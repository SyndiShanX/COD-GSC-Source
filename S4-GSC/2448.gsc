/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2448.gsc
*************************************************/

init() {
  level._id_EFA0 = [];
  level._id_EFA0["allies"] = "allies";
  level._id_EFA0["axis"] = "axis";
  level._id_BAFD = 0;
  level._effect["powerup_on"] = loadfx("vfx/s4/zombie/powerup_glow_green.vfx");
  level._effect["powerup_intro"] = loadfx("vfx/s4/zombie/powerup_spawn_in_green.vfx");
  level._effect["powerup_grabbed"] = loadfx("vfx/s4/zombie/powerup_glow_green_grab.vfx");
  level._effect["powerup_on_solo"] = loadfx("vfx/s4/zombie/powerup_glow_blue.vfx");
  level._effect["powerup_intro_solo"] = loadfx("vfx/s4/zombie/powerup_spawn_in_blue.vfx");
  level._effect["powerup_grabbed_solo"] = loadfx("vfx/s4/zombie/powerup_glow_blue_grab.vfx");
  var_0 = spawnStruct();
  scripts\cp\utility::_id_D458("zombie_insta_kill", var_0._id_110B7, 0, 1);
  scripts\cp\utility::_id_D458("zombie_drop_item", var_0._id_110B6, 0);
  scripts\cp\utility::_id_D458("zombie_timer_offset", var_0._id_110C9, 350);
  scripts\cp\utility::_id_D458("zombie_timer_offset_interval", var_0._id_110CA, 30);
  scripts\cp\utility::_id_D458("zombie_powerup_fire_sale_on", var_0._id_110C7, 0, 1);
  scripts\cp\utility::_id_D458("zombie_powerup_fire_sale_time", var_0._id_110C8, 30, 1);
  scripts\cp\utility::_id_D458("zombie_powerup_bonfire_sale_on", var_0._id_110B2, 0);
  scripts\cp\utility::_id_D458("zombie_powerup_bonfire_sale_time", var_0._id_110B3, 30);
  scripts\cp\utility::_id_D458("zombie_powerup_insta_kill_on", var_0._id_110B8, 0, 1);
  scripts\cp\utility::_id_D458("zombie_powerup_insta_kill_time", var_0._id_110B9, 30, 1);
  scripts\cp\utility::_id_D458("zombie_powerup_double_points_on", var_0._id_110B4, 0, 1);
  scripts\cp\utility::_id_D458("zombie_powerup_double_points_time", var_0._id_110B5, 30, 1);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_max_per_round", var_0._id_110C1, 4);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_min_1", var_0._id_110C2, 20);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_max_1", var_0._id_110BC, 25);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_min_2", var_0._id_110C3, 30);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_max_2", var_0._id_110BD, 35);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_min_3", var_0._id_110C4, 39);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_max_3", var_0._id_110BE, 44);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_min_4", var_0._id_110C5, 49);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_max_4", var_0._id_110BF, 54);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_min_5", var_0._id_110C6, 23);
  scripts\cp\utility::_id_D458("zombie_powerup_drop_max_5", var_0._id_110C0, 28);
  scripts\cp\utility::_id_D458("zombie_powerup_ammo_spacing_min", var_0._id_110BB, 4);
  scripts\cp\utility::_id_D458("zombie_powerup_ammo_spacing_max", var_0._id_110BA, 7);
  level._id_11040 = scripts\cp\utility::_id_459B(level._id_11040, []);
  _id_8073();
  thread _id_10A3F();
  _id_0AF7::_id_BB93();
  _id_0AF6::_id_BB93();
  _id_0AF9::_id_BB93();
  _id_0AFA::_id_BB93();
  _id_0AF5::_id_BB93();
  _id_0AF8::_id_BB93();
  _id_0AF4::_id_BB93();
  scripts\cp\zombies\powerups\zm_powerup_soul::_id_BB93();

  if(getdvarint("#x3ca096ffd2129faa0", 0) == 1) {
    if(getdvarint("#x3dee089cb49164e4e", 0)) {
      scripts\cp\zombies\powerups\zm_powerup_fire_sale::_id_BB93();
    }
  }

  if(getdvarint("#x3dee089cb49164e4e", 0)) {
    _id_C005();
  }

  _id_06CB::_id_AA4A(::_id_AA4A);
  _id_06CB::_id_AA65(::_id_AA65);
  level scripts\engine\utility::_id_5C11("hack_wait_for_spawn");
}

_id_AA65() {
  wait 5;
  level scripts\engine\utility::_id_5C1B("hack_wait_for_spawn");
}

_id_8073() {
  level scripts\engine\utility::_id_5C11("zombie_drop_powerups");
  level scripts\engine\utility::_id_5C1B("zombie_drop_powerups");
  level._id_0F28 = scripts\cp\utility::_id_459B(level._id_0F28, []);
  _id_1083("insta_kill_ug", "zombie_skull", "ZOMBIE/POWERUP_INSTA_KILL", ::_id_6030, 1, !1, !1, undefined, "powerup_instant_kill_ug", "zombie_powerup_insta_kill_ug_time", "zombie_powerup_insta_kill_ug_on", 0);

  if(isDefined(level._id_9342)) {
    [[level._id_9342]]();
  }

  _id_C005();
  level._id_1103F = 0;
  _id_C005();
  level._id_C03F = 0;
  level._id_A385 = randomintrange(scripts\cp\utility::_id_6873("zombie_powerup_ammo_spacing_min"), scripts\cp\utility::_id_6873("zombie_powerup_ammo_spacing_max"));
  level._id_5B8A = 0;
  level thread _id_BB07();
}

_id_D448(var_0) {
  if(!isDefined(level._id_1105E)) {
    level._id_1105E = [];
  }

  level._id_1105E[var_0] = 1;
}

_id_BB07() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C24("hack_wait_for_spawn");

  if(istrue(level._id_4A3A)) {
    return;
  }
  var_0 = [];
  var_1 = [];
  var_2 = 10;
  var_3 = 0;
  var_4 = 0;
  var_5 = 3;

  for(var_6 = 0.15; var_2 >= var_6; var_4 = !var_4) {
    if(var_2 < 5) {
      var_3 = 0.1;
    } else {
      var_3 = 0.2;
    }

    if(var_4) {
      var_2 = var_2 - var_3 - 0.05;
      var_5 = 2;
    } else {
      var_2 = var_2 - var_3;
      var_5 = 3;
    }

    var_0[var_0.size] = var_2;
    var_1[var_1.size] = var_5;
  }

  var_7 = [];
  var_8 = getarraykeys(level._id_11040);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    if(isDefined(level._id_11040[var_8[var_9]]._id_3999)) {
      var_10 = var_8[var_9];
      var_7[var_10] = spawnStruct();
      var_7[var_10]._id_3999 = level._id_11040[var_10]._id_3999;
      var_7[var_10]._id_399A = level._id_11040[var_10]._id_399A;
      var_7[var_10]._id_AB2D = level._id_11040[var_10]._id_AB2D;
      var_7[var_10]._id_F1ED = level._id_11040[var_10]._id_F1ED;
      var_7[var_10]._id_AA58 = level._id_11040[var_10]._id_AA58;
    }
  }

  var_11 = getarraykeys(var_7);

  for(;;) {
    waittillframeend;
    var_12 = scripts\cp\utility::_id_6C5C();
    var_13 = 0;

    for(var_14 = 0; var_14 < var_12.size; var_14++) {
      var_15 = var_12[var_14];

      if(!isPlayer(var_15)) {
        continue;
      }
      if(!isDefined(var_15.team) || scripts\engine\utility::is_equal(var_15.team, "spectator")) {
        continue;
      }
      if(isDefined(level._id_BB11)) {
        if(![[level._id_BB11]](var_15)) {
          continue;
        }
      }

      for(var_16 = 0; var_16 < var_11.size; var_16++) {
        var_10 = var_11[var_16];
        var_17 = var_7[var_10]._id_3999;
        var_18 = var_7[var_10]._id_399A;
        var_19 = var_7[var_10]._id_F1ED;
        var_20 = var_7[var_10]._id_AA58;
        var_21 = undefined;
        var_22 = undefined;

        if(var_7[var_11[var_16]]._id_AB2D && isDefined(var_15 scripts\cp\utility::_id_6874(var_19)) && isDefined(var_15 scripts\cp\utility::_id_6874(var_20))) {
          var_21 = var_15._id_1105D[var_19];
          var_22 = var_15._id_1105D[var_20];
        } else if(isDefined(scripts\cp\utility::_id_6875(var_19, var_15.team))) {
          var_21 = scripts\cp\utility::_id_6875(var_19, var_15.team);
          var_22 = scripts\cp\utility::_id_6875(var_20, var_15.team);
        } else if(isDefined(scripts\cp\utility::_id_6873(var_19))) {
          var_21 = scripts\cp\utility::_id_6873(var_19);
          var_22 = scripts\cp\utility::_id_6873(var_20);
        }

        if(isDefined(var_21) && isDefined(var_22)) {
          var_13 = var_13 | var_22;
          var_15 _id_D18B(var_17, var_18, var_21, var_22, var_0, var_1);

          if(var_22) {
            var_23 = scripts\cp\utility::_id_6875(var_19 + "_tick", var_15.team);

            if(var_21 <= var_23) {
              var_23 = var_23 - 1.0;
              scripts\cp\utility::_id_D45A(var_19 + "_tick", var_15.team, var_23);
              var_24 = level._id_11040[var_10];

              if(var_21 <= 10) {
                if(isDefined(var_24._id_E9E9) && _func_0205(var_24._id_E9E9._id_E9EB)) {
                  var_15 playSound(var_24._id_E9E9._id_E9EB);
                }
              }
            }
          }

          continue;
        }

        var_15 setclientomnvar(var_17, 0);
      }

      waitframe();
    }

    if(!var_13) {
      level waittill("pump_powerup_hud");
    }
  }
}

_id_D18B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_3 && !istrue(self._id_2033)) {
    self setclientomnvar(var_1, int(_func_0037(var_2)));

    if(var_2 < 10) {
      var_6 = 3;

      for(var_7 = var_4.size - 1; var_7 > 0; var_7--) {
        if(var_2 < var_4[var_7]) {
          var_6 = var_5[var_7];
          break;
        }
      }

      self setclientomnvar(var_0, var_6);
    } else
      self setclientomnvar(var_0, 1);
  } else {
    self setclientomnvar(var_0, 0);
    self setclientomnvar(var_1, 0);
  }
}

_id_C005() {
  level._id_1103D = scripts\engine\utility::array_randomize(level._id_1103D);
}

_id_65E5() {
  if(isDefined(level._id_E9E2)) {
    var_0 = level._id_E9E2;
    level._id_E9E2 = undefined;
  } else {
    var_0 = level._id_1103D[level._id_1103F];
    level._id_1103F++;

    if(level._id_1103F >= level._id_1103D.size) {
      level._id_1103F = 0;
      _id_C005();
    }
  }

  return var_0;
}

_id_6805() {
  if(isDefined(level._id_1103E)) {
    var_0 = level._id_1103E;
    level._id_1103E = undefined;
    return level._id_1103D[var_0];
  }

  if(isDefined(level._id_1103C)) {
    var_1 = level._id_1103C;
    level._id_1103C = undefined;
    return var_1;
  }

  for(;;) {
    var_1 = _id_65E5();

    if(isDefined(level._id_11040[var_1]) && [[level._id_11040[var_1]._id_602F]]()) {
      return var_1;
    }
  }
}

_id_9BA6() {
  if(!level._id_11040.size) {
    return 0;
  }

  foreach(var_1 in level._id_1103D) {
    if(isDefined(level._id_11040[var_1]) && [[level._id_11040[var_1]._id_602F]]()) {
      return 1;
    }
  }

  return 0;
}

_id_9F03() {
  var_0 = scripts\cp\utility::_id_6C5C();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1]._id_1105D["zombie_powerup_minigun_on"] == 1) {
      return 1;
    }
  }

  if(!level scripts\engine\utility::_id_5C00("power_on")) {
    if(level scripts\engine\utility::_id_5C00("solo_game")) {
      if(!isDefined(level._id_E016) || level._id_E016 == 0) {
        return 1;
      }
    } else
      return 1;
  }

  return 0;
}

_id_10A3F() {
  level endon("end_game");
  level scripts\engine\utility::_id_5C24("hack_wait_for_spawn");
  waitframe();
  level._id_A37D = _id_6536();
  level._id_A391 = scripts\cp\utility::_id_459B(level._id_A391, 0);

  for(;;) {
    level scripts\engine\utility::_id_5C24("zombie_drop_powerups");

    if(level._id_A391 >= level._id_A37D) {
      level _id_FBB7();
      level._id_A37D = level._id_A391 + _id_6536();
      scripts\cp\utility::_id_D458("zombie_drop_item", 1);
    }

    wait 0.5;
  }
}

_id_6536() {
  var_0 = scripts\cp\utility::_id_6C5C();
  var_1 = 1;

  if(isDefined(var_0) && var_0.size > 1) {
    var_1 = clamp(var_0.size, 1, 4);
  }

  var_2 = randomintrange(scripts\cp\utility::_id_6873("zombie_powerup_drop_min_" + var_1), scripts\cp\utility::_id_6873("zombie_powerup_drop_max_" + var_1));

  if(!isDefined(var_2) || var_2 < 1) {
    var_2 = 12;
  }

  return var_2;
}

_id_FBB7() {
  var_0 = 990;
  var_1 = 999;

  for(var_2 = 1; var_2 <= 4; var_2++) {
    scripts\cp\utility::_id_D458("zombie_powerup_drop_min_" + var_2, int(min(var_0, scripts\cp\utility::_id_6873("zombie_powerup_drop_min_" + var_2) + 1)));
    scripts\cp\utility::_id_D458("zombie_powerup_drop_max_" + var_2, int(min(var_1, scripts\cp\utility::_id_6873("zombie_powerup_drop_max_" + var_2) + 1)));
  }
}

_id_1101D(var_0) {
  if(!level scripts\engine\utility::_id_5C00("zombie_drop_powerups")) {
    return 0;
  }

  if(istrue(level._id_A52A) || istrue(self._id_A52A) || isDefined(var_0) && istrue(var_0._id_889E)) {
    return 0;
  }

  if(istrue(level._id_FDF1)) {
    var_1 = getEntArray("no_powerups", "targetname");

    foreach(var_3 in var_1) {
      if(self istouching(var_3)) {
        return 0;
      }
    }
  }

  if(isDefined(level.check_in_playable_area_func)) {
    if(![[level.check_in_playable_area_func]](self)) {
      return 0;
    }
  }

  return 1;
}

_id_11020(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(scripts\cp\utility::_id_6873("zombie_drop_item")) {
    var_1 = 1;
    var_2 = 1;
  } else {}

  if(var_1 && _id_1101D(var_0)) {
    if(istrue(self._id_7D7D)) {
      var_3 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 100), self.origin + (0, 0, -100), 0, undefined);
    } else {
      var_3 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 5), self.origin + (0, 0, -300), 0, undefined);
    }

    var_4 = var_3["position"];
    var_5 = var_3["entity"];
    var_6 = undefined;
    level thread _id_BAFC(var_4, var_6, var_2);
  }
}

_id_66DE() {
  var_0 = getarraykeys(level._id_11040);
  var_0 = scripts\engine\utility::array_randomize(var_0);
  return var_0[0];
}

_id_66F8() {
  var_0 = getarraykeys(level._id_11040);
  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if([[level._id_11040[var_0[var_1]]._id_602F]]()) {
      return var_0[var_1];
    }
  }

  return var_0[0];
}

_id_60F3() {
  return 1;
}

_id_1083(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  if(!isDefined(var_11)) {
    var_11 = 0;
  }

  if(!isDefined(var_12)) {
    var_12 = 0;
  }

  if(isDefined(level._id_1102C) && !istrue(level._id_1102C[var_0])) {
    return;
  }
  switch (var_0) {
    case "small_ammo":
      var_16 = "";
      break;
    case "full_ammo":
      var_16 = "zmPowerupMaxAmmo";
      break;
    case "fire_sale":
      var_16 = "zmPowerupFireSale";
      break;
    case "bonus_points_player_shared":
    case "bonus_points_player":
    case "bonus_points_team":
      var_16 = "zmPowerupChaosPoints";
      break;
    case "free_perk":
      var_16 = "zmPowerupFreePerk";
      break;
    case "nuke":
      var_16 = "zmPowerupNuke";
      break;
    case "hero_weapon_power":
      var_16 = "zmPowerupSpecialWeapon";
      break;
    case "insta_kill":
      var_16 = "zmPowerupInstakill";
      break;
    case "double_points":
      var_16 = "zmPowerupDouble";
      break;
    case "carpenter":
      var_16 = "zmPowerupCarpenter";
      break;
    case "shield_charge":
      var_16 = "";
      break;
    case "armor_repair":
      var_16 = "zmPowerupArmorRepair";
      break;
    default:
      var_16 = "";
  }

  level._id_1103D = scripts\cp\utility::_id_459B(level._id_1103D, []);
  var_17 = spawnStruct();
  var_17._id_BB0E = var_0;
  var_17._id_9FCB = var_1;
  var_17._id_10CED = "script_model";
  var_17._id_7953 = var_2;
  var_17._id_602F = var_3;
  var_17._id_AB2D = var_4;
  var_17._id_190E = var_5;
  var_17._id_1102B = var_6;

  if(isDefined(var_13) && isDefined(var_14) && isDefined(var_15)) {
    var_17.override_powerup_fx = 1;
    var_17.override_powerup_on_fx = var_13;
    var_17.override_powerup_intro_fx = var_14;
    var_17.override_powerup_grabbed_fx = var_15;
  }

  var_17._id_B5E0 = var_12;
  var_17._id_30D6 = 1;

  if(isDefined(var_7)) {
    var_17._id_605B = var_7;
  }

  level._id_11040[var_0] = var_17;
  level._id_1103D = scripts\engine\utility::array_add(level._id_1103D, var_0);
  _id_1084(var_0);

  if(isDefined(var_8)) {
    var_18 = var_8 + "_state";
    var_19 = var_8 + "_time";
    var_17._id_3999 = var_18;
    var_17._id_399A = var_19;
    var_17._id_F1ED = var_9;
    var_17._id_AA58 = var_10;
  }

  if(scripts\engine\utility::is_equal(var_0, "full_ammo")) {
    level._id_A37E = gettime() / 1000;
  }
}

_id_BB15(var_0, var_1) {
  level._id_11040[var_0]._id_30D6 = var_1;
}

_id_BB17(var_0, var_1) {
  level._id_0BAF[var_0]._id_BC18 = var_1;
}

_id_BB16(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  level._id_11040[var_0]._id_B5E0 = var_1;
}

_id_BB19(var_0) {
  level._id_11053 = scripts\cp\utility::_id_459B(level._id_11053, []);
  level._id_11053[var_0] = 1;
}

_id_1084(var_0) {
  if(!isDefined(level._id_11051)) {
    level._id_11051 = [];
  }

  level._id_11051[level._id_11051.size] = var_0;
}

_id_7D9C(var_0) {
  if(!isDefined(level._id_1102C)) {
    level._id_1102C = [];
  }

  level._id_1102C[var_0] = 1;
}

_id_BB12(var_0) {
  if(!isDefined(level._id_11040) || !isDefined(level._id_11040[var_0])) {
    return;
  }
  level._id_11040[var_0]._id_602F = ::_id_6030;
}

_id_BB1D(var_0) {
  if(!isDefined(level._id_11040) || !isDefined(level._id_11040[var_0]) || isDefined(level._id_11040[var_0]._id_6032)) {
    return;
  }
  level._id_11040[var_0]._id_6032 = level._id_11040[var_0]._id_602F;
  level._id_11040[var_0]._id_602F = ::_id_6030;
}

_id_BB13(var_0) {
  if(!isDefined(level._id_11040) || !isDefined(level._id_11040[var_0]) || !isDefined(level._id_11040[var_0]._id_6032)) {
    return;
  }
  level._id_11040[var_0]._id_602F = level._id_11040[var_0]._id_6032;
  level._id_11040[var_0]._id_6032 = undefined;
}

_id_BB14() {
  level._id_BAFD = 0;
}

_id_3858(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_BAFC(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("#x3c206bdd8d626094e", 0);

  if(istrue(var_4)) {
    return;
  }
  var_2 = scripts\cp\utility::_id_459B(var_2, 1);
  var_3 = scripts\cp\utility::_id_459B(var_3, 0);

  if(isDefined(level._id_4264)) {
    var_5 = [[level._id_4264]](var_0);

    if(istrue(var_5)) {
      return;
    }
  }

  scripts\cp\utility::_id_D458("zombie_drop_item", 0);
  level._id_BAFD++;

  if(!isDefined(var_1)) {
    var_1 = _id_098F::_id_A430("powerup", 1, "script_model", var_0 + (0, 0, 40));
  }

  var_1 setModel("tag_origin");

  if(!isDefined(level._id_1102C) || level._id_1102C.size == 0 || !_id_9BA6()) {
    _id_3858(var_1);
    level._id_BAFD--;
    scripts\cp\utility::_id_D458("zombie_drop_item", 1);
    return;
  }

  var_6 = 1;

  if(var_2 && var_6 && level._id_C03F) {
    var_7 = (var_0[0], var_0[1], var_0[2] + 42);

    if(_id_3464(var_7)) {
      var_6 = 0;
    }
  }

  if(!var_6) {
    level._id_BAFD--;
    var_1 delete();
    scripts\cp\utility::_id_D458("zombie_drop_item", 1);
    return;
  }

  var_1 _id_BB1A(undefined, undefined, var_0);
  var_1 thread _id_BB1F();
  var_1 thread _id_BB22();
  var_1 scripts\engine\utility::delaythread(0.1, ::_id_BB03);
  level notify("powerup_dropped", var_1);
}

_id_8685(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_B315)) {
    var_2 = scripts\engine\utility::_id_6369(var_0.origin, level._id_B315, undefined, level._id_9C4A);

    foreach(var_4 in var_2) {
      if(var_0 istouching(var_4)) {
        return 1;
      }
    }
  }

  if(isDefined(level._id_B316)) {
    if(isDefined(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_A215() {}

_id_E3DD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_3 = scripts\cp\utility::_id_459B(var_3, 0.1);
  var_6 = scripts\cp\utility::_id_459B(var_6, 0);
  var_8 = scripts\cp\utility::_id_459B(var_8, 1);

  if(_func_0107(var_0)) {
    var_0 = scripts\engine\utility::random(var_0);
  }

  switch (var_0) {
    case "full_ammo":
      var_10 = "zmPowerupMaxAmmo";
      break;
    case "fire_sale":
      var_10 = "zmPowerupFireSale";
      break;
    case "bonus_points_player_shared":
    case "bonus_points_player":
    case "bonus_points_team":
      var_10 = "zmPowerupChaosPoints";
      break;
    case "free_perk":
      var_10 = "zmPowerupFreePerk";
      break;
    case "nuke":
      var_10 = "zmPowerupNuke";
      break;
    case "hero_weapon_power":
      var_10 = "zmPowerupSpecialWeapon";
      break;
    case "insta_kill":
      var_10 = "zmPowerupInstakill";
      break;
    case "double_points":
      var_10 = "zmPowerupDouble";
      break;
    case "carpenter":
      var_10 = "zmPowerupCarpenter";
      break;
    case "armor_repair":
      var_10 = "zmPowerupArmorRepair";
      break;
    default:
      var_10 = "";
  }

  if(!var_8 && isDefined(level._id_11040[var_0])) {
    if(![[level._id_11040[var_0]._id_602F]]()) {
      return;
    }
  }

  var_11 = _func_0198(var_1 + (0, 0, 10), var_1 + (0, 0, -100));
  var_12 = _id_098F::_id_A430("powerup", 1, "script_model", var_1 + (0, 0, 40));
  var_12 setModel("tag_origin");
  var_1 = var_12.origin;
  level notify("powerup_dropped", var_12);
  return _id_BB08(var_12, var_0, var_2, var_1, var_3, var_4, var_5, var_7, var_9);
}

_id_BB08(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_4 = scripts\cp\utility::_id_459B(var_4, 0.1);

  if(isDefined(var_0)) {
    var_0 _id_BB1A(var_1, var_2, var_3, var_5, undefined, var_7);

    if(istrue(var_8) && !_id_8685(var_0)) {
      var_0 thread _id_A215();
    }

    if(!istrue(var_6)) {
      var_0 thread _id_BB1F();
    }

    var_0 thread _id_BB22();

    if(isDefined(var_4) && var_4 < 0.1) {
      var_4 = 0.1;
    }

    var_0 scripts\engine\utility::delaythread(var_4, ::_id_BB03, var_2);
    return var_0;
  }
}

_id_BB09(var_0, var_1, var_2, var_3) {
  var_4 = 60;
  var_5 = 120;
  var_6 = 6;

  if(scripts\engine\utility::is_equal(var_0, "nuke")) {
    var_7 = scripts\engine\utility::_id_EA52(randomint(2147483647));
    var_8 = self.origin;
    _func_0018(var_7, 0, var_8, var_4, var_5, "allies");

    while(isDefined(self)) {
      if(distance2dsquared(var_8, self.origin) > _func_0219(var_6)) {
        var_8 = self.origin;
        _func_0018(var_7, 0, var_8, var_4, var_5, "allies");
      }

      wait 1;
    }

    _func_0019(var_7);
  }
}

_id_BB1A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_4 = scripts\cp\utility::_id_459B(var_4, 1);
  var_6 = undefined;

  if(!isDefined(var_0)) {
    var_6 = _id_6805();
  } else {
    var_6 = var_0;

    if("tesla" == var_6 && _id_F0B4()) {
      var_6 = "minigun";
    }
  }

  var_7 = level._id_11040[var_6];

  if(isDefined(var_1)) {
    self._id_BB1E = var_1;
  }

  if(isDefined(var_2)) {
    self._id_BB0D = var_2;
  }

  if(isDefined(var_3)) {
    self._id_BB10 = var_3;
  } else {}

  self._id_BB0E = var_7._id_BB0E;
  self._id_7953 = var_7._id_7953;
  self._id_3999 = var_7._id_3999;
  self._id_AB2D = var_7._id_AB2D;
  self._id_190E = var_7._id_190E;
  self._id_1102B = var_7._id_1102B;
  self._id_602F = var_7._id_602F;

  if(scripts\engine\utility::is_equal(var_7.override_powerup_fx, 1)) {
    self.override_powerup_fx = var_7.override_powerup_fx;
    self.override_powerup_on_fx = var_7.override_powerup_on_fx;
    self.override_powerup_intro_fx = var_7.override_powerup_intro_fx;
    self.override_powerup_grabbed_fx = var_7.override_powerup_grabbed_fx;
  }

  if(isDefined(level._id_0BAF) && isDefined(level._id_0BAF[var_6]) && isDefined(level._id_0BAF[var_6]._id_D80E)) {
    self[[level._id_0BAF[var_6]._id_D80E]]();
  } else {
    _id_BB1C(var_2, var_7, var_5);
  }

  if(var_6 == "full_ammo") {
    level._id_A385 = randomintrange(scripts\cp\utility::_id_6873("zombie_powerup_ammo_spacing_min"), scripts\cp\utility::_id_6873("zombie_powerup_ammo_spacing_max"));
  } else if(!isDefined(var_0)) {
    level._id_A385--;
  }

  if(isDefined(var_7._id_605B)) {
    self._id_605B = var_7._id_605B;
  }

  if(isDefined(var_7._id_30D6)) {
    self._id_30D6 = var_7._id_30D6;
  }

  var_8 = scripts\cp\utility::_id_459B(var_7._id_202B, 0);

  if(!var_8) {
    if(isDefined(level._id_5D4E)) {
      var_8 = self[[level._id_5D4E]](self._id_BB0E);
    }
  }

  if(!istrue(var_8)) {
    if(isDefined(var_7._id_E9E9)) {
      if(_func_0205(var_7._id_E9E9._id_E9EA)) {
        self playSound(var_7._id_E9E9._id_E9EA);
      }

      if(_func_0205(var_7._id_E9E9._id_E9E4)) {
        self playLoopSound(var_7._id_E9E9._id_E9E4);
      }
    }
  }

  level._id_0F28[level._id_0F28.size] = self;
  thread _id_BB09(var_6, var_1, var_2, var_3);
}

_id_BB25(var_0) {
  scripts\engine\utility::_id_1087F("powerup_timedout", "powerup_grabbed", "hacked");
  var_0 delete();
}

_id_BB24(var_0) {
  self endon("powerup_timedout");
  self endon("powerup_grabbed");
  self endon("hacked");
  var_1 = spawn("trigger_radius", self.origin - (0, 0, 40), 521, 32, 72);
  var_1 _meth_80DB();
  var_1 linkto(self);
  var_1 _meth_838B(level._id_11056);
  thread _id_BB25(var_1);
  var_2 = 300;

  if(isDefined(level._id_0DDC)) {
    var_2 = level._id_0DDC;
  }

  while(isDefined(self)) {
    var_3 = var_1 scripts\engine\utility::_id_1087F("trigger");
    var_4 = var_3._id_0025;

    if(isDefined(level._id_0C99)) {
      if(!self[[level._id_0C99]](var_4)) {
        continue;
      }
    } else if(!isDefined(var_4) || !isai(var_4)) {
      continue;
    }
    self stoploopsound();

    if(isDefined(level._id_0BAF) && isDefined(level._id_0BAF[self._id_BB0E]) && isDefined(level._id_0BAF[self._id_BB0E]._id_7113)) {
      var_5 = self[[level._id_0BAF[self._id_BB0E]._id_7113]](var_4);

      if(istrue(var_5)) {
        continue;
      }
    } else {
      if(isDefined(level._id_0DDE)) {
        level thread[[level._id_0DDE]](self);
      }

      if(isDefined(level._id_0BF3)) {
        level thread[[level._id_0BF3]](self, var_4);
      } else {}
    }

    wait 0.1;
    thread _id_BAF9();
    self notify("powerup_grabbed", var_4);
  }
}

_id_BB03(var_0) {
  if(isDefined(self) && self._id_1102B) {
    thread _id_BB24(var_0);
    return;
  }

  self endon("powerup_timedout");
  self endon("powerup_grabbed");

  if(isDefined(self._id_A377)) {
    var_1 = _func_0219(self._id_A377);
  } else {
    var_1 = 4096;
  }

  while(isDefined(self)) {
    var_2 = undefined;

    if(isDefined(self._id_BB10)) {
      var_3 = [];
      var_3[0] = self._id_BB10;
    } else if(isDefined(level._id_BB04))
      var_3 = [[level._id_BB04]]();
    else {
      var_3 = scripts\cp\utility::_id_6C5C();
    }

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = var_3[var_4];

      if(isalive(var_5.owner) && isPlayer(var_5.owner)) {
        var_2 = var_5.owner;
      } else if(isPlayer(var_5)) {
        var_2 = var_5;
      }

      if(!isDefined(self)) {
        break;
      }

      if(self._id_AB2D && !isDefined(var_2)) {
        continue;
      }
      if(isDefined(level._id_0BAF) && isDefined(level._id_0BAF[self._id_BB0E]) && istrue(level._id_0BAF[self._id_BB0E]._id_BC18)) {
        continue;
      }
      if((self._id_BB0E == "minigun" || self._id_BB0E == "tesla" || self._id_BB0E == "random_weapon" || self._id_BB0E == "meat_stink") && (!isPlayer(var_5) || _id_073B::_id_B4EF(var_2) || var_2 useButtonPressed())) {
        continue;
      }
      if(!istrue(self._id_30D6) && _id_073B::_id_B4EF(var_2)) {
        continue;
      }
      if(isDefined(var_2.a_disable_grab_for_powerup) && _func_0107(var_2.a_disable_grab_for_powerup) && scripts\engine\utility::is_equal(var_2.a_disable_grab_for_powerup[self._id_BB0E], 1)) {
        continue;
      }
      var_6 = 0;

      if(scripts\engine\utility::is_equal(var_5._id_7D0E, self)) {
        var_5._id_7D0E = undefined;
        var_6 = 1;
      }

      if(isalive(var_5) && (distancesquared(var_5.origin, self.origin) < var_1 || var_6)) {
        if(isDefined(level._id_0C99)) {
          if(!self[[level._id_0C99]](var_2)) {
            continue;
          }
        }

        if(isDefined(level._id_0BAF) && isDefined(level._id_0BAF[self._id_BB0E]) && isDefined(level._id_0BAF[self._id_BB0E]._id_7113)) {
          var_7 = self[[level._id_0BAF[self._id_BB0E]._id_7113]](var_2);

          if(istrue(var_7)) {
            continue;
          }
        } else {
          switch (self._id_BB0E) {
            case "teller_withdrawl":
              level thread _id_F042(self, var_2);
              break;
            default:
              if(isDefined(level._id_0DDD)) {
                level thread[[level._id_0DDD]](self, var_2);
              } else {}

              break;
          }
        }

        if(_id_DA79(self._id_BB0E) && isPlayer(var_2)) {}

        if(isDefined(level._id_BB02)) {
          self thread[[level._id_BB02]]();
        } else {
          var_8 = _id_64BC();
        }

        if(istrue(self._id_E86B)) {
          level notify("monkey_see_monkey_dont_achieved");
        }

        if(isDefined(self._id_7115)) {
          level notify(self._id_7115);
        }

        var_9 = level._id_11040[self._id_BB0E];

        if(isDefined(var_9._id_E9E9)) {
          if(_func_0205(var_9._id_E9E9._id_E9E8)) {
            var_2 playsoundtoplayer(var_9._id_E9E9._id_E9E8, var_2);
          }

          if(_func_0205(var_9._id_E9E9._id_E9E7)) {
            var_2 playsoundtoteam(var_9._id_E9E9._id_E9E7, var_2.team, var_2);
          }
        } else {
          var_10 = 0;

          if(isDefined(level._id_5D4E)) {
            var_10 = self[[level._id_5D4E]](self._id_BB0E);
          }
        }

        self._id_37F0 = 1;
        self._id_BACB = var_2;
        wait 0.1;

        if(!isDefined(self)) {
          break;
        }

        self stoploopsound();
        self hide();

        if(self._id_BB0E != "fire_sale") {
          if(isDefined(self._id_BACB)) {
            if(isDefined(level._id_BB0C)) {
              level thread[[level._id_BB0C]](self);
              return;
            } else if(isDefined(level._id_BB21)) {
              var_11 = [[level._id_BB21]]();

              if(!var_11) {
                thread _id_BAF9();
                self notify("powerup_grabbed", var_2);
                return;
              }
            }
          }
        }

        thread _id_BAF9();
        self notify("powerup_grabbed", var_2);
      }
    }

    wait 0.1;
  }
}

_id_BB0F(var_0) {
  self setclientomnvar("ui_powerup_splash", var_0);
}

_id_66BD(var_0, var_1) {
  var_2 = scripts\cp\utility::_id_63ED(var_0);

  if(istrue(level._id_2034) || istrue(var_1)) {
    return 0.1;
  }

  if(!isDefined(var_2)) {
    return 1.5;
  }

  var_3 = distance(var_2.origin, var_0);

  if(var_3 > 128) {
    return 0.1;
  } else if(var_3 < 8) {
    return 1.5;
  }

  var_4 = _func_0439(8, 128, 1.5, 0, var_3);
  return var_4;
}

_id_BB1C(var_0, var_1, var_2) {
  self endon("powerup_grabbed");

  if(isDefined(level._id_BB0B)) {
    self thread[[level._id_BB0B]]();
  } else {
    var_3 = _id_64BC();
  }

  var_4 = _id_66BD(var_0, var_2);
  wait(var_4);
  self setModel(var_1._id_9FCB);

  foreach(var_6 in level.players) {
    if(distancesquared(var_0, var_6.origin) < 40000) {
      var_6 _meth_8282(var_0);
    }
  }
}

_id_63FE(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(var_2)) {
      var_2 = var_0[var_4];
      var_3 = distancesquared(var_2.origin, var_1);
      continue;
    }

    if(distancesquared(var_0[var_4].origin, var_1) < var_3) {
      var_2 = var_0[var_4];
      var_3 = distancesquared(var_0[var_4].origin, var_1);
    }
  }

  return var_2;
}

_id_BB20(var_0) {
  self endon("disconnect");

  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(level._id_BB21)) {
    if(![[level._id_BB21]]()) {
      return;
    }
  }

  if(var_0 == "tesla") {
    wait(randomfloatrange(3.5, 4.5));
  } else {
    wait 0.5;
  }

  if(isDefined(level._id_425C)) {
    level[[level._id_425C]](self, var_0);
  }
}

_id_BAFB(var_0, var_1) {
  var_1 = scripts\cp\utility::_id_459B(var_1, 1);

  if(isDefined(level._id_11040[var_0])) {
    level._id_11040[var_0]._id_202C = var_1;
  }
}

_id_BAFA(var_0, var_1) {
  var_1 = scripts\cp\utility::_id_459B(var_1, 1);

  if(isDefined(level._id_11040[var_0])) {
    level._id_11040[var_0]._id_202B = var_1;
  }
}

_id_BB18(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level._id_11040[var_0])) {
    level._id_11040[var_0]._id_E9E9 = spawnStruct();
    level._id_11040[var_0]._id_E9E9._id_E9EA = var_1;
    level._id_11040[var_0]._id_E9E9._id_E9E4 = var_2;
    level._id_11040[var_0]._id_E9E9._id_E9E8 = var_3;
    level._id_11040[var_0]._id_E9E9._id_E9E7 = var_4;
    level._id_11040[var_0]._id_E9E9._id_E9EB = var_5;
  }
}

_id_BB23() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level._id_BB01)) {
    self thread[[level._id_BB01]]();
    return;
  }

  var_0 = _id_64BC();
  thread _id_BB00(var_0);
}

_id_64BC() {
  if(scripts\engine\utility::is_equal(self.override_powerup_fx, 1)) {
    return 5;
  } else if(self._id_AB2D) {
    return 2;
  } else if(self._id_190E) {
    return 4;
  } else if(self._id_1102B) {
    return 3;
  } else {
    return 1;
  }
}

_id_BB22() {
  self endon("powerup_grabbed");
  self endon("powerup_timedout");

  if(isDefined(level._id_11040[self._id_BB0E]) && istrue(level._id_11040[self._id_BB0E]._id_202C)) {
    return;
  }
  thread _id_BB23();

  while(isDefined(self)) {
    var_0 = randomfloatrange(2.5, 5);
    var_1 = randomint(360);

    if(var_1 > 300) {
      var_1 = 300;
    } else if(var_1 < 60) {
      var_1 = 60;
    }

    var_1 = self.angles[1] + var_1;
    var_2 = (-60 + randomint(120), var_1, -45 + randomint(90));
    self rotateto(var_2, var_0, var_0 * 0.5, var_0 * 0.5);

    if(isDefined(self._id_10F48)) {
      self._id_10F48 rotateto(var_2, var_0, var_0 * 0.5, var_0 * 0.5);
    }

    wait(randomfloat(var_0 - 0.1));
  }
}

_id_BB06() {
  if(isDefined(self)) {
    self hide();

    if(isDefined(self._id_10F48)) {
      self._id_10F48 hide();
    }
  }
}

_id_BB1B() {
  if(isDefined(self)) {
    self show();

    if(isDefined(self._id_10F48)) {
      self._id_10F48 show();
    }

    if(isDefined(self._id_BB10)) {
      return;
    }
  }
}

_id_BB1F() {
  if(isDefined(level._id_0C9B) && !isDefined(self._id_BB1E)) {
    self thread[[level._id_0C9B]]();
    return;
  }

  self endon("powerup_grabbed");
  self endon("death");
  self endon("powerup_reset");
  _id_BB1B();
  var_0 = 15;

  if(isDefined(level._id_0C9A)) {
    var_1 = [[level._id_0C9A]](self);

    if(var_1 == 0) {
      return;
    }
    var_0 = var_1;
  }

  wait(var_0);
  _id_788D(::_id_BB06, ::_id_BB1B);
  self notify("powerup_timedout");
  _id_BAF8();
}

_id_788D(var_0, var_1) {
  for(var_2 = 0; var_2 < 40; var_2++) {
    if(var_2 % 2) {
      self[[var_0]]();
    } else {
      self[[var_1]]();
    }

    if(var_2 < 15) {
      wait 0.5;
      continue;
    }

    if(var_2 < 25) {
      wait 0.25;
      continue;
    }

    wait 0.1;
  }
}

_id_BAF8() {
  if(isDefined(self)) {
    scripts\engine\utility::array_remove(level._id_0F28, self);

    if(isDefined(self._id_10F48)) {
      self._id_10F48 delete();
    }

    self delete();
  }
}

_id_BAF9(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  } else {
    wait 0.01;
  }

  _id_BAF8();
}

_id_6655() {
  return "wpn_t9_zm_perk_can_powerup";
}

_id_860D() {
  if(istrue(scripts\cp\utility::_id_6875("zombie_insta_kill", self.team)) || istrue(scripts\cp\utility::_id_6874("zombie_insta_kill")) || istrue(self._id_B01C)) {
    return 1;
  }

  return 0;
}

_id_85AC() {
  if(istrue(scripts\cp\utility::_id_6875("zombie_powerup_double_points_on", self.team)) || istrue(scripts\cp\utility::_id_6875("zombie_powerup_double_points_on"))) {
    return 1;
  }

  return 0;
}

_id_6515(var_0, var_1, var_2, var_3, var_4) {
  if(!("head" == var_2 || "helmet" == var_2 || "neck" == var_2) && istrue(level._id_761E)) {
    return var_4;
  }

  if(isDefined(var_0) && isalive(var_0) && isDefined(level._id_3459)) {
    if(!self[[level._id_3459]](var_0)) {
      return var_4;
    }

    self.health = 1;
    return self.health + self.maxhealth;
  }

  if(isDefined(var_0) && isalive(var_0) && var_0 _id_860D()) {
    if(_id_06FE::is_zm_special()) {
      var_4 = var_4 * 5;
    } else if(_id_06FE::is_zm_elite()) {
      var_4 = var_4 * 2.5;
    } else if(_id_06FE::is_zm_boss()) {
      var_4 = var_4 * 2.5;
    }

    if(isDefined(self._id_82F9)) {
      var_5 = self[[self._id_82F9]](var_0, var_1, var_2);

      if(istrue(var_5)) {
        return var_4;
      }
    }

    if(_id_06FE::is_zm_normal()) {
      self.health = 1;
      return self.health + self.maxhealth;
    } else
      return var_4;
  }

  return var_4;
}

_id_82FA(var_0, var_1, var_2) {
  return 1;
}

_id_B9A8(var_0, var_1) {
  self endon("disconnect");

  if(scripts\cp\utility::_id_6875("zombie_powerup_double_points_on", var_1)) {
    scripts\cp\utility::_id_D45A("zombie_powerup_double_points_time", var_1, 30);
    return;
  }

  scripts\cp\utility::_id_D45A("zombie_powerup_double_points_on", var_1, 1);
  level thread _id_F1F2(var_1);
}

_id_F1F2(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 playLoopSound("zmb_double_point_loop");

  while(scripts\cp\utility::_id_6875("zombie_powerup_double_points_time", var_0) >= 0) {
    waitframe();
    scripts\cp\utility::_id_D45A("zombie_powerup_double_points_time", var_0, scripts\cp\utility::_id_6875("zombie_powerup_double_points_time", var_0) - 0.05);
  }

  scripts\cp\utility::_id_D45A("zombie_powerup_double_points_on", var_0, 0);
  var_2 = scripts\cp\utility::_id_6C5C(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] playSound("zmb_points_loop_off");
  }

  var_1 stoploopsound(2);
  scripts\cp\utility::_id_D45A("zombie_powerup_double_points_time", var_0, 30);
  var_1 delete();
}

_id_48E4() {
  wait 1.0;
}

_id_3464(var_0) {
  if(level scripts\engine\utility::_id_5C00("ape_round")) {
    return 0;
  }

  return 0;
}

_id_F0B4() {
  var_0 = scripts\cp\utility::_id_6C5C();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1]._id_1105D["zombie_powerup_tesla_on"]) {
      return 1;
    }
  }

  return 0;
}

_id_BD01(var_0, var_1) {}

_id_C1D0(var_0, var_1) {
  if(!isDefined(level._id_0B1E)) {
    level._id_0B1E = [];
  }

  var_0._id_0C98 = var_1;
  level._id_0B1E[level._id_0B1E.size] = var_0;
}

_id_6030() {
  return 0;
}

_id_602D() {
  return 1;
}

_id_66BE(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = [];

    foreach(var_4 in level._id_0F28) {
      if(distancesquared(var_0, var_4.origin) < var_1 * var_1) {
        var_2[var_2.size] = var_4;
      }
    }

    return var_2;
  }

  return level._id_0F28;
}

_id_DA79(var_0) {
  switch (var_0) {
    case "blue_monkey":
    case "teller_withdrawl":
    case "small_ammo":
    case "bonus_points_player_shared":
      return 0;
  }

  if(isDefined(level._id_11053) && isDefined(level._id_11053[var_0]) && level._id_11053[var_0]) {
    return 0;
  }

  return 1;
}

_id_F042(var_0, var_1) {}

_id_4C75(var_0) {
  if(isDefined(level._id_11040[var_0]) && istrue(level._id_11040[var_0]._id_AB2D)) {
    return 1;
  }

  return 0;
}

_id_DC5C(var_0, var_1) {
  var_1 = scripts\cp\utility::_id_459B(var_1, 30);
  self endon("disconnect");
  var_2 = "zombie_powerup_" + var_0 + "_on";
  var_3 = "zombie_powerup_" + var_0 + "_time";
  scripts\cp\utility::_id_D459(var_3, var_1);

  if(istrue(scripts\cp\utility::_id_6874(var_2))) {
    return;
  }
  scripts\cp\utility::_id_D459(var_2, 1);
  thread _id_F1F4(var_0, var_1);
  level notify("pump_powerup_hud");
}

_id_F1F4(var_0, var_1) {
  var_1 = scripts\cp\utility::_id_459B(var_1, 30);
  self endon("disconnect");
  var_2 = "zombie_powerup_" + var_0 + "_on";
  var_3 = "zombie_powerup_" + var_0 + "_time";
  var_4 = "zmb_powerup_" + var_0 + "_timeout";

  while(scripts\cp\utility::_id_6874(var_3) >= 0) {
    waitframe();
    scripts\cp\utility::_id_D459(var_3, scripts\cp\utility::_id_6874(var_3) - scripts\cp\utility::_id_A2B8(50));
  }

  scripts\cp\utility::_id_D459(var_2, 0);
  self playsoundtoplayer(var_4, self);
  scripts\cp\utility::_id_D459(var_3, var_1);
}

_id_DC5B(var_0, var_1, var_2) {
  var_2 = scripts\cp\utility::_id_459B(var_2, 30);
  self endon("disconnect");
  var_3 = "zombie_powerup_" + var_1 + "_on";
  var_4 = "zombie_powerup_" + var_1 + "_time";
  var_5 = var_4 + "_tick";
  scripts\cp\utility::_id_D45A(var_5, var_0, var_2);
  scripts\cp\utility::_id_D45A(var_4, var_0, var_2);

  if(scripts\cp\utility::_id_6875(var_3, var_0)) {
    return;
  }
  scripts\cp\utility::_id_D45A(var_3, var_0, 1);
  level thread _id_F1F3(var_0, var_1, var_2);
  level notify("pump_powerup_hud");
}

_id_F1F3(var_0, var_1, var_2) {
  var_2 = scripts\cp\utility::_id_459B(var_2, 30);
  var_3 = "zombie_powerup_" + var_1 + "_on";
  var_4 = "zombie_powerup_" + var_1 + "_time";
  var_5 = "zmb_powerup_" + var_1 + "_timeout";

  while(scripts\cp\utility::_id_6875(var_4, var_0) >= 0) {
    waitframe();
    scripts\cp\utility::_id_D45A(var_4, var_0, scripts\cp\utility::_id_6875(var_4, var_0) - 0.05);
  }

  scripts\cp\utility::_id_D45A(var_3, var_0, 0);
  scripts\cp\utility::_id_D45A(var_4, var_0, var_2);
}

_id_C20E(var_0, var_1, var_2) {
  _id_0CB1(var_0);

  if(isDefined(var_1)) {
    if(!isDefined(level._id_0BAF[var_0]._id_7113)) {
      level._id_0BAF[var_0]._id_7113 = var_1;
    }
  }

  if(isDefined(var_2)) {
    if(!isDefined(level._id_0BAF[var_0]._id_D80E)) {
      level._id_0BAF[var_0]._id_D80E = var_2;
    }
  }
}

_id_0CB1(var_0) {
  if(!isDefined(level._id_0BAF)) {
    level._id_0BAF = [];
  }

  if(!isDefined(level._id_0BAF[var_0])) {
    level._id_0BAF[var_0] = spawnStruct();
    _id_7D9C(var_0);
  }
}

_id_C20F(var_0, var_1) {
  _id_0CB1(var_0);

  if(isDefined(var_1)) {
    if(!isDefined(level._id_0BAF[var_0]._id_10CF0)) {
      level._id_0BAF[var_0]._id_10CF0 = var_1;
    }
  }
}

_id_BB00(var_0) {
  _id_E8CE();

  switch (var_0) {
    case 1:
      var_1 = scripts\engine\utility::getfx("powerup_on");
      break;
    case 2:
      var_1 = scripts\engine\utility::getfx("powerup_on_solo");
      break;
    case 3:
      var_1 = level._effect["powerup_on_red"];
      break;
    case 4:
      var_1 = level._effect["powerup_on_caution"];
      break;
    case 5:
      var_1 = scripts\engine\utility::getfx(self.override_powerup_on_fx);
      break;
    default:
      return;
  }

  _id_B2A2(var_1);
}

_id_BB0A(var_0) {
  _id_E8CE();

  switch (var_0) {
    case 1:
      var_1 = scripts\engine\utility::getfx("powerup_intro");
      break;
    case 2:
      var_1 = scripts\engine\utility::getfx("powerup_intro_solo");
      break;
    case 3:
      var_1 = level._effect["powerup_intro_red"];
      break;
    case 4:
      var_1 = level._effect["powerup_intro_caution"];
    case 5:
      var_1 = scripts\engine\utility::getfx(self.override_powerup_intro_fx);
      break;
    default:
      return;
  }

  _id_B2A2(var_1, 1);
}

_id_BB05(var_0) {
  switch (var_0) {
    case 1:
      var_1 = scripts\engine\utility::getfx("powerup_grabbed");
      break;
    case 2:
      var_1 = scripts\engine\utility::getfx("powerup_grabbed_solo");
      break;
    case 3:
      var_1 = level._effect["powerup_grabbed_red"];
      break;
    case 4:
      var_1 = level._effect["powerup_grabbed_caution"];
      break;
    case 5:
      var_1 = scripts\engine\utility::getfx(self.override_powerup_grabbed_fx);
      break;
    default:
      return;
  }

  playFX(var_1, self.origin);
}

_id_E8CE() {
  if(isDefined(self._id_A384)) {
    stopFXOnTag(self._id_A384, self, "tag_origin");
    self._id_A384 = undefined;
  }

  if(isDefined(self._id_A386)) {
    self stoploopsound(self._id_A386);
    self._id_A386 = undefined;
  }
}

_id_B2A2(var_0, var_1) {
  var_1 = scripts\cp\utility::_id_459B(var_1, 0);

  if(!isDefined(self)) {
    return;
  }
  if(var_1 && !isDefined(self._id_A386)) {}

  self._id_A384 = playFXOnTag(var_0, self, "tag_origin");
}

_id_AA4A(var_0) {
  if(istrue(self._id_A72E)) {
    thread _id_11020(var_0._id_04F6);
  } else {
    var_1 = undefined;

    if(isDefined(var_0._id_50FF)) {
      if(isDefined(var_0._id_50FF.owner)) {
        var_1 = var_0._id_50FF.owner;
      } else {
        var_1 = var_0._id_50FF;
      }
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      thread _id_11020(var_0._id_04F6);
    }
  }
}