/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle.gsc
*****************************************************/

init_vehicles() {
  if(isDefined(level.disablevehiclescripts) && level.disablevehiclescripts) {
    return;
  }
  maps\_vehicle_code::setup_levelvars();
  level.helicopter_crash_locations = common_scripts\utility::array_combine(level.helicopter_crash_locations, maps\_utility::getstructarray_delete("helicopter_crash_location", "targetname"));
  maps\_vehicle_code::setup_vehicle_spawners();
  common_scripts\utility::array_thread(getEntArray("truckjunk", "targetname"), maps\_vehicle_code::truckjunk);
  common_scripts\utility::array_thread(getEntArray("truckjunk", "script_noteworthy"), maps\_vehicle_code::truckjunk);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("truckjunk", "targetname"), maps\_vehicle_code::truckjunk);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("truckjunk", "script_noteworthy"), maps\_vehicle_code::truckjunk);
  maps\_vehicle_code::setup_ai();
  maps\_vehicle_code::setup_triggers();
  var_0 = maps\_vehicle_code::precache_scripts();
  maps\_vehicle_code::setup_vehicles(var_0);

  if(isDefined(level.optimizedvehicletriggerprocess)) {
    common_scripts\utility::array_levelthread(level.vehicle_processtriggers, ::trigger_process_set);
  } else {
    common_scripts\utility::array_levelthread(level.vehicle_processtriggers, maps\_vehicle_code::trigger_process);
  }

  level.vehicle_processtriggers = undefined;
  level.levelhasvehicles = getEntArray("script_vehicle", "code_classname").size > 0;
  maps\_utility::add_hint_string("invulerable_frags", &"SCRIPT_INVULERABLE_FRAGS", undefined);
  maps\_utility::add_hint_string("invulerable_bullets", &"SCRIPT_INVULERABLE_BULLETS", undefined);
  common_scripts\utility::create_lock("aircraft_wash_math");
}

trigger_process_set(var_0) {
  var_0.optimized_process_trigger = 1;
}

vehicle_paths(var_0, var_1, var_2) {
  return maps\_vehicle_code::_vehicle_paths(var_0, var_1, var_2);
}

create_vehicle_from_spawngroup_and_gopath(var_0) {
  var_1 = scripted_spawn(var_0);

  foreach(var_3 in var_1) {
    level thread gopath(var_3);
  }

  return var_1;
}

gopath(var_0) {
  return maps\_vehicle_code::_gopath(var_0);
}

scripted_spawn(var_0) {
  var_1 = maps\_vehicle_code::_getvehiclespawnerarray_by_spawngroup(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2[var_2.size] = vehicle_spawn(var_4);
  }

  return var_2;
}

vehicle_spawn(var_0) {
  return maps\_vehicle_code::_vehicle_spawn(var_0);
}

kill_fx(var_0, var_1) {
  return maps\_vehicle_code::_kill_fx(var_0, var_1);
}

build_radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle_death_radiusdamage)) {
    level.vehicle_death_radiusdamage = [];
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_6 = spawnStruct();
  var_6.offset = var_0;
  var_6.range = var_1;
  var_6.maxdamage = var_2;
  var_6.mindamage = var_3;
  var_6.bkillplayer = var_4;
  var_6.delay = var_5;
  level.vehicle_death_radiusdamage[level.vtclassname] = var_6;
}

build_rumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle_rumble)) {
    level.vehicle_rumble = [];
  }

  var_6 = build_quake(var_1, var_2, var_3, var_4, var_5);
  precacherumble(var_0);
  var_6.rumble = var_0;
  level.vehicle_rumble[level.vtclassname] = var_6;
}

build_rumble_override(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.vehicle_rumble_override)) {
    level.vehicle_rumble_override = [];
  }

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

  if(!isDefined(level.vehicle_death_earthquake)) {
    level.vehicle_death_earthquake = [];
  }

  level.vehicle_death_earthquake[var_3] = build_quake(var_0, var_1, var_2);
}

build_quake(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.scale = var_0;
  var_5.duration = var_1;
  var_5.radius = var_2;

  if(isDefined(var_3)) {
    var_5.basetime = var_3;
  }

  if(isDefined(var_4)) {
    var_5.randomaditionaltime = var_4;
  }

  return var_5;
}

build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_11 = spawnStruct();
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
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));
  }

  level.vttype = var_1;
  level.vtmodel = var_2;
  level.vtoverride = 1;
  level.vtclassname = var_0;

  if(!isDefined(level.vehicle_death_fx)) {
    level.vehicle_death_fx = [];
  }

  if(!is_overrode(var_0)) {
    level.vehicle_death_fx[var_0] = [];
  }

  level.vehicle_death_fx_override[var_0] = 1;

  if(!isDefined(level.vehicle_death_fx[var_0])) {
    level.vehicle_death_fx[var_0] = [];
  }

  level.vehicle_death_fx[var_0][level.vehicle_death_fx[var_0].size] = build_fx(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  level.vtoverride = undefined;
}

build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level.vtclassname;

  if(is_overrode(var_11)) {
    return;
  }
  if(!isDefined(level.vehicle_death_fx[var_11])) {
    level.vehicle_death_fx[var_11] = [];
  }

  level.vehicle_death_fx[var_11][level.vehicle_death_fx[var_11].size] = build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

build_deathanim(var_0) {
  var_1 = level.vtclassname;

  if(!isDefined(level.vehicle_death_anim[var_1])) {
    level.vehicle_death_anim[var_1] = [];
  }

  level.vehicle_death_anim[var_1] = var_0;
}

is_overrode(var_0) {
  if(!isDefined(level.vehicle_death_fx_override)) {
    return 0;
  }

  if(!isDefined(level.vehicle_death_fx_override[var_0])) {
    return 0;
  }

  if(isDefined(level.vtoverride)) {
    return 1;
  }

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
  return isDefined(self.vehicletype);
}

build_turret(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.vehicle_mgturret)) {
    level.vehicle_mgturret = [];
  }

  var_9 = level.vtclassname;

  if(!isDefined(level.vehicle_mgturret[var_9])) {
    level.vehicle_mgturret[var_9] = [];
  }

  precachemodel(var_2);
  precacheturret(var_0);
  var_10 = spawnStruct();
  var_10.info = var_0;
  var_10.tag = var_1;
  var_10.model = var_2;
  var_10.maxrange = var_3;
  var_10.defaultonmode = var_4;
  var_10.deletedelay = var_5;
  var_10.defaultdroppitch = var_6;
  var_10.defaultdropyaw = var_7;

  if(isDefined(var_8)) {
    var_10.offset_tag = var_8;
  }

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

move_truck_junk_here(var_0) {
  if(!isDefined(self.truckjunk)) {
    return;
  }
  foreach(var_2 in self.truckjunk) {
    if(var_2 == var_0) {
      continue;
    }
    var_2 unlink();

    if(isDefined(var_2.script_ghettotag)) {
      var_2 linkto(var_0, var_2.script_ghettotag, var_2.base_origin, var_2.base_angles);
      continue;
    }

    var_2 linkto(var_0);
  }
}

dummy_to_vehicle() {
  if(ishelicopter()) {
    self.modeldummy.origin = self gettagorigin("tag_ground");
  } else {
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
  if(!isDefined(self.riders)) {
    return;
  }
  var_1 = self.riders;

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = maps\_vehicle_aianim::anim_pos(self, var_3.vehicle_position);

    if(isDefined(var_4.passenger_2_turret_func)) {
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

spawn_vehicles_from_targetname(var_0) {
  var_1 = [];
  var_1 = maps\_vehicle_code::spawn_vehicles_from_targetname_newstyle(var_0);
  return var_1;
}

spawn_vehicle_from_targetname(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  return var_1[0];
}

spawn_vehicle_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);
  thread gopath(var_1[0]);
  return var_1[0];
}

spawn_vehicles_from_targetname_and_drive(var_0) {
  var_1 = spawn_vehicles_from_targetname(var_0);

  foreach(var_3 in var_1) {
    thread gopath(var_3);
  }

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
  if(!isDefined(level.vehicle_lights)) {
    level.vehicle_lights = [];
  }

  if(!isDefined(level.vehicle_lights_group_override)) {
    level.vehicle_lights_group_override = [];
  }

  if(isDefined(level.vehicle_lights_group_override[var_4]) && !level.vtoverride) {
    return;
  }
  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6.tag = var_2;
  var_6.delay = var_5;
  var_6.effect = loadfx(var_3);
  level.vehicle_lights[var_0][var_1] = var_6;
  maps\_vehicle_code::group_light(var_0, var_1, "all");

  if(isDefined(var_4)) {
    maps\_vehicle_code::group_light(var_0, var_1, var_4);
  }
}

build_light_override(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));
  }

  level.vtclassname = var_0;
  build_light(var_0, var_1, var_2, var_3, var_4, var_5);
  level.vtoverride = 0;
  level.vehicle_lights_group_override[var_4] = 1;
}

build_hideparts(var_0, var_1) {
  if(!isDefined(level.vehicle_hide_list)) {
    level.vehicle_hide_list = [];
  }

  level.vehicle_hide_list[var_0] = var_1;
}

build_deathmodel(var_0, var_1, var_2, var_3) {
  if(var_0 != level.vtmodel) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  precachemodel(var_0);
  precachemodel(var_1);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    level.vehicle_deathmodel[var_0] = var_1;
    level.vehicle_deathmodel_delay[var_0] = var_2;
  } else {
    level.vehicle_deathmodel[var_3] = var_1;
    level.vehicle_deathmodel_delay[var_3] = var_2;
  }
}

build_shoot_shock(var_0) {
  precacheshader("black");
  precacheshellshock(var_0);
  level.vehicle_shoot_shock[level.vtclassname] = var_0;
}

build_idle(var_0) {
  if(!isDefined(level.vehicle_idleanim)) {
    level.vehicle_idleanim = [];
  }

  if(!isDefined(level.vehicle_idleanim[level.vtmodel])) {
    level.vehicle_idleanim[level.vtmodel] = [];
  }

  level.vehicle_idleanim[level.vtmodel][level.vehicle_idleanim[level.vtmodel].size] = var_0;
}

build_drive(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 10;
  }

  level.vehicle_driveidle[level.vtmodel] = var_0;

  if(isDefined(var_1)) {
    level.vehicle_driveidle_r[level.vtmodel] = var_1;
  }

  level.vehicle_driveidle_normal_speed[level.vtmodel] = var_2;

  if(isDefined(var_3)) {
    level.vehicle_driveidle_animrate[level.vtmodel] = var_3;
  }
}

build_template(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));
  }

  if(isDefined(var_2)) {
    var_0 = var_2;
  }

  precachevehicle(var_0);

  if(!isDefined(level.vehicle_death_fx)) {
    level.vehicle_death_fx = [];
  }

  if(!isDefined(level.vehicle_death_anim)) {
    level.vehicle_death_anim = [];
  }

  if(!isDefined(level.vehicle_death_fx[var_3])) {
    level.vehicle_death_fx[var_3] = [];
  }

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

build_treadfx(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    set_vehicle_effect(var_0, var_1, var_2);

    if(isDefined(var_3) && var_3) {
      set_vehicle_effect(var_0, var_1, var_2, "_bank");
      set_vehicle_effect(var_0, var_1, var_2, "_bank_lg");
    }
  } else {
    var_0 = level.vtclassname;
    maps\_treadfx::main(var_0);
  }
}

build_all_treadfx(var_0, var_1) {
  var_2 = get_surface_types();

  foreach(var_4 in var_2) {
    set_vehicle_effect(var_0, var_4);
  }
}

set_vehicle_effect(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._vehicle_effect)) {
    level._vehicle_effect = [];
  }

  if(isDefined(var_3)) {
    var_1 = var_1 + var_3;
    var_2 = var_2 + var_3;
  }

  if(isDefined(var_2)) {
    level._vehicle_effect[var_0][var_1] = loadfx(var_2);
  } else if(isDefined(level._vehicle_effect[var_0]) && isDefined(level._vehicle_effect[var_0][var_1])) {
    level._vehicle_effect[var_0][var_1] = undefined;
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

build_team(var_0) {
  level.vehicle_team[level.vtclassname] = var_0;
}

build_mainturret(var_0, var_1, var_2, var_3) {
  level.vehicle_hasmainturret[level.vtmodel] = 1;

  if(isDefined(var_0)) {
    level.vehicle_mainturrets[level.vtmodel][var_0] = 1;
  }

  if(isDefined(var_1)) {
    level.vehicle_mainturrets[level.vtmodel][var_1] = 1;
  }

  if(isDefined(var_2)) {
    level.vehicle_mainturrets[level.vtmodel][var_2] = 1;
  }

  if(isDefined(var_3)) {
    level.vehicle_mainturrets[level.vtmodel][var_3] = 1;
  }
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

  if(isDefined(var_1)) {
    level.vehicle_aianims[var_2] = [[var_1]](level.vehicle_aianims[var_2]);
  }
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
  if(isDefined(level.vehicle_csv_export)) {
    return;
  }
  if(var_0 != level.vtmodel) {
    return;
  }
  var_2 = spawnStruct();
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
  if(!isDefined(level.vehicle_death_badplace)) {
    level.vehicle_death_badplace = [];
  }

  var_6 = spawnStruct();
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

  if(isDefined(self.script_speed)) {
    if(!ishelicopter()) {
      var_0 vehphys_setspeed(self.script_speed);
    }
  }

  var_0 thread gopath(var_0);
  return var_0;
}

vehicle_get_riders_by_group(var_0) {
  var_1 = [];
  var_2 = self.classname;

  if(!isDefined(level.vehicle_unloadgroups[var_2])) {
    return var_1;
  }

  var_3 = level.vehicle_unloadgroups[var_2];

  if(!isDefined(var_0)) {
    return var_1;
  }

  foreach(var_5 in self.riders) {
    foreach(var_7 in var_3[var_0]) {
      if(var_5.vehicle_position == var_7) {
        var_1[var_1.size] = var_5;
      }
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

  while(isDefined(self)) {
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

  if(!isDefined(self.attachedpath)) {
    return var_0;
  }

  var_2 = var_1;
  var_2.counted = 0;

  while(isDefined(var_2)) {
    if(isDefined(var_2.counted) && var_2.counted == 1) {
      break;
    }

    var_0 = common_scripts\utility::array_add(var_0, var_2);
    var_2.counted = 1;

    if(!isDefined(var_2.target)) {
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
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  maps\_vehicle_code::lights_on(var_0, var_1);
}

vehicle_lights_off(var_0, var_1) {
  maps\_vehicle_code::lights_off(var_0, var_1);
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
  if(!isDefined(level.helicopter_list)) {
    level.helicopter_list = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.vttype;
  }

  level.helicopter_list[var_0] = 1;
}

build_is_airplane(var_0) {
  if(!isDefined(level.airplane_list)) {
    level.airplane_list = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.vttype;
  }

  level.airplane_list[var_0] = 1;
}

build_single_tread(var_0) {
  if(!isDefined(level.vehicle_single_tread_list)) {
    level.vehicle_single_tread_list = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.vttype;
  }

  level.vehicle_single_tread_list[var_0] = 1;
}

build_rider_death_func(var_0) {
  if(!isDefined(level.vehicle_rider_death_func)) {
    level.vehicle_rider_death_func = [];
  }

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

vehicle_to_dummy() {
  self.modeldummy = spawn("script_model", self.origin);
  self.modeldummy setModel(self.model);
  self.modeldummy.origin = self.origin;
  self.modeldummy.angles = self.angles;
  self.modeldummy useanimtree(#animtree);
  self hide();
  thread maps\_vehicle_code::model_dummy_death();
  move_riders_here(self.modeldummy);
  maps\_vehicle_code::move_turrets_here(self.modeldummy);
  move_truck_junk_here(self.modeldummy);
  thread maps\_vehicle_code::move_lights_here(self.modeldummy);
  maps\_vehicle_code::move_effects_ent_here(self.modeldummy);
  maps\_vehicle_code::copy_attachments(self.modeldummy);
  self.modeldummyon = 1;

  if(maps\_vehicle_code::hashelicopterdustkickup()) {
    self notify("stop_kicking_up_dust");
    thread maps\_vehicle_code::aircraft_wash_thread(self.modeldummy);
  }

  return self.modeldummy;
}

build_death_jolt_delay(var_0) {
  if(!isDefined(level.vehicle_death_jolt)) {
    level.vehicle_death_jolt = [];
  }

  var_1 = spawnStruct();
  var_1.delay = var_0;
  level.vehicle_death_jolt[level.vtclassname] = var_1;
}

enable_global_vehicle_spawn_functions() {
  level.vehicle_spawn_functions_enable = 1;
}