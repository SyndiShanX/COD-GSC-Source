/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\demo.gsc
**********************************************/

main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread maps\mp\_utility::reinitializematchrulesonmigration();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 1, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 5);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 3);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 2);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 1);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  maps\mp\_utility::setovertimelimitdvar(2.5);
  level._id_2D64 = 1;
  maps\mp\_utility::_id_873B(1);
  level.halftimeonscorelimit = 0;
  level._id_6B86 = ::_id_6B86;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level._id_6B7B = ::_id_6B7B;
  level.ontimelimit = ::ontimelimit;
  level.onhalftime = ::onhalftime;
  level.onnormaldeath = ::onnormaldeath;
  level.gamemodemaydropweapon = ::isplayeroutsideofanybombsite;
  level._id_0C25 = 1;
  level._id_6876 = 0;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
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

initializematchrules() {
  maps\mp\_utility::setcommonrulesfrommatchrulesdata();
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

onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  _setomnvar("ui_war_attacker_team", maps\mp\_utility::getteamindex(game["attackers"]));

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
  thread updategametypedvars();
  thread bombs();
  level.halftime_switch_sides = maps\mp\_utility::dvarintvalue("halftimeswitchsides", 1, 0, 1);
}

onspawnplayer() {
  if(maps\mp\_utility::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
    self._id_0112 = 0;
  }

  if(isPlayer(self)) {
    if(level.multibomb && (self.pers["team"] == game["attackers"] || game["status"] == "overtime")) {
      self setclientomnvar("ui_carrying_bomb", 1);
      thread maps\mp\gametypes\_hud_message::splashnotify("bomb_pickedup");
    } else
      self setclientomnvar("ui_carrying_bomb", 0);
  }

  maps\mp\_utility::setextrascore0(0);

  if(isDefined(self.pers["plants"])) {
    maps\mp\_utility::setextrascore0(self.pers["plants"]);
  }

  maps\mp\_utility::setextrascore1(0);

  if(isDefined(self.pers["defuses"])) {
    maps\mp\_utility::setextrascore1(self.pers["defuses"]);
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

updategametypedvars() {
  level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.multibomb = maps\mp\_utility::dvarintvalue("multibomb", 0, 0, 1);
  level.silentplant = maps\mp\_utility::dvarintvalue("silentplant", 0, 0, 1);
  level._id_3992 = maps\mp\_utility::dvarintvalue("extraTime", 2, 0, 10);
}

isplayeroutsideofanybombsite(var_0) {
  if(isDefined(level.bombzones)) {
    foreach(var_2 in level.bombzones) {
      if(distancesquared(self.origin, var_2.trigger.origin) < 4096) {
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
  if(maps\mp\gametypes\_damage::isfriendlyfire(self, var_1)) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  var_10 = self;

  if(var_10.isplanting || var_10.isdefusing) {
    var_1 thread _id_047A::defendobjectiveevent(var_10, var_9, var_4);
    var_1 thread maps\mp\gametypes\_missions::_id_80BB(var_4, var_3);

    if(var_10.isplanting) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_interrupt");
    }

    if(var_10.isdefusing) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_protector");
    }
  }
}

onnormaldeath(var_0, var_1, var_2) {
  if(game["state"] == "postgame" && (var_0.team == game["defenders"] || !level.bombplanted)) {
    var_1.finalkill = 1;
  }
}

bombs() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.icontarget = "waypoint_caster_target";
  level.bombzones = [];
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

    var_11 = _id_04D1::createuseobject(var_9, var_2, var_3, (0, 0, 64));
    var_11 _id_04D1::_id_0C30(var_10);
    var_11 _id_04D1::setusetime(level.planttime);
    var_11 _id_04D1::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
    var_12 = var_11 _id_04D1::getlabel();
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
    var_11 _id_04D1::setvisibleteam("any");
    maps\mp\_utility::_id_863F(var_11, level.icontarget + var_12, 3);
    var_11.onbeginuse = ::_id_6ABE;
    var_11.onenduse = ::_id_6AFB;
    var_11.nousebar = 1;
    var_11.id = "bombZone";
    var_11.onuse = ::onuseplantobject;
    var_11.oncantuse = ::oncantuse;
    var_11.useweapon = "search_dstry_bomb_mp";
    var_11._id_568E = 0;
    var_11.bombplanted = 0;

    for(var_13 = 0; var_13 < var_3.size; var_13++) {
      if(isDefined(var_3[var_13].setdepthoffield)) {
        var_11.exploderindex = var_3[var_13].setdepthoffield;
        var_3[var_13] thread setupkillcament(var_11);
        break;
      }
    }

    level.bombzones[level.bombzones.size] = var_11;
    var_11.bombdefusetrig = _getEnt(var_3[0].target, "targetname");
    var_11.bombdefusetrig.origin = var_11.bombdefusetrig.origin + (0, 0, -10000);
    var_11.bombdefusetrig.label = var_12;
    var_11.bombdefusetrig usetriggertouchcheckstance(1);
  }

  for(var_1 = 0; var_1 < level.bombzones.size; var_1++) {
    var_14 = [];

    for(var_15 = 0; var_15 < level.bombzones.size; var_15++) {
      if(var_15 != var_1) {
        var_14[var_14.size] = level.bombzones[var_15];
      }
    }

    level.bombzones[var_1].otherbombzones = var_14;
  }

  _setomnvar("ui_broadcaster_game_mode_status_1", 0);
}

onuseplantobject(var_0) {
  if(!_id_04D1::isfriendlyteam(var_0.pers["team"]) || game["status"] == "overtime") {
    level thread bombplanted(self, var_0);
    var_0 playSound("mp_bomb_plant");
    var_0 notify("bomb_planted");
    var_0 thread _id_047A::bombplantevent();
    var_0 thread _id_0468::_id_0A22("demoBombPlanted");
    maps\mp\_utility::leaderdialog("bomb_planted");
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_sound"], game["attackers"]);
    maps\mp\_utility::playsoundonplayers(game["bomb_planted_enemy_sound"], game["defenders"]);
    self.bombowner = var_0;
    self.bombplanted = 1;
    var_0.bombplantedtime = gettime();
  } else
    self.bombplanted = 0;
}

play_looping_beep_on_player(var_0) {
  var_1 = common_scripts\utility::_id_0F93(level.players, var_0);

  if(var_1.size) {
    var_0 maps\mp\_utility::playloopsoundtoplayers("snd_bomb_button_press_lp", undefined, var_1);
  }
}

stop_looping_beep_on_player(var_0) {
  var_0 common_scripts\utility::stop_loop_sound_on_entity("snd_bomb_button_press_lp");
}

setupkillcament(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateYaw(-45, 0.05);
  waitframe();
  var_2 = self.origin + (0, 0, 5);
  var_3 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_4 = bulletTrace(var_2, var_3, 0, self);
  self.killcament = spawn("script_model", var_4["position"]);
  self.killcament setscriptmoverkillcam("explosive");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

_id_6ABF(var_0) {
  var_0 allowmelee(0);

  if(_id_04D1::isfriendlyteam(var_0.pers["team"])) {
    if(!level.silentplant && !var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
      var_0 maps\mp\_utility::notify_enemy_bots_bomb_used("defuse");
      var_0 playSound("mp_snd_bomb_disarming");
      level thread play_looping_beep_on_player(var_0);
    }

    var_0.isdefusing = 1;

    if(isDefined(self._id_2D65)) {
      self._id_2D65 hide();
    }
  }
}

_id_6ABE(var_0) {
  var_0 allowmelee(0);

  if(!level.silentplant && !var_0 maps\mp\_utility::_hasperk("specialty_improvedobjectives")) {
    var_0 maps\mp\_utility::notify_enemy_bots_bomb_used("plant");
    var_0 playSound("mp_snd_bomb_arming");
    level thread play_looping_beep_on_player(var_0);
  }

  var_0.isplanting = 1;
}

_id_6AFB(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 allowmelee(1);
  var_1.isplanting = 0;
  level thread stop_looping_beep_on_player(var_1);
}

_id_6AFC(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 allowmelee(1);
  var_1.isdefusing = 0;
  level thread stop_looping_beep_on_player(var_1);

  if(_id_04D1::isfriendlyteam(var_1.pers["team"])) {
    if(isDefined(self._id_2D65) && !var_2) {
      self._id_2D65 show();
    }
  }
}

bombplantedanim(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 playerlinkTo(var_1);

  while(var_0 getcurrentweapon() == self.useweapon) {
    waitframe();
  }

  var_0 unlink();
}

bombplanted(var_0, var_1) {
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
    var_0 _id_04D1::setownerteam(var_2);
  }

  maps\mp\gametypes\_gamelogic::pausetimer();

  if(maps\mp\_utility::gethalftime() && game["status"] != "halftime") {
    _setgameendtime(gettime() + (int(maps\mp\gametypes\_gamelogic::gettimeremaining()) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5)), 1);
  } else {
    _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
  }

  level.bombplanted = 1;
  var_1._id_0112 = 0;

  if(isPlayer(var_1) && !level.multibomb) {
    var_1 setclientomnvar("ui_carrying_bomb", 0);
  }

  var_0._id_568E = 0;
  var_0.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
  level.tickingobject = var_0.visuals[0];
  var_0 _id_04D1::_id_0C30("none");
  var_0 _id_04D1::setvisibleteam("none");
  var_0.defuseendtime = int(gettime() + level.bombtimer * 1000);
  var_3 = var_0 _id_04D1::getlabel();
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

  var_0.bombplanted = 1;
  var_8 = var_0.bombdefusetrig;
  var_8.origin = var_4.origin;
  var_8.realorigin = undefined;
  var_9 = [];
  var_10 = _id_04D1::createuseobject(maps\mp\_utility::getotherteam(var_2), var_8, var_9, (0, 0, 32));
  var_10 _id_04D1::_id_0C30("friendly");
  var_10 _id_04D1::setusetime(level.defusetime);
  var_10 _id_04D1::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_10 _id_04D1::setvisibleteam("any");
  var_10 _id_04D1::set2dicon("friendly", "waypoint_defuse" + var_3);
  var_10 _id_04D1::set2dicon("enemy", "waypoint_defend" + var_3);
  var_10 _id_04D1::playsoundtoteam("friendly", "waypoint_defuse" + var_3);
  var_10 _id_04D1::playsoundtoteam("enemy", "waypoint_defend" + var_3);
  var_10.label = var_3;
  var_10.onbeginuse = ::_id_6ABF;
  var_10.onenduse = ::_id_6AFC;
  var_10.onuse = ::onusedefuseobject;
  var_10.nousebar = 1;
  var_10.id = "defuseObject";
  var_10.useweapon = "search_dstry_bomb_defuse_mp";
  var_10._id_190E = var_0;
  var_10._id_2D65 = var_4;

  if(var_3 == "_a" || var_3 == "_A") {
    _setomnvar("ui_broadcaster_game_mode_status_1", 1);
  } else if(var_3 == "_b" || var_3 == "_B") {
    _setomnvar("ui_broadcaster_game_mode_status_1", 2);
  }

  maps\mp\_utility::playsoundinspace("mp_snd_bomb_planted", var_4.origin + (0, 0, 1));
  var_0 bombtimerwait(var_3);
  var_0.visuals[0] maps\mp\gametypes\_gamelogic::stoptickingsound();

  if(level.gameended || var_0._id_568E) {
    return;
  }
  level.bombexploded = 1;
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
  var_0.bombplanted = 0;

  if(isDefined(var_1)) {
    var_0.visuals[0] radiusdamage(var_13, 512, 300, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    var_1 thread _id_047A::bombdetonateevent();
  } else
    var_0.visuals[0] radiusdamage(var_13, 512, 300, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

  var_14 = "bomb_explosion";

  if(isDefined(var_0.trigger.effect)) {
    var_14 = var_0.trigger.effect;
  }

  var_15 = _randomfloat(360);
  var_16 = var_13 + (0, 0, 50);
  var_17 = _spawnfx(level._effect[var_14], var_16 + (0, 0, 50), (0, 0, 1), (_cos(var_15), _sin(var_15), 0));
  _triggerfx(var_17);
  _physicsexplosionsphere(var_16, 200, 100, 3);
  _playrumbleonposition("grenade_rumble", var_13);
  _earthquake(0.75, 2.0, var_13, 2000);
  thread maps\mp\_utility::playsoundinspace("mp_snd_bomb_detonated", var_13);

  if(isDefined(var_0.exploderindex)) {
    common_scripts\_exploder::exploder(var_0.exploderindex);
  }

  var_10 _id_04D1::disableobject();
  var_10 _id_04D1::deleteuseobject();
  _id_04D2::giveteamscoreforobjective(var_2, 1, 1);

  if(!isDefined(level._id_6876)) {
    level._id_6876 = 1;
  } else {
    level._id_6876++;
  }

  if(level._id_6876 == 2) {
    _id_2D63(var_2, game["end_reason"]["target_destroyed"]);
  }

  if(maps\mp\_utility::gethalftime() && game["status"] != "halftime") {
    _setgameendtime(gettime() + (int(maps\mp\gametypes\_gamelogic::gettimeremaining()) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5)), 1);
  } else {
    _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
  }

  level._id_686C--;

  if(level._id_686C < 1) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();
    level.bombplanted = 0;
  }
}

bombtimerwait(var_0) {
  level endon("game_ended");
  self endon("bomb_defused");
  var_1 = int(level.bombtimer * 1000 + gettime());
  _setomnvar("ui_bomb" + var_0 + "_timer_endtime", var_1);
  thread handlehostmigration(var_0, var_1);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

handlehostmigration(var_0, var_1) {
  level endon("game_ended");
  level endon("game_ended");
  level endon("disconnect");
  self endon("bomb_defused");
  level waittill("host_migration_begin");
  _setomnvar("ui_bomb" + var_0 + "_timer_endtime", 0);
  var_2 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_2 > 0) {
    _setomnvar("ui_bomb" + var_0 + "_timer_endtime", var_1 + var_2);
  }
}

onusedefuseobject(var_0) {
  var_0 notify("bomb_defused");
  thread bombdefused();
  level._id_686C--;

  if(level._id_686C < 1) {
    maps\mp\gametypes\_gamelogic::_id_7DFC();

    if(maps\mp\_utility::gethalftime() && game["status"] != "halftime") {
      _setgameendtime(gettime() + (int(maps\mp\gametypes\_gamelogic::gettimeremaining()) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5)), 1);
    } else {
      _setgameendtime(gettime() + int(maps\mp\gametypes\_gamelogic::gettimeremaining()), 1);
    }

    level.bombplanted = 0;
  }

  self._id_2D65 delete();
  self._id_190E.bombplanted = 0;

  if(game["status"] == "overtime") {
    var_1 = "any";
  } else {
    var_1 = "enemy";
  }

  self._id_190E _id_04D1::_id_0C30(var_1);
  self._id_190E _id_04D1::setvisibleteam("any");
  maps\mp\_utility::leaderdialog("bomb_defused_attackers", game["attackers"]);
  maps\mp\_utility::leaderdialog("bomb_defused_defenders", game["defenders"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_enemy_sound"], game["attackers"]);
  maps\mp\_utility::playsoundonplayers(game["bomb_disarm_sound"], game["defenders"]);
  var_2 = "defuse";

  if(isDefined(self._id_190E.bombowner) && maps\mp\_utility::isreallyalive(self._id_190E.bombowner) && self._id_190E.bombowner.bombplantedtime + 6000 + level.defusetime * 1000 > gettime()) {
    var_2 = "ninja_defuse";
  }

  var_0 thread _id_047A::bombdefuseevent(var_2);
  var_0 thread _id_0468::_id_0A22("demoBombDefused");
  _id_04D1::disableobject();
  _id_04D1::deleteuseobject();
}

bombdefused() {
  self._id_190E maps\mp\gametypes\_gamelogic::stoptickingsound();
  self._id_190E._id_568E = 1;

  if(game["status"] == "overtime") {
    self._id_190E _id_04D1::setownerteam("any");
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

oncantuse(var_0) {
  var_0 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

ontimelimit() {
  if(game["teamScores"]["axis"] == game["teamScores"]["allies"]) {
    _id_2D63("tie", game["end_reason"]["time_limit_reached"]);
  } else if(game["teamScores"][game["defenders"]] > game["teamScores"]["allies"]) {
    _id_2D63(game["defenders"], game["end_reason"]["time_limit_reached"]);
  } else {
    _id_2D63(game["attackers"], game["end_reason"]["time_limit_reached"]);
  }
}

onhalftime(var_0) {
  _id_2D63("halftime", game["end_reason"][var_0]);
}

_id_2D63(var_0, var_1) {
  level.finalkillcam_winner = var_0;

  if(var_1 == game["end_reason"]["target_destroyed"]) {
    var_2 = 1;

    foreach(var_4 in level.bombzones) {
      if(isDefined(level.finalkillcam_killcamentityindex[var_0]) && level.finalkillcam_killcamentityindex[var_0] == var_4.killcamentnum) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      _id_04CE::erasefinalkillcam();
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

  thread maps\mp\gametypes\_gamelogic::endgame(var_0, var_1);
}

checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!level._id_0BC3[game["attackers"]]) {
    level.spectateoverride[game["attackers"]]._id_0C22 = 1;
    var_0 = 1;
  }

  if(!level._id_0BC3[game["defenders"]]) {
    level.spectateoverride[game["defenders"]]._id_0C22 = 1;
    var_0 = 1;
  }

  if(var_0) {
    _id_050F::updatespectatesettings();
  }
}