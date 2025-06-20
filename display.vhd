LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY display IS
    PORT (
        pin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        pout : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END display;

ARCHITECTURE func OF display IS
BEGIN
    PROCESS (pin)
    BEGIN
        CASE pin IS
            WHEN "0000" => pout <= "0111111";
            WHEN "0001" => pout <= "0000110";
            WHEN "0010" => pout <= "1011011";
            WHEN "0011" => pout <= "1001111";
            WHEN "0100" => pout <= "1100110";
            WHEN "0101" => pout <= "1101101";
            WHEN "0110" => pout <= "1111101";
            WHEN "0111" => pout <= "0000111";
            WHEN "1000" => pout <= "1111111";
            WHEN "1001" => pout <= "1101111";
            WHEN OTHERS => pout <= "0000000";
        END CASE;
    END PROCESS;
END func;