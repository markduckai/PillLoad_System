LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY count IS
    PORT (
        ci : IN STD_LOGIC; --��λ�ź�
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --���װƿ��BCD������
        judge : OUT STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
        ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2���������ʾ(װƿ��)
    );
END count;

ARCHITECTURE func_count OF count IS
    SIGNAL tmp : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL tmp_j : STD_LOGIC;
    SIGNAL tmp_o : STD_LOGIC_VECTOR(13 DOWNTO 0);
    COMPONENT display IS
        PORT (
            pin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            pout : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    PROCESS (ci, pin)
    BEGIN
        IF (ci = '1') THEN
            IF (tmp = pin) THEN
                tmp <= "00000000";
                tmp_j <= '1';
            ELSE
                tmp <= tmp + 1;
                tmp_j <= '0';
            END IF;
        END IF;
    END PROCESS;
    judge <= tmp_j;
    u1 : display PORT MAP(tmp(3 DOWNTO 0), tmp_o(6 DOWNTO 0));
    u2 : display PORT MAP(tmp(7 DOWNTO 4), tmp_o(13 DOWNTO 7));
    ou <= tmp_o;
END func_count;