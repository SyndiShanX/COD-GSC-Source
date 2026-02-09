/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cosmodrome_eggs.gsc
*******************************************/

#include animscripts\zombie_utility;
#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_ambientpackage;
#include maps\_music;
#include maps\_busing;
#include maps\_zombiemode_audio;

init() {
  PreCacheModel("p_glo_electrical_transformer");
  PreCacheModel("p_zom_monitor_csm_screen_on");
  PreCacheModel("p_zom_monitor_csm_screen_logo");
  PreCacheModel("p_rus_electric_switch_stop");
  PreCacheModel("p_rus_clock_lrg");
  flag_init("target_teleported");
  flag_init("rerouted_power");
  flag_init("switches_synced");
  flag_init("pressure_sustained");
  flag_init("passkey_confirmed");
  flag_init("weapons_combined");
  level.casimir_lights = [];
  level.lander_letters["a"] = GetEnt("letter_a", "targetname");
  level.lander_letters["e"] = GetEnt("letter_e", "targetname");
  level.lander_letters["h"] = GetEnt("letter_h", "targetname");
  level.lander_letters["i"] = GetEnt("letter_i", "targetname");
  level.lander_letters["l"] = GetEnt("letter_l", "targetname");
  level.lander_letters["m"] = GetEnt("letter_m", "targetname");
  level.lander_letters["n"] = GetEnt("letter_n", "targetname");
  level.lander_letters["r"] = GetEnt("letter_r", "targetname");
  level.lander_letters["s"] = GetEnt("letter_s", "targetname");
  level.lander_letters["t"] = GetEnt("letter_t", "targetname");
  level.lander_letters["u"] = GetEnt("letter_u", "targetname");
  level.lander_letters["y"] = GetEnt("letter_y", "targetname");
  keys = GetArrayKeys(level.lander_letters);
  for(i = 0; i < keys.size; i++) {
    level.lander_letters[keys[i]] Hide();
  }
  teleport_target_event();
  reroute_power_event();
  sync_switch_event();
  pressure_plate_event();
  lander_passkey_event();
  weapon_combo_event();
  level notify("help_found");
  monitor = GetEnt("casimir_monitor", "targetname");
  monitor setModel("p_zom_monitor_csm_screen_off");
}
play_easter_egg_audio(alias, sound_ent, text) {
  if(alias == undefined) {
    return;
  }
  sound_ent playSound(alias, "sounddone");
  sound_ent waittill("sounddone");
}
activate_casimir_light(num) {
  spot = GetStruct("casimir_light_" + num, "targetname");
  if(isDefined(spot)) {
    light = spawn("script_model", spot.origin);
    light setModel("tag_origin");
    light.angles = spot.angles;
    fx = playFXOnTag(level._effect["fx_zmb_light_floodlight_bright"], light, "tag_origin");
    level.casimir_lights[level.casimir_lights.size] = light;
  }
}
teleport_target_event() {
  teleport_target_start = getstruct("teleport_target_start", "targetname");
  teleport_target_spark = getstruct("teleport_target_spark", "targetname");
  level.teleport_target = spawn("script_model", teleport_target_start.origin);
  level.teleport_target setModel("p_glo_electrical_transformer");
  level.teleport_target.angles = teleport_target_start.angles;
  level.teleport_target playLoopSound("zmb_egg_notifier", 1);
  teleport_target_spark = spawn("script_model", teleport_target_spark.origin);
  teleport_target_spark setModel("tag_origin");
  playFXOnTag(level._effect["switch_sparks"], teleport_target_spark, "tag_origin");
  level.teleport_target_trigger = spawn("trigger_radius", teleport_target_start.origin + (0, 0, -70), 0, 125, 100);
  level.black_hole_bomb_loc_check_func = ::bhb_teleport_loc_check;
  flag_wait("target_teleported");
  teleport_target_spark Delete();
  level.black_hole_bomb_loc_check_func = undefined;
  level thread play_egg_vox("vox_ann_egg1_success", "vox_gersh_egg1", 1);
}
bhb_teleport_loc_check(grenade, model, info) {
  if(isDefined(level.teleport_target_trigger) && grenade IsTouching(level.teleport_target_trigger)) {
    model SetClientFlag(level._SCRIPTMOVER_CLIENT_FLAG_BLACKHOLE);
    grenade thread maps\_zombiemode_weap_black_hole_bomb::do_black_hole_bomb_sound(model, info);
    level thread teleport_target(grenade, model);
    return true;
  }
  return false;
}
teleport_target(grenade, model) {
  level.teleport_target_trigger Delete();
  level.teleport_target_trigger = undefined;
  wait(1.0);
  time = 3.0;
  level.teleport_target MoveTo(grenade.origin + (0, 0, 50), time, time - 0.05);
  wait(time);
  teleport_target_end = getstruct("teleport_target_end", "targetname");
  level.teleport_target Hide();
  playsoundatposition("zmb_gersh_teleporter_out", grenade.origin + (0, 0, 50));
  wait(0.5);
  level.teleport_target.angles = teleport_target_end.angles;
  level.teleport_target MoveTo(teleport_target_end.origin, 0.05);
  level.teleport_target StopLoopSound(1);
  wait(0.5);
  level.teleport_target Show();
  playFXOnTag(level._effect["black_hole_bomb_event_horizon"], level.teleport_target, "tag_origin");
  level.teleport_target playSound("zmb_gersh_teleporter_go");
  wait(2.0);
  model Delete();
  flag_set("target_teleported");
}
reroute_power_event() {
  monitor = GetEnt("casimir_monitor", "targetname");
  location = GetStruct("casimir_monitor_struct", "targetname");
  monitor playLoopSound("zmb_egg_notifier", 1);
  monitor setModel("p_zom_monitor_csm_screen_on");
  trig = spawn("trigger_radius", location.origin, 0, 32, 60);
  trig wait_for_use(monitor);
  trig delete();
  flag_set("rerouted_power");
  monitor setModel("p_zom_monitor_csm_screen_logo");
  monitor StopLoopSound(1);
  level thread play_egg_vox("vox_ann_egg2_success", "vox_gersh_egg2", 2);
  level thread activate_casimir_light(1);
}
wait_for_use(monitor) {
  while(1) {
    self waittill("trigger", who);
    while(isPlayer(who) && who IsTouching(self)) {
      if(who UseButtonPressed()) {
        flag_set("rerouted_power");
        monitor playSound("zmb_comp_activate");
        return;
      }
      wait(.05);
    }
  }
}
sync_switch_event() {
  switches = GetStructArray("sync_switch_start", "targetname");
  success = false;
  while(!flag("switches_synced")) {
    flag_wait("monkey_round");
    array_thread(switches, ::reveal_switch);
    self thread switch_watcher();
    level waittill_either("between_round_over", "switches_synced");
  }
  level thread play_egg_vox("vox_ann_egg3_success", "vox_gersh_egg3", 3);
  level thread activate_casimir_light(2);
}
reveal_switch() {
  button = spawn("script_model", self.origin);
  button setModel("p_rus_electric_switch_stop");
  button.angles = self.angles + (0, 90, 0);
  button playLoopSound("zmb_egg_notifier", 1);
  offset = anglesToForward(self.angles) * 8;
  time = 1;
  button MoveTo(button.origin + offset, 1);
  wait(1);
  if(flag("monkey_round")) {
    trig = spawn("trigger_radius", button.origin, 0, 32, 72);
    trig thread wait_for_sync_use(self);
    level waittill_either("between_round_over", "switches_synced");
    trig delete();
  }
  button StopLoopSound(1);
  button MoveTo(self.origin, time);
  wait(time);
  button delete();
}
wait_for_sync_use(ss) {
  level endon("between_round_over");
  level endon("switches_synced");
  ss.pressed = 0;
  while(1) {
    self waittill("trigger", who);
    while(isPlayer(who) && who IsTouching(self)) {
      if(who UseButtonPressed()) {
        level notify("sync_button_pressed");
        playsoundatposition("zmb_push_button", ss.origin);
        ss.pressed = 1;
      }
      wait(.05);
    }
  }
}
switch_watcher() {
  level endon("between_round_over");
  pressed = 0;
  switches = GetStructArray("sync_switch_start", "targetname");
  while(1) {
    level waittill("sync_button_pressed");
    timeout = GetTime() + 500;
    while(GetTime() < timeout) {
      pressed = 0;
      for(i = 0; i < switches.size; i++) {
        if(isDefined(switches[i].pressed) && switches[i].pressed) {
          pressed++;
        }
      }
      if(pressed == 4) {
        flag_set("switches_synced");
        for(i = 0; i < switches.size; i++) {
          playsoundatposition("zmb_misc_activate", switches[i].origin);
        }
        return;
      }
      wait(0.05);
    }
    switch (pressed) {
      case 1:
      case 2:
      case 3:
        for(i = 0; i < switches.size; i++) {
          playsoundatposition("zmb_deny", switches[i].origin);
        }
        break;
    }
    for(i = 0; i < switches.size; i++) {
      switches[i].pressed = 0;
    }
  }
}
pressure_plate_event() {
  area = GetStruct("pressure_pad", "targetname");
  trig = spawn("trigger_radius", area.origin, 0, 300, 100);
  trig area_timer(120);
  trig Delete();
  level thread play_egg_vox("vox_ann_egg4_success", "vox_gersh_egg4", 4);
  level thread activate_casimir_light(3);
}
area_timer(time) {
  clock_loc = GetStruct("pressure_timer", "targetname");
  clock = spawn("script_model", clock_loc.origin);
  clock setModel("p_rus_clock_lrg");
  clock.angles = clock_loc.angles;
  clock playLoopSound("zmb_egg_notifier", 1);
  timer_hand_angles_init = (270, 90, 0);
  timer_hand = spawn("script_model", clock_loc.origin + (-1, 0, 12));
  timer_hand setModel("t5_weapon_ballistic_knife_blade");
  timer_hand.angles = timer_hand_angles_init;
  step = 1.0;
  while(!flag("pressure_sustained")) {
    self waittill("trigger");
    stop_timer = false;
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(!players[i] IsTouching(self)) {
        wait(step);
        stop_timer = true;
      }
    }
    if(stop_timer) {
      continue;
    }
    self playSound("zmb_pressure_plate_trigger");
    time_remaining = time;
    timer_hand RotatePitch(360, time);
    while(time_remaining) {
      players = get_players();
      for(i = 0; i < players.size; i++) {
        if(!players[i] IsTouching(self)) {
          wait(step);
          time_remaining = time;
          stop_timer = true;
          timer_hand RotateTo(timer_hand_angles_init, 0.5);
          timer_hand playSound("zmb_deny");
          wait(0.5);
          break;
        }
      }
      if(stop_timer) {
        break;
      }
      wait(step);
      time_remaining -= step;
      timer_hand playSound("zmb_egg_timer_oneshot");
    }
    if(time_remaining <= 0) {
      flag_set("pressure_sustained");
      players = get_players();
      temp_fx = undefined;
      if(isDefined(players[0].fx)) {
        temp_fx = players[0].fx;
      }
      timer_hand playSound("zmb_perks_packa_ready");
      players[0].fx = level.zombie_powerups["nuke"].fx;
      level thread maps\_zombiemode_powerups::nuke_powerup(players[0]);
      clock StopLoopSound(1);
      wait(1.0);
      if(isDefined(temp_fx)) {
        players[0].fx = temp_fx;
      } else {
        players[0].fx = undefined;
      }
      clock Delete();
      timer_hand Delete();
      return;
    }
  }
}
lander_passkey_event() {
  flag_init("letter_acquired");
  level.lander_key = [];
  level.lander_key["lander_station1"]["lander_station3"] = "s";
  level.lander_key["lander_station1"]["lander_station4"] = "r";
  level.lander_key["lander_station1"]["lander_station5"] = "e";
  level.lander_key["lander_station3"]["lander_station1"] = "y";
  level.lander_key["lander_station3"]["lander_station4"] = "a";
  level.lander_key["lander_station3"]["lander_station5"] = "i";
  level.lander_key["lander_station4"]["lander_station1"] = "m";
  level.lander_key["lander_station4"]["lander_station3"] = "h";
  level.lander_key["lander_station4"]["lander_station5"] = "u";
  level.lander_key["lander_station5"]["lander_station1"] = "t";
  level.lander_key["lander_station5"]["lander_station3"] = "n";
  level.lander_key["lander_station5"]["lander_station4"] = "l";
  level.passkey = array("l", "u", "n", "a");
  level.passkey_progress = 0;
  level.secret1 = array("h", "i", "t", "s", "a", "m");
  level.secret1_progress = 0;
  level.secret2 = array("h", "y", "e", "n", "a");
  level.secret2_progress = 0;
  thread lander_monitor();
  flag_wait("passkey_confirmed");
  level.lander_audio_ent StopLoopSound(1);
  level thread play_egg_vox("vox_ann_egg5_success", "vox_gersh_egg5", 5);
  level thread activate_casimir_light(4);
  wait(1);
  level.lander_audio_ent Delete();
}
lander_monitor() {
  lander = getent("lander", "targetname");
  level.lander_audio_ent = spawn("script_origin", lander.origin);
  level.lander_audio_ent LinkTo(lander);
  level.lander_audio_ent playLoopSound("zmb_egg_notifier", 1);
  while(!flag("passkey_confirmed")) {
    level waittill("lander_launched");
    if(lander.called) {
      start = lander.depart_station;
      dest = lander.station;
      letter = level.lander_key[start][dest];
      model = level.lander_letters[letter];
      model Show();
      model playSound("zmb_spawn_powerup");
      model thread spin_letter();
      model playLoopSound("zmb_spawn_powerup_loop", .5);
      trig = spawn("trigger_radius", model.origin, 0, 200, 150);
      trig thread letter_grab(letter, model);
      flag_wait("lander_grounded");
      if(!flag("letter_acquired")) {
        level.passkey_progress = 0;
        level.secret1_progress = 0;
        level.secret2_progress = 0;
      } else {
        flag_clear("letter_acquired");
      }
      trig delete();
      model Hide();
      model StopLoopSound(.5);
    } else {
      level.passkey_progress = 0;
      level.secret1_progress = 0;
      level.secret2_progress = 0;
    }
  }
}
spin_letter() {
  level endon("lander_grounded");
  level endon("letter_acquired");
  while(1) {
    self RotateYaw(90, 5);
    wait(5);
  }
}
letter_grab(letter, model) {
  level endon("lander_grounded");
  self waittill("trigger");
  flag_set("letter_acquired");
  playsoundatposition("zmb_powerup_grabbed", model.origin);
  model Hide();
  if(letter == level.passkey[level.passkey_progress]) {
    level.passkey_progress++;
    if(level.passkey_progress == level.passkey.size) {
      flag_set("passkey_confirmed");
    }
  } else {
    level.passkey_progress = 0;
  }
  if(letter == level.secret1[level.secret1_progress]) {
    level.secret1_progress++;
    if(level.secret1_progress == level.secret1.size) {}
  } else {
    level.secret1_progress = 0;
  }
  if(letter == level.secret2[level.secret2_progress]) {
    level.secret2_progress++;
    if(level.secret2_progress == level.secret2.size) {}
  } else {
    level.secret2_progress = 0;
  }
}
weapon_combo_event() {
  flag_init("thundergun_hit");
  weapon_combo_spot = GetStruct("weapon_combo_spot", "targetname");
  focal_point = spawn("script_model", weapon_combo_spot.origin);
  focal_point setModel("tag_origin");
  focal_point playLoopSound("zmb_egg_notifier", 1);
  fx = playFXOnTag(level._effect["gersh_spark"], focal_point, "tag_origin");
  level.black_hold_bomb_target_trig = spawn("trigger_radius", weapon_combo_spot.origin, 0, 50, 72);
  level.black_hole_bomb_loc_check_func = ::bhb_combo_loc_check;
  flag_wait("weapons_combined");
  level.black_hold_bomb_target_trig Delete();
  level.black_hole_bomb_loc_check_func = undefined;
  focal_point Delete();
  for(i = 0; i < level.casimir_lights.size; i++) {
    level.casimir_lights[i] Delete();
  }
}
bhb_combo_loc_check(grenade, model, info) {
  if(isDefined(level.black_hold_bomb_target_trig) &&
    grenade IsTouching(level.black_hold_bomb_target_trig)) {
    trig = spawn("trigger_damage", grenade.origin, 0, 15, 72);
    grenade thread wait_for_combo(trig);
  }
  return false;
}
wait_for_combo(trig) {
  self endon("death");
  self thread kill_trig_on_death(trig);
  weapon_combo_spot = GetStruct("weapon_combo_spot", "targetname");
  ray_gun_hit = false;
  doll_hit = false;
  crossbow_hit = false;
  players = get_players();
  array_thread(players, ::thundergun_check, self, trig, weapon_combo_spot);
  while(1) {
    trig waittill("damage", amount, attacker, dir, org, mod);
    if(isDefined(attacker)) {
      if(mod == "MOD_PROJECTILE_SPLASH" && (attacker GetCurrentWeapon() == "ray_gun_upgraded_zm")) {
        ray_gun_hit = true;
      } else if(mod == "MOD_GRENADE_SPLASH") {
        if(amount >= 90000) {
          doll_hit = true;
        } else if(attacker GetCurrentWeapon() == "crossbow_explosive_upgraded_zm") {
          crossbow_hit = true;
        }
      }
      if(ray_gun_hit && doll_hit && flag("thundergun_hit")) {
        flag_set("weapons_combined");
        level thread soul_release(self, trig.origin);
        return;
      }
    }
  }
}
thundergun_check(model, trig, weapon_combo_spot) {
  model endon("death");
  while(1) {
    self waittill("weapon_fired");
    if(self GetCurrentWeapon() == "thundergun_upgraded_zm") {
      if(DistanceSquared(self.origin, weapon_combo_spot.origin) < 90000) {
        vector_to_spot = VectorNormalize(weapon_combo_spot.origin - self GetWeaponMuzzlePoint());
        vector_player_facing = self GetWeaponForwardDir();
        angle_diff = acos(VectorDot(vector_to_spot, vector_player_facing));
        if(angle_diff <= 10) {
          flag_set("thundergun_hit");
          RadiusDamage(trig.origin, 5, 1, 1, self);
        }
      }
    }
  }
}
kill_trig_on_death(trig) {
  self waittill("death");
  trig delete();
  if(flag("thundergun_hit") && !flag("weapons_combined")) {
    level thread play_egg_vox("vox_ann_egg6p1_success", "vox_gersh_egg6_fail2", 7);
  } else if(!flag("weapons_combined")) {
    level thread play_egg_vox(undefined, "vox_gersh_egg6_fail1", 6);
  }
  flag_clear("thundergun_hit");
}
soul_release(model, origin) {
  soul = spawn("script_model", origin);
  soul setModel("tag_origin");
  soul playLoopSound("zmb_egg_soul");
  fx = playFXOnTag(level._effect["gersh_spark"], soul, "tag_origin");
  time = 20;
  model waittill("death");
  level thread play_egg_vox("vox_ann_egg6_success", "vox_gersh_egg6_success", 9);
  level thread wait_for_gersh_vox();
  soul MoveZ(2500, time, time - 1);
  wait(time);
  soul Delete();
  wait(2);
  level thread samantha_is_angry();
}
wait_for_gersh_vox() {
  wait(12.5);
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] thread reward_wait();
  }
}
reward_wait() {
  while(!is_player_valid(self) || (self UseButtonPressed() && self in_revive_trigger())) {
    wait(1.0);
  }
  level thread maps\_zombiemode_powerups::minigun_weapon_powerup(self, 90);
}
play_egg_vox(ann_alias, gersh_alias, plr_num) {
  if(isDefined(ann_alias)) {
    level maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox(ann_alias);
  }
  if(isDefined(gersh_alias)) {
    level maps\zombie_cosmodrome_amb::play_gersh_vox(gersh_alias);
  }
  if(isDefined(plr_num)) {
    players = get_players();
    rand = RandomIntRange(0, players.size);
    players[rand] maps\_zombiemode_audio::create_and_play_dialog("eggs", "gersh_response", undefined, plr_num);
  }
}
samantha_is_angry() {
  playsoundatposition("zmb_samantha_earthquake", (0, 0, 0));
  playsoundatposition("zmb_samantha_whispers", (0, 0, 0));
  wait(6);
  level clientnotify("sia");
  playsoundatposition("zmb_samantha_scream", (0, 0, 0));
}