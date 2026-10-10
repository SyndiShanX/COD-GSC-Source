/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\equipment\bunkerbuster.gsc
*******************************************************/

#using scripts\cp\cp_outofbounds;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace bunkerbuster;

function function_3d78dd516c25ef77(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("explode");
  grenade endon("death");
  grenade thread function_be84a39b52576d18();
  grenade thread function_e241396812ed67b2();
  grenade waittill("missile_stuck", stuckto);
  function_2d7c3d3cba3b7824(grenade, stuckto);
}

function function_2d7c3d3cba3b7824(grenade, var_a9f071baf842f12a) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");
  var_e29c6802d3127907 = getdvarfloat(@ "hash_f1406ba08fa573e", 0.25);
  wait var_e29c6802d3127907;
  grenade setscriptablepartstate("effects", "plant", 0);
  stuckto = var_a9f071baf842f12a;
  isunderwater = undefined;

  if(istrue(isunderwater)) {
    function_c8fd05bf21971a04(grenade, "dig_fail");
    function_3a35103112044e22(grenade);
    function_2c9ec2084ca01277(grenade, 0);
    return;
  }

  if(isDefined(stuckto)) {
    grenade childthread function_a7e67bcacd313b7d(stuckto);
    grenade.stuckto = stuckto;

    if(isPlayer(stuckto)) {
      function_a9dfe926fabd3b25(grenade);
    } else if(isai(stuckto)) {
      function_579620dc242d8f0(grenade, stuckto);
    } else if(stuckto.classname == "grenade" || stuckto.classname == "misc_turret" || stuckto.classname == "scriptable") {
      function_c8fd05bf21971a04(grenade, "dig_fail");
      function_3a35103112044e22(grenade);
      function_2c9ec2084ca01277(grenade, 0);
    } else if(stuckto.classname == "script_vehicle") {
      function_6e25a608eafbc362(grenade, stuckto);
    } else {
      function_9c1241b88a86e763(grenade);
    }

    return;
  }

  function_9c1241b88a86e763(grenade);
}

function function_a7e67bcacd313b7d(stuckto) {
  self endon("death");
  self endon("explode");

  if(isPlayer(stuckto)) {
    return;
  }

  if(isagent(stuckto)) {
    return;
  }

  stuckto waittill("death");
  thread function_a5a20b852c325190();
}

function function_579620dc242d8f0(grenade, stuckto) {
  victim = stuckto;
  grenadestate = "player_stuck";
  grenade thread scripts\cp\weapon::grenadestuckto(grenade, victim);
  function_c8fd05bf21971a04(grenade, grenadestate);
  function_3a35103112044e22(grenade);
  victim childthread function_3355863915967bb(grenade);
  function_2c9ec2084ca01277(grenade, grenadestate);
}

function function_3355863915967bb(grenade) {
  var_e601acf6ad00af27 = getdvarint(@ "hash_36b6fe748db87bee", 5);
  numticks = getdvarint(@ "hash_d7df18c5f0ec5694", 8);
  maxtime = getdvarfloat(@ "hash_6eb6ba9e7ce00943", 0.6);
  starttime = gettime();

  for(curticks = 0; curticks < numticks; curticks++) {
    self dodamage(var_e601acf6ad00af27, grenade.origin, grenade.owner, grenade, "MOD_EXPLOSIVE", grenade.weapon_object);
    wait maxtime / numticks;
  }
}

function function_a9dfe926fabd3b25(grenade) {
  victim = grenade.stuckto;
  grenade thread scripts\cp\weapon::grenadestuckto(grenade, victim);
  function_c8fd05bf21971a04(grenade, 1);
  function_3a35103112044e22(grenade);
  thread function_2c9ec2084ca01277(grenade);
}

function function_9c1241b88a86e763(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");
  upvec = anglestoup(grenade.angles);
  offset = getdvarint(@ "hash_e3ecbcc6d770d476", 50);
  ignorearray = [grenade];
  var_b376fa2d061141c0 = grenade.origin;
  surfacenormal = anglestoup(grenade.angles);
  var_5996067fa75e09d4 = 0;

  while(offset <= 200) {
    var_28ae17b3ccee3b7e = upvec * -1 * offset;
    endorigin = grenade.origin + var_28ae17b3ccee3b7e;
    traceback = scripts\engine\trace::ray_trace(endorigin, grenade.origin, ignorearray, scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0, 0, 0), 1);

    if(traceback["hittype"] != "hittype_none") {
      var_b376fa2d061141c0 = traceback["position"];
      surfacenormal = traceback["normal"];
      var_5996067fa75e09d4 = 1;
      break;
    }

    offset += getdvarint(@ "hash_e3ecbcc6d770d476", 50);
    waitframe();
  }

  if(var_5996067fa75e09d4) {
    var_5996067fa75e09d4 = function_8f7774e4e68d2a43(grenade, var_b376fa2d061141c0, surfacenormal);
  }

  worldup = anglestoup(self getworldupreferenceangles());
  grenadeup = anglestoup(grenade.angles);
  dotresult = vectordot(worldup, grenadeup);
  grenade.var_bfcf780c7f28fbd4 = dotresult >= -0.5 && dotresult <= 0.5;
  grenadestate = ter_op(var_5996067fa75e09d4, "dig_success", "dig_fail");
  function_c8fd05bf21971a04(grenade, grenadestate, var_b376fa2d061141c0, surfacenormal);
  var_2a21b9990f69270e = getdvarfloat(@ "hash_dcc19c96af625740", 0);
  wait var_2a21b9990f69270e;

  if(!var_5996067fa75e09d4) {
    function_3a35103112044e22(grenade);
  } else {
    function_5f9b222ef93f265e(grenade, var_b376fa2d061141c0, surfacenormal);
  }

  function_2c9ec2084ca01277(grenade, grenadestate);
}

function function_c8fd05bf21971a04(grenade, digstate, spawnpoint, referencevec, var_5bcde5d4993abf00) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");

  if(!isDefined(spawnpoint)) {
    spawnpoint = grenade.origin;
  }

  if(!isDefined(referencevec)) {
    referencevec = anglesToForward(grenade.angles);
  }

  if(digstate == "dig_fail") {
    effectsent = spawn_script_origin(spawnpoint, grenade.angles);
    grenade setscriptablepartstate("effects", "sizzle-fail", 0);
  } else {
    effectsent = spawn("script_model", spawnpoint);
    effectsent.angles = vectortoangles(referencevec);
    effectsent setModel("equip_bunkerbuster_burrowed");
    effectsent linkTo(grenade);

    if(digstate == "player_stuck") {
      grenade setscriptablepartstate("effects", "sizzle-player-stuck", 0);
    } else {
      grenade setscriptablepartstate("effects", "sizzle-success", 0);
      var_a2d683023dd73ecc = getdvarfloat(@ "hash_dd3f674055086845", 0.75);
      wait var_a2d683023dd73ecc;
      effectsent setscriptablepartstate("thermal_lance", "active", 0);
    }
  }

  grenade.effectsent = effectsent;
}

function function_2c9ec2084ca01277(grenade, grenadestate) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("explode");
  grenade endon("death");
  var_ad5532bd0a7f34d7 = getdvarfloat(@ "hash_7ecef2f8627473e8", 1);

  if(istrue(grenade.var_25939b3c785fabb9)) {
    var_ad5532bd0a7f34d7 = 3;
  }

  if(istrue(grenade.var_5bcde5d4993abf00)) {
    var_ad5532bd0a7f34d7 = 1.5;
  }

  wait getdvarfloat(@ "hash_4e0c2a5ace3abb90", var_ad5532bd0a7f34d7);
  function_500b28a55f3ecc0e(grenade, grenadestate);
}

function function_6e25a608eafbc362(grenade, vehicle) {
  grenade.var_25939b3c785fabb9 = 1;
  grenade function_5a71826bec10f4f0(vehicle);
  grenade thread function_b0492540ca02a187(vehicle);
  grenadestate = "vehicle_stuck";
  function_c8fd05bf21971a04(grenade, grenadestate);
  function_3a35103112044e22(grenade);
  function_2c9ec2084ca01277(grenade, grenadestate);
}

function function_b0492540ca02a187(vehicle) {
  self endon("death");
  vehicle endon("death");
  level endon("game_ended");

  while(true) {
    vehicle waittill("vehicle_owner_update");
    function_5a71826bec10f4f0(vehicle);
  }
}

function function_5a71826bec10f4f0(vehicle) {
  var_709b8964351947bb = 0;

  if(self.owner.team != vehicle.team && vehicle.team != "neutral") {
    var_709b8964351947bb = 1;
  }

  if(!var_709b8964351947bb) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);

    if(occupants.size > 0) {
      foreach(occupant in occupants) {
        if(isDefined(occupant)) {
          if(occupant.team != self.owner.team) {
            var_709b8964351947bb = 1;
          } else {
            var_709b8964351947bb = 0;
          }

          break;
        }
      }
    }
  }

  if(var_709b8964351947bb) {
    scripts\cp_mp\utility\weapon_utility::function_69d45a21a6d4e9f8(vehicle, vehicle.team);
  }
}

function function_5f9b222ef93f265e(grenade, spawnpoint, surfacenormal) {
  grenade.explodingent = scripts\cp\utility::_launchgrenade("bunkerbuster_burrowed_mp", spawnpoint + anglestoup(grenade.angles) * -1 * 8, (0, 0, 0), 100, 1);
  grenade.explodingent.weapon_object = makeweapon("bunkerbuster_burrowed_mp");
  grenade.explodingent linkTo(grenade.effectsent);
  grenade.explodingent.angles = vectortoangles(surfacenormal);
  grenade setscriptablepartstate("effects", "sizzle-success", 0);
  grenade.explodingent setscriptablepartstate("danger-icon", "on", 0);
  setdvarifuninitialized(@ "hash_78eca657479298a4", 0);
  var_f46e618929c20f6 = getdvarint(@ "hash_78eca657479298a4");

  if(var_f46e618929c20f6) {
    level thread draw_angles(grenade.explodingent.angles, grenade.explodingent.origin, (1, 0, 0), 1000, 50);
  }
}

function function_3a35103112044e22(grenade) {
  explodingent = scripts\cp\utility::_launchgrenade("bunkerbuster_not_burrowed_mp", grenade.origin, (0, 0, 0), 100, 1);
  explodingent linkTo(grenade.effectsent);
  grenade.explodingent = explodingent;
  grenade.explodingent.weapon_object = makeweapon("bunkerbuster_burrowed_mp");
}

function function_8f7774e4e68d2a43(grenade, var_256392925c393bd0, surfacevec) {
  offset = getdvarint(@ "hash_8feb82dd51a5a0c2", 25);
  var_256392925c393bd0 += surfacevec * offset;
  isoob = scripts\cp\cp_outofbounds::ispointinoutofbounds(var_256392925c393bd0, self.team);

  if(isoob) {
    return 0;
  }

  return 1;
}

function function_500b28a55f3ecc0e(grenade, grenadestate) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");

  if(!isDefined(grenadestate) || !isstring(grenadestate)) {
    grenadestate = "";
  }

  stuckto = grenade.stuckto;

  if(isDefined(stuckto) && (grenadestate == "vehicle_stuck" || grenadestate == "player_stuck")) {
    function_1cdf454e2f856a7f(grenade);
  } else if(grenadestate == "dig_success") {
    var_c225480c1fd1c87f = grenade.effectsent.angles;
    var_160a13625801abec = grenade.explodingent.origin;
    grenade.explodingent unlink();
    grenade.explodingent delete();
    velocityvec = (0, 0, 0);
    velocityvec += anglesToForward(var_c225480c1fd1c87f) * getdvarint(@ "hash_8766c486f2519ffb", 300);

    if(istrue(grenade.var_bfcf780c7f28fbd4)) {
      velocityvec += anglestoup(var_c225480c1fd1c87f) * getdvarint(@ "hash_6bffd30022e9bcab", 0) * -1;
    }

    grenade.explodingent = scripts\cp\utility::_launchgrenade("bunkerbuster_round_mp", var_160a13625801abec, velocityvec, 100, 1);
    grenade.explodingent.angles = var_c225480c1fd1c87f;
    grenade.explodingent setscriptablepartstate("shoot", "shoot", 0);
    grenade setscriptablepartstate("effects", "shoot", 0);
    setdvarifuninitialized(@ "hash_78eca657479298a4", 0);
    var_f46e618929c20f6 = getdvarint(@ "hash_78eca657479298a4");

    if(var_f46e618929c20f6) {
      level thread draw_angles(grenade.explodingent.angles, grenade.explodingent.origin, (1, 0, 0), 1000, 100);
    }

    grenade.explodingent setscriptablepartstate("danger-icon", "on", 0);
    bursttime = getdvarfloat(@ "hash_b75d73bdceff168f", 0.5);
    grenade.explodingent waittill_any_timeout_1(bursttime, "missile_stuck");
    grenade.explodingent setscriptablepartstate("shoot", "explode", 0);
  } else {
    grenade setscriptablepartstate("effects", "explode", 0);
  }

  wait 0.1;

  if(isDefined(grenade.explodingent)) {
    grenade.explodingent detonate();
  }

  grenade thread function_a5a20b852c325190(0, ter_op(grenadestate == "dig_success", 1, 0));
}

function function_1cdf454e2f856a7f(grenade) {
  stuckto = grenade.stuckto;

  if(stuckto.classname == "script_vehicle") {
    function_e5be7a1f18a659fb(grenade, stuckto);
    return;
  }

  if(isPlayer(stuckto) || isai(stuckto)) {
    function_591b951a9d91ffe4(grenade, stuckto);
  }
}

function function_e5be7a1f18a659fb(grenade, vehicle) {
  scripts\cp_mp\utility\weapon_utility::function_28e583bfecc38a25(vehicle, vehicle.team);
  vehiclename = vehicle.vehiclename;

  if(vehiclename == "apc_russian" || vehiclename == "light_tank" || vehiclename == "veh9_apc_8x8") {
    damagedata = spawnStruct();
    damagedata.inflictor = vehicle;
    damagedata.objweapon = makeweapon(scripts\cp_mp\vehicles\vehicle_damage::function_7aaa7ae503292f43(vehicle.vehiclename));
    damagedata.meansofdeath = "MOD_EXPLOSIVE";
    damagedata.attacker = grenade.owner;
    exitdata = spawnStruct();
    exitdata.nocorpse = 1;
    vehicle scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(vehicle, damagedata, exitdata);
  } else {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle, 0);

    if(isDefined(occupants) && occupants.size > 0) {
      foreach(occupant in occupants) {
        occupant dodamage(occupant.health, grenade.origin, self, grenade, "MOD_EXPLOSIVE");
      }
    }
  }

  if(isDefined(grenade.explodingent)) {
    grenade.explodingent unlink();
    grenade.explodingent = scripts\cp\utility::_launchgrenade("bunkerbuster_burrowed_mp", vehicle.origin, (0, 0, 0), undefined, 1, grenade.explodingent);
    grenade.explodingent setscriptablepartstate("shoot", "explode", 0);
    grenade.explodingent linkTo(vehicle, "tag_origin");
  }
}

function function_591b951a9d91ffe4(grenade, player) {
  if(isDefined(grenade.explodingent)) {
    grenade.explodingent setscriptablepartstate("shoot", "explode-player-stuck", 0);
  }
}

function function_be84a39b52576d18() {
  level endon("game_ended");
  self endon("explode");
  self.owner waittill_any_3("disconnect", "joined_team", "joined_spectators");
  thread function_a5a20b852c325190();
}

function function_a5a20b852c325190(immediate, var_5996067fa75e09d4) {
  level endon("game_ended");
  self endon("death");
  self notify("explode");

  if(istrue(self.exploding)) {
    return;
  }

  self.exploding = 1;

  if(istrue(var_5996067fa75e09d4)) {
    var_4b54b08a970445f6 = getdvarfloat(@ "hash_a72d28a8eef62114", 0.5);
    wait var_4b54b08a970445f6;
  }

  self setscriptablepartstate("effects", "destroy", 0);

  if(!istrue(immediate)) {
    wait 0.25;
  }

  thread function_f0acd469ce8642b9();
}

function function_f0acd469ce8642b9() {
  self notify("death");
  function_7f69923dc06f01d7();
  self delete();
}

function function_e241396812ed67b2() {
  level endon("game_ended");
  self endon("explode");
  self waittill("death");
  function_7f69923dc06f01d7();
}

function function_7f69923dc06f01d7() {
  if(isDefined(self.explodingent)) {
    self.explodingent delete();
  }

  if(isDefined(self.effectsent)) {
    self.effectsent delete();
  }
}