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

  foreach(var1 in level.players) {
    thread hacking_lua_notify();
  }

  level.setobjectivelocations = &hacking_lua_notify;
}

function parsehackingtable(var0) {
  if(!isDefined(var0)) {
    var0 = "cp/cp_milbase_hacking_objective.csv";
  }

  var1 = 0;
  var2 = 0;
  var3 = 0;

  for(;;) {
    var4 = tablelookupbyrow(var0, var1, 0);

    if(var4 == "") {
      break;
    }

    var5 = spawnStruct();
    var5.ref = var1;
    var5.index = var4;
    var5.time = int(tablelookupbyrow(var0, var1, 1));
    var5.hackingspeed = int(tablelookupbyrow(var0, var1, 2));
    var5.total = var5.time * var5.hackingspeed;
    var3 += var5.total;
    var2 += var5.time;
    var5.totalmeter = var3;
    var5.totaltime = var2;
    level.hackingtabledata[var5.ref] = var5;
    var1++;
  }

  level.hackingtotaltime = var2;
  level.hackingtotalmeter = var3;
  level.hackingtotalsteps = var1;
  level.objective_test = 0;
  scripts\engine\utility::flag_set("hacking_table_parsed");
}

function hacking_lua_notify() {
  level endon("game_ended");
  self notify("hacking_lua_notify");
  self endon("hacking_lua_notify");
  var0 = self;

  for(;;) {
    var0 waittill("luinotifyserver", var1, var2);

    if(var1 == "cpu1_folder" || var1 == "cpu2_folder" || var1 == "cpu3_folder") {
      var3 = computer_search_action(var2);
      var4 = computer_result_omnvar(var1);
      setomnvar(var4, var3);
      level notify("player_computer_searched", var3, var4, var0);
      continue;
    }

    if(var1 == "cpu1_folder_startsearch" || var1 == "cpu2_folder_startsearch" || var1 == "cpu3_folder_startsearch") {
      var3 = computer_search_action(var2);
      var4 = computer_result_omnvar(var1);
      level notify("player_computer_startsearch", var3, var4, var0);
    }
  }
}

function computer_search_action(var0) {
  if(var0 == 4) {
    var1 = 4;
    thread scripts\cp\cp_hud_message::showsplash("cp_intel_hack_found", undefined, self);
  } else if(var1 == 3) {
    var1 = 3;
    thread hacking_objective_time();
  } else if(var1 == 2) {
    var1 = 2;
  } else {
    var1 = 1;
  }

  return var1;
}

function computer_result_omnvar(var0) {
  var1 = "cpu1_search_result";

  switch (var0) {
    case "cpu1_folder_startsearch":
    case "cpu1_folder":
      var1 = "cpu1_search_result";
      break;
    case "cpu2_folder_startsearch":
    case "cpu2_folder":
      var1 = "cpu2_search_result";
      break;
    case "cpu3_folder_startsearch":
    case "cpu3_folder":
      var1 = "cpu3_search_result";
      break;
  }

  return var1;
}

function hacking_objective_time() {
  level endon("game_ended");
  level notify("cpu_hacking_start");
  var0 = level.hackingtotaltime;

  if(isDefined(level.hack_duration)) {
    var0 = level.hack_duration;
  }

  setomnvar("cpu_hacking_progress", 0);
  var1 = gettime();
  var2 = 0;
  var3 = var1;
  var4 = var1;
  var5 = 0;
  var6 = 1;
  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = undefined;

  if(isDefined(level.hackingtabledata[var5].hackingspeed)) {
    var6 = level.hackingtabledata[var5].hackingspeed;
  }

  var11 = (var0 - get_table_time(var5)) / level.hackingtabledata[var5].hackingspeed * 10;
  setomnvar("cpu_hacking_time", int(var11));
  setomnvar("cpu_hacking_speed", var6);
  var7 = get_section_time(var5);

  for(;;) {
    var12 = gettime();

    if(var5 < level.hackingtabledata.size - 1) {
      if(!istrue(level.hacking_paused)) {
        if(istrue(var10)) {
          var10 = undefined;
          var6 = level.hackingtabledata[var5].hackingspeed;
          var11 = (var0 - var7) / level.hackingtabledata[var5].hackingspeed * 10;
          setomnvar("cpu_hacking_speed", var6);
          setomnvar("cpu_hacking_time", int(var11));
        }

        if(var12 > var4 + get_section_time(var5) * 1000) {
          var5 += 1;
          var4 = var12;
          var6 = level.hackingtabledata[var5].hackingspeed;
          var11 = (var0 - var7) / level.hackingtabledata[var5].hackingspeed * 10;
          var7 += get_section_time(var5);
          setomnvar("cpu_hacking_speed", var6);
          setomnvar("cpu_hacking_time", int(var11));
          var13 = var12 - var3;
          var14 = level.hackingtabledata[var5].total / level.hackingtotalmeter;
          var9 = var14 / get_section_time(var5) * 1000 * var13;
        }
      } else {
        var10 = 1;

        if(var12 > var4 + 1500) {
          var4 = var12;

          if(var6 >= 1) {
            var6 = scripts\engine\math::lerp(var6, 0, 0.6);
            var11 = scripts\engine\math::lerp(var11, 800, 0.25);
          } else {
            var6 = 0;
            var11 = -1;
          }

          setomnvar("cpu_hacking_speed", int(var6));
          setomnvar("cpu_hacking_time", int(var11));
        }
      }
    }

    if(!istrue(level.hacking_paused)) {
      var15 = 1;

      if(isDefined(level.hack_multiplier)) {
        var15 = level.hack_multiplier;
      }

      var2 += var9 * var15;

      if(var2 > 1) {
        var2 = 1;
      }

      level.hack_progress = var2;
    }

    setomnvar("cpu_hacking_progress", var2);
    var3 = var12;

    if(var2 == 1) {
      var2 = 0;
      var2 = 1;
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
  foreach(var1 in level.players) {
    var1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("capture");
  }
}

function get_section_time(var0) {
  var1 = level.hackingtotaltime;
  var2 = undefined;

  if(isDefined(level.hack_duration)) {
    var2 = level.hack_duration / var1;
  }

  var3 = level.hackingtabledata[var0].time;

  if(isDefined(var2)) {
    var3 *= var2;
  }

  return var3;
}

function get_table_time(var0) {
  if(isDefined(level.hack_duration)) {
    return level.hack_duration;
  }

  return level.hackingtabledata[var0].totaltime;
}