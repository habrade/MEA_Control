----------------------------------------------------------------------------------
-- Company: 
-- Engineer: s.dong@mails.ccnu.edu.cn
-- 
-- Create Date: 07/09/2020 10:36:26 PM
-- Design Name: 
-- Module Name: ipbus_mea_dev - behv
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.ipbus.all;
--use work.ipbus_reg.all;
use work.ipbus_reg_types.all;
use work.drp_decl.all;

entity ipbus_mea_device is
  generic(
    N_DRP : integer := 1
    );
  port (
    ipb_clk : in  std_logic;
    ipb_rst : in  std_logic;
    ipb_in  : in  ipb_wbus;
    ipb_out : out ipb_rbus;

    clk : in std_logic;
    rst : in std_logic;

    -- Control Port
    mea_start_scan  : out std_logic;
    mea_reset_scan  : out std_logic;
    sel_mea_clk     : out std_logic;
    mea_clk_div_cnt : out integer := 2;

    -- MMCM DRP Ports
    locked   : in  std_logic_vector(N_DRP-1 downto 0);
    rst_mmcm : out std_logic_vector(N_DRP-1 downto 0);
    drp_out  : out drp_wbus_array(N_DRP-1 downto 0);
    drp_in   : in  drp_rbus_array(N_DRP-1 downto 0)
    );
end ipbus_mea_device;

architecture behv of ipbus_mea_device is

  --Temporary registers
  signal rst_mmcm_tmp : std_logic_vector(N_DRP-1 downto 0);

  signal mea_start_scan_tmp  : std_logic;
  signal mea_reset_scan_tmp  : std_logic;
  signal sel_mea_clk_tmp     : std_logic;
  signal mea_clk_div_cnt_tmp : std_logic_vector(31 downto 0);

  -- IPbus reg
  constant SYNC_REG_ENA               : boolean := false;
  constant N_STAT                     : integer := 1;
  constant N_CTRL                     : integer := 3;
  signal stat                         : ipb_reg_v(N_STAT-1 downto 0);
  signal ctrl                         : ipb_reg_v(N_CTRL-1 downto 0);
  signal ctrl_reg_stb, ctrl_reg_stb_r : std_logic_vector(N_CTRL-1 downto 0);
  signal stat_reg_stb                 : std_logic_vector(N_STAT-1 downto 0);

  -- IPbus drp
  signal drp_rst     : std_logic_vector(N_DRP-1 downto 0);
  signal drp_rst_tmp : std_logic_vector(N_DRP-1 downto 0);
  
    --Debug
  attribute mark_debug                           : string;
  attribute mark_debug of mea_clk_div_cnt_tmp    : signal is "true";


begin

  inst_ipbus_slave_reg_drp : entity work.ipbus_slave_reg_drp
    generic map(
      SYNC_REG_ENA => SYNC_REG_ENA,
      N_STAT       => N_STAT,
      N_CTRL       => N_CTRL,
      N_DRP        => N_DRP
      )
    port map(

      ipb_clk => ipb_clk,
      ipb_rst => ipb_rst,
      ipb_in  => ipb_in,
      ipb_out => ipb_out,

      clk => clk,
      rst => rst,

      -- control/state registers
      ctrl         => ctrl,
      ctrl_reg_stb => ctrl_reg_stb,
      stat         => stat,
      stat_reg_stb => open,
      -- MMCM DRP Ports
      drp_rst      => drp_rst,
      drp_in       => drp_in,
      drp_out      => drp_out

      );

  -- control
  process(clk)
  begin
    if rising_edge(clk) then
      -- MEA IO
      mea_start_scan_tmp <= ctrl(0)(0);
      mea_reset_scan_tmp <= ctrl(0)(1);
      sel_mea_clk_tmp    <= ctrl(0)(2);

      -- DRP
      rst_mmcm_tmp(0) <= ctrl(1)(0);
      drp_rst_tmp(0)  <= ctrl(1)(1);

      -- MEA clock counters
      mea_clk_div_cnt_tmp <= ctrl(2);

      ctrl_reg_stb_r <= ctrl_reg_stb;
    end if;
  end process;


  sync_ctrl_signals : process(clk)
  begin
    if rising_edge(clk) then
      if ctrl_reg_stb_r(0) = '1' then
        mea_start_scan <= mea_start_scan_tmp;
        mea_reset_scan <= mea_reset_scan_tmp;
        sel_mea_clk    <= sel_mea_clk_tmp;
      else
        mea_start_scan <= '0';
        mea_reset_scan <= '0';
      end if;

      if ctrl_reg_stb_r(1) = '1' then
        rst_mmcm <= rst_mmcm_tmp;
        drp_rst  <= drp_rst_tmp;
      else
        rst_mmcm <= (others => '0');
        drp_rst  <= (others => '0');
      end if;

      if ctrl_reg_stb_r(2) = '1' then
        mea_clk_div_cnt <= to_integer(unsigned(mea_clk_div_cnt_tmp));
      end if;

    end if;
  end process;

  -- status
  process(clk)
  begin
    if rising_edge(clk) then
      stat(0)(0) <= locked(0);
    end if;
  end process;


end behv;
