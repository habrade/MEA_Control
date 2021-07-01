-------------------------------------------------------------------------------
-- Title      : gen_clk100_en
-- Project    : 
-------------------------------------------------------------------------------
-- File       : gen_clk100_en.vhd
-- Author     : sdong  <sdong@sdong-ubuntu>
-- Company    : 
-- Created    : 2021-06-15
-- Last update: 2021-06-15
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

entity gen_clk100 is
  port (
    clk       : in  std_logic;
    rst       : in  std_logic;
    clk100_en : out std_logic
    );
end entity gen_clk100;


architecture behv of gen_clk100 is

  signal cnt : integer range 0 to 50 := 0;

begin  -- architecture behv

  process(all)
  begin
    if ?? rst then
      clk100_en <= '0';
    elsif rising_edge(clk) then
      if cnt = 50 then
        clk100_en <= '1';
        cnt       <= 0;
      else
        clk100_en <= '0';
        cnt       <= cnt + 1;
      end if;
    end if;
  end process;

end architecture behv;
