/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: mptype\mptype_opforce_henchmen_lmg.gsc
**************************************************/

// IW5 GSC SOURCE
// Decompiled by https://github.com/xensik/gsc-tool

main() {
  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\mp_character_opforce_hench_lmg_a::main();
      break;
    case 1:
      character\mp_character_opforce_hench_lmg_b::main();
      break;
  }
}

precache() {
  character\mp_character_opforce_hench_lmg_a::precache();
  character\mp_character_opforce_hench_lmg_b::precache();
}