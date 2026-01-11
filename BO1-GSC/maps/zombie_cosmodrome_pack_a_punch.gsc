/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cosmodrome_pack_a_punch.gsc
***************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

pack_a_punch_main() {
  flag_init("lander_a_used");
  flag_init("lander_b_used");
  flag_init("lander_c_used");
  flag_init("launch_activated");
  flag_init("launch_complete");
  level.pack_debug = 0;
  level.pack_a_punch_door = getEnt("rocket_room_bottom_door", "targetname");
  level.pack_a_punch_door.clip = getEnt(level.pack_a_punch_door.target, "targetname");
  level.pack_a_punch_door.clip LinkTo(level.pack_a_punch_door);
  launch_trig = getEnt("trig_launch_rocket", "targetname");
  launch_trig thread launch_rocket();
  level thread pack_a_punch_activate();
  level thread rocket_launch_preparation();
}

pack_a_punch_activate() {
  if(getDvar("rocket_test") != "") {
    flag_set("lander_a_used");
    flag_set("lander_b_used");
    flag_set("lander_c_used");
  }
  flag_wait("lander_a_used");
  flag_wait("lander_b_used");
  flag_wait("lander_c_used");
  level thread move_rocket_arm();
  wait(4);
  flag_wait("launch_complete");
  pack_print("punch activate");
  level thread pack_a_punch_open_door();
}

move_rocket_arm() {
  wait(5.5);
  maps\zombie_cosmodrome_traps::link_rocket_pieces();
  level thread maps\zombie_cosmodrome_traps::rocket_arm_sounds();
  level maps\zombie_cosmodrome_traps::move_lifter_away();
  maps\zombie_cosmodrome_traps::unlink_rocket_pieces();
}

rocket_launch_preparation() {
  level waittill("new_lander_used");
  exploder(5601);
  level waittill("new_lander_used");
  wait(6);
  level notify("rocket_lights_on");
}

pack_a_punch_close_door() {
  move_dist = -228;
  level.pack_a_punch_door MoveZ(move_dist, 1.5);
  level.pack_a_punch_door waittill("movedone");
  level.pack_a_punch_door DisconnectPaths();
}

pack_a_punch_open_door() {
  flag_set("rocket_group");
  upper_door_model = getEnt("rocket_room_top_door", "targetname");
  upper_door_model.clip = getEnt(upper_door_model.target, "targetname");
  upper_door_model.clip LinkTo(upper_door_model);
  upper_door_model moveTo(upper_door_model.origin + upper_door_model.script_vector, 1.5);
  level.pack_a_punch_door moveTo(level.pack_a_punch_door.origin + level.pack_a_punch_door.script_vector, 1.5);
  level.pack_a_punch_door.clip NotSolid();
  upper_door_model playSound("zmb_heavy_door_open");
  level.pack_a_punch_door.clip playSound("zmb_heavy_door_open");
  level.pack_a_punch_door waittill("movedone");
  level.pack_a_punch_door.clip ConnectPaths();
}

pack_print(str) {}
launch_rocket() {
  panel = getEnt("rocket_launch_panel", "targetname");
  self UseTriggerRequireLookAt();
  self SetHintString(&"ZOMBIE_NEED_POWER");
  self SetCursorHint("HINT_NOICON");
  level waittill("Pack_A_Punch_on");
  self setHintString(&"ZOMBIE_COSMODROME_WAITING_AUTHORIZAION");
  flag_wait("launch_activated");
  self setHintString(&"ZOMBIE_COSMODROME_LAUNCH_AVAILABLE");
  panel setModel("p_zom_key_console_01");
  self waittill("trigger", who);
  panel playSound("zmb_comp_activate");
  level thread maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_launch_button");
  level thread do_launch_countdown();
  self delete();
}

play_launch_loopers() {
  level endon("rocket_dmg");
  level.rocket_base_looper = getEnt("rocket_base_engine", "script_noteworthy");
  level.rocket_base_looper playLoopSound("zmb_rocket_launch", .1);
  wait(2);
  level.rocket_sound_ent_1 = spawn("script_origin", (0, 0, 0));
  level.rocket_sound_ent_2 = spawn("script_origin", (0, 0, 0));
  level.rocket_sound_ent_1 playLoopSound("zmb_rocket_air_distf", .1);
  level.rocket_sound_ent_2 playLoopSound("zmb_rocket_air_distr", .1);
  wait(22);
  level.rocket_base_looper stopLoopSound(1);
  wait(46);
  level.rocket_sound_ent_1 stopLoopSound(1);
  level.rocket_sound_ent_2 stopLoopSound(1);
  level thread delete_rocket_sound_ents();
}

delete_rocket_sound_ents() {
  wait(5);
  level.rocket_sound_ent_1 Delete();
  level.rocket_sound_ent_2 Delete();
}

do_launch_countdown() {
  level.gantry_r rotateyaw(60, 6);
  level.gantry_l rotateyaw(-60, 6);
  level.gantry_l playSound("zmb_rocket_disengage");
  level.gantry_l playSound("zmb_rocket_start");
  wait(3);
  rocket_base = getEnt("rocket_base_engine", "script_noteworthy");
  level thread play_launch_loopers();
  maps\zombie_cosmodrome_traps::claw_attach(level.claw_arm_l, "claw_l");
  maps\zombie_cosmodrome_traps::claw_attach(level.claw_arm_r, "claw_r");
  wait(2);
  for(i = 5; i > 0; i--) {
    level thread maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_launch_countdown_" + i, true, true);
    wait(1);
    if(i == 4) {
      level.claw_arm_r moveTo(level.claw_retract_r_pos, 4.0);
      level.claw_arm_l moveTo(level.claw_retract_l_pos, 4.0);
    }
  }
  rocket_liftoff();
}

rocket_liftoff() {
  rocket_pieces = getEntArray(level.rocket.target, "targetname");
  for(i = 0; i < rocket_pieces.size; i++) {
    rocket_pieces[i] linkto(level.rocket);
  }
  level endon("rocket_dmg");
  rocket_base = getEnt("rocket_base_engine", "script_noteworthy");
  stop_exploder(5601);
  exploder(5701);
  rocket_base setclientflag(0);
  level thread launch_rumble_and_quake();
  wait(1);
  level thread maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_engines_firing", true);
  level.rocket setforcenocull();
  level.rocket moveTo(level.rocket.origin + (0, 0, 50000), 50, 45);
  wait(5);
  maps\zombie_cosmodrome_traps::claw_detach(level.claw_arm_l, "claw_l");
  maps\zombie_cosmodrome_traps::claw_detach(level.claw_arm_r, "claw_r");
  level thread rocket_monitor_for_damage();
  wait(5);
  flag_set("launch_complete");
  level thread maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_after_launch");
  wait(20);
  level notify("stop_rumble");
  level.rocket waittill("movedone");
  rocket_pieces = getEntArray(level.rocket.target, "targetname");
  for(i = 0; i < rocket_pieces.size; i++) {
    rocket_pieces[i] delete();
  }
  level.rocket delete();
}

launch_rumble_and_quake() {
  level endon("stop_rumble");
  level endon("stop_rumble_dmg");
  while(isDefined(level.rocket)) {
    players = get_players();
    players_in_range = [];
    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, level.rocket.origin) < (5500 * 5500)) {
        players_in_range[players_in_range.size] = players[i];
      }
    }
    if(players_in_range.size < 1) {
      wait(.1);
      continue;
    }
    Earthquake(RandomFloatRange(0.15, 0.35), RandomFloatRange(.25, .5), level.rocket.origin, 5500);
    rumble = "slide_rumble";
    for(i = 0; i < players_in_range.size; i++) {
      players_in_range[i] playRumbleOnEntity(rumble);
    }
    wait(.1);
  }
}

rocket_monitor_for_damage() {
  level endon("stop_rumble");
  rocket_pieces = getEntArray(level.rocket.target, "targetname");
  array_thread(rocket_pieces, ::rocket_piece_monitor_for_damage);
  level.rocket thread rocket_piece_monitor_for_damage();
  level waittill("rocket_dmg");
  playsoundatposition("zmb_rocket_destroyed", (0, 0, 0));
  level.rocket thread rocket_explode();
  level.rocket thread piece_crash_down();
  for(i = 0; i < rocket_pieces.size; i++) {
    rocket_pieces[i] unlink();
    rocket_pieces[i] thread piece_crash_down(i);
  }
  wait(.5);
  clientnotify("RX");
  wait(5);
  if(!flag("launch_complete")) {
    flag_set("launch_complete");
  }
}

piece_crash_down(num) {
  trace = bulletTrace(self.origin, self.origin + (randomintrange(-100, 100), randomintrange(-100, 100), -20000), false, self);
  ground_pos = trace["position"] + (0, 0, 1.5);
  self moveTo(ground_pos, 3);
  self rotateto((randomintrange(-360, 360), randomintrange(-360, 360), randomintrange(-360, 360)), 3.9);
  wait(3.9);
  Earthquake(RandomFloatRange(0.25, 0.45), RandomFloatRange(.65, .75), self.origin, 5500);
  if(isDefined(num)) {
    if(num == 0) {
      self playSound("zmb_rocket_top_crash");
    }
    else if(num == 1) {
      self playSound("zmb_rocket_bottom_crash");
    }
  }
  wait(1);
  self hide();
  wait(10);
  self delete();
}

rocket_piece_monitor_for_damage() {
  level endon("no_rocket_damage");
  self setCanDamage(true);
  self waittill("damage", dmg_amount, attacker, dir, point, dmg_type);
  if(isplayer(attacker) && (dmg_type == "MOD_PROJECTILE" || dmg_type == "MOD_PROJECTILE_SPLASH" || dmg_type == "MOD_EXPLOSIVE" || dmg_type == "MOD_EXPLOSIVE_SPLASH" || dmg_type == "MOD_GRENADE" || dmg_type == "MOD_GRENADE_SPLASH")) {
    level notify("rocket_dmg");
    level.rocket_base_looper stopLoopSound(1);
    level.rocket_sound_ent_1 stopLoopSound(1);
    level.rocket_sound_ent_2 stopLoopSound(1);
    level thread delete_rocket_sound_ents();
  }
}

rocket_explode() {
  playFXOnTag(level._effect["rocket_exp_1"], self, "tag_origin");
  self playSound("zmb_rocket_stage_1_exp");
  wait(2.0);
  maps\_zombiemode_powerups::specific_powerup_drop("double_points", (1379, 380.5, -320));
}