LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY control IS
    PORT (
        judge : IN STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
        en_cnt : OUT STD_LOGIC; --�������ʹ���ź�
        en_green : OUT STD_LOGIC; --�̵���ʾ�ź�
        en_red : OUT STD_LOGIC; --�����ʾ�ź�
        --������˸����
    );
END control;

ARCHITECTURE func_co OF control IS
BEGIN

END func_co;