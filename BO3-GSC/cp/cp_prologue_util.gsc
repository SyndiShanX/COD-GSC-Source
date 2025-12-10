/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_prologue_util.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_objectives;
#using scripts\cp\_spawn_manager;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_spawning;
#using scripts\cp\voice\voice_prologue;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\player_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicleriders_shared;
#using scripts\shared\weapons_shared;
#namespace cp_prologue_util;

function give_max_ammo() {
  a_w_weapons = self getweaponslist();
  foreach(w_weapon in a_w_weapons) {
    self givemaxammo(w_weapon);
    self setweaponammoclip(w_weapon, w_weapon.clipsize);
  }
}

function function_b50f5d52(var_76cb0c72 = 0) {
  a_ai_enemies = getaiteamarray("axis");
  foreach(ai_enemy in a_ai_enemies) {
    if(isalive(ai_enemy)) {
      if(var_76cb0c72) {
        ai_enemy ai::bloody_death(randomfloat(0.25));
        continue;
      }
      ai_enemy delete();
    }
  }
}

function function_2f943869() {
  self endon("death");
  wait(randomfloatrange(0.1, 0.6));
  self vehicle::get_out();
  if(isDefined(self.script_noteworthy)) {
    self setgoal(getnode(self.script_noteworthy, "targetname"), 1);
  }
}

function base_alarm_goes_off() {
  level.is_base_alerted = 1;
  level flag::set_val("is_base_alerted", 1);
  println("");
  level util::clientnotify("alarm_on");
  playsoundatposition("evt_base_alarm", (-1546, 287, 461));
  wait(2);
  playsoundatposition("evt_base_alarm", (-1546, 287, 461));
  wait(2);
  playsoundatposition("evt_base_alarm", (-1546, 287, 461));
}

function spawn_coop_player_replacement(skipto, var_de2f1b3 = 1) {
  flag::wait_till("all_players_spawned");
  primary_weapon = getweapon("ar_standard_hero");
  var_5178c24b = getdvarint("scene_debug_player", 0);
  if(!isDefined(level.var_681ad194)) {
    level.var_681ad194 = [];
  }
  if(var_de2f1b3) {
    if(level.players.size <= 3 && !isDefined(level.var_681ad194[1]) && var_5178c24b != 2) {
      level.var_681ad194[1] = util::get_hero("ally_03");
      s_struct = struct::get(skipto + "_ally_03", "targetname");
      level.var_681ad194[1] forceteleport(s_struct.origin, s_struct.angles);
      level.var_681ad194[1] ai::gun_switchto(primary_weapon, "right");
      level.var_681ad194[1].var_a89679b6 = 3;
    }
    if(level.players.size <= 2 && !isDefined(level.var_681ad194[2]) && var_5178c24b != 3) {
      level.var_681ad194[2] = util::get_hero("ally_02");
      s_struct = struct::get(skipto + "_ally_02", "targetname");
      level.var_681ad194[2] forceteleport(s_struct.origin, s_struct.angles);
      level.var_681ad194[2] ai::gun_switchto(primary_weapon, "right");
      level.var_681ad194[2].var_a89679b6 = 2;
    }
    if(level.players.size == 1 && !isDefined(level.var_681ad194[3]) && var_5178c24b != 4) {
      level.var_681ad194[3] = util::get_hero("ally_01");
      s_struct = struct::get(skipto + "_ally_01", "targetname");
      level.var_681ad194[3] forceteleport(s_struct.origin, s_struct.angles);
      level.var_681ad194[3] ai::gun_switchto(primary_weapon, "right");
      level.var_681ad194[3].var_a89679b6 = 1;
    }
  }
  if(level.players.size >= 2 && isDefined(level.var_681ad194[3])) {
    level.var_681ad194[3] delete();
    level.var_681ad194[3] = undefined;
  }
  if(level.players.size >= 3 && isDefined(level.var_681ad194[2])) {
    level.var_681ad194[2] delete();
    level.var_681ad194[2] = undefined;
  }
  if(level.players.size >= 4 && isDefined(level.var_681ad194[1])) {
    level.var_681ad194[1] delete();
    level.var_681ad194[1] = undefined;
  }
}

function give_player_weapons() {
  self flag::clear("custom_loadout");
  self takeallweapons();
  self.primaryloadoutweapon = getweapon("smg_standard", "grip", "fastreload", "reflex");
  self.secondaryloadoutweapon = getweapon("pistol_standard", "fastreload");
  self giveweapon(self.primaryloadoutweapon);
  self giveweapon(self.secondaryloadoutweapon);
  self.grenadetypeprimary = getweapon("frag_grenade");
  self.grenadetypesecondary = getweapon("concussion_grenade");
  self giveweapon(self.grenadetypeprimary);
  self giveweapon(self.grenadetypesecondary);
  a_w_weapons = self getweaponslist();
  foreach(w_weapon in a_w_weapons) {
    self givemaxammo(w_weapon);
    self setweaponammoclip(w_weapon, w_weapon.clipsize);
  }
  self switchtoweapon(self.primaryloadoutweapon);
  self flag::set("custom_loadout");
}

function arrive_and_spawn(vehicle, str_spawn_manager) {
  vehicle waittill("reached_end_node");
  vehicle disconnectpaths();
  spawn_manager::enable(str_spawn_manager);
}

function ai_idle_then_alert(str_wait_till, var_4afdd260) {
  self endon("death");
  self.goalradius = 8;
  self ai::set_ignoreall(1);
  self ai::set_ignoreme(1);
  self setgoal(self.origin);
  level flag::wait_till(str_wait_till);
  self.goalradius = 32;
  self ai::set_ignoreall(0);
  self ai::set_ignoreme(0);
  if(isDefined(self.target)) {
    node = getnodearray(self.target, "targetname");
    index = randomintrange(0, node.size);
    self setgoal(node[index], 1);
  }
  if(isDefined(var_4afdd260)) {
    self waittill("goal");
    self.goalradius = var_4afdd260;
  }
}

function get_ai_allies() {
  if(!isDefined(level.var_681ad194)) {
    return [];
  }
  for(i = 1; i < 4; i++) {
    if(!isDefined(level.var_681ad194[i]) || !isalive(level.var_681ad194[i])) {
      level.var_681ad194[i] = undefined;
    }
  }
  return arraycopy(level.var_681ad194);
}

function get_ai_allies_and_players() {
  a_team = arraycombine(getplayers(), level.var_681ad194, 0, 0);
  return a_team;
}

function follow_linked_scripted_nodes() {
  self endon("death");
  self.goalradius = 64;
  self.ignoreall = 1;
  nd_node = getnode(self.script_string, "targetname");
  while(true) {
    self setgoal(nd_node.origin);
    self waittill("goal");
    if(!isDefined(nd_node.script_string)) {
      break;
    }
    nd_node = getnode(nd_node.script_string, "targetname");
  }
}

function ai_setgoal(goal) {
  nd_node = getnode(goal, "targetname");
  self setgoal(nd_node, 1);
  self waittill("goal");
}

function ai_low_goal_radius() {
  self.goalradius = 512;
}

function ai_very_low_goal_radius() {
  self.goalradius = 16;
}

function set_goal_volume(e_goal_volume) {
  self setgoalvolume(e_goal_volume);
}

function set_robot_unarmed() {
  orig_team = self getteam();
  self ai::set_behavior_attribute("rogue_control", "forced_level_2");
  self ai::set_behavior_attribute("rogue_control_speed", "run");
  self setteam(orig_team);
  if(level.players.size > 1) {
    self.health = int(self.health * 1.4);
  }
}

function function_bd761fba(str_flag) {
  self endon("death");
  self turret::enable(1, 0);
  level flag::wait_till(str_flag);
  self thread function_3a642801();
}

function function_9af14b02(str_flag, n_time) {
  self endon("death");
  self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
  self waittill("open_fire");
  self turret::shoot_at_target(level.apc, n_time, undefined, 1, 0);
  self turret::enable(1, 1);
  level flag::wait_till(str_flag);
  self thread function_3a642801();
}

function function_1db6047f(str_cleanup) {
  self endon("death");
  trigger::wait_till(str_cleanup);
  self delete();
}

function function_3a642801() {
  foreach(ai_rider in self.riders) {
    if(isDefined(ai_rider)) {
      ai_rider delete();
    }
  }
  level flag::wait_till_clear("deleting_havok_object");
  level flag::set("deleting_havok_object");
  self.delete_on_death = 1;
  self notify("death");
  if(!isalive(self)) {
    self delete();
  }
  wait(0.05);
  level flag::clear("deleting_havok_object");
}

function function_73acb160(str_spawners, start_func) {
  a_spawners = getEntArray(str_spawners, "targetname");
  for(i = 0; i < a_spawners.size; i++) {
    level thread function_1f89893f(a_spawners[i], start_func);
  }
}

function function_1f89893f(e_spawner, start_func) {
  if(isDefined(e_spawner.script_delay)) {
    wait(e_spawner.script_delay);
  }
  e_ent = e_spawner spawner::spawn();
  if(isDefined(start_func)) {
    e_ent thread[[start_func]]();
  }
}

function remove_grenades() {
  self.grenadeammo = 0;
}

function function_40e4b0cf(str_spawn_manager, str_spawners, var_c5690501) {
  a_spawners = getEntArray(str_spawners, "targetname");
  e_volume = getent(var_c5690501, "targetname");
  foreach(sp_spawner in a_spawners) {
    sp_spawner spawner::add_spawn_function(&set_goal_volume, e_volume);
  }
  spawn_manager::enable(str_spawn_manager);
}

function function_a7eac508(str_spawner, var_4ac59d48, end_goal_radius, disable_fallback) {
  a_ents = getEntArray(str_spawner, "targetname");
  for(i = 0; i < a_ents.size; i++) {
    e_ent = a_ents[i] spawner::spawn();
    if(isDefined(var_4ac59d48)) {
      e_ent.goalradius = 64;
    }
    e_ent thread ai_wakamole(end_goal_radius, disable_fallback);
  }
}

function ai_wakamole(end_goal_radius, disable_fallback) {
  self endon("death");
  if(isDefined(disable_fallback) && disable_fallback) {
    self.disable_fallback = 1;
  }
  self waittill("goal");
  if(isDefined(end_goal_radius)) {
    self.goalradius = end_goal_radius;
  }
}

function function_8f7b1e06(str_trigger, var_390543cc, var_9d774f5d) {
  if(isDefined(str_trigger)) {
    e_trigger = getent(str_trigger, "targetname");
    e_trigger waittill("trigger");
  }
  var_441bd962 = getent(var_390543cc, "targetname");
  var_ee2fd889 = getent(var_9d774f5d, "targetname");
  a_ai = getaiteamarray("axis");
  for(i = 0; i < a_ai.size; i++) {
    e_ent = a_ai[i];
    if(e_ent istouching(var_441bd962)) {
      e_ent setgoal(var_ee2fd889);
      e_ent thread ai_wakamole(undefined, 0);
    }
  }
}

function wait_for_all_players_to_pass_struct(str_struct, var_e209da48) {
  s_struct = struct::get(str_struct, "targetname");
  v_struct_dir = anglesToForward(s_struct.angles);
  while(true) {
    num_players_past = 0;
    a_players = getplayers();
    for(i = 0; i < a_players.size; i++) {
      e_player = a_players[i];
      v_dir = vectornormalize(e_player.origin - s_struct.origin);
      dp = vectordot(v_dir, v_struct_dir);
      if(dp > 0.3) {
        num_players_past++;
      }
    }
    if(isDefined(var_e209da48) && num_players_past >= a_players.size) {
      break;
    }
    if(num_players_past == a_players.size) {
      break;
    }
    wait(0.05);
  }
}

function function_12ce22ee() {
  level.a_ai_allies = [];
  if(isDefined(level.var_681ad194[1])) {
    arrayinsert(level.a_ai_allies, level.var_681ad194[1], 0);
  }
  if(isDefined(level.var_681ad194[2])) {
    arrayinsert(level.a_ai_allies, level.var_681ad194[2], 0);
  }
  if(isDefined(level.var_681ad194[3])) {
    arrayinsert(level.a_ai_allies, level.var_681ad194[3], 0);
  }
}

function function_520255e3(str_trigger, time) {
  str_notify = "mufc_" + str_trigger;
  level thread function_901793d(str_trigger, str_notify);
  level thread function_2ffbaa00(time, str_notify);
  level waittill(str_notify);
}

function function_901793d(str_trigger, str_notify) {
  level endon(str_notify);
  e_trigger = getent(str_trigger, "targetname");
  if(isDefined(e_trigger)) {
    e_trigger waittill("trigger");
  }
  level notify(str_notify);
}

function function_2ffbaa00(time, str_notify) {
  level endon(str_notify);
  wait(time);
  level notify(str_notify);
}

function groundpos_ignore_water(origin) {
  return groundtrace(origin, origin + (vectorscale((0, 0, -1), 100000)), 0, undefined, 1)["position"];
}

function function_609c412a(str_volume, check_players) {
  e_volume = getent(str_volume, "targetname");
  num_touching = 0;
  a_ai = getaiteamarray("axis");
  for(i = 0; i < a_ai.size; i++) {
    if(a_ai[i] istouching(e_volume)) {
      num_touching++;
    }
  }
  if(check_players) {
    a_players = getplayers();
    for(i = 0; i < a_players.size; i++) {
      if(a_players[i] istouching(e_volume)) {
        num_touching++;
        break;
      }
    }
  }
  return num_touching;
}

function function_15823dab(v_pos, shake_size, shake_time, var_e64e30a6, rumble_num, e_player) {
  if(shake_size) {
    earthquake(shake_size, shake_time, v_pos, var_e64e30a6);
  }
  for(i = 0; i < rumble_num; i++) {
    e_player playrumbleonentity("damage_heavy");
    wait(0.1);
  }
}

function rumble_all_players(str_type, n_time_between, n_iterations, e_ent) {
  for(i = 0; i < n_iterations; i++) {
    e_ent playrumbleonentity(str_type);
    wait(n_time_between);
  }
}

function function_2a0bc326(v_pos, var_48f82942, var_51fbdea, var_644bf6a7, var_8f4ca4be, str_rumble_type = "damage_heavy", var_183c13ad) {
  if(var_48f82942) {
    earthquake(var_48f82942, var_51fbdea, v_pos, var_644bf6a7);
  }
  var_5ca58060 = var_644bf6a7 * var_644bf6a7;
  foreach(player in level.activeplayers) {
    if(isDefined(var_183c13ad)) {
      player shellshock(var_183c13ad, var_51fbdea);
    }
    player thread function_e42cebb6(v_pos, var_5ca58060, var_8f4ca4be, str_rumble_type);
  }
}

function function_e42cebb6(v_pos, var_5ca58060, var_8f4ca4be, str_rumble_type) {
  self endon("death");
  for(i = 0; i < var_8f4ca4be; i++) {
    if(distancesquared(v_pos, self.origin) <= var_5ca58060) {
      self playrumbleonentity(str_rumble_type);
    }
    wait(0.1);
  }
}

function vehicle_rumble(str_rumble_type = "damage_light", var_74584a64, var_48f82942 = 0.1, n_period = 0.1, n_radius = 2000, n_timeout) {
  if(isDefined(var_74584a64)) {
    self endon(var_74584a64);
  }
  self endon("death");
  n_timepassed = 0;
  b_done = 0;
  while(!b_done) {
    self playrumbleonentity(str_rumble_type);
    earthquake(var_48f82942, n_period, self.origin, n_radius);
    wait(n_period);
    if(isDefined(n_timeout) && n_timeout > 0) {
      n_timepassed = n_timepassed + n_period;
      b_done = n_timepassed >= n_timeout;
    }
  }
}

function function_47a62798(var_de243c2) {
  level.ai_hendricks ai::set_behavior_attribute("cqb", var_de243c2);
  a_allies = get_ai_allies();
  foreach(e_ally in a_allies) {
    e_ally ai::set_behavior_attribute("cqb", var_de243c2);
  }
}

function function_a5398264(str_mode) {
  level.ai_hendricks ai::set_behavior_attribute("move_mode", str_mode);
  level.ai_khalil ai::set_behavior_attribute("move_mode", str_mode);
  level.ai_minister ai::set_behavior_attribute("move_mode", str_mode);
  a_allies = get_ai_allies();
  foreach(e_ally in a_allies) {
    e_ally ai::set_behavior_attribute("move_mode", str_mode);
  }
}

function function_db027040(var_eb6e3c93) {
  level.ai_hendricks.perfectaim = var_eb6e3c93;
  level.ai_khalil.perfectaim = var_eb6e3c93;
  level.ai_minister.perfectaim = var_eb6e3c93;
  a_allies = get_ai_allies();
  foreach(e_ally in a_allies) {
    e_ally.perfectaim = var_eb6e3c93;
  }
}

function num_players_touching_volume(e_volume) {
  a_players = getplayers();
  num_touching = 0;
  for(i = 0; i < a_players.size; i++) {
    if(a_players[i] istouching(e_volume)) {
      num_touching++;
    }
  }
  return num_touching;
}

function function_68b8f4af(e_volume) {
  a_ai = getaiteamarray("axis");
  a_touching = [];
  for(i = 0; i < a_ai.size; i++) {
    if(a_ai[i] istouching(e_volume)) {
      a_touching[a_touching.size] = a_ai[i];
    }
  }
  return a_touching;
}

function function_d1f1caad(str_trigger) {
  e_trigger = getent(str_trigger, "targetname");
  if(isDefined(e_trigger)) {
    e_trigger waittill("trigger");
  }
}

function function_e0fb6da9(str_struct, close_dist, wait_time, var_d1b83750, max_ai, var_a70db4af, var_1813646e, var_98e9bc46) {
  a_players = getplayers();
  if(a_players.size > 1) {
    return;
  }
  s_struct = struct::get(str_struct, "targetname");
  var_37124366 = getent(var_1813646e, "targetname");
  var_7d22b48e = getent(var_98e9bc46, "targetname");
  v_forward = anglesToForward(s_struct.angles);
  s_struct.start_time = undefined;
  var_cc06a93d = 0;
  while(true) {
    e_player = getplayers()[0];
    v_dir = s_struct.origin - e_player.origin;
    var_989d1f7c = vectordot(v_dir, v_forward);
    if(var_989d1f7c < -100) {
      return;
    }
    dist = distance(s_struct.origin, e_player.origin);
    if(dist < close_dist) {
      if(!isDefined(s_struct.start_time)) {
        s_struct.start_time = gettime();
      }
    } else {
      s_struct.start_time = undefined;
    }
    if(isDefined(s_struct.start_time)) {
      time = gettime();
      dt = (time - s_struct.start_time) / 1000;
      if(dt > wait_time) {
        a_ai = getaiteamarray("axis");
        a_touching = [];
        for(i = 0; i < a_ai.size; i++) {
          e_ent = a_ai[i];
          if(!isDefined(e_ent.var_db552f4)) {
            if(e_ent istouching(var_37124366)) {
              a_touching[a_touching.size] = e_ent;
            }
          }
        }
        var_d6f9eed8 = randomintrange(var_d1b83750, max_ai + 1);
        if(var_d6f9eed8 > a_touching.size) {
          var_d6f9eed8 = a_touching.size;
        }
        for(i = 0; i < var_d6f9eed8; i++) {
          a_touching[i] setgoal(var_7d22b48e);
          a_touching[i].var_db552f4 = 1;
        }
        s_struct.start_time = undefined;
        var_cc06a93d++;
        if(var_cc06a93d >= var_a70db4af) {
          return;
        }
      }
    }
    wait(0.05);
  }
}

function function_f5363f47(str_trigger) {
  a_triggers = getEntArray(str_trigger, "targetname");
  str_notify = str_trigger + "_waiting";
  for(i = 0; i < a_triggers.size; i++) {
    level thread function_7eb8a7ab(a_triggers[i], str_notify);
  }
  level waittill(str_notify);
}

function function_7eb8a7ab(e_trigger, str_notify) {
  level endon(str_notify);
  e_trigger waittill("trigger");
  level notify(str_notify);
}

function function_25e841ea() {
  if(!isDefined(level.var_c6c69fca)) {
    level.var_c6c69fca = 1;
  }
}

function function_92d5b013(speed_frac) {
  a_players = getplayers();
  for(i = 0; i < a_players.size; i++) {
    a_players[i] setmovespeedscale(speed_frac);
  }
}

function debug_line(e_ent) {
  e_ent endon("death");
  while(true) {
    v_start = e_ent.origin;
    v_end = v_start + vectorscale((0, 0, 1), 1000);
    v_col = (1, 1, 1);
    line(v_start, v_end, v_col);
    wait(0.1);
  }
}

function function_42da021e(str_spawner_name, var_4c026543, var_61e0b19a, var_e3f49331 = 0) {
  var_28290004 = str_spawner_name + "_end";
  e_vtol = vehicle::simple_spawn_single(str_spawner_name);
  e_vtol endon("death");
  e_vtol thread vehicle_rumble("buzz_high", var_28290004, 0.05, 0.1, 5000);
  nd_start = getvehiclenode(e_vtol.target, "targetname");
  e_vtol attachpath(nd_start);
  if(isDefined(var_4c026543)) {
    if(!isDefined(var_61e0b19a)) {
      e_vtol setspeed(var_4c026543);
    } else {
      e_vtol setspeed(var_4c026543, var_61e0b19a);
    }
  }
  if(var_e3f49331) {
    e_vtol thread function_c56034b7();
  }
  e_vtol startpath();
  e_vtol waittill("reached_end_node");
  e_vtol notify(var_28290004);
  e_vtol.delete_on_death = 1;
  e_vtol notify("death");
  if(!isalive(e_vtol)) {
    e_vtol delete();
  }
}

function function_c56034b7() {
  playFXOnTag(level._effect["vtol_rotorwash"], self, "tag_engine_left");
  playFXOnTag(level._effect["vtol_rotorwash"], self, "tag_engine_right");
}

function function_950d1c3b(b_enable = 1) {
  var_9dff5377 = (b_enable ? 1 : 0);
  foreach(player in level.players) {
    player clientfield::set_to_player("player_tunnel_dust_fx", var_9dff5377);
  }
}

function function_34acbf2() {
  objectives::complete("cp_level_prologue_locate_the_security_room");
  objectives::complete("cp_level_prologue_security_camera");
}

function function_df278013() {
  objectives::complete("cp_level_prologue_free_the_minister");
}

function function_9d35b20d() {
  objectives::complete("cp_level_prologue_free_khalil");
}

function function_cfabe921() {
  function_34acbf2();
  function_df278013();
  function_9d35b20d();
  objectives::complete("cp_level_prologue_find_vehicle");
  objectives::complete("cp_level_prologue_defend_theia");
  objectives::set("cp_level_prologue_goto_exfil");
}

function function_21f52196(str_door_name, t_enter, var_13aabd08) {
  assert(isDefined(t_enter), "");
  assert(isDefined(t_enter.target), "");
  level endon("stop_door_" + str_door_name);
  t_exit = getent(t_enter.target, "targetname");
  t_enter thread function_e0f9fe98(str_door_name, 0);
  t_exit thread function_e0f9fe98(str_door_name, 1);
  if(isDefined(var_13aabd08)) {
    var_dee3d10a = getent(var_13aabd08, "targetname");
    assert(isDefined(var_dee3d10a), "");
    var_dee3d10a endon("death");
    var_dee3d10a waittill("hash_c0b9931e");
    foreach(player in level.players) {
      if(!isDefined(player.a_doors)) {
        player.a_doors = [];
      }
      player.a_doors[str_door_name] = 1;
    }
  }
}

function function_2e61b3e8(str_door_name, t_enter, a_ai) {
  assert(isDefined(t_enter), "");
  assert(isDefined(t_enter.target), "");
  level endon("stop_door_" + str_door_name);
  t_exit = getent(t_enter.target, "targetname");
  if(!isDefined(level.var_40c4c9da)) {
    level.var_40c4c9da = [];
  }
  level.var_40c4c9da[str_door_name] = a_ai;
  foreach(e_guy in a_ai) {
    t_exit thread function_e010251d(str_door_name, 1, e_guy);
  }
}

function function_e0f9fe98(str_door_name, b_state) {
  level endon("stop_door_" + str_door_name);
  self endon("death");
  while(true) {
    self waittill("trigger", e_who);
    if(isplayer(e_who)) {
      if(!isDefined(e_who.a_doors)) {
        e_who.a_doors = [];
      }
      e_who.a_doors[str_door_name] = b_state;
    }
  }
}

function function_e010251d(str_door_name, b_state, e_guy) {
  level endon("stop_door_" + str_door_name);
  self endon("death");
  if(!isDefined(e_guy.a_doors)) {
    e_guy.a_doors = [];
  }
  e_guy.a_doors[str_door_name] = 0;
  while(true) {
    self waittill("trigger", e_who);
    if(isai(e_who) && e_who == e_guy) {
      if(!isDefined(e_who.a_doors)) {
        e_who.a_doors = [];
      }
      e_who.a_doors[str_door_name] = b_state;
    }
  }
}

function function_cdd726fb(str_door_name) {
  var_83b77796 = 1;
  foreach(player in level.activeplayers) {
    if(!isDefined(player.a_doors) || !isDefined(player.a_doors[str_door_name]) || !player.a_doors[str_door_name]) {
      var_83b77796 = 0;
    }
  }
  if(isDefined(level.var_40c4c9da) && isDefined(level.var_40c4c9da[str_door_name])) {
    foreach(e_guy in level.var_40c4c9da[str_door_name]) {
      if(isalive(e_guy) && (!isDefined(e_guy.a_doors) || !isDefined(e_guy.a_doors[str_door_name]) || !e_guy.a_doors[str_door_name])) {
        var_83b77796 = 0;
      }
    }
  }
  return var_83b77796;
}

function function_d990de5a(t_enter) {
  t_exit = getent(t_enter.target, "targetname");
  t_enter delete();
  t_exit delete();
}

function function_d723979e(str_notify, str_model, str_endon) {
  self endon("death");
  if(isDefined(str_endon)) {
    level endon(str_endon);
  }
  self waittill(str_notify);
  self setModel(str_model);
}

function function_72e9bdb8() {
  if(self ishost()) {
    return self getdstat("highestMapReached") > 0;
  }
  return self getdstat("PlayerStatsByMap", "cp_mi_eth_prologue", "hasBeenCompleted");
}