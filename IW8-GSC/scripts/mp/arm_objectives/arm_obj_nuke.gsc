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

function debugprint(var0) {
  if(true) {
    return;
  }
}

function initnukeobjectivelocations() {
  var0 = scripts\engine\utility::getStructArray("computer_location", "targetname");
  var1 = var0[randomint(var0.size)];
  level.objective_nuke = createuseableobject(var1, var1.origin, var1.angles, "intel_laptop", &"MP_ESCAPE_MODE/PULL_WMD_DATA_CORE", "objectUsed");
  level.objective_nuke.curorigin = level.objective_nuke.origin;
  level.objective_nuke.offset3d = (0, 0, 30);

  if(!isDefined(level.objective_nuke.objidnum) || level.objective_nuke.objidnum < 0) {
    level.objective_nuke scripts\mp\gameobjects::requestid(1, 1);
    setupobjectobjective(level.objective_nuke, "MP_ESCAPE_MODE/WMD");
    return;
  }
}

function setupobjectobjective(var0, var1) {
  var2 = var0.objidnum;
  objective_state(var2, "invisible");
  objective_setlabel(var2, var1);
  objective_setzoffset(var2, 30);
  objective_icon(var2, "icon_waypoint_marker");
  objective_setplayintro(var2, 0);
  objective_sethot(var2, 1);
  objective_showtoplayersinmask(var2);
  objective_setbackground(var2, 1);
  objective_position(var2, var0.origin + (0, 0, 50));
  objective_state(var2, "current");
}

function watchobjuse(var0) {
  level endon("game_ended");
  var0 endon("death_or_disconnect");

  for(;;) {
    var0 waittill("objectUsed", var1);
    nukeused(var0, var1);
  }
}

function shownukelocation(var0) {
  if(!isDefined(level.objective_nuke)) {
    return;
  }

  thread scripts\mp\gametypes\arm::playnukeintrovo(var0);

  foreach(var2 in scripts\mp\utility\player::getteamarray(var0.team)) {
    objective_addclienttomask(level.objective_nuke.objidnum, var2);
  }

  if(!istrue(level.nukespotted)) {
    level.nukespoted = 1;

    foreach(var5 in level.players) {
      if(var5.team != var0.team) {}
    }

    return;
  }
}

function hidenukefromeveryone() {
  foreach(var1 in level.players) {
    objective_removeclientfrommask(level.objective_nuke.objidnum, var1);
  }
}

function hidenukefromplayer(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(level.objective_nuke)) {
    return;
  }

  objective_removeclientfrommask(level.objective_nuke.objidnum, var0);
  thread watchobjuse(var0);
}

function nukeused(var0, var1) {
  setgameendtime(0);
  level.scorelimitoverride = 1;
  wait 3;
  var2 = 10 - level.players.size;

  for(var3 = 0; var3 < var2; var3++) {
    var4 = vectorNormalize(var0 getEye() - var1.origin);
    var5 = var1.origin + (randomfloat(1024), randomfloat(1024), 0);
    playFX(level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"], var5, var4);
    earthquake(0.245, 2.2, var5, 50000);
    playrumbleonposition("damage_heavy", var5);
    wait 0.5 + randomfloat(0.5);
  }

  foreach(var7 in level.players) {
    if(var7.team == var0.team) {
      continue;
    }

    var4 = vectorNormalize(var7 getEye() - var0.origin);
    playFX(level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"], var7.origin, var4);
    earthquake(0.245, 2.2, var7.origin, 50000);
    playrumbleonposition("damage_heavy", var7.origin);
    wait 0.5 + randomfloat(0.5);
    var7 kill();
  }

  thread playnukeusedvo(var0);
  wait 5;
  level.finalkillcam_winner = var0.team;
  thread scripts\mp\gamelogic::endgame(var0.team, game["end_reason"]["target_destroyed"], undefined, 1, 0);
}

function createuseableobject(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  var5 = spawn("script_model", var0);
  var5 setnodeploy(1);
  var5.targetname = "useableObject";
  var5 setModel(var2);
  var5.angles = var1;
  var5.useobj = scripts\mp\gameobjects::createhintobject(var5.origin + anglestoup(var5.angles) * 7, "HINT_BUTTON", undefined, var3, -3, undefined, "show", 250, 160, 200, 160);
  var5.useobj linkTo(var5);
  var5.useobj.waitmsg = var4;

  foreach(var7 in level.players) {
    var5.useobj disableplayeruse(var7);
  }

  thread usethink();
  return var5;
}

function usethink() {
  self endon("restarting_physics");
  var0 = self.useobj;
  var1 = undefined;
  jumpiffalse(istrue(level.gameended) && !isDefined(var0)) LOC_00000022;
  return;
}

function useholdthink(var0, var1) {
  scripts\mp\movers::script_mover_link_to_use_object(var0);
  var0 scripts\common\utility::allow_weapon(0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = var1;
  var2 = useholdthinkloop(var0);

  if(isalive(var0)) {
    var0 scripts\common\utility::allow_weapon(1);
  }

  if(isDefined(var0)) {
    scripts\mp\movers::script_mover_unlink_from_use_object(var0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;
  return var2;
}

function useholdthinkloop(var0) {
  while(isplayerusing(var0, self)) {
    if(!var0 scripts\mp\movers::script_mover_use_can_link(self)) {
      var0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return 0;
    }

    self.curprogress += level.framedurationseconds * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    var0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      var0 scripts\mp\gameobjects::updateuiprogress(self, 0);
      return scripts\mp\utility\player::isreallyalive(var0);
    }

    waitframe();
  }

  if(isDefined(self)) {
    var0 scripts\mp\gameobjects::updateuiprogress(self, 0);
  }

  return 0;
}

function createuseent() {
  var0 = spawn("script_origin", self.origin);
  var0.curprogress = 0;
  var0.usetime = 0;
  var0.userate = 3000;
  var0.inuse = 0;
  var0.id = self.id;
  var0 linkTo(self);
  thread deleteuseent(var0);
  return var0;
}

function deleteuseent(var0) {
  self endon("death");
  var0 waittill("death");

  if(isDefined(self.usedby)) {
    foreach(var2 in self.usedby) {
      var2 setclientomnvar("ui_securing", 0);
      var2.ui_securing = undefined;
    }
  }

  self delete();
}

function isplayerusing(var0) {
  return !level.gameended && isDefined(var0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var0.curprogress < var0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function playnukeusedvo(var0) {
  scripts\mp\gametypes\arm::playplayerbattlechatter(var0, "extract_littlebird_start_a_friendly", 10);
  scripts\mp\gametypes\arm::playannouncerbattlechatter(var0, "extract_littlebird_start_a_friendly", 20);
}