/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_dog_killstreak.gsc
***************************************************/

init() {
  func_87A7();
}

func_87A7() {
  level.var_117E = [];
  level.var_1164 = 0;
  level.var_A41["dog"]["spawn"] = ::func_8F96;
  level.var_A41["dog"]["on_killed"] = ::func_6A72;
  level.var_A41["dog"]["on_damaged"] = level.var_A5C;
  level.var_A41["dog"]["on_damaged_finished"] = ::func_6A7E;
  level.var_A41["dog"]["think"] = ::func_0A57;
  level.var_5A7D["agent_mp"] = "agent_mp";
  level.killstreakfuncs["attack_dogs"] = ::func_9E26;
}

func_9E26(param_00, param_01) {
  if(level.var_1164 == 1) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_DOGS");
    return 0;
  }

  if(maps / mp / agents / _agent_utility::func_45BB("dog") >= 1) {
    self iprintlnbold(&"KILLSTREAKS_TOO_MANY_DOGS");
    return 0;
  }

  var_02 = maps / mp / agents / _agent_utility::get_max_agents();
  if(maps / mp / agents / _agent_utility::func_45BB() >= var_02) {
    self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  if(!maps\mp\_utility::isreallyalive(self)) {
    return 0;
  }

  self.origin2 = [];
  return func_A207();
}

func_A207() {
  level.var_1164 = 1;
  maps\mp\_matchdata::func_5E9A("attack_dogs", self.origin);
  if(level.var_53C6) {
    var_00 = getnodesinradiussorted(self.origin, 10000, 50, 2000, "Path");
  } else {
    var_00 = getnodesinradiussorted(self.origin, 500, 50, 128, "Path");
  }

  if(!isDefined(var_00)) {
    return 0;
  }

  if(var_00.size <= 0) {
    return 1;
  }

  for(var_01 = 0; var_01 < 4; var_01++) {
    self.origin2 = common_scripts\utility::func_FA0(self.origin2);
    var_02 = self.origin2.size;
    self.origin2[var_02] = maps / mp / agents / _agent_common::func_2586("dog", self.team);
    if(!isDefined(self.origin2[var_02])) {
      return 0;
    }

    self.origin2[var_02] maps / mp / agents / _agent_utility::func_83FE(self.team, self);
    var_03 = var_00[var_01].origin;
    var_04 = var_00[var_01].angles;
    self.origin2[var_02] thread[[self.origin2[var_02] maps / mp / agents / _agent_utility::func_A59("spawn")]](var_03, var_04, self);
  }

  thread func_93B8();
  thread func_77C2();
  thread func_1165();
  thread func_7DA6();
  return 1;
}

func_93B8() {
  level endon("game_ended");
  self endon("end_attack_dogs");
  var_00 = common_scripts\utility::func_A71B(80, "disconnect", "joined_team");
  level.var_1164 = 0;
  self notify("end_attack_dogs");
}

func_77C2() {
  level endon("game_ended");
  self waittill("end_attack_dogs");
  foreach(var_01 in self.origin2) {
    if(isDefined(var_01)) {
      maps / mp / agents / _agent_utility::func_5A28(var_01);
    }
  }

  level.var_1164 = 0;
}

func_1165() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  self endon("end_attack_dogs");
  for(var_00 = 8; var_00 > 0; var_00--) {
    self waittill("respawn_dog");
  }

  level.var_1164 = 0;
  self notify("end_attack_dogs");
}

func_7DA6() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  self endon("end_attack_dogs");
  for(var_00 = 0; var_00 < 4; var_00++) {
    self waittill("respawn_dog");
    self.origin2 = common_scripts\utility::func_FA0(self.origin2);
    var_01 = self.origin2.size;
    self.origin2[var_01] = maps / mp / agents / _agent_common::func_2586("dog", self.team);
    if(!isDefined(self.origin2[var_01])) {
      return 0;
    }

    if(level.var_53C6) {
      var_02 = maps\mp\gametypes\_globallogic::func_4437();
    } else {
      var_02 = [[level.var_4696]]();
    }

    self.origin2[var_01] thread[[self.origin2[var_01] maps / mp / agents / _agent_utility::func_A59("spawn")]](var_02.origin, var_02.angles, self);
  }
}

func_6A72(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self.var_565F = 0;
  self.var_4B60 = 0;
  param_01.var_5BB0 = gettime();
  if(isDefined(self.var_EAD.var_6B2F[self.var_BA4])) {
    self[[self.var_EAD.var_6B2F[self.var_BA4]]]();
  }

  if(isPlayer(param_01) && isDefined(self.owner) && param_01 != self.owner) {
    self.owner maps\mp\_utility::leaderdialogonplayer("dog_killed");
    maps\mp\gametypes\_damage::func_6B4B(param_01, param_04, param_03, param_02, "attack_dogs_destroyed", undefined, undefined, 1);
    if(isPlayer(param_01)) {
      param_01 maps\mp\gametypes\_missions::processchallenge("ch_notsobestfriend");
      if(!self isonground()) {
        param_01 maps\mp\gametypes\_missions::processchallenge("ch_hoopla");
      }
    }
  }

  self method_83D7("death");
  var_09 = self method_83D8();
  var_0A = getanimlength(var_09);
  param_08 = int(var_0A * 1000);
  self.var_18A8 = self select_last_entity(param_08);
  lib_0380::func_6844("anml_doberman_death", undefined, self);
  maps / mp / agents / _agent_utility::func_2A73();
  self notify("killanimscript");
  if(isDefined(self.owner)) {
    self.owner notify("respawn_dog");
  }
}

func_6A7E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!isDefined(self.var_74B4)) {
    thread func_716F(2.5);
  }

  var_0B = param_02;
  if(isDefined(param_08) && param_08 == "head") {
    var_0B = int(var_0B * 0.6);
    if(param_02 > 0 && var_0B <= 0) {
      var_0B = 1;
    }
  }

  if(self.health - var_0B > 0) {
    self[[level.var_31F3]](param_00, param_01, var_0B, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  if(isPlayer(param_01)) {
    if(isDefined(self.var_11B5) && self.var_11B5 != "attacking") {
      if(distancesquared(self.origin, param_01.origin) <= self.var_31B1) {
        self.var_94 = param_01;
        self.var_3E0B = 1;
        self thread[[level.var_31FB]]();
      }
    }
  }

  [[level.var_A41["player"]["on_damaged_finished"]]](param_00, param_01, var_0B, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

func_8F96(param_00, param_01, param_02, param_03) {
  var_04 = "animal_dobernan";
  if(isDefined(param_02) && isDefined(param_02.team)) {
    if(param_02.team == "axis") {
      var_04 = "iw6_dog";
    }
  }

  self setModel(var_04);
  self.var_90DC = "dog";
  self.var_6AFF = level.var_31F4;
  self method_856C(15, 40);
  if(isDefined(param_00) && isDefined(param_01)) {
    var_05 = param_00;
    var_06 = param_01;
  } else {
    self method_856C(15, 40);
    var_07 = [[level.var_4696]]();
    var_05 = var_07.origin;
    var_06 = var_07.angles;
  }

  maps / mp / agents / _agent_utility::func_8A7();
  self[[level.var_31F2]]();
  self select_by_substring(param_00, param_01, "dog_animclass", 15, 40, self);
  level notify("spawned_agent", self);
  maps / mp / agents / _agent_common::func_83FD(100);
  if(isDefined(param_03)) {
    self.var_BA6 = param_03;
    self method_858A(param_03);
    maps / mp / agents / _agent_utility::func_83FE(self.team, param_02);
  }

  if(isDefined(param_02) && isDefined(param_02.team)) {
    maps / mp / agents / _agent_utility::func_83FE(param_02.team, param_02);
  }

  self setthreatbiasgroup("Dogs");
  self takeallweapons();
  self thread[[maps / mp / agents / _agent_utility::func_A59("think")]]();
  wait(0.1);
  if(function_0269()) {
    playFXOnTag(level.var_3F1E, self, "tag_origin");
  }
}

func_716F(param_00) {
  self endon("death");
  lib_0380::func_6844("anml_doberman_pain", undefined, self);
  self.var_74B4 = 1;
  wait(param_00);
  self.var_74B4 = undefined;
}

func_8F27(param_00) {
  foreach(var_02 in param_00) {
    var_02.var_A9FE = 0;
    var_03 = distance(var_02.var_9087.origin, self.origin);
    if(var_03 < 1500) {
      var_02.var_A9FE = 1;
    } else if(var_03 > 1500 && var_03 < 2000) {
      var_02.var_A9FE = 2;
    } else if(var_03 > 2000 && var_03 < 2500) {
      var_02.var_A9FE = 3;
    } else if(var_03 > 2500) {
      var_02.var_A9FE = 4;
    }

    foreach(var_05 in level.players) {
      var_06 = var_02.var_9087.origin;
      var_07 = var_05.origin;
      var_08 = sighttracepassed(var_06, var_07, 0, var_05);
      if(var_08) {
        var_02.var_A9FE--;
      }

      var_03 = distance(var_02.var_9087.origin, var_05.origin);
      if(var_03 < 256) {
        var_02.var_A9FE--;
      }
    }
  }

  param_00 = common_scripts\utility::func_FA5(param_00, ::func_5788);
  return param_00;
}

func_5788(param_00, param_01) {
  return param_00.var_A9FE > param_01.var_A9FE;
}

func_0A57() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  self endon("end_attack_dogs");
  self[[level.var_31F8]]();
  self.var_5B10 = (0, 0, 0);
  self.var_173E = 0;
  self.var_7A58 = 0;
  self.var_11B8 = self.var_11B8 + 100;
  thread func_5E54();
  self thread[[self.var_A8ED]]();
  thread func_A692();
  thread func_0A56();
  for(;;) {
    if(self.var_BA4 != "melee" && !self.statelocked && self[[level.var_31F5]]() && !self[[level.var_31B2]]()) {
      self selected_ent_buttons(self.var_28D2);
    }

    if(self.var_7A58 > gettime()) {
      wait 0.05;
      continue;
    }

    if(!isDefined(self.enemy) || self.var_173E) {
      var_00 = getnodesinradiussorted(self.origin, 1024, 256, 128, "Path");
      if(var_00.size > 0) {
        var_01 = randomintrange(int(var_00.size * 0.9), var_00.size);
        self method_8395(var_00[var_01].origin);
        self.var_173E = 0;
        self.var_7A58 = gettime() + 2500;
      }
    } else {
      var_02 = self[[level.var_31F1]](self.enemy);
      self.var_28D2 = self.enemy;
      self.vectortoangles = "sprint";
      self.var_15E1 = 0;
      if(distancesquared(var_02, self.var_5B10) > 4096) {
        self method_8395(var_02);
        self.var_5B10 = var_02;
      }
    }

    wait 0.05;
  }
}

func_0A56() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    while(!isDefined(self.var_28D2)) {
      wait(0.25);
    }

    while(isDefined(self.var_28D2) && distance(self.origin, self.var_28D2.origin) > 200) {
      wait(randomfloatrange(0, 2));
      lib_0380::func_6844("anml_doberman_bark", undefined, self);
    }

    wait 0.05;
  }
}

func_A692() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("bad_path", var_00);
    self.var_173E = 1;
  }
}

func_6367() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.origin;
  var_01 = gettime();
  for(;;) {
    wait(5);
    var_02 = distancesquared(self.origin, var_00);
    var_03 = gettime() - var_01 / 1000;
    if(var_02 > 16384) {
      var_00 = self.origin;
      var_01 = gettime();
      continue;
    }

    if(var_03 > 25) {
      break;
    }
  }

  maps / mp / agents / _agent_utility::func_5A28(self);
}

func_5E54() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    foreach(var_01 in level.var_6E97) {
      self getenemyinfo(var_01);
    }

    wait(0.5);
  }
}