/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2904.gsc
***************************************/

func_918F() {
  level.func_91AA = [];
  func_9188("default", 0, ::func_9192);
  _setsaveddvar("r_hudoutlineEnable", 1);
}

func_9197(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04)) {
    var_04 = 0;
  }

  if(!isDefined(var_00)) {
    var_00 = "default";
  }

  if(!isDefined(level.func_91AA)) {
    func_918F();
  }

  if(func_919F(var_00, self)) {
    func_91A7(var_00, self, var_01, var_02, var_03, var_04);
  }
  else {
    var_05 = level.func_91AA[var_00].func_6631.size;
    level.func_91AA[var_00].func_6631[var_05] = func_9190(self, var_01, var_02, var_03, var_04);
    thread func_9195(var_00);
  }

  if(!isDefined(level.func_91AA[var_00].func_C8F5)) {
    if(!isDefined(level.func_91AB)) {
      func_9186(var_00);
    }

    var_06 = level.func_91AA[level.func_91AB].priority;
    var_07 = level.func_91AA[var_00].priority;

    if(level.func_91AB != var_00 && var_06 < var_07) {
      func_9186(var_00);
      return;
    }

    if(level.func_91AB == var_00) {
      func_1251(self, var_01, var_02, var_03, var_04, var_00);
      return;
    }

    return;
  } else {
    var_08 = level.func_91AA[var_00].func_C8F5;

    if(!isDefined(level.func_91AB)) {
      func_9186(var_08);
    }

    var_06 = level.func_91AA[level.func_91AB].priority;
    var_09 = level.func_91AA[var_08].priority;

    if(level.func_91AB != var_08 && var_06 < var_09) {
      func_9186(var_08);
    }
    else if(level.func_91AB == var_08) {
      func_1251(self, var_01, var_02, var_03, var_04, var_08);
    }
  }
}

func_9194(var_00) {
  if(!isDefined(var_00)) {
    var_00 = "default";
  }

  if(!isDefined(level.func_91AA)) {
    return;
  }
  if(isDefined(self)) {
    self notify(var_00 + "hudoutline_disable");
  }

  var_01 = undefined;

  foreach(var_04, var_03 in level.func_91AA[var_00].func_6631) {
    if(!isDefined(var_3.ent)) {
      level.func_91AA[var_00].func_6631[var_04] = undefined;
      continue;
    }

    if(var_3.ent == self) {
      var_01 = var_04;
      level.func_91AA[var_00].func_6631[var_01] = undefined;
      break;
    }
  }

  var_05 = [];

  foreach(var_04, var_07 in level.func_91AA[var_00].func_6631) {
    if(!isDefined(var_07)) {
      continue;
    }
    var_5[var_5.size] = var_07;
  }

  level.func_91AA[var_00].func_6631 = var_05;

  if(!isDefined(level.func_91AB)) {
    return;
  }
  if(level.func_91AB == var_00) {
    if(isDefined(var_01)) {
      func_11DA(self, var_00);
    }

    if(level.func_91AA[var_00].func_6631.size == 0) {
      var_08 = 0;

      if(isDefined(level.func_91AA[var_00].func_3E65) && level.func_91AA[var_00].func_3E65.size > 0) {
        foreach(var_10 in level.func_91AA[var_00].func_3E65) {
          if(level.func_91AA[var_10].func_6631.size > 0) {
            var_08 = 1;
            break;
          }
        }
      }

      if(!var_08) {
        func_9185();
      }
    }
  } else if(isDefined(level.func_91AA[var_00].func_C8F5) && level.func_91AB == level.func_91AA[var_00].func_C8F5) {
    var_12 = level.func_91AA[var_00].func_C8F5;

    if(isDefined(var_01)) {
      func_11DA(self, var_12);
    }

    if(level.func_91AA[var_00].func_6631.size == 0) {
      func_9185();
    }
  }
}

func_9185() {
  var_00 = undefined;
  var_01 = undefined;

  if(isDefined(level.func_91AC) && level.func_91AC.size > 0) {
    foreach(var_03 in level.func_91AC) {
      if(!isDefined(var_00) || level.func_91AA[var_03].priority > var_00) {
        var_00 = level.func_91AA[var_03].priority;
        var_01 = var_03;
      }
    }
  } else {
    foreach(var_03 in level.func_91AA) {
      if(isDefined(var_3.func_C8F5)) {
        continue;
      }
      if(!isDefined(var_3.func_3E65) || var_3.func_3E65.size == 0) {
        if(var_3.func_6631.size == 0) {
          continue;
        }
      } else {
        var_06 = 0;

        if(var_3.func_6631.size > 0) {
          var_06 = 1;
        }

        foreach(var_08 in var_3.func_3E65) {
          if(level.func_91AA[var_08].func_6631.size > 0) {
            var_06 = 1;
          }
        }

        if(!var_06) {
          continue;
        }
      }

      if(!isDefined(var_00) || var_3.priority > var_00) {
        var_00 = var_3.priority;
        var_01 = var_3.func_3C65;
      }
    }
  }

  if(isDefined(var_01)) {
    func_9186(var_01);
  }
  else {
    level.func_91AB = undefined;
  }
}

func_9190(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnStruct();
  var_5.ent = var_00;
  var_5.func_4395 = var_01;
  var_5.func_5259 = var_02;
  var_5.func_6C0F = var_03;
  var_5.func_10F87 = var_04;
  return var_05;
}

func_91A7(var_00, var_01, var_02, var_03, var_04, var_05) {
  foreach(var_07 in level.func_91AA[var_00].func_6631) {
    if(var_7.ent == var_01) {
      var_7.func_4395 = var_02;
      var_7.func_5259 = var_03;
      var_7.func_6C0F = var_04;
      var_7.func_10F87 = var_05;
    }
  }
}

func_9186(var_00) {
  if(isDefined(level.func_91AB) && level.func_91AB != var_00) {
    func_9191(level.func_91AB);

    if(isDefined(level.func_91AA[level.func_91AB].func_3E65) && level.func_91AA[level.func_91AB].func_3E65.size > 0) {
      foreach(var_02 in level.func_91AA[level.func_91AB].func_3E65) {
      func_9191(var_02);
      }
    }
  }

  level.func_91AB = var_00;
  thread func_91A5(var_00);
  func_1250(var_00);
}

func_1250(var_00) {
  var_01 = func_12AA(var_00);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    foreach(var_04 in level.func_91AA[var_1[var_02]].func_6631) {
      var_05 = var_4.ent;
      var_05 hudoutlineenable(var_4.func_4395, var_4.func_5259, var_4.func_6C0F, var_4.func_10F87);
    }
  }
}

func_1251(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(level.func_91AA[var_05].func_3E65) || level.func_91AA[var_05].func_3E65.size == 0) {
    var_00 hudoutlineenable(var_01, var_02, var_03, var_04);
  }
  else {
    var_06 = func_12AA(var_05, 1);
    var_07 = 0;

    for(var_08 = 0; var_08 < var_6.size; var_8++) {
      foreach(var_10 in level.func_91AA[var_6[var_08]].func_6631) {
        if(var_10.ent == var_00) {
          var_00 hudoutlineenable(var_10.func_4395, var_10.func_5259, var_10.func_6C0F, var_10.func_10F87);
          var_07 = 1;
          break;
        }
      }

      if(var_07) {
        break;
      }
    }
  }
}

func_11DA(var_00, var_01) {
  if(!isDefined(level.func_91AA[var_01].func_3E65) || level.func_91AA[var_01].func_3E65.size == 0) {
    self hudoutlinedisable();
  }
  else {
    var_02 = func_12AA(var_01, 1);
    var_03 = 0;

    for(var_04 = 0; var_04 < var_2.size; var_4++) {
      foreach(var_06 in level.func_91AA[var_2[var_04]].func_6631) {
        if(var_6.ent == var_00) {
          var_00 hudoutlineenable(var_6.func_4395, var_6.func_5259, var_6.func_6C0F, var_6.func_10F87);
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
}

func_91A5(var_00) {
  level notify("hudoutline_new_channel_settings");
  level endon("hudoutline_new_channel_settings");
  wait 0.05;
  var_01 = func_9192();
  var_02 = [
    [level.func_91AA[var_00].func_F88E]
  ]();

  foreach(var_05, var_04 in var_01) {
    if(isDefined(var_2[var_05])) {
      _setsaveddvar(var_05, var_2[var_05]);
      continue;
    }

    _setsaveddvar(var_05, var_04);
  }

  if(isDefined(level.func_91AA[var_00].func_B05E)) {
    func_CC8D(var_00, level.func_91AA[var_00].func_B05E);
  }
}

func_9191(var_00) {
  foreach(var_02 in level.func_91AA[var_00].func_6631) {
    var_03 = var_2.ent;
    var_03 hudoutlinedisable();
  }
}

func_9188(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = ::func_9192;
  }

  if(!isDefined(level.func_91AA)) {
    func_918F();
  }

  if(!isDefined(level.func_91AA[var_00])) {
    level.func_91AA[var_00] = spawnStruct();
    level.func_91AA[var_00].func_3C65 = var_00;
    level.func_91AA[var_00].priority = var_01;
    level.func_91AA[var_00].func_F88E = var_02;
    level.func_91AA[var_00].func_6631 = [];
  }
}

func_918A(var_00, var_01, var_02) {
  if(!isDefined(level.func_91AA[var_00])) {
    level.func_91AA[var_00] = spawnStruct();
    level.func_91AA[var_00].func_3C65 = var_00;
    level.func_91AA[var_00].priority = var_01;
    level.func_91AA[var_00].func_6631 = [];
    level.func_91AA[var_00].func_C8F5 = var_02;
  }

  if(!isDefined(level.func_91AA[var_02].func_3E65)) {
    level.func_91AA[var_02].func_3E65 = [];
  }

  level.func_91AA[var_02].func_3E65[level.func_91AA[var_02].func_3E65.size] = var_00;
}

func_91A1(var_00, var_01) {
  level.func_91AA[var_00].func_F88E = var_01;

  if(isDefined(level.func_91AB) && level.func_91AB == var_00) {
    thread func_91A5(var_00);
  }
}

func_919F(var_00, var_01) {
  foreach(var_03 in level.func_91AA[var_00].func_6631) {
    if(var_3.ent == var_01) {
      return 1;
    }
  }

  return 0;
}

func_919A(var_00, var_01) {
  if(!isDefined(level.func_91AC)) {
    level.func_91AC = [];
  }

  if(var_01) {
    foreach(var_03 in level.func_91AC) {
      if(var_03 == var_00) {
        return;
      }
    }

    level.func_91AC[level.func_91AC.size] = var_00;
    func_9185();
  } else {
    var_05 = [];

    foreach(var_03 in level.func_91AC) {
      if(var_03 != var_00) {
        var_5[var_5.size] = var_03;
      }
    }

    level.func_91AC = var_05;
    func_9185();
  }
}

func_9195(var_00, var_01) {
  if(isDefined(var_01)) {
    self endon("endonMsg");
  }

  self endon(var_00 + "hudoutline_disable");
  scripts\engine\utility::waittill_any("death", "entitydeleted");
  thread func_9194(var_00);
}

func_CC8D(var_00, var_01) {
  if(!isDefined(level.func_91AB) || level.func_91AB != var_00) {
    return;
  }
  level notify("hudoutline_new_anim_on_channel_" + var_00);
  level endon("hudoutline_new_channel_settings");
  level endon("hudoutline_new_anim_on_channel_" + var_00);
  level[[var_01]]();
  thread func_91A5(var_00);
}

func_CC8E(var_00, var_01) {
  level.func_91AA[var_00].func_B05E = var_01;

  if(!isDefined(level.func_91AB) || level.func_91AB != var_00) {
    return;
  }
  func_CC8D(var_00, var_01);
}

func_9192() {
  var_00 = [];

  if(isDefined(level.player.func_20F8)) {
    var_01 = length2d(level.player.origin - level.player.func_20F8.origin);
    var_02 = clamp(var_01 / 1000, 1, 2);
    var_0["r_hudoutlineWidth"] = var_02;
  } else
    var_0["r_hudoutlineWidth"] = 1;

  var_0["r_hudoutlineFillColor0"] = "0.9 0.9 0.9 0.5";
  var_0["r_hudoutlineFillColor1"] = "0.3 0.3 0.3 0.5";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.45";
  var_0["r_hudoutlineOccludedInteriorColor"] = ".7 .7 .7 0.25";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  var_0["r_drawTransEIDListBeforeOpaques"] = 0;
  var_0["cg_hud_outline_colors_0"] = "0.000 0.000 0.000 0.000";
  var_0["cg_hud_outline_colors_1"] = "0.882 0.882 0.882 1.000";
  var_0["cg_hud_outline_colors_2"] = "0.945 0.384 0.247 1.000";
  var_0["cg_hud_outline_colors_3"] = "0.431 0.745 0.235 1.000";
  var_0["cg_hud_outline_colors_4"] = "0.157 0.784 0.784 1.000";
  var_0["cg_hud_outline_colors_5"] = "0.886 0.600 0.000 1.000";
  var_0["cg_hud_outline_colors_6"] = "0.000 0.000 0.000 0.000";
  var_0["cg_hud_outline_colors_7"] = "0.76 0.89 0.89 1.0";
  return var_00;
}

func_12AA(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  var_02 = [];
  var_2[0] = var_00;

  if(isDefined(level.func_91AA[var_00].func_3E65) && level.func_91AA[var_00].func_3E65.size > 0) {
    foreach(var_04 in level.func_91AA[var_00].func_3E65) {
      if(level.func_91AA[var_04].func_6631.size > 0) {
        for(var_05 = 0; var_05 < var_2.size; var_5++) {
          if(!var_01) {
            if(level.func_91AA[var_2[var_05]].priority >= level.func_91AA[var_04].priority) {
              var_02 = func_C76D(var_02, var_04, var_05);
              break;
            } else if(var_05 + 1 == var_2.size) {
              var_2[var_05 + 1] = var_04;
              break;
            }
          } else if(level.func_91AA[var_2[var_05]].priority < level.func_91AA[var_04].priority) {
            var_02 = func_C76D(var_02, var_04, var_05);
            break;
          } else if(var_05 + 1 == var_2.size) {
            var_2[var_05 + 1] = var_04;
            break;
          }
        }
      }
    }
  }

  return var_02;
}

func_C76D(var_00, var_01, var_02) {
  if(var_02 == var_0.size) {
    var_03 = var_00;
    var_3[var_3.size] = var_01;
    return var_03;
  }

  var_03 = [];
  var_04 = 0;

  for(var_05 = 0; var_05 < var_0.size; var_5++) {
    if(var_05 == var_02) {
      var_3[var_05] = var_01;
      var_04 = 1;
    }

    var_3[var_05 + var_04] = var_0[var_05];
  }

  return var_03;
}