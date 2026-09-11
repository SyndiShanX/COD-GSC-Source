/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\emp.gsc
***********************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("emp", &tryuseempfromstruct);
}

function tryuseemp() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp", self);
  return tryuseempfromstruct(var0);
}

function tryuseempfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var0, getcompleteweaponname("ks_gesture_generic_mp"));

  if(!istrue(var1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
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
  var0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var1 = 3000;

  if(isDefined(var0)) {
    var1 = var0.origin[2] + 500;
  }

  var2 = level.mapcenter * (1, 1, 0) + (0, 0, var1);
  playFX(scripts\engine\utility::getfx("emp_shockwave"), var2);
  self playSound("jammer_drone_shockwave");

  foreach(var4 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var4)) {
      continue;
    }

    thread applyempshellshock();
  }

  var6 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

  foreach(var8 in var6) {
    destroyactiveobjects(var8, self);
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

function destroyactiveobjects(var0, var1) {
  var2 = "nuke_mp";
  var3 = level.activekillstreaks;
  var4 = [[level.getactiveequipmentarray]]();
  var5 = undefined;

  if(isDefined(var3) && isDefined(var4)) {
    var5 = scripts\engine\utility::array_combine_unique(var3, var4);
  } else if(isDefined(var3)) {
    var5 = var3;
  } else if(isDefined(var4)) {
    var5 = var4;
  }

  if(isDefined(var5)) {
    foreach(var7 in var5) {
      if(isDefined(var7)) {
        var7 scripts\mp\utility\killstreak::dodamagetokillstreak(10000, var1, var1, var0, var7.origin, "MOD_EXPLOSIVE", var2);
      }
    }

    return;
  }
}