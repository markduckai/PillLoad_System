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
        ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2���������ʾ(ÿƿҩƬ��Ŀ)
    );
END single_cnt;

ARCHITECTURE func_s OF single_cnt IS
BEGIN

END func_s;