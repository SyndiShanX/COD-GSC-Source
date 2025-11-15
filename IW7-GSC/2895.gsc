/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2895.gsc
***************************************/

func_967C() {
  level.func_B6C2["easy"]["convergenceTime"] = 2.5;
  level.func_B6C2["easy"]["suppressionTime"] = 3.0;
  level.func_B6C2["easy"]["accuracy"] = 0.38;
  level.func_B6C2["easy"]["aiSpread"] = 2;
  level.func_B6C2["easy"]["playerSpread"] = 0.5;
  level.func_B6C2["medium"]["convergenceTime"] = 1.5;
  level.func_B6C2["medium"]["suppressionTime"] = 3.0;
  level.func_B6C2["medium"]["accuracy"] = 0.38;
  level.func_B6C2["medium"]["aiSpread"] = 2;
  level.func_B6C2["medium"]["playerSpread"] = 0.5;
  level.func_B6C2["hard"]["convergenceTime"] = 0.8;
  level.func_B6C2["hard"]["suppressionTime"] = 3.0;
  level.func_B6C2["hard"]["accuracy"] = 0.38;
  level.func_B6C2["hard"]["aiSpread"] = 2;
  level.func_B6C2["hard"]["playerSpread"] = 0.5;
  level.func_B6C2["fu"]["convergenceTime"] = 0.4;
  level.func_B6C2["fu"]["suppressionTime"] = 3.0;
  level.func_B6C2["fu"]["accuracy"] = 0.38;
  level.func_B6C2["fu"]["aiSpread"] = 2;
  level.func_B6C2["fu"]["playerSpread"] = 0.5;
}

main() {
  if(getdvar("mg42") == "")
    setdvar("mgTurret", "off");

  level.func_B153 = 24;
  var_00 = getEntArray("turretInfo", "targetname");

  for(var_01 = 0; var_01 < var_0.size; var_1++)
    var_0[var_01] delete();

  scripts\engine\utility::create_lock("mg42_drones");
  scripts\engine\utility::create_lock("mg42_drones_target_trace");
}

func_D66E() {
  self detach("weapon_mg42_carry", "tag_origin");
  self endon("death");
  self.goalradius = level.func_4FF6;

  if(isDefined(self.target)) {
    var_00 = getnode(self.target, "targetname");

    if(isDefined(var_00)) {
      if(isDefined(var_0.radius))
        self.goalradius = var_0.radius;

      self give_more_perk(var_00);
    }
  }

  while(!isDefined(self.node))
    wait 0.05;

  var_01 = undefined;

  if(isDefined(self.target)) {
    var_00 = getnode(self.target, "targetname");
    var_01 = var_00;
  }

  if(!isDefined(var_01))
    var_01 = self.node;

  if(!isDefined(var_01)) {
    return;
  }
  if(var_1.type != "Turret") {
    return;
  }
  var_02 = _meth_8194();
  var_2[self.node.origin + ""] = undefined;

  if(isDefined(var_2[var_1.origin + ""])) {
    return;
  }
  var_03 = var_1.turret;

  if(isDefined(var_3.func_E1CA)) {
    return;
  }
  func_E1C9(var_03);

  if(var_3.func_9F46)
    func_AB14(var_03);
  else
    func_E826(var_03);

  scripts\sp\mg_penetration::func_8715(var_1.turret);
}

func_B6AB() {
  self waittill("trigger");
  level notify(self.targetname);
  level.func_B6AB[self.targetname] = 1;
  self delete();
}

func_B6BE(var_00) {
  var_00 waittill("trigger");
  var_01 = _getaiarray("bad_guys");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(isDefined(var_1[var_02].func_EE13) && var_0.func_EE13 == var_1[var_02].func_EE13)
      var_1[var_02] notify("auto_ai");
  }

  var_03 = _getspawnerarray();

  for(var_02 = 0; var_02 < var_3.size; var_2++) {
    if(isDefined(var_3[var_02].func_EE13) && var_0.func_EE13 == var_3[var_02].func_EE13)
      var_3[var_02].func_19C1 = "auto_ai";
  }

  func_0B77::func_A622(var_00);
}

func_B6A8(var_00) {
  self endon("death");
  self endon("stop_suppressionFire");

  if(!isDefined(self.func_112C7))
    self.func_112C7 = 1;

  for(;;) {
    while(self.func_112C7) {
      self settargetentity(var_0[randomint(var_0.size)]);
      wait(2 + randomfloat(2));
    }

    self cleartargetentity();

    while(!self.func_112C7)
      wait 1;
  }
}

func_B31A(var_00) {
  var_01 = self.origin;
  self waittill("auto_ai");
  var_00 notify("stopfiring");
  var_00 give_player_session_tokens("auto_ai");
  var_00 settargetentity(level.player);
}

func_32B6(var_00) {
  if(var_00 == "delay")
    return 0.2;
  else if(var_00 == "delay_range")
    return 0.5;
  else if(var_00 == "burst")
    return 0.5;
  else if(var_00 == "burst_fire_rate")
    return 0.1;
  else
    return 1.5;
}

func_32B7() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self.script_delay_min))
    var_00 = self.script_delay_min;
  else
    var_00 = func_32B6("delay");

  if(isDefined(self.script_delay_max))
    var_01 = self.script_delay_max - var_00;
  else
    var_01 = func_32B6("delay_range");

  if(isDefined(self.func_ED26))
    var_02 = self.func_ED26;
  else
    var_02 = func_32B6("burst");

  if(isDefined(self.func_ED25))
    var_03 = self.func_ED25 - var_02;
  else
    var_03 = func_32B6("burst_range");

  if(isDefined(self.func_ED24))
    var_04 = self.func_ED24;
  else
    var_04 = func_32B6("burst_fire_rate");

  var_05 = gettime();
  var_06 = "start";

  if(isDefined(self.func_FC63))
    thread func_12A2F();

  for(;;) {
    var_07 = (var_05 - gettime()) * 0.001;

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

    if(var_06 != "aim")
      var_06 = "aim";

    thread func_12A99(var_07);
    self waittill("turretstatechange");
  }
}

func_5AAA(var_00) {
  self endon("death");
  self endon("turretstatechange");
  var_01 = 0.1;

  if(isDefined(var_00))
    var_01 = var_00;

  for(;;) {
    self shootturret();
    wait(var_01);
  }
}

func_12A2F() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self.func_FC65))
    self.func_FC66 = 1;

  for(;;) {
    self waittill("turret_fire");
    playFXOnTag(self.func_FC63, self, "tag_origin");

    if(isDefined(self.func_FC66) && self.func_FC66)
      thread func_12A30();
  }
}

func_12A30() {
  self endon("death");
  self.func_FC66 = 0;
  var_00 = self gettagorigin("tag_origin");
  var_01 = scripts\engine\utility::drop_to_ground(var_00, -30);
  var_02 = var_0[2] - var_1[2];
  var_03 = var_02 / 300;
  wait(var_03);
  _playworldsound(self.func_FC65, var_01);
  wait 1;
  self.func_FC66 = 1;
}

func_12A99(var_00) {
  if(var_00 <= 0) {
    return;
  }
  self endon("turretstatechange");
  wait(var_00);

  if(isDefined(self))
    self notify("turretstatechange");
}

func_DC9D(var_00) {
  self endon("death");
  self notify("stop random_spread");
  self endon("stop random_spread");
  self endon("stopfiring");
  self settargetentity(var_00);

  for(;;) {
    if(isplayer(var_00))
      var_0.origin = self.func_B319 getorigin();
    else
      var_0.origin = self.func_B319.origin;

    var_0.origin = var_0.origin + (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
    wait 0.2;
  }
}

func_B6A3(var_00) {
  self notify("stop_using_built_in_burst_fire");
  self endon("stop_using_built_in_burst_fire");
  var_00 givesentry();

  for(;;) {
    var_00 waittill("startfiring");
    thread func_32B5(var_00);
    var_00 _meth_8398();
    var_00 waittill("stopfiring");
    var_00 givesentry();
  }
}

func_32B5(var_00, var_01) {
  var_00 endon("entitydeleted");
  var_00 endon("stopfiring");
  self endon("stop_using_built_in_burst_fire");

  if(isDefined(var_0.script_delay_min))
    var_02 = var_0.script_delay_min;
  else
    var_02 = func_32B6("delay");

  if(isDefined(var_0.script_delay_max))
    var_03 = var_0.script_delay_max - var_02;
  else
    var_03 = func_32B6("delay_range");

  if(isDefined(var_0.func_ED26))
    var_04 = var_0.func_ED26;
  else
    var_04 = func_32B6("burst");

  if(isDefined(var_0.func_ED25))
    var_05 = var_0.func_ED25 - var_04;
  else
    var_05 = func_32B6("burst_range");

  for(;;) {
    var_00 _meth_8398();

    if(isDefined(var_01))
      var_00 thread func_DC9D(var_01);

    wait(var_04 + randomfloat(var_05));
    var_00 givesentry();
    wait(var_02 + randomfloat(var_03));
  }
}

func_140E() {
  if(!isDefined(self.func_6E66))
    self.func_6E66 = 0;

  if(!isDefined(self.targetname)) {
    return;
  }
  var_00 = getnode(self.targetname, "target");

  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_0.func_EE12)) {
    return;
  }
  if(!isDefined(var_0.func_B6A2))
    var_0.func_B6A2 = 1;

  self.func_EE12 = var_0.func_EE12;
  var_01 = 1;

  for(;;) {
    if(var_01) {
      var_01 = 0;

      if(isDefined(var_0.targetname) || self.func_6E66)
        self waittill("get new user");
    }

    if(!var_0.func_B6A2) {
      var_00 waittill("enable mg42");
      var_0.func_B6A2 = 1;
    }

    var_02 = [];
    var_03 = _getaiarray();

    for(var_04 = 0; var_04 < var_3.size; var_4++) {
      var_05 = 1;

      if(isDefined(var_3[var_04].func_EE12) && var_3[var_04].func_EE12 == self.func_EE12)
        var_05 = 0;

      if(isDefined(var_3[var_04].used_an_mg42))
        var_05 = 1;

      if(var_05)
        var_2[var_2.size] = var_3[var_04];
    }

    if(var_2.size)
      var_03 = scripts\sp\utility::func_78AB(var_0.origin, undefined, var_02);
    else
      var_03 = scripts\sp\utility::func_78AA(var_0.origin, undefined);

    var_02 = undefined;

    if(isDefined(var_03)) {
      var_03 notify("stop_going_to_node");
      var_03 thread func_0B77::worldpointinreticle_circle(var_00);
      var_03 waittill("death");
      continue;
    }

    self waittill("get new user");
  }
}

func_B6AA() {
  if(!isDefined(self.func_19C1))
    self.func_19C1 = "manual_ai";

  var_00 = getnode(self.target, "targetname");

  if(!isDefined(var_00)) {
    return;
  }
  var_01 = getent(var_0.target, "targetname");
  var_1.func_C6EA = var_0.origin;

  if(isDefined(var_1.target)) {
    if(!isDefined(level.func_B6AB) || !isDefined(level.func_B6AB[var_1.target])) {
      level.func_B6AB[var_1.target] = 0;
      getent(var_1.target, "targetname") thread func_B6AB();
    }

    var_02 = 1;
  } else
    var_02 = 0;

  for(;;) {
    if(self.count == 0) {
      return;
    }
    var_03 = undefined;

    while(!isDefined(var_03)) {
      var_03 = self dospawn();
      wait 1;
    }

    var_03 thread func_B6A5(var_01, var_02, self.func_19C1);
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

    wait 1;
  }
}

func_A5F9(var_00, var_01, var_02, var_03) {
  var_00 waittill(var_01);

  if(isDefined(var_02))
    var_02 delete();

  if(isDefined(var_03))
    var_03 delete();
}

func_B6A5(var_00, var_01, var_02) {
  self endon("death");

  if(var_02 == "manual_ai") {
    for(;;) {
      thread func_B6A4(var_00, var_01);
      self waittill("auto_ai");
      func_BC9D(var_00, "auto_ai");
      self waittill("manual_ai");
    }
  } else {
    for(;;) {
      func_BC9D(var_00, "auto_ai", level.player);
      self waittill("manual_ai");
      thread func_B6A4(var_00, var_01);
      self waittill("auto_ai");
    }
  }
}

func_D279() {
  if(!isDefined(level.func_CFE7))
    return 0;

  if(level.player getstance() == "prone")
    return 1;

  if(level.func_CFE8 == "cow" && level.player getstance() == "crouch")
    return 1;

  return 0;
}

func_10B5A() {
  if(level.player getstance() == "prone")
    return (0, 0, 5);
  else if(level.player getstance() == "crouch")
    return (0, 0, 25);

  return (0, 0, 50);
}

func_B6A4(var_00, var_01) {
  self endon("death");
  self endon("auto_ai");
  self.pacifist = 1;
  self give_mp_super_weapon(var_0.func_C6EA);
  self.goalradius = level.func_B153;
  self waittill("goal");

  if(var_01) {
    if(!level.func_B6AB[var_0.target])
      level waittill(var_0.target);
  }

  self.pacifist = 0;
  var_00 give_player_session_tokens("auto_ai");
  var_00 cleartargetentity();
  var_02 = spawn("script_origin", (0, 0, 0));
  var_03 = spawn("script_model", (0, 0, 0));
  var_3.func_EB9C = 3;

  if(getdvar("mg42") != "off")
    var_03 setModel("temp");

  var_03 thread func_116C2(var_00, var_02);
  level thread func_A5F9(self, "death", var_02, var_03);
  level thread func_A5F9(self, "auto_ai", var_02, var_03);
  var_0.func_D2F7 = 0;
  var_04 = 0;
  var_05 = getEntArray("mg42_target", "targetname");

  if(var_5.size > 0) {
    var_06 = 1;
    var_07 = var_5[randomint(var_5.size)].origin;
    thread func_FE6F(var_05);
    func_BC9D(var_00);
    self.func_11515 = var_02;
    var_00 give_player_session_tokens("manual_ai");
    var_00 settargetentity(var_02);
    var_00 notify("startfiring");
    var_08 = 15;
    var_09 = 0.08;
    var_10 = 0.05;
    var_2.origin = var_5[randomint(var_5.size)].origin;
    var_11 = 0;

    while(!isDefined(level.func_CFE7)) {
      var_07 = var_2.origin;

      if(distance(var_07, var_5[self.func_86EA].origin) > var_08) {
        var_12 = vectornormalize(var_5[self.func_86EA].origin - var_07);
        var_12 = var_12 * var_08;
        var_07 = var_07 + var_12;
      } else
        self notify("next_target");

      var_2.origin = var_07;
      wait 0.1;
    }

    for(;;) {
      for(var_13 = 0; var_13 < 1; var_13 = var_13 + var_10) {
        var_2.origin = var_07 * (1.0 - var_13) + (level.player getorigin() + func_10B5A()) * var_13;

        if(func_D279())
          var_13 = 2;

        wait(var_09);
      }

      var_14 = level.player getorigin();

      while(!func_D279()) {
        var_2.origin = level.player getorigin();
        var_15 = var_2.origin - var_14;
        var_2.origin = var_2.origin + var_15 + func_10B5A();
        var_14 = level.player getorigin();
        wait 0.1;
      }

      if(func_D279()) {
        var_11 = gettime() + 1500 + randomfloat(4000);

        while(func_D279() && isDefined(level.func_CFE7.target) && gettime() < var_11) {
          var_16 = getEntArray(level.func_CFE7.target, "targetname");
          var_16 = var_16[randomint(var_16.size)];
          var_2.origin = var_16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          wait 0.1;
        }
      }

      self notify("next_target");

      while(func_D279()) {
        var_07 = var_2.origin;

        if(distance(var_07, var_5[self.func_86EA].origin) > var_08) {
          var_12 = vectornormalize(var_5[self.func_86EA].origin - var_07);
          var_12 = var_12 * var_08;
          var_07 = var_07 + var_12;
        } else
          self notify("next_target");

        var_2.origin = var_07;
        wait 0.1;
      }
    }
  } else {
    for(;;) {
      func_BC9D(var_00);

      while(!isDefined(level.func_CFE7)) {
        if(!var_0.func_D2F7) {
          var_00 settargetentity(level.player);
          var_0.func_D2F7 = 1;
          var_3.func_114F2 = level.player;
        }

        wait 0.2;
      }

      var_00 give_player_session_tokens("manual_ai");
      func_BC9D(var_00);
      var_00 notify("startfiring");
      var_11 = gettime() + 1500 + randomfloat(4000);

      while(var_11 > gettime()) {
        if(isDefined(level.func_CFE7)) {
          var_16 = getEntArray(level.func_CFE7.target, "targetname");
          var_16 = var_16[randomint(var_16.size)];
          var_2.origin = var_16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          var_00 settargetentity(var_02);
          var_3.func_114F2 = var_02;
          wait(randomfloat(1));
          continue;
        }

        break;
      }

      var_00 notify("stopfiring");
      func_BC9D(var_00);

      if(var_0.func_D2F7) {
        var_00 give_player_session_tokens("auto_ai");
        var_00 cleartargetentity();
        var_0.func_D2F7 = 0;
        var_3.func_114F2 = var_03;
        var_3.origin = (0, 0, 0);
      }

      while(isDefined(level.func_CFE7))
        wait 0.2;

      wait(0.75 + randomfloat(0.2));
    }
  }
}

func_FE6F(var_00) {
  self endon("death");

  for(;;) {
    var_01 = [];

    for(var_02 = 0; var_02 < var_0.size; var_2++)
      var_1[var_02] = 0;

    for(var_02 = 0; var_02 < var_0.size; var_2++) {
      self.func_86EA = randomint(var_0.size);
      self waittill("next_target");

      while(var_1[self.func_86EA]) {
        self.func_86EA++;

        if(self.func_86EA >= var_0.size)
          self.func_86EA = 0;
      }

      var_1[self.func_86EA] = 1;
    }
  }
}

func_BC9D(var_00, var_01, var_02) {
  self give_mp_super_weapon(var_0.func_C6EA);
  self.goalradius = level.func_B153;
  self waittill("goal");

  if(isDefined(var_01) && var_01 == "auto_ai") {
    var_00 give_player_session_tokens("auto_ai");

    if(isDefined(var_02))
      var_00 settargetentity(var_02);
    else
      var_00 cleartargetentity();
  }

  self _meth_83D7(var_00);
}

func_116C2(var_00, var_01) {
  if(getdvar("mg42") == "off") {
    return;
  }
  self.func_114F2 = self;

  for(;;) {
    self.origin = var_1.origin;
    wait 0.1;
  }
}

func_12A42(var_00) {
  var_01 = getent(var_0.func_263A, "targetname");
  var_02 = 0.5;

  if(isDefined(var_1.func_EEF6))
    var_02 = var_1.func_EEF6;

  var_03 = 2;

  if(isDefined(var_1.func_EEF5))
    var_02 = var_1.func_EEF5;

  for(;;) {
    var_01 waittill("turret_deactivate");
    wait(var_02 + randomfloat(var_03 - var_02));

    while(!_isturretactive(var_01)) {
      func_129EA(var_00, var_01);
      wait 1.0;
    }
  }
}

func_129EA(var_00, var_01) {
  var_02 = _getaiarray();

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    if(var_2[var_03] _meth_81A5(var_0.origin) && var_2[var_03] _meth_8063(var_01)) {
      var_04 = var_2[var_03].keepclaimednodeifvalid;
      var_2[var_03].keepclaimednodeifvalid = 0;

      if(!var_2[var_03] _meth_83D4(var_00))
        var_2[var_03].keepclaimednodeifvalid = var_04;
    }
  }
}

func_F6C3() {
  func_967C();
  var_00 = getEntArray("misc_turret", "code_classname");
  var_01 = scripts\sp\utility::func_7E72();

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    if(isDefined(var_0[var_02].func_EEAB)) {
      switch (var_0[var_02].func_EEAB) {
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
          continue;
      }
    }

    func_B6A7(var_0[var_02], var_01);
  }
}

func_B6A7(var_00, var_01) {
  var_0.contextleanenabled = level.func_B6C2[var_01]["convergenceTime"];
  var_0.suppressiontime = level.func_B6C2[var_01]["suppressionTime"];
  var_0.accuracy = level.func_B6C2[var_01]["accuracy"];
  var_0.func_1B02 = level.func_B6C2[var_01]["aiSpread"];
  var_0.func_D427 = level.func_B6C2[var_01]["playerSpread"];
}

func_B6A9(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 0.88;

  self endon("death");
  self notify("stop_mg42_target_drones");
  self endon("stop_mg42_target_drones");
  self.func_5CAD = 0;

  if(!isDefined(self.func_ED98))
    self.func_ED98 = 0;

  if(!isDefined(var_00))
    var_00 = 0;

  self give_player_session_tokens("manual_ai");
  var_03 = scripts\sp\utility::func_7E72();

  if(!isDefined(level.func_5CC3))
    var_04 = 1;
  else
    var_04 = 0;

  for(;;) {
    if(var_04) {
      if(isDefined(self.func_5CC6))
        self give_player_session_tokens(self.func_5041);
      else if(var_00)
        self give_player_session_tokens("auto_nonai");
      else
        self give_player_session_tokens("auto_ai");

      level waittill("new_drone");
    }

    if(!isDefined(self.func_C3EA))
      self.func_C3EA = self.contextleanenabled;

    self.contextleanenabled = 2;

    if(!var_00) {
      var_05 = self _meth_8165();

      if(!isalive(var_05) || isplayer(var_05)) {
        wait 0.05;
        continue;
      } else
        var_01 = var_5.team;
    } else
      var_05 = undefined;

    if(var_01 == "allies")
      var_06 = "axis";
    else
      var_06 = "allies";

    while(level.func_5CC3[var_06].lastindex) {
      scripts\engine\utility::lock("mg42_drones");

      if(!level.func_5CC3[var_06].lastindex) {
        scripts\engine\utility::unlock("mg42_drones");
        break;
      }

      var_07 = func_7868(var_06, var_02);
      scripts\engine\utility::unlock("mg42_drones");

      if(!isDefined(self.func_ED98) || !self.func_ED98) {
        wait 0.05;
        break;
      }

      if(!isDefined(var_07)) {
        wait 0.05;
        break;
      }

      if(isDefined(self.func_1F5F))
        [[self.func_1F5F]]();

      if(var_00)
        self give_player_session_tokens("manual");
      else
        self give_player_session_tokens("manual_ai");

      self settargetentity(var_07, (0, 0, 32));
      func_5C88(var_07, 1, var_02);
      self cleartargetentity();
      self givesentry();

      if(!var_00 && !(isDefined(self _meth_8165()) && self _meth_8165() == var_05)) {
        break;
      }
    }

    self.contextleanenabled = self.func_C3EA;
    self.func_C3EA = undefined;
    self cleartargetentity();
    self givesentry();

    if(level.func_5CC3[var_06].lastindex) {
      var_04 = 0;
      continue;
    }

    var_04 = 1;
  }
}

func_5C88(var_00, var_01, var_02) {
  self endon("death");
  var_00 endon("death");
  var_03 = gettime() + var_01 * 1000;
  var_04 = 0;

  while(var_03 > gettime() || var_04) {
    scripts\engine\utility::lock("mg42_drones_target_trace");
    var_05 = self getturrettarget(1);

    if(!bullettracepassed(self gettagorigin("tag_flash"), var_0.origin + (0, 0, 40), 0, var_00)) {
      scripts\engine\utility::unlock("mg42_drones_target_trace");
      break;
    } else if(isDefined(var_05) && distance(var_5.origin, self.origin) < distance(self.origin, var_0.origin)) {
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
  scripts\sp\utility::func_11165(level.func_5CC3[var_0.team], 1);
}

func_7868(var_00, var_01) {
  if(level.func_5CC3[var_00].lastindex < 1) {
    return;
  }
  var_02 = undefined;
  var_03 = anglesToForward(self.angles);

  for(var_04 = 0; var_04 < level.func_5CC3[var_00].lastindex; var_4++) {
    if(!isDefined(level.func_5CC3[var_00].func_2274[var_04])) {
      continue;
    }
    var_05 = vectortoangles(level.func_5CC3[var_00].func_2274[var_04].origin - self.origin);
    var_06 = anglesToForward(var_05);

    if(vectordot(var_03, var_06) < var_01) {
      continue;
    }
    var_02 = level.func_5CC3[var_00].func_2274[var_04];

    if(!bullettracepassed(self gettagorigin("tag_flash"), var_02 getsecondspassed(), 0, var_02)) {
      var_02 = undefined;
      continue;
    }

    break;
  }

  var_07 = self getturrettarget(1);

  if(!isDefined(self.func_D836)) {
    if(isDefined(var_02) && isDefined(var_07) && distancesquared(self.origin, var_7.origin) < distancesquared(self.origin, var_2.origin))
      var_02 = undefined;
  }

  return var_02;
}

func_EB7D() {
  var_00 = getEntArray("misc_turret", "code_classname");
  var_01 = [];

  foreach(var_03 in var_00) {
    if(isDefined(var_3.targetname)) {
      continue;
    }
    if(isDefined(var_3.func_EEF4) && var_3.func_EEF4) {
      continue;
    }
    if(isDefined(var_3.func_9FF0)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  if(!var_1.size) {
    return;
  }
  var_05 = var_01;

  foreach(var_07 in var_01) {
    foreach(var_09 in getnodesinradius(var_7.origin, 50, 0)) {
      if(var_9.type == "Path") {
        continue;
      }
      if(var_9.type == "Begin") {
        continue;
      }
      if(var_9.type == "End") {
        continue;
      }
      var_10 = anglesToForward((0, var_9.angles[1], 0));
      var_11 = anglesToForward((0, var_7.angles[1], 0));
      var_12 = vectordot(var_10, var_11);

      if(var_12 < 0.9) {
        continue;
      }
      var_05 = scripts\engine\utility::array_remove(var_05, var_07);
      var_9.func_12A72 = spawn("script_origin", var_7.origin);
      var_9.func_12A72.angles = var_7.angles;
      var_9.func_12A72.node = var_09;
      var_9.func_12A72.func_01B8 = 45;
      var_9.func_12A72.rightarc = 45;
      var_9.func_12A72.func_0349 = 15;
      var_9.func_12A72.func_006B = 15;

      if(isDefined(var_7.func_01B8))
        var_9.func_12A72.func_01B8 = min(var_7.func_01B8, 45);

      if(isDefined(var_7.rightarc))
        var_9.func_12A72.rightarc = min(var_7.rightarc, 45);

      if(isDefined(var_7.func_0349))
        var_9.func_12A72.func_0349 = min(var_7.func_0349, 15);

      if(isDefined(var_7.func_006B))
        var_9.func_12A72.func_006B = min(var_7.func_006B, 15);

      var_07 delete();
    }
  }
}

func_263B() {
  var_00 = getEntArray("misc_turret", "code_classname");
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!isDefined(var_3.targetname) || tolower(var_3.targetname) != "auto_mgturret") {
      continue;
    }
    if(!isDefined(var_3.func_6A0B)) {
      continue;
    }
    if(!isDefined(var_3.func_ED69))
      var_1[var_1.size] = var_03;
  }

  if(!var_1.size) {
    return;
  }
  var_05 = var_01;

  foreach(var_07 in var_01) {
    foreach(var_09 in getnodesinradius(var_7.origin, 70)) {
      if(var_9.type == "Path") {
        continue;
      }
      if(var_9.type == "Begin") {
        continue;
      }
      if(var_9.type == "End") {
        continue;
      }
      var_10 = anglesToForward((0, var_9.angles[1], 0));
      var_11 = anglesToForward((0, var_7.angles[1], 0));
      var_12 = vectordot(var_10, var_11);

      if(var_12 < 0.9) {
        continue;
      }
      var_05 = scripts\engine\utility::array_remove(var_05, var_07);
      var_9.turret = var_07;
      var_7.node = var_09;
      var_7.func_9F46 = 1;
    }
  }
}

func_EB66() {
  self.func_FC5E = [];
  self.func_FC5E["connected"] = [];
  self.func_FC5E["ambush"] = [];

  if(!isDefined(self.func_6A0B)) {
    return;
  }
  if(!isDefined(level.func_FC5D))
    level.func_FC5D = [];

  level.func_FC5D[self.func_6A0B] = self;

  if(isDefined(self.func_EEF7)) {
    var_00 = strtok(self.func_EEF7, " ");

    for(var_01 = 0; var_01 < var_0.size; var_1++)
      self.func_FC5E["connected"][var_0[var_01]] = 1;
  }

  if(isDefined(self.func_EEF3)) {
    var_00 = strtok(self.func_EEF3, " ");

    for(var_01 = 0; var_01 < var_0.size; var_1++)
      self.func_FC5E["ambush"][var_0[var_01]] = 1;
  }
}

func_E2DA() {
  self notify("gun_placed_again");
  self endon("gun_placed_again");
  self waittill("restore_default_drop_pitch");
  wait 1;
  self ghost_can_be_contained();
}

func_5EEF() {
  thread func_5EF0();
}

func_5EF0() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_0.origin = self gettagorigin(level.func_D66F);
  var_0.angles = self gettagangles(level.func_D66F);
  var_00 setModel(self.func_12A78);
  var_01 = anglesToForward(self.angles);
  var_01 = var_01 * 100;
  var_00 movegravity(var_01, 0.5);
  self detach(self.func_12A78, level.func_D66F);
  self.func_12A78 = undefined;
  wait 0.7;
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
  self detach(self.func_12A78, level.func_D66F);
}

func_E2DB() {
  self.func_E80C = undefined;
  scripts\sp\utility::func_F2A4(scripts\anim\init::empty);
}

func_E2E2() {
  self waittill("turret_deactivate");
  self ghost_can_be_contained();
}

func_12DB9(var_00) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");

  for(;;) {
    self waittill("saw_enemy");
    var_0.origin = self.func_A8BB;
  }
}

func_BC78(var_00, var_01) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_02 = self.turret.origin + (0, 0, 16);
  var_03 = var_1.origin + (0, 0, 16);

  for(;;) {
    wait 0.05;

    if(sighttracepassed(var_0.origin, var_03, 0, undefined)) {
      continue;
    }
    var_04 = vectortoangles(var_02 - var_0.origin);
    var_05 = anglesToForward(var_04);
    var_05 = var_05 * 8;
    var_0.origin = var_0.origin + var_05;
  }
}

func_DDE3(var_00) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_0.func_2FAE = [];

  for(;;) {
    var_0.func_2FAE[var_0.func_2FAE.size] = self.origin + (0, 0, 50);
    wait 0.35;
  }
}

func_1A30(var_00, var_01) {
  if(!isalive(self.func_4B6D) && self getpersstat(self.func_4B6D)) {
    var_1.origin = self.func_A8BB;
    return;
  }

  var_02 = anglesToForward(var_0.angles);

  for(var_03 = var_1.func_2FAE.size - 3; var_03 >= 0; var_3--) {
    var_04 = var_1.func_2FAE[var_03];
    var_05 = vectornormalize(var_04 - var_0.origin);
    var_06 = vectordot(var_02, var_05);

    if(var_06 < 0.75) {
      continue;
    }
    var_1.origin = var_04;

    if(sighttracepassed(var_0.origin, var_04, 0, undefined)) {
      continue;
    }
    break;
  }
}

func_6C73(var_00) {
  var_01 = func_7BC7(var_00);
  var_02 = var_1["spot"];
  var_03 = var_1["type"];

  if(!isDefined(var_02)) {
    return;
  }
  func_E1C9(var_02);
  thread func_12DB9(var_00);
  thread func_BC78(var_00, var_02);

  if(var_03 == "ambush")
    thread func_DDE3(var_00);

  if(var_2.func_9F46)
    func_AB14(var_02);
  else {
    func_CB35(var_02);
    func_E826(var_02);
  }

  self notify("stop_updating_enemy_target_pos");

  if(var_03 == "ambush")
    func_1A30(var_02, var_00);

  var_02 settargetentity(var_00);
}

func_10389(var_00) {
  var_00 give_player_session_tokens("manual");
  wait 0.5;
  var_00 give_player_session_tokens("manual_ai");
}

func_AB14(var_00) {
  self _meth_83AF();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "none");
  var_01 = func_7D25(var_00);
  var_02 = _getstartorigin(var_0.origin, var_0.angles, var_01);
  self give_smack_perk(var_02);
  self waittill("runto_arrived");
  func_13030(var_00);
}

func_CB35(var_00) {
  self _meth_83AF();
  self.turret func_8EAE();
}

func_7D25(var_00) {
  var_01 = [];
  var_1["saw_bipod_stand"] = level.func_B6B0["bipod_stand_setup"];
  var_1["saw_bipod_crouch"] = level.func_B6B0["bipod_crouch_setup"];
  var_1["saw_bipod_prone"] = level.func_B6B0["bipod_prone_setup"];
  return var_1[var_0.weaponinfo];
}

func_E826(var_00) {
  var_01 = self.health;
  var_00 endon("turret_deactivate");
  self.func_B6A1 = var_00;
  self endon("death");
  self endon("dropped_gun");
  var_02 = func_7D25(var_00);
  self.func_12A78 = "weapon_mg42_carry";
  self notify("kill_get_gun_back_on_killanimscript_thread");
  scripts\anim\shared::placeweaponon(self.weapon, "none");

  if(self isbadguy())
    self.health = 1;

  self attach(self.func_12A78, level.func_D66F);
  thread func_12A60();
  var_03 = _getstartorigin(var_0.origin, var_0.angles, var_02);
  self give_smack_perk(var_03);
  wait 0.05;
  scripts\sp\utility::func_F2A4(scripts\anim\combat::func_68C7);
  scripts\engine\utility::clear_exception("move");
  scripts\sp\utility::func_F398("cover_crouch", ::func_906E);

  while(distance(self.origin, var_03) > 16) {
    self give_smack_perk(var_03);
    wait 0.05;
  }

  self notify("kill_turret_detach_thread");

  if(self isbadguy())
    self.health = var_01;

  if(soundexists("weapon_setup"))
    _playworldsound("weapon_setup", self.origin);

  self animscripted("setup_done", var_0.origin, var_0.angles, var_02);
  func_E2DB();
  self waittillmatch("setup_done", "end");
  var_00 notify("restore_default_drop_pitch");
  var_00 func_10106();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  func_13030(var_00);
  self detach(self.func_12A78, level.func_D66F);
  scripts\sp\utility::func_F2A4(scripts\anim\init::empty);
  self notify("bcs_portable_turret_setup");
}

func_BC92() {
  self give_smack_perk(self.func_E894);
}

func_906E() {
  self endon("killanimscript");
  self waittill("death");
}

func_130FD() {
  if(!isDefined(self.turret))
    return 0;

  return self.turret.owner == self;
}

func_12A4E() {
  if(!func_130FD()) {
    scripts\engine\utility::clear_exception("move");
    return;
  }

  var_00 = find_connected_turrets("connected");
  var_01 = var_0["spots"];

  if(!var_1.size) {
    scripts\engine\utility::clear_exception("move");
    return;
  }

  var_02 = self.node;

  if(!isDefined(var_02) || !scripts\engine\utility::array_contains(var_01, var_02)) {
    var_03 = _meth_8194();

    for(var_04 = 0; var_04 < var_1.size; var_4++) {
      var_02 = scripts\engine\utility::random(var_01);

      if(isDefined(var_3[var_2.origin + ""]))
        return;
    }
  }

  var_05 = var_2.turret;

  if(isDefined(var_5.func_E1CA)) {
    return;
  }
  func_E1C9(var_05);

  if(var_5.func_9F46)
    func_AB14(var_05);
  else
    func_E826(var_05);

  scripts\sp\mg_penetration::func_8715(var_2.turret);
}

func_13030(var_00) {
  var_01 = self _meth_83D7(var_00);

  if(var_01) {
    scripts\sp\utility::func_F398("move", ::func_12A4E);
    self.turret = var_00;
    thread func_B6A3(var_00);
    var_00 give_player_session_tokens("manual_ai");
    var_00 thread func_E2E2();
    self.turret = var_00;
    var_0.owner = self;
    return 1;
  } else {
    var_00 ghost_can_be_contained();
    return 0;
  }
}

func_7BC7(var_00) {
  var_01 = [];
  var_1[var_1.size] = ::func_6C8D;
  var_1[var_1.size] = ::func_6C90;
  var_01 = scripts\engine\utility::array_randomize(var_01);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    var_03 = [[var_1[var_02]]](var_00);

    if(!isDefined(var_3["spots"])) {
      continue;
    }
    var_3["spot"] = scripts\engine\utility::random(var_3["spots"]);
    return var_03;
  }
}

_meth_8194() {
  var_00 = [];
  var_01 = _getaiarray();

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_02].node)) {
      continue;
    }
    var_0[var_1[var_02].node.origin + ""] = 1;
  }

  return var_00;
}

find_connected_turrets(var_00) {
  var_01 = level.func_FC5D;
  var_02 = [];
  var_03 = getarraykeys(var_01);
  var_04 = _meth_8194();
  var_4[self.node.origin + ""] = undefined;

  for(var_05 = 0; var_05 < var_3.size; var_5++) {
    var_06 = var_3[var_05];

    if(var_1[var_06] == self.turret) {
      continue;
    }
    var_07 = getarraykeys(self.turret.func_FC5E[var_00]);

    for(var_08 = 0; var_08 < var_7.size; var_8++) {
      if(var_1[var_06].func_6A0B + "" != var_7[var_08]) {
        continue;
      }
      if(isDefined(var_1[var_06].func_E1CA)) {
        continue;
      }
      if(isDefined(var_4[var_1[var_06].node.origin + ""])) {
        continue;
      }
      if(distance(self.goalpos, var_1[var_06].origin) > self.goalradius) {
        continue;
      }
      var_2[var_2.size] = var_1[var_06];
    }
  }

  var_09 = [];
  var_9["type"] = var_00;
  var_9["spots"] = var_02;
  return var_09;
}

func_6C90(var_00) {
  return find_connected_turrets("ambush");
}

func_6C8D(var_00) {
  var_01 = find_connected_turrets("connected");
  var_02 = var_1["spots"];

  if(!var_2.size) {
    return;
  }
  var_03 = [];

  for(var_04 = 0; var_04 < var_2.size; var_4++) {
    if(!scripts\engine\utility::within_fov(var_2[var_04].origin, var_2[var_04].angles, var_0.origin, 0.75)) {
      continue;
    }
    if(!sighttracepassed(var_0.origin, var_2[var_04].origin + (0, 0, 16), 0, undefined)) {
      continue;
    }
    var_3[var_3.size] = var_2[var_04];
  }

  var_1["spots"] = var_03;
  return var_01;
}

func_D670() {
  func_EB66();
  var_00 = 1;
  self.func_9F46 = 1;
  self.func_E1CA = undefined;

  if(isDefined(self.func_9FF0)) {
    return;
  }
  if(self.spawnflags & var_00) {
    return;
  }
  func_8EAE();
}

func_8EAE() {
  self notify("stop_checking_for_flanking");
  self.func_9F46 = 0;
  self hide();
  self.func_103FB = 0;
  self makeunusable();
  self setdefaultdroppitch(0);
  thread func_E2DA();
}

func_10106() {
  self show();
  self.func_103FB = 1;
  self makeusable();
  self.func_9F46 = 1;
  thread func_1101D();
}

func_1101D() {
  self endon("stop_checking_for_flanking");
  self waittill("turret_deactivate");

  if(isalive(self.owner))
    self.owner notify("end_mg_behavior");
}

func_12A05(var_00) {
  var_01 = var_00 _meth_8165();

  if(!isDefined(var_01))
    return 0;

  return var_01 == self;
}

func_6304(var_00) {
  func_13818(var_00);
  var_0.func_E1CA = undefined;
}

func_13818(var_00) {
  var_00 endon("turret_deactivate");
  self endon("death");
  self waittill("end_mg_behavior");
}

func_E1C9(var_00) {
  var_0.func_E1CA = self;
  thread func_6304(var_00);
}