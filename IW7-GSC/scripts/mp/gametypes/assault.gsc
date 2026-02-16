/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault.gsc
*********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 1, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 3);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 1);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 0);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 3);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  var_0 = scripts\mp\utility::getwatcheddvar("timelimit");
  scripts\mp\utility::registerwatchdvarint("addObjectiveTime", var_0);
  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onnormaldeath = ::onnormaldeath;
  level.onobjectivecomplete = ::onobjectivecomplete;
  level.allowlatecomers = 0;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  var_0 = getmatchrulesdata("assaultData", "roundLength");
  setdynamicdvar("scr_assault_timelimit", var_0);
  scripts\mp\utility::registertimelimitdvar("assault", var_0);
  var_1 = getmatchrulesdata("assaultData", "roundSwitch");
  setdynamicdvar("scr_assault_roundswitch", var_1);
  scripts\mp\utility::registerroundswitchdvar("assault", var_1, 0, 9);
  var_2 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_assault_winlimit", var_2);
  scripts\mp\utility::registerwinlimitdvar("assault", var_2);
  setdynamicdvar("scr_assault_bombtimer", getmatchrulesdata("assaultData", "bombTimer"));
  setdynamicdvar("scr_assault_planttime", getmatchrulesdata("assaultData", "plantTime"));
  setdynamicdvar("scr_assault_defusetime", getmatchrulesdata("assaultData", "defuseTime"));
  setdynamicdvar("scr_assault_multibomb", getmatchrulesdata("assaultData", "multiBomb"));
  setdynamicdvar("scr_assault_bombResetTimer", getmatchrulesdata("assaultData", "bombResetTimer"));
  setdynamicdvar("scr_assault_roundlimit", 0);
  scripts\mp\utility::registerroundlimitdvar("assault", 0);
  setdynamicdvar("scr_assault_scorelimit", 1);
  scripts\mp\utility::registerscorelimitdvar("assault", 1);
  setdynamicdvar("scr_assault_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("assault", 0);
  setdynamicdvar("scr_assault_promode", 0);
}

onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
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

  setclientnamemode("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx\core\expl\small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  scripts\mp\utility::setobjectivetext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
  scripts\mp\utility::setobjectivetext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
    scripts\mp\utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  } else {
    scripts\mp\utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
    scripts\mp\utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
  scripts\mp\utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");
  initspawns();
  var_2[0] = "sd";
  var_2[1] = "bombzone";
  var_2[2] = "blocker";
  scripts\mp\gameobjects::main(var_2);
  setspecialloadout();
  thread initializeobjectives();
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_assault_spawn_attacker_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_assault_spawn_defender_start");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.assaultspawns = [];
  initbombsitespawns("attacker");
  initbombsitespawns("defender");
}

initbombsitespawns(var_0) {
  level.assaultspawns[var_0] = [];
  var_1 = "mp_assault_spawn_" + var_0;
  var_2 = scripts\mp\spawnlogic::getspawnpointarray(var_1);
  foreach(var_4 in var_2) {
    var_5 = var_4.script_noteworthy;
    if(!isDefined(level.assaultspawns[var_0][var_5])) {
      level.assaultspawns[var_0][var_5] = [];
    }

    level.assaultspawns[var_0][var_5][level.assaultspawns[var_0][var_5].size] = var_4;
  }
}

getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = "defender";
  if(var_0 == game["attackers"]) {
    var_1 = "attacker";
  }

  if(level.ingraceperiod) {
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_assault_spawn_" + var_1 + "_start");
    var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
  } else {
    var_4 = level.curobj.label;
    var_5 = level.assaultspawns[var_1][var_4];
    var_3 = scripts\mp\spawnlogic::getspawnpoint_random(var_5);
  }

  return var_3;
}

onspawnplayer() {
  if(scripts\mp\utility::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  if(level.multibomb && self.pers["team"] == game["attackers"]) {
    self setclientomnvar("ui_carrying_bomb", 1);
  } else {
    self setclientomnvar("ui_carrying_bomb", 0);
  }

  scripts\mp\utility::setextrascore0(0);
  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility::setextrascore0(self.pers["plants"]);
  }

  level notify("spawned_player");
  setuppingwatcher();
  var_0 = getdvarint("scr_allow_highjump");
  self allowhighjump(var_0);
  self allowhighjump(var_0);
  self allowboostjump(var_0);
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_carrying_bomb", 0);
  thread checkallowspectating();
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

sd_endgame(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isai(var_3)) {
      var_3 setclientomnvar("ui_objective_state", 0);
    }
  }

  level.finalkillcam_winner = var_0;
  if(var_1 == game["end_reason"]["target_destroyed"] || var_1 == game["end_reason"]["bomb_defused"]) {
    if(!isDefined(level.finalkillcam_killcamentityindex[var_0]) || level.finalkillcam_killcamentityindex[var_0] != level.curobj.killcamentnum) {
      scripts\mp\final_killcam::erasefinalkillcam();
    }
  }

  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\rank::getscoreinfovalue("kill");
  var_6 = var_0.team;
  if(var_0.isplanting) {
    thread scripts\mp\matchdata::loginitialstats(var_2, "planting");
    var_1 scripts\mp\utility::incperstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    return;
  }

  if(var_0.isbombcarrier) {
    thread scripts\mp\matchdata::loginitialstats(var_2, "carrying");
    return;
  }

  if(var_0.isdefusing) {
    thread scripts\mp\matchdata::loginitialstats(var_2, "defusing");
    var_1 scripts\mp\utility::incperstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    return;
  }
}

ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
  foreach(var_1 in level.players) {
    if(isDefined(var_1.bombplantweapon)) {
      var_1 scripts\mp\utility::_takeweapon(var_1.bombplantweapon);
      break;
    }
  }
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.planttime = scripts\mp\utility::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = scripts\mp\utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.multibomb = scripts\mp\utility::dvarintvalue("multibomb", 0, 0, 1);
  level.bombresettimer = scripts\mp\utility::dvarintvalue("bombResetTimer", 60, 0, 180);
}

setspecialloadout() {
  if(isusingmatchrulesdata() && scripts\mp\utility::getmatchrulesdatawithteamandindex("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level.sd_loadout[game["attackers"]] = ::scripts\mp\utility::getmatchrulesspecialclass(game["attackers"], 5);
  }
}

isplayeroutsideofcurbombsite(var_0) {
  if(isDefined(level.curbombzone)) {
    return self istouching(level.curbombzone.trigger);
  }

  return 0;
}

initializeobjectives() {
  level.firsttimebomb = 1;
  var_0 = getEntArray("bombzone", "targetname");
  level.objectives = var_0;
  level.curobjectiveindex = 0;
  level.curobj = setupnextobjective(level.curobjectiveindex);
}

setupnextobjective(var_0) {
  var_1 = level.objectives[var_0];
  var_2 = var_1.script_noteworthy;
  if(!isDefined(var_2)) {
    var_2 = "bombzone";
  }

  var_3 = undefined;
  switch (var_2) {
    case "bombzone":
      if(isDefined(level.firsttimebomb)) {
        scripts\mp\gametypes\obj_bombzone::bombzone_setupbombcase("sd_bomb");
        level.firsttimebomb = undefined;
      } else {
        scripts\mp\gametypes\obj_bombzone::advancebombcase();
      }

      var_3 = scripts\mp\gametypes\obj_bombzone::bombzone_setupobjective(var_0);
      scripts\mp\utility::leaderdialog("offense_obj", game["attackers"]);
      scripts\mp\utility::leaderdialog("defense_obj", game["defenders"]);
      break;

    case "dompoint":
      var_3 = scripts\mp\gametypes\obj_dom::func_591D(var_0);
      break;

    case "payload":
      break;

    case "ctf":
      break;
  }

  return var_3;
}

onobjectivecomplete(var_0, var_1, var_2, var_3, var_4) {
  switch (var_0) {
    case "dompoint":
      ondompointobjectivecomplete(var_1, var_2, var_3, var_4);
      break;

    case "bombzone":
      onbombzoneobjectivecomplete(var_1, var_2, var_3, var_4);
      break;
  }

  if(var_3 == game["attackers"]) {
    level.curobjectiveindex++;
    if(level.curobjectiveindex < level.objectives.size) {
      var_5 = scripts\mp\utility::getwatcheddvar("addObjectiveTime");
      scripts\mp\utility::setoverridewatchdvar("timelimit", scripts\mp\utility::gettimelimit() + var_5);
      restarttimer();
      level.curobj = setupnextobjective(level.curobjectiveindex);
      return;
    }

    setgameendtime(0);
    wait(3);
    sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
  }
}

ondompointobjectivecomplete(var_0, var_1, var_2, var_3) {
  var_4 = var_1.team;
  if(var_3 == "neutral") {
    var_5 = scripts\mp\utility::getotherteam(var_4);
    thread scripts\mp\utility::printandsoundoneveryone(var_4, var_5, undefined, undefined, "mp_dom_flag_captured", undefined, var_1);
    scripts\mp\utility::statusdialog("secured" + self.label, var_4, 1);
    scripts\mp\utility::statusdialog("enemy_has" + self.label, var_5, 1);
  }
}

onbombzoneobjectivecomplete(var_0, var_1, var_2, var_3) {
  if(var_2 == game["defenders"]) {
    restarttimer();
    thread scripts\mp\gametypes\obj_bombzone::respawnbombcase();
    level.curobj = scripts\mp\gametypes\obj_bombzone::bombzone_setupobjective(level.curobjectiveindex);
  }
}

restarttimer() {
  scripts\mp\gamelogic::resumetimer();
  level.timepaused = gettime() - level.timepausestart;
  level.timelimitoverride = 0;
}

setuppingwatcher() {
  if(isai(self)) {
    return;
  }

  self notifyonplayercommand("playerPing", "+breath_sprint");
  thread waitforplayerping();
}

waitforplayerping() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("playerPing");
    if(scripts\mp\utility::isreallyalive(self) && !scripts\mp\utility::isusingremote()) {
      if(self adsButtonPressed()) {
        doping();
        wait(0.5);
      }
    }

    wait(0.1);
  }
}

doping() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = self getEye();
  var_1 = var_0 + anglesToForward(self getplayerangles()) * 2000;
  var_2 = bulletTrace(var_0, var_1, 1, self);
  var_3 = var_2["entity"];
  var_4 = "WAYPOINT";
  var_5 = (1, 1, 1);
  if(isDefined(var_3)) {
    if(isDefined(var_3.team) && var_3.team != self.team) {
      var_5 = (1, 0, 0);
      if(isPlayer(var_3)) {
        var_4 = "KILL";
        self notify("enemy_sighted");
      } else {
        var_4 = "DESTROY";
      }
    } else if(isDefined(var_3.script_gameobjectname)) {
      if(var_3.script_gameobjectname == "bombzone") {
        if(self.team == game["attackers"]) {
          var_4 = "ATTACK";
          var_5 = (1, 1, 0);
        } else {
          var_4 = "DEFEND";
          var_5 = (0, 0, 1);
        }
      } else if(var_3.script_gameobjectname == "sd") {
        if(self.team == game["attackers"]) {
          var_4 = "OBJECTIVE";
          var_5 = (1, 1, 0);
        }
      }
    }
  }
}