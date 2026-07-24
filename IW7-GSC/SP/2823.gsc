/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2823.gsc
**************************************/

_id_C0E1(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("stop_sequencing_notetracks");
  var_0 endon("death");

  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = self;
  }

  var_7 = undefined;

  if(isDefined(var_4)) {
    var_7 = var_4;
  } else {
    var_7 = var_0._id_1FBB;
  }

  var_8 = spawnStruct();
  var_8._id_53F2 = [];
  var_9 = [];

  if(isDefined(var_7) && isDefined(level._id_EC8D[var_7]) && isDefined(var_3)) {
    if(isDefined(level._id_EC8D[var_7][var_3])) {
      var_9[var_3] = level._id_EC8D[var_7][var_3];
    }

    if(isDefined(level._id_EC8D[var_7]["any"])) {
      var_9["any"] = level._id_EC8D[var_7]["any"];
    }
  }

  foreach(var_18, var_11 in var_9) {
    foreach(var_13 in level._id_EC8D[var_7][var_18]) {
      foreach(var_15 in var_13) {
        if(isDefined(var_15["dialog"])) {
          var_8._id_53F2[var_15["dialog"]] = 1;
        }
      }
    }
  }

  var_19 = 0;
  var_20 = 0;

  for(;;) {
    var_8._id_54A9 = 0;
    var_21 = undefined;

    if(!var_19 && isDefined(var_7) && isDefined(var_3)) {
      var_19 = 1;
      var_22 = undefined;
      var_20 = isDefined(level._id_EC8D[var_7]) && isDefined(level._id_EC8D[var_7][var_3]) && isDefined(level._id_EC8D[var_7][var_3]["start"]);

      if(!var_20) {
        continue;
      }
      var_23 = ["start"];
    } else
      var_0 waittill(var_1, var_23);

    if(!isarray(var_23)) {
      var_23 = [var_23];
    }

    scripts\anim\utility::validatenotetracks(var_1, var_23, var_5);
    var_24 = undefined;

    foreach(var_26 in var_23) {
      _id_C0CC(var_0, var_3, var_26, var_7, var_9, var_6, var_8);

      if(var_26 == "end") {
        var_24 = 1;
      }
    }

    if(isDefined(var_24)) {
      break;
    }
  }
}

_id_C0CC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_2 == "end") {
    return 1;
  }

  foreach(var_12, var_8 in var_4) {
    if(isDefined(level._id_EC8D[var_3][var_12][var_2])) {
      foreach(var_10 in level._id_EC8D[var_3][var_12][var_2]) {
        _id_1ED8(var_10, var_0, var_6, var_5);
      }
    }
  }

  if(var_0 _id_C0DB(var_2)) {
    return;
  }
  _id_7729(var_0, var_2);
}

_id_C0DB(var_0) {
  var_1 = getsubstr(var_0, 0, 3);

  if(var_1 == "ps_") {
    var_2 = getsubstr(var_0, 3);

    if(isDefined(self._id_1EFF)) {
      self thread[[self._id_1EFF]](var_2, "j_head", 1);
    } else {
      var_3 = strtok(var_2, ",");

      if(var_3.size < 2) {
        thread scripts\sp\utility::play_sound_on_tag(var_2, undefined, 1);
      } else {
        thread scripts\sp\utility::play_sound_on_tag(var_3[0], var_3[1], 1);
      }
    }

    return 1;
  }

  if(var_1 == "vo_") {
    var_2 = getsubstr(var_0, 3);

    if(isDefined(self._id_1EFF)) {
      self thread[[self._id_1EFF]](var_2, "j_head", 1);
    } else if(!issentient(self)) {
      thread scripts\sp\utility::play_sound_on_tag(var_2, "j_head", 1, var_2);
    } else {
      self _meth_824A(var_2, "sounddone", 1);
    }

    return 1;
  }

  if(var_1 == "sd_") {
    var_2 = getsubstr(var_0, 3);
    thread scripts\sp\utility::_id_10346(var_2);
    return 1;
  }

  if(var_1 == "sr_") {
    var_2 = getsubstr(var_0, 3);
    level thread scripts\sp\utility::_id_10350(var_2);
    return 1;
  }

  if(var_1 == "rm_") {
    var_4 = getsubstr(var_0, 3);
    level.player playRumbleOnEntity(var_4);
    return 1;
  }

  if(var_1 == "fx_") {
    var_5 = strtok(tolower(var_0), "[]");
    var_6 = strtok(getsubstr(var_5[0], 3), ",() ");
    var_7 = [];

    if(var_5.size > 1) {
      for(var_8 = 1; var_8 < var_5.size; var_8++) {
        var_9 = strtok(var_5[var_8], ",");

        if(var_9.size > 1) {
          var_6 = scripts\engine\utility::array_add(var_6, (float(var_9[0]), float(var_9[1]), float(var_9[2])));
          continue;
        }

        var_6 = scripts\engine\utility::array_add(var_6, var_9[0]);
      }
    }

    if(var_6.size == 2) {
      if(var_6[0] == "exploder") {
        scripts\engine\utility::exploder(var_6[1]);
        return 1;
      } else if(var_6[0] == "stop_exploder") {
        scripts\sp\utility::_id_10FEC(var_6[1]);
        return 1;
      } else {
        playFXOnTag(level._effect[var_6[0]], self, var_6[1]);
        return 1;
      }
    } else if(var_6.size == 3) {
      if(var_6[0] == "playfxontag") {
        playFXOnTag(level._effect[var_6[1]], self, var_6[2]);
        return 1;
      } else if(var_6[0] == "stopfxontag") {
        stopFXOnTag(level._effect[var_6[1]], self, var_6[2]);
        return 1;
      } else if(var_6[0] == "killfxontag") {
        killfxontag(level._effect[var_6[1]], self, var_6[2]);
        return 1;
      }
    } else if(var_6.size == 6) {
      if(var_6[0] == "debris") {
        playFXOnTag(level._effect[var_6[1]], self, var_6[2]);
        self hidepart(var_6[2], var_6[3]);
        return 1;
      }
    } else if(var_6.size == 11) {
      var_10 = (float(var_6[2]), float(var_6[3]), float(var_6[4]));
      var_11 = (float(var_6[5]), float(var_6[6]), float(var_6[7]));
      var_12 = (float(var_6[8]), float(var_6[9]), float(var_6[10]));
      playFX(level._effect[var_6[1]], var_10, var_11, var_12);
    }
  }

  var_1 = getsubstr(var_0, 0, 4);

  if(var_1 == "psr_") {
    var_2 = getsubstr(var_0, 4);
    scripts\sp\utility::_id_DBEF(var_2);
    return 1;
  }

  if(var_1 == "pip_") {
    var_2 = getsubstr(var_0, 4);

    if(isDefined(self._id_1EFF)) {
      self thread[[self._id_1EFF]](var_2, "j_head", 1);
    } else {
      thread scripts\sp\pip_util::_id_CBA5(var_2);
    }

    return 1;
  }

  if(var_1 == "pvo_") {
    var_2 = getsubstr(var_0, 4);
    thread scripts\sp\utility::_id_1034D(var_2);
    return 1;
  }

  if(var_1 == "fov_") {
    var_13 = strtok(var_0, "_");
    var_14 = var_13[1];
    var_15 = 65.0;
    var_16 = undefined;

    if(var_14 == "start") {
      var_15 = float(var_13[2]);
      var_16 = float(var_13[3]);
      level.player _meth_81DE(var_15, var_16);
    } else {
      var_16 = float(var_13[2]);
      level.player _meth_81DE(var_15, var_16);
    }

    return 1;
  }

  return 0;
}

_id_7729(var_0, var_1) {
  switch (var_1) {
    case "ignoreall true":
      var_0.ignoreall = 1;
      break;
    case "ignoreall false":
      var_0.ignoreall = 0;
      break;
    case "ignoreme true":
      var_0.ignoreme = 1;
      break;
    case "ignoreme false":
      var_0.ignoreme = 0;
      break;
    case "allowdeath true":
      var_0.allowdeath = 1;
      break;
    case "allowdeath false":
      var_0.allowdeath = 0;
      break;
    case "follow off":
      var_0._id_7245 = 1;
      break;
    case "follow on":
      var_0._id_7245 = 0;
      break;
    case "lookat_plr_head_on":
      var_0 thread scripts\sp\utility::_id_7799(level.player, 0.15, 0.7);
      break;
    case "lookat_plr_eyes_on":
      var_0 thread scripts\sp\utility::_id_7798(level.player, 4.0, 0.1);
      break;
    case "lookat_plr_off":
      var_0 thread scripts\sp\utility::_id_77B9(0.7);
      break;
    case "lookat_plr_eyes_off":
      var_0 thread scripts\sp\utility::_id_7793(0.1);
      break;
    case "lookat_plr_head_off":
      var_0 thread scripts\sp\utility::_id_779E(0.7);
      break;
    case "bc_vo_start":
      var_0 notify("bc_vochat_start");
      break;
    case "blind_on":
      var_0 _id_0F18::_id_10E8A("set_blind", 1);
      break;
    case "blind_off":
      var_0 _id_0F18::_id_10E8A("set_blind", 0);
      break;
    case "helmet_on":
      if(!isai(var_0)) {
        var_0 thread _id_0E4B::_id_8E05();
      }

      break;
    case "helmet_on_visor_up":
      if(!isai(var_0)) {
        var_0 thread _id_0E4B::_id_8E05(1);
      }

      break;
    case "helmet_on_visor_up_no_audio":
      if(!isai(var_0)) {
        var_0 thread _id_0E4B::_id_8E05(1, undefined, 1);
      }

      break;
    case "helmet_off":
      if(!isai(var_0)) {
        var_0 thread _id_0E4B::_id_8E02();
      }

      break;
    case "visor_up":
    case "visor_raise":
      if(!isai(var_0)) {
        var_0 thread _id_0E4B::_id_1348D();
      }

      break;
    case "visor_down":
    case "visor_lower":
      if(!isai(var_0)) {
        var_0 thread _id_0E4B::_id_13485();
      }

      break;
    case "plr_pull_visor_down_activate_lma_normal_and_clear":
      thread _id_0B0B::_id_25C2();
      break;
    case "plr_pull_visor_down_activate_lma_fast_and_clear":
      thread _id_0B0B::_id_25C2(1.0, "fast");
      break;
    case "plr_helmet_on_closed_visor_activate_lma_and_clear":
      thread _id_0B0B::_id_25C0();
      break;
    case "opsmap_scene_start":
      if(isDefined(var_0._id_9A30)) {
        var_0 thread scripts\sp\interaction::_id_CD50(var_0._id_9A30, var_0._id_C6B8);
      }

      break;
    case "opsmap_scene_end":
      if(isDefined(var_0._id_9A30)) {
        var_0 thread scripts\sp\interaction::_id_9A0F();
      }

      break;
    case "vr_npc_switch_fire_rate":
      var_0 thread _id_0EFB::_id_25ED();
      break;
  }
}

_id_1ED8(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0["function"])) {
    self thread[[var_0["function"]]](var_1);
  }

  if(isDefined(var_0["flag"])) {
    scripts\engine\utility::flag_set(var_0["flag"]);
  }

  if(isDefined(var_0["flag_clear"])) {
    scripts\engine\utility::flag_clear(var_0["flag_clear"]);
  }

  if(isDefined(var_0["notify"])) {
    level notify(var_0["notify"]);
  }

  if(isDefined(var_0["attach gun left"])) {
    var_1 _id_86DE();
    return;
  }

  if(isDefined(var_0["attach gun right"])) {
    var_1 _id_86DF();
    return;
  }

  if(isDefined(var_0["detach gun"])) {
    var_1 _id_86D5(var_0);
    return;
  }

  if(isDefined(var_0["attach model"])) {
    if(isDefined(var_0["selftag"])) {
      var_1 attach(var_0["attach model"], var_0["selftag"]);
    } else {
      var_3 attach(var_0["attach model"], var_0["tag"]);
    }

    return;
  }

  if(isDefined(var_0["detach model"])) {
    if(isDefined(var_0["selftag"])) {
      var_1 detach(var_0["detach model"], var_0["selftag"]);
    } else {
      var_3 detach(var_0["detach model"], var_0["tag"]);
    }
  }

  if(isDefined(var_0["sound"])) {
    var_4 = undefined;

    if(!isDefined(var_0["sound_stays_death"])) {
      var_4 = 1;
    }

    var_5 = undefined;

    if(isDefined(var_0["sound_on_tag"])) {
      var_5 = var_0["sound_on_tag"];
    }

    var_1 thread scripts\sp\utility::play_sound_on_tag(var_0["sound"], var_5, var_4);
  }

  if(isDefined(var_0["playersound"])) {
    level.player playSound(var_0["playersound"]);
  }

  if(isDefined(var_0["playerdialogue"])) {
    level.player thread scripts\sp\utility::_id_1034D(var_0["playerdialogue"]);
  }

  if(!var_2._id_54A9) {
    if(isDefined(var_0["dialog"]) && isDefined(var_2._id_53F2[var_0["dialog"]])) {
      var_1 scripts\anim\face::sayspecificdialogue(var_0["dialog"]);
      var_2._id_53F2[var_0["dialog"]] = undefined;
      var_2._id_54A9 = 1;
    }
  }

  if(isDefined(var_0["create model"])) {
    _id_1E93(var_1, var_0);
  } else if(isDefined(var_0["delete model"])) {
    _id_1F1E(var_1, var_0);
  }

  if(isDefined(var_0["selftag"])) {
    if(isDefined(var_0["effect"])) {
      level thread _id_C0C8(var_1, var_0);
    }

    if(isDefined(var_0["stop_effect"])) {
      stopFXOnTag(level._effect[var_0["stop_effect"]], var_1, var_0["selftag"]);
    }

    if(isDefined(var_0["swap_part_to_efx"])) {
      playFXOnTag(level._effect[var_0["swap_part_to_efx"]], var_1, var_0["selftag"]);
      var_1 hidepart(var_0["selftag"]);
    }

    if(isDefined(var_0["trace_part_for_efx"])) {
      var_6 = undefined;
      var_7 = scripts\engine\utility::getfx(var_0["trace_part_for_efx"]);

      if(isDefined(var_0["trace_part_for_efx_water"])) {
        var_6 = scripts\engine\utility::getfx(var_0["trace_part_for_efx_water"]);
      }

      var_8 = 0;

      if(isDefined(var_0["trace_part_for_efx_delete_depth"])) {
        var_8 = var_0["trace_part_for_efx_delete_depth"];
      }

      var_1 thread _id_11A80(var_0["selftag"], var_7, var_6, var_8);
    }

    if(isDefined(var_0["trace_part_for_efx_canceling"])) {
      var_1 thread _id_11A81(var_0["selftag"]);
    }
  }

  if(isDefined(var_0["tag"]) && isDefined(var_0["effect"])) {
    playFXOnTag(level._effect[var_0["effect"]], var_3, var_0["tag"]);
  }

  if(isDefined(var_0["selftag"]) && isDefined(var_0["effect_looped"])) {
    playFXOnTag(level._effect[var_0["effect_looped"]], var_1, var_0["selftag"]);
  }
}

_id_1E93(var_0, var_1) {
  if(!isDefined(var_0._id_EF84)) {
    var_0._id_EF84 = [];
  }

  var_2 = var_0._id_EF84.size;
  var_0._id_EF84[var_2] = spawn("script_model", (0, 0, 0));
  var_0._id_EF84[var_2] setModel(var_1["create model"]);
  var_0._id_EF84[var_2].origin = var_0 gettagorigin(var_1["selftag"]);
  var_0._id_EF84[var_2].angles = var_0 gettagangles(var_1["selftag"]);
}

_id_1F1E(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0._id_EF84.size; var_2++) {
    if(isDefined(var_1["explosion"])) {
      var_3 = anglesToForward(var_0._id_EF84[var_2].angles);
      var_3 = var_3 * 120;
      var_3 = var_3 + var_0._id_EF84[var_2].origin;
      playFX(level._effect[var_1["explosion"]], var_0._id_EF84[var_2].origin);
      radiusdamage(var_0._id_EF84[var_2].origin, 350, 700, 50);
    }

    var_0._id_EF84[var_2] delete();
  }
}

_id_86DE() {
  if(!isDefined(self._id_86DB)) {
    return;
  }
  self._id_86DB delete();
  self.dropweapon = 1;
  scripts\anim\shared::placeweaponon(self.weapon, "left");
}

_id_86DF() {
  if(!isDefined(self._id_86DB)) {
    return;
  }
  self._id_86DB delete();
  self.dropweapon = 1;
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

_id_86D5(var_0) {
  if(isDefined(self._id_86DB)) {
    return;
  }
  var_1 = self gettagorigin(var_0["tag"]);
  var_2 = self gettagangles(var_0["tag"]);
  var_3 = 0;

  if(isDefined(var_0["suspend"])) {
    var_3 = var_0["suspend"];
  }

  var_4 = spawn("weapon_" + self.weapon, var_1, var_3);
  var_4.angles = var_2;
  self._id_86DB = var_4;
  scripts\anim\shared::placeweaponon(self.weapon, "none");
  self.dropweapon = 0;
}

_id_C0C8(var_0, var_1) {
  var_2 = isDefined(var_1["moreThanThreeHack"]);

  if(var_2) {
    scripts\engine\utility::lock("moreThanThreeHack");
  }

  playFXOnTag(level._effect[var_1["effect"]], var_0, var_1["selftag"]);

  if(var_2) {
    scripts\engine\utility::unlock("moreThanThreeHack");
  }
}

_id_11A81(var_0) {
  self notify("cancel_trace_for_part_" + var_0);
}

_id_11A80(var_0, var_1, var_2, var_3) {
  var_4 = "trace_part_for_efx";
  self endon("cancel_trace_for_part_" + var_0);
  var_5 = self gettagorigin(var_0);
  var_6 = 0;
  var_7 = spawnStruct();
  var_7._id_A8F6 = self gettagorigin(var_0);
  var_7._id_9032 = 0;
  var_7.part = var_0;
  var_7._id_9034 = 0;
  var_7.effect = var_1;
  var_7._id_10E51 = 0;
  var_7._id_A8EE = gettime();

  while(isDefined(self) && !var_7._id_9032) {
    scripts\engine\utility::lock(var_4);
    _id_1173F(var_7);
    scripts\sp\utility::_id_12BDD(var_4);

    if(var_7._id_10E51 == 1 && gettime() - var_7._id_A8EE > 3000) {
      return;
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_2) && var_7._id_9034) {
    var_1 = var_2;
  }

  playFX(var_1, var_7._id_A8F6);

  if(var_3 == 0) {
    self hidepart(var_0);
  } else {
    thread _id_8ED1(var_7._id_A8F6[2] - var_3, var_0);
  }
}

_id_8ED1(var_0, var_1) {
  self endon("entitydeleted");

  while(self gettagorigin(var_1)[2] > var_0) {
    wait 0.05;
  }

  self hidepart(var_1);
}

_id_1173F(var_0) {
  var_1 = undefined;

  if(!isDefined(self)) {
    return;
  }
  var_0._id_4B9E = self gettagorigin(var_0.part);

  if(var_0._id_4B9E != var_0._id_A8F6) {
    var_0._id_A8EE = gettime();
    var_0._id_10E51 = 0;

    if(!bullettracepassed(var_0._id_A8F6, var_0._id_4B9E, 0, self)) {
      var_2 = bulletTrace(var_0._id_A8F6, var_0._id_4B9E, 0, self);

      if(var_2["fraction"] < 1.0) {
        var_0._id_A8F6 = var_2["position"];
        var_0._id_9034 = var_2["surfacetype"] == "water";
        var_0._id_9032 = 1;
        return;
      } else {}
    }
  } else
    var_0._id_10E51 = 1;

  var_0._id_A8F6 = var_0._id_4B9E;
}

_id_1FD5(var_0, var_1) {
  var_1 = tolower(var_1);
  var_2 = getarraykeys(self._id_1FDC);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(self._id_1FDC[var_4]._id_1FAF != var_0) {
      continue;
    }
    if(self._id_1FDC[var_4]._id_C0C2 != var_1) {
      continue;
    }
    self._id_1FDC[var_4]._id_6303 = gettime() + 60000;
    return 1;
  }

  return 0;
}

_id_1FDB(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  _id_1754();

  if(var_1 == "end") {
    return;
  }
  if(_id_1FD5(var_0, var_1)) {
    return;
  }
  var_3 = spawnStruct();
  var_3._id_1FAF = var_0;
  var_3._id_C0C2 = var_1;
  var_3._id_1FBB = var_2;
  var_3._id_6303 = gettime() + 60000;
  _id_1697(var_3);
}

_id_1FD8(var_0, var_1) {
  _id_1754();
  var_2 = spawnStruct();
  var_2._id_1FAF = var_0;
  var_2._id_C0C2 = "#" + var_0;
  var_2._id_1FBB = var_1;
  var_2._id_6303 = gettime() + 60000;

  if(_id_1FD5(var_0, var_2._id_C0C2)) {
    return;
  }
  _id_1697(var_2);
}

_id_1FD9(var_0, var_1, var_2) {
  _id_1754();
  var_0 = var_1 + var_0;
  var_3 = spawnStruct();
  var_3._id_1FAF = var_0;
  var_3._id_C0C2 = "#" + var_0;
  var_3._id_1FBB = var_2;
  var_3._id_6303 = gettime() + 60000;

  if(_id_1FD5(var_0, var_3._id_C0C2)) {
    return;
  }
  _id_1697(var_3);
}

_id_1697(var_0) {
  for(var_1 = 0; var_1 < level._id_1FD7; var_1++) {
    if(isDefined(self._id_1FDC[var_1])) {
      continue;
    }
    self._id_1FDC[var_1] = var_0;
    return;
  }

  var_2 = getarraykeys(self._id_1FDC);
  var_3 = var_2[0];
  var_4 = self._id_1FDC[var_3]._id_6303;

  for(var_1 = 1; var_1 < var_2.size; var_1++) {
    var_5 = var_2[var_1];

    if(self._id_1FDC[var_5]._id_6303 < var_4) {
      var_4 = self._id_1FDC[var_5]._id_6303;
      var_3 = var_5;
    }
  }

  self._id_1FDC[var_3] = var_0;
}

_id_1754() {
  if(!isDefined(self._id_1FDC)) {
    self._id_1FDC = [];
  }

  var_0 = 0;

  for(var_1 = 0; var_1 < level._id_1FDC.size; var_1++) {
    if(self == level._id_1FDC[var_1]) {
      var_0 = 1;
      break;
    }
  }

  if(!var_0) {
    level._id_1FDC[level._id_1FDC.size] = self;
  }
}

_id_6A85(var_0, var_1, var_2) {
  self endon(var_2);
  var_0 endon("death");
  var_0 endon("stop_loop");
  var_0 endon("scripted_face_done");

  for(;;) {
    self waittill(var_1, var_3);

    foreach(var_5 in var_3) {
      var_6 = getsubstr(var_5, 0, 3);

      if(var_6 == "vo_") {
        var_7 = getsubstr(var_5, 3);

        if(!issentient(self)) {
          thread scripts\sp\utility::play_sound_on_tag(var_7, "j_head", 1, var_7);
        } else {
          self _meth_824A(var_7, "face_sounddone", 1);
        }

        continue;
      }

      if(var_6 == "pvo") {
        var_7 = getsubstr(var_5, 4);
        thread scripts\sp\utility::_id_1034D(var_7);
      }
    }
  }
}