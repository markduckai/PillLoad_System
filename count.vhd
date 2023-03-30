LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY count IS
    PORT (
        clr : IN STD_LOGIC; --�����ź�
        ci : IN STD_LOGIC; --��λ�ź�
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --���װƿ��BCD������
        judge : OUT STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
        ou : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --2��BCD�������ʾ(װƿ��)
    );
END count;

ARCHITECTURE func_count OF count IS
    SIGNAL tmpa : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmpb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tmp_j : STD_LOGIC := '0';
    SIGNAL tmp_o : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    COMPONENT display_BCD IS
        PORT (
            pin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            pout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    PROCESS (clr, ci, pin)
    BEGIN
        IF (clr = '1') THEN--����ʱ��������˿��ź�
            tmpa <= "0000";
            tmpb <= "0000";
            tmp_j <= '0';
        ELSIF (rising_edge(ci)) THEN
            IF (tmp_j = '0') THEN --��û����������ʱ��������
                IF (tmpb = "1001") THEN
                    tmpb <= "0000";
                    tmpa <= tmpa + 1;
                ELSE
                    tmpb <= tmpb + 1;
                END IF;
            END IF;
            IF (tmpa = pin(7 DOWNTO 4) AND tmpb = pin(3 DOWNTO 0)) THEN
                tmp_j <= '1';
            END IF;
        END IF;
    END PROCESS;
    u1 : display_BCD PORT MAP(tmpb, tmp_o(3 DOWNTO 0));
    u2 : display_BCD PORT MAP(tmpa, tmp_o(7 DOWNTO 4));
    judge <= tmp_j;
    ou <= tmp_o;
END func_count;