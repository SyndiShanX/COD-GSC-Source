/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_defend.gsc
**************************************/

#include common_scripts\utility;
#include maps\_dialog;
#include maps\_objectives;
#include maps\_scene;
#include maps\_utility;
#include maps\blackout_util;

queue_pipes_drop() {
  level thread snd_pipe_shake(1, (1341, 2308, -324));
  level thread snd_pipe_shake(2, (1433, 2117, -333));
  level thread snd_pipe_steam(1, (1341, 2308, -324));
  level thread snd_pipe_steam(2, (1433, 2117, -333));
  level thread snd_pipe_steam_lrg(1, (1308, 1804, -272));
  level thread snd_pipe_steam_lrg_2(1, (1341, 2308, -324));
  level thread snd_pipe_steam_lrg_2(2, (1433, 2117, -333));
  t_look = trigger_wait("sensitive_pipes_start");
  t_look delete();
  wait 0.5;
  level notify("fxanim_pipes_block_start");
  level clientnotify("fog_level_increase");
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.8, 1, level.player.origin, 1000, level.player);
  level notify("fxanim_pipes_break_loop_02_start");
  playsoundatposition("evt_pipe_blast", (1433, 2117, -333));
  earthquake(0.1, 12, level.player.origin, 1000, level.player);
  wait 12;
  level notify("fxanim_pipes_break_burst_02_start");
  level clientnotify("fog_level_increase");
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.5, 1, level.player.origin, 1000, level.player);
  level notify("fxanim_pipes_break_loop_01_start");
  playsoundatposition("evt_pipe_blast", (1341, 2308, -324));
  earthquake(0.1, 10, level.player.origin, 1000, level.player);
  wait 10;
  level notify("fxanim_pipes_break_burst_01_start");
  level clientnotify("fog_level_increase");
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.3, 0.75, level.player.origin, 1000, level.player);
}

snd_pipe_shake(num, origin) {
  level waittill("fxanim_pipes_break_loop_0" + num + "_start");
  ent = spawn("script_origin", origin);
  ent playloopsound("evt_pipe_rattle_" + num);
  level waittill("fxanim_pipes_break_burst_0" + num + "_start");
  ent delete();
}

snd_pipe_steam(num, origin) {
  level waittill("fxanim_pipes_break_loop_0" + num + "_start");
  ent = spawn("script_origin", origin);
  ent playloopsound("evt_pipe_damage_" + num);
  level waittill("fxanim_pipes_break_burst_0" + num + "_start");
  wait 1;
  ent delete();
}

snd_pipe_steam_lrg(num, origin) {
  level waittill("fxanim_pipes_block_start");
  ent = spawn("script_origin", origin);
  ent playloopsound("evt_pipe_damage_lrg");
  wait 15;
  ent delete();
}

snd_pipe_steam_lrg_2(num, origin) {
  level waittill("fxanim_pipes_break_burst_0" + num + "_start");
  ent = spawn("script_origin", origin);
  ent playloopsound("evt_pipe_damage_lrg");
  wait 15;
  ent delete();
}

door_open(door_name, delete_door) {
  door = getent(door_name, "targetname");
  door connectpaths();

  if(isDefined(delete_door)) {
    if(delete_door)
      door delete();
  }
}

door_breach_right() {
  run_scene_and_delete("door_bash_right");
  door_open("defend_door_right");
  level thread queue_pipes_drop();
}

door_breach_left() {
  flag_wait("sensitive_door_breach_left");
  run_scene_and_delete("door_bash_left");
  door_open("defend_door_left");
}

init_doors() {
  run_scene_first_frame("door_bash_right", 1);
  run_scene_first_frame("door_bash_left", 1);
  wait_network_frame();
  m_door_left = get_model_or_models_from_scene("door_bash_left", "defend_door_left");
  m_door_left.collision = get_ent("sensitive_room_door_breach_left_clip", "targetname");
  m_door_left.collision linkto(m_door_left, "tag_animate");
  m_door_right = get_model_or_models_from_scene("door_bash_right", "defend_door_right");
  m_door_right.collision = get_ent("sensitive_room_door_breach_right_clip", "targetname");
  m_door_right.collision linkto(m_door_right, "tag_animate");
}