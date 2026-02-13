/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2294.gsc
*************************************************/

_id_43F1() {
  if(!isDefined(self._id_0B67._id_91A0)) {
    return;
  }
  var_0 = self._id_0B67._id_91A0;
  var_0 delete();
  self._id_0B67._id_91A0 = undefined;
  scripts\anim\shared::_id_5ED5(self._id_034C, "primary");
}

deathcrouchmeleeoverride(var_0, var_1, var_2) {
  self._id_BF4E = 1;
}

_id_B383(var_0, var_1, var_2) {
  _id_E8DE();
  self stoplookat();

  if(isDefined(self._id_5D9F)) {
    self[[self._id_5D9F]]();
  }

  if(isDefined(self._id_5D5C)) {
    self[[self._id_5D5C]]();
  }

  if(isDefined(self._id_5D51)) {
    self thread[[self._id_5D51]]();
  }

  if(var_0 == "dog") {
    thread scripts\sound\snd_dogs::play_dog_death_sound();
  }

  _id_C517(self.origin);
  anim._id_A77A--;
  anim._id_A779--;
  _id_43F1();
  self._id_0167 = !(self._id_0DDF._id_A567 || istrue(self._id_A5BA));

  if(self._id_0DDF._id_A567) {
    _id_43DE();
    return;
  } else if(isDefined(self._id_BF4E) || self._id_01D0) {
    if(isagent(self)) {
      if(istrue(self._id_24F9)) {
        _id_488F();
      }

      scripts\anim\shared::_id_5009();
      return;
    }

    if(isDefined(self._id_4C3C) && self._id_4C3C) {
      self _meth_8019("noclip");
    } else if(istrue(self._id_A588)) {
      self _meth_8019("nogravity");
    } else {
      self _meth_8019("gravity");
    }

    _id_4CF8();

    if(!isDefined(self)) {
      return;
    }
  }

  var_3 = scripts\common\utility::_id_10A0D();

  if(_id_DB6D(var_3)) {
    _id_780D();
  }

  if(_id_DB6B(var_3)) {
    _id_7613();
  }

  if(!isDefined(self._id_DDA6)) {
    self _meth_85EF(_id_0009::_id_1C6D(), 0.3);
  }

  _id_B386(var_3);

  if(isDefined(self._id_1C30._id_43E5)) {
    self[[self._id_1C30._id_43E5]]();

    if(!isDefined(self._id_43E6)) {
      _id_43DE();
      return;
    }
  }

  if(isDefined(self._id_43E6)) {
    var_4 = self[[self._id_43E6]]();

    if(!isDefined(var_4)) {
      var_4 = 1;
    }

    if(var_4) {
      _id_43DE();
      return;
    }
  }

  self endon("entitydeleted");

  if(_id_DB65() && !self _meth_81DF()) {
    if(istrue(self._id_24F9)) {
      _id_488F();
    }

    scripts\anim\shared::_id_5009();
    _id_4CCB();

    if(isagent(self)) {
      self._id_A546 = 1;
    } else {
      self hide();

      if(!isagent(self)) {
        wait 0.1;
      }
    }

    if(isDefined(self)) {
      _id_43DE();

      if(!isagent(self)) {
        self delete();
      }
    }

    return;
  }

  if(isDefined(self._id_43DA) && !isDefined(self._id_43D3)) {
    self._id_43D3 = _id_6DA0();
  }

  var_5 = undefined;
  var_6 = undefined;
  var_7 = isDefined(self._id_43D2) && isDefined(self._id_4412);

  if(!isDefined(self._id_DDA6)) {
    if(isDefined(self._id_43D3)) {
      var_5 = self._id_43D3;
      var_6 = _id_0009::_id_1C6E(var_1, var_5);
    } else if(var_7) {
      var_5 = _id_0009::_id_1C7D(self._id_4412, self._id_43D2);
      var_6 = _id_0009::_id_1C6E(self._id_4412, var_5);
    } else {
      var_5 = _id_0009::_id_1C5C(var_0, var_1, var_2);
      var_6 = _id_0009::_id_1C6E(var_1, var_5);
    }

    if(!_func_0011(var_6, "dropgun") && !_func_0011(var_6, "fire_spray")) {
      scripts\anim\shared::_id_5009();
    }

    if(_func_0011(var_6, "dropgun")) {
      self._id_0B67._id_1FC0 = 1;
    }

    if(istrue(self._id_24F9)) {
      _id_488F();
    }

    if(isDefined(self._id_006A) && self._id_006A) {
      _id_08FE::_id_488B();
    }

    _id_7424(var_6);
    self._id_43D5 = int(_func_0079(var_6) * 1000);
    var_8 = isDefined(var_2) && var_2 == "directional_orient";

    if(istrue(self._id_4A96)) {
      var_8 = 0;
    }

    _id_AC70(var_8);

    if(_func_02B7(var_5)) {
      if(var_7) {
        self _meth_85ED(self._id_4412, var_5);
      } else {
        self _meth_85ED(var_1, var_5);
      }
    } else {
      var_9 = _id_0009::_id_1C68();
      self _meth_8077(var_9, 0.05);
      self _meth_831A(var_1, var_5, var_9, 1, 0.05);
    }

    if(var_7) {
      _id_0009::_id_1C8E(var_0, self._id_4412, var_6);
    } else {
      _id_0009::_id_1C8E(var_0, var_1, var_6);
    }
  }

  thread _id_06E3::play_paired_turret_anim_if_needed(var_6, var_2);

  if(isDefined(self._id_43D7)) {
    self _meth_8019(self._id_43D7);
  }

  if(isDefined(self._id_DDA6)) {
    if(!isDefined(self._id_A5BA)) {
      if(isDefined(self._id_5DB5)) {
        self[[self._id_5DB5]]();
      }

      if(!isDefined(self)) {
        return;
      }
      if(istrue(self._id_24F9)) {
        _id_488F();
      }

      scripts\anim\shared::_id_5009();
      self startragdoll();
    }

    if(!isagent(self)) {
      wait 0.05;
      self _meth_8019("gravity");
    }
  } else if(isDefined(self._id_BF54))
    thread _id_10821(self._id_BF54);
  else if(getdvarint("#x35d6d8f2d287ad9a0") == 1) {
    thread _id_E71A();
  } else {
    var_10 = _func_00BB(var_6, "start_ragdoll");
    var_11 = !istrue(self.disablefakeragdolltime) && !var_7 && !isDefined(self._id_43D3) && (var_10.size == 0 || var_10[0] > 0.5);

    if(var_11) {
      if(self.damagemod == "MOD_MELEE") {
        var_12 = 0.7;
      } else {
        var_12 = 0.35;
      }

      thread _id_10821(_func_0079(var_6) * var_12);
    }
  }

  if(!isagent(self) && !isDefined(self._id_DDA6)) {
    thread _id_B385();
  }

  self endon("terminate_death_thread");

  if(!isagent(self)) {
    if(isDefined(self._id_DDA6)) {
      wait 0.05;
    } else {
      var_13 = var_1;

      if(var_7) {
        var_13 = self._id_4412;
      }

      _id_0009::_id_1C45(var_0, var_13, ::_id_43F6);
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(istrue(self._id_24F9)) {
    _id_488F();
  }

  scripts\anim\shared::_id_5009();
  self notify("endPlayDeathAnim");

  if(!isagent(self)) {
    if(isDefined(self._id_BF4E) || self._id_01D0) {
      wait 0.5;

      if(!isDefined(self)) {
        return;
      }
      self _meth_85F5(_id_0009::_id_1C6D(), 0);
    }
  }

  _id_43DE();
}

_id_43F6(var_0) {
  if(isDefined(self._id_2D90) && self._id_2D90) {
    switch (var_0) {
      case "model_swap":
        _id_7422();
        return;
      case "burn_vfx_death_start":
        thread _id_7423();
        return;
    }
  }

  scripts\anim\notetracks::_id_A604(var_0);
}

_id_7424(var_0) {
  if(_func_0104(self) && !isnullweapon(self.damageweapon) && issubstr(self.damageweapon.basename, "molotov")) {
    self._id_2D90 = 1;
    thread _id_7423();
    return;
  }

  if(!isDefined(self._id_2D90) || !self._id_2D90) {
    return;
  }
  if(_func_0104(self)) {
    return;
  }
  if(self._id_04B9 != "dog" && (!isDefined(var_0) || !_func_0011(var_0, "model_swap"))) {
    if(isDefined(self._id_7611)) {
      self detach(self._id_7611);
      self._id_7611 = undefined;
    }

    if(isDefined(self._id_75C6)) {
      self detach(self._id_75C6);
      self._id_75C6 = undefined;
    }

    self setModel("burntbody_male");

    if(!isDefined(var_0) || !_func_0011(var_0, "burn_vfx_death_start")) {
      thread _id_7423();
    }
  }
}

_id_7422() {
  if(isDefined(self._id_7611)) {
    self detach(self._id_7611);
    self._id_7611 = undefined;
  }

  if(isDefined(self._id_75C6)) {
    self detach(self._id_75C6);
    self._id_75C6 = undefined;
  }

  self setModel("burntbody_male");
}

_id_7423() {
  self endon("stop_burn_VFX");
  self endon("entitydeleted");
  var_0 = 1;

  if(self _meth_86EE()) {
    var_1 = self _meth_8575("burn_to_death_by_molotov", 1);

    if(isDefined(var_1)) {
      self setscriptablepartstate("burn_to_death_by_molotov", "active");
      var_0 = 0;
    }
  }

  if(var_0) {
    var_2 = _id_6936();

    foreach(var_4 in var_2) {
      if(!isDefined(self)) {
        return;
      }
      playFXOnTag(level._id_60A1[var_4._id_2D97], self, var_4._id_0427);
      wait 0.05;
    }
  }
}

_id_6936() {
  var_0 = [];
  var_0[var_0.size] = _id_3F9F("j_knee_ri", "vfx_burn_sml_high");
  var_0[var_0.size] = _id_3F9F("j_knee_le", "vfx_burn_sml_high");
  var_0[var_0.size] = _id_3F9F("j_hip_proc_ri", "vfx_burn_med_high");
  var_0[var_0.size] = _id_3F9F("j_hip_proc_le", "vfx_burn_med_high");
  var_0[var_0.size] = _id_3F9F("j_spinelower", "vfx_burn_med_high");
  var_0[var_0.size] = _id_3F9F("j_spine4", "vfx_burn_lrg_high");
  var_0[var_0.size] = _id_3F9F("j_elbow_ri", "vfx_burn_sml_high");
  var_0[var_0.size] = _id_3F9F("j_elbow_le", "vfx_burn_sml_high");
  var_0[var_0.size] = _id_3F9F("j_shoulder_ri", "vfx_burn_med_high");
  var_0[var_0.size] = _id_3F9F("j_shoulder_le", "vfx_burn_med_high");
  return var_0;
}

_id_3F9F(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_0427 = var_0;
  var_3._id_2D97 = var_1;
  return var_3;
}

_id_488F() {
  self _meth_809F(self._id_C887, self._id_C889);
  self._id_24F9 = undefined;
}

_id_2E79(var_0, var_1) {
  var_2 = _func_00D6(var_1, 0, 3);

  if(var_2 == "vo_") {
    var_3 = _func_00D6(var_1, 3);
    var_0 _meth_827D(var_3);
    return;
  }

  if(var_2 != "ps_") {
    return;
  }
  var_3 = _func_00D6(var_1, 3);

  if(!isDefined(var_0._id_440D)) {
    var_0._id_440D = spawn("script_origin", var_0.origin);
    var_0._id_440D linkto(var_0, "");
  }

  var_4 = var_0._id_440D;
  var_4 notify("stop_C8DeathSound");
  var_4 endon("stop_C8DeathSound");
  var_4 playSound(var_3);
  var_5 = _func_0142(var_3);
  wait(var_5 * 0.001 + 0.1);
  var_4 delete();
}

_id_B82B(var_0, var_1, var_2) {
  if((scripts\common\utility::_id_87EC(makeweapon("iw7_knife_upgrade1")) || scripts\common\utility::_id_10A0E() || scripts\common\utility::_id_87EC(makeweapon("iw7_sonic"))) && isDefined(self.attacker)) {
    var_3 = _func_0261(self.attacker.origin - self.origin);

    if(self._id_0150 > 135 || self._id_0150 <= -135) {
      self _meth_8251("face angle", var_3);
    } else if(self._id_0150 > 45 && self._id_0150 <= 135) {
      self _meth_8251("face angle", var_3 + 90);
    } else if(self._id_0150 > -45 && self._id_0150 <= 45) {
      self _meth_8251("face angle", var_3 - 180);
    } else {
      self _meth_8251("face angle", var_3 - 90);
    }
  }

  _id_B383(var_0, var_1, var_2);
}

_id_B365(var_0, var_1, var_2) {
  anim._id_A490 = gettime() + randomintrange(25000, 35000);
  self _meth_8251("face angle", self._id_0B67._id_2109.angles[1]);
  _id_B383(var_0, var_1, var_2);
}

_id_B384(var_0, var_1, var_2) {
  var_3 = isagent(self);

  if(!var_3) {
    if(isDefined(self._id_9DA6)) {
      var_4 = var_2;

      if(!isDefined(var_4)) {
        var_4 = 10;
      }

      _id_0009::_id_1C4B(var_0, self._id_9DA6, var_4);
    }
  }

  scripts\anim\shared::_id_5009();

  if(istrue(self._id_24F9)) {
    _id_488F();
  }

  if(isDefined(self._id_5DB5)) {
    self[[self._id_5DB5]]();
  }

  if(!isDefined(self)) {
    return;
  }
  if(!var_3) {
    self startragdoll();
    wait 0.1;
  }

  _id_43DE();
}

_id_43DE() {
  if(istrue(self._id_DDA7)) {
    return;
  }
  if(isDefined(self)) {
    if(self._id_04B9 == "c6") {} else if(self._id_04B9 == "c8")
      _id_2E78();
  }

  _id_06BD::_id_23B1();
  self notify("terminate_ai_threads");

  if(isagent(self)) {
    return;
  }
  var_0 = 3;

  while(isDefined(self) && self.script != "death" && var_0 > 0) {
    var_0--;
    wait 0.05;
  }

  self notify("killanimscript");
}

_id_3620(var_0, var_1, var_2, var_3) {
  return _id_0009::_id_1C7D(var_1, "standing");
}

_id_DBAF(var_0, var_1, var_2, var_3) {
  return _id_08F1::_id_8A2C() || isDefined(self._id_D9E4);
}

_id_DBA0(var_0, var_1, var_2, var_3) {
  if(self._id_04B9 == "juggernaut") {
    return 0;
  }

  if(scripts\common\utility::_id_10A0D()) {
    return 1;
  }

  return 0;
}

_id_DBAB(var_0, var_1, var_2, var_3) {
  if(isDefined(self.damagemod) && isalive(self.attacker)) {
    if(!isPlayer(self.attacker)) {
      return 0;
    }

    if(scripts\common\utility::_id_69C4(self.damagemod) != "melee") {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_DB9B(var_0, var_1, var_2, var_3) {
  if(self._id_0131 == "prone") {
    return 0;
  }

  if(!isDefined(self._id_2D90) && scripts\common\utility::_id_10A0D()) {
    return 0;
  }

  if(gettime() < anim._id_A490 && !istrue(self._id_5E7B)) {
    return 0;
  }

  var_4 = undefined;

  if(isDefined(self._id_011F)) {
    var_4 = self._id_011F;
  } else if(isDefined(self._id_0B67._id_90B5)) {
    var_4 = self._id_0B67._id_90B5;
  }

  if(!isDefined(var_4) || !isDefined(var_4._id_CCBC)) {
    return 0;
  }

  if(abs(_func_000B(var_4.angles[1] - self.angles[1])) > 30) {
    return 0;
  }

  if(isDefined(self._id_CCD7)) {
    if(randomfloat(1) > self._id_CCD7) {
      return 0;
    }
  }

  if(self _meth_8242(var_4)) {
    self._id_0B67._id_2109 = var_4;
    return 1;
  }

  return 0;
}

_id_DB9C(var_0, var_1, var_2, var_3) {
  return self._id_0B67._id_2109._id_CCBC == 1;
}

_id_35D3(var_0, var_1, var_2, var_3) {
  return _id_0009::_id_1C7D(var_1, self._id_0131);
}

_id_DBB8(var_0, var_1, var_2, var_3) {
  var_4 = self.damageweapon;

  if(!isDefined(var_4) || isnullweapon(var_4)) {
    return 0;
  }

  if(self._id_017C) {
    return 0;
  }

  if(self._id_0131 == "prone" || isDefined(self._id_0DDF._id_AA76)) {
    return 0;
  }

  if(self.damagemod == "MOD_MELEE") {
    return 0;
  }

  if(abs(self._id_0150) < 45) {
    return 0;
  }

  if(self._id_014E > 500) {
    return 1;
  }

  if(self._id_0DDF._id_A235 == "run" && !_id_8771(self.attacker, 275)) {
    if(randomint(100) < 65) {
      return 0;
    }
  }

  if(scripts\anim\utility_common::_id_8A44(var_4) && self.maxhealth < self._id_014E) {
    return 1;
  }

  if(scripts\anim\utility_common::_id_8A2E(var_4) && _id_8771(self.attacker, 512)) {
    return 1;
  }

  if(var_4.basename == "iw7_devastator" && scripts\common\utility::_id_8B04(var_4)) {
    return 1;
  }

  return 0;
}

_id_E8DE() {
  self _meth_83F7("voice_bchatter_1_3d");
  self _meth_83F7("voice_air_3d");
  _id_08F1::_id_4A99(0);
  self stoploopsound();
}

_id_2E77() {
  if(!isDefined(self)) {
    return;
  }
  self._id_2C5E._id_4AA0 = 1;

  if(isDefined(self._id_1C30._id_29F3)) {
    return;
  }
  self._id_1C30._id_29F3 = 1;
  self._id_CF20 = 1;

  if(!isDefined(self._id_0B67._id_CF24)) {
    return;
  }
  foreach(var_3, var_1 in self._id_0B67._id_CF24) {
    var_2 = var_1._id_E747;

    if(var_2 == "normal") {
      continue;
    }
    if(issubstr(var_2, "_both")) {
      var_2 = "dmg_both";
    }

    self setscriptablepartstate(var_3, var_2 + "_stopfx");
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

_id_2E78() {
  self._id_2C5E._id_4AA0 = 1;

  if(isDefined(self._id_1C30._id_29F3)) {
    return;
  }
  self._id_1C30._id_29F3 = 1;
  self._id_CF20 = 1;

  if(!isDefined(self._id_0B67._id_CF24)) {
    return;
  }
  foreach(var_2, var_1 in self._id_0B67._id_CF24) {
    if(issubstr(var_2, "dmg_fx")) {
      self setscriptablepartstate(var_2, "stopfx");
    }
  }

  self setscriptablepartstate("torso_overload_fx", "normal");
}

_id_3606(var_0, var_1, var_2) {
  var_3 = length(self._id_04DF);
  var_4 = self _meth_87CE();
  var_5 = _func_03A6(var_4, var_3);
  var_6 = [];
  return _id_0009::_id_1C7D(var_1, var_5);

  if(var_6.size == 0) {
    return _id_0009::_id_1C7D(var_1, "default");
  }

  return var_6[randomint(var_6.size)];
}

_id_35DF(var_0, var_1, var_2) {
  if(scripts\engine\utility::_id_430E("head", "neck")) {
    return _id_0009::_id_1C7D(var_1, "head");
  }

  if(scripts\engine\utility::_id_430E("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    return _id_0009::_id_1C7D(var_1, "torso");
  }

  return _id_0009::_id_1C7D(var_1, "default");
}

_id_35D9(var_0, var_1, var_2) {
  switch (var_2) {
    case "cover_stand":
      return _id_0009::_id_1C7D(var_1, "stand");
    case "cover_exposed":
      return _id_0009::_id_1C7D(var_1, "exposed");
    case "cover_crouch":
      if(scripts\engine\utility::_id_430E("head", "neck") && (self._id_0150 > 135 || self._id_0150 <= -45)) {
        return _id_0009::_id_1C7D(var_1, "crouch_head");
      }

      if(self._id_0150 > -45 && self._id_0150 <= 45) {
        return _id_0009::_id_1C7D(var_1, "crouch_back");
      }

      return _id_0009::_id_1C7D(var_1, "crouch_default");
    case "cover_right":
      if(self._id_0131 == "stand") {
        return _id_0009::_id_1C7D(var_1, "right_stand");
      } else {
        if(scripts\engine\utility::_id_430E("head", "neck")) {
          return _id_0009::_id_1C7D(var_1, "right_crouch_head");
        }

        return _id_0009::_id_1C7D(var_1, "right_crouch_default");
      }
    case "cover_left":
      if(self._id_0131 == "stand") {
        return _id_0009::_id_1C7D(var_1, "left_stand");
      } else {
        return _id_0009::_id_1C7D(var_1, "left_crouch");
      }
    case "cover_3d":
      return _id_0009::_id_1C7D(var_1, "3d");
  }
}

_id_3630(var_0, var_1, var_2) {
  if(scripts\anim\utility_common::_id_8AD4()) {
    return _id_3632(var_0, var_1, var_2);
  }

  if(isDefined(self.attacker) && self _meth_83C3(self.attacker)) {
    return _id_3631(var_0, var_1, var_2);
  }

  var_3 = [];

  if(scripts\engine\utility::_id_430E("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "lower_body");
  } else if(scripts\engine\utility::_id_430E("head", "helmet")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "head");
  } else if(scripts\engine\utility::_id_430E("neck")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "neck");
  } else if(scripts\engine\utility::_id_430E("torso_upper", "left_arm_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "left_shoulder");
  }

  if(scripts\engine\utility::_id_430E("torso_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "torso_upper");
  }

  if(self._id_0150 > 135 || self._id_0150 <= -135) {
    if(scripts\engine\utility::_id_430E("neck", "head", "helmet")) {
      var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "torso_2");
    }

    if(scripts\engine\utility::_id_430E("torso_upper")) {
      var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "torso_2");
    }
  } else if(self._id_0150 > -45 && self._id_0150 <= 45)
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "back");

  var_4 = var_3.size > 0;

  if(!var_4 || randomint(100) < 15) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "default");
  }

  if(randomint(100) < 10 && _id_5BA3()) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "default_firing");
  }

  return var_3[randomint(var_3.size)];
}

_id_35FA(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = self.damageweapon;

  if(!isnullweapon(var_4) && issubstr(var_4.basename, "molotov")) {
    if(_id_0009::_id_1C72(var_1, "molotov_f")) {
      var_3 = 1;
    }
  }

  var_5 = undefined;

  if(var_3 && self._id_0131 == "prone") {
    var_5 = "molotov_prone";
  } else {
    var_5 = "explosive";

    if(var_3) {
      var_5 = "molotov";
    }

    if(self._id_0131 == "crouch") {
      var_5 = var_5 + "_crouch";
    } else if(self._id_0131 == "prone") {
      var_5 = var_5 + "_prone";
    }

    var_5 = var_5 + _id_08FD::_id_6C0B();
  }

  var_6 = _id_0009::_id_1C7D(var_1, var_5);

  if(var_3) {
    var_6 = _id_08F1::_id_BC1C(var_1, var_5, var_6);
  }

  var_7 = _id_0009::_id_1C6E(var_1, var_6);

  if(getDvar("#x3f51c78b80c6be4ce", "on") == "on") {
    var_8 = 1;
    var_9 = _func_00BB(var_7, "start_ragdoll");

    if(var_9.size > 0) {
      var_8 = var_9[0];
    }

    var_10 = _func_00B0(var_7, 0, var_8);
    var_11 = self _meth_8216(var_10);
    var_12 = 0;

    if(scripts\engine\utility::_id_0F78()) {
      var_12 = _func_02A7(self.origin, var_11, 0);
    } else {
      var_12 = self _meth_822C(self.origin, var_11, 0, 1);
    }

    if(!var_12) {
      if(var_3) {
        var_6 = _id_0009::_id_1C7D(var_1, "default_molotov");
      } else {
        var_6 = _id_0009::_id_1C7D(var_1, "default");
      }
    }
  }

  self._id_43D7 = "nogravity";
  return var_6;
}

_id_3632(var_0, var_1, var_2) {
  if(abs(self._id_0150) < 50) {
    return _id_0009::_id_1C7D(var_1, "pistol_2");
  }

  var_3 = [];

  if(abs(self._id_0150) < 110) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_2");
  }

  if(scripts\engine\utility::_id_430E("torso_upper", "torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_torso_upper");
  }

  if(!scripts\engine\utility::_id_430E("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_upper_body");
  }

  if(var_3.size == 0 || scripts\engine\utility::_id_430E("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
    var_3[var_3.size] = _id_0009::_id_1C7D(var_1, "pistol_default");
  }

  return var_3[randomint(var_3.size)];
}

_id_3631(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, "default");
}

_id_5BA3() {
  return 0;
}

_id_B385() {
  self endon("killanimscript");

  if(self._id_03FF != "none") {
    return;
  }
  wait 2;

  if(isDefined(self._id_A5BA) && self.damagemod != "MOD_MELEE") {
    _id_B1FF();
  }
}

_id_B1FF(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_DDA1)) {
    return;
  }
  var_2 = self gettagorigin("j_SpineUpper");
  var_3 = self gettagangles("j_SpineUpper");
  var_4 = anglesToForward(var_3);
  var_5 = anglestoup(var_3);
  var_6 = anglestoright(var_3);
  var_2 = var_2 + var_4 * -8.5 + var_5 * 5 + var_6 * 0;
  var_7 = scripts\engine\trace::_bullet_trace(var_2 + (0, 0, 30), var_2 - (0, 0, 100), 0, undefined);

  if(var_7["normal"][2] > 0.9) {
    playFX(level._effect["deathfx_bloodpool_generic"], var_2);
  }
}

_id_10821(var_0) {
  wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  if(isagent(self)) {
    return;
  }
  if(isDefined(self)) {
    scripts\anim\shared::_id_5009();
  }

  if(isDefined(self._id_5DB5)) {
    self[[self._id_5DB5]]();
  }

  if(isDefined(self) && !isDefined(self._id_A5BA)) {
    self startragdoll();
  }
}

_id_E71A() {
  if(isagent(self)) {
    return;
  }
  if(isDefined(self)) {
    scripts\anim\shared::_id_5009();
  }

  if(isDefined(self._id_5DB5)) {
    self[[self._id_5DB5]]();
  }

  if(isDefined(self) && !isDefined(self._id_A5BA)) {
    self startragdoll();
  }
}

_id_4CF8() {
  scripts\anim\shared::_id_5009();
  self._id_DDA6 = 1;

  if(isDefined(self._id_5DB5)) {
    self[[self._id_5DB5]]();
  }

  if(!isDefined(self)) {
    return;
  }
  var_0 = 10;
  var_1 = scripts\common\utility::_id_69C4(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && var_1 == "melee") {
    var_0 = 5;
  }

  var_2 = self._id_014E;

  if(var_1 == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE") {
    var_2 = min(var_2, 300);
  }

  var_3 = var_0 * var_2;
  var_4 = max(0.3, self._id_0147[2]);
  var_5 = (self._id_0147[0], self._id_0147[1], var_4);

  if(isDefined(self._id_BF49)) {
    var_5 = var_5 * self._id_BF49;
  } else {
    var_5 = var_5 * var_3;
  }

  if(self._id_01D0) {
    var_5 = var_5 + self._id_0344 * 20 * 10;
  }

  if(isDefined(self._id_BF50)) {
    var_5 = var_5 + self._id_BF50 * 10;
  }

  var_6 = self._id_0148;

  if(isDefined(self._id_BF47) && var_6 == "none") {
    var_6 = self._id_BF47;
  }

  if(isDefined(self._id_4C3C) && self._id_4C3C == 1) {
    var_5 = vectornormalize((self._id_0147[0], self._id_0147[1], self._id_0147[2]));
    var_5 = var_5 * 1500;
  }

  self _meth_83E6(var_6, var_5);
  wait 0.05;
}

_id_DB6E(var_0) {
  if(!istrue(self._id_DB6C)) {
    return 0;
  }

  if(isDefined(self._id_026E) && isDefined(self._id_026E.team) && isDefined(self.team) && self._id_026E.team == self.team) {
    return 0;
  }

  if(isDefined(self._id_7810) && !var_0) {
    return 0;
  }

  if(isDefined(self._id_AB34) && self._id_AB34) {
    return 0;
  }

  if(isDefined(self._id_992D) && self._id_992D) {
    return 0;
  }

  if(isDefined(self._id_0148) && self._id_0148 == "helmet") {
    return 1;
  }

  if(var_0 && randomint(2) == 0) {
    return 1;
  }

  return 0;
}

_id_DB6D(var_0) {
  if(!istrue(self._id_DB6C)) {
    return 0;
  }

  if(self._id_04B9 != "soldier" && self._id_04B9 != "juggernaut") {
    return 0;
  }

  if(self.damagemod == "MOD_MELEE" && randomint(3) < 2) {
    return 0;
  }

  if(isDefined(self._id_0148) && (self._id_0148 == "helmet" || self._id_0148 == "head")) {
    return 1;
  }

  if(var_0 && randomint(3) == 0) {
    return 1;
  }

  return 0;
}

_id_780D() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_75C6)) {
    return;
  }
  if(isDefined(self._id_4D97) && self._id_4D97) {
    return;
  }
  var_0 = self gettagorigin("j_head");

  if(isDefined(self._id_780E)) {
    var_1 = anglesToForward(self gettagangles("j_head"));
    playFX(self._id_780E, var_0, var_1);
  }

  _func_01A3("bullet_small_flesh_helmet_npc", var_0);

  if(isDefined(self._id_7810)) {
    self._id_7810 = undefined;
    var_2 = self _meth_8537("helmet", "helmet");

    if(var_2 > 0) {
      self _meth_8536(var_2, "helmet", "helmet");
    }
  }

  var_3 = _func_00BF(self._id_75C6, 0);
  var_4 = spawn("script_model", self.origin + (0, 0, 64));
  var_4 setModel(self._id_75C6);
  var_4.origin = self gettagorigin(var_3);
  var_4.angles = self gettagangles(var_3);
  waitframe();

  if(isDefined(self._id_0147) && self._id_0147 != (0, 0, 0)) {
    var_4 thread _id_780C(self._id_0147);
  } else {
    var_4 thread _id_780C((randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25), randomfloatrange(-1, 1)));
  }

  self detach(self._id_75C6, "");
  self._id_75C6 = undefined;
  self _meth_81AB("j_helmet");

  if(isalive(self) && _id_DBBA()) {
    playFXOnTag(level._id_60A1["helmet_break_suffocate"], self, "j_head");

    if(self._id_1CB8 != "zero_gravity_space" && self._id_1CB8 != "zero_gravity") {
      self._id_43DA = 1;
    }

    self _meth_81FA();
  }
}

_id_780C(var_0) {
  var_1 = var_0;
  var_1 = var_1 * randomfloatrange(2000, 4000);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = randomfloatrange(1500, 3000);
  var_5 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self _meth_8254(var_5, (var_2, var_3, var_4));
  wait 60;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(distancesquared(self.origin, level.player.origin) > 262144) {
      break;
    }

    wait 30;
  }

  self delete();
}

_id_6DA0() {
  var_0 = undefined;

  if(randomint(11) >= 1) {
    return var_0;
  }

  return var_0;
}

_id_DBBA() {
  return 0;
}

_id_DB6B(var_0) {
  if(self._id_04B9 != "soldier" && self._id_04B9 != "juggernaut") {
    return 0;
  }

  if(isDefined(self._id_5EAA)) {
    return 1;
  }

  if(self.damagemod == "MOD_MELEE") {
    return 0;
  }

  if(self.damagemod == "MOD_FIRE") {
    return 0;
  }

  var_1 = self.damageweapon;

  if(isnullweapon(var_1)) {
    return 0;
  }

  if(self.damagemod == "MOD_PROJECTILE" && var_1.classname == "turret" && istrue(level._id_4ABC)) {
    return 0;
  }

  return 0;
}

_id_7613() {
  if(!isDefined(self._id_7611)) {
    return;
  }
  var_0 = self gettagorigin("j_head");
  var_1 = anglesToForward(self gettagangles("j_head"));
  playFXOnTag(level._id_60A1["human_gib_head"], self, "j_head");
  self detach(self._id_7611, "");
  self._id_7611 = undefined;
}

_id_4094(var_0, var_1) {
  return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

_id_9D86(var_0, var_1) {
  var_2 = vectordot(var_1, var_0);
  var_3 = cos(60);

  if(_func_0219(var_2) < _func_0219(var_3)) {
    if(_id_4094(var_0, var_1) > 0) {
      return 1;
    } else {
      return 3;
    }
  } else if(var_2 < 0)
    return 0;
  else {
    return 2;
  }
}

_id_AC70(var_0) {
  var_1 = makeweapon("iw7_knife_upgrade1");
  var_2 = makeweapon("iw7_sonic");

  if(scripts\common\utility::_id_87EC(var_1) || scripts\common\utility::_id_87EC(var_2)) {
    return;
  }
  if(var_0 || self.damagemod == "MOD_MELEE" && isDefined(self.attacker) && !scripts\common\utility::_id_10A0E() && !scripts\common\utility::_id_87EC(var_2)) {
    if(scripts\engine\utility::_id_0F78()) {
      var_3 = self.attacker.origin - self.origin;
      var_4 = _func_030A(var_3, self.angles);
      self _meth_8251("face angle 3d", var_4);
    } else {
      var_5 = self._id_0147;
      var_6 = anglesToForward(self.angles);
      var_7 = vectornormalize((var_5[0], var_5[1], 0));
      var_8 = vectornormalize((var_6[0], var_6[1], 0));
      var_9 = _id_9D86(var_8, var_7);
      var_10 = var_9 * 90;
      var_11 = (-1 * var_7[0], -1 * var_7[1], 0);
      var_12 = rotatevector(var_11, (0, var_10, 0));
      var_13 = _func_0261(var_12);
      var_14 = anglesToForward((0, var_13, 0));
      self _meth_8251("face angle", var_13);
    }
  }
}

_id_B386(var_0) {
  if(isDefined(self._id_0162) && self._id_0162) {
    return;
  }
  if(_id_DBD5()) {
    return;
  }
  var_1 = "death";
  var_2 = "death_generic";
  var_3 = undefined;

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
    var_1 = "death";
    var_2 = "death_melee";
  } else {
    if(isDefined(self.damageweapon) && !isnullweapon(self.damageweapon)) {
      var_3 = _func_00E7(self.damageweapon);
    }

    if(var_0) {
      if(isDefined(var_3) && var_3 == "molotov") {
        var_1 = "flamedeath";
        var_2 = "death_fire";
      } else {
        var_1 = "explodeath";
        var_2 = "death_explode";
      }
    } else {
      if(isDefined(self._id_0B67._id_2109)) {
        var_1 = "falldeath";
        var_2 = "death_fall";
      }

      if(isDefined(var_3) && var_3 == "incendiary") {
        var_1 = "incendeath";
        var_2 = "death_incendiary";
      }
    }
  }

  if(isDefined(level._id_2359)) {
    scripts\anim\face::saybattlechatterdialogue(var_2);
  } else {
    scripts\anim\face::_id_CB6D(var_1);
  }
}

_id_DBD5() {
  if(scripts\engine\utility::_id_430E("head", "helmet")) {
    if(isDefined(self.damageweapon) && !isnullweapon(self.damageweapon)) {
      if(self.damageweapon.classname == "spread") {
        return 0;
      }

      if(issubstr(self.damageweapon.basename, "molotov")) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

_id_C517(var_0) {
  for(var_1 = 0; var_1 < anim._id_E496.size; var_1++) {
    anim._id_E496[var_1] _id_3979(var_0);
  }
}

_id_3979(var_0) {
  if(!isDefined(self._id_DD38)) {
    return;
  }
  if(distance(var_0, self._id_DD38) < 80) {
    self._id_DD38 = undefined;
    self._id_DD3C = gettime();
  }
}

_id_8771(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(distance(self.origin, var_0.origin) > var_1) {
    return 0;
  }

  return 1;
}

_id_8A50(var_0, var_1, var_2, var_3) {
  if(_id_08F1::_id_8A2C()) {
    return 1;
  }

  return 0;
}

_id_362D(var_0, var_1, var_2) {
  if(_id_08F1::_id_8A2C()) {
    return _id_0009::_id_1C7D(var_1, "shock_death");
  } else {
    return _id_0009::_id_1C7D("death_generic", "default");
  }
}

_id_DB65() {
  if(!_func_0415()) {
    return 0;
  }

  if(isDefined(self._id_A587)) {
    return 0;
  }

  if(self._id_04B9 != "soldier" && self._id_04B9 != "juggernaut" && self._id_04B9 != "civilian") {
    return 0;
  }

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
    return 0;
  }

  if(isDefined(self.damagemod) && _func_010F(self.damagemod)) {
    if(isDefined(self._id_026E) && (scripts\engine\utility::is_equal(self._id_026E._id_1CB8, "suicidebomber") || scripts\engine\utility::is_equal(self._id_026E._id_1CB8, "suicidebomber_cp"))) {
      return 1;
    }

    if(isDefined(self.damageweapon) && scripts\engine\utility::is_equal(self.damageweapon.basename, "suicide_vest")) {
      return 1;
    }
  }

  return 0;
}

_id_4CCC(var_0) {
  var_1 = var_0 gettagorigin("j_spine4");

  if(isDefined(var_0._id_0147) && var_0._id_0147 != (0, 0, 0)) {
    playFX(level._id_60A1["human_gib_fullbody"], var_1, var_0._id_0147);
  } else {
    playFX(level._id_60A1["human_gib_fullbody"], var_1, (1, 0, 0));
  }

  if(isagent(var_0)) {
    var_0 playSound("gib_fullbody");
  } else {
    var_2 = spawn("script_origin", var_1);
    var_2 playSound("gib_fullbody", "sounddone");
    var_2 waittill("sounddone");
    wait 0.1;
    var_2 delete();
  }
}

_id_4CCB() {
  if(isDefined(self._id_6EAD)) {
    level thread[[self._id_6EAD]](self);
  } else {
    level thread _id_4CCC(self);
  }
}

_id_DBAE(var_0, var_1, var_2, var_3) {
  var_4 = self.damageweapon;

  if(isDefined(var_4)) {
    if(var_4.type == "shield") {
      return 1;
    }

    var_5 = var_4.basename;

    if(var_5 == "iw7_mauler_c8hack" || var_5 == "iw7_c6hack_melee" || var_5 == "iw7_c6worker_fists") {
      return 1;
    }
  }

  if(isDefined(self._id_026E) && isDefined(self._id_026E._id_04B9) && self._id_026E._id_04B9 == "c8" && isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
    return 1;
  }

  return 0;
}

_id_4E71(var_0, var_1, var_2, var_3) {
  _id_E8DE();
  scripts\anim\shared::_id_5009();
  var_4 = vectornormalize(self.origin - level.player.origin + (0, 0, 30));
  var_5 = self.damageweapon;
  var_6 = var_5.basename;

  if(var_6 == "iw7_c6hack_melee" || var_6 == "iw7_c6worker_fists") {
    var_4 = vectornormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);
  }

  self _meth_82E8(_id_0009::_id_1C6D(), 0);

  if(isDefined(self._id_5DB5)) {
    self[[self._id_5DB5]]();
  }

  if(!isDefined(self)) {
    return;
  }
  self _meth_83E6("torso_upper", var_4 * 2400);

  if(isDefined(self._id_04B9) && self._id_04B9 == "c6") {
    self playSound("shield_death_c6_1");
  }

  level.player _meth_8278("damage_heavy");
  earthquake(0.5, 1, level.player.origin, 100);
  level.player scripts\engine\utility::_id_46A5(0.25, ::_meth_83F4, "damage_heavy");
  wait 1;
  _id_43DE();
}

_id_6C09() {
  if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_0 = "head";
    return var_0;
  } else if(scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower", "right_hand")) {
    var_0 = "midbody";
    return var_0;
  } else if(scripts\engine\utility::_id_430E("left_arm_upper", "left_arm_lower", "left_hand")) {
    var_0 = "midbody";
    return var_0;
  } else if(scripts\engine\utility::_id_430E("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_0 = "lowerbody_l";
    return var_0;
  } else if(scripts\engine\utility::_id_430E("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_0 = "lowerbody_r";
    return var_0;
  } else {
    var_0 = "midbody";
    return var_0;
  }
}

_id_6C08() {
  if(scripts\engine\utility::_id_430E("head", "helmet", "neck")) {
    var_0 = "head";
    return var_0;
  } else {
    var_0 = "midbody";
    return var_0;
  }
}

getweapondeathanimdamagetype() {
  var_0 = "_";
  var_1 = self.damageweapon;
  var_2 = var_1 _meth_8817();

  if(var_2 != "md" && var_2 != "lg" && var_2 != "xl") {
    var_2 = "md";
  }

  if(var_2 == "xl" && randomint(10) > 2) {
    var_2 = "lg";
  }

  var_0 = var_0 + var_2;
  return var_0;
}

_id_35E8(var_0, var_1, var_2) {
  var_3 = _id_08FD::_id_6C0D();

  if(isDefined(self._id_1C30._id_ADEB) && isDefined(self._id_1C30._id_ADF0) && isDefined(self._id_0131) && self._id_1C30._id_ADEB == "lowerbody" && self._id_1C30._id_ADF0 == "_lg" && self._id_0131 == "prone") {
    var_4 = "lowerbody";
    var_3 = "_lg";
  } else {
    var_4 = _id_6C09();
    var_3 = getweapondeathanimdamagetype();
  }

  var_5 = anglesToForward(self.angles);
  var_6 = vectornormalize((self._id_0147[0], self._id_0147[1], 0));
  var_7 = vectornormalize((var_5[0], var_5[1], 0));
  var_8 = _id_9D86(var_7, var_6);
  var_9 = undefined;

  if(var_8 == 2) {
    var_9 = "_8";
  } else if(var_8 == 3) {
    var_9 = "_6";
  } else if(var_8 == 1) {
    var_9 = "_4";
  } else {
    var_9 = "_2";
  }

  if(_id_DB5B(var_1, var_4)) {
    var_10 = "fire_into_air";
  } else {
    var_10 = var_4 + var_3 + var_9;
  }

  return _id_0009::_id_1C7D(var_1, var_10);
}

choosesimpledirectionaldeathanim(var_0, var_1, var_2) {
  var_3 = anglesToForward(self.angles);
  var_4 = vectornormalize((self._id_0147[0], self._id_0147[1], 0));
  var_5 = vectornormalize((var_3[0], var_3[1], 0));
  var_6 = _id_9D86(var_5, var_4);
  var_7 = undefined;

  if(var_6 == 2) {
    var_7 = "back";
  } else if(var_6 == 3) {
    var_7 = "left";
  } else if(var_6 == 1) {
    var_7 = "right";
  } else {
    var_7 = "front";
  }

  var_8 = var_7;
  return _id_0009::_id_1C7D(var_1, var_8);
}

_id_35E7(var_0, var_1, var_2) {
  var_3 = _id_6C08();
  var_4 = getweapondeathanimdamagetype();
  var_5 = anglesToForward(self.angles);
  var_6 = vectornormalize((self._id_0147[0], self._id_0147[1], 0));
  var_7 = vectornormalize((var_5[0], var_5[1], 0));
  var_8 = _id_9D86(var_7, var_6);
  var_9 = undefined;

  if(var_8 == 2) {
    var_9 = "_8";
  } else if(var_8 == 3) {
    var_9 = "_6";
  } else if(var_8 == 1) {
    var_9 = "_4";
  } else {
    var_9 = "_2";
  }

  if(_id_DB5B(var_1, var_3)) {
    var_10 = "fire_into_air";
  } else {
    var_10 = var_3 + var_4 + var_9;
  }

  return _id_0009::_id_1C7D(var_1, var_10);
}

_id_35E9(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self._id_1C30._id_ADEB) && isDefined(self._id_1C30._id_ADF0) && isDefined(self._id_0131) && self._id_1C30._id_ADEB == "lowerbody" && self._id_1C30._id_ADF0 == "_lg" && self._id_0131 == "prone") {
    var_3 = "torso_lower";
  } else {
    [var_3, var_5] = _id_08FD::_id_6C0C();
  }

  var_6 = var_3;
  return _id_0009::_id_1C7D(var_1, var_6);
}

_id_DB5B(var_0, var_1) {
  if(scripts\common\utility::iscp()) {
    return 0;
  }

  if(!isDefined(self._id_04F6) || !scripts\anim\weaponlist::_id_FF06() || istrue(self._id_0162)) {
    return 0;
  }

  if(!_id_0009::_id_1C72(var_0, "fire_into_air")) {
    return 0;
  }

  if(!self._id_0B67._id_0091) {
    return 0;
  }

  if(var_1 == "lowerbody") {
    return 0;
  }

  if(var_1 == "head") {
    var_2 = 0.3;
  } else {
    var_2 = 0.15;
  }

  return randomfloat(1) < var_2;
}

_id_35EB(var_0, var_1, var_2) {
  var_3 = "lowerbody";
  var_4 = "_lg";
  var_5 = anglesToForward(self.angles);
  var_6 = vectornormalize((self._id_0147[0], self._id_0147[1], 0));
  var_7 = vectornormalize((var_5[0], var_5[1], 0));
  var_8 = _id_9D86(var_7, var_6);
  var_9 = undefined;

  if(var_8 == 2) {
    var_9 = "_8";
  } else if(var_8 == 3) {
    var_9 = "_6";
  } else if(var_8 == 1) {
    var_9 = "_4";
  } else {
    var_9 = "_2";
  }

  var_10 = var_3 + var_4 + var_9;
  return _id_0009::_id_1C7D(var_1, var_10);
}