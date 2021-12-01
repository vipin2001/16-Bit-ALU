--added buffer blocks for better rtl view
--instead of A and B(to be added), KS16bit takes in G = A and B and P = A xor B as inputs

entity KS16bit is

	port (G,P : in bit_vector(15 downto 0);
			Cin : in bit;
			S : out bit_vector(16 downto 0));  
			
end entity KS16bit;

--------node in the ks adder------
--2 inputs and 2 outputs--
entity node is
	port( Gcurr,Gprev,Pcurr,Pprev : in bit;
			Gout, Pout : out bit);
end entity node;


architecture bhv of node is
begin
	Gout <= Gcurr or (Gprev and Pcurr);
	Pout <= Pcurr and Pprev;
end bhv; 

--------buffer block------------------

entity buffer_block is 
	port( Gcurr,Pcurr : in bit;
			Gout, Pout : out bit);
end entity buffer_block;

architecture buff of buffer_block is
begin 
	Gout <= Gcurr;
	Pout <= Pcurr;
end buff;

--------------------------------------


architecture behaviour of KS16bit is
	
	signal G1, G2, G3, G4 : bit_vector(15 downto 0);
	signal P1, P2, P3, P4 : bit_vector(15 downto 0);
	signal C : bit_vector(15 downto 0);


	component node is
		port( Gcurr,Gprev,Pcurr,Pprev : in bit;
			Gout, Pout : out bit);
	end component;
	
	component buffer_block is 
		port( Gcurr,Pcurr : in bit;
			Gout, Pout : out bit);
	end component;
	
	--type l1_blocks is array(14 downto 0) of node;
	
	begin
		
		
		
		buffer_1 : buffer_block
		port map(G(0),P(0),G1(0),P1(0));
		
		
		lvl1 :
		for i in 1 to 15 generate
			l1node : node port map(G(i),G(i-1),P(i),P(i-1),G1(i),P1(i));
		end generate lvl1;
		
		--------------level 2------------------------------
		--buffer------
		buffer2 :
		for i in 0 to 1 generate
			l2buffer : buffer_block port map(G1(i),P1(i),G2(i),P2(i));
		end generate buffer2;
		
		--nodes-------
		
		
		lvl2 :
		for i in 2 to 15 generate
			l2node : node port map(G1(i),G1(i-2),P1(i),P1(i-2),G2(i),P2(i));
		end generate lvl2;
	
		
		--------------level 3-------------------------------
		--buffer------
		buffer3 :
		for i in 0 to 3 generate
			l3buffer : buffer_block port map(G2(i),P2(i),G3(i),P3(i));
		end generate buffer3;
		
		--nodes-------
		
		lvl3:
		for i in 4 to 15 generate
			l3node : node port map(G2(i),G2(i-4),P2(i),P2(i-4),G3(i),P3(i));
		end generate lvl3;
		
		--------------level 4--------------------------------
		--buffer------
		buffer4:
		for i in 0 to 7 generate
			l4buffer : buffer_block port map(G3(i),P3(i),G4(i),P4(i));
		end generate buffer4;
		
		--nodes-------
		lvl4 : 
		for i in 8 to 15 generate
			l4node : node port map(G3(i),G3(i-8),P3(i),P3(i-8),G4(i),P4(i));
		end generate lvl4;
		

		--note that C(i) is the carry generated at stage i
		--Hence S(i) == C(i-1) xor P(i)
		--intermediate carries--
		carry :
		for i in 0 to 15 generate
			C(i) <= G4(i) or (P4(i) and Cin);
		end generate carry;
		
		S(0) <= Cin xor P(0);
		adder :
		for i in 1 to 15 generate
			S(i) <= P(i) xor C(i-1);
		end generate adder;
		
		S(16) <= C(15);
		
		
		
end behaviour;
	
	
		
----
--level1 : process(G1,P1)
--		begin 
--		lvl : for k in 1 to 15 loop
--			G1(k) <= G(k) or (P(k) and G(k-1));
--			P1(k) <= P(k) and P(k-1);
--			--l1_blocks(k-1) : node port map(G(k),G(k-1),P(k),P(k-1));
--  	end loop lvl;
--	end process level1;
	
--


