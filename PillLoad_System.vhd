LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY PillLoad_System IS
    PORT (
        clk : IN STD_LOGIC; --����ʱ���ź�
        clr1 : IN STD_LOGIC; --���뵥ƿҩƬ�����ź�
        clr2 : IN STD_LOGIC; --����ҩƬ���������ź�
        cnt_init : IN STD_LOGIC; --�������ü����ź�
        pin1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --ÿƿҩƬ��BCD������
        pin2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --���װƿ����BCD������
        o1 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0); --ÿƿҩƬ��Ŀ��ʾ
        o2 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0); --��ҩƬ������ʾ
        o3 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0); --װƿ����ʾ
        en_g : OUT STD_LOGIC; --�̵���ʾ�ź�
        en_r : OUT STD_LOGIC --�����ʾ�ź�
    );
END PillLoad_System;

ARCHITECTURE func OF PillLoad_System IS
    COMPONENT divide IS --��Ƶ��
        PORT (
            cl1 : IN STD_LOGIC;
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
            ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2���������ʾ(ÿƿҩƬ��Ŀ)
        );
    END COMPONENT;
    COMPONENT total IS --ҩƬ����������
        PORT (
            clr : IN STD_LOGIC; --����ҩƬ���������ź�
            cnt_init : IN STD_LOGIC; --�������ü����ź�
            clk_divide : IN STD_LOGIC; --�����Ƶʱ���ź�
            en_cnt : IN STD_LOGIC; --�������ʹ���ź�
            ou : OUT STD_LOGIC_VECTOR(20 DOWNTO 0) --3���������ʾ(��ҩƬ����)
        );
    END COMPONENT;
    COMPONENT control IS
        PORT (
            judge : IN STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
            en_cnt : OUT STD_LOGIC; --�������ʹ���ź�
            en_green : OUT STD_LOGIC; --�̵���ʾ�ź�
            en_red : OUT STD_LOGIC --�����ʾ�ź�
            --������˸����
        );
    END COMPONENT;
    COMPONENT count IS --װƿ��������
        PORT (
            ci : IN STD_LOGIC; --��λ�ź�
            pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --���װƿ��BCD������
            judge : OUT STD_LOGIC; --�ж�װƿ���Ƿ񳬹����ƿ��
            ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2���������ʾ(װƿ��)
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