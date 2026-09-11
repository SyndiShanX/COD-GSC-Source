/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_smuggler\cp_smuggler_precache.gsc
****************************************************************/

function main() {
  scripts\cp_mp\tripwire::precache();
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("alpha");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("alpha1");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("alpha2");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("bravo");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("bravo1");
  thread scripts\cp\infilexfil\lbravo_infil_cp::lbravo_init("bravo2");
}