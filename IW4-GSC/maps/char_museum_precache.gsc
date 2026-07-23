/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\char_museum_precache.gsc
********************************************************/

main() {
  maps\animated_models\foliage_desertbrush_1::main();
  common_scripts\_destructible_types_anim_generator::main();

  precachemodel("com_metal_briefcase");
  precachemodel("com_cellphone_on");
  precachemodel("electronics_pda");
  precachemodel("rope_test");
  precacheshader("credits_side_bar");

  if(level.level_mode != "credits_1") {
    precachestring(&"CHAR_MUSEUM_DO_NOT_PRESS");
    precacheshader("panic_button");
    maps\_littlebird::main("vehicle_little_bird_bench");
  }
}