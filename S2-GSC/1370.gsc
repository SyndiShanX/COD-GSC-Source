/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1370.gsc
*********************************************/

lib_055A::func_00D5() {
  level.var_AC80 = spawnStruct();
  level.var_AC80.var_9054 = ["zombie_spawner", "zombie_sky_spawner"];
  level.var_AC80.var_ACB3 = [];
  level.var_AC80.var_2914 = [];
  level.var_AC80.var_290A = [];
  level.var_AC80.var_9065 = ::lib_055A::func_1E4E;
  level.var_AC80.var_8FE7 = 0;
  level.var_1F1D = ::lib_055A::func_1F66;
  level.var_4200 = ::lib_055A::func_4562;
  level.var_43F2 = ::lib_055A::func_474A;
  level.var_8C96 = undefined;
  level.var_43F4 = ::lib_055A::func_474B;
  level.var_38D1 = undefined;
  level.var_7D20 = undefined;
  level.var_38D2 = [];
  level.var_7D21 = [];
}

lib_055A::func_6B3F() {
  if(!isDefined(level.var_AC80)) {
    return;
  }

  foreach(var_01 in level.var_AC80.var_ACB3) {
    var_02 = [];
    var_01.var_37C3 = [];
    var_01.var_744A = [];
    var_01.zombies = [];
    var_01 lib_055A::func_ACA1();
    for(var_03 = 0; var_03 < var_01.var_ABFE.size; var_03++) {
      var_04 = var_01.var_ABFE[var_03];
      if(lib_0547::func_AC0F(var_04, var_01.var_AC8A + " spawner", undefined, var_01.var_AC8A)) {
        var_02[var_02.size] = var_04;
      }
    }

    var_01.var_ABFE = var_02;
  }
}

lib_055A::func_3155(param_00) {
  var_01 = isDefined(level.var_AC80.var_ACB3[param_00]);
  return var_01;
}

lib_055A::func_0F4F(param_00) {
  foreach(var_02 in level.var_AC80.var_ACB3) {
    if(common_scripts\utility::func_562E(param_00)) {
      if(isDefined(level.zmb_registered_quest_zones) && common_scripts\utility::func_0F79(level.zmb_registered_quest_zones, var_02.var_AC8A)) {
        continue;
      }
    }

    if(!var_02.var_556E) {
      return 0;
    }
  }

  return 1;
}

lib_055A::func_586A(param_00) {
  return level.var_AC80.var_ACB3[param_00].var_556E;
}

lib_055A::func_1F66(param_00) {
  return level.var_AC80.var_ACB3[param_00].var_5614;
}

lib_055A::func_5780(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01 && !lib_055A::func_586A(param_00)) {
    return 0;
  }

  foreach(var_03 in level.var_744A) {
    if(lib_055A::func_7413(var_03, param_00, param_01)) {
      return 1;
    }
  }

  return 0;
}

lib_055A::func_A100() {
  level endon("game_ended");
  level notify("updating_connection_distances");
  level endon("updating_connection_distances");
  level.var_AC80.var_2585 = [];
  foreach(var_01 in level.var_AC80.var_ACB3) {
    foreach(var_03 in level.var_AC80.var_ACB3) {
      if(var_01.var_AC8A == var_03.var_AC8A) {
        continue;
      }

      if(isDefined(level.var_AC80.var_2585[var_01.var_AC8A]) && isDefined(level.var_AC80.var_2585[var_01.var_AC8A][var_03.var_AC8A])) {
        continue;
      }

      lib_055A::func_474A(var_01.var_AC8A, var_03.var_AC8A);
      wait 0.05;
    }
  }

  if(isDefined(level.var_AC88)) {
    level.var_AC80.var_511B = [];
    foreach(var_01 in level.var_AC80.var_ACB3) {
      foreach(var_03 in level.var_AC80.var_ACB3) {
        if(var_01.var_AC8A == var_03.var_AC8A) {
          continue;
        }

        if(isDefined(level.var_AC80.var_511B[var_01.var_AC8A]) && isDefined(level.var_AC80.var_511B[var_01.var_AC8A][var_03.var_AC8A])) {
          continue;
        }

        lib_055A::func_474B(var_01.var_AC8A, var_03.var_AC8A);
        wait 0.05;
      }
    }
  }
}

lib_055A::func_7BDC(param_00, param_01, param_02) {
  level.var_AC80.var_2585[param_00][param_01] = param_02;
  level.var_AC80.var_2585[param_01][param_00] = param_02;
}

lib_055A::func_474A(param_00, param_01) {
  if(param_00 == param_01) {
    return 0;
  }

  if(!isDefined(level.var_AC80.var_2585)) {
    return -1;
  }

  if(isDefined(level.var_AC80.var_2585[param_00]) && isDefined(level.var_AC80.var_2585[param_00][param_01])) {
    return level.var_AC80.var_2585[param_00][param_01];
  }

  var_02[0]["zone"] = param_00;
  var_02[0]["distance"] = 0;
  while(var_02.size > 0) {
    var_03 = level.var_AC80.var_ACB3[var_02[0]["zone"]];
    var_04 = var_02[0]["distance"];
    var_02 = common_scripts\utility::func_0F9A(var_02, 0);
    var_05[var_03.var_AC8A] = 1;
    foreach(var_0E, var_07 in var_03.var_0A01) {
      if(isDefined(var_05[var_07.var_AC8A])) {
        continue;
      }

      if(var_07.var_554C) {
        var_08 = var_04 + 1;
        if(var_07.var_AC8A == param_01) {
          lib_055A::func_7BDC(param_00, param_01, var_08);
          return var_08;
        }

        var_09 = -1;
        var_0A = -1;
        if(var_02.size == 0) {
          var_09 = 0;
        }

        for(var_0B = 0; var_0B < var_02.size; var_0B++) {
          var_0C = var_02[var_0B]["distance"] >= var_08;
          if(var_0C && var_09 < 0) {
            var_09 = var_0B;
          }

          if(var_02[var_0B]["zone"] == var_07.var_AC8A) {
            if(var_0C) {
              var_0A = var_0B;
            }

            break;
          }
        }

        if(var_0A >= 0) {
          var_02 = common_scripts\utility::func_0F9A(var_02, var_0A);
        }

        if(var_0B == var_02.size && var_09 < 0) {
          var_09 = var_02.size;
        }

        if(var_09 >= 0) {
          param_00["zone"] = var_07.var_AC8A;
          var_0C["distance"] = var_0E;
          param_01 = common_scripts\utility::func_0F86(param_01, var_0C, var_08);
        }
      }
    }
  }

  return -1;
}

lib_055A::func_7BE7(param_00, param_01, param_02) {
  level.var_AC80.var_511B[param_00][param_01] = param_02;
  level.var_AC80.var_511B[param_01][param_00] = param_02;
}

lib_055A::func_474B(param_00, param_01) {
  if(param_00 == param_01) {
    return 0;
  }

  if(!isDefined(level.var_AC80.var_2585)) {
    return -1;
  }

  if(isDefined(level.var_AC80.var_511B[param_00]) && isDefined(level.var_AC80.var_511B[param_00][param_01])) {
    return level.var_AC80.var_511B[param_00][param_01];
  }

  var_02[0]["zone"] = param_00;
  var_02[0]["distance"] = 0;
  while(var_02.size > 0) {
    var_03 = level.var_AC80.var_ACB3[var_02[0]["zone"]];
    var_04 = var_02[0]["distance"];
    var_02 = common_scripts\utility::func_0F9A(var_02, 0);
    var_05[var_03.var_AC8A] = 1;
    foreach(var_0E, var_07 in var_03.var_0A01) {
      if(isDefined(var_05[var_07.var_AC8A])) {
        continue;
      }

      if([[level.var_AC88]](var_07.var_AC8A)) {
        continue;
      }

      if(var_07.var_554C) {
        var_08 = var_04 + 1;
        if(var_07.var_AC8A == param_01) {
          lib_055A::func_7BE7(param_00, param_01, var_08);
          return var_08;
        }

        var_09 = -1;
        var_0A = -1;
        if(var_02.size == 0) {
          var_09 = 0;
        }

        for(var_0B = 0; var_0B < var_02.size; var_0B++) {
          var_0C = var_02[var_0B]["distance"] >= var_08;
          if(var_0C && var_09 < 0) {
            var_09 = var_0B;
          }

          if(var_02[var_0B]["zone"] == var_07.var_AC8A) {
            if(var_0C) {
              var_0A = var_0B;
            }

            break;
          }
        }

        if(var_0A >= 0) {
          var_02 = common_scripts\utility::func_0F9A(var_02, var_0A);
        }

        if(var_0B == var_02.size && var_09 < 0) {
          var_09 = var_02.size;
        }

        if(var_09 >= 0) {
          param_00["zone"] = var_07.var_AC8A;
          var_0C["distance"] = var_0E;
          param_01 = common_scripts\utility::func_0F86(param_01, var_0C, var_08);
        }
      }
    }
  }

  return -1;
}

lib_055A::func_462D() {
  if(self.var_0178 == "spectator" || self.var_0178 == "intermission") {
    return undefined;
  }

  updatecurrentzones();
  var_00 = getarraykeys(self.currentzones);
  if(var_00.size > 0) {
    return var_00[0];
  }

  return undefined;
}

getagentzone() {
  updatecurrentzones();
  var_00 = getarraykeys(self.currentzones);
  if(var_00.size > 0) {
    return var_00[0];
  }

  return undefined;
}

lib_055A::func_4482(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  var_01 = lib_055A::func_4483(param_00);
  var_02 = [];
  foreach(var_04 in var_01) {
    var_02[var_02.size] = var_04.var_AC8A;
  }

  return var_02;
}

lib_055A::func_4483(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  var_01 = [];
  var_02 = [];
  foreach(var_04 in level.var_744A) {
    var_04 updatecurrentzones();
    foreach(var_07, var_06 in var_04.currentzones) {
      if(!isDefined(var_01[var_07])) {
        if(!param_00 || lib_055A::func_586A(var_07)) {
          var_01[var_07] = 1;
          var_02[var_02.size] = level.var_AC80.var_ACB3[var_07];
          continue;
        }

        var_01[var_07] = 0;
      }
    }
  }

  return var_02;
}

lib_055A::func_5860(param_00) {
  param_00 updatecurrentzones();
  if(!isDefined(param_00.currentzones)) {
    return 0;
  }

  return param_00.currentzones.size > 0;
}

lib_055A::func_5861(param_00) {
  param_00 updatecurrentzones();
  if(!isDefined(param_00.currentzones)) {
    return 0;
  }

  foreach(var_02 in param_00.currentzones) {
    if(lib_055A::func_586A(var_02)) {
      return 1;
    }
  }

  return 0;
}

getzoneclosesttopoint(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = undefined;
  foreach(var_04 in level.var_AC80.var_ACB3) {
    if(param_01 && !lib_055A::func_586A(var_04.var_AC8A)) {
      continue;
    }

    foreach(var_06 in var_04.var_A615) {
      if(ispointinvolume(param_00, var_06)) {
        return var_04.var_AC8A;
      }
    }

    if(!isDefined(var_02)) {
      var_02 = var_04;
      continue;
    }

    if(distance(param_00, var_04.var_74DC) < distance(param_00, var_02.var_74DC)) {
      var_02 = var_04;
    }
  }

  return var_02.var_AC8A;
}

lib_055A::func_5771(param_00) {
  foreach(var_02 in level.var_AC80.var_ACB3) {
    foreach(var_04 in var_02.var_A615) {
      if(ispointinvolume(param_00.var_0116, var_04)) {
        return 1;
      }

      if(ispointinvolume(param_00.var_0116 + (0, 0, 20), var_04)) {
        return 1;
      }
    }
  }

  return 0;
}

lib_055A::func_5772(param_00) {
  foreach(var_02 in level.var_AC80.var_ACB3) {
    if(!lib_055A::func_586A(var_02.var_AC8A)) {
      continue;
    }

    foreach(var_04 in var_02.var_A615) {
      if(ispointinvolume(param_00.var_0116, var_04)) {
        return 1;
      }

      if(ispointinvolume(param_00.var_0116 + (0, 0, 20), var_04)) {
        return 1;
      }
    }
  }

  return 0;
}

lib_055A::func_578A(param_00, param_01) {
  var_02 = lib_055A::func_578B(param_00, param_01);
  return isDefined(var_02);
}

lib_055A::func_578B(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  foreach(var_03 in level.var_AC80.var_ACB3) {
    if(param_01 && !lib_055A::func_586A(var_03.var_AC8A)) {
      continue;
    }

    foreach(var_05 in var_03.var_A615) {
      if(ispointinvolume(param_00, var_05)) {
        return var_03.var_AC8A;
      }
    }
  }
}

lib_055A::func_4562(param_00) {
  if(isDefined(level.var_AC80)) {
    foreach(var_02 in level.var_AC80.var_ACB3) {
      foreach(var_04 in var_02.var_A615) {
        if(ispointinvolume(param_00, var_04)) {
          return var_02.var_AC8A;
        }

        if(ispointinvolume(param_00 + (0, 0, 20), var_04)) {
          return var_02.var_AC8A;
        }
      }
    }
  }

  return undefined;
}

lib_055A::func_0F14(param_00) {
  var_01 = maps\mp\agents\_agent_utility::func_43FD("all");
  if(var_01.size == 0) {
    return 0;
  }

  var_02 = level.var_AC80.var_ACB3[param_00];
  foreach(var_04 in var_01) {
    var_04 updatecurrentzones();
  }

  var_06 = var_02 zombies_in_zone_internal();
  return var_06.size > 0;
}

zombies_in_zone_internal() {
  var_00 = self;
  var_01 = [];
  foreach(var_03 in var_00.zombies) {
    if(isDefined(var_03) && isalive(var_03)) {
      var_01[var_01.size] = var_03;
    }
  }

  var_00.zombies = var_01;
  return var_01;
}

players_in_zone_internal() {
  var_00 = self;
  var_01 = [];
  foreach(var_03 in var_00.var_744A) {
    if(isDefined(var_03) && isPlayer(var_03) && var_03.var_0178 != "spectator") {
      var_01[var_01.size] = var_03;
    }
  }

  var_00.var_744A = var_01;
  return var_01;
}

updatecurrentzones() {
  var_00 = self;
  if(isDefined(var_00.lastzoneupdateorigin)) {
    if(var_00.var_0116 == var_00.lastzoneupdateorigin) {
      return;
    }
  }

  var_00.lastzoneupdateorigin = var_00.var_0116;
  var_01 = var_00.currentzones;
  var_00.currentzones = [];
  var_02 = isPlayer(var_00) && var_00.var_0178 == "spectator";
  var_03 = function_01EF(var_00) && !isalive(var_00);
  if(!var_02 && !var_03) {
    foreach(var_09, var_05 in level.var_AC80.var_ACB3) {
      foreach(var_07 in var_05.var_A615) {
        if(var_00 istouching(var_07)) {
          var_00.currentzones[var_09] = 1;
          break;
        }
      }
    }
  }

  if(isDefined(var_01)) {
    var_0A = getarraykeys(var_01);
    foreach(var_09 in var_0A) {
      if(!isDefined(var_00.currentzones[var_09])) {
        var_00 thread onentityleftzone(var_09);
      }
    }
  } else {
    var_01 = [];
  }

  var_0D = getarraykeys(var_00.currentzones);
  foreach(var_09 in var_0D) {
    if(!isDefined(var_01) || !isDefined(var_01[var_09])) {
      var_00 thread onentityfoundinzone(var_09);
    }
  }
}

onentityfoundinzone(param_00) {
  var_01 = self;
  var_02 = level.var_AC80.var_ACB3[param_00];
  var_03 = var_01 getentitynumber();
  var_02.var_37C3[var_03] = var_01;
  if(isPlayer(var_01)) {
    var_02.var_744A[var_03] = var_01;
  }

  if(isDefined(var_01.var_000A) && var_01.var_000A != level.var_746E) {
    var_02.zombies[var_03] = var_01;
  }
}

onentityleftzone(param_00) {
  var_01 = self;
  var_02 = level.var_AC80.var_ACB3[param_00];
  var_03 = var_01 getentitynumber();
  var_02.var_37C3[var_03] = undefined;
  if(isPlayer(var_01)) {
    var_02.var_744A[var_03] = undefined;
  }

  if(isDefined(var_01.var_000A) && var_01.var_000A != level.var_746E) {
    var_02.zombies[var_03] = undefined;
  }
}

lib_055A::func_45BF(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(param_01 && !lib_055A::func_586A(param_00)) {
    return 0;
  }

  var_02 = level.var_AC80.var_ACB3[param_00];
  var_03 = 0;
  foreach(var_05 in level.var_744A) {
    if(lib_055A::func_7413(var_05, param_00, param_01)) {
      var_03++;
    }
  }

  return var_03;
}

lib_055A::func_4626(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = [];
  if(param_02 && !lib_055A::func_586A(param_00)) {
    return var_03;
  }

  var_04 = level.var_AC80.var_ACB3[param_00];
  var_05 = [param_00];
  if(param_01) {
    foreach(var_07 in var_04.var_0A01) {
      if(!param_02 || lib_055A::func_586A(var_07.var_AC8A)) {
        var_05[param_00.size] = var_07.var_AC8A;
      }
    }
  }

  foreach(var_0A in level.var_744A) {
    foreach(param_00 in var_05) {
      if(lib_055A::func_7413(var_0A, param_00, param_02)) {
        var_03[var_03.size] = var_0A;
      }
    }
  }

  return var_03;
}

lib_055A::func_7413(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(param_00.var_0178 == "spectator") {
    return 0;
  }

  param_00 updatecurrentzones();
  if(param_02 && !lib_055A::func_586A(param_01)) {
    return 0;
  }

  return common_scripts\utility::func_562E(param_00.currentzones[param_01]);
}

lib_055A::func_AC29(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(param_02 && !lib_055A::func_586A(param_01)) {
    return 0;
  }

  param_00 updatecurrentzones();
  return common_scripts\utility::func_562E(param_00.currentzones[param_01]);
}

lib_055A::func_45C3(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(param_01 && !lib_055A::func_586A(param_00)) {
    return 0;
  }

  var_02 = lib_0547::func_408F();
  if(var_02.size == 0) {
    return 0;
  }

  var_03 = level.var_AC80.var_ACB3[param_00];
  foreach(var_05 in var_02) {
    var_05 updatecurrentzones();
  }

  return var_03.zombies.size;
}

lib_055A::func_530A(param_00, param_01, param_02) {
  if(isDefined(level.var_AC80.var_ACB3[param_00])) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_03 = spawnStruct();
  var_03.var_0A01 = [];
  var_03.var_55CA = 0;
  var_03.var_556E = param_01;
  var_03.var_5614 = param_01;
  var_03.var_552B = 0;
  var_03.var_AC8A = param_00;
  if(isDefined(param_02)) {
    var_03.var_5614 = param_02;
  }

  var_03.var_A615 = [];
  var_04 = getEntArray(param_00, "targetname");
  foreach(var_06 in var_04) {
    if(var_06.var_003A == "info_volume") {
      var_03.var_A615[var_03.var_A615.size] = var_06;
    }
  }

  common_scripts\utility::func_3C87(var_03.var_AC8A);
  if(param_01) {
    common_scripts\utility::func_3C8F(var_03.var_AC8A);
  }

  level.var_AC80.var_ACB3[param_00] = var_03;
  var_03.var_75FF = lib_055A::func_4634(param_00);
  var_08 = lib_055A::func_4694(param_00);
  var_03.var_ABFE = lib_055A::func_3ACB(var_08, "zombie_spawner");
  if(!isDefined(level.var_AC4F)) {
    level.var_AC4F = [];
  }

  var_09 = lib_055A::func_3ACB(var_08, "zombie_sky_spawner");
  var_03.var_ABFE = common_scripts\utility::func_0F73(var_03.var_ABFE, var_09);
  var_03.var_9050 = [];
  foreach(var_0B in var_03.var_ABFE) {
    lib_055A::func_5374(var_0B);
    if(isDefined(var_0B.var_819A)) {
      var_03.var_9050[var_0B.var_819A] = 1;
    }
  }

  level.var_AC4F = common_scripts\utility::func_0F73(level.var_AC4F, var_03.var_ABFE);
  if(lib_0547::func_2306()) {
    var_03.var_2300 = lib_055A::func_3ACB(var_08, "civilian_extract");
    var_03.var_2302 = lib_055A::func_3ACB(var_08, "civilian_spawner");
    if(!isDefined(level.var_AC4E)) {
      level.var_AC4E = [];
    }

    level.var_AC4E = common_scripts\utility::func_0F73(level.var_AC4E, var_03.var_2302);
  }
}

lib_055A::func_5374(param_00) {
  switch (param_00.var_0165) {
    case "zombie_sky_spawner":
      param_00.var_8C95 = 1;
      break;

    case "zombie_spawner":
      if(isDefined(param_00.var_819A) && !common_scripts\utility::func_3C83(param_00.var_819A)) {
        common_scripts\utility::func_3C87(param_00.var_819A);
      }
      break;
  }
}

lib_055A::func_4634(param_00) {
  var_01 = common_scripts\utility::func_46B7("power_switch", "targetname");
  foreach(var_03 in var_01) {
    if(lib_055A::func_57F4(var_03, level.var_AC80.var_ACB3[param_00].var_A615)) {
      return var_03;
    }
  }

  return undefined;
}

lib_055A::func_57F4(param_00, param_01) {
  foreach(var_03 in param_01) {
    if(ispointinvolume(param_00.var_0116, var_03)) {
      return 1;
    }
  }

  return 0;
}

lib_055A::func_4694(param_00) {
  var_01 = [];
  foreach(var_03 in level.var_AC80.var_9054) {
    foreach(var_05 in getEntArray(var_03, "script_noteworthy")) {
      var_01[var_01.size] = var_05;
    }
  }

  var_08 = [];
  foreach(var_0A in level.var_AC80.var_ACB3[param_00].var_A615) {
    if(isDefined(var_0A.var_01A2)) {
      var_0B = common_scripts\utility::func_46B7(var_0A.var_01A2, "targetname");
      foreach(var_0D in var_0B) {
        if(!common_scripts\utility::func_0F79(var_08, var_0D)) {
          var_0D.var_AC8A = param_00;
          var_08[var_08.size] = var_0D;
        }
      }
    }

    foreach(var_05 in var_01) {
      if(ispointinvolume(var_05.var_0116, var_0A) && !common_scripts\utility::func_0F79(var_08, var_05)) {
        var_05.var_AC8A = param_00;
        var_08[var_08.size] = var_05;
      }
    }
  }

  return var_08;
}

lib_055A::func_3ACB(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_00) {
    if(!isDefined(var_04.var_0165)) {
      continue;
    }

    if(var_04.var_0165 != param_01) {
      continue;
    }

    var_02[var_02.size] = var_04;
  }

  return var_02;
}

lib_055A::func_0993(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(!isDefined(level.var_3C77[param_02])) {
    common_scripts\utility::func_3C87(param_02);
  }

  lib_055A::func_5FBF(param_00, param_01, param_02, 0);
  lib_055A::func_5FBF(param_01, param_00, param_02, param_03);
}

lib_055A::func_5FBF(param_00, param_01, param_02, param_03) {
  var_04 = level.var_AC80.var_ACB3[param_00];
  if(!isDefined(var_04.var_0A01[param_01])) {
    var_05 = spawnStruct();
    var_05.var_AC8A = param_01;
    var_05.var_3CC5[0] = param_02;
    var_05.var_554C = 0;
    var_05.var_6B2C = param_03;
    var_04.var_0A01[param_01] = var_05;
    return;
  }

  var_06 = var_04.var_0A01[param_01];
  var_06.var_3CC5[var_06.var_3CC5.size] = param_02;
}

getadjacentzones(param_00) {
  var_01 = [];
  var_02 = level.var_AC80.var_ACB3[param_00];
  foreach(var_04 in var_02.var_0A01) {
    var_01[var_01.size] = var_04;
  }

  return var_01;
}

lib_055A::func_088A(param_00) {
  if(isDefined(param_00)) {
    level.var_AC80.var_9065 = param_00;
  }

  foreach(var_02 in level.var_AC80.var_ACB3) {
    foreach(var_05, var_04 in var_02.var_0A01) {
      level thread lib_055A::func_ACC1(var_02, var_05);
    }
  }

  level thread lib_055A::func_63E4();
  level thread lib_055A::func_ACAC();
  level.var_AC80.var_08A9 = 1;
}

lib_055A::func_63E4() {
  level endon("game_ended");
  var_00 = 1;
  for(;;) {
    level.var_AC80.var_8FE7 = 1;
    while(level.var_AC80.var_8FE7) {
      wait 0.05;
    }

    wait(var_00);
  }
}

lib_055A::func_ACC1(param_00, param_01) {
  level endon("game_ended");
  foreach(var_03 in param_00.var_0A01[param_01].var_3CC5) {
    level thread lib_055A::func_ACC2(param_00, var_03, param_01);
  }
}

lib_055A::func_ACC2(param_00, param_01, param_02) {
  level endon("game_ended");
  common_scripts\utility::func_3C9F(param_01);
  var_03 = level.var_AC80.var_ACB3[param_02];
  var_03.var_556E = 1;
  common_scripts\utility::func_3C8F(param_00.var_AC8A);
  param_00.var_0A01[param_02].var_554C = 1;
  level thread lib_055A::func_A100();
}

lib_055A::func_445A(param_00, param_01) {
  var_02 = [];
  var_03 = 0;
  var_04 = lib_055A::func_4482();
  for(var_05 = var_04.size; var_05 > 0; var_05--) {
    var_06 = var_04[var_03];
    var_07 = level.var_AC80.var_ACB3[var_06];
    if(param_00) {
      var_02 = common_scripts\utility::func_0F73(var_02, var_07.var_2302);
    } else {
      var_02 = common_scripts\utility::func_0F73(var_02, var_07.var_2300);
      foreach(var_09 in var_02) {
        if(!isDefined(var_09.var_8260)) {
          var_02 = common_scripts\utility::func_0F93(var_02, var_09);
        }
      }
    }

    if(lib_055A::func_586A(var_07.var_AC8A)) {
      foreach(var_0C in var_07.var_0A01) {
        if(!lib_055A::func_586A(var_0C.var_AC8A)) {
          if(!param_00) {
            continue;
          }

          if(var_0C.var_6B2C) {
            continue;
          }
        }

        if(!common_scripts\utility::func_0F79(var_04, var_0C.var_AC8A)) {
          var_04[var_04.size] = var_0C.var_AC8A;
          var_05++;
        }
      }
    }

    var_03++;
  }

  var_02 = function_01AC(var_02, param_01);
  for(var_0E = var_02.size - 1; var_0E >= 0; var_0E--) {
    if(!isDefined(var_02[var_0E].var_4B57)) {
      var_02[var_0E].var_4B57 = 1;
      return var_02[var_0E];
    }
  }

  var_02[var_02.size - 1].var_4B57 = 1;
  return var_02[var_02.size - 1];
}

lib_055A::func_4696(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_AC80)) {
    return undefined;
  }

  if(level.var_AC80.var_8FE7) {
    level.var_AC80.var_8FE7 = 0;
    lib_055A::func_A166();
  }

  return [[level.var_AC80.var_9065]](param_00, param_01, param_02, param_03);
}

lib_055A::func_A166() {
  foreach(var_01 in level.var_AC80.var_ACB3) {
    var_01.var_552B = lib_055A::func_5780(var_01.var_AC8A);
    var_01.var_552C = 0;
  }

  foreach(var_01 in level.var_AC80.var_ACB3) {
    if(var_01.var_552B) {
      foreach(var_05 in var_01.var_0A01) {
        var_06 = level.var_AC80.var_ACB3[var_05.var_AC8A];
        if(!var_06.var_552B) {
          var_06.var_552C = 1;
        }
      }
    }
  }

  var_09 = [];
  var_0A = [];
  foreach(var_01 in level.var_AC80.var_ACB3) {
    if(var_01.var_552B || var_01.var_552C && var_01.var_556E) {
      var_09[var_09.size] = var_01.var_AC8A;
    }

    if(var_01.var_552C) {
      var_0A[var_0A.size] = var_01.var_AC8A;
    }
  }

  level.var_AC80.var_2914 = var_09;
  level.var_AC80.var_290A = var_0A;
}

lib_055A::func_583C(param_00) {
  var_01 = 0;
  if(isDefined(level.var_744A)) {
    foreach(var_03 in level.var_744A) {
      var_04 = function_038E(param_00, var_03.var_0116);
      if(var_04 < 2000) {
        var_01 = 1;
        break;
      }
    }
  }

  return var_01;
}

lib_055A::func_4692() {
  var_00 = [];
  foreach(var_02 in level.var_AC80.var_2914) {
    var_03 = level.var_AC80.var_ACB3[var_02];
    foreach(var_05 in var_03.var_ABFE) {
      var_00[var_00.size] = var_05;
    }
  }

  return var_00;
}

lib_055A::func_4693(param_00) {
  var_01 = [];
  var_02 = level.var_AC80.var_ACB3[param_00];
  foreach(var_04 in var_02.var_ABFE) {
    var_01[var_01.size] = var_04;
  }

  return var_01;
}

lib_055A::func_4691() {
  var_00 = [];
  foreach(var_02 in level.var_AC80.var_290A) {
    var_03 = level.var_AC80.var_ACB3[var_02];
    foreach(var_05 in var_03.var_ABFE) {
      var_00[var_00.size] = var_05;
    }
  }

  return var_00;
}

lib_055A::func_582C() {
  if(isDefined(self.var_8C95) && self.var_8C95) {
    if(isDefined(level.var_8C96)) {
      return [[level.var_8C96]]();
    }

    return 1;
  }

  return 1;
}

lib_055A::func_1E55(param_00, param_01, param_02, param_03) {
  if(isDefined(level.var_7A5D) && isDefined(level.var_7A5D[param_00])) {
    return [[level.var_7A5D[param_00]]]();
  }

  if(level.var_AC80.var_2914.size == 0) {
    return undefined;
  }

  var_04 = undefined;
  if(param_02) {
    var_05 = common_scripts\utility::func_0F92(lib_055A::func_4691());
  } else if(isDefined(var_04)) {
    var_05 = common_scripts\utility::func_0F92(lib_055A::func_4693(var_04));
  } else {
    var_05 = common_scripts\utility::func_0F92(lib_055A::func_4692());
  }

  var_06 = [];
  foreach(var_08 in var_05) {
    if((var_08 lib_055A::func_905D() || isDefined(param_03)) && var_08 lib_055A::func_905C(param_00, param_01) && isDefined(param_03) || (param_02 || lib_055A::func_583C(var_08.var_0116)) && var_08 lib_055A::func_582C()) {
      var_04 = var_08;
      break;
    }
  }

  if(!isDefined(var_04) && common_scripts\utility::func_562E(level.var_7D20)) {
    var_0A = common_scripts\utility::func_0F92(level.var_AC4F);
    foreach(var_08 in var_0A) {
      if(var_08 lib_055A::func_905D() && var_08 lib_055A::func_905C(param_00, param_01)) {
        var_04 = var_08;
        break;
      }
    }
  }

  if(!isDefined(var_04)) {
    var_11 = randomint(level.var_AC80.var_2914.size);
    var_12 = level.var_AC80.var_2914[var_11];
    var_13 = level.var_AC80.var_ACB3[var_12];
    foreach(var_08 in var_13.var_ABFE) {
      if(var_08 lib_055A::func_905C(param_00, param_01)) {
        var_04 = var_08;
        break;
      }
    }
  }

  return var_04;
}

lib_055A::func_1E58(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    var_04 = [param_03];
  } else {
    var_04 = level.var_AC80.var_2914;
  }

  var_05 = [];
  foreach(var_07 in var_04) {
    var_08 = level.var_AC80.var_ACB3[var_07];
    var_05 = common_scripts\utility::func_0F73(var_05, var_08.var_ABFE);
  }

  var_0A = lib_0558::func_4746(var_05, param_00, param_01);
  var_0A.var_5BE2 = gettime();
  return var_0A;
}

lib_055A::func_1E4E(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    var_04 = [param_03];
  } else {
    var_04 = level.var_AC80.var_2914;
  }

  var_09 = [];
  foreach(var_07 in var_04) {
    var_0B = level.var_AC80.var_ACB3[var_07];
    foreach(var_0D in var_0B.var_ABFE) {
      if(!var_0D lib_055A::func_905D()) {
        continue;
      }

      if(!var_0D lib_055A::func_905C(param_00, param_01)) {
        continue;
      }

      if(!var_0D lib_055A::func_582C()) {
        continue;
      }

      if(isDefined(var_0D.var_8109) && common_scripts\utility::func_562E(var_0D.var_50D5)) {
        continue;
      }

      var_09[var_09.size] = var_0D;
    }
  }

  var_10 = 2;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_15 in level.var_744A) {
    if(!isalive(var_15) || common_scripts\utility::func_562E(var_15.var_5378)) {
      continue;
    }

    var_16 = 0;
    foreach(var_18 in var_13) {
      if(isDefined(var_18.var_0088) && var_18.var_0088 == var_15) {
        var_16++;
      }
    }

    if(common_scripts\utility::func_562E(var_15.var_AC5B)) {
      var_16 = var_13.size;
    }

    var_16 = var_16 + randomfloat(var_10);
    if(!isDefined(var_12) || var_16 < var_12) {
      var_12 = var_16;
      var_11 = var_15;
    }
  }

  if(!isDefined(var_11)) {
    return common_scripts\utility::func_7A33(var_09);
  }

  var_1B = 20;
  var_1C = 0.3;
  var_1D = 0.2;
  var_1E = common_scripts\utility::func_5D93(level.var_A980, 1, 10, 40, 80);
  var_1F = 10;
  var_20 = 3;
  var_21 = 2;
  var_22 = undefined;
  var_23 = undefined;
  foreach(var_25 in var_09) {
    var_05 = "";
    var_26 = 0;
    if(common_scripts\utility::func_562E(var_25.var_8C95)) {
      var_26 = var_26 + var_20;
      var_27 = var_25.var_487C;
    } else {
      var_27 = var_25.var_0116;
      var_25 lib_054D::func_A0DA();
      var_26 = var_26 + var_1F * var_25.var_AC3D.size;
      if(isDefined(var_25.var_3C5B) && lib_0547::func_562C(var_25.var_3C5B)) {
        var_26 = var_26 + var_21 * var_25.var_3C5B.var_15CB.var_17EC;
      }
    }

    var_28 = function_038E(var_27, var_11.var_0116);
    var_26 = var_26 + var_28 / var_1E;
    var_26 = var_26 / common_scripts\utility::func_5D93(vectordot(vectornormalize(var_11 getvelocity()), vectornormalize(var_27 - var_11.var_0116)), 0, 1, 1, 1 + var_1D);
    var_26 = var_26 + randomfloat(var_26 * var_1C + var_1B);
    if(!isDefined(var_22) || var_26 < var_22) {
      var_22 = var_26;
      var_23 = var_25;
    }
  }

  return var_23;
}

lib_055A::func_905C(param_00, param_01) {
  if(isDefined(self.var_8260)) {
    var_02 = strtok(self.var_8260, " ,");
    var_03 = 0;
    var_04 = 0;
    foreach(var_06 in var_02) {
      if(var_06 == param_00) {
        var_03 = 1;
      }

      if(var_06 == "exclusive") {
        var_04 = 1;
      }
    }

    if(!var_03 && var_04 || param_01) {
      return 0;
    }
  } else if(param_01) {
    return 0;
  }

  return 1;
}

lib_055A::func_905D() {
  if(common_scripts\utility::func_562E(self.var_3A1B)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(self.is_zombies_spawner_script_disabled)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(level.var_7D20) && !isDefined(self.var_819A)) {
    return 0;
  } else if(common_scripts\utility::func_562E(level.var_38D1) && !isDefined(self.var_819A)) {
    var_00 = level.var_AC80.var_ACB3[self.var_AC8A];
    foreach(var_03, var_02 in var_00.var_9050) {
      if(common_scripts\utility::func_3C77(var_03)) {
        return 0;
      }
    }
  }

  if(isDefined(self.var_819A)) {
    if(!common_scripts\utility::func_3C77(self.var_819A)) {
      return 0;
    }
  }

  return 1;
}

lib_055A::func_8729(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_00)) {
    level.var_38D2[param_01] = 1;
  } else {
    level.var_38D2[param_01] = undefined;
  }

  if(level.var_38D2.size > 0) {
    level.var_38D1 = 1;
    return;
  }

  level.var_38D1 = undefined;
}

lib_055A::func_8712(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_00)) {
    level.var_7D21[param_01] = 1;
  } else {
    level.var_7D21[param_01] = undefined;
  }

  if(level.var_7D21.size > 0) {
    level.var_7D20 = 1;
    return;
  }

  level.var_7D20 = undefined;
}

lib_055A::func_ACA1() {
  var_00 = common_scripts\utility::func_46B5(self.var_AC8A, "targetname");
  if(isDefined(var_00)) {
    var_01 = getclosestpointonnavmesh(var_00.var_0116);
    self.var_74DC = var_01;
    return;
  }

  foreach(var_03 in lib_050D::func_44F9("allies")) {
    if(lib_0547::func_5565(var_03.var_0165, self.var_AC8A)) {
      var_01 = getclosestpointonnavmesh(var_03.var_0116);
      self.var_74DC = var_01;
      return;
    }
  }

  foreach(var_06 in self.var_A615) {
    var_07 = var_06 method_8216(0, 0, 0);
    var_08 = getclosestpointonnavmesh(var_07);
    if(ispointinvolume(var_08, var_06)) {
      self.var_74DC = var_08;
      return;
    }
  }
}

lib_055A::func_ACB0(param_00) {
  var_01 = "mp/zombieZoneTable.csv";
  var_02 = function_027B(var_01);
  return tablelookup(var_01, 0, param_00, 1);
}

lib_055A::func_ACAC() {
  if(common_scripts\utility::func_562E(level.var_ACA3)) {
    return;
  }

  foreach(var_07, var_01 in level.var_AC80.var_ACB3) {
    var_02 = lib_055A::func_ACB0(var_07);
    var_01.var_ACAD = var_02 != "";
  }

  maps\mp\_utility::func_6F74(::zonehudupdateplayerthread);
}

zonehudupdateplayerthread() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00.var_ACA6 = [];
  var_00 thread lib_055A::func_ACAB();
  foreach(var_03, var_02 in level.var_AC80.var_ACB3) {
    var_00 common_scripts\utility::func_3799(var_03);
  }

  for(;;) {
    var_03 = var_00 lib_055A::func_462D();
    if(!isDefined(var_03)) {} else {
      var_02 = level.var_AC80.var_ACB3[var_03];
      if(lib_0547::func_5565(var_00.var_5BB6, var_03)) {} else {
        var_05 = "unknown";
        if(isDefined(var_00.var_5BB6)) {
          var_05 = var_00.var_5BB6;
        }

        var_00 lib_055A::func_ACA7("ui_zm_previous_zone_name", var_05);
        var_00 lib_055A::func_ACA7("ui_zm_current_zone_name", var_03);
        var_06 = "ui_zm_player_" + var_00 getentitynumber() + "_zone_name";
        setomnvar(var_06, var_03);
        var_00.var_5BB6 = var_03;
        if(!var_00 common_scripts\utility::func_3794(var_03)) {
          var_00 common_scripts\utility::func_379A(var_03);
        }
      }
    }

    wait 0.05;
  }
}

lib_055A::func_ACAB() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    if(var_00.var_ACA6.size == 0) {
      var_00 waittill("ZoneHud");
    }

    var_01 = var_00.var_ACA6[0];
    var_00.var_ACA6 = common_scripts\utility::func_0F9A(var_00.var_ACA6, 0);
    var_00[[var_01.var_1E61]](var_01.var_2A35);
  }
}

lib_055A::func_ACA8(param_00) {
  var_01 = self;
  var_01 lib_055A::func_ACA2(param_00, ::lib_055A::func_ACAA);
}

lib_055A::func_ACA7(param_00, param_01) {
  var_02 = self;
  var_03 = spawnStruct();
  var_03.var_6A70 = param_00;
  var_03.var_6A71 = param_01;
  var_02 lib_055A::func_ACA2(var_03, ::lib_055A::func_ACA9);
}

lib_055A::func_ACA2(param_00, param_01) {
  var_02 = self;
  var_03 = spawnStruct();
  var_03.var_2A35 = param_00;
  var_03.var_1E61 = param_01;
  var_02.var_ACA6 = common_scripts\utility::func_0F6F(var_02.var_ACA6, var_03);
  var_02 notify("ZoneHud");
}

lib_055A::func_ACAA(param_00) {
  wait(param_00);
}

lib_055A::func_ACA9(param_00) {
  var_01 = self;
  var_02 = param_00.var_6A70;
  var_03 = param_00.var_6A71;
  var_01 setclientomnvar(var_02, var_03);
}