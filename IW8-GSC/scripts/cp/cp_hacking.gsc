/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hacking.gsc
***********************************************/

function hacking_init() {
  scripts\engine\utility::flag_init("hacking_table_parsed");
  level.hackingtabledata = [];

  if(isDefined(level.hackingfunc)) {
    level thread[[level.hackingfunc]]();
  } else {
    parsehackingtable();
  }

  foreach(var_1 in level.players) {
    thread hacking_lua_notify();
  }

  level.setobjectivelocations = &hacking_lua_notify;
}

function parsehackingtable(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "cp/cp_milbase_hacking_objective.csv";
  }

  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = tablelookupbyrow(var_0, var_1, 0);

    if(var_4 == "") {
      break;
    }

    var_5 = spawnStruct();
    var_5.ref = var_1;
    var_5.index = var_4;
    var_5.time = int(tablelookupbyrow(var_0, var_1, 1));
    var_5.hackingspeed = int(tablelookupbyrow(var_0, var_1, 2));
    var_5.total = var_5.time * var_5.hackingspeed;
    var_3 += var_5.total;
    var_2 += var_5.time;
    var_5.totalmeter = var_3;
    var_5.totaltime = var_2;
    level.hackingtabledata[var_5.ref] = var_5;
    var_1++;
  }

  level.hackingtotaltime = var_2;
  level.hackingtotalmeter = var_3;
  level.hackingtotalsteps = var_1;
  level.objective_test = 0;
  scripts\engine\utility::flag_set("hacking_table_parsed");
}

function hacking_lua_notify() {
  level endon("game_ended");
  self notify("hacking_lua_notify");
  self endon("hacking_lua_notify");
  var_0 = self;

  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "cpu1_folder" || var_1 == "cpu2_folder" || var_1 == "cpu3_folder") {
      var_3 = computer_search_action(var_2);
      var_4 = computer_result_omnvar(var_1);
      setomnvar(var_4, var_3);
      level notify("player_computer_searched", var_3, var_4, var_0);
      continue;
    }

    if(var_1 == "cpu1_folder_startsearch" || var_1 == "cpu2_folder_startsearch" || var_1 == "cpu3_folder_startsearch") {
      var_3 = computer_search_action(var_2);
      var_4 = computer_result_omnvar(var_1);
      level notify("player_computer_startsearch", var_3, var_4, var_0);
    }
  }
}

function computer_search_action(var_0) {
  if(var_0 == 4) {
    var_1 = 4;
    thread scripts\cp\cp_hud_message::showsplash("cp_intel_hack_found", undefined, self);
  } else if(var_1 == 3) {
    var_1 = 3;
    thread hacking_objective_time();
  } else if(var_1 == 2) {
    var_1 = 2;
  } else {
    var_1 = 1;
  }

  return var_1;
}

function computer_result_omnvar(var_0) {
  var_1 = "cpu1_search_result";

  switch (var_0) {
    case "cpu1_folder_startsearch":
    case "cpu1_folder":
      var_1 = "cpu1_search_result";
      break;
    case "cpu2_folder_startsearch":
    case "cpu2_folder":
      var_1 = "cpu2_search_result";
      break;
    case "cpu3_folder_startsearch":
    case "cpu3_folder":
      var_1 = "cpu3_search_result";
      break;
  }

  return var_1;
}

function hacking_objective_time() {
  level endon("game_ended");
  level notify("cpu_hacking_start");
  var_0 = level.hackingtotaltime;

  if(isDefined(level.hack_duration)) {
    var_0 = level.hack_duration;
  }

  setomnvar("cpu_hacking_progress", 0);
  var_1 = gettime();
  var_2 = 0;
  var_3 = var_1;
  var_4 = var_1;
  var_5 = 0;
  var_6 = 1;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = undefined;

  if(isDefined(level.hackingtabledata[var_5].hackingspeed)) {
    var_6 = level.hackingtabledata[var_5].hackingspeed;
  }

  var_11 = (var_0 - get_table_time(var_5)) / level.hackingtabledata[var_5].hackingspeed * 10;
  setomnvar("cpu_hacking_time", int(var_11));
  setomnvar("cpu_hacking_speed", var_6);
  var_7 = get_section_time(var_5);

  for(;;) {
    var_12 = gettime();

    if(var_5 < level.hackingtabledata.size - 1) {
      if(!istrue(level.hacking_paused)) {
        if(istrue(var_10)) {
          var_10 = undefined;
          var_6 = level.hackingtabledata[var_5].hackingspeed;
          var_11 = (var_0 - var_7) / level.hackingtabledata[var_5].hackingspeed * 10;
          setomnvar("cpu_hacking_speed", var_6);
          setomnvar("cpu_hacking_time", int(var_11));
        }

        if(var_12 > var_4 + get_section_time(var_5) * 1000) {
          var_5 += 1;
          var_4 = var_12;
          var_6 = level.hackingtabledata[var_5].hackingspeed;
          var_11 = (var_0 - var_7) / level.hackingtabledata[var_5].hackingspeed * 10;
          var_7 += get_section_time(var_5);
          setomnvar("cpu_hacking_speed", var_6);
          setomnvar("cpu_hacking_time", int(var_11));
          var_13 = var_12 - var_3;
          var_14 = level.hackingtabledata[var_5].total / level.hackingtotalmeter;
          var_9 = var_14 / get_section_time(var_5) * 1000 * var_13;
        }
      } else {
        var_10 = 1;

        if(var_12 > var_4 + 1500) {
          var_4 = var_12;

          if(var_6 >= 1) {
            var_6 = scripts\engine\math::lerp(var_6, 0, 0.6);
            var_11 = scripts\engine\math::lerp(var_11, 800, 0.25);
          } else {
            var_6 = 0;
            var_11 = -1;
          }

          setomnvar("cpu_hacking_speed", int(var_6));
          setomnvar("cpu_hacking_time", int(var_11));
        }
      }
    }

    if(!istrue(level.hacking_paused)) {
      var_15 = 1;

      if(isDefined(level.hack_multiplier)) {
        var_15 = level.hack_multiplier;
      }

      var_2 += var_9 * var_15;

      if(var_2 > 1) {
        var_2 = 1;
      }

      level.hack_progress = var_2;
    }

    setomnvar("cpu_hacking_progress", var_2);
    var_3 = var_12;

    if(var_2 == 1) {
      var_2 = 0;
      var_2 = 1;
      level notify("cpu_hacking_done");
      thread scriptable_door_is_double_door_pair();
      level.hack_progress = -1;
      wait 1;
      setomnvar("cpu_hacking_progress", -1);
      setomnvar("cpu_hacking_signal", 0);
      break;
    }

    waitframe();
  }
}

function scriptable_door_is_double_door_pair() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("capture");
  }
}

function get_section_time(var_0) {
  var_1 = level.hackingtotaltime;
  var_2 = undefined;

  if(isDefined(level.hack_duration)) {
    var_2 = level.hack_duration / var_1;
  }

  var_3 = level.hackingtabledata[var_0].time;

  if(isDefined(var_2)) {
    var_3 *= var_2;
  }

  return var_3;
}

function get_table_time(var_0) {
  if(isDefined(level.hack_duration)) {
    return level.hack_duration;
  }

  return level.hackingtabledata[var_0].totaltime;
}