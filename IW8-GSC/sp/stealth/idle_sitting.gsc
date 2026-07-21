/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\stealth\idle_sitting.gsc
***********************************************/

main() {
  if(isDefined(level.scr_anim) && isDefined(level.scr_anim["idle_chair"])) {
    return;
  }
  script_model();
}

#using_animtree("script_model");

script_model() {
  level.scr_animtree["idle_chair"] = #animtree;
  level.scr_model["idle_chair"] = "cp_disco_folding_chair_lod0";
  level.scr_anim["idle_chair"]["sit_sleeping_react"] = % reb_stl_idle_sit_sleeping_react_chair;
  level.scr_anim["idle_chair"]["sit_sleeping_death"] = % reb_stl_idle_sit_sleeping_death01_chair;
  level.scr_anim["idle_chair"]["sit_cellphone_react"] = % reb_stl_idle_sit_phone01_react_chair;
  level.scr_anim["idle_chair"]["sit_cellphone_death"] = % reb_stl_idle_sit_phone01_death02_4_chair;
  level.scr_anim["idle_chair"]["sit_laptop_react"] = % reb_stl_idle_sit_laptop_react_chair;
  level.scr_anim["idle_chair"]["sit_laptop_death"] = % reb_stl_idle_sit_laptop_death02_2_chair;
  level.scr_anim["idle_chair"]["sit_pistol_clean_react"] = % reb_stl_idle_sit_gunmaintenance_react_chair;
  level.scr_anim["idle_chair"]["sit_pistol_clean_death"] = % reb_stl_idle_sit_gunmaintenance_death01_6_chair;
}