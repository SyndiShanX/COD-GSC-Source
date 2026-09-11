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
  var0 = scripts\mp\utility\dvars::getwatcheddvar("scorelimit");

  if(var0 == 0 && level.bankdisabletags == 0) {
    level.bankdisable = 0;
    return;
  }

  if(level.bankdisabletags == 0 && var0 > 0) {
    level.bankdisabletags = int(var0);
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

function onsuicidedeath(var0) {
  self setclientomnvar("ui_grind_tags", 0);
  thread droptags(level);
}

function createtags() {
  level.dogtags = [];

  for(var0 = 0; var0 < 50; var0++) {
    var1 = spawn("script_model", (0, 0, 0));

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      var1 setModel("military_dogtags_human_skull_02");
    } else {
      var1 setModel("military_dogtags_iw8");
    }

    var1 scriptmodelplayanim("mp_dogtag_spin");

    if(istrue(level.setplayerselfrevivingextrainfo)) {} else {
      var1 setscriptablepartstate("visibility", "hide", 0);
    }

    var1 setasgametypeobjective();
    var2 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var2.targetname = "trigger_dogtag";
    var2 hide();
    var3 = spawnStruct();
    var3.type = "useObject";
    var3.curorigin = var2.origin;
    var3.entnum = var2 getentitynumber();
    var3.lastusedtime = 0;
    var3.visuals = var1;
    var3.offset3d = (0, 0, 16);
    var3.trigger = var2;
    var3.trigger enablelinkTo();
    var3.triggertype = "proximity";
    var3 scripts\mp\gameobjects::allowuse("none");
    level.dogtags[level.dogtags.size] = var3;
  }
}

function gettag() {
  var0 = level.dogtags[0];
  var1 = gettime();

  foreach(var3 in level.dogtags) {
    if(!isDefined(var3.lastusedtime)) {
      continue;
    }

    if(var3.interactteam == "none") {
      var0 = var3;
      break;
    }

    if(var3.lastusedtime < var1) {
      var1 = var3.lastusedtime;
      var0 = var3;
    }
  }

  var0 notify("reset");
  var0 scripts\mp\gameobjects::initializetagpathvariables();
  var0.lastusedtime = gettime();
  return var0;
}

function spawntag(var0) {
  var1 = var0.origin;
  var2 = var0.team;
  var3 = var1 + (0, 0, 14);
  var4 = 35;
  var5 = var0 getstance();

  if(var5 == "prone") {
    var4 = 14;
  }

  if(var5 == "crouch") {
    var4 = 25;
  }

  var6 = var1 + (0, 0, var4);
  var7 = (0, randomfloat(360), 0);
  var8 = anglesToForward(var7);
  var9 = randomfloatrange(30, 150);
  var10 = 0.5;
  var11 = var3 + var9 * var8;
  var12 = playerphysicstrace(var3, var11);
  var13 = gettag();
  var13.curorigin = var6;
  var13.trigger.origin = var6;
  var13.visuals.origin = var6;
  var13.team = var0.team;
  var13.visuals.team = var13.team;
  var13.interactteam = "any";
  var13.trigger show();
  var13.trigger linkTo(var13.visuals, "tag_origin");

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    playsoundatpos(var3, "mp_killconfirm_tags_drop_hw");
  } else {
    playsoundatpos(var3, "mp_grind_token_drop");
  }

  thread tagmoveTo(var13, var2, var6, var12);
  return var13;
}

function tagmoveTo(var0, var1, var2, var3) {
  scripts\mp\gameobjects::allowuse("any");
  thread showtoteam(self.visuals, self);
  self.visuals setasgametypeobjective();
  var4 = getdvarint("NPOQPMP");
  var5 = distance(var1, var2);
  var6 = var2 - var1;
  var7 = 0.5 * var4 * squared(var3) * -1;
  var8 = (var6[0] / var3, var6[1] / var3, (var6[2] - var7) / var3);
  self.visuals movegravity(var8, var3);
  self.curorigin = var2;
}

function showtoteam(var0, var1) {
  var0 endon("death");
  var0 endon("reset");

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    return;
  }

  self setscriptablepartstate("visibility", "show", 0);
}

function monitortaguse(var0) {
  level endon("game_ended");
  var0 endon("deleted");
  var0 endon("reset");

  for(;;) {
    var0.trigger waittill("trigger", var1);

    if(!scripts\mp\utility\player::isreallyalive(var1)) {
      continue;
    }

    if(var1 scripts\mp\utility\player::isusingremote() || isDefined(var1.spawningafterremotedeath)) {
      continue;
    }

    if(isDefined(var1.classname) && var1.classname == "script_vehicle") {
      continue;
    }

    if(isagent(var1) && isDefined(var1.owner)) {
      var1 = var1.owner;
    }

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      if(isDefined(var1) && var1.team == var0.team) {
        playFX(level.conf_fx["vanish"], var0.trigger.origin);
        playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], var0.trigger.origin + (0, 0, 45));
      } else {
        playFX(level.conf_fx["vanish"], var0.trigger.origin);
        playFX(level.spawnoffsettacinsertmax["vanish_hw_en"], var0.trigger.origin + (0, 0, 45));
      }
    } else {
      var0.visuals setscriptablepartstate("visibility", "hide", 0);
    }

    var0.trigger hide();
    var0.curorigin = (0, 0, 1000);
    var0.trigger.origin = (0, 0, 1000);
    var0.visuals.origin = (0, 0, 1000);
    var0 scripts\mp\gameobjects::allowuse("none");
    playersettagcount(var1, var1.tagscarried + 1);
    var1 thread scripts\mp\utility\points::giveunifiedpoints("tag_collected");

    if(istrue(level.setplayerselfrevivingextrainfo)) {
      var1 playSound("mp_killconfirm_tags_pickup_hw");
    } else {
      var1 playSound("mp_grind_token_pickup");
    }

    if(isDefined(level.supportcranked) && level.supportcranked) {
      if(isDefined(var1.cranked) && var1.cranked) {
        var1 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
      } else {
        var1 scripts\mp\cranked::oncranked(undefined, var1);
      }
    }

    break;
  }
}

function onplayerconnect(var0) {
  var0.isscoring = 0;
  thread monitorjointeam();
}

function playersettagcount(var0) {
  self.tagscarried = var0;
  self.game_extrainfo = var0;

  if(var0 > 999) {
    var0 = 999;
  }

  self setclientomnvar("ui_grind_tags", var0);
}

function monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
    playersettagcount(0);
  }
}

function hidehudelementongameend(var0) {
  level waittill("game_ended");

  if(isDefined(var0)) {
    var0.alpha = 0;
    return;
  }
}

function createzones() {
  var0 = getEntArray("grind_location", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\mp\gametypes\obj_grindzone::setupobjective(var2, 1, 1);
    thread runzonethink();
    level.objectives[var3.objectivekey] = var3;
  }

  if(level.mapname == "mp_deadzone") {
    var5 = spawnStruct();
    var5.origin = (1416, 1368, 300);
    var5.angles = (0, 0, 0);
    var5.script_label = "b";
    var3 = scripts\mp\gametypes\obj_grindzone::setupobjective(var5, 1, 1);
    thread runzonethink();
    level.objectives[var3.objectivekey] = var3;
  }

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  foreach(var3 in level.objectives) {
    var7 = scripts\mp\gametypes\obj_grindzone::getreservedobjid(var3.objectivekey);
    var3 scripts\mp\gameobjects::requestid(1, 1, var7);
    var3 scripts\mp\gameobjects::setvisibleteam("any");
    var3 scripts\mp\gametypes\obj_grindzone::ref_1317d();
    var3 scripts\mp\gametypes\obj_grindzone::setneutral();
  }
}

function isinzone(var0, var1) {
  if(scripts\mp\utility\player::isreallyalive(var0) && var0 istouching(var1.trigger) && var1.ownerteam == var0.team) {
    return true;
  }

  return false;
}

function runzonethink() {
  level endon("game_ended");
  self endon("stop_trigger" + self.objectivekey);

  for(;;) {
    self.trigger waittill("trigger", var0);

    if(self.disabled) {
      continue;
    }

    if(self.stalemate) {
      continue;
    }

    if(isagent(var0)) {
      continue;
    }

    if(!isPlayer(var0)) {
      continue;
    }

    if(var0.isscoring) {
      continue;
    }

    var0.isscoring = 1;
    thread processscoring(level, var0);
  }
}

function removetagsongameended() {
  level waittill("game_ended");

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    if(!isDefined(var1.tagscarried)) {
      continue;
    }

    var1.tagscarried = 0;
  }
}

function processscoring(var0, var1) {
  while(var0.tagscarried && isinzone(var0, var1) && !var1.stalemate && !var1.disabled) {
    if(var0.tagscarried >= level.megabanklimit) {
      var0 playsoundtoplayer("mp_grind_token_banked_large", var0);
      scoreamount(var0, level.megabanklimit, var1);
      var2 = scripts\mp\rank::getscoreinfovalue("tag_score");
      var2 *= level.megabanklimit;

      if(!var0 scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
        var0 scripts\mp\killstreaks\killstreaks::givestreakpoints("capture", level.megabankbonusks);
      }

      var0 thread scripts\mp\utility\points::giveunifiedpoints("mega_bank", undefined, var2 + level.megabankbonus);
      var0 scripts\mp\utility\stats::incpersstat("tagsMegaBanked", 1);
    } else {
      var0 playsoundtoplayer("mp_grind_token_banked", var0);
      var3 = level.bankrate;

      if(var3 > var0.tagscarried) {
        var3 = var0.tagscarried;
      }

      scoreamount(var0, var3, var1);

      for(var4 = 0; var4 < var3; var4++) {
        var0 thread scripts\mp\utility\points::giveunifiedpoints("tag_score");
      }
    }

    if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var0.cranked) && var0.cranked) {
      var0 scripts\mp\cranked::setcrankedplayerbombtimer("kill");
    }

    wait level.banktime;
  }

  var1 scripts\mp\gametypes\obj_grindzone::setneutralicons();
  var0.isscoring = 0;
}

function scoreamount(var0, var1, var2) {
  playersettagcount(var0, var0.tagscarried - var1);
  scripts\mp\gamescore::giveteamscoreforobjective(var0.team, var1, 0);
  var0 scripts\mp\utility\stats::incpersstat("confirmed", var1);
  var0 scripts\mp\persistence::statsetchild("round", "confirmed", var0.pers["confirmed"]);
  var0 scripts\mp\utility\stats::setextrascore0(var0.pers["confirmed"]);

  if(level.bankdisable) {
    var2.tagsdeposited += var1;

    if(var2.tagsdeposited >= level.bankdisabletags) {
      var2 scripts\mp\gameobjects::allowuse("none");
      thread ref_1439d();
      var2.disabled = 1;
      var2.scriptable setscriptablepartstate("flag", "off");
      var2.scriptable setscriptablepartstate("pulse", "off");

      if(isDefined(var2.objectivekey)) {
        foreach(var4 in level.teamnamelist) {
          scripts\mp\utility\dialog::statusdialog("grind_disable_" + var2.objectivekey, var4);
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
  foreach(var1 in level.players) {
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var1);
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
    foreach(var1 in level.teamnamelist) {
      scripts\mp\utility\dialog::statusdialog("grind_enable_" + self.objectivekey, var1);
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var2);
  scripts\mp\spawnlogic::registerspawnset("fallback", var3);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var0 + "_start");
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
  } else {
    var2 = scripts\mp\spawnlogic::getspawnpoint(self, var2, "normal", "fallback");
  }

  return var2;
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);
  thread droptags(level, var0);
}

function droptags(var0, var1) {
  if(isagent(var0)) {
    return;
  }

  if(var0.tagscarried > 49) {
    var2 = 49;
  } else if(var1.tagscarried > 0) {
    var2 = var1.tagscarried + 1;
  } else {
    var2 = 1;
  }

  if(istrue(level.setplayerselfrevivingextrainfo) && !isDefined(level.player_current_primary_is_rpg)) {
    level.player_current_primary_is_rpg = 1;
    var2 = 4;
  }

  for(var3 = 0; var3 < var2; var3++) {
    var4 = spawntag(var2);
    var4.team = var2.team;
    var4.victim = var2;
    var4.attacker = var2;
    level notify("new_tag_spawned", var4);
    thread monitortaguse(level);
  }

  var5 = var2.tagscarried - var2;
  var5 = int(max(0, var5));
  playersettagcount(var2, var5);
}

function dogtagallyonusecb(var0) {
  if(isPlayer(var0)) {
    var0 scripts\mp\utility\stats::setextrascore1(var0.pers["denied"]);
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
      var0 = getDvar("scr_devRemoveDomFlag", "");

      foreach(var2 in level.objectives) {
        if(isDefined(var2.objectivekey) && var2.objectivekey == var0) {
          var2 notify("stop_trigger" + var2.objectivekey);
          var2 scripts\mp\gameobjects::allowuse("none");
          var2.trigger = undefined;
          var2 notify("deleted");
          var2.visibleteam = "none";
          var2 scripts\mp\gameobjects::setobjectivestatusicons(undefined, undefined);
          var3 = [];

          foreach(var5 in level.objectives) {
            if(var5.objectivekey != var0) {
              var3 = var5;
            }
          }

          level.objectives = var3;
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
      var0 = getDvar("scr_devPlaceDomFlag", "");
      var1 = undefined;
      var2 = getEntArray("grind_location", "targetname");

      foreach(var4 in var2) {
        if("_" + var4.script_label == var0) {
          var1 = var4;
        }
      }

      var1.origin = level.players[0].origin;
      var1.ownerteam = "neutral";
      var6 = var1.origin + (0, 0, 32);
      var7 = var1.origin + (0, 0, -32);
      var8 = scripts\engine\trace::ray_trace(var6, var7, undefined, scripts\engine\trace::create_default_contents(1));
      var1.origin = var8["position"];
      var1.upangles = vectortoangles(var8["normal"]);
      var1.forward = anglesToForward(var1.upangles);
      var1.right = anglestoright(var1.upangles);
      GscBinSkip1(0x45, 0, spawn("script_model", var1.origin));
    }

    wait 1;
  }
}