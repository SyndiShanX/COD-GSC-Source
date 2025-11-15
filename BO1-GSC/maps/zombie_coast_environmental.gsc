/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_coast_environmental.gsc
***********************************************/

#include maps\_utility;
#include maps\_anim;
#include common_scripts\utility;
#using_animtree("fxanim_props_dlc3");
main() {
  level.scr_anim["hook"]["hook_anim"][0] = % fxanim_zom_ship_crane01_hook_anim;
  level.scr_anim["boat"]["boat_anim"][0] = % fxanim_zom_ship_lifeboat_anim;
  level thread environmental_entities();
}

environmental_entities() {
  level waittill("start_of_round");
  hook = getEntArray("fxanim_zom_ship_crane01_hook_mod", "targetname");
  for(i = 0; i < hook.size; i++) {
    hook[i] thread animate_environmental_object("hook", "hook_anim");
  }
  boat = getEntArray("fxanim_zom_ship_lifeboat_mod", "targetname");
  for(i = 0; i < boat.size; i++) {
    boat[i] thread animate_environmental_object("boat", "boat_anim");
  }
}

#using_animtree("fxanim_props_dlc3");
animate_environmental_object(animname, animation) {
  self.animname = animname;
  self UseAnimTree(#animtree);
  self thread anim_loop(self, animation, "stop_looping");
}