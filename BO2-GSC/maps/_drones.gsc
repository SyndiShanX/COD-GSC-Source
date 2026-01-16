/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_drones.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include animscripts\setposemovement;
#include animscripts\combat_utility;
#include animscripts\shared;
#include common_scripts\utility;
#include maps\_spawner;
#include maps\_names;
#include maps\_friendlyfire;
#include maps\_damagefeedback;
#include maps\_drones;
#using_animtree("fakeshooters");

init() {
  if(getdvar(#"r_reflectionProbeGenerate") == "1") {
    return;
  }
  if(!isDefined(level.drones))
    level.drones = spawnstruct();

  if(!isDefined(level.drones.impact_fx)) {
    effect = loadfx("impacts/fx_flesh_hit");
    drones_set_impact_effect(effect);
  }

  if(!isDefined(level.drones.muzzleflash)) {
    effect = loadfx("weapon/muzzleflashes/fx_standard_flash");
    drones_set_muzzleflash(effect);
  }

  level.drones.step_height = 100;
  level.drones.trace_height = 400;
  drones_init_max();
  drones_set_friendly_fire(0);
  drones_disable_sound(0);
  drones_set_max_ragdolls(8);
  set_anim_array();

  if(!isDefined(level.drones.team))
    level.drones.team = [];

  if(!isDefined(level.drones.team["axis"]))
    level.drones.team["axis"] = struct_arrayspawn();

  if(!isDefined(level.drones.team["allies"]))
    level.drones.team["allies"] = struct_arrayspawn();

  level.drones.drone_spawners = [];
  level.drones.axis_triggers = getentarray("drone_axis", "targetname");
  level.drones.allies_triggers = getentarray("drone_allies", "targetname");
  array_thread(level.drones.axis_triggers, ::drones_setup_spawner, 1);
  array_thread(level.drones.allies_triggers, ::drones_setup_spawner, 1);
  level.drones.axis_structs = getstructarray("drone_axis", "targetname");
  level.drones.allies_structs = getstructarray("drone_allies", "targetname");
  array_thread(level.drones.axis_structs, ::drones_setup_spawner, 0);
  array_thread(level.drones.allies_structs, ::drones_setup_spawner, 0);
  flag_init("drones_stop_looped_anims");
  flag_init("reached_drone_spawn_cap");
  level.drones.max_per_frame = 10;
  level.drones.spawned_this_frame = 0;
  level thread reset_drone_throttle();
  level.drones.respawn_death_delay_min = 1.0;
  level.drones.respawn_death_delay_max = 3.0;
  level.drones.respawners = [];

  if(!isDefined(level.drone_spawnfunction)) {
    level.drone_spawnfunction["axis"] = ::spawn_random_axis_drone;
    level.drone_spawnfunction["allies"] = ::spawn_random_allies_drone;
  }

  level.drones.anim_idle[0] = % stand_alert_1;
  level.drones.anim_idle[1] = % stand_alert_2;
  level.drones.anim_idle[2] = % stand_alert_3;
  level.drones.funcs = [];
}

drones_add_custom_func(str_func_name, func_custom) {
  assert(isDefined(str_func_name), "str_func_name is a required parameter for drones_add_custom_func!");
  assert(isDefined(func_custom), "func_custom is a required parameter for drones_add_custom_func!");
  level.drones.funcs[str_func_name] = func_custom;
}

get_min_value(value, is_integer) {
  values = strtok(value, " ");
  assert(values.size > 0, "_drones a non-number value was encountered: \"" + value + "\"");

  if(!isDefined(is_integer))
    is_integer = 1;

  if(isDefined(values[0])) {
    if(is_integer)
      return int(values[0]);
    else
      return float(values[0]);
  }

  return undefined;
}

get_max_value(value, is_integer) {
  values = strtok(value, " ");
  assert(values.size > 0, "_drones a non-number value was encountered: \"" + value + "\"");

  if(!isDefined(is_integer))
    is_integer = 1;

  if(values.size > 1) {
    if(is_integer)
      return int(values[1]);
    else
      return float(values[1]);
  } else if(values.size == 1) {
    if(is_integer)
      return int(values[0]);
    else
      return float(values[0]);
  }

  return undefined;
}

drones_system_initialized() {
  if(isDefined(level.drones)) {
    if(isDefined(level.drones.team))
      return true;
  }

  return false;
}

drones_get_trigger_from_script_string(script_string_name) {
  drone_trigger = undefined;

  for(i = 0; i < 2; i++) {
    if(!i)
      drone_trigger_array = getentarray("drone_axis", "targetname");
    else
      drone_trigger_array = getentarray("drone_allies", "targetname");

    if(isDefined(drone_trigger_array)) {
      for(j = 0; j < drone_trigger_array.size; j++) {
        e_ent = drone_trigger_array[j];

        if(isDefined(e_ent.script_string) && e_ent.script_string == script_string_name) {
          drone_trigger = drone_trigger_array[j];
          break;
        }
      }
    }
  }

  return drone_trigger;
}

drones_get_data_from_script_string(script_string_name) {
  foreach(s_data in level.drones.drone_spawners) {
    if(isDefined(s_data.script_string) && s_data.script_string == script_string_name)
      return s_data;
  }

  return undefined;
}

drones_init_max() {
  max_drones = 64;

  if(issplitscreen())
    max_drones = 16;

  if(isDefined(level.drones.max_drones))
    max_drones = level.drones.max_drones;

  drones_set_max(max_drones);
}

drones_set_max(max_drones) {
  if(!isDefined(level.drones))
    level.drones = spawnstruct();

  level.drones.max_drones = max_drones;
}

drones_set_impact_effect(effect_handle) {
  if(!isDefined(level.drones))
    level.drones = spawnstruct();

  level.drones.impact_fx = effect_handle;
}

drones_set_muzzleflash(effect_handle) {
  if(!isDefined(level.drones))
    level.drones = spawnstruct();

  level.drones.muzzleflash = effect_handle;
}

drones_set_friendly_fire(friendly_fire) {
  level.drones.friendly_fire = friendly_fire;
}

drones_disable_sound(disable_sound) {
  level.drones.sounds_disabled = disable_sound;
}

save_target_links() {
  foreach(s_child in self.a_targeted) {
    if(isDefined(s_child.target) && !isDefined(s_child.a_targeted)) {
      s_child.a_targeted = level.struct_class_names["targetname"][s_child.target];
      s_child save_target_links();
    }
  }
}

drones_setup_spawner(is_trigger) {
  data = drones_get_spawner(self.targetname, self.target);

  if(is_trigger)
    data.parent_trigger = self;
  else
    data.parent_script_struct = self;

  data.dr_group = self.dr_group;
  data.dr_need_player = self.dr_need_player;
  data.dr_player_trace = self.dr_player_trace;
  data.dr_populate = self.dr_populate;
  data.dr_respawn = self.dr_respawn;

  if(isDefined(self.dr_delay)) {
    data.n_delay_min = get_min_value(self.dr_delay, 0);
    data.n_delay_max = get_max_value(self.dr_delay, 0);
  }

  if(isDefined(self.dr_wait)) {
    data.n_wait_min = get_min_value(self.dr_wait, 0);
    data.n_wait_max = get_max_value(self.dr_wait, 0);
  }

  if(isDefined(self.dr_wave_count)) {
    data.n_wave_count_min = get_min_value(self.dr_wave_count);
    data.n_wave_count_max = get_max_value(self.dr_wave_count);
  }

  if(isDefined(self.dr_wave_size)) {
    data.n_wave_size_min = get_min_value(self.dr_wave_size);
    data.n_wave_size_max = get_max_value(self.dr_wave_size);
  }

  data.script_allowdeath = self.script_allowdeath;
  data.script_int = self.script_int;
  data.script_ender = self.script_ender;
  data.script_noteworthy = self.script_noteworthy;
  data.script_string = self.script_string;
  data.weaponinfo = self.weaponinfo;
  level thread drone_spawner_wait_for_activation(data);
  return data;
}

drones_get_spawner(targetname, target) {
  data = spawnstruct();
  data.parent_trigger = undefined;
  data.parent_script_struct = undefined;

  if(isDefined(target))
    data.a_targeted = getstructarray(target, "targetname");

  assert(isDefined(data.a_targeted));
  assert(isDefined(data.a_targeted[0]));
  data save_target_links();

  if(targetname == "drone_allies")
    data.team = "allies";
  else
    data.team = "axis";

  data.paused = 1;
  data.drone_run_cycle_override = undefined;
  data.speed_modifier_min = undefined;
  data.speed_modifier_max = undefined;
  data.delete_spawner = 0;
  level.drones.drone_spawners[level.drones.drone_spawners.size] = data;
  return data;
}

drone_spawner_wait_for_activation(drones) {
  if(isDefined(drones.script_ender))
    level endon(drones.script_ender);

  if(isDefined(drones.parent_trigger)) {
    drones.parent_trigger endon("death");
    drones.parent_trigger waittill("trigger");
    drones.paused = 0;
  } else {
    drones.parent_script_struct waittill("trigger");
    drones.paused = 0;
  }

  level thread drone_spawner_active(drones);
}

drone_spawner_active(drones) {
  repeat_times = 9999999;

  if(isDefined(drones.n_wave_count_min))
    repeat_times = randomintrange(drones.n_wave_count_min, drones.n_wave_count_max + 1);

  spawn_min = 1;
  spawn_max = spawn_min;

  if(isDefined(drones.n_wave_size_min))
    spawn_min = drones.n_wave_size_min;

  if(isDefined(drones.n_wave_size_max))
    spawn_max = drones.n_wave_size_max;

  if(isDefined(drones.parent_trigger))
    drones.parent_trigger endon("stop_drone_loop");

  if(isDefined(drones.n_delay_min))
    wait(randomfloatrange(drones.n_delay_min, drones.n_delay_max));

  if(isDefined(drones.dr_populate) && drones.dr_populate) {
    level thread pre_populate_drones(drones, spawn_min, spawn_max, drones.team);
    wait_time = get_drone_spawn_wait(drones);
    wait(wait_time);
  }

  for(i = 0; i < repeat_times; i++) {
    if(drones.delete_spawner) {
      return;
    }
    level notify("new drone Spawn wave");
    spawn_size = spawn_min;

    if(spawn_max > spawn_min)
      spawn_size = randomintrange(spawn_min, spawn_max + 1);

    level thread drone_spawngroup(drones, drones.a_targeted, spawn_size, drones.team, 0);
    respawn_wait_loop = 1;

    while(respawn_wait_loop) {
      delay = get_drone_spawn_wait(drones);
      wait(delay);

      if(!drones_respawner_used(drones))
        respawn_wait_loop = 0;
    }

    if(isDefined(drones.parent_trigger)) {
      if(isDefined(drones.parent_trigger.dr_need_player) && drones.parent_trigger.dr_need_player)
        drones.parent_trigger waittill("trigger");
    }

    while(drones.paused)
      wait 1.0;
  }
}

get_drone_spawn_wait(drone_data) {
  min_spawn_wait = 1;
  max_spawn_wait = 1;

  if(isDefined(drone_data.n_wait_min)) {
    min_spawn_wait = drone_data.n_wait_min;
    max_spawn_wait = drone_data.n_wait_max;
  }

  if(max_spawn_wait > min_spawn_wait)
    return randomfloatrange(min_spawn_wait, max_spawn_wait);

  return min_spawn_wait;
}

drone_spawngroup(drones, spawnpoint, spawnsize, team, start_ahead) {
  spawncount = spawnpoint.size;

  if(isDefined(spawnsize)) {
    spawncount = spawnsize;
    spawnpoint = array_randomize(spawnpoint);
  }

  if(spawncount > spawnpoint.size && spawnpoint.size > 1)
    spawncount = spawnpoint.size;

  offsets = [];

  if(isDefined(drones.dr_group) && drones.dr_group)
    offsets = generate_offsets(spawncount);

  for(i = 0; i < spawncount; i++) {
    if(isDefined(drones.script_int))
      wait(randomfloatrange(0.1, 1.0));

    if(isDefined(drones.parent_trigger)) {
      while(!drones.parent_trigger ok_to_trigger_spawn())
        wait_network_frame();
    }

    if(i < spawnpoint.size)
      spawnpoint[i] thread drone_spawn(team, offsets[i], start_ahead, drones);
    else {
      if(i > 0 && offsets[i - 1] == offsets[i])
        wait(randomfloatrange(0.8, 1.1));
      else
        wait(randomfloatrange(0.5, 0.9));

      spawnpoint[spawnpoint.size - 1] thread drone_spawn(team, offsets[i], start_ahead, drones);
    }

    level._numtriggerspawned++;
  }
}

drones_respawner_created(drone_struct) {
  for(i = 0; i < level.drones.respawners.size; i++) {
    if(level.drones.respawners[i] == drone_struct)
      return;
  }

  trigger_alive = 0;

  for(i = 0; i < level.drones.drone_spawners.size; i++) {
    spawner = level.drones.drone_spawners[i];

    for(j = 0; j < spawner.a_targeted.size; j++) {
      if(spawner.a_targeted[j] == drone_struct) {
        trigger_alive = 1;
        break;
      }
    }
  }

  if(trigger_alive)
    level.drones.respawners[level.drones.respawners.size] = drone_struct;
}

drones_respawner_used(drone_spawner) {
  drone_structs = drone_spawner.a_targeted;

  for(i = 0; i < drone_structs.size; i++) {
    struct = drone_structs[i];

    for(j = 0; j < level.drones.respawners.size; j++) {
      if(level.drones.respawners[j] == struct) {
        arrayremovevalue(level.drones.respawners, struct);
        return true;
      }
    }
  }

  return false;
}

generate_offsets(spawncount) {
  offsets = [];
  delta = 0.5 / spawncount;

  for(i = 0; i < spawncount; i++) {
    id = randomint(spawncount * 2);
    offsets[i] = id * delta;
  }

  return offsets;
}

drone_spawn(team, offset, distance_down_path, drones) {
  if(!isDefined(distance_down_path))
    distance_down_path = 0;

  if(!isDefined(drones.dr_respawn))
    level endon("new drone Spawn wave");

  if(isDefined(drones.script_ender))
    level endon(drones.script_ender);

  if(isDefined(self.script_ender))
    level endon(self.script_ender);

  check_drone_throttle();

  if(isDefined(drones.dr_player_trace) && drones.dr_player_trace) {
    while(self spawnpoint_playersview())
      wait 0.2;
  }

  total_drones = level.drones.team["axis"].array.size + level.drones.team["allies"].array.size;

  if(total_drones >= level.drones.max_drones) {
    return;
  }
  if(isDefined(offset))
    spawnoffset = offset * 2 - 1;
  else
    spawnoffset = 0;

  spawnpos = self get_drone_spawn_pos(distance_down_path);

  if(isDefined(self.radius)) {
    angles = (0, 0, 0);

    if(isDefined(self.angles))
      angles = self.angles;

    right = anglestoright(angles);
    spawnpos = spawnpos + vectorscale(right, spawnoffset * self.radius);
  }

  level.drones.spawned_this_frame++;
  guy = spawn("script_model", bullettrace(spawnpos, spawnpos + vectorscale((0, 0, -1), 100000.0), 0, self)["position"]);
  guy.dronerunoffset = spawnoffset;

  if(isDefined(self.angles))
    guy.angles = self.angles;
  else if(isDefined(self.a_targeted))
    guy.angles = vectortoangles(self.a_targeted[0].origin - guy.origin);

  assert(isDefined(level.drone_spawnfunction[team]));
  override_class = undefined;

  if(isDefined(drones.unique_guys)) {
    index = randomint(drones.unique_guys.size);
    spawner = drones.unique_guys[index];
    override_class = spawner.classname;
  }

  if(isDefined(level.drone_spawnfunction_passnode))
    guy[[level.drone_spawnfunction[team]]](self);
  else if(isDefined(override_class))
    guy[[level.drone_spawnfunction[team]]](override_class);
  else
    guy[[level.drone_spawnfunction[team]]]();

  guy drone_assign_weapon(team, self, drones);
  guy.targetname = "drone";
  guy.script_noteworthy = self.script_noteworthy;
  guy makefakeai();

  if(isDefined(drones.b_use_cheap_flag) && drones.b_use_cheap_flag)
    guy setcheapflag(1);

  guy.team = team;
  guy.script_allowdeath = drones.script_allowdeath;
  guy useanimtree(#animtree);

  if(isDefined(drones) && isDefined(drones.drone_run_cycle_override))
    guy.drone_run_cycle_override = drones.drone_run_cycle_override;

  guy drone_set_run_cycle();

  if(isDefined(level.drone_run_rate))
    guy.dronerunrate = level.drone_run_rate;
  else if(isDefined(drones) && isDefined(drones.speed_modifier_min) && isDefined(drones.speed_modifier_max)) {
    modifier = 1.0 + randomfloatrange(drones.speed_modifier_min, drones.speed_modifier_max);
    guy.dronerunrate = guy.dronerunrate * modifier;
  } else if(isDefined(level.drone_run_rate_multiplier))
    guy.dronerunrate = guy.dronerunrate * level.drone_run_rate_multiplier;

  guy thread drone_think(self, level.drones.new_target_node);

  if(isDefined(drones.dr_respawn)) {
    if(isDefined(self.script_ender))
      level thread drone_respawn_after_death(guy, self, team, offset, self.script_ender, drones);
    else
      level thread drone_respawn_after_death(guy, self, team, offset, undefined, drones);
  }
}

get_drone_spawn_pos(required_distance) {
  node = self;
  spawn_pos = node.origin;
  level.drones.new_target_node = undefined;

  if(required_distance == 0 || !isDefined(node.target))
    return spawn_pos;

  next_node = node;
  dist_so_far = 0;

  while(dist_so_far < required_distance) {
    if(!isDefined(node.target))
      return spawn_pos;

    next_node = getstruct(node.target, "targetname");
    dir = next_node.origin - node.origin;
    dir_norm = vectornormalize(dir);
    dist_to_next_node = distance(node.origin, next_node.origin);

    if(dist_so_far + dist_to_next_node > required_distance) {
      frac = (required_distance - dist_so_far) / dist_to_next_node;
      spawn_pos = spawn_pos + dir * frac;
      break;
    }

    dist_so_far = dist_so_far + dist_to_next_node;
    spawn_pos = spawn_pos + dir;
    level.drones.new_target_node = next_node;
    node = next_node;
  }

  return spawn_pos;
}

drone_assign_weapon(team, start_struct, drones) {
  if(isDefined(start_struct.weaponinfo))
    self setcurrentweapon(start_struct.weaponinfo);
  else if(isDefined(drones.weaponinfo))
    self setcurrentweapon(drones.weaponinfo);
  else if(team == "allies") {
    if(isDefined(level.drone_weaponlist_allies) && level.drone_weaponlist_allies.size > 0) {
      if(level.drone_weaponlist_allies[0] == "unarmed") {
        self setcurrentweapon(undefined);
        return;
      }

      randweapon = randomint(level.drone_weaponlist_allies.size);
      self setcurrentweapon(level.drone_weaponlist_allies[randweapon]);
      assert(isDefined(self.weapon), "_drones::couldn't assign weapon from level.drone_weaponlist because the array value is undefined.");
    }
  } else if(isDefined(level.drone_weaponlist_axis) && level.drone_weaponlist_axis.size > 0) {
    randweapon = randomint(level.drone_weaponlist_axis.size);
    self setcurrentweapon(level.drone_weaponlist_axis[randweapon]);
    assert(isDefined(self.weapon), "_drones::couldn't assign weapon from level.drone_weaponlist because the array value is undefined.");
  }

  if(self.weapon != "none") {
    self attach(self.weaponmodel, "tag_weapon_right");
    self useweaponhidetags(self.weapon);
    self.bulletsinclip = weaponclipsize(self.weapon);
  }
}

drone_allies_assignweapon_american() {
  array = [];
  array[array.size] = "m16_sp";
  return array[randomint(array.size)];
}

drone_allies_assignweapon_british() {
  array = [];
  array[array.size] = "m16_sp";
  return array[randomint(array.size)];
}

drone_allies_assignweapon_russian() {
  array = [];
  array[array.size] = "ak47_sp";
  return array[randomint(array.size)];
}

drone_axis_assignweapon_german() {
  array = [];
  array[array.size] = "ak47_sp";
  return array[randomint(array.size)];
}

drone_axis_assignweapon_japanese() {
  array = [];
  array[array.size] = "ak47_sp";
  return array[randomint(array.size)];
}

check_drone_throttle() {
  can_spawn = 0;

  while(!can_spawn) {
    if(level.drones.spawned_this_frame > level.drones.max_per_frame)
      flag_set("reached_drone_spawn_cap");

    flag_waitopen("reached_drone_spawn_cap");
    wait 0.05;

    if(level.drones.spawned_this_frame < level.drones.max_per_frame)
      can_spawn = 1;
  }
}

reset_drone_throttle() {
  while(true) {
    waittillframeend;
    flag_clear("reached_drone_spawn_cap");
    level.drones.spawned_this_frame = 0;
    wait 0.05;
  }
}

drone_respawn_after_death(guy, start_struct, team, offset, ender, drones) {
  min_respawn_time = level.drones.respawn_death_delay_min;
  max_respawn_time = level.drones.respawn_death_delay_max;

  if(isDefined(ender))
    level endon(ender);

  guy waittill("death");
  wait(randomfloatrange(min_respawn_time, max_respawn_time));
  drones_respawner_created(start_struct);
  start_struct thread drone_spawn(team, offset, 0, drones);
}

spawnpoint_playersview() {
  if(!isDefined(level.cos80))
    level.cos80 = cos(80);

  players = get_players();
  player_view_count = 0;
  success = 0;

  for(i = 0; i < players.size; i++) {
    forwardvec = anglestoforward(players[i].angles);
    normalvec = vectornormalize(self.origin - players[i] getorigin());
    vecdot = vectordot(forwardvec, normalvec);

    if(vecdot > level.cos80) {
      success = bullettracepassed(players[i] geteye(), self.origin + vectorscale((0, 0, 1), 48.0), 0, self);

      if(success)
        player_view_count++;
    }
  }

  if(player_view_count != 0)
    return true;

  return false;
}

drone_setname() {
  self endon("drone_death");
  wait 0.25;

  if(!isDefined(self)) {
    return;
  }
  if(self.team != "allies") {
    return;
  }
  if(!isDefined(level.names))
    maps\_names::setup_names();

  if(isDefined(self.script_friendname))
    self.name = self.script_friendname;
  else
    self maps\_names::get_name();

  assert(isDefined(self.name));
  subtext = undefined;

  if(!isDefined(self.weapon))
    subtext = & "";
  else {
    switch (self.weapon) {
      case "commando_sp":
        subtext = & "";
        break;
      case "SVT40":
      case "lee_enfield":
      case "m1carbine":
      case "m1garand":
      case "m1garand_wet":
      case "mosin_rifle":
        subtext = & "WEAPON_RIFLEMAN";
        break;
      case "thompson":
      case "thompson_wet":
        subtext = & "WEAPON_SUBMACHINEGUNNER";
        break;
      case "BAR":
      case "ppsh":
      default:
        subtext = & "WEAPON_SUPPORTGUNNER";
        break;
    }
  }

  if(isDefined(self.model) && issubstr(self.model, "medic"))
    subtext = & "WEAPON_MEDICPLACEHOLDER";

  assert(isDefined(subtext));
  self setlookattext(self.name, & "");
}

drone_think(firstnode, override_target_node) {
  self endon("death");
  self.health = 100;
  self thread drone_setname();

  if(self.team == "allies" && level.drones.friendly_fire)
    level thread maps\_friendlyfire::friendly_fire_think(self);

  self thread drones_clear_variables();
  structarray_add(level.drones.team[self.team], self);
  level notify("new_drone");

  if(isDefined(level.drones_mg_target)) {
    self.turrettarget = spawn("script_origin", self.origin + vectorscale((0, 0, 1), 50.0));
    self.turrettarget linkto(self);
  }

  self endon("drone_death");

  if(isDefined(level.drones.think_func))
    self thread[[level.drones.think_func]]();

  if(!is_false(self.script_allowdeath)) {
    if(isDefined(level.drones.death_func))
      self thread[[level.drones.death_func]]();
    else
      self thread drone_fakedeath();
  }

  self.no_death_sink = 0;

  if(isDefined(firstnode.script_drone_no_sink) && firstnode.script_drone_no_sink)
    self.no_death_sink = 1;

  if(isDefined(override_target_node))
    self drone_runchain(override_target_node);
  else if(isDefined(firstnode.target))
    self drone_runchain(firstnode);

  wait 0.05;
  self.running = undefined;
  level notify("drone_at_last_node", self);
  self thread drone_loop_anim(firstnode);
}

drone_loop_anim(s_reference) {
  self endon("death");
  self endon("drone_death");

  if(!isDefined(s_reference.target)) {
    if(isDefined(s_reference.dr_animation) && isDefined(level.drones.anims[s_reference.dr_animation])) {
      if(isarray(level.drones.anims[s_reference.dr_animation]))
        anim_idle[0] = random(level.drones.anims[s_reference.dr_animation]);
      else
        anim_idle[0] = level.drones.anims[s_reference.dr_animation];
    }
  }

  if(!isDefined(anim_idle)) {
    while(isDefined(self)) {
      self animscripted("drone_idle_anim", self.origin, self.angles, level.drones.anim_idle[randomint(level.drones.anim_idle.size)]);
      self waittillmatch("drone_idle_anim", "end");
    }
  } else {
    while(isDefined(self)) {
      self animscripted("drone_idle_anim", self.origin, self.angles, anim_idle[randomint(anim_idle.size)]);
      self waittillmatch("drone_idle_anim", "end");
    }
  }
}

drone_mortardeath(direction) {
  self useanimtree(#animtree);

  switch (direction) {
    case "up":
      self thread drone_dodeath( % death_explosion_up10);
      break;
    case "forward":
      self thread drone_dodeath( % death_explosion_forward13);
      break;
    case "back":
      self thread drone_dodeath( % death_explosion_back13);
      break;
    case "left":
      self thread drone_dodeath( % death_explosion_left11);
      break;
    case "right":
      self thread drone_dodeath( % death_explosion_right13);
      break;
  }
}

drone_flamedeath() {
  self useanimtree(#animtree);
  self thread drone_fakedeath(1, 1);
}

drone_fakedeath(instant, flamedeath) {
  if(!isDefined(instant))
    instant = 0;

  self endon("delete");
  self endon("drone_death");

  while(isDefined(self)) {
    if(!instant) {
      self setcandamage(1);
      self waittill("damage", amount, attacker, undefined, damage_ori, type);

      if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
        if(amount == 1) {
          self thread drone_fakedeath();
          return;
        }

        self.damageweapon = "none";
        explosivedeath = 1;
      } else if(type == "MOD_BURNED")
        flamedeath = 1;

      self death_notify_wrapper(attacker, type);

      if(self.team == "axis" && (isplayer(attacker) || attacker == level.playervehicle)) {
        level notify("player killed drone");
        attacker thread maps\_damagefeedback::updatedamagefeedback();
      }
    }

    if(!isDefined(self)) {
      return;
    }
    self notify("stop_shooting");
    self.dontdelete = 1;
    self useanimtree(#animtree);

    if(isDefined(explosivedeath) && explosivedeath && !(isDefined(level.disable_drone_explosive_deaths) && level.disable_drone_explosive_deaths)) {
      direction = drone_get_explosion_death_dir(self.origin, self.angles, damage_ori, 50);
      self thread drone_mortardeath(direction);
      return;
    } else if(isDefined(flamedeath) && flamedeath) {
      deaths[0] = % ai_flame_death_a;
      deaths[1] = % ai_flame_death_b;
      deaths[2] = % ai_flame_death_c;
      deaths[3] = % ai_flame_death_d;
    } else if(isDefined(self.running)) {
      deaths[0] = % run_death_facedown;
      deaths[1] = % run_death_fallonback;
      deaths[2] = % run_death_roll;
      deaths[3] = % run_death_flop;
    } else {
      deaths[0] = % ai_death_collapse_in_place;
      deaths[1] = % ai_death_faceplant;
      deaths[2] = % ai_death_fallforward;
      deaths[3] = % ai_death_fallforward_b;
    }

    self thread drone_dodeath(deaths[randomint(deaths.size)]);
    return;
  }
}

drone_delayed_bulletdeath(waittime) {
  if(!isDefined(waittime))
    waittime = 0;

  self endon("delete");
  self endon("drone_death");
  self.dontdelete = 1;

  if(waittime > 0)
    wait(waittime);

  self thread drone_fakedeath(1);
}

do_death_sound() {
  camp = level.campaign;
  team = self.team;
  alias = undefined;

  if(camp == "american" && team == "allies")
    alias = "dds_generic_death_american";

  if(camp == "american" && team == "axis")
    alias = "dds_generic_death_japanese";

  if(camp == "russian" && team == "allies")
    alias = "dds_generic_death_russian";

  if(camp == "russian" && team == "axis")
    alias = "dds_generic_death_german";

  if(camp == "vietnamese" && team == "axis")
    alias = "dds_generic_death_vietnamese ";

  if(isDefined(alias) && soundexists(alias) && !level.drones.sounds_disabled)
    self thread play_sound_in_space(alias);
}

drone_dodeath(deathanim, deathremovenotify) {
  self endon("delete");

  if(is_true(self.dead))
    return;
  else
    self.dead = 1;

  self moveto(self.origin, 0.05, 0, 0);
  tracedeath = 0;

  if(isDefined(self.running) && self.running)
    tracedeath = 1;

  self.running = undefined;
  self notify("drone_death");
  self notify("stop_shooting");
  self unlink();
  self useanimtree(#animtree);
  self thread drone_dodeath_impacts();
  do_death_sound();
  cancelrunningdeath = 0;

  if(tracedeath) {
    offset = getcycleoriginoffset(self.angles, deathanim);
    endanimationlocation = self.origin + offset;
    endanimationlocation = physicstrace(endanimationlocation + vectorscale((0, 0, 1), 128.0), endanimationlocation - vectorscale((0, 0, 1), 128.0));
    d1 = abs(endanimationlocation[2] - self.origin[2]);

    if(d1 > 20)
      cancelrunningdeath = 1;
    else {
      forwardvec = anglestoforward(self.angles);
      rightvec = anglestoright(self.angles);
      upvec = anglestoup(self.angles);
      relativeoffset = vectorscale((1, 0, 0), 50.0);
      secondpos = endanimationlocation;
      secondpos = secondpos + vectorscale(forwardvec, relativeoffset[0]);
      secondpos = secondpos + vectorscale(rightvec, relativeoffset[1]);
      secondpos = secondpos + vectorscale(upvec, relativeoffset[2]);
      secondpos = physicstrace(secondpos + vectorscale((0, 0, 1), 128.0), secondpos - vectorscale((0, 0, 1), 128.0));
      d2 = abs(secondpos[2] - self.origin[2]);

      if(d2 > 20)
        cancelrunningdeath = 1;
    }
  }

  if(cancelrunningdeath)
    deathanim = % ai_death_collapse_in_place;

  self animscripted("drone_death_anim", self.origin, self.angles, deathanim, "deathplant");
  self thread drone_drop_weapon("drone_death_anim", deathanim);
  self thread drone_ragdoll("drone_death_anim", deathanim);
  self waittillmatch("drone_death_anim", "end");

  if(!isDefined(self)) {
    return;
  }
  self setcontents(0);

  if(isDefined(deathremovenotify))
    level waittill(deathremovenotify);
  else
    wait 3;

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.no_death_sink) || isDefined(self.no_death_sink) && !self.no_death_sink) {
    self moveto(self.origin - vectorscale((0, 0, 1), 100.0), 7);
    wait 3;
  }

  if(!isDefined(self)) {
    return;
  }
  self.dontdelete = undefined;
  self thread drone_delete();
}

drone_drop_weapon(drone_death_anim_flag, deathanim) {
  if(animhasnotetrack(deathanim, "dropgun"))
    self waittillmatch(drone_death_anim_flag, "dropgun");
  else
    wait 0.2;

  if(isDefined(self.weapon)) {
    if(isDefined(self.weaponmodel) && self.weaponmodel != "")
      self detach(self.weaponmodel, "tag_weapon_right");
  }
}

drone_ragdoll(drone_death_anim_flag, deathanim) {
  if(!animhasnotetrack(deathanim, "start_ragdoll")) {
    time = getanimlength(deathanim);
    wait(time * 0.8);
  } else
    self waittillmatch(drone_death_anim_flag, "start_ragdoll");

  if(isDefined(level.no_drone_ragdoll) && level.no_drone_ragdoll == 1) {
  } else if(self drone_available_ragdoll())
    self add_to_ragdoll_bucket();
}

drone_dodeath_impacts() {
  self endon("death");
  self endon("drone_death");
  bone[0] = "J_Knee_LE";
  bone[1] = "J_Ankle_LE";
  bone[2] = "J_Clavicle_LE";
  bone[3] = "J_Shoulder_LE";
  bone[4] = "J_Elbow_LE";
  impacts = 1 + randomint(2);

  for(i = 0; i < impacts; i++) {
    playfxontag(level.drones.impact_fx, self, bone[randomint(bone.size)]);

    if(!level.drones.sounds_disabled)
      self playsound("prj_bullet_impact_small_flesh");

    wait 0.05;
  }
}

drone_runchain(point_start) {
  self.v_destination = undefined;

  while(isDefined(self)) {
    if(isDefined(point_start.dr_death_timer)) {
      self.dontdelete = 1;
      timer_min = get_min_value(point_start.dr_death_timer, 0);
      timer_max = get_max_value(point_start.dr_death_timer, 0);
      time = timer_min;

      if(timer_max > timer_min)
        time = randomfloatrange(timer_min, timer_max);

      self thread drone_delayed_bulletdeath(time);
    } else if(!isDefined(point_start.a_targeted) && !isDefined(point_start.script_delete)) {
      self.dontdelete = undefined;
      self thread drone_delete(0.01);
    }

    if(isDefined(point_start.script_delete) && point_start.script_delete) {
      self.dontdelete = undefined;
      self thread drone_delete(point_start.script_delete);
    }

    if(!isDefined(point_start.a_targeted)) {
      break;
    }

    point_end = point_start.a_targeted;

    if(!isDefined(point_end) || !isDefined(point_end[0])) {
      break;
    }

    index = randomint(point_end.size);
    self.v_destination = bullettrace(point_end[index].origin, point_end[index].origin + vectorscale((0, 0, -1), 100000.0), 0, self)["position"];

    if(isDefined(point_end[index].radius)) {
      assert(point_end[index].radius > 0);

      if(!isDefined(self.dronerunoffset))
        self.dronerunoffset = -1 + randomfloat(2);

      if(!isDefined(point_end[index].angles))
        point_end[index].angles = (0, 0, 0);

      forwardvec = anglestoforward(point_end[index].angles);
      rightvec = anglestoright(point_end[index].angles);
      upvec = anglestoup(point_end[index].angles);
      relativeoffset = (0, self.dronerunoffset * point_end[index].radius, 0);
      self.v_destination = self.v_destination + vectorscale(forwardvec, relativeoffset[0]);
      self.v_destination = self.v_destination + vectorscale(rightvec, relativeoffset[1]);
      self.v_destination = self.v_destination + vectorscale(upvec, relativeoffset[2]);
    }

    self process_event(point_start);
    randomanimrate = 0.9 + randomfloat(1.1 - 0.9);
    self thread drone_loop_run_anim(randomanimrate);
    self drone_runto();
    point_start = point_end[index];
  }

  self process_event(point_start);

  if(isDefined(point_start.script_delete) && point_start.script_delete)
    self thread drone_delete(point_start.script_delete);
}

drones_clear_variables() {
  if(isDefined(self.voice))
    self.voice = undefined;
}

drone_delete(delaytime) {
  self endon("death");

  if(isDefined(delaytime) && delaytime > 0)
    wait(delaytime);

  if(!isDefined(self)) {
    return;
  }
  self notify("drone_death");
  self notify("drone_idle_anim");

  if(isinarray(level.drones.team[self.team].array, self))
    structarray_remove(level.drones.team[self.team], self);

  if(!isDefined(self.dontdelete)) {
    if(isDefined(self.turrettarget))
      self.turrettarget delete();

    if(isDefined(self.temp_target))
      self.temp_target delete();

    self detachall();
    self delete();
  }
}

process_event(s_start) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self endon("drone_death");
  self notify("stop_shooting");
  self useanimtree(#animtree);
  d = distance(self.origin, self.v_destination);

  if(!isDefined(self.dronerunrate) || isDefined(self.dronerunrate) && self.dronerunrate == 0)
    self.dronerunrate = 200;

  self.n_travel_time = d / self.dronerunrate;
  self.lowheight = 0;
  self turn_to_face_point(self.v_destination, self.n_travel_time);
  skip = 0;

  if(isDefined(s_start.dr_percent) && randomint(100) < s_start.dr_percent)
    skip = 1;

  if(!skip && isDefined(s_start.dr_event)) {
    switch (s_start.dr_event) {
      case "shoot":
        self drone_event_shoot(s_start, 0, 0);
        break;
      case "shoot_burst":
        self drone_event_shoot(s_start, 0, 1);
        break;
      case "shoot_forever":
        self.n_shots_to_fire = 999999;
        self drone_event_shoot(s_start, 0, 0);
        break;
      case "shoot_bullets":
        self drone_event_shoot(s_start, 1);
        break;
      case "run_and_shoot":
        self thread drone_event_run_and_shoot(0);
        break;
      case "run_and_shoot_burst":
        self thread drone_event_run_and_shoot(1);
        break;
      case "play_looped_anim":
        drone_event_looped_anim(s_start, self.v_destination);
        skip = 1;
        break;
      case "low_height":
        self.lowheight = 1;
        break;
      case "mortardeath_up":
        self thread drone_mortardeath("up");
        return;
      case "mortardeath_forward":
        self thread drone_mortardeath("forward");
        return;
      case "mortardeath_back":
        self thread drone_mortardeath("back");
        return;
      case "mortardeath_left":
        self thread drone_mortardeath("left");
        return;
      case "mortardeath_right":
        self thread drone_mortardeath("right");
        return;
      case "cover_stand":
        self thread drone_cover(s_start.dr_event);
        self waittill("drone out of cover");
        self setflaggedanimknob("cover_exit", % coverstand_trans_out_m, 1, 0.1, 1);
        self waittillmatch("cover_exit", "end");
        break;
      case "cover_crouch":
        self thread drone_cover(s_start.dr_event);
        self waittill("drone out of cover");
        self setflaggedanimknob("cover_exit", % covercrouch_run_out_m, 1, 0.1, 1);
        self waittillmatch("cover_exit", "end");
        break;
      case "cover_crouch_fire":
        self thread drone_cover_fire(s_start.dr_event);
        self waittill("drone out of cover");
        self setflaggedanimknob("cover_exit", % covercrouch_run_out_m, 1, 0.5, 1);
        self waittillmatch("cover_exit", "end");
        break;
      case "flamedeath":
        self thread drone_flamedeath();
        break;
      case "run_fast":
        self drone_set_run_cycle();
        self.running = 0;
        d = distance(self.origin, self.v_destination);
        self.n_travel_time = d / self.dronerunrate;
        break;
      default:
        event_params = strtok(s_start.dr_event, ",");

        if(isDefined(level.drones.funcs[event_params[0]])) {
          params = event_params;
          event_param = event_params[0];
          arrayremovevalue(params, event_params[0]);
          self[[level.drones.funcs[event_param]]](s_start, self.v_destination, params);
        } else {
          assertmsg("The event \"" + s_start.dr_event + "\" is not a valid drone event.If you are trying to use a custom event function, make sure it has been defined in level.drones.funcs");

        }

        break;
    }
  }

  if(!skip && isDefined(s_start.dr_animation)) {
    assert(isDefined(level.drones.anims[s_start.dr_animation]), "There is no animation defined for level.drones.anims[ \"" + s_start.dr_animation + "\" ].dr_animation defined at: " + s_start.origin);
    anim_custom = level.drones.anims[s_start.dr_animation];

    if(isarray(anim_custom))
      anim_custom = anim_custom[randomint(anim_custom.size)];

    self.is_playing_custom_anim = 1;
    self.running = undefined;
    angles = vectortoangles(self.v_destination - self.origin);
    offset = getcycleoriginoffset(angles, anim_custom);
    endpos = self.origin + offset;
    endpos = physicstrace(endpos + vectorscale((0, 0, 1), 64.0), endpos - (0, 0, level.drones.trace_height));
    t = getanimlength(anim_custom);
    assert(t > 0);
    self moveto(endpos, t, 0, 0);
    self clearanim(self.drone_run_cycle, 0.2);
    self notify("stop_drone_loop_run_anim");
    self setflaggedanimknobrestart("drone_custom_anim", anim_custom);
    self waittillmatch("drone_custom_anim", "end");
    self.origin = endpos;
    self notify("custom_anim_done");
    d = distance(self.origin, self.v_destination);
    self.n_travel_time = d / self.dronerunrate;
    self.is_playing_custom_anim = undefined;
  }
}

drone_runto() {
  if(self.n_travel_time < 0.1) {
    return;
  }
  percentage = 0.0;
  startingpos = self.origin;
  oldz = startingpos[2];

  for(i = 0; i < 1 / 0.1; i++) {
    percentage = percentage + 0.1;
    x = (self.v_destination[0] - startingpos[0]) * percentage + startingpos[0];
    y = (self.v_destination[1] - startingpos[1]) * percentage + startingpos[1];

    if(self.lowheight == 1)
      percentagemark = physicstrace((x, y, self.v_destination[2] + 64), (x, y, self.v_destination[2] - level.drones.trace_height));
    else
      percentagemark = physicstrace((x, y, self.v_destination[2] + level.drones.trace_height), (x, y, self.v_destination[2] - level.drones.trace_height));

    if(percentagemark[2] - oldz > level.drones.step_height)
      percentagemark = (percentagemark[0], percentagemark[1], oldz);

    oldz = percentagemark[2];
    self moveto(percentagemark, self.n_travel_time * 0.1, 0, 0);
    wait(self.n_travel_time * 0.1);
  }
}

drone_event_shoot(s_start, b_shoot_bullets, b_shoot_burst) {
  self endon("death");

  if(!isDefined(b_shoot_bullets))
    b_shoot_bullets = 0;

  if(!isDefined(b_shoot_burst))
    b_shoot_burst = 0;

  if(isDefined(s_start.script_int))
    self.n_shots_to_fire = s_start.script_int;

  e_target = undefined;

  if(isDefined(s_start.script_string)) {
    e_target = getent(s_start.script_string, "targetname");
    assert(isDefined(e_target), "No target for drone event @ " + s_start.origin + ".GetEnt failed looking for \"" + s_start.script_string + "\"");
  } else {
    target_offset = anglestoforward(self.angles) * 300;
    shootpos = self.origin + target_offset;

    if(isDefined(self.temp_target))
      self.temp_target.origin = shootpos;
    else
      self.temp_target = spawn("script_origin", shootpos);

    e_target = self.temp_target;
  }

  if(isDefined(b_shoot_bullets) && b_shoot_bullets)
    self drone_shoot_bullets(e_target);
  else
    self drone_shoot_blanks(e_target, b_shoot_burst);

  self clearanim( % combat_directions, 0.2);
  self clearanim( % exposed_reload, 0.2);
}

drone_shoot_bullets(e_target) {
  self endon("death");
  self useanimtree(#animtree);
  self.running = undefined;
  self thread drone_aim_at_target(e_target, "stop_shooting");
  v_tag_flash = self.origin + vectorscale((0, 0, 1), 50.0);

  if(!isDefined(self.n_shots_to_fire))
    self.n_shots_to_fire = 1;

  for(i = 0; i < self.n_shots_to_fire; i++) {
    if(self.bulletsinclip <= 0) {
      self setflaggedanimknoballrestart("reloadanim", % exposed_reload, % root, 1, 0.4);
      self.bulletsinclip = weaponclipsize(self.weapon);
      self waittillmatch("reloadanim", "end");
    }

    self set3flaggedanimknobs("no flag", "aim", "stand", 1, 0.3, 1);
    wait(1 + randomfloat(2));
    v_tag_flash = self gettagorigin("tag_flash");
    magicbullet(self.weapon, v_tag_flash, e_target.origin, self);
    self.bulletsinclip--;
    wait(1 + randomfloat(2));
  }

  self.n_shots_to_fire = undefined;
  self notify("stop_shooting");
}

drone_shoot_blanks(e_target, b_shoot_burst) {
  self endon("death");
  self notify("stop_shooting");
  self endon("stop_shooting");

  if(!isDefined(b_shoot_burst))
    b_shoot_burst = 0;

  self useanimtree(#animtree);
  self.running = undefined;
  self thread drone_aim_at_target(e_target, "stop_shooting");
  shootanimlength = 0;

  if(!isDefined(self.n_shots_to_fire))
    self.n_shots_to_fire = 1;

  n_shots_fired = 0;

  while(n_shots_fired < self.n_shots_to_fire) {
    if(self.bulletsinclip <= 0) {
      numattached = self getattachsize();
      attachname = [];

      for(i = 0; i < numattached; i++)
        attachname[i] = self getattachmodelname(i);

      self setflaggedanimknoballrestart("reloadanim", % exposed_reload, % root, 1, 0.4);
      self.bulletsinclip = weaponclipsize(self.weapon);
      self waittillmatch("reloadanim", "end");
    }

    self set3flaggedanimknobs("no flag", "aim", "stand", 1, 0.3, 1);
    wait(1 + randomfloat(2));

    if(!isDefined(self)) {
      return;
    }
    n_shots = randomint(4) + 1;

    if(n_shots > self.n_shots_to_fire - n_shots_fired)
      n_shots = self.n_shots_to_fire - n_shots_fired;

    if(n_shots > self.bulletsinclip)
      n_shots = self.bulletsinclip;

    for(i = 0; i < n_shots; i++) {
      if(!isDefined(self)) {
        return;
      }
      self set3flaggedanimknobsrestart("shootinganim", "shoot", "stand", 1, 0.05, 1);
      blank_shot_fx(b_shoot_burst);

      if(b_shoot_burst)
        self.bulletsinclip = self.bulletsinclip - 3;
      else
        self.bulletsinclip--;

      n_shots_fired++;

      if(shootanimlength == 0) {
        shootanimlength = gettime();
        self waittillmatch("shootinganim", "end");
        shootanimlength = (gettime() - shootanimlength) / 1000;
        continue;
      }

      wait(shootanimlength - 0.1 + randomfloat(0.3));

      if(!isDefined(self))
        return;
    }
  }

  self.n_shots_to_fire = undefined;
  self notify("stop_shooting");
}

drone_event_run_and_shoot(b_shoot_burst) {
  old_cycle = self.drone_run_cycle;
  self drone_set_run_cycle( % run_n_gun_f);
  self.running = 0;
  self thread drone_loop_run_anim();
  self thread drone_run_and_shoot_blanks(b_shoot_burst);
  self waittill("stop_shooting");
  self thread drone_set_run_cycle(old_cycle);
}

drone_run_and_shoot_blanks(b_shoot_burst) {
  self endon("death");
  self endon("stop_shooting");
  n_shots = 1;

  if(b_shoot_burst)
    n_shots = 3;

  while(true) {
    wait(0.25 + randomfloat(2));
    blank_shot_fx(b_shoot_burst);
  }
}

blank_shot_fx(b_shoot_burst) {
  self endon("death");
  str_wpn_sound = "wpn_mosin_fire";
  n_shots = 1;

  if(b_shoot_burst)
    n_shots = 3;

  for(i = 0; i < n_shots; i++) {
    playfxontag(level.drones.muzzleflash, self, "tag_flash");

    if(!level.drones.sounds_disabled)
      self playsound(str_wpn_sound);

    wait 0.05;
  }
}

drone_event_looped_anim(s_start, v_destination) {
  self endon("death");

  if(!isDefined(level.flag["drones_stop_looped_anims"]))
    flag_init("drones_stop_looped_anims");

  if(!flag("drones_stop_looped_anims") && isDefined(s_start.dr_animation)) {
    assert(isDefined(level.drones.anims[s_start.dr_animation]), "There is no animation defined for level.drones.anims[ \"" + s_start.dr_animation + "\" ].dr_animation defined at: " + s_start.origin);
    anim_custom = level.drones.anims[s_start.dr_animation];

    if(isarray(anim_custom))
      anim_custom = anim_custom[randomint(anim_custom.size)];

    self.is_playing_custom_anim = 1;
    self.running = undefined;
    angles = vectortoangles(v_destination - self.origin);
    offset = getcycleoriginoffset(angles, anim_custom);
    endpos = self.origin + offset;
    endpos = physicstrace(endpos + vectorscale((0, 0, 1), 64.0), endpos - (0, 0, level.drones.trace_height));
    t = getanimlength(anim_custom);
    assert(t > 0);
    self moveto(endpos, t, 0, 0);
    self clearanim(self.drone_run_cycle, 0.2);
    self notify("stop_drone_loop_run_anim");
    self setanim(anim_custom, 1, 0.2);
    flag_wait("drones_stop_looped_anims");
    wait(randomfloatrange(0.1, 0.5));
    self clearanim(anim_custom, 0.2);
    self.drone_run_cycle = drone_pick_run_anim();
    self.origin = endpos;
    self notify("custom_anim_done");
    self.is_playing_custom_anim = undefined;
  }
}

drone_loop_run_anim(animratemod) {
  if(isDefined(self.running) && self.running) {
    return;
  }
  self notify("stop_drone_loop_run_anim");
  self endon("stop_drone_loop_run_anim");
  self endon("delete");
  self endon("drone_death");
  self.running = 1;

  if(!isDefined(animratemod))
    animratemod = 1.0;

  while(isDefined(self.running) && self.running) {
    animrate = self.dronerunrate / self.drone_run_cycle_speed;
    self setflaggedanimknobrestart("drone_run_anim", self.drone_run_cycle, 1, 0.2, animrate);
    self waittillmatch("drone_run_anim", "end");

    if(!isDefined(self))
      return;
  }
}

drone_debugline(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes * 20; i++) {
    line(frompoint, topoint, color);
    wait 0.05;
  }

}

turn_to_face_point(point, n_time) {
  desiredangles = vectortoangles(point - self.origin);

  if(!isDefined(n_time))
    n_time = 0.5;
  else if(n_time > 0.5)
    n_time = 0.5;

  if(n_time < 0.1) {
    return;
  }
  self rotateto((0, desiredangles[1], 0), n_time, 0, 0);
}

set3flaggedanimknobs(animflag, animarray, pose, weight, blendtime, rate) {
  if(!isDefined(self)) {
    return;
  }
  self setanimknob( % combat_directions, weight, blendtime, rate);
  self setflaggedanimknob(animflag, level.drones.animarray[animarray][pose]["up"], 1, blendtime, 1);
  self setanimknob(level.drones.animarray[animarray][pose]["straight"], 1, blendtime, 1);
  self setanimknob(level.drones.animarray[animarray][pose]["down"], 1, blendtime, 1);
}

set3flaggedanimknobsrestart(animflag, animarray, pose, weight, blendtime, rate) {
  if(!isDefined(self)) {
    return;
  }
  self setanimknobrestart( % combat_directions, weight, blendtime, rate);
  self setflaggedanimknobrestart(animflag, level.drones.animarray[animarray][pose]["up"], 1, blendtime, 1);
  self setanimknobrestart(level.drones.animarray[animarray][pose]["straight"], 1, blendtime, 1);
  self setanimknobrestart(level.drones.animarray[animarray][pose]["down"], 1, blendtime, 1);
}

apply_vertical_blend(offset) {
  if(offset < 0) {
    unstraightanim = % combat_down;
    self setanim( % combat_up, 0.01, 0, 1);
    offset = offset * -1;
  } else {
    unstraightanim = % combat_up;
    self setanim( % combat_down, 0.01, 0, 1);
  }

  if(offset > 1)
    offset = 1;

  unstraight = offset;

  if(unstraight >= 1.0)
    unstraight = 0.99;

  if(unstraight <= 0)
    unstraight = 0.01;

  straight = 1 - unstraight;
  self setanim(unstraightanim, unstraight, 0, 1);
  self setanim( % combat_straight, straight, 0, 1);
}

drone_aim_at_target(target, stopstring) {
  self endon(stopstring);

  while(isDefined(self)) {
    targetpos = target.origin;
    turn_to_face_point(targetpos);
    offset = get_target_vertical_offset(targetpos);
    apply_vertical_blend(offset);
    wait 0.05;
  }
}

get_target_vertical_offset(v_target_pos) {
  dir = vectornormalize(v_target_pos - self.origin);
  return dir[2];
}

set_anim_array() {
  level.drones.animarray["aim"]["stand"]["down"] = % stand_aim_down;
  level.drones.animarray["aim"]["stand"]["straight"] = % stand_aim_straight;
  level.drones.animarray["aim"]["stand"]["up"] = % stand_aim_up;
  level.drones.animarray["aim"]["crouch"]["down"] = % crouch_aim_down;
  level.drones.animarray["aim"]["crouch"]["straight"] = % crouch_aim_straight;
  level.drones.animarray["aim"]["crouch"]["up"] = % crouch_aim_up;
  level.drones.animarray["auto"]["stand"]["down"] = % stand_shoot_auto_down;
  level.drones.animarray["auto"]["stand"]["straight"] = % stand_shoot_auto_straight;
  level.drones.animarray["auto"]["stand"]["up"] = % stand_shoot_auto_up;
  level.drones.animarray["auto"]["crouch"]["down"] = % crouch_shoot_auto_down;
  level.drones.animarray["auto"]["crouch"]["straight"] = % crouch_shoot_auto_straight;
  level.drones.animarray["auto"]["crouch"]["up"] = % crouch_shoot_auto_up;
  level.drones.animarray["shoot"]["stand"]["down"] = % stand_shoot_down;
  level.drones.animarray["shoot"]["stand"]["straight"] = % stand_shoot_straight;
  level.drones.animarray["shoot"]["stand"]["up"] = % stand_shoot_up;
  level.drones.animarray["shoot"]["crouch"]["down"] = % crouch_shoot_down;
  level.drones.animarray["shoot"]["crouch"]["straight"] = % crouch_shoot_straight;
  level.drones.animarray["shoot"]["crouch"]["up"] = % crouch_shoot_up;
}

drone_cover_fire(type) {
  self endon("drone_stop_cover");
  self endon("drone_death");
  self endon("death");

  while(true) {
    drone_cover(type);
    self setanimknob( % stand_aim_straight, 1, 0.3, 1);
    wait 0.3;
    forwardvec = anglestoforward(self.angles);
    rightvec = anglestoright(self.angles);
    upvec = anglestoup(self.angles);
    relativeoffset = vectorscale((1, 0, 0), 300.0);
    shootpos = self.origin;
    shootpos = shootpos + vectorscale(forwardvec, relativeoffset[0]);
    shootpos = shootpos + vectorscale(rightvec, relativeoffset[1]);
    shootpos = shootpos + vectorscale(upvec, relativeoffset[2]);

    if(isDefined(self.temp_target))
      self.temp_target delete();

    self.temp_target = spawn("script_origin", shootpos);
    self.bulletsinclip = randomint(4) + 3;
    self thread drone_shoot_blanks(self.temp_target, 1);
    self waittill("stop_shooting");
  }
}

drone_cover(type) {
  self endon("drone_stop_cover");

  if(!isDefined(self.a))
    self.a = spawnstruct();

  self.running = undefined;
  self.a.array = [];

  if(type == "cover_stand") {
    self.a.array["hide_idle"] = % coverstand_hide_idle;
    self.a.array["hide_idle_twitch"] = array( % coverstand_hide_idle_twitch01, % coverstand_hide_idle_twitch02, % coverstand_hide_idle_twitch03, % coverstand_hide_idle_twitch04, % coverstand_hide_idle_twitch05);
    self.a.array["hide_idle_flinch"] = array( % coverstand_react01, % coverstand_react02, % coverstand_react03, % coverstand_react04);
    self setflaggedanimknobrestart("cover_approach", % coverstand_trans_in_m, 1, 0.3, 1);
    self waittillmatch("cover_approach", "end");
    self thread drone_cover_think();
  } else if(type == "cover_crouch") {
    self.a.array["hide_idle"] = % covercrouch_hide_idle;
    self.a.array["hide_idle_twitch"] = array( % covercrouch_twitch_1, % covercrouch_twitch_2, % covercrouch_twitch_3, % covercrouch_twitch_4);
    self setflaggedanimknobrestart("cover_approach", % covercrouch_run_in_m, 1, 0.3, 1);
    self waittillmatch("cover_approach", "end");
    self thread drone_cover_think();
  } else if(type == "cover_crouch_fire") {
    self.a.array["hide_idle"] = % covercrouch_hide_idle;
    self.a.array["hide_idle_twitch"] = array( % covercrouch_twitch_1, % covercrouch_twitch_2, % covercrouch_twitch_3, % covercrouch_twitch_4);
    self setanimknob( % covercrouch_hide_idle, 1, 0.4, 1);
    wait 0.4;
    self drone_cover_think(1 + randomint(3));
  }
}

drone_cover_think(max_loops) {
  self endon("drone_stop_cover");

  if(!isDefined(max_loops))
    max_loops = -1;

  for(loops = 0; loops < max_loops || max_loops == -1; loops++) {
    usetwitch = randomint(2) == 0;

    if(usetwitch)
      idleanim = animarraypickrandom("hide_idle_twitch");
    else
      idleanim = animarray("hide_idle");

    self drone_playidleanimation(idleanim, usetwitch);
  }
}

drone_playidleanimation(idleanim, needsrestart) {
  self endon("drone_stop_cover");

  if(needsrestart)
    self setflaggedanimknobrestart("idle", idleanim, 1, 0.1, 1);
  else
    self setflaggedanimknob("idle", idleanim, 1, 0.1, 1);

  self.a.covermode = "Hide";
  self waittillmatch("idle", "end");
}

drone_get_explosion_death_dir(self_pos, self_angle, explosion_pos, up_distance) {
  if(distance2d(self_pos, explosion_pos) < up_distance)
    return "up";

  p1 = self_pos - vectornormalize(anglestoforward(self_angle)) * 10000;
  p2 = self_pos + vectornormalize(anglestoforward(self_angle)) * 10000;
  p_intersect = pointonsegmentnearesttopoint(p1, p2, explosion_pos);
  side_away_dist = distance2d(p_intersect, explosion_pos);
  side_close_dist = distance2d(p_intersect, self_pos);

  if(side_close_dist != 0) {
    angle = atan(side_away_dist / side_close_dist);
    dot_product = vectordot(anglestoforward(self_angle), vectornormalize(explosion_pos - self_pos));

    if(dot_product < 0)
      angle = 180 - angle;

    if(angle < 45)
      return "back";
    else if(angle > 135)
      return "forward";
  }

  self_right_angle = vectornormalize(anglestoright(self_angle));
  right_point = self_pos + self_right_angle * (up_distance * 0.5);

  if(distance2d(right_point, explosion_pos) < distance2d(self_pos, explosion_pos))
    return "left";
  else
    return "right";
}

animarray(animname) {
  assert(isDefined(self.a.array));

  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), "self.a.array[ \"" + animname + "\" ] is undefined");
  }

  return self.a.array[animname];
}

animarrayanyexist(animname) {
  assert(isDefined(self.a.array));

  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), "self.a.array[ \"" + animname + "\" ] is undefined");
  }

  return self.a.array[animname].size > 0;
}

animarraypickrandom(animname) {
  assert(isDefined(self.a.array));

  if(!isDefined(self.a.array[animname])) {
    dumpanimarray();
    assert(isDefined(self.a.array[animname]), "self.a.array[ \"" + animname + "\" ] is undefined");
  }

  assert(self.a.array[animname].size > 0);

  if(self.a.array[animname].size > 1)
    index = randomint(self.a.array[animname].size);
  else
    index = 0;

  return self.a.array[animname][index];
}

dumpanimarray() {
  println("self.a.array:");
  keys = getarraykeys(self.a.array);

  for(i = 0; i < keys.size; i++) {
    if(isarray(self.a.array[keys[i]])) {
      println(" array[ \"" + keys[i] + "\" ] = {array of size " + self.a.array[keys[i]].size + "}");
      continue;
    }

    println(" array[ \"" + keys[i] + "\" ] = ", self.a.array[keys[i]]);
  }

}

drone_pick_run_anim() {
  if(isDefined(level.drone_run_cycle_override)) {
    if(isarray(level.drone_run_cycle_override))
      return level.drone_run_cycle_override[randomint(level.drone_run_cycle_override.size)];
    else
      return level.drone_run_cycle_override;
  } else if(isDefined(self.drone_run_cycle_override)) {
    if(isarray(self.drone_run_cycle_override))
      return self.drone_run_cycle_override[randomint(self.drone_run_cycle_override.size)];
    else
      return self.drone_run_cycle_override;
  }

  dronerunanims = array( % run_n_gun_f, % run_lowready_f, % ai_militia_run_lowready_f_02, % ai_militia_run_lowready_f_03, % ai_sprint_f_05);
  index = randomint(dronerunanims.size);
  return dronerunanims[index];
}

drone_set_run_cycle(runanim) {
  if(!isDefined(runanim))
    runanim = drone_pick_run_anim();

  self.drone_run_cycle = runanim;
  self.drone_run_cycle_speed = drone_run_anim_speed(runanim);
  self.dronerunrate = self.drone_run_cycle_speed;
}

drone_run_anim_speed(runanim) {
  run_cycle_delta = getmovedelta(runanim, 0, 1);
  run_cycle_dist = length(run_cycle_delta);
  run_cycle_length = getanimlength(runanim);
  run_cycle_speed = run_cycle_dist / run_cycle_length;
  return run_cycle_speed;
}

drones_get_triggers(script_string_trigger_name) {
  triggers = [];

  if(isDefined(level.drones.axis_triggers)) {
    ents = level.drones.axis_triggers;

    for(i = 0; i < ents.size; i++) {
      if(isDefined(ents[i].script_string)) {
        if(ents[i].script_string == script_string_trigger_name)
          triggers[triggers.size] = ents[i];
      }
    }
  }

  if(isDefined(level.drones.allies_triggers)) {
    ents = level.drones.allies_triggers;

    for(i = 0; i < ents.size; i++) {
      if(isDefined(ents[i].script_string)) {
        if(ents[i].script_string == script_string_trigger_name)
          triggers[triggers.size] = ents[i];
      }
    }
  }

  return triggers;
}

drones_set_max_ragdolls(max_ragdolls) {
  level.drones.max_ragdolls = max_ragdolls;
}

drone_available_ragdoll(force_remove) {
  if(!isDefined(level.drones.ragdoll_bucket))
    level.drones.ragdoll_bucket = [];

  if(level.drones.ragdoll_bucket.size >= level.drones.max_ragdolls) {
    num_in_bucket = clean_up_ragdoll_bucket();

    if(num_in_bucket < level.drones.max_ragdolls)
      return true;
    else if(isDefined(force_remove)) {
      if(level.drones.ragdoll_bucket[0].targetname == "drone") {
        self.dontdelete = undefined;
        level.drones.ragdoll_bucket[0] maps\_drones::drone_delete();
      } else
        level.drones.ragdoll_bucket[0] delete();

      arrayremoveindex(level.drones.ragdoll_bucket, 0);
      return true;
    }

    return false;
  }

  return true;
}

add_to_ragdoll_bucket() {
  if(!isDefined(level.drones.ragdoll_bucket))
    level.drones.ragdoll_bucket = [];

  self.ragdoll_start_time = gettime();
  level.drones.ragdoll_bucket[level.drones.ragdoll_bucket.size] = self;
  self startragdoll();
}

clean_up_ragdoll_bucket() {
  current_time = gettime();
  new_bucket = [];

  for(i = 0; i < 16; i++) {
    if(!isDefined(level.drones.ragdoll_bucket[i])) {
      continue;
    }
    ragdoll_time = (current_time - level.drones.ragdoll_bucket[i].ragdoll_start_time) / 1000;

    if(ragdoll_time < 4 || isDefined(self.is_playing_custom_anim)) {
      new_bucket[new_bucket.size] = level.drones.ragdoll_bucket[i];
      continue;
    }

    if(isDefined(level.drones.ragdoll_bucket[i].targetname) && level.drones.ragdoll_bucket[i].targetname == "drone") {
      level.drones.ragdoll_bucket[i].dontdelete = undefined;
      level.drones.ragdoll_bucket[i] maps\_drones::drone_delete();
      continue;
    }

    level.drones.ragdoll_bucket[i] delete();
  }

  level.drones.ragdoll_bucket = new_bucket;
  return level.drones.ragdoll_bucket.size;
}

drones_pause(script_string_name, paused) {
  for(i = 0; i < level.drones.drone_spawners.size; i++) {
    if(isDefined(level.drones.drone_spawners[i].script_string)) {
      if(level.drones.drone_spawners[i].script_string == script_string_name)
        level.drones.drone_spawners[i].paused = paused;
    }
  }
}

drones_speed_modifier(script_string_name, min_speed, max_speed) {
  for(i = 0; i < level.drones.drone_spawners.size; i++) {
    if(isDefined(level.drones.drone_spawners[i].script_string)) {
      if(level.drones.drone_spawners[i].script_string == script_string_name) {
        level.drones.drone_spawners[i].speed_modifier_min = min_speed;
        level.drones.drone_spawners[i].speed_modifier_max = max_speed;
      }
    }
  }
}

drones_setup_unique_anims(script_string_name, anim_array) {
  for(i = 0; i < level.drones.drone_spawners.size; i++) {
    if(isDefined(level.drones.drone_spawners[i].script_string)) {
      if(level.drones.drone_spawners[i].script_string == script_string_name)
        level.drones.drone_spawners[i].drone_run_cycle_override = anim_array;
    }
  }
}

drones_set_respawn_death_delay(min_delay, max_delay) {
  level.drones.respawn_death_delay_min = min_delay;
  level.drones.respawn_death_delay_max = max_delay;
}

pre_populate_drones(drones, spawn_min, spawn_max, team) {
  level notify("new drone Spawn wave");
  path_size = undefined;

  for(i = 0; i < drones.a_targeted.size; i++) {
    size = calc_drone_path_size(drones.a_targeted[i]);

    if(!isDefined(path_size) || size < path_size)
      path_size = size;
  }

  for(dist = 0; dist < path_size; dist = dist + 320) {
    spawn_size = spawn_min;

    if(spawn_max > spawn_min)
      spawn_size = randomintrange(spawn_min, spawn_max + 1);

    level thread drone_spawngroup(drones, drones.a_targeted, spawn_size, team, dist);
  }
}

calc_drone_path_size(node) {
  size = 0;

  if(isDefined(node.target)) {
    while(true) {
      next_node_struct = getstruct(node.target, "targetname");
      size = size + distance(node.origin, next_node_struct.origin);
      node = getstruct(node.target, "targetname");

      if(!isDefined(node.target)) {
        break;
      }
    }
  }

  return size;
}

drones_start(script_string_name) {
  for(i = 0; i < level.drones.drone_spawners.size; i++) {
    spawner = level.drones.drone_spawners[i];

    if(isDefined(spawner.script_string)) {
      if(spawner.script_string == script_string_name) {
        if(isDefined(spawner.parent_trigger)) {
          spawner.parent_trigger notify("trigger");
          continue;
        }

        if(isDefined(spawner.parent_script_struct))
          spawner.parent_script_struct notify("trigger");
      }
    }
  }
}

drones_delete(script_string_name) {
  for(i = 0; i < level.drones.drone_spawners.size; i++) {
    spawner = level.drones.drone_spawners[i];

    if(isDefined(spawner.script_string)) {
      if(spawner.script_string == script_string_name)
        spawner.delete_spawner = 1;
    }
  }
}

drones_assign_spawner(script_string_name, spawner_guy) {
  for(i = 0; i < level.drones.drone_spawners.size; i++) {
    spawner = level.drones.drone_spawners[i];

    if(isDefined(spawner.script_string)) {
      if(spawner.script_string == script_string_name) {
        if(!isDefined(spawner.unique_guys))
          spawner.unique_guys = [];

        spawner.unique_guys[spawner.unique_guys.size] = spawner_guy;
      }
    }
  }
}

drone_notify(param0, param1, param2) {
  self notify(param0, param1, param2);
  iprintlnbold(param0);
}

drones_death_notify_wrapper(attacker, damagetype) {
  level drone_notify("face", "death", self);
  self drone_notify("death", attacker, damagetype);
}

drone_add_spawner() {
  if(!isDefined(self.classname)) {
    return;
  }
  if(!is_spawner(self)) {
    return;
  }
  if(!isDefined(level.drones))
    level.drones = spawnstruct();

  if(!isDefined(level.drones.axis_classnames))
    level.drones.axis_classnames = [];

  if(!isDefined(level.drones.allies_classnames))
    level.drones.allies_classnames = [];

  side = drone_spawner_side(self.classname);

  if(side == "AXIS") {
    for(i = 0; i < level.drones.axis_classnames.size; i++) {
      if(level.drones.axis_classnames[i] == self.classname)
        return;
    }

    level.drones.axis_classnames[level.drones.axis_classnames.size] = self.classname;
  } else if(side == "ALLIES") {
    for(i = 0; i < level.drones.allies_classnames.size; i++) {
      if(level.drones.allies_classnames[i] == self.classname)
        return;
    }

    level.drones.allies_classnames[level.drones.allies_classnames.size] = self.classname;
  }
}

drone_spawner_side(name) {
  test = tolower(name);

  if(issubstr(test, "_ally_"))
    return "ALLIES";
  else if(issubstr(test, "_a_"))
    return "ALLIES";
  else if(issubstr(test, "_enemy_"))
    return "AXIS";
  else if(issubstr(test, "_e_"))
    return "AXIS";

  return "";
}

drone_get_axis_spawner_class() {
  drone_class = undefined;

  if(isDefined(level.drones.axis_classnames) && level.drones.axis_classnames.size > 0) {
    index = randomint(level.drones.axis_classnames.size);
    drone_class = level.drones.axis_classnames[index];
  }

  return drone_class;
}

drone_get_allies_spawner_class() {
  drone_class = undefined;

  if(isDefined(level.drones.allies_classnames) && level.drones.allies_classnames.size > 0) {
    index = randomint(level.drones.allies_classnames.size);
    drone_class = level.drones.allies_classnames[index];
  }

  return drone_class;
}

spawn_random_axis_drone(override_class) {
  if(isDefined(override_class))
    class = override_class;
  else
    class = drone_get_axis_spawner_class();

  assert(isDefined(class), "CANT FIND AXIS DRONE TO SPAWN");
  self getdronemodel(class);
  self setcurrentweapon(self.weapon);
}

spawn_random_allies_drone(override_class) {
  if(isDefined(override_class))
    class = override_class;
  else
    class = drone_get_allies_spawner_class();

  assert(isDefined(class), "CANT FIND ALLIES DRONE TO SPAWN");
  self getdronemodel(class);
  self.dr_ai_classname = class;
  self setcurrentweapon(self.weapon);
}

drones_get_array(str_team) {
  array = [];

  if(isDefined(level.drones.team)) {
    if(str_team == "axis") {
      if(isDefined(level.drones.team["axis"])) {
        axis_drones = level.drones.team["axis"].array;

        for(i = 0; i < axis_drones.size; i++) {
          if(axis_drones[i].health > 0)
            array[array.size] = axis_drones[i];
        }
      }
    } else if(str_team == "allies") {
      if(isDefined(level.drones.team["allies"])) {
        allies_drones = level.drones.team["allies"].array;

        for(i = 0; i < allies_drones.size; i++) {
          if(allies_drones[i].health > 0)
            array[array.size] = allies_drones[i];
        }
      }
    }
  }

  return array;
}

drones_delete_spawned(str_noteworthy) {
  a_m_drones = getentarray("drone", "targetname");

  foreach(index, m_drone in a_m_drones) {
    if(isDefined(m_drone)) {
      if(!isDefined(str_noteworthy) || isDefined(m_drone.script_noteworthy) && str_noteworthy == m_drone.script_noteworthy) {
        m_drone.dontdelete = undefined;
        m_drone thread drone_delete();
      }
    }

    if(index % 20 == 0)
      wait 0.05;
  }
}

drones_set_cheap_flag(script_string_name, b_use_cheap_flag) {
  for(i = 0; i < level.drones.drone_spawners.size; i++) {
    spawner = level.drones.drone_spawners[i];

    if(isDefined(spawner.script_string) && spawner.script_string == script_string_name)
      spawner.b_use_cheap_flag = b_use_cheap_flag;
  }
}