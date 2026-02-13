/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2054.gsc
*************************************************/

init() {
  if(!level._id_BA8B) {
    return;
  }
  level._id_BA8C._id_56B5 = spawnStruct();
  var_0 = level._id_BA8C._id_56B5;
  var_0._id_8FFC = undefined;
  var_0._id_9000 = undefined;

  if(level.teambased) {
    var_0._id_909E = [];
    var_0._id_909F = [];
  }
}

_id_AB7E() {
  _id_3978();
}

_id_6A0B() {
  var_0 = _id_0805::_id_6A0D(self);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_F40D)) {
    var_0._id_F40D = _id_3FC8();
  }

  return var_0._id_F40D;
}

_id_3FC8() {
  var_0 = spawnStruct();
  var_0._id_DA4E = 0;
  var_0._id_DA4F = 0;
  var_0._id_DA4D = 0;
  var_0._id_DA52 = 0;
  var_0._id_DA51 = 0;
  return var_0;
}

_id_AB92(var_0) {
  var_1 = level._id_BA8C._id_56B5;
  _id_7449(var_0);
}

_id_7449(var_0) {
  var_1 = level._id_BA8C._id_56B5;
  var_2 = undefined;
  var_3 = undefined;

  if(level.teambased) {
    if(isDefined(var_1._id_909E[var_0])) {
      var_2 = var_1._id_909E[var_0];
      var_3 = var_1._id_909F[var_0];
    } else {
      var_2 = var_1._id_8FFC;
      var_3 = var_1._id_9000;
    }
  } else {
    var_2 = var_1._id_8FFC;
    var_3 = var_1._id_9000;
  }

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 _id_0805::_id_BD6C("final_kill", var_3);
  }
}

_id_AB61(var_0, var_1, var_2) {
  if(!level._id_BA8B) {
    return;
  }
  if(scripts\common\utility::_id_69C4(var_2) == "splash" && !var_1 scripts\mp\utility\game::_id_8A48()) {
    var_1 _id_0805::_id_BD6C("hit_by_explosive");
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!level._id_BA8B) {
    return;
  }
  var_6 = level._id_BA8C._id_56B5;
  var_7 = gettime();

  if(!isPlayer(var_0)) {
    return;
  }
  var_8 = var_0 _id_6A0B();
  var_9 = var_2 _id_6A0B();
  var_10 = var_0 _id_2EBE(var_0);
  var_11 = var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE";
  var_12 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 1, 1);
  var_13 = _func_02C1(var_0 getEye(), var_2 getEye(), var_12, undefined, 0, "physicsquery_closest", 1);
  var_14 = isDefined(var_13) && var_13.size > 0;
  var_15 = scripts\engine\utility::_id_10E76(var_0 getEye(), var_0 getplayerangles(), var_2.origin, cos(80));
  var_16 = var_11 && (!var_15 || var_14);

  if(!var_16) {
    var_0 _id_0805::_id_BD6C("kill", var_7, var_7, var_5, undefined, var_10);
  }

  if(isDefined(self._id_BC4A) && isDefined(var_0._id_904F)) {
    if(var_0._id_904F < self._id_BC4A) {
      var_17 = var_7 - self._id_BC4A;

      if(var_17 < 1800) {
        var_18 = 1.0 - var_17 / 1800;
        var_0 _id_0805::_id_BD6C("kill_rate_bonus", self._id_BC4A, var_7, var_5, undefined, var_18);
      }
    }
  }

  var_0 _id_7464(var_0, var_3, var_4, var_2, var_10, var_5);

  if(var_3 == "MOD_PROJECTILE_SPLASH") {
    var_0 _id_0805::_id_BD6C("missile_splash_kill", var_7, var_7, var_5, undefined, var_10);
  }

  if(scripts\common\utility::_id_69C4(var_3) == "splash") {
    if(scripts\mp\utility\game::_id_6DE6() <= 12000 && randomintrange(0, 2) == 0) {
      var_0 _id_0805::_id_BD6C("round_start_grenade");
    }
  }

  if(istrue(var_0._id_9FFB["bullet_damage"]) && var_2 _id_0A11::_id_A070()) {
    var_0 _id_0805::_id_BD6C("victim_on_fire", var_7, var_7, var_5, undefined, var_10);
  }

  if(var_0 _id_0A11::_id_A070()) {
    var_0 _id_0805::_id_BD6C("kill_while_on_fire", var_7, var_7, var_5, undefined, var_10);
  }

  if(istrue(var_0._id_9FFB["airborne"])) {
    var_8._id_8FF5 = var_7;
    var_8._id_7D88 = 1;
    var_8.airbourneattacker = var_0;
    var_0 thread _id_10B44();
  }

  if(isDefined(var_0._id_8FC0) && var_7 - var_0._id_8FC0 < 3500) {
    var_0 _id_0805::_id_BD6C("open_door_before_kill", var_0._id_8FC0, var_7, var_5, undefined, var_10);
  }

  if(isDefined(var_0._id_1DD4) && var_0._id_1DD4.size > 3) {
    var_0 _id_0805::_id_BD6C("outnumbered", var_7, var_7, var_5, undefined, var_10);
  }

  if(isDefined(var_9._id_909D) && var_7 - var_9._id_909D < 1000 && randomintrange(0, 2) == 0) {
    var_0 _id_0805::_id_BD6C("kill_teabagger", var_9._id_909D, var_7, var_5, undefined, var_10);
  }

  var_0 _id_7442(var_0, var_1, var_2, var_3, var_4, var_10);
  var_0 _id_746A(var_0, var_1, var_2, var_3, var_4, var_10, var_5);

  if(var_8._id_DA4E) {
    if(var_8._id_DA4D >= 0.9) {
      var_0 _id_0805::_id_BD6C("accuracy_good", var_7, var_7, var_5, undefined, var_10);
    } else if(var_8._id_DA4D <= 0.075) {
      var_0 _id_0805::_id_BD6C("accuracy_very_bad", var_7, var_7, var_5, undefined, var_10);
    } else if(var_8._id_DA4D <= 0.15) {
      var_0 _id_0805::_id_BD6C("accuracy_bad", var_7, var_7, var_5, undefined, var_10);
    }
  }

  if(level.teambased) {
    var_6._id_909E[var_0.team] = var_0;
    var_6._id_909F[var_0.team] = var_7;
  }

  var_6._id_8FFC = var_0;
  var_6._id_9000 = var_7;
}

_id_2EBE(var_0) {
  var_1 = 1.0;

  if(!istrue(var_0._id_9FFB["victim_in_standard_view"])) {
    var_1 = var_1 * 0.15;
  }

  return var_1;
}

_id_746A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_3 == "MOD_MELEE") {
    if(isDefined(var_0._id_904F)) {
      var_7 = isDefined(var_0._id_9042) && var_0._id_9042 >= var_0._id_904F;

      if(!var_7) {
        var_0 _id_0805::_id_BD6C("no_shots_fired_kill", undefined, undefined, var_6, undefined, var_5);
      }
    }
  }
}

_id_7442(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1) && istrue(var_1._id_8835) || scripts\mp\utility\weapon::isthrownaxeweapon(var_4, var_1)) {
    var_6 = scripts\mp\utility\weapon::_id_8A9F(var_4) || scripts\mp\utility\weapon::isthrownaxeweapon(var_4, var_1);

    if(isDefined(var_1._id_E352)) {
      var_7 = distancesquared(var_1._id_E352, var_1.origin);

      if(var_6) {
        if(var_7 >= 640000) {
          var_0 _id_0805::_id_BD6C("long_throwing_knife");
        } else {
          var_0 _id_0805::_id_BD6C("throwing_knife");
        }
      } else if(var_7 >= 1440000)
        var_0 _id_0805::_id_BD6C("long_grenade_throw");
    }

    if(scripts\mp\utility\game::_id_6DE6() <= 12000) {
      if(var_6) {
        var_0 _id_0805::_id_BD6C("round_start_throwing_knife");
      }
    }
  }
}

_id_7464(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime();
  var_7 = scripts\mp\utility\weapon::getweapongroup(var_2);

  foreach(var_10, var_9 in var_0._id_9FFB) {
    switch (var_10) {
      case "backstab":
        if(var_1 == "MOD_MELEE") {
          var_0 _id_0805::_id_BD6C("backstab", var_6, var_6, var_5, undefined, var_4);
        }

        break;
      case "pointblank":
        if(var_7 == "weapon_sniper") {
          var_0 _id_0805::_id_BD6C("pointblank_sniper", var_6, var_6, var_5, undefined, var_4);
        } else {
          var_0 _id_0805::_id_BD6C("pointblank", var_6, var_6, var_5, undefined, var_4);
        }

        break;
      case "airborne":
        if(isDefined(var_0._id_9FFB["ads"])) {
          if(var_7 == "weapon_sniper") {
            var_0 _id_0805::_id_BD6C("airborne_ads_sniper_kill", var_6, var_6, var_5, undefined, var_4);
          } else {
            var_0 _id_0805::_id_BD6C("airborne_ads_kill", var_6, var_6, var_5, undefined, var_4);
          }
        }

        break;
      case "victim_airborne":
        if(var_7 == "weapon_sniper") {
          var_0 _id_0805::_id_BD6C("victim_airborne_sniper", var_6, var_6, var_5, undefined, var_4);
        } else {
          var_0 _id_0805::_id_BD6C("victim_airborne", var_6, var_6, var_5, undefined, var_4);
        }

        break;
      case "longshot":
        if(!isDefined(var_0._id_9FFB["very_longshot"])) {
          var_0 _id_0805::_id_BD6C("longshot", var_6, var_6, var_5, undefined, var_4);
        }

        break;
      case "last_bullet_kill":
        if(var_7 != "weapon_sniper" && var_7 != "weapon_projectile") {
          var_0 _id_0805::_id_BD6C("last_bullet_kill", var_6, var_6, var_5, undefined, var_4);
        }

        break;
      case "victim_sprinting":
        if(var_7 == "weapon_sniper") {
          var_0 _id_0805::_id_BD6C("victim_sprinting_sniper", var_6, var_6, var_5, undefined, var_4);
        }

        break;
      default:
        if(_id_0805::_id_56C6(var_10)) {
          var_0 _id_0805::_id_BD6C(var_10, var_6, var_6, var_5, undefined, var_4);
        }

        break;
    }
  }
}

_id_3A53(var_0, var_1) {
  if(!level._id_BA8B) {
    return;
  }
  if(var_1 == 2) {
    var_0 _id_0805::_id_BD6C("collateral");
  } else if(var_1 == 3) {
    var_0 _id_0805::_id_BD6C("triple_collateral");
  } else {
    var_0 _id_0805::_id_BD6C("multi_collateral");
  }
}

_id_DA56(var_0, var_1) {
  if(!level._id_BA8B) {
    return;
  }
  if(var_1 == 2) {
    var_0 _id_0805::_id_BD6C("shotgun_collateral");
  } else {
    var_0 _id_0805::_id_BD6C("shotgun_multi_collateral");
  }
}

_id_BE93(var_0, var_1, var_2) {
  if(!level._id_BA8B) {
    return;
  }
  var_0 _id_0805::_id_BD6C("quad_feed", var_1, var_2);
}

_id_BD6D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\common\utility::_id_B7C7(var_0, 1000);

  foreach(var_7 in var_5) {
    if(!scripts\mp\utility\player::isreallyalive(var_7)) {
      continue;
    }
    var_8 = var_0 - var_7 getEye();
    var_9 = anglesToForward(var_7 getplayerangles());

    if(vectordot(var_8, var_9) < 0) {
      continue;
    }
    var_7 _id_0805::_id_BD6C(var_2, var_3, var_4);
  }
}

_id_10B44() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_0 = _id_6A0B();

  for(;;) {
    if(self isonground()) {
      var_0._id_7D88 = 0;
      var_0.airbourneattacker = undefined;
      break;
    }

    waitframe();
  }
}

_id_BB7B(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  _id_BD6D(var_0, 1000000, "witness_predator_impact");
}

_id_8EE6(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  _id_BD6D(var_0, 640000, "witness_vehicle_explode");
}

_id_10316(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    return;
  }
  var_0.attacker _id_0805::_id_BD6C("vehicle_destroyed");
}

_id_9F81(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  var_0 _id_0805::_id_BD6C("witness_missile_whizby");
}

_id_2635(var_0, var_1, var_2) {
  if(!level._id_BA8B) {
    return;
  }
  if(var_2) {
    var_0 _id_0805::_id_BD6C("ninja_defuse");
  } else if(var_1) {
    var_0 _id_0805::_id_BD6C("last_alive_defuse");
  } else {
    var_0 _id_0805::_id_BD6C("defuse");
  }
}

_id_C7E1(var_0, var_1) {
  if(!level._id_BA8B) {
    return;
  }
  var_0 _id_0805::_id_BD6C("revived_ally");
}

_id_B823(var_0, var_1) {
  if(!level._id_BA8B) {
    return;
  }
  var_2 = _id_6A0B();

  if(istrue(var_2._id_7D88) && isDefined(var_2.airbourneattacker) && isPlayer(var_2.airbourneattacker)) {
    var_2.airbourneattacker _id_0805::_id_BD6C("fall_to_death_kill", var_2._id_8FF5, gettime());
  }
}

_id_4E60(var_0, var_1) {
  if(!level._id_BA8B) {
    return;
  }
  if(!var_1 && isDefined(var_0._id_9000) && gettime() - var_0._id_9000 < 2000) {
    var_0 _id_0805::_id_BD6C("closed_door_after_kill");
  }
}

_id_B7DB(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  var_1 = _id_6A0B();
  var_2 = gettime();

  if(var_0 == "crouch") {
    _id_0805::_id_BD6C("recent_crouch");

    if(isDefined(self._id_9001)) {
      if(distancesquared(self._id_9001, self.origin) < 40000) {
        var_3 = var_2 - self._id_9056["crouch"];

        if(var_3 < 750) {
          var_4 = isDefined(self._id_904F) && (isDefined(var_1._id_909D) && self._id_904F < var_1._id_909D);

          if(!var_4) {
            _id_0805::_id_BD6C("teabag");
          }

          var_1._id_909D = var_2;
        }
      }
    }
  } else if(var_0 == "prone")
    _id_0805::_id_BD6C("recent_prone");
}

_id_DA5E() {
  if(!level._id_BA8B) {
    return;
  }
  var_0 = _id_6A0B();
  _id_FD29(1);
}

_id_DA61() {
  if(!level._id_BA8B) {
    return;
  }
  var_0 = _id_6A0B();
  _id_FD29(0);
}

_id_FD29(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  var_1 = _id_6A0B();
  var_2 = scripts\engine\utility::ter_op(var_0, 1.0, 0.0);
  var_1._id_DA4D = (var_1._id_DA4D * var_1._id_DA4F + var_2) / (var_1._id_DA4F + 1);
  var_1._id_DA4F++;
  thread _id_DA50();
}

_id_DA50() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("clearShotGroup");
  self notify("shotGroupEndWatcher()");
  self endon("shotGroupEndWatcher()");

  if(!level._id_BA8B) {
    return;
  }
  var_0 = _id_6A0B();
  var_0._id_DA4E = 1;
  wait 2.0;
  _id_3978();
}

_id_3978() {
  if(!level._id_BA8B) {
    return;
  }
  var_0 = _id_6A0B();
  var_0._id_DA4E = 0;
  var_0._id_DA52 = var_0._id_DA4F;
  var_0._id_DA51 = var_0._id_DA4D;
  var_0._id_DA4F = 0;
  var_0._id_DA4D = 0;
  self notify("clearShotGroup");
}

_id_7181(var_0) {
  if(!level._id_BA8B) {
    return;
  }
  if(var_0) {
    _id_0805::_id_BD6C("recent_lethal");
  } else {
    _id_0805::_id_BD6C("recent_tactical");
  }
}

_id_012C() {
  if(!level._id_BA8B) {
    return;
  }
  _id_0805::_id_BD6C("recent_crouch");
}

_id_8C91() {
  if(!level._id_BA8B) {
    return;
  }
  _id_0805::_id_BD6C("recent_jump");
}

_id_0350() {
  if(!level._id_BA8B) {
    return;
  }
  _id_0805::_id_BD6C("recent_prone");
}

_id_DDE8() {
  if(!level._id_BA8B) {
    return;
  }
  _id_0805::_id_BD6C("recent_slide");
}

_id_9A4D() {
  if(!level._id_BA8B) {
    return;
  }
  _id_0805::_id_BD6C("recent_mantle");
}