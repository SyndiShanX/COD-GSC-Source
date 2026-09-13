/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_plundermultipliers.gsc
**********************************************************************/

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
  level._id_16EF52214AC3A63F = spawnStruct();
  _id_9CD269534FFD4DC9 = spawnStruct();
  _id_9CD269534FFD4DC9.validatefunc = ::_id_E7A80B9A5971257A;
  _id_9CD269534FFD4DC9.weight = getdvarfloat("dvar_5AE34E37A601D081", 0);
  _id_9CD269534FFD4DC9.activatefunc = ::_id_041B1AFBE1C7AF99;
  _id_9CD269534FFD4DC9.waitfunc = ::_id_AEC5C0A5B73AE7C5;
  _id_9CD269534FFD4DC9._id_C9E871D29702E8CF = ::_id_ADC3E7F53E3456D0;
  _id_9CD269534FFD4DC9._id_D72A1842C5B57D1D = getdvarint("dvar_77820DD4991EF008", 3);
  _id_9CD269534FFD4DC9._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("bloodmoney", "0 0 0 0 0 0 0 0 0 0 0 0");
  _id_9CD269534FFD4DC9._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("bloodmoney");
  _id_9CD269534FFD4DC9._id_4E378291CBEA730E = 10;
  _id_9CD269534FFD4DC9._id_45620A2820463E6E = getdvarint("dvar_290BF19648DC8EB2", 2);
  _id_9CD269534FFD4DC9._id_EE5FB771F83ADD5E = getdvarfloat("dvar_8685285F3DB98A1C", 2);
  _id_9CD269534FFD4DC9.duration = getdvarint("dvar_4E87BB76AFE4EB45", 120);
  _id_9CD269534FFD4DC9.type = 12;
  _id_337BD370F7C5E6F9::registerpublicevent(12, _id_9CD269534FFD4DC9);
  _id_58F5EACB6ED4BBB6 = spawnStruct();
  _id_58F5EACB6ED4BBB6.validatefunc = ::_id_6150C8F67E691807;
  _id_58F5EACB6ED4BBB6.weight = getdvarfloat("dvar_BF4B6E943F2046F4", 0);
  _id_58F5EACB6ED4BBB6.activatefunc = ::_id_05D935DB1C627D80;
  _id_58F5EACB6ED4BBB6.waitfunc = ::_id_55B066077526E9D4;
  _id_58F5EACB6ED4BBB6._id_C9E871D29702E8CF = ::_id_3C14F9DF7EFC9951;
  _id_58F5EACB6ED4BBB6._id_D72A1842C5B57D1D = getdvarint("dvar_AAAA5E6F854C6C0F", 3);
  _id_58F5EACB6ED4BBB6._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("contractor", "0 0 0 0 0 0 0 0 0 0 0 0");
  _id_58F5EACB6ED4BBB6._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("contractor");
  _id_58F5EACB6ED4BBB6._id_4E378291CBEA730E = 11;
  _id_58F5EACB6ED4BBB6._id_046A451F9012BD1C = getdvarint("dvar_F4F0D78CE0DA6030", 2);
  _id_58F5EACB6ED4BBB6.duration = getdvarint("dvar_5B1205EC7121272C", 120);
  _id_58F5EACB6ED4BBB6.type = 15;
  _id_337BD370F7C5E6F9::registerpublicevent(15, _id_58F5EACB6ED4BBB6);
  _id_A5B707E79D910EF6 = spawnStruct();
  _id_A5B707E79D910EF6.validatefunc = ::_id_98E0AAB5F4A07947;
  _id_A5B707E79D910EF6.weight = getdvarfloat("dvar_72968933B31BBB6D", 0);
  _id_A5B707E79D910EF6.activatefunc = ::_id_8645E7BA0E3942C0;
  _id_A5B707E79D910EF6.waitfunc = ::_id_B44E7B12BCDC2C14;
  _id_A5B707E79D910EF6._id_C9E871D29702E8CF = ::_id_EF3989DD64896A91;
  _id_A5B707E79D910EF6._id_D72A1842C5B57D1D = getdvarint("dvar_4DD2F44C13BAE3F4", 3);
  _id_A5B707E79D910EF6._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("money_siphon", "0 0 0 0 0 0 0 0 0 0 0 0");
  _id_A5B707E79D910EF6._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("money_siphon");
  _id_337BD370F7C5E6F9::registerpublicevent(14, _id_A5B707E79D910EF6);
}

_id_CA6E399C0A8A91B6(_id_5125C340EACE0872, eventname) {
  level endon("game_ended");
  _id_337BD370F7C5E6F9::showsplashtoall("br_plunder_pe_" + eventname + "_active", "splash_list_br_plunder_iw9_mp");
  _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_" + eventname + "_start");
  setomnvar("ui_publicevent_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", _id_5125C340EACE0872._id_4E378291CBEA730E);
  eventduration = _id_5125C340EACE0872.duration;
  _id_91A988004AA42D31 = gettime() + eventduration * 1000;
  setomnvar("ui_publicevent_timer", _id_91A988004AA42D31);
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();

  if(isDefined(_id_5125C340EACE0872._id_40177224043652F0))
    [[_id_5125C340EACE0872._id_40177224043652F0]]();
  else
    _id_5125C340EACE0872.active = 1;

  thread _id_23913A35C5EBD726(eventname);
  _id_49978E5850A50D57 = 5;

  if(eventduration > _id_49978E5850A50D57)
    wait(eventduration - _id_49978E5850A50D57);
  else
    _id_49978E5850A50D57 = int(eventduration);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_49978E5850A50D57; _id_AC0E594AC96AA3A8++) {
    _id_FC7BD6576D8C85BE playSound("ui_mp_fire_sale_timer");
    wait 1.0;
  }

  if(isDefined(_id_5125C340EACE0872._id_BD73A31917F54451))
    [[_id_5125C340EACE0872._id_BD73A31917F54451]]();
  else
    _id_5125C340EACE0872.active = 0;

  _id_337BD370F7C5E6F9::_id_2907D01A7D692108(_id_5125C340EACE0872.type);
  level notify("public_event_" + eventname + "_end");
  _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_" + eventname + "_end");
  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  _id_FC7BD6576D8C85BE delete();
}

_id_23913A35C5EBD726(eventname) {
  wait 2;
  _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_" + eventname + "_active");
}

_id_ADC3E7F53E3456D0() {
  game["dialog"]["public_events_blood_money_start"] = "bldm_wzan_name";
  game["dialog"]["public_events_blood_money_active"] = "bldm_wzan_boos";
}

_id_E7A80B9A5971257A() {
  return scripts\mp\utility\game::getsubgametype() == "plunder";
}

_id_AEC5C0A5B73AE7C5() {}

_id_041B1AFBE1C7AF99() {
  level endon("game_ended");
  _id_CA6E399C0A8A91B6(level.br_pe_data[12], "blood_money");
}

_id_3C14F9DF7EFC9951() {
  game["dialog"]["public_events_contractor_start"] = "cont_wzan_name";
  game["dialog"]["public_events_contractor_active"] = "cont_wzan_boos";
}

_id_6150C8F67E691807() {
  return scripts\mp\utility\game::getsubgametype() == "plunder";
}

_id_55B066077526E9D4() {}

_id_05D935DB1C627D80() {
  level endon("game_ended");
  _id_CA6E399C0A8A91B6(level.br_pe_data[15], "contractor");
}

_id_93CCB74A1D25E826() {}

_id_04109D1FEFCB9970() {}

_id_A5B30787BE00778B() {}

_id_23BCDFA42A7B068B() {}

_id_EF3989DD64896A91() {
  game["dialog"]["public_events_money_siphon_active"] = "csho_wzan_boos";
  _id_A5B707E79D910EF6 = spawnStruct();
  _id_A5B707E79D910EF6.type = 14;
  _id_A5B707E79D910EF6._id_4E378291CBEA730E = 13;
  _id_A5B707E79D910EF6.active = 0;
  _id_A5B707E79D910EF6._id_E8FB817A73E06ABA = getdvarint("dvar_55D165F2F9E49694", 2);
  _id_A5B707E79D910EF6._id_9714DDDA6A6DF159 = getdvarint("dvar_1CC3FEBE5F5F8883", 100);
  _id_A5B707E79D910EF6._id_BB1D98E538185DF4 = getdvarfloat("dvar_23750AE04694DC22", 3);
  _id_A5B707E79D910EF6.duration = getdvarint("dvar_1A720E1709CEABF0", 120);
  _id_A5B707E79D910EF6._id_F9B722C9EDCE3106 = getdvarint("dvar_74F7C2602FC10DD8", 120);
  _id_A5B707E79D910EF6._id_2F1EE623E7FC5C8C = getdvarint("dvar_2AC717F48AEF9BD0", 1);
  level._id_16EF52214AC3A63F._id_A5B707E79D910EF6 = _id_A5B707E79D910EF6;
}

_id_98E0AAB5F4A07947() {
  return scripts\mp\utility\game::getsubgametype() == "plunder";
}

_id_B44E7B12BCDC2C14() {}

_id_8645E7BA0E3942C0() {
  level endon("game_ended");
  _id_CA6E399C0A8A91B6(level._id_16EF52214AC3A63F._id_A5B707E79D910EF6, "money_siphon");
}

_id_7EBDC9E059A1BEAF() {}

_id_6DC1BBC26235EC1D() {
  return scripts\mp\utility\game::getsubgametype() == "plunder";
}

_id_C6FA8AE160635B3A() {}

_id_218E108E5DA1B92A() {
  level endon("game_ended");
  _id_CA6E399C0A8A91B6(level.br_pe_data[16], "cannon_fodder");
}