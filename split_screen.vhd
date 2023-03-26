library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity split_screen is
    Port (clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          split_screen_out:buffer STD_LOGIC);
end split_screen;

architecture Behavioral of split_screen is
    signal counter : unsigned(27 downto 0) := (others => '0');
    signal divider : unsigned(27 downto 0) := to_unsigned(11999999,28);

begin

    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            split_screen_out <= '0';
        elsif rising_edge(clk) then
            if counter >= divider then
                counter <= (others => '0');
                split_screen_out <= not split_screen_out;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

end Behavioral;
