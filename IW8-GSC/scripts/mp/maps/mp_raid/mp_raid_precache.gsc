/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_raid\mp_raid_precache.gsc
********************************************************/

function main() {
  thread scripts\mp\infilexfil\lbravo_infil::lbravo_init("alpha");
  thread scripts\mp\infilexfil\lbravo_infil::lbravo_init("bravo");
  thread scripts\mp\infilexfil\umike_infil::umike_init("alpha");
  thread scripts\mp\infilexfil\umike_infil::umike_init("bravo");
}