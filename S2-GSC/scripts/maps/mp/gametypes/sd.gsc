/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\sd.gsc
********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 3, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 2.5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 4);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  level.objectivebased = 1;
  maps\mp\_utility::_id_873B(1);
  level._id_6B86 = maps\mp\gametypes\common_sd_sr::_id_6B86;
  level._id_6BAF = ::_id_6BAF;
  level._id_6BA7 = ::_id_6BA7;
  level._id_6B7B = ::_id_6B7B;
  level._id_6AE2 = maps\mp\gametypes\common_sd_sr::_id_6AE2;
  level._id_6B5E = maps\mp\gametypes\common_sd_sr::_id_6B5E;
  level._id_6BB6 = maps\mp\gametypes\common_sd_sr::_id_6BB6;
  level._id_6B5C = maps\mp\gametypes\common_sd_sr::_id_6B5C;
  level._id_3FC7 = maps\mp\gametypes\common_sd_sr::_id_5782;
  level._id_0C25 = 0;

  if(level._id_6031 || level._id_6035)
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;

  game["dialog"]["gametype"] = "sd_intro";

  if(getdvarint("2043"))
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];

  game["dialog"]["offense_obj"] = "gbl_destroyobj";
  game["dialog"]["defense_obj"] = "gbl_defendobj";
  _setomnvar("ui_bomb_a_timer_endtime", 0);
  _setomnvar("ui_bomb_b_timer_endtime", 0);
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  var_0 = _getmatchrulesdata("sdData", "roundLength");
  _setdynamicdvar("scr_sd_timelimit", var_0);
  maps\mp\_utility::registertimelimitdvar("sd", var_0);
  var_1 = _getmatchrulesdata("sdData", "roundSwitch");
  _setdynamicdvar("scr_sd_roundswitch", var_1);
  maps\mp\_utility::registerroundswitchdvar("sd", var_1, 0, 9);
  var_2 = _getmatchrulesdata("commonOption", "scoreLimit");
  _setdynamicdvar("scr_sd_winlimit", var_2);
  maps\mp\_utility::registerwinlimitdvar("sd", var_2);
  _setdynamicdvar("scr_sd_bombtimer", _getmatchrulesdata("sdData", "bombTimer"));
  _setdynamicdvar("scr_sd_planttime", _getmatchrulesdata("sdData", "plantTime"));
  _setdynamicdvar("scr_sd_defusetime", _getmatchrulesdata("sdData", "defuseTime"));
  _setdynamicdvar("scr_sd_multibomb", _getmatchrulesdata("sdData", "multiBomb"));
  _setdynamicdvar("scr_sd_silentplant", _getmatchrulesdata("sdData", "silentPlant"));
  _setdynamicdvar("scr_sd_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("sd", 0);
  _setdynamicdvar("scr_sd_scorelimit", 1);
  maps\mp\_utility::registerscorelimitdvar("sd", 1);
  _setdynamicdvar("scr_sd_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("sd", 0);
}

_id_6BAF() {
  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  _setomnvar("ui_war_attacker_team", maps\mp\_utility::_id_46D4(game["attackers"]));
  _setclientnamemode("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx/explosion/mp_gametype_bomb");
  level._effect["search_dstry_bomb_arming_light"] = loadfx("vfx/unique/search_dstry_bomb_arming_light");
  maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
  maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  } else {
    maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
    maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
  maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");
  _id_050D::_id_10E4();
  var_2[0] = "sd";
  var_2[1] = "bombzone";
  var_2[2] = "blocker_sd";
  _id_04D1::main(var_2);
  thread maps\mp\gametypes\common_sd_sr::_id_A121();
  maps\mp\gametypes\common_sd_sr::_id_872D();
  thread maps\mp\gametypes\common_sd_sr::_id_18FD();
  thread openmenu();
}

_id_6BA7() {
  var_0 = isDefined(self._id_57A7) && self._id_57A7;

  if(maps\mp\_utility::_id_56FF(self)) {
    self._id_5777 = 0;
    self._id_56C2 = 0;

    if(!var_0) {
      self._id_568D = 0;
      self._id_0112 = 0;
    }
  }

  if(isPlayer(self) && !var_0) {
    if(level._id_6510 && self.pers["team"] == game["attackers"]) {
      self setclientomnvar("ui_carrying_bomb", 1);
      thread maps\mp\gametypes\_hud_message::_id_9102("bomb_pickedup");
    } else
      self setclientomnvar("ui_carrying_bomb", 0);
  }

  maps\mp\_utility::_id_867B(0);

  if(isDefined(self.pers["plants"]))
    maps\mp\_utility::_id_867B(self.pers["plants"]);

  maps\mp\_utility::_id_867C(0);

  if(isDefined(self.pers["defuses"]))
    maps\mp\_utility::_id_867C(self.pers["defuses"]);

  if(isDefined(self.pers["cur_kill_streak"]))
    self._id_00E4 = self.pers["cur_kill_streak"];

  self._id_57A7 = undefined;
  level notify("spawned_player");
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isPlayer(self))
    self setclientomnvar("ui_carrying_bomb", 0);

  thread maps\mp\gametypes\common_sd_sr::_id_21AB();
  maps\mp\gametypes\common_sd_sr::_id_254C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

openmenu() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level._id_1913) {
    if(isDefined(var_3._id_9D65) && isDefined(var_3._id_9D65.shootblank)) {
      if(var_3._id_9D65.shootblank == "_a") {
        var_0 = var_3;
        continue;
      }

      if(var_3._id_9D65.shootblank == "_b")
        var_1 = var_3;
    }
  }

  for(;;) {
    var_5 = undefined;
    var_6 = undefined;
    var_7 = "none";
    var_8 = "none";
    var_9 = gettime();

    foreach(var_11 in level.players) {
      if(isDefined(var_11._id_568D) && var_11._id_568D) {
        var_5 = var_11;
        break;
      }
    }

    if(!isDefined(var_5)) {
      if(isDefined(level._id_832F))
        var_6 = level._id_832F._id_9D65.origin;
    } else {
      var_6 = var_5.origin;
      var_7 = var_5.name;
    }

    if(isDefined(level._id_18F9) && level._id_18F9 && isDefined(level._id_7069)) {
      var_8 = level._id_7069._id_9D65.shootblank;
      var_6 = level._id_7069._id_9D65.origin;
    }

    _reconevent("script_mp_sd: gameTime %d, bomb_a_loc %v, bomb_b_loc %v, bomb_loc %v, bomb_carrier %s, planted_location %s", var_9, var_0._id_9D65.origin, var_1._id_9D65.origin, var_6, var_7, var_8);
    wait 0.2;
  }
}