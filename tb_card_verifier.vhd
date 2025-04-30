library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_card_verifier is
end tb_card_verifier;

architecture Behavioral of tb_card_verifier is
    signal clk       : STD_LOGIC := '0';
    signal rst       : STD_LOGIC := '1';
    signal bit_input : STD_LOGIC;
    signal isValid   : STD_LOGIC;

    constant clk_period : time := 10 ns;

    constant card_test_1 : STD_LOGIC_VECTOR(63 downto 0) :=
        "0100010101010110011100110111010110000110100010011001100001010101";

    constant card_test_2 : STD_LOGIC_VECTOR(63 downto 0) :=
        "0001001000110100010101100111100010010001001000110100010101100111";

    constant card_test_3 : STD_LOGIC_VECTOR(63 downto 0) :=
        "0100000100010001000100010001000100010001000100010001000100010001";

    constant card_test_4 : STD_LOGIC_VECTOR(63 downto 0) :=
        "0110100001010001010000100110001101011000011100010100001001101001";

    constant card_test_5 : STD_LOGIC_VECTOR(63 downto 0) :=
        "0100010101010110000100011000011110010011011100010111001100110001";

    constant card_test_6 : STD_LOGIC_VECTOR(63 downto 0) :=
        "0011010100110000100001010001010100100001011110010111100100000001";

    -- 11001100101010101111000011110000101010101010101000110

begin
    uut: entity work.mc_card_verifier
        port map (
            clk       => clk,
            rst       => rst,
            bit_input => bit_input,
            isValid   => isValid
        );

    clock_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    stimulus_process : process
    -- send data of card_test to shift register bit by bit sequentially
    procedure apply_card(card: STD_LOGIC_VECTOR) is
        begin
            for i in 63 downto 0 loop
                bit_input <= card(i);
                wait for clk_period;
            end loop;
        end procedure;

    procedure reset_system is
    begin
        rst <= '1';
        wait for clk_period*2;
        rst <= '0';
        --wait for clk_period;
    end procedure;

    begin
        -- rst <= '1';
        -- wait for 1 ns;
        rst <= '0';
        --wait for clk_period;

        --bit_input <= '0';
        -- Applying card_test_1 then Resetting system
        apply_card(card_test_1);
        wait for 100 ns;
        reset_system;
        --wait for 10 ns;


        -- Applying card_test_2 then Resetting system
        apply_card(card_test_2);
        wait for 100 ns;
        reset_system;
        --wait for 10 ns;


        -- Applying card_test_3 then Resetting system
        apply_card(card_test_3);
        wait for 100 ns;
        reset_system;
        --wait for 10 ns;
            

        -- Applying card_test_4 then Resetting system
        apply_card(card_test_4);
        wait for 100 ns;
        reset_system;
        --wait for 10 ns;


        apply_card(card_test_5);
        wait for 100 ns;
        reset_system;
        --wait for 10 ns;


        apply_card(card_test_6);
        wait for 100 ns;
        reset_system;
        --wait for 10 ns;


        rst <= '1';


        wait;
    end process;
end Behavioral;
