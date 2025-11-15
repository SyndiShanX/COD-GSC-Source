/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_patrol_anims_patroljog.gsc
********************************************/

main() {
  humans();
  dogs();
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["generic"]["_stealth_patrol_walk_patroljog"] = % patrol_jog;
  level.scr_anim["generic"]["patrol_walk_patroljog"][0] = % patrol_jog;
  level.scr_anim["generic"]["patrol_lookup"] = % patrol_jog_look_up_once;
  level.scr_anim["generic"]["patrol_orders"] = % patrol_jog_orders_once;
  level.scr_anim["generic"]["patrol_360"] = % patrol_jog_360_once;
  level.patrol_scriptedanims["patrol_lookup"] = "patrol_lookup";
  level.patrol_scriptedanims["patrol_orders"] = "patrol_orders";
  level.patrol_scriptedanims["patrol_360"] = "patrol_360";
}

dogs() {}