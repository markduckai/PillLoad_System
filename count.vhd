LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY count IS
    PORT (
        ci : IN STD_LOGIC; --��λ�ź�
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --���װƿ��BCD������
        judge : OUT STD_LOGIC : --�ж�װƿ���Ƿ񳬹����ƿ��
        ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2���������ʾ(װƿ��)
    );
END count;

ARCHITECTURE func_count OF count IS
BEGIN

END func_count;