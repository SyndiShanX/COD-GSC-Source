/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2895.gsc
**************************************/

func_967C() {
  level.var_B6C2["easy"]["convergenceTime"] = 2.5;
  level.var_B6C2["easy"]["suppressionTime"] = 3.0;
  level.var_B6C2["easy"]["accuracy"] = 0.38;
  level.var_B6C2["easy"]["aiSpread"] = 2;
  level.var_B6C2["easy"]["playerSpread"] = 0.5;
  level.var_B6C2["medium"]["convergenceTime"] = 1.5;
  level.var_B6C2["medium"]["suppressionTime"] = 3.0;
  level.var_B6C2["medium"]["accuracy"] = 0.38;
  level.var_B6C2["medium"]["aiSpread"] = 2;
  level.var_B6C2["medium"]["playerSpread"] = 0.5;
  level.var_B6C2["hard"]["convergenceTime"] = 0.8;
  level.var_B6C2["hard"]["suppressionTime"] = 3.0;
  level.var_B6C2["hard"]["accuracy"] = 0.38;
  level.var_B6C2["hard"]["aiSpread"] = 2;
  level.var_B6C2["hard"]["playerSpread"] = 0.5;
  level.var_B6C2["fu"]["convergenceTime"] = 0.4;
  level.var_B6C2["fu"]["suppressionTime"] = 3.0;
  level.var_B6C2["fu"]["accuracy"] = 0.38;
  level.var_B6C2["fu"]["aiSpread"] = 2;
  level.var_B6C2["fu"]["playerSpread"] = 0.5;
}

main() {
  if(getdvar("mg42") == "") {
    setdvar("mgTurret", "off");
  }

  level.var_B153 = 24;
  var_0 = getEntArray("turretInfo", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] delete();
  }

  scripts\engine\utility::create_lock("mg42_drones");
  scripts\engine\utility::create_lock("mg42_drones_target_trace");
}

func_D66E() {
  self detach("weapon_mg42_carry", "tag_origin");
  self endon("death");
  self.goalradius = level.var_4FF6;

  if(isDefined(self.target)) {
    var_0 = getnode(self.target, "targetname");

    if(isDefined(var_0)) {
      if(isDefined(var_0.radius)) {
        self.goalradius = var_0.radius;
      }

      self give_more_perk(var_0);
    }
  }

  while(!isDefined(self.node)) {
    wait 0.05;
  }

  var_1 = undefined;

  if(isDefined(self.target)) {
    var_0 = getnode(self.target, "targetname");
    var_1 = var_0;
  }

  if(!isDefined(var_1)) {
    var_1 = self.node;
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1.type != "Turret") {
    return;
  }
  var_2 = _meth_8194();
  var_2[self.node.origin + ""] = undefined;

  if(isDefined(var_2[var_1.origin + ""])) {
    return;
  }
  var_3 = var_1.turret;

  if(isDefined(var_3.var_E1CA)) {
    return;
  }
  func_E1C9(var_3);

  if(var_3.var_9F46) {
    func_AB14(var_3);
  } else {
    func_E826(var_3);
  }

  scripts\sp\mg_penetration::func_8715(var_1.turret);
}

func_B6AB() {
  self waittill("trigger");
  level notify(self.targetname);
  level.var_B6AB[self.targetname] = 1;
  self delete();
}

func_B6BE(var_0) {
  var_0 waittill("trigger");
  var_1 = _getaiarray("bad_guys");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].var_EE13) && var_0.var_EE13 == var_1[var_2].var_EE13) {
      var_1[var_2] notify("auto_ai");
    }
  }

  var_3 = _getspawnerarray();

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    if(isDefined(var_3[var_2].var_EE13) && var_0.var_EE13 == var_3[var_2].var_EE13) {
      var_3[var_2].var_19C1 = "auto_ai";
    }
  }

  func_0B77::func_A622(var_0);
}

func_B6A8(var_0) {
  self endon("death");
  self endon("stop_suppressionFire");

  if(!isDefined(self.var_112C7)) {
    self.var_112C7 = 1;
  }

  for(;;) {
    while(self.var_112C7) {
      self settargetentity(var_0[randomint(var_0.size)]);
      wait(2 + randomfloat(2));
    }

    self cleartargetentity();

    while(!self.var_112C7) {
      wait 1;
    }
  }
}

func_B31A(var_0) {
  var_1 = self.origin;
  self waittill("auto_ai");
  var_0 notify("stopfiring");
  var_0 give_player_session_tokens("auto_ai");
  var_0 settargetentity(level.player);
}

func_32B6(var_0) {
  if(var_0 == "delay") {
    return 0.2;
  } else if(var_0 == "delay_range") {
    return 0.5;
  } else if(var_0 == "burst") {
    return 0.5;
  } else if(var_0 == "burst_fire_rate") {
    return 0.1;
  } else {
    return 1.5;
  }
}

func_32B7() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self.script_delay_min)) {
    var_0 = self.script_delay_min;
  } else {
    var_0 = func_32B6("delay");
  }

  if(isDefined(self.script_delay_max)) {
    var_1 = self.script_delay_max - var_0;
  } else {
    var_1 = func_32B6("delay_range");
  }

  if(isDefined(self.var_ED26)) {
    var_2 = self.var_ED26;
  } else {
    var_2 = func_32B6("burst");
  }

  if(isDefined(self.var_ED25)) {
    var_3 = self.var_ED25 - var_2;
  } else {
    var_3 = func_32B6("burst_range");
  }

  if(isDefined(self.var_ED24)) {
    var_4 = self.var_ED24;
  } else {
    var_4 = func_32B6("burst_fire_rate");
  }

  var_5 = gettime();
  var_6 = "start";

  if(isDefined(self.var_FC63)) {
    thread func_12A2F();
  }

  for(;;) {
    var_7 = (var_5 - gettime()) * 0.001;

    if(self getteamarray() && var_7 <= 0) {
      if(var_6 != "fire") {
        var_6 = "fire";
        thread func_5AAA(var_4);
      }

      var_7 = var_2 + randomfloat(var_3);
      thread func_12A99(var_7);
      self waittill("turretstatechange");
      var_7 = var_0 + randomfloat(var_1);
      var_5 = gettime() + int(var_7 * 1000);
      continue;
    }

    if(var_6 != "aim") {
      var_6 = "aim";
    }

    thread func_12A99(var_7);
    self waittill("turretstatechange");
  }
}

func_5AAA(var_0) {
  self endon("death");
  self endon("turretstatechange");
  var_1 = 0.1;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  for(;;) {
    self shootturret();
    wait(var_1);
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
  var_0 = self gettagorigin("tag_origin");
  var_1 = scripts\engine\utility::drop_to_ground(var_0, -30);
  var_2 = var_0[2] - var_1[2];
  var_3 = var_2 / 300;
  wait(var_3);
  _playworldsound(self.var_FC65, var_1);
  wait 1;
  self.var_FC66 = 1;
}

func_12A99(var_0) {
  if(var_0 <= 0) {
    return;
  }
  self endon("turretstatechange");
  wait(var_0);

  if(isDefined(self)) {
    self notify("turretstatechange");
  }
}

func_DC9D(var_0) {
  self endon("death");
  self notify("stop random_spread");
  self endon("stop random_spread");
  self endon("stopfiring");
  self settargetentity(var_0);

  for(;;) {
    if(isplayer(var_0)) {
      var_0.origin = self.var_B319 getorigin();
    } else {
      var_0.origin = self.var_B319.origin;
    }

    var_0.origin = var_0.origin + (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
    wait 0.2;
  }
}

func_B6A3(var_0) {
  self notify("stop_using_built_in_burst_fire");
  self endon("stop_using_built_in_burst_fire");
  var_0 givesentry();

  for(;;) {
    var_0 waittill("startfiring");
    thread func_32B5(var_0);
    var_0 _meth_8398();
    var_0 waittill("stopfiring");
    var_0 givesentry();
  }
}

func_32B5(var_0, var_1) {
  var_0 endon("entitydeleted");
  var_0 endon("stopfiring");
  self endon("stop_using_built_in_burst_fire");

  if(isDefined(var_0.script_delay_min)) {
    var_2 = var_0.script_delay_min;
  } else {
    var_2 = func_32B6("delay");
  }

  if(isDefined(var_0.script_delay_max)) {
    var_3 = var_0.script_delay_max - var_2;
  } else {
    var_3 = func_32B6("delay_range");
  }

  if(isDefined(var_0.var_ED26)) {
    var_4 = var_0.var_ED26;
  } else {
    var_4 = func_32B6("burst");
  }

  if(isDefined(var_0.var_ED25)) {
    var_5 = var_0.var_ED25 - var_4;
  } else {
    var_5 = func_32B6("burst_range");
  }

  for(;;) {
    var_0 _meth_8398();

    if(isDefined(var_1)) {
      var_0 thread func_DC9D(var_1);
    }

    wait(var_4 + randomfloat(var_5));
    var_0 givesentry();
    wait(var_2 + randomfloat(var_3));
  }
}

func_140E() {
  if(!isDefined(self.var_6E66)) {
    self.var_6E66 = 0;
  }

  if(!isDefined(self.targetname)) {
    return;
  }
  var_0 = getnode(self.targetname, "target");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.var_EE12)) {
    return;
  }
  if(!isDefined(var_0.var_B6A2)) {
    var_0.var_B6A2 = 1;
  }

  self.var_EE12 = var_0.var_EE12;
  var_1 = 1;

  for(;;) {
    if(var_1) {
      var_1 = 0;

      if(isDefined(var_0.targetname) || self.var_6E66) {
        self waittill("get new user");
      }
    }

    if(!var_0.var_B6A2) {
      var_0 waittill("enable mg42");
      var_0.var_B6A2 = 1;
    }

    var_2 = [];
    var_3 = _getaiarray();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = 1;

      if(isDefined(var_3[var_4].var_EE12) && var_3[var_4].var_EE12 == self.var_EE12) {
        var_5 = 0;
      }

      if(isDefined(var_3[var_4].used_an_mg42)) {
        var_5 = 1;
      }

      if(var_5) {
        var_2[var_2.size] = var_3[var_4];
      }
    }

    if(var_2.size) {
      var_3 = scripts\sp\utility::func_78AB(var_0.origin, undefined, var_2);
    } else {
      var_3 = scripts\sp\utility::func_78AA(var_0.origin, undefined);
    }

    var_2 = undefined;

    if(isDefined(var_3)) {
      var_3 notify("stop_going_to_node");
      var_3 thread func_0B77::worldpointinreticle_circle(var_0);
      var_3 waittill("death");
      continue;
    }

    self waittill("get new user");
  }
}

func_B6AA() {
  if(!isDefined(self.var_19C1)) {
    self.var_19C1 = "manual_ai";
  }

  var_0 = getnode(self.target, "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getent(var_0.target, "targetname");
  var_1.var_C6EA = var_0.origin;

  if(isDefined(var_1.target)) {
    if(!isDefined(level.var_B6AB) || !isDefined(level.var_B6AB[var_1.target])) {
      level.var_B6AB[var_1.target] = 0;
      getent(var_1.target, "targetname") thread func_B6AB();
    }

    var_2 = 1;
  } else
    var_2 = 0;

  for(;;) {
    if(self.count == 0) {
      return;
    }
    var_3 = undefined;

    while(!isDefined(var_3)) {
      var_3 = self dospawn();
      wait 1;
    }

    var_3 thread func_B6A5(var_1, var_2, self.var_19C1);
    var_3 thread func_B6A3(var_1);
    var_3 waittill("death");

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

func_A5F9(var_0, var_1, var_2, var_3) {
  var_0 waittill(var_1);

  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

func_B6A5(var_0, var_1, var_2) {
  self endon("death");

  if(var_2 == "manual_ai") {
    for(;;) {
      thread func_B6A4(var_0, var_1);
      self waittill("auto_ai");
      func_BC9D(var_0, "auto_ai");
      self waittill("manual_ai");
    }
  } else {
    for(;;) {
      func_BC9D(var_0, "auto_ai", level.player);
      self waittill("manual_ai");
      thread func_B6A4(var_0, var_1);
      self waittill("auto_ai");
    }
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

func_B6A4(var_0, var_1) {
  self endon("death");
  self endon("auto_ai");
  self.pacifist = 1;
  self give_mp_super_weapon(var_0.var_C6EA);
  self.goalradius = level.var_B153;
  self waittill("goal");

  if(var_1) {
    if(!level.var_B6AB[var_0.target]) {
      level waittill(var_0.target);
    }
  }

  self.pacifist = 0;
  var_0 give_player_session_tokens("auto_ai");
  var_0 cleartargetentity();
  var_2 = spawn("script_origin", (0, 0, 0));
  var_3 = spawn("script_model", (0, 0, 0));
  var_3.var_EB9C = 3;

  if(getdvar("mg42") != "off") {
    var_3 setModel("temp");
  }

  var_3 thread func_116C2(var_0, var_2);
  level thread func_A5F9(self, "death", var_2, var_3);
  level thread func_A5F9(self, "auto_ai", var_2, var_3);
  var_0.var_D2F7 = 0;
  var_4 = 0;
  var_5 = getEntArray("mg42_target", "targetname");

  if(var_5.size > 0) {
    var_6 = 1;
    var_7 = var_5[randomint(var_5.size)].origin;
    thread func_FE6F(var_5);
    func_BC9D(var_0);
    self.var_11515 = var_2;
    var_0 give_player_session_tokens("manual_ai");
    var_0 settargetentity(var_2);
    var_0 notify("startfiring");
    var_8 = 15;
    var_9 = 0.08;
    var_10 = 0.05;
    var_2.origin = var_5[randomint(var_5.size)].origin;
    var_11 = 0;

    while(!isDefined(level.var_CFE7)) {
      var_7 = var_2.origin;

      if(distance(var_7, var_5[self.var_86EA].origin) > var_8) {
        var_12 = vectornormalize(var_5[self.var_86EA].origin - var_7);
        var_12 = var_12 * var_8;
        var_7 = var_7 + var_12;
      } else
        self notify("next_target");

      var_2.origin = var_7;
      wait 0.1;
    }

    for(;;) {
      for(var_13 = 0; var_13 < 1; var_13 = var_13 + var_10) {
        var_2.origin = var_7 * (1.0 - var_13) + (level.player getorigin() + func_10B5A()) * var_13;

        if(func_D279()) {
          var_13 = 2;
        }

        wait(var_9);
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

        while(func_D279() && isDefined(level.var_CFE7.target) && gettime() < var_11) {
          var_16 = getEntArray(level.var_CFE7.target, "targetname");
          var_16 = var_16[randomint(var_16.size)];
          var_2.origin = var_16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          wait 0.1;
        }
      }

      self notify("next_target");

      while(func_D279()) {
        var_7 = var_2.origin;

        if(distance(var_7, var_5[self.var_86EA].origin) > var_8) {
          var_12 = vectornormalize(var_5[self.var_86EA].origin - var_7);
          var_12 = var_12 * var_8;
          var_7 = var_7 + var_12;
        } else
          self notify("next_target");

        var_2.origin = var_7;
        wait 0.1;
      }
    }
  } else {
    for(;;) {
      func_BC9D(var_0);

      while(!isDefined(level.var_CFE7)) {
        if(!var_0.var_D2F7) {
          var_0 settargetentity(level.player);
          var_0.var_D2F7 = 1;
          var_3.var_114F2 = level.player;
        }

        wait 0.2;
      }

      var_0 give_player_session_tokens("manual_ai");
      func_BC9D(var_0);
      var_0 notify("startfiring");
      var_11 = gettime() + 1500 + randomfloat(4000);

      while(var_11 > gettime()) {
        if(isDefined(level.var_CFE7)) {
          var_16 = getEntArray(level.var_CFE7.target, "targetname");
          var_16 = var_16[randomint(var_16.size)];
          var_2.origin = var_16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          var_0 settargetentity(var_2);
          var_3.var_114F2 = var_2;
          wait(randomfloat(1));
          continue;
        }

        break;
      }

      var_0 notify("stopfiring");
      func_BC9D(var_0);

      if(var_0.var_D2F7) {
        var_0 give_player_session_tokens("auto_ai");
        var_0 cleartargetentity();
        var_0.var_D2F7 = 0;
        var_3.var_114F2 = var_3;
        var_3.origin = (0, 0, 0);
      }

      while(isDefined(level.var_CFE7)) {
        wait 0.2;
      }

      wait(0.75 + randomfloat(0.2));
    }
  }
}

func_FE6F(var_0) {
  self endon("death");

  for(;;) {
    var_1 = [];

    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_1[var_2] = 0;
    }

    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      self.var_86EA = randomint(var_0.size);
      self waittill("next_target");

      while(var_1[self.var_86EA]) {
        self.var_86EA++;

        if(self.var_86EA >= var_0.size) {
          self.var_86EA = 0;
        }
      }

      var_1[self.var_86EA] = 1;
    }
  }
}

func_BC9D(var_0, var_1, var_2) {
  self give_mp_super_weapon(var_0.var_C6EA);
  self.goalradius = level.var_B153;
  self waittill("goal");

  if(isDefined(var_1) && var_1 == "auto_ai") {
    var_0 give_player_session_tokens("auto_ai");

    if(isDefined(var_2)) {
      var_0 settargetentity(var_2);
    } else {
      var_0 cleartargetentity();
    }
  }

  self _meth_83D7(var_0);
}

func_116C2(var_0, var_1) {
  if(getdvar("mg42") == "off") {
    return;
  }
  self.var_114F2 = self;

  for(;;) {
    self.origin = var_1.origin;
    wait 0.1;
  }
}

func_12A42(var_0) {
  var_1 = getent(var_0.var_263A, "targetname");
  var_2 = 0.5;

  if(isDefined(var_1.var_EEF6)) {
    var_2 = var_1.var_EEF6;
  }

  var_3 = 2;

  if(isDefined(var_1.var_EEF5)) {
    var_2 = var_1.var_EEF5;
  }

  for(;;) {
    var_1 waittill("turret_deactivate");
    wait(var_2 + randomfloat(var_3 - var_2));

    while(!_isturretactive(var_1)) {
      func_129EA(var_0, var_1);
      wait 1.0;
    }
  }
}

func_129EA(var_0, var_1) {
  var_2 = _getaiarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] _meth_81A5(var_0.origin) && var_2[var_3] _meth_8063(var_1)) {
      var_4 = var_2[var_3].keepclaimednodeifvalid;
      var_2[var_3].keepclaimednodeifvalid = 0;

      if(!var_2[var_3] _meth_83D4(var_0)) {
        var_2[var_3].keepclaimednodeifvalid = var_4;
      }
    }
  }
}

func_F6C3() {
  func_967C();
  var_0 = getEntArray("misc_turret", "code_classname");
  var_1 = scripts\sp\utility::func_7E72();

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2].var_EEAB)) {
      switch (var_0[var_2].var_EEAB) {
        case "easy":
          var_1 = "easy";
          break;
        case "medium":
          var_1 = "medium";
          break;
        case "hard":
          var_1 = "hard";
          break;
        case "fu":
          var_1 = "fu";
          break;
        default:
          continue;
      }
    }

    func_B6A7(var_0[var_2], var_1);
  }
}

func_B6A7(var_0, var_1) {
  var_0.contextleanenabled = level.var_B6C2[var_1]["convergenceTime"];
  var_0.suppressiontime = level.var_B6C2[var_1]["suppressionTime"];
  var_0.accuracy = level.var_B6C2[var_1]["accuracy"];
  var_0.var_1B02 = level.var_B6C2[var_1]["aiSpread"];
  var_0.var_D427 = level.var_B6C2[var_1]["playerSpread"];
}

func_B6A9(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0.88;
  }

  self endon("death");
  self notify("stop_mg42_target_drones");
  self endon("stop_mg42_target_drones");
  self.var_5CAD = 0;

  if(!isDefined(self.var_ED98)) {
    self.var_ED98 = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self give_player_session_tokens("manual_ai");
  var_3 = scripts\sp\utility::func_7E72();

  if(!isDefined(level.var_5CC3)) {
    var_4 = 1;
  } else {
    var_4 = 0;
  }

  for(;;) {
    if(var_4) {
      if(isDefined(self.var_5CC6)) {
        self give_player_session_tokens(self.var_5041);
      } else if(var_0) {
        self give_player_session_tokens("auto_nonai");
      } else {
        self give_player_session_tokens("auto_ai");
      }

      level waittill("new_drone");
    }

    if(!isDefined(self.var_C3EA)) {
      self.var_C3EA = self.contextleanenabled;
    }

    self.contextleanenabled = 2;

    if(!var_0) {
      var_5 = self _meth_8165();

      if(!isalive(var_5) || isplayer(var_5)) {
        wait 0.05;
        continue;
      } else
        var_1 = var_5.team;
    } else
      var_5 = undefined;

    if(var_1 == "allies") {
      var_6 = "axis";
    } else {
      var_6 = "allies";
    }

    while(level.var_5CC3[var_6].lastindex) {
      scripts\engine\utility::lock("mg42_drones");

      if(!level.var_5CC3[var_6].lastindex) {
        scripts\engine\utility::unlock("mg42_drones");
        break;
      }

      var_7 = func_7868(var_6, var_2);
      scripts\engine\utility::unlock("mg42_drones");

      if(!isDefined(self.var_ED98) || !self.var_ED98) {
        wait 0.05;
        break;
      }

      if(!isDefined(var_7)) {
        wait 0.05;
        break;
      }

      if(isDefined(self.var_1F5F)) {
        [[self.var_1F5F]]();
      }

      if(var_0) {
        self give_player_session_tokens("manual");
      } else {
        self give_player_session_tokens("manual_ai");
      }

      self settargetentity(var_7, (0, 0, 32));
      func_5C88(var_7, 1, var_2);
      self cleartargetentity();
      self givesentry();

      if(!var_0 && !(isDefined(self _meth_8165()) && self _meth_8165() == var_5)) {
        break;
      }
    }

    self.contextleanenabled = self.var_C3EA;
    self.var_C3EA = undefined;
    self cleartargetentity();
    self givesentry();

    if(level.var_5CC3[var_6].lastindex) {
      var_4 = 0;
      continue;
    }

    var_4 = 1;
  }
}

func_5C88(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_3 = gettime() + var_1 * 1000;
  var_4 = 0;

  while(var_3 > gettime() || var_4) {
    scripts\engine\utility::lock("mg42_drones_target_trace");
    var_5 = self getturrettarget(1);

    if(!bullettracepassed(self gettagorigin("tag_flash"), var_0.origin + (0, 0, 40), 0, var_0)) {
      scripts\engine\utility::unlock("mg42_drones_target_trace");
      break;
    } else if(isDefined(var_5) && distance(var_5.origin, self.origin) < distance(self.origin, var_0.origin)) {
      scripts\engine\utility::unlock("mg42_drones_target_trace");
      break;
    }

    if(!var_4) {
      self _meth_8398();
      var_4 = 1;
    }

    scripts\sp\utility::func_12BDD("mg42_drones_target_trace");
  }

  self givesentry();
  scripts\sp\utility::func_11165(level.var_5CC3[var_0.team], 1);
}

func_7868(var_0, var_1) {
  if(level.var_5CC3[var_0].lastindex < 1) {
    return;
  }
  var_2 = undefined;
  var_3 = anglesToForward(self.angles);

  for(var_4 = 0; var_4 < level.var_5CC3[var_0].lastindex; var_4++) {
    if(!isDefined(level.var_5CC3[var_0].var_2274[var_4])) {
      continue;
    }
    var_5 = vectortoangles(level.var_5CC3[var_0].var_2274[var_4].origin - self.origin);
    var_6 = anglesToForward(var_5);

    if(vectordot(var_3, var_6) < var_1) {
      continue;
    }
    var_2 = level.var_5CC3[var_0].var_2274[var_4];

    if(!bullettracepassed(self gettagorigin("tag_flash"), var_2 getsecondspassed(), 0, var_2)) {
      var_2 = undefined;
      continue;
    }

    break;
  }

  var_7 = self getturrettarget(1);

  if(!isDefined(self.var_D836)) {
    if(isDefined(var_2) && isDefined(var_7) && distancesquared(self.origin, var_7.origin) < distancesquared(self.origin, var_2.origin)) {
      var_2 = undefined;
    }
  }

  return var_2;
}

func_EB7D() {
  var_0 = getEntArray("misc_turret", "code_classname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.targetname)) {
      continue;
    }
    if(isDefined(var_3.var_EEF4) && var_3.var_EEF4) {
      continue;
    }
    if(isDefined(var_3.var_9FF0)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  if(!var_1.size) {
    return;
  }
  var_5 = var_1;

  foreach(var_7 in var_1) {
    foreach(var_9 in getnodesinradius(var_7.origin, 50, 0)) {
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
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
      var_9.var_12A72 = spawn("script_origin", var_7.origin);
      var_9.var_12A72.angles = var_7.angles;
      var_9.var_12A72.node = var_9;
      var_9.var_12A72.var_01B8 = 45;
      var_9.var_12A72.rightarc = 45;
      var_9.var_12A72.var_0349 = 15;
      var_9.var_12A72.var_006B = 15;

      if(isDefined(var_7.var_01B8)) {
        var_9.var_12A72.var_01B8 = min(var_7.var_01B8, 45);
      }

      if(isDefined(var_7.rightarc)) {
        var_9.var_12A72.rightarc = min(var_7.rightarc, 45);
      }

      if(isDefined(var_7.var_0349)) {
        var_9.var_12A72.var_0349 = min(var_7.var_0349, 15);
      }

      if(isDefined(var_7.var_006B)) {
        var_9.var_12A72.var_006B = min(var_7.var_006B, 15);
      }

      var_7 delete();
    }
  }
}

func_263B() {
  var_0 = getEntArray("misc_turret", "code_classname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.targetname) || tolower(var_3.targetname) != "auto_mgturret") {
      continue;
    }
    if(!isDefined(var_3.var_6A0B)) {
      continue;
    }
    if(!isDefined(var_3.var_ED69)) {
      var_1[var_1.size] = var_3;
    }
  }

  if(!var_1.size) {
    return;
  }
  var_5 = var_1;

  foreach(var_7 in var_1) {
    foreach(var_9 in getnodesinradius(var_7.origin, 70)) {
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
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
      var_9.turret = var_7;
      var_7.node = var_9;
      var_7.var_9F46 = 1;
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
    var_0 = strtok(self.var_EEF7, " ");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      self.var_FC5E["connected"][var_0[var_1]] = 1;
    }
  }

  if(isDefined(self.var_EEF3)) {
    var_0 = strtok(self.var_EEF3, " ");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      self.var_FC5E["ambush"][var_0[var_1]] = 1;
    }
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
  var_0 = spawn("script_model", (0, 0, 0));
  var_0.origin = self gettagorigin(level.var_D66F);
  var_0.angles = self gettagangles(level.var_D66F);
  var_0 setModel(self.var_12A78);
  var_1 = anglesToForward(self.angles);
  var_1 = var_1 * 100;
  var_0 movegravity(var_1, 0.5);
  self detach(self.var_12A78, level.var_D66F);
  self.var_12A78 = undefined;
  wait 0.7;
  var_0 delete();
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
  scripts\sp\utility::func_F2A4(scripts\anim\init::empty);
}

func_E2E2() {
  self waittill("turret_deactivate");
  self ghost_can_be_contained();
}

func_12DB9(var_0) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");

  for(;;) {
    self waittill("saw_enemy");
    var_0.origin = self.var_A8BB;
  }
}

func_BC78(var_0, var_1) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_2 = self.turret.origin + (0, 0, 16);
  var_3 = var_1.origin + (0, 0, 16);

  for(;;) {
    wait 0.05;

    if(sighttracepassed(var_0.origin, var_3, 0, undefined)) {
      continue;
    }
    var_4 = vectortoangles(var_2 - var_0.origin);
    var_5 = anglesToForward(var_4);
    var_5 = var_5 * 8;
    var_0.origin = var_0.origin + var_5;
  }
}

func_DDE3(var_0) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_0.var_2FAE = [];

  for(;;) {
    var_0.var_2FAE[var_0.var_2FAE.size] = self.origin + (0, 0, 50);
    wait 0.35;
  }
}

func_1A30(var_0, var_1) {
  if(!isalive(self.var_4B6D) && self getpersstat(self.var_4B6D)) {
    var_1.origin = self.var_A8BB;
    return;
  }

  var_2 = anglesToForward(var_0.angles);

  for(var_3 = var_1.var_2FAE.size - 3; var_3 >= 0; var_3--) {
    var_4 = var_1.var_2FAE[var_3];
    var_5 = vectornormalize(var_4 - var_0.origin);
    var_6 = vectordot(var_2, var_5);

    if(var_6 < 0.75) {
      continue;
    }
    var_1.origin = var_4;

    if(sighttracepassed(var_0.origin, var_4, 0, undefined)) {
      continue;
    }
    break;
  }
}

func_6C73(var_0) {
  var_1 = func_7BC7(var_0);
  var_2 = var_1["spot"];
  var_3 = var_1["type"];

  if(!isDefined(var_2)) {
    return;
  }
  func_E1C9(var_2);
  thread func_12DB9(var_0);
  thread func_BC78(var_0, var_2);

  if(var_3 == "ambush") {
    thread func_DDE3(var_0);
  }

  if(var_2.var_9F46) {
    func_AB14(var_2);
  } else {
    func_CB35(var_2);
    func_E826(var_2);
  }

  self notify("stop_updating_enemy_target_pos");

  if(var_3 == "ambush") {
    func_1A30(var_2, var_0);
  }

  var_2 settargetentity(var_0);
}

func_10389(var_0) {
  var_0 give_player_session_tokens("manual");
  wait 0.5;
  var_0 give_player_session_tokens("manual_ai");
}

func_AB14(var_0) {
  self _meth_83AF();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "none");
  var_1 = func_7D25(var_0);
  var_2 = _getstartorigin(var_0.origin, var_0.angles, var_1);
  self give_smack_perk(var_2);
  self waittill("runto_arrived");
  func_13030(var_0);
}

func_CB35(var_0) {
  self _meth_83AF();
  self.turret func_8EAE();
}

func_7D25(var_0) {
  var_1 = [];
  var_1["saw_bipod_stand"] = level.var_B6B0["bipod_stand_setup"];
  var_1["saw_bipod_crouch"] = level.var_B6B0["bipod_crouch_setup"];
  var_1["saw_bipod_prone"] = level.var_B6B0["bipod_prone_setup"];
  return var_1[var_0.weaponinfo];
}

func_E826(var_0) {
  var_1 = self.health;
  var_0 endon("turret_deactivate");
  self.var_B6A1 = var_0;
  self endon("death");
  self endon("dropped_gun");
  var_2 = func_7D25(var_0);
  self.var_12A78 = "weapon_mg42_carry";
  self notify("kill_get_gun_back_on_killanimscript_thread");
  scripts\anim\shared::placeweaponon(self.weapon, "none");

  if(self isbadguy()) {
    self.health = 1;
  }

  self attach(self.var_12A78, level.var_D66F);
  thread func_12A60();
  var_3 = _getstartorigin(var_0.origin, var_0.angles, var_2);
  self give_smack_perk(var_3);
  wait 0.05;
  scripts\sp\utility::func_F2A4(scripts\anim\combat::func_68C7);
  scripts\engine\utility::clear_exception("move");
  scripts\sp\utility::func_F398("cover_crouch", ::func_906E);

  while(distance(self.origin, var_3) > 16) {
    self give_smack_perk(var_3);
    wait 0.05;
  }

  self notify("kill_turret_detach_thread");

  if(self isbadguy()) {
    self.health = var_1;
  }

  if(soundexists("weapon_setup")) {
    _playworldsound("weapon_setup", self.origin);
  }

  self animscripted("setup_done", var_0.origin, var_0.angles, var_2);
  func_E2DB();
  self waittillmatch("setup_done", "end");
  var_0 notify("restore_default_drop_pitch");
  var_0 func_10106();
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  func_13030(var_0);
  self detach(self.var_12A78, level.var_D66F);
  scripts\sp\utility::func_F2A4(scripts\anim\init::empty);
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

  return self.turret.owner == self;
}

func_12A4E() {
  if(!func_130FD()) {
    scripts\engine\utility::clear_exception("move");
    return;
  }

  var_0 = find_connected_turrets("connected");
  var_1 = var_0["spots"];

  if(!var_1.size) {
    scripts\engine\utility::clear_exception("move");
    return;
  }

  var_2 = self.node;

  if(!isDefined(var_2) || !scripts\engine\utility::array_contains(var_1, var_2)) {
    var_3 = _meth_8194();

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_2 = scripts\engine\utility::random(var_1);

      if(isDefined(var_3[var_2.origin + ""])) {
        return;
      }
    }
  }

  var_5 = var_2.turret;

  if(isDefined(var_5.var_E1CA)) {
    return;
  }
  func_E1C9(var_5);

  if(var_5.var_9F46) {
    func_AB14(var_5);
  } else {
    func_E826(var_5);
  }

  scripts\sp\mg_penetration::func_8715(var_2.turret);
}

func_13030(var_0) {
  var_1 = self _meth_83D7(var_0);

  if(var_1) {
    scripts\sp\utility::func_F398("move", ::func_12A4E);
    self.turret = var_0;
    thread func_B6A3(var_0);
    var_0 give_player_session_tokens("manual_ai");
    var_0 thread func_E2E2();
    self.turret = var_0;
    var_0.owner = self;
    return 1;
  } else {
    var_0 ghost_can_be_contained();
    return 0;
  }
}

func_7BC7(var_0) {
  var_1 = [];
  var_1[var_1.size] = ::func_6C8D;
  var_1[var_1.size] = ::func_6C90;
  var_1 = scripts\engine\utility::array_randomize(var_1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = [[var_1[var_2]]](var_0);

    if(!isDefined(var_3["spots"])) {
      continue;
    }
    var_3["spot"] = scripts\engine\utility::random(var_3["spots"]);
    return var_3;
  }
}

_meth_8194() {
  var_0 = [];
  var_1 = _getaiarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_2].node)) {
      continue;
    }
    var_0[var_1[var_2].node.origin + ""] = 1;
  }

  return var_0;
}

find_connected_turrets(var_0) {
  var_1 = level.var_FC5D;
  var_2 = [];
  var_3 = getarraykeys(var_1);
  var_4 = _meth_8194();
  var_4[self.node.origin + ""] = undefined;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(var_1[var_6] == self.turret) {
      continue;
    }
    var_7 = getarraykeys(self.turret.var_FC5E[var_0]);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_1[var_6].var_6A0B + "" != var_7[var_8]) {
        continue;
      }
      if(isDefined(var_1[var_6].var_E1CA)) {
        continue;
      }
      if(isDefined(var_4[var_1[var_6].node.origin + ""])) {
        continue;
      }
      if(distance(self.goalpos, var_1[var_6].origin) > self.goalradius) {
        continue;
      }
      var_2[var_2.size] = var_1[var_6];
    }
  }

  var_9 = [];
  var_9["type"] = var_0;
  var_9["spots"] = var_2;
  return var_9;
}

func_6C90(var_0) {
  return find_connected_turrets("ambush");
}

func_6C8D(var_0) {
  var_1 = find_connected_turrets("connected");
  var_2 = var_1["spots"];

  if(!var_2.size) {
    return;
  }
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(!scripts\engine\utility::within_fov(var_2[var_4].origin, var_2[var_4].angles, var_0.origin, 0.75)) {
      continue;
    }
    if(!sighttracepassed(var_0.origin, var_2[var_4].origin + (0, 0, 16), 0, undefined)) {
      continue;
    }
    var_3[var_3.size] = var_2[var_4];
  }

  var_1["spots"] = var_3;
  return var_1;
}

func_D670() {
  func_EB66();
  var_0 = 1;
  self.var_9F46 = 1;
  self.var_E1CA = undefined;

  if(isDefined(self.var_9FF0)) {
    return;
  }
  if(self.spawnflags &var_0) {
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

  if(isalive(self.owner)) {
    self.owner notify("end_mg_behavior");
  }
}

func_12A05(var_0) {
  var_1 = var_0 _meth_8165();

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1 == self;
}

func_6304(var_0) {
  func_13818(var_0);
  var_0.var_E1CA = undefined;
}

func_13818(var_0) {
  var_0 endon("turret_deactivate");
  self endon("death");
  self waittill("end_mg_behavior");
}

func_E1C9(var_0) {
  var_0.var_E1CA = self;
  thread func_6304(var_0);
}