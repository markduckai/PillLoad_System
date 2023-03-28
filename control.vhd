LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY control IS
    PORT (
        judge : IN STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
        en_cnt : OUT STD_LOGIC; --�������ʹ���ź�
        en_green : OUT STD_LOGIC; --�̵���ʾ�ź�
        en_red : OUT STD_LOGIC --�����ʾ�ź�
        --������˸����
    );
END control;

ARCHITECTURE func_co OF control IS
    SIGNAL tmp_cnt, tmp_green, tmp_red : STD_LOGIC := '0';
BEGIN
    PROCESS (judge)
    BEGIN
        IF (judge = '0') THEN --û�������ƿ��ʱʹ����Ч���̵����������
            tmp_cnt <= '1';
            tmp_green <= '1';
            tmp_red <= '0';
        ELSE --����ʱʹ����Ч���̵��𣬺����
            tmp_cnt <= '0';
            tmp_green <= '0';
            tmp_red <= '1';
        END IF;
    END PROCESS;
    en_cnt <= tmp_cnt;
    en_green <= tmp_green;
    en_red <= tmp_red;
END func_co;