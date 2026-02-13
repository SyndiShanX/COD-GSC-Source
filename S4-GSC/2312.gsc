/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2312.gsc
*************************************************/

_id_109CE(var_0, var_1, var_2, var_3) {
  if(_id_06BD::_id_23E3()) {
    return 1;
  }

  return 0;
}

_id_109C8() {
  return 0;
}

_id_109C9(var_0, var_1, var_2, var_3) {
  if(!_id_06BD::_id_23E5()) {
    return 0;
  }

  if(!isDefined(self._id_9D92)) {
    return 0;
  }

  if(!isDefined(self._id_012F)) {
    return 0;
  }

  var_4 = self._id_012F.origin - self.origin;
  var_5 = length(var_4);

  if(var_5 >= self._id_1DF5) {
    var_4 = var_4 / var_5;
    var_6 = _id_0B05::_id_6B52(self._id_012F);

    if(!self _meth_8009(self.origin, var_6.origin, self._id_0359, self.height, 0)) {
      return 0;
    }
  }

  return 1;
}

_id_109CA(var_0, var_1, var_2, var_3) {
  if(_id_0907::_id_8931() && _id_0907::_id_8930()) {
    return 0;
  }

  if(istrue(self._id_0B67._id_9D90)) {
    return 1;
  }

  return 0;
}

_id_DB99() {
  if(isDefined(self._id_1210) && self._id_1210 == "zombie_brute") {
    return 0;
  }

  if(isDefined(self._id_012F) && self._id_012F.health < 91) {
    return 0;
  }

  if(isDefined(level._id_10C9F) && level._id_10C9F < 10) {
    return 0;
  }

  var_0 = _id_0907::_id_8931();
  var_1 = _id_0907::_id_8930();
  var_2 = !(var_1 || var_0);
  var_3 = randomint(100) < 2;
  return var_2 && var_3;
}

_id_35D1(var_0, var_1, var_2) {
  var_3 = _id_0907::_id_8931();
  var_4 = _id_0907::_id_8930();
  var_5 = var_3 && var_4;
  var_6 = !(var_4 || var_3);
  var_7 = self _meth_810F(var_1);

  if(var_6) {
    return randomint(var_7);
  }

  if(var_5) {
    return 0;
  }

  var_8 = int(var_7 / 2);

  if(var_3) {
    return randomint(var_8);
  }

  return var_8 + randomint(var_8);
}

_id_B886(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  var_3 = _id_6E27(self._id_012F, 1);
  _id_4C3F(var_0, var_1, self._id_012F, var_3, 1, 1, 1);

  while(istrue(self._id_8873)) {
    waitframe();
  }

  _id_0009::_id_1C53(var_0, "end");
}

_id_B898(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  var_3 = _id_06BD::_id_23C0();
  self._id_9D92 = undefined;
  var_4 = _id_6E27(var_3, 1);
  self._id_AF99 = 1;
  self._id_13E7 = "melee";
  _id_4C3F(var_0, var_1, var_3, var_4, 0, 1);

  while(istrue(self._id_8873)) {
    waitframe();
  }

  _id_0009::_id_1C53(var_0, "end");
}

_id_B8F7(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  var_3 = _id_06BD::_id_23C0();
  var_4 = _id_6E27(var_3, 1);
  self._id_13E7 = "melee";
  _id_4C3F(var_0, var_1, var_3, var_4, 0, 1);

  while(istrue(self._id_8873)) {
    waitframe();
  }

  _id_0009::_id_1C53(var_0, "end");
}

attackterminate(var_0, var_1, var_2) {
  self._id_13E7 = var_2;
}

_id_10983(var_0, var_1, var_2, var_3) {
  var_4 = max(0.01, self._id_A5AC);
  var_5 = _func_00BB(var_1, "finish");
  var_6 = 0.9;

  if(var_5.size > 0) {
    var_6 = var_5[0];
  }

  var_7 = var_2 / var_4 * var_6;
  var_8 = var_7 - var_3;

  if(var_8 > 0) {
    _id_0017::_id_10981(var_0, "end", var_8);
  }
}

_id_B8C3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self _meth_810C(var_1, var_2);
  var_6 = _func_0079(var_5);
  var_7 = max(0.01, self._id_A5AC);
  var_8 = _func_00BB(var_5, "gutgrab");
  var_9 = var_6 / var_7 * var_8[0];
  var_10 = self _meth_8880(var_1);

  if(!isDefined(var_10)) {
    var_10 = var_1;
  }

  if(isDefined(self._id_012F)) {
    thread _id_587F(var_1, self._id_012F, 15);
  }

  self _meth_8019("zonly_physics");
  _id_0017::_id_D14E(var_1, var_2, self._id_A5AC);

  if(var_8.size > 0) {
    _id_0017::_id_10980(var_10, "gutgrab");
  } else {
    wait(var_9);
  }

  self._id_BD9D = "c_t9_zmb_gore_chunk_03";
  self._id_BD9C = var_3;
  self attach(self._id_BD9D, self._id_BD9C);
  _id_10983(var_10, var_5, var_6, var_9);
}

_id_B8C4(var_0, var_1, var_2, var_3) {
  var_4 = self _meth_810C(var_1, var_2);
  var_5 = _func_0079(var_4);
  var_6 = max(0.01, self._id_A5AC);
  var_7 = _func_00BB(var_4, "gutgo");
  var_8 = var_5 / var_6 * var_7[0];
  var_9 = self _meth_8880(var_1);

  if(!isDefined(var_9)) {
    var_9 = var_1;
  }

  _id_0017::_id_D14E(var_1, var_2, self._id_A5AC);
  _id_E90A();

  if(isDefined(self._id_012F)) {
    if(_func_011D(self._id_012F)) {
      var_10 = self._id_012F getEye();
    } else {
      var_10 = self._id_012F.origin + (0, 0, 45);
    }

    var_11 = var_10[2] - self._id_012F.origin[2];
    var_12 = self._id_012F.origin + (0, 0, randomfloatrange(0.5, 1) * var_11);
  } else
    var_12 = self.origin + anglesToForward(self.angles) * 400 + (0, 0, randomfloatrange(25, 55));

  if(var_7.size > 0) {
    _id_0017::_id_10980(var_9, "gutgo");
  } else {
    wait(var_8);
  }

  _id_06BD::_id_23AF();
  self _meth_8251("face angle", self.angles[1]);
  self _meth_8019("zonly_physics");
  thread _id_5BA1(var_12);
  _id_10983(var_9, var_4, var_5, var_8);
}

_id_5BA1(var_0) {
  var_1 = 1000;
  var_2 = 5;

  if(isDefined(self._id_BD9D)) {
    self detach(self._id_BD9D, self._id_BD9C);
    self._id_BD9D = undefined;
  }

  var_3 = self gettagorigin(self._id_BD9C);
  var_4 = var_0 - var_3;
  var_5 = length((var_4[0], var_4[1], 0)) / var_1;

  if(var_5 == 0) {
    return;
  }
  var_6 = getdvarfloat("#x33c01342f08fa6256");
  var_7 = (0.5 * var_6 * _func_0219(var_5) + var_4[2]) / var_5;
  var_4 = vectornormalize((var_4[0], var_4[1], 0));
  var_8 = (var_4[0] * var_1, var_4[1] * var_1, var_7);
  var_9 = magicgrenademanual("zombie_ranged_attack_mp", var_3, var_8, var_2, self);
  var_9.angles = self gettagangles(self._id_BD9C);
  var_9 thread _id_B848();
  level thread trackgrenadeprojectile(var_9);
}

_id_B848() {
  self playLoopSound("zmb_gut_projectile_lp");
  self waittill("death");

  if(!_func_0458(self)) {
    self stoploopsound();
    playsoundatpos(self.origin, "zmb_gut_projectile_impact");
  }
}

trackgrenadeprojectile(var_0) {
  level.aigutprojectiles = scripts\cp\utility::_id_459B(level.aigutprojectiles, []);
  level.aigutprojectiles = scripts\engine\utility::array_add(level.aigutprojectiles, var_0);
  var_0 waittill("death");
  level.aigutprojectiles = scripts\engine\utility::array_remove(level.aigutprojectiles, var_0);
}

_id_B8C2(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  self._id_13E7 = "melee";
  self._id_0B67.isthrowingguts = 1;
  thread _id_7486(var_0, var_1);
  var_3 = [];

  if(!_id_0907::_id_8930()) {
    var_4 = var_3.size;
    var_3[var_4]["animIndex"] = 0;
    var_3[var_4]["tag"] = "tag_accessory_left";
  }

  if(!_id_0907::_id_8931()) {
    var_4 = var_3.size;
    var_3[var_4]["animIndex"] = 2;
    var_3[var_4]["tag"] = "tag_accessory_right";
  }

  var_5 = scripts\engine\utility::random(var_3);
  thread _id_09A5::_id_B313(self, "zmb_gut_throw", 0);
  _id_B8C3(var_0, var_1, var_5["animIndex"], var_5["tag"], var_2);
  _id_B8C4(var_0, var_1, var_5["animIndex"] + 1, var_2);
  self notify("ranged_attack_done");

  while(istrue(self._id_8873)) {
    waitframe();
  }

  _id_0009::_id_1C53(var_0, "end");
}

_id_7486(var_0, var_1) {
  scripts\engine\utility::_id_10882(var_1 + "_finished", "death", "ranged_attack_done", "terminate_ai_threads");

  if(isDefined(self)) {
    self._id_13E7 = "idle";
    self._id_9035 = gettime();

    if(isDefined(self._id_0B67)) {
      _id_06BD::_id_23AF();
      self._id_0B67.isthrowingguts = 0;
    }

    _id_E90A();

    if(isDefined(self._id_BD9D)) {
      self detach(self._id_BD9D, self._id_BD9C);
    } else if(!isalive(self)) {
      self _meth_809E();
    }

    self._id_BD9D = undefined;
    self._id_BD9C = undefined;
  }
}

_id_B1DF(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  var_3 = _id_06BD::_id_23C0();
  var_4 = _id_6E27(var_3, 1);
  self._id_13E7 = "melee";
  _id_4C3F(var_0, var_1, var_3, var_4, 0, 1, 0, 1);

  while(istrue(self._id_8873)) {
    waitframe();
  }

  _id_0009::_id_1C53(var_0, "end");
}

_id_2414(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_0B67._id_2C5D) && self._id_0B67._id_2C5D;
}

_id_109CF() {
  if(_id_2414()) {
    return 1;
  }

  return 0;
}

_id_109D0() {
  return istrue(self._id_DABE);
}

_id_B8FC(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");

  if(isDefined(self._id_1210) && self._id_1210 == "skater") {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_skater_pre_explo");
  } else {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_clown_pre_explo");
  }

  var_3 = _id_06BE::_id_1C5D(var_0, var_1);
  _id_0017::_id_B353(var_1, var_3, 2.0, var_1, "explode");

  if(isDefined(self._id_1210) && self._id_1210 != "skater") {
    playsoundatpos(self gettagorigin("tag_eye"), "zmb_vo_clown_death");
  }

  wait 0.25;
  self _meth_83F8();
  self._id_A546 = 1;
  self suicide();
}

_id_B904(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  self._id_DABE = undefined;
  var_3 = _id_06BE::_id_1C5D(var_0, var_1);
  _id_0017::_id_B356(var_1, var_3, var_1);
}

_id_587D(var_0, var_1) {
  self endon(var_0 + "_finished");
  self notify("stop_melee_face_enemy");
  self endon("stop_melee_face_enemy");

  for(;;) {
    if(isDefined(var_1) && isalive(var_1)) {
      if(self _meth_85EC()) {
        self _meth_82C1("face angle abs", (0, _func_0261(var_1.origin - self.origin), 0));
      } else {
        self _meth_8251("face angle", _func_0261(var_1.origin - self.origin), 1);
      }
    } else
      break;

    waitframe();
  }
}

_id_587F(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  self notify("stop_melee_face_enemy");
  self endon("stop_melee_face_enemy");

  for(;;) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_3 = self.angles[1];
      var_4 = _func_0261(var_1.origin - self.origin);
      var_5 = _func_000B(var_4 - var_3);

      if(abs(var_5) < var_2) {
        var_6 = var_4;
      } else {
        var_7 = var_5 / abs(var_5);
        var_6 = var_3 + var_7 * var_2;
      }

      self _meth_8251("face angle", var_6, 1);
    } else
      break;

    waitframe();
  }
}

_id_E90A() {
  self notify("stop_melee_face_enemy");
}

_id_4C3F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon(var_1 + "_finished");
  self endon("death");
  self endon("terminate_ai_threads");
  self._id_9011 = undefined;
  self._id_9012 = undefined;

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = _id_06BE::_id_1C5D(var_0, var_1);
  var_9 = self _meth_810C(var_1, var_8);
  var_10 = _func_0079(var_9);
  var_11 = max(0.01, self._id_A5AC);
  var_12 = _func_00BB(var_9, "hit");
  var_13 = var_10 / var_11 * 0.33;

  if(var_12.size > 0) {
    var_13 = var_10 / var_11 * var_12[0];
  }

  var_14 = self _meth_8880(var_1);

  if(!isDefined(var_14)) {
    var_14 = var_1;
  }

  if(self _meth_85EC()) {
    self _meth_82C2("gravity");
  }

  if(var_5 && isDefined(self._id_012F)) {
    thread _id_587D(var_1, self._id_012F);
  } else if(isDefined(var_2)) {
    if(self _meth_85EC()) {
      self _meth_82C1("face angle abs", (0, _func_0261(var_2.origin - self.origin), 0));
    } else {
      self _meth_8251("face angle", _func_0261(var_2.origin - self.origin));
    }
  } else if(self _meth_85EC())
    self _meth_82C1("face angle abs", self.angles);
  else {
    self _meth_8251("face angle", self.angles[1]);
  }

  if(self _meth_85EC()) {
    self _meth_82B9("anim deltas");
  } else {
    self _meth_8019(scripts\engine\utility::ter_op(istrue(self._id_86F2), "gravity_off_nav", "zonly_physics"));
  }

  _id_0017::_id_D14E(var_1, var_8, self._id_A5AC);

  if(var_6) {
    var_15 = _func_00BB(var_9, "lunge_start");
    var_16 = 0;

    if(var_15.size > 0) {
      var_16 = var_10 / var_11 * var_15[0];
    }

    var_13 = var_13 - var_16;

    if(var_16 > 0) {
      wait(var_16);
    }

    if(self._id_9910) {
      var_17 = var_3 - self.origin;
      var_18 = _func_00B0(var_9, var_15[0], var_12[0]);
      var_19 = _id_0017::_id_68C5(var_17, var_18);
      var_11 = var_11 * clamp(1 / var_19._id_10FDD, 0.5, 1);
      var_13 = var_10 / var_11 * var_12[0] - var_10 / var_11 * var_15[0];
      _id_0017::_id_D14E(var_1 + "_norestart", var_8, self._id_A5AC);
    }
  }

  if(var_4) {
    if(self _meth_85EC()) {
      self _meth_82BA(0, 1);
      self _meth_82B3(self.origin, var_3, var_13);
      childthread _id_FCA8(var_2, var_13, 1, self._id_9914);
      _id_0017::_id_D6EC(1, "DoAttack");
    } else {}
  } else if(self _meth_85EC())
    self _meth_82BA(1, 1);

  if(var_12.size > 0) {
    _id_0017::_id_10980(var_14, "hit");
  } else {
    wait(var_13);
  }

  _id_06BD::_id_23AF();
  self notify("cancel_updatelerppos");

  if(var_5 && isDefined(self._id_012F)) {
    thread _id_587D(var_1, self._id_012F);
  } else {
    _id_E90A();

    if(isDefined(var_2)) {
      if(self _meth_85EC()) {
        self _meth_82C1("face angle abs", (0, _func_0261(var_2.origin - self.origin), 0));
      } else {
        self _meth_8251("face angle", _func_0261(var_2.origin - self.origin));
      }
    } else if(self _meth_85EC())
      self _meth_82C1("face angle abs", self.angles);
    else {
      self _meth_8251("face angle", self.angles[1]);
    }
  }

  if(self _meth_85EC()) {
    self _meth_82B9("anim deltas");
    self _meth_82BA(1, 1);
  } else
    self _meth_8019(scripts\engine\utility::ter_op(istrue(self._id_86F2), "gravity_off_nav", "zonly_physics"));

  if(var_4) {
    _id_0017::_id_D6EC(0, "DoAttack");
  }

  if(_id_1DF9(var_2)) {
    self notify("attack_hit", var_2, var_3);
    var_20 = 0;

    if(isDefined(var_2)) {
      var_20 = _id_659A(var_2);
    }

    if(isDefined(self._id_9D7E)) {
      var_20 = self._id_9D7E;
    }

    if(isDefined(var_7)) {
      thread _id_CFC7(var_2, var_3, 0.5);
    }

    if(isalive(var_2)) {
      _id_4D17(var_2, var_20, "MOD_IMPACT");
    }

    var_21 = scripts\engine\utility::_id_1BAB(self._id_42EF, var_2);

    if(!isDefined(var_21)) {
      self._id_42EF[self._id_42EF.size] = var_2;
    }

    level notify("attack_hit", self, var_2);
  } else
    self notify("attack_miss", var_2, var_3);

  self._id_9014 = self.origin;
  var_11 = max(0.01, self._id_A5AC);
  var_22 = _func_00BB(var_9, "finish");
  var_23 = 0.9;

  if(var_22.size > 0) {
    var_23 = var_22[0];
  }

  var_24 = var_10 / var_11 * var_23;
  var_25 = var_24 - var_13;

  if(var_25 > 0) {
    _id_0017::_id_10981(var_1, "end", var_25);
  }

  self._id_9013 = gettime();
}

_id_CFC7(var_0, var_1, var_2) {
  self endon("death");
  wait(var_2);

  if(_id_1DF9(var_0)) {
    self notify("attack_hit", var_0, var_1);
    var_3 = 0;

    if(isDefined(var_0)) {
      var_3 = _id_659A();
    }

    if(isDefined(self._id_9D7E)) {
      var_3 = self._id_9D7E;
    }

    if(isalive(var_0)) {
      _id_4D17(var_0, var_3, "MOD_IMPACT");
    }

    level notify("attack_hit", self, var_0);
  } else
    self notify("attack_miss", var_0, var_1);
}

_id_659A(var_0) {
  var_1 = 0;

  if(self._id_1210 == "zombie_brute") {
    var_1 = 90;
  } else if(isDefined(self._id_110B0) && isDefined(self._id_9D80)) {
    var_1 = self._id_9D80;
  } else {
    var_1 = 20;
  }

  if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    var_1 = var_1 * 10;
  }

  if(isDefined(var_0._id_5562) && var_0._id_5562 == "equip_tac_cover") {
    var_1 = var_1 * 10;
  }

  return var_1;
}

_id_4D17(var_0, var_1, var_2) {
  if(scripts\cp\utility::isprotectedbyriotshieldcp(var_0)[0]) {
    var_3 = var_1;
    var_1 = int(scripts\cp\utility::get_riot_shield_melee_damage_percent() * var_1);
    var_4 = var_3 - var_1;
    _id_070F::createabsorbdamageevent(var_0, self, var_2, var_4);
  }

  if(isPlayer(var_0)) {
    var_0 thread scripts\cp\covenants\cp_artifact_defense_system::try_to_activate_artifact_defense_system(self);

    if(var_0 scripts\common\utility::_id_89CE(self)) {
      return;
    }
  }

  var_0 dodamage(var_1, self.origin, self, self, var_2, "zombie_melee_attack_mp");
}

_id_FCA8(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_4 = self.origin;
  var_5 = var_1;
  var_6 = 0.05;

  for(;;) {
    wait(var_6);
    var_5 = var_5 - var_6;

    if(var_5 <= 0) {
      break;
    }

    var_7 = _id_6E27(var_0, var_2);

    if(!isDefined(var_7)) {
      break;
    }

    if(isDefined(var_3)) {
      var_8 = var_3;
    } else {
      var_8 = _id_0B05::_id_6B54() - self._id_0359;
    }

    var_9 = var_7 - var_4;

    if(_func_0135(var_9) > var_8 * var_8) {
      var_7 = var_4 + vectornormalize(var_9) * var_8;
    }

    self _meth_82C1("face enemy");
    self _meth_82B3(self.origin, var_7, var_5);
  }
}

_id_6E27(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  if(!var_1) {
    var_2 = _id_06E0::_id_5056(var_0.origin);
    return var_2;
  } else {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < self._id_1DF5) {
      return self.origin;
    } else {
      var_3 = var_3 / var_4;
      var_5 = _id_0B05::_id_6B52(var_0);

      if(_id_0B05::_id_318A(self.origin, var_5.origin)) {
        return var_5.origin;
      } else {
        return undefined;
      }
    }
  }
}

_id_1DF9(var_0) {
  if(!isalive(var_0)) {
    return 0;
  }

  if(!_id_10E7D()) {
    return 0;
  }

  if(istrue(self._id_86F2)) {
    return 1;
  }

  if(isPlayer(var_0) || isai(var_0)) {
    if(istrue(self._id_2467) && !istrue(self._id_4B40)) {
      var_1 = [];
      var_1[0] = self;
      var_2 = self getEye() - (0, 0, 16);
      var_3 = var_0 getEye() - (0, 0, 16);
      var_4 = scripts\engine\trace::_id_E409(var_2, var_3, 4, var_1);

      if(var_4["fraction"] < 1) {
        var_5 = var_4["entity"];

        if(isDefined(var_5) && isai(var_5)) {
          if(isDefined(var_5.team) && var_5.team == self.team) {
            var_6 = vectornormalize((var_3 - var_2) * (1, 1, 0));
            var_7 = vectornormalize((var_5.origin - self.origin) * (1, 1, 0));
            var_8 = vectordot(var_7, var_6);

            if(var_8 > 0.866 && distance(self.origin, var_5.origin) > 12) {
              return 0;
            }
          }
        }
      }
    }
  }

  if(_id_881E(var_0, self._id_9D84)) {
    return 1;
  }

  if(_id_0B05::_id_8830(var_0)) {
    return 1;
  }

  return 0;
}

_id_881E(var_0, var_1) {
  var_2 = vectornormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);
  return var_4 > var_1;
}

_id_10E7D() {
  var_0 = self._id_54D1;

  if(isDefined(self._id_012F) && !_func_02AE(self._id_012F.origin) && !_id_06BD::_id_23E5()) {
    if(_id_0B05::_id_C0AF("offmesh", var_0)) {
      return 1;
    }
  }

  if(!_id_0B05::_id_C0AF("normal", var_0)) {
    return 0;
  }

  if(_id_0B05::_id_6B54() > self._id_9D95 && !_id_0B05::_id_10E7F()) {
    return 0;
  }

  return 1;
}