/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\tac_ops\hostage_utility.gsc
**************************************************/

function hostagesysteminit() {
  level.activehostagecount = 0;
  level.hostages = [];
  level.inactiveextractions = [];
  level.activeextractions = [];
  level.activeextractors = [];
  level.hostagehidespots = scripts\engine\utility::getStructArray("hostage", "targetname");
  level.hostageexitpoints = scripts\engine\utility::getStructArray("hostage_exit", "targetname");

  foreach(var_1 in level.hostageexitpoints) {
    level.objective[level.objective.size] = spawn("trigger_radius", var_1.origin, 0, 90, 128);
  }

  level.randhidespots = scripts\engine\utility::array_randomize(level.hostagehidespots);
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  thread hostagestatuswatcher();
}

function numextractpointsavailable() {
  return level.inactiveextractions.size;
}

function heloextracttryuse(var_0) {
  var_1 = scripts\mp\killstreaks\target_marker::gettargetmarker(var_0);

  if(!isDefined(var_1.location)) {
    return false;
  }

  if(numextractpointsavailable() == 0) {
    iprintlnbold("COPTERS ALREADY ON THE WAY");

    if(isDefined(var_1.visual)) {
      var_1.visual delete();
    }

    return false;
  }

  scripts\mp\gametypes\to_hstg::trycreateextractpoint(var_1.location, var_1);
  var_2 = scripts\mp\gametypes\tac_ops::gettacopstimeremainingms();

  if(var_2 < scripts\mp\gametypes\to_hstg::getextractiontimeconst() * 1000) {
    startlastextraction();
  }

  return true;
}

function spawnhostage(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "vip") {
    var_1 = game["attackers"];
    var_3 = "body_opforce_london_terrorist_1_2";
    var_4 = "head_male_bc_03";
  } else {
    var_3 = "neutral";
    var_3 = "body_mp_western_fireteam_west_ar_1_1_lod1";
    var_4 = "head_mp_western_fireteam_west_ar_1_1";
  }

  var_5 = spawn("script_model", var_2);
  var_6 = spawn("script_model", var_2);
  var_7 = spawn("script_model", var_2);
  var_6 setModel(var_3);
  var_7 setModel(var_4);
  var_7 linkTo(var_6, "j_neck", (-9, 1, 0), (0, 0, 0));
  var_6 linkTo(var_5, "", (0, 0, -48), (0, 0, 0));
  var_8 = spawn("script_model", var_2);
  var_8.team = var_3;
  var_8.destination = var_2;
  var_5.trigger = var_8;
  var_8 linkTo(var_5);
  var_5.trigger makeusable();
  var_5.body = var_6;
  var_5.head = var_7;
  var_5 = drophostage(undefined, var_5, var_2, 1);
  var_5.teamscored["allies"] = 0;
  var_5.teamscored["axis"] = 0;
  var_5.wasindent = 0;
  var_5.requireslos = 1;
  var_5.setdropped = &drophostage;
  var_5.team = var_3;
  var_5.usehostagedrop = 1;
  var_5.ownerteam = var_3;
  var_5.interactteam = scripts\engine\utility::ter_op(var_3 == "neutral", "any", "friendly");
  var_5.exclusiveuse = 0;
  var_5.curprogress = 0;
  var_5.usetime = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "cmd", 500, 0);
  var_5.userate = 1;
  var_5.id = "care_package";
  var_5.skiptouching = 1;
  var_5.onuse = &hostageonuse;
  var_5 thread scripts\mp\gameobjects::useobjectusethink();
  var_9 = "icon_minimap_tac_ops_hostage_unknown";
  var_10 = spawn("script_model", var_2);
  var_10 linkTo(var_5);
  var_5.attachobj = var_10;

  if(var_3 == "neutral") {
    var_11 = "any";
    var_12 = "any";
  } else {
    var_11 = "friendly";
    var_12 = "friendly";
  }

  if(scripts\mp\utility\game::getgametype() != "cmd" && var_4) {
    var_7.trackedobject = var_7 scripts\mp\gameobjects::createtrackedobject(var_12, (0, 0, 0));
    var_7.trackedobject.objidpingfriendly = 0;
    var_7.trackedobject.objidpingenemy = 1;
    var_7.trackedobject.objpingdelay = 2;
    var_7.trackedobject scripts\mp\gameobjects::allowcarry(var_11);
    var_7.trackedobject scripts\mp\gameobjects::setownerteam(var_7.ownerteam);
    var_7.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);
    var_7.trackedobject.cancontestclaim = 1;
    var_7.trackedobject.stalemate = 0;
    var_7.trackedobject.wasstalemate = 1;
    var_7.trackedobject scripts\mp\gameobjects::setvisibleteam(var_12);
  }

  if(isDefined(var_7.trackedobject)) {
    var_7.trackedobject scripts\mp\gameobjects::allowcarry(var_3);
    var_7.trackedobject scripts\mp\gameobjects::setownerteam(var_3);
    var_7.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);

    if(scripts\mp\utility\game::getgametype() == "btm" || scripts\mp\utility\game::getgametype() == "arm") {
      var_7.trackedobject.cancontestclaim = 1;
      var_7.trackedobject.stalemate = 0;
      var_7.trackedobject.wasstalemate = 1;
    }

    var_7.trackedobject scripts\mp\gameobjects::setvisibleteam(var_12);
  }

  return var_7;
}

function spawnallhostages(var_0) {
  for(var_1 = 0; var_1 < level.hostagehidespots.size; var_1++) {
    level.hostages[var_1] = spawnhostage(level.hostagehidespots[var_1].origin, var_0);
  }
}

function spawnrandomhostages(var_0, var_1) {
  var_2 = int(min(5 - level.activehostagecount, min(level.randhidespots.size - level.spawnedhostagecount, var_0)));

  if(var_2 == 0) {
    return;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    level.hostages[level.spawnedhostagecount + var_3] = spawnhostage(level.randhidespots[level.spawnedhostagecount + var_3].origin, var_1);
  }

  level.spawnedhostagecount += var_2;
  level.activehostagecount += var_2;
}

function spawnwmhostagecarry() {
  var_0 = spawn("script_model", self.origin);
  var_1 = spawn("script_model", self.origin);
  var_0 setModel("body_opforce_london_terrorist_1_2");
  var_1 setModel("head_male_bc_03");
  var_1 linkTo(var_0, "j_neck", (-9, 1, 0), (0, 0, 0));

  if(false) {
    var_0 scriptmodelplayanimdeltamotion("wm_firemancarry_loop_mp_stand");
    var_0 linkTo(self, "j_shoulder_le");
  } else {
    var_0 scriptmodelplayanimdeltamotion("hm_grnd_civ_react02_idle04");
    var_0 linkTo(self, "j_shoulder_le", (-12, -8, -8), (0, 0, 30));
    var_1 hidefromplayer(self);
    var_0 hidefromplayer(self);
  }

  var_0.head = var_1;
  self.hostagecarried.wmhostage = var_0;
  return var_0;
}

function hostageonuse(var_0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("dropped");
  var_0 endon("death");

  if(istrue(self.inlaststand)) {
    return;
  }

  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0.01);
  var_0.ui_securing = undefined;
  thread scripts\mp\gameobjects::updatecurorigin();
  level.hostagecarrier = var_0;
  self.trigger makeunusable();
  var_0.hostagecarried = self;

  if(scripts\mp\utility\game::getgametype() == "vip" || scripts\mp\utility\game::getgametype() == "btm") {
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.team, 11, 12, level.hostagecarrier, 13);
  }

  carrydebuff(var_0);
  thread playthanksvo();
  wait 0.4;
  spawnwmhostagecarry(var_0);
  var_0.hostagecarried.body hide(1);
  var_0.hostagecarried.head hide(1);
  self linkTo(var_0, "tag_eye", (0, 0, 0), (0, 0, 0));

  if(isDefined(self.trackedobject)) {
    self.trackedobject.ownerteam = var_0.team;
    self.trackedobject.carrier = var_0;
    self.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);
  }

  if(scripts\mp\utility\game::getgametype() != "btm" && isDefined(level.hostagegoalent)) {
    level.hostagegoalent.ownerteam = var_0.team;
    level.hostagegoalent scripts\mp\gameobjects::requestid(1, 1);
    level.hostagegoalent scripts\mp\gameobjects::setvisibleteam("any");
    level.hostagegoalent scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.iconpreventextract);
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var_0 scripts\mp\gametypes\btm::summonextractchopper(level.vipextractzones[var_0.team]);
    level.vipextractzones[var_0.team].goalent scripts\mp\gameobjects::setvisibleteam("any");
  }

  if(isDefined(self.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
  }

  if(scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm" || scripts\mp\utility\game::getgametype() == "arm") {
    if(var_0.team == "axis") {
      var_0.hostageoutlineid = scripts\mp\utility\outline::outlineenableforteam(var_0, "axis", "outline_nodepth_orange", "killstreak_personal");
    } else {
      var_0.hostageoutlineid = scripts\mp\utility\outline::outlineenableforteam(var_0, "allies", "outline_nodepth_cyan", "killstreak_personal");
    }
  }

  if(!isDefined(self.useobj)) {
    self.useobj = spawn("script_model", var_0.origin);
  }

  self.useobj linkTo(var_0, "tag_eye");
  self.useobj makeusable();
  self.useobj setCursorHint("HINT_NOICON");
  self.useobj sethintonobstruction("show");

  if(scripts\mp\utility\game::getgametype() == "vip") {
    self.useobj setHintString(&"MP/HOLD_TO_DROP_VIP");
  } else {
    self.useobj setHintString(&"MP/HOLD_TO_DROP_HOSTAGE");
  }

  self.useobj sethintdisplayfov(360);
  self.useobj setusefov(360);
  self.useobj sethintdisplayrange(100);
  self.useobj setuserange(100);
  self.useobj setusepriority(-3);
  var_0 giveandfireoffhand("temp_hostage_carry_mp");
  var_0.carryobject = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      self.useobj enableplayeruse(var_2);
      continue;
    }

    self.useobj disableplayeruse(var_2);
  }

  foreach(var_5 in level.hostages) {
    if(var_5 != self) {
      var_5 disableplayeruse(var_0);
    }
  }

  thread watchhostagedrop(var_0, self, self.useobj);

  if(isDefined(level.tacopssublevel)) {
    thread chemistcomplaining();
  }

  thread laststandlistener(var_0);

  if(self.wasindent) {}

  self.wasindent = 1;
  level notify("hostage_status_update", 1);
}

function playthanksvo() {
  wait 4;
  self playSound("dx_mpb_us3_hvt_thank");
}

function spawncmdgoal() {
  level endon("game_ended");
  self endon("death");
  self endon("dropped_hostage");
  var_0 = (-1970, -1692, 5);
  level.hostagegoalent = spawn("script_model", var_0);
  level.hostagegoalent.angles = (0, 270, 0);
  level.hostagegoalent.team = "allies";
  level.hostagegoalent setModel("cop_marker_scriptable");
  level.hostagegoalent setscriptablepartstate("marker", "red");
  level.hostagegoalent playLoopSound("mp_flare_burn_lp");
  level.hostagegoalent thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 60);
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], level.hostagegoalent, "tag_origin");
  var_1 = spawn("trigger_radius", var_0, 0, 120, 128);
  thread goaltriggerwatcher(var_1);
}

function goaltriggerwatcher(var_0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");
  self waittill("trigger", var_0);

  if(isDefined(var_0.hostagecarried)) {
    drophostage(var_0, level.hostages[0], var_0.origin);
    level.hostages[0].trigger makeunusable();
    level.hostages[0] makeunusable();
    level.hostages[0].useobj unlink();
    level.hostages[0].useobj makeunusable();

    if(isDefined(level.hostages[0].outlineid)) {
      scripts\mp\utility\outline::outlinedisable(level.hostages[0].outlineid, level.hostages[0].body);
    }

    thread spawnstartbradley(var_0);
  }

  self delete();
}

function spawnstartbradley(var_0) {
  while(!isDefined(level.bradley)) {
    waitframe();
  }

  var_1 = (-2139, -1977, 64);
  var_2 = (0, 270, 0);
  var_3 = var_0.team;
  var_4 = [];

  foreach(var_6 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
    if(distancesquared(var_6.origin, var_1) < 360000) {
      var_6 queuedialogforplayer("dx_mpp_usp1_hostage_extraction", "cop_hostage_extraction", 2);
    }
  }

  wait 3;
  scripts\mp\utility\dialog::leaderdialog("cop_killstreak_bradley", var_3, "killstreak_used", var_4);
  scripts\mp\utility\dialog::leaderdialog("cop_enemy_bradley", scripts\mp\utility\game::getotherteam(var_3)[0], "killstreak_used", var_4);
  scripts\mp\gametypes\bradley_spawner::spawnbradleynoduration(var_1, var_2, "allies");
}

function getclosestcheckpoint(var_0) {
  var_1 = level.extractionlocent.origin;
  var_2 = var_1 - level.hostagecheckpointent[0][0].origin;
  var_3 = undefined;

  for(var_4 = 0; var_4 < level.hostagecheckpointent.size; var_4++) {
    var_5 = level.hostagecheckpointent[var_4][0].origin;
    var_6 = var_5 - var_0;

    if(vectordot(var_2, var_6) < 0) {
      var_3 = var_5;
    }
  }

  if(!isDefined(var_3)) {
    var_3 = level.hostagecheckpointent[0][0].origin;
  }

  return var_3;
}

function getclosestfleezone(var_0) {
  var_1 = level.hostageexitpoints[0].origin;
  var_2 = distancesquared(var_0, var_1);

  for(var_3 = 1; var_3 < level.hostageexitpoints.size; var_3++) {
    var_4 = level.hostageexitpoints[var_3].origin;
    var_5 = distancesquared(var_4, var_0);

    if(var_2 > var_5) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

function hostagethreatwatcher() {
  level endon("game_ended");
  self endon("hostage_scored");
  level endon("hostage_phase_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = distancesquared(var_1 getEye(), self.origin);

      if(var_1.team == "allies" && isalive(var_1)) {
        if(var_2 < 57600) {
          hostagestoprunning();
          return;
        }
      }
    }

    wait 0.5;
  }
}

function hostagestoprunning() {
  self notify("hostage_stopped");
  self.isrunning = 0;
  drophostage(undefined, self, self.origin);
}

function hostagenearbywatcher() {
  level endon("game_ended");
  level endon("hostage_phase_ended");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1.team != "axis") {
        continue;
      }

      var_2 = hasextractionkillstreak(var_1);
      var_3 = 0;
      var_4 = 0;

      foreach(var_6 in level.activeextractors) {
        if(var_1 == var_6) {
          var_4 = 1;
        }
      }

      foreach(var_9 in level.hostages) {
        var_10 = distancesquared(var_1 getEye(), var_9.origin);

        if(!istrue(var_9.isrunning)) {
          if(var_10 < 14400 && proxentlos(var_9, var_1)) {
            var_3 = 1;
            break;
          }
        }
      }

      if(istrue(level.lastevaccopterdeployed) || var_2 && !var_3) {
        removeextractionkillstreak(var_1);
        var_1 notify("equip_deploy_end");
        var_1 scripts\mp\killstreaks\killstreaks::updatekillstreakuislots();
        var_1 scripts\mp\killstreaks\killstreaks::updatekillstreakselectedui();

        if(!var_4 && istrue(level.lastevaccopterdeployed)) {
          delayplayerwarning(var_1, "The last evac copter is already en route!");
        }

        break;
      }

      if(!var_4 && !var_2 && var_3) {
        var_1 clearoffhandprimary();
        var_1 scripts\mp\killstreaks\killstreaks::awardkillstreak("tacops_beacon_mp", "other");
        var_1 iprintlnbold("DPAD-Right to call an evac copter");
        break;
      }
    }

    wait 0.5;
  }
}

function proxentlos(var_0) {
  if(!isDefined(self.requireslos)) {
    return true;
  }

  var_1 = var_0 getEye();
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  var_3 = [];
  var_4 = self.origin + (0, 0, 32);
  var_5 = 1;
  var_3 = self.visuals;
  var_3 = var_0;
  var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);

  if(var_6["fraction"] != 1 && var_5) {
    var_4 = self.origin + (0, 0, 16);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  if(var_6["fraction"] != 1) {
    var_4 = self.origin + (0, 0, 0);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  return var_6["fraction"] == 1;
}

function delayplayerwarning(var_0) {
  if(!isDefined(self.lastlzwarning)) {
    self iprintlnbold(var_0);
    self.lastlzwarning = 1;
    wait 10;
    self.lastlzwarning = undefined;
    return;
  }
}

function startlastextraction() {
  level.lastevaccopterdeployed = 1;
  scripts\mp\gametypes\tac_ops::extendtacopstimelimitms(60000);
}

function hasextractionkillstreak() {
  var_0 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.streakname == "tacops_beacon_mp") {
      return true;
    }
  }

  return false;
}

function removeextractionkillstreak() {
  var_0 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.streakname == "tacops_beacon_mp") {
      scripts\mp\killstreaks\killstreaks::removekillstreak(0);
    }
  }
}

function manageheadicons(var_0) {
  self.ownerteamid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  objective_onentity(self.ownerteamid, self);
  objective_addteamtomask(self.ownerteamid, var_0.team);
  self.teamheadicon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_0.team, "waypoint_blitz_defend", 36);
}

function moveonpath(var_0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("hostage_scored");
  self endon("hostage_stopped");
  var_1 = 100;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_4 = getphysicspointaboutnavmesh(var_3);
    var_5 = distance(self.origin, var_4);

    if(var_5 == 0) {
      continue;
    }

    var_6 = var_5 / var_1;
    self.angles = vectortoangles(var_4 - self.origin);
    self moveTo(var_4, var_6, 0, 0);
    wait var_6;
  }

  thread hostagestoprunning();
}

function scorehostage(var_0, var_1) {
  level.hostages = scripts\engine\utility::array_remove(level.hostages, self);
  scripts\mp\gameobjects::deletetrackedobject();
  level.activehostagecount--;

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.body delete();
  self.head delete();
  self delete();
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0, var_1, 0);
  self notify("hostage_scored");
}

function removeminimapicons() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.curobjid);

  if(isDefined(self.useobj)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.useobj.ownerteamid);
  }

  if(isDefined(self.useobj) && isDefined(self.useobj.teamheadicon)) {
    self.useobj.teamheadicon destroy();

    foreach(var_1 in self.useobj.entityheadicons) {
      if(!isDefined(var_1)) {
        continue;
      }

      var_1 destroy();
    }

    return;
  }
}

function getphysicspointaboutnavmesh(var_0) {
  var_1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var_2 = physics_raycast(var_0 + (0, 0, 48), var_0 - (0, 0, 48), var_1, undefined, 0, "physicsquery_closest");
  var_3 = isDefined(var_2) && var_2.size > 0;

  if(var_3) {
    var_4 = var_2[0]["position"];
    return var_4;
  }

  return var_1;
}

function drophostage(var_0, var_1, var_2, var_3, var_4) {
  self notify("gameobject_deleted");

  if(!isDefined(var_0)) {
    var_0 = self.carrier;
  }

  if(!isDefined(var_2)) {
    var_2 = self.curorigin;
  }

  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_1 notify("dropped");

  if(isDefined(var_1.trackedobject)) {
    var_1.trackedobject.carrier = var_1.attachobj;
    var_1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);

    if(isDefined(var_0) && isDefined(var_0.hostageoutlineid)) {
      scripts\mp\utility\outline::outlinedisable(var_0.hostageoutlineid, var_0);
    }

    if(scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm" || scripts\mp\utility\game::getgametype() == "arm") {
      var_1.outlineid = scripts\mp\utility\outline::outlineenableforall(var_1.body, "outline_nodepth_cyan", "killstreak_personal");
    }
  }

  if(isDefined(level.hostagegoalent)) {
    level.hostagegoalent scripts\mp\gameobjects::setvisibleteam("none");
    level.hostagegoalent scripts\mp\gameobjects::releaseid();
  }

  if(scripts\mp\utility\game::getgametype() == "btm" && isDefined(level.vipextractzones)) {
    level.vipextractzones[var_0.team].goalent scripts\mp\gameobjects::setvisibleteam("none");
  }

  var_1.carried = 0;
  var_5 = var_2;
  var_1 unlink();
  var_5 = getclosestpointonnavmesh(var_2);
  var_1.origin = getphysicspointaboutnavmesh(var_5) + (0, 0, 2);
  var_1.angles = (0, var_1.angles[1], 0);

  if(!isDefined(var_3) && isDefined(var_1.useobj)) {
    var_1.useobj.origin = var_1.origin;
  }

  if(isDefined(var_0)) {
    var_0.carryobject = undefined;
    var_6 = var_0.team;

    foreach(var_8 in level.hostages) {
      if(var_8 != var_1) {
        var_8 enableplayeruse(var_0);
      }
    }

    removecarrydebuff(var_0, !isDefined(var_4));
  }

  if(isDefined(var_1.wmhostage)) {
    var_1.wmhostage unlink();
    var_1.wmhostage.head delete();
    var_1.wmhostage delete();
    var_1.wmhostage = undefined;
  }

  if(isDefined(var_4)) {
    wait var_4;
  }

  if(isDefined(var_0) && isDefined(var_0.hostagecarried)) {
    var_0.hostagecarried.body show();
    var_0.hostagecarried.head show();
    var_0.hostagecarried = undefined;
  } else {
    var_1.body show();
    var_1.head show();
  }

  var_1.trigger makeusable();

  if(isDefined(var_4)) {
    restoreweapons(var_0);
  }

  level.hostagecarrier = undefined;

  if(scripts\mp\utility\game::getgametype() == "vip") {
    foreach(var_0 in level.players) {
      if(var_0.team != var_1.trigger.team) {
        var_1.trigger disableplayeruse(var_0);
        var_1.trigger hidefromplayer(var_0);
      }
    }

    var_1.trigger setHintString(&"MP/HOLD_TO_PICKUP_VIP");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1.team, 10, 12);
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var_1.trigger setHintString(&"MP/HOLD_TO_PICKUP_VIP");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_1.team, 10, 12);
  } else {
    var_1.trigger setHintString(&"MP/HOLD_TO_PICKUP_HOSTAGE");
  }

  var_1 setusepriority(-3);

  if(isDefined(var_1.curobjid)) {
    objective_setownerteam(var_1.curobjid, "neutral");
  }

  if(isDefined(var_1.body)) {
    var_1.body linkTo(var_1, "", (0, 0, 0), (0, 0, 0));
    var_1.body scriptmodelplayanimdeltamotion("hm_grnd_civ_react02_idle07");
  }

  return var_1;
}

function restoreweapons() {
  self takeallweapons();

  foreach(var_1 in self.restoreweaponlist) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 0);

    if(scripts\mp\utility\weapon::update_health_bar_to_player(var_1)) {
      self assignweaponmeleeslot(var_1);
    }
  }

  var_3 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_3)) {
    thread scripts\mp\supers::givesuperweapon(var_3);
  }

  var_4 = self.loadoutgesture;

  if(isDefined(var_4)) {
    scripts\cp_mp\gestures::cleargesture();
    scripts\cp_mp\gestures::givegesture(var_4);
  }

  var_5 = "primary";
  var_6 = scripts\mp\equipment::getcurrentequipment(var_5);

  if(isDefined(var_6)) {
    scripts\mp\equipment::giveequipment(var_6, var_5);
  }

  var_5 = "secondary";
  var_6 = scripts\mp\equipment::getcurrentequipment(var_5);

  if(isDefined(var_6)) {
    scripts\mp\equipment::giveequipment(var_6, var_5);
  }

  foreach(var_1 in self.restoreweaponlist) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_1)) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
      break;
    }
  }
}

function carrydebuff() {
  if(istrue(level.hostagecarrystates[self.guid])) {
    return;
  }

  scripts\common\utility::allow_prone(0);
  scripts\common\utility::allow_mantle(0);
  var_0 = "iw8_hvtcarry_mp";

  if(scripts\common\utility::iscp()) {
    var_0 = "iw8_hvtcarry_cp";
  }

  scripts\mp\utility\player::_setsuit(var_0);
  scripts\mp\utility\perk::giveperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = 0.75;
  scripts\mp\weapons::updatemovespeedscale();
  var_1 = "iw8_pi_golf21_mp";
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1);
  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, "mod_hvt");
}

function refillsinglecountammo() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death_or_disconnect");
  self endon("dropped_hostage");

  for(;;) {
    if(scripts\mp\utility\player::isreallyalive(self) && self.team != "spectator" && isDefined(self.lastdroppableweaponobj) && self getcurrentweaponclipammo() == 0) {
      wait 1;
      self notify("reload");
      wait 1;
      continue;
    }

    waitframe();
  }
}

function refillammo() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death_or_disconnect");
  self endon("dropped_hostage");

  for(;;) {
    self waittill("reload");
    self givestartammo(self.currentprimaryweapon);
  }
}

function removecarrydebuff(var_0) {
  if(!istrue(level.hostagecarrystates[self.guid])) {
    return;
  }

  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_mantle(1);
  scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
  scripts\mp\utility\perk::removeperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = undefined;
  scripts\mp\weapons::updatemovespeedscale();
  scripts\cp_mp\utility\inventory_utility::getridofweapon("temp_hostage_carry_mp");
  scripts\common\utility::allow_weapon_switch(1);

  if(var_0) {
    restoreweapons();
  }

  level.hostagecarrystates[self.guid] = 0;
  self notify("dropped_hostage");
}

function chemistcomplaining() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  level endon("dropped_hostage");

  for(;;) {
    wait 5 + randomfloatrange(3, 10);
    playsoundatpos(self.origin, "dx_mpb_chem_phase2_chemreact");
    wait 5 + randomfloatrange(3, 10);
  }
}

function laststandlistener(var_0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
}

function watchhostagedrop(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death");
  self.carried = 1;
  var_3 = 0;
  self.carrier = var_0;
  var_4 = level.framedurationseconds;

  while(self.carried) {
    if(!var_0 useButtonPressed()) {
      var_3 = 1;
    }

    var_5 = 0;

    while(var_3 && var_0 useButtonPressed()) {
      var_5 += var_4;

      if(var_5 > 0.3) {
        var_2 unlink();
        var_2 disableplayeruse(var_0);
        var_2 makeunusable();
        var_6 = var_0.origin + anglesToForward(var_0.angles) * 72 + (0, 0, 24);
        drophostage(var_0, var_1, var_6, undefined, 1.4);
        return;
      }

      wait var_5;
    }

    waitframe();
  }
}

function obfuscateobjectiveposition() {
  self endon("death");
  var_0 = 512;
  var_1 = var_0 / 2;

  for(;;) {
    var_2 = randomfloatrange(var_1 / 3, var_1);

    if(randomint(2) == 0) {
      var_2 *= -1;
    }

    var_3 = randomfloatrange(var_1 / 3, var_1);

    if(randomint(2) == 0) {
      var_3 *= -1;
    }

    var_4 = (var_2, var_3, 0);
    scripts\mp\objidpoolmanager::update_objective_position(self.curobjid, self.origin + (var_2, var_3, 0));
    wait randomfloatrange(8, 13);
  }
}

function createobjective(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var_1 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "invisible", (0, 0, 0), var_0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_1, self);
  scripts\mp\objidpoolmanager::update_objective_state(var_1, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(var_1, var_0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1);

  if(isDefined(level.objvisall)) {
    [[level.objvisall]](var_1);
  }

  return var_1;
}

function hostagestatuswatcher() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  level endon("hostage_holdout_phase_begun");
  GscBinSkip4(0x6e, level);
}

function hostageallygrabbedchatterwatcher() {
  for(;;) {
    level waittill("hostage_ally_grabbed");
    wait 1;
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_chem_phase2_chemreact", "allies");
    wait 10;
  }
}

function hostageallydroppedchatterwatcher() {
  for(;;) {
    level waittill("hostage_ally_dropped");
    wait 1;
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_chem_phase2_chemreact", "allies");
    wait 10;
  }
}

function hostageallygrabbedwatcher() {
  for(;;) {
    level waittill("hostage_ally_grabbed");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_hvtgraba", "allies");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase1_enemyhvtgrabb", "axis");
    wait 30;
  }
}

function hostageallydroppedwatcher() {
  for(;;) {
    level waittill("hostage_ally_dropped");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_hvtdropa", "allies");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase1_enemyhvtdropb", "axis");
    wait 30;
  }
}

function hostageaxisgrabbedwatcher() {
  for(;;) {
    level waittill("hostage_axis_grabbed");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_enemyhvtgraba", "allies");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase1_hvtgrabb", "axis");
    wait 30;
  }
}

function hostagespawnpushedwatcher() {
  for(;;) {
    level waittill("hostage_spawns_pushed");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_spawnpusha", "allies");
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase2_spawnpushb", "axis");
    wait 30;
  }
}

function proxcmdwatcher() {
  level endon("death");
  var_0 = spawn("trigger_radius", level.hostages[0].origin, 0, 120, 128);
  var_0 waittill("trigger", var_1);

  foreach(var_3 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
    if(distancesquared(var_3.origin, var_0.origin) < 250000) {
      var_3 queuedialogforplayer("dx_mpp_usp1_hostage_located", "cop_hostage_located", 2);
    }
  }

  var_0 delete();
}