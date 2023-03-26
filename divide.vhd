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
    SIGNAL counter : INTEGER RANGE 0 TO 99999 := 0;
    SIGNAL div : INTEGER := 1000;
    SIGNAL clk_tmp : STD_LOGIC;
BEGIN
    PROCESS (cl1)
    BEGIN
        IF rising_edge(cl1) THEN
            counter <= counter + 1;
            IF counter = div THEN
                counter <= 0;
                clk_tmp <= NOT clk_tmp;
            END IF;
        END IF;
    END PROCESS;
    clk_divide <= clk_tmp;
END fuc_d;