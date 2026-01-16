/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel2_amb.gsc
*****************************************************/

#include maps\_utility;
#include maps\_ambientpackage;
#include maps\_music;
#include common_scripts\utility;
#include maps\_busing;

main() {
  activateAmbientPackage("pel2_outdoors", 0);
  activateAmbientRoom("pel2_outdoors", 0);
  level thread play_post_airfield();
  level thread play_counter_attack();
  level thread play_level_ending();
}

play_post_airfield() {
  wait(5);
  level waittill("obj_airfield_complete");
  setmusicstate("POST_AIRFIELD");
  battlechatter_off();
}

play_counter_attack() {
  wait(5);
  level waittill("aw_shit");
  setmusicstate("COUNTER_ATTACK");
  setbusstate("COUNTER_ATTACK");
  wait(6);
  battlechatter_on();
}

play_level_ending() {
  wait(2);
  level waittill("here_it_comes");
  setmusicstate("LEVEL_END");
  setbusstate("LEVEL_END");
  battlechatter_off();
}

plane_crash_move_shockwave() {
  wait(6.5);
  origin_left = getent("plane_explosion_left", "targetname");
  origin_right = getent("plane_explosion_right", "targetname");
  target_left = getent(origin_left.target, "targetname");
  target_right = getent(origin_right.target, "targetname");
  ent1 = spawn("script_origin", origin_left.origin);
  ent2 = spawn("script_origin", origin_right.origin);
  ent1 playsound("bomber_shockwave_l");
  ent2 playsound("bomber_shockwave_r");
  ent1 moveto(target_left.origin, 7.5);
  ent2 moveto(target_right.origin, 7.5);
}

line_to_me(guy) {
  self endon("movedone");
  while (1) {
    line(self.origin, guy.origin, (1, 1, 1));
    wait 0.05;
  }
}

play_flame_tree_loop(tree) {
  tree playloopsound("flame_tree_loop");
  wait(10);
  tree stoploopsound();
  playsoundatposition("flame_tree_stop_loop", tree.origin);
}