/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3869.gsc
**************************************/

main() {
  _id_9732();
  thread _id_10A9E();
  thread _id_13437();
}

_id_9732() {
  self._id_10E6D = spawnStruct();
  self._id_10E6D._id_10A9D = [];
  self._id_10E6D._id_74D5 = [];
  scripts\sp\utility::_id_65E0("stealth_enabled");
  scripts\sp\utility::_id_65E0("stealth_override_goal");
  scripts\sp\utility::_id_65E1("stealth_enabled");
  scripts\sp\utility::_id_65E0("stealth_in_shadow");
  _id_0F27::_id_868B("stealth_spotted");
  _id_0F27::_id_8682();
}

_id_10A9E() {
  self endon("death");
  self notify("spotted_thread");
  self endon("spotted_thread");

  for(;;) {
    scripts\sp\utility::_id_65E3("stealth_enabled");
    _id_0F27::_id_868E("stealth_spotted");

    if(!scripts\sp\utility::_id_65DB("stealth_enabled")) {
      scripts\sp\utility::_id_65E3("stealth_enabled");
    }

    thread _id_10E1B();
    scripts\sp\utility::_id_65E3("stealth_enabled");
    _id_0F27::_id_868D("stealth_spotted");

    if(!scripts\sp\utility::_id_65DB("stealth_enabled")) {
      scripts\sp\utility::_id_65E3("stealth_enabled");
    }

    thread _id_10E20();
  }
}

_id_10E1B() {
  thread scripts\sp\utility::_id_F2DA(0);
  self._id_10E6D._id_C3EF = self.grenadeammo;
  self.grenadeammo = 0;
  self._id_72DE = undefined;
  self.ignoreme = 1;

  if(isDefined(self._id_10E6D._id_74D5["hidden"])) {
    _id_0F18::_id_10E8B("hidden");
  }
}

_id_10E20() {
  thread scripts\sp\utility::_id_F2DA(1);

  if(isDefined(self._id_10E6D._id_C3EF)) {
    self.grenadeammo = self._id_10E6D._id_C3EF;
  } else {
    self.grenadeammo = 3;
  }

  self.ignoreme = 0;
  self _meth_8250(0);
  scripts\sp\utility::_id_5514();

  if(isDefined(self._id_10E6D._id_74D5["spotted"])) {
    _id_0F18::_id_10E8B("spotted");
  }
}

_id_81F0() {
  self endon("death");
}

_id_13437() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    scripts\sp\utility::_id_65E3("stealth_enabled");

    if(!isDefined(self._id_10E6D._id_931F)) {
      self.maxvisibledist = _id_7938();
    }

    wait 0.05;
  }
}

_id_7938() {
  var_0 = self.a.pose;

  if(var_0 == "back") {
    var_0 = "prone";
  }

  if(_id_0F27::_id_869D()) {
    var_1 = "spotted";
  } else {
    var_1 = "hidden";
  }

  var_2 = level._id_10E6D._id_53A0._id_DCCA[var_1][var_0];

  if(scripts\sp\utility::_id_65DB("stealth_in_shadow")) {
    var_2 = max(level._id_10E6D._id_53A0._id_DCCA["hidden"]["prone"], var_2 * 0.5);
  }

  return var_2;
}