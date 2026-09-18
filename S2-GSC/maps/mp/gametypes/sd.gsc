/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\sd.gsc
*********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::init();
  lib_01DD::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 3, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 2.5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 4);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  level.objectivebased = 1;
  maps\mp\_utility::func_873B(1);
  level.var_6B86 = ::maps / mp / gametypes / common_sd_sr::func_6B86;
  level.var_6BAF = ::func_6BAF;
  level.var_6BA7 = ::func_6BA7;
  level.var_6B7B = ::func_6B7B;
  level.var_6AE2 = ::maps / mp / gametypes / common_sd_sr::func_6AE2;
  level.var_6B5E = ::maps / mp / gametypes / common_sd_sr::func_6B5E;
  level.var_6BB6 = ::maps / mp / gametypes / common_sd_sr::func_6BB6;
  level.onnormaldeath = ::maps / mp / gametypes / common_sd_sr::onnormaldeath;
  level.var_3FC7 = ::maps / mp / gametypes / common_sd_sr::func_5782;
  level.var_C25 = 0;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "sd_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "gbl_destroyobj";
  game["dialog"]["defense_obj"] = "gbl_defendobj";
  setomnvar("ui_bomb_a_timer_endtime", 0);
  setomnvar("ui_bomb_b_timer_endtime", 0);
}

func_5300() {
  maps\mp\_utility::func_8653();
  var_00 = getmatchrulesdata("sdData", "roundLength");
  setdynamicdvar("scr_sd_timelimit", var_00);
  maps\mp\_utility::registertimelimitdvar("sd", var_00);
  var_01 = getmatchrulesdata("sdData", "roundSwitch");
  setdynamicdvar("scr_sd_roundswitch", var_01);
  maps\mp\_utility::registerroundswitchdvar("sd", var_01, 0, 9);
  var_02 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_sd_winlimit", var_02);
  maps\mp\_utility::registerwinlimitdvar("sd", var_02);
  setdynamicdvar("scr_sd_bombtimer", getmatchrulesdata("sdData", "bombTimer"));
  setdynamicdvar("scr_sd_planttime", getmatchrulesdata("sdData", "plantTime"));
  setdynamicdvar("scr_sd_defusetime", getmatchrulesdata("sdData", "defuseTime"));
  setdynamicdvar("scr_sd_multibomb", getmatchrulesdata("sdData", "multiBomb"));
  setdynamicdvar("scr_sd_silentplant", getmatchrulesdata("sdData", "silentPlant"));
  setdynamicdvar("scr_sd_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("sd", 0);
  setdynamicdvar("scr_sd_scorelimit", 1);
  maps\mp\_utility::registerscorelimitdvar("sd", 1);
  setdynamicdvar("scr_sd_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("sd", 0);
}

func_6BAF() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  setomnvar("ui_war_attacker_team", maps\mp\_utility::func_46D4(game["attackers"]));
  setclientnamemode("manual_change");
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
  lib_050D::func_10E4();
  var_02[0] = "sd";
  var_02[1] = "bombzone";
  var_02[2] = "blocker_sd";
  maps\mp\gametypes\_gameobjects::main(var_02);
  thread maps / mp / gametypes / common_sd_sr::func_A121();
  maps / mp / gametypes / common_sd_sr::func_872D();
  thread maps / mp / gametypes / common_sd_sr::func_18FD();
  thread func_832D();
}

func_6BA7() {
  var_00 = isDefined(self.var_57A7) && self.var_57A7;
  if(maps\mp\_utility::func_56FF(self)) {
    self.var_5777 = 0;
    self.var_56C2 = 0;
    if(!var_00) {
      self.var_568D = 0;
      self.objective = 0;
    }
  }

  if(isPlayer(self) && !var_00) {
    if(level.var_6510 && self.pers["team"] == game["attackers"]) {
      self setclientomnvar("ui_carrying_bomb", 1);
      thread maps\mp\gametypes\_hud_message::func_9102("bomb_pickedup");
    } else {
      self setclientomnvar("ui_carrying_bomb", 0);
    }
  }

  maps\mp\_utility::func_867B(0);
  if(isDefined(self.pers["plants"])) {
    maps\mp\_utility::func_867B(self.pers["plants"]);
  }

  maps\mp\_utility::func_867C(0);
  if(isDefined(self.pers["defuses"])) {
    maps\mp\_utility::func_867C(self.pers["defuses"]);
  }

  if(isDefined(self.pers["cur_kill_streak"])) {
    self.killstreakcount = self.pers["cur_kill_streak"];
  }

  self.var_57A7 = undefined;
  level notify("spawned_player");
}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isPlayer(self)) {
    self setclientomnvar("ui_carrying_bomb", 0);
  }

  thread maps / mp / gametypes / common_sd_sr::func_21AB();
  maps / mp / gametypes / common_sd_sr::func_254C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

func_832D() {
  var_00 = undefined;
  var_01 = undefined;
  foreach(var_03 in level.var_1913) {
    if(isDefined(var_03.var_9D65) && isDefined(var_03.var_9D65.var_81E8)) {
      if(var_03.var_9D65.var_81E8 == "_a") {
        var_00 = var_03;
        continue;
      }

      if(var_03.var_9D65.var_81E8 == "_b") {
        var_01 = var_03;
      }
    }
  }

  for(;;) {
    var_05 = undefined;
    var_06 = undefined;
    var_07 = "none";
    var_08 = "none";
    var_09 = gettime();
    foreach(var_0B in level.players) {
      if(isDefined(var_0B.var_568D) && var_0B.var_568D) {
        var_05 = var_0B;
        break;
      }
    }

    if(!isDefined(var_05)) {
      if(isDefined(level.var_832F)) {
        var_06 = level.var_832F.var_9D65.origin;
      }
    } else {
      var_06 = var_05.origin;
      var_07 = var_05.name;
    }

    if(isDefined(level.var_18F9) && level.var_18F9 && isDefined(level.var_7069)) {
      var_08 = level.var_7069.var_9D65.var_81E8;
      var_06 = level.var_7069.var_9D65.origin;
    }

    function_00F5("script_mp_sd: gameTime %d, bomb_a_loc %v, bomb_b_loc %v, bomb_loc %v, bomb_carrier %s, planted_location %s", var_09, var_00.var_9D65.origin, var_01.var_9D65.origin, var_06, var_07, var_08);
    wait(0.2);
  }
}