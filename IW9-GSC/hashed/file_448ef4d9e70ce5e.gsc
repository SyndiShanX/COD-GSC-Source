/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_448ef4d9e70ce5e.gsc
***********************************************/

main() {
  _id_4B87F2871B6B025C::_id_E05AEEC06B7B52AA(::_id_04DA231B2893604C, ::_id_DE1545C98ED439F8, ::_id_0A62D0F50F690359, ::_id_DD47832CD570074B, ::_id_BE3314F77FEF5D6B, ::_id_0F6C33CF49E7246E, ::_id_71106DD668C1BCAB, ::_id_230B60EF0852DCB8, ::_id_A699C74CE724A801, ::_id_E1B16133A0146153);
  _id_A76B0A124A6A8F46();
  _id_3E689374A8C8C3A2();

  while(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("aggregator", "registerOnPlayerSpawnCallback"))
    waitframe();

  [[scripts\cp_mp\utility\script_utility::getsharedfunc("aggregator", "registerOnPlayerSpawnCallback")]](::_id_9AC5625CAF26591E);
}

_id_9AC5625CAF26591E() {
  thread _id_4B87F2871B6B025C::_id_FC7D07D4CC7AE9F1();
}

_id_3E689374A8C8C3A2(_id_B3A75D9ABCE87A6C, _id_A21C47B05ECE35D7) {
  if(!isDefined(level._id_C3A0F3B16CCE4CA9._id_E19572257DC28EEB))
    level._id_C3A0F3B16CCE4CA9._id_E19572257DC28EEB = spawnStruct();

  if(isDefined(_id_B3A75D9ABCE87A6C))
    level._id_C3A0F3B16CCE4CA9._id_E19572257DC28EEB.normal = _id_B3A75D9ABCE87A6C;
  else
    level._id_C3A0F3B16CCE4CA9._id_E19572257DC28EEB.normal = 23;

  if(isDefined(_id_A21C47B05ECE35D7))
    level._id_C3A0F3B16CCE4CA9._id_E19572257DC28EEB.sprint = _id_A21C47B05ECE35D7;
  else
    level._id_C3A0F3B16CCE4CA9._id_E19572257DC28EEB.sprint = 15;
}

_id_04DA231B2893604C() {
  if(self _meth_635E39FC16A64657())
    _id_F9FA7B3DE81FB81A = level._id_C3A0F3B16CCE4CA9._id_E19572257DC28EEB.sprint;
  else
    _id_F9FA7B3DE81FB81A = level._id_C3A0F3B16CCE4CA9._id_E19572257DC28EEB.normal;

  return _id_F9FA7B3DE81FB81A;
}

_id_DE1545C98ED439F8() {
  if(self _meth_635E39FC16A64657())
    return 4.0;
  else
    return 6.0;
}

_id_0A62D0F50F690359() {
  return 6.0;
}

_id_0F6C33CF49E7246E() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_swimming"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_swimming");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("stealth", "revertAiAccuracy"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("stealth", "revertAiAccuracy")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "surfaceFunc"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "surfaceFunc")]]();

  if(istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("scubaGasMask", "hasScubaGasMask", self)))
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("scubaGasMask", "updateScubaGasmask", self, 0);
}

_id_71106DD668C1BCAB() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_swimming");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("stealth", "dropAiAccuracy"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("stealth", "dropAiAccuracy")]]();

  if(istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("scubaGasMask", "hasScubaGasMask", self))) {
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("scubaGasMask", "updateScubaGasmask", self, 1);
    thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("scubaGasMask", "monitorScubaGasMaskDamage");
  }
}

_id_DD47832CD570074B() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "ftue_triggerTip"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "ftue_triggerTip")]]("br_ftue_swimming");
}

_id_BE3314F77FEF5D6B() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_B2F95A220A66B955 = self getcurrentweapon();

    if(isDefined(_id_B2F95A220A66B955))
      self switchtoweaponimmediate(_id_B2F95A220A66B955);
  }
}

_id_230B60EF0852DCB8(_id_78264A131B0E70AC, _id_1DDC31DC2F8FAA49, _id_232AA0A9F1E032DD) {
  if(!isDefined(_id_232AA0A9F1E032DD))
    _id_232AA0A9F1E032DD = self;

  if(isDefined(_id_1DDC31DC2F8FAA49))
    self playSound(_id_1DDC31DC2F8FAA49, self);

  _id_232AA0A9F1E032DD playsoundtoplayer(_id_78264A131B0E70AC, self, _id_232AA0A9F1E032DD);
}

_id_E1B16133A0146153() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    data = spawnStruct();
    data.allowairexit = 1;
    data.exittype = "INVOLUNTARY";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(self.vehicle, undefined, self, data, 1);

    while(self _meth_793F941D7DFF15ED())
      waitframe();
  }

  scripts\common\utility::trycall(level._id_DA6CB768C7CA7B39);
  return makeweapon("iw9_drown_mp");
}

_id_A699C74CE724A801(_id_FC0043E95242D5CB, _id_B18D3429CF88F29F) {
  self visionsetnakedforplayer(_id_FC0043E95242D5CB, _id_B18D3429CF88F29F);
}

_id_AFB40A34C99DC4E4(objweapon) {
  return isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "iw9_drown_mp";
}

_id_A76B0A124A6A8F46() {
  for(_id_17E0E568853307D3 = 1; _id_17E0E568853307D3 <= 4; _id_17E0E568853307D3++) {
    _id_6AB8CED775EA3F3F = getEntArray("trigger_multiple_mp_proto_current_" + _id_17E0E568853307D3, "classname");

    foreach(_id_9D8A746C25F33AB6 in _id_6AB8CED775EA3F3F) {
      _id_9D8A746C25F33AB6._id_17E0E568853307D3 = _id_17E0E568853307D3;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "makeEnterExitTrigger"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "makeEnterExitTrigger")]](_id_9D8A746C25F33AB6, ::_id_46C5EDF87B46FC60, ::_id_D1EC9743B2C9EA9E);
    }
  }
}

_id_46C5EDF87B46FC60(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  player _meth_923D9644AB0B076F(trigger._id_17E0E568853307D3, 1);
}

_id_D1EC9743B2C9EA9E(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
  player _meth_923D9644AB0B076F(trigger._id_17E0E568853307D3, 0);
}