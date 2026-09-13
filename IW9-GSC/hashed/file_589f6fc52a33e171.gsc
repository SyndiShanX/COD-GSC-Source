/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_589f6fc52a33e171.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_techo", ::_id_24D2A56D4D62BD05);
}

_id_24D2A56D4D62BD05() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_techo")) {
    return;
  }
  scripts\engine\utility::create_func_ref("set_vehicle_anims_asierra", ::set_vehicle_anims_asierra);
  callbacks = [];
  callbacks["spawn"] = ::_id_40C39A1C05EF19AB;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_techo", callbacks);
  _id_DEC083BCE4B10A7F(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("veh9_techo"));
}

#using_animtree("mp_vehicles_always_loaded");

set_vehicle_anims_asierra(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_asierra_driver_exit_patrol;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat = % vh_asierra_driver_exit_combat_idle;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run = % vh_asierra_driver_exit_combat_run;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim = % vh_asierra_pass_exit_patrol;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat = % vh_asierra_pass_exit_combat_idle;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_run = % vh_asierra_pass_exit_combat_run;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[7].vehicle_getoutanim = % vh_asierra_bed_exit_patrol;
  _id_E4B7E99A96C8829F[7].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[7].vehicle_getoutanim_combat = % vh_asierra_bed_exit_combat_idle;
  _id_E4B7E99A96C8829F[7].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[7].vehicle_getoutanim_combat_run = % vh_asierra_bed_exit_combat_idle;
  _id_E4B7E99A96C8829F[7].vehicle_getoutanim_combat_run_clear = 0;
  return _id_E4B7E99A96C8829F;
}

_id_40C39A1C05EF19AB(spawndata, _id_EE8DA5624236DC89) {
  spawndata = scripts\cp_mp\vehicles\vehicle_spawn::_id_37480E9C9C701CF2("veh9_techo", spawndata);

  if(isDefined(spawndata.script_forcecolor)) {
    switch (spawndata.script_forcecolor) {
      case "tan":
        if(scripts\common\utility::iscp())
          spawndata.modelname = "veh9_civ_lnd_techo_vehphys_cp_dirty_tan";
        else
          spawndata.modelname = "veh9_civ_lnd_techo_vehphys_mp_dirty_tan";

        break;
      case "black":
        if(scripts\common\utility::iscp())
          spawndata.modelname = "veh9_civ_lnd_techo_vehphys_cp_dirty_black";
        else
          spawndata.modelname = "veh9_civ_lnd_techo_vehphys_mp_dirty_black";

        break;
      default:
        if(scripts\common\utility::iscp())
          spawndata.modelname = "veh9_civ_lnd_techo_vehphys_cp_dirty";
        else
          spawndata.modelname = "veh9_civ_lnd_techo_vehphys_mp_dirty";

        break;
    }
  }

  vehicle = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle))
    return undefined;

  vehicle.classname_mp = "script_vehicle_veh9_techo_ai";
  scripts\cp_mp\vehicles\vehicle::vehicle_create(vehicle, "veh9_techo", spawndata);
  vehicle.objweapon = makeweapon(scripts\cp_mp\vehicles\vehicle_damage::_id_7AAA7AE503292F43("veh9_techo"));
  scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_registerinstance(vehicle);
  scripts\cp_mp\vehicles\vehicle::vehicle_createlate(vehicle, spawndata);
  vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();
  vehicle thread scripts\cp_mp\vehicles\vehicle::_id_1B69321FF9937FC5();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_techo", "create"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_techo", "create")]](vehicle);

  vehicle scripts\engine\utility::ent_flag_init("unloaded");
  vehicle scripts\engine\utility::ent_flag_init("loaded");

  if(isDefined(level.vehicleinitthread[_func_40FD49171FAD19D3(spawndata.vehicletype)][vehicle.classname_mp]))
    vehicle thread[[level.vehicleinitthread[_func_40FD49171FAD19D3(spawndata.vehicletype)][vehicle.classname_mp]]]();

  return vehicle;
}

_id_DEC083BCE4B10A7F(_id_E2818AD39A3341B4) {
  modelname = "veh9_civ_lnd_techo_vehphys_mp_dirty";
  classname = "script_vehicle_veh9_techo_ai";
  vehicletype = "veh9_techo_physics_mp";

  if(scripts\common\utility::iscp()) {
    modelname = "veh9_civ_lnd_techo_vehphys_cp_dirty";
    vehicletype = "veh9_techo_physics_cp";
  }

  scripts\common\vehicle_build::build_template("truck", modelname, vehicletype, classname);
  scripts\common\vehicle_build::build_localinit(::_id_59FC728287347948);
  scripts\common\vehicle_build::build_aianims(::_id_F11DC3C61B5CDD5B, ::_id_D038F9C97D05DD23, "techo");
  scripts\common\vehicle_build::build_unload_groups(::_id_88FC457F0920A596);
}

_id_59FC728287347948() {
  self.script_badplace = 1;
  self.vehicleanimalias = "techo_mp";

  if(scripts\common\utility::iscp())
    self.vehicleanimalias = "techo_cp";
}

_id_D038F9C97D05DD23(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % reb_com_veh8_techo_fl_door_open;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim = % reb_com_veh8_techo_fr_door_open;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim = % reb_com_veh8_techo_bl_door_open;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim = % reb_com_veh8_techo_br_door_open;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}

_id_F11DC3C61B5CDD5B() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[0].sittag = "TAG_SEAT_0";
  _id_E4B7E99A96C8829F[1].sittag = "TAG_SEAT_1";
  _id_E4B7E99A96C8829F[2].sittag = "TAG_SEAT_2";
  _id_E4B7E99A96C8829F[3].sittag = "TAG_SEAT_3";
  _id_E4B7E99A96C8829F[4].sittag = "TAG_SEAT_4";
  _id_E4B7E99A96C8829F[5].sittag = "TAG_SEAT_5";
  _id_E4B7E99A96C8829F[6].sittag = "TAG_SEAT_6";
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[6].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[1].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[2].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[3].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[4].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[5].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[6].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[0].death_impulse = 0;
  _id_E4B7E99A96C8829F[1].death_impulse = 1;
  _id_E4B7E99A96C8829F[2].death_impulse = 1;
  _id_E4B7E99A96C8829F[3].death_impulse = 1;
  _id_E4B7E99A96C8829F[4].death_impulse = 1;
  _id_E4B7E99A96C8829F[5].death_impulse = 1;
  _id_E4B7E99A96C8829F[6].death_impulse = 1;
  _id_E4B7E99A96C8829F[0]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[1]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[2]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[3]._id_BCD0A0AFD54C6491 = 0;
  _id_E4B7E99A96C8829F[4]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[5]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[6]._id_BCD0A0AFD54C6491 = 1;
  _id_E4B7E99A96C8829F[0]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[1]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[2]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[3]._id_70AA9EAF339DDB20 = 0;
  _id_E4B7E99A96C8829F[4]._id_70AA9EAF339DDB20 = 1;
  _id_E4B7E99A96C8829F[5]._id_70AA9EAF339DDB20 = 1;
  _id_E4B7E99A96C8829F[6]._id_70AA9EAF339DDB20 = 1;
  return _id_E4B7E99A96C8829F;
}

_id_88FC457F0920A596() {
  unload_groups = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 7; _id_AC0E594AC96AA3A8++)
    unload_groups["default"][_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6];
  unload_groups["backseats"] = [2, 3];
  unload_groups["entirecab"] = [0, 1, 2, 3];
  unload_groups["bed"] = [4, 5, 6];
  return unload_groups;
}

_id_CD8BE6F9E047FA65(riders, spawninvehicle) {
  if(!isDefined(spawninvehicle))
    spawninvehicle = 0;

  thread _id_A32C19965223C966();

  foreach(index, rider in riders) {
    _id_B87E69DF003B39F5 = scripts\common\vehicle_aianim::get_availablepositions();

    if(isDefined(rider.spawner.script_startingposition))
      rider.script_startingposition = int(rider.spawner.script_startingposition);

    rider.script_startingposition = index;
    rider.spawner.script_startingposition = index;
    pos = scripts\common\vehicle_aianim::choose_vehicle_position(rider, _id_B87E69DF003B39F5, 0);
    rider.vehicle_position = pos.vehicle_position;
    rider thread scripts\vehicle\vehicle_common::entervehicle(self, spawninvehicle, pos, scripts\common\vehicle_aianim::anim_pos(self, pos.vehicle_position));
    self.riders[self.riders.size] = rider;
    rider.ridingvehicle = self;

    if(isDefined(rider.team) && pos.vehicle_position == 0)
      rider thread _id_CD67F03AFF52AF6D(self);
  }
}

_id_A32C19965223C966() {
  self waittill("death", attacker, meansofdeath, _id_06B62DB6EEC868E2, damagelocation);
  thread scripts\common\vehicle_code::vehicle_killriders();
}

_id_CD67F03AFF52AF6D(vehicle) {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, self.team);
  self waittill("death", attacker, meansofdeath, _id_06B62DB6EEC868E2, damagelocation);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, "neutral");
}