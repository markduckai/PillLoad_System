LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY PillLoad_System IS
    PORT (
        clk : IN STD_LOGIC; --输入时钟信号
        clr1 : IN STD_LOGIC; --输入单瓶药片清零信号
        clr2 : IN STD_LOGIC; --输入药片总量清零信号
        cnt_init : IN STD_LOGIC; --输入启用计数信号
        pin1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --每瓶药片的BCD码输入
        pin2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --最大装瓶量的BCD码输入
        o1 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0); --每瓶药片数目显示
        o2 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0); --总药片数量显示
        o3 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0); --装瓶数显示
        en_g : OUT STD_LOGIC; --绿灯显示信号
        en_r : OUT STD_LOGIC --红灯显示信号
    );
END PillLoad_System;

ARCHITECTURE func OF PillLoad_System IS
    COMPONENT divide IS --分频器
        PORT (
            cl1 : IN STD_LOGIC;
            clk_divide : OUT STD_LOGIC
        );
    END COMPONENT;
    COMPONENT single_cnt IS --单瓶药片计数器
        PORT (
            cnt_init : IN STD_LOGIC; --输入启用计数信号
            clk_divide : IN STD_LOGIC; -- 输入分频时钟信号
            en_cnt : IN STD_LOGIC; --输入计数使能信号
            pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --每瓶药片的BCD码输入
            clr : IN STD_LOGIC; --单瓶药片清零信号
            ci : OUT STD_LOGIC; --进位信号
            ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2个数码管显示(每瓶药片数目)
        );
    END COMPONENT;
    COMPONENT total IS --药片总量计数器
        PORT (
            clr : IN STD_LOGIC; --输入药片总量清零信号
            cnt_init : IN STD_LOGIC; --输入启用计数信号
            clk_divide : IN STD_LOGIC; --输入分频时钟信号
            en_cnt : IN STD_LOGIC; --输入计数使能信号
            ou : OUT STD_LOGIC_VECTOR(20 DOWNTO 0) --3个数码管显示(总药片数量)
        );
    END COMPONENT;
    COMPONENT control IS
        PORT (
            judge : IN STD_LOGIC; --判断装瓶量是否超过最大瓶数
            en_cnt : OUT STD_LOGIC; --输出计数使能信号
            en_green : OUT STD_LOGIC; --绿灯显示信号
            en_red : OUT STD_LOGIC --红灯显示信号
            --方波闪烁报警
        );
    END COMPONENT;
    COMPONENT count IS --装瓶量计数器
        PORT (
            ci : IN STD_LOGIC; --进位信号
            pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --最大装瓶量BCD码输入
            judge : OUT STD_LOGIC; --判断装瓶量是否超过最大瓶数
            ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2个数码管显示(装瓶数)
        );
    END COMPONENT;
    SIGNAL clk_divide, ci, judge : STD_LOGIC := '0';
    SIGNAL en_cnt : STD_LOGIC := '1';
    SIGNAL en_green, en_red : STD_LOGIC := '0';
    SIGNAL out1 : STD_LOGIC_VECTOR(13 DOWNTO 0) := (OTHERS => '0');
    SIGNAL out2 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (OTHERS => '0');
    SIGNAL out3 : STD_LOGIC_VECTOR(13 DOWNTO 0) := (OTHERS => '0');
BEGIN
    u1 : divide PORT MAP(clk, clk_divide);
    u2 : single_cnt PORT MAP(cnt_init, clk_divide, en_cnt, pin1, clr1, ci, out1);
    u3 : total PORT MAP(clr2, cnt_init, clk_divide, en_cnt, out2);
    u4 : control PORT MAP(judge, en_cnt, en_green, en_red);
    u5 : count PORT MAP(ci, pin2, judge, out3);
    en_g <= en_green;
    en_r <= en_red;
    o1 <= out1;
    o2 <= out2;
    o3 <= out3;
END func;