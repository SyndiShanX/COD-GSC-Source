/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_airstrike.gsc
**********************************************/

func_00D5() {
  level.var_80B7["airstrike"] = 400;
  level.var_80B8["airstrike"] = 75;
  level.var_80B6["airstrike"] = -1;
  level.var_80B9["airstrike"] = 6;
  level.var_80B5["airstrike"] = 8;
  level.var_5A61["airstrike"] = ::func_9E23;
  level.var_5A7D["airstrike_bomb_mp"] = "airstrike";
  level.var_5A7D["airstrike_bomb_axis_mp"] = "airstrike";
}

func_9E23(param_00) {
  if(lib_0527::func_9E35(param_00, "airstrike")) {
    self.var_0B95 = 0;
    return 1;
  }

  return 0;
}

func_0B9A(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  if(isDefined(param_02)) {
    param_02 endon("disconnect");
  }

  level.var_2000 = 1;
  if(isDefined(param_02)) {
    param_02 thread func_6B75();
  }

  if(maps\mp\_utility::func_579B() && isDefined(param_03) && isDefined(level.var_79C2.var_80B0) && isDefined(level.var_79C2.var_80B0.var_0B9C)) {
    thread[[level.var_79C2.var_80B0.var_0B9C]](4);
  } else {
    thread func_11DA();
  }

  var_06 = 0;
  if(isDefined(param_02)) {
    var_06 = param_02 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  }

  var_07 = 3;
  if(var_06) {
    var_07 = 4;
  }

  if(maps\mp\_utility::func_579B() && isDefined(param_03) && isDefined(level.var_79C2.var_80B0) && isDefined(level.var_79C2.var_80B0.var_0B98)) {
    var_07 = exp(3 * level.var_79C2.var_80B0.var_0B98);
  }

  if(isDefined(level.var_0811) && level.var_0811) {
    var_07 = 1;
  }

  for(var_08 = 0; var_08 < var_07 && !maps\mp\_utility::func_5668(0, param_03); var_08++) {
    if(isDefined(level.var_0811) && level.var_0811) {
      wait(1);
    } else {
      wait(4);
    }

    var_09 = lib_0527::func_4570();
    if(maps\mp\_utility::func_4571() == "mp_airship") {
      var_09 = var_09 - 180;
    }

    var_0A = [];
    for(var_0B = -5; var_0B < 6; var_0B++) {
      var_0C = spawnStruct();
      var_0C.var_0116 = (level.var_5FEB[0] + cos(var_09 + 90) * var_0B * 700, level.var_5FEB[1] + sin(var_09 + 90) * var_0B * 700, level.var_5FEB[2]);
      var_0C.var_7F31 = abs(abs(var_0B) - 5 / 50);
      var_0A[var_0A.size] = var_0C;
    }

    if(isDefined(param_03)) {
      if(isDefined(param_05)) {
        var_09 = param_05;
      }

      if(isDefined(param_04)) {
        thread lib_0527::func_9302(param_00, [param_04], [var_09], param_01, param_03);
      } else {
        var_0D = func_4435(var_0A, var_09, param_03);
        thread lib_0527::func_9302(param_00, [var_0D.var_0116], [var_09], param_01, param_03);
      }
    } else {
      var_0D = param_02 func_4435(var_0A, var_09);
      param_02 thread lib_0527::func_9302(param_00, [var_0D.var_0116], [var_09], param_01);
    }

    if(var_06) {
      wait(7.5);
      continue;
    }

    wait(10);
  }

  wait(4);
  level.var_2000 = undefined;
  level notify("carpetBombingEnded");
  if(isDefined(param_02)) {
    param_02 notify("carpetBombingEnded");
  }
}

func_11DA() {
  var_00 = lib_0380::func_2889("mp_ks_air_raid_siren", undefined, level.var_5FEB + (0, 0, 200));
}

func_4435(param_00, param_01, param_02) {
  foreach(var_04 in level.var_744A) {
    if(!maps\mp\_utility::func_57A0(var_04)) {
      continue;
    }

    if(isDefined(param_02)) {
      if(level.var_984D && var_04.var_01A7 == param_02) {
        continue;
      }
    } else if(level.var_984D && var_04.var_01A7 == self.var_01A7 && var_04 != self) {
      continue;
    }

    if(var_04.var_01A7 == "spectator") {
      continue;
    }

    var_05 = 999999999;
    var_06 = undefined;
    var_07 = 999999999;
    var_08 = undefined;
    foreach(var_0A in param_00) {
      var_0B = distance2d((var_0A.var_0116[0] * cos(param_01 + 90), var_0A.var_0116[1] * sin(param_01 + 90), 0), (var_04.var_0116[0] * cos(param_01 + 90), var_04.var_0116[1] * sin(param_01 + 90), 0));
      if(var_0B <= var_05) {
        var_07 = var_05;
        var_08 = var_06;
        var_05 = var_0B;
        var_06 = var_0A;
      } else if(var_0B <= var_07) {
        var_07 = var_0B;
        var_08 = var_0A;
      }

      if(isDefined(self) && var_04 == self && var_0B <= 1000) {
        if(maps\mp\_utility::func_4571() != "mp_shipment_s2" && maps\mp\_utility::func_4571() != "mp_sandbox_01") {
          if(!bullettracepassed(var_04.var_0116 + (0, 0, 32), var_04.var_0116 + (0, 0, 10000), 0, var_04)) {
            var_0A.var_7F31 = var_0A.var_7F31 - 3.25;
            continue;
          }

          var_0A.var_7F31 = var_0A.var_7F31 - 6;
        }
      }
    }

    if(isDefined(self) && var_04 == self) {
      continue;
    } else {
      if(!bullettracepassed(var_04.var_0116 + (0, 0, 32), var_04.var_0116 + (0, 0, 10000), 0, var_04)) {
        var_06.var_7F31 = var_06.var_7F31 + 0.75;
        var_08.var_7F31 = var_08.var_7F31 + 0.5;
        continue;
      }

      var_06.var_7F31 = var_06.var_7F31 + 2.5;
      var_08.var_7F31 = var_08.var_7F31 + 1.75;
    }
  }

  if(isDefined(param_02)) {
    var_0E = param_02;
  } else {
    var_0E = self.var_01A7;
  }

  var_0F = level.var_7AD1[maps\mp\_utility::func_45DE(var_0E)];
  if(!level.var_984D) {
    var_0F = level.var_7AD1["all"];
  }

  foreach(var_11 in var_0F) {
    if(!level.var_984D && var_11["player"] == self.var_48CA) {
      continue;
    }

    var_05 = 999999999;
    var_06 = undefined;
    var_07 = 999999999;
    var_08 = undefined;
    foreach(var_0A in param_00) {
      var_0B = distance2d((var_0A.var_0116[0] * cos(param_01 + 90), var_0A.var_0116[1] * sin(param_01 + 90), 0), (var_11["position"][0] * cos(param_01 + 90), var_11["position"][1] * sin(param_01 + 90), 0));
      if(var_0B <= var_05) {
        var_07 = var_05;
        var_08 = var_06;
        var_05 = var_0B;
        var_06 = var_0A;
        continue;
      }

      if(var_0B <= var_07) {
        var_07 = var_0B;
        var_08 = var_0A;
      }
    }

    if(!bullettracepassed(var_11["position"] + (0, 0, 32), var_11["position"] + (0, 0, 10000), 0, undefined)) {
      var_06.var_7F31 = var_06.var_7F31 + 0.075;
      var_08.var_7F31 = var_08.var_7F31 + 0.05;
      continue;
    }

    var_06.var_7F31 = var_06.var_7F31 + 0.125;
    var_08.var_7F31 = var_08.var_7F31 + 0.1;
  }

  var_15 = param_00[0];
  foreach(var_0A in param_00) {
    if(var_0A.var_7F31 > var_15.var_7F31) {
      var_15 = var_0A;
      continue;
    }

    if(var_0A.var_7F31 == var_15.var_7F31) {
      if(common_scripts\utility::func_24A6()) {
        var_15 = var_0A;
      }
    }
  }

  return var_15;
}

func_6B75() {
  self endon("carpetBombingEnded");
  self waittill("disconnect");
  level.var_2000 = undefined;
  level.var_0B93 = undefined;
  level notify("aud_carpet_bomb_killed");
}