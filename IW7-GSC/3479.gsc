/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3479.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("drone_hive", ::tryusedronehive, undefined, undefined, undefined, ::func_13C8C);
  level.dronemissilespawnarray = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var_01 in level.dronemissilespawnarray) {
  var_1.func_1155F = getent(var_1.target, "targetname");
  }

  var_03 = ["passive_predator", "passive_no_missiles", "passive_implosion", "passive_rapid_missiles"];
  scripts\mp\killstreak_loot::func_DF07("drone_hive", var_03);
}

func_13C8C(var_00) {
  self setclientomnvar("ui_remote_control_sequence", 1);
}

tryusedronehive(var_00) {
  return usedronehive(self, var_0.lifeid, var_00);
}

usedronehive(var_00, var_01, var_02) {
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  var_03 = scripts\mp\killstreaks\killstreaks::func_D507(var_02);

  if(!var_03) {
    return 0;
  }

  var_00 scripts\engine\utility::allow_weapon_switch(0);
  level thread func_B9CB(var_00);
  level thread monitorgameend(var_00);
  level thread monitorobjectivecamera(var_00);
  level thread func_E846(var_00, var_01, var_2.streakname, var_02);
  return 1;
}

func_13AA4(var_00) {
  var_00 endon("killstreak_disowned");
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self)) {
      var_00 thermalvisionon();
      var_00 thermalvisionfofoverlayon();
      continue;
    }

    var_00 setclientomnvar("ui_predator_missile", 2);
  }
}

watchhostmigrationfinishedinit(var_00) {
  var_00 endon("killstreak_disowned");
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(isDefined(self)) {
      var_00 setclientomnvar("ui_predator_missile", 1);
      var_00 setclientomnvar("ui_predator_missiles_left", self.missilesleft);
      continue;
    }

    var_00 setclientomnvar("ui_predator_missile", 2);
  }
}

watchclosetogoal(var_00) {
  var_00 endon("killstreak_disowned");
  var_00 endon("disconnect");
  level endon("game_ended");
  var_01 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1);

  while(isDefined(self)) {
    var_02 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), level.characters, var_01);

    if(isDefined(var_2["position"]) && distancesquared(self.origin, var_2["position"]) < 5000) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  var_00 thread scripts\mp\killstreaks\killstreaks::func_11086();
}

func_E846(var_00, var_01, var_02, var_03) {
  var_00 endon("killstreak_disowned");
  level endon("game_ended");
  var_04 = "used_drone_hive";
  var_05 = "drone_hive_projectile_mp";
  var_06 = "switch_blade_child_mp";
  var_07 = scripts\mp\killstreak_loot::getrarityforlootitem(var_3.variantid);

  if(var_07 != "") {
    var_04 = var_04 + "_" + var_07;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_03, "passive_implosion")) {
    var_05 = "drone_hive_impulse_mp";
    var_06 = "switch_blade_impulse_mp";
  }

  level thread scripts\mp\utility\game::teamplayercardsplash(var_04, var_00);
  var_00 notifyonplayercommand("missileTargetSet", "+attack");
  var_00 notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  var_08 = func_7DFE(var_00, level.dronemissilespawnarray);
  var_09 = var_8.origin * (1, 1, 0) + (0, 0, level.mapcenter[2] + 10000);
  var_10 = var_8.func_1155F.origin;
  var_11 = scripts\mp\utility\game::_magicbullet(var_05, var_09, var_10, var_00);
  var_11 setCanDamage(1);
  var_11 _meth_80A2();
  var_11 give_player_next_weapon(1);
  var_11.team = var_0.team;
  var_11.lifeid = var_01;
  var_11.type = "remote";
  var_11.owner = var_00;
  var_11.entitynumber = var_11 getentitynumber();
  var_11.streakinfo = var_03;
  var_11.weapon_name = "drone_hive_projectile_mp";
  var_11 thread watchmissileextraeffect(var_03, 1);
  level.rockets[var_11.entitynumber] = var_11;
  level.remotemissileinprogress = 1;
  level thread monitordeath(var_11, 1);
  level thread monitorboost(var_11);

  if(isDefined(var_0.killsthislifeperweapon)) {
    var_0.killsthislifeperweapon["drone_hive_projectile_mp"] = 0;
    var_0.killsthislifeperweapon["switch_blade_child_mp"] = 0;
  }

  missileeyes(var_00, var_11);
  var_00 setclientomnvar("ui_predator_missile", 1);
  var_11 thread func_13AA4(var_00);
  var_11 thread watchhostmigrationfinishedinit(var_00);
  var_11 thread scripts\mp\killstreaks\utility::watchsupertrophynotify(var_00);
  var_00 scripts\mp\matchdata::logkillstreakevent(var_02, var_11.origin);
  var_12 = 0;
  var_11.missilesleft = 2;

  if(scripts\mp\killstreaks\utility::func_A69F(var_03, "passive_predator")) {
    var_11.missilesleft = -1;
    var_11.singlefire = 1;
    var_11 getrankxpmultiplier();
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_03, "passive_rapid_missiles")) {
    var_11.func_12BA7 = 1;
  }

  var_13 = 2;
  var_00 setclientomnvar("ui_predator_missiles_left", var_11.missilesleft);

  for(;;) {
    var_14 = var_11 scripts\engine\utility::waittill_any_return("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(var_14 == "death") {
      break;
    }
    if(!isDefined(var_11)) {
      break;
    }
    if(scripts\mp\utility\game::istrue(var_11.func_12BA7)) {
      if(scripts\mp\utility\game::istrue(var_11.lasttimefired)) {
        if(gettime() < var_11.lasttimefired + var_13 * 1000 && var_12 == 0) {
          continue;
        }
      }

      level thread firerapidmissiles(var_11, var_12, var_03, var_06);
      var_12++;
      var_11.lasttimefired = gettime();
      var_11.missilesleft = 2 - var_12;
      var_15 = var_11.missilesleft;

      if(var_11.missilesleft == 0) {
        var_15 = -1;
      }

      var_00 setclientomnvar("ui_predator_missiles_left", var_15);

      if(var_12 == 2) {
        var_12 = 0;
        var_11.missilesleft = 2;
        var_00 thread resetmissiles(var_11, var_13);
      }

      continue;
    }

    if(var_12 < 2) {
      if(!scripts\mp\utility\game::istrue(var_11.singlefire)) {
        level thread spawnswitchblade(var_11, var_12, var_03, var_06);
        var_12++;
        var_11.missilesleft = 2 - var_12;
        var_00 setclientomnvar("ui_predator_missiles_left", var_11.missilesleft);

        if(var_12 == 2) {
          var_11 getrankxpmultiplier();
        }
      }
    }
  }

  level thread func_E474(var_00);
  scripts\mp\utility\game::printgameaction("killstreak ended - drone_hive", var_00);
}

firerapidmissiles(var_00, var_01, var_02, var_03) {
  var_04 = var_01;

  for(var_05 = 0; var_05 < 2; var_5++) {
    level thread spawnswitchblade(var_00, var_04, var_02, var_03);
    var_4++;

    if(var_04 > 1) {
      var_04 = 0;
    }

    wait 0.1;
  }
}

resetmissiles(var_00, var_01) {
  var_00 endon("death");
  self endon("disconnect");
  wait(var_01);
  self setclientomnvar("ui_predator_missiles_left", var_0.missilesleft);
}

func_B9EE() {
  level endon("game_ended");
  self endon("death");
  var_00 = [];
  var_01 = [];

  for(;;) {
    var_02 = [];
    var_00 = scripts\mp\killstreaks\utility::func_7E92();

    foreach(var_04 in var_00) {
      var_05 = self.owner worldpointinreticle_circle(var_4.origin, 65, 90);

      if(var_05) {
        self.owner thread scripts\mp\utility\game::drawline(self.origin, var_4.origin, 10, (0, 0, 1));
        var_2[var_2.size] = var_04;
      }
    }

    if(var_2.size) {
      var_01 = sortbydistance(var_02, self.origin);
      self.func_AA25 = var_1[0];
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

spawnswitchblade(var_00, var_01, var_02, var_03) {
  var_0.owner playlocalsound("ammo_crate_use");
  var_04 = var_00 gettagangles("tag_origin");
  var_05 = anglesToForward(var_04);
  var_06 = anglestoright(var_04);
  var_07 = (100, 100, 100);
  var_08 = (15000, 15000, 15000);

  if(var_01) {
    var_07 = var_07 * -1;
  }

  var_09 = bulletTrace(var_0.origin, var_0.origin + var_05 * var_08, 0, var_00);
  var_08 = var_08 * var_9["fraction"];
  var_10 = var_0.origin + var_06 * var_07;
  var_11 = var_0.origin + var_05 * var_08;
  var_12 = scripts\mp\utility\game::_magicbullet(var_03, var_10, var_11, var_0.owner);
  var_13 = var_00 getclosesttargetinview(var_0.owner, var_11);

  if(isDefined(var_13) && !scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_rapid_missiles")) {
    var_12 missile_settargetent(var_13);
  }

  var_12 setCanDamage(1);
  var_12 give_player_next_weapon(1);
  var_12.team = var_0.team;
  var_12.lifeid = var_0.lifeid;
  var_12.type = var_0.type;
  var_12.owner = var_0.owner;
  var_12.entitynumber = var_12 getentitynumber();
  var_12.streakinfo = var_02;
  var_12.weapon_name = "switch_blade_child_mp";
  var_12 thread watchmissileextraeffect(var_02, 0);
  level.rockets[var_12.entitynumber] = var_12;
  level thread monitordeath(var_12, 0);
}

getclosesttargetinview(var_00, var_01) {
  var_02 = scripts\mp\killstreaks\utility::func_7E92(var_00);
  var_03 = undefined;
  var_04 = undefined;

  foreach(var_06 in var_02) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(var_06)) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(var_6.trinityrocketlocked)) {
      continue;
    }
    var_07 = distance2dsquared(var_6.origin, var_01);

    if(var_07 < 262144 && scripts\mp\utility\game::istrue(canseetarget(var_06))) {
      if(!isDefined(var_04) || var_07 < var_04) {
        var_03 = var_06;
        var_04 = var_07;
      }
    }
  }

  if(isDefined(var_03)) {
    var_3.trinityrocketlocked = 1;
    var_03 thread watchtarget(self);
  }

  return var_03;
}

canseetarget(var_00) {
  var_01 = 0;
  var_02 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_03 = [var_00 gettagorigin("j_head"), var_00 gettagorigin("j_mainroot"), var_00 gettagorigin("tag_origin")];

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_04], self, var_02)) {
      continue;
    }
    var_01 = 1;
    break;
  }

  return var_01;
}

watchtarget(var_00) {
  self endon("disconnect");

  for(;;) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(self)) {
      break;
    }
    if(!isDefined(var_00)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  self.trinityrocketlocked = undefined;

  if(isDefined(var_00)) {
    var_00 missile_cleartarget();
  }
}

looptriggeredeffect(var_00, var_01) {
  var_01 endon("death");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    triggerfx(var_00);
    wait 0.25;
  }
}

getnextmissilespawnindex(var_00) {
  var_01 = var_00 + 1;

  if(var_01 == level.dronemissilespawnarray.size) {
    var_01 = 0;
  }

  return var_01;
}

monitorboost(var_00) {
  var_00 endon("death");

  for(;;) {
    var_0.owner waittill("missileTargetSet");
    var_00 notify("missileTargetSet");
  }
}

func_7DFE(var_00, var_01) {
  var_02 = [];

  foreach(var_04 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_04)) {
      continue;
    }
    if(var_4.team == var_0.team) {
      continue;
    }
    if(var_4.team == "spectator") {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  if(!var_2.size) {
    return var_1[randomint(var_1.size)];
  }

  var_06 = scripts\engine\utility::array_randomize(var_01);
  var_07 = var_6[0];

  foreach(var_09 in var_06) {
    var_9.func_101E4 = 0;

    for(var_10 = 0; var_10 < var_2.size; var_10++) {
      var_11 = var_2[var_10];

      if(!scripts\mp\utility\game::isreallyalive(var_11)) {
        var_2[var_10] = var_2[var_2.size - 1];
        var_2[var_2.size - 1] = undefined;
        var_10--;
        continue;
      }

      if(bullettracepassed(var_11.origin + (0, 0, 32), var_9.origin, 0, var_11)) {
        var_9.func_101E4 = var_9.func_101E4 + 1;
        return var_09;
      }

      wait 0.05;
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    if(var_9.func_101E4 == var_2.size) {
      return var_09;
    }

    if(var_9.func_101E4 > var_7.func_101E4) {
      var_07 = var_09;
    }
  }

  return var_07;
}

missileeyes(var_00, var_01) {
  var_02 = 0.5;
  var_00 scripts\mp\utility\game::freezecontrolswrapper(1);
  var_00 cameralinkto(var_01, "tag_origin");
  var_00 controlslinkto(var_01);
  var_00 thermalvisionon();
  var_00 thermalvisionfofoverlayon();
  var_00 playlocalsound("trinity_rocket_plr");
  var_00 setclientomnvar("ui_killstreak_health", 1);
  var_00 setclientomnvar("ui_killstreak_countdown", gettime() + int(15000));
  level thread unfreezecontrols(var_00, var_02);
}

unfreezecontrols(var_00, var_01, var_02) {
  var_00 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01 - 0.35);
  var_00 scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_B9CB(var_00) {
  var_00 endon("disconnect");
  var_00 endon("end_kill_streak");
  var_00 waittill("killstreak_disowned");
  level thread func_E474(var_00);
}

monitorgameend(var_00) {
  var_00 endon("disconnect");
  var_00 endon("end_kill_streak");
  level waittill("game_ended");
  var_01 = 1;
  level thread func_E474(var_00, 0, var_01);
}

monitorobjectivecamera(var_00) {
  var_00 endon("end_kill_streak");
  var_00 endon("disconnect");
  level waittill("objective_cam");
  level thread func_E474(var_00, 1);
}

monitordeath(var_00, var_01) {
  var_02 = var_0.owner;
  var_00 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(var_0.func_114F1)) {
    var_0.func_114F1 delete();
  }

  if(isDefined(var_0.entitynumber)) {
    level.rockets[var_0.entitynumber] = undefined;
  }

  if(var_01) {
    level.remotemissileinprogress = undefined;
  }

  if(isDefined(var_02) && !scripts\mp\utility\game::isreallyalive(var_02) && scripts\mp\utility\game::istrue(var_01)) {
    var_02 thread stopmissilesoundonspawn();
  }
}

stopmissilesoundonspawn() {
  self endon("disconnect");
  self waittill("spawned_player");
  self stopolcalsound("trinity_rocket_plr");
  self stopolcalsound("trinity_rocket_plr_lsrs");
  self stopolcalsound("trinity_rocket_plr_lfe");
}

func_E474(var_00, var_01, var_02) {
  if(!isDefined(var_00)) {
    return;
  }
  var_00 playlocalsound("trinity_rocket_exp_plr");

  if(!scripts\mp\utility\game::istrue(var_02)) {
    var_00 thread scripts\mp\killstreaks\killstreaks::func_11086();
  }

  var_00 setclientomnvar("ui_predator_missile", 2);
  var_00 notify("end_kill_streak");
  var_00 stopolcalsound("trinity_rocket_plr");
  var_00 stopolcalsound("trinity_rocket_plr_lsrs");
  var_00 stopolcalsound("trinity_rocket_plr_lfe");
  var_00 thermalvisionoff();
  var_00 thermalvisionfofoverlayoff();
  var_00 controlsunlink();
  var_00 cameraunlink();
  var_00 setclientomnvar("ui_predator_missile", 0);
  var_00 scripts\engine\utility::allow_weapon_switch(1);
}

watchmissileextraeffect(var_00, var_01) {
  level endon("game_ended");
  var_02 = scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_predator");
  var_03 = scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_implosion");

  if(!var_02 && !var_03) {
    return;
  }
  if(var_02 && !scripts\mp\utility\game::istrue(var_01)) {
    return;
  }
  var_04 = self.owner;
  var_05 = self.weapon_name;
  var_06 = scripts\engine\utility::spawn_tag_origin();
  var_06 linkto(self);
  var_4.extraeffectkillcam = var_06;
  self.explosiontarget = spawn("script_model", self.origin);
  self.explosiontarget setModel("ks_drone_hive_target_mp");
  self.explosiontarget setentityowner(var_04);
  self.explosiontarget setotherent(var_04);
  self.explosiontarget linkto(self, "tag_origin");
  self.explosiontarget.weapon_name = var_05;
  self.explosiontarget.streakinfo = var_00;
  var_07 = self.explosiontarget;
  self waittill("death");

  if(!isDefined(var_07)) {
    return;
  }
  if(var_02) {
    wait 0.27;
    var_07 setscriptablepartstate("chain_explode_1", "active", 0);
    wait 0.27;
    var_07 setscriptablepartstate("chain_explode_2", "active", 0);
    wait 1;
  } else if(var_03) {
    var_07 setscriptablepartstate("impulse_explode", "active", 0);
    wait 0.5;
    var_08 = _spawnimpulsefield(var_04, "drone_hive_implosion_mp", var_7.origin);
    wait 0.1;
    var_08 delete();
    var_07 radiusdamage(var_7.origin, 325, 1000, 1000, var_04, "MOD_EXPLOSIVE", var_05);
    scripts\mp\shellshock::grenade_earthquakeatposition(var_7.origin);
    physicsexplosionsphere(var_7.origin, 300, 0, 200);
    wait 1;
  }

  if(isDefined(var_07)) {
    var_07 delete();
  }

  if(isDefined(var_06)) {
    var_06 delete();
  }
}

watchgastrigger(var_00, var_01) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_02);

    if(!isplayer(var_02)) {
      continue;
    }
    if(level.teambased && var_2.team == var_0.team && var_02 != var_00) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(var_2.gettinggassed)) {
      continue;
    }
    thread applygasdamageovertime(var_00, var_01, var_02);
  }
}

applygasdamageovertime(var_00, var_01, var_02) {
  var_02 endon("disconnect");
  var_2.gettinggassed = 1;

  while(var_02 istouching(self)) {
    var_02 getrandomarmkillstreak(20, self.origin, var_00, self, "MOD_EXPLOSIVE", var_01);
    var_03 = scripts\engine\utility::waittill_any_timeout(0.5, "death");

    if(var_03 == "death") {
      break;
    }
  }

  if(scripts\mp\utility\game::istrue(var_2.gettinggassed)) {
    var_2.gettinggassed = undefined;
  }
}