LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY count IS
    PORT (
        ci : IN STD_LOGIC; --进位信号
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --最大装瓶量BCD码输入
        judge : OUT STD_LOGIC; --判断装瓶量是否超过最大瓶数
        ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2个数码管显示(装瓶数)
    );
END count;

ARCHITECTURE func_count OF count IS
    SIGNAL tmpa : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmpb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmp_j : STD_LOGIC := '0';
    SIGNAL tmp_o : STD_LOGIC_VECTOR(13 DOWNTO 0) := (OTHERS => '0');
    COMPONENT display IS
        PORT (
            pin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            pout : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    PROCESS (ci, pin)
    BEGIN
        IF (rising_edge(ci)) THEN
            IF (tmp_j = '0') THEN
                IF (tmpb = "1001") THEN
                    tmpb <= "0000";
                    tmpa <= tmpa + 1;
                ELSE
                    tmpb <= tmpb + 1;
                END IF;
                IF (tmpa = pin(7 DOWNTO 4) AND tmpb = pin(3 DOWNTO 0)) THEN
                    tmp_j <= '1';
                END IF;
            END IF;
        END IF;
    END PROCESS;
    judge <= tmp_j;
    u1 : display PORT MAP(tmpb, tmp_o(6 DOWNTO 0));
    u2 : display PORT MAP(tmpa, tmp_o(13 DOWNTO 7));
    ou <= tmp_o;
END func_count;