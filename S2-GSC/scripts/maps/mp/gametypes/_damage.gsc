/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_damage.gsc
*************************************************/

isswitchingteams() {
  if(isDefined(self.switching_teams)) {
    return 1;
  }

  return 0;
}

isteamswitchbalanced() {
  var_0 = _id_0510::countplayers();
  var_0[self.leaving_team]--;
  var_0[self.joining_team]++;
  return var_0[self.joining_team] - var_0[self.leaving_team] < 2;
}

isfriendlyfire(var_0, var_1) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0.team != var_1.team) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  if(isDefined(var_0) && isDefined(var_1) && _isagent(var_0) && isDefined(var_0._id_0A4B) && var_0._id_0A4B == "leprechauns") {
    return 0;
  }

  return 1;
}

_id_8B8B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(var_0._id_3E24)) {
    return 0;
  }

  if(var_0 isonladder() || var_0 ismantling() || !var_0 isonground() || var_0 _meth_800A()) {
    return 0;
  }

  if(isDefined(var_0.nuked)) {
    return 0;
  }

  return 1;
}

killedself(var_0) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(var_0 != self) {
    return 0;
  }

  return 1;
}

handleteamchangedeath() {
  if(!level.teambased) {
    return;
  }
  if(self.joining_team == "spectator" || !isteamswitchbalanced()) {
    self thread[[level.onxpevent]]("suicide");
    maps\mp\_utility::incpersstat("suicides", 1);
    self.suicides = maps\mp\_utility::getpersstat("suicides");
  }
}

handleworlddeath(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.team)) {
    handlesuicidedeath(var_2, var_3);
    return;
  }

  if(level.teambased && var_0.team != self.team || !level.teambased) {
    if(isDefined(level.onnormaldeath) && (isPlayer(var_0) || _isagent(var_0)) && var_0.team != "spectator") {
      [[level.onnormaldeath]](self, var_0, var_1);
    }
  }
}

givescoreloss(var_0) {
  var_1 = int(max(0, _id_04D2::_id_0638(self) - var_0));
  _id_04D2::_id_06D8(self, var_1);
}

handlesuicidedeath(var_0, var_1) {
  self thread[[level.onxpevent]]("suicide");
  maps\mp\_utility::incpersstat("suicides", 1);
  self.suicides = maps\mp\_utility::getpersstat("suicides");

  if(!maps\mp\_utility::privatematch() && self.suicides == 15) {
    thread delayedsuicidekick();
  }

  var_2 = _id_0511::gettweakablevalue("game", "suicidepointloss");
  givescoreloss(var_2);

  if(var_0 == "MOD_SUICIDE" && var_1 == "none" && isDefined(self.throwinggrenade)) {
    self.lastgrenadesuicidetime = gettime();
  }

  if(isDefined(level.onsuicidedeath)) {
    [[level.onsuicidedeath]](self);
  }

  if(isDefined(self.friendlydamage)) {
    self iprintlnbold(&"MP_FRIENDLY_FIRE_WILL_NOT");
  }

  self.pers["suicideSpawnDelay"] = _id_0511::gettweakablevalue("game", "suicidespawndelay", 1);
}

delayedsuicidekick() {
  self endon("disconnect");
  level endon("game_ended");
  wait(_randomintrange(1, 60));
  _kick(self getentitynumber());
}

handlefriendlyfiredeath(var_0) {
  if(_func_367()) {
    return;
  }
  var_0 thread[[level.onxpevent]]("teamkill");
  var_0.pers["teamkills"] = var_0.pers["teamkills"] + 1.0;
  var_0.pers["totalTeamKills"] = var_0.pers["totalTeamKills"] + 1.0;
  var_0.teamkillsthisround++;

  if(_id_0511::gettweakablevalue("team", "teamkillpointloss")) {
    var_1 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
    var_0 givescoreloss(var_1);
  }

  var_2 = var_0 maps\mp\gametypes\_playerlogic::teamkilldelay();

  if(var_2 > 0) {
    var_0.pers["teamKillPunish"] = 1;
    var_0 maps\mp\_utility::_suicide();
  }

  var_3 = _id_0511::gettweakablevalue("team", "teamkillkicklimit");

  if(var_3 > 0) {
    var_4 = var_0.pers["totalTeamKills"];

    if(var_4 >= var_3) {
      thread friendlyfirekick(var_0);
    }
  }
}

friendlyfirekick(var_0) {
  waittillframeend;

  if(!_isremovedentity(var_0)) {
    _kick(var_0 getentitynumber(), "EXE_PLAYERKICKED_TEAMKILL");
  }

  level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

handlenormaldeath(var_0, var_1, var_2, var_3, var_4) {
  var_1 thread _id_047A::killedplayer(var_0, self, var_3, var_4, var_2);
  var_1 killnotification();

  if(maps\mp\_utility::isbulletdamage(var_4)) {
    _id_0378::snd_message("snd_mp_player_death");
  }

  if(var_4 == "MOD_HEAD_SHOT") {
    var_1 _id_0378::snd_message("mp_headshot_killer");
    _id_0378::snd_message("mp_headshot_killed");
  }

  var_1 thread _id_047A::killedplayerevent(self, var_3, var_4, var_2);
  thread _id_0533::_id_3F90();
  var_5 = var_1.pers["cur_kill_streak"];

  if(var_1 maps\mp\_utility::_hasperk("specialty_intelkillsandassists")) {
    _func_256(self.origin, var_1, 750);
  }

  if(isalive(var_1)) {
    if(var_1 maps\mp\_utility::_hasperk("specialty_boostafterkill")) {
      var_1 thread _id_052C::handleescalationboostafterkill();
    }

    if(var_1 maps\mp\_utility::_hasperk("specialty_multikillboost")) {
      var_1 thread _id_052C::handleclassifiedboostaftermultikillorheadshot(var_4 == "MOD_HEAD_SHOT");
    }

    if(maps\mp\_utility::ismeleemod(var_4) || var_1 maps\mp\_utility::killshouldaddtokillstreak(var_3)) {
      var_1.pers["cur_kill_streak"]++;
      var_1._id_00E4 = var_1.pers["cur_kill_streak"];
      var_1 notify("kill_streak_increased");

      if(maps\mp\_utility::isbulletdamage(var_4) && var_1 maps\mp\_utility::_hasperk("specialty_deadeye")) {
        var_1.deadeyekillcount++;
      }

      if(maps\mp\_utility::_id_0F5C() && getdvarint("scorestreak_enabled_v2_rocket") == 1) {
        if(var_1 _id_04CA::hasaccesstov2rocket()) {
          if(!maps\mp\_utility::iskillstreakweapon(var_3)) {
            var_1.pers["cur_kill_streak_for_nuke"]++;
            var_6 = 25;

            if(var_1 maps\mp\_utility::_hasperk("specialty_hardline")) {
              var_6--;
            }

            if(var_1.pers["cur_kill_streak_for_nuke"] == var_6) {
              var_7 = var_1 _id_051E::getnextkillstreakslotindex("v2_rocket", 0);
              var_1 thread _id_051E::givekillstreak("v2_rocket", 0, 1, var_1);
              var_1 thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("v2_rocket", var_6, undefined, var_7);
            }
          }
        }
      }
    }

    var_1 maps\mp\_utility::setplayerstatifgreater("longestkillstreak", var_1.pers["cur_kill_streak"]);

    if(var_1.pers["cur_kill_streak"] > var_1 maps\mp\_utility::getpersstat("longestStreak")) {
      var_1 maps\mp\_utility::setpersstat("longestStreak", var_1.pers["cur_kill_streak"]);
    }

    if(var_1 maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight")) {
      var_1 thread _id_052C::fightorflightregeneratehealth();
    }

    if(var_1 maps\mp\_utility::_hasperk("specialty_extrascorewhilehealing")) {
      var_1 thread _id_052C::fasterhealthregenkilltrigger();
    }
  }

  var_1.pers["cur_death_streak"] = 0;

  if(var_1.pers["cur_kill_streak"] > var_1 maps\mp\gametypes\_persistence::statgetchild("round", "killStreak")) {
    var_1 maps\mp\gametypes\_persistence::statsetchild("round", "killStreak", var_1.pers["cur_kill_streak"]);
  }

  if(var_1 maps\mp\_utility::rankingenabled()) {
    if(var_1.pers["cur_kill_streak"] > var_1.kill_streak) {
      var_1 maps\mp\gametypes\_persistence::statset("killStreak", var_1.pers["cur_kill_streak"]);
      var_1.kill_streak = var_1.pers["cur_kill_streak"];
    }
  }

  var_8 = _id_0511::gettweakablevalue("game", "deathpointloss");
  givescoreloss(var_8);
  level notify("player_got_killstreak_" + var_1.pers["cur_kill_streak"], var_1);
  var_1 notify("got_killstreak", var_1.pers["cur_kill_streak"]);
  var_1 notify("killed_enemy");

  if(isDefined(level.onnormaldeath) && var_1.pers["team"] != "spectator") {
    [[level.onnormaldeath]](self, var_1, var_0);
  }

  if(isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != var_1) {
    if(gettime() - self.lastattackedshieldtime < 5000) {
      if(level.teambased) {
        self.lastattackedshieldplayer thread _id_047A::processassistevent(self, "assist_riot_shield");
      } else {
        self.lastattackedshieldplayer thread _id_047A::_id_7751(self, "crossfire_riot_shield");
      }

      if(!isDefined(level.disabledivisionchallenges) || !level.disabledivisionchallenges) {
        self.lastattackedshieldplayer maps\mp\gametypes\_missions::processchallenge("ch_grenadier_skill");
      }
    }
  }

  if(!level.teambased) {
    if(isDefined(self.attackerdata)) {
      foreach(var_10 in self.attackerdata) {
        if(!isDefined(maps\mp\_utility::_id_073C(var_10.attackerent)) || var_10.attackerent == var_1 || self == var_10.attackerent) {
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

        if(var_10.attackerent maps\mp\_utility::_hasperk("specialty_paint_pro") && isDefined(var_10.attackerent.specialty_paint_time) && isDefined(self.painted) && self.painted) {
          if(isDefined(self.paintedattackers) && isDefined(self.paintedattackers[var_10.attackerent.guid]) && self.paintedattackers[var_10.attackerent.guid] + var_10.attackerent.specialty_paint_time * 1000 >= gettime()) {
            var_16 = 1;
          }
        }

        var_17 = 0;

        if(var_10.attackerent maps\mp\_utility::_hasperk("specialty_paint") && isDefined(var_10.attackerent.specialty_paint_time) && isDefined(self.painted) && self.painted) {
          if(isDefined(self.paintedexpeditionaryattackers) && isDefined(self.paintedexpeditionaryattackers[var_10.attackerent.guid]) && self.paintedexpeditionaryattackers[var_10.attackerent.guid] + var_10.attackerent.specialty_paint_time * 1000 >= gettime()) {
            var_17 = 1;
          }
        }

        if(var_17 && var_10.damage < 60) {
          var_11 = "crossfire_painted_expeditionary";
        } else if(var_16 && var_10.damage < 60) {
          var_11 = "crossfire_painted";
        } else if(var_12 && var_10.damage < 60) {
          var_11 = "crossfire_tactical";
        } else if(var_10.damage >= 40 && var_10.damage < 60) {
          var_11 = "crossfire_mid";
        } else if(var_10.damage >= 60 && var_10.damage < 80) {
          var_11 = "crossfire_high";
        } else if(var_10.damage >= 80) {
          var_11 = "crossfire_steal";
        }

        var_10.attackerent thread _id_047A::_id_7751(self, var_11, var_10._id_01D0);

        if(var_10.attackerent maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight")) {
          var_10.attackerent thread _id_052C::fightorflightregeneratehealth();
        }
      }
    }

    return;
  }

  level thread _id_04C2::playerlinktoabsolute(var_1, "kill", 0.75);

  if(!maps\mp\_utility::iskillstreakweapon(var_3)) {
    var_19["uav"] = [];
    var_19["counter_uav"] = [];
    var_19["advanced_uav"] = [];

    if(isDefined(level.uavmodels)) {
      foreach(var_21 in level.uavmodels[var_1.team]) {
        if(!isDefined(var_21._id_0117)) {
          continue;
        }
        if(common_scripts\utility::_id_0F79(var_19[var_21._id_01C8], var_21._id_0117)) {
          continue;
        }
        var_19[var_21._id_01C8][var_19[var_21._id_01C8].size] = var_21._id_0117;

        if(var_21._id_01C8 == "counter_uav") {
          if(var_21._id_0117 != var_1 && var_21._id_0117 maps\mp\_utility::_hasperk("specialty_killstreaks")) {
            var_21._id_0117 thread _id_047A::processassistevent(self, "assist_counter_uav");
            var_21._id_0117 maps\mp\gametypes\_missions::processchallenge("ch_career_killstreakassists", 10);
          }

          continue;
        }

        if(var_21._id_0117 == var_1) {
          var_21._id_0117 maps\mp\gametypes\_missions::processchallenge("ch_streak_actionableintel");
          continue;
        }

        var_21._id_0117 thread _id_047A::processassistevent(self, "assist_uav");
        var_21._id_0117 maps\mp\gametypes\_persistence::incrementscorestreakstat(var_21._id_01C8, "killsOrAssists", 1);
        var_21._id_0117 maps\mp\gametypes\_missions::processchallenge("ch_career_killstreakassists", 10);
        var_21._id_0117 maps\mp\gametypes\_missions::processchallenge("ch_streak_uav", 10);
      }
    }

    var_23 = level.teambased && isDefined(level._id_3CE0) && level._id_3CE0 != var_1 && level._id_3CE0 maps\mp\_utility::_hasperk("specialty_killstreaks");

    if(var_23) {
      level._id_3CE0 thread _id_047A::processassistevent(self, "assist_flak_guns");
      level._id_3CE0 maps\mp\gametypes\_missions::processchallenge("ch_career_killstreakassists", 10);
    }
  }

  if(isDefined(self.tagmarkedby)) {
    self.tagmarkedby = undefined;
  }

  if(level.teambased && isDefined(level.teamemped) && level.teamemped[self.team] || !level.teambased && isDefined(level.empplayer) && level.empplayer != self) {
    if(isDefined(level.empowner) && level.empassistpoints && level.empowner != var_1) {
      level.empowner thread _id_047A::processassistevent(self, "assist_emp");
    }

    _id_0485::logkillstreakassist(level.empowner);
  }

  if(isDefined(self.attackerdata)) {
    foreach(var_10 in self.attackerdata) {
      if(!isDefined(maps\mp\_utility::_id_073C(var_10.attackerent))) {
        continue;
      }
      if(var_10.attackerent == var_1) {
        continue;
      }
      if(self == var_10.attackerent) {
        continue;
      }
      if(maps\mp\_utility::iskillstreakweapon(var_10._id_01D0) && var_10._id_01D0 != "killstreak_flak_gun_raids" && var_10._id_01D0 != "agent_raid_fighters_mp") {
        var_10.attackerent maps\mp\gametypes\_missions::processchallenge("ch_career_killstreakassists");
        _id_0485::logkillstreakassist(var_10.attackerent);
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

      if(var_10.attackerent maps\mp\_utility::_hasperk("specialty_paint_pro") && isDefined(var_10.attackerent.specialty_paint_time) && isDefined(self.painted) && self.painted) {
        if(isDefined(self.paintedattackers) && isDefined(self.paintedattackers[var_10.attackerent.guid]) && self.paintedattackers[var_10.attackerent.guid] + var_10.attackerent.specialty_paint_time * 1000 >= gettime()) {
          var_28 = 1;
        }
      }

      var_29 = 0;

      if(var_10.attackerent maps\mp\_utility::_hasperk("specialty_paint") && isDefined(var_10.attackerent.specialty_paint_time) && isDefined(self.painted) && self.painted) {
        if(isDefined(self.paintedexpeditionaryattackers) && isDefined(self.paintedexpeditionaryattackers[var_10.attackerent.guid]) && self.paintedexpeditionaryattackers[var_10.attackerent.guid] + var_10.attackerent.specialty_paint_time * 1000 >= gettime()) {
          var_29 = 1;
        }
      }

      if(var_29 && var_10.damage < 60) {
        var_11 = "assist_painted_expeditionary";
      } else if(var_28 && var_10.damage < 60) {
        var_11 = "assist_painted";
      } else if(var_25 && var_10.damage < 60) {
        var_11 = "assist_tactical";
      } else if(var_10.damage >= 40 && var_10.damage < 60) {
        var_11 = "assist_mid";
      } else if(var_10.damage >= 60 && var_10.damage < 80) {
        var_11 = "assist_high";
      } else if(var_10.damage >= 80) {
        var_11 = "assist_steal";
      }

      var_10.attackerent thread _id_047A::processassistevent(self, var_11, var_10._id_01D0, var_10._id_A9DF);

      if(var_10.attackerent maps\mp\_utility::_hasperk("specialty_intelkillsandassists")) {
        _func_256(self.origin, var_10.attackerent, 750);
      }

      if(var_10.attackerent maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight")) {
        var_10.attackerent thread _id_052C::fightorflightregeneratehealth();
      }
    }
  }
}

isplayerweapon(var_0) {
  if(weaponclass(var_0) == "non-player") {
    return 0;
  }

  if(weaponclass(var_0) == "turret") {
    return 0;
  }

  if(weaponinventorytype(var_0) == "primary" || weaponinventorytype(var_0) == "altmode") {
    return 1;
  }

  return 0;
}

callback_playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  playerkilled_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
}

callback_playergrenadesuicide(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self.explosiveinfo = [];
  self.explosiveinfo["damageTime"] = gettime();
  self.explosiveinfo["damageId"] = var_0 getentitynumber();
  self.explosiveinfo["returnToSender"] = 0;
  self.explosiveinfo["counterKill"] = 0;
  self.explosiveinfo["chainKill"] = 0;
  self.explosiveinfo["cookedKill"] = 0;
  self.explosiveinfo["throwbackKill"] = 0;
  self.explosiveinfo["midAirDetonate"] = 0;
  self.explosiveinfo["suicideGrenadeKill"] = self == var_0;
  self.explosiveinfo["weapon"] = var_4;
}

_id_1E64() {
  self delete();
}

launchshield(var_0, var_1) {
  self refreshshieldmodels("none", 1);
  _id_048A::riotshield_clear();
}

playerkilled_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = var_4;
  var_12 = gettime();
  var_2 endon("spawned");
  var_2 notify("killed_player");
  var_2._id_5D9F = 0;

  if(isDefined(var_4) && var_4 == "MOD_FALLING" && isDefined(var_2) && isDefined(var_2._id_5723) && var_2._id_5723 && isDefined(var_2._id_6E4B)) {
    var_1 = var_2._id_6E4B;
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_1.exo_ping_on) && var_1.exo_ping_on == 1) {
    var_1 maps\mp\gametypes\_missions::processchallenge("ch_exoability_ping");
  }

  if(isDefined(var_2.waterwakevfxdeletefunc)) {
    var_2[[var_2.waterwakevfxdeletefunc]]();
  }

  if(isDefined(var_2.prekilledfunc)) {
    var_2[[var_2.prekilledfunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  var_2 maps\mp\gametypes\_playerlogic::resetuidvarsondeath();
  var_2._id_083E = 0;
  var_2.perkoutlined = 0;
  var_2.jumpbuttonpressed = 0;
  var_1 = maps\mp\_utility::_id_073C(var_1);

  if(isDefined(var_1)) {
    var_1.assistedsuicide = undefined;
  }

  if(!isDefined(var_2.idflags)) {
    if(var_4 == "MOD_SUICIDE") {
      var_2.idflags = 0;
    } else if(var_4 == "MOD_GRENADE") {
      if((issubstr(var_5, "frag_grenade") || issubstr(var_5, "thermobaric_grenade")) && var_3 == 100000) {
        var_2.idflags = 0;
      } else if(var_5 == "v2_rocket_mp") {
        var_2.idflags = 0;
      } else if(level.friendlyfire >= 2) {
        var_2.idflags = 0;
      } else {}
    }
  }

  if(var_2 _id_048A::_id_4B8C()) {
    var_2 launchshield(var_3, var_4);
  }

  if(!maps\mp\_utility::_id_5697(var_4, var_5)) {}

  if(!var_10) {
    if(isDefined(var_2.endgame)) {
      maps\mp\_utility::revertvisionsetforplayer(2);
    } else {
      maps\mp\_utility::revertvisionsetforplayer(0);
      var_2 thermalvisionoff();
    }
  } else {
    maps/_loadout(var_2, 1);
    self notify("death", var_1, var_4, var_5);
  }

  if(game["state"] == "postgame") {
    return;
  }
  var_13 = 0;

  if(!isPlayer(var_0) && isDefined(var_0.primaryweapon)) {
    var_14 = var_0.primaryweapon;
  } else if(isDefined(var_1) && isPlayer(var_1) && var_1 getcurrentprimaryweapon() != "none") {
    var_14 = var_1 getcurrentprimaryweapon();
  } else if(issubstr(var_5, "alt_")) {
    var_14 = getsubstr(var_5, 4, var_5.size);
  } else {
    var_14 = undefined;
  }

  if(isDefined(var_2.uselaststandparams) || isDefined(var_2.laststandparams) && var_4 == "MOD_SUICIDE") {
    var_2 ensurelaststandparamsvalidity();
    var_2.uselaststandparams = undefined;
    var_0 = var_2.laststandparams.einflictor;
    var_1 = maps\mp\_utility::_id_073C(var_2.laststandparams.attacker);
    var_3 = var_2.laststandparams.idamage;
    var_4 = var_2.laststandparams.smeansofdeath;
    var_5 = var_2.laststandparams.sweapon;
    var_14 = var_2.laststandparams.sprimaryweapon;
    var_6 = var_2.laststandparams.vdir;
    var_7 = var_2.laststandparams.shitloc;
    var_13 = (gettime() - var_2.laststandparams.laststandstarttime) / 1000;
    var_2.laststandparams = undefined;
  }

  if((!isDefined(var_1) || !isDefined(var_1.classname) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2) && isDefined(self.attackers)) {
    var_15 = undefined;

    foreach(var_17 in self.attackers) {
      if(!isDefined(maps\mp\_utility::_id_073C(var_17))) {
        continue;
      }
      if(!isDefined(var_2.attackerdata[var_17.guid].damage)) {
        continue;
      }
      if(var_17 == var_2 || level.teambased && var_17.team == var_2.team) {
        continue;
      }
      if(var_2.attackerdata[var_17.guid].lasttimedamaged + 2500 < gettime() && (var_1 != var_2 && (isDefined(var_2._id_00E8) && var_2._id_00E8))) {
        continue;
      }
      if(var_2.attackerdata[var_17.guid].damage > 1 && !isDefined(var_15)) {
        var_15 = var_17;
        continue;
      }

      if(isDefined(var_15) && var_2.attackerdata[var_17.guid].damage > var_2.attackerdata[var_15.guid].damage) {
        var_15 = var_17;
      }
    }

    if(isDefined(var_15)) {
      var_1 = var_15;

      if(!isDefined(self._id_6E6B) || !self._id_6E6B) {
        var_1.assistedsuicide = 1;
      }

      var_5 = var_2.attackerdata[var_15.guid]._id_01D0;
      var_6 = var_2.attackerdata[var_15.guid].vdir;
      var_7 = var_2.attackerdata[var_15.guid].shitloc;
      var_8 = var_2.attackerdata[var_15.guid]._id_014A;
      var_4 = var_2.attackerdata[var_15.guid].smeansofdeath;
      var_3 = var_2.attackerdata[var_15.guid].damage;
      var_14 = var_2.attackerdata[var_15.guid].sprimaryweapon;
      var_0 = var_1;
    }
  } else if(isDefined(var_1))
    var_1.assistedsuicide = undefined;

  if(maps\mp\_utility::isheadshot(var_5, var_7, var_4, var_1)) {
    var_4 = "MOD_HEAD_SHOT";
  }

  if(var_4 == "MOD_HEAD_SHOT" && isDefined(var_6)) {}

  var_19 = isfriendlyfire(var_2, var_1);

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_003B)) {
      if(var_1._id_003B == "script_vehicle" && isDefined(var_1._id_0117)) {
        var_1 = var_1._id_0117;
      }

      if(var_1._id_003B == "misc_turret" && isDefined(var_1._id_0117)) {
        if(isDefined(var_1.vehicle)) {
          var_1.vehicle notify("killedPlayer", var_2);
        }

        var_1 = var_1._id_0117;
      }
    }

    var_2._id_1187 = undefined;

    if(_isagent(var_1) && isDefined(var_1._id_0117)) {
      if(isDefined(var_1._id_0A4B)) {
        var_2._id_1187 = var_1._id_0A4B;
      }

      var_2._id_1186 = var_1 getentitynumber();
      var_1 = var_1._id_0117;
      var_5 = "agent_mp";
      var_4 = "MOD_RIFLE_BULLET";

      if(isDefined(var_2._id_1187) && var_2._id_1187 == "bomberEscortFighterAgents") {
        var_5 = "agent_raid_fighters_mp";
      }
    }

    if(isDefined(var_1._id_003B) && var_1._id_003B == "script_model" && isDefined(var_1._id_0117)) {
      var_1 = var_1._id_0117;

      if(!isfriendlyfire(var_2, var_1) && var_1 != var_2) {
        var_1 notify("crushed_enemy");
      }
    }
  }

  if(var_4 != "MOD_SUICIDE" && (maps\mp\_utility::isaigameparticipant(var_2) || maps\mp\_utility::isaigameparticipant(var_1)) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["get_attacker_ent"])) {
    var_20 = [[level.bot_funcs["get_attacker_ent"]]](var_1, var_0);

    if(isDefined(var_20)) {
      if(maps\mp\_utility::isaigameparticipant(var_2)) {
        var_2 botmemoryevent("death", var_5, var_20.origin, var_2.origin, var_20);
      }

      if(maps\mp\_utility::isaigameparticipant(var_1)) {
        var_21 = 1;

        if(var_20.classname == "script_vehicle" && isDefined(var_20.helitype) || var_20.classname == "rocket" || var_20.classname == "misc_turret") {
          var_21 = 0;
        }

        if(var_21) {
          var_1 botmemoryevent("kill", var_5, var_20.origin, var_2.origin, var_2);
        }
      }
    }
  }

  if(isDefined(var_2.grenadierfrenzy) && var_2.grenadierfrenzy == 1) {
    var_2 _id_052C::togglegrenadierfrenzy(0);
  }

  var_22 = var_2 getcurrentweapon();
  var_2 thread _id_0513::dropscavengerfordeath(var_1, var_4, var_5);

  if(!isDefined(var_2._id_0A4F)) {
    var_2 thread[[level.weapondropfunction]](var_1, var_4, var_5);
  } else {
    var_2._id_0A4F thread[[level.weapondropfunction]](var_1, var_4, var_5);
  }

  if(!var_10) {
    var_2 maps\mp\_utility::updatesessionstate("dead");
  }

  var_23 = isDefined(var_2) && isDefined(var_2.switching_teams) && var_2.switching_teams;

  if(!var_23) {
    var_2 maps\mp\gametypes\_playerlogic::removefromalivecount();
  }

  if(!isDefined(var_2.switching_teams) && !(isDefined(level.iszombiegame) && level.iszombiegame) && !isfriendlyfire(var_2, var_1)) {
    var_2 maps\mp\_utility::incpersstat("deaths", 1);
    var_2 maps\mp\_utility::incplayerstat("deaths", 1);
    var_2.deaths = var_2 maps\mp\_utility::getpersstat("deaths");

    if(!xmodelalias/alias_ger_heads_scarf_for_muddy_cheap() && !(isDefined(level._id_2F8B) && level._id_2F8B) && !(isDefined(level.disableallplayerstats) && level.disableallplayerstats)) {
      var_2 maps\mp\_utility::updatepersratio("kdRatio", "kills", "deaths");
      var_2 maps\mp\gametypes\_persistence::statsetchild("round", "deaths", var_2.deaths);
      var_2 _id_04CA::_id_50FC(var_2._id_0079, 1, "deaths");
    }
  }

  var_24 = maps\mp\_utility::ismeleemod(var_4) && issubstr(var_5, "bayonet");

  if(!maps\mp\_utility::practiceroundgame() && (!level._id_53C7 || !isbot(var_1))) {
    _obituary(var_2, var_1, var_5, var_4, var_24);
  }

  var_25 = 0;
  var_2 logprintplayerdeath(self._id_5CC6, var_1, var_3, var_4, var_5, var_14, var_7);
  var_2 _id_0485::logplayerlife(1);
  var_2 _id_0485::logplayerdeath(self._id_5CC6, var_0, var_1, var_3, var_4, var_5, var_14, var_7, var_22);

  if(maps\mp\_utility::ismeleemod(var_4) && isPlayer(var_1) && !issubstr(var_5, "riotshield")) {
    var_1 maps\mp\_utility::incplayerstat("knifekills", 1);
  }

  var_26 = 0;

  if(var_2 isswitchingteams()) {
    handleteamchangedeath();
  } else if((!isPlayer(var_1) || isPlayer(var_1) && var_4 == "MOD_FALLING") && (!isDefined(var_2._id_5723) || !var_2._id_5723)) {
    handleworlddeath(var_1, self._id_5CC6, var_4, var_7);

    if(_isagent(var_1)) {
      var_25 = 1;
    }

    if(_id_04E6::isworldkillcam(var_0, var_1, var_5)) {
      var_25 = 1;
    }
  } else if(var_1 == var_2 && (isDefined(var_0) && (!isDefined(var_0.isorbitalcam) || var_0.isorbitalcam == 0)))
    handlesuicidedeath(var_4, var_7);
  else if(var_19) {
    if(!isDefined(var_2.nuked)) {
      handlefriendlyfiredeath(var_1);
    }
  } else {
    var_25 = 1;

    if(_isai(var_2)) {
      if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["should_do_killcam"])) {
        var_25 = var_2[[level.bot_funcs["should_do_killcam"]]]();
      }
    }

    if(isDefined(var_2._id_1187) && var_2._id_1187 == "bomberEscortFighterAgents") {
      var_25 = 0;
    }

    if(isDefined(var_0) && (!isDefined(var_0.isorbitalcam) || var_0.isorbitalcam == 0)) {
      handlenormaldeath(self._id_5CC6, var_1, var_0, var_5, var_4);
      var_26 = 1;
    }

    var_2.pers["cur_death_streak"]++;
    var_1 thread _id_04E7::_id_A128(var_1, var_2);
    var_2 thread _id_04E7::_id_A128(var_1, var_2);
  }

  if(isDefined(var_1) && isDefined(var_1.assistedsuicide) && var_1.assistedsuicide) {
    var_25 = 0;
  }

  var_2 _id_A106(self.attackers, self.attackerdata);

  if(!level.teambased) {
    self.attackers = [];
  }

  var_27 = 0;
  var_28 = undefined;

  if(isDefined(self.previousprimary)) {
    var_27 = 1;
    var_28 = self.previousprimary;
    self.previousprimary = undefined;
  }

  if(isPlayer(var_1) && var_1 != self && (!level.teambased || level.teambased && self.team != var_1.team)) {
    if(var_27 && isDefined(var_28)) {
      var_29 = var_28;
    } else {
      var_29 = self.lastdroppableweapon;
    }

    thread maps\mp\gametypes\_gamelogic::trackleaderboarddeathstats(var_29, var_4);
    var_1 thread maps\mp\gametypes\_gamelogic::trackattackerleaderboarddeathstats(var_5, var_4, var_0);
  }

  var_2.wasswitchingteamsforonplayerkilled = undefined;

  if(isDefined(var_2.switching_teams)) {
    var_2.wasswitchingteamsforonplayerkilled = 1;
  }

  var_2 resetplayervariables();
  var_2._id_00E6 = var_1;
  var_2.lastinflictor = var_0;

  if(!isDefined(var_2._id_0A4F)) {
    var_2.lastdeathpos = var_2.origin;
  } else {
    var_2.lastdeathpos = var_2._id_0A4F.origin;
  }

  var_2.deathtime = gettime();

  if(isPlayer(var_1) && var_2 != var_1 && (!level.teambased || level.teambased && var_2.team != var_1.team) && (!isDefined(level.killstreakwieldweapons) || !isDefined(level.killstreakwieldweapons[var_5]) || var_5 == "flamethrower_mp" || var_5 == "flamethrower_german_mp" || var_5 == "flamethrower_grenadier_mp" || var_5 == "flamethrower_german_grenadier_mp" || var_5 == "killstreak_molotov_cocktail_mp" || var_5 == "killstreak_molotov_cocktail_grenadier_mp")) {
    var_30["position"] = var_2.lastdeathpos;
    var_30["time"] = var_2.deathtime;

    if(level.teambased) {
      level._id_7AD1[var_2.team][level._id_7AD1[var_2.team].size] = var_30;
    } else {
      var_30["player"] = self.guid;
      level._id_7AD1["all"][level._id_7AD1["all"].size] = var_30;
    }
  }

  var_2.wantsafespawn = 0;
  var_2.revived = 0;
  var_2.sameshotdamage = 0;
  var_2 _id_051E::resetadrenaline(0);
  var_2 _id_052C::resetspecialistperkstreak();
  var_31 = _id_046D::gettotalscore(var_2) - var_2.scoreatlifestart;
  var_2 maps\mp\_utility::setplayerstatifgreater("mostScorePerLife", var_31);
  var_32 = undefined;

  if(maps\mp\_utility::isrocketcorpse()) {
    var_25 = 1;
    var_10 = 0;
    var_32 = self.killcament;
    self waittill("final_rocket_corpse_death");
  } else {
    if(var_10) {
      var_25 = 0;

      if(!isDefined(var_2._id_0A4F)) {
        var_9 = var_2 playerforcedeathanim(var_0, var_4, var_5, var_7, var_6);
      }
    }

    if(isDefined(var_2.hideondeath) && var_2.hideondeath) {
      var_2 playerhide();
      thread _id_04C8::_id_09AA(var_2, var_2, var_2.team, 5.0, var_1, var_4, var_5);
    } else if(var_2 maps\mp\perks\_medic::canspawnmedicpatienttrigger())
      var_2 thread maps\mp\perks\_medic::ondeath_handlemedic();
    else if(!isDefined(var_2._id_0A4F)) {
      var_2.body = var_2 cloneplayer(var_9);
      var_2.body.costumes = var_2.costumes;

      if(isDefined(var_2._id_5DA9)) {
        var_2.body enablelinkTo();

        if(isDefined(var_2._id_5DAA)) {
          var_2.body linkTo(var_2._id_5DA9, var_2._id_5DAA);
        } else {
          var_2.body linkTo(var_2._id_5DA9);
        }
      }

      var_33 = common_scripts\utility::_id_562E(var_2._id_3E19);

      if((var_33 || issubstr(var_11, "MOD_GRENADE") || issubstr(var_11, "MOD_EXPLOSIVE") || issubstr(var_11, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1)) {
        if(getdvarint("scr_dismemberment_style", 0) == 0 && !_func_367() && getdvarint("isEsportsMatch", 0) == 0 && level.gametype != "infect" && maps\mp\_utility::getmapname() != "mp_sandbox_01") {
          if(isDefined(var_5) && var_5 != "smoke_grenade_mp" && var_5 != "stun_grenade_mp" && var_5 != "signal_flare_mp" && var_5 != "signal_flare_expeditionary_mp" && var_5 != "tabun_grenade_mp" && var_5 != "carepackage_crate_mp") {
            var_2 _id_04EB::_id_4AAB(var_33);

            if(isDefined(var_2._id_65D2) && isDefined(var_2._id_65D1)) {
              _playFXOnTag(common_scripts\utility::getfx(var_2._id_65D2), var_2.body, var_2._id_65D1);
            }
          }
        }
      }

      if(var_10) {
        var_2 playerhide();
      }

      if(!_id_8B8B(var_2)) {
        var_2.body startragdoll();
      }

      if(!isDefined(var_2.switching_teams)) {
        thread _id_04C8::_id_09AA(var_2.body, var_2, var_2.team, 5.0, var_1, var_4, var_5);
      }

      thread delaystartragdoll(var_2.body, var_7, var_6, var_5, var_0, var_4);
      var_2 notify("corpse_created");
    } else if(!isDefined(var_2.switching_teams))
      thread _id_04C8::_id_09AA(var_2._id_0A4F, var_2, var_2.team, 5.0, var_1, var_4, var_5);
  }

  if(!maps\mp\_utility::isheadshot(var_5, var_7, var_11, var_1) && !isDefined(var_2.nuked)) {
    var_2 maps\mp\_utility::playdeathsound(var_11, var_5);
  }

  var_2 thread[[level._id_6B7B]](var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self._id_5CC6);

  if(var_26) {
    var_2 thread maps\mp\gametypes\_missions::playerkilled(var_0, var_1, var_3, var_4, var_5, var_14, var_7, var_1.modifiers);
  }

  if(_isai(var_2) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["on_killed"])) {
    var_2 thread[[level.bot_funcs["on_killed"]]](var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self._id_5CC6);
  }

  if(maps\mp\_utility::isgameparticipant(var_1)) {
    var_34 = var_1 getentitynumber();
  } else {
    var_34 = -1;
  }

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    var_34 = -1;
  }

  if(!isDefined(var_32) && isDefined(var_1)) {
    var_32 = var_2 getkillcamentity(var_1, var_0, var_5);
  }

  var_35 = -1;
  var_36 = 0;
  var_37 = 0;

  if(isDefined(var_32)) {
    var_35 = var_32 getentitynumber();
    var_36 = var_32._id_002B;

    if(isDefined(var_32.killcamstarttime)) {
      var_36 = var_32.killcamstarttime;
      var_37 = 1;
    }

    if(!isDefined(var_36)) {
      var_36 = 0;
    }
  } else if(var_5 == "orbital_laser_fov_mp" && isDefined(var_0) && isDefined(var_0.killcamstarttime)) {
    var_36 = var_0.killcamstarttime;
    var_37 = 1;
  }

  if(common_scripts\utility::_id_562E(level.forcenokillcam)) {
    var_25 = 0;
  }

  if(isDefined(var_1) && isDefined(var_1._id_5BE2)) {
    var_38 = (gettime() - var_1._id_5BE2) / 1000.0;
  } else {
    var_38 = 0;
  }

  if(var_4 != "MOD_SUICIDE" && !(!isDefined(var_1) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2) && !common_scripts\utility::_id_562E(level.forcenokillcam)) {
    _id_04CE::recordfinalkillcam(5.0, var_2, var_1, var_34, var_35, var_36, var_5, var_13, var_8, var_4, "normal", var_37);
  }

  if(_id_04E6::killcamvalid(var_2, var_25)) {
    var_39 = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
    var_40 = maps\mp\gametypes\_gamelogic::timeuntilroundend();
    var_41 = _id_04E6::killcamtime(var_36, var_5, 0, var_39, var_40, var_37, 0);
    var_42 = _id_04E6::killcamarchivetime(var_41, var_38, var_13, var_8 / 1000);
    var_2 _id_04E6::prekillcamnotify(var_0, var_1, var_42, var_22);
  } else if(maps\mp\_utility::isvalidclass(var_2.class))
    var_2 maps\mp\gametypes\_playerlogic::streamclass();

  var_43 = gettime() + 5000;

  if(!var_10) {
    wait 0.25;

    if(_id_04E6::killcamvalid(var_2, var_25)) {
      var_2 thread _id_04E6::cancelkillcamonuse();
      var_2 setclientomnvar("ui_show_skip_killcam", 1);
    }

    wait 0.25;
    self.respawntimerstarttime = gettime() + 1000;
    var_39 = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);

    if(var_39 < 1) {
      var_39 = 1;
    }

    wait 1.5;

    if(isDefined(self.streamweapons) && self.streamweapons.size > 0) {
      while(_id_04E6::killcamvalid(var_2, var_25) && isPlayer(self) && isPlayer(var_1) && !self hasloadedcustomizationplayerview(var_1, self.streamweapons) && gettime() < var_43) {
        waitframe();
      }
    }

    if(common_scripts\utility::_id_562E(var_2.onplayerkilledwaitfordeathduration)) {
      var_44 = gettime() - var_2.deathtime;

      if(var_9 > var_44) {
        var_45 = (var_9 - var_44) / 1000;
        wait(var_45);
      }

      var_2.onplayerkilledwaitfordeathduration = undefined;
    }

    var_46 = var_2 _meth_85E2();

    if(isDefined(var_46)) {
      var_2 dismountvehicle();
    }

    var_2 setclientomnvar("ui_show_skip_killcam", 0);
    var_2 notify("death_delay_finished");
  }

  var_47 = (gettime() - var_2.deathtime) / 1000;
  self.respawntimerstarttime = gettime();
  var_48 = gettime() >= var_43;

  if(_id_04E6::killcamvalid(var_2, var_25) && !var_48) {
    var_49 = !(maps\mp\_utility::getgametypenumlives() && !var_2.pers["lives"]);
    var_39 = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
    var_50 = var_49 && var_39 <= 0;

    if(!var_49) {
      var_39 = -1;
      level notify("player_eliminated", var_2);
    }

    var_2 _id_04E6::killcam(var_0, var_34, var_35, var_36, var_5, var_47 + var_13, var_8, var_39, maps\mp\gametypes\_gamelogic::timeuntilroundend(), var_1, var_2, var_4, "normal", var_38, var_37);
  }

  if(isDefined(var_2._id_1187)) {
    var_2._id_1187 = undefined;
  }

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam) {
      var_2 maps\mp\_utility::updatesessionstate("dead");
      var_2 maps\mp\_utility::clearkillcamstate();
    }

    return;
  }

  var_51 = maps\mp\_utility::getgametypenumlives();
  var_52 = self.pers["lives"];

  if(maps\mp\_utility::isvalidclass(var_2.class)) {
    var_2 thread maps\mp\gametypes\_playerlogic::spawnclient();
  }
}

waittimerforspawn() {
  self endon("randomSpawnPressed");
  self.kc_teamspawntext settext(&"PLATFORM_PRESS_TO_TEAMSPAWN");
  self.kc_teamspawntext.alpha = 1;
  self.kc_randomspawntext settext(&"PLATFORM_PRESS_TO_RESPAWN");
  self.kc_randomspawntext.alpha = 1;
  thread waitteamspawnbutton();
  thread waitspawnrandombutton();

  if(isDefined(self.skippedkillcam) && self.skippedkillcam) {
    var_0 = 8;
  } else {
    var_0 = 9;
  }

  if(isDefined(self.timestartedtowait)) {
    var_1 = int(_ceil(var_0 - (gettime() - self.timestartedtowait) / 1000));
  } else {
    var_1 = var_0;
  }

  self.partnerspawning = 0;
  wait 0.5;

  for(var_2 = var_1; var_2 > 0; var_2--) {
    maps\mp\_utility::setlowermessage("kc_info", &"MP_TIME_TILL_SPAWN", var_1, 1, 1);
    wait 1;
  }

  self.kc_randomspawntext.alpha = 0;
  self.kc_teamspawntext.alpha = 0;
  maps\mp\_utility::clearlowermessage("kc_info");
  self notify("abort_fireteam_spawn");
}

waitspawnrandombutton() {
  self endon("disconnect");
  self endon("abort_fireteam_spawn");

  while(self useButtonPressed()) {
    waitframe();
  }

  while(!self useButtonPressed()) {
    waitframe();

    if(!maps\mp\_utility::isreallyalive(self.partner)) {
      break;
    }
  }

  self.partnerspawning = 0;
  self notify("randomSpawnPressed");
  self.kc_randomspawntext.alpha = 0;
  self.kc_teamspawntext.alpha = 0;
  maps\mp\_utility::clearlowermessage("kc_info");
  self notify("abort_fireteam_spawn");
}

waitteamspawnbutton() {
  self endon("disconnect");
  self endon("abort_fireteam_spawn");

  while(self attackButtonPressed()) {
    waitframe();
  }

  while(!self attackButtonPressed()) {
    waitframe();
  }

  self.partnerspawning = 1;
  self playlocalsound("copycat_steal_class");
  self notify("teamSpawnPressed");
  self.kc_randomspawntext.alpha = 0;
  self.kc_teamspawntext.alpha = 0;
}

checkforcebleedout() {
  if(level.diehardmode != 1) {
    return 0;
  }

  if(!maps\mp\_utility::getgametypenumlives()) {
    return 0;
  }

  if(level.livescount[self.team] > 0) {
    return 0;
  }

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
    if(!var_1.inlaststand) {
      return 0;
    }
  }

  foreach(var_1 in level.players) {
    if(!isalive(var_1)) {
      continue;
    }
    if(var_1.team != self.team) {
      continue;
    }
    if(var_1.inlaststand && var_1 != self) {
      var_1 laststandbleedout(0);
    }
  }

  return 1;
}

resetplayervariables() {
  self.killedplayerscurrent = [];
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self._id_00E4 = 0;
  _id_04D1::detachusemodels();
}

getkillcamentity(var_0, var_1, var_2) {
  if(isDefined(var_0.didturretexplosion) && var_0.didturretexplosion && isDefined(var_0.turret)) {
    var_0.didturretexplosion = undefined;
    return var_0.turret.killcament;
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
      if(isDefined(var_1)) {
        return var_1.killcament;
      }

      break;
    case "agent_raid_fighters_mp":
    case "agent_mp":
      return var_1;
    case "thermite_flames_mp":
    case "firebomb_flames_mp":
      self.killcamstarttime = gettime() - 2000;
      return self;
    case "ww2_fighter_bullet_mp":
    case "fighter_strike_gun_mp":
      if(isDefined(var_1) && isDefined(var_1._id_700B)) {
        return var_1._id_700B.killcament;
      }

      break;
    case "ball_drone_projectile_mp":
    case "ball_drone_gun_mp":
      if(isPlayer(var_0) && isDefined(var_0.balldrone) && isDefined(var_0.balldrone.turret) && isDefined(var_0.balldrone.turret.killcament)) {
        return var_0.balldrone.turret.killcament;
      }

      break;
    case "none":
      if(isDefined(var_1) && isDefined(var_1.targetname) && (var_1.targetname == "care_package" || var_1.targetname == "rocket_button")) {
        return var_1.killcament;
      }

      break;
  }

  if(maps\mp\_utility::isdestructibleweapon(var_2) || maps\mp\_utility::isbombsiteweapon(var_2)) {
    if(isDefined(var_1.killcament) && !var_0 attackerinremotekillstreak()) {
      return var_1.killcament;
    } else {
      return undefined;
    }
  }

  if(_id_04E6::isworldkillcam(var_1, var_0, var_2)) {
    if(var_2 == "turretweapon_tank_panzer_cannon_mp_left" || var_2 == "turretweapon_tank_panzer_cannon_mp_right") {
      return var_1.killcament;
    }

    return var_0.killcament;
  }

  if(!isDefined(var_1) || var_0 == var_1 && !_isagent(var_0)) {
    return undefined;
  }

  return var_1;
}

attackerinremotekillstreak() {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && self == level.chopper.gunner) {
    return 1;
  }

  if(isDefined(self.using_remote_turret) && self.using_remote_turret) {
    return 1;
  }

  if(isDefined(self.using_remote_tank) && self.using_remote_tank) {
    return 1;
  }

  return 0;
}

hitlocdebug(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[0] = 2;
  var_5[1] = 3;
  var_5[2] = 5;
  var_5[3] = 7;

  if(!getdvarint("scr_hitloc_debug")) {
    return;
  }
  if(!isDefined(var_0.hitlocinited)) {
    for(var_6 = 0; var_6 < 6; var_6++) {
      var_0 setclientdvar("ui_hitloc_" + var_6, "");
    }

    var_0.hitlocinited = 1;
  }

  if(level.splitscreen || !isPlayer(var_0)) {
    return;
  }
  var_7 = 6;

  if(!isDefined(var_0.damageinfo)) {
    var_0.damageinfo = [];

    for(var_6 = 0; var_6 < var_7; var_6++) {
      var_0.damageinfo[var_6] = spawnStruct();
      var_0.damageinfo[var_6].damage = 0;
      var_0.damageinfo[var_6]._id_4DD8 = "";
      var_0.damageinfo[var_6]._id_1B7C = 0;
      var_0.damageinfo[var_6].colorindex = 0;
    }

    var_0.damageinfocolorindex = 0;
    var_0.damageinfovictim = undefined;
  }

  for(var_6 = var_7 - 1; var_6 > 0; var_6--) {
    var_0.damageinfo[var_6].damage = var_0.damageinfo[var_6 - 1].damage;
    var_0.damageinfo[var_6]._id_4DD8 = var_0.damageinfo[var_6 - 1]._id_4DD8;
    var_0.damageinfo[var_6]._id_1B7C = var_0.damageinfo[var_6 - 1]._id_1B7C;
    var_0.damageinfo[var_6].colorindex = var_0.damageinfo[var_6 - 1].colorindex;
  }

  var_0.damageinfo[0].damage = var_2;
  var_0.damageinfo[0]._id_4DD8 = var_3;
  var_0.damageinfo[0]._id_1B7C = var_4 &level._id_5039;

  if(isDefined(var_0.damageinfovictim) && var_0.damageinfovictim != var_1) {
    var_0.damageinfocolorindex++;

    if(var_0.damageinfocolorindex == var_5.size) {
      var_0.damageinfocolorindex = 0;
    }
  }

  var_0.damageinfovictim = var_1;
  var_0.damageinfo[0].colorindex = var_0.damageinfocolorindex;

  for(var_6 = 0; var_6 < var_7; var_6++) {
    var_8 = "^" + var_5[var_0.damageinfo[var_6].colorindex];

    if(var_0.damageinfo[var_6]._id_4DD8 != "") {
      var_9 = var_8 + var_0.damageinfo[var_6]._id_4DD8;

      if(var_0.damageinfo[var_6]._id_1B7C) {
        var_9 = var_9 + " (BP)";
      }

      var_0 setclientdvar("ui_hitloc_" + var_6, var_9);
    }

    var_0 setclientdvar("ui_hitloc_damage_" + var_6, var_8 + var_0.damageinfo[var_6].damage);
  }
}

ishardwrireprotected(var_0) {
  if(!maps\mp\_utility::_hasperk("specialty_stun_resistance")) {
    return 0;
  }

  switch (var_0) {
    case "mp_lab_gas":
    case "killstreak_strike_missile_gas_mp":
      return 1;
  }

  return 0;
}

callback_playerdamage_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_1) && var_1 != var_2 && isDefined(var_3) && var_3 > 0) {
    var_1 notify("has_recently_done_damage");

    if(isDefined(var_1.has_recently_done_damage)) {
      var_1.has_recently_done_damage++;
    } else {
      var_1.has_recently_done_damage = 1;
    }
  }

  if(getdvarint("4017", 0) && !_func_367()) {
    return "4017";
  }

  if(_func_367() && isDefined(var_1) && isPlayer(var_1) && !_id_0513::isonevonedamage(var_1, var_2)) {
    return;
  }
  if(maps\mp\_utility::_id_5697(var_5, var_6) && isDefined(var_2) && isDefined(var_2.underwater) && var_2.underwater) {
    return;
  }
  if(issubstr(var_6, "turretweapon_tank_panzer_cannon_mp") && maps\mp\_utility::getmapname() == "mp_raid_dlc3" && isDefined(var_2) && isDefined(var_2.team) && isDefined(game["defenders"]) && var_2.team == game["defenders"]) {
    return;
  }
  var_1 = maps\mp\_utility::_id_073C(var_1);

  if(level.gametype == "infect") {
    if(isDefined(var_1) && isDefined(var_2.pers["team"]) && var_2.pers["team"] == "allies" && isDefined(var_1.pers["team"]) && var_1.pers["team"] == "axis") {
      if(isDefined(var_1.teamchangedthisframe) && var_1.teamchangedthisframe) {
        return;
      }
    }
  }

  if(isDefined(var_5) && var_5 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return "crushed";
  }

  if(!maps\mp\_utility::isreallyalive(var_2) && !isDefined(var_2.inliveplayerkillstreak)) {
    return "!isReallyAlive( victim )";
  }

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing") {
    return "soft_landing";
  }

  if(var_6 == "killstreak_emp_mp") {
    return "sWeapon == killstreak_emp_mp";
  }

  if(var_6 == "killstreak_air_strike_mp" || var_6 == "killstreak_uav_mp" || var_6 == "killstreak_uav_axis_mp") {
    if(isDefined(var_6) && isDefined(var_5) && isDefined(var_1) && isDefined(var_1.name) && isDefined(var_2) && isDefined(var_2.name)) {}
  }

  if(!maps\mp\_utility::_id_585F() && isDefined(var_1) && isDefined(var_1.classname) && issubstr(var_1.classname, "misc_turret")) {
    var_1 = var_1 getturretowner();
  }

  if(var_2 ishardwrireprotected(var_6)) {
    return "specialty_stun_resistance";
  }

  if((var_6 == "emp_grenade_mp" || var_6 == "emp_grenade_killstreak_mp") && var_5 != "MOD_IMPACT") {
    var_2 notify("emp_grenaded", var_1);
  }

  if(isDefined(level.hostmigrationtimer)) {
    return "level.hostMigrationTimer";
  }

  var_11 = maps\mp\_utility::attackerishittingteam(var_2, var_1);

  if(var_5 == "MOD_FALLING") {
    var_2 setclientomnvar("ui_fullscreen_dirt_left", 1);
  }

  if(var_5 == "MOD_EXPLOSIVE_BULLET" && var_3 != 1) {
    var_3 = var_3 * getdvarfloat("scr_explBulletMod");
    var_3 = int(var_3);
  }

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "worldspawn") {
    var_1 = undefined;
  }

  if(isDefined(var_1) && isDefined(var_1.gunner)) {
    var_1 = var_1.gunner;
  }

  if(isDefined(var_1) && var_1 == var_2 && var_6 == "killstreak_strike_missile_gas_mp") {
    return "gasCloudOwner";
  }

  if(isDefined(var_1) && isPlayer(var_1) && _isexplosivedamagemod(var_5) && issubstr(var_6, "explosive_drone") && var_2 maps\mp\_utility::_hasperk("specialty_blastshield2") && maps\mp\_utility::isreallyalive(var_2)) {
    var_2.explosive_drone_owner = var_1;
  }

  var_12 = isDefined(var_1) && isDefined(var_0) && isDefined(var_2) && isPlayer(var_1) && var_1 == var_0 && var_1 == var_2 && !isDefined(var_0._id_754A);
  var_13 = var_6 == "fighter_strike_gun_mp" || maps\mp\_utility::_id_5697(var_5, var_6);

  if(var_12 && !var_13) {
    return "attackerIsInflictorVictim";
  }

  var_14 = 0.0;
  var_15 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

  if(!_isagent(self)) {
    if(isDefined(var_1) && issubstr(var_15, var_5) && var_3 > 0) {
      if(!isDefined(self.damage_info[var_1 getentitynumber()])) {
        self.damage_info[var_1 getentitynumber()] = spawnStruct();
      }

      if(!isDefined(self.damage_info[var_1 getentitynumber()]._id_6875)) {
        self.damage_info[var_1 getentitynumber()]._id_6875 = 0;
      }

      self.damage_info[var_1 getentitynumber()]._id_6875++;
    }
  }

  var_16 = undefined;

  if(level.gametype == "onevone") {
    level._id_6B14 = gettime();
  }

  var_17 = 0;

  if(isDefined(var_2.lightarmorhp)) {
    var_17 = 1;
  }

  if(var_4 &level.idflags_shield_explosive_impact) {
    var_14 = 0.0;
    var_3 = 0.0;
  } else if(var_9 == "shield") {
    var_16 = "hitriotshield";

    if(var_11 && level.friendlyfire == 0) {
      return "attackerIsHittingTeammate";
    }

    if(!var_11 && isDefined(var_2) && isDefined(var_3) && _isnumber(var_3) && issubstr(var_2 getcurrentweapon(), "riotshield_mp")) {
      if(!isDefined(var_2.pers["riotshield_dmg_taken"])) {
        var_2.pers["riotshield_dmg_taken"] = 0;
      }

      var_2.pers["riotshield_dmg_taken"] = var_2.pers["riotshield_dmg_taken"] + var_3;

      if(var_2.pers["riotshield_dmg_taken"] > 400) {
        var_2 _id_047A::riotshielddamagetakenevent();
        var_2.pers["riotshield_dmg_taken"] = 0;
      }
    }

    if(var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET" && !var_11) {
      if(isPlayer(var_1) && isDefined(var_2) && issubstr(var_2 getcurrentweapon(), "riotshield_mp")) {
        var_1.lastattackedshieldplayer = var_2;
        var_1.lastattackedshieldtime = gettime();
      }

      if(maps\mp\_utility::isenvironmentweapon(var_6)) {
        var_18 = 25;
      } else {
        var_18 = _id_052D::cac_modified_damage(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9);
      }

      var_2.shielddamage = var_2.shielddamage + var_18;

      if(!maps\mp\_utility::isenvironmentweapon(var_6) || common_scripts\utility::cointoss()) {
        var_2.shieldbullethits++;

        if(isDefined(var_2.pers["bulletsBlockedByShield"])) {
          var_2.pers["bulletsBlockedByShield"]++;
        }
      }

      if(var_2.shieldbullethits >= level.riotshieldxpbullets) {
        var_2.shielddamage = 0;
        var_2.shieldbullethits = 0;
      }
    }

    if(var_4 &level.idflags_shield_explosive_impact_huge || var_5 == "MOD_IMPACT" && issubstr(var_6, "grenade_launcher") && issubstr(var_6, "alt+")) {
      var_9 = "none";

      if(!(var_4 &level.idflags_shield_explosive_splash)) {
        if(getdvarint("spv_cavalryImpactExplosivesBlocked_enabled", 0) == 1) {
          var_3 = 51;
        }
      }
    } else if(var_4 &level.idflags_no_team_protection) {
      if(isDefined(var_0) && isDefined(var_0.stuckenemyentity) && var_0.stuckenemyentity == var_2 || issubstr(var_6, "explosive_tips_dp28")) {
        var_3 = 150;
      }

      var_9 = "none";
    } else {
      var_1 thread _id_04C7::updatedamagefeedback("hitriotshield");
      return "hit shield";
    }
  } else if(maps\mp\_utility::ismeleemod(var_5)) {
    if(!(var_11 && level.friendlyfire == 0)) {
      if(issubstr(var_6, "riotshield")) {
        var_14 = 0.0;
        var_2 stunplayer(0.0);
      }
    }

    if(_func_367() && isDefined(var_1._id_572A) && var_1._id_572A && isDefined(var_1.current1v1weaponmode) && var_1.current1v1weaponmode == 1) {
      var_3 = 110;
    }

    if(_func_367() && isDefined(var_2) && isDefined(var_1) && isDefined(var_2._id_5692) && var_2._id_5692 && isDefined(var_1._id_5692) && var_1._id_5692 && isDefined(var_2._id_34D2) && isDefined(var_1._id_34D2) && var_2._id_34D2 == var_1 && var_1._id_34D2 == var_2) {
      if(var_2.health - var_3 <= 0) {
        var_2 shellshock("frag_grenade_mp", 2.5);
        var_2 playRumbleOnEntity("artillery_rumble");
      } else if(var_3 > 30) {
        var_2 shellshock("frag_grenade_mp", 1.25);
        var_2 playRumbleOnEntity("heavygun_fire");
      } else {
        var_2 shellshock("frag_grenade_mp", 0.75);
        var_2 playRumbleOnEntity("damage_heavy");
      }
    }
  }

  if(var_6 == "bouncingbetty_mp") {
    var_19 = var_2 getstance();

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

  if(isDefined(var_1) && var_1 == var_2 && var_6 == "teslagunmtx_mp") {
    var_3 = var_3 * 0.5;
  }

  if(!var_11) {
    var_3 = _id_052D::cac_modified_damage(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0);
  } else if(_isexplosivedamagemod(var_5) || var_5 == "MOD_GAS") {
    if(var_2 maps\mp\_utility::_hasperk("specialty_blastshield2") && isDefined(var_2._id_90D4) && !_id_0513::_id_57F6(var_6) && !_id_052D::_id_3154(var_6)) {
      var_3 = int(var_3 * var_2._id_90D4);
    }
  } else if(maps\mp\_utility::_id_5697(var_5, var_6)) {
    if(var_2 maps\mp\_utility::_hasperk("specialty_fireshield") && isDefined(var_2._id_90D8)) {
      var_3 = int(var_3 * var_2._id_90D8);
    }
  }

  if(isDefined(level.modifyplayerdamage)) {
    var_3 = [[level.modifyplayerdamage]](var_2, var_0, var_1, var_3, var_5, var_6, var_7, var_8, var_9, undefined);
  }

  var_20 = isDefined(var_1) && !isDefined(var_1.gunner) && isDefined(var_1.classname) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");
  var_11 = maps\mp\_utility::attackerishittingteam(var_2, var_1);

  if(!var_3) {
    return "!iDamage";
  }

  var_2.idflags = var_4;
  var_2.idflagstime = gettime();

  if(game["state"] == "postgame") {
    return "game[ state ] == postgame";
  }

  if(var_2._id_0179 == "spectator") {
    return "victim.sessionteam == spectator";
  }

  if(isDefined(var_2.candocombat) && !var_2.candocombat) {
    return "!victim.canDoCombat";
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_1.candocombat) && !var_1.candocombat) {
    return "!eAttacker.canDoCombat";
  }

  if(isDefined(var_1) && isalive(var_1) && !isDefined(var_1.perkoutlined)) {
    var_1.perkoutlined = 0;
  }

  if(var_20 && var_11) {
    if(var_5 == "MOD_CRUSH") {
      var_2 maps\mp\_utility::_suicide();
      return "suicide crush";
    }

    if(!level.friendlyfire) {
      return "!level.friendlyfire";
    }
  }

  if(_isai(self)) {
    self[[level.bot_funcs["on_damaged"]]](var_1, var_3, var_5, var_6, var_0, var_9);
  }

  if(!isDefined(var_8)) {
    var_4 = var_4 | level.idflags_no_knockback;
  }

  var_21 = 0;

  if(var_2.health == var_2.maxhealth && (!isDefined(var_2._id_00E8) || !var_2._id_00E8) || !isDefined(var_2.attackers) && !isDefined(var_2._id_00E8)) {
    var_2.attackers = [];
    var_2.attackerdata = [];
  }

  if(maps\mp\_utility::isheadshot(var_6, var_9, var_5, var_1)) {
    var_5 = "MOD_HEAD_SHOT";
  }

  if(_id_0511::gettweakablevalue("game", "onlyheadshots")) {
    if(var_5 == "MOD_PISTOL_BULLET" || var_5 == "MOD_RIFLE_BULLET" || var_5 == "MOD_EXPLOSIVE_BULLET") {
      return "getTweakableValue( game, onlyheadshots )";
    } else if(var_5 == "MOD_HEAD_SHOT") {
      var_3 = 150;
    }
  }

  if(maps\mp\_utility::ismeleemod(var_5) && isPlayer(var_2) && var_2 getstance() == "prone") {
    var_3 = 150;
  }

  if(var_6 == "none" && isDefined(var_0)) {
    if(isDefined(var_0._id_0075) && issubstr(var_0._id_0075, "vehicle_")) {
      var_6 = "destructible_car";
    }
  }

  if(isDefined(level._id_5CC7) && isDefined(level._id_5CC7[var_2._id_5CC6]) && gettime() < level._id_5CC7[var_2._id_5CC6] + level._id_5A77) {
    var_22 = int(max(var_2.health / 4, 1));

    if(var_3 >= var_22 && maps\mp\_utility::iskillstreakweapon(var_6) && !maps\mp\_utility::ismeleemod(var_5)) {
      var_3 = var_22;

      if(var_6 == "firebomb_flames_mp") {
        var_3 = 2;
      }
    }
  }

  if(!(var_4 &level.idflags_passthru)) {
    if(!level.teambased && var_20 && isDefined(var_1._id_0117) && var_1._id_0117 == var_2) {
      if(var_5 == "MOD_CRUSH") {
        var_2 maps\mp\_utility::_suicide();
      }

      return "ffa suicide";
    }

    if((issubstr(var_5, "MOD_GRENADE") || issubstr(var_5, "MOD_EXPLOSIVE") || issubstr(var_5, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1)) {
      if(var_2 != var_1 && var_0.classname == "grenade" && var_2._id_5BE2 + 3500 > gettime() && isDefined(var_2.lastspawnpoint) && distance(var_0.origin, var_2.lastspawnpoint.origin) < 250) {
        return "spawnkill grenade protection";
      }

      var_2.explosiveinfo = [];
      var_2.explosiveinfo["damageTime"] = gettime();
      var_2.explosiveinfo["damageId"] = var_0 getentitynumber();
      var_2.explosiveinfo["returnToSender"] = 0;
      var_2.explosiveinfo["counterKill"] = 0;
      var_2.explosiveinfo["chainKill"] = 0;
      var_2.explosiveinfo["cookedKill"] = 0;
      var_2.explosiveinfo["throwbackKill"] = 0;
      var_2.explosiveinfo["suicideGrenadeKill"] = 0;
      var_2.explosiveinfo["midAirDetonate"] = 0;
      var_2.explosiveinfo["weapon"] = var_6;
      var_23 = issubstr(var_6, "frag_");

      if(var_1 != var_2) {
        if((issubstr(var_6, "c4_") || issubstr(var_6, "claymore_")) && isDefined(var_1) && isDefined(var_0._id_0117)) {
          var_2.explosiveinfo["returnToSender"] = var_0._id_0117 == var_2;
          var_2.explosiveinfo["counterKill"] = isDefined(var_0.wasdamaged);
          var_2.explosiveinfo["chainKill"] = isDefined(var_0.waschained);
          var_2.explosiveinfo["bulletPenetrationKill"] = isDefined(var_0.wasdamagedfrombulletpenetration);
          var_2.explosiveinfo["cookedKill"] = 0;
        }

        if(isDefined(var_1.lastgrenadesuicidetime) && var_1.lastgrenadesuicidetime >= gettime() - 50 && var_23) {
          var_2.explosiveinfo["suicideGrenadeKill"] = 1;
        }

        if(var_23) {
          var_2.explosiveinfo["cookedKill"] = isDefined(var_0.iscooked);
          var_2.explosiveinfo["throwbackKill"] = isDefined(var_0.threwback);
        }
      }

      var_2.explosiveinfo["stickKill"] = isDefined(var_0.isstuck) && var_0.isstuck == "enemy";
      var_2.explosiveinfo["stickFriendlyKill"] = isDefined(var_0.isstuck) && var_0.isstuck == "friendly";

      if(isDefined(var_0) && var_0.classname == "grenade" && !isDefined(var_0.missile_stuck)) {
        var_24 = bulletTrace(var_0.origin, var_0.origin - (0, 0, 100), 0, var_0);

        if(var_0.origin[2] > var_24["position"][2] + 5) {
          var_2.explosiveinfo["midAirDetonate"] = 1;
        }
      }

      if(isPlayer(var_1) && var_1 != self) {
        maps\mp\gametypes\_gamelogic::setinflictorstat(var_0, var_1, var_6);
      }
    }

    if(issubstr(var_5, "MOD_IMPACT") && issubstr(var_6, "gl")) {
      if(isPlayer(var_1) && var_1 != self) {
        maps\mp\gametypes\_gamelogic::setinflictorstat(var_0, var_1, var_6);
      }
    }

    if(isPlayer(var_1) && isDefined(var_1.pers["participation"])) {
      var_1.pers["participation"]++;
    } else if(isPlayer(var_1)) {
      var_1.pers["participation"] = 1;
    }

    if(var_11) {
      if(_func_367()) {
        if(isDefined(var_1._id_4E03) && isDefined(var_2._id_4E03) && common_scripts\utility::_id_0F79(var_1._id_4E03, var_2) && common_scripts\utility::_id_0F79(var_2._id_4E03, var_1) || var_1 == var_2 && isDefined(var_1._id_5729) && var_1._id_5729) {
          if(var_3 < 1) {
            var_3 = 1;
          }

          if(isDefined(var_1._id_34D2) && var_1._id_34D2 == var_2) {
            if(var_2.health - var_3 <= 0) {
              var_3 = var_2.health - 1;
              var_2 notify("lostDuel");
            } else
              var_2 notify("updateDuelHealthDisplay");
          }

          var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);

          if(isDefined(var_1) && var_1 != var_2 && isDefined(var_9)) {
            if(!maps\mp\_utility::isreallyalive(var_2)) {
              if(maps\mp\_utility::ismeleemod(var_5)) {
                var_25 = "killshot_nosound";
              } else if(var_9 == "head") {
                var_25 = "killshot_headshot";
              } else {
                var_25 = "killshot";
              }
            } else if(isDefined(var_16))
              var_25 = var_16;
            else if(maps\mp\_utility::ismeleemod(var_5)) {
              var_25 = "standard_nosound";
            } else if(var_9 == "head") {
              var_25 = "headshot";
            } else if(var_3 < _func_2F9(maps\mp\_utility::_id_4431(var_6))) {
              var_25 = "minor";
            } else if(!shouldweaponfeedback(var_6)) {
              var_25 = "none";
            } else {
              var_25 = "standard";
            }

            var_1 thread _id_04C7::updatedamagefeedback(var_25);
          }

          return;
        }
      }

      if(level.friendlyfire == 0 || !isPlayer(var_1) && level.friendlyfire != 1 || shouldignorefriendlyfireforhardcore(var_6, var_1)) {
        if(var_6 == "artillery_mp" || var_6 == "airstrike_bomb_mp" || var_6 == "airstrike_bomb_axis_mp" || var_6 == "firebomb_bomb_mp" || var_6 == "firebomb_bomb_axis_mp" || var_6 == "firebomb_bomb_grenadier_mp" || var_6 == "firebomb_bomb_axis_grenadier_mp") {
          var_2 damageshellshockandrumble(var_0, var_6, var_5, var_3, var_4, var_1);
        }

        return "friendly fire";
      } else if(level.friendlyfire == 1) {
        if(var_3 < 1) {
          var_3 = 1;
        }

        var_2.lastdamagewasfromenemy = 0;
        var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
      } else if(level.friendlyfire == 2 && maps\mp\_utility::isreallyalive(var_1)) {
        var_3 = int(var_3 * 0.5);

        if(var_3 < 1) {
          var_3 = 1;
        }

        var_1.lastdamagewasfromenemy = 0;
        var_1.friendlydamage = 1;
        var_1 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
        var_1.friendlydamage = undefined;
      } else if(level.friendlyfire == 3 && maps\mp\_utility::isreallyalive(var_1)) {
        var_3 = int(var_3 * 0.5);

        if(var_3 < 1) {
          var_3 = 1;
        }

        var_2.lastdamagewasfromenemy = 0;
        var_1.lastdamagewasfromenemy = 0;
        var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);

        if(maps\mp\_utility::isreallyalive(var_1)) {
          var_1.friendlydamage = 1;
          var_1 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
          var_1.friendlydamage = undefined;
        }
      }

      var_21 = 1;
    } else {
      if(var_3 < 1 && !_func_367()) {
        var_3 = 1;
      }

      if(_func_367() && isDefined(var_1) && isDefined(var_2) && var_1 == var_2 && isDefined(var_1._id_5721) && var_1._id_5721) {
        var_3 = 0;
      }

      _id_5E8A(var_2, var_1, var_0, var_6, var_3, var_7, var_8, var_9, var_10, var_5);

      if(issubstr(var_5, "MOD_GRENADE") && isDefined(var_0) && isDefined(var_0.iscooked)) {
        var_2.wascooked = gettime();
      } else {
        var_2.wascooked = undefined;
      }

      if(issubstr(var_5, "MOD_IMPACT") && isDefined(var_0) && isDefined(var_0.recall) && var_0.recall) {
        var_2.wasrecall = 1;
      } else {
        var_2.wasrecall = 0;
      }

      var_2.lastdamagewasfromenemy = isDefined(var_1) && var_1 != var_2;

      if(var_2.lastdamagewasfromenemy) {
        var_26 = gettime();
        var_1.damagedplayers[var_2.guid] = var_26;
        var_2._id_5B8A = var_26;
      }

      var_2 finishplayerdamagewrapper(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
      var_2 thread maps\mp\gametypes\_missions::playerdamaged(var_0, var_1, var_3, var_5, var_6, var_9);
    }

    if(!maps\mp\_utility::isreallyalive(var_2)) {
      if((issubstr(var_5, "MOD_GRENADE") || issubstr(var_5, "MOD_EXPLOSIVE") || issubstr(var_5, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1)) {
        var_2 _id_04EB::_id_2E43(var_8);
      }

      if(isDefined(var_2.lastdamagewasfromenemy) && var_2.lastdamagewasfromenemy) {
        level notify("normal_enemy_kill");
      }
    }

    if(var_20 && isDefined(var_1.gunner)) {
      var_27 = var_1.gunner;
    } else {
      var_27 = var_1;
    }

    var_28 = undefined;

    if(isDefined(var_27)) {
      var_28 = var_27 _meth_85E2();
    }

    if(isDefined(var_27) && (var_27 != var_2 || maps\mp\_utility::iskillstreakweapon(var_6)) && var_3 > 0 && (!isDefined(var_9) || var_9 != "shield")) {
      if(!maps\mp\_utility::isreallyalive(var_2) || _isagent(var_2) && isDefined(var_2._id_0A4B) && var_2._id_0A4B == "paratroopers" && var_2.health - var_3 <= 0) {
        if(maps\mp\_utility::ismeleemod(var_5)) {
          var_25 = "killshot_nosound";
        } else if(isDefined(var_6) && issubstr(var_6, "throwingknife_mp")) {
          var_25 = "throwingknife";
        } else if(var_9 == "head") {
          var_25 = "killshot_headshot";
        } else {
          var_25 = "killshot";
        }
      } else if(isDefined(var_16))
        var_25 = var_16;
      else if(level.gametype == "br") {
        var_25 = "hitmorehealth";
      } else if(common_scripts\utility::_id_562E(var_2._id_4B97)) {
        var_25 = "hitlightarmor";
      } else if(maps\mp\_utility::ismeleemod(var_5)) {
        var_25 = "standard_nosound";
      } else if(var_4 &level.idflags_shield_explosive_impact) {
        var_25 = "stun";
      } else if(maps\mp\_utility::isbulletdamage(var_5) && var_2 maps\mp\_utility::_hasperk("specialty_armorvest")) {
        var_25 = "hitjuggernaut";
      } else if(maps\mp\_utility::isbulletdamage(var_5) && isDefined(var_2._id_4B9A) && var_2._id_4B9A) {
        var_25 = "hitjuggernaut";
      } else if(_isexplosivedamagemod(var_5) && isDefined(var_2._id_4B64) && var_2._id_4B64) {
        var_25 = "hitlightarmor";
      } else if(_id_0513::_id_57F6(var_6) && var_2 maps\mp\_utility::_hasperk("specialty_stun_resistance")) {
        var_25 = "hittacticalmask";
      } else if(_isexplosivedamagemod(var_5) && var_2 maps\mp\_utility::_hasperk("specialty_blastshield2") && !_id_0513::_id_57F6(var_6) && !_id_052D::_id_3154(var_6)) {
        var_25 = "hitblastshield";
      } else if(maps\mp\_utility::_id_5697(var_5) && var_2 maps\mp\_utility::_hasperk("specialty_fireshield")) {
        var_25 = "hitfireshield";
      } else if(isDefined(var_2.raidmaniac) && var_2.raidmaniac || isDefined(var_2.raidcombatbuff) && var_2.raidcombatbuff) {
        var_25 = "hitlightarmor";
      } else if(var_9 == "head") {
        var_25 = "headshot";
      } else if(var_17 && var_5 != "MOD_HEAD_SHOT" && !maps\mp\_utility::isfmjdamage(var_6, var_5, var_1)) {
        var_25 = "hitlightarmor";
      } else if(var_3 < _func_2F9(maps\mp\_utility::_id_4431(var_6))) {
        var_25 = "minor";
      } else if(!shouldweaponfeedback(var_6)) {
        var_25 = "none";
      } else {
        var_25 = "standard";
      }

      if(!isDefined(var_28) || isDefined(var_28) && var_28 _meth_8564() != "plane") {
        var_27 thread _id_04C7::updatedamagefeedback(var_25);
      }
    }

    maps\mp\gametypes\_gamelogic::sethasdonecombat(var_2, 1);
  }

  if(isDefined(var_1) && var_1 != var_2 && !var_21) {
    level.usestartspawns = 0;
  }

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

    if(isDefined(var_0) && isDefined(var_0._id_5CC6) && var_0._id_5CC6 != -1) {
      var_39 = var_0._id_5CC6;
    } else {
      var_39 = var_1._id_5CC6;
    }
  } else {
    var_37 = "world";
    var_38 = var_2.origin;
    var_39 = -1;
  }

  var_40 = gettime();

  if(var_2.sessionstate != "dead") {
    if(!_isagent(var_2) && var_5 != "MOD_FALLING" && var_5 != "MOD_SUICIDE" && (!isDefined(var_1) || var_1 != var_2)) {
      var_41 = (var_40 - level._id_5CC7[var_2._id_5CC6]) / 1000.0;

      if(var_2._id_90AE < 0) {
        var_2._id_90AE = var_41;
      }

      if(var_41 <= 3.0 && isDefined(var_2.spawninfo) && var_2.spawninfo.damagereceivedtoofast == 0) {
        if(isDefined(var_2.pers["immediateActionSpawnCount"])) {
          var_2.pers["immediateActionSpawnCount"]++;
        }

        if(isDefined(var_1) && isDefined(var_1.pers) && isDefined(var_1.pers["causedImmediateActionSpawnCount"])) {
          var_1.pers["causedImmediateActionSpawnCount"]++;
        }

        if(!isDefined(level.matchdata)) {
          level.matchdata = [];
        }

        if(!isDefined(game["trapSpawnDmgReceivedCount"])) {
          game["trapSpawnDmgReceivedCount"] = 1;
        } else {
          game["trapSpawnDmgReceivedCount"]++;
        }

        var_2.spawninfo.damagereceivedtoofast = 1;

        if(var_2.spawninfo._id_9CFD == 0) {
          if(!isDefined(game["trapSpawnByAnyMeansCount"])) {
            game["trapSpawnByAnyMeansCount"] = 1;
          } else {
            game["trapSpawnByAnyMeansCount"]++;
          }

          if(isDefined(var_2.pers["badSpawnByAnyMeansCount"])) {
            var_2.pers["badSpawnByAnyMeansCount"]++;
          }

          if(isDefined(var_1) && isDefined(var_1.pers) && isDefined(var_1.pers["causedBadSpawnByAnyMeansCount"])) {
            var_1.pers["causedBadSpawnByAnyMeansCount"]++;
          }

          var_2.spawninfo._id_9CFD = 1;
        }
      }
    } else
      var_41 = -1;

    if(isDefined(var_1) && isPlayer(var_1) && var_5 != "MOD_FALLING" && var_5 != "MOD_SUICIDE" && (!isDefined(var_2) || var_1 != var_2)) {
      var_42 = (var_40 - level._id_5CC7[var_39]) / 1000.0;

      if(var_1._id_90AD < 0) {
        var_1._id_90AD = var_42;
      }

      if(var_42 <= 3.0 && var_1.spawninfo._id_29BA == 0) {
        if(isDefined(var_1) && isDefined(var_1.pers["immediateActionSpawnCount"])) {
          var_1.pers["immediateActionSpawnCount"]++;
        }

        if(!isDefined(level.matchdata)) {
          level.matchdata = [];
        }

        if(!isDefined(game["trapSpawnDmgDealtCount"])) {
          game["trapSpawnDmgDealtCount"] = 1;
        } else {
          game["trapSpawnDmgDealtCount"]++;
        }

        var_1.spawninfo._id_29BA = 1;

        if(var_1.spawninfo._id_9CFD == 0) {
          if(!isDefined(game["trapSpawnByAnyMeansCount"])) {
            game["trapSpawnByAnyMeansCount"] = 1;
          } else {
            game["trapSpawnByAnyMeansCount"]++;
          }

          if(isDefined(var_1) && isDefined(var_1.pers["badSpawnByAnyMeansCount"])) {
            var_1.pers["badSpawnByAnyMeansCount"]++;
          }

          var_1.spawninfo._id_9CFD = 1;
        }
      }
    } else
      var_42 = -1;

    if(!_isagent(var_2)) {
      _reconspatialevent(var_2.origin, "script_mp_damage: player_name %s, player_angles %v, hit_loc %s, attacker_name %s, attacker_pos %v, damage %d, weapon %s, damage_type %s, gameTime %d, life_id %d, attacker_life_id %d, spawnToDamageReceivedTime %f, spawnToDamageDealtTime %f", var_2.name, var_2.angles, var_9, var_37, var_38, var_3, var_6, var_5, var_40, var_2._id_5CC6, var_39, var_41, var_42);

      if(isDefined(level._id_73CD)) {
        [[level._id_73CD]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
      }
    }

    _logprint("D;" + var_32 + ";" + var_29 + ";" + var_31 + ";" + var_30 + ";" + var_35 + ";" + var_34 + ";" + var_33 + ";" + var_36 + ";" + var_6 + ";" + var_3 + ";" + var_5 + ";" + var_9 + "\n");
  } else {
    if(!_isagent(var_2) && var_2._id_90AE < 0) {
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

  hitlocdebug(var_1, var_2, var_3, var_9, var_4);

  if(_isagent(self)) {
    self[[maps\mp\agents\_agent_utility::_id_0A59("on_damaged_finished")]](var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, "");
  }

  return "finished";
}

_id_118E(var_0, var_1) {
  var_2 = !isDefined(var_0) || var_0 getentitynumber() == _worldentnumber();
  var_3 = maps\mp\_utility::iskillstreakweapon(var_1);

  if(var_2 && var_3) {
    return 1;
  }

  return 0;
}

shouldweaponfeedback(var_0) {
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
  if(!level.hardcoremode) {
    return 0;
  }

  if(getdvarint("scr_hardcore_StreaksTeamKill", 0) != 0) {
    return 0;
  }

  if(_isagent(var_1) && isDefined(var_1._id_0A4B) && var_1._id_0A4B == "paratroopers") {
    return 1;
  }

  if(!isDefined(var_0) || !maps\mp\_utility::iskillstreakweapon(var_0)) {
    return 0;
  }

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
  if(!isDefined(var_0.attackerdata)) {
    var_0.attackerdata = [];
  }

  if(!isDefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_1;
    var_0.attackerdata[var_1.guid] = spawnStruct();
    var_0.attackerdata[var_1.guid].damage = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_1;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid]._id_A9DF = [];
    var_0.attackerdata[var_1.guid]._id_4DD5 = 1;
    var_0.attackerdata[var_1.guid]._id_4DE6 = [];
    var_0.attackerdata[var_1.guid]._id_4DD6 = [];
    var_10 = anglesToForward((0, var_0.angles[1], 0));
    var_11 = var_0.origin - var_1.origin;
    var_11 = vectorNormalize((var_11[0], var_11[1], 0));
    var_12 = vectordot(var_10, var_11);
    var_13 = var_12 * -1;
    var_14 = 0;

    if(var_13 >= _cos(getdvarint("cg_fov", 65))) {
      var_14 = 1;
    }

    if(var_9 == "MOD_EXPLOSIVE" || var_9 == "MOD_GRENADE" || var_9 == "MOD_GRENADE_SPLASH" || var_9 == "MOD_PROJECTILE_SPLASH" || var_9 == "MOD_PROJECTILE" || var_9 == "MOD_MELEE" || var_9 == "MOD_MELEE_ALT" || var_9 == "MOD_MELEE_DOG" || maps\mp\_utility::_id_5697(var_9, var_3) || var_9 == "MOD_SUICIDE" || var_9 == "MOD_IMPACT" || var_9 == "MOD_TRIGGER_HURT" || var_9 == "MOD_FALLING" || var_9 == "MOD_CRUSH" || isDefined(level.killstreakwieldweapons) && isDefined(level.killstreakwieldweapons[var_3])) {
      var_14 = -1;
    }

    var_0.attackerdata[var_1.guid]._id_3C67 = var_14;
  } else
    var_0.attackerdata[var_1.guid]._id_4DD5++;

  if(_id_0513::isprimaryweapon(var_3) && !_id_0513::issidearm(var_3)) {
    var_0.attackerdata[var_1.guid].isprimary = 1;
  }

  if(!isDefined(var_0.attackerdata[var_1.guid]._id_A9DF[var_3])) {
    var_0.attackerdata[var_1.guid]._id_A9DF[var_3] = var_3;
  }

  var_15 = var_0.attackerdata[var_1.guid]._id_4DD5;
  var_0.attackerdata[var_1.guid].damage = var_0.attackerdata[var_1.guid].damage + var_4;
  var_0.attackerdata[var_1.guid]._id_01D0 = var_3;
  var_0.attackerdata[var_1.guid].vpoint = var_5;
  var_0.attackerdata[var_1.guid].vdir = var_6;
  var_0.attackerdata[var_1.guid].shitloc = var_7;
  var_0.attackerdata[var_1.guid]._id_014A = var_8;
  var_0.attackerdata[var_1.guid].smeansofdeath = var_9;
  var_0.attackerdata[var_1.guid].attackerent = var_1;
  var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();
  var_0.attackerdata[var_1.guid]._id_4DE6[var_15 - 1] = var_3;
  var_0.attackerdata[var_1.guid]._id_4DD6[var_15 - 1] = var_4;

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.primaryweapon)) {
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
  } else if(isDefined(var_1) && isPlayer(var_1) && var_1 getcurrentprimaryweapon() != "none") {
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_1 getcurrentprimaryweapon();
  } else {
    var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
  }

  if(!isDefined(var_1._id_A491)) {
    var_1._id_A491 = [];
  }

  if(!isDefined(var_1._id_A491[var_0.guid])) {
    var_1._id_A495[var_0.guid] = var_0;
  }

  var_1._id_A491[var_0.guid] = var_0.attackerdata[var_1.guid];
  var_1._id_A491[var_0.guid]._id_A492 = var_0;
  var_1._id_A491[var_0.guid]._id_A493 = var_0._id_5CC6;

  if(!isDefined(var_1._id_29B9)) {
    var_1._id_29B9 = 0;
  }

  if(!isDefined(var_0._id_29DA)) {
    var_0._id_29DA = 0;
  }

  var_1._id_29B9 = var_1._id_29B9 + var_4;
  var_0._id_29DA = var_0._id_29DA + var_4;
}

resetattackerlist() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 1.75;
  self.attackers = [];
  self.attackerdata = [];
}

_id_5E8A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_099A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1._id_0117) && (!isDefined(var_1.isfiringturret) || !var_1.isfiringturret)) {
    _id_099A(var_0, var_1._id_0117, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1.botgetscriptgoalyaw) && isDefined(var_1.isfiringturret) && var_1.isfiringturret) {
    _id_099A(var_0, var_1.botgetscriptgoalyaw, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_2) && isDefined(var_2._id_0117) && isDefined(var_2._id_0117.guid)) {
    var_10 = var_2._id_0117.team != var_0.team || level.friendlyfire == 1;

    if(var_10 && !isDefined(self.attackerdata[var_2._id_0117.guid])) {
      _id_099A(var_0, var_2._id_0117, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }

  if(isDefined(var_1)) {
    level._id_5BB7 = var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3)) {
    var_1 thread _id_0513::checkhit(var_3, var_9, var_0);
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3) && var_1 != var_0) {
    var_0.attackerposition = var_1.origin;
  } else {
    var_0.attackerposition = undefined;
  }
}

_id_A106(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_6, var_4 in var_0) {
      if(!isPlayer(var_4)) {
        continue;
      }
      var_5 = var_4 getentitynumber();
      self setclientomnvar("ui_death_details_attacker_" + var_2, var_5);
      self setclientomnvar("ui_death_details_hits_" + var_2, int(_min(var_1[var_6]._id_4DD5, 10)));
      var_2++;

      if(var_2 >= 4) {
        break;
      }
    }
  }

  for(var_7 = var_2; var_7 < 4; var_7++) {
    self setclientomnvar("ui_death_details_attacker_" + var_7, -1);
  }
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
  if(common_scripts\utility::_id_562E(var_0._id_5D9F) && !self isragdoll()) {
    if(isDefined(var_0.team) && isDefined(var_1.team) && var_0.team != var_1.team) {
      self notify("force_start_ragdoll");
    }
  }
}

callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = callback_playerdamage_internal(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

finishplayerdamagewrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(level._id_6B77)) {
    self[[level._id_6B77]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  var_11 = 0;

  if(maps\mp\_utility::isusingremote() && var_2 >= self.health && !(var_3 &level.idflags_shield_explosive_impact) && !isDefined(self.inliveplayerkillstreak) && !self isgod()) {
    var_11 = 1;
  }

  if(var_11 || maps\mp\_utility::isrocketcorpse()) {
    if(!isDefined(var_7)) {
      var_7 = (0, 0, 0);
    }

    if(!isDefined(var_1) && !isDefined(var_0)) {
      var_1 = self;
      var_0 = var_1;
    }

    playerkilled_internal(var_0, var_1, self, var_2, var_4, var_5, var_7, var_8, var_9, 0, 1);
  } else {
    if(!callback_killingblow(var_0, var_1, var_2 - var_2 * var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    if(isPlayer(self)) {
      var_12 = self finishplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

      if(isDefined(var_12)) {
        if(var_4 != "MOD_FALLING") {
          self setclientomnvar("ui_damage_flash", 1);
        }

        if(!common_scripts\utility::_id_562E(level.disableplayerdamageimpactfx)) {
          thread finishplayerdamage_impactfxwrapper(var_12[0], var_12[1], var_12[2], var_12[3], var_12[4], var_12[5], var_12[6]);
        }
      }
    }
  }

  if(var_4 == "MOD_EXPLOSIVE_BULLET") {
    self shellshock("damage_mp", getdvarfloat("scr_csmode"));
  }

  damageshellshockandrumble(var_0, var_5, var_4, var_2, var_3, var_1);
}

finishplayerdamage_impactfxwrapper(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  waittillframeend;

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  self finishplayerdamage_impactfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

callback_playerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9.einflictor = var_0;
  var_9.attacker = var_1;
  var_9.idamage = var_2;
  var_9.attackerposition = var_1.origin;

  if(var_1 == self) {
    var_9.smeansofdeath = "MOD_SUICIDE";
  } else {
    var_9.smeansofdeath = var_3;
  }

  var_9.sweapon = var_4;

  if(isDefined(var_1) && isPlayer(var_1) && var_1 getcurrentprimaryweapon() != "none") {
    var_9.sprimaryweapon = var_1 getcurrentprimaryweapon();
  } else {
    var_9.sprimaryweapon = undefined;
  }

  var_9.vdir = var_5;
  var_9.shitloc = var_6;
  var_9.laststandstarttime = gettime();
  var_10 = maydolaststand(var_4, var_3, var_6);

  if(isDefined(self.endgame)) {
    var_10 = 0;
  }

  if(level.teambased && isDefined(var_1.team) && var_1.team == self.team) {
    var_10 = 0;
  }

  if(level.diehardmode) {
    if(level.teamcount[self.team] <= 1) {
      var_10 = 0;
    } else if(maps\mp\_utility::isteaminlaststand()) {
      var_10 = 0;
      maps\mp\_utility::killteaminlaststand(self.team);
    }
  }

  if(!var_10) {
    self.laststandparams = var_9;
    self.uselaststandparams = 1;
    maps\mp\_utility::_suicide();
  } else {
    self.inlaststand = 1;
    var_11 = spawnStruct();

    if(maps\mp\_utility::_hasperk("specialty_finalstand")) {
      var_11.titletext = game["strings"]["final_stand"];
      var_11.iconname = level.specialty_finalstand_icon;
    } else {
      var_11.titletext = game["strings"]["last_stand"];
      var_11.iconname = level.specialty_finalstand_icon;
    }

    var_11.glowcolor = (1, 0, 0);
    var_11.sound = "mp_last_stand";
    var_11.duration = 2.0;
    self.health = 1;
    thread maps\mp\gametypes\_hud_message::notifymessage(var_11);
    var_12 = "frag_grenade_mp";

    if(maps\mp\_utility::_hasperk("specialty_finalstand")) {
      self.laststandparams = var_9;
      self.infinalstand = 1;
      var_13 = self getweaponslistexclusives();

      foreach(var_15 in var_13) {
        self takeweapon(var_15);
      }

      common_scripts\utility::_id_0601();
      thread enablelaststandweapons();
      thread laststandtimer(20, 1);
    } else {
      if(level.diehardmode) {
        var_1 thread _id_047A::killedplayerevent(self, var_4, var_3);
        self.laststandparams = var_9;
        common_scripts\utility::_id_0602();
        thread laststandtimer(20, 0);
        common_scripts\utility::_id_0601();
        return;
      }

      self.laststandparams = var_9;
      var_17 = undefined;
      var_18 = self getweaponlistprimaries();

      foreach(var_15 in var_18) {
        if(_id_0513::issidearm(var_15) && var_15 != "combatknife_mp") {
          var_17 = var_15;
        }
      }

      if(!isDefined(var_17)) {
        var_17 = "m1911_mp";
        maps\mp\_utility::_giveweapon(var_17);
      }

      self givemaxammo(var_17);
      self disableweaponswitch();
      common_scripts\utility::_id_0601();

      if(!maps\mp\_utility::_hasperk("specialty_laststandoffhand")) {
        self disableoffhandweapons();
      }

      self switchtoweapon(var_17);
      thread laststandtimer(10, 0);
    }
  }
}

dieaftertime(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  wait(var_0);
  self.uselaststandparams = 1;
  maps\mp\_utility::_suicide();
}

detonateonuse() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self waittill("detonate");
  self.uselaststandparams = 1;
  c4deathdetonate();
}

detonateondeath() {
  self endon("detonate");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self waittill("death");
  c4deathdetonate();
}

c4deathdetonate() {
  self playSound("detpack_explo_default");
  self.c4deatheffect = playFX(level.c4death, self.origin);
  radiusdamage(self.origin, 312, 100, 100, self);

  if(isalive(self)) {
    maps\mp\_utility::_suicide();
  }
}

enablelaststandweapons() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::freezecontrolswrapper(1);
  wait 0.3;
  maps\mp\_utility::freezecontrolswrapper(0);
}

laststandtimer(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  self notify("player_last_stand");
  thread laststandwaittilldeath();
  self._id_00E8 = 1;

  if(!var_1 && (!isDefined(self.inc4death) || !self.inc4death) && (!isDefined(var_2) || !var_2)) {
    thread laststandallowsuicide();
    maps\mp\_utility::setlowermessage("last_stand", &"PLATFORM_COWARDS_WAY_OUT", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    thread laststandkeepoverlay();
  }

  if(level.diehardmode == 1 && level.diehardmode != 2 && (!isDefined(var_2) || !var_2)) {
    var_3 = spawn("script_model", self.origin);
    var_3 setModel("tag_origin");
    var_3 setCursorHint("HINT_NOICON");
    var_3 setHintString(&"PLATFORM_REVIVE");
    var_3 _id_7E61(self);
    var_3 endon("death");
    var_4 = _newteamhudelem(self.team);
    var_4 setshader("waypoint_revive", 8, 8);
    var_4 setwaypoint(1, 1);
    var_4 settargetEnt(self);
    var_4 thread destroyonreviveentdeath(var_3);
    var_4.color = (0.33, 0.75, 0.24);
    maps\mp\_utility::playdeathsound();

    if(var_1) {
      wait(var_0);

      if(self.infinalstand) {
        thread laststandbleedout(var_1, var_3);
      }
    }

    return;
  } else if(level.diehardmode == 2 && (!isDefined(var_2) || !var_2)) {
    thread laststandkeepoverlay();
    var_3 = spawn("script_model", self.origin);
    var_3 setModel("tag_origin");
    var_3 setCursorHint("HINT_NOICON");
    var_3 setHintString(&"PLATFORM_REVIVE");
    var_3 _id_7E61(self);
    var_3 endon("death");
    var_4 = _newteamhudelem(self.team);
    var_4 setshader("waypoint_revive", 8, 8);
    var_4 setwaypoint(1, 1);
    var_4 settargetEnt(self);
    var_4 thread destroyonreviveentdeath(var_3);
    var_4.color = (0.33, 0.75, 0.24);
    maps\mp\_utility::playdeathsound();

    if(var_1) {
      wait(var_0);

      if(self.infinalstand) {
        thread laststandbleedout(var_1, var_3);
      }
    }

    wait(var_0 / 3);
    var_4.color = (1, 0.64, 0);

    while(var_3.inuse) {
      waitframe();
    }

    maps\mp\_utility::playdeathsound();
    wait(var_0 / 3);
    var_4.color = (1, 0, 0);

    while(var_3.inuse) {
      waitframe();
    }

    maps\mp\_utility::playdeathsound();
    wait(var_0 / 3);

    while(var_3.inuse) {
      waitframe();
    }

    waitframe();
    thread laststandbleedout(var_1);
    return;
  }

  if(!isDefined(var_2) || !var_2) {
    thread laststandkeepoverlay();
  }

  wait(var_0);
  thread laststandbleedout(var_1);
}

maxhealthoverlay(var_0, var_1) {
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

laststandbleedout(var_0, var_1) {
  if(var_0) {
    self._id_00E8 = undefined;
    self.infinalstand = 0;
    self notify("revive");
    maps\mp\_utility::clearlowermessage("last_stand");
    maps\mp\gametypes\_playerlogic::laststandrespawnplayer();

    if(isDefined(var_1)) {
      var_1 delete();
    }
  } else {
    self.uselaststandparams = 1;
    self.beingrevived = 0;
    maps\mp\_utility::_suicide();
  }
}

laststandallowsuicide() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("revive");

  for(;;) {
    if(self useButtonPressed()) {
      var_0 = gettime();

      while(self useButtonPressed()) {
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

  thread laststandbleedout(0);
}

laststandkeepoverlay() {
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

laststandwaittilldeath() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");
  maps\mp\_utility::clearlowermessage("last_stand");
  self._id_00E8 = undefined;
}

maydolaststand(var_0, var_1, var_2) {
  if(var_1 == "MOD_TRIGGER_HURT") {
    return 0;
  }

  if(var_1 != "MOD_PISTOL_BULLET" && var_1 != "MOD_RIFLE_BULLET" && var_1 != "MOD_FALLING" && var_1 != "MOD_EXPLOSIVE_BULLET") {
    return 0;
  }

  if(var_1 == "MOD_IMPACT" && (var_0 == "throwingknife_mp" || var_0 == "throwingknifejugg_mp")) {
    return 0;
  }

  if(var_1 == "MOD_IMPACT" && (var_0 == "m79_mp" || issubstr(var_0, "gl_"))) {
    return 0;
  }

  if(maps\mp\_utility::isheadshot(var_0, var_2, var_1)) {
    return 0;
  }

  if(maps\mp\_utility::isusingremote()) {
    return 0;
  }

  return 1;
}

ensurelaststandparamsvalidity() {
  if(!isDefined(self.laststandparams.attacker)) {
    self.laststandparams.attacker = self;
  }
}

gethitlocheight(var_0) {
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

gethitloctag(var_0) {
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

delaystartragdoll(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = var_0 getcorpseanim();

    if(_animhasnotetrack(var_6, "ignore_ragdoll")) {
      return;
    }
  }

  if(isDefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_8 in level.noragdollents) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536) {
        return;
      }
    }
  }

  wait 0.2;

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 isragdoll()) {
    return;
  }
  var_6 = var_0 getcorpseanim();
  var_10 = 0.35;

  if(_animhasnotetrack(var_6, "start_ragdoll")) {
    var_11 = _getnotetracktimes(var_6, "start_ragdoll");

    if(isDefined(var_11)) {
      var_10 = var_11[0];
    }
  }

  var_12 = var_0 _meth_801F();
  var_13 = clamp(var_10 - var_12, 0, 1);
  var_14 = var_13 * _getanimlength(var_6);

  if(var_14 > 0) {
    var_0 common_scripts\utility::waittill_notify_or_timeout("force_start_ragdoll", var_14);
  }

  if(isDefined(var_0)) {
    var_0 startragdoll();
  }
}

getmostkilledby() {
  var_0 = "";
  var_1 = 0;
  var_2 = getarraykeys(self.killedby);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(self.killedby[var_4] <= var_1) {
      continue;
    }
    var_1 = self.killedby[var_4];
    var_5 = var_4;
  }

  return var_0;
}

getmostkilled() {
  var_0 = "";
  var_1 = 0;
  var_2 = getarraykeys(self.killedplayers);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(self.killedplayers[var_4] <= var_1) {
      continue;
    }
    var_1 = self.killedplayers[var_4];
    var_0 = var_4;
  }

  return var_0;
}

damageshellshockandrumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_0513::onweapondamage(var_0, var_1, var_2, var_3, var_5);
  var_6 = gettime();

  if(!isDefined(self.lastdamagerumbletime) || var_6 > self.lastdamagerumbletime) {
    self.lastdamagerumbletime = var_6;
    self playRumbleOnEntity("damage_heavy");
  }
}

_id_7E61(var_0) {
  var_1 = var_0.team;
  self linkTo(var_0, "tag_origin");
  self._id_0117 = var_0;
  self.inuse = 0;
  self makeusable();
  updateusablebyteam(var_1);
  thread trackteamchanges(var_1);
  thread revivetriggerthink(var_1);
  thread deleteonreviveordeathordisconnect();
}

deleteonreviveordeathordisconnect() {
  self endon("death");
  self._id_0117 common_scripts\utility::waittill_any("death", "disconnect");
  self delete();
}

updateusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2.team && var_2 != self._id_0117) {
      self enableplayeruse(var_2);
      continue;
    }

    self disableplayeruse(var_2);
  }
}

trackteamchanges(var_0) {
  self endon("death");

  for(;;) {
    level waittill("joined_team");
    updateusablebyteam(var_0);
  }
}

tracklaststandchanges(var_0) {
  self endon("death");

  for(;;) {
    level waittill("player_last_stand");
    updateusablebyteam(var_0);
  }
}

revivetriggerthink(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);
    self._id_0117.beingrevived = 1;

    if(isDefined(var_1.beingrevived) && var_1.beingrevived) {
      self._id_0117.beingrevived = 0;
      continue;
    }

    self makeunusable();
    self._id_0117 maps\mp\_utility::freezecontrolswrapper(1);
    var_2 = reviveholdthink(var_1);
    self._id_0117.beingrevived = 0;

    if(!isalive(self._id_0117)) {
      self delete();
      return;
    }

    self._id_0117 maps\mp\_utility::freezecontrolswrapper(0);

    if(var_2) {
      level thread maps\mp\gametypes\_rank::awardgameevent("reviver", var_1);
      self._id_0117._id_00E8 = undefined;
      self._id_0117 maps\mp\_utility::clearlowermessage("last_stand");
      self._id_0117 common_scripts\utility::_id_0616();
      self._id_0117.maxhealth = 100;
      self._id_0117 _id_0513::updatemovespeedscale();
      self._id_0117 maps\mp\gametypes\_playerlogic::laststandrespawnplayer();
      self._id_0117 maps\mp\_utility::giveperk("specialty_pistoldeath");
      self._id_0117.beingrevived = 0;
      self delete();
      return;
    }

    self makeusable();
    updateusablebyteam(var_0);
  }
}

reviveholdthink(var_0, var_1, var_2, var_3) {
  var_4 = 3000;
  var_5 = spawn("script_origin", self.origin);
  var_5 hide();

  if(isDefined(level.additional_revive_spot_handling_func)) {
    var_5 = [[level.additional_revive_spot_handling_func]](var_5, var_0);
  }

  if(isPlayer(var_0)) {
    var_0 playerlinkTo(var_5);
  } else {
    var_0 linkTo(var_5);
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    var_0 common_scripts\utility::_id_0602();
  }

  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(var_1)) {
    self.usetime = var_1;
  } else {
    self.usetime = var_4;
  }

  var_0 thread personalusebar(self);
  thread reviveholdthink_cleanup(var_0, var_2, var_5);
  var_6 = reviveholdthinkloop(var_0);
  self.inuse = 0;

  if(!common_scripts\utility::_id_562E(var_5.dontdeleterevivespot)) {
    var_5 delete();
  }

  if(isDefined(var_6) && var_6) {
    self._id_0117 thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived", var_0);
    self._id_0117.inlaststand = 0;
    return 1;
  }

  if(maps\mp\_utility::_id_585F()) {
    var_0._id_39E3++;

    if(isDefined(var_0._id_00E8) && var_0._id_00E8) {
      var_0._id_39E5++;
    }

    return 0;
  }
}

reviveholdthink_cleanup(var_0, var_1, var_2) {
  common_scripts\utility::waittill_any_ents(self, "death", var_2, "death");

  if(isDefined(level.additional_on_revive_end_func)) {
    [[level.additional_on_revive_end_func]](var_0, var_1, var_2);
    return;
  }

  if(!_isremovedentity(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_0) && maps\mp\_utility::isreallyalive(var_0)) {
    var_0 unlink();

    if(var_1) {
      var_0 common_scripts\utility::_id_0616();
    }
  }
}

personalusebar(var_0) {
  self setclientomnvar("ui_use_bar_text", 3);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_1 = undefined;

  if(isDefined(var_0) && isDefined(var_0._id_0117)) {
    var_1 = var_0._id_0117;
    var_1 setclientomnvar("ui_use_bar_text", 4);
    var_1 setclientomnvar("ui_use_bar_start_time", int(gettime()));
  }

  var_2 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0.inuse && !level.gameended && isDefined(self)) {
    var_3 = int(gettime());
    self setclientomnvar("ui_use_bar_current_time", var_3);

    if(isDefined(var_1)) {
      var_1 setclientomnvar("ui_use_bar_current_time", var_3);
    }

    if(var_2 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      if(var_0.userate > 0) {
        var_4 = gettime();
        var_5 = var_0.curprogress / var_0.usetime;
        var_6 = var_4 + (1 - var_5) * (var_0.usetime / var_0.userate);
        self setclientomnvar("ui_use_bar_end_time", int(var_6));

        if(isDefined(var_1)) {
          var_1 setclientomnvar("ui_use_bar_end_time", int(var_6));
        }
      }

      var_2 = var_0.userate;
    }

    waitframe();
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_use_bar_end_time", 0);
  }

  if(isDefined(var_1)) {
    var_1 setclientomnvar("ui_use_bar_end_time", 0);
  }
}

personalusebaroldstyle(var_0, var_1) {
  var_2 = maps\mp\gametypes\_hud_util::_id_2821();
  var_3 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
  var_3 settext(&"MPUI_REVIVING");

  if(isDefined(var_1)) {
    var_3 settext(var_1);
  }

  var_4 = var_0._id_0117 maps\mp\gametypes\_hud_util::_id_2821();
  var_5 = var_0._id_0117 maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
  var_5 settext(&"MPUI_BEING_REVIVED");
  var_6 = -1;

  while(maps\mp\_utility::isreallyalive(self) && isDefined(var_0) && var_0.inuse && !level.gameended && isDefined(self)) {
    if(var_6 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }

      var_2 maps\mp\gametypes\_hud_util::updatebar(var_0.curprogress / var_0.usetime, 1000 / var_0.usetime * var_0.userate);
      var_4 maps\mp\gametypes\_hud_util::updatebar(var_0.curprogress / var_0.usetime, 1000 / var_0.usetime * var_0.userate);

      if(!var_0.userate) {
        var_2 maps\mp\gametypes\_hud_util::hideelem();
        var_3 maps\mp\gametypes\_hud_util::hideelem();
        var_4 maps\mp\gametypes\_hud_util::hideelem();
        var_5 maps\mp\gametypes\_hud_util::hideelem();
      } else {
        var_2 maps\mp\gametypes\_hud_util::showelem();
        var_3 maps\mp\gametypes\_hud_util::showelem();
        var_4 maps\mp\gametypes\_hud_util::showelem();
        var_5 maps\mp\gametypes\_hud_util::showelem();
      }
    }

    var_6 = var_0.userate;
    waitframe();
  }

  if(isDefined(var_2)) {
    var_2 maps\mp\gametypes\_hud_util::destroyelem();
  }

  if(isDefined(var_3)) {
    var_3 maps\mp\gametypes\_hud_util::destroyelem();
  }

  if(isDefined(var_4)) {
    var_4 maps\mp\gametypes\_hud_util::destroyelem();
  }

  if(isDefined(var_5)) {
    var_5 maps\mp\gametypes\_hud_util::destroyelem();
  }
}

reviveholdthinkloop(var_0) {
  level endon("game_ended");
  self._id_0117 endon("death");
  self._id_0117 endon("disconnect");

  while(maps\mp\_utility::isreallyalive(var_0) && var_0 useButtonPressed() && self.curprogress < self.usetime && !(isDefined(var_0.inlaststand) && var_0.inlaststand)) {
    self.curprogress = self.curprogress + 50 * self.userate;
    self.userate = 1;

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      return maps\mp\_utility::isreallyalive(var_0);
    }

    waitframe();
  }

  return 0;
}

callback_killingblow(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && var_2 >= self.health && isDefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    maps\mp\_utility::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

emitfalldamage(var_0) {
  _physicsexplosionsphere(self.origin, 64, 64, 1);
  var_1 = [];

  for(var_2 = 0; var_2 < 360; var_2 = var_2 + 30) {
    var_3 = _cos(var_2) * 16;
    var_4 = _sin(var_2) * 16;
    var_5 = bulletTrace(self.origin + (var_3, var_4, 4), self.origin + (var_3, var_4, -6), 1, self);

    if(isDefined(var_5["entity"]) && isDefined(var_5["entity"].targetname) && (var_5["entity"].targetname == "destructible_vehicle" || var_5["entity"].targetname == "destructible_toy")) {
      var_1[var_1.size] = var_5["entity"];
    }
  }

  if(var_1.size) {
    var_6 = spawn("script_origin", self.origin);
    var_6 hide();
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

logprintplayerdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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

  _logprint("K;" + var_10 + ";" + var_7 + ";" + var_9 + ";" + var_8 + ";" + var_11 + ";" + var_14 + ";" + var_13 + ";" + var_12 + ";" + var_4 + ";" + var_2 + ";" + var_3 + ";" + var_6 + "\n");
}

destroyonreviveentdeath(var_0) {
  var_0 waittill("death");
  self destroy();
}

gamemodemodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_2) && isPlayer(var_2) && isalive(var_2)) {
    if(level.matchrules_damagemultiplier) {
      var_3 = var_3 * level.matchrules_damagemultiplier;
    }

    if(level.matchrules_vampirism) {
      var_2.health = int(_min(_float(var_2.maxhealth), _float(var_2.health + 20)));
    }
  }

  return var_3;
}

setentitydamagecallback(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = "normal";
  }

  if(!isDefined(var_3)) {
    var_3 = ::modifydamage;
  }

  self setCanDamage(1);

  if(isDefined(self.classname) && self.classname != "script_vehicle") {
    self setdamagecallbackon(1);
  }

  self.health = 999999;
  self.maxhealth = var_0;
  self._id_006A = 0;
  self.biskillstreak = var_4;
  self.damagefeedback = var_1;
  self.damagecallback = ::processdamagetaken;
  self.modifydamagefunc = var_3;
  self.ondeathfunc = var_2;
  self.attackerlist = [];
}

processdamagetaken(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self)) {
    return;
  }
  if(!(isDefined(level._id_5667) && level._id_5667) && !(isDefined(level.iszombiegame) && level.iszombiegame) && isDefined(var_1) && !maps\mp\_utility::isgameparticipant(var_1)) {
    return;
  }
  if(isDefined(var_1) && !_id_0513::friendlyfirecheck(self._id_0117, var_1)) {
    return;
  }
  var_1 playRumbleOnEntity("damage_light");

  if(isDefined(self.iscrashing) && self.iscrashing) {
    return;
  }
  if(isDefined(self.isleaving) && self.isleaving) {
    return;
  }
  if(isDefined(self.stopdamagefunc) && self.stopdamagefunc) {
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

    var_12 = [[self.modifydamagefunc]](var_1, var_5, var_4, var_2);
  }

  if(var_12 <= 0) {
    return 1;
  }

  if(isDefined(var_3) && var_3 &level._id_5039) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;
  self._id_006A = self._id_006A + var_12;
  _id_051E::killstreakhit(var_1, var_5, self);

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 _id_04C7::updatedamagefeedback(self.damagefeedback);

    if(isnewattacker(var_1)) {
      self.attackerlist[self.attackerlist.size] = var_1;
    }
  }

  if(self._id_006A >= self.maxhealth) {
    if(self.biskillstreak && isPlayer(var_1)) {
      var_1 notify("destroyed_killstreak", var_5);
    }

    if(self.classname == "script_vehicle" || self.classname == "script_model") {
      var_13 = maps\mp\_utility::_id_4431(var_5, 1);

      if(maps\mp\_utility::_id_5856(var_13)) {
        var_13 = maps\mp\gametypes\_class::getbasefromlootversion(var_13);
      }

      var_14 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_5, var_13);

      if(isDefined(self.model) && var_14 == "weapon_launcher") {
        if(issubstr(self.model, "uav")) {
          if(isDefined(level.challengeinfo["ch_uav_" + var_13])) {
            var_1 maps\mp\gametypes\_missions::processchallenge("ch_uav_" + var_13);
          }
        }

        if(issubstr(self.model, "warbird")) {
          if(isDefined(level.challengeinfo["ch_warbird_" + var_13])) {
            var_1 maps\mp\gametypes\_missions::processchallenge("ch_warbird_" + var_13);
          }
        }

        if(issubstr(self.model, "orbital_platform")) {
          if(isDefined(level.challengeinfo["ch_paladin_" + var_13])) {
            var_1 maps\mp\gametypes\_missions::processchallenge("ch_paladin_" + var_13);
          }
        }

        if(issubstr(self.model, "drone") && !issubstr(self.model, "uav")) {
          if(isDefined(level.challengeinfo["ch_drone_" + var_13])) {
            var_1 maps\mp\gametypes\_missions::processchallenge("ch_drone_" + var_13);
          }
        }
      }
    }

    self.stopdamagefunc = 1;
    self thread[[self.ondeathfunc]](var_1, var_5, var_4, var_2);
  }
}

isnewattacker(var_0) {
  foreach(var_2 in self.attackerlist) {
    if(var_0 == var_2) {
      return 0;
    }
  }

  return 1;
}

modifydamage(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_4 = handlemeleedamage(var_1, var_2, var_4);
  var_4 = handleempdamage(var_1, var_2, var_4, var_0);
  var_4 = handlemissiledamage(var_1, var_2, var_4);
  var_4 = handlegrenadedamage(var_1, var_2, var_4);
  var_4 = handleapdamage(var_1, var_2, var_4, var_0);
  return var_4;
}

handlemissiledamage(var_0, var_1, var_2) {
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

handlegrenadedamage(var_0, var_1, var_2) {
  if(var_0 == "stun_grenade_mp") {
    self notify("concussed");
    return 0;
  } else if(_isexplosivedamagemod(var_1)) {
    switch (var_0) {
      case "frag_grenade_german_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_2 = var_2 * 4;
        break;
      default:
        if(maps\mp\_utility::isstrstart(var_0, "alt_")) {
          var_2 = var_2 * 3;
        }

        break;
    }
  }

  return var_2;
}

handlemeleedamage(var_0, var_1, var_2) {
  if(maps\mp\_utility::ismeleemod(var_1)) {
    var_3 = int(self.maxhealth / 3) + 1;

    if(var_3 > var_2) {
      return var_3;
    }
  }

  return var_2;
}

handleempdamage(var_0, var_1, var_2, var_3) {
  if((var_0 == "emp_grenade_mp" || var_0 == "emp_grenade_killstreak_mp") && (var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD_GRENADE")) {
    self notify("emp_damage", var_3, 8.0);
    return 0;
  }

  return var_2;
}

handleapdamage(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isPlayer(var_3) && isDefined(self._id_0117) && isDefined(self._id_0117.team)) {
    if(var_3 maps\mp\_utility::_hasperk("specialty_streakdamager")) {
      return var_2 * var_3._id_2998;
    }
  }

  return var_2;
}

onkillstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;

  if(isDefined(var_0) && isDefined(self._id_0117)) {
    if(isDefined(var_0._id_0117) && isPlayer(var_0._id_0117)) {
      var_0 = var_0._id_0117;
    }

    if(var_0 == self._id_0117) {
      return;
    }
    if(_issentient(self._id_0117) && _issentient(var_0)) {
      if(!_isalliedsentient(self._id_0117, var_0)) {
        var_8 = var_0;
      }
    } else if(level.teambased) {
      if(self._id_0117.team != var_0.team) {
        var_8 = var_0;
      }
    } else if(self._id_0117 != var_0)
      var_8 = var_0;
  }

  if(isDefined(var_8)) {
    var_8 notify("destroyed_killstreak", var_1);
    var_8 maps\mp\_utility::incplayerstat(var_4, 1);
    level thread maps\mp\gametypes\_rank::awardgameevent(var_4, var_8, var_1, undefined, var_2);

    if(isDefined(level.killstreakwieldweapons) && isDefined(level.killstreakwieldweapons[var_1])) {
      var_9 = level.killstreakwieldweapons[var_1];

      if(var_9 == "counter_uav" || var_9 == "flak_gun") {
        var_8 maps\mp\gametypes\_persistence::incrementscorestreakstat(var_9, "killsOrAssists", 1);
      }
    }

    var_10 = _id_047A::_id_43D6(var_1, var_2);

    if(var_10 == "fighter_strike_kill") {
      if(var_4 == "airstrike_destroyed" || var_4 == "fire_bombing_run_destroyed" || var_4 == "carepackage_plane_destroyed" || var_4 == "emergency_carepackage_plane_destroyed" || var_4 == "uav_destroyed" || var_4 == "counter_uav_destroyed" || var_4 == "plane_gunner_destroyed" || var_4 == "paratroopers_plane_destroyed") {
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_interceptor");
      }
    }

    if(isDefined(self._id_6F2A) && !self._id_6F2A) {
      if(var_4 == "carepackage_plane_destroyed" || var_4 == "emergency_carepackage_plane_destroyed" || var_4 == "paratroopers_plane_destroyed") {
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_denied");
      } else if(var_4 == "airstrike_destroyed" || var_4 == "fire_bombing_run_destroyed") {
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_bomberdefense");
      }
    }

    if(var_4 == "plane_gunner_destroyed") {
      var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_ballout");
    }

    if(var_4 == "paratroopers_destroyed") {
      var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_rearguard");
    }

    if(var_4 == "fritzx_destroyed") {
      var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_movingtarget");
    }

    var_11 = maps\mp\_utility::_id_45B5(var_1);
    var_12 = maps\mp\gametypes\_missions::get_challenge_weapon_class(var_1, var_11);

    if(var_12 == "weapon_projectile" && isDefined(self._id_01C8) && var_11 != "dp28_mp") {
      var_8 maps\mp\gametypes\_missions::processchallenge("ch_camo_" + var_11);
      var_8 notify("increment_camo_multidestroy", var_11);
      var_13 = gettime();

      if(isDefined(self._id_5C2F) && var_13 - self._id_5C2F <= 20000) {
        var_8 maps\mp\gametypes\_missions::_id_99C5(var_1, "ch_camoT2_quicklaunch_");
      }

      if(isDefined(var_8.streaksdestroyedthislife)) {
        if(isDefined(var_8.streaksdestroyedthislife[var_11])) {
          var_8.streaksdestroyedthislife[var_11]++;
        } else {
          var_8.streaksdestroyedthislife[var_11] = 1;
        }

        if(var_8.streaksdestroyedthislife[var_11] == 2) {
          var_8 maps\mp\gametypes\_missions::_id_99C5(var_1, "ch_camoT2_doubledestroy_");
        }
      }
    }

    if(isDefined(var_6)) {
      level thread maps\mp\_utility::teamplayercardsplash(var_6, var_8);
    }

    if(isDefined(var_7) && var_7) {
      if(var_1 == "counter_recon_gun_mp") {
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_counteruav");
      } else if(var_1 == "killstreak_flak_gun_mp") {
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_flakgun");
      } else {
        var_8 maps\mp\gametypes\_missions::processchallenge("ch_streak_antiair");
      }

      level thread maps\mp\gametypes\_missions::vehiclekilled(self._id_0117, self, undefined, var_8, var_3, var_2, var_1);
    }
  }

  thread _id_047A::checkvandalismmedal(var_8);

  if(isDefined(self._id_0117) && isDefined(var_5)) {
    self._id_0117 thread maps\mp\_utility::leaderdialogonplayer(var_5);
  }
}

_id_4CAB(var_0) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.costume)) {
    return;
  }
  if(_isagent(self) && isDefined(self._id_0A4B) && self._id_0A4B == "paratroopers") {
    return;
  }
  if(self hasfemalecustomizationmodel()) {
    return;
  }
  if(self.costume[4] != 0) {
    _id_4505();
  }

  if(!isDefined(self.hatmodel)) {
    return;
  } else {
    self.costume[4] = 0;
  }

  var_1 = spawn("script_model", self.origin + (0, 0, 20));
  var_1 setModel(self.hatmodel);
  var_1.origin = self gettagorigin("j_head") + (0, 0, 20);
  var_1.angles = self gettagangles("j_head");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("helmet_collision");
  var_2.angles = var_1.angles;

  if(_isagent(self)) {
    self setagentcostumeindex(2);
  } else {
    self set_grenadeammo(self.costume);
  }

  self.hatmodel = undefined;
  var_1 linkTo(var_2);
  var_2._id_6292 = var_1;
  var_2 thread _id_4CA9(var_0);
  var_2 hideallparts();
}

_id_4CA9(var_0) {
  level endon("game_ended");
  setdvarifuninitialized("helmet_launch_vel", 10000);
  setdvarifuninitialized("helmet_launch_z_force", 6000);

  if(!isDefined(var_0)) {
    var_0 = anglesToForward(self.angles);
  }

  var_1 = var_0;
  var_2 = var_1[0] * getdvarint("helmet_launch_vel");
  var_3 = var_1[1] * getdvarint("helmet_launch_vel");
  var_4 = var_1[2] * getdvarint("helmet_launch_z_force");
  var_5 = self.origin + var_0 * -5;
  self physicslaunchclient(var_5, (var_2, var_3, var_4));
  wait 15;
  self._id_6292 delete();
  self delete();
}

_id_4505() {
  var_0 = "hat";
  var_1 = level.costumetypehexids[var_0];
  var_2 = self.costume[4];
  var_3 = undefined;
  var_4 = _func_2C0(var_1, var_2);

  if(self.team == "allies") {
    var_3 = "mp/costumeIdTable.csv";
  } else {
    var_3 = "mp/axisCostumeIdTable.csv";
  }

  var_5 = tablelookup(var_3, 7, var_4, 4);

  if(self.team == "allies") {
    var_3 = "mp/costumeModelTable.csv";
  } else {
    var_3 = "mp/axisCostumeModelTable.csv";
  }

  var_6 = _tablelookuprownum(var_3, 1, "hat");

  for(self.hatmodel = undefined; isDefined(var_6) && var_6 >= 0; var_6 = var_6 - 1) {
    var_7 = _tablelookupbyrow(var_3, var_6, 1);

    if(var_7 == "hat") {
      if(var_5 == _tablelookupbyrow(var_3, var_6, 3)) {
        self.hatmodel = _tablelookupbyrow(var_3, var_6, 0);
        break;
      }
    }
  }
}