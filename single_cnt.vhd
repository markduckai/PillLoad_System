LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY single_cnt IS
    PORT (
        cnt_init : IN STD_LOGIC; --输入启用计数信号
        clk_divide : IN STD_LOGIC; -- 输入分频时钟信号
        en_cnt : IN STD_LOGIC; --输入计数使能信号
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --每瓶药片的BCD码输入
        clr : IN STD_LOGIC; --单瓶药片清零信号
        ci : OUT STD_LOGIC; --进位信号
        ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2个数码管显示(每瓶药片数目)
    );
END single_cnt;

ARCHITECTURE func_s OF single_cnt IS
BEGIN

END func_s;