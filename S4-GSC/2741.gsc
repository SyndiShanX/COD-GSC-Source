/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2741.gsc
*************************************************/

_id_957D() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "spawnCallback", ::_id_9581);
  _id_957F();
  _id_957E();
  _id_0AC1::_id_1022A("little_bird", _id_09D7::_id_956D);

  if(istrue(level._id_DCF0)) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "endEnterInternal", ::_id_957B);
  }
}

_id_957F() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("little_bird", 1);
  var_0._id_0E01 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10267;
  var_0._id_0E02 = 60;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_0._id_C69E = 30;
  }
}

_id_957E() {
  var_0 = _id_09E2::_id_10144("little_bird", 1);
  var_0._id_5FDC = 78;
  var_0._id_2093 = 28;
  var_0._id_919A = 55;
  var_0._id_C862 = 55;
  var_0._id_2954 = -80;
  var_0._id_4B96 = 80;
  var_0._id_98A0 = (0, 0, -70);
}

_id_9581(var_0, var_1) {
  var_2 = _id_09D7::_id_9563(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_9580;
  }

  return var_2;
}

_id_9580() {
  thread _id_9582();
}

_id_9582() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  var_1._id_C189 = var_0._id_C189;
  var_1._id_BFC5 = var_0._id_BFC5;
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("little_bird", var_1, var_2);

  if(isDefined(var_3)) {
    if(isDefined(var_1._id_C189) && istrue(level._id_FEAF) && level._id_FEAF != 2) {
      var_3._id_C189 = var_1._id_C189;
      var_3.maxhealth = int(max(var_3.maxhealth, var_1._id_BFC5));
      var_3.health = var_3.maxhealth;
      _id_0808::_id_BFC7(var_3);
    }

    if(istrue(level._id_DCF0)) {
      scripts\mp\gametypes\arm::_id_10029(var_3, var_3.team);
    }
  }
}

_id_957B(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level._id_DCF0)) {
    var_0 scripts\mp\gametypes\arm::_id_10234(var_3.team);
  }
}