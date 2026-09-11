/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_code.gsc
***********************************************/

function vehicle_initlevelvariables() {
  setdvarifuninitialized("enable_vehicle_ai_using_BT", 1);

  if(!isDefined(level.vehicle)) {
    level.vehicle = spawnStruct();
  }

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
  level.vehicle.templates.bullet_shield = [];
  level.vehicle.templates.death_jolt = [];
  level.vehicle.templates.death_badplace = [];
  level.vehicle.templates.idle_anim = [];
  level.vehicle.templates.helicopter_list = [];
  level.vehicle.templates.airplane_list = [];
  level.vehicle.templates.single_tread_list = [];
  level.vehicle.templates.deathanimations = [];
  level.vehicle.templates.vehicle_death_fx = [];
  level.vehicle.templates.vehicle_rocket_death_fx = [];
  level.vehicle.templates.death_radiusdamage = [];
  level.vehicle.templates.model = [];
}

function ishelicopter_internal() {
  if(isDefined(self.isheli)) {
    return true;
  }

  if(!isDefined(self.vehicletype)) {
    return false;
  }

  return isDefined(level.vehicle.templates.helicopter_list[self.vehicletype]);
}

function isairplane_internal() {
  return isDefined(level.vehicle.templates.airplane_list[self.vehicletype]);
}

function vehicle_setuplevelvariables() {
  if(!scripts\engine\utility::add_init_script("vehicle_vars", &vehicle_setuplevelvariables)) {
    return;
  }

  scripts\engine\utility::init_struct_class();
  vehicle_initlevelvariables();
  scripts\common\vehicle_aianim::setup_aianimthreads();
}

function vehicle_precachescripts() {
  var_0 = [];
  level.needsprecaching = [];

  if(!isDefined(level.vehicleinitthread)) {
    level.vehicleinitthread = [];
  }

  var_1 = getEntArray("script_vehicle", "code_classname");

  foreach(var_3 in var_1) {
    var_3.vehicletype = tolower(var_3.vehicletype);

    if(var_3.vehicletype == "empty" || var_3.vehicletype == "empty_heli") {
      continue;
    }

    var_0 = var_3;
    vehicle_precachesetup(var_3.classname, var_3);
  }

  if(level.needsprecaching.size > 0) {
    var_5 = "";

    foreach(var_7 in level.needsprecaching) {
      foreach(var_9 in var_7) {
        foreach(var_11 in var_9.reasons) {}
      }
    }

    level waittill("never");
  }

  return var_0;
}

function vehicle_precachesetup(var_0, var_1) {
  if(isDefined(level.vehicleinitthread[var_1.vehicletype]) && isDefined(level.vehicleinitthread[var_1.vehicletype][var_1.classname])) {
    return;
  }

  if(var_1.classname == "script_vehicle") {
    return;
  }

  var_2 = [];

  if(isDefined(level.needsprecaching[var_0])) {
    var_2 = level.needsprecaching[var_0];
  }

  var_3 = spawnStruct();
  var_3.pos = var_1.origin;
  var_3.reasons = [];

  if(!isDefined(level.vehicleinitthread[var_1.vehicletype])) {
    var_3.reasons[var_3.reasons.size] = "vehicletype \"" + var_1.vehicletype + "\" is not setup properly. Maybe you just need to re-package? Or you have a Radiant copy/paste issue where you have the wrong vehicletype set?";
  } else if(!isDefined(level.vehicleinitthread[var_1.vehicletype][var_1.classname])) {
    var_3.reasons[var_3.reasons.size] = "classname \"" + var_1.classname + "\"is not setup properly. Maybe you just need to re-package? Or the vehicle's Quaked is not setup properly";
  }

  var_2 = var_3;
  level.needsprecaching[var_0] = var_2;
}

function vehicle_setupspawners() {
  var_0 = _getvehiclespawnerarray();

  foreach(var_2 in var_0) {
    thread vehicle_spawnerlogic();
  }
}

function vehicle_spawnerlogic() {
  self endon("entitydeleted");

  if(isDefined(self.script_deathflag)) {
    thread scripts\engine\utility::script_func("vehicle_spawner_deathflag");
  }

  self.count = 1;
  self.spawn_functions = [];

  for(;;) {
    self waittill("spawned", var_0);
    self.count--;

    if(!isDefined(var_0)) {
      continue;
    }

    var_0.spawn_funcs = self.spawn_functions;
    var_0.spawner = self;
    var_0 thread scripts\engine\utility::script_func("run_spawn_functions");
  }
}

function vehicle_triggerkillspawner(var_0) {
  var_0 waittill("trigger");

  foreach(var_2 in vehicle_getspawnerarray()) {
    if(scripts\engine\utility::is_equal(var_2.script_kill_vehicle_spawner, var_0.script_kill_vehicle_spawner)) {
      var_2 delete();
    }
  }
}

function vehicle_spawnaiarray(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::ent_flag_exist("no_riders_until_unload") && scripts\engine\utility::ent_flag("no_riders_until_unload");

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = 0;

    if(isDefined(var_4.script_drone)) {
      var_5 = 1;
      var_6 = scripts\engine\utility::script_func("dronespawn_bodyonly", var_4);
      var_6 scripts\engine\utility::script_func("drone_give_soul");
    } else if(isDefined(var_4.script_fakeactor) || isDefined(var_4.script_bodyonly)) {
      var_5 = 1;
      var_6 = scripts\engine\utility::script_func("bodyonlyspawn", var_4);
      var_6 scripts\engine\utility::script_func("fakeactor_give_soul");
    } else {
      var_6 = var_4 scripts\engine\utility::script_func("spawn_ai", var_2);
    }

    if(!var_5 && !isalive(var_6)) {
      continue;
    }

    var_1 = scripts\engine\utility::array_add(var_1, var_6);
  }

  var_8 = vehicle_removenonridersfromaiarray(var_1);
  return var_8;
}

function vehicle_removenonridersfromaiarray(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!ai_should_be_added(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function ai_should_be_added(var_0) {
  if(isalive(var_0)) {
    return true;
  }

  if(!isDefined(var_0)) {
    return false;
  }

  if(!isDefined(var_0.classname)) {
    return false;
  }

  return var_0.classname == "script_model";
}

function spawn_riders() {
  if(scripts\engine\utility::ent_flag_exist("no_riders_until_unload") && !scripts\engine\utility::ent_flag("no_riders_until_unload")) {
    self notify("spawnedRiders");
    return [];
  }

  var_0 = get_vehicle_riders_spawners();

  if(!var_0.size) {
    self notify("spawnedRiders");
    return [];
  }

  var_1 = spawn_group(var_0);
  self notify("spawnedRiders", var_1);
  return var_1;
}

function spawn_group(var_0) {
  var_1 = vehicle_spawnaiarray(var_0);
  var_1 = sort_by_startingpos(var_1);

  foreach(var_3 in var_1) {
    thread scripts\common\vehicle_aianim::guy_enter(var_3);
  }

  thread set_loaded_when_full(var_1);
  return var_1;
}

function set_loaded_when_full(var_0) {
  scripts\engine\utility::array_wait(var_0, "loaded", 1);
  scripts\common\vehicle_aianim::vehicle_loaded_if_full(self);
}

function spawn_unload_group(var_0) {
  if(!isDefined(var_0)) {
    return spawn_riders();
  }

  var_1 = get_vehicle_riders_spawners();

  if(!var_1.size) {
    return [];
  }

  var_2 = [];
  var_3 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.unloadgroups[var_3]) && isDefined(level.vehicle.templates.unloadgroups[var_3][var_0])) {
    var_4 = level.vehicle.templates.unloadgroups[var_3][var_0];

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(isDefined(var_1[var_5])) {
        var_1[var_5].script_startingposition = var_4[var_5];
      }
    }

    var_1 = sort_by_startingpos(var_1);

    foreach(var_7 in var_4) {
      foreach(var_9 in var_1) {
        if(var_9.script_startingposition == var_7) {
          var_2 = var_9;
        }
      }
    }

    var_12 = vehicle_spawnaiarray(var_2);

    foreach(var_14 in var_12) {
      thread scripts\common\vehicle_aianim::guy_enter(var_14);
    }

    self notify("spawnedRiders", var_12);
    return var_12;
  }

  return spawn_riders();
}

function sort_by_startingpos(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_startingposition)) {
      var_1 = var_4;
      continue;
    }

    var_2 = var_4;
  }

  return scripts\engine\utility::array_combine(var_1, var_2);
}

function remove_vehicle_spawned_thisframe() {
  waitframe();
  self.vehicle_spawned_thisframe = undefined;
}

function vehicle_init(var_0) {
  var_1 = get_vehicle_classname(var_0);

  if(isDefined(level.vehicle.templates.hide_part_list[var_1])) {
    foreach(var_3 in level.vehicle.templates.hide_part_list[var_1]) {
      var_0 hidepart(var_3);
    }
  }

  if(var_0.vehicletype == "empty" || var_0.vehicletype == "empty_heli") {
    var_0 thread scripts\common\vehicle_paths::getonpath();
    return;
  }

  var_0 scripts\engine\utility::set_ai_number();
  var_5 = var_0.vehicletype;
  vehicle_setstartinghealth(var_0);
  vehicle_setteam(var_0);

  if(isDefined(level.vehicleinitthread[var_0.vehicletype][var_1])) {}

  var_0 thread[[level.vehicleinitthread[var_0.vehicletype][var_1]]]();
  thread vehicle_playexhausteffect();
  thread vehicle_playengineeffect();

  if(!isDefined(var_0.script_avoidplayer)) {
    var_0.script_avoidplayer = 0;
  }

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal) {
      var_0 thermaldrawenable();
    }
  }

  var_0 scripts\engine\utility::ent_flag_init("unloaded");
  var_0 scripts\engine\utility::ent_flag_init("loaded");
  var_0 scripts\engine\utility::ent_flag_init("landed");
  var_0.riders = [];
  var_0.unloadque = [];
  var_0.unload_group = "default";
  var_0.fastroperig = [];

  if(isDefined(level.vehicle.templates.attachedmodels) && isDefined(level.vehicle.templates.attachedmodels[var_1])) {
    var_6 = level.vehicle.templates.attachedmodels[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0.fastroperig[var_9] = undefined;
      var_0.fastroperiganimating[var_9] = 0;
    }
  }

  if(isDefined(var_0.script_vehicle_lights_on)) {
    var_0 thread scripts\common\vehicle_lights::lights_on(var_0.script_vehicle_lights_on);
  }

  if(isDefined(var_0.script_godmode)) {
    var_0.godmode = 1;
  }

  thread vehicle_damagelogic();
  var_0 thread scripts\common\vehicle_aianim::handle_attached_guys();

  if(isDefined(var_0.script_friendname)) {
    var_0 setvehiclelookattext(var_0.script_friendname, &"");
  }

  thread vehicle_handleunloadevent();

  if(isDefined(var_0.script_dontunloadonend)) {
    var_0.dontunloadonend = 1;
  }

  thread vehicle_rumble();
  var_0 thread scripts\engine\utility::script_func("vehicle_treads");
  thread idle_animations();
  thread animate_drive_idle();

  if(isDefined(var_0.script_deathflag)) {
    var_0 thread scripts\engine\utility::script_func("vehicle_deathflag");
  }

  thread mainturretinit();
  thread mginit();

  if(isDefined(level.vehicle.spawn_callback_thread)) {
    level thread[[level.vehicle.spawn_callback_thread]](var_0);
  }

  if(isDefined(var_0.script_team)) {
    var_0 setvehicleteam(var_0.script_team);
  }

  if(var_0 scripts\common\vehicle::ishelicopter()) {
    thread vehicle_ai_avoidance_heli();
  } else {
    thread vehicle_ai_avoidance_logic();
  }

  var_0 thread scripts\common\vehicle_paths::getonpath();

  if(isDefined(level.ignorewash)) {
    var_11 = level.ignorewash;
  } else {
    var_11 = 0;
  }

  if(scripts\common\utility::issp() && vehicle_hasdustkickup(var_1) && !var_11) {
    thread aircraft_wash_thread();
  }

  if(var_1 vehicle_isphysveh()) {
    var_1.veh_pathtype = "constrained";

    if(isDefined(var_1.script_pathtype)) {
      var_1.veh_pathtype = var_1.script_pathtype;
    }
  }

  spawn_riders(var_1);
  thread vehicle_deathlogic();
}

function get_vehicle_classname() {
  if(isDefined(self.classname_mp)) {
    return self.classname_mp;
  }

  return self.classname;
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
    scripts\engine\utility::array_delete(self.mgturret);
  }

  if(isDefined(self.mainturret)) {
    self.mainturret delete();
  }

  if(istrue(level.vehicle.templates.has_main_turret[self.model])) {
    self clearturrettarget();
  }

  var_0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rumble[var_0])) {
    self stoprumble(level.vehicle.templates.rumble[var_0].rumble);
  }

  if(!scripts\common\utility::issp()) {
    return;
  }

  self useanimtree(#animtree);

  if(isDefined(level.vehicle.templates.driveidle[self.model])) {
    self clearanim(level.vehicle.templates.driveidle[self.model], 0);
  }

  if(isDefined(level.vehicle.templates.driveidle_r[self.model])) {
    self clearanim(level.vehicle.templates.driveidle_r[self.model], 0);
    return;
  }
}

function vehicle_deathlogic() {
  self endon("entitydeleted");
  self endon("nodeath_thread");
  thread helicopter_unloading_watcher();
  self waittill("death", var_0, var_1, var_2, var_3);
  vehicle_deathcustomlogic(var_0, var_1, var_2);
  vehicle_playdeatheffects(var_0, var_1, var_3);
  thread vehicle_killriders();
  vehicle_setdeathmodel();
  vehicle_docrash(var_0, var_1);

  if(vehicle_iscorpse()) {
    self notify("vehicle_deathComplete", self.origin, self.angles);
    return;
  }

  vehicle_deathcleanup();
  self notify("vehicle_deathComplete", self.origin, self.angles);

  if(istrue(self.vehicle_skipdeathmodel)) {
    if(scripts\common\utility::iscp()) {
      wait 0.1;
    }

    self delete();
    return;
  }

  self makecorpse();
  createnavbadplacebyent(self);
}

function vehicle_deathcustomlogic(var_0, var_1, var_2) {
  if(isDefined(self.custom_death_script)) {
    self thread[[self.custom_death_script]]();
  }

  if(isDefined(level.vehicle.templates.death_thread[self.vehicletype])) {
    GscBinSkip1(0x74, level.vehicle.templates.death_thread[self.vehicletype]);
  }

  var_3 = isDefined(var_0) && isDefined(var_1) && isDefined(var_2);

  if(var_3) {
    var_4 = createheadicon(var_2);
    var_0 scripts\engine\utility::script_func("register_kill", self, var_1, var_4);
    return;
  }
}

function vehicle_iscrashing() {
  return istrue(self.vehiclecrashing);
}

function vehicle_killriders() {
  if(istrue(self.pilot_killed) && !istrue(self.unloading)) {
    self waittill("flavor_done");
  }

  foreach(var_1 in self.riders) {
    if(!isalive(var_1)) {
      continue;
    }

    if(!isDefined(var_1.ridingvehicle)) {
      continue;
    }

    if(isDefined(var_1.magic_bullet_shield)) {
      var_1 scripts\common\ai::stop_magic_bullet_shield();
    }

    if(isDefined(var_1._blackboard) && isDefined(var_1._blackboard.chosenvehicleanimpos) && istrue(var_1._blackboard.chosenvehicleanimpos.isincircle)) {
      var_2 = 100;
      var_3 = self vehicle_getvelocity();
      var_1.do_immediate_ragdoll = 1;
      var_1.ragdollhitloc = "torso_lower";
      var_1.ragdollimpactvector = (var_1.origin - self.origin) * var_2 + var_3;
    }

    if(scripts\common\utility::iscp() && isDefined(self.is_area_in_verdansk)) {
      if(isDefined(self.is_area_in_verdansk.attacker) && isPlayer(self.is_area_in_verdansk.attacker)) {
        var_1 dodamage(var_1.maxhealth, self.is_area_in_verdansk.attacker.origin, self.is_area_in_verdansk.attacker, self.is_area_in_verdansk.attacker, self.is_area_in_verdansk.meansofdeath, self.is_area_in_verdansk.objweapon);
      } else {
        var_1 kill();
      }

      continue;
    }

    var_1 kill();
  }
}

function vehicle_rider_death_detection(var_0) {
  if(isDefined(self.vehicle_position) && self.vehicle_position != 0) {
    return;
  }

  self.health = 1;
  var_0 endon("death");
  self.baseaccuracy = 0.15;
  self waittill("death");
  var_0 notify("driver_died");
  vehicle_killriders(var_0);
}

function vehicle_becomes_crashable() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend();
  self.riders = scripts\engine\utility::array_removedead(self.riders);

  if(self.riders.size) {
    scripts\engine\utility::array_thread(self.riders, &vehicle_rider_death_detection, self);
    scripts\engine\utility::waittill_either("veh_collision", "driver_died");
    vehicle_killriders();
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self vehphys_crash();
}

function _vehicle_landvehicle(var_0, var_1) {
  self endon("death");
  self notify("newpath");

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(scripts\engine\utility::flat_angle(self.angles)[1]);

  if(isDefined(self.unload_land_offset)) {
    _setvehgoalpos_wrap(scripts\common\utility::groundpos(self.origin) + (0, 0, self.unload_land_offset), 1);
  } else {
    _setvehgoalpos_wrap(scripts\common\utility::groundpos(self.origin), 1);
  }

  self waittill("goal");
}

function vehicle_landanims(var_0, var_1) {
  self endon("death");
  var_2 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.landanims[var_2])) {
    return;
  }

  var_3 = level.vehicle.templates.landanims[var_2];

  foreach(var_5 in var_3) {
    self setanim(var_5.land, 1, 0.2, 1);
  }

  if(!var_1) {
    return;
  }

  if(isDefined(var_0)) {
    self waittill("unloaded");
  } else {
    self waittill("continuepath");
  }

  foreach(var_5 in var_3) {
    self clearanim(var_5.land, 0);
    self setanim(var_5.takeoff, 1, 0.2, 1);
  }
}

function vehicle_landvehicle(var_0, var_1) {
  return _vehicle_landvehicle(var_0, var_1);
}

function spawn_vehicle_and_attach_to_spline_path(var_0) {
  var_1 = scripts\common\utility::spawn_vehicle();

  if(isDefined(var_0)) {
    var_1 vehicle_setspeed(var_0);
  }

  thread vehicle_becomes_crashable();
  var_1 endon("death");
  var_1.dontunloadonend = 1;
  var_1 scripts\common\vehicle_paths::gopath(var_1);
  leave_path_for_spline_path(var_1);
}

function leave_path_for_spline_path() {
  self endon("script_crash_vehicle");
  scripts\engine\utility::waittill_either("enable_spline_path", "reached_end_node");
  var_0 = get_my_spline_node(self.origin);

  if(isDefined(level.drive_spline_path_fun)) {
    var_0 thread[[level.drive_spline_path_fun]](self);
    return;
  }
}

function get_my_spline_node(var_0) {
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = scripts\engine\utility::get_array_of_closest(var_0, level.snowmobile_path);
  var_2 = [];

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_2 = var_1[var_3];
  }

  foreach(var_5 in level.snowmobile_path) {
    foreach(var_7 in var_2) {
      if(var_7 == var_5) {
        return var_7;
      }
    }
  }
}

function waittill_stable(var_0) {
  var_1 = 12;
  var_2 = 400;
  var_3 = gettime() + var_2;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var_1 || abs(self.angles[2]) > var_1) {
      var_3 = gettime() + var_2;
    }

    if(gettime() > var_3) {
      break;
    }

    wait 0.05;
  }
}

function _vehicle_unload(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    self.unload_group = var_0;
  }

  if(scripts\engine\utility::ent_flag_exist("no_riders_until_unload")) {
    scripts\engine\utility::ent_flag_set("no_riders_until_unload");
    var_1 = spawn_unload_group(self.unload_group);

    foreach(var_3 in var_1) {
      scripts\common\ai::spawn_failed(var_3);
    }

    waittillframeend();
  }

  self notify("unloading");
  var_1 = [];
  var_5 = level.vehicle.templates.unloadgroups[get_vehicle_classname()];

  if(isDefined(var_5)) {
    var_6 = scripts\common\vehicle_aianim::get_unload_group();

    if(istrue(self.vehiclesetuprope)) {
      var_7 = 0;

      while(var_7 < level.vehicle.templates.aianims[get_vehicle_classname()].size) {
        var_8 = level.vehicle.templates.aianims[get_vehicle_classname()][var_7];

        if(istrue(var_8.setuprope)) {
          var_9 = 0;

          foreach(var_11 in self.riders) {
            if(isDefined(var_6[var_11.vehicle_position]) && var_11.vehicle_position != var_7) {
              var_12 = scripts\common\vehicle_aianim::anim_pos(self, var_11.vehicle_position);

              if(var_12.fastroperig == var_8.fastroperig) {
                var_9 = 1;
                break;
              }
            }
          }

          var_9 = undefined;
          var_11 = undefined;

          if(var_8) {
            foreach(var_10 in self.riders) {
              if(var_10.vehicle_position == var_6) {
                scripts\common\vehicle_aianim::guy_setup_rope(var_10, var_7);
                break;
              }
            }
          }
        }

        var_6++;
      }
    }

    foreach(var_11 in self.riders) {
      if(isalive(var_11) && isDefined(var_5[var_11.vehicle_position])) {
        if(isDefined(level.vehicle.aianimcheck["unload"]) && ![[level.vehicle.aianimcheck["unload"]]](var_11, var_11.vehicle_position)) {
          continue;
        }

        var_8 = scripts\common\vehicle_aianim::anim_pos(self, var_11.vehicle_position);

        if(isDefined(var_8) && istrue(var_8.lootspawnitem)) {
          continue;
        }

        if(isDefined(level.vehicle.aianimthread["unload"])) {
          if(!istrue(var_8.setuprope)) {
            var_11 notify("newanim");
            GscBinSkip1(0x74, level.vehicle.aianimthread["unload"], var_11, var_11.vehicle_position);
          }
        }
      }
    }
  }

  return var_0;
}

function _setvehgoalpos_wrap(var_0, var_1) {
  if(self.health <= 0) {
    return;
  }

  if(isDefined(self.originheightoffset)) {
    var_0 += (0, 0, self.originheightoffset);
  }

  self setvehgoalpos(var_0, var_1);
}

function vehicle_kill_badplace_forever() {
  self notify("kill_badplace_forever");
}

function vehicle_isdestructible() {
  return isDefined(self.destructible_type);
}

function _kill_fx_play_direction(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = self getentityvelocity();
    var_2 = vectorNormalize(var_2);
    var_0 = vectorNormalize(var_0);
    var_3 = vectorlerp(var_2, var_0, var_1);
    return var_3;
  }

  return undefined;
}

function vehicle_playdeatheffects(var_0, var_1, var_2) {
  if(vehicle_isdestructible()) {
    return;
  }

  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);
  thread vehicle_deathearthquake();
  thread vehicle_deathradiusdamage();
  thread vehicle_deathkilllights();
  thread vehicle_deathjolt(var_2);
  thread vehicle_deathvfx(var_0, var_1);
}

function vehicle_deathvfx(var_0, var_1) {
  var_2 = get_vehicle_classname();

  if(vehicle_shoulddorocketdeath(var_0, var_1, var_2)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 3;
    var_3 = level.vehicle.templates.vehicle_rocket_death_fx[var_2];
  } else if(istrue(self.pilot_killed)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 4;
    var_3 = level.vehicle.templates.vehicle_rocket_death_fx[var_3];
  } else {
    var_3 = level.vehicle.templates.vehicle_death_fx[var_3];
  }

  foreach(var_5 in var_3) {
    thread kill_fx_thread(self.model, var_5, self.vehicletype, var_2);
  }
}

function vehicle_deathearthquake() {
  var_0 = level.vehicle.templates.death_earthquake[get_vehicle_classname()];

  if(isDefined(var_0)) {
    earthquake(var_0.scale, var_0.duration, self.origin, var_0.radius);
    return;
  }
}

function vehicle_deathradiusdamage() {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }

  var_0 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.death_radiusdamage) || !isDefined(level.vehicle.templates.death_radiusdamage[var_0])) {
    return;
  }

  var_1 = level.vehicle.templates.death_radiusdamage[var_0].maxdamage;
  var_2 = level.vehicle.templates.death_radiusdamage[var_0].mindamage;
  self radiusdamage(self.origin + level.vehicle.templates.death_radiusdamage[var_0].offset, level.vehicle.templates.death_radiusdamage[var_0].range, var_1, var_2, self);
}

function vehicle_deathkilllights() {
  scripts\common\vehicle_lights::lights_off_internal("all", self.model, get_vehicle_classname());
}

function vehicle_deathjolt(var_0) {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }

  if(!scripts\common\utility::issp() && self issuspendedvehicle()) {
    return;
  }

  self joltbody(var_0, 3);
}

function vehicle_shoulddorocketdeath(var_0, var_1, var_2) {
  if(!vehicle_hasrocketdeath(var_2)) {
    return false;
  }

  if(istrue(self.vehicle_forcerocketdeath)) {
    return true;
  }

  if(scripts\engine\utility::is_equal(var_1, "MOD_PROJECTILE")) {
    return true;
  }

  if(scripts\engine\utility::is_equal(var_1, "MOD_PROJECTILE_SPLASH")) {
    return true;
  }

  if(scripts\engine\utility::is_equal(var_1, "MOD_GRENADE")) {
    return true;
  }

  return false;
}

function vehicle_hasrocketdeath(var_0) {
  return isDefined(level.vehicle.templates.vehicle_rocket_death_fx[var_0]);
}

function kill_fx_thread(var_0, var_1, var_2, var_3) {
  if(isDefined(self.pilot_killed)) {
    self waittill("flavor_done");
  }

  if(isDefined(self.nodeath)) {
    return;
  }

  if(!isDefined(var_3)) {
    return;
  }

  if(isDefined(var_1.waitdelay)) {
    if(var_1.waitdelay >= 0) {
      wait var_1.waitdelay;
    } else {
      self waittill("death_finished");
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_1.notifystring)) {
    self notify(var_1.notifystring);
  }

  var_4 = vectorNormalize(self.origin - var_3.origin);

  if(isDefined(var_1.selfdeletedelay)) {
    scripts\engine\utility::delaycall(var_1.selfdeletedelay, &delete);
  }

  if(isDefined(var_1.effect)) {
    if(var_1.beffectlooping) {
      if(isDefined(var_1.tag)) {
        if(isDefined(var_1.stayontag) && var_1.stayontag == 1) {
          thread loop_fx_on_vehicle_tag(var_1.effect, var_1.delay, var_1.tag);
        } else {
          thread playloopedfxontag(var_1.effect, var_1.delay, var_1.tag);
        }
      } else {
        var_5 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1.effect, self.origin, var_5);
      }
    } else if(isDefined(var_1.tag)) {
      var_5 = _kill_fx_play_direction(var_4, var_1.attacker_velocity_lerp);

      if(isDefined(var_5)) {
        var_6 = deathfx_ent();
        playFX(var_1.effect, var_6 gettagorigin(var_1.tag), var_5);

        if(isDefined(var_1.remove_deathfx_entity_delay)) {
          var_6 scripts\engine\utility::delaycall(var_1.remove_deathfx_entity_delay, &delete);
        }
      } else {
        var_6 = deathfx_ent();
        playFXOnTag(var_2.effect, var_6, var_2.tag);
        thread stop_fx_on_vehicle_watcher(var_2.effect, var_6, var_2.tag);

        if(isDefined(var_2.remove_deathfx_entity_delay)) {
          deathfx_ent() scripts\engine\utility::delaycall(var_2.remove_deathfx_entity_delay, &delete);
        }
      }
    } else {
      var_5 = _kill_fx_play_direction(var_6, var_3.attacker_velocity_lerp);

      if(isDefined(var_5)) {
        playFX(var_3.effect, self.origin, var_5);
      } else {
        var_5 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_3.effect, self.origin, var_5);
      }
    }
  }

  if(isDefined(var_3.sound)) {
    if(var_3.bsoundlooping) {
      thread death_firesound(var_3.sound);
      return;
    }

    scripts\engine\utility::play_sound_in_space(var_3.sound);
    return;
  }
}

function stop_fx_on_vehicle_watcher(var_0, var_1, var_2) {
  var_1 waittill("stop_all_death_fx");
  stopFXOnTag(var_0, var_1, var_2);
}

function loop_fx_on_vehicle_tag(var_0, var_1, var_2) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(var_0, deathfx_ent(), var_2);
    wait var_1;
  }
}

function death_firesound(var_0) {
  thread scripts\engine\utility::script_func("playloopsound_on_tag", var_0, undefined, 0, 1);
  scripts\engine\utility::ref_143a5("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }

  self notify("stop sound" + var_0);
}

function deathfx_ent() {
  if(isDefined(self.death_fx_on_self) && self.death_fx_on_self) {
    return self;
  }

  if(!isDefined(self.deathfx_ent)) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel(self.model);
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 notsolid();
    var_0 hide();
    var_0 linkTo(self);
    var_0.death_fx = 1;
    self.deathfx_ent = var_0;
  } else {
    self.deathfx_ent setModel(self.model);
  }

  return self.deathfx_ent;
}

function playloopedfxontag(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", self.origin);
  self endon("fire_extinguish");
  thread playloopedfxontag_originupdate(var_2, var_3);

  for(;;) {
    playFX(var_0, var_3.origin, var_3.upvec);
    wait var_1;
  }
}

function playloopedfxontag_originupdate(var_0, var_1) {
  var_1.angles = self gettagangles(var_0);
  var_1.origin = self gettagorigin(var_0);
  var_1.forwardvec = anglesToForward(var_1.angles);
  var_1.upvec = anglestoup(var_1.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    var_1.angles = self gettagangles(var_0);
    var_1.origin = self gettagorigin(var_0);
    var_1.forwardvec = anglesToForward(var_1.angles);
    var_1.upvec = anglestoup(var_1.angles);
    wait 0.05;
  }
}

function _getvehiclespawnerarray(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0) && isDefined(var_1)) {
    var_3 = 1;
    var_4 = getEntArray(var_0, var_1);
  } else {
    var_3 = 0;
    var_4 = getEntArray("script_vehicle", "code_classname");
  }

  foreach(var_6 in var_4) {
    if(var_3 && var_6.code_classname != "script_vehicle") {
      continue;
    }

    if(isspawner(var_6)) {
      var_4 = var_6;
    }
  }

  return var_4;
}

function update_steering(var_0) {
  if(var_0.update_time == gettime()) {
    return var_0.steering;
  }

  var_0.update_time = gettime();

  if(var_0.steering_enable) {
    var_1 = clamp(0 - var_0.angles[2], 0 - var_0.steering_maxroll, var_0.steering_maxroll) / var_0.steering_maxroll;

    if(isDefined(var_0.leanasitturns) && var_0.leanasitturns) {
      var_2 = var_0 vehicle_getsteering();
      var_2 *= -1;
      var_1 += var_2;

      if(var_1 != 0) {
        var_3 = 1 / abs(var_1);

        if(var_3 < 1) {
          var_1 *= var_3;
        }
      }
    }

    var_4 = var_1 - var_0.steering;

    if(var_4 != 0) {
      var_5 = var_0.steering_maxdelta / abs(var_4);

      if(var_5 < 1) {
        var_4 *= var_5;
      }

      var_0.steering += var_4;
    }
  } else {
    var_0.steering = 0;
  }

  return var_0.steering;
}

function get_from_spawnStruct(var_0) {
  return scripts\engine\utility::getStruct(var_0, "targetname");
}

function get_from_entity(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];
  }

  return undefined;
}

function get_from_vehicle_node(var_0) {
  return getvehiclenode(var_0, "targetname");
}

function set_lookat_from_dest(var_0) {
  var_1 = getEnt(var_0.script_linkto, "script_linkname");

  if(!isDefined(var_1)) {
    return;
  }

  self setlookatent(var_1);
  self.set_lookat_point = 1;
}

function damage_hint_bullet_only() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }

    var_4 = tolower(var_4);

    switch (var_4) {
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;
          var_1 scripts\engine\utility::script_func("display_hint", "invulerable_bullets");
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
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }

    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }

    var_4 = tolower(var_4);

    switch (var_4) {
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

          if(var_4 == "mod_grenade" || var_4 == "mod_grenade_splash") {
            var_1 scripts\engine\utility::script_func("display_hint", "invulerable_frags", 5);
          } else {
            var_1 scripts\engine\utility::script_func("display_hint", "invulerable_bullets", 5);
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
    return;
  }
}

function aircraft_wash_thread(var_0) {
  self endon("death");
  self endon("death_finished");
  self notify("stop_kicking_up_dust");
  self endon("stop_kicking_up_dust");
  var_1 = 2000;

  if(isDefined(level.treadfx_maxheight)) {
    var_1 = level.treadfx_maxheight;
  }

  var_2 = 80 / var_1;
  var_3 = 0.5;

  if(isairplane_internal()) {
    var_3 = 0.15;
  }

  var_4 = self;

  if(isDefined(var_0)) {
    var_4 = var_0;
  }

  var_5 = 3;

  for(;;) {
    wait var_3;

    if(true) {
      if(isDefined(self.disable_wash) && self.disable_wash) {
        continue;
      }

      if(isDefined(self.treadfx_maxheight)) {
        var_1 = self.treadfx_maxheight;
      }

      var_6 = anglestoup(var_4.angles) * -1;
      var_7 = undefined;
      var_5++;

      if(var_5 > 3) {
        var_5 = 3;
        var_7 = scripts\engine\trace::ray_trace(var_4.origin, var_4.origin + var_6 * var_1, var_4, undefined, 1);
      }

      if(var_7["fraction"] == 1 || var_7["fraction"] < var_2) {
        continue;
      }

      var_8 = distance(var_4.origin, var_7["position"]);
      var_9 = get_wash_fx(self, var_7, var_6, var_8);

      if(!isDefined(var_9)) {
        continue;
      }

      var_3 = (var_8 - 350) / (var_1 - 350) * 0.1 + 0.05;
      var_3 = max(var_3, 0.05);

      if(!isDefined(var_7)) {
        continue;
      }

      if(!isDefined(var_7["position"])) {
        continue;
      }

      var_10 = var_7["position"];
      var_11 = var_7["normal"];
      var_8 = vectordot(var_10 - var_4.origin, var_11);
      var_12 = var_4.origin + (0, 0, var_8);
      var_13 = var_10 - var_12;

      if(isDefined(self.treadfx_orient_to_player)) {
        var_13 = var_10 - level.player.origin;
      }

      if(vectordot(var_7["normal"], (0, 0, 1)) == -1) {
        continue;
      }

      if(length(var_13) < 1) {
        var_13 = var_4.angles + (0, 180, 0);
      }

      playFX(var_9, var_10, var_11, var_13);
    }
  }
}

function get_wash_fx(var_0, var_1, var_2, var_3) {
  var_4 = var_1["surfacetype"];
  var_5 = undefined;
  var_6 = vectordot((0, 0, -1), var_2);

  if(var_6 >= 0.97) {
    var_5 = undefined;
  } else if(var_6 >= 0.92) {
    var_5 = "_bank";
  } else {
    var_5 = "_bank_lg";
  }

  return get_wash_effect(get_vehicle_classname(var_0), var_4, var_5);
}

function get_wash_effect(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_1 + var_2;

    if(!isDefined(level.vehicle.templates.surface_effects[var_0][var_3]) && var_1 != "default") {
      return get_wash_effect(var_0, "default", var_2);
    } else {
      return level.vehicle.templates.surface_effects[var_0][var_3];
    }
  }

  return get_vehicle_effect(var_0, var_1);
}

function get_vehicle_effect(var_0, var_1) {
  if(!isDefined(level.vehicle.templates.surface_effects[var_0][var_1]) && var_1 != "default") {
    return get_vehicle_effect(var_0, "default");
  } else {
    return level.vehicle.templates.surface_effects[var_0][var_1];
  }

  return undefined;
}

function no_treads() {
  return ishelicopter_internal() || isairplane_internal();
}

function vehicle_hasdustkickup() {
  if(!ishelicopter_internal() && !isairplane_internal()) {
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

function ref_14101() {
  self endon("stop_ai_avoidance");
  self waittill("death");
  vehicle_remove_navobstacle();
  vehicle_remove_navrepulsor();
}

function vehicle_ai_avoidance_logic() {
  self endon("death");
  self endon("stop_ai_avoidance");
  thread ref_14101();
  var_0 = self vehicle_isphysveh();
  var_1 = 25;

  for(;;) {
    vehicle_navobstacle();

    for(var_2 = self.origin; vehicle_is_stopped() && (!var_0 || self vehicle_isonground()); var_2 = self.origin) {
      wait 0.1;

      if(lengthsquared(self.origin - var_2) > var_1) {
        vehicle_remove_navobstacle();
        vehicle_navobstacle();
      }
    }

    vehicle_remove_navobstacle();
    vehicle_navrepulsor();

    while(!vehicle_is_stopped() || var_0 && !self vehicle_isonground()) {
      wait 0.1;
    }

    vehicle_remove_navrepulsor();
  }
}

function vehicle_is_stopped() {
  if(!scripts\common\utility::issp() && self issuspendedvehicle()) {
    return true;
  }

  if(self vehicle_isphysveh()) {
    return (self vehicle_getspeed() < 0.01);
  }

  return self vehicle_getspeed() == 0;
}

function vehicle_ai_avoidance_heli() {
  self endon("death");
  self endon("stop_ai_avoidance");
  thread ref_14101();

  for(;;) {
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
    return;
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
    return;
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
    return;
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
  var_0 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    var_0 = 1;
  }

  if(var_0) {
    self.dontdisconnectpaths = 1;
    return;
  }

  wait randomfloat(1);

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self.dontdisconnectpaths)) {
        self disconnectPaths();
        self.pathsdisconnected = 1;
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

function vehicle_start_ai_avoidance() {
  if(getdvarint("scr_br_vehicle_ai_avoidance_enabled", 1) == 0) {
    return;
  }

  foreach(var_1 in level.vehicle.instances) {
    foreach(var_3 in var_1) {
      if(istrue(var_3.isheli)) {
        thread vehicle_ai_avoidance_heli();
        continue;
      }

      thread vehicle_ai_avoidance_logic();
    }
  }
}

function vehicle_stop_ai_avoidance() {
  if(getdvarint("scr_br_vehicle_ai_avoidance_enabled", 1) == 0) {
    return;
  }

  foreach(var_1 in level.vehicle.instances) {
    foreach(var_3 in var_1) {
      var_3 notify("stop_ai_avoidance");
      vehicle_remove_navobstacle(var_3);
      vehicle_remove_navrepulsor(var_3);
    }
  }
}

function mainturretinit() {
  var_0 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.mainturret[var_0])) {
    return;
  }

  var_1 = level.vehicle.templates.mainturret[var_0];

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = "";

  if(isDefined(self.script_turrets)) {
    var_2 = self.script_turrets;
  }

  self.mainturret = turretinitshared(var_1);

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
  var_0 = get_vehicle_classname();

  if(isDefined(self.script_nomg) && self.script_nomg > 0) {
    return;
  }

  if(!isDefined(level.vehicle.templates.mgturret[var_0])) {
    return;
  }

  var_1 = level.vehicle.templates.mgturret[var_0];

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = "";

  if(isDefined(self.script_turrets)) {
    var_2 = self.script_turrets;
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4.referencename) && !issubstr(var_2, var_4.referencename)) {
      continue;
    }

    self.mgturret[var_5] = turretinitshared(var_4);
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

function turretinitshared(var_0) {
  var_1 = 0;

  if(isDefined(self.script_mg_angle)) {
    var_1 = self.script_mg_angle;
  }

  var_2 = spawnturret("misc_turret", (0, 0, 0), var_0.info);
  var_3 = (0, 0, 0);

  if(isDefined(var_0.offset_tag)) {
    var_3 = (0, 0, 0);
  }

  var_4 = self;

  if(isDefined(var_0.mainturretchild)) {
    if(isDefined(self.mainturret)) {}

    var_4 = self.mainturret;
  }

  var_2 linkTo(var_4, var_0.tag, var_3, (0, -1 * var_1, 0));
  var_2 setModel(var_0.model);
  var_2.angles = self.angles;
  var_2.isvehicleattached = 1;
  var_2.ownervehicle = self;
  var_2.weaponinfo = var_0.info;
  var_2.script_team = self.script_team;
  var_2 makeusable();
  set_turret_team(var_2);
  thread vehicle_turret_difficulty(level, var_2);

  if(isDefined(self.script_fireondrones)) {
    var_2.script_fireondrones = self.script_fireondrones;
  }

  if(isDefined(var_0.deletedelay)) {
    var_2.deletedelay = var_0.deletedelay;
  }

  if(isDefined(var_0.defaultdroppitch)) {
    var_2 setdefaultdroppitch(var_0.defaultdroppitch);
  }

  if(isDefined(var_0.referencename)) {
    var_2.referencename = var_0.referencename;
  }

  if(isDefined(var_0.defaultonmode)) {
    turret_set_default_on_mode(var_2, var_0.defaultonmode);
  }

  return var_2;
}

function vehicle_turret_difficulty(var_0, var_1) {
  var_0.convergencetime = level.mgturretsettings[var_1]["convergenceTime"];
  var_0.suppressiontime = level.mgturretsettings[var_1]["suppressionTime"];
  var_0.accuracy = level.mgturretsettings[var_1]["accuracy"];
  var_0.aispread = level.mgturretsettings[var_1]["aiSpread"];
  var_0.playerspread = level.mgturretsettings[var_1]["playerSpread"];
}

function turret_set_default_on_mode(var_0) {
  self.defaultonmode = var_0;
}

function set_turret_team(var_0) {
  switch (self.script_team) {
    case "friendly":
    case "allies":
      var_0 setturretteam("allies");
      break;
    case "enemy":
    case "axis":
      var_0 setturretteam("axis");
      break;
    case "team3":
      var_0 setturretteam("team3");
      break;
    default:
      break;
  }
}

#using_animtree("");

function animate_drive_idle() {
  if(!scripts\common\utility::issp()) {
    return;
  }

  self endon("suspend_drive_anims");

  if(!isDefined(self.vehiclewheeldirection)) {
    self.vehiclewheeldirection = 1;
  }

  var_0 = self.model;
  var_1 = -1;
  var_2 = undefined;

  if(!isDefined(level.vehicle.templates.driveidle[var_0])) {
    return;
  }

  self useanimtree(#animtree);

  if(!isDefined(level.vehicle.templates.driveidle_r[var_0])) {
    level.vehicle.templates.driveidle_r[var_0] = level.vehicle.templates.driveidle[var_0];
  }

  self endon("death");
  var_3 = level.vehicle.templates.driveidle_normal_speed[var_0];
  var_4 = 1;

  if(isDefined(level.vehicle.templates.driveidle_animrate) && isDefined(level.vehicle.templates.driveidle_animrate[var_0])) {
    var_4 = level.vehicle.templates.driveidle_animrate[var_0];
  }

  var_5 = self.vehiclewheeldirection;
  var_6 = level.vehicle.templates.driveidle[var_0];

  for(;;) {
    if(!var_3) {
      if(isDefined(self.suspend_driveanims)) {
        wait 0.05;
        continue;
      }

      self setanim(level.vehicle.templates.driveidle[var_0], 1, 0.2, var_4);
      return;
    }

    var_7 = self vehicle_getspeed();

    if(var_5 != self.vehiclewheeldirection) {
      var_8 = 0;

      if(self.vehiclewheeldirection) {
        var_6 = level.vehicle.templates.driveidle[var_0];
        var_8 = 1 - get_normal_anim_time(level.vehicle.templates.driveidle_r[var_0]);
        self clearanim(level.vehicle.templates.driveidle_r[var_0], 0);
      } else {
        var_6 = level.vehicle.templates.driveidle_r[var_0];
        var_8 = 1 - get_normal_anim_time(level.vehicle.templates.driveidle[var_0]);
        self clearanim(level.vehicle.templates.driveidle[var_0], 0);
      }

      var_2 = 0.01;

      if(var_2 >= 1 || var_2 == 0) {
        var_2 = 0.01;
      }

      var_5 = self.vehiclewheeldirection;
    }

    var_9 = var_7 / var_3;

    if(var_9 != var_1) {
      self setanim(var_6, 1, 0.05, var_9);
      var_1 = var_9;
    }

    if(isDefined(var_2)) {
      self setanimtime(var_6, var_2);
      var_2 = undefined;
    }

    wait 0.05;
  }
}

function setup_vehicles(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isspawner(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  foreach(var_6 in var_1) {
    thread vehicle_init(var_6);
  }
}

function vehicle_setstartinghealth() {
  var_0 = get_vehicle_classname();

  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
    return;
  }

  if(level.vehicle.templates.life[var_0] == -1) {
    return;
  }

  if(isDefined(level.vehicle.templates.life_range_low[var_0]) && isDefined(level.vehicle.templates.life_range_high[var_0])) {
    self.health = randomint(level.vehicle.templates.life_range_high[var_0] - level.vehicle.templates.life_range_low[var_0]) + level.vehicle.templates.life_range_low[var_0];
    return;
  }

  self.health = level.vehicle.templates.life[var_0];
}

function get_normal_anim_time(var_0) {
  var_1 = self getanimtime(var_0);
  var_2 = getanimlength(var_0);

  if(var_1 == 0) {
    return 0;
  }

  return self getanimtime(var_0) / getanimlength(var_0);
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

  foreach(var_1 in level.vehicle.templates.idle_anim[self.model]) {
    self setanim(var_1);
  }
}

function vehicle_rumble() {
  self endon("kill_rumble_forever");
  var_0 = get_vehicle_classname();
  var_1 = level.vehicle.templates.rumble[var_0];

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = var_1.radius * 2;
  var_3 = -1 * var_1.radius;
  var_4 = spawn("trigger_radius", self.origin + (0, 0, var_3), 0, var_1.radius, var_2);
  var_4 enablelinkTo();
  var_4 linkTo(self);
  self.rumbletrigger = var_4;
  self endon("death");

  if(!isDefined(self.rumbleon)) {
    self.rumbleon = 1;
  }

  if(isDefined(var_1.scale)) {
    self.rumble_scale = var_1.scale;
  } else {
    self.rumble_scale = 0.15;
  }

  if(isDefined(var_1.duration)) {
    self.rumble_duration = var_1.duration;
  } else {
    self.rumble_duration = 4.5;
  }

  if(isDefined(var_1.radius)) {
    self.rumble_radius = var_1.radius;
  } else {
    self.rumble_radius = 600;
  }

  if(isDefined(var_1.basetime)) {
    self.rumble_basetime = var_1.basetime;
  } else {
    self.rumble_basetime = 1;
  }

  if(isDefined(var_1.randomaditionaltime)) {
    self.rumble_randomaditionaltime = var_1.randomaditionaltime;
  } else {
    self.rumble_randomaditionaltime = 1;
  }

  var_4.radius = self.rumble_radius;

  for(;;) {
    var_4 waittill("trigger");

    if(vehicle_is_stopped() && !isDefined(self.forcerumble) || !self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(var_1.rumble);

    if(isDefined(self.vehicletype)) {
      var_5 = self.vehicletype + "_rumble_sfx";

      if(soundexists(var_5)) {
        level.player playSound(var_5);
      }
    }

    while(level.player istouching(var_4) && self.rumbleon && (!vehicle_is_stopped() || isDefined(self.forcerumble))) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime);
    }

    self stoprumble(var_1.rumble);
  }
}

function vehicle_setteam() {
  var_0 = get_vehicle_classname();

  if(!isDefined(self.script_team) && isDefined(level.vehicle.templates.team[var_0])) {
    self.script_team = level.vehicle.templates.team[var_0];
    return;
  }
}

function vehicle_handleunloadevent() {
  self endon("death");
  var_0 = self.vehicletype;

  if(!scripts\engine\utility::ent_flag_exist("unloaded")) {
    scripts\engine\utility::ent_flag_init("unloaded");
    return;
  }
}

function get_vehiclenode_any_dynamic(var_0) {
  var_1 = getvehiclenode(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getEnt(var_0, "targetname");
  } else if(ishelicopter_internal()) {}

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  }

  return var_1;
}

function vehicle_damagelogic() {
  self endon("death");
  self.damage_functions = [];
  var_0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.bullet_shield[var_0]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level.vehicle.templates.bullet_shield[var_0];
  }

  if(isDefined(level.vehicle.templates.grenade_shield[var_0]) && !isDefined(self.script_grenadeshield)) {
    self.script_grenadeshield = level.vehicle.templates.bullet_shield[var_0];
  }

  self.healthbuffer = 20000;
  self.health += self.healthbuffer;
  var_1 = self.health;

  while(self.health > 0) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(istrue(self.interaction_is_jugg_maze_button)) {
      return;
    }

    var_12 = self.damage_functions;
    var_14 = getfirstarraykey(var_12);

    if(isDefined(var_14)) {
      var_13 = var_12[var_14];
      GscBinSkip1(0x74, var_13, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    var_12 = undefined;
    var_14 = undefined;

    if(isDefined(var_3)) {
      var_3 scripts\engine\utility::script_func("register_shot_hit");

      if(scripts\engine\utility::func_ref_exist("vehicle_damage_modifier")) {
        var_15 = undefined;

        if(isDefined(level.player_xp)) {
          var_15 = [[level.player_xp]](var_3, self, var_2, var_11, var_6, undefined, var_5, var_4, var_7, var_9, var_8, var_10);
        }

        if(isDefined(var_15)) {
          self.is_area_in_verdansk = var_15;
        } else {
          self.is_area_in_verdansk = undefined;
        }

        var_16 = scripts\engine\utility::script_func("vehicle_damage_modifier", var_15);

        if(isDefined(var_16)) {
          var_2 = var_16;
        }
      }
    }

    if(vehicle_should_regenerate(var_3, var_6) || _is_godmode()) {
      if(isDefined(self.regenerate) && !istrue(self.regenerate)) {
        var_1 = self.health;
      } else {
        self.health = var_1;
      }
    } else {
      if(scripts\common\utility::issp() && isDefined(var_6)) {
        var_17 = 0;

        if(var_6 == "MOD_GRENADE_SPLASH" || var_6 == "MOD_PROJECTILE_SPLASH") {
          var_17 = var_2 * 12;
        } else if(var_6 == "MOD_GRENADE" || var_6 == "MOD_PROJECTILE") {
          var_17 = var_2 * 5;
        }

        if(var_17) {
          self.health -= int(var_17);
        }
      }

      var_1 = self.health;
    }

    if(!istrue(self.ref_13dd4) && self.health <= self.healthbuffer) {
      self notify("death", var_3, var_6, var_11, var_5);
    }
  }
}

function vehicle_isalive(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(var_0.healthbuffer) && var_0.health < var_0.healthbuffer) {
    return false;
  }

  if(var_0.health <= 0) {
    return false;
  }

  return true;
}

function grenadeshielded(var_0) {
  if(!isDefined(self.script_grenadeshield)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "grenade")) {
    return 0;
  }

  if(self.script_grenadeshield) {
    return 1;
  }

  return 0;
}

function bulletshielded(var_0) {
  if(!isDefined(self.script_bulletshield)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "bullet") || issubstr(var_0, "explosive")) {
    return 0;
  }

  if(self.script_bulletshield) {
    return 1;
  }

  return 0;
}

function explosive_bulletshielded(var_0) {
  if(!isDefined(self.script_explosive_bullet_shield)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "explosive")) {
    return 0;
  }

  if(self.script_explosive_bullet_shield) {
    return 1;
  }

  return 0;
}

function vehicle_should_regenerate(var_0, var_1) {
  return !isDefined(var_0) && self.script_team != "neutral" || attacker_isonmyteam(var_0) || attacker_troop_isonmyteam(var_0) || is_invulnerable_from_ai(var_0) || bulletshielded(var_1) || explosive_bulletshielded(var_1) || grenadeshielded(var_1) || var_1 == "MOD_MELEE";
}

function _is_godmode() {
  return istrue(self.godmode);
}

function is_invulnerable_from_ai(var_0) {
  if(!isDefined(self.script_ai_invulnerable)) {
    return 0;
  }

  if(isDefined(var_0) && isai(var_0) && self.script_ai_invulnerable == 1) {
    return 1;
  }

  return 0;
}

function attacker_troop_isonmyteam(var_0) {
  if(!istrue(self.ref_13dd4) && isDefined(self.script_team) && self.script_team == "allies" && isDefined(var_0) && isPlayer(var_0)) {
    return 1;
  }

  if(isai(var_0) && scripts\engine\utility::is_equal(var_0.team, self.script_team)) {
    return 1;
  }

  return 0;
}

function attacker_isonmyteam(var_0) {
  if(isDefined(var_0) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team) {
    return true;
  }

  return false;
}

function vehicle_setwheeldirection(var_0) {
  self.vehiclewheeldirection = scripts\engine\utility::ter_op(var_0 <= 0, 0, 1);
}

function vehicle_playexhausteffect() {
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

function vehicle_playengineeffect() {
  var_0 = level.vehicle.templates.engine_fx[self.classname];

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = 0.25;
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    if(!vehicle_isalive(self)) {
      return;
    }

    var_4 = var_0.effect;
    var_3 = var_0.effect_tag;
    var_5 = self vehicle_getspeed() / self vehicle_gettopspeedforward();

    if(isDefined(self.enginefx_effort_scale)) {
      var_5 *= self.enginefx_effort_scale;
    }

    if(isDefined(var_0.max_effort_effect) && var_5 >= var_0.max_effort_ratio) {
      var_4 = var_0.max_effort_effect;
    } else if(isDefined(var_0.med_effort_effect) && var_5 >= var_0.med_effort_ratio) {
      var_4 = var_0.med_effort_effect;
    } else if(isDefined(var_0.min_effort_effect) && var_5 >= var_0.min_effort_ratio) {
      var_4 = var_0.min_effort_effect;
    }

    if(!isDefined(var_2) || var_2 != var_4) {
      if(isDefined(var_2)) {
        stopFXOnTag(var_2, self, var_3);
        waitframe();

        if(!vehicle_isalive(self)) {
          return;
        }
      }

      playFXOnTag(var_4, self, var_3);
      var_2 = var_4;
    }

    wait var_1;
  }
}

function vehicle_pathdetach() {
  self.attachedpath = undefined;
  self notify("newpath");

  if(ishelicopter_internal()) {
    self setgoalyaw(scripts\engine\utility::flat_angle(self.angles)[1]);
    self setvehgoalpos(self.origin + (0, 0, 4), 1);
    return;
  }
}

function deathrollon() {
  if(self.health > 0) {
    self.rollingdeath = 1;
    return;
  }
}

function deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
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

  if(ishelicopter_internal() && hashelicopterturret()) {
    if(isDefined(level.chopperturretfunc)) {
      self thread[[level.chopperturretofffunc]]();
      return;
    }
  }

  if(!isDefined(self.mgturret)) {
    return;
  }

  foreach(var_1 in self.mgturret) {
    _turretoffshared(var_1);
  }
}

function _mgon() {
  self.script_turretmg = 1;

  if(ishelicopter_internal() && hashelicopterturret()) {
    self thread[[level.chopperturretonfunc]]();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }

  foreach(var_1 in self.mgturret) {
    var_1 show();
    _turretonshared(var_1);
  }
}

function _turretoffshared(var_0) {
  if(isDefined(var_0.script_fireondrones)) {
    var_0.script_fireondrones = 0;
  }

  var_0 setmode("manual");
}

function _turretonshared(var_0) {
  if(isDefined(var_0.script_fireondrones)) {
    var_0.script_fireondrones = 1;
  }

  if(isDefined(var_0.defaultonmode)) {
    if(var_0.defaultonmode != "sentry") {
      var_0 setmode(var_0.defaultonmode);
    }
  } else {
    var_0 setmode("auto_nonai");
  }

  set_turret_team(var_0);
}

function get_vehicle_riders_spawners() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = scripts\engine\utility::noself_func_return("getspawnerarray", self.target);

    if(!isDefined(var_1)) {
      var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
    }

    if(!isDefined(var_1)) {
      var_1 = [];
    }

    foreach(var_3 in var_1) {
      if(isstruct(var_3)) {
        if(!isDefined(var_3.script_demeanor)) {
          continue;
        }
      } else {
        if(!issubstr(var_3.code_classname, "actor") && !issubstr(var_3.code_classname, "vehicle")) {
          continue;
        }

        if(issubstr(var_3.code_classname, "actor")) {
          if(!isspawner(var_3)) {
            continue;
          } else if(issubstr(var_3.code_classname, "vehicle")) {
            if(!(var_3.spawnflags & 2)) {
              continue;
            }
          }
        }
      }

      if(isDefined(var_3.dont_auto_ride)) {
        continue;
      }

      var_0 = var_3;
    }
  }

  return var_0;
}

function vehicle_spawn_internal(var_0) {
  if(isDefined(var_0.script_delay_spawn)) {
    var_0 endon("death");
    wait var_0.script_delay_spawn;
  }

  if(!scripts\common\utility::issp()) {
    var_1 = vehicle_spawn_mp_internal(var_0);
  } else {
    var_1 = var_1 vehicle_dospawn();
  }

  if(!isDefined(var_1.spawned_count)) {
    var_1.spawned_count = 0;
  }

  var_1.spawned_count++;
  var_1.vehicle_spawned_thisframe = var_1;
  var_1.last_spawned_vehicle = var_1;
  thread remove_vehicle_spawned_thisframe();
  var_1.vehicle_spawner = var_1;
  thread vehicle_init(var_1);
  var_1 notify("spawned", var_1);
  return var_1;
}

function vehicle_spawn_mp_internal(var_0) {
  var_1 = "temp_vehicle_targetname";

  if(isDefined(var_0.targetname)) {
    var_1 = var_0.targetname;
  }

  if(!isDefined(var_0.classname_mp)) {
    var_2 = var_0.classname;
  } else {
    var_2 = var_1.classname_mp;
  }

  var_3 = spawnVehicle(level.vehicle.templates.model[var_2], var_2, var_1.vehicletype, var_1.origin, var_1.angles);
  var_3.vehicletype = var_1.vehicletype;
  var_3.classname_mp = var_2;

  if(isDefined(var_1.target)) {
    var_3.target = var_1.target;
  }

  return var_3;
}

function setvehgoalpos_wrap(var_0, var_1) {
  return _setvehgoalpos_wrap(var_0, var_1);
}

function vehicle_liftoffvehicle(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 512;
  }

  var_1 = self.origin + (0, 0, var_0);
  self setneargoalnotifydist(10);
  setvehgoalpos_wrap(var_1, 1);
  self waittill("goal");
}

function vehicle_shouldplaydeathanimation(var_0) {
  if(!vehicle_hasdeathanimations(var_0)) {
    return false;
  }

  if(istrue(self.vehicle_skipdeathanimation)) {
    return false;
  }

  return true;
}

function vehicle_hasdeathanimations(var_0) {
  return isDefined(level.vehicle.templates.deathanimations[get_vehicle_classname(var_0)]);
}

function vehicle_getdeathanimation(var_0, var_1) {
  var_2 = level.vehicle.templates.deathanimations[get_vehicle_classname(var_0)];

  if(isDefined(var_1)) {
    var_3 = var_0 getpointinbounds(0.5, 0.5, 0.5);
    var_4 = var_1 - var_3;
    var_5 = [];
    GscBinSkip0(0x2e, "forward", anglesToForward(var_0.angles));
  }

  return scripts\engine\utility::random(var_5);
}

function vehicle_playdeathanimation(var_0) {
  self vehicle_turnengineoff();
  scripts\engine\utility::self_func("vehicle_orientto", self.origin, self.angles, 0, 0);
  self useanimtree(#animtree);
  self animScripted("vehicle_playDeathAnimation", self.origin, self.angles, var_0);
  self setneargoalnotifydist(30);

  if(scripts\common\vehicle::ishelicopter()) {
    self setvehgoalpos(self.origin, 1);
    self setgoalyaw(self.angles[1]);
    return;
  }
}

function vehicle_setcrashing(var_0) {
  self.vehiclecrashing = var_0;
}

function vehicle_docrash(var_0, var_1) {
  if(istrue(self.vehicle_skipdeathcrash)) {
    return;
  }

  vehicle_setcrashing(1);

  if(self vehicle_isphysveh()) {
    self vehphys_crash();

    if(!istrue(self.dontdisconnectpaths)) {
      self disconnectPaths();
    }

    while(!vehicle_iscorpse() && isDefined(self) && !vehicle_is_stopped()) {
      waitframe();
    }
  } else if(ishelicopter_internal()) {
    thread vehicle_helicoptercrash(var_0, var_1);
    self waittill("vehicle_crashDone");
  }

  vehicle_setcrashing(0);
}

function vehicle_helicoptercrash(var_0, var_1) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    self.original_attacker = var_0;
  }

  if(!isDefined(self)) {
    return;
  }

  detach_getoutrigs();
  thread helicopter_crash_move(var_0, var_1);
}

function helicopter_crash_move(var_0, var_1) {
  self endon("in_air_explosion");
  jumpiffalse(isDefined(self.perferred_crash_location)) LOC_00000020;
  var_2 = self.perferred_crash_location;
  goto LOC_00000037;
}

function helicopter_crash_path(var_0) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_1 = 56;

    if(isDefined(var_0.radius)) {
      var_1 = var_0.radius;
    }

    self setneargoalnotifydist(var_1);
    self setvehgoalpos(var_0.origin, 0);
    scripts\engine\utility::ref_143a5("goal", "near_goal");
  }
}

function helicopter_crash_flavor(var_0, var_1) {
  self endon("vehicle_crashDone");
  self clearlookatent();

  if(soundexists("hind_helicopter_dying_loop")) {
    self playLoopSound("hind_helicopter_dying_loop");
  }

  var_2 = 0;

  if(isDefined(self.preferred_crash_style)) {
    var_2 = self.preferred_crash_style;

    if(self.preferred_crash_style < 0) {
      var_3 = [1, 2, 2];
      var_4 = 5;
      var_5 = randomint(var_4);
      var_6 = 0;

      foreach(var_8 in var_3) {
        var_6 += var_8;

        if(var_5 < var_6) {
          var_2 = var_9;
          break;
        }
      }
    }
  }

  switch (var_2) {
    case 1:
      thread helicopter_crash_zigzag();
      break;
    case 2:
      thread helicopter_crash_directed(var_0, var_1);
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
  var_0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.vehicle_rocket_death_fx[var_0])) {
    var_1 = level.vehicle.templates.vehicle_rocket_death_fx[var_0];
    var_2 = var_1[1];

    if(isDefined(var_2.waitdelay)) {
      wait var_2.waitdelay;
    }

    waitframe();
  }

  self notify("vehicle_crashDone");
  self notify("in_air_explosion");
}

function helicopter_pilot_death_explosion() {
  thread helicopter_crash_rotate();
  scripts\engine\utility::waittill_notify_or_timeout("goal", 3);
  self notify("flavor_done");
  thread helicopter_in_air_explosion();
}

function helicopter_unloading_watcher() {
  if(!scripts\common\vehicle::ishelicopter()) {
    return;
  }

  self endon("vehicle_crashDone");
  self waittill("unloading");
  self.unloading = 1;
  self waittill("unloaded");
  self.unloading = 0;
}

function helicopter_crash_directed(var_0, var_1) {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var_2 = 90 * randomintrange(-2, 3);

  for(;;) {
    var_3 = var_0 - self.origin;
    var_4 = vectortoyaw(var_3);
    var_4 += var_2;
    self settargetyaw(var_4);
    wait 0.1;
  }
}

function helicopter_crash_zigzag() {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  var_0 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    var_1 = randomintrange(20, 120);

    if(var_0) {
      self settargetyaw(self.angles[1] + var_1);
    } else {
      self settargetyaw(self.angles[1] - var_1);
    }

    var_0 = 1 - var_0;
    var_2 = randomfloatrange(0.5, 1);
    wait var_2;
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

    var_0 = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + var_0);
    wait 0.5;
  }
}

function get_unused_crash_locations() {
  var_0 = [];
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_removeundefined(level.vehicle.helicopter_crash_locations);

  foreach(var_2 in level.vehicle.helicopter_crash_locations) {
    if(isDefined(var_2.claimed)) {
      continue;
    }

    var_0 = var_2;
  }

  return var_0;
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

  var_0 = getarraykeys(self.fastroperig);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(self.fastroperig[var_0[var_1]])) {
      self.fastroperig[var_0[var_1]] unlink();
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

  self setModel(level.vehicle.templates.deathmodel[self.model]);
}