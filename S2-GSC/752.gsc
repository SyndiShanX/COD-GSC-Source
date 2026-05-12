/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 752.gsc
*********************************************/

lib_02F0::func_7FE7() {
  level.var_06B2 = spawnStruct();
  level.var_06B2.var_061A = [];
  level.var_06B2.var_0720 = [];
  level.var_06B2.var_05E5 = [];
  level.var_06B2.var_05F8 = "entity";
  level.var_06B2.var_05F7 = 0.05;
  level.var_06B2.var_0622 = spawn("script_origin", (0, 0, 0));
}

rv_audio_update_entnotify_origin(param_00) {
  level.var_06B2.var_0622.var_0116 = param_00;
}

lib_02F0::func_800B(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = level.var_06B2.var_05F8;
  var_07 = lib_02F0::func_06C7(var_06, param_00, param_01, param_02, param_03, param_04, param_05);
  return var_07;
}

lib_02F0::func_800A(param_00, param_01, param_02, param_03) {
  var_04 = level.var_06B2.var_05F8;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = param_01;
  var_08 = lib_02F0::func_06C7(var_04, param_00, var_05, var_06, var_07, param_02, param_03);
  return var_08;
}

lib_02F0::func_800E(param_00, param_01, param_02) {
  if(isDefined(param_00) == 0) {
    return;
  }

  if(isarray(param_00) == 1) {
    foreach(var_04 in param_00) {
      if(function_0279(var_04) == 0) {
        var_04 thread lib_02F0::func_06C9(var_04, param_01);
      }
    }

    return;
  }

  param_00 thread lib_02F0::func_06C9(param_00, param_01);
}

lib_02F0::func_800F(param_00, param_01, param_02, param_03) {
  param_01 thread lib_02F0::func_06CA(param_00, param_01, param_02, param_03);
}

lib_02F0::func_8007(param_00) {
  return lib_02EF::func_8AAB(param_00);
}

lib_02F0::func_800D(param_00, param_01, param_02, param_03, param_04) {
  param_00 lib_02EF::func_8AAF(param_01, param_02, param_03, param_04);
}

lib_02F0::func_8005(param_00) {
  return lib_02EF::func_8AAA(param_00);
}

lib_02F0::func_800C(param_00, param_01, param_02, param_03, param_04) {
  param_00 lib_02EF::func_8AAC(param_01, param_02, param_03, param_04);
}

lib_02F0::func_8013(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  param_00 = lib_02F0::func_8015(param_00);
  var_07 = lib_02F0::func_06C7(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
  return var_07;
}

lib_02F0::func_8012(param_00, param_01, param_02, param_03, param_04) {
  param_00 = lib_02F0::func_8015(param_00);
  var_05 = undefined;
  var_06 = undefined;
  var_07 = param_02;
  var_08 = lib_02F0::func_06C7(param_00, param_01, var_05, var_06, var_07, param_03, param_04);
  return var_08;
}

lib_02F0::func_8010() {
  return "entity";
}

lib_02F0::func_8011() {
  return level.var_06B2.var_05F8;
}

lib_02F0::func_8014(param_00) {
  var_01 = undefined;
  if(isDefined(param_00) == 0) {
    param_00 = "entity";
  }

  level.var_06B2.var_05F8 = lib_02F0::func_8015(param_00);
}

lib_02F0::func_8006(param_00) {
  if(isDefined(param_00.var_8F4E) == 1) {
    return param_00.var_8F4E;
  }

  return "";
}

lib_02F0::func_8015(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case 0:
    case "ent":
    case "e":
    case "entity":
      var_01 = "entity";
      break;

    case 1:
    case "sound_entity":
    case "soundentity":
    case "sndent":
    case "snd":
    case "sndentity":
    case "s":
      var_01 = "sndentity";
      break;

    case 2:
    case "client_sound":
    case "clientsound":
    case "clisnd":
    case "cs":
    case "clientsnd":
    case "client":
    case "c":
      var_01 = "clientsnd";
      break;

    default:
      var_01 = undefined;
      break;
  }

  return var_01;
}

lib_02F0::func_06B5(param_00, param_01) {}

lib_02F0::func_06B4(param_00, param_01) {}

lib_02F0::func_06B3() {
  var_00 = self.var_8F4E;
  self waittill("death");
}

lib_02F0::func_06BE(param_00, param_01, param_02, param_03) {
  if(isDefined(param_02) == 1) {
    param_03 = param_02 lib_02EF::func_46BD(param_03);
    var_04 = (0, 0, 0);
    var_05 = (0, 0, 0);
    if(isDefined(param_01) == 1) {
      var_04 = param_01;
    }

    param_00 method_8449(param_02, param_03, var_04, var_05);
  }
}

lib_02F0::func_06BC(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = undefined;
  var_07 = undefined;
  var_08 = 0;
  if(isDefined(param_02) == 1 && isDefined(param_03) == 1 && isDefined(param_01) == 1) {
    var_07 = param_02 gettagorigin(param_03);
    var_07 = var_07 + param_01;
  } else if(isDefined(param_02) == 1 && isDefined(param_03) == 1) {
    var_07 = param_02 gettagorigin(param_03);
  } else if(isDefined(param_02) == 1) {
    var_07 = param_02.var_0116;
  } else if(isDefined(param_02) == 0 && isDefined(param_01) == 0) {
    var_07 = (-32768, -32768, -32768);
  } else {
    var_07 = param_01;
  }

  var_06 = spawn("script_origin", var_07);
  lib_02F0::func_06BE(var_06, param_01, param_02, param_03);
  var_06.var_8F45 = param_02;
  var_06.var_8F4E = "entity";
  return var_06;
}

lib_02F0::func_06BD(param_00) {
  if(isDefined(param_00) == 1 && function_0279(param_00) == 0) {
    param_00 delete();
  }
}

lib_02F0::func_06BF(param_00, param_01, param_02, param_03) {
  var_04 = param_00;
  var_05 = undefined;
  if(isDefined(param_00.var_8F45) == 1) {
    waittillframeend;
    if(function_0279(param_00) == 1) {
      return;
    }
  }

  var_05 = lib_02F0::func_8007(var_04);
  if(isDefined(param_02) == 0 && isDefined(var_05) == 1) {
    param_02 = var_05;
  }

  if(issoundaliaslooping(param_01) == 1) {
    var_04 method_861D(param_01, param_02);
  } else {
    var_06 = "sounddone";
    var_04 method_8617(param_01, var_06, undefined, undefined, undefined, param_02);
    var_07 = getsndaliasvalue(param_01, "secondaryaliasname");
    if(isDefined(var_07) == 1 && var_07 != "") {
      var_04 thread lib_02F0::func_06C1(param_01);
    } else {
      var_04 thread lib_02F0::func_06C2(var_06);
    }
  }

  var_06.var_8F3E = param_03;
}

lib_02F0::func_06C0(param_00) {
  param_00 endon("death");
  var_01 = param_00;
  if(isDefined(var_01) == 1 && function_0279(var_01) == 0) {
    var_01 method_8614();
    wait 0.05;
    lib_02F0::func_06BD(var_01);
  }
}

lib_02F0::func_06C1(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_02 = lookupsoundlength(param_00);
  var_03 = lib_02EF::func_468E(param_00, "pitch_min");
  if(isDefined(var_03) == 1) {
    var_02 = var_02 * 1 / var_03;
  }

  wait(var_02);
  lib_02F0::func_06BD(var_01);
}

lib_02F0::func_06C2(param_00) {
  var_01 = self;
  var_01 endon("death");
  var_01 waittill(param_00);
  lib_02F0::func_06BD(var_01);
}

lib_02F0::func_06C3(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = 1;
  var_07 = 0;
  if(isDefined(param_04) == 0) {
    param_04 = 1;
  }

  if(isDefined(param_05) == 0) {
    param_05 = lib_02EF::func_4625();
  }

  var_08 = spawnsoundentity(param_00, param_01, var_06, var_07, param_04, param_02, param_03, param_05);
  var_08.var_8F45 = param_02;
  var_08.var_8F4E = "sndentity";
  return var_08;
}

lib_02F0::func_06C4(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03) == 0) {
    param_03 = lib_02EF::func_4625();
  }

  param_00 method_863E(0, param_02, param_03);
  param_00.var_8F3E = param_01;
}

lib_02F0::func_06C5(param_00) {
  var_01 = param_00;
  if(isDefined(var_01) == 1) {
    var_02 = 0;
    var_01 method_863F(var_02);
  }
}

lib_02F0::func_06B9(param_00, param_01) {
  var_02 = param_01.var_8F4E;
  var_03 = param_01.var_4983;
  var_04 = "_rvsnd_clientsnd_notify_" + var_03;
  self endon("death");
  self endon(var_04);
  self waittill(param_00);
  param_01 notify("death");
}

lib_02F0::func_06B8(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_01) == 0) {
    param_01 = (0, 0, 0);
  }

  if(isDefined(param_03) == 1) {
    param_03 = param_02 lib_02EF::func_46BD(param_03);
    var_06 = param_02 gettagorigin(param_03);
    if(isDefined(var_06) == 1) {
      param_01 = var_06 - param_02.var_0116;
    }
  }

  var_07 = spawnStruct();
  var_07.var_8F49 = param_01;
  var_07.var_8F45 = param_02;
  var_07.var_8F44 = param_03;
  return var_07;
}

lib_02F0::func_06BA(param_00, param_01, param_02, param_03) {
  var_04 = param_00.var_8F49;
  var_05 = param_00.var_8F45;
  var_06 = param_00.var_8F44;
  var_07 = undefined;
  var_08 = undefined;
  var_09 = undefined;
  var_0A = undefined;
  var_0B = undefined;
  if(isDefined(var_04) == 1) {
    var_07 = "world";
  }

  if(isDefined(var_05) == 1) {
    var_07 = "body";
    var_08 = "soft_oriented";
  }

  if(isDefined(param_03) == 0) {
    param_03 = lib_02EF::func_4625();
  }

  param_00 = spawnStruct();
  param_00.var_4983 = playclientsound(param_01, var_05, var_04, var_07, var_06, var_08, var_09, var_0A, param_02, var_0B, param_03);
  if(isDefined(param_00.var_4983) == 0) {
    param_00 = undefined;
    return undefined;
  }

  param_00.var_8F3E = param_01;
  param_00.var_8F45 = var_05;
  param_00.var_8F4E = "clientsnd";
  param_00.var_8F49 = var_04;
  param_00.var_8F44 = var_06;
  return param_00;
}

lib_02F0::func_06BB(param_00) {
  if(isDefined(param_00) == 1 && isDefined(param_00.var_4983) == 1) {
    var_01 = 0;
    stopclientsound(param_00.var_4983, var_01);
    param_00.var_4983 = undefined;
  }
}

lib_02F0::func_06C7(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = undefined;
  var_08 = param_04;
  var_09 = undefined;
  if(function_0344(param_01) == 0) {
    return undefined;
  }

  if(isDefined(level.var_06B2.var_05F8) == 0) {
    param_00 = level.var_06B2.var_05F8;
  }

  if(isDefined(param_05) == 0) {
    if(issoundaliaslooping(param_01) == 1) {
      param_05 = level.var_06B2.var_05F7;
    } else {
      param_05 = 0;
    }
  }

  if(isDefined(param_05) == 1 && param_05 > 0) {
    var_09 = 0;
  }

  switch (param_00) {
    case "entity":
    default:
      var_07 = lib_02F0::func_06BC(param_01, var_08, param_02, param_03, var_09, param_06);
      var_07 thread lib_02F0::func_06BF(var_07, param_01, var_09, param_06);
      break;

    case "sndentity":
      var_07 = lib_02F0::func_06C3(param_01, var_08, param_02, param_03, var_09, param_06);
      var_07 thread lib_02F0::func_06C4(var_07, param_01, var_09, param_06);
      break;

    case "clientsnd":
      var_07 = lib_02F0::func_06B8(param_01, var_08, param_02, param_03, var_09, param_06);
      var_07 = lib_02F0::func_06BA(var_07, param_01, var_09, param_06);
      break;
  }

  if(param_05 > 0) {
    var_0B = 0;
    if(param_00 == "entity" && isDefined(param_02) == 1) {
      var_0B = 0.05;
    }

    var_07 thread lib_02F0::func_06C8(var_07, param_05, var_0B);
  }

  return var_07;
}

lib_02F0::func_06C9(param_00, param_01) {
  param_00 endon("death");
  var_02 = param_00.var_8F4E;
  var_03 = param_00.var_8F3E;
  if(isDefined(var_03) == 1 && issoundaliaslooping(param_00.var_8F3E) == 1 && isDefined(param_01) == 0) {
    param_01 = level.var_06B2.var_05F7;
  }

  if(isDefined(param_01) == 1) {
    lib_02F0::func_800D(param_00, 0, param_01);
    wait(param_01 + 0.05);
    if(function_0279(param_00) == 1) {
      return;
    }
  } else {
    param_01 = 0;
  }

  switch (var_02) {
    case "entity":
    default:
      lib_02F0::func_06C0(param_00);
      break;

    case "sndentity":
      lib_02F0::func_06C5(param_00);
      break;

    case "clientsnd":
      lib_02F0::func_06BB(param_00);
      break;
  }
}

lib_02F0::func_06CA(param_00, param_01, param_02, param_03) {
  param_00 endon("death");
  param_01 common_scripts\utility::func_A70A("death", "deleted");
  lib_02F0::func_06C9(param_00, param_02);
}

lib_02F0::func_06C8(param_00, param_01, param_02) {
  lib_02F0::func_800D(param_00, 0, 0);
  if(isDefined(param_02) == 1 && param_02 > 0) {
    param_00 endon("rvSndAbortInitialFadeIn");
    wait(param_02);
    waittillframeend;
  }

  if(isDefined(param_00) && !function_0279(param_00)) {
    lib_02F0::func_800D(param_00, 1, param_01);
  }
}

lib_02F0::func_8009(param_00, param_01, param_02, param_03) {
  var_04 = self;
  if(isDefined(param_02) == 0) {
    param_02 = 0;
  }

  if(isDefined(param_03) == 0) {
    param_03 = 0;
  }

  if(isDefined(var_04.var_8F4E) == 0 && lib_02EF::func_56DB(var_04) == 1) {
    var_04 moveto(param_00, param_01, param_02, param_03);
    return;
  }

  switch (var_04.var_8F4E) {
    case "entity":
    default:
      var_04 moveto(param_00, param_01, param_02, param_03);
      break;

    case "sndentity":
      if(isDefined(var_04.var_8F45) == 1) {
        var_04.var_8F45 moveto(param_00, param_01, param_02, param_03);
      } else {
        var_04 moveto(param_00, param_01, param_02, param_03);
      }
      break;

    case "clientsnd":
      break;
  }
}

lib_02F0::func_8008(param_00) {
  if(isDefined(param_00) == 1 && isDefined(param_00.var_8F4E) == 1) {
    switch (param_00.var_8F4E) {
      default:
        break;

      case "clientsnd":
      case "sndentity":
      case "entity":
        return 1;
    }
  }

  return 0;
}