/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront.gsc
**********************************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_waterfront\gen\mp_jup_waterfront_art;
#using scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio;
#using scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_fx;
#using scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_lighting;
#using scripts\mp\utility\game;
#namespace mp_jup_waterfront;

function main() {
  scripts\mp\maps\mp_jup_waterfront\gen\mp_jup_waterfront_art::main();
  scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_fx::main();
  scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_lighting::main();
  scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_waterfront");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread function_1682cf22619a5e55();

  while(true) {
    level thread function_1e575c6c1a602ca2();
    level thread bus_spawn();
    wait 15;
    level thread train_spawn();
    wait 30;
  }
}

function bus_spawn() {
  var_573498b6d349be06 = getStructArray("bus_start", "script_noteworthy");

  foreach(var_25c4448fdb8fcb80 in var_573498b6d349be06) {
    var_872fe47787e8589a = spawn_model("veh8_civ_lnd_buniform_uk_static_closed", var_25c4448fdb8fcb80.origin, var_25c4448fdb8fcb80.angles);
    var_25c4448fdb8fcb80 thread vehicle_movement(var_872fe47787e8589a);
  }
}

function function_1e575c6c1a602ca2() {
  var_573498b6d349be06 = getStructArray("car_start", "script_noteworthy");

  foreach(var_25c4448fdb8fcb80 in var_573498b6d349be06) {
    var_bc22b8fed0d6d1fe = randomint(3);

    if(var_bc22b8fed0d6d1fe == 0) {
      var_872fe47787e8589a = spawn_model("veh8_civ_lnd_buniform_uk_static_closed", var_25c4448fdb8fcb80.origin, var_25c4448fdb8fcb80.angles);
      thread scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio::bus_audio(var_872fe47787e8589a);
    } else if(var_bc22b8fed0d6d1fe == 1) {
      var_872fe47787e8589a = spawn_model("veh9_civ_lnd_van_palfa_static", var_25c4448fdb8fcb80.origin, var_25c4448fdb8fcb80.angles);
      thread scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio::van_audio(var_872fe47787e8589a);
    } else if(var_bc22b8fed0d6d1fe == 2) {
      var_872fe47787e8589a = spawn_model("jup_surge_veh8_civ_lnd_victor40", var_25c4448fdb8fcb80.origin, var_25c4448fdb8fcb80.angles);
      thread scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio::car_audio(var_872fe47787e8589a);
    }

    var_25c4448fdb8fcb80 thread vehicle_movement(var_872fe47787e8589a);
  }
}

function train_spawn() {
  var_43d4efeadf93a39e = getStructArray("train_start", "script_noteworthy");

  foreach(var_2d32422f90ea0d48 in var_43d4efeadf93a39e) {
    trainmodel = spawn_model("jup_machinery_london_train_carriage_01", var_2d32422f90ea0d48.origin, var_2d32422f90ea0d48.angles);
    var_2d32422f90ea0d48 thread vehicle_movement(trainmodel);

    if(isDefined(var_2d32422f90ea0d48.script_parameters)) {
      thread scripts\mp\maps\mp_jup_waterfront\mp_jup_waterfront_audio::train_audio(trainmodel, var_2d32422f90ea0d48.script_parameters);
    }
  }
}

function vehicle_movement(vehmodel) {
  targetpoint = getStruct(self.target, "targetname");
  currentpoint = self;

  while(isDefined(targetpoint)) {
    var_7a7468a3f3fd54b = distance(currentpoint.origin, targetpoint.origin);
    var_4187040fa98742ee = var_7a7468a3f3fd54b / 400;
    thread function_bd3aa5ee59da5a59(vehmodel, targetpoint.origin, targetpoint.angles, var_4187040fa98742ee);
    wait var_4187040fa98742ee;
    vehmodel delete();
    break;
  }
}

function function_bd3aa5ee59da5a59(vehmodel, targetorigin, targetangle, var_4187040fa98742ee) {
  vehmodel moveTo(targetorigin, var_4187040fa98742ee);
  vehmodel rotateTo(targetangle, 0.1);
}

function function_1682cf22619a5e55() {
  level waittill("infil_setup_complete");
  var_6120df12544987e8 = getEnt("static_infil_van", "targetname");

  if(gameflag("infil_will_run") && isDefined(var_6120df12544987e8)) {
    var_6120df12544987e8 hide();
  }
}