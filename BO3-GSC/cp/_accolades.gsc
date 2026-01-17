/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_accolades.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\_collectibles;
#using scripts\cp\_decorations;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_save;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\table_shared;
#using scripts\shared\util_shared;
#namespace accolades;

function autoexec __init__sytem__() {
  system::register("accolades", &__init__, &__main__, undefined);
}

function __init__() {
  if(function_214e644a()) {
    return;
  }
  var_c02de660 = [];
  var_c02de660[var_c02de660.size] = "AQUIFER";
  var_c02de660[var_c02de660.size] = "BIODOMES";
  var_c02de660[var_c02de660.size] = "BLACKSTATION";
  var_c02de660[var_c02de660.size] = "INFECTION";
  var_c02de660[var_c02de660.size] = "LOTUS";
  var_c02de660[var_c02de660.size] = "NEWWORLD";
  var_c02de660[var_c02de660.size] = "PROLOGUE";
  var_c02de660[var_c02de660.size] = "RAMSES";
  var_c02de660[var_c02de660.size] = "SGEN";
  var_c02de660[var_c02de660.size] = "VENGEANCE";
  var_c02de660[var_c02de660.size] = "ZURICH";
  level.accolades = [];
  level.var_deb20b04 = getrootmapname();
  level.mission_name = getmissionname();
  if(isDefined(level.mission_name) && missionhasaccolades(level.var_deb20b04)) {
    for(i = 0; i < var_c02de660.size; i++) {
      if(var_c02de660[i] == toupper(level.mission_name)) {
        level.mission_index = i + 1;
        break;
      }
    }
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&on_player_disconnect);
    level.var_f8718de3 = ("MISSION_" + toupper(level.mission_name)) + "_";
    level.var_d8f32e57 = int(tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, level.var_f8718de3 + "UNTOUCHED", 0));
    register(level.var_f8718de3 + "UNTOUCHED", undefined, 1);
    register(level.var_f8718de3 + "SCORE");
    register(level.var_f8718de3 + "COLLECTIBLE");
    level thread function_4c436dfe();
  }
}

function __main__() {
  if(function_214e644a()) {
    return;
  }
}

function function_4f9d8dec(str_accolade) {
  accolades = self savegame::get_player_data("accolades");
  if(isDefined(accolades)) {
    return accolades[str_accolade];
  }
}

function function_50f58bd0(str_accolade, var_a3dc571a) {
  var_83736781 = self savegame::get_player_data("accolades");
  var_83736781[str_accolade] = var_a3dc571a;
  self savegame::set_player_data("accolades", var_83736781);
}

function function_464d3607(var_36b04a4a, is_state) {
  if(isDefined(is_state) && is_state) {
    return self getdstat("PlayerStatsByMap", level.var_deb20b04, "accolades", var_36b04a4a, "state");
  }
  return self getdstat("PlayerStatsByMap", level.var_deb20b04, "accolades", var_36b04a4a, "value");
}

function function_ce95384b(var_36b04a4a, is_state, value, var_b3982c20) {
  if(isDefined(is_state) && is_state) {
    self function_e2d5f2db(var_36b04a4a, value);
    self setdstat("PlayerStatsByMap", level.var_deb20b04, "accolades", var_36b04a4a, "state", value);
  } else {
    if(isDefined(var_b3982c20) && var_b3982c20) {
      self function_86373aa7(var_36b04a4a, value);
    }
    self setdstat("PlayerStatsByMap", level.var_deb20b04, "accolades", var_36b04a4a, "value", value);
  }
  self.var_eb7d74bb = 1;
}

function function_520227e6(var_36b04a4a) {
  return self function_464d3607(var_36b04a4a, 0);
}

function function_de8b9e62(var_36b04a4a, value, var_b3982c20) {
  self function_ce95384b(var_36b04a4a, 0, value, var_b3982c20);
}

function function_3bbb909b(var_36b04a4a, value, var_b3982c20) {
  statvalue = self function_520227e6(var_36b04a4a);
  self function_de8b9e62(var_36b04a4a, statvalue + value, var_b3982c20);
  return statvalue + value;
}

function function_3a7fd23a(var_36b04a4a) {
  return self function_464d3607(var_36b04a4a, 1);
}

function function_8992915e(var_36b04a4a, state) {
  self function_ce95384b(var_36b04a4a, 1, state);
}

function function_86373aa7(var_36b04a4a, value) {
  self setnoncheckpointdata(("accolades" + var_36b04a4a) + "value", value);
}

function function_e2d5f2db(var_36b04a4a, state) {
  self setnoncheckpointdata(("accolades" + var_36b04a4a) + "state", state);
}

function function_4f34644b(var_36b04a4a) {
  return self getnoncheckpointdata(("accolades" + var_36b04a4a) + "value");
}

function function_31381fa7(var_36b04a4a) {
  return self getnoncheckpointdata(("accolades" + var_36b04a4a) + "state");
}

function function_cc6b3591(var_36b04a4a) {
  self clearnoncheckpointdata(("accolades" + var_36b04a4a) + "state");
  self clearnoncheckpointdata(("accolades" + var_36b04a4a) + "value");
}

function function_77b3b4d1() {
  if(self == level) {
    foreach(player in level.players) {
      player function_77b3b4d1();
    }
  } else {
    accolades = self savegame::get_player_data("accolades");
    if(!isDefined(accolades)) {
      return;
    }
    foreach(str_accolade, s_accolade in level.accolades) {
      accolade = accolades[str_accolade];
      if(accolade.current_value > self function_520227e6(accolade.index)) {
        self function_de8b9e62(accolade.index, accolade.current_value, 1);
      }
    }
  }
}

function private function_9ba543a3(str_accolade, var_eb856299) {
  var_51ccabeb = tablelookuprownum("gamedata/stats/cp/statsmilestones1.csv", 4, str_accolade);
  var_35cb50ff = tablelookupcolumnforrow("gamedata/stats/cp/statsmilestones1.csv", var_51ccabeb, 2);
  return int(var_35cb50ff) <= var_eb856299;
}

function private function_214e644a() {
  return isDefined(level.var_837b3a61) && level.var_837b3a61 || sessionmodeiscampaignzombiesgame();
}

function function_3c63ee8() {
  return !ismapsublevel() && (getdvarstring("skipto") == "" || getdvarstring("skipto") == "level_start");
}

function function_994b29af(str_accolade) {
  var_ea75dd36 = tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, toupper(str_accolade), 7);
  return var_ea75dd36 != "";
}

function function_7efd1da3(str_accolade) {
  var_a33c5066 = tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, toupper(str_accolade), 6);
  if(var_a33c5066 != "") {
    return int(var_a33c5066);
  }
  return 0;
}

function function_77abfac7(num_tokens = 1) {
  var_6dff2ed7 = self getdstat("unlocks", 0);
  var_6dff2ed7 = var_6dff2ed7 + num_tokens;
  self setdstat("unlocks", 0, var_6dff2ed7);
}

function function_92050191(var_36b04a4a, var_eb856299) {
  var_9d479b7 = self getdstat("PlayerStatsByMap", getrootmapname(), "accolades", var_36b04a4a, "highestValue");
  if(var_eb856299 > var_9d479b7) {
    self setdstat("PlayerStatsByMap", getrootmapname(), "accolades", var_36b04a4a, "highestValue", var_eb856299);
  }
}

function function_feabf577(str_accolade) {
  var_8dab6968 = tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, toupper(str_accolade), 2);
  if(var_8dab6968 == "") {
    return 0;
  }
  return int(var_8dab6968);
}

function function_42acdca5(str_accolade) {
  accolade = self function_4f9d8dec(str_accolade);
  if(function_9ba543a3(str_accolade, accolade.current_value)) {
    return;
  }
  self function_cc6b3591(accolade.index);
  self function_8992915e(accolade.index, 0);
  if(isDefined(accolade.var_ab795acb) && accolade.var_ab795acb) {
    accolade.current_value = 1;
  } else {
    accolade.current_value = 0;
  }
  self function_de8b9e62(accolade.index, accolade.current_value, 0);
}

function register(str_accolade, str_increment_notify, var_ab795acb) {
  if(function_214e644a()) {
    return;
  }
  if(!isDefined(level.accolades[str_accolade])) {
    var_d8f32e57 = int(tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, str_accolade, 0));
    level.accolades[str_accolade] = spawnStruct();
    level.accolades[str_accolade].increment_notify = str_increment_notify;
    level.accolades[str_accolade].index = var_d8f32e57 - level.var_d8f32e57;
    level.accolades[str_accolade].var_ab795acb = isDefined(var_ab795acb) && var_ab795acb;
  }
}

function increment(str_accolade, n_val = 1, var_50f65478) {
  if(function_214e644a()) {
    return;
  }
  if(self == level) {
    foreach(player in level.players) {
      player increment(str_accolade);
    }
  } else {
    accolade = self function_4f9d8dec(str_accolade);
    if(!isDefined(accolade)) {
      return;
    }
    if(function_3a7fd23a(accolade.index) != 0) {
      if(str_accolade == (level.var_f8718de3 + "SCORE")) {
        accolade.current_value = accolade.current_value + n_val;
        self function_92050191(accolade.index, accolade.current_value);
      }
      return;
    }
    if(!(isDefined(accolade.var_ab795acb) && accolade.var_ab795acb)) {
      accolade.current_value = accolade.current_value + n_val;
    } else {
      accolade.current_value = 0;
    }
    if(!(isDefined(var_50f65478) && var_50f65478)) {
      var_cacb0169 = tablelookupistring("", 4, str_accolade, 5);
      iprintln(var_cacb0169);
    }
    self.var_eb7d74bb = 1;
    self function_de8b9e62(accolade.index, accolade.current_value, 0);
    self function_92050191(accolade.index, accolade.current_value);
    if(!function_9ba543a3(str_accolade, accolade.current_value) || accolade.index == 1) {
      return;
    }
    self function_de8b9e62(accolade.index, accolade.current_value, 1);
    self function_8992915e(accolade.index, 1);
    var_fdcc76d1 = tablelookupistring("gamedata/stats/cp/statsmilestones1.csv", 4, str_accolade, 8);
    if(isDefined(var_fdcc76d1)) {
      util::show_event_message(self, var_fdcc76d1);
      self playlocalsound("uin_accolade");
    }
    self thread challenges::function_96ed590f("career_accolades");
    accolade.is_completed = 1;
    self decorations::function_e72fc18();
    if(isDefined(accolade.var_9ebe4012) && accolade.var_9ebe4012) {
      self thread challenges::function_96ed590f("career_tokens");
      self giveunlocktoken(1);
    }
    self addrankxpvalue("award_accolade", accolade.var_2376b52b);
    self decorations::function_59f1fa79();
    uploadstats(self);
  }
}

function private _increment_by_notify(str_accolade, str_notify) {
  self endon("hash_115de864");
  self endon("disconnect");
  if(!isDefined(self.var_4fbad7c0)) {
    self.var_4fbad7c0 = [];
  }
  if(isDefined(self.var_4fbad7c0[str_notify]) && self.var_4fbad7c0[str_notify]) {
    return;
  }
  self.var_4fbad7c0[str_notify] = 1;
  while(true) {
    self waittill(str_notify, n_val);
    self increment(str_accolade, n_val);
  }
}

function private function_115de864() {
  self notify("hash_115de864");
  accolades = [];
  self savegame::set_player_data("accolades", accolades);
  foreach(str_accolade, s_accolade in level.accolades) {
    var_aa6073 = spawnStruct();
    var_aa6073.index = s_accolade.index;
    var_aa6073.var_ab795acb = s_accolade.var_ab795acb;
    var_cba20a96 = self function_3a7fd23a(s_accolade.index);
    self function_e2d5f2db(s_accolade.index, var_cba20a96);
    if(var_cba20a96 != 0) {
      var_aa6073.current_value = function_520227e6(s_accolade.index);
      var_aa6073.is_completed = 1;
      self function_50f58bd0(str_accolade, var_aa6073);
      self function_86373aa7(s_accolade.index, var_aa6073.current_value);
      continue;
    }
    if(isDefined(s_accolade.increment_notify) && (!(isDefined(strendswith(str_accolade, "COLLECTIBLE")) && strendswith(str_accolade, "COLLECTIBLE")))) {
      self thread _increment_by_notify(str_accolade, s_accolade.increment_notify);
    }
    if(s_accolade.var_ab795acb) {
      var_aa6073.current_value = 1;
    } else {
      var_aa6073.current_value = 0;
    }
    if(isDefined(strendswith(str_accolade, "COLLECTIBLE")) && strendswith(str_accolade, "COLLECTIBLE")) {
      var_aa6073.current_value = self getdstat("PlayerStatsByMap", getrootmapname(), "accolades", s_accolade.index, "highestValue");
    }
    self function_de8b9e62(s_accolade.index, var_aa6073.current_value, 1);
    if(function_994b29af(str_accolade)) {
      var_aa6073.var_9ebe4012 = 1;
    }
    var_aa6073.var_2376b52b = function_7efd1da3(str_accolade);
    self function_50f58bd0(str_accolade, var_aa6073);
  }
  self.var_eb7d74bb = 1;
  self decorations::function_e72fc18();
  self savegame::set_player_data("last_mission", getmissionname());
}

function function_673a5138() {
  self endon("disconnect");
  self endon("death");
  var_88d3591a = self function_4f9d8dec(level.var_f8718de3 + "COLLECTIBLE");
  while(true) {
    self waittill("hash_eb5cc7bc");
    if(self function_3a7fd23a(var_88d3591a.index) != 0) {
      continue;
    }
    self function_3bbb909b(var_88d3591a.index, 1, 1);
    self increment(level.var_f8718de3 + "COLLECTIBLE");
  }
}

function function_d2380b2() {
  self endon("disconnect");
  accolade = self function_4f9d8dec(level.var_f8718de3 + "UNTOUCHED");
  if(accolade.current_value == 0) {
    return;
  }
  self util::waittill_any("death", "increment_untouched");
  self increment(level.var_f8718de3 + "UNTOUCHED");
  self function_de8b9e62(accolade.index, accolade.current_value, 1);
}

function function_39f05ec1() {
  self endon("disconnect");
  self endon("death");
  last_score = self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "SCORE");
  var_7b12b16 = self function_4f9d8dec(level.var_f8718de3 + "SCORE");
  var_6962bddd = self function_3a7fd23a(var_7b12b16.index);
  if(isDefined(var_6962bddd) && var_6962bddd) {
    return;
  }
  while(true) {
    self waittill("score_event");
    last_score = var_7b12b16.current_value;
    new_score = self.pers["score"];
    scorediff = new_score - last_score;
    self increment(level.var_f8718de3 + "SCORE", scorediff, 1);
  }
}

function on_player_connect() {
  if(function_214e644a()) {
    return;
  }
  self function_cf1b719a();
  if(!ismapsublevel() && level.skipto_point == level.default_skipto) {
    self function_115de864();
  }
  if(isDefined(level.accolades)) {
    self.var_eb7d74bb = 1;
    self function_2d7075c8();
    self thread function_8082e9f0();
  }
}

function on_player_spawned() {
  if(self savegame::get_player_data("last_mission") === getmissionname()) {
    foreach(str_accolade, s_accolade in level.accolades) {
      if(isDefined(s_accolade.increment_notify)) {
        self thread _increment_by_notify(str_accolade, s_accolade.increment_notify);
      }
    }
  } else {
    self function_115de864();
  }
  self thread function_3b92459f();
  self thread function_d2380b2();
  self thread function_673a5138();
  self thread function_39f05ec1();
}

function function_cf1b719a() {
  if(!isDefined(level.accolades)) {
    return;
  }
  foreach(s_accolade in level.accolades) {
    self function_cc6b3591(s_accolade.index);
  }
}

function on_player_disconnect() {
  foreach(s_accolade in level.accolades) {
    if(self function_3a7fd23a(s_accolade.index) == 1) {
      self function_8992915e(s_accolade.index, 2);
    }
  }
  self savegame::set_player_data("accolades", undefined);
  self savegame::set_player_data("last_mission", "");
}

function function_8082e9f0() {
  self endon("disconnect");
  while(true) {
    cmd = getdvarstring("");
    if(isDefined(cmd) && cmd != "") {
      self function_a4b8b7d1(int(cmd));
    }
    if(cmd != "") {
      setdvar("", "");
    }
    if(self.var_eb7d74bb == 1 && isDefined(self.var_ab872594)) {
      function_7aaf1e5d();
    }
    if(getdvarint("") > 0) {
      self function_1ea616fe();
    } else {
      self notify("hash_30b79005");
    }
    wait(1);
  }
}

function function_7b64a1e0() {
  self endon("disconnect");
  self waittill("hash_30b79005");
  function_7aaf1e5d();
}

function function_7aaf1e5d() {
  if(isDefined(self.var_ab872594)) {
    foreach(var_ab872594 in self.var_ab872594) {
      var_ab872594 destroy();
    }
    foreach(var_5922e3b8 in self.var_5922e3b8) {
      var_5922e3b8 destroy();
    }
    foreach(var_eda8fa83 in self.var_87b86b14) {
      var_eda8fa83 destroy();
    }
    self.var_ab872594 = undefined;
    self.var_5922e3b8 = undefined;
    self.var_87b86b14 = undefined;
  }
}

function function_1ea616fe() {
  x = 0;
  y = 100;
  var_c06a516a = "";
  var_1c70e53e = "";
  var_16bed2ea = "";
  if(!isDefined(level.accolades) || isDefined(self.var_ab872594) || !isDefined(self savegame::get_player_data(""))) {
    return;
  }
  self.var_ab872594 = [];
  self.var_5922e3b8 = [];
  self.var_87b86b14 = [];
  var_c74eaab3 = 0;
  var_ab872594 = newclienthudelem(self);
  var_5922e3b8 = newclienthudelem(self);
  var_87b86b14 = newclienthudelem(self);
  foreach(str_accolade, s_accolade in level.accolades) {
    if((var_c74eaab3 % 7) == 6) {
      var_ab872594.x = x + 2;
      var_ab872594.y = y + 2;
      var_ab872594.alignx = "";
      var_ab872594.aligny = "";
      var_ab872594 settext(var_c06a516a);
      var_ab872594.hidewheninmenu = 1;
      var_ab872594.font = "";
      var_ab872594.foreground = 1;
      var_5922e3b8.x = x + 120;
      var_5922e3b8.y = y + 2;
      var_5922e3b8.alignx = "";
      var_5922e3b8.aligny = "";
      var_5922e3b8 settext(var_1c70e53e);
      var_5922e3b8.hidewheninmenu = 1;
      var_5922e3b8.font = "";
      var_5922e3b8.foreground = 1;
      var_87b86b14.x = x + 180;
      var_87b86b14.y = y + 2;
      var_87b86b14.alignx = "";
      var_87b86b14.aligny = "";
      var_87b86b14 settext(var_16bed2ea);
      var_87b86b14.hidewheninmenu = 1;
      var_87b86b14.font = "";
      var_87b86b14.foreground = 1;
      self.var_ab872594[self.var_ab872594.size] = var_ab872594;
      self.var_5922e3b8[self.var_5922e3b8.size] = var_5922e3b8;
      self.var_87b86b14[self.var_87b86b14.size] = var_87b86b14;
      var_ab872594 = newclienthudelem(self);
      var_5922e3b8 = newclienthudelem(self);
      var_87b86b14 = newclienthudelem(self);
      y = y + 73;
      var_c74eaab3 = 1;
      var_c06a516a = str_accolade + "";
      var_1c70e53e = self function_4f9d8dec(str_accolade).current_value;
      if(isDefined(self function_4f9d8dec(str_accolade).is_completed) && self function_4f9d8dec(str_accolade).is_completed) {
        var_1c70e53e = var_1c70e53e + "";
      }
      var_1c70e53e = var_1c70e53e + "";
      var_16bed2ea = self function_520227e6(s_accolade.index) + "";
      continue;
    }
    var_c06a516a = var_c06a516a + (str_accolade + "");
    var_1c70e53e = var_1c70e53e + self function_4f9d8dec(str_accolade).current_value;
    if(isDefined(self function_4f9d8dec(str_accolade).is_completed) && self function_4f9d8dec(str_accolade).is_completed) {
      var_1c70e53e = var_1c70e53e + "";
    }
    var_1c70e53e = var_1c70e53e + "";
    var_16bed2ea = var_16bed2ea + (self function_520227e6(s_accolade.index) + "");
    var_c74eaab3++;
  }
  var_ab872594.x = x + 2;
  var_ab872594.y = y + 2;
  var_ab872594.alignx = "";
  var_ab872594.aligny = "";
  var_ab872594 settext(var_c06a516a);
  var_ab872594.hidewheninmenu = 1;
  var_ab872594.font = "";
  var_ab872594.foreground = 1;
  var_5922e3b8.x = x + 120;
  var_5922e3b8.y = y + 2;
  var_5922e3b8.alignx = "";
  var_5922e3b8.aligny = "";
  var_5922e3b8 settext(var_1c70e53e);
  var_5922e3b8.hidewheninmenu = 1;
  var_5922e3b8.font = "";
  var_5922e3b8.foreground = 1;
  var_87b86b14.x = x + 180;
  var_87b86b14.y = y + 2;
  var_87b86b14.alignx = "";
  var_87b86b14.aligny = "";
  var_87b86b14 settext(var_16bed2ea);
  var_87b86b14.hidewheninmenu = 1;
  var_87b86b14.font = "";
  var_87b86b14.foreground = 1;
  self.var_ab872594[self.var_ab872594.size] = var_ab872594;
  self.var_5922e3b8[self.var_5922e3b8.size] = var_5922e3b8;
  self.var_87b86b14[self.var_87b86b14.size] = var_87b86b14;
  self thread function_7b64a1e0();
  self.var_eb7d74bb = 0;
}

function function_a4b8b7d1(var_36b04a4a) {
  current_index = 0;
  foreach(str_accolade, s_accolade in level.accolades) {
    if(current_index == var_36b04a4a) {
      self increment(str_accolade);
      break;
    }
    current_index++;
  }
}

function function_2d7075c8() {
  setdvar("", "");
  setdvar("", "");
  adddebugcommand("");
  for(i = 0; i < level.accolades.size; i++) {
    adddebugcommand(((((("" + i) + "") + i) + "") + i) + "");
  }
}

function function_3b92459f() {
  self endon("disconnect");
  self endon("death");
}

function function_4c436dfe() {
  self endon("disconnect");
  while(true) {
    level waittill("save_restore");
    if(function_3c63ee8()) {
      continue;
    }
    foreach(e_player in level.players) {
      foreach(str_accolade, s_accolade in level.accolades) {
        accolade = e_player function_4f9d8dec(str_accolade);
        var_13c6f0bc = e_player function_3a7fd23a(s_accolade.index);
        var_89eb65c1 = e_player function_31381fa7(s_accolade.index);
        var_dd586ee5 = e_player function_4f34644b(s_accolade.index);
        if(isDefined(var_89eb65c1) && var_89eb65c1 && var_13c6f0bc == 0) {
          if(isDefined(accolade.var_9ebe4012) && accolade.var_9ebe4012) {
            e_player giveunlocktoken(1);
          }
          e_player addrankxpvalue("award_accolade", accolade.var_2376b52b);
          e_player addplayerstat("career_accolades", 1);
        }
        if(s_accolade.index == 2 || (isDefined(var_89eb65c1) && var_89eb65c1) && isDefined(var_dd586ee5)) {
          e_player function_8992915e(s_accolade.index, var_89eb65c1);
          accolade.is_completed = isDefined(var_89eb65c1) && var_89eb65c1;
          e_player function_de8b9e62(s_accolade.index, var_dd586ee5);
          e_player function_92050191(s_accolade.index, var_dd586ee5);
          accolade.current_value = var_dd586ee5;
          continue;
        }
        if(s_accolade.index == 0 && isDefined(var_dd586ee5)) {
          e_player function_de8b9e62(s_accolade.index, var_dd586ee5, 1);
          accolade.current_value = var_dd586ee5;
        }
      }
      e_player decorations::function_59f1fa79();
      e_player.var_eb7d74bb = 1;
    }
    uploadstats();
  }
}

function function_83f30558(accolade) {
  var_c3291c61 = self getdstat("PlayerStatsByMap", getrootmapname(), "accolades", accolade.index, "highestValue");
  currentvalue = accolade.current_value;
  if(!(isDefined(accolade.var_ab795acb) && accolade.var_ab795acb)) {
    var_fd9588d9 = currentvalue > var_c3291c61;
  }
  if(isDefined(var_fd9588d9) && var_fd9588d9) {
    self setdstat("PlayerStatsByMap", getrootmapname(), "accolades", accolade.index, "highestValue", currentvalue);
  }
}

function commit(map_name = level.script) {
  if(function_214e644a()) {
    return;
  }
  if(self == level) {
    foreach(player in level.players) {
      player commit(map_name);
      player function_cf1b719a();
    }
  } else if(isarray(self savegame::get_player_data("accolades"))) {
    foreach(str_accolade, s_accolade in level.accolades) {
      accolade = self function_4f9d8dec(str_accolade);
      if(!isDefined(accolade) || self function_3a7fd23a(accolade.index) != 0) {
        continue;
      }
      if(accolade.index == 2) {
        var_40a77a3a = self collectibles::function_ccb1e08d(getrootmapname());
        while(accolade.current_value < var_40a77a3a) {
          self increment(str_accolade);
        }
      }
      if(function_9ba543a3(str_accolade, accolade.current_value)) {
        if(accolade.index == 0 || accolade.index == 1 && !skipto::function_cb7247d8(map_name)) {
          continue;
        }
        accolade.is_completed = 1;
        self function_8992915e(accolade.index, 1);
        self function_de8b9e62(accolade.index, accolade.current_value, 1);
        if(isDefined(accolade.var_9ebe4012) && accolade.var_9ebe4012) {
          self giveunlocktoken(1);
        }
        self addplayerstat("career_accolades", 1);
      }
    }
    self decorations::function_59f1fa79();
  }
}