/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3664.gsc
*********************************************/

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
  var_0 = 0;
  var_1 = (0, 0, 0);
  for(;;) {
    wait(0.05);
    var_2 = self getvelocity();
    var_3 = var_2 - var_1;
    var_4 = length(var_3);
    var_5 = length(var_2);
    var_3 = var_2 - var_1;
    var_6 = level.player getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = anglestoright(var_6);
    var_9 = anglestoup(var_6);
    var_10 = abs(vectordot(var_3, var_7));
    var_11 = abs(vectordot(var_3, var_9));
    var_12 = abs(vectordot(var_3, var_8));
    if(var_5 != 0) {
      if(var_4 > 20) {
        if(level.player issprinting()) {
          func_12877();
        } else {
          func_12876();
        }
      } else if(var_5 >= var_0) {
        func_12875();
      }

      if(var_11 > 20 || var_10 > 20 || var_12 > 20) {
        func_12876();
      }
    }

    var_0 = var_5;
    var_1 = var_2;
  }
}

func_12875() {
  var_0 = gettime();
  if(var_0 > self.var_1183D.var_1045D.var_C518) {
    self.var_1183D.var_1045D.var_C518 = var_0 + randomintrange(200, 3000);
    self.var_1183D.var_1045D playSound("space_jetpack_boost_start_large");
  }
}

func_12876() {
  var_0 = gettime();
  if(var_0 > self.var_1183D.var_1045D.var_32BB) {
    self.var_1183D.var_1045D.var_32BB = var_0 + randomintrange(400, 800);
    self.var_1183D.var_1045D playSound("space_jetpack_boost_oneshot");
  }
}

func_12877() {
  var_0 = gettime();
  if(var_0 > self.var_1183D.var_1045D.var_10ABD) {
    self.var_1183D.var_1045D.var_10ABD = var_0 + randomintrange(400, 800);
    self.var_1183D.var_1045D playSound("space_jetpack_boost_oneshot_big");
  }
}

func_F335(var_0, var_1) {
  if(!isDefined(level.var_11CC)) {
    level.var_11CC = [];
  }

  if(!isDefined(level.var_11CC[var_0])) {
    var_2 = newhudelem();
    var_2.x = 10;
    var_2.y = 240 + 20 * level.var_11CC.size;
    var_2.label = var_0;
    level.var_11CC[var_0] = var_2;
  } else {
    var_2 = level.var_11CC[var_1];
  }

  var_2 settext(var_1);
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
  var_0 = 0;
  var_1 = 0;
  for(;;) {
    scripts\engine\utility::waitframe();
    var_2 = 0;
    if(level.player playerads() > 0.5 && gettime() > var_0) {
      var_2 = 1;
      var_0 = gettime() + 6000;
      thread func_CD54("player_short_breath_in");
    }

    var_3 = func_7A41();
    if(!var_2) {
      thread func_1286C(var_3);
    }

    thread func_1286D(var_3);
    var_1 = var_3;
  }
}

func_7A41() {
  if(self issprinting() && !self.isent.var_6F43) {
    self.isent.var_1045D.var_10AB9 = self.isent.var_1045D.var_10AB9 + 1;
  } else {
    self.isent.var_1045D.var_10AB9 = self.isent.var_1045D.var_10AB9 - 0.25;
  }

  var_0 = 0;
  self.isent.var_1045D.var_10AB9 = clamp(self.isent.var_1045D.var_10AB9, 0, 200);
  var_1 = int(self.isent.var_1045D.var_10AB9);
  if(var_1 > 60) {
    var_0 = 3;
  } else if(var_1 > 40) {
    var_0 = 2;
  } else if(var_1 > 20) {
    var_0 = 1;
  }

  return var_0;
}

func_11AA6() {
  var_0 = 0;
  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("grapple", "viper_stop_thrust", "viper_ads_out", "long_fire_time");
    var_2 = gettime();
    if(var_2 < var_0) {
      continue;
    }

    switch (var_1) {
      case "viper_stop_thrust":
        var_3 = "player_short_breath_out";
        wait(0.4);
        break;

      case "grapple":
        var_3 = "player_short_breath_in";
        wait(1);
        break;

      case "viper_ads_out":
        var_3 = "player_short_breath_out";
        wait(0.45);
        break;

      default:
        var_3 = "player_short_breath_in";
        break;
    }

    func_CD54(var_3);
    var_0 = gettime() + 1000;
  }
}

func_11AC5() {
  self endon("death");
  for(;;) {
    var_0 = 0;
    self waittill("begin_firing");
    var_1 = scripts\engine\utility::waittill_notify_or_timeout_return("end_firing", 1.5);
    if(!isDefined(var_1)) {
      thread func_CD54("player_short_breath_out");
    }
  }
}

func_CD54(var_0) {
  self notify("interrupt_breath");
  self endon("interrupt_breath");
  self.isent.var_1045D.var_3800 = 0;
  if(self.isent.var_1045D gettimepassed()) {
    self.isent.var_1045D stopsounds();
    while(self.isent.var_1045D gettimepassed()) {
      scripts\engine\utility::waitframe();
    }
  }

  func_CE38(var_0, 1);
  wait(3);
  self.isent.var_1045D.var_3800 = 1;
}

func_1286C(var_0) {
  if(!self.isent.var_1045D.var_3800) {
    return;
  }

  self endon("death");
  self endon("interrupt_breath");
  var_1 = func_787D(0);
  self.isent.var_1045D.var_3800 = 0;
  if(!scripts\sp\utility::func_65DB("pressurized")) {
    func_CE38(var_1["inhale"]);
  }

  if(!scripts\sp\utility::func_65DB("pressurized")) {
    func_CE38(var_1["exhale"]);
    if(isDefined(var_1["time"])) {
      wait(var_1["time"]);
    }
  }

  self.isent.var_1045D.var_3800 = 1;
}

func_1286D(var_0) {
  if(gettime() < self.isent.var_10463.var_BF43) {
    return;
  }

  if(scripts\sp\utility::func_65DB("pressurized")) {
    return;
  }

  self endon("death");
  self.isent.var_10463 playSound("player_space_heartbeat");
  switch (var_0) {
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

func_CE38(var_0, var_1) {
  self endon("death");
  while(self.isent.var_1045D gettimepassed() && !isDefined(var_1)) {
    wait(0.05);
  }

  if(isDefined(var_1)) {
    self.isent.var_1045D playSound(var_0, "space_sound_interrupt_done", 1);
    self.isent.var_1045D waittill("space_sound_interrupt_done");
    return;
  }

  self.isent.var_1045D playSound(var_0, "space_sound_done");
  self.isent.var_1045D waittill("space_sound_done");
}

func_787D(var_0) {
  var_1 = [];
  switch (var_0) {
    case 1:
      var_1["inhale"] = "space_breathe_player_inhale";
      var_1["exhale"] = "space_breathe_player_exhale";
      var_1["time"] = 0.75;
      break;

    case 2:
      var_1["inhale"] = "space_breathe_player_inhale";
      var_1["exhale"] = "space_breathe_player_exhale";
      var_1["time"] = 0.75;
      break;

    case 3:
      var_1["inhale"] = "space_breathe_player_inhale";
      var_1["exhale"] = "space_breathe_player_exhale";
      var_1["time"] = 2 + randomfloat(0.5);
      break;

    default:
      var_1["inhale"] = "space_breathe_player_inhale";
      var_1["exhale"] = "space_breathe_player_exhale";
      var_1["time"] = 2 + randomfloat(0.5);
      break;
  }

  return var_1;
}

pain(var_0) {
  switch (var_0) {
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

func_5B6A(var_0, var_1) {
  var_1 = var_1 * 0.05;
  var_2 = var_0 + var_1;
  var_3 = vectortoangles(var_2 - var_0);
  var_4 = length(var_2 - var_0);
  var_5 = 50;
  var_6 = anglesToForward(var_3);
  var_7 = var_6 * var_4;
  var_8 = 2;
  var_9 = var_6 * var_4 - var_8;
  var_10 = anglestoright(var_3);
  var_11 = var_10 * var_8 * -1;
  var_12 = var_10 * var_8;
  var_13 = (0.8, 0.8, 0);
  var_14 = 4;
}

draw_axis(var_0) {
  var_1 = 4;
  var_2 = (1, 1, 1);
  var_3 = 0;
  var_4 = 1;
}