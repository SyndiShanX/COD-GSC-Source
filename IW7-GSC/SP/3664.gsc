/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3664.gsc
************************/

func_6247() {
  if(isDefined(self.var_1183D)) {
    return;
  }

  self.var_1183D = spawnStruct();
  self.var_1183D.var_1045D = spawn("script_origin", (0, 0, 0));
  self.var_1183D.var_1045D.var_32BB = 0;
  self.var_1183D.var_1045D.var_10ABD = 0;
  self.var_1183D.var_1045D.var_C518 = 0;
  self.var_1183D.var_26E2 = ["x", "y", "z_up", "z_down"];
  self.var_1183D.var_D891 = (0, 0, 0);
  thread func_11851();
}

func_5593() {
  self notify("disable_thruster_audio");
  if(isDefined(self.var_1183D)) {
    self.var_1183D.var_1045D delete();
  }

  self.var_1183D = undefined;
}

func_11851() {
  self endon("disable_thruster_audio");
  var_00 = 0;
  var_01 = (0, 0, 0);
  for(;;) {
    wait(0.05);
    var_02 = self getvelocity();
    var_03 = var_02 - var_01;
    var_04 = length(var_03);
    var_05 = length(var_02);
    var_03 = var_02 - var_01;
    var_06 = level.player getplayerangles();
    var_07 = anglesToForward(var_06);
    var_08 = anglestoright(var_06);
    var_09 = anglestoup(var_06);
    var_0A = abs(vectordot(var_03, var_07));
    var_0B = abs(vectordot(var_03, var_09));
    var_0C = abs(vectordot(var_03, var_08));
    if(var_05 != 0) {
      if(var_04 > 20) {
        if(level.player issprinting()) {
          func_12877();
        } else {
          func_12876();
        }
      } else if(var_05 >= var_00) {
        func_12875();
      }

      if(var_0B > 20 || var_0A > 20 || var_0C > 20) {
        func_12876();
      }
    }

    var_00 = var_05;
    var_01 = var_02;
  }
}

func_12875() {
  var_00 = gettime();
  if(var_00 > self.var_1183D.var_1045D.var_C518) {
    self.var_1183D.var_1045D.var_C518 = var_00 + randomintrange(200, 3000);
    self.var_1183D.var_1045D playSound("space_jetpack_boost_start_large");
  }
}

func_12876() {
  var_00 = gettime();
  if(var_00 > self.var_1183D.var_1045D.var_32BB) {
    self.var_1183D.var_1045D.var_32BB = var_00 + randomintrange(400, 800);
    self.var_1183D.var_1045D playSound("space_jetpack_boost_oneshot");
  }
}

func_12877() {
  var_00 = gettime();
  if(var_00 > self.var_1183D.var_1045D.var_10ABD) {
    self.var_1183D.var_1045D.var_10ABD = var_00 + randomintrange(400, 800);
    self.var_1183D.var_1045D playSound("space_jetpack_boost_oneshot_big");
  }
}

func_F335(param_00, param_01) {
  if(!isDefined(level.var_11CC)) {
    level.var_11CC = [];
  }

  if(!isDefined(level.var_11CC[param_00])) {
    var_02 = newhudelem();
    var_02.x = 10;
    var_02.y = 240 + 20 * level.var_11CC.size;
    var_02.label = param_00;
    level.var_11CC[param_00] = var_02;
  } else {
    var_02 = level.var_11CC[param_01];
  }

  var_02 settext(param_01);
}

func_CF84() {
  self endon("death");
  self endon("disable_space");
  if(!isDefined(self.isent.var_1045D)) {
    self.isent.var_1045D = scripts\engine\utility::spawn_tag_origin();
    self.isent.var_1045D linkto(self, "", (0, 0, 30), (0, 0, 0));
    self.isent.var_1045D.var_3800 = 1;
    self.isent.var_1045D.var_10AB9 = 0;
    self.isent.var_10463 = scripts\engine\utility::spawn_tag_origin();
    self.isent.var_10463 linkto(self, "", (0, 0, 30), (0, 0, 0));
    self.isent.var_10463.var_BF43 = 0;
  }

  childthread func_11AC5();
  childthread func_11AA6();
  var_00 = 0;
  var_01 = 0;
  for(;;) {
    scripts\engine\utility::waitframe();
    var_02 = 0;
    if(level.player getweaponrankinfominxp() > 0.5 && gettime() > var_00) {
      var_02 = 1;
      var_00 = gettime() + 6000;
      thread func_CD54("player_short_breath_in");
    }

    var_03 = func_7A41();
    if(!var_02) {
      thread func_1286C(var_03);
    }

    thread func_1286D(var_03);
    var_01 = var_03;
  }
}

func_7A41() {
  if(self issprinting() && !self.isent.var_6F43) {
    self.isent.var_1045D.var_10AB9 = self.isent.var_1045D.var_10AB9 + 1;
  } else {
    self.isent.var_1045D.var_10AB9 = self.isent.var_1045D.var_10AB9 - 0.25;
  }

  var_00 = 0;
  self.isent.var_1045D.var_10AB9 = clamp(self.isent.var_1045D.var_10AB9, 0, 200);
  var_01 = int(self.isent.var_1045D.var_10AB9);
  if(var_01 > 60) {
    var_00 = 3;
  } else if(var_01 > 40) {
    var_00 = 2;
  } else if(var_01 > 20) {
    var_00 = 1;
  }

  return var_00;
}

func_11AA6() {
  var_00 = 0;
  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("grapple", "viper_stop_thrust", "viper_ads_out", "long_fire_time");
    var_02 = gettime();
    if(var_02 < var_00) {
      continue;
    }

    switch (var_01) {
      case "viper_stop_thrust":
        var_03 = "player_short_breath_out";
        wait(0.4);
        break;

      case "grapple":
        var_03 = "player_short_breath_in";
        wait(1);
        break;

      case "viper_ads_out":
        var_03 = "player_short_breath_out";
        wait(0.45);
        break;

      default:
        var_03 = "player_short_breath_in";
        break;
    }

    func_CD54(var_03);
    var_00 = gettime() + 1000;
  }
}

func_11AC5() {
  self endon("death");
  for(;;) {
    var_00 = 0;
    self waittill("begin_firing");
    var_01 = scripts\engine\utility::waittill_notify_or_timeout_return("end_firing", 1.5);
    if(!isDefined(var_01)) {
      thread func_CD54("player_short_breath_out");
    }
  }
}

func_CD54(param_00) {
  self notify("interrupt_breath");
  self endon("interrupt_breath");
  self.isent.var_1045D.var_3800 = 0;
  if(self.isent.var_1045D gettimepassed()) {
    self.isent.var_1045D stopsounds();
    while(self.isent.var_1045D gettimepassed()) {
      scripts\engine\utility::waitframe();
    }
  }

  func_CE38(param_00, 1);
  wait(3);
  self.isent.var_1045D.var_3800 = 1;
}

func_1286C(param_00) {
  if(!self.isent.var_1045D.var_3800) {
    return;
  }

  self endon("death");
  self endon("interrupt_breath");
  var_01 = func_787D(0);
  self.isent.var_1045D.var_3800 = 0;
  if(!scripts\sp\utility::func_65DB("pressurized")) {
    func_CE38(var_01["inhale"]);
  }

  if(!scripts\sp\utility::func_65DB("pressurized")) {
    func_CE38(var_01["exhale"]);
    if(isDefined(var_01["time"])) {
      wait(var_01["time"]);
    }
  }

  self.isent.var_1045D.var_3800 = 1;
}

func_1286D(param_00) {
  if(gettime() < self.isent.var_10463.var_BF43) {
    return;
  }

  if(scripts\sp\utility::func_65DB("pressurized")) {
    return;
  }

  self endon("death");
  self.isent.var_10463 playSound("player_space_heartbeat");
  switch (param_00) {
    case 3:
      self.isent.var_10463.var_BF43 = gettime() + 400;
      break;

    case 2:
      self.isent.var_10463.var_BF43 = gettime() + 750;
      break;

    case 1:
      self.isent.var_10463.var_BF43 = gettime() + 1000;
      break;

    default:
      self.isent.var_10463.var_BF43 = gettime() + randomintrange(1500, 2000);
      break;
  }
}

func_CE38(param_00, param_01) {
  self endon("death");
  while(self.isent.var_1045D gettimepassed() && !isDefined(param_01)) {
    wait(0.05);
  }

  if(isDefined(param_01)) {
    self.isent.var_1045D playSound(param_00, "space_sound_interrupt_done", 1);
    self.isent.var_1045D waittill("space_sound_interrupt_done");
    return;
  }

  self.isent.var_1045D playSound(param_00, "space_sound_done");
  self.isent.var_1045D waittill("space_sound_done");
}

func_787D(param_00) {
  var_01 = [];
  switch (param_00) {
    case 1:
      var_01["inhale"] = "space_breathe_player_inhale";
      var_01["exhale"] = "space_breathe_player_exhale";
      var_01["time"] = 0.75;
      break;

    case 2:
      var_01["inhale"] = "space_breathe_player_inhale";
      var_01["exhale"] = "space_breathe_player_exhale";
      var_01["time"] = 0.75;
      break;

    case 3:
      var_01["inhale"] = "space_breathe_player_inhale";
      var_01["exhale"] = "space_breathe_player_exhale";
      var_01["time"] = 2 + randomfloat(0.5);
      break;

    default:
      var_01["inhale"] = "space_breathe_player_inhale";
      var_01["exhale"] = "space_breathe_player_exhale";
      var_01["time"] = 2 + randomfloat(0.5);
      break;
  }

  return var_01;
}

pain(param_00) {
  switch (param_00) {
    case "breathing_better":
      wait(randomfloatrange(0.2, 0.4));
      break;

    case "breathing_hurt":
      wait(randomfloatrange(0.2, 0.4));
      break;

    default:
      break;
  }
}

func_5B6A(param_00, param_01) {
  param_01 = param_01 * 0.05;
  var_02 = param_00 + param_01;
  var_03 = vectortoangles(var_02 - param_00);
  var_04 = length(var_02 - param_00);
  var_05 = 50;
  var_06 = anglesToForward(var_03);
  var_07 = var_06 * var_04;
  var_08 = 2;
  var_09 = var_06 * var_04 - var_08;
  var_0A = anglestoright(var_03);
  var_0B = var_0A * var_08 * -1;
  var_0C = var_0A * var_08;
  var_0D = (0.8, 0.8, 0);
  var_0E = 4;
}

draw_axis(param_00) {
  var_01 = 4;
  var_02 = (1, 1, 1);
  var_03 = 0;
  var_04 = 1;
}