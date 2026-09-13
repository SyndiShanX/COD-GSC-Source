/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_firesale.gsc
************************************************************/

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_B5D1FFC1E41BBF8C", 1.0);
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_454CDD349CEC1727", 8);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("firesale", "05 1010 10101010");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("firesale");
  _id_337BD370F7C5E6F9::registerpublicevent(2, _id_7EC7671A1E0C788F);
}

_id_C9E871D29702E8CF() {
  game["dialog"]["public_events_firesale_start"] = "pbvn_wzan_frsa";
  game["dialog"]["public_events_firesale_end"] = "pbvn_wzan_frse";
}

validatefunc() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex <= 1)
    return 1;

  _id_035C1E70B1D29218 = _id_4384ABBF498DF6A7::_id_8301CE82F0AE1BE6();
  return _id_035C1E70B1D29218 >= 1;
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  _id_98489428013A0100 = calculateeventstarttime();
  wait(_id_98489428013A0100);
}

activatefunc() {
  level endon("game_ended");
  _id_337BD370F7C5E6F9::showsplashtoall("br_pe_firesale_start");
  _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_firesale_start");
  setomnvar("ui_publicevent_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 1);
  eventduration = _id_0FBB2D5E09E58DB7();
  _id_91A988004AA42D31 = gettime() + eventduration * 1000;
  setomnvar("ui_publicevent_timer", _id_91A988004AA42D31);
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();

  if(isDefined(level._id_0A4078546548CB0A))
    [[level._id_0A4078546548CB0A]]();

  level notify("public_event_firesale_start");
  _id_49978E5850A50D57 = 5;

  if(eventduration > _id_49978E5850A50D57)
    wait(eventduration - _id_49978E5850A50D57);
  else
    _id_49978E5850A50D57 = int(eventduration);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_49978E5850A50D57; _id_AC0E594AC96AA3A8++) {
    _id_FC7BD6576D8C85BE playSound("ui_mp_fire_sale_timer");
    wait 1.0;
  }

  if(isDefined(level._id_4FECF02C9241F7F0))
    [[level._id_4FECF02C9241F7F0]]();

  _id_337BD370F7C5E6F9::_id_2907D01A7D692108(2);
  level notify("public_event_firesale_end");
  scripts\mp\hud_util::showsplashtoall("br_pe_firesale_end");
  _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_firesale_end");
  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  _id_FC7BD6576D8C85BE delete();
}

_id_0FBB2D5E09E58DB7() {
  eventduration = getdvarfloat("dvar_0104F9A52DB6EF74", 90.0);
  _id_CC5318567913F501 = isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex != -1;
  _id_543C8E4D624FF7A3 = getdvarint("dvar_CC7FED1C42605966", 1) == 1;

  if(_id_543C8E4D624FF7A3 && _id_CC5318567913F501)
    eventduration = min(eventduration, _id_2695A20D4011076D::_id_ABBFB4D18D1A9CA7());

  _id_8812000C33AED3C9 = getdvarint("dvar_18C9EA0970A9D3AA", 0) == 1;

  if(_id_8812000C33AED3C9 && _id_CC5318567913F501)
    eventduration = _id_2695A20D4011076D::_id_ABBFB4D18D1A9CA7();

  _id_5F651E1139EF776F = getdvarint("dvar_394BCE38A6950030", 15.0);
  eventduration = max(eventduration, _id_5F651E1139EF776F);
  return eventduration;
}

calculateeventstarttime() {
  _id_87940078241E4580 = getdvarfloat("dvar_3549564826254716", 795.0);
  _id_07AF9598177DC2DE = getdvarfloat("dvar_356D4848264DA304", 1110.0);

  if(_id_07AF9598177DC2DE > _id_87940078241E4580)
    return randomfloatrange(_id_87940078241E4580, _id_07AF9598177DC2DE);
  else
    return _id_87940078241E4580;
}