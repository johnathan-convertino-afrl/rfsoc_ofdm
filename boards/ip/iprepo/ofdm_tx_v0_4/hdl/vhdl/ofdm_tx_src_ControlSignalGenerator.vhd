-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_src_ControlSignalGenerator.vhd
-- Created: 2022-03-24 21:51:00
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_ControlSignalGenerator
-- Source Path: OFDM_Tx_HW/OFDMTx/ControlSignalGenerator
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_ControlSignalGenerator IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_12_0                        :   IN    std_logic;
        enable                            :   IN    std_logic;
        dataValid                         :   OUT   std_logic;
        preambleValid                     :   OUT   std_logic;
        dataReady                         :   OUT   std_logic;
        PilotValid                        :   OUT   std_logic
        );
END ofdm_tx_src_ControlSignalGenerator;


ARCHITECTURE rtl OF ofdm_tx_src_ControlSignalGenerator IS

  -- Component Declarations
  COMPONENT ofdm_tx_src_PreamValidGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          enable                          :   IN    std_logic;
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_dataValidGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          y                               :   IN    std_logic;
          enable                          :   IN    std_logic;
          valOut                          :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_dataReadyGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          enb_1                           :   IN    std_logic;
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_pilotValidGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_12_0                      :   IN    std_logic;
          enb_1                           :   IN    std_logic;
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_tx_src_PreamValidGen
    USE ENTITY work.ofdm_tx_src_PreamValidGen(rtl);

  FOR ALL : ofdm_tx_src_dataValidGen
    USE ENTITY work.ofdm_tx_src_dataValidGen(rtl);

  FOR ALL : ofdm_tx_src_dataReadyGen
    USE ENTITY work.ofdm_tx_src_dataReadyGen(rtl);

  FOR ALL : ofdm_tx_src_pilotValidGen
    USE ENTITY work.ofdm_tx_src_pilotValidGen(rtl);

  -- Signals
  SIGNAL PreamValidGen_out1               : std_logic;
  SIGNAL dataValidGen_out1                : std_logic;
  SIGNAL dataReadyGen_out1                : std_logic;
  SIGNAL pilotValidGen_out1               : std_logic;

BEGIN
  u_PreamValidGen : ofdm_tx_src_PreamValidGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              enable => enable,
              y => PreamValidGen_out1
              );

  u_dataValidGen : ofdm_tx_src_dataValidGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              y => PreamValidGen_out1,
              enable => enable,
              valOut => dataValidGen_out1
              );

  u_dataReadyGen : ofdm_tx_src_dataReadyGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              enb_1 => dataValidGen_out1,
              y => dataReadyGen_out1
              );

  u_pilotValidGen : ofdm_tx_src_pilotValidGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_12_0 => enb_1_12_0,
              enb_1 => dataValidGen_out1,
              y => pilotValidGen_out1
              );

  dataValid <= dataValidGen_out1;

  preambleValid <= PreamValidGen_out1;

  dataReady <= dataReadyGen_out1;

  PilotValid <= pilotValidGen_out1;

END rtl;
