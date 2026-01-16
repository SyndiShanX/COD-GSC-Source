/*********************************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: common_scripts\_destructible_types_anim_light_fluo_on.gsc
*********************************************************************/

#using_animtree("destructibles");
main() {
  level._destructible_preanims["light_fluorescent_swing"] = % light_fluorescent_swing;
  level._destructible_preanims["light_fluorescent_null"] = % light_fluorescent_null;
  level._destructible_preanims["light_fluorescent_swing_02"] = % light_fluorescent_swing_02;
  level._effect["spotlight_fx"] = loadfx("misc/fluorescent_spotlight");

}