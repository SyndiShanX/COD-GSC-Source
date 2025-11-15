/*******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\anim.gsc
*******************************/

func_C0E1(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("stop_sequencing_notetracks");
  param_00 endon("death");
  if(isDefined(param_02)) {
    var_06 = param_02;
  } else {
    var_06 = self;
  }

  var_07 = undefined;
  if(isDefined(param_04)) {
    var_07 = param_04;
  } else {
    var_07 = param_00.var_1FBB;
  }

  var_08 = spawnStruct();
  var_08.var_53F2 = [];
  var_09 = [];
  if(isDefined(var_07) && isDefined(level.var_EC8D[var_07]) && isDefined(param_03)) {
    if(isDefined(level.var_EC8D[var_07][param_03])) {
      var_09[param_03] = level.var_EC8D[var_07][param_03];
    }

    if(isDefined(level.var_EC8D[var_07]["any"])) {
      var_09["any"] = level.var_EC8D[var_07]["any"];
    }
  }

  foreach(var_12, var_0B in var_09) {
    foreach(var_0D in level.var_EC8D[var_07][var_12]) {
      foreach(var_0F in var_0D) {
        if(isDefined(var_0F["dialog"])) {
          var_08.var_53F2[var_0F["dialog"]] = 1;
        }
      }
    }
  }

  var_13 = 0;
  var_14 = 0;
  for(;;) {
    var_08.var_54A9 = 0;
    var_15 = undefined;
    if(!var_13 && isDefined(var_07) && isDefined(param_03)) {
      var_13 = 1;
      var_16 = undefined;
      var_14 = isDefined(level.var_EC8D[var_07]) && isDefined(level.var_EC8D[var_07][param_03]) && isDefined(level.var_EC8D[var_07][param_03]["start"]);
      if(!var_14) {
        continue;
      }

      var_17 = ["start"];
    } else {
      param_00 waittill(param_01, var_17);
    }

    if(!isarray(var_17)) {
      var_17 = [var_17];
    }

    scripts\anim\utility::validatenotetracks(param_01, var_17, param_05);
    var_18 = undefined;
    foreach(var_1A in var_17) {
      func_C0CC(param_00, param_03, var_1A, var_07, var_09, var_06, var_08);
      if(var_1A == "end") {
        var_18 = 1;
      }
    }

    if(isDefined(var_18)) {
      break;
    }
  }
}

func_C0CC(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(param_02 == "end") {
    return 1;
  }

  foreach(var_0C, var_08 in param_04) {
    if(isDefined(level.var_EC8D[param_03][var_0C][param_02])) {
      foreach(var_0A in level.var_EC8D[param_03][var_0C][param_02]) {
        func_1ED8(var_0A, param_00, param_06, param_05);
      }
    }
  }

  if(param_00 func_C0DB(param_02)) {
    return;
  }

  func_7729(param_00, param_02);
}

func_C0DB(param_00) {
  var_01 = getsubstr(param_00, 0, 3);
  if(var_01 == "ps_") {
    var_02 = getsubstr(param_00, 3);
    if(isDefined(self.var_1EFF)) {
      self thread[[self.var_1EFF]](var_02, "j_head", 1);
    } else {
      var_03 = strtok(var_02, ",");
      if(var_03.size < 2) {
        thread scripts\sp\utility::play_sound_on_tag(var_02, undefined, 1);
      } else {
        thread scripts\sp\utility::play_sound_on_tag(var_03[0], var_03[1], 1);
      }
    }

    return 1;
  }

  if(var_02 == "vo_") {
    var_02 = getsubstr(var_01, 3);
    if(isDefined(self.var_1EFF)) {
      self thread[[self.var_1EFF]](var_02, "j_head", 1);
    } else if(!issentient(self)) {
      thread scripts\sp\utility::play_sound_on_tag(var_02, "j_head", 1, var_02);
    } else {
      self getyawtoenemy(var_02, "sounddone", 1);
    }

    return 1;
  }

  if(var_02 == "sd_") {
    var_02 = getsubstr(var_01, 3);
    thread scripts\sp\utility::func_10346(var_02);
    return 1;
  }

  if(var_02 == "sr_") {
    var_02 = getsubstr(var_01, 3);
    level thread scripts\sp\utility::func_10350(var_02);
    return 1;
  }

  if(var_02 == "rm_") {
    var_04 = getsubstr(var_01, 3);
    level.player playrumbleonentity(var_04);
    return 1;
  }

  if(var_04 == "fx_") {
    var_05 = strtok(tolower(var_02), "[]");
    var_06 = strtok(getsubstr(var_05[0], 3), ",() ");
    var_07 = [];
    if(var_05.size > 1) {
      for(var_08 = 1; var_08 < var_05.size; var_08++) {
        var_09 = strtok(var_05[var_08], ",");
        if(var_09.size > 1) {
          var_06 = scripts\engine\utility::array_add(var_06, (float(var_09[0]), float(var_09[1]), float(var_09[2])));
          continue;
        }

        var_06 = scripts\engine\utility::array_add(var_06, var_09[0]);
      }
    }

    if(var_06.size == 2) {
      if(var_06[0] == "exploder") {
        scripts\engine\utility::exploder(var_06[1]);
        return 1;
      } else if(var_06[0] == "stop_exploder") {
        scripts\sp\utility::func_10FEC(var_06[1]);
        return 1;
      } else {
        playFXOnTag(level._effect[var_06[0]], self, var_06[1]);
        return 1;
      }
    } else if(var_06.size == 3) {
      if(var_06[0] == "playfxontag") {
        playFXOnTag(level._effect[var_06[1]], self, var_06[2]);
        return 1;
      } else if(var_06[0] == "stopfxontag") {
        stopFXOnTag(level._effect[var_06[1]], self, var_06[2]);
        return 1;
      } else if(var_06[0] == "killfxontag") {
        killfxontag(level._effect[var_06[1]], self, var_06[2]);
        return 1;
      }
    } else if(var_06.size == 6) {
      if(var_06[0] == "debris") {
        playFXOnTag(level._effect[var_06[1]], self, var_06[2]);
        self hidepart(var_06[2], var_06[3]);
        return 1;
      }
    } else if(var_06.size == 11) {
      var_0A = (float(var_06[2]), float(var_06[3]), float(var_06[4]));
      var_0B = (float(var_06[5]), float(var_06[6]), float(var_06[7]));
      var_0C = (float(var_06[8]), float(var_06[9]), float(var_06[10]));
      playFX(level._effect[var_06[1]], var_0A, var_0B, var_0C);
    }
  }

  var_04 = getsubstr(var_02, 0, 4);
  if(var_04 == "psr_") {
    var_02 = getsubstr(var_02, 4);
    scripts\sp\utility::func_DBEF(var_04);
    return 1;
  }

  if(var_04 == "pip_") {
    var_02 = getsubstr(var_02, 4);
    if(isDefined(self.var_1EFF)) {
      self thread[[self.var_1EFF]](var_04, "j_head", 1);
    } else {
      thread scripts\sp\pip::func_CBA5(var_04);
    }

    return 1;
  }

  if(var_04 == "pvo_") {
    var_02 = getsubstr(var_02, 4);
    thread scripts\sp\utility::func_1034D(var_04);
    return 1;
  }

  if(var_04 == "fov_") {
    var_0D = strtok(var_02, "_");
    var_0E = var_0D[1];
    var_0F = 65;
    var_10 = undefined;
    if(var_0E == "start") {
      var_0F = float(var_0D[2]);
      var_10 = float(var_0D[3]);
      level.player _meth_81DE(var_0F, var_10);
    } else {
      var_10 = float(var_0D[2]);
      level.player _meth_81DE(var_0F, var_10);
    }

    return 1;
  }

  return 0;
}

func_7729(param_00, param_01) {
  switch (param_01) {
    case "ignoreall true":
      param_00.precacheleaderboards = 1;
      break;

    case "ignoreall false":
      param_00.precacheleaderboards = 0;
      break;

    case "ignoreme true":
      param_00.ignoreme = 1;
      break;

    case "ignoreme false":
      param_00.ignoreme = 0;
      break;

    case "allowdeath true":
      param_00.var_30 = 1;
      break;

    case "allowdeath false":
      param_00.var_30 = 0;
      break;

    case "follow off":
      param_00.var_7245 = 1;
      break;

    case "follow on":
      param_00.var_7245 = 0;
      break;

    case "lookat_plr_head_on":
      param_00 thread scripts\sp\utility::func_7799(level.player, 0.15, 0.7);
      break;

    case "lookat_plr_eyes_on":
      param_00 thread scripts\sp\utility::func_7798(level.player, 4, 0.1);
      break;

    case "lookat_plr_off":
      param_00 thread scripts\sp\utility::func_77B9(0.7);
      break;

    case "lookat_plr_eyes_off":
      param_00 thread scripts\sp\utility::func_7793(0.1);
      break;

    case "lookat_plr_head_off":
      param_00 thread scripts\sp\utility::func_779E(0.7);
      break;

    case "bc_vo_start":
      param_00 notify("bc_vochat_start");
      break;

    case "blind_on":
      param_00 lib_0F18::func_10E8A("set_blind", 1);
      break;

    case "blind_off":
      param_00 lib_0F18::func_10E8A("set_blind", 0);
      break;

    case "helmet_on":
      if(!isai(param_00)) {
        param_00 thread lib_0E4B::func_8E05();
      }
      break;

    case "helmet_on_visor_up":
      if(!isai(param_00)) {
        param_00 thread lib_0E4B::func_8E05(1);
      }
      break;

    case "helmet_on_visor_up_no_audio":
      if(!isai(param_00)) {
        param_00 thread lib_0E4B::func_8E05(1, undefined, 1);
      }
      break;

    case "helmet_off":
      if(!isai(param_00)) {
        param_00 thread lib_0E4B::func_8E02();
      }
      break;

    case "visor_up":
    case "visor_raise":
      if(!isai(param_00)) {
        param_00 thread lib_0E4B::func_1348D();
      }
      break;

    case "visor_down":
    case "visor_lower":
      if(!isai(param_00)) {
        param_00 thread lib_0E4B::func_13485();
      }
      break;

    case "plr_pull_visor_down_activate_lma_normal_and_clear":
      thread scripts\sp\audio::func_25C2();
      break;

    case "plr_pull_visor_down_activate_lma_fast_and_clear":
      thread scripts\sp\audio::func_25C2(1, "fast");
      break;

    case "plr_helmet_on_closed_visor_activate_lma_and_clear":
      thread scripts\sp\audio::func_25C0();
      break;

    case "opsmap_scene_start":
      if(isDefined(param_00.var_9A30)) {
        param_00 thread scripts\sp\interaction::func_CD50(param_00.var_9A30, param_00.var_C6B8);
      }
      break;

    case "opsmap_scene_end":
      if(isDefined(param_00.var_9A30)) {
        param_00 thread scripts\sp\interaction::func_9A0F();
      }
      break;

    case "vr_npc_switch_fire_rate":
      param_00 thread lib_0EFB::func_25ED();
      break;
  }
}

func_1ED8(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00["function"])) {
    self thread[[param_00["function"]]](param_01);
  }

  if(isDefined(param_00["flag"])) {
    scripts\engine\utility::flag_set(param_00["flag"]);
  }

  if(isDefined(param_00["flag_clear"])) {
    scripts\engine\utility::flag_clear(param_00["flag_clear"]);
  }

  if(isDefined(param_00["notify"])) {
    level notify(param_00["notify"]);
  }

  if(isDefined(param_00["attach gun left"])) {
    param_01 func_86DE();
    return;
  }

  if(isDefined(param_00["attach gun right"])) {
    param_01 func_86DF();
    return;
  }

  if(isDefined(param_00["detach gun"])) {
    param_01 func_86D5(param_00);
    return;
  }

  if(isDefined(param_00["attach model"])) {
    if(isDefined(param_00["selftag"])) {
      param_01 attach(param_00["attach model"], param_00["selftag"]);
    } else {
      param_03 attach(param_00["attach model"], param_00["tag"]);
    }

    return;
  }

  if(isDefined(param_00["detach model"])) {
    if(isDefined(param_00["selftag"])) {
      param_01 detach(param_00["detach model"], param_00["selftag"]);
    } else {
      param_03 detach(param_00["detach model"], param_00["tag"]);
    }
  }

  if(isDefined(param_00["sound"])) {
    var_04 = undefined;
    if(!isDefined(param_00["sound_stays_death"])) {
      var_04 = 1;
    }

    var_05 = undefined;
    if(isDefined(param_00["sound_on_tag"])) {
      var_05 = param_00["sound_on_tag"];
    }

    param_01 thread scripts\sp\utility::play_sound_on_tag(param_00["sound"], var_05, var_04);
  }

  if(isDefined(param_00["playersound"])) {
    level.player playSound(param_00["playersound"]);
  }

  if(isDefined(param_00["playerdialogue"])) {
    level.player thread scripts\sp\utility::func_1034D(param_00["playerdialogue"]);
  }

  if(!param_02.var_54A9) {
    if(isDefined(param_00["dialog"]) && isDefined(param_02.var_53F2[param_00["dialog"]])) {
      param_01 scripts\anim\face::sayspecificdialogue(param_00["dialog"]);
      param_02.var_53F2[param_00["dialog"]] = undefined;
      param_02.var_54A9 = 1;
    }
  }

  if(isDefined(param_00["create model"])) {
    func_1E93(param_01, param_00);
  } else if(isDefined(param_00["delete model"])) {
    func_1F1E(param_01, param_00);
  }

  if(isDefined(param_00["selftag"])) {
    if(isDefined(param_00["effect"])) {
      level thread func_C0C8(param_01, param_00);
    }

    if(isDefined(param_00["stop_effect"])) {
      stopFXOnTag(level._effect[param_00["stop_effect"]], param_01, param_00["selftag"]);
    }

    if(isDefined(param_00["swap_part_to_efx"])) {
      playFXOnTag(level._effect[param_00["swap_part_to_efx"]], param_01, param_00["selftag"]);
      param_01 hidepart(param_00["selftag"]);
    }

    if(isDefined(param_00["trace_part_for_efx"])) {
      var_06 = undefined;
      var_07 = scripts\engine\utility::getfx(param_00["trace_part_for_efx"]);
      if(isDefined(param_00["trace_part_for_efx_water"])) {
        var_06 = scripts\engine\utility::getfx(param_00["trace_part_for_efx_water"]);
      }

      var_08 = 0;
      if(isDefined(param_00["trace_part_for_efx_delete_depth"])) {
        var_08 = param_00["trace_part_for_efx_delete_depth"];
      }

      param_01 thread func_11A80(param_00["selftag"], var_07, var_06, var_08);
    }

    if(isDefined(param_00["trace_part_for_efx_canceling"])) {
      param_01 thread func_11A81(param_00["selftag"]);
    }
  }

  if(isDefined(param_00["tag"]) && isDefined(param_00["effect"])) {
    playFXOnTag(level._effect[param_00["effect"]], param_03, param_00["tag"]);
  }

  if(isDefined(param_00["selftag"]) && isDefined(param_00["effect_looped"])) {
    playFXOnTag(level._effect[param_00["effect_looped"]], param_01, param_00["selftag"]);
  }
}

func_1E93(param_00, param_01) {
  if(!isDefined(param_00.var_EF84)) {
    param_00.var_EF84 = [];
  }

  var_02 = param_00.var_EF84.size;
  param_00.var_EF84[var_02] = spawn("script_model", (0, 0, 0));
  param_00.var_EF84[var_02] setModel(param_01["create model"]);
  param_00.var_EF84[var_02].origin = param_00 gettagorigin(param_01["selftag"]);
  param_00.var_EF84[var_02].angles = param_00 gettagangles(param_01["selftag"]);
}

func_1F1E(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.var_EF84.size; var_02++) {
    if(isDefined(param_01["explosion"])) {
      var_03 = anglesToForward(param_00.var_EF84[var_02].angles);
      var_03 = var_03 * 120;
      var_03 = var_03 + param_00.var_EF84[var_02].origin;
      playFX(level._effect[param_01["explosion"]], param_00.var_EF84[var_02].origin);
      radiusdamage(param_00.var_EF84[var_02].origin, 350, 700, 50);
    }

    param_00.var_EF84[var_02] delete();
  }
}

func_86DE() {
  if(!isDefined(self.var_86DB)) {
    return;
  }

  self.var_86DB delete();
  self.iscinematicplaying = 1;
  scripts\anim\shared::placeweaponon(self.var_394, "left");
}

func_86DF() {
  if(!isDefined(self.var_86DB)) {
    return;
  }

  self.var_86DB delete();
  self.iscinematicplaying = 1;
  scripts\anim\shared::placeweaponon(self.var_394, "right");
}

func_86D5(param_00) {
  if(isDefined(self.var_86DB)) {
    return;
  }

  var_01 = self gettagorigin(param_00["tag"]);
  var_02 = self gettagangles(param_00["tag"]);
  var_03 = 0;
  if(isDefined(param_00["suspend"])) {
    var_03 = param_00["suspend"];
  }

  var_04 = spawn("weapon_" + self.var_394, var_01, var_03);
  var_04.angles = var_02;
  self.var_86DB = var_04;
  scripts\anim\shared::placeweaponon(self.var_394, "none");
  self.iscinematicplaying = 0;
}

func_C0C8(param_00, param_01) {
  var_02 = isDefined(param_01["moreThanThreeHack"]);
  if(var_02) {
    scripts\engine\utility::lock("moreThanThreeHack");
  }

  playFXOnTag(level._effect[param_01["effect"]], param_00, param_01["selftag"]);
  if(var_02) {
    scripts\engine\utility::unlock("moreThanThreeHack");
  }
}

func_11A81(param_00) {
  self notify("cancel_trace_for_part_" + param_00);
}

func_11A80(param_00, param_01, param_02, param_03) {
  var_04 = "trace_part_for_efx";
  self endon("cancel_trace_for_part_" + param_00);
  var_05 = self gettagorigin(param_00);
  var_06 = 0;
  var_07 = spawnStruct();
  var_07.var_A8F6 = self gettagorigin(param_00);
  var_07.var_9032 = 0;
  var_07.part = param_00;
  var_07.var_9034 = 0;
  var_07.effect = param_01;
  var_07.var_10E51 = 0;
  var_07.var_A8EE = gettime();
  while(isDefined(self) && !var_07.var_9032) {
    scripts\engine\utility::lock(var_04);
    func_1173F(var_07);
    scripts\sp\utility::func_12BDD(var_04);
    if(var_07.var_10E51 == 1 && gettime() - var_07.var_A8EE > 3000) {
      return;
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(param_02) && var_07.var_9034) {
    param_01 = param_02;
  }

  playFX(param_01, var_07.var_A8F6);
  if(param_03 == 0) {
    self hidepart(param_00);
    return;
  }

  thread func_8ED1(var_07.var_A8F6[2] - param_03, param_00);
}

func_8ED1(param_00, param_01) {
  self endon("entitydeleted");
  while(self gettagorigin(param_01)[2] > param_00) {
    wait(0.05);
  }

  self hidepart(param_01);
}

func_1173F(param_00) {
  var_01 = undefined;
  if(!isDefined(self)) {
    return;
  }

  param_00.var_4B9E = self gettagorigin(param_00.part);
  if(param_00.var_4B9E != param_00.var_A8F6) {
    param_00.var_A8EE = gettime();
    param_00.var_10E51 = 0;
    if(!bullettracepassed(param_00.var_A8F6, param_00.var_4B9E, 0, self)) {
      var_02 = bulletTrace(param_00.var_A8F6, param_00.var_4B9E, 0, self);
      if(var_02["fraction"] < 1) {
        param_00.var_A8F6 = var_02["position"];
        param_00.var_9034 = var_02["surfacetype"] == "water";
        param_00.var_9032 = 1;
        return;
      } else {}
    }
  } else {
    param_00.var_10E51 = 1;
  }

  param_00.var_A8F6 = param_00.var_4B9E;
}

func_1FD5(param_00, param_01) {
  param_01 = tolower(param_01);
  var_02 = getarraykeys(self.var_1FDC);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    var_04 = var_02[var_03];
    if(self.var_1FDC[var_04].var_1FAF != param_00) {
      continue;
    }

    if(self.var_1FDC[var_04].var_C0C2 != param_01) {
      continue;
    }

    self.var_1FDC[var_04].var_6303 = gettime() + -5536;
    return 1;
  }

  return 0;
}

func_1FDB(param_00, param_01, param_02) {
  param_01 = tolower(param_01);
  func_1754();
  if(param_01 == "end") {
    return;
  }

  if(func_1FD5(param_00, param_01)) {
    return;
  }

  var_03 = spawnStruct();
  var_03.var_1FAF = param_00;
  var_03.var_C0C2 = param_01;
  var_03.var_1FBB = param_02;
  var_03.var_6303 = gettime() + -5536;
  func_1697(var_03);
}

func_1FD8(param_00, param_01) {
  func_1754();
  var_02 = spawnStruct();
  var_02.var_1FAF = param_00;
  var_02.var_C0C2 = "#" + param_00;
  var_02.var_1FBB = param_01;
  var_02.var_6303 = gettime() + -5536;
  if(func_1FD5(param_00, var_02.var_C0C2)) {
    return;
  }

  func_1697(var_02);
}

func_1FD9(param_00, param_01, param_02) {
  func_1754();
  param_00 = param_01 + param_00;
  var_03 = spawnStruct();
  var_03.var_1FAF = param_00;
  var_03.var_C0C2 = "#" + param_00;
  var_03.var_1FBB = param_02;
  var_03.var_6303 = gettime() + -5536;
  if(func_1FD5(param_00, var_03.var_C0C2)) {
    return;
  }

  func_1697(var_03);
}

func_1697(param_00) {
  for(var_01 = 0; var_01 < level.var_1FD7; var_01++) {
    if(isDefined(self.var_1FDC[var_01])) {
      continue;
    }

    self.var_1FDC[var_01] = param_00;
    return;
  }

  var_02 = getarraykeys(self.var_1FDC);
  var_03 = var_02[0];
  var_04 = self.var_1FDC[var_03].var_6303;
  for(var_01 = 1; var_01 < var_02.size; var_01++) {
    var_05 = var_02[var_01];
    if(self.var_1FDC[var_05].var_6303 < var_04) {
      var_04 = self.var_1FDC[var_05].var_6303;
      var_03 = var_05;
    }
  }

  self.var_1FDC[var_03] = param_00;
}

func_1754() {
  if(!isDefined(self.var_1FDC)) {
    self.var_1FDC = [];
  }

  var_00 = 0;
  for(var_01 = 0; var_01 < level.var_1FDC.size; var_01++) {
    if(self == level.var_1FDC[var_01]) {
      var_00 = 1;
      break;
    }
  }

  if(!var_00) {
    level.var_1FDC[level.var_1FDC.size] = self;
  }
}

func_6A85(param_00, param_01, param_02) {
  self endon(param_02);
  param_00 endon("death");
  param_00 endon("stop_loop");
  param_00 endon("scripted_face_done");
  for(;;) {
    self waittill(param_01, var_03);
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