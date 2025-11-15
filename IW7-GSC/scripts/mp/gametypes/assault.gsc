/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault.gsc
********************************************/

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

  var_00 = scripts\mp\utility::getwatcheddvar("timelimit");
  scripts\mp\utility::registerwatchdvarint("addObjectiveTime", var_00);
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
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  var_00 = getmatchrulesdata("assaultData", "roundLength");
  setdynamicdvar("scr_assault_timelimit", var_00);
  scripts\mp\utility::registertimelimitdvar("assault", var_00);
  var_01 = getmatchrulesdata("assaultData", "roundSwitch");
  setdynamicdvar("scr_assault_roundswitch", var_01);
  scripts\mp\utility::registerroundswitchdvar("assault", var_01, 0, 9);
  var_02 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_assault_winlimit", var_02);
  scripts\mp\utility::registerwinlimitdvar("assault", var_02);
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
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  setclientnamemode("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx\core\expl\small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  scripts\mp\utility::setobjectivetext(game["attackers"], & "OBJECTIVES_SD_ATTACKER");
  scripts\mp\utility::setobjectivetext(game["defenders"], & "OBJECTIVES_SD_DEFENDER");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext(game["attackers"], & "OBJECTIVES_SD_ATTACKER");
    scripts\mp\utility::setobjectivescoretext(game["defenders"], & "OBJECTIVES_SD_DEFENDER");
  } else {
    scripts\mp\utility::setobjectivescoretext(game["attackers"], & "OBJECTIVES_SD_ATTACKER_SCORE");
    scripts\mp\utility::setobjectivescoretext(game["defenders"], & "OBJECTIVES_SD_DEFENDER_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext(game["attackers"], & "OBJECTIVES_SD_ATTACKER_HINT");
  scripts\mp\utility::setobjectivehinttext(game["defenders"], & "OBJECTIVES_SD_DEFENDER_HINT");
  initspawns();
  var_02[0] = "sd";
  var_02[1] = "bombzone";
  var_02[2] = "blocker";
  scripts\mp\gameobjects::main(var_02);
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

initbombsitespawns(param_00) {
  level.assaultspawns[param_00] = [];
  var_01 = "mp_assault_spawn_" + param_00;
  var_02 = scripts\mp\spawnlogic::getspawnpointarray(var_01);
  foreach(var_04 in var_02) {
    var_05 = var_04.script_noteworthy;
    if(!isDefined(level.assaultspawns[param_00][var_05])) {
      level.assaultspawns[param_00][var_05] = [];
    }

    level.assaultspawns[param_00][var_05][level.assaultspawns[param_00][var_05].size] = var_04;
  }
}

getspawnpoint() {
  var_00 = self.pers["team"];
  var_01 = "defender";
  if(var_00 == game["attackers"]) {
    var_01 = "attacker";
  }

  if(level.ingraceperiod) {
    var_02 = scripts\mp\spawnlogic::getspawnpointarray("mp_assault_spawn_" + var_01 + "_start");
    var_03 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_02);
  } else {
    var_04 = level.curobj.label;
    var_05 = level.assaultspawns[var_01][var_04];
    var_03 = scripts\mp\spawnlogic::getspawnpoint_random(var_05);
  }

  return var_03;
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
  var_00 = getdvarint("scr_allow_highjump");
  self allowhighjump(var_00);
  self allowhighjump(var_00);
  self allowboostjump(var_00);
}

onplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  self setclientomnvar("ui_carrying_bomb", 0);
  thread checkallowspectating();
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

sd_endgame(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(!isai(var_03)) {
      var_03 setclientomnvar("ui_objective_state", 0);
    }
  }

  level.finalkillcam_winner = param_00;
  if(param_01 == game["end_reason"]["target_destroyed"] || param_01 == game["end_reason"]["bomb_defused"]) {
    if(!isDefined(level.finalkillcam_killcamentityindex[param_00]) || level.finalkillcam_killcamentityindex[param_00] != level.curobj.killcamentnum) {
      scripts\mp\final_killcam::erasefinalkillcam();
    }
  }

  thread scripts\mp\gamelogic::endgame(param_00, param_01);
}

onnormaldeath(param_00, param_01, param_02, param_03, param_04) {
  var_05 = scripts\mp\rank::getscoreinfovalue("kill");
  var_06 = param_00.team;
  if(param_00.isplanting) {
    thread scripts\mp\matchdata::loginitialstats(param_02, "planting");
    param_01 scripts\mp\utility::incperstat("defends", 1);
    param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
    return;
  }

  if(param_00.isbombcarrier) {
    thread scripts\mp\matchdata::loginitialstats(param_02, "carrying");
    return;
  }

  if(param_00.isdefusing) {
    thread scripts\mp\matchdata::loginitialstats(param_02, "defusing");
    param_01 scripts\mp\utility::incperstat("defends", 1);
    param_01 scripts\mp\persistence::statsetchild("round", "defends", param_01.pers["defends"]);
    return;
  }
}

ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
  foreach(var_01 in level.players) {
    if(isDefined(var_01.bombplantweapon)) {
      var_01 scripts\mp\utility::_takeweapon(var_01.bombplantweapon);
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
    level.sd_loadout[game["attackers"]] = scripts\mp\utility::getmatchrulesspecialclass(game["attackers"], 5);
  }
}

isplayeroutsideofcurbombsite(param_00) {
  if(isDefined(level.curbombzone)) {
    return self istouching(level.curbombzone.trigger);
  }

  return 0;
}

initializeobjectives() {
  level.firsttimebomb = 1;
  var_00 = getEntArray("bombzone", "targetname");
  level.objectives = var_00;
  level.curobjectiveindex = 0;
  level.curobj = setupnextobjective(level.curobjectiveindex);
}

setupnextobjective(param_00) {
  var_01 = level.objectives[param_00];
  var_02 = var_01.script_noteworthy;
  if(!isDefined(var_02)) {
    var_02 = "bombzone";
  }

  var_03 = undefined;
  switch (var_02) {
    case "bombzone":
      if(isDefined(level.firsttimebomb)) {
        scripts\mp\gametypes\obj_bombzone::bombzone_setupbombcase("sd_bomb");
        level.firsttimebomb = undefined;
      } else {
        scripts\mp\gametypes\obj_bombzone::advancebombcase();
      }

      var_03 = scripts\mp\gametypes\obj_bombzone::bombzone_setupobjective(param_00);
      scripts\mp\utility::leaderdialog("offense_obj", game["attackers"]);
      scripts\mp\utility::leaderdialog("defense_obj", game["defenders"]);
      break;

    case "dompoint":
      var_03 = scripts\mp\gametypes\obj_dom::func_591D(param_00);
      break;

    case "payload":
      break;

    case "ctf":
      break;
  }

  return var_03;
}

onobjectivecomplete(param_00, param_01, param_02, param_03, param_04) {
  switch (param_00) {
    case "dompoint":
      ondompointobjectivecomplete(param_01, param_02, param_03, param_04);
      break;

    case "bombzone":
      onbombzoneobjectivecomplete(param_01, param_02, param_03, param_04);
      break;
  }

  if(param_03 == game["attackers"]) {
    level.curobjectiveindex++;
    if(level.curobjectiveindex < level.objectives.size) {
      var_05 = scripts\mp\utility::getwatcheddvar("addObjectiveTime");
      scripts\mp\utility::setoverridewatchdvar("timelimit", scripts\mp\utility::gettimelimit() + var_05);
      restarttimer();
      level.curobj = setupnextobjective(level.curobjectiveindex);
      return;
    }

    setgameendtime(0);
    wait(3);
    sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
  }
}

ondompointobjectivecomplete(param_00, param_01, param_02, param_03) {
  var_04 = param_01.team;
  if(param_03 == "neutral") {
    var_05 = scripts\mp\utility::getotherteam(var_04);
    thread scripts\mp\utility::printandsoundoneveryone(var_04, var_05, undefined, undefined, "mp_dom_flag_captured", undefined, param_01);
    scripts\mp\utility::statusdialog("secured" + self.label, var_04, 1);
    scripts\mp\utility::statusdialog("enemy_has" + self.label, var_05, 1);
  }
}

onbombzoneobjectivecomplete(param_00, param_01, param_02, param_03) {
  if(param_02 == game["defenders"]) {
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
      if(self adsbuttonpressed()) {
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
  var_00 = self getEye();
  var_01 = var_00 + anglesToForward(self getplayerangles()) * 2000;
  var_02 = bulletTrace(var_00, var_01, 1, self);
  var_03 = var_02["entity"];
  var_04 = "WAYPOINT";
  var_05 = (1, 1, 1);
  if(isDefined(var_03)) {
    if(isDefined(var_03.team) && var_03.team != self.team) {
      var_05 = (1, 0, 0);
      if(isplayer(var_03)) {
        var_04 = "KILL";
        self notify("enemy_sighted");
      } else {
        var_04 = "DESTROY";
      }
    } else if(isDefined(var_03.script_gameobjectname)) {
      if(var_03.script_gameobjectname == "bombzone") {
        if(self.team == game["attackers"]) {
          var_04 = "ATTACK";
          var_05 = (1, 1, 0);
        } else {
          var_04 = "DEFEND";
          var_05 = (0, 0, 1);
        }
      } else if(var_03.script_gameobjectname == "sd") {
        if(self.team == game["attackers"]) {
          var_04 = "OBJECTIVE";
          var_05 = (1, 1, 0);
        }
      }
    }
  }
}