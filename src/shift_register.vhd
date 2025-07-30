library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_register_module is
    Port (
        clk            : in  STD_LOGIC;
        rst            : in  STD_LOGIC;
        bit_input      : in  STD_LOGIC;
        shift_register : out STD_LOGIC_VECTOR(3 downto 0)
    );
end shift_register_module;

architecture Behavioral of shift_register_module is
    signal shift_reg : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

begin
    process(clk, rst)
    begin
        if rst = '1' then
            shift_reg <= (others => '0');

        elsif rising_edge(clk) then
            shift_reg <= shift_reg(2 downto 0) & bit_input;
        end if;
    end process;
    shift_register <= shift_reg;
end Behavioral;
