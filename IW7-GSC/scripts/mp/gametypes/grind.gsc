/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grind.gsc
*********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 85);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
  }

  updategametypedvars();
  level.var_1C26 = [];
  level.var_26F2 = [];
  level.dogtagsplayer = [];
  scripts\mp\gametypes\obj_grindzone::init();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onspawnplayer = ::onspawnplayer;
  level.conf_fx["vanish"] = loadfx("vfx\core\impacts\small_snowhit");
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_grind_bankTime", getmatchrulesdata("grindData", "bankTime"));
  setdynamicdvar("scr_grind_bankRate", getmatchrulesdata("grindData", "bankRate"));
  setdynamicdvar("scr_grind_bankCaptureTime", getmatchrulesdata("grindData", "bankCaptureTime"));
  setdynamicdvar("scr_grind_megaBankLimit", getmatchrulesdata("grindData", "megaBankLimit"));
  setdynamicdvar("scr_grind_bankBonus", getmatchrulesdata("grindData", "megaBankBonus"));
  setdynamicdvar("scr_grind_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("grind", 0);
  setdynamicdvar("scr_grind_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_WAR");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_WAR");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_WAR_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_WAR_HINT");
  initspawns();
  createtags();
  level.dogtagallyonusecb = ::dogtagallyonusecb;
  var_0[0] = level.gametype;
  var_0[1] = "dom";
  scripts\mp\gameobjects::main(var_0);
  createzones();
  level thread onplayerconnect();
  level thread removetagsongameended();
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.banktime = scripts\mp\utility::dvarfloatvalue("bankTime", 2, 0, 10);
  level.bankrate = scripts\mp\utility::dvarintvalue("bankRate", 1, 1, 10);
  level.bankcapturetime = scripts\mp\utility::dvarintvalue("bankCaptureTime", 0, 0, 10);
  level.megabanklimit = scripts\mp\utility::dvarintvalue("megaBankLimit", 5, 5, 15);
  level.megabankbonus = scripts\mp\utility::dvarintvalue("megaBankBonus", 150, 0, 750);
}

onspawnplayer() {
  if(isDefined(self.tagscarried)) {
    self setclientomnvar("ui_grind_tags", self.tagscarried);
  }
}

createtags() {
  level.dogtags = [];
  for(var_0 = 0; var_0 < 30; var_0++) {
    var_1[0] = spawn("script_model", (0, 0, 0));
    var_1[0] setModel("dogtags_iw7_foe");
    var_1[1] = spawn("script_model", (0, 0, 0));
    var_1[1] setModel("dogtags_iw7_friend");
    var_1[0] scriptmodelplayanim("mp_dogtag_spin");
    var_1[1] scriptmodelplayanim("mp_dogtag_spin");
    var_1[0] hide();
    var_1[1] hide();
    var_1[0] setasgametypeobjective();
    var_1[1] setasgametypeobjective();
    var_2 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var_2.var_336 = "trigger_dogtag";
    var_2 hide();
    var_3 = spawnStruct();
    var_3.type = "useObject";
    var_3.curorigin = var_2.origin;
    var_3.entnum = var_2 getentitynumber();
    var_3.lastusedtime = 0;
    var_3.visuals = var_1;
    var_3.offset3d = (0, 0, 16);
    var_3.trigger = var_2;
    var_3.triggertype = "proximity";
    var_3 scripts\mp\gameobjects::allowuse("none");
    level.dogtags[level.dogtags.size] = var_3;
  }
}

gettag() {
  var_0 = level.dogtags[0];
  var_1 = gettime();
  foreach(var_3 in level.dogtags) {
    if(!isDefined(var_3.lastusedtime)) {
      continue;
    }

    if(var_3.interactteam == "none") {
      var_0 = var_3;
      break;
    }

    if(var_3.lastusedtime < var_1) {
      var_1 = var_3.lastusedtime;
      var_0 = var_3;
    }
  }

  var_0 notify("reset");
  var_0 scripts\mp\gameobjects::initializetagpathvariables();
  var_0.lastusedtime = gettime();
  return var_0;
}

spawntag(var_0, var_1) {
  var_2 = var_0 + (0, 0, 14);
  var_3 = (0, randomfloat(360), 0);
  var_4 = anglesToForward(var_3);
  var_5 = randomfloatrange(30, 150);
  var_6 = var_2 + var_5 * var_4;
  var_2 = playerphysicstrace(var_2, var_6);
  var_7 = gettag();
  var_7.curorigin = var_2;
  var_7.trigger.origin = var_2;
  var_7.visuals[0].origin = var_2;
  var_7.visuals[1].origin = var_2;
  var_7.trigger show();
  var_7 scripts\mp\gameobjects::allowuse("any");
  var_7.visuals[0] thread showtoteam(var_7, scripts\mp\utility::getotherteam(var_1));
  var_7.visuals[1] thread showtoteam(var_7, var_1);
  var_7.visuals[0] setasgametypeobjective();
  var_7.visuals[1] setasgametypeobjective();
  playsoundatpos(var_2, "mp_grind_token_drop");
  return var_7;
}

showtoteam(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");
  self hide();
  foreach(var_3 in level.players) {
    if(playercanusetags(var_3)) {
      if(var_3.team == var_1) {
        self showtoplayer(var_3);
      }

      if(var_3.team == "spectator" && var_1 == "allies") {
        self showtoplayer(var_3);
      }
    }
  }

  for(;;) {
    level scripts\engine\utility::waittill_any_3("joined_team", "update_phase_visibility");
    self hide();
    foreach(var_3 in level.players) {
      if(playercanusetags(var_3)) {
        if(var_3.team == var_1) {
          self showtoplayer(var_3);
        }
      }

      if(var_3.team == "spectator" && var_1 == "allies") {
        self showtoplayer(var_3);
      }

      if(var_0.victimteam == var_3.team && var_3 == var_0.var_4F) {
        scripts\mp\objidpoolmanager::minimap_objective_state(var_0.objid, "invisible");
      }
    }
  }
}

playercanusetags(var_0) {
  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_0)) {
    return 0;
  }

  return 1;
}

func_BA31(var_0) {
  level endon("game_ended");
  var_0 endon("deleted");
  var_0 endon("reset");
  for(;;) {
    var_0.trigger waittill("trigger", var_1);
    if(!scripts\mp\utility::isreallyalive(var_1)) {
      continue;
    }

    if(var_1 scripts\mp\utility::isusingremote() || isDefined(var_1.spawningafterremotedeath)) {
      continue;
    }

    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }

    if(isagent(var_1) && isDefined(var_1.triggerportableradarping)) {
      var_1 = var_1.triggerportableradarping;
    }

    if(!scripts\mp\equipment\phase_shift::areentitiesinphase(var_0, var_1)) {
      continue;
    }

    var_0.visuals[0] hide();
    var_0.visuals[1] hide();
    var_0.trigger hide();
    var_0.curorigin = (0, 0, 1000);
    var_0.trigger.origin = (0, 0, 1000);
    var_0.visuals[0].origin = (0, 0, 1000);
    var_0.visuals[1].origin = (0, 0, 1000);
    var_0 scripts\mp\gameobjects::allowuse("none");
    if(var_0.team != var_1.team) {
      var_1 playersettagcount(var_1.tagscarried + 1);
      var_1 thread scripts\mp\utility::giveunifiedpoints("tag_collected");
    }

    var_1 playSound("mp_killconfirm_tags_pickup");
    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var_1.cranked) && var_1.cranked) {
        var_1 scripts\mp\utility::setcrankedplayerbombtimer("kill");
      } else {
        var_1 scripts\mp\utility::oncranked(undefined, var_1);
      }
    }

    playsoundatpos(var_1.origin, "mp_grind_token_pickup");
    break;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.isscoring = 0;
    var_0 thread monitorjointeam();
  }
}

playersettagcount(var_0) {
  self.tagscarried = var_0;
  self.objective_additionalentity = var_0;
  if(var_0 > 999) {
    var_0 = 999;
  }

  self setclientomnvar("ui_grind_tags", var_0);
}

monitorjointeam() {
  self endon("disconnect");
  for(;;) {
    scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
    playersettagcount(0);
    if(self.team == "allies") {
      level.var_1C26 = scripts\engine\utility::array_add(level.var_1C26, self);
      continue;
    }

    if(self.team == "axis") {
      level.var_26F2 = scripts\engine\utility::array_add(level.var_26F2, self);
    }
  }
}

hidehudelementongameend(var_0) {
  level waittill("game_ended");
  if(isDefined(var_0)) {
    var_0.alpha = 0;
  }
}

createzones() {
  level.var_13FC1 = [];
  var_0 = getEntArray("grind_location", "targetname");
  foreach(var_2 in var_0) {
    level.var_13FC1[level.var_13FC1.size] = var_2;
  }

  level.objectives = level.var_13FC1;
  for(var_4 = 0; var_4 < level.var_13FC1.size; var_4++) {
    var_5 = scripts\mp\gametypes\obj_grindzone::setupobjective(var_4);
    var_5 thread runzonethink();
    level.var_13FC1[var_4].useobj = var_5;
    var_5.levelflag = level.var_13FC1[var_4];
  }
}

isinzone(var_0, var_1) {
  if(scripts\mp\utility::isreallyalive(var_0) && var_0 istouching(var_1.trigger) && var_1.ownerteam == var_0.team) {
    return 1;
  }

  return 0;
}

runzonethink() {
  level endon("game_ended");
  self endon("stop_trigger" + self.label);
  for(;;) {
    self.trigger waittill("trigger", var_0);
    if(self.stalemate) {
      continue;
    }

    if(isagent(var_0)) {
      continue;
    }

    if(!isplayer(var_0)) {
      continue;
    }

    if(var_0.isscoring) {
      continue;
    }

    var_0.isscoring = 1;
    level thread processscoring(var_0, self);
  }
}

removetagsongameended() {
  level waittill("game_ended");
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(!isDefined(var_1.tagscarried)) {
      continue;
    }

    var_1.tagscarried = 0;
  }
}

processscoring(var_0, var_1) {
  while(var_0.tagscarried && isinzone(var_0, var_1) && !var_1.stalemate) {
    var_0 playsoundtoplayer("mp_grind_token_banked", var_0);
    if(var_0.tagscarried >= level.megabanklimit) {
      scoreamount(var_0, level.megabanklimit);
      var_2 = scripts\mp\rank::getscoreinfovalue("tag_score");
      var_2 = var_2 * level.megabanklimit;
      var_0 thread scripts\mp\utility::giveunifiedpoints("mega_bank", var_0.var_394, var_2 + level.megabankbonus);
      var_0 scripts\mp\missions::func_D991("ch_mega_bank");
    } else {
      var_3 = level.bankrate;
      if(var_3 > var_0.tagscarried) {
        var_3 = var_0.tagscarried;
      }

      scoreamount(var_0, var_3);
      for(var_4 = 0; var_4 < var_3; var_4++) {
        var_0 thread scripts\mp\utility::giveunifiedpoints("tag_score");
      }
    }

    if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked) {
      var_0 scripts\mp\utility::setcrankedplayerbombtimer("kill");
    }

    var_0 scripts\mp\missions::processchallenge("ch_grinder");
    wait(level.banktime);
  }

  var_1 scripts\mp\gametypes\obj_grindzone::setneutralicons();
  var_0.isscoring = 0;
}

scoreamount(var_0, var_1) {
  var_0 playersettagcount(var_0.tagscarried - var_1);
  scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, var_1, 0);
  var_0 scripts\mp\utility::incperstat("confirmed", var_1);
  var_0 scripts\mp\persistence::statsetchild("round", "confirmed", var_0.pers["confirmed"]);
  var_0 scripts\mp\utility::setextrascore0(var_0.pers["confirmed"]);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = self.pers["team"];
  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility::getotherteam(var_0);
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(var_2);
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_2);
  }

  return var_2;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::onnormaldeath(var_0, var_1, var_2, var_3, var_4);
  level thread droptags(var_0, var_1);
}

droptags(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }

  if(var_0.tagscarried > 9) {
    var_2 = 10;
  } else if(var_1.tagscarried > 0) {
    var_2 = var_1.tagscarried;
  } else {
    var_2 = 0;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = spawntag(var_0.origin, var_0.team);
    var_4.team = var_0.team;
    var_4.victim = var_0;
    var_4.var_4F = var_1;
    level notify("new_tag_spawned", var_4);
    level thread func_BA31(var_4);
  }

  var_5 = var_0.tagscarried - var_2;
  var_5 = int(max(0, var_5));
  var_0 playersettagcount(var_5);
}

dogtagallyonusecb(var_0) {
  if(isplayer(var_0)) {
    var_0 scripts\mp\utility::setextrascore1(var_0.pers["denied"]);
  }
}

removepoint() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getdvar("scr_devRemoveDomFlag", "");
      foreach(var_2 in level.var_13FC1) {
        if(isDefined(var_2.useobj.label) && var_2.useobj.label == var_0) {
          var_2.useobj notify("stop_trigger" + var_2.useobj.label);
          var_2.useobj scripts\mp\gameobjects::allowuse("none");
          var_2.useobj.trigger = undefined;
          var_2.useobj notify("deleted");
          var_2.useobj.visibleteam = "none";
          var_2.useobj scripts\mp\gameobjects::set2dicon("friendly", undefined);
          var_2.useobj scripts\mp\gameobjects::set3dicon("friendly", undefined);
          var_2.useobj scripts\mp\gameobjects::set2dicon("enemy", undefined);
          var_2.useobj scripts\mp\gameobjects::set3dicon("enemy", undefined);
          var_3 = [];
          for(var_4 = 0; var_4 < level.objectives.size; var_4++) {
            if(level.objectives[var_4].script_label != var_0) {
              var_3[var_3.size] = level.objectives[var_4];
            }
          }

          level.objectives = var_3;
          var_3 = [];
          for(var_4 = 0; var_4 < level.var_13FC1.size; var_4++) {
            if(level.var_13FC1[var_4].useobj.label != var_0) {
              var_3[var_3.size] = level.var_13FC1[var_4];
            }
          }

          level.var_13FC1 = var_3;
          break;
        }
      }

      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait(1);
  }
}

placepoint() {
  self endon("game_ended");
  for(;;) {
    if(getdvar("scr_devPlaceDomFlag", "") != "") {
      var_0 = getdvar("scr_devPlaceDomFlag", "");
      var_1 = undefined;
      var_2 = getEntArray("grind_location", "targetname");
      foreach(var_4 in var_2) {
        if("_" + var_4.script_label == var_0) {
          var_1 = var_4;
        }
      }

      var_1.origin = level.players[0].origin;
      var_1.ownerteam = "neutral";
      var_6 = var_1.origin + (0, 0, 32);
      var_7 = var_1.origin + (0, 0, -32);
      var_8 = bulletTrace(var_6, var_7, 0, undefined);
      var_1.origin = var_8["position"];
      var_1.upangles = vectortoangles(var_8["normal"]);
      var_1.missionfailed = anglesToForward(var_1.upangles);
      var_1.setdebugorigin = anglestoright(var_1.upangles);
      var_9[0] = spawn("script_model", var_1.origin);
      var_9[0].angles = var_1.angles;
      level.objectives[level.objectives.size] = var_1;
      level.var_13FC1[level.var_13FC1.size] = var_1;
      var_0A = spawn("trigger_radius", var_1.origin, 0, 90, 128);
      var_0A.script_label = var_1.script_label;
      var_1 = var_0A;
      var_0B = scripts\mp\gameobjects::createuseobject("neutral", var_1, var_9, (0, 0, 100));
      var_0C = var_0;
      var_0B.label = var_0C;
      var_0B thread runzonethink();
      var_0B scripts\mp\gameobjects::allowuse("enemy");
      var_0B scripts\mp\gameobjects::setusetime(level.bankcapturetime);
      var_0B scripts\mp\gameobjects::setusetext(&"MP_SECURING_POSITION");
      var_0B scripts\mp\gameobjects::set2dicon("friendly", "waypoint_defend" + var_0C);
      var_0B scripts\mp\gameobjects::set3dicon("friendly", "waypoint_defend" + var_0C);
      var_0B scripts\mp\gameobjects::set2dicon("enemy", "waypoint_captureneutral" + var_0C);
      var_0B scripts\mp\gameobjects::set3dicon("enemy", "waypoint_captureneutral" + var_0C);
      var_0B scripts\mp\gameobjects::setvisibleteam("any");
      var_0B scripts\mp\gameobjects::cancontestclaim(1);
      var_0B.onuse = ::scripts\mp\gametypes\obj_grindzone::zone_onuse;
      var_0B.onbeginuse = ::scripts\mp\gametypes\obj_grindzone::zone_onusebegin;
      var_0B.onunoccupied = ::scripts\mp\gametypes\obj_grindzone::zone_onunoccupied;
      var_0B.oncontested = ::scripts\mp\gametypes\obj_grindzone::zone_oncontested;
      var_0B.onuncontested = ::scripts\mp\gametypes\obj_grindzone::zone_onuncontested;
      var_0B.claimgracetime = level.bankcapturetime * 1000;
      var_6 = var_0B.visuals[0].origin + (0, 0, 32);
      var_7 = var_0B.visuals[0].origin + (0, 0, -32);
      var_0D = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
      var_0E = [];
      var_8 = scripts\common\trace::ray_trace(var_6, var_7, var_0E, var_0D);
      var_0B.baseeffectpos = var_8["position"];
      var_0F = vectortoangles(var_8["normal"]);
      var_0F = -1 * var_0F;
      var_0B.baseeffectforward = anglesToForward(var_0F);
      var_0B scripts\mp\gametypes\obj_grindzone::setneutral();
      for(var_10 = 0; var_10 < level.objectives.size; var_10++) {
        level.objectives[var_10].useobj = var_0B;
        var_0B.levelflag = level.objectives[var_10];
      }

      level.var_13FC1[level.var_13FC1.size].useobj = var_0B;
      setdynamicdvar("scr_devPlaceDomFlag", "");
    }

    wait(1);
  }
}