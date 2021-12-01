-- We calculate the OR of elements of bit_vector, i.e A(0) or A(1) or ......... A(14) or A(15)

entity sixteen_or is 

	port( X : in bit_vector(15 downto 0); 
		   Y : out bit); 
			
end sixteen_or; 
 
architecture Behavioral of sixteen_or is 

	begin 
			
		Y <= (X(0) or X(1)) or (X(2) or X(3)) or (X(4) or X(5)) or (X(6) or X(7)) or (X(8) or X(9)) or (X(10) or X(11)) or (X(12) or X(13)) or (X(14) or X(15));
end Behavioral;