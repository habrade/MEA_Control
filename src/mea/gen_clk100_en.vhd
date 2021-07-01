-------------------------------------------------------------------------------
-- Title      : gen_clocks_en
-- Project    : 
-------------------------------------------------------------------------------
-- File       : gen_clocks_en.vhd
-- Author     : sdong  <sdong@sdong-ubuntu>
-- Company    : 
-- Created    : 2021-06-15
-- Last update: 2021-07-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: a module to generate 100KHz clock enable signal
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-06-15  1.0      sdong   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.VComponents.all;

entity gen_clocks is
  generic(
    DAC_FREQ : real := 5.0;
    MEA_FREQ : real := 5.0
    );
  port (
    clk       : in  std_logic;          -- 50MHz input
    rst       : in  std_logic;
    clk100_en : out std_logic;
    clk_dac   : out std_logic;
    clk_mea   : out std_logic;
    locked    : out std_logic
    );
end entity gen_clocks;


architecture behv of gen_clocks is

  signal cnt : integer range 0 to 500 := 0;

  constant CLK_FR_FREQ  : real := 50.0;   -- 50MHz reference
  constant CLK_VCO_FREQ : real := 640.0;  -- VCO freq 640MHz

  signal clkfb                : std_logic;
  signal clk_dac_i, clk_mea_i : std_logic;
  signal clk_dac_b, clk_mea_b : std_logic;


begin  -- architecture behv

  process(all)
  begin
    if ?? rst then
      clk100_en <= '0';
    elsif rising_edge(clk) then
      if cnt = 500 -1 then
        clk100_en <= '1';
        cnt       <= 0;
      else
        clk100_en <= '0';
        cnt       <= cnt + 1;
      end if;
    end if;
  end process;

  mmcm : MMCME2_BASE
    generic map(
      clkin1_period   => 1000.0 / CLK_FR_FREQ,
      clkfbout_mult_f => CLK_VCO_FREQ / CLK_FR_FREQ,
      clkout1_divide  => integer(CLK_VCO_FREQ / DAC_FREQ),
      clkout2_divide  => integer(CLK_VCO_FREQ / MEA_FREQ)
      )
    port map(
      clkin1   => clk,
      clkfbin  => clkfb,
      clkfbout => clkfb,
      clkout1  => clk_dac_i,
      clkout2  => clk_mea_i,
      locked   => locked,
      rst      => '0',
      pwrdwn   => '0'
      );

  bufgdac : BUFG port map(
    i => clk_dac_i,
    o => clk_dac_b
    );

  clk_dac <= clk_dac_b;


  bufgmea : BUFG port map(
    i => clk_mea_i,
    o => clk_mea_b
    );

  clk_mea <= clk_mea_b;


end architecture behv;
