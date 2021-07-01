-------------------------------------------------------------------------------
-- Title      : tb_mea_scan
-- Project    : 
-------------------------------------------------------------------------------
-- File       : sim_scan.vhd
-- Author     : sdong  <s.dong@mails.ccnu.edu.cn>
-- Company    : 
-- Created    : 2021-07-01
-- Last update: 2021-07-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-07-01  1.0      sdong   Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity tb_mea_scan is
end entity;


architecture behv of tb_mea_scan is

  signal clk        : std_logic;
  signal rst        : std_logic;
  signal start_scan : std_logic;
  signal reset_scan : std_logic;

  signal speak   : std_logic;
  signal start   : std_logic;
  signal rst_out : std_logic;

  constant CLK_PERIOD : time := 5 ns;

begin

  gen_clk : process
  begin
    clk <= '1';
    wait for CLK_PERIOD/2;
    clk <= '0';
    wait for CLK_PERIOD/2;
  end process;

  gen_rst : process
  begin
    rst <= '0';
    wait for 11 ns;
    rst <= '1';
    wait for 13 ns;
    rst <= '0';
    wait;
  end process;

  main_process : process
  begin
    start_scan <= '0';
    reset_scan <= '0';
    wait for 101 ns;
    reset_scan <= '1';
    wait for 20 ns;
    reset_scan <= '0';
    wait for 10 ns;
    start_scan <= '1';
    wait for 10 ns;
    start_scan <= '0';
    wait for 500 ns;
    reset_scan <= '1';
    wait for 20 ns;
    reset_scan <= '0';
    wait for 46 ns;
    start_scan <= '1';
    wait for 10 ns;
    start_scan <= '0';
    wait for 500 ns;
    std.env.stop;
  end process;

  mea_scan : entity work.mea_scan
    port map(
      clk        => clk,
      rst        => rst,
      start_scan => start_scan,
      reset_scan => reset_scan,
      speak      => speak,
      start      => start,
      rst_out    => rst_out
      );

end architecture behv;

