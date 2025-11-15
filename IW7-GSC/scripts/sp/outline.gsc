/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\outline.gsc
**********************************/

func_918F() {
  level.var_91AA = [];
  func_9188("default", 0, ::func_9192);
  setsaveddvar("r_hudoutlineEnable", 1);
}

func_9197(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_04)) {
    param_04 = 0;
  }

  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  if(!isDefined(level.var_91AA)) {
    func_918F();
  }

  if(func_919F(param_00, self)) {
    func_91A7(param_00, self, param_01, param_02, param_03, param_04);
  } else {
    var_05 = level.var_91AA[param_00].var_6631.size;
    level.var_91AA[param_00].var_6631[var_05] = func_9190(self, param_01, param_02, param_03, param_04);
    thread func_9195(param_00);
  }

  if(!isDefined(level.var_91AA[param_00].var_C8F5)) {
    if(!isDefined(level.var_91AB)) {
      func_9186(param_00);
    }

    var_06 = level.var_91AA[level.var_91AB].priority;
    var_07 = level.var_91AA[param_00].priority;
    if(level.var_91AB != param_00 && var_06 < var_07) {
      func_9186(param_00);
      return;
    }

    if(level.var_91AB == param_00) {
      func_1251(self, param_01, param_02, param_03, param_04, param_00);
      return;
    }

    return;
  }

  var_08 = level.var_91AA[param_01].var_C8F5;
  if(!isDefined(level.var_91AB)) {
    func_9186(var_08);
  }

  var_06 = level.var_91AA[level.var_91AB].priority;
  var_09 = level.var_91AA[var_08].priority;
  if(level.var_91AB != var_08 && var_06 < var_09) {
    func_9186(var_08);
    return;
  }

  if(level.var_91AB == var_08) {
    func_1251(self, param_01, param_02, param_03, param_04, var_08);
    return;
  }
}

func_9194(param_00) {
  if(!isDefined(param_00)) {
    param_00 = "default";
  }

  if(!isDefined(level.var_91AA)) {
    return;
  }

  if(isDefined(self)) {
    self notify(param_00 + "hudoutline_disable");
  }

  var_01 = undefined;
  foreach(var_04, var_03 in level.var_91AA[param_00].var_6631) {
    if(!isDefined(var_03.ent)) {
      level.var_91AA[param_00].var_6631[var_04] = undefined;
      continue;
    }

    if(var_03.ent == self) {
      var_01 = var_04;
      level.var_91AA[param_00].var_6631[var_01] = undefined;
      break;
    }
  }

  var_05 = [];
  foreach(var_07 in level.var_91AA[param_00].var_6631) {
    if(!isDefined(var_07)) {
      continue;
    }

    var_05[var_05.size] = var_07;
  }

  level.var_91AA[param_00].var_6631 = var_05;
  if(!isDefined(level.var_91AB)) {
    return;
  }

  if(level.var_91AB == param_00) {
    if(isDefined(var_01)) {
      func_11DA(self, param_00);
    }

    if(level.var_91AA[param_00].var_6631.size == 0) {
      var_08 = 0;
      if(isDefined(level.var_91AA[param_00].var_3E65) && level.var_91AA[param_00].var_3E65.size > 0) {
        foreach(var_0A in level.var_91AA[param_00].var_3E65) {
          if(level.var_91AA[var_0A].var_6631.size > 0) {
            var_08 = 1;
            break;
          }
        }
      }

      if(!var_08) {
        func_9185();
        return;
      }

      return;
    }

    return;
  }

  if(isDefined(level.var_91AA[var_01].var_C8F5) && level.var_91AB == level.var_91AA[var_01].var_C8F5) {
    var_0C = level.var_91AA[var_01].var_C8F5;
    if(isDefined(var_02)) {
      func_11DA(self, var_0C);
    }

    if(level.var_91AA[var_01].var_6631.size == 0) {
      func_9185();
      return;
    }
  }
}

func_9185() {
  var_00 = undefined;
  var_01 = undefined;
  if(isDefined(level.var_91AC) && level.var_91AC.size > 0) {
    foreach(var_03 in level.var_91AC) {
      if(!isDefined(var_00) || level.var_91AA[var_03].priority > var_00) {
        var_00 = level.var_91AA[var_03].priority;
        var_01 = var_03;
      }
    }
  } else {
    foreach(var_03 in level.var_91AA) {
      if(isDefined(var_03.var_C8F5)) {
        continue;
      }

      if(!isDefined(var_03.var_3E65) || var_03.var_3E65.size == 0) {
        if(var_03.var_6631.size == 0) {
          continue;
        }
      } else {
        var_06 = 0;
        if(var_03.var_6631.size > 0) {
          var_06 = 1;
        }

        foreach(var_08 in var_03.var_3E65) {
          if(level.var_91AA[var_08].var_6631.size > 0) {
            var_06 = 1;
          }
        }

        if(!var_06) {
          continue;
        }
      }

      if(!isDefined(var_00) || var_03.priority > var_00) {
        var_00 = var_03.priority;
        var_01 = var_03.var_3C65;
      }
    }
  }

  if(isDefined(var_01)) {
    func_9186(var_01);
    return;
  }

  level.var_91AB = undefined;
}

func_9190(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnStruct();
  var_05.ent = param_00;
  var_05.var_4395 = param_01;
  var_05.var_5259 = param_02;
  var_05.var_6C0F = param_03;
  var_05.var_10F87 = param_04;
  return var_05;
}

func_91A7(param_00, param_01, param_02, param_03, param_04, param_05) {
  foreach(var_07 in level.var_91AA[param_00].var_6631) {
    if(var_07.ent == param_01) {
      var_07.var_4395 = param_02;
      var_07.var_5259 = param_03;
      var_07.var_6C0F = param_04;
      var_07.var_10F87 = param_05;
    }
  }
}

func_9186(param_00) {
  if(isDefined(level.var_91AB) && level.var_91AB != param_00) {
    func_9191(level.var_91AB);
    if(isDefined(level.var_91AA[level.var_91AB].var_3E65) && level.var_91AA[level.var_91AB].var_3E65.size > 0) {
      foreach(var_02 in level.var_91AA[level.var_91AB].var_3E65) {
        func_9191(var_02);
      }
    }
  }

  level.var_91AB = param_00;
  thread func_91A5(param_00);
  func_1250(param_00);
}

func_1250(param_00) {
  var_01 = func_12AA(param_00);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    foreach(var_04 in level.var_91AA[var_01[var_02]].var_6631) {
      var_05 = var_04.ent;
      var_05 hudoutlineenable(var_04.var_4395, var_04.var_5259, var_04.var_6C0F, var_04.var_10F87);
    }
  }
}

func_1251(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.var_91AA[param_05].var_3E65) || level.var_91AA[param_05].var_3E65.size == 0) {
    param_00 hudoutlineenable(param_01, param_02, param_03, param_04);
    return;
  }

  var_06 = func_12AA(param_05, 1);
  var_07 = 0;
  for(var_08 = 0; var_08 < var_06.size; var_08++) {
    foreach(var_0A in level.var_91AA[var_06[var_08]].var_6631) {
      if(var_0A.ent == param_00) {
        param_00 hudoutlineenable(var_0A.var_4395, var_0A.var_5259, var_0A.var_6C0F, var_0A.var_10F87);
        var_07 = 1;
        break;
      }
    }

    if(var_07) {
      break;
    }
  }
}

func_11DA(param_00, param_01) {
  if(!isDefined(level.var_91AA[param_01].var_3E65) || level.var_91AA[param_01].var_3E65.size == 0) {
    self hudoutlinedisable();
    return;
  }

  var_02 = func_12AA(param_01, 1);
  var_03 = 0;
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    foreach(var_06 in level.var_91AA[var_02[var_04]].var_6631) {
      if(var_06.ent == param_00) {
        param_00 hudoutlineenable(var_06.var_4395, var_06.var_5259, var_06.var_6C0F, var_06.var_10F87);
        var_03 = 1;
        break;
      }
    }

    if(var_03) {
      break;
    }
  }

  if(!var_03) {
    self hudoutlinedisable();
  }
}

func_91A5(param_00) {
  level notify("hudoutline_new_channel_settings");
  level endon("hudoutline_new_channel_settings");
  wait(0.05);
  var_01 = func_9192();
  var_02 = [
    [level.var_91AA[param_00].var_F88E]
  ]();
  foreach(var_05, var_04 in var_01) {
    if(isDefined(var_02[var_05])) {
      setsaveddvar(var_05, var_02[var_05]);
      continue;
    }

    setsaveddvar(var_05, var_04);
  }

  if(isDefined(level.var_91AA[param_00].var_B05E)) {
    func_CC8D(param_00, level.var_91AA[param_00].var_B05E);
  }
}

func_9191(param_00) {
  foreach(var_02 in level.var_91AA[param_00].var_6631) {
    var_03 = var_02.ent;
    var_03 hudoutlinedisable();
  }
}

func_9188(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = ::func_9192;
  }

  if(!isDefined(level.var_91AA)) {
    func_918F();
  }

  if(!isDefined(level.var_91AA[param_00])) {
    level.var_91AA[param_00] = spawnStruct();
    level.var_91AA[param_00].var_3C65 = param_00;
    level.var_91AA[param_00].priority = param_01;
    level.var_91AA[param_00].var_F88E = param_02;
    level.var_91AA[param_00].var_6631 = [];
  }
}

func_918A(param_00, param_01, param_02) {
  if(!isDefined(level.var_91AA[param_00])) {
    level.var_91AA[param_00] = spawnStruct();
    level.var_91AA[param_00].var_3C65 = param_00;
    level.var_91AA[param_00].priority = param_01;
    level.var_91AA[param_00].var_6631 = [];
    level.var_91AA[param_00].var_C8F5 = param_02;
  }

  if(!isDefined(level.var_91AA[param_02].var_3E65)) {
    level.var_91AA[param_02].var_3E65 = [];
  }

  level.var_91AA[param_02].var_3E65[level.var_91AA[param_02].var_3E65.size] = param_00;
}

func_91A1(param_00, param_01) {
  level.var_91AA[param_00].var_F88E = param_01;
  if(isDefined(level.var_91AB) && level.var_91AB == param_00) {
    thread func_91A5(param_00);
  }
}

func_919F(param_00, param_01) {
  foreach(var_03 in level.var_91AA[param_00].var_6631) {
    if(var_03.ent == param_01) {
      return 1;
    }
  }

  return 0;
}

func_919A(param_00, param_01) {
  if(!isDefined(level.var_91AC)) {
    level.var_91AC = [];
  }

  if(param_01) {
    foreach(var_03 in level.var_91AC) {
      if(var_03 == param_00) {
        return;
      }
    }

    level.var_91AC[level.var_91AC.size] = param_00;
    func_9185();
    return;
  }

  var_05 = [];
  foreach(var_03 in level.var_91AC) {
    if(var_03 != param_00) {
      var_05[var_05.size] = var_03;
    }
  }

  level.var_91AC = var_05;
  func_9185();
}

func_9195(param_00, param_01) {
  if(isDefined(param_01)) {
    self endon("endonMsg");
  }

  self endon(param_00 + "hudoutline_disable");
  scripts\engine\utility::waittill_any_3("death", "entitydeleted");
  thread func_9194(param_00);
}

func_CC8D(param_00, param_01) {
  if(!isDefined(level.var_91AB) || level.var_91AB != param_00) {
    return;
  }

  level notify("hudoutline_new_anim_on_channel_" + param_00);
  level endon("hudoutline_new_channel_settings");
  level endon("hudoutline_new_anim_on_channel_" + param_00);
  level[[param_01]]();
  thread func_91A5(param_00);
}

func_CC8E(param_00, param_01) {
  level.var_91AA[param_00].var_B05E = param_01;
  if(!isDefined(level.var_91AB) || level.var_91AB != param_00) {
    return;
  }

  func_CC8D(param_00, param_01);
}

func_9192() {
  var_00 = [];
  if(isDefined(level.player.var_20F8)) {
    var_01 = length2d(level.player.origin - level.player.var_20F8.origin);
    var_02 = clamp(var_01 / 1000, 1, 2);
    var_00["r_hudoutlineWidth"] = var_02;
  } else {
    var_00["r_hudoutlineWidth"] = 1;
  }

  var_00["r_hudoutlineFillColor0"] = "0.9 0.9 0.9 0.5";
  var_00["r_hudoutlineFillColor1"] = "0.3 0.3 0.3 0.5";
  var_00["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  var_00["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.45";
  var_00["r_hudoutlineOccludedInteriorColor"] = ".7 .7 .7 0.25";
  var_00["r_hudOutlineOccludedColorFromFill"] = 1;
  var_00["r_drawTransEIDListBeforeOpaques"] = 0;
  var_00["cg_hud_outline_colors_0"] = "0.000 0.000 0.000 0.000";
  var_00["cg_hud_outline_colors_1"] = "0.882 0.882 0.882 1.000";
  var_00["cg_hud_outline_colors_2"] = "0.945 0.384 0.247 1.000";
  var_00["cg_hud_outline_colors_3"] = "0.431 0.745 0.235 1.000";
  var_00["cg_hud_outline_colors_4"] = "0.157 0.784 0.784 1.000";
  var_00["cg_hud_outline_colors_5"] = "0.886 0.600 0.000 1.000";
  var_00["cg_hud_outline_colors_6"] = "0.000 0.000 0.000 0.000";
  var_00["cg_hud_outline_colors_7"] = "0.76 0.89 0.89 1.0";
  return var_00;
}

func_12AA(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = [];
  var_02[0] = param_00;
  if(isDefined(level.var_91AA[param_00].var_3E65) && level.var_91AA[param_00].var_3E65.size > 0) {
    foreach(var_04 in level.var_91AA[param_00].var_3E65) {
      if(level.var_91AA[var_04].var_6631.size > 0) {
        for(var_05 = 0; var_05 < var_02.size; var_05++) {
          if(!param_01) {
            if(level.var_91AA[var_02[var_05]].priority >= level.var_91AA[var_04].priority) {
              var_02 = func_C76D(var_02, var_04, var_05);
              break;
            } else if(var_05 + 1 == var_02.size) {
              var_02[var_05 + 1] = var_04;
              break;
            }

            continue;
          }

          if(level.var_91AA[var_02[var_05]].priority < level.var_91AA[var_04].priority) {
            var_02 = func_C76D(var_02, var_04, var_05);
            break;
          } else if(var_05 + 1 == var_02.size) {
            var_02[var_05 + 1] = var_04;
            break;
          }
        }
      }
    }
  }

  return var_02;
}

func_C76D(param_00, param_01, param_02) {
  if(param_02 == param_00.size) {
    var_03 = param_00;
    var_03[var_03.size] = param_01;
    return var_03;
  }

  var_03 = [];
  var_04 = 0;
  for(var_05 = 0; var_05 < param_00.size; var_05++) {
    if(var_05 == param_02) {
      var_03[var_05] = param_01;
      var_04 = 1;
    }

    var_03[var_05 + var_04] = param_00[var_05];
  }

  return var_03;
}