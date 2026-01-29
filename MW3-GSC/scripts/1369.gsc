/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1369.gsc
**************************************/

_id_4218() {
  _id_42FB();

  if(isplayer(self)) {
    return;
  }
  switch (self.team) {
    case "team3":
    case "axis":
      _id_4301();
      _id_4302();
      _id_4308();
      _id_4311();
      break;
    case "allies":
      _id_4317();
      _id_431A();
      _id_431D();
  }
}

_id_42FA(var_0, var_1) {
  level._id_2190[var_0] = var_1;
}

_id_42FB(var_0) {
  if(isplayer(self)) {
    _id_055E::_id_4219();
    return;
  }

  if(!isDefined(self._id_0B6E) || !isDefined(self._id_0B6E._id_423A._id_42FC)) {
    switch (self.team) {
      case "allies":
        _id_055E::_id_4219();
        _id_055F::_id_4235();
        break;
      case "team3":
      case "axis":
        _id_055D::_id_4268();
        _id_0560::_id_4281();
        break;
    }
  }

  if(isDefined(var_0)) {
    _id_42FD(var_0);

  }
  self._id_0B6E._id_423A._id_42FC = 1;
}

_id_42FD(var_0) {
  switch (self.team) {
    case "allies":
      _id_055F::_id_423B(var_0);
      break;
    case "team3":
    case "axis":
      _id_0560::_id_4287(var_0);
      break;
  }
}

_id_42FE() {
  switch (self.team) {
    case "allies":
      _id_055F::_id_423C();
      break;
    case "team3":
    case "axis":
      _id_0560::_id_4288();
      break;
  }
}

_id_42FF(var_0) {
  _id_055D::_id_427F(var_0);
}

_id_4300() {
  _id_055D::_id_4280();
}

_id_4301(var_0) {
  if(!isDefined(self._id_0B6E._id_423A._id_0AD9)) {
    maps\_stealth_threat_enemy::_id_4249();

  }
  if(isDefined(var_0)) {
    _id_4305(var_0);
  }
}

_id_4302() {
  self._id_4259 = 0;
}

_id_4303() {
  self._id_4259 = 1;
}

_id_4304(var_0, var_1) {
  if(isDefined(var_0)) {
    maps\_stealth_threat_enemy::_id_4261(var_0);

  }
  if(isDefined(var_1)) {
    maps\_stealth_threat_enemy::_id_4266(var_1);
  }
}

_id_4305(var_0, var_1) {
  var_2 = "threat";
  var_3 = "warning";
  var_4 = 1;
  var_5 = var_3 + var_4;

  if(isDefined(var_0)) {
    while(isDefined(self._id_0B6E._id_41D0._id_41D1[var_2][var_5])) {
      if(!isDefined(var_0[var_5])) {
        var_0[var_5] = maps\_stealth_shared_utilities::_id_41D2(var_2, var_5);

      }
      var_4++;
      var_5 = var_3 + var_4;
    }
  }

  _id_4304(var_0, var_1);
}

_id_4306() {
  var_0 = [];
  _id_4304(var_0);
}

_id_4307() {
  maps\_stealth_threat_enemy::_id_425E();
  maps\_stealth_threat_enemy::_id_4267();
}

_id_42F5(var_0) {
  level._id_0B6E._id_41ED._id_4272 = var_0;
}

_id_4308(var_0) {
  if(!isDefined(self._id_0B6E._id_423A._id_4250)) {
    _id_0561::_id_428A();

  }
  if(isDefined(var_0)) {
    _id_4309(var_0);
  }
}

_id_4309(var_0) {
  _id_0561::_id_42A8(var_0);
}

_id_430A() {
  _id_0561::_id_42A7();
}

_id_430B() {
  _id_0562::_id_42B3();
}

_id_430C(var_0) {
  _id_0562::_id_42B4(var_0);
}

_id_430D() {
  _id_0562::_id_42B1();
}

_id_430E(var_0) {
  _id_0562::_id_42B2(var_0);
}

_id_430F(var_0) {
  _id_0562::_id_42B6(var_0);
}

_id_4310() {
  _id_0562::_id_42B7();
}

_id_4311(var_0) {
  _id_4312();
  _id_0563::_id_42C0();

  if(isDefined(var_0)) {
    foreach(var_3, var_2 in var_0) {}
    _id_0563::_id_42C1(var_3, var_2);
  }
}

_id_4312() {
  if(!isDefined(self._id_0B6E._id_423A._id_0EFE)) {
    _id_0563::_id_42B8();
  }
}

_id_4313(var_0, var_1) {
  _id_4312();
  _id_0563::_id_42C1("heard_scream", var_0, var_1);
}

_id_4314(var_0, var_1) {
  _id_4312();
  _id_0563::_id_42C1("doFlashBanged", var_0, var_1);
}

_id_4315(var_0, var_1) {
  _id_4312();
  _id_0563::_id_42C1("explode", var_0, var_1);
}

_id_4316(var_0, var_1, var_2, var_3) {
  _id_4312();
  _id_0563::_id_42C1(var_0, var_1, var_2, var_3);
}

_id_4317(var_0) {
  if(!isDefined(self._id_0B6E._id_423A._id_42C8)) {
    _id_0564::_id_42C5();

  }
  if(isDefined(var_0)) {
    _id_4318(var_0);
  }
}

_id_4318(var_0) {
  _id_0564::_id_42C9(var_0);
}

_id_4319() {
  _id_0564::_id_42CA();
}

_id_431A(var_0) {
  if(!isDefined(self._id_0B6E._id_423A._id_42D1)) {
    _id_0565::_id_42CB();

  }
  if(isDefined(var_0)) {
    _id_431B(var_0);
  }
}

_id_431B(var_0) {
  _id_0565::_id_42D2(var_0);
}

_id_431C() {
  _id_0565::_id_42D3();
}

_id_431D() {
  _id_0566::_id_42D4();
}

_id_431E() {
  maps\_utility::_id_13DC("_stealth_stance_handler");
}

_id_431F() {
  maps\_utility::_id_13DE("_stealth_stance_handler");
}

_id_4320() {
  waittillframeend;
  maps\_utility::_id_13DB("_stealth_normal");
}

_id_4213() {
  var_0 = level._id_0B6E._id_1124.groups;

  foreach(var_7, var_2 in var_0) {
    var_3 = maps\_stealth_shared_utilities::_id_41E1(var_7);

    foreach(var_5 in var_3) {
      if(!var_5 maps\_utility::_id_1008("_stealth_normal")) {
        return 0;
      }
    }
  }

  return 1;
}

_id_4321() {
  _id_4320();
  waittillframeend;
  self notify("stealth_enemy_endon_alert");
}

_id_4322(var_0, var_1) {
  thread maps\_stealth_shared_utilities::_id_420F(var_0, var_1);
}

_id_4323(var_0, var_1) {
  maps\_stealth_visibility_system::_id_42F7(var_0, var_1);
}

_id_4324() {
  maps\_stealth_visibility_system::_id_42F6();
}

_id_4325(var_0) {
  _id_0562::_id_42B0(var_0);
}

_id_4326() {
  _id_0562::_id_42AF();
}

_id_4327(var_0) {
  var_1 = level._id_0B6E._id_41ED._id_4220;
  maps\_stealth_visibility_system::_id_42F9(var_0);
  maps\_stealth_visibility_system::_id_42E8(var_1);
}

_id_4328() {
  var_0 = level._id_0B6E._id_41ED._id_4220;
  maps\_stealth_visibility_system::_id_42F8();
  maps\_stealth_visibility_system::_id_42E8(var_0);
}

_id_4329(var_0, var_1) {
  _id_055E::_id_4234(var_0, var_1);
}

_id_432A() {
  _id_055E::_id_4233();
}

_id_432B(var_0, var_1, var_2) {
  _id_0566::_id_42E5(var_0, var_1, var_2);
}

_id_432C() {
  _id_0566::_id_42E4();
}

_id_432D(var_0) {
  maps\_stealth_shared_utilities::_id_420C(var_0);
}

_id_432E() {
  maps\_stealth_shared_utilities::_id_420B();
}

_id_432F(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {}

  var_0 _id_4336();
  var_5 = var_0 maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");

  if(common_scripts\utility::flag(var_5)) {
    return;
  }
  var_6 = "stop_loop";
  var_0.allowdeath = 1;

  if(!isDefined(var_4)) {
    thread maps\_anim::_id_11CD(var_0, "gravity", var_1, var_3);
  } else {
    thread maps\_anim::_id_11C8(var_0, var_1, var_3);

  }
  var_0 maps\_stealth_shared_utilities::_id_420D(self, var_2, var_3, var_6);
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "stop_idle_proc");
  maps\_utility::_id_1DB1(::_id_432D);
  thread _id_4330();
}

_id_4330() {
  self endon("death");
  maps\_utility::_id_275B();
}

_id_4331(var_0, var_1, var_2) {
  var_0 _id_4336();
  var_0 maps\_stealth_shared_utilities::_id_420D(self, var_1, var_2, "stop_loop");
}

_id_4332(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_4336();
  thread _id_4333(var_0, var_1, var_2, var_3, var_4);
}

_id_4333(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_4336();
  var_0 thread _id_4321();
  var_0 endon("stealth_enemy_endon_alert");
  var_0 endon("death");
  maps\_anim::_id_11C4(var_0, var_1, var_4);
  _id_432F(var_0, var_2, var_3, var_4);
}

_id_4334(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_4336();
  thread _id_4335(var_0, var_1, var_2, var_3, var_4);
}

_id_4335(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_4336();
  var_0 thread _id_4321();
  var_0 endon("stealth_enemy_endon_alert");
  var_0 endon("death");
  maps\_anim::_id_11C5(var_0, var_1, var_4);
  _id_432F(var_0, var_2, var_3, var_4);
}

_id_4336() {}

_id_4337() {
  return maps\_stealth_shared_utilities::_id_41DE("_stealth_spotted");
}

_id_4338() {
  return maps\_stealth_shared_utilities::_id_41DE("_stealth_event");
}

_id_4339() {
  return maps\_stealth_shared_utilities::_id_41DE("_stealth_found_corpse");
}

_id_433A() {
  return maps\_stealth_shared_utilities::_id_41DF("_stealth_spotted");
}

_id_433B() {
  return maps\_stealth_shared_utilities::_id_41DF("_stealth_event");
}

_id_433C() {
  return maps\_stealth_shared_utilities::_id_41DF("_stealth_found_corpse");
}

_id_4208() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
  return common_scripts\utility::flag(var_0);
}

_id_4271() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_found_corpse");
  return common_scripts\utility::flag(var_0);
}

_id_41CC() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
  common_scripts\utility::flag_wait(var_0);
}

_id_428D() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_found_corpse");
  common_scripts\utility::flag_wait(var_0);
}

_id_41CD() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
  return common_scripts\utility::flag_waitopen(var_0);
}

_id_4292() {
  var_0 = maps\_stealth_shared_utilities::_id_41DB("_stealth_found_corpse");
  return common_scripts\utility::flag_waitopen(var_0);
}

_id_4215() {
  return maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");
}

_id_4216() {
  return maps\_stealth_shared_utilities::_id_41DB("_stealth_found_corpse");
}

_id_433D(var_0) {
  _id_433F(var_0);
}

_id_433E() {
  _id_433F("default");
}

_id_433F(var_0) {
  if(isDefined(self._id_204F)) {
    level._id_0B6E._id_1124.groups[self._id_204F] = common_scripts\utility::array_remove(level._id_0B6E._id_1124.groups[self._id_204F], self);

  }
  self._id_204F = maps\_utility::string(var_0);

  if(isDefined(self._id_0B6E._id_423A._id_42FC)) {
    maps\_stealth_shared_utilities::_id_41D9("_stealth_spotted");
    maps\_stealth_shared_utilities::_id_41D9("_stealth_event");
    maps\_stealth_shared_utilities::_id_41D9("_stealth_found_corpse");
    maps\_stealth_shared_utilities::_id_41DA();
  }
}

_id_4340() {
  return self._id_204F;
}

_id_4341() {
  common_scripts\utility::flag_set("_stealth_enabled");
  var_0 = getaispeciesarray("all", "all");

  foreach(var_3, var_2 in var_0) {}
  var_2 _id_4343();

  foreach(var_5 in level.players) {}
  var_5 _id_055E::_id_421A();

  maps\_stealth_visibility_system::_id_42E8("hidden");
}

_id_4342() {
  common_scripts\utility::flag_clear("_stealth_enabled");
  var_0 = getaispeciesarray("all", "all");

  foreach(var_3, var_2 in var_0) {}
  var_2 _id_4344();

  foreach(var_5 in level.players) {
    var_5.maxvisibledist = 8192;

    if(var_5 maps\_utility::_id_133C("_stealth_enabled")) {
      var_5 maps\_utility::_id_13DE("_stealth_enabled");
    }
  }

  maps\_stealth_visibility_system::_id_42E8("spotted");
}

_id_4343() {
  if(maps\_utility::_id_133C("_stealth_enabled")) {
    maps\_utility::_id_13DC("_stealth_enabled");

  }
  if(self.team == "allies") {
    _id_055E::_id_421A();
  }
}

_id_4344() {
  if(maps\_utility::_id_133C("_stealth_enabled")) {
    maps\_utility::_id_13DE("_stealth_enabled");

  }
  self.maxvisibledist = 8192;
}