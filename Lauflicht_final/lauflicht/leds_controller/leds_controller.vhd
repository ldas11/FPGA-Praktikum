library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	

entity leds_controller is
	PORT(
		reset, reverse, start_pause, scaler : in std_logic;
		muster : in std_logic_vector(7 downto 0);
		leds : out std_logic_vector(7 downto 0)
		);
end leds_controller;

architecture control of leds_controller is

	type state_type is (s1, s2, s3, s4, s5, s6, s7, s8);
	
	signal current_state, next_state : state_type;
	signal leds_temp : std_logic_vector(7 downto 0);
	signal muster_temp : std_logic_vector(7 downto 0);
	signal counter : integer range 0 to 8 :=0;

begin
	
	muster_temp <= muster;
	
	--change state when the scaler has a rising edge--
	process(reset, scaler, start_pause, next_state, counter)
		begin

			if (reset = '0') then
				
				current_state <= s1;
			
			elsif (start_pause = '0') then --puede no ser necesario
					
				current_state <= current_state;

			elsif (scaler'event and scaler = '1') then
				
				current_state <= next_state;			
				
			end if;

	end process;

	--selects the next state, depends on reverse--
	process(current_state, reverse)
		begin
			
			case current_state is
				
				when s1 =>
					
					if(reverse = '1') then
						next_state <= s8;
					else
						next_state <= s2;
					end if;

				when s2 =>

					if(reverse = '1') then
						next_state <= s1;
					else
						next_state <= s3;
					end if;

				when s3 =>

					if(reverse = '1') then
						next_state <= s2;
					else
						next_state <= s4;
					end if;

				when s4 =>

					if(reverse = '1') then
						next_state <= s3;
					else
						next_state <= s5;
					end if;
				when s5 =>

					if(reverse = '1') then
						next_state <= s4;
					else
						next_state <= s6;
					end if;

				when s6 =>

					if(reverse = '1') then
						next_state <= s5;
					else
						next_state <= s7;
					end if;

				when s7 =>

					if(reverse = '1') then
						next_state <= s6;
					else
						next_state <= s8;
					end if;

				when s8 =>	

					if(reverse = '1') then
						next_state <= s7;
					else
						next_state <= s1;
					end if;
							
			end case;

	end process;

	--defines which leds should shine, depending on the current state--
	process(current_state, muster_temp)
		begin

			case current_state is

				when s1 =>
					
					leds_temp(7) <= muster_temp(7);
					leds_temp(6) <= muster_temp(6);
					leds_temp(5) <= muster_temp(5);
					leds_temp(4) <= muster_temp(4);
					leds_temp(3) <= muster_temp(3);
					leds_temp(2) <= muster_temp(2);
					leds_temp(1) <= muster_temp(1);
					leds_temp(0) <= muster_temp(0);

				when s2 =>

					leds_temp(7) <= muster_temp(6);
					leds_temp(6) <= muster_temp(5);
					leds_temp(5) <= muster_temp(4);
					leds_temp(4) <= muster_temp(3);
					leds_temp(3) <= muster_temp(2);
					leds_temp(2) <= muster_temp(1);
					leds_temp(1) <= muster_temp(0);
					leds_temp(0) <= muster_temp(7);

				when s3 =>

					leds_temp(7) <= muster_temp(5);
					leds_temp(6) <= muster_temp(4);
					leds_temp(5) <= muster_temp(3);
					leds_temp(4) <= muster_temp(2);
					leds_temp(3) <= muster_temp(1);
					leds_temp(2) <= muster_temp(0);
					leds_temp(1) <= muster_temp(7);
					leds_temp(0) <= muster_temp(6);

				when s4 =>

					leds_temp(7) <= muster_temp(4);
					leds_temp(6) <= muster_temp(3);
					leds_temp(5) <= muster_temp(2);
					leds_temp(4) <= muster_temp(1);
					leds_temp(3) <= muster_temp(0);
					leds_temp(2) <= muster_temp(7);
					leds_temp(1) <= muster_temp(6);
					leds_temp(0) <= muster_temp(5);

				when s5 =>

					leds_temp(7) <= muster_temp(3);
					leds_temp(6) <= muster_temp(2);
					leds_temp(5) <= muster_temp(1);
					leds_temp(4) <= muster_temp(0);
					leds_temp(3) <= muster_temp(7);
					leds_temp(2) <= muster_temp(6);
					leds_temp(1) <= muster_temp(5);
					leds_temp(0) <= muster_temp(4);

				when s6 =>

					leds_temp(7) <= muster_temp(2);
					leds_temp(6) <= muster_temp(1);
					leds_temp(5) <= muster_temp(0);
					leds_temp(4) <= muster_temp(7);
					leds_temp(3) <= muster_temp(6);
					leds_temp(2) <= muster_temp(5);
					leds_temp(1) <= muster_temp(4);
					leds_temp(0) <= muster_temp(3);

				when s7 =>

					leds_temp(7) <= muster_temp(1);
					leds_temp(6) <= muster_temp(0);
					leds_temp(5) <= muster_temp(7);
					leds_temp(4) <= muster_temp(6);
					leds_temp(3) <= muster_temp(5);
					leds_temp(2) <= muster_temp(4);
					leds_temp(1) <= muster_temp(3);
					leds_temp(0) <= muster_temp(2);

				when s8 =>

					leds_temp(7) <= muster_temp(0);
					leds_temp(6) <= muster_temp(7);
					leds_temp(5) <= muster_temp(6);
					leds_temp(4) <= muster_temp(5);
					leds_temp(3) <= muster_temp(4);
					leds_temp(2) <= muster_temp(3);
					leds_temp(1) <= muster_temp(2);
					leds_temp(0) <= muster_temp(1);

			end case;
	end process;

	
	

leds <= leds_temp;


end architecture control;























