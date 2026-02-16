/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bank.gsc
*************************************************/

init() {
  level._id_2A16 = getdvarint("#x3caa1c1db64166782", 0);

  if(!istrue(level._id_2A16)) {
    return;
  }
  level._effect["poi_light_bank"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_light_bank.vfx");
  level._id_21CC = getEntArray("bank_entry_detector", "targetname");

  foreach(var_1 in level._id_21CC) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1._id_B7BE = 0;
    var_1._id_1420 = 0;
    var_1._id_21D2 = scripts\engine\utility::getStructArray(var_1.target, "targetname");
    var_1 thread _id_0AA6::_id_99E8(var_1, ::_id_21D3, ::_id_21D4);
  }
}

_id_21D3(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1._id_B7BE = var_1._id_B7BE + 1;

  if(var_1._id_B7BE != 1) {
    return;
  }
  var_1 thread _id_21DE();
}

_id_21D4(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1._id_B7BE = max(var_1._id_B7BE - 1, 0);

  if(var_1._id_B7BE == 0) {
    var_1 thread _id_21DD();
  }
}

_id_21D6() {
  if(!istrue(level._id_2A16)) {
    return;
  }
  var_0 = self;
  var_0 notify("bankPlunderDeposited");
  var_0 endon("bankPlunderDeposited");
  var_1 = scripts\engine\utility::_id_6969(var_0.origin, level._id_21CC, 90000);

  if(!isDefined(var_1)) {
    return;
  }
  var_1 _id_21DD();
  var_2 = getdvarint("#x3ea5b7e8f11705f62", 15);
  wait(var_2);

  if(var_1._id_B7BE > 0) {
    var_1 _id_21DE();
  }
}

_id_21DE() {
  self notify("bank_alarm_triggered");
  var_0 = self;
  var_0._id_1420 = 1;
  var_0 playLoopSound("bank_alarm_lp");

  foreach(var_2 in var_0._id_21D2) {
    var_3 = anglesToForward(var_2.angles);
    var_4 = anglestoup(var_2.angles);
    var_2._id_605B = spawnfx(level._effect["poi_light_bank"], var_2.origin + var_3 * 5, var_3, var_4);
    triggerfx(var_2._id_605B);
  }

  var_6 = getdvarint("#x319c586f0a9c4e673", 5);
  wait(var_6);
  var_0._id_1420 = 0;

  if(var_0._id_B7BE == 0) {
    var_0 _id_21DD();
  }
}

_id_21DD() {
  self endon("bank_alarm_triggered");
  var_0 = self;

  if(var_0._id_1420) {
    return;
  }
  wait 3;
  var_0 stoploopsound();

  foreach(var_2 in var_0._id_21D2) {
    if(isDefined(var_2._id_605B)) {
      var_2._id_605B delete();
    }
  }
}