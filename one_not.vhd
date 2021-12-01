entity one_not is
	port( Pin : in bit;
			Pout : out bit);
			
end entity one_not;

architecture inv_bhv of one_not is
	begin
		Pout <= not Pin;
		
end architecture inv_bhv;