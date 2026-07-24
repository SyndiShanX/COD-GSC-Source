/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3103.gsc
**************************************/

_id_61F8(var_0) {
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

  thread _id_0BDC::_id_1985();

  if(!isDefined(self.subclass)) {
    self.subclass = "jackal";
  }

  if(self.script_team == "axis") {
    _id_0BDC::_id_105DB("jackal", "JACKAL_R7_SKELTER", "jackal", "enemy_jackal", 1);
  } else {
    _id_0BDC::_id_105DB("jackal", undefined, "ally_jackal", "ally_jackal");
  }

  _id_0BDC::_id_A0AF();
  _id_0BDC::_id_A2DE(1, 0);
  thread _id_0C20::_id_7598(var_2);
  thread _id_0C1C::death_monitor();
  thread _id_0C1C::_id_6170();
  thread _id_0C1A::_id_25C5();

  if(!var_1) {
    thread _id_0C18::_id_1EDC();
  }

  _id_0C24::_id_10A49();
  _id_0C1B::_id_13CC4();
  _id_0C21::_id_D97E();

  if(var_1) {
    _id_0C20::_id_A3B7("fly");

    if(getdvarint("fake_jackal_sfx") == 1) {
      _id_0C1A::_id_11130(0);
    }
  } else if(!var_0)
    _id_0BDC::_id_6B4C("fly");

  level._id_A056._id_1630 = scripts\engine\utility::array_add(level._id_A056._id_1630, self);
}

_id_552A() {
  self notify("terminate_ai_threads");

  if(_id_0BDC::_id_9CC8()) {
    _id_0BDC::_id_105DA();
  }

  level._id_A056._id_1630 = scripts\engine\utility::array_remove(level._id_A056._id_1630, self);
}