/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_code.gsc
*******************************************/

#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_airdrop;
#using scripts\common\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace vehicle_code;

function vehicle_initlevelvariables() {
  setdvarifuninitialized(@ "hash_b8d9dce6bbc23e00", 0);
  setdvarifuninitialized(@ "hash_fb816855f6554343", 0);
  setdvarifuninitialized(@ "scr_vehicle_husk", 0);
  setdvarifuninitialized(@ "hash_9cdcaf7a53494c37", 0);
  setdvarifuninitialized(@ "hash_cfd8073837710cef", 0);
  setdvarifuninitialized(@ "hash_a56728daa842e5e", 0);
  setdvarifuninitialized(@ "hash_f0f3e5a83f3f2843", 1);
  setdvarifuninitialized(@ "hash_7598045ee90e851d", 1);
  setdvarifuninitialized(@ "hash_4bd69b09131419ca", 1);
  setdvarifuninitialized(@ "ai_debugvehicleinfo", 0);
  setdvarifuninitialized(@ "hash_fd46728789917a5", 0);
  setdvarifuninitialized(@ "hash_6f7d4369d136d19a", 0);

  if(utility::issp()) {
    setsaveddvar(@ "movingplatformcinematicmotion", 1);
    setsaveddvar(@ "useextendedcinematicmotion", 1);
  }

  if(!isDefined(level.vehicle)) {
    level.vehicle = spawnStruct();
  }

  level.vehicle.templates = spawnStruct();
  level.vehicle.helicopter_crash_locations = getEntArray("helicopter_crash_location", #targetname);
  level.vehicle.helicopter_crash_locations = arraycombine(level.vehicle.helicopter_crash_locations, utility::getstructarray_delete("helicopter_crash_location", "targetname"));
  level.vehicle.templates.team = [];
  level.vehicle.templates.deathmodel = [];
  level.vehicle.templates.death_thread = [];
  level.vehicle.templates.driveidle = [];
  level.vehicle.templates.driveidle_r = [];
  level.vehicle.templates.rumble = [];
  level.vehicle.templates.mainturret = [];
  level.vehicle.templates.mgturret = [];
  level.vehicle.templates.death_earthquake = [];
  level.vehicle.templates.surface_effects = [];
  level.vehicle.templates.unloadgroups = [];
  level.vehicle.templates.aianims = [];
  level.vehicle.templates.landanims = [];
  level.vehicle.templates.exhaust_fx = [];
  level.vehicle.templates.engine_fx = [];
  level.vehicle.templates.shoot_shock = [];
  level.vehicle.templates.hide_part_list = [];
  level.vehicle.templates.destructible_model = [];
  level.vehicle.templates.grenade_shield = [];
  level.vehicle.templates.var_d499c951c21f6dbb = [];
  level.vehicle.templates.bullet_shield = [];
  level.vehicle.templates.collision_shield = [];
  level.vehicle.templates.death_jolt = [];
  level.vehicle.templates.death_badplace = [];
  level.vehicle.templates.idle_anim = [];
  level.vehicle.templates.helicopter_list = [];
  level.vehicle.templates.boat_list = [];
  level.vehicle.templates.airplane_list = [];
  level.vehicle.templates.tank_list = [];
  level.vehicle.templates.single_tread_list = [];
  level.vehicle.templates.deathanimations = [];
  level.vehicle.templates.vehicle_death_fx = [];
  level.vehicle.templates.vehicle_rocket_death_fx = [];
  level.vehicle.templates.var_5cc6ecb6fb44af7c = [];
  level.vehicle.templates.death_radiusdamage = [];
  level.vehicle.templates.model = [];
  level.vehicle.templates.husk = [];
  level.vehicle.templates.var_bc8fe258d26d514 = [];
  level.vehicle.templates.iw9physics = [];
  level.vehicle.templates.hudindex = [];
  level.vehicle.templates.dependentparts = [];
  level.vehicle.damageableparts = [];
  level.vehicle.var_f601a32decc8f632 = throttle::throttle_initialize("stoppedVehicle_throttle", 10);

  if(utility::issp()) {
    partdamagel = function_2628f73dceb39b8a(3, 3);
    var_c31008c7889ca83 = function_2628f73dceb39b8a(5, 5);
    var_c30fa8c7889bd51 = function_2628f73dceb39b8a(5, 5);
    var_c31018c7889ccb6 = function_2628f73dceb39b8a(3, 3);
    level.vehicle.damageableparts["tag_mirror_left"] = partdamagel;
    level.vehicle.damageableparts["tag_mirror_left_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_mirror_right"] = partdamagel;
    level.vehicle.damageableparts["tag_mirror_right_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_front_left"] = partdamagel;
    level.vehicle.damageableparts["tag_light_front_left_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_front_right"] = partdamagel;
    level.vehicle.damageableparts["tag_light_front_right_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_front_left_2"] = partdamagel;
    level.vehicle.damageableparts["tag_light_front_right_2"] = partdamagel;
    level.vehicle.damageableparts["tag_light_back_left"] = partdamagel;
    level.vehicle.damageableparts["tag_light_back_left_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_back_right"] = partdamagel;
    level.vehicle.damageableparts["tag_light_back_right_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_back_left_2"] = partdamagel;
    level.vehicle.damageableparts["tag_light_back_right_2"] = partdamagel;
    level.vehicle.damageableparts["tag_light_top_left"] = partdamagel;
    level.vehicle.damageableparts["tag_light_top_right"] = partdamagel;
    level.vehicle.damageableparts["tag_light_front_middle"] = partdamagel;
    level.vehicle.damageableparts["tag_light_front_top"] = partdamagel;
    level.vehicle.damageableparts["tag_light_back_top"] = partdamagel;
    level.vehicle.damageableparts["tag_light_parking_front_left_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_parking_front_right_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_parking_back_left_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_parking_back_right_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_fog_left_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_light_fog_right_d0"] = partdamagel;
    level.vehicle.damageableparts["tag_antenna"] = partdamagel;
    level.vehicle.damageableparts["tag_hubcap_front_left"] = partdamagel;
    level.vehicle.damageableparts["tag_hubcap_front_right"] = partdamagel;
    level.vehicle.damageableparts["tag_hubcap_back_left"] = partdamagel;
    level.vehicle.damageableparts["tag_hubcap_back_right"] = partdamagel;
    level.vehicle.damageableparts["tag_windshield_front"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_windshield_front_pristine"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_windshield_front_web"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_windshield_back"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_window_front_left"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_window_front_right"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_window_back_left"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_window_back_right"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_window_back_left_corner"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_window_back_right_corner"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_window_sunroof"] = var_c31008c7889ca83;
    level.vehicle.damageableparts["tag_door_front_left"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_door_front_right"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_door_back_left"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_door_back_right"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_door_front_left_d0"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_door_front_right_d0"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_door_back_left_d0"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_door_back_right_d0"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_hood"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_hood_d0"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_trunk"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_bumper_front"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_bumper_back"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_bumper_front_damaged"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_bumper_back_damaged"] = var_c30fa8c7889bd51;
    level.vehicle.damageableparts["tag_wheel_center_front_left"] = var_c31018c7889ccb6;
    level.vehicle.damageableparts["tag_wheel_center_front_right"] = var_c31018c7889ccb6;
    level.vehicle.damageableparts["tag_wheel_center_middle_left"] = var_c31018c7889ccb6;
    level.vehicle.damageableparts["tag_wheel_center_middle_right"] = var_c31018c7889ccb6;
    level.vehicle.damageableparts["tag_wheel_center_back_left"] = var_c31018c7889ccb6;
    level.vehicle.damageableparts["tag_wheel_center_back_right"] = var_c31018c7889ccb6;
    level.vehicle.damageableparts["tag_wheel_spare"] = var_c31018c7889ccb6;

    foreach(name, _ in level.vehicle.damageableparts) {
      vehicle::function_6a14477bcf586606(name);
    }
  }
}

function private function_2628f73dceb39b8a(healthvalue, explosivedamagehealthvalue) {
  part = spawnStruct();
  part.healthvalue = healthvalue;
  part.explosivedamagehealthvalue = explosivedamagehealthvalue;
  return part;
}

function _getvehiclespawnerarray(value, key) {
  if(isDefined(value) || isDefined(key)) {
    assert(isDefined(value) && isDefined(key), "<dev string:x24>");
  }

  newarray = [];

  if(isDefined(value) && isDefined(key)) {
    check_classname = 1;
    vehicles = getEntArray(value, key);
  } else {
    check_classname = 0;
    vehicles = getEntArray("script_vehicle", #code_classname);
  }

  foreach(vehicle in vehicles) {
    if(check_classname && vehicle.code_classname != "script_vehicle") {
      continue;
    }

    if(isspawner(vehicle)) {
      newarray[newarray.size] = vehicle;
    }
  }

  return newarray;
}

function _mainturretoff() {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  self.script_turretmain = 0;

  if(!isDefined(self.mainturret)) {
    return;
  }

  _turretoffshared(self.mainturret);
}

function _mainturreton() {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  self.script_turretmain = 1;

  if(!isDefined(self.mainturret)) {
    return;
  }

  _turretonshared(self.mainturret);
}

function _mgoff() {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  self.script_turretmg = 0;

  if(vehicle::ishelicopter() && hashelicopterturret()) {
    if(isDefined(level.chopperturretfunc)) {
      assert(isDefined(level.chopperturretofffunc), "<dev string:x7c>");
      self thread[[level.chopperturretofffunc]]();
      return;
    }
  }

  if(!isDefined(self.mgturret)) {
    return;
  }

  foreach(turret in self.mgturret) {
    _turretoffshared(turret);
  }
}

function _mgon() {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  self.script_turretmg = 1;

  if(vehicle::ishelicopter() && hashelicopterturret()) {
    assert(isDefined(level.chopperturretonfunc), "<dev string:x7c>");
    self thread[[level.chopperturretonfunc]]();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }

  foreach(turret in self.mgturret) {
    turret show();
    _turretonshared(turret);
  }
}

function _turretoffshared(turret) {
  if(isDefined(turret.script_fireondrones)) {
    turret.script_fireondrones = 0;
  }

  turret setmode("manual");
}

function _turretonshared(turret) {
  if(isDefined(turret.script_fireondrones)) {
    turret.script_fireondrones = 1;
  }

  if(isDefined(turret.defaultonmode)) {
    if(turret.defaultonmode != "sentry") {
      turret setmode(turret.defaultonmode);
    }
  } else {
    turret setmode("auto_nonai");
  }

  set_turret_team(turret);
}

function _vehicle_unload(who) {
  self endon("death");

  if(isDefined(who)) {
    self.unload_group = who;
  }

  if(isDefined(self.vehicle_unload_function)) {
    result = self[[self.vehicle_unload_function]]();

    if(isDefined(result)) {
      return result;
    }
  }

  if(isDefined(level.func["vehicle_unload"])) {
    result = self[[level.func["vehicle_unload"]]]();

    if(isDefined(result)) {
      return result;
    }
  }

  if(utility::ent_flag_exist("no_riders_until_unload")) {
    utility::ent_flag_set("no_riders_until_unload");
    ai = spawn_unload_group(self.unload_group);

    foreach(a in ai) {
      ai::spawn_failed(a);
    }

    waittillframeend();
  }

  self notify("unloading");
  ai = [];
  unloadgroups = level.vehicle.templates.unloadgroups[get_vehicle_classname()];

  if(isDefined(unloadgroups)) {
    unloadgroup = vehicle_aianim::get_unload_group();

    if(self.vehiclesetuprope) {
      for(i = 0; i < level.vehicle.templates.aianims[get_vehicle_classname()].size; i++) {
        animpos = level.vehicle.templates.aianims[get_vehicle_classname()][i];

        if(animpos.setuprope) {
          usingrope = 0;

          foreach(rider in self.riders) {
            if(isDefined(rider.vehicle_position) && isDefined(unloadgroup[rider.vehicle_position]) && rider.vehicle_position != i) {
              rideranimpos = vehicle_aianim::anim_pos(self, rider.vehicle_position);

              if(rideranimpos.fastroperig == animpos.fastroperig) {
                usingrope = 1;
                break;
              }
            }
          }

          if(usingrope) {
            foreach(rider in self.riders) {
              if(isalive(rider) && isDefined(rider.vehicle_position) && rider.vehicle_position == i) {
                vehicle_aianim::guy_setup_rope(rider, animpos);
                break;
              }
            }
          }
        }
      }
    }

    foreach(rider in self.riders) {
      if(isDefined(rider.vehicle_position) && isalive(rider) && isDefined(unloadgroup[rider.vehicle_position])) {
        if(isDefined(level.vehicle.aianimcheck["unload"]) && ![[level.vehicle.aianimcheck["unload"]]](rider, rider.vehicle_position)) {
          continue;
        }

        animpos = vehicle_aianim::anim_pos(self, rider.vehicle_position);

        if(isDefined(animpos) && animpos.do_not_unload) {
          continue;
        }

        rider setbattlechatterflag("unloading", 1, 3);
        rider setbattlechatterflag("disabled", 0);

        if(isDefined(level.vehicle.aianimthread["unload"])) {
          if(!animpos.setuprope) {
            rider notify("newanim");

            if(rider != self.aidriver && who == "moving") {
              rider._blackboard.var_b9c6f854e130fe2a = 1;
            }

            if(rider == self.aidriver && who == "moving") {
              continue;
            }

            thread[[level.vehicle.aianimthread["unload"]]](rider, rider.vehicle_position);
            rider notify("unload");
            rider.vehicle = undefined;

            if(isDefined(animpos.mgturret)) {
              rider ai::stop_use_turret();
            }

            ai[ai.size] = rider;
          }
        }
      }
    }
  }

  return ai;
}

function vehicle_setuplevelvariables() {
  if(!utility::add_init_script("vehicle_vars", &vehicle_setuplevelvariables)) {
    return;
  }

  vehicle_initlevelvariables();

  if(getprojectname() == "<dev string:xec>") {
    init_vehicle_spawner_devgui();
  }

  vehicle_aianim::setup_aianimthreads();
}

function vehicle_triggerkillspawner(trigger) {
  trigger waittill("trigger");

  foreach(vehiclespawner in vehicle_getspawnerarray()) {
    if(vehiclespawner.script_kill_vehicle_spawner == trigger.script_kill_vehicle_spawner) {
      vehiclespawner delete();
    }
  }
}

function vehicle_spawnaiarray(spawners) {
  totalspawnedai = [];
  forcespawn = utility::ent_flag_exist("no_riders_until_unload") && utility::ent_flag("no_riders_until_unload");

  foreach(spawner in spawners) {
    spawner.count = 1;
    dronespawn = 0;

    if(isDefined(spawner.script_drone)) {
      dronespawn = 1;
      spawned = utility::script_func("dronespawn_bodyonly", spawner);
      spawned utility::script_func("drone_give_soul");
    } else if(isDefined(spawner.script_fakeactor) || isDefined(spawner.script_bodyonly)) {
      dronespawn = 1;
      spawned = utility::script_func("bodyonlyspawn", spawner);
      spawned utility::script_func("fakeactor_give_soul");
    } else {
      spawned = spawner utility::script_func("spawn_ai", forcespawn);
    }

    if(!dronespawn && !isalive(spawned)) {
      continue;
    }

    totalspawnedai[totalspawnedai.size] = spawned;
  }

  riders = vehicle_removenonridersfromaiarray(totalspawnedai);
  return riders;
}

function vehicle_removenonridersfromaiarray(aiarray) {
  living_ai = [];

  foreach(ai in aiarray) {
    if(!ai_should_be_added(ai)) {
      continue;
    }

    living_ai[living_ai.size] = ai;
  }

  return living_ai;
}

function ai_should_be_added(ai) {
  if(isalive(ai)) {
    return true;
  }

  if(!isDefined(ai)) {
    return false;
  }

  if(!isDefined(ai.classname)) {
    return false;
  }

  return ai.classname == "script_model";
}

function spawn_riders() {
  if(utility::ent_flag_exist("no_riders_until_unload") && !utility::ent_flag("no_riders_until_unload")) {
    self notify("spawnedRiders");
    return [];
  }

  spawners = get_vehicle_riders_spawners();

  if(!spawners.size) {
    self notify("spawnedRiders");
    return [];
  }

  riders = spawn_group(spawners);
  self notify("spawnedRiders", riders);
  return riders;
}

function spawn_group(spawners) {
  ai = vehicle_spawnaiarray(spawners);
  ai = sort_by_startingpos(ai);

  if(vehicle::function_df978a2fa3318bbd()) {
    thread vehicle_ai::load(ai, 1);
  } else {
    foreach(guy in ai) {
      thread vehicle_aianim::guy_enter(guy);
    }
  }

  thread set_loaded_when_full(ai);
  return ai;
}

function set_loaded_when_full(ai) {
  utility::array_wait(ai, "loaded", 1);
  vehicle_aianim::vehicle_loaded_if_full(self);
}

function spawn_unload_group(who) {
  if(!isDefined(who)) {
    return spawn_riders();
  }

  assert(utility::ent_flag_exist("<dev string:xf3>") && utility::ent_flag("<dev string:xf3>"), "<dev string:x10d>");
  spawners = get_vehicle_riders_spawners();

  if(!spawners.size) {
    return [];
  }

  group_spawners = [];
  classname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.unloadgroups[classname]) && isDefined(level.vehicle.templates.unloadgroups[classname][who])) {
    group = level.vehicle.templates.unloadgroups[classname][who];

    for(i = 0; i < group.size; i++) {
      if(isDefined(spawners[i])) {
        spawners[i].script_startingposition = group[i];
      }
    }

    spawners = sort_by_startingpos(spawners);

    foreach(ride_pos in group) {
      foreach(spawner in spawners) {
        if(spawner.script_startingposition == ride_pos) {
          group_spawners[group_spawners.size] = spawner;
        }
      }
    }

    ai = vehicle_spawnaiarray(group_spawners);

    foreach(guy in ai) {
      thread vehicle_aianim::guy_enter(guy);
    }

    self notify("spawnedRiders", ai);
    return ai;
  }

  return spawn_riders();
}

function sort_by_startingpos(guysarray) {
  firstarray = [];
  secondarray = [];

  foreach(guy in guysarray) {
    if(isDefined(guy.script_startingposition)) {
      firstarray[firstarray.size] = guy;
      continue;
    }

    secondarray[secondarray.size] = guy;
  }

  return arraycombine(firstarray, secondarray);
}

function function_2f279e91bd543e23() {
  if(vehicle::ishelicopter()) {
    thread vehicle_ai_avoidance_heli();
    return;
  }

  thread vehicle_ai_avoidance_logic();
}

function get_vehicle_classname() {
  var_7237854e3be197ca = self.classname_mp;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  var_7237854e3be197ca = self.classname_sp;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  return self.classname;
}

function get_vehicle_model() {
  var_7237854e3be197ca = self.modelhack;

  if(isDefined(var_7237854e3be197ca)) {
    return var_7237854e3be197ca;
  }

  model = self.vehiclemodel;

  if(model == "") {
    model = self.model;
  }

  return model;
}

#using_animtree("vehicles");

function vehicle_deathcleanup() {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x153>" + "<dev string:x18c>" + "<dev string:x1b2>");
  self notify("stop_looping_death_fx");
  self notify("death_finished");

  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
  }

  destroynavrepulsor("veh_" + self getentitynumber());

  if(isDefined(self.rumbletrigger)) {
    self.rumbletrigger delete();
  }

  if(isDefined(self.mgturret)) {
    utility::array_delete(self.mgturret);
  }

  if(isDefined(self.mainturret)) {
    self.mainturret delete();
  }

  if(level.vehicle.templates.has_main_turret[self.model]) {
    self clearturrettarget();
  }

  classname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rumble[classname])) {
    self stoprumble(level.vehicle.templates.rumble[classname].rumble);
  }

  if(!utility::issp()) {
    return;
  }

  self useanimtree(#animtree);

  if(isDefined(level.vehicle.templates.driveidle[self.model])) {
    self clearanim(level.vehicle.templates.driveidle[self.model], 0);
  }

  if(isDefined(level.vehicle.templates.driveidle_r[self.model])) {
    self clearanim(level.vehicle.templates.driveidle_r[self.model], 0);
  }
}

function vehicle_iscrashing() {
  return istrue(self.vehiclecrashing);
}

function vehicle_killriders() {
  vehicle_ai::kill_riders();
}

function vehicle_landanims(isunloadnode, hasnextnode) {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  self endon("death");
  classname = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.landanims[classname])) {
    return;
  }

  landanims = level.vehicle.templates.landanims[classname];

  foreach(lanim in landanims) {
    self setanim(lanim.land, 1, 0.2, 1);
  }

  if(!hasnextnode) {
    return;
  }

  if(isDefined(isunloadnode)) {
    self waittill("unloaded");
  } else {
    self waittill("continuepath");
  }

  foreach(lanim in landanims) {
    self clearanim(lanim.land, 0);
    self setanim(lanim.takeoff, 1, 0.2, 1);
  }
}

function waittill_stable(node) {
  offset = 12;
  stabletime = 400;
  timer = gettime() + stabletime;
  prevangles = self.angles;

  while(isDefined(self)) {
    if(abs(angleclamp180(self.angles[0])) > offset || abs(angleclamp180(self.angles[2])) > offset || abs(self.angles[1] - prevangles[1]) > 0.5) {
      timer = gettime() + stabletime;
    }

    if(gettime() > timer) {
      break;
    }

    prevangles = self.angles;
    wait 0.05;
  }
}

function vehicle_kill_badplace_forever() {
  self notify("kill_badplace_forever");
}

function function_b6c635d769164cf1(node) {
  return node.target;
}

function get_from_spawnStruct(node) {
  array = utility::getStructArray(node.target, "targetname");

  if(array.size == 1) {
    return array[0];
  }

  foreach(element in array) {
    poi_definition = isDefined(element.script_poi) ? element.script_poi : element.poi;
    comp_poi_definition = isDefined(self.script_poi) ? self.script_poi : self.poi;

    if(isDefined(poi_definition) && isDefined(comp_poi_definition) && poi_definition == comp_poi_definition) {
      return element;
    }
  }

  return array[0];
}

function get_from_entity(node) {
  ent = getEntArray(node.target, #targetname);

  if(isDefined(ent) && ent.size > 0) {
    return ent[randomint(ent.size)];
  }

  return undefined;
}

function get_from_vehicle_node(node) {
  return getvehiclenode(node.target, #targetname);
}

function set_lookat_from_dest(dest) {
  viewtarget = getEnt(dest.script_linkto, #script_linkname);

  if(!isDefined(viewtarget)) {
    return;
  }

  self setlookatent(viewtarget);
  self.set_lookat_point = 1;
}

function hashelicopterturret() {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");

  if(!isDefined(self.vehicletype)) {
    return false;
  }

  if(self.vehicletype == "cobra") {
    return true;
  }

  if(self.vehicletype == "cobra_player") {
    return true;
  }

  if(self.vehicletype == "viper") {
    return true;
  }

  return false;
}

function vehicle_ai_avoidance_cleanup() {
  self waittill("death");
  vehicle_remove_navobstacle();
  vehicle_remove_navrepulsor();
}

function vehicle_ai_avoidance_logic() {
  self endon("death");
  thread vehicle_ai_avoidance_cleanup();
  isphysicsvehicle = self vehicle_isphysveh();
  var_95f636000669c3d5 = 56.25;
  vehicleref = vehicle::get_ref();

  if(vehicle::has_data(vehicleref)) {
    bundledata = vehicle::get_data(vehicleref);
    var_95f636000669c3d5 = bundledata.nudgethreshold * bundledata.nudgethreshold;
  }

  while(true) {
    throttle::throttle_wait_in_queue(level.vehicle.var_f601a32decc8f632, self);
    vehicle_navobstacle();

    for(currentorigin = self.origin; function_a45a8093293194a7(isphysicsvehicle); currentorigin = self.origin) {
      wait 0.5;

      if(length2dsquared(self.origin - currentorigin) > var_95f636000669c3d5) {
        vehicle_remove_navobstacle();
        vehicle_navobstacle();
      }
    }

    vehicle_remove_navobstacle();
    vehicle_navrepulsor();

    while(!function_a45a8093293194a7(isphysicsvehicle)) {
      wait 0.1;
    }

    vehicle_remove_navrepulsor();
  }
}

function function_a45a8093293194a7(isphysicsvehicle) {
  if(!vehicle_is_stopped(1)) {
    return false;
  }

  if(isphysicsvehicle && !self vehicle_isonground()) {
    return false;
  }

  if(!utility::issp()) {
    if(!self vehicle_isphysveh()) {
      return false;
    }

    if(self hascomponent("p2p") && self function_24e10bf6894fa869("p2p", "manualSpeed") > 0) {
      return false;
    }

    if(self hascomponent("path") && !self function_24e10bf6894fa869("path", "pause") && self function_24e10bf6894fa869("path", "targetSpeed") > 0) {
      return false;
    }
  }

  return true;
}

function vehicle_is_stopped(var_ed87b2c2706620c4) {
  velocity = self vehicle_getvelocity();

  if(!isDefined(velocity)) {
    return true;
  }

  speed = var_ed87b2c2706620c4 ? length((velocity[0], velocity[1], 0)) : length(velocity);

  if(self vehicle_isphysveh()) {
    return (speed / 17.6 < 0.25);
  }

  return speed / 17.6 == 0;
}

function vehicle_ai_avoidance_heli() {
  self endon("death");
  thread vehicle_ai_avoidance_cleanup();

  while(true) {
    vehicle_navobstacle();

    while(self vehicle_getspeed() == 0 && (!isDefined(self.script_disconnectpaths) || self.script_disconnectpaths)) {
      wait 0.1;
    }

    vehicle_remove_navobstacle();

    while(self vehicle_getspeed() != 0 || isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
      wait 0.1;
    }
  }
}

function vehicle_navrepulsor() {
  if(isDefined(self.script_badplace) && !self.script_badplace) {
    return;
  }

  createnavrepulsor(self.unique_id + "vehicle_badplace", -1, self, -1, 0, "allies", "axis");
}

function vehicle_remove_navrepulsor() {
  destroynavrepulsor(self.unique_id + "vehicle_badplace");
}

function vehicle_navobstacle() {
  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    return;
  }

  self.navobstacleid = createnavbadplacebyent(self);
}

function vehicle_remove_navobstacle() {
  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
    self.navobstacleid = undefined;
  }
}

function vehicle_disable_navrepulsors() {
  self.script_badplace = 0;
  vehicle_remove_navrepulsor();
}

function vehicle_enable_navrepulsors() {
  self.script_badplace = undefined;

  if(!function_a45a8093293194a7()) {
    vehicle_navrepulsor();
  }
}

function vehicle_disable_navobstacles() {
  self.script_disconnectpaths = 0;
  vehicle_remove_navobstacle();
}

function vehicle_enable_navobstacles() {
  self.script_disconnectpaths = undefined;

  if(!self.navobstacleid && function_a45a8093293194a7()) {
    vehicle_navobstacle();
  }
}

function mainturretinit() {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  classname = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.mainturret[classname])) {
    return;
  }

  turret_template = level.vehicle.templates.mainturret[classname];

  if(!isDefined(turret_template)) {
    return;
  }

  allowed_turrets = "";

  if(isDefined(self.script_turrets)) {
    allowed_turrets = self.script_turrets;
  }

  self.mainturret = turretinitshared(turret_template);

  if(!isDefined(self.script_turretmain)) {
    self.script_turretmain = 1;
  }

  if(self.script_turretmain == 0) {
    thread _mainturretoff();
    return;
  }

  self.script_turretmain = 1;
  thread _mainturreton();
}

function mginit() {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  classname = get_vehicle_classname();

  if(isDefined(self.script_nomg) && self.script_nomg > 0) {
    return;
  }

  if(!isDefined(level.vehicle.templates.mgturret[classname])) {
    return;
  }

  turret_templates = level.vehicle.templates.mgturret[classname];

  if(!isDefined(turret_templates)) {
    return;
  }

  allowed_turrets = "";

  if(isDefined(self.script_turrets)) {
    allowed_turrets = self.script_turrets;
  }

  foreach(index, turret_template in turret_templates) {
    if(isDefined(turret_template.referencename) && !issubstr(allowed_turrets, turret_template.referencename)) {
      continue;
    }

    self.mgturret[index] = turretinitshared(turret_template);
  }

  if(!isDefined(self.script_turretmg)) {
    self.script_turretmg = 1;
  }

  if(self.script_turretmg == 0) {
    thread _mgoff();
    return;
  }

  self.script_turretmg = 1;
  thread _mgon();
}

function turretinitshared(turret_template) {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  mgangle = 0;

  if(isDefined(self.script_mg_angle)) {
    mgangle = self.script_mg_angle;
  }

  turret = spawnturret("misc_turret", (0, 0, 0), turret_template.info);
  linkoffset = turret_template.offset_tag ?? (0, 0, 0);
  parent = self;

  if(isDefined(turret_template.mainturretchild)) {
    if(!isDefined(self.mainturret)) {
      assertmsg("<dev string:x1be>" + get_vehicle_classname() + "<dev string:x1d5>");
    }

    parent = self.mainturret;
  }

  turret linkTo(parent, turret_template.tag, linkoffset, (0, -1 * mgangle, 0));
  bodymodel = get_vehicle_model();
  array = strtok(bodymodel, "::");

  if(array.size > 1) {
    color = array[0] + "::";
  } else {
    color = "";
  }

  turret setModel(color + turret_template.model);
  turret.angles = self.angles;
  turret.isvehicleattached = 1;
  turret.ownervehicle = self;
  turret.weaponinfo = turret_template.info;
  assert(isDefined(self.script_team));
  turret.script_team = self.script_team;
  turret makeusable();
  set_turret_team(turret);
  level thread vehicle_turret_difficulty(turret, utility::getdifficulty());

  if(isDefined(self.script_fireondrones)) {
    turret.script_fireondrones = self.script_fireondrones;
  }

  if(isDefined(turret_template.deletedelay)) {
    turret.deletedelay = turret_template.deletedelay;
  }

  if(isDefined(turret_template.defaultdroppitch)) {
    turret setdefaultdroppitch(turret_template.defaultdroppitch);
  }

  if(isDefined(turret_template.referencename)) {
    turret.referencename = turret_template.referencename;
  }

  if(isDefined(turret_template.defaultonmode)) {
    turret turret_set_default_on_mode(turret_template.defaultonmode);
  }

  return turret;
}

function vehicle_turret_difficulty(turret, difficulty) {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");
  turret.convergencetime = level.mgturretsettings[difficulty]["convergenceTime"];
  turret.suppressiontime = level.mgturretsettings[difficulty]["suppressionTime"];
  turret.accuracy = level.mgturretsettings[difficulty]["accuracy"];
  turret.aispread = level.mgturretsettings[difficulty]["aiSpread"];
  turret.playerspread = level.mgturretsettings[difficulty]["playerSpread"];
}

function turret_set_default_on_mode(defaultonmode) {
  self.defaultonmode = defaultonmode;
}

function set_turret_team(turret) {
  switch (self.script_team) {
    case #"hash_5f54b9bf7583687f":
    case #"hash_ecada18a31eceade":
      turret setturretteam("allies");
      break;
    case #"hash_3e323a3a6f36e18b":
    case #"hash_7c2d091e6337bf54":
      turret setturretteam("axis");
      break;
    case #"hash_24b14065e10b1f8d":
      turret setturretteam("team3");
      break;
    case #"hash_a571cacc018623b8":
      turret setturretteam("neutral");
      break;
    default:
      assertmsg("<dev string:x22c>" + self.script_team);
      break;
  }
}

function vehicle_setteam() {
  classname = get_vehicle_classname();

  if(!isDefined(self.script_team) && isDefined(level.vehicle.templates.team[classname])) {
    self.script_team = level.vehicle.templates.team[classname];
  }
}

function get_vehiclenode_any_dynamic(target) {
  path_start = getvehiclenode(target, #targetname);

  if(!isDefined(path_start)) {
    path_start = getEnt(target, #targetname);
  } else if(vehicle::ishelicopter()) {
    println("<dev string:x245>" + path_start.targetname);
    println("<dev string:x265>" + self.vehicletype);

    assertmsg("<dev string:x276>");
  }

  if(!isDefined(path_start)) {
    path_start = utility::getStruct(target, "targetname");
  }

  return path_start;
}

function vehicle_isalive(vehicle) {
  assert(!vehicle::function_df978a2fa3318bbd(), "<dev string:x49>");

  if(!isDefined(vehicle)) {
    return false;
  }

  if(vehicle.health < vehicle.healthbuffer) {
    return false;
  }

  if(vehicle.health <= 0) {
    return false;
  }

  if(vehicle.isvehiclehusk) {
    return false;
  }

  return true;
}

function vehicle_setwheeldirection(direction) {
  self.vehiclewheeldirection = direction <= 0 ? 0 : 1;
}

function vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");

  if(vehicle::ishelicopter()) {
    self setgoalyaw(utility::flat_angle(self.angles)[1]);
    self setvehgoalpos(self.origin + (0, 0, 4), 1);
  }
}

function deathrollon() {
  if(self.health > 0) {
    self.rollingdeath = 1;
  }
}

function deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

function get_vehicle_riders_spawners() {
  spawners = [];

  if(isDefined(self.target)) {
    targets = utility::noself_func_return("getspawnerarray", self.target);

    if(!isDefined(targets)) {
      targets = utility::getStructArray(self.target, "targetname");
    }

    if(!isDefined(targets)) {
      targets = [];
    }

    foreach(target in targets) {
      if(isstruct(target)) {
        if(!isDefined(target.script_demeanor)) {
          continue;
        }
      } else {
        if(!issubstr(target.code_classname, "actor") && !issubstr(target.code_classname, "vehicle")) {
          continue;
        }

        if(issubstr(target.code_classname, "actor")) {
          if(!isspawner(target)) {
            continue;
          } else if(issubstr(target.code_classname, "vehicle")) {
            if(!(target.spawnflags & 2)) {
              continue;
            }
          }
        }
      }

      if(isDefined(target.dont_auto_ride)) {
        continue;
      }

      spawners[spawners.size] = target;
    }
  }

  return spawners;
}

function helicopter_unloading_watcher() {
  if(!vehicle::ishelicopter()) {
    return;
  }

  self endon("vehicle_crashDone");
  self waittill("unloading");
  self.unloading = 1;
  self waittill("unloaded");
  self.unloading = undefined;
}

function vehicle_iscorpse() {
  return isDefined(self) && get_vehicle_classname() == "script_vehicle_corpse";
}

function detach_getoutrigs() {
  if(!isDefined(self.fastroperig)) {
    return;
  }

  if(!self.fastroperig.size) {
    return;
  }

  keys = getarraykeys(self.fastroperig);

  for(i = 0; i < keys.size; i++) {
    if(isDefined(self.fastroperig[keys[i]])) {
      self.fastroperig[keys[i]] unlink();
    }
  }
}

function vehicle_huskLaunch(parent, vehicleref, spawndata, forcemultiplier) {
  if(vehicle::is_static() || !self vehicle_isphysveh()) {
    return;
  }

  if(isDefined(parent) && parent.p2phusk) {
    return;
  }

  if(isDefined(parent) && parent.headondeath) {
    return;
  }

  if(isDefined(parent) && isDefined(parent.damageinfo)) {
    damagestrength = parent.damageinfo["amount"];
    damagedir = parent.damageinfo["direction_vec"];
    damagelocation = parent.damageinfo["damageLocation"];
    damagemod = parent.damageinfo["MOD"];
  } else {
    damagestrength = 600;
    damagedir = undefined;
    damagelocation = self.origin;
    damagemod = "";
  }

  if(isDefined(parent) && isDefined(parent.var_52e328d5399ca9af) && gettime() - parent.var_52e328d5399ca9af < 1000) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x2ac>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    damagestrength *= 0.1;
  }

  if(isDefined(damagedir)) {
    damagedir = (damagedir[0], damagedir[1], 0.25);
  } else {
    damagedir = (randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25), 0.25);
  }

  launchstrength = function_1aaf8ca18b62a037(damagestrength, damagemod, damagelocation, 0.3);

  if(isDefined(forcemultiplier)) {
    launchstrength *= forcemultiplier;
  }

  if(isDefined(level.sharedfuncs) && isDefined(vehicleref) && isDefined(level.sharedfuncs[vehicleref])) {
    vehicle_husklaunchoverride = level.sharedfuncs[vehicleref]["vehicle_huskLaunch"];

    if(isDefined(vehicle_husklaunchoverride)) {
      self[[vehicle_husklaunchoverride]](spawndata.initialvelocity);

      if(isDefined(self.damagedir)) {
        damagedir = self.damagedir;
      }

      if(isDefined(self.launchstrength)) {
        launchstrength = self.launchstrength;
      }
    }
  }

  self vehphys_impulse(damagedir, launchstrength, 1);

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    print3d(damagelocation + (0, 0, 6), "<dev string:x2e2>" + gettime(), (1, 0, 1), 1, 0.2, 1000, 1);

    print3d(damagelocation + (0, 0, 3), "<dev string:x2ec>" + launchstrength, (1, 0, 1), 1, 0.2, 1000, 1);

    print3d(damagelocation + (0, 0, 0), "<dev string:x306>" + self getconfigvalue("<dev string:x310>") + "<dev string:x318>" + damagestrength, (1, 0, 1), 1, 0.2, 1000, 1);

    utility::draw_arrow_time(damagelocation, damagelocation + anglesToForward(vectortoangles(damagedir)) * launchstrength, (1, 0, 1), 1000);
  }

  self.var_52e328d5399ca9af = gettime();
}

function vehicle_explosionlaunch(amount, damagedir, damagelocation, meansofdeath) {
  if(!self vehicle_isphysveh()) {
    return;
  }

  if(self.isstationary) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x329>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    return;
  }

  if(self.healthactual <= self.healthbuffer + 1) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x348>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    return;
  }

  if(isDefined(self.parentlaunchtime) && gettime() - self.parentlaunchtime < 1000) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x368>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    amount *= 0.1;
  }

  if(!isDefined(self.var_52e328d5399ca9af)) {
    self.var_52e328d5399ca9af = gettime();
  } else if(gettime() - self.var_52e328d5399ca9af < 1000) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x3a0>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    amount *= 0.1;
  }

  launchstrength = function_1aaf8ca18b62a037(amount, meansofdeath, damagelocation);
  damagedir = (damagedir[0], damagedir[1], 0.25);
  self vehphys_impulse(damagedir, launchstrength, 1);

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    print3d(damagelocation + (0, 0, 6), "<dev string:x2e2>" + gettime() + "<dev string:x3d1>" + self.var_52e328d5399ca9af, (1, 0, 1), 1, 0.2, 1000, 1);

    print3d(damagelocation + (0, 0, 3), "<dev string:x3ef>" + launchstrength, (1, 0, 1), 1, 0.2, 1000, 1);

    print3d(damagelocation + (0, 0, 0), "<dev string:x306>" + self getconfigvalue("<dev string:x310>") + "<dev string:x318>" + amount, (1, 0, 1), 1, 0.2, 1000, 1);

    utility::draw_arrow_time(damagelocation, damagelocation + anglesToForward(vectortoangles(damagedir)) * launchstrength, (1, 0, 1), 1000);
  }

  self.var_52e328d5399ca9af = gettime();
}

function function_1aaf8ca18b62a037(amount, meansofdeath, damagelocation, launchscalar) {
  if(!isDefined(launchscalar)) {
    launchscalar = 1;
  }

  amount = amount > 600 ? 600 : amount;

  if(isDefined(meansofdeath)) {
    meansofdeath = tolower(meansofdeath);

    if(meansofdeath == "mod_projectile_splash") {
      amount *= 0.75;
    }
  }

  if(self hascomponent("p2p")) {
    amount *= 0.1;
  }

  mass = self getconfigvalue("mass");
  maxlaunchstrength = mass * 0.1 * launchscalar;
  normalizedamount = math::normalize_value(600, 0, amount);
  launchstrength = maxlaunchstrength * normalizedamount;
  launchstrength = min(launchstrength, 16250);

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    print3d(damagelocation + (0, 0, 9), "<dev string:x408>" + amount + "<dev string:x422>" + normalizedamount, (0, 1, 0), 1, 0.2, 1000, 1);
  }

  return launchstrength;
}

function function_123d1d60a34593b() {
  if(!self isscriptable()) {
    return;
  }

  self endon("death");
  utility::flag_wait("scriptables_ready");

  if(!self getscriptablehaspart("flag")) {
    return;
  }

  assert(self getscriptableparthasstate("<dev string:x439>", "<dev string:x441>"));
  assert(self getscriptableparthasstate("<dev string:x439>", "<dev string:x449>"));
  assert(self getscriptableparthasstate("<dev string:x439>", "<dev string:x453>"));
  assert(self getscriptableparthasstate("<dev string:x439>", "<dev string:x45b>"));
  speedsqfast = squared(616);
  speedsqmedium = squared(123.2);
  speedsqslow = squared(35.2);
  state = self getscriptablepartstate("flag");

  while(true) {
    self waittill("player_enter");

    while(true) {
      prevstate = state;
      speedsquared = lengthsquared(self vehicle_getvelocity());

      if(speedsquared > speedsqfast) {
        state = "fast";
      } else if(speedsquared > speedsqmedium) {
        state = "medium";
      } else if(speedsquared > speedsqslow) {
        state = "slow";
      } else {
        state = "stopped";
      }

      if(prevstate != state) {
        self setscriptablepartstate("flag", state);
      }

      if(speedsquared < 1 && vehicle_occupancy::get_all_occupants(self).size == 0) {
        break;
      }

      wait 0.1;
    }
  }
}

function init_vehicle_spawn_devgui() {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  wait 5;
  setdvarifuninitialized(@ "scr_vehiclefriendlydamage", 0);
  setdvarifuninitialized(@ "hash_e422b8f9cc30c4bb", 0);
  setdvarifuninitialized(@ "hash_7ca94be708b6afcf", 0);
  devgui::function_9082edeb5db93280("<dev string:x466>");

  foreach(vehicleref in utility::alphabetize(vehicle::function_75acd2d48a8f3605(0))) {
    data = vehicle::get_data(vehicleref);

    if(data.var_1a9fc8dddc15c33) {
      category = "<dev string:x479>";
      devgui::add_devgui_command(category + vehicleref + "<dev string:x48d>", "<dev string:x497>" + vehicleref, 1);
      devgui::add_devgui_command(category + vehicleref + "<dev string:x4b8>", "<dev string:x4c4>" + vehicleref, 2);
      continue;
    }

    category = "<dev string:x4e7>";

    if(data.canfly) {
      category = "<dev string:x4f9>";
    } else if(data.isboat) {
      category = "<dev string:x50a>";
    }

    if(isstartstr(data.ref, "<dev string:x51d>")) {
      category += "<dev string:x525>";
    } else if(isstartstr(data.ref, "<dev string:x52c>")) {
      category += "<dev string:x537>";
    } else if(isstartstr(data.ref, "<dev string:x53f>")) {
      category += "<dev string:x54a>";
    } else if(isstartstr(data.ref, "<dev string:x552>")) {
      category += "<dev string:x55d>";
    } else if(isstartstr(data.ref, "<dev string:x565>")) {
      category += "<dev string:x570>";
    }

    devgui::add_devgui_command(category + vehicleref + "<dev string:x48d>", "<dev string:x578>" + vehicleref, 1);
    devgui::add_devgui_command(category + vehicleref + "<dev string:x4b8>", "<dev string:x593>" + vehicleref, 2);
    devgui::add_devgui_command(category + vehicleref + "<dev string:x5b0>", "<dev string:x497>" + vehicleref, 3);
    devgui::add_devgui_command(category + vehicleref + "<dev string:x5c6>", "<dev string:x4c4>" + vehicleref, 4);
  }

  devgui::function_77df7fe7dd273e10();
  devgui::function_9082edeb5db93280("<dev string:x5de>");
  devgui::add_devgui_command("<dev string:x601>", "<dev string:x616>");
  devgui::add_devgui_command("<dev string:x638>", "<dev string:x64e>");
  devgui::add_devgui_command("<dev string:x670>", "<dev string:x688>");
  devgui::add_devgui_command("<dev string:x6aa>", "<dev string:x6c3>");
  devgui::add_devgui_command("<dev string:x6e5>", "<dev string:x6fc>");
  devgui::add_devgui_command("<dev string:x71e>", "<dev string:x738>");
  devgui::add_devgui_command("<dev string:x75c>", "<dev string:x777>");
  devgui::add_devgui_command("<dev string:x79b>", "<dev string:x7b3>");
  devgui::add_devgui_command("<dev string:x7d4>", "<dev string:x7ec>");
  devgui::add_devgui_command("<dev string:x80d>", "<dev string:x825>");
  devgui::add_devgui_command("<dev string:x846>", "<dev string:x85e>");
  devgui::add_devgui_command("<dev string:x87f>", "<dev string:x897>");
  devgui::add_devgui_command("<dev string:x8b8>", "<dev string:x8d0>");
  devgui::function_77df7fe7dd273e10();
  level thread function_2c6dd6aadcae44d8();
}

function private function_2c6dd6aadcae44d8() {
  while(true) {
    vehicleref = getDvar(@ "scr_spawnvehicle", "<dev string:x8f1>");

    if(vehicleref != "<dev string:x8f1>") {
      player = level.players[0];

      if(isDefined(player)) {
        if(vehicle_airdrop::can_airdrop(vehicleref)) {
          spawndata = spawnStruct();
          spawndata.origin = player.origin + (0, 0, 100);
          spawndata.angles = player.angles * (0, 1, 0);
          spawndata.spawntype = "<dev string:x8f5>";
          level.var_53ee440e883f18de = level vehicle_airdrop::vehicle_airdrop(vehicleref, spawndata);
        } else {
          if(player vehicle::is_in_vehicle(1) && getdvarint(@ "hash_8af4302fef6d5e56")) {
            player.vehicle.dontspawnhusk = 1;
            vehicle::death(player.vehicle);
          }

          level.var_53ee440e883f18de = player thread vehicle::function_69fd088e96b07e30(vehicleref);
        }
      }

      setdevdvar(@ "scr_spawnvehicle", "<dev string:x8f1>");
    }

    host = function_711615b269dcc3c();

    if(!isDefined(host)) {
      waitframe();
      continue;
    }

    forward = anglesToForward(host.angles);
    vehicleref = getDvar(@ "hash_6a4bdbee44239d75", "<dev string:x8f1>");

    if(vehicleref != "<dev string:x8f1>") {
      setdevdvar(@ "hash_6a4bdbee44239d75", "<dev string:x8f1>");
      spawnposition = host.origin + (0, 0, 100) + forward * 300;
      spawnangles = host.angles * (0, 1, 0);
      vehicle = undefined;
      seatid = undefined;
      spawndata = spawnStruct();
      spawndata.origin = spawnposition;
      spawndata.angles = spawnangles;
      spawndata.spawntype = "<dev string:x8f5>";
      [vehicle, seatid] = vehicle::function_48833bc196a87e8c(vehicleref, spawndata);
      level.var_53ee440e883f18de = vehicle;

      if(getdvarint(@ "hash_19956db1f58cf7c", 0) == 1) {
        vehicle function_edc1329b6c257a41(spawnposition, forward);
      } else {
        vehicle addcomponent("<dev string:x8ff>");
        vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x906>", 1);
        vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x915>", 1);
        vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x92c>", 300);
        vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x93d>", 1);
        vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x953>", 0.5);
        vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x967>", 4);
      }

      vehicle vehicle_turnengineon();

      if(!isDefined(level.devvehicles)) {
        level.devvehicles = [vehicle];
      } else {
        level.devvehicles[level.devvehicles.size] = vehicle;
      }
    }

    drivedvar = getdvarint(@ "hash_b48b64507c871c18", 0);

    if(isDefined(level.devvehicles) && drivedvar) {
      setdevdvar(@ "hash_b48b64507c871c18", 0);

      foreach(vehicle in level.devvehicles) {
        switch (drivedvar) {
          case 2:
            if(vehicle.vehiclename == "<dev string:x97d>" || vehicle.vehiclename == "<dev string:x98c>") {
              break;
            }

            direction = vectorNormalize(vehicle.origin - host.origin);
            endpoint = direction * 3000 + vehicle.origin;
            vehicle thread vehicle_ai::function_1a6c0d0264fdd63c(vehicle.origin, endpoint, 300);
            break;
          case 1:
            if(vehicle.vehiclename == "<dev string:x97d>" || vehicle.vehiclename == "<dev string:x98c>") {
              break;
            }

            direction = vectorNormalize(host.origin - vehicle.origin);
            endpoint = direction * -300 + host.origin;
            vehicle thread vehicle_ai::function_1a6c0d0264fdd63c(vehicle.origin, endpoint, 300);
            break;
          case 3:
            vehicle notify("<dev string:x99e>");
            vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x9ae>", 0);
            vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x906>", 1);
            vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x9bd>", vehicle.origin);
            vehicle stoppath();
            vehicle vehicle_setspeedimmediate(0, 1, 1);
            vehicle vehicle_cleardrivingstate();
            break;
          default:
            break;
        }
      }
    }

    destroydvar = getDvar(@ "hash_aba9a0c99545e4f6", "<dev string:x8f1>");

    if(destroydvar != "<dev string:x8f1>" && isDefined(level.devvehicles)) {
      setdevdvar(@ "hash_aba9a0c99545e4f6", "<dev string:x8f1>");

      foreach(index, vehicle in level.devvehicles) {
        if(vehicle.vehiclename == destroydvar) {
          level.devvehicles[index] = undefined;
          vehicle notify("<dev string:x99e>");
          vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x9ae>", 0);
          vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x906>", 1);
          vehicle setconfigvalue("<dev string:x8ff>", "<dev string:x9bd>", vehicle.origin);
          vehicle stoppath();
          vehicle vehicle_setspeedimmediate(0, 1, 1);
          vehicle vehicle_cleardrivingstate();
          break;
        }
      }

      setDvar(@ "hash_37b6962333b896f9", destroydvar);
    }

    waitframe();
  }
}

function private function_711615b269dcc3c() {
  if(!isDefined(level.players)) {
    return undefined;
  }

  hostplayer = undefined;

  foreach(player in level.players) {
    if(isPlayer(player) && player utility::callsharedfunc(#"player", #"ishost")) {
      hostplayer = player;
      break;
    }
  }

  return hostplayer;
}

function init_vehicle_spawner_devgui() {
  setdvarifuninitialized(@ "vehicle_spawner_vehicletype", "<dev string:x8f1>");
  var_337d4e7b01c3603a = function_e102ffad881bafe9();
  ground_vehicles = [];
  water_vehicles = [];
  air_vehicles = [];

  if(isDefined(var_337d4e7b01c3603a)) {
    foreach(var_c63888efdaddcd6e in var_337d4e7b01c3603a) {
      if(isDefined(var_c63888efdaddcd6e.type) && isDefined(var_c63888efdaddcd6e.model)) {
        if(var_c63888efdaddcd6e.type == "<dev string:x9ca>") {
          ground_vehicles[ground_vehicles.size] = var_c63888efdaddcd6e;
          continue;
        }

        if(var_c63888efdaddcd6e.type == "<dev string:x9d4>") {
          water_vehicles[water_vehicles.size] = var_c63888efdaddcd6e;
          continue;
        }

        if(var_c63888efdaddcd6e.type == "<dev string:x9dd>") {
          air_vehicles[air_vehicles.size] = var_c63888efdaddcd6e;
        }
      }
    }
  }

  devgui::function_9082edeb5db93280("<dev string:x9e4>");

  for(index = 0; index < ground_vehicles.size; index++) {
    vehicletype = getxhashsourcename(ground_vehicles[index].vehicletype);
    devgui::function_cd4e263c1f3018ae(vehicletype, "<dev string:xa08>" + vehicletype, &function_33a8d9cc076a760);
  }

  devgui::function_77df7fe7dd273e10();
  devgui::function_9082edeb5db93280("<dev string:xa2c>");

  for(index = 0; index < water_vehicles.size; index++) {
    vehicletype = getxhashsourcename(water_vehicles[index].vehicletype);
    devgui::function_cd4e263c1f3018ae(vehicletype, "<dev string:xa08>" + vehicletype, &function_33a8d9cc076a760);
  }

  devgui::function_77df7fe7dd273e10();
  devgui::function_9082edeb5db93280("<dev string:xa4f>");

  for(index = 0; index < air_vehicles.size; index++) {
    vehicletype = getxhashsourcename(air_vehicles[index].vehicletype);
    devgui::function_cd4e263c1f3018ae(vehicletype, "<dev string:xa08>" + vehicletype, &function_33a8d9cc076a760);
  }

  devgui::function_77df7fe7dd273e10();
}

function function_edc1329b6c257a41(spawnposition, forward) {
  if(getdvarint(@ "hash_19956db1f58cf7c", 0) == 1) {
    vehicle = self;
    var_658b3c60f55be51c = 1500 + 1000 * getdvarint(@ "hash_6f7d4369d136d19a", 0);
    vehicle.var_fe235c34c3ed8888 = spawnposition;
    vehicle.var_778ef4f53292ff6e = vehicle.origin + anglesToForward(vehicle.angles) * var_658b3c60f55be51c;
    vehicle.distancetogoal = 50;
    vehicle.var_89739d842134105c = utility::mph_to_ips(vehicle vehicle_gettopspeedforward());

    if(vehicle vehicle::ishelicopter()) {
      vehicle.var_fe235c34c3ed8888 = vehicle.var_fe235c34c3ed8888 + (0, 100, 0) + forward * 300;
      vehicle.var_778ef4f53292ff6e = vehicle.var_778ef4f53292ff6e + (0, 100, 0) + forward * 300;
      vehicle.distancetogoal = 5000;
      vehicle.var_89739d842134105c /= 2;
    }

    vehicle thread function_3f67fe231df1c8af();
  }
}

function vehicle_spawner_spawn_vehicle() {
  vehicletype = getDvar(@ "vehicle_spawner_vehicletype", "<dev string:x8f1>");

  if(vehicletype != "<dev string:x8f1>") {
    player = level.players[0];

    if(!isDefined(player)) {
      return;
    }

    forward = anglesToForward(player.angles);
    spawnposition = player.origin + (0, 0, 100) + forward * 300;
    spawnangles = player.angles * (0, 1, 0);
    vehicle = spawnVehicle(undefined, "<dev string:xa70>", vehicletype, spawnposition, spawnangles);

    if(!isDefined(vehicle.interactdata)) {
      vehicle makeusable();
    }

    vehicle function_edc1329b6c257a41(spawnposition, forward);
  }
}

function function_33a8d9cc076a760(param) {
  vehicletype = param[0];
  setDvar(@ "vehicle_spawner_vehicletype", vehicletype);
  iprintln("<dev string:xa87>" + vehicletype);
  vehicle_spawner_spawn_vehicle();
}

function function_3f67fe231df1c8af() {
  targetposition = self.var_fe235c34c3ed8888;
  self endon("<dev string:xaa5>");

  while(true) {
    if(!self hascomponent("<dev string:x8ff>")) {
      if(targetposition == self.var_fe235c34c3ed8888) {
        targetposition = self.var_778ef4f53292ff6e;
      } else {
        targetposition = self.var_fe235c34c3ed8888;
      }

      println("<dev string:xaae>" + targetposition);
      var_c5331c6576c90dfe = getdvarint(@ "hash_fd46728789917a5", 0) == 1;
      self addcomponent("<dev string:x8ff>");
      self setconfigvalue("<dev string:x8ff>", "<dev string:x906>", 1);
      self setconfigvalue("<dev string:x8ff>", "<dev string:xac2>", 0);
      self setconfigvalue("<dev string:x8ff>", "<dev string:x9bd>", targetposition);
      self setconfigvalue("<dev string:x8ff>", "<dev string:x9ae>", self.var_89739d842134105c);
      self setconfigvalue("<dev string:x8ff>", "<dev string:xad0>", var_c5331c6576c90dfe);
      self setconfigvalue("<dev string:x8ff>", "<dev string:x92c>", 25);
      self setconfigvalue("<dev string:x8ff>", "<dev string:xae8>", 0.5);
    } else {
      if(distance2dsquared(self.origin, targetposition) <= self.distancetogoal) {
        self removecomponent("<dev string:x8ff>");
      }

      println("<dev string:xb00>" + distance2dsquared(self.origin, targetposition));
    }

    waitframe();
  }
}

# /