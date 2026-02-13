/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_capture.gsc
*************************************************/

init() {
  var_0 = spawnStruct();
  var_0._id_B0B3 = 0.5;
  var_0._id_FEE4 = &"MP/RETURNING_FLAG";
  var_0._id_FEE3 = &"MP/GRABBING_FLAG";
  var_0._id_AB50 = ::_id_AB43;
  var_0._id_AABA = ::_id_AB41;
  var_0._id_AB8A = ::_id_AB44;
  var_0._id_AAAE = ::_id_AB40;
  var_0._id_B0AE = "waypoint_capture_take";
  var_0._id_47A0 = 0.5;
  level._id_A8F1["ctf"] = var_0;
}

_id_3FA5(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level._id_A8F1["ctf"];
  }

  var_3 = _id_3FA8(var_0, var_1, var_2);
  var_4 = _id_3FE8(var_3._id_10430[0].target, var_3, var_1, var_2);
  var_3._id_01FA = var_4;
}

_id_3FA8(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");

  if(!isDefined(var_3)) {
    scripts\engine\utility::_id_5598("No model named " + var_0 + " found!");
  } else {
    var_4 = spawn("trigger_radius", var_3.origin, 0, 96, 120);
    var_5 = _id_07D6::_id_3FA8(var_1, var_4, [var_3], (0, 0, 85));
    var_5 _id_07D6::_id_D71A("friendly", var_2._id_B0B3);
    var_5 _id_07D6::_id_D71A("enemy", var_2._id_B0B3);
    var_5 _id_07D6::_id_D719("enemy", var_2._id_FEE4);
    var_5 _id_07D6::_id_D719("friendly", var_2._id_FEE3);
    var_5 _id_07D6::_id_159C("enemy");
    var_5 _id_07D6::_id_D61B(var_2._id_B0AE, var_2._id_B0AE);
    var_5 _id_07D6::_id_D8E0("enemy");
    var_5._id_A90C = 1;
    var_5._id_15E2 = 1;
    var_5._id_AB4D = var_2._id_AB50;
    var_5._id_AB4E = var_2._id_AB4F;
    var_5._id_AAB9 = var_2._id_AABA;
    var_5._id_AB88 = var_2._id_AB8A;
    var_5._id_D729 = var_2;

    if(!isDefined(var_2._id_32EB)) {
      var_2._id_32EB = var_3.model;
    }

    var_5 setnodeploy(1);
    var_5 _meth_8359(1);
  }
}

_id_3FE8(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");

  if(!isDefined(var_4)) {
    scripts\engine\utility::_id_5598("No goal trigger named " + var_4 + " found!");
  } else {
    var_5 = _id_07D6::_id_406E(var_2, var_4, [], (0, 0, 85));
    var_5 _id_07D6::_id_15DF("enemy");
    var_5 _id_07D6::_id_D8E0("any");
    var_5 _id_07D6::_id_D61B("waypoint_blitz_defend", "waypoint_blitz_goal");
    var_5 _id_07D6::_id_D8D2(var_3._id_47A0);
    var_5 _id_07D6::_id_D5C5(var_1);
    var_5._id_ABCB = var_3._id_AAAE;
    var_5._id_D729 = var_3;
  }
}

_id_AB43(var_0, var_1, var_2) {
  if(var_0.team == _id_07D6::_id_6C02()) {
    _id_07D6::_id_C797();
  } else {
    var_0 _id_1DBB(self._id_D729._id_32EB);
    _id_07D6::_id_D8E0("any");
    _id_07D6::_id_D61B("waypoint_capture_kill", "waypoint_escort");
  }
}

_id_AB41(var_0) {
  _id_07D6::_id_159C("any");
  _id_07D6::_id_D8E0("any");
  _id_07D6::_id_D61B("waypoint_capture_recover", "waypoint_capture_take");
}

_id_C790() {
  if(!isDefined(self._id_D729._id_C79F)) {
    return;
  }
  self endon("picked_up");
  wait(self._id_D729._id_C79F);
  _id_07D6::_id_C797();
}

_id_AB44() {}

_id_AB40(var_0) {
  self._id_8CD8 _id_07D6::_id_159C("none");
  self._id_8CD8 _id_07D6::_id_D8E0("none");
  var_0 _id_488E();
  _id_07D6::_id_479D();
}

_id_1DBB(var_0) {
  self attach(var_0, "j_spine4", 1);
  self._id_32D0 = var_0;
}

_id_488E() {
  if(isDefined(self._id_32D0)) {
    self detach(self._id_32D0, "j_spine4");
    self._id_32D0 = undefined;
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_488E();
}