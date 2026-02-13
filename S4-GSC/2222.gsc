/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2222.gsc
*************************************************/

main() {
  if(!isDefined(level._id_0408)) {
    _id_08B1::main();
  }

  _id_80AB();
  thread _id_E43A();
  thread _id_10413();
}

_id_80AB() {
  self._id_0408 = spawnStruct();
  self._id_0408._id_E439 = [];
  self._id_0408._id_6035 = [];
  scripts\engine\utility::_id_5473("stealth_enabled");
  scripts\engine\utility::_id_5473("stealth_override_goal");
  scripts\engine\utility::_id_5474("stealth_enabled");
  scripts\engine\utility::_id_5473("stealth_in_shadow");
  _id_08B5::_id_720C("stealth_spotted");
  _id_08B5::_id_71F7();
  self._id_0408._id_2C56 = 0;
}

_id_E43A() {
  self endon("death");
  self notify("spotted_thread");
  self endon("spotted_thread");

  for(;;) {
    scripts\engine\utility::_id_5476("stealth_enabled");
    _id_08B5::_id_7210("stealth_spotted");

    if(!scripts\engine\utility::_id_546E("stealth_enabled")) {
      scripts\engine\utility::_id_5476("stealth_enabled");
    }

    thread _id_E74A();
    scripts\engine\utility::_id_5476("stealth_enabled");
    _id_08B5::_id_720E("stealth_spotted");

    if(!scripts\engine\utility::_id_546E("stealth_enabled")) {
      scripts\engine\utility::_id_5476("stealth_enabled");
    }

    thread _id_E74E();
  }
}

_id_E74A() {
  thread _id_08B5::_id_D492(0);
  self._id_0408._id_AA2D = self._id_0206;
  self._id_0206 = 0;
  self._id_01D1 = 0;
  self._id_0181 = 1;
  self._id_017F = 1;

  if(isDefined(self._id_0408._id_6035["hidden"])) {
    _id_08A8::_id_E79D("hidden");
  }
}

_id_E74E() {
  thread _id_08B5::_id_D492(1);

  if(isDefined(self._id_0408._id_AA2D)) {
    self._id_0206 = self._id_0408._id_AA2D;
  } else {
    self._id_0206 = 3;
  }

  self._id_0181 = 0;
  self._id_017F = 0;
  self _meth_8285(0);

  if(isDefined(self._id_0408._id_6035["spotted"])) {
    _id_08A8::_id_E79D("spotted");
  }
}

_id_6E26() {
  self endon("death");
}

_id_10413() {
  self endon("death");
  self endon("long_death");

  for(;;) {
    scripts\engine\utility::_id_5476("stealth_enabled");

    if(!isDefined(self._id_0408._id_7D13)) {
      self._id_02A1 = _id_6449();
    }

    wait 0.05;
  }
}

_id_6449() {
  var_0 = self._id_0131;

  if(var_0 == "back") {
    var_0 = "prone";
  }

  if(_id_08B5::_id_721C()) {
    var_1 = "spotted";
  } else {
    var_1 = "hidden";
  }

  var_2 = level._id_0408._id_4892._id_C01B[var_1][var_0];

  if(scripts\engine\utility::_id_546E("stealth_in_shadow")) {
    var_2 = max(level._id_0408._id_4892._id_C01B["hidden"]["prone"], var_2 * 0.5);
  }

  return var_2;
}