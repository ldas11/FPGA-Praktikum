library ieee;
use ieee.std_logic_1164.all;

entity muxcontrol is 
	port(
	clk, reset, sw0, sw1, sw2, sw3 : in std_logic;
	u33, u32 : out std_logic_vector(7 downto 0);
	muxchannel : out std_logic_vector(1 downto 0)
	);
end muxcontrol;

architecture control of muxcontrol is
	
	signal current_state : std_logic_vector(1 downto 0);
	signal next_state : std_logic_vector(1 downto 0);
	
	signal muxchannel_temp : std_logic_vector(1 downto 0);
	
	signal u33_temp : std_logic_vector(7 downto 0);
	signal u32_temp : std_logic_vector(7 downto 0);
	
	function stdVectorToSevenSeg33(number : std_logic_vector) return std_logic_vector is
	
		variable sevenSegment : std_logic_vector(7 downto 0); 
	
		begin
			--receive an int, return the belonging logic_vector--
			case number is
			
				when "00" => sevenSegment := "00110001";--p
				when "01" => sevenSegment := "01001001";--s
				when "10" => sevenSegment := "00110001";--p
				when "11" => sevenSegment := "00110001";--p
				--when 4 => sevenSegment := "10011101";
				--when 5 => sevenSegment := "01001001";
				--when 6 => sevenSegment := "01000001";
				--when 7 => sevenSegment := "00011111";
				--when 8 => sevenSegment := "00000001";
				--when 9 => sevenSegment := "00011001";
				when others => sevenSegment := "00000000";
		
			end case;
		--assign output--
		return sevenSegment;

	end stdVectorToSevenSeg33;
	
	function stdVectorToSevenSeg32(number : std_logic_vector) return std_logic_vector is
	
		variable sevenSegment : std_logic_vector(7 downto 0); 
	
		begin
			--receive an int, return the belonging logic_vector--
			case number is
			
				when "00" => sevenSegment := "11000001";--b
				when "01" => sevenSegment := "11000001";--b
				when "10" => sevenSegment := "11010001";--h
				when "11" => sevenSegment := "11100001";--t
				--when 4 => sevenSegment := "10011101";
				--when 5 => sevenSegment := "01001001";
				--when 6 => sevenSegment := "01000001";
				--when 7 => sevenSegment := "00011111";
				--when 8 => sevenSegment := "00000001";
				--when 9 => sevenSegment := "00011001";
				when others => sevenSegment := "00000000";
		
			end case;
		--assign output--
		return sevenSegment;

	end stdVectorToSevenSeg32;
	
	begin
	
	process(clk, reset, next_state, current_state)
		begin

			if (reset = '0') then
				
				current_state <= "00";

			elsif (clk'event and clk = '1') then
				
				current_state <= next_state;			
				
			end if;
			
	end process;
	
	process(current_state, sw0, sw1, sw2, sw3)
		begin	
			case current_state is
				when "00" =>
					
					muxchannel_temp <= "00";
					
					if(sw0 = '0') then
						next_state <= "00";
					elsif(sw1 = '0') then
						next_state <= "01";
					elsif(sw2 = '0') then 
						next_state <= "10";
					elsif(sw3 = '0') then	
						next_state <= "11";
					else
						next_state <=current_state;
					end if;
					
				when "01" =>
					
					muxchannel_temp <= "01";
					
					if(sw0 = '0') then
						next_state <= "00";
					elsif(sw1 = '0') then
						next_state <= "01";
					elsif(sw2 = '0') then 
						next_state <= "10";
					elsif(sw3 = '0') then	
						next_state <= "11";
					else
						next_state <=current_state;
					end if;
					
				when "10" =>
				
					muxchannel_temp <= "10";
					
					if(sw0 = '0') then
						next_state <= "00";
					elsif(sw1 = '0') then
						next_state <= "01";
					elsif(sw2 = '0') then 
						next_state <= "10";
					elsif(sw3 = '0') then	
						next_state <= "11";
					else
						next_state <=current_state;
					end if;
					
				when "11" =>
				
				
					muxchannel_temp <= "11";
					
					if(sw0 = '0') then
						next_state <= "00";
					elsif(sw1 = '0') then
						next_state <= "01";
					elsif(sw2 = '0') then 
						next_state <= "10";
					elsif(sw3 = '0') then	
						next_state <= "11";
					else
						next_state <=current_state;
					end if;
					
			end case;
			
	end process;
	

u33 <= stdVectorToSevenSeg33(current_state);
u32 <= stdVectorToSevenSeg32(current_state);

muxchannel <= muxchannel_temp; 

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
end control;