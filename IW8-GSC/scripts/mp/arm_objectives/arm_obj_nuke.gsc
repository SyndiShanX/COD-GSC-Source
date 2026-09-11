/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\arm_objectives\arm_obj_nuke.gsc
******************************************************/

function init() {}

function objectivesetup() {
  debugprint("Use Objective: Setup");
  level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"] = loadfx("vfx/iw8/level/highway/vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx");
  initnukeobjectivelocations();
}

function debugprint(var_0) {
  if(true) {
    return;
  }
}

function initnukeobjectivelocations() {
  var_0 = scripts\engine\utility::getStructArray("computer_location", "targetname");
  var_1 = var_0[randomint(var_0.size)];
  level.objective_nuke = createuseableobject(var_1, var_1.origin, var_1.angles, "intel_laptop", &"MP_ESCAPE_MODE/PULL_WMD_DATA_CORE", "objectUsed");
  level.objective_nuke.curorigin = level.objective_nuke.origin;
  level.objective_nuke.offset3d = (0, 0, 30);

  if(!isDefined(level.objective_nuke.objidnum) || level.objective_nuke.objidnum < 0) {
    level.objective_nuke scripts\mp\gameobjects::requestid(1, 1);
    setupobjectobjective(level.objective_nuke, "MP_ESCAPE_MODE/WMD");
    return;
  }
}

function setupobjectobjective(var_0, var_1) {
  var_2 = var_0.objidnum;
  objective_state(var_2, "invisible");
  objective_setlabel(var_2, var_1);
  objective_setzoffset(var_2, 30);
  objective_icon(var_2, "icon_waypoint_marker");
  objective_setplayintro(var_2, 0);
  objective_sethot(var_2, 1);
  objective_showtoplayersinmask(var_2);
  objective_setbackground(var_2, 1);
  objective_position(var_2, var_0.origin + (0, 0, 50));
  objective_state(var_2, "current");
}

function watchobjuse(var_0) {
  level endon("game_ended");
  var_0 endon("death_or_disconnect");

  for(;;) {
    var_0 waittill("objectUsed", var_1);
    nukeused(var_0, var_1);
  }
}

function shownukelocation(var_0) {
  if(!isDefined(level.objective_nuke)) {
    return;
  }

  thread scripts\mp\gametypes\arm::playnukeintrovo(var_0);

  foreach(var_2 in scripts\mp\utility\player::getteamarray(var_0.team)) {
    objective_addclienttomask(level.objective_nuke.objidnum, var_2);
  }

  if(!istrue(level.nukespotted)) {
    level.nukespoted = 1;

    foreach(var_5 in level.players) {
      if(var_5.team != var_0.team) {}
    }

    return;
  }
}

function hidenukefromeveryone() {
  foreach(var_1 in level.players) {
    objective_removeclientfrommask(level.objective_nuke.objidnum, var_1);
  }
}

function hidenukefromplayer(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(level.objective_nuke)) {
    return;
  }

  objective_removeclientfrommask(level.objective_nuke.objidnum, var_0);
  thread watchobjuse(var_0);
}

function nukeused(var_0, var_1) {
  setgameendtime(0);
  level.scorelimitoverride = 1;
  wait 3;
  var_2 = 10 - level.players.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = vectorNormalize(var_0 getEye() - var_1.origin);
    var_5 = var_1.origin + (randomfloat(1024), randomfloat(1024), 0);
    playFX(level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"], var_5, var_4);
    earthquake(0.245, 2.2, var_5, 50000);
    playrumbleonposition("damage_heavy", var_5);
    wait 0.5 + randomfloat(0.5);
  }

  foreach(var_7 in level.players) {
    if(var_7.team == var_0.team) {
      continue;
    }

    var_4 = vectorNormalize(var_7 getEye() - var_0.origin);
    playFX(level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"], var_7.origin, var_4);
    earthquake(0.245, 2.2, var_7.origin, 50000);
    playrumbleonposition("damage_heavy", var_7.origin);
    wait 0.5 + randomfloat(0.5);
    var_7 kill();
  }

  thread playnukeusedvo(var_0);
  wait 5;
  level.finalkillcam_winner = var_0.team;
  thread scripts\mp\gamelogic::endgame(var_0.team, game["end_reason"]["target_destroyed"], undefined, 1, 0);
}

function createuseableobject(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = spawn("script_model", var_0);
  var_5 setnodeploy(1);
  var_5.targetname = "useableObject";
  var_5 setModel(var_2);
  var_5.angles = var_1;
  var_5.useobj = scripts\mp\gameobjects::createhintobject(var_5.origin + anglestoup(var_5.angles) * 7, "HINT_BUTTON", undefined, var_3, -3, undefined, "show", 250, 160, 200, 160);
  var_5.useobj linkTo(var_5);
  var_5.useobj.waitmsg = var_4;

  foreach(var_7 in level.players) {
    var_5.useobj disableplayeruse(var_7);
  }

  thread usethink();
  return var_5;
}

function usethink() {
  self endon("restarting_physics");
  var_0 = self.useobj;
  var_1 = undefined;
  jumpiffalse(istrue(level.gameended) && !isDefined(var_0)) LOC_00000022;
  return;
}

function useholdthink(var_0, var_1) {
  scripts\mp\movers::script_mover_link_to_use_object(var_0);
  var_0 scripts\common\utility::allow_weapon(0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = var_1;
  var_2 = useholdthinkloop(var_0);

  if(isalive(var_0)) {
    var_0 scripts\common\utility::allow_weapon(1);
  }

  if(isDefined(var_0)) {
    scripts\mp\movers::script_mover_unlink_from_use_object(var_0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;
  return var_2;
}

function useholdthinkloop(var_0) {
  while(isplayerusing(var_0, self)) {
    if(!var_0 scripts\mp\movers::script_mover_use_can_link(self)) {
      var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return 0;
    }

    self.curprogress += level.framedurationseconds * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    waitframe();
  }

  if(isDefined(self)) {
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
  }

  return 0;
}

function createuseent() {
  var_0 = spawn("script_origin", self.origin);
  var_0.curprogress = 0;
  var_0.usetime = 0;
  var_0.userate = 3000;
  var_0.inuse = 0;
  var_0.id = self.id;
  var_0 linkTo(self);
  thread deleteuseent(var_0);
  return var_0;
}

function deleteuseent(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self.usedby)) {
    foreach(var_2 in self.usedby) {
      var_2 setclientomnvar("ui_securing", 0);
      var_2.ui_securing = undefined;
    }
  }

  self delete();
}

function isplayerusing(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function playnukeusedvo(var_0) {
  scripts\mp\gametypes\arm::playplayerbattlechatter(var_0, "extract_littlebird_start_a_friendly", 10);
  scripts\mp\gametypes\arm::playannouncerbattlechatter(var_0, "extract_littlebird_start_a_friendly", 20);
}