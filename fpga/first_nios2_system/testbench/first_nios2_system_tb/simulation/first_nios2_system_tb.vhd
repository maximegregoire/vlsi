-- first_nios2_system_tb.vhd

-- Generated using ACDS version 13.0 156 at 2013.10.09.16:04:14

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity first_nios2_system_tb is
end entity first_nios2_system_tb;

architecture rtl of first_nios2_system_tb is
	component first_nios2_system is
		port (
			clk_clk                            : in  std_logic                     := 'X';             -- clk
			reset_reset_n                      : in  std_logic                     := 'X';             -- reset_n
			regfile_0_conduit_end_AVINTDIS     : out std_logic;                                        -- AVINTDIS
			regfile_0_conduit_end_T1INTOVR     : out std_logic;                                        -- T1INTOVR
			regfile_0_conduit_end_T1INTSTS     : out std_logic;                                        -- T1INTSTS
			regfile_0_conduit_end_T0INTSTS     : out std_logic;                                        -- T0INTSTS
			regfile_0_conduit_end_T1INTEN      : out std_logic;                                        -- T1INTEN
			regfile_0_conduit_end_T0INTEN      : out std_logic;                                        -- T0INTEN
			regfile_0_conduit_end_T1CNTEN      : out std_logic;                                        -- T1CNTEN
			regfile_0_conduit_end_T0CNTEN      : out std_logic;                                        -- T0CNTEN
			regfile_0_conduit_end_T1RST        : out std_logic;                                        -- T1RST
			regfile_0_conduit_end_T0RST        : out std_logic;                                        -- T0RST
			regfile_0_conduit_end_T0CNT        : out std_logic_vector(31 downto 0);                    -- T0CNT
			regfile_0_conduit_end_T1CNT        : out std_logic_vector(31 downto 0);                    -- T1CNT
			regfile_0_conduit_end_T0CMP        : out std_logic_vector(31 downto 0);                    -- T0CMP
			regfile_0_conduit_end_T1CMP        : out std_logic_vector(31 downto 0);                    -- T1CMP
			regfile_0_conduit_end_GP0          : out std_logic_vector(31 downto 0);                    -- GP0
			regfile_0_conduit_end_GP1          : out std_logic_vector(31 downto 0);                    -- GP1
			regfile_0_conduit_end_T0INT_set    : in  std_logic                     := 'X';             -- T0INT_set
			regfile_0_conduit_end_T1INT_set    : in  std_logic                     := 'X';             -- T1INT_set
			regfile_0_conduit_end_T0CNT_in     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- T0CNT_in
			regfile_0_conduit_end_T1CNT_in     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- T1CNT_in
			regfile_0_conduit_end_avalon_inten : in  std_logic                     := 'X';             -- avalon_inten
			counter_0_conduit_end_count        : out std_logic_vector(31 downto 0);                    -- count
			counter_0_conduit_end_clear        : in  std_logic                     := 'X';             -- clear
			counter_0_conduit_end_count_cmp    : in  std_logic_vector(31 downto 0) := (others => 'X'); -- count_cmp
			counter_0_conduit_end_count_equal  : out std_logic;                                        -- count_equal
			counter_0_conduit_end_enable       : in  std_logic                     := 'X';             -- enable
			counter_1_conduit_end_count        : out std_logic_vector(31 downto 0);                    -- count
			counter_1_conduit_end_clear        : in  std_logic                     := 'X';             -- clear
			counter_1_conduit_end_count_cmp    : in  std_logic_vector(31 downto 0) := (others => 'X'); -- count_cmp
			counter_1_conduit_end_count_equal  : out std_logic;                                        -- count_equal
			counter_1_conduit_end_enable       : in  std_logic                     := 'X'              -- enable
		);
	end component first_nios2_system;

	component altera_avalon_clock_source is
		generic (
			CLOCK_RATE : positive := 10;
			CLOCK_UNIT : positive := 1000000
		);
		port (
			clk : out std_logic   -- clk
		);
	end component altera_avalon_clock_source;

	component altera_avalon_reset_source is
		generic (
			ASSERT_HIGH_RESET    : integer := 1;
			INITIAL_RESET_CYCLES : integer := 0
		);
		port (
			reset : out std_logic;        -- reset_n
			clk   : in  std_logic := 'X'  -- clk
		);
	end component altera_avalon_reset_source;

	component altera_conduit_bfm is
		port (
			clk              : in  std_logic                     := 'X';             -- clk
			reset            : in  std_logic                     := 'X';             -- reset
			sig_AVINTDIS     : in  std_logic                     := 'X';             -- AVINTDIS
			sig_T1INTOVR     : in  std_logic                     := 'X';             -- T1INTOVR
			sig_T1INTSTS     : in  std_logic                     := 'X';             -- T1INTSTS
			sig_T0INTSTS     : in  std_logic                     := 'X';             -- T0INTSTS
			sig_T1INTEN      : in  std_logic                     := 'X';             -- T1INTEN
			sig_T0INTEN      : in  std_logic                     := 'X';             -- T0INTEN
			sig_T1CNTEN      : in  std_logic                     := 'X';             -- T1CNTEN
			sig_T0CNTEN      : in  std_logic                     := 'X';             -- T0CNTEN
			sig_T1RST        : in  std_logic                     := 'X';             -- T1RST
			sig_T0RST        : in  std_logic                     := 'X';             -- T0RST
			sig_T0CNT        : in  std_logic_vector(31 downto 0) := (others => 'X'); -- T0CNT
			sig_T1CNT        : in  std_logic_vector(31 downto 0) := (others => 'X'); -- T1CNT
			sig_T0CMP        : in  std_logic_vector(31 downto 0) := (others => 'X'); -- T0CMP
			sig_T1CMP        : in  std_logic_vector(31 downto 0) := (others => 'X'); -- T1CMP
			sig_GP0          : in  std_logic_vector(31 downto 0) := (others => 'X'); -- GP0
			sig_GP1          : in  std_logic_vector(31 downto 0) := (others => 'X'); -- GP1
			sig_T0INT_set    : out std_logic;                                        -- T0INT_set
			sig_T1INT_set    : out std_logic;                                        -- T1INT_set
			sig_T0CNT_in     : out std_logic_vector(31 downto 0);                    -- T0CNT_in
			sig_T1CNT_in     : out std_logic_vector(31 downto 0);                    -- T1CNT_in
			sig_avalon_inten : out std_logic                                         -- avalon_inten
		);
	end component altera_conduit_bfm;

	component altera_conduit_bfm_0002 is
		port (
			clk             : in  std_logic                     := 'X';             -- clk
			reset           : in  std_logic                     := 'X';             -- reset
			sig_count       : in  std_logic_vector(31 downto 0) := (others => 'X'); -- count
			sig_clear       : out std_logic;                                        -- clear
			sig_count_cmp   : out std_logic_vector(31 downto 0);                    -- count_cmp
			sig_count_equal : in  std_logic                     := 'X';             -- count_equal
			sig_enable      : out std_logic                                         -- enable
		);
	end component altera_conduit_bfm_0002;

	signal first_nios2_system_inst_clk_bfm_clk_clk                                : std_logic;                     -- first_nios2_system_inst_clk_bfm:clk -> [first_nios2_system_inst:clk_clk, first_nios2_system_inst_counter_0_conduit_end_bfm:clk, first_nios2_system_inst_counter_1_conduit_end_bfm:clk, first_nios2_system_inst_regfile_0_conduit_end_bfm:clk, first_nios2_system_inst_reset_bfm:clk]
	signal first_nios2_system_inst_reset_bfm_reset_reset                          : std_logic;                     -- first_nios2_system_inst_reset_bfm:reset -> [first_nios2_system_inst:reset_reset_n, first_nios2_system_inst_reset_bfm_reset_reset:in]
	signal first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_t1cnt_in     : std_logic_vector(31 downto 0); -- first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1CNT_in -> first_nios2_system_inst:regfile_0_conduit_end_T1CNT_in
	signal first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_t1int_set    : std_logic;                     -- first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1INT_set -> first_nios2_system_inst:regfile_0_conduit_end_T1INT_set
	signal first_nios2_system_inst_regfile_0_conduit_end_t0cmp                    : std_logic_vector(31 downto 0); -- first_nios2_system_inst:regfile_0_conduit_end_T0CMP -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T0CMP
	signal first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_avalon_inten : std_logic;                     -- first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_avalon_inten -> first_nios2_system_inst:regfile_0_conduit_end_avalon_inten
	signal first_nios2_system_inst_regfile_0_conduit_end_t1intsts                 : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T1INTSTS -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1INTSTS
	signal first_nios2_system_inst_regfile_0_conduit_end_t0intsts                 : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T0INTSTS -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T0INTSTS
	signal first_nios2_system_inst_regfile_0_conduit_end_t0cnt                    : std_logic_vector(31 downto 0); -- first_nios2_system_inst:regfile_0_conduit_end_T0CNT -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T0CNT
	signal first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_t0int_set    : std_logic;                     -- first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T0INT_set -> first_nios2_system_inst:regfile_0_conduit_end_T0INT_set
	signal first_nios2_system_inst_regfile_0_conduit_end_t1cnt                    : std_logic_vector(31 downto 0); -- first_nios2_system_inst:regfile_0_conduit_end_T1CNT -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1CNT
	signal first_nios2_system_inst_regfile_0_conduit_end_t1cmp                    : std_logic_vector(31 downto 0); -- first_nios2_system_inst:regfile_0_conduit_end_T1CMP -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1CMP
	signal first_nios2_system_inst_regfile_0_conduit_end_t1intovr                 : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T1INTOVR -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1INTOVR
	signal first_nios2_system_inst_regfile_0_conduit_end_t0inten                  : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T0INTEN -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T0INTEN
	signal first_nios2_system_inst_regfile_0_conduit_end_t1rst                    : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T1RST -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1RST
	signal first_nios2_system_inst_regfile_0_conduit_end_gp1                      : std_logic_vector(31 downto 0); -- first_nios2_system_inst:regfile_0_conduit_end_GP1 -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_GP1
	signal first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_t0cnt_in     : std_logic_vector(31 downto 0); -- first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T0CNT_in -> first_nios2_system_inst:regfile_0_conduit_end_T0CNT_in
	signal first_nios2_system_inst_regfile_0_conduit_end_gp0                      : std_logic_vector(31 downto 0); -- first_nios2_system_inst:regfile_0_conduit_end_GP0 -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_GP0
	signal first_nios2_system_inst_regfile_0_conduit_end_t1inten                  : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T1INTEN -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1INTEN
	signal first_nios2_system_inst_regfile_0_conduit_end_t1cnten                  : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T1CNTEN -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T1CNTEN
	signal first_nios2_system_inst_regfile_0_conduit_end_t0cnten                  : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T0CNTEN -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T0CNTEN
	signal first_nios2_system_inst_regfile_0_conduit_end_t0rst                    : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_T0RST -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_T0RST
	signal first_nios2_system_inst_regfile_0_conduit_end_avintdis                 : std_logic;                     -- first_nios2_system_inst:regfile_0_conduit_end_AVINTDIS -> first_nios2_system_inst_regfile_0_conduit_end_bfm:sig_AVINTDIS
	signal first_nios2_system_inst_counter_0_conduit_end_bfm_conduit_clear        : std_logic;                     -- first_nios2_system_inst_counter_0_conduit_end_bfm:sig_clear -> first_nios2_system_inst:counter_0_conduit_end_clear
	signal first_nios2_system_inst_counter_0_conduit_end_count                    : std_logic_vector(31 downto 0); -- first_nios2_system_inst:counter_0_conduit_end_count -> first_nios2_system_inst_counter_0_conduit_end_bfm:sig_count
	signal first_nios2_system_inst_counter_0_conduit_end_bfm_conduit_enable       : std_logic;                     -- first_nios2_system_inst_counter_0_conduit_end_bfm:sig_enable -> first_nios2_system_inst:counter_0_conduit_end_enable
	signal first_nios2_system_inst_counter_0_conduit_end_bfm_conduit_count_cmp    : std_logic_vector(31 downto 0); -- first_nios2_system_inst_counter_0_conduit_end_bfm:sig_count_cmp -> first_nios2_system_inst:counter_0_conduit_end_count_cmp
	signal first_nios2_system_inst_counter_0_conduit_end_count_equal              : std_logic;                     -- first_nios2_system_inst:counter_0_conduit_end_count_equal -> first_nios2_system_inst_counter_0_conduit_end_bfm:sig_count_equal
	signal first_nios2_system_inst_counter_1_conduit_end_bfm_conduit_clear        : std_logic;                     -- first_nios2_system_inst_counter_1_conduit_end_bfm:sig_clear -> first_nios2_system_inst:counter_1_conduit_end_clear
	signal first_nios2_system_inst_counter_1_conduit_end_count                    : std_logic_vector(31 downto 0); -- first_nios2_system_inst:counter_1_conduit_end_count -> first_nios2_system_inst_counter_1_conduit_end_bfm:sig_count
	signal first_nios2_system_inst_counter_1_conduit_end_bfm_conduit_enable       : std_logic;                     -- first_nios2_system_inst_counter_1_conduit_end_bfm:sig_enable -> first_nios2_system_inst:counter_1_conduit_end_enable
	signal first_nios2_system_inst_counter_1_conduit_end_bfm_conduit_count_cmp    : std_logic_vector(31 downto 0); -- first_nios2_system_inst_counter_1_conduit_end_bfm:sig_count_cmp -> first_nios2_system_inst:counter_1_conduit_end_count_cmp
	signal first_nios2_system_inst_counter_1_conduit_end_count_equal              : std_logic;                     -- first_nios2_system_inst:counter_1_conduit_end_count_equal -> first_nios2_system_inst_counter_1_conduit_end_bfm:sig_count_equal
	signal first_nios2_system_inst_reset_bfm_reset_reset_ports_inv                : std_logic;                     -- first_nios2_system_inst_reset_bfm_reset_reset:inv -> [first_nios2_system_inst_counter_0_conduit_end_bfm:reset, first_nios2_system_inst_counter_1_conduit_end_bfm:reset, first_nios2_system_inst_regfile_0_conduit_end_bfm:reset]
	
	
	signal count_0 : std_logic_vector(31 downto 0);
	signal count_0_cmp : std_logic_vector(31 downto 0);
	signal count_0_equal : std_logic;
	signal count_0_clear : std_logic;
	signal count_0_en : std_logic;
	
	signal count_1 : std_logic_vector(31 downto 0);
	signal count_1_cmp : std_logic_vector(31 downto 0);
	signal count_1_equal : std_logic;
	signal count_1_clear : std_logic;
	signal count_1_en : std_logic;
	
	-- 0 - POLL     1 - AVALON
	signal avalon_int_en : std_logic := '1';

begin

	first_nios2_system_inst : component first_nios2_system
		port map (
			clk_clk                            => first_nios2_system_inst_clk_bfm_clk_clk,                                --                   clk.clk
			reset_reset_n                      => first_nios2_system_inst_reset_bfm_reset_reset,                          --                 reset.reset_n
			regfile_0_conduit_end_AVINTDIS     => first_nios2_system_inst_regfile_0_conduit_end_avintdis,                 -- regfile_0_conduit_end.AVINTDIS
			regfile_0_conduit_end_T1INTOVR     => first_nios2_system_inst_regfile_0_conduit_end_t1intovr,                 --                      .T1INTOVR
			regfile_0_conduit_end_T1INTSTS     => first_nios2_system_inst_regfile_0_conduit_end_t1intsts,                 --                      .T1INTSTS
			regfile_0_conduit_end_T0INTSTS     => first_nios2_system_inst_regfile_0_conduit_end_t0intsts,                 --                      .T0INTSTS
			regfile_0_conduit_end_T1INTEN      => first_nios2_system_inst_regfile_0_conduit_end_t1inten,                  --                      .T1INTEN
			regfile_0_conduit_end_T0INTEN      => first_nios2_system_inst_regfile_0_conduit_end_t0inten,                  --                      .T0INTEN
			regfile_0_conduit_end_T1CNTEN      => count_1_en,  		               --                      .T1CNTEN
			regfile_0_conduit_end_T0CNTEN      => count_0_en,			                 --                      .T0CNTEN
			regfile_0_conduit_end_T1RST        => count_1_clear,                   --                      .T1RST
			regfile_0_conduit_end_T0RST        => count_0_clear,                   --                      .T0RST
			regfile_0_conduit_end_T0CNT        => first_nios2_system_inst_regfile_0_conduit_end_t0cnt,                    --                      .T0CNT
			regfile_0_conduit_end_T1CNT        => first_nios2_system_inst_regfile_0_conduit_end_t1cnt,                    --                      .T1CNT
			regfile_0_conduit_end_T0CMP        => count_0_cmp,                    --                      .T0CMP
			regfile_0_conduit_end_T1CMP        => count_1_cmp,                    --                      .T1CMP
			regfile_0_conduit_end_GP0          => first_nios2_system_inst_regfile_0_conduit_end_gp0,                      --                      .GP0
			regfile_0_conduit_end_GP1          => first_nios2_system_inst_regfile_0_conduit_end_gp1,                      --                      .GP1
			regfile_0_conduit_end_T0INT_set    => count_0_equal,  	    --                      .T0INT_set
			regfile_0_conduit_end_T1INT_set    => count_1_equal,       --                      .T1INT_set
			regfile_0_conduit_end_T0CNT_in     => count_0,   		    --                      .T0CNT_in
			regfile_0_conduit_end_T1CNT_in     => count_1,    		    --                      .T1CNT_in
			regfile_0_conduit_end_avalon_inten => avalon_int_en, --                      .avalon_inten
			counter_0_conduit_end_count        => count_0,          -- counter_0_conduit_end.count
			counter_0_conduit_end_clear        => count_0_clear,    --                      .clear
			counter_0_conduit_end_count_cmp    => count_0_cmp,      --                      .count_cmp
			counter_0_conduit_end_count_equal  => count_0_equal,    --                      .count_equal
			counter_0_conduit_end_enable       => count_0_en,       --                      .enable
			counter_1_conduit_end_count        => count_1,          -- counter_1_conduit_end.count
			counter_1_conduit_end_clear        => count_1_clear,    --                      .clear
			counter_1_conduit_end_count_cmp    => count_1_cmp,      --                      .count_cmp
			counter_1_conduit_end_count_equal  => count_1_equal,    --                      .count_equal
			counter_1_conduit_end_enable       => count_1_en        --                      .enable
		);

	first_nios2_system_inst_clk_bfm : component altera_avalon_clock_source
		generic map (
			CLOCK_RATE => 50000000,
			CLOCK_UNIT => 1
		)
		port map (
			clk => first_nios2_system_inst_clk_bfm_clk_clk  -- clk.clk
		);

	first_nios2_system_inst_reset_bfm : component altera_avalon_reset_source
		generic map (
			ASSERT_HIGH_RESET    => 0,
			INITIAL_RESET_CYCLES => 50
		)
		port map (
			reset => first_nios2_system_inst_reset_bfm_reset_reset, -- reset.reset_n
			clk   => first_nios2_system_inst_clk_bfm_clk_clk        --   clk.clk
		);

	first_nios2_system_inst_regfile_0_conduit_end_bfm : component altera_conduit_bfm
		port map (
			clk              => first_nios2_system_inst_clk_bfm_clk_clk,                                --     clk.clk
			reset            => first_nios2_system_inst_reset_bfm_reset_reset_ports_inv,                --   reset.reset
			sig_AVINTDIS     => first_nios2_system_inst_regfile_0_conduit_end_avintdis,                 -- conduit.AVINTDIS
			sig_T1INTOVR     => first_nios2_system_inst_regfile_0_conduit_end_t1intovr,                 --        .T1INTOVR
			sig_T1INTSTS     => first_nios2_system_inst_regfile_0_conduit_end_t1intsts,                 --        .T1INTSTS
			sig_T0INTSTS     => first_nios2_system_inst_regfile_0_conduit_end_t0intsts,                 --        .T0INTSTS
			sig_T1INTEN      => first_nios2_system_inst_regfile_0_conduit_end_t1inten,                  --        .T1INTEN
			sig_T0INTEN      => first_nios2_system_inst_regfile_0_conduit_end_t0inten,                  --        .T0INTEN
			sig_T1CNTEN      => first_nios2_system_inst_regfile_0_conduit_end_t1cnten,                  --        .T1CNTEN
			sig_T0CNTEN      => first_nios2_system_inst_regfile_0_conduit_end_t0cnten,                  --        .T0CNTEN
			sig_T1RST        => first_nios2_system_inst_regfile_0_conduit_end_t1rst,                    --        .T1RST
			sig_T0RST        => first_nios2_system_inst_regfile_0_conduit_end_t0rst,                    --        .T0RST
			sig_T0CNT        => first_nios2_system_inst_regfile_0_conduit_end_t0cnt,                    --        .T0CNT
			sig_T1CNT        => first_nios2_system_inst_regfile_0_conduit_end_t1cnt,                    --        .T1CNT
			sig_T0CMP        => first_nios2_system_inst_regfile_0_conduit_end_t0cmp,                    --        .T0CMP
			sig_T1CMP        => first_nios2_system_inst_regfile_0_conduit_end_t1cmp,                    --        .T1CMP
			sig_GP0          => first_nios2_system_inst_regfile_0_conduit_end_gp0,                      --        .GP0
			sig_GP1          => first_nios2_system_inst_regfile_0_conduit_end_gp1,                      --        .GP1
			sig_T0INT_set    => first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_t0int_set,    --        .T0INT_set
			sig_T1INT_set    => first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_t1int_set,    --        .T1INT_set
			sig_T0CNT_in     => first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_t0cnt_in,     --        .T0CNT_in
			sig_T1CNT_in     => first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_t1cnt_in,     --        .T1CNT_in
			sig_avalon_inten => first_nios2_system_inst_regfile_0_conduit_end_bfm_conduit_avalon_inten  --        .avalon_inten
		);

	first_nios2_system_inst_counter_0_conduit_end_bfm : component altera_conduit_bfm_0002
		port map (
			clk             => first_nios2_system_inst_clk_bfm_clk_clk,                             --     clk.clk
			reset           => first_nios2_system_inst_reset_bfm_reset_reset_ports_inv,             --   reset.reset
			sig_count       => first_nios2_system_inst_counter_0_conduit_end_count,                 -- conduit.count
			sig_clear       => first_nios2_system_inst_counter_0_conduit_end_bfm_conduit_clear,     --        .clear
			sig_count_cmp   => first_nios2_system_inst_counter_0_conduit_end_bfm_conduit_count_cmp, --        .count_cmp
			sig_count_equal => first_nios2_system_inst_counter_0_conduit_end_count_equal,           --        .count_equal
			sig_enable      => first_nios2_system_inst_counter_0_conduit_end_bfm_conduit_enable     --        .enable
		);

	first_nios2_system_inst_counter_1_conduit_end_bfm : component altera_conduit_bfm_0002
		port map (
			clk             => first_nios2_system_inst_clk_bfm_clk_clk,                             --     clk.clk
			reset           => first_nios2_system_inst_reset_bfm_reset_reset_ports_inv,             --   reset.reset
			sig_count       => first_nios2_system_inst_counter_1_conduit_end_count,                 -- conduit.count
			sig_clear       => first_nios2_system_inst_counter_1_conduit_end_bfm_conduit_clear,     --        .clear
			sig_count_cmp   => first_nios2_system_inst_counter_1_conduit_end_bfm_conduit_count_cmp, --        .count_cmp
			sig_count_equal => first_nios2_system_inst_counter_1_conduit_end_count_equal,           --        .count_equal
			sig_enable      => first_nios2_system_inst_counter_1_conduit_end_bfm_conduit_enable     --        .enable
		);

	first_nios2_system_inst_reset_bfm_reset_reset_ports_inv <= not first_nios2_system_inst_reset_bfm_reset_reset;

end architecture rtl; -- of first_nios2_system_tb
