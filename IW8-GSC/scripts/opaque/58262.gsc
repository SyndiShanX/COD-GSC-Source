/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58262.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("circle_peek", &ref_13e25, undefined, &ref_13e0d);
  var0 = "circle_peak";
  game["dialog"]["use_circle_peek"] = var0 + "_use";
  game["dialog"]["timeout_circle_peek"] = var0 + "_timeout";
}

function weapongivenchoppergunner(var0) {
  return true;
}

function ref_13e24() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("circle_peek", self);
  return ref_13e25(var0);
}

function ref_13e0d() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("circle_peek", self);
  var0.ref_133ce = 1;
  return ref_13e25(var0, 1);
}

function ref_13e25(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return 0;
    }
  }

  if(!istrue(var1)) {
    var2 = getcompleteweaponname("ks_gesture_generic_mp");
    var3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var0, var2);

    if(!istrue(var3)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return 0;
    }
  }

  var4 = gulag_intro_vo(var0);

  if(!istrue(var4)) {
    return var4;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var0.streakname, self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + var0.streakname, self);
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var0.streakname, 1);

  if(istrue(var1)) {
    scripts\mp\utility\dialog::playkillstreakusedialog(var0.streakname);
  }

  return 1;
}

function gulag_intro_vo(var0) {
  if(!isDefined(level.ref_13aca)) {
    return false;
  }

  if(!isDefined(level.br_circle.circleindex)) {
    return false;
  }

  if(!isDefined(level.ref_13aca[self.team])) {
    level.ref_13aca[self.team] = 0;
  }

  var1 = level.ref_13aca[self.team] + level.br_circle.circleindex + 1;

  for(var2 = var1; var2 < level.gulag_tutorial_vo.size; var2++) {
    scripts\mp\gametypes\br_quest_util::ref_12972(self.team);
  }

  return true;
}