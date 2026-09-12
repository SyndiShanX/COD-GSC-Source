/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58215.gsc
***********************************************/

function x1opsnpcweaponbarrelmodel() {
  scripts\engine\utility::create_func_ref("little_bird_mg", &ref_134FA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird_mg", "create", &x1opsnpcheadmodel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird_mg", "initLate", &x1opsnpcweaponmagmodel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird_mg", "spawnCallback", &x1opspreplayertransition);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("little_bird_mg", &_calloutmarkerping_poolidisdanger::x1spyplane);
}

function x1opsnpcheadmodel(var_0) {
  var_0.maxhealth = 2500;
  var_0.health = var_0.maxhealth;
  var_0.vehicle_specific_onentervehicle = &x1opsnpcweaponstockmodel;
  var_0.vehicle_specific_onexitvehicle = &x1opsplayertransition;
  var_1 = var_0 getentitynumber();
  being_pickedup(var_0, var_1);
  thread ref_12C04(var_0);
}

function x1opsnpcweaponmagmodel() {
  if(true) {
    return;
  }

  level.zombiejumpbar = [];
  var_0 = scripts\engine\utility::getStructArray("littlebirdMG_spawn", "targetname");
  thread x1opsnpcs(var_0, 3);
}

function x1opsnpcs(var_0, var_1) {
  wait var_1;
  var_2 = getdvarint("r_reflectionProbeGenerate", 0) == 0;

  if(var_2) {
    foreach(var_4 in var_0) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_6 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_5);

      if(isDefined(var_6)) {
        level.littlebirds = scripts\engine\utility::array_add(level.littlebirds, var_6);
      }
    }
  }

  level notify("little_birds_mg_done_spawning");
}

function ref_13581(var_0, var_1, var_2, var_3) {
  var_4 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_0, var_1, undefined, var_2);

  if(istrue(var_3)) {
    return var_4;
  }
}

function ref_134FA(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 100);
  var_1.angles = var_0.angles * (0, 1, 0);
  var_1.owner = var_0;
  var_2 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_1);

  if(isDefined(var_2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_2, "pilot", var_0, undefined, 1);
    return;
  }
}

function x1opsnpcweaponstockmodel(var_0, var_1, var_2, var_3) {}

function x1opsplayertransition(var_0, var_1, var_2, var_3) {}

function being_pickedup(var_0) {
  if(!isDefined(level.zombiejumpbar)) {
    level.zombiejumpbar = [];
  }

  level.zombiejumpbar[var_0] = self;
}

function ref_12C04(var_0) {
  self waittill("death");
  level.zombiejumpbar[var_0] = undefined;
}

function x1opspreplayertransition(var_0, var_1) {
  if(true) {
    return;
  }

  var_2 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var_0, var_1);

  if(isDefined(var_2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &x1opsnpcweaponreceivermodel;
  }

  return var_2;
}

function x1opsnpcweaponreceivermodel() {
  thread x1opsrespawnselection();
}

function x1opsrespawnselection() {
  var_0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var_0);
  var_1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("little_bird_mg")) {
      var_2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var_0, var_1);

      if(!isDefined(var_2)) {
        continue;
      }

      break;
    }
  }
}