-------------------------------------------------------------------------------
-- Title      : mea_clk_div
-- Project    : 
-------------------------------------------------------------------------------
-- File       : mea_clk_div.vhd
-- Author     : sdong  <sdong@mails.ccnu.edu.cn>
-- Company    : 
-- Created    : 2021-07-09
-- Last update: 2021-07-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-07-09  1.0      sdong   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mea_clk_div is
  port(
    clk_mea     : in  std_logic;
    rst         : in  std_logic;
    clk_cnt     : in  integer;
    clk_mea_div : out std_logic
    );
end entity mea_clk_div;

architecture behv of mea_clk_div is

  signal cnt : integer := 0;

begin

  process (all)
  begin
    if rising_edge(clk_mea) then
      if ?? rst then
        cnt         <= 0;
        clk_mea_div <= '0';
      elsif cnt = clk_cnt then
        cnt         <= 0;
        clk_mea_div <= not clk_mea_div;
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;

end architecture;
