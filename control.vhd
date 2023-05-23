LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY control IS
    PORT (
        clr : IN STD_LOGIC; --�����ź�
        clk_alarm : IN STD_LOGIC; --�����ź�
        judge : IN STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
        en_cnt : OUT STD_LOGIC; --�������ʹ���ź�
        en_green : OUT STD_LOGIC; --�̵���ʾ�ź�
        en_red : OUT STD_LOGIC; --�����ʾ�ź�
        en_alarm : OUT STD_LOGIC--������˸����//����������
    );
END control;

ARCHITECTURE func_co OF control IS
    SIGNAL tmp_cnt, tmp_green, tmp_red, tmp_alarm : STD_LOGIC := '0';
BEGIN
    PROCESS (clr, judge, clk_alarm)
    BEGIN
        IF (clr = '1') THEN --����ʱ��������˿ڲ���
            tmp_cnt <= '1';
            tmp_green <= '1';
            tmp_red <= '0';
            tmp_alarm <= '0';
        ELSIF (judge = '0') THEN --û�����ƿ��ʱʹ����Ч���̵����������
            tmp_cnt <= '1';
            tmp_green <= '1';
            tmp_red <= '0';
            tmp_alarm <= '0';
        ELSE --����ʱʹ����Ч���̵��𣬺����,����
            tmp_cnt <= '0';
            tmp_green <= '0';
            tmp_red <= '1';
            tmp_alarm <= clk_alarm;
        END IF;
    END PROCESS;
    en_cnt <= tmp_cnt;
    en_green <= tmp_green;
    en_red <= tmp_red;
    en_alarm <= tmp_alarm;
END func_co;