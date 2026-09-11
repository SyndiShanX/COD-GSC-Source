/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\dronehive.gsc
************************************************/

function init() {
  level.dronemissilespawnarray = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var1 in level.dronemissilespawnarray) {
    var1.targetent = getEnt(var1.target, "targetname");
  }
}

function weapongivendronehive(var0) {
  return true;
}

function tryusedronehive(var0) {
  return usedronehive(self, var0.lifeid, var0);
}

function usedronehive(var0, var1, var2) {
  if(isDefined(self.underwater) && self.underwater) {
    return false;
  }

  var3 = var0 scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var2);

  if(!var3) {
    return false;
  }

  var0 scripts\common\utility::allow_weapon_switch(0);
  thread monitordisownkillstreaks(level);
  thread monitorgameend(level);
  thread monitorobjectivecamera(level);
  thread rundronehive(level, var0, var1, var2.streakname);
  return true;
}

function watchhostmigrationstartedinit(var0) {
  var0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self)) {
      var0 thermalvisionon();
      continue;
    }

    var0 setclientomnvar("ui_predator_missile", 2);
  }
}

function watchhostmigrationfinishedinit(var0) {
  var0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(isDefined(self)) {
      var0 setclientomnvar("ui_predator_missile", 1);
      var0 setclientomnvar("ui_predator_missiles_left", self.missilesleft);
      continue;
    }

    var0 setclientomnvar("ui_predator_missile", 2);
  }
}

function watchclosetogoal(var0) {
  var0 endon("disconnect");
  level endon("game_ended");
  var1 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);

  while(isDefined(self)) {
    var2 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), level.characters, var1);

    if(isDefined(var2["position"]) && distancesquared(self.origin, var2["position"]) < 5000) {
      break;
    }

    waitframe();
  }

  self.streakinfo notify("killstreak_finished_with_deploy_weapon");
}

function rundronehive(var0, var1, var2, var3) {
  var0 endon("disconnect");
  level endon("game_ended");
  var4 = "used_drone_hive";
  var5 = "drone_hive_projectile_mp";
  var6 = "switch_blade_child_mp";
  level thread scripts\mp\hud_util::teamplayercardsplash(var4, var0);
  var0 notifyonplayercommand("missileTargetSet", "+attack");
  var0 notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  var7 = getbestmissilespawnpoint(var0, level.dronemissilespawnarray);
  var8 = var7.origin * (1, 1, 0) + (0, 0, level.mapcenter[2] + 10000);
  var9 = var7.targetent.origin;
  var10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var5), var8, var9, var0);
  var10 setCanDamage(1);
  var10 disablemissileboosting();
  var10 setmissileminimapvisible(1);
  var10.team = var0.team;
  var10.lifeid = var1;
  var10.type = "remote";
  var10.owner = var0;
  var10.entitynumber = var10 getentitynumber();
  var10.streakinfo = var3;
  var10.weapon_name = "drone_hive_projectile_mp";
  level.rockets[var10.entitynumber] = var10;
  level.remotemissileinprogress = 1;
  thread monitordeath(level, var10);
  thread monitorboost(level);
  missileeyes(var0, var10);
  var0 setclientomnvar("ui_predator_missile", 1);
  thread watchhostmigrationstartedinit(var10);
  thread watchhostmigrationfinishedinit(var10);
  var10 thread scripts\mp\utility\killstreak::watchsupertrophynotify(var0);
  var0 scripts\common\utility::ref_13e0a(level.ref_11b2a, var2, var10.origin);
  var11 = 0;
  var10.missilesleft = 2;
  var12 = 2;
  var0 setclientomnvar("ui_predator_missiles_left", var10.missilesleft);

  for(;;) {
    var13 = var10 scripts\engine\utility::ref_143ad("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(istrue(var10.unlimitedammo)) {
      jumpiffalse(istrue(var10.lasttimefired)) LOC_00000204;
      thread firerapidmissiles(level, var10, var11, var3);
      var11++;
      var10.lasttimefired = gettime();
      var10.missilesleft = 2 - var11;
      var14 = var10.missilesleft;

      if(var10.missilesleft == 0) {
        var14 = -1;
      }

      var0 setclientomnvar("ui_predator_missiles_left", var14);

      if(var11 == 2) {
        var11 = 0;
        var10.missilesleft = 2;
        thread resetmissiles(var0, var10);
      }

      continue;
    }

    if(var11 < 2) {
      if(!istrue(var10.singlefire)) {
        thread spawnswitchblade(level, var10, var11, var3);
        var11++;
        var10.missilesleft = 2 - var11;
        var0 setclientomnvar("ui_predator_missiles_left", var10.missilesleft);

        if(var11 == 2) {
          var10 enablemissileboosting();
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
  scripts\mp\utility\print::printgameaction("killstreak ended - drone_hive", var0);
}

function firerapidmissiles(var0, var1, var2, var3) {
  var4 = var1;

  for(var5 = 0; var5 < 2; var5++) {
    thread spawnswitchblade(level, var0, var4, var2);
    var4++;

    if(var4 > 1) {
      var4 = 0;
    }

    wait 0.1;
  }
}

function resetmissiles(var0, var1) {
  var0 endon("death");
  self endon("disconnect");
  wait var1;
  self setclientomnvar("ui_predator_missiles_left", var0.missilesleft);
}

function monitorlockedtarget() {
  level endon("game_ended");
  self endon("death");
  var0 = [];
  var1 = [];

  for(;;) {
    var2 = [];
    var0 = scripts\mp\utility\killstreak::getenemytargets();

    foreach(var4 in var0) {
      var5 = self.owner worldpointinreticle_circle(var4.origin, 65, 90);

      if(var5) {
        self.owner thread scripts\mp\utility\debug::drawline(self.origin, var4.origin, 10, (0, 0, 1));
        var2 = var4;
      }
    }

    if(var2.size) {
      [self.lasttargetlocked] = sortbydistance(var2, self.origin);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function spawnswitchblade(var0, var1, var2, var3) {
  var0.owner playlocalsound("ammo_crate_use");
  var4 = var0 gettagangles("tag_origin");
  var5 = anglesToForward(var4);
  var6 = anglestoright(var4);
  var7 = (100, 100, 100);
  var8 = (15000, 15000, 15000);

  if(var1) {
    var7 *= -1;
  }

  var9 = scripts\engine\trace::_bullet_trace(var0.origin, var0.origin + var5 * var8, 0, var0);
  var8 *= var9["fraction"];
  var10 = var0.origin + var6 * var7;
  var11 = var0.origin + var5 * var8;
  var12 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var3), var10, var11, var0.owner);
  var13 = getclosesttargetinview(var0, var0.owner, var11);

  if(isDefined(var13)) {
    var12 missile_settargetEnt(var13);
  }

  var12 setCanDamage(1);
  var12 setmissileminimapvisible(1);
  var12.team = var0.team;
  var12.lifeid = var0.lifeid;
  var12.type = var0.type;
  var12.owner = var0.owner;
  var12.entitynumber = var12 getentitynumber();
  var12.streakinfo = var2;
  var12.weapon_name = "switch_blade_child_mp";
  level.rockets[var12.entitynumber] = var12;
  thread monitordeath(level, var12);
}

function getclosesttargetinview(var0, var1) {
  var2 = scripts\mp\utility\killstreak::getenemytargets(var0);
  var3 = undefined;
  var4 = undefined;

  foreach(var6 in var2) {
    if(!isDefined(var6) || !scripts\mp\utility\player::isreallyalive(var6)) {
      continue;
    }

    if(istrue(var6.trinityrocketlocked)) {
      continue;
    }

    var7 = distance2dsquared(var6.origin, var1);

    if(var7 < 262144 && istrue(canseetarget(var6))) {
      if(!isDefined(var4) || var7 < var4) {
        var3 = var6;
        var4 = var7;
      }
    }
  }

  if(isDefined(var3)) {
    var3.trinityrocketlocked = 1;
    thread watchtarget();
  }

  return var3;
}

function canseetarget(var0) {
  var1 = 0;
  var2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var3 = [var0 gettagorigin("j_head"), var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_origin")];

  for(var4 = 0; var4 < var3.size; var4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var3[var4], self, var2)) {
      continue;
    }

    var1 = 1;
    break;
  }

  return var1;
}

function watchtarget() {
  self endon("disconnect");
  self waittill("death");
  self.trinityrocketlocked = undefined;
}

function looptriggeredeffect(var0, var1) {
  var1 endon("death");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    triggerfx(var0);
    wait 0.25;
  }
}

function getnextmissilespawnindex(var0) {
  var1 = var0 + 1;

  if(var1 == level.dronemissilespawnarray.size) {
    var1 = 0;
  }

  return var1;
}

function monitorboost(var0) {
  var0 endon("death");

  for(;;) {
    var0.owner waittill("missileTargetSet");
    var0 notify("missileTargetSet");
  }
}

function getbestmissilespawnpoint(var0, var1) {
  var2 = [];

  foreach(var4 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var4)) {
      continue;
    }

    if(var4.team == var0.team) {
      continue;
    }

    if(var4.team == "spectator") {
      continue;
    }

    var2 = var4;
  }

  if(!var2.size) {
    return var1[randomint(var1.size)];
  }

  [var7] = scripts\engine\utility::array_randomize(var1);

  foreach(var9 in var6) {
    var9.sightedenemies = 0;

    for(var10 = 0; var10 < var2.size; var10++) {
      var11 = var2[var10];

      if(!scripts\mp\utility\player::isreallyalive(var11)) {
        var2 = var2[var2.size - 1];
        var2[var2.size - 1] = undefined;
        var10--;
        continue;
      }

      if(scripts\engine\trace::_bullet_trace_passed(var11.origin + (0, 0, 32), var9.origin, 0, var11)) {
        var9.sightedenemies += 1;
        return var9;
      }

      wait 0.05;
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    if(var9.sightedenemies == var2.size) {
      return var9;
    }

    if(var9.sightedenemies > var7.sightedenemies) {
      var7 = var9;
    }
  }

  return var7;
}

function missileeyes(var0, var1) {
  var2 = 0.5;
  var0 scripts\mp\utility\player::_freezecontrols(1);
  var0 cameralinkTo(var1, "tag_origin");
  var0 controlslinkTo(var1);
  var0 thermalvisionon();
  var0 setclientomnvar("ui_killstreak_health", 1);
  var0 setclientomnvar("ui_killstreak_countdown", gettime() + int(15000));
  thread unfreezecontrols(level, var0);
}

function unfreezecontrols(var0, var1, var2) {
  var0 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var1 - 0.35);
  var0 scripts\mp\utility\player::_freezecontrols(0);
}

function monitordisownkillstreaks(var0) {
  var0 endon("disconnect");
  var0 endon("end_kill_streak");
  GscBinSkip4(0x6e, var0, "joined_team");
}

function monitorownerstatus(var0) {
  self waittill(var0);
  thread returnplayer(level);
}

function monitorgameend(var0) {
  var0 endon("disconnect");
  var0 endon("end_kill_streak");
  level waittill("game_ended");
  var1 = 1;
  thread returnplayer(level, var0, 0);
}

function monitorobjectivecamera(var0) {
  var0 endon("end_kill_streak");
  var0 endon("disconnect");
  level waittill("objective_cam");
  thread returnplayer(level, var0);
}

function monitordeath(var0, var1) {
  var0 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(var0.targeffect)) {
    var0.targeffect delete();
  }

  if(isDefined(var0.entitynumber)) {
    level.rockets[var0.entitynumber] = undefined;
  }

  if(var1) {
    level.remotemissileinprogress = undefined;
    return;
  }
}

function returnplayer(var0, var1, var2) {
  if(!isDefined(var0)) {
    return;
  }

  if(!istrue(var2)) {
    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  var0 setclientomnvar("ui_predator_missile", 2);
  var0 notify("end_kill_streak");
  var0 thermalvisionoff();
  var0 controlsunlink();
  var0 cameraunlink();
  var0 setclientomnvar("ui_predator_missile", 0);
  var0 scripts\common\utility::allow_weapon_switch(1);
}

function watchgastrigger(var0, var1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var2);

    if(!isPlayer(var2)) {
      continue;
    }

    if(level.teambased && var2.team == var0.team && var2 != var0) {
      continue;
    }

    if(istrue(var2.gettinggassed)) {
      continue;
    }

    thread applygasdamageovertime(var0, var1, var2);
  }
}

function applygasdamageovertime(var0, var1, var2) {
  var2 endon("disconnect");
  var2.gettinggassed = 1;

  while(var2 istouching(self)) {
    var2 dodamage(20, self.origin, var0, self, "MOD_EXPLOSIVE", var1);
    var3 = scripts\engine\utility::ref_143b9(0.5, "death");

    if(var3 == "death") {
      break;
    }
  }

  if(istrue(var2.gettinggassed)) {
    var2.gettinggassed = undefined;
    return;
  }
}