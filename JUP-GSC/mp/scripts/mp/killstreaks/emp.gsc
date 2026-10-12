/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\emp.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace emp;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("emp", &tryuseempfromstruct);
}

function tryuseemp() {
  streakinfo = createstreakinfo("emp", self);
  return tryuseempfromstruct(streakinfo);
}

function tryuseempfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_generic_mp"));

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  thread startemp();
  level callback::callback("killstreak_finish_use", {
    #streakinfo: self.streakinfo
  });
  return true;
}

function startemp() {
  level endon("game_ended");
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = 3000;

  if(isDefined(heightent)) {
    heightoffset = heightent.origin[2] + 500;
  }

  fxspawnpos = level.mapcenter * (1, 1, 0) + (0, 0, heightoffset);
  playFX(getfx("emp_shockwave"), fxspawnpos);
  self playSound("jammer_drone_shockwave");

  foreach(player in level.players) {
    if(!isreallyalive(player)) {
      continue;
    }

    player thread applyempshellshock();
  }

  enemyteams = getenemyteams(self.owner.team);

  foreach(entry in enemyteams) {
    destroyactiveobjects(entry, self);
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

function destroyactiveobjects(team, owner) {
  weapon = "nuke_mp";
  var_6c845d64be969ce8 = level.activekillstreaks;
  equipmentarray = [[level.getactiveequipmentarray]]();
  activeobjects = undefined;

  if(isDefined(var_6c845d64be969ce8) && isDefined(equipmentarray)) {
    activeobjects = array_combine_unique(var_6c845d64be969ce8, equipmentarray);
  } else if(isDefined(var_6c845d64be969ce8)) {
    activeobjects = var_6c845d64be969ce8;
  } else if(isDefined(equipmentarray)) {
    activeobjects = equipmentarray;
  }

  if(isDefined(activeobjects)) {
    foreach(object in activeobjects) {
      if(isDefined(object)) {
        object dodamagetokillstreak(10000, owner, owner, team, object.origin, "MOD_EXPLOSIVE", weapon);
      }
    }
  }
}