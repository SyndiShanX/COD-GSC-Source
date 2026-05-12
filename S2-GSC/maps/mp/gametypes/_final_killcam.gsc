/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_final_killcam.gsc
************************************************/

func_9454(param_00) {
  level endon("stream_end");
  foreach(var_02 in level.var_744A) {
    if(isai(var_02)) {
      continue;
    }

    if(isDefined(var_02.var_9459) && var_02.var_9459.size > 0) {
      while(isPlayer(var_02) && isPlayer(param_00) && !var_02 method_842C(param_00, var_02.var_9459[0])) {
        wait 0.05;
      }
    }
  }

  level notify("stream_end");
}

func_7D67() {
  foreach(var_01 in level.var_744A) {
    if(!isai(var_01)) {
      var_01 method_8533(0);
    }
  }

  function_03B7(0);
}

func_9458(param_00) {
  level endon("stream_end");
  wait(param_00);
  level notify("stream_end");
}

func_A6C9(param_00) {
  thread func_9458(5);
  func_9454(param_00);
}

func_44D9() {
  return 15;
}

func_0F11() {
  foreach(var_01 in level.var_744A) {
    if(isDefined(var_01.var_5A29)) {
      return 1;
    }
  }

  return 0;
}

func_3B5E(param_00, param_01, param_02, param_03) {
  var_04 = isDefined(param_00) && isDefined(param_01) && !maps\mp\_utility::func_761E() && !maps\mp\_utility::func_579B() && (isDefined(level.var_984D) && !level.var_984D) || (isDefined(param_01.var_01A7) && isDefined(param_00.var_01A7) && param_01.var_01A7 != param_00.var_01A7) || level.var_3FDC == "ball" && isDefined(level.var_3B59) && isDefined(level.var_3B59[param_01.var_01A7]) && level.var_3B59[param_01.var_01A7] == "score";
  if(var_04) {
    var_05 = func_44D9();
    var_06 = param_02 - param_03;
    if(var_06 <= var_05) {
      return 1;
    }
  }

  return 0;
}

func_52B8() {
  level.var_3B51 = [];
  level.var_3B5B = [];
  level.var_3B4C = [];
  level.var_3B4E = [];
  level.var_3B52 = [];
  level.var_3B53 = [];
  level.var_3B56 = [];
  level.var_3B50 = [];
  level.var_3B54 = [];
  level.var_3B58 = [];
  level.var_3B57 = [];
  level.var_3B55 = [];
  level.var_3B59 = [];
  level.var_3B5A = [];
  level.var_3B4F = [];
  level.var_3B4D = [];
  if(level.var_6520) {
    foreach(var_01 in level.var_985B) {
      level.var_3B51[var_01] = undefined;
      level.var_3B5B[var_01] = undefined;
      level.var_3B4C[var_01] = undefined;
      level.var_3B4E[var_01] = undefined;
      level.var_3B52[var_01] = undefined;
      level.var_3B53[var_01] = undefined;
      level.var_3B56[var_01] = undefined;
      level.var_3B50[var_01] = undefined;
      level.var_3B54[var_01] = undefined;
      level.var_3B58[var_01] = undefined;
      level.var_3B57[var_01] = undefined;
      level.var_3B55[var_01] = undefined;
      level.var_3B59[var_01] = undefined;
      level.var_3B5A[var_01] = undefined;
      level.var_3B4F[var_01] = undefined;
      level.var_3B4D[var_01] = undefined;
    }
  } else {
    level.var_3B51["axis"] = undefined;
    level.var_3B5B["axis"] = undefined;
    level.var_3B4C["axis"] = undefined;
    level.var_3B4E["axis"] = undefined;
    level.var_3B52["axis"] = undefined;
    level.var_3B53["axis"] = undefined;
    level.var_3B56["axis"] = undefined;
    level.var_3B50["axis"] = undefined;
    level.var_3B54["axis"] = undefined;
    level.var_3B58["axis"] = undefined;
    level.var_3B57["axis"] = undefined;
    level.var_3B55["axis"] = undefined;
    level.var_3B59["axis"] = undefined;
    level.var_3B5A["axis"] = undefined;
    level.var_3B4F["axis"] = undefined;
    level.var_3B4D["axis"] = undefined;
    level.var_3B51["allies"] = undefined;
    level.var_3B5B["allies"] = undefined;
    level.var_3B4C["allies"] = undefined;
    level.var_3B4E["allies"] = undefined;
    level.var_3B52["allies"] = undefined;
    level.var_3B53["allies"] = undefined;
    level.var_3B56["allies"] = undefined;
    level.var_3B50["allies"] = undefined;
    level.var_3B54["allies"] = undefined;
    level.var_3B58["allies"] = undefined;
    level.var_3B57["allies"] = undefined;
    level.var_3B55["allies"] = undefined;
    level.var_3B59["allies"] = undefined;
    level.var_3B5A["allies"] = undefined;
    level.var_3B4F["allies"] = undefined;
    level.var_3B4D["allies"] = undefined;
  }

  level.var_3B51["none"] = undefined;
  level.var_3B5B["none"] = undefined;
  level.var_3B4C["none"] = undefined;
  level.var_3B4E["none"] = undefined;
  level.var_3B52["none"] = undefined;
  level.var_3B53["none"] = undefined;
  level.var_3B56["none"] = undefined;
  level.var_3B50["none"] = undefined;
  level.var_3B54["none"] = undefined;
  level.var_3B58["none"] = undefined;
  level.var_3B57["none"] = undefined;
  level.var_3B55["none"] = undefined;
  level.var_3B59["none"] = undefined;
  level.var_3B5A["none"] = undefined;
  level.var_3B4F["none"] = undefined;
  level.var_3B4D["none"] = undefined;
  level.var_3B5C = undefined;
}

func_3801() {
  if(level.var_6520) {
    for(var_00 = 0; var_00 < level.var_985B.size; var_00++) {
      level.var_3B51[level.var_985B[var_00]] = undefined;
      level.var_3B5B[level.var_985B[var_00]] = undefined;
      level.var_3B4C[level.var_985B[var_00]] = undefined;
      level.var_3B4E[level.var_985B[var_00]] = undefined;
      level.var_3B52[level.var_985B[var_00]] = undefined;
      level.var_3B53[level.var_985B[var_00]] = undefined;
      level.var_3B56[level.var_985B[var_00]] = undefined;
      level.var_3B50[level.var_985B[var_00]] = undefined;
      level.var_3B54[level.var_985B[var_00]] = undefined;
      level.var_3B58[level.var_985B[var_00]] = undefined;
      level.var_3B57[level.var_985B[var_00]] = undefined;
      level.var_3B55[level.var_985B[var_00]] = undefined;
      level.var_3B59[level.var_985B[var_00]] = undefined;
      level.var_3B5A[level.var_985B[var_00]] = undefined;
      level.var_3B4F[level.var_985B[var_00]] = undefined;
      level.var_3B4D[level.var_985B[var_00]] = undefined;
    }
  } else {
    level.var_3B51["axis"] = undefined;
    level.var_3B5B["axis"] = undefined;
    level.var_3B4C["axis"] = undefined;
    level.var_3B4E["axis"] = undefined;
    level.var_3B52["axis"] = undefined;
    level.var_3B53["axis"] = undefined;
    level.var_3B56["axis"] = undefined;
    level.var_3B50["axis"] = undefined;
    level.var_3B54["axis"] = undefined;
    level.var_3B58["axis"] = undefined;
    level.var_3B57["axis"] = undefined;
    level.var_3B55["axis"] = undefined;
    level.var_3B59["axis"] = undefined;
    level.var_3B5A["axis"] = undefined;
    level.var_3B4F["axis"] = undefined;
    level.var_3B4D["axis"] = undefined;
    level.var_3B51["allies"] = undefined;
    level.var_3B5B["allies"] = undefined;
    level.var_3B4C["allies"] = undefined;
    level.var_3B4E["allies"] = undefined;
    level.var_3B52["allies"] = undefined;
    level.var_3B53["allies"] = undefined;
    level.var_3B56["allies"] = undefined;
    level.var_3B50["allies"] = undefined;
    level.var_3B54["allies"] = undefined;
    level.var_3B58["allies"] = undefined;
    level.var_3B57["allies"] = undefined;
    level.var_3B55["allies"] = undefined;
    level.var_3B59["allies"] = undefined;
    level.var_3B5A["allies"] = undefined;
    level.var_3B4F["allies"] = undefined;
    level.var_3B4D["allies"] = undefined;
  }

  level.var_3B51["none"] = undefined;
  level.var_3B5B["none"] = undefined;
  level.var_3B4C["none"] = undefined;
  level.var_3B4E["none"] = undefined;
  level.var_3B52["none"] = undefined;
  level.var_3B53["none"] = undefined;
  level.var_3B56["none"] = undefined;
  level.var_3B50["none"] = undefined;
  level.var_3B54["none"] = undefined;
  level.var_3B58["none"] = undefined;
  level.var_3B57["none"] = undefined;
  level.var_3B55["none"] = undefined;
  level.var_3B59["none"] = undefined;
  level.var_3B5A["none"] = undefined;
  level.var_3B4F["none"] = undefined;
  level.var_3B4D["none"] = undefined;
  level.var_3B5C = undefined;
}

func_7B32(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(level.var_984D && isDefined(param_02.var_01A7)) {
    level.var_3B51[param_02.var_01A7] = param_00;
    level.var_3B5B[param_02.var_01A7] = param_01;
    level.var_3B4C[param_02.var_01A7] = param_02;
    level.var_3B4E[param_02.var_01A7] = param_03;
    level.var_3B52[param_02.var_01A7] = param_04;
    level.var_3B53[param_02.var_01A7] = param_05;
    level.var_3B56[param_02.var_01A7] = param_06;
    level.var_3B50[param_02.var_01A7] = param_07;
    level.var_3B54[param_02.var_01A7] = param_08;
    level.var_3B58[param_02.var_01A7] = maps\mp\_utility::func_467B();
    level.var_3B57[param_02.var_01A7] = maps\mp\_utility::func_467B();
    level.var_3B55[param_02.var_01A7] = param_09;
    level.var_3B59[param_02.var_01A7] = param_0A;
    level.var_3B5A[param_02.var_01A7] = isDefined(param_0B) && param_0B;
    level.var_3B4F[param_02.var_01A7] = param_01.var_1193;
    level.var_3B4D[param_02.var_01A7] = param_01.var_1189;
  }

  level.var_3B51["none"] = param_00;
  level.var_3B5B["none"] = param_01;
  level.var_3B4C["none"] = param_02;
  level.var_3B4E["none"] = param_03;
  level.var_3B52["none"] = param_04;
  level.var_3B53["none"] = param_05;
  level.var_3B56["none"] = param_06;
  level.var_3B50["none"] = param_07;
  level.var_3B54["none"] = param_08;
  level.var_3B58["none"] = maps\mp\_utility::func_467B();
  level.var_3B57["none"] = maps\mp\_utility::func_467B();
  level.var_3B57["none"] = maps\mp\_utility::func_467B();
  level.var_3B55["none"] = param_09;
  level.var_3B59["none"] = param_0A;
  level.var_3B5A["none"] = isDefined(param_0B) && param_0B;
  level.var_3B4F["none"] = param_01.var_1193;
  level.var_3B4D["none"] = param_01.var_1189;
}

func_9456() {
  if(isai(self)) {
    return;
  }

  if(func_8B8C()) {
    var_00 = "none";
    if(isDefined(level.var_3B5C)) {
      var_00 = level.var_3B5C;
    }

    var_01 = level.var_3B5B[var_00];
    var_02 = level.var_3B4C[var_00];
    var_03 = level.var_3B57[var_00];
    var_04 = level.var_3B58[var_00];
    if(!func_3B5E(var_01, var_02, var_03, var_04)) {
      return;
    }

    var_05 = level.var_3B53[var_00];
    var_06 = level.var_3B56[var_00];
    var_07 = level.var_3B5A[var_00];
    var_08 = level.var_3B54[var_00];
    var_09 = level.var_3B50[var_00];
    var_0A = gettime() - var_01.var_2AB8 / 1000;
    var_0B = var_0A + var_09;
    var_0C = maps\mp\gametypes\_killcam::func_5A33(var_05, var_06, var_0B, 0, func_44D9(), var_07, 1);
    var_0D = var_0C + var_0B + var_08 / 1000;
    self method_8533(1);
    function_03B7(1);
    thread maps\mp\gametypes\_killcam::func_7681(level.var_3B4C[var_00], level.var_3B4C[var_00], var_0D, "none");
    return;
  }

  if(isDefined(level.var_74CA) && level.var_74CA >= 0) {
    self method_8533(1);
    function_03B7(1);
    var_0E = maps\mp\gametypes\_playerlogic::func_4006();
    var_0F = level.playofthegameentity;
    var_0F.var_0189 = 1;
    self.var_9459 = self method_8423(var_0F, 0, var_0E);
    var_0F.var_0189 = 0;
  }
}

func_36B7() {
  func_7D67();
  level.var_8C03 = 0;
  level notify("final_killcam_done");
}

func_7B3B(param_00, param_01) {
  level.var_74CA = param_00 getentitynumber();
  level.playofthegameentity = param_00;
  level.playofthegamerecordtime = maps\mp\_utility::func_44FA();
  level notify("cancel_previous_delayed_recording");
  level endon("cancel_previous_delayed_recording");
  level thread maps\mp\gametypes\_potg::func_2407(param_00);
  if(param_01 != 0) {
    wait(param_01);
  }

  function_0368(level.var_74CA);
}

func_329B() {
  if(isDefined(level.var_74CA)) {} else {}

  if(isDefined(level.var_74CA) && level.var_74CA >= 0) {
    level.var_8C03 = 1;
    foreach(var_01 in level.var_744A) {
      if(level.var_74CA == var_01 getentitynumber()) {
        func_A6C9(var_01);
        break;
      }
    }

    foreach(var_01 in level.var_744A) {
      var_01 maps\mp\_utility::func_7E50(0);
      var_01 setblurforplayer(0, 0);
      var_01.var_009F = -1;
      var_01.var_0189 = 1;
      var_01.var_00E2 = level.var_74CA;
      if(var_01 method_8436()) {
        var_01 maps\mp\gametypes\_broadcaster::resetforplayofthegamecam();
      }

      var_01 thread maps\mp\gametypes\_killcam::func_74C9();
    }

    wait(0.1);
    while(func_0F11()) {
      wait 0.05;
    }
  }
}

func_8B8C() {
  if(level.var_53C7) {
    return 0;
  }

  if(!maps\mp\gametypes\_potg::func_578D()) {
    return 1;
  }

  if(level.var_3FDC == "sd" || level.var_3FDC == "gun" || level.var_3FDC == "br" || level.var_3FDC == "dogfight") {
    return 1;
  }

  if(level.var_3FDC == "ball" && isDefined(level.ball_final_killcam) && level.ball_final_killcam == 1) {
    return 1;
  }

  if(level.var_74CA == -1) {
    return 1;
  }

  if(maps\mp\_utility::isprophuntgametype()) {
    return 1;
  }

  if(maps\mp\_utility::func_579B()) {
    return 1;
  }

  if(!isDefined(level.var_74CC) || level.var_74CC == 0) {
    return 1;
  }

  return 0;
}

func_318C() {
  level.var_74CA = -1;
  level.playofthegameentity = undefined;
  level waittill("round_end_finished");
  level.var_8C03 = 1;
  var_00 = "none";
  if(isDefined(level.var_3B5C)) {
    var_00 = level.var_3B5C;
  }

  var_01 = level.var_3B51[var_00];
  var_02 = level.var_3B5B[var_00];
  var_03 = level.var_3B4C[var_00];
  var_04 = level.var_3B4E[var_00];
  var_05 = level.var_3B52[var_00];
  var_06 = level.var_3B53[var_00];
  var_07 = level.var_3B5A[var_00];
  var_08 = level.var_3B56[var_00];
  var_09 = level.var_3B50[var_00];
  var_0A = level.var_3B54[var_00];
  var_0B = level.var_3B58[var_00];
  var_0C = level.var_3B57[var_00];
  var_0D = level.var_3B55[var_00];
  var_0E = level.var_3B59[var_00];
  var_0F = level.var_3B4F[var_00];
  var_10 = level.var_3B4D[var_00];
  if(func_8B8C() && !func_3B5E(var_02, var_03, var_0C, var_0B)) {
    func_36B7();
    return;
  }

  if(isDefined(var_03)) {
    var_03.var_3B4B = 1;
    var_03 maps\mp\gametypes\_missions::func_7750("ch_heroics_moviestar");
    if(level.var_3FDC == "conf" && isDefined(level.var_3B4C[var_03.var_01A7]) && level.var_3B4C[var_03.var_01A7] == var_03) {
      var_03 maps\mp\gametypes\_missions::func_7750("ch_theedge");
      if(isDefined(var_03.var_62A1["revenge"])) {
        var_03 maps\mp\gametypes\_missions::func_7750("ch_moneyshot");
      }

      if(isDefined(var_03.var_5133) && var_03.var_5133) {
        var_03 maps\mp\gametypes\_missions::func_7750("ch_lastresort");
      }

      if(isDefined(var_02) && isDefined(var_02.var_3961) && isDefined(var_02.var_3961["stickKill"]) && var_02.var_3961["stickKill"]) {
        var_03 maps\mp\gametypes\_missions::func_7750("ch_stickman");
      }

      if(isDefined(var_02.var_1189) && isDefined(var_02.var_1189[var_03.var_48CA]) && isDefined(var_02.var_1189[var_03.var_48CA].var_8CD7) && isDefined(var_02.var_1189[var_03.var_48CA].var_01D0) && issubstr(var_02.var_1189[var_03.var_48CA].var_8CD7, "MOD_MELEE") && issubstr(var_02.var_1189[var_03.var_48CA].var_01D0, "riotshield_mp")) {
        var_03 maps\mp\gametypes\_missions::func_7750("ch_owned");
      }

      switch (level.var_3B56[var_03.var_01A7]) {
        case "artillery_mp":
          var_03 maps\mp\gametypes\_missions::func_7750("ch_finishingtouch");
          break;

        case "stealth_bomb_mp":
          var_03 maps\mp\gametypes\_missions::func_7750("ch_technokiller");
          break;

        case "sentry_minigun_mp":
          var_03 maps\mp\gametypes\_missions::func_7750("ch_absentee");
          break;

        case "ac130_25mm_mp":
        case "ac130_40mm_mp":
        case "ac130_105mm_mp":
          var_03 maps\mp\gametypes\_missions::func_7750("ch_deathfromabove");
          break;

        case "remotemissile_projectile_mp":
          var_03 maps\mp\gametypes\_missions::func_7750("ch_dronekiller");
          break;

        default:
          break;
      }
    }
  }

  func_A6C9(var_03);
  if(func_8B8C()) {
    var_11 = gettime() - var_02.var_2AB8 / 1000;
    foreach(var_13 in level.var_744A) {
      var_13 maps\mp\_utility::func_7E50(0);
      if(var_13 method_8436()) {
        var_13 maps\mp\gametypes\_broadcaster::resetforplayofthegamecam();
      }

      var_13 setblurforplayer(0, 0);
      if(isDefined(var_03) && isDefined(var_03.var_5BE2)) {
        var_14 = gettime() - var_03.var_5BE2 / 1000;
      } else {
        var_14 = 0;
      }

      var_13 maps\mp\gametypes\_damage::func_A106(var_0F, var_10);
      var_13 thread maps\mp\gametypes\_killcam::func_5A29(var_03, var_04, var_05, var_06, var_08, var_11 + var_09, var_0A, 0, func_44D9(), var_03, var_02, var_0D, var_0E, var_14, var_07);
    }
  }

  wait(0.1);
  if(!func_8B8C()) {
    func_329B();
  }

  while(func_0F11()) {
    wait 0.05;
  }

  func_36B7();
}