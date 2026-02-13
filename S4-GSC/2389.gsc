/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2389.gsc
*************************************************/

_id_123D(var_0, var_1) {
  self endon("death");
  _id_1295(var_1);
  var_2 = "ascender_" + var_0 + "_in";
  var_3 = "ascender_" + var_0 + "_loop";
  var_4 = "ascender_" + var_0 + "_out";
  var_5 = "wm_eq_ascender_" + var_0 + "_get_on_ascender";
  var_6 = "wm_eq_ascender_" + var_0 + "_loop_ascender";
  var_7 = "wm_eq_ascender_" + var_0 + "_get_off_ascender";
  thread _id_C2F2(var_1);
  var_8 = _id_123A(var_2, var_1);
  var_8._id_52B0 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  _id_F2B2(1, var_8);
  thread _id_1237(var_2, var_4, var_3, var_5, var_7, var_6, var_8, var_1, var_0);
  var_1._id_84EF = 0;
  scripts\engine\utility::waittill_any_2("ascended", "death");
}

_id_1295(var_0) {
  self._id_0229 = 1;
  self._id_0201 = 96;
  self _meth_8326(self _meth_86F8(var_0.origin));

  while(istrue(var_0._id_84EF)) {
    wait 0.1;
  }

  var_0._id_84EF = 1;
}

_id_C2F2(var_0) {
  self endon("ascended");
  self waittill("death");
  var_0._id_84EF = 0;
}

_id_1237(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  var_9 = _id_0009::_id_1C7D("animscripted2", var_0);
  var_10 = _id_0009::_id_1C6E("animscripted2", var_9);
  var_11 = _id_0009::_id_1C7D("animscripted2", var_1);
  var_12 = _id_0009::_id_1C6E("animscripted2", var_11);
  var_13 = _id_0009::_id_1C7D("animscripted2", var_2);
  var_14 = _id_0009::_id_1C6E("animscripted2", var_13);
  self setplayerangles(var_6.angles);

  if(var_8 == "up") {
    self _meth_80F9(var_6.origin + anglestoleft(var_6.angles) * -4 + anglesToForward(var_6.angles) * 10, var_6.angles);
  } else {
    self _meth_80F9(var_6.origin + anglestoleft(var_6.angles) * 4, var_6.angles);
  }

  _id_123B(var_7);
  thread _id_1C22();
  _id_1234(var_3, var_7, var_9, var_6, var_10);
  _id_1235(var_14, var_6);
  _id_1236(var_4, var_11, var_12);
  _id_123C();
  _id_F2B2(0);
  self notify("ascended");
}

_id_1234(var_0, var_1, var_2, var_3, var_4) {
  self._id_1C21 _meth_853F(var_0, var_1.origin, var_1.angles);
  self _meth_8019("noclip");
  self _meth_85ED("animscripted2", var_2);
  self _meth_8251("face angle", var_3.angles[1]);
  waitframe();
  self._id_1C21 show();
  wait(_func_0079(var_4));
}

_id_1235(var_0, var_1) {
  self._id_1772 = spawn("script_origin", self.origin);
  self._id_1772.angles = self.angles;
  self linkto(self._id_1772);
  self._id_1C21 linkto(self._id_1772);
  var_2 = _func_0079(var_0);
  self._id_1772 moveto(var_1._id_52B0.origin, var_2 * 3);
  self._id_1772 waittill("movedone");
}

_id_1236(var_0, var_1, var_2) {
  self unlink();
  self._id_1C21 _meth_82CA();
  self._id_1C21 _meth_853F(var_0, self._id_1C21.origin, self._id_1C21.angles);
  self _meth_85ED("animscripted2", var_1);
  wait(_func_0079(var_2));
  self._id_1772 delete();
  self._id_1C21 delete();
}

_id_123A(var_0, var_1) {
  var_2 = _id_0009::_id_1C7D("animscripted2", var_0);
  var_3 = _id_0009::_id_1C6E("animscripted2", var_2);
  var_4 = spawnStruct();

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_4.origin = getstartorigin(var_1.origin, var_1.angles, var_3);
  var_4.angles = _func_00D2(var_1.origin, var_1.angles, var_3);
  return var_4;
}

_id_123B(var_0) {
  self._id_AA27 = self._id_04F6;
  self._id_1C23 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  self giveweapon(self._id_1C23);
  self takeweapon(self._id_AA27);
  self setspawnweapon(self._id_1C23);
  self._id_1C21 = spawn("script_model", var_0.origin);
  self._id_1C21.angles = var_0.angles;
  self._id_1C21 setModel("misc_wm_ascender");
  self._id_1C21 hide();
}

_id_123C() {
  self giveweapon(self._id_AA27);
  self takeweapon(self._id_1C23);
  self setspawnweapon(self._id_AA27);
}

_id_1238(var_0) {
  var_1 = scripts\engine\utility::getstructarray("ascend_begin", "script_noteworthy");
  var_2 = scripts\engine\utility::_id_6969(var_0, var_1);
  return var_2;
}

_id_1239(var_0) {
  var_1 = scripts\engine\utility::getstructarray("descend_begin", "script_noteworthy");
  var_2 = scripts\engine\utility::_id_6969(var_0, var_1);
  return var_2;
}

_id_1C22() {
  self endon("ascended");
  var_0 = self._id_1C21;
  self._id_4C08 = 1;
  self waittill("death");
  var_0 delete();
}

_id_F2B2(var_0, var_1) {
  if(var_0) {
    self._id_0229 = 1;

    if(isDefined(var_1)) {
      self._id_0201 = 8;
      self _meth_8326(self _meth_86F8(var_1.origin));
      self waittill("goal");
      wait 1;
    }

    _id_06BE::_id_1C9C();
    self._id_B85C = 1;
  } else {
    self._id_0201 = 4096;
    self._id_0229 = 0;
    _id_0AED::_id_18C1();
    self._id_B85C = undefined;
  }
}