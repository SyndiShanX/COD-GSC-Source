/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58215.gsc
***********************************************/

function x1opsnpcweaponbarrelmodel() {
  scripts\engine\utility::create_func_ref("little_bird_mg", &ref_134fa);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird_mg", "create", &x1opsnpcheadmodel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird_mg", "initLate", &x1opsnpcweaponmagmodel);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird_mg", "spawnCallback", &x1opspreplayertransition);
  scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_registeroutoftimecallback("little_bird_mg", &_calloutmarkerping_poolidisdanger::x1spyplane);
}

function x1opsnpcheadmodel(var0) {
  var0.maxhealth = 2500;
  var0.health = var0.maxhealth;
  var0.vehicle_specific_onentervehicle = &x1opsnpcweaponstockmodel;
  var0.vehicle_specific_onexitvehicle = &x1opsplayertransition;
  var1 = var0 getentitynumber();
  being_pickedup(var0, var1);
  thread ref_12c04(var0);
}

function x1opsnpcweaponmagmodel() {
  if(true) {
    return;
  }

  level.zombiejumpbar = [];
  var0 = scripts\engine\utility::getStructArray("littlebirdMG_spawn", "targetname");
  thread x1opsnpcs(var0, 3);
}

function x1opsnpcs(var0, var1) {
  wait var1;
  var2 = getdvarint("LLQQOPKTKM", 0) == 0;

  if(var2) {
    foreach(var4 in var0) {
      var5 = spawnStruct();
      var5.origin = var4.origin;
      var5.angles = var4.angles;
      var6 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var5);

      if(isDefined(var6)) {
        level.littlebirds = scripts\engine\utility::array_add(level.littlebirds, var6);
      }
    }
  }

  level notify("little_birds_mg_done_spawning");
}

function ref_13581(var0, var1, var2, var3) {
  var4 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var0, var1, undefined, var2);

  if(istrue(var3)) {
    return var4;
  }
}

function ref_134fa(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 100);
  var1.angles = var0.angles * (0, 1, 0);
  var1.owner = var0;
  var2 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var1);

  if(isDefined(var2)) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, "pilot", var0, undefined, 1);
    return;
  }
}

function x1opsnpcweaponstockmodel(var0, var1, var2, var3) {}

function x1opsplayertransition(var0, var1, var2, var3) {}

function being_pickedup(var0) {
  if(!isDefined(level.zombiejumpbar)) {
    level.zombiejumpbar = [];
  }

  level.zombiejumpbar[var0] = self;
}

function ref_12c04(var0) {
  self waittill("death");
  level.zombiejumpbar[var0] = undefined;
}

function x1opspreplayertransition(var0, var1) {
  if(true) {
    return;
  }

  var2 = _calloutmarkerping_poolidisdanger::x1opsruntoicon(var0, var1);

  if(isDefined(var2) && scripts\cp\vehicles\vehicle_spawn_cp::vehicle_spawn_cp_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &x1opsnpcweaponreceivermodel;
  }

  return var2;
}

function x1opsnpcweaponreceivermodel() {
  thread x1opsrespawnselection();
}

function x1opsrespawnselection() {
  var0 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self), var0);
  var1 = spawnStruct();

  for(;;) {
    wait 60;

    if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle("little_bird_mg")) {
      var2 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("little_bird_mg", var0, var1);

      if(!isDefined(var2)) {
        continue;
      }

      break;
    }
  }
}