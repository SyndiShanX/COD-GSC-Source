/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\vehicle_code.gsc
***********************************************/

#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;
#namespace vehicle_code;

function vehicle_initlevelvariables() {
  setdvarifuninitialized(@ "hash_9403d7d31fc1d981", 1);
  setdvarifuninitialized(@ "hash_fb816855f6554343", 0);
  setdvarifuninitialized(@ "hash_80e8717f617516cf", 0);
  setdvarifuninitialized(@ "hash_9cdcaf7a53494c37", 0);
  setdvarifuninitialized(@ "hash_cfd8073837710cef", 0);
  setdvarifuninitialized(@ "hash_a56728daa842e5e", 0);
  setdvarifuninitialized(@ "hash_f0f3e5a83f3f2843", 1);
  setdvarifuninitialized(@ "hash_7598045ee90e851d", 1);
  setdvarifuninitialized(@ "hash_4bd69b09131419ca", 1);
  setdvarifuninitialized(@ "hash_3a76c9f686d280fc", 0);

  if(utility::issp()) {
    setsaveddvar(@ "hash_a9386838a077a91e", 1);
    setsaveddvar(@ "hash_b2b4f1e1cf04437f", 1);
  }

  if(!isDefined(level.vehicle)) {
    level.vehicle = spawnStruct();
  }

  level.vehicle.templates = spawnStruct();
  level.vehicle.helicopter_crash_locations = getEntArray("helicopter_crash_location", "targetname");
  level.vehicle.helicopter_crash_locations = array_combine(level.vehicle.helicopter_crash_locations, getstructarray_delete("helicopter_crash_location", "targetname"));
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
  level.vehicle.templates.var_7412ca7553957e74 = [];
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
  level.vehicle.templates.death_radiusdamage = [];
  level.vehicle.templates.model = [];
  level.vehicle.templates.husk = [];
  level.vehicle.templates.var_893da51cf12b2c8b = [];
  level.vehicle.templates.iw9physics = [];
  level.vehicle.templates.hudindex = [];
  level.vehicle.templates.dependentparts = [];
  level.vehicle.damageableparts = [];

  if(utility::issp()) {
    level.vehicle.damageableparts["tag_mirror_left"] = 3;
    level.vehicle.damageableparts["tag_mirror_right"] = 3;
    level.vehicle.damageableparts["tag_light_front_left"] = 3;
    level.vehicle.damageableparts["tag_light_front_right"] = 3;
    level.vehicle.damageableparts["tag_light_front_left_2"] = 3;
    level.vehicle.damageableparts["tag_light_front_right_2"] = 3;
    level.vehicle.damageableparts["tag_light_back_left"] = 3;
    level.vehicle.damageableparts["tag_light_back_right"] = 3;
    level.vehicle.damageableparts["tag_light_back_left_2"] = 3;
    level.vehicle.damageableparts["tag_light_back_right_2"] = 3;
    level.vehicle.damageableparts["tag_light_top_left"] = 3;
    level.vehicle.damageableparts["tag_light_top_right"] = 3;
    level.vehicle.damageableparts["tag_light_front_middle"] = 3;
    level.vehicle.damageableparts["tag_light_front_top"] = 3;
    level.vehicle.damageableparts["tag_light_back_top"] = 3;
    level.vehicle.damageableparts["tag_antenna"] = 3;
    level.vehicle.damageableparts["tag_hubcap_front_left"] = 3;
    level.vehicle.damageableparts["tag_hubcap_front_right"] = 3;
    level.vehicle.damageableparts["tag_hubcap_back_left"] = 3;
    level.vehicle.damageableparts["tag_hubcap_back_right"] = 3;
    level.vehicle.damageableparts["tag_windshield_front"] = 5;
    level.vehicle.damageableparts["tag_windshield_front_pristine"] = 5;
    level.vehicle.damageableparts["tag_windshield_front_web"] = 5;
    level.vehicle.damageableparts["tag_windshield_back"] = 5;
    level.vehicle.damageableparts["tag_window_front_left"] = 5;
    level.vehicle.damageableparts["tag_window_front_right"] = 5;
    level.vehicle.damageableparts["tag_window_back_left"] = 5;
    level.vehicle.damageableparts["tag_window_back_right"] = 5;
    level.vehicle.damageableparts["tag_window_back_left_corner"] = 5;
    level.vehicle.damageableparts["tag_window_back_right_corner"] = 5;
    level.vehicle.damageableparts["tag_window_sunroof"] = 5;
    level.vehicle.damageableparts["tag_door_front_left"] = 5;
    level.vehicle.damageableparts["tag_door_front_right"] = 5;
    level.vehicle.damageableparts["tag_door_back_left"] = 5;
    level.vehicle.damageableparts["tag_door_back_right"] = 5;
    level.vehicle.damageableparts["tag_hood"] = 5;
    level.vehicle.damageableparts["tag_trunk"] = 5;
    level.vehicle.damageableparts["tag_bumper_front"] = 5;
    level.vehicle.damageableparts["tag_bumper_back"] = 5;
    level.vehicle.damageableparts["tag_bumper_front_damaged"] = 5;
    level.vehicle.damageableparts["tag_bumper_back_damaged"] = 5;
    level.vehicle.damageableparts["tag_wheel_center_front_left"] = 3;
    level.vehicle.damageableparts["tag_wheel_center_front_right"] = 3;
    level.vehicle.damageableparts["tag_wheel_center_middle_left"] = 3;
    level.vehicle.damageableparts["tag_wheel_center_middle_right"] = 3;
    level.vehicle.damageableparts["tag_wheel_center_back_left"] = 3;
    level.vehicle.damageableparts["tag_wheel_center_back_right"] = 3;
    level.vehicle.damageableparts["tag_wheel_spare"] = 3;

    foreach(name, _ in level.vehicle.damageableparts) {
      scripts\common\vehicle::function_9039b650ffb212c8(name);
    }
  }
}

function private addhealth(amount) {
  if(amount < 0) {
    print("<dev string:x1c>" + amount);

    return;
  }

  self.health += int(amount);
}

function private isexplosivedamage(mod, objweapon) {
  if(isDefined(objweapon) && isDefined(objweapon.basename)) {
    switch (objweapon.basename) {
      case #"hash_734c65fd451709ec":
      case #"hash_b347bbcd9d4a348d":
        if(getdvarint(@ "hash_cfd8073837710cef")) {
          iprintln("skipping explosive damage for weapon: " + objweapon.basename);
        }

        return false;
    }
  }

  if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE") {
    return true;
  }

  return false;
}

function private function_2cffaf4e15c4ab48(weaponname) {
  if(!isDefined(self.var_11bd2d454480b300)) {
    return false;
  }

  if(array_contains(self.var_11bd2d454480b300, weaponname)) {
    return true;
  }

  return false;
}

function _getvehiclespawnerarray(value, key) {
  if(isDefined(value) || isDefined(key)) {
    assertex(isDefined(value) && isDefined(key), "<dev string:x49>");
  }

  newarray = [];

  if(isDefined(value) && isDefined(key)) {
    check_classname = 1;
    vehicles = getEntArray(value, key);
  } else {
    check_classname = 0;
    vehicles = getEntArray("script_vehicle", "code_classname");
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

function _kill_fx_play_direction(attackdir, lerp) {
  if(isDefined(attackdir) && isDefined(lerp)) {
    velocity = self getentityvelocity();
    velocity = vectorNormalize(velocity);
    attackdir = vectorNormalize(attackdir);
    dir = vectorlerp(velocity, attackdir, lerp);
    return dir;
  }

  return undefined;
}

function _mainturretoff() {
  self.script_turretmain = 0;

  if(!isDefined(self.mainturret)) {
    return;
  }

  _turretoffshared(self.mainturret);
}

function _mainturreton() {
  self.script_turretmain = 1;

  if(!isDefined(self.mainturret)) {
    return;
  }

  _turretonshared(self.mainturret);
}

function _mgoff() {
  self.script_turretmg = 0;

  if(ishelicopter() && hashelicopterturret()) {
    if(isDefined(level.chopperturretfunc)) {
      assertex(isDefined(level.chopperturretofffunc), "<dev string:x6e>");
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
  self.script_turretmg = 1;

  if(ishelicopter() && hashelicopterturret()) {
    assertex(isDefined(level.chopperturretonfunc), "<dev string:x6e>");
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

function _setvehgoalpos_wrap(origin, bstop) {
  if(self.health <= 0) {
    return;
  }

  if(isDefined(self.originheightoffset)) {
    origin += (0, 0, self.originheightoffset);
  }

  self setvehgoalpos(origin, bstop);
}

function _vehicle_landvehicle(neargoal, node) {
  self endon("death");
  self notify("newpath");

  if(!isDefined(neargoal)) {
    neargoal = 2;
  }

  self setneargoalnotifydist(neargoal);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(flat_angle(self.angles)[1]);

  if(isDefined(self.unload_land_offset)) {
    _setvehgoalpos_wrap(utility::groundpos(self.origin) + (0, 0, self.unload_land_offset), 1);
  } else {
    _setvehgoalpos_wrap(utility::groundpos(self.origin), 1);
  }

  self waittill("goal");
}

function _vehicle_unload(who) {
  self endon("death");

  if(isDefined(who)) {
    self.unload_group = who;
  }

  if(isDefined(self.var_e477b04ae71253d8)) {
    result = self[[self.var_e477b04ae71253d8]]();

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

  if(ent_flag_exist("no_riders_until_unload")) {
    ent_flag_set("no_riders_until_unload");
    ai = spawn_unload_group(self.unload_group);

    foreach(a in ai) {
      spawn_failed(a);
    }

    waittillframeend();
  }

  self notify("unloading");
  ai = [];
  unloadgroups = level.vehicle.templates.unloadgroups[get_vehicle_classname()];

  if(isDefined(unloadgroups)) {
    unloadgroup = get_unload_group();

    if(istrue(self.vehiclesetuprope)) {
      for(i = 0; i < level.vehicle.templates.aianims[get_vehicle_classname()].size; i++) {
        animpos = level.vehicle.templates.aianims[get_vehicle_classname()][i];

        if(istrue(animpos.setuprope)) {
          usingrope = 0;

          foreach(rider in self.riders) {
            if(isDefined(rider.vehicle_position) && isDefined(unloadgroup[rider.vehicle_position]) && rider.vehicle_position != i) {
              var_7f54a8f82a6ee298 = anim_pos(self, rider.vehicle_position);

              if(var_7f54a8f82a6ee298.fastroperig == animpos.fastroperig) {
                usingrope = 1;
                break;
              }
            }
          }

          if(usingrope) {
            foreach(rider in self.riders) {
              if(isalive(rider) && isDefined(rider.vehicle_position) && rider.vehicle_position == i) {
                scripts\common\vehicle_aianim::guy_setup_rope(rider, animpos);
                break;
              }
            }
          }
        }
      }
    }

    var_3f5e5ee34d09efdd = 0;

    foreach(rider in self.riders) {
      if(isalive(rider) && isDefined(rider.vehicle_position) && isDefined(unloadgroup[rider.vehicle_position])) {
        if(isDefined(level.vehicle.aianimcheck["unload"]) && ![[level.vehicle.aianimcheck["unload"]]](rider, rider.vehicle_position)) {
          continue;
        }

        animpos = anim_pos(self, rider.vehicle_position);

        if(isDefined(animpos) && istrue(animpos.do_not_unload)) {
          continue;
        }

        if(isDefined(level.vehicle.aianimthread["unload"])) {
          if(!istrue(animpos.setuprope)) {
            rider notify("newanim");
            thread[[level.vehicle.aianimthread["unload"]]](rider, rider.vehicle_position);
            var_3f5e5ee34d09efdd = 1;
            rider notify("unload");
            rider.vehicle = undefined;

            if(isDefined(animpos.mgturret)) {
              rider scripts\common\ai::stop_use_turret();
            }

            ai = array_add(ai, rider);
          }
        }
      }
    }

    if(!var_3f5e5ee34d09efdd) {
      scripts\engine\utility::ent_flag_set("unloaded");
    }
  }

  return ai;
}

function vehicle_spawn_internal(vspawner, var_a7333fc35fb3cc3a) {
  if(isDefined(vspawner.script_delay_spawn)) {
    vspawner endon("death");
    wait vspawner.script_delay_spawn;
  }

  assertex(!isDefined(vspawner.vehicle_spawned_thisframe), "<dev string:xde>");
  nonentspawner = 0;

  if(!issp()) {
    vehicle = vehicle_spawn_mp_internal(vspawner);
  } else {
    targetname = default_to(vspawner.targetname, "");
    model = vspawner function_d0e99a4f0c29166e();

    if(isDefined(vspawner.var_ae43938336bbd264)) {
      array = strtok(vspawner.var_ae43938336bbd264, ",");
      color = array[randomintrange(0, array.size)];

      if(color != "base") {
        model = color + "::" + model;
      }
    }

    vehicletype = vspawner.vehicletype;

    if(getdvarint(@ "hash_a56728daa842e5e") && isDefined(level.vehicle.templates.iw9physics[vspawner.classname])) {
      vehicletype = level.vehicle.templates.iw9physics[vspawner.classname];
    }

    vehicle = spawnVehicle(model, targetname, vehicletype, vspawner.origin, vspawner.angles);
    assert(isDefined(vehicle));
    vehicle.classname_mp = vspawner.classname;

    if(isDefined(vspawner.spawnflags) && vspawner.spawnflags & 16) {
      vehicle.isstationary = 1;
    }

    if(isDefined(vspawner.spawnflags) && vspawner.spawnflags & 4) {
      husk = vehicle function_18657584b6bd786a(1);
      return husk;
    }

    if(isDefined(vspawner.spawnflags)) {
      if(vspawner.spawnflags & 1) {
        vehicle thread script_func("vehicle_usable");
      }

      if(vspawner.spawnflags & 8 || istrue(vehicle.isstationary)) {
        vehicle function_65aa053c077c003a(1);
      }
    }

    if(isDefined(vspawner.target)) {
      vehicle.target = vspawner.target;
    }

    if(isDefined(vspawner.script_noteworthy)) {
      vehicle.script_noteworthy = vspawner.script_noteworthy;
    }

    if(isDefined(vspawner.script_parameters)) {
      vehicle.script_parameters = vspawner.script_parameters;
    }

    if(isDefined(vspawner.script_linkto)) {
      vehicle.script_linkto = vspawner.script_linkto;
    }

    if(isDefined(vspawner.script_godmode)) {
      vehicle.script_godmode = vspawner.script_godmode;
    }

    if(isDefined(vspawner.script_index)) {
      vehicle.script_index = vspawner.script_index;
    }

    if(isDefined(vspawner.script_friendname)) {
      vehicle.script_friendname = vspawner.script_friendname;
    }

    if(isDefined(vspawner.script_dontunloadonend)) {
      vehicle.script_dontunloadonend = vspawner.script_dontunloadonend;
    }

    if(isDefined(vspawner.script_deathflag)) {
      vehicle.script_deathflag = vspawner.script_deathflag;
    }

    if(isDefined(vspawner.script_team)) {
      vehicle.script_team = vspawner.script_team;
    }

    if(isDefined(vspawner.script_delete)) {
      vehicle.script_delete = vspawner.script_delete;
    }

    if(isDefined(vspawner.script_vehicle_selfremove)) {
      vehicle.script_vehicle_selfremove = vspawner.script_vehicle_selfremove;
    }

    if(isDefined(vspawner.script_vehicle_lights_on)) {
      vehicle.script_vehicle_lights_on = vspawner.script_vehicle_lights_on;
    }
  }

  assert(isDefined(vehicle));

  if(!isDefined(vspawner.spawned_count)) {
    vspawner.spawned_count = 0;
  }

  vspawner.spawned_count++;
  vspawner.last_spawned_vehicle = vehicle;
  vehicle.vehicle_spawner = vspawner;
  thread vehicle_init(vehicle, var_a7333fc35fb3cc3a);
  vspawner notify("spawned", vehicle);
  return vehicle;
}

function vehicle_spawn_mp_internal(vspawner) {
  targetname = "temp_vehicle_targetname";

  if(isDefined(vspawner.targetname)) {
    targetname = vspawner.targetname;
  }

  if(!isDefined(vspawner.classname_mp)) {
    classname_mp = vspawner.classname;
  } else {
    classname_mp = vspawner.classname_mp;
  }

  vehicle = spawnVehicle(level.vehicle.templates.model[classname_mp], targetname, vspawner.vehicletype, vspawner.origin, vspawner.angles);
  vehicle.classname_mp = classname_mp;

  if(isDefined(vspawner.target)) {
    vehicle.target = vspawner.target;
  }

  return vehicle;
}

function vehicle_setuplevelvariables() {
  if(!add_init_script("vehicle_vars", &vehicle_setuplevelvariables)) {
    return;
  }

  init_struct_class();
  vehicle_initlevelvariables();

  init_vehicle_spawner_devgui();

  scripts\common\vehicle_aianim::setup_aianimthreads();
}

function vehicle_precachescripts() {
  allvehiclesprespawn = [];
  level.needsprecaching = [];

  if(!isDefined(level.vehicleinitthread)) {
    level.vehicleinitthread = [];
  }

  vehicles = getEntArray("script_vehicle", "code_classname");

  foreach(vehicle in vehicles) {
    if(vehicle.vehicletype == "empty" || vehicle.vehicletype == "empty_heli") {
      continue;
    }

    allvehiclesprespawn[allvehiclesprespawn.size] = vehicle;
    vehicle_precachesetup(vehicle.classname, vehicle);
  }

  if(level.needsprecaching.size > 0) {
    println("<dev string:x127>");
    println("<dev string:x180>");
    println("<dev string:x127>");
    tab = "<dev string:x1d9>";

    foreach(index, reasons in level.needsprecaching) {
      println(index);

      foreach(reason in reasons) {
        println(tab + reason.pos);

        foreach(r in reason.reasons) {
          println(tab + tab + r);
        }
      }
    }

    println("<dev string:x127>");

    assertex(0, "<dev string:x1e1>");
    level waittill("never");
  }

  return allvehiclesprespawn;
}

function vehicle_precachesetup(classname, vehicle) {
  vehicletype = function_40fd49171fad19d3(vehicle.vehicletype);

  if(isDefined(level.vehicleinitthread[vehicletype]) && isDefined(level.vehicleinitthread[vehicletype][vehicle.classname])) {
    return;
  }

  if(vehicle.classname == "script_vehicle") {
    return;
  }

  reasons = [];

  if(isDefined(level.needsprecaching[classname])) {
    reasons = level.needsprecaching[classname];
  }

  struct = spawnStruct();
  struct.pos = vehicle.origin;
  struct.reasons = [];

  if(!isDefined(level.vehicleinitthread[vehicletype])) {
    struct.reasons[struct.reasons.size] = "vehicletype \"" + vehicle.vehicletype + "\" is not setup properly. Maybe you just need to re-package? Or you have a Radiant copy/paste issue where you have the wrong vehicletype set?";
  } else if(!isDefined(level.vehicleinitthread[vehicletype][vehicle.classname])) {
    struct.reasons[struct.reasons.size] = "classname \"" + vehicle.classname + "\"is not setup properly. Maybe you just need to re-package? Or the vehicle's Quaked is not setup properly";
  }

  reasons[reasons.size] = struct;
  level.needsprecaching[classname] = reasons;
}

function vehicle_setupspawners() {
  spawners = _getvehiclespawnerarray();

  foreach(spawner in spawners) {
    spawner thread vehicle_spawnerlogic();
    model = spawner function_d0e99a4f0c29166e();

    if(isDefined(spawner.var_ae43938336bbd264) && isDefined(model)) {
      array = strtok(spawner.var_ae43938336bbd264, ",");

      for(i = 0; i < array.size; i++) {
        if(array[i] == "base") {
          precachemodel(model);
          continue;
        }

        precachemodel(array[i] + "::" + model);
      }

      if(isDefined(level.vehicle.templates.husk[model])) {
        for(i = 0; i < array.size; i++) {
          if(array[i] == "base") {
            precachemodel(level.vehicle.templates.husk[model]);
            continue;
          }

          if(istrue(level.vehicle.templates.var_893da51cf12b2c8b[model])) {
            precachemodel(array[i] + "::" + level.vehicle.templates.husk[model]);
          }
        }
      }

      if(isDefined(level.vehicle.templates.mgturret[spawner.classname])) {
        for(i = 0; i < array.size; i++) {
          if(array[i] != "base") {
            precachemodel(array[i] + "::" + level.vehicle.templates.mgturret[spawner.classname][0].model);
          }
        }
      }

      if(isDefined(level.vehicle.templates.mainturret[spawner.classname])) {
        for(i = 0; i < array.size; i++) {
          if(array[i] != "base") {
            precachemodel(array[i] + "::" + level.vehicle.templates.mainturret[spawner.classname].model);
          }
        }
      }
    }
  }
}

function vehicle_spawnerlogic() {
  self endon("entitydeleted");

  if(isDefined(self.script_deathflag)) {
    thread script_func("vehicle_spawner_deathflag");
  }

  self.count = 1;
  self.spawn_functions = [];

  while(true) {
    self waittill("spawned", vehicle);
    self.count--;

    if(!isDefined(vehicle)) {
      println("<dev string:x216>" + self.origin + "<dev string:x23a>");
      continue;
    }

    vehicle.spawn_funcs = self.spawn_functions;
    vehicle.spawner = self;
    vehicle thread script_func("run_spawn_functions");
  }
}

function vehicle_triggerkillspawner(trigger) {
  trigger waittill("trigger");

  foreach(vehiclespawner in vehicle_getspawnerarray()) {
    if(is_equal(vehiclespawner.script_kill_vehicle_spawner, trigger.script_kill_vehicle_spawner)) {
      vehiclespawner delete();
    }
  }
}

function vehicle_spawnaiarray(spawners, var_a7333fc35fb3cc3a) {
  var_d69b722478f810b7 = [];
  forcespawn = ent_flag_exist("no_riders_until_unload") && ent_flag("no_riders_until_unload");

  foreach(spawner in spawners) {
    spawner.count = 1;
    dronespawn = 0;

    if(isDefined(spawner.script_drone)) {
      dronespawn = 1;
      spawned = script_func("dronespawn_bodyonly", spawner);
      spawned script_func("drone_give_soul");
    } else if(isDefined(spawner.script_fakeactor) || isDefined(spawner.script_bodyonly)) {
      dronespawn = 1;
      spawned = script_func("bodyonlyspawn", spawner);
      spawned script_func("fakeactor_give_soul");
    } else {
      spawned = spawner script_func("spawn_ai", forcespawn);
    }

    if(!dronespawn && !isalive(spawned)) {
      continue;
    }

    var_d69b722478f810b7 = array_add(var_d69b722478f810b7, spawned);

    if(istrue(var_a7333fc35fb3cc3a)) {
      waitframe();
    }
  }

  riders = vehicle_removenonridersfromaiarray(var_d69b722478f810b7);
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

function spawn_riders(var_a7333fc35fb3cc3a) {
  if(ent_flag_exist("no_riders_until_unload") && !ent_flag("no_riders_until_unload")) {
    self notify("spawnedRiders");
    return [];
  }

  spawners = get_vehicle_riders_spawners();

  if(!spawners.size) {
    self notify("spawnedRiders");
    return [];
  }

  riders = spawn_group(spawners, var_a7333fc35fb3cc3a);
  self notify("spawnedRiders", riders);
  return riders;
}

function spawn_group(spawners, var_a7333fc35fb3cc3a) {
  ai = vehicle_spawnaiarray(spawners, var_a7333fc35fb3cc3a);
  ai = sort_by_startingpos(ai);

  foreach(guy in ai) {
    thread scripts\common\vehicle_aianim::guy_enter(guy);
  }

  thread set_loaded_when_full(ai);
  return ai;
}

function set_loaded_when_full(ai) {
  array_wait(ai, "loaded", 1);
  scripts\common\vehicle_aianim::vehicle_loaded_if_full(self);
}

function spawn_unload_group(who) {
  if(!isDefined(who)) {
    return spawn_riders();
  }

  assertex(ent_flag_exist("<dev string:x24f>") && ent_flag("<dev string:x24f>"), "<dev string:x269>");
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
      thread scripts\common\vehicle_aianim::guy_enter(guy);
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

  return array_combine(firstarray, secondarray);
}

function vehicle_init(vehicle, var_a7333fc35fb3cc3a) {
  if(getDvar(@ "hash_742caa13b3c2e685") == "1") {
    return;
  }

  assert(vehicle.classname != "<dev string:x2af>");
  classname = vehicle get_vehicle_classname();

  if(isDefined(level.vehicle.templates.hide_part_list[classname])) {
    foreach(part in level.vehicle.templates.hide_part_list[classname]) {
      vehicle hidepart(part);
    }
  }

  vehicletype = function_40fd49171fad19d3(vehicle.vehicletype);

  if(vehicletype == "empty" || vehicletype == "empty_heli") {
    vehicle thread getonpath();
    return;
  }

  vehicle set_ai_number();
  vehicle vehicle_setstartinghealth();

  vehicle thread function_835a3820d2ab0b74();

  vehicle thread function_a1df9e8f97742aaf("<dev string:x2bf>" + vehicle.healthstarting, 0, (0, 1, 0));

  vehicle vehicle_setteam();

  if(!isDefined(level.vehicleinitthread[vehicletype][classname])) {
    println("<dev string:x2df>" + classname);
    println("<dev string:x2f9>" + function_3c8848a3a11b2553(vehicletype));
    println("<dev string:x315>" + vehicle.model);
  }

  vehicle thread[[level.vehicleinitthread[vehicletype][classname]]]();
  vehicle thread vehicle_playexhausteffect();
  vehicle thread vehicle_playengineeffect();

  if(!isDefined(vehicle.script_avoidplayer)) {
    vehicle.script_avoidplayer = 0;
  }

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal) {
      vehicle thermaldrawenable();
    }
  }

  vehicle ent_flag_init("unloaded");
  vehicle ent_flag_init("loaded");
  vehicle ent_flag_init("landed");
  vehicle.riders = [];
  vehicle.unloadque = [];
  vehicle.unload_group = "default";
  vehicle.fastroperig = [];

  if(isDefined(level.vehicle.templates.attachedmodels) && isDefined(level.vehicle.templates.attachedmodels[classname])) {
    rigs = level.vehicle.templates.attachedmodels[classname];
    strings = getarraykeys(rigs);

    foreach(string in strings) {
      vehicle.fastroperig[string] = undefined;
      vehicle.fastroperiganimating[string] = 0;
    }
  }

  if(isDefined(vehicle.script_vehicle_lights_on)) {
    vehicle thread lights_on(vehicle.script_vehicle_lights_on);
  }

  if(isDefined(vehicle.script_godmode)) {
    vehicle.godmode = 1;
  }

  vehicle thread vehicle_damagelogic();
  vehicle thread scripts\common\vehicle_aianim::handle_attached_guys();

  if(isDefined(vehicle.script_friendname)) {
    vehicle setvehiclelookattext(vehicle.script_friendname, &"");
  }

  vehicle thread vehicle_handleunloadevent();

  if(isDefined(vehicle.script_dontunloadonend)) {
    vehicle.dontunloadonend = 1;
  }

  vehicle thread vehicle_rumble();
  vehicle thread script_func("vehicle_treads");
  vehicle thread idle_animations();
  vehicle thread animate_drive_idle();

  if(isDefined(vehicle.script_deathflag)) {
    vehicle thread script_func("vehicle_deathflag");
  }

  vehicle thread mainturretinit();
  vehicle thread mginit();

  if(isDefined(level.vehicle.spawn_callback_thread)) {
    level thread[[level.vehicle.spawn_callback_thread]](vehicle);
  }

  if(isDefined(vehicle.script_team)) {
    vehicle setvehicleteam(vehicle.script_team);
  }

  vehicle function_8e397e15e0fbd01a();
  vehicle thread getonpath();

  if(isDefined(level.ignorewash)) {
    ignore_wash = level.ignorewash;
  } else {
    ignore_wash = 0;
  }

  if(utility::issp() && vehicle vehicle_hasdustkickup() && !ignore_wash) {
    vehicle thread aircraft_wash_thread();
  }

  if(vehicle vehicle_isphysveh()) {
    vehicle.veh_pathtype = "constrained";

    if(isDefined(vehicle.script_pathtype)) {
      vehicle.veh_pathtype = vehicle.script_pathtype;
    }
  }

  vehicle thread function_fd3542824f9c1bd2();
  vehicle thread function_c2b5282b537a56bc();
  vehicle spawn_riders(var_a7333fc35fb3cc3a);
  vehicle thread vehicle_deathlogic();

  if(istrue(var_a7333fc35fb3cc3a)) {
    vehicle notify("vehicle_init_complete");
  }
}

function vehicle_init_mp(vehicle) {
  assert(vehicle.classname != "<dev string:x2af>");
  classname = vehicle get_vehicle_classname();

  if(vehicle.spawndata.vehicletype == "empty" || vehicle.spawndata.vehicletype == "empty_heli") {
    vehicle thread getonpath();
    return;
  }

  vehicle set_ai_number();
  type = vehicle.spawndata.vehicletype;

  if(!isDefined(vehicle.script_avoidplayer)) {
    vehicle.script_avoidplayer = 0;
  }

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal) {
      vehicle thermaldrawenable();
    }
  }

  vehicle ent_flag_init("unloaded");
  vehicle ent_flag_init("loaded");
  vehicle ent_flag_init("landed");
  vehicle.riders = [];
  vehicle.unloadque = [];
  vehicle.unload_group = "default";
  vehicle.fastroperig = [];

  if(isDefined(vehicle.attachedmodels) && isDefined(vehicle.attachedmodels[classname])) {
    rigs = vehicle.attachedmodels[classname];
    strings = getarraykeys(rigs);

    foreach(string in strings) {
      vehicle.fastroperig[string] = undefined;
      vehicle.fastroperiganimating[string] = 0;
    }
  }

  if(isDefined(vehicle.script_godmode)) {
    vehicle.godmode = 1;
  }

  vehicle thread scripts\common\vehicle_aianim::handle_attached_guys();

  if(isDefined(vehicle.script_friendname)) {
    vehicle setvehiclelookattext(vehicle.script_friendname, &"");
  }

  vehicle thread vehicle_handleunloadevent();

  if(isDefined(vehicle.script_dontunloadonend)) {
    vehicle.dontunloadonend = 1;
  }

  vehicle thread script_func("vehicle_treads");

  if(isDefined(vehicle.script_deathflag)) {
    vehicle thread script_func("vehicle_deathflag");
  }

  if(isDefined(vehicle.script_team)) {
    vehicle setvehicleteam(vehicle.script_team);
  }

  vehicle function_8e397e15e0fbd01a();
  vehicle thread getonpath();

  if(isDefined(level.ignorewash)) {
    ignore_wash = level.ignorewash;
  } else {
    ignore_wash = 0;
  }

  if(utility::issp() && vehicle vehicle_hasdustkickup() && !ignore_wash) {
    vehicle thread aircraft_wash_thread();
  }

  if(vehicle vehicle_isphysveh()) {
    vehicle.veh_pathtype = "constrained";

    if(isDefined(vehicle.script_pathtype)) {
      vehicle.veh_pathtype = vehicle.script_pathtype;
    }
  }
}

function function_8e397e15e0fbd01a() {
  if(isDefined(level.var_620e3a366fb95fcf) && level.var_620e3a366fb95fcf) {
    return;
  }

  if(ishelicopter()) {
    thread vehicle_ai_avoidance_heli();
    return;
  }

  thread vehicle_ai_avoidance_logic();
}

function get_vehicle_classname() {
  vehiclebundle = self.veh_scriptbundlesettings;

  if(isDefined(vehiclebundle) && isDefined(vehiclebundle.ref) && isDefined(level.vehicle.templates.model[vehiclebundle.ref])) {
    return vehiclebundle.ref;
  }

  if(isDefined(self.classname_mp)) {
    return self.classname_mp;
  }

  return self.classname;
}

function function_d0e99a4f0c29166e() {
  if(isDefined(self.modelhack)) {
    return self.modelhack;
  }

  model = self.vehiclemodel;

  if(model == "") {
    model = self.model;
  }

  return model;
}

#using_animtree("vehicles");

function vehicle_deathcleanup() {
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
    array_delete(self.mgturret);
  }

  if(isDefined(self.mainturret)) {
    self.mainturret delete();
  }

  if(istrue(level.vehicle.templates.has_main_turret[self.model])) {
    self clearturrettarget();
  }

  classname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rumble[classname])) {
    self stoprumble(level.vehicle.templates.rumble[classname].rumble);
  }

  if(!issp()) {
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

function vehicle_deathlogic() {
  self endon("entitydeleted");
  self endon("nodeath_thread");
  thread helicopter_unloading_watcher();
  self waittill("death", attacker, meansofdeath, weaponobject, damagelocation);

  if(isDefined(self.fn_death)) {
    [[self.fn_death]]();
  }

  shouldcontinue = vehicle_deathcustomlogic(attacker, meansofdeath, weaponobject);

  if(isDefined(shouldcontinue) && !shouldcontinue) {
    return;
  }

  vehicle_playdeatheffects(attacker, meansofdeath, damagelocation);

  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      if(!isDefined(rider)) {
        continue;
      }

      rider notify("EndVehicleMotionWarp");
      rider motionwarpcancel();
    }
  }

  if(isDefined(self.runningtovehicle)) {
    foreach(guy in self.runningtovehicle) {
      if(!isDefined(guy)) {
        continue;
      }

      guy notify("EndVehicleMotionWarp");
      guy motionwarpcancel();
    }
  }

  thread vehicle_killriders();

  if(function_b795d4c865a7bc7e()) {
    function_5d04267dd0768069();
  } else {
    vehicle_setdeathmodel();

    if(ishelicopter()) {
      vehicle_docrash(attacker, meansofdeath);
    }
  }

  if(vehicle_iscorpse()) {
    self notify("vehicle_deathComplete", self.origin, self.angles);
    return;
  }

  vehicle_deathcleanup();
  function_37f33bfe6b63cb0a();
  self notify("vehicle_deathComplete", self.origin, self.angles);

  if(isDefined(self.driver) && isPlayer(self.driver)) {
    self.driver function_f3bb4f4911a1beb2("vehicle", "vehicle_driverShowViewModel");
  }

  if(function_b795d4c865a7bc7e() || self isscriptable()) {
    if(isDefined(self.var_48fb8bde665d628d)) {
      array_delete(self.var_48fb8bde665d628d);
    }
  } else if(istrue(self.vehicle_skipdeathmodel)) {
    if(utility::iscp()) {
      wait 0.1;
    }
  }

  self delete();
}

function vehicle_deathcustomlogic(attacker, meansofdeath, weaponobject) {
  result = undefined;

  if(isDefined(self.custom_death_script)) {
    self thread[[self.custom_death_script]]();
  }

  if(isDefined(self.deathfunction)) {
    result = self[[self.deathfunction]](attacker, meansofdeath, weaponobject);
  }

  if(isDefined(level.vehicle.templates.death_thread[self.vehicletype])) {
    thread[[level.vehicle.templates.death_thread[self.vehicletype]]]();
  }

  registerkill = isDefined(attacker) && isDefined(meansofdeath) && isDefined(weaponobject);

  if(registerkill) {
    weaponname = getcompleteweaponname(weaponobject);
    attacker script_func("register_kill", self, meansofdeath, weaponname);
  }

  return result;
}

function vehicle_iscrashing() {
  return istrue(self.vehiclecrashing);
}

function vehicle_killriders() {
  if(istrue(self.pilot_killed) && !istrue(self.unloading)) {
    self waittill("flavor_done");
  }

  foreach(rider in self.riders) {
    if(!isalive(rider)) {
      continue;
    }

    if(!isDefined(rider.ridingvehicle)) {
      continue;
    }

    if(isDefined(rider.magic_bullet_shield)) {
      rider stop_magic_bullet_shield();
    }

    if(isDefined(rider._blackboard) && isDefined(rider._blackboard.chosenvehicleanimpos) && istrue(rider._blackboard.var_41c9f8c7891f19da)) {
      var_adf3664b12362142 = 100;
      velocity = self vehicle_getvelocity();
      rider.do_immediate_ragdoll = 1;
      rider.ragdollhitloc = "torso_lower";
      rider.ragdollimpactvector = (rider.origin - self.origin) * var_adf3664b12362142 + velocity;
    }

    if(utility::iscp() && isDefined(self.damage_data)) {
      if(isDefined(self.damage_data.attacker) && isPlayer(self.damage_data.attacker)) {
        rider dodamage(rider.maxhealth, self.damage_data.attacker.origin, self.damage_data.attacker, self.damage_data.attacker, self.damage_data.meansofdeath, self.damage_data.objweapon);
      } else {
        rider kill();
      }

      continue;
    }

    rider kill();
  }
}

function vehicle_rider_death_detection(vehicle) {
  if(isDefined(self.vehicle_position) && self.vehicle_position != 0) {
    return;
  }

  self.health = 1;
  vehicle endon("death");
  self.baseaccuracy = 0.15;
  self waittill("death");
  vehicle notify("driver_died");
  vehicle vehicle_killriders();
}

function vehicle_becomes_crashable() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend();
  self.riders = array_removedead(self.riders);

  if(self.riders.size) {
    array_thread(self.riders, &vehicle_rider_death_detection, self);
    waittill_either("veh_collision", "driver_died");
    vehicle_killriders();
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self vehphys_crash();
}

function vehicle_landanims(isunloadnode, hasnextnode) {
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

function vehicle_landvehicle(neargoal, node) {
  return _vehicle_landvehicle(neargoal, node);
}

function spawn_vehicle_and_attach_to_spline_path(default_speed) {
  vehicle = utility::spawn_vehicle();

  if(isDefined(default_speed)) {
    vehicle vehicle_setspeed(default_speed);
  }

  vehicle thread vehicle_becomes_crashable();
  vehicle endon("death");
  vehicle.dontunloadonend = 1;
  vehicle gopath(vehicle);
  vehicle leave_path_for_spline_path();
}

function leave_path_for_spline_path() {
  self endon("script_crash_vehicle");
  waittill_either("enable_spline_path", "reached_end_node");
  node = get_my_spline_node(self.origin);

  if(isDefined(level.drive_spline_path_fun)) {
    node thread[[level.drive_spline_path_fun]](self);
  }
}

function get_my_spline_node(org) {
  org = (org[0], org[1], 0);
  all_nodes = get_array_of_closest(org, level.snowmobile_path);
  close_nodes = [];

  for(i = 0; i < 3; i++) {
    close_nodes[i] = all_nodes[i];
  }

  foreach(path in level.snowmobile_path) {
    foreach(node in close_nodes) {
      if(node == path) {
        return node;
      }
    }
  }

  assertex(0, "<dev string:x32b>");
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

function vehicle_isdestructible() {
  return isDefined(self.destructible_type);
}

function vehicle_playdeatheffects(attacker, meansofdeath, damagelocation) {
  if(vehicle_isdestructible()) {
    return;
  }

  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);
  thread vehicle_deathearthquake();
  thread vehicle_deathradiusdamage();

  if(self isscriptable() && !ishelicopter()) {
    utility::function_3677f2be30fdd581("visibility", "hide");
    delaycall(0.05, &delete);
    return;
  }

  thread vehicle_deathkilllights();
  thread vehicle_deathvfx(attacker, meansofdeath);
}

function vehicle_deathvfx(attacker, meansofdeath) {
  vehicleclassname = get_vehicle_classname();

  if(vehicle_shoulddorocketdeath(attacker, meansofdeath, vehicleclassname)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 3;
    deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[vehicleclassname];
  } else if(istrue(self.pilot_killed)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 4;
    deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[vehicleclassname];
  } else {
    deathfxstructs = level.vehicle.templates.vehicle_death_fx[vehicleclassname];
  }

  if(isDefined(deathfxstructs)) {
    foreach(fxstruct in deathfxstructs) {
      thread kill_fx_thread(self.model, fxstruct, self.vehicletype, attacker);
    }
  }
}

function vehicle_deathearthquake() {
  deathearthquake = level.vehicle.templates.death_earthquake[get_vehicle_classname()];

  if(isDefined(deathearthquake)) {
    earthquake(deathearthquake.scale, deathearthquake.duration, self.origin, deathearthquake.radius);
  }
}

function vehicle_deathradiusdamage() {
  if(ishelicopter()) {
    return;
  }

  classname = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.death_radiusdamage) || !isDefined(level.vehicle.templates.death_radiusdamage[classname])) {
    return;
  }

  maxdamage = level.vehicle.templates.death_radiusdamage[classname].maxdamage;
  mindamage = level.vehicle.templates.death_radiusdamage[classname].mindamage;
  self radiusdamage(self.origin + level.vehicle.templates.death_radiusdamage[classname].offset, level.vehicle.templates.death_radiusdamage[classname].range, maxdamage, mindamage);
}

function vehicle_deathkilllights() {
  lights_off_internal("all", self.model, get_vehicle_classname());
}

function vehicle_shoulddorocketdeath(attacker, meansofdeath, vehicleclassname) {
  if(!vehicle_hasrocketdeath(vehicleclassname)) {
    return false;
  }

  if(istrue(self.vehicle_forcerocketdeath)) {
    return true;
  }

  if(is_equal(meansofdeath, "MOD_PROJECTILE")) {
    return true;
  }

  if(is_equal(meansofdeath, "MOD_PROJECTILE_SPLASH")) {
    return true;
  }

  if(is_equal(meansofdeath, "MOD_GRENADE")) {
    return true;
  }

  return false;
}

function vehicle_hasrocketdeath(classname) {
  return isDefined(level.vehicle.templates.vehicle_rocket_death_fx[classname]);
}

function kill_fx_thread(model, struct, type, attacker) {
  if(isDefined(self.pilot_killed)) {
    self waittill("flavor_done");
  }

  if(isDefined(self.nodeath)) {
    return;
  }

  if(!isDefined(attacker)) {
    return;
  }

  assert(isDefined(struct));

  if(isDefined(struct.waitdelay)) {
    if(struct.waitdelay >= 0) {
      wait struct.waitdelay;
    } else {
      self waittill("death_finished");
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(struct.notifystring)) {
    self notify(struct.notifystring);
  }

  attackerdirection = vectorNormalize(self.origin - attacker.origin);

  if(isDefined(struct.selfdeletedelay)) {
    delaycall(struct.selfdeletedelay, &delete);
  }

  if(isDefined(struct.effect)) {
    if(struct.beffectlooping) {
      if(isDefined(struct.tag)) {
        if(isDefined(struct.stayontag) && struct.stayontag == 1) {
          thread loop_fx_on_vehicle_tag(struct.effect, struct.delay, struct.tag);
        } else {
          thread playloopedfxontag(struct.effect, struct.delay, struct.tag);
        }
      } else {
        forward = self.origin + (0, 0, 100) - self.origin;
        playFX(struct.effect, self.origin, forward);
      }
    } else if(isDefined(struct.tag)) {
      forward = _kill_fx_play_direction(attackerdirection, struct.attacker_velocity_lerp);

      if(isDefined(forward)) {
        deathent = deathfx_ent();
        playFX(struct.effect, deathent gettagorigin(struct.tag), forward);

        if(isDefined(struct.remove_deathfx_entity_delay)) {
          deathent delaycall(struct.remove_deathfx_entity_delay, &delete);
        }
      } else {
        deathent = deathfx_ent();
        playFXOnTag(struct.effect, deathent, struct.tag);
        thread stop_fx_on_vehicle_watcher(struct.effect, deathent, struct.tag);

        if(isDefined(struct.remove_deathfx_entity_delay)) {
          deathfx_ent() delaycall(struct.remove_deathfx_entity_delay, &delete);
        }
      }
    } else {
      forward = _kill_fx_play_direction(attackerdirection, struct.attacker_velocity_lerp);

      if(isDefined(forward)) {
        playFX(struct.effect, self.origin, forward);
      } else {
        forward = self.origin + (0, 0, 100) - self.origin;
        playFX(struct.effect, self.origin, forward);
      }
    }
  }

  if(isDefined(struct.sound)) {
    if(struct.bsoundlooping) {
      thread death_firesound(struct.sound);
      return;
    }

    play_sound_in_space(struct.sound);
  }
}

function stop_fx_on_vehicle_watcher(effect_id, deathent, effect_tag) {
  deathent waittill("stop_all_death_fx");
  stopFXOnTag(effect_id, deathent, effect_tag);
}

function loop_fx_on_vehicle_tag(effect, looptime, tag) {
  assert(isDefined(effect));
  assert(isDefined(tag));
  assert(isDefined(looptime));
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(effect, deathfx_ent(), tag);
    wait looptime;
  }
}

function death_firesound(sound) {
  thread script_func("playloopsound_on_tag", sound, undefined, 0, 1);
  waittill_any_2("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    iprintln("<dev string:x346>");

    return;
  }

  self notify("stop sound" + sound);
}

function deathfx_ent() {
  if(isDefined(self.death_fx_on_self) && self.death_fx_on_self) {
    return self;
  }

  if(!isDefined(self.deathfx_ent)) {
    ent = spawn("script_model", (0, 0, 0));
    ent setModel(self.model);
    ent.origin = self.origin;
    ent.angles = self.angles;
    ent notsolid();
    ent hide();
    ent linkTo(self);
    ent.death_fx = 1;
    self.deathfx_ent = ent;
  } else {
    self.deathfx_ent setModel(self.model);
  }

  return self.deathfx_ent;
}

function playloopedfxontag(effect, durration, tag) {
  effectorigin = spawn("script_origin", self.origin);
  self endon("fire_extinguish");
  thread playloopedfxontag_originupdate(tag, effectorigin);

  while(true) {
    playFX(effect, effectorigin.origin, effectorigin.upvec);
    wait durration;
  }
}

function playloopedfxontag_originupdate(tag, effectorigin) {
  effectorigin.angles = self gettagangles(tag);
  effectorigin.origin = self gettagorigin(tag);
  effectorigin.forwardvec = anglesToForward(effectorigin.angles);
  effectorigin.upvec = anglestoup(effectorigin.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    effectorigin.angles = self gettagangles(tag);
    effectorigin.origin = self gettagorigin(tag);
    effectorigin.forwardvec = anglesToForward(effectorigin.angles);
    effectorigin.upvec = anglestoup(effectorigin.angles);
    wait 0.05;
  }
}

function update_steering(vehicle) {
  if(vehicle.update_time == gettime()) {
    return vehicle.steering;
  }

  vehicle.update_time = gettime();

  if(vehicle.steering_enable) {
    steering_goal = clamp(0 - vehicle.angles[2], 0 - vehicle.steering_maxroll, vehicle.steering_maxroll) / vehicle.steering_maxroll;

    if(isDefined(vehicle.leanasitturns) && vehicle.leanasitturns) {
      vehicle_steering = vehicle vehicle_getsteering();
      vehicle_steering *= -1;
      steering_goal += vehicle_steering;

      if(steering_goal != 0) {
        goal_factor = 1 / abs(steering_goal);

        if(goal_factor < 1) {
          steering_goal *= goal_factor;
        }
      }
    }

    delta = steering_goal - vehicle.steering;

    if(delta != 0) {
      factor = vehicle.steering_maxdelta / abs(delta);

      if(factor < 1) {
        delta *= factor;
      }

      vehicle.steering += delta;
    }
  } else {
    vehicle.steering = 0;
  }

  return vehicle.steering;
}

function function_98c0327a3d5ce1c(target) {
  return target;
}

function get_from_spawnStruct(target) {
  array = getStructArray(target, "targetname");

  if(array.size == 1) {
    return array[0];
  }

  foreach(element in array) {
    if(isDefined(element.poi) && isDefined(self.poi) && element.poi == self.poi) {
      return element;
    }
  }

  return array[0];
}

function get_from_entity(target) {
  ent = getEntArray(target, "targetname");

  if(isDefined(ent) && ent.size > 0) {
    return ent[randomint(ent.size)];
  }

  return undefined;
}

function get_from_vehicle_node(target) {
  return getvehiclenode(target, "targetname");
}

function set_lookat_from_dest(dest) {
  viewtarget = getEnt(dest.script_linkto, "script_linkname");

  if(!isDefined(viewtarget)) {
    return;
  }

  self setlookatent(viewtarget);
  self.set_lookat_point = 1;
}

function damage_hint_bullet_only() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }

    type = tolower(type);

    switch (type) {
      case #"hash_85662cca994b567":
      case #"hash_cafa41dcb907577c":
      case #"hash_f43c177a8f2e82d9":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;
          attacker script_func("display_hint", "invulerable_bullets");
          wait 4;
          level.armordamagehints = 0;

          if(isDefined(self)) {
            self.displayingdamagehints = 0;
          }

          break;
        }

        break;
    }
  }
}

function damage_hints() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }

    type = tolower(type);

    switch (type) {
      case #"hash_85662cca994b567":
      case #"hash_1991ba0f6a8cd0a2":
      case #"hash_3734ba2dac7b82b0":
      case #"hash_cafa41dcb907577c":
      case #"hash_f43c177a8f2e82d9":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;

          if(type == "mod_grenade" || type == "mod_grenade_splash") {
            attacker script_func("display_hint", "invulerable_frags", 5);
          } else {
            attacker script_func("display_hint", "invulerable_bullets", 5);
          }

          wait 4;
          level.armordamagehints = 0;

          if(isDefined(self)) {
            self.displayingdamagehints = 0;
          }

          break;
        }

        break;
    }
  }
}

function damage_hints_cleanup() {
  self waittill("death");

  if(self.displayingdamagehints) {
    level.armordamagehints = 0;
  }
}

function aircraft_wash_thread(model) {
  self endon("death");
  self endon("death_finished");
  self notify("stop_kicking_up_dust");
  self endon("stop_kicking_up_dust");
  max_height = 2000;

  if(isDefined(level.treadfx_maxheight)) {
    max_height = level.treadfx_maxheight;
  }

  min_fraction = 80 / max_height;
  rate = 0.5;

  if(isairplane()) {
    rate = 0.15;
  }

  trace_ent = self;

  if(isDefined(model)) {
    trace_ent = model;
  }

  trace_count = 3;
  var_b5973f58036e29a5 = scripts\engine\trace::create_default_contents(1);

  for(;;) {
    wait rate;

    if(true) {
      if(isDefined(self.disable_wash) && self.disable_wash) {
        continue;
      }

      if(isDefined(self.treadfx_maxheight)) {
        max_height = self.treadfx_maxheight;
      }

      down_vector = anglestoup(trace_ent.angles) * -1;
      trace = undefined;
      trace_count++;

      if(trace_count > 3) {
        trace_count = 3;
        trace = scripts\engine\trace::ray_trace(trace_ent.origin, trace_ent.origin + down_vector * max_height, trace_ent, var_b5973f58036e29a5, 1);
      }

      if(trace["fraction"] == 1 || trace["fraction"] < min_fraction) {
        continue;
      }

      dist = distance(trace_ent.origin, trace["position"]);
      treadfx = get_wash_fx(self, trace, down_vector, dist);

      if(!isDefined(treadfx)) {
        continue;
      }

      rate = (dist - 350) / (max_height - 350) * 0.1 + 0.05;
      rate = max(rate, 0.05);

      if(!isDefined(trace)) {
        continue;
      }

      if(!isDefined(trace["position"])) {
        continue;
      }

      fx_origin = trace["position"];
      fx_normal = trace["normal"];
      dist = vectordot(fx_origin - trace_ent.origin, fx_normal);
      pos = trace_ent.origin + (0, 0, dist);
      forward = fx_origin - pos;

      if(isDefined(self.treadfx_orient_to_player)) {
        forward = fx_origin - level.player.origin;
      }

      if(vectordot(trace["normal"], (0, 0, 1)) == -1) {
        continue;
      }

      if(length(forward) < 1) {
        forward = trace_ent.angles + (0, 180, 0);
      }

      playFX(treadfx, fx_origin, fx_normal, forward);
    }
  }
}

function get_wash_fx(vehicle, trace, down_vector, dist) {
  surface = trace["surfacetype"];
  bank = undefined;
  dot = vectordot((0, 0, -1), down_vector);

  if(dot >= 0.97) {
    bank = undefined;
  } else if(dot >= 0.92) {
    bank = "_bank";
  } else {
    bank = "_bank_lg";
  }

  return get_wash_effect(vehicle get_vehicle_classname(), surface, bank);
}

function get_wash_effect(classname, surface, bank) {
  if(isDefined(bank)) {
    bank_surface = surface + bank;

    if(!isDefined(level.vehicle.templates.surface_effects[classname][bank_surface]) && surface != "default") {
      return get_wash_effect(classname, "default", bank);
    } else {
      return level.vehicle.templates.surface_effects[classname][bank_surface];
    }
  }

  return get_vehicle_effect(classname, surface);
}

function get_vehicle_effect(classname, surface) {
  if(!isDefined(level.vehicle.templates.surface_effects[classname][surface]) && surface != "default") {
    return get_vehicle_effect(classname, "default");
  } else {
    return level.vehicle.templates.surface_effects[classname][surface];
  }

  return undefined;
}

function no_treads() {
  return ishelicopter() || isairplane();
}

function vehicle_hasdustkickup() {
  if(!ishelicopter() && !isairplane()) {
    return false;
  }

  return true;
}

function hashelicopterturret() {
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
  var_f9728679c5e60af8 = 56.25;

  while(true) {
    vehicle_navobstacle();

    for(currentorigin = self.origin; vehicle_is_stopped() && (!isphysicsvehicle || self vehicle_isonground()); currentorigin = self.origin) {
      wait 0.5;

      if(lengthsquared(self.origin - currentorigin) > var_f9728679c5e60af8) {
        vehicle_remove_navobstacle();
        vehicle_navobstacle();
      }
    }

    vehicle_remove_navobstacle();
    vehicle_navrepulsor();

    while(!vehicle_is_stopped() || isphysicsvehicle && !self vehicle_isonground()) {
      wait 0.1;
    }

    vehicle_remove_navrepulsor();
  }
}

function vehicle_is_stopped() {
  if(!issp() && self issuspendedvehicle()) {
    return true;
  }

  if(self vehicle_isphysveh()) {
    if(isDefined(self.var_fa004eae3663dc6c)) {
      return (length(self vehicle_getvelocity()) / 17.6 < self.var_fa004eae3663dc6c);
    } else {
      return (length(self vehicle_getvelocity()) / 17.6 < 0.25);
    }
  }

  return length(self vehicle_getvelocity()) / 17.6 == 0;
}

function vehicle_ai_avoidance_heli() {
  self endon("death");

  while(true) {
    vehicle_navobstacle();

    while(self vehicle_getspeed() == 0 && (!isDefined(self.script_disconnectpaths) || istrue(self.script_disconnectpaths))) {
      wait 0.1;
    }

    vehicle_remove_navobstacle();

    while(self vehicle_getspeed() != 0 || isDefined(self.script_disconnectpaths) && !istrue(self.script_disconnectpaths)) {
      wait 0.1;
    }
  }
}

function vehicle_navrepulsor() {
  if(isDefined(self.script_badplace) && !istrue(self.script_badplace)) {
    return;
  }

  createnavrepulsor(self.unique_id + "vehicle_badplace", -1, self, "allies", "axis");
}

function vehicle_remove_navrepulsor() {
  destroynavrepulsor(self.unique_id + "vehicle_badplace");
}

function vehicle_navobstacle() {
  if(isDefined(self.script_disconnectpaths) && !istrue(self.script_disconnectpaths)) {
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

  if(!vehicle_is_stopped()) {
    vehicle_navrepulsor();
  }
}

function vehicle_disable_navobstacles() {
  self.script_disconnectpaths = 0;
  vehicle_remove_navobstacle();
}

function vehicle_enable_navobstacles() {
  self.script_disconnectpaths = undefined;

  if(vehicle_is_stopped()) {
    vehicle_navobstacle();
  }
}

function vehicle_badplace() {
  vehicle_navrepulsor();
}

function vehicle_remove_badplace() {
  vehicle_remove_navrepulsor();
}

function disconnect_paths_whenstopped() {
  self endon("death");
  self.pathsdisconnected = 0;
  var_d92d81d0d2fdf1c2 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    var_d92d81d0d2fdf1c2 = 1;
  }

  if(var_d92d81d0d2fdf1c2) {
    self.dontdisconnectpaths = 1;
    return;
  }

  wait randomfloat(1);

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self.dontdisconnectpaths)) {
        self disconnectPaths();
        self.pathsdisconnected = 1;
      } else {
        assertex(self.dontdisconnectpaths == 1, "<dev string:x397>");
      }

      self notify("speed_zero_path_disconnect");

      while(self vehicle_getspeed() < 1) {
        if(isDefined(self.dontdisconnectpaths) && self.dontdisconnectpaths) {
          break;
        }

        wait 0.05;
      }
    }

    self connectpaths();
    self.pathsdisconnected = 0;
    wait 1;
  }
}

function mainturretinit() {
  classname = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.mainturret[classname])) {
    return;
  }

  var_f15dc6dd1ec8f7de = level.vehicle.templates.mainturret[classname];

  if(!isDefined(var_f15dc6dd1ec8f7de)) {
    return;
  }

  allowed_turrets = "";

  if(isDefined(self.script_turrets)) {
    allowed_turrets = self.script_turrets;
  }

  self.mainturret = turretinitshared(var_f15dc6dd1ec8f7de);

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
  classname = get_vehicle_classname();

  if(isDefined(self.script_nomg) && self.script_nomg > 0) {
    return;
  }

  if(!isDefined(level.vehicle.templates.mgturret[classname])) {
    return;
  }

  var_9a34054ab3f8b177 = level.vehicle.templates.mgturret[classname];

  if(!isDefined(var_9a34054ab3f8b177)) {
    return;
  }

  allowed_turrets = "";

  if(isDefined(self.script_turrets)) {
    allowed_turrets = self.script_turrets;
  }

  foreach(index, var_f15dc6dd1ec8f7de in var_9a34054ab3f8b177) {
    if(isDefined(var_f15dc6dd1ec8f7de.referencename) && !issubstr(allowed_turrets, var_f15dc6dd1ec8f7de.referencename)) {
      continue;
    }

    self.mgturret[index] = turretinitshared(var_f15dc6dd1ec8f7de);
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

function turretinitshared(var_f15dc6dd1ec8f7de) {
  mgangle = 0;

  if(isDefined(self.script_mg_angle)) {
    mgangle = self.script_mg_angle;
  }

  turret = spawnturret("misc_turret", (0, 0, 0), var_f15dc6dd1ec8f7de.info);
  linkoffset = ter_op(isDefined(var_f15dc6dd1ec8f7de.offset_tag), var_f15dc6dd1ec8f7de.offset_tag, (0, 0, 0));
  parent = self;

  if(isDefined(var_f15dc6dd1ec8f7de.mainturretchild)) {
    if(!isDefined(self.mainturret)) {
      assertmsg("<dev string:x3d0>" + get_vehicle_classname() + "<dev string:x3e7>");
    }

    parent = self.mainturret;
  }

  turret linkTo(parent, var_f15dc6dd1ec8f7de.tag, linkoffset, (0, -1 * mgangle, 0));
  bodymodel = function_d0e99a4f0c29166e();
  array = strtok(bodymodel, "::");

  if(array.size > 1) {
    color = array[0] + "::";
  } else {
    color = "";
  }

  turret setModel(color + var_f15dc6dd1ec8f7de.model);
  turret.angles = self.angles;
  turret.isvehicleattached = 1;
  turret.ownervehicle = self;
  turret.weaponinfo = var_f15dc6dd1ec8f7de.info;
  assert(isDefined(self.script_team));
  turret.script_team = self.script_team;
  turret makeusable();
  set_turret_team(turret);
  level thread vehicle_turret_difficulty(turret, utility::getdifficulty());

  if(isDefined(self.script_fireondrones)) {
    turret.script_fireondrones = self.script_fireondrones;
  }

  if(isDefined(var_f15dc6dd1ec8f7de.deletedelay)) {
    turret.deletedelay = var_f15dc6dd1ec8f7de.deletedelay;
  }

  if(isDefined(var_f15dc6dd1ec8f7de.defaultdroppitch)) {
    turret setdefaultdroppitch(var_f15dc6dd1ec8f7de.defaultdroppitch);
  }

  if(isDefined(var_f15dc6dd1ec8f7de.referencename)) {
    turret.referencename = var_f15dc6dd1ec8f7de.referencename;
  }

  if(isDefined(var_f15dc6dd1ec8f7de.defaultonmode)) {
    turret turret_set_default_on_mode(var_f15dc6dd1ec8f7de.defaultonmode);
  }

  return turret;
}

function vehicle_turret_difficulty(turret, difficulty) {
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
      assertmsg("<dev string:x43e>" + self.script_team);
      break;
  }
}

function animate_drive_idle() {
  if(!issp()) {
    return;
  }

  self endon("suspend_drive_anims");

  if(!isDefined(self.vehiclewheeldirection)) {
    self.vehiclewheeldirection = 1;
  }

  model = function_d0e99a4f0c29166e();
  curanimrate = -1;
  newanimtime = undefined;

  if(!isDefined(level.vehicle.templates.driveidle[model])) {
    return;
  }

  self useanimtree(#animtree);

  if(!isDefined(level.vehicle.templates.driveidle_r[model])) {
    level.vehicle.templates.driveidle_r[model] = level.vehicle.templates.driveidle[model];
  }

  self endon("death");
  normalspeed = level.vehicle.templates.driveidle_normal_speed[model];
  animrate = 1;

  if(isDefined(level.vehicle.templates.driveidle_animrate) && isDefined(level.vehicle.templates.driveidle_animrate[model])) {
    animrate = level.vehicle.templates.driveidle_animrate[model];
  }

  lastdir = self.vehiclewheeldirection;
  animation = level.vehicle.templates.driveidle[model];

  while(true) {
    if(!normalspeed) {
      if(isDefined(self.suspend_driveanims)) {
        wait 0.05;
        continue;
      }

      self setanim(level.vehicle.templates.driveidle[model], 1, 0.2, animrate);
      return;
    }

    speed = self vehicle_getspeed();

    if(lastdir != self.vehiclewheeldirection) {
      dif = 0;

      if(self.vehiclewheeldirection) {
        animation = level.vehicle.templates.driveidle[model];
        dif = 1 - get_normal_anim_time(level.vehicle.templates.driveidle_r[model]);
        self clearanim(level.vehicle.templates.driveidle_r[model], 0);
      } else {
        animation = level.vehicle.templates.driveidle_r[model];
        dif = 1 - get_normal_anim_time(level.vehicle.templates.driveidle[model]);
        self clearanim(level.vehicle.templates.driveidle[model], 0);
      }

      newanimtime = 0.01;

      if(newanimtime >= 1 || newanimtime == 0) {
        newanimtime = 0.01;
      }

      lastdir = self.vehiclewheeldirection;
    }

    newanimrate = speed / normalspeed;

    if(newanimrate != curanimrate) {
      self setanim(animation, 1, 0.05, newanimrate);
      curanimrate = newanimrate;
    }

    if(isDefined(newanimtime)) {
      self setanimtime(animation, newanimtime);
      newanimtime = undefined;
    }

    wait 0.05;
  }
}

function setup_vehicles(vehicles) {
  nonspawned = [];

  foreach(vehicle in vehicles) {
    if(isspawner(vehicle)) {
      continue;
    }

    nonspawned[nonspawned.size] = vehicle;
  }

  foreach(live_vehicle in nonspawned) {
    model = live_vehicle function_d0e99a4f0c29166e();

    if(isDefined(live_vehicle.var_ae43938336bbd264) && isDefined(model)) {
      array = strtok(live_vehicle.var_ae43938336bbd264, ",");
      color = array[randomintrange(0, array.size)];

      if(color == "base") {
        precachemodel(model);
      } else {
        precachemodel(color + "::" + model);
      }

      if(isDefined(level.vehicle.templates.husk[model])) {
        if(color == "base") {
          precachemodel(level.vehicle.templates.husk[model]);
        } else if(istrue(level.vehicle.templates.var_893da51cf12b2c8b[model])) {
          precachemodel(color + "::" + level.vehicle.templates.husk[model]);
        }
      }

      if(color == "base") {
        live_vehicle setModel(model);
      } else {
        live_vehicle setModel(color + "::" + model);
      }
    }

    if(isDefined(live_vehicle.spawnflags) && live_vehicle.spawnflags & 16) {
      live_vehicle.isstationary = 1;
    }

    if(isDefined(live_vehicle.spawnflags) && live_vehicle.spawnflags & 4) {
      husk = live_vehicle thread function_18657584b6bd786a(1);
      continue;
    }

    if(isDefined(live_vehicle.spawnflags)) {
      if(live_vehicle.spawnflags & 1) {
        live_vehicle thread script_func("vehicle_usable");
      } else {
        live_vehicle vehicle_turnengineoff();
      }

      if(live_vehicle vehicle_isphysveh() && !live_vehicle ishelicopter() && (live_vehicle.spawnflags & 8 || istrue(live_vehicle.isstationary))) {
        live_vehicle function_65aa053c077c003a(1);
      }
    }

    thread vehicle_init(live_vehicle);
  }
}

function vehicle_setstartinghealth() {
  classname = get_vehicle_classname();
  assertex(isDefined(level.vehicle.templates.life[classname]), "<dev string:x457>" + classname);

  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
  } else {
    if(level.vehicle.templates.life[classname] == -1) {
      return;
    }

    if(isDefined(level.vehicle.templates.life_range_low[classname]) && isDefined(level.vehicle.templates.life_range_high[classname]) && level.vehicle.templates.life_range_high[classname] > level.vehicle.templates.life_range_low[classname]) {
      self.health = randomint(level.vehicle.templates.life_range_high[classname] - level.vehicle.templates.life_range_low[classname]) + level.vehicle.templates.life_range_low[classname];
    } else {
      self.health = level.vehicle.templates.life[classname];
    }
  }

  self.explosivehits = 0;
  self.maxhealth = self.health;
  self.healthactual = self.health;
  self.healthstarting = self.health;
  self.damagestate = "damagePristine";
  self.var_653c58271b7da4c9 = 1;
  self.ui_warning = 0;
  function_98c558b067cdd616();
}

function get_normal_anim_time(animation) {
  animtime = self getanimtime(animation);
  animlength = getanimlength(animation);

  if(animtime == 0) {
    return 0;
  }

  return self getanimtime(animation) / getanimlength(animation);
}

function suspend_drive_anims() {
  self notify("suspend_drive_anims");
  self clearanim(level.vehicle.templates.driveidle[self.model], 0);
  self clearanim(level.vehicle.templates.driveidle_r[self.model], 0);
}

function idle_animations() {
  if(!isDefined(level.vehicle.templates.idle_anim[self.model])) {
    return;
  }

  self useanimtree(#animtree);

  foreach(animation in level.vehicle.templates.idle_anim[self.model]) {
    self setanim(animation);
  }
}

function vehicle_rumble() {
  self endon("kill_rumble_forever");
  classname = get_vehicle_classname();
  rumblestruct = level.vehicle.templates.rumble[classname];

  if(!isDefined(rumblestruct)) {
    return;
  }

  height = rumblestruct.radius * 2;
  zoffset = -1 * rumblestruct.radius;
  areatrigger = spawn("trigger_radius", self.origin + (0, 0, zoffset), 0, rumblestruct.radius, height);
  areatrigger enablelinkTo();
  areatrigger linkTo(self);
  self.rumbletrigger = areatrigger;
  self endon("death");

  if(!isDefined(self.rumbleon)) {
    self.rumbleon = 1;
  }

  if(isDefined(rumblestruct.scale)) {
    self.rumble_scale = rumblestruct.scale;
  } else {
    self.rumble_scale = 0.15;
  }

  if(isDefined(rumblestruct.duration)) {
    self.rumble_duration = rumblestruct.duration;
  } else {
    self.rumble_duration = 4.5;
  }

  if(isDefined(rumblestruct.radius)) {
    self.rumble_radius = rumblestruct.radius;
  } else {
    self.rumble_radius = 600;
  }

  if(isDefined(rumblestruct.basetime)) {
    self.rumble_basetime = rumblestruct.basetime;
  } else {
    self.rumble_basetime = 1;
  }

  if(isDefined(rumblestruct.randomaditionaltime)) {
    self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
  } else {
    self.rumble_randomaditionaltime = 1;
  }

  areatrigger.radius = self.rumble_radius;

  while(true) {
    areatrigger waittill("trigger");

    if(vehicle_is_stopped() && !isDefined(self.forcerumble) || !self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(rumblestruct.rumble);

    if(isDefined(self.vehicletype)) {
      soundname = self.vehicletype + "_rumble_sfx";

      if(soundexists(soundname)) {
        level.player playSound(soundname);
      }
    }

    while(level.player istouching(areatrigger) && self.rumbleon && (!vehicle_is_stopped() || isDefined(self.forcerumble))) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime);
    }

    self stoprumble(rumblestruct.rumble);
  }
}

function vehicle_setteam() {
  classname = get_vehicle_classname();

  if(!isDefined(self.script_team) && isDefined(level.vehicle.templates.team[classname])) {
    self.script_team = level.vehicle.templates.team[classname];
  }
}

function vehicle_handleunloadevent() {
  self endon("death");
  type = self.vehicletype;

  if(!ent_flag_exist("unloaded")) {
    ent_flag_init("unloaded");
  }
}

function get_vehiclenode_any_dynamic(target) {
  path_start = getvehiclenode(target, "targetname");

  if(!isDefined(path_start)) {
    path_start = getEnt(target, "targetname");
  } else if(ishelicopter()) {
    println("<dev string:x4aa>" + path_start.targetname);
    println("<dev string:x4ca>" + self.vehicletype);

    assertmsg("<dev string:x4db>");
  }

  if(!isDefined(path_start)) {
    path_start = getStruct(target, "targetname");
  }

  return path_start;
}

function vehicle_damagelogic() {
  self endon("death");
  self.damage_functions = [];
  classname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.bullet_shield[classname]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level.vehicle.templates.bullet_shield[classname];
  }

  if(isDefined(level.vehicle.templates.grenade_shield[classname]) && !isDefined(self.script_grenadeshield)) {
    self.script_grenadeshield = level.vehicle.templates.grenade_shield[classname];
  }

  if(isDefined(level.vehicle.templates.collision_shield[classname]) && !isDefined(self.var_721298f6d1910c00)) {
    self.var_721298f6d1910c00 = level.vehicle.templates.collision_shield[classname];
  }

  self.healthbuffer = 100000;
  self.health += self.healthbuffer;
  self.healthactual = self.health;

  while(self.health > 0) {
    self.damageinfo = undefined;
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time);
    partname = scripts\common\vehicle::function_8ed0ffa3f8be7c75(partname);
    attachtagname = scripts\common\vehicle::function_8ed0ffa3f8be7c75(attachtagname);

    if(!flag("scriptables_ready")) {
      flag_wait("scriptables_ready");
    }

    flag_wait("scriptables_ready");
    damagedpartname = ter_op(attachtagname != "", attachtagname, partname);
    amount = function_8f700dc8e0d2fa89(amount, meansofdeath, time);

    if(!isDefined(meansofdeath) || !isexplosivedamage(meansofdeath, objweapon)) {
      amount = function_8dfb977adeef3436(amount);
    }

    self.damageinfo["amount"] = amount;
    self.damageinfo["attacker"] = attacker;
    self.damageinfo["direction_vec"] = direction_vec;
    self.damageinfo["damageLocation"] = damagelocation;
    self.damageinfo["MOD"] = meansofdeath;
    self.damageinfo["weapon"] = objweapon;

    if(istrue(self.custom_damage_handler)) {
      return;
    }

    foreach(func in self.damage_functions) {
      thread[[func]](amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon);
    }

    if(isDefined(attacker)) {
      attacker script_func("register_shot_hit");

      if(func_ref_exist("vehicle_damage_modifier")) {
        data = undefined;

        if(isDefined(level.fn_damage_pack)) {
          data = [[level.fn_damage_pack]](attacker, self, amount, objweapon, meansofdeath, undefined, damagelocation, direction_vec, modelname, partname, attachtagname, dflags);
        }

        if(isDefined(data)) {
          self.damage_data = data;
        } else {
          self.damage_data = undefined;
        }

        new_amount = script_func("vehicle_damage_modifier", data);

        if(isDefined(new_amount)) {
          amount = new_amount;
        }
      }
    }

    if(function_d7fe44ffb08b499a()) {
      thread function_a1df9e8f97742aaf("<dev string:x511>", 1, (0, 1, 0));

      self.health = self.healthactual;
    } else if(function_e9ed4f44f9d1d682(attacker)) {
      thread function_a1df9e8f97742aaf("<dev string:x519>" + self.script_team + "<dev string:x531>" + time, 1, (0, 1, 0));

      self.health = self.healthactual;
    } else if(function_c948f3a1e60efd61(attacker, meansofdeath, objweapon)) {
      thread function_a1df9e8f97742aaf("<dev string:x538>" + "<dev string:x531>" + time, 1, (0, 1, 0));

      self.health = self.healthactual;
    } else if(function_ba6c52398d8ba7fb(meansofdeath, objweapon)) {
      thread function_a1df9e8f97742aaf("<dev string:x54d>" + "<dev string:x531>" + time, 1, (0, 1, 0));

      self.health = self.healthactual;
    } else {
      if(function_f237c27c3ba6b34d(meansofdeath)) {
        thread function_a1df9e8f97742aaf("<dev string:x564>" + "<dev string:x531>" + time, 1, (0, 1, 0));

        self.health = self.healthactual;
      }

      if(isDefined(self.var_c543f8e941150b0b)) {
        part_hit = self[[self.var_c543f8e941150b0b]](damagedpartname, meansofdeath, damagelocation);

        if(isDefined(part_hit)) {
          if(isDefined(self.var_2352359ef3eefcd3)) {
            self thread[[self.var_2352359ef3eefcd3]](attacker, amount, part_hit, direction_vec, damagelocation);
          }

          if(isstartstr(part_hit, "tag_armor")) {
            amount = 0;
            self.health = self.healthactual;
          }
        }
      }

      if(utility::issp() && isDefined(meansofdeath)) {
        if(isDefined(objweapon) && function_2cffaf4e15c4ab48(getcompleteweaponname(objweapon)) || !function_b9ea9d0702abf6fd(self.health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor)) {
          if(meansofdeath == "MOD_MELEE") {
            function_a1ed6ce90e57bd32(amount, damagelocation, meansofdeath, objweapon, attacker);
          } else {
            thread function_b958f96bb17ec92d(damagedpartname, amount, meansofdeath, objweapon, attacker);
          }
        }
      }

      if(function_9e9dfc6f77569f4d()) {
        thread function_a1df9e8f97742aaf("<dev string:x57a>", 1, (0, 1, 0));

        self.health = self.healthactual;
      } else {
        self.healthactual = self.health;
        function_89cec1224ae724d5();
      }

      thread function_a1df9e8f97742aaf("<dev string:x585>" + self.damagestate + "<dev string:x596>" + self.healthactual, 1, (1, 0, 0));

      thread function_a1df9e8f97742aaf(meansofdeath + "<dev string:x5a3>" + amount + "<dev string:x5aa>" + self.explosivehits + "<dev string:x5be>" + damagedpartname + "<dev string:x5c5>" + self.healthactual + "<dev string:x531>" + time);
    }

    if(function_d7fe44ffb08b499a() || function_9e9dfc6f77569f4d()) {
      continue;
    }

    if(amount >= self.healthstarting * 2) {
      self notify("death", attacker, meansofdeath, objweapon, damagelocation);
    }

    if(self.damagestate == "damageHeavy") {
      if(self.health <= self.healthbuffer || function_4d5539ed20893df1()) {
        self notify("death", attacker, meansofdeath, objweapon, damagelocation);
      }

      continue;
    }

    if(isDefined(level.vehicle.templates.explosivehits[classname]) && function_4d5539ed20893df1()) {
      self notify("death", attacker, meansofdeath, objweapon, damagelocation);
    }

    if(ishelicopter() && function_4d5539ed20893df1()) {
      self notify("death", attacker, meansofdeath, objweapon, damagelocation);
    }

    healthpercentage = (self.health - self.healthbuffer) / self.healthstarting;

    if(function_4d5539ed20893df1()) {
      self.damagestate = "damageHeavy";
    } else if(healthpercentage <= 0.3) {
      self.damagestate = "damageHeavy";
    } else if(healthpercentage <= 0.65) {
      self.damagestate = "damageMedium";
    } else if(healthpercentage <= 0.9) {
      self.damagestate = "damageLight";
    } else {
      self.damagestate = "damagePristine";
    }

    thread function_a1df9e8f97742aaf("<dev string:x585>" + self.damagestate + "<dev string:x596>" + self.healthactual, 1, (1, 0, 0));

    if(self isscriptable() && self getscriptablehaspart(self.damagestate) && self getscriptablepartstate(self.damagestate, 1) != self.damagestate) {
      utility::function_3677f2be30fdd581(self.damagestate, "highSpeed");
    }

    if(self.damagestate == "damageHeavy") {
      vehicle_sethealth(self.healthstarting * 0.3);
      function_89cec1224ae724d5();
      self.var_1d8c9c9044eafcbc = gettime();
      self notify("vehicle_inBurndown");
      childthread function_a286aecf91c78efa();
    }
  }
}

function private function_8f700dc8e0d2fa89(amount, meansofdeath, time) {
  thread function_a1df9e8f97742aaf("<dev string:x5cc>" + time + "<dev string:x5e2>" + self.healthstarting + "<dev string:x5f8>", 0, (1, 0, 0.5));

  isbullet = undefined;

  if(isDefined(meansofdeath) && isendstr(meansofdeath, "_BULLET")) {
    isbullet = 1;
  } else {
    return amount;
  }

  scaledamount = undefined;

  if(istrue(level.var_1de5acbb26e97918)) {
    scaledamount = amount * level.var_1de5acbb26e97918;

    thread function_a1df9e8f97742aaf("<dev string:x5cc>" + time + "<dev string:x5e2>" + self.healthstarting + "<dev string:x60c>" + level.var_1de5acbb26e97918, 0, (1, 0, 0.5));
  }

  if(istrue(self.var_1de5acbb26e97918)) {
    scaledamount = amount * self.var_1de5acbb26e97918;

    thread function_a1df9e8f97742aaf("<dev string:x5cc>" + time + "<dev string:x5e2>" + self.healthstarting + "<dev string:x626>" + self.var_1de5acbb26e97918, 0, (1, 0, 0.5));
  }

  if(isDefined(scaledamount)) {
    addhealth(amount - scaledamount);
    amount = scaledamount;
  }

  return amount;
}

function private function_8dfb977adeef3436(amount) {
  if(self.damagestate == "damageHeavy") {
    addhealth(amount * 0.75);
    return (amount * 0.25);
  }

  return amount;
}

function private function_a183f52b983f5769(amount) {
  scaledamount = amount;

  if(istrue(level.var_bd79128b30a2dfb2)) {
    scaledamount = amount * level.var_bd79128b30a2dfb2;
  }

  if(istrue(self.var_bd79128b30a2dfb2)) {
    scaledamount = amount * self.var_bd79128b30a2dfb2;
  }

  return scaledamount;
}

function private function_4a5955251a67bfda(objweapon) {
  if(!isDefined(objweapon)) {
    return 1;
  }

  scaleweaponname = getweaponbasename(objweapon);
  scaledamount = 1;

  if(isDefined(level.var_b8e957f2bf26c5e5)) {
    foreach(entry in level.var_b8e957f2bf26c5e5) {
      if(entry[0] == scaleweaponname) {
        scaledamount = entry[1];
      }
    }
  }

  if(isDefined(self.var_b8e957f2bf26c5e5)) {
    foreach(entry in self.var_b8e957f2bf26c5e5) {
      if(entry[0] == scaleweaponname) {
        scaledamount = entry[1];
      }
    }
  }

  return scaledamount;
}

function function_a286aecf91c78efa() {
  self.ui_warning = 1;
  function_89cec1224ae724d5();
  healthinc = int((self.health - self.healthbuffer) / 30 / 0.25) + 1;

  while(gettime() - self.var_1d8c9c9044eafcbc < 30000) {
    countdown = 30000 - gettime() - self.var_1d8c9c9044eafcbc;

    thread function_a1df9e8f97742aaf("<dev string:x63f>" + countdown, 2, (1, 0, 1));

    vehicle_damage(healthinc, undefined, "MOD_EXECUTION");
    wait 1;
  }
}

function function_37a7cbb36025d760() {
  while(gettime() - self.var_1d8c9c9044eafcbc < 30000) {
    countdown = 30000 - gettime() - self.var_1d8c9c9044eafcbc;

    thread function_a1df9e8f97742aaf("<dev string:x63f>" + countdown, 2, (1, 0, 1));

    waitframe();
  }

  self notify("death");
}

function function_a1ed6ce90e57bd32(amount, damagelocation, meansofdeath, objweapon, attacker) {
  var_6071f029b63b07f6 = function_7bba68b7e28ec873(64, damagelocation, 1);

  foreach(part in var_6071f029b63b07f6) {
    switch (level.vehicle.damageableparts[part]) {
      case 5:
        break;
      default:
        var_6071f029b63b07f6 = array_remove(var_6071f029b63b07f6, part);
        break;
    }
  }

  var_6d8c939979ade635 = function_350e192b13bea45c(var_6071f029b63b07f6);

  if(isDefined(var_6d8c939979ade635) && distancesquared(damagelocation, self gettagorigin(var_6d8c939979ade635)) <= squared(64)) {
    thread function_b958f96bb17ec92d(var_6d8c939979ade635, amount, meansofdeath, objweapon, undefined, 1, damagelocation);
  }
}

function function_f8f1d017591e2c60(health, amount, meansofdeath, objweapon) {
  classname = get_vehicle_classname();
  assertex(isDefined(level.vehicle.templates.explosivehits[classname]), "<dev string:x64d>" + classname);

  if(amount >= 110 && (meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_PROJECTILE_SPLASH")) {
    hitsscale = function_4a5955251a67bfda(objweapon);

    if(level.vehicle.templates.explosivehits[classname] > 0) {
      healthreduction = self.healthstarting / level.vehicle.templates.explosivehits[classname] / 0.5 * hitsscale;
      function_cacd62db1bbe8cb9(amount);
      function_c8a94acef0beb362(healthreduction);
    }

    self.explosivehits += 0.5 * hitsscale;
    return true;
  } else if(amount >= 190 && (meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_EXECUTION")) {
    hitsscale = function_4a5955251a67bfda(objweapon);

    if(level.vehicle.templates.explosivehits[classname] > 0) {
      healthreduction = self.healthstarting / level.vehicle.templates.explosivehits[classname] / 1 * hitsscale;
      function_cacd62db1bbe8cb9(amount);
      function_c8a94acef0beb362(healthreduction);
    }

    self.explosivehits += 1 * hitsscale;
    return true;
  }

  return false;
}

function function_4d5539ed20893df1() {
  classname = get_vehicle_classname();
  assertex(isDefined(level.vehicle.templates.explosivehits[classname]), "<dev string:x64d>" + classname);

  if(level.vehicle.templates.explosivehits[classname] == 0) {
    if(self.explosivehits > level.vehicle.templates.explosivehits[classname]) {
      return true;
    }
  }

  if(level.vehicle.templates.explosivehits[classname] > 0 && self.explosivehits >= level.vehicle.templates.explosivehits[classname]) {
    return true;
  }

  return false;
}

function function_b9ea9d0702abf6fd(health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor) {
  if(function_f8f1d017591e2c60(health, amount, meansofdeath, objweapon)) {
    thread function_97de184a1b867545();
    var_10d73932d2ecd911 = function_7bba68b7e28ec873(undefined, damagelocation, 1);

    for(i = 0; i < var_10d73932d2ecd911.size; i++) {
      if(i == 4) {
        break;
      }

      if(isDefined(inflictor)) {
        thread function_b958f96bb17ec92d(var_10d73932d2ecd911[i], amount * 2, meansofdeath, objweapon, attacker, 1, inflictor.origin);
        continue;
      }

      thread function_b958f96bb17ec92d(var_10d73932d2ecd911[i], amount * 2, meansofdeath, objweapon, attacker, 1);
    }

    if(!istrue(self.skiplaunch) && isDefined(meansofdeath) && isexplosivedamage(meansofdeath, objweapon)) {
      thread function_80b9a13a5f971524(amount, direction_vec, damagelocation, meansofdeath);
    }

    return true;
  }

  return false;
}

function function_98c558b067cdd616() {
  if(isDefined(self.damageableparts)) {
    return;
  }

  self.damageableparts = [];

  for(i = 0; i < getnumparts(self.model); i++) {
    partname = getpartname(self.model, i);
    partname = scripts\common\vehicle::function_8ed0ffa3f8be7c75(partname);

    if(array_contains_key(level.vehicle.damageableparts, partname)) {
      self.damageableparts[partname] = level.vehicle.damageableparts[partname];
    }
  }
}

function function_97de184a1b867545() {
  if(!self isscriptable()) {
    return;
  }

  function_98c558b067cdd616();
  keys = getarraykeys(self.damageableparts);

  foreach(key in keys) {
    if(isstartstr(key, "tag_wind")) {
      self.damageableparts[key] = 0;
      utility::function_3677f2be30fdd581(key, "death");
    }
  }
}

function function_b958f96bb17ec92d(damagedpartname, amount, meansofdeath, objweapon, attacker, skipregen, origin, skiptire) {
  if(!isDefined(skipregen)) {
    skipregen = 0;
  }

  if(!isDefined(skiptire)) {
    skiptire = 0;
  }

  if(!isDefined(damagedpartname) || !array_contains_key(level.vehicle.damageableparts, damagedpartname)) {
    return;
  }

  if(isDefined(damagedpartname) && isDefined(self.var_9868a2f0e52a82bd) && array_contains(self.var_9868a2f0e52a82bd, damagedpartname)) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(self.origin, "<dev string:x671>" + damagedpartname, (1, 1, 1), 1, 0.2, 1000, 1);
    }

    return;
  }

  function_98c558b067cdd616();

  if(!skipregen) {
    addhealth(amount * 0.5);
  }

  hits = 0;

  if(isDefined(objweapon) && isDefined(objweapon.classname)) {
    if(!isDefined(meansofdeath) || meansofdeath != "MOD_IMPACT") {
      switch (objweapon.classname) {
        case #"hash_719417cb1de832b6":
          hits = 0.5;
          break;
        case #"hash_8cdaf2e4ecfe5b51":
          hits = 1;
          break;
        case #"hash_6191aaef9f922f96":
          hits = 4;
          break;
        case #"hash_61e969dacaaf9881":
        case #"hash_e224d0b635d0dadd":
          hits = 8;
          break;
      }
    }
  } else if(isDefined(meansofdeath)) {
    switch (meansofdeath) {
      case #"hash_b1078ff213fddba6":
        hits = 1;
        break;
      case #"hash_a5123f4d02745600":
        hits = 3;
        break;
      case #"hash_61e42661ac27b9f2":
        hits = self.damageableparts[damagedpartname];
        break;
    }
  }

  if(function_d44d56adf507094e(damagedpartname) && !isPlayer(attacker) || function_d44d56adf507094e(damagedpartname) && isai(attacker)) {
    hits *= 0.5;
  }

  if(issubstr(damagedpartname, "tag_wind") && isDefined(meansofdeath) && meansofdeath == "MOD_IMPACT" && isDefined(objweapon) && is_equal(objweapon.classname, "grenade")) {
    hits = 2;
  }

  if(function_d44d56adf507094e(damagedpartname) && skiptire) {
    hits = 0;
  }

  self.damageableparts[damagedpartname] -= hits;

  thread function_fe805ffb3ad24253(damagedpartname, hits, origin);

  if(self.damageableparts[damagedpartname] <= 0) {
    if(function_d44d56adf507094e(damagedpartname) && !skiptire) {
      if(isvehiclehusk() || getdvarint(@ "hash_f0f3e5a83f3f2843") && function_34a2eb36fbca6e89()) {
        numwheels = function_f18b042694d92f4();

        switch (damagedpartname) {
          case #"hash_176975cfc4da6ccf":
            function_b1aab60676c543fe(0, "fl");
            break;
          case #"hash_7882ec199836b440":
            function_b1aab60676c543fe(1, "fr");
            break;
          case #"hash_8990a9b7b683c2bd":
            function_b1aab60676c543fe(2, "ml");
            break;
          case #"hash_a4c07c681d7d1836":
            function_b1aab60676c543fe(3, "mr");
            break;
          case #"hash_e88679f8ff04aa03":
            if(numwheels > 4) {
              function_b1aab60676c543fe(4, "bl");
            } else {
              function_b1aab60676c543fe(2, "bl");
            }

            break;
          case #"hash_95f9a89e42cf970c":
            if(numwheels > 4) {
              function_b1aab60676c543fe(5, "br");
            } else {
              function_b1aab60676c543fe(3, "br");
            }

            break;
        }
      }
    }

    utility::function_3677f2be30fdd581(damagedpartname, "death");
    classname = get_vehicle_classname();

    if(isDefined(level.vehicle.templates.dependentparts[classname]) && isDefined(level.vehicle.templates.dependentparts[classname][damagedpartname])) {
      foreach(part in level.vehicle.templates.dependentparts[classname][damagedpartname]) {
        if(self.damageableparts[part] > 0) {
          utility::function_3677f2be30fdd581(part, "death");
        }
      }
    }

    return;
  }

  if(issubstr(damagedpartname, "tag_wind") && self.damageableparts[damagedpartname] <= 3) {
    utility::function_3677f2be30fdd581(damagedpartname, "webbed");
  }
}

function function_d44d56adf507094e(damagedpartname) {
  switch (damagedpartname) {
    case #"hash_176975cfc4da6ccf":
    case #"hash_7882ec199836b440":
    case #"hash_8990a9b7b683c2bd":
    case #"hash_95f9a89e42cf970c":
    case #"hash_a4c07c681d7d1836":
    case #"hash_e88679f8ff04aa03":
      return 1;
    default:
      return 0;
  }
}

function vehicle_isalive(vehicle) {
  if(!isDefined(vehicle)) {
    return false;
  }

  if(isDefined(vehicle.healthbuffer) && vehicle.health < vehicle.healthbuffer) {
    return false;
  }

  if(vehicle.health <= 0) {
    return false;
  }

  return true;
}

function grenadeshielded(type, objweapon) {
  if(!isDefined(self.script_grenadeshield)) {
    return 0;
  }

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "grenade")) {
    return 0;
  }

  if(isDefined(level.vehicle.templates.var_7412ca7553957e74[get_vehicle_classname()])) {
    if(array_contains(level.vehicle.templates.var_7412ca7553957e74[get_vehicle_classname()], getweaponbasename(objweapon))) {
      return 0;
    }
  }

  if(self.script_grenadeshield) {
    return 1;
  }

  return 0;
}

function bulletshielded(type) {
  if(!isDefined(self.script_bulletshield)) {
    return 0;
  }

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "bullet") || issubstr(type, "explosive")) {
    return 0;
  }

  if(self.script_bulletshield) {
    return 1;
  }

  return 0;
}

function explosive_bulletshielded(type) {
  if(!isDefined(self.script_explosive_bullet_shield)) {
    return 0;
  }

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "explosive")) {
    return 0;
  }

  if(self.script_explosive_bullet_shield) {
    return 1;
  }

  return 0;
}

function vehicle_should_regenerate(attacker, type, objweapon) {
  return function_f237c27c3ba6b34d(type) || function_e9ed4f44f9d1d682(attacker) || function_c948f3a1e60efd61(attacker, type, objweapon) || function_ba6c52398d8ba7fb(type);
}

function function_f237c27c3ba6b34d(type) {
  return type == "MOD_MELEE";
}

function function_e9ed4f44f9d1d682(attacker) {
  return !isDefined(attacker) && self.script_team != "neutral" || attacker_isonmyteam(attacker) || attacker_troop_isonmyteam(attacker) || is_invulnerable_from_ai(attacker);
}

function function_c948f3a1e60efd61(attacker, type, objweapon) {
  return isDefined(level.var_d1d6757f3c58e700) && [[level.var_d1d6757f3c58e700]](attacker, type, objweapon);
}

function function_ba6c52398d8ba7fb(type, objweapon) {
  return bulletshielded(type) || explosive_bulletshielded(type) || grenadeshielded(type, objweapon);
}

function is_invulnerable_from_ai(attacker) {
  if(!isDefined(self.script_ai_invulnerable)) {
    return 0;
  }

  if(isDefined(attacker) && isai(attacker) && self.script_ai_invulnerable == 1) {
    return 1;
  }

  return 0;
}

function attacker_troop_isonmyteam(attacker) {
  if(getdvarint(@ "hash_fb816855f6554343")) {
    return 0;
  }

  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(attacker) && isPlayer(attacker)) {
    return 1;
  }

  if(isai(attacker) && is_equal(attacker.team, self.script_team)) {
    return 1;
  }

  return 0;
}

function attacker_isonmyteam(attacker) {
  if(getdvarint(@ "hash_fb816855f6554343")) {
    return false;
  }

  if(isDefined(attacker) && isDefined(attacker.script_team) && isDefined(self.script_team) && attacker.script_team == self.script_team) {
    return true;
  }

  return false;
}

function vehicle_setwheeldirection(direction) {
  self.vehiclewheeldirection = ter_op(direction <= 0, 0, 1);
}

function vehicle_playexhausteffect() {
  self endon("entitydeleted");
  self endon("death");

  if(!isDefined(level.vehicle.templates.exhaust_fx[self.model])) {
    return;
  }

  while(true) {
    playFXOnTag(level.vehicle.templates.exhaust_fx[self.model], self, "tag_engine_exhaust");
    waitframe();
  }
}

function vehicle_playengineeffect() {
  enginefx = level.vehicle.templates.engine_fx[get_vehicle_classname()];

  if(!isDefined(enginefx)) {
    return;
  }

  effectdelay = 0.25;
  prev_effect = undefined;
  var_35c675f4f473ab8c = undefined;

  while(true) {
    if(!vehicle_isalive(self)) {
      return;
    }

    var_d1d99b2513672267 = enginefx.effect;
    var_35c675f4f473ab8c = enginefx.effect_tag;
    effort_ratio = self vehicle_getspeed() / self vehicle_gettopspeedforward();

    if(isDefined(self.enginefx_effort_scale)) {
      effort_ratio *= self.enginefx_effort_scale;
    }

    if(isDefined(enginefx.max_effort_effect) && effort_ratio >= enginefx.max_effort_ratio) {
      var_d1d99b2513672267 = enginefx.max_effort_effect;
    } else if(isDefined(enginefx.med_effort_effect) && effort_ratio >= enginefx.med_effort_ratio) {
      var_d1d99b2513672267 = enginefx.med_effort_effect;
    } else if(isDefined(enginefx.min_effort_effect) && effort_ratio >= enginefx.min_effort_ratio) {
      var_d1d99b2513672267 = enginefx.min_effort_effect;
    }

    if(!isDefined(prev_effect) || prev_effect != var_d1d99b2513672267) {
      if(isDefined(prev_effect)) {
        stopFXOnTag(prev_effect, self, var_35c675f4f473ab8c);
        waitframe();

        if(!vehicle_isalive(self)) {
          return;
        }
      }

      playFXOnTag(var_d1d99b2513672267, self, var_35c675f4f473ab8c);
      prev_effect = var_d1d99b2513672267;
    }

    wait effectdelay;
  }
}

function vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");

  if(ishelicopter()) {
    self setgoalyaw(flat_angle(self.angles)[1]);
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
    targets = noself_func_return("getspawnerarray", self.target);

    if(!isDefined(targets)) {
      targets = getStructArray(self.target, "targetname");
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

function setvehgoalpos_wrap(origin, bstop) {
  return _setvehgoalpos_wrap(origin, bstop);
}

function vehicle_liftoffvehicle(height) {
  if(!isDefined(height)) {
    height = 512;
  }

  destination = self.origin + (0, 0, height);
  self setneargoalnotifydist(10);
  setvehgoalpos_wrap(destination, 1);
  self waittill("goal");
}

function vehicle_shouldplaydeathanimation(vehicle) {
  if(!vehicle_hasdeathanimations(vehicle)) {
    return false;
  }

  if(istrue(self.vehicle_skipdeathanimation)) {
    return false;
  }

  return true;
}

function vehicle_hasdeathanimations(vehicle) {
  return isDefined(level.vehicle.templates.deathanimations[vehicle get_vehicle_classname()]);
}

function vehicle_getdeathanimation(vehicle, damagelocation) {
  deathanimations = level.vehicle.templates.deathanimations[vehicle get_vehicle_classname()];

  if(isDefined(damagelocation)) {
    centerofmass = vehicle getpointinbounds(0.5, 0.5, 0.5);
    var_4f61353d9ff59711 = damagelocation - centerofmass;
    directions = [];
    directions["forward"] = anglesToForward(vehicle.angles);
    directions["right"] = anglestoright(vehicle.angles);
    directions["backward"] = directions["forward"] * -1;
    directions["left"] = directions["right"] * -1;
    var_d65dafae56aa5229 = undefined;
    largestprojection = -999999;
    directionkeys = ["forward", "right", "backward", "left"];

    foreach(currentkey in directionkeys) {
      direction = directions[currentkey];
      currentprojection = math::scalar_projection(direction, var_4f61353d9ff59711);

      if(!isDefined(var_d65dafae56aa5229) || currentprojection > largestprojection) {
        var_d65dafae56aa5229 = currentkey;
        largestprojection = currentprojection;
      }
    }

    return deathanimations[var_d65dafae56aa5229];
  }

  return random(deathanimations);
}

function vehicle_playdeathanimation(deathanimation) {
  self vehicle_turnengineoff();
  self_func("vehicle_orientto", self.origin, self.angles, 0, 0);
  self useanimtree(#animtree);
  self animScripted("vehicle_playDeathAnimation", self.origin, self.angles, deathanimation);
  self setneargoalnotifydist(30);

  if(ishelicopter()) {
    self setvehgoalpos(self.origin, 1);
    self setgoalyaw(self.angles[1]);
  }
}

function vehicle_setcrashing(boolean) {
  self.vehiclecrashing = boolean;
}

function vehicle_docrash(attacker, cause) {
  if(istrue(self.vehicle_skipdeathcrash)) {
    return;
  }

  vehicle_setcrashing(1);
  var_b990362c13178e7d = getdvarint(@ "hash_31333fbc83a5058f") != 0 && ishelicopter() && self vehicle_isphysveh();

  if(self vehicle_isphysveh() && !var_b990362c13178e7d) {
    self vehphys_crash();

    if(!istrue(self.dontdisconnectpaths)) {
      self disconnectPaths();
    }

    while(!vehicle_iscorpse() && isDefined(self) && !vehicle_is_stopped()) {
      waitframe();
    }
  } else if(ishelicopter()) {
    thread vehicle_helicoptercrash(attacker, cause);
    self waittill("vehicle_crashDone");
  }

  vehicle_setcrashing(0);
}

function vehicle_helicoptercrash(attacker, cause) {
  if(isDefined(attacker) && isPlayer(attacker)) {
    self.original_attacker = attacker;
  }

  if(!isDefined(self)) {
    return;
  }

  detach_getoutrigs();
  thread helicopter_crash_move(attacker, cause);
}

function helicopter_crash_move(attacker, cause) {
  self endon("in_air_explosion");

  if(isDefined(self.perferred_crash_location)) {
    crashloc = self.perferred_crash_location;
  } else if(isDefined(level.vehicle.var_4bd4e750e5a8e895)) {
    crashloc = [[level.vehicle.var_4bd4e750e5a8e895]](self);
  } else {
    assertex(level.vehicle.helicopter_crash_locations.size > 0, "<dev string:x67f>");
    unusedlocations = get_unused_crash_locations();
    assertex(unusedlocations.size > 0, "<dev string:x6fc>");
    crashloc = getclosest(self.origin, unusedlocations);
  }

  assert(isDefined(crashloc));
  crashloc.claimed = 1;
  self notify("newpath");
  self notify("deathspin");
  indirect_zoff = 0;
  direct = 0;

  if(isDefined(crashloc.script_parameters) && crashloc.script_parameters == "direct") {
    direct = 1;
  }

  if(isDefined(self.heli_crash_indirect_zoff)) {
    direct = 0;
    indirect_zoff = self.heli_crash_indirect_zoff;
  }

  if(direct) {
    assert(isDefined(crashloc.radius));
    crash_speed = 40;
    self vehicle_setspeed(crash_speed, 15, 10);
    self setneargoalnotifydist(crashloc.radius);
    self setvehgoalpos(crashloc.origin, 0);
    thread helicopter_crash_flavor(crashloc.origin, crash_speed);
    waittill_any_2("goal", "near_goal");
    helicopter_crash_path(crashloc);
  } else {
    indirect_target = (crashloc.origin[0], crashloc.origin[1], self.origin[2] + indirect_zoff);

    if(isDefined(self.heli_crash_lead)) {
      indirect_target = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
      indirect_target = (indirect_target[0], indirect_target[1], indirect_target[2] + indirect_zoff);
    }

    crash_speed = 20;

    if(isDefined(self.crash_speed)) {
      crash_speed = self.crash_speed;
    }

    self vehicle_setspeed(crash_speed, 10, 10);
    self setneargoalnotifydist(350);
    self setvehgoalpos(indirect_target, 1);
    thread helicopter_crash_flavor(indirect_target, 40);

    for(msg = "blank"; msg != "death"; msg = "death") {
      msg = waittill_any_3("goal", "near_goal", "death");

      if(!isDefined(msg) && !isDefined(self)) {
        crashloc.claimed = undefined;
        self notify("vehicle_crashDone");
        return;
      }
    }

    self setvehgoalpos(crashloc.origin, 0);
    self waittill("goal");
    helicopter_crash_path(crashloc);
  }

  crashloc.claimed = undefined;
  self notify("stop_crash_loop_sound");
  self notify("vehicle_crashDone");
}

function helicopter_crash_path(crashloc) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(crashloc.target)) {
    crashloc = getStruct(crashloc.target, "targetname");
    assert(isDefined(crashloc));
    radius = 56;

    if(isDefined(crashloc.radius)) {
      radius = crashloc.radius;
    }

    self setneargoalnotifydist(radius);
    self setvehgoalpos(crashloc.origin, 0);
    waittill_any_2("goal", "near_goal");
  }
}

function helicopter_crash_flavor(target_origin, crash_speed) {
  self endon("vehicle_crashDone");
  self clearlookatent();

  if(soundexists("hind_helicopter_dying_loop")) {
    self playLoopSound("hind_helicopter_dying_loop");
  }

  style = 0;

  if(isDefined(self.preferred_crash_style)) {
    style = self.preferred_crash_style;

    if(self.preferred_crash_style < 0) {
      style_chance = [1, 2, 2];
      total = 5;
      rnd = randomint(total);
      chance = 0;

      foreach(i, val in style_chance) {
        chance += val;

        if(rnd < chance) {
          style = i;
          break;
        }
      }
    }
  }

  switch (style) {
    case 1:
      thread helicopter_crash_zigzag();
      break;
    case 2:
      thread helicopter_crash_directed(target_origin, crash_speed);
      break;
    case 3:
      thread helicopter_in_air_explosion();
      break;
    case 4:
      thread helicopter_pilot_death_explosion();
      break;
    case 0:
    default:
      thread helicopter_crash_rotate();
      break;
  }
}

function helicopter_in_air_explosion() {
  vehicleclassname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.vehicle_rocket_death_fx[vehicleclassname])) {
    deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[vehicleclassname];
    struct = deathfxstructs[2];

    if(isDefined(struct) && isDefined(struct.waitdelay)) {
      wait struct.waitdelay;
    }

    waitframe();
  }

  self notify("vehicle_crashDone");
  self notify("in_air_explosion");
}

function helicopter_pilot_death_explosion() {
  thread helicopter_crash_rotate();
  waittill_notify_or_timeout("goal", 5);
  self notify("flavor_done");
  thread helicopter_in_air_explosion();
}

function helicopter_unloading_watcher() {
  if(!ishelicopter()) {
    return;
  }

  self endon("vehicle_crashDone");
  self waittill("unloading");
  self.unloading = 1;
  self waittill("unloaded");
  self.unloading = 0;
}

function helicopter_crash_directed(target_origin, crash_speed) {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  angleoff = 90 * randomintrange(-2, 3);

  for(;;) {
    totarget = target_origin - self.origin;
    yaw = vectortoyaw(totarget);
    yaw += angleoff;
    self settargetyaw(yaw);
    wait 0.1;
  }
}

function helicopter_crash_zigzag() {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  dir = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    irand = randomintrange(20, 120);

    if(dir) {
      self settargetyaw(self.angles[1] + irand);
    } else {
      self settargetyaw(self.angles[1] - irand);
    }

    dir = 1 - dir;
    rtime = randomfloatrange(0.5, 1);
    wait rtime;
  }
}

function helicopter_crash_rotate() {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    irand = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + irand);
    wait 0.5;
  }
}

function get_unused_crash_locations() {
  unusedlocations = [];
  level.vehicle.helicopter_crash_locations = array_removeundefined(level.vehicle.helicopter_crash_locations);

  foreach(location in level.vehicle.helicopter_crash_locations) {
    if(isDefined(location.claimed)) {
      continue;
    }

    unusedlocations[unusedlocations.size] = location;
  }

  return unusedlocations;
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

function vehicle_setdeathmodel() {
  if(!isDefined(level.vehicle.templates.deathmodel[self.model])) {
    return;
  }

  if(istrue(self.vehicle_skipdeathmodel)) {
    return;
  }

  if(self isscriptable()) {
    if(ishelicopter()) {
      return;
    }

    deathmodel = spawn("script_model", self.origin);
    deathmodel.angles = self.angles;
    deathmodel setModel(level.vehicle.templates.deathmodel[self.model]);
    return;
  }

  self setModel(level.vehicle.templates.deathmodel[self.model]);
}

function function_1e9728e5e662aca3(husk) {
  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      if(!isDefined(rider)) {
        continue;
      }

      if(!isalive(rider)) {
        continue;
      }

      if(isDefined(rider._blackboard)) {
        vehicle = rider._blackboard.currentvehicle;
        position = rider._blackboard.var_9176cae5619d7fba;
      } else {
        vehicle = rider.ridingvehicle;
        position = rider.vehicle_position;
      }

      aianims = anim_pos(vehicle, position);

      if(isDefined(aianims) && isDefined(aianims.sittag)) {
        rider unlink();
      }

      rider linkTo(husk, aianims.sittag);
    }
  }
}

function function_5d04267dd0768069(quiet) {
  if(!isDefined(level.vehicle.husks)) {
    level.vehicle.husks = [];
  } else {
    level.vehicle.husks = array_removeundefined(level.vehicle.husks);
  }

  velocity = self vehicle_getvelocity();

  if(istrue(self.headondeath)) {
    velocity = self vehicle_getvelocity();
    velocity *= 5;
  }

  model = function_d0e99a4f0c29166e();
  colorvariation = "";

  if(issubstr(model, "::")) {
    colorvariation = strtok(model, "::")[0] + "::";
    model = strtok(model, "::")[1];

    if(!istrue(level.vehicle.templates.var_893da51cf12b2c8b[model])) {
      colorvariation = "";
    }
  }

  self notsolid();
  classname = get_vehicle_classname();
  husk = spawnVehicle(colorvariation + level.vehicle.templates.husk[model], "vehicle_husk", level.vehicle.templates.husktype[model], self.origin, self.angles, undefined, velocity);
  husk.isvehiclehusk = 1;
  husk.classname_mp = classname;
  husk vehicle_sethealth(level.vehicle.templates.life[classname] + 100000);
  husk.healthstarting = level.vehicle.templates.life[classname];
  husk.parentmodel = model;
  husk.explosivehits = 0;
  husk.isstationary = self.isstationary;
  husk.var_d9ecf3d795727bb = self.var_84bca5671c65c2aa;
  husk.var_1b84f0b023dd1ca7 = self.var_1b84f0b023dd1ca7;

  if(!husk hascomponent("animator")) {
    husk addcomponent("animator");
  }

  self notify("vehicle_huskCreation", husk);

  if(isDefined(self.var_27c9e774969793bc)) {
    husk thread[[self.var_27c9e774969793bc]]();
  }

  level.vehicle.husks = array_add(level.vehicle.husks, husk);

  if(isDefined(self.spawnflags) && (self.spawnflags & 8 || istrue(husk.isstationary))) {
    husk function_65aa053c077c003a(1);
  }

  husk function_9ce59aa48970a667();
  husk vehicle_turnengineoff();
  husk delaycall(0.05, &vehphys_crash);
  husk function_98c558b067cdd616();

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    print3d(husk.origin + (0, 0, 3), "<dev string:x75a>" + velocity, (0, 1, 1), 1, 0.2, 1000, 1);

    draw_arrow_time(husk.origin, husk.origin + velocity, (0, 1, 1), 1000);
  }

  if(istrue(self.var_1de5acbb26e97918)) {
    husk.var_1de5acbb26e97918 = self.var_1de5acbb26e97918;
  }

  if(!istrue(quiet)) {
    husk thread function_b43ab7b2056ecb9a();
  }

  if(!istrue(quiet) && !istrue(self.skiplaunch)) {
    husk thread vehicle_husklaunch(self, undefined, undefined);
  }

  husk thread function_835a3820d2ab0b74();

  husk thread disconnect_paths_whenstopped();
  husk thread function_fd3542824f9c1bd2();
  husk thread function_2d9c04d7fe4e6719(self);
  husk thread function_4286de11e406088f();

  if(isDefined(self.damageableparts)) {
    foreach(i, health in self.damageableparts) {
      if(health <= 0) {
        husk.damageableparts[i] = 0;
      }
    }
  }

  function_1e9728e5e662aca3(husk);
  return husk;
}

function function_18657584b6bd786a(quiet) {
  flag_wait("scriptables_ready");
  husk = function_5d04267dd0768069(quiet);
  self delete();
  return husk;
}

function function_b43ab7b2056ecb9a(state) {
  if(!self isscriptable()) {
    return;
  }

  if(!isDefined(state)) {
    state = "on";
  }

  utility::function_3677f2be30fdd581("damage_transition", state);
  utility::function_3677f2be30fdd581("floor_fire", state);

  if(!istrue(self.var_1b84f0b023dd1ca7)) {
    utility::function_3677f2be30fdd581("smoke_heavy", state);
  }
}

function vehicle_husklaunch(parent, vehicleref, spawndata, forcemultiplier) {
  if(!self vehicle_isphysveh()) {
    return;
  }

  if(istrue(self.isstationary)) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(self.origin, "<dev string:x76d>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    return;
  }

  if(isDefined(parent) && istrue(parent.var_880b13dde87ce358)) {
    return;
  }

  if(isDefined(parent) && istrue(parent.headondeath)) {
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

  if(isDefined(parent) && isDefined(parent.var_84bca5671c65c2aa) && gettime() - parent.var_84bca5671c65c2aa < 1000) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x791>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    damagestrength *= 0.1;
  }

  if(isDefined(damagedir)) {
    damagedir = (damagedir[0], damagedir[1], 0.25);
  } else {
    damagedir = (randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25), 0.25);
  }

  launchstrength = function_90f94b8850010576(damagestrength, damagemod, damagelocation, 0.3);

  if(isDefined(forcemultiplier)) {
    launchstrength *= forcemultiplier;
  }

  if(isDefined(vehicleref) && isDefined(level.sharedfuncs) && isDefined(level.sharedfuncs[vehicleref])) {
    var_fd0de3143acb9a42 = level.sharedfuncs[vehicleref]["vehicle_huskLaunch"];

    if(isDefined(var_fd0de3143acb9a42)) {
      self[[var_fd0de3143acb9a42]](spawndata.initialvelocity);

      if(isDefined(self.damagedir)) {
        damagedir = self.damagedir;
      }

      if(isDefined(self.launchstrength)) {
        launchstrength = self.launchstrength;
      }
    }
  }

  self function_e0201404a8b6f664(damagedir, launchstrength, 1);

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    print3d(damagelocation + (0, 0, 6), "<dev string:x7c7>" + gettime(), (1, 0, 1), 1, 0.2, 1000, 1);

    print3d(damagelocation + (0, 0, 3), "<dev string:x7d1>" + launchstrength, (1, 0, 1), 1, 0.2, 1000, 1);

    print3d(damagelocation + (0, 0, 0), "<dev string:x7eb>" + self function_3dda404001a83ee("<dev string:x7f5>") + "<dev string:x7fd>" + damagestrength, (1, 0, 1), 1, 0.2, 1000, 1);

    draw_arrow_time(damagelocation, damagelocation + anglesToForward(vectortoangles(damagedir)) * launchstrength, (1, 0, 1), 1000);
  }

  self.var_84bca5671c65c2aa = gettime();
}

function function_80b9a13a5f971524(amount, damagedir, damagelocation, meansofdeath) {
  if(!self vehicle_isphysveh()) {
    return;
  }

  if(istrue(self.isstationary)) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x80e>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    return;
  }

  if(self.healthactual <= self.healthbuffer + 1) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x82d>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    return;
  }

  if(isDefined(self.var_d9ecf3d795727bb) && gettime() - self.var_d9ecf3d795727bb < 1000) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x84d>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    amount *= 0.1;
  }

  if(!isDefined(self.var_84bca5671c65c2aa)) {
    self.var_84bca5671c65c2aa = gettime();
  } else if(gettime() - self.var_84bca5671c65c2aa < 1000) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(damagelocation + (0, 0, -3), "<dev string:x885>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    amount *= 0.1;
  }

  launchstrength = function_90f94b8850010576(amount, meansofdeath, damagelocation);
  damagedir = (damagedir[0], damagedir[1], 0.25);
  self function_e0201404a8b6f664(damagedir, launchstrength, 1);

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    print3d(damagelocation + (0, 0, 6), "<dev string:x7c7>" + gettime() + "<dev string:x8b6>" + self.var_84bca5671c65c2aa, (1, 0, 1), 1, 0.2, 1000, 1);

    print3d(damagelocation + (0, 0, 3), "<dev string:x8d4>" + launchstrength, (1, 0, 1), 1, 0.2, 1000, 1);

    print3d(damagelocation + (0, 0, 0), "<dev string:x7eb>" + self function_3dda404001a83ee("<dev string:x7f5>") + "<dev string:x7fd>" + amount, (1, 0, 1), 1, 0.2, 1000, 1);

    draw_arrow_time(damagelocation, damagelocation + anglesToForward(vectortoangles(damagedir)) * launchstrength, (1, 0, 1), 1000);
  }

  self.var_84bca5671c65c2aa = gettime();
}

function function_90f94b8850010576(amount, meansofdeath, damagelocation, launchscalar) {
  if(!isDefined(launchscalar)) {
    launchscalar = 1;
  }

  amount = ter_op(amount > 600, 600, amount);

  if(isDefined(meansofdeath)) {
    meansofdeath = tolower(meansofdeath);

    if(meansofdeath == "mod_projectile_splash") {
      amount *= 0.75;
    }
  }

  if(self hascomponent("p2p")) {
    amount *= 0.1;
  }

  mass = self function_3dda404001a83ee("mass");
  var_7002c1806613b11f = mass * 0.1 * launchscalar;
  normalizedamount = math::normalize_value(600, 0, amount);
  launchstrength = var_7002c1806613b11f * normalizedamount;

  if(istank()) {
    launchstrength *= 0.25;
  }

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    print3d(damagelocation + (0, 0, 9), "<dev string:x8ed>" + amount + "<dev string:x907>" + normalizedamount, (0, 1, 0), 1, 0.2, 1000, 1);
  }

  return launchstrength;
}

function function_2d9c04d7fe4e6719(parent) {
  if(self isscriptable()) {
    var_e72978aa7c06ee3c = ["tag_hood", "tag_antenna", "tag_mirror_left", "tag_mirror_right", "tag_bumper_front", "tag_bumper_back", "tag_windshield_front", "tag_windshield_front_pristine", "tag_windshield_front_web", "tag_windshield_back", "tag_window_front_left", "tag_window_front_right", "tag_window_back_left", "tag_window_back_right", "tag_window_back_left_corner", "tag_window_back_right_corner", "tag_window_sunroof", "tag_hubcap_front_left", "tag_hubcap_front_right", "tag_hubcap_back_left", "tag_hubcap_back_right", "tag_wheel_spare"];

    foreach(part in var_e72978aa7c06ee3c) {
      if(isDefined(parent.damageableparts) && isDefined(parent.damageableparts[part])) {
        if(parent.damageableparts[part] <= 0) {
          state = "hide";
        } else {
          self.damageableparts[part] = 0;
          state = "death";
        }

        utility::function_3677f2be30fdd581(part, state);
      }
    }

    var_de1af8851d79e89 = ["tag_door_front_left", "tag_door_front_right", "tag_door_back_left", "tag_door_back_right", "tag_bumper_front_damaged", "tag_bumper_back_damaged", "tag_light_front_left", "tag_light_front_right", "tag_light_front_left_2", "tag_light_front_right_2", "tag_light_back_left", "tag_light_back_right", "tag_light_back_left_2", "tag_light_back_right_2", "tag_light_top_left", "tag_light_top_right", "tag_light_front_middle", "tag_light_front_top", "tag_light_back_top", "tag_wheel_center_front_left", "tag_wheel_center_front_right", "tag_wheel_center_middle_left", "tag_wheel_center_middle_right", "tag_wheel_center_back_left", "tag_wheel_center_back_right"];

    foreach(part in var_de1af8851d79e89) {
      state = undefined;

      if(isDefined(parent.damageableparts) && isDefined(parent.damageableparts[part]) && parent.damageableparts[part] <= 0) {
        classname = get_vehicle_classname();

        if(function_d44d56adf507094e(part) && getdvarint(@ "hash_4bd69b09131419ca") == 1) {
          function_b958f96bb17ec92d(part, 0, "MOD_EXECUTION", undefined, level.player, 1, self gettagorigin(part), 0);
        } else {
          self.damageableparts[part] = 0;
          state = "hide";
        }
      } else if(isDefined(self.damageableparts) && isDefined(self.damageableparts[part]) && randomint(2) == 0) {
        classname = get_vehicle_classname();

        if(function_d44d56adf507094e(part) && getdvarint(@ "hash_4bd69b09131419ca") == 1) {
          function_b958f96bb17ec92d(part, 0, "MOD_EXECUTION", undefined, level.player, 1, self gettagorigin(part), 0);
        } else {
          self.damageableparts[part] = 0;
          state = "death";
        }
      }

      if(isDefined(state)) {
        utility::function_3677f2be30fdd581(part, state);
      }
    }

    return;
  }

  thread function_a1df9e8f97742aaf("<dev string:x91e>", 1, (1, 0, 0));
}

function function_f18b042694d92f4() {
  if(self tagexists("tag_wheel_center_middle_left")) {
    return 6;
  }

  return 4;
}

function function_b1aab60676c543fe(wheelnum, position) {
  if(!isDefined(self.var_488f0fc49178c96)) {
    self.var_488f0fc49178c96 = 0;
  }

  self.var_488f0fc49178c96 |= 1 << wheelnum;

  if(isDefined(self.driver) && isPlayer(self.driver)) {
    level.player setclientomnvar("ui_veh_flat_tire_mask", self.var_488f0fc49178c96);
  }

  classname = get_vehicle_classname();

  if(!isDefined(self.var_c3db265fefdb8d4)) {
    self.var_c3db265fefdb8d4 = [];
  }

  if(!array_contains(self.var_c3db265fefdb8d4, position)) {
    self blowuptire(wheelnum);
    self.var_c3db265fefdb8d4 = array_add(self.var_c3db265fefdb8d4, position);
    self notify("vehicle_tire_blown", position);
  }
}

function function_fd3542824f9c1bd2() {
  self endon("death");
  self endon("stop collision watcher");
  self vehphys_enablecollisioncallback(1);

  while(true) {
    self.collisioninfo = undefined;
    classname = get_vehicle_classname();
    self waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent, collzone);

    if(istrue(self.var_721298f6d1910c00)) {
      return;
    }

    self.collisioninfo["impulse"] = impulse;

    if(getdvarint(@ "hash_cfd8073837710cef")) {
      draw_angles(vectortoangles(normal), position, (0, 1, 0), 1000, 10);
      line(position, position + anglesToForward(vectortoangles(normal)) * -32, (1, 0, 0), 1, 0, 1000);
      line(position, self.origin, (0, 1, 1), 1, 0, 1000);
      print3d(self.origin + (0, 0, 3), classname, (0, 1, 1), 1, 0.2, 1000, 1);
      print3d(self.origin, "<dev string:x93d>" + impulse, (0, 1, 1), 1, 0.2, 1000, 0);
      print3d(self.origin + (0, 0, -3), "<dev string:x94a>" + collzone, (0, 1, 1), 1, 0.2, 1000, 0);

      if(isDefined(ent)) {
        print3d(self.origin + (0, 0, -6), "<dev string:x958>" + vectordot(anglesToForward(self.angles), anglesToForward(ent.angles)), (0, 1, 1), 1, 0.2, 1000, 0);
      }
    }

    if(isDefined(ent) && ent.code_classname == "script_vehicle" && isDefined(ent.collisioninfo) && isDefined(ent.collisioninfo["impulse"]) && ent.collisioninfo["impulse"] > impulse) {
      impulse = ent.collisioninfo["impulse"];
      self.collisioninfo["impulse"] = ent.collisioninfo["impulse"];
    }

    if(!function_d7fe44ffb08b499a() && impulse >= 0.15) {
      damage = impulse * 400;
      damagescaled = function_a183f52b983f5769(damage);
      var_6d8c939979ade635 = function_7bba68b7e28ec873(64, position, 0, 1);

      if(isDefined(var_6d8c939979ade635)) {
        if(getdvarint(@ "hash_cfd8073837710cef")) {
          classname = get_vehicle_classname();
          classname = getsubstr(classname, 19, classname.size);

          print3d(self gettagorigin(var_6d8c939979ade635), classname + "<dev string:x961>" + var_6d8c939979ade635 + "<dev string:x969>" + damagescaled, (1, 0, 0), 1, 0.2, 1000, 0);

          line(position, self gettagorigin(var_6d8c939979ade635), (1, 0, 0), 1, 0, 1000);
        }

        if(impulse > 0.8) {
          function_97de184a1b867545();
          var_10d73932d2ecd911 = function_7bba68b7e28ec873(1000, position, 1, 1);

          for(i = 0; i < var_10d73932d2ecd911.size; i++) {
            if(i == 5) {
              break;
            }

            thread function_b958f96bb17ec92d(var_10d73932d2ecd911[i], 0, "MOD_EXECUTION", undefined, level.player, 1, position, 1);
          }
        } else {
          thread function_b958f96bb17ec92d(var_6d8c939979ade635, 0, "MOD_IMPACT", undefined, level.player, 1, position, 1);
        }
      }

      if(!function_9e9dfc6f77569f4d() && !isvehiclehusk() && !ent isvehiclehusk()) {
        var_aa8369f87b6b7363 = function_ab048fa9b5ad972(ent, position, impulse, collzone);

        if(var_aa8369f87b6b7363 == 1) {
          vehicle_headondeath(ent);
        } else if(var_aa8369f87b6b7363 != 2) {
          vehicle_damage(damagescaled, undefined, "MOD_IMPACT");
        }
      }
    }

    if(isvehiclehusk() && isDefined(ent)) {
      if(!isDefined(self.var_6268d543216a4f2)) {
        self.var_6268d543216a4f2 = 0;
      }

      if(ent.code_classname == "script_vehicle") {
        self.var_6268d543216a4f2 += 1;
      }

      if(self.var_6268d543216a4f2 >= 5) {
        ents = self getlinkedchildren();
        ents = array_add(ents, self);
        array_delete(ents);
      }
    }

    wait 1;
  }
}

function function_ab048fa9b5ad972(ent, position, impulse, collzone) {
  if(ishelicopter() || ent ishelicopter()) {
    return 0;
  }

  if(isboat() || ent isboat()) {
    return 0;
  }

  if(getdvarint(@ "hash_7598045ee90e851d") == 1 && impulse > 0.4 && isDefined(ent.classname_mp) && isDefined(self.classname_mp) && isDefined(ent) && ent.code_classname == "script_vehicle" && ent function_5ae2b449b60714ca(position) && function_5ae2b449b60714ca(position) && vectordot(anglesToForward(self.angles), anglesToForward(ent.angles)) < -0.9 && collzone == 0) {
    if(!isDefined(level.vehicle.templates.explosivehits[self.classname_mp]) || !isDefined(level.vehicle.templates.explosivehits[ent.classname_mp])) {
      return 1;
    }

    if(level.vehicle.templates.explosivehits[self.classname_mp] < level.vehicle.templates.explosivehits[ent.classname_mp]) {
      return 1;
    }

    if(level.vehicle.templates.explosivehits[self.classname_mp] == level.vehicle.templates.explosivehits[ent.classname_mp]) {
      if(!isDefined(self.driver) || !isPlayer(self.driver)) {
        return 1;
      }
    }

    if(function_79a6e6e740893346() < self.healthstarting * 0.5) {
      return 1;
    }

    vehicle_damage(self.healthstarting * 0.5, undefined, "MOD_IMPACT");
    return 2;
  }

  return 0;
}

function function_5ae2b449b60714ca(point) {
  dot = 0;
  tag = "tag_wheel_center_front_left";

  if(!self tagexists("tag_wheel_center_front_left")) {
    print("<dev string:x971>");

    tag = "tag_origin";
  }

  to_point = point - self gettagorigin(tag);
  forward = anglesToForward(self.angles);
  dot = vectordot(to_point, forward);
  return dot > 0;
}

function vehicle_headondeath(ent) {
  if(getdvarint(@ "hash_cfd8073837710cef")) {
    classname = get_vehicle_classname();

    print3d(self.origin + (0, 0, 60), classname + "<dev string:x9b1>", (1, 0, 0), 1, 1, 1000, 1);
  }

  self.headondeath = 1;
  self notify("vehicle_headOnDeath");
  vehicle_kill(ent);
}

function function_7bba68b7e28ec873(alloweddist, damagelocation, returnarray, var_bf877db179e9611) {
  function_98c558b067cdd616();

  if(self.damageableparts.size == 0) {
    if(istrue(returnarray)) {
      return [];
    } else {
      return;
    }
  }

  parts = function_c7dde17f06deb794(self.damageableparts, damagelocation);

  foreach(i, part in parts) {
    if(self.damageableparts[part] <= 0) {
      parts = array_remove_index(parts, i, 1);
    }
  }

  if(istrue(var_bf877db179e9611)) {
    foreach(i, part in parts) {
      if(function_d44d56adf507094e(part)) {
        parts = array_remove_index(parts, i, 1);
      }
    }
  }

  firstpart = function_350e192b13bea45c(parts);
  firstpart = function_5aaaaa0dc9a36d29(firstpart);

  if(istrue(returnarray)) {
    return parts;
  }

  if(isDefined(firstpart) && distancesquared(damagelocation, self gettagorigin(firstpart)) <= squared(alloweddist)) {
    return firstpart;
  }

  if(istrue(returnarray)) {
    return [];
  }

  return;
}

function function_5aaaaa0dc9a36d29(part) {
  if(!isDefined(part)) {
    return undefined;
  }

  if(part == "tag_bumper_front_damaged" || part == "tag_bumper_back_damaged") {
    var_ffc85e3083340fe6 = getsubstr(part, 0, part.size - 8);

    if(utility::function_35c178c80fa19cbd(var_ffc85e3083340fe6, "death")) {
      return part;
    }

    return var_ffc85e3083340fe6;
  }
}

function function_c7dde17f06deb794(array, damagelocation) {
  assertex(isDefined(array), "<dev string:x9c3>");
  self.partdamagelocation = damagelocation;
  keys = getarraykeys(array);
  keys = array_sort_with_func(keys, &part_distance);
  return keys;
}

function part_distance(parta, partb) {
  return distancesquared(self gettagorigin(parta), self.partdamagelocation) < distancesquared(self gettagorigin(partb), self.partdamagelocation);
}

function function_4286de11e406088f() {
  self notify("stop_damageLogic");
  self endon("death");
  self endon("stop_damageLogic");

  thread function_a1df9e8f97742aaf("<dev string:x9d9>", 2, (0, 1, 1));

  while(self.health > 0) {
    self.damageinfo = undefined;
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time);
    partname = scripts\common\vehicle::function_8ed0ffa3f8be7c75(partname);
    attachtagname = scripts\common\vehicle::function_8ed0ffa3f8be7c75(attachtagname);
    damagedpartname = ter_op(attachtagname != "", attachtagname, partname);
    amount = function_8f700dc8e0d2fa89(amount, meansofdeath, time);
    self.damageinfo["amount"] = amount;
    self.damageinfo["attacker"] = attacker;
    self.damageinfo["direction_vec"] = direction_vec;
    self.damageinfo["damageLocation"] = damagelocation;
    self.damageinfo["MOD"] = meansofdeath;
    self.damageinfo["weapon"] = objweapon;

    if(function_d7fe44ffb08b499a()) {
      thread function_a1df9e8f97742aaf("<dev string:x511>", 1, (0, 1, 0));

      self.health = self.healthactual;
      continue;
    }

    if(!function_b9ea9d0702abf6fd(self.health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor)) {
      thread function_a1df9e8f97742aaf(meansofdeath + "<dev string:x5a3>" + amount + "<dev string:x5be>" + damagedpartname + "<dev string:x5c5>" + self.health + "<dev string:x531>" + time);

      if(meansofdeath == "MOD_MELEE") {
        function_a1ed6ce90e57bd32(amount, damagelocation, meansofdeath, objweapon, attacker);
      } else {
        thread function_b958f96bb17ec92d(damagedpartname, amount, meansofdeath, objweapon, attacker);
      }
    }

    if(function_9e9dfc6f77569f4d()) {
      thread function_a1df9e8f97742aaf("<dev string:x57a>", 1, (0, 1, 0));

      self.health = self.healthactual;
      continue;
    }

    self.healthactual = self.health;
  }
}

function function_835a3820d2ab0b74() {
  self endon("death");

  if(!isDefined(self.damagedebuginfo)) {
    self.damagedebuginfo = spawnStruct();
    self.damagedebuginfo.text[0] = "";
    self.damagedebuginfo.color[0] = (1, 1, 1);
    self.damagedebuginfo.text[1] = "";
    self.damagedebuginfo.color[1] = (1, 1, 1);
    self.damagedebuginfo.text[2] = "";
    self.damagedebuginfo.color[2] = (1, 1, 1);
  }

  for(;;) {
    if(!getdvarint(@ "hash_cfd8073837710cef")) {} else {
      zoffset = 70;

      for(i = 0; i < self.damagedebuginfo.text.size; i++) {
        if(isDefined(self.damagedebuginfo.text[i])) {
          zoffset -= 3;

          print3d(self.origin + (0, 0, zoffset), self.damagedebuginfo.text[i], self.damagedebuginfo.color[i], 1, 0.2, 1, 1);
        }
      }
    }

    waitframe();
  }
}

function function_a1df9e8f97742aaf(text, linenum, color, bone) {
  if(!isDefined(self.damagedebuginfo)) {
    self.damagedebuginfo = spawnStruct();
  }

  if(!isDefined(self.var_4eb5f18e4aff3101)) {
    self.var_4eb5f18e4aff3101 = 0;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  queuesize = 12;

  if(!isDefined(linenum)) {
    linenum = 3;

    if(self.var_4eb5f18e4aff3101 < queuesize) {
      self.var_4eb5f18e4aff3101 += 1;
    }

    for(i = queuesize; i > linenum; i--) {
      self.damagedebuginfo.text[i] = self.damagedebuginfo.text[i - 1];
      self.damagedebuginfo.color[i] = self.damagedebuginfo.color[i - 1];
    }
  }

  self.damagedebuginfo.text[linenum] = text;
  self.damagedebuginfo.color[linenum] = color;
}

function function_fe805ffb3ad24253(damagedpartname, amount, origin) {
  self notify("<dev string:x9e2>" + damagedpartname);
  self endon("<dev string:x9f1>");
  self endon("<dev string:x9e2>" + damagedpartname);
  originoffset = undefined;

  if(isDefined(origin)) {
    originoffset = origin - self.origin;
  }

  time = gettime();

  for(;;) {
    if(!getdvarint(@ "hash_cfd8073837710cef")) {} else {
      if(gettime() - time > 10000) {
        break;
      }

      if(isDefined(originoffset)) {
        line(self.origin + originoffset, self gettagorigin(damagedpartname, 1), (1, 1, 1), 1, 0, 1);
      }

      print3d(self gettagorigin(damagedpartname, 1), damagedpartname + "<dev string:x5a3>" + amount + "<dev string:x5c5>" + self.damageableparts[damagedpartname] + "<dev string:x531>" + time, (1, 1, 1), 1, 0.2, 1, 1);
    }

    waitframe();
  }
}

function function_ceca0fbe6b37349a() {
  self endon("death");
  flag_wait("scriptables_ready");

  while(true) {
    level.player waittill("ads_pressed");

    if(isDefined(self.driver) && isPlayer(self.driver)) {
      ontime = gettime();
      vehicle_lights_on("brakelights");
      level.player waittill("ads_released");

      if(gettime() - ontime < 300) {
        wait 0.3;
      }

      vehicle_lights_on("daylights");
    }
  }
}

function function_c2b5282b537a56bc() {
  if(!self isscriptable()) {
    return;
  }

  self endon("death");
  flag_wait("scriptables_ready");

  if(!self getscriptablehaspart("flag")) {
    return;
  }

  while(true) {
    velocityspeed = length(self vehicle_getvelocity()) / 17.6;

    if(velocityspeed > 35) {
      utility::function_3677f2be30fdd581("flag", "fast");
    } else if(velocityspeed > 7) {
      utility::function_3677f2be30fdd581("flag", "medium");
    } else if(velocityspeed > 2) {
      utility::function_3677f2be30fdd581("flag", "slow");
    } else {
      utility::function_3677f2be30fdd581("flag", "stopped");
    }

    wait 0.1;
  }
}

function init_vehicle_spawner_devgui() {
  setdvarifuninitialized(@ "hash_e73c951b937ce2c2", "<dev string:x9fa>");
  function_a9a864379a098ad6("<dev string:x9fe>", "<dev string:xa28>", &function_48d05ac8c8af934f, 0, 2);
  var_11f099113be884b5 = function_e3b6f7bd4cb6ce92();
  ground_vehicles = [];
  water_vehicles = [];
  air_vehicles = [];

  if(isDefined(var_11f099113be884b5)) {
    foreach(var_31e4e9a915c4851 in var_11f099113be884b5) {
      if(isDefined(var_31e4e9a915c4851.type) && isDefined(var_31e4e9a915c4851.model)) {
        if(var_31e4e9a915c4851.type == "<dev string:xa41>") {
          ground_vehicles[ground_vehicles.size] = var_31e4e9a915c4851;
          continue;
        }

        if(var_31e4e9a915c4851.type == "<dev string:xa4b>") {
          water_vehicles[water_vehicles.size] = var_31e4e9a915c4851;
          continue;
        }

        if(var_31e4e9a915c4851.type == "<dev string:xa54>") {
          air_vehicles[air_vehicles.size] = var_31e4e9a915c4851;
        }
      }
    }
  }

  function_6e7290c8ee4f558b("<dev string:xa5b>");

  for(index = 0; index < ground_vehicles.size; index++) {
    vehicletype = function_3c8848a3a11b2553(ground_vehicles[index].vehicletype);
    function_b23a59dfb4ca49a1(vehicletype, "<dev string:xa8e>" + vehicletype, &function_24af60cc7030872d);
  }

  function_fe953f000498048f();
  function_6e7290c8ee4f558b("<dev string:xab2>");

  for(index = 0; index < water_vehicles.size; index++) {
    vehicletype = function_3c8848a3a11b2553(water_vehicles[index].vehicletype);
    function_b23a59dfb4ca49a1(vehicletype, "<dev string:xa8e>" + vehicletype, &function_24af60cc7030872d);
  }

  function_fe953f000498048f();
  function_6e7290c8ee4f558b("<dev string:xae4>");

  for(index = 0; index < air_vehicles.size; index++) {
    vehicletype = function_3c8848a3a11b2553(air_vehicles[index].vehicletype);
    function_b23a59dfb4ca49a1(vehicletype, "<dev string:xa8e>" + vehicletype, &function_24af60cc7030872d);
  }

  function_fe953f000498048f();
}

function function_48d05ac8c8af934f() {
  vehicletype = getDvar(@ "hash_e73c951b937ce2c2", "<dev string:x9fa>");

  if(vehicletype != "<dev string:x9fa>") {
    player = level.players[0];

    if(!isDefined(player)) {
      return;
    }

    forward = anglesToForward(player.angles);
    spawnposition = player.origin + (0, 0, 100) + forward * 300;
    spawnangles = player.angles * (0, 1, 0);
    vehicle = spawnVehicle(undefined, "<dev string:xb14>", vehicletype, spawnposition, spawnangles);

    if(!isDefined(vehicle.interactdata)) {
      vehicle makeusable();
    }
  }
}

function function_24af60cc7030872d(param) {
  vehicletype = param[0];
  setDvar(@ "hash_e73c951b937ce2c2", vehicletype);
  iprintln("<dev string:xb2b>" + vehicletype);
}

# /