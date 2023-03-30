LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY PillLoad_System IS
    PORT (
        clk : IN STD_LOGIC; --输入时钟信号
        clr : IN STD_LOGIC; --输入清零信号
        cnt_init : IN STD_LOGIC; --输入启用计数信号
        in_mode : IN STD_LOGIC; --输入模式信号
        mode : IN STD_LOGIC; --输出显示信号(1输出每瓶药片数目，0输出装瓶数显示)
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --每瓶药片的BCD码输入
        o1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --每瓶药片数目显示
        o2 : OUT STD_LOGIC_VECTOR(14 DOWNTO 0); --总药片数量显示
        en_g : OUT STD_LOGIC; --绿灯显示信号
        en_r : OUT STD_LOGIC;--红灯显示信号
        clk_divide : OUT STD_LOGIC
    );
END PillLoad_System;

ARCHITECTURE func OF PillLoad_System IS
    COMPONENT divide IS --分频器
        PORT (
            clk : IN STD_LOGIC;
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
            ou : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --2个数码管显示(每瓶药片数目)
        );
    END COMPONENT;
    COMPONENT total IS --药片总量计数器
        PORT (
            clr : IN STD_LOGIC; --输入药片总量清零信号
            cnt_init : IN STD_LOGIC; --输入启用计数信号
            clk_divide : IN STD_LOGIC; --输入分频时钟信号
            en_cnt : IN STD_LOGIC; --输入计数使能信号
            judge : IN STD_LOGIC; --判断瓶是否装满
            ou : OUT STD_LOGIC_VECTOR(14 DOWNTO 0) --3个数码管显示(总药片数量)
        );
    END COMPONENT;
    COMPONENT control IS
        PORT (
            clr : IN STD_LOGIC; --清零信号
            judge : IN STD_LOGIC; --判断装瓶量是否超过最大瓶数
            en_cnt : OUT STD_LOGIC; --输出计数使能信号
            en_green : OUT STD_LOGIC; --绿灯显示信号
            en_red : OUT STD_LOGIC --红灯显示信号
            --方波闪烁报警
        );
    END COMPONENT;
    COMPONENT count IS --装瓶量计数器
        PORT (
            clr : IN STD_LOGIC; --清零信号
            ci : IN STD_LOGIC; --进位信号
            pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --最大装瓶量BCD码输入
            judge : OUT STD_LOGIC; --判断装瓶量是否超过最大瓶数
            ou : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --2个数码管显示(装瓶数)
        );
    END COMPONENT;
    SIGNAL tmp_divide, ci, judge : STD_LOGIC := '0';
    SIGNAL en_cnt : STD_LOGIC := '1';
    SIGNAL en_green, en_red : STD_LOGIC := '0';
    SIGNAL pin1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL pin2 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL out1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL out2 : STD_LOGIC_VECTOR(14 DOWNTO 0) := (OTHERS => '0');
    SIGNAL out3 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (in_mode, pin)
    BEGIN
        IF (in_mode = '0') THEN
            pin1 <= pin;
        ELSE
            pin2 <= pin;
        END IF;
    END PROCESS;
    u1 : divide PORT MAP(clk, tmp_divide);
    u2 : single_cnt PORT MAP(cnt_init, tmp_divide, en_cnt, pin1, clr, ci, out1);
    u3 : total PORT MAP(clr, cnt_init, tmp_divide, en_cnt, judge, out2);
    u4 : control PORT MAP(clr, judge, en_cnt, en_green, en_red);
    u5 : count PORT MAP(clr, ci, pin2, judge, out3);
    en_g <= en_green;
    en_r <= en_red;
    o1 <= out1 WHEN mode = '1' ELSE
        out3;
    o2 <= out2;
    clk_divide <= tmp_divide;
END func;