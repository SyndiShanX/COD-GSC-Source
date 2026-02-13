/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_grindzone.gsc
**************************************************/

init() {
  _id_D881();
}

_id_D881() {
  level._id_7C74 = "waypoint_bank_";
  level._id_7C42 = "waypoint_scoring_foe_";
  level._id_7C4B = "waypoint_scoring_friend_";
  level._id_7C52 = "waypoint_contested_";
  level._id_7C5D = "waypoint_contested_";
}

_id_D896(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_0.origin, 0, 90, 128);
  var_3._id_CD99 = var_0._id_CD99;
  var_0 = var_3;
  var_4[0] = spawn("script_model", var_0.origin);
  var_4[0].angles = var_0.angles;

  if(isDefined(var_0._id_A8E1)) {
    var_5 = var_0._id_A8E1;
  } else {
    var_5 = var_0._id_CD99;
  }

  if(isDefined(var_0._id_7C73)) {
    var_6 = var_0._id_7C73;
  } else {
    var_6 = var_0._id_CD99;
  }

  if(istrue(var_1)) {
    var_7 = _id_6CED(var_5);
  } else {
    var_7 = undefined;
  }

  var_8 = _id_07D6::_id_406E("neutral", var_0, var_4, (0, 0, 90), var_1, var_2);
  var_8 _id_07D6::_id_15DF("enemy");
  var_8 _id_07D6::_id_D8D2(level._id_21CD);
  var_8 _id_07D6::_id_316A(1);
  var_8 _id_07D6::_id_A362(1);
  var_8._id_ED75 = 0;
  var_8._id_4A88 = 0;
  var_8._id_A8E1 = var_5;
  var_8._id_7C73 = var_6;

  if(!istrue(var_2)) {
    var_8 _id_07D6::_id_D8E0("any");
    var_8 _id_D614();
    _func_0167(var_8._id_A908, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
    var_8 scripts\engine\utility::delaythread(1.0, ::_id_D607);
  }

  return var_8;
}

_id_D614() {
  self._id_AA79 = ::_id_110D9;
  self._id_ABD4 = ::_id_110DB;
  self._id_AAC2 = ::_id_110DA;
  self._id_ABCB = ::_id_110D8;
  self._id_ABC8 = ::_id_110D6;
  self._id_AA8D = ::_id_110D2;
  self._id_ABC7 = ::_id_110D5;
  self._id_7C8C = "domFlag";
  _id_07D6::_id_B0E7();
  self._id_37F3 = level._id_21CD * 1000;
  self._id_03A9 = _id_D8AD(self._id_10430[0].origin, self);
}

_id_6CED(var_0) {
  if(var_0 == "a") {
    var_1 = 0;
  } else {
    var_1 = 1;
  }

  return var_1;
}

_id_D8AD(var_0, var_1) {
  var_2 = var_0 + (0, 0, 32);
  var_3 = var_0 + (0, 0, -32);
  var_4 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_5 = [];
  var_6 = scripts\engine\trace::ray_trace(var_2, var_3, var_5, var_4);
  var_1._id_22B7 = var_6["position"];
  var_7 = vectortoangles(var_6["normal"]);
  var_1._id_22B6 = anglesToForward(var_7);
  var_1._id_22B7 = _id_5BFD(var_1);
  var_8 = spawn("script_model", var_1._id_22B7);
  var_8 setModel("grind_flag_scriptable");
  var_8.angles = _func_030A(var_1._id_22B6, var_8.angles);
  return var_8;
}

_id_5BFD(var_0) {
  var_1 = var_0._id_22B7;

  if(level.mapname == "mp_village2") {
    if(var_0.trigger._id_CD99 == "b") {
      var_1 = var_0._id_22B7 + (0, 0, 10);
    }
  }

  return var_1;
}

_id_0F05() {
  self._id_AA79 = undefined;
  self._id_ABD4 = undefined;
  self._id_AAC2 = undefined;
  self._id_ABCB = undefined;
  self._id_ABC8 = undefined;
  self._id_AA8D = undefined;
  self._id_ABC7 = undefined;
}

_id_4392() {
  self._id_AA79 = undefined;
  self._id_ABD4 = undefined;
  self._id_AAC2 = undefined;
  self._id_ABCB = undefined;
  self._id_ABC8 = undefined;
  self._id_AA8D = undefined;
  self._id_ABC7 = undefined;
}

_id_D607() {
  _id_07D6::_id_D639("neutral");
  _id_D608();
  _id_FC64("idle", 0);
}

_id_110D9(var_0) {
  self._id_497A = 0;
  thread _id_07D6::_id_FE93(var_0.team);
}

_id_110DB(var_0, var_1, var_2, var_3) {
  var_4 = _id_07D6::_id_6C02();

  if(var_1 > 0.05 && var_2 && !self._id_497A) {
    if(!isagent(var_3)) {
      _id_FC63(var_0);
    }

    self._id_497A = 1;
  }
}

_id_110DA(var_0, var_1, var_2) {
  var_3 = _id_07D6::_id_6C02();

  if(var_3 == "neutral") {
    _id_D608();
    _id_FC64("idle", 0);
  } else {
    _id_D712();
    _id_FC64(var_3, 0);
  }
}

_id_110D8(var_0) {
  var_1 = var_0.team;
  var_2 = _id_07D6::_id_6C02();
  var_3 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  var_4 = gettime();
  _id_D712();
  _id_FC64(var_1, 0);
  _id_07D6::_id_D639(var_1);
}

_id_110D6() {
  _id_D608();
  _id_D607();
}

_id_110D2() {
  _id_D4E2();
  _id_FC64("contested", 0);
}

_id_110D5(var_0) {
  var_1 = _id_07D6::_id_6C02();

  if(var_0 == "none" || var_1 == "neutral") {
    _id_D608();
  } else {
    _id_D712();
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  _id_FC64(var_2, 0);
}

_id_D4F0(var_0) {
  if(isDefined(level._id_EB99) && level._id_EB99 && isDefined(var_0._id_3E59) && var_0._id_3E59) {
    var_0 _id_07C1::_id_D4EE("assist");
  }
}

_id_D608() {
  if(!isDefined(level._id_ED22)) {
    _id_07D6::_id_D61B(level._id_7C74);
  }
}

_id_D712() {
  _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
}

_id_D4E2() {
  _id_07D6::_id_D61B(level._id_7C5D);
}

_id_FC64(var_0, var_1) {
  self._id_03A9 setscriptablepartstate("flag", var_0);

  if(!istrue(var_1)) {
    self._id_03A9 setscriptablepartstate("pulse", "off");
  }
}

_id_FC63(var_0) {
  self._id_03A9 setscriptablepartstate("pulse", var_0);
}