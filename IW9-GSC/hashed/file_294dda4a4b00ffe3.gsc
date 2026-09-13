/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_294dda4a4b00ffe3.gsc
***********************************************/

init() {
  level._id_ADAAED38371FA15B = spawnStruct();
  level._id_ADAAED38371FA15B._id_361441FD51D2BD4E = 0;
  level._id_ADAAED38371FA15B.state = 0;
  level._id_ADAAED38371FA15B.targets = _id_76E26AFF7DCF2A6A();

  if(_id_AFEA038C5C9F1209())
    level._id_ADAAED38371FA15B._id_0D4622DBFFCAD86C = _id_276BE8B8EA7B9DA7();

  level._id_ADAAED38371FA15B._id_4D2460299CA3AB25 = getdvarint("dvar_A1A32D7B6AB4A658", 1) > 0;
  level._id_ADAAED38371FA15B.timer = spawnStruct();
  level._id_ADAAED38371FA15B.timer.duration = level._id_ADAAED38371FA15B.targets[0];
  thread _id_727B37A4211441B8();
}

_id_4AD287E0971672A6() {
  return getdvarint("dvar_4558ABF9D259B284", 0) > 0;
}

_id_AFEA038C5C9F1209() {
  return getdvarint("dvar_A973AB15BA11D2BA", 1) > 0;
}

_id_78F8BE234116673D() {
  return getdvarint("dvar_8BA88F3DDFD5E041", 5);
}

_id_76E26AFF7DCF2A6A() {
  _id_24ABC960B59E06D0 = getDvar("dvar_BC9D24D7D03581E3", "0 0 0");
  _id_4FEAE575CE34EFA0 = [];

  if(_id_24ABC960B59E06D0 != "") {
    _id_394D57A3C2AE52AF = strtok(_id_24ABC960B59E06D0, " ");

    foreach(target in _id_394D57A3C2AE52AF) {
      _id_063A7BA4C102C8FD = int(target);
      _id_4FEAE575CE34EFA0[_id_4FEAE575CE34EFA0.size] = _id_063A7BA4C102C8FD;
    }
  }

  return _id_4FEAE575CE34EFA0;
}

_id_8BE9BAE8228A91F7(eventname) {
  _id_AE18D736D9768B9A = getDvar(_func_2EF675C13CA1C4AF("dvar_ABB46656D4B7E51C", eventname, "_pe_meter_event_weights"), "0 0 0 0 0 0 0 0");
  _id_B9B56551E1ACFEE2 = [];

  if(_id_AE18D736D9768B9A != "") {
    _id_DDCEA577BBDD75B0 = strtok(_id_AE18D736D9768B9A, " ");

    foreach(weight in _id_DDCEA577BBDD75B0)
    _id_B9B56551E1ACFEE2[_id_B9B56551E1ACFEE2.size] = float(weight);
  }

  return _id_B9B56551E1ACFEE2;
}

_id_276BE8B8EA7B9DA7() {
  _id_0D4622DBFFCAD86C = spawnStruct();
  _id_0D4622DBFFCAD86C._id_82819A1606FDDCC0 = [];
  _id_B47E0ED9BA26B84F = getDvar("scr_br_pe_meter_predetermined_events", "");
  _id_F4EF4AD8C3051332 = strtok(_id_B47E0ED9BA26B84F, ",");

  if(_id_F4EF4AD8C3051332.size == 0) {
    scripts\mp\utility\script::demoforcesre("Public Event Meters: No predetermined public events set! Set dvar 'scr_br_pe_meter_predetermined_events'");
    return undefined;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F4EF4AD8C3051332.size; _id_AC0E594AC96AA3A8++) {
    _id_EFCE2281DBD74D39 = [];
    _id_82819A1606FDDCC0 = strtok(_id_F4EF4AD8C3051332[_id_AC0E594AC96AA3A8], " ");

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_82819A1606FDDCC0.size; _id_AC0E5C4AC96AAA41++)
      _id_82819A1606FDDCC0[_id_AC0E5C4AC96AAA41] = int(_id_82819A1606FDDCC0[_id_AC0E5C4AC96AAA41]);

    _id_0D4622DBFFCAD86C._id_82819A1606FDDCC0[_id_AC0E594AC96AA3A8] = _id_82819A1606FDDCC0;
  }

  return _id_0D4622DBFFCAD86C;
}

_id_C6B950C21813B5CD() {
  _id_C8693EECDD0B3E54 = level._id_ADAAED38371FA15B._id_361441FD51D2BD4E;
  _id_C8693EECDD0B3E54 = clamp(_id_C8693EECDD0B3E54, 0, level._id_ADAAED38371FA15B.targets.size - 1);
  return int(_id_C8693EECDD0B3E54);
}

_id_3168DDA92F94DE9C() {
  endtime = level._id_ADAAED38371FA15B.timer.endtime;
  currenttime = gettime();

  if(!isDefined(endtime) || currenttime >= endtime)
    return undefined;

  _id_C8693EECDD0B3E54 = _id_C6B950C21813B5CD();
  duration = level._id_ADAAED38371FA15B.targets[_id_C8693EECDD0B3E54];
  _id_208A9BD22D08B9DB = endtime - currenttime;
  return _id_208A9BD22D08B9DB / (duration * 1000);
}

_id_989D407AD1798EB0() {
  if(!istrue(level._id_ADAAED38371FA15B._id_4D2460299CA3AB25))
    return 0;

  return level._id_ADAAED38371FA15B._id_361441FD51D2BD4E > level._id_ADAAED38371FA15B.targets.size - 1;
}

_id_727B37A4211441B8() {
  level endon("cancel_public_event");
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_B25D69BA35A863C8(1);
  thread _id_6EA8115FC5F81BBD();
}

_id_2D3BA92B45FB796E() {
  _id_C8693EECDD0B3E54 = _id_C6B950C21813B5CD();

  if(_id_AFEA038C5C9F1209()) {
    _id_82819A1606FDDCC0 = level._id_ADAAED38371FA15B._id_0D4622DBFFCAD86C._id_82819A1606FDDCC0[_id_C8693EECDD0B3E54];

    foreach(eventtype in _id_82819A1606FDDCC0)
    level thread _id_337BD370F7C5E6F9::runpubliceventoftype(eventtype, 1, _id_C8693EECDD0B3E54, 1);
  } else
    level thread _id_337BD370F7C5E6F9::choosepubliceventtype(1, _id_C8693EECDD0B3E54, 1);

  level._id_ADAAED38371FA15B._id_361441FD51D2BD4E = level._id_ADAAED38371FA15B._id_361441FD51D2BD4E + 1;
}

_id_6EA8115FC5F81BBD() {
  level endon("game_ended");

  while(!_id_989D407AD1798EB0()) {
    _id_C8693EECDD0B3E54 = _id_C6B950C21813B5CD();
    target = level._id_ADAAED38371FA15B.targets[_id_C8693EECDD0B3E54];
    endtime = gettime() + target * 1000;
    _id_B25D69BA35A863C8(1);
    _id_793358077B37FB75(endtime);
    _id_8E5A2527F76E9BA4(target);
    level notify("br_pe_meter_active");

    while(gettime() < level._id_ADAAED38371FA15B.timer.endtime || level._id_ADAAED38371FA15B.state == 0)
      wait 0.1;

    _id_B25D69BA35A863C8(2);
    _id_2D3BA92B45FB796E();
    _id_7DDE797732B78B5B = _id_78F8BE234116673D();

    if(_id_7DDE797732B78B5B > 0)
      wait(_id_7DDE797732B78B5B);

    while(_id_337BD370F7C5E6F9::_id_7DDADB6D5643BEE4())
      level scripts\engine\utility::waittill_any_2("br_pe_end", "cancel_public_event");

    waitframe();
  }

  _id_B25D69BA35A863C8(0);
}

_id_D24F2DD28D26377E(_id_CC748B6D457627FE) {
  if(!isDefined(_id_CC748B6D457627FE) || _id_CC748B6D457627FE == 0 || !isDefined(level._id_ADAAED38371FA15B.timer.endtime)) {
    return;
  }
  endtime = level._id_ADAAED38371FA15B.timer.endtime;
  endtime = endtime + _id_CC748B6D457627FE * 1000;
  _id_C8693EECDD0B3E54 = _id_C6B950C21813B5CD();
  duration = level._id_ADAAED38371FA15B.targets[_id_C8693EECDD0B3E54];

  if(endtime - gettime() > duration * 1000)
    endtime = gettime() + duration * 1000;

  _id_793358077B37FB75(endtime);
}

_id_B25D69BA35A863C8(state) {
  if(!isDefined(state) || level._id_ADAAED38371FA15B.state == state) {
    return;
  }
  level._id_ADAAED38371FA15B.state = state;
  scripts\cp_mp\utility\omnvar_utility::_id_D3CF7FF1A257E2C3("ui_br_pe_meter_data", 0, 2, state);
}

_id_793358077B37FB75(endtime) {
  level._id_ADAAED38371FA15B.timer.endtime = endtime;
  _id_17079EA11178B6B2 = int(endtime / 1000);
  scripts\cp_mp\utility\omnvar_utility::_id_D3CF7FF1A257E2C3("ui_br_pe_meter_data", 2, 11, _id_17079EA11178B6B2);
}

_id_8E5A2527F76E9BA4(duration) {
  level._id_ADAAED38371FA15B.timer.duration = duration;
  scripts\cp_mp\utility\omnvar_utility::_id_D3CF7FF1A257E2C3("ui_br_pe_meter_data", 13, 8, duration);
}