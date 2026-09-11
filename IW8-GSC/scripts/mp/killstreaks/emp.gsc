/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\emp.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("emp", &tryuseempfromstruct);
}

function tryuseemp() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp", self);
  return tryuseempfromstruct(var_0);
}

function tryuseempfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, getcompleteweaponname("ks_gesture_generic_mp"));

  if(!istrue(var_1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  thread startemp();

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  return true;
}

function startemp() {
  level endon("game_ended");
  var_0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_1 = 3000;

  if(isDefined(var_0)) {
    var_1 = var_0.origin[2] + 500;
  }

  var_2 = level.mapcenter * (1, 1, 0) + (0, 0, var_1);
  playFX(scripts\engine\utility::getfx("emp_shockwave"), var_2);
  self playSound("jammer_drone_shockwave");

  foreach(var_4 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      continue;
    }

    thread applyempshellshock();
  }

  var_6 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

  foreach(var_8 in var_6) {
    destroyactiveobjects(var_8, self);
  }
}

function applyempshellshock() {
  self setscriptablepartstate("emped", "active", 0);
  self playLoopSound("emp_nade_lp");
  thread applyempshellshockvisionset();
  wait 0.5;
  self setscriptablepartstate("emped", "neutral", 0);
  self playSound("emp_nade_lp_end");
  self stoploopsound("emp_nade_lp");
}

function applyempshellshockvisionset() {
  visionsetnaked("coup_sunblind", 0.05);
  waitframe();
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 0.5);
}

function destroyactiveobjects(var_0, var_1) {
  var_2 = "nuke_mp";
  var_3 = level.activekillstreaks;
  var_4 = [[level.getactiveequipmentarray]]();
  var_5 = undefined;

  if(isDefined(var_3) && isDefined(var_4)) {
    var_5 = scripts\engine\utility::array_combine_unique(var_3, var_4);
  } else if(isDefined(var_3)) {
    var_5 = var_3;
  } else if(isDefined(var_4)) {
    var_5 = var_4;
  }

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        var_7 scripts\mp\utility\killstreak::dodamagetokillstreak(10000, var_1, var_1, var_0, var_7.origin, "MOD_EXPLOSIVE", var_2);
      }
    }

    return;
  }
}