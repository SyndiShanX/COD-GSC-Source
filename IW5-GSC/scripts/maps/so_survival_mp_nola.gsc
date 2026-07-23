/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_nola.gsc
************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_dlc_1.csv";
  level.loadout_table = "sp/so_survival/tier_dlc_1.csv";
  maps/_so_survival_ai::ai_type_add_override_class("easy", "actor_enemy_so_easy_v2");
  maps\so_survival_mp_nola_precache::main();
  maps\mp\mp_nola_precache::main();
  maps\createart\mp_nola_art::main();
  maps\mp\mp_nola_fx::main();
  maps\createfx\mp_nola_fx::main();
  maps\_so_survival::survival_preload();
  maps\_load::main();
  ambientplay("ambient_mp_nola");
  maps\_utility::set_vision_set("mp_nola", 0);
  maps\_so_survival::survival_postload();
  maps\_compass::setupminimap("compass_map_mp_nola");
  maps\_so_survival::survival_init();
  level thread maps/_so_survival_code::break_glass();
}