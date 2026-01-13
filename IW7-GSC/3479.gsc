/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3479.gsc
**************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("drone_hive", ::tryusedronehive, undefined, undefined, undefined, ::func_13C8C);
  level.dronemissilespawnarray = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var_1 in level.dronemissilespawnarray) {
    var_1.var_1155F = getent(var_1.target, "targetname");
  }

  var_3 = ["passive_predator", "passive_no_missiles", "passive_implosion", "passive_rapid_missiles"];
  scripts\mp\killstreak_loot::func_DF07("drone_hive", var_3);
}

func_13C8C(var_0) {
  self setclientomnvar("ui_remote_control_sequence", 1);
}

tryusedronehive(var_0) {
  return usedronehive(self, var_0.lifeid, var_0);
}

usedronehive(var_0, var_1, var_2) {
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  var_3 = scripts\mp\killstreaks\killstreaks::func_D507(var_2);

  if(!var_3) {
    return 0;
  }

  var_0 scripts\engine\utility::allow_weapon_switch(0);
  level thread func_B9CB(var_0);
  level thread monitorgameend(var_0);
  level thread monitorobjectivecamera(var_0);
  level thread func_E846(var_0, var_1, var_2.streakname, var_2);
  return 1;
}

func_13AA4(var_0) {
  var_0 endon("killstreak_disowned");
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self)) {
      var_0 thermalvisionon();
      var_0 thermalvisionfofoverlayon();
      continue;
    }

    var_0 setclientomnvar("ui_predator_missile", 2);
  }
}

watchhostmigrationfinishedinit(var_0) {
  var_0 endon("killstreak_disowned");
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

watchclosetogoal(var_0) {
  var_0 endon("killstreak_disowned");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);

  while(isDefined(self)) {
    var_2 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), level.characters, var_1);

    if(isDefined(var_2["position"]) && distancesquared(self.origin, var_2["position"]) < 5000) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  var_0 thread scripts\mp\killstreaks\killstreaks::func_11086();
}

func_E846(var_0, var_1, var_2, var_3) {
  var_0 endon("killstreak_disowned");
  level endon("game_ended");
  var_4 = "used_drone_hive";
  var_5 = "drone_hive_projectile_mp";
  var_6 = "switch_blade_child_mp";
  var_7 = scripts\mp\killstreak_loot::getrarityforlootitem(var_3.variantid);

  if(var_7 != "") {
    var_4 = var_4 + "_" + var_7;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_3, "passive_implosion")) {
    var_5 = "drone_hive_impulse_mp";
    var_6 = "switch_blade_impulse_mp";
  }

  level thread scripts\mp\utility\game::teamplayercardsplash(var_4, var_0);
  var_0 notifyonplayercommand("missileTargetSet", "+attack");
  var_0 notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  var_8 = func_7DFE(var_0, level.dronemissilespawnarray);
  var_9 = var_8.origin * (1, 1, 0) + (0, 0, level.mapcenter[2] + 10000);
  var_10 = var_8.var_1155F.origin;
  var_11 = scripts\mp\utility\game::_magicbullet(var_5, var_9, var_10, var_0);
  var_11 setCanDamage(1);
  var_11 func_80A2();
  var_11 give_player_next_weapon(1);
  var_11.team = var_0.team;
  var_11.lifeid = var_1;
  var_11.type = "remote";
  var_11.owner = var_0;
  var_11.entitynumber = var_11 getentitynumber();
  var_11.streakinfo = var_3;
  var_11.weapon_name = "drone_hive_projectile_mp";
  var_11 thread watchmissileextraeffect(var_3, 1);
  level.rockets[var_11.entitynumber] = var_11;
  level.remotemissileinprogress = 1;
  level thread monitordeath(var_11, 1);
  level thread monitorboost(var_11);

  if(isDefined(var_0.killsthislifeperweapon)) {
    var_0.killsthislifeperweapon["drone_hive_projectile_mp"] = 0;
    var_0.killsthislifeperweapon["switch_blade_child_mp"] = 0;
  }

  missileeyes(var_0, var_11);
  var_0 setclientomnvar("ui_predator_missile", 1);
  var_11 thread func_13AA4(var_0);
  var_11 thread watchhostmigrationfinishedinit(var_0);
  var_11 thread scripts\mp\killstreaks\utility::watchsupertrophynotify(var_0);
  var_0 scripts\mp\matchdata::logkillstreakevent(var_2, var_11.origin);
  var_12 = 0;
  var_11.missilesleft = 2;

  if(scripts\mp\killstreaks\utility::func_A69F(var_3, "passive_predator")) {
    var_11.missilesleft = -1;
    var_11.singlefire = 1;
    var_11 getrankxpmultiplier();
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_3, "passive_rapid_missiles")) {
    var_11.var_12BA7 = 1;
  }

  var_13 = 2;
  var_0 setclientomnvar("ui_predator_missiles_left", var_11.missilesleft);

  for(;;) {
    var_14 = var_11 scripts\engine\utility::waittill_any_return("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(var_14 == "death") {
      break;
    }
    if(!isDefined(var_11)) {
      break;
    }
    if(scripts\mp\utility\game::istrue(var_11.var_12BA7)) {
      if(scripts\mp\utility\game::istrue(var_11.lasttimefired)) {
        if(gettime() < var_11.lasttimefired + var_13 * 1000 && var_12 == 0) {
          continue;
        }
      }

      level thread firerapidmissiles(var_11, var_12, var_3, var_6);
      var_12++;
      var_11.lasttimefired = gettime();
      var_11.missilesleft = 2 - var_12;
      var_15 = var_11.missilesleft;

      if(var_11.missilesleft == 0) {
        var_15 = -1;
      }

      var_0 setclientomnvar("ui_predator_missiles_left", var_15);

      if(var_12 == 2) {
        var_12 = 0;
        var_11.missilesleft = 2;
        var_0 thread resetmissiles(var_11, var_13);
      }

      continue;
    }

    if(var_12 < 2) {
      if(!scripts\mp\utility\game::istrue(var_11.singlefire)) {
        level thread spawnswitchblade(var_11, var_12, var_3, var_6);
        var_12++;
        var_11.missilesleft = 2 - var_12;
        var_0 setclientomnvar("ui_predator_missiles_left", var_11.missilesleft);

        if(var_12 == 2) {
          var_11 getrankxpmultiplier();
        }
      }
    }
  }

  level thread func_E474(var_0);
  scripts\mp\utility\game::printgameaction("killstreak ended - drone_hive", var_0);
}

firerapidmissiles(var_0, var_1, var_2, var_3) {
  var_4 = var_1;

  for(var_5 = 0; var_5 < 2; var_5++) {
    level thread spawnswitchblade(var_0, var_4, var_2, var_3);
    var_4++;

    if(var_4 > 1) {
      var_4 = 0;
    }

    wait 0.1;
  }
}

resetmissiles(var_0, var_1) {
  var_0 endon("death");
  self endon("disconnect");
  wait(var_1);
  self setclientomnvar("ui_predator_missiles_left", var_0.missilesleft);
}

func_B9EE() {
  level endon("game_ended");
  self endon("death");
  var_0 = [];
  var_1 = [];

  for(;;) {
    var_2 = [];
    var_0 = scripts\mp\killstreaks\utility::func_7E92();

    foreach(var_4 in var_0) {
      var_5 = self.owner worldpointinreticle_circle(var_4.origin, 65, 90);

      if(var_5) {
        self.owner thread scripts\mp\utility\game::drawline(self.origin, var_4.origin, 10, (0, 0, 1));
        var_2[var_2.size] = var_4;
      }
    }

    if(var_2.size) {
      var_1 = sortbydistance(var_2, self.origin);
      self.var_AA25 = var_1[0];
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

spawnswitchblade(var_0, var_1, var_2, var_3) {
  var_0.owner playlocalsound("ammo_crate_use");
  var_4 = var_0 gettagangles("tag_origin");
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = (100, 100, 100);
  var_8 = (15000, 15000, 15000);

  if(var_1) {
    var_7 = var_7 * -1;
  }

  var_9 = bulletTrace(var_0.origin, var_0.origin + var_5 * var_8, 0, var_0);
  var_8 = var_8 * var_9["fraction"];
  var_10 = var_0.origin + var_6 * var_7;
  var_11 = var_0.origin + var_5 * var_8;
  var_12 = scripts\mp\utility\game::_magicbullet(var_3, var_10, var_11, var_0.owner);
  var_13 = var_0 getclosesttargetinview(var_0.owner, var_11);

  if(isDefined(var_13) && !scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_rapid_missiles")) {
    var_12 missile_settargetent(var_13);
  }

  var_12 setCanDamage(1);
  var_12 give_player_next_weapon(1);
  var_12.team = var_0.team;
  var_12.lifeid = var_0.lifeid;
  var_12.type = var_0.type;
  var_12.owner = var_0.owner;
  var_12.entitynumber = var_12 getentitynumber();
  var_12.streakinfo = var_2;
  var_12.weapon_name = "switch_blade_child_mp";
  var_12 thread watchmissileextraeffect(var_2, 0);
  level.rockets[var_12.entitynumber] = var_12;
  level thread monitordeath(var_12, 0);
}

getclosesttargetinview(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\utility::func_7E92(var_0);
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(var_6)) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(var_6.trinityrocketlocked)) {
      continue;
    }
    var_7 = distance2dsquared(var_6.origin, var_1);

    if(var_7 < 262144 && scripts\mp\utility\game::istrue(canseetarget(var_6))) {
      if(!isDefined(var_4) || var_7 < var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_3)) {
    var_3.trinityrocketlocked = 1;
    var_3 thread watchtarget(self);
  }

  return var_3;
}

canseetarget(var_0) {
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

watchtarget(var_0) {
  self endon("disconnect");

  for(;;) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(self)) {
      break;
    }
    if(!isDefined(var_0)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  self.trinityrocketlocked = undefined;

  if(isDefined(var_0)) {
    var_0 missile_cleartarget();
  }
}

looptriggeredeffect(var_0, var_1) {
  var_1 endon("death");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    triggerfx(var_0);
    wait 0.25;
  }
}

getnextmissilespawnindex(var_0) {
  var_1 = var_0 + 1;

  if(var_1 == level.dronemissilespawnarray.size) {
    var_1 = 0;
  }

  return var_1;
}

monitorboost(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0.owner waittill("missileTargetSet");
    var_0 notify("missileTargetSet");
  }
}

func_7DFE(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_4)) {
      continue;
    }
    if(var_4.team == var_0.team) {
      continue;
    }
    if(var_4.team == "spectator") {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(!var_2.size) {
    return var_1[randomint(var_1.size)];
  }

  var_6 = scripts\engine\utility::array_randomize(var_1);
  var_7 = var_6[0];

  foreach(var_9 in var_6) {
    var_9.var_101E4 = 0;

    for(var_10 = 0; var_10 < var_2.size; var_10++) {
      var_11 = var_2[var_10];

      if(!scripts\mp\utility\game::isreallyalive(var_11)) {
        var_2[var_10] = var_2[var_2.size - 1];
        var_2[var_2.size - 1] = undefined;
        var_10--;
        continue;
      }

      if(bullettracepassed(var_11.origin + (0, 0, 32), var_9.origin, 0, var_11)) {
        var_9.var_101E4 = var_9.var_101E4 + 1;
        return var_9;
      }

      wait 0.05;
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    if(var_9.var_101E4 == var_2.size) {
      return var_9;
    }

    if(var_9.var_101E4 > var_7.var_101E4) {
      var_7 = var_9;
    }
  }

  return var_7;
}

missileeyes(var_0, var_1) {
  var_2 = 0.5;
  var_0 scripts\mp\utility\game::freezecontrolswrapper(1);
  var_0 cameralinkto(var_1, "tag_origin");
  var_0 controlslinkto(var_1);
  var_0 thermalvisionon();
  var_0 thermalvisionfofoverlayon();
  var_0 playlocalsound("trinity_rocket_plr");
  var_0 setclientomnvar("ui_killstreak_health", 1);
  var_0 setclientomnvar("ui_killstreak_countdown", gettime() + int(15000));
  level thread unfreezecontrols(var_0, var_2);
}

unfreezecontrols(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1 - 0.35);
  var_0 scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_B9CB(var_0) {
  var_0 endon("disconnect");
  var_0 endon("end_kill_streak");
  var_0 waittill("killstreak_disowned");
  level thread func_E474(var_0);
}

monitorgameend(var_0) {
  var_0 endon("disconnect");
  var_0 endon("end_kill_streak");
  level waittill("game_ended");
  var_1 = 1;
  level thread func_E474(var_0, 0, var_1);
}

monitorobjectivecamera(var_0) {
  var_0 endon("end_kill_streak");
  var_0 endon("disconnect");
  level waittill("objective_cam");
  level thread func_E474(var_0, 1);
}

monitordeath(var_0, var_1) {
  var_2 = var_0.owner;
  var_0 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(var_0.var_114F1)) {
    var_0.var_114F1 delete();
  }

  if(isDefined(var_0.entitynumber)) {
    level.rockets[var_0.entitynumber] = undefined;
  }

  if(var_1) {
    level.remotemissileinprogress = undefined;
  }

  if(isDefined(var_2) && !scripts\mp\utility\game::isreallyalive(var_2) && scripts\mp\utility\game::istrue(var_1)) {
    var_2 thread stopmissilesoundonspawn();
  }
}

stopmissilesoundonspawn() {
  self endon("disconnect");
  self waittill("spawned_player");
  self stopolcalsound("trinity_rocket_plr");
  self stopolcalsound("trinity_rocket_plr_lsrs");
  self stopolcalsound("trinity_rocket_plr_lfe");
}

func_E474(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 playlocalsound("trinity_rocket_exp_plr");

  if(!scripts\mp\utility\game::istrue(var_2)) {
    var_0 thread scripts\mp\killstreaks\killstreaks::func_11086();
  }

  var_0 setclientomnvar("ui_predator_missile", 2);
  var_0 notify("end_kill_streak");
  var_0 stopolcalsound("trinity_rocket_plr");
  var_0 stopolcalsound("trinity_rocket_plr_lsrs");
  var_0 stopolcalsound("trinity_rocket_plr_lfe");
  var_0 thermalvisionoff();
  var_0 thermalvisionfofoverlayoff();
  var_0 controlsunlink();
  var_0 cameraunlink();
  var_0 setclientomnvar("ui_predator_missile", 0);
  var_0 scripts\engine\utility::allow_weapon_switch(1);
}

watchmissileextraeffect(var_0, var_1) {
  level endon("game_ended");
  var_2 = scripts\mp\killstreaks\utility::func_A69F(var_0, "passive_predator");
  var_3 = scripts\mp\killstreaks\utility::func_A69F(var_0, "passive_implosion");

  if(!var_2 && !var_3) {
    return;
  }
  if(var_2 && !scripts\mp\utility\game::istrue(var_1)) {
    return;
  }
  var_4 = self.owner;
  var_5 = self.weapon_name;
  var_6 = scripts\engine\utility::spawn_tag_origin();
  var_6 linkto(self);
  var_4.extraeffectkillcam = var_6;
  self.explosiontarget = spawn("script_model", self.origin);
  self.explosiontarget setModel("ks_drone_hive_target_mp");
  self.explosiontarget setentityowner(var_4);
  self.explosiontarget setotherent(var_4);
  self.explosiontarget linkto(self, "tag_origin");
  self.explosiontarget.weapon_name = var_5;
  self.explosiontarget.streakinfo = var_0;
  var_7 = self.explosiontarget;
  self waittill("death");

  if(!isDefined(var_7)) {
    return;
  }
  if(var_2) {
    wait 0.27;
    var_7 setscriptablepartstate("chain_explode_1", "active", 0);
    wait 0.27;
    var_7 setscriptablepartstate("chain_explode_2", "active", 0);
    wait 1;
  } else if(var_3) {
    var_7 setscriptablepartstate("impulse_explode", "active", 0);
    wait 0.5;
    var_8 = _spawnimpulsefield(var_4, "drone_hive_implosion_mp", var_7.origin);
    wait 0.1;
    var_8 delete();
    var_7 radiusdamage(var_7.origin, 325, 1000, 1000, var_4, "MOD_EXPLOSIVE", var_5);
    scripts\mp\shellshock::grenade_earthquakeatposition(var_7.origin);
    physicsexplosionsphere(var_7.origin, 300, 0, 200);
    wait 1;
  }

  if(isDefined(var_7)) {
    var_7 delete();
  }

  if(isDefined(var_6)) {
    var_6 delete();
  }
}

watchgastrigger(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);

    if(!isplayer(var_2)) {
      continue;
    }
    if(level.teambased && var_2.team == var_0.team && var_2 != var_0) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(var_2.gettinggassed)) {
      continue;
    }
    thread applygasdamageovertime(var_0, var_1, var_2);
  }
}

applygasdamageovertime(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  var_2.gettinggassed = 1;

  while(var_2 istouching(self)) {
    var_2 getrandomarmkillstreak(20, self.origin, var_0, self, "MOD_EXPLOSIVE", var_1);
    var_3 = scripts\engine\utility::waittill_any_timeout(0.5, "death");

    if(var_3 == "death") {
      break;
    }
  }

  if(scripts\mp\utility\game::istrue(var_2.gettinggassed)) {
    var_2.gettinggassed = undefined;
  }
}