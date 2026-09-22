/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\demo.gsc
**********************************************/

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
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 1, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 3);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 2);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 1);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  maps\mp\_utility::setovertimelimitdvar(2.5);
  level._id_2D64 = 1;
  maps\mp\_utility::_id_873B(1);
  level._id_4959 = 0;
  level._id_6B86 = ::_id_6B86;
  level._id_6BAF = ::_id_6BAF;
  level._id_6BA7 = ::_id_6BA7;
  level._id_6B7B = ::_id_6B7B;
  level._id_6BB6 = ::_id_6BB6;
  level._id_6B42 = ::_id_6B42;
  level._id_6B5C = ::_id_6B5C;
  level._id_3FC7 = ::_id_5782;
  level._id_0C25 = 1;
  level._id_6876 = 0;

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  game["dialog"]["gametype"] = "demo_intro";

  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "gbl_destroyobj";
  game["dialog"]["defense_obj"] = "gbl_defendobj";
  _setomnvar("ui_bomb_a_timer_endtime", 0);
  _setomnvar("ui_bomb_b_timer_endtime", 0);
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  var_0 = _getmatchrulesdata("demoData", "roundSwitch");
  _setdynamicdvar("scr_demo_roundswitch", var_0);
  maps\mp\_utility::registerroundswitchdvar("demo", var_0, 0, 9);
  _setdynamicdvar("scr_demo_bombtimer", _getmatchrulesdata("demoData", "bombTimer"));
  _setdynamicdvar("scr_demo_planttime", _getmatchrulesdata("demoData", "plantTime"));
  _setdynamicdvar("scr_demo_defusetime", _getmatchrulesdata("demoData", "defuseTime"));
  _setdynamicdvar("scr_demo_multibomb", _getmatchrulesdata("demoData", "multiBomb"));
  _setdynamicdvar("scr_demo_silentplant", _getmatchrulesdata("demoData", "silentPlant"));
  _setdynamicdvar("scr_demo_extratime", _getmatchrulesdata("demoData", "extraTime"));
  _setdynamicdvar("scr_demo_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar("demo", 1);
  _setdynamicdvar("scr_demo_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar("demo", 1);
  _setdynamicdvar("scr_demo_scorelimit", 3);
  maps\mp\_utility::registerscorelimitdvar("demo", 3);
  _setdynamicdvar("scr_demo_halftime", 1);
  maps\mp\_utility::registerhalftimedvar("demo", 1);
  _setdynamicdvar("scr_demo_halftimeswitchsides", _getmatchrulesdata("demoData", "halfTimeSwitchSides"));
}

_id_6BAF() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  _setomnvar("ui_war_attacker_team", maps\mp\_utility::_id_46D4(game["attackers"]));

  if(game["status"] == "halftime") {
    _setomnvar("ui_current_round", 2);
  } else if(game["status"] == "overtime") {
    _setomnvar("ui_current_round", 3);
  } else if(game["status"] == "overtime_halftime") {
    _setomnvar("ui_current_round", 4);
  }

  _setclientnamemode("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx/explosion/mp_gametype_bomb");
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
  var_2[0] = "blocker_demo";

  if(game["status"] == "overtime") {
    var_2[1] = "demo_bombzone_ot";
    level.demobombbteam = "exploded";

    foreach(var_4 in level.players) {
      var_4 setclientomnvar("ui_demo_bomb_b_state", 2);
    }
  } else
    var_2[1] = "demo_bombzone";

  _id_04D1::main(var_2);
  thread _id_A121();
  thread _id_18FD();
  level._id_4958 = maps\mp\_utility::dvarintvalue("halftimeswitchsides", 1, 0, 1);
}

_id_6BA7() {
  if(maps\mp\_utility::_id_56FF(self)) {
    self._id_5777 = 0;
    self._id_56C2 = 0;
    self._id_568D = 1;
    self._id_0112 = 0;
  }

  if(isPlayer(self)) {
    if(level._id_6510 && (self.pers["team"] == game["attackers"] || game["status"] == "overtime")) {
      self setclientomnvar("ui_carrying_bomb", 1);
      thread maps\mp\gametypes\_hud_message::_id_9102("bomb_pickedup");
    } else
      self setclientomnvar("ui_carrying_bomb", 0);
  }

  maps\mp\_utility::_id_867B(0);

  if(isDefined(self.pers["plants"])) {
    maps\mp\_utility::_id_867B(self.pers["plants"]);
  }

  maps\mp\_utility::_id_867C(0);

  if(isDefined(self.pers["defuses"])) {
    maps\mp\_utility::_id_867C(self.pers["defuses"]);
  }

  if(!isDefined(level.demobombateam)) {
    self setclientomnvar("ui_demo_bomb_a_state", 0);
  } else if(level.demobombateam == "exploded") {
    self setclientomnvar("ui_demo_bomb_a_state", 2);
  } else if(level.demobombateam == self.team) {
    self setclientomnvar("ui_demo_bomb_a_state", 3);
  } else {
    self setclientomnvar("ui_demo_bomb_a_state", 1);
  }

  if(!isDefined(level.demobombbteam)) {
    self setclientomnvar("ui_demo_bomb_b_state", 0);
  } else if(level.demobombbteam == "exploded") {
    self setclientomnvar("ui_demo_bomb_b_state", 2);
  } else if(level.demobombbteam == self.team) {
    self setclientomnvar("ui_demo_bomb_b_state", 3);
  } else {
    self setclientomnvar("ui_demo_bomb_b_state", 1);
  }

  level notify("spawned_player");
}

_id_6B86() {
  game["bomb_dropped_sound"] = "mp_obj_notify_neg_sml";
  game["bomb_dropped_enemy_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_recovered_sound"] = "mp_obj_notify_pos_sml";
  game["bomb_grabbed_sound"] = "mp_snd_bomb_pickup";
  game["bomb_planted_sound"] = "mp_obj_notify_pos_med";
  game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_med";
  game["bomb_disarm_sound"] = "mp_obj_notify_pos_lrg";
  game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_lrg";
}

_id_A121() {
  level._id_7078 = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
  level._id_2CA9 = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level._id_1909 = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level._id_6510 = maps\mp\_utility::dvarintvalue("multibomb", 0, 0, 1);
  level._id_8C56 = maps\mp\_utility::dvarintvalue("silentplant", 0, 0, 1);
  level._id_3992 = maps\mp\_utility::dvarintvalue("extraTime", 2, 0, 10);
}

_id_5782(var_0) {
  if(isDefined(level._id_1913)) {
    foreach(var_2 in level._id_1913) {
      if(distancesquared(self.origin, var_2._id_9D65.origin) < 4096) {
        return 0;
      }
    }
  }

  return 1;
}

_id_6B7B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(maps\mp\gametypes\_damage::_id_56FA(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  var_10 = self;

  if(var_10._id_5777 || var_10._id_56C2) {
    var_1 thread _id_047A::_id_2C80(var_10, var_9, var_4);
    var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);

    if(var_10._id_5777) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_interrupt");
    }

    if(var_10._id_56C2) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_protector");
    }
  }
}

_id_6B5C(var_0, var_1, var_2) {
  if(game["state"] == "postgame" && (var_0.team == game["defenders"] || !level._id_18F9)) {
    var_1._id_3B4B = 1;
  }
}

_id_18FD() {
  level._id_18F9 = 0;
  level._id_18D3 = 0;
  level._id_18EE = 0;
  level.icontarget = "waypoint_caster_target";
  level._id_1913 = [];
  level._id_2D65 = [];
  var_0 = getEntArray("demo_bombzone", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(game["status"] == "overtime") {
      level.demolition_site_mod = [];
      level.demolition_site_mod[var_1] = level.demolition_site_mod_ot;
      level.demolition_site_origins = [];
      level.demolition_site_origins[var_1] = level.demolition_site_origins_ot;
      level.demolition_site_angles = [];
      level.demolition_site_angles[var_1] = level.demolition_site_angles_ot;
    }

    var_2 = var_0[var_1];
    var_3 = getEntArray(var_0[var_1].target, "targetname");
    var_4 = [];
    var_5 = undefined;

    if(isDefined(level.demolition_site_mod) && isDefined(level.demolition_site_mod[var_1])) {
      var_4 = getEntArray("script_brushmodel", "classname");

      foreach(var_7 in var_4) {
        if(distance(var_7.origin, var_2.origin) <= 200 && isDefined(var_7.dropweapon) && (game["status"] != "overtime" && var_7.dropweapon == "demo_bombzone" || game["status"] == "overtime" && var_7.dropweapon == "demo_bombzone_ot") && isDefined(var_7.shootblank) && var_7.shootblank == level.demolition_site_mod[var_1]) {
          var_5 = var_7;
        }
      }
    }

    if(isDefined(level.demolition_site_origins) && isDefined(level.demolition_site_origins[var_1]) && isDefined(var_5)) {
      var_2.origin = level.demolition_site_origins[var_1];
      var_3[0].origin = level.demolition_site_origins[var_1];
      var_5.origin = (0, 0, 26) + level.demolition_site_origins[var_1];
    }

    if(isDefined(level.demolition_site_angles) && isDefined(level.demolition_site_angles[var_1]) && isDefined(var_5)) {
      var_2.angles = level.demolition_site_angles[var_1];
      var_3[0].angles = (0, 270, 0) + level.demolition_site_angles[var_1];
      var_5.angles = level.demolition_site_angles[var_1];
    }

    if(game["status"] == "overtime") {
      var_9 = "any";
      var_10 = "any";
    } else {
      var_9 = game["defenders"];
      var_10 = "enemy";
    }

    var_11 = _id_04D1::_id_2837(var_9, var_2, var_3, (0, 0, 64));
    var_11 _id_04D1::_id_0C30(var_10);
    var_11 _id_04D1::_id_8A5A(level._id_7078);
    var_11 _id_04D1::_id_8A57(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
    var_12 = var_11 _id_04D1::_id_454C();
    var_11.label = var_12;

    if(game["status"] == "overtime") {
      var_11 _id_04D1::set2dicon("friendly", "waypoint_target" + var_12);
      var_11 _id_04D1::playsoundtoteam("friendly", "waypoint_target" + var_12);
    } else {
      var_11 _id_04D1::set2dicon("friendly", "waypoint_defend" + var_12);
      var_11 _id_04D1::playsoundtoteam("friendly", "waypoint_defend" + var_12);
    }

    var_11 _id_04D1::set2dicon("enemy", "waypoint_target" + var_12);
    var_11 _id_04D1::playsoundtoteam("enemy", "waypoint_target" + var_12);
    var_11 _id_04D1::_id_8A60("any");
    maps\mp\_utility::_id_863F(var_11, level.icontarget + var_12, 3);
    var_11._id_6ABC = ::_id_6ABE;
    var_11._id_6AFA = ::_id_6AFB;
    var_11._id_681A = 1;
    var_11._id_502A = "bombZone";
    var_11._id_6BBF = ::_id_6BC8;
    var_11._id_6AC9 = ::_id_6AC9;
    var_11._id_A248 = "search_dstry_bomb_mp";
    var_11._id_568E = 0;
    var_11._id_18F9 = 0;

    for(var_13 = 0; var_13 < var_3.size; var_13++) {
      if(isDefined(var_3[var_13].setdepthoffield)) {
        var_11._id_3947 = var_3[var_13].setdepthoffield;
        var_3[var_13] thread _id_8A29(var_11);
        break;
      }
    }

    level._id_1913[level._id_1913.size] = var_11;
    var_11._id_18D5 = _getEnt(var_3[0].target, "targetname");
    var_11._id_18D5.origin = var_11._id_18D5.origin + (0, 0, -10000);
    var_11._id_18D5.label = var_12;
    var_11._id_18D5 usetriggertouchcheckstance(1);
  }

  for(var_1 = 0; var_1 < level._id_1913.size; var_1++) {
    var_14 = [];

    for(var_15 = 0; var_15 < level._id_1913.size; var_15++) {
      if(var_15 != var_1) {
        var_14[var_14.size] = level._id_1913[var_15];
      }
    }

    level._id_1913[var_1]._id_6C61 = var_14;
  }

  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
}

_id_6BC8(var_0) {
  if(!_id_04D1::_id_56FB(var_0.pers["team"]) || game["status"] == "overtime") {
    level thread _id_18F9(self, var_0);
    var_0 playSound("mp_bomb_plant");
    var_0 notify("bomb_planted");
    var_0 thread _id_047A::_id_18FC();
    var_0 thread _id_0468::_id_0A22("demoBombPlanted");
    maps\mp\_utility::leaderdialog("bomb_planted");
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_sound"], game["attackers"]);
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_enemy_sound"], game["defenders"]);
    self._id_18F8 = var_0;
    self._id_18F9 = 1;
    var_0._id_18FB = gettime();
  } else
    self._id_18F9 = 0;
}

_id_7156(var_0) {
  var_1 = common_scripts\utility::_id_0F93(level.players, var_0);

  if(var_1.size) {
    var_0 maps\mp\_utility::_id_74C3("snd_bomb_button_press_lp", undefined, var_1);
  }
}

_id_93D6(var_0) {
  var_0 common_scripts\utility::_id_93D5("snd_bomb_button_press_lp");
}

_id_8A29(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateYaw(-45, 0.05);
  waitframe();
  var_2 = self.origin + (0, 0, 5);
  var_3 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_4 = bulletTrace(var_2, var_3, 0, self);
  self._id_5A2C = spawn("script_model", var_4["position"]);
  self._id_5A2C setscriptmoverkillcam("explosive");
  var_0._id_5A2D = self._id_5A2C getentitynumber();
  var_1 delete();
}

_id_6ABF(var_0) {
  var_0 allowmelee(0);

  if(_id_04D1::_id_56FB(var_0.pers["team"])) {
    if(!level._id_8C56 && !var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
      var_0 maps\mp\_utility::_id_67F4("defuse");
      var_0 playSound("mp_snd_bomb_disarming");
      level thread _id_7156(var_0);
    }

    var_0._id_56C2 = 1;

    if(isDefined(self._id_2D65)) {
      self._id_2D65 hide();
    }
  }
}

_id_6ABE(var_0) {
  var_0 allowmelee(0);

  if(!level._id_8C56 && !var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
    var_0 maps\mp\_utility::_id_67F4("plant");
    var_0 playSound("mp_snd_bomb_arming");
    level thread _id_7156(var_0);
  }

  var_0._id_5777 = 1;
}

_id_6AFB(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 allowmelee(1);
  var_1._id_5777 = 0;
  level thread _id_93D6(var_1);
}

_id_6AFC(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 allowmelee(1);
  var_1._id_56C2 = 0;
  level thread _id_93D6(var_1);

  if(_id_04D1::_id_56FB(var_1.pers["team"])) {
    if(isDefined(self._id_2D65) && !var_2) {
      self._id_2D65 show();
    }
  }
}

_id_18FA(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 playerlinkTo(var_1);

  while(var_0 getcurrentweapon() == self._id_A248) {
    waitframe();
  }

  var_0 unlink();
}

_id_18F9(var_0, var_1) {
  level notify("bomb_planted", var_0);
  var_2 = "allies";

  if(isDefined(var_1) && isDefined(var_1.team)) {
    var_2 = var_1.team;
  }

  if(!isDefined(level._id_686C)) {
    level._id_686C = 1;
  } else {
    level._id_686C++;
  }

  if(game["status"] == "overtime") {
    var_0 _id_04D1::_id_86EC(var_2);
  }

  maps\mp\gametypes\_gamelogic::_id_6F27();

  if(maps\mp\_utility::gethalftime() && game["status"] != "halftime") {
    _setgameendtime(gettime() + (int(maps\mp\gametypes\_gamelogic::_id_46E5()) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5)), 1);
  } else {
    _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
  }

  level._id_18F9 = 1;
  var_1._id_0112 = 0;

  if(isPlayer(var_1) && !level._id_6510) {
    var_1 setclientomnvar("ui_carrying_bomb", 0);
  }

  var_0._id_568E = 0;
  var_0._id_A582[0] thread maps\mp\gametypes\_gamelogic::_id_74E5();
  level._id_99C0 = var_0._id_A582[0];
  var_0 _id_04D1::_id_0C30("none");
  var_0 _id_04D1::_id_8A60("none");
  var_0._id_2CA0 = int(gettime() + level._id_1909 * 1000);
  var_3 = var_0 _id_04D1::_id_454C();
  var_4 = spawn("script_model", var_1.origin);
  var_4.angles = var_1.angles;
  var_4 setModel("npc_gen_s_and_d_bomb");
  level._id_2D65[var_3] = var_4;

  if(var_3 == "_a") {
    level.demobombateam = var_2;
  } else if(var_3 == "_b") {
    level.demobombbteam = var_2;
  }

  foreach(var_6 in level.players) {
    if(var_6.team == var_2) {
      var_6 setclientomnvar("ui_demo_bomb" + var_3 + "_state", 3);
      continue;
    }

    var_6 setclientomnvar("ui_demo_bomb" + var_3 + "_state", 1);
  }

  var_0._id_18F9 = 1;
  var_8 = var_0._id_18D5;
  var_8.origin = var_4.origin;
  var_8._id_7AC4 = undefined;
  var_9 = [];
  var_10 = _id_04D1::_id_2837(maps\mp\_utility::getotherteam(var_2), var_8, var_9, (0, 0, 32));
  var_10 _id_04D1::_id_0C30("friendly");
  var_10 _id_04D1::_id_8A5A(level._id_2CA9);
  var_10 _id_04D1::_id_8A57(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_10 _id_04D1::_id_8A60("any");
  var_10 _id_04D1::set2dicon("friendly", "waypoint_defuse" + var_3);
  var_10 _id_04D1::set2dicon("enemy", "waypoint_defend" + var_3);
  var_10 _id_04D1::playsoundtoteam("friendly", "waypoint_defuse" + var_3);
  var_10 _id_04D1::playsoundtoteam("enemy", "waypoint_defend" + var_3);
  var_10.label = var_3;
  var_10._id_6ABC = ::_id_6ABF;
  var_10._id_6AFA = ::_id_6AFC;
  var_10._id_6BBF = ::_id_6BC3;
  var_10._id_681A = 1;
  var_10._id_502A = "defuseObject";
  var_10._id_A248 = "search_dstry_bomb_defuse_mp";
  var_10._id_190E = var_0;
  var_10._id_2D65 = var_4;

  if(var_3 == "_a" || var_3 == "_A") {
    _setomnvar("ui_broadcaster_game_mode_status_1", 1);
  } else if(var_3 == "_b" || var_3 == "_B") {
    _setomnvar("ui_broadcaster_game_mode_status_1", 2);
  }

  maps\mp\_utility::playsoundinspace("mp_snd_bomb_planted", var_4.origin + (0, 0, 1));
  var_0 _id_190B(var_3);
  var_0._id_A582[0] maps\mp\gametypes\_gamelogic::_id_9415();

  if(level.gameended || var_0._id_568E) {
    return;
  }
  level._id_18EE = 1;
  _setomnvar("ui_broadcaster_game_mode_status_1", 0);

  if(var_3 == "_a") {
    level.demobombateam = "exploded";
  } else if(var_3 == "_b") {
    level.demobombbteam = "exploded";
  }

  foreach(var_6 in level.players) {
    var_6 setclientomnvar("ui_demo_bomb" + var_3 + "_state", 2);
  }

  var_13 = var_4.origin;
  var_13 = var_13 + (0, 0, 10);
  var_4 delete();
  var_0._id_18F9 = 0;

  if(isDefined(var_1)) {
    var_0._id_A582[0] radiusdamage(var_13, 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    var_1 thread _id_047A::_id_18D6();
  } else
    var_0._id_A582[0] radiusdamage(var_13, 512, 300, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

  var_14 = "bomb_explosion";

  if(isDefined(var_0._id_9D65._id_359B)) {
    var_14 = var_0._id_9D65._id_359B;
  }

  var_15 = _randomfloat(360);
  var_16 = var_13 + (0, 0, 50);
  var_17 = _spawnfx(level._effect[var_14], var_16 + (0, 0, 50), (0, 0, 1), (_cos(var_15), _sin(var_15), 0));
  _triggerfx(var_17);
  _physicsexplosionsphere(var_16, 200, 100, 3);
  _playrumbleonposition("grenade_rumble", var_13);
  _earthquake(0.75, 2.0, var_13, 2000);
  thread maps\mp\_utility::playsoundinspace("mp_snd_bomb_detonated", var_13);

  if(isDefined(var_0._id_3947)) {
    common_scripts\_exploder::exploder(var_0._id_3947);
  }

  var_10 _id_04D1::_id_2F93();
  var_10 _id_04D1::_id_2D58();
  _id_04D2::_id_47BD(var_2, 1, 1);

  if(!isDefined(level._id_6876)) {
    level._id_6876 = 1;
  } else {
    level._id_6876++;
  }

  if(level._id_6876 == 2) {
    _id_2D63(var_2, game["end_reason"]["target_destroyed"]);
  }

  if(maps\mp\_utility::gethalftime() && game["status"] != "halftime") {
    _setgameendtime(gettime() + (int(maps\mp\gametypes\_gamelogic::_id_46E5()) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5)), 1);
  } else {
    _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
  }

  level._id_686C--;

  if(level._id_686C < 1) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();
    level._id_18F9 = 0;
  }
}

_id_190B(var_0) {
  level endon("game_ended");
  self endon("bomb_defused");
  var_1 = int(level._id_1909 * 1000 + gettime());
  _setomnvar("ui_bomb" + var_0 + "_timer_endtime", var_1);
  thread _id_4ACC(var_0, var_1);
  maps\mp\gametypes\_hostmigration::_id_A6F4(level._id_1909);
}

_id_4ACC(var_0, var_1) {
  level endon("game_ended");
  level endon("game_ended");
  level endon("disconnect");
  self endon("bomb_defused");
  level waittill("host_migration_begin");
  _setomnvar("ui_bomb" + var_0 + "_timer_endtime", 0);
  var_2 = maps\mp\gametypes\_hostmigration::_id_A782();

  if(var_2 > 0) {
    _setomnvar("ui_bomb" + var_0 + "_timer_endtime", var_1 + var_2);
  }
}

_id_6BC3(var_0) {
  var_0 notify("bomb_defused");
  thread _id_18D3();
  level._id_686C--;

  if(level._id_686C < 1) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();

    if(maps\mp\_utility::gethalftime() && game["status"] != "halftime") {
      _setgameendtime(gettime() + (int(maps\mp\gametypes\_gamelogic::_id_46E5()) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5)), 1);
    } else {
      _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::_id_46E5()), 1);
    }

    level._id_18F9 = 0;
  }

  self._id_2D65 delete();
  self._id_190E._id_18F9 = 0;

  if(game["status"] == "overtime") {
    var_1 = "any";
  } else {
    var_1 = "enemy";
  }

  self._id_190E _id_04D1::_id_0C30(var_1);
  self._id_190E _id_04D1::_id_8A60("any");
  maps\mp\_utility::leaderdialog("bomb_defused_attackers", game["attackers"]);
  maps\mp\_utility::leaderdialog("bomb_defused_defenders", game["defenders"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_enemy_sound"], game["attackers"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_sound"], game["defenders"]);
  var_2 = "defuse";

  if(isDefined(self._id_190E._id_18F8) && maps\mp\_utility::isreallyalive(self._id_190E._id_18F8) && self._id_190E._id_18F8._id_18FB + 6000 + level._id_2CA9 * 1000 > gettime()) {
    var_2 = "ninja_defuse";
  }

  var_0 thread _id_047A::_id_18D4(var_2);
  var_0 thread _id_0468::_id_0A22("demoBombDefused");
  _id_04D1::_id_2F93();
  _id_04D1::_id_2D58();
}

_id_18D3() {
  self._id_190E maps\mp\gametypes\_gamelogic::_id_9415();
  self._id_190E._id_568E = 1;

  if(game["status"] == "overtime") {
    self._id_190E _id_04D1::_id_86EC("any");
  }

  if(self.label == "_a") {
    level.demobombateam = undefined;
  } else if(self.label == "_b") {
    level.demobombbteam = undefined;
  }

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_demo_bomb" + self.label + "_state", 0);
  }

  _setomnvar("ui_bomb" + self.label + "_timer_endtime", 0);
  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
  self._id_190E notify("bomb_defused");
}

_id_6AC9(var_0) {
  var_0 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

_id_6BB6() {
  if(game["teamScores"]["axis"] == game["teamScores"]["allies"]) {
    _id_2D63("tie", game["end_reason"]["time_limit_reached"]);
  } else if(game["teamScores"][game["defenders"]] > game["teamScores"]["allies"]) {
    _id_2D63(game["defenders"], game["end_reason"]["time_limit_reached"]);
  } else {
    _id_2D63(game["attackers"], game["end_reason"]["time_limit_reached"]);
  }
}

_id_6B42(var_0) {
  _id_2D63("halftime", game["end_reason"][var_0]);
}

_id_2D63(var_0, var_1) {
  level._id_3B5C = var_0;

  if(var_1 == game["end_reason"]["target_destroyed"]) {
    var_2 = 1;

    foreach(var_4 in level._id_1913) {
      if(isDefined(level._id_3B52[var_0]) && level._id_3B52[var_0] == var_4._id_5A2D) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      _id_04CE::_id_3801();
    }
  }

  if(game["status"] == "normal") {
    if(var_1 == game["end_reason"]["target_destroyed"]) {
      game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::getwatcheddvar("timelimit") * 60 * 1000 / 2.0;
    }

    var_0 = "halftime";
    var_1 = game["end_reason"]["switching_sides"];
  } else if(game["status"] == "halftime") {
    if(game["teamScores"]["axis"] == game["teamScores"]["allies"]) {
      var_0 = "overtime";
      var_1 = game["end_reason"]["switching_sides"];
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
      var_0 = "axis";
    else {
      var_0 = "allies";
    }
  }

  thread maps\mp\gametypes\_gamelogic::_id_36B9(var_0, var_1);
}

_id_21AB() {
  waitframe();
  var_0 = 0;

  if(!level._id_0BC3[game["attackers"]]) {
    level._id_90E2[game["attackers"]]._id_0C22 = 1;
    var_0 = 1;
  }

  if(!level._id_0BC3[game["defenders"]]) {
    level._id_90E2[game["defenders"]]._id_0C22 = 1;
    var_0 = 1;
  }

  if(var_0) {
    _id_050F::_id_A16A();
  }
}