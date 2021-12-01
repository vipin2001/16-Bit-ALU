entity three_and is
	port( A0, A1, A2 : in bit;
			Y : out bit);
			
end entity three_and;

architecture and3_bhv of three_and is
	begin
		Y <= (A0 and A1) and A2;
		
end architecture and3_bhv;