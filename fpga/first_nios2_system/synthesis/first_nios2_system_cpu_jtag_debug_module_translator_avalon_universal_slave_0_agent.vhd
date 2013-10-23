-- first_nios2_system_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent.vhd

-- Generated using ACDS version 13.0 156 at 2013.10.23.16:46:51

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity first_nios2_system_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent is
	generic (
		PKT_DATA_H                : integer := 31;
		PKT_DATA_L                : integer := 0;
		PKT_BEGIN_BURST           : integer := 87;
		PKT_SYMBOL_W              : integer := 8;
		PKT_BYTEEN_H              : integer := 35;
		PKT_BYTEEN_L              : integer := 32;
		PKT_ADDR_H                : integer := 67;
		PKT_ADDR_L                : integer := 36;
		PKT_TRANS_COMPRESSED_READ : integer := 68;
		PKT_TRANS_POSTED          : integer := 69;
		PKT_TRANS_WRITE           : integer := 70;
		PKT_TRANS_READ            : integer := 71;
		PKT_TRANS_LOCK            : integer := 72;
		PKT_SRC_ID_H              : integer := 91;
		PKT_SRC_ID_L              : integer := 89;
		PKT_DEST_ID_H             : integer := 94;
		PKT_DEST_ID_L             : integer := 92;
		PKT_BURSTWRAP_H           : integer := 79;
		PKT_BURSTWRAP_L           : integer := 77;
		PKT_BYTE_CNT_H            : integer := 76;
		PKT_BYTE_CNT_L            : integer := 74;
		PKT_PROTECTION_H          : integer := 98;
		PKT_PROTECTION_L          : integer := 96;
		PKT_RESPONSE_STATUS_H     : integer := 104;
		PKT_RESPONSE_STATUS_L     : integer := 103;
		PKT_BURST_SIZE_H          : integer := 82;
		PKT_BURST_SIZE_L          : integer := 80;
		ST_CHANNEL_W              : integer := 7;
		ST_DATA_W                 : integer := 105;
		AVS_BURSTCOUNT_W          : integer := 3;
		SUPPRESS_0_BYTEEN_CMD     : integer := 0;
		PREVENT_FIFO_OVERFLOW     : integer := 1;
		USE_READRESPONSE          : integer := 0;
		USE_WRITERESPONSE         : integer := 0
	);
	port (
		clk                     : in  std_logic                      := '0';             --             clk.clk
		reset                   : in  std_logic                      := '0';             --       clk_reset.reset
		m0_address              : out std_logic_vector(31 downto 0);                     --              m0.address
		m0_burstcount           : out std_logic_vector(2 downto 0);                      --                .burstcount
		m0_byteenable           : out std_logic_vector(3 downto 0);                      --                .byteenable
		m0_debugaccess          : out std_logic;                                         --                .debugaccess
		m0_lock                 : out std_logic;                                         --                .lock
		m0_readdata             : in  std_logic_vector(31 downto 0)  := (others => '0'); --                .readdata
		m0_readdatavalid        : in  std_logic                      := '0';             --                .readdatavalid
		m0_read                 : out std_logic;                                         --                .read
		m0_waitrequest          : in  std_logic                      := '0';             --                .waitrequest
		m0_writedata            : out std_logic_vector(31 downto 0);                     --                .writedata
		m0_write                : out std_logic;                                         --                .write
		rp_endofpacket          : out std_logic;                                         --              rp.endofpacket
		rp_ready                : in  std_logic                      := '0';             --                .ready
		rp_valid                : out std_logic;                                         --                .valid
		rp_data                 : out std_logic_vector(104 downto 0);                    --                .data
		rp_startofpacket        : out std_logic;                                         --                .startofpacket
		cp_ready                : out std_logic;                                         --              cp.ready
		cp_valid                : in  std_logic                      := '0';             --                .valid
		cp_data                 : in  std_logic_vector(104 downto 0) := (others => '0'); --                .data
		cp_startofpacket        : in  std_logic                      := '0';             --                .startofpacket
		cp_endofpacket          : in  std_logic                      := '0';             --                .endofpacket
		cp_channel              : in  std_logic_vector(6 downto 0)   := (others => '0'); --                .channel
		rf_sink_ready           : out std_logic;                                         --         rf_sink.ready
		rf_sink_valid           : in  std_logic                      := '0';             --                .valid
		rf_sink_startofpacket   : in  std_logic                      := '0';             --                .startofpacket
		rf_sink_endofpacket     : in  std_logic                      := '0';             --                .endofpacket
		rf_sink_data            : in  std_logic_vector(105 downto 0) := (others => '0'); --                .data
		rf_source_ready         : in  std_logic                      := '0';             --       rf_source.ready
		rf_source_valid         : out std_logic;                                         --                .valid
		rf_source_startofpacket : out std_logic;                                         --                .startofpacket
		rf_source_endofpacket   : out std_logic;                                         --                .endofpacket
		rf_source_data          : out std_logic_vector(105 downto 0);                    --                .data
		rdata_fifo_sink_ready   : out std_logic;                                         -- rdata_fifo_sink.ready
		rdata_fifo_sink_valid   : in  std_logic                      := '0';             --                .valid
		rdata_fifo_sink_data    : in  std_logic_vector(33 downto 0)  := (others => '0'); --                .data
		rdata_fifo_src_ready    : in  std_logic                      := '0';             --  rdata_fifo_src.ready
		rdata_fifo_src_valid    : out std_logic;                                         --                .valid
		rdata_fifo_src_data     : out std_logic_vector(33 downto 0);                     --                .data
		m0_response             : in  std_logic_vector(1 downto 0)   := (others => '0');
		m0_writeresponserequest : out std_logic;
		m0_writeresponsevalid   : in  std_logic                      := '0'
	);
end entity first_nios2_system_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent;

architecture rtl of first_nios2_system_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent is
	component altera_merlin_slave_agent is
		generic (
			PKT_DATA_H                : integer := 31;
			PKT_DATA_L                : integer := 0;
			PKT_BEGIN_BURST           : integer := 81;
			PKT_SYMBOL_W              : integer := 8;
			PKT_BYTEEN_H              : integer := 71;
			PKT_BYTEEN_L              : integer := 68;
			PKT_ADDR_H                : integer := 63;
			PKT_ADDR_L                : integer := 32;
			PKT_TRANS_COMPRESSED_READ : integer := 67;
			PKT_TRANS_POSTED          : integer := 66;
			PKT_TRANS_WRITE           : integer := 65;
			PKT_TRANS_READ            : integer := 64;
			PKT_TRANS_LOCK            : integer := 87;
			PKT_SRC_ID_H              : integer := 74;
			PKT_SRC_ID_L              : integer := 72;
			PKT_DEST_ID_H             : integer := 77;
			PKT_DEST_ID_L             : integer := 75;
			PKT_BURSTWRAP_H           : integer := 85;
			PKT_BURSTWRAP_L           : integer := 82;
			PKT_BYTE_CNT_H            : integer := 81;
			PKT_BYTE_CNT_L            : integer := 78;
			PKT_PROTECTION_H          : integer := 86;
			PKT_PROTECTION_L          : integer := 86;
			PKT_RESPONSE_STATUS_H     : integer := 89;
			PKT_RESPONSE_STATUS_L     : integer := 88;
			PKT_BURST_SIZE_H          : integer := 92;
			PKT_BURST_SIZE_L          : integer := 90;
			ST_CHANNEL_W              : integer := 8;
			ST_DATA_W                 : integer := 93;
			AVS_BURSTCOUNT_W          : integer := 4;
			SUPPRESS_0_BYTEEN_CMD     : integer := 1;
			PREVENT_FIFO_OVERFLOW     : integer := 0;
			USE_READRESPONSE          : integer := 0;
			USE_WRITERESPONSE         : integer := 0
		);
		port (
			clk                     : in  std_logic                      := 'X';             -- clk
			reset                   : in  std_logic                      := 'X';             -- reset
			m0_address              : out std_logic_vector(31 downto 0);                     -- address
			m0_burstcount           : out std_logic_vector(2 downto 0);                      -- burstcount
			m0_byteenable           : out std_logic_vector(3 downto 0);                      -- byteenable
			m0_debugaccess          : out std_logic;                                         -- debugaccess
			m0_lock                 : out std_logic;                                         -- lock
			m0_readdata             : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- readdata
			m0_readdatavalid        : in  std_logic                      := 'X';             -- readdatavalid
			m0_read                 : out std_logic;                                         -- read
			m0_waitrequest          : in  std_logic                      := 'X';             -- waitrequest
			m0_writedata            : out std_logic_vector(31 downto 0);                     -- writedata
			m0_write                : out std_logic;                                         -- write
			rp_endofpacket          : out std_logic;                                         -- endofpacket
			rp_ready                : in  std_logic                      := 'X';             -- ready
			rp_valid                : out std_logic;                                         -- valid
			rp_data                 : out std_logic_vector(104 downto 0);                    -- data
			rp_startofpacket        : out std_logic;                                         -- startofpacket
			cp_ready                : out std_logic;                                         -- ready
			cp_valid                : in  std_logic                      := 'X';             -- valid
			cp_data                 : in  std_logic_vector(104 downto 0) := (others => 'X'); -- data
			cp_startofpacket        : in  std_logic                      := 'X';             -- startofpacket
			cp_endofpacket          : in  std_logic                      := 'X';             -- endofpacket
			cp_channel              : in  std_logic_vector(6 downto 0)   := (others => 'X'); -- channel
			rf_sink_ready           : out std_logic;                                         -- ready
			rf_sink_valid           : in  std_logic                      := 'X';             -- valid
			rf_sink_startofpacket   : in  std_logic                      := 'X';             -- startofpacket
			rf_sink_endofpacket     : in  std_logic                      := 'X';             -- endofpacket
			rf_sink_data            : in  std_logic_vector(105 downto 0) := (others => 'X'); -- data
			rf_source_ready         : in  std_logic                      := 'X';             -- ready
			rf_source_valid         : out std_logic;                                         -- valid
			rf_source_startofpacket : out std_logic;                                         -- startofpacket
			rf_source_endofpacket   : out std_logic;                                         -- endofpacket
			rf_source_data          : out std_logic_vector(105 downto 0);                    -- data
			rdata_fifo_sink_ready   : out std_logic;                                         -- ready
			rdata_fifo_sink_valid   : in  std_logic                      := 'X';             -- valid
			rdata_fifo_sink_data    : in  std_logic_vector(33 downto 0)  := (others => 'X'); -- data
			rdata_fifo_src_ready    : in  std_logic                      := 'X';             -- ready
			rdata_fifo_src_valid    : out std_logic;                                         -- valid
			rdata_fifo_src_data     : out std_logic_vector(33 downto 0);                     -- data
			m0_response             : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- response
			m0_writeresponserequest : out std_logic;                                         -- writeresponserequest
			m0_writeresponsevalid   : in  std_logic                      := 'X'              -- writeresponsevalid
		);
	end component altera_merlin_slave_agent;

begin

	cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent : component altera_merlin_slave_agent
		generic map (
			PKT_DATA_H                => PKT_DATA_H,
			PKT_DATA_L                => PKT_DATA_L,
			PKT_BEGIN_BURST           => PKT_BEGIN_BURST,
			PKT_SYMBOL_W              => PKT_SYMBOL_W,
			PKT_BYTEEN_H              => PKT_BYTEEN_H,
			PKT_BYTEEN_L              => PKT_BYTEEN_L,
			PKT_ADDR_H                => PKT_ADDR_H,
			PKT_ADDR_L                => PKT_ADDR_L,
			PKT_TRANS_COMPRESSED_READ => PKT_TRANS_COMPRESSED_READ,
			PKT_TRANS_POSTED          => PKT_TRANS_POSTED,
			PKT_TRANS_WRITE           => PKT_TRANS_WRITE,
			PKT_TRANS_READ            => PKT_TRANS_READ,
			PKT_TRANS_LOCK            => PKT_TRANS_LOCK,
			PKT_SRC_ID_H              => PKT_SRC_ID_H,
			PKT_SRC_ID_L              => PKT_SRC_ID_L,
			PKT_DEST_ID_H             => PKT_DEST_ID_H,
			PKT_DEST_ID_L             => PKT_DEST_ID_L,
			PKT_BURSTWRAP_H           => PKT_BURSTWRAP_H,
			PKT_BURSTWRAP_L           => PKT_BURSTWRAP_L,
			PKT_BYTE_CNT_H            => PKT_BYTE_CNT_H,
			PKT_BYTE_CNT_L            => PKT_BYTE_CNT_L,
			PKT_PROTECTION_H          => PKT_PROTECTION_H,
			PKT_PROTECTION_L          => PKT_PROTECTION_L,
			PKT_RESPONSE_STATUS_H     => PKT_RESPONSE_STATUS_H,
			PKT_RESPONSE_STATUS_L     => PKT_RESPONSE_STATUS_L,
			PKT_BURST_SIZE_H          => PKT_BURST_SIZE_H,
			PKT_BURST_SIZE_L          => PKT_BURST_SIZE_L,
			ST_CHANNEL_W              => ST_CHANNEL_W,
			ST_DATA_W                 => ST_DATA_W,
			AVS_BURSTCOUNT_W          => AVS_BURSTCOUNT_W,
			SUPPRESS_0_BYTEEN_CMD     => SUPPRESS_0_BYTEEN_CMD,
			PREVENT_FIFO_OVERFLOW     => PREVENT_FIFO_OVERFLOW,
			USE_READRESPONSE          => USE_READRESPONSE,
			USE_WRITERESPONSE         => USE_WRITERESPONSE
		)
		port map (
			clk                     => clk,                     --             clk.clk
			reset                   => reset,                   --       clk_reset.reset
			m0_address              => m0_address,              --              m0.address
			m0_burstcount           => m0_burstcount,           --                .burstcount
			m0_byteenable           => m0_byteenable,           --                .byteenable
			m0_debugaccess          => m0_debugaccess,          --                .debugaccess
			m0_lock                 => m0_lock,                 --                .lock
			m0_readdata             => m0_readdata,             --                .readdata
			m0_readdatavalid        => m0_readdatavalid,        --                .readdatavalid
			m0_read                 => m0_read,                 --                .read
			m0_waitrequest          => m0_waitrequest,          --                .waitrequest
			m0_writedata            => m0_writedata,            --                .writedata
			m0_write                => m0_write,                --                .write
			rp_endofpacket          => rp_endofpacket,          --              rp.endofpacket
			rp_ready                => rp_ready,                --                .ready
			rp_valid                => rp_valid,                --                .valid
			rp_data                 => rp_data,                 --                .data
			rp_startofpacket        => rp_startofpacket,        --                .startofpacket
			cp_ready                => cp_ready,                --              cp.ready
			cp_valid                => cp_valid,                --                .valid
			cp_data                 => cp_data,                 --                .data
			cp_startofpacket        => cp_startofpacket,        --                .startofpacket
			cp_endofpacket          => cp_endofpacket,          --                .endofpacket
			cp_channel              => cp_channel,              --                .channel
			rf_sink_ready           => rf_sink_ready,           --         rf_sink.ready
			rf_sink_valid           => rf_sink_valid,           --                .valid
			rf_sink_startofpacket   => rf_sink_startofpacket,   --                .startofpacket
			rf_sink_endofpacket     => rf_sink_endofpacket,     --                .endofpacket
			rf_sink_data            => rf_sink_data,            --                .data
			rf_source_ready         => rf_source_ready,         --       rf_source.ready
			rf_source_valid         => rf_source_valid,         --                .valid
			rf_source_startofpacket => rf_source_startofpacket, --                .startofpacket
			rf_source_endofpacket   => rf_source_endofpacket,   --                .endofpacket
			rf_source_data          => rf_source_data,          --                .data
			rdata_fifo_sink_ready   => rdata_fifo_sink_ready,   -- rdata_fifo_sink.ready
			rdata_fifo_sink_valid   => rdata_fifo_sink_valid,   --                .valid
			rdata_fifo_sink_data    => rdata_fifo_sink_data,    --                .data
			rdata_fifo_src_ready    => rdata_fifo_src_ready,    --  rdata_fifo_src.ready
			rdata_fifo_src_valid    => rdata_fifo_src_valid,    --                .valid
			rdata_fifo_src_data     => rdata_fifo_src_data,     --                .data
			m0_response             => "00",                    --     (terminated)
			m0_writeresponserequest => open,                    --     (terminated)
			m0_writeresponsevalid   => '0'                      --     (terminated)
		);

end architecture rtl; -- of first_nios2_system_cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent
