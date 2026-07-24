/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3142.gsc
**************************************/

_id_3535() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("damage");

    if(!isDefined(self._blackboard._id_2ABA) && self.damagemod != "MOD_IMPACT") {
      var_0 = 1;
      self._blackboard._id_2ABA = 1;
    } else
      var_0 = isexplosivedamagemod(self.damagemod) && self.damagetaken > 50;

    var_1 = isexplosivedamagemod(self.damagemod);

    if(var_0)
      _id_3559(1);
  }
}

_id_3620() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("damage_subpart", var_0);
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(isexplosivedamagemod(var_6.type))
        var_2 = var_2 + var_6.amount;

      var_1 = var_1 + var_6.amount;

      if(self _meth_850C(var_6.partname, var_6.subpartname) <= 0)
        var_3 = 1;

      if(var_6.type != "MOD_IMPACT")
        var_4 = 1;
    }

    if(!isDefined(self._blackboard._id_2ABA) && var_4) {
      var_8 = 1;
      self._blackboard._id_2ABA = 1;
    } else
      var_8 = var_2 > 50 || var_3;

    if(var_8)
      _id_3559(1);
  }
}

_id_3559(var_0) {
  if(self.a._id_5605) {
    return;
  }
  if(isDefined(self.asm._id_2AD2)) {
    return;
  }
  if(gettime() < self._blackboard.timeoff + 5000) {
    return;
  }
  foreach(var_6, var_2 in self._id_164D) {
    if(isDefined(var_2._id_2F3C)) {
      var_3 = var_2._id_4BC0;
      var_4 = anim.asm[var_6].states[var_3];

      if(!isDefined(var_4._id_C87F)) {
        continue;
      }
      var_5 = anim.asm[var_6].states[var_4._id_C87F];

      if(var_0)
        self._blackboard._id_A983 = gettime();

      self._blackboard.timeoff = gettime();
      scripts\asm\asm::asm_setstate(var_4._id_C87F);
      break;
    }
  }
}

_id_D4EE(var_0, var_1, var_2, var_3) {
  self.asm._id_2AD2 = 1;
  var_4 = self[[self._id_7191]](var_0, var_1);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82EA(var_1, var_4, 1, var_2, 1);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_4109(var_0, var_1, var_2) {
  self.asm._id_2AD2 = undefined;
}

_id_3EE4(var_0, var_1, var_2) {
  var_3 = self._blackboard._id_A983 == gettime();
  var_4 = _id_0A1E::_id_7E5A();

  if(var_3)
    var_5 = var_4;
  else
    var_5 = var_4 + "_small";

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);

  if(!var_3 || _id_8C21(var_6))
    return var_6;

  return _id_0A1E::_id_2356(var_1, "default");
}

_id_D542(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.asm._id_2AD2 = 1;
  self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, _id_0A1E::asm_getallanimsforstate(var_0, var_1), 1, var_2);
  _id_0A1E::_id_231F(var_0, var_1);
}

_id_CF37(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.asm._id_2AD2 = 1;
  var_4 = _id_0A1E::_id_2356(var_1, "enter");
  var_5 = _id_0A1E::_id_2356(var_1, "recover");
  var_6 = max(0, self.empstartcallback - getanimlength(var_4) - getanimlength(var_5));

  if(var_6 > 0) {
    self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
    self _meth_82AB(_id_0A1E::_id_2356(var_1, "stun"), 1, var_2);
    wait(var_6);
  }

  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_CF1C(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  self.asm._id_2AD2 = 1;

  if(!scripts\asm\asm_bb::bb_isselfdestruct() && (!isDefined(self._id_30E9) || !self._id_30E9)) {
    self clearanim(_id_0A1E::asm_getbodyknob(), var_2);
    self _meth_82AB(_id_0A1E::_id_2356(var_1, "stun"), 1, var_2);
    wait(anim._id_3546);
  }

  scripts\asm\asm::asm_fireevent(var_1, "end");
}

_id_411A(var_0, var_1, var_2) {
  self.asm._id_2AD2 = undefined;
}

_id_8C21(var_0) {
  var_1 = getmovedelta(var_0);
  var_2 = self _meth_84AC();
  var_3 = rotatevector(var_1, self.angles);
  var_4 = var_2 + var_3;

  if(self maymovefrompointtopoint(var_2, var_4, 0, 1))
    return 1;

  return 0;
}

_id_3527(var_0, var_1, var_2) {
  if(isDefined(var_2))
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_2);
  else {
    var_3 = _id_0A1E::_id_7E5A();
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }
}

_id_35D7(var_0, var_1, var_2, var_3) {
  self stoploopsound();

  if(isDefined(self.bt._id_71C9))
    [[self.bt._id_71C9]]();

  if(isDefined(self._id_E601))
    self._id_E601 delete();

  if(isDefined(self.asm._id_F1FD)) {
    _id_F1FD();
    return;
  }

  if(self.a.nodeath == 1) {
    _id_0C60::_id_4E36();
    return;
  }

  if(isDefined(self._id_4E46)) {
    var_4 = self[[self._id_4E46]]();

    if(!isDefined(var_4))
      var_4 = 1;

    if(var_4)
      return;
  }

  if(isDefined(self._id_4E2A))
    var_5 = self._id_4E2A;
  else {
    var_6 = anim.asm[var_0].states[var_1]._id_71A5;
    var_5 = self[[var_6]](var_0, var_1, var_3);
  }

  if(!isDefined(self.asm._id_4E73))
    self _meth_824A("vox_c12_death", "vox_c12_death", 1);

  playFXOnTag(level._id_7649["c12_implode_buildup"], self, "j_spinelowerbottom");
  self clearanim(_id_0A1E::_id_2342(), var_2);
  self _meth_82EA(var_1, var_5, 1, var_2);
  self endon("terminate_death_thread");
  _id_0A1E::_id_231F(var_0, var_1);
  self notify("endPlayDeathAnim");
  var_7 = self gettagorigin("j_spinelowerbottom");
  playFX(level._id_7649["c12_implode_explosion"], var_7);
  _id_35A5();
  playrumbleonposition("heavy_1s", var_7);
  earthquake(1, 0.5, var_7, 1200);
  scripts\engine\utility::waitframe();
  _id_0C60::_id_4E36();
  self delete();
}

_id_F1FD() {
  var_0 = self gettagorigin("j_spinelowerbottom");
  playFX(level._id_7649["c12_selfdestruct_explosion"], var_0);
  _id_35FD();
  scripts\engine\utility::waitframe();

  if(isDefined(self.bt._id_71C9))
    [[self.bt._id_71C9]]();

  var_0 = self.origin + (0, 0, 60);
  radiusdamage(var_0 + (0, 0, 32), 512, 150, 20, self);
  physicsexplosionsphere(var_0, 1000, 50, 1);
  level.player playRumbleOnEntity("heavy_1s");
  earthquake(2.25, 0.3, var_0, 1200);
  level thread _id_F20A(var_0);
  _id_0C60::_id_4E36();
  destroynavrepulsor("c12_selfdestruct");
  self delete();
}

_id_F20A(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playSound("c12_self_destruct", "sounddone");
  var_1 waittill("sounddone");
  var_1 delete();
}

_id_35A5() {
  level thread _id_F20A(self.origin);
  _id_3539("implode");
}

_id_35FD() {
  var_0 = [];

  if(self getscriptablepartstate("head") == "rodeofinal")
    var_0[var_0.size] = "head";

  _id_3539("selfdestruct");
}

_id_3539(var_0, var_1) {
  var_2 = ["head", "torso", "left_arm", "right_arm", "left_leg", "right_leg", "hip_pack_left", "hip_pack_right"];

  if(isDefined(self.asm._id_4E73)) {
    if(!isDefined(var_1))
      var_1 = [];

    var_1 = scripts\engine\utility::array_combine(var_1, ["head", "torso", "left_arm", "right_arm", "hip_pack_left", "hip_pack_right"]);
  }

  if(isDefined(var_1))
    var_2 = scripts\engine\utility::array_remove_array(var_2, var_1);

  foreach(var_4 in var_2) {
    if(self getscriptablepartstate(var_4) == "dismember") {
      continue;
    }
    self setscriptablepartstate(var_4 + "_death_fx", var_0);
  }
}