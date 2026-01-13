/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3103.gsc
***************************************/

func_61F8(var_0) {
  setdvarifuninitialized("fake_jackal_sfx", 0);
  self endon("terminate_ai_threads");
  var_1 = 0;

  if(issubstr(self.classname, "cheap")) {
    var_1 = 1;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0 || var_1) {
    var_2 = 0;
  } else {
    var_2 = 1;
  }

  thread func_0BDC::func_1985();

  if(!isDefined(self.subclass)) {
    self.subclass = "jackal";
  }

  if(self.script_team == "axis") {
    func_0BDC::func_105DB("jackal", "JACKAL_R7_SKELTER", "jackal", "enemy_jackal", 1);
  } else {
    func_0BDC::func_105DB("jackal", undefined, "ally_jackal", "ally_jackal");
  }

  func_0BDC::func_A0AF();
  func_0BDC::func_A2DE(1, 0);
  thread func_0C20::func_7598(var_2);
  thread func_0C1C::death_monitor();
  thread func_0C1C::func_6170();
  thread func_0C1A::func_25C5();

  if(!var_1) {
    thread func_0C18::func_1EDC();
  }

  func_0C24::func_10A49();
  func_0C1B::func_13CC4();
  func_0C21::func_D97E();

  if(var_1) {
    func_0C20::func_A3B7("fly");

    if(getdvarint("fake_jackal_sfx") == 1) {
      func_0C1A::func_11130(0);
    }
  } else if(!var_0)
    func_0BDC::func_6B4C("fly");

  level.var_A056.var_1630 = scripts\engine\utility::array_add(level.var_A056.var_1630, self);
}

func_552A() {
  self notify("terminate_ai_threads");

  if(func_0BDC::func_9CC8()) {
    func_0BDC::func_105DA();
  }

  level.var_A056.var_1630 = scripts\engine\utility::array_remove(level.var_A056.var_1630, self);
}