/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_aniyah_tac\mp_aniyah_tac_precache.gsc
********************************************************************/

function main() {
  thread scripts\mp\infilexfil\lbravo_infil::lbravo_init("alpha");
  thread scripts\mp\infilexfil\rappel_hackney_infil::rappel_hackney_init("alpha");
  thread scripts\mp\infilexfil\rappel_hackney_infil::rappel_hackney_init("bravo");
}