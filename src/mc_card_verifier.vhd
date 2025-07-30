library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mc_card_verifier is
    Port (
        clk       : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        bit_input : in  STD_LOGIC;
        isValid   : out STD_LOGIC
    );
end mc_card_verifier;

architecture Behavioral of mc_card_verifier is

    component shift_register_module is
        Port (
            clk            : in  STD_LOGIC;
            rst            : in  STD_LOGIC;
            bit_input      : in  STD_LOGIC;
            shift_register : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component chunk_manager_module is
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
    end component;

    component luhn_algorithm_module is
        Port (
            clk                            : in  STD_LOGIC;
            rst                            : in  STD_LOGIC;
            chunk1, chunk2, chunk3, chunk4 : in STD_LOGIC_VECTOR(15 downto 0);
            is_ready_for_luhn              : in  STD_LOGIC;
            isValid                        : out STD_LOGIC;
            sum_show                       : out integer;
            card_data_show                 : out STD_LOGIC_VECTOR(63 downto 0);
            last_digit_show                : out integer
        );
    end component;

    signal shift_register                 : STD_LOGIC_VECTOR(3 downto 0);
    signal chunk1, chunk2, chunk3, chunk4 : STD_LOGIC_VECTOR(15 downto 0);
    signal is_ready_for_luhn              : STD_LOGIC;
    signal sum_show                       : integer;
    signal card_data_show                 : STD_LOGIC_VECTOR(63 downto 0);
    signal last_digit_show                : integer;
    
begin

    U1: shift_register_module port map (
        clk            => clk,
        rst            => rst,
        bit_input      => bit_input,
        shift_register => shift_register
    );

    U2: chunk_manager_module port map (
        clk               => clk,
        rst               => rst,
        shift_register    => shift_register,
        bit_input         => bit_input,
        chunk1            => chunk1,
        chunk2            => chunk2,
        chunk3            => chunk3,
        chunk4            => chunk4,
        is_ready_for_luhn => is_ready_for_luhn
    );

    U3: luhn_algorithm_module port map (
        clk               => clk,
        rst               => rst,
        chunk1            => chunk1,
        chunk2            => chunk2,
        chunk3            => chunk3,
        chunk4            => chunk4,
        is_ready_for_luhn => is_ready_for_luhn,
        isValid           => isValid,
        sum_show          => sum_show,
        card_data_show    => card_data_show,
        last_digit_show   => last_digit_show
    );

end Behavioral;
