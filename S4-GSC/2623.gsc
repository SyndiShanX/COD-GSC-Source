/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2623.gsc
*************************************************/

init() {
  level._id_4FC6 = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var_1 in level._id_4FC6) {
    var_1._id_EEA2 = getent(var_1.target, "targetname");
  }
}

_id_10D8D(var_0) {
  return 1;
}

_id_F77A(var_0) {
  return _id_FE57(self, var_0._id_936C, var_0);
}

_id_FE57(var_0, var_1, var_2) {
  if(isDefined(self._id_F941) && self._id_F941) {
    return 0;
  }

  var_3 = var_0 _id_09B9::_id_EA05(var_2);

  if(!var_3) {
    return 0;
  }

  var_0 scripts\common\utility::_id_1593(0);
  level thread _id_A107(var_0);
  level thread _id_A110(var_0);
  level thread _id_A12B(var_0);
  level thread _id_CA33(var_0, var_1, var_2.streakname, var_2);
  return 1;
}

_id_10B83(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self)) {
      var_0 _meth_840B();
      continue;
    }

    var_0 setclientomnvar("ui_predator_missile", 2);
  }
}

_id_10B81(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(isDefined(self)) {
      var_0 setclientomnvar("ui_predator_missile", 1);
      var_0 setclientomnvar("ui_predator_missiles_left", self._id_9F7F);
      continue;
    }

    var_0 setclientomnvar("ui_predator_missile", 2);
  }
}

_id_10AB1(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 1, 1, 1);

  while(isDefined(self)) {
    var_2 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), level.characters, var_1);

    if(isDefined(var_2["position"]) && distancesquared(self.origin, var_2["position"]) < 5000) {
      break;
    }

    waitframe();
  }

  self.streakinfo notify("killstreak_finished_with_deploy_weapon");
}

_id_CA33(var_0, var_1, var_2, var_3) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_4 = "used_drone_hive";
  var_5 = "drone_hive_projectile_mp";
  var_6 = "switch_blade_child_mp";
  level thread scripts\mp\hud_util::_id_EF8D(var_4, var_0);
  var_0 notifyonplayercommand("missileTargetSet", "+attack");
  var_0 notifyonplayercommand("missileTargetSet", "+attack_akimbo_accessible");
  var_7 = _id_690F(var_0, level._id_4FC6);
  var_8 = var_7.origin * (1, 1, 0) + (0, 0, level._id_9AAC[2] + 10000);
  var_9 = var_7._id_EEA2.origin;
  var_10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(var_5), var_8, var_9, var_0);
  var_10 setCanDamage(1);
  var_10 _meth_80AA();
  var_10 setmissileminimapvisible(1);
  var_10.team = var_0.team;
  var_10._id_936C = var_1;
  var_10.type = "remote";
  var_10.owner = var_0;
  var_10.entitynumber = var_10 getentitynumber();
  var_10.streakinfo = var_3;
  var_10.weapon_name = "drone_hive_projectile_mp";
  level._id_C8B8[var_10.entitynumber] = var_10;
  level._id_C341 = 1;
  level thread _id_A102(var_10, 1);
  level thread _id_A0F8(var_10);
  _id_9F6D(var_0, var_10);
  var_0 setclientomnvar("ui_predator_missile", 1);
  var_10 thread _id_10B83(var_0);
  var_10 thread _id_10B81(var_0);
  var_10 thread scripts\mp\utility\killstreak::_id_10C0E(var_0);
  var_0 scripts\common\utility::_id_F73A(level._id_9BB4, var_2, var_10.origin);
  var_11 = 0;
  var_10._id_9F7F = 2;
  var_12 = 2;
  var_0 setclientomnvar("ui_predator_missiles_left", var_10._id_9F7F);

  for(;;) {
    var_13 = var_10 scripts\engine\utility::_id_10897("death", "missileTargetSet");
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(var_13 == "death") {
      break;
    }

    if(!isDefined(var_10)) {
      break;
    }

    if(istrue(var_10._id_F958)) {
      if(istrue(var_10._id_90A8)) {
        if(gettime() < var_10._id_90A8 + var_12 * 1000 && var_11 == 0) {
          continue;
        }
      }

      level thread _id_5B88(var_10, var_11, var_3, var_6);
      var_11++;
      var_10._id_90A8 = gettime();
      var_10._id_9F7F = 2 - var_11;
      var_14 = var_10._id_9F7F;

      if(var_10._id_9F7F == 0) {
        var_14 = -1;
      }

      var_0 setclientomnvar("ui_predator_missiles_left", var_14);

      if(var_11 == 2) {
        var_11 = 0;
        var_10._id_9F7F = 2;
        var_0 thread _id_C624(var_10, var_12);
      }

      continue;
    }

    if(var_11 < 2) {
      if(!istrue(var_10._id_DD61)) {
        level thread _id_E38A(var_10, var_11, var_3, var_6);
        var_11++;
        var_10._id_9F7F = 2 - var_11;
        var_0 setclientomnvar("ui_predator_missiles_left", var_10._id_9F7F);

        if(var_11 == 2) {
          var_10 _meth_80DC();
        }
      }
    }
  }

  level thread _id_C79C(var_0);
  scripts\mp\utility\print::_id_BD15("killstreak ended - drone_hive", var_0);
}

_id_5B88(var_0, var_1, var_2, var_3) {
  var_4 = var_1;

  for(var_5 = 0; var_5 < 2; var_5++) {
    level thread _id_E38A(var_0, var_4, var_2, var_3);
    var_4++;

    if(var_4 > 1) {
      var_4 = 0;
    }

    wait 0.1;
  }
}

_id_C624(var_0, var_1) {
  var_0 endon("death");
  self endon("disconnect");
  wait(var_1);
  self setclientomnvar("ui_predator_missiles_left", var_0._id_9F7F);
}

_id_A121() {
  level endon("game_ended");
  self endon("death");
  var_0 = [];
  var_1 = [];

  for(;;) {
    var_2 = [];
    var_0 = scripts\mp\utility\killstreak::_id_6A00();

    foreach(var_4 in var_0) {
      var_5 = self.owner _meth_845E(var_4.origin, 65, 90);

      if(var_5) {
        self.owner thread scripts\mp\utility\debug::_id_4F43(self.origin, var_4.origin, 10, (0, 0, 1));
        var_2[var_2.size] = var_4;
      }
    }

    if(var_2.size) {
      var_1 = _func_0204(var_2, self.origin);
      self._id_909C = var_1[0];
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
    }

    wait 0.05;
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_E38A(var_0, var_1, var_2, var_3) {
  var_0.owner playlocalsound("ammo_crate_use");
  var_4 = var_0 gettagangles("tag_origin");
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = (100, 100, 100);
  var_8 = (15000, 15000, 15000);

  if(var_1) {
    var_7 = var_7 * -1;
  }

  var_9 = scripts\engine\trace::_bullet_trace(var_0.origin, var_0.origin + var_5 * var_8, 0, var_0);
  var_8 = var_8 * var_9["fraction"];
  var_10 = var_0.origin + var_6 * var_7;
  var_11 = var_0.origin + var_5 * var_8;
  var_12 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(var_3), var_10, var_11, var_0.owner);
  var_13 = var_0 _id_6975(var_0.owner, var_11);

  if(isDefined(var_13)) {
    var_12 missile_settargetent(var_13);
  }

  var_12 setCanDamage(1);
  var_12 setmissileminimapvisible(1);
  var_12.team = var_0.team;
  var_12._id_936C = var_0._id_936C;
  var_12.type = var_0.type;
  var_12.owner = var_0.owner;
  var_12.entitynumber = var_12 getentitynumber();
  var_12.streakinfo = var_2;
  var_12.weapon_name = "switch_blade_child_mp";
  level._id_C8B8[var_12.entitynumber] = var_12;
  level thread _id_A102(var_12, 0);
}

_id_6975(var_0, var_1) {
  var_2 = scripts\mp\utility\killstreak::_id_6A00(var_0);
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_6)) {
      continue;
    }
    if(istrue(var_6._id_F63F)) {
      continue;
    }
    var_7 = distance2dsquared(var_6.origin, var_1);

    if(var_7 < 262144 && istrue(_id_31D2(var_6))) {
      if(!isDefined(var_4) || var_7 < var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_3)) {
    var_3._id_F63F = 1;
    var_3 thread _id_10C11();
  }

  return var_3;
}

_id_31D2(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0);
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

_id_10C11() {
  self endon("disconnect");
  self waittill("death");
  self._id_F63F = undefined;
}

_id_9849(var_0, var_1) {
  var_1 endon("death");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    triggerfx(var_0);
    wait 0.25;
  }
}

_id_6B87(var_0) {
  var_1 = var_0 + 1;

  if(var_1 == level._id_4FC6.size) {
    var_1 = 0;
  }

  return var_1;
}

_id_A0F8(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0.owner waittill("missileTargetSet");
    var_0 notify("missileTargetSet");
  }
}

_id_690F(var_0, var_1) {
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
    var_2[var_2.size] = var_4;
  }

  if(!var_2.size) {
    return var_1[randomint(var_1.size)];
  }

  var_6 = scripts\engine\utility::array_randomize(var_1);
  var_7 = var_6[0];

  foreach(var_9 in var_6) {
    var_9._id_DD35 = 0;

    for(var_10 = 0; var_10 < var_2.size; var_10++) {
      var_11 = var_2[var_10];

      if(!scripts\mp\utility\player::isreallyalive(var_11)) {
        var_2[var_10] = var_2[var_2.size - 1];
        var_2[var_2.size - 1] = undefined;
        var_10--;
        continue;
      }

      if(scripts\engine\trace::_bullet_trace_passed(var_11.origin + (0, 0, 32), var_9.origin, 0, var_11)) {
        var_9._id_DD35 = var_9._id_DD35 + 1;
        return var_9;
      }

      wait 0.05;
      scripts\mp\hostmigration::waittillhostmigrationdone();
    }

    if(var_9._id_DD35 == var_2.size) {
      return var_9;
    }

    if(var_9._id_DD35 > var_7._id_DD35) {
      var_7 = var_9;
    }
  }

  return var_7;
}

_id_9F6D(var_0, var_1) {
  var_2 = 0.5;
  var_0 scripts\mp\utility\player::_freezecontrols(1);
  var_0 cameralinkto(var_1, "tag_origin");
  var_0 _meth_8094(var_1);
  var_0 _meth_840B();
  var_0 setclientomnvar("ui_killstreak_health", 1);
  var_0 setclientomnvar("ui_killstreak_countdown", gettime() + int(15000));
  level thread _id_F944(var_0, var_2);
}

_id_F944(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1 - 0.35);
  var_0 scripts\mp\utility\player::_freezecontrols(0);
}

_id_A107(var_0) {
  var_0 endon("disconnect");
  var_0 endon("end_kill_streak");
  var_0 childthread _id_A12E("joined_team");
  var_0 childthread _id_A12E("joined_spectators");
}

_id_A12E(var_0) {
  self waittill(var_0);
  level thread _id_C79C(self);
}

_id_A110(var_0) {
  var_0 endon("disconnect");
  var_0 endon("end_kill_streak");
  level waittill("game_ended");
  var_1 = 1;
  level thread _id_C79C(var_0, 0, var_1);
}

_id_A12B(var_0) {
  var_0 endon("end_kill_streak");
  var_0 endon("disconnect");
  level waittill("objective_cam");
  level thread _id_C79C(var_0, 1);
}

_id_A102(var_0, var_1) {
  var_0 waittill("death");
  scripts\mp\hostmigration::waittillhostmigrationdone();

  if(isDefined(var_0._id_EE62)) {
    var_0._id_EE62 delete();
  }

  if(isDefined(var_0.entitynumber)) {
    level._id_C8B8[var_0.entitynumber] = undefined;
  }

  if(var_1) {
    level._id_C341 = undefined;
  }
}

_id_C79C(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!istrue(var_2)) {
    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  var_0 setclientomnvar("ui_predator_missile", 2);
  var_0 notify("end_kill_streak");
  var_0 _meth_840A();
  var_0 _meth_8095();
  var_0 _meth_8060();
  var_0 setclientomnvar("ui_predator_missile", 0);
  var_0 scripts\common\utility::_id_1593(1);
}

_id_10B6A(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    if(level.teambased && var_2.team == var_0.team && var_2 != var_0) {
      continue;
    }
    if(istrue(var_2._id_6DEF)) {
      continue;
    }
    thread _id_19D6(var_0, var_1, var_2);
  }
}

_id_19D6(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  var_2._id_6DEF = 1;

  while(var_2 istouching(self)) {
    var_2 dodamage(20, self.origin, var_0, self, "MOD_EXPLOSIVE", var_1);
    var_3 = scripts\engine\utility::_id_108A7(0.5, "death");

    if(var_3 == "death") {
      break;
    }
  }

  if(istrue(var_2._id_6DEF)) {
    var_2._id_6DEF = undefined;
  }
}