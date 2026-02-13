/***************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\asm\zombie_juggernaut\zombie_juggernaut.gsc
***************************************************************/

zombiejuggernaut(var_0, var_1, var_2) {
  self endon("asm_terminated");
  self endon("death");
  self._id_0275 = 90;
  self._id_0377 = -90;
  self._id_1C30._id_5E3A = spawnStruct();
  self._id_1C30._id_5E3A._id_5E36 = "invalid";
  self._id_1C30._id_5E3A._id_F1E8 = 0;
  self._id_1C30._id_426A = spawnStruct();
  self._id_1C30._id_5F3F = 0;
  self._id_1C30.movealias = [];
  self._id_5DC3 = _id_0909::_id_110AB;
  self._id_5D6B = _id_0909::_id_3180;
  self._id_033F = 64;
  self _meth_87CF(self._id_1C30._id_1A35);
  self._id_5DC3 = ::_id_DBA8;
  self.fnplaypainanim = ::_id_B8AA;
  _func_03A2("zombie_juggernaut", "walk", 40);
  _id_08F1::_id_D8B2();
  thread scripts\anim\shared::_id_459F();
  aimtrack(var_0);
}

_id_DBA8() {
  if(!istrue(self.force_damage_pain) && (!isDefined(self._id_014E) || self._id_014E < self.maxhealth * 0.5)) {
    return 0;
  }

  self.force_damage_pain = undefined;
  return _id_0909::_id_110AB();
}

_id_B8AA(var_0) {
  self endon("death");
  self._id_A4C0 = gettime() + var_0 * 1000 + 5000;

  if(!istrue(self.playing_vo_taunt)) {
    self _meth_827E("ai_juggernaut_exert_pain");
  }

  self._id_1C30.playpain = 1;
  wait(var_0);
  self._id_1C30.playpain = 0;
}

zombiejuggernaut_shouldstrafe(var_0, var_1, var_2) {
  if(!istrue(self._id_0047)) {
    return 0;
  }

  if(!isDefined(self._id_0192)) {
    return 0;
  }

  return 1;
}

zombiejuggernaut_meleeterminate(var_0, var_1, var_2) {
  _id_0908::attackterminate(var_0, var_1, var_2);
  _id_0009::_id_1C52("melee", "end");
}

zombiejuggernaut_windupterminate(var_0, var_1, var_2) {
  self._id_0B67.needs_to_shoot = 0;
  _id_0009::_id_1C52("windup", "end");
}

zombiejuggernaut_shootterminate(var_0, var_1, var_2) {
  self._id_0B67.needs_to_stop_shoot = 0;
  _id_0009::_id_1C52("shoot", "end");
}

zombiejuggernaut_tauntterminate(var_0, var_1, var_2) {
  self._id_0B67.needs_to_taunt = 0;
  _id_0009::_id_1C52("taunt", "end");
}

zombiejuggernaut_startshooting() {
  self._id_0B67.needs_to_shoot = 1;
}

zombiejuggernaut_stopshooting() {
  self._id_0B67.needs_to_stop_shoot = 1;
}

wantstoshoot(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_0B67.needs_to_shoot)) {
    return 1;
  }

  return 0;
}

wantstostopshoot(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_0B67.needs_to_stop_shoot)) {
    return 1;
  }

  return 0;
}

zombiejuggernaut_requesttaunt() {
  self._id_0B67.needs_to_taunt = 1;
}

wantstotaunt(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_0B67.needs_to_taunt)) {
    return 1;
  }

  return 0;
}

aimtrack(var_0) {
  self endon("asm_terminated");
  _id_06C1::_id_D576();
  self._id_1C30._id_F3F1 = var_0;
  var_1 = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "aim_2"));
  var_2 = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "aim_4"));
  var_3 = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "aim_6"));
  var_4 = _id_0009::_id_1C6E("knobs", _id_0009::_id_1C7D("knobs", "aim_8"));
  _id_06C1::_id_F415(var_1, var_2, var_3, var_4);
  aimtrackloop(var_0);
}

aimtrackloop(var_0) {
  self endon("death");
  self._id_1C30._id_BC6D = 0;
  self._id_1C30._id_BC55 = 0;
  var_1 = (0, 0, 0);
  var_2 = 1;
  var_3 = 0;
  var_4 = 0;
  var_5 = 10;

  for(;;) {
    _id_06C1::_id_7DB0();
    var_6 = _id_0009::_id_1C43(self._id_1C30._id_F3F1, "aim");

    if(!istrue(self._id_0047)) {
      var_6 = 0;
    }

    if(!var_6 && _id_0009::_id_1C43(self._id_1C30._id_F3F1, "notetrackAim")) {
      var_6 = _id_0009::_id_1C50(self._id_1C30._id_F3F1, "start_aim");
    }

    if(!var_6 || !istrue(self._id_0B67._id_03CE)) {
      self._id_1C30._id_1354 = undefined;
    } else if(!isDefined(self._id_1C30._id_1354)) {
      self._id_1C30._id_1354 = gettime();
    }

    var_1 = (0, 0, 0);
    var_7 = undefined;
    var_8 = undefined;

    if(var_6) {
      var_8 = self _meth_884D();
      var_7 = _id_0AED::getshootposmp(var_8);
      var_9 = undefined;

      if(isDefined(var_7)) {
        var_9 = var_7;
      }

      if(isDefined(self._id_1353)) {
        self _meth_8007(self._id_1353);
      } else if(!isDefined(var_9)) {
        self _meth_8007(3);
      } else {
        self _meth_8007(1);
      }

      var_10 = isDefined(var_9);
      var_11 = (0, 0, 0);

      if(var_10) {
        var_11 = var_9;
      }

      var_14 = 0;
      var_15 = isDefined(self._id_E83A);

      if(var_15) {
        var_14 = self._id_E83A;
      }

      var_16 = 0;
      var_17 = 0;
      var_18 = (var_17, var_16, 0);
      var_19 = self _meth_8107();

      if(self _meth_8659() || istrue(self._id_8873)) {
        var_1 = self _meth_85E4(var_8, var_11, var_10, var_18, var_14, var_15, 0);
      } else {
        var_1 = self _meth_85E4((0, 0, 0));
      }

      if(_func_000C(var_19, var_1) > 12) {
        self._id_0086 = 0;
      }
    } else if(abs(self._id_1C30._id_BC6D) < 5 && abs(self._id_1C30._id_BC55) < 5) {
      self _meth_85E4((0, 0, 0));
      self _meth_8007(3);
      self._id_0086 = 0;
      waitframe();
      continue;
    }

    if(self _meth_8645(self._id_1C30._id_F3F1)) {
      waitframe();
      continue;
    }

    if(istrue(self._id_0380)) {
      waitframe();
      continue;
    }

    var_23 = var_1[0];
    var_24 = var_1[1];
    var_1 = undefined;

    if(var_4 > 0) {
      var_4 = var_4 - 1;
      var_5 = max(10, var_5 - 5);
    } else if(self._id_0366 && self._id_0366 != var_3) {
      var_4 = 2;
      var_5 = 30;
    } else
      var_5 = 10;

    var_25 = 4;
    var_3 = self._id_0366;
    var_26 = self._id_02D6 != "stop" || !var_2;

    if(var_26) {
      var_27 = var_24 - self._id_1C30._id_BC6D;

      if(_func_0219(var_27) > var_25) {
        var_28 = var_27 * 0.4;
        var_24 = self._id_1C30._id_BC6D + clamp(var_28, -1 * var_5, var_5);
        var_24 = clamp(var_24, self._id_0377, self._id_0275);
      }

      var_29 = var_23 - self._id_1C30._id_BC55;

      if(_func_0219(var_29) > var_25) {
        var_30 = var_29 * 0.4;
        var_23 = self._id_1C30._id_BC55 + clamp(var_30, -1 * var_5, var_5);
        var_23 = clamp(var_23, self._id_04BE, self._id_0185);
      }
    }

    var_2 = 0;
    self._id_1C30._id_BC6D = var_24;
    self._id_1C30._id_BC55 = var_23;

    if(isDefined(self._id_1C30._id_4D0B) && self._id_1C30._id_4D0B) {
      _id_06C1::_id_F422(var_23, var_24);
    } else {
      _id_06C1::_id_F421(var_23, var_24);
    }

    wait 0.05;
  }
}