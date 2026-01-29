/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1367.gsc
**************************************/

main() {
  precachestring(&"SCOUTSNIPER_MRHR");
  precachestring(&"SCRIPT_RADIATION_DEATH");
  precacheshellshock("radiation_low");
  precacheshellshock("radiation_med");
  precacheshellshock("radiation_high");

  foreach(var_2, var_1 in level.players) {
    var_1.radiation = spawnStruct();
    var_1.radiation._id_4192 = 0;
    var_1.radiation._id_4193 = 0;
    var_1 maps\_utility::_id_1402("_radiation_poisoning");
  }

  common_scripts\utility::run_thread_on_targetname("radiation", ::_id_4194);
  common_scripts\utility::run_thread_on_targetname("super_radiation", ::_id_4197);
  common_scripts\utility::array_thread(level.players, ::_id_4198);
  common_scripts\utility::array_thread(level.players, ::_id_41A0);
  common_scripts\utility::array_thread(level.players, ::_id_419B);
  common_scripts\utility::array_thread(level.players, ::_id_41A2);
  common_scripts\utility::array_thread(level.players, ::_id_419C);
  common_scripts\utility::array_thread(level.players, ::_id_419D);
  common_scripts\utility::array_thread(level.players, ::_id_41A4);
}

_id_4194() {
  self._id_0A6B = 0;

  for(;;) {
    self waittill("trigger", var_0);
    thread _id_4195(var_0);
  }
}

_id_4195(var_0) {
  if(var_0.radiation._id_4193) {
    return;
  }
  var_0.radiation._id_4193 = 1;
  var_0.radiation._id_4196[var_0.radiation._id_4196.size] = self;

  while(var_0 istouching(self)) {
    wait 0.05;

  }
  var_0.radiation._id_4193 = 0;
  var_0.radiation._id_4196 = common_scripts\utility::array_remove(var_0.radiation._id_4196, self);
}

_id_4197() {
  self waittill("trigger", var_0);
  var_0.radiation._id_4192 = 1;
}

_id_4198() {
  self.radiation._id_4196 = [];
  self.radiation._id_1E43 = 0;
  self.radiation._id_4199 = 0;
  self.radiation._id_2203 = 0;
  self.radiation._id_419A = 0;
  var_0 = 1;
  var_1 = 0;
  var_2 = 1100000 / (60 * var_0);
  var_3 = 200000;
  var_4 = var_2 - var_1;

  for(;;) {
    var_5 = [];

    for(var_6 = 0; var_6 < self.radiation._id_4196.size; var_6++) {
      var_7 = self.radiation._id_4196[var_6];
      var_8 = distance(self.origin, var_7.origin) - 15;
      var_5[var_6] = var_2 - var_2 / var_7.radius * var_8;
    }

    var_9 = 0;

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_9 = var_9 + var_5[var_6];

    }
    if(var_9 < var_1) {
      var_9 = var_1;

    }
    if(var_9 > var_2) {
      var_9 = var_2;

    }
    self.radiation._id_1E43 = var_9;
    self.radiation._id_4199 = (var_9 - var_1) / var_4 * 100;

    if(self.radiation._id_4192) {
      var_9 = var_2;
      self.radiation._id_4199 = 100;
    }

    if(self.radiation._id_4199 > 25) {
      self.radiation._id_2203 = self.radiation._id_2203 + var_9;
      self.radiation._id_419A = self.radiation._id_2203 / var_3 * 100;
    } else if(self.radiation._id_4199 < 1 && self.radiation._id_2203 > 0) {
      self.radiation._id_2203 = self.radiation._id_2203 - 1500;

      if(self.radiation._id_2203 < 0) {
        self.radiation._id_2203 = 0;

      }
      self.radiation._id_419A = self.radiation._id_2203 / var_3 * 100;
    }

    wait(var_0);
  }
}

_id_419B() {
  var_0 = 1;

  for(;;) {
    if(self.radiation._id_4199 >= 75) {
      self shellshock("radiation_high", 5);
    } else if(self.radiation._id_4199 >= 50) {
      self shellshock("radiation_med", 5);
    } else if(self.radiation._id_4199 > 25) {
      self shellshock("radiation_low", 5);

    }
    wait(var_0);
  }
}

_id_419C() {
  thread _id_419E();

  for(;;) {
    if(self.radiation._id_4199 >= 75) {
      self.radiation.sound = "item_geigercouner_level4";
    } else if(self.radiation._id_4199 >= 50) {
      self.radiation.sound = "item_geigercouner_level3";
    } else if(self.radiation._id_4199 >= 25) {
      self.radiation.sound = "item_geigercouner_level2";
    } else if(self.radiation._id_4199 > 0) {
      self.radiation.sound = "item_geigercouner_level1";
    } else {
      self.radiation.sound = "none";

    }
    wait 0.05;
  }
}

_id_419D() {
  for(;;) {
    if(self.radiation._id_4199 > 25) {
      maps\_utility::_id_13DC("_radiation_poisoning");
    } else {
      maps\_utility::_id_13DE("_radiation_poisoning");

    }
    wait 0.05;
  }
}

_id_419E() {
  wait 0.05;
  var_0 = spawn("script_origin", (0, 0, 0));
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0 linkto(self);
  var_1 = self.radiation.sound;

  for(;;) {
    if(var_1 != self.radiation.sound) {
      var_0 stoploopsound();

      if(isDefined(self.radiation.sound) && self.radiation.sound != "none") {
        var_0 playLoopSound(self.radiation.sound);
      }
    }

    var_1 = self.radiation.sound;
    wait 0.05;
  }
}

_id_419F() {
  var_0 = 0.05;
  var_1 = newclienthudelem(self);
  var_1.fontscale = 1.2;
  var_1.x = 670;
  var_1.y = 350;
  var_1.alignx = "right";
  var_1.label = "";
  var_1.alpha = 0;

  for(;;) {
    var_1.label = self.radiation._id_4199;
    wait(var_0);
  }
}

_id_41A0() {
  var_0 = 0.028;
  var_1 = 100;
  var_2 = 1;
  var_3 = var_1 - var_0;
  var_4 = self.origin;
  var_5 = newclienthudelem(self);
  var_5.fontscale = 1.2;
  var_5.x = 676;
  var_5.y = 360;
  var_5.alpha = 0;
  var_5.alignx = "right";
  var_5.label = &"SCOUTSNIPER_MRHR";
  var_5 thread _id_41A1(self);

  for(;;) {
    if(self.radiation._id_1E43 <= var_0) {
      var_6 = randomfloatrange(-0.001, 0.001);
      var_5 setvalue(var_0 + var_6);
    } else if(self.radiation._id_1E43 > var_1) {
      var_5 setvalue(var_1);
    } else {
      var_5 setvalue(self.radiation._id_1E43);

    }
    wait(var_2);
  }
}

_id_41A1(var_0) {
  var_1 = 0.05;

  for(;;) {
    var_2 = 1;
    var_3 = 0.13;

    while(var_0.radiation._id_1E43 >= 100) {
      if(var_2 <= 0 || var_2 >= 1) {
        var_3 = var_3 * -1;

      }
      var_2 = var_2 + var_3;

      if(var_2 <= 0) {
        var_2 = 0;

      }
      if(var_2 >= 1) {
        var_2 = 1;

      }
      self.color = (1, var_2, var_2);
      wait(var_1);
    }

    self.color = (1, 1, 1);
    wait(var_1);
  }
}

_id_41A2() {
  level endon("special_op_terminated");
  self endon("death");
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("black", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_1 = 1;
  var_2 = 4;
  var_3 = 0.25;
  var_4 = 1;
  var_5 = 25;
  var_6 = 100;
  var_7 = 0;

  for(;;) {
    while(self.radiation._id_419A > 25 && self.radiation._id_4199 > 25) {
      var_8 = var_6 - var_5;
      var_7 = (self.radiation._id_419A - var_5) / var_8;

      if(var_7 < 0) {
        var_7 = 0;
      } else if(var_7 > 1) {
        var_7 = 1;

      }
      var_9 = var_2 - var_1;
      var_10 = var_1 + var_9 * (1 - var_7);
      var_11 = var_4 - var_3;
      var_12 = var_3 + var_11 * var_7;
      var_13 = 7.2 * var_12;
      var_14 = var_7 * 0.5;
      var_15 = 7.2 * var_14;

      if(var_7 == 1) {
        break;
      }

      var_16 = var_10 / 2;
      var_0 fadeinblackout(var_16, var_12, var_13, self);
      var_0 fadeoutblackout(var_16, var_14, var_15, self);
      wait(var_7 * 0.5);
    }

    if(var_7 == 1) {
      break;
    }

    if(var_0.alpha != 0) {
      var_0 fadeoutblackout(1, 0, 0, self);

    }
    wait 0.05;
  }

  var_0 fadeinblackout(2, 1, 6, self);
  thread _id_41A3();
}

_id_41A3() {
  self._id_1EEB = 1;
  self._id_0ECC = 1;
  self._id_1937 = 1;

  if(!maps\_utility::_id_1887()) {
    return;
  }
  waittillframeend;
  var_0 = &"SCRIPT_RADIATION_DEATH";
  setdvar("ui_deadquote", var_0);
}

fadeinblackout(var_0, var_1, var_2, var_3) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  var_3 setblurforplayer(var_2, var_0);
  wait(var_0);
}

fadeoutblackout(var_0, var_1, var_2, var_3) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  var_3 setblurforplayer(var_2, var_0);
  wait(var_0);
}

_id_41A4() {
  self endon("death");

  for(;;) {
    maps\_utility::_id_1654("_radiation_poisoning");

    if(level.script == "scoutsniper" || level.script == "co_scoutsniper") {
      level thread maps\_utility::_id_1255(maps\_utility::_id_11F4, "scoutsniper_mcm_youdaft");

    }
    level notify("radiation_warning");
    maps\_utility::_id_13DB("_radiation_poisoning");
    wait 10;
  }
}