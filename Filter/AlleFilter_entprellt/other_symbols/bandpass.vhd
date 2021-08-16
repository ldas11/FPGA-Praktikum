library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	

entity bandpass is
	port (
			adc_in : in std_logic_vector(13 downto 0);
			clk, reset : in std_logic;
			dac_out : out std_logic_vector(13 downto 0)
		);
end bandpass;

architecture filter of bandpass is
	--signal fur 0, t-1, t-2
	signal x_0 : std_logic_vector(13 downto 0);
	signal x_1 : std_logic_vector(13 downto 0);
	signal x_2 : std_logic_vector(13 downto 0);
	--werte nach Multiplikation
	signal mult_0 : std_logic_vector(16 downto 0);
	signal mult_2 : std_logic_vector(16 downto 0);

	--Addition
	signal akkumulator : std_logic_vector(16 downto 0);

	function multiplicar(a, factor: std_logic_vector) return std_logic_vector is
		variable a_sign : signed(13 downto 0);
		variable factor_sign : signed(2 downto 0);
		variable result_temp : signed(16 downto 0);
		variable result : std_logic_vector(16 downto 0);
		
		begin
			
			a_sign := signed(a);
			factor_sign := signed(factor);
			
			result_temp := a_sign * factor_sign;
			result := std_logic_vector(result_temp)(16 downto 0);
			
			return result;
			
	end multiplicar;
	
	function sumar(a,b : std_logic_vector) return std_logic_vector is
	begin 
		return std_logic_vector(signed(a)+signed(b))(16 downto 0);
	end sumar;
	
begin
	--shift register 
	process(clk, reset, adc_in)
		
		begin
			
			if(reset = '0') then
				
				x_0 <= "00000000000000";
				x_1 <= "00000000000000";
				x_2 <= "00000000000000";

			elsif(clk'event and clk = '1') then

				x_0 <= adc_in;
				x_1 <= x_0;
				x_2 <=x_1;

			end if;

	end process;

	--Multiplikation
	process(x_0, x_1, x_2)

		begin
			mult_0 <= multiplicar(x_0, "110");
			mult_2 <= multiplicar(x_2, "010");
	end process;

	--Addition
	process(mult_0, mult_2)
		begin
			akkumulator <= sumar(mult_0, mult_2);
	end process;

	dac_out <= akkumulator(15 downto 2);

end architecture filter;