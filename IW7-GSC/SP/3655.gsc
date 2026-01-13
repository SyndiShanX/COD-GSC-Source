/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3655.gsc
************************/

func_4D8A() {
  self.var_4D8B = 1;
  thread func_11ABF();
  self notifyonplayercommand("jump", "+gostand");
  self notifyonplayercommand("jump", "+moveup");
  self.var_4D93 = undefined;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.angles = (0, 0, 0);
  self getwholescenedurationmin(var_0);
  thread func_A4D9();
  while(lib_0E4F::func_9C7B()) {
    while(level.player _meth_8439() || level.player _meth_843B() || level.player gettimeremainingpercentage()) {
      wait(0.05);
    }

    self waittill("juke");
    var_1 = self getnormalizedmovement();
    if(self adsbuttonpressed() || self getstance() == "prone") {
      continue;
    }

    var_2 = scripts\common\trace::ray_trace(self.origin + (0, 0, 1), self.origin - (0, 0, 32), self);
    self.var_4D93 = 1;
    self allowads(0);
    var_3 = scripts\engine\utility::spawn_tag_origin();
    var_3.origin = self.origin;
    var_3.angles = self.angles;
    var_4 = getdvarint("g_speed");
    thread scripts\sp\utility::func_D2CD(50, 0.1);
    self getrawbaseweaponname(0.5, 0.5);
    var_5 = anglestoup(level.player.angles);
    var_6 = undefined;
    var_7 = undefined;
    var_8 = 0;
    if(self _meth_843B()) {
      var_1 = var_5 * -1;
      var_9 = 0.1;
      var_0A = 0.1;
      var_0B = 0.125;
      var_0C = 0.4;
      var_0D = 0.025;
      var_0E = 3000;
      var_8 = 1;
    } else if(self gettimeremainingpercentage()) {
      var_1 = var_5;
      var_9 = 0.1;
      var_0A = 0.1;
      var_0B = 0.125;
      var_0C = 0.4;
      var_0D = 0.025;
      var_0E = 3000;
      var_8 = 1;
    } else if(var_1[0] > 0.7) {
      var_9 = 0.1;
      var_0A = 0.1;
      var_0B = 0.1;
      var_0C = 0.4;
      var_0D = 0.025;
      var_0E = 1;
    } else {
      var_9 = 0.1;
      var_0A = 0.1;
      var_0B = 0.1;
      var_0C = 0.6;
      var_0D = 0.2;
      var_0E = 20000;
    }

    if(var_8 == 1) {
      var_7 = var_1;
    } else {
      var_6 = 125;
      if(var_2["fraction"] > 0.3) {
        var_0F = self getplayerangles() - vectortoangles(var_1);
        var_0F = (min(0, var_0F[0]), var_0F[1], var_0F[2]);
        var_7 = anglesToForward(var_0F) * var_4 * min(1, length(var_1));
        if(isDefined(self.var_5AD4)) {
          var_7 = var_7 * 1.2;
        }

        var_6 = 150;
      } else {
        var_0F = self.angles - vectortoangles(var_2);
        var_7 = anglesToForward(var_0F) * var_4 * min(1, length(var_1));
        var_7 = var_7 - (0, 0, var_7[2]);
      }

      var_3 moveslide((0, 0, 15), 15, var_7 * 0.25 + (0, 0, var_6));
    }

    earthquake(var_0A, var_9 * 0.5, self.origin, 512);
    self setstance("stand");
    if(func_9C57()) {
      self playerlinkto(var_3, "tag_origin", 1);
      earthquake(0.2, 0.3, self.origin, 256);
    } else {
      earthquake(var_0B, var_0C, self.origin, 2048);
      level notify("player_SwimWaterCurrent_lerp_savedDvar");
      var_7 = vectornormalize(var_7);
      setsaveddvar("player_SwimWaterCurrent", var_7 * var_0E);
      if(var_8 != 1) {
        thread func_118C4(var_0, var_7);
      }
    }

    wait(var_9);
    var_10 = self getlinkedparent();
    if(isDefined(var_10) && var_10 == var_3) {
      self setvelocity(var_7 + (0, 0, 50));
      self unlink();
    }

    if(func_9C57()) {
      thread scripts\sp\utility::play_sound_on_entity("land");
      self _meth_80A6();
    } else {
      scripts\engine\utility::delaythread(var_0D, ::func_AB9C, "player_SwimWaterCurrent", (0, 0, 0), 0.5);
    }

    var_3 delete();
    self allowads(1);
    thread scripts\sp\utility::func_D2CD(100, var_0D);
    thread lib_0E48::func_C144();
    if(func_9C57()) {
      self waittill("landed_on_ground");
    }

    wait(var_0D);
    self.var_4D93 = undefined;
  }
}

func_AB9C(var_0, var_1, var_2) {
  var_3 = getdvarvector(var_0);
  var_4 = var_3;
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_5 = 0;
  var_6 = var_1 - var_3;
  var_7 = 0.05 / var_2;
  while(var_5 < 1) {
    var_4 = var_3 + var_5 * var_6;
    setsaveddvar(var_0, var_4);
    var_5 = var_5 + var_7;
    scripts\engine\utility::waitframe();
  }

  setsaveddvar(var_0, var_1);
}

func_11ABF() {
  self notify("track_sprint_button");
  self endon("track_sprint_button");
  while(level.player scripts\sp\utility::func_65DB("player_gravity_off")) {
    var_0 = self getnormalizedmovement();
    var_1 = length(var_0);
    if((self buttonpressed("BUTTON_LSTICK") && var_1 > 0.3) || self _meth_843B() || self gettimeremainingpercentage()) {
      if(self.var_4D8B) {
        self notify("juke");
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_A4D9() {
  while(level.player scripts\sp\utility::func_65DB("player_gravity_off")) {
    self waittill("jump");
    if(self buttonpressed("BUTTON_LSTICK")) {
      while(self buttonpressed("BUTTON_LSTICK")) {
        self notify("track_sprint_button");
        scripts\engine\utility::waitframe();
      }

      thread func_11ABF();
    }
  }
}

func_118C4(var_0, var_1) {
  var_2 = var_1;
  var_3 = anglestoright(self.angles);
  var_4 = var_2 - 2 * var_3 * vectordot(var_2, var_3);
  var_4 = -1 * var_4;
  var_5 = 8;
  var_6 = var_4[0] * var_5;
  var_7 = var_4[1] * -1 * var_5;
  var_8 = 0.25;
  var_0 rotateto((var_6, 0, var_7), var_8, 0, var_8);
  var_0 waittill("rotatedone");
  var_9 = 0.75;
  var_0 rotateto((0, 0, 0), var_9, var_9 * 0.25, var_9 * 0.5);
  var_0 waittill("rotatedone");
}

func_9C57() {
  return !isDefined(self.isent) || !self.isent.var_6F43;
}