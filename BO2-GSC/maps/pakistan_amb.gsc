/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_amb.gsc
**************************************/

#include maps\_utility;

main() {
  thread sign_break_lp();
}

sign_break_lp() {
  level waittill("sign_dangle_break_start");
  wait 1.5;
  sign_loop_ent = spawn("script_origin", (1900, 2824, 578));
  sign_loop_ent playloopsound("fxa_sign_dangle_lp", 2);
}