/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_damage.gsc
*************************************************/

_id_57F3() {
  if(isDefined(self._id_9566))
    return 1;

  return 0;
}

_id_5802() {
  var_0 = _id_0510::_id_2697();
  var_0[self._id_5C62]--;
  var_0[self._id_596B]++;
  return var_0[self._id_596B] - var_0[self._id_5C62] < 2;
}

_id_56FA(var_0, var_1) {
  if(!level.teambased)
    return 0;

  if(!isDefined(var_1))
    return 0;

  if(!isPlayer(var_1) && !isDefined(var_1.team))
    return 0;

  if(var_0.team != var_1.team)
    return 0;

  if(var_0 == var_1)
    return 0;

  if(isDefined(var_0) && isDefined(var_1) && _func_1EF(var_0) && isDefined(var_0._id_0A4B) && var_0._id_0A4B == "leprechauns")
    return 0;

  return 1;
}

_id_8B8B(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(common_scripts\utility::_id_562E(var_0._id_3E24))
    return 0;

  if(var_0 _meth_801D() || var_0 _meth_82E4() || !var_0 _meth_8346() || var_0 _meth_800A())
    return 0;

  if(isDefined(var_0.nuked))
    return 0;

  return 1;
}

_id_5A44(var_0) {
  if(!isPlayer(var_0))
    return 0;

  if(var_0 != self)
    return 0;

  return 1;
}

_id_4AFC() {
  if(!level.teambased) {
    return;
  }
  if(self._id_596B == "spectator" || !_id_5802()) {
    self thread[[level._id_6BCE]]("suicide");
    maps\mp\_utility::incpersstat("suicides", 1);
    self._id_94DD = maps\mp\_utility::getpersstat("suicides");
  }
}

_id_4B08(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.team)) {
    _id_4AF8(var_2, var_3);
    return;
  }

  if(level.teambased && var_0.team != self.team || !level.teambased) {
    if(isDefined(level._id_6B5C) && (isPlayer(var_0) || _func_1EF(var_0)) && var_0.team != "spectator")
      [[level._id_6B5C]](self, var_0, var_1);
  }
}

_id_47B9(var_0) {
  var_1 = int(max(0, _id_04D2::_id_0638(self) - var_0));
  _id_04D2::_id_06D8(self, var_1);
}

_id_4AF8(var_0, var_1) {
  self thread[[level._id_6BCE]]("suicide");
  maps\mp\_utility::incpersstat("suicides", 1);
  self._id_94DD = maps\mp\_utility::getpersstat("suicides");

  if(!maps\mp\_utility::privatematch() && self._id_94DD == 15)
    thread _id_2CDF();

  var_2 = _id_0511::_id_46F7("game", "suicidepointloss");
  _id_47B9(var_2);

  if(var_0 == "MOD_SUICIDE" && var_1 == "none" && isDefined(self.throwinggrenade))
    self._id_5BA1 = gettime();

  if(isDefined(level._id_6BB2))
    [[level._id_6BB2]](self);

  if(isDefined(self._id_3EC1))
    self iprintlnbold(&"MP_FRIENDLY_FIRE_WILL_NOT");

  self.pers["suicideSpawnDelay"] = _id_0511::_id_46F7("game", "suicidespawndelay", 1);
}

_id_2CDF() {
  self endon("disconnect");
  level endon("game_ended");
  wait(_func_0A4(1, 60));
  _func_134(self getentitynumber());
}

_id_4AC3(var_0) {
  if(_func_367()) {
    return;
  }
  var_0 thread[[level._id_6BCE]]("teamkill");
  var_0.pers["teamkills"] = var_0.pers["teamkills"] + 1.0;
  var_0.pers["totalTeamKills"] = var_0.pers["totalTeamKills"] + 1.0;
  var_0._id_9857++;

  if(_id_0511::_id_46F7("team", "teamkillpointloss")) {
    var_1 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
    var_0 _id_47B9(var_1);
  }

  var_2 = var_0 maps\mp\gametypes\_playerlogic::_id_9856();

  if(var_2 > 0) {
    var_0.pers["teamKillPunish"] = 1;
    var_0 maps\mp\_utility::_suicide();
  }

  var_3 = _id_0511::_id_46F7("team", "teamkillkicklimit");

  if(var_3 > 0) {
    var_4 = var_0.pers["totalTeamKills"];

    if(var_4 >= var_3)
      thread _id_3ED0(var_0);
  }
}

_id_3ED0(var_0) {
  waittillframeend;

  if(!_func_279(var_0))
    _func_134(var_0 getentitynumber(), "EXE_PLAYERKICKED_TEAMKILL");

  level thread maps\mp\gametypes\_gamelogic::_id_A11E();
}

_id_4AD8(var_0, var_1, var_2, var_3, var_4) {
  var_1 thread _id_047A::_id_5A40(var_0, self, var_3, var_4, var_2);
  var_1 _meth_83CB();

  if(maps\mp\_utility::isbulletdamage(var_4))
    _id_0378::_id_8D74("snd_mp_player_death");

  if(var_4 == "MOD_HEAD_SHOT") {
    var_1 _id_0378::_id_8D74("mp_headshot_killer");
    _id_0378::_id_8D74("mp_headshot_killed");
  }

  var_1 thread _id_047A::_id_5A41(self, var_3, var_4, var_2);
  thread _id_0533::_id_3F90();
  var_5 = var_1.pers["cur_kill_streak"];

  if(var_1 maps\mp\_utility::_hasperk("specialty_intelkillsandassists"))
    _func_256(self.origin, var_1, 750);

  if(isalive(var_1)) {
    if(var_1 maps\mp\_utility::_hasperk("specialty_boostafterkill"))
      var_1 thread _id_052C::handleescalationboostafterkill();

    if(var_1 maps\mp\_utility::_hasperk("specialty_multikillboost"))
      var_1 thread _id_052C::handleclassifiedboostaftermultikillorheadshot(var_4 == "MOD_HEAD_SHOT");

    if(maps\mp\_utility::_id_5755(var_4) || var_1 maps\mp\_utility::_id_5A54(var_3)) {
      var_1.pers["cur_kill_streak"]++;
      var_1._id_00E4 = var_1.pers["cur_kill_streak"];
      var_1 notify("kill_streak_increased");

      if(maps\mp\_utility::isbulletdamage(var_4) && var_1 maps\mp\_utility::_hasperk("specialty_deadeye"))
        var_1.deadeyekillcount++;

      if(maps\mp\_utility::_id_0F5C() && getdvarint("scorestreak_enabled_v2_rocket") == 1) {
        if(var_1 _id_04CA::hasaccesstov2rocket()) {
          if(!maps\mp\_utility::iskillstreakweapon(var_3)) {
            var_1.pers["cur_kill_streak_for_nuke"]++;
            var_6 = 25;

            if(var_1 maps\mp\_utility::_hasperk("specialty_hardline"))
              var_6--;

            if(var_1.pers["cur_kill_streak_for_nuke"] == var_6) {
              var_7 = var_1 _id_051E::_id_45A5("v2_rocket", 0);
              var_1 thread _id_051E::_id_478D("v2_rocket", 0, 1, var_1);
              var_1 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("v2_rocket", var_6, undefined, var_7);
            }
          }
        }
      }
    }

    var_1 maps\mp\_utility::setplayerstatifgreater("longestkillstreak", var_1.pers["cur_kill_streak"]);

    if(var_1.pers["cur_kill_streak"] > var_1 maps\mp\_utility::getpersstat("longestStreak"))
      var_1 maps\mp\_utility::setpersstat("longestStreak", var_1.pers["cur_kill_streak"]);

    if(var_1 maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight"))
      var_1 thread _id_052C::fightorflightregeneratehealth();

    if(var_1 maps\mp\_utility::_hasperk("specialty_extrascorewhilehealing"))
      var_1 thread _id_052C::fasterhealthregenkilltrigger();
  }

  var_1.pers["cur_death_streak"] = 0;

  if(var_1.pers["cur_kill_streak"] > var_1 maps\mp\gametypes\_persistence::statgetchild("round", "killStreak"))
    var_1 maps\mp\gametypes\_persistence::statsetchild("round", "killStreak", var_1.pers["cur_kill_streak"]);

  if(var_1 maps\mp\_utility::rankingenabled()) {
    if(var_1.pers["cur_kill_streak"] > var_1._id_5A1D) {
      var_1 maps\mp\gametypes\_persistence::statset("killStreak", var_1.pers["cur_kill_streak"]);
      var_1._id_5A1D = var_1.pers["cur_kill_streak"];
    }
  }

  var_8 = _id_0511::_id_46F7("game", "deathpointloss");
  _id_47B9(var_8);
  level notify("player_got_killstreak_" + var_1.pers["cur_kill_streak"], var_1);
  var_1 notify("got_killstreak", var_1.pers["cur_kill_streak"]);
  var_1 notify("killed_enemy");

  if(isDefined(level._id_6B5C) && var_1.pers["team"] != "spectator")
    [[level._id_6B5C]](self, var_1, var_0);

  if(isDefined(self._id_5B6F) && isDefined(self._id_5B70) && self._id_5B6F != var_1) {
    if(gettime() - self._id_5B70 < 5000) {
      if(level.teambased)
        self._id_5B6F thread _id_047A::_id_774E(self, "assist_riot_shield");
      else
        self._id_5B6F thread _id_047A::_id_7751(self, "crossfire_riot_shield");

      if(!isDefined(level.disabledivisionchallenges) || !level.disabledivisionchallenges)
        self._id_5B6F maps\mp\gametypes\_missions::processchallenge("ch_grenadier_skill");
    }
  }

  if(!level.teambased) {
    if(isDefined(self._id_1189)) {
      foreach(var_10 in self._id_1189) {
        if(!isDefined(maps\mp\_utility::_id_073C(var_10._id_118A)) || var_10._id_118A == var_1 || self == var_10._id_118A) {
          continue;
        }
        var_11 = "crossfire_low";
        var_12 = 0;

        foreach(var_14 in var_10._id_A9DF) {
          if(_id_0513::_id_57F6(var_14)) {
            var_12 = 1;
            break;
          }
        }

        var_16 = 0;

        if(var_10._id_118A maps\mp\_utility::_hasperk("specialty_paint_pro") && isDefined(var_10._id_118A._id_90DA) && isDefined(self._id_6DEC) && self._id_6DEC) {
          if(isDefined(self.paintedattackers) && isDefined(self.paintedattackers[var_10._id_118A.guid]) && self.paintedattackers[var_10._id_118A.guid] + var_10._id_118A._id_90DA * 1000 >= gettime())
            var_16 = 1;
        }

        var_17 = 0;

        if(var_10._id_118A maps\mp\_utility::_hasperk("specialty_paint") && isDefined(var_10._id_118A._id_90DA) && isDefined(self._id_6DEC) && self._id_6DEC) {
          if(isDefined(self.paintedexpeditionaryattackers) && isDefined(self.paintedexpeditionaryattackers[var_10._id_118A.guid]) && self.paintedexpeditionaryattackers[var_10._id_118A.guid] + var_10._id_118A._id_90DA * 1000 >= gettime())
            var_17 = 1;
        }

        if(var_17 && var_10._id_2994 < 60)
          var_11 = "crossfire_painted_expeditionary";
        else if(var_16 && var_10._id_2994 < 60)
          var_11 = "crossfire_painted";
        else if(var_12 && var_10._id_2994 < 60)
          var_11 = "crossfire_tactical";
        else if(var_10._id_2994 >= 40 && var_10._id_2994 < 60)
          var_11 = "crossfire_mid";
        else if(var_10._id_2994 >= 60 && var_10._id_2994 < 80)
          var_11 = "crossfire_high";
        else if(var_10._id_2994 >= 80)
          var_11 = "crossfire_steal";

        var_10._id_118A thread _id_047A::_id_7751(self, var_11, var_10._id_01D0);

        if(var_10._id_118A maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight"))
          var_10._id_118A thread _id_052C::fightorflightregeneratehealth();
      }
    }

    return;
  }

  level thread _id_04C2::_id_807A(var_1, "kill", 0.75);

  if(!maps\mp\_utility::iskillstreakweapon(var_3)) {
    var_19["uav"] = [];
    var_19["counter_uav"] = [];
    var_19["advanced_uav"] = [];

    if(isDefined(level._id_9FDA)) {
      foreach(var_21 in level._id_9FDA[var_1.team]) {
        if(!isDefined(var_21._id_0117)) {
          continue;
        }
        if(common_scripts\utility::_id_0F79(var_19[var_21._id_01C8], var_21._id_0117)) {
          continue;
        }
        var_19[var_21._id_01C8][var_19[var_21._id_01C8].size] = var_21._id_0117;

        if(var_21._id_01C8 == "counter_uav") {
          if(var_21._id_0117 != var_1 && var_21._id_0117 maps\mp\_utility::_hasperk("specialty_killstreaks")) {
            var_21._id_0117 thread _id_047A::_id_774E(self, "assist_counter_uav");
            var_21._id_0117 maps\mp\gametypes\_missions::processchallenge("ch_career_killstreakassists", 10);
          }

          continue;
        }

        if(var_21._id_0117 == var_1) {
          var_21._id_0117 maps\mp\gametypes\_missions::processchallenge("ch_streak_actionableintel");
          continue;
        }

        var_21._id_0117 thread _id_047A::_id_774E(self, "assist_uav");
        var_21._id_0117 maps\mp\gametypes\_persistence::incrementscorestreakstat(var_21._id_01C8, "killsOrAssists", 1);
        var_21._id_0117 maps\mp\gametypes\_missions::processchallenge("ch_career_killstreakassists", 10);
        var_21._id_0117 maps\mp\gametypes\_missions::processchallenge("ch_streak_uav", 10);
      }
    }

    var_23 = level.teambased && isDefined(level._id_3CE0) && level._id_3CE0 != var_1 && level._id_3CE0 maps\mp\_utility::_hasperk("specialty_killstreaks");

    if(var_23) {
      level._id_3CE0 thread _id_047A::_id_774E(self, "assist_flak_guns");
      level._id_3CE0 maps\mp\gametypes\_missions::processchallenge("ch_career_killstreakassists", 10);
    }
  }

  if(isDefined(self._id_95B8))
    self._id_95B8 = undefined;

  if(level.teambased && isDefined(level.teamemped) && level.teamemped[self.team] || !level.teambased && isDefined(level.empplayer) && level.empplayer != self) {
    if(isDefined(level._id_35F5) && level._id_35ED && level._id_35F5 != var_1)
      level._id_35F5 thread _id_047A::_id_774E(self, "assist_emp");

    _id_0485::logkillstreakassist(level._id_35F5);
  }

  if(isDefined(self._id_1189)) {
    foreach(var_10 in self._id_1189) {
      if(!isDefined(maps\mp\_utility::_id_073C(var_10._id_118A))) {
        continue;
      }
      if(var_10._id_118A == var_1) {
        continue;
      }
      if(self == var_10._id_118A) {
        continue;
      }
      if(maps\mp\_utility::iskillstreakweapon(var_10._id_01D0) && var_10._id_01D0 != "killstreak_flak_gun_raids" && var_10._id_01D0 != "agent_raid_fighters_mp") {
        var_10._id_118A maps\mp\gametypes\_missions::processchallenge("ch_career_killstreakassists");
        _id_0485::logkillstreakassist(var_10._id_118A);
      }

      var_11 = "assist_low";
      var_25 = 0;

      foreach(var_14 in var_10._id_A9DF) {
        if(_id_0513::_id_57F6(var_14)) {
          var_25 = 1;
          break;
        }
      }

      var_28 = 0;

      if(var_10._id_118A maps\mp\_utility::_hasperk("specialty_paint_pro") && isDefined(var_10._id_118A._id_90DA) && isDefined(self._id_6DEC) && self._id_6DEC) {
        if(isDefined(self.paintedattackers) && isDefined(self.paintedattackers[var_10._id_118A.guid]) && self.paintedattackers[var_10._id_118A.guid] + var_10._id_118A._id_90DA * 1000 >= gettime())
          var_28 = 1;
      }

      var_29 = 0;

      if(var_10._id_118A maps\mp\_utility::_hasperk("specialty_paint") && isDefined(var_10._id_118A._id_90DA) && isDefined(self._id_6DEC) && self._id_6DEC) {
        if(isDefined(self.paintedexpeditionaryattackers) && isDefined(self.paintedexpeditionaryattackers[var_10._id_118A.guid]) && self.paintedexpeditionaryattackers[var_10._id_118A.guid] + var_10._id_118A._id_90DA * 1000 >= gettime())
          var_29 = 1;
      }

      if(var_29 && var_10._id_2994 < 60)
        var_11 = "assist_painted_expeditionary";
      else if(var_28 && var_10._id_2994 < 60)
        var_11 = "assist_painted";
      else if(var_25 && var_10._id_2994 < 60)
        var_11 = "assist_tactical";
      else if(var_10._id_2994 >= 40 && var_10._id_2994 < 60)
        var_11 = "assist_mid";
      else if(var_10._id_2994 >= 60 && var_10._id_2994 < 80)
        var_11 = "assist_high";
      else if(var_10._id_2994 >= 80)
        var_11 = "assist_steal";

      var_10._id_118A thread _id_047A::_id_774E(self, var_11, var_10._id_01D0, var_10._id_A9DF);

      if(var_10._id_118A maps\mp\_utility::_hasperk("specialty_intelkillsandassists"))
        _func_256(self.origin, var_10._id_118A, 750);

      if(var_10._id_118A maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight"))
        var_10._id_118A thread _id_052C::fightorflightregeneratehealth();
    }
  }
}

_id_5785(var_0) {
  if(weaponclass(var_0) == "non-player")
    return 0;

  if(weaponclass(var_0) == "turret")
    return 0;

  if(weaponinventorytype(var_0) == "primary" || weaponinventorytype(var_0) == "altmode")
    return 1;

  return 0;
}

callback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
}

callback_playergrenadesuicide(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self._id_3961 = [];
  self._id_3961["damageTime"] = gettime();
  self._id_3961["damageId"] = var_0 getentitynumber();
  self._id_3961["returnToSender"] = 0;
  self._id_3961["counterKill"] = 0;
  self._id_3961["chainKill"] = 0;
  self._id_3961["cookedKill"] = 0;
  self._id_3961["throwbackKill"] = 0;
  self._id_3961["midAirDetonate"] = 0;
  self._id_3961["suicideGrenadeKill"] = self == var_0;
  self._id_3961["weapon"] = var_4;
}

_id_1E64() {
  self delete();
}

_id_5C2D(var_0, var_1) {
  self _meth_84D2("none", 1);
  _id_048A::_id_7E96();
}

playerkilled_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = var_4;
  var_12 = gettime();
  var_2 endon("spawned");
  var_2 notify("killed_player");
  var_2._id_5D9F = 0;

  if(isDefined(var_4) && var_4 == "MOD_FALLING" && isDefined(var_2) && isDefined(var_2._id_5723) && var_2._id_5723 && isDefined(var_2._id_6E4B))
    var_1 = var_2._id_6E4B;

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_1._id_3903) && var_1._id_3903 == 1)
    var_1 maps\mp\gametypes\_missions::processchallenge("ch_exoability_ping");

  if(isDefined(var_2.waterwakevfxdeletefunc))
    var_2[[var_2.waterwakevfxdeletefunc]]();

  if(isDefined(var_2._id_7682))
    var_2[[var_2._id_7682]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  var_2 maps\mp\gametypes\_playerlogic::_id_7D72();
  var_2._id_083E = 0;
  var_2._id_6F64 = 0;
  var_2._id_83E4 = 0;
  var_1 = maps\mp\_utility::_id_073C(var_1);

  if(isDefined(var_1))
    var_1._id_10E9 = undefined;

  if(!isDefined(var_2._id_5033)) {
    if(var_4 == "MOD_SUICIDE")
      var_2._id_5033 = 0;
    else if(var_4 == "MOD_GRENADE") {
      if((issubstr(var_5, "frag_grenade") || issubstr(var_5, "thermobaric_grenade")) && var_3 == 100000)
        var_2._id_5033 = 0;
      else if(var_5 == "v2_rocket_mp")
        var_2._id_5033 = 0;
      else if(level._id_3EC4 >= 2)
        var_2._id_5033 = 0;
      else {}
    }
  }

  if(var_2 _id_048A::_id_4B8C())
    var_2 _id_5C2D(var_3, var_4);

  if(!maps\mp\_utility::_id_5697(var_4, var_5)) {}

  if(!var_10) {
    if(isDefined(var_2._id_36B9))
      maps\mp\_utility::_id_7E50(2);
    else {
      maps\mp\_utility::_id_7E50(0);
      var_2 _meth_80A9();
    }
  } else {
    _func_2D3(var_2, 1);
    self notify("death", var_1, var_4, var_5);
  }

  if(game["state"] == "postgame") {
    return;
  }
  var_13 = 0;

  if(!isPlayer(var_0) && isDefined(var_0.primaryweapon))
    var_14 = var_0.primaryweapon;
  else if(isDefined(var_1) && isPlayer(var_1) && var_1 _meth_8317() != "none")
    var_14 = var_1 _meth_8317();
  else if(issubstr(var_5, "alt_"))
    var_14 = getsubstr(var_5, 4, var_5.size);
  else
    var_14 = undefined;

  if(isDefined(var_2._id_A219) || isDefined(var_2._id_5BEF) && var_4 == "MOD_SUICIDE") {
    var_2 _id_378E();
    var_2._id_A219 = undefined;
    var_0 = var_2._id_5BEF._id_35A9;
    var_1 = maps\mp\_utility::_id_073C(var_2._id_5BEF._id_1180);
    var_3 = var_2._id_5BEF._id_502C;
    var_4 = var_2._id_5BEF._id_8CD7;
    var_5 = var_2._id_5BEF._id_953E;
    var_14 = var_2._id_5BEF._id_912F;
    var_6 = var_2._id_5BEF._id_A2B1;
    var_7 = var_2._id_5BEF._id_8B0A;
    var_13 = (gettime() - var_2._id_5BEF._id_5BF4) / 1000;
    var_2._id_5BEF = undefined;
  }

  if((!isDefined(var_1) || !isDefined(var_1.classname) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2) && isDefined(self._id_1193)) {
    var_15 = undefined;

    foreach(var_17 in self._id_1193) {
      if(!isDefined(maps\mp\_utility::_id_073C(var_17))) {
        continue;
      }
      if(!isDefined(var_2._id_1189[var_17.guid]._id_2994)) {
        continue;
      }
      if(var_17 == var_2 || level.teambased && var_17.team == var_2.team) {
        continue;
      }
      if(var_2._id_1189[var_17.guid]._id_5C08 + 2500 < gettime() && (var_1 != var_2 && (isDefined(var_2._id_00E8) && var_2._id_00E8))) {
        continue;
      }
      if(var_2._id_1189[var_17.guid]._id_2994 > 1 && !isDefined(var_15)) {
        var_15 = var_17;
        continue;
      }

      if(isDefined(var_15) && var_2._id_1189[var_17.guid]._id_2994 > var_2._id_1189[var_15.guid]._id_2994)
        var_15 = var_17;
    }

    if(isDefined(var_15)) {
      var_1 = var_15;

      if(!isDefined(self._id_6E6B) || !self._id_6E6B)
        var_1._id_10E9 = 1;

      var_5 = var_2._id_1189[var_15.guid]._id_01D0;
      var_6 = var_2._id_1189[var_15.guid]._id_A2B1;
      var_7 = var_2._id_1189[var_15.guid]._id_8B0A;
      var_8 = var_2._id_1189[var_15.guid]._id_014A;
      var_4 = var_2._id_1189[var_15.guid]._id_8CD7;
      var_3 = var_2._id_1189[var_15.guid]._id_2994;
      var_14 = var_2._id_1189[var_15.guid]._id_912F;
      var_0 = var_1;
    }
  } else if(isDefined(var_1))
    var_1._id_10E9 = undefined;

  if(maps\mp\_utility::_id_570A(var_5, var_7, var_4, var_1))
    var_4 = "MOD_HEAD_SHOT";

  if(var_4 == "MOD_HEAD_SHOT" && isDefined(var_6)) {}

  var_19 = _id_56FA(var_2, var_1);

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_003B)) {
      if(var_1._id_003B == "script_vehicle" && isDefined(var_1._id_0117))
        var_1 = var_1._id_0117;

      if(var_1._id_003B == "misc_turret" && isDefined(var_1._id_0117)) {
        if(isDefined(var_1._id_A2C8))
          var_1._id_A2C8 notify("killedPlayer", var_2);

        var_1 = var_1._id_0117;
      }
    }

    var_2._id_1187 = undefined;

    if(_func_1EF(var_1) && isDefined(var_1._id_0117)) {
      if(isDefined(var_1._id_0A4B))
        var_2._id_1187 = var_1._id_0A4B;

      var_2._id_1186 = var_1 getentitynumber();
      var_1 = var_1._id_0117;
      var_5 = "agent_mp";
      var_4 = "MOD_RIFLE_BULLET";

      if(isDefined(var_2._id_1187) && var_2._id_1187 == "bomberEscortFighterAgents")
        var_5 = "agent_raid_fighters_mp";
    }

    if(isDefined(var_1._id_003B) && var_1._id_003B == "script_model" && isDefined(var_1._id_0117)) {
      var_1 = var_1._id_0117;

      if(!_id_56FA(var_2, var_1) && var_1 != var_2)
        var_1 notify("crushed_enemy");
    }
  }

  if(var_4 != "MOD_SUICIDE" && (maps\mp\_utility::_id_5666(var_2) || maps\mp\_utility::_id_5666(var_1)) && isDefined(level._id_19D5) && isDefined(level._id_19D5["get_attacker_ent"])) {
    var_20 = [[level._id_19D5["get_attacker_ent"]]](var_1, var_0);

    if(isDefined(var_20)) {
      if(maps\mp\_utility::_id_5666(var_2))
        var_2 _meth_8364("death", var_5, var_20.origin, var_2.origin, var_20);

      if(maps\mp\_utility::_id_5666(var_1)) {
        var_21 = 1;

        if(var_20.classname == "script_vehicle" && isDefined(var_20._id_4C9E) || var_20.classname == "rocket" || var_20.classname == "misc_turret")
          var_21 = 0;

        if(var_21)
          var_1 _meth_8364("kill", var_5, var_20.origin, var_2.origin, var_2);
      }
    }
  }

  if(isDefined(var_2.grenadierfrenzy) && var_2.grenadierfrenzy == 1)
    var_2 _id_052C::togglegrenadierfrenzy(0);

  var_22 = var_2 getcurrentweapon();
  var_2 thread _id_0513::_id_34A9(var_1, var_4, var_5);

  if(!isDefined(var_2._id_0A4F))
    var_2 thread[[level._id_A9C5]](var_1, var_4, var_5);
  else
    var_2._id_0A4F thread[[level._id_A9C5]](var_1, var_4, var_5);

  if(!var_10)
    var_2 maps\mp\_utility::_id_A165("dead");

  var_23 = isDefined(var_2) && isDefined(var_2._id_9566) && var_2._id_9566;

  if(!var_23)
    var_2 maps\mp\gametypes\_playerlogic::_id_7CDD();

  if(!isDefined(var_2._id_9566) && !(isDefined(level._id_585D) && level._id_585D) && !_id_56FA(var_2, var_1)) {
    var_2 maps\mp\_utility::incpersstat("deaths", 1);
    var_2 maps\mp\_utility::incplayerstat("deaths", 1);
    var_2.deaths = var_2 maps\mp\_utility::getpersstat("deaths");

    if(!_func_3AF() && !(isDefined(level._id_2F8B) && level._id_2F8B) && !(isDefined(level.disableallplayerstats) && level.disableallplayerstats)) {
      var_2 maps\mp\_utility::updatepersratio("kdRatio", "kills", "deaths");
      var_2 maps\mp\gametypes\_persistence::statsetchild("round", "deaths", var_2.deaths);
      var_2 _id_04CA::_id_50FC(var_2._id_0079, 1, "deaths");
    }
  }

  var_24 = maps\mp\_utility::_id_5755(var_4) && issubstr(var_5, "bayonet");

  if(!maps\mp\_utility::_id_761E() && (!level._id_53C7 || !isbot(var_1)))
    _func_15C(var_2, var_1, var_5, var_4, var_24);

  var_25 = 0;
  var_2 _id_5EAB(self._id_5CC6, var_1, var_3, var_4, var_5, var_14, var_7);
  var_2 _id_0485::_id_5EA6(1);
  var_2 _id_0485::_id_5EA5(self._id_5CC6, var_0, var_1, var_3, var_4, var_5, var_14, var_7, var_22);

  if(maps\mp\_utility::_id_5755(var_4) && isPlayer(var_1) && !issubstr(var_5, "riotshield"))
    var_1 maps\mp\_utility::incplayerstat("knifekills", 1);

  var_26 = 0;

  if(var_2 _id_57F3())
    _id_4AFC();
  else if((!isPlayer(var_1) || isPlayer(var_1) && var_4 == "MOD_FALLING") && (!isDefined(var_2._id_5723) || !var_2._id_5723)) {
    _id_4B08(var_1, self._id_5CC6, var_4, var_7);

    if(_func_1EF(var_1))
      var_25 = 1;

    if(_id_04E6::_id_585A(var_0, var_1, var_5))
      var_25 = 1;
  } else if(var_1 == var_2 && (isDefined(var_0) && (!isDefined(var_0._id_576B) || var_0._id_576B == 0)))
    _id_4AF8(var_4, var_7);
  else if(var_19) {
    if(!isDefined(var_2.nuked))
      _id_4AC3(var_1);
  } else {
    var_25 = 1;

    if(_func_0C1(var_2)) {
      if(isDefined(level._id_19D5) && isDefined(level._id_19D5["should_do_killcam"]))
        var_25 = var_2[[level._id_19D5["should_do_killcam"]]]();
    }

    if(isDefined(var_2._id_1187) && var_2._id_1187 == "bomberEscortFighterAgents")
      var_25 = 0;

    if(isDefined(var_0) && (!isDefined(var_0._id_576B) || var_0._id_576B == 0)) {
      _id_4AD8(self._id_5CC6, var_1, var_0, var_5, var_4);
      var_26 = 1;
    }

    var_2.pers["cur_death_streak"]++;
    var_1 thread _id_04E7::_id_A128(var_1, var_2);
    var_2 thread _id_04E7::_id_A128(var_1, var_2);
  }

  if(isDefined(var_1) && isDefined(var_1._id_10E9) && var_1._id_10E9)
    var_25 = 0;

  var_2 _id_A106(self._id_1193, self._id_1189);

  if(!level.teambased)
    self._id_1193 = [];

  var_27 = 0;
  var_28 = undefined;

  if(isDefined(self._id_76DD)) {
    var_27 = 1;
    var_28 = self._id_76DD;
    self._id_76DD = undefined;
  }

  if(isPlayer(var_1) && var_1 != self && (!level.teambased || level.teambased && self.team != var_1.team)) {
    if(var_27 && isDefined(var_28))
      var_29 = var_28;
    else
      var_29 = self._id_5B94;

    thread maps\mp\gametypes\_gamelogic::_id_9BC0(var_29, var_4);
    var_1 thread maps\mp\gametypes\_gamelogic::_id_9BA0(var_5, var_4, var_0);
  }

  var_2._id_A878 = undefined;

  if(isDefined(var_2._id_9566))
    var_2._id_A878 = 1;

  var_2 _id_7D6A();
  var_2._id_00E6 = var_1;
  var_2._id_5BAE = var_0;

  if(!isDefined(var_2._id_0A4F))
    var_2._id_5B90 = var_2.origin;
  else
    var_2._id_5B90 = var_2._id_0A4F.origin;

  var_2._id_2AB8 = gettime();

  if(isPlayer(var_1) && var_2 != var_1 && (!level.teambased || level.teambased && var_2.team != var_1.team) && (!isDefined(level._id_5A7D) || !isDefined(level._id_5A7D[var_5]) || var_5 == "flamethrower_mp" || var_5 == "flamethrower_german_mp" || var_5 == "flamethrower_grenadier_mp" || var_5 == "flamethrower_german_grenadier_mp" || var_5 == "killstreak_molotov_cocktail_mp" || var_5 == "killstreak_molotov_cocktail_grenadier_mp")) {
    var_30["position"] = var_2._id_5B90;
    var_30["time"] = var_2._id_2AB8;

    if(level.teambased)
      level._id_7AD1[var_2.team][level._id_7AD1[var_2.team].size] = var_30;
    else {
      var_30["player"] = self.guid;
      level._id_7AD1["all"][level._id_7AD1["all"].size] = var_30;
    }
  }

  var_2._id_A7F5 = 0;
  var_2._id_7E54 = 0;
  var_2._id_803E = 0;
  var_2 _id_051E::_id_7D50(0);
  var_2 _id_052C::resetspecialistperkstreak();
  var_31 = _id_046D::_id_46EB(var_2) - var_2._id_80A7;
  var_2 maps\mp\_utility::setplayerstatifgreater("mostScorePerLife", var_31);
  var_32 = undefined;

  if(maps\mp\_utility::_id_57B0()) {
    var_25 = 1;
    var_10 = 0;
    var_32 = self._id_5A2C;
    self waittill("final_rocket_corpse_death");
  } else {
    if(var_10) {
      var_25 = 0;

      if(!isDefined(var_2._id_0A4F))
        var_9 = var_2 _meth_8020(var_0, var_4, var_5, var_7, var_6);
    }

    if(isDefined(var_2._id_4D13) && var_2._id_4D13) {
      var_2 _meth_8003();
      thread _id_04C8::_id_09AA(var_2, var_2, var_2.team, 5.0, var_1, var_4, var_5);
    } else if(var_2 maps\mp\perks\_medic::canspawnmedicpatienttrigger())
      var_2 thread maps\mp\perks\_medic::ondeath_handlemedic();
    else if(!isDefined(var_2._id_0A4F)) {
      var_2._id_18A8 = var_2 _meth_826D(var_9);
      var_2._id_18A8._id_2685 = var_2._id_2685;

      if(isDefined(var_2._id_5DA9)) {
        var_2._id_18A8 _meth_8070();

        if(isDefined(var_2._id_5DAA))
          var_2._id_18A8 _meth_8055(var_2._id_5DA9, var_2._id_5DAA);
        else
          var_2._id_18A8 _meth_8055(var_2._id_5DA9);
      }

      var_33 = common_scripts\utility::_id_562E(var_2._id_3E19);

      if((var_33 || issubstr(var_11, "MOD_GRENADE") || issubstr(var_11, "MOD_EXPLOSIVE") || issubstr(var_11, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1)) {
        if(getdvarint("scr_dismemberment_style", 0) == 0 && !_func_367() && getdvarint("isEsportsMatch", 0) == 0 && level.gametype != "infect" && maps\mp\_utility::_id_4571() != "mp_sandbox_01") {
          if(isDefined(var_5) && var_5 != "smoke_grenade_mp" && var_5 != "stun_grenade_mp" && var_5 != "signal_flare_mp" && var_5 != "signal_flare_expeditionary_mp" && var_5 != "tabun_grenade_mp" && var_5 != "carepackage_crate_mp") {
            var_2 _id_04EB::_id_4AAB(var_33);

            if(isDefined(var_2._id_65D2) && isDefined(var_2._id_65D1))
              _func_147(common_scripts\utility::_id_44F5(var_2._id_65D2), var_2._id_18A8, var_2._id_65D1);
          }
        }
      }

      if(var_10)
        var_2 _meth_8003();

      if(!_id_8B8B(var_2))
        var_2._id_18A8 _meth_8028();

      if(!isDefined(var_2._id_9566))
        thread _id_04C8::_id_09AA(var_2._id_18A8, var_2, var_2.team, 5.0, var_1, var_4, var_5);

      thread _id_2CEC(var_2._id_18A8, var_7, var_6, var_5, var_0, var_4);
      var_2 notify("corpse_created");
    } else if(!isDefined(var_2._id_9566))
      thread _id_04C8::_id_09AA(var_2._id_0A4F, var_2, var_2.team, 5.0, var_1, var_4, var_5);
  }

  if(!maps\mp\_utility::_id_570A(var_5, var_7, var_11, var_1) && !isDefined(var_2.nuked))
    var_2 maps\mp\_utility::_id_7210(var_11, var_5);

  var_2 thread[[level._id_6B7B]](var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self._id_5CC6);

  if(var_26)
    var_2 thread maps\mp\gametypes\_missions::_id_7417(var_0, var_1, var_3, var_4, var_5, var_14, var_7, var_1._id_62A1);

  if(_func_0C1(var_2) && isDefined(level._id_19D5) && isDefined(level._id_19D5["on_killed"]))
    var_2 thread[[level._id_19D5["on_killed"]]](var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self._id_5CC6);

  if(maps\mp\_utility::_id_56FF(var_1))
    var_34 = var_1 getentitynumber();
  else
    var_34 = -1;

  if(isDefined(level._id_585D) && level._id_585D)
    var_34 = -1;

  if(!isDefined(var_32) && isDefined(var_1))
    var_32 = var_2 _id_452F(var_1, var_0, var_5);

  var_35 = -1;
  var_36 = 0;
  var_37 = 0;

  if(isDefined(var_32)) {
    var_35 = var_32 getentitynumber();
    var_36 = var_32._id_002B;

    if(isDefined(var_32._id_5A32)) {
      var_36 = var_32._id_5A32;
      var_37 = 1;
    }

    if(!isDefined(var_36))
      var_36 = 0;
  } else if(var_5 == "orbital_laser_fov_mp" && isDefined(var_0) && isDefined(var_0._id_5A32)) {
    var_36 = var_0._id_5A32;
    var_37 = 1;
  }

  if(common_scripts\utility::_id_562E(level.forcenokillcam))
    var_25 = 0;

  if(isDefined(var_1) && isDefined(var_1._id_5BE2))
    var_38 = (gettime() - var_1._id_5BE2) / 1000.0;
  else
    var_38 = 0;

  if(var_4 != "MOD_SUICIDE" && !(!isDefined(var_1) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2) && !common_scripts\utility::_id_562E(level.forcenokillcam))
    _id_04CE::_id_7B32(5.0, var_2, var_1, var_34, var_35, var_36, var_5, var_13, var_8, var_4, "normal", var_37);

  if(_id_04E6::_id_5A34(var_2, var_25)) {
    var_39 = maps\mp\gametypes\_playerlogic::_id_9A1C(1);
    var_40 = maps\mp\gametypes\_gamelogic::_id_9A1B();
    var_41 = _id_04E6::_id_5A33(var_36, var_5, 0, var_39, var_40, var_37, 0);
    var_42 = _id_04E6::_id_5A2A(var_41, var_38, var_13, var_8 / 1000);
    var_2 _id_04E6::_id_7681(var_0, var_1, var_42, var_22);
  } else if(maps\mp\_utility::isvalidclass(var_2.class))
    var_2 maps\mp\gametypes\_playerlogic::_id_9455();

  var_43 = gettime() + 5000;

  if(!var_10) {
    wait 0.25;

    if(_id_04E6::_id_5A34(var_2, var_25)) {
      var_2 thread _id_04E6::_id_1F41();
      var_2 _meth_82FF("ui_show_skip_killcam", 1);
    }

    wait 0.25;
    self._id_7DB7 = gettime() + 1000;
    var_39 = maps\mp\gametypes\_playerlogic::_id_9A1C(1);

    if(var_39 < 1)
      var_39 = 1;

    wait 1.5;

    if(isDefined(self._id_9459) && self._id_9459.size > 0) {
      while(_id_04E6::_id_5A34(var_2, var_25) && isPlayer(self) && isPlayer(var_1) && !self _meth_842C(var_1, self._id_9459) && gettime() < var_43)
        waitframe();
    }

    if(common_scripts\utility::_id_562E(var_2.onplayerkilledwaitfordeathduration)) {
      var_44 = gettime() - var_2._id_2AB8;

      if(var_9 > var_44) {
        var_45 = (var_9 - var_44) / 1000;
        wait(var_45);
      }

      var_2.onplayerkilledwaitfordeathduration = undefined;
    }

    var_46 = var_2 _meth_85E2();

    if(isDefined(var_46))
      var_2 _meth_80F4();

    var_2 _meth_82FF("ui_show_skip_killcam", 0);
    var_2 notify("death_delay_finished");
  }

  var_47 = (gettime() - var_2._id_2AB8) / 1000;
  self._id_7DB7 = gettime();
  var_48 = gettime() >= var_43;

  if(_id_04E6::_id_5A34(var_2, var_25) && !var_48) {
    var_49 = !(maps\mp\_utility::getgametypenumlives() && !var_2.pers["lives"]);
    var_39 = maps\mp\gametypes\_playerlogic::_id_9A1C(1);
    var_50 = var_49 && var_39 <= 0;

    if(!var_49) {
      var_39 = -1;
      level notify("player_eliminated", var_2);
    }

    var_2 _id_04E6::_id_5A29(var_0, var_34, var_35, var_36, var_5, var_47 + var_13, var_8, var_39, maps\mp\gametypes\_gamelogic::_id_9A1B(), var_1, var_2, var_4, "normal", var_38, var_37);
  }

  if(isDefined(var_2._id_1187))
    var_2._id_1187 = undefined;

  if(game["state"] != "playing") {
    if(!level._id_8C03) {
      var_2 maps\mp\_utility::_id_A165("dead");
      var_2 maps\mp\_utility::clearkillcamstate();
    }

    return;
  }

  var_51 = maps\mp\_utility::getgametypenumlives();
  var_52 = self.pers["lives"];

  if(maps\mp\_utility::isvalidclass(var_2.class))
    var_2 thread maps\mp\gametypes\_playerlogic::_id_9035();
}

_id_A798() {
  self endon("randomSpawnPressed");
  self._id_5998 settext(&"PLATFORM_PRESS_TO_TEAMSPAWN");
  self._id_5998.alpha = 1;
  self._id_5997 settext(&"PLATFORM_PRESS_TO_RESPAWN");
  self._id_5997.alpha = 1;
  thread _id_A702();
  thread _id_A6FD();

  if(isDefined(self._id_8C8A) && self._id_8C8A)
    var_0 = 8;
  else
    var_0 = 9;

  if(isDefined(self._id_9A19))
    var_1 = int(_func_0D5(var_0 - (gettime() - self._id_9A19) / 1000));
  else
    var_1 = var_0;

  self._id_6E9D = 0;
  wait 0.5;

  for(var_2 = var_1; var_2 > 0; var_2--) {
    maps\mp\_utility::_id_86C3("kc_info", &"MP_TIME_TILL_SPAWN", var_1, 1, 1);
    wait 1;
  }

  self._id_5997.alpha = 0;
  self._id_5998.alpha = 0;
  maps\mp\_utility::_id_2401("kc_info");
  self notify("abort_fireteam_spawn");
}

_id_A6FD() {
  self endon("disconnect");
  self endon("abort_fireteam_spawn");

  while(self _meth_8341())
    waitframe();

  while(!self _meth_8341()) {
    waitframe();

    if(!maps\mp\_utility::isreallyalive(self._id_6E9C)) {
      break;
    }
  }

  self._id_6E9D = 0;
  self notify("randomSpawnPressed");
  self._id_5997.alpha = 0;
  self._id_5998.alpha = 0;
  maps\mp\_utility::_id_2401("kc_info");
  self notify("abort_fireteam_spawn");
}

_id_A702() {
  self endon("disconnect");
  self endon("abort_fireteam_spawn");

  while(self _meth_8342())
    waitframe();

  while(!self _meth_8342())
    waitframe();

  self._id_6E9D = 1;
  self playlocalsound("copycat_steal_class");
  self notify("teamSpawnPressed");
  self._id_5997.alpha = 0;
  self._id_5998.alpha = 0;
}

_id_21B7() {
  if(level._id_2EF3 != 1)
    return 0;

  if(!maps\mp\_utility::getgametypenumlives())
    return 0;

  if(level._id_5DDB[self.team] > 0)
    return 0;

  foreach(var_1 in level.players) {
    if(!isalive(var_1)) {
      continue;
    }
    if(var_1.team != self.team) {
      continue;
    }
    if(var_1 == self) {
      continue;
    }
    if(!var_1._id_5378)
      return 0;
  }

  foreach(var_1 in level.players) {
    if(!isalive(var_1)) {
      continue;
    }
    if(var_1.team != self.team) {
      continue;
    }
    if(var_1._id_5378 && var_1 != self)
      var_1 _id_5BEA(0);
  }

  return 1;
}

_id_7D6A() {
  self._id_5A43 = [];
  self._id_9566 = undefined;
  self._id_596B = undefined;
  self._id_5C62 = undefined;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self._id_00E4 = 0;
  _id_04D1::_id_2E46();
}

_id_452F(var_0, var_1, var_2) {
  if(isDefined(var_0._id_2EEC) && var_0._id_2EEC && isDefined(var_0._id_9EDD)) {
    var_0._id_2EEC = undefined;
    return var_0._id_9EDD._id_5A2C;
  }

  switch (var_2) {
    case "war_tripwire_mp":
    case "fighter_strike_plane_grenadier_mp":
    case "fighter_strike_plane_mp":
    case "bouncingbetty_mp":
    case "c4_mp":
    case "flamethrower_german_grenadier_mp":
    case "flamethrower_grenadier_mp":
    case "flamethrower_german_mp":
    case "flamethrower_mp":
    case "azon_projectile_grenadier_mp":
    case "fritzx_projectile_grenadier_mp":
    case "azon_projectile_mp":
    case "fritzx_projectile_mp":
    case "carepackage_crate_mp":
    case "bomb_site_mp":
      if(isDefined(var_1))
        return var_1._id_5A2C;

      break;
    case "agent_raid_fighters_mp":
    case "agent_mp":
      return var_1;
    case "thermite_flames_mp":
    case "firebomb_flames_mp":
      self._id_5A32 = gettime() - 2000;
      return self;
    case "ww2_fighter_bullet_mp":
    case "fighter_strike_gun_mp":
      if(isDefined(var_1) && isDefined(var_1._id_700B))
        return var_1._id_700B._id_5A2C;

      break;
    case "ball_drone_projectile_mp":
    case "ball_drone_gun_mp":
      if(isPlayer(var_0) && isDefined(var_0._id_1560) && isDefined(var_0._id_1560._id_9EDD) && isDefined(var_0._id_1560._id_9EDD._id_5A2C))
        return var_0._id_1560._id_9EDD._id_5A2C;

      break;
    case "none":
      if(isDefined(var_1) && isDefined(var_1.targetname) && (var_1.targetname == "care_package" || var_1.targetname == "rocket_button"))
        return var_1._id_5A2C;

      break;
  }

  if(maps\mp\_utility::_id_56C4(var_2) || maps\mp\_utility::_id_568F(var_2)) {
    if(isDefined(var_1._id_5A2C) && !var_0 _id_118C())
      return var_1._id_5A2C;
    else
      return undefined;
  }

  if(_id_04E6::_id_585A(var_1, var_0, var_2)) {
    if(var_2 == "turretweapon_tank_panzer_cannon_mp_left" || var_2 == "turretweapon_tank_panzer_cannon_mp_right")
      return var_1._id_5A2C;

    return var_0._id_5A2C;
  }

  if(!isDefined(var_1) || var_0 == var_1 && !_func_1EF(var_0))
    return undefined;

  return var_1;
}

_id_118C() {
  if(!isDefined(self))
    return 0;

  if(isDefined(level._id_2210) && isDefined(level._id_2210._id_48EA) && self == level._id_2210._id_48EA)
    return 1;

  if(isDefined(self._id_A255) && self._id_A255)
    return 1;

  if(isDefined(self._id_A254) && self._id_A254)
    return 1;

  return 0;
}

_id_4DD9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[0] = 2;
  var_5[1] = 3;
  var_5[2] = 5;
  var_5[3] = 7;

  if(!getdvarint("scr_hitloc_debug")) {
    return;
  }
  if(!isDefined(var_0._id_4DDA)) {
    for(var_6 = 0; var_6 < 6; var_6++)
      var_0 setclientdvar("ui_hitloc_" + var_6, "");

    var_0._id_4DDA = 1;
  }

  if(level.splitscreen || !isPlayer(var_0)) {
    return;
  }
  var_7 = 6;

  if(!isDefined(var_0._id_29CC)) {
    var_0._id_29CC = [];

    for(var_6 = 0; var_6 < var_7; var_6++) {
      var_0._id_29CC[var_6] = spawnStruct();
      var_0._id_29CC[var_6]._id_2994 = 0;
      var_0._id_29CC[var_6]._id_4DD8 = "";
      var_0._id_29CC[var_6]._id_1B7C = 0;
      var_0._id_29CC[var_6]._id_24FB = 0;
    }

    var_0._id_29CD = 0;
    var_0._id_29CE = undefined;
  }

  for(var_6 = var_7 - 1; var_6 > 0; var_6--) {
    var_0._id_29CC[var_6]._id_2994 = var_0._id_29CC[var_6 - 1]._id_2994;
    var_0._id_29CC[var_6]._id_4DD8 = var_0._id_29CC[var_6 - 1]._id_4DD8;
    var_0._id_29CC[var_6]._id_1B7C = var_0._id_29CC[var_6 - 1]._id_1B7C;
    var_0._id_29CC[var_6]._id_24FB = var_0._id_29CC[var_6 - 1]._id_24FB;
  }

  var_0._id_29CC[0]._id_2994 = var_2;
  var_0._id_29CC[0]._id_4DD8 = var_3;
  var_0._id_29CC[0]._id_1B7C = var_4 &level._id_5039;

  if(isDefined(var_0._id_29CE) && var_0._id_29CE != var_1) {
    var_0._id_29CD++;

    if(var_0._id_29CD == var_5.size)
      var_0._id_29CD = 0;
  }

  var_0._id_29CE = var_1;
  var_0._id_29CC[0]._id_24FB = var_0._id_29CD;

  for(var_6 = 0; var_6 < var_7; var_6++) {
    var_8 = "^" + var_5[var_0._id_29CC[var_6]._id_24FB];

    if(var_0._id_29CC[var_6]._id_4DD8 != "") {
      var_9 = var_8 + var_0._id_29CC[var_6]._id_4DD8;

      if(var_0._id_29CC[var_6]._id_1B7C)
        var_9 = var_9 + " (BP)";

      var_0 setclientdvar("ui_hitloc_" + var_6, var_9);
    }

    var_0 setclientdvar("ui_hitloc_damage_" + var_6, var_8 + var_0._id_29CC[var_6]._id_2994);
  }
}

_id_5709(var_0) {
  if(!maps\mp\_utility::_hasperk("specialty_stun_resistance"))
    return 0;

  switch (var_0) {
    case "mp_lab_gas":
    case "killstreak_strike_missile_gas_mp":
      return 1;
  }

  return 0;
}

_id_1E69(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_1) && var_1 != var_2 && isDefined(var_3) && var_3 > 0) {
    var_1 notify("has_recently_done_damage");

    if(isDefined(var_1.has_recently_done_damage))
      var_1.has_recently_done_damage++;
    else
      var_1.has_recently_done_damage = 1;
  }

  if(getdvarint("4017", 0) && !_func_367())
    return "4017";

  if(_func_367() && isDefined(var_1) && isPlayer(var_1) && !_id_0513::isonevonedamage(var_1, var_2)) {
    return;
  }
  if(maps\mp\_utility::_id_5697(var_5, var_6) && isDefined(var_2) && isDefined(var_2._id_A019) && var_2._id_A019) {
    return;
  }
  if(issubstr(var_6, "turretweapon_tank_panzer_cannon_mp") && maps\mp\_utility::_id_4571() == "mp_raid_dlc3" && isDefined(var_2) && isDefined(var_2.team) && isDefined(game["defenders"]) && var_2.team == game["defenders"]) {
    return;
  }
  var_1 = maps\mp\_utility::_id_073C(var_1);

  if(level.gametype == "infect") {
    if(isDefined(var_1) && isDefined(var_2.pers["team"]) && var_2.pers["team"] == "allies" && isDefined(var_1.pers["team"]) && var_1.pers["team"] == "axis") {
      if(isDefined(var_1._id_984E) && var_1._id_984E)
        return;
    }
  }

  if(isDefined(var_5) && var_5 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle")
    return "crushed";

  if(!maps\mp\_utility::isreallyalive(var_2) && !isDefined(var_2._id_5379))
    return "!isReallyAlive( victim )";

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing")
    return "soft_landing";

  if(var_6 == "killstreak_emp_mp")
    return "sWeapon == killstreak_emp_mp";

  if(var_6 == "killstreak_air_strike_mp" || var_6 == "killstreak_uav_mp" || var_6 == "killstreak_uav_axis_mp") {
    if(isDefined(var_6) && isDefined(var_5) && isDefined(var_1) && isDefined(var_1.name) && isDefined(var_2) && isDefined(var_2.name)) {}
  }

  if(!maps\mp\_utility::_id_585F() && isDefined(var_1) && isDefined(var_1.classname) && issubstr(var_1.classname, "misc_turret"))
    var_1 = var_1 _meth_80E2();

  if(var_2 _id_5709(var_6))
    return "specialty_stun_resistance";

  if((var_6 == "emp_grenade_mp" || var_6 == "emp_grenade_killstreak_mp") && var_5 != "MOD_IMPACT")
    var_2 notify("emp_grenaded", var_1);

  if(isDefined(level.hostmigrationtimer))
    return "level.hostMigrationTimer";

  var_11 = maps\mp\_utility::_id_118D(var_2, var_1);

  if(var_5 == "MOD_FALLING")
    var_2 _meth_82FF("ui_fullscreen_dirt_left", 1);

  if(var_5 == "MOD_EXPLOSIVE_BULLET" && var_3 != 1) {
    var_3 = var_3 * getdvarfloat("scr_explBulletMod");
    var_3 = int(var_3);
  }

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "worldspawn")
    var_1 = undefined;

  if(isDefined(var_1) && isDefined(var_1._id_48EA))
    var_1 = var_1._id_48EA;

  if(isDefined(var_1) && var_1 == var_2 && var_6 == "killstreak_strike_missile_gas_mp")
    return "gasCloudOwner";

  if(isDefined(var_1) && isPlayer(var_1) && _func_17B(var_5) && issubstr(var_6, "explosive_drone") && var_2 maps\mp\_utility::_hasperk("specialty_blastshield2") && maps\mp\_utility::isreallyalive(var_2))
    var_2._id_3959 = var_1;

  var_12 = isDefined(var_1) && isDefined(var_0) && isDefined(var_2) && isPlayer(var_1) && var_1 == var_0 && var_1 == var_2 && !isDefined(var_0._id_754A);
  var_13 = var_6 == "fighter_strike_gun_mp" || maps\mp\_utility::_id_5697(var_5, var_6);

  if(var_12 && !var_13)
    return "attackerIsInflictorVictim";

  var_14 = 0.0;
  var_15 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

  if(!_func_1EF(self)) {
    if(isDefined(var_1) && issubstr(var_15, var_5) && var_3 > 0) {
      if(!isDefined(self._id_29A2[var_1 getentitynumber()]))
        self._id_29A2[var_1 getentitynumber()] = spawnStruct();

      if(!isDefined(self._id_29A2[var_1 getentitynumber()]._id_6875))
        self._id_29A2[var_1 getentitynumber()]._id_6875 = 0;

      self._id_29A2[var_1 getentitynumber()]._id_6875++;
    }
  }

  var_16 = undefined;

  if(level.gametype == "onevone")
    level._id_6B14 = gettime();

  var_17 = 0;

  if(isDefined(var_2._id_5D2E))
    var_17 = 1;

  if(var_4 &level.idflags_shield_explosive_impact) {
    var_14 = 0.0;
    var_3 = 0.0;
  } else if(var_9 == "shield") {
    var_16 = "hitriotshield";

    if(var_11 && level._id_3EC4 == 0)
      return "attackerIsHittingTeammate";

    if(!var_11 && isDefined(var_2) && isDefined(var_3) && _func_2A2(var_3) && issubstr(var_2 getcurrentweapon(), "riotshield_mp")) {
      if(!isDefined(var_2.pers["riotshield_dmg_taken"]))
        var_2.pers["riotshield_dmg_taken"] = 0;

      var_2.pers["riotshield_dmg_taken"] = var_2.pers["riotshield_dmg_taken"] + var_3;

      if(var_2.pers["riotshield_dmg_taken"] > 400) {
        var_2 _id_047A::riotshielddamagetakenevent();
        var_2.pers["riotshield_dmg_taken"] = 0;
      }
    }

    if(var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET" && !var_11) {
      if(isPlayer(var_1) && isDefined(var_2) && issubstr(var_2 getcurrentweapon(), "riotshield_mp")) {
        var_1._id_5B6F = var_2;
        var_1._id_5B70 = gettime();
      }

      if(maps\mp\_utility::_id_56DF(var_6))
        var_18 = 25;
      else
        var_18 = _id_052D::_id_1E13(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);

      var_2._id_8AFE = var_2._id_8AFE + var_18;

      if(!maps\mp\_utility::_id_56DF(var_6) || common_scripts\utility::_id_24A6()) {
        var_2._id_8AFD++;

        if(isDefined(var_2.pers["bulletsBlockedByShield"]))
          var_2.pers["bulletsBlockedByShield"]++;
      }

      if(var_2._id_8AFD >= level._id_7EA4) {
        var_2._id_8AFE = 0;
        var_2._id_8AFD = 0;
      }
    }

    if(var_4 &level.idflags_shield_explosive_impact_huge || var_5 == "MOD_IMPACT" && issubstr(var_6, "grenade_launcher") && issubstr(var_6, "alt+")) {
      var_9 = "none";

      if(!(var_4 &level.idflags_shield_explosive_splash)) {
        if(getdvarint("spv_cavalryImpactExplosivesBlocked_enabled", 0) == 1)
          var_3 = 51;
      }
    } else if(var_4 &level.idflags_no_team_protection) {
      if(isDefined(var_0) && isDefined(var_0._id_9488) && var_0._id_9488 == var_2 || issubstr(var_6, "explosive_tips_dp28"))
        var_3 = 150;

      var_9 = "none";
    } else {
      var_1 thread _id_04C7::_id_A102("hitriotshield");
      return "hit shield";
    }
  } else if(maps\mp\_utility::_id_5755(var_5)) {
    if(!(var_11 && level._id_3EC4 == 0)) {
      if(issubstr(var_6, "riotshield")) {
        var_14 = 0.0;
        var_2 _meth_8183(0.0);
      }
    }

    if(_func_367() && isDefined(var_1._id_572A) && var_1._id_572A && isDefined(var_1.current1v1weaponmode) && var_1.current1v1weaponmode == 1)
      var_3 = 110;

    if(_func_367() && isDefined(var_2) && isDefined(var_1) && isDefined(var_2._id_5692) && var_2._id_5692 && isDefined(var_1._id_5692) && var_1._id_5692 && isDefined(var_2._id_34D2) && isDefined(var_1._id_34D2) && var_2._id_34D2 == var_1 && var_1._id_34D2 == var_2) {
      if(var_2.health - var_3 <= 0) {
        var_2 _meth_8182("frag_grenade_mp", 2.5);
        var_2 _meth_809F("artillery_rumble");
      } else if(var_3 > 30) {
        var_2 _meth_8182("frag_grenade_mp", 1.25);
        var_2 _meth_809F("heavygun_fire");
      } else {
        var_2 _meth_8182("frag_grenade_mp", 0.75);
        var_2 _meth_809F("damage_heavy");
      }
    }
  }

  if(var_6 == "bouncingbetty_mp") {
    var_19 = var_2 _meth_8178();

    switch (var_19) {
      case "prone":
        var_3 = var_3 * 0.25;
        break;
      case "crouch":
        var_3 = var_3 * 0.55;
        break;
      default:
        break;
    }
  }

  if(isDefined(var_1) && var_1 == var_2 && var_6 == "teslagunmtx_mp")
    var_3 = var_3 * 0.5;

  if(!var_11)
    var_3 = _id_052D::_id_1E13(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0);
  else if(_func_17B(var_5) || var_5 == "MOD_GAS") {
    if(var_2 maps\mp\_utility::_hasperk("specialty_blastshield2") && isDefined(var_2._id_90D4) && !_id_0513::_id_57F6(var_6) && !_id_052D::_id_3154(var_6))
      var_3 = int(var_3 * var_2._id_90D4);
  } else if(maps\mp\_utility::_id_5697(var_5, var_6)) {
    if(var_2 maps\mp\_utility::_hasperk("specialty_fireshield") && isDefined(var_2._id_90D8))
      var_3 = int(var_3 * var_2._id_90D8);
  }

  if(isDefined(level._id_62AD))
    var_3 = [[level._id_62AD]](var_2, var_0, var_1, var_3, var_5, var_6, var_7, var_8, var_9, undefined);

  var_20 = isDefined(var_1) && !isDefined(var_1._id_48EA) && isDefined(var_1.classname) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");
  var_11 = maps\mp\_utility::_id_118D(var_2, var_1);

  if(!var_3)
    return "!iDamage";

  var_2._id_5033 = var_4;
  var_2._id_5041 = gettime();

  if(game["state"] == "postgame")
    return "game[ state ] == postgame";

  if(var_2._id_0179 == "spectator")
    return "victim.sessionteam == spectator";

  if(isDefined(var_2._id_1F4D) && !var_2._id_1F4D)
    return "!victim.canDoCombat";

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_1._id_1F4D) && !var_1._id_1F4D)
    return "!eAttacker.canDoCombat";

  if(isDefined(var_1) && isalive(var_1) && !isDefined(var_1._id_6F64))
    var_1._id_6F64 = 0;

  if(var_20 && var_11) {
    if(var_5 == "MOD_CRUSH") {
      var_2 maps\mp\_utility::_suicide();
      return "suicide crush";
    }

    if(!level._id_3EC4)
      return "!level.friendlyfire";
  }

  if(_func_0C1(self))
    self[[level._id_19D5["on_damaged"]]](var_1, var_3, var_5, var_6, var_0, var_9);

  if(!isDefined(var_8))
    var_4 = var_4 | level.idflags_no_knockback;

  var_21 = 0;

  if(var_2.health == var_2.maxhealth && (!isDefined(var_2._id_00E8) || !var_2._id_00E8) || !isDefined(var_2._id_1193) && !isDefined(var_2._id_00E8)) {
    var_2._id_1193 = [];
    var_2._id_1189 = [];
  }

  if(maps\mp\_utility::_id_570A(var_6, var_9, var_5, var_1))
    var_5 = "MOD_HEAD_SHOT";

  if(_id_0511::_id_46F7("game", "onlyheadshots")) {
    if(var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET")
      return "getTweakableValue( game, onlyheadshots )";
    else if(var_5 == "MOD_HEAD_SHOT")
      var_3 = 150;
  }

  if(maps\mp\_utility::_id_5755(var_5) && isPlayer(var_2) && var_2 _meth_8178() == "prone")
    var_3 = 150;

  if(var_6 == "none" && isDefined(var_0)) {
    if(isDefined(var_0._id_0075) && issubstr(var_0._id_0075, "vehicle_"))
      var_6 = "destructible_car";
  }

  if(isDefined(level._id_5CC7) && isDefined(level._id_5CC7[var_2._id_5CC6]) && gettime() < level._id_5CC7[var_2._id_5CC6] + level._id_5A77) {
    var_22 = int(max(var_2.health / 4, 1));

    if(var_3 >= var_22 && maps\mp\_utility::iskillstreakweapon(var_6) && !maps\mp\_utility::_id_5755(var_5)) {
      var_3 = var_22;

      if(var_6 == "firebomb_flames_mp")
        var_3 = 2;
    }
  }

  if(!(var_4 &level.idflags_passthru)) {
    if(!level.teambased && var_20 && isDefined(var_1._id_0117) && var_1._id_0117 == var_2) {
      if(var_5 == "MOD_CRUSH")
        var_2 maps\mp\_utility::_suicide();

      return "ffa suicide";
    }

    if((issubstr(var_5, "MOD_GRENADE") || issubstr(var_5, "MOD_EXPLOSIVE") || issubstr(var_5, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1)) {
      if(var_2 != var_1 && var_0.classname == "grenade" && var_2._id_5BE2 + 3500 > gettime() && isDefined(var_2._id_5BE0) && distance(var_0.origin, var_2._id_5BE0.origin) < 250)
        return "spawnkill grenade protection";

      var_2._id_3961 = [];
      var_2._id_3961["damageTime"] = gettime();
      var_2._id_3961["damageId"] = var_0 getentitynumber();
      var_2._id_3961["returnToSender"] = 0;
      var_2._id_3961["counterKill"] = 0;
      var_2._id_3961["chainKill"] = 0;
      var_2._id_3961["cookedKill"] = 0;
      var_2._id_3961["throwbackKill"] = 0;
      var_2._id_3961["suicideGrenadeKill"] = 0;
      var_2._id_3961["midAirDetonate"] = 0;
      var_2._id_3961["weapon"] = var_6;
      var_23 = issubstr(var_6, "frag_");

      if(var_1 != var_2) {
        if((issubstr(var_6, "c4_") || issubstr(var_6, "claymore_")) && isDefined(var_1) && isDefined(var_0._id_0117)) {
          var_2._id_3961["returnToSender"] = var_0._id_0117 == var_2;
          var_2._id_3961["counterKill"] = isDefined(var_0._id_A86E);
          var_2._id_3961["chainKill"] = isDefined(var_0._id_A86B);
          var_2._id_3961["bulletPenetrationKill"] = isDefined(var_0._id_A86F);
          var_2._id_3961["cookedKill"] = 0;
        }

        if(isDefined(var_1._id_5BA1) && var_1._id_5BA1 >= gettime() - 50 && var_23)
          var_2._id_3961["suicideGrenadeKill"] = 1;

        if(var_23) {
          var_2._id_3961["cookedKill"] = isDefined(var_0._id_56B8);
          var_2._id_3961["throwbackKill"] = isDefined(var_0._id_999E);
        }
      }

      var_2._id_3961["stickKill"] = isDefined(var_0._id_57E6) && var_0._id_57E6 == "enemy";
      var_2._id_3961["stickFriendlyKill"] = isDefined(var_0._id_57E6) && var_0._id_57E6 == "friendly";

      if(isDefined(var_0) && var_0.classname == "grenade" && !isDefined(var_0.missile_stuck)) {
        var_24 = bulletTrace(var_0.origin, var_0.origin - (0, 0, 100), 0, var_0);

        if(var_0.origin[2] > var_24["position"][2] + 5)
          var_2._id_3961["midAirDetonate"] = 1;
      }

      if(isPlayer(var_1) && var_1 != self)
        maps\mp\gametypes\_gamelogic::_id_86B0(var_0, var_1, var_6);
    }

    if(issubstr(var_5, "MOD_IMPACT") && issubstr(var_6, "gl")) {
      if(isPlayer(var_1) && var_1 != self)
        maps\mp\gametypes\_gamelogic::_id_86B0(var_0, var_1, var_6);
    }

    if(isPlayer(var_1) && isDefined(var_1.pers["participation"]))
      var_1.pers["participation"]++;
    else if(isPlayer(var_1))
      var_1.pers["participation"] = 1;

    if(var_11) {
      if(_func_367()) {
        if(isDefined(var_1._id_4E03) && isDefined(var_2._id_4E03) && common_scripts\utility::_id_0F79(var_1._id_4E03, var_2) && common_scripts\utility::_id_0F79(var_2._id_4E03, var_1) || var_1 == var_2 && isDefined(var_1._id_5729) && var_1._id_5729) {
          if(var_3 < 1)
            var_3 = 1;

          if(isDefined(var_1._id_34D2) && var_1._id_34D2 == var_2) {
            if(var_2.health - var_3 <= 0) {
              var_3 = var_2.health - 1;
              var_2 notify("lostDuel");
            } else
              var_2 notify("updateDuelHealthDisplay");
          }

          var_2 _id_3BAC(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);

          if(isDefined(var_1) && var_1 != var_2 && isDefined(var_9)) {
            if(!maps\mp\_utility::isreallyalive(var_2)) {
              if(maps\mp\_utility::_id_5755(var_5))
                var_25 = "killshot_nosound";
              else if(var_9 == "head")
                var_25 = "killshot_headshot";
              else
                var_25 = "killshot";
            } else if(isDefined(var_16))
              var_25 = var_16;
            else if(maps\mp\_utility::_id_5755(var_5))
              var_25 = "standard_nosound";
            else if(var_9 == "head")
              var_25 = "headshot";
            else if(var_3 < _func_2F9(maps\mp\_utility::_id_4431(var_6)))
              var_25 = "minor";
            else if(!_id_8BB3(var_6))
              var_25 = "none";
            else
              var_25 = "standard";

            var_1 thread _id_04C7::_id_A102(var_25);
          }

          return;
        }
      }

      if(level._id_3EC4 == 0 || !isPlayer(var_1) && level._id_3EC4 != 1 || shouldignorefriendlyfireforhardcore(var_6, var_1)) {
        if(var_6 == "artillery_mp" || var_6 == "airstrike_bomb_mp" || var_6 == "airstrike_bomb_axis_mp" || var_6 == "firebomb_bomb_mp" || var_6 == "firebomb_bomb_axis_mp" || var_6 == "firebomb_bomb_grenadier_mp" || var_6 == "firebomb_bomb_axis_grenadier_mp")
          var_2 _id_29DC(var_0, var_6, var_5, var_3, var_4, var_1);

        return "friendly fire";
      } else if(level._id_3EC4 == 1) {
        if(var_3 < 1)
          var_3 = 1;

        var_2._id_5B8D = 0;
        var_2 _id_3BAC(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
      } else if(level._id_3EC4 == 2 && maps\mp\_utility::isreallyalive(var_1)) {
        var_3 = int(var_3 * 0.5);

        if(var_3 < 1)
          var_3 = 1;

        var_1._id_5B8D = 0;
        var_1._id_3EC1 = 1;
        var_1 _id_3BAC(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
        var_1._id_3EC1 = undefined;
      } else if(level._id_3EC4 == 3 && maps\mp\_utility::isreallyalive(var_1)) {
        var_3 = int(var_3 * 0.5);

        if(var_3 < 1)
          var_3 = 1;

        var_2._id_5B8D = 0;
        var_1._id_5B8D = 0;
        var_2 _id_3BAC(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);

        if(maps\mp\_utility::isreallyalive(var_1)) {
          var_1._id_3EC1 = 1;
          var_1 _id_3BAC(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
          var_1._id_3EC1 = undefined;
        }
      }

      var_21 = 1;
    } else {
      if(var_3 < 1 && !_func_367())
        var_3 = 1;

      if(_func_367() && isDefined(var_1) && isDefined(var_2) && var_1 == var_2 && isDefined(var_1._id_5721) && var_1._id_5721)
        var_3 = 0;

      _id_5E8A(var_2, var_1, var_0, var_6, var_3, var_7, var_8, var_9, var_10, var_5);

      if(issubstr(var_5, "MOD_GRENADE") && isDefined(var_0) && isDefined(var_0._id_56B8))
        var_2._id_A86D = gettime();
      else
        var_2._id_A86D = undefined;

      if(issubstr(var_5, "MOD_IMPACT") && isDefined(var_0) && isDefined(var_0._id_7ACE) && var_0._id_7ACE)
        var_2._id_A876 = 1;
      else
        var_2._id_A876 = 0;

      var_2._id_5B8D = isDefined(var_1) && var_1 != var_2;

      if(var_2._id_5B8D) {
        var_26 = gettime();
        var_1._id_29BD[var_2.guid] = var_26;
        var_2._id_5B8A = var_26;
      }

      var_2 _id_3BAC(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
      var_2 thread maps\mp\gametypes\_missions::_id_73CC(var_0, var_1, var_3, var_5, var_6, var_9);
    }

    if(!maps\mp\_utility::isreallyalive(var_2)) {
      if((issubstr(var_5, "MOD_GRENADE") || issubstr(var_5, "MOD_EXPLOSIVE") || issubstr(var_5, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1))
        var_2 _id_04EB::_id_2E43(var_8);

      if(isDefined(var_2._id_5B8D) && var_2._id_5B8D)
        level notify("normal_enemy_kill");
    }

    if(var_20 && isDefined(var_1._id_48EA))
      var_27 = var_1._id_48EA;
    else
      var_27 = var_1;

    var_28 = undefined;

    if(isDefined(var_27))
      var_28 = var_27 _meth_85E2();

    if(isDefined(var_27) && (var_27 != var_2 || maps\mp\_utility::iskillstreakweapon(var_6)) && var_3 > 0 && (!isDefined(var_9) || var_9 != "shield")) {
      if(!maps\mp\_utility::isreallyalive(var_2) || _func_1EF(var_2) && isDefined(var_2._id_0A4B) && var_2._id_0A4B == "paratroopers" && var_2.health - var_3 <= 0) {
        if(maps\mp\_utility::_id_5755(var_5))
          var_25 = "killshot_nosound";
        else if(isDefined(var_6) && issubstr(var_6, "throwingknife_mp"))
          var_25 = "throwingknife";
        else if(var_9 == "head")
          var_25 = "killshot_headshot";
        else
          var_25 = "killshot";
      } else if(isDefined(var_16))
        var_25 = var_16;
      else if(level.gametype == "br")
        var_25 = "hitmorehealth";
      else if(common_scripts\utility::_id_562E(var_2._id_4B97))
        var_25 = "hitlightarmor";
      else if(maps\mp\_utility::_id_5755(var_5))
        var_25 = "standard_nosound";
      else if(var_4 &level.idflags_shield_explosive_impact)
        var_25 = "stun";
      else if(maps\mp\_utility::isbulletdamage(var_5) && var_2 maps\mp\_utility::_hasperk("specialty_armorvest"))
        var_25 = "hitjuggernaut";
      else if(maps\mp\_utility::isbulletdamage(var_5) && isDefined(var_2._id_4B9A) && var_2._id_4B9A)
        var_25 = "hitjuggernaut";
      else if(_func_17B(var_5) && isDefined(var_2._id_4B64) && var_2._id_4B64)
        var_25 = "hitlightarmor";
      else if(_id_0513::_id_57F6(var_6) && var_2 maps\mp\_utility::_hasperk("specialty_stun_resistance"))
        var_25 = "hittacticalmask";
      else if(_func_17B(var_5) && var_2 maps\mp\_utility::_hasperk("specialty_blastshield2") && !_id_0513::_id_57F6(var_6) && !_id_052D::_id_3154(var_6))
        var_25 = "hitblastshield";
      else if(maps\mp\_utility::_id_5697(var_5) && var_2 maps\mp\_utility::_hasperk("specialty_fireshield"))
        var_25 = "hitfireshield";
      else if(isDefined(var_2.raidmaniac) && var_2.raidmaniac || isDefined(var_2.raidcombatbuff) && var_2.raidcombatbuff)
        var_25 = "hitlightarmor";
      else if(var_9 == "head")
        var_25 = "headshot";
      else if(var_17 && var_5 != "MOD_HEAD_SHOT" && !maps\mp\_utility::_id_56F8(var_6, var_5, var_1))
        var_25 = "hitlightarmor";
      else if(var_3 < _func_2F9(maps\mp\_utility::_id_4431(var_6)))
        var_25 = "minor";
      else if(!_id_8BB3(var_6))
        var_25 = "none";
      else
        var_25 = "standard";

      if(!isDefined(var_28) || isDefined(var_28) && var_28 _meth_8564() != "plane")
        var_27 thread _id_04C7::_id_A102(var_25);
    }

    maps\mp\gametypes\_gamelogic::_id_869D(var_2, 1);
  }

  if(isDefined(var_1) && var_1 != var_2 && !var_21)
    level._id_A239 = 0;

  var_29 = var_2 getentitynumber();
  var_30 = var_2.name;
  var_31 = var_2.pers["team"];
  var_32 = var_2.guid;
  var_33 = "";

  if(isPlayer(var_1)) {
    var_34 = var_1 getentitynumber();
    var_35 = var_1.guid;
    var_36 = var_1.name;
    var_33 = var_1.pers["team"];
  } else {
    var_34 = -1;
    var_35 = "";
    var_36 = "";
    var_33 = "world";
  }

  if(isPlayer(var_1)) {
    var_37 = var_1.name;
    var_38 = var_1.origin;

    if(isDefined(var_0) && isDefined(var_0._id_5CC6) && var_0._id_5CC6 != -1)
      var_39 = var_0._id_5CC6;
    else
      var_39 = var_1._id_5CC6;
  } else {
    var_37 = "world";
    var_38 = var_2.origin;
    var_39 = -1;
  }

  var_40 = gettime();

  if(var_2.sessionstate != "dead") {
    if(!_func_1EF(var_2) && var_5 != "MOD_FALLING" && var_5 != "MOD_SUICIDE" && (!isDefined(var_1) || var_1 != var_2)) {
      var_41 = (var_40 - level._id_5CC7[var_2._id_5CC6]) / 1000.0;

      if(var_2._id_90AE < 0)
        var_2._id_90AE = var_41;

      if(var_41 <= 3.0 && isDefined(var_2._id_9070) && var_2._id_9070._id_29D9 == 0) {
        if(isDefined(var_2.pers["immediateActionSpawnCount"]))
          var_2.pers["immediateActionSpawnCount"]++;

        if(isDefined(var_1) && isDefined(var_1.pers) && isDefined(var_1.pers["causedImmediateActionSpawnCount"]))
          var_1.pers["causedImmediateActionSpawnCount"]++;

        if(!isDefined(level._id_6026))
          level._id_6026 = [];

        if(!isDefined(game["trapSpawnDmgReceivedCount"]))
          game["trapSpawnDmgReceivedCount"] = 1;
        else
          game["trapSpawnDmgReceivedCount"]++;

        var_2._id_9070._id_29D9 = 1;

        if(var_2._id_9070._id_9CFD == 0) {
          if(!isDefined(game["trapSpawnByAnyMeansCount"]))
            game["trapSpawnByAnyMeansCount"] = 1;
          else
            game["trapSpawnByAnyMeansCount"]++;

          if(isDefined(var_2.pers["badSpawnByAnyMeansCount"]))
            var_2.pers["badSpawnByAnyMeansCount"]++;

          if(isDefined(var_1) && isDefined(var_1.pers) && isDefined(var_1.pers["causedBadSpawnByAnyMeansCount"]))
            var_1.pers["causedBadSpawnByAnyMeansCount"]++;

          var_2._id_9070._id_9CFD = 1;
        }
      }
    } else
      var_41 = -1;

    if(isDefined(var_1) && isPlayer(var_1) && var_5 != "MOD_FALLING" && var_5 != "MOD_SUICIDE" && (!isDefined(var_2) || var_1 != var_2)) {
      var_42 = (var_40 - level._id_5CC7[var_39]) / 1000.0;

      if(var_1._id_90AD < 0)
        var_1._id_90AD = var_42;

      if(var_42 <= 3.0 && var_1._id_9070._id_29BA == 0) {
        if(isDefined(var_1) && isDefined(var_1.pers["immediateActionSpawnCount"]))
          var_1.pers["immediateActionSpawnCount"]++;

        if(!isDefined(level._id_6026))
          level._id_6026 = [];

        if(!isDefined(game["trapSpawnDmgDealtCount"]))
          game["trapSpawnDmgDealtCount"] = 1;
        else
          game["trapSpawnDmgDealtCount"]++;

        var_1._id_9070._id_29BA = 1;

        if(var_1._id_9070._id_9CFD == 0) {
          if(!isDefined(game["trapSpawnByAnyMeansCount"]))
            game["trapSpawnByAnyMeansCount"] = 1;
          else
            game["trapSpawnByAnyMeansCount"]++;

          if(isDefined(var_1) && isDefined(var_1.pers["badSpawnByAnyMeansCount"]))
            var_1.pers["badSpawnByAnyMeansCount"]++;

          var_1._id_9070._id_9CFD = 1;
        }
      }
    } else
      var_42 = -1;

    if(!_func_1EF(var_2)) {
      _func_0F6(var_2.origin, "script_mp_damage: player_name %s, player_angles %v, hit_loc %s, attacker_name %s, attacker_pos %v, damage %d, weapon %s, damage_type %s, gameTime %d, life_id %d, attacker_life_id %d, spawnToDamageReceivedTime %f, spawnToDamageDealtTime %f", var_2.name, var_2.angles, var_9, var_37, var_38, var_3, var_6, var_5, var_40, var_2._id_5CC6, var_39, var_41, var_42);

      if(isDefined(level._id_73CD))
        [[level._id_73CD]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }

    _func_15A("D;" + var_32 + ";" + var_29 + ";" + var_31 + ";" + var_30 + ";" + var_35 + ";" + var_34 + ";" + var_33 + ";" + var_36 + ";" + var_6 + ";" + var_3 + ";" + var_5 + ";" + var_9 + "\n");
  } else {
    if(!_func_1EF(var_2) && var_2._id_90AE < 0) {
      if(isDefined(level._id_5CC7[var_2._id_5CC6])) {
        var_41 = (var_40 - level._id_5CC7[var_2._id_5CC6]) / 1000.0;
        var_2._id_90AE = var_41;
      }
    }

    if(isDefined(var_1) && isPlayer(var_1) && var_1._id_90AD < 0) {
      if(isDefined(level._id_5CC7[var_39])) {
        var_42 = (var_40 - level._id_5CC7[var_39]) / 1000.0;
        var_1._id_90AD = var_42;
      }
    }
  }

  _id_4DD9(var_1, var_2, var_3, var_9, var_4);

  if(_func_1EF(self))
    self[[maps\mp\agents\_agent_utility::_id_0A59("on_damaged_finished")]](var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, "");

  return "finished";
}

_id_118E(var_0, var_1) {
  var_2 = !isDefined(var_0) || var_0 getentitynumber() == _func_15B();
  var_3 = maps\mp\_utility::iskillstreakweapon(var_1);

  if(var_2 && var_3)
    return 1;

  return 0;
}

_id_8BB3(var_0) {
  switch (var_0) {
    case "firebomb_bomb_axis_grenadier_mp":
    case "firebomb_bomb_grenadier_mp":
    case "firebomb_bomb_axis_mp":
    case "firebomb_bomb_mp":
    case "airstrike_bomb_axis_mp":
    case "airstrike_bomb_mp":
    case "artillery_mp":
      return 0;
  }

  return 1;
}

shouldignorefriendlyfireforhardcore(var_0, var_1) {
  if(!level.hardcoremode)
    return 0;

  if(getdvarint("scr_hardcore_StreaksTeamKill", 0) != 0)
    return 0;

  if(_func_1EF(var_1) && isDefined(var_1._id_0A4B) && var_1._id_0A4B == "paratroopers")
    return 1;

  if(!isDefined(var_0) || !maps\mp\_utility::iskillstreakweapon(var_0))
    return 0;

  switch (var_0) {
    case "firebomb_flames_mp":
    case "firebomb_bomb_axis_grenadier_mp":
    case "firebomb_bomb_grenadier_mp":
    case "firebomb_bomb_axis_mp":
    case "firebomb_bomb_mp":
    case "airstrike_bomb_axis_mp":
    case "airstrike_bomb_mp":
    case "missile_strike_projectile_axis_mp":
    case "missile_strike_projectile_mp":
    case "mortar_strike_projectile_axis_mp":
    case "mortar_strike_projectile_mp":
    case "azon_projectile_mp":
    case "fritzx_projectile_mp":
    case "artillery_mp":
      return 1;
  }

  return 0;
}

_id_099A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0._id_1189))
    var_0._id_1189 = [];

  if(!isDefined(var_0._id_1189[var_1.guid])) {
    var_0._id_1193[var_1.guid] = var_1;
    var_0._id_1189[var_1.guid] = spawnStruct();
    var_0._id_1189[var_1.guid]._id_2994 = 0;
    var_0._id_1189[var_1.guid]._id_118A = var_1;
    var_0._id_1189[var_1.guid]._id_3C71 = gettime();
    var_0._id_1189[var_1.guid]._id_A9DF = [];
    var_0._id_1189[var_1.guid]._id_4DD5 = 1;
    var_0._id_1189[var_1.guid]._id_4DE6 = [];
    var_0._id_1189[var_1.guid]._id_4DD6 = [];
    var_10 = anglesToForward((0, var_0.angles[1], 0));
    var_11 = var_0.origin - var_1.origin;
    var_11 = vectorNormalize((var_11[0], var_11[1], 0));
    var_12 = vectordot(var_10, var_11);
    var_13 = var_12 * -1;
    var_14 = 0;

    if(var_13 >= _func_0A7(getdvarint("cg_fov", 65)))
      var_14 = 1;

    if(var_9 == "MOD_EXPLOSIVE" || var_9 == "MOD_GRENADE" || var_9 == "MOD_GRENADE_SPLASH" || var_9 == "MOD_PROJECTILE_SPLASH" || var_9 == "MOD_PROJECTILE" || var_9 == "MOD_MELEE" || var_9 == "MOD_MELEE_ALT" || var_9 == "MOD_MELEE_DOG" || maps\mp\_utility::_id_5697(var_9, var_3) || var_9 == "MOD_SUICIDE" || var_9 == "MOD_IMPACT" || var_9 == "MOD_TRIGGER_HURT" || var_9 == "MOD_FALLING" || var_9 == "MOD_CRUSH" || isDefined(level._id_5A7D) && isDefined(level._id_5A7D[var_3]))
      var_14 = -1;

    var_0._id_1189[var_1.guid]._id_3C67 = var_14;
  } else
    var_0._id_1189[var_1.guid]._id_4DD5++;

  if(_id_0513::_id_5795(var_3) && !_id_0513::_id_57CD(var_3))
    var_0._id_1189[var_1.guid]._id_5792 = 1;

  if(!isDefined(var_0._id_1189[var_1.guid]._id_A9DF[var_3]))
    var_0._id_1189[var_1.guid]._id_A9DF[var_3] = var_3;

  var_15 = var_0._id_1189[var_1.guid]._id_4DD5;
  var_0._id_1189[var_1.guid]._id_2994 = var_0._id_1189[var_1.guid]._id_2994 + var_4;
  var_0._id_1189[var_1.guid]._id_01D0 = var_3;
  var_0._id_1189[var_1.guid]._id_A62D = var_5;
  var_0._id_1189[var_1.guid]._id_A2B1 = var_6;
  var_0._id_1189[var_1.guid]._id_8B0A = var_7;
  var_0._id_1189[var_1.guid]._id_014A = var_8;
  var_0._id_1189[var_1.guid]._id_8CD7 = var_9;
  var_0._id_1189[var_1.guid]._id_118A = var_1;
  var_0._id_1189[var_1.guid]._id_5C08 = gettime();
  var_0._id_1189[var_1.guid]._id_4DE6[var_15 - 1] = var_3;
  var_0._id_1189[var_1.guid]._id_4DD6[var_15 - 1] = var_4;

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.primaryweapon))
    var_0._id_1189[var_1.guid]._id_912F = var_2.primaryweapon;
  else if(isDefined(var_1) && isPlayer(var_1) && var_1 _meth_8317() != "none")
    var_0._id_1189[var_1.guid]._id_912F = var_1 _meth_8317();
  else
    var_0._id_1189[var_1.guid]._id_912F = undefined;

  if(!isDefined(var_1._id_A491))
    var_1._id_A491 = [];

  if(!isDefined(var_1._id_A491[var_0.guid]))
    var_1._id_A495[var_0.guid] = var_0;

  var_1._id_A491[var_0.guid] = var_0._id_1189[var_1.guid];
  var_1._id_A491[var_0.guid]._id_A492 = var_0;
  var_1._id_A491[var_0.guid]._id_A493 = var_0._id_5CC6;

  if(!isDefined(var_1._id_29B9))
    var_1._id_29B9 = 0;

  if(!isDefined(var_0._id_29DA))
    var_0._id_29DA = 0;

  var_1._id_29B9 = var_1._id_29B9 + var_4;
  var_0._id_29DA = var_0._id_29DA + var_4;
}

_id_7D51() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 1.75;
  self._id_1193 = [];
  self._id_1189 = [];
}

_id_5E8A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1))
    _id_099A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1._id_0117) && (!isDefined(var_1._id_80D7) || !var_1._id_80D7))
    _id_099A(var_0, var_1._id_0117, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1._id_835E) && isDefined(var_1._id_80D7) && var_1._id_80D7)
    _id_099A(var_0, var_1._id_835E, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(isDefined(var_2) && isDefined(var_2._id_0117) && isDefined(var_2._id_0117.guid)) {
    var_10 = var_2._id_0117.team != var_0.team || level._id_3EC4 == 1;

    if(var_10 && !isDefined(self._id_1189[var_2._id_0117.guid]))
      _id_099A(var_0, var_2._id_0117, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_1))
    level._id_5BB7 = var_1;

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3))
    var_1 thread _id_0513::_id_21C6(var_3, var_9, var_0);

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3) && var_1 != var_0)
    var_0._id_1192 = var_1.origin;
  else
    var_0._id_1192 = undefined;
}

_id_A106(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_6, var_4 in var_0) {
      if(!isPlayer(var_4)) {
        continue;
      }
      var_5 = var_4 getentitynumber();
      self _meth_82FF("ui_death_details_attacker_" + var_2, var_5);
      self _meth_82FF("ui_death_details_hits_" + var_2, int(_func_0AF(var_1[var_6]._id_4DD5, 10)));
      var_2++;

      if(var_2 >= 4) {
        break;
      }
    }
  }

  for(var_7 = var_2; var_7 < 4; var_7++)
    self _meth_82FF("ui_death_details_attacker_" + var_7, -1);
}

callback_entityoutofworld(var_0, var_1) {
  if(!isDefined(self) || !_func_388(self)) {
    return;
  }
  if(!isDefined(var_0) || !_func_389(var_0)) {
    return;
  }
  var_1 = maps\mp\_utility::_id_073C(var_1);

  if(!isDefined(var_1)) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_0._id_5D9F) && !self _meth_81E0()) {
    if(isDefined(var_0.team) && isDefined(var_1.team) && var_0.team != var_1.team)
      self notify("force_start_ragdoll");
  }
}

callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = _id_1E69(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_3BAC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(level._id_6B77))
    self[[level._id_6B77]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  var_11 = 0;

  if(maps\mp\_utility::isusingremote() && var_2 >= self.health && !(var_3 &level.idflags_shield_explosive_impact) && !isDefined(self._id_5379) && !self _meth_8527())
    var_11 = 1;

  if(var_11 || maps\mp\_utility::_id_57B0()) {
    if(!isDefined(var_7))
      var_7 = (0, 0, 0);

    if(!isDefined(var_1) && !isDefined(var_0)) {
      var_1 = self;
      var_0 = var_1;
    }

    playerkilled_internal(var_0, var_1, self, var_2, var_4, var_5, var_7, var_8, var_9, 0, 1);
  } else {
    if(!_id_1E66(var_0, var_1, var_2 - var_2 * var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    if(isPlayer(self)) {
      var_12 = self _meth_8265(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

      if(isDefined(var_12)) {
        if(var_4 != "MOD_FALLING")
          self _meth_82FF("ui_damage_flash", 1);

        if(!common_scripts\utility::_id_562E(level.disableplayerdamageimpactfx))
          thread _id_3BAB(var_12[0], var_12[1], var_12[2], var_12[3], var_12[4], var_12[5], var_12[6]);
      }
    }
  }

  if(var_4 == "MOD_EXPLOSIVE_BULLET")
    self _meth_8182("damage_mp", getdvarfloat("scr_csmode"));

  _id_29DC(var_0, var_5, var_4, var_2, var_3, var_1);
}

_id_3BAB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  waittillframeend;

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  self _meth_853A(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

callback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9._id_35A9 = var_0;
  var_9._id_1180 = var_1;
  var_9._id_502C = var_2;
  var_9._id_1192 = var_1.origin;

  if(var_1 == self)
    var_9._id_8CD7 = "MOD_SUICIDE";
  else
    var_9._id_8CD7 = var_3;

  var_9._id_953E = var_4;

  if(isDefined(var_1) && isPlayer(var_1) && var_1 _meth_8317() != "none")
    var_9._id_912F = var_1 _meth_8317();
  else
    var_9._id_912F = undefined;

  var_9._id_A2B1 = var_5;
  var_9._id_8B0A = var_6;
  var_9._id_5BF4 = gettime();
  var_10 = _id_60AC(var_4, var_3, var_6);

  if(isDefined(self._id_36B9))
    var_10 = 0;

  if(level.teambased && isDefined(var_1.team) && var_1.team == self.team)
    var_10 = 0;

  if(level._id_2EF3) {
    if(level.teamcount[self.team] <= 1)
      var_10 = 0;
    else if(maps\mp\_utility::_id_57FF()) {
      var_10 = 0;
      maps\mp\_utility::_id_5A7F(self.team);
    }
  }

  if(!var_10) {
    self._id_5BEF = var_9;
    self._id_A219 = 1;
    maps\mp\_utility::_suicide();
  } else {
    self._id_5378 = 1;
    var_11 = spawnStruct();

    if(maps\mp\_utility::_hasperk("specialty_finalstand")) {
      var_11.titletext = game["strings"]["final_stand"];
      var_11.iconname = level._id_90D7;
    } else {
      var_11.titletext = game["strings"]["last_stand"];
      var_11.iconname = level._id_90D7;
    }

    var_11.glowcolor = (1, 0, 0);
    var_11.sound = "mp_last_stand";
    var_11.duration = 2.0;
    self.health = 1;
    thread maps\mp\gametypes\_hud_message::notifymessage(var_11);
    var_12 = "frag_grenade_mp";

    if(maps\mp\_utility::_hasperk("specialty_finalstand")) {
      self._id_5BEF = var_9;
      self._id_5133 = 1;
      var_13 = self _meth_82D3();

      foreach(var_15 in var_13)
      self takeweapon(var_15);

      common_scripts\utility::_id_0601();
      thread _id_365B();
      thread _id_5BF5(20, 1);
    } else {
      if(level._id_2EF3) {
        var_1 thread _id_047A::_id_5A41(self, var_4, var_3);
        self._id_5BEF = var_9;
        common_scripts\utility::_id_0602();
        thread _id_5BF5(20, 0);
        common_scripts\utility::_id_0601();
        return;
      }

      self._id_5BEF = var_9;
      var_17 = undefined;
      var_18 = self getweaponlistprimaries();

      foreach(var_15 in var_18) {
        if(_id_0513::_id_57CD(var_15) && var_15 != "combatknife_mp")
          var_17 = var_15;
      }

      if(!isDefined(var_17)) {
        var_17 = "m1911_mp";
        maps\mp\_utility::_giveweapon(var_17);
      }

      self givemaxammo(var_17);
      self _meth_8326();
      common_scripts\utility::_id_0601();

      if(!maps\mp\_utility::_hasperk("specialty_laststandoffhand"))
        self _meth_8324();

      self switchtoweapon(var_17);
      thread _id_5BF5(10, 0);
    }
  }
}

_id_2EEF(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  wait(var_0);
  self._id_A219 = 1;
  maps\mp\_utility::_suicide();
}

_id_2E69() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self waittill("detonate");
  self._id_A219 = 1;
  _id_1DF2();
}

_id_2E68() {
  self endon("detonate");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self waittill("death");
  _id_1DF2();
}

_id_1DF2() {
  self playSound("detpack_explo_default");
  self._id_1DF3 = playFX(level._id_1DF1, self.origin);
  radiusdamage(self.origin, 312, 100, 100, self);

  if(isalive(self))
    maps\mp\_utility::_suicide();
}

_id_365B() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::freezecontrolswrapper(1);
  wait 0.3;
  maps\mp\_utility::freezecontrolswrapper(0);
}

_id_5BF5(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  self notify("player_last_stand");
  thread _id_5BFB();
  self._id_00E8 = 1;

  if(!var_1 && (!isDefined(self._id_50DC) || !self._id_50DC) && (!isDefined(var_2) || !var_2)) {
    thread _id_5BE8();
    maps\mp\_utility::_id_86C3("last_stand", &"PLATFORM_COWARDS_WAY_OUT", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    thread _id_5BEC();
  }

  if(level._id_2EF3 == 1 && level._id_2EF3 != 2 && (!isDefined(var_2) || !var_2)) {
    var_3 = spawn("script_model", self.origin);
    var_3 setModel("tag_origin");
    var_3 _meth_80CD("HINT_NOICON");
    var_3 _meth_80CE(&"PLATFORM_REVIVE");
    var_3 _id_7E61(self);
    var_3 endon("death");
    var_4 = _func_19C(self.team);
    var_4 setshader("waypoint_revive", 8, 8);
    var_4 _meth_80CB(1, 1);
    var_4 _meth_80C0(self);
    var_4 thread _id_2DD6(var_3);
    var_4.color = (0.33, 0.75, 0.24);
    maps\mp\_utility::_id_7210();

    if(var_1) {
      wait(var_0);

      if(self._id_5133)
        thread _id_5BEA(var_1, var_3);
    }

    return;
  } else if(level._id_2EF3 == 2 && (!isDefined(var_2) || !var_2)) {
    thread _id_5BEC();
    var_3 = spawn("script_model", self.origin);
    var_3 setModel("tag_origin");
    var_3 _meth_80CD("HINT_NOICON");
    var_3 _meth_80CE(&"PLATFORM_REVIVE");
    var_3 _id_7E61(self);
    var_3 endon("death");
    var_4 = _func_19C(self.team);
    var_4 setshader("waypoint_revive", 8, 8);
    var_4 _meth_80CB(1, 1);
    var_4 _meth_80C0(self);
    var_4 thread _id_2DD6(var_3);
    var_4.color = (0.33, 0.75, 0.24);
    maps\mp\_utility::_id_7210();

    if(var_1) {
      wait(var_0);

      if(self._id_5133)
        thread _id_5BEA(var_1, var_3);
    }

    wait(var_0 / 3);
    var_4.color = (1, 0.64, 0);

    while(var_3._id_54F5)
      waitframe();

    maps\mp\_utility::_id_7210();
    wait(var_0 / 3);
    var_4.color = (1, 0, 0);

    while(var_3._id_54F5)
      waitframe();

    maps\mp\_utility::_id_7210();
    wait(var_0 / 3);

    while(var_3._id_54F5)
      waitframe();

    waitframe();
    thread _id_5BEA(var_1);
    return;
  }

  if(!isDefined(var_2) || !var_2)
    thread _id_5BEC();

  wait(var_0);
  thread _id_5BEA(var_1);
}

_id_6086(var_0, var_1) {
  self endon("stop_maxHealthOverlay");
  self endon("revive");
  self endon("death");

  for(;;) {
    self.health = self.health - 1;
    self.maxhealth = var_0;
    waitframe();
    self.maxhealth = 50;
    self.health = self.health + 1;
    wait 0.5;
  }
}

_id_5BEA(var_0, var_1) {
  if(var_0) {
    self._id_00E8 = undefined;
    self._id_5133 = 0;
    self notify("revive");
    maps\mp\_utility::_id_2401("last_stand");
    maps\mp\gametypes\_playerlogic::_id_5BF0();

    if(isDefined(var_1))
      var_1 delete();
  } else {
    self._id_A219 = 1;
    self._id_172C = 0;
    maps\mp\_utility::_suicide();
  }
}

_id_5BE8() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("revive");

  for(;;) {
    if(self _meth_8341()) {
      var_0 = gettime();

      while(self _meth_8341()) {
        waitframe();

        if(gettime() - var_0 > 700) {
          break;
        }
      }

      if(gettime() - var_0 > 700) {
        break;
      }
    }

    waitframe();
  }

  thread _id_5BEA(0);
}

_id_5BEC() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("revive");

  while(!level.gameended) {
    self.health = 2;
    waitframe();
    self.health = 1;
    wait 0.5;
  }

  self.health = self.maxhealth;
}

_id_5BFB() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");
  maps\mp\_utility::_id_2401("last_stand");
  self._id_00E8 = undefined;
}

_id_60AC(var_0, var_1, var_2) {
  if(var_1 == "MOD_TRIGGER_HURT")
    return 0;

  if(var_1 != "MOD_PISTOL_BULLET" && var_1 != "MOD_RIFLE_BULLET" && var_1 != "MOD_FALLING" && var_1 != "MOD_EXPLOSIVE_BULLET")
    return 0;

  if(var_1 == "MOD_IMPACT" && (var_0 == "throwingknife_mp" || var_0 == "throwingknifejugg_mp"))
    return 0;

  if(var_1 == "MOD_IMPACT" && (var_0 == "m79_mp" || issubstr(var_0, "gl_")))
    return 0;

  if(maps\mp\_utility::_id_570A(var_0, var_2, var_1))
    return 0;

  if(maps\mp\_utility::isusingremote())
    return 0;

  return 1;
}

_id_378E() {
  if(!isDefined(self._id_5BEF._id_1180))
    self._id_5BEF._id_1180 = self;
}

_id_450E(var_0) {
  switch (var_0) {
    case "neck":
    case "helmet":
    case "head":
      return 60;
    case "torso_upper":
    case "left_hand":
    case "left_arm_lower":
    case "left_arm_upper":
    case "right_arm_lower":
    case "right_hand":
    case "right_arm_upper":
    case "gun":
      return 48;
    case "torso_lower":
      return 40;
    case "left_leg_upper":
    case "right_leg_upper":
      return 32;
    case "left_leg_lower":
    case "right_leg_lower":
      return 10;
    case "left_foot":
    case "right_foot":
      return 5;
  }

  return 48;
}

_id_450F(var_0) {
  switch (var_0) {
    case "helmet":
      return "j_neck";
    case "head":
      return "j_neck";
    case "neck":
      return "j_neck";
    case "torso_upper":
      return "j_neck";
    case "right_arm_upper":
      return "J_Shoulder_RI";
    case "left_arm_upper":
      return "J_Shoulder_LE";
    case "right_arm_lower":
      return "J_Elbow_RI";
    case "left_arm_lower":
      return "J_Elbow_LE";
    case "right_hand":
      return "J_Wrist_RI";
    case "left_hand":
      return "J_Wrist_LE";
    case "gun":
      return "J_Wrist_RI";
    case "torso_lower":
      return "J_SpineLower";
    case "right_leg_upper":
      return "J_Hip_RI";
    case "left_leg_upper":
      return "J_Hip_LE";
    case "right_leg_lower":
      return "J_Knee_RI";
    case "left_leg_lower":
      return "J_Knee_LE";
    case "right_foot":
      return "J_Ankle_RI";
    case "left_foot":
      return "J_Ankle_LE";
  }

  return undefined;
}

_id_2CEC(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = var_0 _meth_801E();

    if(_func_066(var_6, "ignore_ragdoll"))
      return;
  }

  if(isDefined(level._id_6738) && level._id_6738.size) {
    foreach(var_8 in level._id_6738) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536)
        return;
    }
  }

  wait 0.2;

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 _meth_81E0()) {
    return;
  }
  var_6 = var_0 _meth_801E();
  var_10 = 0.35;

  if(_func_066(var_6, "start_ragdoll")) {
    var_11 = _func_067(var_6, "start_ragdoll");

    if(isDefined(var_11))
      var_10 = var_11[0];
  }

  var_12 = var_0 _meth_801F();
  var_13 = clamp(var_10 - var_12, 0, 1);
  var_14 = var_13 * _func_065(var_6);

  if(var_14 > 0)
    var_0 common_scripts\utility::waittill_notify_or_timeout("force_start_ragdoll", var_14);

  if(isDefined(var_0))
    var_0 _meth_8028();
}

_id_4594() {
  var_0 = "";
  var_1 = 0;
  var_2 = getarraykeys(self._id_5A3C);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(self._id_5A3C[var_4] <= var_1) {
      continue;
    }
    var_1 = self._id_5A3C[var_4];
    var_5 = var_4;
  }

  return var_0;
}

_id_4593() {
  var_0 = "";
  var_1 = 0;
  var_2 = getarraykeys(self._id_5A42);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(self._id_5A42[var_4] <= var_1) {
      continue;
    }
    var_1 = self._id_5A42[var_4];
    var_0 = var_4;
  }

  return var_0;
}

_id_29DC(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_0513::_id_6BCD(var_0, var_1, var_2, var_3, var_5);
  var_6 = gettime();

  if(!isDefined(self._id_5B8C) || var_6 > self._id_5B8C) {
    self._id_5B8C = var_6;
    self _meth_809F("damage_heavy");
  }
}

_id_7E61(var_0) {
  var_1 = var_0.team;
  self _meth_8055(var_0, "tag_origin");
  self._id_0117 = var_0;
  self._id_54F5 = 0;
  self makeusable();
  _id_A18E(var_1);
  thread _id_9BCC(var_1);
  thread _id_7E64(var_1);
  thread _id_2D44();
}

_id_2D44() {
  self endon("death");
  self._id_0117 common_scripts\utility::_id_A70A("death", "disconnect");
  self delete();
}

_id_A18E(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2.team && var_2 != self._id_0117) {
      self enableplayeruse(var_2);
      continue;
    }

    self disableplayeruse(var_2);
  }
}

_id_9BCC(var_0) {
  self endon("death");

  for(;;) {
    level waittill("joined_team");
    _id_A18E(var_0);
  }
}

_id_9BBF(var_0) {
  self endon("death");

  for(;;) {
    level waittill("player_last_stand");
    _id_A18E(var_0);
  }
}

_id_7E64(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);
    self._id_0117._id_172C = 1;

    if(isDefined(var_1._id_172C) && var_1._id_172C) {
      self._id_0117._id_172C = 0;
      continue;
    }

    self _meth_80B3();
    self._id_0117 maps\mp\_utility::freezecontrolswrapper(1);
    var_2 = _id_7E5A(var_1);
    self._id_0117._id_172C = 0;

    if(!isalive(self._id_0117)) {
      self delete();
      return;
    }

    self._id_0117 maps\mp\_utility::freezecontrolswrapper(0);

    if(var_2) {
      level thread maps\mp\gametypes\_rank::_id_1457("reviver", var_1);
      self._id_0117._id_00E8 = undefined;
      self._id_0117 maps\mp\_utility::_id_2401("last_stand");
      self._id_0117 common_scripts\utility::_id_0616();
      self._id_0117.maxhealth = 100;
      self._id_0117 _id_0513::_id_A13B();
      self._id_0117 maps\mp\gametypes\_playerlogic::_id_5BF0();
      self._id_0117 maps\mp\_utility::giveperk("specialty_pistoldeath");
      self._id_0117._id_172C = 0;
      self delete();
      return;
    }

    self makeusable();
    _id_A18E(var_0);
  }
}

_id_7E5A(var_0, var_1, var_2, var_3) {
  var_4 = 3000;
  var_5 = spawn("script_origin", self.origin);
  var_5 _meth_805C();

  if(isDefined(level.additional_revive_spot_handling_func))
    var_5 = [[level.additional_revive_spot_handling_func]](var_5, var_0);

  if(isPlayer(var_0))
    var_0 _meth_8077(var_5);
  else
    var_0 _meth_8055(var_5);

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2)
    var_0 common_scripts\utility::_id_0602();

  self._id_28D5 = 0;
  self._id_54F5 = 1;
  self._id_A22B = 0;

  if(isDefined(var_1))
    self._id_A23F = var_1;
  else
    self._id_A23F = var_4;

  var_0 thread _id_6F82(self);
  thread _id_7E5B(var_0, var_2, var_5);
  var_6 = _id_7E5C(var_0);
  self._id_54F5 = 0;

  if(!common_scripts\utility::_id_562E(var_5.dontdeleterevivespot))
    var_5 delete();

  if(isDefined(var_6) && var_6) {
    self._id_0117 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived", var_0);
    self._id_0117._id_5378 = 0;
    return 1;
  }

  if(maps\mp\_utility::_id_585F()) {
    var_0._id_39E3++;

    if(isDefined(var_0._id_00E8) && var_0._id_00E8)
      var_0._id_39E5++;

    return 0;
  }
}

_id_7E5B(var_0, var_1, var_2) {
  common_scripts\utility::_id_A70C(self, "death", var_2, "death");

  if(isDefined(level.additional_on_revive_end_func)) {
    [[level.additional_on_revive_end_func]](var_0, var_1, var_2);
    return;
  }

  if(!_func_279(var_2))
    var_2 delete();

  if(isDefined(var_0) && maps\mp\_utility::isreallyalive(var_0)) {
    var_0 _meth_8057();

    if(var_1)
      var_0 common_scripts\utility::_id_0616();
  }
}

_id_6F82(var_0) {
  self _meth_82FF("ui_use_bar_text", 3);
  self _meth_82FF("ui_use_bar_start_time", int(gettime()));
  var_1 = undefined;

  if(isDefined(var_0) && isDefined(var_0._id_0117)) {
    var_1 = var_0._id_0117;
    var_1 _meth_82FF("ui_use_bar_text", 4);
    var_1 _meth_82FF("ui_use_bar_start_time", int(gettime()));
  }

  var_2 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0._id_54F5 && !level.gameended && isDefined(self)) {
    var_3 = int(gettime());
    self _meth_82FF("ui_use_bar_current_time", var_3);

    if(isDefined(var_1))
      var_1 _meth_82FF("ui_use_bar_current_time", var_3);

    if(var_2 != var_0._id_A22B) {
      if(var_0._id_28D5 > var_0._id_A23F)
        var_0._id_28D5 = var_0._id_A23F;

      if(var_0._id_A22B > 0) {
        var_4 = gettime();
        var_5 = var_0._id_28D5 / var_0._id_A23F;
        var_6 = var_4 + (1 - var_5) * (var_0._id_A23F / var_0._id_A22B);
        self _meth_82FF("ui_use_bar_end_time", int(var_6));

        if(isDefined(var_1))
          var_1 _meth_82FF("ui_use_bar_end_time", int(var_6));
      }

      var_2 = var_0._id_A22B;
    }

    waitframe();
  }

  if(isDefined(self))
    self _meth_82FF("ui_use_bar_end_time", 0);

  if(isDefined(var_1))
    var_1 _meth_82FF("ui_use_bar_end_time", 0);
}

_id_6F83(var_0, var_1) {
  var_2 = maps\mp\gametypes\_hud_util::_id_2821();
  var_3 = maps\mp\gametypes\_hud_util::_id_2822();
  var_3 settext(&"MPUI_REVIVING");

  if(isDefined(var_1))
    var_3 settext(var_1);

  var_4 = var_0._id_0117 maps\mp\gametypes\_hud_util::_id_2821();
  var_5 = var_0._id_0117 maps\mp\gametypes\_hud_util::_id_2822();
  var_5 settext(&"MPUI_BEING_REVIVED");
  var_6 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0._id_54F5 && !level.gameended && isDefined(self)) {
    if(var_6 != var_0._id_A22B) {
      if(var_0._id_28D5 > var_0._id_A23F)
        var_0._id_28D5 = var_0._id_A23F;

      var_2 maps\mp\gametypes\_hud_util::_id_A0E3(var_0._id_28D5 / var_0._id_A23F, 1000 / var_0._id_A23F * var_0._id_A22B);
      var_4 maps\mp\gametypes\_hud_util::_id_A0E3(var_0._id_28D5 / var_0._id_A23F, 1000 / var_0._id_A23F * var_0._id_A22B);

      if(!var_0._id_A22B) {
        var_2 maps\mp\gametypes\_hud_util::_id_4D06();
        var_3 maps\mp\gametypes\_hud_util::_id_4D06();
        var_4 maps\mp\gametypes\_hud_util::_id_4D06();
        var_5 maps\mp\gametypes\_hud_util::_id_4D06();
      } else {
        var_2 maps\mp\gametypes\_hud_util::_id_8BF6();
        var_3 maps\mp\gametypes\_hud_util::_id_8BF6();
        var_4 maps\mp\gametypes\_hud_util::_id_8BF6();
        var_5 maps\mp\gametypes\_hud_util::_id_8BF6();
      }
    }

    var_6 = var_0._id_A22B;
    waitframe();
  }

  if(isDefined(var_2))
    var_2 maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(var_3))
    var_3 maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(var_4))
    var_4 maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(var_5))
    var_5 maps\mp\gametypes\_hud_util::destroyelem();
}

_id_7E5C(var_0) {
  level endon("game_ended");
  self._id_0117 endon("death");
  self._id_0117 endon("disconnect");

  while(maps\mp\_utility::isreallyalive(var_0) && var_0 _meth_8341() && self._id_28D5 < self._id_A23F && !(isDefined(var_0._id_5378) && var_0._id_5378)) {
    self._id_28D5 = self._id_28D5 + 50 * self._id_A22B;
    self._id_A22B = 1;

    if(self._id_28D5 >= self._id_A23F) {
      self._id_54F5 = 0;
      return maps\mp\_utility::isreallyalive(var_0);
    }

    waitframe();
  }

  return 0;
}

_id_1E66(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self._id_5B8D) && self._id_5B8D && var_2 >= self.health && isDefined(self._id_252D) && self._id_252D == "specialty_endgame") {
    maps\mp\_utility::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

_id_35D9(var_0) {
  _func_175(self.origin, 64, 64, 1);
  var_1 = [];

  for(var_2 = 0; var_2 < 360; var_2 = var_2 + 30) {
    var_3 = _func_0A7(var_2) * 16;
    var_4 = _func_0A6(var_2) * 16;
    var_5 = bulletTrace(self.origin + (var_3, var_4, 4), self.origin + (var_3, var_4, -6), 1, self);

    if(isDefined(var_5["entity"]) && isDefined(var_5["entity"].targetname) && (var_5["entity"].targetname == "destructible_vehicle" || var_5["entity"].targetname == "destructible_toy"))
      var_1[var_1.size] = var_5["entity"];
  }

  if(var_1.size) {
    var_6 = spawn("script_origin", self.origin);
    var_6 _meth_805C();
    var_6.type = "soft_landing";
    var_6._id_2E27 = var_1;
    radiusdamage(self.origin, 64, 100, 100, var_6);
    wait 0.1;
    var_6 delete();
  }
}

_id_068A(var_0, var_1, var_2, var_3) {
  var_4 = var_0.team;

  foreach(var_6 in level.players) {
    var_7 = var_6.team;

    if(var_7 == "spectator") {
      var_6 iprintln(&"MP_OBITUARY_NEUTRAL", var_1.name, var_0.name);
      continue;
    }

    if(var_7 == var_4) {
      var_6 iprintln(&"MP_OBITUARY_ENEMY", var_1.name, var_0.name);
      continue;
    }

    var_6 iprintln(&"MP_OBITUARY_FRIENDLY", var_1.name, var_0.name);
  }
}

_id_5EAB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self getentitynumber();
  var_8 = self.name;
  var_9 = self.team;
  var_10 = self.guid;

  if(isPlayer(var_1)) {
    var_11 = var_1.guid;
    var_12 = var_1.name;
    var_13 = var_1.team;
    var_14 = var_1 getentitynumber();
    var_15 = var_1._id_01D6 + "(" + var_12 + ")";
  } else {
    var_11 = "";
    var_12 = "";
    var_13 = "world";
    var_14 = -1;
    var_15 = "none";
  }

  _func_15A("K;" + var_10 + ";" + var_7 + ";" + var_9 + ";" + var_8 + ";" + var_11 + ";" + var_14 + ";" + var_13 + ";" + var_12 + ";" + var_4 + ";" + var_2 + ";" + var_3 + ";" + var_6 + "\n");
}

_id_2DD6(var_0) {
  var_0 waittill("death");
  self destroy();
}

_id_3FC8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_2) && isPlayer(var_2) && isalive(var_2)) {
    if(level._id_6031)
      var_3 = var_3 * level._id_6031;

    if(level._id_6035)
      var_2.health = int(_func_0AF(_func_0AD(var_2.maxhealth), _func_0AD(var_2.health + 20)));
  }

  return var_3;
}

_id_8676(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_1))
    var_1 = "normal";

  if(!isDefined(var_3))
    var_3 = ::_id_62A6;

  self _meth_82C3(1);

  if(isDefined(self.classname) && self.classname != "script_vehicle")
    self _meth_849F(1);

  self.health = 999999;
  self.maxhealth = var_0;
  self._id_006A = 0;
  self._id_176C = var_4;
  self._id_29C1 = var_1;
  self.damagecallback = ::_id_7753;
  self._id_62A7 = var_3;
  self._id_6AE6 = var_2;
  self._id_118F = [];
}

_id_7753(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self)) {
    return;
  }
  if(!(isDefined(level._id_5667) && level._id_5667) && !(isDefined(level._id_585D) && level._id_585D) && isDefined(var_1) && !maps\mp\_utility::_id_56FF(var_1)) {
    return;
  }
  if(isDefined(var_1) && !_id_0513::_id_3ECD(self._id_0117, var_1)) {
    return;
  }
  var_1 _meth_809F("damage_light");

  if(isDefined(self._id_56BB) && self._id_56BB) {
    return;
  }
  if(isDefined(self._id_5745) && self._id_5745) {
    return;
  }
  if(isDefined(self._id_93FD) && self._id_93FD) {
    return;
  }
  var_12 = var_2;

  if(isDefined(var_5)) {
    switch (var_5) {
      case "smoke_grenade_axis_expeditionary_mp":
      case "smoke_grenade_expeditionary_mp":
      case "paint_grenade_mp":
      case "smoke_grenade_axis_mp":
      case "smoke_grenade_mp":
        return;
    }

    var_12 = [[self._id_62A7]](var_1, var_5, var_4, var_2);
  }

  if(var_12 <= 0)
    return 1;

  if(isDefined(var_3) && var_3 &level._id_5039)
    self._id_A86F = 1;

  self._id_A86E = 1;
  self._id_006A = self._id_006A + var_12;
  _id_051E::_id_5A67(var_1, var_5, self);

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 _id_04C7::_id_A102(self._id_29C1);

    if(_id_575B(var_1))
      self._id_118F[self._id_118F.size] = var_1;
  }

  if(self._id_006A >= self.maxhealth) {
    if(self._id_176C && isPlayer(var_1))
      var_1 notify("destroyed_killstreak", var_5);

    if(self.classname == "script_vehicle" || self.classname == "script_model") {
      var_13 = maps\mp\_utility::_id_4431(var_5, 1);

      if(maps\mp\_utility::_id_5856(var_13))
        var_13 = maps\mp\gametypes\_class::_id_4432(var_13);

      var_14 = maps\mp\gametypes\_missions::_id_40EE(var_5, var_13);

      if(isDefined(self.model) && var_14 == "weapon_launcher") {
        if(issubstr(self.model, "uav")) {
          if(isDefined(level._id_20AA["ch_uav_" + var_13]))
            var_1 maps\mp\gametypes\_missions::processchallenge("ch_uav_" + var_13);
        }

        if(issubstr(self.model, "warbird")) {
          if(isDefined(level._id_20AA["ch_warbird_" + var_13]))
            var_1 maps\mp\gametypes\_missions::processchallenge("ch_warbird_" + var_13);
        }

        if(issubstr(self.model, "orbital_platform")) {
          if(isDefined(level._id_20AA["ch_paladin_" + var_13]))
            var_1 maps\mp\gametypes\_missions::processchallenge("ch_paladin_" + var_13);
        }

        if(issubstr(self.model, "drone") && !issubstr(self.model, "uav")) {
          if(isDefined(level._id_20AA["ch_drone_" + var_13]))
            var_1 maps\mp\gametypes\_missions::processchallenge("ch_drone_" + var_13);
        }
      }
    }

    self._id_93FD = 1;
    self thread[[self._id_6AE6]](var_1, var_5, var_4, var_2);
  }
}

_id_575B(var_0) {
  foreach(var_2 in self._id_118F) {
    if(var_0 == var_2)
      return 0;
  }

  return 1;
}

_id_62A6(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_4 = _id_4AD4(var_1, var_2, var_4);
  var_4 = _id_4ABD(var_1, var_2, var_4, var_0);
  var_4 = _id_4AD5(var_1, var_2, var_4);
  var_4 = _id_4AC8(var_1, var_2, var_4);
  var_4 = _id_4AB7(var_1, var_2, var_4, var_0);
  return var_4;
}

_id_4AD5(var_0, var_1, var_2) {
  var_3 = var_2;

  switch (var_0) {
    case "airstrike_missile_mp":
    case "carepackage_crate_mp":
    case "stinger_mp":
    case "bomb_site_mp":
      self._id_5AFE = 1;
      var_3 = self.maxhealth + 1;
      break;
  }

  return var_3;
}

_id_4AC8(var_0, var_1, var_2) {
  if(var_0 == "stun_grenade_mp") {
    self notify("concussed");
    return 0;
  } else if(_func_17B(var_1)) {
    switch (var_0) {
      case "frag_grenade_german_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_2 = var_2 * 4;
        break;
      default:
        if(maps\mp\_utility::_id_57E5(var_0, "alt_"))
          var_2 = var_2 * 3;

        break;
    }
  }

  return var_2;
}

_id_4AD4(var_0, var_1, var_2) {
  if(maps\mp\_utility::_id_5755(var_1)) {
    var_3 = int(self.maxhealth / 3) + 1;

    if(var_3 > var_2)
      return var_3;
  }

  return var_2;
}

_id_4ABD(var_0, var_1, var_2, var_3) {
  if((var_0 == "emp_grenade_mp" || var_0 == "emp_grenade_killstreak_mp") && (var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_GRENADE")) {
    self notify("emp_damage", var_3, 8.0);
    return 0;
  }

  return var_2;
}

_id_4AB7(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isPlayer(var_3) && isDefined(self._id_0117) && isDefined(self._id_0117.team)) {
    if(var_3 maps\mp\_utility::_hasperk("specialty_streakdamager"))
      return var_2 * var_3._id_2998;
  }

  return var_2;
}

_id_6B4B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;

  if(isDefined(var_0) && isDefined(self._id_0117)) {
    if(isDefined(var_0._id_0117) && isPlayer(var_0._id_0117))
      var_0 = var_0._id_0117;

    if(var_0 == self._id_0117) {
      return;
    }
    if(_func_0C3(self._id_0117) && _func_0C3(var_0)) {
      if(!_func_26C(self._id_0117, var_0))
        var_8 = var_0;
    } else if(level.teambased) {
      if(self._id_0117.team != var_0.team)
        var_8 = var_0;
    } else if(self._id_0117 != var_0)
      var_8 = var_0;
  }

  if(isDefined(var_8)) {
    var_8 notify("destroyed_killstreak", var_1);
    var_8 maps\mp\_utility::incplayerstat(var_4, 1);
    level thread maps\mp\gametypes\_rank::_id_1457(var_4, var_8, var_1, undefined, var_2);

    if(isDefined(level._id_5A7D) && isDefined(level._id_5A7D[var_1])) {
      var_9 = level._id_5A7D[var_1];

      if(var_9 == "counter_uav" || var_9 == "flak_gun")
        var_8 maps\mp\gametypes\_persistence::incrementscorestreakstat(var_9, "killsOrAssists", 1);
    }

    var_10 = _id_047A::_id_43D6(var_1, var_2);

    if(var_10 == "fighter_strike_kill") {
      if(var_4 == "airstrike_destroyed" || var_4 == "fire_bombing_run_destroyed" || var_4 == "carepackage_plane_destroyed" || var_4 == "emergency_carepackage_plane_destroyed" || var_4 == "uav_destroyed" || var_4 == "counter_uav_destroyed" || var_4 == "plane_gunner_destroyed" || var_4 == "paratroopers_plane_destroyed")
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_interceptor");
    }

    if(isDefined(self._id_6F2A) && !self._id_6F2A) {
      if(var_4 == "carepackage_plane_destroyed" || var_4 == "emergency_carepackage_plane_destroyed" || var_4 == "paratroopers_plane_destroyed")
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_denied");
      else if(var_4 == "airstrike_destroyed" || var_4 == "fire_bombing_run_destroyed")
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_bomberdefense");
    }

    if(var_4 == "plane_gunner_destroyed")
      var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_ballout");

    if(var_4 == "paratroopers_destroyed")
      var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_rearguard");

    if(var_4 == "fritzx_destroyed")
      var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_movingtarget");

    var_11 = maps\mp\_utility::_id_45B5(var_1);
    var_12 = maps\mp\gametypes\_missions::_id_40EE(var_1, var_11);

    if(var_12 == "weapon_projectile" && isDefined(self._id_01C8) && var_11 != "dp28_mp") {
      var_8 maps\mp\gametypes\_missions::processchallenge("ch_camo_" + var_11);
      var_8 notify("increment_camo_multidestroy", var_11);
      var_13 = gettime();

      if(isDefined(self._id_5C2F) && var_13 - self._id_5C2F <= 20000)
        var_8 maps\mp\gametypes\_missions::_id_99C5(var_1, "ch_camoT2_quicklaunch_");

      if(isDefined(var_8.streaksdestroyedthislife)) {
        if(isDefined(var_8.streaksdestroyedthislife[var_11]))
          var_8.streaksdestroyedthislife[var_11]++;
        else
          var_8.streaksdestroyedthislife[var_11] = 1;

        if(var_8.streaksdestroyedthislife[var_11] == 2)
          var_8 maps\mp\gametypes\_missions::_id_99C5(var_1, "ch_camoT2_doubledestroy_");
      }
    }

    if(isDefined(var_6))
      level thread maps\mp\_utility::teamplayercardsplash(var_6, var_8);

    if(isDefined(var_7) && var_7) {
      if(var_1 == "counter_recon_gun_mp")
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_counteruav");
      else if(var_1 == "killstreak_flak_gun_mp")
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_flakgun");
      else
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_antiair");

      level thread maps\mp\gametypes\_missions::_id_A3F7(self._id_0117, self, undefined, var_8, var_3, var_2, var_1);
    }
  }

  thread _id_047A::_id_21EF(var_8);

  if(isDefined(self._id_0117) && isDefined(var_5))
    self._id_0117 thread maps\mp\_utility::leaderdialogonplayer(var_5);
}

_id_4CAB(var_0) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_267E)) {
    return;
  }
  if(_func_1EF(self) && isDefined(self._id_0A4B) && self._id_0A4B == "paratroopers") {
    return;
  }
  if(self _meth_843D()) {
    return;
  }
  if(self._id_267E[4] != 0)
    _id_4505();

  if(!isDefined(self.hatmodel))
    return;
  else
    self._id_267E[4] = 0;

  var_1 = spawn("script_model", self.origin + (0, 0, 20));
  var_1 setModel(self.hatmodel);
  var_1.origin = self gettagorigin("j_head") + (0, 0, 20);
  var_1.angles = self _meth_8181("j_head");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("helmet_collision");
  var_2.angles = var_1.angles;

  if(_func_1EF(self))
    self _meth_8528(2);
  else
    self _meth_84C7(self._id_267E);

  self.hatmodel = undefined;
  var_1 _meth_8055(var_2);
  var_2._id_6292 = var_1;
  var_2 thread _id_4CA9(var_0);
  var_2 _meth_8052();
}

_id_4CA9(var_0) {
  level endon("game_ended");
  setdvarifuninitialized("helmet_launch_vel", 10000);
  setdvarifuninitialized("helmet_launch_z_force", 6000);

  if(!isDefined(var_0))
    var_0 = anglesToForward(self.angles);

  var_1 = var_0;
  var_2 = var_1[0] * getdvarint("helmet_launch_vel");
  var_3 = var_1[1] * getdvarint("helmet_launch_vel");
  var_4 = var_1[2] * getdvarint("helmet_launch_z_force");
  var_5 = self.origin + var_0 * -5;
  self _meth_82C5(var_5, (var_2, var_3, var_4));
  wait 15;
  self._id_6292 delete();
  self delete();
}

_id_4505() {
  var_0 = "hat";
  var_1 = level._id_2686[var_0];
  var_2 = self._id_267E[4];
  var_3 = undefined;
  var_4 = _func_2C0(var_1, var_2);

  if(self.team == "allies")
    var_3 = "mp/costumeIdTable.csv";
  else
    var_3 = "mp/axisCostumeIdTable.csv";

  var_5 = tablelookup(var_3, 7, var_4, 4);

  if(self.team == "allies")
    var_3 = "mp/costumeModelTable.csv";
  else
    var_3 = "mp/axisCostumeModelTable.csv";

  var_6 = _func_1B1(var_3, 1, "hat");

  for(self.hatmodel = undefined; isDefined(var_6) && var_6 >= 0; var_6 = var_6 - 1) {
    var_7 = _func_1AE(var_3, var_6, 1);

    if(var_7 == "hat") {
      if(var_5 == _func_1AE(var_3, var_6, 3)) {
        self.hatmodel = _func_1AE(var_3, var_6, 0);
        break;
      }
    }
  }
}