-- Two input XOR (Used in xor16.vhd)
entity two_xor is 

	port ( A : in bit; 
			 B : in bit; 
			 C : out bit);
			 
end two_xor; 
 
architecture Behavioral of two_xor is

	begin 
		C <= A xor B;
 
end Behavioral;