/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\notetracks_common.gsc
*********************************************/

_id_6784(var_0) {
  if(isDefined(self) && _soundexists(var_0)) {
    self playSound(var_0);
  } else {}
}

_id_430B(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_1 = _tolower(var_1);

  if(var_0 == "playrumble_") {
    var_2 = 11;
  } else if(var_0 == "playrumbleloop_") {
    var_2 = 15;
  } else if(var_0 == "stoprumble_") {
    var_2 = 11;
  }

  if(_func_2C6(var_1, var_0)) {
    var_3 = getsubstr(var_1, var_2, 999);
  }

  return var_3;
}

_id_7BF0() {
  anim._id_67D0["dropgun"] = ::_id_67B5;
  anim._id_67D0["unlink"] = ::_id_67E6;
  anim._id_67D0["dismember_left_arm"] = ::_id_679D;
  anim._id_67D0["dismember_right_arm"] = ::_id_67A1;
  anim._id_67D0["dismember_left_leg"] = ::_id_679F;
  anim._id_67D0["dismember_right_leg"] = ::_id_67A3;
  anim._id_67D0["dismember_novfx_left_arm"] = ::_id_679E;
  anim._id_67D0["dismember_novfx_right_arm"] = ::_id_67A2;
  anim._id_67D0["dismember_novfx_left_leg"] = ::_id_67A0;
  anim._id_67D0["dismember_novfx_right_leg"] = ::_id_67A4;

  if(getdvarint("fov_notetracks_code_handling") == 0 && !_isdedicatedserver()) {
    anim._id_67D4["fov_"] = ::_id_67B2;
  }

  anim._id_67D4["earthquake_"] = ::_id_67A7;
  anim._id_67D4["fadetoblack_"] = ::_id_67AA;
  anim._id_67D4["fadefromblack_"] = ::_id_67A9;
  anim._id_67D4["fadetoandfromblack"] = ::notetrackfadetoandfromblack;
  anim._id_67D4["playrumble_"] = ::_id_67C6;
  anim._id_67D4["playrumbleloop_"] = ::_id_67C7;
  anim._id_67D4["stoprumble_"] = ::_id_67E2;
  anim._id_67D0["stopallrumbles"] = ::_id_67DF;
  anim._id_67D4["setmodel_"] = ::_id_67D6;
  anim._id_67D4["attachmodeltotag"] = ::_id_6793;
  anim._id_67D4["detachmodelfromtag"] = ::_id_679A;
  anim._id_67D4["dropmodelfromtag"] = ::_id_67A6;
  anim._id_67D4["delayedlaunchmodelfromtag"] = ::_id_6799;
  anim._id_67D4["dropgun"] = ::_id_67B5;
  anim._id_67D4["playfxontag"] = ::notetrackplayfxontag;
  anim._id_67D4["stopfxontag"] = ::notetrackstopfxontag;
  anim._id_67D4["killfxontag"] = ::notetrackkillfxontag;
  anim._id_67D4["playfxontagforclient"] = ::notetrackplayfxontagforclient;
  anim._id_67D4["stopfxontagforclient"] = ::notetrackstopfxontagforclient;
  anim._id_67D4["killfxontagforclient"] = ::notetrackkillfxontagforclient;
  anim._id_67D4["hidepart"] = ::notetrackhidepart;
  anim._id_67D4["showpart"] = ::notetrackshowpart;

  if(isDefined(level._id_0686)) {
    var_0 = getarraykeys(level._id_0686);

    foreach(var_2 in var_0) {
      anim._id_67D0[var_2] = ::_id_297E;
    }
  }
}

_id_A025() {
  wait 0.1;

  if(isDefined(self)) {
    self unlink();
  }
}

_id_67E6(var_0, var_1) {
  self unlink();
}

_id_67B5(var_0, var_1, var_2) {
  var_3 = self getlinkedchildren();

  foreach(var_5 in var_3) {
    var_5 unlink();
    var_5 _meth_8273();
  }
}

_id_679D(var_0, var_1, var_2) {
  _id_04EB::_id_4AAB("left_arm");

  if(isDefined(self._id_65D2) && isDefined(self._id_65D1)) {
    _playFXOnTag(common_scripts\utility::_id_44F5(self._id_65D2), self, self._id_65D1);
  }
}

_id_679E(var_0, var_1, var_2) {
  _id_04EB::_id_4AAB("left_arm");
}

_id_67A1(var_0, var_1, var_2) {
  _id_04EB::_id_4AAB("right_arm");

  if(isDefined(self._id_65D2) && isDefined(self._id_65D1)) {
    _playFXOnTag(common_scripts\utility::_id_44F5(self._id_65D2), self, self._id_65D1);
  }
}

_id_67A2(var_0, var_1, var_2) {
  _id_04EB::_id_4AAB("right_arm");
}

_id_679F(var_0, var_1, var_2) {
  _id_04EB::_id_4AAB("left_leg");

  if(isDefined(self._id_65D2) && isDefined(self._id_65D1)) {
    _playFXOnTag(common_scripts\utility::_id_44F5(self._id_65D2), self, self._id_65D1);
  }
}

_id_67A0(var_0, var_1, var_2) {
  _id_04EB::_id_4AAB("left_leg");
}

_id_67A3(var_0, var_1, var_2) {
  _id_04EB::_id_4AAB("right_leg");

  if(isDefined(self._id_65D2) && isDefined(self._id_65D1)) {
    _playFXOnTag(common_scripts\utility::_id_44F5(self._id_65D2), self, self._id_65D1);
  }
}

_id_67A4(var_0, var_1, var_2) {
  _id_04EB::_id_4AAB("right_leg");
}

_id_297E(var_0, var_1) {
  if(isDefined(self._id_00B5)) {
    var_2 = self._id_00B5;
  } else {
    var_2 = "dirt";
  }

  var_3 = undefined;

  if(isDefined(level._id_0686[var_0][var_2])) {
    var_3 = level._id_0686[var_0][var_2];
  } else if(isDefined(level._id_0686[var_0]["all"])) {
    var_3 = level._id_0686[var_0]["all"];
  }

  if(!isDefined(var_3)) {
    return;
  }
  if(_isai(self) && isDefined(var_3.fx)) {
    _playFXOnTag(var_3.fx, self, var_3._id_95A6);
  }

  if(!isDefined(var_3._id_8F3A) && !isDefined(var_3._id_8F3C)) {
    return;
  }
  var_4 = "" + var_3._id_8F3A + var_2 + var_3._id_8F3C;

  if(!_soundexists(var_4)) {
    var_4 = "" + var_3._id_8F3A + "default" + var_3._id_8F3C;
  }

  _id_6784(var_4);
}

_id_6793(var_0, var_1, var_2) {
  [var_4, var_5] = _id_421A("attachmodeltotag", var_0);

  if(!isDefined(var_4)) {
    return;
  }
  if(isDefined(var_5)) {
    if(self gettagindex(var_5) == -1) {
      return;
    }
    if(_id_55BA(var_4, var_5)) {
      return;
    } else {
      self attach(var_4, var_5);
    }
  } else
    self attach(var_4);

  thread _id_6794(var_0, var_1, var_4, var_5);
}

_id_6794(var_0, var_1, var_2, var_3) {
  if(_isai(self)) {
    for(;;) {
      if(!isDefined(self)) {
        return;
      }
      if(!isalive(self)) {
        if(1) {
          var_4 = 500.0;
          _id_A6E0(var_2, var_3, var_4);
        } else
          _id_801F(var_2, var_3);

        return;
      }

      waitframe();
    }
  } else {}
}

_id_801F(var_0, var_1) {
  if(isDefined(var_1) && _id_55BA(var_0, var_1)) {
    self detach(var_0, var_1);
    return 1;
  } else if(!isDefined(var_1) && _id_55BA(var_0, undefined)) {
    self detach(var_0);
    return 1;
  }

  return 0;
}

_id_55BA(var_0, var_1) {
  var_2 = self getattachsize();
  return 0;
}

_id_679A(var_0, var_1, var_2) {
  [var_4, var_5] = _id_421A("deachmodelfromtag", var_0);

  if(!isDefined(var_4)) {
    return;
  }
  if(isDefined(var_5)) {
    if(self gettagindex(var_5) == -1) {
      return;
    }
    _id_801F(var_4, var_5);
  } else
    _id_801F(var_4);
}

_id_6799(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  [var_6, var_7] = _id_421A("launchmodelfromtag", var_0);

  if(!isDefined(var_6)) {
    return;
  }
  if(isDefined(var_7)) {
    if(self gettagindex(var_7) == -1) {
      return;
    }
  }

  var_8 = 500.0;
  _id_A6E0(var_6, var_7, var_8);
}

_id_A6E0(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_1)) {
    var_3 = self gettagorigin(var_1);
    var_4 = self gettagangles(var_1);
  } else {
    var_3 = self.origin;
    var_4 = self.angles;
  }

  waitframe();

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1)) {
    var_5 = self gettagorigin(var_1);
    var_6 = self gettagangles(var_1);
  } else {
    var_5 = self.origin;
    var_6 = self.angles;
  }

  var_7 = var_3 - var_5;
  _id_6FA0(var_0, var_1, var_5, var_6, var_7, var_2);
}

_id_6FA0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(_id_801F(var_0, var_1)) {
    var_6 = vectorNormalize(var_4) * var_5;
    var_7 = spawn("script_model", var_2);
    var_7 setModel(var_0);
    var_7.angles = var_3;
    var_8 = var_7.origin;
    var_7 physicslaunchclient(var_8, var_6);
  }
}

_id_67A6(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  [var_6, var_7] = _id_421A("dropmodelfromtag", var_0);

  if(!isDefined(var_6)) {
    return;
  }
  if(isDefined(var_7)) {
    if(self gettagindex(var_7) == -1) {
      return;
    }
    var_3 = self gettagorigin(var_7);
    var_4 = self gettagangles(var_7);
  } else {
    var_3 = self.origin;
    var_4 = self.angles;
  }

  var_8 = (0, 0, -1);
  var_9 = 5;
  _id_6FA0(var_6, var_7, var_3, var_4, var_8, var_9);
}

_id_421A(var_0, var_1) {
  var_2 = strtok(var_1, "'");
  var_3 = var_2[1];
  var_4 = var_2[3];
  return [var_3, var_4];
}

notetrackplayFXOnTag(var_0, var_1, var_2) {
  return notetrackplayfxontag_internal("PlayFxOnTag", var_0, var_1, var_2);
}

notetrackstopFXOnTag(var_0, var_1, var_2) {
  return notetrackplayfxontag_internal("StopFxOnTag", var_0, var_1, var_2);
}

notetrackkillfxontag(var_0, var_1, var_2) {
  return notetrackplayfxontag_internal("KillFxOnTag", var_0, var_1, var_2);
}

notetrackplayfxontagforclient(var_0, var_1, var_2) {
  return notetrackplayfxontag_internal("PlayFxOnTagForClient", var_0, var_1, var_2);
}

notetrackstopfxontagforclient(var_0, var_1, var_2) {
  return notetrackplayfxontag_internal("StopFxOnTagForClient", var_0, var_1, var_2);
}

notetrackkillfxontagforclient(var_0, var_1, var_2) {
  return notetrackplayfxontag_internal("KillFxOnTagForClient", var_0, var_1, var_2);
}

notetrackplayfxontag_internal(var_0, var_1, var_2, var_3) {
  [var_5, var_6] = _id_421A("playfxontag", var_1);

  if(!isDefined(var_5)) {
    return;
  }
  if(!isDefined(level._effect[var_5])) {
    level._effect[var_5] = loadfx(var_5);

    if(!isDefined(level._effect[var_5])) {
      return;
    }
  }

  if(isDefined(var_6)) {
    if(self gettagindex(var_6) == -1) {
      return;
    }
  } else
    var_6 = "TAG_ORIGIN";

  var_7 = 1;

  if(var_0 == "PlayFxOnTag") {
    _playFXOnTag(level._effect[var_5], self, var_6);
  } else if(var_0 == "StopFxOnTag") {
    _stopFXOnTag(level._effect[var_5], self, var_6);
  } else if(var_0 == "KillFXOnTag") {
    _killfxontag(level._effect[var_5], self, var_6);
  } else if(var_0 == "PlayFXOnTagForClient") {
    foreach(var_9 in var_3) {
      _playfxontagforclients(level._effect[var_5], self, var_6, var_9);
    }
  } else if(var_0 == "StopFXOnTagForClient") {
    foreach(var_9 in var_3) {
      _stopfxontagforclient(level._effect[var_5], self, var_6, var_9);
    }
  } else if(var_0 == "KillFXOnTagForClient") {
    foreach(var_9 in var_3) {
      _killfxontagforclient(level._effect[var_5], self, var_6, var_9);
    }
  } else
    var_7 = 0;
}

get_model_tag_from_hideparts(var_0) {
  var_1 = strtok(var_0, "'");
  var_2 = var_1[3];
  var_3 = var_1[1];
  return [var_3, var_2];
}

notetrackhidepart(var_0, var_1, var_2) {
  return notetrackhideorshow_internal("hidepart", var_0, var_1, var_2);
}

notetrackshowpart(var_0, var_1, var_2) {
  return notetrackhideorshow_internal("showpart", var_0, var_1, var_2);
}

notetrackhideorshow_internal(var_0, var_1, var_2, var_3) {
  [var_5, var_6] = get_model_tag_from_hideparts(var_1);

  if(!isDefined(var_5)) {
    return;
  }
  if(isDefined(var_5)) {
    if(self gettagindex(var_5) == -1) {
      return;
    }
  }

  var_7 = 1;

  if(var_0 == "hidepart") {
    if(isDefined(var_6)) {
      self hidepart(var_5, var_6);
    } else {
      self hidepart(var_5);
    }
  } else if(var_0 == "showpart") {
    if(isDefined(var_6)) {
      self showpart(var_5, var_6);
    } else {
      self showpart(var_5);
    }
  } else
    var_7 = 0;
}

_id_67D6(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_9462(var_0, "_");

  if(!isDefined(var_3) || var_3 == -1) {
    return;
  }
  var_4 = getsubstr(var_0, var_3 + 1, 99999);

  if(!isDefined(var_4)) {
    return;
  }
  self setModel(var_4);
}

_id_67C6(var_0, var_1, var_2) {
  var_3 = _id_430B("playrumble_", var_0);

  if(isDefined(self)) {
    foreach(var_5 in var_2) {
      var_5 playRumbleOnEntity(var_3);
    }
  }
}

_id_67C7(var_0, var_1, var_2) {
  var_3 = _id_430B("playrumbleloop_", var_0);

  if(isDefined(self)) {
    foreach(var_5 in var_2) {
      var_5 playrumblelooponentity(var_3);
    }
  }
}

_id_67E2(var_0, var_1, var_2) {
  var_3 = _id_430B("stoprumble_", var_0);

  if(isDefined(self)) {
    foreach(var_5 in var_2) {
      var_5 stoprumble(var_3);
    }
  }
}

_id_67DF(var_0, var_1, var_2) {
  _stopallrumbles();
}

notetrackfadetoandfromblack(var_0, var_1, var_2) {
  thread _id_67AC(var_0, var_1, var_2);
}

_id_67AA(var_0, var_1, var_2) {
  thread _id_67AD(var_0, var_1, 1, var_2);
}

_id_67A9(var_0, var_1, var_2) {
  thread _id_67AD(var_0, var_1, 0, var_2);
}

_id_67AC(var_0, var_1, var_2) {
  var_3 = strtok(var_0, "_;");
  var_4 = var_3[1];
  var_5 = var_3[2];
  var_6 = var_3[3];
  var_7 = var_3[4];

  if(!isDefined(var_3[3])) {
    return;
  }
  var_4 = _float(var_4);
  var_5 = _float(var_5);
  var_6 = _float(var_6);

  if(isDefined(var_7) && var_7 == "mayaframes") {
    var_4 = var_4 / 30.0;
    var_5 = var_5 / 30.0;
    var_6 = var_6 / 30.0;
  }

  foreach(var_9 in var_2) {
    var_9 thread _id_30B4(var_4);
  }

  wait(var_4);
  wait(var_5);

  foreach(var_9 in var_2) {
    var_9 thread do_fade_from_black(var_6);
  }
}

_id_67AD(var_0, var_1, var_2, var_3) {
  var_4 = strtok(var_0, "_;");
  var_5 = var_4[1];
  var_6 = var_4[2];

  if(!isDefined(var_5)) {
    return;
  }
  var_7 = _float(var_5);

  if(isDefined(var_6) && var_6 == "mayaframes") {
    var_7 = var_7 / 30.0;
  }

  foreach(var_9 in var_3) {
    if(var_2) {
      var_9 thread _id_30B4(var_7);
      continue;
    }

    var_9 thread do_fade_from_black(var_7);
  }
}

notetrackresetfades() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1._id_6772)) {
      var_1 thread do_fade_from_black(0.0);
    }
  }
}

_id_30B4(var_0) {
  self notify("do_fade_from_black");
  self notify("do_fade_to_black");
  self endon("do_fade_to_black");

  if(!isDefined(self._id_6772)) {
    self._id_6772 = _newclienthudelem(self);
    self._id_6772 setshader("black", 640, 480);
    self._id_6772.sort = 1;
    self._id_6772._id_00C6 = "fullscreen";
    self._id_6772._id_01CA = "fullscreen";
    self._id_6772.foreground = 1;
  }

  if(var_0 > 0) {
    self._id_6772.alpha = 0.0;
    self._id_6772 fadeovertime(var_0);
  }

  self._id_6772.alpha = 1.0;
  wait(var_0);
}

do_fade_from_black(var_0) {
  self notify("do_fade_from_black");
  self notify("do_fade_to_black");
  self endon("do_fade_from_black");

  if(!isDefined(self._id_6772)) {
    self._id_6772 = _newclienthudelem(self);
    self._id_6772 setshader("black", 640, 480);
    self._id_6772.sort = 1;
    self._id_6772._id_00C6 = "fullscreen";
    self._id_6772._id_01CA = "fullscreen";
    self._id_6772.foreground = 1;
  }

  if(var_0 > 0) {
    self._id_6772.alpha = 1.0;
    self._id_6772 fadeovertime(var_0);
  }

  self._id_6772.alpha = 0.0;
  wait(var_0);
  self._id_6772 destroy();
}

_id_67B2(var_0, var_1, var_2) {
  var_3 = strtok(var_0, "_;");
  var_4 = var_3[1];
  var_5 = var_3[2];
  var_6 = var_3[3];

  if(!isDefined(var_4)) {
    return;
  }
  if(var_4 == "reset") {
    var_4 = 65;
  } else if(var_4 == "vehicle") {
    if(!isDefined(level._id_67D3)) {
      return;
    }
    var_4 = level._id_67D3;
  } else if(var_4 == "start")
    return;
  else if(var_4 == "end") {
    return;
  } else if(_id_561B(var_4)) {
    var_4 = int(var_4);
  } else {
    return;
  }

  if(isDefined(var_6)) {
    if(_id_561B(var_6)) {
      var_6 = _float(var_6);

      if(isDefined(var_5) && var_5 == "mayaframes") {
        var_6 = var_6 / 30.0;
      }
    } else if(isDefined(var_6))
      return;
  } else if(isDefined(var_5) && _id_561B(var_5))
    var_6 = _float(var_5);
  else {
    var_6 = 0;
  }

  foreach(var_8 in var_2) {
    var_9 = var_4 / 65;
    var_10 = int(var_6 * 10) / 10;
    var_8 lerpfovscale(var_9, var_10);
  }
}

_id_67A7(var_0, var_1, var_2) {
  var_3 = strtok(var_0, "_;");
  var_4 = var_3[1];
  var_5 = var_3[2];
  var_6 = var_3[3];

  if(!isDefined(var_4) || !isDefined(var_5) || !isDefined(var_6)) {
    return;
  }
  if(isDefined(var_2)) {
    foreach(var_8 in var_2) {
      _earthquake(var_4, var_5, self.origin, var_6, var_8);
    }
  } else
    _earthquake(var_4, var_5, self.origin, var_6);
}

_id_0EC0(var_0, var_1) {
  var_2 = _func_2C7(var_0, var_1, 1);

  if(var_2.size > 0) {
    return 1;
  }

  return 0;
}

_id_45B8(var_0) {
  foreach(var_3, var_2 in anim._id_67D4) {
    var_3 = _tolower(var_3);

    if(_func_2C6(var_0, var_3)) {
      return anim._id_67D4[var_3];
    }
  }

  var_4 = anim._id_67D0[_tolower(var_0)];
  return var_4;
}

_id_4AD9(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(!isDefined(var_5) || _isstring(var_5)) {
    var_6 = _id_4627(var_5);
  } else if(_isarray(var_5)) {
    var_6 = var_5;
  } else if(isPlayer(var_5)) {
    var_6 = [var_5];
  }

  var_7 = _id_45B8(var_0);

  if(isDefined(var_7)) {
    return thread[[var_7]](var_0, var_1, var_6);
  }

  switch (var_0) {
    case "undefined":
    case "end":
      return var_0;
    default:
      if(isDefined(var_2)) {
        return [[var_2]](var_0, var_3);
      }

      break;
  }
}

_id_3222(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(;;) {
    self waittill(var_1, var_6);

    if(!isDefined(var_6)) {
      var_6 = "undefined";
    }

    if(!isDefined(var_5)) {
      var_5 = "undefined";
    }

    var_7 = _id_4AD9(var_6, var_1, var_2, var_5, var_4, var_0);

    if(isDefined(var_7)) {
      return var_7;
    }
  }
}

_id_945F(var_0) {
  return "" + var_0;
}

_id_561B(var_0) {
  var_1 = _float(var_0);

  if(_func_2C6(var_0, " ")) {
    while(_func_2C6(var_0, " ")) {
      var_0 = getsubstr(var_0, 1, 9999);
    }
  }

  if(_func_2C6(var_0, "-.") || _func_2C6(var_0, ".")) {
    var_0 = "0" + _id_945F(var_0);
  }

  if(issubstr(var_0, ".")) {
    while(_isendstr(var_0, "0")) {
      var_0 = _func_2FF(var_0, "0");
    }
  } else
    var_0 = _id_945F(var_0);

  return _id_945F(var_1) == var_0;
}

_id_4627(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(var_1)) {
    if(var_0 == "all") {
      var_1 = 1;
    } else if(var_0 == "non_spectator") {
      var_1 = 0;
      var_0 = "all";
    } else
      var_1 = 0;
  } else if(var_0 == "non_spectator" && var_1) {}

  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(!var_1 && (var_4.sessionstate == "spectator" || var_4.team == "spectator")) {
      continue;
    }
    if(var_0 == "all" || var_4.team == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

switchtooffhand(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3) && isDefined(var_0)) {
    var_3 = "default_notifyname" + var_0;
  }

  thread fov_notetrack_team_setter(var_4);
  self scriptmodelplayanimdeltamotionfrompos(var_0, var_1, var_2, var_3);
  thread _id_3222(var_4, var_3);
}

fov_notetrack_team_setter(var_0) {
  if(getdvarint("fov_notetracks_code_handling") == 0 && !_isdedicatedserver()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  } else if(_isstring(var_0)) {
    var_1 = var_0;

    if(var_1 == "all") {
      return;
    }
    thread _id_8C21(var_1, 0);
  } else if(_isarray(var_0)) {
    self hide();

    foreach(var_3 in var_0) {
      var_4 = var_3.sessionstate == "spectator";

      if(!var_4) {
        self showtoplayer(var_3);
      }
    }
  } else if(isPlayer(var_0)) {
    self hide();
    self showtoplayer(var_0);
  }
}

_id_8C21(var_0, var_1) {
  self notify("showToTeam");
  self endon("showToTeam");
  self endon("clear");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self hide();

  foreach(var_3 in level.players) {
    var_4 = var_3.sessionstate == "spectator";

    if(var_3.team == var_0 && !var_4) {
      self showtoplayer(var_3);
    }

    if(var_1 && (var_3.team == "spectator" || var_4) && var_0 == "allies") {
      self showtoplayer(var_3);
    }
  }

  for(;;) {
    level common_scripts\utility::_id_A70A("joined_team", "joined_spectators", "spawn_after_spectator", "class_select_cancel_spectator");
    self hide();

    foreach(var_3 in level.players) {
      var_4 = var_3.sessionstate == "spectator";

      if(var_3.team == var_0 && !var_4) {
        self showtoplayer(var_3);
      }

      if(var_1 && (var_3.team == "spectator" || var_4) && var_0 == "allies") {
        self showtoplayer(var_3);
      }
    }
  }
}