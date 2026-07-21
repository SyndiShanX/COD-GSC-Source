/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_vehicles.gsc
***********************************************/

coopvehicles_init() {
  if(isDefined(level.vehicles_init))
    [[level.vehicles_init]]();

  if(!isDefined(level.unloading_func))
    level.unloading_func = [];

  if(!isDefined(level.unloaded_func))
    level.unloaded_func = [];

  if(!isDefined(level.vehicle_builds))
    level.vehicle_builds = [];

  setDvar("_encstr_AAB417B9369CEBB9E8E45D6C3AF56EC11BA573CAF50E858E0D", 1);
  level thread init_vehicle_spawning();
  scripts\engine\utility::create_func_ref("_encstr_8D0E18DBB56330034C871198DFF8CFE7EDA87F3DF8A4E48B431B", ::incrementobjectiveachievementkill);
  level._effect["_encstr_B8DC10183F8D7457BF7738A11271B8E0B44D"] = loadfx("_encstr_B1473108DAA09FE817E8786E984E91D9CD23B06873AD954143E77ED36FDB3B9BF279A080CBD9FB5ABBCC705671FFA0C55B92E0");
  level._effect["_encstr_99B91250F35864D3F0A3B2A9EBDFDF9DA073C2A5"] = loadfx("_encstr_88362ED39980C0D07742512BC9CEB9C46843D8D7B52E2EF3DAC7475BA1FF9933C05196540A60F6A1934801CC5A4575D0");
  level._effect["_encstr_B2251330933804F3D083928969B627FBC009B59811"] = loadfx("_encstr_9AB231FCAE2B28030B5F19F0F335CF189F4007FD12CE4B55B031C070F9FE91B0BBE805EEA78773BFDB4AF001725099600B6613");
}

_id_13F29() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.bullet_shield)) {
        var_0 = getarraykeys(level.vehicle.templates.bullet_shield);

        for(var_1 = 0; var_1 < var_0.size; var_1++)
          level.vehicle.templates.bullet_shield[var_0[var_1]] = 0;
      }
    }
  }
}

init_infectgroundwarvehicles() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.unloadgroups)) {
        var_0 = getarraykeys(level.vehicle.templates.unloadgroups);

        for(var_1 = 0; var_1 < var_0.size; var_1++) {
          var_2 = var_0[var_1];
          var_3 = level.vehicle.templates.aianims[var_0[var_1]].size;

          if(!isDefined(level.vehicle.templates.unloadgroups[var_2]))
            level.vehicle.templates.unloadgroups[var_2] = [];

          if(isDefined(level.vehicle.templates.unloadgroups[var_2]["_encstr_BED50BFF9EF32711D62F803057"])) {
            continue;
          }
          if(var_3 > 1) {
            for(var_4 = 1; var_4 < var_3; var_4++) {
              if(isDefined(level.vehicle.templates.aianims[var_2][var_4])) {
                var_5 = level.vehicle.templates.aianims[var_2][var_4];

                if(isDefined(var_5.getout)) {
                  if(!isDefined(level.vehicle.templates.unloadgroups[var_2]["_encstr_BED50BFF9EF32711D62F803057"]))
                    level.vehicle.templates.unloadgroups[var_2]["_encstr_BED50BFF9EF32711D62F803057"] = [];

                  level.vehicle.templates.unloadgroups[var_2]["_encstr_BED50BFF9EF32711D62F803057"][level.vehicle.templates.unloadgroups[var_2]["_encstr_BED50BFF9EF32711D62F803057"].size] = var_4;
                }
              }
            }
          }
        }
      }
    }
  }
}

_id_1311C() {
  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.team)) {
        var_0 = getarraykeys(level.vehicle.templates.team);

        for(var_1 = 0; var_1 < var_0.size; var_1++)
          level.vehicle.templates.team[var_0[var_1]] = "_encstr_8E8405EA382B2A";
      }
    }
  }
}

_id_1311B(var_0, var_1) {
  level.vehicle.templates.bullet_shield[var_1] = var_0;
}

registervehicleinteractions() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_95AF1A5AE6E8B239161B8EB4EDE6CD7D96734BA37DE68EC24E8EB291"))
    scripts\engine\utility::flag_wait("_encstr_95AF1A5AE6E8B239161B8EB4EDE6CD7D96734BA37DE68EC24E8EB291");

  level.interaction_hintstrings["_encstr_AC190E59E2D43835FF1BD960F2D77968"] = &"_encstr_B6731AF6082797EB74F86919D05AC70D8B946DF6AF5BBDB96C6009A9";
  level.interaction_hintstrings["_encstr_8CA309F310986DC115F6F8"] = &"_encstr_820427FF5451F9376731BD5774AA901151ADBB8B2F780A579B612999F791CA18F1D509CF352534C5E2";
  scripts\cp\cp_interaction::registerinteraction("_encstr_AC190E59E2D43835FF1BD960F2D77968", ::vehiclehint, ::usevehicle);
  scripts\cp\cp_interaction::registerinteraction("_encstr_8CA309F310986DC115F6F8", ::vehiclehint, ::usevehicle);
}

vehiclehint(var_0, var_1) {
  if(getdvarint("_encstr_AB601C16D37B5E7BA502B06829FF15D0D37916012D27A34B8C3AD8B8A2D2", 0) == 1)
    return &"_encstr_B6731AF6082797EB74F86919D05AC70D8B946DF6AF5BBDB96C6009A9";
  else
    return "_encstr_B40101";
}

usevehicle(var_0, var_1) {
  if(getdvarint("_encstr_AB601C16D37B5E7BA502B06829FF15D0D37916012D27A34B8C3AD8B8A2D2", 0) == 1) {
    var_2 = var_0.vehicle;
    var_2.ownerid = var_1 getentitynumber();
    var_2.originalowner = var_1;
    var_2.driver = var_1;
    var_1.vehicle = var_2;
    var_2 setCanDamage(0);
    var_1 setplayerangles(var_2.angles);
    var_1.vehicle setotherent(var_1);
    var_1 controlslinkTo(var_2);
    var_1 playerlinktodelta(var_2, "_encstr_91A20B39B11731F50B2A7B0183");
    var_1.vehicle setentityowner(var_1);
    var_1 playerhide();

    foreach(var_0 in var_2.interactions)
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);

    thread watchforplayerexit(var_2, var_1);
    thread vehiclewatchforflip(var_2, var_1);
  }
}

watchforplayerexit(var_0, var_1) {
  var_1 endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 notifyonplayercommand("_encstr_95740D391337B5711BE5A9A30B4578", "_encstr_97410B23BD6B976233901AF2F8");
  var_1 waittill("_encstr_95740D391337B5711BE5A9A30B4578");
  exitvehicle(var_0, var_1);
}

exitvehicle(var_0, var_1, var_2) {
  var_1 unlink(1);
  var_1 controlsunlink();
  var_1.vehicle setotherent(undefined);
  var_1.vehicle setentityowner(undefined);
  var_1.vehicle = undefined;
  var_1 setOrigin(scripts\engine\utility::random(var_0.interactions).origin);

  if(istrue(var_2))
    var_0 delete();
  else {
    foreach(var_4 in var_0.interactions)
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
  }

  waitframe();
  var_1 playershow();
}

vehiclewatchforflip(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = 0;

  for(;;) {
    if(var_2 >= 4) {
      break;
    }

    var_3 = vectordot(anglestoup(var_0.angles), (0, 0, 1));

    if(var_3 < 0.707)
      var_2 = var_2 + 0.05;
    else
      var_2 = 0;

    waitframe();
  }

  exitvehicle(var_0, var_1, 1);
}

updateinteractionstructpositions(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = spawnStruct();
  var_2 = spawnStruct();
  var_3 = spawnStruct();
  var_4 = spawnStruct();
  createvehicleinteraction(var_1, var_0);
  createvehicleinteraction(var_2, var_0);
  createvehicleinteraction(var_3, var_0);
  createvehicleinteraction(var_4, var_0);

  for(;;) {
    var_5 = anglesToForward(var_0.angles);
    var_6 = -1 * var_5;
    var_7 = anglestoleft(var_0.angles);
    var_8 = anglestoright(var_0.angles);
    var_5 = var_5 * 145;
    var_6 = var_6 * 145;
    var_7 = var_7 * 90;
    var_8 = var_8 * 90;
    var_9 = var_0.origin + var_5;
    var_10 = var_0.origin + var_6;
    var_11 = var_0.origin + var_7;
    var_12 = var_0.origin + var_8;
    var_1.origin = var_9 + (0, 0, 12);
    var_2.origin = var_10 + (0, 0, 12);
    var_3.origin = var_11 + (0, 0, 12);
    var_4.origin = var_12 + (0, 0, 12);
    wait 0.25;
  }
}

_spawnVehicle(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnVehicle(var_0, var_1, var_2, var_3, var_4);
  var_7.interactions = [];
  var_7 thread updateinteractionstructpositions(var_7);
  return var_7;
}

createvehicleinteraction(var_0, var_1) {
  var_0.script_noteworthy = "_encstr_AC190E59E2D43835FF1BD960F2D77968";
  var_0.requires_power = 0;
  var_0.powered_on = 1;
  var_0.script_parameters = "_encstr_8B1608EC43B8D647A113";
  var_0.cost = 0;
  var_0.spend_type = "_encstr_A3BA05E0735C50";
  var_0.targetname = "_encstr_81010C2D9BE8B29C0B8D1D2DED37";
  var_0.vehicle = var_1;
  var_1.interactions[var_1.interactions.size] = var_0;
  scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", "_encstr_81010C2D9BE8B29C0B8D1D2DED37", var_0);
  scripts\cp\utility::addtostructarray("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", "_encstr_8CA309F310986DC115F6F8", var_0);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

create_simple_vehicle_path_from_struct(var_0) {
  self.pathing_array = [];
  self.pathing_array[self.pathing_array.size] = var_0;
  var_0.pathing_index = self.pathing_array.size;

  for(var_1 = var_0; isDefined(var_1.target); self.pathing_array[self.pathing_array.size] = var_1) {
    var_2 = scripts\engine\utility::getStructArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_2.size < 1) {
      break;
    }

    if(var_2.size > 1) {
      var_3 = 1;
      var_4 = var_2;
      var_2 = [];

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        if(var_4[var_5] == var_1) {
          var_3 = 0;
          continue;
        }

        var_2[var_2.size] = var_4[var_5];
      }
    }

    var_1 = var_2[0];
    var_1.pathing_index = self.pathing_array.size;
  }
}

vehiclefollowpathgeneric(var_0, var_1) {
  if(istrue(var_1))
    create_simple_vehicle_path_from_struct(var_0);

  if(isstruct(var_0))
    thread vehiclefollowstructpath(var_0);
  else
    thread vehiclefollowpath(var_0);
}

getvehiclepath(var_0) {
  var_1 = getvehiclenode(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  return var_1;
}

vehiclefollowstructpathsplines(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  self endon("_encstr_8C9E0BD847079DA879ABD879E1");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_1.size == 0) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  while(var_1.size < 4) {
    var_3 = create_extra_structpath(1, var_1[var_1.size - 1].origin, var_1[var_1.size - 2].origin);
    var_1[var_1.size] = var_3;
  }

  var_4 = [];
  var_5 = [];
  var_6 = var_1.size;
  var_7 = undefined;
  var_8 = self.origin;
  var_9 = 15;

  for(var_10 = 0; var_10 < var_6; var_10++) {
    if(isDefined(var_1[var_10 + 1]))
      var_7 = var_1[var_10 + 1].origin;

    if(var_10 == 0)
      var_4[var_4.size] = self.origin;
    else
      var_4[var_4.size] = var_1[var_10].origin;

    var_11 = 300;

    if(isDefined(self.convoy) && istrue(self.convoy.settings.use_path_speeds) && isDefined(var_1[var_10].speed) || !isDefined(self.convoy) && isDefined(var_1[var_10].speed))
      var_11 = 300 * (var_1[var_10].speed / 15);

    var_12 = get_duration_between_points(var_8, var_7, scripts\engine\utility::ter_op(isDefined(self.cp_speed), self.cp_speed, var_11));
    var_5[var_5.size] = var_12;
    var_8 = var_7;
  }

  if(isDefined(self.convoy) && istrue(self.on_last_pathing_array)) {
    var_13 = self.convoy.spawned_vehicles.size;
    var_14 = 500;

    for(var_10 = 0; var_10 < self.convoy.spawned_vehicles.size; var_10++) {
      if(var_10 == 0) {
        continue;
      }
      if(self.convoy.spawned_vehicles[var_10] == self) {
        var_15 = var_4[var_4.size - 1];
        var_16 = var_4[var_4.size - 2];
        var_17 = (var_16 + var_15) / 2;
        var_18 = var_17 - var_16;

        if(length(var_18) < var_14 * var_10)
          var_18 = vectorNormalize(var_18) * (var_14 * var_10);

        var_4[var_4.size - 1] = var_15 - var_18;
      }
    }
  }

  if(isDefined(self.convoy) && isDefined(self.convoy.settings.path_jitter)) {
    var_6 = self.convoy.settings.path_jitter;

    if(var_6 > 0) {
      for(var_10 = 0; var_10 < var_4.size - 1; var_10++) {
        var_19 = randomfloatrange(var_6 * -1, var_6);
        var_20 = randomfloatrange(var_6 * -1, var_6);
        var_21 = 0;
        var_4[var_10] = var_4[var_10] + (var_19, var_20, var_21);
      }
    }
  }

  foreach(var_23 in var_4) {}

  foreach(var_26 in var_5) {}

  if(_id_141FD(self))
    self startpathnodes(var_4, var_5);
  else
    self startpathnodes(var_4, var_5, 0, 0.5, 0.5, 0, 0, 0);

  thread _id_14205(var_2);
  self notify("_encstr_82F90FEBADB95B9369883BF218BF4FDF53");

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    while(self issuspendedvehicle() || var_10 > 0 && var_5[var_10] > 1 && self vehicle_getspeed() < 1)
      wait 0.25;

    wait(var_5[var_10]);
  }

  if(_id_141FD(self)) {
    self.on_last_pathing_array = undefined;

    if(isDefined(self.convoy) && !istrue(self.convoy.settings.roaming) || !isDefined(self.convoy))
      thread finish_spline_path();
  }

  if(istrue(self._id_119E3))
    vehiclefollowstructpathsplines(self.pathing_array[0], self.pathing_array, 1);
}

_id_141FD(var_0) {
  if(istrue(var_0._id_119E3))
    return 0;

  if(isDefined(var_0.pathing_arrays)) {
    if(istrue(var_0.on_last_pathing_array))
      return 1;
    else
      return 0;
  }

  return 1;
}

create_extra_structpath(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = (var_1 - self.origin) / 2;

  var_3 = var_1;
  var_4 = var_2;
  var_5 = (var_4 + var_3) / 2;
  var_6 = var_5 - var_4;
  var_7 = spawnStruct();
  var_7.origin = var_3 + var_6;
  return var_7;
}

vehiclefollowstructpath(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  self endon("_encstr_8C9E0BD847079DA879ABD879E1");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.on_last_pathing_array = undefined;
  var_2 = undefined;

  if(isDefined(self.pathing_arrays) && self.pathing_arrays.size > 0) {
    for(var_3 = 0; var_3 < self.pathing_arrays.size; var_3++) {
      if(!isDefined(self.pathing_arrays) || self.pathing_arrays.size == 0) {
        return;
      }
      if(var_3 == self.pathing_arrays.size - 1)
        self.on_last_pathing_array = 1;

      vehiclefollowstructpathsplines(var_0, self.pathing_arrays[var_3], var_1);
    }
  } else if(isDefined(self.pathing_array) && self.pathing_array.size > 0) {
    self.on_last_pathing_array = 1;
    vehiclefollowstructpathsplines(var_0, self.pathing_array, var_1);
  }
}

finish_spline_path() {
  if(isDefined(self.convoy)) {
    if(!isDefined(self.convoy.settings) || istrue(self.convoy.settings.unload_at_target)) {
      if(isDefined(level.vehicle_all_stop_func))
        self[[level.vehicle_all_stop_func]](0);

      self notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC");
    }

    if(isDefined(self.convoy.settings) && isDefined(self.convoy.settings.target))
      self notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC");
  }

  self stoppath(1);
  self notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
}

killstreak_update_hint_logic() {
  self endon("_encstr_AD75063D571AE108");

  if(!self issuspendedvehicle())
    self suspendvehicle();
}

ent_facing_away_from_mypos(var_0) {
  var_1 = var_0.angles;
  var_2 = vectordot(var_1, vectorNormalize(var_0.origin - self.origin));
  return var_2 > 0;
}

drop_to_ground_ignore_vehicle(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 1500;

  if(!isDefined(var_2))
    var_2 = -12000;

  var_4 = scripts\engine\trace::create_world_contents();

  if(isDefined(var_3))
    return scripts\engine\trace::ray_trace(var_0 + var_1 * var_3, var_0 + var_2 * var_3, undefined, var_4)["_encstr_BD260953AA97E3F014279D"];
  else
    return scripts\engine\trace::ray_trace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2), undefined, var_4)["_encstr_BD260953AA97E3F014279D"];
}

anglebetweenvectorsrounded(var_0, var_1) {
  return acos(clamp(vectordot(var_0, var_1) / (length(var_0) * length(var_1)), -1, 1));
}

vehiclefollowpath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  self endon("_encstr_8C9E0BD847079DA879ABD879E1");
  self startpath(var_0);

  for(var_1 = getvehiclenode(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"); isDefined(var_1); var_1 = getvehiclenode(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {
    var_1 waittill("_encstr_8F5C086405E70FBA4B4A");

    if(isDefined(var_1.script_unload)) {
      self vehicle_setspeedimmediate(0, 30, 30);

      for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed())
        wait 0.1;

      self notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC");

      while(self.riders.size > 0)
        wait 0.1;

      if(isDefined(var_1.target))
        self resumespeed(10);
    }

    if(isDefined(var_1.script_pathtype) && var_1.script_pathtype == "_encstr_81A8077D3088BFA631") {
      self vehicle_setspeedimmediate(0, 300, 300);
      self stoppath(1);
      self notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC");
      self notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
      return;
    }

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self vehicle_setspeedimmediate(0, 30, 30);

  for(var_2 = self vehicle_getspeed(); var_2 > 1; var_2 = self vehicle_getspeed())
    wait 0.1;

  self notify("_encstr_AB850C5DDC8DED168CF59DBA5EDC");
}

spawn_ai_in_truck(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_0 scripts\engine\utility::ent_flag_wait("_encstr_A7010F14764BF3BF23A9CB4080D74A0D41");
  var_0.riders = [];
  var_0.spawned_guys = [];
  var_9 = [];

  if(!isDefined(var_2) && isDefined(level.all_spawn_locations))
    var_2 = scripts\engine\utility::random(level.all_spawn_locations);

  var_10 = "_encstr_A33710EF824B85C7D9C6AF90CD034883701B";
  var_11 = level.ambientgroups[var_10];

  if(!isDefined(var_11)) {
    var_12 = scripts\cp\cp_modular_spawning::registerambientgroup;
    [[var_12]]("_encstr_A33710EF824B85C7D9C6AF90CD034883701B", 0, 10, 250, 20, 0, "_encstr_A33710EF824B85C7D9C6AF90CD034883701B", undefined, undefined, undefined);
    waitframe();
    var_11 = level.ambientgroups[var_10];
  }

  if(!var_11 scripts\engine\utility::ent_flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
    var_11 scripts\engine\utility::ent_flag_init("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

  if(!isDefined(level.spawn_module_structs_memory[var_10])) {
    level.spawn_module_structs_memory[var_10] = [];
    level.active_spawn_module_structs[var_10][0] = var_11;
    level.spawn_module_structs_memory[var_10][0] = var_11;
  }

  for(var_13 = 0; var_13 < var_1; var_13++) {
    if(isDefined(level.soldierspawnfunc))
      var_14 = [[level.soldierspawnfunc]](var_4, var_2, undefined, 1);
    else
      var_14 = var_0 scripts\cp\cp_modular_spawning::spawn_ai(undefined, undefined, var_5, var_11);

    if(isDefined(var_14)) {
      if(isDefined(var_11.cargo_truck_mg_init)) {
        if(isDefined(level.players[var_11.cargo_truck_mg_init])) {
          level.players[var_11.cargo_truck_mg_init].cargo_truck_mg_gunnerdamagemodignorefunc++;
          var_14.cargo_truck_mg_initdamage = level.players[var_11.cargo_truck_mg_init];
        }
      }

      var_11 scripts\cp\cp_modular_spawning::change_module_status(undefined, "_encstr_97EE0C19B7EA731910A0CE957347");
      level notify("_encstr_A3DD1637382CEEDC56C8EBEC27DEAB83AFCD7B63C84B569C", var_14);
      thread scripts\cp\cp_modular_spawning::run_ai_post_spawn_init(var_11, var_14, var_0, undefined, undefined, undefined, undefined);
      var_14.group = var_11;

      if(istrue(var_0._id_13898)) {
        var_14.sightmaxdistance = 2200;
        var_14.ignoreall = 1;
      }

      var_14.trial_target_think_func = 1;
      var_14.dontkilloff = 1;

      if(isDefined(level.reserved_spawn_slots["_encstr_95ED09EDEB0F7F38DFBBCB"]))
        scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_95ED09EDEB0F7F38DFBBCB");

      if(isDefined(var_8))
        var_14 thread[[var_8]]();

      if(istrue(var_7)) {
        var_15 = var_13 + 2;

        if(isDefined(var_6))
          var_15 = var_6;

        var_16 = (0, 0, 0);

        if(!isvector(var_6)) {
          var_17 = level.vehicle.templates.aianims[var_0.classname_mp][var_15];
          var_18 = var_17.sittag;
        } else {
          var_18 = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
          var_16 = var_6;
          var_16 = rotatevector(var_16, var_0.angles);
        }

        var_14.origin = var_0 gettagorigin(var_18) + (0, 0, -18) + var_16;
        var_14.linkedent = scripts\engine\utility::spawn_tag_origin(var_14.origin);
        var_14.linkedent linkTo(var_0, var_18);
        var_14 linkTo(var_14.linkedent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        var_14 thread scripts\engine\utility::delete_on_death(var_14.linkedent);
        wait 0.05;
        var_14 playerlinkedoffsetenable();
      }

      var_14.dontkilloff = 1;
      var_0.spawned_guys[var_0.spawned_guys.size] = var_14;
      var_9[var_9.size] = var_14;
    }

    wait 0.05;
  }

  if(!istrue(var_7)) {
    foreach(var_20 in var_9) {
      if(isDefined(var_6) && isint(var_6))
        var_20.forced_startingposition = var_6;

      var_0 thread scripts\common\vehicle_aianim::guy_enter(var_20);
    }
  }

  level thread make_guys_leave_truck(var_0);
  return var_9;
}

spawn_real_ai_from_drone_pos(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_2 = var_0.origin;
  var_3 = var_0.script_noteworthy;

  for(var_4 = var_0.model; var_1.size >= level.max_enemy_count; var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A"))
    wait 5;

  if(!isDefined(var_0)) {
    var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
    var_0 setModel(var_4);
    var_0.vehicle_position = 3;
    var_0.disable_gun_recall = 1;
    var_0.script_noteworthy = var_3;
  }

  var_5 = undefined;

  while(!isDefined(var_5)) {
    var_5 = scripts\cp\cp_modular_spawning::spawn_ai(var_2, undefined, undefined);

    if(!isDefined(var_5))
      wait 3;
  }

  var_5.disable_gun_recall = 1;
  var_5.disable_vehicle_idle = 1;
  var_5.animationarchetype = "_encstr_958C08CDDBD8325A959C";
  var_5.dontkilloff = 1;

  if(isDefined(level.reserved_spawn_slots["_encstr_99530D0353B07BA2A0C1CB472D55EB"]))
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_99530D0353B07BA2A0C1CB472D55EB");

  return var_5;
}

disableunloadanim() {
  return 1;
}

deposit_ai_from_drones_in_vehicle(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = scripts\engine\utility::_id_143AD("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A", "_encstr_AB850C5DDC8DED168CF59DBA5EDC");
  wait 0.75;
  level thread make_guys_leave_truck(self, 1);
}

create_unload_nodes(var_0, var_1) {
  var_2 = [(-140, 64, 48), (-212, 64, 48), (-140, -64, 48), (-212, -64, 48)];
  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_2) {
    if(var_4 < var_1) {
      var_7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin + var_6);
      var_3 = scripts\engine\utility::array_add(var_3, var_7);
      var_4++;
      var_7 linkTo(var_0);
      wait 0.1;
    }
  }

  return var_3;
}

reinforcement_test() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(4, "_encstr_9AE813B8BF41E8EDEA8ABEB5A5A235538F13983843");
  wait 5;
}

spawn_reinforcement_truck(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = var_8.origin;

  if(!isDefined(var_8.angles))
    var_10 = (0, 0, 0);
  else
    var_10 = var_8.angles;

  var_11 = _spawnVehicle(var_2, "_encstr_A96D08B8AF9D78E583DA", "_encstr_8FBC0F1A83346F0A58D35B59FFD899D75F", var_9, (0, 0, 0));

  if(isDefined(var_11)) {
    level thread vehicle_logic(var_11, var_3, var_0, var_5, var_6, var_7);
    return var_11;
  }
}

spawnreinforementtruck(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = var_8.origin;

  if(!isDefined(var_8.angles))
    var_10 = (0, 0, 0);
  else
    var_10 = var_8.angles;

  var_11 = _spawnVehicle(var_2, "_encstr_A96D08B8AF9D78E583DA", "_encstr_8FBC0F1A83346F0A58D35B59FFD899D75F", var_9, (0, 0, 0));

  if(isDefined(var_11)) {
    var_11.num_guys = var_0;
    var_11.targetname_string = var_1;
    var_11.model_name = var_2;
    var_11.start_node_name = var_3;
    var_11.damagable = var_4;
    var_11.spawnpoints = var_8;
    var_11.bforcespawn = var_6;
    var_11.group = var_7;
    return var_11;
  } else
    return undefined;
}

vehicle_logic(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 get_start_node(var_1);

  if(!isDefined(var_6)) {
    var_0 delete();
    return;
  }

  var_0.unload_nodes = create_unload_nodes(var_0, var_2);
  wait 0.1;
  var_0.origin = var_6.origin;
  var_0.angles = var_6.angles;
  spawn_ai_in_truck(var_0, var_2, var_3, var_4, var_5);
  var_0 vehiclefollowpath(var_6);
}

get_start_node(var_0) {
  var_1 = undefined;

  if(isDefined(var_0))
    var_1 = getvehiclenode(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  else {
    var_2 = getallvehiclenodes();
    var_3 = scripts\engine\utility::getclosest(self.origin, var_2, 500);

    if(!isDefined(var_3))
      return undefined;
    else
      var_1 = var_3;
  }

  return var_1;
}

spawn_guys_on_truck(var_0) {}

make_guys_leave_truck(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_965214322D9BB031C62BBE1B9558672BBE1D9C57365B");

  if(!istrue(var_1)) {
    var_0 waittill("_encstr_AB850C5DDC8DED168CF59DBA5EDC");
    var_0 vehicle_setspeed(0, 90, 90);
    wait 1;
    var_0 vehicle_setspeedimmediate(0, 30, 30);
  }

  if(istrue(var_0.disable_leave_truck)) {
    return;
  }
  var_2 = "_encstr_A33710EF824B85C7D9C6AF90CD034883701B";
  var_3 = level.ambientgroups[var_2];

  if(!isDefined(var_3)) {
    var_4 = scripts\cp\cp_modular_spawning::registerambientgroup;
    [[var_4]]("_encstr_A33710EF824B85C7D9C6AF90CD034883701B", 0, 10, 250, 20, 0, "_encstr_A33710EF824B85C7D9C6AF90CD034883701B", undefined, undefined, undefined);
    waitframe();
    var_3 = level.ambientgroups[var_2];
  }

  if(!var_3 scripts\engine\utility::ent_flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
    var_3 scripts\engine\utility::ent_flag_init("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

  if(!isDefined(level.spawn_module_structs_memory[var_2])) {
    level.spawn_module_structs_memory[var_2] = [];
    level.active_spawn_module_structs[var_2][0] = var_3;
    level.spawn_module_structs_memory[var_2][0] = var_3;
  }

  var_5 = [];

  foreach(var_7 in var_0.attachedguys) {
    if(isent(var_7)) {
      var_7.group = var_3;
      var_7.combat_func_override = "_encstr_A65B084B38A76BEFC350";

      if(istrue(var_0._id_13898) && isalive(var_7)) {
        var_7.sightmaxdistance = 2200;
        var_7 thread scripts\cp\coop_stealth::run_common_functions(var_7, 1, 1, 60, 160000);
        var_7.ignoreall = 0;
      }

      if(!isalive(var_7))
        var_5[var_5.size] = var_7;
    }
  }

  var_0 hudattractionobj(var_3, var_5);

  if(!istrue(var_1)) {
    while(var_0.riders.size > 0)
      waitframe();
  } else
    wait 2;

  var_0 notify("_encstr_BD82096B5DA4B07F924F29");
}

soldier_leave_truck(var_0, var_1) {
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0.origin);
  var_3 = anglesToForward(var_1.angles) * -1;
  var_4 = 150;
  var_5 = scripts\cp\utility::vec_multiply(var_3, var_4);
  var_6 = getclosestpointonnavmesh(var_0.origin + var_5);
  var_0.scripted_mode = 1;
  var_0.ignoreall = 1;
  var_0 linkTo(var_2);
  var_2 moveTo(var_6 + (0, 0, 5), 0.25);
  var_2 waittill("_encstr_9B420907FD535DAC6DF285");
  var_0.scripted_mode = 0;
  var_0.ignoreall = 0;
  var_0 unlink();
  var_1.riders = scripts\engine\utility::array_remove(var_1.riders, var_0);
  var_6 = getclosestpointonnavmesh(var_0.origin);
  var_0 setgoalpos(var_6);

  if(isDefined(var_0.spawnpoint) && isDefined(var_0.spawnpoint.script_goalvolume))
    var_0 setgoalvolumeauto(getEnt(var_0.spawnpoint.script_goalvolume, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B"));

  var_0.goalradius = 2048;
  var_2 delete();
}

incrementobjectiveachievementkill(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    if(isDefined(var_0.damage))
      var_1 = var_0.damage;

    if(isDefined(var_0.attacker) && isPlayer(var_0.attacker) && isDefined(var_1)) {
      if(isDefined(var_0.attacker.team) && isDefined(self.team) && var_0.attacker.team != self.team) {
        if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
          if(var_0.objweapon.basename == "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18")
            var_1 = 10000;
        }
      }

      if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
        switch (var_0.objweapon.basename) {
          case "_encstr_8DCB0F47F22330CEE7996B13A2E390583A":
          case "_encstr_95E70D8EDBDA85F5839CED35F5B683":
            if(isDefined(self.healthbuffer))
              self.health = self.healthbuffer - 100;
            else
              self.health = 0;

            break;
          case "_encstr_BA730BF8AFF178988293F158B9":
            if(self.healthbuffer > self.health) {
              if(isDefined(var_0.objweapon) && issubstr(var_0.objweapon.basename, "_encstr_8DCB085BEF657B4DCF0B"))
                var_0.attacker thread scripts\cp\cp_achievement::scriptable_setups();
            }

            break;
        }

        if(isDefined(var_0.meansofdeath))
          var_1 = scripts\cp\cp_damage::handleapdamage(var_0.objweapon, var_0.meansofdeath, var_1, var_0.attacker);
      }

      if(isDefined(self.is_correct_wire_color_sync))
        var_1 = var_1 * self.is_correct_wire_color_sync;

      if(istrue(var_0.attacker.is_available_for_hack)) {
        var_2 = var_0.attacker.origin[2];
        var_3 = self.origin[2];

        if(var_2 >= var_3) {
          var_4 = int(abs(var_2 - var_3));
          var_5 = int(var_4 / 64);

          if(var_5 > 0)
            var_1 = var_1 * (1 + 0.4 * var_5);
        }
      }

      var_0.attacker scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", 1, var_1, 0, 0);
      var_6 = self.health - var_1;
      self.health = int(max(var_6, self.healthbuffer - 1));
    }
  }

  return var_1;
}

delete_on_end() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  wait 0.25;
  scripts\engine\utility::_id_143A5("_encstr_BD82096B5DA4B07F924F29", "_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
}

spawnstaticvehicle(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3.angles = var_1;
  var_3 setModel(var_2);
  var_3 solid();
  createnavobstaclebybounds(var_3.origin, (100, 100, 200), var_3.angles);
  var_3 disconnectPaths();
  wait 0.1;
}

init_vehicle_spawning() {
  level.ai_spawn_vehicle_func = [];
  level.next_index = 0;
  level.all_ai_vehicle_infils = [];
  level.available_ai_vehicle_air_infils = [];
  level.available_ai_vehicle_ground_infils = [];
  level.path_points = [];
  level.invalid_path_points = [];
  level.heli_triggers = [];
  level._id_14102 = [];
  create_vehicle_builds();
  vehicle_registrations();
  level thread init_vehicles_after_flags();
  add_ai_ground_infil("_encstr_BE76076250081CE2DF");
  add_ai_ground_infil("_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B");
  add_ai_air_infil("_encstr_A6F90CB2FC09825758B150955870");
  register_vehicle_spawn("_encstr_A6F90CB2FC09825758B150955870", undefined, undefined, undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, "_encstr_A5B51098DDE113BF8276A09BB1C78B0BFBB2", undefined, ::spawn_enemy_chopper, "_encstr_88CD07337F8B2B8083");
  register_vehicle_spawn("_encstr_B4750649E5A638C0", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "_encstr_B4750649E5A638C0");
  register_vehicle_spawn("_encstr_8AA50F73A76340B0F9ABC7FD57330B802B", 10, 10, 10, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", "_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", undefined, ::veh_ground_veh_spawn, "_encstr_8AA50F73A76340B0F9ABC7FD57330B802B");
  register_vehicle_spawn("_encstr_8348061DACC643DE", 10, 10, 10, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", "_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", undefined, ::veh_ground_veh_spawn, "_encstr_8348061DACC643DE");
  register_vehicle_spawn("_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B", 10, 10, 10, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", "_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", undefined, ::veh_ground_veh_spawn, "_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B");
  register_vehicle_spawn("_encstr_96D415B368D32A264101914949E5B8279B0F08C19F1ADB", 1, 2, 30, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", "_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", undefined, ::veh_ground_veh_spawn, "_encstr_96D415B368D32A264101914949E5B8279B0F08C19F1ADB");
  register_vehicle_spawn("_encstr_8C3819FCAD6BCA6F8D4A80113265C1FE975B8B790FBAE327329340", 1, 2, 30, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", "_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", undefined, ::veh_ground_veh_spawn, "_encstr_8C3819FCAD6BCA6F8D4A80113265C1FE975B8B790FBAE327329340");
  register_vehicle_spawn("_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3", 4, 10, 10, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", "_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", undefined, ::veh_ground_veh_spawn, "_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3");
  register_vehicle_spawn("_encstr_BEDB0ABB93F56A5919C1C782", 4, 10, 10, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", "_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", undefined, ::veh_ground_veh_spawn, "_encstr_BEDB0ABB93F56A5919C1C782");
  register_vehicle_spawn("_encstr_A3351CC84AC5A988DF2FC446E747506161A3F8A062DEC1813F2B5737D703", undefined, undefined, undefined, undefined, undefined, undefined, undefined, ::choose_random_ground_vehicle_spawn);
  register_vehicle_spawn("_encstr_83C5194E0B7323EDADFAB0D227EBB395D02DD836B2EBCDC1C2DD73", undefined, undefined, undefined, undefined, undefined, undefined, undefined, ::choose_random_air_vehicle_spawn);
  register_vehicle_spawn("_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728", undefined, undefined, undefined, undefined, undefined, undefined, undefined, ::choose_escalation_air_vehicle_spawn);
  register_vehicle_spawn_drivers("_encstr_AD8D0DAA4A18EDD130D7CB40935DC7", 2, scripts\engine\utility::random(["_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4", "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8"]));
  register_vehicle_spawn_drivers("_encstr_8348061DACC643DE", 2, scripts\engine\utility::random(["_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4", "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8"]));
  register_vehicle_spawn_drivers("_encstr_96D415B368D32A264101914949E5B8279B0F08C19F1ADB", 2, scripts\engine\utility::random(["_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4", "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8"]));
  register_vehicle_spawn_drivers("_encstr_8C3819FCAD6BCA6F8D4A80113265C1FE975B8B790FBAE327329340", 2, scripts\engine\utility::random(["_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4", "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8"]));
  register_vehicle_spawn_drivers("_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3", 2, scripts\engine\utility::random(["_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4", "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8"]));
  register_vehicle_spawn_drivers("_encstr_B4750649E5A638C0", 2, scripts\engine\utility::random(["_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4", "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8"]));
}

register_unloading_func(var_0, var_1) {
  if(!isDefined(level.unloading_func))
    level.unloading_func = [];

  var_2 = spawnStruct();
  var_2.spawn_type = var_1;
  level.unloading_func[var_0] = var_1;
}

register_unloaded_func(var_0, var_1) {
  if(!isDefined(level.unloading_func))
    level.unloaded_func = [];

  var_2 = spawnStruct();
  var_2.spawn_type = var_1;
  level.unloaded_func[var_0] = var_1;
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

deploy_fast_rope() {
  var_0 = self gettagorigin("_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_1 = self gettagangles("_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_2 = "_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D";
  var_3 = % _encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D;
  var_4 = getstartorigin(var_0, var_1, var_3);
  var_5 = getstartangles(var_0, var_1, var_3);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_6.angles = var_5;
  thread scripts\engine\utility::delete_on_death(var_6);
  var_6 setModel("_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D");
  var_6 linkTo(self);
  var_6 scriptmodelplayanimdeltamotionfrompos(var_2, var_4, var_5);
  var_0 = self gettagorigin("_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_1 = self gettagangles("_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1");
  var_2 = "_encstr_A55427AC8BBAA583DA5937D17DCC166EA3EB4EBD1CCAD7BB6BAF18627DB437334B8DF543CAC62DD727";
  var_3 = % _encstr_A55427AC8BBAA583DA5937D17DCC166EA3EB4EBD1CCAD7BB6BAF18627DB437334B8DF543CAC62DD727;
  var_4 = getstartorigin(var_0, var_1, var_3);
  var_5 = getstartangles(var_0, var_1, var_3);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_7.angles = var_5;
  thread scripts\engine\utility::delete_on_death(var_7);
  var_7 setModel("_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D");
  var_7 linkTo(self);
  var_7 scriptmodelplayanimdeltamotionfrompos(var_2, var_4, var_5);
  scripts\engine\utility::waittill_either("_encstr_AD75063D571AE108", "_encstr_BD82096B5DA4B07F924F29");
  var_6 scriptmodelclearanim();
  var_6 scriptmodelplayanim("_encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663");
  var_7 scriptmodelclearanim();
  var_7 scriptmodelplayanim("_encstr_A9AE2C56E2D5B483ADB27347D7CC85DC47AF277B0759EB77B5BE0362F5D237335A36AF1A951B4B7DC9D733B0C663");
  wait 2;
  var_6 delete();
  var_7 delete();
}

drop_fast_rope() {}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

setup_fast_rope_anims() {
  level.scr_animtree["_encstr_A11F05257FC375"] = #animtree;
  level.scr_anim["_encstr_A11F05257FC375"]["_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D"] = % _encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D;
  level.scr_animname["_encstr_A11F05257FC375"]["_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D"] = "_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D";
  level.scr_model["_encstr_A11F05257FC375"]["_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D"] = "_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D";
  level.tag["_encstr_A11F05257FC375"]["_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D"] = "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1";
  level.scr_anim["_encstr_A11F05257FC375"]["_encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663"] = % _encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663;
  level.scr_animname["_encstr_A11F05257FC375"]["_encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663"] = "_encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663";
  level.scr_model["_encstr_A11F05257FC375"]["_encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663"] = "_encstr_B25427595C5D5A0EB5B2CD3AD79916378EF59CDBE059BEEEB57DC04C7DA573CC2D36AFD02B36A5F58D";
  level.tag["_encstr_A11F05257FC375"]["_encstr_9AF32C2BB85DB4C16B2B9B47AFCC58B9A3FAE4BD0759EBEE5BEB6089BE5A9BCC2D8DEB3456632DAFC6AF990BC663"] = "_encstr_86EB131F452BEAF1E066DEE5586B0113F58783A3E1";
}

init_vehicles_after_flags() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_97AF17C6CAD9598DEB939585235EF5CC7B397D37D84E9607E8");
  _id_13F29();
  init_infectgroundwarvehicles();
  _id_1311C();
  level.ground_vehicle_structs = scripts\engine\utility::getStructArray("_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level.vehicle.helicopter_crash_locations)) {
    level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getstructarray_delete("_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
    level.vehicle.helicopter_crash_locations = scripts\engine\utility::array_combine(level.vehicle.helicopter_crash_locations, scripts\engine\utility::getStructArray("_encstr_8CC80AA0A5312A895DF871B4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  } else
    level.vehicle.helicopter_crash_locations = scripts\engine\utility::getStructArray("_encstr_8CC80AA0A5312A895DF871B4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

vehicle_ai_spawn_funcs() {
  register_spawner_script_function("_encstr_BE76076250081CE2DF", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_8AA50F73A76340B0F9ABC7FD57330B802B", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_8348061DACC643DE", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_B226132E9318501FD140B28908B80B71181BB98B3B", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_96D415B368D32A264101914949E5B8279B0F08C19F1ADB", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_8C3819FCAD6BCA6F8D4A80113265C1FE975B8B790FBAE327329340", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_BEDB0ABB93F56A5919C1C782", ::ai_ground_veh_spawn, undefined);
  register_spawner_script_function("_encstr_B4750649E5A638C0", ::ai_ground_veh_spawn, undefined);
}

register_spawner_script_function(var_0, var_1, var_2, var_3) {
  if(istrue(var_3))
    level waittill(var_0);

  if(isDefined(level.spawner_script_funcs[var_0]))
    var_4 = level.spawner_script_funcs[var_0];
  else
    var_4 = spawnStruct();

  var_4.script_function = var_1;
  var_4.specs = var_2;
  level.spawner_script_funcs[var_0] = var_4;
}

create_ai_plr_vehicle(var_0, var_1) {
  copy_vehicle_build_to_spawnpoint(var_1, var_0);
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2.cannotbesuspended = 1;

  if(isDefined(var_0.vehiclename)) {
    var_2.vehiclename = var_0.vehiclename;
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_2, "_encstr_8E8405EA382B2A");
    var_2 makeunusable();
    var_2 setCanDamage(1);
    var_2.maxhealth = 999999;
    var_2.health = var_2.maxhealth;
    var_2 scripts\cp_mp\emp_debuff::set_start_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
    var_2 scripts\cp_mp\emp_debuff::set_clear_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance(var_2);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance(var_2);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_2);
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_2, undefined, undefined);
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent(var_2, undefined);
    var_3 = scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
    [[var_3]](var_2, scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback);
    var_4 = scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
    [[var_4]](var_2, scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback);
    thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  }

  return var_2;
}

register_vehicle_build(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.model = var_1;
  var_5.vehicletype = var_2;
  var_5.classname_mp = var_3;
  level.vehicle_builds[var_0] = var_5;
}

_id_12B02(var_0, var_1) {
  if(istrue(var_1))
    level waittill(var_0);

  var_2 = level.vehicle_builds[var_0];

  if(isDefined(var_2)) {
    var_2.trial_turret_kill_func = 1;
    var_2.brjugg_initfeatures = 1;
  }
}

_id_141B4(var_0) {
  return istrue(level.vehicle_builds[var_0].trial_turret_kill_func);
}

init_ammo_boxes(var_0, var_1, var_2, var_3) {
  level thread _id_12B03(var_0, var_1, var_2, var_3, undefined, 1, 1);
  level thread _id_12B02(var_0, 1);
  level thread register_vehicle_spawn_drivers(var_0, 1, scripts\engine\utility::random(["_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4", "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8"]));
  level thread _id_12B05(var_0, undefined, undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined);
}

_id_12B03(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_6))
    level waittill(var_0);

  if(isDefined(level.vehicle)) {
    if(isDefined(level.vehicle.templates)) {
      if(isDefined(level.vehicle.templates.aianims)) {
        if(isDefined(level.vehicle.templates.aianims[var_3])) {
          if(isDefined(level.ai_spawn_vehicle_func[var_0]) && isDefined(level.ai_spawn_vehicle_func[var_0].max_ai)) {
            if(isDefined(var_5))
              level.vehicle_builds[var_0].max_ai = var_5;
            else
              level.vehicle_builds[var_0].max_ai = level.ai_spawn_vehicle_func[var_0].max_ai;
          } else if(isDefined(var_5))
            level.vehicle_builds[var_0].max_ai = var_5;
          else {
            var_7 = level.vehicle.templates.aianims[var_3];
            level.vehicle_builds[var_0].max_ai = var_7.size;
          }
        }
      }
    }
  }
}

puzzle_mark_complete(var_0, var_1) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[var_1]) && isDefined(level.vehicle_builds[var_1].max_ai)) {
    var_2 = puddle_fx(var_0, var_1);

    if(isDefined(var_2)) {
      var_3 = 0;

      for(var_4 = 0; var_4 < self.usedpositions.size; var_4++) {
        var_5 = 1;

        for(var_6 = 0; var_6 < var_2.size; var_6++) {
          if(var_2[var_6] == var_4) {
            var_5 = 0;
            break;
          }
        }

        if(var_5)
          var_3++;
      }

      return int(min(var_3, level.vehicle_builds[var_1].max_ai));
      return;
    }

    return level.vehicle_builds[var_1].max_ai;
    return;
  } else
    return undefined;
}

get_random_available_air_ai_infil() {
  return scripts\engine\utility::random(level.available_ai_vehicle_air_infils);
}

get_random_available_ground_ai_infil() {
  return scripts\engine\utility::random(level.available_ai_vehicle_ground_infils);
}

attempt_ai_ground_infil_cooldown(var_0) {
  if(level.ai_spawn_vehicle_func[var_0].max_num <= level.ai_spawn_vehicle_func[var_0].count)
    level thread remove_ai_ground_infil_for_time(var_0);
}

attempt_ai_air_infil_cooldown(var_0) {
  if(level.ai_spawn_vehicle_func[var_0].max_num <= level.ai_spawn_vehicle_func[var_0].count)
    level thread remove_ai_air_infil_for_time(var_0);
}

remove_ai_ground_infil_for_time(var_0) {
  level.available_ai_vehicle_ground_infils = scripts\engine\utility::array_remove(level.available_ai_vehicle_ground_infils, var_0);

  if(isDefined(level.ai_spawn_vehicle_func[var_0].cooldown))
    scripts\engine\utility::delaythread(level.ai_spawn_vehicle_func[var_0].cooldown, ::add_ai_ground_infil, var_0);
}

remove_ai_air_infil_for_time(var_0) {
  level.available_ai_vehicle_air_infils = scripts\engine\utility::array_remove(level.available_ai_vehicle_air_infils, var_0);

  if(isDefined(level.ai_spawn_vehicle_func[var_0].cooldown))
    scripts\engine\utility::delaythread(level.ai_spawn_vehicle_func[var_0].cooldown, ::add_ai_air_infil, var_0);
}

add_ai_air_infil(var_0) {
  level.available_ai_vehicle_air_infils[var_0] = var_0;
}

add_ai_ground_infil(var_0) {
  level.available_ai_vehicle_ground_infils[var_0] = var_0;
}

_id_12B05(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  level waittill(var_0);

  if(isDefined(level.ai_spawn_vehicle_func[var_0])) {
    var_10 = level.ai_spawn_vehicle_func[var_0];

    if(isDefined(var_0))
      var_10.spawn_type = var_0;

    if(isDefined(var_1))
      var_10.max_num = var_1;

    if(isDefined(var_2))
      var_10.cooldown = var_2;

    if(isDefined(var_3))
      var_10.max_wait_for_infil = var_3;

    if(isDefined(var_4))
      var_10.spawn_points = var_4;

    if(isDefined(var_5))
      var_10.exit_points = var_5;

    if(isDefined(var_6))
      var_10.path_start_points = var_6;

    if(isDefined(var_8))
      var_10.vehicle_spawn_func = var_8;

    if(isDefined(var_9))
      var_10.vehicle_build = var_9;

    level.ai_spawn_vehicle_func[var_0] = var_10;

    if(isDefined(var_6))
      level thread get_path_points(var_0, var_6);
  }

  if(isDefined(var_7)) {
    if(isDefined(level.vehicle_builds[var_0]) && isDefined(level.vehicle_builds[var_0].max_ai))
      level.vehicle_builds[var_0].max_ai = var_7;
  }
}

register_vehicle_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  level.all_ai_vehicle_infils[level.all_ai_vehicle_infils.size] = var_0;
  var_10 = spawnStruct();
  var_10.spawn_type = var_0;
  var_10.max_num = var_1;
  var_10.cooldown = var_2;
  var_10.max_wait_for_infil = var_3;
  var_10.spawn_points = var_4;
  var_10.exit_points = var_5;
  var_10.path_start_points = var_6;
  var_10.vehicle_spawn_func = var_8;
  var_10.count = 0;
  var_10.max_ai = var_7;
  var_10.vehicle_build = var_9;
  var_10.infected_music = var_0;
  level.ai_spawn_vehicle_func[var_0] = var_10;

  if(isDefined(var_6))
    level thread get_path_points(var_0, var_6);
}

get_path_points(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  level.path_points[var_0] = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

register_vehicle_spawn_drivers(var_0, var_1, var_2, var_3) {
  if(istrue(var_3))
    level waittill(var_0);

  if(isDefined(level.ai_spawn_vehicle_func[var_0])) {
    var_4 = level.ai_spawn_vehicle_func[var_0];
    var_4.num_script_models = var_1;
    var_4.driver_models = var_2;
    level.ai_spawn_vehicle_func[var_0] = var_4;
  }
}

choose_random_ground_vehicle_spawn(var_0, var_1, var_2) {
  if(isDefined(var_1.ai_infil_type))
    var_3 = var_1.ai_infil_type;
  else
    var_3 = get_random_available_ground_ai_infil();

  if(isDefined(var_3)) {
    var_1.og_script_function = var_1.script_function;
    var_1.script_function = var_3;

    if(!isDefined(var_1.vehicle) && isDefined(level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func]](var_0, var_1, var_3))
        return 1;
      else
        return 0;
    } else if(isDefined(var_1.vehicle))
      return 1;
    else
      return 0;

    self thread[[level.spawner_script_funcs[var_3].script_function]](var_0, var_1, var_3);
    thread attempt_ai_ground_infil_cooldown(var_3);
  } else
    return 0;
}

decrement_wave_veh_count(var_0) {
  if(isDefined(self.valid_vehicles) && isDefined(self.valid_vehicles[var_0])) {
    self.valid_vehicles[var_0]--;

    if(self.valid_vehicles[var_0] < 1)
      self.valid_vehicles[var_0] = undefined;
  }
}

choose_escalation_air_vehicle_spawn(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = var_0 scripts\cp\cp_modular_spawning::get_current_wave_ref();

  if(isDefined(var_4)) {
    var_5 = var_0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();

    if(istrue(var_0.use_only_veh_spawners) && (!isDefined(var_5) || var_5.size < 1))
      return 0;

    var_5 = var_1 scripts\cp\cp_modular_spawning::pressure_stability_event_init(var_5);

    if(isDefined(var_5) && var_5.size > 0) {
      var_3 = scripts\engine\utility::random(var_5);

      if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var_0, var_3))
        return 0;
    }
  } else if(isDefined(var_0.valid_vehicles) && scripts\engine\utility::array_sum(var_0.valid_vehicles) > 0) {
    var_5 = var_0 scripts\cp\cp_modular_spawning::pressure_stability_event_start();
    var_5 = var_1 scripts\cp\cp_modular_spawning::pressure_stability_event_init(var_5);

    if(isDefined(var_5) && var_5.size > 0) {
      var_3 = scripts\engine\utility::random(var_5);

      if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var_0, var_3))
        return 0;
    }
  } else
    var_3 = get_random_available_air_ai_infil();

  if(isDefined(var_3)) {
    if(scripts\cp\cp_modular_spawning::has_vehicle_type_exceeded_module_cap(var_0, var_3))
      return 0;

    var_1.og_script_function = var_1.script_function;
    var_1.script_function = var_3;

    if(!isDefined(var_1.vehicle) && isDefined(level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func]](var_0, var_1, var_3))
        return 1;
      else
        return 0;
    } else if(isDefined(var_1.vehicle))
      return 1;
    else
      return 0;

    self thread[[level.spawner_script_funcs[var_3].script_function]](var_0, var_1, var_3);
  } else
    return 0;
}

choose_random_air_vehicle_spawn(var_0, var_1, var_2) {
  if(isDefined(var_1.ai_infil_type))
    var_3 = var_1.ai_infil_type;
  else
    var_3 = get_random_available_air_ai_infil();

  if(isDefined(var_3)) {
    var_1.og_script_function = var_1.script_function;
    var_1.script_function = var_3;

    if(!isDefined(var_1.vehicle) && isDefined(level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var_3].vehicle_spawn_func]](var_0, var_1, var_3))
        return 1;
      else
        return 0;
    } else if(isDefined(var_1.vehicle))
      return 1;
    else
      return 0;

    self thread[[level.spawner_script_funcs[var_3].script_function]](var_0, var_1, var_3);
    thread attempt_ai_air_infil_cooldown(var_3);
  } else
    return 0;
}

ai_ground_veh_spawn(var_0, var_1, var_2) {
  if(isDefined(var_1.vehicle)) {
    self.vehicle = var_1.vehicle;
    self.vehicle thread scripts\engine\utility::thread_on_notify("_encstr_BD82096B5DA4B07F924F29", ::clear_kill_off_flags, self, undefined, self, self, "_encstr_AD75063D571AE108");
    thread delay_enter_vehicle(var_0, var_1, var_1.vehicle, var_2);
    var_1.vehicle thread allow_infil_after_full_or_timeout(var_0, var_2);
  }
}

should_kill_off_flags() {
  if(isDefined(level.script) && (level.script == "_encstr_ABDD090A3390CF5C40B73D" || level.script == "_encstr_8D5C0C360ED7318DB736DA0B32AC" || level.script == "_encstr_AC530FEAD3702BBEA039A770D918C2BFAF" || level.script == "_encstr_ACFA0BB7B381457BEEDF03FB44"))
    return 0;

  return 1;
}

stop_vehicle_on_damage_after_loaded() {
  self endon("_encstr_81A8077D3088BFA631");
  self endon("_encstr_AD75063D571AE108");
  self.vehicle endon("_encstr_AD75063D571AE108");
  self.vehicle endon("_encstr_A7A420CDE8DB1CEBCE2BD04BD863ACEB7BB9AFC80BB5859DCAFAA537E856E4B92CC6");
  self waittill("_encstr_92D20741F7CEB03D1B");
}

stop_vehicle_on_damage() {
  self.vehicle endon("_encstr_AD75063D571AE108");
  self.vehicle endon("_encstr_A7A420CDE8DB1CEBCE2BD04BD863ACEB7BB9AFC80BB5859DCAFAA537E856E4B92CC6");
  self endon("_encstr_81A8077D3088BFA631");
  self.vehicle endon("_encstr_BD82096B5DA4B07F924F29");
  var_0 = self.vehicle;
  var_1 = scripts\engine\utility::_id_143AD("_encstr_B2BE0788BAF573592F", "_encstr_AD75063D571AE108");
  thread stop_vehicle_on_damage_internal(var_0);
}

stop_vehicle_on_damage_internal(var_0) {
  var_0 notify("_encstr_A7A420CDE8DB1CEBCE2BD04BD863ACEB7BB9AFC80BB5859DCAFAA537E856E4B92CC6");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 scripts\common\utility::vehicle_detachfrompath();
  var_0 scripts\common\vehicle::vehicle_unload("_encstr_8B1608EC43B8D647A113");
  var_0 waittill("_encstr_BD82096B5DA4B07F924F29");
  var_0 thread scripts\common\utility::vehicle_resumepath();
}

ai_mindia8_jugg_spawn(var_0, var_1, var_2) {
  if(!isDefined(var_1.vehicle)) {
    if(isDefined(level.ai_spawn_vehicle_func[var_2].vehicle_spawn_func)) {
      if([[level.ai_spawn_vehicle_func[var_2].vehicle_spawn_func]](var_0, var_1, var_2)) {
        if(isDefined(self.unittype) && self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
          self.forced_startingposition = 14;
          self.dontkilloff = 1;
        }

        thread ai_enter_vehicle(var_0, var_1, var_2);

        if(!isDefined(self.forced_startingposition)) {
          if(var_1.vehicle.riders.size >= level.vehicle_builds[var_2].max_ai - 1)
            var_1.vehicle notify("_encstr_AD890EDA035FD38854EBE77E991A46F3");
        }
      }
    }
  } else {
    if(isDefined(self.unittype) && self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
      self.forced_startingposition = 14;
      self.dontkilloff = 1;
    }

    thread ai_enter_vehicle(var_0, var_1, var_2);

    if(var_1.vehicle.riders.size >= level.vehicle_builds[var_2].max_ai - 1)
      var_1.vehicle notify("_encstr_AD890EDA035FD38854EBE77E991A46F3");
  }
}

ai_lbravo_spawn(var_0, var_1, var_2) {
  if(!isDefined(var_1.vehicle) && isDefined(level.ai_spawn_vehicle_func[var_2].vehicle_spawn_func)) {
    if([[level.ai_spawn_vehicle_func[var_2].vehicle_spawn_func]](var_0, var_1, var_2))
      thread ai_enter_vehicle(var_0, var_1, var_2);
  } else
    thread ai_enter_vehicle(var_0, var_1, var_2);
}

ai_enter_vehicle(var_0, var_1, var_2) {
  if(isDefined(var_1.vehicle)) {
    thread hasexiteddriver(var_1.vehicle);
    thread delay_enter_vehicle(var_0, var_1, var_1.vehicle, var_2);
    var_1.vehicle thread allow_infil_after_full_or_timeout(var_0, var_2);

    if(isDefined(var_1.script_demeanor))
      scripts\cp\cp_modular_spawning::set_demeanor_from_unittype(var_1.script_demeanor);
  }
}

hasexiteddriver(var_0) {
  self endon("_encstr_AD75063D571AE108");
  hashitplayer(var_0);
  thread clear_kill_off_flags(self);
}

hashitplayer(var_0) {
  self endon("_encstr_81A8077D3088BFA631");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_ABA008615A631510C7EA");
}

delay_enter_vehicle(var_0, var_1, var_2, var_3) {
  if(isDefined(self.spawnpoint.pos_override_struct) && self.spawnpoint.pos_override_struct != var_2)
    var_2 thread add_to_vehicle_queue(self);
  else {
    scripts\engine\utility::thread_on_notify("_encstr_92D20741F7CEB03D1B", ::disable_canshootinvehicle);
    self hide();

    if(isDefined(var_1.script_demeanor))
      scripts\cp\cp_modular_spawning::set_demeanor_from_unittype(var_1.script_demeanor);

    var_4 = var_2 redlight(var_0, var_3);

    if(!isDefined(self.forced_startingposition) && isDefined(var_4) && int(var_4) >= 0)
      self.forced_startingposition = var_4;

    self dontinterpolate();
    var_2 thread scripts\common\vehicle_aianim::guy_enter(self);
  }
}

disable_canshootinvehicle() {
  self show();

  if(istrue(level.vehicle_ai_can_shoot_after_reload)) {
    return;
  }
  self.canshootinvehicle = 0;
}

add_to_vehicle_queue(var_0) {
  self notify("_encstr_938B159E49E09FFBB70F7337493BB21440B6126381B06D");
  self.load_queue[self.load_queue.size] = var_0;
  var_0 scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", ::remove_from_vehicle_queue, self);
}

remove_from_vehicle_queue(var_0) {
  if(isDefined(var_0) && isDefined(var_0.load_queue) && var_0.load_queue.size > 0) {
    if(scripts\engine\utility::array_contains(var_0.load_queue, self))
      var_0.load_queue = scripts\engine\utility::array_remove(var_0.load_queue, self);
  }
}

veh_ground_veh_spawn(var_0, var_1, var_2) {
  var_3 = level.ai_spawn_vehicle_func[var_2];
  var_4 = var_3 get_vehicle_spawn_points(var_1);

  if(var_4.size > 0) {
    foreach(var_6 in var_4) {
      if(istrue(var_6.in_use)) {
        continue;
      }
      var_7 = create_ai_plr_vehicle(var_6, var_2);

      if(isDefined(var_7)) {
        var_7 stringtovec3(var_1, var_0, var_6, var_2);
        var_7 thread veh_ping_vehicle_location_to_players();
        var_7 thread waittill_full_or_timeout(var_2, var_0);
        var_7 post_spawn_vehicle_init(var_0, var_1, var_2, var_6);
        var_7 thread super_onspawned(var_0, var_2);

        if(_id_141B4(var_2) || getdvarint("_encstr_B484197F779659DBB8D3CC920B811D9265838B57D13E6296E0FB42", 0))
          var_7 thread _id_135CB(var_7, var_2);

        clear_vehicle_build_to_spawnpoint(var_6);
        return 1;
      } else {
        clear_vehicle_build_to_spawnpoint(var_6);
        return 0;
      }
    }

    return 0;
  } else
    return 0;
}

veh_ping_vehicle_location_to_players() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A9210A283BEC90BB323450EC");

  for(;;) {
    pinglocationenemyteams(self.origin, "_encstr_8E8405EA382B2A");
    wait 2;
  }
}

post_spawn_vehicle_init(var_0, var_1, var_2, var_3) {
  level.ai_spawn_vehicle_func[var_2].count++;
  self.load_queue = [];
  self.group = var_0;
  self.vehicle_skipdeathmodel = 1;
  self.veh_spawn_point = var_3;
  var_1.ai_infil_type = var_2;
  var_3.in_use = 1;
  var_1.specs = level.spawner_script_funcs[var_2].specs;
  var_1.vehicle = self;
  self.spawn_point = var_1;
}

set_throttle_zero() {}

reset_throttle() {}

_id_135CB(var_0, var_1) {
  var_2 = level.ai_spawn_vehicle_func[var_1];

  if(isDefined(var_2) && isDefined(var_2.num_script_models)) {
    var_3 = [];

    for(var_4 = 0; var_4 < var_2.num_script_models; var_4++) {
      var_5 = level.vehicle.templates.aianims[var_0.classname_mp][var_4];
      var_6 = var_5.sittag;
      var_7 = var_0 scripts\cp\vehicles\vehicle_cp::spawn_script_model_at_pos(var_4, var_6, var_5.idle_anim, var_5.idle, var_2.driver_models);
      var_3[var_3.size] = var_7;
      level._id_14102[level._id_14102.size] = var_7;
      var_0 thread handlemeleekillrewardbullets(var_3);

      if(var_4 <= 1 && scripts\cp\utility::turn_off_sniper_laser())
        var_0 thread _id_12F4E(var_7);
    }
  }

  if(isDefined(level.vehicle_builds[var_1]) && isDefined(level.vehicle_builds[var_1].max_ai))
    var_8 = int(min(level.vehicle_builds[var_1].max_ai, var_0.usedpositions.size));
  else
    var_8 = var_0.usedpositions.size;

  if(var_0.attachedguys.size >= var_8) {
    var_0 notify("_encstr_AD890EDA035FD38854EBE77E991A46F3");
    return;
  }
}

_id_12F4E(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  var_1 = 250;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && isPlayer(var_3) && isDefined(var_2) && var_2 > 0 && isDefined(var_5)) {
      if(var_0 tagexists("_encstr_AADA07DBF19A4A81D7"))
        var_6 = var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7");
      else
        var_6 = var_0.origin + (0, 0, 50);

      var_6 = var_6 + (0, 0, -20);
      var_7 = var_3 getEye();
      var_8 = vectorNormalize(var_5 - var_7);
      var_9 = vectorNormalize(var_6 - var_7);
      var_10 = vectordot(var_8, var_9);
      var_11 = vectordot(vectorNormalize(anglesToForward(self.angles)), vectorNormalize(var_5 - self.origin));
      var_12 = var_0.origin + (0, 0, 18);

      if(var_10 > 0.99975 && var_11 > 0.73 && var_5[2] > var_12[2]) {
        var_1 = var_1 - var_2;

        if(var_1 <= 0) {
          var_3 scripts\cp\cp_achievement::scriptable_enginedamaged();
          self notify("_encstr_AD75063D571AE108", var_3);
        }
      }
    }
  }
}

_id_13B03(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_1 = getdvarint("_encstr_B4FB06AB1EBA31F3", 0);
    var_2 = getdvarint("_encstr_B6FB0693B845497F", 0);
    var_3 = getdvarint("_encstr_A6FB0693EB056133", 0);
    var_4 = scripts\cp\utility::get_point_in_local_ent_space(var_0, (var_1, var_2, var_3));
    thread scripts\engine\utility::draw_line_for_time(var_4, var_4 + (0, 0, 128), 1, 1, 1, 0.05);
    waitframe();
  }
}

handlemeleekillrewardbullets(var_0) {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] _id_12BCD();
  }
}

_id_12BCD() {
  if(scripts\engine\utility::array_contains(level._id_14102, self)) {
    level._id_14102 = scripts\engine\utility::array_remove(level._id_14102, self);

    if(isDefined(self))
      self delete();
  }
}

get_vehicle_spawn_points(var_0) {
  if(istrue(var_0.veh_model_spawner))
    return [var_0];
  else {
    var_1 = scripts\engine\utility::getStructArray(self.spawn_points, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = [];

    if(isDefined(var_0.script_linkname)) {
      for(var_3 = 0; var_3 < var_1.size; var_3++) {
        if(is_linked_struct(var_1[var_3], var_0))
          var_2[var_2.size] = var_1[var_3];
      }

      if(var_2.size < 1) {
        return scripts\engine\utility::array_randomize(var_1);
        return;
      }

      var_4 = scripts\engine\utility::random(var_2);
      return [var_4];
      return;
    } else
      return scripts\engine\utility::array_randomize(var_1);
  }
}

veh_heli_spawn(var_0, var_1, var_2) {
  var_3 = level.ai_spawn_vehicle_func[var_2];
  var_4 = var_3 get_vehicle_spawn_points(var_1);

  if(var_4.size > 0) {
    foreach(var_6 in var_4) {
      if(istrue(var_6.in_use)) {
        continue;
      }
      if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
        thread scripts\engine\utility::draw_capsule(var_6.origin, 64, 64, (0, 0, 0), (0, 1, 0), 0, 1000);

      copy_vehicle_build_to_spawnpoint(var_2, var_6);
      var_7 = vectortoangles(var_1.origin - var_6.origin);
      var_6.angles = (0, var_7[1], 0);
      var_8 = scripts\common\vehicle::vehicle_spawn(var_6);

      if(isDefined(var_8)) {
        var_8 stringtovec3(var_1, var_0, var_6, var_2);
        var_6 _id_13BB7(1);

        if(var_6 scripts\common\vehicle_code::ishelicopter_internal())
          var_8 init_helicopter(var_0, var_2);
        else {}

        var_0.vehicle = var_8;
        var_8.veh_spawn_point = var_6;
        var_8.path_gobbler = 1;
        var_1.specs = level.spawner_script_funcs[var_2].specs;
        var_1.ai_infil_type = var_2;
        var_8 thread veh_ping_vehicle_location_to_players();
        var_8 thread heli_waittill_full_or_timeout(var_2, var_0);

        if(_id_141B4(var_2) || getdvarint("_encstr_B484197F779659DBB8D3CC920B811D9265838B57D13E6296E0FB42", 0) || scripts\cp\utility::turn_off_sniper_laser())
          var_8 thread _id_135CB(var_8, var_2);

        clear_vehicle_build_to_spawnpoint(var_6);
        return 1;
      } else {
        clear_vehicle_build_to_spawnpoint(var_6);
        return 0;
      }
    }

    return 0;
  } else
    return 0;
}

stringtovec3(var_0, var_1, var_2, var_3) {
  self.load_queue = [];
  self.spawn_point = var_0;
  self.stop_all_ascend_anims = var_3;
  self.group = var_1;
  var_1.vehicle = self;
  var_0.vehicle = self;
  var_0.veh_spawn_point = var_2;
  self.veh_spawn_point = var_2;
  self.dontdisconnectpaths = 1;
  var_1._id_12A87 = 1;
  self setCanDamage(1);
  scripts\cp_mp\emp_debuff::set_start_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback);
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback);
  thread lb_impulse_dmg_threshold_top();
  var_1 thread decrement_wave_veh_count(var_3);
  self vehicle_turnengineon();
}

lb_impulse_dmg_threshold_top() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = _id_14451();

  if(isDefined(var_0) && isai(var_0)) {
    var_0.health = 500;
    var_0.maxhealth = 500;

    if(scripts\common\vehicle_code::ishelicopter_internal())
      thread lb_mg_dmg_factor_driverless_collision(var_0);
    else
      thread _id_138CE(var_0);
  }
}

lb_mg_dmg_factor_driverless_collision(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A2CE0F32B2B0D11AD766969B4B371A5946");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_81A8077D3088BFA631");
  var_0 waittill("_encstr_AD75063D571AE108", var_1, var_2, var_3, var_4);

  if(isDefined(var_1) && isPlayer(var_1))
    var_1 scripts\cp\cp_achievement::scriptable_enginedamaged();

  self notify("_encstr_AD75063D571AE108", var_1);
}

_id_138CE(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_81A8077D3088BFA631");
  var_0 waittill("_encstr_AD75063D571AE108", var_1, var_2, var_3, var_4);
  self notify("_encstr_ABAE1EDD16A3C686AF337B39AF8563B1FA075837CDAC739DB227CDF5C8AC8532");
  self stoppath(1);
  self notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
  scripts\common\vehicle::vehicle_unload();
}

_id_14451() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A9210A283BEC90BB323450EC");

  for(;;) {
    self waittill("_encstr_9AA80CCEAE97F5957347CA9CB2C8", var_0, var_1);

    if(isDefined(var_0)) {
      if(scripts\engine\utility::is_equal(self.driver, var_0))
        return var_0;
    }
  }

  return undefined;
}

_id_13BB7(var_0) {
  if(istrue(var_0))
    self.in_use = var_0;
  else
    self.in_use = undefined;
}

clear_vehicle_build_to_spawnpoint(var_0) {
  var_0.classname_mp = undefined;
  var_0.vehicletype = undefined;
  var_0.vehiclename = undefined;
}

copy_vehicle_build_to_spawnpoint(var_0, var_1) {
  if(isDefined(level.vehicle_builds) && isDefined(level.vehicle_builds[var_0])) {
    var_2 = level.vehicle_builds[var_0];

    if(isDefined(var_2.classname_mp))
      var_1.classname_mp = var_2.classname_mp;

    if(isDefined(var_2.vehicletype))
      var_1.vehicletype = var_2.vehicletype;

    if(isDefined(var_2.vehiclename))
      var_1.vehiclename = var_2.vehiclename;
  }
}

waittill_full_or_timeout(var_0, var_1) {
  self notify("_encstr_85FB196716D2EBE197A8E010671B2824B74FCAC9CBE3D3D1DFCDF3");
  self endon("_encstr_85FB196716D2EBE197A8E010671B2824B74FCAC9CBE3D3D1DFCDF3");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread decrement_vehicles_active(var_0, var_1);
  thread watch_for_all_passengers_dead(var_0, var_1);

  if(self vehicle_isphysveh()) {
    if(getdvarint("_encstr_AAB417B9369CEBB9E8E45D6C3AF56EC11BA573CAF50E858E0D", 0))
      self vehicle_cleardrivingstate();

    self.veh_brake = 1;
  }

  self waittill("_encstr_AD890EDA035FD38854EBE77E991A46F3");
  self.spawn_point scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_A9210A283BEC90BB323450EC", ::check_for_unloading_func, var_0, undefined, undefined);

  if(!isDefined(self.group._id_13959))
    self.group._id_13959 = 1;
  else
    self.group._id_13959++;

  self.group.vehicle = undefined;
  self.spawn_point.pos_override_struct = undefined;

  if(self.load_queue.size > 0) {
    thread scripts\common\vehicle::vehicle_load_ai(self.load_queue);
    scripts\engine\utility::ent_flag_wait("_encstr_92D20741F7CEB03D1B");
  } else
    wait 1;

  var_2 = create_vehicle_path(var_0);

  if(self vehicle_isphysveh())
    self.veh_brake = 0;

  self notify("_encstr_B4501B8EF829A69AF3133703633093E9D86004D5D1D16B435F3D133F59");

  if(!self vehicle_isphysveh()) {
    if(isDefined(self.target)) {
      var_3 = getvehiclenode(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      self attachpath(var_3);
      self startpath();
    } else
      self notify("_encstr_A5C016E3EDCD737EF3332A3B300DF11F3FFF9BCE900DAA9A");
  } else {
    self notify("_encstr_87DE08E656DDC158E81A");

    if(isDefined(self.target)) {
      var_3 = getvehiclenode(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(isDefined(var_3)) {
        self attachpath(var_3);
        self startpath();
        return;
      }
    }

    if(getdvarint("_encstr_AAB417B9369CEBB9E8E45D6C3AF56EC11BA573CAF50E858E0D", 0) && self.pathing_array.size >= 1) {
      self.spawn_point.vehicle = undefined;
      vehiclefollowstructpath(self.pathing_array[0], 1);
      wait 5;
    } else {
      self.spawn_point.vehicle = undefined;
      thread scripts\common\vehicle_paths::getonpath();
    }
  }
}

get_duration_between_points(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_0, var_1);

  if(istrue(var_3))
    var_4 = var_4 * 0.0568182;

  var_5 = var_4 / var_2;

  if(var_5 < 0.05)
    var_5 = 0.05;

  return var_5;
}

start_vehicle_path(var_0) {
  if(!self vehicle_isphysveh() && !isstruct(var_0)) {
    var_0 = getvehiclenode(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    self attachpath(var_0);
    self startpath();
  } else {
    self notify("_encstr_87DE08E656DDC158E81A");

    if(getdvarint("_encstr_AAB417B9369CEBB9E8E45D6C3AF56EC11BA573CAF50E858E0D", 0) && self.pathing_array.size >= 1)
      thread vehiclefollowstructpath(self.pathing_array[0]);
    else
      thread scripts\common\vehicle_paths::getonpath();
  }
}

watch_for_vehicle_stuck() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A5C016E3EDCD737EF3332A3B300DF11F3FFF9BCE900DAA9A");
  self waittill("_encstr_B4501B8EF829A69AF3133703633093E9D86004D5D1D16B435F3D133F59");
  self endon("_encstr_A9210A283BEC90BB323450EC");
  var_0 = 0;
  var_1 = 2;

  if(isDefined(self._id_13F12))
    var_1 = self._id_13F12;

  for(;;) {
    if(self issuspendedvehicle() || self vehicle_getspeed() <= 2)
      var_0 = var_0 + 0.1;
    else
      var_0 = 0;

    if(var_0 >= var_1) {
      break;
    }

    wait 0.1;
  }

  self vehicle_setspeedimmediate(0, 30, 30);
  thread scripts\common\vehicle_code::_vehicle_unload("_encstr_8B1608EC43B8D647A113");
}

heli_waittill_full_or_timeout(var_0, var_1) {
  self notify("_encstr_85FB196716D2EBE197A8E010671B2824B74FCAC9CBE3D3D1DFCDF3");
  self endon("_encstr_85FB196716D2EBE197A8E010671B2824B74FCAC9CBE3D3D1DFCDF3");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread decrement_vehicles_active(var_0, var_1);
  thread slide_trig(var_0);
  self waittill("_encstr_AD890EDA035FD38854EBE77E991A46F3");
  self.spawn_point scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  self.group.vehicle = undefined;
  scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_A9210A283BEC90BB323450EC", ::check_for_unloading_func, var_0, undefined, undefined);
  scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_BD82096B5DA4B07F924F29", ::delete_nav_obstacle, undefined, undefined, undefined);

  if(isDefined(self.spawn_point.heli_path_func))
    var_2 = self[[self.spawn_point.heli_path_func]](var_0);
  else
    var_2 = create_direct_heli_path(var_0);

  self.spawn_point.vehicle = undefined;
}

check_for_unloading_func(var_0) {
  if(isDefined(level.unloading_func[var_0]))
    self thread[[level.unloading_func[var_0]]]();
}

watch_for_all_passengers_dead(var_0, var_1) {
  self notify("_encstr_ABAE1EDD16A3C686AF337B39AF8563B1FA075837CDAC739DB227CDF5C8AC8532");
  self endon("_encstr_ABAE1EDD16A3C686AF337B39AF8563B1FA075837CDAC739DB227CDF5C8AC8532");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A9210A283BEC90BB323450EC");
  self waittill("_encstr_9AA80CCEAE97F5957347CA9CB2C8");
  self waittill("_encstr_AD890EDA035FD38854EBE77E991A46F3");

  for(;;) {
    var_2 = reflectbolt(1);

    if(var_2 <= 0) {
      delete_nav_obstacle();
      self notify("_encstr_9BEB14368171CFE2FEB66F0DE03CB293EA69A8C87645");
      self notify("_encstr_87DE08E656DDC158E81A");
      self vehicle_setspeedimmediate(0, 30, 30);
      thread hudattractionobj(var_1);
      break;
    }

    wait 0.2;
  }
}

hudattractionobj(var_0, var_1) {
  var_2 = self.riders;

  if(isDefined(var_1))
    var_2 = var_1;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isent(var_4) || isagent(var_4)) {
      continue;
    }
    var_5 = spawnStruct();
    var_5.origin = var_4.origin;
    var_5.angles = var_4.angles;
    var_5.vehicle_position = var_4.vehicle_position;
    var_5.specs = var_4.specs;

    if(isDefined(self.convoy))
      level lastteamused(self);

    var_4 _id_12BCD();
    var_6 = var_5.vehicle_position;
    var_5.vehicle_position = undefined;
    var_5.specs = "_encstr_8F270B1005542B0B6909095FE8";
    var_7 = scripts\cp\cp_modular_spawning::spawn_soldier_scripted_internal(var_0, var_5, 0, "_encstr_8F270B1005542B0B6909095FE8", undefined, 1);

    if(isDefined(var_7)) {
      var_7.forced_startingposition = var_6;

      if(istrue(self._id_13898)) {
        var_7.ignoreall = 0;
        var_7.sightmaxdistance = 2200;
        var_7 thread scripts\cp\coop_stealth::run_common_functions(var_7, 1, 1, 60, 160000);
      }

      thread scripts\common\vehicle_aianim::guy_enter(var_7);
    }

    if(isent(var_4))
      var_4 delete();
  }

  scripts\common\vehicle::vehicle_unload();
}

lastteamused(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.convoy)) {
    return;
  }
  var_0.convoy endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  var_0.convoy endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = var_0.convoy;

  if(istrue(var_1.kiosksearchradiusidealmax)) {
    var_0 thread lasttimedamagecalledout();

    while(istrue(var_1.kiosksearchradiusidealmax))
      wait 0.5;

    return;
  }

  var_2 = 28;

  if(getaiarray("_encstr_8E8405EA382B2A").size > var_2) {
    var_1.kiosksearchradiusidealmax = 1;
    scripts\cp\cp_modular_spawning::pause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");

    while(getaiarray("_encstr_8E8405EA382B2A").size > var_2)
      wait 0.5;

    var_1.kiosksearchradiusidealmax = undefined;
    var_1 notify("_encstr_952F1D6D079A9B7A35DBB918A758F0F792EB53E01F414B401CF77878A36569");
    scripts\cp\cp_modular_spawning::unpause_group_by_group_name("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  }
}

lasttimedamagecalledout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.convoy endon("_encstr_952F1D6D079A9B7A35DBB918A758F0F792EB53E01F414B401CF77878A36569");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.convoy))
    self.convoy.kiosksearchradiusidealmax = undefined;
}

slide_trig(var_0) {
  self notify("_encstr_ACAF18C3FFD5C7814C52E34BD3AFEFC0AA9F01712F77BA5BD16B");
  self endon("_encstr_ACAF18C3FFD5C7814C52E34BD3AFEFC0AA9F01712F77BA5BD16B");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_9AA80CCEAE97F5957347CA9CB2C8");
  self waittill("_encstr_AD890EDA035FD38854EBE77E991A46F3");
  thread _id_143A4(var_0);
  thread _id_143EA(var_0);
}

_id_143EA(var_0) {
  self notify("_encstr_ADC91903B69950CD6AB3D1AFCFC21940294F8E195DF52889823BCB");
  self endon("_encstr_ADC91903B69950CD6AB3D1AFCFC21940294F8E195DF52889823BCB");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8C8C1E7F21C10186E06884CF2640D99B265B3BEFAB760B7718B3BF1959E0EE32");
  self waittill("_encstr_BD82096B5DA4B07F924F29");

  if(isDefined(self.spawn_point) && isDefined(self.spawn_point.wavesv_finite_ending)) {
    if(isDefined(level.sixthsenselastvotime))
      [[level.sixthsenselastvotime]](self);

    return;
  }

  self notify("_encstr_87DE08E656DDC158E81A");
  delete_nav_obstacle();
  thread recently_spawned_vehicle(var_0);
  self notify("_encstr_8C8C1E7F21C10186E06884CF2640D99B265B3BEFAB760B7718B3BF1959E0EE32");
}

_id_143A4(var_0) {
  self notify("_encstr_AD7D1FC37659900DAAF391EFDFA25981FECE2898DF87E04BE1AFA5930FFA10B085");
  self endon("_encstr_AD7D1FC37659900DAAF391EFDFA25981FECE2898DF87E04BE1AFA5930FFA10B085");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BD82096B5DA4B07F924F29");

  for(;;) {
    var_1 = reflectbolt();
    var_2 = reflectbolt(1);
    var_3 = reflectprojectile(1);

    if(var_2 <= 0 || var_3 <= 0) {
      if(isDefined(self.spawn_point) && isDefined(self.spawn_point.wavesv_finite_ending)) {
        if(isDefined(level.sixthsenselastvotime))
          [[level.sixthsenselastvotime]](self);

        return;
      }

      thread recently_spawned_vehicle(var_0);
      self notify("_encstr_87DE08E656DDC158E81A");
      delete_nav_obstacle();
      self notify("_encstr_8C8C1E7F21C10186E06884CF2640D99B265B3BEFAB760B7718B3BF1959E0EE32");
      break;
    }

    wait 0.2;
  }
}

recently_spawned_vehicle(var_0) {
  self endon("_encstr_AD75063D571AE108");
  thread _id_11B04();
  var_1 = getgroundposition(self.origin, 1);

  if(distancesquared(self.origin, var_1) <= 2250000) {
    var_2 = spawnStruct();
    var_2.origin = var_1 + (0, 0, 1500);
    var_2.angles = self.angles;
    var_2.script_goalyaw = 1;
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_2);
    self setneargoalnotifydist(512);
    scripts\engine\utility::_id_143A5("_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_8B7205D9ED5958");
  }

  var_3 = get_best_end_point(var_0, self.spawn_point, self.angles);

  if(!isDefined(var_3))
    var_3 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].exit_points, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

  var_4 = duplicate_struct(var_3);
  var_5 = anglesToForward(vectortoangles(var_4.origin - self.origin)) * 10000;
  var_4.origin = var_4.origin + (var_5[0], var_5[1], var_4.origin[2]);
  var_4.targetname = create_unique_kvp_string();
  self.end_point = var_4;
  var_6 = var_4;

  if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
    thread scripts\engine\utility::draw_capsule(var_4.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);

  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_4);
}

_id_11B04() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  wait 2;

  if(isDefined(self.riders) && self.riders.size > 0) {
    for(var_0 = 0; var_0 < self.riders.size; var_0++)
      self.riders[var_0]._id_11E52 = 1;
  }
}

cant_get_out_num() {
  var_0 = 0;

  if(isDefined(level.vehicle.templates.aianims)) {
    if(isDefined(self.classname_mp) && isDefined(level.vehicle.templates.aianims[self.classname_mp])) {
      for(var_1 = 0; var_1 < self.riders.size; var_1++) {
        var_2 = self.riders[var_1];

        if(!isDefined(var_2.vehicle_position)) {
          continue;
        }
        var_3 = level.vehicle.templates.aianims[self.classname_mp][var_2.vehicle_position];

        if(!isDefined(var_3.getout))
          var_0++;
      }
    } else if(isDefined(level.vehicle.templates.aianims[self.classname])) {
      for(var_1 = 0; var_1 < self.riders.size; var_1++) {
        var_2 = self.riders[var_1];
        var_3 = level.vehicle.templates.aianims[self.classname][var_2.vehicle_position];

        if(!isDefined(var_3.getout))
          var_0++;
      }
    }
  }

  return var_0;
}

reflectbolt(var_0) {
  var_1 = 0;

  foreach(var_3 in self.riders) {
    if(istrue(var_0)) {
      if(isalive(var_3))
        var_1++;

      continue;
    }

    var_1++;
  }

  return var_1;
}

reflectprojectile(var_0, var_1) {
  var_2 = 0;

  if(isDefined(self.classname_mp)) {
    if(isDefined(level.vehicle) && isDefined(level.vehicle.templates) && isDefined(level.vehicle.templates.aianims) && isDefined(level.vehicle.templates.aianims[self.classname_mp])) {
      for(var_3 = 0; var_3 < self.riders.size; var_3++) {
        var_4 = self.riders[var_3];

        if(!isalive(var_4)) {
          continue;
        }
        if(!isai(var_4)) {
          continue;
        }
        if(!isDefined(var_4.vehicle_position)) {
          continue;
        }
        if(scripts\common\vehicle_aianim::check_unloadgroup(var_4.vehicle_position)) {
          var_5 = level.vehicle.templates.aianims[self.classname_mp][var_4.vehicle_position];

          if(isDefined(var_5.getout))
            var_2++;
        }
      }
    }
  }

  return var_2;
}

unload_when_near_players() {
  self endon("_encstr_81A8077D3088BFA631");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    wait 1;

    if(scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 1, 512).size) {
      if(isDefined(self.riders)) {
        for(var_0 = 0; var_0 < self.riders.size; var_0++) {
          var_1 = self.riders[var_0];
          var_1 scripts\common\utility::demeanor_override("_encstr_AA7C07466F9DA30713");
        }
      }

      break;
    }
  }
}

create_vehicle_path(var_0) {
  level notify("_encstr_8CE9148DC9CA2C1D2BF53BB2344B368D597D0E0BA31A");
  var_1 = level.next_index;
  level.next_index++;

  if(isDefined(self.spawn_point.veh_model_spawner)) {
    self.allow_unload_on_path = 1;
    var_2 = create_path_to_delete_node(var_0, var_1);
    var_3 = undefined;
    return var_2;
  } else {
    var_2 = duplicate_struct(self.veh_spawn_point);
    add_targetname_kvps(var_2, undefined, var_0 + var_1 + "_encstr_B4810709B378B9F3F5");
    self.currentnode = var_2;
    var_4 = create_simple_path(self.currentnode, self.angles, var_1, var_0, "_encstr_87AD1357C378176F20F0627ADE07CF4B20A3EEF71F", (1, 1, 0));

    if(var_4)
      return var_2;
  }

  var_3 = duplicate_struct(self.spawn_point);
  var_5 = undefined;

  if(isDefined(var_3) && isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_linkto)) {
    var_6 = self.veh_spawn_point get_veh_linked_structs();
    var_7 = -5;

    foreach(var_9 in var_6) {
      var_10 = scripts\engine\math::get_dot(self.origin, self.angles, var_9.origin);
      var_11 = scripts\engine\math::get_dot(self.origin, vectortoangles(var_3.origin - self.origin), var_9.origin);
      var_12 = var_10 + var_11;

      if(var_12 > var_7) {
        var_7 = var_12;
        var_5 = var_9;
      }
    }
  }

  if(!isDefined(var_5)) {
    var_14 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].path_start_points, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_14) || var_14.size < 1)
      var_14 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].path_start_points, "_encstr_A29D10371B275A1C47F536969BDA390BB5B2");

    if(!isDefined(var_14) || var_14.size < 1) {
      return;
    }
    var_5 = scripts\engine\utility::getclosest(self.origin, var_14);
  }

  if(!isDefined(var_5)) {
    return;
  }
  var_15 = duplicate_struct(var_5);
  var_15.angles = vectortoangles(var_15.origin - self.origin);

  if(0) {
    level thread scripts\cp\utility::draw_line_until_endons(self.spawn_point.origin, 1, 1, 1, "_encstr_8CE9148DC9CA2C1D2BF53BB2344B368D597D0E0BA31A");
    level thread scripts\cp\utility::draw_line_until_endons(var_15.origin, 0, 1, 0, "_encstr_8CE9148DC9CA2C1D2BF53BB2344B368D597D0E0BA31A");
    level thread scripts\cp\utility::draw_line_until_endons(var_3.origin, 1, 1, 0, "_encstr_8CE9148DC9CA2C1D2BF53BB2344B368D597D0E0BA31A");
  }

  add_targetname_kvps(var_15, undefined, var_0 + var_1 + "_encstr_B4810709B378B9F3F5");
  create_path_from_struct_to_struct(var_15, var_3, var_1, var_0, "_encstr_8CB611F5AEE61BED0B91D71C0BA3D04B37B3EB", (1, 1, 1));
  scripts\engine\utility::thread_on_notify("_encstr_BD82096B5DA4B07F924F29", ::create_path_to_delete_node, var_0, var_1, self);
  scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", ::reset_spawn_point_targetname, self.spawn_point, undefined, self);
  self.disabled_nodes = undefined;
  return var_15;
}

create_path_to_delete_node(var_0, var_1) {
  var_2 = self.spawn_point;
  self.currentnode = var_2;
  var_3 = create_simple_path(self.currentnode, self.angles, var_1, var_0, "_encstr_87AD1357C378176F20F0627ADE07CF4B20A3EEF71F", (1, 1, 0));

  if(!var_3) {
    var_4 = get_best_end_point(var_0, self.currentnode);
    var_5 = duplicate_struct(var_4);
    self.path_gobbler = 1;
    self.end_point = var_5;

    if(0)
      level thread scripts\cp\utility::draw_line_until_endons(var_5.origin, 1, 0, 0, "_encstr_8CE9148DC9CA2C1D2BF53BB2344B368D597D0E0BA31A");

    create_path_from_struct_to_struct(self.currentnode, var_5, var_1, var_0, "_encstr_87AD1357C378176F20F0627ADE07CF4B20A3EEF71F", (1, 1, 0));
  }

  if(scripts\engine\math::is_point_in_front(self.currentnode.origin) || self.spawn_point.origin == self.currentnode.origin)
    self.target = self.pathing_array[1].targetname;
  else if(!var_3)
    self.target = self.pathing_array[1].targetname;
  else
    self.pathing_array = scripts\engine\utility::array_remove_index(self.pathing_array, 0);

  self.disabled_nodes = undefined;
  return self.currentnode;
}

start_struct_path(var_0, var_1) {
  self notify("_encstr_AB8312932B1763B3495FB4BA3BC0FB8FC7215BAA");
  self endon("_encstr_AB8312932B1763B3495FB4BA3BC0FB8FC7215BAA");
  self endon("_encstr_AD75063D571AE108");
  self startpathnodes(var_0, var_1, 0, 0.5, 0.5, 1);
  var_2 = 1;
  var_3 = self.pathing_array[var_2];
  var_4 = self.pathing_array[var_2];
  var_5 = 62500;

  if(!isDefined(var_3)) {
    return;
  }
  thread process_nextpoint_after_struct_wait(var_3, var_5);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_6, var_7, var_8, var_9);

    if(isint(var_6)) {
      if(var_2 < var_6 + 1) {
        var_2 = var_6 + 1;
        var_3 = get_next_node_on_spline(var_2);

        if(isDefined(var_3)) {
          var_4 = var_3;
          thread process_nextpoint_after_struct_wait(var_3, var_5);
          continue;
        }

        break;
      }
    }
  }
}

_id_14205(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A27322B3B21A2D8D8D59F5389CB7D82BE6DC7D73DB46B2AF77A159E6BEB0E8F53BF616B1");
  self endon("_encstr_A27322B3B21A2D8D8D59F5389CB7D82BE6DC7D73DB46B2AF77A159E6BEB0E8F53BF616B1");
  var_1 = 12500;
  var_2 = 1;
  var_3 = self.pathing_array[var_2];
  var_4 = self.pathing_array[var_2];
  level._id_1421F = self;

  if(istrue(var_0))
    thread process_nextpoint_after_struct_wait(var_3, var_1);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_5, var_6, var_7, var_8);

    if(isint(var_5)) {
      if(var_2 < var_5 + 1) {
        if(isDefined(self.path_gobbler))
          scripts\engine\utility::deletestruct_ref(var_3);

        var_2 = var_5 + 1;
        var_3 = get_next_node_on_spline(var_2);

        if(isDefined(var_3)) {
          var_4 = var_3;
          self notify("_encstr_B1360F85CF2BF0100D70FB969AFFD090F3");

          if(istrue(var_0))
            thread process_nextpoint_after_struct_wait(var_3, var_1);

          continue;
        }

        break;
      }
    }
  }
}

process_nextpoint_after_struct_wait(var_0, var_1) {
  self notify("_encstr_A9D724B31B089B60DAFAB1FD812BED198F695D1196D3C5C1BD9259733B2DA337FCAEEF804301");
  self endon("_encstr_A9D724B31B089B60DAFAB1FD812BED198F695D1196D3C5C1BD9259733B2DA337FCAEEF804301");
  self endon("_encstr_AD75063D571AE108");

  while(distancesquared(self.origin, var_0.origin) > var_1)
    wait 0.1;

  process_vehicle_struct_node(var_0);
}

process_vehicle_struct_node(var_0) {
  self endon("_encstr_87DE08E656DDC158E81A");
  self endon("_encstr_AD75063D571AE108");
  var_1 = scripts\common\vehicle_paths::get_path_getfunc(var_0);
  var_2 = undefined;
  self.currentnode = var_0;
  scripts\common\vehicle_paths::trigger_process_node(var_0);

  if(scripts\common\vehicle_paths::vehicle_should_unload(scripts\common\vehicle_paths::node_wait, var_0)) {
    self vehicle_setspeedimmediate(0, 1, 1);
    struct_path_unload_node(var_0);
    wait 0.25;

    if(!isDefined(self.riders) || self.riders.size < 1) {
      self notify("_encstr_A27322B3B21A2D8D8D59F5389CB7D82BE6DC7D73DB46B2AF77A159E6BEB0E8F53BF616B1");
      self notify("_encstr_B241116EE8B7077D33ED8D36DB77F507588E1A");
      return;
    }

    self resumespeed(20);
  }
}

struct_path_unload_node(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.ent_flag["_encstr_A3390CC953678907D5E091908E03"]) && scripts\engine\utility::ent_flag("_encstr_A3390CC953678907D5E091908E03")) {
    return;
  }
  if(!isDefined(var_0.script_flag_wait) && !isDefined(var_0.script_delay)) {}

  var_1 = getnode(var_0.targetname, "_encstr_A16007A921A23B85E3");

  if(isDefined(var_1) && self.riders.size) {
    foreach(var_3 in self.riders) {
      if(isai(var_3))
        var_3 thread scripts\engine\utility::script_func("_encstr_858C0B87DD37999FE988907487", var_1);
    }
  }

  if(scripts\common\vehicle_code::ishelicopter_internal()) {
    self sethoverparams(0, 0, 0);
    scripts\common\vehicle_code::waittill_stable(var_0);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "_encstr_92480EEB904B8BEF4130F2275CE8DF97")
      scripts\engine\utility::flag_wait(var_0.script_flag);
  }

  if(isDefined(var_0.script_unload)) {
    if(var_0.script_unload == "_encstr_A34C02BB")
      var_0.script_unload = "_encstr_8B1608EC43B8D647A113";
  }

  scripts\common\vehicle_code::_vehicle_unload(var_0.script_unload);

  if(scripts\common\vehicle_aianim::riders_unloadable(var_0.script_unload))
    self waittill("_encstr_BD82096B5DA4B07F924F29");

  if(isDefined(var_0.script_flag_wait) || isDefined(var_0.script_delay))
    return;
}

get_next_node_on_spline(var_0) {
  if(!isDefined(var_0))
    return undefined;
  else if(!isDefined(self.pathing_array))
    return undefined;
  else if(isDefined(self.pathing_array[var_0]))
    return self.pathing_array[var_0];
  else
    return undefined;
}

create_simple_path(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_6 = 1;
  var_7 = var_0;
  var_8 = -0.3;
  self.pathing_array = [var_0];

  if(0) {
    level.players[0] notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_97410B23BD6B976233901AF2F8");
    level.players[0] notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_B4C60AD707B2BDC0E6CE1309");
  }

  if(isDefined(var_7.script_linkto)) {
    var_9 = duplicate_struct(var_7);
    add_targetname_kvps(var_9, undefined, var_3 + var_2 + "_encstr_B4810709B378B9F3F5");
    self.currentnode = var_9;
    var_7 = self.currentnode;
  }

  for(;;) {
    if(0)
      level.players[0] waittill("_encstr_AB19049D0FC0");

    if(isDefined(var_7.script_linkto)) {
      var_10 = var_7 get_veh_linked_structs();
      var_11 = [];
      var_12 = -1;
      var_13 = undefined;

      if(var_10.size == 1)
        var_11[var_11.size] = var_10[0];
      else {
        for(var_14 = 0; var_14 < var_10.size; var_14++) {
          var_15 = var_10[var_14];

          if(!isDefined(var_13))
            var_13 = var_15;

          var_16 = scripts\engine\math::get_dot(var_7.origin, var_1, var_15.origin);

          if(var_16 >= var_8)
            var_11[var_11.size] = var_15;
        }
      }

      if(var_11.size < 1 && isDefined(var_13))
        var_11[var_11.size] = var_13;

      if(var_11.size > 0) {
        var_17 = scripts\engine\utility::random(var_11);
        var_17 = duplicate_struct(var_17);
        self.path_gobbler = 1;
        self.pathing_array[self.pathing_array.size] = var_17;
        add_targetname_kvps(var_17, var_7, var_3 + "_encstr_BA4C02DF" + var_2 + "_encstr_97270EBF07A8BD2BD9590903212D83F9" + self.pathing_array.size);

        if(0)
          level thread scripts\cp\utility::draw_line_until_endons(var_7.origin, 1, 1, 1, "_encstr_8CE9148DC9CA2C1D2BF53BB2344B368D597D0E0BA31A", var_17.origin);

        var_7 = var_17;
      } else
        break;
    } else if(isDefined(var_7.target)) {
      var_10 = var_7 scripts\engine\utility::get_target_array();
      var_11 = [];
      var_12 = -1;
      var_13 = undefined;

      for(var_14 = 0; var_14 < var_10.size; var_14++) {
        var_15 = var_10[var_14];
        var_16 = scripts\engine\math::get_dot(var_7.origin, var_1, var_15.origin);

        if(var_16 >= var_8) {
          var_11[var_11.size] = var_15;
          continue;
        }

        if(var_16 >= var_12)
          var_13 = var_10[var_14];
      }

      if(var_11.size < 1 && isDefined(var_13))
        var_11[var_11.size] = var_13;

      if(var_11.size > 0) {
        var_17 = scripts\engine\utility::random(var_11);

        if(scripts\engine\utility::array_contains(self.pathing_array, var_17)) {
          self.pathing_array[self.pathing_array.size] = var_17;
          self._id_119E3 = 1;
          break;
        }

        self.pathing_array[self.pathing_array.size] = var_17;

        if(0)
          level thread scripts\cp\utility::draw_line_until_endons(var_7.origin, 1, 1, 1, "_encstr_8CE9148DC9CA2C1D2BF53BB2344B368D597D0E0BA31A", var_17.origin);

        var_7 = var_17;
      } else
        break;
    } else
      break;
  }

  if(self.pathing_array.size > 27)
    split_large_pathing_array();

  if(self.pathing_array.size < 1)
    return 0;
  else
    return 1;
}

split_large_pathing_array() {
  self.pathing_arrays = [];
  var_0 = [];
  var_1 = undefined;

  for(var_2 = 0; var_2 < self.pathing_array.size; var_2++) {
    var_0[var_0.size] = self.pathing_array[var_2];
    var_1 = self.pathing_array[var_2];

    if(var_2 > 0 && var_2 % 27 == 0) {
      self.pathing_arrays[self.pathing_arrays.size] = var_0;
      var_0 = [];
      var_0[0] = var_1;
    }
  }

  if(var_0.size == 1) {
    var_3 = spawnStruct();
    var_3.origin = (var_0[0].origin + var_1.origin) / 2;
    var_0[var_0.size] = var_0[0];
    var_0[0] = var_3;
  }

  if(var_0.size > 0)
    self.pathing_arrays[self.pathing_arrays.size] = var_0;
}

create_path_from_struct_to_struct(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_6 = var_0;
  var_6.angles = self.angles;
  var_7 = undefined;
  var_8 = 1;
  var_9 = 0;
  var_0.pathing_index = 0;

  if(isDefined(self.disabled_nodes))
    self.disabled_nodes = undefined;

  if(isDefined(self.pathing_array)) {
    foreach(var_11 in self.pathing_array) {
      if(isDefined(var_11)) {
        var_11.previous_struct = undefined;
        var_11.antepenultimate_struct = undefined;
      }
    }
  }

  self.pathing_array = [var_0];

  if(0) {
    announcement("_encstr_AB3B179BFF8313319058EAEB7BCBB09B7107988FDEB95B5399");
    level.players[0] notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_97410B23BD6B976233901AF2F8");
    level.players[0] notifyonplayercommand("_encstr_AB19049D0FC0", "_encstr_B4C60AD707B2BDC0E6CE1309");
  }

  for(;;) {
    if(0)
      level.players[0] waittill("_encstr_AB19049D0FC0");

    var_6 = find_closest_path_struct(var_6, var_1, var_3 + var_2 + var_4 + var_9, var_5, var_3);

    if(isDefined(var_6)) {
      if(!isDefined(var_6.pathing_index)) {
        var_6.pathing_index = self.pathing_array.size;
        self.pathing_array[self.pathing_array.size] = var_6;

        if(0) {
          if(isDefined(var_6.previous_struct))
            level thread scripts\cp\utility::draw_line_until_endons(var_6.previous_struct.origin, var_5[0], var_5[1], var_5[2], ["_encstr_8CE9148DC9CA2C1D2BF53BB2344B368D597D0E0BA31A", "_encstr_91140CAD2D8DC6BE919589D5D9EB" + var_6.pathing_index], var_6.origin);
        }
      }

      if(var_6.origin == var_1.origin) {
        break;
      }
    } else
      break;

    if(var_9 > 1000) {
      self notify("_encstr_9A8213AA4F2F5178E791EFA801B3CB8F030597BD99");
      break;
    }

    var_9++;
  }

  for(var_13 = 0; var_13 < self.pathing_array.size - 1; var_13++)
    self.pathing_array[var_13].target = self.pathing_array[var_13 + 1].targetname;

  if(self.pathing_array.size > 27)
    split_large_pathing_array();
}

find_closest_path_struct(var_0, var_1, var_2, var_3, var_4) {
  self notify("_encstr_BECD19DFF3950A0F3938DFA75813FC61411FA3D47017436A83588B");

  if(0)
    level thread scripts\cp\utility::drawsphere(var_0.origin, 24, 1, (1, 1, 1));

  var_5 = undefined;
  var_6 = sortbydistance(var_0 get_veh_linked_structs(), var_1.origin);

  if(var_6.size < 1) {
    var_7 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_4].path_start_points, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_7) || var_7.size < 1)
      var_7 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_4].path_start_points, "_encstr_A29D10371B275A1C47F536969BDA390BB5B2");

    if(!isDefined(var_7) || var_7.size < 1) {
      return;
    }
    var_8 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_7, [var_0], 3);

    foreach(var_10 in var_8) {
      var_6[var_6.size] = var_10;
      var_6 = scripts\engine\utility::array_combine(var_6, sortbydistance(var_10 get_veh_linked_structs(), var_10.origin));
    }
  }

  var_12 = [];
  var_13 = -5;
  var_14 = 20000;
  var_15 = -5;
  var_16 = undefined;
  var_17 = 0;

  foreach(var_10 in var_6) {
    var_19 = var_10;

    foreach(var_21 in self.pathing_array) {
      if(istrue(var_21.disabled) || var_10.origin == var_21.origin) {
        var_19 = undefined;
        break;
      }
    }

    if(isDefined(var_19))
      var_12[var_12.size] = var_19;
  }

  var_0.rewinding_path = undefined;

  if(var_12.size > 1) {
    if(istrue(0)) {}

    self.pathing_array[self.pathing_array.size - 1].was_branch = 1;
  }

  if(is_linked_struct(var_0, var_1))
    var_5 = var_1;
  else if(var_12.size > 0) {
    if(istrue(0)) {
      foreach(var_25 in var_12) {}
    }

    var_5 = calc_best_closest_struct(var_0, var_1, var_12);
  }

  if(!isDefined(var_5) && isDefined(var_16))
    var_5 = var_16;

  if(isDefined(var_5)) {
    var_5.angles = vectortoangles(var_5.origin - var_0.origin);

    if(var_5.origin != var_1.origin)
      var_5 = duplicate_struct(var_5);

    var_5.previous_struct = var_0;

    if(isDefined(var_0.previous_struct))
      var_5.antepenultimate_struct = var_0.previous_struct;

    add_targetname_kvps(var_5, var_0, var_2);
    return var_5;
  }

  if(!isDefined(var_5)) {
    var_5 = step_back_to_last_good_branch(var_0, var_1);

    if(isDefined(var_5))
      add_targetname_kvps(var_5, var_0, var_2);
  }

  return var_5;
}

is_linked_struct(var_0, var_1) {
  if(isDefined(var_0.script_linkto) && isDefined(var_1.script_linkname)) {
    var_2 = var_0 scripts\engine\utility::get_links();

    foreach(var_4 in var_2) {
      if(var_1.script_linkname == var_4)
        return 1;
    }
  }

  return 0;
}

print_debug_info(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_5);
  self endon("_encstr_AD75063D571AE108");
  var_6 = istrue(self.pathing_array[self.pathing_array.size - 1].was_branch);

  for(;;)
    waitframe();
}

get_veh_linked_structs() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = scripts\engine\utility::getStructArray(var_1[var_2], "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

      if(var_3.size > 0)
        var_0 = scripts\engine\utility::array_combine(var_0, var_3);
    }
  }

  return var_0;
}

calc_best_closest_struct(var_0, var_1, var_2) {
  var_3 = 1000000;
  var_4 = 360;
  var_5 = -50;
  var_6 = undefined;
  var_7 = 0.5;

  for(var_8 = 0; var_8 < var_2.size; var_8++) {
    if(var_2[var_8].origin == var_0.origin)
      var_0 = var_0.previous_struct;
  }

  var_9 = -5;
  var_10 = distance(var_1.origin, var_0.origin);

  foreach(var_12 in var_2) {
    var_13 = 5;
    var_14 = 5;
    var_15 = 0;
    var_16 = undefined;
    var_17 = -5;

    if(var_12 == var_0) {
      continue;
    }
    if(var_12.origin == var_0.origin) {
      continue;
    }
    if(isDefined(var_0.previous_struct) && var_0.previous_struct.origin == var_12.origin) {
      continue;
    }
    if(isDefined(var_0.antepenultimate_struct) && var_0.antepenultimate_struct.origin == var_12.origin) {
      continue;
    }
    if(isDefined(var_12.script_noteworthy) && var_12.script_noteworthy == "_encstr_970D094917423528F5CD31" && var_12.origin != var_1.origin) {
      continue;
    }
    if(!istrue(self.allow_unload_on_path) && isDefined(var_12.script_unload) && var_12.origin != var_1.origin) {
      continue;
    }
    if(istrue(var_12.disabled)) {
      continue;
    }
    if(check_all_previous_in_pathing(var_12, 30)) {
      continue;
    }
    if(istrue(struct_is_personally_disabled(var_12))) {
      continue;
    }
    var_18 = distance(var_0.origin, var_12.origin);

    if(var_12.origin == var_1.origin && var_18 > 1250) {
      continue;
    }
    var_18 = distance(var_1.origin, var_12.origin);
    var_19 = vectortoangles(var_1.origin - var_0.origin);

    if(!isDefined(var_0.angles))
      var_0.angles = (0, 0, 0);

    var_20 = scripts\engine\math::get_dot(var_0.origin, var_0.angles, var_12.origin);
    var_20 = scripts\engine\math::normalize_value(-0.5, 0.8, var_20);
    var_21 = scripts\engine\math::get_dot(var_0.origin, var_19, var_12.origin);
    var_21 = scripts\engine\math::normalize_value(-0.8, 0.8, var_21);
    var_22 = scripts\engine\math::normalize_value(0, 2000, var_18);
    var_22 = 1 - var_22;
    var_17 = var_20 + var_21 + var_22;

    if(var_20 < 0.25)
      var_17 = var_17 - 10;

    if(0)
      thread print_debug_info(var_12, var_21, var_20, var_18, var_17, "_encstr_BECD19DFF3950A0F3938DFA75813FC61411FA3D47017436A83588B");

    if(var_17 > var_5) {
      var_6 = var_12;
      var_5 = var_17;
    }
  }

  if(!isDefined(var_6)) {}

  return var_6;
}

get_best_end_point(var_0, var_1, var_2) {
  if(isDefined(var_1.script_linkto)) {
    var_3 = var_1 get_veh_linked_structs();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(scripts\engine\utility::is_equal(level.ai_spawn_vehicle_func[var_0].exit_points, var_3[var_4].targetname))
        return var_3[var_4];
    }
  }

  var_5 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].exit_points, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = -5;
  var_7 = undefined;
  var_8 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_5, [var_1]);

  if(isDefined(var_1.angles))
    var_2 = var_1.angles;

  foreach(var_10 in var_8) {
    var_11 = scripts\engine\math::get_dot(var_1.origin, var_2, var_10.origin);

    if(var_11 > var_6) {
      if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
        thread scripts\engine\utility::draw_capsule(var_10.origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);

      var_6 = var_11;
      var_7 = var_10;
    }
  }

  return var_7;
}

check_all_previous_in_pathing(var_0, var_1) {
  if(!isDefined(self.pathing_array))
    return 0;

  if(!isDefined(var_1))
    var_1 = self.pathing_array.size;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(isDefined(self.pathing_array[var_2]) && self.pathing_array[var_2].origin == var_0.origin)
      return 1;
  }

  return 0;
}

struct_is_personally_disabled(var_0) {
  if(!isDefined(self.disabled_nodes))
    return 0;

  for(var_1 = self.disabled_nodes.size - 1; var_1 >= 0; var_1--) {
    if(self.disabled_nodes[var_1].origin == var_0.origin)
      return 1;
  }

  return 0;
}

step_back_to_last_good_branch(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = [];
  var_5 = 0;

  for(var_6 = self.pathing_array.size - 1; var_6 >= 0; var_6--) {
    if(var_5 > 0) {
      break;
    }

    if(istrue(self.pathing_array[var_6].was_branch)) {
      var_7 = self.pathing_array[var_6] get_veh_linked_structs();

      for(var_8 = 0; var_8 < var_7.size; var_8++) {
        if(is_this_a_valid_node(var_7[var_8]))
          var_4[var_4.size] = var_7[var_8];
      }

      if(var_4.size > 0) {
        if(var_4.size == 1)
          var_9 = var_4[0];
        else
          var_9 = calc_best_closest_struct(var_0, var_1, var_4);

        var_5 = var_6;
        var_3 = var_9;

        if(istrue(0)) {}

        break;
      } else
        disable_this_node_for_us(self.pathing_array[var_6]);

      continue;
    }

    disable_this_node_for_us(self.pathing_array[var_6]);
  }

  if(isDefined(var_0.previous_struct)) {
    if(isDefined(var_3)) {
      var_2 = var_3;

      if(isDefined(self.pathing_array[var_5 - 1]))
        var_2.previous_struct = self.pathing_array[var_5 - 1];

      if(isDefined(self.pathing_array[var_5 - 2]))
        var_2.antepenultimate_struct = self.pathing_array[var_5 - 2];
    } else
      var_2 = self.pathing_array[0];

    if(isDefined(var_2))
      var_2.rewinding_path = 1;
  }

  if(!isDefined(var_2)) {}

  return var_2;
}

is_this_a_valid_node(var_0) {
  if(istrue(var_0.disabled))
    return 0;

  for(var_1 = self.pathing_array.size - 1; var_1 >= 0; var_1--) {
    if(self.pathing_array[var_1].origin == var_0.origin)
      return 0;
  }

  for(var_1 = self.disabled_nodes.size - 1; var_1 >= 0; var_1--) {
    if(self.disabled_nodes[var_1].origin == var_0.origin)
      return 0;
  }

  return 1;
}

disable_this_node_for_us(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self.disabled_nodes))
    self.disabled_nodes = [];

  if(scripts\engine\utility::array_contains(self.disabled_nodes, var_0)) {
    return;
  }
  self.disabled_nodes[self.disabled_nodes.size] = var_0;

  if(istrue(0)) {}

  level notify("_encstr_91140CAD2D8DC6BE919589D5D9EB" + var_0.pathing_index);
  self.pathing_array = scripts\engine\utility::array_remove(self.pathing_array, var_0);
}

create_direct_heli_path(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = create_direct_path_from_landing_point(var_0);
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_1);
}

binding(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_2 + 1;

    if(isDefined(var_0[var_3])) {
      var_4 = vectortoangles(var_0[var_3].origin - var_0[var_2].origin);
      var_0[var_2].angles = (0, var_4[1], 0);
      continue;
    }

    var_4 = vectortoangles(var_1.origin - var_0[var_2].origin);
    var_0[var_2].angles = (0, var_4[1], 0);

    if(!isDefined(var_1.angles) || var_1.angles == (0, 0, 0))
      var_1.angles = (0, var_4[1], 0);

    break;
  }
}

create_direct_path_from_landing_point(var_0) {
  var_1 = create_unique_kvp_string();
  var_2 = var_1;
  var_3 = duplicate_struct(self.spawn_point);
  var_3.targetname = var_1;
  scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_3.targetname, var_3);
  var_4 = [];

  if(isDefined(var_3.script_linkto))
    var_4 = var_3 build_path_from_script_linkTo(var_0);

  if(var_4.size > 0) {
    binding(var_4, var_3);
    var_5 = self.spawn_point.origin;

    for(var_6 = 0; var_6 < self.riders.size; var_6++) {
      if(isalive(self.riders[var_6]) && isai(self.riders[var_6]))
        self.riders[var_6] scripts\cp\cp_modular_spawning::set_goal_pos(var_5);
    }

    if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
      thread scripts\engine\utility::draw_line_for_time(self.veh_spawn_point.origin, var_4[0].origin, 1, 1, 1, 60);

    return var_4[0];
  }

  if(isDefined(var_3.script_linkname)) {
    var_7 = [];
    var_8 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].path_start_points, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

    if(!isDefined(var_8) || var_8.size < 1)
      var_8 = scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].path_start_points, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(!isDefined(var_8) || var_8.size < 1) {
      return;
    }
    var_9 = var_3.script_linkname;

    for(var_6 = 0; var_6 < var_8.size; var_6++) {
      if(scripts\engine\utility::is_equal(var_8[var_6].script_linkto, var_9)) {
        var_10 = [];
        var_11 = duplicate_struct(var_8[var_6]);
        var_11.target = var_2;
        scripts\cp\utility::addtostructarray("_encstr_A16007A921A23B85E3", var_2, var_11);
        var_11.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_11.targetname, var_11);
        var_10 = var_11 get_linkto_structs_return_to_array(var_10, var_8);

        if(var_10.size > 0)
          var_7[var_7.size] = var_10;
      }
    }

    if(var_7.size > 0) {
      var_12 = [];

      for(var_6 = 0; var_6 < var_7.size; var_6++) {
        thread cleanup_unused_paths(var_7[var_6], var_7[var_6][var_7[var_6].size - 1]);
        var_12[var_12.size] = var_7[var_6][var_7[var_6].size - 1];

        if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
          thread scripts\engine\utility::draw_capsule(var_7[var_6][var_7[var_6].size - 1].origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
      }

      var_13 = scripts\engine\math::get_mid_point(var_3.origin, self.origin);

      if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0)) {
        thread scripts\engine\utility::draw_capsule(self.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread scripts\engine\utility::draw_capsule(self.spawn_point.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
        thread scripts\engine\utility::draw_capsule(var_13, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);
      }

      var_14 = scripts\engine\utility::getclosest(var_13, var_12);

      if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
        thread scripts\engine\utility::draw_line_for_time(var_14.origin, self.origin, 1, 0, 0, 10);

      if(isDefined(var_14.target)) {
        var_15 = var_14 scripts\engine\utility::get_target_array();

        for(var_6 = 0; var_6 < var_15.size; var_6++) {
          if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0)) {
            thread scripts\engine\utility::draw_line_for_time(var_14.origin, var_15[var_6].origin, 1, 0, 0, 12.5);
            thread scripts\engine\utility::draw_capsule(var_15[var_6].origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
          }

          if(var_6 >= var_15.size - 1) {
            if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
              thread scripts\engine\utility::draw_line_for_time(var_3.origin, var_15[var_6].origin, 1, 0, 0, 12.5);
          }
        }
      }

      if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
        thread scripts\engine\utility::draw_capsule(var_14.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);

      var_14 notify("_encstr_92640CC0525B99A6DF30E8DE15C3");
      self notify("_encstr_92640CC0525B99A6DF30E8DE15C3");
      return var_14;
      return;
    }

    var_7 = [];
    var_14 = create_entrance_points(var_3);

    if(isDefined(var_14)) {
      var_14.target = var_2;
      scripts\cp\utility::addtostructarray("_encstr_A16007A921A23B85E3", var_2, var_14);
      var_14.targetname = create_unique_kvp_string();
      scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_14.targetname, var_14);

      if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0)) {
        thread scripts\engine\utility::draw_capsule(var_14.origin, 32, 32, (0, 0, 0), (0, 1, 1), 0, 250);
        thread scripts\engine\utility::draw_capsule(var_3.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
      }

      return var_14;
      return;
    }

    return var_3;
    return;
    return;
  } else
    return var_3;
}

brjugg_initexternalfeatures(var_0) {
  if(isDefined(level.vehicle_builds[var_0]))
    return istrue(level.vehicle_builds[var_0].brjugg_initfeatures);
  else
    return 0;
}

build_path_from_script_linkTo(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::get_links();
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];
    var_6 = scripts\engine\utility::getStructArray(var_5, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

    if(isDefined(var_6) && var_6.size > 0) {
      var_6 = scripts\engine\utility::array_randomize(var_6);

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];

        if(scripts\engine\utility::is_equal(var_8.targetname, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2")) {
          continue;
        }
        if(!brjugg_initexternalfeatures(var_0)) {
          if(scripts\engine\utility::is_equal(var_8.script_noteworthy, "_encstr_970D094917423528F5CD31"))
            continue;
        }

        var_8 = duplicate_struct(var_8);
        var_1[var_1.size] = var_8;
        var_8.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_8.targetname, var_8);

        if(isDefined(var_3)) {
          if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
            thread scripts\engine\utility::draw_line_for_time(var_3.origin, var_8.origin, 1, 1, 1, 60);

          var_3.target = var_8.targetname;
          scripts\cp\utility::addtostructarray("_encstr_A16007A921A23B85E3", var_3.target, var_3);
        }

        var_3 = var_8;
        break;
      }
    }
  }

  if(var_1.size > 0) {
    var_1[var_1.size - 1].target = self.targetname;
    scripts\cp\utility::addtostructarray("_encstr_A16007A921A23B85E3", var_1[var_1.size - 1].target, var_1[var_1.size - 1]);

    if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
      thread scripts\engine\utility::draw_line_for_time(var_1[var_1.size - 1].origin, self.origin, 1, 1, 1, 60);
  }

  return var_1;
}

create_entrance_points(var_0) {
  var_1 = [];
  var_2 = var_0.origin;

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (1500, 0, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (1500, 0, 1500);
    var_1[var_1.size] = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (-1500, 0, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (-1500, 0, 1500);
    var_1[var_1.size] = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (0, -1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (0, -1500, 1500);
    var_1[var_1.size] = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (0, 1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (0, 1500, 1500);
    var_1[var_1.size] = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (-1500, 1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (-1500, 1500, 1500);
    var_1[var_1.size] = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (-1500, -1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (-1500, -1500, 1500);
    var_1[var_1.size] = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (1500, -1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (1500, -1500, 1500);
    var_1[var_1.size] = var_3;
  }

  if(scripts\engine\trace::capsule_trace_passed(var_2 + (1500, 1500, 1500), var_2, 256, 512, (0, 0, 0), level.characters)) {
    var_3 = spawnStruct();
    var_3.origin = var_2 + (1500, 1500, 1500);
    var_1[var_1.size] = var_3;
  }

  var_4 = scripts\engine\math::get_mid_point(var_0.origin, self.origin);

  if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
    thread scripts\engine\utility::draw_capsule(var_4, 32, 32, (0, 0, 0), (1, 1, 0), 0, 250);

  var_5 = scripts\engine\utility::getclosest(var_4, var_1);

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    if(var_1[var_6] != var_5) {
      if(getdvarint("_encstr_87DF1B3736C97D19D29CACD8E87DD02B3696FA07581D0DFA912BC4BA9D", 0))
        thread scripts\engine\utility::draw_capsule(var_1[var_6].origin, 32, 32, (0, 0, 0), (1, 0, 0), 0, 250);
    }
  }

  return var_5;
}

get_linkto_structs_return_to_array(var_0, var_1) {
  var_0[var_0.size] = self;

  if(isDefined(self.script_linkname)) {
    var_2 = self.script_linkname;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3].origin == self.origin) {
        continue;
      }
      if(scripts\engine\utility::is_equal(var_1[var_3].script_linkto, var_2)) {
        var_4 = duplicate_struct(var_1[var_3]);
        var_4.target = self.targetname;
        scripts\cp\utility::addtostructarray("_encstr_A16007A921A23B85E3", var_4.target, var_4);
        var_4.targetname = create_unique_kvp_string();
        scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4.targetname, var_4);
        var_0[var_0.size] = var_4;
        var_0 = var_4 get_linkto_structs_return_to_array(var_0, var_1);
      }
    }
  }

  return var_0;
}

cleanup_unused_paths(var_0, var_1) {
  var_1 endon("_encstr_92640CC0525B99A6DF30E8DE15C3");
  self waittill("_encstr_92640CC0525B99A6DF30E8DE15C3");

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    scripts\engine\utility::deletestruct_ref(var_0[var_2]);
}

create_heli_path(var_0) {
  self.veh_path = [];
  var_1 = level.next_index;
  level.next_index++;
  var_2 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_0].exit_points, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_3 = duplicate_struct(var_2);
  self.end_point = var_3;
  thread begin_searching_for_landing_loc(undefined, var_0, var_1);
  scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", ::reset_spawn_point_targetname, self.spawn_point, undefined, self);
}

begin_searching_for_landing_loc(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A9452053AB714BA5A1380582D3C9CBD41008CFB12A950FF5288E717A06DFDF9005B2");
  self endon("_encstr_A9452053AB714BA5A1380582D3C9CBD41008CFB12A950FF5288E717A06DFDF9005B2");
  self endon("_encstr_9BEB14368171CFE2FEB66F0DE03CB293EA69A8C87645");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = scripts\cp\utility::get_array_of_valid_players();

    if(!var_7.size) {
      wait 1;
      continue;
    }

    var_8 = scripts\cp\utility::get_center_point_of_array(var_7);

    if(!isDefined(var_8))
      var_8 = self.origin;

    if(isDefined(self.spawn_point)) {
      if(isDefined(self.spawn_point)) {}

      var_9 = [self.spawn_point];
    } else
      var_9 = sortbydistance(level.valid_air_vehicle_spawn_points, var_8);

    var_3 = undefined;
    var_10 = 2048;

    for(var_11 = 0; var_11 < var_9.size; var_11++) {
      var_12 = var_9[var_11];

      if(isDefined(var_12.radius) && var_12.radius > var_10)
        var_10 = int(var_12.radius);

      if(distance2dsquared(var_12.origin, var_8) <= var_10 * var_10) {
        var_3 = var_12;
        break;
      }
    }

    if(isDefined(var_3)) {
      var_10 = 2048;

      if(isDefined(var_3.radius) && var_3.radius > var_10)
        var_10 = int(var_3.radius);

      if(distance2dsquared(var_3.origin, self.origin) <= var_10 * var_10) {
        level.valid_air_vehicle_spawn_points = scripts\engine\utility::array_remove(level.valid_air_vehicle_spawn_points, var_3);
        var_4 = duplicate_struct(var_3);

        if(!isDefined(var_3.script_noteworthy))
          var_4.targetname = "_encstr_8C3411B04EE45A9D56327DB0E8EB37DB32B2BE" + var_2;
        else
          var_4.targetname = var_3.script_noteworthy;

        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_4);
        self.landing_spot = var_4;
        var_13 = (150, 150, 150);

        if(var_1 == "_encstr_BDFF1009A61BFBFB5F5728506F61303D72CD")
          var_13 = (90, 90, 90);

        self.nav_obstacle = createnavobstaclebybounds(var_4.origin, var_13, (0, 0, 0), "_encstr_8E8405EA382B2A");
        thread delete_nav_obstacle_on_death();
        break;
      } else {
        var_14 = scripts\engine\utility::array_remove_array(level.path_points[var_1], level.invalid_path_points);

        if(isDefined(var_6))
          var_14 = scripts\engine\utility::array_remove(level.path_points[var_1], var_6);

        var_15 = get_best_hover_point(var_8, var_14);

        if(isDefined(var_15)) {
          var_16 = duplicate_struct(var_15);

          if(!isDefined(var_15.script_noteworthy))
            var_16.script_noteworthy = "_encstr_8C3411B04EE45A9D56327DB0E8EB37DB32B2BE" + var_2;
          else
            var_16.script_noteworthy = var_15.script_noteworthy;

          var_16.radius = 512;

          if(!isDefined(var_6) || var_15 != var_6)
            thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_16);

          var_6 = var_15;
          level.invalid_path_points[level.invalid_path_points.size] = var_15;
          var_17 = scripts\engine\utility::_id_143B9(2.5, var_16.script_noteworthy);

          if(var_17 == "_encstr_995408F398012F656821")
            var_6 = undefined;

          scripts\engine\utility::deletestruct_ref(var_16);
          level.invalid_path_points = scripts\engine\utility::array_remove(level.invalid_path_points, var_15);
        } else
          wait 1;
      }

      continue;
    }

    var_14 = scripts\engine\utility::array_remove_array(level.path_points[var_1], level.invalid_path_points);

    if(isDefined(var_6))
      var_14 = scripts\engine\utility::array_remove(level.path_points[var_1], var_6);

    var_15 = get_best_hover_point(var_8, var_14);

    if(isDefined(var_15)) {
      var_16 = duplicate_struct(var_15);

      if(!isDefined(var_15.script_noteworthy))
        var_16.script_noteworthy = "_encstr_8C3411B04EE45A9D56327DB0E8EB37DB32B2BE" + var_2;
      else
        var_16.script_noteworthy = var_15.script_noteworthy;

      var_16.radius = 512;

      if(!isDefined(var_6) || var_15 != var_6)
        thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_16);

      var_6 = var_15;
      level.invalid_path_points[level.invalid_path_points.size] = var_15;
      var_17 = scripts\engine\utility::_id_143B9(2.5, var_16.script_noteworthy);

      if(var_17 == "_encstr_995408F398012F656821")
        var_6 = undefined;

      scripts\engine\utility::deletestruct_ref(var_16);
      level.invalid_path_points = scripts\engine\utility::array_remove(level.invalid_path_points, var_15);
      continue;
    }

    wait 1;
  }

  self waittill("_encstr_BD82096B5DA4B07F924F29");

  if(!scripts\engine\utility::array_contains(level.valid_air_vehicle_spawn_points, var_3))
    level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = var_3;

  if(isDefined(var_4))
    var_5 = get_exit_route(var_4, var_1 + var_2 + "_encstr_B4810709B378B9F3F5");

  var_18 = scripts\engine\utility::random(scripts\engine\utility::getStructArray(level.ai_spawn_vehicle_func[var_1].exit_points, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_19 = duplicate_struct(var_18);

  if(isDefined(var_4) && isDefined(var_5) && var_5 != var_4) {
    add_targetname_kvps(var_5, var_4, var_1 + var_2 + "_encstr_8AF40BFAAC0FD2D1AF0EB0A386");
    add_targetname_kvps(var_19, var_5, var_1 + var_2 + "_encstr_BD4305AF56CD91");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_5);
  } else {
    add_targetname_kvps(var_19, var_4, var_1 + var_2 + "_encstr_BD4305AF56CD91");
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_19);
  }

  delete_nav_obstacle();
}

create_unique_kvp_string() {
  var_0 = get_next_free_num();
  return "_encstr_B15A0CD57DE8FA7F1D5E08A1C778" + var_0;
}

get_next_free_num() {
  var_0 = level.next_index;
  level.next_index++;
  return var_0;
}

avoid_other_helicopters(var_0) {
  self notify("_encstr_AC6618607B22BB2F9F7FD3EA4D2B1FC45D8D3887E0B3B12D95BB");
  self endon("_encstr_AC6618607B22BB2F9F7FD3EA4D2B1FC45D8D3887E0B3B12D95BB");

  for(;;) {
    var_1 = self.origin + anglesToForward(self.angles) * 256;

    foreach(var_3 in scripts\engine\utility::get_array_of_closest(var_1, level.all_spawned_vehicles, [self], undefined, 512)) {
      if(var_3 == self)
        continue;
    }

    wait 1;
  }
}

get_best_hover_point(var_0, var_1) {
  var_1 = sortbydistance(var_1, var_0);
  var_2 = -5;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = scripts\engine\math::get_dot(self.origin, self.angles, var_5.origin);

    if(var_6 > 0)
      return var_5;
  }

  return var_3;
}

get_exit_route(var_0, var_1) {
  var_2 = var_0;

  if(isDefined(var_2.script_linkto)) {
    for(var_3 = 0; isDefined(var_2.script_linkto); var_3++) {
      var_4 = scripts\engine\utility::random(var_2 get_veh_linked_structs());
      var_4 = duplicate_struct(var_4);
      add_targetname_kvps(var_4, var_0, var_1 + "_encstr_B6BD0DA61728186DA9ABB79BABD220" + var_3);
      var_2 = var_4;
    }
  }

  return var_2;
}

copy_path_struct_at_new_pos(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.speed = var_1.speed;
  var_2.lookahead = var_1.lookahead;
  return var_2;
}

add_targetname_kvps(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0.targetname = var_2;
    scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_2, var_0);

    if(isDefined(self.veh_path))
      self.veh_path[self.veh_path.size] = var_0;
  }

  if(isDefined(var_1)) {
    var_1.target = var_2;
    scripts\cp\utility::addtostructarray("_encstr_A16007A921A23B85E3", var_2, var_1);

    if(isDefined(self.veh_path))
      self.veh_path[self.veh_path.size] = var_1;
  }
}

duplicate_struct(var_0) {
  var_1 = spawnStruct();
  var_1.path_gobbler = 1;
  var_1.origin = var_0.origin;

  if(isDefined(var_0.angles))
    var_1.angles = var_0.angles;
  else
    var_1.angles = (0, 0, 0);

  if(isDefined(var_0.script_unload))
    var_1.script_unload = var_0.script_unload;

  if(isDefined(var_0.lookahead))
    var_1.lookahead = var_0.lookahead;

  if(isDefined(var_0.speed))
    var_1.speed = var_0.speed;
  else
    var_1.speed = 2000;

  if(isDefined(var_0.start_node))
    var_1.start_node = var_0.start_node;

  if(isDefined(var_0.script_noteworthy))
    var_1.script_noteworthy = var_0.script_noteworthy;

  if(isDefined(var_0.script_linkname))
    var_1.script_linkname = var_0.script_linkname;

  if(isDefined(var_0.script_linkto))
    var_1.script_linkto = var_0.script_linkto;

  if(isDefined(var_0.script_brake))
    var_1.script_brake = var_0.script_brake;

  if(isDefined(var_0.script_pathtype))
    var_1.script_pathtype = var_0.script_pathtype;

  if(isDefined(var_0.script_goalyaw))
    var_1.script_goalyaw = var_0.script_goalyaw;

  if(isDefined(var_0.script_anglevehicle))
    var_1.script_anglevehicle = var_0.script_anglevehicle;

  if(isDefined(var_0.radius))
    var_1.radius = var_0.radius;
  else
    var_1.radius = 512;

  return var_1;
}

delete_nav_obstacle() {
  if(isDefined(self.nav_obstacle))
    destroynavobstacle(self.nav_obstacle);

  self.spawn_point scripts\cp\cp_modular_spawning::set_default_spawner_values();
}

attack_player_cooldown(var_0, var_1, var_2, var_3) {
  var_3._id_12A87 = undefined;
  var_4 = 1;

  if(isDefined(var_2)) {
    if(var_2 reflectbolt() < 1)
      var_4 = 0;
  }

  if(isDefined(var_0))
    var_0 _id_13BB7(0);

  if(isDefined(var_1)) {
    if(var_4)
      var_1 scripts\cp\cp_modular_spawning::mounted();
    else if(isDefined(var_2))
      var_2 mountstringtodlogenum(var_1);
  }

  reset_spawn_point_targetname(var_1);

  if(isDefined(var_2)) {
    if(isDefined(var_2.veh_spawn_point))
      var_2.veh_spawn_point = undefined;
  }
}

mountstringtodlogenum(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  var_0 scripts\cp\cp_modular_spawning::mounted();
}

delete_nav_obstacle_on_death() {
  self waittill("_encstr_AD75063D571AE108");
  delete_nav_obstacle();
}

reached_infil_node(var_0) {
  iprintlnbold("_encstr_82EF05B4FDBE71");
}

decrement_vehicles_active(var_0, var_1) {
  self notify("_encstr_A5921AB201038B071091C2735FB467C8FA39A8552B60FFEF03041C0F");
  self endon("_encstr_A5921AB201038B071091C2735FB467C8FA39A8552B60FFEF03041C0F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = self.veh_spawn_point;
  var_3 = self.spawn_point;
  var_4 = scripts\engine\utility::_id_143AD("_encstr_AD75063D571AE108", "_encstr_BD82096B5DA4B07F924F29");
  level scripts\engine\utility::delaythread(5, ::attack_player_cooldown, var_2, var_3, self, var_1);
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  level.ai_spawn_vehicle_func[var_0].count--;

  if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup)) {
    var_5 = scripts\engine\utility::getStructArray(self.veh_spawn_point.script_vehiclegroup, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_7 in var_5)
    var_7.disabled = undefined;
  }

  if(isDefined(self.veh_spawn_point))
    self.veh_spawn_point.in_use = undefined;

  self.veh_spawn_point = undefined;
}

reset_spawn_point_targetname(var_0) {
  if(!isDefined(var_0) && isDefined(self.spawn_point))
    var_0 = self.spawn_point;

  if(isDefined(var_0)) {
    var_0.ai_infil_type = undefined;

    if(isDefined(var_0.og_script_function))
      var_0.script_function = var_0.og_script_function;

    var_0 = undefined;
  }

  if(isDefined(self) && isDefined(self.veh_path)) {
    foreach(var_2 in self.veh_path) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(isDefined(var_2.script_noteworthy))
        remove_from_struct_array("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_2.script_noteworthy, var_2);

      if(isDefined(var_2.target))
        remove_from_struct_array("_encstr_A16007A921A23B85E3", var_2.target, var_2);

      if(isDefined(var_2.targetname))
        remove_from_struct_array("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_2.targetname, var_2);

      if(isDefined(var_2.script_linkname))
        remove_from_struct_array("_encstr_A29D10371B275A1C47F536969BDAB90BB5B2", var_2.script_linkname, var_2);
    }
  }

  if(isDefined(self) && isDefined(self.pathing_array)) {
    foreach(var_2 in self.pathing_array) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(isDefined(var_2.script_noteworthy))
        remove_from_struct_array("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_2.script_noteworthy, var_2);

      if(isDefined(var_2.target))
        remove_from_struct_array("_encstr_A16007A921A23B85E3", var_2.target, var_2);

      if(isDefined(var_2.targetname)) {
        remove_from_struct_array("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", var_2.targetname, var_2);
        remove_from_struct_array("_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_2.targetname, var_2);
      }

      if(isDefined(var_2.script_linkname))
        remove_from_struct_array("_encstr_A29D10371B275A1C47F536969BDAB90BB5B2", var_2.script_linkname, var_2);
    }
  }
}

remove_from_struct_array(var_0, var_1, var_2) {
  if(isDefined(level.struct_class_names[var_0]) && isDefined(level.struct_class_names[var_0][var_1]) && scripts\engine\utility::array_contains(level.struct_class_names[var_0][var_1], var_2))
    level.struct_class_names[var_0][var_1] = scripts\engine\utility::array_remove(level.struct_class_names[var_0][var_1], var_2);
}

clear_kill_off_flags(var_0) {
  if(istrue(var_0.skip_clear_kill_off_flag)) {
    return;
  }
  var_0.killofftime = gettime() + 20000;
  var_0.dontkilloff = undefined;
  var_0.canshootinvehicle = undefined;
  var_0.ignoreall = 0;

  if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle.landing_spot))
    var_0 scripts\cp\cp_modular_spawning::node_fields_pre_goal(var_0.vehicle.landing_spot);

  if(isDefined(var_0.demeanoroverride) && var_0.demeanoroverride == "_encstr_914B078DB09BAB0BB1") {
    var_0 scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("_encstr_96080730D8534E0A28");
    var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
    var_0 thread scripts\cp\cp_modular_spawning::start_patrol();
  } else {
    var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
    var_1 = var_0 scripts\cp\utility::get_closest_living_player();

    if(isDefined(var_1))
      var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);

    var_0 scripts\cp\cp_modular_spawning::enter_combat();
  }
}

_id_12AE5(var_0, var_1, var_2) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
        if(!isDefined(level.ambientgroups[var_0][var_3]._id_141B3))
          level.ambientgroups[var_0][var_3]._id_141B3 = [];

        level.ambientgroups[var_0][var_3]._id_141B3[var_1] = var_2;
      }
    } else {
      if(!isDefined(level.ambientgroups[var_0]._id_141B3))
        level.ambientgroups[var_0]._id_141B3 = [];

      level.ambientgroups[var_0]._id_141B3[var_1] = var_2;
    }
  }
}

puddle_fx(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    if(!isDefined(var_0._id_141B3)) {
      return;
    }
    if(!isDefined(var_0._id_141B3[var_1])) {
      return;
    }
    return var_0._id_141B3[var_1];
  } else
    return undefined;
}

redlight(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = puddle_fx(var_0, var_1);

    if(!isDefined(var_2))
      var_2 = [];

    for(var_3 = 0; var_3 < self.usedpositions.size; var_3++) {
      if(self.usedpositions[var_3]) {
        continue;
      }
      var_4 = 1;

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_2[var_5] == var_3) {
          var_4 = 0;
          break;
        }
      }

      if(var_4)
        return var_3;
    }
  }

  return -1;
}

_id_1301B(var_0) {
  if(isDefined(var_0)) {
    return;
  }
  for(;;) {
    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(enablegroundwarspawnlogic(level.players[var_1] getEye(), self.origin + (0, 0, 56))) {
        break;
      }
    }

    wait 0.1;
  }

  self notify(var_0);
}

allow_infil_after_full_or_timeout(var_0, var_1) {
  self notify("_encstr_B188221FF810CFD3171B2D277309298939A087EBC9892DAA5938755A7011825DE1105F7B");
  self endon("_encstr_B188221FF810CFD3171B2D277309298939A087EBC9892DAA5938755A7011825DE1105F7B");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD890EDA035FD38854EBE77E991A46F3");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = puzzle_mark_complete(var_0, var_1);

  if(isDefined(level.ai_spawn_vehicle_func[var_1].max_wait_for_infil))
    scripts\engine\utility::_id_143B9(level.ai_spawn_vehicle_func[var_1].max_wait_for_infil, "_encstr_BD97189B8EDBE0F5DD2CB41DA5373BBE33BD937DB90E58DD73B9");

  if(isDefined(var_2)) {
    if(self.attachedguys.size == var_2 || isDefined(self.load_queue) && self.load_queue.size == var_2) {
      self notify("_encstr_AD890EDA035FD38854EBE77E991A46F3");
      return;
    } else {
      childthread _id_1301B("_encstr_AD890EDA035FD38854EBE77E991A46F3");

      if(isDefined(self.group))
        self.group scripts\engine\utility::_id_143B9(3, "_encstr_AD75063D571AE108");
      else
        wait 3;

      self notify("_encstr_AD890EDA035FD38854EBE77E991A46F3");
    }
  }

  if(isDefined(self.load_queue) && self.load_queue.size > 0)
    self notify("_encstr_AD890EDA035FD38854EBE77E991A46F3");
  else if(self.attachedguys.size < 1) {
    scripts\common\vehicle_code::vehicle_deathcleanup();
    scripts\common\vehicle_paths::delete_riders();
    self notify("_encstr_A25F0710622DF3B3D7");
    self delete();
  } else
    self notify("_encstr_AD890EDA035FD38854EBE77E991A46F3");
}

little_bird_mg_takegunnerturret(var_0, var_1) {}

register_combined_vehicles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  [[var_0]](var_1, var_2, var_3);
  level thread _id_12AE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_12AE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_97AF17C6CAD9598DEB939585235EF5CC7B397D37D84E9607E8");
  register_vehicle_build(var_6, var_1, var_2, var_3, var_6);
  var_8 = spawnStruct();
  copy_vehicle_build_to_spawnpoint(var_5, var_8);

  if(var_8 scripts\common\vehicle_code::ishelicopter_internal()) {
    add_ai_air_infil(var_5);
    register_vehicle_spawn(var_5, 10, 10, undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", "_encstr_8CC80AA0A5312A895DF871B4", "_encstr_A5B51098DDE113BF8276A09BB1C78B0BFBB2", undefined, ::veh_heli_spawn, var_6);
    register_spawner_script_function(var_5, ::ai_lbravo_spawn);
  } else {
    add_ai_ground_infil(var_5);
    register_vehicle_spawn(var_5, 10, 10, undefined, "_encstr_B18B1657819701152DAB7028E183E3383F2367DFF72B095D", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", "_encstr_A93C163B937BABDC91D7D95986AF969B33968DFA83C2A3D0", undefined, ::veh_ground_veh_spawn, var_6);
    register_spawner_script_function(var_5, ::ai_ground_veh_spawn);
  }

  _id_12B03(var_6, var_1, var_2, var_3, var_4);
  var_9 = level.vehicle.templates.aianims[var_3];
  var_10 = 0;

  for(var_11 = 0; var_11 < var_9.size; var_11++) {
    if(isDefined(var_9[var_11].idle_anim))
      var_10++;
  }

  if(var_10 > 0)
    register_vehicle_spawn_drivers(var_5, var_10, scripts\engine\utility::random(["_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4", "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8"]));

  if(isDefined(var_4) && getdvarint("_encstr_969017B98DC9FA8D9CAC581DB2D7B5E0EB9D56D0B4B18DCAB9", 0))
    init_gas_vents(var_4, var_3, var_6);

  level notify(var_5);
}

init_gas_vents(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.vehicle)) {
    return;
  }
  var_3 = level.vehicle_builds[var_2];
  var_3.vehiclename = var_2;
  init_pipe_traps(var_0, var_1, var_2);
  init_petrograd_bsp_patch(var_0, var_1, var_2);
  init_patches(var_0, var_1, var_2);
  init_pipe_room_obj(var_0, var_1, var_2);
}

init_patches(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.interact)) {
    return;
  }
  if(!isDefined(level.vehicle.interact.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.interact.vehicledata[var_0]) && !isDefined(level.vehicle.interact.vehicledata[var_2])) {
    if(isDefined(level.vehicle.templates.aianims[var_1])) {
      var_3 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle(var_2, 1);

      for(var_4 = 0; var_4 < level.vehicle.templates.aianims[var_1].size; var_4++) {
        var_5 = level.vehicle.templates.aianims[var_1][var_4];
        var_6 = tolower(var_5.sittag);
        var_3.seatenterarrays[var_6] = [];
        var_3.seatenterarrays[var_6][var_3.seatenterarrays[var_6].size] = var_6;
        var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_2, var_6, 1);

        if(var_4 == 0) {
          var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_2, 1);
          var_8.driverseatid = var_6;
        }
      }

      level.vehicle.interact.vehicledata[var_2] = var_3;
    }
  }
}

init_pipe_traps(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.vehicledata[var_0]) && !isDefined(level.vehicle.vehicledata[var_2])) {
    var_3 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var_2, 1);
    var_3.destroycallback = level.vehicle.vehicledata[var_0].destroycallback;
    level.vehicle.vehicledata[var_2] = var_3;
  }
}

init_pipe_room_obj(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle._id_11FD0.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle._id_11FD0.vehicledata[var_0]) && !isDefined(level.vehicle._id_11FD0.vehicledata[var_2])) {
    var_3 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E(var_2, 1);
    var_4 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E(var_0);
    var_3.brtruck_initdialog = var_4.brtruck_initdialog;
    var_3.id = var_4.id;
    var_3._id_12DA2 = var_4._id_12DA2;
    var_3.seatids = var_4.seatids;
    var_3._id_14422 = var_4._id_14422;
    var_3._id_14423 = var_4._id_14423;
    var_3._id_14424 = var_4._id_14424;
    var_3._id_14426 = var_4._id_14426;
    level.vehicle._id_11FD0.vehicledata[var_2] = var_3;
  }
}

init_laser_panel_anims(var_0, var_1) {
  if(!isDefined(level.vehicle._id_11FD0.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle._id_11FD0.vehicledata[var_0])) {
    var_2 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E(var_0, 1);
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_0);
    var_2.seatids = [];
    var_4 = getarraykeys(var_3.seatdata);

    for(var_5 = 0; var_5 < var_4.size; var_5++)
      var_2.seatids[var_4[var_5]] = var_1[var_5];

    level.vehicle._id_11FD0.vehicledata[var_0] = var_2;
  }
}

init_petrograd_bsp_patch(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.occupancy.vehicledata[var_0]) && !isDefined(level.vehicle.occupancy.vehicledata[var_2])) {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_2, 1);
    var_3.camera = level.vehicle.occupancy.vehicledata[var_0].camera;
    var_3.damagefeedbackgroupheavy = level.vehicle.occupancy.vehicledata[var_0].damagefeedbackgroupheavy;
    var_3.damagefeedbackgrouplight = level.vehicle.occupancy.vehicledata[var_0].damagefeedbackgrouplight;
    var_3.damagemodifier = level.vehicle.occupancy.vehicledata[var_0].damagemodifier;
    var_3.enterendcallback = level.vehicle.occupancy.vehicledata[var_0].enterendcallback;
    var_3.enterstartcallback = level.vehicle.occupancy.vehicledata[var_0].enterstartcallback;
    var_3.exitdirections = level.vehicle.occupancy.vehicledata[var_0].exitdirections;
    var_3.exitendcallback = level.vehicle.occupancy.vehicledata[var_0].exitendcallback;
    var_3.exitextents = level.vehicle.occupancy.vehicledata[var_0].exitextents;
    var_3.exitoffsets = level.vehicle.occupancy.vehicledata[var_0].exitoffsets;
    var_3.exitstartcallback = level.vehicle.occupancy.vehicledata[var_0].exitstartcallback;
    var_3.restrictions = level.vehicle.occupancy.vehicledata[var_0].restrictions;
    var_3.threatbiasgroup = level.vehicle.occupancy.vehicledata[var_0].threatbiasgroup;
    level.vehicle.occupancy.vehicledata[var_2] = var_3;
  }
}

_id_12AF9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.vehicle)) {
    return;
  }
  if(!isDefined(level.vehicle.occupancy.vehicledata)) {
    return;
  }
  if(!isDefined(!isDefined(level.vehicle.occupancy.vehicledata[var_0]))) {
    return;
  }
  _id_12AF8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_12AF8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_0, 1);
  var_9 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_0, var_1, 1);
  var_9.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_1, var_2);
  var_9.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_9.damagemodifier = 0.5;
  var_9.animtag = var_3;
  var_9.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_9.animtag);
  var_9.exitids = var_4;
  var_8.exitoffsets[var_1] = var_5;
  var_8.exitdirections[var_1] = var_6;
  var_9.spawnpriority = 10;
}

_id_12AFD(var_0) {
  var_1 = ["_encstr_91A20B39B11731F50B2A7B0183", "_encstr_96F20EADF9077641FE9B2890221713AB", "_encstr_8C1E095BF787B932F978A6", "_encstr_9A1E093A85B3F513AC32C8", "_encstr_96740F538869D7AA5BA5497E1D6583B593"];
  var_2 = ["_encstr_A10D0BA3B27F17C327D98568E0", "_encstr_A30D0B30D3708180E951D37165", "_encstr_910D0BD951F7D19EB70A9BE647", "_encstr_910D0BD951F7D19EB70A9BE647", "_encstr_910D0BD951F7D19EB70A9BE647", "_encstr_930D0BB31F7F41CB11C81BAF42", "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4"];
  var_3 = var_1;
  var_4 = [];
  var_5 = (5, 14, 55);
  var_6 = "_encstr_A5AD056A019C63";
  var_7 = 10;

  if(isDefined(level.vehicle.interact.vehicledata[var_0]) && isDefined(isDefined(level.vehicle.interact.vehicledata[var_0].seatenterarrays))) {
    var_8 = getarraykeys(level.vehicle.interact.vehicledata[var_0].seatenterarrays);

    for(var_9 = 0; var_9 < level.vehicle.interact.vehicledata[var_0].seatenterarrays.size; var_9++) {
      var_10 = var_8[var_9];
      var_4 = scripts\engine\utility::array_add(var_3, var_10);
      _id_12AF9(var_0, var_10, var_1, var_2[var_9], var_4, var_5, var_6, var_7);
    }
  }
}

_id_12AE1(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.vehicle)) {
    return;
  }
  if(!isDefined(level.vehicle.interact)) {
    return;
  }
  if(!isDefined(level.vehicle.interact.vehicledata)) {
    return;
  }
  if(isDefined(level.vehicle.interact.vehicledata[var_0])) {
    return;
  }
  if(!isarray(var_1))
    var_1 = [var_1];

  if(isDefined(level.vehicle.interact.vehicledata[var_0].seatenterarrays)) {
    var_2 = level.vehicle.interact.vehicledata[var_0].seatenterarrays;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      for(var_4 = 0; var_4 < var_1.size; var_4++) {}
    }
  }
}

vehicle_registrations(var_0, var_1, var_2, var_3) {
  scripts\vehicle\mindia8::main("_encstr_99061990532CF2E013E390766B4B32295230D26BCDB0FA67FFCA1B", "_encstr_A60D0E2307118F4150A11F847AC08F30", "_encstr_8CDA16676F9E32D0387E13DF70380B9AFDFFB7E3D34E6ABD");
  scripts\vehicle\mindia8::main("_encstr_8DCA216DE564BAD8C7FAE8B642EF06C97E70D7118DCD72B5E73203BE6AA7BE4819DD71", "_encstr_A60D0E2307118F4150A11F847AC08F30", "_encstr_AF331BC31EE30FBA4961F3DAC0ABB6D3F9E85958A769538777988AB3C8");
  register_vehicle_build("_encstr_856111C65B33FF6334AFC85110239093B70F79", "_encstr_99061990532CF2E013E390766B4B32295230D26BCDB0FA67FFCA1B", "_encstr_A60D0E2307118F4150A11F847AC08F30", "_encstr_8CDA16676F9E32D0387E13DF70380B9AFDFFB7E3D34E6ABD");
  register_vehicle_build("_encstr_A6F90CB2FC09825758B150955870", "_encstr_8DCA216DE564BAD8C7FAE8B642EF06C97E70D7118DCD72B5E73203BE6AA7BE4819DD71", "_encstr_A60D0E2307118F4150A11F847AC08F30", "_encstr_AF331BC31EE30FBA4961F3DAC0ABB6D3F9E85958A769538777988AB3C8");
  init_jugg_maze("_encstr_8CDA16676F9E32D0387E13DF70380B9AFDFFB7E3D34E6ABD");
  init_jugg_maze("_encstr_AF331BC31EE30FBA4961F3DAC0ABB6D3F9E85958A769538777988AB3C8");
  level thread init_ammo_boxes("_encstr_92C70FB14C390BD9B7FA85AD31D2563747", "_encstr_A5EA215BCFF05A30720F6907475AEE199C664331B32FA95F2A5B4F1F6312BD4817BE8B", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", "_encstr_8DA722B936394B07E8F53BCAA1D2B18DACBE2DDD0EF5B1314E8567BDF516B54CB459DC1D");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "_encstr_A5EA215BCFF05A30720F6907475AEE199C664331B32FA95F2A5B4F1F6312BD4817BE8B", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", "_encstr_8DA722B936394B07E8F53BCAA1D2B18DACBE2DDD0EF5B1314E8567BDF516B54CB459DC1D", undefined, "_encstr_92C70FB14C390BD9B7FA85AD31D2563747", "_encstr_92C70FB14C390BD9B7FA85AD31D2563747");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", "_encstr_96301F92C72534F043AF1B4D58BF3E1C73C187E338719A60237273D2F949FB3E0F", undefined, "_encstr_AB0D0C1B31E40B67BDEBB3AECD9B", "_encstr_AB0D0C1B31E40B67BDEBB3AECD9B");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "_encstr_B44B192E9318501FD140B289A93B5371D005A2811D78C1BF8F3B2B", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", "_encstr_91212442880A10292B59EB157A7BAE08DB0F11D440914DC22B2B5E28F74A5B33535715F03F83", undefined, "_encstr_83E711590BA33738FF41710B35CB397DCA2711", "_encstr_83E711590BA33738FF41710B35CB397DCA2711");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", "_encstr_AA6F1AFF6F7308C395309EDDD0630AC369B19A8B721F128AAAC95B67", undefined, "_encstr_951007814D5B63F807", "_encstr_951007814D5B63F807");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "_encstr_A5EA215BCFF05A30720F6907475AEE199C664331B32FA95F2A5B4F1F6312BD4817BE8B", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", "_encstr_AF1B22EFE7268A68B0E69BA7F8A0831275070F47F9D8A232A809932D36D8C9AB5683A7DB", undefined, "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3", "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "_encstr_B44B192E9318501FD140B289A93B5371D005A2811D78C1BF8F3B2B", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", "_encstr_82F627EB26DB379261791B2228B38EFB91804967E3066B5E5590E39AA9FF46CBAB73CDFAC8E9A72231", undefined, "_encstr_B1B514E14EF31303A7BFA0B863D2B8435BB9EDFFE26B", "_encstr_B1B514E14EF31303A7BFA0B863D2B8435BB9EDFFE26B");
  register_combined_vehicles(scripts\vehicle\lbravo::main, "_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A", "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3", "_encstr_BD5E238F580B214BB9F8C33F5BABB2FC31511F171A066C32CD8FCBB528632A87D860ABF710", undefined, "_encstr_BDFF1009A61BFBFB5F5728506F61303D72CD", "_encstr_BDFF1009A61BFBFB5F5728506F61303D72CD");
  register_combined_vehicles(scripts\vehicle\blima::main, "_encstr_B2671623E5D0519E0729F97F8B2D1BC80120B0DDCF49689F", "_encstr_8DD90913C62DB585D7D81C", "_encstr_8CEF193FBB4A98F71B3173192A0726E8272FB3BF78F90831570AE9", undefined, "_encstr_873F0CB51C346BD71F0A5A81D28B", "_encstr_873F0CB51C346BD71F0A5A81D28B");
  register_combined_vehicles(scripts\vehicle\blima::main, "_encstr_B2671623E5D0519E0729F97F8B2D1BC80120B0DDCF49689F", "_encstr_8DD90913C62DB585D7D81C", "_encstr_B8BC1C530AF383B03377CDD3785CE0D97721E85B27EF4E080C2DEBAF9BC2", undefined, "_encstr_84AB069378304D32", "_encstr_84AB069378304D32");
  level thread register_spawner_script_function("_encstr_A9100DDA2D37325A161C7D53D59DCE", ::ai_mindia8_jugg_spawn, ["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"], 1);
  level thread _id_12B05("_encstr_A9100DDA2D37325A161C7D53D59DCE", undefined, undefined, undefined, undefined, undefined, undefined, 3, undefined, undefined);
  register_combined_vehicles(scripts\vehicle\mindia8::main, "_encstr_8A67159D594383F5DAB41BF52CB4E47DB55ACD91A52CC1", "_encstr_BAFD0BB5B473195A0BC1AF1B83", "_encstr_AD1A226BDE7A40375367CDE393AAF63005B9506390EFA8630A93CBF3AA91CEF8D70A5999", undefined, "_encstr_BA020FB5D27319A5B00EBEB163F6B95646", "_encstr_BA020FB5D27319A5B00EBEB163F6B95646");
  register_combined_vehicles(scripts\vehicle\mindia8::main, "_encstr_A3BD27E37758F298EAE791EFDFF25681E5CC68399CB92A50E2EB8B850FAA17D88B29D39089F85976EB", "_encstr_BAFD0BB5B473195A0BC1AF1B83", "_encstr_8F871B9BD8E4B4388EEBCE590D96D81B95BE2DBBE0D75B2DCD8CA51683", undefined, "_encstr_88520840BAB5F918BF78", "_encstr_88520840BAB5F918BF78");
  register_combined_vehicles(scripts\vehicle\mindia8_jugg::main, "_encstr_A3BD27E37758F298EAE791EFDFF25681E5CC68399CB92A50E2EB8B850FAA17D88B29D39089F85976EB", "_encstr_BAFD0BB5B473195A0BC1AF1B83", "_encstr_AD23206E8D4E4BE03A7DCECA349636C6597D2D771CBEDAD23719D2160EF59A5DB3EC", undefined, "_encstr_A9100DDA2D37325A161C7D53D59DCE", "_encstr_A9100DDA2D37325A161C7D53D59DCE");
  register_combined_vehicles(scripts\vehicle\techo::main, "_encstr_8F311EB4D70AF96EE3DFC091D336C1FF737FA6332D1131B0D15F3078876F7919", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_84532DB7DF73E3D814B1A3D964E188A9FAC71B370A0935B04D9608968BD5D0D3F25FAFB127E37511602C72EBF4BB98", undefined, "_encstr_B22E0C8072FEF9C04F4F0BF324CF", "_encstr_B22E0C8072FEF9C04F4F0BF324CF");
  register_combined_vehicles(scripts\vehicle\techo::main, "_encstr_AA3F21CECAA107EBB1B43BEB8D9B237DA3B21BD0DEFA19969C47E5AF38342F375A8DE6", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_AD6C32B9D8274B07E8BED9B243D2D836567D96DDE0FA3A39AEC66DFA3A598D1AEDEBEED0D23A95325A393A2FEB07A1BCE62D1BCD", undefined, "_encstr_AC351138CA467148D7C7830BBC47513B6A43D8", "_encstr_AC351138CA467148D7C7830BBC47513B6A43D8");
  register_combined_vehicles(scripts\vehicle\techo::main, "_encstr_8F311EB4D70AF96EE3DFC091D336C1FF737FA6332D1131B0D15F3078876F7919", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_837C2A932770BC2BD51E9B520DA3AF3510F7311F0971837B7DB142F9AB8DD76CE80FA098E3A80CF7262E3A13", "_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_96EC0BA32B8D1AB7D70E8697E6", "_encstr_96EC0BA32B8D1AB7D70E8697E6");
  register_combined_vehicles(scripts\vehicle\techo::main, "_encstr_A2401F4C2FF201860BC7E8A9FB2EB9979A54C8DD84DA07ABF89FF84BBF6B163BC3", "_encstr_A676126B09DBE9BB3681F8C01B4A73C1779761DF", "_encstr_B4A424D8FA3B835F63D994A2389BC8EA80F1C070D7A774C54A9A6D30A2B03317A288803364F8", undefined, "_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B", "_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B");
  init_laser_panel_anims("_encstr_96EC0BA32B8D1AB7D70E8697E6", []);
  _id_12AFD("_encstr_96EC0BA32B8D1AB7D70E8697E6");
  _id_12AFD("_encstr_B22E0C8072FEF9C04F4F0BF324CF");
  register_combined_vehicles(scripts\vehicle\decho::main, "_encstr_82CF3040A2EC89168F6134B84C93B9FF570A70387A495569539531B05CF72361F8318848E29F8D2127B6501F389FCB03261B", "_encstr_B87511C5AFC221EDB723981807A9D94F695247", "_encstr_A72A35B98D272D3847EB3B2B1AA5D88DCA7D5ABB0EEB23568D86F6F5272B132B36BEB62D1B9DE42BAC7332964EE8F2D7E043CB6EA5D8B9", undefined, "_encstr_BE7E0C1BA0E1F862272C3AF7051D", "_encstr_BE7E0C1BA0E1F862272C3AF7051D");
  scripts\vehicle\techo::main("_encstr_AA3F21CECAA107EBB1B43BEB8D9B237DA3B21BD0DEFA19969C47E5AF38342F375A8DE6", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_AD6C32B9D8274B07E8BED9B243D2D836567D96DDE0FA3A39AEC66DFA3A598D1AEDEBEED0D23A95325A393A2FEB07A1BCE62D1BCD");
  scripts\vehicle\techo::main("_encstr_A59C1F67B2A183D7C64B3BD7639B19EBA32B360DDBAF39568CFA0E43E56EB48DE6", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_AAAF2B035AA3D3E04307BD83286C302987F1D80B57BF9508DB138FFF5C57E8E3076933F17A67CF90F0FBB3FF63");
  scripts\vehicle\techo::main("_encstr_810525CE59D01CD71BA59DEB8D3791AF1D56D886DB7D46D29CD1F2EB395623FAE0D0BCB996C6CD", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_8AC5304BFE5A60177347AD83F3CAD610E559B043B08F40CE5BAFEFEFBBD22EF8B7215B994F1CD086A3EF8FB9233B6E485382");
  scripts\vehicle\techo::main("_encstr_86C52124DF385F98378A6DBEC11803F7BB1876A0FF4FC579183B4B21D77BF08791D0B0", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_AF6D2DF6366BA35260FF4B6AA8748EB181C01BA747C69B3AEBD732C9019F16CA8AE9312A6A6FB71EC9C123E6BA9078");
  scripts\vehicle\techo::main("_encstr_8A9D274353A317CF90A8E3A1E0103CB905FBAFB3DF409AA12013D8B91958413252776B2B9BFEB26340", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_995132C27188711335B7DB6F2153EABCE85EFC4B8289146B8DE7A78F310D92E010A6B615C1D0C3C2EBDDC30F7FAFEA3988C86E5A");
  scripts\vehicle\techo::main("_encstr_AA801F4E57100931C74BD597A13D32B7FD283E7370572446E8490B52705AC4EE9B", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_81AD2B7BB64BA7E211098BB298031E0B0130F9F773B69BAACB104229606356D3B8986C99E05E5374BBB86AE230");
  scripts\vehicle\techo::main("_encstr_85DC25E329B36A59884BD6F769C8DFAFE541CA8AF080D30CF869E1EF21E865670F58E3A3986637", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_863930AFC76BFBD02C89ABC16CE990A1F2CF133F02013D88459E309E93CDD8EB0A67D19BC3DA0B707C70BE73BCA96093624F");
  scripts\vehicle\techo::main("_encstr_A7242167CAD01CEB362D67BE8DB919F58E566C86B7D79CBAE6D1CBD71C43F2B99636B9", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_866D3258C62A0B2903273085304B2721B590602F520F20836D77C277434D1EDCBF0987682B732A65DFB73BE8D7AB69B950503203");
  scripts\vehicle\techo::main("_encstr_ADA526B3CA34C1F5362DECAF1B37197D1D95C6D0BDBE27EADC47E5BE26D8BA95AF0E34CBE62D6C9B", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_9A86319B38B0189830175B4AB02CDE0461A76773D2567BF3839AD8487152B2F317A719096BC27BB82E8DBFFFD310F1A8E29618");
  scripts\vehicle\techo::main("_encstr_8464275E9528C2C9DF586BF1982DFFA7430DD3C83896A30BA7888309F011F61F18F848704BBB17568F", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_A18A32E636935A1CD1EBD9AC344BB13659BE2DEE0EEBE8935736B6FAA3956C34B7F513D858D8B64E57B9E8CBFA1C0D5E37A58DE6");
  scripts\vehicle\techo::main("_encstr_A67C287BB12BC2F130E34E1F912047174D29A222586813B398F14917BFE8CE0B7C41F92B40D35FECC0E7", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_A10D3338923A7BA363E78475B87F8929A7F95090BF99893B5FC302609C9771E98D81E820C26DD791ABFD16ED79575B51F0EB40205B");
  scripts\vehicle\techo::main("_encstr_8678276CB52323E879F04B81799A41B1844531430D17B6B743399BAE3F1A07515B8923640F78DB56BF", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_A3633267E3E2304FA399ABF1D2EF8E507F47DB17D00160964FB26DBE7BB7B6A815EF5F95357778DE17ABFB62D13BFB68AA21DF0F");
  scripts\vehicle\techo::main("_encstr_9351219CCD0BAA0F6E2A70311245211ED375AE1B2F2F2BB316F2D829EB1CD353FF1B2E", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_961A2DB6D62BDB0B748740C043B1A119E271233C7891B9735D9FA0191BD5F9A9AAE9264D46EA419E208BC84017EB33");
  scripts\vehicle\vindia::main("_encstr_9351219CCD0BAA0F6E2A70311245211ED375AE1B2F2F2BB316F2D829EB1CD353FF1B2E", "_encstr_8A93118CAD49209A4928F32A436FCAB8B6CB30", "_encstr_961A2DB6D62BDB0B748740C043B1A119E271233C7891B9735D9FA0191BD5F9A9AAE9264D46EA419E208BC84017EB33");
  register_combined_vehicles(scripts\vehicle\mkilo23_ai_infil::main, "_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07", "_encstr_B87B11439AA9512A79A760E17BE35A272F677A", "_encstr_AD6C2DB9D8274B07E8BED9B24370D7B696B1F5B1B923AFB66DD28D7B19CC7D1C0D2FE6D2C6B97DB05AAFB4CDCC96B1", undefined, "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B", "_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B");
  scripts\vehicle\empty_turret::main("_encstr_96CE0F8D83AF1DABC9C9563AF5C4DB2397", "_encstr_8C2A0D6F68EF6DE92E0B681D764723", "_encstr_AC291C7FFB0AD8B75B71B3D9EAC7E628676FEBCB70F3106863CBCB2302EB");
  scripts\cp\cp_remote_tank::main("_encstr_850114B32B430EBE6BA536AFC6B923FAEE43DEA359B1", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AA6E28FF6F7308C395309EDDD0630AC369B1DAFB9E67226A2DC5B91B991F58F197A303A748F143131704");
  scripts\cp\cp_remote_tank::main("_encstr_BE60197393DBEB2F50DA9D27AD609F87204017E5D573216D879BA3", "_encstr_BE1B129DCAA1F583B036BEB92B37D14E5E7DAD83", "_encstr_AAE42838923A7BA363E78475B87F8929A7F970A8C996BFF83BCD07F7B7DF10F30FB208C83221D311AFFC");

  if(isDefined(level._id_14208))
    [[level._id_14208]]();
}

create_vehicle_builds() {
  if(isDefined(level.script) && (level.script == "_encstr_ABDD090A3390CF5C40B73D" || level.script == "_encstr_8D5C0C360ED7318DB736DA0B32AC" || level.script == "_encstr_AC530FEAD3702BBEA039A770D918C2BFAF" || level.script == "_encstr_ACFA0BB7B381457BEEDF03FB44")) {
    if(getdvarint("_encstr_BAB3110FDF7859F3B84F7260515007A53FD976", 0))
      register_vehicle_build("_encstr_BE76076250081CE2DF", "_encstr_8EE41C23BA4BFB1985B10977AC2D88305312B8E9C2C780981C893F13CB52", "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40", "_encstr_9B2F265B966B8702F1E96B52B8233E6B6110D9D79396BBCAAB30A209601B350358E7677AC1F93F54");
    else
      register_vehicle_build("_encstr_BE76076250081CE2DF", "_encstr_B8D414D0EB63CBEFFDA31BD0AC3838B7E3A8B201A07E", "_encstr_ADA706A3E4BA1BB6", "_encstr_8E7F26D7BF1383B8349183F944016849DAE77B572A29D5906DF628B66AF9D8F572879FAFC3129DE0");
  } else {
    register_vehicle_build("_encstr_91BD0C38D29B91B416D737BD19CA", "_encstr_B8D414D0EB63CBEFFDA31BD0AC3838B7E3A8B201A07E", "_encstr_ADA706A3E4BA1BB6", "_encstr_8E7F26D7BF1383B8349183F944016849DAE77B572A29D5906DF628B66AF9D8F572879FAFC3129DE0");
    register_vehicle_build("_encstr_BE76076250081CE2DF", "_encstr_8EE41C23BA4BFB1985B10977AC2D88305312B8E9C2C780981C893F13CB52", "_encstr_8DC71569E5A638C00F6B687263378E48BD6ED70BB70E40", "_encstr_9B2F265B966B8702F1E96B52B8233E6B6110D9D79396BBCAAB30A209601B350358E7677AC1F93F54");
  }

  register_vehicle_build("_encstr_87130EBFE1330143CE69A8E041A2119B", "_encstr_BE8B29E3254A83B77208AC4105E079B1939782FBB89A294BB318E804216B175B891BC0F8E0C84F03A980D1", "_encstr_A676126B09DBE9BB3681F8C01B4A73C1779761DF", "_encstr_B225322B9FC804A35D86132A883B17BD987FB99781F90BE38539DA7193036BF740EB17596F809623B87332CA5EE7AB68F843A383", "_encstr_91CD07D045CF0B0BB8");
  register_vehicle_build("_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B", "_encstr_A2401F4C2FF201860BC7E8A9FB2EB9979A54C8DD84DA07ABF89FF84BBF6B163BC3", "_encstr_A676126B09DBE9BB3681F8C01B4A73C1779761DF", "_encstr_B4A424D8FA3B835F63D994A2389BC8EA80F1C070D7A774C54A9A6D30A2B03317A288803364F8", "_encstr_84D70A6B2BEF3C9B30A67164");
  register_vehicle_build("_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3", "_encstr_AD381DAB61FB3201B03384AF217017679158D292886E46493019998BC3309A", "_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3", "_encstr_8DE0296E369C4B83D1AF672B0DA5C68DCABEA5DD70AF479357D8ADF5DADA5A367BC8CCF5384397DC5A6CCD");
  register_vehicle_build("_encstr_BD8411B5DAD28DF61999AF0B2DD7D2DC33B41B", "_encstr_A27620B3B21A077DAD5AC6AF1B3719FADADAA563DB2399AF07A15E37D2B1E6F56B07", "_encstr_955C10E258838BE5D22F0F28B1A0AA273EF3", "_encstr_AD6C2DB9D8274B07E8BED9B24370D7B696B1F5B1B923AFB66DD28D7B19CC7D1C0D2FE6D2C6B97DB05AAFB4CDCC96B1");
  register_vehicle_build("_encstr_BEDB0ABB93F56A5919C1C782", "_encstr_8CD81F73639327FFF0B89551F0730CA974938BB3C34F19B952468A644AD059224E", "_encstr_A9BD126328309B5418A75040C3A01CDFE6864B8B", "_encstr_AB911DF6A91A7BB72301C3E5A893A0A0D08163E3312E13A72EF1EF915911BE");
  register_vehicle_build("_encstr_B4750649E5A638C0", "_encstr_A5491B5415D372C7A61238695A3D79565BBD56C367672391085BC88083", "_encstr_B87511C5AFC221EDB723981807A9D94F695247", "_encstr_ACEE279F9776DA38E0D6AB77285073C245577F17C908D2E57058E5F1E3B0B1FB2D3FA3E3D3464ADB08");
}

setup_player_vehicles(var_0, var_1, var_2) {
  var_3 = "_encstr_884C0296";
  var_4 = "_encstr_854C0289";
  var_5 = "_encstr_BA4C02DF";
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_B2F03D814DA811B782477DE9EBEAF39883F55109D51021E32B53417B4AC04B885CDE71D16ABD580F73E775073B5A0328F3A541F657E5A05D6AD22F217F4358" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_A6E90F181C530BB8109F4EDF23233D16F2";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_88123C12EA91CB9B631C35BE9403528981989F9A52391CF2B7BBBBB6FD33EA4301620A6FE86B281B974E495B5DC9D21310E087BB70C1B58269F68A96BC9D" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_A77D0E4AC0479C53964D1106EA11CABC";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_93F63B01CB806AC12CDD37042BCAD02D6C36560497044595368637B4C6581B881044E6598E026E6C39F59D951AA56C8DCAFA19CA26BA3B403507C2DD73" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_927D0D8B93E6D23E4B29662D692212";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_AD953B72AFFFD998E8334DC60F90D8322651EFEA0757714110F14A1D63B80A7E2F65CF77298F4B3BA0E67BE7982023D255071BCFED4DB2B0C12BB66BB0" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_AAAB0D489992FE2B3F637FFD3D9A32";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_ACF73831CE76DEF8E15B40910BCDF00BFA6B23B9B61E0B3837720BB23EF0FABE729321672FE348B8554C50C9D59DD97D2A2333C7BA59A7D87FA5" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_A7BC0A32C86FB27B8A8EB89A";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_BE4B3510E5019AC10BBB7302B259A1D2B136AC04BC04A00A1A440288DC95E802E61B397D3B2B1A961BC6CAEB322B26AEEC80353816EE37" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_ADE007F9D35FDECA44";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_AD2E39805E044D0EB077730295AC0D96C61B5901F2020AA0D0802955D4444044E6B23A01371BC9FA9DB21AB48DD895D7325926BACE046A0EC2EE37" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_AC8E0FC3E363E09BBBA80B58B2456AF21A";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_A131356708AEDEFBEF43939AB72DFC022E2137EE5A29397BE6BDF2B5070ADD3083BF53DF2ED5E3B311E93BD1C3B03E7397D2ABDA46B333" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_B4A807DE0B30A27E72";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_8DC83DC1AF76E14FF71BA85931DF0B78FE74C3B9C7DED91F53F2805179EBBDF01492D1352377A8F70FAA3BA6436FFBE8AE24D357DCDF40A577B6174B1A0FA0" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_96C40FC2F81537570EE5AAA576D03AAE8D";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_93B539F10EB61E38A11BCDD14B8DB04B3AABE379F65ECEF8E8A6ADF16A322A56531749812F321EB106CFB0C8D6544820FA7FDDA3E7AE769029A378" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_AAF50BE7C0633196D17292673B";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_92263E51082E631009270BEF56058320E6F149E2BA9031C887F83327A0E578A367F8DA7EBED07DC4D757339306E4C9B3720F2CBA9169D5E8DB7708CB7AA31753" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_BE2710C077D0B2630B5683EB7B6E477E0205";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_963536465F81BAF0E1FF9AEF9F8FFC197F58B7962F86F8585263662612CBFF2442937666A865E1E8A8B305D73147C5908D37D13938C7FFCE" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_A76D08535956381110A0";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_B26E418E6082D37BC79FD3E2F5FDC251309057F608DA84A2A647E7DAE91E1A9E48BB4DEADB2230CE7E6BABD2CF4EF3F7C8E104B4D1E83DD1DD730B9FDFC7A910280B3D" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_93C113AD075DCAA52E681B5F908388F2F525A6364A";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_8CC33F019708A61C2CBB9B089559A196B18D9580F280A95619048A930BCDB938ED938E8810889BAC1D0137B1C9BEECCAA14B6CB1957D91B298AEB3046A382CBB9B" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_832F115897B2192B326A682F37700699862EF2";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_B6CB3E40E540A9C1C2777302ACACA1A5D863B240CB020AB4365B573802A227ABC6DA880888CDB23A409B6C4EF567CA34B41B36CABE325931ABD9106A0716EE73" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_976C10832D8D5BBA387D8E4E5D6CB5118005";
  scripts\cp\utility::addentrytodevgui(var_6);
  var_6 = "_encstr_B2541C19599DD9AEA5AF6CB6190822340A02141BC25ECA4ECDE8C808BC80" + var_1 + "_encstr_851035F10EB61E38A11BCDD14B8DB04B3AABE379F65E4488F626C1992A758857530F457F3B52134B138D110E175D7035CA6ABFA9FFDBE8" + var_5 + var_3 + var_2 + var_3 + var_4 + "_encstr_A3DE072DA125AAA79A";
  scripts\cp\utility::addentrytodevgui(var_6);
}

cp_vehicle_debug(var_0) {
  var_1 = strtok(var_0, "_encstr_BA4C02DF");
  var_2 = strtok(var_0, "_encstr_884C0296");
  var_3 = strtok(var_0, "_encstr_854C0289");
  var_4 = undefined;

  if(var_2.size > 0) {
    var_5 = int(var_2[0]);
    var_4 = level.players[var_5];
  }

  switch (var_1[0]) {
    case "_encstr_8E8A0677D987435E":
    case "_encstr_8E8A06F7D987435E":
      if(isDefined(var_3) && var_3.size > 1)
        scripts\engine\utility::script_func(var_3[1], var_4);

      break;
    default:
      break;
  }
}

spawn_enemy_chopper(var_0, var_1, var_2) {
  var_3 = level.ai_spawn_vehicle_func[var_2];
  var_4 = var_3 get_vehicle_spawn_points(var_1);

  if(isDefined(level.cashtypes))
    return 0;

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    if(isDefined(var_0.valid_vehicles)) {
      if(isDefined(var_0.valid_vehicles["_encstr_A6F90CB2FC09825758B150955870"])) {
        if(var_0.valid_vehicles["_encstr_A6F90CB2FC09825758B150955870"] == 0)
          return 0;
      }
    }

    if(getdvarint("_encstr_81871EF74B22B9DBBF43F5A32B881BF641277259286167A16DA80BB2C0651134", 0) > 0)
      return 0;
  }

  if(var_4.size > 0) {
    foreach(var_6 in var_4) {
      if(istrue(var_6.in_use)) {
        continue;
      }
      copy_vehicle_build_to_spawnpoint(var_2, var_6);
      var_7 = vectortoangles(var_1.origin - var_6.origin);
      var_6.angles = (0, var_7[1], 0);
      var_8 = scripts\common\vehicle::vehicle_spawn(var_6);

      if(isDefined(var_8)) {
        var_6.in_use = 1;
        var_8.veh_spawn_point = var_6;
        level.cashtypes = var_8;
        var_8 stringtovec3(var_1, var_0, var_6, var_2);
        var_0.vehicle = undefined;
        var_1.vehicle = undefined;
        var_1.veh_spawn_point = undefined;
        var_0._id_12A87 = undefined;
        var_8 init_helicopter(var_0, var_2);
        var_8.vehicle_forcerocketdeath = undefined;
        var_8.death_fx_on_self = 1;
        var_8.circle_radius = 2500;
        var_8 scripts\cp\helicopter\cp_helicopter::heli_mg_create("_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED", "_encstr_B1DA118FE9B73268D01EF3BB9340ADFBAF6753", "_encstr_99FE0B2B19086F6B9DC5D387E1");
        var_8 thread scripts\cp\helicopter\cp_helicopter::setup_pilot(1, undefined, undefined, undefined);
        var_8 setmaxpitchroll(15, 15);
        var_8.health_remaining = 2250;
        level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var_8);
        var_8 sethoverparams(25, 15, 10);
        var_8.vehicletype = "_encstr_88CD07337F8B2B8083";
        var_8.headicon = deleteheadicon(var_8);
        setheadiconfriendlyimage(var_8.headicon, "_encstr_A6371ED0BAC8D74B6C7BE6BE43AC58C8AFCA17575A0E5B2B73E8BE56E656B697");
        setheadiconsnaptoedges(var_8.headicon, 12000);
        setheadiconmaxdistance(var_8.headicon, 1500);
        addclienttoheadiconmask(var_8.headicon, 10);
        setheadicondrawthroughgeo(var_8.headicon, 1);
        var_8.bullets_can_damage = 1;
        var_8.needs_to_evade = 0;
        level thread _id_142D6();

        if(scripts\cp\utility::turn_off_sniper_laser())
          return 1;
      }
    }
  }

  return 0;
}

_id_142D6() {
  var_0 = ["_encstr_B8892C622A88A732A8872B298B50B1FFCF8D5A5A13F59FEC20F95133B783832FEE1E0273DBC71764A8D55707E32A", "_encstr_9A892CEAE0D9489808171C0A102EC00BE16B7375E7331E52826AC8564703C3C70AA7790569823F482380C7FF9B1B", "_encstr_95112C91798967C87757D13E0BDF47E363A0CD78631011419798036A28CB40ED88690AC5AC0E3BBAD7FAF0971352", "_encstr_9A112C68D3B91798E2EE4B8353EE9F49FF200D40E38349106D64E81E85F36439EB4FD0EBE3C806AA7FC3CFB7A7DB"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "_encstr_9A8507BA4040188D08");
}

_id_13079(var_0) {
  if(isDefined(self.healthbuffer)) {
    self.health = self.healthbuffer + var_0;
    self.maxhealth = self.health;
  } else {
    self.health = var_0;
    self.maxhealth = self.health;
  }
}

init_helicopter(var_0, var_1) {
  self.isheli = 1;
  self.currentdestindex = gettime();

  switch (var_1) {
    case "_encstr_BA020FB5D27319A5B00EBEB163F6B95646":
    case "_encstr_873F0CB51C346BD71F0A5A81D28B":
    case "_encstr_84AB069378304D32":
    case "_encstr_A9100DDA2D37325A161C7D53D59DCE":
    case "_encstr_88520840BAB5F918BF78":
      _id_13079(5000);
      break;
    case "_encstr_A6F90CB2FC09825758B150955870":
      _id_13079(50000);
      break;
    default:
      _id_13079(1250);
      break;
  }

  thread is_done_speaking();
  self.team = "_encstr_8E8405EA382B2A";

  if(isDefined(self.script_team))
    self.team = self.script_team;

  self setvehicleteam(self.team);

  if(isDefined(var_1) && var_1 == "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3")
    thread waiting_for_disable();

  if(self.team == "_encstr_8E8405EA382B2A") {
    level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
    thread smoke_wheelson_chosen_spawn();
  }

  self.dontdisconnectpaths = 1;
  self.vehicle_forcerocketdeath = 1;
  self.death_fx_on_self = 1;

  if(isDefined(var_1)) {
    level.ai_spawn_vehicle_func[var_1].count++;

    if(isDefined(var_0))
      scripts\cp\cp_modular_spawning::add_to_module_vehicles_list(var_0, var_1);
  }

  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

smoke_wheelson_chosen_spawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_A56411C8956359E896E676F5D9CA432D8D8D2B");
  level thread scripts\cp\cp_weapon::remove_from_special_lockon_target_list(self);
}

is_done_speaking() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = scripts\common\utility::playersnear(self.origin, 256);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(var_0[var_1].origin[2] > self.origin[2]) {
        if(var_0[var_1].origin[2] - self.origin[2] <= 32 && var_0[var_1] isonground())
          var_0[var_1] dodamage(var_0[var_1].health + 1000, self.origin, self, self, "_encstr_8D4E0A501FCB898912CB3FA3");
      }
    }

    wait 0.25;
  }
}

waiting_for_disable() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BD82096B5DA4B07F924F29");
  self notify("_encstr_B1C417630BDC9196373BD78CB0AD16CE95AFBB58E81B0DCAC9");
  self endon("_encstr_B1C417630BDC9196373BD78CB0AD16CE95AFBB58E81B0DCAC9");
  var_0 = 256;
  var_1 = 80;
  var_2 = 36;

  while(isDefined(self)) {
    if(isDefined(self.currentdestindex) && gettime() - self.currentdestindex < 5000) {
      wait 0.05;
      continue;
    }

    var_3 = self.origin + (0, 0, -140) + anglesToForward(self.angles) * 24;

    if(self.team == "_encstr_8E8405EA382B2A") {
      foreach(var_5 in level.players) {
        if(isDefined(var_5) && isalive(var_5) && truckwarspawnlocations(var_5.origin, var_3, var_1, var_2))
          var_5 dodamage(var_5.health + 1000, self.origin, self, self, "_encstr_8D4E0A501FCB898912CB3FA3");
      }
    }

    var_7 = tablesort(var_3 - (0, 0, 200), 400, 400);

    if(!isDefined(var_7) || var_7.size == 0) {
      wait 0.25;
      continue;
    }

    var_7 = sortbydistance(var_7, self.origin);
    var_8 = undefined;

    for(var_9 = 0; var_9 < var_7.size; var_9++) {
      var_10 = var_7[var_9];

      if(!isDefined(var_10) || var_10 == self) {
        continue;
      }
      if(var_10 vehicle_getspeed() > 1) {
        continue;
      }
      if(isent(var_10) && truckwarspawnlocations(var_10.origin, var_3, var_0 * 1.5, var_2)) {
        var_8 = var_10;
        break;
      }
    }

    if(!isDefined(var_8)) {
      wait 0.05;
      continue;
    }

    var_11 = var_8;
    var_12 = 0;

    if(isDefined(var_11.vehiclename) && var_11.vehiclename == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8")
      var_12 = 1;

    if(isDefined(var_11.vehiclename) && var_11.vehiclename == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F")
      var_12 = 1;

    if(isDefined(var_11.stop_all_ascend_anims) && var_11.stop_all_ascend_anims == "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3")
      var_12 = 1;

    if(isDefined(self.owner) && isPlayer(self.owner) && isDefined(var_11.owner) && isPlayer(var_11.owner))
      var_12 = 0;

    if(triggerexitfunc() && var_11 triggerexitfunc())
      var_12 = 0;

    if(var_12) {
      var_13 = var_11.health + 1000;
      var_11 notify("_encstr_81A31964CB7817B720F1D11AD809FB0CF8A3EFFE1F909E6F5FE94A", var_13, self);
      var_11.load_sequence_4_vfx = 1;
      var_11 dodamage(var_13, self.origin, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
    }

    wait 0.05;
  }
}

truckwarspawnlocations(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::distance_2d_squared(var_0, var_1) > squared(var_2))
    return 0;

  if(var_0[2] < var_1[2])
    return 0;

  if(var_0[2] > var_1[2] + var_3)
    return 0;

  return 1;
}

triggerexitfunc() {
  if(isDefined(self.owner) && isPlayer(self.owner))
    return 1;

  if(isDefined(self.occupants)) {
    foreach(var_1 in self.occupants) {
      if(isDefined(var_1) && isPlayer(var_1) && isalive(var_1))
        return 1;
    }
  }

  return 0;
}

laser_trap_triggers(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_BD82096B5DA4B07F924F29");

  if(isDefined(var_0))
    var_0 delete();
}

super_onspawned(var_0, var_1) {
  self.custom_death_script = ::internal_isplayerindanger_think;

  switch (var_1) {
    case "_encstr_AC351138CA467148D7C7830BBC47513B6A43D8":
    case "_encstr_B22E0C8072FEF9C04F4F0BF324CF":
    case "_encstr_B1F8111B037642AEF0D9F6BD7698E18957B99B":
    case "_encstr_96EC0BA32B8D1AB7D70E8697E6":
      _id_13079(2500);
      break;
    default:
      _id_13079(1250);
      break;
  }

  self.vehicle_skipdeathcrash = 1;
  self.team = "_encstr_8E8405EA382B2A";
  self setvehicleteam(self.team);

  if(isDefined(var_1)) {
    level.ai_spawn_vehicle_func[var_1].count++;

    if(isDefined(var_0))
      scripts\cp\cp_modular_spawning::add_to_module_vehicles_list(var_0, var_1);
  }

  thread watch_for_vehicle_stuck();
  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

internal_isplayerindanger_think() {
  self vehicle_setspeedimmediate(0, 1, 1);

  if(isDefined(self.riders) && self.riders.size > 0) {
    foreach(var_1 in self.riders) {
      if(!isDefined(var_1) || !isalive(var_1)) {
        continue;
      }
      if(isDefined(var_1._blackboard) && isDefined(var_1._blackboard.chosenvehicleanimpos)) {
        if(istrue(var_1._blackboard.chosenvehicleanimpos.isincircle))
          var_1._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll = 1;
      }
    }
  }
}

heli_think_default() {
  thread heli_damagemonitor();
  thread heli_check_players();
  thread heli_move();
  thread engage_target_think();
  thread rumble_nearby_players();
}

heli_damagemonitor(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = 0;
  self.health = 1000000;

  if(!isDefined(var_1))
    var_1 = 2500;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
    self.health = 1000000;

    if(isDefined(var_4) && var_4 == self) {
      continue;
    }
    if(isDefined(var_16) && isDefined(var_16.owner) && var_16.owner == self) {
      continue;
    }
    if(isDefined(var_4) && isDefined(self.minigun) && var_4 == self.minigun) {
      continue;
    }
    if(scripts\cp\helicopter\cp_helicopter::is_snipe_kill(var_4, var_6, var_12)) {
      var_2++;

      if(var_2 == 1) {
        if(isDefined(self.headicon))
          setheadiconimage(self.headicon);

        self.headicon = undefined;
        var_4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BD2118AD2DD8C6BE9BDCD76CA1F6E0C1CAE47DB9ABC107EDC9E8");
        var_4 scripts\cp\cp_persistence::give_player_currency(500, "_encstr_8DEC06B1E943615B");
        playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], self.origin);
        var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", 1);
        level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
        self.minigun delete();

        if(isDefined(self.pilot))
          self.pilot delete();

        self notify("_encstr_A56411C8956359E896E676F5D9CA432D8D8D2B");
        self delete();
        return;
      }

      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
      continue;
    }

    if(!isexplosivedamagemod(var_7)) {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5D20E0DD2E8C2C9D6F627D09516675E");
    } else {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8");

      if(isDefined(var_12) && isDefined(var_12.basename)) {
        switch (var_12.basename) {
          case "_encstr_A93010035F88EE71B82FAD78F10352C7C518":
            break;
          case "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18":
            var_3 = 1400;
            break;
          default:
            break;
        }
      } else if(var_3 < 700)
        var_3 = 700;

      if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0) && !scripts\engine\utility::flag(var_0))
        scripts\engine\utility::flag_set(var_0);
      else {
        if(!istrue(self.needs_to_evade))
          self.needs_to_evade = 1;

        self notify("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    self.health_remaining = self.health_remaining - var_3;

    if(self.health_remaining <= var_1 * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["_encstr_B87011F355B2609793E9B902034B58788CA765"], self.origin);
      self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
      self.deathfx = 1;
    } else if(self.health_remaining <= var_1 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
      playFX(level._effect["_encstr_B87011F355B2609793E9B902034B58788CA765"], self.origin);
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var_1 * 0.75 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(self.headicon))
        setheadiconimage(self.headicon);

      self.headicon = undefined;

      if(isDefined(var_12) && issubstr(var_12.basename, "_encstr_8DCB085BEF657B4DCF0B")) {
        if(isDefined(var_4) && isPlayer(var_4))
          var_4 thread scripts\cp\cp_achievement::scriptable_setups();
      }

      if(isDefined(var_4) && isPlayer(var_4)) {
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BD2118AD2DD8C6BE9BDCD76CA1F6E0C1CAE47DB9ABC107EDC9E8");
        var_4 scripts\cp\cp_persistence::give_player_currency(500, "_encstr_8DEC06B1E943615B");
      }

      playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], self.origin);
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8", 1);
      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      self.minigun delete();

      if(isDefined(self.pilot))
        self.pilot delete();

      self notify("_encstr_A56411C8956359E896E676F5D9CA432D8D8D2B");
      self delete();
      continue;
    }

    if(isDefined(var_4) && isPlayer(var_4))
      var_4 scripts\cp\cp_persistence::give_player_currency(10, "_encstr_8DEC06B1E943615B");
  }
}

init_jugg_maze(var_0) {
  level.vtclassname = var_0;
  scripts\common\vehicle_build::build_rocket_deathfx("_encstr_A3462E0426A3A08F9573701A3A68618D26C905FEB16F70AF7FBBD00872426B384B4F1BFD1C375E01A60370587E5B3D12", "_encstr_A2B40B8E2C3B7DDB274B9D4B37", undefined, undefined, undefined, 0, 0, 0);
}

crash_deathfx() {
  self waittill("_encstr_A5D616CECAD0D28DC656F5C89516471A1A7B5BC1D895E8CA", var_0);
  playFX(level._effect["_encstr_B14E143325DB1182B8F8959E5698D09BB95FBFC78F08"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
}

get_helicopter_path_positions(var_0) {
  self.path_positions = [];
  var_1 = 12;
  var_2 = 2048;
  var_3 = 360 / var_1;
  var_4 = self.origin;
  self.flight_pos = undefined;
  self.flight_pos_dot = undefined;

  if(isDefined(var_0)) {
    if(isvector(var_0))
      var_5 = var_0;
    else
      var_5 = var_0.origin;
  } else
    var_5 = scripts\cp\utility::get_center_point_of_array(level.players);

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = var_3 * var_6;
    var_8 = cos(var_7) * var_2;
    var_9 = sin(var_7) * var_2;
    var_10 = var_4[0] + var_8;
    var_11 = var_4[1] + var_9;
    var_12 = var_4[2];

    if(validate_pos((var_10, var_11, var_12), var_5)) {
      self.path_positions[self.path_positions.size] = (var_10, var_11, var_12);
      continue;
    }
  }
}

draw_capsule_until_notifies(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B4D10ADC950BE4EB76DE8536");

  for(;;) {
    thread scripts\engine\utility::draw_capsule(var_0, 32, 32, (0, 0, 0), var_1, 0, 1);
    waitframe();
  }
}

validate_pos(var_0, var_1) {
  if(isDefined(var_1))
    var_0 = (var_0[0], var_0[1], var_1[2] + 1500);

  if(isDefined(level.heli_triggers) && level.heli_triggers.size > 0) {
    var_2 = level.heli_triggers;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(!isDefined(var_2[var_3])) {
        level.heli_triggers = scripts\engine\utility::array_remove(level.heli_triggers, var_2[var_3]);
        continue;
      }

      if(isDefined(self.move_trigger) && self.move_trigger == var_2[var_3]) {
        continue;
      }
      if(ispointinvolume(var_0, var_2[var_3]))
        return 0;
    }
  }

  if(scripts\engine\trace::capsule_trace_passed(self.origin, var_0, 256, 512, self.angles, self)) {
    if(isDefined(var_1)) {
      var_4 = var_0 - self.origin;

      if(isvector(var_1))
        var_5 = vectortoangles(var_1 - self.origin);
      else if(isDefined(var_1.velo_forward))
        var_5 = vectortoangles(var_1.velo_forward - self.origin);
      else
        var_5 = vectortoangles(var_1.origin - self.origin);

      var_6 = anglesToForward(var_5);
      var_7 = vectordot(var_4, var_6);

      if(isDefined(self.flight_pos)) {
        if(var_7 > self.flight_pos_dot) {
          self.flight_pos_dot = var_7;
          self.flight_pos = var_0;
        }
      } else {
        self.flight_pos_dot = var_7;
        self.flight_pos = var_0;
      }

      if(var_7 > 0.3) {
        return 1;
        return;
      }

      return 0;
      return;
    } else if(scripts\engine\math::is_point_in_front(var_0))
      return 1;
    else
      return 0;
  } else
    return 0;
}

point_is_towards_target(var_0, var_1) {
  var_2 = var_0 - self.origin;
  var_3 = vectortoangles(var_1.origin - self.origin);
  var_4 = anglesToForward(var_3);
  var_5 = vectordot(var_2, var_4);
  return var_5 > 0.3;
}

update_every_frame() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(isDefined(self.update_state)) {
      switch (self.update_state) {
        default:
          break;
      }
    }

    waitframe();
  }
}

heli_move() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = self.origin[2];
  self.chopper_height = var_0;
  var_1 = 0;
  var_2 = 5;
  self vehicle_setspeed(75, 30);

  for(;;) {
    if(istrue(self.needs_to_evade)) {
      heli_evade((self.origin[0], self.origin[1], self.chopper_height));
      continue;
    }

    if(!isDefined(self.best_target)) {
      heli_go_search();
      continue;
    }

    if(should_move_to_target(self.minigun, self.best_target)) {
      heli_move_to_target(self.best_target);
      continue;
    }

    wait 1;
  }
}

should_move_to_target(var_0, var_1) {
  var_2 = 6250000;

  if(isDefined(self.should_move_to_target_dist))
    var_2 = self.should_move_to_target_dist * self.should_move_to_target_dist;

  if(istrue(self.landed)) {
    self.landed = undefined;
    return 1;
  }

  if(distance2dsquared(var_0.origin, var_1.origin) > var_2 || isDefined(self.gotopos) && distance2dsquared(var_0.origin, self.gotopos) > var_2)
    return 1;

  return 0;
}

heli_move_to_target(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self cleartargetyaw();
  self cleargoalyaw();
  self setlookatent(var_0);

  if(isDefined(self.best_target))
    get_helicopter_path_positions(self.best_target);
  else
    get_helicopter_path_positions();

  var_1 = undefined;

  if(isDefined(self.flight_pos))
    var_1 = self.flight_pos;
  else if(isDefined(self.path_positions) && self.path_positions.size > 0)
    var_1 = scripts\engine\utility::random(self.path_positions);

  if(isDefined(var_1)) {
    self setneargoalnotifydist(750);

    if(distance2dsquared(self.origin, var_1) > 1440000) {
      self vehicle_setspeed(50, 30, 30);
      self setvehgoalpos(var_1, 1);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var_1, 0);
    }

    scripts\engine\utility::_id_143B9(15, "_encstr_B4D10ADC950BE4EB76DE8536");
  }

  wait 5;
}

heli_evade(var_0) {
  self notify("_encstr_8101178E58D6B49B3B7D59CE2CB9A53B59F558361DA5F6DCDC");
  self endon("_encstr_8101178E58D6B49B3B7D59CE2CB9A53B59F558361DA5F6DCDC");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 5000;
  get_helicopter_path_positions();
  var_2 = self.path_positions;

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = 0;
    var_4 = var_2[0];
    self cleargoalyaw();
    self cleartargetyaw();
    self clearlookatent();

    foreach(var_8, var_6 in var_2) {
      if(isvector(var_6))
        var_7 = var_6;
      else
        var_7 = var_6.origin;

      if(scripts\engine\utility::within_fov(self.origin, self.angles, var_7, cos(25))) {
        var_4 = var_6;
        var_3 = var_8;
        break;
      }
    }

    if(isvector(var_2[var_3]))
      self setvehgoalpos(var_2[var_3], 0);
    else
      self setvehgoalpos(var_2[var_3].origin, 0);

    var_9 = 1500;
    var_9 = var_9 * (var_1 / 5000);
    var_10 = 100;
    var_10 = var_10 * (var_1 / 5000);
    self setneargoalnotifydist(1500);
    self vehicle_setspeed(100, 50, 50);
    var_11 = 0;
    var_8 = var_3 + 1;
    var_12 = randomint(4);

    while(var_11 < var_2.size - 1) {
      if(var_8 >= var_2.size)
        var_8 = 0;

      if(isvector(var_2[var_8]))
        self setvehgoalpos(var_2[var_8], 0);
      else
        self setvehgoalpos(var_2[var_8].origin, 0);

      self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
      var_11++;
      var_8++;

      if(var_11 == var_12) {
        break;
      }
    }
  }

  self.needs_to_evade = 0;
}

rumble_nearby_players() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    playrumbleonposition("_encstr_97011287E9A8326880FBF2BF9329BAEB19652317", self.origin);
    wait 0.1;
  }
}

circle_around_target() {
  get_helicopter_path_positions();
}

heli_check_players() {
  self endon("_encstr_AD75063D571AE108");
  self.best_target = undefined;
  var_0 = 5;
  var_1 = 0;

  for(;;) {
    var_2 = heli_get_target();

    if(isDefined(var_2)) {
      var_1 = 0;
      self notify("_encstr_B6DD0D1D582776958ED7667B5DDC91");
      self.best_target = var_2;
    } else {
      self notify("_encstr_951A0CC8F9F058352B87B857677B");
      var_1 = var_1 + 0.25;

      if(var_1 >= var_0) {
        var_1 = 0;
        self.best_target = undefined;
      }
    }

    wait 0.25;
  }
}

engage_target_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_85C014F9B2CFFF701F1FD1F35AC7383D87ABD0E05A07");
  self endon("_encstr_85C014F9B2CFFF701F1FD1F35AC7383D87ABD0E05A07");
  self endon("_encstr_AD75063D571AE108");
  self.minigun setmode("_encstr_849007B268BD03DFD8");
  self.nextfiretime = gettime() + 2000;

  for(;;) {
    while(isDefined(self.best_target)) {
      self sethoverparams(150, 35, 35);

      if(istrue(self.has_rockets)) {
        wait 2;

        if(istrue(self.rockets_ready))
          scripts\cp\helicopter\cp_helicopter::hover_and_shoot_rockets(self.best_target);
      } else {
        self.minigun settargetentity(self.best_target, (0, 0, 40));
        var_0 = scripts\engine\utility::waittill_any_ents_or_timeout_return(3, self.minigun, "_encstr_97881123FB639E8883C74F55DF6B6066CF12BB");
        scripts\cp\helicopter\cp_helicopter::shoot_at_target();
      }

      self notify("_encstr_96EF0FA30BC9D9B21DEB56E6CE583BCA46");
      self sethoverparams(0, 0, 0);
    }

    wait 1;
  }
}

heli_get_target() {
  var_0 = self.origin;
  var_1 = undefined;
  var_2 = scripts\engine\utility::get_array_of_closest(var_0, level.players);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!var_4 scripts\cp\utility::is_valid_player(undefined, 0) || istrue(var_4 isinfreefall()) || istrue(var_4 isskydiving()) || istrue(var_4 isparachuting())) {
      continue;
    }
    var_0 = (var_4.origin[0], var_4.origin[1], self.chopper_height);

    if(!istrue(self.has_rockets)) {
      if(scripts\engine\trace::ray_trace_passed(var_0, var_4.origin + (0, 0, 10), [self, var_4])) {
        var_1 = var_4;
        self.gotopos = var_0;
      }
    }

    if(!isDefined(var_1)) {
      var_5 = anglestoright(var_4.angles);
      var_6 = anglestoleft(var_4.angles);
      var_7 = anglesToForward(var_4.angles);
      var_8 = var_7 * -1;
      var_9 = [var_5, var_6, var_7, var_8];

      foreach(var_11 in var_9) {
        if(isDefined(var_4.vehicle))
          var_12 = [self, var_4, var_4.vehicle];
        else
          var_12 = [self, var_4];

        var_0 = (var_4.origin[0], var_4.origin[1], 0) + (var_11[0], var_11[1], 0) * 1800 + (0, 0, self.chopper_height);

        if(scripts\engine\trace::ray_trace_passed(var_0, var_4.origin + (0, 0, 10), var_12)) {
          var_1 = var_4;
          self.gotopos = var_0;
          self.nocircle = 1;
          return var_1;
        }
      }
    }

    if(isDefined(var_1)) {
      break;
    }
  }

  return var_1;
}

heli_go_search() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B6DD0D1D582776958ED7667B5DDC91");
  self endon("_encstr_B8950FB9AC59C8DCF5E8F6AF5667C246CA");
  self endon("_encstr_AD75063D571AE108");
  self clearlookatent();
  self cleartargetyaw();
  self cleargoalyaw();

  if(isDefined(self.minigun))
    self.minigun cleartargetentity();

  self vehicle_setspeed(90, 15);
  self setneargoalnotifydist(1000);

  while(!isDefined(self.best_target)) {
    get_helicopter_path_positions();

    if(isDefined(self.flight_pos)) {
      var_0 = self.flight_pos;
      self setvehgoalpos(var_0, 0);
    } else if(isDefined(self.path_positions) && self.path_positions.size > 0) {
      var_0 = scripts\engine\utility::random(self.path_positions);
      self setvehgoalpos(var_0, 0);
    }

    self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  }
}

is_vehicle_spawnpoint() {
  return scripts\cp\cp_spawner_scoring::get_spawn_scoring_type() == "_encstr_847610EC5686D2C63659AFCD8358DD37AC39";
}