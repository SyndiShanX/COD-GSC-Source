/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2425.gsc
*************************************************/

_id_10025() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "create", ::_id_10021);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "createLate", ::_id_10022);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrame", ::_id_10023);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrameLate", ::_id_10024);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_interact", "init", _id_097B::_id_100E9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "init", _id_097C::_id_10172);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "init", _id_097E::_id_1026E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "init", _id_0978::_id_1000C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "init", _id_097A::_id_10031);
  scripts\cp_mp\utility\script_utility::registersharedfunc("technical", "init", _id_0976::_id_EFD3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "init", _id_0971::_id_93AA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "init", _id_0972::_id_955B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("bronco_sfps_mp", "init", _id_0967::_id_2BFF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "init", _id_0975::_id_ECC3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "init", _id_0965::_id_1E38);
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "init", _id_0970::_id_8EC1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "init", _id_0969::_id_3D29);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "init", _id_0974::_id_B086);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "init", _id_0968::_id_3274);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "init", _id_096D::_id_79EE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "init", _id_096F::_id_8BAA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "init", _id_0973::_id_9CDF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty_truck", "init", _id_096E::_id_7A12);
  scripts\cp_mp\utility\script_utility::registersharedfunc("van", "init", _id_0977::_id_FF7B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "init", _id_0964::_id_1975);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_tracking", "vehicle_spawned", ::_id_102BA);
  _id_096C::init();
  _id_097D::_id_1021B();
}

_id_E1E6(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_1);
  var_6 = self gettagangles(var_1);
  var_7 = getstartorigin(var_5, var_6, var_3);
  var_8 = _func_00D2(var_5, var_6, var_3);
  var_9 = spawn("script_model", var_7);
  var_9.angles = var_8;
  var_9 setModel(var_4);
  var_9 linkto(self);

  if(isDefined(var_2)) {
    var_9 _meth_82CB(var_2);
  }

  var_9._id_10238 = var_0;
  var_9._id_4A06 = 1;
  self._id_1D81[self._id_1D81.size] = var_9;
  self._id_FE56[var_0] = 1;
  self._id_C835[self._id_C835.size] = var_9;

  if(var_0 == 0) {
    self._id_4F62 = var_9;
  }

  return var_9;
}

_id_E236(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", self.origin);
  var_4 setModel(var_0);
  var_4 notsolid();
  var_4 show();

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_5 = "tag_origin";

  if(isDefined(var_1)) {
    var_5 = var_1;
  }

  var_6 = self gettagorigin(var_5);

  if(isDefined(var_6)) {
    var_4 linkto(self, var_5, var_2, var_3);
  } else {
    var_4 linkto(self);
  }

  var_4._id_0481 = self._id_0481 + "_accessory";

  if(!isDefined(self._id_0E4B)) {
    self._id_0E4B = [];
  }

  self._id_0E4B[self._id_0E4B.size] = var_4;
  return var_4;
}

_id_102BA(var_0) {
  if(!isDefined(var_0._id_F94F)) {
    var_0 _id_079E::_id_1D10();
  }

  var_0 thread _id_06E9::_id_FFF7();
}

_id_10021(var_0, var_1) {
  var_0._id_2C51 = 0;
  var_0._id_9000 = 0;
  var_0._id_8D7E = [];
  var_0._id_8D78 = [];
  var_0._id_8FFD = undefined;
  var_0._id_7120 = 0;
  var_0._id_42F6 = [];
  var_0._id_9000 = 0;
  var_0._id_8FFB = 0;
  var_0._id_C0F3 = 0;
  var_0._id_C0F1 = 0;
  var_0._id_0267 = 0;
  var_0._id_0157 = 0;
  var_0.pers["cur_kill_streak"] = 0;
  var_0.pers["cur_death_streak"] = 0;
  var_0.pers["cur_kill_streak_for_nuke"] = 0;
  var_0._id_F33C = [];
  var_0.guid = var_0 getentitynumber();
  _id_097D::_id_1021D(var_0);
}

_id_10022(var_0, var_1) {}

_id_10023(var_0) {
  _id_097D::_id_10214(var_0, 1);
}

_id_10024(var_0) {}