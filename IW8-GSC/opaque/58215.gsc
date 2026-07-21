/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58215.gsc
***********************************************/

x1opsnpcweaponbarrelmodel() {
  scripts\engine\utility::create_func_ref("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", ::_id_134FA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_8AEA073693CA16D12B", ::x1opsnpcheadmodel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_BAF609D2739647C4853A2B", ::x1opsnpcweaponmagmodel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::x1opspreplayertransition);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", _calloutmarkerping_poolidisdanger::x1spyplane);
}

x1opsnpcheadmodel(var_0) {
  var_0.maxhealth = 2500;
  var_0.health = var_0.maxhealth;
  var_0.vehicle_specific_onentervehicle = ::x1opsnpcweaponstockmodel;
  var_0.vehicle_specific_onexitvehicle = ::x1opsplayertransition;
  var_1 = var_0 getentitynumber();
  var_0 being_pickedup(var_1);
  var_0 thread _id_12C04(var_1);
}

x1opsnpcweaponmagmodel() {
  if(1) {
    return;
  }
  level.zombiejumpbar = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_8E9213A9E1E5F340FFB2C35577582D07179BDFABBA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread x1opsnpcs(var_0, 3);
}

x1opsnpcs(var_0, var_1) {
  wait(var_1);
  var_2 = getdvarint("_encstr_8F7A0BD1E5E15304B8CF7989FF", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_5);

      if(isDefined(var_6))
        level.littlebirds = scripts\engine\utility::array_add(level.littlebirds, var_6);
    }
  }

  level notify("_encstr_A67B1EDA3025F33D2B8F5A29AD708217C16961E258F04F3998F9513FBD300D2F");
}

_id_13581(var_0, var_1, var_2, var_3) {
  var_4 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_0, var_1, undefined, var_2);

  if(istrue(var_3))
    return var_4;
}

_id_134FA(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_1);

  if(isDefined(var_2))
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "_encstr_A266062032BD7723", var_0, undefined, 1);
}

x1opsnpcweaponstockmodel(var_0, var_1, var_2, var_3) {}

x1opsplayertransition(var_0, var_1, var_2, var_3) {}

being_pickedup(var_0) {
  if(!isDefined(level.zombiejumpbar))
    level.zombiejumpbar = [];

  level.zombiejumpbar[var_0] = self;
}

_id_12C04(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.zombiejumpbar[var_0] = undefined;
}

x1opspreplayertransition(var_0, var_1) {
  if(1) {
    return;
  }
  var_2 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::x1opsnpcweaponreceivermodel;

  return var_2;
}

x1opsnpcweaponreceivermodel() {
  thread x1opsrespawnselection();
}

x1opsrespawnselection() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }
      break;
    }
  }
}