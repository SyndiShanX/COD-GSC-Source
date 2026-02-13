/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\plunder.gsc
*************************************************/

init() {
  level._id_5BD5 = [];
  level._id_4CEB = [];
  _id_405B();
  level thread _id_C52E();
  level thread onplayerconnect();
}

_id_D651(var_0) {
  level._id_B96E = var_0;
}

_id_405B() {
  level._id_503D = [];
  level._id_503D[0] = spawnStruct();
  level._id_503D[0]._id_B9BE = 1;
  level._id_503D[0]._id_ED6B = "military_dogtags_iw8_white";
  level._id_503D[1] = spawnStruct();
  level._id_503D[1]._id_B9BE = 5;
  level._id_503D[1]._id_ED6B = "military_dogtags_iw8_green";
  level._id_503D[2] = spawnStruct();
  level._id_503D[2]._id_B9BE = 10;
  level._id_503D[2]._id_ED6B = "military_dogtags_iw8_blue";
  level._id_503D[3] = spawnStruct();
  level._id_503D[3]._id_B9BE = 20;
  level._id_503D[3]._id_ED6B = "military_dogtags_iw8_purple";
  level._id_503D[4] = spawnStruct();
  level._id_503D[4]._id_B9BE = 40;
  level._id_503D[4]._id_ED6B = "military_dogtags_iw8_orange";
  level._id_503D[5] = spawnStruct();
  level._id_503D[5]._id_B9BE = 80;
  level._id_503D[5]._id_ED6B = "military_dogtags_iw8_gold";

  if(scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "pill") {
    level._id_503D[0]._id_9CAD = 30;
    level._id_503D[1]._id_9CAD = 30;
    level._id_503D[2]._id_9CAD = 20;
    level._id_503D[3]._id_9CAD = 10;
    level._id_503D[4]._id_9CAD = 10;
    level._id_503D[5]._id_9CAD = 10;
  } else {
    level._id_503D[0]._id_9CAD = 32;
    level._id_503D[1]._id_9CAD = 8;
    level._id_503D[2]._id_9CAD = 4;
    level._id_503D[3]._id_9CAD = 2;
    level._id_503D[4]._id_9CAD = 1;
    level._id_503D[5]._id_9CAD = 1;
  }

  level._id_503D[0]._id_ED6F = _id_405C(level._id_503D[0]);
  level._id_503D[1]._id_ED6F = _id_405C(level._id_503D[1]);
  level._id_503D[2]._id_ED6F = _id_405C(level._id_503D[2]);
  level._id_503D[3]._id_ED6F = _id_405C(level._id_503D[3]);
  level._id_503D[4]._id_ED6F = _id_405C(level._id_503D[4]);
  level._id_503D[5]._id_ED6F = _id_405C(level._id_503D[5]);
}

_id_405C(var_0) {
  var_0._id_4CE8 = [];

  for(var_1 = 0; var_1 < var_0._id_9CAD; var_1++) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel(var_0._id_ED6B);
    var_2 _meth_82CB("mp_dogtag_spin");
    var_2 hide();
    var_2 setasgametypeobjective();
    var_3 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var_3._id_0481 = "trigger_dogtag";
    var_3 hide();
    var_4 = spawnStruct();
    var_4.type = "useObject";
    var_4._id_4140 = var_3.origin;
    var_4._id_5513 = var_3 getentitynumber();
    var_4._id_90B8 = 0;
    var_4._id_10430 = var_2;
    var_4._id_A97E = (0, 0, 16);
    var_4.trigger = var_3;
    var_4._id_F637 = "proximity";
    var_4 _id_07D6::_id_15DF("none");
    var_0._id_4CE8[var_0._id_4CE8.size] = var_4;
  }
}

_id_6DB1(var_0) {
  var_1 = level._id_503D[var_0]._id_4CE8[0];
  var_2 = gettime();

  foreach(var_4 in level._id_503D[var_0]._id_4CE8) {
    if(!isDefined(var_4._id_90B8)) {
      continue;
    }
    if(var_4._id_83B6 == "none") {
      var_1 = var_4;
      break;
    }

    if(var_4._id_90B8 < var_2) {
      var_2 = var_4._id_90B8;
      var_1 = var_4;
    }
  }

  var_1 notify("reset");
  var_1 _id_07D6::_id_81EA();
  var_1._id_90B8 = gettime();
  return var_1;
}

_id_E38B(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + (0, 0, 0);
  var_5 = (0, randomfloat(360), 0);
  var_6 = anglesToForward(var_5);

  if(istrue(var_3)) {
    var_7 = randomfloatrange(16, 64);
  } else {
    var_7 = 0;
  }

  var_4 = var_4 + var_7 * var_6;
  var_8 = _id_6DB1(var_0);
  var_8._id_4140 = var_4;
  var_8.trigger.origin = var_4;
  var_8._id_10430.origin = var_4;
  var_8._id_ED78 = var_0;
  var_8.trigger show();
  var_8 _id_07D6::_id_15DF("any");
  var_8._id_10430 _id_DCF4(var_8);
  var_8._id_10430 setasgametypeobjective();
  return var_8;
}

_id_5050(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "pill") {
    var_0 _id_5067(var_0._id_ED74, var_1);
  } else {
    var_2 = scripts\engine\utility::array_contains(level._id_5BD5, var_0);
    var_3 = 1;

    if(!var_2) {
      var_3 = 5;
      level._id_5BD5 = scripts\engine\utility::array_add(level._id_5BD5, var_0);
    }

    var_4 = var_0._id_ED74 + var_3;
    var_0 _id_5067(var_4, var_1);
  }

  var_0 _id_B7A5(0);
}

_id_5067(var_0, var_1) {
  self setclientomnvar("ui_hvt_value", 0);
  var_2 = int(var_0 / 80);
  var_3 = int(var_0 % 80);
  _id_5069(5, int(max(0, var_2)), self, var_1);
  var_4 = int(var_3 / 40);
  var_3 = int(var_3 % 40);
  _id_5069(4, int(max(0, var_4)), self, var_1);
  var_5 = int(var_3 / 20);
  var_3 = int(var_3 % 20);
  _id_5069(3, int(max(0, var_5)), self, var_1);
  var_6 = int(var_3 / 10);
  var_3 = int(var_3 % 10);
  _id_5069(2, int(max(0, var_6)), self, var_1);
  var_7 = int(var_3 / 5);
  var_3 = int(var_3 % 5);
  _id_5069(1, int(max(0, var_7)), self, var_1);
  var_8 = int(var_3 / 1);
  var_3 = int(var_3 % 1);
  _id_5069(0, int(max(0, var_8)), self, var_1);
}

_id_5068(var_0, var_1) {
  var_2 = int(var_0 / 80);
  var_3 = int(var_0 % 80);
  _id_5069(5, int(max(0, var_2)), self, var_1);
  var_4 = int(var_3 / 40);
  var_3 = int(var_3 % 40);
  _id_5069(4, int(max(0, var_4)), self, var_1);
  var_5 = int(var_3 / 20);
  var_3 = int(var_3 % 20);
  _id_5069(3, int(max(0, var_5)), self, var_1);
  var_6 = int(var_3 / 10);
  var_3 = int(var_3 % 10);
  _id_5069(2, int(max(0, var_6)), self, var_1);
  var_7 = int(var_3 / 5);
  var_3 = int(var_3 % 5);
  _id_5069(1, int(max(0, var_7)), self, var_1);
  var_8 = int(var_3 / 1);
  var_3 = int(var_3 % 1);
  _id_5069(0, int(max(0, var_8)), self, var_1);
}

_id_5069(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = _id_E38B(var_0, var_2.origin, var_2.team, 1);
    var_5.team = var_2.team;
    level notify("new_tag_spawned", var_5);
    var_5._id_103C2 = var_2;
    var_5.attacker = var_3;
    level thread _id_A148(var_5);
  }
}

_id_B7A5(var_0) {
  if(!isDefined(self._id_ED74)) {
    self._id_ED74 = 0;
  }

  if(isDefined(level._id_B96E)) {
    var_1 = var_0 - self._id_ED74;
    [[level._id_B96E]](var_1);
  }

  self._id_ED74 = var_0;
  self._id_01F1 = var_0;

  if(scripts\mp\utility\game::getgametype() != "hvt") {
    if(scripts\mp\utility\game::getgametype() == "pill") {
      self setclientomnvar("ui_pillage_currency", var_0);
    } else {
      self setclientomnvar("ui_grind_tags", var_0);
    }
  }

  var_2 = _id_6DB2(var_0);

  if(scripts\mp\utility\game::getgametype() != "br" && scripts\mp\utility\game::getgametype() != "pill") {
    var_3 = self getentitynumber();

    if(var_3 < 20) {
      setomnvar("ui_droploot_inv_" + self getentitynumber(), var_2);
    }
  }
}

_id_6DB2(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  var_1 = int(var_0 / 80);
  var_2 = int(var_0 % 80);
  var_3 = int(var_2 / 40);
  var_2 = int(var_2 % 40);
  var_4 = int(var_2 / 20);
  var_2 = int(var_2 % 20);
  var_5 = int(var_2 / 10);
  var_2 = int(var_2 % 10);
  var_6 = int(var_2 / 5);
  var_2 = int(var_2 % 5);
  var_7 = int(var_2 / 1);
  var_2 = int(var_2 % 1);
  var_8 = var_7 + var_6 * 10 + var_5 * 100 + var_4 * 1000 + var_3 * 10000 + var_1 * 100000;
  return var_8;
}

_id_A11C() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
    _id_B7A5(0);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_8A17 = 0;
    var_0 thread _id_A11C();
  }
}

_id_A148(var_0) {
  level endon("game_ended");
  var_0 endon("deleted");
  var_0 endon("reset");
  wait 2.0;

  for(;;) {
    var_0.trigger waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }
    if(isagent(var_1) && isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }

    playsoundatpos(var_0._id_4140, "mp_killconfirm_tags_pickup");
    var_0._id_10430 hide();
    var_0.trigger hide();
    var_0._id_4140 = (0, 0, -1000);
    var_0.trigger.origin = (0, 0, -1000);
    var_0._id_10430.origin = (0, 0, -1000);
    var_0 _id_07D6::_id_15DF("none");
    var_2 = level._id_503D[var_0._id_ED78]._id_B9BE;
    var_1 _id_B7A5(var_1._id_ED74 + var_2);

    if(isDefined(level._id_EB99) && level._id_EB99) {
      if(isDefined(var_1._id_3E59) && var_1._id_3E59) {
        var_1 _id_07C1::_id_D4EE("kill");
      } else {
        var_1 _id_07C1::_id_AA91(undefined, var_1);
      }
    }

    if(scripts\mp\utility\game::getgametype() == "hvt") {
      var_1 scripts\mp\gametypes\hvt::_id_ED76();
    }

    break;
  }
}

_id_B673(var_0) {
  return 1;
}

_id_DCF4(var_0) {
  self hide();

  foreach(var_2 in level.players) {
    self showtoplayer(var_2);
  }
}

_id_C52E() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1._id_ED74)) {
      continue;
    }
    var_1._id_ED74 = 0;
  }
}

_id_821B() {
  var_0 = scripts\engine\utility::getstructarray("loot_cache", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0.size * 0.5;
  level._id_9866 = [];

  if(1) {
    for(var_2 = 0; var_2 < var_1; var_2++) {
      level._id_9866[level._id_9866.size] = _id_4010(var_0[var_2].origin, var_0[var_2].angles, -1);
    }
  } else {
    var_3 = var_1 * 0.4;
    var_4 = var_1 * 0.1;
    var_5 = 0;

    for(var_2 = 0; var_2 < var_3; var_2++) {
      level._id_9866[level._id_9866.size] = _id_4010(var_0[var_2].origin, var_0[var_2].angles, 1);
      var_5 = var_2;
    }

    for(var_2 = var_5 + 1; var_2 < var_4 + var_3; var_2++) {
      level._id_9866[level._id_9866.size] = _id_4010(var_0[var_2].origin, var_0[var_2].angles, 3);
      var_5 = var_2;
    }

    for(var_2 = var_5 + 1; var_2 < var_1; var_2++) {
      level._id_9866[level._id_9866.size] = _id_4010(var_0[var_2].origin, var_0[var_2].angles, 0);
    }
  }
}

_id_4010(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::_id_B179(var_2, var_0, var_1);
  return var_3;
}

_id_322F(var_0) {
  var_0 notify("opened_cache", self);
  var_1 = self._id_4350._id_3BEB;

  if(var_1 == -1) {
    var_2 = randomint(90);

    if(var_2 <= 20) {
      var_1 = 0;
    } else if(var_2 <= 60) {
      var_1 = 1;
    } else if(var_2 <= 70) {
      var_1 = 3;
    } else if(var_2 <= 80) {
      var_1 = 5;
    } else {
      var_1 = 4;
    }
  }

  switch (var_1) {
    case 5:
      break;
    case 0:
      break;
    case 1:
      break;
    case 3:
      break;
    case 4:
      break;
    default:
      _id_5067(100);
      break;
  }

  var_0 playlocalsound("ammo_crate_use");
}

_id_6DB3(var_0) {
  return var_0 * randomfloatrange(0.8, 1.2);
}

_id_6A88() {
  var_0 = randomint(level._id_2A95._id_2AC0.size);
  return level._id_2A95._id_2AC0[var_0];
}

_id_6ACE() {
  var_0 = randomint(level._id_2A95._id_2AC1.size);
  return level._id_2A95._id_2AC1[var_0];
}

_id_6A76() {
  return level._id_55AA._id_0206;
}

_id_68B6() {
  if(!1) {
    var_0 = randomint(level._id_55AA._id_16CC.size);
    return level._id_55AA._id_16CC[var_0];
  }

  return 105;
}

_id_BD7A(var_0, var_1) {
  switch (var_0) {
    case 0:
      var_1 notify("cache_common_weapon_found");
      break;
    case 1:
      var_1 notify("cache_uncommon_weapon_found");
      break;
    case 2:
      var_1 notify("cache_rare_weapon_found");
      break;
    case 3:
      var_1 notify("cache_epic_weapon_found");
      break;
    case 4:
      var_1 notify("cache_legendary_weapon_found");
      break;
  }
}

_id_21DA(var_0) {
  var_1 = self getplayerdata("common", "bankedEscapeCurrency");
  self setplayerdata("common", "bankedEscapeCurrency", var_1 + var_0);
}

_id_C609() {
  foreach(var_1 in level._id_9866) {
    if(isDefined(var_1._id_FE90)) {
      var_1._id_FE90 _meth_80E0(self);
    }
  }
}