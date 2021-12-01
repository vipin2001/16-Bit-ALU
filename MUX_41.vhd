entity MUX_41 is
	port( S0, S1 : in bit;
			A, B, C, D : in bit;
			Y : out bit);
			
end entity MUX_41;

architecture structural of MUX_41 is

	component one_not is
		port( Pin : in bit;
				Pout : out bit);
	end component one_not;
	
	component three_and is
		port( A0, A1, A2 : in bit;
				Y : out bit);
	end component three_and;
	
	component four_or is
		port( A0, A1, A2, A3 : in bit;
				Y : out bit);
	end component four_or;

	signal ctrl0, ctrl1, temp1, temp2, temp3, temp4 : bit;
	
	begin
	
	NOT1_0 : one_not port map(S0, ctrl0);
	
	NOT1_1 : one_not port map(S1, ctrl1);
	
	AND3_1 : three_and port map(A, ctrl0, ctrl1, temp1);
		
	AND3_2 : three_and port map(B, S0, ctrl1, temp2);
	
	AND3_3 : three_and port map(C, ctrl0, S1, temp3);
	
	AND3_4 : three_and port map(D, S0, S1, temp4);
	
	OR4_1 : four_or port map(temp1, temp2, temp3, temp4, Y);
	
	end structural;
	
	