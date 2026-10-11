/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_439d01e25d19543b.gsc
*************************************************/

#using script_5307834cd39b435c;
#using script_5c65d346ac65390c;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace namespace_39beb6d4ea2b65f4;

function init() {
  if(getdvarint(@ "hash_81e631c248118cd6", 1) != 1) {
    return;
  }

  level.var_c0e521049f7ae2c9 = getdvarint(@ "hash_62ff9f6d45bb6187", 1);
  level.palfaspawns = scripts\cp_mp\vehicles\vehicle_spawn::function_b08e7e3a0b14f76f("veh9_palfa");
  level.var_343e61767f194b9d = getStructArray("palfa_fuel_spawn", "targetname");
}

function spawnpalfa() {
  if(getdvarint(@ "hash_81e631c248118cd6", 1) != 1) {
    return;
  }

  if(!isDefined(level.palfaspawns) || level.palfaspawns.size == 0 || !isDefined(level.var_343e61767f194b9d) || level.var_343e61767f194b9d.size == 0) {
    return;
  }

  scripts\engine\utility::registersharedfunc(23395, "pickedUp", &function_4579ae632e8313bd);
  palfa = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", random(level.palfaspawns));
  palfa.fuel = 0;
  palfa.var_7ee6203c5532a9e6 = 1;
  palfa.exfilhelicopter = 1;
  level.var_84b057f4f76a152a = palfa;

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    scripts\mp\outofbounds::enableoobimmunity(palfa);
    palfa.onstartriding = &function_436c572e13c3c87f;
    palfa.onendriding = &function_fce5e8b79cac65b4;
    palfa.ontouchoob = &function_4edcaac915edcd2e;
  }

  if(false) {
    foreach(fuelloc in level.var_343e61767f194b9d) {
      level thread scripts\mp\utility\debug::drawsphere(fuelloc.origin, 300, 10000, (1, 0, 0));
    }
  }

  level.var_343e61767f194b9d = array_slice(sortbydistance(level.var_343e61767f194b9d, palfa.origin), level.var_343e61767f194b9d.size - 3);

  if(isDefined(level.wztrain_info) && isDefined(level.wztrain_info.trains) && isDefined(level.wztrain_info.trains["cargo_train"]) && isDefined(level.wztrain_info.trains["cargo_train"][4]) && isDefined(level.var_7d2577fb3be5a656)) {
    struct = level.var_7d2577fb3be5a656;
    level.var_343e61767f194b9d[randomint(level.var_343e61767f194b9d.size)] = struct;
    struct.var_ce5c1024bca39998 = 1;
  }

  tospawn = getdvarint(@ "scr_emptypalfa_numgascans", 1);

  foreach(chosen in array_randomize(level.var_343e61767f194b9d)) {
    if(false) {
      level thread scripts\mp\utility\debug::drawsphere(chosen.origin, 100, 10000, (0, 1, 0));
    }

    fuel = spawnscriptable("brloot_gascan_palfa", chosen.origin, chosen.angles);

    if(isDefined(chosen.traincar)) {
      fuel scriptable_setparententity(chosen.traincar, chosen.origin, chosen.angles);
    }

    fuel.count = 1;
    fuel.criticalitem = 1;
    fuel.var_ce5c1024bca39998 = chosen.var_ce5c1024bca39998;
    scripts\mp\gametypes\br_pickups::registerscriptableinstance(fuel);
    tospawn -= 1;

    if(tospawn <= 0) {
      return;
    }
  }
}

function private function_436c572e13c3c87f(player) {
  scripts\mp\outofbounds::enableoobimmunity(player);
  player.ontouchoob = &function_10f36f1f7c586276;
  thread function_14980658c4ae8eaa(player.team);
}

function private function_14980658c4ae8eaa(team) {
  wait 4;

  if(isDefined(self) && self.fuel <= 0) {
    level thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9("palfa_is_grounded", team);
  }
}

function private function_fce5e8b79cac65b4(player) {
  if(isDefined(player)) {
    player.ontouchoob = undefined;

    if(!istrue(player.extracted)) {
      scripts\mp\outofbounds::disableoobimmunity(player);
    }
  }
}

function private function_4579ae632e8313bd(scriptable, player) {
  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("palfa_fuel_use", player.team);
}

function function_354bd1ba3062243d() {
  if(istrue(level.var_43834c3a158b5eff)) {
    return;
  }

  level.var_43834c3a158b5eff = 1;

  if(!isDefined(level.var_84b057f4f76a152a) || level.var_84b057f4f76a152a.fuel <= 0) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    scripts\cp_mp\overlord::function_9793a81bc3bc19e9("palfa_refueled", self.team);
    level.var_84b057f4f76a152a thread function_b5f1b07a91e21eb9();
  }

  mtx = scripts\cp_mp\vehicles\vehicle::function_471cde1983a05f66(self, "veh9_palfa");
  scripts\cp_mp\vehicles\vehicle::function_4201160d49c885a7(level.var_84b057f4f76a152a, mtx);
  level.var_84b057f4f76a152a.var_7ee6203c5532a9e6 = undefined;
}

function private function_b5f1b07a91e21eb9() {
  self endon("death");
  wait 60;
  occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(self);
  scripts\cp_mp\overlord::playevent("palfa_flying_reminder", occupants);
}

function private function_10f36f1f7c586276(occupant) {
  function_4edcaac915edcd2e(level.var_84b057f4f76a152a);
}

function private function_4edcaac915edcd2e(heli) {
  if(istrue(level.var_32e5e1538fbe1d9d)) {
    return;
  }

  level.var_32e5e1538fbe1d9d = 1;
  exfilplayers = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(heli);
  namespace_25b25d188ef778c4::function_e7994a561be9b933(exfilplayers);
  heli.endingvehicle = 1;
  vehicles = vehicle_getarrayinradius(heli.origin, 500, 500);

  foreach(vehicle in vehicles) {
    foreach(occupant in vehicle.occupants) {
      if(isPlayer(occupant) && scripts\mp\utility\player::isreallyalive(occupant)) {
        exfilplayers = function_6d6af8144a5131f1(exfilplayers, occupant);
      }
    }

    if(!istrue(vehicle.endingvehicle)) {
      level thread scripts\cp_mp\vehicles\vehicle::vehicle_death(vehicle);
    }
  }

  heli.exfilpathstarted = 1;
  heli notify("exfil_path_started");
  info = namespace_e8fceb5cf6e8cdf8::function_730c660d9fc6808e(exfilplayers, 0, 0, 0, 1);
  scripts\engine\utility::callsharedfunc("chopper_exfil", "exfil_players", exfilplayers, info);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(heli);
  waitframe();
  struct = spawnStruct();
  struct.origin = heli.origin;
  struct.angles = heli.angles;
  mtx = heli.mtx;
  scripts\cp_mp\vehicles\vehicle::vehicle_death(heli);
  newheli = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_palfa", struct);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(newheli);
  newheli scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  newheli function_247ad6a91f6a4ffe(1);
  scripts\cp_mp\vehicles\vehicle::function_4201160d49c885a7(newheli, mtx);
  path = namespace_e8fceb5cf6e8cdf8::function_1093b8f392744e3b(newheli, newheli.origin + (0, 0, 1000) + 5000 * anglesToForward(newheli.angles), level.chopperexfil.heliheight, 0);
  path.origin = struct.origin;
  path.angles = struct.angles;
  newheli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);

  if(false) {
    pathnode = path;

    while(isDefined(pathnode)) {
      prev = pathnode.origin;
      sphere(pathnode.origin, 200, (0, 0, 1), 0, 10000);
      pathnode = pathnode.target;

      if(isDefined(pathnode)) {
        line(pathnode.origin, prev, (0, 0, 1), 1, 0, 10000);
      }
    }
  }

  newheli.var_1693991455559c14 = 1;
  newheli endon("death");
  wait 15;
  level thread scripts\cp_mp\vehicles\vehicle::vehicle_death(newheli);
}