/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\quaked\script_struct_mp_jup_jltv_mg.gsc
**************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_airdrop;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#namespace script_struct_mp_jup_jltv_mg;

function autoexec main() {
  function_c0b3ddc9a6bdcc46("veh_jup_jltv_mg", &function_36f3aa21fcac5b21);
}

function function_41840e7c1272c050(veh_spawner) {
  veh_spawner.spawnmethod = "airdrop_at_position_unsafe";
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_jltv_mg", veh_spawner);
  return vehicle;
}

function private function_36f3aa21fcac5b21() {
  if(!function_9697379150687859("veh_jup_jltv_mg")) {
    return;
  }

  callbacks = [];
  callbacks["spawn"] = &function_d2a84209a50b34d2;
  callbacks["enterEnd"] = &function_7abe06772f227330;
  callbacks["exitEnd"] = &function_2fdd0e40db525024;
  callbacks["reenter"] = &function_4b1ad3b1d7810658;
  callbacks["spawnPostAirdrop"] = &function_83972c0fabc82c9f;
  function_8497e7e46b5e397("veh_jup_jltv_mg", callbacks);
  function_f2a24ca61d1563a();
}

function private function_d2a84209a50b34d2(spawndata, faildata) {
  spawnposition = undefined;
  spawnangles = undefined;

  if(!isDefined(spawndata)) {
    spawndata = spawnStruct();
  }

  if(!isDefined(spawndata.spawnmethod)) {
    spawndata.spawnmethod = "place_at_position_unsafe";
  }

  isairdrop = issubstr(spawndata.spawnmethod, "airdrop_");
  assertex(isDefined(spawndata) && (isDefined(spawndata.origin) || spawndata.spawnmethod == "airdrop_from_player"), "spawnData.origin must be defined.");
  spawnposition = spawndata.origin;
  spawnangles = spawndata.angles;

  if(isDefined(spawndata.owner) && istrue(spawndata.faceawayfromowner)) {
    between = spawnposition - spawndata.owner.origin;

    if(length2dsquared(between) > 0) {
      spawnangles = vectortoangles(spawnposition - spawndata.owner.origin);
    } else {
      spawnangles = spawndata.owner getplayerangles(1);
    }
  }

  if(!isDefined(spawnangles)) {
    spawnangles = (0, randomint(360), 0);
  } else {
    spawnangles *= (0, 1, 0);
  }

  vehicle = undefined;

  if(isairdrop) {
    vehicle = function_4c41d739b1eb8cd0(spawnposition, spawnangles, spawndata, faildata);
  } else {
    vehicle = function_62204f70106947a6(spawnposition, spawnangles, spawndata, faildata);
  }

  return vehicle;
}

function private function_4c41d739b1eb8cd0(position, angles, spawndata, faildata) {
  spawndata.origin = position;
  spawndata.angles = angles;
  vehicle = scripts\cp_mp\vehicles\vehicle_airdrop::vehicle_airdrop("veh_jup_jltv_mg", spawndata, faildata);
  return vehicle;
}

function private function_62204f70106947a6(spawnposition, spawnangles, spawndata, faildata) {
  oldorigin = spawndata.origin;
  oldangles = spawndata.angles;
  spawndata.origin = spawnposition;
  spawndata.angles = spawnangles;
  vehicle = function_83972c0fabc82c9f(spawndata, faildata);
  spawndata.origin = oldorigin;
  spawndata.angles = oldangles;

  if(!isDefined(vehicle)) {
    return undefined;
  }

  return vehicle;
}

function private function_83972c0fabc82c9f(spawndata, faildata) {
  vehicle = function_bba34cf920370ff4("veh_jup_jltv_mg", spawndata, faildata);
  turret_weapon = function_edcae4b27a6f7abe();
  turret = function_9e1cb0f4ea79f09e(vehicle, spawndata, turret_weapon);
  vehicle_registerturret(vehicle, turret, makeweapon(turret_weapon));

  if(utility::iscp()) {
    vehicle.var_7ee6203c5532a9e6 = 1;
    vehicle.vehicle_specific_onentervehicle = &function_d09b279cd811f266;
    vehicle.vehicle_specific_onexitvehicle = &function_e1f107025762fca4;
  }

  return vehicle;
}

function private function_f2a24ca61d1563a() {
  leveldataforvehicle = vehomn_getleveldataforvehicle("veh_jup_jltv_mg", 1);
  leveldataforvehicle.rotationids[0] = 0;
  leveldataforvehicle.rotationids[1] = 1;
  leveldataforvehicle.rotationrefsbyseatandweapon["driver"][function_edcae4b27a6f7abe()] = 0;
  leveldataforvehicle.rotationrefsbyseatandweapon["gunner"][function_edcae4b27a6f7abe()] = 1;
  leveldataforvehicle.var_bd169af9b46727ef = 1;
}

function private function_edcae4b27a6f7abe() {
  mapname = getDvar(@ "g_mapname");

  if(utility::iscp()) {
    if(mapname == "cp_lone") {
      return "iw9_mg_jltv_cp";
    } else if(is_equal(level.gametype, "dungeons")) {
      return "jup_mg_jltv_dungeons_cp";
    }
  }

  return "jup_mg_jltv_mp";
}

function private function_7abe06772f227330(vehicle, seatid, oldseatid, player, data) {
  if(istrue(data.success)) {
    thread function_2aa52f506944ea71(vehicle, seatid, oldseatid, player, data);
    return;
  }

  if(!istrue(data.playerdisconnect) && !istrue(data.playerdeath)) {
    if(seatid == "gunner") {
      turret_weapon = function_edcae4b27a6f7abe();
      thread vehicle_occupancy_taketurret(player, vehicle, turret_weapon, data, 1);
    }
  }
}

function private function_2aa52f506944ea71(vehicle, seatid, oldseatid, player, data) {
  if(seatid == "gunner") {
    level thread vehicle_occupancy_disablefirefortime(player, ter_op(istrue(vehicle.playedfirstraise), 850, 2200));
    turret_weapon = function_edcae4b27a6f7abe();
    player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, turret_weapon);
    vehicle.playedfirstraise = 1;
  }

  vehomn_updateomnvarsonseatenter(vehicle, oldseatid, seatid, player);
}

function private function_2fdd0e40db525024(vehicle, seatid, newseatid, player, data) {
  if(istrue(data.success)) {
    function_3d7fcd7f8aa45e0d(vehicle, seatid, newseatid, player, data);
  }
}

function private function_3d7fcd7f8aa45e0d(vehicle, seatid, newseatid, player, data) {
  if(seatid == "gunner") {
    turret_weapon = function_edcae4b27a6f7abe();
    turret = vehicle_getturretbyweapon(vehicle, turret_weapon);

    if(!istrue(data.playerdisconnect)) {
      player enableturretdismount();
      player controlturretoff(turret);
      thread vehicle_occupancy_cleardisablefirefortime(player, data.playerdeath);

      if(!istrue(data.playerdeath)) {
        thread vehicle_occupancy_taketurret(player, vehicle, turret_weapon, data, 1);
      }
    }

    turret.owner = undefined;
    turret setotherent(undefined);
    turret setentityowner(undefined);
    turret setsentryowner(undefined);
  }

  if(!istrue(data.playerdisconnect)) {
    success = vehicle_occupancy_moveplayertoexit(vehicle, seatid, newseatid, player, data);

    if(!success) {
      if(issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      } else {
        player suicide();
      }
    }
  }

  vehomn_updateomnvarsonseatexit(vehicle, seatid, newseatid, player);
}

function private function_4b1ad3b1d7810658(vehicle, reenterseatid, var_3f68c37bafd38606, player, data) {
  if(isDefined(var_3f68c37bafd38606) && var_3f68c37bafd38606 == "gunner") {
    turret_weapon = function_edcae4b27a6f7abe();
    thread vehicle_occupancy_taketurret(player, vehicle, turret_weapon, data, 1);
  }
}

function private function_9e1cb0f4ea79f09e(vehicle, spawndata, turretweapon) {
  turret = spawnturret("misc_turret", vehicle gettagorigin("tag_turret"), turretweapon, 0);
  turret linkTo(vehicle, "tag_turret", (0, 0, 0), (0, 0, 0));

  if(issubstr(spawndata.modelname, "::")) {
    [override] = strtok(spawndata.modelname, "::");
    modelname = override + "::" + "veh9_mil_lnd_jltv_turret_gun_mtx";
  } else {
    modelname = "veh9_mil_lnd_jltv_turret_gun_mtx";
  }

  turret setModel(modelname);
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  return turret;
}

#using_animtree("mp_vehicles_always_loaded");

function private function_d09b279cd811f266(vehicle, newseatid, player, data) {
  if(istrue(vehicle.door_open)) {
    vehicle vehicleplayanim(%reb_com_veh8_techo_fl_door_close);
    vehicle.door_open = undefined;
  }

  if(istrue(level.var_d39df167f3a996b0)) {
    vehicle setscriptablepartstate("lights", "on");
  }

  if(isDefined(vehicle.var_f24cc3beef01650c)) {
    vehicle.var_1ab6b61153087915 = vehicle.var_f24cc3beef01650c;
  }
}

function private function_e1f107025762fca4(vehicle, newseatid, player, data) {
  if(!istrue(data.playerdisconnect)) {
    player.isdrivingvehicle = undefined;
  }

  vehicle.var_1ab6b61153087915 = undefined;
}