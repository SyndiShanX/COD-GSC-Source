/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_30fea87d65917e79.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace namespace_ba6f89a44ea97e90;

function main() {
  function_c0b3ddc9a6bdcc46("veh9_apc_8x8", &function_488998cacb2bd88d);
}

function private function_488998cacb2bd88d() {
  if(!function_9697379150687859("veh9_apc_8x8")) {
    return;
  }

  callbacks["enterEnd"] = &function_8cd2392376db14b4;
  callbacks["exitEnd"] = &function_6896df4f69c410f0;
  callbacks["update"] = &function_a7fa2d6f6bc0b312;
  callbacks["spawn"] = &function_2c74b512a59ddbe3;
  function_8497e7e46b5e397("veh9_apc_8x8", callbacks);
  function_a4da9e788f6eac5f();
  function_299e9968e72a6bd8();
  function_29b4292c92443328("veh9_apc_8x8").var_528c63bf357fb963 = getdvarint(@ "hash_f73768d95dd26d25", 8);
}

function private function_a4da9e788f6eac5f() {
  leveldataforvehicle = vehomn_getleveldataforvehicle("veh9_apc_8x8", 1);
  leveldataforvehicle.ammoids["driverTurret"] = 0;
  leveldataforvehicle.rotationids["chassis"] = 0;
  leveldataforvehicle.mainturretweapon = "iw9_tur_apc_russian_mp";
  leveldataforvehicle.rotationrefsbyseatandweapon["driver"]["apc_rus_mp"] = "chassis";
  leveldataforvehicle.rotationrefsbyseatandweapon["front_left"]["iw9_tur_apc_russian_mp"] = "chassis";
  leveldataforvehicle.rotationrefsbyseatandweapon["front_right"]["iw9_tur_apc_russian_mp"] = "chassis";
  leveldataforvehicle.rotationrefsbyseatandweapon["back_right"]["iw9_tur_apc_russian_mp"] = "chassis";
  leveldataforvehicle.rotationrefsbyseatandweapon["back_left"]["iw9_tur_apc_russian_mp"] = "chassis";
  leveldataforvehicle.rotationrefsbyseatandweapon["back"]["iw9_tur_apc_russian_mp"] = "chassis";
}

function private function_299e9968e72a6bd8() {
  vehicle_damage_setpremoddamagecallback("veh9_apc_8x8", &function_80a2f71bfa81e0d2);
  vehicle_damage_setpostmoddamagecallback("veh9_apc_8x8", &function_e0560a4879ef9415);
  vehicle_damage_setweaponhitdamagedata("iw9_tur_apc_russian_mp", 2);
}

function private function_2c74b512a59ddbe3(spawndata, faildata) {
  vehicle = function_bba34cf920370ff4("veh9_apc_8x8", spawndata, faildata);
  var_b101137988b007d7 = vehicle_damage_getinstancedataforvehicle(vehicle, 1);
  var_b101137988b007d7.destroyscoreevent = "none";
  var_b101137988b007d7.destroyaward = "kill_apc_rus";
  var_b101137988b007d7.destroyawardlaunchonly = 1;
  vehicle thread function_a3413ba13b12f41f();
  return vehicle;
}

function private function_80a2f71bfa81e0d2(data) {
  if(vehicle_damage_isselfdamage(self, data)) {
    return false;
  }

  var_6b11d3047f506fb6 = self.origin - data.point;
  normal = anglestoup(self.angles);
  dist = vectordot(var_6b11d3047f506fb6, normal);
  var_d74074ad5396e58a = data.point + normal * dist;
  var_c47f1816352556dd = vectorNormalize(var_d74074ad5396e58a - self.origin);
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  var_d726822c713445c2 = getdvarfloat(@ "hash_45d4631df7323c01", -0.892);

  if(vectordot(var_c47f1816352556dd, forward) < var_d726822c713445c2) {
    data.isrearcriticaldamage = function_f9cfc875faff6dbe(data);
  }

  return true;
}

function private function_e0560a4879ef9415(data) {
  if(istrue(data.isrearcriticaldamage)) {
    data.damage = int(data.damage * 1.6);
  }

  return true;
}

function private function_f9cfc875faff6dbe(data) {
  if(isDefined(data.inflictor) && isDefined(data.inflictor.weapon_name) && data.inflictor.weapon_name == "gl") {
    return (isDefined(data.meansofdeath) && data.meansofdeath == "MOD_GRENADE");
  }

  if(isDefined(data.objweapon) && isDefined(data.objweapon.basename)) {
    switch (data.objweapon.basename) {
      case #"hash_a622e958420b92a0":
        return (isDefined(data.meansofdeath) && (data.meansofdeath == "MOD_PROJECTILE" || data.meansofdeath == "MOD_RIFLE_BULLET"));
      case #"hash_3e782fd775b72022":
      case #"hash_6b9700922cc910a9":
      case #"hash_8c12df11df01f306":
      case #"hash_a9e31b8ffd42a67b":
      case #"hash_f55c20924061bd15":
      case #"hash_fd9c279f85990dad":
        return (isDefined(data.meansofdeath) && data.meansofdeath == "MOD_PROJECTILE");
      case #"hash_e704ecf8710c6f57":
        return (isDefined(data.meansofdeath) && data.meansofdeath == "MOD_GRENADE");
    }
  }

  return false;
}

function private function_8cd2392376db14b4(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(istrue(data.success)) {
    function_a9592fd0c9c9c19d(vehicle, seatid, var_fc7c7a874b43a31a, player, data);
  }

  if(istrue(vehicle.israllypointvehicle)) {
    foreach(plr in level.players) {
      if(istrue(vehicle.revealed) || is_equal(plr.team, vehicle.team)) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, plr);
      }
    }

    foreach(occupant in vehicle.occupants) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(vehicle.marker.objidnum, occupant);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(vehicle.marker.objidnum, player);
  }
}

function private function_a9592fd0c9c9c19d(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(seatid == "driver") {
    player cameradefault();
    thread vehicle_occupancy_disablefirefortime(player, 100);
  }

  vehomn_updateomnvarsonseatenter(vehicle, var_fc7c7a874b43a31a, seatid, player);
  function_8a1eab7c9242a820(vehicle, var_fc7c7a874b43a31a, seatid, player);

  if(seatid == "driver") {
    vehicle thread function_8a5f78f0c60e3e1a(player);
  }
}

function private function_6896df4f69c410f0(vehicle, seatid, var_7558f98f3236963d, player, data) {
  if(istrue(data.success)) {
    function_74adb461a2be931(vehicle, seatid, var_7558f98f3236963d, player, data);
  }
}

function private function_74adb461a2be931(vehicle, seatid, var_7558f98f3236963d, player, data) {
  if(!istrue(data.playerdisconnect)) {
    success = vehicle_occupancy_moveplayertoexit(vehicle, seatid, var_7558f98f3236963d, player, data);

    if(!success) {
      if(issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      } else {
        player suicide();
      }
    } else if(istrue(vehicle.israllypointvehicle)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
    }
  }

  vehomn_updateomnvarsonseatexit(vehicle, seatid, var_7558f98f3236963d, player);
}

function private function_a7fa2d6f6bc0b312(data) {
  vehicle_occupancy_updatemovefeedback("driver");
}

function private function_a3413ba13b12f41f() {
  self endon("death");
  function_f3b33ffcc3787a2();

  while(true) {
    waittill_any_2("vehicle_turret_fire", "vehicle_turret_reload_end");
    function_f3b33ffcc3787a2();
  }
}

function private function_8a5f78f0c60e3e1a(driver) {
  self endon("death");

  if(isDefined(driver)) {
    driver endon("vehicle_change_seat");
    driver endon("vehicle_seat_exit");
    driver endon("death_or_disconnect");

    while(driver reloadbuttonPressed()) {
      waitframe();
    }

    var_33193f537b85b6d4 = getdvarint(@ "hash_9402582f8123db99", 250) / 1000;

    while(true) {
      holdtime = 0;
      usereloadconfig = driver getcurrentusereloadconfig();
      var_72e25a59fcef57b5 = 0;

      while(driver reloadbuttonPressed()) {
        if(!driver usinggamepad() && self function_ab2bddb6cd03a29d() < weaponclipsize("iw9_tur_apc_russian_mp")) {
          self function_4012509dbd1cee6f();
          var_72e25a59fcef57b5 = 1;
          function_f3b33ffcc3787a2();
          break;
        }

        if(self function_ab2bddb6cd03a29d() < weaponclipsize("iw9_tur_apc_russian_mp") && usereloadconfig > 0 && holdtime >= var_33193f537b85b6d4) {
          self function_4012509dbd1cee6f();
          var_72e25a59fcef57b5 = 1;
          function_f3b33ffcc3787a2();
        }

        holdtime += level.framedurationseconds;
        waitframe();
      }

      if(!var_72e25a59fcef57b5 && driver usinggamepad() && self function_ab2bddb6cd03a29d() < weaponclipsize("iw9_tur_apc_russian_mp") && (usereloadconfig == 0 && holdtime > 0 && holdtime < 0.2 || usereloadconfig > 0 && holdtime >= var_33193f537b85b6d4)) {
        self function_4012509dbd1cee6f();
        function_f3b33ffcc3787a2();
      }

      waitframe();
    }
  }
}

function private function_b26f847a5594d2a2(amount) {
  turret = vehicle_getturretbyweapon(self, "iw9_tur_apc_russian_mp");
  turret.shotsleft += amount;
  turret.shotsleft = int(clamp(turret.shotsleft, 0, function_7585a70307df520f()));
  function_f3b33ffcc3787a2();
}

function private function_7585a70307df520f() {
  if(isDefined(level.var_468b95f3865fa8d3)) {
    count = [[level.var_468b95f3865fa8d3]](self);

    if(isDefined(count)) {
      return count;
    }
  }

  leveldataforvehicle = vehicle_getleveldataforvehicle("veh9_apc_8x8");
  return leveldataforvehicle.var_528c63bf357fb963;
}

function private function_8a1eab7c9242a820(vehicle, var_fc7c7a874b43a31a, seatid, player) {
  if(seatid == "driver") {
    vehicle function_f3b33ffcc3787a2();
  }
}

function private function_f3b33ffcc3787a2() {
  driver = vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver)) {
    vehomn_setammo("veh9_apc_8x8", "driverTurret", self function_ab2bddb6cd03a29d(), driver);
  }
}