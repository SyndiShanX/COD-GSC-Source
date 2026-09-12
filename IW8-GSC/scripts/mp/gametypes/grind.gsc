/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grind.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_grind_bankTime", getmatchrulesdata("grindData", "bankTime"));
  setdynamicdvar("scr_grind_bankRate", getmatchrulesdata("grindData", "bankRate"));
  setdynamicdvar("scr_grind_bankCaptureTime", getmatchrulesdata("grindData", "bankCaptureTime"));
  setdynamicdvar("scr_grind_bankDisable", getmatchrulesdata("grindData", "bankDisable"));
  setdynamicdvar("scr_grind_bankDisableTags", getmatchrulesdata("grindData", "bankDisableTags"));
  setdynamicdvar("scr_grind_bankDisableTime", getmatchrulesdata("grindData", "bankDisableTime"));
  setdynamicdvar("scr_grind_megaBankLimit", getmatchrulesdata("grindData", "megaBankLimit"));
  setdynamicdvar("scr_grind_megaBankBonusKS", getmatchrulesdata("grindData", "megaBankBonusKS"));
  setdynamicdvar("scr_grind_bankBonus", getmatchrulesdata("grindData", "megaBankBonus"));
  setdynamicdvar("scr_grind_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("grind", 0);
  setdynamicdvar("scr_grind_promode", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  scripts\mp\utility\game::setobjectivetext("allies", &"OBJECTIVES/WAR");
  scripts\mp\utility\game::setobjectivetext("axis", &"OBJECTIVES/WAR");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/WAR");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/WAR");
  } else {
    scripts\mp\utility\game::setobjectivescoretext("allies", &"OBJECTIVES/WAR_SCORE");
    scripts\mp\utility\game::setobjectivescoretext("axis", &"OBJECTIVES/WAR_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext("allies", &"OBJECTIVES/WAR_HINT");
  scripts\mp\utility\game::setobjectivehinttext("axis", &"OBJECTIVES/WAR_HINT");
  initspawns();
  createtags();
  level.dogtagallyonusecb = &dogtagallyonusecb;
  setupwaypointicons();
  thread createzones();
  thread removetagsongameended();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.banktime = scripts\mp\utility\dvars::dvarfloatvalue("bankTime", 2, 0, 10);
  level.bankrate = scripts\mp\utility\dvars::dvarintvalue("bankRate", 1, 1, 10);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("bankCaptureTime", 0, 0, 10);
  level.bankdisable = scripts\mp\utility\dvars::dvarintvalue("bankDisable", 1, 0, 1);
  level.bankdisabletags = scripts\mp\utility\dvars::dvarintvalue("bankDisableTags", 0, 0, 50);
  level.bankdisabletime = scripts\mp\utility\dvars::dvarintvalue("bankDisableTime", 0, 0, 120);
  level.megabanklimit = scripts\mp\utility\dvars::dvarintvalue("megaBankLimit", 5, 5, 15);
  level.megabankbonusks = scripts\mp\utility\dvars::dvarintvalue("megaBankBonusKS", 1, 0, 10);
  level.megabankbonus = scripts\mp\utility\dvars::dvarintvalue("megaBankBonus", 150, 0, 750);
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("scorelimit");

  if(var_0 == 0 && level.bankdisabletags == 0) {
    level.bankdisable = 0;
    return;
  }

  if(level.bankdisabletags == 0 && var_0 > 0) {
    level.bankdisabletags = int(var_0);
    return;
  }
}

function onspawnplayer() {
  self setclientomnvar("ui_match_status_hint_text", 34);

  if(isDefined(self.tagscarried)) {
    self setclientomnvar("ui_grind_tags", self.tagscarried);
    return;
  }
}

function onsuicidedeath(var_0) {
  self setclientomnvar("ui_grind_tags", 0);
  thread droptags(level);
}

function createtags() {
  level.dogtags = [];

  for(var_0 = 0; var_0 < 50; var_0++) {
    var_1 = spawn("script_model", (0, 0, 0));

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      var_1 setModel("military_dogtags_human_skull_02");
    } else {
      var_1 setModel("military_dogtags_iw8");
    }

    var_1 scriptmodelplayanim("mp_dogtag_spin");

    if(istrue(level.setplayerselfrevivingextrainfo)) {} else {
      var_1 setscriptablepartstate("visibility", "hide", 0);
    }

    var_1 setasgametypeobjective();
    var_2 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var_2.targetname = "trigger_dogtag";
    var_2 hide();
    var_3 = spawnStruct();
    var_3.type = "useObject";
    var_3.curorigin = var_2.origin;
    var_3.entnum = var_2 getentitynumber();
    var_3.lastusedtime = 0;
    var_3.visuals = var_1;
    var_3.offset3d = (0, 0, 16);
    var_3.trigger = var_2;
    var_3.trigger enablelinkTo();
    var_3.triggertype = "proximity";
    var_3 scripts\mp\gameobjects::allowuse("none");
    level.dogtags[level.dogtags.size] = var_3;
  }
}

function gettag() {
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

function spawntag(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.team;
  var_3 = var_1 + (0, 0, 14);
  var_4 = 35;
  var_5 = var_0 getstance();

  if(var_5 == "prone") {
    var_4 = 14;
  }

  if(var_5 == "crouch") {
    var_4 = 25;
  }

  var_6 = var_1 + (0, 0, var_4);
  var_7 = (0, randomfloat(360), 0);
  var_8 = anglesToForward(var_7);
  var_9 = randomfloatrange(30, 150);
  var_10 = 0.5;
  var_11 = var_3 + var_9 * var_8;
  var_12 = playerphysicstrace(var_3, var_11);
  var_13 = gettag();
  var_13.curorigin = var_6;
  var_13.trigger.origin = var_6;
  var_13.visuals.origin = var_6;
  var_13.team = var_0.team;
  var_13.visuals.team = var_13.team;
  var_13.interactteam = "any";
  var_13.trigger show();
  var_13.trigger linkTo(var_13.visuals, "tag_origin");

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    playsoundatpos(var_3, "mp_killconfirm_tags_drop_hw");
  } else {
    playsoundatpos(var_3, "mp_grind_token_drop");
  }

  thread tagmoveTo(var_13, var_2, var_6, var_12);
  return var_13;
}

function tagmoveTo(var_0, var_1, var_2, var_3) {
  scripts\mp\gameobjects::allowuse("any");
  thread showtoteam(self.visuals, self);
  self.visuals setasgametypeobjective();
  var_4 = getdvarint("bg_gravity");
  var_5 = distance(var_1, var_2);
  var_6 = var_2 - var_1;
  var_7 = 0.5 * var_4 * squared(var_3) * -1;
  var_8 = (var_6[0] / var_3, var_6[1] / var_3, (var_6[2] - var_7) / var_3);
  self.visuals movegravity(var_8, var_3);
  self.curorigin = var_2;
}

function showtoteam(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    return;
  }

  self setscriptablepartstate("visibility", "show", 0);
}

function monitortaguse(var_0) {
  level endon("game_ended");
  var_0 endon("deleted");
  var_0 endon("reset");

  for(;;) {
    var_0.trigger waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }

    if(var_1 scripts\mp\utility\player::isusingremote() || isDefined(var_1.spawningafterremotedeath)) {
      continue;
    }

    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }

    if(isagent(var_1) && isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      if(isDefined(var_1) && var_1.team == var_0.team) {
        playFX(level.conf_fx["vanish"], var_0.trigger.origin);
        playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], var_0.trigger.origin + (0, 0, 45));
      } else {
        playFX(level.conf_fx["vanish"], var_0.trigger.origin);
        playFX(level.spawnoffsettacinsertmax["vanish_hw_en"], var_0.trigger.origin + (0, 0, 45));
      }
    } else {
      var_0.visuals setscriptablepartstate("visibility", "hide", 0);
    }

    var_0.trigger hide();
    var_0.curorigin = (0, 0, 1000);
    var_0.trigger.origin = (0, 0, 1000);
    var_0.visuals.origin = (0, 0, 1000);
    var_0 scripts\mp\gameobjects::allowuse("none");
    playersettagcount(var_1, var_1.tagscarried + 1);
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("tag_collected");

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      var_1 playSound("mp_killconfirm_tags_pickup_hw");
    } else {
      var_1 playSound("mp_grind_token_pickup");
    }

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var_1.cranked) && var_1.cranked) {
        var_1 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      } else {
        var_1 scripts\mp\cranked::oncranked(undefined, var_1);
      }
    }

    break;
  }
}

function onplayerconnect(var_0) {
  var_0.isscoring = 0;
  thread monitorjointeam();
}

function playersettagcount(var_0) {
  self.tagscarried = var_0;
  self.game_extrainfo = var_0;

  if(var_0 > 999) {
    var_0 = 999;
  }

  self setclientomnvar("ui_grind_tags", var_0);
}

function monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
    playersettagcount(0);
  }
}

function hidehudelementongameend(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0.alpha = 0;
    return;
  }
}

function createzones() {
  var_0 = getEntArray("grind_location", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\gametypes\obj_grindzone::setupobjective(var_2, 1, 1);
    thread runzonethink();
    level.objectives[var_3.objectivekey] = var_3;
  }

  if(level.mapname == "mp_deadzone") {
    var_5 = spawnStruct();
    var_5.origin = (1416, 1368, 300);
    var_5.angles = (0, 0, 0);
    var_5.script_label = "b";
    var_3 = scripts\mp\gametypes\obj_grindzone::setupobjective(var_5, 1, 1);
    thread runzonethink();
    level.objectives[var_3.objectivekey] = var_3;
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  foreach(var_3 in level.objectives) {
    var_7 = scripts\mp\gametypes\obj_grindzone::getreservedobjid(var_3.objectivekey);
    var_3 scripts\mp\gameobjects::requestid(1, 1, var_7);
    var_3 scripts\mp\gameobjects::setvisibleteam("any");
    var_3 scripts\mp\gametypes\obj_grindzone::ref_1317d();
    var_3 scripts\mp\gametypes\obj_grindzone::setneutral();
  }
}

function isinzone(var_0, var_1) {
  if(scripts\mp\utility\player::isreallyalive(var_0) && var_0 istouching(var_1.trigger) && var_1.ownerteam == var_0.team) {
    return true;
  }

  return false;
}

function runzonethink() {
  level endon("game_ended");
  self endon("stop_trigger" + self.objectivekey);

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(self.disabled) {
      continue;
    }

    if(self.stalemate) {
      continue;
    }

    if(isagent(var_0)) {
      continue;
    }

    if(!isPlayer(var_0)) {
      continue;
    }

    if(var_0.isscoring) {
      continue;
    }

    var_0.isscoring = 1;
    thread processscoring(level, var_0);
  }
}

function removetagsongameended() {
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

function processscoring(var_0, var_1) {
  while(var_0.tagscarried && isinzone(var_0, var_1) && !var_1.stalemate && !var_1.disabled) {
    if(var_0.tagscarried >= level.megabanklimit) {
      var_0 playsoundtoplayer("mp_grind_token_banked_large", var_0);
      scoreamount(var_0, level.megabanklimit, var_1);
      var_2 = scripts\mp\rank::getscoreinfovalue("tag_score");
      var_2 *= level.megabanklimit;

      if(!var_0 scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
        var_0 scripts\mp\killstreaks\killstreaks::givestreakpoints("capture", level.megabankbonusks);
      }

      var_0 thread scripts\mp\utility\points::giveunifiedpoints("mega_bank", undefined, var_2 + level.megabankbonus);
      var_0 scripts\mp\utility\stats::incpersstat("tagsMegaBanked", 1);
    } else {
      var_0 playsoundtoplayer("mp_grind_token_banked", var_0);
      var_3 = level.bankrate;

      if(var_3 > var_0.tagscarried) {
        var_3 = var_0.tagscarried;
      }

      scoreamount(var_0, var_3, var_1);

      for(var_4 = 0; var_4 < var_3; var_4++) {
        var_0 thread scripts\mp\utility\points::giveunifiedpoints("tag_score");
      }
    }

    if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked) {
      var_0 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
    }

    wait level.banktime;
  }

  var_1 scripts\mp\gametypes\obj_grindzone::setneutralicons();
  var_0.isscoring = 0;
}

function scoreamount(var_0, var_1, var_2) {
  playersettagcount(var_0, var_0.tagscarried - var_1);
  scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, var_1, 0);
  var_0 scripts\mp\utility\stats::incpersstat("confirmed", var_1);
  var_0 scripts\mp\persistence::statsetchild("round", "confirmed", var_0.pers["confirmed"]);
  var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["confirmed"]);

  if(level.bankdisable) {
    var_2.tagsdeposited += var_1;

    if(var_2.tagsdeposited >= level.bankdisabletags) {
      var_2 scripts\mp\gameobjects::allowuse("none");
      thread ref_1439d();
      var_2.disabled = 1;
      var_2.scriptable setscriptablepartstate("flag", "off");
      var_2.scriptable setscriptablepartstate("pulse", "off");

      if(isDefined(var_2.objectivekey)) {
        foreach(var_4 in level.teamnamelist) {
          scripts\mp\utility\dialog::statusdialog("grind_disable_" + var_2.objectivekey, var_4);
        }
      }

      if(level.bankdisabletime == 0) {
        return;
      }

      thread waitthenenablezone();
      return;
    }

    return;
  }
}

function ref_1439d() {
  foreach(var_1 in level.players) {
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var_1);
  }

  waitframe();
  scripts\mp\gameobjects::setvisibleteam("none");
}

function waitthenenablezone() {
  level endon("game_ended");
  wait level.bankdisabletime;
  self.disabled = 0;
  self.scriptable setscriptablepartstate("flag", "idle");
  scripts\mp\gameobjects::allowuse("any");
  scripts\mp\gameobjects::setvisibleteam("any");

  if(isDefined(self.objectivekey)) {
    foreach(var_1 in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("grind_enable_" + self.objectivekey, var_1);
    }

    return;
  }
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var_2);
  scripts\mp\spawnlogic::registerspawnset("fallback", var_3);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  } else {
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, var_2, "normal", "fallback");
  }

  return var_2;
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  thread droptags(level, var_0);
}

function droptags(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }

  if(var_0.tagscarried > 49) {
    var_2 = 49;
  } else if(var_1.tagscarried > 0) {
    var_2 = var_1.tagscarried + 1;
  } else {
    var_2 = 1;
  }

  if(istrue(level.setplayerselfrevivingextrainfo) && !isDefined(level.player_current_primary_is_rpg)) {
    level.player_current_primary_is_rpg = 1;
    var_2 = 4;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = spawntag(var_2);
    var_4.team = var_2.team;
    var_4.victim = var_2;
    var_4.attacker = var_2;
    level notify("new_tag_spawned", var_4);
    thread monitortaguse(level);
  }

  var_5 = var_2.tagscarried - var_2;
  var_5 = int(max(0, var_5));
  playersettagcount(var_2, var_5);
}

function dogtagallyonusecb(var_0) {
  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["denied"]);
    return;
  }
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bank_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_BANK_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bank_b", 0, "neutral", "MP_INGAME_ONLY/OBJ_BANK_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_scoring_foe_a", 2, "enemy", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_scoring_foe_b", 2, "enemy", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_scoring_friend_a", 2, "friendly", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_scoring_friend_b", 2, "friendly", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_contested_b", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1);
}

function removepoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devRemoveDomFlag", "") != "") {
      var_0 = getDvar("scr_devRemoveDomFlag", "");

      foreach(var_2 in level.objectives) {
        if(isDefined(var_2.objectivekey) && var_2.objectivekey == var_0) {
          var_2 notify("stop_trigger" + var_2.objectivekey);
          var_2 scripts\mp\gameobjects::allowuse("none");
          var_2.trigger = undefined;
          var_2 notify("deleted");
          var_2.visibleteam = "none";
          var_2 scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
          var_3 = [];

          foreach(var_5 in level.objectives) {
            if(var_5.objectivekey != var_0) {
              var_3 = var_5;
            }
          }

          level.objectives = var_3;
          break;
        }
      }

      setdynamicdvar("scr_devRemoveDomFlag", "");
    }

    wait 1;
  }
}

function placepoint() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("scr_devPlaceDomFlag", "") != "") {
      var_0 = getDvar("scr_devPlaceDomFlag", "");
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
      var_8 = scripts\engine\trace::ray_trace(var_6, var_7, undefined, scripts\engine\trace::create_default_contents(1));
      var_1.origin = var_8["position"];
      var_1.upangles = vectortoangles(var_8["normal"]);
      var_1.forward = anglesToForward(var_1.upangles);
      var_1.right = anglestoright(var_1.upangles);
      GscBinSkip1(0x45, 0, spawn("script_model", var_1.origin));
    }

    wait 1;
  }
}