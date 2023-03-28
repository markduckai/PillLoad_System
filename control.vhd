LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY control IS
    PORT (
        judge : IN STD_LOGIC; --判断装瓶量是否超过最大瓶数
        en_cnt : OUT STD_LOGIC; --输出计数使能信号
        en_green : OUT STD_LOGIC; --绿灯显示信号
        en_red : OUT STD_LOGIC --红灯显示信号
        --方波闪烁报警
    );
END control;

ARCHITECTURE func_co OF control IS
    SIGNAL tmp_cnt, tmp_green, tmp_red : STD_LOGIC := '0';
BEGIN
    PROCESS (judge)
    BEGIN
        IF (judge = '0') THEN --没超过最大瓶数时使能有效，绿灯亮，红灯灭
            tmp_cnt <= '1';
            tmp_green <= '1';
            tmp_red <= '0';
        ELSE --超过时使能无效，绿灯灭，红灯亮
            tmp_cnt <= '0';
            tmp_green <= '0';
            tmp_red <= '1';
        END IF;
    END PROCESS;
    en_cnt <= tmp_cnt;
    en_green <= tmp_green;
    en_red <= tmp_red;
END func_co;