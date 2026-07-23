/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ny_hind_ai.gsc
***************************************/

_id_4531(var_0) {
  if(var_0 == "delay") {
    return 0.2;
  } else if(var_0 == "delay_range") {
    return 0.5;
  } else if(var_0 == "burst") {
    return 0.5;
  } else {
    return 1.5;
  }
}

_id_4532() {
  self waittill("death");
  self.origin delete();
  self.origin = undefined;
}

_id_4534() {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  level.player_hind endon("death");
  self.origin = common_scripts\utility::spawn_tag_origin();
  thread _id_4532();
  var_0 = self.origin;
  var_0.origin = level.player_hind.origin;
  var_1 = 0;
  self.main_turret["around_dangle"] = 6.0;
  self.main_turret["around_radius"] = 120;
  self.main_turret["target"] = var_0;
  self.main_turret["aimspeed"] = 80;

  for(;;) {
    var_2 = 0.5 * (level.player getEye() + level.player.origin);
    var_3 = var_2 - self.origin;
    var_3 = vectorNormalize(var_3);
    var_4 = maps\_shg_common::vectorcross(var_3, (0, 0, 1));
    var_5 = cos(var_1);
    var_6 = sin(var_1);
    var_7 = var_5 * var_4 + var_6 * (0, 0, 1);
    var_0.origin = var_2 + self.main_turret["around_radius"] * var_7;
    var_1 = var_1 + self.main_turret["around_dangle"];

    if(var_1 > 360) {
      var_1 = var_1 - 360;
    }
    wait 0.05;
  }
}

_id_4536() {
  if(!isDefined(self)) {
    return;
  }
  self.main_turret["target"] = level.player;
  self.main_turret["mintimebtnfires"] = 0.1;
  self.main_turret["maxtimebtnfires"] = 0.5;
  self.main_turret["aimspeed"] = 80;
  self.main_turret["aimcount"] = 120;
  self.main_turret["sweepspeed"] = 10;
  self.main_turret["sweepcount"] = 0;
  self.main_turret["delay"] = 0.0;
  self.main_turret["delayrange"] = 0.1;
  self.main_turret["burst"] = 0.5;
  self.main_turret["burstrange"] = 1.5;
  self notify("turretstatechange");
}

_id_4537() {
  if(!isDefined(self)) {
    return;
  }
  self.main_turret["delay"] = 120.0;
  self.main_turret["delayrange"] = 0.1;
  self.main_turret["burst"] = 0.0;
  self.main_turret["burstrange"] = 0.0;
  self.main_turret["mintimebtnfires"] = 10000;
  self.main_turret["maxtimebtnfires"] = 10000;
  self notify("turretstatechange");
}

_id_4538() {
  self endon("death");
  self endon("stop_ai");
  _id_453A();
  thread _id_4539();
  thread _id_453C();

  for(;;) {
    var_0 = randomfloatrange(self.main_turret["mintimebtnfires"], self.main_turret["maxtimebtnfires"]);
    wait(var_0);
    self._id_44D4 = 1;
    self waittill("turretstatechange");
    wait 0.05;
  }
}

_id_4539() {
  self endon("death");
  self endon("stop_ai");
  self endon("stop_burst_fire_unmanned");
  var_0 = gettime();
  var_1 = "start";
  self._id_44D4 = 0;

  for(;;) {
    var_2 = (var_0 - gettime()) * 0.001;

    if(self._id_44D4 && var_2 <= 0) {
      if(var_1 != "fire") {
        var_1 = "fire";
        thread _id_453E();
      }

      var_2 = self.main_turret["burst"] + randomfloat(self.main_turret["burstrange"]);
      thread _id_453F(var_2);
      self waittill("turretstatechange");
      var_2 = self.main_turret["delay"] + randomfloat(self.main_turret["delayrange"]);
      var_0 = gettime() + int(var_2 * 1000);
      continue;
    }

    if(var_1 != "aim") {
      var_1 = "aim";
    }
    if(var_2 <= 0) {
      var_2 = 0.1;
    }
    thread _id_453F(var_2);
    self waittill("turretstatechange");
  }
}

_id_453A() {
  if(!isDefined(self)) {
    return;
  }
  self.main_turret["mintimebtnfires"] = 0.5;
  self.main_turret["maxtimebtnfires"] = 4;
  self.main_turret["aimspeed"] = 40;
  self.main_turret["aimcount"] = 120;
  self.main_turret["sweepspeed"] = 10;
  self.main_turret["sweepcount"] = 60;
  self.main_turret["state"] = "aiming";
  self.main_turret["oldstate"] = "xxxx";
  self.main_turret["delay"] = 0.2;
  self.main_turret["delayrange"] = 0.5;
  self.main_turret["burst"] = 0.5;
  self.main_turret["burstrange"] = 1.5;
  self.main_turret["target"] = level.player;
}

_id_453B(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self.main_turret["state"] = var_0;
}

_id_453C() {
  self endon("stop_ai");

  if(!isDefined(self.main_turret)) {
    return;
  }
  self endon("death");
  var_0 = anglesToForward(self.angles);
  var_1 = self.origin + 1200 * var_0;
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    self setturrettargetvec(var_1);

    if(self.main_turret["oldstate"] != self.main_turret["state"]) {
      var_2 = 0;
      self.main_turret["oldstate"] = self.main_turret["state"];
    }

    var_2++;

    if(self.main_turret["state"] == "sweeping") {
      var_5 = distance(level.player.origin, self.origin);
      var_0 = anglesToForward(self.angles);
      var_6 = self.origin + var_5 * var_0;
      var_7 = var_6 - var_1;
      var_5 = distance(var_6, var_1);
      var_7 = vectorNormalize(var_7);

      if(var_5 > self.main_turret["aimspeed"]) {
        var_5 = self.main_turret["aimspeed"];
      }
      var_1 = var_1 + var_5 * var_7;

      if(var_2 > self.main_turret["sweepcount"]) {
        var_2 = 0;
        self.main_turret["state"] = "aiming";
      }
    } else if(self.main_turret["state"] == "aiming") {
      var_8 = self.main_turret["target"];

      if(!isDefined(var_8) || isai(var_8) && !isalive(var_8)) {
        self.main_turret["state"] = "idle";
        continue;
      }

      if(isai(var_8) || isPlayer(var_8)) {
        var_6 = 0.5 * (var_8 getEye() + var_8.origin);
      } else {
        var_6 = var_8.origin;
      }
      var_7 = var_6 - var_1;
      var_5 = distance(var_6, var_1);
      var_7 = vectorNormalize(var_7);

      if(var_5 > self.main_turret["aimspeed"]) {
        var_5 = self.main_turret["aimspeed"];
      }
      var_1 = var_1 + var_5 * var_7;

      if(var_2 > self.main_turret["aimcount"]) {
        var_2 = 0;
        self.main_turret["state"] = "sweeping";
      }
    } else {
      var_0 = anglesToForward(self.angles);
      var_1 = self.origin + 1200 * var_0;
      var_2 = 0;
    }

    wait 0.05;
  }
}

_id_453D() {
  self waittill("turretstatechange");
  self._id_44D4 = 0;
}

_id_453E() {
  self endon("death");
  self endon("stop_ai");
  self endon("turretstatechange");
  thread _id_453D();
  var_0 = "hind_turret";

  for(;;) {
    self setvehweapon(var_0);
    self fireweapon();
    self._id_44D4 = 1;
    wait 0.1;
  }
}

_id_453F(var_0) {
  if(var_0 <= 0) {
    return;
  }
  self endon("turretstatechange");
  self endon("stop_ai");
  wait(var_0);

  if(isDefined(self)) {
    self notify("turretstatechange");
  }
}