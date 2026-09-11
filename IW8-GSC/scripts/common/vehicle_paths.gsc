/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_paths.gsc
***********************************************/

function gopath(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  var0 endon("death");

  if(isDefined(var0.hasstarted)) {
    return;
  } else {
    var0.hasstarted = 1;
  }

  var0 scripts\engine\utility::script_delay();
  var0 notify("start_vehiclepath");

  if(var0 scripts\common\vehicle_code::ishelicopter_internal()) {
    var0 notify("start_dynamicpath");
    return;
  }

  var0 startpath();
}

function _vehicle_paths(var0, var1, var2) {
  if(scripts\common\vehicle_code::ishelicopter_internal()) {
    vehicle_paths_helicopter(var0, var1, var2);
    return;
  }

  vehicle_paths_non_heli(var0);
}

function trigger_process_node(var0) {
  if(isDefined(var0.script_flag_set)) {
    scripts\engine\utility::flag_set(var0.script_flag_set);
  }

  if(isDefined(var0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var0.script_flag_clear);
  }

  if(isDefined(var0.script_prefab_exploder)) {
    var0.script_exploder = var0.script_prefab_exploder;
    var0.script_prefab_exploder = undefined;
  }

  if(isDefined(var0.script_exploder)) {
    var1 = var0.script_exploder_delay;

    if(isDefined(var1)) {
      level scripts\engine\utility::delaythread(var1, &scripts\engine\utility::exploder, var0.script_exploder);
    } else {
      level scripts\engine\utility::exploder(var0.script_exploder);
    }
  }

  if(isDefined(var0.script_flag_set)) {
    scripts\engine\utility::flag_set(var0.script_flag_set);
  }

  if(isDefined(var0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var0.script_ent_flag_set);
  }

  if(isDefined(var0.script_ent_flag_clear)) {
    scripts\engine\utility::ent_flag_clear(var0.script_ent_flag_clear);
  }

  if(isDefined(var0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var0.script_flag_clear);
  }

  if(isDefined(var0.script_noteworthy)) {
    if(var0.script_noteworthy == "deleteme") {
      scripts\common\vehicle_code::vehicle_deathcleanup();
      delete_riders();
      self delete();
      return;
    } else if(var0.script_noteworthy == "engineoff") {
      self vehicle_turnengineoff();
    } else {
      self notify(var0.script_noteworthy);
      self notify("noteworthy", var0.script_noteworthy);
    }
  }

  if(isDefined(var0.script_badplace)) {
    self.script_badplace = var0.script_badplace;
  }

  if(isDefined(var0.script_turretmg)) {
    if(var0.script_turretmg) {
      scripts\common\vehicle_code::_mgon();
    } else {
      scripts\common\vehicle_code::_mgoff();
    }
  }

  if(isDefined(var0.script_turretmain)) {
    if(var0.script_turretmain) {
      scripts\common\vehicle_code::_mainturreton();
      return;
    }

    scripts\common\vehicle_code::_mainturretoff();
    return;
  }
}

function delete_riders() {
  if(isDefined(self.riders)) {
    foreach(var1 in self.riders) {
      if(isDefined(var1.magic_bullet_shield)) {
        var1 scripts\common\ai::stop_magic_bullet_shield();
      }

      if(!scripts\common\utility::issp() && isai(var1)) {
        var1 kill();
        continue;
      }

      var1 delete();
    }

    return;
  }
}

function islastnode(var0) {
  if(!isDefined(var0.target)) {
    return true;
  }

  if(!isDefined(getvehiclenode(var0.target, "targetname")) && !isDefined(scripts\common\vehicle_code::get_vehiclenode_any_dynamic(var0.target))) {
    return true;
  }

  return false;
}

function vehicle_should_unload(var0, var1) {
  if(isDefined(var1.script_unload)) {
    return true;
  }

  if(var0 != &node_wait) {
    return false;
  }

  if(!islastnode(var1)) {
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

function overshoot_next_node(var0) {}

function vehicle_resumepathvehicle() {
  if(!scripts\common\vehicle_code::ishelicopter_internal()) {
    self resumespeed(35);
    return;
  }

  var0 = undefined;

  if(isDefined(self.currentnode.target)) {
    var0 = scripts\common\vehicle_code::get_vehiclenode_any_dynamic(self.currentnode.target);
  }

  if(!isDefined(var0)) {
    return;
  }

  _vehicle_paths(var0);
}

function get_path_getfunc(var0) {
  var1 = &scripts\common\vehicle_code::get_from_vehicle_node;

  if(scripts\common\vehicle_code::ishelicopter_internal() && isDefined(var0.target)) {
    if(isDefined(scripts\common\vehicle_code::get_from_entity(var0.target))) {
      var1 = &scripts\common\vehicle_code::get_from_entity;
    }

    if(isDefined(scripts\common\vehicle_code::get_from_spawnStruct(var0.target))) {
      var1 = &scripts\common\vehicle_code::get_from_spawnstruct;
    }
  } else if(!scripts\common\utility::issp() && isDefined(var0.target)) {
    if(isDefined(scripts\common\vehicle_code::get_from_spawnStruct(var0.target))) {
      var1 = &scripts\common\vehicle_code::get_from_spawnstruct;
    }
  }

  return var1;
}

function struct_wait(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = var0;
  }

  wait 0.05;

  if(isDefined(var1.speed) && var1.speed >= 0) {
    self vehicledriveto(var0.origin, int(var1.speed));

    while(distancesquared(self.origin, var0.origin) > var2) {
      wait 0.1;

      if(scripts\common\utility::iscp()) {
        self vehicle_setspeedimmediate(var1.speed, 15, 15);
      }
    }

    return;
  }

  if(isDefined(var1.speed) && var1.speed < 0) {
    self vehicle_setspeedimmediate(0, 15, 15);
    return;
  }
}

function node_wait(var0, var1, var2) {
  if(isDefined(self.unique_id)) {
    var3 = "node_flag_triggered" + self.unique_id;
  } else {
    var3 = "node_flag_triggered";
  }

  nodes_flag_triggered(var3, var1, var3);

  if(self.attachedpath == var1) {
    self notify("node_wait_terminated");
    waittillframeend();
    return;
  }

  var1 scripts\engine\utility::ent_flag_wait_vehicle_node(var3);
  var1 scripts\engine\utility::ent_flag_clear(var3, 1);
  var1 notify("processed_node" + var3);
}

function nodes_flag_triggered(var0, var1, var2) {
  var3 = 0;

  while(isDefined(var1) && var3 < 3) {
    var3++;
    thread node_flag_triggered(var0, var1);

    if(!isDefined(var1.target)) {
      return;
    }

    var1 = [[var2]](var1.target);
  }
}

function node_flag_triggered(var0, var1) {
  if(var1 scripts\engine\utility::ent_flag_exist(var0)) {
    return;
  }

  var1 scripts\engine\utility::ent_flag_init(var0);
  thread node_flag_triggered_cleanup(var1, var0);
  var1 endon("processed_node" + var0);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  var1 waittillmatch("trigger", self);
  var1 scripts\engine\utility::ent_flag_set(var0);
}

function node_flag_triggered_cleanup(var0, var1) {
  var0 endon("processed_node" + var1);
  scripts\engine\utility::ref_143a6("death", "newpath", "node_wait_terminated");
  var0 scripts\engine\utility::ent_flag_clear(var1, 1);
}

function vehicle_paths_non_heli(var0) {
  self notify("newpath");

  if(isDefined(var0)) {
    self.attachedpath = var0;
  }

  var1 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var1)) {
    return;
  }

  self endon("newpath");
  self endon("death");
  var2 = var1;
  var3 = undefined;
  var4 = var1;
  var5 = get_path_getfunc(var1);
  var6 = 40000;

  while(isDefined(var4)) {
    if(!isstruct(var4)) {
      node_wait(var4, var3, var5);
    } else {
      struct_wait(var4, var3, var6);
    }

    if(!isDefined(self)) {
      return;
    }

    trigger_process_node(var4);
    self.currentnode = var4;

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var4.script_team)) {
      self.script_team = var4.script_team;
    }

    if(isDefined(var4.script_turningdir)) {
      self notify("turning", var4.script_turningdir);
    }

    if(isDefined(var4.script_deathroll)) {
      if(var4.script_deathroll == 0) {
        thread scripts\common\vehicle_code::deathrolloff();
      } else {
        thread scripts\common\vehicle_code::deathrollon();
      }
    }

    if(isDefined(var4.script_wheeldirection)) {
      scripts\common\vehicle_code::vehicle_setwheeldirection(var4.script_wheeldirection);
    }

    if(vehicle_should_unload(&node_wait, var4)) {
      thread unload_node(var4);
    }

    if(isDefined(var4.script_transmission)) {
      self.veh_transmission = var4.script_transmission;

      if(self.veh_transmission == "forward") {
        scripts\common\vehicle_code::vehicle_setwheeldirection(1);
      } else {
        scripts\common\vehicle_code::vehicle_setwheeldirection(0);
      }
    }

    if(isDefined(var4.script_brake)) {
      self.veh_brake = var4.script_brake;
    }

    if(isDefined(var4.script_pathtype)) {
      self.veh_pathtype = var4.script_pathtype;
    }

    if(isDefined(var4.script_speed)) {
      var7 = undefined;

      if(isDefined(var4.script_accel)) {
        var7 = var4.script_accel;
      }

      var8 = undefined;

      if(isDefined(var4.script_decel)) {
        var8 = var4.script_decel;
      }

      self vehicle_setspeed(var4.script_speed, var7, var8);
    }

    if(isDefined(var4.script_ent_flag_wait) && !scripts\engine\utility::ent_flag(var4.script_ent_flag_wait)) {
      if(isDefined(var4.script_decel)) {
        var8 = var4.script_decel;
      } else if(isDefined(var5.target)) {
        var9 = [[var6]](var5.target);
        var10 = distance(var5.origin, var9.origin) * 0.0568182;
        var11 = self vehicle_getspeed();
        var8 = squared(var11) / 2 * var10;
      } else {
        var8 = 20;
      }

      self vehicle_setspeed(0, var8, var8);
      GscBinSkip4(0x35);
    }

    if(isDefined(var8.script_delay)) {
      var8 = 20;

      if(isDefined(var8.script_decel)) {
        var8 = var8.script_decel;
      }

      self vehicle_setspeed(0, var8);
      GscBinSkip4(0x35);
    }

    if(isDefined(var8.script_flag_wait)) {
      var12 = 0;

      if(!scripts\engine\utility::flag(var8.script_flag_wait) || isDefined(var8.script_delay_post)) {
        var12 = 1;
        var7 = 5;
        var8 = 20;

        if(isDefined(var8.script_accel)) {
          var7 = var8.script_accel;
        }

        if(isDefined(var8.script_decel)) {
          var8 = var8.script_decel;
        }

        _vehicle_stop_named("script_flag_wait_" + var8.script_flag_wait, var7, var8);
        GscBinSkip4(0x35);
      }

      scripts\engine\utility::flag_wait(var8.script_flag_wait);

      if(!isDefined(self)) {
        return;
      }

      if(isDefined(var8.script_delay_post)) {
        wait var8.script_delay_post;

        if(!isDefined(self)) {
          return;
        }
      }

      var7 = 10;

      if(isDefined(var8.script_accel)) {
        var7 = var8.script_accel;
      }

      if(var8) {
        self notify("resumed_path");
        _vehicle_resume_named("script_flag_wait_" + var8.script_flag_wait);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(var8.script_vehicle_lights_off)) {
      thread scripts\common\vehicle_lights::lights_off(var8.script_vehicle_lights_off);
    }

    if(isDefined(var8.script_vehicle_lights_on)) {
      thread scripts\common\vehicle_lights::lights_on(var8.script_vehicle_lights_on);
    }

    if(isDefined(var8.script_forcecolor)) {
      thread scripts\engine\utility::script_func("forcecolor_riders", var8.script_forcecolor);
    }

    var8 = var8;

    if(!isDefined(var8.target)) {
      break;
    }

    var8 = [[var12]](var8.target);

    if(!isDefined(var8)) {
      var8 = var8;
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

function add_z(var0, var1) {
  return (var0[0], var0[1], var0[2] + var1);
}

function vehicle_paths_helicopter(var0, var1, var2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(isDefined(var0)) {
    self.attachedpath = var0;
  }

  var3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var3)) {
    return;
  }

  var4 = var3;

  if(var1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var2)) {
    var5 = spawnStruct();
    var5.origin = add_z(self.origin, var2);
    heli_wait_node(var5, undefined);
  }

  var6 = undefined;
  var7 = var3;
  var8 = get_path_getfunc(var3);

  while(isDefined(var7)) {
    if(isDefined(var7.script_linkto)) {
      scripts\common\vehicle_code::set_lookat_from_dest(var7);
    }

    if(isDefined(var7.script_land)) {
      var9 = 0;

      if(isDefined(var7.target)) {
        var9 = isDefined([[var8]](var7.target));
      }

      thread scripts\common\vehicle_code::vehicle_landanims(var7.script_unload, var9);
    }

    heli_wait_node(var7, var6, var2);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = var7;
    var7 notify("trigger", self);

    if(isDefined(var7.script_helimove)) {
      self setyawspeedbyname(var7.script_helimove);

      if(var7.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    trigger_process_node(var7);

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var7.script_team)) {
      self.script_team = var7.script_team;
    }

    if(vehicle_should_unload(&heli_wait_node, var7)) {
      thread unload_node(var7);
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(var7.script_pathtype)) {
        self.veh_pathtype = var7.script_pathtype;
      }
    }

    if(isDefined(var7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var7.script_flag_wait);

      if(isDefined(var7.script_delay_post)) {
        wait var7.script_delay_post;
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(var7.script_vehicle_lights_off)) {
      thread scripts\common\vehicle_lights::lights_off(var7.script_vehicle_lights_off);
    }

    if(isDefined(var7.script_vehicle_lights_on)) {
      thread scripts\common\vehicle_lights::lights_on(var7.script_vehicle_lights_on);
    }

    if(isDefined(var7.script_forcecolor)) {
      thread scripts\engine\utility::script_func("forcecolor_riders", var7.script_forcecolor);
    }

    var6 = var7;

    if(!isDefined(var7.target)) {
      break;
    }

    var7 = [[var8]](var7.target);

    if(!isDefined(var7)) {
      var7 = var6;
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

function heli_wait_node(var0, var1, var2) {
  self endon("newpath");

  if(isDefined(var0.script_unload) || isDefined(var0.script_land)) {
    var3 = 0;

    if(isDefined(var0.script_land)) {
      scripts\engine\utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset)) {
        var3 = self.unload_land_offset;
      }
    } else if(isDefined(var0.script_unload) && isDefined(self.unload_hover_offset)) {
      var3 = self.unload_hover_offset;
    } else if(isDefined(var0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var4 = scripts\common\utility::groundpos(var0.origin);
      var3 = var0.origin[2] - var4[2];

      if(var3 >= self.unload_hover_offset_max) {
        var3 = self.unload_hover_offset_max;
      } else if(isDefined(self.unload_hover_land_height) && var3 < self.unload_hover_land_height) {
        var3 = self.unload_hover_land_height;
      }
    }

    var0.radius = 2;

    if(isDefined(var0.ground_pos)) {
      var0.origin = var0.ground_pos + (0, 0, var3);
    } else {
      var5 = scripts\common\utility::groundpos(var0.origin) + (0, 0, var3);

      if(var5[2] > var0.origin[2] - 2000) {
        var0.origin = scripts\common\utility::groundpos(var0.origin) + (0, 0, var3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var1)) {
    var6 = var1.script_airresistance;
    var7 = var1.speed;
    var8 = var1.script_accel;
    var9 = var1.script_decel;
  } else {
    var6 = undefined;
    var7 = undefined;
    var8 = undefined;
    var9 = undefined;
  }

  var10 = isDefined(var7.script_stopnode) && var7.script_stopnode;
  var11 = isDefined(var7.script_unload);
  var12 = isDefined(var7.script_flag_wait) && !scripts\engine\utility::flag(var7.script_flag_wait);
  var13 = !isDefined(var7.target);
  var14 = isDefined(var7.script_delay);

  if(isDefined(var7.angles)) {
    var15 = var7.angles[1];
  } else {
    var15 = 0;
  }

  if(self.health <= 0) {
    return;
  }

  var16 = var8.origin;

  if(isDefined(var6)) {
    var16 = add_z(var16, var6);
  }

  if(isDefined(self.heliheightoverride)) {
    var16 = (var16[0], var16[1], self.heliheightoverride);
  }

  self vehicle_helisetai(var16, var8, var9, var10, var8.script_goalyaw, var8.script_anglevehicle, var15, var7, var15, var11, var12, var13, var14);

  if(isDefined(var8.radius)) {
    self setneargoalnotifydist(var8.radius);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  trigger_process_node(var8);

  if(isDefined(var8.script_firelink)) {
    if(isDefined(level.helicopter_firelinkfunk)) {}

    GscBinSkip1(0x74, level.helicopter_firelinkfunk, var8);
  }

  var8 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    scripts\engine\utility::deletestruct_ref(var8);
  }

  self notify("continuepath");
}

function quickdropall() {
  var0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  if(var0.size == 1) {
    return var0[0];
  }

  var1 = [];

  foreach(var3 in var0) {
    if(!isDefined(var3.script_demeanor)) {
      var1 = var3;
    }
  }

  return var1[0];
}

function getonpath(var0) {
  var1 = undefined;
  var2 = self.vehicletype;

  if(isDefined(self.vehicle_spawner)) {
    if(istrue(self.vehicle_spawner.dontgetonpath)) {
      return;
    }
  }

  if(isDefined(self.target)) {
    var1 = getvehiclenode(self.target, "targetname");

    if(!isDefined(var1)) {
      var3 = getEntArray(self.target, "targetname");

      foreach(var5 in var3) {
        if(var5.code_classname == "script_origin") {
          var1 = var5;
          break;
        }
      }
    }

    if(!isDefined(var1)) {
      if(scripts\common\utility::iscp()) {
        var1 = quickdropall();
      } else {
        var1 = scripts\engine\utility::getStruct(self.target, "targetname");
      }
    }
  }

  if(!isDefined(var1)) {
    if(scripts\common\vehicle_code::ishelicopter_internal()) {
      self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self.attachedpath = var1;

  if(!scripts\common\vehicle_code::ishelicopter_internal() && !isstruct(var1)) {
    self.origin = var1.origin;

    if(!isDefined(var0)) {
      self attachpath(var1);
    }
  } else if(isDefined(self.speed)) {
    self vehicle_setspeedimmediate(self.speed, 20);
  } else if(isDefined(var1.speed)) {
    var7 = 20;
    var8 = 10;

    if(isDefined(var1.script_accel)) {
      var7 = var1.script_accel;
    }

    if(isDefined(var1.script_decel)) {
      var7 = var1.script_decel;
    }

    var9 = float(var1.speed);
    self vehicle_setspeedimmediate(var9, var7, var8);
  } else {
    self vehicle_setspeed(60, 20, 10);
  }

  thread _vehicle_paths(undefined, scripts\common\vehicle_code::ishelicopter_internal());
}

function _vehicle_resume_named(var0) {
  var1 = self.vehicle_stop_named[var0];
  self.vehicle_stop_named[var0] = undefined;

  if(self.vehicle_stop_named.size) {
    return;
  }

  self resumespeed(var1);
}

function _vehicle_stop_named(var0, var1, var2) {
  if(!isDefined(self.vehicle_stop_named)) {
    self.vehicle_stop_named = [];
  }

  self vehicle_setspeed(0, var1, var2);
  self.vehicle_stop_named[var0] = var1;
}

function unload_node(var0) {
  self endon("death");

  if(isDefined(self.ent_flag["prep_unload"]) && scripts\engine\utility::ent_flag("prep_unload")) {
    return;
  }

  if(!isDefined(var0.script_flag_wait) && !isDefined(var0.script_delay)) {
    self notify("newpath");
  }

  var1 = getnode(var0.targetname, "target");

  if(isDefined(var1) && self.riders.size) {
    foreach(var3 in self.riders) {
      if(isai(var3)) {
        var3 thread scripts\engine\utility::script_func("go_to_node", var1);
      }
    }
  }

  if(scripts\common\vehicle_code::ishelicopter_internal()) {
    self sethoverparams(0, 0, 0);
    scripts\common\vehicle_code::waittill_stable(var0);
  }

  if(isDefined(var0.script_noteworthy)) {
    if(var0.script_noteworthy == "wait_for_flag") {
      scripts\engine\utility::flag_wait(var0.script_flag);
    }
  }

  if(isDefined(var0.script_unload)) {
    if(var0.script_unload == "1") {
      var0.script_unload = "default";
    }
  }

  scripts\common\vehicle_code::_vehicle_unload(var0.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(var0.script_unload)) {
    self waittill("unloaded");
  }

  if(isDefined(var0.script_flag_wait) || isDefined(var0.script_delay)) {
    return;
  }

  if(isDefined(self)) {
    thread vehicle_resumepathvehicle();
    return;
  }
}