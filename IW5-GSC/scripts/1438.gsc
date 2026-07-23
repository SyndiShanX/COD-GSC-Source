/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1438.gsc
**************************************/

main() {
  setdvarifuninitialized("debug_vehiclegod", "off");
  setdvarifuninitialized("debug_vehicleplayerhealth", "off");
  setdvarifuninitialized("player_vehicle_dismountable", "off");
  precacheshader("tank_shell");
  level.playeronvehicle = 0;
}

vehicle_wait(var_0) {
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
      thread vehicle_enter();
    } else {
      thread vehicle_exit();
    }
    if(var_0) {
      break;
    }

    wait 0.05;
  }
}

vehicle_exit() {
  level.playeronvehicle = 0;
  level.playervehicle = level.playervehiclenone;
  level notify("player exited vehicle");

  if(isDefined(level.player.oldthreatbias)) {
    level.player.threatbias = level.player.oldthreatbias;
    level.player.oldthreatbias = undefined;
  }

  if(isDefined(level.vehiclehud)) {
    level.vehiclehud destroy();
  }
  if(isDefined(level.vehiclehud2)) {
    level.vehiclehud2 destroy();
  }
  if(isDefined(level.vehiclefireicon)) {
    level.vehiclefireicon destroy();
  }
}

vehicle_enter() {
  level.playeronvehicle = 1;
  level.playervehicle = self;
  thread vehicle_ridehandle();
}

setup_vehicle_tank() {
  vehicle_givehealth();
}

setup_vehicle_other() {
  vehicle_givehealth();
}

vehicle_givehealth() {
  var_0 = maps\_utility::getdifficulty();

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
  if(isDefined(self.healthbuffer)) {
    self.health = self.health + self.healthbuffer;
    self.currenthealth = self.health;
    self.maxhealth = self.health;
  }
}

protect_player() {
  level endon("player exited vehicle");
  self endon("death");

  for(var_0 = level.player.health; isalive(level.player); level.player.health = level.player.health + int(var_1 * 0.2)) {
    level.player waittill("damage", var_1);

    if(self.health <= 0) {
      level.player kill((0, 0, 0));
    }
  }
}

vehicle_ridehandle() {
  level endon("player exited vehicle");
  self endon("no_regen_health");
  self endon("death");
  thread vehicle_kill_player_ondeath();
  self.maximumhealth = self.health;

  switch (maps\_utility::getdifficulty()) {
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

  thread vehicle_damageset();
  var_3 = gettime();

  for(;;) {
    if(self.damaged) {
      if(getDvar("debug_vehicleplayerhealth") != "off") {
        iprintlnbold("playervehicles health: ", self.health - self.healthbuffer);
      }
      self.damaged = 0;
      var_2 = gettime() + var_1;
    }

    var_4 = gettime();

    if(self.health < self.maximumhealth && var_4 > var_2 && var_4 > var_3) {
      if(self.health + var_0 > self.maximumhealth) {
        self.health = self.maximumhealth;
      } else {
        self.health = self.health + var_0;
      }
      var_3 = gettime() + 250;

      if(getDvar("debug_vehicleplayerhealth") != "off") {
        iprintlnbold("playervehicles health: ", self.health - self.healthbuffer);
      }
    }

    wait 0.05;
  }
}

vehicle_kill_player_ondeath() {
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

vehicle_damageset() {
  self.damaged = 0;
  self endon("death");

  for(;;) {
    self waittill("damage", var_0);
    self.damaged = 1;
  }
}

vehicle_reloadsound() {
  for(;;) {
    self waittill("turret_fire");
    wait 0.5;
    self playSound("tank_reload");
  }
}

vehicle_hud_tank_fireicon() {
  if(getDvar("player_vehicle_dismountable") != "off") {
    return;
  }
  level endon("player exited vehicle");
  level.player endon("death");
  self endon("death");

  if(isDefined(level.vehiclefireicon)) {
    level.vehiclefireicon destroy();
  }
  level.vehiclefireicon = newhudelem();
  level.vehiclefireicon.x = -32;
  level.vehiclefireicon.y = -64;
  level.vehiclefireicon.alignx = "center";
  level.vehiclefireicon.aligny = "middle";
  level.vehiclefireicon.horzalign = "right";
  level.vehiclefireicon.vertalign = "bottom";
  level.vehiclefireicon setshader("tank_shell", 64, 64);
  var_0 = 1;
  level.vehiclefireicon.alpha = var_0;

  for(;;) {
    if(var_0) {
      if(!self isturretready()) {
        var_0 = 0;
        level.vehiclefireicon.alpha = var_0;
      }
    } else if(self isturretready()) {
      var_0 = 1;
      level.vehiclefireicon.alpha = var_0;
    }

    wait 0.05;
  }
}

healthoverlay() {
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
  var_1 = self.health - self.healthbuffer;
  var_2 = 0;
  var_3 = 0.3;

  for(;;) {
    var_4 = (self.health - self.healthbuffer) / var_1;
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
      var_4 = (self.health - self.healthbuffer) / var_1;
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