library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chunk_manager_module is
    Port (
        clk               : in  STD_LOGIC;
        rst               : in  STD_LOGIC;
        shift_register    : in  STD_LOGIC_VECTOR(3 downto 0);
        bit_input         : in  STD_LOGIC;
        chunk1            : out STD_LOGIC_VECTOR(15 downto 0);
        chunk2            : out STD_LOGIC_VECTOR(15 downto 0);
        chunk3            : out STD_LOGIC_VECTOR(15 downto 0);
        chunk4            : out STD_LOGIC_VECTOR(15 downto 0);
        is_ready_for_luhn : out STD_LOGIC
    );
end chunk_manager_module;

architecture Behavioral of chunk_manager_module is

    signal temp_chunk_counter   : integer range 0 to 3 := 0;
    signal current_chunk_fill   : integer range 0 to 3 := 0;
    signal temp_chunk           : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal bit_counter_4        : integer range 0 to 3 := 0;
    signal bit_counter_64       : integer range 0 to 63 := 0;
    signal is_register_filled   : STD_LOGIC := '0'; -- is register fixed
    signal is_temp_chunk_filled : STD_LOGIC := '0';

    signal s_chunk1 : STD_LOGIC_VECTOR(15 downto 0);
    signal s_chunk2 : STD_LOGIC_VECTOR(15 downto 0);
    signal s_chunk3 : STD_LOGIC_VECTOR(15 downto 0);
    signal s_chunk4 : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    process(clk, rst)
    begin
        if rst = '1' then
            s_chunk1   <= (others => '0');
            s_chunk2   <= (others => '0');
            s_chunk3   <= (others => '0');
            s_chunk4   <= (others => '0');
            temp_chunk <= (others => '0');
          
            temp_chunk_counter <= 0;
            current_chunk_fill <= 0;
              
            bit_counter_4  <= 0;
            bit_counter_64 <= 0;

            is_ready_for_luhn    <= '0';
            is_register_filled   <= '0';
            is_temp_chunk_filled <= '0';

        elsif rising_edge(clk) then
            if is_register_filled = '1' then
                if temp_chunk_counter = 3 then
                    is_temp_chunk_filled <= '1';
                    temp_chunk_counter <= 0;
                else
                    temp_chunk_counter <= temp_chunk_counter + 1;
                end if;

                temp_chunk <= temp_chunk(11 downto 0) & shift_register;

                if is_temp_chunk_filled = '1' then
                    case current_chunk_fill is
                        when 0 => s_chunk1 <= temp_chunk;
                        when 1 => s_chunk2 <= temp_chunk;
                        when 2 => s_chunk3 <= temp_chunk;
                        --when 3 => s_chunk4 <= temp_chunk;
                        when others => null;
                    end case;
                    if current_chunk_fill = 3 then 
                        current_chunk_fill <= 0;
                    else
                        current_chunk_fill <= current_chunk_fill + 1;
                    end if;
                    is_temp_chunk_filled <= '0';
                end if;
                is_register_filled <= '0';
            end if;
            
            if bit_counter_4 = 3 then
                is_register_filled <= '1';
                bit_counter_4 <= 0;
            else
                bit_counter_4  <= bit_counter_4 + 1;
            end if;

            if bit_counter_64 = 63 then
                is_ready_for_luhn <= '1';
                s_chunk4 <= temp_chunk(11 downto 0) & shift_register(2 downto 0) & bit_input;
                bit_counter_64 <= 0;
            else
                is_ready_for_luhn <= '0';
                bit_counter_64 <= bit_counter_64 + 1;
            end if;
        end if;
    end process;
    
    chunk1 <= s_chunk1;
    chunk2 <= s_chunk2;
    chunk3 <= s_chunk3;
    chunk4 <= s_chunk4;

end Behavioral;
