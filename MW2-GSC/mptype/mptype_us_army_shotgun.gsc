/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: mptype\mptype_us_army_shotgun.gsc
********************************************************/

main() {

  switch (codescripts\character::get_random_character(3)) {
    case 0:
      character\mp_character_us_army_shotgun::main();
      break;
    case 1:
      character\mp_character_us_army_shotgun_b::main();
      break;
    case 2:
      character\mp_character_us_army_shotgun_c::main();
      break;
  }
}

precache() {
  character\mp_character_us_army_shotgun::precache();
  character\mp_character_us_army_shotgun_b::precache();
  character\mp_character_us_army_shotgun_c::precache();
}