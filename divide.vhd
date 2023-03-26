LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY divide IS
    PORT (
        cl1 : IN STD_LOGIC;
        clk_divide : OUT STD_LOGIC
    );
END divide;

ARCHITECTURE fuc_d OF divide IS
    signal counter : integer range 0 to 99999 := 0;
    signal div : integer := 1000;
BEGIN
process(cl1)
    begin
        if rising_edge(cl1) then
            counter <= counter + 1;
            if counter = div then
                counter <= 0;
                clk_divide <= not clk_divide;
            end if;
        end if;
    end process;
END fuc_d;
