/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\blades.gsc
************************************************/

main() {
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
    _setdynamicdvar("scr_game_radarMode", 1);
  }

  setdvarifuninitialized("blades_score_riflebullet", 10);
  setdvarifuninitialized("blades_score_defectivegrenade", 6);
  setdvarifuninitialized("blades_score_melee", 3);
  setdvarifuninitialized("blades_score_throwingknife", 0);
  _id_872E();
  maps\mp\_utility::_id_873B(0);
  level.disableforfeit = 1;
  level._id_6BA7 = ::_id_6BA7;
  level._id_6B7B = ::_id_6B7B;
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_6B7F = ::_id_6B7F;
  level._id_1DEA = ::_id_1785;
  level.thermalvisionon = 1;
  level._id_2FAB = 1;
  level.disabledivisionstats = 1;
  level._id_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  level.mgnestsdisabled = 1;
  level.disabledivisionpassives = 1;
  level.disabledivisionskills = 1;

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  _setteammode("ffa");
  _setdynamicdvar("scr_game_compassRadarUpdateTime", 9);
  game["dialog"]["gametype"] = "ffa_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
}

_id_5300() {
  maps\mp\_utility::_id_8653(1);
  _setdynamicdvar("scr_blades_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("blades", 1);
  _setdynamicdvar("scr_blades_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("blades", 1);
  _setdynamicdvar("scr_blades_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("blades", 0);
}

_id_6BAF() {
  _setclientnamemode("auto_change");
  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_BLADES");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_BLADES");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_BLADES");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_BLADES");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_BLADES_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_BLADES_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_BLADES_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_BLADES_HINT");
  _id_050D::_id_10E4();
  level._id_A239 = 0;
  var_0[0] = "blades";
  _id_04D1::main(var_0);

  foreach(var_2 in level.players) {
    var_2.pers["gamemodeLoadout"] = level._id_1784;
    var_2 maps\mp\gametypes\_class::_id_4773(var_2.team, "gamemode");
  }

  level._id_7895 = 1;
  level._id_17EF = 1;
  level thread onplayerconnect();
}

_id_6B5C(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in level.players) {
    if(isDefined(var_5.score) && var_5.score > var_3) {
      var_3 = var_5.score;
    }
  }

  if(game["state"] == "postgame" && var_1.score >= var_3) {
    var_1._id_3B4B = 1;
  }
}

_id_6B7F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(_id_57BE(var_0, var_3, var_4)) {
    if(isriflebulletkill(var_3, var_4)) {
      var_5 = getdvarint("blades_score_riflebullet", 10);
    } else if(isdefectivegrenadekill(var_3, var_4)) {
      var_5 = getdvarint("blades_score_defectivegrenade", 6);
    } else if(_id_5754(var_3, var_4)) {
      var_5 = getdvarint("blades_score_melee", 3);
    } else if(_id_5806(var_3, var_4)) {
      var_5 = getdvarint("blades_score_throwingknife", 0);
    }

    var_1 _id_04D2::_id_A161(var_1, var_5);
  }

  return var_5;
}

_id_57BE(var_0, var_1, var_2) {
  switch (var_0) {
    case "kill":
      return isriflebulletkill(var_1, var_2) || isdefectivegrenadekill(var_1, var_2) || _id_5806(var_1, var_2) || _id_5754(var_1, var_2);
  }

  return 0;
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_1)) {
    return;
  }
  if(var_3 == "MOD_TRIGGER_HURT" && !isPlayer(var_1)) {
    var_1 = self;
  }

  if(var_3 == "MOD_FALLING" || isPlayer(var_1)) {
    if(var_3 == "MOD_FALLING" || var_1 == self || _id_5806(var_4, var_3)) {
      self playlocalsound("mp_war_objective_lost");
      self._id_8C15 = 1;
      self.setbackduetosuicide = var_3 == "MOD_FALLING" || var_1 == self;
      self._id_65ED++;
      self._id_0021 = self._id_65ED;
      var_10 = self.score;
      self.pers["score"] = 0;
      self.score = 0;
      maps\mp\_utility::_id_867B(0);
      _id_04D2::_id_A161(self, var_10 * -1);

      if(_id_5806(var_4, var_3) && isDefined(var_1)) {
        var_1._id_9149++;
        var_1 maps\mp\_utility::_id_867C(var_1._id_9149);
        var_1 thread _id_047A::bankruptenemybladesscoreevent();
        var_11 = getleadingplayer();

        if(isDefined(var_11) && self == var_11) {
          var_1 thread _id_047A::bankruptfirstplayerbladesscoreevent();
          maps\mp\_utility::leaderdialogonplayer("humiliation", "status");
          return;
        }

        return;
      }
    } else if(_id_57BE("kill", var_4, var_3) && !_id_5806(var_4, var_3)) {
      if(var_1.lastscoretime + 3000 > gettime()) {
        var_1 thread _id_047A::quickbladesscoreevent();
      }

      var_1.lastscoretime = gettime();

      if(isriflebulletkill(var_4, var_3)) {
        var_1 thread _id_047A::increasedbladesscoreriflebulletevent();
      } else if(isdefectivegrenadekill(var_4, var_3)) {
        var_1 thread _id_047A::increasedbladesscoredefectivegrenadeevent();
      } else if(_id_5754(var_4, var_3)) {
        var_1 thread _id_047A::increasedbladesscoremeleeevent();
      }
    }
  }
}

getleadingplayer() {
  var_0 = 0;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_3.score) && var_3.score > var_0) {
      var_0 = var_3.score;
      var_1 = var_3;
      continue;
    }

    if(isDefined(var_3.score) && var_3.score == var_0) {
      var_1 = undefined;
    }
  }

  return var_1;
}

_id_5806(var_0, var_1) {
  return var_0 == "throwingknife_mp" && var_1 == "MOD_IMPACT";
}

_id_5754(var_0, var_1) {
  return var_1 == "MOD_MELEE";
}

isdefectivegrenadekill(var_0, var_1) {
  return var_0 == "alt+m1garand_blades_mp+grenade_launcher_blades" && var_1 != "MOD_MELEE";
}

isriflebulletkill(var_0, var_1) {
  return var_0 == "alt+m30_blades_mp+m30_rifle_blades" && var_1 != "MOD_MELEE";
}

_id_872E() {
  level._id_1784 = maps\mp\gametypes\_class::_id_44B4();
  level._id_1784["loadoutDivision"] = 6;
  level._id_1784["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16846848, 0);
  level._id_1784["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16920576, 0);
  level._id_1784["loadoutEquipmentStruct"] = maps\mp\_utility::_id_44CE(16818176, 0);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_9149 = 0;
    var_0._id_65ED = 0;
    var_0.lastscoretime = 0;
    var_0._id_8C15 = 0;
    var_0.setbackduetosuicide = 0;
  }
}

_id_7B82() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload");
    self givestartammo(self.primaryweapon);

    if(isDefined(self.lethalweapon)) {
      self givestartammo(self.lethalweapon);

      if(self.lethalweapon == "throwingknife_mp") {
        _id_04C7::_id_A102("resupply_throwingknife");
        continue;
      }

      _id_04C7::_id_A102("resupply_equipment");
    }
  }
}

_id_7B85() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(maps\mp\_utility::isreallyalive(self) && self.team != "spectator" && (isDefined(self.primaryweapon) && _weapontype(self.primaryweapon) != "melee" && self getammocount(self.primaryweapon) == 0 || isDefined(self.lethalweapon) && self getammocount(self.lethalweapon) == 0)) {
      wait 2;
      self notify("reload");
      wait 1;
      continue;
    }

    waitframe();
  }
}

_id_1785() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level._id_1784;
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  maps\mp\gametypes\_class::_id_4790(self.team, self.class);
}

_id_6BA7() {
  self _meth_8328();
  _id_1785();
  thread _id_A6F3();
}

_id_A6F3() {
  level endon("game_ended");
  self endon("disconnect");
  level waittill("player_spawned");
  givesticksnstonesloadout();

  if(self._id_8C15) {
    if(self.setbackduetosuicide) {
      thread _id_047A::bankruptedbladesscoresuicideevent();
    } else {
      thread _id_047A::bankruptedbladesscoreevent();
    }

    self._id_8C15 = 0;
    self.setbackduetosuicide = 0;
  }
}

givesticksnstonesloadout() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("giveRifleBulletGun");
  self endon("giveRifleBulletGun");
  waittillframeend;
  maps\mp\_utility::giveperk("specialty_longersprint");
  maps\mp\_utility::giveperk("specialty_sprintfastrecovery");
  maps\mp\_utility::giveperk("specialty_fastclimb");
  maps\mp\_utility::giveperk("specialty_fastmantle");
  maps\mp\_utility::giveperk("specialty_sprintreload");
  maps\mp\_utility::giveperk("specialty_fastreload");
  maps\mp\_utility::giveperk("specialty_increasedmeleedamage");
  self takeallweapons();
  self.lethalweapon = "throwingknife_mp";
  self setlethalweapon(self.lethalweapon);
  self giveweapon(self.lethalweapon);
  self setweaponammoclip(self.lethalweapon, 1);
  var_0 = "alt+m30_blades_mp+m30_rifle_blades";
  maps\mp\_utility::_giveweapon(var_0);
  self givestartammo(var_0);
  var_1 = maps\mp\_utility::_id_4431(var_0);
  self.pers["secondaryWeapon"] = var_1;
  self.botclearscriptenemy = var_0;
  var_2 = "alt+m1garand_blades_mp+grenade_launcher_blades";
  maps\mp\_utility::_giveweapon(var_2);
  self givestartammo(var_2);
  self switchtoweapon(var_2);
  self setspawnweapon(var_2);
  var_1 = maps\mp\_utility::_id_4431(var_2);
  self.pers["primaryWeapon"] = var_1;
  self.primaryweapon = var_2;
}