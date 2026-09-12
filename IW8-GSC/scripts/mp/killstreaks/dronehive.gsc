/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\dronehive.gsc
************************************************/

function init() {
  level.dronemissilespawnarray = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var_1 in level.dronemissilespawnarray) {
    var_1.targetent = getEnt(var_1.target, "targetname");
  }
}

function weapongivendronehive(var_0) {
  return true;
}

function tryusedronehive(var_0) {
  return usedronehive(self, var_0.lifeid, var_0);
}

function usedronehive(var_0, var_1, var_2) {
  if(isDefined(self.underwater) && self.underwater) {
    return false;
  }

  var_3 = var_0 scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_2);

  if(!var_3) {
    return false;
  }

  var_0 scripts\common\utility::allow_weapon_switch(0);
  thread monitordisownkillstreaks(level);
  thread monitorgameend(level);
  thread monitorobjectivecamera(level);
  thread rundronehive(level, var_0, var_1, var_2.streakname);
  return true;
}

function watchhostmigrationstartedinit(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self)) {
      var_0 thermalvisionon();
      continue;
    }

    var_0 setclientomnvar("ui_predator_missile", 2);
  }
}

function watchhostmigrationfinishedinit(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(isDefined(self)) {
      var_0 setclientomnvar("ui_predator_missile", 1);
      var_0 setclientomnvar("ui_predator_missiles_left", self.missilesleft);
      continue;
    }

    var_0 setclientomnvar("ui_predator_missile", 2);
  }
}

function watchclosetogoal(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);

  while(isDefined(self)) {
    var_2 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), level.characters, var_1);

    if(isDefined(var_2["position"]) && distancesquared(self.origin, var_2["position"]) < 5000) {
      break;
    }

    waitframe();
  }

  self.streakinfo notify("killstreak_finished_with_deploy_weapon");
}

function rundronehive(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_4 = "used_drone_hive";
  var_5 = "drone_hive_projectile_mp";
  var_6 = "switch_blade_child_mp";
  level thread scripts\mp\hud_util::teamplayercardsplash(var_4, var_0);
  var_0 notifyonplayercommand("missileTargetSet", "+attack");
  var_0 notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  var_7 = getbestmissilespawnpoint(var_0, level.dronemissilespawnarray);
  var_8 = var_7.origin * (1, 1, 0) + (0, 0, level.mapcenter[2] + 10000);
  var_9 = var_7.targetent.origin;
  var_10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var_5), var_8, var_9, var_0);
  var_10 setCanDamage(1);
  var_10 disablemissileboosting();
  var_10 setmissileminimapvisible(1);
  var_10.team = var_0.team;
  var_10.lifeid = var_1;
  var_10.type = "remote";
  var_10.owner = var_0;
  var_10.entitynumber = var_10 getentitynumber();
  var_10.streakinfo = var_3;
  var_10.weapon_name = "drone_hive_projectile_mp";
  level.rockets[var_10.entitynumber] = var_10;
  level.remotemissileinprogress = 1;
  thread monitordeath(level, var_10);
  thread monitorboost(level);
  missileeyes(var_0, var_10);
  var_0 setclientomnvar("ui_predator_missile", 1);
  thread watchhostmigrationstartedinit(var_10);
  thread watchhostmigrationfinishedinit(var_10);
  var_10 thread scripts\mp\utility\killstreak::watchsupertrophynotify(var_0);
  var_0 scripts\common\utility::ref_13E0A(level.ref_11B2A, var_2, var_10.origin);
  var_11 = 0;
  var_10.missilesleft = 2;
  var_12 = 2;
  var_0 setclientomnvar("ui_predator_missiles_left", var_10.missilesleft);

  for(;;) {
    var_13 = var_10 scripts\engine\utility::ref_143AD("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(istrue(var_10.unlimitedammo)) {
      jumpiffalse(istrue(var_10.lasttimefired)) LOC_00000204;
      thread firerapidmissiles(level, var_10, var_11, var_3);
      var_11++;
      var_10.lasttimefired = gettime();
      var_10.missilesleft = 2 - var_11;
      var_14 = var_10.missilesleft;

      if(var_10.missilesleft == 0) {
        var_14 = -1;
      }

      var_0 setclientomnvar("ui_predator_missiles_left", var_14);

      if(var_11 == 2) {
        var_11 = 0;
        var_10.missilesleft = 2;
        thread resetmissiles(var_0, var_10);
      }

      continue;
    }

    if(var_11 < 2) {
      if(!istrue(var_10.singlefire)) {
        thread spawnswitchblade(level, var_10, var_11, var_3);
        var_11++;
        var_10.missilesleft = 2 - var_11;
        var_0 setclientomnvar("ui_predator_missiles_left", var_10.missilesleft);

        if(var_11 == 2) {
          var_10 enablemissileboosting();
          LOC_000002c2:
        }
        LOC_000002c2:
      }
      LOC_000002c2:
    }
    LOC_000002c2:
  }

  LOC_000002c5:
    thread returnplayer(level);
  scripts\mp\utility\print::printgameaction("killstreak ended - drone_hive", var_0);
}

function firerapidmissiles(var_0, var_1, var_2, var_3) {
  var_4 = var_1;

  for(var_5 = 0; var_5 < 2; var_5++) {
    thread spawnswitchblade(level, var_0, var_4, var_2);
    var_4++;

    if(var_4 > 1) {
      var_4 = 0;
    }

    wait 0.1;
  }
}

function resetmissiles(var_0, var_1) {
  var_0 endon("death");
  self endon("disconnect");
  wait var_1;
  self setclientomnvar("ui_predator_missiles_left", var_0.missilesleft);
}

function monitorlockedtarget() {
  level endon("game_ended");
  self endon("death");
  var_0 = [];
  var_1 = [];

  for(;;) {
    var_2 = [];
    var_0 = scripts\mp\utility\killstreak::getenemytargets();

    foreach(var_4 in var_0) {
      var_5 = self.owner worldpointinreticle_circle(var_4.origin, 65, 90);

      if(var_5) {
        self.owner thread scripts\mp\utility\debug::drawline(self.origin, var_4.origin, 10, (0, 0, 1));
        var_2 = var_4;
      }
    }

    if(var_2.size) {
      [self.lasttargetlocked] = sortbydistance(var_2, self.origin);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function spawnswitchblade(var_0, var_1, var_2, var_3) {
  var_0.owner playlocalsound("ammo_crate_use");
  var_4 = var_0 gettagangles("tag_origin");
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = (100, 100, 100);
  var_8 = (15000, 15000, 15000);

  if(var_1) {
    var_7 *= -1;
  }

  var_9 = scripts\engine\trace::_bullet_trace(var_0.origin, var_0.origin + var_5 * var_8, 0, var_0);
  var_8 *= var_9["fraction"];
  var_10 = var_0.origin + var_6 * var_7;
  var_11 = var_0.origin + var_5 * var_8;
  var_12 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var_3), var_10, var_11, var_0.owner);
  var_13 = getclosesttargetinview(var_0, var_0.owner, var_11);

  if(isDefined(var_13)) {
    var_12 missile_settargetEnt(var_13);
  }

  var_12 setCanDamage(1);
  var_12 setmissileminimapvisible(1);
  var_12.team = var_0.team;
  var_12.lifeid = var_0.lifeid;
  var_12.type = var_0.type;
  var_12.owner = var_0.owner;
  var_12.entitynumber = var_12 getentitynumber();
  var_12.streakinfo = var_2;
  var_12.weapon_name = "switch_blade_child_mp";
  level.rockets[var_12.entitynumber] = var_12;
  thread monitordeath(level, var_12);
}

function getclosesttargetinview(var_0, var_1) {
  var_2 = scripts\mp\utility\killstreak::getenemytargets(var_0);
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_6)) {
      continue;
    }

    if(istrue(var_6.trinityrocketlocked)) {
      continue;
    }

    var_7 = distance2dsquared(var_6.origin, var_1);

    if(var_7 < 262144 && istrue(canseetarget(var_6))) {
      if(!isDefined(var_4) || var_7 < var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_3)) {
    var_3.trinityrocketlocked = 1;
    thread watchtarget();
  }

  return var_3;
}

function canseetarget(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_3 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }

    var_1 = 1;
    break;
  }

  return var_1;
}

function watchtarget() {
  self endon("disconnect");
  self waittill("death");
  self.trinityrocketlocked = undefined;
}

function looptriggeredeffect(var_0, var_1) {
  var_1 endon("death");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    triggerfx(var_0);
    wait 0.25;
  }
}

function getnextmissilespawnindex(var_0) {
  var_1 = var_0 + 1;

  if(var_1 == level.dronemissilespawnarray.size) {
    var_1 = 0;
  }

  return var_1;
}

function monitorboost(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0.owner waittill("missileTargetSet");
    var_0 notify("missileTargetSet");
  }
}

function getbestmissilespawnpoint(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      continue;
    }

    if(var_4.team == var_0.team) {
      continue;
    }

    if(var_4.team == "spectator") {
      continue;
    }

    var_2 = var_4;
  }

  if(!var_2.size) {
    return var_1[randomint(var_1.size)];
  }

  [var_7] = scripts\engine\utility::array_randomize(var_1);

  foreach(var_9 in var_6) {
    var_9.sightedenemies = 0;

    for(var_10 = 0; var_10 < var_2.size; var_10++) {
      var_11 = var_2[var_10];

      if(!scripts\mp\utility\player::isreallyalive(var_11)) {
        var_2 = var_2[var_2.size - 1];
        var_2[var_2.size - 1] = undefined;
        var_10--;
        continue;
      }

      if(scripts\engine\trace::_bullet_trace_passed(var_11.origin + (0, 0, 32), var_9.origin, 0, var_11)) {
        var_9.sightedenemies += 1;
        return var_9;
      }

      wait 0.05;
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    if(var_9.sightedenemies == var_2.size) {
      return var_9;
    }

    if(var_9.sightedenemies > var_7.sightedenemies) {
      var_7 = var_9;
    }
  }

  return var_7;
}

function missileeyes(var_0, var_1) {
  var_2 = 0.5;
  var_0 scripts\mp\utility\player::_freezecontrols(1);
  var_0 cameralinkTo(var_1, "tag_origin");
  var_0 controlslinkTo(var_1);
  var_0 thermalvisionon();
  var_0 setclientomnvar("ui_killstreak_health", 1);
  var_0 setclientomnvar("ui_killstreak_countdown", gettime() + int(15000));
  thread unfreezecontrols(level, var_0);
}

function unfreezecontrols(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1 - 0.35);
  var_0 scripts\mp\utility\player::_freezecontrols(0);
}

function monitordisownkillstreaks(var_0) {
  var_0 endon("disconnect");
  var_0 endon("end_kill_streak");
  GscBinSkip4(0x6e, var_0, "joined_team");
}

function monitorownerstatus(var_0) {
  self waittill(var_0);
  thread returnplayer(level);
}

function monitorgameend(var_0) {
  var_0 endon("disconnect");
  var_0 endon("end_kill_streak");
  level waittill("game_ended");
  var_1 = 1;
  thread returnplayer(level, var_0, 0);
}

function monitorobjectivecamera(var_0) {
  var_0 endon("end_kill_streak");
  var_0 endon("disconnect");
  level waittill("objective_cam");
  thread returnplayer(level, var_0);
}

function monitordeath(var_0, var_1) {
  var_0 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(var_0.targeffect)) {
    var_0.targeffect delete();
  }

  if(isDefined(var_0.entitynumber)) {
    level.rockets[var_0.entitynumber] = undefined;
  }

  if(var_1) {
    level.remotemissileinprogress = undefined;
    return;
  }
}

function returnplayer(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!istrue(var_2)) {
    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  var_0 setclientomnvar("ui_predator_missile", 2);
  var_0 notify("end_kill_streak");
  var_0 thermalvisionoff();
  var_0 controlsunlink();
  var_0 cameraunlink();
  var_0 setclientomnvar("ui_predator_missile", 0);
  var_0 scripts\common\utility::allow_weapon_switch(1);
}

function watchgastrigger(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }

    if(level.teambased && var_2.team == var_0.team && var_2 != var_0) {
      continue;
    }

    if(istrue(var_2.gettinggassed)) {
      continue;
    }

    thread applygasdamageovertime(var_0, var_1, var_2);
  }
}

function applygasdamageovertime(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  var_2.gettinggassed = 1;

  while(var_2 istouching(self)) {
    var_2 dodamage(20, self.origin, var_0, self, "MOD_EXPLOSIVE", var_1);
    var_3 = scripts\engine\utility::ref_143B9(0.5, "death");

    if(var_3 == "death") {
      break;
    }
  }

  if(istrue(var_2.gettinggassed)) {
    var_2.gettinggassed = undefined;
    return;
  }
}