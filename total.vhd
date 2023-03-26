LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY total IS
    PORT (
        clr : IN STD_LOGIC; --����ҩƬ���������ź�
        cnt_init : IN STD_LOGIC; --�������ü����ź�
        clk_divide : IN STD_LOGIC; --�����Ƶʱ���ź�
        en_cnt : IN STD_LOGIC; --�������ʹ���ź�
        ou : OUT STD_LOGIC_VECTOR(20 DOWNTO 0) --3���������ʾ(��ҩƬ����)
    );
END total;

ARCHITECTURE func_f OF total IS
    SIGNAL tmp1 : STD_LOGIC_VECTOR(3 DOWNTO 0); --��λ
    SIGNAL tmp2 : STD_LOGIC_VECTOR(3 DOWNTO 0); --ʮλ
    SIGNAL tmp3 : STD_LOGIC_VECTOR(3 DOWNTO 0); --��λ
    COMPONENT display IS
        PORT (
            pin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            pout : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    PROCESS (clr, cnt_init, clk_divide, en_cnt)
    BEGIN
        IF (clr = '0') THEN
            tmp1 <= "0000";
            tmp2 <= "0000";
            tmp3 <= "0000";
        ELSIF (en_cnt = '1' AND cnt_init = '1') THEN
            IF (clk_divide'event AND clk_divide = '1') THEN
                tmp3 <= tmp3 + 1;
                IF (tmp3 = "1010") THEN
                    tmp3 <= "0000";
                    tmp2 <= tmp2 + 1;
                END IF;
                IF (tmp2 = "1010") THEN
                    tmp2 <= "0000";
                    tmp1 <= tmp1 + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u1 : display PORT MAP(tmp1, ou(20 DOWNTO 14));
    u2 : display PORT MAP(tmp2, ou(13 DOWNTO 7));
    u3 : display PORT MAP(tmp3, ou(6 DOWNTO 0));
END func_f;