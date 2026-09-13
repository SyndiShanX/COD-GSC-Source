/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_34f71bd59550adcb.gsc
***********************************************/

_id_80D68C9701E1AEA5(data) {
  scripts\mp\flags::_id_1240434F4201AC9D("vehicle_patrol_paths_selected");
  level._id_035D525D711DE1B7 = spawnStruct();
  level._id_035D525D711DE1B7.speed = getdvarfloat("dvar_FFE88A9964EE8CDA", 20.0);
  level._id_035D525D711DE1B7._id_3FA7196496D9308B = getdvarint("dvar_CEAF6D7A5F1DB16E", 1);
  level._id_4B11054EAA9AA4EC = [];

  foreach(_id_AC0E594AC96AA3A8, _id_AC0E424AC96A7113 in level._id_9E7ADB59A0CB3E3D) {
    _id_AC0E424AC96A7113.origin = _id_AC0E424AC96A7113.path[0].origin;
    level._id_4B11054EAA9AA4EC[level._id_4B11054EAA9AA4EC.size] = _id_AC0E424AC96A7113;
  }

  _id_03314ADD7998AB13::_id_B713F2D39B34540F(data, ::_id_F04C99751CDC9E0C, level._id_4B11054EAA9AA4EC);
}

_id_F04C99751CDC9E0C(_id_EFA8EF05B190D7D0, node) {
  _id_B8EBE3F71A08AB40 = _id_6C4E8CEA70BF4B6D::_id_5F6D9FD82BDD2D05(_id_EFA8EF05B190D7D0);
  _id_B8EBE3F71A08AB40.funcs["onInit"] = ::_id_DB3D241C0C7AAD79;
  _id_B8EBE3F71A08AB40.funcs["onTeamAssigned"] = ::_id_2C9F290C95B69F86;
  _id_B8EBE3F71A08AB40.funcs["onPlayerJoined"] = ::_id_51D145A2E76E5A7B;
  _id_B8EBE3F71A08AB40.funcs["onPlayerRemoved"] = ::_id_0A7933EF4399591A;
  _id_B8EBE3F71A08AB40.funcs["onTeamStart"] = ::_id_075070F6092D4F6E;
  _id_B8EBE3F71A08AB40.funcs["onCancel"] = ::_id_D7EDC7EA0B792A79;
  _id_B8EBE3F71A08AB40.node = node;
  _id_B8EBE3F71A08AB40.ref = "dmz_convoy_attack";
  _id_B8EBE3F71A08AB40._id_30E8A65CFF941C7A = _id_64ACB6CE534155B7::getquesttableindex(_id_B8EBE3F71A08AB40.ref);
  return _id_B8EBE3F71A08AB40;
}

_id_DB3D241C0C7AAD79() {
  if(!isDefined(self.node)) {
    return;
  }
  _id_6C4E8CEA70BF4B6D::_id_C847BFD52C064289(self.node.origin + (0, 0, 60));

  if(!scripts\cp_mp\vehicles\vehicle::_id_FA537F1AB52A76D1("veh9_jltv_mg")) {
    _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
    return;
  }

  self._id_EFA8EF05B190D7D0.origin = self.node.origin;
  self._id_4EAD6B4FF3816236 = [];
  self.node._id_F16652E1462A3739 = 1;
  self.node.spawntype = "GAME_MODE";
  self.node.team = "team_hundred_ninety_five";
  self.node.showheadicon = 1;

  if(istrue(level._id_035D525D711DE1B7._id_3FA7196496D9308B))
    self.vehicle = _id_D54ED88824A6416E();
  else
    self.vehicle = _id_5751A98AFBCC56BD();

  scripts\mp\objidpoolmanager::update_objective_onentity(self.icon, self.vehicle);
  thread _id_6FB25F6B9A58B347();
  self.vehicle _id_4BAC13D511590220::_id_1DA2C31423C2676A(level._id_035D525D711DE1B7.speed);
  self.node.direction = 1;
  self.node.index = 0;
  self.vehicle _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  self.vehicle _meth_77320E794D35465A("p2p", "goalThreshold", level._id_035D525D711DE1B7.speed * 4);
  self.vehicle _meth_77320E794D35465A("p2p", "steeringMultiplier", 2.5);
  self.vehicle _meth_77320E794D35465A("p2p", "stuckTime", 4.0);
  self.vehicle._id_305797971B8E8DBA = self.node;
  self.vehicle thread _id_4BAC13D511590220::_id_C3889ABF5CD6ABBF(self.node, level._id_035D525D711DE1B7.speed);
}

_id_51D145A2E76E5A7B(player) {}

_id_0A7933EF4399591A(player) {}

_id_D7EDC7EA0B792A79(team) {}

_id_2C9F290C95B69F86(team) {
  _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_convoy_attack_assigned", team);
}

_id_075070F6092D4F6E(team) {}

_id_8250FD658E3AAE32() {
  _id_6C4E8CEA70BF4B6D::_id_629ED367D1393020();
}

_id_4377E070100DE7EC() {
  _id_8250FD658E3AAE32();

  if(isDefined(self.teams[0])) {
    _id_6C4E8CEA70BF4B6D::_id_CD4F277CF0D6A560(self.teams[0]);
    _id_6C4E8CEA70BF4B6D::_id_1759ACFD39BB5EDF("dmz_convoy_attack_success", self.teams[0]);
  }

  _id_6C4E8CEA70BF4B6D::_id_84E79AB809A8EEA3();
}

_id_6FB25F6B9A58B347() {
  self endon("task_ended");
  self.vehicle waittill("death");
  _id_30DEA07ECDA5DB65();
  thread _id_4377E070100DE7EC();
}

_id_5751A98AFBCC56BD() {
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_jltv_mg", self.node);
  vehicle._id_7EE6203C5532A9E6 = 1;
  vehicle._id_B8EBE3F71A08AB40 = self;
  vehicle._id_EB504FC7E1CFEB4C = 1;
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.node.origin, 0, 1);
  _id_B4D3F717373AF2BB = _id_1C47017BA325709A::_id_236A093E8A0EC040("veh9_jltv_mg");
  spawners = _id_1C47017BA325709A::_id_F260B1CEF943F1AB("veh9_jltv_mg", 4, _id_B4D3F717373AF2BB, self.node.origin, _id_171F90B9C4C76D44, "absolute");
  riders = _id_1C47017BA325709A::_id_4AD6C25D6754F697(spawners, 4, undefined, "absolute", "convoy_attack", "convoy_attack", "team_hundred_ninety_five", undefined, "veh9_jltv_mg");

  if(riders.size > 0) {
    foreach(rider in riders)
    rider._id_C7845D939C783CEF = 1;
  }

  if(isDefined(riders[1]))
    riders[1] setstealthstate("combat");

  vehicle scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders, 1, 1);
  return vehicle;
}

_id_859FFD6BDCF262A7(offset, angles) {
  _id_A7D7579A649F51E7 = _func_4AD9053267734CF2(offset, self.origin, self.angles);
  _id_EEABF9578A5F3207 = combineangles(self.angles, angles);
  _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache_convoy_attack", _id_A7D7579A649F51E7, angles);
  _id_B038ED928EC17A81 scriptablesetparententity(self, offset, angles);
  self._id_B8EBE3F71A08AB40._id_4EAD6B4FF3816236[self._id_B8EBE3F71A08AB40._id_4EAD6B4FF3816236.size] = _id_B038ED928EC17A81;
}

_id_D54ED88824A6416E() {
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_cargo_truck", self.node);
  vehicle._id_7EE6203C5532A9E6 = 1;
  vehicle._id_B8EBE3F71A08AB40 = self;
  vehicle._id_EB504FC7E1CFEB4C = 1;
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.node.origin, 0, 1);
  _id_B4D3F717373AF2BB = _id_1C47017BA325709A::_id_236A093E8A0EC040("veh9_mil_cargo_truck");
  spawners = _id_1C47017BA325709A::_id_F260B1CEF943F1AB("veh9_mil_cargo_truck", 7, _id_B4D3F717373AF2BB, self.node.origin, _id_171F90B9C4C76D44, "absolute");
  riders = _id_1C47017BA325709A::_id_4AD6C25D6754F697(spawners, 7, undefined, "absolute", "convoy_attack", "convoy_attack", "team_hundred_ninety_five", undefined, "veh9_mil_cargo_truck_convoy_attack");

  if(riders.size > 0) {
    vehicle thread _id_D9592F915EC62177(riders[0]);

    foreach(rider in riders)
    rider._id_C7845D939C783CEF = 1;
  }

  vehicle scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders, 1, 1);
  vehicle _id_859FFD6BDCF262A7((33, 23, 10), (0, 90, 0));
  vehicle _id_859FFD6BDCF262A7((33, -23, 10), (0, 90, 0));
  return vehicle;
}

_id_30DEA07ECDA5DB65() {
  if(istrue(self._id_AE2F44687C8AFA77)) {
    return;
  }
  self._id_AE2F44687C8AFA77 = 1;

  foreach(_id_B038ED928EC17A81 in self._id_4EAD6B4FF3816236)
  _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
}

_id_D9592F915EC62177(driver) {
  self endon("death");
  self endon("unloaded");
  driver waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self._id_B8EBE3F71A08AB40 _id_30DEA07ECDA5DB65();
  _id_2B736EB3FDD9B328::_id_AB0EE2215EB51DD5("combat");
}