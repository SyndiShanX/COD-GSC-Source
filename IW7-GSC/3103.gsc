/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3103.gsc
***************************************/

func_61F8(var_00) {
  setdvarifuninitialized("fake_jackal_sfx", 0);
  self endon("terminate_ai_threads");
  var_01 = 0;

  if(issubstr(self.classname, "cheap"))
    var_01 = 1;

  if(!isDefined(var_00))
    var_00 = 0;

  if(var_00 || var_01)
    var_02 = 0;
  else
    var_02 = 1;

  thread func_0BDC::func_1985();

  if(!isDefined(self.subclass))
    self.subclass = "jackal";

  if(self.script_team == "axis")
    func_0BDC::func_105DB("jackal", "JACKAL_R7_SKELTER", "jackal", "enemy_jackal", 1);
  else
    func_0BDC::func_105DB("jackal", undefined, "ally_jackal", "ally_jackal");

  func_0BDC::func_A0AF();
  func_0BDC::func_A2DE(1, 0);
  thread func_0C20::func_7598(var_02);
  thread func_0C1C::death_monitor();
  thread func_0C1C::func_6170();
  thread func_0C1A::func_25C5();

  if(!var_01)
    thread func_0C18::func_1EDC();

  func_0C24::func_10A49();
  func_0C1B::func_13CC4();
  func_0C21::func_D97E();

  if(var_01) {
    func_0C20::func_A3B7("fly");

    if(getdvarint("fake_jackal_sfx") == 1)
      func_0C1A::func_11130(0);
  } else if(!var_00)
    func_0BDC::func_6B4C("fly");

  level.func_A056.func_1630 = scripts\engine\utility::array_add(level.func_A056.func_1630, self);
}

func_552A() {
  self notify("terminate_ai_threads");

  if(func_0BDC::func_9CC8())
    func_0BDC::func_105DA();

  level.func_A056.func_1630 = scripts\engine\utility::array_remove(level.func_A056.func_1630, self);
}