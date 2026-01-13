/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3869.gsc
*********************************************/

main() {
  func_9732();
  thread func_10A9E();
  thread func_13437();
}

func_9732() {
  self.var_10E6D = spawnStruct();
  self.var_10E6D.var_10A9D = [];
  self.var_10E6D.var_74D5 = [];
  scripts\sp\utility::func_65E0("stealth_enabled");
  scripts\sp\utility::func_65E0("stealth_override_goal");
  scripts\sp\utility::func_65E1("stealth_enabled");
  scripts\sp\utility::func_65E0("stealth_in_shadow");
  lib_0F27::func_868B("stealth_spotted");
  lib_0F27::func_8682();
}

func_10A9E() {
  self endon("death");
  self notify("spotted_thread");
  self endon("spotted_thread");
  for(;;) {
    scripts\sp\utility::func_65E3("stealth_enabled");
    lib_0F27::func_868E("stealth_spotted");
    if(!scripts\sp\utility::func_65DB("stealth_enabled")) {
      scripts\sp\utility::func_65E3("stealth_enabled");
    }

    thread func_10E1B();
    scripts\sp\utility::func_65E3("stealth_enabled");
    lib_0F27::func_868D("stealth_spotted");
    if(!scripts\sp\utility::func_65DB("stealth_enabled")) {
      scripts\sp\utility::func_65E3("stealth_enabled");
    }

    thread func_10E20();
  }
}

func_10E1B() {
  thread scripts\sp\utility::func_F2DA(0);
  self.var_10E6D.var_C3EF = self.objective_state;
  self.objective_state = 0;
  self.var_72DE = undefined;
  self.ignoreme = 1;
  if(isDefined(self.var_10E6D.var_74D5["hidden"])) {
    lib_0F18::func_10E8B("hidden");
  }
}

func_10E20() {
  thread scripts\sp\utility::func_F2DA(1);
  if(isDefined(self.var_10E6D.var_C3EF)) {
    self.objective_state = self.var_10E6D.var_C3EF;
  } else {
    self.objective_state = 3;
  }

  self.ignoreme = 0;
  self _meth_8250(0);
  scripts\sp\utility::func_5514();
  if(isDefined(self.var_10E6D.var_74D5["spotted"])) {
    lib_0F18::func_10E8B("spotted");
  }
}

makeentitynomeleetarget() {
  self endon("death");
}

func_13437() {
  self endon("death");
  self endon("pain_death");
  for(;;) {
    scripts\sp\utility::func_65E3("stealth_enabled");
    if(!isDefined(self.var_10E6D.var_931F)) {
      self.setturretnode = func_7938();
    }

    wait(0.05);
  }
}

func_7938() {
  var_0 = self.a.pose;
  if(var_0 == "back") {
    var_0 = "prone";
  }

  if(lib_0F27::func_869D()) {
    var_1 = "spotted";
  } else {
    var_1 = "hidden";
  }

  var_2 = level.var_10E6D.var_53A0.var_DCCA[var_1][var_0];
  if(scripts\sp\utility::func_65DB("stealth_in_shadow")) {
    var_2 = max(level.var_10E6D.var_53A0.var_DCCA["hidden"]["prone"], var_2 * 0.5);
  }

  return var_2;
}