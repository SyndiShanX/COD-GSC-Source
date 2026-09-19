/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\752.gsc
**************************************/

_id_7FE7() {
  level._id_06B2 = spawnStruct();
  level._id_06B2._id_061A = [];
  level._id_06B2._id_0720 = [];
  level._id_06B2._id_05E5 = [];
  level._id_06B2._id_05F8 = "entity";
  level._id_06B2._id_05F7 = 0.05;
  level._id_06B2._id_0622 = spawn("script_origin", (0, 0, 0));
}

rv_audio_update_entnotify_origin(var_0) {
  level._id_06B2._id_0622.origin = var_0;
}

_id_800B(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_06B2._id_05F8;
  var_7 = _id_06C7(var_6, var_0, var_1, var_2, var_3, var_4, var_5);
  return var_7;
}

_id_800A(var_0, var_1, var_2, var_3) {
  var_4 = level._id_06B2._id_05F8;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = var_1;
  var_8 = _id_06C7(var_4, var_0, var_5, var_6, var_7, var_2, var_3);
  return var_8;
}

enableammogeneration(var_0, var_1, var_2) {
  if(isDefined(var_0) == 0) {
    return;
  }
  if(_isarray(var_0) == 1) {
    foreach(var_4 in var_0) {
      if(_isremovedentity(var_4) == 0)
        var_4 thread _id_06C9(var_4, var_1);
    }
  } else
    var_0 thread _id_06C9(var_0, var_1);
}

disableammogeneration(var_0, var_1, var_2, var_3) {
  var_1 thread _id_06CA(var_0, var_1, var_2, var_3);
}

threatdetectedtoplayer(var_0) {
  return _id_02EF::_id_8AAB(var_0);
}

disableplayeruse(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_02EF::_id_8AAF(var_1, var_2, var_3, var_4);
}

showtoplayer(var_0) {
  return _id_02EF::_id_8AAA(var_0);
}

enableplayeruse(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_02EF::_id_8AAC(var_1, var_2, var_3, var_4);
}

_id_8013(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 = _id_8015(var_0);
  var_7 = _id_06C7(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  return var_7;
}

_id_8012(var_0, var_1, var_2, var_3, var_4) {
  var_0 = _id_8015(var_0);
  var_5 = undefined;
  var_6 = undefined;
  var_7 = var_2;
  var_8 = _id_06C7(var_0, var_1, var_5, var_6, var_7, var_3, var_4);
  return var_8;
}

_id_8010() {
  return "entity";
}

makeportableradar() {
  return level._id_06B2._id_05F8;
}

_id_8014(var_0) {
  var_1 = undefined;

  if(isDefined(var_0) == 0)
    var_0 = "entity";

  level._id_06B2._id_05F8 = _id_8015(var_0);
}

_id_8006(var_0) {
  if(isDefined(var_0._id_8F4E) == 1)
    return var_0._id_8F4E;

  return "";
}

_id_8015(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 0:
    case "ent":
    case "e":
    case "entity":
      var_1 = "entity";
      break;
    case 1:
    case "sound_entity":
    case "soundentity":
    case "sndent":
    case "snd":
    case "sndentity":
    case "s":
      var_1 = "sndentity";
      break;
    case 2:
    case "client_sound":
    case "clientsound":
    case "clisnd":
    case "cs":
    case "clientsnd":
    case "client":
    case "c":
      var_1 = "clientsnd";
      break;
    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

_id_06B5(var_0, var_1) {}

_id_06B4(var_0, var_1) {}

_id_06B3() {
  var_0 = self._id_8F4E;
  self waittill("death");
}

_id_06BE(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) == 1) {
    var_3 = var_2 _id_02EF::_id_46BD(var_3);
    var_4 = (0, 0, 0);
    var_5 = (0, 0, 0);

    if(isDefined(var_1) == 1)
      var_4 = var_1;

    var_0 linktosynchronizedparent(var_2, var_3, var_4, var_5);
  }
}

_id_06BC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  var_7 = undefined;
  var_8 = 0.0;

  if(isDefined(var_2) == 1 && isDefined(var_3) == 1 && isDefined(var_1) == 1) {
    var_7 = var_2 gettagorigin(var_3);
    var_7 = var_7 + var_1;
  } else if(isDefined(var_2) == 1 && isDefined(var_3) == 1)
    var_7 = var_2 gettagorigin(var_3);
  else if(isDefined(var_2) == 1)
    var_7 = var_2.origin;
  else if(isDefined(var_2) == 0 && isDefined(var_1) == 0)
    var_7 = (-32768, -32768, -32768);
  else
    var_7 = var_1;

  var_6 = spawn("script_origin", var_7);
  _id_06BE(var_6, var_1, var_2, var_3);
  var_6._id_8F45 = var_2;
  var_6._id_8F4E = "entity";
  return var_6;
}

_id_06BD(var_0) {
  if(isDefined(var_0) == 1 && _isremovedentity(var_0) == 0)
    var_0 delete();
  else {}
}

_id_06BF(var_0, var_1, var_2, var_3) {
  var_4 = var_0;
  var_5 = undefined;

  if(isDefined(var_0._id_8F45) == 1) {
    waittillframeend;

    if(_isremovedentity(var_0) == 1)
      return;
  }

  var_5 = threatdetectedtoplayer(var_4);

  if(isDefined(var_2) == 0 && isDefined(var_5) == 1)
    var_2 = var_5;

  if(_func_35C(var_1) == 1)
    var_4 playloopsound(var_1, var_2);
  else {
    var_6 = "sounddone";
    var_4 playSound(var_1, var_6, undefined, undefined, undefined, var_2);
    var_7 = _getsndaliasvalue(var_1, "secondaryaliasname");

    if(isDefined(var_7) == 1 && var_7 != "")
      var_4 thread _id_06C1(var_1);
    else
      var_4 thread _id_06C2(var_6);
  }

  var_4._id_8F3E = var_1;
}

_id_06C0(var_0) {
  var_0 endon("death");
  var_1 = var_0;

  if(isDefined(var_1) == 1 && _isremovedentity(var_1) == 0) {
    var_1 stopsounds();
    waitframe();
    _id_06BD(var_1);
  } else {}
}

_id_06C1(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_2 = _lookupsoundlength(var_0);
  var_3 = _id_02EF::_id_468E(var_0, "pitch_min");

  if(isDefined(var_3) == 1)
    var_2 = var_2 * (1.0 / var_3);

  wait(var_2);
  _id_06BD(var_1);
}

_id_06C2(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 waittill(var_0);
  _id_06BD(var_1);
}

_id_06C3(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 1;
  var_7 = 0.0;

  if(isDefined(var_4) == 0)
    var_4 = 1.0;

  if(isDefined(var_5) == 0)
    var_5 = _id_02EF::_id_4625();

  var_8 = _func_360(var_0, var_1, var_6, var_7, var_4, var_2, var_3, var_5);
  var_8._id_8F45 = var_2;
  var_8._id_8F4E = "sndentity";
  return var_8;
}

_id_06C4(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) == 0)
    var_3 = _id_02EF::_id_4625();

  var_0 _meth_863E(0.0, var_2, var_3);
  var_0._id_8F3E = var_1;
}

_id_06C5(var_0) {
  var_1 = var_0;

  if(isDefined(var_1) == 1) {
    var_2 = 0.0;
    var_1 _meth_863F(var_2);
  }
}

_id_06B9(var_0, var_1) {
  var_2 = var_1._id_8F4E;
  var_3 = var_1._id_4983;
  var_4 = "_rvsnd_clientsnd_notify_" + var_3;
  self endon("death");
  self endon(var_4);
  self waittill(var_0);
  var_1 notify("death");
}

_id_06B8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1) == 0)
    var_1 = (0, 0, 0);

  if(isDefined(var_3) == 1) {
    var_3 = var_2 _id_02EF::_id_46BD(var_3);
    var_6 = var_2 gettagorigin(var_3);

    if(isDefined(var_6) == 1)
      var_1 = var_6 - var_2.origin;
  }

  var_7 = spawnStruct();
  var_7._id_8F49 = var_1;
  var_7._id_8F45 = var_2;
  var_7._id_8F44 = var_3;
  return var_7;
}

_id_06BA(var_0, var_1, var_2, var_3) {
  var_4 = var_0._id_8F49;
  var_5 = var_0._id_8F45;
  var_6 = var_0._id_8F44;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(isDefined(var_4) == 1)
    var_7 = "world";

  if(isDefined(var_5) == 1) {
    var_7 = "body";
    var_8 = "soft_oriented";
  }

  if(isDefined(var_3) == 0)
    var_3 = _id_02EF::_id_4625();

  var_0 = spawnStruct();
  var_0._id_4983 = _func_351(var_1, var_5, var_4, var_7, var_6, var_8, var_9, var_10, var_2, var_11, var_3);

  if(isDefined(var_0._id_4983) == 0) {
    var_0 = undefined;
    return undefined;
  }

  var_0._id_8F3E = var_1;
  var_0._id_8F45 = var_5;
  var_0._id_8F4E = "clientsnd";
  var_0._id_8F49 = var_4;
  var_0._id_8F44 = var_6;
  return var_0;
}

_id_06BB(var_0) {
  if(isDefined(var_0) == 1 && isDefined(var_0._id_4983) == 1) {
    var_1 = 0.0;
    _func_352(var_0._id_4983, var_1);
    var_0._id_4983 = undefined;
  }
}

_id_06C7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  var_8 = var_4;
  var_9 = undefined;

  if(_soundexists(var_1) == 0)
    return undefined;

  if(isDefined(level._id_06B2._id_05F8) == 0)
    var_0 = level._id_06B2._id_05F8;

  if(isDefined(var_5) == 0) {
    if(_func_35C(var_1) == 1)
      var_5 = level._id_06B2._id_05F7;
    else
      var_5 = 0.0;
  }

  if(isDefined(var_5) == 1 && var_5 > 0.0)
    var_9 = 0.0;

  switch (var_0) {
    case "entity":
    default:
      var_7 = _id_06BC(var_1, var_8, var_2, var_3, var_9, var_6);
      var_7 thread _id_06BF(var_7, var_1, var_9, var_6);
      break;
    case "sndentity":
      var_7 = _id_06C3(var_1, var_8, var_2, var_3, var_9, var_6);
      var_7 thread _id_06C4(var_7, var_1, var_9, var_6);
      break;
    case "clientsnd":
      var_7 = _id_06B8(var_1, var_8, var_2, var_3, var_9, var_6);
      var_7 = _id_06BA(var_7, var_1, var_9, var_6);
      break;
  }

  if(var_5 > 0.0) {
    var_11 = 0.0;

    if(var_0 == "entity" && isDefined(var_2) == 1)
      var_11 = 0.05;

    var_7 thread _id_06C8(var_7, var_5, var_11);
  }

  return var_7;
}

_id_06C9(var_0, var_1) {
  var_0 endon("death");
  var_2 = var_0._id_8F4E;
  var_3 = var_0._id_8F3E;

  if(isDefined(var_3) == 1 && _func_35C(var_0._id_8F3E) == 1 && isDefined(var_1) == 0)
    var_1 = level._id_06B2._id_05F7;

  if(isDefined(var_1) == 1) {
    disableplayeruse(var_0, 0.0, var_1);
    wait(var_1 + 0.05);

    if(_isremovedentity(var_0) == 1)
      return;
  } else
    var_1 = 0;

  switch (var_2) {
    case "entity":
    default:
      _id_06C0(var_0);
      break;
    case "sndentity":
      _id_06C5(var_0);
      break;
    case "clientsnd":
      _id_06BB(var_0);
      break;
  }
}

_id_06CA(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_1 common_scripts\utility::_id_A70A("death", "deleted");
  _id_06C9(var_0, var_2);
}

_id_06C8(var_0, var_1, var_2) {
  disableplayeruse(var_0, 0.0, 0.0);

  if(isDefined(var_2) == 1 && var_2 > 0.0) {
    var_0 endon("rvSndAbortInitialFadeIn");
    wait(var_2);
    waittillframeend;
  }

  if(isDefined(var_0) && !_isremovedentity(var_0))
    disableplayeruse(var_0, 1.0, var_1);
}

_id_8009(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(var_2) == 0)
    var_2 = 0.0;

  if(isDefined(var_3) == 0)
    var_3 = 0.0;

  if(isDefined(var_4._id_8F4E) == 0 && _id_02EF::_id_56DB(var_4) == 1) {
    var_4 moveto(var_0, var_1, var_2, var_3);
    return;
  }

  switch (var_4._id_8F4E) {
    case "entity":
    default:
      var_4 moveto(var_0, var_1, var_2, var_3);
      break;
    case "sndentity":
      if(isDefined(var_4._id_8F45) == 1)
        var_4._id_8F45 moveto(var_0, var_1, var_2, var_3);
      else
        var_4 moveto(var_0, var_1, var_2, var_3);

      break;
    case "clientsnd":
      break;
  }
}

clearthreatdetected(var_0) {
  if(isDefined(var_0) == 1 && isDefined(var_0._id_8F4E) == 1) {
    switch (var_0._id_8F4E) {
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