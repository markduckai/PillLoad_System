LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY count IS
    PORT (
        ci : IN STD_LOGIC; --进位信号
        pin : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --最大装瓶量BCD码输入
        judge : OUT STD_LOGIC : --判断装瓶量是否超过最大瓶数
        ou : OUT STD_LOGIC_VECTOR(13 DOWNTO 0) --2个数码管显示(装瓶数)
    );
END count;

ARCHITECTURE func_count OF count IS
BEGIN

END func_count;