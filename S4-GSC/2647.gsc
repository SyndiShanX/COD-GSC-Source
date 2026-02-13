/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2647.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("paratroopers", ::_id_FEA1);
}

_id_D795() {
  level._id_11EF["actor_enemy_mp_paratrooper"] = level._id_11EF["player"];
  level._id_11EF["actor_enemy_mp_paratrooper"]["spawn"] = ::_id_E1B5;
  level._id_11EF["actor_enemy_mp_paratrooper"]["on_killed"] = _id_07F7::_id_457C;
  level._id_11EF["actor_enemy_mp_paratrooper"]["on_damaged"] = _id_0016::_id_AA45;
  level._id_11EF["actor_enemy_mp_paratrooper"]["on_damaged_finished"] = _id_07F7::_id_457A;
}

_id_FEA1(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("#x31f351a1df8d60e90", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  var_1 = _id_09EF::_id_6DF2(1, 0, 3);

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = [];

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_2[var_3] = _id_0015::_id_3B84("actor_enemy_mp_paratrooper", self.team);

    if(!isDefined(var_2[var_3])) {
      for(var_4 = 0; var_4 < var_3; var_4++) {
        var_2[var_3].isactive = 0;
      }

      return 0;
    }

    var_2[var_3].isactive = 1;
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3].isactive = 0;
  }

  var_5 = spawnStruct();
  var_5._id_E00D = var_2;
  var_5._id_EEF7 = [];
  var_5._id_E011 = 3;
  var_5.owner = self;
  var_5._id_E00E = 0;

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_6 = var_2[var_3];
    var_6 _id_09EF::_id_D136(self.team, self);
    var_7 = var_1[var_3].origin;
    var_8 = vectortoangles(self.origin - var_1[var_3].origin);
    var_6 thread[[var_6 _id_09EF::_id_1215("spawn")]](var_7, var_8, self);
    var_6 thread _id_AE52(var_5);
  }

  var_5 _id_AE4E();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }

  return 1;
}

_id_E1B5(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_3 = var_0;
    var_4 = var_1;
  } else {
    var_5 = self[[level._id_6D4A]]();
    var_3 = var_5.origin;
    var_4 = var_5.angles;
  }

  var_6 = "enemy_mp_paratrooper";
  _id_07F7::_id_E32A(var_6, var_3, var_4);

  if(isDefined(var_2)) {
    _id_09EF::_id_D136(var_2.team, var_2);
    self _meth_8851(3, var_2.team);
  }

  level notify("spawned_agent", self);
  wait 0.1;
  return 1;
}

_id_AE52(var_0) {
  self endon("death");
  level endon("game_ended");
  thread _id_AE50(var_0);
}

_id_AE50(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  self waittill("death");
  var_0._id_EEF7[self getentitynumber()] = undefined;
  var_1 = scripts\engine\utility::_id_1BAB(var_0._id_E00D, self);
  var_0._id_E00D[var_1] = undefined;
  var_0._id_E00E = var_0._id_E00E + 1;

  if(var_0._id_E00E == 4) {
    var_0 thread _id_8D91();
    return;
  }

  if(var_0._id_E011 >= 4) {
    return;
  }
  var_0._id_E011 = var_0._id_E011 + 1;
  thread _id_E32C(var_0);
}

_id_E32C(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  wait 7;
  var_1 = undefined;

  while(!isDefined(var_1)) {
    var_1 = _id_0015::_id_3B84("actor_enemy_mp_paratrooper", var_0.owner.sessionteam);

    if(!isDefined(var_1)) {
      wait 1;
    }
  }

  var_2 = -1;

  for(var_3 = 0; var_3 < 3; var_3++) {
    if(!isDefined(var_0._id_E00D[var_3])) {
      var_2 = var_3;
      break;
    }
  }

  var_0._id_E00D[var_2] = var_1;
  var_1 _id_09EF::_id_D136(var_0.owner.sessionteam, var_0.owner);
  var_4 = undefined;

  while(!isDefined(var_4)) {
    var_4 = var_0.owner scripts\mp\playerlogic::_id_6D4A();

    if(!isDefined(var_4)) {
      wait 1;
    }
  }

  var_5 = var_4._id_E332;
  var_6 = var_4._id_E267;
  var_1 thread[[var_1 _id_09EF::_id_1215("spawn")]](var_5, var_6, var_0.owner);
  var_1 thread _id_AE52(var_0);
}

_id_AE4E() {
  thread _id_10BC3();
  thread _id_10BC6();
}

_id_8D91() {
  self notify("death");

  for(var_0 = 0; var_0 < self._id_E00D.size; var_0++) {
    if(!isDefined(self._id_E00D[var_0])) {
      continue;
    }
    _id_09EF::_id_8D5E(self._id_E00D[var_0]);
  }
}

_id_10BC3() {
  self endon("death");
  level endon("game_ended");
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
      thread _id_8D91();
    }
  }
}