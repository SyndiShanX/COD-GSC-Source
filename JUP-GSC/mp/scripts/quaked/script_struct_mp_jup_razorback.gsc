/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\quaked\script_struct_mp_jup_razorback.gsc
****************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_airdrop;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace namespace_7d937d28dc1863ea;

function autoexec main() {
  level.var_7bf42d565645a485 = 1;
  function_c0b3ddc9a6bdcc46("veh_jup_razorback", &function_7b85ecc9d8f7999f);
}

function private function_7b85ecc9d8f7999f() {
  if(!function_9697379150687859("veh_jup_razorback")) {
    return;
  }

  level._effect["razorback_land"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_dropoff_dust.vfx");
  callbacks = [];
  callbacks["spawn"] = &function_62702a579222bd60;
  callbacks["initSpawnData"] = &function_1859f961771f5092;
  callbacks["enterEnd"] = &function_e46a03fe7ae6e0e6;
  callbacks["exitEnd"] = &function_8dfba5d7f86409a6;
  callbacks["reenter"] = &function_6a0b988cd7cc2702;
  callbacks["spawnPostAirdrop"] = &function_36266b198eee7af1;
  callbacks["copySpawnData"] = &function_220f1eb18c81f91f;
  function_8497e7e46b5e397("veh_jup_razorback", callbacks);
}

function private function_1859f961771f5092(spawndata) {
  if(!isDefined(spawndata)) {
    spawndata = spawnStruct();
  }

  if(!isDefined(spawndata.spawnmethod)) {
    spawndata.spawnmethod = "place_at_position_unsafe";
  }

  if(isDefined(spawndata.var_14cde247ac3313a4)) {
    switch (spawndata.var_14cde247ac3313a4) {
      case #"hash_22ce3b03c1e51a9c":
        spawndata.var_14cde247ac3313a4 = "tan";
        break;
      case #"hash_a1e9b77432f55b0e":
        spawndata.var_14cde247ac3313a4 = "green";
        break;
    }
  }

  return spawndata;
}

function private function_62702a579222bd60(spawndata, faildata) {
  function_1859f961771f5092(spawndata);

  if(!isDefined(spawndata.showheadicon)) {
    spawndata.showheadicon = 0;
  }

  vehicle = razorback_spawn(spawndata, faildata);
  return vehicle;
}

function private function_220f1eb18c81f91f(from, to) {
  to.spawnmethod = from.spawnmethod;
  to.faceawayfromowner = from.faceawayfromowner;
  to.cantimeout = from.cantimeout;
  to.showheadicon = from.showheadicon;
}

function private razorback_spawn(spawndata, faildata, streakinfo) {
  spawnposition = undefined;
  spawnangles = undefined;
  var_a50521aed4831f1c = undefined;
  var_3ee18b54b626dba8 = undefined;
  spawndata = function_1859f961771f5092(spawndata);
  assertex(isDefined(spawndata) && (isDefined(spawndata.origin) || spawndata.spawnmethod == "<dev string:x1c>"), "<dev string:x33>");
  isairdrop = issubstr(spawndata.spawnmethod, "airdrop_");
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
    vehicle = function_594881805cec9222(spawnposition, spawnangles, var_a50521aed4831f1c, var_3ee18b54b626dba8, spawndata, faildata);
  } else {
    vehicle = function_19cfa10bff3647b0(spawnposition, spawnangles, spawndata, faildata);
  }

  return vehicle;
}

function private function_19cfa10bff3647b0(spawnposition, spawnangles, spawndata, faildata) {
  oldorigin = spawndata.origin;
  oldangles = spawndata.angles;
  spawndata.origin = spawnposition;
  spawndata.angles = spawnangles;
  vehicle = function_36266b198eee7af1(spawndata, faildata);
  spawndata.origin = oldorigin;
  spawndata.angles = oldangles;

  if(!isDefined(vehicle)) {
    return undefined;
  }

  return vehicle;
}

function private function_36266b198eee7af1(spawndata, faildata) {
  vehicle = function_bba34cf920370ff4("veh_jup_razorback", spawndata, faildata);
  turret_weapon = function_154eeb077c3211e2();
  turret = function_7d1a850ac1a81925(vehicle, turret_weapon, spawndata, "tag_turret_attach", "veh_jup_mil_tank_razorback_turret_vehphys");
  vehicle_registerturret(vehicle, turret, makeweapon(turret_weapon));
  return vehicle;
}

function private function_e46a03fe7ae6e0e6(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(istrue(data.success)) {
    thread function_446e8de4f20c387b(vehicle, seatid, var_fc7c7a874b43a31a, player, data);
    return;
  }

  if(!istrue(data.playerdisconnect) && !istrue(data.playerdeath)) {
    if(seatid == "gunner") {
      turret_weapon = function_154eeb077c3211e2();
      thread vehicle_occupancy_taketurret(player, vehicle, turret_weapon, data, 1);
    }
  }
}

function private function_446e8de4f20c387b(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(seatid == "gunner") {
    turret_weapon = function_154eeb077c3211e2();
    player function_d764f933c0054e16(vehicle, turret_weapon, 0, 0);
    player visionsetkillstreakforplayer("aviCougarGunner", 0);
  }

  function_5004590331017d88(vehicle, seatid, var_fc7c7a874b43a31a, player, data);
}

function private function_8dfba5d7f86409a6(vehicle, seatid, var_7558f98f3236963d, player, data) {
  if(istrue(data.success)) {
    function_1ccee9eb8e41323b(vehicle, seatid, var_7558f98f3236963d, player, data);
  }
}

function private function_1ccee9eb8e41323b(vehicle, seatid, var_7558f98f3236963d, player, data) {
  if(seatid == "gunner") {
    if(!istrue(data.playerdisconnect)) {
      turret_weapon = function_154eeb077c3211e2();
      player function_99ec1e87f279f082(data, vehicle, turret_weapon);
      player visionsetkillstreakforplayer("");
    }
  }

  function_cb4191526e56163c(vehicle, seatid, var_7558f98f3236963d, player, data);
}

function private function_6a0b988cd7cc2702(vehicle, var_9de41f2ee77c33ba, var_3f68c37bafd38606, player, data) {
  if(isDefined(var_3f68c37bafd38606) && var_3f68c37bafd38606 == "gunner") {
    turret_weapon = function_154eeb077c3211e2();
    thread vehicle_occupancy_taketurret(player, vehicle, turret_weapon, data, 1);
  }
}

function private function_594881805cec9222(position, angles, groundposition, groundnormal, spawndata, faildata) {
  spawndata.origin = position;
  spawndata.angles = angles;
  vehicle = scripts\cp_mp\vehicles\vehicle_airdrop::vehicle_airdrop("veh_jup_razorback", spawndata, faildata);
  return vehicle;
}

function private function_154eeb077c3211e2() {
  turretweapon = function_2e58e7b01554419a("veh_jup_razorback", "gunner");

  if(isDefined(turretweapon)) {
    return turretweapon.basename;
  }

  return "";
}