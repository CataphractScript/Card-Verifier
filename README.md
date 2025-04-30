# Documentation for Card Verifier

## 1. Design Document 

**Introduction:** The goal of this project is to design VHDL code for a Card Verifier Logic Circuit, which verifies the validity of credit card number. 

Functional Requirements: The Card Verifier should be able to validate a credit card number. 

### Card Verifier Overview: 

This system reads input data (credit card number) from a shift-register and validates the credit card number using The Luhn Formula. 

• Shift register usage :

The 4-bit inputs are received through a shift register and after each 4-bit data is captured, it is sent to a 16-bit temporary variable to be stored temporarily. The shift register captures and sends 4 sets of 4-bits. 

Finally after the temporary variable was filled, its data is transferred to the chunk where the data is to be stored. This process continues until all 4 chunks are filled. 

## 2. Testing Report 

**Test Plan:** Tests have been designed to verify the correct functionality of the system,including card validation processing. 

**Test Case 1:** Valid credit card number test: 

Valid credit card number were tested to ensure validation process. / Wave form submitted. 

**Test Case 2:** Invalid credit card test: 

Invalid credit card number were tested to ensure validation process. / Wave form submitted. 

### Simulation Results: 

Simulation results include waveform outputs and verification of correct system behavior under test conditions. 

## 3. User Guide 

### ghdl installation: 

1. Installing GHDL on Linux: 

    1.1. ```sudo apt update```

    1.2. ```sudo apt install ghdl```

2. Installing GHDL on Windows:

    2.1. Download the latest Windows binary from the official GitHub releases: [https://github.com/ghdl/ghdl/releases](https://github.com/ghdl/ghdl/releases)


 

### Testbench: 

❖ Open ```tb_card_verifier.vhd``` file: 
&nbsp;&nbsp;&nbsp;&nbsp;➢ Enter your number equal to Credit Card number variable 

### Analyzing code and wave observation:

1. open the terminal in Visual Studio Code using: ```Ctrl + \~```

2. check and analyze main file: 
    2.1. ```ghdl -s mc_card_verifier.vhd```
    2.2. ```ghdl -a mc_card_verifier.vhd```

3. check and analyze Testbench file: 
    3.1. ```ghdl -s tb_card_verifier.vhd```
    3.2. ```ghdl -a tb_card_verifier.vhd```

4. Compile Testbench (Elaborates the entity) file using: ```ghdl -e tb_card_verifier``` 

5. Running the simulator and generating waves using:
```ghdl -r tb_card_verifier –wave=tb.ghw –stop-time=5000ns``` (Choosing a time is optional./ it was our suggestion) 

6. Wave observation using: ```gtkwave tb.ghw```

## Authors:

- Arman Jahangirian
- Parsa Dowlatabadi