/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3b23ba56a2983e0e.gsc
***********************************************/

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_775C4A885C388CB8", 1);
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_90197611FDF280C3", 1);
  _id_337BD370F7C5E6F9::registerpublicevent(18, _id_7EC7671A1E0C788F);
  thread _id_046E8EE30ABAD44E();
}

_id_046E8EE30ABAD44E() {
  setDvar(_func_2EF675C13CA1C4AF("scr_", "chopper", "_disabled"), 1);
  setDvar("dvar_0FB9F16D91BCC8A8", 0);
  setDvar("dvar_85E8885FCE5027E7", "veh_airdrop_escort_champion_phys");
  setDvar("dvar_FAD92B3F5A4631F2", "veh9_mil_air_heli_hind_champion_weapons");
  level._id_D8D4808549090419 = ::_id_E95064540E994184;
  level._id_22ABCD778E5212B6 = ::_id_0AE49568842BCE7E;

  if(getdvarint("dvar_58163C73F7FBAB8C", 0))
    scripts\cp_mp\utility\script_utility::registersharedfunc("br_lootchopper", "championChopper_onCrateUse", ::_id_27BA806914C925D9);

  level _id_2FDEB8023287BE67::_id_1CCD859721E5EAEE();
  _id_E2958F412A7425C0 = level._id_6A4C9FBD7AA58544["chopper"];
  [[_id_E2958F412A7425C0._id_EC2EC5F083DF61CD]](_id_E2958F412A7425C0);
}

_id_C9E871D29702E8CF() {}

validatefunc() {
  return scripts\mp\utility\game::getsubgametype() == "champion";
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  _id_98489428013A0100 = calculateeventstarttime();
  wait(_id_98489428013A0100);
}

activatefunc() {
  level endon("game_ended");
  scripts\mp\hud_util::showsplashtoall("br_champion_chopper_event_start");
  _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_choppers_start");
  setomnvar("ui_publicevent_minimap_pulse", 1);
  _id_7A5DADB6081D4303 = getdvarint("dvar_2B0E04A31A35CC57", 1);
  spawnchoppers(_id_7A5DADB6081D4303);
}

calculateeventstarttime() {
  _id_87940078241E4580 = getdvarfloat("dvar_43560F4E801B8DDA", 60);
  _id_07AF9598177DC2DE = getdvarfloat("dvar_4378F94E8041A530", 120);

  if(_id_07AF9598177DC2DE > _id_87940078241E4580)
    return randomfloatrange(_id_87940078241E4580, _id_07AF9598177DC2DE);
  else
    return _id_87940078241E4580;
}

spawnchoppers(_id_7A5DADB6081D4303) {
  _id_B8CE4D2921224D79 = _id_69598A9E902CE145();

  if(_id_7A5DADB6081D4303 > _id_B8CE4D2921224D79.size)
    _id_7A5DADB6081D4303 = _id_B8CE4D2921224D79.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7A5DADB6081D4303; _id_AC0E594AC96AA3A8++) {
    _id_D20CABB504F78F36 = spawnStruct();
    _id_D20CABB504F78F36.origin = _id_B8CE4D2921224D79[_id_AC0E594AC96AA3A8];
    _id_2FDEB8023287BE67::_id_7D97C0571433F835("chopper", _id_D20CABB504F78F36);
  }
}

_id_69598A9E902CE145() {
  _id_B8CE4D2921224D79 = [];

  foreach(_id_171F90B9C4C76D44, origin in level._id_ACF99124377543BB) {
    if(_id_2695A20D4011076D::ispointincurrentsafecircle(origin))
      _id_B8CE4D2921224D79[_id_B8CE4D2921224D79.size] = origin;
  }

  return scripts\engine\utility::array_randomize(_id_B8CE4D2921224D79);
}

_id_E95064540E994184(_id_3CFEBEB76C5403A7) {
  chopper = _id_3CFEBEB76C5403A7.chopper;
  scripts\mp\vehicles\damage::set_death_callback(chopper.vehiclename, ::_id_31529A6224103B1A);
  chopper.lootfunc = ::_id_92AF99C896C92C0B;
  chopper playLoopSound("br_heli_infil_hero_lp");
  objidnum = _id_3CFEBEB76C5403A7.objidnum;
  scripts\mp\objidpoolmanager::update_objective_icon(objidnum, "hud_icon_minimap_vehicle_heli_hind");
  scripts\mp\objidpoolmanager::update_objective_ownerteam(objidnum, chopper.team);
}

_id_92AF99C896C92C0B() {
  if(getdvarint("dvar_58163C73F7FBAB8C", 0)) {
    _id_76A22C18960F72AF = _id_271667045665E514::lootchopper_finddroplocation(self.origin + (0, 0, 500));

    if(isDefined(_id_76A22C18960F72AF)) {
      _id_0E38F5EC33ED2CB0 = scripts\cp_mp\killstreaks\airdrop::dropbrlootchoppercrateforpublicevent(self.origin, _id_76A22C18960F72AF);
      _id_0E38F5EC33ED2CB0.usetimeoverride = 10;
    } else {}
  }

  playsoundatpos(self.origin, "ks_support_chopper_explode");
}

_id_27BA806914C925D9(player) {
  _id_6B5E1783915835C1 = "mp/loot/br/champion_mgl/lootset_supply_drop_boss.csv";
  self.itemsdropped = 0;
  _id_E05413A53B5D9167 = [];
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 0, 1, "killstreak", _id_6B5E1783915835C1);
  _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);
  _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 4, 1, "weapon", _id_6B5E1783915835C1);
  _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);
  _id_1361F1A11BA15C7E = _id_552B8E4EA5FF7DF1::chooseandspawnitems(dropstruct, 4, 1, "plunder", _id_6B5E1783915835C1);
  _id_E05413A53B5D9167 = scripts\engine\utility::array_combine(_id_E05413A53B5D9167, _id_1361F1A11BA15C7E);

  foreach(ent in _id_E05413A53B5D9167)
  ent.lootsource = "c130_box";

  if(!isDefined(player.lootcachesopened))
    player.lootcachesopened = 1;
  else
    player.lootcachesopened++;

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6499CE3D42F1C7D2");
}

_id_31529A6224103B1A(data) {
  instance = self._id_0566868292EE2A1B;

  if(isDefined(instance)) {
    instance notify("boss_death");
    instance._id_6181D0250AFA3CEC = 1;
    instance._id_6181DE250AFA5BB6 = data.attacker;
  }

  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  _id_AA4375C53E07B7EC(data);
  thread _id_20FC47823E95E4AF::_id_103478F5D3688256(self, data.attacker);
  self notify("death");
  return 1;
}

_id_AA4375C53E07B7EC(data) {
  team = data.attacker.team;
  chopper = self;

  if(!isstring(team)) {
    return;
  }
  data.attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_ADB08E37172D8EF2");
}

_id_0AE49568842BCE7E(_id_3CFEBEB76C5403A7, player) {
  _id_47BDE44B1ACEC603 = _id_3CFEBEB76C5403A7.name;
  _id_E2958F412A7425C0 = level._id_6A4C9FBD7AA58544[_id_47BDE44B1ACEC603];

  if(isDefined(_id_E2958F412A7425C0._id_7232C52496C3A94A))
    _id_3CFEBEB76C5403A7[[_id_E2958F412A7425C0._id_7232C52496C3A94A]](player, 0);
}