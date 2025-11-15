/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_dronehive.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("drone_hive", ::tryusedronehive, undefined, undefined, undefined, ::func_13C8C);
  level.dronemissilespawnarray = getEntArray("remoteMissileSpawn", "targetname");
  foreach(var_01 in level.dronemissilespawnarray) {
    var_01.var_1155F = getent(var_01.target, "targetname");
  }

  var_03 = ["passive_predator", "passive_no_missiles", "passive_implosion", "passive_rapid_missiles"];
  scripts\mp\killstreak_loot::func_DF07("drone_hive", var_03);
}

func_13C8C(param_00) {
  self setclientomnvar("ui_remote_control_sequence", 1);
}

tryusedronehive(param_00) {
  return usedronehive(self, param_00.lifeid, param_00);
}

usedronehive(param_00, param_01, param_02) {
  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  var_03 = scripts\mp\killstreaks\_killstreaks::func_D507(param_02);
  if(!var_03) {
    return 0;
  }

  param_00 scripts\engine\utility::allow_weapon_switch(0);
  level thread func_B9CB(param_00);
  level thread monitorgameend(param_00);
  level thread monitorobjectivecamera(param_00);
  level thread func_E846(param_00, param_01, param_02.streakname, param_02);
  return 1;
}

func_13AA4(param_00) {
  param_00 endon("killstreak_disowned");
  param_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("host_migration_begin");
    if(isDefined(self)) {
      param_00 thermalvisionon();
      param_00 thermalvisionfofoverlayon();
      continue;
    }

    param_00 setclientomnvar("ui_predator_missile", 2);
  }
}

watchhostmigrationfinishedinit(param_00) {
  param_00 endon("killstreak_disowned");
  param_00 endon("disconnect");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("host_migration_end");
    if(isDefined(self)) {
      param_00 setclientomnvar("ui_predator_missile", 1);
      param_00 setclientomnvar("ui_predator_missiles_left", self.missilesleft);
      continue;
    }

    param_00 setclientomnvar("ui_predator_missile", 2);
  }
}

watchclosetogoal(param_00) {
  param_00 endon("killstreak_disowned");
  param_00 endon("disconnect");
  level endon("game_ended");
  var_01 = scripts\common\trace::create_contents(1, 1, 1, 1, 1, 1, 1);
  while(isDefined(self)) {
    var_02 = scripts\common\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), level.characters, var_01);
    if(isDefined(var_02["position"]) && distancesquared(self.origin, var_02["position"]) < 5000) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  param_00 thread scripts\mp\killstreaks\_killstreaks::func_11086();
}

func_E846(param_00, param_01, param_02, param_03) {
  param_00 endon("killstreak_disowned");
  level endon("game_ended");
  var_04 = "used_drone_hive";
  var_05 = "drone_hive_projectile_mp";
  var_06 = "switch_blade_child_mp";
  var_07 = scripts\mp\killstreak_loot::getrarityforlootitem(param_03.variantid);
  if(var_07 != "") {
    var_04 = var_04 + "_" + var_07;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_03, "passive_implosion")) {
    var_05 = "drone_hive_impulse_mp";
    var_06 = "switch_blade_impulse_mp";
  }

  level thread scripts\mp\utility::teamplayercardsplash(var_04, param_00);
  param_00 notifyonplayercommand("missileTargetSet", "+attack");
  param_00 notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  var_08 = func_7DFE(param_00, level.dronemissilespawnarray);
  var_09 = var_08.origin * (1, 1, 0) + (0, 0, level.mapcenter[2] + 10000);
  var_0A = var_08.var_1155F.origin;
  var_0B = scripts\mp\utility::_magicbullet(var_05, var_09, var_0A, param_00);
  var_0B setCanDamage(1);
  var_0B _meth_80A2();
  var_0B give_player_next_weapon(1);
  var_0B.team = param_00.team;
  var_0B.lifeid = param_01;
  var_0B.type = "remote";
  var_0B.triggerportableradarping = param_00;
  var_0B.entitynumber = var_0B getentitynumber();
  var_0B.streakinfo = param_03;
  var_0B.weapon_name = "drone_hive_projectile_mp";
  var_0B thread watchmissileextraeffect(param_03, 1);
  level.rockets[var_0B.entitynumber] = var_0B;
  level.remotemissileinprogress = 1;
  level thread monitordeath(var_0B, 1);
  level thread monitorboost(var_0B);
  if(isDefined(param_00.killsthislifeperweapon)) {
    param_00.killsthislifeperweapon["drone_hive_projectile_mp"] = 0;
    param_00.killsthislifeperweapon["switch_blade_child_mp"] = 0;
  }

  missileeyes(param_00, var_0B);
  param_00 setclientomnvar("ui_predator_missile", 1);
  var_0B thread func_13AA4(param_00);
  var_0B thread watchhostmigrationfinishedinit(param_00);
  var_0B thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(param_00);
  param_00 scripts\mp\matchdata::logkillstreakevent(param_02, var_0B.origin);
  var_0C = 0;
  var_0B.missilesleft = 2;
  if(scripts\mp\killstreaks\_utility::func_A69F(param_03, "passive_predator")) {
    var_0B.missilesleft = -1;
    var_0B.singlefire = 1;
    var_0B getrankxpmultiplier();
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_03, "passive_rapid_missiles")) {
    var_0B.var_12BA7 = 1;
  }

  var_0D = 2;
  param_00 setclientomnvar("ui_predator_missiles_left", var_0B.missilesleft);
  for(;;) {
    var_0E = var_0B scripts\engine\utility::waittill_any_return("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();
    if(var_0E == "death") {
      break;
    }

    if(!isDefined(var_0B)) {
      break;
    }

    if(scripts\mp\utility::istrue(var_0B.var_12BA7)) {
      if(scripts\mp\utility::istrue(var_0B.lasttimefired)) {
        if(gettime() < var_0B.lasttimefired + var_0D * 1000 && var_0C == 0) {
          continue;
        }
      }

      level thread firerapidmissiles(var_0B, var_0C, param_03, var_06);
      var_0C++;
      var_0B.lasttimefired = gettime();
      var_0B.missilesleft = 2 - var_0C;
      var_0F = var_0B.missilesleft;
      if(var_0B.missilesleft == 0) {
        var_0F = -1;
      }

      param_00 setclientomnvar("ui_predator_missiles_left", var_0F);
      if(var_0C == 2) {
        var_0C = 0;
        var_0B.missilesleft = 2;
        param_00 thread resetmissiles(var_0B, var_0D);
      }

      continue;
    }

    if(var_0C < 2) {
      if(!scripts\mp\utility::istrue(var_0B.singlefire)) {
        level thread spawnswitchblade(var_0B, var_0C, param_03, var_06);
        var_0C++;
        var_0B.missilesleft = 2 - var_0C;
        param_00 setclientomnvar("ui_predator_missiles_left", var_0B.missilesleft);
        if(var_0C == 2) {
          var_0B getrankxpmultiplier();
        }
      }
    }
  }

  level thread func_E474(param_00);
  scripts\mp\utility::printgameaction("killstreak ended - drone_hive", param_00);
}

firerapidmissiles(param_00, param_01, param_02, param_03) {
  var_04 = param_01;
  for(var_05 = 0; var_05 < 2; var_05++) {
    level thread spawnswitchblade(param_00, var_04, param_02, param_03);
    var_04++;
    if(var_04 > 1) {
      var_04 = 0;
    }

    wait(0.1);
  }
}

resetmissiles(param_00, param_01) {
  param_00 endon("death");
  self endon("disconnect");
  wait(param_01);
  self setclientomnvar("ui_predator_missiles_left", param_00.missilesleft);
}

func_B9EE() {
  level endon("game_ended");
  self endon("death");
  var_00 = [];
  var_01 = [];
  for(;;) {
    var_02 = [];
    var_00 = scripts\mp\killstreaks\_utility::func_7E92();
    foreach(var_04 in var_00) {
      var_05 = self.triggerportableradarping worldpointinreticle_circle(var_04.origin, 65, 90);
      if(var_05) {
        self.triggerportableradarping thread scripts\mp\utility::drawline(self.origin, var_04.origin, 10, (0, 0, 1));
        var_02[var_02.size] = var_04;
      }
    }

    if(var_02.size) {
      var_01 = sortbydistance(var_02, self.origin);
      self.var_AA25 = var_01[0];
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
    }

    wait(0.05);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

spawnswitchblade(param_00, param_01, param_02, param_03) {
  param_00.triggerportableradarping playlocalsound("ammo_crate_use");
  var_04 = param_00 gettagangles("tag_origin");
  var_05 = anglesToForward(var_04);
  var_06 = anglestoright(var_04);
  var_07 = (100, 100, 100);
  var_08 = (15000, 15000, 15000);
  if(param_01) {
    var_07 = var_07 * -1;
  }

  var_09 = bulletTrace(param_00.origin, param_00.origin + var_05 * var_08, 0, param_00);
  var_08 = var_08 * var_09["fraction"];
  var_0A = param_00.origin + var_06 * var_07;
  var_0B = param_00.origin + var_05 * var_08;
  var_0C = scripts\mp\utility::_magicbullet(param_03, var_0A, var_0B, param_00.triggerportableradarping);
  var_0D = param_00 getclosesttargetinview(param_00.triggerportableradarping, var_0B);
  if(isDefined(var_0D) && !scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_rapid_missiles")) {
    var_0C missile_settargetent(var_0D);
  }

  var_0C setCanDamage(1);
  var_0C give_player_next_weapon(1);
  var_0C.team = param_00.team;
  var_0C.lifeid = param_00.lifeid;
  var_0C.type = param_00.type;
  var_0C.triggerportableradarping = param_00.triggerportableradarping;
  var_0C.entitynumber = var_0C getentitynumber();
  var_0C.streakinfo = param_02;
  var_0C.weapon_name = "switch_blade_child_mp";
  var_0C thread watchmissileextraeffect(param_02, 0);
  level.rockets[var_0C.entitynumber] = var_0C;
  level thread monitordeath(var_0C, 0);
}

getclosesttargetinview(param_00, param_01) {
  var_02 = scripts\mp\killstreaks\_utility::func_7E92(param_00);
  var_03 = undefined;
  var_04 = undefined;
  foreach(var_06 in var_02) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_06)) {
      continue;
    }

    if(scripts\mp\utility::istrue(var_06.trinityrocketlocked)) {
      continue;
    }

    var_07 = distance2dsquared(var_06.origin, param_01);
    if(var_07 < 262144 && scripts\mp\utility::istrue(canseetarget(var_06))) {
      if(!isDefined(var_04) || var_07 < var_04) {
        var_03 = var_06;
        var_04 = var_07;
      }
    }
  }

  if(isDefined(var_03)) {
    var_03.trinityrocketlocked = 1;
    var_03 thread watchtarget(self);
  }

  return var_03;
}

canseetarget(param_00) {
  var_01 = 0;
  var_02 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_03 = [param_00 gettagorigin("j_head"), param_00 gettagorigin("j_mainroot"), param_00 gettagorigin("tag_origin")];
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    if(!scripts\common\trace::ray_trace_passed(self.origin, var_03[var_04], self, var_02)) {
      continue;
    }

    var_01 = 1;
    break;
  }

  return var_01;
}

watchtarget(param_00) {
  self endon("disconnect");
  for(;;) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(self)) {
      break;
    }

    if(!isDefined(param_00)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self.trinityrocketlocked = undefined;
  if(isDefined(param_00)) {
    param_00 missile_cleartarget();
  }
}

looptriggeredeffect(param_00, param_01) {
  param_01 endon("death");
  level endon("game_ended");
  self endon("death");
  for(;;) {
    triggerfx(param_00);
    wait(0.25);
  }
}

getnextmissilespawnindex(param_00) {
  var_01 = param_00 + 1;
  if(var_01 == level.dronemissilespawnarray.size) {
    var_01 = 0;
  }

  return var_01;
}

monitorboost(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00.triggerportableradarping waittill("missileTargetSet");
    param_00 notify("missileTargetSet");
  }
}

func_7DFE(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in level.players) {
    if(!scripts\mp\utility::isreallyalive(var_04)) {
      continue;
    }

    if(var_04.team == param_00.team) {
      continue;
    }

    if(var_04.team == "spectator") {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  if(!var_02.size) {
    return param_01[randomint(param_01.size)];
  }

  var_06 = scripts\engine\utility::array_randomize(param_01);
  var_07 = var_06[0];
  foreach(var_09 in var_06) {
    var_09.var_101E4 = 0;
    for(var_0A = 0; var_0A < var_02.size; var_0A++) {
      var_0B = var_02[var_0A];
      if(!scripts\mp\utility::isreallyalive(var_0B)) {
        var_02[var_0A] = var_02[var_02.size - 1];
        var_02[var_02.size - 1] = undefined;
        var_0A--;
        continue;
      }

      if(bullettracepassed(var_0B.origin + (0, 0, 32), var_09.origin, 0, var_0B)) {
        var_09.var_101E4 = var_09.var_101E4 + 1;
        return var_09;
      }

      wait(0.05);
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    if(var_09.var_101E4 == var_02.size) {
      return var_09;
    }

    if(var_09.var_101E4 > var_07.var_101E4) {
      var_07 = var_09;
    }
  }

  return var_07;
}

missileeyes(param_00, param_01) {
  var_02 = 0.5;
  param_00 scripts\mp\utility::freezecontrolswrapper(1);
  param_00 cameralinkto(param_01, "tag_origin");
  param_00 controlslinkto(param_01);
  param_00 thermalvisionon();
  param_00 thermalvisionfofoverlayon();
  param_00 playlocalsound("trinity_rocket_plr");
  param_00 setclientomnvar("ui_killstreak_health", 1);
  param_00 setclientomnvar("ui_killstreak_countdown", gettime() + int(15000));
  level thread unfreezecontrols(param_00, var_02);
}

unfreezecontrols(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_01 - 0.35);
  param_00 scripts\mp\utility::freezecontrolswrapper(0);
}

func_B9CB(param_00) {
  param_00 endon("disconnect");
  param_00 endon("end_kill_streak");
  param_00 waittill("killstreak_disowned");
  level thread func_E474(param_00);
}

monitorgameend(param_00) {
  param_00 endon("disconnect");
  param_00 endon("end_kill_streak");
  level waittill("game_ended");
  var_01 = 1;
  level thread func_E474(param_00, 0, var_01);
}

monitorobjectivecamera(param_00) {
  param_00 endon("end_kill_streak");
  param_00 endon("disconnect");
  level waittill("objective_cam");
  level thread func_E474(param_00, 1);
}

monitordeath(param_00, param_01) {
  var_02 = param_00.triggerportableradarping;
  param_00 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();
  if(isDefined(param_00.var_114F1)) {
    param_00.var_114F1 delete();
  }

  if(isDefined(param_00.entitynumber)) {
    level.rockets[param_00.entitynumber] = undefined;
  }

  if(param_01) {
    level.remotemissileinprogress = undefined;
  }

  if(isDefined(var_02) && !scripts\mp\utility::isreallyalive(var_02) && scripts\mp\utility::istrue(param_01)) {
    var_02 thread stopmissilesoundonspawn();
  }
}

stopmissilesoundonspawn() {
  self endon("disconnect");
  self waittill("spawned_player");
  self stoplocalsound("trinity_rocket_plr");
  self stoplocalsound("trinity_rocket_plr_lsrs");
  self stoplocalsound("trinity_rocket_plr_lfe");
}

func_E474(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return;
  }

  param_00 playlocalsound("trinity_rocket_exp_plr");
  if(!scripts\mp\utility::istrue(param_02)) {
    param_00 thread scripts\mp\killstreaks\_killstreaks::func_11086();
  }

  param_00 setclientomnvar("ui_predator_missile", 2);
  param_00 notify("end_kill_streak");
  param_00 stoplocalsound("trinity_rocket_plr");
  param_00 stoplocalsound("trinity_rocket_plr_lsrs");
  param_00 stoplocalsound("trinity_rocket_plr_lfe");
  param_00 thermalvisionoff();
  param_00 thermalvisionfofoverlayoff();
  param_00 controlsunlink();
  param_00 cameraunlink();
  param_00 setclientomnvar("ui_predator_missile", 0);
  param_00 scripts\engine\utility::allow_weapon_switch(1);
}

watchmissileextraeffect(param_00, param_01) {
  level endon("game_ended");
  var_02 = scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_predator");
  var_03 = scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_implosion");
  if(!var_02 && !var_03) {
    return;
  }

  if(var_02 && !scripts\mp\utility::istrue(param_01)) {
    return;
  }

  var_04 = self.triggerportableradarping;
  var_05 = self.weapon_name;
  var_06 = scripts\engine\utility::spawn_tag_origin();
  var_06 linkto(self);
  var_04.extraeffectkillcam = var_06;
  self.explosiontarget = spawn("script_model", self.origin);
  self.explosiontarget setModel("ks_drone_hive_target_mp");
  self.explosiontarget setentityowner(var_04);
  self.explosiontarget setotherent(var_04);
  self.explosiontarget linkto(self, "tag_origin");
  self.explosiontarget.weapon_name = var_05;
  self.explosiontarget.streakinfo = param_00;
  var_07 = self.explosiontarget;
  self waittill("death");
  if(!isDefined(var_07)) {
    return;
  }

  if(var_02) {
    wait(0.27);
    var_07 setscriptablepartstate("chain_explode_1", "active", 0);
    wait(0.27);
    var_07 setscriptablepartstate("chain_explode_2", "active", 0);
    wait(1);
  } else if(var_03) {
    var_07 setscriptablepartstate("impulse_explode", "active", 0);
    wait(0.5);
    var_08 = spawnimpulsefield(var_04, "drone_hive_implosion_mp", var_07.origin);
    wait(0.1);
    var_08 delete();
    var_07 radiusdamage(var_07.origin, 325, 1000, 1000, var_04, "MOD_EXPLOSIVE", var_05);
    scripts\mp\shellshock::grenade_earthquakeatposition(var_07.origin);
    physicsexplosionsphere(var_07.origin, 300, 0, 200);
    wait(1);
  }

  if(isDefined(var_07)) {
    var_07 delete();
  }

  if(isDefined(var_06)) {
    var_06 delete();
  }
}

watchgastrigger(param_00, param_01) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_02);
    if(!isplayer(var_02)) {
      continue;
    }

    if(level.teambased && var_02.team == param_00.team && var_02 != param_00) {
      continue;
    }

    if(scripts\mp\utility::istrue(var_02.gettinggassed)) {
      continue;
    }

    thread applygasdamageovertime(param_00, param_01, var_02);
  }
}

applygasdamageovertime(param_00, param_01, param_02) {
  param_02 endon("disconnect");
  param_02.gettinggassed = 1;
  while(param_02 istouching(self)) {
    param_02 dodamage(20, self.origin, param_00, self, "MOD_EXPLOSIVE", param_01);
    var_03 = scripts\engine\utility::waittill_any_timeout_1(0.5, "death");
    if(var_03 == "death") {
      break;
    }
  }

  if(scripts\mp\utility::istrue(param_02.gettinggassed)) {
    param_02.gettinggassed = undefined;
  }
}