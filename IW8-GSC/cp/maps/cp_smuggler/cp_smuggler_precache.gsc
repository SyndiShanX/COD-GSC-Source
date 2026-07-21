/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_smuggler\cp_smuggler_precache.gsc
********************************************************/

main() {
  scripts\cp_mp\tripwire::precache();
  scripts\cp_mp\tripwire::precachetrap("_encstr_8B11138E9C4B83BB4B2756EBD1E42C83D7CC4E85CE", "_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23", 1);
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("_encstr_BDBB0616C6C186C2");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("_encstr_91A40713BCD2887706");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("_encstr_ACA407B9984198974F");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("_encstr_871D0613938567B7");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("_encstr_8AF607CE7287CBD742");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("_encstr_84F607E03B912337C7");
}