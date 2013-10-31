-- ************ IMPORTANT NOTICE *************
-- NOTE1: The initialization sequence has been adapted for a the Avalon memory
--        controller.
-- NOTE2: The "ADDRESS DATA" format read and written by this model 
--        should comply with the definition found in the assignment.
-- NOTE3: This model has originally been designed for an open page architecture,
--        supporting one open page at a time.

--*****************************************************************************
--   Description  :   PIPELINED SYNCHRONOUS DRAM 4Mx16 (64 Mbits density)
--*****************************************************************************
library ieee;
library work;

use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.sdrampack.all;

entity sdramsdr is

  generic(
    DUMPFILE : string := "/dev/null";
    LOADFILE : string := "/dev/null"
    );
  port(
    resetN : in    std_logic;
    sa     : in    std_logic_vector(11 downto 0);
    sbs    : in    std_logic_vector(1 downto 0);
    scasN  : in    std_logic;
    scke   : in    std_logic;
    sclk   : in    std_logic;
    scsN   : in    std_logic;
    sdqm   : in    std_logic_vector(1 downto 0);
    dump   : in    std_logic;
    load   : in    std_logic;
    srasN  : in    std_logic;
    sweN   : in    std_logic;
    sd     : inout std_logic_vector(15 downto 0)
    );
begin

end sdramsdr;

architecture functional of sdramsdr is

  
  type modeName is(
    UNINITIALIZED,
    POWER_ON,
    COMMAND
    );

  type commandName is(
    DESL,                               --  No command
    NOP,                                --  Do nothing
    BST,                                --  Burst stop (for page mode, N.S.)
    READ,                               --  Read burst of data
    READA,                              --  Read with auto-precharge(N.S.)
    WRIT,                               --  Write burst of data
    WRITA,                              --  Write with auto-precharge (N.S.)
    ACT,                                --  Row activate (select a row)
    PRE,                                --  Precharge selected bank
    PALL,                               --  Precharge all bank
    MRS,                                --  Mode Register Set
    REF                                 --  CBR refresh
    );
  type bankStatus is (
    IDLE,                               --  bank are  precharged
    ROW_ACTIVATING,                     --  charging row in sense amp.
    ROW_ACTIVE,                         --  ready for column accessing
    READING,                            --  memory is in burst read
    READING_A,                          --  read Auto-Pre.(AP) posted->N.S.
    WRITING,                            --  memory is in write burst
    WRITE_RECOVERING,                   --  data being written in sense amp.
    WRITING_A,                          --  (see writing) AP is posted->N.S.
    WRITE_RECOVERING_A,                 --  (see write_recovering)->N.S.
    PRECHARGING,                        --  writing row in the memory bank
    REFRESHING,                         --  refreshing(ACT+PRE)
    MODE_REGISTER_ACCESSING             --  setting mode, burst_length,etc.
    );

  type memEntry;
  type entryPtr is access memEntry;
  type memEntry is record
    address   : integer;
    data      : std_logic_vector(15 downto 0);
    nextEntry : entryPtr;
  end record;
  type head is record
    numEntries : integer;
    listPtr    : entryPtr;
  end record;
  type headPtr is access head;
  type midList is record
    leftNew  : integer;
    rightNew : integer;
    listPtr  : entryPtr;
  end record;
  type midListPtr is access midList;

  subtype rowAdr is std_logic_vector(11 downto 0);

  type typeBankState is array (0 to 3) of bankStatus;
  type rowBank is array (0 to 3) of rowAdr;
  type time2d is array (0 to 3) of time;

  constant modele : string                        := "SDRAMSDR, ";
  constant allXs  : std_logic_vector(15 downto 0) := "XXXXXXXXXXXXXXXX";

  signal MSG69_inhibit : boolean   := false;
  signal action        : commandName;   --  memory command 
  signal bankState     : TypeBankState;     --  double reg. for state of banks
  signal burstBank     : integer range 0 to 3;  --  memorize the bank that is bursting
  signal burstEnd      : boolean;  --  High when the burst is ending this cycle
  signal checkReWRite  : boolean   := true;
  signal colAdr        : std_logic_vector(7 downto 0);  -- column register
  signal firstWrite    : std_logic := '0';  --  high after the first write to mem.
  signal mode          : modeName;      --  memory mode
  signal powOnState    : bankStatus;    --  bank state on power on
  signal readMem       : std_logic := '0';  --  read strobe
  signal refresh       : std_logic := '0';  --  trig value after each REF command.
  signal reset1N       : std_logic;
  signal rfhViolation  : std_logic := '0';  --  high when refresh violation
  signal rowsAdr       : rowBank;       --  double row register(1 per bank)
  signal scasNI        : std_logic;     --   Transform scasN 'H'/'L' to '1'/'0'
  signal scsNI         : std_logic;  --   Transform scsN 'H'/'L' to '1'/'0'-> not anymore!!!
  signal sdqmD1        : std_logic_vector(1 downto 0);  --   sdqmI delayed by 1 clock cycle
  signal sdqmD2        : std_logic_vector(1 downto 0);  --   sdqmI delayed by 2 clock cycles
  signal sdqmI         : std_logic_vector(1 downto 0);
  signal dumpI         : std_logic;
  signal loadI         : std_logic;
  signal setSclkPeriod : std_logic := '0';  --  trig setting of CLK_PERIOD
  signal setupTiming   : std_logic := '0';
  signal setupTiming1  : std_logic := '0';
  signal srasNI        : std_logic;     --   Transform srasN 'H'/'L' to '1'/'0'
  signal sweNI         : std_logic;     --   Transform sweN 'H'/'L' to '1'/'0'
  signal trigMe        : boolean;       --  trigs the DO_COMMAND process
  signal writeMem      : std_logic := '0';  --  write strobe

------------------------------------------------------------------------------
-- ***************   IMPORTANT ***********************************************
-- Default value for device specific timings. In order to support several
-- configuration or a specific SDRAM technology, the following signal might need
-- to be modified. A dynamic way (at run time) to modify them is recommanded.
------------------------------------------------------------------------------
  signal BURST_LENGTH      : integer := 1;
  signal CAS_LATENCY       : integer := 3;
  signal CLK_PERIOD        : time    := 10 ns;
  signal DUMMY_REF_MIN     : integer := 2;          -- dummy refresh after MRS
  signal IRSA              : time;  -- Idle cycles between MRS and first refresh
  signal IRSA_PER          : integer := 4;
  signal RFH_PERIOD        : time    := 64 ms;
  signal TAC               : time    := 3 ns;       -- Access time from clock
  signal TDPL              : time;      -- writ_rec->row_act 
  signal TDPL_PER          : integer := 2;
  signal THZ               : time    := 6 ns;
  signal TLZ               : time    := 0 ns;
  signal TOH               : time    := 4 ns;
  signal TRAS_CAS2_MIN     : time;  --  act to prechage min. interval with cas latency of 2
  signal TRAS_CAS2_MIN_PER : integer := 5;
  signal TRAS_CAS3_MIN     : time;  --  act to prechage min. interval with cas latency of 3
  signal TRAS_CAS3_MIN_PER : integer := 4;
  signal TRAS_MAX          : time    := 120000 ns;  --  act to precharge maximum interval
  signal TRC               : time;      --  refreshing->idle
  signal TRCD              : time;      --  row_activating->row_active
  signal TRCD_PER          : integer := 2;
  signal TRC_PER           : integer := 7;
  signal TRP               : time;      --  pre->idle
  signal TRP_PER           : integer := 2;
  signal TRRD              : time;      --  act(0) to act(1) min. interval
  signal TRRD_PER          : integer := 2;

  alias preSel  : std_logic is sa(10);  --  selected PRE or PALL
  alias autoPre : std_logic is sa(10);  --  AP if high
  alias rowVec  : std_logic_vector(11 downto 0) is sa(11 downto 0);
  alias colVec  : std_logic_vector(7 downto 0) is sa(7 downto 0);


-------------------------------------------------------------------------------
--  Fait des "assertions" de commentaires VHDL
-------------------------------------------------------------------------------
  procedure assertmsg (comment : string; level : severity_level) is

    variable message : line;

  begin

    write(message, modele);
    write(message, now);
    write(message, string'(", "));
    write(message, comment);
    assert false
      report message(message'range)
      severity level;
    
  end assertmsg;


-------------------------------------------------------------------------------
--  Selectionne la commande a chaque montee d'horloge
-------------------------------------------------------------------------------
  function selectCommand (signal scsN, scasN, srasN, sweN, preSel, autoPre : std_logic;
                          bs                                               : std_logic_vector(1 downto 0))
    return commandName                  --  PS. Valid ONLY if CKE is HIGH.
  is
  begin
    if (scsN = '1' or scsN = 'H') then
      return (DESL);
    elsif (scsN = '0' and scasN = '1' and srasN = '1' and sweN = '1') then
      return (NOP);
    elsif (scsN = '0' and scasN = '1' and srasN = '1' and sweN = '0') then
      return (bsT);
    elsif (scsN = '0' and scasN = '0' and srasN = '1' and sweN = '1') then
      if (autoPre = '0') then
        return (READ);
      elsif (autoPre = '1') then
        return (READA);
      else
        assertmsg("MSG1: Bad level on auto-precharge pin", error);
        return (DESL);                  --  default:simulation can continue
      end if;
    elsif (scsN = '0' and scasN = '0' and srasN = '1' and sweN = '0') then
      if (autoPre = '0') then
        return (WRIT);
      elsif (autoPre = '1') then
        return (WRITA);
      else
        assertmsg("MSG2: Bad level on auto-precharge pin", error);
        return(DESL);                   --  default:simulation can continue
      end if;
    elsif (scsN = '0' and scasN = '1' and srasN = '0' and sweN = '1') then
      return (ACT);
    elsif (scsN = '0' and scasN = '1' and srasN = '0' and sweN = '0') then
      if (preSel = '0') then
        if (bs(0) /= '0' and bs(0) /= '1' and bs(1) /= '0' and bs(1) /= '1') then
          assertmsg("MSG3: Bad level on BS pin: command ignored", error);
          return (DESL);
        end if;
        return (PRE);
      elsif (preSel = '1') then
        return (PALL);
      else
        assertmsg("MSG4: Bad level on precharge pin", error);
        return(DESL);                   --  default:simulation can continue
      end if;
    elsif (scsN = '0' and scasN = '0' and srasN = '0' and sweN = '1') then
      return (REF);
    elsif (scsN = '0' and scasN = '0' and srasN = '0' and sweN = '0') then
      return (MRS);
    else
      assertmsg("MSG5: No CMD associated with level on cs,ras,cas and we)", error);
      return(DESL);                     --  default:simulation can continue
    end if;
  end selectCommand;


-------------------------------------------------------------------------------
--  Tient compte du byte mask(sdqmI) lors de l'ecriture d'un element memoire de
--  la liste chainee.
-------------------------------------------------------------------------------
  function writeData (oldData, newData, byteMask : std_logic_vector)
    return std_logic_vector is

    variable result    : std_logic_vector(oldData'range);
    variable badEnable : boolean := false;

  begin

    for i in byteMask'range loop
      if (byteMask(i) = '0') then
        for j in (i+1)*8-1 downto i*8 loop
          result(j) := newData(j);
        end loop;
      elsif (byteMask(i) = '1') then
        for j in (i+1)*8-1 downto i*8 loop
          result(j) := oldData(j);
        end loop;
      else
        badEnable := true;
      end if;
    end loop;

    if (badEnable = true) then
      assertmsg("MSG5A: Byte enables are not all at a valid logic level (1 or 0).", error);
    end if;
    return (result);

  end writeData;


-------------------------------------------------------------------------------
--  Verifie qu'un vecteur de type "std_logic_vector" ne contient que des
--  elements a '0' ou a '1'
-------------------------------------------------------------------------------
  function is0or1 (vecteur : std_logic_vector) return boolean is

  begin
    
    for i in vecteur'range loop
      if (vecteur(i) /= '0' and vecteur(i) /= '1') then
        return (false);
      end if;
    end loop;
    return (true);
  end is0or1;

-------------------------------------------------------------------------------
--  Verifie qu'un std_logic ne contient est a un niveau '0' ou  '1'
-------------------------------------------------------------------------------
  function is0or1 (element : std_logic) return boolean is

  begin
    
    if (element /= '0' and element /= '1') then
      return (false);
    end if;
    return (true);
  end is0or1;


begin  --  architecture


  sdqmI  <= To_X01(sdqm);
  scsNI  <= scsN;
  scasNI <= To_X01(scasN);
  srasNI <= To_X01(srasN);
  sweNI  <= To_X01(sweN);
  dumpI  <= dump;
  loadI  <= load;

-------------------------------------------------------------------------------
-- Process: reset_1
-- Purpose: Resynchronize the reset.
-------------------------------------------------------------------------------
  reset_1 : process (sclk)

  begin  --  process reset_1

    if (sclk = '1' and sclk'event) then
      reset1N <= resetN;
    end if;
    
  end process reset_1;


-------------------------------------------------------------------------------
-- Process: SETUP_SDRAM_TIMING
-- Purpose:SDRAM access rules.
-------------------------------------------------------------------------------
  SETUP_SDRAM_TIMING : process (setupTiming, setupTiming1)

  begin  --  process SETUP_SDRAM_TIMING

    if ((setupTiming = '1' and setupTiming'event) or (setupTiming1 = '1' and setUpTiming1'event)) then
      TDPL          <= TDPL_PER * CLK_PERIOD;
      TRAS_CAS2_MIN <= TRAS_CAS2_MIN_PER * CLK_PERIOD;
      TRAS_CAS3_MIN <= TRAS_CAS3_MIN_PER * CLK_PERIOD;
      IRSA          <= IRSA_PER * CLK_PERIOD;
      TRC           <= TRC_PER * CLK_PERIOD;
      TRCD          <= TRCD_PER * CLK_PERIOD;
      TRP           <= TRP_PER * CLK_PERIOD;
      TRRD          <= TRRD_PER * CLK_PERIOD;
    end if;
    
  end process SETUP_SDRAM_TIMING;

----------------------------------------------------------------------------
--  Process:   MEM_MODE
--  Purpose:   select the functionnal memory mode
--  Inputs:    sclk,resetN
--  Outputs:   action,trigMe,sd,mode
----------------------------------------------------------------------------
  MEM_MODE : process(sclk, resetN)


    variable registerSet : boolean                      := false;
    variable refCount    : integer                      := 0;
    variable startPowOn  : boolean                      := false;  --  Power on sequence has begun?
    variable actionV     : commandName;  --  like signal action,but a variable
    variable dqmMask     : std_logic_vector(1 downto 0) := (others => '1');
    variable debut_seq   : time;

  begin  --  MEM_MODE

    
    if ((resetN = '1' or resetN = 'H') and reset1N = '0' and resetN'event) then
      setSclkPeriod <= '1', '0' after 1 ns;
    elsif (resetN = '0' and resetN'event) then
      mode        <= UNINITIALIZED;
      registerSet := false;
      startPowOn  := false;
      refCount    := 0;
    end if;
    if (sclk'event and sclk = '1') then
      sdqmD1 <= sdqmI;
      sdqmD2 <= sdqmD1;
    end if;
    case mode is
      when UNINITIALIZED =>
        if (is0or1(scsNI) and is0or1(sdqmI)) then
          mode         <= POWER_ON;
          setupTiming1 <= '1', '0' after 1 ns;
        else
          -- do nothing
        end if;
      when POWER_ON =>
        if (sclk = '1' and sclk'event and (resetN = '1' or resetN = 'H')) then
          actionV := selectCommand(scsNI, scasNI, srasNI, sweNI, preSel, autoPre, sbs);
          case actionV is
            when DESL|NOP =>            --  NOP valid?
              --  Do nothing
            when PALL     =>
              debut_seq := now;
              if (startPowOn = false) then
                powOnState <= PRECHARGING, IDLE after TRP;
                startPowOn := true;
              else
                assertmsg("MSG6: Bad initialization sequence", error);
              end if;
            when MRS =>
              if (powOnState = IDLE and startPowOn = true
                  and registerSet = false) then
                registerSet := true;
                powOnState  <= MODE_REGISTER_ACCESSING,
                              IDLE after IRSA;
                mode <= COMMAND after IRSA;
                if (sa(11 downto 7) /= "00000") then
                  assertmsg("MSG7: sa(11-7) must be '00000' on MRS.", error);
                end if;
                if (CAS_LATENCY = 2) then
                  if (sa(6 downto 4) /= "010") then
                    assertmsg("MSG8: Cas latency is not set to 2.", error);
                  end if;
                elsif (CAS_LATENCY = 3) then
                  if (sa(6 downto 4) /= "011") then
                    assertmsg("MSG8A: Cas latency is not set to 3.", error);
                  end if;
                end if;
                if (sa(3) /= '0') then
                  assertmsg("MSG9: Wrap type MRS isn't sequentiel.", error);
                end if;
                if (sa(2 downto 0) /= "000") then
                  assertmsg("MSG10: Burst length in MSR is not 1.", error);
                end if;
              else
                assertmsg("MSG11: Bad initialization sequence", error);
              end if;
            when REF =>
              if (powOnState = IDLE) then
                refCount := refCount+1;
                if (refCount = DUMMY_REF_MIN) then
                  powOnState <= REFRESHING, IDLE after TRC;
                  assertmsg("MSG12: Memory initialization sequence ends in tRC", note);
--                     if (sdqmI'LAST_EVENT < now-debut_seq+CLK_PERIOD 
--                        or sdqmI /= dqmMask or scke'LAST_EVENT< now-debut_seq+
--                        CLK_PERIOD or scke/='1') then
--                        assertmsg("MSG15: scke and sdqm must be high during initialization",ERROR);
--                     end if;                         
                  if (scke'last_event < now-debut_seq+ CLK_PERIOD or scke /= '1') then
                    assertmsg("MSG15: scke must be high during initialization", error);
                  end if;
                end if;
              else
                assertmsg("MSG13: Bad initialization sequence.", error);
              end if;
            when others =>
              assertmsg("MSG14: Bad initialization sequence.", error);
          end case;
        end if;
        
        
      when COMMAND =>
        if (scke = '1' and sclk = '1' and sclk'event) then
          actionV := selectCommand(scsNI, scasNI, srasNI, sweNI, preSel, autoPre, sbs);
          action  <= actionV;
          if (actionV = DESL and action /= DESL and scsNI = 'H') then
            assertmsg("MSG15A: CS shouldn't be set to high level by a pull-up", error);
          end if;
          trigMe <= not trigMe;
        end if;
    end case;  --  mode
  end process MEM_MODE;

-------------------------------------------------------------------------------
-- Process: DO_COMMAND
-- Purpose: Carry out the command assert on the clock rising edge.
-- Inputs:  trigMe
-- Outputs: bankState,rowAdr,colAdr,sd,readMem,writeMem,BurstEnd
-- Note:    This process is trigged one delta time after the process
--          MEM_MODE to allow signal "action" and all other output signals
--          (bankState, rowAdr,etc.) to take their new value before DO_COMMAND 
--          is processed.
-------------------------------------------------------------------------------
  DO_COMMAND : process (trigMe, resetN)

    variable whichBank  : integer range 0 to 3;
    variable otherBank  : integer range 0 to 3;
    variable colVecInt  : integer;
    variable i          : integer   := 0;
    variable trigValueR : std_logic := '1';  --force an event on readMem signal
    variable trigValueW : std_logic := '1';  --force an event on writeMem signal
    variable timeAct    : time2d    := (others => 0 ns);  -- Last ACT com. for each bank
    variable timeRead   : time2d    := (others => 0 ns);  -- Last READ com. for each bank
    variable message    : line      := null;

  begin

    if (mode = UNINITIALIZED or mode = POWER_ON) then  --  initialized  sd-driver
      sd <= (others => 'Z');
    end if;
    if (powOnState /= IDLE) then
      assertmsg("MSG18A:Initialization is not finished, bank still refreshing", error);
    end if;

    if (resetN'event and resetN = '0') then
      bankState <= (others => IDLE);
    elsif(trigMe'event) then

      case action is                    --  action is DESL at initialization
        when DESL | NOP =>
          --  do nothing
        when BST        =>
          assertmsg("MSG19: Burst stop command not supported", error);
        when ACT =>
          if (sbs(0) /= '0' and sbs(0) /= '1' and sbs(0) /= '0' and sbs(1) /= '1') then
            assertmsg("MSG20: Undefined bank on ACT command ->ACT ignored", error);
          else
            whichBank := to_integer(sbs);
--            write(message, modele);
--            write(message, now);
--            write(message, string'(", "));
--            write(message, string'("MSG20A: Activation of row_"));
--            write(message, to_integer(rowVec));
--            write(message, string'(" in internal bank"));
--            write(message, whichBank);
--            assert false
--              report message(message'range)
--              severity note;
            message := null;
            case bankState(whichBank) is    --  process target bank
              when IDLE =>
                bankState(whichBank) <= ROW_ACTIVATING,
                                        ROW_ACTIVE after TRCD;
                rowsAdr(whichBank) <= rowVec;
                timeAct(whichBank) := now;  --  to check TRAS when PRE
              when others =>
                assertmsg("MSG21: ACT admitted only when bank is IDLE", error);
            end case;
            for ii in 1 to 3 loop
              case bankState((whichBank+ii) mod 4) is  --  validation state other bank
                when ROW_ACTIVATING =>
                  assertmsg("MSG22: Delay TRRD not met.", error);
                when others =>
                  --  Do nothing if IDLE,ROW_ACTIVE,READING,WRITING,WRITE_RECOVERING
                  --  or PRECHARCHING.
                  --  Auto-precharge is not supported and MODE_REGISTER_ACCESSING
                  --  or REFRESHING state is trigged before.
              end case;
            end loop;
          end if;

        when READ =>
--          assertmsg("MSG22A: Reading WORD", note);
          i := 0;
          if (sbs(0) /= '0' and sbs(0) /= '1' and sbs(1) /= '0' and sbs(1) /= '1') then
            assertmsg("MSG23: Undefined selected bank during read", error);
          else
            whichBank := to_integer(sbs);
            burstBank <= whichBank after (CAS_LATENCY-1)*CLK_PERIOD + TAC;
            case bankState(whichBank) is
              when ROW_ACTIVE | READING =>
                if(bankState(whichBank) = ROW_ACTIVE) then
                  sd <= (others => 'X') after (CAS_LATENCY-1)*CLK_PERIOD+TLZ,
                        (others => 'Z') after (CAS_LATENCY-1)*CLK_PERIOD+TAC;
                else
                  if ((now-timeRead(whichbank)) < BURST_LENGTH*CLK_PERIOD) then
                    assertmsg("MSG24: Burst stops by READ cmd NS", error);
                  end if;
                end if;
                timeRead(whichBank)  := now;
                bankState(whichBank) <= READING, ROW_ACTIVE after
                                        (CAS_LATENCY+BURST_LENGTH-1)*CLK_PERIOD;
                colVecInt := to_int_chklevel(colVec);
                while i < BURST_LENGTH loop
                  if (colVecInt = -1) then
                    colAdr <= transport (others => 'X')
                              after (CAS_LATENCY-1+i)*CLK_PERIOD + TAC;
                  else
                    colAdr <= transport conv_std_logic_vector(colVecInt+i,
                                                              colVec'length) after (CAS_LATENCY-1+i)*CLK_PERIOD + TAC;
                  end if;
                  readMem <= transport trigValueR after
                             (CAS_LATENCY-1+i)*CLK_PERIOD + TAC;
                  i          := i+1;
                  trigValueR := not trigValueR;
                end loop;
                burstEnd <= false, true after
                            (CAS_LATENCY+BURST_LENGTH-2)*CLK_PERIOD + TAC;
              when WRITING =>  -- Not necessarily a burst termination -> CAS_LAT dependant.
                assertmsg("MSG25: Read command during write not supported.", error);
              when WRITE_RECOVERING =>
                assertmsg("MSG26: Read command during row activation not supported.", error);
              when IDLE =>
                assertmsg("MSG27: Bank must be activated before read cmd.", error);
              when PRECHARGING =>
                assertmsg("MSG28: Cannot assert READ cmd when precharging.", error);
              when ROW_ACTIVATING =>
                assertmsg("MSG29: Cannot assert READ cmd when ROW_ACTIVATING.", error);
              when REFRESHING =>
                assertmsg("MSG30: Cannot read while REFRESHING.", error);
              when others =>
                assertmsg("MSG31: auto precharge not supported.", error);
            end case;
            for ii in 1 to 3 loop
              case bankState((whichBank+ii) mod 4) is  --validate other banks
                when IDLE | PRECHARGING | ROW_ACTIVE | ROW_ACTIVATING =>
                  --   Do nothing
                when READING                                          =>
                  if ((now-timeRead((whichBank+ii) mod 4)) < BURST_LENGTH*CLK_PERIOD) then
                    assertmsg("MSG32: Burst stops by ping-pong READ not supported", error);
                  end if;
                when WRITING =>  -- Not necessarely a burst term. CAS_LAT dependant.
                  assertmsg("MSG33: Ping-pong W/R Not supported.", error);
                when WRITE_RECOVERING =>
                  assertmsg("MSG34: Ping-pong W/R Not supported.", error);
                when others =>
                  assertmsg("MSG35: auto precharge or MRS not supported", error);
              end case;  --  bankState(otherBank)
            end loop;
          end if;

        when WRIT =>
          i := 0;
          if (sbs(0) /= '0' and sbs(0) /= '1' and sbs(1) /= '0' and sbs(1) /= '1') then
            assertmsg("MSG36: Undefined selected bank on WRITE->cmd ignored", error);
          else
            whichBank := to_integer(sbs);
            burstBank <= whichBank;     --  note: no latency on write
            case bankState(whichBank) is
              when ROW_ACTIVE | WRITE_RECOVERING =>
                if (BURST_LENGTH > 1) then
                  bankState(whichBank) <= WRITING, WRITE_RECOVERING
                                          after (BURST_LENGTH-1)*CLK_PERIOD,
                                          ROW_ACTIVE after TDPL+(BURST_LENGTH-1)*CLK_PERIOD;
                else                    --  BURST_LENGTH=1
                  bankState(whichBank) <= WRITE_RECOVERING,
                                          ROW_ACTIVE after TDPL;
                end if;
                colVecInt := to_int_chklevel(colVec);
                while i < BURST_LENGTH loop
                  if (colVecInt = -1) then
                    colAdr <= (others => 'X');
                  else
                    colAdr <= transport conv_std_logic_vector(colVecInt+i,
                                                              colVec'length) after i*CLK_PERIOD;
                  end if;
                  writeMem   <= transport trigValueW after i*CLK_PERIOD;
                  trigValueW := not trigValueW;
                  i          := i+1;
                end loop;
              when READING =>
                assertmsg("MSG37: READ burst stops by WRITE on same page not supported", error);
              when WRITING =>
                assertmsg("MSG38: WRITE burst stops by WRITE not supported.", error);
              when IDLE =>
                assertmsg("MSG39: Bank must be activated before write cmmd.", error);
              when PRECHARGING =>
                assertmsg("MSG40: Cannot assert WRITE cmd when precharging.", error);
              when ROW_ACTIVATING =>
                assertmsg("MSG41: Cannot assert WRITE cmd while ROW_ACTIVATING.", error);
              when REFRESHING =>
                assertmsg("MSG42: Cannot write while REFRESHING.", error);
              when others =>
                assertmsg("MSG43: Auto-precharge or MRS not supported.", error);
            end case;
            for ii in 1 to 3 loop
              case bankState((whichBank+ii) mod 4) is  --validate other bank state
                when IDLE|PRECHARGING|ROW_ACTIVE|ROW_ACTIVATING|WRITE_RECOVERING =>
                  --   Do nothing 
                when READING                                                     =>
                  assertmsg("MSG44: Burst stops by ping-pong WRITE not supported", error);
                when WRITING =>
                  assertmsg("MSG45: WRITE burst stops by WRITE not suported", error);
                when others =>
                  assertmsg("MSG46: Auto-precharge or MRS not supported", error);
              end case;  --  bankState(otherBank)
            end loop;
          end if;

        when PALL | PRE =>
          whichBank := to_integer(sbs);
          if (bankState(whichBank) /= IDLE) then
            if (CAS_LATENCY = 2) then
              if (now-timeAct(whichBank) < TRAS_CAS2_MIN) then
                assertmsg("MSG47: ACT to PRE delay (TRAS) too short", error);
              end if;
            elsif (CAS_LATENCY = 3) then
              if (now-timeAct(whichBank) < TRAS_CAS3_MIN) then
                assertmsg("MSG47A: ACT to PRE delay (TRAS) too short", error);
              end if;
            end if;
            if (now-timeAct(whichBank) > TRAS_MAX) then
              assertmsg("MSG47A: ACT to PRE delay (TRAS) too long", error);
            end if;
          end if;
          case bankState(whichBank) is
            when ROW_ACTIVE =>
              bankState(whichBank) <= PRECHARGING, IDLE after TRP;
            when READING =>  -- IEP (last data-out to PRE) is set to -tCLK to allow 
              -- VIA to support all SDRAM's manufacturer timing
              if (CAS_LATENCY = 1 or CAS_LATENCY = 2) then
                if (now-timeRead(whichBank) < BURST_LENGTH*CLK_PERIOD) then
                  assertmsg("MSG48: Read burst stops by precharge not supported", error);
                  assertmsg("MSG48a: Is sdqm high to mask invalid data?", note);
                end if;
                bankState(whichBank) <= PRECHARGING, IDLE after TRP;
              else                      --  CAS_LATENCY=3
                if (now-timeRead(whichBank) < (BURST_LENGTH+1)*CLK_PERIOD) then
                  assertmsg("MSG49:READ burst stops by precharge not supported", error);
                  assertmsg("MSG49a: Is sdqm high 2 cycles to mask invalid data?", note);
                end if;
                bankState(whichBank) <= PRECHARGING, IDLE after TRP;
              end if;
            when WRITING =>
              assertmsg("MSG50: WRITE burst stops by PRE/PALL not supported", error);
              assertmsg("MSG50a: Must mask preceding data that don't satisfy TDPL", note);
            when WRITE_RECOVERING =>
              assertmsg("MSG51: No precharging while WRITE_RECOVERING.", error);
            when IDLE        =>
              --  Do nothing
            when PRECHARGING =>
              assertmsg("MSG52: Assert PRE/PALL command while precharging?", error);
            when ROW_ACTIVATING =>
              assertmsg("MSG53: No precharging while row activating.", error);
            when REFRESHING =>
              assertmsg("MSG54: No precharging while refreshing.", error);
            when others =>
              assertmsg("MSG55: PALL or MRS not supported", error);
          end case;  --  bankState(whichBank)
          if (preSel = '0') then
            --  Precharge selected bank already done, PRE was selected.
          else                          --  PALL is selected
            for ii in 1 to 3 loop
              if (bankState((whichBank+ii) mod 4) /= IDLE) then
                if (CAS_LATENCY = 2) then
                  if (now-timeAct((whichBank+ii) mod 4) < TRAS_CAS2_MIN) then
                    assertmsg("MSG56: ACT to PRE delay (TRAS) too short", error);
                  end if;
                elsif (CAS_LATENCY = 3) then
                  if (now-timeAct((whichBank+ii) mod 4) < TRAS_CAS3_MIN) then
                    assertmsg("MSG56A: ACT to PRE delay (TRAS) too short", error);
                  end if;
                end if;
                if(now-timeAct((whichBank+ii) mod 4) > TRAS_MAX) then
                  assertmsg("MSG56B: ACT to PRE delay (TRAS) too long", error);
                end if;
              end if;
              case bankState((whichBank+ii) mod 4) is
                when ROW_ACTIVE =>
                  bankState((whichBank+ii) mod 4) <= PRECHARGING, IDLE after TRP;
                when READING =>  -- IEP (last data-out to PRE) is set to -tCLK to allow 
                  -- VIA to support all SDRAM's manufacturer timing
                  if (CAS_LATENCY = 1 or CAS_LATENCY = 2) then
                    if (now-timeRead(whichBank) < BURST_LENGTH*CLK_PERIOD) then
                      assertmsg("MSG48: Read burst stops by PRE not supported", error);
                      assertmsg("MSG48a: Is sdqm high to mask invalid data?", note);
                    end if;
                    bankState(whichBank) <= PRECHARGING, IDLE after TRP;
                  else                  --  CAS_LATENCY=3
                    if (now-timeRead(whichBank) < (BURST_LENGTH+1)*CLK_PERIOD) then
                      assertmsg("MSG49:READ burst stops by PRE not supported", error);
                      assertmsg("MSG49a: Is sdqm high 2 cycles to mask invalid data?", note);
                    end if;
                    bankState(whichBank) <= PRECHARGING, IDLE after TRP;
                  end if;
                  
                when WRITING =>
                  assertmsg("MSG59: WRITE burst stops by PALL not supported", error);
                  assertmsg("MSG59a: Must mask preceding data that do not satisfy TDPL", note);
                when WRITE_RECOVERING =>
                  assertmsg("MSG60: No PALL while WRITE_RECOVERING.", error);
                when IDLE        =>
                  --  Do nothing
                when PRECHARGING =>
                  assertmsg("MSG61: Assert a PALL command while precharging?", error);
                when ROW_ACTIVATING =>
                  assertmsg("MSG62: No precharging while row activating.", error);
                when REFRESHING =>
                  assertmsg("MSG63: No precharging while refreshing.", error);
                when others =>
                  assertmsg("MSG64: PALL or MRS not supported", error);
              end case;
            end loop;
          end if;

        when REF =>
          for ii in 1 to 3 loop
            if (bankState(ii) = IDLE) then
              bankState(ii) <= REFRESHING, IDLE after TRC;
              refresh       <= not refresh;  --  this trigs the REF_SDRAM process
            else
              assertmsg("MSG65: All bank must be IDLE before refreshing.", error);
            end if;
          end loop;

        when READA =>
          assertmsg("MSG66: READA command not supported", error);

        when WRITA =>
          assertmsg("MSG67: WRITA command not supported", error);

        when MRS =>
          assertmsg("MSG68: MRS command is legal only during initialization", error);

      end case;  --  action
    end if;

  end process DO_COMMAND;

-------------------------------------------------------------------------------
--  Process:   MEMORY
--  Purpose:   Create a link list that will contain all address-data set
--             that were accessed and created on write command.
--  Inputs:    readMem,writeMem,dumpI
--  Outputs:   sd
-------------------------------------------------------------------------------
  MEMORY : process (readMem, writeMem, dumpI, loadI)

    file outFile          : text is out DUMPFILE;
    file inFile           : text is in LOADFILE;
    variable adrInt       : integer;
    variable adrLength    : integer                       := rowAdr'length+colAdr'length+2;  -- +2 for bank select
    variable adrLogic     : std_logic_vector(adrLength-1 downto 0);
    variable adrHexInFile : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    variable tmpAdr       : std_logic_vector(21 downto 0);
    variable bankSelect   : std_logic_vector(1 downto 0);
    variable blank        : character;
    variable dataWritten  : boolean                       := false;
    variable findData     : boolean                       := false;
    variable goodFlag     : boolean                       := true;
    variable lineCount    : integer                       := 0;
    variable listEmpty    : boolean                       := true;
    variable memHead      : headPtr;
    variable memTail      : headPtr;
    variable memMiddle    : midListPtr;
    variable message      : line;
    variable midListAdr   : integer                       := -1;
    variable outLine      : line;
    variable memLine      : line;
    variable tmpStd       : std_logic;
    variable tmpPtr       : entryPtr;
    variable tmpPtr1      : entryPtr;
    variable underScore   : character;

  begin  --  process MEMORY
    
    if (mode = UNINITIALIZED or mode = POWER_ON) then  --  initialized sd-driver
      sd           <= (others => 'Z');
      adrHexInFile := (others => '0');
    end if;

    case burstBank is
      when 0 => bankSelect := "00";
      when 1 => bankSelect := "01";
      when 2 => bankSelect := "10";
      when 3 => bankSelect := "11";
    end case;

    if(is0or1(rowsAdr(burstBank)) and is0or1(colAdr)) then
      adrLogic := bankSelect(1)&rowsAdr(burstBank)&bankSelect(0)&colAdr;
      adrInt   := to_integer(adrLogic);
    else
      adrInt := -1;
    end if;

    if(readMem'event) then
      if (sdqmD2 /= "00") then
        assertmsg("MSG68A: SDQM pins must be low when reading", error);
      end if;
    end if;
    if (readMem'event and listEmpty = false) then
      findData := false;
      if (adrInt /= -1) then
        if (midListadr > adrInt) then
          tmpPtr                := memHead.listPtr;
          while (tmpPtr.address <= adrInt and findData = false) loop
            if (tmpPtr.address = adrInt) then
              if (burstEnd = false) then
                sd <= tmpPtr.data, (others => 'X') after CLK_PERIOD-TAC+TOH;
              else
                sd <= tmpPtr.data, (others => 'X') after CLK_PERIOD-TAC+TOH,
                      (others => 'Z') after CLK_PERIOD-TAC+THZ;
              end if;
              findData := true;
            else
              tmpPtr := tmpPtr.nextEntry;
            end if;
          end loop;
        else
          tmpPtr                                   := memMiddle.listPtr;
          while (tmpPtr /= null and tmpPtr.address <= adrInt and findData = false) loop
            if (tmpPtr.address = adrInt) then
              if (burstEnd = false) then
                sd <= tmpPtr.data, (others => 'X') after CLK_PERIOD-TAC+TOH;
              else
                sd <= tmpPtr.data, (others => 'X') after CLK_PERIOD-TAC+TOH,
                      (others => 'Z') after CLK_PERIOD-TAC+THZ;
              end if;
              findData := true;
            else
              tmpPtr := tmpPtr.nextEntry;
            end if;
          end loop;
        end if;
        if (findData = false) then
          if (burstEnd = false) then
            sd <= (others => 'X');
          else
            sd <= (others => 'X'), (others => 'Z') after CLK_PERIOD-TAC+THZ;
          end if;
          if (MSG69_inhibit = false) then
            assertmsg("MSG69: Data undefined: address not written before.", error);
          end if;
        end if;
      else
        if (burstEnd = false) then
          sd <= (others => 'X');
        else
          sd <= (others => 'X'), (others => 'Z') after CLK_PERIOD-TAC+THZ;
        end if;
        assertmsg("MSG70: Address is undefined so... data is undefined", error);
      end if;
    elsif (readMem'event and listEmpty = true) then
      if (burstEnd = false) then
        sd <= (others => 'X');
      else
        sd <= (others => 'X'), (others => 'Z') after CLK_PERIOD-TAC+THZ;
      end if;
      assertmsg("MSG71: Data is undefined:  linklist is empty", error);
    elsif (writeMem'event and sdqmI /= "11") then
      dataWritten := false;
      if (firstWrite = '0' or listEmpty = true) then
        if (adrInt /= -1) then
          tmpPtr      := new memEntry'(adrInt, (others => 'X'), null);
          tmpPtr.data := writeData(tmpPtr.data, sd, sdqmI);
          listEmpty   := false;
          firstWrite  <= '1';
          memHead     := new head'(1, tmpPtr);
          memMiddle   := new midList'(0, 0, tmpPtr);
          midListAdr  := memMiddle.listPtr.address;
        else
          assertmsg("MSG72: address undefined: data is ignored", error);
        end if;
      elsif (adrInt /= -1) then
        if (memHead.listPtr.address > adrInt) then
          tmpPtr             := new memEntry'(adrInt, (others => 'X'), memHead.listPtr);
          tmpPtr.data        := writeData(tmpPtr.data, sd, sdqmI);
          memHead.listPtr    := tmpPtr;
          memHead.numEntries := memHead.numEntries+1;
          memMiddle.leftNew  := memMiddle.leftNew+1;
          if (memMiddle.leftNew-memMiddle.rightNew = 2) then
            tmpPtr := memHead.listPtr;
            for i in 0 to memHead.numEntries/2 loop
              tmpPtr := tmpPtr.nextEntry;
            end loop;
            memMiddle.listPtr  := tmpPtr;
            midListAdr         := memMiddle.listPtr.address;
            memMiddle.leftNew  := 0;
            memMiddle.rightNew := 0;
          end if;
        elsif (midListAdr > adrInt) then
          tmpPtr := memHead.listPtr;
          while (dataWritten = false) loop
            if (tmpPtr.address = adrInt) then
              tmpPtr1 := new memEntry'(adrInt, (others => 'X'),
                                     null);
              tmpPtr1.data := writeData(tmpPtr1.data, sd, sdqmI);
              if (checkReWrite = true) then
                if ((tmpPtr.data(15 downto 0) xor tmpPtr1.data(15 downto 0)) /= allXs(15 downto 0)) then
                  assertmsg("MSG72A: Memory location has been written more than once", error);
                end if;
              end if;
              deallocate(tmpPtr1);
              tmpPtr.data := writeData(tmpPtr.data, sd, sdqmI);
              dataWritten := true;
            elsif (tmpPtr.nextEntry.address > adrInt) then
              tmpPtr1 := new memEntry'(adrInt, (others => 'X'),
                                     tmpPtr.nextEntry);
              tmpPtr1.data       := writeData(tmpPtr1.data, sd, sdqmI);
              dataWritten        := true;
              tmpPtr.nextEntry   := tmpPtr1;
              memHead.numEntries := memHead.numEntries+1;
              memMiddle.leftNew  := memMiddle.leftNew+1;
              if (memMiddle.leftNew-memMiddle.rightNew = 2) then
                tmpPtr := memHead.listPtr;
                for i in 1 to memHead.numEntries/2 loop
                  tmpPtr := tmpPtr.nextEntry;
                end loop;
                memMiddle.listPtr  := tmpPtr;
                midListAdr         := memMiddle.listPtr.address;
                memMiddle.leftNew  := 0;
                memMiddle.rightNew := 0;
              end if;
            else
              tmpPtr := tmpPtr.nextEntry;
            end if;
          end loop;
        else                            -- adrInt>=midListadr
          tmpPtr := memMiddle.listPtr;
          while (tmpPtr.nextEntry /= null and dataWritten = false) loop
            if (tmpPtr.address = adrInt) then
              tmpPtr1 := new memEntry'(adrInt, (others => 'X'),
                                     null);
              tmpPtr1.data := writeData(tmpPtr1.data, sd, sdqmI);
              if (checkReWrite = true) then
                if ((tmpPtr.data(15 downto 0) xor tmpPtr1.data(15 downto 0)) /= allXs(15 downto 0)) then
                  assertmsg("MSG72B: Memory location has been written more than once", error);
                end if;
              end if;
              deallocate(tmpPtr1);
              tmpPtr.data := writeData(tmpPtr.data, sd, sdqmI);
              dataWritten := true;
            elsif(tmpPtr.nextEntry.address > adrInt) then
              tmpPtr1 := new memEntry'(adrInt, (others => 'X'),
                                     tmpPtr.nextEntry);
              tmpPtr1.data       := writeData(tmpPtr1.data, sd, sdqmI);
              dataWritten        := true;
              tmpPtr.nextEntry   := tmpPtr1;
              memHead.numEntries := memHead.numEntries+1;
              memMiddle.rightNew := memMiddle.rightNew+1;
              if (memMiddle.rightNew-memMiddle.leftNew = 2) then
                tmpPtr := memHead.listPtr;
                for i in 1 to memHead.numEntries/2 loop
                  tmpPtr := tmpPtr.nextEntry;
                end loop;
                memMiddle.listPtr  := tmpPtr;
                midListAdr         := memMiddle.listPtr.address;
                memMiddle.leftNew  := 0;
                memMiddle.rightNew := 0;
              end if;
            else
              tmpPtr := tmpPtr.nextEntry;
            end if;
          end loop;
          if (tmpPtr.nextEntry = null) then
            if (tmpPtr.address = adrInt) then
              tmpPtr1 := new memEntry'(adrInt, (others => 'X'),
                                     null);
              tmpPtr1.data := writeData(tmpPtr1.data, sd, sdqmI);
              if (checkReWrite = true) then
                if ((tmpPtr.data(15 downto 0) xor tmpPtr1.data(15 downto 0)) /= allXs(15 downto 0)) then
                  assertmsg("MSG72C: Memory location has been written more than once", error);
                end if;
              end if;
              deallocate(tmpPtr1);
              tmpPtr.data := writeData(tmpPtr.data, sd, sdqmI);
            else
              tmpPtr1            := new memEntry'(adrInt, (others => 'X'), null);
              tmpPtr1.data       := writeData(tmpPtr1.data, sd, sdqmI);
              tmpPtr.nextEntry   := tmpPtr1;
              memHead.numEntries := memHead.numEntries+1;
              memMiddle.rightNew := memMiddle.rightNew+1;
              if (memMiddle.rightNew-memMiddle.leftNew = 2) then
                tmpPtr := memHead.listPtr;
                for i in 1 to (memHead.numEntries/2) loop
                  tmpPtr := tmpPtr.nextEntry;
                end loop;
                memMiddle.listPtr  := tmpPtr;
                midListAdr         := memMiddle.listPtr.address;
                memMiddle.leftNew  := 0;
                memMiddle.rightNew := 0;
              end if;
            end if;
          end if;
        end if;
      else
        assertmsg("MSG73: address undefined : data is ignored", error);
      end if;
    elsif(writeMem'event and sdqmI = "11") then
      assertmsg("MSG73A: Write to SDRAM with sdqm's pins all active", note);
    end if;  --  End READ or WRITE
    if (dumpI'event and dumpI = '1' and listEmpty = false) then
      assertmsg("MSG74: Dumpage de la memoire", note);
      tmpPtr := memHead.listPtr;
      while (tmpPtr /= null) loop
        adrHexInFile(22 downto 1) := conv_std_logic_vector(tmpPtr.address, 22);
        hwrite(outLine, adrHexInFile);
        write(outline, string'(" "));
        for ii in 1 downto 1 loop
          hwrite(outLine, tmpPtr.data((ii+1)*8-1 downto ii*8));
          write(outLine, string'("_"));
        end loop;
        hwrite(outLine, tmpPtr.data(7 downto 0));
        writeLine(outFile, outLine);
        tmpPtr1 := tmpPtr.nextEntry;
        tmpPtr  := tmpPtr1;
      end loop;
    end if;

    if (loadI'event and loadI = '1') then
      lineCount := 1;
      if (listEmpty = false) then
        assertmsg("MSG76: La memoire doit etre vide pour un load", error);
      else
        -------------------------------------------------------------------------
        --  Pour etre en mesure de lire plusieurs fois ce fichier, il faudrait
        --  que celui-ci soit declare dans un procedure qie l'on appelerait a la
        --  place du code ci-dessous. Il faudrait aussi s'arranger pour
        --  recuperer la liste chaine auretour de la piocedure
        -------------------------------------------------------------------------
        while not(endfile(inFile)) loop
          if (lineCount = 1) then
            tmpPtr     := new memEntry'(0, (others => 'X'), null);
            memHead    := new head'(1, tmpPtr);
            memTail    := new head'(0, tmpPtr);
            memMiddle  := new midList'(0, 0, tmpPtr);
            listEmpty  := false;
            firstWrite <= '1';
            lineCount  := lineCount + 1;
          else
            tmpPtr                    := new memEntry'(0, (others => 'X'), null);
            memTail.listPtr.nextEntry := tmpPtr;
            memTail.listPtr           := tmpPtr;
            memHead.numEntries        := memHead.numEntries+1;
            if (lineCount mod 2 /= 0) then
              memMiddle.listPtr := memMiddle.listPtr.nextEntry;
              memMiddle.leftNew := memMiddle.leftNew+1;
              midListAdr        := memMiddle.listPtr.address;
            else
              memMiddle.rightNew := memMiddle.rightNew+1;
            end if;
            lineCount := lineCount+1;
          end if;
          readline(inFile, memLine);
          hread(memLine, adrHexInFile, goodFlag);
          if (not goodFlag) then exit; end if;
          tmpAdr         := adrHexInFile(22 downto 1);
          tmpPtr.address := to_integer(tmpAdr);
          if (lineCount = 2) then
            midListAdr := tmpPtr.address;  -- when first element ...
          end if;
          read(memLine, blank, goodFlag);
          if (not goodFlag) then exit; end if;
          for ii in 1 downto 1 loop
            hread(memLine, tmpPtr.data((ii+1)*8-1 downto ii*8), goodFlag);
            if (not goodFlag) then exit; end if;
            read(memLine, underScore, goodFlag);
            if ((not goodFlag) or (underscore /= '_')) then exit; end if;
          end loop;
          hread(memLine, tmpPtr.data(7 downto 0), goodFlag);
          if (not goodFlag) then exit; end if;
        end loop;
        if (not goodFlag) then
          write(message, string'("MSG77: Erreur de syntaxe a la ligne "));
          write(message, lineCount);
          assertmsg(message(message'range), error);
          message := null;
        else
          assertmsg("End of the reverse dump", note);
          if (lineCount = 1) then
            assertmsg("MSG78: Fichier a loader est vide ou inexistant", error);
          end if;
        end if;
      end if;
    end if;

  end process MEMORY;

------------------------------------------------------------------------------
--  Process:  RFH_SDRAM
--  Purpose:  Check if all rows are refreshed for the time required (32 ms),
--            and flag  an error if the refresh period constraint is not met.  
--  Inputs:   firstWrite,refresh,rfhViolation
--  Outputs:  rfhViolation
------------------------------------------------------------------------------
  RFH_SDRAM : process (firstWrite, refresh, rfhViolation)

    variable refreshRow : integer range 0 to (2**12);
    
  begin  --  process RFH_SDRAM

    if (firstWrite = '1' and firstWrite'event) then
      rfhViolation <= '1' after RFH_PERIOD;
    elsif (refresh'event and firstWrite = '1') then
      refreshRow := refreshRow+1;
      if (refreshRow = (2**12)) then
        refreshRow   := 0;
        rfhViolation <= '0', '1' after RFH_PERIOD;
      end if;
    end if;
    if (rfhViolation'event and rfhViolation = '1' and
        not(refresh'event and refreshRow = 0)) then
      assertmsg("MSG79: Not all rows has been refreshed within tREF", error);
      rfhViolation <= '0', '1' after RFH_PERIOD;
      refreshRow   := 0;
    end if;

  end process RFH_SDRAM;




-------------------------------------------------------------------------------
--  Process: SETCLOCK
--  Purpose: Init CLK_PERIOD value.
-------------------------------------------------------------------------------
  P_SETCLOCK : process

    variable debutPeriod : time;
    
  begin  -- process ubus_refresh

    if (setSclkPeriod = '1' and setSclkPeriod'event) then
      wait on sclk until sclk = '0' and sclk'event;
      debutPeriod := now;
      wait on sclk until sclk = '0' and sclk'event;
      CLK_PERIOD  <= now - debutPeriod;
      setupTiming <= '1', '0' after 1 ns;
    end if;

    wait on setSclkPeriod;

  end process P_SETCLOCK;


end functional;
