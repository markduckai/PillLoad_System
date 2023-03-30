LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY PillLoad_System IS
    PORT (
        clk : IN STD_LOGIC; --����ʱ���ź�
        clr : IN STD_LOGIC; --���������ź�
        cnt_init : IN STD_LOGIC; --�������ü����ź�
        in_mode : IN STD_LOGIC; --����ģʽ�ź�
        mode : IN STD_LOGIC; --�����ʾ�ź�(1���ÿƿҩƬ��Ŀ��0���װƿ����ʾ)
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --ÿƿҩƬ��BCD������
        o1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --ÿƿҩƬ��Ŀ��ʾ
        o2 : OUT STD_LOGIC_VECTOR(14 DOWNTO 0); --��ҩƬ������ʾ
        en_g : OUT STD_LOGIC; --�̵���ʾ�ź�
        en_r : OUT STD_LOGIC;--�����ʾ�ź�
        clk_divide : OUT STD_LOGIC
    );
END PillLoad_System;

ARCHITECTURE func OF PillLoad_System IS
    COMPONENT divide IS --��Ƶ��
        PORT (
            clk : IN STD_LOGIC;
            clk_divide : OUT STD_LOGIC
        );
    END COMPONENT;
    COMPONENT single_cnt IS --��ƿҩƬ������
        PORT (
            cnt_init : IN STD_LOGIC; --�������ü����ź�
            clk_divide : IN STD_LOGIC; -- �����Ƶʱ���ź�
            en_cnt : IN STD_LOGIC; --�������ʹ���ź�
            pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --ÿƿҩƬ��BCD������
            clr : IN STD_LOGIC; --��ƿҩƬ�����ź�
            ci : OUT STD_LOGIC; --��λ�ź�
            ou : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --2���������ʾ(ÿƿҩƬ��Ŀ)
        );
    END COMPONENT;
    COMPONENT total IS --ҩƬ����������
        PORT (
            clr : IN STD_LOGIC; --����ҩƬ���������ź�
            cnt_init : IN STD_LOGIC; --�������ü����ź�
            clk_divide : IN STD_LOGIC; --�����Ƶʱ���ź�
            en_cnt : IN STD_LOGIC; --�������ʹ���ź�
            judge : IN STD_LOGIC; --�ж�ƿ�Ƿ�װ��
            ou : OUT STD_LOGIC_VECTOR(14 DOWNTO 0) --3���������ʾ(��ҩƬ����)
        );
    END COMPONENT;
    COMPONENT control IS
        PORT (
            clr : IN STD_LOGIC; --�����ź�
            judge : IN STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
            en_cnt : OUT STD_LOGIC; --�������ʹ���ź�
            en_green : OUT STD_LOGIC; --�̵���ʾ�ź�
            en_red : OUT STD_LOGIC --�����ʾ�ź�
            --������˸����
        );
    END COMPONENT;
    COMPONENT count IS --װƿ��������
        PORT (
            clr : IN STD_LOGIC; --�����ź�
            ci : IN STD_LOGIC; --��λ�ź�
            pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --���װƿ��BCD������
            judge : OUT STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
            ou : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --2���������ʾ(װƿ��)
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