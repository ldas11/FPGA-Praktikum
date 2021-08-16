library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	

entity bandsperre is
	port (
			adc_in : in std_logic_vector(13 downto 0);
			clk, reset : in std_logic;
			dac_out : out std_logic_vector(13 downto 0)
		);
end bandsperre;

architecture filter of bandsperre is
	
	signal x_0 : std_logic_vector(13 downto 0);

	signal mult0_0 : std_logic_vector(16 downto 0);
	signal mult0_1 : std_logic_vector(16 downto 0);
	signal mult0_2 : std_logic_vector(16 downto 0);

	signal mult2 : std_logic_vector(16 downto 0);

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
	
	process(clk, reset, adc_in)
		
		begin
			
			if(reset = '0') then
				
				x_0 <= "00000000000000";
				mult0_1 <= "00000000000000000";
				mult0_2 <= "00000000000000000";

			elsif(clk'event and clk = '1') then

				x_0 <= adc_in;
				mult0_1<= mult0_0;
				mult0_2<= mult0_1;
			end if;

	end process;

	process(x_0)

		begin
			mult0_0 <= multiplicar(x_0, "010");
			mult2 <= multiplicar(x_0, "010");
	end process;

	process(mult0_2, mult2)
		begin
			akkumulator <= sumar(mult0_2, mult2);
	end process;

	dac_out <= akkumulator(15 downto 2);

end architecture filter;