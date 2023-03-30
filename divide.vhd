LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY divide IS
    PORT (
        clk : IN STD_LOGIC;
        clk_divide : OUT STD_LOGIC
    );
END divide;

ARCHITECTURE fuc_d OF divide IS
    SIGNAL counter : INTEGER RANGE 0 TO 99999 := 0;
    SIGNAL div : INTEGER := 10000;
    SIGNAL clk_tmp : STD_LOGIC;
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF counter = div THEN
                counter <= 0;
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS;
    PROCESS (clk, counter)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            IF (counter > 5000) THEN
                clk_tmp <= '1'; --1Hz·½²¨
            ELSE
                clk_tmp <= '0';
            END IF;
        END IF;
    END PROCESS;

    clk_divide <= clk_tmp;
END fuc_d;