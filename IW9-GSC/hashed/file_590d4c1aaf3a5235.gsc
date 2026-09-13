/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_590d4c1aaf3a5235.gsc
***********************************************/

_id_2E887982267D85A8() {
  scripts\mp\flags::_id_1240434F4201AC9D("vehicle_patrol_paths_selected");
  level._id_035D525D711DE1B7 = spawnStruct();
  level._id_035D525D711DE1B7.enabled = getdvarint("dvar_39C37258CA05357B", 0);

  if(!level._id_035D525D711DE1B7.enabled) {
    return;
  }
  level._id_035D525D711DE1B7.speed = getdvarfloat("dvar_FFE88A9964EE8CDA", 20.0);
  level._id_035D525D711DE1B7._id_19B2F27954F6434E = getdvarint("dvar_01E2146029ACD559", 4);
  level._id_035D525D711DE1B7._id_14EC3F04478A5448 = getdvarint("dvar_EC74918DFB1E85E7", 6);
  level._id_4B11054EAA9AA4EC = [];

  foreach(_id_AC0E594AC96AA3A8, _id_AC0E424AC96A7113 in level._id_9E7ADB59A0CB3E3D) {
    _id_AC0E424AC96A7113.origin = _id_AC0E424AC96A7113.path[0].origin;
    level._id_4B11054EAA9AA4EC[level._id_4B11054EAA9AA4EC.size] = _id_AC0E424AC96A7113;
  }

  level._id_4B11054EAA9AA4EC = scripts\engine\utility::array_randomize(level._id_4B11054EAA9AA4EC);
  _id_FC617751F654A141 = randomintrange(level._id_035D525D711DE1B7._id_19B2F27954F6434E, level._id_035D525D711DE1B7._id_14EC3F04478A5448 + 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    _id_E0C08758EB0006BE = spawnStruct();
    _id_E0C08758EB0006BE thread _id_C089B1C94E960517(level._id_4B11054EAA9AA4EC[_id_AC0E594AC96AA3A8]);
  }
}

_id_C089B1C94E960517(_id_C79916C8DF58D478) {
  if(!isDefined(_id_C79916C8DF58D478)) {
    return;
  }
  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("veh9_mil_cargo_truck")) {
    return;
  }
  self.node = _id_C79916C8DF58D478;
  self._id_4EAD6B4FF3816236 = [];
  self.node._id_F16652E1462A3739 = 1;
  self.node.spawntype = "GAME_MODE";
  self.node.team = "team_hundred_ninety_five";
  self.node.showheadicon = 1;
  self.node.direction = 1;
  self.node.index = 0;
  self.vehicle = _id_96B8AB6BF1035B06();
  thread _id_3878E6CB9CF4E33F();
  self.vehicle _id_4BAC13D511590220::_id_1DA2C31423C2676A(level._id_035D525D711DE1B7.speed);
  self.vehicle _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  self.vehicle _meth_77320E794D35465A("p2p", "goalThreshold", level._id_035D525D711DE1B7.speed * 4);
  self.vehicle _meth_77320E794D35465A("p2p", "steeringMultiplier", 2.5);
  self.vehicle _meth_77320E794D35465A("p2p", "stuckTime", 4.0);
  self.vehicle._id_305797971B8E8DBA = self.node;
  self.vehicle thread _id_4BAC13D511590220::_id_C3889ABF5CD6ABBF(self.node, level._id_035D525D711DE1B7.speed);
}

_id_3878E6CB9CF4E33F() {
  self.vehicle waittill("death");
  self._id_FB41D1CA75009BF0 = self.vehicle scripts\cp_mp\vehicles\vehicle::_id_12F5A0E2344C10C5();

  if(isDefined(self._id_FB41D1CA75009BF0)) {
    foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236)
    self._id_FB41D1CA75009BF0 _id_7F20E60880A9BFDD(_id_B038ED928EC17A81);

    _id_71B01F0D4EC1F90D();
    self._id_FB41D1CA75009BF0 waittill("death");
  }

  foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236)
  _id_B038ED928EC17A81 freescriptable();
}

_id_F1323C29E2C131AF(offset, angles) {
  _id_A7D7579A649F51E7 = _func_4AD9053267734CF2(offset, self.origin, self.angles);
  _id_EEABF9578A5F3207 = combineangles(self.angles, angles);
  _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache_convoy_attack", _id_A7D7579A649F51E7, angles);
  _id_B038ED928EC17A81 scriptablesetparententity(self, offset, angles);
  _id_B038ED928EC17A81.offset = offset;
  _id_B038ED928EC17A81._id_4DDAAF082B9DCBB1 = angles;
  self._id_E0C08758EB0006BE._id_4EAD6B4FF3816236[self._id_E0C08758EB0006BE._id_4EAD6B4FF3816236.size] = _id_B038ED928EC17A81;
}

_id_7F20E60880A9BFDD(_id_B038ED928EC17A81) {
  _id_B038ED928EC17A81 scriptableclearparententity();
  _id_B038ED928EC17A81 scriptablesetparententity(self, _id_B038ED928EC17A81.offset, _id_B038ED928EC17A81._id_4DDAAF082B9DCBB1);
}

_id_96B8AB6BF1035B06() {
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.node.origin, 0, 1);
  _id_B4D3F717373AF2BB = _id_1C47017BA325709A::_id_236A093E8A0EC040("veh9_mil_cargo_truck");
  spawners = _id_1C47017BA325709A::_id_F260B1CEF943F1AB("veh9_mil_cargo_truck", 7, _id_B4D3F717373AF2BB, self.node.origin, _id_171F90B9C4C76D44, "absolute");
  riders = _id_1C47017BA325709A::_id_4AD6C25D6754F697(spawners, 7, undefined, "high", "convoy_attack", "convoy_attack", "team_hundred_ninety_five", undefined, "veh9_mil_cargo_truck_convoy_attack");

  if(riders.size > 0) {
    foreach(rider in riders)
    rider._id_C7845D939C783CEF = 1;
  }

  spawndata = spawnStruct();
  spawndata.origin = self.node.origin;
  spawndata.angles = (0, 0, 0);
  spawndata.spawntype = "GAME_MODE";
  spawndata.team = "team_hundred_ninety_five";
  spawndata.showheadicon = 1;
  spawndata._id_F16652E1462A3739 = 1;
  _id_EE8DA5624236DC89 = spawnStruct();
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", spawndata, _id_EE8DA5624236DC89);
  vehicle._id_7EE6203C5532A9E6 = 1;
  vehicle._id_E0C08758EB0006BE = self;
  vehicle._id_EB504FC7E1CFEB4C = 1;

  if(riders.size > 0)
    vehicle thread _id_15CF713DCBF2C97F(riders[0]);

  waitframe();
  vehicle scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders, 1, 1);
  vehicle _id_F1323C29E2C131AF((33, 23, 10), (0, 90, 0));
  vehicle _id_F1323C29E2C131AF((33, -23, 10), (0, 90, 0));
  return vehicle;
}

_id_71B01F0D4EC1F90D() {
  if(istrue(self._id_AE2F44687C8AFA77)) {
    return;
  }
  self._id_AE2F44687C8AFA77 = 1;

  foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236)
  _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
}

_id_15CF713DCBF2C97F(driver) {
  self endon("death");
  self endon("unloaded");
  driver waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self._id_E0C08758EB0006BE _id_71B01F0D4EC1F90D();
  _id_2B736EB3FDD9B328::_id_AB0EE2215EB51DD5("combat");
}