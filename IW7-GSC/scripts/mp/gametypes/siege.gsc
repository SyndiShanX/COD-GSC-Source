/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\siege.gsc
*********************************************/

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
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
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
  var_2[0] = "dom";
  scripts\mp\gameobjects::main(var_2);
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
  var_0 = self.pers["team"];
  var_1 = scripts\mp\utility::getotherteam(var_0);
  if(level.usestartspawns) {
    if(game["switchedsides"]) {
      var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_1 + "_start");
      var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
    } else {
      var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_2 + "_start");
      var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_3);
    }
  } else {
    var_4 = getteamdompoints(var_2);
    var_5 = scripts\mp\utility::getotherteam(var_0);
    var_6 = getteamdompoints(var_5);
    var_7 = getpreferreddompoints(var_4, var_6);
    var_2 = scripts\mp\spawnlogic::getteamspawnpoints(var_0);
    var_8 = [];
    var_8["preferredDomPoints"] = var_7;
    var_3 = scripts\mp\spawnscoring::getspawnpoint(var_2, undefined, var_8);
  }

  return var_3;
}

getteamdompoints(var_0) {
  var_1 = [];
  foreach(var_3 in level.domflags) {
    if(var_3.ownerteam == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

getpreferreddompoints(var_0, var_1) {
  var_2 = [];
  var_2[0] = 0;
  var_2[1] = 0;
  var_2[2] = 0;
  var_3 = self.pers["team"];
  if(var_0.size == level.domflags.size) {
    var_4 = var_3;
    var_5 = level.bestspawnflag[var_3];
    var_2[var_5.useobj.dompointnumber] = 1;
    return var_2;
  }

  if(var_2.size > 0) {
    foreach(var_7 in var_2) {
      var_4[var_7.dompointnumber] = 1;
    }

    return var_4;
  }

  if(var_5.size == 0) {
    var_4 = var_8;
    var_5 = level.bestspawnflag[var_8];
    if(var_4.size > 0 && var_4.size < level.domflags.size) {
      var_8 = _meth_81EF(var_7, undefined);
      level.bestspawnflag[var_7] = var_8;
    }

    var_5[var_8.useobj.dompointnumber] = 1;
    return var_5;
  }

  return var_7;
}

gettimesincedompointcapture(var_0) {
  return gettime() - var_0.capturetime;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._domflageffect = [];
    var_0._domflagpulseeffect = [];
    var_0.ui_dom_securing = undefined;
    var_0.ui_dom_stalemate = undefined;
    var_0 thread onplayerspawned();
    var_0 thread scripts\mp\gametypes\obj_dom::ondisconnect();
    var_0.siegelatecomer = 1;
    var_0 thread onplayerdisconnected();
  }
}

onplayerdisconnected() {
  for(;;) {
    self waittill("disconnect");
    foreach(var_1 in self._domflageffect) {
      if(isDefined(var_1)) {
        var_1 delete();
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
    level waittill("joined_team", var_0);
    if(scripts\mp\utility::gamehasstarted()) {
      var_0.siegelatecomer = 1;
    }
  }
}

onspawnplayer() {
  func_12E58();
  level notify("spawned_player");
}

checkallowspectating() {
  wait(0.05);
  var_0 = 0;
  if(!level.alivecount[game["attackers"]]) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!level.alivecount[game["defenders"]]) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0) {
    scripts\mp\spectating::updatespectatesettings();
  }
}

domflags() {
  level endon("game_ended");
  level.var_AA1D["allies"] = 0;
  level.var_AA1D["axis"] = 0;
  var_0 = getEntArray("flag_primary", "targetname");
  var_1 = getEntArray("flag_secondary", "targetname");
  if(var_0.size + var_1.size < 2) {
    return;
  }

  level.magicbullet = [];
  var_2 = "mp\siegeFlagPos.csv";
  var_3 = scripts\mp\utility::getmapname();
  var_4 = 1;
  for(var_5 = 2; var_5 < 11; var_5++) {
    var_6 = tablelookup(var_2, var_4, var_3, var_5);
    if(var_6 != "") {
      setflagpositions(var_5, float(var_6));
    }
  }

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    level.magicbullet[level.magicbullet.size] = var_0[var_7];
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    level.magicbullet[level.magicbullet.size] = var_1[var_7];
  }

  level.domflags = [];
  for(var_7 = 0; var_7 < level.magicbullet.size; var_7++) {
    var_8 = level.magicbullet[var_7];
    var_8.origin = getflagpos(var_8.script_label, var_8.origin);
    if(isDefined(var_8.target)) {
      var_9[0] = getent(var_8.target, "targetname");
    } else {
      var_9[0] = spawn("script_model", var_8.origin);
      var_9[0].angles = var_8.angles;
    }

    var_0A = scripts\mp\gameobjects::createuseobject("neutral", var_8, var_9, (0, 0, 100));
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
    var_0C = var_9[0].origin + (0, 0, 32);
    var_0D = var_9[0].origin + (0, 0, -32);
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
    level.magicbullet[var_7].useobj = var_0A;
    var_0A.levelflag = level.magicbullet[var_7];
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

setflagpositions(var_0, var_1) {
  switch (var_0) {
    case 2:
      level.siege_a_xpos = var_1;
      break;

    case 3:
      level.siege_a_ypos = var_1;
      break;

    case 4:
      level.siege_a_zpos = var_1;
      break;

    case 5:
      level.siege_b_xpos = var_1;
      break;

    case 6:
      level.siege_b_ypos = var_1;
      break;

    case 7:
      level.siege_b_zpos = var_1;
      break;

    case 8:
      level.siege_c_xpos = var_1;
      break;

    case 9:
      level.siege_c_ypos = var_1;
      break;

    case 10:
      level.siege_c_zpos = var_1;
      break;
  }
}

getflagpos(var_0, var_1) {
  var_2 = var_1;
  if(var_0 == "_a") {
    if(isDefined(level.siege_a_xpos) && isDefined(level.siege_a_ypos) && isDefined(level.siege_a_zpos)) {
      var_2 = (level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos);
    }
  } else if(var_0 == "_b") {
    if(isDefined(level.siege_b_xpos) && isDefined(level.siege_b_ypos) && isDefined(level.siege_b_zpos)) {
      var_2 = (level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos);
    }
  } else if(isDefined(level.siege_c_xpos) && isDefined(level.siege_c_ypos) && isDefined(level.siege_c_zpos)) {
    var_2 = (level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos);
  }

  return var_2;
}

func_110AB() {
  var_0 = undefined;
  foreach(var_2 in level.magicbullet) {
    if(var_2.script_label == "_b") {
      level.var_3BB4 = var_2;
    }
  }
}

watchflagtimerpause() {
  level endon("game_ended");
  for(;;) {
    level waittill("flag_capturing", var_0);
    if(level.rushtimer) {
      var_1 = scripts\mp\utility::getotherteam(var_0.prevteam);
      if(var_0.prevteam != "neutral" && isDefined(level.siegetimerstate) && level.siegetimerstate != "pause" && !iswinningteam(var_1)) {
        level.gametimerbeeps = 0;
        level.siegetimerstate = "pause";
        pausecountdowntimer();
        if(!flagownersalive(var_0.prevteam)) {
          setwinner(var_1, var_0.prevteam + "_eliminated");
        }
      }
    }
  }
}

iswinningteam(var_0) {
  var_1 = 0;
  var_2 = getflagcount(var_0);
  if(var_2 == 2) {
    var_1 = 1;
  }

  return var_1;
}

flagownersalive(var_0) {
  var_1 = 0;
  foreach(var_3 in level.participants) {
    if(isDefined(var_3) && var_3.team == var_0 && scripts\mp\utility::isreallyalive(var_3) || var_3.pers["lives"] > 0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

pausecountdowntimer() {
  if(!level.timerstoppedforgamemode) {
    var_0 = level.rushtimeramount;
    if(isDefined(level.siegetimeleft)) {
      var_0 = level.siegetimeleft;
    }

    var_1 = int(gettime() + var_0 * 1000);
    scripts\mp\gamelogic::pausetimer(var_1);
  }

  level notify("siege_timer_paused");
}

resumecountdowntimer(var_0) {
  var_1 = level.rushtimeramount;
  if(level.timerstoppedforgamemode) {
    if(isDefined(level.siegetimeleft)) {
      var_1 = level.siegetimeleft;
    }

    var_2 = int(gettime() + var_1 * 1000);
    setgameendtime(var_2);
    scripts\mp\gamelogic::resumetimer(var_2);
    if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
      level.siegetimerstate = "start";
    }

    thread watchgametimer(var_1);
    if(scripts\mp\utility::istrue(var_0)) {
      if(level.siegeflagcapturing.size > 0) {
        level notify("flag_capturing", self);
        return;
      }
    }
  }
}

watchflagenduse(var_0) {
  level endon("game_ended");
  var_1 = 0;
  var_2 = 0;
  var_3 = level.rushtimerteam;
  var_1 = getflagcount("allies");
  var_2 = getflagcount("axis");
  if(level.rushtimerteam != "none") {
    if(level.sharedrushtimer || var_1 == 1 && var_2 == 1) {
      level.siegetimerstate = "start";
      notifyplayers("siege_timer_start");
      resumecountdowntimer(1);
      return;
    }
  }

  if(var_1 == 2 || var_2 == 2) {
    level.rushtimerteam = scripts\engine\utility::ter_op(var_1 > var_2, "allies", "axis");
    if(var_3 != level.rushtimerteam) {
      if(level.rushtimer) {
        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "reset") {
          level.gametimerbeeps = 0;
          level.siegetimeleft = undefined;
          level.siegetimerstate = "reset";
          notifyplayers("siege_timer_reset");
        }

        if(!isDefined(level.siegetimerstate) || level.siegetimerstate != "start") {
          var_4 = level.rushtimeramount;
          if(isDefined(level.siegetimeleft)) {
            var_4 = level.siegetimeleft;
          }

          var_5 = int(gettime() + var_4 * 1000);
          foreach(var_7 in level.players) {
            var_7 setclientomnvar("ui_bomb_timer", 0);
          }

          level.timelimitoverride = 1;
          scripts\mp\gamelogic::pausetimer(var_5);
          setgameendtime(var_5);
          scripts\mp\gamelogic::resumetimer(var_5);
          if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "pause") {
            level.siegetimerstate = "start";
            notifyplayers("siege_timer_start");
          }

          if(!level.gametimerbeeps) {
            thread watchgametimer(var_4);
          }
        }
      }
    } else if((var_3 == level.rushtimerteam && var_1 == 1) || var_3 == level.rushtimerteam && var_2 == 1) {
      resumecountdowntimer(1);
    } else {
      level.gametimerbeeps = 0;
      level.siegetimeleft = undefined;
      level.siegetimerstate = "reset";
      notifyplayers("siege_timer_reset");
      resumecountdowntimer(1);
    }
  } else if(var_1 == 3) {
    setwinner("allies", "score_limit_reached");
  } else if(var_2 == 3) {
    setwinner("axis", "score_limit_reached");
  }

  self.prevteam = self.ownerteam;
}

watchgameinactive() {
  level endon("game_ended");
  level endon("flag_capturing");
  var_0 = getdvarfloat("scr_siege_timelimit");
  if(var_0 > 0) {
    var_1 = var_0 * 60 - 1;
    while(var_1 > 0) {
      var_1 = var_1 - 1;
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

watchgametimer(var_0) {
  level endon("game_ended");
  level endon("siege_timer_paused");
  level endon("siege_timer_reset");
  var_1 = var_0;
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 hide();
  level.gametimerbeeps = 1;
  while(var_1 > 0) {
    var_1 = var_1 - 1;
    level.siegetimeleft = var_1;
    if(var_1 <= 30) {
      if(var_1 != 0) {
        var_2 playSound("ui_mp_timer_countdown");
      }
    }

    wait(1);
  }

  ontimelimit();
}

getflagcount(var_0) {
  var_1 = 0;
  foreach(var_3 in level.domflags) {
    if(var_3.ownerteam == var_0 && !isbeingcaptured(var_3)) {
      var_1 = var_1 + 1;
    }
  }

  return var_1;
}

isbeingcaptured(var_0) {
  var_1 = 0;
  if(isDefined(var_0)) {
    if(level.siegeflagcapturing.size > 0) {
      foreach(var_3 in level.siegeflagcapturing) {
        if(var_0.label == var_3) {
          var_1 = 1;
        }
      }
    }
  }

  return var_1;
}

setwinner(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isai(var_3)) {
      var_3 setclientomnvar("ui_objective_state", 0);
      var_3 setclientomnvar("ui_bomb_timer", 0);
    }
  }

  thread scripts\mp\gamelogic::endgame(var_0, game["end_reason"][var_1]);
}

onbeginuse(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  self.didstatusnotify = 0;
  scripts\mp\gameobjects::setusetime(level.caprate);
  level.siegeflagcapturing[level.siegeflagcapturing.size] = self.label;
  level notify("flag_capturing", self);
  thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
}

onuse(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  self.capturetime = gettime();
  setflagcaptured(var_1, var_2, var_0);
  level.usestartspawns = 0;
  if(var_2 == "neutral") {
    var_3 = scripts\mp\utility::getotherteam(var_1);
    thread scripts\mp\utility::printandsoundoneveryone(var_1, var_3, undefined, undefined, "mp_dom_flag_captured", undefined, var_0);
    var_4 = getteamflagcount(var_1);
    if(var_4 < level.magicbullet.size) {
      if(var_4 == 2) {
        scripts\mp\utility::statusdialog("friendly_captured_2", var_1);
        scripts\mp\utility::statusdialog("enemy_captured_2", var_3, 1);
      } else {
        scripts\mp\utility::statusdialog("secured" + self.label, var_1);
        scripts\mp\utility::statusdialog("enemy_has" + self.label, var_3, 1);
      }
    }
  }

  thread giveflagcapturexp(self.touchlist[var_1], var_2);
}

onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();
  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "neutral") {
      scripts\mp\utility::statusdialog("securing" + self.label, var_0);
      self.prevownerteam = scripts\mp\utility::getotherteam(var_0);
    } else {
      scripts\mp\utility::statusdialog("losing" + self.label, var_4, 1);
      scripts\mp\utility::statusdialog("securing" + self.label, var_0);
    }

    if(!isagent(var_3)) {
      scripts\mp\gametypes\obj_dom::updateflagcapturestate(var_0);
    }

    scripts\mp\gameobjects::setzonestatusicons(level.iconlosing + self.label, level.icontaking + self.label);
    self.didstatusnotify = 1;
  }
}

onenduse(var_0, var_1, var_2) {
  checkendgame();
  if(isplayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  if(var_2) {
    self.flagcapsuccess = 1;
  } else {
    self.flagcapsuccess = 0;
    resumecountdowntimer();
  }

  var_3 = scripts\mp\gameobjects::getownerteam();
  if(var_3 == "neutral") {
    scripts\mp\gameobjects::setzonestatusicons(level.iconneutral + self.label);
    scripts\mp\gametypes\obj_dom::updateflagstate("idle", 0);
  } else {
    scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
    scripts\mp\gametypes\obj_dom::updateflagstate(var_3, 0);
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

onuncontested(var_0) {
  checkendgame();
  var_1 = scripts\mp\gameobjects::getownerteam();
  if(var_0 == "none" || var_1 == "neutral") {
    scripts\mp\gameobjects::setzonestatusicons(level.iconneutral + self.label);
    self.didstatusnotify = 0;
  } else {
    scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  scripts\mp\gametypes\obj_dom::updateflagstate(var_2, 0);
}

_meth_81EF(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  foreach(var_6 in level.magicbullet) {
    if(var_6.useobj getflagteam() != "neutral") {
      continue;
    }

    var_7 = distancesquared(var_6.origin, level.areanynavvolumesloaded[var_0]);
    if(isDefined(var_1)) {
      if(!func_9DF8(var_6, var_1) && !isDefined(var_2) || var_7 < var_3) {
        var_3 = var_7;
        var_2 = var_6;
      }

      continue;
    }

    if(!isDefined(var_2) || var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_6;
    }
  }

  return var_2;
}

func_9DF8(var_0, var_1) {
  var_2 = 0;
  if(isarray(var_1)) {
    foreach(var_4 in var_1) {
      if(var_0 == var_4) {
        var_2 = 1;
        break;
      }
    }
  } else if(var_0 == var_1) {
    var_2 = 1;
  }

  return var_2;
}

ondeadevent(var_0) {
  if(scripts\mp\utility::gamehasstarted()) {
    if(var_0 == "all") {
      ontimelimit();
      return;
    }

    if(var_0 == game["attackers"]) {
      if(getflagcount(var_0) == 2) {
        return;
      }

      setwinner(game["defenders"], game["attackers"] + "_eliminated");
      return;
    }

    if(var_0 == game["defenders"]) {
      if(getflagcount(var_0) == 2) {
        return;
      }

      setwinner(game["attackers"], game["defenders"] + "_eliminated");
      return;
    }

    return;
  }
}

ononeleftevent(var_0) {
  var_1 = scripts\mp\utility::getlastlivingplayer(var_0);
  var_1 thread givelastonteamwarning();
}

func_12E58() {
  if(isDefined(level.alive_players["allies"])) {
    setomnvar("ui_allies_alive", level.alive_players["allies"].size);
  }

  if(isDefined(level.alive_players["axis"])) {
    setomnvar("ui_axis_alive", level.alive_players["axis"].size);
  }
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  func_12E58();
  if(!isplayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(!flagownersalive(self.team) && getteamflagcount(self.team) == 2) {
    scripts\mp\utility::statusdialog("objs_capture", var_1.team, 1);
  }

  var_0A = 0;
  var_0B = 0;
  var_0C = 0;
  var_0D = self;
  var_0E = var_0D.team;
  var_0F = var_0D.origin;
  var_10 = var_1.team;
  var_11 = var_1.origin;
  var_12 = 0;
  if(isDefined(var_0)) {
    var_11 = var_0.origin;
    var_12 = var_0 == var_1;
  }

  foreach(var_14 in var_1.touchtriggers) {
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
      var_18 = var_1 istouching(var_14);
      var_19 = var_0D istouching(var_14);
      if(var_18 || var_19) {
        if(var_14.useobj.claimteam == var_0E) {
          if(!var_0B) {
            if(var_0A) {
              var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
            }

            var_0B = 1;
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
            thread scripts\mp\matchdata::loginitialstats(var_9, "assaulting");
            continue;
          }
        } else if(var_14.useobj.claimteam == var_10) {
          if(!var_0C) {
            if(var_0A) {
              var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
            }

            var_0C = 1;
            var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
            var_1 scripts\mp\utility::incperstat("defends", 1);
            var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
            thread scripts\mp\matchdata::loginitialstats(var_9, "defending");
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
            var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
          }

          var_0B = 1;
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
          thread scripts\mp\matchdata::loginitialstats(var_9, "assaulting");
          continue;
        }
      }

      continue;
    }

    if(!var_0C) {
      var_1B = distsquaredcheck(var_14, var_11, var_0F);
      if(var_1B) {
        if(var_0A) {
          var_1 thread scripts\mp\utility::giveunifiedpoints("capture_kill");
        }

        var_0C = 1;
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var_1 scripts\mp\utility::incperstat("defends", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
        thread scripts\mp\matchdata::loginitialstats(var_9, "defending");
        continue;
      }
    }
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);
  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0.modifieddefendcheck)) {
      return 1;
    }

    if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100) {
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
  var_0 = scripts\mp\utility::getotherteam(self.pers["team"]);
  level thread scripts\mp\utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\utility::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  scripts\mp\music_and_dialog::func_C54B(self);
  scripts\mp\missions::lastmansd();
}

ontimelimit() {
  if(isDefined(level.siegegameinactive)) {
    level thread scripts\mp\gamelogic::forceend();
    return;
  }

  var_0 = getflagcount("allies");
  var_1 = getflagcount("axis");
  if(var_0 > var_1) {
    setwinner("allies", "time_limit_reached");
    return;
  }

  if(var_1 > var_0) {
    setwinner("axis", "time_limit_reached");
    return;
  }

  if(var_1 == var_0) {
    var_2 = scripts\mp\gamelogic::func_7E07();
    setwinner(var_2, "time_limit_reached");
    return;
  }

  setwinner("tie", "time_limit_reached");
}

teamrespawn(var_0, var_1) {
  var_2 = scripts\mp\utility::getteamarray(var_1.team).size;
  if(!isDefined(var_1.rescuedplayers)) {
    var_1.rescuedplayers = [];
  }

  foreach(var_4 in level.participants) {
    if(isDefined(var_4) && var_4.team == var_0 && !scripts\mp\utility::isreallyalive(var_4) && !scripts\engine\utility::array_contains(level.alive_players[var_4.team], var_4) && !isDefined(var_4.waitingtoselectclass) || !var_4.waitingtoselectclass) {
      if(isDefined(var_4.siegelatecomer) && var_4.siegelatecomer) {
        var_4.siegelatecomer = 0;
      }

      if(!scripts\mp\utility::istrue(var_4.pers["teamKillPunish"])) {
        var_4 scripts\mp\playerlogic::incrementalivecount(var_4.team);
        var_4.alreadyaddedtoalivecount = 1;
        var_4 thread func_136F9();
        var_4 func_12E58();
        var_4 thread scripts\mp\hud_message::showsplash("sr_respawned");
        level notify("sr_player_respawned", var_4);
        var_4 scripts\mp\utility::leaderdialogonplayer("revived");
      }

      var_1 scripts\mp\missions::processchallenge("ch_rescuer");
      var_1.rescuedplayers[var_4.guid] = 1;
      if(var_1.rescuedplayers.size == 4) {
        var_1 scripts\mp\missions::processchallenge("ch_helpme");
      }
    }
  }

  if(var_1.rescuedplayers.size == var_2 - 1) {
    var_1 scripts\mp\missions::func_D991("ch_clutch_revives");
  }

  self.playersrevived = var_1.rescuedplayers.size;
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

notifyplayers(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\hud_message::showsplash(var_0);
  }

  level notify("match_ending_soon", "time");
  level notify(var_0);
}

getteamflagcount(var_0) {
  var_1 = 0;
  for(var_2 = 0; var_2 < level.magicbullet.size; var_2++) {
    if(level.domflags[var_2] scripts\mp\gameobjects::getownerteam() == var_0) {
      var_1++;
    }
  }

  return var_1;
}

getflagteam() {
  return scripts\mp\gameobjects::getownerteam();
}

flagsetup() {
  foreach(var_1 in level.domflags) {
    switch (var_1.label) {
      case "_a":
        var_1.dompointnumber = 0;
        break;

      case "_b":
        var_1.dompointnumber = 1;
        break;

      case "_c":
        var_1.dompointnumber = 2;
        break;
    }
  }

  var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_dom_spawn");
  foreach(var_5 in var_3) {
    var_5.dompointa = 0;
    var_5.dompointb = 0;
    var_5.dompointc = 0;
    var_5.nearflagpoint = getnearestflagpoint(var_5);
    switch (var_5.nearflagpoint.useobj.dompointnumber) {
      case 0:
        var_5.dompointa = 1;
        break;

      case 1:
        var_5.dompointb = 1;
        break;

      case 2:
        var_5.dompointc = 1;
        break;
    }
  }
}

getnearestflagpoint(var_0) {
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;
  foreach(var_5 in level.domflags) {
    var_6 = undefined;
    if(var_1) {
      var_6 = getpathdist(var_0.origin, var_5.levelflag.origin, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distancesquared(var_5.levelflag.origin, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2.levelflag;
}

giveflagcapturexp(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\mp\gameobjects::getearliestclaimplayer();
  if(isDefined(var_2.triggerportableradarping)) {
    var_2 = var_2.triggerportableradarping;
  }

  level.lastcaptime = gettime();
  if(isplayer(var_2)) {
    level thread scripts\mp\utility::teamplayercardsplash("callout_securedposition" + self.label, var_2);
    var_2 thread scripts\mp\matchdata::loggameevent("capture", var_2.origin);
  }

  var_3 = getarraykeys(var_0);
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_0[var_3[var_4]].player;
    if(isDefined(var_5.triggerportableradarping)) {
      var_5 = var_5.triggerportableradarping;
    }

    if(!isplayer(var_5)) {
      continue;
    }

    var_5 thread updatecpm();
    if(var_5.cpm > 3) {
      var_6 = 0;
      var_7 = 0;
    } else if(var_5.numcaps > 5) {
      var_6 = 125;
      var_7 = 50;
    } else if(self.label == "_b" || var_1 != "neutral" || self.playersrevived > 0) {
      var_6 = undefined;
      var_7 = undefined;
    } else {
      var_6 = 125;
      var_7 = 50;
    }

    var_5 thread scripts\mp\awards::givemidmatchaward("mode_siege_secure", var_7, var_6);
    var_5 scripts\mp\utility::incperstat("captures", 1);
    var_5 scripts\mp\persistence::statsetchild("round", "captures", var_5.pers["captures"]);
    var_5 scripts\mp\missions::processchallenge("ch_domcap");
    var_5 scripts\mp\utility::setextrascore0(var_5.pers["captures"]);
    var_5 scripts\mp\utility::incperstat("rescues", self.playersrevived);
    var_5 scripts\mp\persistence::statsetchild("round", "rescues", var_5.pers["rescues"]);
    var_5 scripts\mp\utility::setextrascore1(var_5.pers["rescues"]);
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

setflagcaptured(var_0, var_1, var_2, var_3) {
  scripts\mp\gameobjects::setownerteam(var_0);
  scripts\mp\gameobjects::setzonestatusicons(level.icondefend + self.label, level.iconcapture + self.label);
  scripts\mp\gametypes\obj_dom::updateflagstate(var_0, 0);
  watchflagenduse(var_0);
  if(!isDefined(var_3)) {
    if(var_1 != "neutral") {
      var_4 = getteamflagcount(var_0);
      if(var_4 == 2) {
        scripts\mp\utility::statusdialog("friendly_captured_2", var_0);
        scripts\mp\utility::statusdialog("enemy_captured_2", var_1, 1);
      } else {
        scripts\mp\utility::statusdialog("secured" + self.label, var_0);
        scripts\mp\utility::statusdialog("lost" + self.label, var_1, 1);
      }

      scripts\mp\utility::playsoundonplayers("mp_dom_flag_lost", var_1);
      level.lastcaptime = gettime();
    }

    teamrespawn(var_0, var_2);
    self.firstcapture = 0;
  }
}

checkendgame() {
  var_0 = getflagcount("allies");
  var_1 = getflagcount("axis");
  if(var_0 == 3) {
    setwinner("allies", "score_limit_reached");
    return;
  }

  if(var_1 == 3) {
    setwinner("axis", "score_limit_reached");
  }
}

removedompoint() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getdvar("scr_devRemoveDomFlag", "");
      foreach(var_2 in level.domflags) {
        if(isDefined(var_2.label) && var_2.label == var_0) {
          var_2 scripts\mp\gameobjects::allowuse("none");
          var_2.trigger = undefined;
          var_2 notify("deleted");
          if(isDefined(var_2.var_BEEF)) {
            var_2.var_BEEF delete();
          }

          foreach(var_4 in level.players) {
            foreach(var_6 in var_4._domflageffect) {
              if(isDefined(var_6)) {
                var_6 delete();
              }
            }

            foreach(var_9 in var_4._domflagpulseeffect) {
              if(isDefined(var_9)) {
                var_9 delete();
              }
            }
          }

          var_2.visibleteam = "none";
          var_2 scripts\mp\gameobjects::set2dicon("friendly", undefined);
          var_2 scripts\mp\gameobjects::set3dicon("friendly", undefined);
          var_2 scripts\mp\gameobjects::set2dicon("enemy", undefined);
          var_2 scripts\mp\gameobjects::set3dicon("enemy", undefined);
          var_0C = [];
          for(var_0D = 0; var_0D < level.magicbullet.size; var_0D++) {
            if(level.magicbullet[var_0D].script_label != var_0) {
              var_0C[var_0C.size] = level.magicbullet[var_0D];
            }
          }

          level.magicbullet = var_0C;
          level.objectives = level.magicbullet;
          var_0C = [];
          for(var_0D = 0; var_0D < level.domflags.size; var_0D++) {
            if(level.domflags[var_0D].label != var_0) {
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
      var_0 = getdvar("scr_devPlaceDomFlag", "");
      var_1 = spawnStruct();
      var_1.origin = level.players[0].origin;
      var_1.angles = level.players[0].angles;
      var_2 = spawn("trigger_radius", var_1.origin, 0, 120, 128);
      var_1.trigger = var_2;
      var_1.trigger.script_label = var_0;
      var_1.ownerteam = "neutral";
      var_3 = var_1.origin + (0, 0, 32);
      var_4 = var_1.origin + (0, 0, -32);
      var_5 = bulletTrace(var_3, var_4, 0, undefined);
      var_1.origin = var_5["position"];
      var_1.upangles = vectortoangles(var_5["normal"]);
      var_1.missionfailed = anglesToForward(var_1.upangles);
      var_1.setdebugorigin = anglestoright(var_1.upangles);
      var_1.visuals[0] = spawn("script_model", var_1.origin);
      var_1.visuals[0].angles = var_1.angles;
      level.magicbullet[level.magicbullet.size] = var_1;
      level.objectives = level.magicbullet;
      var_6 = scripts\mp\gameobjects::createuseobject("neutral", var_1.trigger, var_1.visuals, (0, 0, 100));
      var_6 scripts\mp\gameobjects::allowuse("enemy");
      var_6 scripts\mp\gameobjects::setusetime(level.caprate);
      var_6 scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
      var_7 = var_0;
      var_6.label = var_7;
      var_6 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_defend" + var_7);
      var_6 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_defend" + var_7);
      var_6 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_captureneutral" + var_7);
      var_6 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_captureneutral" + var_7);
      var_6 scripts\mp\gameobjects::setvisibleteam("any");
      var_6 scripts\mp\gameobjects::cancontestclaim(1);
      var_6.onuse = ::onuse;
      var_6.onbeginuse = ::onbeginuse;
      var_6.onuseupdate = ::onuseupdate;
      var_6.onenduse = ::onenduse;
      var_6.oncontested = ::oncontested;
      var_6.onuncontested = ::onuncontested;
      var_6.nousebar = 1;
      var_6.id = "domFlag";
      var_6.firstcapture = 1;
      var_6.claimgracetime = 10000;
      var_6.decayrate = 50;
      var_3 = var_1.visuals[0].origin + (0, 0, 32);
      var_4 = var_1.visuals[0].origin + (0, 0, -32);
      var_8 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_9 = [];
      var_5 = scripts\common\trace::ray_trace(var_3, var_4, var_9, var_8);
      var_6.baseeffectpos = var_5["position"];
      var_0A = vectortoangles(var_5["normal"]);
      var_6.baseeffectforward = anglesToForward(var_0A);
      var_6 scripts\mp\gametypes\obj_dom::initializematchrecording();
      var_6 scripts\engine\utility::delaythread(1, ::setneutral);
      for(var_0B = 0; var_0B < level.magicbullet.size; var_0B++) {
        level.magicbullet[var_0B].useobj = var_6;
        var_6.levelflag = level.magicbullet[var_0B];
      }

      level.domflags[level.domflags.size] = var_6;
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait(1);
  }
}