/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: mptype\mptype_tf141_forest_assault.gsc
********************************************************/

main() {

  switch (codescripts\character::get_random_character(2)) {
    case 0:
      character\mp_character_tf_141_forest_assault_a::main();
      break;
    case 1:
      character\mp_character_tf_141_forest_assault_b::main();
      break;
  }
}

precache() {
  character\mp_character_tf_141_forest_assault_a::precache();
  character\mp_character_tf_141_forest_assault_b::precache();
}