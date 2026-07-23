/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_idle_smoke.gsc
********************************************************/

#include maps\_props;
#using_animtree("generic_human");
main() {
  add_smoking_notetracks("generic");
  level.scr_anim["generic"]["smoke_idle"][0] = % patrol_bored_idle_smoke;
  level.scr_anim["generic"]["smoke_react"] = % patrol_bored_react_look_advance;
}