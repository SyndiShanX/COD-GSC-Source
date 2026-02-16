/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1919.gsc
*************************************************/

_id_7FE3() {
  _id_C09E();
  _id_8071();
  _id_8072();
  _id_8070();
  level thread _id_C5AE();
  level thread _id_34D3();
  level thread _id_BB27();
}

_id_BB27() {
  var_0 = getarraykeys(level._id_0F27);

  for(;;) {
    level waittill("connected", var_1);

    foreach(var_3 in var_0) {
      if(istrue(level._id_0F27[var_3])) {
        if(isDefined(level._id_BACA[var_3])) {
          thread[[level._id_BACA[var_3]]](var_1);
        }
      }
    }
  }
}

_id_8071() {
  level._effect["pickup"] = loadfx("vfx/iw7/core/zombie/powerups/vfx_zom_powerup_pickup.vfx");
  level._effect["pickup_fnfmod"] = loadfx("vfx/iw7/core/zombie/powerups/vfx_zd_powerup_pickup.vfx");
  level._effect["big_explo"] = loadfx("vfx/iw7/_requests/coop/vfx_nuke_explosion_01.vfx");
}

_id_8070() {
  if(!isDefined(level._id_0F27)) {
    level._id_0F27 = [];
  }

  level._id_0F27["instakill"] = 0;
  level._id_0F27["double_money"] = 0;
  level._id_0F27["fire_sale"] = 0;
  level._id_0F27["infinite_ammo"] = 0;
  level._id_0F27["infinite_grenades"] = 0;
  level._id_BACA["instakill"] = ::_id_19BF;
  level._id_BACA["double_money"] = ::_id_19B7;
  level._id_BACA["infinite_ammo"] = ::_id_19BD;
  level._id_BACA["infinite_grenades"] = ::_id_19BE;
  level._id_BACA["fire_sale"] = ::_id_19BA;

  if(!isDefined(level._id_BAC9)) {
    level._id_BAC9 = 500;
  }

  if(!isDefined(level._id_BAFE)) {
    level._id_BAFE = randomintrange(2000, 3000);
  }

  if(!isDefined(level._id_BAFF)) {
    level._id_BAFF = 5;
  }

  if(!isDefined(level._id_BAFD)) {
    level._id_BAFD = 0;
  }

  if(!isDefined(level._id_CBF2)) {
    level._id_CBF2 = level._id_BAFE;
  }
}

_id_34D3() {
  level waittill("regular_wave_starting");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!istrue(var_1._id_34F8)) {
        var_1._id_34F8 = 1;
        level._id_CBF2 = level._id_CBF2 + level._id_BAC9;

        if(var_1 scripts\cp\utility::_id_8580("more_power_up_drops")) {
          level._id_BAFE = level._id_BAFE - 5;
        }
      }
    }

    level waittill("player_spawned");
  }
}

_id_8072() {
  scripts\engine\utility::_id_5C11("zombie_drop_powerups");
  scripts\engine\utility::_id_5C11("fire_sale");
  scripts\engine\utility::_id_5C11("canFiresale");
  scripts\engine\utility::_id_5C11("explosive_armor");
  scripts\engine\utility::_id_5C11("force_drop_max_ammo");
}

_id_C5AE() {
  level endon("game_ended");

  for(;;) {
    level waittill("spawn_wave_done");
    level._id_BAFD = 0;
  }
}

_id_C09E() {
  level._id_985A = [];
  level._id_9856 = [];
  level._id_9858 = [];
  level._id_9859 = [];

  if(isDefined(level._id_BACC)) {
    var_0 = level._id_BACC;
  } else {
    var_0 = "cp/zombies/zombie_loot.csv";
  }

  for(var_1 = 1; var_1 <= 100; var_1++) {
    var_2 = _id_EC72(var_0, var_1, 2);

    if(scripts\cp\utility::_id_85B5(var_2)) {
      break;
    }

    var_3 = [];
    var_3["weights"] = _id_3C7E(_id_EC72(var_0, var_1, 3));
    var_3["weight_sum"] = _id_685F(var_3["weights"]);
    var_4 = strtok(_id_EC72(var_0, var_1, 4), " ");
    var_3["contents"] = [];

    foreach(var_8, var_6 in var_4) {
      var_7 = [];
      var_7["value"] = var_6;
      var_7["last_time"] = 0;
      var_3["contents"][var_8] = var_7;
    }

    level._id_985A[var_2] = var_3;
  }

  for(var_1 = 101; var_1 <= 150; var_1++) {
    var_9 = _id_EC72(var_0, var_1, 2);

    if(scripts\cp\utility::_id_85B5(var_9)) {
      break;
    }

    var_10 = _id_EC72(var_0, var_1, 3);

    if(!isDefined(level._effect[var_10])) {
      level._effect[var_10] = loadfx(var_10);
    }

    level._id_9856[var_9] = var_10;
    var_11 = _id_EC72(var_0, var_1, 1);
    level._id_9859[var_9] = var_11;
  }

  for(var_1 = 101; var_1 <= 150; var_1++) {
    var_9 = _id_EC72(var_0, var_1, 2);

    if(scripts\cp\utility::_id_85B5(var_9)) {
      break;
    }

    var_12 = _id_EC72(var_0, var_1, 4);

    if(scripts\cp\utility::_id_85B5(var_12)) {
      continue;
    }
    level._id_9858[var_9] = var_12;
  }
}

_id_3C7E(var_0) {
  var_0 = strtok(var_0, " ");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = float(var_0[var_2]);
  }

  return var_1;
}

_id_685F(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3;
  }

  return var_1;
}

_id_4FF0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_2 == "none") {
    return 0;
  }

  var_0 = _func_02AB(var_0);
  var_6 = istrue(var_3);
  var_7 = _id_3F3B(var_0);

  if(!isDefined(var_7)) {
    return 0;
  }

  var_7._id_5D7F = 0;

  foreach(var_9 in level.players) {
    if(var_9 scripts\cp\utility::_id_8580("temporal_increase")) {
      var_7._id_5D7F = 1;
      break;
    }
  }

  var_7._id_3BE3 = var_2;
  var_11 = _id_6575(var_7);
  var_7._id_6095 = var_11;
  var_12 = (0, 0, 0);

  if(isDefined(var_1) && var_1 scripts\cp\utility::_id_8580("more_power_up_drops")) {
    var_1 scripts\cp\utility::_id_A689("more_power_up_drops");
  }

  if(isDefined(var_4)) {
    level._id_BAFE = level._id_BAFE * 1.14;
    level._id_CBF2 = var_4 + level._id_BAFE;
    level._id_BAFD++;
    level._id_8F1C = gettime();
  }

  if(!scripts\cp\utility::_id_85FB(var_0) && _id_9854()) {
    var_0 = _id_A230(var_7);
    var_7 thread _id_9857();
    var_6 = 1;
  } else {
    var_0 = var_0 + (0, 0, 50);

    if(istrue(var_7._id_5D7F)) {
      var_7._id_5D81 = spawnfx(level._effect["powerup_additive_fx"], var_0 + (0, 0, -10));
    }

    var_7._id_605B = spawnfx(scripts\engine\utility::getfx(var_11), var_0);

    if(isDefined(var_12)) {
      var_7._id_605B.angles = var_12;
    }
  }

  if(isDefined(var_1)) {
    var_7.owner = var_1;
  } else {
    var_7.owner = level.players[0];
  }

  var_7 notify("activate");

  if(!var_6) {
    if(istrue(var_7._id_5D7F)) {
      triggerfx(var_7._id_5D81);
      var_7._id_5D81 _meth_8322();
    }

    triggerfx(var_7._id_605B);
    var_7._id_605B _meth_8322();
    var_7 thread _id_9857();
  }

  var_7 thread _id_985E(var_7);
  var_7 thread _id_9861(var_7);
  var_13 = _id_650E(var_2);

  if(isDefined(var_13) && istrue(var_5)) {
    _id_FBB6(var_13);
  }

  level thread _id_389B(var_7);
  return 1;
}

_id_9854() {
  if(istrue(level._id_4A1E)) {
    return 0;
  }

  return 1;
}

_id_A230(var_0) {
  level endon("game_ended");
  var_0._id_605B = spawn("script_model", var_0.origin + (0, 0, 50));
  var_0._id_605B setModel("tag_origin");
  wait 0.1;

  if(istrue(var_0._id_5D7F)) {
    playFXOnTag(level._effect["powerup_additive_fx"], var_0._id_605B, "tag_origin");
  }

  playFXOnTag(scripts\engine\utility::getfx(var_0._id_6095), var_0._id_605B, "tag_origin");
  var_1 = scripts\engine\utility::_id_6969(var_0.origin, level.players);
  var_2 = distance(var_0.origin, var_1.origin);
  var_3 = 300;
  var_4 = var_2 / var_3;

  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  var_5 = _func_02AB(scripts\engine\utility::_id_5000(var_1.origin, 32, -100)) + (0, 0, 50);
  var_0._id_605B moveto(var_5, var_4);
  var_0._id_605B waittill("movedone");
  var_0 dontinterpolate();
  var_0.origin = var_0._id_605B.origin;
  return var_0.origin;
}

_id_389B(var_0) {
  var_0 scripts\engine\utility::_id_108A7(_id_6577(), "picked_up");

  if(istrue(var_0._id_5D7F)) {
    playFX(level._effect["pickup_fnfmod"], var_0.origin + (0, 0, 50));
  } else {
    playFX(level._effect["pickup"], var_0.origin + (0, 0, 50));
  }

  if(isDefined(var_0._id_605B)) {
    var_0._id_605B delete();
  }

  if(isDefined(var_0._id_5D81)) {
    var_0._id_5D81 delete();
  }

  wait 0.5;
  var_0._id_5D7F = 0;

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_0 notify("loot_deleted");
}

_id_9857() {
  self endon("death");
  self endon("picked_up");
  self endon("loot_deleted");
  var_0 = _id_6577() - 5;
  wait(var_0);

  for(var_1 = 0; var_1 < 5; var_1++) {
    wait 0.5;
    self._id_605B delete();
    wait 0.5;
    var_2 = _id_6575(self);
    self._id_605B = spawnfx(scripts\engine\utility::getfx(var_2), self.origin + (0, 0, 50));
    self._id_605B.angles = (0, 0, 0);
    wait 0.1;
    triggerfx(self._id_605B);
    self._id_605B _meth_8322();
  }

  if(isDefined(self) && isDefined(self._id_605B)) {
    self._id_605B delete();
  }

  if(isDefined(self) && isDefined(self._id_5D81)) {
    self._id_5D81 delete();
  }
}

_id_6577() {
  if(isDefined(level._id_9862)) {
    return level._id_9862;
  }

  return 30;
}

_id_650E(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "kill_generic_zombie";
  }

  var_2 = 0;
  var_3 = level._id_985A[var_1]["contents"].size;

  for(var_2 = 0; var_2 < var_3; var_2++) {
    if(level._id_985A[var_1]["contents"][var_2]["value"] == var_0) {
      return var_2;
    }
  }

  return 0;
}

_id_A0D2(var_0) {
  self endon("loot_deleted");
  level endon("game_ended");

  while(isDefined(var_0) && isDefined(var_0.health) && var_0.health >= 1) {
    level waittill("attack_hit", var_1, var_2);

    if(var_0 != var_2) {
      continue;
    }
    var_0.health = var_0.health - 50;
  }

  self notify("picked_up");
}

_id_3F3B(var_0) {
  var_1 = scripts\engine\utility::_id_5000(var_0, 32, -64);
  var_2 = spawn("trigger_radius", var_1, 0, 32, 76);
  return var_2;
}

_id_6575(var_0) {
  if(!isDefined(level._id_9856[var_0._id_3BE3])) {
    return "vfx_loot_ace_hearts";
  }

  return level._id_9856[var_0._id_3BE3];
}

_id_9861(var_0) {
  var_0 endon("loot_deleted");
  var_1 = var_0 scripts\engine\utility::_id_108A7(_id_6577(), "picked_up");

  if(var_1 == "picked_up") {
    thread _id_BD53(var_0.owner, var_0._id_3BE3, var_0, 1);
  }
}

_id_985E(var_0) {
  var_0 endon("loot_deleted");
  wait 0.2;

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      wait 0.25;
      continue;
    }

    var_0 notify("picked_up");
    var_1 playlocalsound("zmb_powerup_activate");
    break;
  }
}

_id_BD53(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  var_1 = strtok(var_1, "_");
  var_5 = var_1[0];
  var_6 = var_1[1];
  var_7 = gettime();
  var_8 = int(level._id_9859[var_4]);
  var_9 = 1;
  _id_4B6C(0);

  switch (var_5) {
    case "power":
      level thread[[level._id_BAB8]](var_4, var_7);
      break;
    case "fire":
      if(isDefined(level._id_5B50)) {
        if(isDefined(var_0._id_F07B)) {
          var_6 = int(var_6) * var_0._id_F07B;
        }

        level thread _id_076F::_id_F72D("powerup_firesale", "zmb_powerup_vo");
        var_2 playSound("zmb_powerup_fire_sale");
        level thread[[level._id_5B50]](var_4, int(var_6), var_7);
      }

      break;
    case "grenade":
      if(isDefined(var_0._id_F07B)) {
        var_6 = int(var_6) * var_0._id_F07B;
      }

      level thread _id_076F::_id_F72D("powerup_infinitegrenades", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_infinite_grenades");
      level thread _id_6EF8(var_4, int(var_6), var_7);
      break;
    case "infinite":
      if(isDefined(var_0._id_F07B)) {
        var_6 = int(var_6) * var_0._id_F07B;
      }

      level thread _id_076F::_id_F72D("powerup_infiniteammo", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_infinite_ammo");
      level thread _id_6EF7(var_4, int(var_6), var_7);
      break;
    case "upgrade":
      if(isDefined(level._id_FD9A)) {
        var_2 playSound("zmb_powerup_wpn_upgrade");
        level thread[[level._id_FD9A]]();
      }

      break;
    case "kill":
      if(istrue(level._id_5E87)) {
        var_9 = 0;
        level thread _id_8D14(var_2, int(var_6));
      } else {
        level thread _id_076F::_id_F72D("powerup_nuke", "zmb_powerup_vo");
        var_2 playSound("zmb_powerup_nuke");
        level thread _id_8D14(var_2, int(var_6));
      }

      break;
    case "cash":
      level thread _id_076F::_id_F72D("powerup_doublemoney", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_dbl_cash");
      level thread _id_CB7D(var_0, var_4, int(var_6), var_7);
      break;
    case "instakill":
      if(isDefined(var_0._id_F07B)) {
        var_6 = int(var_6) * var_0._id_F07B;
      }

      level thread _id_076F::_id_F72D("powerup_instakill", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_instakill");
      level thread _id_0EB6(var_0, var_4, int(var_6), var_7);
      break;
    case "ammo":
      level thread _id_076F::_id_F72D("powerup_maxammo", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_max_ammo");
      level notify("pick_up_max_ammo");
      level thread _id_6EBF();
      break;
    case "board":
      if(isDefined(level._id_C0E2)) {
        level thread _id_076F::_id_F72D("powerup_carpenter", "zmb_powerup_vo");
        var_2 playSound("zmb_powerup_reboard_windows");
        level thread[[level._id_C0E2]](var_0);
      }

      break;
    default:
  }

  if(istrue(var_3)) {
    var_0 _id_0741::_id_BD77("mt_powerup_grabs");
  }

  var_0 thread scripts\cp\cp_hud_message::_id_F8BA("powerups");
  waitframe();

  if(var_9) {
    _id_4B6C(var_8);
  }
}

_id_6574(var_0, var_1, var_2) {
  if(!isDefined(level._id_985A[var_0])) {
    return undefined;
  }

  var_3 = gettime();
  var_4 = _id_3593(var_0, var_3, var_1);
  return var_4;
}

_id_3593(var_0, var_1, var_2) {
  var_3 = level._id_10C9F;
  var_4 = level._id_985A[var_0]["contents"].size;
  level._id_15A9 = [];

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = level._id_985A[var_0]["contents"][var_5]["value"];
    var_7 = level._id_985A[var_0]["contents"][var_5]["last_time"];
    var_6 = strtok(var_6, "_");
    var_8 = var_6[0];

    switch (var_8) {
      case "fire":
        if((istrue(level._id_BAC8) || scripts\engine\utility::_id_5C00("canFiresale") && var_1 - var_7 >= 180000) && var_3 >= 5) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      case "explosive":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 300000) && var_3 >= 8) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      case "infinite":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 180000) && var_3 >= 5) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      case "ammo":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 180000) && var_3 >= 2) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      case "grenade":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 60000) && var_3 >= 1) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      case "upgrade":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 600000) && var_3 >= 15) {
          if(!scripts\cp\utility::_id_857B()) {
            level._id_15A9[level._id_15A9.size] = var_5;
          }

          break;
        } else
          break;
      case "kill":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 180000) && var_3 >= 1) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      case "cash":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 90000) && var_3 >= 1) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      case "instakill":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 90000) && var_3 >= 1) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      case "board":
        if((istrue(level._id_BAC8) || var_1 - var_7 >= 45000) && var_3 >= 1) {
          level._id_15A9[level._id_15A9.size] = var_5;
          break;
        } else
          break;
      default:
        break;
    }
  }

  if(level._id_15A9.size < 1) {
    return undefined;
  }

  var_9 = level._id_15A9[_id_6576(var_0)];
  var_10 = level._id_985A[var_0]["contents"][var_9]["value"];
  level._id_15A9 = undefined;
  level._id_8F3A = var_9;
  return var_10;
}

_id_6576(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_15A9.size; var_2++) {
    var_3 = int(level._id_15A9[var_2]);
    var_1 = var_1 + level._id_985A[var_0]["weights"][var_3];
  }

  var_4 = randomfloat(var_1);
  var_5 = 0;

  for(var_2 = 0; var_2 < level._id_15A9.size; var_2++) {
    var_3 = int(level._id_15A9[var_2]);
    var_5 = var_5 + level._id_985A[var_0]["weights"][var_3];

    if(var_5 >= var_4) {
      return var_2;
    }
  }
}

_id_EC72(var_0, var_1, var_2) {
  return _func_0222(var_0, 0, var_1, var_2);
}

_id_FB63(var_0, var_1, var_2) {
  if(!scripts\cp\utility::_id_3D1D("loot")) {
    return;
  }
  if(!isDefined(level._id_9855)) {
    return;
  }
  if(!scripts\engine\utility::_id_5C00("zombie_drop_powerups")) {
    return;
  }
  if(!isPlayer(var_2)) {
    return;
  }
  var_4 = istrue(level._id_BAC8);

  if(level._id_BAFD >= level._id_BAFF && !var_4) {
    return;
  }
  if(!scripts\cp\utility::_id_85FB(var_1)) {
    return;
  }
  if(istrue(self._id_86D9)) {
    return;
  }
  if(isDefined(level._id_84F7)) {
    if(!scripts\cp\cp_weapon::_id_88D5(var_1, level._id_84F7, undefined, undefined, 1)) {
      return;
    }
  } else if(!scripts\cp\cp_weapon::_id_88D5(var_1, undefined, undefined, undefined, 1)) {
    return;
  }
  var_5 = level.players;
  var_3 = undefined;
  var_6 = 0;

  if(var_2 scripts\cp\utility::_id_8580("more_power_up_drops")) {
    var_7 = level._id_CBF2 * 0.7;
  } else {
    var_7 = level._id_CBF2;
  }

  for(var_8 = 0; var_8 < var_5.size; var_8++) {
    if(isDefined(var_5[var_8]._id_F35F)) {
      var_6 = var_6 + var_5[var_8]._id_F35F;
    }
  }

  var_9 = 0;

  if(var_6 > var_7 && !var_9) {
    var_3 = _id_6574("kill_" + var_0, var_1);
  }

  if(isDefined(var_3)) {
    level thread _id_4FF0(var_1, var_2, var_3, undefined, var_6, 1);
  }
}

_id_FBB6(var_0) {
  var_1 = gettime();
  level._id_985A["kill_generic_zombie"]["contents"][var_0]["last_time"] = var_1;
}

_id_6EE6(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("deactivated" + var_0);
  scripts\engine\utility::_id_5C1B("explosive_armor");
  level thread _id_4376(var_0, var_1);
  level thread _id_B3F8(var_0, ::_id_6F29);
  level thread _id_B5DE(var_0, ::_id_6F29);
  level thread _id_6EE7(var_0, ::_id_6F29);
  level._id_57E4 = 1;

  foreach(var_4 in level.players) {
    if(!isalive(var_4) || istrue(var_4.inlaststand)) {
      continue;
    }
    if(!istrue(var_4._id_74EE)) {
      thread _id_6F29(var_4, var_0);
    }
  }
}

_id_6F29(var_0, var_1) {
  var_0._id_74EE = 1;
  var_0 thread _id_BAAD(undefined, var_1);
  var_0 thread _id_3F0B();
  var_0 thread _id_42BD();
  var_0 thread _id_C3B6(var_1);
  var_0 thread _id_C3B7(var_0);
}

_id_B3F8(var_0, var_1) {
  level endon("deactivated" + var_0);
  level endon("game_ended");

  while(scripts\engine\utility::_id_5C00("explosive_armor")) {
    level waittill("connected", var_2);
    thread[[var_1]](var_2, var_0);
  }
}

_id_B5DE(var_0, var_1) {
  level endon("deactivated" + var_0);
  level endon("game_ended");

  while(scripts\engine\utility::_id_5C00("explosive_armor")) {
    level waittill("player_spawned", var_2);
    thread[[var_1]](var_2, var_0);
  }
}

_id_6EE7(var_0, var_1) {
  level endon("deactivated" + var_0);
  level endon("game_ended");

  while(scripts\engine\utility::_id_5C00("explosive_armor")) {
    level waittill("revive_success", var_2);
    thread[[var_1]](var_2, var_0);
  }
}

_id_C3B6(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  scripts\engine\utility::_id_5C30("explosive_armor");
  self._id_74EE = undefined;
  self setscriptablepartstate("exp_touch", "neutral", 0);
  self notify("explosive_armor_removed");
  self notify("remove_power_icon" + var_0);
}

_id_C3B7(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("explosive_armor_removed");
  var_0 scripts\engine\utility::waittill_any_2("death", "last_stand");
  var_0._id_74EE = undefined;
  var_0 setscriptablepartstate("exp_touch", "neutral", 0);
  var_0 notify("explosive_armor_removed");
}

_id_4376(var_0, var_1) {
  level endon("disconnect");
  level endon("game_ended");
  var_1 = var_1 - 5.5;
  scripts\engine\utility::_id_108A7(var_1, "deactivated" + var_0);
  level notify("deactivated" + var_0);
  wait 5.5;
  scripts\engine\utility::_id_5C04("explosive_armor");
  level._id_57E4 = undefined;

  foreach(var_3 in level.players) {
    var_3._id_74EE = undefined;
  }
}

_id_42BD() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self endon("explosive_armor_removed");

  for(var_0 = gettime(); scripts\engine\utility::_id_5C00("explosive_armor"); var_0 = gettime()) {
    var_1 = scripts\engine\utility::_id_6369(self.origin, level._id_E2A4, undefined, undefined, 128, 1);

    foreach(var_3 in var_1) {
      if(isalive(var_3)) {
        if(!isDefined(var_3._id_57E5) || gettime() > var_3._id_57E5) {
          var_3._id_57E5 = var_0 + 1000;
          var_3 dodamage(100, self.origin, self, self, "MOD_UNKNOWN", "power_script_generic_primary_mp");
        }
      }
    }

    wait 0.25;
  }
}

_id_3F0B() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("exp_touch", "on", 0);
}

_id_ACB4(var_0, var_1, var_2) {
  level endon("deactivated" + var_0);
  level thread _id_4380(var_0, var_1);
  level thread _id_ACB0(var_0);

  for(;;) {
    foreach(var_4 in level.players) {
      if(!istrue(var_4._id_7508)) {
        var_4._id_7508 = 1;
        var_5 = var_1 - (gettime() - var_2) / 1000;
        var_4 thread _id_BAAD(var_5, var_0);
      }
    }

    wait 0.25;
  }
}

_id_ACB0(var_0) {
  level endon("game_ended");
  level endon("host_migration_begin");
  level endon("deactivated" + var_0);

  for(;;) {
    var_1 = _id_06FE::_id_68A1("axis");

    foreach(var_4, var_3 in var_1) {
      if(!isalive(var_3)) {
        wait 0.2;
        continue;
      }

      if(isDefined(var_3._id_42EE)) {
        wait 0.2;
        continue;
      }

      if(isDefined(var_3._id_9B32)) {
        wait 0.2;
        continue;
      }

      if(isDefined(var_3._id_9B2B)) {
        wait 0.2;
        continue;
      }

      if(isDefined(var_3._id_5A06)) {
        wait 0.2;
        continue;
      }

      _id_074A::_id_5210(var_3, level.players, 4, 0, 0, "high");

      if(var_4 % 2 == 0) {
        wait 0.05;
      }
    }

    wait 0.2;
  }
}

_id_4380(var_0, var_1) {
  level endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::_id_108A7(var_1, "deactivated" + var_0);
  level notify("deactivated" + var_0);

  foreach(var_3 in level.players) {
    var_3._id_7508 = undefined;
    var_3 _id_074A::_id_F9C3();
  }
}

_id_6EF8(var_0, var_1, var_2) {
  level notify("activated" + var_0);
  level endon("activated" + var_0);
  level endon("deactivated" + var_0);
  level notify("infinite_grenade_active");
  level._id_7E88 = 1;
  level thread _id_4378(var_0, var_1);
  level._id_0F27["infinite_grenades"] = 1;

  foreach(var_4 in level.players) {
    thread _id_19BE(var_4);
  }
}

_id_19BA(var_0) {
  if(isDefined(var_0._id_F07B)) {
    var_0 thread _id_BAAD(30 * var_0._id_F07B, "fire_30");
  } else {
    var_0 thread _id_BAAD(30, "fire_30");
  }
}

_id_19BE(var_0) {
  var_0._id_BA9B = 1;
  var_0._id_74FB = 1;
  var_0 _id_0753::_id_BA96(1, "primary", 1);

  if(isDefined(var_0._id_F07B)) {
    var_0 thread _id_BAAD(30 * var_0._id_F07B, "grenade_30");
  } else {
    var_0 thread _id_BAAD(30, "grenade_30");
  }
}

_id_4378(var_0, var_1) {
  level endon("disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::_id_108A8(var_1, "deactivated" + var_0, "activated" + var_0);

  if(var_2 != "activated" + var_0) {
    level._id_0F27["infinite_grenades"] = 0;
    level notify("deactivated" + var_0);

    foreach(var_4 in level.players) {
      var_4 _id_0753::_id_BA96(undefined, "primary", 1);
      var_4._id_74FB = undefined;
      var_4._id_BA9B = 0;
    }

    level._id_7E88 = undefined;
  }
}

_id_6EF7(var_0, var_1, var_2) {
  level notify("activated" + var_0);
  level endon("activated" + var_0);
  level endon("deactivated" + var_0);
  level notify("infinite_ammo_active");
  level._id_7E84 = 1;
  level._id_0F27["infinite_ammo"] = 1;
  level thread _id_4377(var_0, var_1);

  foreach(var_4 in level.players) {
    thread _id_19BD(var_4);
  }
}

_id_19BD(var_0) {
  var_0 thread _id_076F::_id_F72D("powerup_ammo", "zmb_comment_vo");
  var_0._id_74FA = 1;
  var_1 = var_0 _id_16D8();
  var_0 thread _id_F957(var_1, "infinite_20");

  if(isDefined(var_0._id_F07B)) {
    var_0 thread _id_BAAD(20 * var_0._id_F07B, "infinite_20");
  } else {
    var_0 thread _id_BAAD(20, "infinite_20");
  }
}

_id_4377(var_0, var_1) {
  level endon("disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::_id_108A8(var_1, "deactivated" + var_0, "activated" + var_0);

  if(var_2 != "activated" + var_0) {
    level._id_0F27["infinite_ammo"] = 0;
    level._id_7E84 = undefined;
    level notify("deactivated" + var_0);

    foreach(var_4 in level.players) {
      var_4._id_74FA = undefined;
    }
  }

  foreach(var_4 in level.players) {
    if(var_4 scripts\cp\utility::_id_88C4()) {
      var_4 scripts\cp\utility::_id_5201(0);
    }
  }
}

_id_6F02(var_0, var_1, var_2) {
  level endon("deactivated" + var_0);
  level endon("disconnect");
  level endon("game_ended");
  var_3 = undefined;
  level._id_CFE1 = 1;
  var_4 = scripts\engine\utility::random(["power_speedBoost", "power_siegeMode", "power_barrier", "power_mortarMount", "power_transponder"]);

  for(;;) {
    foreach(var_6 in level.players) {
      if(!istrue(var_6._id_74FE)) {
        var_6._id_74FE = 1;
        var_7 = var_1 - (gettime() - var_2) / 1000;
        var_3 = var_6 _id_0753::_id_10DF9("secondary");
        var_6 thread _id_0753::_id_6FD3(var_4, "secondary", undefined, undefined, undefined, undefined, 1);
        var_6 _id_0753::_id_BAB5(10, "secondary");
        var_6 thread _id_10CA(var_0, var_7);
        var_6 thread _id_BAAD(var_7, var_0);
        var_6 thread _id_437D(var_7, var_3, var_4, var_0);
      }
    }

    wait 0.25;
  }
}

_id_10CA(var_0, var_1) {
  level endon("deactivated" + var_0);
  level endon("disconnect");
  level endon("game_ended");
  self endon("disconnect");
  self endon("lb_power_used");
  self._id_10CB = 0;
  var_2 = var_1 / 3;
  self notifyonplayercommand("lb_power_used", "+speed_throw");

  while(self._id_10CB > 3) {
    if(!isalive(self)) {
      wait 0.5;
      continue;
    }

    scripts\cp\utility::_id_D5E9("msg_axe_hint", &"CP_ZOMBIE/ADD_ABILITY__HINT", 5);
    self._id_10CB++;
    wait(var_2);
  }
}

_id_437D(var_0, var_1, var_2, var_3) {
  level endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::_id_108A7(var_0, "deactivated" + var_3);
  self._id_74FE = undefined;
  self._id_10CB = undefined;
  level._id_CFE1 = undefined;
  level notify("deactivated" + var_3);
  _id_0753::_id_C50E(var_2);

  if(isDefined(var_1)) {
    thread _id_0753::_id_6FD3(var_1, "secondary", undefined, undefined, undefined, undefined, 0);
  }
}

_id_6EBF() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(_id_073B::_id_B4EF(var_1)) {
      continue;
    }
    scripts\cp\utility::_id_6F0B(var_1);
  }
}

_id_0EB6(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level notify("activated" + var_1);
  level endon("deactivated" + var_1);
  level._id_82F4 = 1;
  level thread _id_4379(var_1, var_2);
  level._id_0F27["instakill"] = 1;

  foreach(var_5 in level.players) {
    thread _id_19BF(var_5);
  }
}

_id_19BF(var_0) {
  var_0._id_82F8 = 1;

  if(isDefined(var_0._id_F07B)) {
    var_0 thread _id_BAAD(30 * var_0._id_F07B, "instakill_30");
  } else {
    var_0 thread _id_BAAD(30, "instakill_30");
  }
}

_id_4379(var_0, var_1) {
  level endon("game_ended");
  level endon("activated" + var_0);
  scripts\engine\utility::_id_108A7(var_1, "deactivated" + var_0);
  level notify("deactivated" + var_0);

  foreach(var_3 in level.players) {
    var_3._id_82F8 = undefined;
  }

  level._id_82F4 = undefined;
  level._id_0F27["instakill"] = 0;
}

_id_CB7D(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("deactivated" + var_1);
  level notify("scale_earned_cash");
  level endon("scale_earned_cash");
  level._id_0F27["double_money"] = 1;
  level._id_32FF = 2;

  if(isDefined(var_0._id_F07B)) {
    level thread _id_4381(var_1, 30 * var_0._id_F07B, var_2);
  } else {
    level thread _id_4381(var_1, 30, var_2);
  }

  foreach(var_5 in level.players) {
    thread _id_19B7(var_5);
  }
}

_id_19B7(var_0) {
  var_0._id_4E98 = 1;

  if(isDefined(var_0._id_F07B)) {
    var_0 thread _id_BAAD(30 * var_0._id_F07B, "cash_2");
  } else {
    var_0 thread _id_BAAD(30, "cash_2");
  }
}

_id_4381(var_0, var_1, var_2) {
  level endon("disconnect");
  level endon("game_ended");
  var_3 = scripts\engine\utility::_id_108A8(var_1, "deactivated" + var_0, "activated" + var_0);

  if(var_3 != "activated" + var_0) {
    level notify("deactivated" + var_0);
    level._id_32FF = 1;
    level._id_0F27["double_money"] = 0;

    foreach(var_5 in level.players) {
      var_5._id_4E98 = undefined;
    }
  }
}

_id_BAAD(var_0, var_1) {
  level notify("power_icon_active_" + var_1);
  level endon("power_icon_active_" + var_1);
  var_2 = level._id_9858[var_1];
  self._id_BB26[var_1] = var_2;
  var_3 = _id_D3FF(var_1);
  thread _id_78CD(var_0, var_1, var_3);
}

_id_D3FF(var_0) {
  var_1 = int(_func_0222(level._id_BACC, 2, var_0, 1));
  var_2 = int(var_1);
  self _meth_82F8("zm_active_powerups", var_2 - 1, 1);
  return var_2;
}

_id_4B6C(var_0) {
  foreach(var_2 in level.players) {
    var_2 setclientomnvar("zm_powerup_activated", var_0);
    wait 0.05;
  }
}

_id_64BE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = scripts\engine\utility::getStructArray(var_1, var_2);
  var_6[var_6.size] = var_0;

  foreach(var_8 in var_6) {
    var_9 = scripts\engine\utility::_id_6369(var_8.origin, level.players, undefined, 1, var_4, 1);

    if(var_9.size >= 1) {
      if(!isDefined(var_8.angles)) {
        var_8.angles = (0, 0, 0);
      }

      var_10 = scripts\engine\utility::spawn_tag_origin(var_8.origin, var_8.angles);
      var_10 show();
      var_10.origin = var_8.origin;
      var_10.angles = var_8.angles;
      var_5[var_5.size] = var_10;

      if(isDefined(var_3)) {
        if(var_5.size >= var_3) {
          break;
        }
      }
    }
  }

  var_5 = _func_0204(var_5, var_0.origin);
  return var_5;
}

_id_8D14(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_0.origin;
  var_3 = _id_64BE(var_0, "effect_loc", "targetname", undefined, 1500);
  wait 1.0;
  playsoundatpos(var_2, "zmb_powerup_nuke_explo");
  level thread _id_A6FF(var_0, var_3);
  waitframe();
  playrumbleonposition("heavy_3s", var_2);
  earthquake(0.25, 4, var_2, 2500);
  waitframe();
  var_4 = _id_06FE::_id_68A1("axis");

  foreach(var_6 in level.players) {
    var_6 scripts\cp\utility::_id_10A2("nuke", 0.0, 0);
  }

  var_8 = _func_0204(var_4, var_2);
  var_9 = 400;

  if(isDefined(level._id_32FF)) {
    var_9 = 400 * level._id_32FF;
  }

  foreach(var_11 in var_8) {
    if(_id_85FA(var_11)) {
      continue;
    }
    if(istrue(var_11._id_8873)) {
      var_11 dodamage(var_11.health + 100, var_11.origin);
    } else {
      var_11._id_0229 = 1;
      var_11._id_8569 = 1;
      var_11._id_A546 = undefined;
      var_11 thread _id_8D4B(1);
    }

    wait 0.1;
  }

  level._id_A727 = 1;
  wait 5;
  level._id_A727 = 0;

  foreach(var_6 in level.players) {
    var_6 scripts\cp\utility::_id_C48A("nuke", 0);

    if(!istrue(level._id_5E87)) {
      if(!_id_073B::_id_B4EF(var_6)) {
        var_6 _id_074E::_id_6F28(var_9, undefined, undefined, 1, "nuke");
      }
    }
  }

  level._id_5E87 = undefined;
}

_id_85FA(var_0) {
  return istrue(var_0._id_7D47);
}

_id_A6FF(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    foreach(var_6 in level.players) {
      if(!var_6 scripts\cp\utility::_id_8708()) {
        continue;
      }
      if(istrue(var_6._id_7D66)) {
        continue;
      }
      if(istrue(var_6._id_864C)) {
        continue;
      }
      _func_019D(level._effect["big_explo"], var_4, "tag_origin", var_6);
    }

    waitframe();
  }

  wait 5;

  foreach(var_4 in var_1) {
    foreach(var_6 in level.players) {
      _func_02D1(level._effect["big_explo"], var_4, "tag_origin", var_6);
    }

    var_4 delete();
    waitframe();
  }
}

_id_8D4B(var_0) {
  self endon("death");
  thread _id_075B::_id_19F5(self);
  self._id_9B33 = 1;
  var_1 = istrue(self._id_86D9);

  if(isDefined(var_0)) {
    if(isalive(self) && !var_1) {
      playFX(level._effect["head_loss"], self gettagorigin("j_neck"));
      self setscriptablepartstate("head", "detached", 1);
      self setscriptablepartstate("eyes", "eye_glow_off", 1);
    }
  } else
    wait 1;

  self dodamage(self.health, self.origin);
}

_id_6F11(var_0, var_1) {
  var_0 iprintlnbold("Got Loot: $" + var_1);
  var_0 _id_074E::_id_6F28(var_1);
}

_id_5C8F(var_0, var_1, var_2) {
  var_2 endon("remove " + var_1 + " icon");
  var_2 endon("death");
  var_2 endon("disconnect");
  level endon("game_ended");
  var_3 = 10;
  var_4 = 0.2;
  wait(var_0 - 5);
  var_0 = 5;

  for(;;) {
    wait(var_0 / var_3);
    self.alpha = 0.1;
    wait(var_4);
    self.alpha = 0.75;

    if(float(var_3 * 1.5) > var_4) {
      var_3 = float(var_3 * 1.5);
      continue;
    }

    var_3 = var_4;
  }
}

_id_78CD(var_0, var_1, var_2, var_3) {
  level endon("activated" + var_1);
  self endon("remove_carryIcon" + var_1);
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  var_4 = 5.5;
  var_0 = var_0 - var_4;
  self _meth_82F8("zm_active_powerup_animation", var_2 - 1, 0);

  if(var_0 > 0) {
    level scripts\engine\utility::_id_108A7(var_0, "deactivated" + var_1);
    self _meth_82F8("zm_active_powerup_animation", var_2 - 1, 1);
  }

  level scripts\engine\utility::_id_108A7(var_4, "deactivated" + var_1);
  level notify("power_up_deactivated");

  if(isDefined(self._id_BB26[var_1])) {
    self._id_BB26[var_1] = undefined;
  }

  self notify("remove " + var_1 + " icon");
  self _meth_82F8("zm_active_powerups", var_2 - 1, 0);
  self _meth_82F8("zm_active_powerup_animation", var_2 - 1, 0);
}

_id_78F0() {
  self endon("remove_carryIcon");
  level waittill("game_ended");

  if(isDefined(self._id_32E7)) {
    self._id_32E7.alpha = 0;
  }
}

_id_16D8() {
  self endon("death");
  self endon("disconnect");
  var_0 = [];

  foreach(var_2 in self.weaponlist) {
    var_0[getcompleteweaponname(var_2)] = self _meth_8109(var_2);
  }

  return var_0;
}

_id_F957(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("deactivated" + var_1);

  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  scripts\cp\utility::_id_5201(1);

  for(;;) {
    var_2 = 0;

    foreach(var_4 in self.weaponlist) {
      if(var_4 == self getcurrentweapon() && _id_10D0A(var_4)) {
        var_2 = 1;
        self setweaponammoclip(var_4, weaponclipsize(var_4), "left");
      }

      if(var_4 == self getcurrentweapon() && _id_10D0A(var_4)) {
        var_2 = 1;
        self setweaponammoclip(var_4, weaponclipsize(var_4), "right");
      }

      if(var_2 == 0) {
        _id_16D8();
      }
    }

    wait 0.05;
  }
}

_id_10D0A(var_0) {
  var_1 = 1;

  foreach(var_3 in level._id_AC5A) {
    if(var_0 == var_3) {
      var_1 = 0;
    }
  }

  return var_1;
}

_id_4C1D() {
  waitframe();

  if(isDefined(self) && scripts\cp\utility::_id_7526(self.model, "tag_eye")) {
    _func_019D(level._effect["vfx_screen_flash"], self, "tag_eye", self);
  }
}