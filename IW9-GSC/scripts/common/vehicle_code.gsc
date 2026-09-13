/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_code.gsc
***********************************************/

vehicle_initlevelvariables() {
  setdvarifuninitialized("dvar_9403D7D31FC1D981", 1);
  setdvarifuninitialized("dvar_FB816855F6554343", 0);
  setdvarifuninitialized("scr_vehicle_husk", 0);
  setdvarifuninitialized("dvar_9CDCAF7A53494C37", 0);
  setdvarifuninitialized("dvar_CFD8073837710CEF", 0);
  setdvarifuninitialized("dvar_0A56728DAA842E5E", 0);
  setdvarifuninitialized("dvar_F0F3E5A83F3F2843", 1);
  setdvarifuninitialized("dvar_7598045EE90E851D", 1);
  setdvarifuninitialized("dvar_4BD69B09131419CA", 1);
  setdvarifuninitialized("ai_debugvehicleinfo", 0);

  if(scripts\common\utility::issp()) {
    setsaveddvar("movingplatformcinematicmotion", 1);
    setsaveddvar("useextendedcinematicmotion", 1);
  }

  if(!isDefined(level.vehicle))
    level.vehicle = spawnStruct();

  level.vehicle.templates = spawnStruct();
  level.vehicle.helicopter_crash_locations = getEntArray("helicopter_crash_location", "targetname");
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("helicopter_crash_location", "targetname"));
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
  level.vehicle.templates._id_7412CA7553957E74 = [];
  level.vehicle.templates.bullet_shield = [];
  level.vehicle.templates._id_4356B75E0EDDF77D = [];
  level.vehicle.templates.death_jolt = [];
  level.vehicle.templates.death_badplace = [];
  level.vehicle.templates.idle_anim = [];
  level.vehicle.templates.helicopter_list = [];
  level.vehicle.templates._id_91F3271E71001190 = [];
  level.vehicle.templates.airplane_list = [];
  level.vehicle.templates._id_27719D9C0BC9708A = [];
  level.vehicle.templates.single_tread_list = [];
  level.vehicle.templates.deathanimations = [];
  level.vehicle.templates.vehicle_death_fx = [];
  level.vehicle.templates.vehicle_rocket_death_fx = [];
  level.vehicle.templates.death_radiusdamage = [];
  level.vehicle.templates.model = [];
  level.vehicle.templates._id_FB41D1CA75009BF0 = [];
  level.vehicle.templates._id_893DA51CF12B2C8B = [];
  level.vehicle.templates._id_95742F5C97192175 = [];
  level.vehicle.templates._id_445AD4FF08E86D9E = [];
  level.vehicle.templates._id_A72227C6BFA8A146 = [];

  if(scripts\common\utility::issp()) {
    level.vehicle._id_AAB9695C92B0ED96["tag_mirror_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_mirror_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_front_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_front_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_front_left_2"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_front_right_2"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_back_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_back_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_back_left_2"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_back_right_2"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_top_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_top_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_front_middle"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_front_top"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_light_back_top"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_antenna"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_hubcap_front_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_hubcap_front_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_hubcap_back_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_hubcap_back_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_windshield_front"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_windshield_front_pristine"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_windshield_front_web"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_windshield_back"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_window_front_left"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_window_front_right"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_window_back_left"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_window_back_right"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_window_back_left_corner"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_window_back_right_corner"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_window_sunroof"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_door_front_left"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_door_front_right"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_door_back_left"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_door_back_right"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_hood"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_trunk"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_bumper_front"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_bumper_back"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_bumper_front_damaged"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_bumper_back_damaged"] = 5;
    level.vehicle._id_AAB9695C92B0ED96["tag_wheel_center_front_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_wheel_center_front_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_wheel_center_middle_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_wheel_center_middle_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_wheel_center_back_left"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_wheel_center_back_right"] = 3;
    level.vehicle._id_AAB9695C92B0ED96["tag_wheel_spare"] = 3;

    foreach(name, _ in level.vehicle._id_AAB9695C92B0ED96)
    scripts\common\vehicle::_id_9039B650FFB212C8(name);
  }
}

_id_957AE339752B129E(amount) {
  if(amount < 0) {
    return;
  }
  self.health = self.health + int(amount);
}

isexplosivedamage(mod, objweapon) {
  if(isDefined(objweapon) && isDefined(objweapon.basename)) {
    switch (objweapon.basename) {
      case "gunship_25mm_sp_compound":
      case "gunship_25mm_sp_ambush":
        if(getdvarint("dvar_CFD8073837710CEF"))
          iprintln("skipping explosive damage for weapon: " + objweapon.basename);

        return 0;
    }
  }

  if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE")
    return 1;

  return 0;
}

_id_2CFFAF4E15C4AB48(weaponname) {
  if(!isDefined(self._id_11BD2D454480B300))
    return 0;

  if(scripts\engine\utility::array_contains(self._id_11BD2D454480B300, weaponname))
    return 1;

  return 0;
}

_getvehiclespawnerarray(value, key) {
  _id_BFC65A378A6D8EFE = [];

  if(isDefined(value) && isDefined(key)) {
    _id_28AF6061170E7CC7 = 1;
    vehicles = getEntArray(value, key);
  } else {
    _id_28AF6061170E7CC7 = 0;
    vehicles = getEntArray("script_vehicle", "code_classname");
  }

  foreach(vehicle in vehicles) {
    if(_id_28AF6061170E7CC7 && vehicle.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(vehicle))
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = vehicle;
  }

  return _id_BFC65A378A6D8EFE;
}

_kill_fx_play_direction(_id_2B784F12869DA5F8, lerp) {
  if(isDefined(_id_2B784F12869DA5F8) && isDefined(lerp)) {
    velocity = self getentityvelocity();
    velocity = vectorNormalize(velocity);
    _id_2B784F12869DA5F8 = vectorNormalize(_id_2B784F12869DA5F8);
    dir = vectorlerp(velocity, _id_2B784F12869DA5F8, lerp);
    return dir;
  } else
    return undefined;
}

_mainturretoff() {
  self.script_turretmain = 0;

  if(!isDefined(self.mainturret)) {
    return;
  }
  _turretoffshared(self.mainturret);
}

_mainturreton() {
  self.script_turretmain = 1;

  if(!isDefined(self.mainturret)) {
    return;
  }
  _turretonshared(self.mainturret);
}

_mgoff() {
  self.script_turretmg = 0;

  if(scripts\common\vehicle::ishelicopter() && hashelicopterturret()) {
    if(isDefined(level.chopperturretfunc)) {
      self thread[[level.chopperturretofffunc]]();
      return;
    }
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(_id_AC0E594AC96AA3A8, turret in self.mgturret)
  _turretoffshared(turret);
}

_mgon() {
  self.script_turretmg = 1;

  if(scripts\common\vehicle::ishelicopter() && hashelicopterturret()) {
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

_turretoffshared(turret) {
  if(isDefined(turret.script_fireondrones))
    turret.script_fireondrones = 0;

  turret setmode("manual");
}

_turretonshared(turret) {
  if(isDefined(turret.script_fireondrones))
    turret.script_fireondrones = 1;

  if(isDefined(turret.defaultonmode)) {
    if(turret.defaultonmode != "sentry")
      turret setmode(turret.defaultonmode);
  } else
    turret setmode("auto_nonai");

  set_turret_team(turret);
}

_setvehgoalpos_wrap(origin, _id_56BF21256ACD1819) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self.originheightoffset))
    origin = origin + (0, 0, self.originheightoffset);

  self setvehgoalpos(origin, _id_56BF21256ACD1819);
}

_vehicle_landvehicle(_id_44760E645D6BE134, node) {
  self endon("death");
  self notify("newpath");

  if(!isDefined(_id_44760E645D6BE134))
    _id_44760E645D6BE134 = 2;

  self setneargoalnotifydist(_id_44760E645D6BE134);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(scripts\engine\utility::flat_angle(self.angles)[1]);

  if(isDefined(self.unload_land_offset))
    _setvehgoalpos_wrap(scripts\common\utility::groundpos(self.origin) + (0, 0, self.unload_land_offset), 1);
  else
    _setvehgoalpos_wrap(scripts\common\utility::groundpos(self.origin), 1);

  self waittill("goal");
}

_vehicle_unload(_id_FA8D840338038893) {
  self endon("death");

  if(isDefined(_id_FA8D840338038893))
    self.unload_group = _id_FA8D840338038893;

  if(isDefined(self._id_E477B04AE71253D8)) {
    result = self[[self._id_E477B04AE71253D8]]();

    if(isDefined(result))
      return result;
  }

  if(isDefined(level.func["vehicle_unload"])) {
    result = self[[level.func["vehicle_unload"]]]();

    if(isDefined(result))
      return result;
  }

  if(scripts\engine\utility::ent_flag_exist("no_riders_until_unload")) {
    scripts\engine\utility::ent_flag_set("no_riders_until_unload");
    ai = spawn_unload_group(self.unload_group);

    foreach(a in ai)
    scripts\common\ai::spawn_failed(a);

    waittillframeend;
  }

  self notify("unloading");
  ai = [];
  unloadgroups = level.vehicle.templates.unloadgroups[get_vehicle_classname()];

  if(isDefined(unloadgroups)) {
    _id_CE621A37EDDE9CB9 = scripts\common\vehicle_aianim::get_unload_group();

    if(istrue(self.vehiclesetuprope)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.vehicle.templates.aianims[get_vehicle_classname()].size; _id_AC0E594AC96AA3A8++) {
        _id_C458EDAC96D58B16 = level.vehicle.templates.aianims[get_vehicle_classname()][_id_AC0E594AC96AA3A8];

        if(istrue(_id_C458EDAC96D58B16.setuprope)) {
          _id_43B3EF9D0A31EBAB = 0;

          foreach(rider in self.riders) {
            if(isDefined(rider.vehicle_position) && isDefined(_id_CE621A37EDDE9CB9[rider.vehicle_position]) && rider.vehicle_position != _id_AC0E594AC96AA3A8) {
              _id_7F54A8F82A6EE298 = scripts\common\vehicle_aianim::anim_pos(self, rider.vehicle_position);

              if(_id_7F54A8F82A6EE298.fastroperig == _id_C458EDAC96D58B16.fastroperig) {
                _id_43B3EF9D0A31EBAB = 1;
                break;
              }
            }
          }

          if(_id_43B3EF9D0A31EBAB) {
            foreach(rider in self.riders) {
              if(isalive(rider) && isDefined(rider.vehicle_position) && rider.vehicle_position == _id_AC0E594AC96AA3A8) {
                scripts\common\vehicle_aianim::guy_setup_rope(rider, _id_C458EDAC96D58B16);
                break;
              }
            }
          }
        }
      }
    }

    _id_3F5E5EE34D09EFDD = 0;

    foreach(rider in self.riders) {
      if(isalive(rider) && isDefined(rider.vehicle_position) && isDefined(_id_CE621A37EDDE9CB9[rider.vehicle_position])) {
        if(isDefined(level.vehicle.aianimcheck["unload"]) && ![[level.vehicle.aianimcheck["unload"]]](rider, rider.vehicle_position)) {
          continue;
        }
        _id_C458EDAC96D58B16 = scripts\common\vehicle_aianim::anim_pos(self, rider.vehicle_position);

        if(isDefined(_id_C458EDAC96D58B16) && istrue(_id_C458EDAC96D58B16.do_not_unload)) {
          continue;
        }
        if(isDefined(level.vehicle.aianimthread["unload"])) {
          if(!istrue(_id_C458EDAC96D58B16.setuprope)) {
            rider notify("newanim");
            thread[[level.vehicle.aianimthread["unload"]]](rider, rider.vehicle_position);
            _id_3F5E5EE34D09EFDD = 1;
            rider notify("unload");
            rider.vehicle = undefined;

            if(isDefined(_id_C458EDAC96D58B16.mgturret))
              rider scripts\common\ai::stop_use_turret();

            ai = scripts\engine\utility::array_add(ai, rider);
          }
        }
      }
    }

    if(!_id_3F5E5EE34D09EFDD)
      scripts\engine\utility::ent_flag_set("unloaded");
  }

  return ai;
}

vehicle_spawn_internal(vspawner) {
  if(isDefined(vspawner.script_delay_spawn)) {
    vspawner endon("death");
    wait(vspawner.script_delay_spawn);
  }

  _id_108BA48017B681F7 = 0;

  if(!scripts\common\utility::issp())
    vehicle = vehicle_spawn_mp_internal(vspawner);
  else {
    targetname = scripts\engine\utility::_id_53C4C53197386572(vspawner.targetname, "");
    model = vspawner _id_D0E99A4F0C29166E();

    if(isDefined(vspawner._id_AE43938336BBD264)) {
      array = strtok(vspawner._id_AE43938336BBD264, ",");
      color = array[randomintrange(0, array.size)];

      if(color != "base")
        model = color + "::" + model;
    }

    vehicletype = vspawner.vehicletype;

    if(getdvarint("dvar_0A56728DAA842E5E") && isDefined(level.vehicle.templates._id_95742F5C97192175[vspawner.classname]))
      vehicletype = level.vehicle.templates._id_95742F5C97192175[vspawner.classname];

    vehicle = spawnVehicle(model, targetname, vehicletype, vspawner.origin, vspawner.angles);
    vehicle.classname_mp = vspawner.classname;

    if(isDefined(vspawner.spawnflags) && vspawner.spawnflags & 16)
      vehicle._id_A784428198C5658B = 1;

    if(isDefined(vspawner.spawnflags) && vspawner.spawnflags & 4) {
      _id_FB41D1CA75009BF0 = vehicle _id_18657584B6BD786A(1);
      return _id_FB41D1CA75009BF0;
    }

    if(isDefined(vspawner.spawnflags)) {
      if(vspawner.spawnflags & 1)
        vehicle thread scripts\engine\utility::script_func("vehicle_usable");

      if(vspawner.spawnflags & 8 || istrue(vehicle._id_A784428198C5658B))
        vehicle _meth_65AA053C077C003A(1);
    }

    if(isDefined(vspawner.target))
      vehicle.target = vspawner.target;

    if(isDefined(vspawner.script_noteworthy))
      vehicle.script_noteworthy = vspawner.script_noteworthy;

    if(isDefined(vspawner.script_parameters))
      vehicle.script_parameters = vspawner.script_parameters;

    if(isDefined(vspawner.script_linkto))
      vehicle.script_linkto = vspawner.script_linkto;

    if(isDefined(vspawner.script_godmode))
      vehicle.script_godmode = vspawner.script_godmode;

    if(isDefined(vspawner.script_index))
      vehicle.script_index = vspawner.script_index;

    if(isDefined(vspawner.script_friendname))
      vehicle.script_friendname = vspawner.script_friendname;

    if(isDefined(vspawner.script_dontunloadonend))
      vehicle.script_dontunloadonend = vspawner.script_dontunloadonend;

    if(isDefined(vspawner.script_deathflag))
      vehicle.script_deathflag = vspawner.script_deathflag;

    if(isDefined(vspawner.script_team))
      vehicle.script_team = vspawner.script_team;

    if(isDefined(vspawner.script_delete))
      vehicle.script_delete = vspawner.script_delete;

    if(isDefined(vspawner.script_vehicle_selfremove))
      vehicle.script_vehicle_selfremove = vspawner.script_vehicle_selfremove;

    if(isDefined(vspawner.script_vehicle_lights_on))
      vehicle.script_vehicle_lights_on = vspawner.script_vehicle_lights_on;
  }

  if(!isDefined(vspawner.spawned_count))
    vspawner.spawned_count = 0;

  vspawner.spawned_count++;
  vspawner.last_spawned_vehicle = vehicle;
  vehicle.vehicle_spawner = vspawner;
  thread vehicle_init(vehicle);
  vspawner notify("spawned", vehicle);
  return vehicle;
}

vehicle_spawn_mp_internal(vspawner) {
  targetname = "temp_vehicle_targetname";

  if(isDefined(vspawner.targetname))
    targetname = vspawner.targetname;

  if(!isDefined(vspawner.classname_mp))
    classname_mp = vspawner.classname;
  else
    classname_mp = vspawner.classname_mp;

  vehicle = spawnVehicle(level.vehicle.templates.model[classname_mp], targetname, vspawner.vehicletype, vspawner.origin, vspawner.angles);
  vehicle.classname_mp = classname_mp;

  if(isDefined(vspawner.target))
    vehicle.target = vspawner.target;

  return vehicle;
}

vehicle_setuplevelvariables() {
  if(!scripts\engine\utility::add_init_script("vehicle_vars", ::vehicle_setuplevelvariables)) {
    return;
  }
  scripts\engine\utility::init_struct_class();
  vehicle_initlevelvariables();
  scripts\common\vehicle_aianim::setup_aianimthreads();
}

vehicle_precachescripts() {
  _id_69C1E608887EF109 = [];
  level.needsprecaching = [];

  if(!isDefined(level.vehicleinitthread))
    level.vehicleinitthread = [];

  vehicles = getEntArray("script_vehicle", "code_classname");

  foreach(vehicle in vehicles) {
    if(vehicle.vehicletype == "empty" || vehicle.vehicletype == "empty_heli") {
      continue;
    }
    _id_69C1E608887EF109[_id_69C1E608887EF109.size] = vehicle;
    vehicle_precachesetup(vehicle.classname, vehicle);
  }

  if(level.needsprecaching.size > 0) {
    _id_E9B07E032ACA08A8 = "";

    foreach(index, reasons in level.needsprecaching) {
      foreach(_id_401C3A2E68AAB0FD in reasons) {
        foreach(r in _id_401C3A2E68AAB0FD.reasons) {}
      }
    }

    level waittill("never");
  }

  return _id_69C1E608887EF109;
}

vehicle_precachesetup(classname, vehicle) {
  vehicletype = _func_40FD49171FAD19D3(vehicle.vehicletype);

  if(isDefined(level.vehicleinitthread[vehicletype]) && isDefined(level.vehicleinitthread[vehicletype][vehicle.classname])) {
    return;
  }
  if(vehicle.classname == "script_vehicle") {
    return;
  }
  reasons = [];

  if(isDefined(level.needsprecaching[classname]))
    reasons = level.needsprecaching[classname];

  struct = spawnStruct();
  struct.pos = vehicle.origin;
  struct.reasons = [];

  if(!isDefined(level.vehicleinitthread[vehicletype]))
    struct.reasons[struct.reasons.size] = "vehicletype \"" + vehicletype + "\" is not setup properly. Maybe you just need to re-package? Or you have a Radiant copy/paste issue where you have the wrong vehicletype set?";
  else if(!isDefined(level.vehicleinitthread[vehicletype][vehicle.classname]))
    struct.reasons[struct.reasons.size] = "classname \"" + vehicle.classname + "\"is not setup properly. Maybe you just need to re-package? Or the vehicle's Quaked is not setup properly";

  reasons[reasons.size] = struct;
  level.needsprecaching[classname] = reasons;
}

vehicle_setupspawners() {
  spawners = _getvehiclespawnerarray();

  foreach(spawner in spawners) {
    spawner thread vehicle_spawnerlogic();
    model = spawner _id_D0E99A4F0C29166E();

    if(isDefined(spawner._id_AE43938336BBD264) && isDefined(model)) {
      array = strtok(spawner._id_AE43938336BBD264, ",");

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
        if(array[_id_AC0E594AC96AA3A8] == "base") {
          precachemodel(model);
          continue;
        }

        precachemodel(array[_id_AC0E594AC96AA3A8] + "::" + model);
      }

      if(isDefined(level.vehicle.templates._id_FB41D1CA75009BF0[model])) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
          if(array[_id_AC0E594AC96AA3A8] == "base") {
            precachemodel(level.vehicle.templates._id_FB41D1CA75009BF0[model]);
            continue;
          }

          if(istrue(level.vehicle.templates._id_893DA51CF12B2C8B[model]))
            precachemodel(array[_id_AC0E594AC96AA3A8] + "::" + level.vehicle.templates._id_FB41D1CA75009BF0[model]);
        }
      }

      if(isDefined(level.vehicle.templates.mgturret[spawner.classname])) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
          if(array[_id_AC0E594AC96AA3A8] != "base")
            precachemodel(array[_id_AC0E594AC96AA3A8] + "::" + level.vehicle.templates.mgturret[spawner.classname][0].model);
        }
      }

      if(isDefined(level.vehicle.templates.mainturret[spawner.classname])) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
          if(array[_id_AC0E594AC96AA3A8] != "base")
            precachemodel(array[_id_AC0E594AC96AA3A8] + "::" + level.vehicle.templates.mainturret[spawner.classname].model);
        }
      }
    }
  }
}

vehicle_spawnerlogic() {
  self endon("entitydeleted");

  if(isDefined(self.script_deathflag))
    thread scripts\engine\utility::script_func("vehicle_spawner_deathflag");

  self.count = 1;
  self.spawn_functions = [];

  for(;;) {
    self waittill("spawned", vehicle);
    self.count--;

    if(!isDefined(vehicle)) {
      continue;
    }
    vehicle.spawn_funcs = self.spawn_functions;
    vehicle.spawner = self;
    vehicle thread scripts\engine\utility::script_func("run_spawn_functions");
  }
}

vehicle_triggerkillspawner(trigger) {
  trigger waittill("trigger");

  foreach(_id_EA0FBAC82EEC8FC1 in vehicle_getspawnerarray()) {
    if(scripts\engine\utility::is_equal(_id_EA0FBAC82EEC8FC1.script_kill_vehicle_spawner, trigger.script_kill_vehicle_spawner))
      _id_EA0FBAC82EEC8FC1 delete();
  }
}

vehicle_spawnaiarray(spawners) {
  _id_D69B722478F810B7 = [];
  forcespawn = scripts\engine\utility::ent_flag_exist("no_riders_until_unload") && scripts\engine\utility::ent_flag("no_riders_until_unload");

  foreach(spawner in spawners) {
    spawner.count = 1;
    dronespawn = 0;

    if(isDefined(spawner.script_drone)) {
      dronespawn = 1;
      spawned = scripts\engine\utility::script_func("dronespawn_bodyonly", spawner);
      spawned scripts\engine\utility::script_func("drone_give_soul");
    } else if(isDefined(spawner.script_fakeactor) || isDefined(spawner.script_bodyonly)) {
      dronespawn = 1;
      spawned = scripts\engine\utility::script_func("bodyonlyspawn", spawner);
      spawned scripts\engine\utility::script_func("fakeactor_give_soul");
    } else
      spawned = spawner scripts\engine\utility::script_func("spawn_ai", forcespawn);

    if(!dronespawn && !isalive(spawned)) {
      continue;
    }
    _id_D69B722478F810B7 = scripts\engine\utility::array_add(_id_D69B722478F810B7, spawned);
  }

  riders = vehicle_removenonridersfromaiarray(_id_D69B722478F810B7);
  return riders;
}

vehicle_removenonridersfromaiarray(_id_DA96C8943126A950) {
  _id_14511C73652EA6CB = [];

  foreach(ai in _id_DA96C8943126A950) {
    if(!ai_should_be_added(ai)) {
      continue;
    }
    _id_14511C73652EA6CB[_id_14511C73652EA6CB.size] = ai;
  }

  return _id_14511C73652EA6CB;
}

ai_should_be_added(ai) {
  if(isalive(ai))
    return 1;

  if(!isDefined(ai))
    return 0;

  if(!isDefined(ai.classname))
    return 0;

  return ai.classname == "script_model";
}

spawn_riders() {
  if(scripts\engine\utility::ent_flag_exist("no_riders_until_unload") && !scripts\engine\utility::ent_flag("no_riders_until_unload")) {
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

spawn_group(spawners) {
  ai = vehicle_spawnaiarray(spawners);
  ai = sort_by_startingpos(ai);

  foreach(guy in ai)
  thread scripts\common\vehicle_aianim::guy_enter(guy);

  thread set_loaded_when_full(ai);
  return ai;
}

set_loaded_when_full(ai) {
  scripts\engine\utility::array_wait(ai, "loaded", 1);
  scripts\common\vehicle_aianim::vehicle_loaded_if_full(self);
}

spawn_unload_group(_id_FA8D840338038893) {
  if(!isDefined(_id_FA8D840338038893))
    return spawn_riders();

  spawners = get_vehicle_riders_spawners();

  if(!spawners.size)
    return [];

  _id_731D2E30E2526FA4 = [];
  classname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.unloadgroups[classname]) && isDefined(level.vehicle.templates.unloadgroups[classname][_id_FA8D840338038893])) {
    group = level.vehicle.templates.unloadgroups[classname][_id_FA8D840338038893];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < group.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(spawners[_id_AC0E594AC96AA3A8]))
        spawners[_id_AC0E594AC96AA3A8].script_startingposition = group[_id_AC0E594AC96AA3A8];
    }

    spawners = sort_by_startingpos(spawners);

    foreach(_id_D13149368C074D36 in group) {
      foreach(spawner in spawners) {
        if(spawner.script_startingposition == _id_D13149368C074D36)
          _id_731D2E30E2526FA4[_id_731D2E30E2526FA4.size] = spawner;
      }
    }

    ai = vehicle_spawnaiarray(_id_731D2E30E2526FA4);

    foreach(guy in ai)
    thread scripts\common\vehicle_aianim::guy_enter(guy);

    self notify("spawnedRiders", ai);
    return ai;
  } else
    return spawn_riders();
}

sort_by_startingpos(_id_C44A1423A6EDF056) {
  _id_A0AAD838E42D7386 = [];
  _id_5AA2C99BF85B5562 = [];

  foreach(guy in _id_C44A1423A6EDF056) {
    if(isDefined(guy.script_startingposition)) {
      _id_A0AAD838E42D7386[_id_A0AAD838E42D7386.size] = guy;
      continue;
    }

    _id_5AA2C99BF85B5562[_id_5AA2C99BF85B5562.size] = guy;
  }

  return scripts\engine\utility::array_combine(_id_A0AAD838E42D7386, _id_5AA2C99BF85B5562);
}

vehicle_init(vehicle) {
  if(getDvar("dvar_742CAA13B3C2E685") == "1") {
    return;
  }
  classname = vehicle get_vehicle_classname();

  if(isDefined(level.vehicle.templates.hide_part_list[classname])) {
    foreach(part in level.vehicle.templates.hide_part_list[classname])
    vehicle hidepart(part);
  }

  vehicletype = _func_40FD49171FAD19D3(vehicle.vehicletype);

  if(vehicletype == "empty" || vehicletype == "empty_heli") {
    vehicle thread scripts\common\vehicle_paths::getonpath();
    return;
  }

  vehicle scripts\engine\utility::set_ai_number();
  vehicle vehicle_setstartinghealth();
  vehicle vehicle_setteam();

  if(!isDefined(level.vehicleinitthread[vehicletype][classname])) {}

  vehicle thread[[level.vehicleinitthread[vehicletype][classname]]]();
  vehicle thread vehicle_playexhausteffect();
  vehicle thread vehicle_playengineeffect();

  if(!isDefined(vehicle.script_avoidplayer))
    vehicle.script_avoidplayer = 0;

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal)
      vehicle thermaldrawenable();
  }

  vehicle scripts\engine\utility::ent_flag_init("unloaded");
  vehicle scripts\engine\utility::ent_flag_init("loaded");
  vehicle scripts\engine\utility::ent_flag_init("landed");
  vehicle.riders = [];
  vehicle.unloadque = [];
  vehicle.unload_group = "default";
  vehicle.fastroperig = [];

  if(isDefined(level.vehicle.templates.attachedmodels) && isDefined(level.vehicle.templates.attachedmodels[classname])) {
    _id_8DDABFC554F9A292 = level.vehicle.templates.attachedmodels[classname];
    strings = getarraykeys(_id_8DDABFC554F9A292);

    foreach(string in strings) {
      vehicle.fastroperig[string] = undefined;
      vehicle.fastroperiganimating[string] = 0;
    }
  }

  if(isDefined(vehicle.script_vehicle_lights_on))
    vehicle thread scripts\common\vehicle_lights::lights_on(vehicle.script_vehicle_lights_on);

  if(isDefined(vehicle.script_godmode))
    vehicle.godmode = 1;

  vehicle thread vehicle_damagelogic();
  vehicle thread scripts\common\vehicle_aianim::handle_attached_guys();

  if(isDefined(vehicle.script_friendname))
    vehicle setvehiclelookattext(vehicle.script_friendname, &"");

  vehicle thread vehicle_handleunloadevent();

  if(isDefined(vehicle.script_dontunloadonend))
    vehicle.dontunloadonend = 1;

  vehicle thread vehicle_rumble();
  vehicle thread scripts\engine\utility::script_func("vehicle_treads");
  vehicle thread idle_animations();
  vehicle thread animate_drive_idle();

  if(isDefined(vehicle.script_deathflag))
    vehicle thread scripts\engine\utility::script_func("vehicle_deathflag");

  vehicle thread mainturretinit();
  vehicle thread mginit();

  if(isDefined(level.vehicle.spawn_callback_thread))
    level thread[[level.vehicle.spawn_callback_thread]](vehicle);

  if(isDefined(vehicle.script_team))
    vehicle setvehicleteam(vehicle.script_team);

  vehicle _id_8E397E15E0FBD01A();
  vehicle thread scripts\common\vehicle_paths::getonpath();

  if(isDefined(level.ignorewash))
    _id_BB7075A368A061CF = level.ignorewash;
  else
    _id_BB7075A368A061CF = 0;

  if(scripts\common\utility::issp() && vehicle vehicle_hasdustkickup() && !_id_BB7075A368A061CF)
    vehicle thread aircraft_wash_thread();

  if(vehicle vehicle_isphysveh()) {
    vehicle.veh_pathtype = "constrained";

    if(isDefined(vehicle.script_pathtype))
      vehicle.veh_pathtype = vehicle.script_pathtype;
  }

  vehicle thread _id_FD3542824F9C1BD2();
  vehicle thread _id_C2B5282B537A56BC();
  vehicle spawn_riders();
  vehicle thread vehicle_deathlogic();
}

_id_9FCCC375476161D6(vehicle) {
  classname = vehicle get_vehicle_classname();

  if(vehicle.spawndata.vehicletype == "empty" || vehicle.spawndata.vehicletype == "empty_heli") {
    vehicle thread scripts\common\vehicle_paths::getonpath();
    return;
  }

  vehicle scripts\engine\utility::set_ai_number();
  type = vehicle.spawndata.vehicletype;

  if(!isDefined(vehicle.script_avoidplayer))
    vehicle.script_avoidplayer = 0;

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal)
      vehicle thermaldrawenable();
  }

  vehicle scripts\engine\utility::ent_flag_init("unloaded");
  vehicle scripts\engine\utility::ent_flag_init("loaded");
  vehicle scripts\engine\utility::ent_flag_init("landed");
  vehicle.riders = [];
  vehicle.unloadque = [];
  vehicle.unload_group = "default";
  vehicle.fastroperig = [];

  if(isDefined(vehicle.attachedmodels) && isDefined(vehicle.attachedmodels[classname])) {
    _id_8DDABFC554F9A292 = vehicle.attachedmodels[classname];
    strings = getarraykeys(_id_8DDABFC554F9A292);

    foreach(string in strings) {
      vehicle.fastroperig[string] = undefined;
      vehicle.fastroperiganimating[string] = 0;
    }
  }

  if(isDefined(vehicle.script_godmode))
    vehicle.godmode = 1;

  vehicle thread scripts\common\vehicle_aianim::handle_attached_guys();

  if(isDefined(vehicle.script_friendname))
    vehicle setvehiclelookattext(vehicle.script_friendname, &"");

  vehicle thread vehicle_handleunloadevent();

  if(isDefined(vehicle.script_dontunloadonend))
    vehicle.dontunloadonend = 1;

  vehicle thread scripts\engine\utility::script_func("vehicle_treads");

  if(isDefined(vehicle.script_deathflag))
    vehicle thread scripts\engine\utility::script_func("vehicle_deathflag");

  if(isDefined(vehicle.script_team))
    vehicle setvehicleteam(vehicle.script_team);

  vehicle _id_8E397E15E0FBD01A();
  vehicle thread scripts\common\vehicle_paths::getonpath();

  if(isDefined(level.ignorewash))
    _id_BB7075A368A061CF = level.ignorewash;
  else
    _id_BB7075A368A061CF = 0;

  if(scripts\common\utility::issp() && vehicle vehicle_hasdustkickup() && !_id_BB7075A368A061CF)
    vehicle thread aircraft_wash_thread();

  if(vehicle vehicle_isphysveh()) {
    vehicle.veh_pathtype = "constrained";

    if(isDefined(vehicle.script_pathtype))
      vehicle.veh_pathtype = vehicle.script_pathtype;
  }
}

_id_8E397E15E0FBD01A() {
  if(scripts\common\vehicle::ishelicopter())
    thread vehicle_ai_avoidance_heli();
  else
    thread vehicle_ai_avoidance_logic();
}

get_vehicle_classname() {
  if(isDefined(self.classname_mp))
    return self.classname_mp;

  return self.classname;
}

_id_D0E99A4F0C29166E() {
  if(isDefined(self._id_5E6DB70C016D2947))
    return self._id_5E6DB70C016D2947;

  model = self._id_B8957CD52D1EFA30;

  if(model == "")
    model = self.model;

  return model;
}

#using_animtree("vehicles");

vehicle_deathcleanup() {
  self notify("stop_looping_death_fx");
  self notify("death_finished");

  if(isDefined(self.navobstacleid))
    destroynavobstacle(self.navobstacleid);

  destroynavrepulsor("veh_" + self getentitynumber());

  if(isDefined(self.rumbletrigger))
    self.rumbletrigger delete();

  if(isDefined(self.mgturret))
    scripts\engine\utility::array_delete(self.mgturret);

  if(isDefined(self.mainturret))
    self.mainturret delete();

  if(istrue(level.vehicle.templates.has_main_turret[self.model]))
    self clearturrettarget();

  classname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rumble[classname]))
    self stoprumble(level.vehicle.templates.rumble[classname].rumble);

  if(!scripts\common\utility::issp()) {
    return;
  }
  self useanimtree(#animtree);

  if(isDefined(level.vehicle.templates.driveidle[self.model]))
    self clearanim(level.vehicle.templates.driveidle[self.model], 0);

  if(isDefined(level.vehicle.templates.driveidle_r[self.model]))
    self clearanim(level.vehicle.templates.driveidle_r[self.model], 0);
}

vehicle_deathlogic() {
  self endon("entitydeleted");
  self endon("nodeath_thread");
  thread helicopter_unloading_watcher();
  self waittill("death", attacker, meansofdeath, _id_06B62DB6EEC868E2, damagelocation);

  if(isDefined(self._id_A9F96E33F612C828))
    [[self._id_A9F96E33F612C828]]();

  _id_35AB2DABE0210D0F = vehicle_deathcustomlogic(attacker, meansofdeath, _id_06B62DB6EEC868E2);

  if(isDefined(_id_35AB2DABE0210D0F) && !_id_35AB2DABE0210D0F) {
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

  if(scripts\vehicle\vehicle_common::_id_B795D4C865A7BC7E())
    _id_5D04267DD0768069();
  else {
    vehicle_setdeathmodel();

    if(scripts\common\vehicle::ishelicopter())
      vehicle_docrash(attacker, meansofdeath);
  }

  if(vehicle_iscorpse())
    self notify("vehicle_deathComplete", self.origin, self.angles);
  else {
    vehicle_deathcleanup();
    self notify("vehicle_deathComplete", self.origin, self.angles);

    if(scripts\vehicle\vehicle_common::_id_B795D4C865A7BC7E() || self isscriptable()) {
      if(isDefined(self._id_48FB8BDE665D628D))
        scripts\engine\utility::array_delete(self._id_48FB8BDE665D628D);

      self delete();
    } else {
      if(istrue(self.vehicle_skipdeathmodel)) {
        if(scripts\common\utility::iscp())
          wait 0.1;

        self delete();
        return;
      }

      self makecorpse();
      createnavbadplacebyent(self);
    }
  }
}

vehicle_deathcustomlogic(attacker, meansofdeath, _id_06B62DB6EEC868E2) {
  result = undefined;

  if(isDefined(self.custom_death_script))
    self thread[[self.custom_death_script]]();

  if(isDefined(self.deathfunction))
    result = self[[self.deathfunction]](attacker, meansofdeath, _id_06B62DB6EEC868E2);

  if(isDefined(level.vehicle.templates.death_thread[self.vehicletype]))
    thread[[level.vehicle.templates.death_thread[self.vehicletype]]]();

  registerkill = isDefined(attacker) && isDefined(meansofdeath) && isDefined(_id_06B62DB6EEC868E2);

  if(registerkill) {
    weaponname = getcompleteweaponname(_id_06B62DB6EEC868E2);
    attacker scripts\engine\utility::script_func("register_kill", self, meansofdeath, weaponname);
  }

  return result;
}

vehicle_iscrashing() {
  return istrue(self.vehiclecrashing);
}

vehicle_killriders() {
  if(istrue(self.pilot_killed) && !istrue(self.unloading))
    self waittill("flavor_done");

  foreach(rider in self.riders) {
    if(!isalive(rider)) {
      continue;
    }
    if(!isDefined(rider.ridingvehicle)) {
      continue;
    }
    if(isDefined(rider.magic_bullet_shield))
      rider scripts\common\ai::stop_magic_bullet_shield();

    if(isDefined(rider._blackboard) && isDefined(rider._blackboard.chosenvehicleanimpos) && istrue(rider._blackboard._id_41C9F8C7891F19DA)) {
      _id_ADF3664B12362142 = 100.0;
      velocity = self vehicle_getvelocity();
      rider.do_immediate_ragdoll = 1;
      rider.ragdollhitloc = "torso_lower";
      rider.ragdollimpactvector = (rider.origin - self.origin) * _id_ADF3664B12362142 + velocity;
    }

    if(scripts\common\utility::iscp() && isDefined(self.damage_data)) {
      if(isDefined(self.damage_data.attacker) && isPlayer(self.damage_data.attacker))
        rider dodamage(rider.maxhealth, self.damage_data.attacker.origin, self.damage_data.attacker, self.damage_data.attacker, self.damage_data.meansofdeath, self.damage_data.objweapon);
      else
        rider kill();

      continue;
    }

    rider kill();
  }
}

vehicle_rider_death_detection(vehicle) {
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

vehicle_becomes_crashable() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend;
  self.riders = scripts\engine\utility::array_removedead(self.riders);

  if(self.riders.size) {
    scripts\engine\utility::array_thread(self.riders, ::vehicle_rider_death_detection, self);
    scripts\engine\utility::waittill_either("veh_collision", "driver_died");
    vehicle_killriders();
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self vehphys_crash();
}

vehicle_landanims(_id_01221D5694CF7822, _id_1CFCC2359E6AAF52) {
  self endon("death");
  classname = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.landanims[classname])) {
    return;
  }
  landanims = level.vehicle.templates.landanims[classname];

  foreach(_id_60EABCF32AF43DFE in landanims)
  self setanim(_id_60EABCF32AF43DFE.land, 1, 0.2, 1);

  if(!_id_1CFCC2359E6AAF52) {
    return;
  }
  if(isDefined(_id_01221D5694CF7822))
    self waittill("unloaded");
  else
    self waittill("continuepath");

  foreach(_id_60EABCF32AF43DFE in landanims) {
    self clearanim(_id_60EABCF32AF43DFE.land, 0);
    self setanim(_id_60EABCF32AF43DFE.takeoff, 1, 0.2, 1);
  }
}

vehicle_landvehicle(_id_44760E645D6BE134, node) {
  return _vehicle_landvehicle(_id_44760E645D6BE134, node);
}

spawn_vehicle_and_attach_to_spline_path(_id_776BE63DCBC6B552) {
  vehicle = scripts\common\utility::spawn_vehicle();

  if(isDefined(_id_776BE63DCBC6B552))
    vehicle vehicle_setspeed(_id_776BE63DCBC6B552);

  vehicle thread vehicle_becomes_crashable();
  vehicle endon("death");
  vehicle.dontunloadonend = 1;
  vehicle scripts\common\vehicle_paths::gopath(vehicle);
  vehicle leave_path_for_spline_path();
}

leave_path_for_spline_path() {
  self endon("script_crash_vehicle");
  scripts\engine\utility::waittill_either("enable_spline_path", "reached_end_node");
  node = get_my_spline_node(self.origin);

  if(isDefined(level.drive_spline_path_fun))
    node thread[[level.drive_spline_path_fun]](self);
}

get_my_spline_node(org) {
  org = (org[0], org[1], 0);
  _id_C6736586AE30F7EA = scripts\engine\utility::get_array_of_closest(org, level.snowmobile_path);
  _id_1A99FE3A1869724D = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++)
    _id_1A99FE3A1869724D[_id_AC0E594AC96AA3A8] = _id_C6736586AE30F7EA[_id_AC0E594AC96AA3A8];

  foreach(path in level.snowmobile_path) {
    foreach(node in _id_1A99FE3A1869724D) {
      if(node == path)
        return node;
    }
  }
}

waittill_stable(node) {
  offset = 12;
  _id_35B0AECC155B4DBB = 400;
  timer = gettime() + _id_35B0AECC155B4DBB;
  prevangles = self.angles;

  while(isDefined(self)) {
    if(abs(angleclamp180(self.angles[0])) > offset || abs(angleclamp180(self.angles[2])) > offset || abs(self.angles[1] - prevangles[1]) > 0.5)
      timer = gettime() + _id_35B0AECC155B4DBB;

    if(gettime() > timer) {
      break;
    }

    prevangles = self.angles;
    wait 0.05;
  }
}

vehicle_kill_badplace_forever() {
  self notify("kill_badplace_forever");
}

vehicle_isdestructible() {
  return isDefined(self.destructible_type);
}

vehicle_playdeatheffects(attacker, meansofdeath, damagelocation) {
  if(vehicle_isdestructible()) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);
  thread vehicle_deathearthquake();
  thread vehicle_deathradiusdamage();

  if(self isscriptable() && !scripts\common\vehicle::ishelicopter()) {
    scripts\common\utility::_id_3677F2BE30FDD581("visibility", "hide");
    scripts\engine\utility::delaycall(0.05, ::delete);
  } else {
    thread vehicle_deathkilllights();
    thread vehicle_deathvfx(attacker, meansofdeath);
  }
}

vehicle_deathvfx(attacker, meansofdeath) {
  _id_9EF41E2C046AD906 = get_vehicle_classname();

  if(vehicle_shoulddorocketdeath(attacker, meansofdeath, _id_9EF41E2C046AD906)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 3;
    _id_21CB1C59019B56F7 = level.vehicle.templates.vehicle_rocket_death_fx[_id_9EF41E2C046AD906];
  } else if(istrue(self.pilot_killed)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 4;
    _id_21CB1C59019B56F7 = level.vehicle.templates.vehicle_rocket_death_fx[_id_9EF41E2C046AD906];
  } else
    _id_21CB1C59019B56F7 = level.vehicle.templates.vehicle_death_fx[_id_9EF41E2C046AD906];

  if(isDefined(_id_21CB1C59019B56F7)) {
    foreach(_id_419CC4153A9718B6 in _id_21CB1C59019B56F7)
    thread kill_fx_thread(self.model, _id_419CC4153A9718B6, self.vehicletype, attacker);
  }
}

vehicle_deathearthquake() {
  _id_44AD722912E72154 = level.vehicle.templates.death_earthquake[get_vehicle_classname()];

  if(isDefined(_id_44AD722912E72154))
    earthquake(_id_44AD722912E72154.scale, _id_44AD722912E72154.duration, self.origin, _id_44AD722912E72154.radius);
}

vehicle_deathradiusdamage() {
  if(scripts\common\vehicle::ishelicopter()) {
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

vehicle_deathkilllights() {
  scripts\common\vehicle_lights::lights_off_internal("all", self.model, get_vehicle_classname());
}

vehicle_shoulddorocketdeath(attacker, meansofdeath, _id_9EF41E2C046AD906) {
  if(!vehicle_hasrocketdeath(_id_9EF41E2C046AD906))
    return 0;

  if(istrue(self.vehicle_forcerocketdeath))
    return 1;

  if(scripts\engine\utility::is_equal(meansofdeath, "MOD_PROJECTILE"))
    return 1;

  if(scripts\engine\utility::is_equal(meansofdeath, "MOD_PROJECTILE_SPLASH"))
    return 1;

  if(scripts\engine\utility::is_equal(meansofdeath, "MOD_GRENADE"))
    return 1;

  return 0;
}

vehicle_hasrocketdeath(classname) {
  return isDefined(level.vehicle.templates.vehicle_rocket_death_fx[classname]);
}

kill_fx_thread(model, struct, type, attacker) {
  if(isDefined(self.pilot_killed))
    self waittill("flavor_done");

  if(isDefined(self.nodeath)) {
    return;
  }
  if(!isDefined(attacker)) {
    return;
  }
  if(isDefined(struct.waitdelay)) {
    if(struct.waitdelay >= 0)
      wait(struct.waitdelay);
    else
      self waittill("death_finished");
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(struct.notifystring))
    self notify(struct.notifystring);

  _id_F86CB346559301F7 = vectorNormalize(self.origin - attacker.origin);

  if(isDefined(struct.selfdeletedelay))
    scripts\engine\utility::delaycall(struct.selfdeletedelay, ::delete);

  if(isDefined(struct.effect)) {
    if(struct.beffectlooping) {
      if(isDefined(struct.tag)) {
        if(isDefined(struct.stayontag) && struct.stayontag == 1)
          thread loop_fx_on_vehicle_tag(struct.effect, struct.delay, struct.tag);
        else
          thread playloopedfxontag(struct.effect, struct.delay, struct.tag);
      } else {
        forward = self.origin + (0, 0, 100) - self.origin;
        playFX(struct.effect, self.origin, forward);
      }
    } else if(isDefined(struct.tag)) {
      forward = _kill_fx_play_direction(_id_F86CB346559301F7, struct.attacker_velocity_lerp);

      if(isDefined(forward)) {
        _id_F0E63DFCBA14733E = deathfx_ent();
        playFX(struct.effect, _id_F0E63DFCBA14733E gettagorigin(struct.tag), forward);

        if(isDefined(struct.remove_deathfx_entity_delay))
          _id_F0E63DFCBA14733E scripts\engine\utility::delaycall(struct.remove_deathfx_entity_delay, ::delete);
      } else {
        _id_F0E63DFCBA14733E = deathfx_ent();
        playFXOnTag(struct.effect, _id_F0E63DFCBA14733E, struct.tag);
        thread stop_fx_on_vehicle_watcher(struct.effect, _id_F0E63DFCBA14733E, struct.tag);

        if(isDefined(struct.remove_deathfx_entity_delay))
          deathfx_ent() scripts\engine\utility::delaycall(struct.remove_deathfx_entity_delay, ::delete);
      }
    } else {
      forward = _kill_fx_play_direction(_id_F86CB346559301F7, struct.attacker_velocity_lerp);

      if(isDefined(forward))
        playFX(struct.effect, self.origin, forward);
      else {
        forward = self.origin + (0, 0, 100) - self.origin;
        playFX(struct.effect, self.origin, forward);
      }
    }
  }

  if(isDefined(struct.sound)) {
    if(struct.bsoundlooping)
      thread death_firesound(struct.sound);
    else
      scripts\engine\utility::play_sound_in_space(struct.sound);
  }
}

stop_fx_on_vehicle_watcher(_id_84501ABDD5C427F0, _id_F0E63DFCBA14733E, effect_tag) {
  _id_F0E63DFCBA14733E waittill("stop_all_death_fx");
  stopFXOnTag(_id_84501ABDD5C427F0, _id_F0E63DFCBA14733E, effect_tag);
}

loop_fx_on_vehicle_tag(effect, _id_E354D4BC1D4F4D4E, tag) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(effect, deathfx_ent(), tag);
    wait(_id_E354D4BC1D4F4D4E);
  }
}

death_firesound(sound) {
  thread scripts\engine\utility::script_func("playloopsound_on_tag", sound, undefined, 0, 1);
  scripts\engine\utility::waittill_any_2("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + sound);
}

deathfx_ent() {
  if(isDefined(self.death_fx_on_self) && self.death_fx_on_self)
    return self;

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
  } else
    self.deathfx_ent setModel(self.model);

  return self.deathfx_ent;
}

playloopedfxontag(effect, _id_8B076700EA5BBAC3, tag) {
  _id_24D4ADBE595ACFEA = spawn("script_origin", self.origin);
  self endon("fire_extinguish");
  thread playloopedfxontag_originupdate(tag, _id_24D4ADBE595ACFEA);

  for(;;) {
    playFX(effect, _id_24D4ADBE595ACFEA.origin, _id_24D4ADBE595ACFEA.upvec);
    wait(_id_8B076700EA5BBAC3);
  }
}

playloopedfxontag_originupdate(tag, _id_24D4ADBE595ACFEA) {
  _id_24D4ADBE595ACFEA.angles = self gettagangles(tag);
  _id_24D4ADBE595ACFEA.origin = self gettagorigin(tag);
  _id_24D4ADBE595ACFEA.forwardvec = anglesToForward(_id_24D4ADBE595ACFEA.angles);
  _id_24D4ADBE595ACFEA.upvec = anglestoup(_id_24D4ADBE595ACFEA.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    _id_24D4ADBE595ACFEA.angles = self gettagangles(tag);
    _id_24D4ADBE595ACFEA.origin = self gettagorigin(tag);
    _id_24D4ADBE595ACFEA.forwardvec = anglesToForward(_id_24D4ADBE595ACFEA.angles);
    _id_24D4ADBE595ACFEA.upvec = anglestoup(_id_24D4ADBE595ACFEA.angles);
    wait 0.05;
  }
}

update_steering(vehicle) {
  if(vehicle.update_time == gettime())
    return vehicle.steering;

  vehicle.update_time = gettime();

  if(vehicle.steering_enable) {
    _id_8B4EEF7EF67C5FBC = clamp(0 - vehicle.angles[2], 0 - vehicle.steering_maxroll, vehicle.steering_maxroll) / vehicle.steering_maxroll;

    if(isDefined(vehicle.leanasitturns) && vehicle.leanasitturns) {
      _id_FBC088BDC2E9138B = vehicle vehicle_getsteering();
      _id_FBC088BDC2E9138B = _id_FBC088BDC2E9138B * -1.0;
      _id_8B4EEF7EF67C5FBC = _id_8B4EEF7EF67C5FBC + _id_FBC088BDC2E9138B;

      if(_id_8B4EEF7EF67C5FBC != 0) {
        _id_05A867F30C70AD20 = 1.0 / abs(_id_8B4EEF7EF67C5FBC);

        if(_id_05A867F30C70AD20 < 1)
          _id_8B4EEF7EF67C5FBC = _id_8B4EEF7EF67C5FBC * _id_05A867F30C70AD20;
      }
    }

    _id_3777ECE6A73EADA5 = _id_8B4EEF7EF67C5FBC - vehicle.steering;

    if(_id_3777ECE6A73EADA5 != 0) {
      _id_CCBBA16287668F0A = vehicle.steering_maxdelta / abs(_id_3777ECE6A73EADA5);

      if(_id_CCBBA16287668F0A < 1)
        _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 * _id_CCBBA16287668F0A;

      vehicle.steering = vehicle.steering + _id_3777ECE6A73EADA5;
    }
  } else
    vehicle.steering = 0;

  return vehicle.steering;
}

_id_098C0327A3D5CE1C(target) {
  return target;
}

get_from_spawnStruct(target) {
  array = scripts\engine\utility::getStructArray(target, "targetname");

  if(array.size == 1)
    return array[0];
  else {
    foreach(_id_F7806D4CF24AACD3 in array) {
      if(isDefined(_id_F7806D4CF24AACD3._id_B205D90302DA2F07) && isDefined(self._id_B205D90302DA2F07) && _id_F7806D4CF24AACD3._id_B205D90302DA2F07 == self._id_B205D90302DA2F07)
        return _id_F7806D4CF24AACD3;
    }

    return array[0];
  }
}

get_from_entity(target) {
  ent = getEntArray(target, "targetname");

  if(isDefined(ent) && ent.size > 0)
    return ent[randomint(ent.size)];

  return undefined;
}

get_from_vehicle_node(target) {
  return getvehiclenode(target, "targetname");
}

set_lookat_from_dest(_id_815D30728A6EF9D9) {
  _id_9AE5B7230AF98AF5 = getEnt(_id_815D30728A6EF9D9.script_linkto, "script_linkname");

  if(!isDefined(_id_9AE5B7230AF98AF5)) {
    return;
  }
  self setlookatent(_id_9AE5B7230AF98AF5);
  self.set_lookat_point = 1;
}

damage_hint_bullet_only() {
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
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;
          attacker scripts\engine\utility::script_func("display_hint", "invulerable_bullets");
          wait 4;
          level.armordamagehints = 0;

          if(isDefined(self))
            self.displayingdamagehints = 0;

          break;
        }
    }
  }
}

damage_hints() {
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
      case "mod_grenade_splash":
      case "mod_grenade":
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;

          if(type == "mod_grenade" || type == "mod_grenade_splash")
            attacker scripts\engine\utility::script_func("display_hint", "invulerable_frags", 5);
          else
            attacker scripts\engine\utility::script_func("display_hint", "invulerable_bullets", 5);

          wait 4;
          level.armordamagehints = 0;

          if(isDefined(self))
            self.displayingdamagehints = 0;

          break;
        }
    }
  }
}

damage_hints_cleanup() {
  self waittill("death");

  if(self.displayingdamagehints)
    level.armordamagehints = 0;
}

aircraft_wash_thread(model) {
  self endon("death");
  self endon("death_finished");
  self notify("stop_kicking_up_dust");
  self endon("stop_kicking_up_dust");
  _id_20520E06DC84DF35 = 2000;

  if(isDefined(level.treadfx_maxheight))
    _id_20520E06DC84DF35 = level.treadfx_maxheight;

  _id_B012B58235910016 = 80 / _id_20520E06DC84DF35;
  rate = 0.5;

  if(scripts\common\vehicle::isairplane())
    rate = 0.15;

  _id_7636A8DC247C5984 = self;

  if(isDefined(model))
    _id_7636A8DC247C5984 = model;

  _id_A1B6E266BCAD49FE = 3;
  _id_B5973F58036E29A5 = scripts\engine\trace::create_default_contents(1);

  for(;;) {
    wait(rate);

    if(1) {
      if(isDefined(self.disable_wash) && self.disable_wash) {
        continue;
      }
      if(isDefined(self.treadfx_maxheight))
        _id_20520E06DC84DF35 = self.treadfx_maxheight;

      _id_59C63D210E5007B1 = anglestoup(_id_7636A8DC247C5984.angles) * -1;
      trace = undefined;
      _id_A1B6E266BCAD49FE++;

      if(_id_A1B6E266BCAD49FE > 3) {
        _id_A1B6E266BCAD49FE = 3;
        trace = scripts\engine\trace::ray_trace(_id_7636A8DC247C5984.origin, _id_7636A8DC247C5984.origin + _id_59C63D210E5007B1 * _id_20520E06DC84DF35, _id_7636A8DC247C5984, _id_B5973F58036E29A5, 1);
      }

      if(trace["fraction"] == 1 || trace["fraction"] < _id_B012B58235910016) {
        continue;
      }
      dist = distance(_id_7636A8DC247C5984.origin, trace["position"]);
      _id_4643B33060D67DA5 = get_wash_fx(self, trace, _id_59C63D210E5007B1, dist);

      if(!isDefined(_id_4643B33060D67DA5)) {
        continue;
      }
      rate = (dist - 350) / (_id_20520E06DC84DF35 - 350) * 0.1 + 0.05;
      rate = max(rate, 0.05);

      if(!isDefined(trace)) {
        continue;
      }
      if(!isDefined(trace["position"])) {
        continue;
      }
      fx_origin = trace["position"];
      _id_7F8AE928D63BE1BB = trace["normal"];
      dist = vectordot(fx_origin - _id_7636A8DC247C5984.origin, _id_7F8AE928D63BE1BB);
      pos = _id_7636A8DC247C5984.origin + (0, 0, dist);
      forward = fx_origin - pos;

      if(isDefined(self.treadfx_orient_to_player))
        forward = fx_origin - level.player.origin;

      if(vectordot(trace["normal"], (0, 0, 1)) == -1) {
        continue;
      }
      if(length(forward) < 1)
        forward = _id_7636A8DC247C5984.angles + (0, 180, 0);

      playFX(_id_4643B33060D67DA5, fx_origin, _id_7F8AE928D63BE1BB, forward);
    }
  }
}

get_wash_fx(vehicle, trace, _id_59C63D210E5007B1, dist) {
  _id_895F3C282BC9FC68 = trace["surfacetype"];
  _id_00F5D9414137E12B = undefined;
  dot = vectordot((0, 0, -1), _id_59C63D210E5007B1);

  if(dot >= 0.97)
    _id_00F5D9414137E12B = undefined;
  else if(dot >= 0.92)
    _id_00F5D9414137E12B = "_bank";
  else
    _id_00F5D9414137E12B = "_bank_lg";

  return get_wash_effect(vehicle get_vehicle_classname(), _id_895F3C282BC9FC68, _id_00F5D9414137E12B);
}

get_wash_effect(classname, _id_895F3C282BC9FC68, _id_00F5D9414137E12B) {
  if(isDefined(_id_00F5D9414137E12B)) {
    _id_D3F1E21839909C67 = _id_895F3C282BC9FC68 + _id_00F5D9414137E12B;

    if(!isDefined(level.vehicle.templates.surface_effects[classname][_id_D3F1E21839909C67]) && _id_895F3C282BC9FC68 != "default")
      return get_wash_effect(classname, "default", _id_00F5D9414137E12B);
    else
      return level.vehicle.templates.surface_effects[classname][_id_D3F1E21839909C67];
  }

  return get_vehicle_effect(classname, _id_895F3C282BC9FC68);
}

get_vehicle_effect(classname, _id_895F3C282BC9FC68) {
  if(!isDefined(level.vehicle.templates.surface_effects[classname][_id_895F3C282BC9FC68]) && _id_895F3C282BC9FC68 != "default")
    return get_vehicle_effect(classname, "default");
  else
    return level.vehicle.templates.surface_effects[classname][_id_895F3C282BC9FC68];

  return undefined;
}

no_treads() {
  return scripts\common\vehicle::ishelicopter() || scripts\common\vehicle::isairplane();
}

vehicle_hasdustkickup() {
  if(!scripts\common\vehicle::ishelicopter() && !scripts\common\vehicle::isairplane())
    return 0;

  return 1;
}

hashelicopterturret() {
  if(!isDefined(self.vehicletype))
    return 0;

  if(self.vehicletype == "cobra")
    return 1;

  if(self.vehicletype == "cobra_player")
    return 1;

  if(self.vehicletype == "viper")
    return 1;

  return 0;
}

vehicle_ai_avoidance_cleanup() {
  self waittill("death");
  vehicle_remove_navobstacle();
  vehicle_remove_navrepulsor();
}

vehicle_ai_avoidance_logic() {
  self endon("death");
  thread vehicle_ai_avoidance_cleanup();
  _id_DA5E21C00A97C42A = self vehicle_isphysveh();
  _id_F9728679C5E60AF8 = 56.25;

  for(;;) {
    vehicle_navobstacle();
    _id_8ACE8BF028CAA1D8 = self.origin;

    while(vehicle_is_stopped() && (!_id_DA5E21C00A97C42A || self vehicle_isonground())) {
      wait 0.5;

      if(lengthsquared(self.origin - _id_8ACE8BF028CAA1D8) > _id_F9728679C5E60AF8) {
        vehicle_remove_navobstacle();
        vehicle_navobstacle();
        _id_8ACE8BF028CAA1D8 = self.origin;
      }
    }

    vehicle_remove_navobstacle();
    vehicle_navrepulsor();

    while(!vehicle_is_stopped() || _id_DA5E21C00A97C42A && !self vehicle_isonground())
      wait 0.1;

    vehicle_remove_navrepulsor();
  }
}

vehicle_is_stopped() {
  if(!scripts\common\utility::issp() && self issuspendedvehicle())
    return 1;

  if(self vehicle_isphysveh())
    return length(self vehicle_getvelocity()) / 17.6 < 0.25;

  return length(self vehicle_getvelocity()) / 17.6 == 0;
}

vehicle_ai_avoidance_heli() {
  self endon("death");

  for(;;) {
    vehicle_navobstacle();

    while(self vehicle_getspeed() == 0 && (!isDefined(self.script_disconnectpaths) || istrue(self.script_disconnectpaths)))
      wait 0.1;

    vehicle_remove_navobstacle();

    while(self vehicle_getspeed() != 0 || isDefined(self.script_disconnectpaths) && !istrue(self.script_disconnectpaths))
      wait 0.1;
  }
}

vehicle_navrepulsor() {
  if(isDefined(self.script_badplace) && !istrue(self.script_badplace)) {
    return;
  }
  createnavrepulsor(self.unique_id + "vehicle_badplace", -1, self, "allies", "axis");
}

vehicle_remove_navrepulsor() {
  destroynavrepulsor(self.unique_id + "vehicle_badplace");
}

vehicle_navobstacle() {
  if(isDefined(self.script_disconnectpaths) && !istrue(self.script_disconnectpaths)) {
    return;
  }
  self.navobstacleid = createnavbadplacebyent(self);
}

vehicle_remove_navobstacle() {
  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
    self.navobstacleid = undefined;
  }
}

vehicle_disable_navrepulsors() {
  self.script_badplace = 0;
  vehicle_remove_navrepulsor();
}

vehicle_enable_navrepulsors() {
  self.script_badplace = undefined;

  if(!vehicle_is_stopped())
    vehicle_navrepulsor();
}

vehicle_disable_navobstacles() {
  self.script_disconnectpaths = 0;
  vehicle_remove_navobstacle();
}

vehicle_enable_navobstacles() {
  self.script_disconnectpaths = undefined;

  if(vehicle_is_stopped())
    vehicle_navobstacle();
}

vehicle_badplace() {
  vehicle_navrepulsor();
}

vehicle_remove_badplace() {
  vehicle_remove_navrepulsor();
}

disconnect_paths_whenstopped() {
  self endon("death");
  self.pathsdisconnected = 0;
  _id_D92D81D0D2FDF1C2 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths)
    _id_D92D81D0D2FDF1C2 = 1;

  if(_id_D92D81D0D2FDF1C2) {
    self.dontdisconnectpaths = 1;
    return;
  }

  wait(randomfloat(1));

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self.dontdisconnectpaths)) {
        self disconnectPaths();
        self.pathsdisconnected = 1;
      } else {}

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

mainturretinit() {
  classname = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.mainturret[classname])) {
    return;
  }
  _id_F15DC6DD1EC8F7DE = level.vehicle.templates.mainturret[classname];

  if(!isDefined(_id_F15DC6DD1EC8F7DE)) {
    return;
  }
  _id_2C65BE20EAFC23F3 = "";

  if(isDefined(self.script_turrets))
    _id_2C65BE20EAFC23F3 = self.script_turrets;

  self.mainturret = turretinitshared(_id_F15DC6DD1EC8F7DE);

  if(!isDefined(self.script_turretmain))
    self.script_turretmain = 1;

  if(self.script_turretmain == 0)
    thread _mainturretoff();
  else {
    self.script_turretmain = 1;
    thread _mainturreton();
  }
}

mginit() {
  classname = get_vehicle_classname();

  if(isDefined(self.script_nomg) && self.script_nomg > 0) {
    return;
  }
  if(!isDefined(level.vehicle.templates.mgturret[classname])) {
    return;
  }
  _id_9A34054AB3F8B177 = level.vehicle.templates.mgturret[classname];

  if(!isDefined(_id_9A34054AB3F8B177)) {
    return;
  }
  _id_2C65BE20EAFC23F3 = "";

  if(isDefined(self.script_turrets))
    _id_2C65BE20EAFC23F3 = self.script_turrets;

  foreach(index, _id_F15DC6DD1EC8F7DE in _id_9A34054AB3F8B177) {
    if(isDefined(_id_F15DC6DD1EC8F7DE.referencename) && !issubstr(_id_2C65BE20EAFC23F3, _id_F15DC6DD1EC8F7DE.referencename)) {
      continue;
    }
    self.mgturret[index] = turretinitshared(_id_F15DC6DD1EC8F7DE);
  }

  if(!isDefined(self.script_turretmg))
    self.script_turretmg = 1;

  if(self.script_turretmg == 0)
    thread _mgoff();
  else {
    self.script_turretmg = 1;
    thread _mgon();
  }
}

turretinitshared(_id_F15DC6DD1EC8F7DE) {
  _id_A53C4231F99C0BC4 = 0;

  if(isDefined(self.script_mg_angle))
    _id_A53C4231F99C0BC4 = self.script_mg_angle;

  turret = spawnturret("misc_turret", (0, 0, 0), _id_F15DC6DD1EC8F7DE.info);
  linkoffset = scripts\engine\utility::ter_op(isDefined(_id_F15DC6DD1EC8F7DE.offset_tag), _id_F15DC6DD1EC8F7DE.offset_tag, (0, 0, 0));
  parent = self;

  if(isDefined(_id_F15DC6DD1EC8F7DE.mainturretchild)) {
    if(!isDefined(self.mainturret)) {}

    parent = self.mainturret;
  }

  turret linkTo(parent, _id_F15DC6DD1EC8F7DE.tag, linkoffset, (0, -1 * _id_A53C4231F99C0BC4, 0));
  bodymodel = _id_D0E99A4F0C29166E();
  array = strtok(bodymodel, "::");

  if(array.size > 1)
    color = array[0] + "::";
  else
    color = "";

  turret setModel(color + _id_F15DC6DD1EC8F7DE.model);
  turret.angles = self.angles;
  turret.isvehicleattached = 1;
  turret.ownervehicle = self;
  turret.weaponinfo = _id_F15DC6DD1EC8F7DE.info;
  turret.script_team = self.script_team;
  turret makeusable();
  set_turret_team(turret);
  level thread vehicle_turret_difficulty(turret, scripts\common\utility::getdifficulty());

  if(isDefined(self.script_fireondrones))
    turret.script_fireondrones = self.script_fireondrones;

  if(isDefined(_id_F15DC6DD1EC8F7DE.deletedelay))
    turret.deletedelay = _id_F15DC6DD1EC8F7DE.deletedelay;

  if(isDefined(_id_F15DC6DD1EC8F7DE.defaultdroppitch))
    turret setdefaultdroppitch(_id_F15DC6DD1EC8F7DE.defaultdroppitch);

  if(isDefined(_id_F15DC6DD1EC8F7DE.referencename))
    turret.referencename = _id_F15DC6DD1EC8F7DE.referencename;

  if(isDefined(_id_F15DC6DD1EC8F7DE.defaultonmode))
    turret turret_set_default_on_mode(_id_F15DC6DD1EC8F7DE.defaultonmode);

  return turret;
}

vehicle_turret_difficulty(turret, difficulty) {
  turret.convergencetime = level.mgturretsettings[difficulty]["convergenceTime"];
  turret.suppressionTime = level.mgturretsettings[difficulty]["suppressionTime"];
  turret.accuracy = level.mgturretsettings[difficulty]["accuracy"];
  turret.aiSpread = level.mgturretsettings[difficulty]["aiSpread"];
  turret.playerSpread = level.mgturretsettings[difficulty]["playerSpread"];
}

turret_set_default_on_mode(defaultonmode) {
  self.defaultonmode = defaultonmode;
}

set_turret_team(turret) {
  switch (self.script_team) {
    case "friendly":
    case "allies":
      turret setturretteam("allies");
      break;
    case "enemy":
    case "axis":
      turret setturretteam("axis");
      break;
    case "team3":
      turret setturretteam("team3");
      break;
    case "neutral":
      turret setturretteam("neutral");
      break;
    default:
      break;
  }
}

animate_drive_idle() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  self endon("suspend_drive_anims");

  if(!isDefined(self.vehiclewheeldirection))
    self.vehiclewheeldirection = 1;

  model = _id_D0E99A4F0C29166E();
  _id_38DF3CDC3CEA641E = -1;
  _id_F12AA8AD25F80351 = undefined;

  if(!isDefined(level.vehicle.templates.driveidle[model])) {
    return;
  }
  self useanimtree(#animtree);

  if(!isDefined(level.vehicle.templates.driveidle_r[model]))
    level.vehicle.templates.driveidle_r[model] = level.vehicle.templates.driveidle[model];

  self endon("death");
  normalspeed = level.vehicle.templates.driveidle_normal_speed[model];
  _id_07B60BC0EAB3FD1E = 1.0;

  if(isDefined(level.vehicle.templates.driveidle_animrate) && isDefined(level.vehicle.templates.driveidle_animrate[model]))
    _id_07B60BC0EAB3FD1E = level.vehicle.templates.driveidle_animrate[model];

  _id_01EF3BE8B073C4D4 = self.vehiclewheeldirection;
  animation = level.vehicle.templates.driveidle[model];

  for(;;) {
    if(!normalspeed) {
      if(isDefined(self.suspend_driveanims)) {
        wait 0.05;
        continue;
      }

      self setanim(level.vehicle.templates.driveidle[model], 1, 0.2, _id_07B60BC0EAB3FD1E);
      return;
    }

    speed = self vehicle_getspeed();

    if(_id_01EF3BE8B073C4D4 != self.vehiclewheeldirection) {
      _id_D3E80203D73E375C = 0;

      if(self.vehiclewheeldirection) {
        animation = level.vehicle.templates.driveidle[model];
        _id_D3E80203D73E375C = 1 - get_normal_anim_time(level.vehicle.templates.driveidle_r[model]);
        self clearanim(level.vehicle.templates.driveidle_r[model], 0);
      } else {
        animation = level.vehicle.templates.driveidle_r[model];
        _id_D3E80203D73E375C = 1 - get_normal_anim_time(level.vehicle.templates.driveidle[model]);
        self clearanim(level.vehicle.templates.driveidle[model], 0);
      }

      _id_F12AA8AD25F80351 = 0.01;

      if(_id_F12AA8AD25F80351 >= 1 || _id_F12AA8AD25F80351 == 0)
        _id_F12AA8AD25F80351 = 0.01;

      _id_01EF3BE8B073C4D4 = self.vehiclewheeldirection;
    }

    _id_6442D47E06F360FA = speed / normalspeed;

    if(_id_6442D47E06F360FA != _id_38DF3CDC3CEA641E) {
      self setanim(animation, 1, 0.05, _id_6442D47E06F360FA);
      _id_38DF3CDC3CEA641E = _id_6442D47E06F360FA;
    }

    if(isDefined(_id_F12AA8AD25F80351)) {
      self setanimtime(animation, _id_F12AA8AD25F80351);
      _id_F12AA8AD25F80351 = undefined;
    }

    wait 0.05;
  }
}

setup_vehicles(vehicles) {
  _id_BA9F1614841F98E6 = [];

  foreach(vehicle in vehicles) {
    if(isspawner(vehicle))
      continue;
    else
      _id_BA9F1614841F98E6[_id_BA9F1614841F98E6.size] = vehicle;
  }

  foreach(_id_447C2355B0DB50FC in _id_BA9F1614841F98E6) {
    model = _id_447C2355B0DB50FC _id_D0E99A4F0C29166E();

    if(isDefined(_id_447C2355B0DB50FC._id_AE43938336BBD264) && isDefined(model)) {
      array = strtok(_id_447C2355B0DB50FC._id_AE43938336BBD264, ",");
      color = array[randomintrange(0, array.size)];

      if(color == "base")
        precachemodel(model);
      else
        precachemodel(color + "::" + model);

      if(isDefined(level.vehicle.templates._id_FB41D1CA75009BF0[model])) {
        if(color == "base")
          precachemodel(level.vehicle.templates._id_FB41D1CA75009BF0[model]);
        else if(istrue(level.vehicle.templates._id_893DA51CF12B2C8B[model]))
          precachemodel(color + "::" + level.vehicle.templates._id_FB41D1CA75009BF0[model]);
      }

      if(color == "base")
        _id_447C2355B0DB50FC setModel(model);
      else
        _id_447C2355B0DB50FC setModel(color + "::" + model);
    }

    if(isDefined(_id_447C2355B0DB50FC.spawnflags) && _id_447C2355B0DB50FC.spawnflags & 16)
      _id_447C2355B0DB50FC._id_A784428198C5658B = 1;

    if(isDefined(_id_447C2355B0DB50FC.spawnflags) && _id_447C2355B0DB50FC.spawnflags & 4) {
      _id_FB41D1CA75009BF0 = _id_447C2355B0DB50FC thread _id_18657584B6BD786A(1);
      continue;
    }

    if(isDefined(_id_447C2355B0DB50FC.spawnflags)) {
      if(_id_447C2355B0DB50FC.spawnflags & 1)
        _id_447C2355B0DB50FC thread scripts\engine\utility::script_func("vehicle_usable");
      else
        _id_447C2355B0DB50FC vehicle_turnengineoff();

      if(_id_447C2355B0DB50FC vehicle_isphysveh() && !_id_447C2355B0DB50FC scripts\common\vehicle::ishelicopter() && (_id_447C2355B0DB50FC.spawnflags & 8 || istrue(_id_447C2355B0DB50FC._id_A784428198C5658B)))
        _id_447C2355B0DB50FC _meth_65AA053C077C003A(1);
    }

    thread vehicle_init(_id_447C2355B0DB50FC);
  }
}

vehicle_setstartinghealth() {
  classname = get_vehicle_classname();

  if(isDefined(self.script_startinghealth))
    self.health = self.script_startinghealth;
  else {
    if(level.vehicle.templates.life[classname] == -1) {
      return;
    }
    if(isDefined(level.vehicle.templates.life_range_low[classname]) && isDefined(level.vehicle.templates.life_range_high[classname]))
      self.health = randomint(level.vehicle.templates.life_range_high[classname] - level.vehicle.templates.life_range_low[classname]) + level.vehicle.templates.life_range_low[classname];
    else
      self.health = level.vehicle.templates.life[classname];
  }

  self._id_EBD1D83C2799EF12 = 0;
  self.maxhealth = self.health;
  self._id_80D0F593608378C1 = self.health;
  self._id_FA70E73BAE432D6F = self.health;
  self.damagestate = "damagePristine";
  self._id_653C58271B7DA4C9 = 1;
  self._id_FB29967BDC4900EC = 0;
  _id_98C558B067CDD616();
}

get_normal_anim_time(animation) {
  _id_EB5B1F36E255152D = self getanimtime(animation);
  animlength = getanimlength(animation);

  if(_id_EB5B1F36E255152D == 0)
    return 0;

  return self getanimtime(animation) / getanimlength(animation);
}

suspend_drive_anims() {
  self notify("suspend_drive_anims");
  self clearanim(level.vehicle.templates.driveidle[self.model], 0);
  self clearanim(level.vehicle.templates.driveidle_r[self.model], 0);
}

idle_animations() {
  if(!isDefined(level.vehicle.templates.idle_anim[self.model])) {
    return;
  }
  self useanimtree(#animtree);

  foreach(animation in level.vehicle.templates.idle_anim[self.model])
  self setanim(animation);
}

vehicle_rumble() {
  self endon("kill_rumble_forever");
  classname = get_vehicle_classname();
  _id_CAD06C766785FED9 = level.vehicle.templates.rumble[classname];

  if(!isDefined(_id_CAD06C766785FED9)) {
    return;
  }
  height = _id_CAD06C766785FED9.radius * 2;
  zoffset = -1 * _id_CAD06C766785FED9.radius;
  _id_C1E5E178D5D956E4 = spawn("trigger_radius", self.origin + (0, 0, zoffset), 0, _id_CAD06C766785FED9.radius, height);
  _id_C1E5E178D5D956E4 enablelinkTo();
  _id_C1E5E178D5D956E4 linkTo(self);
  self.rumbletrigger = _id_C1E5E178D5D956E4;
  self endon("death");

  if(!isDefined(self.rumbleon))
    self.rumbleon = 1;

  if(isDefined(_id_CAD06C766785FED9.scale))
    self.rumble_scale = _id_CAD06C766785FED9.scale;
  else
    self.rumble_scale = 0.15;

  if(isDefined(_id_CAD06C766785FED9.duration))
    self.rumble_duration = _id_CAD06C766785FED9.duration;
  else
    self.rumble_duration = 4.5;

  if(isDefined(_id_CAD06C766785FED9.radius))
    self.rumble_radius = _id_CAD06C766785FED9.radius;
  else
    self.rumble_radius = 600;

  if(isDefined(_id_CAD06C766785FED9.basetime))
    self.rumble_basetime = _id_CAD06C766785FED9.basetime;
  else
    self.rumble_basetime = 1;

  if(isDefined(_id_CAD06C766785FED9.randomaditionaltime))
    self.rumble_randomaditionaltime = _id_CAD06C766785FED9.randomaditionaltime;
  else
    self.rumble_randomaditionaltime = 1;

  _id_C1E5E178D5D956E4.radius = self.rumble_radius;

  for(;;) {
    _id_C1E5E178D5D956E4 waittill("trigger");

    if(vehicle_is_stopped() && !isDefined(self.forcerumble) || !self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(_id_CAD06C766785FED9.rumble);

    if(isDefined(self.vehicletype)) {
      _id_CB3339ECE72DBDEB = self.vehicletype + "_rumble_sfx";

      if(soundexists(_id_CB3339ECE72DBDEB))
        level.player playSound(_id_CB3339ECE72DBDEB);
    }

    while(level.player istouching(_id_C1E5E178D5D956E4) && self.rumbleon && (!vehicle_is_stopped() || isDefined(self.forcerumble))) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait(self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime));
    }

    self stoprumble(_id_CAD06C766785FED9.rumble);
  }
}

vehicle_setteam() {
  classname = get_vehicle_classname();

  if(!isDefined(self.script_team) && isDefined(level.vehicle.templates.team[classname]))
    self.script_team = level.vehicle.templates.team[classname];
}

vehicle_handleunloadevent() {
  self endon("death");
  type = self.vehicletype;

  if(!scripts\engine\utility::ent_flag_exist("unloaded"))
    scripts\engine\utility::ent_flag_init("unloaded");
}

get_vehiclenode_any_dynamic(target) {
  _id_A9C45240836FE2A5 = getvehiclenode(target, "targetname");

  if(!isDefined(_id_A9C45240836FE2A5))
    _id_A9C45240836FE2A5 = getEnt(target, "targetname");
  else if(scripts\common\vehicle::ishelicopter()) {}

  if(!isDefined(_id_A9C45240836FE2A5))
    _id_A9C45240836FE2A5 = scripts\engine\utility::getStruct(target, "targetname");

  return _id_A9C45240836FE2A5;
}

vehicle_damagelogic() {
  self endon("death");
  self.damage_functions = [];
  classname = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.bullet_shield[classname]) && !isDefined(self.script_bulletshield))
    self.script_bulletshield = level.vehicle.templates.bullet_shield[classname];

  if(isDefined(level.vehicle.templates.grenade_shield[classname]) && !isDefined(self.script_grenadeshield))
    self.script_grenadeshield = level.vehicle.templates.grenade_shield[classname];

  if(isDefined(level.vehicle.templates._id_4356B75E0EDDF77D[classname]) && !isDefined(self._id_721298F6D1910C00))
    self._id_721298F6D1910C00 = level.vehicle.templates._id_4356B75E0EDDF77D[classname];

  self.healthbuffer = 100000;
  self.health = self.health + self.healthbuffer;
  self._id_80D0F593608378C1 = self.health;

  while(self.health > 0) {
    self.damageinfo = undefined;
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, _id_799F234362ADB813, partname, _id_44E290FB31B85206, objweapon, origin, angles, normal, inflictor, time);
    partname = scripts\common\vehicle::_id_8ED0FFA3F8BE7C75(partname);
    _id_799F234362ADB813 = scripts\common\vehicle::_id_8ED0FFA3F8BE7C75(_id_799F234362ADB813);

    if(!scripts\engine\utility::flag("scriptables_ready"))
      scripts\engine\utility::flag_wait("scriptables_ready");

    scripts\engine\utility::flag_wait("scriptables_ready");
    _id_4D52D3B077C86DFE = scripts\engine\utility::ter_op(_id_799F234362ADB813 != "", _id_799F234362ADB813, partname);
    amount = _id_8F700DC8E0D2FA89(amount, meansofdeath, time);

    if(!isDefined(meansofdeath) || !isexplosivedamage(meansofdeath, objweapon))
      amount = _id_8DFB977ADEEF3436(amount);

    self.damageinfo["amount"] = amount;
    self.damageinfo["attacker"] = attacker;
    self.damageinfo["direction_vec"] = direction_vec;
    self.damageinfo["damageLocation"] = damagelocation;
    self.damageinfo["MOD"] = meansofdeath;
    self.damageinfo["weapon"] = objweapon;

    if(istrue(self.custom_damage_handler)) {
      return;
    }
    foreach(func in self.damage_functions)
    thread[[func]](amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, _id_799F234362ADB813, partname, _id_44E290FB31B85206, objweapon);

    if(isDefined(attacker)) {
      attacker scripts\engine\utility::script_func("register_shot_hit");

      if(scripts\engine\utility::func_ref_exist("vehicle_damage_modifier")) {
        data = undefined;

        if(isDefined(level.fn_damage_pack))
          data = [[level.fn_damage_pack]](attacker, self, amount, objweapon, meansofdeath, undefined, damagelocation, direction_vec, modelname, partname, _id_799F234362ADB813, _id_44E290FB31B85206);

        if(isDefined(data))
          self.damage_data = data;
        else
          self.damage_data = undefined;

        _id_98AFD1CE36F4905A = scripts\engine\utility::script_func("vehicle_damage_modifier", data);

        if(isDefined(_id_98AFD1CE36F4905A))
          amount = _id_98AFD1CE36F4905A;
      }
    }

    if(scripts\common\vehicle::_id_D7FE44FFB08B499A())
      self.health = self._id_80D0F593608378C1;
    else if(_id_E9ED4F44F9D1D682(attacker))
      self.health = self._id_80D0F593608378C1;
    else if(_id_C948F3A1E60EFD61(attacker, meansofdeath, objweapon))
      self.health = self._id_80D0F593608378C1;
    else if(_id_BA6C52398D8BA7FB(meansofdeath, objweapon))
      self.health = self._id_80D0F593608378C1;
    else {
      if(_id_F237C27C3BA6B34D(meansofdeath))
        self.health = self._id_80D0F593608378C1;

      if(isDefined(self._id_C543F8E941150B0B)) {
        _id_81A21B295824983A = self[[self._id_C543F8E941150B0B]](_id_4D52D3B077C86DFE, meansofdeath, damagelocation);

        if(isDefined(_id_81A21B295824983A)) {
          if(isDefined(self._id_2352359EF3EEFCD3))
            self thread[[self._id_2352359EF3EEFCD3]](attacker, amount, _id_81A21B295824983A, direction_vec, damagelocation);

          if(isstartstr(_id_81A21B295824983A, "tag_armor")) {
            amount = 0;
            self.health = self._id_80D0F593608378C1;
          }
        }
      }

      if(scripts\common\utility::issp() && isDefined(meansofdeath)) {
        if(isDefined(objweapon) && _id_2CFFAF4E15C4AB48(getcompleteweaponname(objweapon)) || !_id_B9EA9D0702ABF6FD(self.health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor)) {
          if(meansofdeath == "MOD_MELEE")
            _id_A1ED6CE90E57BD32(amount, damagelocation, meansofdeath, objweapon, attacker);
          else
            thread _id_B958F96BB17EC92D(_id_4D52D3B077C86DFE, amount, meansofdeath, objweapon, attacker);
        }
      }

      if(scripts\common\vehicle::_id_9E9DFC6F77569F4D())
        self.health = self._id_80D0F593608378C1;
      else {
        self._id_80D0F593608378C1 = self.health;
        scripts\common\vehicle::_id_89CEC1224AE724D5();
      }
    }

    if(scripts\common\vehicle::_id_D7FE44FFB08B499A() || scripts\common\vehicle::_id_9E9DFC6F77569F4D()) {
      continue;
    }
    if(amount >= self._id_FA70E73BAE432D6F * 2)
      self notify("death", attacker, meansofdeath, objweapon, damagelocation);

    if(self.damagestate == "damageHeavy") {
      if(self.health <= self.healthbuffer || _id_4D5539ED20893DF1())
        self notify("death", attacker, meansofdeath, objweapon, damagelocation);

      continue;
    }

    if(isDefined(level.vehicle.templates._id_EBD1D83C2799EF12[classname]) && _id_4D5539ED20893DF1())
      self notify("death", attacker, meansofdeath, objweapon, damagelocation);

    if(scripts\common\vehicle::ishelicopter() && _id_4D5539ED20893DF1())
      self notify("death", attacker, meansofdeath, objweapon, damagelocation);

    _id_47D36F3CB2120A2B = (self.health - self.healthbuffer) / self._id_FA70E73BAE432D6F;

    if(_id_4D5539ED20893DF1())
      self.damagestate = "damageHeavy";
    else if(_id_47D36F3CB2120A2B <= 0.3)
      self.damagestate = "damageHeavy";
    else if(_id_47D36F3CB2120A2B <= 0.65)
      self.damagestate = "damageMedium";
    else if(_id_47D36F3CB2120A2B <= 0.9)
      self.damagestate = "damageLight";
    else
      self.damagestate = "damagePristine";

    if(self isscriptable() && self getscriptablehaspart(self.damagestate) && self getscriptablepartstate(self.damagestate, 1) != self.damagestate)
      scripts\common\utility::_id_3677F2BE30FDD581(self.damagestate, "highSpeed");

    if(self.damagestate == "damageHeavy") {
      scripts\common\vehicle::_id_2D15999DC8BB344A(self._id_FA70E73BAE432D6F * 0.3);
      scripts\common\vehicle::_id_89CEC1224AE724D5();
      self._id_1D8C9C9044EAFCBC = gettime();
      self notify("vehicle_inBurndown");
      childthread _id_A286AECF91C78EFA();
    }
  }
}

_id_8F700DC8E0D2FA89(amount, meansofdeath, time) {
  _id_CD51503D08D24E7D = undefined;

  if(isDefined(meansofdeath) && isendstr(meansofdeath, "_BULLET"))
    _id_CD51503D08D24E7D = 1;
  else
    return amount;

  _id_2B1B3F1A13C63097 = undefined;

  if(istrue(level._id_1DE5ACBB26E97918))
    _id_2B1B3F1A13C63097 = amount * level._id_1DE5ACBB26E97918;

  if(istrue(self._id_1DE5ACBB26E97918))
    _id_2B1B3F1A13C63097 = amount * self._id_1DE5ACBB26E97918;

  if(isDefined(_id_2B1B3F1A13C63097)) {
    _id_957AE339752B129E(amount - _id_2B1B3F1A13C63097);
    amount = _id_2B1B3F1A13C63097;
  }

  return amount;
}

_id_8DFB977ADEEF3436(amount) {
  if(self.damagestate == "damageHeavy") {
    _id_957AE339752B129E(amount * 0.75);
    return amount * 0.25;
  }

  return amount;
}

_id_A183F52B983F5769(amount) {
  _id_2B1B3F1A13C63097 = amount;

  if(istrue(level._id_BD79128B30A2DFB2))
    _id_2B1B3F1A13C63097 = amount * level._id_BD79128B30A2DFB2;

  if(istrue(self._id_BD79128B30A2DFB2))
    _id_2B1B3F1A13C63097 = amount * self._id_BD79128B30A2DFB2;

  return _id_2B1B3F1A13C63097;
}

_id_4A5955251A67BFDA(objweapon) {
  if(!isDefined(objweapon))
    return 1;

  _id_9DC5F2253F8CBF5A = getweaponbasename(objweapon);
  _id_2B1B3F1A13C63097 = 1;

  if(isDefined(level._id_B8E957F2BF26C5E5)) {
    foreach(_id_F90358454413407F in level._id_B8E957F2BF26C5E5) {
      if(_id_F90358454413407F[0] == _id_9DC5F2253F8CBF5A)
        _id_2B1B3F1A13C63097 = _id_F90358454413407F[1];
    }
  }

  if(isDefined(self._id_B8E957F2BF26C5E5)) {
    foreach(_id_F90358454413407F in self._id_B8E957F2BF26C5E5) {
      if(_id_F90358454413407F[0] == _id_9DC5F2253F8CBF5A)
        _id_2B1B3F1A13C63097 = _id_F90358454413407F[1];
    }
  }

  return _id_2B1B3F1A13C63097;
}

_id_A286AECF91C78EFA() {
  self._id_FB29967BDC4900EC = 1;
  scripts\common\vehicle::_id_89CEC1224AE724D5();
  _id_F0784055CABE89A9 = int((self.health - self.healthbuffer) / 30.0 / 0.25) + 1;

  while(gettime() - self._id_1D8C9C9044EAFCBC < 30000) {
    _id_792ED6BAA73AE134 = 30000 - (gettime() - self._id_1D8C9C9044EAFCBC);
    scripts\common\vehicle::_id_28C5281474FFC395(_id_F0784055CABE89A9, undefined, "MOD_EXECUTION");
    wait 1;
  }
}

_id_37A7CBB36025D760() {
  while(gettime() - self._id_1D8C9C9044EAFCBC < 30000) {
    _id_792ED6BAA73AE134 = 30000 - (gettime() - self._id_1D8C9C9044EAFCBC);
    waitframe();
  }

  self notify("death");
}

_id_A1ED6CE90E57BD32(amount, damagelocation, meansofdeath, objweapon, attacker) {
  _id_6071F029B63B07F6 = _id_7BBA68B7E28EC873(64, damagelocation, 1);

  foreach(part in _id_6071F029B63B07F6) {
    switch (level.vehicle._id_AAB9695C92B0ED96[part]) {
      case 5:
        break;
      default:
        _id_6071F029B63B07F6 = scripts\engine\utility::array_remove(_id_6071F029B63B07F6, part);
    }
  }

  _id_6D8C939979ADE635 = scripts\engine\utility::_id_350E192B13BEA45C(_id_6071F029B63B07F6);

  if(isDefined(_id_6D8C939979ADE635) && distancesquared(damagelocation, self gettagorigin(_id_6D8C939979ADE635)) <= squared(64))
    thread _id_B958F96BB17EC92D(_id_6D8C939979ADE635, amount, meansofdeath, objweapon, undefined, 1, damagelocation);
}

_id_F8F1D017591E2C60(health, amount, meansofdeath, objweapon) {
  classname = self.classname;

  if(self.classname == "script_vehicle" && isDefined(self.classname_mp))
    classname = self.classname_mp;

  if(amount >= 110 && (meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_PROJECTILE_SPLASH")) {
    _id_BCD0223EE21642EF = _id_4A5955251A67BFDA(objweapon);

    if(level.vehicle.templates._id_EBD1D83C2799EF12[classname] > 0) {
      _id_C2DDE83463340B3C = self._id_FA70E73BAE432D6F / (level.vehicle.templates._id_EBD1D83C2799EF12[classname] / (0.5 * _id_BCD0223EE21642EF));
      scripts\common\vehicle::_id_CACD62DB1BBE8CB9(amount);
      scripts\common\vehicle::_id_C8A94ACEF0BEB362(_id_C2DDE83463340B3C);
    }

    self._id_EBD1D83C2799EF12 = self._id_EBD1D83C2799EF12 + 0.5 * _id_BCD0223EE21642EF;
    return 1;
  } else if(amount >= 190 && (meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_EXECUTION")) {
    _id_BCD0223EE21642EF = _id_4A5955251A67BFDA(objweapon);

    if(level.vehicle.templates._id_EBD1D83C2799EF12[classname] > 0) {
      _id_C2DDE83463340B3C = self._id_FA70E73BAE432D6F / (level.vehicle.templates._id_EBD1D83C2799EF12[classname] / (1 * _id_BCD0223EE21642EF));
      scripts\common\vehicle::_id_CACD62DB1BBE8CB9(amount);
      scripts\common\vehicle::_id_C8A94ACEF0BEB362(_id_C2DDE83463340B3C);
    }

    self._id_EBD1D83C2799EF12 = self._id_EBD1D83C2799EF12 + 1 * _id_BCD0223EE21642EF;
    return 1;
  }

  return 0;
}

_id_4D5539ED20893DF1() {
  classname = self.classname;

  if(self.classname == "script_vehicle" && isDefined(self.classname_mp))
    classname = self.classname_mp;

  if(level.vehicle.templates._id_EBD1D83C2799EF12[classname] == 0) {
    if(self._id_EBD1D83C2799EF12 > level.vehicle.templates._id_EBD1D83C2799EF12[classname])
      return 1;
  }

  if(level.vehicle.templates._id_EBD1D83C2799EF12[classname] > 0 && self._id_EBD1D83C2799EF12 >= level.vehicle.templates._id_EBD1D83C2799EF12[classname])
    return 1;

  return 0;
}

_id_B9EA9D0702ABF6FD(health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor) {
  if(_id_F8F1D017591E2C60(health, amount, meansofdeath, objweapon)) {
    thread _id_97DE184A1B867545();
    _id_10D73932D2ECD911 = _id_7BBA68B7E28EC873(undefined, damagelocation, 1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_10D73932D2ECD911.size; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 == 4) {
        break;
      }

      if(isDefined(inflictor)) {
        thread _id_B958F96BB17EC92D(_id_10D73932D2ECD911[_id_AC0E594AC96AA3A8], amount * 2, meansofdeath, objweapon, attacker, 1, inflictor.origin);
        continue;
      }

      thread _id_B958F96BB17EC92D(_id_10D73932D2ECD911[_id_AC0E594AC96AA3A8], amount * 2, meansofdeath, objweapon, attacker, 1);
    }

    if(!istrue(self._id_3DADD352FE1D0B39) && isDefined(meansofdeath) && isexplosivedamage(meansofdeath, objweapon))
      thread _id_80B9A13A5F971524(amount, direction_vec, damagelocation, meansofdeath);

    return 1;
  }

  return 0;
}

_id_98C558B067CDD616() {
  if(isDefined(self._id_AAB9695C92B0ED96)) {
    return;
  }
  self._id_AAB9695C92B0ED96 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < getnumparts(self.model); _id_AC0E594AC96AA3A8++) {
    partname = getpartname(self.model, _id_AC0E594AC96AA3A8);
    partname = scripts\common\vehicle::_id_8ED0FFA3F8BE7C75(partname);

    if(scripts\engine\utility::array_contains_key(level.vehicle._id_AAB9695C92B0ED96, partname))
      self._id_AAB9695C92B0ED96[partname] = level.vehicle._id_AAB9695C92B0ED96[partname];
  }
}

_id_97DE184A1B867545() {
  if(!self isscriptable()) {
    return;
  }
  _id_98C558B067CDD616();
  keys = getarraykeys(self._id_AAB9695C92B0ED96);

  foreach(key in keys) {
    if(isstartstr(key, "tag_wind")) {
      self._id_AAB9695C92B0ED96[key] = 0;
      scripts\common\utility::_id_3677F2BE30FDD581(key, "death");
    }
  }
}

_id_B958F96BB17EC92D(_id_4D52D3B077C86DFE, amount, meansofdeath, objweapon, attacker, _id_3605F9462E97466F, origin, _id_42FC86B39F173720) {
  if(!isDefined(_id_3605F9462E97466F))
    _id_3605F9462E97466F = 0;

  if(!isDefined(_id_42FC86B39F173720))
    _id_42FC86B39F173720 = 0;

  if(!isDefined(_id_4D52D3B077C86DFE) || !scripts\engine\utility::array_contains_key(level.vehicle._id_AAB9695C92B0ED96, tolower(_id_4D52D3B077C86DFE))) {
    return;
  }
  if(isDefined(_id_4D52D3B077C86DFE) && isDefined(self._id_9868A2F0E52A82BD) && scripts\engine\utility::array_contains(self._id_9868A2F0E52A82BD, _id_4D52D3B077C86DFE)) {
    if(getdvarint("dvar_CFD8073837710CEF")) {}
  } else {
    _id_98C558B067CDD616();

    if(!_id_3605F9462E97466F)
      _id_957AE339752B129E(amount * 0.5);

    hits = 0;

    if(isDefined(objweapon) && isDefined(objweapon.classname)) {
      if(!isDefined(meansofdeath) || meansofdeath != "MOD_IMPACT") {
        switch (objweapon.classname) {
          case "pistol":
            hits = 0.5;
            break;
          case "rifle":
            hits = 1;
            break;
          case "sniper":
            hits = 4;
            break;
          case "rocketlauncher":
          case "grenade":
            hits = 8;
            break;
        }
      }
    } else if(isDefined(meansofdeath)) {
      switch (meansofdeath) {
        case "MOD_IMPACT":
          hits = 1;
          break;
        case "MOD_MELEE":
          hits = 3;
          break;
        case "MOD_EXECUTION":
          hits = self._id_AAB9695C92B0ED96[_id_4D52D3B077C86DFE];
          break;
      }
    }

    if(_id_D44D56ADF507094E(_id_4D52D3B077C86DFE) && !isPlayer(attacker) || _id_D44D56ADF507094E(_id_4D52D3B077C86DFE) && isai(attacker))
      hits = hits * 0.5;

    if(issubstr(_id_4D52D3B077C86DFE, "tag_wind") && isDefined(meansofdeath) && meansofdeath == "MOD_IMPACT" && isDefined(objweapon) && scripts\engine\utility::is_equal(objweapon.classname, "grenade"))
      hits = 2;

    if(_id_D44D56ADF507094E(_id_4D52D3B077C86DFE) && _id_42FC86B39F173720)
      hits = 0;

    self._id_AAB9695C92B0ED96[_id_4D52D3B077C86DFE] = self._id_AAB9695C92B0ED96[_id_4D52D3B077C86DFE] - hits;

    if(self._id_AAB9695C92B0ED96[_id_4D52D3B077C86DFE] <= 0) {
      if(_id_D44D56ADF507094E(_id_4D52D3B077C86DFE) && !_id_42FC86B39F173720) {
        if(scripts\common\vehicle::_id_B7148A3BFC4DEFB2() || getdvarint("dvar_F0F3E5A83F3F2843") && scripts\common\vehicle::_id_34A2EB36FBCA6E89()) {
          _id_2C0CBB2E9B2CD03F = _id_0F18B042694D92F4();

          switch (_id_4D52D3B077C86DFE) {
            case "tag_wheel_center_front_left":
              _id_B1AAB60676C543FE(0, "fl");
              break;
            case "tag_wheel_center_front_right":
              _id_B1AAB60676C543FE(1, "fr");
              break;
            case "tag_wheel_center_middle_left":
              _id_B1AAB60676C543FE(2, "ml");
              break;
            case "tag_wheel_center_middle_right":
              _id_B1AAB60676C543FE(3, "mr");
              break;
            case "tag_wheel_center_back_left":
              if(_id_2C0CBB2E9B2CD03F > 4)
                _id_B1AAB60676C543FE(4, "bl");
              else
                _id_B1AAB60676C543FE(2, "bl");

              break;
            case "tag_wheel_center_back_right":
              if(_id_2C0CBB2E9B2CD03F > 4)
                _id_B1AAB60676C543FE(5, "br");
              else
                _id_B1AAB60676C543FE(3, "br");

              break;
          }
        }
      }

      scripts\common\utility::_id_3677F2BE30FDD581(_id_4D52D3B077C86DFE, "death");
      classname = get_vehicle_classname();

      if(isDefined(level.vehicle.templates._id_A72227C6BFA8A146[classname]) && isDefined(level.vehicle.templates._id_A72227C6BFA8A146[classname][_id_4D52D3B077C86DFE])) {
        foreach(part in level.vehicle.templates._id_A72227C6BFA8A146[classname][_id_4D52D3B077C86DFE]) {
          if(self._id_AAB9695C92B0ED96[part] > 0)
            scripts\common\utility::_id_3677F2BE30FDD581(part, "death");
        }

        return;
      }

      return;
    }

    if(issubstr(_id_4D52D3B077C86DFE, "tag_wind") && self._id_AAB9695C92B0ED96[_id_4D52D3B077C86DFE] <= 3)
      scripts\common\utility::_id_3677F2BE30FDD581(_id_4D52D3B077C86DFE, "webbed");
  }
}

_id_D44D56ADF507094E(_id_4D52D3B077C86DFE) {
  switch (_id_4D52D3B077C86DFE) {
    case "tag_wheel_center_back_left":
    case "tag_wheel_center_back_right":
    case "tag_wheel_center_middle_left":
    case "tag_wheel_center_front_left":
    case "tag_wheel_center_middle_right":
    case "tag_wheel_center_front_right":
      return 1;
    default:
      return 0;
  }
}

vehicle_isalive(vehicle) {
  if(!isDefined(vehicle))
    return 0;

  if(isDefined(vehicle.healthbuffer) && vehicle.health < vehicle.healthbuffer)
    return 0;

  if(vehicle.health <= 0)
    return 0;

  return 1;
}

grenadeshielded(type, objweapon) {
  if(!isDefined(self.script_grenadeshield))
    return 0;

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "grenade"))
    return 0;

  if(isDefined(level.vehicle.templates._id_7412CA7553957E74[get_vehicle_classname()])) {
    if(scripts\engine\utility::array_contains(level.vehicle.templates._id_7412CA7553957E74[get_vehicle_classname()], getweaponbasename(objweapon)))
      return 0;
  }

  if(self.script_grenadeshield)
    return 1;
  else
    return 0;
}

bulletshielded(type) {
  if(!isDefined(self.script_bulletshield))
    return 0;

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "bullet") || issubstr(type, "explosive"))
    return 0;

  if(self.script_bulletshield)
    return 1;
  else
    return 0;
}

explosive_bulletshielded(type) {
  if(!isDefined(self.script_explosive_bullet_shield))
    return 0;

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "explosive"))
    return 0;

  if(self.script_explosive_bullet_shield)
    return 1;
  else
    return 0;
}

vehicle_should_regenerate(attacker, type, objweapon) {
  return _id_F237C27C3BA6B34D(type) || _id_E9ED4F44F9D1D682(attacker) || _id_C948F3A1E60EFD61(attacker, type, objweapon) || _id_BA6C52398D8BA7FB(type);
}

_id_F237C27C3BA6B34D(type) {
  return type == "MOD_MELEE";
}

_id_E9ED4F44F9D1D682(attacker) {
  return !isDefined(attacker) && self.script_team != "neutral" || attacker_isonmyteam(attacker) || attacker_troop_isonmyteam(attacker) || is_invulnerable_from_ai(attacker);
}

_id_C948F3A1E60EFD61(attacker, type, objweapon) {
  return isDefined(level._id_D1D6757F3C58E700) && [[level._id_D1D6757F3C58E700]](attacker, type, objweapon);
}

_id_BA6C52398D8BA7FB(type, objweapon) {
  return bulletshielded(type) || explosive_bulletshielded(type) || grenadeshielded(type, objweapon);
}

is_invulnerable_from_ai(attacker) {
  if(!isDefined(self.script_ai_invulnerable))
    return 0;

  if(isDefined(attacker) && isai(attacker) && self.script_ai_invulnerable == 1)
    return 1;
  else
    return 0;
}

attacker_troop_isonmyteam(attacker) {
  if(getdvarint("dvar_FB816855F6554343"))
    return 0;

  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(attacker) && isPlayer(attacker))
    return 1;
  else if(isai(attacker) && scripts\engine\utility::is_equal(attacker.team, self.script_team))
    return 1;
  else
    return 0;
}

attacker_isonmyteam(attacker) {
  if(getdvarint("dvar_FB816855F6554343"))
    return 0;

  if(isDefined(attacker) && isDefined(attacker.script_team) && isDefined(self.script_team) && attacker.script_team == self.script_team)
    return 1;

  return 0;
}

vehicle_setwheeldirection(direction) {
  self.vehiclewheeldirection = scripts\engine\utility::ter_op(direction <= 0, 0, 1);
}

vehicle_playexhausteffect() {
  self endon("entitydeleted");
  self endon("death");

  if(!isDefined(level.vehicle.templates.exhaust_fx[self.model])) {
    return;
  }
  for(;;) {
    playFXOnTag(level.vehicle.templates.exhaust_fx[self.model], self, "tag_engine_exhaust");
    waitframe();
  }
}

vehicle_playengineeffect() {
  _id_B86B9B1031E6DBA9 = level.vehicle.templates.engine_fx[self.classname];

  if(!isDefined(_id_B86B9B1031E6DBA9)) {
    return;
  }
  _id_9E6A1FE8AE2E1CA7 = 0.25;
  _id_5AFF5311307E6110 = undefined;
  _id_35C675F4F473AB8C = undefined;

  for(;;) {
    if(!vehicle_isalive(self)) {
      return;
    }
    _id_D1D99B2513672267 = _id_B86B9B1031E6DBA9.effect;
    _id_35C675F4F473AB8C = _id_B86B9B1031E6DBA9.effect_tag;
    _id_0425FFE7428F07FF = self vehicle_getspeed() / self vehicle_gettopspeedforward();

    if(isDefined(self.enginefx_effort_scale))
      _id_0425FFE7428F07FF = _id_0425FFE7428F07FF * self.enginefx_effort_scale;

    if(isDefined(_id_B86B9B1031E6DBA9.max_effort_effect) && _id_0425FFE7428F07FF >= _id_B86B9B1031E6DBA9.max_effort_ratio)
      _id_D1D99B2513672267 = _id_B86B9B1031E6DBA9.max_effort_effect;
    else if(isDefined(_id_B86B9B1031E6DBA9.med_effort_effect) && _id_0425FFE7428F07FF >= _id_B86B9B1031E6DBA9.med_effort_ratio)
      _id_D1D99B2513672267 = _id_B86B9B1031E6DBA9.med_effort_effect;
    else if(isDefined(_id_B86B9B1031E6DBA9.min_effort_effect) && _id_0425FFE7428F07FF >= _id_B86B9B1031E6DBA9.min_effort_ratio)
      _id_D1D99B2513672267 = _id_B86B9B1031E6DBA9.min_effort_effect;

    if(!isDefined(_id_5AFF5311307E6110) || _id_5AFF5311307E6110 != _id_D1D99B2513672267) {
      if(isDefined(_id_5AFF5311307E6110)) {
        stopFXOnTag(_id_5AFF5311307E6110, self, _id_35C675F4F473AB8C);
        waitframe();

        if(!vehicle_isalive(self))
          return;
      }

      playFXOnTag(_id_D1D99B2513672267, self, _id_35C675F4F473AB8C);
      _id_5AFF5311307E6110 = _id_D1D99B2513672267;
    }

    wait(_id_9E6A1FE8AE2E1CA7);
  }
}

vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");

  if(scripts\common\vehicle::ishelicopter()) {
    self setgoalyaw(scripts\engine\utility::flat_angle(self.angles)[1]);
    self setvehgoalpos(self.origin + (0, 0, 4), 1);
  }
}

deathrollon() {
  if(self.health > 0)
    self.rollingdeath = 1;
}

deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

get_vehicle_riders_spawners() {
  spawners = [];

  if(isDefined(self.target)) {
    targets = scripts\engine\utility::noself_func_return("getspawnerarray", self.target);

    if(!isDefined(targets))
      targets = scripts\engine\utility::getStructArray(self.target, "targetname");

    if(!isDefined(targets))
      targets = [];

    foreach(target in targets) {
      if(isstruct(target)) {
        if(!isDefined(target.script_demeanor))
          continue;
      } else {
        if(!issubstr(target.code_classname, "actor") && !issubstr(target.code_classname, "vehicle")) {
          continue;
        }
        if(issubstr(target.code_classname, "actor")) {
          if(!isspawner(target))
            continue;
          else if(issubstr(target.code_classname, "vehicle")) {
            if(!(target.spawnflags & 2))
              continue;
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

setvehgoalpos_wrap(origin, _id_56BF21256ACD1819) {
  return _setvehgoalpos_wrap(origin, _id_56BF21256ACD1819);
}

vehicle_liftoffvehicle(height) {
  if(!isDefined(height))
    height = 512;

  destination = self.origin + (0, 0, height);
  self setneargoalnotifydist(10);
  setvehgoalpos_wrap(destination, 1);
  self waittill("goal");
}

vehicle_shouldplaydeathanimation(vehicle) {
  if(!vehicle_hasdeathanimations(vehicle))
    return 0;

  if(istrue(self.vehicle_skipdeathanimation))
    return 0;

  return 1;
}

vehicle_hasdeathanimations(vehicle) {
  return isDefined(level.vehicle.templates.deathanimations[vehicle get_vehicle_classname()]);
}

vehicle_getdeathanimation(vehicle, damagelocation) {
  deathanimations = level.vehicle.templates.deathanimations[vehicle get_vehicle_classname()];

  if(isDefined(damagelocation)) {
    _id_67526FFE5EB4DA55 = vehicle getpointinbounds(0.5, 0.5, 0.5);
    _id_4F61353D9FF59711 = damagelocation - _id_67526FFE5EB4DA55;
    _id_8E4D6CA7020FE22F = [];
    _id_8E4D6CA7020FE22F["forward"] = anglesToForward(vehicle.angles);
    _id_8E4D6CA7020FE22F["right"] = anglestoright(vehicle.angles);
    _id_8E4D6CA7020FE22F["backward"] = _id_8E4D6CA7020FE22F["forward"] * -1;
    _id_8E4D6CA7020FE22F["left"] = _id_8E4D6CA7020FE22F["right"] * -1;
    _id_D65DAFAE56AA5229 = undefined;
    _id_68579A660D72AC02 = -999999;
    _id_3E8E874097F3600A = ["forward", "right", "backward", "left"];

    foreach(_id_9996E4DCD9EF33F5 in _id_3E8E874097F3600A) {
      direction = _id_8E4D6CA7020FE22F[_id_9996E4DCD9EF33F5];
      _id_DE514D79C19A246B = scripts\engine\math::scalar_projection(direction, _id_4F61353D9FF59711);

      if(!isDefined(_id_D65DAFAE56AA5229) || _id_DE514D79C19A246B > _id_68579A660D72AC02) {
        _id_D65DAFAE56AA5229 = _id_9996E4DCD9EF33F5;
        _id_68579A660D72AC02 = _id_DE514D79C19A246B;
      }
    }

    return deathanimations[_id_D65DAFAE56AA5229];
  } else
    return scripts\engine\utility::random(deathanimations);
}

vehicle_playdeathanimation(_id_B4455C2804D48521) {
  self vehicle_turnengineoff();
  scripts\engine\utility::self_func("vehicle_orientto", self.origin, self.angles, 0, 0);
  self useanimtree(#animtree);
  self animScripted("vehicle_playDeathAnimation", self.origin, self.angles, _id_B4455C2804D48521);
  self setneargoalnotifydist(30);

  if(scripts\common\vehicle::ishelicopter()) {
    self setvehgoalpos(self.origin, 1);
    self setgoalyaw(self.angles[1]);
  }
}

vehicle_setcrashing(_id_B96D126FC701024B) {
  self.vehiclecrashing = _id_B96D126FC701024B;
}

vehicle_docrash(attacker, cause) {
  if(istrue(self.vehicle_skipdeathcrash)) {
    return;
  }
  vehicle_setcrashing(1);
  _id_B990362C13178E7D = getdvarint("vehlegacyhelipathingforphysicshelicopters") != 0 && scripts\common\vehicle::ishelicopter() && self vehicle_isphysveh();

  if(self vehicle_isphysveh() && !_id_B990362C13178E7D) {
    self vehphys_crash();

    if(!istrue(self.dontdisconnectpaths))
      self disconnectPaths();

    while(!vehicle_iscorpse() && isDefined(self) && !vehicle_is_stopped())
      waitframe();
  } else if(scripts\common\vehicle::ishelicopter()) {
    thread vehicle_helicoptercrash(attacker, cause);
    self waittill("vehicle_crashDone");
  }

  vehicle_setcrashing(0);
}

vehicle_helicoptercrash(attacker, cause) {
  if(isDefined(attacker) && isPlayer(attacker))
    self.original_attacker = attacker;

  if(!isDefined(self)) {
    return;
  }
  detach_getoutrigs();
  thread helicopter_crash_move(attacker, cause);
}

helicopter_crash_move(attacker, cause) {
  self endon("in_air_explosion");

  if(isDefined(self.perferred_crash_location))
    _id_BE1CCD90B435B15A = self.perferred_crash_location;
  else if(isDefined(level.vehicle._id_4BD4E750E5A8E895))
    _id_BE1CCD90B435B15A = [[level.vehicle._id_4BD4E750E5A8E895]](self);
  else {
    _id_5DE6274DA9793141 = get_unused_crash_locations();
    _id_BE1CCD90B435B15A = scripts\engine\utility::getclosest(self.origin, _id_5DE6274DA9793141);
  }

  _id_BE1CCD90B435B15A.claimed = 1;
  self notify("newpath");
  self notify("deathspin");
  _id_2D8B0EB3F94EACB7 = 0;
  direct = 0;

  if(isDefined(_id_BE1CCD90B435B15A.script_parameters) && _id_BE1CCD90B435B15A.script_parameters == "direct")
    direct = 1;

  if(isDefined(self.heli_crash_indirect_zoff)) {
    direct = 0;
    _id_2D8B0EB3F94EACB7 = self.heli_crash_indirect_zoff;
  }

  if(direct) {
    crash_speed = 40;
    self vehicle_setspeed(crash_speed, 15, 10);
    self setneargoalnotifydist(_id_BE1CCD90B435B15A.radius);
    self setvehgoalpos(_id_BE1CCD90B435B15A.origin, 0);
    thread helicopter_crash_flavor(_id_BE1CCD90B435B15A.origin, crash_speed);
    scripts\engine\utility::waittill_any_2("goal", "near_goal");
    helicopter_crash_path(_id_BE1CCD90B435B15A);
  } else {
    _id_A6F9945AF3300F2D = (_id_BE1CCD90B435B15A.origin[0], _id_BE1CCD90B435B15A.origin[1], self.origin[2] + _id_2D8B0EB3F94EACB7);

    if(isDefined(self.heli_crash_lead)) {
      _id_A6F9945AF3300F2D = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
      _id_A6F9945AF3300F2D = (_id_A6F9945AF3300F2D[0], _id_A6F9945AF3300F2D[1], _id_A6F9945AF3300F2D[2] + _id_2D8B0EB3F94EACB7);
    }

    crash_speed = 20;

    if(isDefined(self.crash_speed))
      crash_speed = self.crash_speed;

    self vehicle_setspeed(crash_speed, 10, 10);
    self setneargoalnotifydist(350);
    self setvehgoalpos(_id_A6F9945AF3300F2D, 1);
    thread helicopter_crash_flavor(_id_A6F9945AF3300F2D, 40);
    msg = "blank";

    while(msg != "death") {
      msg = scripts\engine\utility::waittill_any_3("goal", "near_goal", "death");

      if(!isDefined(msg) && !isDefined(self)) {
        _id_BE1CCD90B435B15A.claimed = undefined;
        self notify("vehicle_crashDone");
        return;
      } else
        msg = "death";
    }

    self setvehgoalpos(_id_BE1CCD90B435B15A.origin, 0);
    self waittill("goal");
    helicopter_crash_path(_id_BE1CCD90B435B15A);
  }

  _id_BE1CCD90B435B15A.claimed = undefined;
  self notify("stop_crash_loop_sound");
  self notify("vehicle_crashDone");
}

helicopter_crash_path(_id_BE1CCD90B435B15A) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(_id_BE1CCD90B435B15A.target)) {
    _id_BE1CCD90B435B15A = scripts\engine\utility::getStruct(_id_BE1CCD90B435B15A.target, "targetname");
    radius = 56;

    if(isDefined(_id_BE1CCD90B435B15A.radius))
      radius = _id_BE1CCD90B435B15A.radius;

    self setneargoalnotifydist(radius);
    self setvehgoalpos(_id_BE1CCD90B435B15A.origin, 0);
    scripts\engine\utility::waittill_any_2("goal", "near_goal");
  }
}

helicopter_crash_flavor(_id_4351410D12107DF3, crash_speed) {
  self endon("vehicle_crashDone");
  self clearlookatent();

  if(soundexists("hind_helicopter_dying_loop"))
    self playLoopSound("hind_helicopter_dying_loop");

  style = 0;

  if(isDefined(self.preferred_crash_style)) {
    style = self.preferred_crash_style;

    if(self.preferred_crash_style < 0) {
      _id_21BC11AA48ABF8E7 = [1, 2, 2];
      total = 5;
      _id_CB8E2003144AC503 = randomint(total);
      _id_302E82DA1A1989AD = 0;

      foreach(_id_AC0E594AC96AA3A8, val in _id_21BC11AA48ABF8E7) {
        _id_302E82DA1A1989AD = _id_302E82DA1A1989AD + val;

        if(_id_CB8E2003144AC503 < _id_302E82DA1A1989AD) {
          style = _id_AC0E594AC96AA3A8;
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
      thread helicopter_crash_directed(_id_4351410D12107DF3, crash_speed);
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

helicopter_in_air_explosion() {
  _id_9EF41E2C046AD906 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.vehicle_rocket_death_fx[_id_9EF41E2C046AD906])) {
    _id_21CB1C59019B56F7 = level.vehicle.templates.vehicle_rocket_death_fx[_id_9EF41E2C046AD906];
    struct = _id_21CB1C59019B56F7[2];

    if(isDefined(struct) && isDefined(struct.waitdelay))
      wait(struct.waitdelay);

    waitframe();
  }

  self notify("vehicle_crashDone");
  self notify("in_air_explosion");
}

helicopter_pilot_death_explosion() {
  thread helicopter_crash_rotate();
  scripts\engine\utility::waittill_notify_or_timeout("goal", 5);
  self notify("flavor_done");
  thread helicopter_in_air_explosion();
}

helicopter_unloading_watcher() {
  if(!scripts\common\vehicle::ishelicopter()) {
    return;
  }
  self endon("vehicle_crashDone");
  self waittill("unloading");
  self.unloading = 1;
  self waittill("unloaded");
  self.unloading = 0;
}

helicopter_crash_directed(_id_4351410D12107DF3, crash_speed) {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  _id_FC583FE931147501 = 90 * randomintrange(-2, 3);

  for(;;) {
    _id_7F96D62F3ABBF9B9 = _id_4351410D12107DF3 - self.origin;
    yaw = vectortoyaw(_id_7F96D62F3ABBF9B9);
    yaw = yaw + _id_FC583FE931147501;
    self settargetyaw(yaw);
    wait 0.1;
  }
}

helicopter_crash_zigzag() {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  dir = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    _id_3F403475C9BCA3F7 = randomintrange(20, 120);

    if(dir)
      self settargetyaw(self.angles[1] + _id_3F403475C9BCA3F7);
    else
      self settargetyaw(self.angles[1] - _id_3F403475C9BCA3F7);

    dir = 1 - dir;
    _id_F0EAEFB65F1333F0 = randomfloatrange(0.5, 1.0);
    wait(_id_F0EAEFB65F1333F0);
  }
}

helicopter_crash_rotate() {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    _id_3F403475C9BCA3F7 = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + _id_3F403475C9BCA3F7);
    wait 0.5;
  }
}

get_unused_crash_locations() {
  _id_5DE6274DA9793141 = [];
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_removeundefined(level.vehicle.helicopter_crash_locations);

  foreach(location in level.vehicle.helicopter_crash_locations) {
    if(isDefined(location.claimed)) {
      continue;
    }
    _id_5DE6274DA9793141[_id_5DE6274DA9793141.size] = location;
  }

  return _id_5DE6274DA9793141;
}

vehicle_iscorpse() {
  return isDefined(self) && get_vehicle_classname() == "script_vehicle_corpse";
}

detach_getoutrigs() {
  if(!isDefined(self.fastroperig)) {
    return;
  }
  if(!self.fastroperig.size) {
    return;
  }
  keys = getarraykeys(self.fastroperig);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self.fastroperig[keys[_id_AC0E594AC96AA3A8]]))
      self.fastroperig[keys[_id_AC0E594AC96AA3A8]] unlink();
  }
}

vehicle_setdeathmodel() {
  if(!isDefined(level.vehicle.templates.deathmodel[self.model])) {
    return;
  }
  if(istrue(self.vehicle_skipdeathmodel)) {
    return;
  }
  if(self isscriptable()) {
    if(scripts\common\vehicle::ishelicopter()) {
      return;
    }
    deathmodel = spawn("script_model", self.origin);
    deathmodel.angles = self.angles;
    deathmodel setModel(level.vehicle.templates.deathmodel[self.model]);
  } else
    self setModel(level.vehicle.templates.deathmodel[self.model]);
}

_id_1E9728E5E662ACA3(_id_FB41D1CA75009BF0) {
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
        position = rider._blackboard._id_9176CAE5619D7FBA;
      } else {
        vehicle = rider.ridingvehicle;
        position = rider.vehicle_position;
      }

      aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, position);

      if(isDefined(aianims) && isDefined(aianims.sittag))
        rider unlink();

      rider linkTo(_id_FB41D1CA75009BF0, aianims.sittag);
    }
  }
}

_id_5D04267DD0768069(_id_D66A76615076CAD3) {
  if(!isDefined(level.vehicle._id_925BE33F50560119))
    level.vehicle._id_925BE33F50560119 = [];
  else
    level.vehicle._id_925BE33F50560119 = scripts\engine\utility::array_removeundefined(level.vehicle._id_925BE33F50560119);

  velocity = self vehicle_getvelocity();

  if(istrue(self._id_0083B8F4F5A22568)) {
    velocity = self vehicle_getvelocity();
    velocity = velocity * 5;
  }

  model = _id_D0E99A4F0C29166E();
  _id_8413CC84ECA03D21 = "";

  if(issubstr(model, "::")) {
    _id_8413CC84ECA03D21 = strtok(model, "::")[0] + "::";
    model = strtok(model, "::")[1];

    if(!istrue(level.vehicle.templates._id_893DA51CF12B2C8B[model]))
      _id_8413CC84ECA03D21 = "";
  }

  self notsolid();
  classname = scripts\engine\utility::_id_53C4C53197386572(self.classname_mp, self.classname);
  _id_FB41D1CA75009BF0 = spawnVehicle(_id_8413CC84ECA03D21 + level.vehicle.templates._id_FB41D1CA75009BF0[model], "vehicle_husk", level.vehicle.templates._id_CFB2CE4545421678[model], self.origin, self.angles, undefined, velocity);
  _id_FB41D1CA75009BF0._id_B7148A3BFC4DEFB2 = 1;
  _id_FB41D1CA75009BF0.classname_mp = classname;
  _id_FB41D1CA75009BF0 scripts\common\vehicle::_id_2D15999DC8BB344A(level.vehicle.templates.life[classname] + 100000);
  _id_FB41D1CA75009BF0._id_FA70E73BAE432D6F = level.vehicle.templates.life[classname];
  _id_FB41D1CA75009BF0._id_DB6BBCA31492C586 = model;
  _id_FB41D1CA75009BF0._id_EBD1D83C2799EF12 = 0;
  _id_FB41D1CA75009BF0._id_A784428198C5658B = self._id_A784428198C5658B;
  _id_FB41D1CA75009BF0._id_0D9ECF3D795727BB = self._id_84BCA5671C65C2AA;
  _id_FB41D1CA75009BF0._id_1B84F0B023DD1CA7 = self._id_1B84F0B023DD1CA7;

  if(!_id_FB41D1CA75009BF0 _meth_01E8542A707A8002("animator"))
    _id_FB41D1CA75009BF0 _meth_D2E41C7603BA7697("animator");

  self notify("vehicle_huskCreation", _id_FB41D1CA75009BF0);

  if(isDefined(self._id_27C9E774969793BC))
    _id_FB41D1CA75009BF0 thread[[self._id_27C9E774969793BC]]();

  level.vehicle._id_925BE33F50560119 = scripts\engine\utility::array_add(level.vehicle._id_925BE33F50560119, _id_FB41D1CA75009BF0);

  if(isDefined(self.spawnflags) && (self.spawnflags & 8 || istrue(_id_FB41D1CA75009BF0._id_A784428198C5658B)))
    _id_FB41D1CA75009BF0 _meth_65AA053C077C003A(1);

  _id_FB41D1CA75009BF0 scripts\common\vehicle::_id_9CE59AA48970A667();
  _id_FB41D1CA75009BF0 vehicle_turnengineoff();
  _id_FB41D1CA75009BF0 scripts\engine\utility::delaycall(0.05, ::vehphys_crash);
  _id_FB41D1CA75009BF0 _id_98C558B067CDD616();

  if(getdvarint("dvar_CFD8073837710CEF"))
    scripts\engine\utility::draw_arrow_time(_id_FB41D1CA75009BF0.origin, _id_FB41D1CA75009BF0.origin + velocity, (0, 1, 1), 1000);

  if(istrue(self._id_1DE5ACBB26E97918))
    _id_FB41D1CA75009BF0._id_1DE5ACBB26E97918 = self._id_1DE5ACBB26E97918;

  if(!istrue(_id_D66A76615076CAD3))
    _id_FB41D1CA75009BF0 thread _id_B43AB7B2056ECB9A();

  if(!istrue(_id_D66A76615076CAD3) && !istrue(self._id_3DADD352FE1D0B39))
    _id_FB41D1CA75009BF0 thread _id_2B8B11C3C14C9BAA(self, undefined);

  _id_FB41D1CA75009BF0 thread disconnect_paths_whenstopped();
  _id_FB41D1CA75009BF0 thread _id_FD3542824F9C1BD2();
  _id_FB41D1CA75009BF0 thread _id_2D9C04D7FE4E6719(self);
  _id_FB41D1CA75009BF0 thread _id_4286DE11E406088F();

  if(isDefined(self._id_AAB9695C92B0ED96)) {
    foreach(_id_AC0E594AC96AA3A8, health in self._id_AAB9695C92B0ED96) {
      if(health <= 0)
        _id_FB41D1CA75009BF0._id_AAB9695C92B0ED96[_id_AC0E594AC96AA3A8] = 0;
    }
  }

  _id_1E9728E5E662ACA3(_id_FB41D1CA75009BF0);
  return _id_FB41D1CA75009BF0;
}

_id_18657584B6BD786A(_id_D66A76615076CAD3) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  _id_FB41D1CA75009BF0 = _id_5D04267DD0768069(_id_D66A76615076CAD3);
  self delete();
  return _id_FB41D1CA75009BF0;
}

_id_B43AB7B2056ECB9A(state) {
  if(!self isscriptable()) {
    return;
  }
  if(!isDefined(state))
    state = "on";

  scripts\common\utility::_id_3677F2BE30FDD581("damage_transition", state);
  scripts\common\utility::_id_3677F2BE30FDD581("floor_fire", state);

  if(!istrue(self._id_1B84F0B023DD1CA7))
    scripts\common\utility::_id_3677F2BE30FDD581("smoke_heavy", state);
}

_id_2B8B11C3C14C9BAA(parent, spawndata, _id_09F889D0177ED067) {
  if(!self vehicle_isphysveh()) {
    return;
  }
  if(istrue(self._id_A784428198C5658B)) {
    if(getdvarint("dvar_CFD8073837710CEF")) {}

    return;
  }

  if(isDefined(parent) && istrue(parent._id_880B13DDE87CE358)) {
    return;
  }
  if(isDefined(parent) && istrue(parent._id_0083B8F4F5A22568)) {
    return;
  }
  if(isDefined(parent) && isDefined(parent.damageinfo)) {
    _id_18C97A374D7EC7A5 = parent.damageinfo["amount"];
    damagedir = parent.damageinfo["direction_vec"];
    damagelocation = parent.damageinfo["damageLocation"];
    damagemod = parent.damageinfo["MOD"];
  } else {
    _id_18C97A374D7EC7A5 = 600;
    damagedir = undefined;
    damagelocation = self.origin;
    damagemod = "";
  }

  if(isDefined(parent) && isDefined(parent._id_84BCA5671C65C2AA) && gettime() - parent._id_84BCA5671C65C2AA < 1000) {
    if(getdvarint("dvar_CFD8073837710CEF")) {}

    _id_18C97A374D7EC7A5 = _id_18C97A374D7EC7A5 * 0.1;
  }

  if(isDefined(damagedir))
    damagedir = (damagedir[0], damagedir[1], 0.25);
  else
    damagedir = (randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25), 0.25);

  _id_055BEFC5188EA09B = _id_90F94B8850010576(_id_18C97A374D7EC7A5, damagemod, damagelocation, 0.3);

  if(isDefined(_id_09F889D0177ED067))
    _id_055BEFC5188EA09B = _id_055BEFC5188EA09B * _id_09F889D0177ED067;

  self _meth_E0201404A8B6F664(damagedir, _id_055BEFC5188EA09B, 1);

  if(getdvarint("dvar_CFD8073837710CEF"))
    scripts\engine\utility::draw_arrow_time(damagelocation, damagelocation + anglesToForward(vectortoangles(damagedir)) * _id_055BEFC5188EA09B, (1, 0, 1), 1000);

  self._id_84BCA5671C65C2AA = gettime();
}

_id_80B9A13A5F971524(amount, damagedir, damagelocation, meansofdeath) {
  if(!self vehicle_isphysveh()) {
    return;
  }
  if(istrue(self._id_A784428198C5658B)) {
    if(getdvarint("dvar_CFD8073837710CEF")) {}

    return;
  }

  if(self._id_80D0F593608378C1 <= self.healthbuffer + 1) {
    if(getdvarint("dvar_CFD8073837710CEF")) {}

    return;
  }

  if(isDefined(self._id_0D9ECF3D795727BB) && gettime() - self._id_0D9ECF3D795727BB < 1000) {
    if(getdvarint("dvar_CFD8073837710CEF")) {}

    amount = amount * 0.1;
  }

  if(!isDefined(self._id_84BCA5671C65C2AA))
    self._id_84BCA5671C65C2AA = gettime();
  else if(gettime() - self._id_84BCA5671C65C2AA < 1000) {
    if(getdvarint("dvar_CFD8073837710CEF")) {}

    amount = amount * 0.1;
  }

  _id_055BEFC5188EA09B = _id_90F94B8850010576(amount, meansofdeath, damagelocation);
  damagedir = (damagedir[0], damagedir[1], 0.25);
  self _meth_E0201404A8B6F664(damagedir, _id_055BEFC5188EA09B, 1);

  if(getdvarint("dvar_CFD8073837710CEF"))
    scripts\engine\utility::draw_arrow_time(damagelocation, damagelocation + anglesToForward(vectortoangles(damagedir)) * _id_055BEFC5188EA09B, (1, 0, 1), 1000);

  self._id_84BCA5671C65C2AA = gettime();
}

_id_90F94B8850010576(amount, meansofdeath, damagelocation, _id_5B76EEF9FAB1DECA) {
  if(!isDefined(_id_5B76EEF9FAB1DECA))
    _id_5B76EEF9FAB1DECA = 1;

  amount = scripts\engine\utility::ter_op(amount > 600, 600, amount);

  if(isDefined(meansofdeath)) {
    meansofdeath = tolower(meansofdeath);

    if(meansofdeath == "mod_projectile_splash")
      amount = amount * 0.75;
  }

  if(self _meth_01E8542A707A8002("p2p"))
    amount = amount * 0.1;

  _id_C98EC20E8E72D5C5 = self _meth_03DDA404001A83EE("mass");
  _id_7002C1806613B11F = _id_C98EC20E8E72D5C5 * 0.1 * _id_5B76EEF9FAB1DECA;
  _id_42E6394B5597D748 = scripts\engine\math::normalize_value(600, 0, amount);
  _id_055BEFC5188EA09B = _id_7002C1806613B11F * _id_42E6394B5597D748;

  if(scripts\common\vehicle::_id_E751A1EB999DD1A5())
    _id_055BEFC5188EA09B = _id_055BEFC5188EA09B * 0.25;

  if(getdvarint("dvar_CFD8073837710CEF")) {}

  return _id_055BEFC5188EA09B;
}

_id_2D9C04D7FE4E6719(parent) {
  if(self isscriptable()) {
    _id_E72978AA7C06EE3C = ["tag_hood", "tag_antenna", "tag_mirror_left", "tag_mirror_right", "tag_bumper_front", "tag_bumper_back", "tag_windshield_front", "tag_windshield_front_pristine", "tag_windshield_front_web", "tag_windshield_back", "tag_window_front_left", "tag_window_front_right", "tag_window_back_left", "tag_window_back_right", "tag_window_back_left_corner", "tag_window_back_right_corner", "tag_window_sunroof", "tag_hubcap_front_left", "tag_hubcap_front_right", "tag_hubcap_back_left", "tag_hubcap_back_right", "tag_wheel_spare"];

    foreach(part in _id_E72978AA7C06EE3C) {
      if(isDefined(parent._id_AAB9695C92B0ED96) && isDefined(parent._id_AAB9695C92B0ED96[part])) {
        if(parent._id_AAB9695C92B0ED96[part] <= 0)
          state = "hide";
        else {
          self._id_AAB9695C92B0ED96[part] = 0;
          state = "death";
        }

        scripts\common\utility::_id_3677F2BE30FDD581(part, state);
      }
    }

    _id_0DE1AF8851D79E89 = ["tag_door_front_left", "tag_door_front_right", "tag_door_back_left", "tag_door_back_right", "tag_bumper_front_damaged", "tag_bumper_back_damaged", "tag_light_front_left", "tag_light_front_right", "tag_light_front_left_2", "tag_light_front_right_2", "tag_light_back_left", "tag_light_back_right", "tag_light_back_left_2", "tag_light_back_right_2", "tag_light_top_left", "tag_light_top_right", "tag_light_front_middle", "tag_light_front_top", "tag_light_back_top", "tag_wheel_center_front_left", "tag_wheel_center_front_right", "tag_wheel_center_middle_left", "tag_wheel_center_middle_right", "tag_wheel_center_back_left", "tag_wheel_center_back_right"];

    foreach(part in _id_0DE1AF8851D79E89) {
      state = undefined;

      if(isDefined(parent._id_AAB9695C92B0ED96) && isDefined(parent._id_AAB9695C92B0ED96[part]) && parent._id_AAB9695C92B0ED96[part] <= 0) {
        classname = get_vehicle_classname();

        if(_id_D44D56ADF507094E(part) && getdvarint("dvar_4BD69B09131419CA") == 1)
          _id_B958F96BB17EC92D(part, 0, "MOD_EXECUTION", undefined, level.player, 1, self gettagorigin(part), 0);
        else {
          self._id_AAB9695C92B0ED96[part] = 0;
          state = "hide";
        }
      } else if(isDefined(self._id_AAB9695C92B0ED96) && isDefined(self._id_AAB9695C92B0ED96[part]) && randomint(2) == 0) {
        classname = get_vehicle_classname();

        if(_id_D44D56ADF507094E(part) && getdvarint("dvar_4BD69B09131419CA") == 1)
          _id_B958F96BB17EC92D(part, 0, "MOD_EXECUTION", undefined, level.player, 1, self gettagorigin(part), 0);
        else {
          self._id_AAB9695C92B0ED96[part] = 0;
          state = "death";
        }
      }

      if(isDefined(state))
        scripts\common\utility::_id_3677F2BE30FDD581(part, state);
    }
  } else {}
}

_id_0F18B042694D92F4() {
  if(self tagexists("tag_wheel_center_middle_left"))
    return 6;
  else
    return 4;
}

_id_B1AAB60676C543FE(_id_12E26F9F13300310, position) {
  if(!isDefined(self._id_0488F0FC49178C96))
    self._id_0488F0FC49178C96 = 0;

  self._id_0488F0FC49178C96 = self._id_0488F0FC49178C96 | 1 << _id_12E26F9F13300310;

  if(isDefined(self.driver) && isPlayer(self.driver))
    level.player setclientomnvar("ui_veh_flat_tire_mask", self._id_0488F0FC49178C96);

  classname = get_vehicle_classname();

  if(!isDefined(self._id_0C3DB265FEFDB8D4))
    self._id_0C3DB265FEFDB8D4 = [];

  if(!scripts\engine\utility::array_contains(self._id_0C3DB265FEFDB8D4, position)) {
    self _meth_792B01BD9710F266(_id_12E26F9F13300310);
    self._id_0C3DB265FEFDB8D4 = scripts\engine\utility::array_add(self._id_0C3DB265FEFDB8D4, position);
    self notify("vehicle_tire_blown", position);
  }
}

_id_FD3542824F9C1BD2() {
  self endon("death");
  self endon("stop collision watcher");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self._id_0BDB822D4C42D7BF = undefined;
    classname = get_vehicle_classname();
    self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent, _id_9FFA610F23463C71);

    if(istrue(self._id_721298F6D1910C00)) {
      return;
    }
    self._id_0BDB822D4C42D7BF["impulse"] = _id_D71630B8BAF84FA8;

    if(getdvarint("dvar_CFD8073837710CEF")) {
      scripts\engine\utility::draw_angles(vectortoangles(normal), position, (0, 1, 0), 1000, 10);

      if(isDefined(ent)) {}
    }

    if(isDefined(ent) && ent.code_classname == "script_vehicle" && isDefined(ent._id_0BDB822D4C42D7BF) && isDefined(ent._id_0BDB822D4C42D7BF["impulse"]) && ent._id_0BDB822D4C42D7BF["impulse"] > _id_D71630B8BAF84FA8) {
      _id_D71630B8BAF84FA8 = ent._id_0BDB822D4C42D7BF["impulse"];
      self._id_0BDB822D4C42D7BF["impulse"] = ent._id_0BDB822D4C42D7BF["impulse"];
    }

    if(!scripts\common\vehicle::_id_D7FE44FFB08B499A() && _id_D71630B8BAF84FA8 >= 0.15) {
      damage = _id_D71630B8BAF84FA8 * 400;
      _id_94A9FD97AF4A0676 = _id_A183F52B983F5769(damage);
      _id_6D8C939979ADE635 = _id_7BBA68B7E28EC873(64, position, 0, 1);

      if(isDefined(_id_6D8C939979ADE635)) {
        if(getdvarint("dvar_CFD8073837710CEF")) {
          classname = get_vehicle_classname();
          classname = getsubstr(classname, 19, classname.size);
        }

        if(_id_D71630B8BAF84FA8 > 0.8) {
          _id_97DE184A1B867545();
          _id_10D73932D2ECD911 = _id_7BBA68B7E28EC873(1000, position, 1, 1);

          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_10D73932D2ECD911.size; _id_AC0E594AC96AA3A8++) {
            if(_id_AC0E594AC96AA3A8 == 5) {
              break;
            }

            thread _id_B958F96BB17EC92D(_id_10D73932D2ECD911[_id_AC0E594AC96AA3A8], 0, "MOD_EXECUTION", undefined, level.player, 1, position, 1);
          }
        } else
          thread _id_B958F96BB17EC92D(_id_6D8C939979ADE635, 0, "MOD_IMPACT", undefined, level.player, 1, position, 1);
      }

      if(!scripts\common\vehicle::_id_9E9DFC6F77569F4D() && !scripts\common\vehicle::_id_B7148A3BFC4DEFB2() && !ent scripts\common\vehicle::_id_B7148A3BFC4DEFB2()) {
        _id_AA8369F87B6B7363 = _id_0AB048FA9B5AD972(ent, position, _id_D71630B8BAF84FA8, _id_9FFA610F23463C71);

        if(_id_AA8369F87B6B7363 == 1)
          _id_5B6729AB193D09D3(ent);
        else if(_id_AA8369F87B6B7363 != 2)
          scripts\common\vehicle::_id_28C5281474FFC395(_id_94A9FD97AF4A0676, undefined, "MOD_IMPACT");
      }
    }

    if(scripts\common\vehicle::_id_B7148A3BFC4DEFB2() && isDefined(ent)) {
      if(!isDefined(self._id_06268D543216A4F2))
        self._id_06268D543216A4F2 = 0;

      if(ent.code_classname == "script_vehicle")
        self._id_06268D543216A4F2 = self._id_06268D543216A4F2 + 1;

      if(self._id_06268D543216A4F2 >= 5) {
        ents = self getlinkedchildren();
        ents = scripts\engine\utility::array_add(ents, self);
        scripts\engine\utility::array_delete(ents);
      }
    }

    wait 1.0;
  }
}

_id_0AB048FA9B5AD972(ent, position, _id_D71630B8BAF84FA8, _id_9FFA610F23463C71) {
  if(scripts\common\vehicle::ishelicopter() || ent scripts\common\vehicle::ishelicopter())
    return 0;

  if(scripts\common\vehicle::_id_941D95491D4D4817() || ent scripts\common\vehicle::_id_941D95491D4D4817())
    return 0;

  if(getdvarint("dvar_7598045EE90E851D") == 1 && _id_D71630B8BAF84FA8 > 0.4 && isDefined(ent.classname_mp) && isDefined(self.classname_mp) && isDefined(ent) && ent.code_classname == "script_vehicle" && ent _id_5AE2B449B60714CA(position) && _id_5AE2B449B60714CA(position) && vectordot(anglesToForward(self.angles), anglesToForward(ent.angles)) < -0.9 && _id_9FFA610F23463C71 == 0) {
    if(!isDefined(level.vehicle.templates._id_EBD1D83C2799EF12[self.classname_mp]) || !isDefined(level.vehicle.templates._id_EBD1D83C2799EF12[ent.classname_mp]))
      return 1;

    if(level.vehicle.templates._id_EBD1D83C2799EF12[self.classname_mp] < level.vehicle.templates._id_EBD1D83C2799EF12[ent.classname_mp])
      return 1;

    if(level.vehicle.templates._id_EBD1D83C2799EF12[self.classname_mp] == level.vehicle.templates._id_EBD1D83C2799EF12[ent.classname_mp]) {
      if(!isDefined(self.driver) || !isPlayer(self.driver))
        return 1;
    }

    if(scripts\common\vehicle::_id_79A6E6E740893346() < self._id_FA70E73BAE432D6F * 0.5)
      return 1;

    scripts\common\vehicle::_id_28C5281474FFC395(self._id_FA70E73BAE432D6F * 0.5, undefined, "MOD_IMPACT");
    return 2;
  }

  return 0;
}

_id_5AE2B449B60714CA(point) {
  dot = 0;
  tag = "tag_wheel_center_front_left";

  if(!self tagexists("tag_wheel_center_front_left"))
    tag = "tag_origin";

  _id_485B74CB677A51A9 = point - self gettagorigin(tag);
  forward = anglesToForward(self.angles);
  dot = vectordot(_id_485B74CB677A51A9, forward);
  return dot > 0;
}

_id_5B6729AB193D09D3(ent) {
  if(getdvarint("dvar_CFD8073837710CEF"))
    classname = get_vehicle_classname();

  self._id_0083B8F4F5A22568 = 1;
  self notify("vehicle_headOnDeath");
  scripts\common\vehicle::_id_538EF15C254E4D34(ent);
}

_id_7BBA68B7E28EC873(_id_8887EF07110532E7, damagelocation, _id_FB1F805FFA028960, _id_0BF877DB179E9611) {
  _id_98C558B067CDD616();

  if(self._id_AAB9695C92B0ED96.size == 0) {
    if(istrue(_id_FB1F805FFA028960))
      return [];
    else
      return;
  }

  parts = _id_C7DDE17F06DEB794(self._id_AAB9695C92B0ED96, damagelocation);

  foreach(_id_AC0E594AC96AA3A8, part in parts) {
    if(self._id_AAB9695C92B0ED96[part] <= 0)
      parts = scripts\engine\utility::array_remove_index(parts, _id_AC0E594AC96AA3A8, 1);
  }

  if(istrue(_id_0BF877DB179E9611)) {
    foreach(_id_AC0E594AC96AA3A8, part in parts) {
      if(_id_D44D56ADF507094E(part))
        parts = scripts\engine\utility::array_remove_index(parts, _id_AC0E594AC96AA3A8, 1);
    }
  }

  _id_45FC229CD6C306B4 = scripts\engine\utility::_id_350E192B13BEA45C(parts);
  _id_45FC229CD6C306B4 = _id_5AAAAA0DC9A36D29(_id_45FC229CD6C306B4);

  if(istrue(_id_FB1F805FFA028960))
    return parts;
  else if(isDefined(_id_45FC229CD6C306B4) && distancesquared(damagelocation, self gettagorigin(_id_45FC229CD6C306B4)) <= squared(_id_8887EF07110532E7))
    return _id_45FC229CD6C306B4;
  else if(istrue(_id_FB1F805FFA028960))
    return [];
  else
    return;
}

_id_5AAAAA0DC9A36D29(part) {
  if(!isDefined(part))
    return undefined;

  if(part == "tag_bumper_front_damaged" || part == "tag_bumper_back_damaged") {
    _id_FFC85E3083340FE6 = getsubstr(part, 0, part.size - 8);

    if(scripts\common\utility::_id_35C178C80FA19CBD(_id_FFC85E3083340FE6, "death"))
      return part;

    return _id_FFC85E3083340FE6;
  }
}

_id_C7DDE17F06DEB794(array, damagelocation) {
  self._id_3CA4B6A49A825232 = damagelocation;
  keys = getarraykeys(array);
  keys = scripts\engine\utility::array_sort_with_func(keys, ::_id_F2E5602B6379A312);
  return keys;
}

_id_F2E5602B6379A312(_id_77EE125B8AD0984B, _id_77EE135B8AD09A7E) {
  return distancesquared(self gettagorigin(_id_77EE125B8AD0984B), self._id_3CA4B6A49A825232) < distancesquared(self gettagorigin(_id_77EE135B8AD09A7E), self._id_3CA4B6A49A825232);
}

_id_4286DE11E406088F() {
  self notify("stop_damageLogic");
  self endon("death");
  self endon("stop_damageLogic");

  while(self.health > 0) {
    self.damageinfo = undefined;
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, _id_799F234362ADB813, partname, _id_44E290FB31B85206, objweapon, origin, angles, normal, inflictor, time);
    partname = scripts\common\vehicle::_id_8ED0FFA3F8BE7C75(partname);
    _id_799F234362ADB813 = scripts\common\vehicle::_id_8ED0FFA3F8BE7C75(_id_799F234362ADB813);
    _id_4D52D3B077C86DFE = scripts\engine\utility::ter_op(_id_799F234362ADB813 != "", _id_799F234362ADB813, partname);
    amount = _id_8F700DC8E0D2FA89(amount, meansofdeath, time);
    self.damageinfo["amount"] = amount;
    self.damageinfo["attacker"] = attacker;
    self.damageinfo["direction_vec"] = direction_vec;
    self.damageinfo["damageLocation"] = damagelocation;
    self.damageinfo["MOD"] = meansofdeath;
    self.damageinfo["weapon"] = objweapon;

    if(scripts\common\vehicle::_id_D7FE44FFB08B499A()) {
      self.health = self._id_80D0F593608378C1;
      continue;
    }

    if(!_id_B9EA9D0702ABF6FD(self.health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor)) {
      if(meansofdeath == "MOD_MELEE")
        _id_A1ED6CE90E57BD32(amount, damagelocation, meansofdeath, objweapon, attacker);
      else
        thread _id_B958F96BB17EC92D(_id_4D52D3B077C86DFE, amount, meansofdeath, objweapon, attacker);
    }

    if(scripts\common\vehicle::_id_9E9DFC6F77569F4D()) {
      self.health = self._id_80D0F593608378C1;
      continue;
    }

    self._id_80D0F593608378C1 = self.health;
  }
}

_id_835A3820D2AB0B74() {
  self endon("death");

  if(!isDefined(self._id_F62942F38B243E4F)) {
    self._id_F62942F38B243E4F = spawnStruct();
    self._id_F62942F38B243E4F.text[0] = "";
    self._id_F62942F38B243E4F.color[0] = (1, 1, 1);
    self._id_F62942F38B243E4F.text[1] = "";
    self._id_F62942F38B243E4F.color[1] = (1, 1, 1);
    self._id_F62942F38B243E4F.text[2] = "";
    self._id_F62942F38B243E4F.color[2] = (1, 1, 1);
  }

  for(;;) {
    if(!getdvarint("dvar_CFD8073837710CEF")) {} else {
      zoffset = 70;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_F62942F38B243E4F.text.size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(self._id_F62942F38B243E4F.text[_id_AC0E594AC96AA3A8]))
          zoffset = zoffset - 3;
      }
    }

    waitframe();
  }
}

_id_A1DF9E8F97742AAF(text, _id_00C2E4118E56C429, color, bone) {
  if(!isDefined(self._id_F62942F38B243E4F))
    self._id_F62942F38B243E4F = spawnStruct();

  if(!isDefined(self._id_4EB5F18E4AFF3101))
    self._id_4EB5F18E4AFF3101 = 0;

  if(!isDefined(color))
    color = (1, 1, 1);

  _id_2DF2ED9765358B55 = 12;

  if(!isDefined(_id_00C2E4118E56C429)) {
    _id_00C2E4118E56C429 = 3;

    if(self._id_4EB5F18E4AFF3101 < _id_2DF2ED9765358B55)
      self._id_4EB5F18E4AFF3101 = self._id_4EB5F18E4AFF3101 + 1;

    for(_id_AC0E594AC96AA3A8 = _id_2DF2ED9765358B55; _id_AC0E594AC96AA3A8 > _id_00C2E4118E56C429; _id_AC0E594AC96AA3A8--) {
      self._id_F62942F38B243E4F.text[_id_AC0E594AC96AA3A8] = self._id_F62942F38B243E4F.text[_id_AC0E594AC96AA3A8 - 1];
      self._id_F62942F38B243E4F.color[_id_AC0E594AC96AA3A8] = self._id_F62942F38B243E4F.color[_id_AC0E594AC96AA3A8 - 1];
    }
  }

  self._id_F62942F38B243E4F.text[_id_00C2E4118E56C429] = text;
  self._id_F62942F38B243E4F.color[_id_00C2E4118E56C429] = color;
}

_id_FE805FFB3AD24253(_id_4D52D3B077C86DFE, amount, origin) {
  self notify("stop debug " + _id_4D52D3B077C86DFE);
  self endon("death");
  self endon("stop debug " + _id_4D52D3B077C86DFE);
  _id_1E2F2224127D2990 = undefined;

  if(isDefined(origin))
    _id_1E2F2224127D2990 = origin - self.origin;

  time = gettime();

  for(;;) {
    if(!getdvarint("dvar_CFD8073837710CEF")) {} else {
      if(gettime() - time > 10000) {
        break;
      }

      if(isDefined(_id_1E2F2224127D2990)) {}
    }

    waitframe();
  }
}

_id_CECA0FBE6B37349A() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");

  for(;;) {
    level.player waittill("ads_pressed");

    if(isDefined(self.driver) && isPlayer(self.driver)) {
      _id_9D6CB79F4E312DDD = gettime();
      scripts\common\vehicle::vehicle_lights_on("brakelights");
      level.player waittill("ads_released");

      if(gettime() - _id_9D6CB79F4E312DDD < 300)
        wait 0.3;

      scripts\common\vehicle::vehicle_lights_on("daylights");
    }
  }
}

_id_C2B5282B537A56BC() {
  if(!self isscriptable()) {
    return;
  }
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");

  if(!self getscriptablehaspart("flag")) {
    return;
  }
  for(;;) {
    _id_AD34A12845171639 = length(self vehicle_getvelocity()) / 17.6;

    if(_id_AD34A12845171639 > 35)
      scripts\common\utility::_id_3677F2BE30FDD581("flag", "fast");
    else if(_id_AD34A12845171639 > 7)
      scripts\common\utility::_id_3677F2BE30FDD581("flag", "medium");
    else if(_id_AD34A12845171639 > 2)
      scripts\common\utility::_id_3677F2BE30FDD581("flag", "slow");
    else
      scripts\common\utility::_id_3677F2BE30FDD581("flag", "stopped");

    wait 0.1;
  }
}