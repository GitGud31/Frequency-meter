library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

Entity Projet_1 is
	
	Port(
	 R,H,Ve : in std_logic;
	 S : out std_logic; 
	 comp_sec : out std_logic_vector(9 downto 0);
	 unite, dizaine, centaine, millier : out std_logic_vector(3 downto 0)
	 );
	
end Projet_1;

Architecture Aprojet_1 of Projet_1 is

signal une_sec : std_logic;
signal comp_une_sec : std_logic_vector(9 downto 0);
signal comp_unite, comp_dizaine, comp_centaine, comp_millier : std_logic_vector(3 downto 0);

begin
	Process(H)
	begin
		if rising_edge(H) then
			if comp_une_sec < 1000 then
				comp_une_sec <= comp_une_sec + 1;
				une_sec <= '1';
			else
				comp_une_sec <= (others =>'0');
				une_sec <= '0';
					
			end if;
		end if;
	end process;

	Process(une_sec,Ve)
	begin
		if une_sec = '1' then
			if rising_edge(Ve) then
				if comp_unite < 9 then
					comp_unite <= comp_unite + 1;
				else 
					comp_unite <= (others =>'0');
					if comp_dizaine < 9 then
						comp_dizaine <= comp_dizaine + 1;
					else 
						comp_dizaine <= (others =>'0');
						if comp_centaine < 9 then
							comp_centaine <= comp_centaine + 1;
						else 
							comp_centaine <= (others =>'0');
							if comp_millier < 9 then
							   comp_millier <= comp_millier + 1;
							else 
								comp_dizaine  <= (others =>'0');
								comp_centaine <= (others =>'0');
								comp_unite    <= (others =>'0');
								comp_millier  <= (others =>'0');
							end if; --end millier
						end if; --end centaine
					end if; --end dizaine
				end if; --end unite
 			end if; --end rising_edge(ve)
 			
 			if Ve = '1' then 
						comp_unite <= comp_unite - 1;
					end if; --end -1
 			
		else
			comp_dizaine  <= (others =>'0');
			comp_centaine <= (others =>'0');
			comp_unite    <= (others =>'0');
			comp_millier  <= (others =>'0');
						
		end if; -- end une_sec
	end process;
	unite    <= comp_unite;
	dizaine  <= comp_dizaine;
	centaine <= comp_centaine;
	millier  <= comp_millier;
	
	S <= une_sec;
	comp_sec <= comp_une_sec;

end Aprojet_1;