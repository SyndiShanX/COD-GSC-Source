/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\siege.gsc
******************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 3, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 5);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 1);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 0);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 4);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 1);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    scripts\mp\utility::registerwinbytwoenableddvar(level.gametype, 1);
    scripts\mp\utility::registerwinbytwomaxroundsdvar(level.gametype, 4);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.gamehasstarted = 0;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.lastcaptime = gettime();
  level.alliesprevflagcount = 0;
  level.axisprevflagcount = 0;
  level.allowlatecomers = 0;
  level.gametimerbeeps = 0;
  level.rushtimerteam = "none";
  level.siegeflagcapturing = [];
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "reinforce";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";
  game["dialog"]["revived"] = "sr_rev";
  game["dialog"]["enemy_captured_2"] = "enemy_captured_2";
  game["dialog"]["friendly_captured_2"] = "friendly_captured_2";
  game["dialog"]["lastalive_zones"] = "lastalive_zones";
  setomnvar("ui_allies_alive", 0);
  setomnvar("ui_axis_alive", 0);
  thread onplayerconnect();
  thread onplayerjointeam();
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_siege_rushTimer", getmatchrulesdata("siegeData", "rushTimer"));
  setdynamicdvar("scr_siege_rushTimerAmount", getmatchrulesdata("siegeData", "rushTimerAmount"));
  setdynamicdvar("scr_siege_sharedRushTimer", getmatchrulesdata("siegeData", "sharedRushTimer"));
  setdynamicdvar("scr_siege_preCapPoints", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("scr_siege_capRate", getmatchrulesdata("siegeData", "capRate"));
  setdynamicdvar("scr_siege_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("siege", 0);
  setdynamicdvar("scr_siege_promode", 0);
}

seticonnames() {
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

onstartgametype() {
  seticonnames();
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_DOM");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_DOM");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_DOM_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_DOM_HINT");
  initspawns();
  var_02[0] = "dom";
  scripts\mp\gameobjects::main(var_02);
  thread domflags();
  thread watchflagtimerpause();
  thread watchgameinactive();
  thread watchgamestart();
  thread removedompoint();
  thread placedompoint();
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.rushtimer = scripts\mp\utility::dvarintvalue("rushTimer", 1, 0, 1);
  level.rushtimeramount = scripts\mp\utility::dvarfloatvalue("rushTimerAmount", 45, 30, 120);
  level.sharedrushtimer = scripts\mp\utility::dvarfloatvalue("sharedRushTimer", 0, 0, 1);
  level.precappoints = scripts\mp\utility::dvarintvalue("preCapPoints", 0, 0, 1);
  level.caprate = scripts\mp\utility::dvarfloatvalue("capRate", 7.5, 1, 10);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Domination");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_00 = self.pers["team"];
  var_01 = scripts\mp\utility::getotherteam(var_00);
  if(level.usestartspawns) {
    if(game["switchedsides"]) {
      var_02 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_01 + "_start");
      var_03 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_02);
    } else {
      var_02 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_02 + "_start");
      var_03 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_03);
    }
  } else {
    var_04 = getteamdompoints(var_02);
    var_05 = scripts\mp\utility::getotherteam(var_00);
    var_06 = getteamdompoints(var_05);
    var_07 = getpreferreddompoints(var_04, var_06);
    var_02 = scripts\mp\spawnlogic::getteamspawnpoints(var_00);
    var_08 = [];
    var_08["preferredDomPoints"] = var_07;
    var_03 = scripts\mp\spawnscoring::getspawnpoint(var_02, undefined, var_08);
  }

  return var_03;
}

getteamdompoints(param_00) {
  var_01 = [];
  foreach(var_03 in level.domflags) {
    if(var_03.ownerteam == param_00) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

getpreferreddompoints(param_00, param_01) {
  var_02 = [];
  var_02[0] = 0;
  var_02[1] = 0;
  var_02[2] = 0;
  var_03 = self.pers["team"];
  if(param_00.size == level.domflags.size) {
    var_04 = var_03;
    var_05 = level.bestspawnflag[var_03];
    var_02[var_05.useobj.dompointnumber] = 1;
    return var_02;
  }

  if(var_02.size > 0) {
    foreach(var_07 in var_02) {
      var_04[var_07.dompointnumber] = 1;
    }

    return var_04;
  }

  if(var_05.size == 0) {
    var_04 = var_08;
    var_05 = level.bestspawnflag[var_08];
    if(var_04.size > 0 && var_04.size < level.domflags.size) {
      var_08 = _meth_81EF(var_07, undefined);
      level.bestspawnflag[var_07] = var_08;
    }

    var_05[var_08.useobj.dompointnumber] = 1;
    return var_05;
  }

  return var_07;
}

gettimesincedompointcapture(param_00) {
  return gettime() - param_00.capturetime;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00._domflageffect = [];
    var_00._domflagpulseeffect = [];
    var_00.ui_dom_securing = undefined;
    var_00.ui_dom_stalemate = undefined;
    var_00 thread onplayerspawned();
    var_00 thread scripts\mp\gametypes\obj_dom::ondisconnect();
    var_00.siegelatecomer = 1;
    var_00 thread onplayerdisconnected();
  }
}

onplayerdisconnected() {
  for(;;) {
    self waittill("disconnect");
    foreach(var_01 in self._domflageffect) {
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }

    func_12E58();
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned");
    scripts\mp\utility::setextrascore0(0);
    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility::setextrascore0(self.pers["captures"]);
    }

    scripts\mp\utility::setextrascore1(0);
    if(isDefined(self.pers["rescues"])) {
      scripts\mp\utility::setextrascore1(self.pers["rescues"]);
    }
  }
}

onplayerjointeam() {
  level endon("game_ended");
  for(;;) {
    level waittill("joined_team", var_00);
    if(scripts\mp\utility::gamehasstarted()) {
      var_00.siegelatecomer = 1;
    }
  }
}

onspawnplayer() {
  func_12E58();
  level notify("spawned_player");
}

checkallowspectating() {
  wait(0.05);
  var_00 = 0;
  if(!level.alivecount[game["attackers"]]) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_00 = 1;
  }

  if(!level.alivecount[game["defenders"]]) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_00 = 1;
  }

  if(var_00) {
    scripts\mp\spectating::updatespectatesettings();
  }
}

domflags() {
  level endon("game_ended");
  level.var_AA1D["allies"] = 0;
  level.var_AA1D["axis"] = 0;
  var_00 = getEntArray("flag_primary", "targetname");
  var_01 = getEntArray("flag_secondary", "targetname");
  if(var_00.size + var_01.size < 2) {
    return;
  }

  level.magicbullet = [];
  var_02 = "mp\siegeFlagPos.csv";
  var_03 = scripts\mp\utility::getmapname();
  var_04 = 1;
  for(var_05 = 2; var_05 < 11; var_05++) {
    var_06 = tablelookup(var_02, var_04, var_03, var_05);
    if(var_06 != "") {
      setflagpositions(var_05, float(var_06));
    }
  }

  for(var_07 = 0; var_07 < var_00.size; var_07++) {
    level.magicbullet[level.magicbullet.size] = var_00[var_07];
  }

  for(var_07 = 0; var_07 < var_01.size; var_07++) {
    level.magicbullet[level.magicbullet.size] = var_01[var_07];
  }

  level.domflags = [];
  for(var_07 = 0; var_07 < level.magicbullet.size; var_07++) {
    var_08 = level.magicbullet[var_07];
    var_08.origin = getflagpos(var_08.script_label, var_08.origin);
    if(isDefined(var_08.target)) {
      var_09[0] = getent(var_08.target, "targetname");
    } else {
      var_09[0] = spawn("script_model", var_08.origin);
      var_09[0].angles = var_08.angles;
    }

    var_0A = scripts\mp\gameobjects::createuseobject("neutral", var_08, var_09, (0, 0, 100));
    var_0A scripts\mp\gameobjects::allowuse("enemy");
    var_0A scripts\mp\gameobjects::setusetime(level.caprate);
    var_0A scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
    var_0B = var_0A scripts\mp\gameobjects::getlabel();
    var_0A.label = var_0B;
    var_0A scripts\mp\gameobjects::set2dicon("friendly", "waypoint_defend" + var_0B);
    var_0A scripts\mp\gameobjects::set3dicon("friendly", "waypoint_defend" + var_0B);
    var_0A scripts\mp\gameobjects::set2dicon("enemy", "waypoint_captureneutral" + var_0B);
    var_0A scripts\mp\gameobjects::set3dicon("enemy", "waypoint_captureneutral" + var_0B);
    var_0A scripts\mp\gameobjects::setvisibleteam("any");
    var_0A scripts\mp\gameobjects::cancontestclaim(1);
    var_0A.onuse = ::onuse;
    var_0A.onbeginuse = ::onbeginuse;
    var_0A.onuseupdate = ::onuseupdate;
    var_0A.onenduse = ::onenduse;
    var_0A.oncontested = ::oncontested;
    var_0A.onuncontested = ::onuncontested;
    var_0A.nousebar = 1;
    var_0A.id = "domFlag";
    var_0A.firstcapture = 1;
    var_0A.prevteam = "neutral";
    var_0A.flagcapsuccess = 0;
    var_0A.playersrevived = 0;
    var_0A.claimgracetime = level.caprate * 1000;
    var_0C = var_09[0].origin + (0, 0, 32);
    var_0D = var_09[0].origin + (0, 0, -32);
    var_0E = bulletTrace(var_0C, var_0D, 0, undefined);
    var_0F = scripts\mp\gametypes\obj_dom::checkmapoffsets(var_0A.label);
    var_0A.baseeffectpos = var_0E["position"] + var_0F;
    var_10 = vectortoangles(var_0E["normal"]);
    var_11 = scripts\mp\gametypes\obj_dom::checkmapfxangles(var_0A.label, var_10);
    var_0A.baseeffectforward = anglesToForward(var_11);
    var_12 = spawn("script_model", var_0A.baseeffectpos);
    var_12 setModel("dom_flag_scriptable");
    var_12.angles = generateaxisanglesfromforwardvector(var_0A.baseeffectforward, var_12.angles);
    var_0A.physics_capsulecast = var_12;
    var_0A.vfxnamemod = "";
    if(var_0A.trigger.fgetarg == 160) {
      var_0A.vfxnamemod = "_160";
    } else if(var_0A.trigger.fgetarg == 90) {
      var_0A.vfxnamemod = "_90";
    }

    var_0A scripts\engine\utility::delaythread(1, ::setneutral);
    level.magicbullet[var_07].useobj = var_0A;
    var_0A.levelflag = level.magicbullet[var_07];
    level.domflags[level.domflags.size] = var_0A;
  }

  var_13 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
  var_14 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
  level.areanynavvolumesloaded["allies"] = var_14[0].origin;
  level.areanynavvolumesloaded["axis"] = var_13[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["allies"] = _meth_81EF("allies", undefined);
  level.bestspawnflag["axis"] = _meth_81EF("axis", level.bestspawnflag["allies"]);
  if(level.precappoints) {
    func_110AB();
    var_15 = [];
    var_15[var_15.size] = level.var_3BB4;
    if(game["switchedsides"]) {
      level.var_429F = _meth_81EF("axis", level.var_3BB4);
      var_15[var_15.size] = level.var_429F;
      level.var_42A0 = _meth_81EF("allies", var_15);
    } else {
      level.var_429F = _meth_81EF("allies", level.var_3BB4);
      var_15[var_15.size] = level.var_429F;
      level.var_42A0 = _meth_81EF("axis", var_15);
    }

    level scripts\engine\utility::delaythread(1.5, ::precap);
  }

  flagsetup();
}

precap() {
  level.var_429F.useobj setflagcaptured("allies", "neutral", undefined, 1);
  level.var_42A0.useobj setflagcaptured("axis", "neutral", undefined, 1);
}

setneutral() {
  thread scripts\mp\gametypes\obj_dom::domflag_setneutral();
}

setflagpositions(param_00, param_01) {
  switch (param_00) {
    case 2:
      level.siege_a_xpos = param_01;
      break;

    case 3:
      level.siege_a_ypos = param_01;
      break;

    case 4:
      level.siege_a_zpos = param_01;
      break;

    case 5:
      level.siege_b_xpos = param_01;
      break;

    case 6:
      level.siege_b_ypos = param_01;
      break;

    case 7:
      level.siege_b_zpos = param_01;
      break;

    case 8:
      level.siege_c_xpos = param_01;
      break;

    case 9:
      level.siege_c_ypos = param_01;
      break;

    case 10:
      level.siege_c_zpos = param_01;
      break;
  }
}

getflagpos(param_00, param_01) {
  var_02 = param_01;
  if(param_00 == "_a") {
    if(isDefined(level.siege_a_xpos) && isDefined(level.siege_a_ypos) && isDefined(level.siege_a_zpos)) {
      var_02 = (level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos);
    }
  } else if(param_00 == "_b") {
    if(isDefined(level.siege_b_xpos) && isDefined(level.siege_b_ypos) && isDefined(level.siege_b_zpos)) {
      var_02 = (level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos);
    }
  } else if(isDefined(level.siege_c_xpos) && isDefined(level.siege_c_ypos) && isDefined(level.siege_c_zpos)) {
    var_02 = (level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos);
  }

  return var_02;
}

func_110AB() {
  var_00 = undefined;
  foreach(var_02 in level.magicbullet) {
    if(var_02.script_label == "_b") {
      level.var_3BB4 = var_02;
    }
  }
}

watchflagtimerpause() {
  level endon("game_ended");
  for(;;) {
    level waittill("flag_capturing", var_00);
    if(level.rushtimer) {
      var_01 = scripts\mp\utility::getotherteam(var_00.prevteam);
      if(var_00.prevteam != "neutral" && isDefined(level.siegetimerstate) && level.siegetimerstate != "pause" && !iswinningteam(var_01)) {
        level.gametimerbeeps = 0;
        level.siegetimerstate = "pause";
        pausecountdowntimer();
        if(!flagownersalive(var_00.prevteam)) {
          setwinner(var_01, var_00.prevteam + "_eliminated");
        }
      }
    }
  }
}

iswinningteam(param_00) {
  var_01 = 0;
  var_02 = getflagcount(param_00);
  if(var_02 == 2) {
    var_01 = 1;
  }

  return var_01;
}

flagownersalive(param_00) {
  var_01 = 0;
  foreach(var_03 in level.participants) {
    if(isDefined(var_03) && var_03.team == param_00 && scripts\mp\utility::isreallyalive(var_03) || var_03.pers["lives"] > 0) {
      var_01 = 1;
      break;
    }
  }

  return var_01;
}

pausecountdowntimer() {
  if(!level.timerstoppedforgamemode) {
    var_00 = level.rushtimeramount;
    if(isDefined(level.siegetimeleft)) {
      var_00 = level.siegetimeleft;
    }

    var_01 = int(gettime() + var_00 * 1000);
    scripts\mp\gamelogic::pausetimer(var_01);
  }

  level notify("siege_timer_paused");
}

resumecountdowntimer(param_00) {
  var_01 = level.rushtimeramount;
  if(level.timerstoppedforgamemode) {
    if(isDefined(level.siegetimeleft)) {
      var_01 = level.siegetimeleft;
    }

    var_02 = int(gettime() + var_01 * 1000);
    setgameendtime(var_02);
    scripts\mp\gamelogic::resumetimer(var_02);
    if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
      level.siegetimerstate = "start";
    }

    thread watchgametimer(var_01);
    if(scripts\mp\utility::istrue(param_00)) {
      if(level.siegeflagcapturing.size > 0) {
        level notify("flag_capturing", self);
        return;
      }
    }
  }
}

watchflagenduse(param_00) {
  level endon("game_ended");
  var_01 = 0;
  var_02 = 0;
  var_03 = level.rushtimerteam;
  var_01 = getflagcount("allies");
  var_02 = getflagcount("axis");
  if(level.rushtimerteam != "none") {
    if(level.sharedrushtimer || var_01 == 1 && var_02 == 1) {
      level.siegetimerstate = "start";
      notifyplayers("siege_timer_start");
      resumecountdowntimer(1);
      return;
    }
  }

  if(var_01 == 2 || var_02 == 2) {
    level.rushtimerteam = scripts\engine\utility::ter_op(var_01 > var_02, "allies", "axis");
    if(var_03 != level.rushtimerteam) {
      if(level.rushtimer) {
        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "reset") {
          level.gametimerbeeps = 0;
          level.siegetimeleft = undefined;
          level.siegetimerstate = "reset";
          notifyplayers("siege_timer_reset");
        }

        if(!isDefined(level.siegetimerstate) || level.siegetimerstate != "start") {
          var_04 = level.rushtimeramount;
          if(isDefined(level.siegetimeleft)) {
            var_04 = level.siegetimeleft;
          }

          var_05 = int(gettime() + var_04 * 1000);
          foreach(var_07 in level.players) {
            var_07 setclientomnvar("ui_bomb_timer", 0);
          }

          level.timelimitoverride = 1;
          scripts\mp\gamelogic::pausetimer(var_05);
          setgameendtime(var_05);
          scripts\mp\gamelogic::resumetimer(var_05);
          if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
            level.siegetimerstate = "start";
            notifyplayers("siege_timer_start");
          }

          if(!level.gametimerbeeps) {
            thread watchgametimer(var_04);
          }
        }
      }
    } else if((var_03 == level.rushtimerteam && var_01 == 1) || var_03 == level.rushtimerteam && var_02 == 1) {
      resumecountdowntimer(1);
    } else {
      level.gametimerbeeps = 0;
      level.siegetimeleft = undefined;
      level.siegetimerstate = "reset";
      notifyplayers("siege_timer_reset");
      resumecountdowntimer(1);
    }
  } else if(var_01 == 3) {
    setwinner("allies", "score_limit_reached");
  } else if(var_02 == 3) {
    setwinner("axis", "score_limit_reached");
  }

  self.prevteam = self.ownerteam;
}

watchgameinactive() {
  level endon("game_ended");
  level endon("flag_capturing");
  var_00 = getdvarfloat("scr_siege_timelimit");
  if(var_00 > 0) {
    var_01 = var_00 * 60 - 1;
    while(var_01 > 0) {
      var_01 = var_01 - 1;
      wait(1);
    }

    level.siegegameinactive = 1;
  }
}

watchgamestart() {
  level endon("game_ended");
  scripts\mp\utility::gameflagwait("prematch_done");
  while(!havespawnedplayers()) {
    scripts\engine\utility::waitframe();
  }

  level.gamehasstarted = 1;
}

havespawnedplayers() {
  if(level.teambased) {
    return level.hasspawned["axis"] && level.hasspawned["allies"];
  }

  return level.maxplayercount > 1;
}

watchgametimer(param_00) {
  level endon("game_ended");
  level endon("siege_timer_paused");
  level endon("siege_timer_reset");
  var_01 = param_00;
  var_02 = spawn("script_origin", (0, 0, 0));
  var_02 hide();
  level.gametimerbeeps = 1;
  while(var_01 > 0) {
    var_01 = var_01 - 1;
    level.siegetimeleft = var_01;
    if(var_01 <= 30) {
      if(var_01 != 0) {
        var_02 playSound("ui_mp_timer_countdown");
      }
    }

    wait(1);
  }

  ontimelimit();
}

getflagcount(param_00) {
  var_01 = 0;
  foreach(var_03 in level.domflags) {
    if(var_03.ownerteam == param_00 && !isbeingcaptured(var_03)) {
      var_01 = var_01 + 1;
    }
  }

  return var_01;
}

isbeingcaptured(param_00) {
  var_01 = 0;
  if(isDefined(param_00)) {
    if(level.siegeflagcapturing.size > 0) {
      foreach(var_03 in level.siegeflagcapturing) {
        if(param_00.label == var_03) {
          var_01 = 1;
        }
      }
    }
  }

  return var_01;
}

setwinner(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(!isai(var_03)) {
      var_03 setclientomnvar("ui_objective_state", 0);
      var_03 setclientomnvar("ui_bomb_timer", 0);
    }
  }

  thread scripts\mp\gamelogic::endgame(param_00, game["end_reason"][param_01]);
}

onbeginuse(param_00) {
  var_01 = scripts\mp\gameobjects::getownerteam();
  self.didstatusnotify = 0;
  scripts\mp\gameobjects::setusetime(level.caprate);
  level.siegeflagcapturing[level.siegeflagcapturing.size] = self.label;
  level notify("flag_capturing", self);
  thread scripts\mp\gameobjects::useobjectdecay(param_00.team);
}

onuse(param_00) {
  var_01 = param_00.team;
  var_02 = scripts\mp\gameobjects::getownerteam();
  self.capturetime = gettime();
  setflagcaptured(var_01, var_02, param_00);
  level.usestartspawns = 0;
  if(var_02 == "neutral") {
    var_03 = scripts\mp\utility::getotherteam(var_01);
    thread scripts\mp\utility::printandsoundoneveryone(var_01, var_03, undefined, undefined, "mp_dom_flag_captured", undefined, param_00);
    var_04 = getteamflagcount(var_01);
    if(var_04 < level.magicbullet.size) {
      if(var_04 == 2) {
        scripts\mp\utility::statusdialog("friendly_captured_2", var_01);
        scripts\mp\utility::statusdialog("enemy_captured_2", var_03, 1);
      } else {
        scripts\mp\utility::statusdialog("secured" + self.label, var_01);
        scripts\mp\utility::statusdialog("enemy_has" + self.label, var_03, 1);
      }
    }
  }

  thread giveflagcapturexp(self.touchlist[var_01], var_02);
}

onuseupdate(param_00, param_01, param_02, param_03) {
  var_04 = scripts\mp\gameobjects::getownerteam();
  if(param_01 > 0.05 && param_02 && !self.didstatusnotify) {
    if(var_04 == "neutral") {
      scripts\mp\utility::statusdialog("securing" + self.label, param_00);
      self.prevownerteam = scripts\mp\utility::getotherteam(param_00);
    } else {
      scripts\mp\utility::statusdialog("losing" + self.label, var_04, 1);
      scripts\mp\utility::statusdialog("securing" + self.label, param_00);
    }

    if(!isagent(param_03)) {
      scripts\mp\gametypes\obj_dom::updateflagcapturestate(param_00);
    }

    scripts\mp\gameobjects::setzonestatusicons(level.iconlosing + self.label, level.icontaking + self.label);
    self.didstatusnotify = 1;
  }
}

onenduse(param_00, param_01, param_02) {
  checkendgame();
  if(isplayer(param_01)) {
    param_01 setclientomnvar("ui_objective_state", 0);
    param_01.ui_dom_securing = undefined;
  }

  if(param_02) {
    self.flagcapsuccess = 1;
  } else {
    self.flagcapsuccess = 0;
    resumecountdowntimer();
  }

  var_03 = scripts\mp\gameobjects::getownerteam();
  if(var_03 == "neutral") {
    scripts\mp\gameobjects::setzonestatusicons(level.iconneutral + self.label);
    scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
    scripts\mp\gametypes\obj_dom::updateflagstate(var_03, 0);
  }

  level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.label);
}

oncontested() {
  scripts\mp\gameobjects::setzonestatusicons(level.iconcontested + self.label);
  scripts\mp\gametypes\obj_dom::updateflagstate("contested", 0);
  if(level.rushtimerteam == self.ownerteam) {
    resumecountdowntimer();
  }
}

onuncontested(param_00) {
  checkendgame();
  var_01 = scripts\mp\gameobjects::getownerteam();
  if(param_00 == "none" || var_01 == "neutral") {
    scripts\mp\gameobjects::setzonestatusicons(level.iconneutral + self.label);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
  }

  var_02 = scripts\engine\utility::ter_op(var_01 == "neutral", "idle", var_01);
  scripts\mp\gametypes\obj_dom::updateflagstate(var_02, 0);
}

_meth_81EF(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  foreach(var_06 in level.magicbullet) {
    if(var_06.useobj getflagteam() != "neutral") {
      continue;
    }

    var_07 = distancesquared(var_06.origin, level.areanynavvolumesloaded[param_00]);
    if(isDefined(param_01)) {
      if(!func_9DF8(var_06, param_01) && !isDefined(var_02) || var_07 < var_03) {
        var_03 = var_07;
        var_02 = var_06;
      }

      continue;
    }

    if(!isDefined(var_02) || var_07 < var_03) {
      var_03 = var_07;
      var_02 = var_06;
    }
  }

  return var_02;
}

func_9DF8(param_00, param_01) {
  var_02 = 0;
  if(isarray(param_01)) {
    foreach(var_04 in param_01) {
      if(param_00 == var_04) {
        var_02 = 1;
        break;
      }
    }
  } else if(param_00 == param_01) {
    var_02 = 1;
  }

  return var_02;
}

ondeadevent(param_00) {
  if(scripts\mp\utility::gamehasstarted()) {
    if(param_00 == "all") {
      ontimelimit();
      return;
    }

    if(param_00 == game["attackers"]) {
      if(getflagcount(param_00) == 2) {
        return;
      }

      setwinner(game["defenders"], game["attackers"] + "_eliminated");
      return;
    }

    if(param_00 == game["defenders"]) {
      if(getflagcount(param_00) == 2) {
        return;
      }

      setwinner(game["attackers"], game["defenders"] + "_eliminated");
      return;
    }

    return;
  }
}

ononeleftevent(param_00) {
  var_01 = scripts\mp\utility::getlastlivingplayer(param_00);
  var_01 thread givelastonteamwarning();
}

func_12E58() {
  if(isDefined(level.alive_players["allies"])) {
    setomnvar("ui_allies_alive", level.alive_players["allies"].size);
  }

  if(isDefined(level.alive_players["axis"])) {
    setomnvar("ui_axis_alive", level.alive_players["axis"].size);
  }
}

onplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  func_12E58();
  if(!isplayer(param_01) || param_01.team == self.team) {
    return;
  }

  if(!flagownersalive(self.team) && getteamflagcount(self.team) == 2) {
    scripts\mp\utility::statusdialog("objs_capture", param_01.team, 1);
  }

  var_0A = 0;
  var_0B = 0;
  var_0C = 0;
  var_0D = self;
  var_0E = var_0D.team;
  var_0F = var_0D.origin;
  var_10 = param_01.team;
  var_11 = param_01.origin;
  var_12 = 0;
  if(isDefined(param_00)) {
    var_11 = param_00.origin;
    var_12 = param_00 == param_01;
  }

  foreach(var_14 in param_01.touchtriggers) {
    if(var_14 != level.magicbullet[0] && var_14 != level.magicbullet[1] && var_14 != level.magicbullet[2]) {
      continue;
    }

    var_15 = var_14.useobj.ownerteam;
    if(var_10 != var_15) {
      if(!var_0A) {
        var_0A = 1;
      }

      continue;
    }
  }

  foreach(var_14 in level.magicbullet) {
    var_15 = var_14.useobj.ownerteam;
    if(var_15 == "neutral") {
      var_18 = param_01 istouching(var_14);
      var_19 = var_0D istouching(var_14);
      if(var_18 || var_19) {
        if(var_14.useobj.claimteam == var_0E) {
          if(!var_0B) {
            if(var_0A) {
              param_01 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
            }

            var_0B = 1;
            param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            thread scripts\mp\matchdata::loginitialstats(param_09, "assaulting");
            continue;
          }
        } else if(var_14.useobj.claimteam == var_10) {
          if(!var_0C) {
            if(var_0A) {
              param_01 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
            }

            var_0C = 1;
            param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
            param_01 scripts\mp\utility::incperstat("defends", 1);
            param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
            thread scripts\mp\matchdata::loginitialstats(param_09, "defending");
            continue;
          }
        }
      }

      continue;
    }

    if(var_15 != var_10) {
      if(!var_0B) {
        var_1A = distsquaredcheck(var_14, var_11, var_0F);
        if(var_1A) {
          if(var_0A) {
            param_01 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
          }

          var_0B = 1;
          param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          thread scripts\mp\matchdata::loginitialstats(param_09, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!var_0C) {
      var_1B = distsquaredcheck(var_14, var_11, var_0F);
      if(var_1B) {
        if(var_0A) {
          param_01 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
        }

        var_0C = 1;
        param_01 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        param_01 scripts\mp\utility::incperstat("defends", 1);
        param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
        thread scripts\mp\matchdata::loginitialstats(param_09, "defending");
        continue;
      }
    }
  }
}

distsquaredcheck(param_00, param_01, param_02) {
  var_03 = distancesquared(param_00.origin, param_01);
  var_04 = distancesquared(param_00.origin, param_02);
  if(var_03 < 105625 || var_04 < 105625) {
    if(!isDefined(param_00.modifieddefendcheck)) {
      return 1;
    }

    if(param_01[2] - param_00.origin[2] < 100 || param_02[2] - param_00.origin[2] < 100) {
      return 1;
    }

    return 0;
  }

  return 0;
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility::waittillrecoveredhealth(3);
  var_00 = scripts\mp\utility::getotherteam(self.pers["team"]);
  level thread scripts\mp\utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\utility::teamplayercardsplash("callout_lastenemyalive", self, var_00);
  scripts\mp\music_and_dialog::func_C54B(self);
  scripts\mp\missions::lastmansd();
}

ontimelimit() {
  if(isDefined(level.siegegameinactive)) {
    level thread scripts\mp\gamelogic::forceend();
    return;
  }

  var_00 = getflagcount("allies");
  var_01 = getflagcount("axis");
  if(var_00 > var_01) {
    setwinner("allies", "time_limit_reached");
    return;
  }

  if(var_01 > var_00) {
    setwinner("axis", "time_limit_reached");
    return;
  }

  if(var_01 == var_00) {
    var_02 = scripts\mp\gamelogic::func_7E07();
    setwinner(var_02, "time_limit_reached");
    return;
  }

  setwinner("tie", "time_limit_reached");
}

teamrespawn(param_00, param_01) {
  var_02 = scripts\mp\utility::getteamarray(param_01.team).size;
  if(!isDefined(param_01.rescuedplayers)) {
    param_01.rescuedplayers = [];
  }

  foreach(var_04 in level.participants) {
    if(isDefined(var_04) && var_04.team == param_00 && !scripts\mp\utility::isreallyalive(var_04) && !scripts\engine\utility::array_contains(level.alive_players[var_04.team], var_04) && !isDefined(var_04.waitingtoselectclass) || !var_04.waitingtoselectclass) {
      if(isDefined(var_04.siegelatecomer) && var_04.siegelatecomer) {
        var_04.siegelatecomer = 0;
      }

      if(!scripts\mp\utility::istrue(var_04.pers["teamKillPunish"])) {
        var_04 scripts\mp\playerlogic::incrementalivecount(var_04.team);
        var_04.alreadyaddedtoalivecount = 1;
        var_04 thread func_136F9();
        var_04 func_12E58();
        var_04 thread scripts\mp\hud_message::showsplash("sr_respawned");
        level notify("sr_player_respawned", var_04);
        var_04 scripts\mp\utility::leaderdialogonplayer("revived");
      }

      param_01 scripts\mp\missions::processchallenge("ch_rescuer");
      param_01.rescuedplayers[var_04.guid] = 1;
      if(param_01.rescuedplayers.size == 4) {
        param_01 scripts\mp\missions::processchallenge("ch_helpme");
      }
    }
  }

  if(param_01.rescuedplayers.size == var_02 - 1) {
    param_01 scripts\mp\missions::func_D991("ch_clutch_revives");
  }

  self.playersrevived = param_01.rescuedplayers.size;
}

func_136F9() {
  self endon("started_spawnPlayer");
  for(;;) {
    wait(0.05);
    if(isDefined(self) && self.sessionstate == "spectator" || !scripts\mp\utility::isreallyalive(self)) {
      self.pers["lives"] = 1;
      scripts\mp\playerlogic::spawnclient();
      continue;
    }
  }
}

notifyplayers(param_00) {
  foreach(var_02 in level.players) {
    var_02 thread scripts\mp\hud_message::showsplash(param_00);
  }

  level notify("match_ending_soon", "time");
  level notify(param_00);
}

getteamflagcount(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.magicbullet.size; var_02++) {
    if(level.domflags[var_02] scripts\mp\gameobjects::getownerteam() == param_00) {
      var_01++;
    }
  }

  return var_01;
}

getflagteam() {
  return scripts\mp\gameobjects::getownerteam();
}

flagsetup() {
  foreach(var_01 in level.domflags) {
    switch (var_01.label) {
      case "_a":
        var_01.dompointnumber = 0;
        break;

      case "_b":
        var_01.dompointnumber = 1;
        break;

      case "_c":
        var_01.dompointnumber = 2;
        break;
    }
  }

  var_03 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  foreach(var_05 in var_03) {
    var_05.dompointa = 0;
    var_05.dompointb = 0;
    var_05.dompointc = 0;
    var_05.nearflagpoint = getnearestflagpoint(var_05);
    switch (var_05.nearflagpoint.useobj.dompointnumber) {
      case 0:
        var_05.dompointa = 1;
        break;

      case 1:
        var_05.dompointb = 1;
        break;

      case 2:
        var_05.dompointc = 1;
        break;
    }
  }
}

getnearestflagpoint(param_00) {
  var_01 = scripts\mp\spawnlogic::ispathdataavailable();
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in level.domflags) {
    var_06 = undefined;
    if(var_01) {
      var_06 = getpathdist(param_00.origin, var_05.levelflag.origin, 999999);
    }

    if(!isDefined(var_06) || var_06 == -1) {
      var_06 = distancesquared(var_05.levelflag.origin, param_00.origin);
    }

    if(!isDefined(var_02) || var_06 < var_03) {
      var_02 = var_05;
      var_03 = var_06;
    }
  }

  return var_02.levelflag;
}

giveflagcapturexp(param_00, param_01) {
  level endon("game_ended");
  var_02 = scripts\mp\gameobjects::getearliestclaimplayer();
  if(isDefined(var_02.triggerportableradarping)) {
    var_02 = var_02.triggerportableradarping;
  }

  level.lastcaptime = gettime();
  if(isplayer(var_02)) {
    level thread scripts\mp\utility::teamplayercardsplash("callout_securedposition" + self.label, var_02);
    var_02 thread scripts\mp\matchdata::loggameevent("capture", var_02.origin);
  }

  var_03 = getarraykeys(param_00);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_05 = param_00[var_03[var_04]].player;
    if(isDefined(var_05.triggerportableradarping)) {
      var_05 = var_05.triggerportableradarping;
    }

    if(!isplayer(var_05)) {
      continue;
    }

    var_05 thread updatecpm();
    if(var_05.cpm > 3) {
      var_06 = 0;
      var_07 = 0;
    } else if(var_05.numcaps > 5) {
      var_06 = 125;
      var_07 = 50;
    } else if(self.label == "_b" || param_01 != "neutral" || self.playersrevived > 0) {
      var_06 = undefined;
      var_07 = undefined;
    } else {
      var_06 = 125;
      var_07 = 50;
    }

    var_05 thread scripts\mp\awards::givemidmatchaward("mode_siege_secure", var_07, var_06);
    var_05 scripts\mp\utility::incperstat("captures", 1);
    var_05 scripts\mp\persistence::statsetchild("round", "captures", var_05.pers["captures"]);
    var_05 scripts\mp\missions::processchallenge("ch_domcap");
    var_05 scripts\mp\utility::setextrascore0(var_05.pers["captures"]);
    var_05 scripts\mp\utility::incperstat("rescues", self.playersrevived);
    var_05 scripts\mp\persistence::statsetchild("round", "rescues", var_05.pers["rescues"]);
    var_05 scripts\mp\utility::setextrascore1(var_05.pers["rescues"]);
    wait(0.05);
  }

  self.playersrevived = 0;
}

getcapxpscale() {
  if(self.cpm < 4) {
    return 1;
  }

  return 0.25;
}

updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;
  if(scripts\mp\utility::getminutespassed() < 1) {
    return;
  }

  self.cpm = self.numcaps / scripts\mp\utility::getminutespassed();
}

setflagcaptured(param_00, param_01, param_02, param_03) {
  scripts\mp\gameobjects::setownerteam(param_00);
  scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
  scripts\mp\gametypes\obj_dom::updateflagstate(param_00, 0);
  watchflagenduse(param_00);
  if(!isDefined(param_03)) {
    if(param_01 != "neutral") {
      var_04 = getteamflagcount(param_00);
      if(var_04 == 2) {
        scripts\mp\utility::statusdialog("friendly_captured_2", param_00);
        scripts\mp\utility::statusdialog("enemy_captured_2", param_01, 1);
      } else {
        scripts\mp\utility::statusdialog("secured" + self.label, param_00);
        scripts\mp\utility::statusdialog("lost" + self.label, param_01, 1);
      }

      scripts\mp\utility::playsoundonplayers("mp_dom_flag_lost", param_01);
      level.lastcaptime = gettime();
    }

    teamrespawn(param_00, param_02);
    self.firstcapture = 0;
  }
}

checkendgame() {
  var_00 = getflagcount("allies");
  var_01 = getflagcount("axis");
  if(var_00 == 3) {
    setwinner("allies", "score_limit_reached");
    return;
  }

  if(var_01 == 3) {
    setwinner("axis", "score_limit_reached");
  }
}

removedompoint() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devRemoveDomFlag", "") != "") {
      var_00 = getdvar("scr_devRemoveDomFlag", "");
      foreach(var_02 in level.domflags) {
        if(isDefined(var_02.label) && var_02.label == var_00) {
          var_02 scripts\mp\gameobjects::allowuse("none");
          var_02.trigger = undefined;
          var_02 notify("deleted");
          if(isDefined(var_02.var_BEEF)) {
            var_02.var_BEEF delete();
          }

          foreach(var_04 in level.players) {
            foreach(var_06 in var_04._domflageffect) {
              if(isDefined(var_06)) {
                var_06 delete();
              }
            }

            foreach(var_09 in var_04._domflagpulseeffect) {
              if(isDefined(var_09)) {
                var_09 delete();
              }
            }
          }

          var_02.visibleteam = "none";
          var_02 scripts\mp\gameobjects::set2dicon("friendly", undefined);
          var_02 scripts\mp\gameobjects::set3dicon("friendly", undefined);
          var_02 scripts\mp\gameobjects::set2dicon("enemy", undefined);
          var_02 scripts\mp\gameobjects::set3dicon("enemy", undefined);
          var_0C = [];
          for(var_0D = 0; var_0D < level.magicbullet.size; var_0D++) {
            if(level.magicbullet[var_0D].script_label != var_00) {
              var_0C[var_0C.size] = level.magicbullet[var_0D];
            }
          }

          level.magicbullet = var_0C;
          level.objectives = level.magicbullet;
          var_0C = [];
          for(var_0D = 0; var_0D < level.domflags.size; var_0D++) {
            if(level.domflags[var_0D].label != var_00) {
              var_0C[var_0C.size] = level.domflags[var_0D];
            }
          }

          level.domflags = var_0C;
          break;
        }
      }

      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait(1);
  }
}

placedompoint() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devPlaceDomFlag", "") != "") {
      var_00 = getdvar("scr_devPlaceDomFlag", "");
      var_01 = spawnStruct();
      var_01.origin = level.players[0].origin;
      var_01.angles = level.players[0].angles;
      var_02 = spawn("trigger_radius", var_01.origin, 0, 120, 128);
      var_01.trigger = var_02;
      var_01.trigger.script_label = var_00;
      var_01.ownerteam = "neutral";
      var_03 = var_01.origin + (0, 0, 32);
      var_04 = var_01.origin + (0, 0, -32);
      var_05 = bulletTrace(var_03, var_04, 0, undefined);
      var_01.origin = var_05["position"];
      var_01.upangles = vectortoangles(var_05["normal"]);
      var_01.missionfailed = anglesToForward(var_01.upangles);
      var_01.setdebugorigin = anglestoright(var_01.upangles);
      var_01.visuals[0] = spawn("script_model", var_01.origin);
      var_01.visuals[0].angles = var_01.angles;
      level.magicbullet[level.magicbullet.size] = var_01;
      level.objectives = level.magicbullet;
      var_06 = scripts\mp\gameobjects::createuseobject("neutral", var_01.trigger, var_01.visuals, (0, 0, 100));
      var_06 scripts\mp\gameobjects::allowuse("enemy");
      var_06 scripts\mp\gameobjects::setusetime(level.caprate);
      var_06 scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
      var_07 = var_00;
      var_06.label = var_07;
      var_06 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_defend" + var_07);
      var_06 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_defend" + var_07);
      var_06 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_captureneutral" + var_07);
      var_06 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_captureneutral" + var_07);
      var_06 scripts\mp\gameobjects::setvisibleteam("any");
      var_06 scripts\mp\gameobjects::cancontestclaim(1);
      var_06.onuse = ::onuse;
      var_06.onbeginuse = ::onbeginuse;
      var_06.onuseupdate = ::onuseupdate;
      var_06.onenduse = ::onenduse;
      var_06.oncontested = ::oncontested;
      var_06.onuncontested = ::onuncontested;
      var_06.nousebar = 1;
      var_06.id = "domFlag";
      var_06.firstcapture = 1;
      var_06.claimgracetime = 10000;
      var_06.decayrate = 50;
      var_03 = var_01.visuals[0].origin + (0, 0, 32);
      var_04 = var_01.visuals[0].origin + (0, 0, -32);
      var_08 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_09 = [];
      var_05 = scripts\common\trace::ray_trace(var_03, var_04, var_09, var_08);
      var_06.baseeffectpos = var_05["position"];
      var_0A = vectortoangles(var_05["normal"]);
      var_06.baseeffectforward = anglesToForward(var_0A);
      var_06 scripts\mp\gametypes\obj_dom::initializematchrecording();
      var_06 scripts\engine\utility::delaythread(1, ::setneutral);
      for(var_0B = 0; var_0B < level.magicbullet.size; var_0B++) {
        level.magicbullet[var_0B].useobj = var_06;
        var_06.levelflag = level.magicbullet[var_0B];
      }

      level.domflags[level.domflags.size] = var_06;
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait(1);
  }
}