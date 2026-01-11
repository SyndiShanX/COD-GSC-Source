/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_moon_digger.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

digger_init_flags() {
  level.diggers_global_time = 240.0;
  flag_init("teleporter_digger_hacked");
  flag_init("start_teleporter_digger");
  flag_init("start_hangar_digger");
  flag_init("hangar_digger_hacked");
  flag_init("start_biodome_digger");
  flag_init("biodome_digger_hacked");
  flag_init("hide_diggers");
  flag_init("init_diggers");
  flag_set("init_diggers");
  flag_init("teleporter_breached");
  flag_init("hangar_breached");
  flag_init("biodome_breached");
  flag_init("teleporter_blocked");
  flag_init("hangar_blocked");
  flag_init("both_tunnels_breached");
  flag_init("both_tunnels_blocked");
  flag_init("digger_moving");
  level.diggers = array("teleporter", "hangar", "biodome");
  if(!isDefined(level.digger_speed_multiplier)) {
    level.digger_speed_multiplier = 1;
  }
  if(isDefined(level.quantum_bomb_register_result_func)) {
    [[level.quantum_bomb_register_result_func]]("remove_digger", ::quantum_bomb_remove_digger_result, 75, ::quantum_bomb_remove_digger_validation);
  }
}

digger_init() {
  level thread setup_diggers();
}

setup_diggers() {
  level thread digger_think_panel("digger_hangar_blocker", "hangar_digger_switch", "start_hangar_digger", "hangar_digger_hacked", ::digger_think_blocker, "hangar");
  level thread digger_think_panel("digger_teleporter_blocker", "teleporter_digger_switch", "start_teleporter_digger", "teleporter_digger_hacked", ::digger_think_blocker, "teleporter");
  level thread digger_think_panel(undefined, "biodome_digger_switch", "start_biodome_digger", "biodome_digger_hacked", ::digger_think_biodome, "biodome");
  level thread diggers_think_no_mans_land();
  level thread digger_round_logic();
  diggers = getEntArray("digger_body", "targetname");
  array_thread(diggers, ::digger_think_move);
  level thread waitfor_smash();
  wait(.5);
  flag_clear("init_diggers");
}

digger_round_logic() {
  level endon("digger_logic_stop");
  flag_wait("power_on");
  wait(20.0);
  last_active_round = level.round_number;
  first_digger_activated = false;
  if(randomInt(100) >= 90) {
    digger_activate();
    last_active_round = level.round_number;
    first_digger_activated = true;
  }
  rnd = 0;
  while(!first_digger_activated) {
    level waittill("between_round_over");
    if(level flag_exists("teleporter_used") && flag("teleporter_used")) {
      continue;
    }
    if(randomInt(100) >= 90 || rnd > 2) {
      digger_activate();
      last_active_round = level.round_number;
      first_digger_activated = true;
    }
    rnd++;
  }
  while(1) {
    level waittill("between_round_over");
    if(level flag_exists("teleporter_used") && flag("teleporter_used")) {
      continue;
    }
    if(flag("digger_moving")) {
      continue;
    }
    if(level.round_number < 10) {
      min_activation_time = 3;
      max_activation_time = 8;
    } else {
      min_activation_time = 2;
      max_activation_time = 8;
    }
    diff = abs(level.round_number - last_active_round);
    if(diff >= min_activation_time && diff < max_activation_time) {
      if(randomInt(100) >= 80) {
        digger_activate();
        last_active_round = level.round_number;
      }
    } else if(diff >= max_activation_time) {
      digger_activate();
      last_active_round = level.round_number;
    }
  }
}

digger_activate(force_digger) {
  if(isDefined(force_digger)) {
    flag_set("start_" + force_digger + "_digger");
    level thread send_clientnotify(force_digger, false);
    level thread play_digger_start_vox(force_digger);
    wait(1);
    level notify(force_digger + "_vox_timer_stop");
    level thread play_timer_vox(force_digger);
    return;
  }
  non_active = [];
  for(i = 0; i < level.diggers.size; i++) {
    if(!flag("start_" + level.diggers[i] + "_digger")) {
      non_active[non_active.size] = level.diggers[i];
    }
  }
  if(non_active.size > 0) {
    digger_to_activate = random(non_active);
    flag_set("start_" + digger_to_activate + "_digger");
    level thread send_clientnotify(digger_to_activate, false);
    level thread play_digger_start_vox(digger_to_activate);
    wait(1);
    level thread play_timer_vox(digger_to_activate);
  }
}

play_digger_start_vox(digger_name) {
  level thread maps\zombie_moon_amb::play_mooncomp_vox("vox_mcomp_digger_start_", digger_name);
  wait(7);
  if(!is_true(level.on_the_moon)) {
    return;
  }
  players = get_players();
  players[randomintrange(0, players.size)] thread maps\_zombiemode_audio::create_and_play_dialog("digger", "incoming");
}

send_clientnotify(digger_name, pause) {
  switch (digger_name) {
    case "hangar":
      if(!pause) {
        clientnotify("Dz3");
      } else {
        clientnotify("Dz3e");
      }
      break;
    case "teleporter":
      if(!pause) {
        clientnotify("Dz2");
      } else {
        clientnotify("Dz2e");
      }
      break;
    case "biodome":
      if(!pause) {
        clientnotify("Dz5");
      } else {
        clientnotify("Dz5e");
      }
      break;
  }
}

digger_think_move() {
  targets = getEntArray(self.target, "targetname");
  if(targets[0].model == "p_zom_digger_body") {
    tracks = targets[0];
    arm = targets[1];
  } else {
    arm = targets[0];
    tracks = targets[1];
  }
  blade_center = getEnt(arm.target, "targetname");
  blade = getEnt(blade_center.target, "targetname");
  blade LinkTo(blade_center);
  blade_center LinkTo(arm);
  arm LinkTo(self);
  self linkto(tracks);
  tracks clearclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_MOVING_EARTHQUAKE_RUMBLE);
  arm clearclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_ARM_FX);
  switch (tracks.target) {
    case "hangar_vehicle_path":
      self.digger_name = "hangar";
      self.down_angle = -45;
      self.up_angle = 45;
      self.zones = array("cata_right_start_zone", "cata_right_middle_zone", "cata_right_end_zone");
      break;
    case "digger_path_teleporter":
      self.digger_name = "teleporter";
      self.down_angle = -52;
      self.up_angle = 52;
      self.zones = array("cata_left_middle_zone", "cata_left_start_zone");
      self.arm_lowered = false;
      break;
    case "digger_path_biodome":
      self.digger_name = "biodome";
      self.down_angle = -20;
      self.up_angle = 20;
      self.zones = array("forest_zone");
      break;
  }
  self.hacked_flag = self.digger_name + "_digger_hacked";
  self.start_flag = "start_" + self.digger_name + "_digger";
  self.arm_lowered = false;
  tracks digger_follow_path(self, undefined, arm);
  self endon(self.digger_name + "_digger_hacked");
  self stopLoopSound(2);
  self playSound("evt_dig_move_stop");
  self unlink();
  level.arm_move_speed = 11;
  level.blade_spin_speed = 80;
  level.blade_spin_up_time = 1;
  body_turn = RandomIntRange(-1, 1);
  body_turn_speed = max(1, abs(body_turn)) * .3;
  arm Unlink(self);
  arm.og_angles = arm.angles;
  self thread digger_arm_logic(arm, blade_center, tracks);
  self thread wait_for_digger_hack_digging(arm, blade_center, tracks);
  self thread wait_for_digger_hack_moving(arm, blade_center, tracks);
}

wait_for_digger_hack_digging(arm, blade_center, tracks) {
  self endon("stop_monitor");
  self waittill("digger_arm_raised");
  blade_center LinkTo(arm);
  arm LinkTo(self);
  self linkto(tracks);
  tracks digger_follow_path(self, true, arm);
  flag_clear(self.hacked_flag);
  flag_clear(self.start_flag);
  self thread digger_think_move();
}

wait_for_digger_hack_moving(arm, blade_center, tracks) {
  self endon("arm_lower");
  while(1) {
    level waittill("digger_hacked", digger_name);
    if(digger_name == self.digger_name) {
      flag_clear(self.hacked_flag);
      flag_clear(self.start_flag);
      self notify("stop_monitor");
      self thread digger_think_move();
      break;
    }
  }
}

digger_arm_breach_logic(arm, blade_center, tracks) {
  self endon(self.hacked_flag);
  wait(8);
  if(flag(self.hacked_flag)) {
    return;
  }
  level notify("digger_arm_smash", self.digger_name, self.zones);
  switch (self.digger_name) {
    case "hangar":
      exploder(101);
      flag_set("hangar_breached");
      flag_set("hangar_blocked");
      if(isDefined(level.tunnel_11_destroyed)) {
        level.tunnel_11_destroyed show();
      }
      clientnotify("sl1");
      clientnotify("sl7");
      level.zones["cata_right_start_zone"].adjacent_zones["cata_right_middle_zone"].is_connected = false;
      level.zones["cata_right_middle_zone"].adjacent_zones["cata_right_start_zone"].is_connected = false;
      break;
    case "teleporter":
      exploder(111);
      flag_set("teleporter_breached");
      flag_set("teleporter_blocked");
      if(isDefined(level.tunnel_6_destroyed)) {
        level.tunnel_6_destroyed show();
      }
      clientnotify("sl2");
      clientnotify("sl3");
      level.zones["airlock_west2_zone"].adjacent_zones["cata_left_middle_zone"].is_connected = false;
      level.zones["cata_left_middle_zone"].adjacent_zones["airlock_west2_zone"].is_connected = false;
      break;
    case "biodome":
      break;
  }
  if(flag("hangar_breached") && flag("teleporter_breached")) {
    flag_set("both_tunnels_breached");
  }
  if(flag("teleporter_blocked") && flag("hangar_blocked")) {
    flag_set("both_tunnels_blocked");
  } else {
    flag_clear("both_tunnels_blocked");
  }
  arm waittill("rotatedone");
  arm playSound("evt_dig_arm_stop");
  blade_center UnLink(arm);
  switch (self.digger_name) {
    case "hangar":
      blade_center playLoopSound("evt_dig_wheel_loop1", 1);
      break;
    case "teleporter":
      blade_center playLoopSound("evt_dig_wheel_loop1", 1);
      break;
    case "biodome":
      blade_center playLoopSound("evt_dig_wheel_loop2", 1);
      break;
  }
  blade_center setclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_DIGGING_EARTHQUAKE_RUMBLE);
  blade_center rotatePitch(720, 5, level.blade_spin_up_time, level.blade_spin_up_time);
  smokeAngles = (0, arm.angles[1] + 180, arm.angles[2]);
  forward = anglesToForward(smokeAngles);
  wait(2);
  self.arm_moving = undefined;
}

digger_arm_logic(arm, blade_center, tracks) {
  arm setclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_ARM_FX);
  tracks setclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_MOVING_EARTHQUAKE_RUMBLE);
  if(!flag(self.hacked_flag)) {
    if(!is_true(self.arm_lowered)) {
      self notify("arm_lower");
      self.arm_lowered = true;
      self.arm_moving = true;
      arm Unlink(self);
      arm playSound("evt_dig_arm_move");
      arm rotatePitch(self.down_angle, level.arm_move_speed, level.arm_move_speed / 4, level.arm_move_speed / 4);
      self thread digger_arm_breach_logic(arm, blade_center, tracks);
    }
    while(!flag(self.hacked_flag)) {
      blade_center rotatePitch(360, 3);
      wait(3);
    }
  }
  while(is_true(self.arm_moving) && !flag(self.hacked_flag)) {
    wait(.1);
  }
  if(is_true(self.arm_lowered)) {
    self.arm_moving = true;
    self.arm_lowered = false;
    blade_center stopLoopSound(2);
    blade_center clearclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_DIGGING_EARTHQUAKE_RUMBLE);
    blade_center LinkTo(arm);
    arm playSound("evt_dig_arm_move");
    arm rotatePitch(self.up_angle, level.arm_move_speed, level.arm_move_speed / 4, level.arm_move_speed / 4);
    wait(2);
    level notify("digger_arm_lift", self.digger_name);
    switch (self.digger_name) {
      case "hangar":
        stop_exploder(101);
        if(flag("tunnel_11_door1")) {
          level.zones["cata_right_start_zone"].adjacent_zones["cata_right_middle_zone"].is_connected = true;
          level.zones["cata_right_middle_zone"].adjacent_zones["cata_right_start_zone"].is_connected = true;
        }
        flag_clear("hangar_blocked");
        flag_clear("both_tunnels_blocked");
        break;
      case "teleporter":
        stop_exploder(111);
        if(flag("catacombs_west4")) {
          level.zones["airlock_west2_zone"].adjacent_zones["cata_left_middle_zone"].is_connected = true;
          level.zones["cata_left_middle_zone"].adjacent_zones["airlock_west2_zone"].is_connected = true;
        }
        flag_clear("teleporter_blocked");
        flag_clear("both_tunnels_blocked");
        break;
    }
    arm waittill("rotatedone");
    arm LinkTo(self);
    arm playSound("evt_dig_arm_stop");
    self.arm_moving = undefined;
  }
  self notify("digger_arm_raised");
}

digger_think_panel(blocker_name, trig_name, start_flag, hacked_flag, blocker_func, digger_name) {
  if(isDefined(blocker_name)) {
    dmg_trig = getEnt("digger_" + digger_name + "_dmg", "targetname");
    blocker = getEnt(blocker_name, "targetname");
    level thread[[blocker_func]](blocker, digger_name, dmg_trig);
  }
  if(!isDefined(blocker_name) && isDefined(blocker_func)) {
    level thread[[blocker_func]](digger_name);
  }
  trig = getEnt(trig_name, "targetname");
  struct = spawnStruct();
  struct.origin = trig.origin - (0, 0, 12);
  struct.script_int = -1000;
  struct.script_float = 5;
  struct.digger_name = digger_name;
  struct.hacked_flag = hacked_flag;
  struct.start_flag = start_flag;
  struct.custom_debug_color = (255, 0, 0);
  struct.radius = 64;
  struct.height = 64;
  struct.custom_string = &"ZOMBIE_MOON_DISABLE_DIGGER";
  struct.no_bullet_trace = true;
  struct.no_sight_check = true;
  trig UseTriggerRequireLookAt();
  trig setcursorhint("HINT_NOICON");
  trig thread maps\_zombiemode_equip_hacker::hide_hint_when_hackers_active();
  trig SetHintString(&"ZOMBIE_MOON_NO_HACK");
  trig thread set_hint_on_digger_trig(start_flag, hacked_flag, struct);
}

set_hint_on_digger_trig(start_flag, hacked_flag, struct) {
  while(1) {
    if(!flag(start_flag)) {
      maps\_zombiemode_equip_hacker::deregister_hackable_struct(struct);
      self sethintstring(&"ZOMBIE_MOON_NO_HACK");
    }
    while(!flag(start_flag)) {
      wait .05;
    }
    if(flag(start_flag) && !flag(hacked_flag)) {
      maps\_zombiemode_equip_hacker::register_pooled_hackable_struct(struct, ::digger_hack_func, ::digger_hack_qualifer);
      self sethintstring(&"ZOMBIE_MOON_SYSTEM_ONLINE");
      switch (struct.digger_name) {
        case "hangar":
          level clientnotify("HCA");
          break;
        case "teleporter":
          level clientnotify("TCA");
          break;
        case "biodome":
          level clientnotify("BCA");
          break;
      }
    }
    while(!flag(hacked_flag)) {
      wait .05;
    }
    if(flag(hacked_flag)) {
      maps\_zombiemode_equip_hacker::deregister_hackable_struct(struct);
      self sethintstring(&"ZOMBIE_MOON_NO_HACK");
      switch (struct.digger_name) {
        case "hangar":
          level clientnotify("HCO");
          break;
        case "teleporter":
          level clientnotify("TCO");
          break;
        case "biodome":
          level clientnotify("BCO");
          break;
      }
    }
    flag_waitopen(hacked_flag);
    wait(.05);
  }
}

digger_hack_func(hacker) {
  level thread send_clientnotify(self.digger_name, true);
  hacker thread maps\_zombiemode_audio::create_and_play_dialog("digger", "hacked");
  level thread delayed_computer_hacked_vox(self.digger_name);
  flag_set(self.hacked_flag);
  level notify(self.digger_name + "_vox_timer_stop");
  while(1) {
    level waittill("digger_reached_end", digger_name);
    if(digger_name == self.digger_name) {
      break;
    }
  }
  level notify("digger_hacked", self.digger_name);
}

delayed_computer_hacked_vox(digger) {
  wait(4);
  level thread maps\zombie_moon_amb::play_mooncomp_vox("vox_mcomp_digger_hacked_", digger);
}

digger_hack_qualifer(player) {
  if(!flag(self.hacked_flag)) {
    return true;
  }
  return false;
}

digger_think_biodome(digger_name) {
  while(1) {
    level waittill("digger_arm_smash", name, zones);
    if(name == digger_name) {
      flag_set("biodome_breached");
      level thread biodome_breach_fx();
      for(i = 0; i < zones.size; i++) {
        zone = zones[i];
        _zones = getEntArray(zone, "targetname");
        for(x = 0; x < _zones.size; x++) {
          _zones[x].script_string = "lowgravity";
        }
        level thread maps\zombie_moon_gravity::zone_breached(zone);
      }
      break;
    }
  }
}

biodome_breach_fx() {
  clientnotify("BIO");
  exploder(200);
}

digger_think_blocker(blocker, digger_name, dmg_trig) {
  dmg_trig trigger_off();
  dmg_trig thread digger_damage_player();
  level thread digger_think_blocker_remove(blocker, digger_name, dmg_trig);
  while(1) {
    level waittill("digger_arm_smash", name, zones);
    if(name == digger_name) {
      blocker movez(-512, .05, .05);
      blocker waittill("movedone");
      blocker disconnectpaths();
      blocker thread kill_anyone_touching_blocker();
      dmg_trig trigger_on();
      for(i = 0; i < zones.size; i++) {
        zone = zones[i];
        _zones = getEntArray(zone, "targetname");
        for(x = 0; x < _zones.size; x++) {
          _zones[x].script_string = "lowgravity";
        }
        level thread maps\zombie_moon_gravity::zone_breached(zone);
      }
    }
  }
}

digger_damage_player() {
  while(1) {
    self waittill("trigger", player);
    if(!is_player_valid(player) && !is_true(player._pushed)) {
      continue;
    }
    if(!player maps\_laststand::player_is_in_laststand()) {
      if(player hasperk("specialty_armorvest")) {
        player dodamage(100, player.origin);
      }
      level thread digger_push_player(self, player);
    }
  }
}

digger_push_player(trig, player) {
  player endon("disconnect");
  player._pushed = true;
  eye_org = trig.origin;
  foot_org = trig.origin;
  mid_org = trig.origin;
  explode_radius = 50;
  test_org = player getEye();
  dist = distance(eye_org, test_org);
  scale = 1.0 - (dist / explode_radius);
  if(scale < 0) {
    scale = 0;
  }
  pulse = randomintrange(20, 45);
  dir = (player.origin[0] - trig.origin[0], player.origin[1] - trig.origin[1], 0);
  dir = VectorNormalize(dir);
  dir += (0, 0, 1);
  dir *= pulse;
  player SetOrigin(player.origin + (0, 0, .1));
  player_velocity = dir;
  player SetVelocity(player_velocity);
  wait(2);
  player._pushed = undefined;
}

kill_anyone_touching_blocker() {
  self endon("stop_check");
  while(1) {
    if(isDefined(self.trigger_off)) {
      wait(.05);
      continue;
    }
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] istouching(self)) {
        if(!players[i] maps\_laststand::player_is_in_laststand()) {
          players[i] player_digger_instant_kill();
        }
      }
    }
    zombies = getaiarray("axis");
    for(i = 0; i < zombies.size; i++) {
      if(isDefined(zombies[i]) && zombies[i] istouching(self)) {
        zombies[i] thread zombie_ragdoll_death();
        wait_network_frame();
      }
    }
    wait(.1);
  }
}

player_digger_instant_kill() {
  self thread maps\zombie_moon::insta_kill_player();
}

zombie_ragdoll_death() {
  self endon("death");
  fwd = anglesToForward(flat_angle(self.angles));
  my_velocity = Vector_Scale(fwd, 200);
  my_velocity_with_lift = (my_velocity[0], my_velocity[1], 20);
  self LaunchRagdoll(my_velocity_with_lift, self.origin);
  wait_network_frame();
  self dodamage(self.health + 666, self.origin);
}

digger_think_blocker_remove(blocker, digger_name, dmg_trig) {
  while(1) {
    level waittill("digger_arm_lift", name);
    if(name == digger_name) {
      blocker connectpaths();
      blocker movez(512, .05, .05);
      dmg_trig trigger_off();
      blocker notify("stop_check");
    }
  }
}

diggers_think_no_mans_land() {
  level endon("intermission");
  diggers = getEntArray("digger_body", "targetname");
  while(1) {
    flag_wait("enter_nml");
    array_thread(diggers, ::diggers_visible, false);
    flag_waitopen("enter_nml");
    array_thread(diggers, ::diggers_visible, true);
  }
}

diggers_visible(visible) {
  targets = getEntArray(self.target, "targetname");
  if(targets[0].model == "p_zom_digger_body") {
    tracks = targets[0];
    arm = targets[1];
  } else {
    arm = targets[0];
    tracks = targets[1];
  }
  blade_center = getEnt(arm.target, "targetname");
  blade = getEnt(blade_center.target, "targetname");
  if(!visible) {
    level clientnotify("DH");
    blade hide();
    arm hide();
    tracks hide();
    self hide();
  } else {
    level clientnotify("DS");
    blade show();
    arm show();
    tracks show();
    self show();
  }
}

play_timer_vox(digger_name) {
  level endon(digger_name + "_vox_timer_stop");
  time_left = level.diggers_global_time;
  played180sec = false;
  played120sec = false;
  played60sec = false;
  played30sec = false;
  digger_start_time = GetTime();
  while(time_left > 0) {
    curr_time = GetTime();
    time_used = (curr_time - digger_start_time) / 1000.0;
    time_left = (level.diggers_global_time - time_used);
    if(time_left <= 180.0 && !played180sec) {
      level thread maps\zombie_moon_amb::play_mooncomp_vox("vox_mcomp_digger_start_", digger_name);
      played180sec = true;
    }
    if(time_left <= 120.0 && !played120sec) {
      level thread maps\zombie_moon_amb::play_mooncomp_vox("vox_mcomp_digger_start_", digger_name);
      played120sec = true;
    }
    if(time_left <= 60.0 && !played60sec) {
      level thread maps\zombie_moon_amb::play_mooncomp_vox("vox_mcomp_digger_time_60_", digger_name);
      played60sec = true;
    }
    if(time_left <= 30.0 && !played30sec) {
      level thread maps\zombie_moon_amb::play_mooncomp_vox("vox_mcomp_digger_time_30_", digger_name);
      played30sec = true;
    }
    wait(1.0);
  }
}

get_correct_times(digger) {
  level endon("digger_arm_smash");
  for(i = 0; i < 500; i++) {
    iprintlnbold(i);
    wait(1);
  }
}

waitfor_smash() {
  while(1) {
    level waittill("digger_arm_smash", digger, zones);
    level thread play_delayed_breach_vox(digger);
    level thread switch_ambient_packages(digger);
    level thread player_breach_vox(zones);
  }
}

switch_ambient_packages(digger) {
  switch (digger) {
    case "hangar":
      clientnotify("Az3b");
      level.audio_zones_breached["3b"] = true;
      flag_wait("tunnel_11_door1");
      clientnotify("Az3a");
      level.audio_zones_breached["3a"] = true;
      flag_wait("tunnel_11_door2");
      clientnotify("Az3c");
      level.audio_zones_breached["3c"] = true;
      break;
    case "teleporter":
      clientnotify("Az2b");
      level.audio_zones_breached["2b"] = true;
      flag_wait("tunnel_6_door1");
      clientnotify("Az2a");
      level.audio_zones_breached["2a"] = true;
      break;
    case "biodome":
      clientnotify("Az5");
      level.audio_zones_breached["5"] = true;
      break;
  }
}

play_delayed_breach_vox(digger) {
  if(!level.on_the_moon) {
    return;
  }
  playsoundatposition("evt_breach_alarm", (0, 0, 0));
  wait(1.5);
  if(!level.on_the_moon) {
    return;
  }
  playsoundatposition("evt_breach_alarm", (0, 0, 0));
  wait(1.5);
  if(!level.on_the_moon) {
    return;
  }
  playsoundatposition("evt_breach_alarm", (0, 0, 0));
  wait(2);
  level thread maps\zombie_moon_amb::play_mooncomp_vox("vox_mcomp_digger_breach_", digger);
}

player_breach_vox(zones) {
  players = get_players();
  for(i = 0; i < zones.size; i++) {
    zone = zones[i];
    _zones = getEntArray(zone, "targetname");
    for(x = 0; x < _zones.size; x++) {
      for(j = 0; j < players.size; j++) {
        if(is_player_valid(players[j]) && players[j] istouching(_zones[x])) {
          players[j] thread maps\_zombiemode_audio::create_and_play_dialog("digger", "breach");
        }
      }
    }
  }
}

link_vehicle_nodes(start_node) {
  start_node.previous_node = undefined;
  linked_nodes = [];
  linked_nodes[linked_nodes.size] = start_node;
  cur_node = start_node;
  while(1) {
    if(isDefined(cur_node.target)) {
      next_node = getvehiclenode(cur_node.target, "targetname");
      previous_node = cur_node;
      cur_node.next_node = next_node;
      cur_node = getvehiclenode(cur_node.target, "targetname");
      cur_node.previous_node = previous_node;
      linked_nodes[linked_nodes.size] = cur_node;
    } else {
      break;
    }
  }
  return linked_nodes;
}

digger_debug_star(origin, color, time) {}
digger_follow_path_calc_speed() {
  path_start_node = getvehiclenode(self.target, "targetname");
  number_nodes = 0;
  self.path_length = 0;
  start_node = path_start_node;
  while(isDefined(start_node.target)) {
    next_node = getvehiclenode(start_node.target, "targetname");
    if(isDefined(next_node)) {
      length = length(next_node.origin - start_node.origin);
      self.path_length = self.path_length + length;
      start_node = next_node;
      digger_debug_star(start_node.origin, (1, 1, 1), 1000);
      number_nodes++;
    }
  }
  self.digger_speed = self.path_length / level.diggers_global_time;
}

digger_follow_path_recalc_speed(path_start_node) {
  number_nodes = 0;
  self.path_length = 0;
  start_node = path_start_node;
  while(isDefined(start_node.target)) {
    next_node = getvehiclenode(start_node.target, "targetname");
    if(isDefined(next_node)) {
      length = length(next_node.origin - start_node.origin);
      self.path_length = self.path_length + length;
      start_node = next_node;
      digger_debug_star(start_node.origin, (1, 1, 1), 1000);
      number_nodes++;
    }
  }
  curr_time = GetTime();
  time_used = (curr_time - self.start_time) / 1000.0;
  time_left = (level.diggers_global_time - time_used);
  self.digger_speed = self.path_length / time_left;
}

digger_debugger_counter(time_to_help_them) {}
digger_follow_path(body, reverse, arm) {
  last_node = undefined;
  next_node_dir = undefined;
  direction = undefined;
  fraction = 0;
  reached_end = false;
  path_start_node = getvehiclenode(self.target, "targetname");
  linked_nodes = link_vehicle_nodes(path_start_node);
  self thread digger_follow_path_calc_speed();
  if(flag("init_diggers")) {
    self.origin = path_start_node.origin;
    self.angles = path_start_node.angles;
  }
  if(isDefined(body.start_flag)) {
    flag_wait(body.start_flag);
  }
  if(!isDefined(reverse)) {
    current_node = path_start_node;
    next_node = linked_nodes[0].next_node;
    fx_name = "digger_treadfx_fwd";
    flag_set("digger_moving");
  } else {
    current_node = linked_nodes[linked_nodes.size - 1];
    next_node = linked_nodes[linked_nodes.size - 1].previous_node;
    fx_name = "digger_treadfx_bkwd";
    self.digger_speed = 5.0;
    flag_clear("digger_moving");
  }
  body playSound("evt_dig_move_start");
  self setclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_MOVING_EARTHQUAKE_RUMBLE);
  arm setclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_ARM_FX);
  body playLoopSound("evt_dig_move_loop", .5);
  if(body.digger_name == "hangar") {
    exploder(102);
  } else if(body.digger_name == "teleporter") {
    exploder(112);
  }
  self.start_time = GetTime();
  level thread digger_debugger_counter(level.diggers_global_time);
  while(!reached_end) {
    if(flag(body.hacked_flag)) {
      direction = "bkwd";
      if(flag("digger_moving")) {
        flag_clear("digger_moving");
      }
    } else {
      if(!flag("digger_moving")) {
        flag_set("digger_moving");
      }
      direction = "fwd";
    }
    last_node_dir = (1, 0, 0);
    if(isDefined(last_node)) {
      last_node_dir = current_node.origin - last_node.origin;
      last_node_dir = VectorNormalize(last_node_dir);
    } else {
      last_node_dir = anglesToForward(self.angles);
    }
    curr_node_dir = next_node.origin - current_node.origin;
    curr_node_dir = VectorNormalize(curr_node_dir);
    if(direction == "fwd") {
      if(isDefined(current_node.next_node) && isDefined(current_node.next_node.next_node)) {
        next_node_dir = current_node.next_node.next_node.origin - next_node.origin;
      } else {
        end_time = GetTime();
        total_time = end_time - self.start_time;
        reached_end = true;
      }
    } else {
      if(isDefined(current_node.previous_node) && isDefined(current_node.previous_node.previous_node)) {
        next_node_dir = current_node.previous_node.previous_node.origin - next_node.origin;
      } else {
        end_time = GetTime();
        total_time = end_time - self.start_time;
        reached_end = true;
      }
    }
    next_node_dir = VectorNormalize(next_node_dir);
    next_node_plane = curr_node_dir + next_node_dir;
    next_node_plane = VectorNormalize(next_node_plane);
    curr_node_plane = last_node_dir + curr_node_dir;
    curr_node_plane = VectorNormalize(curr_node_plane);
    origin = self.origin;
    curr_node_to_origin = origin - current_node.origin;
    origin_to_next_node = next_node.origin - origin;
    d1 = VectorDot(curr_node_to_origin, curr_node_plane);
    d2 = VectorDot(origin_to_next_node, next_node_plane);
    if(d2 < 0) {
      last_node = current_node;
      current_node = next_node;
      if(direction == "fwd") {
        next_node = current_node.next_node;
        self thread digger_follow_path_recalc_speed(current_node);
        continue;
      } else {
        next_node = current_node.previous_node;
        self thread digger_follow_path_recalc_speed(current_node);
        continue;
      }
    } else if(d1 < 0) {
      d1 = VectorDot(curr_node_dir, curr_node_to_origin);
      if(d1 < 0) {
        fraction = 0;
      } else {
        curr_node_length = Length(next_node.origin - current_node.origin);
        dist = Length(origin_to_next_node);
        fraction = 1 - (dist / curr_node_length);
        fraction = clamp(fraction, 0, 1);
        if(fraction > 0.95) {
          last_node = current_node;
          current_node = next_node;
          if(direction == "fwd") {
            next_node = current_node.next_node;
            self thread digger_follow_path_recalc_speed(current_node);
            continue;
          } else {
            next_node = current_node.previous_node;
            self thread digger_follow_path_recalc_speed(current_node);
            continue;
          }
        }
      }
    }
    fraction = d1 / (d1 + d2);
    speed = current_node.speed + (next_node.speed - current_node.speed) * fraction;
    speed = (speed * .5) * level.digger_speed_multiplier;
    look_ahead = current_node.lookahead + (next_node.lookahead - current_node.lookahead) * fraction;
    look_dist = current_node.lookahead * speed;
    node_length = Length(next_node.origin - current_node.origin);
    dist = (fraction * node_length) + look_dist;
    look_pos = (0, 0, 0);
    if(dist > node_length) {
      delta = dist - node_length;
      look_pos = next_node.origin + next_node_dir * delta;
    } else {
      look_pos = self.origin + curr_node_dir * dist;
    }
    look_dir = VectorNormalize(look_pos - self.origin);
    if(direction == "fwd") {
      velocity = look_dir * self.digger_speed * level.digger_speed_multiplier;
    } else {
      velocity = look_dir * speed;
    }
    self.origin = self.origin + velocity * 0.05;
    look_ahead = current_node.lookahead + (next_node.lookahead - current_node.lookahead) * fraction;
    self.angles = current_node.angles + (next_node.angles - current_node.angles) * fraction;
    wait(0.05);
  }
  if(body.digger_name == "hangar") {
    stop_exploder(102);
  } else if(body.digger_name == "teleporter") {
    stop_exploder(112);
  }
  self clearclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_MOVING_EARTHQUAKE_RUMBLE);
  arm clearclientflag(level._CLIENTFLAG_SCRIPTMOVER_DIGGER_ARM_FX);
  flag_clear("digger_moving");
  level notify("digger_reached_end", body.digger_name);
  self notify("path_end");
}

quantum_bomb_remove_digger_validation(position) {
  if(!flag("both_tunnels_breached")) {
    return false;
  }
  range_squared = 600 * 600;
  hangar_blocker = getEnt("digger_hangar_blocker", "targetname");
  if(distanceSquared(hangar_blocker.origin, position) < range_squared) {
    return true;
  }
  teleporter_blocker = getEnt("digger_teleporter_blocker", "targetname");
  if(distanceSquared(teleporter_blocker.origin, position) < range_squared) {
    return true;
  }
  return false;
}

quantum_bomb_remove_digger_result(position) {
  range_squared = 600 * 600;
  hangar_blocker = getEnt("digger_hangar_blocker", "targetname");
  if(distanceSquared(hangar_blocker.origin, position) < range_squared) {
    flag_set("hangar_digger_hacked");
    [[level.quantum_bomb_play_area_effect_func]](position);
  }
  teleporter_blocker = getEnt("digger_teleporter_blocker", "targetname");
  if(distanceSquared(teleporter_blocker.origin, position) < range_squared) {
    flag_set("teleporter_digger_hacked");
    [[level.quantum_bomb_play_area_effect_func]](position);
  }
}