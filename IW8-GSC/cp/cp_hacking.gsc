/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_hacking.gsc
***********************************************/

hacking_init() {
  scripts\engine\utility::flag_init("_encstr_86491559E95ED8CBC30286EB4ADB7110F950D3E58387E8");
  level.hackingtabledata = [];

  if(isDefined(level.hackingfunc))
    level thread[[level.hackingfunc]]();
  else
    parsehackingtable();

  foreach(var_1 in level.players)
  var_1 thread hacking_lua_notify();

  level.setobjectivelocations = ::hacking_lua_notify;
}

parsehackingtable(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_A5E224963AD6E71347A7406073918B1339A41F2E54EAB5B91F9713A877AB2343130F20A62AB3";

  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = tablelookupbyrow(var_0, var_1, 0);

    if(var_4 == "_encstr_B40101") {
      break;
    }

    var_5 = spawnStruct();
    var_5.ref = var_1;
    var_5.index = var_4;
    var_5.time = int(tablelookupbyrow(var_0, var_1, 1));
    var_5.hackingspeed = int(tablelookupbyrow(var_0, var_1, 2));
    var_5.total = var_5.time * var_5.hackingspeed;
    var_3 = var_3 + var_5.total;
    var_2 = var_2 + var_5.time;
    var_5.totalmeter = var_3;
    var_5.totaltime = var_2;
    level.hackingtabledata[var_5.ref] = var_5;
    var_1++;
  }

  level.hackingtotaltime = var_2;
  level.hackingtotalmeter = var_3;
  level.hackingtotalsteps = var_1;
  level.objective_test = 0;
  scripts\engine\utility::flag_set("_encstr_86491559E95ED8CBC30286EB4ADB7110F950D3E58387E8");
}

hacking_lua_notify() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_951D1328F978383943F721517F2A715DE0F0C860F8");
  self endon("_encstr_951D1328F978383943F721517F2A715DE0F0C860F8");
  var_0 = self;

  for(;;) {
    var_0 waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2);

    if(var_1 == "_encstr_915F0C08134B7BF6BB4719052583" || var_1 == "_encstr_85F00C2E82CBFD7EF637E058E71A" || var_1 == "_encstr_B40B0CE6498FEE27A3CF8455EBA2") {
      var_3 = computer_search_action(var_2);
      var_4 = computer_result_omnvar(var_1);
      setomnvar(var_4, var_3);
      level notify("_encstr_92201938B158E559E4EB36BDB683AEA35693EBDC9558938D342BC8", var_3, var_4, var_0);
      continue;
    }

    if(var_1 == "_encstr_887D188D38EAC4FA337B8D4656C9BECDA3164EA3B9950B3936D0" || var_1 == "_encstr_9116188D0EAE23BE99BDB191594EEB373A5827479B561639C61A" || var_1 == "_encstr_AAF418E738775299D635E04540E3A64B6D99389B5F97CA4548B3") {
      var_3 = computer_search_action(var_2);
      var_4 = computer_result_omnvar(var_1);
      level notify("_encstr_B6211C13600823633A012F303D470B24DD7250C2392036F4CF571FB2E96B", var_3, var_4, var_0);
    }
  }
}

computer_search_action(var_0) {
  if(var_0 == 4) {
    var_1 = 4;
    thread scripts\cp\cp_hud_message::showsplash("_encstr_B1271406C8C7901DDB9AB02162B63F686F4698853EF3", undefined, self);
  } else if(var_0 == 3) {
    var_1 = 3;
    level thread hacking_objective_time();
  } else if(var_0 == 2)
    var_1 = 2;
  else
    var_1 = 1;

  return var_1;
}

computer_result_omnvar(var_0) {
  var_1 = "_encstr_A96213C638AB13AFCDB216398D34FAC9B26EBAD8A3";

  switch (var_0) {
    case "_encstr_887D188D38EAC4FA337B8D4656C9BECDA3164EA3B9950B3936D0":
    case "_encstr_915F0C08134B7BF6BB4719052583":
      var_1 = "_encstr_A96213C638AB13AFCDB216398D34FAC9B26EBAD8A3";
      break;
    case "_encstr_9116188D0EAE23BE99BDB191594EEB373A5827479B561639C61A":
    case "_encstr_85F00C2E82CBFD7EF637E058E71A":
      var_1 = "_encstr_B4A1137ED29BAD2EB32FB8382FF0666522BAED712B";
      break;
    case "_encstr_AAF418E738775299D635E04540E3A64B6D99389B5F97CA4548B3":
    case "_encstr_B40B0CE6498FEE27A3CF8455EBA2":
      var_1 = "_encstr_81F513EF496BBBD7DA979FCADF5911F2A593431860";
      break;
  }

  return var_1;
}

hacking_objective_time() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_BD6C127A43F52F4C50A70319A5B859579D99E393");
  var_0 = level.hackingtotaltime;

  if(isDefined(level.hack_duration))
    var_0 = level.hack_duration;

  setomnvar("_encstr_8249154F210549D0B8C17CC458B0DF735E87D7F3E3AE33", 0);
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

  if(isDefined(level.hackingtabledata[var_5].hackingspeed))
    var_6 = level.hackingtabledata[var_5].hackingspeed;

  var_11 = (var_0 - get_table_time(var_5)) / level.hackingtabledata[var_5].hackingspeed * 10;
  setomnvar("_encstr_8CB111EE10B78EB9364220C86A4F1F231FA565", int(var_11));
  setomnvar("_encstr_9B8B12A60A43AF0D698FA0B853873E2FBBF72DBD", var_6);
  var_7 = get_section_time(var_5);

  for(;;) {
    var_12 = gettime();

    if(var_5 < level.hackingtabledata.size - 1) {
      if(!istrue(level.hacking_paused)) {
        if(istrue(var_10)) {
          var_10 = undefined;
          var_6 = level.hackingtabledata[var_5].hackingspeed;
          var_11 = (var_0 - var_7) / level.hackingtabledata[var_5].hackingspeed * 10;
          setomnvar("_encstr_9B8B12A60A43AF0D698FA0B853873E2FBBF72DBD", var_6);
          setomnvar("_encstr_8CB111EE10B78EB9364220C86A4F1F231FA565", int(var_11));
        }

        if(var_12 > var_4 + get_section_time(var_5) * 1000) {
          var_5 = var_5 + 1;
          var_4 = var_12;
          var_6 = level.hackingtabledata[var_5].hackingspeed;
          var_11 = (var_0 - var_7) / level.hackingtabledata[var_5].hackingspeed * 10;
          var_7 = var_7 + get_section_time(var_5);
          setomnvar("_encstr_9B8B12A60A43AF0D698FA0B853873E2FBBF72DBD", var_6);
          setomnvar("_encstr_8CB111EE10B78EB9364220C86A4F1F231FA565", int(var_11));
          var_13 = var_12 - var_3;
          var_14 = level.hackingtabledata[var_5].total / level.hackingtotalmeter;
          var_9 = var_14 / (get_section_time(var_5) * 1000) * var_13;
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

          setomnvar("_encstr_9B8B12A60A43AF0D698FA0B853873E2FBBF72DBD", int(var_6));
          setomnvar("_encstr_8CB111EE10B78EB9364220C86A4F1F231FA565", int(var_11));
        }
      }
    }

    if(!istrue(level.hacking_paused)) {
      var_15 = 1;

      if(isDefined(level.hack_multiplier))
        var_15 = level.hack_multiplier;

      var_2 = var_2 + var_9 * var_15;

      if(var_2 > 1)
        var_2 = 1;

      level.hack_progress = var_2;
    }

    setomnvar("_encstr_8249154F210549D0B8C17CC458B0DF735E87D7F3E3AE33", var_2);
    var_3 = var_12;

    if(var_2 == 1) {
      var_2 = 0;
      var_2 = 1;
      level notify("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
      level thread scriptable_door_is_double_door_pair();
      level.hack_progress = -1;
      wait 1;
      setomnvar("_encstr_8249154F210549D0B8C17CC458B0DF735E87D7F3E3AE33", -1);
      setomnvar("_encstr_96CD138D83BAD743858DB6B4E6CED79B969DE6851B", 0);
      break;
    }

    waitframe();
  }
}

scriptable_door_is_double_door_pair() {
  foreach(var_1 in level.players)
  var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_95EB0866891B23FB85B3");
}

get_section_time(var_0) {
  var_1 = level.hackingtotaltime;
  var_2 = undefined;

  if(isDefined(level.hack_duration))
    var_2 = level.hack_duration / var_1;

  var_3 = level.hackingtabledata[var_0].time;

  if(isDefined(var_2))
    var_3 = var_3 * var_2;

  return var_3;
}

get_table_time(var_0) {
  if(isDefined(level.hack_duration))
    return level.hack_duration;
  else
    return level.hackingtabledata[var_0].totaltime;
}