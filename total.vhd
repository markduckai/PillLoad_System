LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY total IS
    PORT (
        clr : IN STD_LOGIC; --输入药片总量清零信号
        cnt_init : IN STD_LOGIC; --输入启用计数信号
        clk_divide : IN STD_LOGIC; --输入分频时钟信号
        en_cnt : IN STD_LOGIC; --输入计数使能信号
        ou : OUT STD_LOGIC_VECTOR(20 DOWNTO 0) --3个数码管显示(总药片数量)
    );
END total;

ARCHITECTURE func_f OF total IS
BEGIN

END func_f;