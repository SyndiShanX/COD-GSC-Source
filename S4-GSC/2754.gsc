/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2754.gsc
*************************************************/

_id_10285() {
  var_0 = getdvarint("#x34ad90f355ba0d2af", 128);
  var_1 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10275();
  var_1._id_9C7B = var_0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "canSpawnVehicle", ::_id_1027F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", ::_id_10284);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsAbandonedTimeout", ::_id_10283);
  _id_10280();
}

_id_1027F(var_0, var_1, var_2) {
  if(getdvarint("#x3472b950714ddf102", 1) == 0) {
    return 0;
  }

  return 1;
}

_id_10284() {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(getDvar("#x3f59526763711edc4", "") == "dmz") {
      if(getdvarint("#x333981d61b8a29c6f", 1) > 0) {
        return 1;
      }
    }

    return 0;
  }

  return 1;
}

_id_10283() {
  if(scripts\mp\utility\game::getgametype() == "br") {
    return 0;
  }

  return 1;
}

_id_10280() {
  if(scripts\cp_mp\vehicles\vehicle_spawn::_id_1027C()) {
    _id_0AA3::_id_C28D(::_id_10281);
  }
}

_id_10281() {
  var_0 = scripts\cp_mp\utility\game_utility::_id_6B2D();

  if(var_0 == "mp_downtown_gw") {
    self setorigin((22314, -13059, -128), 1, 1);
    self setplayerangles((0, 36, 0));
  } else if(var_0 == "mp_farms2_gw") {
    self setorigin((45073, -11307, 18), 1, 1);
    self setplayerangles((0, 315, 0));
  } else if(var_0 == "mp_quarry2") {
    self setorigin((29048, 35035, 560), 1, 1);
    self setplayerangles((0, 0, 0));
  }

  thread _id_10282();
}

_id_10282() {
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
    var_0 = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(var_0)) {
      var_1 = scripts\cp_mp\vehicles\vehicle::_id_100C1(var_0._id_1031E);

      if(isDefined(var_1._id_4841)) {
        var_0 thread[[var_1._id_4841]]();
        return;
      } else
        continue;
    }

    thread _id_10281();
    break;
  }
}