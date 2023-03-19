LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY control IS
    PORT (
        judge : IN STD_LOGIC; --判断装瓶量是否超过最大瓶数
        en_cnt : OUT STD_LOGIC; --输出计数使能信号
        en_green : OUT STD_LOGIC; --绿灯显示信号
        en_red : OUT STD_LOGIC; --红灯显示信号
        --方波闪烁报警
    );
END control;

ARCHITECTURE func_co OF control IS
BEGIN

END func_co;