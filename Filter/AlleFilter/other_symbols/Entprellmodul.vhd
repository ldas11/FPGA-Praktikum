library ieee;
use ieee.std_logic_1164.all;
USE ieee.STD_LOGIC_UNSIGNED.all;


ENTITY Entprellmodul IS

	Port(clk, button : in Std_logic;
		PB : out std_logic
		);
END Entprellmodul;


Architecture behav Of Entprellmodul Is

Signal tmp : std_logic_vector (0 to 19);

Begin

	Process(clk)
	Begin
		
		IF button='1' THEN
			tmp<="00000000000000000000";
			PB <= '1';
		ElsIf (rising_edge(clk)) THEN
			If (tmp = "11111111111111111111")THEN 
				PB<= '0';
			ELSE 
				tmp<=tmp+1;
			END IF;
		END IF;
		
	END PROCESS;
END behav;
		
		

