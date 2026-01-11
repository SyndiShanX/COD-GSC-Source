/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2823.gsc
***************************************/

func_C0E1(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 endon("stop_sequencing_notetracks");
  var_00 endon("death");

  if(isDefined(var_02)) {
    var_06 = var_02;
  } else {
    var_06 = self;
  }

  var_07 = undefined;

  if(isDefined(var_04)) {
    var_07 = var_04;
  } else {
    var_07 = var_0.func_1FBB;
  }

  var_08 = spawnStruct();
  var_8.func_53F2 = [];
  var_09 = [];

  if(isDefined(var_07) && isDefined(level.func_EC8D[var_07]) && isDefined(var_03)) {
    if(isDefined(level.func_EC8D[var_07][var_03])) {
      var_9[var_03] = level.func_EC8D[var_07][var_03];
    }

    if(isDefined(level.func_EC8D[var_07]["any"])) {
      var_9["any"] = level.func_EC8D[var_07]["any"];
    }
  }

  foreach(var_18, var_11 in var_09) {
    foreach(var_13 in level.func_EC8D[var_07][var_18]) {
      foreach(var_15 in var_13) {
        if(isDefined(var_15["dialog"])) {
          var_8.func_53F2[var_15["dialog"]] = 1;
        }
      }
    }
  }

  var_19 = 0;
  var_20 = 0;

  for(;;) {
    var_8.func_54A9 = 0;
    var_21 = undefined;

    if(!var_19 && isDefined(var_07) && isDefined(var_03)) {
      var_19 = 1;
      var_22 = undefined;
      var_20 = isDefined(level.func_EC8D[var_07]) && isDefined(level.func_EC8D[var_07][var_03]) && isDefined(level.func_EC8D[var_07][var_03]["start"]);

      if(!var_20) {
        continue;
      }
      var_23 = ["start"];
    } else
      var_00 waittill(var_01, var_23);

    if(!isarray(var_23)) {
      var_23 = [var_23];
    }

    scripts\anim\utility::validatenotetracks(var_01, var_23, var_05);
    var_24 = undefined;

    foreach(var_26 in var_23) {
      func_C0CC(var_00, var_03, var_26, var_07, var_09, var_06, var_08);

      if(var_26 == "end") {
        var_24 = 1;
      }
    }

    if(isDefined(var_24)) {
      break;
    }
  }
}

func_C0CC(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(var_02 == "end") {
    return 1;
  }

  foreach(var_12, var_08 in var_04) {
    if(isDefined(level.func_EC8D[var_03][var_12][var_02])) {
      foreach(var_10 in level.func_EC8D[var_03][var_12][var_02]) {
        func_1ED8(var_10, var_00, var_06, var_05);
      }
    }
  }

  if(var_00 func_C0DB(var_02)) {
    return;
  }
  func_7729(var_00, var_02);
}

func_C0DB(var_00) {
  var_01 = getsubstr(var_00, 0, 3);

  if(var_01 == "ps_") {
    var_02 = getsubstr(var_00, 3);

    if(isDefined(self.func_1EFF)) {
      self thread[[self.func_1EFF]](var_02, "j_head", 1);
    } else {
      var_03 = strtok(var_02, ",");

      if(var_3.size < 2) {
        thread scripts\sp\utility::play_sound_on_tag(var_02, undefined, 1);
      } else {
        thread scripts\sp\utility::play_sound_on_tag(var_3[0], var_3[1], 1);
      }
    }

    return 1;
  }

  if(var_01 == "vo_") {
    var_02 = getsubstr(var_00, 3);

    if(isDefined(self.func_1EFF)) {
      self thread[[self.func_1EFF]](var_02, "j_head", 1);
    } else if(!issentient(self)) {
      thread scripts\sp\utility::play_sound_on_tag(var_02, "j_head", 1, var_02);
    } else {
      self getyawtoenemy(var_02, "sounddone", 1);
    }

    return 1;
  }

  if(var_01 == "sd_") {
    var_02 = getsubstr(var_00, 3);
    thread scripts\sp\utility::func_10346(var_02);
    return 1;
  }

  if(var_01 == "sr_") {
    var_02 = getsubstr(var_00, 3);
    level thread scripts\sp\utility::func_10350(var_02);
    return 1;
  }

  if(var_01 == "rm_") {
    var_04 = getsubstr(var_00, 3);
    level.player playrumbleonentity(var_04);
    return 1;
  }

  if(var_01 == "fx_") {
    var_05 = strtok(tolower(var_00), "[]");
    var_06 = strtok(getsubstr(var_5[0], 3), ",() ");
    var_07 = [];

    if(var_5.size > 1) {
      for(var_08 = 1; var_08 < var_5.size; var_8++) {
        var_09 = strtok(var_5[var_08], ",");

        if(var_9.size > 1) {
          var_06 = scripts\engine\utility::array_add(var_06, (float(var_9[0]), float(var_9[1]), float(var_9[2])));
          continue;
        }

        var_06 = scripts\engine\utility::array_add(var_06, var_9[0]);
      }
    }

    if(var_6.size == 2) {
      if(var_6[0] == "exploder") {
        scripts\engine\utility::exploder(var_6[1]);
        return 1;
      } else if(var_6[0] == "stop_exploder") {
        scripts\sp\utility::func_10FEC(var_6[1]);
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
        _killfxontag(level._effect[var_6[1]], self, var_6[2]);
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

  var_01 = getsubstr(var_00, 0, 4);

  if(var_01 == "psr_") {
    var_02 = getsubstr(var_00, 4);
    scripts\sp\utility::func_DBEF(var_02);
    return 1;
  }

  if(var_01 == "pip_") {
    var_02 = getsubstr(var_00, 4);

    if(isDefined(self.func_1EFF)) {
      self thread[[self.func_1EFF]](var_02, "j_head", 1);
    } else {
      thread scripts\sp\pip_util::func_CBA5(var_02);
    }

    return 1;
  }

  if(var_01 == "pvo_") {
    var_02 = getsubstr(var_00, 4);
    thread scripts\sp\utility::func_1034D(var_02);
    return 1;
  }

  if(var_01 == "fov_") {
    var_13 = strtok(var_00, "_");
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

func_7729(var_00, var_01) {
  switch (var_01) {
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
      var_0.func_7245 = 1;
      break;
    case "follow on":
      var_0.func_7245 = 0;
      break;
    case "lookat_plr_head_on":
      var_00 thread scripts\sp\utility::func_7799(level.player, 0.15, 0.7);
      break;
    case "lookat_plr_eyes_on":
      var_00 thread scripts\sp\utility::func_7798(level.player, 4.0, 0.1);
      break;
    case "lookat_plr_off":
      var_00 thread scripts\sp\utility::func_77B9(0.7);
      break;
    case "lookat_plr_eyes_off":
      var_00 thread scripts\sp\utility::func_7793(0.1);
      break;
    case "lookat_plr_head_off":
      var_00 thread scripts\sp\utility::func_779E(0.7);
      break;
    case "bc_vo_start":
      var_00 notify("bc_vochat_start");
      break;
    case "blind_on":
      var_00 func_0F18::func_10E8A("set_blind", 1);
      break;
    case "blind_off":
      var_00 func_0F18::func_10E8A("set_blind", 0);
      break;
    case "helmet_on":
      if(!isai(var_00)) {
        var_00 thread func_0E4B::func_8E05();
      }

      break;
    case "helmet_on_visor_up":
      if(!isai(var_00)) {
        var_00 thread func_0E4B::func_8E05(1);
      }

      break;
    case "helmet_on_visor_up_no_audio":
      if(!isai(var_00)) {
        var_00 thread func_0E4B::func_8E05(1, undefined, 1);
      }

      break;
    case "helmet_off":
      if(!isai(var_00)) {
        var_00 thread func_0E4B::func_8E02();
      }

      break;
    case "visor_up":
    case "visor_raise":
      if(!isai(var_00)) {
        var_00 thread func_0E4B::func_1348D();
      }

      break;
    case "visor_down":
    case "visor_lower":
      if(!isai(var_00)) {
        var_00 thread func_0E4B::func_13485();
      }

      break;
    case "plr_pull_visor_down_activate_lma_normal_and_clear":
      thread func_0B0B::func_25C2();
      break;
    case "plr_pull_visor_down_activate_lma_fast_and_clear":
      thread func_0B0B::func_25C2(1.0, "fast");
      break;
    case "plr_helmet_on_closed_visor_activate_lma_and_clear":
      thread func_0B0B::func_25C0();
      break;
    case "opsmap_scene_start":
      if(isDefined(var_0.func_9A30)) {
        var_00 thread scripts\sp\interaction::func_CD50(var_0.func_9A30, var_0.func_C6B8);
      }

      break;
    case "opsmap_scene_end":
      if(isDefined(var_0.func_9A30)) {
        var_00 thread scripts\sp\interaction::func_9A0F();
      }

      break;
    case "vr_npc_switch_fire_rate":
      var_00 thread func_0EFB::func_25ED();
      break;
  }
}

func_1ED8(var_00, var_01, var_02, var_03) {
  if(isDefined(var_0["function"])) {
    self thread[[var_0["function"]]](var_01);
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
    var_01 func_86DE();
    return;
  }

  if(isDefined(var_0["attach gun right"])) {
    var_01 func_86DF();
    return;
  }

  if(isDefined(var_0["detach gun"])) {
    var_01 func_86D5(var_00);
    return;
  }

  if(isDefined(var_0["attach model"])) {
    if(isDefined(var_0["selftag"])) {
      var_01 attach(var_0["attach model"], var_0["selftag"]);
    } else {
      var_03 attach(var_0["attach model"], var_0["tag"]);
    }

    return;
  }

  if(isDefined(var_0["detach model"])) {
    if(isDefined(var_0["selftag"])) {
      var_01 detach(var_0["detach model"], var_0["selftag"]);
    } else {
      var_03 detach(var_0["detach model"], var_0["tag"]);
    }
  }

  if(isDefined(var_0["sound"])) {
    var_04 = undefined;

    if(!isDefined(var_0["sound_stays_death"])) {
      var_04 = 1;
    }

    var_05 = undefined;

    if(isDefined(var_0["sound_on_tag"])) {
      var_05 = var_0["sound_on_tag"];
    }

    var_01 thread scripts\sp\utility::play_sound_on_tag(var_0["sound"], var_05, var_04);
  }

  if(isDefined(var_0["playersound"])) {
    level.player playSound(var_0["playersound"]);
  }

  if(isDefined(var_0["playerdialogue"])) {
    level.player thread scripts\sp\utility::func_1034D(var_0["playerdialogue"]);
  }

  if(!var_2.func_54A9) {
    if(isDefined(var_0["dialog"]) && isDefined(var_2.func_53F2[var_0["dialog"]])) {
      var_01 scripts\anim\face::sayspecificdialogue(var_0["dialog"]);
      var_2.func_53F2[var_0["dialog"]] = undefined;
      var_2.func_54A9 = 1;
    }
  }

  if(isDefined(var_0["create model"])) {
    func_1E93(var_01, var_00);
  } else if(isDefined(var_0["delete model"])) {
    func_1F1E(var_01, var_00);
  }

  if(isDefined(var_0["selftag"])) {
    if(isDefined(var_0["effect"])) {
      level thread func_C0C8(var_01, var_00);
    }

    if(isDefined(var_0["stop_effect"])) {
      stopFXOnTag(level._effect[var_0["stop_effect"]], var_01, var_0["selftag"]);
    }

    if(isDefined(var_0["swap_part_to_efx"])) {
      playFXOnTag(level._effect[var_0["swap_part_to_efx"]], var_01, var_0["selftag"]);
      var_01 hidepart(var_0["selftag"]);
    }

    if(isDefined(var_0["trace_part_for_efx"])) {
      var_06 = undefined;
      var_07 = scripts\engine\utility::getfx(var_0["trace_part_for_efx"]);

      if(isDefined(var_0["trace_part_for_efx_water"])) {
        var_06 = scripts\engine\utility::getfx(var_0["trace_part_for_efx_water"]);
      }

      var_08 = 0;

      if(isDefined(var_0["trace_part_for_efx_delete_depth"])) {
        var_08 = var_0["trace_part_for_efx_delete_depth"];
      }

      var_01 thread func_11A80(var_0["selftag"], var_07, var_06, var_08);
    }

    if(isDefined(var_0["trace_part_for_efx_canceling"])) {
      var_01 thread func_11A81(var_0["selftag"]);
    }
  }

  if(isDefined(var_0["tag"]) && isDefined(var_0["effect"])) {
    playFXOnTag(level._effect[var_0["effect"]], var_03, var_0["tag"]);
  }

  if(isDefined(var_0["selftag"]) && isDefined(var_0["effect_looped"])) {
    playFXOnTag(level._effect[var_0["effect_looped"]], var_01, var_0["selftag"]);
  }
}

func_1E93(var_00, var_01) {
  if(!isDefined(var_0.func_EF84)) {
    var_0.func_EF84 = [];
  }

  var_02 = var_0.func_EF84.size;
  var_0.func_EF84[var_02] = spawn("script_model", (0, 0, 0));
  var_0.func_EF84[var_02] setModel(var_1["create model"]);
  var_0.func_EF84[var_02].origin = var_00 gettagorigin(var_1["selftag"]);
  var_0.func_EF84[var_02].angles = var_00 gettagangles(var_1["selftag"]);
}

func_1F1E(var_00, var_01) {
  for(var_02 = 0; var_02 < var_0.func_EF84.size; var_2++) {
    if(isDefined(var_1["explosion"])) {
      var_03 = anglesToForward(var_0.func_EF84[var_02].angles);
      var_03 = var_03 * 120;
      var_03 = var_03 + var_0.func_EF84[var_02].origin;
      playFX(level._effect[var_1["explosion"]], var_0.func_EF84[var_02].origin);
      radiusdamage(var_0.func_EF84[var_02].origin, 350, 700, 50);
    }

    var_0.func_EF84[var_02] delete();
  }
}

func_86DE() {
  if(!isDefined(self.func_86DB)) {
    return;
  }
  self.func_86DB delete();
  self.dropweapon = 1;
  scripts\anim\shared::placeweaponon(self.weapon, "left");
}

func_86DF() {
  if(!isDefined(self.func_86DB)) {
    return;
  }
  self.func_86DB delete();
  self.dropweapon = 1;
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

func_86D5(var_00) {
  if(isDefined(self.func_86DB)) {
    return;
  }
  var_01 = self gettagorigin(var_0["tag"]);
  var_02 = self gettagangles(var_0["tag"]);
  var_03 = 0;

  if(isDefined(var_0["suspend"])) {
    var_03 = var_0["suspend"];
  }

  var_04 = spawn("weapon_" + self.weapon, var_01, var_03);
  var_4.angles = var_02;
  self.func_86DB = var_04;
  scripts\anim\shared::placeweaponon(self.weapon, "none");
  self.dropweapon = 0;
}

func_C0C8(var_00, var_01) {
  var_02 = isDefined(var_1["moreThanThreeHack"]);

  if(var_02) {
    scripts\engine\utility::lock("moreThanThreeHack");
  }

  playFXOnTag(level._effect[var_1["effect"]], var_00, var_1["selftag"]);

  if(var_02) {
    scripts\engine\utility::unlock("moreThanThreeHack");
  }
}

func_11A81(var_00) {
  self notify("cancel_trace_for_part_" + var_00);
}

func_11A80(var_00, var_01, var_02, var_03) {
  var_04 = "trace_part_for_efx";
  self endon("cancel_trace_for_part_" + var_00);
  var_05 = self gettagorigin(var_00);
  var_06 = 0;
  var_07 = spawnStruct();
  var_7.func_A8F6 = self gettagorigin(var_00);
  var_7.func_9032 = 0;
  var_7.part = var_00;
  var_7.func_9034 = 0;
  var_7.effect = var_01;
  var_7.func_10E51 = 0;
  var_7.func_A8EE = gettime();

  while(isDefined(self) && !var_7.func_9032) {
    scripts\engine\utility::lock(var_04);
    func_1173F(var_07);
    scripts\sp\utility::func_12BDD(var_04);

    if(var_7.func_10E51 == 1 && gettime() - var_7.func_A8EE > 3000) {
      return;
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_02) && var_7.func_9034) {
    var_01 = var_02;
  }

  playFX(var_01, var_7.func_A8F6);

  if(var_03 == 0) {
    self hidepart(var_00);
  } else {
    thread func_8ED1(var_7.func_A8F6[2] - var_03, var_00);
  }
}

func_8ED1(var_00, var_01) {
  self endon("entitydeleted");

  while(self gettagorigin(var_01)[2] > var_00) {
    wait 0.05;
  }

  self hidepart(var_01);
}

func_1173F(var_00) {
  var_01 = undefined;

  if(!isDefined(self)) {
    return;
  }
  var_0.func_4B9E = self gettagorigin(var_0.part);

  if(var_0.func_4B9E != var_0.func_A8F6) {
    var_0.func_A8EE = gettime();
    var_0.func_10E51 = 0;

    if(!bullettracepassed(var_0.func_A8F6, var_0.func_4B9E, 0, self)) {
      var_02 = bulletTrace(var_0.func_A8F6, var_0.func_4B9E, 0, self);

      if(var_2["fraction"] < 1.0) {
        var_0.func_A8F6 = var_2["position"];
        var_0.func_9034 = var_2["surfacetype"] == "water";
        var_0.func_9032 = 1;
        return;
      } else {}
    }
  } else
    var_0.func_10E51 = 1;

  var_0.func_A8F6 = var_0.func_4B9E;
}

func_1FD5(var_00, var_01) {
  var_01 = tolower(var_01);
  var_02 = getarraykeys(self.func_1FDC);

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = var_2[var_03];

    if(self.func_1FDC[var_04].func_1FAF != var_00) {
      continue;
    }
    if(self.func_1FDC[var_04].func_C0C2 != var_01) {
      continue;
    }
    self.func_1FDC[var_04].func_6303 = gettime() + 60000;
    return 1;
  }

  return 0;
}

func_1FDB(var_00, var_01, var_02) {
  var_01 = tolower(var_01);
  func_1754();

  if(var_01 == "end") {
    return;
  }
  if(func_1FD5(var_00, var_01)) {
    return;
  }
  var_03 = spawnStruct();
  var_3.func_1FAF = var_00;
  var_3.func_C0C2 = var_01;
  var_3.func_1FBB = var_02;
  var_3.func_6303 = gettime() + 60000;
  func_1697(var_03);
}

func_1FD8(var_00, var_01) {
  func_1754();
  var_02 = spawnStruct();
  var_2.func_1FAF = var_00;
  var_2.func_C0C2 = "#" + var_00;
  var_2.func_1FBB = var_01;
  var_2.func_6303 = gettime() + 60000;

  if(func_1FD5(var_00, var_2.func_C0C2)) {
    return;
  }
  func_1697(var_02);
}

func_1FD9(var_00, var_01, var_02) {
  func_1754();
  var_00 = var_01 + var_00;
  var_03 = spawnStruct();
  var_3.func_1FAF = var_00;
  var_3.func_C0C2 = "#" + var_00;
  var_3.func_1FBB = var_02;
  var_3.func_6303 = gettime() + 60000;

  if(func_1FD5(var_00, var_3.func_C0C2)) {
    return;
  }
  func_1697(var_03);
}

func_1697(var_00) {
  for(var_01 = 0; var_01 < level.func_1FD7; var_1++) {
    if(isDefined(self.func_1FDC[var_01])) {
      continue;
    }
    self.func_1FDC[var_01] = var_00;
    return;
  }

  var_02 = getarraykeys(self.func_1FDC);
  var_03 = var_2[0];
  var_04 = self.func_1FDC[var_03].func_6303;

  for(var_01 = 1; var_01 < var_2.size; var_1++) {
    var_05 = var_2[var_01];

    if(self.func_1FDC[var_05].func_6303 < var_04) {
      var_04 = self.func_1FDC[var_05].func_6303;
      var_03 = var_05;
    }
  }

  self.func_1FDC[var_03] = var_00;
}

func_1754() {
  if(!isDefined(self.func_1FDC)) {
    self.func_1FDC = [];
  }

  var_00 = 0;

  for(var_01 = 0; var_01 < level.func_1FDC.size; var_1++) {
    if(self == level.func_1FDC[var_01]) {
      var_00 = 1;
      break;
    }
  }

  if(!var_00) {
    level.func_1FDC[level.func_1FDC.size] = self;
  }
}

func_6A85(var_00, var_01, var_02) {
  self endon(var_02);
  var_00 endon("death");
  var_00 endon("stop_loop");
  var_00 endon("scripted_face_done");

  for(;;) {
    self waittill(var_01, var_03);

    foreach(var_05 in var_03) {
      var_06 = getsubstr(var_05, 0, 3);

      if(var_06 == "vo_") {
        var_07 = getsubstr(var_05, 3);

        if(!issentient(self)) {
          thread scripts\sp\utility::play_sound_on_tag(var_07, "j_head", 1, var_07);
        } else {
          self getyawtoenemy(var_07, "face_sounddone", 1);
        }

        continue;
      }

      if(var_06 == "pvo") {
        var_07 = getsubstr(var_05, 4);
        thread scripts\sp\utility::func_1034D(var_07);
      }
    }
  }
}