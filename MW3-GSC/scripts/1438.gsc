/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1438.gsc
**************************************/

main() {
  setdvarifuninitialized("debug_vehiclegod", "off");
  setdvarifuninitialized("debug_vehicleplayerhealth", "off");
  setdvarifuninitialized("player_vehicle_dismountable", "off");
  precacheshader("tank_shell");
  level._id_43D3 = 0;
}

_id_43D4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  } else if(var_0) {
    if(getDvar("player_vehicle_dismountable") == "off") {
      self makeunusable();
    }
  }

  self endon("death");
  self endon("stop_vehicle_wait");

  while(self.health > 0) {
    if(!var_0) {
      self waittill("trigger");
    } else {
      var_0 = 0;
      self useby(level.player);
    }

    var_1 = self getvehicleowner();

    if(isDefined(var_1) && isPlayer(var_1)) {
      thread _id_43DA();
    } else {
      thread _id_43D5();
    }
    if(var_0) {
      break;
    }

    wait 0.05;
  }
}

_id_43D5() {
  level._id_43D3 = 0;
  level._id_284F = level._id_2A51;
  level notify("player exited vehicle");

  if(isDefined(level.player._id_43D6)) {
    level.player.threatbias = level.player._id_43D6;
    level.player._id_43D6 = undefined;
  }

  if(isDefined(level._id_43D7)) {
    level._id_43D7 destroy();
  }
  if(isDefined(level._id_43D8)) {
    level._id_43D8 destroy();
  }
  if(isDefined(level._id_43D9)) {
    level._id_43D9 destroy();
  }
}

_id_43DA() {
  level._id_43D3 = 1;
  level._id_284F = self;
  thread _id_43DF();
}

_id_43DB() {
  _id_43DD();
}

_id_43DC() {
  _id_43DD();
}

_id_43DD() {
  var_0 = maps\_utility::_id_229D();

  if(var_0 == "easy") {
    self.health = 3000;
  } else if(var_0 == "medium") {
    self.health = 2500;
  } else if(var_0 == "hard") {
    self.health = 2000;
  } else if(var_0 == "fu") {
    self.health = 1300;
  } else {
    self.health = 2000;
  }
  if(isDefined(self._id_163B)) {
    self.health = self.health + self._id_163B;
    self._id_29A1 = self.health;
    self.maxhealth = self.health;
  }
}

_id_43DE() {
  level endon("player exited vehicle");
  self endon("death");

  for(var_0 = level.player.health; isalive(level.player); level.player.health = level.player.health + int(var_1 * 0.2)) {
    level.player waittill("damage", var_1);

    if(self.health <= 0) {
      level.player kill((0, 0, 0));
    }
  }
}

_id_43DF() {
  level endon("player exited vehicle");
  self endon("no_regen_health");
  self endon("death");
  thread _id_43E2();
  self._id_43E0 = self.health;

  switch (maps\_utility::_id_229D()) {
    case "gimp":
      var_0 = 100;
      var_1 = 2700;
      break;
    case "easy":
      var_0 = 75;
      var_1 = 2700;
      break;
    case "medium":
      var_0 = 50;
      var_1 = 2700;
      break;
    case "hard":
      var_0 = 30;
      var_1 = 3700;
      break;
    case "fu":
      var_0 = 20;
      var_1 = 4700;
      break;
    default:
      var_0 = 50;
      var_1 = 2700;
      break;
  }

  if(self.vehicletype == "crusader_player") {
    self setModel("vehicle_crusader2_viewmodel");
  }
  var_2 = gettime();

  if(getDvar("debug_vehiclegod") != "off") {
    for(;;) {
      self waittill("damage");
      self.health = self.maxhealth;
    }
  }

  thread _id_43E3();
  var_3 = gettime();

  for(;;) {
    if(self._id_43E1) {
      if(getDvar("debug_vehicleplayerhealth") != "off") {
        iprintlnbold("playervehicles health: ", self.health - self._id_163B);
      }
      self._id_43E1 = 0;
      var_2 = gettime() + var_1;
    }

    var_4 = gettime();

    if(self.health < self._id_43E0 && var_4 > var_2 && var_4 > var_3) {
      if(self.health + var_0 > self._id_43E0) {
        self.health = self._id_43E0;
      } else {
        self.health = self.health + var_0;
      }
      var_3 = gettime() + 250;

      if(getDvar("debug_vehicleplayerhealth") != "off") {
        iprintlnbold("playervehicles health: ", self.health - self._id_163B);
      }
    }

    wait 0.05;
  }
}

_id_43E2() {
  level endon("player exited vehicle");
  self waittill("death");
  level.player enablehealthshield(0);

  for(;;) {
    level.player kill();
    wait 0.1;
  }

  wait 0.5;
  level.player enablehealthshield(1);
}

_id_43E3() {
  self._id_43E1 = 0;
  self endon("death");

  for(;;) {
    self waittill("damage", var_0);
    self._id_43E1 = 1;
  }
}

_id_43E4() {
  for(;;) {
    self waittill("turret_fire");
    wait 0.5;
    self playSound("tank_reload");
  }
}

_id_43E5() {
  if(getDvar("player_vehicle_dismountable") != "off") {
    return;
  }
  level endon("player exited vehicle");
  level.player endon("death");
  self endon("death");

  if(isDefined(level._id_43D9)) {
    level._id_43D9 destroy();
  }
  level._id_43D9 = newhudelem();
  level._id_43D9.x = -32;
  level._id_43D9.y = -64;
  level._id_43D9.alignx = "center";
  level._id_43D9.aligny = "middle";
  level._id_43D9.horzalign = "right";
  level._id_43D9.vertalign = "bottom";
  level._id_43D9 setshader("tank_shell", 64, 64);
  var_0 = 1;
  level._id_43D9.alpha = var_0;

  for(;;) {
    if(var_0) {
      if(!self isturretready()) {
        var_0 = 0;
        level._id_43D9.alpha = var_0;
      }
    } else if(self isturretready()) {
      var_0 = 1;
      level._id_43D9.alpha = var_0;
    }

    wait 0.05;
  }
}

_id_2334() {
  self endon("death");
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("splatter_alt_sp", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_1 = self.health - self._id_163B;
  var_2 = 0;
  var_3 = 0.3;

  for(;;) {
    var_4 = (self.health - self._id_163B) / var_1;
    var_5 = 0.5 + 0.5 * var_4;

    if(var_4 < 0.75 || var_2) {
      if(!var_2) {
        var_2 = 1;
      }
      var_6 = 1.0 - var_4 + var_3;
      var_0 fadeovertime(0.05);
      var_0.alpha = var_6;
      wait 0.1;
      var_0 fadeovertime(var_5 * 0.2);
      var_0.alpha = var_6 * 0.5;
      wait(var_5 * 0.2);
      var_0 fadeovertime(var_5 * 0.3);
      var_0.alpha = var_6 * 0.3;
      wait(var_5 * 0.3);
      var_4 = (self.health - self._id_163B) / var_1;
      var_5 = 0.3 + 0.7 * var_4;

      if(var_4 > 0.9) {
        var_2 = 0;
        var_0 fadeovertime(0.5);
        var_0.alpha = 0;
        wait(var_5 * 0.5 - 0.1);
      } else {
        wait(var_5 * 0.5 - 0.1);
      }
      continue;
    }

    wait 0.05;
  }
}