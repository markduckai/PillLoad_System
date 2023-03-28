LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY single_cnt IS
    PORT (
        cnt_init : IN STD_LOGIC; --�������ü����ź�
        clk_divide : IN STD_LOGIC; -- �����Ƶʱ���ź�
        en_cnt : IN STD_LOGIC; --�������ʹ���ź�
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --ÿƿҩƬ��BCD������
        clr : IN STD_LOGIC; --��ƿҩƬ�����ź�
        ci : OUT STD_LOGIC; --��λ�ź�
        ou : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --2��BCD�������ʾ(ÿƿҩƬ��Ŀ) 
    );
END single_cnt;

ARCHITECTURE func_s OF single_cnt IS
    SIGNAL tmpa : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmpb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmpo : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmp_ci : STD_LOGIC := '0';
    COMPONENT display_BCD IS
        PORT (
            pin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            pout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    PROCESS (cnt_init, clk_divide, en_cnt, pin, clr)
    BEGIN
        IF (clr = '1') THEN --�첽�����ź�
            tmpa <= "0000";
            tmpb <= "0000";
        ELSIF (rising_edge(clk_divide)) THEN
            IF (cnt_init = '1' AND en_cnt = '1') THEN --����ʹ��
                IF (tmpb = "1001") THEN
                    tmpb <= "0000";
                    tmpa <= tmpa + 1;
                ELSE
                    tmpb <= tmpb + 1;
                END IF;
                IF (tmpa = pin(7 DOWNTO 4) AND tmpb = pin(3 DOWNTO 0)) THEN
                    tmpa <= "0000";
                    tmpb <= "0001";
                    tmp_ci <= '1';
                ELSE
                    tmp_ci <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u1 : display_BCD PORT MAP(tmpa, tmpo(7 DOWNTO 4));
    u2 : display_BCD PORT MAP(tmpb, tmpo(3 DOWNTO 0));
    ou <= tmpo;
    ci <= tmp_ci;
END func_s;