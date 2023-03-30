LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY single_cnt IS
    PORT (
        cnt_init : IN STD_LOGIC; --输入启用计数信号
        clk_divide : IN STD_LOGIC; -- 输入分频时钟信号
        en_cnt : IN STD_LOGIC; --输入计数使能信号
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --每瓶药片的BCD码输入
        clr : IN STD_LOGIC; --单瓶药片清零信号
        ci : OUT STD_LOGIC; --进位信号
        ou : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --2个BCD数码管显示(每瓶药片数目) 
    );
END single_cnt;

ARCHITECTURE func_s OF single_cnt IS
    SIGNAL tmpa : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmpb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmpo : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    COMPONENT display_BCD IS
        PORT (
            pin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            pout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    PROCESS (clr, cnt_init, clk_divide, en_cnt, pin)
    BEGIN
        IF (clr = '1') THEN--清零信号
            tmpa <= "0000";
            tmpb <= "0000";
            ci <= '0';
        ELSIF (rising_edge(clk_divide)) THEN
            IF (cnt_init = '1' AND en_cnt = '1') THEN --计数使能
                IF ((tmpa + 1 = pin(7 DOWNTO 4) AND tmpb = "1001" AND "0000" = pin(3 DOWNTO 0)) OR (tmpa = pin(7 DOWNTO 4) AND tmpb + 1 = pin(3 DOWNTO 0))) THEN
                    tmpa <= "0000";
                    tmpb <= "0000";
                    ci <= '1';
                ELSIF (tmpb = "1001") THEN
                    tmpb <= "0000";
                    tmpa <= tmpa + 1;
                    ci <= '0';
                ELSE
                    tmpb <= tmpb + 1;
                    ci <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u1 : display_BCD PORT MAP(tmpa, tmpo(7 DOWNTO 4));
    u2 : display_BCD PORT MAP(tmpb, tmpo(3 DOWNTO 0));
    ou <= tmpo;
END func_s;