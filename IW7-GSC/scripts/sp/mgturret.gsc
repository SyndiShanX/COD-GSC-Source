/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\mgturret.gsc
***********************************/

func_967C() {
  level.var_B6C2["easy"]["convergenceTime"] = 2.5;
  level.var_B6C2["easy"]["suppressionTime"] = 3;
  level.var_B6C2["easy"]["accuracy"] = 0.38;
  level.var_B6C2["easy"]["aiSpread"] = 2;
  level.var_B6C2["easy"]["playerSpread"] = 0.5;
  level.var_B6C2["medium"]["convergenceTime"] = 1.5;
  level.var_B6C2["medium"]["suppressionTime"] = 3;
  level.var_B6C2["medium"]["accuracy"] = 0.38;
  level.var_B6C2["medium"]["aiSpread"] = 2;
  level.var_B6C2["medium"]["playerSpread"] = 0.5;
  level.var_B6C2["hard"]["convergenceTime"] = 0.8;
  level.var_B6C2["hard"]["suppressionTime"] = 3;
  level.var_B6C2["hard"]["accuracy"] = 0.38;
  level.var_B6C2["hard"]["aiSpread"] = 2;
  level.var_B6C2["hard"]["playerSpread"] = 0.5;
  level.var_B6C2["fu"]["convergenceTime"] = 0.4;
  level.var_B6C2["fu"]["suppressionTime"] = 3;
  level.var_B6C2["fu"]["accuracy"] = 0.38;
  level.var_B6C2["fu"]["aiSpread"] = 2;
  level.var_B6C2["fu"]["playerSpread"] = 0.5;
}

main() {
  if(getdvar("mg42") == "") {
    setdvar("mgTurret", "off");
  }

  level.var_B153 = 24;
  var_00 = getEntArray("turretInfo", "targetname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01] delete();
  }

  scripts\engine\utility::create_lock("mg42_drones");
  scripts\engine\utility::create_lock("mg42_drones_target_trace");
}

func_D66E() {
  self detach("weapon_mg42_carry", "tag_origin");
  self endon("death");
  self.objective_playermask_showto = level.var_4FF6;
  if(isDefined(self.target)) {
    var_00 = getnode(self.target, "targetname");
    if(isDefined(var_00)) {
      if(isDefined(var_00.fgetarg)) {
        self.objective_playermask_showto = var_00.fgetarg;
      }

      self give_more_perk(var_00);
    }
  }

  while(!isDefined(self.target_getindexoftarget)) {
    wait(0.05);
  }

  var_01 = undefined;
  if(isDefined(self.target)) {
    var_00 = getnode(self.target, "targetname");
    var_01 = var_00;
  }

  if(!isDefined(var_01)) {
    var_01 = self.target_getindexoftarget;
  }

  if(!isDefined(var_01)) {
    return;
  }

  if(var_01.type != "Turret") {
    return;
  }

  var_02 = _meth_8194();
  var_02[self.target_getindexoftarget.origin + ""] = undefined;
  if(isDefined(var_02[var_01.origin + ""])) {
    return;
  }

  var_03 = var_01.turret;
  if(isDefined(var_03.var_E1CA)) {
    return;
  }

  func_E1C9(var_03);
  if(var_03.var_9F46) {
    func_AB14(var_03);
  } else {
    func_E826(var_03);
  }

  scripts\sp\mg_penetration::func_8715(var_01.turret);
}

func_B6AB() {
  self waittill("trigger");
  level notify(self.var_336);
  level.var_B6AB[self.var_336] = 1;
  self delete();
}

func_B6BE(param_00) {
  param_00 waittill("trigger");
  var_01 = getaiarray("bad_guys");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(isDefined(var_01[var_02].var_EE13) && param_00.var_EE13 == var_01[var_02].var_EE13) {
      var_01[var_02] notify("auto_ai");
    }
  }

  var_03 = getspawnerarray();
  for(var_02 = 0; var_02 < var_03.size; var_02++) {
    if(isDefined(var_03[var_02].var_EE13) && param_00.var_EE13 == var_03[var_02].var_EE13) {
      var_03[var_02].var_19C1 = "auto_ai";
    }
  }

  lib_0B77::func_A622(param_00);
}

func_B6A8(param_00) {
  self endon("death");
  self endon("stop_suppressionFire");
  if(!isDefined(self.var_112C7)) {
    self.var_112C7 = 1;
  }

  for(;;) {
    while(self.var_112C7) {
      self settargetentity(param_00[randomint(param_00.size)]);
      wait(2 + randomfloat(2));
    }

    self cleartargetentity();
    while(!self.var_112C7) {
      wait(1);
    }
  }
}

func_B31A(param_00) {
  var_01 = self.origin;
  self waittill("auto_ai");
  param_00 notify("stopfiring");
  param_00 give_player_session_tokens("auto_ai");
  param_00 settargetentity(level.player);
}

func_32B6(param_00) {
  if(param_00 == "delay") {
    return 0.2;
  }

  if(param_00 == "delay_range") {
    return 0.5;
  }

  if(param_00 == "burst") {
    return 0.5;
  }

  if(param_00 == "burst_fire_rate") {
    return 0.1;
  }

  return 1.5;
}

func_32B7() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");
  if(isDefined(self.script_delay_min)) {
    var_00 = self.script_delay_min;
  } else {
    var_00 = func_32B6("delay");
  }

  if(isDefined(self.script_delay_max)) {
    var_01 = self.script_delay_max - var_00;
  } else {
    var_01 = func_32B6("delay_range");
  }

  if(isDefined(self.var_ED26)) {
    var_02 = self.var_ED26;
  } else {
    var_02 = func_32B6("burst");
  }

  if(isDefined(self.var_ED25)) {
    var_03 = self.var_ED25 - var_02;
  } else {
    var_03 = func_32B6("burst_range");
  }

  if(isDefined(self.var_ED24)) {
    var_04 = self.var_ED24;
  } else {
    var_04 = func_32B6("burst_fire_rate");
  }

  var_05 = gettime();
  var_06 = "start";
  if(isDefined(self.var_FC63)) {
    thread func_12A2F();
  }

  for(;;) {
    var_07 = var_05 - gettime() * 0.001;
    if(self getteamarray() && var_07 <= 0) {
      if(var_06 != "fire") {
        var_06 = "fire";
        thread func_5AAA(var_04);
      }

      var_07 = var_02 + randomfloat(var_03);
      thread func_12A99(var_07);
      self waittill("turretstatechange");
      var_07 = var_00 + randomfloat(var_01);
      var_05 = gettime() + int(var_07 * 1000);
      continue;
    }

    if(var_06 != "aim") {
      var_06 = "aim";
    }

    thread func_12A99(var_07);
    self waittill("turretstatechange");
  }
}

func_5AAA(param_00) {
  self endon("death");
  self endon("turretstatechange");
  var_01 = 0.1;
  if(isDefined(param_00)) {
    var_01 = param_00;
  }

  for(;;) {
    self shootturret();
    wait(var_01);
  }
}

func_12A2F() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");
  if(isDefined(self.var_FC65)) {
    self.var_FC66 = 1;
  }

  for(;;) {
    self waittill("turret_fire");
    playFXOnTag(self.var_FC63, self, "tag_origin");
    if(isDefined(self.var_FC66) && self.var_FC66) {
      thread func_12A30();
    }
  }
}

func_12A30() {
  self endon("death");
  self.var_FC66 = 0;
  var_00 = self gettagorigin("tag_origin");
  var_01 = scripts\engine\utility::drop_to_ground(var_00, -30);
  var_02 = var_00[2] - var_01[2];
  var_03 = var_02 / 300;
  wait(var_03);
  playworldsound(self.var_FC65, var_01);
  wait(1);
  self.var_FC66 = 1;
}

func_12A99(param_00) {
  if(param_00 <= 0) {
    return;
  }

  self endon("turretstatechange");
  wait(param_00);
  if(isDefined(self)) {
    self notify("turretstatechange");
  }
}

func_DC9D(param_00) {
  self endon("death");
  self notify("stop random_spread");
  self endon("stop random_spread");
  self endon("stopfiring");
  self settargetentity(param_00);
  for(;;) {
    if(isplayer(param_00)) {
      param_00.origin = self.var_B319 getorigin();
    } else {
      param_00.origin = self.var_B319.origin;
    }

    param_00.origin = param_00.origin + (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
    wait(0.2);
  }
}

func_B6A3(param_00) {
  self notify("stop_using_built_in_burst_fire");
  self endon("stop_using_built_in_burst_fire");
  param_00 givesentry();
  for(;;) {
    param_00 waittill("startfiring");
    thread func_32B5(param_00);
    param_00 _meth_8398();
    param_00 waittill("stopfiring");
    param_00 givesentry();
  }
}

func_32B5(param_00, param_01) {
  param_00 endon("entitydeleted");
  param_00 endon("stopfiring");
  self endon("stop_using_built_in_burst_fire");
  if(isDefined(param_00.script_delay_min)) {
    var_02 = param_00.script_delay_min;
  } else {
    var_02 = func_32B6("delay");
  }

  if(isDefined(param_00.script_delay_max)) {
    var_03 = param_00.script_delay_max - var_02;
  } else {
    var_03 = func_32B6("delay_range");
  }

  if(isDefined(param_00.var_ED26)) {
    var_04 = param_00.var_ED26;
  } else {
    var_04 = func_32B6("burst");
  }

  if(isDefined(param_00.var_ED25)) {
    var_05 = param_00.var_ED25 - var_04;
  } else {
    var_05 = func_32B6("burst_range");
  }

  for(;;) {
    param_00 _meth_8398();
    if(isDefined(param_01)) {
      param_00 thread func_DC9D(param_01);
    }

    wait(var_04 + randomfloat(var_05));
    param_00 givesentry();
    wait(var_02 + randomfloat(var_03));
  }
}

func_140E() {
  if(!isDefined(self.var_6E66)) {
    self.var_6E66 = 0;
  }

  if(!isDefined(self.var_336)) {
    return;
  }

  var_00 = getnode(self.var_336, "target");
  if(!isDefined(var_00)) {
    return;
  }

  if(!isDefined(var_00.var_EE12)) {
    return;
  }

  if(!isDefined(var_00.var_B6A2)) {
    var_00.var_B6A2 = 1;
  }

  self.var_EE12 = var_00.var_EE12;
  var_01 = 1;
  for(;;) {
    if(var_01) {
      var_01 = 0;
      if(isDefined(var_00.var_336) || self.var_6E66) {
        self waittill("get new user");
      }
    }

    if(!var_00.var_B6A2) {
      var_00 waittill("enable mg42");
      var_00.var_B6A2 = 1;
    }

    var_02 = [];
    var_03 = getaiarray();
    for(var_04 = 0; var_04 < var_03.size; var_04++) {
      var_05 = 1;
      if(isDefined(var_03[var_04].var_EE12) && var_03[var_04].var_EE12 == self.var_EE12) {
        var_05 = 0;
      }

      if(isDefined(var_03[var_04].used_an_mg42)) {
        var_05 = 1;
      }

      if(var_05) {
        var_02[var_02.size] = var_03[var_04];
      }
    }

    if(var_02.size) {
      var_03 = scripts\sp\utility::func_78AB(var_00.origin, undefined, var_02);
    } else {
      var_03 = scripts\sp\utility::func_78AA(var_00.origin, undefined);
    }

    var_02 = undefined;
    if(isDefined(var_03)) {
      var_03 notify("stop_going_to_node");
      var_03 thread lib_0B77::worldpointinreticle_circle(var_00);
      var_03 waittill("death");
      continue;
    }

    self waittill("get new user");
  }
}

func_B6AA() {
  if(!isDefined(self.var_19C1)) {
    self.var_19C1 = "manual_ai";
  }

  var_00 = getnode(self.target, "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = getent(var_00.target, "targetname");
  var_01.var_C6EA = var_00.origin;
  if(isDefined(var_01.target)) {
    if(!isDefined(level.var_B6AB) || !isDefined(level.var_B6AB[var_01.target])) {
      level.var_B6AB[var_01.target] = 0;
      getent(var_01.target, "targetname") thread func_B6AB();
    }

    var_02 = 1;
  } else {
    var_02 = 0;
  }

  for(;;) {
    if(self.var_C1 == 0) {
      return;
    }

    var_03 = undefined;
    while(!isDefined(var_03)) {
      var_03 = self dospawn();
      wait(1);
    }

    var_03 thread func_B6A5(var_01, var_02, self.var_19C1);
    var_03 thread func_B6A3(var_01);
    var_03 waittill("death");
    if(isDefined(self.script_delay)) {
      wait(self.script_delay);
      continue;
    }

    if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
      wait(self.script_delay_min + randomfloat(self.script_delay_max - self.script_delay_min));
      continue;
    }

    wait(1);
  }
}

func_A5F9(param_00, param_01, param_02, param_03) {
  param_00 waittill(param_01);
  if(isDefined(param_02)) {
    param_02 delete();
  }

  if(isDefined(param_03)) {
    param_03 delete();
  }
}

func_B6A5(param_00, param_01, param_02) {
  self endon("death");
  if(param_02 == "manual_ai") {
    for(;;) {
      thread func_B6A4(param_00, param_01);
      self waittill("auto_ai");
      func_BC9D(param_00, "auto_ai");
      self waittill("manual_ai");
    }

    return;
  }

  for(;;) {
    func_BC9D(param_00, "auto_ai", level.player);
    self waittill("manual_ai");
    thread func_B6A4(param_00, param_01);
    self waittill("auto_ai");
  }
}

func_D279() {
  if(!isDefined(level.var_CFE7)) {
    return 0;
  }

  if(level.player getstance() == "prone") {
    return 1;
  }

  if(level.var_CFE8 == "cow" && level.player getstance() == "crouch") {
    return 1;
  }

  return 0;
}

func_10B5A() {
  if(level.player getstance() == "prone") {
    return (0, 0, 5);
  } else if(level.player getstance() == "crouch") {
    return (0, 0, 25);
  }

  return (0, 0, 50);
}

func_B6A4(param_00, param_01) {
  self endon("death");
  self endon("auto_ai");
  self.triggeroneoffradarsweep = 1;
  self give_mp_super_weapon(param_00.var_C6EA);
  self.objective_playermask_showto = level.var_B153;
  self waittill("goal");
  if(param_01) {
    if(!level.var_B6AB[param_00.target]) {
      level waittill(param_00.target);
    }
  }

  self.triggeroneoffradarsweep = 0;
  param_00 give_player_session_tokens("auto_ai");
  param_00 cleartargetentity();
  var_02 = spawn("script_origin", (0, 0, 0));
  var_03 = spawn("script_model", (0, 0, 0));
  var_03.var_EB9C = 3;
  if(getdvar("mg42") != "off") {
    var_03 setModel("temp");
  }

  var_03 thread func_116C2(param_00, var_02);
  level thread func_A5F9(self, "death", var_02, var_03);
  level thread func_A5F9(self, "auto_ai", var_02, var_03);
  param_00.var_D2F7 = 0;
  var_04 = 0;
  var_05 = getEntArray("mg42_target", "targetname");
  if(var_05.size > 0) {
    var_06 = 1;
    var_07 = var_05[randomint(var_05.size)].origin;
    thread func_FE6F(var_05);
    func_BC9D(param_00);
    self.var_11515 = var_02;
    param_00 give_player_session_tokens("manual_ai");
    param_00 settargetentity(var_02);
    param_00 notify("startfiring");
    var_08 = 15;
    var_09 = 0.08;
    var_0A = 0.05;
    var_02.origin = var_05[randomint(var_05.size)].origin;
    var_0B = 0;
    while(!isDefined(level.var_CFE7)) {
      var_07 = var_02.origin;
      if(distance(var_07, var_05[self.var_86EA].origin) > var_08) {
        var_0C = vectornormalize(var_05[self.var_86EA].origin - var_07);
        var_0C = var_0C * var_08;
        var_07 = var_07 + var_0C;
      } else {
        self notify("next_target");
      }

      var_02.origin = var_07;
      wait(0.1);
    }

    for(;;) {
      for(var_0D = 0; var_0D < 1; var_0D = var_0D + var_0A) {
        var_02.origin = var_07 * 1 - var_0D + level.player getorigin() + func_10B5A() * var_0D;
        if(func_D279()) {
          var_0D = 2;
        }

        wait(var_09);
      }

      var_0E = level.player getorigin();
      while(!func_D279()) {
        var_02.origin = level.player getorigin();
        var_0F = var_02.origin - var_0E;
        var_02.origin = var_02.origin + var_0F + func_10B5A();
        var_0E = level.player getorigin();
        wait(0.1);
      }

      if(func_D279()) {
        var_0B = gettime() + 1500 + randomfloat(4000);
        while(func_D279() && isDefined(level.var_CFE7.target) && gettime() < var_0B) {
          var_10 = getEntArray(level.var_CFE7.target, "targetname");
          var_10 = var_10[randomint(var_10.size)];
          var_02.origin = var_10.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          wait(0.1);
        }
      }

      self notify("next_target");
      while(func_D279()) {
        var_07 = var_02.origin;
        if(distance(var_07, var_05[self.var_86EA].origin) > var_08) {
          var_0C = vectornormalize(var_05[self.var_86EA].origin - var_07);
          var_0C = var_0C * var_08;
          var_07 = var_07 + var_0C;
        } else {
          self notify("next_target");
        }

        var_02.origin = var_07;
        wait(0.1);
      }
    }

    return;
  }

  for(;;) {
    func_BC9D(param_00);
    while(!isDefined(level.var_CFE7)) {
      if(!param_00.var_D2F7) {
        param_00 settargetentity(level.player);
        param_00.var_D2F7 = 1;
        var_03.var_114F2 = level.player;
      }

      wait(0.2);
    }

    param_00 give_player_session_tokens("manual_ai");
    func_BC9D(param_00);
    param_00 notify("startfiring");
    var_0B = gettime() + 1500 + randomfloat(4000);
    while(var_0B > gettime()) {
      if(isDefined(level.var_CFE7)) {
        var_10 = getEntArray(level.var_CFE7.target, "targetname");
        var_10 = var_10[randomint(var_10.size)];
        var_02.origin = var_10.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
        param_00 settargetentity(var_02);
        var_03.var_114F2 = var_02;
        wait(randomfloat(1));
        continue;
      }

      break;
    }

    param_00 notify("stopfiring");
    func_BC9D(param_00);
    if(param_00.var_D2F7) {
      param_00 give_player_session_tokens("auto_ai");
      param_00 cleartargetentity();
      param_00.var_D2F7 = 0;
      var_03.var_114F2 = var_03;
      var_03.origin = (0, 0, 0);
    }

    while(isDefined(level.var_CFE7)) {
      wait(0.2);
    }

    wait(0.75 + randomfloat(0.2));
  }
}

func_FE6F(param_00) {
  self endon("death");
  for(;;) {
    var_01 = [];
    for(var_02 = 0; var_02 < param_00.size; var_02++) {
      var_01[var_02] = 0;
    }

    for(var_02 = 0; var_02 < param_00.size; var_02++) {
      self.var_86EA = randomint(param_00.size);
      self waittill("next_target");
      while(var_01[self.var_86EA]) {
        self.var_86EA++;
        if(self.var_86EA >= param_00.size) {
          self.var_86EA = 0;
        }
      }

      var_01[self.var_86EA] = 1;
    }
  }
}

func_BC9D(param_00, param_01, param_02) {
  self give_mp_super_weapon(param_00.var_C6EA);
  self.objective_playermask_showto = level.var_B153;
  self waittill("goal");
  if(isDefined(param_01) && param_01 == "auto_ai") {
    param_00 give_player_session_tokens("auto_ai");
    if(isDefined(param_02)) {
      param_00 settargetentity(param_02);
    } else {
      param_00 cleartargetentity();
    }
  }

  self _meth_83D7(param_00);
}

func_116C2(param_00, param_01) {
  if(getdvar("mg42") == "off") {
    return;
  }

  self.var_114F2 = self;
  for(;;) {
    self.origin = param_01.origin;
    wait(0.1);
  }
}

func_12A42(param_00) {
  var_01 = getent(param_00.var_263A, "targetname");
  var_02 = 0.5;
  if(isDefined(var_01.var_EEF6)) {
    var_02 = var_01.var_EEF6;
  }

  var_03 = 2;
  if(isDefined(var_01.var_EEF5)) {
    var_02 = var_01.var_EEF5;
  }

  for(;;) {
    var_01 waittill("turret_deactivate");
    wait(var_02 + randomfloat(var_03 - var_02));
    while(!isturretactive(var_01)) {
      func_129EA(param_00, var_01);
      wait(1);
    }
  }
}

func_129EA(param_00, param_01) {
  var_02 = getaiarray();
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(var_02[var_03] _meth_81A5(param_00.origin) && var_02[var_03] _meth_8063(param_01)) {
      var_04 = var_02[var_03].sendmatchdata;
      var_02[var_03].sendmatchdata = 0;
      if(!var_02[var_03] _meth_83D4(param_00)) {
        var_02[var_03].sendmatchdata = var_04;
      }
    }
  }
}

func_F6C3() {
  func_967C();
  var_00 = getEntArray("misc_turret", "code_classname");
  var_01 = scripts\sp\utility::func_7E72();
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    if(isDefined(var_00[var_02].var_EEAB)) {
      switch (var_00[var_02].var_EEAB) {
        case "easy":
          var_01 = "easy";
          break;

        case "medium":
          var_01 = "medium";
          break;

        case "hard":
          var_01 = "hard";
          break;

        case "fu":
          var_01 = "fu";
          break;

        default:
          break;
      }
    }

    func_B6A7(var_00[var_02], var_01);
  }
}

func_B6A7(param_00, param_01) {
  param_00.var_C0 = level.var_B6C2[param_01]["convergenceTime"];
  param_00.suppressiontime = level.var_B6C2[param_01]["suppressionTime"];
  param_00.accuracy = level.var_B6C2[param_01]["accuracy"];
  param_00.var_1B02 = level.var_B6C2[param_01]["aiSpread"];
  param_00.var_D427 = level.var_B6C2[param_01]["playerSpread"];
}

func_B6A9(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0.88;
  }

  self endon("death");
  self notify("stop_mg42_target_drones");
  self endon("stop_mg42_target_drones");
  self.var_5CAD = 0;
  if(!isDefined(self.var_ED98)) {
    self.var_ED98 = 0;
  }

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  self give_player_session_tokens("manual_ai");
  var_03 = scripts\sp\utility::func_7E72();
  if(!isDefined(level.var_5CC3)) {
    var_04 = 1;
  } else {
    var_04 = 0;
  }

  for(;;) {
    if(var_04) {
      if(isDefined(self.var_5CC6)) {
        self give_player_session_tokens(self.var_5041);
      } else if(param_00) {
        self give_player_session_tokens("auto_nonai");
      } else {
        self give_player_session_tokens("auto_ai");
      }

      level waittill("new_drone");
    }

    if(!isDefined(self.var_C3EA)) {
      self.var_C3EA = self.var_C0;
    }

    self.var_C0 = 2;
    if(!param_00) {
      var_05 = self _meth_8165();
      if(!isalive(var_05) || isplayer(var_05)) {
        wait(0.05);
        continue;
      } else {
        param_01 = var_05.team;
      }
    } else {
      var_05 = undefined;
    }

    if(param_01 == "allies") {
      var_06 = "axis";
    } else {
      var_06 = "allies";
    }

    while(level.var_5CC3[var_06].lastindex) {
      scripts\engine\utility::lock("mg42_drones");
      if(!level.var_5CC3[var_06].lastindex) {
        scripts\engine\utility::unlock("mg42_drones");
        break;
      }

      var_07 = func_7868(var_06, param_02);
      scripts\engine\utility::unlock("mg42_drones");
      if(!isDefined(self.var_ED98) || !self.var_ED98) {
        wait(0.05);
        break;
      }

      if(!isDefined(var_07)) {
        wait(0.05);
        break;
      }

      if(isDefined(self.var_1F5F)) {
        [
          [self.var_1F5F]
        ]();
      }

      if(param_00) {
        self give_player_session_tokens("manual");
      } else {
        self give_player_session_tokens("manual_ai");
      }

      self settargetentity(var_07, (0, 0, 32));
      func_5C88(var_07, 1, param_02);
      self cleartargetentity();
      self givesentry();
      if(!param_00 && !isDefined(self _meth_8165()) && self _meth_8165() == var_05) {
        break;
      }
    }

    self.var_C0 = self.var_C3EA;
    self.var_C3EA = undefined;
    self cleartargetentity();
    self givesentry();
    if(level.var_5CC3[var_06].lastindex) {
      var_04 = 0;
      continue;
    }

    var_04 = 1;
  }
}

func_5C88(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("death");
  var_03 = gettime() + param_01 * 1000;
  var_04 = 0;
  while(var_03 > gettime() || var_04) {
    scripts\engine\utility::lock("mg42_drones_target_trace");
    var_05 = self getturrettarget(1);
    if(!bullettracepassed(self gettagorigin("tag_flash"), param_00.origin + (0, 0, 40), 0, param_00)) {
      scripts\engine\utility::unlock("mg42_drones_target_trace");
      break;
    } else if(isDefined(var_05) && distance(var_05.origin, self.origin) < distance(self.origin, param_00.origin)) {
      scripts\engine\utility::unlock("mg42_drones_target_trace");
      break;
    }

    if(!var_04) {
      self _meth_8398();
      var_04 = 1;
    }

    scripts\sp\utility::func_12BDD("mg42_drones_target_trace");
  }

  self givesentry();
  scripts\sp\utility::func_11165(level.var_5CC3[param_00.team], 1);
}

func_7868(param_00, param_01) {
  if(level.var_5CC3[param_00].lastindex < 1) {
    return;
  }

  var_02 = undefined;
  var_03 = anglesToForward(self.angles);
  for(var_04 = 0; var_04 < level.var_5CC3[param_00].lastindex; var_04++) {
    if(!isDefined(level.var_5CC3[param_00].var_2274[var_04])) {
      continue;
    }

    var_05 = vectortoangles(level.var_5CC3[param_00].var_2274[var_04].origin - self.origin);
    var_06 = anglesToForward(var_05);
    if(vectordot(var_03, var_06) < param_01) {
      continue;
    }

    var_02 = level.var_5CC3[param_00].var_2274[var_04];
    if(!bullettracepassed(self gettagorigin("tag_flash"), var_02 getsecondspassed(), 0, var_02)) {
      var_02 = undefined;
      continue;
    }

    break;
  }

  var_07 = self getturrettarget(1);
  if(!isDefined(self.var_D836)) {
    if(isDefined(var_02) && isDefined(var_07) && distancesquared(self.origin, var_07.origin) < distancesquared(self.origin, var_02.origin)) {
      var_02 = undefined;
    }
  }

  return var_02;
}

func_EB7D() {
  var_00 = getEntArray("misc_turret", "code_classname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.var_336)) {
      continue;
    }

    if(isDefined(var_03.var_EEF4) && var_03.var_EEF4) {
      continue;
    }

    if(isDefined(var_03.var_9FF0)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  if(!var_01.size) {
    return;
  }

  var_05 = var_01;
  foreach(var_07 in var_01) {
    foreach(var_09 in getnodesinradius(var_07.origin, 50, 0)) {
      if(var_09.type == "Path") {
        continue;
      }

      if(var_09.type == "Begin") {
        continue;
      }

      if(var_09.type == "End") {
        continue;
      }

      var_0A = anglesToForward((0, var_09.angles[1], 0));
      var_0B = anglesToForward((0, var_07.angles[1], 0));
      var_0C = vectordot(var_0A, var_0B);
      if(var_0C < 0.9) {
        continue;
      }

      var_05 = scripts\engine\utility::array_remove(var_05, var_07);
      var_09.var_12A72 = spawn("script_origin", var_07.origin);
      var_09.var_12A72.angles = var_07.angles;
      var_09.var_12A72.target_getindexoftarget = var_09;
      var_09.var_12A72.setmatchdataid = 45;
      var_09.var_12A72.setdevdvarifuninitialized = 45;
      var_09.var_12A72.var_349 = 15;
      var_09.var_12A72.var_6B = 15;
      if(isDefined(var_07.setmatchdataid)) {
        var_09.var_12A72.setmatchdataid = min(var_07.setmatchdataid, 45);
      }

      if(isDefined(var_07.setdevdvarifuninitialized)) {
        var_09.var_12A72.setdevdvarifuninitialized = min(var_07.setdevdvarifuninitialized, 45);
      }

      if(isDefined(var_07.var_349)) {
        var_09.var_12A72.var_349 = min(var_07.var_349, 15);
      }

      if(isDefined(var_07.var_6B)) {
        var_09.var_12A72.var_6B = min(var_07.var_6B, 15);
      }

      var_07 delete();
    }
  }
}

func_263B() {
  var_00 = getEntArray("misc_turret", "code_classname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(!isDefined(var_03.var_336) || tolower(var_03.var_336) != "auto_mgturret") {
      continue;
    }

    if(!isDefined(var_03.var_6A0B)) {
      continue;
    }

    if(!isDefined(var_03.var_ED69)) {
      var_01[var_01.size] = var_03;
    }
  }

  if(!var_01.size) {
    return;
  }

  var_05 = var_01;
  foreach(var_07 in var_01) {
    foreach(var_09 in getnodesinradius(var_07.origin, 70)) {
      if(var_09.type == "Path") {
        continue;
      }

      if(var_09.type == "Begin") {
        continue;
      }

      if(var_09.type == "End") {
        continue;
      }

      var_0A = anglesToForward((0, var_09.angles[1], 0));
      var_0B = anglesToForward((0, var_07.angles[1], 0));
      var_0C = vectordot(var_0A, var_0B);
      if(var_0C < 0.9) {
        continue;
      }

      var_05 = scripts\engine\utility::array_remove(var_05, var_07);
      var_09.turret = var_07;
      var_07.target_getindexoftarget = var_09;
      var_07.var_9F46 = 1;
    }
  }
}

func_EB66() {
  self.var_FC5E = [];
  self.var_FC5E["connected"] = [];
  self.var_FC5E["ambush"] = [];
  if(!isDefined(self.var_6A0B)) {
    return;
  }

  if(!isDefined(level.var_FC5D)) {
    level.var_FC5D = [];
  }

  level.var_FC5D[self.var_6A0B] = self;
  if(isDefined(self.var_EEF7)) {
    var_00 = strtok(self.var_EEF7, " ");
    for(var_01 = 0; var_01 < var_00.size; var_01++) {
      self.var_FC5E["connected"][var_00[var_01]] = 1;
    }
  }

  if(isDefined(self.var_EEF3)) {
    var_00 = strtok(self.var_EEF3, " ");
    for(var_01 = 0; var_01 < var_00.size; var_01++) {
      self.var_FC5E["ambush"][var_00[var_01]] = 1;
    }
  }
}

func_E2DA() {
  self notify("gun_placed_again");
  self endon("gun_placed_again");
  self waittill("restore_default_drop_pitch");
  wait(1);
  self ghost_can_be_contained();
}

func_5EEF() {
  thread func_5EF0();
}

func_5EF0() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00.origin = self gettagorigin(level.var_D66F);
  var_00.angles = self gettagangles(level.var_D66F);
  var_00 setModel(self.var_12A78);
  var_01 = anglesToForward(self.angles);
  var_01 = var_01 * 100;
  var_00 movegravity(var_01, 0.5);
  self detach(self.var_12A78, level.var_D66F);
  self.var_12A78 = undefined;
  wait(0.7);
  var_00 delete();
}

func_12A60() {
  self endon("kill_turret_detach_thread");
  self endon("dropped_gun");
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  func_5EEF();
}

func_12A61() {
  self endon("death");
  self endon("kill_turret_detach_thread");
  self waittill("dropped_gun");
  self detach(self.var_12A78, level.var_D66F);
}

func_E2DB() {
  self.var_E80C = undefined;
  scripts\sp\utility::func_F2A4(::scripts\anim\init::isdefined);
}

func_E2E2() {
  self waittill("turret_deactivate");
  self ghost_can_be_contained();
}

func_12DB9(param_00) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  for(;;) {
    self waittill("saw_enemy");
    param_00.origin = self.var_A8BB;
  }
}

func_BC78(param_00, param_01) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_02 = self.turret.origin + (0, 0, 16);
  var_03 = param_01.origin + (0, 0, 16);
  for(;;) {
    wait(0.05);
    if(sighttracepassed(param_00.origin, var_03, 0, undefined)) {
      continue;
    }

    var_04 = vectortoangles(var_02 - param_00.origin);
    var_05 = anglesToForward(var_04);
    var_05 = var_05 * 8;
    param_00.origin = param_00.origin + var_05;
  }
}

func_DDE3(param_00) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  param_00.var_2FAE = [];
  for(;;) {
    param_00.var_2FAE[param_00.var_2FAE.size] = self.origin + (0, 0, 50);
    wait(0.35);
  }
}

func_1A30(param_00, param_01) {
  if(!isalive(self.var_4B6D) && self getpersstat(self.var_4B6D)) {
    param_01.origin = self.var_A8BB;
    return;
  }

  var_02 = anglesToForward(param_00.angles);
  for(var_03 = param_01.var_2FAE.size - 3; var_03 >= 0; var_03--) {
    var_04 = param_01.var_2FAE[var_03];
    var_05 = vectornormalize(var_04 - param_00.origin);
    var_06 = vectordot(var_02, var_05);
    if(var_06 < 0.75) {
      continue;
    }

    param_01.origin = var_04;
    if(sighttracepassed(param_00.origin, var_04, 0, undefined)) {
      continue;
    }

    break;
  }
}

func_6C73(param_00) {
  var_01 = func_7BC7(param_00);
  var_02 = var_01["spot"];
  var_03 = var_01["type"];
  if(!isDefined(var_02)) {
    return;
  }

  func_E1C9(var_02);
  thread func_12DB9(param_00);
  thread func_BC78(param_00, var_02);
  if(var_03 == "ambush") {
    thread func_DDE3(param_00);
  }

  if(var_02.var_9F46) {
    func_AB14(var_02);
  } else {
    func_CB35(var_02);
    func_E826(var_02);
  }

  self notify("stop_updating_enemy_target_pos");
  if(var_03 == "ambush") {
    func_1A30(var_02, param_00);
  }

  var_02 settargetentity(param_00);
}

func_10389(param_00) {
  param_00 give_player_session_tokens("manual");
  wait(0.5);
  param_00 give_player_session_tokens("manual_ai");
}

func_AB14(param_00) {
  self _meth_83AF();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "none");
  var_01 = func_7D25(param_00);
  var_02 = getstartorigin(param_00.origin, param_00.angles, var_01);
  self give_smack_perk(var_02);
  self waittill("runto_arrived");
  func_13030(param_00);
}

func_CB35(param_00) {
  self _meth_83AF();
  self.turret func_8EAE();
}

func_7D25(param_00) {
  var_01 = [];
  var_01["saw_bipod_stand"] = level.var_B6B0["bipod_stand_setup"];
  var_01["saw_bipod_crouch"] = level.var_B6B0["bipod_crouch_setup"];
  var_01["saw_bipod_prone"] = level.var_B6B0["bipod_prone_setup"];
  return var_01[param_00.var_39B];
}

func_E826(param_00) {
  var_01 = self.health;
  param_00 endon("turret_deactivate");
  self.var_B6A1 = param_00;
  self endon("death");
  self endon("dropped_gun");
  var_02 = func_7D25(param_00);
  self.var_12A78 = "weapon_mg42_carry";
  self notify("kill_get_gun_back_on_killanimscript_thread");
  scripts\anim\shared::placeweaponon(self.var_394, "none");
  if(self gettargetchargepos()) {
    self.health = 1;
  }

  self attach(self.var_12A78, level.var_D66F);
  thread func_12A60();
  var_03 = getstartorigin(param_00.origin, param_00.angles, var_02);
  self give_smack_perk(var_03);
  wait(0.05);
  scripts\sp\utility::func_F2A4(::scripts\anim\combat::func_68C7);
  scripts\engine\utility::clear_exception("move");
  scripts\sp\utility::func_F398("cover_crouch", ::func_906E);
  while(distance(self.origin, var_03) > 16) {
    self give_smack_perk(var_03);
    wait(0.05);
  }

  self notify("kill_turret_detach_thread");
  if(self gettargetchargepos()) {
    self.health = var_01;
  }

  if(soundexists("weapon_setup")) {
    playworldsound("weapon_setup", self.origin);
  }

  self animscripted("setup_done", param_00.origin, param_00.angles, var_02);
  func_E2DB();
  self waittillmatch("end", "setup_done");
  param_00 notify("restore_default_drop_pitch");
  param_00 func_10106();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  func_13030(param_00);
  self detach(self.var_12A78, level.var_D66F);
  scripts\sp\utility::func_F2A4(::scripts\anim\init::isdefined);
  self notify("bcs_portable_turret_setup");
}

func_BC92() {
  self give_smack_perk(self.var_E894);
}

func_906E() {
  self endon("killanimscript");
  self waittill("death");
}

func_130FD() {
  if(!isDefined(self.turret)) {
    return 0;
  }

  return self.turret.triggerportableradarping == self;
}

func_12A4E() {
  if(!func_130FD()) {
    scripts\engine\utility::clear_exception("move");
    return;
  }

  var_00 = find_connected_turrets("connected");
  var_01 = var_00["spots"];
  if(!var_01.size) {
    scripts\engine\utility::clear_exception("move");
    return;
  }

  var_02 = self.target_getindexoftarget;
  if(!isDefined(var_02) || !scripts\engine\utility::array_contains(var_01, var_02)) {
    var_03 = _meth_8194();
    for(var_04 = 0; var_04 < var_01.size; var_04++) {
      var_02 = scripts\engine\utility::random(var_01);
      if(isDefined(var_03[var_02.origin + ""])) {
        return;
      }
    }
  }

  var_05 = var_02.turret;
  if(isDefined(var_05.var_E1CA)) {
    return;
  }

  func_E1C9(var_05);
  if(var_05.var_9F46) {
    func_AB14(var_05);
  } else {
    func_E826(var_05);
  }

  scripts\sp\mg_penetration::func_8715(var_02.turret);
}

func_13030(param_00) {
  var_01 = self _meth_83D7(param_00);
  if(var_01) {
    scripts\sp\utility::func_F398("move", ::func_12A4E);
    self.turret = param_00;
    thread func_B6A3(param_00);
    param_00 give_player_session_tokens("manual_ai");
    param_00 thread func_E2E2();
    self.turret = param_00;
    param_00.triggerportableradarping = self;
    return 1;
  }

  param_00 ghost_can_be_contained();
  return 0;
}

func_7BC7(param_00) {
  var_01 = [];
  var_01[var_01.size] = ::func_6C8D;
  var_01[var_01.size] = ::func_6C90;
  var_01 = scripts\engine\utility::array_randomize(var_01);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = [[var_01[var_02]]](param_00);
    if(!isDefined(var_03["spots"])) {
      continue;
    }

    var_03["spot"] = scripts\engine\utility::random(var_03["spots"]);
    return var_03;
  }
}

_meth_8194() {
  var_00 = [];
  var_01 = getaiarray();
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(!isDefined(var_01[var_02].target_getindexoftarget)) {
      continue;
    }

    var_00[var_01[var_02].target_getindexoftarget.origin + ""] = 1;
  }

  return var_00;
}

find_connected_turrets(param_00) {
  var_01 = level.var_FC5D;
  var_02 = [];
  var_03 = getarraykeys(var_01);
  var_04 = _meth_8194();
  var_04[self.target_getindexoftarget.origin + ""] = undefined;
  for(var_05 = 0; var_05 < var_03.size; var_05++) {
    var_06 = var_03[var_05];
    if(var_01[var_06] == self.turret) {
      continue;
    }

    var_07 = getarraykeys(self.turret.var_FC5E[param_00]);
    for(var_08 = 0; var_08 < var_07.size; var_08++) {
      if(var_01[var_06].var_6A0B + "" != var_07[var_08]) {
        continue;
      }

      if(isDefined(var_01[var_06].var_E1CA)) {
        continue;
      }

      if(isDefined(var_04[var_01[var_06].target_getindexoftarget.origin + ""])) {
        continue;
      }

      if(distance(self.objective_playermask_hidefromall, var_01[var_06].origin) > self.objective_playermask_showto) {
        continue;
      }

      var_02[var_02.size] = var_01[var_06];
    }
  }

  var_09 = [];
  var_09["type"] = param_00;
  var_09["spots"] = var_02;
  return var_09;
}

func_6C90(param_00) {
  return find_connected_turrets("ambush");
}

func_6C8D(param_00) {
  var_01 = find_connected_turrets("connected");
  var_02 = var_01["spots"];
  if(!var_02.size) {
    return;
  }

  var_03 = [];
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    if(!scripts\engine\utility::within_fov(var_02[var_04].origin, var_02[var_04].angles, param_00.origin, 0.75)) {
      continue;
    }

    if(!sighttracepassed(param_00.origin, var_02[var_04].origin + (0, 0, 16), 0, undefined)) {
      continue;
    }

    var_03[var_03.size] = var_02[var_04];
  }

  var_01["spots"] = var_03;
  return var_01;
}

func_D670() {
  func_EB66();
  var_00 = 1;
  self.var_9F46 = 1;
  self.var_E1CA = undefined;
  if(isDefined(self.var_9FF0)) {
    return;
  }

  if(self.spawnimpulsefield &var_00) {
    return;
  }

  func_8EAE();
}

func_8EAE() {
  self notify("stop_checking_for_flanking");
  self.var_9F46 = 0;
  self hide();
  self.var_103FB = 0;
  self makeunusable();
  self setdefaultdroppitch(0);
  thread func_E2DA();
}

func_10106() {
  self show();
  self.var_103FB = 1;
  self makeusable();
  self.var_9F46 = 1;
  thread func_1101D();
}

func_1101D() {
  self endon("stop_checking_for_flanking");
  self waittill("turret_deactivate");
  if(isalive(self.triggerportableradarping)) {
    self.triggerportableradarping notify("end_mg_behavior");
  }
}

func_12A05(param_00) {
  var_01 = param_00 _meth_8165();
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01 == self;
}

func_6304(param_00) {
  func_13818(param_00);
  param_00.var_E1CA = undefined;
}

func_13818(param_00) {
  param_00 endon("turret_deactivate");
  self endon("death");
  self waittill("end_mg_behavior");
}

func_E1C9(param_00) {
  param_00.var_E1CA = self;
  thread func_6304(param_00);
}