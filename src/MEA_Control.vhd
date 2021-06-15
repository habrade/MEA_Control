library IEEE;
use IEEE.STD_LOGIC_1164.all;

library UNISIM;
use UNISIM.vcomponents.all;

use work.ipbus.all;
use work.drp_decl.all;

entity MEA_Control is port(
  sysclk_p     : in  std_logic;
  sysclk_n     : in  std_logic;
  rst          : in  std_logic;
  leds         : out std_logic_vector(3 downto 0);  -- status LEDs
--              dip_sw: in std_logic_vector(3 downto 0); -- switches
  gmii_gtx_clk : out std_logic;
  gmii_tx_en   : out std_logic;
  gmii_tx_er   : out std_logic;
  gmii_txd     : out std_logic_vector(7 downto 0);
  gmii_rx_clk  : in  std_logic;
  gmii_rx_dv   : in  std_logic;
  gmii_rx_er   : in  std_logic;
  gmii_rxd     : in  std_logic_vector(7 downto 0);
  phy_rst      : out std_logic;

  -- DAC8568
  DAC_SCLK   : out std_logic;
  DAC_DIN    : out std_logic;
  DAC_SYNC_N : out std_logic;

  -- MEA    
  SRAM_WE_FPGA : out std_logic;
  SRAM_D1_FPGA : out std_logic;
  SRAM_D2_FPGA : out std_logic;

  -- mea scan ports
  mea_mark  : in  std_logic;
  mea_start : out std_logic;
  mea_speak : out std_logic;
  mea_clk   : out std_logic;
  mea_reset : out std_logic
  );
end MEA_Control;

architecture rtl of MEA_Control is

  -- IPbus
  signal clk_ipb, rst_ipb, clk_125M, clk_aux, rst_aux, nuke, soft_rst, phy_rst_e, userled : std_logic;
  signal mac_addr                                                                         : std_logic_vector(47 downto 0);
  signal ip_addr                                                                          : std_logic_vector(31 downto 0);
  signal ipb_out                                                                          : ipb_wbus;
  signal ipb_in                                                                           : ipb_rbus;

  -- DAC8568
  signal dac8568_busy                                                   : std_logic;
  signal dac8568_start, dac8568_rst, dac8568_rst_n                      : std_logic;
  signal dac8568_sel_ch                                                 : std_logic_vector(7 downto 0);
  signal dac8568_data_a, dac8568_data_b, dac8568_data_c, dac8568_data_d : std_logic_vector(15 downto 0);
  signal dac8568_data_e, dac8568_data_f, dac8568_data_g, dac8568_data_h : std_logic_vector(15 downto 0);

  -- MEA
  signal mea_start_scan : std_logic;
  signal clk100_en      : std_logic;

  -- MEA MMCM DRP
  constant N_DRP           : integer := 1;
  signal rst_mmcm          : std_logic_vector(N_DRP-1 downto 0);
  signal drp_m2s           : drp_wbus_array(N_DRP-1 downto 0);
  signal drp_s2m           : drp_rbus_array(N_DRP-1 downto 0);
  signal clk_mea_o         : std_logic;
  signal mea_clocks_locked : std_logic_vector(N_DRP-1 downto 0);


  -- FREQ Counter
  constant N_CLK     : integer := 1;
  signal clk_mea_div : std_logic_vector(N_CLK -1 downto 0);

  constant CLK_AUX_FREQ : real := 50.0;

  attribute mark_debug                      : string;
  attribute mark_debug of clk_mea_o         : signal is "true";
  attribute mark_debug of clk_mea_div       : signal is "true";
  attribute mark_debug of mea_clocks_locked : signal is "true";

begin

-- Infrastructure

  ipbus_infra : entity work.ipbus_gmii_infra
    generic map(
      CLK_AUX_FREQ => CLK_AUX_FREQ
      )
    port map(
      sysclk_p     => sysclk_p,
      sysclk_n     => sysclk_n,
      clk_ipb_o    => clk_ipb,
      rst_ipb_o    => rst_ipb,
      clk_125_o    => clk_125M,
      rst_125_o    => phy_rst_e,
      clk_aux_o    => clk_aux,
      rst_aux_o    => rst_aux,
      nuke         => nuke,
      soft_rst     => soft_rst,
      leds         => leds(1 downto 0),
      gmii_gtx_clk => gmii_gtx_clk,
      gmii_txd     => gmii_txd,
      gmii_tx_en   => gmii_tx_en,
      gmii_tx_er   => gmii_tx_er,
      gmii_rx_clk  => gmii_rx_clk,
      gmii_rxd     => gmii_rxd,
      gmii_rx_dv   => gmii_rx_dv,
      gmii_rx_er   => gmii_rx_er,
      mac_addr     => mac_addr,
      ip_addr      => ip_addr,
      ipb_in       => ipb_in,
      ipb_out      => ipb_out
      );

  leds(2) <= mea_mark;
  leds(3) <= mea_clocks_locked(0);
  phy_rst <= not phy_rst_e;

--      mac_addr <= X"020ddba1151" & dip_sw; -- Careful here, arbitrary addresses do not always work
--      ip_addr <= X"c0a8c81" & dip_sw; -- 192.168.200.16+n
  mac_addr <= X"020ddba1151" & "0000";  -- Careful here, arbitrary addresses do not always work
  ip_addr  <= X"c0a8021" & "0000";      -- 192.168.2.16+n

-- ipbus slaves live in the entity below, and can expose top-level ports
-- The ipbus fabric is instantiated within.

  ipbus_payload : entity work.ipbus_payload
    generic map(
      N_DRP => N_DRP,
      N_CLK => N_CLK
      )
    port map(
      ipb_clk => clk_ipb,
      ipb_rst => rst_ipb,
      ipb_in  => ipb_out,
      ipb_out => ipb_in,

      -- Slave clocks
      clk            => clk_aux,
      rst            => rst_aux,
      -- Global
      nuke           => nuke,
      soft_rst       => soft_rst,
      -- DAC8568
      dac8568_busy   => dac8568_busy,
      dac8568_rst    => dac8568_rst,
      dac8568_start  => dac8568_start,
      dac8568_sel_ch => dac8568_sel_ch,
      dac8568_data_a => dac8568_data_a,
      dac8568_data_b => dac8568_data_b,
      dac8568_data_c => dac8568_data_c,
      dac8568_data_d => dac8568_data_d,
      dac8568_data_e => dac8568_data_e,
      dac8568_data_f => dac8568_data_f,
      dac8568_data_g => dac8568_data_g,
      dac8568_data_h => dac8568_data_h,
      --MEA
      mea_start_scan => mea_start_scan,
      -- MMCM DRP Ports
      locked         => mea_clocks_locked,
      rst_mmcm       => rst_mmcm,
      drp_out        => drp_m2s,
      drp_in         => drp_s2m,
      -- FREQ CTR
      clk_ctr_in     => clk_mea_div
      );

  gen_clk100 : entity work.gen_clk100
    port map(
      clk       => clk_aux,
      rst       => rst_aux,
      clk100_en => clk100_en
      );



  pixel_mea : entity work.Pixel_MEA
    port map(
      clk       => clk_aux,
      rst       => rst_aux,
      clk100_en => clk100_en,
      SRAM_WE   => SRAM_WE_FPGA,
      SRAM_D1   => SRAM_D1_FPGA,
      SRAM_D2   => SRAM_D2_FPGA
      );

  mea_scan : entity work.mea_scan
    port map(
      clk        => clk_aux,
      rst        => rst_aux,
      start_scan => mea_start_scan,
      speak      => mea_speak,
      start      => mea_start,
      rst_out    => mea_reset
      );

  dac8568_rst_n <= not dac8568_rst;
  dac8568 : entity work.dac_inter8568
    port map(
      clk       => clk_aux,
      reset     => dac8568_rst,
      busy_8568 => dac8568_busy,
      start     => dac8568_start,
      ch        => dac8568_sel_ch,
      dataa     => dac8568_data_a,
      datab     => dac8568_data_b,
      datac     => dac8568_data_c,
      datad     => dac8568_data_d,
      datae     => dac8568_data_e,
      dataf     => dac8568_data_f,
      datag     => dac8568_data_g,
      datah     => dac8568_data_h,

      din  => DAC_DIN,
      sclk => DAC_SCLK,
      syn  => DAC_SYNC_N
      );

  mea_clocks : entity work.mea_clocks
    generic map(
      N_DRP => N_DRP
      )
    port map(
      rst      => rst_ipb,
      clk      => clk_ipb,
      clk_MEA  => clk_mea_o,
      -- MMCM DRP Ports
      locked   => mea_clocks_locked,
      rst_mmcm => rst_mmcm,
      drp_out  => drp_s2m,
      drp_in   => drp_m2s
      );

  mea_clk <= clk_mea_o;

  freq_div : entity work.freq_ctr_div
    generic map(
      N_CLK => N_CLK
      )
    port map(
      clk(0) => clk_mea_o,
      clkdiv => clk_mea_div
      );

end rtl;
