/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_burn.gsc
********************************************************/

main() {
  level thread _id_566F849E77540164();
}

empty() {}

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
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_18F15E37B1C00C2A", 0);
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_09635EFF2F877171", 2);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("burn", "1 0 0 1 0 0 0 0");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("burn");
  _id_337BD370F7C5E6F9::registerpublicevent(10, _id_7EC7671A1E0C788F);
  level._id_8618BEB2A2CD62F5 = getdvarint("dvar_395E15ECCDA7C237", 20);
  level._id_E1AFCCDCC4F2AC1E = 0;
  level._id_A604C0239B4099D0 = [];
}

_id_C9E871D29702E8CF() {}

validatefunc() {
  return scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "burn";
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex <= 1 && !istrue(level.br_infils_disabled))
    level waittill("br_c130_left_bounds");

  wait(level._id_8618BEB2A2CD62F5);
}

activatefunc() {
  level endon("game_ended");
  _id_7952AFBB182F3840();
  setomnvar("ui_publicevent_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 9);
  eventduration = _id_0FBB2D5E09E58DB7();
  _id_91A988004AA42D31 = gettime() + eventduration * 1000;
  setomnvar("ui_publicevent_timer", _id_91A988004AA42D31);
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();
  _id_49978E5850A50D57 = 5;

  if(eventduration > _id_49978E5850A50D57)
    wait(eventduration - _id_49978E5850A50D57);
  else
    _id_49978E5850A50D57 = int(eventduration);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_49978E5850A50D57; _id_AC0E594AC96AA3A8++) {
    _id_FC7BD6576D8C85BE playSound("ui_mp_fire_sale_timer");
    wait 1.0;
  }

  _id_337BD370F7C5E6F9::_id_2907D01A7D692108(10);
  level notify("public_event_burn_end");
  _id_A22DD6572676CB4F();
  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  _id_FC7BD6576D8C85BE delete();
}

_id_7952AFBB182F3840() {
  level._id_E1AFCCDCC4F2AC1E = 1;
  level._id_276D5DC84ED57702 = [];

  foreach(team in level.teamnamelist) {
    _id_652F47620AC4713F = level.teamdata[team]["teamCount"];
    _id_BCE4EFC75EB01319 = level.teamdata[team]["aliveCount"];

    if(_id_652F47620AC4713F > 0) {
      if(_id_60E4A3BBB3596257::_id_0194C860F5134A8E(team) || _id_60E4A3BBB3596257::_id_301EC2DE7600D358(team) || _id_BCE4EFC75EB01319 == 0 || istrue(level._id_A604C0239B4099D0[team])) {
        level._id_276D5DC84ED57702[team] = 1;
        continue;
      }

      scripts\mp\hud_util::showsplashtoteam(team, "br_pe_burn_start");
    }
  }
}

_id_A22DD6572676CB4F() {
  foreach(team in level.teamnamelist) {
    _id_652F47620AC4713F = level.teamdata[team]["teamCount"];
    _id_BCE4EFC75EB01319 = level.teamdata[team]["aliveCount"];

    if(_id_652F47620AC4713F > 0 && _id_BCE4EFC75EB01319 > 0) {
      if(!_id_60E4A3BBB3596257::_id_0194C860F5134A8E(team) && !_id_60E4A3BBB3596257::_id_301EC2DE7600D358(team) && !istrue(level._id_276D5DC84ED57702[team]))
        _id_60E4A3BBB3596257::_id_8100594E66CC40D6(team);
    }
  }

  level._id_E1AFCCDCC4F2AC1E = 0;
  level._id_276D5DC84ED57702 = undefined;
}

_id_83FCE66824A454E7(team) {
  level._id_A604C0239B4099D0[team] = 1;

  if(level._id_E1AFCCDCC4F2AC1E) {
    level._id_276D5DC84ED57702[team] = 1;
    scripts\mp\hud_util::showsplashtoteam(team, "br_pe_burn_end1");
  }
}

_id_C5FBDC2F5659F962(team) {
  level._id_A604C0239B4099D0[team] = undefined;
}

_id_00D8A347AD56A61A(team) {
  if(level._id_E1AFCCDCC4F2AC1E)
    level._id_276D5DC84ED57702[team] = 1;
}

_id_0FBB2D5E09E58DB7() {
  eventduration = getdvarfloat("dvar_DBC7E0DAE5351D5E", 60.0);
  return eventduration;
}