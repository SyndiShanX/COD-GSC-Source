/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_restock.gsc
***********************************************************/

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_A5F3589998DA80AE", 1.0);
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F._id_0F4FD1F55EC89DED = ::_id_0F4FD1F55EC89DED;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_64910BCD2CE10275", 2);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("restock", "05 5 50 0 0 0");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("restock");
  _id_337BD370F7C5E6F9::registerpublicevent(7, _id_7EC7671A1E0C788F);
}

_id_C9E871D29702E8CF() {
  game["dialog"]["power_up_field_resupply"] = "pbvn_wzan_rstn";
  level._id_BD006676148E6C40 = [];
  level._id_0A688DD9515C7DEF = [];
  level._id_344F2168E7B1BC8E = [];
}

validatefunc() {
  return 1;
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
}

activatefunc() {
  level endon("game_ended");
  _id_337BD370F7C5E6F9::showsplashtoall("br_pe_restock_active");
  _id_2CEDCC356F1B9FC8::brleaderdialog("power_up_field_resupply", 1);

  foreach(instance in level._id_BD006676148E6C40) {
    if(!isDefined(instance)) {
      continue;
    }
    if(isDefined(instance.type) && instance.type == "br_reusable_loot_cache") {
      instance setscriptablepartstate("body", "closing");
      instance notify("closed");
      _id_5534E9F86D0272DD = "closing";
    } else
      _id_5534E9F86D0272DD = "closed_usable";

    instance setscriptablepartstate("body", _id_5534E9F86D0272DD);
    instance _id_F929DBB719836091();
    instance _id_C23984C8AF54D944();
  }
}

_id_0F4FD1F55EC89DED() {}

_id_F929DBB719836091() {
  level endon("game_ended");
  self endon("death");

  switch (self.type) {
    case "br_loot_cache":
      _id_8CD3AE6CB0D422DC();
      break;
    case "br_loot_cache_lege":
      _id_C7076B566F348B22();
      break;
    case "br_loot_cache_personal_supply":
    case "br_reusable_loot_cache":
    case "br_loot_cache_stronghold":
    case "br_loot_cache_blacksite":
      break;
    default:
      _id_EC86E04EB404CE02();
      break;
  }

  if(isDefined(self._id_276AC5E84835EA87))
    _id_744CAD313ED0A87E::_id_DF20D77FC7D6103C(self._id_276AC5E84835EA87, self);
}

_id_8CD3AE6CB0D422DC() {
  if(!isDefined(level._id_0A688DD9515C7DEF) || level._id_0A688DD9515C7DEF.size <= 0) {
    return;
  }
  _id_610520BE555433B2 = randomint(level._id_0A688DD9515C7DEF.size);
  self.contents = scripts\engine\utility::random(level._id_0A688DD9515C7DEF);
  scripts\engine\utility::array_remove_index(level._id_0A688DD9515C7DEF, _id_610520BE555433B2);
}

_id_C7076B566F348B22() {
  if(!isDefined(level._id_344F2168E7B1BC8E) || level._id_344F2168E7B1BC8E.size <= 0) {
    return;
  }
  _id_610520BE555433B2 = randomint(level._id_344F2168E7B1BC8E.size);
  self.contents = level._id_344F2168E7B1BC8E[_id_610520BE555433B2];
  scripts\engine\utility::array_remove_index(level._id_344F2168E7B1BC8E, _id_610520BE555433B2);
}

_id_EC86E04EB404CE02() {
  if(!isDefined(self._id_9632642B41DAD704)) {
    return;
  }
  self.contents = self._id_9632642B41DAD704;
}

_id_A5CBF2004CED4597() {
  return istrue(level._id_B06BB395C37B7AB8) && getdvarfloat("dvar_A5F3589998DA80AE", 0) || istrue(level._id_337628AE96A92FF2);
}

_id_6849C58E1CEC4248(items) {
  if(!isDefined(level._id_BD006676148E6C40))
    level._id_BD006676148E6C40 = [];

  if(!isDefined(level._id_0A688DD9515C7DEF))
    level._id_0A688DD9515C7DEF = [];

  if(!isDefined(level._id_344F2168E7B1BC8E))
    level._id_344F2168E7B1BC8E = [];

  switch (self.type) {
    case "br_loot_cache":
      level._id_0A688DD9515C7DEF = scripts\engine\utility::array_add(level._id_0A688DD9515C7DEF, items);
      level._id_BD006676148E6C40 = scripts\engine\utility::array_add(level._id_BD006676148E6C40, self);
      break;
    case "br_loot_cache_lege":
      level._id_344F2168E7B1BC8E = scripts\engine\utility::array_add(level._id_344F2168E7B1BC8E, items);
      level._id_BD006676148E6C40 = scripts\engine\utility::array_add(level._id_BD006676148E6C40, self);
      break;
    case "br_loot_cache_personal_supply":
    case "br_reusable_loot_cache":
    case "br_loot_cache_stronghold":
    case "br_loot_cache_blacksite":
      level._id_BD006676148E6C40 = scripts\engine\utility::array_add(level._id_BD006676148E6C40, self);
      break;
    case "br_secretstash_quest_cache":
    case "br_scavenger_quest_cache":
      break;
    default:
      break;
  }
}

_id_C23984C8AF54D944() {
  if(scripts\engine\utility::array_contains(level._id_BD006676148E6C40, self))
    level._id_BD006676148E6C40 = scripts\engine\utility::array_remove(level._id_BD006676148E6C40, self);
}