library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment_coder is
	PORT(
		tick, reset : in std_logic;
		u32, u33 : out std_logic_vector(7 downto 0)
		);
END seven_segment_coder;

architecture display_count of seven_segment_coder is

	signal counter : integer range 0 to 99 :=0;--tal vez inicializarlos
	signal multiplesOfTen : integer range 0 to 9;
	signal multiplesOfOne : integer range 0 to 9;

	function integerToSevenSeg(number : integer) return std_logic_vector is
	
		variable sevenSegment : std_logic_vector(7 downto 0); 
	
		begin
			--receive an int, return the belonging logic_vector--
			case number is
			
				when 0 => sevenSegment := "00000011"; 
				when 1 => sevenSegment := "10011111";
				when 2 => sevenSegment := "00100101";
				when 3 => sevenSegment := "00001101";
				when 4 => sevenSegment := "10011001";
				when 5 => sevenSegment := "01001001";
				when 6 => sevenSegment := "01000001";
				when 7 => sevenSegment := "00011111";
				when 8 => sevenSegment := "00000001";
				when 9 => sevenSegment := "00011001";
				when others => sevenSegment := "00000000";
		
			end case;
		--assign output--
		return sevenSegment;

	end integerToSevenSeg;

	procedure divider(signal number : in integer; signal ten, one : out integer range 0 to 9) is
		
			variable number_temp : integer range 0 to 99;
			variable tens : integer range 0 to 9;
			variable ones : integer range 0 to 9;

			begin
	
			number_temp := number;
			--see if number is greater than 9 to determine the first digit--
			if (number_temp > 9) then
			
				tens := number_temp/10;
			
				number_temp := number_temp - (tens * 10);
			
			else 
				
				tens := 0;
			
			end if;
			--the remainder is the second digit--
			ones := number_temp;

			--output assignment--
			ten <= tens;
			one <= ones;

	end divider;

begin
		--count every time the leds move up to 99, then return to 0--
	process(reset, tick)
		begin

			if (reset = '0') then
				
				counter <= 0;
				
			elsif(tick'event and tick = '1') then --counts every time tick changes its value 
				
				if (counter < 99) then
					counter <= counter + 1;
				else
					counter <= 0;
				end if;

			end if;

	end process;

	--divide counter in its components--
	divider(counter, multiplesOfTen, multiplesOfOne);
	--assign the result of divider to the intended display--
	u32 <= integerToSevenSeg(multiplesOfTen);
	u33 <= integerToSevenSeg(multiplesOfOne);

end display_count;