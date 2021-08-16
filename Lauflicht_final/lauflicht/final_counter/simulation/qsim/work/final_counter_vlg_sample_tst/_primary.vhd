library verilog;
use verilog.vl_types.all;
entity final_counter_vlg_sample_tst is
    port(
        counter         : in     vl_logic_vector(2 downto 0);
        reset           : in     vl_logic;
        scaler          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end final_counter_vlg_sample_tst;
