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

  foreach(var1 in level.hostageexitpoints) {
    level.objective[level.objective.size] = spawn("trigger_radius", var1.origin, 0, 90, 128);
  }

  level.randhidespots = scripts\engine\utility::array_randomize(level.hostagehidespots);
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  thread hostagestatuswatcher();
}

function numextractpointsavailable() {
  return level.inactiveextractions.size;
}

function heloextracttryuse(var0) {
  var1 = scripts\mp\killstreaks\target_marker::gettargetmarker(var0);

  if(!isDefined(var1.location)) {
    return false;
  }

  if(numextractpointsavailable() == 0) {
    iprintlnbold("COPTERS ALREADY ON THE WAY");

    if(isDefined(var1.visual)) {
      var1.visual delete();
    }

    return false;
  }

  scripts\mp\gametypes\to_hstg::trycreateextractpoint(var1.location, var1);
  var2 = scripts\mp\gametypes\tac_ops::gettacopstimeremainingms();

  if(var2 < scripts\mp\gametypes\to_hstg::getextractiontimeconst() * 1000) {
    startlastextraction();
  }

  return true;
}

function spawnhostage(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "vip") {
    var1 = game["attackers"];
    var3 = "body_opforce_london_terrorist_1_2";
    var4 = "head_male_bc_03";
  } else {
    var3 = "neutral";
    var3 = "body_mp_western_fireteam_west_ar_1_1_lod1";
    var4 = "head_mp_western_fireteam_west_ar_1_1";
  }

  var5 = spawn("script_model", var2);
  var6 = spawn("script_model", var2);
  var7 = spawn("script_model", var2);
  var6 setModel(var3);
  var7 setModel(var4);
  var7 linkTo(var6, "j_neck", (-9, 1, 0), (0, 0, 0));
  var6 linkTo(var5, "", (0, 0, -48), (0, 0, 0));
  var8 = spawn("script_model", var2);
  var8.team = var3;
  var8.destination = var2;
  var5.trigger = var8;
  var8 linkTo(var5);
  var5.trigger makeusable();
  var5.body = var6;
  var5.head = var7;
  var5 = drophostage(undefined, var5, var2, 1);
  var5.teamscored["allies"] = 0;
  var5.teamscored["axis"] = 0;
  var5.wasindent = 0;
  var5.requireslos = 1;
  var5.setdropped = &drophostage;
  var5.team = var3;
  var5.usehostagedrop = 1;
  var5.ownerteam = var3;
  var5.interactteam = scripts\engine\utility::ter_op(var3 == "neutral", "any", "friendly");
  var5.exclusiveuse = 0;
  var5.curprogress = 0;
  var5.usetime = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "cmd", 500, 0);
  var5.userate = 1;
  var5.id = "care_package";
  var5.skiptouching = 1;
  var5.onuse = &hostageonuse;
  var5 thread scripts\mp\gameobjects::useobjectusethink();
  var9 = "icon_minimap_tac_ops_hostage_unknown";
  var10 = spawn("script_model", var2);
  var10 linkTo(var5);
  var5.attachobj = var10;

  if(var3 == "neutral") {
    var11 = "any";
    var12 = "any";
  } else {
    var11 = "friendly";
    var12 = "friendly";
  }

  if(scripts\mp\utility\game::getgametype() != "cmd" && var4) {
    var7.trackedobject = var7 scripts\mp\gameobjects::createtrackedobject(var12, (0, 0, 0));
    var7.trackedobject.objidpingfriendly = 0;
    var7.trackedobject.objidpingenemy = 1;
    var7.trackedobject.objpingdelay = 2;
    var7.trackedobject scripts\mp\gameobjects::allowcarry(var11);
    var7.trackedobject scripts\mp\gameobjects::setownerteam(var7.ownerteam);
    var7.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);
    var7.trackedobject.cancontestclaim = 1;
    var7.trackedobject.stalemate = 0;
    var7.trackedobject.wasstalemate = 1;
    var7.trackedobject scripts\mp\gameobjects::setvisibleteam(var12);
  }

  if(isDefined(var7.trackedobject)) {
    var7.trackedobject scripts\mp\gameobjects::allowcarry(var3);
    var7.trackedobject scripts\mp\gameobjects::setownerteam(var3);
    var7.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);

    if(scripts\mp\utility\game::getgametype() == "btm" || scripts\mp\utility\game::getgametype() == "arm") {
      var7.trackedobject.cancontestclaim = 1;
      var7.trackedobject.stalemate = 0;
      var7.trackedobject.wasstalemate = 1;
    }

    var7.trackedobject scripts\mp\gameobjects::setvisibleteam(var12);
  }

  return var7;
}

function spawnallhostages(var0) {
  for(var1 = 0; var1 < level.hostagehidespots.size; var1++) {
    level.hostages[var1] = spawnhostage(level.hostagehidespots[var1].origin, var0);
  }
}

function spawnrandomhostages(var0, var1) {
  var2 = int(min(5 - level.activehostagecount, min(level.randhidespots.size - level.spawnedhostagecount, var0)));

  if(var2 == 0) {
    return;
  }

  for(var3 = 0; var3 < var2; var3++) {
    level.hostages[level.spawnedhostagecount + var3] = spawnhostage(level.randhidespots[level.spawnedhostagecount + var3].origin, var1);
  }

  level.spawnedhostagecount += var2;
  level.activehostagecount += var2;
}

function spawnwmhostagecarry() {
  var0 = spawn("script_model", self.origin);
  var1 = spawn("script_model", self.origin);
  var0 setModel("body_opforce_london_terrorist_1_2");
  var1 setModel("head_male_bc_03");
  var1 linkTo(var0, "j_neck", (-9, 1, 0), (0, 0, 0));

  if(false) {
    var0 scriptmodelplayanimdeltamotion("wm_firemancarry_loop_mp_stand");
    var0 linkTo(self, "j_shoulder_le");
  } else {
    var0 scriptmodelplayanimdeltamotion("hm_grnd_civ_react02_idle04");
    var0 linkTo(self, "j_shoulder_le", (-12, -8, -8), (0, 0, 30));
    var1 hidefromplayer(self);
    var0 hidefromplayer(self);
  }

  var0.head = var1;
  self.hostagecarried.wmhostage = var0;
  return var0;
}

function hostageonuse(var0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("dropped");
  var0 endon("death");

  if(istrue(self.inlaststand)) {
    return;
  }

  var0 setclientomnvar("ui_securing", 0);
  var0 setclientomnvar("ui_securing_progress", 0.01);
  var0.ui_securing = undefined;
  thread scripts\mp\gameobjects::updatecurorigin();
  level.hostagecarrier = var0;
  self.trigger makeunusable();
  var0.hostagecarried = self;

  if(scripts\mp\utility\game::getgametype() == "vip" || scripts\mp\utility\game::getgametype() == "btm") {
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(self.team, 11, 12, level.hostagecarrier, 13);
  }

  carrydebuff(var0);
  thread playthanksvo();
  wait 0.4;
  spawnwmhostagecarry(var0);
  var0.hostagecarried.body hide(1);
  var0.hostagecarried.head hide(1);
  self linkTo(var0, "tag_eye", (0, 0, 0), (0, 0, 0));

  if(isDefined(self.trackedobject)) {
    self.trackedobject.ownerteam = var0.team;
    self.trackedobject.carrier = var0;
    self.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);
  }

  if(scripts\mp\utility\game::getgametype() != "btm" && isDefined(level.hostagegoalent)) {
    level.hostagegoalent.ownerteam = var0.team;
    level.hostagegoalent scripts\mp\gameobjects::requestid(1, 1);
    level.hostagegoalent scripts\mp\gameobjects::setvisibleteam("any");
    level.hostagegoalent scripts\mp\gameobjects::setobjectivestatusicons(level.iconextract, level.iconpreventextract);
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var0 scripts\mp\gametypes\btm::summonextractchopper(level.vipextractzones[var0.team]);
    level.vipextractzones[var0.team].goalent scripts\mp\gameobjects::setvisibleteam("any");
  }

  if(isDefined(self.outlineid)) {
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
  }

  if(scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm" || scripts\mp\utility\game::getgametype() == "arm") {
    if(var0.team == "axis") {
      var0.hostageoutlineid = scripts\mp\utility\outline::outlineenableforteam(var0, "axis", "outline_nodepth_orange", "killstreak_personal");
    } else {
      var0.hostageoutlineid = scripts\mp\utility\outline::outlineenableforteam(var0, "allies", "outline_nodepth_cyan", "killstreak_personal");
    }
  }

  if(!isDefined(self.useobj)) {
    self.useobj = spawn("script_model", var0.origin);
  }

  self.useobj linkTo(var0, "tag_eye");
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
  var0 giveandfireoffhand("temp_hostage_carry_mp");
  var0.carryobject = self;

  foreach(var2 in level.players) {
    if(var2 == var0) {
      self.useobj enableplayeruse(var2);
      continue;
    }

    self.useobj disableplayeruse(var2);
  }

  foreach(var5 in level.hostages) {
    if(var5 != self) {
      var5 disableplayeruse(var0);
    }
  }

  thread watchhostagedrop(var0, self, self.useobj);

  if(isDefined(level.tacopssublevel)) {
    thread chemistcomplaining();
  }

  thread laststandlistener(var0);

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
  var0 = (-1970, -1692, 5);
  level.hostagegoalent = spawn("script_model", var0);
  level.hostagegoalent.angles = (0, 270, 0);
  level.hostagegoalent.team = "allies";
  level.hostagegoalent setModel("cop_marker_scriptable");
  level.hostagegoalent setscriptablepartstate("marker", "red");
  level.hostagegoalent playLoopSound("mp_flare_burn_lp");
  level.hostagegoalent thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 60);
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], level.hostagegoalent, "tag_origin");
  var1 = spawn("trigger_radius", var0, 0, 120, 128);
  thread goaltriggerwatcher(var1);
}

function goaltriggerwatcher(var0) {
  level endon("game_ended");
  self notify("trigger_start");
  self endon("trigger_start");
  self waittill("trigger", var0);

  if(isDefined(var0.hostagecarried)) {
    drophostage(var0, level.hostages[0], var0.origin);
    level.hostages[0].trigger makeunusable();
    level.hostages[0] makeunusable();
    level.hostages[0].useobj unlink();
    level.hostages[0].useobj makeunusable();

    if(isDefined(level.hostages[0].outlineid)) {
      scripts\mp\utility\outline::outlinedisable(level.hostages[0].outlineid, level.hostages[0].body);
    }

    thread spawnstartbradley(var0);
  }

  self delete();
}

function spawnstartbradley(var0) {
  while(!isDefined(level.bradley)) {
    waitframe();
  }

  var1 = (-2139, -1977, 64);
  var2 = (0, 270, 0);
  var3 = var0.team;
  var4 = [];

  foreach(var6 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
    if(distancesquared(var6.origin, var1) < 360000) {
      var6 queuedialogforplayer("dx_mpp_usp1_hostage_extraction", "cop_hostage_extraction", 2);
    }
  }

  wait 3;
  scripts\mp\utility\dialog::leaderdialog("cop_killstreak_bradley", var3, "killstreak_used", var4);
  scripts\mp\utility\dialog::leaderdialog("cop_enemy_bradley", scripts\mp\utility\game::getotherteam(var3)[0], "killstreak_used", var4);
  scripts\mp\gametypes\bradley_spawner::spawnbradleynoduration(var1, var2, "allies");
}

function getclosestcheckpoint(var0) {
  var1 = level.extractionlocent.origin;
  var2 = var1 - level.hostagecheckpointent[0][0].origin;
  var3 = undefined;

  for(var4 = 0; var4 < level.hostagecheckpointent.size; var4++) {
    var5 = level.hostagecheckpointent[var4][0].origin;
    var6 = var5 - var0;

    if(vectordot(var2, var6) < 0) {
      var3 = var5;
    }
  }

  if(!isDefined(var3)) {
    var3 = level.hostagecheckpointent[0][0].origin;
  }

  return var3;
}

function getclosestfleezone(var0) {
  var1 = level.hostageexitpoints[0].origin;
  var2 = distancesquared(var0, var1);

  for(var3 = 1; var3 < level.hostageexitpoints.size; var3++) {
    var4 = level.hostageexitpoints[var3].origin;
    var5 = distancesquared(var4, var0);

    if(var2 > var5) {
      var1 = var4;
      var2 = var5;
    }
  }

  return var1;
}

function hostagethreatwatcher() {
  level endon("game_ended");
  self endon("hostage_scored");
  level endon("hostage_phase_ended");

  for(;;) {
    foreach(var1 in level.players) {
      var2 = distancesquared(var1 getEye(), self.origin);

      if(var1.team == "allies" && isalive(var1)) {
        if(var2 < 57600) {
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
    foreach(var1 in level.players) {
      if(var1.team != "axis") {
        continue;
      }

      var2 = hasextractionkillstreak(var1);
      var3 = 0;
      var4 = 0;

      foreach(var6 in level.activeextractors) {
        if(var1 == var6) {
          var4 = 1;
        }
      }

      foreach(var9 in level.hostages) {
        var10 = distancesquared(var1 getEye(), var9.origin);

        if(!istrue(var9.isrunning)) {
          if(var10 < 14400 && proxentlos(var9, var1)) {
            var3 = 1;
            break;
          }
        }
      }

      if(istrue(level.lastevaccopterdeployed) || var2 && !var3) {
        removeextractionkillstreak(var1);
        var1 notify("equip_deploy_end");
        var1 scripts\mp\killstreaks\killstreaks::updatekillstreakuislots();
        var1 scripts\mp\killstreaks\killstreaks::updatekillstreakselectedui();

        if(!var4 && istrue(level.lastevaccopterdeployed)) {
          delayplayerwarning(var1, "The last evac copter is already en route!");
        }

        break;
      }

      if(!var4 && !var2 && var3) {
        var1 clearoffhandprimary();
        var1 scripts\mp\killstreaks\killstreaks::awardkillstreak("tacops_beacon_mp", "other");
        var1 iprintlnbold("DPAD-Right to call an evac copter");
        break;
      }
    }

    wait 0.5;
  }
}

function proxentlos(var0) {
  if(!isDefined(self.requireslos)) {
    return true;
  }

  var1 = var0 getEye();
  var2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  var3 = [];
  var4 = self.origin + (0, 0, 32);
  var5 = 1;
  var3 = self.visuals;
  var3 = var0;
  var6 = scripts\engine\trace::ray_trace(var1, var4, var3, var2, 0);

  if(var6["fraction"] != 1 && var5) {
    var4 = self.origin + (0, 0, 16);
    var6 = scripts\engine\trace::ray_trace(var1, var4, var3, var2, 0);
  }

  if(var6["fraction"] != 1) {
    var4 = self.origin + (0, 0, 0);
    var6 = scripts\engine\trace::ray_trace(var1, var4, var3, var2, 0);
  }

  return var6["fraction"] == 1;
}

function delayplayerwarning(var0) {
  if(!isDefined(self.lastlzwarning)) {
    self iprintlnbold(var0);
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
  var0 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(var2.streakname == "tacops_beacon_mp") {
      return true;
    }
  }

  return false;
}

function removeextractionkillstreak() {
  var0 = scripts\mp\killstreaks\killstreaks::getgimmeslotkillstreakstructs();

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(var2.streakname == "tacops_beacon_mp") {
      scripts\mp\killstreaks\killstreaks::removekillstreak(0);
    }
  }
}

function manageheadicons(var0) {
  self.ownerteamid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  objective_onentity(self.ownerteamid, self);
  objective_addteamtomask(self.ownerteamid, var0.team);
  self.teamheadicon = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var0.team, "waypoint_blitz_defend", 36);
}

function moveonpath(var0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("hostage_scored");
  self endon("hostage_stopped");
  var1 = 100;

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = var0[var2];
    var4 = getphysicspointaboutnavmesh(var3);
    var5 = distance(self.origin, var4);

    if(var5 == 0) {
      continue;
    }

    var6 = var5 / var1;
    self.angles = vectortoangles(var4 - self.origin);
    self moveTo(var4, var6, 0, 0);
    wait var6;
  }

  thread hostagestoprunning();
}

function scorehostage(var0, var1) {
  level.hostages = scripts\engine\utility::array_remove(level.hostages, self);
  scripts\mp\gameobjects::deletetrackedobject();
  level.activehostagecount--;

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.body delete();
  self.head delete();
  self delete();
  level scripts\mp\gamescore::giveteamscoreforobjective(var0, var1, 0);
  self notify("hostage_scored");
}

function removeminimapicons() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.curobjid);

  if(isDefined(self.useobj)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.useobj.ownerteamid);
  }

  if(isDefined(self.useobj) && isDefined(self.useobj.teamheadicon)) {
    self.useobj.teamheadicon destroy();

    foreach(var1 in self.useobj.entityheadicons) {
      if(!isDefined(var1)) {
        continue;
      }

      var1 destroy();
    }

    return;
  }
}

function getphysicspointaboutnavmesh(var0) {
  var1 = scripts\engine\trace::create_contents(undefined, 1, 1, undefined, undefined, undefined, undefined);
  var2 = physics_raycast(var0 + (0, 0, 48), var0 - (0, 0, 48), var1, undefined, 0, "physicsquery_closest");
  var3 = isDefined(var2) && var2.size > 0;

  if(var3) {
    var4 = var2[0]["position"];
    return var4;
  }

  return var1;
}

function drophostage(var0, var1, var2, var3, var4) {
  self notify("gameobject_deleted");

  if(!isDefined(var0)) {
    var0 = self.carrier;
  }

  if(!isDefined(var2)) {
    var2 = self.curorigin;
  }

  if(!isDefined(var1)) {
    var1 = self;
  }

  var1 notify("dropped");

  if(isDefined(var1.trackedobject)) {
    var1.trackedobject.carrier = var1.attachobj;
    var1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.iconrecover, level.iconrecover);

    if(isDefined(var0) && isDefined(var0.hostageoutlineid)) {
      scripts\mp\utility\outline::outlinedisable(var0.hostageoutlineid, var0);
    }

    if(scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm" || scripts\mp\utility\game::getgametype() == "arm") {
      var1.outlineid = scripts\mp\utility\outline::outlineenableforall(var1.body, "outline_nodepth_cyan", "killstreak_personal");
    }
  }

  if(isDefined(level.hostagegoalent)) {
    level.hostagegoalent scripts\mp\gameobjects::setvisibleteam("none");
    level.hostagegoalent scripts\mp\gameobjects::releaseid();
  }

  if(scripts\mp\utility\game::getgametype() == "btm" && isDefined(level.vipextractzones)) {
    level.vipextractzones[var0.team].goalent scripts\mp\gameobjects::setvisibleteam("none");
  }

  var1.carried = 0;
  var5 = var2;
  var1 unlink();
  var5 = getclosestpointonnavmesh(var2);
  var1.origin = getphysicspointaboutnavmesh(var5) + (0, 0, 2);
  var1.angles = (0, var1.angles[1], 0);

  if(!isDefined(var3) && isDefined(var1.useobj)) {
    var1.useobj.origin = var1.origin;
  }

  if(isDefined(var0)) {
    var0.carryobject = undefined;
    var6 = var0.team;

    foreach(var8 in level.hostages) {
      if(var8 != var1) {
        var8 enableplayeruse(var0);
      }
    }

    removecarrydebuff(var0, !isDefined(var4));
  }

  if(isDefined(var1.wmhostage)) {
    var1.wmhostage unlink();
    var1.wmhostage.head delete();
    var1.wmhostage delete();
    var1.wmhostage = undefined;
  }

  if(isDefined(var4)) {
    wait var4;
  }

  if(isDefined(var0) && isDefined(var0.hostagecarried)) {
    var0.hostagecarried.body show();
    var0.hostagecarried.head show();
    var0.hostagecarried = undefined;
  } else {
    var1.body show();
    var1.head show();
  }

  var1.trigger makeusable();

  if(isDefined(var4)) {
    restoreweapons(var0);
  }

  level.hostagecarrier = undefined;

  if(scripts\mp\utility\game::getgametype() == "vip") {
    foreach(var0 in level.players) {
      if(var0.team != var1.trigger.team) {
        var1.trigger disableplayeruse(var0);
        var1.trigger hidefromplayer(var0);
      }
    }

    var1.trigger setHintString(&"MP/HOLD_TO_PICKUP_VIP");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var1.team, 10, 12);
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var1.trigger setHintString(&"MP/HOLD_TO_PICKUP_VIP");
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var1.team, 10, 12);
  } else {
    var1.trigger setHintString(&"MP/HOLD_TO_PICKUP_HOSTAGE");
  }

  var1 setusepriority(-3);

  if(isDefined(var1.curobjid)) {
    objective_setownerteam(var1.curobjid, "neutral");
  }

  if(isDefined(var1.body)) {
    var1.body linkTo(var1, "", (0, 0, 0), (0, 0, 0));
    var1.body scriptmodelplayanimdeltamotion("hm_grnd_civ_react02_idle07");
  }

  return var1;
}

function restoreweapons() {
  self takeallweapons();

  foreach(var1 in self.restoreweaponlist) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var1, undefined, undefined, 0);

    if(scripts\mp\utility\weapon::update_health_bar_to_player(var1)) {
      self assignweaponmeleeslot(var1);
    }
  }

  var3 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(var3)) {
    thread scripts\mp\supers::givesuperweapon(var3);
  }

  var4 = self.loadoutgesture;

  if(isDefined(var4)) {
    scripts\cp_mp\gestures::cleargesture();
    scripts\cp_mp\gestures::givegesture(var4);
  }

  var5 = "primary";
  var6 = scripts\mp\equipment::getcurrentequipment(var5);

  if(isDefined(var6)) {
    scripts\mp\equipment::giveequipment(var6, var5);
  }

  var5 = "secondary";
  var6 = scripts\mp\equipment::getcurrentequipment(var5);

  if(isDefined(var6)) {
    scripts\mp\equipment::giveequipment(var6, var5);
  }

  foreach(var1 in self.restoreweaponlist) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var1)) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var1);
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
  var0 = "iw8_hvtcarry_mp";

  if(scripts\common\utility::iscp()) {
    var0 = "iw8_hvtcarry_cp";
  }

  scripts\mp\utility\player::_setsuit(var0);
  scripts\mp\utility\perk::giveperk("specialty_sprintfire");
  self.overrideweaponspeed_speedscale = 0.75;
  scripts\mp\weapons::updatemovespeedscale();
  var1 = "iw8_pi_golf21_mp";
  var2 = scripts\mp\utility\weapon::getweaponrootname(var1);
  var3 = [];
  GscBinSkip0(0x2e, var3.size, "mod_hvt");
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

function removecarrydebuff(var0) {
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

  if(var0) {
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

function laststandlistener(var0) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
}

function watchhostagedrop(var0, var1, var2) {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  self endon("death");
  self.carried = 1;
  var3 = 0;
  self.carrier = var0;
  var4 = level.framedurationseconds;

  while(self.carried) {
    if(!var0 useButtonPressed()) {
      var3 = 1;
    }

    var5 = 0;

    while(var3 && var0 useButtonPressed()) {
      var5 += var4;

      if(var5 > 0.3) {
        var2 unlink();
        var2 disableplayeruse(var0);
        var2 makeunusable();
        var6 = var0.origin + anglesToForward(var0.angles) * 72 + (0, 0, 24);
        drophostage(var0, var1, var6, undefined, 1.4);
        return;
      }

      wait var5;
    }

    waitframe();
  }
}

function obfuscateobjectiveposition() {
  self endon("death");
  var0 = 512;
  var1 = var0 / 2;

  for(;;) {
    var2 = randomfloatrange(var1 / 3, var1);

    if(randomint(2) == 0) {
      var2 *= -1;
    }

    var3 = randomfloatrange(var1 / 3, var1);

    if(randomint(2) == 0) {
      var3 *= -1;
    }

    var4 = (var2, var3, 0);
    scripts\mp\objidpoolmanager::update_objective_position(self.curobjid, self.origin + (var2, var3, 0));
    wait randomfloatrange(8, 13);
  }
}

function createobjective(var0) {
  var1 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var1 == -1) {
    return -1;
  }

  scripts\mp\objidpoolmanager::objective_add_objective(var1, "invisible", (0, 0, 0), var0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var1, self);
  scripts\mp\objidpoolmanager::update_objective_state(var1, "active");
  scripts\mp\objidpoolmanager::update_objective_icon(var1, var0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var1);

  if(isDefined(level.objvisall)) {
    [[level.objvisall]](var1);
  }

  return var1;
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
  var0 = spawn("trigger_radius", level.hostages[0].origin, 0, 120, 128);
  var0 waittill("trigger", var1);

  foreach(var3 in scripts\mp\utility\teams::getteamdata("allies", "players")) {
    if(distancesquared(var3.origin, var0.origin) < 250000) {
      var3 queuedialogforplayer("dx_mpp_usp1_hostage_located", "cop_hostage_located", 2);
    }
  }

  var0 delete();
}