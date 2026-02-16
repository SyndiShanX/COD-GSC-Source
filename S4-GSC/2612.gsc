/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2612.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("attack_dogs", ::_id_FE51);
  game["dialog"]["all_dogs_killed"] = "mp_glob_kill_bchr_adak";
}

_id_D795() {
  var_0 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isholidayenabled(2), "actor_s4_mp_attack_dog_codmas", "actor_s4_mp_attack_dog");
  level._id_11EF[var_0] = level._id_11EF["player"];
  level._id_11EF[var_0]["spawn"] = _id_0A3E::_id_E119;
  level._id_11EF[var_0]["on_killed"] = _id_0A3E::_id_AA44;
  level._id_11EF[var_0]["on_damaged"] = _id_0016::_id_AA45;
  level._id_11EF[var_0]["on_damaged_finished"] = _id_0A3E::_id_AA50;
  level._id_11EF[var_0]["think"] = _id_0B00::main;
}

_id_F779(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0, self);
  return _id_FE51(var_1);
}

_id_FE51(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!_id_0A3E::_id_B3D5("attack_dog", var_0)) {
    return 0;
  }

  var_1 = scripts\engine\utility::getStructArray("org_dog_spawn", "targetname");

  if(!_id_0A3E::_id_B5F9(var_0)) {
    return 0;
  }

  var_2 = _id_09EF::_id_6DF2(1, 0, 3);

  if(!isDefined(var_2) && (!isDefined(var_1) || var_1.size <= 0)) {
    return 0;
  }

  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_3[var_4] = _id_0015::_id_3B84(scripts\engine\utility::ter_op(scripts\mp\utility\game::isholidayenabled(2), "actor_s4_mp_attack_dog_codmas", "actor_s4_mp_attack_dog"), self.team);

    if(!isDefined(var_3[var_4])) {
      for(var_5 = 0; var_5 < var_4; var_5++) {
        var_3[var_4].isactive = 0;
      }

      return 0;
    }

    var_3[var_4].isactive = 1;
  }

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_3[var_4].isactive = 0;
  }

  var_6 = spawnStruct();
  var_6._id_4CD0 = var_3;
  var_6._id_EEF7 = [];
  var_6._id_4CDC = 3;
  var_6.owner = self;
  var_6._id_4CDA = 0;

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_7 = var_3[var_4];
    var_7 _id_09EF::_id_D136(self.team, self);

    if(isDefined(var_1) && var_1.size > 0) {
      var_8 = var_1[randomint(var_1.size)];
      var_9 = var_8.origin;
      var_10 = var_8.angles;
    } else {
      var_9 = var_2[var_4].origin;
      var_10 = vectortoangles(self.origin - var_2[var_4].origin);
    }

    var_7 _id_8143(var_9, var_10, var_6, self, var_0);
  }

  _id_0A3E::_id_D1E1("attack_dog", 1);
  var_6 _id_4CC5(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_attack_dog", var_0.owner);
  }

  return 1;
}

_id_8143(var_0, var_1, var_2, var_3, var_4) {
  self._id_4CEE = "attack_dog";
  self._id_F9A0 = 250000;
  self thread[[_id_09EF::_id_1215("spawn")]](var_0, var_1, var_3, scripts\engine\utility::ter_op(scripts\mp\utility\game::isholidayenabled(2), "actor_s4_mp_attack_dog_codmas", "actor_s4_mp_attack_dog"));
  thread _id_1DCE(var_2);
  self._id_9D6D = 1;
  self.streakinfo = var_4;
  scripts\mp\utility\killstreak::_id_1155(var_4.streakname, "Killstreak_Ground", var_4.owner, 0, 0);
}

_id_4CC5(var_0) {
  thread _id_10BC3();
  thread _id_10BC6();
  thread _id_4CC6(var_0);
}

_id_10BC3() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }
    self.owner waittill("death");

    switch (level.gametype) {
      case "sd":
        thread _id_8D72();
        break;
      case "sr":
        var_0 = level scripts\engine\utility::_id_10897("sr_player_eliminated", "sr_player_respawned");

        if(isDefined(var_0) && var_0 == "sr_player_eliminated") {
          thread _id_8D72();
        }

        break;
    }
  }
}

_id_10BC6() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.owner)) {
      return;
    }
    var_0 = self.owner scripts\engine\utility::_id_1089F("joined_team", "joined_spectators");

    if(isDefined(var_0) && (var_0 == "joined_team" || var_0 == "joined_spectators")) {
      thread _id_8D72();
    }
  }
}

_id_8D72() {
  self notify("death");
  self.owner _id_0A3E::_id_D1E1("attack_dog", 0);

  for(var_0 = 0; var_0 < self._id_4CD0.size; var_0++) {
    if(!isDefined(self._id_4CD0[var_0])) {
      continue;
    }
    self._id_4CD0[var_0] _id_09EF::_id_8D71();
  }
}

retreatdogcontroller(var_0) {
  self notify("death");
  self.owner _id_0A3E::_id_D1E1("attack_dog", 0);
  self._id_EEF7 = undefined;

  foreach(var_2 in self._id_4CD0) {
    if(!isDefined(var_2) || !isalive(var_2)) {
      continue;
    }
    var_2 notify("dog_retreat");
    var_2 _id_D52E(var_0, undefined);
    var_2._id_0229 = 1;

    if(!isDefined(var_0) || var_0.size == 0) {
      if(isDefined(var_2) && isalive(var_2)) {
        var_2 _id_09EF::_id_8D71();
      }

      continue;
    }

    var_0 = _func_0204(var_0, var_2.origin);
    var_3 = var_0[0].origin;

    if(distancesquared(var_2.origin, var_3) < 9000000) {
      var_4 = var_2 _id_06E0::_id_31A9(var_2.origin, var_3);

      if(!var_4._id_31A8) {
        var_3 = _func_02AB(var_3);
      }

      var_2 _meth_84BC(2, var_3);
      var_2 _meth_8600(2, 32);
      var_2 _meth_84C0(0);
      var_2 _meth_84C0(1);
      var_2 scripts\engine\utility::delaythread(2.0, ::retreattimeout);
      continue;
    }

    var_2 _id_09EF::_id_8D71();
  }
}

retreattimeout() {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self endon("death");
  level endon("game_ended");
  scripts\engine\utility::_id_108F5("traverse_warp_across_finished", 12);

  if(isDefined(self) && isalive(self)) {
    self.retreat = 1;
    _id_09EF::_id_8D71();
  }
}

_id_4CC6(var_0) {
  level endon("game_ended");
  self endon("death");
  wait 40;
  level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "adog_time");
  var_1 = scripts\engine\utility::getStructArray("org_dog_spawn", "targetname");
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);

  if(!isDefined(var_1) || var_1.size == 0) {
    thread _id_8D72();
  } else {
    thread retreatdogcontroller(var_1);
  }
}

_id_1DCE(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("dog_retreat");
  thread _id_1DCD(var_0);

  for(;;) {
    var_1 = _id_6978(var_0);

    if(!isDefined(var_1)) {
      wait 0.05;
      continue;
    }

    if(!isDefined(self._id_01BD) || self._id_01BD != var_1) {
      _id_D52E(var_0, var_1);
    }

    scripts\engine\utility::_id_10888(var_1, "death", self, "find_new_target");

    if(var_1.sessionstate == "dead") {
      _id_D52E(var_0, undefined);
    }
  }
}

_id_D52E(var_0, var_1) {
  var_0._id_EEF7[self getentitynumber()] = var_1;
  self._id_01BD = var_1;
  self._id_31FB = undefined;
  self._id_5E7C = 0;
}

_id_1DCD(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  self waittill("death");
  var_0._id_EEF7[self getentitynumber()] = undefined;
  var_1 = scripts\engine\utility::_id_1BAB(var_0._id_4CD0, self);
  var_0._id_4CD0[var_1] = undefined;
  var_0._id_4CDA = var_0._id_4CDA + 1;

  if(var_0._id_4CDA == 9) {
    var_0.owner thread _id_0A8D::_id_9137("all_dogs_killed");
    var_0 thread _id_8D72();
    return;
  }

  if(var_0._id_4CDC >= 9) {
    return;
  }
  var_0._id_4CDC = var_0._id_4CDC + 1;
  thread _id_E32B(var_0);
}

_id_E32B(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  wait 4;
  var_1 = undefined;

  while(!isDefined(var_1)) {
    var_1 = _id_0015::_id_3B84(scripts\engine\utility::ter_op(scripts\mp\utility\game::isholidayenabled(2), "actor_s4_mp_attack_dog_codmas", "actor_s4_mp_attack_dog"), var_0.owner.sessionteam);

    if(!isDefined(var_1)) {
      wait 1;
    }
  }

  var_2 = -1;

  for(var_3 = 0; var_3 < 3; var_3++) {
    if(!isDefined(var_0._id_4CD0[var_3])) {
      var_2 = var_3;
      break;
    }
  }

  var_0._id_4CD0[var_2] = var_1;
  var_1 _id_09EF::_id_D136(var_0.owner.sessionteam, var_0.owner);
  var_4 = scripts\engine\utility::getStructArray("org_dog_spawn", "targetname");

  if(!isDefined(var_4) || var_4.size == 0) {
    var_5 = undefined;

    while(!isDefined(var_5)) {
      var_5 = var_0.owner scripts\mp\playerlogic::_id_6D4A();

      if(!isDefined(var_5)) {
        wait 1;
      }
    }
  } else
    var_5 = var_4[randomint(var_4.size)];

  var_6 = var_5._id_E332;
  var_7 = var_5._id_E267;
  var_1 _id_8143(var_6, var_7, var_0, var_0.owner);
}

_id_6978(var_0) {
  var_1 = [];
  var_2 = var_0.owner.sessionteam;
  var_3 = [];

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(level.players[var_4].sessionteam == var_2 && scripts\mp\utility\game::getgametype() != "dm") {
      continue;
    }
    if(level.players[var_4].sessionstate == "dead") {
      continue;
    }
    if(isDefined(self.usedtarget) && isDefined(self._id_31FB) && self.usedtarget == level.players[var_4]) {
      continue;
    }
    if(level.players[var_4] scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
      continue;
    }
    var_1[var_1.size] = level.players[var_4];
    var_3[var_3.size] = 0;
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = _func_0204(var_1, self.origin);
  var_6 = undefined;

  for(var_4 = 0; var_4 < var_5.size; var_4++) {
    if(var_4 > 0) {
      waitframe();
    }

    var_7 = _id_06E0::_id_68E7(var_5[var_4]);
    var_8 = _id_06E0::_id_31A9(self.origin, var_7);

    if(!var_8._id_31A8) {
      continue;
    }
    var_3[var_4] = 1;

    if(scripts\engine\utility::array_contains(var_0._id_EEF7, var_5[var_4])) {
      continue;
    }
    var_6 = var_5[var_4];
    break;
  }

  if(!isDefined(var_6)) {
    for(var_4 = 0; var_4 < var_5.size; var_4++) {
      if(!var_3[var_4]) {
        continue;
      }
      var_6 = var_5[var_4];
    }
  }

  if(!isDefined(var_6)) {
    var_6 = var_5[0];
  }

  return var_6;
}