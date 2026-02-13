/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2810.gsc
*************************************************/

_id_BB93() {
  _id_0990::_id_C20E("nuke", ::_id_7112);
  _id_0990::_id_1083("nuke", "s4_zm_power_up_nuke", "ZOMBIE/POWERUP_NUKE", ::_id_602E, !1, !1, !1, "zombie/fx9_powerup_nuke");
  _id_0990::_id_BB18("nuke", "zmb_powerup_spawn", "zmb_powerup_lp", "zmb_powerup_grab_plr", "zmb_powerup_grab_npc", "");
  level._effect["powerup_nuke_explode"] = loadfx("vfx/s4/zombie/vfx_nuke_pickup.vfx");
  level._effect["powerup_nuke_zombie_fire"] = loadfx("vfx/s2/zombie/zmb_zmb_fire_torso.vfx");
  level scripts\engine\utility::_id_5C11("nuke_stop_special_spawning");
}

_id_7112(var_0) {
  level thread _id_A70D(self, var_0.team, var_0);
  var_1 = scripts\cp\utility::_id_6C5C();

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isPlayer(var_3) && isDefined(self._id_7953)) {
      var_3 _id_0990::_id_BB0F(2);
    }
  }

  var_0 thread _id_0990::_id_BB20("nuke");
  var_5 = _func_0070("axis");
  var_0._id_11035 = scripts\engine\utility::_id_6369(self.origin, var_5);
  var_0 notify("nuke_triggered");
}

_id_602E() {
  if(getdvarint("#x3dee089cb49164e4e", 0)) {
    return 1;
  }

  if(!isDefined(level._id_3BE9._id_0F51)) {
    return 0;
  }

  var_0 = scripts\cp\utility::_id_6C5C();

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\cp\utility::_id_688C(var_2.origin, 3000, "axis");

    if(var_3.size) {
      return 1;
    }
  }

  return 0;
}

_id_A70D(var_0, var_1, var_2) {
  level thread _id_A6F2(3);
  var_3 = var_0.origin;
  playFX(scripts\engine\utility::getfx("powerup_nuke_explode"), var_3);
  level thread _id_A6FE(var_1, var_3);
  var_4 = _id_06FE::_id_68A1("axis");

  foreach(var_6 in var_4) {
    var_6 scripts\aitypes\zombie_common\stun::stun(1.5);
  }

  wait 0.5;
  var_8 = scripts\engine\utility::_id_1BCA(var_4);
  var_8 = scripts\engine\utility::_id_6369(var_3, var_8);
  var_9 = [];

  for(var_10 = 0; var_10 < var_8.size; var_10++) {
    if(istrue(var_8[var_10]._id_7D0A)) {
      continue;
    }
    if(isDefined(var_8[var_10]._id_9B33) && var_8[var_10]._id_9B33) {
      continue;
    }
    if(isDefined(var_8[var_10]._id_A6F0)) {
      var_8[var_10] thread[[var_8[var_10]._id_A6F0]]();
      continue;
    }

    if(istrue(var_8[var_10]._id_992D)) {
      continue;
    }
    var_8[var_10]._id_9B33 = 1;

    if(!istrue(var_8[var_10]._id_A72E) && !istrue(var_8[var_10]._id_992D)) {
      var_8[var_10]._id_A72E = 1;
      var_8[var_10]._id_4A75 = 1;
      var_8[var_10]._id_5FF5 = 1;
      var_9[var_9.size] = var_8[var_10];
      var_11 = scripts\engine\utility::ter_op(var_8[var_10] tagexists("j_spinelower"), "j_spinelower", "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("powerup_nuke_zombie_fire"), var_8[var_10], var_11);
      var_8[var_10] _id_0B05::_id_D602("walk");
    }
  }

  var_12 = undefined;

  for(var_10 = 0; var_10 < var_9.size; var_10++) {
    wait(randomfloatrange(0.1, 0.3));

    if(!isDefined(var_9[var_10])) {
      continue;
    }
    if(istrue(var_9[var_10]._id_992D)) {
      continue;
    }
    if(!istrue(var_9[var_10]._id_8806)) {
      var_9[var_10] playSound("zmb_nuke_soul");
    }

    var_13 = undefined;

    if(var_9[var_10] _id_06FE::is_zm_special() && getdvarint("#x3dee089cb49164e4e", 0)) {
      var_13 = var_9[var_10].maxhealth * 0.75;
    } else if(var_9[var_10] _id_06FE::is_zm_elite() && getdvarint("#x3dee089cb49164e4e", 0)) {
      var_13 = var_9[var_10].maxhealth * 0.25;
    } else {
      var_9[var_10] _meth_81FA();
    }

    if(isDefined(var_13)) {
      if(var_13 < var_9[var_10].health) {
        var_9[var_10]._id_9B33 = 0;
        var_9[var_10]._id_4A75 = 0;
        var_9[var_10]._id_5FF5 = 0;

        if(!isDefined(var_12)) {
          var_12 = spawn("script_model", var_3);
        }

        if(isDefined(var_9[var_10]._id_110B0) && var_9[var_10]._id_110B0 == level.zombie_type_trickster) {
          var_9[var_10] dodamage(int(var_13), var_9[var_10].origin, var_2, var_12, "MOD_EXPLOSIVE", undefined, "none");
        } else {
          var_9[var_10] dodamage(int(var_13), var_9[var_10].origin, var_2, var_12, undefined, undefined, "none");
        }

        var_9[var_10]._id_A72E = 0;
        continue;
      }

      var_9[var_10] _meth_81FA();
    }
  }

  if(isDefined(var_12)) {
    var_12 delete();
  }

  level notify("nuke_complete");

  if(_id_0990::_id_4C75("nuke") && isPlayer(var_2)) {
    var_2 thread _id_0752::_id_7003("nuke_powerup");
  } else {
    foreach(var_15 in scripts\cp\utility::_id_6C5C()) {
      var_15 thread _id_0752::_id_7003("nuke_powerup");
    }
  }
}

_id_A6FE(var_0, var_1) {
  if(isDefined(var_0)) {
    scripts\cp\utility::_id_6C5C()[0] playsoundtoteam("zmb_nuke_flash", var_0);
  }

  _func_01EA("ui_total_fade_color", 1);

  foreach(var_3 in level.players) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_3, 1, 0.25);
  }

  wait 0.5;

  foreach(var_3 in level.players) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_3, 0, 1);
  }

  wait 1;
  _func_01EA("ui_total_fade_color", 0);
}

_id_A6F2(var_0) {
  level endon("disable_nuke_delay_spawning");

  if(istrue(level._id_4A28)) {
    return;
  }
  var_1 = level scripts\engine\utility::_id_5C00("spawn_zombies");
  level scripts\engine\utility::_id_5C1B("nuke_stop_special_spawning");
  level scripts\engine\utility::_id_5C04("spawn_zombies");
  level waittill("nuke_complete");

  if(istrue(level._id_4A28)) {
    return;
  }
  level scripts\engine\utility::_id_108F5("abort_nuke_spawn_delay", var_0);

  if(var_1) {
    level scripts\engine\utility::_id_5C1B("spawn_zombies");
  }

  level scripts\engine\utility::_id_5C04("nuke_stop_special_spawning");
}

_id_D2EA(var_0) {
  self._id_A6F0 = ::_id_A6F0;
  self._id_A37F = var_0;
}

_id_A6F0() {
  self endon("death");
  wait(randomfloatrange(0.1, 0.7));
  self dodamage(self.maxhealth * self._id_A37F, self.origin);
  return;
}