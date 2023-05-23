LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY control IS
    PORT (
        clr : IN STD_LOGIC; --清零信号
        clk_alarm : IN STD_LOGIC; --报警信号
        judge : IN STD_LOGIC; --判断装瓶量是否超过最大瓶数
        en_cnt : OUT STD_LOGIC; --输出计数使能信号
        en_green : OUT STD_LOGIC; --绿灯显示信号
        en_red : OUT STD_LOGIC; --红灯显示信号
        en_alarm : OUT STD_LOGIC--方波闪烁报警//扬声器报警
    );
END control;

ARCHITECTURE func_co OF control IS
    SIGNAL tmp_cnt, tmp_green, tmp_red, tmp_alarm : STD_LOGIC := '0';
BEGIN
    PROCESS (clr, judge, clk_alarm)
    BEGIN
        IF (clr = '1') THEN --清零时重置输出端口参数
            tmp_cnt <= '1';
            tmp_green <= '1';
            tmp_red <= '0';
            tmp_alarm <= '0';
        ELSIF (judge = '0') THEN --没到最大瓶数时使能有效，绿灯亮，红灯灭
            tmp_cnt <= '1';
            tmp_green <= '1';
            tmp_red <= '0';
            tmp_alarm <= '0';
        ELSE --超过时使能无效，绿灯灭，红灯亮,报警
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