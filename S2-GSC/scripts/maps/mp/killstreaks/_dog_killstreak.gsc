/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_dog_killstreak.gsc
***********************************************************/

init() {
  setup_callbacks();
}

setup_callbacks() {
  level._id_117E = [];
  level._id_1164 = 0;
  level._id_0A41["dog"]["spawn"] = ::spawn_dog;
  level._id_0A41["dog"]["on_killed"] = ::on_agent_dog_killed;
  level._id_0A41["dog"]["on_damaged"] = level._id_0A5C;
  level._id_0A41["dog"]["on_damaged_finished"] = ::on_damaged_finished;
  level._id_0A41["dog"]["think"] = ::_id_0A57;
  level.killstreakwieldweapons["agent_mp"] = "agent_mp";
  level.killstreakfuncs["attack_dogs"] = ::_id_9E26;
}

_id_9E26(var_0, var_1) {
  if(level._id_1164 == 1) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_DOGS");
    return 0;
  }

  if(maps\mp\agents\_agent_utility::getnumactiveagents("dog") >= 1) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_DOGS");
    return 0;
  }

  var_2 = maps\mp\agents\_agent_utility::get_max_agents();

  if(maps\mp\agents\_agent_utility::getnumactiveagents() >= var_2) {
    self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(self)) {
    return 0;
  }

  self._id_1162 = [];
  return _id_A207();
}

_id_A207() {
  level._id_1164 = 1;
  _id_0485::_id_5E9A("attack_dogs", self.origin);

  if(level._id_53C6) {
    var_0 = _getnodesinradiussorted(self.origin, 10000, 50, 2000, "Path");
  } else {
    var_0 = _getnodesinradiussorted(self.origin, 500, 50, 128, "Path");
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0.size <= 0) {
    return 1;
  }

  for(var_1 = 0; var_1 < 4; var_1++) {
    self._id_1162 = common_scripts\utility::_id_0FA0(self._id_1162);
    var_2 = self._id_1162.size;
    self._id_1162[var_2] = maps\mp\agents\_agent_common::connectnewagent("dog", self.team);

    if(!isDefined(self._id_1162[var_2])) {
      return 0;
    }

    self._id_1162[var_2] maps\mp\agents\_agent_utility::hudoutlineenable(self.team, self);
    var_3 = var_0[var_1].origin;
    var_4 = var_0[var_1].angles;
    self._id_1162[var_2] thread[[self._id_1162[var_2] maps\mp\agents\_agent_utility::_id_0A59("spawn")]](var_3, var_4, self);
  }

  thread _id_93B8();
  thread _id_77C2();
  thread _id_1165();
  thread _id_7DA6();
  return 1;
}

_id_93B8() {
  level endon("game_ended");
  self endon("end_attack_dogs");
  var_0 = common_scripts\utility::waittill_any_timeout_no_endon_death(80, "disconnect", "joined_team");
  level._id_1164 = 0;
  self notify("end_attack_dogs");
}

_id_77C2() {
  level endon("game_ended");
  self waittill("end_attack_dogs");

  foreach(var_1 in self._id_1162) {
    if(isDefined(var_1)) {
      maps\mp\agents\_agent_utility::killagent(var_1);
    }
  }

  level._id_1164 = 0;
}

_id_1165() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  self endon("end_attack_dogs");

  for(var_0 = 8; var_0 > 0; var_0--) {
    self waittill("respawn_dog");
  }

  level._id_1164 = 0;
  self notify("end_attack_dogs");
}

_id_7DA6() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  self endon("end_attack_dogs");

  for(var_0 = 0; var_0 < 4; var_0++) {
    self waittill("respawn_dog");
    self._id_1162 = common_scripts\utility::_id_0FA0(self._id_1162);
    var_1 = self._id_1162.size;
    self._id_1162[var_1] = maps\mp\agents\_agent_common::connectnewagent("dog", self.team);

    if(!isDefined(self._id_1162[var_1])) {
      return 0;
    }

    if(level._id_53C6) {
      var_2 = _id_04D4::_id_4437();
    } else {
      var_2 = [[level.getspawnpoint]]();
    }

    self._id_1162[var_1] thread[[self._id_1162[var_1] maps\mp\agents\_agent_utility::_id_0A59("spawn")]](var_2.origin, var_2.angles, self);
  }
}

on_agent_dog_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.isactive = 0;
  self.hasdied = 0;
  var_1.lastkilldogtime = gettime();

  if(isDefined(self._id_0EAD.onexit[self._id_0BA4])) {
    self[[self._id_0EAD.onexit[self._id_0BA4]]]();
  }

  if(isPlayer(var_1) && isDefined(self._id_0117) && var_1 != self._id_0117) {
    self._id_0117 maps\mp\_utility::leaderdialogonplayer("dog_killed");
    maps\mp\gametypes\_damage::onkillstreakkilled(var_1, var_4, var_3, var_2, "attack_dogs_destroyed", undefined, undefined, 1);

    if(isPlayer(var_1)) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_notsobestfriend");

      if(!self isonground()) {
        var_1 maps\mp\gametypes\_missions::processchallenge("ch_hoopla");
      }
    }
  }

  self setanimstate("death");
  var_9 = self getanimentry();
  var_10 = _getanimlength(var_9);
  var_8 = int(var_10 * 1000);
  self.body = self cloneagent(var_8);
  _id_0380::_id_6844("anml_doberman_death", undefined, self);
  maps\mp\agents\_agent_utility::deactivateagent();
  self notify("killanimscript");

  if(isDefined(self._id_0117)) {
    self._id_0117 notify("respawn_dog");
  }
}

on_damaged_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(self.playing_pain_sound)) {
    thread play_pain_sound(2.5);
  }

  var_11 = var_2;

  if(isDefined(var_8) && var_8 == "head") {
    var_11 = int(var_11 * 0.6);

    if(var_2 > 0 && var_11 <= 0) {
      var_11 = 1;
    }
  }

  if(self.health - var_11 > 0) {
    self[[level._id_31F3]](var_0, var_1, var_11, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isPlayer(var_1)) {
    if(isDefined(self.attackstate) && self.attackstate != "attacking") {
      if(distancesquared(self.origin, var_1.origin) <= self.dogdamagedradiussq) {
        self._id_0094 = var_1;
        self.forceattack = 1;
        self thread[[level._id_31FB]]();
      }
    }
  }

  [[level._id_0A41["player"]["on_damaged_finished"]]](var_0, var_1, var_11, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

spawn_dog(var_0, var_1, var_2, var_3) {
  var_4 = "animal_dobernan";

  if(isDefined(var_2) && isDefined(var_2.team)) {
    if(var_2.team == "axis") {
      var_4 = "iw6_dog";
    }
  }

  self setModel(var_4);
  self.species = "dog";
  self.onenteranimstate = level._id_31F4;
  self _meth_856C(15, 40);

  if(isDefined(var_0) && isDefined(var_1)) {
    var_5 = var_0;
    var_6 = var_1;
  } else {
    self _meth_856C(15, 40);
    var_7 = [[level.getspawnpoint]]();
    var_5 = var_7.origin;
    var_6 = var_7.angles;
  }

  maps\mp\agents\_agent_utility::_id_08A7();
  self[[level._id_31F2]]();
  self spawnagent(var_0, var_1, "dog_animclass", 15, 40, self);
  level notify("spawned_agent", self);
  maps\mp\agents\_agent_common::set_agent_health(100);

  if(isDefined(var_3)) {
    self._id_0BA6 = var_3;
    self _meth_858A(var_3);
    maps\mp\agents\_agent_utility::hudoutlineenable(self.team, var_2);
  }

  if(isDefined(var_2) && isDefined(var_2.team)) {
    maps\mp\agents\_agent_utility::hudoutlineenable(var_2.team, var_2);
  }

  self setthreatbiasgroup("Dogs");
  self takeallweapons();
  self thread[[maps\mp\agents\_agent_utility::_id_0A59("think")]]();
  wait 0.1;

  if(_ishairrunning()) {
    _playFXOnTag(level._id_3F1E, self, "tag_origin");
  }
}

play_pain_sound(var_0) {
  self endon("death");
  _id_0380::_id_6844("anml_doberman_pain", undefined, self);
  self.playing_pain_sound = 1;
  wait(var_0);
  self.playing_pain_sound = undefined;
}

_id_8F27(var_0) {
  foreach(var_2 in var_0) {
    var_2.weight = 0;
    var_3 = distance(var_2._id_9087.origin, self.origin);

    if(var_3 < 1500) {
      var_2.weight = 1;
    } else if(var_3 > 1500 && var_3 < 2000) {
      var_2.weight = 2;
    } else if(var_3 > 2000 && var_3 < 2500) {
      var_2.weight = 3;
    } else if(var_3 > 2500) {
      var_2.weight = 4;
    }

    foreach(var_5 in level.players) {
      var_6 = var_2._id_9087.origin;
      var_7 = var_5.origin;
      var_8 = _sighttracepassed(var_6, var_7, 0, var_5);

      if(var_8) {
        var_2.weight--;
      }

      var_3 = distance(var_2._id_9087.origin, var_5.origin);

      if(var_3 < 256) {
        var_2.weight--;
      }
    }
  }

  var_0 = common_scripts\utility::_id_0FA5(var_0, ::_id_5788);
  return var_0;
}

_id_5788(var_0, var_1) {
  return var_0.weight > var_1.weight;
}

_id_0A57() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  self endon("end_attack_dogs");
  self[[level._id_31F8]]();
  self._id_5B10 = (0, 0, 0);
  self.bhasnopath = 0;
  self._id_7A58 = 0;
  self.attackzheight = self.attackzheight + 100;
  thread locateenemypositions();
  self thread[[self.watchattackstatefunc]]();
  thread waitforbadpath();
  thread _id_0A56();

  for(;;) {
    if(self._id_0BA4 != "melee" && !self._id_018F && self[[level._id_31F5]]() && !self[[level._id_31B2]]()) {
      self scragentbeginmelee(self.curmeleetarget);
    }

    if(self._id_7A58 > gettime()) {
      waitframe();
      continue;
    }

    if(!isDefined(self._id_0088) || self.bhasnopath) {
      var_0 = _getnodesinradiussorted(self.origin, 1024, 256, 128, "Path");

      if(var_0.size > 0) {
        var_1 = _randomintrange(int(var_0.size * 0.9), var_0.size);
        self scragentsetgoalpos(var_0[var_1].origin);
        self.bhasnopath = 0;
        self._id_7A58 = gettime() + 2500;
      }
    } else {
      var_2 = self[[level._id_31F1]](self._id_0088);
      self.curmeleetarget = self._id_0088;
      self._id_0108 = "sprint";
      self.barrivalsenabled = 0;

      if(distancesquared(var_2, self._id_5B10) > 4096) {
        self scragentsetgoalpos(var_2);
        self._id_5B10 = var_2;
      }
    }

    waitframe();
  }
}

_id_0A56() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    while(!isDefined(self.curmeleetarget)) {
      wait 0.25;
    }

    while(isDefined(self.curmeleetarget) && distance(self.origin, self.curmeleetarget.origin) > 200) {
      wait(_randomfloatrange(0, 2));
      _id_0380::_id_6844("anml_doberman_bark", undefined, self);
    }

    waitframe();
  }
}

waitforbadpath() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("bad_path", var_0);
    self.bhasnopath = 1;
  }
}

_id_6367() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.origin;
  var_1 = gettime();

  for(;;) {
    wait 5.0;
    var_2 = distancesquared(self.origin, var_0);
    var_3 = (gettime() - var_1) / 1000;

    if(var_2 > 16384) {
      var_0 = self.origin;
      var_1 = gettime();
      continue;
    }

    if(var_3 > 25) {
      break;
    }
  }

  maps\mp\agents\_agent_utility::killagent(self);
}

locateenemypositions() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    foreach(var_1 in level.participants) {
      self getenemyinfo(var_1);
    }

    wait 0.5;
  }
}