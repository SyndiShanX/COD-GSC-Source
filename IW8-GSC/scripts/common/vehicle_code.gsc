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
  var0 = [];
  level.needsprecaching = [];

  if(!isDefined(level.vehicleinitthread)) {
    level.vehicleinitthread = [];
  }

  var1 = getEntArray("script_vehicle", "code_classname");

  foreach(var3 in var1) {
    var3.vehicletype = tolower(var3.vehicletype);

    if(var3.vehicletype == "empty" || var3.vehicletype == "empty_heli") {
      continue;
    }

    var0 = var3;
    vehicle_precachesetup(var3.classname, var3);
  }

  if(level.needsprecaching.size > 0) {
    var5 = "";

    foreach(var7 in level.needsprecaching) {
      foreach(var9 in var7) {
        foreach(var11 in var9.reasons) {}
      }
    }

    level waittill("never");
  }

  return var0;
}

function vehicle_precachesetup(var0, var1) {
  if(isDefined(level.vehicleinitthread[var1.vehicletype]) && isDefined(level.vehicleinitthread[var1.vehicletype][var1.classname])) {
    return;
  }

  if(var1.classname == "script_vehicle") {
    return;
  }

  var2 = [];

  if(isDefined(level.needsprecaching[var0])) {
    var2 = level.needsprecaching[var0];
  }

  var3 = spawnStruct();
  var3.pos = var1.origin;
  var3.reasons = [];

  if(!isDefined(level.vehicleinitthread[var1.vehicletype])) {
    var3.reasons[var3.reasons.size] = "vehicletype \"" + var1.vehicletype + "\" is not setup properly. Maybe you just need to re-package? Or you have a Radiant copy/paste issue where you have the wrong vehicletype set?";
  } else if(!isDefined(level.vehicleinitthread[var1.vehicletype][var1.classname])) {
    var3.reasons[var3.reasons.size] = "classname \"" + var1.classname + "\"is not setup properly. Maybe you just need to re-package? Or the vehicle's Quaked is not setup properly";
  }

  var2 = var3;
  level.needsprecaching[var0] = var2;
}

function vehicle_setupspawners() {
  var0 = _getvehiclespawnerarray();

  foreach(var2 in var0) {
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
    self waittill("spawned", var0);
    self.count--;

    if(!isDefined(var0)) {
      continue;
    }

    var0.spawn_funcs = self.spawn_functions;
    var0.spawner = self;
    var0 thread scripts\engine\utility::script_func("run_spawn_functions");
  }
}

function vehicle_triggerkillspawner(var0) {
  var0 waittill("trigger");

  foreach(var2 in vehicle_getspawnerarray()) {
    if(scripts\engine\utility::is_equal(var2.script_kill_vehicle_spawner, var0.script_kill_vehicle_spawner)) {
      var2 delete();
    }
  }
}

function vehicle_spawnaiarray(var0) {
  var1 = [];
  var2 = scripts\engine\utility::ent_flag_exist("no_riders_until_unload") && scripts\engine\utility::ent_flag("no_riders_until_unload");

  foreach(var4 in var0) {
    var4.count = 1;
    var5 = 0;

    if(isDefined(var4.script_drone)) {
      var5 = 1;
      var6 = scripts\engine\utility::script_func("dronespawn_bodyonly", var4);
      var6 scripts\engine\utility::script_func("drone_give_soul");
    } else if(isDefined(var4.script_fakeactor) || isDefined(var4.script_bodyonly)) {
      var5 = 1;
      var6 = scripts\engine\utility::script_func("bodyonlyspawn", var4);
      var6 scripts\engine\utility::script_func("fakeactor_give_soul");
    } else {
      var6 = var4 scripts\engine\utility::script_func("spawn_ai", var2);
    }

    if(!var5 && !isalive(var6)) {
      continue;
    }

    var1 = scripts\engine\utility::array_add(var1, var6);
  }

  var8 = vehicle_removenonridersfromaiarray(var1);
  return var8;
}

function vehicle_removenonridersfromaiarray(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!ai_should_be_added(var3)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function ai_should_be_added(var0) {
  if(isalive(var0)) {
    return true;
  }

  if(!isDefined(var0)) {
    return false;
  }

  if(!isDefined(var0.classname)) {
    return false;
  }

  return var0.classname == "script_model";
}

function spawn_riders() {
  if(scripts\engine\utility::ent_flag_exist("no_riders_until_unload") && !scripts\engine\utility::ent_flag("no_riders_until_unload")) {
    self notify("spawnedRiders");
    return [];
  }

  var0 = get_vehicle_riders_spawners();

  if(!var0.size) {
    self notify("spawnedRiders");
    return [];
  }

  var1 = spawn_group(var0);
  self notify("spawnedRiders", var1);
  return var1;
}

function spawn_group(var0) {
  var1 = vehicle_spawnaiarray(var0);
  var1 = sort_by_startingpos(var1);

  foreach(var3 in var1) {
    thread scripts\common\vehicle_aianim::guy_enter(var3);
  }

  thread set_loaded_when_full(var1);
  return var1;
}

function set_loaded_when_full(var0) {
  scripts\engine\utility::array_wait(var0, "loaded", 1);
  scripts\common\vehicle_aianim::vehicle_loaded_if_full(self);
}

function spawn_unload_group(var0) {
  if(!isDefined(var0)) {
    return spawn_riders();
  }

  var1 = get_vehicle_riders_spawners();

  if(!var1.size) {
    return [];
  }

  var2 = [];
  var3 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.unloadgroups[var3]) && isDefined(level.vehicle.templates.unloadgroups[var3][var0])) {
    var4 = level.vehicle.templates.unloadgroups[var3][var0];

    for(var5 = 0; var5 < var4.size; var5++) {
      if(isDefined(var1[var5])) {
        var1[var5].script_startingposition = var4[var5];
      }
    }

    var1 = sort_by_startingpos(var1);

    foreach(var7 in var4) {
      foreach(var9 in var1) {
        if(var9.script_startingposition == var7) {
          var2 = var9;
        }
      }
    }

    var12 = vehicle_spawnaiarray(var2);

    foreach(var14 in var12) {
      thread scripts\common\vehicle_aianim::guy_enter(var14);
    }

    self notify("spawnedRiders", var12);
    return var12;
  }

  return spawn_riders();
}

function sort_by_startingpos(var0) {
  var1 = [];
  var2 = [];

  foreach(var4 in var0) {
    if(isDefined(var4.script_startingposition)) {
      var1 = var4;
      continue;
    }

    var2 = var4;
  }

  return scripts\engine\utility::array_combine(var1, var2);
}

function remove_vehicle_spawned_thisframe() {
  waitframe();
  self.vehicle_spawned_thisframe = undefined;
}

function vehicle_init(var0) {
  var1 = get_vehicle_classname(var0);

  if(isDefined(level.vehicle.templates.hide_part_list[var1])) {
    foreach(var3 in level.vehicle.templates.hide_part_list[var1]) {
      var0 hidepart(var3);
    }
  }

  if(var0.vehicletype == "empty" || var0.vehicletype == "empty_heli") {
    var0 thread scripts\common\vehicle_paths::getonpath();
    return;
  }

  var0 scripts\engine\utility::set_ai_number();
  var5 = var0.vehicletype;
  vehicle_setstartinghealth(var0);
  vehicle_setteam(var0);

  if(isDefined(level.vehicleinitthread[var0.vehicletype][var1])) {}

  var0 thread[[level.vehicleinitthread[var0.vehicletype][var1]]]();
  thread vehicle_playexhausteffect();
  thread vehicle_playengineeffect();

  if(!isDefined(var0.script_avoidplayer)) {
    var0.script_avoidplayer = 0;
  }

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal) {
      var0 thermaldrawenable();
    }
  }

  var0 scripts\engine\utility::ent_flag_init("unloaded");
  var0 scripts\engine\utility::ent_flag_init("loaded");
  var0 scripts\engine\utility::ent_flag_init("landed");
  var0.riders = [];
  var0.unloadque = [];
  var0.unload_group = "default";
  var0.fastroperig = [];

  if(isDefined(level.vehicle.templates.attachedmodels) && isDefined(level.vehicle.templates.attachedmodels[var1])) {
    var6 = level.vehicle.templates.attachedmodels[var1];
    var7 = getarraykeys(var6);

    foreach(var9 in var7) {
      var0.fastroperig[var9] = undefined;
      var0.fastroperiganimating[var9] = 0;
    }
  }

  if(isDefined(var0.script_vehicle_lights_on)) {
    var0 thread scripts\common\vehicle_lights::lights_on(var0.script_vehicle_lights_on);
  }

  if(isDefined(var0.script_godmode)) {
    var0.godmode = 1;
  }

  thread vehicle_damagelogic();
  var0 thread scripts\common\vehicle_aianim::handle_attached_guys();

  if(isDefined(var0.script_friendname)) {
    var0 setvehiclelookattext(var0.script_friendname, &"");
  }

  thread vehicle_handleunloadevent();

  if(isDefined(var0.script_dontunloadonend)) {
    var0.dontunloadonend = 1;
  }

  thread vehicle_rumble();
  var0 thread scripts\engine\utility::script_func("vehicle_treads");
  thread idle_animations();
  thread animate_drive_idle();

  if(isDefined(var0.script_deathflag)) {
    var0 thread scripts\engine\utility::script_func("vehicle_deathflag");
  }

  thread mainturretinit();
  thread mginit();

  if(isDefined(level.vehicle.spawn_callback_thread)) {
    level thread[[level.vehicle.spawn_callback_thread]](var0);
  }

  if(isDefined(var0.script_team)) {
    var0 setvehicleteam(var0.script_team);
  }

  if(var0 scripts\common\vehicle::ishelicopter()) {
    thread vehicle_ai_avoidance_heli();
  } else {
    thread vehicle_ai_avoidance_logic();
  }

  var0 thread scripts\common\vehicle_paths::getonpath();

  if(isDefined(level.ignorewash)) {
    var11 = level.ignorewash;
  } else {
    var11 = 0;
  }

  if(scripts\common\utility::issp() && vehicle_hasdustkickup(var1) && !var11) {
    thread aircraft_wash_thread();
  }

  if(var1 vehicle_isphysveh()) {
    var1.veh_pathtype = "constrained";

    if(isDefined(var1.script_pathtype)) {
      var1.veh_pathtype = var1.script_pathtype;
    }
  }

  spawn_riders(var1);
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

  var0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.rumble[var0])) {
    self stoprumble(level.vehicle.templates.rumble[var0].rumble);
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
  self waittill("death", var0, var1, var2, var3);
  vehicle_deathcustomlogic(var0, var1, var2);
  vehicle_playdeatheffects(var0, var1, var3);
  thread vehicle_killriders();
  vehicle_setdeathmodel();
  vehicle_docrash(var0, var1);

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

function vehicle_deathcustomlogic(var0, var1, var2) {
  if(isDefined(self.custom_death_script)) {
    self thread[[self.custom_death_script]]();
  }

  if(isDefined(level.vehicle.templates.death_thread[self.vehicletype])) {
    GscBinSkip1(0x74, level.vehicle.templates.death_thread[self.vehicletype]);
  }

  var3 = isDefined(var0) && isDefined(var1) && isDefined(var2);

  if(var3) {
    var4 = createheadicon(var2);
    var0 scripts\engine\utility::script_func("register_kill", self, var1, var4);
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

  foreach(var1 in self.riders) {
    if(!isalive(var1)) {
      continue;
    }

    if(!isDefined(var1.ridingvehicle)) {
      continue;
    }

    if(isDefined(var1.magic_bullet_shield)) {
      var1 scripts\common\ai::stop_magic_bullet_shield();
    }

    if(isDefined(var1._blackboard) && isDefined(var1._blackboard.chosenvehicleanimpos) && istrue(var1._blackboard.chosenvehicleanimpos.isincircle)) {
      var2 = 100;
      var3 = self vehicle_getvelocity();
      var1.do_immediate_ragdoll = 1;
      var1.ragdollhitloc = "torso_lower";
      var1.ragdollimpactvector = (var1.origin - self.origin) * var2 + var3;
    }

    if(scripts\common\utility::iscp() && isDefined(self.is_area_in_verdansk)) {
      if(isDefined(self.is_area_in_verdansk.attacker) && isPlayer(self.is_area_in_verdansk.attacker)) {
        var1 dodamage(var1.maxhealth, self.is_area_in_verdansk.attacker.origin, self.is_area_in_verdansk.attacker, self.is_area_in_verdansk.attacker, self.is_area_in_verdansk.meansofdeath, self.is_area_in_verdansk.objweapon);
      } else {
        var1 kill();
      }

      continue;
    }

    var1 kill();
  }
}

function vehicle_rider_death_detection(var0) {
  if(isDefined(self.vehicle_position) && self.vehicle_position != 0) {
    return;
  }

  self.health = 1;
  var0 endon("death");
  self.baseaccuracy = 0.15;
  self waittill("death");
  var0 notify("driver_died");
  vehicle_killriders(var0);
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

function _vehicle_landvehicle(var0, var1) {
  self endon("death");
  self notify("newpath");

  if(!isDefined(var0)) {
    var0 = 2;
  }

  self setneargoalnotifydist(var0);
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

function vehicle_landanims(var0, var1) {
  self endon("death");
  var2 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.landanims[var2])) {
    return;
  }

  var3 = level.vehicle.templates.landanims[var2];

  foreach(var5 in var3) {
    self setanim(var5.land, 1, 0.2, 1);
  }

  if(!var1) {
    return;
  }

  if(isDefined(var0)) {
    self waittill("unloaded");
  } else {
    self waittill("continuepath");
  }

  foreach(var5 in var3) {
    self clearanim(var5.land, 0);
    self setanim(var5.takeoff, 1, 0.2, 1);
  }
}

function vehicle_landvehicle(var0, var1) {
  return _vehicle_landvehicle(var0, var1);
}

function spawn_vehicle_and_attach_to_spline_path(var0) {
  var1 = scripts\common\utility::spawn_vehicle();

  if(isDefined(var0)) {
    var1 vehicle_setspeed(var0);
  }

  thread vehicle_becomes_crashable();
  var1 endon("death");
  var1.dontunloadonend = 1;
  var1 scripts\common\vehicle_paths::gopath(var1);
  leave_path_for_spline_path(var1);
}

function leave_path_for_spline_path() {
  self endon("script_crash_vehicle");
  scripts\engine\utility::waittill_either("enable_spline_path", "reached_end_node");
  var0 = get_my_spline_node(self.origin);

  if(isDefined(level.drive_spline_path_fun)) {
    var0 thread[[level.drive_spline_path_fun]](self);
    return;
  }
}

function get_my_spline_node(var0) {
  var0 = (var0[0], var0[1], 0);
  var1 = scripts\engine\utility::get_array_of_closest(var0, level.snowmobile_path);
  var2 = [];

  for(var3 = 0; var3 < 3; var3++) {
    var2 = var1[var3];
  }

  foreach(var5 in level.snowmobile_path) {
    foreach(var7 in var2) {
      if(var7 == var5) {
        return var7;
      }
    }
  }
}

function waittill_stable(var0) {
  var1 = 12;
  var2 = 400;
  var3 = gettime() + var2;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var1 || abs(self.angles[2]) > var1) {
      var3 = gettime() + var2;
    }

    if(gettime() > var3) {
      break;
    }

    wait 0.05;
  }
}

function _vehicle_unload(var0) {
  self endon("death");

  if(isDefined(var0)) {
    self.unload_group = var0;
  }

  if(scripts\engine\utility::ent_flag_exist("no_riders_until_unload")) {
    scripts\engine\utility::ent_flag_set("no_riders_until_unload");
    var1 = spawn_unload_group(self.unload_group);

    foreach(var3 in var1) {
      scripts\common\ai::spawn_failed(var3);
    }

    waittillframeend();
  }

  self notify("unloading");
  var1 = [];
  var5 = level.vehicle.templates.unloadgroups[get_vehicle_classname()];

  if(isDefined(var5)) {
    var6 = scripts\common\vehicle_aianim::get_unload_group();

    if(istrue(self.vehiclesetuprope)) {
      var7 = 0;

      while(var7 < level.vehicle.templates.aianims[get_vehicle_classname()].size) {
        var8 = level.vehicle.templates.aianims[get_vehicle_classname()][var7];

        if(istrue(var8.setuprope)) {
          var9 = 0;

          foreach(var11 in self.riders) {
            if(isDefined(var6[var11.vehicle_position]) && var11.vehicle_position != var7) {
              var12 = scripts\common\vehicle_aianim::anim_pos(self, var11.vehicle_position);

              if(var12.fastroperig == var8.fastroperig) {
                var9 = 1;
                break;
              }
            }
          }

          var9 = undefined;
          var11 = undefined;

          if(var8) {
            foreach(var10 in self.riders) {
              if(var10.vehicle_position == var6) {
                scripts\common\vehicle_aianim::guy_setup_rope(var10, var7);
                break;
              }
            }
          }
        }

        var6++;
      }
    }

    foreach(var11 in self.riders) {
      if(isalive(var11) && isDefined(var5[var11.vehicle_position])) {
        if(isDefined(level.vehicle.aianimcheck["unload"]) && ![[level.vehicle.aianimcheck["unload"]]](var11, var11.vehicle_position)) {
          continue;
        }

        var8 = scripts\common\vehicle_aianim::anim_pos(self, var11.vehicle_position);

        if(isDefined(var8) && istrue(var8.lootspawnitem)) {
          continue;
        }

        if(isDefined(level.vehicle.aianimthread["unload"])) {
          if(!istrue(var8.setuprope)) {
            var11 notify("newanim");
            GscBinSkip1(0x74, level.vehicle.aianimthread["unload"], var11, var11.vehicle_position);
          }
        }
      }
    }
  }

  return var0;
}

function _setvehgoalpos_wrap(var0, var1) {
  if(self.health <= 0) {
    return;
  }

  if(isDefined(self.originheightoffset)) {
    var0 += (0, 0, self.originheightoffset);
  }

  self setvehgoalpos(var0, var1);
}

function vehicle_kill_badplace_forever() {
  self notify("kill_badplace_forever");
}

function vehicle_isdestructible() {
  return isDefined(self.destructible_type);
}

function _kill_fx_play_direction(var0, var1) {
  if(isDefined(var0) && isDefined(var1)) {
    var2 = self getentityvelocity();
    var2 = vectorNormalize(var2);
    var0 = vectorNormalize(var0);
    var3 = vectorlerp(var2, var0, var1);
    return var3;
  }

  return undefined;
}

function vehicle_playdeatheffects(var0, var1, var2) {
  if(vehicle_isdestructible()) {
    return;
  }

  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);
  thread vehicle_deathearthquake();
  thread vehicle_deathradiusdamage();
  thread vehicle_deathkilllights();
  thread vehicle_deathjolt(var2);
  thread vehicle_deathvfx(var0, var1);
}

function vehicle_deathvfx(var0, var1) {
  var2 = get_vehicle_classname();

  if(vehicle_shoulddorocketdeath(var0, var1, var2)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 3;
    var3 = level.vehicle.templates.vehicle_rocket_death_fx[var2];
  } else if(istrue(self.pilot_killed)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 4;
    var3 = level.vehicle.templates.vehicle_rocket_death_fx[var3];
  } else {
    var3 = level.vehicle.templates.vehicle_death_fx[var3];
  }

  foreach(var5 in var3) {
    thread kill_fx_thread(self.model, var5, self.vehicletype, var2);
  }
}

function vehicle_deathearthquake() {
  var0 = level.vehicle.templates.death_earthquake[get_vehicle_classname()];

  if(isDefined(var0)) {
    earthquake(var0.scale, var0.duration, self.origin, var0.radius);
    return;
  }
}

function vehicle_deathradiusdamage() {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }

  var0 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.death_radiusdamage) || !isDefined(level.vehicle.templates.death_radiusdamage[var0])) {
    return;
  }

  var1 = level.vehicle.templates.death_radiusdamage[var0].maxdamage;
  var2 = level.vehicle.templates.death_radiusdamage[var0].mindamage;
  self radiusdamage(self.origin + level.vehicle.templates.death_radiusdamage[var0].offset, level.vehicle.templates.death_radiusdamage[var0].range, var1, var2, self);
}

function vehicle_deathkilllights() {
  scripts\common\vehicle_lights::lights_off_internal("all", self.model, get_vehicle_classname());
}

function vehicle_deathjolt(var0) {
  if(scripts\common\vehicle::ishelicopter()) {
    return;
  }

  if(!scripts\common\utility::issp() && self issuspendedvehicle()) {
    return;
  }

  self joltbody(var0, 3);
}

function vehicle_shoulddorocketdeath(var0, var1, var2) {
  if(!vehicle_hasrocketdeath(var2)) {
    return false;
  }

  if(istrue(self.vehicle_forcerocketdeath)) {
    return true;
  }

  if(scripts\engine\utility::is_equal(var1, "MOD_PROJECTILE")) {
    return true;
  }

  if(scripts\engine\utility::is_equal(var1, "MOD_PROJECTILE_SPLASH")) {
    return true;
  }

  if(scripts\engine\utility::is_equal(var1, "MOD_GRENADE")) {
    return true;
  }

  return false;
}

function vehicle_hasrocketdeath(var0) {
  return isDefined(level.vehicle.templates.vehicle_rocket_death_fx[var0]);
}

function kill_fx_thread(var0, var1, var2, var3) {
  if(isDefined(self.pilot_killed)) {
    self waittill("flavor_done");
  }

  if(isDefined(self.nodeath)) {
    return;
  }

  if(!isDefined(var3)) {
    return;
  }

  if(isDefined(var1.waitdelay)) {
    if(var1.waitdelay >= 0) {
      wait var1.waitdelay;
    } else {
      self waittill("death_finished");
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var1.notifystring)) {
    self notify(var1.notifystring);
  }

  var4 = vectorNormalize(self.origin - var3.origin);

  if(isDefined(var1.selfdeletedelay)) {
    scripts\engine\utility::delaycall(var1.selfdeletedelay, &delete);
  }

  if(isDefined(var1.effect)) {
    if(var1.beffectlooping) {
      if(isDefined(var1.tag)) {
        if(isDefined(var1.stayontag) && var1.stayontag == 1) {
          thread loop_fx_on_vehicle_tag(var1.effect, var1.delay, var1.tag);
        } else {
          thread playloopedfxontag(var1.effect, var1.delay, var1.tag);
        }
      } else {
        var5 = self.origin + (0, 0, 100) - self.origin;
        playFX(var1.effect, self.origin, var5);
      }
    } else if(isDefined(var1.tag)) {
      var5 = _kill_fx_play_direction(var4, var1.attacker_velocity_lerp);

      if(isDefined(var5)) {
        var6 = deathfx_ent();
        playFX(var1.effect, var6 gettagorigin(var1.tag), var5);

        if(isDefined(var1.remove_deathfx_entity_delay)) {
          var6 scripts\engine\utility::delaycall(var1.remove_deathfx_entity_delay, &delete);
        }
      } else {
        var6 = deathfx_ent();
        playFXOnTag(var2.effect, var6, var2.tag);
        thread stop_fx_on_vehicle_watcher(var2.effect, var6, var2.tag);

        if(isDefined(var2.remove_deathfx_entity_delay)) {
          deathfx_ent() scripts\engine\utility::delaycall(var2.remove_deathfx_entity_delay, &delete);
        }
      }
    } else {
      var5 = _kill_fx_play_direction(var6, var3.attacker_velocity_lerp);

      if(isDefined(var5)) {
        playFX(var3.effect, self.origin, var5);
      } else {
        var5 = self.origin + (0, 0, 100) - self.origin;
        playFX(var3.effect, self.origin, var5);
      }
    }
  }

  if(isDefined(var3.sound)) {
    if(var3.bsoundlooping) {
      thread death_firesound(var3.sound);
      return;
    }

    scripts\engine\utility::play_sound_in_space(var3.sound);
    return;
  }
}

function stop_fx_on_vehicle_watcher(var0, var1, var2) {
  var1 waittill("stop_all_death_fx");
  stopFXOnTag(var0, var1, var2);
}

function loop_fx_on_vehicle_tag(var0, var1, var2) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(var0, deathfx_ent(), var2);
    wait var1;
  }
}

function death_firesound(var0) {
  thread scripts\engine\utility::script_func("playloopsound_on_tag", var0, undefined, 0, 1);
  scripts\engine\utility::ref_143a5("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }

  self notify("stop sound" + var0);
}

function deathfx_ent() {
  if(isDefined(self.death_fx_on_self) && self.death_fx_on_self) {
    return self;
  }

  if(!isDefined(self.deathfx_ent)) {
    var0 = spawn("script_model", (0, 0, 0));
    var0 setModel(self.model);
    var0.origin = self.origin;
    var0.angles = self.angles;
    var0 notsolid();
    var0 hide();
    var0 linkTo(self);
    var0.death_fx = 1;
    self.deathfx_ent = var0;
  } else {
    self.deathfx_ent setModel(self.model);
  }

  return self.deathfx_ent;
}

function playloopedfxontag(var0, var1, var2) {
  var3 = spawn("script_origin", self.origin);
  self endon("fire_extinguish");
  thread playloopedfxontag_originupdate(var2, var3);

  for(;;) {
    playFX(var0, var3.origin, var3.upvec);
    wait var1;
  }
}

function playloopedfxontag_originupdate(var0, var1) {
  var1.angles = self gettagangles(var0);
  var1.origin = self gettagorigin(var0);
  var1.forwardvec = anglesToForward(var1.angles);
  var1.upvec = anglestoup(var1.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    var1.angles = self gettagangles(var0);
    var1.origin = self gettagorigin(var0);
    var1.forwardvec = anglesToForward(var1.angles);
    var1.upvec = anglestoup(var1.angles);
    wait 0.05;
  }
}

function _getvehiclespawnerarray(var0, var1) {
  var2 = [];

  if(isDefined(var0) && isDefined(var1)) {
    var3 = 1;
    var4 = getEntArray(var0, var1);
  } else {
    var3 = 0;
    var4 = getEntArray("script_vehicle", "code_classname");
  }

  foreach(var6 in var4) {
    if(var3 && var6.code_classname != "script_vehicle") {
      continue;
    }

    if(isspawner(var6)) {
      var4 = var6;
    }
  }

  return var4;
}

function update_steering(var0) {
  if(var0.update_time == gettime()) {
    return var0.steering;
  }

  var0.update_time = gettime();

  if(var0.steering_enable) {
    var1 = clamp(0 - var0.angles[2], 0 - var0.steering_maxroll, var0.steering_maxroll) / var0.steering_maxroll;

    if(isDefined(var0.leanasitturns) && var0.leanasitturns) {
      var2 = var0 vehicle_getsteering();
      var2 *= -1;
      var1 += var2;

      if(var1 != 0) {
        var3 = 1 / abs(var1);

        if(var3 < 1) {
          var1 *= var3;
        }
      }
    }

    var4 = var1 - var0.steering;

    if(var4 != 0) {
      var5 = var0.steering_maxdelta / abs(var4);

      if(var5 < 1) {
        var4 *= var5;
      }

      var0.steering += var4;
    }
  } else {
    var0.steering = 0;
  }

  return var0.steering;
}

function get_from_spawnStruct(var0) {
  return scripts\engine\utility::getStruct(var0, "targetname");
}

function get_from_entity(var0) {
  var1 = getEntArray(var0, "targetname");

  if(isDefined(var1) && var1.size > 0) {
    return var1[randomint(var1.size)];
  }

  return undefined;
}

function get_from_vehicle_node(var0) {
  return getvehiclenode(var0, "targetname");
}

function set_lookat_from_dest(var0) {
  var1 = getEnt(var0.script_linkto, "script_linkname");

  if(!isDefined(var1)) {
    return;
  }

  self setlookatent(var1);
  self.set_lookat_point = 1;
}

function damage_hint_bullet_only() {
  level.armordamagehints = 0;
  self.displayingdamagehints = 0;
  thread damage_hints_cleanup();

  while(isDefined(self)) {
    self waittill("damage", var0, var1, var2, var3, var4);

    if(!isPlayer(var1)) {
      continue;
    }

    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }

    var4 = tolower(var4);

    switch (var4) {
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level.armordamagehints) {
          if(isDefined(level.thrown_semtex_grenades) && level.thrown_semtex_grenades > 0) {
            break;
          }

          level.armordamagehints = 1;
          self.displayingdamagehints = 1;
          var1 scripts\engine\utility::script_func("display_hint", "invulerable_bullets");
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
    self waittill("damage", var0, var1, var2, var3, var4);

    if(!isPlayer(var1)) {
      continue;
    }

    if(isDefined(self.has_semtex_on_it)) {
      continue;
    }

    var4 = tolower(var4);

    switch (var4) {
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

          if(var4 == "mod_grenade" || var4 == "mod_grenade_splash") {
            var1 scripts\engine\utility::script_func("display_hint", "invulerable_frags", 5);
          } else {
            var1 scripts\engine\utility::script_func("display_hint", "invulerable_bullets", 5);
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

function aircraft_wash_thread(var0) {
  self endon("death");
  self endon("death_finished");
  self notify("stop_kicking_up_dust");
  self endon("stop_kicking_up_dust");
  var1 = 2000;

  if(isDefined(level.treadfx_maxheight)) {
    var1 = level.treadfx_maxheight;
  }

  var2 = 80 / var1;
  var3 = 0.5;

  if(isairplane_internal()) {
    var3 = 0.15;
  }

  var4 = self;

  if(isDefined(var0)) {
    var4 = var0;
  }

  var5 = 3;

  for(;;) {
    wait var3;

    if(true) {
      if(isDefined(self.disable_wash) && self.disable_wash) {
        continue;
      }

      if(isDefined(self.treadfx_maxheight)) {
        var1 = self.treadfx_maxheight;
      }

      var6 = anglestoup(var4.angles) * -1;
      var7 = undefined;
      var5++;

      if(var5 > 3) {
        var5 = 3;
        var7 = scripts\engine\trace::ray_trace(var4.origin, var4.origin + var6 * var1, var4, undefined, 1);
      }

      if(var7["fraction"] == 1 || var7["fraction"] < var2) {
        continue;
      }

      var8 = distance(var4.origin, var7["position"]);
      var9 = get_wash_fx(self, var7, var6, var8);

      if(!isDefined(var9)) {
        continue;
      }

      var3 = (var8 - 350) / (var1 - 350) * 0.1 + 0.05;
      var3 = max(var3, 0.05);

      if(!isDefined(var7)) {
        continue;
      }

      if(!isDefined(var7["position"])) {
        continue;
      }

      var10 = var7["position"];
      var11 = var7["normal"];
      var8 = vectordot(var10 - var4.origin, var11);
      var12 = var4.origin + (0, 0, var8);
      var13 = var10 - var12;

      if(isDefined(self.treadfx_orient_to_player)) {
        var13 = var10 - level.player.origin;
      }

      if(vectordot(var7["normal"], (0, 0, 1)) == -1) {
        continue;
      }

      if(length(var13) < 1) {
        var13 = var4.angles + (0, 180, 0);
      }

      playFX(var9, var10, var11, var13);
    }
  }
}

function get_wash_fx(var0, var1, var2, var3) {
  var4 = var1["surfacetype"];
  var5 = undefined;
  var6 = vectordot((0, 0, -1), var2);

  if(var6 >= 0.97) {
    var5 = undefined;
  } else if(var6 >= 0.92) {
    var5 = "_bank";
  } else {
    var5 = "_bank_lg";
  }

  return get_wash_effect(get_vehicle_classname(var0), var4, var5);
}

function get_wash_effect(var0, var1, var2) {
  if(isDefined(var2)) {
    var3 = var1 + var2;

    if(!isDefined(level.vehicle.templates.surface_effects[var0][var3]) && var1 != "default") {
      return get_wash_effect(var0, "default", var2);
    } else {
      return level.vehicle.templates.surface_effects[var0][var3];
    }
  }

  return get_vehicle_effect(var0, var1);
}

function get_vehicle_effect(var0, var1) {
  if(!isDefined(level.vehicle.templates.surface_effects[var0][var1]) && var1 != "default") {
    return get_vehicle_effect(var0, "default");
  } else {
    return level.vehicle.templates.surface_effects[var0][var1];
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
  var0 = self vehicle_isphysveh();
  var1 = 25;

  for(;;) {
    vehicle_navobstacle();

    for(var2 = self.origin; vehicle_is_stopped() && (!var0 || self vehicle_isonground()); var2 = self.origin) {
      wait 0.1;

      if(lengthsquared(self.origin - var2) > var1) {
        vehicle_remove_navobstacle();
        vehicle_navobstacle();
      }
    }

    vehicle_remove_navobstacle();
    vehicle_navrepulsor();

    while(!vehicle_is_stopped() || var0 && !self vehicle_isonground()) {
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
  var0 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    var0 = 1;
  }

  if(var0) {
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

  foreach(var1 in level.vehicle.instances) {
    foreach(var3 in var1) {
      if(istrue(var3.isheli)) {
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

  foreach(var1 in level.vehicle.instances) {
    foreach(var3 in var1) {
      var3 notify("stop_ai_avoidance");
      vehicle_remove_navobstacle(var3);
      vehicle_remove_navrepulsor(var3);
    }
  }
}

function mainturretinit() {
  var0 = get_vehicle_classname();

  if(!isDefined(level.vehicle.templates.mainturret[var0])) {
    return;
  }

  var1 = level.vehicle.templates.mainturret[var0];

  if(!isDefined(var1)) {
    return;
  }

  var2 = "";

  if(isDefined(self.script_turrets)) {
    var2 = self.script_turrets;
  }

  self.mainturret = turretinitshared(var1);

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
  var0 = get_vehicle_classname();

  if(isDefined(self.script_nomg) && self.script_nomg > 0) {
    return;
  }

  if(!isDefined(level.vehicle.templates.mgturret[var0])) {
    return;
  }

  var1 = level.vehicle.templates.mgturret[var0];

  if(!isDefined(var1)) {
    return;
  }

  var2 = "";

  if(isDefined(self.script_turrets)) {
    var2 = self.script_turrets;
  }

  foreach(var4 in var1) {
    if(isDefined(var4.referencename) && !issubstr(var2, var4.referencename)) {
      continue;
    }

    self.mgturret[var5] = turretinitshared(var4);
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

function turretinitshared(var0) {
  var1 = 0;

  if(isDefined(self.script_mg_angle)) {
    var1 = self.script_mg_angle;
  }

  var2 = spawnturret("misc_turret", (0, 0, 0), var0.info);
  var3 = (0, 0, 0);

  if(isDefined(var0.offset_tag)) {
    var3 = (0, 0, 0);
  }

  var4 = self;

  if(isDefined(var0.mainturretchild)) {
    if(isDefined(self.mainturret)) {}

    var4 = self.mainturret;
  }

  var2 linkTo(var4, var0.tag, var3, (0, -1 * var1, 0));
  var2 setModel(var0.model);
  var2.angles = self.angles;
  var2.isvehicleattached = 1;
  var2.ownervehicle = self;
  var2.weaponinfo = var0.info;
  var2.script_team = self.script_team;
  var2 makeusable();
  set_turret_team(var2);
  thread vehicle_turret_difficulty(level, var2);

  if(isDefined(self.script_fireondrones)) {
    var2.script_fireondrones = self.script_fireondrones;
  }

  if(isDefined(var0.deletedelay)) {
    var2.deletedelay = var0.deletedelay;
  }

  if(isDefined(var0.defaultdroppitch)) {
    var2 setdefaultdroppitch(var0.defaultdroppitch);
  }

  if(isDefined(var0.referencename)) {
    var2.referencename = var0.referencename;
  }

  if(isDefined(var0.defaultonmode)) {
    turret_set_default_on_mode(var2, var0.defaultonmode);
  }

  return var2;
}

function vehicle_turret_difficulty(var0, var1) {
  var0.convergencetime = level.mgturretsettings[var1]["convergenceTime"];
  var0.suppressiontime = level.mgturretsettings[var1]["suppressionTime"];
  var0.accuracy = level.mgturretsettings[var1]["accuracy"];
  var0.aispread = level.mgturretsettings[var1]["aiSpread"];
  var0.playerspread = level.mgturretsettings[var1]["playerSpread"];
}

function turret_set_default_on_mode(var0) {
  self.defaultonmode = var0;
}

function set_turret_team(var0) {
  switch (self.script_team) {
    case "friendly":
    case "allies":
      var0 setturretteam("allies");
      break;
    case "enemy":
    case "axis":
      var0 setturretteam("axis");
      break;
    case "team3":
      var0 setturretteam("team3");
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

  var0 = self.model;
  var1 = -1;
  var2 = undefined;

  if(!isDefined(level.vehicle.templates.driveidle[var0])) {
    return;
  }

  self useanimtree(#animtree);

  if(!isDefined(level.vehicle.templates.driveidle_r[var0])) {
    level.vehicle.templates.driveidle_r[var0] = level.vehicle.templates.driveidle[var0];
  }

  self endon("death");
  var3 = level.vehicle.templates.driveidle_normal_speed[var0];
  var4 = 1;

  if(isDefined(level.vehicle.templates.driveidle_animrate) && isDefined(level.vehicle.templates.driveidle_animrate[var0])) {
    var4 = level.vehicle.templates.driveidle_animrate[var0];
  }

  var5 = self.vehiclewheeldirection;
  var6 = level.vehicle.templates.driveidle[var0];

  for(;;) {
    if(!var3) {
      if(isDefined(self.suspend_driveanims)) {
        wait 0.05;
        continue;
      }

      self setanim(level.vehicle.templates.driveidle[var0], 1, 0.2, var4);
      return;
    }

    var7 = self vehicle_getspeed();

    if(var5 != self.vehiclewheeldirection) {
      var8 = 0;

      if(self.vehiclewheeldirection) {
        var6 = level.vehicle.templates.driveidle[var0];
        var8 = 1 - get_normal_anim_time(level.vehicle.templates.driveidle_r[var0]);
        self clearanim(level.vehicle.templates.driveidle_r[var0], 0);
      } else {
        var6 = level.vehicle.templates.driveidle_r[var0];
        var8 = 1 - get_normal_anim_time(level.vehicle.templates.driveidle[var0]);
        self clearanim(level.vehicle.templates.driveidle[var0], 0);
      }

      var2 = 0.01;

      if(var2 >= 1 || var2 == 0) {
        var2 = 0.01;
      }

      var5 = self.vehiclewheeldirection;
    }

    var9 = var7 / var3;

    if(var9 != var1) {
      self setanim(var6, 1, 0.05, var9);
      var1 = var9;
    }

    if(isDefined(var2)) {
      self setanimtime(var6, var2);
      var2 = undefined;
    }

    wait 0.05;
  }
}

function setup_vehicles(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(isspawner(var3)) {
      continue;
    }

    var1 = var3;
  }

  foreach(var6 in var1) {
    thread vehicle_init(var6);
  }
}

function vehicle_setstartinghealth() {
  var0 = get_vehicle_classname();

  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
    return;
  }

  if(level.vehicle.templates.life[var0] == -1) {
    return;
  }

  if(isDefined(level.vehicle.templates.life_range_low[var0]) && isDefined(level.vehicle.templates.life_range_high[var0])) {
    self.health = randomint(level.vehicle.templates.life_range_high[var0] - level.vehicle.templates.life_range_low[var0]) + level.vehicle.templates.life_range_low[var0];
    return;
  }

  self.health = level.vehicle.templates.life[var0];
}

function get_normal_anim_time(var0) {
  var1 = self getanimtime(var0);
  var2 = getanimlength(var0);

  if(var1 == 0) {
    return 0;
  }

  return self getanimtime(var0) / getanimlength(var0);
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

  foreach(var1 in level.vehicle.templates.idle_anim[self.model]) {
    self setanim(var1);
  }
}

function vehicle_rumble() {
  self endon("kill_rumble_forever");
  var0 = get_vehicle_classname();
  var1 = level.vehicle.templates.rumble[var0];

  if(!isDefined(var1)) {
    return;
  }

  var2 = var1.radius * 2;
  var3 = -1 * var1.radius;
  var4 = spawn("trigger_radius", self.origin + (0, 0, var3), 0, var1.radius, var2);
  var4 enablelinkTo();
  var4 linkTo(self);
  self.rumbletrigger = var4;
  self endon("death");

  if(!isDefined(self.rumbleon)) {
    self.rumbleon = 1;
  }

  if(isDefined(var1.scale)) {
    self.rumble_scale = var1.scale;
  } else {
    self.rumble_scale = 0.15;
  }

  if(isDefined(var1.duration)) {
    self.rumble_duration = var1.duration;
  } else {
    self.rumble_duration = 4.5;
  }

  if(isDefined(var1.radius)) {
    self.rumble_radius = var1.radius;
  } else {
    self.rumble_radius = 600;
  }

  if(isDefined(var1.basetime)) {
    self.rumble_basetime = var1.basetime;
  } else {
    self.rumble_basetime = 1;
  }

  if(isDefined(var1.randomaditionaltime)) {
    self.rumble_randomaditionaltime = var1.randomaditionaltime;
  } else {
    self.rumble_randomaditionaltime = 1;
  }

  var4.radius = self.rumble_radius;

  for(;;) {
    var4 waittill("trigger");

    if(vehicle_is_stopped() && !isDefined(self.forcerumble) || !self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(var1.rumble);

    if(isDefined(self.vehicletype)) {
      var5 = self.vehicletype + "_rumble_sfx";

      if(soundexists(var5)) {
        level.player playSound(var5);
      }
    }

    while(level.player istouching(var4) && self.rumbleon && (!vehicle_is_stopped() || isDefined(self.forcerumble))) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime);
    }

    self stoprumble(var1.rumble);
  }
}

function vehicle_setteam() {
  var0 = get_vehicle_classname();

  if(!isDefined(self.script_team) && isDefined(level.vehicle.templates.team[var0])) {
    self.script_team = level.vehicle.templates.team[var0];
    return;
  }
}

function vehicle_handleunloadevent() {
  self endon("death");
  var0 = self.vehicletype;

  if(!scripts\engine\utility::ent_flag_exist("unloaded")) {
    scripts\engine\utility::ent_flag_init("unloaded");
    return;
  }
}

function get_vehiclenode_any_dynamic(var0) {
  var1 = getvehiclenode(var0, "targetname");

  if(!isDefined(var1)) {
    var1 = getEnt(var0, "targetname");
  } else if(ishelicopter_internal()) {}

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStruct(var0, "targetname");
  }

  return var1;
}

function vehicle_damagelogic() {
  self endon("death");
  self.damage_functions = [];
  var0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.bullet_shield[var0]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level.vehicle.templates.bullet_shield[var0];
  }

  if(isDefined(level.vehicle.templates.grenade_shield[var0]) && !isDefined(self.script_grenadeshield)) {
    self.script_grenadeshield = level.vehicle.templates.bullet_shield[var0];
  }

  self.healthbuffer = 20000;
  self.health += self.healthbuffer;
  var1 = self.health;

  while(self.health > 0) {
    self waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);

    if(istrue(self.interaction_is_jugg_maze_button)) {
      return;
    }

    var12 = self.damage_functions;
    var14 = getfirstarraykey(var12);

    if(isDefined(var14)) {
      var13 = var12[var14];
      GscBinSkip1(0x74, var13, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
    }

    var12 = undefined;
    var14 = undefined;

    if(isDefined(var3)) {
      var3 scripts\engine\utility::script_func("register_shot_hit");

      if(scripts\engine\utility::func_ref_exist("vehicle_damage_modifier")) {
        var15 = undefined;

        if(isDefined(level.player_xp)) {
          var15 = [[level.player_xp]](var3, self, var2, var11, var6, undefined, var5, var4, var7, var9, var8, var10);
        }

        if(isDefined(var15)) {
          self.is_area_in_verdansk = var15;
        } else {
          self.is_area_in_verdansk = undefined;
        }

        var16 = scripts\engine\utility::script_func("vehicle_damage_modifier", var15);

        if(isDefined(var16)) {
          var2 = var16;
        }
      }
    }

    if(vehicle_should_regenerate(var3, var6) || _is_godmode()) {
      if(isDefined(self.regenerate) && !istrue(self.regenerate)) {
        var1 = self.health;
      } else {
        self.health = var1;
      }
    } else {
      if(scripts\common\utility::issp() && isDefined(var6)) {
        var17 = 0;

        if(var6 == "MOD_GRENADE_SPLASH" || var6 == "MOD_PROJECTILE_SPLASH") {
          var17 = var2 * 12;
        } else if(var6 == "MOD_GRENADE" || var6 == "MOD_PROJECTILE") {
          var17 = var2 * 5;
        }

        if(var17) {
          self.health -= int(var17);
        }
      }

      var1 = self.health;
    }

    if(!istrue(self.ref_13dd4) && self.health <= self.healthbuffer) {
      self notify("death", var3, var6, var11, var5);
    }
  }
}

function vehicle_isalive(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(var0.healthbuffer) && var0.health < var0.healthbuffer) {
    return false;
  }

  if(var0.health <= 0) {
    return false;
  }

  return true;
}

function grenadeshielded(var0) {
  if(!isDefined(self.script_grenadeshield)) {
    return 0;
  }

  var0 = tolower(var0);

  if(!isDefined(var0) || !issubstr(var0, "grenade")) {
    return 0;
  }

  if(self.script_grenadeshield) {
    return 1;
  }

  return 0;
}

function bulletshielded(var0) {
  if(!isDefined(self.script_bulletshield)) {
    return 0;
  }

  var0 = tolower(var0);

  if(!isDefined(var0) || !issubstr(var0, "bullet") || issubstr(var0, "explosive")) {
    return 0;
  }

  if(self.script_bulletshield) {
    return 1;
  }

  return 0;
}

function explosive_bulletshielded(var0) {
  if(!isDefined(self.script_explosive_bullet_shield)) {
    return 0;
  }

  var0 = tolower(var0);

  if(!isDefined(var0) || !issubstr(var0, "explosive")) {
    return 0;
  }

  if(self.script_explosive_bullet_shield) {
    return 1;
  }

  return 0;
}

function vehicle_should_regenerate(var0, var1) {
  return !isDefined(var0) && self.script_team != "neutral" || attacker_isonmyteam(var0) || attacker_troop_isonmyteam(var0) || is_invulnerable_from_ai(var0) || bulletshielded(var1) || explosive_bulletshielded(var1) || grenadeshielded(var1) || var1 == "MOD_MELEE";
}

function _is_godmode() {
  return istrue(self.godmode);
}

function is_invulnerable_from_ai(var0) {
  if(!isDefined(self.script_ai_invulnerable)) {
    return 0;
  }

  if(isDefined(var0) && isai(var0) && self.script_ai_invulnerable == 1) {
    return 1;
  }

  return 0;
}

function attacker_troop_isonmyteam(var0) {
  if(!istrue(self.ref_13dd4) && isDefined(self.script_team) && self.script_team == "allies" && isDefined(var0) && isPlayer(var0)) {
    return 1;
  }

  if(isai(var0) && scripts\engine\utility::is_equal(var0.team, self.script_team)) {
    return 1;
  }

  return 0;
}

function attacker_isonmyteam(var0) {
  if(isDefined(var0) && isDefined(var0.script_team) && isDefined(self.script_team) && var0.script_team == self.script_team) {
    return true;
  }

  return false;
}

function vehicle_setwheeldirection(var0) {
  self.vehiclewheeldirection = scripts\engine\utility::ter_op(var0 <= 0, 0, 1);
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
  var0 = level.vehicle.templates.engine_fx[self.classname];

  if(!isDefined(var0)) {
    return;
  }

  var1 = 0.25;
  var2 = undefined;
  var3 = undefined;

  for(;;) {
    if(!vehicle_isalive(self)) {
      return;
    }

    var4 = var0.effect;
    var3 = var0.effect_tag;
    var5 = self vehicle_getspeed() / self vehicle_gettopspeedforward();

    if(isDefined(self.enginefx_effort_scale)) {
      var5 *= self.enginefx_effort_scale;
    }

    if(isDefined(var0.max_effort_effect) && var5 >= var0.max_effort_ratio) {
      var4 = var0.max_effort_effect;
    } else if(isDefined(var0.med_effort_effect) && var5 >= var0.med_effort_ratio) {
      var4 = var0.med_effort_effect;
    } else if(isDefined(var0.min_effort_effect) && var5 >= var0.min_effort_ratio) {
      var4 = var0.min_effort_effect;
    }

    if(!isDefined(var2) || var2 != var4) {
      if(isDefined(var2)) {
        stopFXOnTag(var2, self, var3);
        waitframe();

        if(!vehicle_isalive(self)) {
          return;
        }
      }

      playFXOnTag(var4, self, var3);
      var2 = var4;
    }

    wait var1;
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

  foreach(var1 in self.mgturret) {
    _turretoffshared(var1);
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

  foreach(var1 in self.mgturret) {
    var1 show();
    _turretonshared(var1);
  }
}

function _turretoffshared(var0) {
  if(isDefined(var0.script_fireondrones)) {
    var0.script_fireondrones = 0;
  }

  var0 setmode("manual");
}

function _turretonshared(var0) {
  if(isDefined(var0.script_fireondrones)) {
    var0.script_fireondrones = 1;
  }

  if(isDefined(var0.defaultonmode)) {
    if(var0.defaultonmode != "sentry") {
      var0 setmode(var0.defaultonmode);
    }
  } else {
    var0 setmode("auto_nonai");
  }

  set_turret_team(var0);
}

function get_vehicle_riders_spawners() {
  var0 = [];

  if(isDefined(self.target)) {
    var1 = scripts\engine\utility::noself_func_return("getspawnerarray", self.target);

    if(!isDefined(var1)) {
      var1 = scripts\engine\utility::getStructArray(self.target, "targetname");
    }

    if(!isDefined(var1)) {
      var1 = [];
    }

    foreach(var3 in var1) {
      if(isstruct(var3)) {
        if(!isDefined(var3.script_demeanor)) {
          continue;
        }
      } else {
        if(!issubstr(var3.code_classname, "actor") && !issubstr(var3.code_classname, "vehicle")) {
          continue;
        }

        if(issubstr(var3.code_classname, "actor")) {
          if(!isspawner(var3)) {
            continue;
          } else if(issubstr(var3.code_classname, "vehicle")) {
            if(!(var3.spawnflags & 2)) {
              continue;
            }
          }
        }
      }

      if(isDefined(var3.dont_auto_ride)) {
        continue;
      }

      var0 = var3;
    }
  }

  return var0;
}

function vehicle_spawn_internal(var0) {
  if(isDefined(var0.script_delay_spawn)) {
    var0 endon("death");
    wait var0.script_delay_spawn;
  }

  if(!scripts\common\utility::issp()) {
    var1 = vehicle_spawn_mp_internal(var0);
  } else {
    var1 = var1 vehicle_dospawn();
  }

  if(!isDefined(var1.spawned_count)) {
    var1.spawned_count = 0;
  }

  var1.spawned_count++;
  var1.vehicle_spawned_thisframe = var1;
  var1.last_spawned_vehicle = var1;
  thread remove_vehicle_spawned_thisframe();
  var1.vehicle_spawner = var1;
  thread vehicle_init(var1);
  var1 notify("spawned", var1);
  return var1;
}

function vehicle_spawn_mp_internal(var0) {
  var1 = "temp_vehicle_targetname";

  if(isDefined(var0.targetname)) {
    var1 = var0.targetname;
  }

  if(!isDefined(var0.classname_mp)) {
    var2 = var0.classname;
  } else {
    var2 = var1.classname_mp;
  }

  var3 = spawnVehicle(level.vehicle.templates.model[var2], var2, var1.vehicletype, var1.origin, var1.angles);
  var3.vehicletype = var1.vehicletype;
  var3.classname_mp = var2;

  if(isDefined(var1.target)) {
    var3.target = var1.target;
  }

  return var3;
}

function setvehgoalpos_wrap(var0, var1) {
  return _setvehgoalpos_wrap(var0, var1);
}

function vehicle_liftoffvehicle(var0) {
  if(!isDefined(var0)) {
    var0 = 512;
  }

  var1 = self.origin + (0, 0, var0);
  self setneargoalnotifydist(10);
  setvehgoalpos_wrap(var1, 1);
  self waittill("goal");
}

function vehicle_shouldplaydeathanimation(var0) {
  if(!vehicle_hasdeathanimations(var0)) {
    return false;
  }

  if(istrue(self.vehicle_skipdeathanimation)) {
    return false;
  }

  return true;
}

function vehicle_hasdeathanimations(var0) {
  return isDefined(level.vehicle.templates.deathanimations[get_vehicle_classname(var0)]);
}

function vehicle_getdeathanimation(var0, var1) {
  var2 = level.vehicle.templates.deathanimations[get_vehicle_classname(var0)];

  if(isDefined(var1)) {
    var3 = var0 getpointinbounds(0.5, 0.5, 0.5);
    var4 = var1 - var3;
    var5 = [];
    GscBinSkip0(0x2e, "forward", anglesToForward(var0.angles));
  }

  return scripts\engine\utility::random(var5);
}

function vehicle_playdeathanimation(var0) {
  self vehicle_turnengineoff();
  scripts\engine\utility::self_func("vehicle_orientto", self.origin, self.angles, 0, 0);
  self useanimtree(#animtree);
  self animScripted("vehicle_playDeathAnimation", self.origin, self.angles, var0);
  self setneargoalnotifydist(30);

  if(scripts\common\vehicle::ishelicopter()) {
    self setvehgoalpos(self.origin, 1);
    self setgoalyaw(self.angles[1]);
    return;
  }
}

function vehicle_setcrashing(var0) {
  self.vehiclecrashing = var0;
}

function vehicle_docrash(var0, var1) {
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
    thread vehicle_helicoptercrash(var0, var1);
    self waittill("vehicle_crashDone");
  }

  vehicle_setcrashing(0);
}

function vehicle_helicoptercrash(var0, var1) {
  if(isDefined(var0) && isPlayer(var0)) {
    self.original_attacker = var0;
  }

  if(!isDefined(self)) {
    return;
  }

  detach_getoutrigs();
  thread helicopter_crash_move(var0, var1);
}

function helicopter_crash_move(var0, var1) {
  self endon("in_air_explosion");
  jumpiffalse(isDefined(self.perferred_crash_location)) LOC_00000020;
  var2 = self.perferred_crash_location;
  goto LOC_00000037;
}

function helicopter_crash_path(var0) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(var0.target)) {
    var0 = scripts\engine\utility::getStruct(var0.target, "targetname");
    var1 = 56;

    if(isDefined(var0.radius)) {
      var1 = var0.radius;
    }

    self setneargoalnotifydist(var1);
    self setvehgoalpos(var0.origin, 0);
    scripts\engine\utility::ref_143a5("goal", "near_goal");
  }
}

function helicopter_crash_flavor(var0, var1) {
  self endon("vehicle_crashDone");
  self clearlookatent();

  if(soundexists("hind_helicopter_dying_loop")) {
    self playLoopSound("hind_helicopter_dying_loop");
  }

  var2 = 0;

  if(isDefined(self.preferred_crash_style)) {
    var2 = self.preferred_crash_style;

    if(self.preferred_crash_style < 0) {
      var3 = [1, 2, 2];
      var4 = 5;
      var5 = randomint(var4);
      var6 = 0;

      foreach(var8 in var3) {
        var6 += var8;

        if(var5 < var6) {
          var2 = var9;
          break;
        }
      }
    }
  }

  switch (var2) {
    case 1:
      thread helicopter_crash_zigzag();
      break;
    case 2:
      thread helicopter_crash_directed(var0, var1);
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
  var0 = get_vehicle_classname();

  if(isDefined(level.vehicle.templates.vehicle_rocket_death_fx[var0])) {
    var1 = level.vehicle.templates.vehicle_rocket_death_fx[var0];
    var2 = var1[1];

    if(isDefined(var2.waitdelay)) {
      wait var2.waitdelay;
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

function helicopter_crash_directed(var0, var1) {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var2 = 90 * randomintrange(-2, 3);

  for(;;) {
    var3 = var0 - self.origin;
    var4 = vectortoyaw(var3);
    var4 += var2;
    self settargetyaw(var4);
    wait 0.1;
  }
}

function helicopter_crash_zigzag() {
  self endon("vehicle_crashDone");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  var0 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    var1 = randomintrange(20, 120);

    if(var0) {
      self settargetyaw(self.angles[1] + var1);
    } else {
      self settargetyaw(self.angles[1] - var1);
    }

    var0 = 1 - var0;
    var2 = randomfloatrange(0.5, 1);
    wait var2;
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

    var0 = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + var0);
    wait 0.5;
  }
}

function get_unused_crash_locations() {
  var0 = [];
  level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_removeundefined(level.vehicle.helicopter_crash_locations);

  foreach(var2 in level.vehicle.helicopter_crash_locations) {
    if(isDefined(var2.claimed)) {
      continue;
    }

    var0 = var2;
  }

  return var0;
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

  var0 = getarraykeys(self.fastroperig);

  for(var1 = 0; var1 < var0.size; var1++) {
    if(isDefined(self.fastroperig[var0[var1]])) {
      self.fastroperig[var0[var1]] unlink();
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