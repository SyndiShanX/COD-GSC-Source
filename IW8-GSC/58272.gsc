/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58272.gsc
***********************************************/

function init() {
  if(isDefined(level.ref_119f9)) {
    return;
  }

  test_bag_pickup();
  level._effect["vfx_golden_loot_explosion_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare");
  level._effect["vfx_br_legendary_loot_glow"] = loadfx("vfx/iw8_br/gameplay/vfx_br_launch_code_glow");
}

function test_bag_pickup() {
  if(!isDefined(level.ref_119f9)) {
    level.ref_119f9 = spawnStruct();
    level.ref_119f9.ammo_types = [];
    level.ref_119f9.ammo_types["rifle"] = "brloot_ammo_762";
    level.ref_119f9.ammo_types["mg"] = "brloot_ammo_762";
    level.ref_119f9.ammo_types["pistol"] = "brloot_ammo_919";
    level.ref_119f9.ammo_types["smg"] = "brloot_ammo_919";
    level.ref_119f9.ammo_types["sniper"] = "brloot_ammo_50cal";
    level.ref_119f9.ammo_types["rocketlauncher"] = "brloot_ammo_rocket";
    level.ref_119f9.ammo_types["spread"] = "brloot_ammo_12g";
  }

  level.ref_119f9.ref_12148 = [];
  level.ref_119f9.ref_119fd = [];
}

function ref_11a45(var_0, var_1) {
  if(!isDefined(level.ref_119f9)) {
    return;
  }

  if(!scripts\engine\utility::array_contains_key(level.ref_119f9.ref_119fd, var_0)) {
    level.ref_119f9.ref_119fd[var_0] = allow_hotjoining(var_0, var_1);
    return;
  }
}

function ref_11a47(var_0, var_1) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }

  if(scripts\engine\utility::array_contains_key(level.ref_119f9.ref_119fd, var_0)) {
    level.ref_119f9.ref_119fd[var_0] = var_1;
    return;
  }
}

function ref_11a44(var_0, var_1, var_2) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }

  var_3 = level.ref_119f9.ref_119fd[var_0];

  if(!scripts\engine\utility::array_contains_key(var_3, var_1)) {
    level.ref_119f9.ref_12148[var_0][var_1] = var_2;
    level.ref_119f9.ref_119fd[var_0] = allow_hotjoining(var_0, level.ref_119f9.ref_12148[var_0]);
    return;
  }
}

function ref_11a46(var_0, var_1) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }

  var_2 = level.ref_119f9.ref_119fd[var_0];

  if(scripts\engine\utility::array_contains_key(var_2, var_1)) {
    level.ref_119f9.ref_12148[var_0] = scripts\engine\utility::array_remove_key(level.ref_119f9.ref_12148[var_0], var_1);
    level.ref_119f9.ref_119fd[var_0] = allow_hotjoining(var_0, level.ref_119f9.ref_12148[var_0]);
    return;
  }
}

function removepickup(var_0) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }

  return level.ref_119f9.ref_119fd[var_0];
}

function loottableexist(var_0) {
  return scripts\engine\utility::array_contains_key(level.ref_119f9.ref_119fd, var_0);
}

function ref_13673(var_0, var_1, var_2, var_3, var_4) {
  if(cargo_truck_mg_cp_spawncallback(var_0)) {
    return;
  }

  var_5 = removepickup(var_0);
  var_6 = spawnStruct();
  var_6.ml_p3_to_safehouse_transition = randomintrange(1, 10);
  var_6.heightoffset = 0;
  var_6.origin = var_1;

  if(isstring(var_3)) {} else if(var_3) {
    playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), var_1);
  }

  for(var_7 = 0; var_7 < var_2; var_7++) {
    var_8 = randomfloat(1);

    foreach(var_15, var_10 in var_5) {
      var_11 = var_10[2];
      var_12 = var_10[3];

      if(var_8 >= var_11 && var_8 <= var_12) {
        switch (var_15) {
          case "nothing":
            continue;
          case "brloot_ammo_killer_based":
            if(!isDefined(var_4)) {
              continue;
            }

            if(!isDefined(var_4["eAttacker"])) {
              continue;
            }

            var_13 = var_4["eAttacker"];
            var_14 = undefined;

            if(isPlayer(var_13) || isbot(var_13) || isagent(var_13)) {
              var_14 = weaponclass(var_4["eAttacker"] getcurrentweapon());
            }

            if(!isDefined(var_14)) {
              continue;
            }

            var_6.item = level.ref_119f9.ammo_types[var_14];

            if(!isDefined(var_6.item)) {
              continue;
            }

            break;
          default:
            var_6.item = var_15;
            break;
        }

        var_6.ml_p3_to_safehouse_transition += 2;
        thread ref_13672(var_6);
        waitframe();
      }
    }
  }
}

function cargo_truck_mg_cp_spawncallback(var_0) {
  if(!scripts\engine\utility::array_contains_key(level.ref_119f9.ref_119fd, var_0)) {
    return true;
  }

  return false;
}

function ref_13672(var_0) {
  var_0.legendary = issubstr(var_0.item, "lege");
  var_1 = var_0.item;
  var_2 = var_0.origin + (0, 0, var_0.heightoffset);
  var_3 = (0, 0, 0);
  var_4 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_1, var_0, var_2, var_3, 0, var_0.legendary, 0);
  var_0.heightoffset += 3;
}

function allow_hotjoining(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_3 += var_5;
  }

  var_7 = 0;
  var_8 = getarraykeys(var_1);
  var_9 = undefined;

  foreach(var_14, var_5 in var_1) {
    var_2 = [];
    var_11 = var_5 / var_3;

    if(var_7 == 0) {
      var_12 = 0;
      var_13 = var_11;
    } else {
      var_12 = var_9[3];
      var_13 = var_12 + var_11;
    }

    var_2 = [var_5, var_11, var_12, var_13];
    var_9 = var_2[var_14];
    var_7++;
  }

  level.ref_119f9.ref_12148[var_0] = var_1;
  return var_2;
}