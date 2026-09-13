/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_lootcratedrop.gsc
*****************************************************************/

main() {
  level thread _id_566F849E77540164();
}

_id_566F849E77540164() {
  level endon("disable_public_event");
  level endon("game_ended");

  if(isDefined(level._id_034714CE799B6017) && !level._id_034714CE799B6017) {
    return;
  }
  level waittill("init_public_event");
  init();
}

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_E03D399538AF12FE", 2);
  _id_7EC7671A1E0C788F.validatefunc = ::_id_A78763EA0CF7510E;
  _id_7EC7671A1E0C788F.activatefunc = ::_id_71B5F57CD836A45D;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_E85CF8591EC416E4;
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_0FDD3801A5F5CF93", 0);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("plunder_crate", "00 0 00 0 0 0");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("plunder_crate");
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_cashcrate", "cashCrate_onCrateUse", ::_id_FC6FFFAED5B50C85);
  _id_337BD370F7C5E6F9::registerpublicevent(11, _id_7EC7671A1E0C788F);
}

_id_E85CF8591EC416E4() {
  thread _id_FAE94A598DCE531E();
  _id_C9E871D29702E8CF();
}

_id_87E6691E7D8C03AC() {
  _id_C9E871D29702E8CF();
}

_id_A77E39E3A8937837() {
  _id_C9E871D29702E8CF();
}

_id_C9E871D29702E8CF() {
  if(isDefined(level._id_09B34D707B8D9D76)) {
    return;
  }
  level._id_09B34D707B8D9D76 = 1;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    game["dialog"]["cash_drop"] = "bm_event_airdrop";
  else
    game["dialog"]["cash_drop"] = "cash_wzan_incm";

  game["dialog"]["weapon_drop"] = "drop_resupply";
  game["dialog"]["medical_drop"] = "medical_announcement";
  level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
}

_id_A78763EA0CF7510E() {
  return 1;
}

_id_1D60C987A31953A6() {
  return 1;
}

_id_599C8B86B0FEDE65() {
  return 1;
}

_id_71B5F57CD836A45D() {
  _id_BE12B3D2A01E1295(3);
}

_id_183F7F5CEB7A8F3B() {
  _id_BE12B3D2A01E1295(1);
}

_id_921E8477FDBB38BA() {
  _id_BE12B3D2A01E1295(2);
}

_id_BE12B3D2A01E1295(_id_AFB1E307CA3C0ED7) {
  level._id_6A7847BED8F16264 = getdvarfloat("dvar_302F97714CAE9D45", 5);
  _id_7CE5358B6AFBDF68 = spawnStruct();

  switch (_id_AFB1E307CA3C0ED7) {
    case 3:
      level._id_EAF636CC14E840AE = getdvarint("dvar_73E1B59A77872E46", 15000);
      level thread _id_271667045665E514::init();
      level thread scripts\cp_mp\killstreaks\airdrop::_id_53A94FEE5954AF57();
      _id_7CE5358B6AFBDF68._id_B5AF62407C69ADC9 = "battle_royale_cash_crate";
      _id_7CE5358B6AFBDF68._id_5411956FB9CDC64D = "active";
      _id_7CE5358B6AFBDF68._id_CF327C477C7CD3F0 = "cashdrop_common_world";
      _id_7CE5358B6AFBDF68._id_2833481BEF266A60 = "on";
      _id_7CE5358B6AFBDF68._id_73028FDD377ED0C4 = "br_plunder_pe_cash_drop_active";
      _id_7CE5358B6AFBDF68._id_548D317A24C84E75 = "splash_list_br_plunder_iw9_mp";
      _id_7CE5358B6AFBDF68._id_7A39E7C938990279 = "cash_drop";
      level._id_2831FF636B688BF5 = 0;
      break;
  }

  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata(_id_7CE5358B6AFBDF68._id_B5AF62407C69ADC9);

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE_LOADOUT";
  else
    _id_962A30A9BB8C0F09.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";

  _id_962A30A9BB8C0F09.minimapicon = undefined;

  if(isDefined(_id_962A30A9BB8C0F09._id_C9042CDFE65FB49D))
    _id_7CE5358B6AFBDF68._id_5411956FB9CDC64D = _id_962A30A9BB8C0F09._id_C9042CDFE65FB49D;

  if(!istrue(_id_962A30A9BB8C0F09._id_A07A6CC29E3B5458) && isDefined(_id_7CE5358B6AFBDF68._id_73028FDD377ED0C4))
    _id_337BD370F7C5E6F9::showsplashtoall(_id_7CE5358B6AFBDF68._id_73028FDD377ED0C4, _id_7CE5358B6AFBDF68._id_548D317A24C84E75);

  _id_2CEDCC356F1B9FC8::brleaderdialog(_id_7CE5358B6AFBDF68._id_7A39E7C938990279, 1);
  numcrates = getdvarint("dvar_3CB6406502812DC6", 10);
  level._id_2A89743460772EA0 = [];
  _id_261E315C49E5E4EF::_id_607167C18661377B([1], "pe_crate_drop");
}

_id_1E632783FE9D057D(_id_8EE83E2CBD3D747D, dropstruct) {
  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata("battle_royale_cash_crate");
  _id_5D11A6A17E49FDB3 = undefined;
  _id_8DF771DFD9CC0975 = undefined;
  cratetype = "battle_royale_cash_crate";
  _id_ED2C1553CA1BD30B = (_id_8EE83E2CBD3D747D[0], _id_8EE83E2CBD3D747D[1], 0) + (0, 0, level._id_5D2AF95280A3CF58);
  _id_90D4FE050E6864D4 = (0, randomfloat(360), 0);
  _id_DDB9D36F435AD444 = _id_8EE83E2CBD3D747D;
  crate = scripts\cp_mp\killstreaks\airdrop::dropcrate(_id_5D11A6A17E49FDB3, _id_8DF771DFD9CC0975, cratetype, _id_ED2C1553CA1BD30B, _id_90D4FE050E6864D4, _id_DDB9D36F435AD444);

  if(!isDefined(crate)) {
    return;
  }
  if(!istrue(_id_962A30A9BB8C0F09._id_9EA9E33FA2A90171)) {
    crate setscriptablepartstate("trail", "active", 0);
    crate.smokesignal = spawn("script_model", _id_ED2C1553CA1BD30B + (0, 0, 58));
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal linkTo(crate);
    crate.smokesignal setscriptablepartstate("smoke_trail", "on");
  }

  _id_EF5D5141FDB51174 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(crate);
  _id_EF5D5141FDB51174.usetimeoverride = level._id_6A7847BED8F16264;
  crate setscriptablepartstate("objective_map", "cashdrop_common_world");
  crate.nevertimeout = 1;
  crate._id_13BA232EEE7E6069 = "ks_airdrop_crate_br";
  level._id_2A89743460772EA0[level._id_2A89743460772EA0.size] = crate;
  return crate;
}

_id_FC6FFFAED5B50C85(player) {
  self.itemsdropped = 0;

  if(!isDefined(level._id_87252118C429BD32))
    level._id_87252118C429BD32 = 0;
  else
    level._id_87252118C429BD32 = (level._id_87252118C429BD32 + 1) % 10;

  items = getscriptcachecontents("pe_crate_drop", level._id_87252118C429BD32);

  if(isDefined(items) && player scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance"))
    items = _id_552B8E4EA5FF7DF1::lootcontentsadjustkillchain(items, player);

  if(isDefined(items))
    _id_E05413A53B5D9167 = _id_552B8E4EA5FF7DF1::lootcachespawncontents(items, 0, player);

  if(!isDefined(player.lootcachesopened))
    player.lootcachesopened = 1;
  else
    player.lootcachesopened++;

  if(isDefined(self._id_7B5E5C2BBC8F9F79)) {
    objective_delete(self._id_7B5E5C2BBC8F9F79);
    scripts\mp\objidpoolmanager::returnobjectiveid(self._id_7B5E5C2BBC8F9F79);
    self._id_7B5E5C2BBC8F9F79 = undefined;
  }

  if(scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder")
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("lootCachesOpened", player.lootcachesopened);
}

_id_FAE94A598DCE531E() {
  level waittill("br_supply_drops_init");
  dropstruct = _id_046CF752D93DC17B::_id_69B2E5235BFB7998("pe_crate_drop", "military_carepackage_03_br", undefined, ::_id_FC6FFFAED5B50C85);
  dropstruct _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("pe_crate_drop", "spawnDropCrate", ::_id_1E632783FE9D057D);
  dropstruct._id_30DAF66A65A215E7 = 1;
  game["dialog"]["dropbag_incoming"] = "dpbi_wzan_gams";
}

deactivate() {
  foreach(crate in level._id_2A89743460772EA0) {
    if(!isDefined(crate)) {
      continue;
    }
    playFX(level.conf_fx["vanish"], crate.origin);

    if(isDefined(crate.smokesignal)) {
      crate.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
      crate.smokesignal delete();
    }

    crate scripts\cp_mp\killstreaks\airdrop::deletecrateimmediate();
    level._id_2A89743460772EA0 = scripts\engine\utility::array_remove(level._id_2A89743460772EA0, crate);
  }
}

_id_A7B6924C27B24419(_id_3AAB229635E84AE1) {
  _id_C35D9F1ADC6B131F = 0.0;

  foreach(circle in _id_3AAB229635E84AE1)
  _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + circle.radius;

  return _id_C35D9F1ADC6B131F;
}

_id_33EDFEFAB8F13307(_id_3AAB229635E84AE1, _id_3163D28D241D4273) {
  _id_C35D9F1ADC6B131F = 0.0;

  foreach(circle in _id_3AAB229635E84AE1) {
    _id_C35D9F1ADC6B131F = _id_C35D9F1ADC6B131F + circle.radius;

    if(_id_3163D28D241D4273 <= _id_C35D9F1ADC6B131F)
      return circle;
  }

  return undefined;
}

_id_24D2F715EEA2A268(_id_819EDACDACB810E4, _id_1062AD70C2EE0FD1, _id_5CAE8DADBF316A7D) {
  _id_DCB13E0878FB0DD4 = _id_FCC289142135E1A4(_id_819EDACDACB810E4, _id_1062AD70C2EE0FD1, _id_5CAE8DADBF316A7D);
  droppoint = _id_2695A20D4011076D::getrandompointinboundscircle(_id_DCB13E0878FB0DD4.origin, _id_DCB13E0878FB0DD4.radius, 0, 0.85, 1, 1);
  return droppoint;
}

_id_FCC289142135E1A4(_id_819EDACDACB810E4, _id_1062AD70C2EE0FD1, _id_5CAE8DADBF316A7D) {
  _id_A372A079062548CC = distance2d(_id_819EDACDACB810E4, _id_1062AD70C2EE0FD1);
  _id_BBE4C8002C4744EA = int(_id_5CAE8DADBF316A7D / 2);

  if(_id_A372A079062548CC != 0.0) {
    _id_B7F1626973B3920B = int(_id_1062AD70C2EE0FD1[0] - _id_BBE4C8002C4744EA / _id_A372A079062548CC * (_id_1062AD70C2EE0FD1[0] - _id_819EDACDACB810E4[0]));
    _id_B7F1616973B38FD8 = int(_id_1062AD70C2EE0FD1[1] - _id_BBE4C8002C4744EA / _id_A372A079062548CC * (_id_1062AD70C2EE0FD1[1] - _id_819EDACDACB810E4[1]));
  } else {
    _id_B7F1626973B3920B = int(_id_819EDACDACB810E4[0]);
    _id_B7F1616973B38FD8 = int(_id_819EDACDACB810E4[1]);
  }

  _id_B7F1646973B39671 = 0;
  _id_DCB13E0878FB0DD4 = spawnStruct();
  _id_DCB13E0878FB0DD4.origin = (_id_B7F1626973B3920B, _id_B7F1616973B38FD8, _id_B7F1646973B39671);
  _id_DCB13E0878FB0DD4.radius = _id_BBE4C8002C4744EA;
  return _id_DCB13E0878FB0DD4;
}