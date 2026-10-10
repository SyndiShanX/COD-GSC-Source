/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_hacking.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_hacking;
#using scripts\cp\cp_hud_message;
#using scripts\cp\points;
#using scripts\cp\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace cp_hacking;

function hacking_init() {
  flag_init("hacking_table_parsed");
  level.hackingtabledata = [];

  if(isDefined(level.hackingfunc)) {
    level thread[[level.hackingfunc]]();
  } else {
    parsehackingtable();
  }

  foreach(player in level.players) {
    player thread scripts\cp\cp_hacking::hacking_lua_notify();
  }

  level.hacking_lua_notify_func = &hacking_lua_notify;
}

function parsehackingtable(table) {
  if(!isDefined(table)) {
    table = "cp/cp_milbase_hacking_objective.csv";
  }

  row = 0;
  total_time = 0;
  total_meter = 0;

  while(true) {
    index = tablelookupbyrow(table, row, 0);

    if(index == "") {
      break;
    }

    var_99eaf771a00a585 = spawnStruct();
    var_99eaf771a00a585.ref = row;
    var_99eaf771a00a585.index = index;
    var_99eaf771a00a585.time = int(tablelookupbyrow(table, row, 1));
    var_99eaf771a00a585.hackingspeed = int(tablelookupbyrow(table, row, 2));
    var_99eaf771a00a585.total = var_99eaf771a00a585.time * var_99eaf771a00a585.hackingspeed;
    total_meter += var_99eaf771a00a585.total;
    total_time += var_99eaf771a00a585.time;
    var_99eaf771a00a585.totalmeter = total_meter;
    var_99eaf771a00a585.totaltime = total_time;
    level.hackingtabledata[var_99eaf771a00a585.ref] = var_99eaf771a00a585;
    row++;
  }

  level.hackingtotaltime = total_time;
  level.hackingtotalmeter = total_meter;
  level.hackingtotalsteps = row;
  level.objective_test = 0;
  flag_set("hacking_table_parsed");
}

function hacking_lua_notify() {
  level endon("game_ended");
  self notify("hacking_lua_notify");
  self endon("hacking_lua_notify");
  player = self;

  while(true) {
    player waittill("luinotifyserver", notification, value);

    if(notification == "cpu1_folder" || notification == "cpu2_folder" || notification == "cpu3_folder") {
      var_b88fc3b4056e722a = computer_search_action(value);
      var_7d20819e53d0eb3 = computer_result_omnvar(notification);
      setomnvar(var_7d20819e53d0eb3, var_b88fc3b4056e722a);
      level notify("player_computer_searched", var_b88fc3b4056e722a, var_7d20819e53d0eb3, player);
      continue;
    }

    if(notification == "cpu1_folder_startsearch" || notification == "cpu2_folder_startsearch" || notification == "cpu3_folder_startsearch") {
      var_b88fc3b4056e722a = computer_search_action(value);
      var_7d20819e53d0eb3 = computer_result_omnvar(notification);
      level notify("player_computer_startsearch", var_b88fc3b4056e722a, var_7d20819e53d0eb3, player);
    }
  }
}

function computer_search_action(value) {
  if(value == 4) {
    omnvar = 4;
    thread scripts\cp\cp_hud_message::showsplash("cp_intel_hack_found", undefined, self);
  } else if(value == 3) {
    omnvar = 3;
    level thread hacking_objective_time();
  } else if(value == 2) {
    omnvar = 2;
  } else {
    omnvar = 1;
  }

  return omnvar;
}

function computer_result_omnvar(notification) {
  var_7d20819e53d0eb3 = "cpu1_search_result";

  switch (notification) {
    case #"hash_53a389ec8f596dad":
    case #"hash_ae8e9ac0d2da63d6":
      var_7d20819e53d0eb3 = "cpu1_search_result";
      break;
    case #"hash_619888f79b9424a2":
    case #"hash_ec0973d0bb55da01":
      var_7d20819e53d0eb3 = "cpu2_search_result";
      break;
    case #"hash_40629b069b68b947":
    case #"hash_47b62f6ce1648048":
      var_7d20819e53d0eb3 = "cpu3_search_result";
      break;
  }

  return var_7d20819e53d0eb3;
}

function hacking_objective_time() {
  level endon("game_ended");
  level notify("cpu_hacking_start");
  meter_time = level.hackingtotaltime;

  if(isDefined(level.hack_duration)) {
    meter_time = level.hack_duration;
  }

  setomnvar("cpu_hacking_progress", 0);
  starttime = gettime();
  hacking_progress = 0;
  lasttime = starttime;
  var_7b5ac39513e1475e = starttime;
  var_bad213c38a81b916 = 0;
  hackingspeed = 1;
  var_fdaa6e5b6e900b7f = 0;
  scaledamount = 0;
  var_7d3ee4fc53ce2f49 = 0;
  var_8b0efb5a41ef954d = undefined;

  if(isDefined(level.hackingtabledata[var_bad213c38a81b916].hackingspeed)) {
    hackingspeed = level.hackingtabledata[var_bad213c38a81b916].hackingspeed;
  }

  displaytime = (meter_time - get_table_time(var_bad213c38a81b916)) / level.hackingtabledata[var_bad213c38a81b916].hackingspeed * 10;
  setomnvar("cpu_hacking_time", int(displaytime));
  setomnvar("cpu_hacking_speed", hackingspeed);
  var_fdaa6e5b6e900b7f = get_section_time(var_bad213c38a81b916);

  while(true) {
    curtime = gettime();

    if(var_bad213c38a81b916 < level.hackingtabledata.size - 1) {
      if(!istrue(level.hacking_paused)) {
        if(istrue(var_8b0efb5a41ef954d)) {
          var_8b0efb5a41ef954d = undefined;
          hackingspeed = level.hackingtabledata[var_bad213c38a81b916].hackingspeed;
          displaytime = (meter_time - var_fdaa6e5b6e900b7f) / level.hackingtabledata[var_bad213c38a81b916].hackingspeed * 10;
          setomnvar("cpu_hacking_speed", hackingspeed);
          setomnvar("cpu_hacking_time", int(displaytime));
        }

        if(curtime > var_7b5ac39513e1475e + get_section_time(var_bad213c38a81b916) * 1000) {
          var_bad213c38a81b916 += 1;
          var_7b5ac39513e1475e = curtime;
          hackingspeed = level.hackingtabledata[var_bad213c38a81b916].hackingspeed;
          displaytime = (meter_time - var_fdaa6e5b6e900b7f) / level.hackingtabledata[var_bad213c38a81b916].hackingspeed * 10;
          var_fdaa6e5b6e900b7f += get_section_time(var_bad213c38a81b916);
          setomnvar("cpu_hacking_speed", hackingspeed);
          setomnvar("cpu_hacking_time", int(displaytime));
          timeframe = curtime - lasttime;
          var_189d09fc1a0f11f9 = level.hackingtabledata[var_bad213c38a81b916].total / level.hackingtotalmeter;
          var_7d3ee4fc53ce2f49 = var_189d09fc1a0f11f9 / get_section_time(var_bad213c38a81b916) * 1000 * timeframe;
        }
      } else {
        var_8b0efb5a41ef954d = 1;

        if(curtime > var_7b5ac39513e1475e + 1500) {
          var_7b5ac39513e1475e = curtime;

          if(hackingspeed >= 1) {
            hackingspeed = math::lerp(hackingspeed, 0, 0.6);
            displaytime = math::lerp(displaytime, 800, 0.25);
          } else {
            hackingspeed = 0;
            displaytime = -1;
          }

          setomnvar("cpu_hacking_speed", int(hackingspeed));
          setomnvar("cpu_hacking_time", int(displaytime));
        }
      }
    }

    if(!istrue(level.hacking_paused)) {
      modifier = 1;

      if(isDefined(level.hack_multiplier)) {
        modifier = level.hack_multiplier;
      }

      hacking_progress += var_7d3ee4fc53ce2f49 * modifier;

      if(hacking_progress > 1) {
        hacking_progress = 1;
      }

      level.hack_progress = hacking_progress;
    }

    setomnvar("cpu_hacking_progress", hacking_progress);
    lasttime = curtime;

    if(hacking_progress == 1) {
      hacking_progress = 0;
      hacking_progress = 1;
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

function give_xp_to_all_players_hack() {
  foreach(player in level.players) {
    player thread scripts\cp\points::doscoreevent(#"capture");
  }
}

function get_section_time(var_bad213c38a81b916) {
  totaltime = level.hackingtotaltime;
  modifier = undefined;

  if(isDefined(level.hack_duration)) {
    modifier = level.hack_duration / totaltime;
  }

  var_83edcdda354ac909 = level.hackingtabledata[var_bad213c38a81b916].time;

  if(isDefined(modifier)) {
    var_83edcdda354ac909 *= modifier;
  }

  return var_83edcdda354ac909;
}

function get_table_time(var_bad213c38a81b916) {
  if(isDefined(level.hack_duration)) {
    return level.hack_duration;
  }

  return level.hackingtabledata[var_bad213c38a81b916].totaltime;
}