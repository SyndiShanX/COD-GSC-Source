/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_spawn_mp.gsc
****************************************************/

function vehicle_spawn_mp_init() {
  var0 = getdvarint("scr_max_vehicles", 128);
  var1 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldata();
  var1.maxinstancecount = var0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "canSpawnVehicle", &vehicle_spawn_mp_canspawnvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", &vehicle_spawn_mp_gamemodesupportsrespawn);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsAbandonedTimeout", &ref_14217);
  vehicle_spawn_mp_codetesthackinit();
}

function vehicle_spawn_mp_canspawnVehicle(var0, var1, var2) {
  if(getdvarint("scr_allow_vehicles", 1) == 0) {
    return false;
  }

  if(getdvarint("scr_allow_vehicle_" + var0, 1) == 0) {
    return false;
  }

  return true;
}

function vehicle_spawn_mp_gamemodesupportsrespawn() {
  if(getdvarint("scr_br_force_vehicle_supports_respawn", 0)) {
    return true;
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") {
      if(getdvarint("scr_bmo_vehicleRespawnEnabled", 1) > 0) {
        return true;
      }
    }

    return false;
  }

  return true;
}

function ref_14217() {
  if(scripts\mp\utility\game::getgametype() == "br") {
    return false;
  }

  return true;
}

function vehicle_spawn_mp_codetesthackinit() {
  if(scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_iscodevehicletest()) {
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&vehicle_spawn_mp_codetesthackspawncallback);
    return;
  }
}

function vehicle_spawn_mp_codetesthackspawncallback() {
  var0 = scripts\cp_mp\utility\game_utility::getmapname();

  if(var0 == "mp_downtown_gw") {
    self setOrigin((22314, -13059, -128), 1, 1);
    self setplayerangles((0, 36, 0));
  } else if(var0 == "mp_farms2_gw") {
    self setOrigin((45073, -11307, 18), 1, 1);
    self setplayerangles((0, 315, 0));
  } else if(var0 == "mp_quarry2") {
    self setOrigin((29048, 35035, 560), 1, 1);
    self setplayerangles((0, 0, 0));
  }

  thread vehicle_spawn_mp_codetesthackwatchrespawn();
}

function vehicle_spawn_mp_codetesthackwatchrespawn() {
  self endon("death_or_disconnect");
  self notify("vehicle_spawn_mp_codeTestHackSpawnCallback");
  self endon("vehicle_spawn_mp_codeTestHackSpawnCallback");
  self notifyonplayercommand("code_vehicle_test_respawn", "+actionslot 1");
  self notifyonplayercommand("code_vehicle_test_respawn", "+actionslot 2");

  for(;;) {
    self waittill("code_vehicle_test_respawn");

    if(!scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    var0 = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(var0)) {
      var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(var0.vehiclename);

      if(isDefined(var1.destroycallback)) {
        var0 thread[[var1.destroycallback]]();
        return;
      } else {
        continue;
      }
    }

    thread vehicle_spawn_mp_codetesthackspawncallback();
    break;
  }
}