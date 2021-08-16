library verilog;
use verilog.vl_types.all;
entity final_counter is
    port(
        scaler          : in     vl_logic;
        reset           : in     vl_logic;
        counter         : in     vl_logic_vector(2 downto 0);
        tick            : out    vl_logic
    );
end final_counter;
