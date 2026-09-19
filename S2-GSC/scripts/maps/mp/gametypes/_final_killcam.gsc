/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_final_killcam.gsc
********************************************************/

_id_9454(var_0) {
  level endon("stream_end");

  foreach(var_2 in level.players) {
    if(_func_0C1(var_2)) {
      continue;
    }
    if(isDefined(var_2._id_9459) && var_2._id_9459.size > 0) {
      while(isPlayer(var_2) && isPlayer(var_0) && !var_2 _meth_842C(var_0, var_2._id_9459[0]))
        waitframe();
    }
  }

  level notify("stream_end");
}

_id_7D67() {
  foreach(var_1 in level.players) {
    if(!_func_0C1(var_1))
      var_1 _meth_8533(0);
  }

  _func_3B7(0);
}

_id_9458(var_0) {
  level endon("stream_end");
  wait(var_0);
  level notify("stream_end");
}

_id_A6C9(var_0) {
  thread _id_9458(5.0);
  _id_9454(var_0);
}

_id_44D9() {
  return 15;
}

_id_0F11() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_5A29))
      return 1;
  }

  return 0;
}

_id_3B5E(var_0, var_1, var_2, var_3) {
  var_4 = isDefined(var_0) && isDefined(var_1) && !maps\mp\_utility::_id_761E() && !maps\mp\_utility::_id_579B() && (isDefined(level.teambased) && !level.teambased || isDefined(var_1.team) && isDefined(var_0.team) && var_1.team != var_0.team || level.gametype == "ball" && isDefined(level._id_3B59) && isDefined(level._id_3B59[var_1.team]) && level._id_3B59[var_1.team] == "score");

  if(var_4) {
    var_5 = _id_44D9();
    var_6 = var_2 - var_3;

    if(var_6 <= var_5)
      return 1;
  }

  return 0;
}

_id_52B8() {
  level._id_3B51 = [];
  level._id_3B5B = [];
  level._id_3B4C = [];
  level._id_3B4E = [];
  level._id_3B52 = [];
  level._id_3B53 = [];
  level._id_3B56 = [];
  level._id_3B50 = [];
  level._id_3B54 = [];
  level._id_3B58 = [];
  level._id_3B57 = [];
  level._id_3B55 = [];
  level._id_3B59 = [];
  level._id_3B5A = [];
  level._id_3B4F = [];
  level._id_3B4D = [];

  if(level._id_6520) {
    foreach(var_1 in level._id_985B) {
      level._id_3B51[var_1] = undefined;
      level._id_3B5B[var_1] = undefined;
      level._id_3B4C[var_1] = undefined;
      level._id_3B4E[var_1] = undefined;
      level._id_3B52[var_1] = undefined;
      level._id_3B53[var_1] = undefined;
      level._id_3B56[var_1] = undefined;
      level._id_3B50[var_1] = undefined;
      level._id_3B54[var_1] = undefined;
      level._id_3B58[var_1] = undefined;
      level._id_3B57[var_1] = undefined;
      level._id_3B55[var_1] = undefined;
      level._id_3B59[var_1] = undefined;
      level._id_3B5A[var_1] = undefined;
      level._id_3B4F[var_1] = undefined;
      level._id_3B4D[var_1] = undefined;
    }
  } else {
    level._id_3B51["axis"] = undefined;
    level._id_3B5B["axis"] = undefined;
    level._id_3B4C["axis"] = undefined;
    level._id_3B4E["axis"] = undefined;
    level._id_3B52["axis"] = undefined;
    level._id_3B53["axis"] = undefined;
    level._id_3B56["axis"] = undefined;
    level._id_3B50["axis"] = undefined;
    level._id_3B54["axis"] = undefined;
    level._id_3B58["axis"] = undefined;
    level._id_3B57["axis"] = undefined;
    level._id_3B55["axis"] = undefined;
    level._id_3B59["axis"] = undefined;
    level._id_3B5A["axis"] = undefined;
    level._id_3B4F["axis"] = undefined;
    level._id_3B4D["axis"] = undefined;
    level._id_3B51["allies"] = undefined;
    level._id_3B5B["allies"] = undefined;
    level._id_3B4C["allies"] = undefined;
    level._id_3B4E["allies"] = undefined;
    level._id_3B52["allies"] = undefined;
    level._id_3B53["allies"] = undefined;
    level._id_3B56["allies"] = undefined;
    level._id_3B50["allies"] = undefined;
    level._id_3B54["allies"] = undefined;
    level._id_3B58["allies"] = undefined;
    level._id_3B57["allies"] = undefined;
    level._id_3B55["allies"] = undefined;
    level._id_3B59["allies"] = undefined;
    level._id_3B5A["allies"] = undefined;
    level._id_3B4F["allies"] = undefined;
    level._id_3B4D["allies"] = undefined;
  }

  level._id_3B51["none"] = undefined;
  level._id_3B5B["none"] = undefined;
  level._id_3B4C["none"] = undefined;
  level._id_3B4E["none"] = undefined;
  level._id_3B52["none"] = undefined;
  level._id_3B53["none"] = undefined;
  level._id_3B56["none"] = undefined;
  level._id_3B50["none"] = undefined;
  level._id_3B54["none"] = undefined;
  level._id_3B58["none"] = undefined;
  level._id_3B57["none"] = undefined;
  level._id_3B55["none"] = undefined;
  level._id_3B59["none"] = undefined;
  level._id_3B5A["none"] = undefined;
  level._id_3B4F["none"] = undefined;
  level._id_3B4D["none"] = undefined;
  level._id_3B5C = undefined;
}

_id_3801() {
  if(level._id_6520) {
    for(var_0 = 0; var_0 < level._id_985B.size; var_0++) {
      level._id_3B51[level._id_985B[var_0]] = undefined;
      level._id_3B5B[level._id_985B[var_0]] = undefined;
      level._id_3B4C[level._id_985B[var_0]] = undefined;
      level._id_3B4E[level._id_985B[var_0]] = undefined;
      level._id_3B52[level._id_985B[var_0]] = undefined;
      level._id_3B53[level._id_985B[var_0]] = undefined;
      level._id_3B56[level._id_985B[var_0]] = undefined;
      level._id_3B50[level._id_985B[var_0]] = undefined;
      level._id_3B54[level._id_985B[var_0]] = undefined;
      level._id_3B58[level._id_985B[var_0]] = undefined;
      level._id_3B57[level._id_985B[var_0]] = undefined;
      level._id_3B55[level._id_985B[var_0]] = undefined;
      level._id_3B59[level._id_985B[var_0]] = undefined;
      level._id_3B5A[level._id_985B[var_0]] = undefined;
      level._id_3B4F[level._id_985B[var_0]] = undefined;
      level._id_3B4D[level._id_985B[var_0]] = undefined;
    }
  } else {
    level._id_3B51["axis"] = undefined;
    level._id_3B5B["axis"] = undefined;
    level._id_3B4C["axis"] = undefined;
    level._id_3B4E["axis"] = undefined;
    level._id_3B52["axis"] = undefined;
    level._id_3B53["axis"] = undefined;
    level._id_3B56["axis"] = undefined;
    level._id_3B50["axis"] = undefined;
    level._id_3B54["axis"] = undefined;
    level._id_3B58["axis"] = undefined;
    level._id_3B57["axis"] = undefined;
    level._id_3B55["axis"] = undefined;
    level._id_3B59["axis"] = undefined;
    level._id_3B5A["axis"] = undefined;
    level._id_3B4F["axis"] = undefined;
    level._id_3B4D["axis"] = undefined;
    level._id_3B51["allies"] = undefined;
    level._id_3B5B["allies"] = undefined;
    level._id_3B4C["allies"] = undefined;
    level._id_3B4E["allies"] = undefined;
    level._id_3B52["allies"] = undefined;
    level._id_3B53["allies"] = undefined;
    level._id_3B56["allies"] = undefined;
    level._id_3B50["allies"] = undefined;
    level._id_3B54["allies"] = undefined;
    level._id_3B58["allies"] = undefined;
    level._id_3B57["allies"] = undefined;
    level._id_3B55["allies"] = undefined;
    level._id_3B59["allies"] = undefined;
    level._id_3B5A["allies"] = undefined;
    level._id_3B4F["allies"] = undefined;
    level._id_3B4D["allies"] = undefined;
  }

  level._id_3B51["none"] = undefined;
  level._id_3B5B["none"] = undefined;
  level._id_3B4C["none"] = undefined;
  level._id_3B4E["none"] = undefined;
  level._id_3B52["none"] = undefined;
  level._id_3B53["none"] = undefined;
  level._id_3B56["none"] = undefined;
  level._id_3B50["none"] = undefined;
  level._id_3B54["none"] = undefined;
  level._id_3B58["none"] = undefined;
  level._id_3B57["none"] = undefined;
  level._id_3B55["none"] = undefined;
  level._id_3B59["none"] = undefined;
  level._id_3B5A["none"] = undefined;
  level._id_3B4F["none"] = undefined;
  level._id_3B4D["none"] = undefined;
  level._id_3B5C = undefined;
}

_id_7B32(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(level.teambased && isDefined(var_2.team)) {
    level._id_3B51[var_2.team] = var_0;
    level._id_3B5B[var_2.team] = var_1;
    level._id_3B4C[var_2.team] = var_2;
    level._id_3B4E[var_2.team] = var_3;
    level._id_3B52[var_2.team] = var_4;
    level._id_3B53[var_2.team] = var_5;
    level._id_3B56[var_2.team] = var_6;
    level._id_3B50[var_2.team] = var_7;
    level._id_3B54[var_2.team] = var_8;
    level._id_3B58[var_2.team] = maps\mp\_utility::getsecondspassed();
    level._id_3B57[var_2.team] = maps\mp\_utility::getsecondspassed();
    level._id_3B55[var_2.team] = var_9;
    level._id_3B59[var_2.team] = var_10;
    level._id_3B5A[var_2.team] = isDefined(var_11) && var_11;
    level._id_3B4F[var_2.team] = var_1._id_1193;
    level._id_3B4D[var_2.team] = var_1._id_1189;
  }

  level._id_3B51["none"] = var_0;
  level._id_3B5B["none"] = var_1;
  level._id_3B4C["none"] = var_2;
  level._id_3B4E["none"] = var_3;
  level._id_3B52["none"] = var_4;
  level._id_3B53["none"] = var_5;
  level._id_3B56["none"] = var_6;
  level._id_3B50["none"] = var_7;
  level._id_3B54["none"] = var_8;
  level._id_3B58["none"] = maps\mp\_utility::getsecondspassed();
  level._id_3B57["none"] = maps\mp\_utility::getsecondspassed();
  level._id_3B57["none"] = maps\mp\_utility::getsecondspassed();
  level._id_3B55["none"] = var_9;
  level._id_3B59["none"] = var_10;
  level._id_3B5A["none"] = isDefined(var_11) && var_11;
  level._id_3B4F["none"] = var_1._id_1193;
  level._id_3B4D["none"] = var_1._id_1189;
}

_id_9456() {
  if(_func_0C1(self)) {
    return;
  }
  if(_id_8B8C()) {
    var_0 = "none";

    if(isDefined(level._id_3B5C))
      var_0 = level._id_3B5C;

    var_1 = level._id_3B5B[var_0];
    var_2 = level._id_3B4C[var_0];
    var_3 = level._id_3B57[var_0];
    var_4 = level._id_3B58[var_0];

    if(!_id_3B5E(var_1, var_2, var_3, var_4)) {
      return;
    }
    var_5 = level._id_3B53[var_0];
    var_6 = level._id_3B56[var_0];
    var_7 = level._id_3B5A[var_0];
    var_8 = level._id_3B54[var_0];
    var_9 = level._id_3B50[var_0];
    var_10 = (gettime() - var_1._id_2AB8) / 1000;
    var_11 = var_10 + var_9;
    var_12 = _id_04E6::_id_5A33(var_5, var_6, var_11, 0, _id_44D9(), var_7, 1);
    var_13 = var_12 + var_11 + var_8 / 1000;
    self _meth_8533(1);
    _func_3B7(1);
    thread _id_04E6::_id_7681(level._id_3B4C[var_0], level._id_3B4C[var_0], var_13, "none");
  } else if(isDefined(level._id_74CA) && level._id_74CA >= 0) {
    self _meth_8533(1);
    _func_3B7(1);
    var_14 = maps\mp\gametypes\_playerlogic::_id_4006();
    var_15 = level.playofthegameentity;
    var_15._id_0189 = 1;
    self._id_9459 = self _meth_8423(var_15, 0, var_14);
    var_15._id_0189 = 0;
  }
}

_id_36B7() {
  _id_7D67();
  level._id_8C03 = 0;
  level notify("final_killcam_done");
}

_id_7B3B(var_0, var_1) {
  level._id_74CA = var_0 getentitynumber();
  level.playofthegameentity = var_0;
  level.playofthegamerecordtime = maps\mp\_utility::_id_44FA();
  level notify("cancel_previous_delayed_recording");
  level endon("cancel_previous_delayed_recording");
  level thread _id_04F0::_id_2407(var_0);

  if(var_1 != 0)
    wait(var_1);

  _func_368(level._id_74CA);
}

_id_329B() {
  if(isDefined(level._id_74CA)) {} else {}

  if(isDefined(level._id_74CA) && level._id_74CA >= 0) {
    level._id_8C03 = 1;

    foreach(var_1 in level.players) {
      if(level._id_74CA == var_1 getentitynumber()) {
        _id_A6C9(var_1);
        break;
      }
    }

    foreach(var_1 in level.players) {
      var_1 maps\mp\_utility::_id_7E50(0);
      var_1 _meth_82DD(0, 0);
      var_1.forcespectatorclient = -1;
      var_1._id_0189 = 1;
      var_1._id_00E2 = level._id_74CA;

      if(var_1 _meth_8436())
        var_1 _id_04C3::resetforplayofthegamecam();

      var_1 thread _id_04E6::_id_74C9();
    }

    wait 0.1;

    while(_id_0F11())
      waitframe();
  }
}

_id_8B8C() {
  if(level._id_53C7)
    return 0;

  if(!_id_04F0::_id_578D())
    return 1;

  if(level.gametype == "sd" || level.gametype == "gun" || level.gametype == "br" || level.gametype == "dogfight")
    return 1;

  if(level.gametype == "ball" && isDefined(level.ball_final_killcam) && level.ball_final_killcam == 1)
    return 1;

  if(level._id_74CA == -1)
    return 1;

  if(maps\mp\_utility::isprophuntgametype())
    return 1;

  if(maps\mp\_utility::_id_579B())
    return 1;

  if(!isDefined(level._id_74CC) || level._id_74CC == 0)
    return 1;

  return 0;
}

_id_318C() {
  level._id_74CA = -1;
  level.playofthegameentity = undefined;
  level waittill("round_end_finished");
  level._id_8C03 = 1;
  var_0 = "none";

  if(isDefined(level._id_3B5C))
    var_0 = level._id_3B5C;

  var_1 = level._id_3B51[var_0];
  var_2 = level._id_3B5B[var_0];
  var_3 = level._id_3B4C[var_0];
  var_4 = level._id_3B4E[var_0];
  var_5 = level._id_3B52[var_0];
  var_6 = level._id_3B53[var_0];
  var_7 = level._id_3B5A[var_0];
  var_8 = level._id_3B56[var_0];
  var_9 = level._id_3B50[var_0];
  var_10 = level._id_3B54[var_0];
  var_11 = level._id_3B58[var_0];
  var_12 = level._id_3B57[var_0];
  var_13 = level._id_3B55[var_0];
  var_14 = level._id_3B59[var_0];
  var_15 = level._id_3B4F[var_0];
  var_16 = level._id_3B4D[var_0];

  if(_id_8B8C() && !_id_3B5E(var_2, var_3, var_12, var_11)) {
    _id_36B7();
    return;
  }

  if(isDefined(var_3)) {
    var_3._id_3B4B = 1;
    var_3 maps\mp\gametypes\_missions::processchallenge("ch_heroics_moviestar");

    if(level.gametype == "conf" && isDefined(level._id_3B4C[var_3.team]) && level._id_3B4C[var_3.team] == var_3) {
      var_3 maps\mp\gametypes\_missions::processchallenge("ch_theedge");

      if(isDefined(var_3._id_62A1["revenge"]))
        var_3 maps\mp\gametypes\_missions::processchallenge("ch_moneyshot");

      if(isDefined(var_3._id_5133) && var_3._id_5133)
        var_3 maps\mp\gametypes\_missions::processchallenge("ch_lastresort");

      if(isDefined(var_2) && isDefined(var_2._id_3961) && isDefined(var_2._id_3961["stickKill"]) && var_2._id_3961["stickKill"])
        var_3 maps\mp\gametypes\_missions::processchallenge("ch_stickman");

      if(isDefined(var_2._id_1189) && isDefined(var_2._id_1189[var_3.guid]) && isDefined(var_2._id_1189[var_3.guid]._id_8CD7) && isDefined(var_2._id_1189[var_3.guid]._id_01D0) && issubstr(var_2._id_1189[var_3.guid]._id_8CD7, "MOD_MELEE") && issubstr(var_2._id_1189[var_3.guid]._id_01D0, "riotshield_mp"))
        var_3 maps\mp\gametypes\_missions::processchallenge("ch_owned");

      switch (level._id_3B56[var_3.team]) {
        case "artillery_mp":
          var_3 maps\mp\gametypes\_missions::processchallenge("ch_finishingtouch");
          break;
        case "stealth_bomb_mp":
          var_3 maps\mp\gametypes\_missions::processchallenge("ch_technokiller");
          break;
        case "sentry_minigun_mp":
          var_3 maps\mp\gametypes\_missions::processchallenge("ch_absentee");
          break;
        case "ac130_25mm_mp":
        case "ac130_40mm_mp":
        case "ac130_105mm_mp":
          var_3 maps\mp\gametypes\_missions::processchallenge("ch_deathfromabove");
          break;
        case "remotemissile_projectile_mp":
          var_3 maps\mp\gametypes\_missions::processchallenge("ch_dronekiller");
          break;
        default:
          break;
      }
    }
  }

  _id_A6C9(var_3);

  if(_id_8B8C()) {
    var_17 = (gettime() - var_2._id_2AB8) / 1000;

    foreach(var_19 in level.players) {
      var_19 maps\mp\_utility::_id_7E50(0);

      if(var_19 _meth_8436())
        var_19 _id_04C3::resetforplayofthegamecam();

      var_19 _meth_82DD(0, 0);

      if(isDefined(var_3) && isDefined(var_3._id_5BE2))
        var_20 = (gettime() - var_3._id_5BE2) / 1000.0;
      else
        var_20 = 0;

      var_19 maps\mp\gametypes\_damage::_id_A106(var_15, var_16);
      var_19 thread _id_04E6::_id_5A29(var_3, var_4, var_5, var_6, var_8, var_17 + var_9, var_10, 0, _id_44D9(), var_3, var_2, var_13, var_14, var_20, var_7);
    }
  }

  wait 0.1;

  if(!_id_8B8C())
    _id_329B();

  while(_id_0F11())
    waitframe();

  _id_36B7();
}