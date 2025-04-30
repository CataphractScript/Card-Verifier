library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity luhn_algorithm_module is
    Port (
        clk               : in STD_LOGIC;
        rst               : in STD_LOGIC;
        chunk1            : in STD_LOGIC_VECTOR(15 downto 0);
        chunk2            : in STD_LOGIC_VECTOR(15 downto 0);
        chunk3            : in STD_LOGIC_VECTOR(15 downto 0);
        chunk4            : in STD_LOGIC_VECTOR(15 downto 0);
        is_ready_for_luhn : in STD_LOGIC;
        isValid           : out STD_LOGIC;
        sum_show          : out integer;
        card_data_show    : out STD_LOGIC_VECTOR(63 downto 0);
        last_digit_show   : out integer
    );
end luhn_algorithm_module;

architecture Behavioral of luhn_algorithm_module is
begin
    process(clk, rst)
        variable sum               : integer := 0;
        variable current_digit     : integer;
        variable last_digit        : integer;
        variable card_data         : STD_LOGIC_VECTOR(63 downto 0);
        variable card_data_15digit : STD_LOGIC_VECTOR(59 downto 0);
    begin
        if rst = '1' then
            isValid           <= '0';
            sum               := 0;
            sum_show          <= 0;
            card_data         := (others => '0');
            card_data_15digit := (others => '0');
            last_digit_show   <= 0;

        elsif rising_edge(clk) then
            if is_ready_for_luhn = '1' then
                card_data := chunk1 & chunk2 & chunk3 & chunk4;
                card_data_show <= card_data;
                last_digit := to_integer(unsigned(card_data(3 downto 0)));
                card_data_15digit := card_data(63 downto 4);

                sum := 0;
                for i in 0 to 14 loop
                    current_digit := to_integer(unsigned(card_data_15digit((4*i)+3 downto (4*i))));
                    
                    if (i mod 2) = 0 then
                        current_digit := current_digit * 2;
                        if current_digit > 9 then
                            current_digit := current_digit - 9;
                        end if;
                    end if;
                    
                    sum := sum + current_digit;
                end loop;
    
                sum := sum + last_digit;
                sum_show <= sum;
    
                if (sum mod 10) = 0 then
                    isValid <= '1';
                else
                    isValid <= '0';
                end if;
                last_digit_show <= last_digit;
            end if;
        end if;
    end process;
end Behavioral;
