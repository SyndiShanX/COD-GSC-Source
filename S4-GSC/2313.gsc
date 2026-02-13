/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2313.gsc
*************************************************/

_id_3B0C() {}

_id_11071(var_0, var_1, var_2) {
  self._id_1C30._id_5E3A = spawnStruct();
  self._id_1C30._id_5E3A._id_5E36 = "invalid";
  self._id_1C30._id_5E3A._id_F1E8 = 0;
  self._id_1C30._id_426A = spawnStruct();
  self._id_1C30._id_5F3F = 0;
  self._id_1C30.movealias = [];
  self._id_5DC3 = ::_id_110AB;
  self._id_5D6B = ::_id_3180;
  self._id_033F = 64;
  self _meth_87CF(self._id_1C30._id_1A35);

  if(_id_1106E()) {
    _id_08F1::_id_D8B2();
    thread scripts\anim\shared::_id_459F();
    _id_06C1::_id_F3D4(var_0);
  }
}

setmoveratescale(var_0) {
  self._id_A254 = var_0;
  _id_0009::_id_1C9F(self._id_A254);
}

setnonmoveratescale(var_0) {
  self._id_A5AC = var_0;
}

_id_362C(var_0, var_1, var_2) {
  if(isDefined(self._id_03E9) && isDefined(self._id_03E9._id_CC9D)) {
    var_3 = "";

    switch (self._id_91A3._id_02D6) {
      case "slow_walk":
      case "walk":
        var_3 = "_walk";
        break;
      case "run":
      case "sprint":
        var_3 = "_run";
        break;
      default:
        var_3 = "_run";
        break;
    }

    var_4 = _id_0009::_id_1C7E(var_1, self._id_03E9._id_CC9D + var_3);

    if(isDefined(var_4)) {
      return var_4;
    }

    var_4 = _id_0009::_id_1C7E(var_1, self._id_03E9._id_CC9D);

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  if(!isDefined(var_2)) {
    return _id_0009::_id_1C6C(var_0, var_1);
  }

  return _id_0009::_id_1C7D(var_1, var_2);
}

_id_362A(var_0, var_1, var_2) {
  return _id_362C(var_0, var_1, var_2);
}

_id_3605(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return _id_0009::_id_1C6C(var_0, var_1);
  }

  return _id_0009::_id_1C7D(var_1, var_2);
}

_id_11064(var_0, var_1, var_2) {
  var_3 = self._id_1C30.movealias[var_1];

  if(!isDefined(var_3)) {
    var_3 = _id_0009::_id_1C6B(var_1);
    self._id_1C30.movealias[var_1] = var_3;
  }

  self._id_1C30._id_A244 = var_3;
  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_11065(var_0, var_1, var_2) {
  var_3 = self _meth_810F(var_1);
  var_4 = _id_0B05::_id_4307(self._id_431D, self._id_0147);
  var_5 = _func_000B(var_4 - self.angles[1]);
  var_6 = _id_0B05::_id_6C06(var_5, var_3);
  return var_6;
}

_id_1107D(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);

  if(isDefined(self._id_0323)) {
    if(self _meth_85EC()) {
      self _meth_82B9("code_move");
      self _meth_82C1("face motion");
    } else {
      self _meth_8019("normal");
      self _meth_8251("face motion");
    }
  }

  var_4 = self _meth_810C(var_1, var_3);
  var_5 = _func_0079(var_4);
  var_6 = 1;

  if(isDefined(self._id_A5AC) && self._id_A5AC > 0) {
    var_6 = self._id_A5AC;
  }

  var_5 = var_5 * (1 / var_6);
  self._id_A4C0 = gettime() + var_5 * 0.75 * 1000;

  if(isDefined(self.fnplaypainanim)) {
    self thread[[self.fnplaypainanim]](var_5);
  }

  _id_0017::_id_B354(var_1, var_3, self._id_A5AC, "pain_anim");
  _id_5B1B(var_0, var_1, var_2);
}

_id_1107E(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_3 = undefined;

  if(isDefined(self._id_1C30._id_A244)) {
    var_3 = _id_0009::_id_1C7E(var_1, self._id_1C30._id_A244);
  }

  if(!isDefined(var_3)) {
    var_3 = _id_0009::_id_1C6C(var_0, var_1);
  }

  var_4 = _id_0009::_id_1C6A(var_0, var_1);
  thread _id_0017::_id_B353(var_1, var_3, self._id_A5AC, var_1, "end", var_4);
  self._id_A4C0 = gettime() + 10000;
  wait 0.35;
  _id_0009::_id_1C53(var_0, "end");
}

_id_11072(var_0, var_1, var_2, var_3) {
  var_4 = _id_42F3();

  if(scripts\engine\utility::_id_430E("torso_upper", "torso_lower") && (isDefined(var_4) && var_4 >= 0)) {
    return 1;
  }

  return scripts\engine\utility::_id_430E("left_arm_upper", "left_arm_lower", "left_hand", "left_leg_upper", "left_foot", "left_leg_lower");
}

_id_11073(var_0, var_1, var_2, var_3) {
  var_4 = _id_42F3();

  if(scripts\engine\utility::_id_430E("torso_upper", "torso_lower") && (isDefined(var_4) && var_4 < 0)) {
    return 1;
  }

  return scripts\engine\utility::_id_430E("right_arm_upper", "right_arm_lower", "right_hand", "right_leg_upper", "right_foot", "right_leg_lower");
}

_id_87EB(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::_id_430E("head", "neck", "helmet");
}

_id_42F3() {
  var_0 = _id_0B05::_id_4307(self._id_431D, self._id_0147);
  var_1 = _func_000B(var_0 - self.angles[1]);
  return var_1;
}

_id_5B1B(var_0, var_1, var_2) {
  self notify("killanimscript");
  self _meth_85CA(var_0, "choose_idle");
}

_id_110AB() {
  if(isDefined(self._id_0043) && self._id_0043 == 0) {
    return 0;
  }

  if(isDefined(self._id_8873) && self._id_8873) {
    return 0;
  }

  if(isDefined(self._id_A4C0) && gettime() < self._id_A4C0) {
    return 0;
  }

  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(isDefined(level._id_A523) && self istouching(level._id_A523)) {
    return 0;
  }

  if(!istrue(self._id_EAAB)) {
    if(_id_06BD::_id_23E3()) {
      return 0;
    }

    if(_id_06BD::_id_23E2()) {
      return 0;
    }
  }

  if(!scripts\aitypes\zombie_common\awareness::is_aware()) {
    return 0;
  }

  return 1;
}

_id_8919(var_0) {
  switch (var_0) {
    case "left_leg_upper":
    case "right_leg_lower":
    case "right_leg_upper":
    case "right_foot":
    case "left_foot":
    case "left_leg_lower":
      return 1;
    default:
      return 0;
  }
}

_id_8937(var_0, var_1, var_2, var_3) {
  return !_id_06BD::_id_23E5();
}

_id_11074(var_0, var_1, var_2, var_3) {
  return _id_06BD::_id_23D5();
}

_id_1106E(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_04F6) && !isnullweapon(self._id_04F6);
}

_id_A40B(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_4B40)) {
    return self._id_4B40;
  }

  return 0;
}

_id_A415(var_0, var_1, var_2, var_3) {
  return _id_06BD::_id_23E6("walk");
}

_id_A412(var_0, var_1, var_2, var_3) {
  return _id_06BD::_id_23E6("run");
}

_id_A413(var_0, var_1, var_2, var_3) {
  if(_id_8A73()) {
    return 1;
  }

  return _id_06BD::_id_23E6("sprint");
}

needstosupersprint(var_0, var_1, var_2, var_3) {
  return _id_06BD::_id_23E6("super_sprint");
}

needstowander(var_0, var_1, var_2, var_3) {
  return _id_06BD::_id_23E6("wander");
}

_id_A414() {
  if(_id_8A73() && _id_DBBC() && !_id_7597()) {
    return 1;
  }

  return 0;
}

_id_A410() {
  if(isDefined(self._id_03E9) && isDefined(self._id_03E9._id_CC9D)) {
    return !istrue(self._id_7598);
  }

  return 0;
}

_id_A40E(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_94FF);
}

_id_A40F() {
  if(isDefined(self._id_03E9) && isDefined(self._id_03E9._id_CD65)) {
    return !istrue(self._id_7596);
  }

  return 0;
}

_id_DBF2() {
  if(isDefined(self._id_94FF)) {
    return 0;
  } else {
    return 1;
  }
}

_id_A23D(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_1210) && self._id_1210 == "zombie_brute") {
    return 0;
  }

  var_4 = isDefined(self._id_1C30._id_4130) && self._id_1C30._id_4130 != self._id_0B67._id_02D7;

  if(var_4) {
    return 1;
  } else {
    return 0;
  }
}

_id_887B() {
  return istrue(self._id_2528);
}

_id_8A73() {
  return istrue(self._id_86D9);
}

_id_DBBC() {
  return istrue(self._id_DABE);
}

_id_7597() {
  return istrue(self._id_7597);
}

_id_87B3(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_86D9)) {
    return 1;
  }

  return 0;
}

_id_87C2(var_0, var_1, var_2, var_3) {
  if(self._id_1210 == "zombie_cop") {
    if(getdvarint("#x35394973edbfb246e") != 0) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_DBBE(var_0, var_1, var_2, var_3) {
  return 0;
}

_id_DBA1(var_0, var_1, var_2, var_3) {
  return istrue(self._id_C8AA);
}

_id_35FC(var_0, var_1, var_2) {
  self notify("facemelter_launch_chosen");

  if(istrue(self._id_4B40)) {
    return "prone_launch";
  }

  return "launch";
}

_id_5887(var_0, var_1, var_2, var_3) {
  self notify("ready_to_launch");
}

_id_DB9D(var_0, var_1, var_2, var_3) {
  return istrue(self._id_4B0F);
}

_id_35F1(var_0, var_1, var_2) {
  if(istrue(self._id_4B40)) {
    return "prone_spin";
  }

  return "spin";
}

_id_4B11(var_0, var_1, var_2, var_3) {
  self notify("ready_to_spin");
}

_id_DBA4(var_0, var_1, var_2, var_3) {
  return istrue(self._id_75DE);
}

_id_3600(var_0, var_1, var_2) {
  if(istrue(self._id_4B40)) {
    return "prone_expand_head";
  }

  return "expand_head";
}

_id_DBB0(var_0, var_1, var_2, var_3) {
  return 0;
}

_id_B8F5(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_CF4A = 1;

  if(self _meth_85EC()) {
    self _meth_82C2("noclip");
  } else {
    self _meth_8019("noclip");
  }

  var_3 = _id_06BE::_id_1C5D(var_0, var_1);
  var_4 = 0.01;
  thread _id_06BE::_id_1C88(var_0, var_1, var_3, var_4);

  if(isDefined(level._id_E147)) {
    self[[level._id_E147]]();
  }

  wait 0.5;
  self._id_7596 = 1;
}

_id_B897(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_CF4A = 1;

  if(self _meth_85EC()) {
    self _meth_82C2("noclip");
  } else {
    self _meth_8019("noclip");
  }

  thread _id_08F1::_id_B31C(var_0, var_1, var_2);
  wait 1;
  level thread[[level._id_9DAB]](self);
}

_id_B919(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._id_CF4A = 1;
  self._id_86ED = 1;
  self._id_103E8 = 1;
  self._id_0229 = 1;
  self.ignoreme = 1;

  if(self _meth_85EC()) {
    self _meth_82C2("noclip");
  } else {
    self _meth_8019("noclip");
  }

  _id_0017::_id_D6EC(1, "play_vignette_anim");
  self._id_7598 = 0;
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);

  if(isDefined(self._id_03E9) && isDefined(self._id_03E9._id_91D1)) {
    thread _id_AA16(var_0, var_1, var_3);
  }

  var_4 = 1.0;
  var_5 = self._id_4C08;
  self._id_4C08 = 1;
  _id_06BE::_id_1C89(var_0, var_1, var_3, var_4, "code_move");
  self._id_4C08 = var_5;

  if(self _meth_85EC()) {
    self _meth_82C2("gravity");
  } else {
    self _meth_8019("gravity");
  }

  self._id_CF4A = 0;
  self._id_0229 = 0;
  self.ignoreme = 0;
  _id_0017::_id_D6EC(0, "play_vignette_anim");
  self._id_103E8 = undefined;
  self._id_7598 = 1;
}

_id_F0A0(var_0, var_1, var_2) {
  if(self _meth_85EC()) {
    self _meth_82C2("gravity");
  } else {
    self _meth_8019("gravity");
  }

  self._id_CF4A = 0;
  self._id_7598 = 1;
  self._id_86ED = undefined;
  self._id_103E8 = undefined;
  self notify("intro_vignette_done");
}

_id_91CE(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = _id_06BE::_id_1C5D(var_0, var_1);
  var_3 = self _meth_810C(var_1, var_2);
  var_4 = _func_0079(var_3);
  var_5 = _func_00BB(var_3, "fall");
  var_6 = _func_00BB(var_3, "land");
  var_7 = _func_00B0(var_3, var_5[0], var_6[0]);

  if(self _meth_85EC()) {
    self _meth_82BA(1.0, 1.0);
  }

  var_8 = 1;
  _id_0017::_id_B354(var_1, var_2, var_8, var_1, "fall", undefined);

  if(var_7 == (0, 0, 0)) {
    if(self _meth_85EC()) {
      self _meth_82C2("gravity");
    } else {
      self _meth_8019("gravity");
    }

    return;
  }

  var_9 = scripts\engine\utility::_id_5000(self.origin, 0, -2000);
  var_9 = self._id_03E9._id_91D0;
  var_10 = var_9 - self.origin;
  var_11 = var_10[2] / var_7[2];
  var_12 = var_4 * var_6[0] - var_4 * var_5[0];
  var_13 = var_12 * var_11;

  if(var_11 >= 1) {
    if(self _meth_85EC()) {
      self _meth_82BA(1, var_11);
    }

    var_8 = 1 / var_11;
    _id_0017::_id_B354(var_1, var_2, var_8, var_1, "land", undefined);
    var_8 = 1;

    if(self _meth_85EC()) {
      self _meth_82C2("gravity");
      self _meth_82BA(1, 1);
    } else
      self _meth_8019("gravity");

    _id_0017::_id_B354(var_1, var_2, var_8, var_1, "end", undefined);
  }
}

_id_AA16(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self _meth_810C(var_1, var_2);
  var_4 = _func_0079(var_3);
  var_5 = _func_00BB(var_3, "fall");
  var_6 = _func_00BB(var_3, "land");

  if(var_5.size > 0 && var_6.size > 0) {
    var_7 = _func_00B0(var_3, var_5[0], var_6[0]);
    _id_0017::_id_10980(var_1, "fall", var_1, var_2, undefined);
  } else {
    wait(var_4);
    return;
  }

  if(var_7 == (0, 0, 0)) {
    self _meth_82C2("gravity");
    return;
  }

  var_8 = scripts\engine\utility::_id_5000(self.origin, 0, -2000);
  var_8 = self._id_03E9._id_91D0;
  var_9 = var_8 - self.origin;
  var_10 = var_9[2] / var_7[2];
  var_11 = var_4 * var_6[0] - var_4 * var_5[0];
  var_12 = var_11 * var_10;

  if(var_10 >= 1) {
    if(self _meth_85EC()) {
      self _meth_82BA(1, var_10);
    }

    _id_0017::_id_10980(var_1, "land", var_1, var_2, undefined);

    if(self _meth_85EC()) {
      self _meth_82C2("gravity");
      self _meth_82BA(1, 1);
    } else
      self _meth_8019("gravity");
  }
}

_id_B862(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_03E9) && isDefined(self._id_03E9._id_91D1)) {
    return 1;
  }

  return 0;
}

_id_B8FD(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_08F1::_id_B31C(var_0, var_1, var_2);
  self._id_7597 = 1;
}

_id_F814(var_0) {
  self._id_54D1 = 1;
  self._id_86D9 = 1;
  self._id_A546 = 1;
  self._id_DABE = var_0;
  self.health = _id_2F00();
  self._id_0229 = 0;
  self setscriptablepartstate("eyes", "eye_glow_off");
  self _meth_809E();
  var_1 = ["park_clown_zombie", "park_clown_zombie_blue", "park_clown_zombie_green", "park_clown_zombie_orange", "park_clown_zombie_yellow"];
  var_2 = scripts\engine\utility::random(var_1);
  self setModel(var_2);
  _id_06BD::_id_23F3("sprint");

  if(isDefined(level._id_EAF3)) {
    self _meth_8512(level._id_EAF3);
  }
}

_id_2F00() {
  var_0 = 200;

  switch (level._id_E3D5) {
    case 0:
      var_0 = 100;
      break;
    case 1:
      var_0 = 400;
      break;
    case 2:
      var_0 = 900;
      break;
    case 3:
      var_0 = 1300;
      break;
    default:
      var_0 = 1600;
  }

  return var_0;
}

_id_DBB6(var_0, var_1, var_2, var_3) {
  if(_id_0017::_id_8A63()) {
    return 0;
  }

  if(self._id_13E7 == "traverse") {
    return 0;
  }

  if(isDefined(var_2) && _func_010F(var_2) && var_0 >= 350) {
    if(isDefined(var_1) && !issubstr(var_1.basename, "g18pap") && isDefined(var_1._id_04B7) && !issubstr(var_1._id_04B7, "g18pap")) {
      return 1;
    }
  }

  if(isDefined(var_2) && var_2 == "MOD_MELEE") {
    return 1;
  }

  if(isDefined(self._id_EAA4)) {
    if(self._id_EAA4 > gettime()) {
      return 1;
    } else {
      self._id_EAA4 = undefined;
      self._id_EAAB = undefined;
    }
  }

  if(istrue(self._id_EAAB)) {
    return 1;
  }

  if(isDefined(self._id_DBB7) && [[self._id_DBB7]]()) {
    return 1;
  }

  return 0;
}

_id_DB25() {
  if(!_id_0AEB::_id_DB24()) {
    return 0;
  }

  if(isDefined(self._id_012F)) {
    return 0;
  }

  if(isDefined(self._id_5523)) {
    return 0;
  }

  return 1;
}

_id_DBE9(var_0, var_1, var_2, var_3) {
  if(!_id_DB25()) {
    return 0;
  }

  if(!isDefined(self._id_0323)) {
    return 0;
  }

  if(!isDefined(self._id_19FC)) {
    self._id_19FC = self._id_027F;
  }

  if(isDefined(self._id_8873) && self._id_8873) {
    self._id_19FC = undefined;
    return 0;
  }

  if(!isDefined(var_3) || var_3.size < 1) {
    var_4 = "Exposed";
  } else {
    var_4 = var_3[0];
  }

  if(!_id_08F1::_id_8764(var_0, var_1, var_2, var_4)) {
    return 0;
  }

  self._id_1C30._id_E906 = _id_2EFF(var_0, var_2, var_4);

  if(!isDefined(self._id_1C30._id_E906)) {
    return 0;
  }

  return 1;
}

_id_2EFF(var_0, var_1, var_2) {
  var_3 = _id_08F1::_id_68D8();

  if(isDefined(var_3)) {
    var_4 = var_3.origin;
  } else {
    var_4 = self._id_0323;
  }

  var_5 = _id_0AEB::_id_69B5();
  var_6 = self._id_19FC;
  var_7 = vectortoangles(var_6);

  if(isDefined(var_5)) {
    var_8 = _func_000B(var_5[1] - var_7[1]);
  } else if(isDefined(var_3) && var_3.type != "Path") {
    var_8 = _func_000B(var_3.angles[1] - var_7[1]);
  } else {
    var_9 = var_4 - self.origin;
    var_10 = vectortoangles(var_9);
    var_8 = _func_000B(var_10[1] - var_7[1]);
  }

  var_11 = var_1;
  var_12 = _id_0AEB::_id_6D92();
  var_13 = var_4 - self.origin;
  var_14 = _func_0135(var_13);
  var_15 = 0;
  var_16 = self _meth_810C(var_11, var_15);
  var_17 = _func_00B0(var_16);
  var_18 = _func_0077(var_16);
  var_19 = length(self getvelocity());
  var_20 = var_19 * 0.053;
  var_21 = length(var_13);
  var_22 = length(var_17);

  if(abs(var_21 - var_22) > var_20) {
    return undefined;
  }

  if(var_14 < _func_0135(var_17)) {
    return undefined;
  }

  var_23 = _id_0AEB::_id_2EB1(var_12._id_B9FE, var_12._id_01BF[1], var_17, var_18);
  var_24 = _func_02AB(var_12._id_B9FE, self);
  var_25 = _id_0AEB::_id_2EB1(var_24, var_12._id_01BF[1], var_17, var_18);
  var_26 = self _meth_84DC();
  var_27 = _func_02A6(var_26, var_24, self, 1);
  var_28 = var_27["fraction"] >= 0.9 || _func_02A8(var_26, var_24, self);

  if(!var_28) {
    var_29 = self _meth_8473();
    var_28 = var_29 < distance(var_26, var_24) + 8.0;
  }

  if(var_28) {
    var_30 = spawnStruct();
    var_30._id_E8FC = var_15;
    var_30._id_0053 = 0;
    var_30._id_0405 = var_23;
    var_30._id_0052 = var_18;
    var_30.angles = var_12.angles;
    var_30._id_01BF = var_12._id_01BF;
    var_30._id_E907 = var_17;
    var_30._id_1C0B = var_4;
    return var_30;
  }

  return undefined;
}

_id_B90E(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_3 = self _meth_8161();
  var_4 = self _meth_8160();

  if(self _meth_85EC()) {
    self _meth_82C2("noclip");
    self _meth_82C1("face angle abs", var_3.angles);
    self _meth_82B9("anim deltas");
    self _meth_82BA(1.0, 1.0);
  } else {
    self _meth_8251("face angle", var_3.angles[1]);
    self _meth_8019("noclip");
  }

  var_5 = var_4 - var_3.origin;
  var_6 = self _meth_810C(var_1, 0);
  var_7 = _func_0079(var_6);
  var_8 = _func_00B0(var_6);
  var_9 = length(var_8);
  var_10 = length(var_4 - self.origin);
  var_11 = var_7 * (var_10 / var_9);

  if(self _meth_85EC()) {
    self _meth_82B3(self.origin, var_4, var_11);
  }

  self _meth_82E6(var_1, 0);
  wait(var_11);

  if(self _meth_85EC()) {
    self _meth_82C2("gravity");
  } else {
    self _meth_8019("gravity");
  }

  self notify("traverse_end");
  _id_F09F(var_0, var_1);
}

_id_3638(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return _id_0009::_id_1C6C(var_0, var_1);
  }

  switch (self._id_0B67._id_02D7) {
    case "slow_walk":
    case "walk":
      var_2 = var_2 + "_walk";
      break;
    case "super_sprint":
    case "run":
    case "sprint":
      var_2 = var_2 + "_run";
      break;
    default:
      var_2 = var_2 + "_walk";
      break;
  }

  return _id_0009::_id_1C7D(var_1, var_2);
}

_id_B910(var_0, var_1, var_2) {
  _id_0017::_id_D6EC(1, "DoTraverse");
  var_3 = self._id_4C08;
  self._id_4C08 = 1;
  _id_4E8B(var_0, var_1, var_2);
  self._id_4C08 = var_3;

  if(self _meth_85EC()) {
    self _meth_82BA(1, 1);
  }

  _id_0017::_id_D6EC(0, "Traverse end_script");
  self._id_75BE = 1;
  self._id_F4D2 = undefined;
}

_id_4E8C(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  thread _id_38A3(var_1);
  var_3 = self _meth_8161();
  var_4 = self _meth_8160();
  self._id_532D = var_4;

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_4)) {
    return;
  }
  self._id_533E = var_4;
  self._id_F4D2 = vectornormalize(var_4 - var_3.origin);
  var_5 = undefined;
  var_5 = var_3._id_005D;

  if(var_1 == "traverse_external") {
    var_5 = var_1;
  }

  if(_id_A409(var_5)) {
    var_5 = "crawling_" + var_5;
  }

  if(!isDefined(var_5)) {
    return;
  }
  self._id_86ED = 1;
  var_6 = _id_0009::_id_1C5C(var_0, var_1, var_2);
  var_7 = _id_0009::_id_1C6E(var_1, var_6);
  var_8 = issubstr(var_5, "jump_across");
  var_9 = var_5 == "traverse_boost" && (self._id_E3D8 == "humanoid" || self._id_E3D8 == "zombie");
  var_10 = var_4 - var_3.origin;
  var_11 = (var_10[0], var_10[1], 0);
  var_12 = vectortoangles(var_11);

  if(self _meth_85EC()) {
    self _meth_82C1("face angle abs", var_12);
    self _meth_82B9("anim deltas");
  } else {
    self _meth_8251("face angle", var_12[1]);
    self _meth_8019("noclip");
  }

  self._id_F4E4 = var_7;
  self._id_F4DE = var_3.angles;
  _id_0017::_id_B354(var_5, var_6, 1.0, "traverse", undefined, ::_id_F4EC);
  _id_91DD();

  if(self _meth_85EC()) {
    self _meth_82C2("gravity");
  }

  self._id_86ED = undefined;
  self notify("traverse_end");
  _id_F09F(var_0, var_1);
}

_id_F4E2(var_0, var_1) {
  var_2 = _func_00BB(self._id_F4E4, var_0)[0];
  var_3 = _func_00BB(self._id_F4E4, var_1)[0];
  var_4 = _func_00B0(self._id_F4E4, var_2, 1.0);
  var_5 = self._id_533E - self.origin;
  var_6 = var_5[2] - var_4[2];
  var_7 = _func_00B0(self._id_F4E4, var_2, var_3);
  var_8 = (var_7[0], var_7[1], var_7[2] + var_6);
  var_9 = rotatevector(var_8, self._id_F4DE);
  var_10 = self.origin + var_9;
  return var_10;
}

_id_F4EC(var_0, var_1, var_2, var_3) {
  if(var_0 == "warp_up_start") {
    scripts\engine\utility::_id_A1BC(self._id_F4E4, self._id_533E, self._id_F4DE, var_0, undefined);
  } else if(var_0 == "flex_height_up_start") {
    var_4 = _id_F4E2("flex_height_up_start", "flex_height_up_end");
    scripts\engine\utility::_id_A1BC(self._id_F4E4, var_4, self._id_F4DE, "flex_height_up_start", "flex_height_up_end");
  } else if(var_0 == "flex_height_down_start") {
    var_4 = _id_F4E2("flex_height_down_start", "flex_height_down_end");
    scripts\engine\utility::_id_A1BC(self._id_F4E4, var_4, self._id_F4DE, "flex_height_down_start", "flex_height_down_end");
  }
}

_id_38A3(var_0) {
  self waittill(var_0 + "_finished");
  self._id_533E = undefined;
  self._id_F4E4 = undefined;
  self._id_F4DE = undefined;
}

_id_4E8B(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");

  if(!self _meth_85EC()) {
    _id_4E8C(var_0, var_1, var_2);
    return;
  }

  var_3 = self _meth_8161();
  var_4 = self _meth_8160();
  self._id_532D = var_4;

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_4)) {
    return;
  }
  self._id_533E = var_4;
  self._id_F4D2 = vectornormalize(var_4 - var_3.origin);
  var_5 = undefined;
  var_5 = var_3._id_005D;

  if(var_1 == "traverse_external") {
    var_5 = var_1;
  }

  if(_id_A409(var_5)) {
    var_5 = "crawling_" + var_5;
  }

  if(!isDefined(var_5)) {
    return;
  }
  self._id_86ED = 1;
  var_6 = _id_06BE::_id_1C5D(var_0, var_5);
  var_7 = var_4 - var_3.origin;
  var_8 = (var_7[0], var_7[1], 0);
  var_9 = vectortoangles(var_8);
  var_10 = issubstr(var_5, "jump_across");
  var_11 = var_5 == "traverse_boost" && (self._id_E3D8 == "humanoid" || self._id_E3D8 == "zombie");

  if(self _meth_85EC()) {
    self _meth_82C1("face angle abs", var_9);
    self _meth_82B9("anim deltas");
  } else {
    self _meth_8251("face angle", var_9[1]);
    self _meth_8019("noclip");
  }

  var_12 = self _meth_810C(var_5, var_6);
  var_13 = "flex_height_up_start";
  var_14 = _func_00BB(var_12, var_13);

  if(var_14.size == 0) {
    var_13 = "flex_height_start";
    var_14 = _func_00BB(var_12, var_13);

    if(var_14.size == 0) {
      var_13 = "traverse_jump_start";
      var_14 = _func_00BB(var_12, var_13);
    }
  }

  var_15 = "flex_height_up_end";
  var_16 = _func_00BB(var_12, var_15);

  if(var_16.size == 0) {
    var_15 = "flex_height_end";
    var_16 = _func_00BB(var_12, var_15);

    if(var_16.size == 0) {
      var_15 = "traverse_jump_end";
      var_16 = _func_00BB(var_12, var_15);
    }
  }

  var_17 = "highest_point";
  var_18 = _func_00BB(var_12, var_17);
  var_19 = "flex_height_down_start";
  var_20 = _func_00BB(var_12, var_19);
  var_21 = "flex_height_down_end";
  var_22 = _func_00BB(var_12, var_21);
  var_23 = "crawler_early_stop";
  var_24 = _func_00BB(var_12, var_23);
  var_25 = _func_00BB(var_12, "code_move");

  if(var_25.size > 0) {
    var_26 = _func_00B0(var_12, 0, var_25[0]);
  } else {
    var_26 = _func_00B0(var_12, 0, 1);
  }

  var_27 = _id_0017::_id_68C5(var_7, var_26);
  var_28 = _func_0011(var_12, "ignoreanimscaling");

  if(var_28) {
    var_27._id_10FDD = 1.0;
  }

  if(self _meth_85EC()) {
    self _meth_82C2("noclip");
  } else {
    self _meth_8019("noclip");
  }

  var_29 = self _meth_815F();

  if(isDefined(var_29) && isDefined(var_29.target)) {
    self._id_532B = var_29;

    if(var_18.size > 0) {
      _id_0017::_id_4E88(var_5 + "_norestart", var_6, var_12, "traverse", var_13, var_17, 0, ::_id_110AF);
      var_30 = scripts\engine\utility::getstruct(self._id_532B.target, "targetname");

      if(isDefined(var_30._id_039B) && var_30._id_039B == "continue_flex_height") {
        _id_0017::_id_4E88(var_5 + "_norestart", var_6, var_12, "traverse", var_17, var_15, 1, ::_id_110AF);
      }

      if(self _meth_85EC()) {
        self _meth_82BA(1.0, 1.0);
      }

      _id_0017::_id_B356(var_5 + "_norestart", var_6, "traverse", "end", ::_id_110AF);
    } else if(var_20.size == 0) {
      _id_0017::_id_4E88(var_5 + "_norestart", var_6, var_12, "traverse", var_13, var_15, 0, ::_id_110AF);

      if(self _meth_85EC()) {
        self _meth_82BA(1.0, 1.0);
      }

      _id_0017::_id_B356(var_5 + "_norestart", var_6, "traverse", "end", ::_id_110AF);
    } else {
      var_30 = scripts\engine\utility::getstruct(self._id_532B.target, "targetname");
      var_31 = var_20[0];
      _id_0017::_id_4E89(var_5 + "_norestart", var_6, "traverse", var_12, var_13, var_15, var_30.origin, var_31, ::_id_110AF);

      if(var_20[0] - var_16[0] > 0.02) {
        if(self _meth_85EC()) {
          self _meth_82BA(1.0, 1.0);
        }

        _id_0017::_id_B356(var_5 + "_norestart", var_6, "traverse", var_19, ::_id_110AF);
      }

      var_30 = self._id_532B;
      var_31 = var_22[0];
      _id_0017::_id_4E89(var_5 + "_norestart", var_6, "traverse", var_12, var_19, var_21, var_30.origin, var_31, ::_id_110AF);

      if(self _meth_85EC()) {
        self _meth_82BA(1.0, 1.0);
      }

      if(var_24.size == 0 || !istrue(self._id_4B40)) {
        _id_0017::_id_B356(var_5 + "_norestart", var_6, "traverse", "end", ::_id_110AF);
      }
    }

    self._id_532B = undefined;
  } else if(var_20.size > 0 && var_22.size > 0 && self._id_1210 != "zombie_brute") {
    if(self _meth_85EC()) {
      self _meth_82BA(1.0, 1.0);
    }

    _id_0017::_id_B356(var_5 + "_norestart", var_6, "traverse", "end", ::_id_110AF);
  } else if(var_10 && abs(var_7[2]) < 48) {
    var_32 = _func_0079(var_12);
    var_33 = var_14[0] * var_32;
    var_34 = var_16[0] * var_32;

    if(self _meth_85EC()) {
      self _meth_82BA(1, 1);
    }

    _id_0017::_id_B354(var_5, var_6, self._id_F4EE, "traverse", var_13);

    if(self _meth_85EC()) {
      self _meth_82BA(1, 0);
    }

    childthread _id_F4DC(var_3.origin[2], var_4[2], (var_34 - var_33) / self._id_F4EE);
    _id_0017::_id_B354(var_5 + "_norestart", var_6, self._id_F4EE, "traverse", var_15);

    if(self _meth_85EC()) {
      self _meth_82BA(1, 1);
    }

    _id_0017::_id_B354(var_5 + "_norestart", var_6, self._id_F4EE, "traverse");
  } else if(var_7[2] > 16) {
    if(var_26[2] > 0) {
      if(var_11) {
        if(self _meth_85EC()) {
          self _meth_82BA(var_27._id_10FDD, var_27._id_050C);
        }

        var_35 = clamp(2 / var_27._id_050C, 0.5, 1);

        if(var_16.size > 0) {
          _id_0017::_id_B354(var_5, var_6, var_35 * self._id_F4EE, "traverse", var_15);
          _id_0017::_id_D6EC(0, "DoTraverse");
          var_36 = var_5 + "_norestart";
          _id_0017::_id_D14E(var_36, var_6, self._id_F4EE);
          _id_0017::_id_10981("traverse", "code_move");
        } else
          _id_0017::_id_B354(var_5, var_6, self._id_F4EE, "traverse");

        if(self _meth_85EC()) {
          self _meth_82BA(1, 1);
        }
      } else if(var_14.size > 0) {
        var_27._id_10FDD = 1;
        var_27._id_050C = 1;

        if(!var_28 && _func_0134(var_8) < 0.64 * _func_0134(var_26)) {
          var_27._id_10FDD = 0.4;
        }

        if(self _meth_85EC()) {
          self _meth_82BA(var_27._id_10FDD, var_27._id_050C);
        }

        _id_0017::_id_B354(var_5, var_6, self._id_F4EE, "traverse", var_13);
        var_37 = _func_00B0(var_12, 0, var_14[0]);
        var_38 = _func_00B0(var_12, 0, var_16[0]);
        var_27._id_10FDD = 1;
        var_27._id_050C = 1;
        var_39 = var_4 - self.origin;
        var_40 = var_26 - var_37;

        if(!var_28 && _func_0134(var_39) < 0.5625 * _func_0134(var_40)) {
          var_27._id_10FDD = 0.75;
        }

        var_41 = var_26 - var_38;
        var_42 = (var_41[0] * var_27._id_10FDD, var_41[1] * var_27._id_10FDD, var_41[2] * var_27._id_050C);
        var_43 = rotatevector(var_42, var_9);
        var_44 = var_4 - var_43;
        var_45 = var_38 - var_37;
        var_46 = rotatevector(var_45, var_9);
        var_47 = var_44 - self.origin;
        var_48 = var_27;
        var_27 = _id_0017::_id_68C5(var_47, var_46, 1);

        if(var_28) {
          var_27._id_10FDD = 1.0;
        }

        if(var_47[2] <= 0) {
          var_27._id_050C = 0.0;
        }

        if(self _meth_85EC()) {
          self _meth_82BA(var_27._id_10FDD, var_27._id_050C);
        }

        _id_0017::_id_10981("traverse", var_15);
        _id_0017::_id_D6EC(0, "DoTraverse");
        var_27 = var_48;

        if(self _meth_85EC()) {
          self _meth_82BA(var_27._id_10FDD, var_27._id_050C);
        }

        _id_0017::_id_10981("traverse", "code_move");
      } else {
        if(self _meth_85EC()) {
          self _meth_82BA(var_27._id_10FDD, var_27._id_050C);
        }

        _id_0017::_id_B354(var_5, var_6, self._id_F4EE, "traverse");
      }
    } else
      _id_0017::_id_4E88(var_5 + "_norestart", var_6, var_12, "traverse", "flex_height_start", "flex_height_end", 1, ::_id_110AF);
  } else if(abs(var_7[2]) < 16 || var_26[2] == 0) {
    if(self _meth_85EC()) {
      self _meth_82BA(var_27._id_10FDD, var_27._id_050C);
    }

    var_35 = clamp(2 / var_27._id_050C, 0.5, 1);

    if(var_16.size > 0) {
      _id_0017::_id_B354(var_5, var_6, var_35 * self._id_F4EE, "traverse", var_15);
      _id_0017::_id_D6EC(0, "DoTraverse");
      var_36 = var_5 + "_norestart";
      _id_0017::_id_D14E(var_36, var_6, self._id_F4EE);
      _id_0017::_id_10981("traverse", "code_move");
    } else
      _id_0017::_id_B354(var_5, var_6, self._id_F4EE, "traverse");

    if(self _meth_85EC()) {
      self _meth_82BA(1, 1);
    }
  } else if(var_26[2] < 0) {
    if(self _meth_85EC()) {
      self _meth_82BA(var_27._id_10FDD, var_27._id_050C);
    }

    var_35 = clamp(2 / var_27._id_050C, 0.5, 1);
    var_50 = var_5 + "_norestart";

    if(var_14.size > 0) {
      _id_0017::_id_B354(var_5, var_6, self._id_F4EE, "traverse", var_13);
      var_5 = var_50;
    }

    if(var_16.size > 0) {
      _id_0017::_id_B354(var_5, var_6, var_35 * 1.0, "traverse", var_15);
      _id_0017::_id_D14E(var_50, var_6, self._id_F4EE);

      if(_func_0011(var_12, "removestatelock")) {
        _id_0017::_id_10981("traverse", "removestatelock");
      }

      _id_0017::_id_D6EC(0, "DoTraverse");
      _id_0017::_id_10981("traverse", "code_move");
    } else
      _id_0017::_id_B354(var_5, var_6, 1.0, "traverse");

    if(self _meth_85EC()) {
      self _meth_82BA(1, 1);
    }
  } else {}

  _id_91DD();

  if(self _meth_85EC()) {
    self _meth_82C2("gravity");
  }

  self._id_86ED = undefined;
  self notify("traverse_end");
  _id_F09F(var_0, var_1);
}

_id_F4DC(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_3 = gettime();

  for(;;) {
    var_4 = (gettime() - var_3) / 1000.0;
    var_5 = var_4 / var_2;

    if(var_5 > 1.0) {
      break;
    }

    var_6 = _id_0B05::_id_91A9(var_5, var_0, var_1);
    self setorigin((self.origin[0], self.origin[1], var_6), 0);
    wait 0.05;
  }
}

_id_A409(var_0) {
  if(istrue(self._id_4B40)) {
    return 1;
  }

  return 0;
}

_id_91DD() {
  var_0 = 0.1;
  var_1 = self._id_533E;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1[2];
  var_3 = self.origin[2];

  if(var_3 < var_2) {
    self setorigin((self.origin[0], self.origin[1], var_2 + var_0), 0);
  }
}

_id_F0A2(var_0, var_1, var_2) {
  self._id_86ED = undefined;
}

_id_F09F(var_0, var_1) {
  if(!self _meth_85EC()) {
    self _meth_85F9();
  }

  self _meth_85CA(var_0, "choose_movetype");
  self notify("killanimscript");
}

_id_1107C(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_0009::_id_1C9F(self._id_A254);
  self _meth_8019("normal");
  self _meth_8251("face motion");
  self._id_1C30._id_4130 = var_2;
  thread _id_08F1::_id_10800(var_0, var_1, 1);
  _id_0AED::_id_B89B(var_0, var_1, var_2);
  _id_0009::_id_1C9F(1);
}

_id_11079(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self _meth_8019("zonly_physics");
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);
  self _meth_8251("face angle", var_3._id_01BF[1]);
  thread _id_5B13(var_1 + "_finished");
  _id_0AEB::_id_B31D(var_0, var_1, var_2);
  self notify("FinishArrivalAnim");
}

_id_5B13(var_0) {
  self endon("death");
  scripts\engine\utility::_id_108B4(var_0, "FinishArrivalAnim");
  self _meth_8616();
}

_id_1107A(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_0009::_id_1C9F(self._id_A254);
  _id_0AEC::_id_B32B(var_0, var_1, var_2);
  _id_0009::_id_1C9F(1);
}

_id_1107F(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_0009::_id_1C9F(self._id_A254);
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);
  self._id_D9BC = undefined;
  self _meth_8019("zonly_physics", 0);
  self _meth_8251("face current");
  _id_06BE::_id_1C89(var_0, var_1, var_3, self._id_A246, "code_move");
  self _meth_8019("normal", 0);
  self _meth_8251("face motion");
  _id_0009::_id_1C9F(self._id_A254);
}

_id_11080(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  _id_0009::_id_1C9F(self._id_A254);
  _id_1107F(var_0, var_1, var_2);
  _id_0009::_id_1C9F(self._id_A254);
}

_id_110AF(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "apply_physics":
      if(self _meth_85EC()) {
        self _meth_82C2("gravity");
      } else {
        self _meth_8019("gravity");
      }

      break;
    default:
      break;
  }
}

_id_5F67(var_0, var_1, var_2) {
  var_1 = self._id_5F65;
  level thread[[level._id_5FE8]](self);
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);

  if(istrue(self._id_0EEF)) {
    _id_06BE::_id_1C88(var_0, var_1, 0.1, var_3, 0.2);
  } else {
    _id_06BE::_id_1C88(var_0, var_1, 0.1, var_3, 0.001);
  }
}

_id_3506(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_8873)) {
    if(isDefined(var_3)) {
      self._id_5F65 = var_3;
    } else {
      self._id_5F65 = _id_0009::_id_1C5F(var_0);
    }

    return 1;
  }

  return 0;
}

_id_3511(var_0, var_1, var_2, var_3) {
  if(!istrue(self._id_8873)) {
    self._id_5F65 = undefined;
    return 1;
  }

  return 0;
}

_id_52F5(var_0, var_1, var_2) {
  self._id_5F65 = undefined;
  level thread[[level._id_F0EC]](self);
}

_id_8B1E(var_0, var_1, var_2, var_3) {
  if(self _meth_85EC()) {
    if(self _meth_84E5(200)) {
      return 1;
    }
  }

  return 0;
}

_id_3180(var_0, var_1, var_2) {
  var_3 = 0.5;
  var_4 = _func_00BB(var_0, "turn_extent");

  if(var_4.size == 1) {
    var_3 = var_4[0];
  } else {
    var_5 = _func_00BB(var_0, "code_move");

    if(var_5.size == 1) {
      var_3 = var_5[0] * 0.5;
    }
  }

  var_6 = 1.0;
  var_7 = _func_00BB(var_0, "finish");

  if(var_7.size == 0) {
    var_7 = _func_00BB(var_0, "end");
  }

  if(var_7.size == 1) {
    var_6 = var_7[0];
  }

  var_8 = _func_00B0(var_0, 0.0, var_3);
  var_9 = _func_00B0(var_0, 0.0, var_6);
  var_10 = self.origin;
  var_11 = rotatevector(var_8, var_1) + var_10;
  var_12 = rotatevector(var_9, var_1) + var_10;

  if(!_func_02A8(var_11, var_12, self)) {
    return 0;
  }

  var_13 = self._id_0359;

  if(!var_2) {
    var_13 = self._id_0359 / 2;
  }

  if(!_id_06E0::_id_3199(var_10, var_11, 0, var_13)) {
    return 0;
  }

  return 1;
}

_id_5A03(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_8595)) {
    return 1;
  }

  return 0;
}

_id_8809(var_0, var_1, var_2, var_3) {
  if(_id_5A03(var_0, var_1, var_2, var_3)) {
    return 0;
  }

  self._id_26B5 = undefined;
  return 1;
}

_id_B36E(var_0, var_1, var_2) {
  if(self _meth_85EC()) {
    self _meth_82C1("face angle abs", self._id_4813);
  } else {
    self _meth_8251("face angle", self._id_4813[1]);
  }

  _id_0009::_id_1C81(var_0, var_1, 1, 0);
}

_id_35D6(var_0, var_1, var_2) {
  if(isDefined(self._id_26B5)) {
    return self._id_26B5;
  }

  if(self._id_4B40) {
    _id_D178();
    self._id_26B5 = _id_0009::_id_1C7D(var_1, "boombox_dance_crawl_" + level._id_26B2);
    return self._id_26B5;
  } else if(istrue(self._id_855F)) {
    self._id_26B5 = _id_0009::_id_1C7D(var_1, "disco_dance_center_" + randomintrange(0, 4));
    return self._id_26B5;
  } else {
    _id_D179();
    self._id_26B5 = _id_0009::_id_1C7D(var_1, "boombox_dance_" + level._id_26B3);
    return self._id_26B5;
  }
}

_id_D179() {
  if(!isDefined(level._id_26B3)) {
    level._id_26B3 = 0;
  }

  level._id_26B3++;

  if(level._id_26B3 > 5) {
    level._id_26B3 = 0;
  }
}

_id_D178() {
  if(!isDefined(level._id_26B2)) {
    level._id_26B2 = 0;
  }

  level._id_26B2++;

  if(level._id_26B2 > 1) {
    level._id_26B2 = 0;
  }
}

_id_A407(var_0, var_1, var_2, var_3) {
  return 0;
}

_id_362E(var_0, var_1, var_2) {
  if(istrue(self._id_FD9B)) {
    return _id_0009::_id_1C7D(var_1, "upgraded");
  } else {
    return _id_0009::_id_1C7D(var_1, "normal");
  }
}

_id_82B0(var_0, var_1, var_2, var_3) {
  return 0;
}

_id_A40D(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_5523)) {
    return 0;
  }

  if(!istrue(self._id_25BE) || istrue(self._id_54D1)) {
    return 0;
  }

  if(!isDefined(level._id_5D4B)) {
    return 0;
  }

  if(!isDefined(self._id_39EA)) {
    self._id_39EA = [[level._id_5D4B]](self.origin);

    if(!isDefined(self._id_39EA)) {
      iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
      return 0;
    }
  } else if(!_id_06BD::_id_23E5()) {
    if(!isDefined(self._id_39EA)) {
      self._id_4982 = 1;
      self dodamage(self.health + 950, self.origin, self, self, "MOD_SUICIDE");
      return 0;
    }
  }

  if(self _meth_85EC()) {
    self _meth_82BF(4);
    self _meth_82BE(self._id_39EA.origin);
  } else {
    self._id_0201 = 4;
    self _meth_8326(self._id_39EA.origin);
  }

  if(!_id_06BD::_id_23E5()) {
    return 0;
  }

  self._id_5523 = self._id_39EA;
  self._id_39EA = undefined;
  return 1;
}

_id_35F9(var_0, var_1, var_2) {
  if(isDefined(self._id_54EB)) {
    return self._id_54EB;
  }

  var_3 = self._id_1DC9;
  var_4 = undefined;

  if(!isDefined(var_3._id_CD99)) {
    var_4 = "mid";
  } else {
    var_4 = var_3._id_CD99;
  }

  if(istrue(var_3._id_24DE)) {
    var_4 = var_4 + "_extended";
  }

  self._id_54EB = _id_0009::_id_1C7D(var_1, var_4);
  return self._id_54EB;
}

_id_35D2(var_0, var_1, var_2) {
  var_3 = self._id_1DC9;
  var_4 = "standing_";

  if(_id_A40B()) {
    var_4 = "crawling_";
  }

  if(!isDefined(var_3._id_CD99)) {
    var_4 = var_4 + "mid";
  } else {
    var_4 = var_4 + var_3._id_CD99;
  }

  return _id_0009::_id_1C7D(var_1, var_4);
}

_id_F086(var_0, var_1, var_2) {}

_id_35E5(var_0, var_1, var_2) {}

_id_D29C() {}

_id_3642(var_0, var_1, var_2) {
  if(self._id_4B40) {
    return _id_0009::_id_1C7D(var_1, "crawling");
  } else {
    return _id_0009::_id_1C7D(var_1, "standing");
  }
}

_id_4868(var_0, var_1, var_2, var_3) {}

_id_866F(var_0, var_1) {
  var_2 = 2304;
  return distancesquared(var_0.origin, var_1.origin) < var_2;
}

_id_1DF6(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\engine\utility::_id_6969(self.origin, level._id_417B);

    if(_id_866F(self._id_39E5, var_4)) {
      _id_0908::_id_4D17(self._id_39E5, 45, "MOD_IMPACT");
    }
  }
}

_id_B362(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(self _meth_85EC()) {
    self _meth_82C1("face angle abs", self._id_1DC9.angles);
  } else {
    self _meth_8251("face angle", self._id_1DC9.angles[1]);
  }

  _id_0009::_id_1C87(var_0, var_1, var_2);
}

_id_B389(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(self _meth_85EC()) {
    self _meth_82C1("face angle abs", self._id_1DC9.angles);
  } else {
    self _meth_8251("face angle", self._id_1DC9.angles[1]);
  }

  _id_0009::_id_1C87(var_0, var_1, var_2);
}

_id_54EA(var_0, var_1, var_2) {}

_id_A156() {}

_id_FE39(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_1DC9.target)) {
    return 0;
  }

  var_4 = _func_00B3(self._id_1DC9.target, "targetname");

  if(!isDefined(var_4) || var_4.size == 0) {
    return 0;
  }

  var_5 = var_4[0];

  if(!isDefined(var_5) || !isDefined(var_5._id_005D)) {
    return 0;
  }

  var_4 = _func_00B3(var_5.target, "targetname");

  if(!isDefined(var_4) || var_4.size == 0) {
    return 0;
  }

  var_6 = var_4[0];

  if(self _meth_85EC()) {
    self _meth_82BE(var_6.origin);
  } else {
    self _meth_8326(var_6.origin);
  }

  self._id_5524 = 0;
  thread _id_A156();
  return 1;
}

_id_A155() {}

_id_4EAE(var_0, var_1, var_2, var_3) {}

_id_C070(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_5524)) {
    return 1;
  }

  return 0;
}

_id_A40C(var_0, var_1, var_2, var_3) {}

_id_11076(var_0, var_1, var_2, var_3) {
  _id_06BD::_id_23B0();
  return 1;
}

_id_DB53(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_1C30._id_4130)) {
    return 0;
  }

  switch (self._id_1C30._id_4130) {
    case "slow_walk":
    case "walk":
      return 0;
  }

  return 1;
}

_id_DB01(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_5D4C)) {
    return 0;
  }

  if(_id_A40B()) {
    return 0;
  }

  var_4 = "mid";

  if(isDefined(self._id_1DC9._id_CD99)) {
    var_4 = self._id_1DC9._id_CD99;
  }

  self._id_39E5 = [[level._id_5D4C]](self);

  if(!isDefined(self._id_39E5)) {
    return 0;
  }

  if(randomint(100) > 50) {
    return 0;
  }

  return 1;
}

_id_8AFF(var_0, var_1, var_2, var_3) {
  if(istrue(level._id_24F0)) {
    return 1;
  }

  if(istrue(self._id_2DEB)) {
    return 1;
  }

  return 0;
}

_id_880A(var_0, var_1, var_2, var_3) {
  return !_id_8AFF(var_0, var_1, var_2, var_3);
}

_id_363B(var_0, var_1, var_2) {
  var_3 = "standing";

  if(_id_A40B()) {
    var_3 = "crawling";
  }

  return _id_0009::_id_1C7D(var_1, var_3);
}

_id_DB76(var_0, var_1, var_2, var_3) {
  return _id_0908::_id_109CE() && !istrue(self._id_EAAB);
}

_id_DB88(var_0, var_1, var_2, var_3) {
  if(self._id_7598) {
    if(_id_06BD::_id_23E5()) {
      return 1;
    }

    if(isDefined(self._id_03E9) && isDefined(self._id_03E9._id_CC9D) && self._id_03E9._id_CC9D == "spawn_wall_low") {
      return 1;
    }
  }

  return 0;
}

_id_DBF6(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_1C30.stumblecooldownexpiretime) && gettime() < self._id_1C30.stumblecooldownexpiretime) {
    return 0;
  }

  return isDefined(self._id_0148) && _id_8919(self._id_0148);
}

choosestumbleanim(var_0, var_1, var_2) {
  return _id_0009::_id_1C7D(var_1, self._id_0B67._id_02D7);
}

playstumbleanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);

  if(isDefined(var_3)) {
    var_4 = self _meth_810C(var_1, var_3);

    if(isDefined(var_4)) {
      var_5 = _func_0079(var_4);

      if(isDefined(self._id_A5AC) && self._id_A5AC > 0) {
        var_5 = var_5 * (1 / self._id_A5AC);
      }

      self._id_1C30.stumblecooldownexpiretime = gettime() + (var_5 + 5) * 1000;
      _id_0017::_id_B354(var_1, var_3, self._id_A5AC, "pain_anim");
    }
  }
}