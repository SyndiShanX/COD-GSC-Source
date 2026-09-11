/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_riverside_gw\mp_riverside_gw_precache.gsc
************************************************************************/

function main() {
  thread scripts\mp\infilexfil\lbravo_infil::lbravo_init("alpha");
  thread scripts\mp\infilexfil\lbravo_infil::lbravo_init("bravo");
  thread scripts\mp\infilexfil\mi8_infil::mi8_init("alpha");
  thread scripts\mp\infilexfil\mi8_infil::mi8_init("bravo");
}