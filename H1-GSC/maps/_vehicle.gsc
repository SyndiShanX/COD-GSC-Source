/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_vehicle.gsc
********************************/

init_vehicles() {
  if(isdefined(level.disablevehiclescripts) && level.disablevehiclescripts) {
    return;
  }
  maps\_vehicle_code::setup_levelvars();
  level.helicopter_crash_locations = common_scripts\utility::array_combine(level.helicopter_crash_locations, maps\_utility::getstructarray_delete("helicopter_crash_location", "targetname"));
  common_scripts\utility::array_levelthread(getentarray("colmap_vehicle", "targetname"), maps\_utility::deleteent);
  maps\_vehicle_code::setup_vehicle_spawners();
  common_scripts\utility::array_thread(getentarray("truckjunk", "targetname"), maps\_vehicle_code::truckjunk);
  common_scripts\utility::array_thread(getentarray("truckjunk", "script_noteworthy"), maps\_vehicle_code::truckjunk);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("truckjunk", "targetname"), maps\_vehicle_code::truckjunk);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("truckjunk", "script_noteworthy"), maps\_vehicle_code::truckjunk);
  maps\_vehicle_code::setup_ai();
  maps\_vehicle_code::setup_triggers();
  var_0 = maps\_vehicle_code::precache_scripts();
  maps\_vehicle_code::setup_vehicles(var_0);

  if(isdefined(level.optimizedvehicletriggerprocess))
    common_scripts\utility::array_levelthread(level.vehicle_processtriggers, ::trigger_process_set);
  else
    common_scripts\utility::array_levelthread(level.vehicle_processtriggers, maps\_vehicle_code::trigger_process);

  level.vehicle_processtriggers = undefined;
  level.levelhasvehicles = getentarray("script_vehicle", "code_classname").size > 0;
  maps\_utility::add_hint_string("invulerable_frags", & "SCRIPT_INVULERABLE_FRAGS", undefined);
  maps\_utility::add_hint_string("invulerable_bullets", & "SCRIPT_INVULERABLE_BULLETS", undefined);
  common_scripts\utility::create_lock("aircraft_wash_math");

  if(isdefined(level.helicopter_landed_fx_override)) {
    foreach(var_3, var_2 in level.helicopter_landed_fx_override)
    level._heli_landed_fx[loadfx(var_3)] = loadfx(var_2);
  }

  set_crush_vehicle_clips(undefined, "postcrushed", 0);
}

trigger_process_set(var_0) {
  var_0.optimized_process_trigger = 1;
}

vehicle_paths(var_0, var_1, var_2) {
  return maps\_vehicle_code::_vehicle_paths(var_0, var_1, var_2);
}

create_vehicle_from_spawngroup_and_gopath(var_0) {
  var_1 = scripted_spawn(var_0);

  foreach(var_3 in var_1)
  level thread gopath(var_3);

  return var_1;
}

gopath(var_0) {
  return maps\_vehicle_code::_gopath(var_0);
}

scripted_spawn(var_0) {
  return maps\_vehicle_code::_scripted_spawn(var_0);
}

vehicle_spawn(var_0) {
  return maps\_vehicle_code::_vehicle_spawn(var_0);
}

waittill_vehiclespawn(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isspawner(var_1))
    var_1 waittill("spawned", var_1);

  return var_1;
}

waittill_vehiclespawn_noteworthy(var_0) {
  level waittill("new_vehicle_spawned" + var_0, var_1);
  return var_1;
}

kill_fx(var_0, var_1) {
  return maps\_vehicle_code::_kill_fx(var_0, var_1);
}

vehicle_flag_arrived(var_0) {
  if(!isdefined(self.vehicle_flags))
    self.vehicle_flags = [];

  while (!isdefined(self.vehicle_flags[var_0])) {
    self waittill("vehicle_flag_arrived", var_1);

    if(var_0 == var_1)
      return;
  }
}

build_radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level.vehicle_death_radiusdamage))
    level.vehicle_death_radiusdamage = [];

  if(!isdefined(var_4))
    var_4 = 0;

  if(!isdefined(var_0))
    var_0 = (0, 0, 0);

  var_6 = spawnstruct();
  var_6.offset = var_0;
  var_6.range = var_1;
  var_6.maxdamage = var_2;
  var_6.mindamage = var_3;
  var_6.bkillplayer = var_4;
  var_6.delay = var_5;
  level.vehicle_death_radiusdamage[level.vtclassname] = var_6;
}

build_rumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level.vehicle_rumble))
    level.vehicle_rumble = [];

  var_6 = build_quake(var_1, var_2, var_3, var_4, var_5);
  precacherumble(var_0);
  var_6.rumble = var_0;
  level.vehicle_rumble[level.vtclassname] = var_6;
}

build_rumble_override(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(level.vehicle_rumble_override))
    level.vehicle_rumble_override = [];

  var_7 = build_quake(var_2, var_3, var_4, var_5, var_6);
  precacherumble(var_1);
  var_7.rumble = var_1;
  level.vehicle_rumble_override[var_0] = var_7;
}

build_rumble_unique(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = build_quake(var_1, var_2, var_3, var_4, var_5);
  var_6.rumble = var_0;
  self.vehicle_rumble_unique = var_6;
  vehicle_kill_rumble_forever();
  thread maps\_vehicle_code::vehicle_rumble();
}

build_deathquake(var_0, var_1, var_2) {
  var_3 = level.vtclassname;

  if(!isdefined(level.vehicle_death_earthquake))
    level.vehicle_death_earthquake = [];

  level.vehicle_death_earthquake[var_3] = build_quake(var_0, var_1, var_2);
}

build_deathquake_with_classname(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.vehicle_death_earthquake))
    level.vehicle_death_earthquake = [];

  level.vehicle_death_earthquake[var_0] = build_quake(var_1, var_2, var_3);
}

build_quake(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnstruct();
  var_5.scale = var_0;
  var_5.duration = var_1;
  var_5.radius = var_2;

  if(isdefined(var_3))
    var_5.basetime = var_3;

  if(isdefined(var_4))
    var_5.randomaditionaltime = var_4;

  return var_5;
}

build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isdefined(var_5))
    var_5 = 0;

  if(!isdefined(var_3))
    var_3 = 0;

  if(!isdefined(var_4))
    var_4 = 1;

  var_11 = spawnstruct();
  var_11.effect = loadfx(var_0);
  var_11.tag = var_1;
  var_11.sound = var_2;
  var_11.bsoundlooping = var_5;
  var_11.delay = var_4;
  var_11.waitdelay = var_6;
  var_11.stayontag = var_7;
  var_11.notifystring = var_8;
  var_11.beffectlooping = var_3;
  var_11.selfdeletedelay = var_9;
  var_11.remove_deathfx_entity_delay = var_10;
  return var_11;
}

build_deathfx_override(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isdefined(level.script))
    level.script = tolower(getdvar("mapname"));

  level.vttype = var_1;
  level.vtmodel = var_2;
  level.vtoverride = 1;
  level.vtclassname = var_0;

  if(!isdefined(level.vehicle_death_fx))
    level.vehicle_death_fx = [];

  if(!is_overrode(var_0))
    level.vehicle_death_fx[var_0] = [];

  level.vehicle_death_fx_override[var_0] = 1;

  if(!isdefined(level.vehicle_death_fx[var_0]))
    level.vehicle_death_fx[var_0] = [];

  level.vehicle_death_fx[var_0][level.vehicle_death_fx[var_0].size] = build_fx(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  level.vtoverride = undefined;
}

swap_deathfx_effect_only(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.vehicle_death_fx)) {
    return;
  }
  var_4 = 0;

  foreach(var_6 in level.vehicle_death_fx[var_0]) {
    if(isdefined(var_6.effect) && !isdefined(var_1)) {
      continue;
    }
    if(!isdefined(var_6.effect) && isdefined(var_1)) {
      continue;
    }
    if(isdefined(var_6.effect) && isdefined(var_1) && var_6.effect != loadfx(var_1)) {
      continue;
    }
    if(var_6.tag != var_2) {
      continue;
    }
    if(isdefined(var_3))
      var_6.effect = loadfx(var_3);
    else
      var_6.effect = undefined;

    var_4 = 1;
  }

  if(!var_4)
    return;
}

build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level.vtclassname;

  if(is_overrode(var_11)) {
    return;
  }
  if(!isdefined(level.vehicle_death_fx[var_11]))
    level.vehicle_death_fx[var_11] = [];

  level.vehicle_death_fx[var_11][level.vehicle_death_fx[var_11].size] = build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

build_deathfx_generic_script_model(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level.vtclassname;
  level.vtclassname = "script_model";
  build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  level.vtclassname = var_11;
}

build_deathanim(var_0, var_1) {
  override_deathanim(level.vtclassname, var_1, var_0);
}

override_deathanim(var_0, var_1, var_2) {
  if(!isdefined(level.vehicle_deathanim))
    level.vehicle_deathanim = [];

  var_3 = var_0;

  if(isdefined(var_1))
    var_3 = var_3 + "_" + var_1;

  if(!isdefined(var_2)) {
    level.vehicle_deathanim[var_3] = undefined;
    return;
  }

  level.vehicle_deathanim[var_3] = process_deathanim(var_0, var_2);
}

custom_deathanim(var_0) {
  if(!isdefined(var_0)) {
    self.vehicle_deathanim = undefined;
    return;
  }

  self.vehicle_deathanim = process_deathanim(self.classname, var_0);
}

process_deathanim(var_0, var_1) {
  if(!isdefined(var_1.is_directional))
    var_1.is_directional = 0;

  if(var_1.is_directional) {}

  if(!isdefined(var_1.clear_anims))
    var_1.clear_anims = 0;

  if(!isdefined(var_1.clear_anims_time))
    var_1.clear_anims_time = 0;

  if(!isdefined(var_1.alter_velocity))
    var_1.alter_velocity = 0;

  if(!isdefined(var_1.alter_velocity_speed))
    var_1.alter_velocity_speed = 0;

  if(!isdefined(var_1.alter_velocity_accel))
    var_1.alter_velocity_accel = 40;

  if(!isdefined(var_1.alter_velocity_decel))
    var_1.alter_velocity_decel = 20;

  if(!isdefined(var_1.delay_crash))
    var_1.delay_crash = 0;

  if(!isdefined(var_1.delay_crash_time))
    var_1.delay_crash_time = -1;

  if(!isdefined(var_1.delay_crash_force_end))
    var_1.delay_crash_force_end = 0;

  if(!isdefined(var_1.turn_off_engine))
    var_1.turn_off_engine = 1;

  if(!isdefined(var_1.can_damage))
    var_1.can_damage = 0;

  if(!isdefined(var_1.delete_time))
    var_1.delete_time = -1;

  if(!isdefined(var_1.notetrack_notifies))
    var_1.notetrack_notifies = [];

  if(!isdefined(var_1.death_fx_on_self))
    var_1.death_fx_on_self = 1;

  return var_1;
}

validate_deathanim_directional(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  foreach(var_7, var_6 in var_0) {
    switch (var_7) {
      case "front":
        var_1 = 1;
        break;
      case "rear":
        var_2 = 1;
        break;
      case "left":
        var_3 = 1;
        break;
      case "right":
        var_4 = 1;
        break;
    }
  }

  var_8 = var_0.size == 4 && (var_1 && var_2 && var_3 && var_4);
  return var_8;
}

is_overrode(var_0) {
  if(!isdefined(level.vehicle_death_fx_override))
    return 0;

  if(!isdefined(level.vehicle_death_fx_override[var_0]))
    return 0;

  if(isdefined(level.vtoverride))
    return 1;

  return level.vehicle_death_fx_override[var_0];
}

build_rocket_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level.vtclassname;
  level.vtclassname = "rocket_death" + var_11;
  build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  level.vtclassname = var_11;
}

force_kill() {
  return maps\_vehicle_code::_force_kill();
}

godon() {
  self.godmode = 1;
}

godoff() {
  self.godmode = 0;
}

mgoff() {
  return maps\_vehicle_code::_mgoff();
}

mgon() {
  return maps\_vehicle_code::_mgon();
}

isvehicle() {
  return isdefined(self.vehicletype);
}

build_missile_launcher(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isdefined(level.vehicle_missile_launcher))
    level.vehicle_missile_launcher = [];

  var_12 = level.vtclassname;

  if(!isdefined(level.vehicle_missile_launcher[var_12]))
    level.vehicle_missile_launcher[var_12] = [];

  precachemodel(var_2);
  precacheitem(var_3);
  var_13 = spawnstruct();
  var_13.tag = var_1;
  var_13.missile_model = var_2;
  var_13.missile_object = var_3;
  var_13.pre_fire_function = var_4;
  var_13.post_fire_function = var_5;
  var_13.inter_salvo_delay = var_6;
  var_13.homing_delay_min = var_7;
  var_13.homing_delay_max = var_8;
  var_13.salvo_cooldown_min = var_9;
  var_13.salvo_cooldown_max = var_10;
  var_13.missile_abort_if_owner_destroyed = var_11;
  level.vehicle_missile_launcher[var_12][level.vehicle_missile_launcher[var_12].size] = var_13;
}

build_turret(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isdefined(level.vehicle_mgturret))
    level.vehicle_mgturret = [];

  var_9 = level.vtclassname;

  if(!isdefined(level.vehicle_mgturret[var_9]))
    level.vehicle_mgturret[var_9] = [];

  precachemodel(var_2);
  precacheturret(var_0);
  var_10 = spawnstruct();
  var_10.info = var_0;
  var_10.tag = var_1;
  var_10.model = var_2;
  var_10.maxrange = var_3;
  var_10.defaultonmode = var_4;
  var_10.deletedelay = var_5;
  var_10.defaultdroppitch = var_6;
  var_10.defaultdropyaw = var_7;

  if(isdefined(var_8))
    var_10.offset_tag = var_8;

  level.vehicle_mgturret[var_9][level.vehicle_mgturret[var_9].size] = var_10;
}

vehicle_is_crashing() {
  return maps\_vehicle_code::_vehicle_is_crashing();
}

is_godmode() {
  return maps\_vehicle_code::_is_godmode();
}

vehicle_kill_rumble_forever() {
  self notify("kill_rumble_forever");
}

move_truck_junk_here(var_0, var_1) {
  if(!isdefined(self.truckjunk)) {
    return;
  }
  foreach(var_3 in self.truckjunk) {
    if(var_3 == var_0) {
      continue;
    }
    var_3 unlink();

    if(isdefined(var_3.script_ghettotag)) {
      var_3 linkto(var_0, var_3.script_ghettotag, var_3.base_origin, var_3.base_angles);
      continue;
    }

    if(isdefined(var_1)) {
      var_3 linkto(var_0, var_1);
      continue;
    }

    var_3 linkto(var_0);
  }
}

dummy_to_vehicle() {
  if(ishelicopter())
    self.modeldummy.origin = self gettagorigin("tag_ground");
  else {
    self.modeldummy.origin = self.origin;
    self.modeldummy.angles = self.angles;
  }

  self show();
  move_riders_here(self);
  maps\_vehicle_code::move_turrets_here(self);
  thread maps\_vehicle_code::move_lights_here(self);
  maps\_vehicle_code::move_effects_ent_here(self);
  self.modeldummyon = 0;
  self.modeldummy delete();
  self.modeldummy = undefined;

  if(maps\_vehicle_code::hashelicopterdustkickup()) {
    self notify("stop_kicking_up_dust");
    thread maps\_vehicle_code::aircraft_wash_thread();
  }

  return self.modeldummy;
}

move_riders_here(var_0) {
  if(!isdefined(self.riders)) {
    return;
  }
  var_1 = self.riders;

  foreach(var_3 in var_1) {
    if(!isdefined(var_3)) {
      continue;
    }
    var_4 = maps\_vehicle_aianim::anim_pos(self, var_3.vehicle_position);

    if(isdefined(var_4.passenger_2_turret_func)) {
      continue;
    }
    var_3 unlink();
    var_3 linkto(var_0, var_4.sittag, (0, 0, 0), (0, 0, 0));

    if(isai(var_3)) {
      var_3 forceteleport(var_0 gettagorigin(var_4.sittag));
      continue;
    }

    var_3.origin = var_0 gettagorigin(var_4.sittag);
  }
}

get_script_vehicles() {
  var_0 = [];
  var_1 = getentarray("script_vehicle", "code_classname");

  foreach(var_3 in var_1) {
    if(!isspawner(var_3))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

spawn_vehicles_from_targetname(var_0) {
  var_1 = [];
  var_1 = maps\_vehicle_code::spawn_vehicles_from_targetname_newstyle(var_0);
  return var_1;
}

get_vehicles_from_targetname(var_0) {
  var_1 = [];
  var_2 = getentarray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(isdefined(var_4.last_spawned_vehicle))
      var_1[var_1.size] = var_4.last_spawned_vehicle;
  }

  return var_1;
}

spawn_vehicle_from_targetname(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  return var_1[0];
}

get_vehicle_from_targetname(var_0) {
  var_1 = get_vehicles_from_targetname(var_0);
  return var_1[0];
}

vehicle_spawner_has_targetname(var_0, var_1) {
  if(!isdefined(var_0))
    return 0;

  if(!isdefined(var_1))
    return 0;

  var_2 = var_0.vehicle_spawner;

  if(!isdefined(var_2))
    return 0;

  if(!isdefined(var_2.targetname))
    return 0;

  if(var_2.targetname != var_1)
    return 0;

  return 1;
}

spawn_vehicle_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  thread gopath(var_1[0]);
  return var_1[0];
}

spawn_vehicles_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);

  foreach(var_3 in var_1)
  thread gopath(var_3);

  return var_1;
}

aircraft_wash(var_0) {
  thread maps\_vehicle_code::aircraft_wash_thread(var_0);
}

vehicle_wheels_forward() {
  maps\_vehicle_code::wheeldirectionchange(1);
}

vehicle_wheels_backward() {
  maps\_vehicle_code::wheeldirectionchange(0);
}

build_light(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level.vehicle_lights))
    level.vehicle_lights = [];

  if(!isdefined(level.vehicle_lights_group_override))
    level.vehicle_lights_group_override = [];

  if(isdefined(level.vehicle_lights_group_override[var_4]) && !level.vtoverride) {
    return;
  }
  var_6 = spawnstruct();
  var_6.name = var_1;
  var_6.tag = var_2;
  var_6.delay = var_5;
  var_6.effect = loadfx(var_3);
  level.vehicle_lights[var_0][var_1] = var_6;
  maps\_vehicle_code::group_light(var_0, var_1, "all");

  if(isdefined(var_4))
    maps\_vehicle_code::group_light(var_0, var_1, var_4);
}

build_light_override(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level.script))
    level.script = tolower(getdvar("mapname"));

  level.vtclassname = var_0;
  build_light(var_0, var_1, var_2, var_3, var_4, var_5);
  level.vtoverride = 0;
  level.vehicle_lights_group_override[var_4] = 1;
}

build_hideparts(var_0, var_1) {
  if(!isdefined(level.vehicle_hide_list))
    level.vehicle_hide_list = [];

  level.vehicle_hide_list[var_0] = var_1;
}

build_deathmodel(var_0, var_1, var_2, var_3) {
  if(var_0 != level.vtmodel && level.vtmodel != "script_model") {
    return;
  }
  if(!isdefined(var_1))
    var_1 = var_0;

  precachemodel(var_0);
  precachemodel(var_1);

  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_3)) {
    level.vehicle_deathmodel[var_0] = var_1;
    level.vehicle_deathmodel_delay[var_0] = var_2;
  } else {
    level.vehicle_deathmodel[var_3] = var_1;
    level.vehicle_deathmodel_delay[var_3] = var_2;
  }
}

build_shoot_shock(var_0) {
  precacheshellshock(var_0);
  level.vehicle_shoot_shock[level.vtclassname] = var_0;
}

build_idle(var_0) {
  if(!isdefined(level.vehicle_idleanim))
    level.vehicle_idleanim = [];

  if(!isdefined(level.vehicle_idleanim[level.vtmodel]))
    level.vehicle_idleanim[level.vtmodel] = [];

  level.vehicle_idleanim[level.vtmodel][level.vehicle_idleanim[level.vtmodel].size] = var_0;
}

build_drive(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_2))
    var_2 = 10;

  level.vehicle_driveidle[level.vtmodel] = var_0;

  if(isdefined(var_1))
    level.vehicle_driveidle_r[level.vtmodel] = var_1;

  level.vehicle_driveidle_normal_speed[level.vtmodel] = var_2;

  if(isdefined(var_3))
    level.vehicle_driveidle_animrate[level.vtmodel] = var_3;
}

build_template(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.script))
    level.script = tolower(getdvar("mapname"));

  if(isdefined(var_2))
    var_0 = var_2;

  if(var_0 != "script_model")
    precachevehicle(var_0);

  if(!isdefined(level.vehicle_death_fx))
    level.vehicle_death_fx = [];

  if(!isdefined(level.vehicle_deathanim))
    level.vehicle_deathanim = [];

  if(!isdefined(level.vehicle_death_fx[var_3]))
    level.vehicle_death_fx[var_3] = [];

  level.vehicle_team[var_3] = "axis";
  level.vehicle_life[var_3] = 999;
  level.vehicle_hasmainturret[var_1] = 0;
  level.vehicle_mainturrets[var_1] = [];
  level.vtmodel = var_1;
  level.vttype = var_0;
  level.vtclassname = var_3;
}

build_exhaust(var_0) {
  level.vehicle_exhaust[level.vtmodel] = loadfx(var_0);
}

build_treadfx(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_0)) {
    set_vehicle_effect(var_0, var_1, var_2, undefined, var_4);

    if(isdefined(var_3) && var_3) {
      set_vehicle_effect(var_0, var_1, var_2, "_bank", var_4);
      set_vehicle_effect(var_0, var_1, var_2, "_bank_lg", var_4);
    }
  } else {
    var_0 = level.vtclassname;
    maps\_treadfx::main(var_0);
  }
}

build_treadfx_script_model(var_0, var_1, var_2, var_3, var_4) {
  build_treadfx(var_0, var_1 + "_script_model", var_2, var_3, var_4);
}

build_treadfx_override_tags(var_0, var_1) {
  if(!isdefined(level._vehicle_effect_custom_param))
    level._vehicle_effect_custom_param = [];

  if(!isdefined(level._vehicle_effect_custom_param[var_0]))
    level._vehicle_effect_custom_param[var_0] = spawnstruct();

  level._vehicle_effect_custom_param[var_0].tags = var_1;
}

build_treadfx_override_get_surface_function(var_0, var_1) {
  if(!isdefined(level._vehicle_effect_custom_param))
    level._vehicle_effect_custom_param = [];

  if(!isdefined(level._vehicle_effect_custom_param[var_0]))
    level._vehicle_effect_custom_param[var_0] = spawnstruct();

  level._vehicle_effect_custom_param[var_0].get_surface_override_function = var_1;
}

build_all_treadfx(var_0, var_1) {
  var_2 = get_surface_types();

  foreach(var_4 in var_2)
  set_vehicle_effect(var_0, var_4);
}

set_vehicle_effect(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(level._vehicle_effect))
    level._vehicle_effect = [];

  if(!isdefined(level._vehicle_effect_name))
    level._vehicle_effect_name = [];

  if(!isdefined(level._vehicle_sound_effect))
    level._vehicle_sound_effect = [];

  if(isdefined(var_3)) {
    var_1 = var_1 + var_3;
    var_2 = var_2 + var_3;

    if(isdefined(var_4))
      var_4 = var_4 + var_3;
  }

  if(isdefined(var_2))
    update_vehicle_effect(var_0, var_1, var_2, var_4);
  else if(isdefined(level._vehicle_effect[var_0]) && isdefined(level._vehicle_effect[var_0][var_1])) {
    level._vehicle_effect[var_0][var_1] = undefined;
    level._vehicle_sound_effect[var_0][var_1] = var_4;
  }
}

get_surface_types() {
  var_0 = [];
  var_0[var_0.size] = "brick";
  var_0[var_0.size] = "bark";
  var_0[var_0.size] = "carpet";
  var_0[var_0.size] = "cloth";
  var_0[var_0.size] = "concrete";
  var_0[var_0.size] = "dirt";
  var_0[var_0.size] = "flesh";
  var_0[var_0.size] = "foliage";
  var_0[var_0.size] = "glass";
  var_0[var_0.size] = "grass";
  var_0[var_0.size] = "gravel";
  var_0[var_0.size] = "ice";
  var_0[var_0.size] = "metal";
  var_0[var_0.size] = "mud";
  var_0[var_0.size] = "paper";
  var_0[var_0.size] = "plaster";
  var_0[var_0.size] = "rock";
  var_0[var_0.size] = "sand";
  var_0[var_0.size] = "snow";
  var_0[var_0.size] = "water";
  var_0[var_0.size] = "wood";
  var_0[var_0.size] = "asphalt";
  var_0[var_0.size] = "ceramic";
  var_0[var_0.size] = "plastic";
  var_0[var_0.size] = "rubber";
  var_0[var_0.size] = "cushion";
  var_0[var_0.size] = "fruit";
  var_0[var_0.size] = "paintedmetal";
  var_0[var_0.size] = "riotshield";
  var_0[var_0.size] = "slush";
  var_0[var_0.size] = "default";
  return var_0;
}

update_vehicle_effect(var_0, var_1, var_2, var_3) {
  level._vehicle_effect[var_0][var_1] = loadfx(var_2);
  level._vehicle_effect_name[var_0][var_1] = var_2;
  level._vehicle_sound_effect[var_0][var_1] = var_3;
  var_4 = maps\_treadfx::get_surface_types_variation(var_1);

  for (var_5 = 0; var_5 < var_4.size; var_5++) {
    level._vehicle_effect[var_0][var_4[var_5]] = loadfx(var_2);
    level._vehicle_effect_name[var_0][var_4[var_5]] = var_2;
    level._vehicle_sound_effect[var_0][var_4[var_5]] = var_3;
  }
}

add_vehicle_fx_to_bank(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  if(!isdefined(level._vehicle_effect_bank))
    level._vehicle_effect_bank = [];

  var_1 = get_surface_types();
  var_2 = [];

  foreach(var_4 in var_1) {
    level._vehicle_effect_bank[var_0][var_4] = loadfx(var_0);
    var_2 = maps\_treadfx::get_surface_types_variation(var_4);

    foreach(var_6 in var_2)
    level._vehicle_effect_bank[var_0][var_6] = loadfx(var_0);
  }
}

switch_vehicle_fx(var_0, var_1) {
  if(!isdefined(var_0) || !isdefined(var_1)) {
    return;
  }
  if(!isdefined(level._vehicle_effect_bank[var_1])) {
    return;
  }
  var_2 = get_surface_types();
  var_3 = 0;
  var_4 = 0;
  var_5 = "";
  var_6 = [];

  foreach(var_8 in var_2) {
    var_4 = level._vehicle_effect[var_0][var_8];
    var_5 = level._vehicle_effect_name[var_0][var_8];
    var_3 = level._vehicle_effect_bank[var_1][var_8];
    override_vehicle_effect(var_0, var_8, var_5, var_4, var_3, var_1);
    var_6 = maps\_treadfx::get_surface_types_variation(var_8);

    foreach(var_10 in var_6)
    override_vehicle_effect(var_0, var_10, var_5, var_4, var_3, var_1);
  }
}

override_vehicle_effect(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._vehicle_effect[var_0][var_1] = var_4;
  level._vehicle_effect_name[var_0][var_1] = var_5;
  level._vehicle_effect_bank[var_2][var_1] = var_3;
}

build_team(var_0) {
  level.vehicle_team[level.vtclassname] = var_0;
}

build_mainturret(var_0, var_1, var_2, var_3) {
  level.vehicle_hasmainturret[level.vtmodel] = 1;

  if(isdefined(var_0))
    level.vehicle_mainturrets[level.vtmodel][var_0] = 1;

  if(isdefined(var_1))
    level.vehicle_mainturrets[level.vtmodel][var_1] = 1;

  if(isdefined(var_2))
    level.vehicle_mainturrets[level.vtmodel][var_2] = 1;

  if(isdefined(var_3))
    level.vehicle_mainturrets[level.vtmodel][var_3] = 1;
}

build_bulletshield(var_0) {
  level.vehicle_bulletshield[level.vtclassname] = var_0;
}

build_grenadeshield(var_0) {
  level.vehicle_grenadeshield[level.vtclassname] = var_0;
}

build_aianims(var_0, var_1) {
  var_2 = level.vtclassname;
  level.vehicle_aianims[var_2] = [[var_0]]();

  if(isdefined(var_1))
    level.vehicle_aianims[var_2] = [
      [var_1]
    ](level.vehicle_aianims[var_2]);
}

build_aianims_with_classname(var_0, var_1, var_2) {
  level.vehicle_aianims[var_0] = [[var_1]]();

  if(isdefined(var_2))
    level.vehicle_aianims[var_0] = [
      [var_2]
    ](level.vehicle_aianims[var_0]);
}

build_frontarmor(var_0) {
  level.vehicle_frontarmor[level.vtclassname] = var_0;
}

build_attach_models(var_0) {
  level.vehicle_attachedmodels[level.vtclassname] = [[var_0]]();
}

build_unload_groups(var_0) {
  level.vehicle_unloadgroups[level.vtclassname] = [[var_0]]();
}

build_life(var_0, var_1, var_2) {
  var_3 = level.vtclassname;
  level.vehicle_life[var_3] = var_0;
  level.vehicle_life_range_low[var_3] = var_1;
  level.vehicle_life_range_high[var_3] = var_2;
}

build_deckdust(var_0) {
  level.vehicle_deckdust[level.vtmodel] = loadfx(var_0);
}

build_destructible(var_0, var_1) {
  if(isdefined(level.vehicle_csv_export)) {
    return;
  }
  if(var_0 != level.vtmodel) {
    return;
  }
  var_2 = spawnstruct();
  var_2.model = var_0;
  var_2 maps\_utility::precache_destructible(var_1);
  level.destructible_model[level.vtmodel] = var_1;
}

build_localinit(var_0) {
  level.vehicleinitthread[level.vttype][level.vtclassname] = var_0;
}

is_dummy() {
  return self.modeldummyon;
}

vehicle_load_ai(var_0, var_1, var_2) {
  maps\_vehicle_aianim::load_ai(var_0, undefined, var_2);
}

vehicle_load_ai_single(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  maps\_vehicle_aianim::load_ai(var_3, var_1, var_2);
}

build_death_badplace(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(level.vehicle_death_badplace))
    level.vehicle_death_badplace = [];

  var_6 = spawnstruct();
  var_6.delay = var_0;
  var_6.duration = var_1;
  var_6.height = var_2;
  var_6.radius = var_3;
  var_6.team1 = var_4;
  var_6.team2 = var_5;
  level.vehicle_death_badplace[level.vtclassname] = var_6;
}

mount_snowmobile(var_0, var_1) {
  return maps\_vehicle_code::_mount_snowmobile(var_0, var_1);
}

spawn_vehicle_and_gopath() {
  var_0 = maps\_utility::spawn_vehicle();

  if(isdefined(self.script_speed)) {
    if(!ishelicopter())
      var_0 vehphys_setspeed(self.script_speed);
  }

  var_0 thread gopath(var_0);
  return var_0;
}

vehicle_get_riders_by_group(var_0) {
  var_1 = [];
  var_2 = self.classname;

  if(!isdefined(level.vehicle_unloadgroups[var_2]))
    return var_1;

  var_3 = level.vehicle_unloadgroups[var_2];

  if(!isdefined(var_0))
    return var_1;

  foreach(var_5 in self.riders) {
    foreach(var_7 in var_3[var_0]) {
      if(var_5.vehicle_position == var_7)
        var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

vehicle_ai_event(var_0) {
  return maps\_vehicle_aianim::animate_guys(var_0);
}

vehicle_unload(var_0) {
  return maps\_vehicle_code::_vehicle_unload(var_0);
}

vehicle_turret_scan_on() {
  self endon("death");
  self endon("stop_scanning_turret");
  var_0 = randomint(2);

  while (isdefined(self)) {
    if(common_scripts\utility::cointoss()) {
      maps\_vehicle_code::vehicle_aim_turret_at_angle(0);
      wait(randomfloatrange(2, 10));
    }

    if(var_0 == 0) {
      var_1 = randomintrange(10, 30);
      var_0 = 1;
    } else {
      var_1 = randomintrange(-30, -10);
      var_0 = 0;
    }

    maps\_vehicle_code::vehicle_aim_turret_at_angle(var_1);
    wait(randomfloatrange(2, 10));
  }
}

vehicle_turret_scan_off() {
  self notify("stop_scanning_turret");
}

vehicle_get_path_array() {
  self endon("death");
  var_0 = [];
  var_1 = self.attachedpath;

  if(!isdefined(self.attachedpath))
    return var_0;

  var_2 = var_1;
  var_2.counted = 0;

  while (isdefined(var_2)) {
    if(isdefined(var_2.counted) && var_2.counted == 1) {
      break;
    }

    var_0 = common_scripts\utility::array_add(var_0, var_2);
    var_2.counted = 1;

    if(!isdefined(var_2.target)) {
      break;
    }

    if(!ishelicopter()) {
      var_2 = getvehiclenode(var_2.target, "targetname");
      continue;
    }

    var_2 = maps\_utility::getent_or_struct(var_2.target, "targetname");
  }

  return var_0;
}

vehicle_lights_on(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = "all";

  maps\_vehicle_code::lights_on(var_0, var_1);
}

vehicle_lights_off(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = "all";

  maps\_vehicle_code::lights_off(var_0, var_1);
}

vehicle_single_light_on(var_0) {
  if(!isdefined(self) || !isdefined(self.classname) || !isdefined(var_0)) {
    return;
  }
  if(!isdefined(level.vehicle_lights[self.classname])) {
    return;
  }
  var_1 = level.vehicle_lights[self.classname][var_0];

  if(!isdefined(var_1)) {
    return;
  }
  if(isdefined(var_1.delay))
    var_2 = var_1.delay;
  else
    var_2 = 0;

  self endon("death");
  childthread common_scripts\utility::noself_delaycall_proc(::playfxontag, var_2, var_1.effect, self, var_1.tag);
  self.lights[var_0] = 1;
}

vehicle_single_light_off(var_0) {
  if(!isdefined(self.lights)) {
    return;
  }
  if(!isdefined(self.lights[var_0])) {
    return;
  }
  var_1 = level.vehicle_lights[self.classname][var_0];

  if(!isdefined(var_1)) {
    return;
  }
  stopfxontag(var_1.effect, self, var_1.tag);
  self.lights[var_0] = undefined;
}

vehicle_switch_paths(var_0, var_1) {
  self setswitchnode(var_0, var_1);
  self.attachedpath = var_1;
  thread vehicle_paths();
}

vehicle_stop_named(var_0, var_1, var_2) {
  return maps\_vehicle_code::_vehicle_stop_named(var_0, var_1, var_2);
}

vehicle_resume_named(var_0) {
  return maps\_vehicle_code::_vehicle_resume_named(var_0);
}

build_is_helicopter(var_0) {
  if(!isdefined(level.helicopter_list))
    level.helicopter_list = [];

  if(!isdefined(var_0))
    var_0 = level.vttype;

  level.helicopter_list[var_0] = 1;
}

build_is_airplane(var_0) {
  if(!isdefined(level.airplane_list))
    level.airplane_list = [];

  if(!isdefined(var_0))
    var_0 = level.vttype;

  level.airplane_list[var_0] = 1;
}

build_single_tread(var_0) {
  if(!isdefined(level.vehicle_single_tread_list))
    level.vehicle_single_tread_list = [];

  if(!isdefined(var_0))
    var_0 = level.vttype;

  level.vehicle_single_tread_list[var_0] = 1;
}

vehicle_set_health(var_0) {
  if(isdefined(self.healthbuffer))
    self.health = var_0 + self.healthbuffer;
  else
    self.health = var_0;

  self.currenthealth = self.health;
}

build_rider_death_func(var_0) {
  if(!isdefined(level.vehicle_rider_death_func))
    level.vehicle_rider_death_func = [];

  level.vehicle_rider_death_func[level.vtclassname] = var_0;
}

ishelicopter() {
  return maps\_vehicle_code::_ishelicopter();
}

isairplane() {
  return maps\_vehicle_code::_isairplane();
}

get_dummy() {
  return maps\_vehicle_code::_get_dummy();
}

#using_animtree("vehicles");

vehicle_to_dummy(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 0;

  if(!var_1) {
    self.modeldummy = spawn("script_model", self.origin);
    self.modeldummy setmodel(self.model);
    self.modeldummy.origin = self.origin;
    self.modeldummy.angles = self.angles;
    self.modeldummy useanimtree(#animtree);
  } else {
    self.modeldummy show();
    self.modeldummy unlink();
    self.modeldummy.origin = self.origin;
    self.modeldummy.angles = self.angles;
  }

  self transfermarkstonewscriptmodel(self.modeldummy);
  self hide();
  thread maps\_vehicle_code::model_dummy_death();
  move_riders_here(self.modeldummy);
  maps\_vehicle_code::move_turrets_here(self.modeldummy);
  move_truck_junk_here(self.modeldummy, var_0);
  thread maps\_vehicle_code::move_lights_here(self.modeldummy);
  maps\_vehicle_code::move_effects_ent_here(self.modeldummy, var_0);
  maps\_vehicle_code::copy_attachments(self.modeldummy);

  if(isdefined(self.customvehicletodummytransferfunc))
    self thread[[self.customvehicletodummytransferfunc]](self.modeldummy, var_0);

  self.modeldummyon = 1;

  if(maps\_vehicle_code::hashelicopterdustkickup()) {
    self notify("stop_kicking_up_dust");
    thread maps\_vehicle_code::aircraft_wash_thread(self.modeldummy);
  }

  return self.modeldummy;
}

build_death_jolt_delay(var_0) {
  if(!isdefined(level.vehicle_death_jolt))
    level.vehicle_death_jolt = [];

  var_1 = spawnstruct();
  var_1.delay = var_0;
  level.vehicle_death_jolt[level.vtclassname] = var_1;
}

enable_global_vehicle_spawn_functions() {
  level.vehicle_spawn_functions_enable = 1;
}

tank_crush(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = vehicle_to_dummy();
  var_9 = 7;
  var_10 = 5;
  var_11 = 5;
  self vehicle_setspeed(var_9, var_10, var_11);
  var_12 = getanimlength(var_2);
  var_13 = var_12 / 3;
  var_14 = var_12 / 3;
  var_15 = var_0.origin;
  var_16 = var_0.angles;
  var_17 = anglestoforward(var_16);
  var_18 = anglestoup(var_16);
  var_19 = anglestoright(var_16);
  var_20 = getstartorigin(var_15, var_16, var_2);
  var_21 = getstartangles(var_15, var_16, var_2);
  var_22 = anglestoforward(var_21);
  var_23 = anglestoup(var_21);
  var_24 = anglestoright(var_21);
  var_25 = anglestoforward(var_8.angles);
  var_26 = anglestoup(var_8.angles);
  var_27 = anglestoright(var_8.angles);
  var_28 = var_15 - var_20;
  var_29 = vectordot(var_28, var_22);
  var_30 = vectordot(var_28, var_23);
  var_31 = vectordot(var_28, var_24);
  var_32 = spawn("script_origin", var_8.origin);
  var_32.origin = var_32.origin + maps\_utility::vector_multiply(var_25, var_29);
  var_32.origin = var_32.origin + maps\_utility::vector_multiply(var_26, var_30);
  var_32.origin = var_32.origin + maps\_utility::vector_multiply(var_27, var_31);
  var_28 = anglestoforward(var_16);
  var_29 = vectordot(var_28, var_22);
  var_30 = vectordot(var_28, var_23);
  var_31 = vectordot(var_28, var_24);
  var_33 = maps\_utility::vector_multiply(var_25, var_29);
  var_33 = var_33 + maps\_utility::vector_multiply(var_26, var_30);
  var_33 = var_33 + maps\_utility::vector_multiply(var_27, var_31);
  var_32.angles = vectortoangles(var_33);

  if(isdefined(var_5))
    level thread common_scripts\utility::play_sound_in_space(var_5, var_15);

  var_8 linkto(var_32);
  var_0 useanimtree(var_4);
  var_8 useanimtree(var_4);
  var_34 = tank_crush_fx_validation(level._vehicle_effect["tankcrush"]["window_med_left"], level._vehicle_effect["tankcrush"]["window_med"]);
  var_35 = tank_crush_fx_validation(level._vehicle_effect["tankcrush"]["window_med_right"], level._vehicle_effect["tankcrush"]["window_med"]);
  var_36 = tank_crush_fx_validation(level._vehicle_effect["tankcrush"]["window_large_back"], level._vehicle_effect["tankcrush"]["window_large"]);
  var_37 = tank_crush_fx_validation(level._vehicle_effect["tankcrush"]["window_large_front"], level._vehicle_effect["tankcrush"]["window_large"]);

  if(tank_crush_has_notetracks(var_3)) {
    var_0 thread notetrack_tank_crush_fx_on_tag("tag_window_left_glass_fx", var_34, "veh_glass_break_small", "left_glass_fx", var_3);
    var_0 thread notetrack_tank_crush_fx_on_tag("tag_window_right_glass_fx", var_35, "veh_glass_break_small", "right_glass_fx", var_3);
    var_0 thread notetrack_tank_crush_fx_on_tag("tag_windshield_back_glass_fx", var_36, "veh_glass_break_large", "back_glass_fx", var_3);
    var_0 thread notetrack_tank_crush_fx_on_tag("tag_windshield_front_glass_fx", var_37, "veh_glass_break_large", "front_glass_fx", var_3);
  } else {
    var_0 thread tank_crush_fx_on_tag("tag_window_left_glass_fx", var_34, "veh_glass_break_small", 0.2);
    var_0 thread tank_crush_fx_on_tag("tag_window_right_glass_fx", var_35, "veh_glass_break_small", 0.4);
    var_0 thread tank_crush_fx_on_tag("tag_windshield_back_glass_fx", var_36, "veh_glass_break_large", 0.7);
    var_0 thread tank_crush_fx_on_tag("tag_windshield_front_glass_fx", var_37, "veh_glass_break_large", 1.5);
  }

  var_0 animscripted("tank_crush_anim", var_15, var_16, var_3);
  var_8 animscripted("tank_crush_anim", var_32.origin, var_32.angles, var_2);

  if(isdefined(var_7))
    thread[[var_7]](var_0);

  var_32 moveto(var_15, var_13, var_13 / 2, var_13 / 2);
  var_32 rotateto(var_16, var_13, var_13 / 2, var_13 / 2);
  wait(var_13);
  var_12 = var_12 - var_13;
  var_12 = var_12 - var_14;
  set_crush_vehicle_clips(var_0, "precrushed", 0);
  set_crush_vehicle_clips(var_0, "postcrushed", 1);
  wait(var_12);
  var_38 = spawn("script_model", var_20);
  var_38.angles = var_21;
  var_39 = var_38 localtoworldcoords(getmovedelta(var_2, 0, 1));
  var_40 = var_21 + (0, getangledelta(var_2, 0, 1), 0);
  var_38 delete();
  var_41 = anglestoforward(var_40);
  var_42 = anglestoup(var_40);
  var_43 = anglestoright(var_40);
  var_44 = self getattachpos(var_1);
  var_25 = anglestoforward(var_44[1]);
  var_26 = anglestoup(var_44[1]);
  var_27 = anglestoright(var_44[1]);
  var_28 = var_15 - var_39;
  var_29 = vectordot(var_28, var_41);
  var_30 = vectordot(var_28, var_42);
  var_31 = vectordot(var_28, var_43);
  var_32.final_origin = var_44[0];
  var_32.final_origin = var_32.final_origin + maps\_utility::vector_multiply(var_25, var_29);
  var_32.final_origin = var_32.final_origin + maps\_utility::vector_multiply(var_26, var_30);
  var_32.final_origin = var_32.final_origin + maps\_utility::vector_multiply(var_27, var_31);
  var_28 = anglestoforward(var_16);
  var_29 = vectordot(var_28, var_41);
  var_30 = vectordot(var_28, var_42);
  var_31 = vectordot(var_28, var_43);
  var_33 = maps\_utility::vector_multiply(var_25, var_29);
  var_33 = var_33 + maps\_utility::vector_multiply(var_26, var_30);
  var_33 = var_33 + maps\_utility::vector_multiply(var_27, var_31);
  var_32.final_angles = vectortoangles(var_33);

  if(getdvar("debug_tankcrush") == "1") {
    thread maps\_utility::draw_line_from_ent_for_time(level.player, self.origin, 1, 0, 0, var_12 / 2);
    thread maps\_utility::draw_line_from_ent_for_time(level.player, var_39, 0, 1, 0, var_12 / 2);
    thread maps\_utility::draw_line_from_ent_to_ent_for_time(level.player, var_32, 0, 0, 1, var_12 / 2);
  }

  if(isdefined(var_6) && var_6) {
    var_45 = 1;
    var_46 = distance(self.origin, var_1.origin);
    var_47 = var_46 / var_14;
    self vehicle_setspeed(var_47, var_47 * 0.05);
  }

  var_32 moveto(var_32.final_origin, var_14, var_14 / 2, var_14 / 2);
  var_32 rotateto(var_32.final_angles, var_14, var_14 / 2, var_14 / 2);
  wait(var_14);
  self attachpath(var_1);

  if(isdefined(var_6) && var_6)
    self vehicle_setspeed(var_9, var_10, var_11);

  dummy_to_vehicle();
}

set_crush_vehicle_clips(var_0, var_1, var_2) {
  if(!isdefined(var_1)) {
    return;
  }
  if(var_1 != "precrushed" && var_1 != "postcrushed") {
    return;
  }
  if(!isdefined(var_2))
    var_2 = 1;

  var_3 = [];

  if(isdefined(var_0) && isdefined(var_0.targetname))
    var_3 = getentarray(var_0.targetname + "_" + var_1 + "_clip", "targetname");
  else {
    var_4 = getentarray("script_brushmodel", "classname");

    foreach(var_6 in var_4) {
      if(isdefined(var_6.targetname) && issubstr(var_6.targetname, var_1))
        var_3 = common_scripts\utility::array_add(var_3, var_6);
    }
  }

  foreach(var_9 in var_3) {
    if(var_2) {
      var_9 solid();
      continue;
    }

    var_9 notsolid();
  }
}

tank_crush_fx_on_tag(var_0, var_1, var_2, var_3) {
  if(isdefined(var_3))
    wait(var_3);

  playfxontag(var_1, self, var_0);

  if(isdefined(var_2))
    thread maps\_utility::play_sound_on_tag(var_2, var_0);
}

notetrack_tank_crush_fx_on_tag(var_0, var_1, var_2, var_3, var_4) {
  if(!animhasnotetrack(var_4, var_3)) {
    return;
  }
  var_5 = getanimlength(var_4);
  var_6 = getnotetracktimes(var_4, var_3);
  var_5 = var_5 * var_6[0];
  wait(var_5);
  playfxontag(var_1, self, var_0);

  if(isdefined(var_2))
    thread maps\_utility::play_sound_on_tag(var_2, var_0);
}

tank_crush_fx_validation(var_0, var_1) {
  if(isdefined(var_0))
    return var_0;

  if(isdefined(var_1))
    return var_1;
}

tank_crush_has_notetracks(var_0) {
  if(animhasnotetrack(var_0, "left_glass_fx"))
    return 1;

  if(animhasnotetrack(var_0, "right_glass_fx"))
    return 1;

  if(animhasnotetrack(var_0, "back_glass_fx"))
    return 1;

  if(animhasnotetrack(var_0, "front_glass_fx"))
    return 1;

  return 0;
}

heli_squashes_stuff(var_0) {
  self endon("death");
  level endon(var_0);

  for (;;) {
    self waittill("trigger", var_1);

    if(isalive(var_1)) {
      if(var_1.team == "allies" && var_1 != level.player) {
        continue;
      }
      var_1 dodamage(var_1.health + 150, (0, 0, 0));
    }
  }
}

show_rigs(var_0) {
  wait 0.01;
  thread maps\_vehicle_aianim::getout_rigspawn(self, var_0);

  if(!self.riders.size) {
    return;
  }
  for (var_1 = 0; var_1 < self.riders.size; var_1++)
    thread maps\_vehicle_aianim::getout_rigspawn(self, self.riders[var_1].vehicle_position);
}

build_exploder_event_with_targetname(var_0, var_1, var_2, var_3) {
  thread build_exploder_event_with_targetname_internal(var_0, var_1, var_2, var_3);
}

build_exploder_event_with_targetname_internal(var_0, var_1, var_2, var_3) {
  var_4 = maps\_utility::getvehiclespawner(var_0);
  var_4 waittill("spawned", var_5);
  build_exploder_event_internal(var_5, var_1, var_2, var_3);
}

build_exploder_event(var_0, var_1, var_2, var_3) {
  thread build_exploder_event_internal(var_0, var_1, var_2, var_3);
}

build_exploder_event_internal(var_0, var_1, var_2, var_3) {
  var_0 waittill(var_1);

  if(isdefined(var_3))
    wait(var_3);

  common_scripts\_exploder::exploder(var_2);
}

volume_up(var_0) {
  self notify("new_volume_command");
  self endon("new_volume_command");
  self endon("death");
  self scalevolume(0, 0);

  if(isdefined(self.snd_disable_vehicle_system))
    self.snd_disable_vehicle_system = 0;
  else
    self vehicle_turnengineon();

  self scalevolume(1.0, var_0);
  wait(var_0);
}

volume_down(var_0) {
  self notify("new_volume_command");
  self endon("new_volume_command");
  self endon("death");
  self scalevolume(0.0, var_0);
  wait(var_0);

  if(isdefined(self.snd_disable_vehicle_system))
    self.snd_disable_vehicle_system = 1;
  else
    self vehicle_turnengineoff();
}

lerp_enginesound(var_0, var_1, var_2) {}