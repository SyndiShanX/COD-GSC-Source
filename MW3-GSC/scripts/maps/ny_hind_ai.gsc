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
  self._id_4533 delete();
  self._id_4533 = undefined;
}

_id_4534() {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  level._id_4483 endon("death");
  self._id_4533 = common_scripts\utility::spawn_tag_origin();
  thread _id_4532();
  var_0 = self._id_4533;
  var_0.origin = level._id_4483.origin;
  var_1 = 0;
  self._id_4535["around_dangle"] = 6.0;
  self._id_4535["around_radius"] = 120;
  self._id_4535["target"] = var_0;
  self._id_4535["aimspeed"] = 80;

  for(;;) {
    var_2 = 0.5 * (level.player getEye() + level.player.origin);
    var_3 = var_2 - self.origin;
    var_3 = vectornormalize(var_3);
    var_4 = maps\_shg_common::_id_1684(var_3, (0, 0, 1));
    var_5 = cos(var_1);
    var_6 = sin(var_1);
    var_7 = var_5 * var_4 + var_6 * (0, 0, 1);
    var_0.origin = var_2 + self._id_4535["around_radius"] * var_7;
    var_1 = var_1 + self._id_4535["around_dangle"];

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
  self._id_4535["target"] = level.player;
  self._id_4535["mintimebtnfires"] = 0.1;
  self._id_4535["maxtimebtnfires"] = 0.5;
  self._id_4535["aimspeed"] = 80;
  self._id_4535["aimcount"] = 120;
  self._id_4535["sweepspeed"] = 10;
  self._id_4535["sweepcount"] = 0;
  self._id_4535["delay"] = 0.0;
  self._id_4535["delayrange"] = 0.1;
  self._id_4535["burst"] = 0.5;
  self._id_4535["burstrange"] = 1.5;
  self notify("turretstatechange");
}

_id_4537() {
  if(!isDefined(self)) {
    return;
  }
  self._id_4535["delay"] = 120.0;
  self._id_4535["delayrange"] = 0.1;
  self._id_4535["burst"] = 0.0;
  self._id_4535["burstrange"] = 0.0;
  self._id_4535["mintimebtnfires"] = 10000;
  self._id_4535["maxtimebtnfires"] = 10000;
  self notify("turretstatechange");
}

_id_4538() {
  self endon("death");
  self endon("stop_ai");
  _id_453A();
  thread _id_4539();
  thread _id_453C();

  for(;;) {
    var_0 = randomfloatrange(self._id_4535["mintimebtnfires"], self._id_4535["maxtimebtnfires"]);
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

      var_2 = self._id_4535["burst"] + randomfloat(self._id_4535["burstrange"]);
      thread _id_453F(var_2);
      self waittill("turretstatechange");
      var_2 = self._id_4535["delay"] + randomfloat(self._id_4535["delayrange"]);
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
  self._id_4535["mintimebtnfires"] = 0.5;
  self._id_4535["maxtimebtnfires"] = 4;
  self._id_4535["aimspeed"] = 40;
  self._id_4535["aimcount"] = 120;
  self._id_4535["sweepspeed"] = 10;
  self._id_4535["sweepcount"] = 60;
  self._id_4535["state"] = "aiming";
  self._id_4535["oldstate"] = "xxxx";
  self._id_4535["delay"] = 0.2;
  self._id_4535["delayrange"] = 0.5;
  self._id_4535["burst"] = 0.5;
  self._id_4535["burstrange"] = 1.5;
  self._id_4535["target"] = level.player;
}

_id_453B(var_0) {
  if(!isDefined(self)) {
    return;
  }
  self._id_4535["state"] = var_0;
}

_id_453C() {
  self endon("stop_ai");

  if(!isDefined(self._id_4535)) {
    return;
  }
  self endon("death");
  var_0 = anglesToForward(self.angles);
  var_1 = self.origin + 1200 * var_0;
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    self setturrettargetvec(var_1);

    if(self._id_4535["oldstate"] != self._id_4535["state"]) {
      var_2 = 0;
      self._id_4535["oldstate"] = self._id_4535["state"];
    }

    var_2++;

    if(self._id_4535["state"] == "sweeping") {
      var_5 = distance(level.player.origin, self.origin);
      var_0 = anglesToForward(self.angles);
      var_6 = self.origin + var_5 * var_0;
      var_7 = var_6 - var_1;
      var_5 = distance(var_6, var_1);
      var_7 = vectornormalize(var_7);

      if(var_5 > self._id_4535["aimspeed"]) {
        var_5 = self._id_4535["aimspeed"];
      }
      var_1 = var_1 + var_5 * var_7;

      if(var_2 > self._id_4535["sweepcount"]) {
        var_2 = 0;
        self._id_4535["state"] = "aiming";
      }
    } else if(self._id_4535["state"] == "aiming") {
      var_8 = self._id_4535["target"];

      if(!isDefined(var_8) || isai(var_8) && !isalive(var_8)) {
        self._id_4535["state"] = "idle";
        continue;
      }

      if(isai(var_8) || isPlayer(var_8)) {
        var_6 = 0.5 * (var_8 getEye() + var_8.origin);
      } else {
        var_6 = var_8.origin;
      }
      var_7 = var_6 - var_1;
      var_5 = distance(var_6, var_1);
      var_7 = vectornormalize(var_7);

      if(var_5 > self._id_4535["aimspeed"]) {
        var_5 = self._id_4535["aimspeed"];
      }
      var_1 = var_1 + var_5 * var_7;

      if(var_2 > self._id_4535["aimcount"]) {
        var_2 = 0;
        self._id_4535["state"] = "sweeping";
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