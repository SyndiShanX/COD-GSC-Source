/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\drone_civilian.gsc
***********************************************/

#using_animtree("generic_human");

init() {
  level.drone_anims["neutral"]["stand"]["idle"] = % hm_grnd_red_civ_hide_idle01;
  level.drone_anims["neutral"]["stand"]["run"] = % hm_grnd_red_civ_run_forward;
  level.drone_anims["neutral"]["stand"]["death"] = % hf_grnd_red_civ_run_death01;
  scripts\sp\drone::initglobals();
}