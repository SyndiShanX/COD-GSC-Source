/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_paths.gsc
***********************************************/

function gopath(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("death");

  if(isDefined(var_0.hasstarted)) {
    return;
  } else {
    var_0.hasstarted = 1;
  }

  var_0 scripts\engine\utility::script_delay();
  var_0 notify("start_vehiclepath");

  if(var_0 scripts\common\vehicle_code::ishelicopter_internal()) {
    var_0 notify("start_dynamicpath");
    return;
  }

  var_0 startpath();
}

function _vehicle_paths(var_0, var_1, var_2) {
  if(scripts\common\vehicle_code::ishelicopter_internal()) {
    vehicle_paths_helicopter(var_0, var_1, var_2);
    return;
  }

  vehicle_paths_non_heli(var_0);
}

function trigger_process_node(var_0) {
  if(isDefined(var_0.script_flag_set)) {
    scripts\engine\utility::flag_set(var_0.script_flag_set);
  }

  if(isDefined(var_0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);
  }

  if(isDefined(var_0.script_prefab_exploder)) {
    var_0.script_exploder = var_0.script_prefab_exploder;
    var_0.script_prefab_exploder = undefined;
  }

  if(isDefined(var_0.script_exploder)) {
    var_1 = var_0.script_exploder_delay;

    if(isDefined(var_1)) {
      level scripts\engine\utility::delaythread(var_1, &scripts\engine\utility::exploder, var_0.script_exploder);
    } else {
      level scripts\engine\utility::exploder(var_0.script_exploder);
    }
  }

  if(isDefined(var_0.script_flag_set)) {
    scripts\engine\utility::flag_set(var_0.script_flag_set);
  }

  if(isDefined(var_0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);
  }

  if(isDefined(var_0.script_ent_flag_clear)) {
    scripts\engine\utility::ent_flag_clear(var_0.script_ent_flag_clear);
  }

  if(isDefined(var_0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "deleteme") {
      scripts\common\vehicle_code::vehicle_deathcleanup();
      delete_riders();
      self delete();
      return;
    } else if(var_0.script_noteworthy == "engineoff") {
      self vehicle_turnengineoff();
    } else {
      self notify(var_0.script_noteworthy);
      self notify("noteworthy", var_0.script_noteworthy);
    }
  }

  if(isDefined(var_0.script_badplace)) {
    self.script_badplace = var_0.script_badplace;
  }

  if(isDefined(var_0.script_turretmg)) {
    if(var_0.script_turretmg) {
      scripts\common\vehicle_code::_mgon();
    } else {
      scripts\common\vehicle_code::_mgoff();
    }
  }

  if(isDefined(var_0.script_turretmain)) {
    if(var_0.script_turretmain) {
      scripts\common\vehicle_code::_mainturreton();
      return;
    }

    scripts\common\vehicle_code::_mainturretoff();
    return;
  }
}

function delete_riders() {
  if(isDefined(self.riders)) {
    foreach(var_1 in self.riders) {
      if(isDefined(var_1.magic_bullet_shield)) {
        var_1 scripts\common\ai::stop_magic_bullet_shield();
      }

      if(!scripts\common\utility::issp() && isai(var_1)) {
        var_1 kill();
        continue;
      }

      var_1 delete();
    }

    return;
  }
}

function islastnode(var_0) {
  if(!isDefined(var_0.target)) {
    return true;
  }

  if(!isDefined(getvehiclenode(var_0.target, "targetname")) && !isDefined(scripts\common\vehicle_code::get_vehiclenode_any_dynamic(var_0.target))) {
    return true;
  }

  return false;
}

function vehicle_should_unload(var_0, var_1) {
  if(isDefined(var_1.script_unload)) {
    return true;
  }

  if(var_0 != &node_wait) {
    return false;
  }

  if(!islastnode(var_1)) {
    return false;
  }

  if(istrue(self.dontunloadonend)) {
    return false;
  }

  if(self.vehicletype == "empty" || self.vehicletype == "empty_heli") {
    return false;
  }

  return !(isDefined(self.script_vehicle_selfremove) && self.script_vehicle_selfremove);
}

function overshoot_next_node(var_0) {}

function vehicle_resumepathvehicle() {
  if(!scripts\common\vehicle_code::ishelicopter_internal()) {
    self resumespeed(35);
    return;
  }

  var_0 = undefined;

  if(isDefined(self.currentnode.target)) {
    var_0 = scripts\common\vehicle_code::get_vehiclenode_any_dynamic(self.currentnode.target);
  }

  if(!isDefined(var_0)) {
    return;
  }

  _vehicle_paths(var_0);
}

function get_path_getfunc(var_0) {
  var_1 = &scripts\common\vehicle_code::get_from_vehicle_node;

  if(scripts\common\vehicle_code::ishelicopter_internal() && isDefined(var_0.target)) {
    if(isDefined(scripts\common\vehicle_code::get_from_entity(var_0.target))) {
      var_1 = &scripts\common\vehicle_code::get_from_entity;
    }

    if(isDefined(scripts\common\vehicle_code::get_from_spawnStruct(var_0.target))) {
      var_1 = &scripts\common\vehicle_code::get_from_spawnstruct;
    }
  } else if(!scripts\common\utility::issp() && isDefined(var_0.target)) {
    if(isDefined(scripts\common\vehicle_code::get_from_spawnStruct(var_0.target))) {
      var_1 = &scripts\common\vehicle_code::get_from_spawnstruct;
    }
  }

  return var_1;
}

function struct_wait(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  wait 0.05;

  if(isDefined(var_1.speed) && var_1.speed >= 0) {
    self vehicledriveto(var_0.origin, int(var_1.speed));

    while(distancesquared(self.origin, var_0.origin) > var_2) {
      wait 0.1;

      if(scripts\common\utility::iscp()) {
        self vehicle_setspeedimmediate(var_1.speed, 15, 15);
      }
    }

    return;
  }

  if(isDefined(var_1.speed) && var_1.speed < 0) {
    self vehicle_setspeedimmediate(0, 15, 15);
    return;
  }
}

function node_wait(var_0, var_1, var_2) {
  if(isDefined(self.unique_id)) {
    var_3 = "node_flag_triggered" + self.unique_id;
  } else {
    var_3 = "node_flag_triggered";
  }

  nodes_flag_triggered(var_3, var_1, var_3);

  if(self.attachedpath == var_1) {
    self notify("node_wait_terminated");
    waittillframeend();
    return;
  }

  var_1 scripts\engine\utility::ent_flag_wait_vehicle_node(var_3);
  var_1 scripts\engine\utility::ent_flag_clear(var_3, 1);
  var_1 notify("processed_node" + var_3);
}

function nodes_flag_triggered(var_0, var_1, var_2) {
  var_3 = 0;

  while(isDefined(var_1) && var_3 < 3) {
    var_3++;
    thread node_flag_triggered(var_0, var_1);

    if(!isDefined(var_1.target)) {
      return;
    }

    var_1 = [[var_2]](var_1.target);
  }
}

function node_flag_triggered(var_0, var_1) {
  if(var_1 scripts\engine\utility::ent_flag_exist(var_0)) {
    return;
  }

  var_1 scripts\engine\utility::ent_flag_init(var_0);
  thread node_flag_triggered_cleanup(var_1, var_0);
  var_1 endon("processed_node" + var_0);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  var_1 waittillmatch("trigger", self);
  var_1 scripts\engine\utility::ent_flag_set(var_0);
}

function node_flag_triggered_cleanup(var_0, var_1) {
  var_0 endon("processed_node" + var_1);
  scripts\engine\utility::ref_143a6("death", "newpath", "node_wait_terminated");
  var_0 scripts\engine\utility::ent_flag_clear(var_1, 1);
}

function vehicle_paths_non_heli(var_0) {
  self notify("newpath");

  if(isDefined(var_0)) {
    self.attachedpath = var_0;
  }

  var_1 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_1)) {
    return;
  }

  self endon("newpath");
  self endon("death");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = get_path_getfunc(var_1);
  var_6 = 40000;

  while(isDefined(var_4)) {
    if(!isstruct(var_4)) {
      node_wait(var_4, var_3, var_5);
    } else {
      struct_wait(var_4, var_3, var_6);
    }

    if(!isDefined(self)) {
      return;
    }

    trigger_process_node(var_4);
    self.currentnode = var_4;

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_4.script_team)) {
      self.script_team = var_4.script_team;
    }

    if(isDefined(var_4.script_turningdir)) {
      self notify("turning", var_4.script_turningdir);
    }

    if(isDefined(var_4.script_deathroll)) {
      if(var_4.script_deathroll == 0) {
        thread scripts\common\vehicle_code::deathrolloff();
      } else {
        thread scripts\common\vehicle_code::deathrollon();
      }
    }

    if(isDefined(var_4.script_wheeldirection)) {
      scripts\common\vehicle_code::vehicle_setwheeldirection(var_4.script_wheeldirection);
    }

    if(vehicle_should_unload(&node_wait, var_4)) {
      thread unload_node(var_4);
    }

    if(isDefined(var_4.script_transmission)) {
      self.veh_transmission = var_4.script_transmission;

      if(self.veh_transmission == "forward") {
        scripts\common\vehicle_code::vehicle_setwheeldirection(1);
      } else {
        scripts\common\vehicle_code::vehicle_setwheeldirection(0);
      }
    }

    if(isDefined(var_4.script_brake)) {
      self.veh_brake = var_4.script_brake;
    }

    if(isDefined(var_4.script_pathtype)) {
      self.veh_pathtype = var_4.script_pathtype;
    }

    if(isDefined(var_4.script_speed)) {
      var_7 = undefined;

      if(isDefined(var_4.script_accel)) {
        var_7 = var_4.script_accel;
      }

      var_8 = undefined;

      if(isDefined(var_4.script_decel)) {
        var_8 = var_4.script_decel;
      }

      self vehicle_setspeed(var_4.script_speed, var_7, var_8);
    }

    if(isDefined(var_4.script_ent_flag_wait) && !scripts\engine\utility::ent_flag(var_4.script_ent_flag_wait)) {
      if(isDefined(var_4.script_decel)) {
        var_8 = var_4.script_decel;
      } else if(isDefined(var_5.target)) {
        var_9 = [[var_6]](var_5.target);
        var_10 = distance(var_5.origin, var_9.origin) * 0.0568182;
        var_11 = self vehicle_getspeed();
        var_8 = squared(var_11) / 2 * var_10;
      } else {
        var_8 = 20;
      }

      self vehicle_setspeed(0, var_8, var_8);
      GscBinSkip4(0x35);
    }

    if(isDefined(var_8.script_delay)) {
      var_8 = 20;

      if(isDefined(var_8.script_decel)) {
        var_8 = var_8.script_decel;
      }

      self vehicle_setspeed(0, var_8);
      GscBinSkip4(0x35);
    }

    if(isDefined(var_8.script_flag_wait)) {
      var_12 = 0;

      if(!scripts\engine\utility::flag(var_8.script_flag_wait) || isDefined(var_8.script_delay_post)) {
        var_12 = 1;
        var_7 = 5;
        var_8 = 20;

        if(isDefined(var_8.script_accel)) {
          var_7 = var_8.script_accel;
        }

        if(isDefined(var_8.script_decel)) {
          var_8 = var_8.script_decel;
        }

        _vehicle_stop_named("script_flag_wait_" + var_8.script_flag_wait, var_7, var_8);
        GscBinSkip4(0x35);
      }

      scripts\engine\utility::flag_wait(var_8.script_flag_wait);

      if(!isDefined(self)) {
        return;
      }

      if(isDefined(var_8.script_delay_post)) {
        wait var_8.script_delay_post;

        if(!isDefined(self)) {
          return;
        }
      }

      var_7 = 10;

      if(isDefined(var_8.script_accel)) {
        var_7 = var_8.script_accel;
      }

      if(var_8) {
        self notify("resumed_path");
        _vehicle_resume_named("script_flag_wait_" + var_8.script_flag_wait);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(var_8.script_vehicle_lights_off)) {
      thread scripts\common\vehicle_lights::lights_off(var_8.script_vehicle_lights_off);
    }

    if(isDefined(var_8.script_vehicle_lights_on)) {
      thread scripts\common\vehicle_lights::lights_on(var_8.script_vehicle_lights_on);
    }

    if(isDefined(var_8.script_forcecolor)) {
      thread scripts\engine\utility::script_func("forcecolor_riders", var_8.script_forcecolor);
    }

    var_8 = var_8;

    if(!isDefined(var_8.target)) {
      break;
    }

    var_8 = [[var_12]](var_8.target);

    if(!isDefined(var_8)) {
      var_8 = var_8;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    scripts\common\vehicle_code::vehicle_deathcleanup();
    delete_riders();
    self notify("delete");
    self delete();
    return;
  }
}

function vehicle_notifyonstop() {
  self endon("resumed_path");

  while(scripts\common\vehicle_code::vehicle_is_stopped()) {
    waitframe();
  }

  self setwaitspeed(0);
  self waittill("reached_wait_speed");
  self notify("stopped_path");
}

function vehicle_waittill_stopped() {
  while(!scripts\common\vehicle_code::vehicle_is_stopped()) {
    waitframe();
  }
}

function add_z(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

function vehicle_paths_helicopter(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self.attachedpath = var_0;
  }

  var_3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_3;

  if(var_1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = add_z(self.origin, var_2);
    heli_wait_node(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = get_path_getfunc(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7.script_linkto)) {
      scripts\common\vehicle_code::set_lookat_from_dest(var_7);
    }

    if(isDefined(var_7.script_land)) {
      var_9 = 0;

      if(isDefined(var_7.target)) {
        var_9 = isDefined([[var_8]](var_7.target));
      }

      thread scripts\common\vehicle_code::vehicle_landanims(var_7.script_unload, var_9);
    }

    heli_wait_node(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = var_7;
    var_7 notify("trigger", self);

    if(isDefined(var_7.script_helimove)) {
      self setyawspeedbyname(var_7.script_helimove);

      if(var_7.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    trigger_process_node(var_7);

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_7.script_team)) {
      self.script_team = var_7.script_team;
    }

    if(vehicle_should_unload(&heli_wait_node, var_7)) {
      thread unload_node(var_7);
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(var_7.script_pathtype)) {
        self.veh_pathtype = var_7.script_pathtype;
      }
    }

    if(isDefined(var_7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var_7.script_flag_wait);

      if(isDefined(var_7.script_delay_post)) {
        wait var_7.script_delay_post;
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(var_7.script_vehicle_lights_off)) {
      thread scripts\common\vehicle_lights::lights_off(var_7.script_vehicle_lights_off);
    }

    if(isDefined(var_7.script_vehicle_lights_on)) {
      thread scripts\common\vehicle_lights::lights_on(var_7.script_vehicle_lights_on);
    }

    if(isDefined(var_7.script_forcecolor)) {
      thread scripts\engine\utility::script_func("forcecolor_riders", var_7.script_forcecolor);
    }

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    delete_riders();
    self delete();
    return;
  }
}

function heli_wait_node(var_0, var_1, var_2) {
  self endon("newpath");

  if(isDefined(var_0.script_unload) || isDefined(var_0.script_land)) {
    var_3 = 0;

    if(isDefined(var_0.script_land)) {
      scripts\engine\utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset)) {
        var_3 = self.unload_land_offset;
      }
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset)) {
      var_3 = self.unload_hover_offset;
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self.unload_hover_offset_max) {
        var_3 = self.unload_hover_offset_max;
      } else if(isDefined(self.unload_hover_land_height) && var_3 < self.unload_hover_land_height) {
        var_3 = self.unload_hover_land_height;
      }
    }

    var_0.radius = 2;

    if(isDefined(var_0.ground_pos)) {
      var_0.origin = var_0.ground_pos + (0, 0, var_3);
    } else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000) {
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1.script_airresistance;
    var_7 = var_1.speed;
    var_8 = var_1.script_accel;
    var_9 = var_1.script_decel;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_7.script_stopnode) && var_7.script_stopnode;
  var_11 = isDefined(var_7.script_unload);
  var_12 = isDefined(var_7.script_flag_wait) && !scripts\engine\utility::flag(var_7.script_flag_wait);
  var_13 = !isDefined(var_7.target);
  var_14 = isDefined(var_7.script_delay);

  if(isDefined(var_7.angles)) {
    var_15 = var_7.angles[1];
  } else {
    var_15 = 0;
  }

  if(self.health <= 0) {
    return;
  }

  var_16 = var_8.origin;

  if(isDefined(var_6)) {
    var_16 = add_z(var_16, var_6);
  }

  if(isDefined(self.heliheightoverride)) {
    var_16 = (var_16[0], var_16[1], self.heliheightoverride);
  }

  self vehicle_helisetai(var_16, var_8, var_9, var_10, var_8.script_goalyaw, var_8.script_anglevehicle, var_15, var_7, var_15, var_11, var_12, var_13, var_14);

  if(isDefined(var_8.radius)) {
    self setneargoalnotifydist(var_8.radius);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  trigger_process_node(var_8);

  if(isDefined(var_8.script_firelink)) {
    if(isDefined(level.helicopter_firelinkfunk)) {}

    GscBinSkip1(0x74, level.helicopter_firelinkfunk, var_8);
  }

  var_8 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    scripts\engine\utility::deletestruct_ref(var_8);
  }

  self notify("continuepath");
}

function quickdropall() {
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  if(var_0.size == 1) {
    return var_0[0];
  }

  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.script_demeanor)) {
      var_1 = var_3;
    }
  }

  return var_1[0];
}

function getonpath(var_0) {
  var_1 = undefined;
  var_2 = self.vehicletype;

  if(isDefined(self.vehicle_spawner)) {
    if(istrue(self.vehicle_spawner.dontgetonpath)) {
      return;
    }
  }

  if(isDefined(self.target)) {
    var_1 = getvehiclenode(self.target, "targetname");

    if(!isDefined(var_1)) {
      var_3 = getEntArray(self.target, "targetname");

      foreach(var_5 in var_3) {
        if(var_5.code_classname == "script_origin") {
          var_1 = var_5;
          break;
        }
      }
    }

    if(!isDefined(var_1)) {
      if(scripts\common\utility::iscp()) {
        var_1 = quickdropall();
      } else {
        var_1 = scripts\engine\utility::getStruct(self.target, "targetname");
      }
    }
  }

  if(!isDefined(var_1)) {
    if(scripts\common\vehicle_code::ishelicopter_internal()) {
      self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self.attachedpath = var_1;

  if(!scripts\common\vehicle_code::ishelicopter_internal() && !isstruct(var_1)) {
    self.origin = var_1.origin;

    if(!isDefined(var_0)) {
      self attachpath(var_1);
    }
  } else if(isDefined(self.speed)) {
    self vehicle_setspeedimmediate(self.speed, 20);
  } else if(isDefined(var_1.speed)) {
    var_7 = 20;
    var_8 = 10;

    if(isDefined(var_1.script_accel)) {
      var_7 = var_1.script_accel;
    }

    if(isDefined(var_1.script_decel)) {
      var_7 = var_1.script_decel;
    }

    var_9 = float(var_1.speed);
    self vehicle_setspeedimmediate(var_9, var_7, var_8);
  } else {
    self vehicle_setspeed(60, 20, 10);
  }

  thread _vehicle_paths(undefined, scripts\common\vehicle_code::ishelicopter_internal());
}

function _vehicle_resume_named(var_0) {
  var_1 = self.vehicle_stop_named[var_0];
  self.vehicle_stop_named[var_0] = undefined;

  if(self.vehicle_stop_named.size) {
    return;
  }

  self resumespeed(var_1);
}

function _vehicle_stop_named(var_0, var_1, var_2) {
  if(!isDefined(self.vehicle_stop_named)) {
    self.vehicle_stop_named = [];
  }

  self vehicle_setspeed(0, var_1, var_2);
  self.vehicle_stop_named[var_0] = var_1;
}

function unload_node(var_0) {
  self endon("death");

  if(isDefined(self.ent_flag["prep_unload"]) && scripts\engine\utility::ent_flag("prep_unload")) {
    return;
  }

  if(!isDefined(var_0.script_flag_wait) && !isDefined(var_0.script_delay)) {
    self notify("newpath");
  }

  var_1 = getnode(var_0.targetname, "target");

  if(isDefined(var_1) && self.riders.size) {
    foreach(var_3 in self.riders) {
      if(isai(var_3)) {
        var_3 thread scripts\engine\utility::script_func("go_to_node", var_1);
      }
    }
  }

  if(scripts\common\vehicle_code::ishelicopter_internal()) {
    self sethoverparams(0, 0, 0);
    scripts\common\vehicle_code::waittill_stable(var_0);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "wait_for_flag") {
      scripts\engine\utility::flag_wait(var_0.script_flag);
    }
  }

  if(isDefined(var_0.script_unload)) {
    if(var_0.script_unload == "1") {
      var_0.script_unload = "default";
    }
  }

  scripts\common\vehicle_code::_vehicle_unload(var_0.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(var_0.script_unload)) {
    self waittill("unloaded");
  }

  if(isDefined(var_0.script_flag_wait) || isDefined(var_0.script_delay)) {
    return;
  }

  if(isDefined(self)) {
    thread vehicle_resumepathvehicle();
    return;
  }
}