library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity mea_scan is
  port (
    clk : in std_logic;  -- The mea clock is generated by one MMMC, and the frequency is controlled by the software.
    rst : in std_logic;

    start_scan : in  std_logic;         -- Start signal from software
    -- The io ports of the ASIC
    speak      : out std_logic;
    start      : out std_logic;
    rst_out    : out std_logic
    );
end mea_scan;

architecture behv of mea_scan is
  -- declarative_items (signal declarations, component declarations, etc.)  
  type SCAN_STATE is (IDLE, RESET_CHIP, ASS_START, ASS_SPEAK);
  signal state_reg, state_next : SCAN_STATE;

  signal rst_cnt : integer range 0 to 3;

begin
  -- architecture body

  process(clk, rst)
  begin
    if rst = '1' then
      state_reg <= IDLE;
    elsif rising_edge(clk) then
      state_reg <= state_next;
    end if;
  end process;

  process(all)
  begin
    state_next <= state_reg;
    case state_reg is
      when IDLE =>
        if ?? start_scan then
          state_next <= RESET_CHIP;
        end if;
      when RESET_CHIP =>
        if rst_cnt = 3 then
          state_next <= ASS_START;
        end if;
      when ASS_START =>
        state_next <= ASS_SPEAK;
      when ASS_SPEAK =>
        null;
      when others =>
        state_next <= IDLE;
    end case;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
      case(state_next) is
        when IDLE =>
          speak   <= '0';
          start   <= '0';
          rst_out <= '0';
        when RESET_CHIP =>
          rst_out <= '1';
          rst_cnt <= rst_cnt + 1;
        when ASS_START =>
          rst_out <= '0';
          start   <= '1';
          rst_cnt <= 0;
        when ASS_SPEAK =>
          start <= '0';
          speak <= '1';
        when others => null;
      end case;
    end if;
  end process;

end behv;
