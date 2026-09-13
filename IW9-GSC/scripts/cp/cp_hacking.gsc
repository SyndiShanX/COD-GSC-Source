/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hacking.gsc
***********************************************/

hacking_init() {
  scripts\engine\utility::flag_init("hacking_table_parsed");
  level.hackingtabledata = [];

  if(isDefined(level.hackingfunc))
    level thread[[level.hackingfunc]]();
  else
    parsehackingtable();

  foreach(player in level.players)
  player thread hacking_lua_notify();

  level.hacking_lua_notify_func = ::hacking_lua_notify;
}

parsehackingtable(table) {
  if(!isDefined(table))
    table = "cp/cp_milbase_hacking_objective.csv";

  _id_CB89110314447B2F = 0;
  total_time = 0;
  _id_02DDCF2A0AFA6BDB = 0;

  for(;;) {
    index = tablelookupbyrow(table, _id_CB89110314447B2F, 0);

    if(index == "") {
      break;
    }

    _id_099EAF771A00A585 = spawnStruct();
    _id_099EAF771A00A585.ref = _id_CB89110314447B2F;
    _id_099EAF771A00A585.index = index;
    _id_099EAF771A00A585.time = int(tablelookupbyrow(table, _id_CB89110314447B2F, 1));
    _id_099EAF771A00A585.hackingspeed = int(tablelookupbyrow(table, _id_CB89110314447B2F, 2));
    _id_099EAF771A00A585.total = _id_099EAF771A00A585.time * _id_099EAF771A00A585.hackingspeed;
    _id_02DDCF2A0AFA6BDB = _id_02DDCF2A0AFA6BDB + _id_099EAF771A00A585.total;
    total_time = total_time + _id_099EAF771A00A585.time;
    _id_099EAF771A00A585.totalmeter = _id_02DDCF2A0AFA6BDB;
    _id_099EAF771A00A585.totaltime = total_time;
    level.hackingtabledata[_id_099EAF771A00A585.ref] = _id_099EAF771A00A585;
    _id_CB89110314447B2F++;
  }

  level.hackingtotaltime = total_time;
  level.hackingtotalmeter = _id_02DDCF2A0AFA6BDB;
  level.hackingtotalsteps = _id_CB89110314447B2F;
  level.objective_test = 0;
  scripts\engine\utility::flag_set("hacking_table_parsed");
}

hacking_lua_notify() {
  level endon("game_ended");
  self notify("hacking_lua_notify");
  self endon("hacking_lua_notify");
  player = self;

  for(;;) {
    player waittill("luinotifyserver", _id_EA3E3B2121E6713A, value);

    if(_id_EA3E3B2121E6713A == "cpu1_folder" || _id_EA3E3B2121E6713A == "cpu2_folder" || _id_EA3E3B2121E6713A == "cpu3_folder") {
      _id_B88FC3B4056E722A = computer_search_action(value);
      _id_07D20819E53D0EB3 = computer_result_omnvar(_id_EA3E3B2121E6713A);
      setomnvar(_id_07D20819E53D0EB3, _id_B88FC3B4056E722A);
      level notify("player_computer_searched", _id_B88FC3B4056E722A, _id_07D20819E53D0EB3, player);
      continue;
    }

    if(_id_EA3E3B2121E6713A == "cpu1_folder_startsearch" || _id_EA3E3B2121E6713A == "cpu2_folder_startsearch" || _id_EA3E3B2121E6713A == "cpu3_folder_startsearch") {
      _id_B88FC3B4056E722A = computer_search_action(value);
      _id_07D20819E53D0EB3 = computer_result_omnvar(_id_EA3E3B2121E6713A);
      level notify("player_computer_startsearch", _id_B88FC3B4056E722A, _id_07D20819E53D0EB3, player);
    }
  }
}

computer_search_action(value) {
  if(value == 4) {
    omnvar = 4;
    thread scripts\cp\cp_hud_message::showsplash("cp_intel_hack_found", undefined, self);
  } else if(value == 3) {
    omnvar = 3;
    level thread hacking_objective_time();
  } else if(value == 2)
    omnvar = 2;
  else
    omnvar = 1;

  return omnvar;
}

computer_result_omnvar(_id_EA3E3B2121E6713A) {
  _id_07D20819E53D0EB3 = "cpu1_search_result";

  switch (_id_EA3E3B2121E6713A) {
    case "cpu1_folder":
    case "cpu1_folder_startsearch":
      _id_07D20819E53D0EB3 = "cpu1_search_result";
      break;
    case "cpu2_folder_startsearch":
    case "cpu2_folder":
      _id_07D20819E53D0EB3 = "cpu2_search_result";
      break;
    case "cpu3_folder_startsearch":
    case "cpu3_folder":
      _id_07D20819E53D0EB3 = "cpu3_search_result";
      break;
  }

  return _id_07D20819E53D0EB3;
}

hacking_objective_time() {
  level endon("game_ended");
  level notify("cpu_hacking_start");
  _id_1D940AAD29A009B2 = level.hackingtotaltime;

  if(isDefined(level.hack_duration))
    _id_1D940AAD29A009B2 = level.hack_duration;

  setomnvar("cpu_hacking_progress", 0);
  starttime = gettime();
  _id_4469E496E26F43EA = 0;
  _id_B4C04337A6A90C84 = starttime;
  _id_7B5AC39513E1475E = starttime;
  _id_BAD213C38A81B916 = 0;
  hackingspeed = 1;
  _id_FDAA6E5B6E900B7F = 0;
  _id_2B1B3F1A13C63097 = 0;
  _id_7D3EE4FC53CE2F49 = 0;
  _id_8B0EFB5A41EF954D = undefined;

  if(isDefined(level.hackingtabledata[_id_BAD213C38A81B916].hackingspeed))
    hackingspeed = level.hackingtabledata[_id_BAD213C38A81B916].hackingspeed;

  _id_48F1DBF87DD99400 = (_id_1D940AAD29A009B2 - get_table_time(_id_BAD213C38A81B916)) / level.hackingtabledata[_id_BAD213C38A81B916].hackingspeed * 10;
  setomnvar("cpu_hacking_time", int(_id_48F1DBF87DD99400));
  setomnvar("cpu_hacking_speed", hackingspeed);
  _id_FDAA6E5B6E900B7F = get_section_time(_id_BAD213C38A81B916);

  for(;;) {
    _id_6B7BEE46F2C6DA28 = gettime();

    if(_id_BAD213C38A81B916 < level.hackingtabledata.size - 1) {
      if(!istrue(level.hacking_paused)) {
        if(istrue(_id_8B0EFB5A41EF954D)) {
          _id_8B0EFB5A41EF954D = undefined;
          hackingspeed = level.hackingtabledata[_id_BAD213C38A81B916].hackingspeed;
          _id_48F1DBF87DD99400 = (_id_1D940AAD29A009B2 - _id_FDAA6E5B6E900B7F) / level.hackingtabledata[_id_BAD213C38A81B916].hackingspeed * 10;
          setomnvar("cpu_hacking_speed", hackingspeed);
          setomnvar("cpu_hacking_time", int(_id_48F1DBF87DD99400));
        }

        if(_id_6B7BEE46F2C6DA28 > _id_7B5AC39513E1475E + get_section_time(_id_BAD213C38A81B916) * 1000) {
          _id_BAD213C38A81B916 = _id_BAD213C38A81B916 + 1;
          _id_7B5AC39513E1475E = _id_6B7BEE46F2C6DA28;
          hackingspeed = level.hackingtabledata[_id_BAD213C38A81B916].hackingspeed;
          _id_48F1DBF87DD99400 = (_id_1D940AAD29A009B2 - _id_FDAA6E5B6E900B7F) / level.hackingtabledata[_id_BAD213C38A81B916].hackingspeed * 10;
          _id_FDAA6E5B6E900B7F = _id_FDAA6E5B6E900B7F + get_section_time(_id_BAD213C38A81B916);
          setomnvar("cpu_hacking_speed", hackingspeed);
          setomnvar("cpu_hacking_time", int(_id_48F1DBF87DD99400));
          _id_431D1AEF97FDF6B5 = _id_6B7BEE46F2C6DA28 - _id_B4C04337A6A90C84;
          _id_189D09FC1A0F11F9 = level.hackingtabledata[_id_BAD213C38A81B916].total / level.hackingtotalmeter;
          _id_7D3EE4FC53CE2F49 = _id_189D09FC1A0F11F9 / (get_section_time(_id_BAD213C38A81B916) * 1000) * _id_431D1AEF97FDF6B5;
        }
      } else {
        _id_8B0EFB5A41EF954D = 1;

        if(_id_6B7BEE46F2C6DA28 > _id_7B5AC39513E1475E + 1500) {
          _id_7B5AC39513E1475E = _id_6B7BEE46F2C6DA28;

          if(hackingspeed >= 1) {
            hackingspeed = scripts\engine\math::lerp(hackingspeed, 0, 0.6);
            _id_48F1DBF87DD99400 = scripts\engine\math::lerp(_id_48F1DBF87DD99400, 800, 0.25);
          } else {
            hackingspeed = 0;
            _id_48F1DBF87DD99400 = -1;
          }

          setomnvar("cpu_hacking_speed", int(hackingspeed));
          setomnvar("cpu_hacking_time", int(_id_48F1DBF87DD99400));
        }
      }
    }

    if(!istrue(level.hacking_paused)) {
      modifier = 1;

      if(isDefined(level.hack_multiplier))
        modifier = level.hack_multiplier;

      _id_4469E496E26F43EA = _id_4469E496E26F43EA + _id_7D3EE4FC53CE2F49 * modifier;

      if(_id_4469E496E26F43EA > 1)
        _id_4469E496E26F43EA = 1;

      level.hack_progress = _id_4469E496E26F43EA;
    }

    setomnvar("cpu_hacking_progress", _id_4469E496E26F43EA);
    _id_B4C04337A6A90C84 = _id_6B7BEE46F2C6DA28;

    if(_id_4469E496E26F43EA == 1) {
      _id_4469E496E26F43EA = 0;
      _id_4469E496E26F43EA = 1;
      level notify("cpu_hacking_done");
      level thread give_xp_to_all_players_hack();
      level.hack_progress = -1;
      wait 1;
      setomnvar("cpu_hacking_progress", -1);
      setomnvar("cpu_hacking_signal", 0);
      break;
    }

    waitframe();
  }
}

give_xp_to_all_players_hack() {
  foreach(player in level.players)
  player thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_F4CD65EB4AA3FD61");
}

get_section_time(_id_BAD213C38A81B916) {
  totaltime = level.hackingtotaltime;
  modifier = undefined;

  if(isDefined(level.hack_duration))
    modifier = level.hack_duration / totaltime;

  _id_83EDCDDA354AC909 = level.hackingtabledata[_id_BAD213C38A81B916].time;

  if(isDefined(modifier))
    _id_83EDCDDA354AC909 = _id_83EDCDDA354AC909 * modifier;

  return _id_83EDCDDA354AC909;
}

get_table_time(_id_BAD213C38A81B916) {
  if(isDefined(level.hack_duration))
    return level.hack_duration;
  else
    return level.hackingtabledata[_id_BAD213C38A81B916].totaltime;
}