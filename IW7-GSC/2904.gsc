/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2904.gsc
**************************************/

_id_918F() {
  level._id_91AA = [];
  _id_9188("default", 0, ::_id_9192);
  setsaveddvar("r_hudoutlineEnable", 1);
}

_id_9197(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(level._id_91AA)) {
    _id_918F();
  }

  if(_id_919F(var_0, self)) {
    _id_91A7(var_0, self, var_1, var_2, var_3, var_4);
  } else {
    var_5 = level._id_91AA[var_0]._id_6631.size;
    level._id_91AA[var_0]._id_6631[var_5] = _id_9190(self, var_1, var_2, var_3, var_4);
    thread _id_9195(var_0);
  }

  if(!isDefined(level._id_91AA[var_0]._id_C8F5)) {
    if(!isDefined(level._id_91AB)) {
      _id_9186(var_0);
    }

    var_6 = level._id_91AA[level._id_91AB].priority;
    var_7 = level._id_91AA[var_0].priority;

    if(level._id_91AB != var_0 && var_6 < var_7) {
      _id_9186(var_0);
      return;
    }

    if(level._id_91AB == var_0) {
      _id_1251(self, var_1, var_2, var_3, var_4, var_0);
      return;
    }

    return;
  } else {
    var_8 = level._id_91AA[var_0]._id_C8F5;

    if(!isDefined(level._id_91AB)) {
      _id_9186(var_8);
    }

    var_6 = level._id_91AA[level._id_91AB].priority;
    var_9 = level._id_91AA[var_8].priority;

    if(level._id_91AB != var_8 && var_6 < var_9) {
      _id_9186(var_8);
    } else if(level._id_91AB == var_8) {
      _id_1251(self, var_1, var_2, var_3, var_4, var_8);
    }
  }
}

_id_9194(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(level._id_91AA)) {
    return;
  }
  if(isDefined(self)) {
    self notify(var_0 + "hudoutline_disable");
  }

  var_1 = undefined;

  foreach(var_4, var_3 in level._id_91AA[var_0]._id_6631) {
    if(!isDefined(var_3.ent)) {
      level._id_91AA[var_0]._id_6631[var_4] = undefined;
      continue;
    }

    if(var_3.ent == self) {
      var_1 = var_4;
      level._id_91AA[var_0]._id_6631[var_1] = undefined;
      break;
    }
  }

  var_5 = [];

  foreach(var_4, var_7 in level._id_91AA[var_0]._id_6631) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  level._id_91AA[var_0]._id_6631 = var_5;

  if(!isDefined(level._id_91AB)) {
    return;
  }
  if(level._id_91AB == var_0) {
    if(isDefined(var_1)) {
      _id_11DA(self, var_0);
    }

    if(level._id_91AA[var_0]._id_6631.size == 0) {
      var_8 = 0;

      if(isDefined(level._id_91AA[var_0]._id_3E65) && level._id_91AA[var_0]._id_3E65.size > 0) {
        foreach(var_10 in level._id_91AA[var_0]._id_3E65) {
          if(level._id_91AA[var_10]._id_6631.size > 0) {
            var_8 = 1;
            break;
          }
        }
      }

      if(!var_8) {
        _id_9185();
      }
    }
  } else if(isDefined(level._id_91AA[var_0]._id_C8F5) && level._id_91AB == level._id_91AA[var_0]._id_C8F5) {
    var_12 = level._id_91AA[var_0]._id_C8F5;

    if(isDefined(var_1)) {
      _id_11DA(self, var_12);
    }

    if(level._id_91AA[var_0]._id_6631.size == 0) {
      _id_9185();
    }
  }
}

_id_9185() {
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level._id_91AC) && level._id_91AC.size > 0) {
    foreach(var_3 in level._id_91AC) {
      if(!isDefined(var_0) || level._id_91AA[var_3].priority > var_0) {
        var_0 = level._id_91AA[var_3].priority;
        var_1 = var_3;
      }
    }
  } else {
    foreach(var_3 in level._id_91AA) {
      if(isDefined(var_3._id_C8F5)) {
        continue;
      }
      if(!isDefined(var_3._id_3E65) || var_3._id_3E65.size == 0) {
        if(var_3._id_6631.size == 0) {
          continue;
        }
      } else {
        var_6 = 0;

        if(var_3._id_6631.size > 0) {
          var_6 = 1;
        }

        foreach(var_8 in var_3._id_3E65) {
          if(level._id_91AA[var_8]._id_6631.size > 0) {
            var_6 = 1;
          }
        }

        if(!var_6) {
          continue;
        }
      }

      if(!isDefined(var_0) || var_3.priority > var_0) {
        var_0 = var_3.priority;
        var_1 = var_3._id_3C65;
      }
    }
  }

  if(isDefined(var_1)) {
    _id_9186(var_1);
  } else {
    level._id_91AB = undefined;
  }
}

_id_9190(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.ent = var_0;
  var_5._id_4395 = var_1;
  var_5._id_5259 = var_2;
  var_5._id_6C0F = var_3;
  var_5._id_10F87 = var_4;
  return var_5;
}

_id_91A7(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in level._id_91AA[var_0]._id_6631) {
    if(var_7.ent == var_1) {
      var_7._id_4395 = var_2;
      var_7._id_5259 = var_3;
      var_7._id_6C0F = var_4;
      var_7._id_10F87 = var_5;
    }
  }
}

_id_9186(var_0) {
  if(isDefined(level._id_91AB) && level._id_91AB != var_0) {
    _id_9191(level._id_91AB);

    if(isDefined(level._id_91AA[level._id_91AB]._id_3E65) && level._id_91AA[level._id_91AB]._id_3E65.size > 0) {
      foreach(var_2 in level._id_91AA[level._id_91AB]._id_3E65) {
        _id_9191(var_2);
      }
    }
  }

  level._id_91AB = var_0;
  thread _id_91A5(var_0);
  _id_1250(var_0);
}

_id_1250(var_0) {
  var_1 = _id_12AA(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    foreach(var_4 in level._id_91AA[var_1[var_2]]._id_6631) {
      var_5 = var_4.ent;
      var_5 hudoutlineenable(var_4._id_4395, var_4._id_5259, var_4._id_6C0F, var_4._id_10F87);
    }
  }
}

_id_1251(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_91AA[var_5]._id_3E65) || level._id_91AA[var_5]._id_3E65.size == 0) {
    var_0 hudoutlineenable(var_1, var_2, var_3, var_4);
  } else {
    var_6 = _id_12AA(var_5, 1);
    var_7 = 0;

    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      foreach(var_10 in level._id_91AA[var_6[var_8]]._id_6631) {
        if(var_10.ent == var_0) {
          var_0 hudoutlineenable(var_10._id_4395, var_10._id_5259, var_10._id_6C0F, var_10._id_10F87);
          var_7 = 1;
          break;
        }
      }

      if(var_7) {
        break;
      }
    }
  }
}

_id_11DA(var_0, var_1) {
  if(!isDefined(level._id_91AA[var_1]._id_3E65) || level._id_91AA[var_1]._id_3E65.size == 0) {
    self hudoutlinedisable();
  } else {
    var_2 = _id_12AA(var_1, 1);
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      foreach(var_6 in level._id_91AA[var_2[var_4]]._id_6631) {
        if(var_6.ent == var_0) {
          var_0 hudoutlineenable(var_6._id_4395, var_6._id_5259, var_6._id_6C0F, var_6._id_10F87);
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        break;
      }
    }

    if(!var_3) {
      self hudoutlinedisable();
    }
  }
}

_id_91A5(var_0) {
  level notify("hudoutline_new_channel_settings");
  level endon("hudoutline_new_channel_settings");
  wait 0.05;
  var_1 = _id_9192();
  var_2 = [[level._id_91AA[var_0]._id_F88E]]();

  foreach(var_5, var_4 in var_1) {
    if(isDefined(var_2[var_5])) {
      setsaveddvar(var_5, var_2[var_5]);
      continue;
    }

    setsaveddvar(var_5, var_4);
  }

  if(isDefined(level._id_91AA[var_0]._id_B05E)) {
    _id_CC8D(var_0, level._id_91AA[var_0]._id_B05E);
  }
}

_id_9191(var_0) {
  foreach(var_2 in level._id_91AA[var_0]._id_6631) {
    var_3 = var_2.ent;
    var_3 hudoutlinedisable();
  }
}

_id_9188(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = ::_id_9192;
  }

  if(!isDefined(level._id_91AA)) {
    _id_918F();
  }

  if(!isDefined(level._id_91AA[var_0])) {
    level._id_91AA[var_0] = spawnStruct();
    level._id_91AA[var_0]._id_3C65 = var_0;
    level._id_91AA[var_0].priority = var_1;
    level._id_91AA[var_0]._id_F88E = var_2;
    level._id_91AA[var_0]._id_6631 = [];
  }
}

_id_918A(var_0, var_1, var_2) {
  if(!isDefined(level._id_91AA[var_0])) {
    level._id_91AA[var_0] = spawnStruct();
    level._id_91AA[var_0]._id_3C65 = var_0;
    level._id_91AA[var_0].priority = var_1;
    level._id_91AA[var_0]._id_6631 = [];
    level._id_91AA[var_0]._id_C8F5 = var_2;
  }

  if(!isDefined(level._id_91AA[var_2]._id_3E65)) {
    level._id_91AA[var_2]._id_3E65 = [];
  }

  level._id_91AA[var_2]._id_3E65[level._id_91AA[var_2]._id_3E65.size] = var_0;
}

_id_91A1(var_0, var_1) {
  level._id_91AA[var_0]._id_F88E = var_1;

  if(isDefined(level._id_91AB) && level._id_91AB == var_0) {
    thread _id_91A5(var_0);
  }
}

_id_919F(var_0, var_1) {
  foreach(var_3 in level._id_91AA[var_0]._id_6631) {
    if(var_3.ent == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_919A(var_0, var_1) {
  if(!isDefined(level._id_91AC)) {
    level._id_91AC = [];
  }

  if(var_1) {
    foreach(var_3 in level._id_91AC) {
      if(var_3 == var_0) {
        return;
      }
    }

    level._id_91AC[level._id_91AC.size] = var_0;
    _id_9185();
  } else {
    var_5 = [];

    foreach(var_3 in level._id_91AC) {
      if(var_3 != var_0) {
        var_5[var_5.size] = var_3;
      }
    }

    level._id_91AC = var_5;
    _id_9185();
  }
}

_id_9195(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon("endonMsg");
  }

  self endon(var_0 + "hudoutline_disable");
  scripts\engine\utility::waittill_any("death", "entitydeleted");
  thread _id_9194(var_0);
}

_id_CC8D(var_0, var_1) {
  if(!isDefined(level._id_91AB) || level._id_91AB != var_0) {
    return;
  }
  level notify("hudoutline_new_anim_on_channel_" + var_0);
  level endon("hudoutline_new_channel_settings");
  level endon("hudoutline_new_anim_on_channel_" + var_0);
  level[[var_1]]();
  thread _id_91A5(var_0);
}

_id_CC8E(var_0, var_1) {
  level._id_91AA[var_0]._id_B05E = var_1;

  if(!isDefined(level._id_91AB) || level._id_91AB != var_0) {
    return;
  }
  _id_CC8D(var_0, var_1);
}

_id_9192() {
  var_0 = [];

  if(isDefined(level.player._id_20F8)) {
    var_1 = length2d(level.player.origin - level.player._id_20F8.origin);
    var_2 = clamp(var_1 / 1000, 1, 2);
    var_0["r_hudoutlineWidth"] = var_2;
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
  return var_0;
}

_id_12AA(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = [];
  var_2[0] = var_0;

  if(isDefined(level._id_91AA[var_0]._id_3E65) && level._id_91AA[var_0]._id_3E65.size > 0) {
    foreach(var_4 in level._id_91AA[var_0]._id_3E65) {
      if(level._id_91AA[var_4]._id_6631.size > 0) {
        for(var_5 = 0; var_5 < var_2.size; var_5++) {
          if(!var_1) {
            if(level._id_91AA[var_2[var_5]].priority >= level._id_91AA[var_4].priority) {
              var_2 = _id_C76D(var_2, var_4, var_5);
              break;
            } else if(var_5 + 1 == var_2.size) {
              var_2[var_5 + 1] = var_4;
              break;
            }
          } else if(level._id_91AA[var_2[var_5]].priority < level._id_91AA[var_4].priority) {
            var_2 = _id_C76D(var_2, var_4, var_5);
            break;
          } else if(var_5 + 1 == var_2.size) {
            var_2[var_5 + 1] = var_4;
            break;
          }
        }
      }
    }
  }

  return var_2;
}

_id_C76D(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}