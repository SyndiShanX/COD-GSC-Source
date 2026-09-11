/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  var_0 = getmatchrulesdata("assaultData", "roundLength");
  setdynamicdvar("scr_assault_timelimit", var_0);
  scripts\mp\utility\game::registertimelimitdvar("assault", var_0);
  var_1 = getmatchrulesdata("assaultData", "roundSwitch");
  setdynamicdvar("scr_assault_roundswitch", var_1);
  scripts\mp\utility\game::registerroundswitchdvar("assault", var_1, 0, 9);
  var_2 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_assault_winlimit", var_2);
  scripts\mp\utility\game::registerwinlimitdvar("assault", var_2);
  setdynamicdvar("scr_assault_bombtimer", getmatchrulesdata("assaultData", "bombTimer"));
  setdynamicdvar("scr_assault_planttime", getmatchrulesdata("assaultData", "plantTime"));
  setdynamicdvar("scr_assault_defusetime", getmatchrulesdata("assaultData", "defuseTime"));
  setdynamicdvar("scr_assault_multibomb", getmatchrulesdata("assaultData", "multiBomb"));
  setdynamicdvar("scr_assault_bombResetTimer", getmatchrulesdata("assaultData", "bombResetTimer"));
  setdynamicdvar("scr_assault_roundlimit", 0);
  scripts\mp\utility\game::registerroundlimitdvar("assault", 0);
  setdynamicdvar("scr_assault_scorelimit", 1);
  scripts\mp\utility\game::registerscorelimitdvar("assault", 1);
  setdynamicdvar("scr_assault_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("assault", 0);
}

function onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

function onstartgametype() {
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
  level._effect["bomb_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT");
  initspawns();
  setspecialloadout();
  thread initializeobjectives();
}

function initspawns() {
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

function initbombsitespawns(var_0) {
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

function getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = "defender";

  if(var_0 == game["attackers"]) {
    var_1 = "attacker";
  }

  jumpiffalse(level.ingraceperiod) LOC_00000054;
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_assault_spawn_" + var_1 + "_start");
  var_3 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_2);
  goto LOC_00000078;
}

function onspawnplayer() {
  if(scripts\mp\utility\entity::isgameparticipant(self)) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  if(level.multibomb && self.pers["team"] == game["attackers"]) {
    self setclientomnvar("ui_carrying_bomb", 1);
  } else {
    self setclientomnvar("ui_carrying_bomb", 0);
  }

  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::setextrascore0(self.pers["plants"]);
  }

  level notify("spawned_player");
  setuppingwatcher();
  var_0 = getdvarint("scr_allow_highjump");
  self allowhighjump(var_0);
  self allowhighjump(var_0);
  self allowboostjump(var_0);
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_carrying_bomb", 0);
  thread checkallowspectating();
}

function checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0) {
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function sd_endgame(var_0, var_1) {
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

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\rank::getscoreinfovalue("kill");
  var_7 = var_0.team;

  if(var_0.isplanting) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_2, "planting");
    var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    return;
  }

  if(var_0.isbombcarrier) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_2, "carrying");
    return;
  }

  if(var_0.isdefusing) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_2, "defusing");
    var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    return;
  }
}

function ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);

  foreach(var_1 in level.players) {
    if(isDefined(var_1.bombplantweapon)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.bombplantweapon);
      break;
    }
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.multibomb = scripts\mp\utility\dvars::dvarintvalue("multibomb", 0, 0, 1);
  level.bombresettimer = scripts\mp\utility\dvars::dvarintvalue("bombResetTimer", 60, 0, 180);
}

function setspecialloadout() {
  if(isusingmatchrulesdata() && scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level.sd_loadout[game["attackers"]] = scripts\mp\utility\game::getmatchrulesspecialclass(game["attackers"], 5);
    return;
  }
}

function isplayeroutsideofcurbombsite(var_0) {
  if(isDefined(level.curbombzone)) {
    return self istouching(level.curbombzone.trigger);
  }

  return 0;
}

function initializeobjectives() {
  level.firsttimebomb = 1;
  var_0 = getEntArray("bombzone", "targetname");
  level.objectives = var_0;
  level.curobjectiveindex = 0;
  level.curobj = setupnextobjective(level.curobjectiveindex);
}

function setupnextobjective(var_0) {
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

      var_3 = scripts\mp\gametypes\obj_bombzone::setupobjective(var_0);
      scripts\mp\utility\dialog::leaderdialog("offense_obj", game["attackers"]);
      scripts\mp\utility\dialog::leaderdialog("defense_obj", game["defenders"]);
      break;
    case "dompoint":
      var_3 = scripts\mp\gametypes\obj_dom::setupobjective(level.objectives[var_0]);
      break;
    case "payload":
      break;
    case "ctf":
      break;
  }

  return var_3;
}

function onobjectivecomplete(var_0, var_1, var_2, var_3, var_4) {
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
      var_5 = scripts\mp\utility\dvars::getwatcheddvar("addObjectiveTime");
      scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", scripts\mp\utility\game::gettimelimit() + var_5);
      restarttimer();
      level.curobj = setupnextobjective(level.curobjectiveindex);
      return;
    }

    setgameendtime(0);
    wait 3;
    sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
    return;
  }
}

function ondompointobjectivecomplete(var_0, var_1, var_2, var_3) {
  var_4 = var_1.team;

  if(var_3 == "neutral") {
    var_5 = scripts\mp\utility\game::getotherteam(var_4)[0];
    thread scripts\mp\utility\print::printandsoundoneveryone(var_4, var_5, undefined, undefined, "mp_dom_flag_captured", undefined, var_1);
    scripts\mp\utility\dialog::statusdialog("secured" + self.label, var_4, 1);
    scripts\mp\utility\dialog::statusdialog("lost_" + self.label, var_5, 1);
    return;
  }
}

function onbombzoneobjectivecomplete(var_0, var_1, var_2, var_3) {
  if(var_2 == game["defenders"]) {
    restarttimer();
    thread scripts\mp\gametypes\obj_bombzone::respawnbombcase();
    level.curobj = scripts\mp\gametypes\obj_bombzone::setupobjective(level.curobjectiveindex);
    return;
  }
}

function restarttimer() {
  scripts\mp\gamelogic::resumetimer();
  level.timepaused = gettime() - level.timepausestart;
  level.timelimitoverride = 0;
}

function setuppingwatcher() {
  if(isai(self)) {
    return;
  }

  self notifyonplayercommand("playerPing", "+breath_sprint");
  thread waitforplayerping();
}

function waitforplayerping() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("playerPing");

    if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::isusingremote()) {
      if(self adsButtonPressed()) {
        doping();
        wait 0.5;
      }
    }

    wait 0.1;
  }
}

function doping() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = self getEye();
  var_1 = var_0 + anglesToForward(self getplayerangles()) * 2000;
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1, self);
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

      return;
    }

    if(isDefined(var_3.script_gameobjectname)) {
      if(var_3.script_gameobjectname == "bombzone") {
        if(self.team == game["attackers"]) {
          var_4 = "ATTACK";
          var_5 = (1, 1, 0);
        } else {
          var_4 = "DEFEND";
          var_5 = (0, 0, 1);
        }

        return;
      }

      if(var_3.script_gameobjectname == "sd") {
        if(self.team == game["attackers"]) {
          var_4 = "OBJECTIVE";
          var_5 = (1, 1, 0);
        }
      }
    }
  }
}