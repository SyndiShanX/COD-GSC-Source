/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: mptype\mptype_opforce_airborne_smg.gsc
********************************************************/

main() {

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\mp_character_airborne_smg::main();
      break;
    case 1:
      character\mp_character_airborne_smg_b::main();
      break;
    case 2:
      character\mp_character_airborne_smg_c::main();
      break;
  }
}

precache() {
  character\mp_character_airborne_smg::precache();
  character\mp_character_airborne_smg_b::precache();
  character\mp_character_airborne_smg_c::precache();
}