/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_36967ce8ee2ea745.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_jltv_mg", ::_id_AE4E7F00C8115B31);
}

_id_AE4E7F00C8115B31() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_jltv_mg")) {
    return;
  }
  callbacks = [];
  callbacks["spawn"] = ::_id_8801494DFF845E4F;
  callbacks["enterEnd"] = ::_id_BB30116F3FD6E9E0;
  callbacks["exitEnd"] = ::_id_FDC839BB6FC50C34;
  callbacks["reenter"] = ::_id_6ED911AD6F6DF408;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_jltv_mg", callbacks);
  _id_9752AACD99A363CA();
}

_id_9752AACD99A363CA() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle("veh9_jltv_mg", 1);
  _id_E2818AD39A3341B4.rotationids[0] = 0;
  _id_E2818AD39A3341B4.rotationids[1] = 1;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["driver"][_id_F921E95B80E8AFAE()] = 0;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["gunner"][_id_F921E95B80E8AFAE()] = 1;
  _id_E2818AD39A3341B4._id_BD169AF9B46727EF = 1;
}

_id_F921E95B80E8AFAE() {
  mapname = getDvar("g_mapname");

  if(scripts\common\utility::iscp() && mapname == "cp_lone")
    return "iw9_mg_jltv_cp";

  return "iw9_mg_jltv_mp";
}

_id_8801494DFF845E4F(spawndata, _id_EE8DA5624236DC89) {
  vehicle = scripts\cp_mp\vehicles\vehicle::_id_BBA34CF920370FF4("veh9_jltv_mg", spawndata, _id_EE8DA5624236DC89);
  turret = _id_B6F99331F7CC8AAE(vehicle, spawndata);
  scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, turret, makeweapon(_id_F921E95B80E8AFAE()));
  return vehicle;
}

_id_BB30116F3FD6E9E0(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success))
    thread _id_3AD4A8A755341361(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
  else if(!istrue(data.playerdisconnect) && !istrue(data.playerdeath)) {
    if(seatid == "gunner")
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, _id_F921E95B80E8AFAE(), data, 1);
  }
}

_id_3AD4A8A755341361(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "gunner") {
    level thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, scripts\engine\utility::ter_op(istrue(vehicle._id_ECC491F42AACEAF4), 850, 2200));
    player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, _id_F921E95B80E8AFAE());
    vehicle._id_ECC491F42AACEAF4 = 1;
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);
}

_id_FDC839BB6FC50C34(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    _id_A3417B548967A91D(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

_id_A3417B548967A91D(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(seatid == "gunner") {
    turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, _id_F921E95B80E8AFAE());

    if(!istrue(data.playerdisconnect)) {
      player enableturretdismount();
      player controlturretoff(turret);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(player, data.playerdeath);

      if(!istrue(data.playerdeath))
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, _id_F921E95B80E8AFAE(), data, 1);
    }

    turret.owner = undefined;
    turret setotherent(undefined);
    turret setentityowner(undefined);
    turret setsentryowner(undefined);
  }

  if(!istrue(data.playerdisconnect)) {
    success = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(vehicle, seatid, _id_7558F98F3236963D, player, data);

    if(!success) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      else
        player suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, _id_7558F98F3236963D, player);
}

_id_6ED911AD6F6DF408(vehicle, _id_9DE41F2EE77C33BA, _id_3F68C37BAFD38606, player, data) {
  if(isDefined(_id_3F68C37BAFD38606) && _id_3F68C37BAFD38606 == "gunner")
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, _id_F921E95B80E8AFAE(), data, 1);
}

_id_B6F99331F7CC8AAE(vehicle, spawndata) {
  turret = spawnturret("misc_turret", vehicle gettagorigin("tag_turret"), _id_F921E95B80E8AFAE(), 0);
  turret linkTo(vehicle, "tag_turret", (0, 0, 0), (0, 0, 0));
  turret setModel("veh9_mil_lnd_jltv_turret_gun");
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  return turret;
}