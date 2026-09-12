/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58262.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("circle_peek", &ref_13E25, undefined, &ref_13E0D);
  var_0 = "circle_peak";
  game["dialog"]["use_circle_peek"] = var_0 + "_use";
  game["dialog"]["timeout_circle_peek"] = var_0 + "_timeout";
}

function weapongivenchoppergunner(var_0) {
  return true;
}

function ref_13E24() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("circle_peek", self);
  return ref_13E25(var_0);
}

function ref_13E0D() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("circle_peek", self);
  var_0.ref_133CE = 1;
  return ref_13E25(var_0, 1);
}

function ref_13E25(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return 0;
    }
  }

  if(!istrue(var_1)) {
    var_2 = getcompleteweaponname("ks_gesture_generic_mp");
    var_3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, var_2);

    if(!istrue(var_3)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return 0;
    }
  }

  var_4 = gulag_intro_vo(var_0);

  if(!istrue(var_4)) {
    return var_4;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + var_0.streakname, self);
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_0.streakname, 1);

  if(istrue(var_1)) {
    scripts\mp\utility\dialog::playkillstreakusedialog(var_0.streakname);
  }

  return 1;
}

function gulag_intro_vo(var_0) {
  if(!isDefined(level.ref_13ACA)) {
    return false;
  }

  if(!isDefined(level.br_circle.circleindex)) {
    return false;
  }

  if(!isDefined(level.ref_13ACA[self.team])) {
    level.ref_13ACA[self.team] = 0;
  }

  var_1 = level.ref_13ACA[self.team] + level.br_circle.circleindex + 1;

  for(var_2 = var_1; var_2 < level.gulag_tutorial_vo.size; var_2++) {
    scripts\mp\gametypes\br_quest_util::ref_12972(self.team);
  }

  return true;
}