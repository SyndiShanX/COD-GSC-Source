/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_bosses_getaway.gsc
*******************************************************/

main() {
  gametype = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5();

  if(gametype != "dmz") {
    return;
  }
  _id_5A732482DAA6FD86 = _id_2FDEB8023287BE67::_id_B170E67029D0B874("getaway");

  if(getdvarint(_id_5A732482DAA6FD86, 1) > 0) {
    _id_ACE9556DC2CF4D4D();
    thread _id_38A40E30AD08DE9E();
  }
}

_id_ACE9556DC2CF4D4D() {
  level._effect["vfx_delta_dmz_veh_boost_rnr"] = loadfx("vfx/iw9/level/mp_delta/dmz/vfx_delta_dmz_veh_boost_rnr.vfx");
  level._effect["vfx_delta_dmz_red_light_mines"] = loadfx("vfx/iw9/level/mp_delta/dmz/vfx_delta_dmz_red_light_mines.vfx");
}

_id_38A40E30AD08DE9E() {
  level waittill("register_dmz_bosses");
  _id_B7015A0DBEFEBCE1 = scripts\engine\utility::getStructArray("boss_getaway_node", "targetname");

  if(!isDefined(_id_B7015A0DBEFEBCE1) || _id_B7015A0DBEFEBCE1.size == 0) {
    return;
  }
  _id_19743D9E6FD8C91F();
  level notify("pause_reset_delta_movingtrain");
}

_id_19743D9E6FD8C91F() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896.name = "getaway";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_F1CA976DDE3DB44C;
  _id_AED74300DAF62896.spawnfunc = ::_id_008DA71E6CB64D10;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_15F02415B39228DF;
  _id_AED74300DAF62896._id_7232C52496C3A94A = ::_id_9CB934178CF34F6F;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "main", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_F1CA976DDE3DB44C(_id_AED74300DAF62896) {
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];
  _id_B7015A0DBEFEBCE1 = scripts\engine\utility::getStructArray("boss_getaway_node", "targetname");

  if(!isDefined(_id_B7015A0DBEFEBCE1) || _id_B7015A0DBEFEBCE1.size == 0) {
    return;
  }
  _id_B7015A0DBEFEBCE1 = _id_F7D4BA6C999AAA44(_id_B7015A0DBEFEBCE1);
  _id_B7015A0DBEFEBCE1 = scripts\engine\utility::array_randomize(_id_B7015A0DBEFEBCE1);
  paths = [];

  foreach(_id_C229D93C0BB4F8E8 in _id_B7015A0DBEFEBCE1)
  paths[paths.size] = _id_4717043A80AA5766(_id_C229D93C0BB4F8E8);

  _id_584343C90B6513FF = _id_B7015A0DBEFEBCE1[0];
  struct = spawnStruct();
  struct.origin = _id_584343C90B6513FF.origin;
  struct.angles = _id_584343C90B6513FF.angles;
  struct._id_B7015A0DBEFEBCE1 = _id_B7015A0DBEFEBCE1;
  struct.paths = paths;
  struct._id_F1A894F81AD453AF = paths[0];
  _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = struct;
  _id_AED74300DAF62896._id_A136A131D25C1FA0 = _id_A69137DC24C97461();
  _id_B206990978582767 = getdvarint("dvar_1CC37F530EB3096D", 150);
  _id_6DEFF7B851A73401 = getdvarint("dvar_01BE4746CA5281FB", 200);

  if(_id_6DEFF7B851A73401 < _id_B206990978582767)
    _id_AED74300DAF62896.spawntime = _id_6DEFF7B851A73401;
  else
    _id_AED74300DAF62896.spawntime = randomintrange(_id_B206990978582767, _id_6DEFF7B851A73401);

  _id_5D59C976161AE9CD();
  _id_2B80503B32D40B24();
}

_id_5D59C976161AE9CD() {
  _id_37C3A1DD721F8F89 = getdvarfloat("dvar_760F32327D6C5D7B", 0.19);

  foreach(tag, value in level.vehicles.hitdamage.vehicles["veh9_armored_acv_6x6"].weaponhitsperattack)
  level.vehicles.hitdamage.vehicles["veh9_armored_acv_6x6"].weaponhitsperattack[tag] = int(value * _id_37C3A1DD721F8F89);
}

_id_2B80503B32D40B24() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_getleveldataforvehicle("veh9_armored_acv_6x6", 1);
  _id_E2818AD39A3341B4.handleeventcallback = ::_id_1C359665A667E859;
  _id_E2818AD39A3341B4.class = "immovable";
}

_id_1C359665A667E859(_id_F91CB8070749380D, vehicle) {
  if(_id_F91CB8070749380D.vehiclename != "veh9_armored_acv_6x6") {
    if(_id_F91CB8070749380D _id_AADD37718D7F4B5F() || vehicle _id_AADD37718D7F4B5F()) {
      return;
    }
    temp = vehicle;
    vehicle = _id_F91CB8070749380D;
    _id_F91CB8070749380D = temp;
  }

  if(!isDefined(vehicle) || !isDefined(vehicle.health)) {
    return;
  }
  if(vehicle.vehiclename == "cargo_train") {
    return;
  }
  if(scripts\cp_mp\vehicles\vehicle_collision::_id_D88AED99025A81E4(vehicle, _id_F91CB8070749380D)) {
    return;
  }
  _id_A77F772E56CB195A = _id_F91CB8070749380D vehicle_getvelocity();
  _id_C11C965258EE413F = length(_id_A77F772E56CB195A);

  if(_id_C11C965258EE413F <= 0) {
    return;
  }
  _id_4573A8725DD3748E = vehicle.origin - _id_F91CB8070749380D.origin;

  if(vectordot(_id_A77F772E56CB195A, _id_4573A8725DD3748E) <= 0) {
    return;
  }
  health = vehicle.health;
  damage = _id_C11C965258EE413F * _id_F91CB8070749380D._id_5596371C3C7AD1DD;
  _id_13FE689AABC10C20 = damage >= health;

  if(_id_13FE689AABC10C20)
    vehicle._id_A8F4BB03B366AA80 = 1;

  vehicle dodamage(damage, _id_F91CB8070749380D.origin, _id_F91CB8070749380D, _id_F91CB8070749380D, "MOD_CRUSH");

  if(vehicle vehicle_isphysveh())
    vehicle _meth_E0201404A8B6F664(vehicle.origin - _id_F91CB8070749380D.origin + (0, 0, 200), _id_C11C965258EE413F, 1);

  if(vehicle.health < health)
    level thread scripts\cp_mp\vehicles\vehicle_collision::vehicle_collision_ignorefutureevent(vehicle, _id_F91CB8070749380D, 1);
}

_id_AADD37718D7F4B5F() {
  return istrue(self._id_B7148A3BFC4DEFB2) && self.spawndata._id_EC2DF2ACAF230179 == "veh9_armored_acv_6x6";
}

_id_2DC09BD7CFFE39EE(vehicle, _id_AE9ACDDA1C693FA6) {
  if(isDefined(_id_AE9ACDDA1C693FA6.classname) && _id_AE9ACDDA1C693FA6.classname == "script_model") {
    _id_BF8E5F003146AF44 = _id_AE9ACDDA1C693FA6 getlinkedparent();

    if(isDefined(_id_BF8E5F003146AF44))
      _id_AE9ACDDA1C693FA6 = _id_BF8E5F003146AF44;
  }

  if(isDefined(_id_AE9ACDDA1C693FA6.streakname) && _id_AE9ACDDA1C693FA6.streakname == "sentry_turret" && !istrue(_id_AE9ACDDA1C693FA6._id_455A731F2701DD65)) {
    _id_4FAC8B8CE36E09F1 = 1;
    _id_0B2797481A55C620 = 1;
    _id_AE9ACDDA1C693FA6._id_455A731F2701DD65 = 1;
    _id_AE9ACDDA1C693FA6 notify("kill_turret", _id_0B2797481A55C620, _id_4FAC8B8CE36E09F1);
  }
}

_id_008DA71E6CB64D10() {
  level endon("game_ended");
  spawntime = level._id_6A4C9FBD7AA58544["getaway"].spawntime;

  if(spawntime < 0) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  wait(spawntime);
  _id_15F02415B39228DF();
}

_id_15F02415B39228DF(loc) {
  _id_0BAA08EA813E9752 = _id_2FDEB8023287BE67::_id_3BCF85FF011D31F8("getaway");

  if(!isDefined(_id_0BAA08EA813E9752)) {
    return;
  }
  if(_id_0BAA08EA813E9752._id_F1A894F81AD453AF.size == 0) {
    return;
  }
  instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("getaway");
  instance._id_FB1DEF007972B25A = _id_0BAA08EA813E9752.origin;
  instance.spawnangles = _id_0BAA08EA813E9752.angles;
  instance._id_F1A894F81AD453AF = _id_0BAA08EA813E9752._id_F1A894F81AD453AF;
  instance._id_B7015A0DBEFEBCE1 = _id_0BAA08EA813E9752._id_B7015A0DBEFEBCE1;
  instance.paths = _id_0BAA08EA813E9752.paths;
  instance._id_E2958F412A7425C0 = instance _id_6731DACDBE2BA2B5();
  instance._id_9329E0D3CE1D5CA8 = "getaway";
  instance._id_47BDE44B1ACEC603 = "getaway";
  instance notify("boss_spawned");
  dlog_recordevent("dlog_event_dmz_boss_getaway_spawn", []);

  if(!isarray(instance._id_085E53E70C7110DA))
    instance._id_085E53E70C7110DA = [];
}

_id_A69137DC24C97461() {
  _id_A136A131D25C1FA0 = [];
  _id_31583E7265EBDEB2 = [[0.95, 1, ["brloot_armor_plate", 5, 2], ["brloot_valuable_blow_torch", 5, 1]], [0.9, 1, ["brloot_armor_plate", 5, 2], ["brloot_valuable_blow_torch", 5, 1]], [0.85, 1, ["brloot_armor_plate", 5, 2], ["brloot_offhand_atmine", 5, 2]], [0.8, 3, ["brloot_armor_plate", 5, 2], ["brloot_offhand_atmine", 30, 1]], [0.75, 1, ["brloot_armor_plate", 5, 2], ["brloot_valuable_blow_torch", 5, 1]], [0.7, 2, ["brloot_armor_plate", 5, 2], ["brloot_offhand_atmine", 5, 2]], [0.65, 1, ["brloot_armor_plate", 5, 2], ["brloot_offhand_atmine", 5, 2]], [0.6, 3, ["brloot_self_revive", 5, 1], ["brloot_armor_plate", 5, 3], ["brloot_offhand_atmine", 15, 2], ["brloot_valuable_folder", 15, 1], ["brloot_valuable_folder_sensitive", 1, 1]], [0.55, 1, ["brloot_armor_plate", 5, 1], ["brloot_valuable_blow_torch", 5, 1]], [0.5, 2, ["brloot_self_revive", 5, 1], ["brloot_offhand_atmine", 15, 1]], [0.45, 1, ["brloot_armor_plate", 5, 1], ["brloot_valuable_blow_torch", 2, 1]], [0.4, 3, ["brloot_self_revive", 5, 1], ["brloot_armor_plate", 15, 3], ["brloot_offhand_atmine", 25, 2], ["brloot_valuable_folder", 30, 1], ["brloot_valuable_game_console", 5, 1]], [0.35, 1, ["brloot_armor_plate", 5, 1], ["brloot_valuable_blow_torch", 5, 1], ["brloot_offhand_atmine", 5, 2]], [0.3, 2, ["brloot_armor_plate", 5, 1], ["brloot_offhand_atmine", 10, 2], ["brloot_valuable_blow_torch", 2, 1]], [0.25, 1, ["brloot_armor_plate", 5, 1], ["brloot_valuable_blow_torch", 5, 1]], [0.2, 2, ["brloot_self_revive", 5, 1], ["brloot_valuable_game_console", 25, 1]], [0.15, 1, ["brloot_armor_plate", 5, 1], ["brloot_valuable_blow_torch", 2, 1]], [0.1, 2, ["brloot_armor_plate", 5, 1], ["brloot_super_stimpistol", 2, 1]], [0.05, 2, ["brloot_armor_plate", 5, 1], ["brloot_valuable_blow_torch", 2, 1]], [0, 3, ["brloot_self_revive", 33, 1], ["brloot_valuable_blow_torch_bullfrog", 33, 1], ["killstreak", 33, 1]]];

  foreach(_id_690D1CF274CFE40A in _id_31583E7265EBDEB2) {
    _id_74AA005B171AD11E = spawnStruct();
    _id_74AA005B171AD11E.healthratio = _id_690D1CF274CFE40A[0];
    _id_9BE70D6D4FF253A1 = _id_690D1CF274CFE40A[1];
    _id_9BA7A0BB585BA0E7 = [];

    foreach(_id_9884034814B22E02 in _id_690D1CF274CFE40A) {
      if(isarray(_id_9884034814B22E02))
        _id_9BA7A0BB585BA0E7[_id_9BA7A0BB585BA0E7.size] = _id_A800E4149FC88E01(_id_9884034814B22E02[0], _id_9884034814B22E02[1], _id_9884034814B22E02[2]);
    }

    _id_36564DEDD77D9A6C = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9BE70D6D4FF253A1; _id_AC0E594AC96AA3A8++) {
      _id_DE19F33CB691869D = _id_36540080052ABB60(_id_9BA7A0BB585BA0E7);

      if(isDefined(_id_DE19F33CB691869D)) {
        _id_36564DEDD77D9A6C[_id_36564DEDD77D9A6C.size] = _id_C003A2DE1EC15F14(_id_DE19F33CB691869D.name);
        _id_9BA7A0BB585BA0E7 = _id_5ED14FD89FEF748A(_id_DE19F33CB691869D, _id_9BA7A0BB585BA0E7);
      }
    }

    _id_74AA005B171AD11E.rewards = _id_36564DEDD77D9A6C;
    _id_A136A131D25C1FA0[_id_A136A131D25C1FA0.size] = _id_74AA005B171AD11E;
  }

  return _id_A136A131D25C1FA0;
}

_id_A800E4149FC88E01(name, weight, maxcount) {
  object = spawnStruct();
  object.name = name;
  object.weight = weight;
  object.maxcount = maxcount;
  return object;
}

_id_36540080052ABB60(_id_6862AE2260C95B0B) {
  _id_D4B9E030F49735D5 = 0;

  foreach(object in _id_6862AE2260C95B0B)
  _id_D4B9E030F49735D5 = _id_D4B9E030F49735D5 + object.weight;

  _id_162B86F62CD92B56 = randomfloat(_id_D4B9E030F49735D5);
  _id_C2A009E075D70716 = 0;

  foreach(object in _id_6862AE2260C95B0B) {
    _id_C2A009E075D70716 = _id_C2A009E075D70716 + object.weight;

    if(_id_C2A009E075D70716 > _id_162B86F62CD92B56)
      return object;
  }

  return undefined;
}

_id_C003A2DE1EC15F14(name) {
  if(name == "ammo")
    return level.br_ammo_types[randomint(level.br_ammo_types.size)];
  else if(name == "killstreak") {
    _id_0278C1C23E4C3C54 = [];

    foreach(_id_D8061F26B5ECA018, _id_F406BE343AB9CC93 in level.br_pickups.br_killstreakreference) {
      if(!istrue(level.br_pickups._id_C4B4B56C76765330[_id_D8061F26B5ECA018]) && _id_D8061F26B5ECA018 != "brloot_killstreak_auav")
        _id_0278C1C23E4C3C54[_id_0278C1C23E4C3C54.size] = _id_D8061F26B5ECA018;
    }

    return _id_0278C1C23E4C3C54[randomint(_id_0278C1C23E4C3C54.size)];
  }

  return name;
}

_id_5ED14FD89FEF748A(_id_DE19F33CB691869D, _id_9BA7A0BB585BA0E7) {
  _id_BFC65A378A6D8EFE = [];

  foreach(object in _id_9BA7A0BB585BA0E7) {
    if(object != _id_DE19F33CB691869D) {
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = object;
      continue;
    }

    if(object.maxcount > 1) {
      object.maxcount--;
      _id_BFC65A378A6D8EFE[_id_BFC65A378A6D8EFE.size] = object;
    }
  }

  return _id_BFC65A378A6D8EFE;
}

_id_6731DACDBE2BA2B5() {
  _id_72DAC79A97FC7C5C = spawnStruct();
  _id_72DAC79A97FC7C5C.origin = self._id_FB1DEF007972B25A;
  _id_72DAC79A97FC7C5C.angles = self.spawnangles;
  _id_72DAC79A97FC7C5C._id_79FA6BD3C9BF6A0D = 1;
  _id_72DAC79A97FC7C5C.dontgetonpath = 1;
  spawndata = spawnStruct();
  spawndata.origin = _id_72DAC79A97FC7C5C.origin;
  spawndata.angles = _id_72DAC79A97FC7C5C.angles;
  spawndata.spawntype = "getaway";
  spawndata.showheadicon = 1;
  spawndata._id_F16652E1462A3739 = 1;
  _id_EE8DA5624236DC89 = spawnStruct();
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_BC4E8BB8E8A1FFAE(), spawndata, _id_EE8DA5624236DC89);
  vehicle.vehicle_spawner = _id_72DAC79A97FC7C5C;
  vehicle._id_EB504FC7E1CFEB4C = 0;
  vehicle._id_F1A894F81AD453AF = self._id_F1A894F81AD453AF;
  vehicle._id_37DB87FAA54F5A2B = 0;
  vehicle._id_0566868292EE2A1B = self;
  vehicle.team = "team_hundred_ninety_four";
  vehicle.teamfriendlyto = "team_hundred_ninety_four";
  vehicle._id_2D4520BF83C93D41 = 0;
  vehicle.currentstate = "roam";
  vehicle._id_47BDE44B1ACEC603 = "getaway";
  vehicle vehicle_turnengineon();
  vehicle vehicleshowonminimap(0);
  vehicle._id_F2FF23BA01017057 = getdvarint("dvar_082A18423A7B8F65", 20);
  vehicle._id_78004B3FCB407A05 = getdvarint("dvar_7175A26196FFE00B", 34);
  vehicle._id_813D53B703CA8F8A = getdvarint("dvar_173305C97FF3BB2C", 30);
  vehicle._id_6492BC580AF9358E = getdvarfloat("dvar_0F28442CCE2465C0", 9);
  vehicle._id_BC2F6E50D4761BFA = 1;
  vehicle._id_64C5A4A6F78C0674 = 1;
  vehicle._id_0B9F9F547C1377D6 = getdvarfloat("dvar_8830C4EA04B9ADCF", 45);
  vehicle._id_ECB595D73834DE8D = getdvarfloat("dvar_7265F116F4F54E7B", 3);
  vehicle._id_79D99354AEA449C1 = getdvarfloat("dvar_5ABA0E0B95C4CA43", 22);
  vehicle._id_D379A8BDED406DFE = getdvarfloat("dvar_2ACC89B9FEF4A418", 0.8);
  vehicle._id_39CA18354C1E245E = getdvarfloat("dvar_A76DCDAB73A226E6", 200);
  vehicle._id_B66C0EEFBA57D97D = getdvarfloat("dvar_42B4DF450E8CA037", 0.1);
  vehicle._id_5596371C3C7AD1DD = getdvarfloat("dvar_E7971D8E3892D65B", 30);
  vehicle._id_ECBCF02A326B4EBC = getdvarfloat("dvar_ACC91979AF76B36D", 1024);
  vehicle._id_ECBCF02A326B4EBC = pow(vehicle._id_ECBCF02A326B4EBC, 2);
  vehicle._id_9F7B2CEF12A7C8F3 = getdvarint("dvar_330E8F2D87843309", 20);
  vehicle._id_9F9E42EF12CE410D = getdvarint("dvar_32EB812D875DCC87", 60);
  vehicle._id_5F59BD78A8BC8B5D = getdvarfloat("dvar_E7FEFACBE0B0B89F", 2);
  vehicle._id_FEED7759C7E1ADF8 = getdvarint("dvar_68EE551BA307EC7A", 12);
  vehicle._id_6DB8B3FABD1FD01F = getdvarint("dvar_24C9EBD36E0B3956", 30) * 1000;
  vehicle._id_2CCE8E007AD7BDDD = getdvarint("dvar_BB79795A55684073", 1);
  vehicle._id_F280E41FA7BDA8A3 = getdvarint("dvar_F10B16792AE26E65", 1);
  vehicle._id_98FD2804CFEACE92 = getdvarfloat("dvar_47E6EA99627A33B4", 0.25);
  vehicle _id_03FBD609AB215CEF();

  if(isDefined(level._id_6E5FF6CAE14C4081))
    level._id_6E5FF6CAE14C4081[level._id_6E5FF6CAE14C4081.size] = vehicle;

  _id_0264E7B25ADEC1CB(spawndata.origin, vehicle);
  vehicle _id_39F164C8EDAD43D5();
  self._id_9ACFC0BD86B2E2C1 = _id_4BAC13D511590220::_id_DF5D237DB38291AC;
  self._id_A9F96E33F612C828 = _id_4BAC13D511590220::_id_6A0B2A08499A9842;
  vehicle scripts\common\vehicle::vehicle_lights_on("headlights", "script_struct_mp_iw9_acv_6x6");
  vehicle _id_8A2AE9ADB168E75E();
  vehicle thread _id_92534F8E28DF198A();
  vehicle thread _id_955A53CD76A3FBE1();
  vehicle thread _id_EF3C629E76458FDD();
  vehicle.damagecallback = ::_id_93FC4DDEF057CBFE;
  vehicle thread _id_1FBA720CE819791C(self);
  vehicle thread _id_2FDEB8023287BE67::_id_2676819F01AE14ED("getaway", "brloot_weaponcase_delta", "tag_dmz_boss_loot_spawn");
  vehicle._id_4B75A4EE07200D3B = ::_id_2DC09BD7CFFE39EE;
  vehicle thread _id_C1FD28F8A07779B0();
  vehicle thread _id_16B15F5E4A751A3A();
  vehicle thread _id_C3E469874896E5ED();
  vehicle thread _id_A123101F764A25C3();
  return vehicle;
}

_id_03FBD609AB215CEF() {
  if(getdvarint("dvar_559DDDA5F49BC493", 1) <= 0) {
    return;
  }
  rider = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF("enemy_mp_shotgun_tier1_ru", self.origin, self.angles, "medium", "bossArea", undefined, "getaway", "team_hundred_ninety_four", undefined, undefined, undefined, undefined, 0);

  if(isDefined(rider)) {
    rider._id_A4738C70736D3A61 = ::_id_51002BD07310E3FC;
    scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6([rider], 1);
  }
}

_id_51002BD07310E3FC(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  return;
}

_id_BC4E8BB8E8A1FFAE() {
  return "veh9_armored_acv_6x6";
}

_id_0264E7B25ADEC1CB(origin, vehicle) {
  _id_2FDEB8023287BE67::_id_8002B09B8348902C(origin, "ui_map_icon_boss_getaway");
  scripts\mp\objidpoolmanager::update_objective_onentity(self.objidnum, vehicle);
  _id_8F0DB36A6A62724C(origin);
  vehicle _id_DD78773CAEB8E501();
  return 1;
}

_id_8F0DB36A6A62724C(origin) {
  players = scripts\engine\utility::array_removeundefined(level.players);
  _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(origin, 1, 1, 1);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_getaway_revealed", players, _id_171F90B9C4C76D44);
}

_id_9CB934178CF34F6F(player, showicon) {
  team = player.team;

  if(!isDefined(self._id_7D8AD21E5DFD7C94))
    self._id_7D8AD21E5DFD7C94 = [];

  if(!isDefined(self._id_E2958F412A7425C0) || !isalive(self._id_E2958F412A7425C0) || scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, team))
    return 0;

  self._id_7D8AD21E5DFD7C94 = scripts\engine\utility::array_add(self._id_7D8AD21E5DFD7C94, team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_AC4C51BF033F6323 = players;
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);
  _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, player, level._id_B1149892B2595056, "dmz_boss_bullfrog_approach", 1.5);
  return 1;
}

_id_DD78773CAEB8E501() {
  if(_id_3AACF02225CA0DA5::_id_94B502046C767CD1() == "boss") {
    _id_4673B0931E86514C = "Boss_Focus_Dmz";

    if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414() || scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
      _id_4673B0931E86514C = "Boss_Focus_SM_Dmz";

    circleradius = 2000;
    scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_4673B0931E86514C, self.origin, circleradius);
    thread _id_F6A69D45F2DA33D0(circleradius);
    scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
    thread _id_2FDEB8023287BE67::_id_3C9B7EA5BE9B4602(self, "boss_driver_revealed");
  }
}

_id_F6A69D45F2DA33D0(radius) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(self.origin);
    waitframe();
  }
}

_id_EC13AA0608F307FC() {
  _id_7CD478841C1E0001();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self._id_0566868292EE2A1B.objidnum);
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}

_id_9E13E2A9CA3E8330() {
  _id_FBBA62F9C96F912A();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self._id_0566868292EE2A1B.objidnum);
  scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
  self notify("kill_vo_threads");
}

_id_187FA8158218000A() {
  _id_9E13E2A9CA3E8330();

  if(istrue(self._id_F280E41FA7BDA8A3)) {
    players = scripts\engine\utility::array_removeundefined(level.players);
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.origin, 1);
    _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_getaway_exfil", players, _id_171F90B9C4C76D44);
    _id_65F58F3C394DCF9A::_id_2E4AFBF3AEAF31E4(self._id_0566868292EE2A1B, "dmz_boss_bullfrog_combat", 0.0);
  }

  dlog_recordevent("dlog_event_dmz_boss_getaway_escape", []);
  thread _id_A58A63E4796BDA00();
}

_id_A58A63E4796BDA00() {
  level endon("game_ended");
  self endon("death");
  _id_FE66ECF180EC2613 = getdvarint("dvar_22560D0A816512D0", 75);
  _id_3DAFA337A7EED569 = getdvarint("dvar_2233030A813EB51A", 100);
  waittime = randomintrange(_id_FE66ECF180EC2613, _id_3DAFA337A7EED569);
  wait(waittime);

  while(!istrue(self._id_AB290448DB7FC1D6))
    wait 1;

  if(isDefined(self._id_0566868292EE2A1B)) {
    self _meth_1CD1EE312FD03BB4(0);
    self._id_AB290448DB7FC1D6 = undefined;
    self._id_37DB87FAA54F5A2B = (self._id_37DB87FAA54F5A2B + 1) % self._id_0566868292EE2A1B.paths.size;
    self._id_F1A894F81AD453AF = self._id_0566868292EE2A1B.paths[self._id_37DB87FAA54F5A2B];
    _id_C229D93C0BB4F8E8 = self._id_0566868292EE2A1B._id_B7015A0DBEFEBCE1[self._id_37DB87FAA54F5A2B];
    self.origin = _id_C229D93C0BB4F8E8.origin;
    self.angles = _id_C229D93C0BB4F8E8.angles;
    self notify("getaway_newPath");

    if(istrue(self._id_2CCE8E007AD7BDDD))
      _id_8F0DB36A6A62724C(self.origin);

    scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
    self._id_0566868292EE2A1B._id_7D8AD21E5DFD7C94 = [];
  }
}

_id_1D444946AFDD9304() {
  foreach(_id_0566868292EE2A1B in level._id_6A4C9FBD7AA58544["getaway"].instances) {
    if(_id_0566868292EE2A1B._id_E2958F412A7425C0 == self) {
      _id_9957E56A02C76205();
      self notify("boss_despawn");
      self delete();
      return;
    }
  }
}

_id_8A2AE9ADB168E75E() {
  self _meth_D2E41C7603BA7697("p2p");
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
  self _meth_77320E794D35465A("p2p", "steeringMultiplier", 2.5);
  self _meth_77320E794D35465A("p2p", "stuckTime", 0.5);
  self _meth_77320E794D35465A("p2p", "stuckForcedReverseTime", 2);
  self _meth_77320E794D35465A("p2p", "reverseGasWhileStuck", 0.5);
  self _meth_77320E794D35465A("p2p", "reverseGasNormal", 0.5);
  self _meth_77320E794D35465A("p2p", "useAccurateAckermannSteeringGeometry", 1);
  self _meth_77320E794D35465A("p2p", "considerGoalThresholdRadius", 1);
  self _meth_77320E794D35465A("p2p", "resetGoalReachedOnNewGoalPoint", 1);
  _id_2F10825BA72AADD1 = _id_3E1BE8D0DC72E4A4();
  _id_2F10825BA72AADD1 = _id_F9876B4636011819(_id_2F10825BA72AADD1);
  _id_8483B16A68572091(_id_2F10825BA72AADD1);
  _id_63EDC1100BD70453();
}

_id_F2C3A07C2576D008() {
  if(istrue(self._id_6471343D5103DDE5))
    return _id_597492F1129C657E();

  return _id_3E1BE8D0DC72E4A4();
}

_id_3E1BE8D0DC72E4A4() {
  if(istrue(self._id_BA4FD609AD418385))
    return _id_C1C0E85942D8BE40();

  return self._id_F2FF23BA01017057;
}

_id_C1C0E85942D8BE40() {
  if(_id_9D3DF757AA3776B8())
    return self._id_813D53B703CA8F8A;

  return self._id_78004B3FCB407A05;
}

_id_597492F1129C657E() {
  return self._id_F2FF23BA01017057;
}

_id_F9876B4636011819(speed) {
  if(istrue(self._id_3F6A557A85BBF19B))
    return 0;

  if(isDefined(self._id_262F9EB7A241E07F) && isDefined(self._id_262F9EB7A241E07F._id_4CCF35E9D9CC044F))
    return min(speed, self._id_262F9EB7A241E07F._id_4CCF35E9D9CC044F);

  return speed;
}

_id_9D3DF757AA3776B8() {
  return isDefined(self._id_3D925AA15AE310A5) && self._id_3D925AA15AE310A5.size <= 1;
}

_id_92534F8E28DF198A() {
  self endon("death");
  result = undefined;
  _id_172F57D206893FCD = _id_723B6CD8C3D9080F(self);
  thread _id_FD0161D37F23474C();

  while(isDefined(_id_172F57D206893FCD)) {
    waitframe();

    if(isDefined(result)) {
      if(result == "near_goal") {
        if(_id_AFB70FC41B839519(_id_172F57D206893FCD)) {
          self.currentstate = "idle";
          self _meth_77320E794D35465A("p2p", "pause", 1);
          scripts\engine\utility::_id_CF308F348D516C65(_id_172F57D206893FCD._id_49C67399CCDA3BC1, self, "escaping");
          self _meth_77320E794D35465A("p2p", "resume", 1);
        }

        if(_id_BC62C05D8DBB95BE(_id_172F57D206893FCD))
          _id_A555F970E85EEAE7(_id_172F57D206893FCD);

        if(_id_709ACCA3005E029B(_id_172F57D206893FCD)) {
          _id_8BAA47470A179E19 = _id_172F57D206893FCD.origin;
          _id_172F57D206893FCD = _id_723B6CD8C3D9080F(_id_172F57D206893FCD);
          result = _id_0ABFF48F75042EFF(_id_172F57D206893FCD.origin, _id_8BAA47470A179E19);

          if(!isDefined(result) || result == "spline_skip" || result == "low_speed" || result == "spline_timeout" || result == "spline_ended" || result == "in_water") {} else if(result == "node_skip") {
            if(_id_709ACCA3005E029B(_id_172F57D206893FCD))
              _id_172F57D206893FCD = _id_723B6CD8C3D9080F(_id_172F57D206893FCD);
            else {
              self._id_AB290448DB7FC1D6 = 1;
              self _meth_1CD1EE312FD03BB4(1);
              _id_FBBA62F9C96F912A();
              self waittill("getaway_newPath");
              _id_172F57D206893FCD = _id_723B6CD8C3D9080F(self);
            }
          }

          self.currentstate = "roam";
        } else {
          self._id_AB290448DB7FC1D6 = 1;
          self _meth_1CD1EE312FD03BB4(1);
          _id_FBBA62F9C96F912A();
          self waittill("getaway_newPath");
          _id_172F57D206893FCD = _id_723B6CD8C3D9080F(self);
        }
      } else if(result == "path_blocked") {} else {}
    } else {}

    result = _id_255139E1C1D637D1(_id_172F57D206893FCD);
  }
}

_id_FBBA62F9C96F912A() {
  entitynumber = self getentitynumber();

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player notify("forced_kill_callout_" + entitynumber);
  }
}

_id_FD0161D37F23474C() {
  self endon("death");
  self._id_3F6A557A85BBF19B = 0;
  waitframe();

  while(isDefined(self._id_262F9EB7A241E07F)) {
    _id_0B13EFCE2FD79BF9();
    _id_63EDC1100BD70453();
    waitframe();
  }
}

_id_0B13EFCE2FD79BF9() {
  _id_3F6A557A85BBF19B = scripts\common\utility::_id_35C178C80FA19CBD("ddos", "disabled");

  if(_id_3F6A557A85BBF19B != self._id_3F6A557A85BBF19B) {
    self._id_3F6A557A85BBF19B = _id_3F6A557A85BBF19B;
    speed = scripts\engine\utility::ter_op(_id_3F6A557A85BBF19B, 0, _id_F2C3A07C2576D008());
    speed = _id_F9876B4636011819(speed);
    _id_8483B16A68572091(speed);
  }
}

_id_63EDC1100BD70453() {
  velocity = self vehicle_getvelocity();
  forward = anglesToForward(self.angles);
  _id_5110BFC25C4FAF1E = vectordot(forward, velocity) > 0;

  if(_id_5110BFC25C4FAF1E) {
    speed = self vehicle_getspeed();
    _id_F2FF23BA01017057 = 16.9;
    _id_78004B3FCB407A05 = 31.5;
    _id_A51734400FA0AB25 = 200;

    if(speed >= _id_F2FF23BA01017057 && speed <= _id_78004B3FCB407A05) {
      _id_6C8D21B2E54B2478 = (speed - _id_F2FF23BA01017057) / (_id_78004B3FCB407A05 - _id_F2FF23BA01017057);
      _id_A51734400FA0AB25 = _id_6C8D21B2E54B2478 * 100 + 200;
    } else if(speed < _id_F2FF23BA01017057) {
      if(istrue(self._id_3F6A557A85BBF19B))
        _id_A51734400FA0AB25 = 200;
      else {
        _id_6C8D21B2E54B2478 = speed / _id_F2FF23BA01017057;
        _id_A51734400FA0AB25 = _id_6C8D21B2E54B2478 * 200;
      }
    } else
      _id_A51734400FA0AB25 = 300;
  } else
    _id_A51734400FA0AB25 = 1;

  self _meth_77320E794D35465A("p2p", "goalThreshold", _id_A51734400FA0AB25);
  self._id_A51734400FA0AB25 = _id_A51734400FA0AB25;
}

_id_AFB70FC41B839519(_id_172F57D206893FCD) {
  return isDefined(_id_172F57D206893FCD._id_49C67399CCDA3BC1) && !istrue(self._id_BA4FD609AD418385);
}

_id_709ACCA3005E029B(node) {
  return !istrue(node._id_8B79D0E3AD3FB617) && isDefined(node._id_F1A894F81AD453AF) && node._id_F1A894F81AD453AF.size > 0;
}

_id_723B6CD8C3D9080F(currentnode) {
  _id_0E052C0161D3EF54 = [];

  foreach(_id_29376CACC64CC4E6 in currentnode._id_F1A894F81AD453AF) {
    if(_id_CBF33E428D383E42(_id_29376CACC64CC4E6))
      _id_0E052C0161D3EF54[_id_0E052C0161D3EF54.size] = _id_29376CACC64CC4E6;
  }

  if(_id_0E052C0161D3EF54.size == 0)
    return undefined;

  _id_D4DD08EA3680E7F4 = randomint(_id_0E052C0161D3EF54.size);
  index = scripts\engine\utility::ter_op(_id_0E052C0161D3EF54.size > 1, _id_D4DD08EA3680E7F4, 0);
  return _id_0E052C0161D3EF54[index];
}

_id_CBF33E428D383E42(node) {
  if(istrue(node._id_6151219583257C64))
    return istrue(self._id_BA4FD609AD418385);

  if(istrue(node._id_0D8AACB6BA39B8C6))
    return !istrue(self._id_BA4FD609AD418385);

  return 1;
}

_id_BC62C05D8DBB95BE(node) {
  return 0;
}

_id_A555F970E85EEAE7(node) {
  _id_7337DC942371CDE8 = [];
  _id_7337DC942371CDE8["east"] = "tram_east_to_west";
  _id_7337DC942371CDE8["west"] = "tram_west_to_east";

  foreach(_id_7F853C287B0B8AF8 in node._id_3C7E11089422B540) {
    if(isDefined(_id_7337DC942371CDE8[_id_7F853C287B0B8AF8]))
      thread _id_FE81CF20F3755F3E(_id_7337DC942371CDE8[_id_7F853C287B0B8AF8]);
  }
}

_id_FE81CF20F3755F3E(_id_7F853C287B0B8AF8) {
  level endon("game_ended");

  if(!isDefined(self._id_643B074221181779))
    self._id_643B074221181779 = [];

  self._id_643B074221181779[self._id_643B074221181779.size] = _id_7F853C287B0B8AF8;
  _id_445B8E3C7F65E081 = undefined;

  if(isDefined(self._id_1A30C325005E16A5)) {
    _id_445B8E3C7F65E081 = randomintrange(self._id_9F7B2CEF12A7C8F3, self._id_9F9E42EF12CE410D);
    _id_445B8E3C7F65E081 = _id_445B8E3C7F65E081 - (gettime() - self._id_1A30C325005E16A5);
    _id_445B8E3C7F65E081 = max(0, _id_445B8E3C7F65E081);
  }

  self._id_1A30C325005E16A5 = gettime();

  if(isDefined(_id_445B8E3C7F65E081))
    wait(_id_445B8E3C7F65E081);

  level notify("resume_delta_movingtrain", _id_7F853C287B0B8AF8);
}

_id_7CD478841C1E0001() {
  _id_B0522F8BAD1F65FF = ["tram_east_to_west", "tram_west_to_east"];

  foreach(_id_7F853C287B0B8AF8 in _id_B0522F8BAD1F65FF)
  thread _id_FE81CF20F3755F3E(_id_7F853C287B0B8AF8);
}

_id_34E6B11CD60141AC(_id_4EF9E4A1EA3E8D89, _id_4209F05DD035E702, _id_10EE98E5A0EBFD49) {
  self endon("reached_end_node");
  self endon("path_blocked");
  self endon("death");

  if(!isDefined(_id_10EE98E5A0EBFD49))
    _id_10EE98E5A0EBFD49 = self._id_A51734400FA0AB25;

  _id_896A81FC006302CD = _id_10EE98E5A0EBFD49 * _id_10EE98E5A0EBFD49;
  timer = 0;
  timeout = 3;

  for(;;) {
    if(distance2dsquared(self.origin, _id_4EF9E4A1EA3E8D89) < _id_896A81FC006302CD)
      return "spline_ended";

    if(distance2dsquared(self.origin, _id_4209F05DD035E702) < _id_896A81FC006302CD)
      return "node_skip";

    if(timer >= timeout)
      return "spline_timeout";

    _id_A3FEAB549FDCB153 = self vehicle_getspeed();

    if(_id_A3FEAB549FDCB153 < 5)
      return "low_speed";

    self _meth_77320E794D35465A("path", "radiusToStep", max(self._id_A51734400FA0AB25 + 5, 200));
    timer = timer + level.framedurationseconds;
    waitframe();
  }
}

_id_0ABFF48F75042EFF(targetorigin, _id_8BAA47470A179E19) {
  _id_A3FEAB549FDCB153 = self vehicle_getspeed();

  if(_id_A3FEAB549FDCB153 < 5)
    return "low_speed";

  _id_4E48F4F90EE5AC43 = self _meth_962A6476FE1C33EE();

  if(_id_4E48F4F90EE5AC43 == "veh_amphibious_water")
    return "in_water";

  _id_97C91012A5E24992 = self getorigin();
  _id_ECBF1912E3659CE3 = self vehicle_getvelocity();
  dot = clamp(_func_C1AA7C066EC92CA5(_id_ECBF1912E3659CE3, targetorigin - _id_97C91012A5E24992), -1.0, 1.0);
  angle = acos(dot);
  result = undefined;

  if(angle > self._id_0B9F9F547C1377D6) {
    _id_6E3005AA69B4A271 = _func_767CEA82B001F645(targetorigin - _id_8BAA47470A179E19);
    _id_F2EE88DFB075F111 = _func_767CEA82B001F645(_id_8BAA47470A179E19 - _id_97C91012A5E24992);
    _id_A6A2B18DCB5074FC = _func_767CEA82B001F645(_id_ECBF1912E3659CE3);
    _id_0B0F38B900E9B33F = _id_A6A2B18DCB5074FC * 200;
    _id_7A4A739E8EC0A373 = max(self._id_A51734400FA0AB25, 200);
    _id_6AA6B2429E55CD32 = _id_8BAA47470A179E19 + _id_0B0F38B900E9B33F;
    _id_0756BEB25CED7321 = 0.5 * _id_7A4A739E8EC0A373;
    _id_7DB6235A7408E42F = [];
    _id_7DB6235A7408E42F[0] = _id_6AA6B2429E55CD32 - _id_F2EE88DFB075F111 * _id_7A4A739E8EC0A373;
    _id_7DB6235A7408E42F[1] = _id_6AA6B2429E55CD32 - _id_F2EE88DFB075F111 * _id_0756BEB25CED7321;
    _id_7DB6235A7408E42F[2] = _id_6AA6B2429E55CD32 + _id_6E3005AA69B4A271 * _id_0756BEB25CED7321;
    _id_7DB6235A7408E42F[3] = _id_6AA6B2429E55CD32 + _id_6E3005AA69B4A271 * _id_7A4A739E8EC0A373;
    _id_7DB6235A7408E42F[4] = _id_6AA6B2429E55CD32 + _id_6E3005AA69B4A271 * 2 * _id_7A4A739E8EC0A373;
    _id_A3FEAB549FDCB153 = max(_id_A3FEAB549FDCB153, self._id_F2FF23BA01017057);
    times = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7DB6235A7408E42F.size; _id_AC0E594AC96AA3A8++) {
      _id_B7AB7579B3C791B1 = undefined;

      if(_id_AC0E594AC96AA3A8 == 0)
        _id_B7AB7579B3C791B1 = _id_97C91012A5E24992;
      else
        _id_B7AB7579B3C791B1 = _id_7DB6235A7408E42F[_id_AC0E594AC96AA3A8 - 1];

      currentpoint = _id_7DB6235A7408E42F[_id_AC0E594AC96AA3A8];
      times[_id_AC0E594AC96AA3A8] = _id_4BAC13D511590220::get_duration_between_points(_id_B7AB7579B3C791B1, currentpoint, _id_A3FEAB549FDCB153, 1);
    }

    _id_442A530F228EBD29 = spawnStruct();
    _id_442A530F228EBD29.points = _id_7DB6235A7408E42F;
    _id_442A530F228EBD29.times = times;
    _id_442A530F228EBD29._id_79D924275E2B5029 = 0;
    _id_442A530F228EBD29._id_E9B075032AC9F4DD = 0.5;
    _id_3319FFF16AE7F89B = _id_597492F1129C657E();
    _id_3319FFF16AE7F89B = _id_F9876B4636011819(_id_3319FFF16AE7F89B);
    _id_8483B16A68572091(_id_3319FFF16AE7F89B);
    self._id_6471343D5103DDE5 = 1;
    self._id_FC34186159901BBA = _func_6E313DDA90FB035F(_id_442A530F228EBD29.points, _id_442A530F228EBD29.times, _id_442A530F228EBD29._id_79D924275E2B5029, _id_442A530F228EBD29._id_E9B075032AC9F4DD);
    self _meth_77320E794D35465A("p2p", "brakeAtGoal", 0);
    self _meth_D2E41C7603BA7697("path");
    self _meth_77320E794D35465A("path", "catmullRomId", self._id_FC34186159901BBA);
    self _meth_77320E794D35465A("path", "stepProximityFactor", 5);
    self _meth_77320E794D35465A("path", "radiusToStep", max(self._id_A51734400FA0AB25 + 5, 200));
    self _meth_77320E794D35465A("path", "setBrakeAtGoalOnEndNode", 0);
    self _meth_77320E794D35465A("path", "yawHelper", 1);
    result = _id_34E6B11CD60141AC(_id_7DB6235A7408E42F[_id_7DB6235A7408E42F.size - 1], targetorigin, self._id_A51734400FA0AB25);
    self stoppath();
    self _meth_6A325F91941ED47C("path");
    self._id_6471343D5103DDE5 = undefined;
  } else
    result = "spline_skip";

  return result;
}

_id_255139E1C1D637D1(_id_262F9EB7A241E07F) {
  self._id_262F9EB7A241E07F = _id_262F9EB7A241E07F;
  targetorigin = _id_262F9EB7A241E07F.origin;

  if(isDefined(_id_262F9EB7A241E07F._id_20247FB9F3BABB74))
    self._id_BC2F6E50D4761BFA = _id_262F9EB7A241E07F._id_20247FB9F3BABB74;

  _id_67FDD7F46DAEE991 = _id_AFB70FC41B839519(_id_262F9EB7A241E07F) || !_id_709ACCA3005E029B(_id_262F9EB7A241E07F);
  self _meth_77320E794D35465A("p2p", "brakeAtGoal", _id_67FDD7F46DAEE991);
  _id_FDAAF77413E3084A = self _meth_962A6476FE1C33EE();
  _id_2F10825BA72AADD1 = _id_3E1BE8D0DC72E4A4();
  _id_2F10825BA72AADD1 = _id_F9876B4636011819(_id_2F10825BA72AADD1);
  result = undefined;

  if(self._id_BC2F6E50D4761BFA)
    result = _id_4BAC13D511590220::_id_8F40A2C8678F8304(self.origin, targetorigin, _id_2F10825BA72AADD1);
  else {
    _id_8483B16A68572091(_id_2F10825BA72AADD1);
    self _meth_77320E794D35465A("p2p", "goalPoint", targetorigin);
  }

  if(!isDefined(result))
    result = scripts\engine\utility::waittill_any_return_3("near_goal", "path_blocked", "p2p_component_reset");

  return result;
}

_id_955A53CD76A3FBE1() {
  self endon("death");
  _id_AFC12F05CE5A1EEC = self _meth_962A6476FE1C33EE();

  while(!_func_96D228FA8E72A818(self)) {
    if(!self _meth_01E8542A707A8002("p2p")) {
      _id_CBAAC34D8397CD0D = self _meth_962A6476FE1C33EE();

      if(_id_AFC12F05CE5A1EEC != _id_CBAAC34D8397CD0D) {
        _id_AFC12F05CE5A1EEC = _id_CBAAC34D8397CD0D;
        _id_8A2AE9ADB168E75E();
        thread _id_255139E1C1D637D1(self._id_262F9EB7A241E07F);
        waitframe();
        self notify("p2p_component_reset");
      }
    }

    waitframe();
  }
}

_id_F7D4BA6C999AAA44(nodes) {
  _id_58E0D036347FD542 = [];
  _id_39ADBD994DF460B8 = getdvarint("dvar_00AF41DDC6F24FEF", -1);

  foreach(index, node in nodes) {
    if(_id_39ADBD994DF460B8 >= 0 && index != _id_39ADBD994DF460B8) {
      continue;
    }
    _id_E25B47370653DED5 = 1;
    _id_EF28F26BF86C8CFD = [node];

    while(_id_EF28F26BF86C8CFD.size > 0) {
      lastindex = _id_EF28F26BF86C8CFD.size - 1;
      targetnode = _id_EF28F26BF86C8CFD[lastindex];
      _id_EF28F26BF86C8CFD[lastindex] = undefined;

      if(scripts\engine\utility::array_contains(_id_58E0D036347FD542, targetnode)) {
        _id_E25B47370653DED5 = 0;
        break;
      }

      if(isDefined(targetnode.target)) {
        _id_08EB7449458BD838 = 0;
        _id_ED710652CF74DE26 = 0;
        targets = scripts\engine\utility::getStructArray(targetnode.target, "targetname");

        foreach(target in targets) {
          if(isDefined(target)) {
            _id_8BDE1CED0BE43D69 = spawnStruct();
            _id_8BDE1CED0BE43D69 _id_ED2EE8C177B65B43(target);

            if(!istrue(_id_8BDE1CED0BE43D69._id_6151219583257C64))
              _id_08EB7449458BD838 = 1;

            if(!istrue(_id_8BDE1CED0BE43D69._id_0D8AACB6BA39B8C6))
              _id_ED710652CF74DE26 = 1;

            if(istrue(_id_8BDE1CED0BE43D69._id_8B79D0E3AD3FB617))
              target._id_8B79D0E3AD3FB617 = 1;

            _id_EF28F26BF86C8CFD[_id_EF28F26BF86C8CFD.size] = target;
          }
        }

        if(istrue(targetnode._id_8B79D0E3AD3FB617)) {
          _id_E25B47370653DED5 = 0;
          break;
        }

        if(!_id_08EB7449458BD838) {
          _id_E25B47370653DED5 = 0;
          break;
        }

        if(!_id_ED710652CF74DE26) {
          _id_E25B47370653DED5 = 0;
          break;
        }

        if(isDefined(targetnode._id_3C7E11089422B540)) {
          foreach(_id_7F853C287B0B8AF8 in targetnode._id_3C7E11089422B540) {
            if(_id_7F853C287B0B8AF8 != "west" && _id_7F853C287B0B8AF8 != "east") {}
          }
        }

        continue;
      }

      if(!istrue(targetnode._id_8B79D0E3AD3FB617)) {
        _id_E25B47370653DED5 = 0;
        break;
      }
    }

    if(_id_E25B47370653DED5)
      _id_58E0D036347FD542[_id_58E0D036347FD542.size] = node;
  }

  return _id_58E0D036347FD542;
}

_id_4717043A80AA5766(node) {
  _id_584343C90B6513FF = node;
  _id_4CE60BFA72F076EC = [node];
  _id_C51AFA1E6CF090CD = [];

  while(_id_4CE60BFA72F076EC.size > 0) {
    lastindex = _id_4CE60BFA72F076EC.size - 1;
    node = _id_4CE60BFA72F076EC[lastindex];
    _id_4CE60BFA72F076EC[lastindex] = undefined;

    if(!isDefined(node.target)) {
      continue;
    }
    if(!isDefined(_id_C51AFA1E6CF090CD[node.target])) {
      _id_F903FEE99F3EC06D = _id_47B02E23F87CF4D3(node.target);
      _id_4CE60BFA72F076EC = scripts\engine\utility::array_combine(_id_F903FEE99F3EC06D, _id_4CE60BFA72F076EC);
      _id_C51AFA1E6CF090CD[node.target] = _id_F903FEE99F3EC06D;
    }
  }

  _id_740926EE0AE470A4 = [_id_584343C90B6513FF.target];

  for(_id_4CE60BFA72F076EC = _id_C51AFA1E6CF090CD; _id_4CE60BFA72F076EC.size > 0; _id_740926EE0AE470A4 = _id_1A2F45598924632F) {
    _id_1A2F45598924632F = [];

    foreach(targetname in _id_740926EE0AE470A4) {
      if(!isDefined(_id_C51AFA1E6CF090CD[targetname])) {
        continue;
      }
      foreach(node in _id_C51AFA1E6CF090CD[targetname]) {
        if(isDefined(node.target)) {
          node._id_F1A894F81AD453AF = _id_C51AFA1E6CF090CD[node.target];
          _id_1A2F45598924632F[_id_1A2F45598924632F.size] = node.target;
        }
      }

      _id_4CE60BFA72F076EC[targetname] = undefined;
    }
  }

  foreach(_id_810692A1EEAA6849 in _id_C51AFA1E6CF090CD) {
    foreach(node in _id_810692A1EEAA6849) {
      node.target = undefined;
      node.targetname = undefined;
    }
  }

  _id_810692A1EEAA6849 = _id_C51AFA1E6CF090CD[_id_584343C90B6513FF.target];
  return _id_810692A1EEAA6849;
}

_id_47B02E23F87CF4D3(targetname) {
  _id_810692A1EEAA6849 = [];
  targets = scripts\engine\utility::getStructArray(targetname, "targetname");

  foreach(target in targets) {
    if(isDefined(target)) {
      _id_7F39DDF85B8B395C = spawnStruct();
      _id_7F39DDF85B8B395C.origin = target.origin;
      _id_7F39DDF85B8B395C.target = target.target;
      _id_7F39DDF85B8B395C _id_ED2EE8C177B65B43(target);
      _id_810692A1EEAA6849[_id_810692A1EEAA6849.size] = _id_7F39DDF85B8B395C;
    }
  }

  return _id_810692A1EEAA6849;
}

_id_ED2EE8C177B65B43(node) {
  if(!isDefined(node.script_noteworthy)) {
    return;
  }
  script_noteworthy = tolower(node.script_noteworthy);
  _id_67F14F8315CB0F2F = strtok(script_noteworthy, ",");

  foreach(_id_E921CD2D3FB29B66 in _id_67F14F8315CB0F2F) {
    _id_8AFFBA174AD67158 = strtok(_id_E921CD2D3FB29B66, "=");

    switch (_id_8AFFBA174AD67158[0]) {
      case "usenavmesh":
        self._id_20247FB9F3BABB74 = _id_8AFFBA174AD67158[1] == "true";
        break;
      case "stop":
        self._id_49C67399CCDA3BC1 = int(_id_8AFFBA174AD67158[1]);
        break;
      case "escapeonly":
        self._id_6151219583257C64 = 1;
        break;
      case "roamonly":
        self._id_0D8AACB6BA39B8C6 = 1;
        break;
      case "speedlimit":
        self._id_4CCF35E9D9CC044F = int(_id_8AFFBA174AD67158[1]);
        break;
      case "end":
        self._id_8B79D0E3AD3FB617 = 1;
        break;
      case "releasetrain":
        if(!isDefined(self._id_3C7E11089422B540))
          self._id_3C7E11089422B540 = [];

        self._id_3C7E11089422B540[self._id_3C7E11089422B540.size] = _id_8AFFBA174AD67158[1];
        break;
      default:
        break;
    }
  }
}

_id_EF3C629E76458FDD() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_A4AA0CA0BB299E64 = 1;
    _id_A81DEF6B99BE9835 = self.origin + (0, 0, 80);

    if(_id_A4AA0CA0BB299E64) {
      _id_884A42FB00B49C01 = 0;

      foreach(player in level.players) {
        if(isDefined(player.vehicle) && _id_BFDF39B811CE950D(_id_A81DEF6B99BE9835, player.vehicle)) {
          _id_884A42FB00B49C01 = 1;
          _id_B07FC78B324D7421(player);
          continue;
        }

        if(_id_BD9142F5361E64C6(_id_A81DEF6B99BE9835, player)) {
          _id_884A42FB00B49C01 = 1;
          _id_B07FC78B324D7421(player);
        }
      }

      if(_id_884A42FB00B49C01) {
        _id_B899DCC5EBC85EE0();
        thread _id_2E0189834D3A4603();
        waittime = max(0.2, self._id_6492BC580AF9358E - 5);
        wait(waittime);
      }
    }

    wait 0.4;
  }
}

_id_BD9142F5361E64C6(_id_A81DEF6B99BE9835, player) {
  _id_1E96530E4BC3C851 = ["j_head", "j_shoulder_ri", "j_shoulder_le", "j_mainroot"];

  if(!isDefined(player))
    return 0;

  if(distancesquared(player.origin, _id_A81DEF6B99BE9835) < self._id_ECBCF02A326B4EBC) {
    foreach(tag in _id_1E96530E4BC3C851) {
      tagorigin = player gettagorigin(tag);

      if(sighttracepassed(_id_A81DEF6B99BE9835, tagorigin, 0, self))
        return 1;
    }
  }

  return 0;
}

_id_BFDF39B811CE950D(_id_A81DEF6B99BE9835, vehicle) {
  if(!isDefined(vehicle))
    return 0;

  _id_6F3A90A6B2B8799D = vehicle.origin + (0, 0, 50);

  if(distancesquared(_id_6F3A90A6B2B8799D, _id_A81DEF6B99BE9835) < self._id_ECBCF02A326B4EBC) {
    trace = scripts\engine\trace::ray_trace(_id_A81DEF6B99BE9835, _id_6F3A90A6B2B8799D);
    fraction = trace["fraction"];
    ent = trace["entity"];

    if(isDefined(fraction) && fraction == 1 || isDefined(ent) && ent == vehicle)
      return 1;
  }

  return 0;
}

_id_93FC4DDEF057CBFE(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  if(isDefined(inflictor) && isDefined(inflictor.owner) && inflictor.owner == self) {
    return;
  }
  if(!istrue(self._id_1CD2082B231A9A13)) {
    return;
  }
  if(isagent(attacker))
    damage = int(ceil(damage * self._id_98FD2804CFEACE92));

  self[[level.vehicles.damagecallback]](inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid);
}

_id_1FBA720CE819791C(instance) {
  level endon("game_ended");
  self waittill("death", _id_6181DE250AFA5BB6);

  if(!isDefined(self)) {
    return;
  }
  _id_71D51A073D7AA433(1);
  _id_EC13AA0608F307FC();
  _id_9957E56A02C76205();
  team = undefined;

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team))
    team = _id_6181DE250AFA5BB6.team;

  _id_74B5B12BB6514385 = 1.0;
  _id_EC6A81EAC0E4DC61 = [];

  if(isDefined(team)) {
    _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_driver_eliminated", team, _id_74B5B12BB6514385);
    _id_CEB1FF9428033CFD = scripts\engine\utility::array_remove_array(level.players, scripts\mp\utility\teams::getteamdata(team, "players"));
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "killer_uno_id";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_6181DE250AFA5BB6 _meth_7A32B0201993D7F7();
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "team";
    _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = team;
  } else
    _id_CEB1FF9428033CFD = level.players;

  dlog_recordevent("dlog_event_dmz_boss_getaway_takedown", _id_EC6A81EAC0E4DC61);
  _id_CEB1FF9428033CFD = scripts\engine\utility::array_removeundefined(_id_CEB1FF9428033CFD);
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("boss_driver_kia", _id_CEB1FF9428033CFD, _id_74B5B12BB6514385, 1);

  if(isDefined(_id_6181DE250AFA5BB6))
    _id_65F58F3C394DCF9A::_id_73F954808739F7BC(instance, _id_6181DE250AFA5BB6, "dmz_boss_bullfrog_win", 2.5);
}

_id_C1FD28F8A07779B0() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    player = _id_087181E724C8DA49(attacker);

    if(isDefined(player)) {
      _id_B07FC78B324D7421(player);
      _id_B899DCC5EBC85EE0();
      thread _id_2E0189834D3A4603();
    } else if(isagent(inflictor) && self.team != inflictor.team)
      thread _id_2E0189834D3A4603();

    _id_71D51A073D7AA433();
    _id_C09E5D188F407C87(attacker);
  }
}

_id_B07FC78B324D7421(player) {
  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(self._id_3D925AA15AE310A5))
    self._id_3D925AA15AE310A5 = [];

  _id_C84DC5F0D9A11F84(player, gettime());
}

_id_C84DC5F0D9A11F84(player, timer) {
  data = spawnStruct();
  data.player = player;
  data.timer = timer;
  _id_D0C167F100A76975(data);
  self._id_3D925AA15AE310A5[player getentitynumber()] = data;
}

_id_16B15F5E4A751A3A() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    wait 0.5;

    if(!isDefined(self._id_3D925AA15AE310A5)) {
      continue;
    }
    _id_68105A8315ED7941 = [];
    currenttime = gettime();

    foreach(data in self._id_3D925AA15AE310A5) {
      if(isDefined(data.player) && currenttime - data.timer < 8000)
        _id_68105A8315ED7941[data.player getentitynumber()] = data;
    }

    self._id_3D925AA15AE310A5 = _id_68105A8315ED7941;
    _id_B899DCC5EBC85EE0();
  }
}

_id_B899DCC5EBC85EE0() {
  currenttime = gettime();

  foreach(data in self._id_3D925AA15AE310A5) {
    if(!isDefined(data.player.team)) {
      continue;
    }
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(data.player.team, "alivePlayers");

    foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
      if(distancesquared(data.player.origin, _id_F0EA4030349A33D5.origin) < self._id_ECBCF02A326B4EBC)
        _id_C84DC5F0D9A11F84(_id_F0EA4030349A33D5, data.timer);
    }
  }
}

_id_39F164C8EDAD43D5() {
  self._id_0D974FFCFAC54803 = [];
  _id_9BAD0C9374BE4038("military_carepackage_03_delta_dmz_boss");
  _id_9BAD0C9374BE4038("prop_un_military_duffle_bag_01", (-20, 25, 10));
  _id_9BAD0C9374BE4038("prop_un_military_duffle_bag_01", (-20, 25, 20));
  _id_9BAD0C9374BE4038("prop_un_military_duffle_bag_01", (-20, -40, 10));
  _id_9BAD0C9374BE4038("prop_un_military_duffle_bag_01", (-20, -40, 20));
}

_id_9BAD0C9374BE4038(modelname, offset) {
  if(!isDefined(offset))
    offset = (0, 0, 0);

  offset = offset + (-51.582, 0, 14.776);
  _id_7D41C50E8B95F282 = spawn("script_model", (0, 0, 0));
  _id_7D41C50E8B95F282 setModel(modelname);
  _id_7D41C50E8B95F282 linkTo(self, "tag_origin", offset, (0, 0, 0));
  self._id_0D974FFCFAC54803 = scripts\engine\utility::array_add(self._id_0D974FFCFAC54803, _id_7D41C50E8B95F282);
}

_id_9957E56A02C76205() {
  if(isDefined(self._id_0D974FFCFAC54803))
    scripts\engine\utility::array_delete(self._id_0D974FFCFAC54803);
}

_id_087181E724C8DA49(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent))
      return ent;

    if(isDefined(ent.vehicletype) && isDefined(ent.owner) && isPlayer(ent.owner))
      return ent.owner;
  }

  return undefined;
}

_id_71D51A073D7AA433(isdead) {
  if(istrue(self._id_A4627541C1E4E54E)) {
    return;
  }
  healthratio = scripts\engine\utility::ter_op(istrue(isdead), 0, self.health / self.maxhealth);
  self.itemsdropped = 0;
  rewards = undefined;

  for(_id_11D65784F0B6AFA2 = self._id_2D4520BF83C93D41; _id_11D65784F0B6AFA2 < level._id_6A4C9FBD7AA58544["getaway"]._id_A136A131D25C1FA0.size && healthratio <= level._id_6A4C9FBD7AA58544["getaway"]._id_A136A131D25C1FA0[_id_11D65784F0B6AFA2].healthratio; _id_11D65784F0B6AFA2++) {
    _id_B7D859B6131F4ED3 = _id_B7B9E91B6500F316(_id_11D65784F0B6AFA2);

    if(isDefined(rewards)) {
      rewards = scripts\engine\utility::array_combine(rewards, _id_B7D859B6131F4ED3);
      continue;
    }

    rewards = _id_B7D859B6131F4ED3;
  }

  self._id_2D4520BF83C93D41 = _id_11D65784F0B6AFA2;

  if(isDefined(rewards) && rewards.size > 0)
    thread _id_A49F0907B0D52BBD(rewards);
}

_id_B7B9E91B6500F316(_id_93140492439DE389) {
  rewards = [];
  _id_5721EC9E1540B52C = level._id_6A4C9FBD7AA58544["getaway"]._id_A136A131D25C1FA0[_id_93140492439DE389].rewards;

  foreach(reward in _id_5721EC9E1540B52C)
  rewards[rewards.size] = reward;

  return rewards;
}

_id_A49F0907B0D52BBD(rewards) {
  level endon("game_ended");

  if(isDefined(self._id_EF9E59EB3528E1FC))
    rewards = scripts\engine\utility::array_combine(self._id_EF9E59EB3528E1FC, rewards);

  self._id_EF9E59EB3528E1FC = rewards;
  self notify("startedNewDropTrail");
  self endon("startedNewDropTrail");
  [droporigin, dropangles] = _id_51845FE693715603();
  wait 0.2;
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  while(rewards.size > 0) {
    if(isDefined(self))
      [droporigin, dropangles] = _id_51845FE693715603();

    last = rewards.size - 1;
    _id_9DC84EDEA1FC38FD = rewards[last];
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, droporigin, dropangles);
    _id_7E52B56769FA7774::spawnpickup(_id_9DC84EDEA1FC38FD, _id_CB4FAD49263E20C4, 1, 1);
    rewards[last] = undefined;

    if(isDefined(self))
      self._id_EF9E59EB3528E1FC = rewards;

    if(rewards.size > 0)
      wait 0.2;
  }

  self._id_EF9E59EB3528E1FC = undefined;
}

_id_51845FE693715603() {
  return [self gettagorigin("tag_dmz_boss_loot_spawn"), self gettagangles("tag_dmz_boss_loot_spawn")];
}

_id_C09E5D188F407C87(attacker) {
  if(!isDefined(attacker)) {
    return;
  }
  team = attacker.team;

  if(!isDefined(team)) {
    return;
  }
  healthratio = self.health / self.maxhealth;

  if(healthratio <= 0) {
    return;
  }
  if(!isDefined(self._id_6FF384AC50D8B0D6))
    self._id_6FF384AC50D8B0D6 = 0;

  _id_F1BBB363D1536E06 = [0.75, 0.5, 0.25];
  _id_64F88D0441939203 = gettime();
  self._id_9777D8876A7173AC[team] = _id_64F88D0441939203;

  if(self._id_6FF384AC50D8B0D6 >= _id_F1BBB363D1536E06.size) {
    return;
  }
  if(healthratio <= _id_F1BBB363D1536E06[self._id_6FF384AC50D8B0D6]) {
    self._id_6FF384AC50D8B0D6++;

    foreach(team, _id_B4C04337A6A90C84 in self._id_9777D8876A7173AC) {
      if(_id_64F88D0441939203 - _id_B4C04337A6A90C84 < self._id_5F59BD78A8BC8B5D)
        _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_driver_engage", team, 1);
    }
  }
}

_id_A123101F764A25C3() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_9663B48B3914B10F = istrue(self._id_1CD2082B231A9A13);
    _id_1CD2082B231A9A13 = _id_45B2B4A889E633FA::ispointinbounds(self.origin);

    if(_id_9663B48B3914B10F != _id_1CD2082B231A9A13) {
      _id_5BE42282AE3E2973(_id_1CD2082B231A9A13);

      if(_id_9663B48B3914B10F)
        _id_187FA8158218000A();
    }

    self._id_1CD2082B231A9A13 = _id_1CD2082B231A9A13;
    wait 0.2;
  }
}

_id_8483B16A68572091(_id_9BD80DE30AC955B2) {
  if(isDefined(self._id_262F9EB7A241E07F) && isDefined(self._id_262F9EB7A241E07F._id_4CCF35E9D9CC044F))
    _id_9BD80DE30AC955B2 = min(self._id_262F9EB7A241E07F._id_4CCF35E9D9CC044F, _id_9BD80DE30AC955B2);

  _id_4BAC13D511590220::_id_B3B7D0915DC445C7(_id_9BD80DE30AC955B2);
}

_id_D621968E8D9A67C7() {
  timer = 0;
  timeout = self._id_6492BC580AF9358E;
  _id_193BA10DFA6671B4 = level.framedurationseconds;
  _id_65D8AF8E6851EFDA = self vehicle_getspeed();
  _id_362EA91BC3F17F1A = 10;

  while(timer < timeout) {
    _id_BA4F3CA96C47B7D8 = self vehicle_getspeed();

    if(_id_BA4F3CA96C47B7D8 > self._id_F2FF23BA01017057 || _id_BA4F3CA96C47B7D8 - _id_65D8AF8E6851EFDA > _id_362EA91BC3F17F1A) {
      playFXOnTag(level._effect["vfx_delta_dmz_veh_boost_rnr"], self, "tag_exhaust");
      return;
    }

    timer = timer + _id_193BA10DFA6671B4;
    wait(_id_193BA10DFA6671B4);
  }
}

_id_959801F8E4CA9617() {
  level endon("game_ended");
  self endon("roaming");
  self endon("death");
  _id_C58E8E47D90B3DC5();
  thread _id_077CB3608B8C19A6();
  _id_D621968E8D9A67C7();
}

_id_C58E8E47D90B3DC5() {
  while(istrue(self._id_6471343D5103DDE5))
    waitframe();

  _id_78004B3FCB407A05 = _id_C1C0E85942D8BE40();
  _id_78004B3FCB407A05 = _id_F9876B4636011819(_id_78004B3FCB407A05);
  _id_8483B16A68572091(_id_78004B3FCB407A05);
}

_id_077CB3608B8C19A6() {
  self endon("roaming");
  self endon("death");
  _id_5679D6AEFA5D786D = _id_9D3DF757AA3776B8();

  for(;;) {
    wait 1;

    if(!isDefined(self._id_3D925AA15AE310A5)) {
      continue;
    }
    _id_56F23F56F0E856C1 = _id_9D3DF757AA3776B8();

    if(_id_56F23F56F0E856C1 != _id_5679D6AEFA5D786D) {
      _id_C58E8E47D90B3DC5();
      _id_5679D6AEFA5D786D = _id_56F23F56F0E856C1;
    }
  }
}

_id_2E0189834D3A4603() {
  level endon("game_ended");
  self notify("escaping");
  self endon("escaping");
  self endon("death");

  if(!istrue(self._id_BA4FD609AD418385)) {
    self._id_BA4FD609AD418385 = 1;
    self.currentstate = "escape";
    thread _id_DE1E62238F74B0D8();
    thread _id_959801F8E4CA9617();
    thread _id_B9118C8106A95AE2();
  }

  wait(self._id_6492BC580AF9358E);
  self notify("roaming");
  self._id_BA4FD609AD418385 = undefined;
  self.currentstate = "roam";
  thread _id_9A711D0B52D8CB6E();
  _id_543020482C67892F = self._id_F2FF23BA01017057;
  _id_543020482C67892F = _id_F9876B4636011819(_id_543020482C67892F);
  _id_8483B16A68572091(_id_543020482C67892F);
}

_id_B9118C8106A95AE2() {
  level endon("game_ended");
  self endon("death");
  self endon("roaming");
  self endon("boss_despawn");

  while(istrue(self._id_BA4FD609AD418385)) {
    wait(self._id_ECB595D73834DE8D);

    if(_id_0C17ECA6DB34BB47())
      _id_D2DA952076D9FC45();
  }
}

_id_0C17ECA6DB34BB47() {
  if(self.veh_speed < self._id_79D99354AEA449C1)
    return 0;

  if(!_id_709ACCA3005E029B(self._id_262F9EB7A241E07F))
    return 0;

  forward = anglesToForward(self.angles);
  _id_5110BFC25C4FAF1E = vectordot(forward, self vehicle_getvelocity()) > 0;
  return _id_5110BFC25C4FAF1E;
}

_id_D2DA952076D9FC45() {
  self playSound("bullfrog_boss_mine_eject");
  _id_806C214208CF5B41 = _id_E615868A15D523A0();
  mine = scripts\mp\utility\weapon::_launchgrenade("at_mine_mp", self.origin, _id_806C214208CF5B41, self._id_D379A8BDED406DFE);
  mine scripts\mp\equipment\at_mine::_id_9B1B9F121A84A4A1("at_mine_ap_mp", self._id_D379A8BDED406DFE + 10);
  mine thread _id_DB8004CBF0F6B1C9(self._id_D379A8BDED406DFE);
  mine.weapon_name = "at_mine_mp";
  mine.owner = self;
  mine.owner.plantedlethalequip = [];
  mine._id_E926ABD3E5970492 = 1;
  mine._id_40E5B4307CB6229C = 1;
  mine.weapon_object = makeweapon("at_mine_mp");
  mine.armtime = self._id_B66C0EEFBA57D97D;
  playFXOnTag(level._effect["vfx_delta_dmz_red_light_mines"], mine.dangericonent, "tag_fx");
  thread scripts\mp\equipment\at_mine::at_mine_use(mine);
}

_id_E615868A15D523A0() {
  _id_6540021BFB9A3FFE = 0.1;
  _id_6216A70332193755 = 1.0 - _id_6540021BFB9A3FFE;
  range = 2 * _id_6216A70332193755;
  _id_00AE14C5A8B1B582 = randomfloat(range);
  _id_B9DB33E54E5A924D = scripts\engine\utility::ter_op(_id_00AE14C5A8B1B582 < _id_6216A70332193755, _id_00AE14C5A8B1B582 - 1.0, _id_00AE14C5A8B1B582 - _id_6216A70332193755 + _id_6540021BFB9A3FFE);
  right = anglestoright(self.angles);
  return right * _id_B9DB33E54E5A924D * self._id_39CA18354C1E245E;
}

_id_DB8004CBF0F6B1C9(delay) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self playSound("bullfrog_boss_mine_plant");
  self playSound("bullfrog_boss_warning_beep");
  waittime = delay - level.framedurationseconds;
  wait(waittime);
  killfxontag(level._effect["vfx_delta_dmz_red_light_mines"], self.dangericonent, "tag_fx");
  waitframe();
  self notify("detonateExplosive");
}

_id_5BE42282AE3E2973(_id_1CD2082B231A9A13) {
  if(_id_1CD2082B231A9A13) {
    if(!istrue(self._id_BA4FD609AD418385))
      thread _id_78D1D6551C48B5F2();
  } else {
    state = scripts\engine\utility::ter_op(istrue(self._id_BA4FD609AD418385), "exfilEscape", "exfilRoam");
    self setscriptablepartstate("speaker", state, 0);
  }
}

_id_78D1D6551C48B5F2() {
  level endon("game_ended");
  self endon("escaping");
  self endon("death");
  self endon("kill_vo_threads");
  self setscriptablepartstate("speaker", "inbound", 0);
  wait(self._id_FEED7759C7E1ADF8);
  thread _id_9A711D0B52D8CB6E();
}

_id_9A711D0B52D8CB6E() {
  level endon("game_ended");
  self endon("escaping");
  self endon("death");
  self endon("kill_vo_threads");

  for(;;) {
    if(istrue(self._id_1CD2082B231A9A13)) {
      self setscriptablepartstate("speaker", "mute", 0);
      waitframe();
      self setscriptablepartstate("speaker", "roam", 0);
    }

    wait(self._id_FEED7759C7E1ADF8);
  }
}

_id_DE1E62238F74B0D8() {
  level endon("game_ended");
  self endon("roaming");
  self endon("death");
  self endon("kill_vo_threads");
  wait 0.5;
  self setscriptablepartstate("speaker", "escape", 0);

  for(;;) {
    wait(self._id_FEED7759C7E1ADF8);

    if(istrue(self._id_1CD2082B231A9A13)) {
      self setscriptablepartstate("speaker", "mute", 0);
      waitframe();

      if(_id_0C17ECA6DB34BB47())
        self setscriptablepartstate("speaker", "escapeMad", 0);
    }
  }
}

_id_D0C167F100A76975(_id_0AD3658A1088AF24) {
  if(!isDefined(self._id_86CBFCCFF303CF56))
    self._id_86CBFCCFF303CF56 = [];

  _id_2F5764B74AD4A6C6 = _id_0AD3658A1088AF24.player getentitynumber();

  if(!isDefined(self._id_86CBFCCFF303CF56[_id_2F5764B74AD4A6C6]) || self._id_86CBFCCFF303CF56[_id_2F5764B74AD4A6C6].timer < 0)
    _id_65F58F3C394DCF9A::_id_4231B99C9D0E1875(self._id_0566868292EE2A1B, [_id_0AD3658A1088AF24.player], "dmz_boss_bullfrog_combat", 1.5);

  self._id_86CBFCCFF303CF56[_id_2F5764B74AD4A6C6] = _id_0AD3658A1088AF24;
}

_id_C3E469874896E5ED() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    wait 1;

    if(!isDefined(self._id_86CBFCCFF303CF56)) {
      continue;
    }
    _id_68105A8315ED7941 = [];
    _id_A97DC011F346DF97 = [];
    currenttime = gettime();

    foreach(data in self._id_86CBFCCFF303CF56) {
      if(isDefined(data.player) && currenttime - data.timer < self._id_6DB8B3FABD1FD01F) {
        _id_68105A8315ED7941[data.player getentitynumber()] = data;
        continue;
      }

      if(isDefined(data.player))
        _id_A97DC011F346DF97[_id_A97DC011F346DF97.size] = data.player;
    }

    _id_65F58F3C394DCF9A::_id_30F2D27959CA7507(self._id_0566868292EE2A1B, _id_A97DC011F346DF97);
    self._id_86CBFCCFF303CF56 = _id_68105A8315ED7941;
  }
}