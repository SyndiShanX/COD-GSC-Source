/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3656.gsc
************************/

func_5AD1(var_0) {
  scripts\engine\utility::flag_init("allow_double_jump");
  scripts\engine\utility::flag_set("allow_double_jump");
  notifyoncommand("jump", "+gostand");
  notifyoncommand("jump", "+moveup");
  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  setsaveddvar("jump_height", var_0);
  self.var_AD32 = undefined;
  self.var_5AD4 = undefined;
  for(;;) {
    self waittill("jump");
    var_1 = scripts\common\trace::ray_trace(self.origin + (0, 0, 1), self.origin - (0, 0, getdvarint("jump_height")), self, scripts\common\trace::create_default_contents(0));
    var_1 = bulletTrace(self.origin + (0, 0, 1), self.origin - (0, 0, getdvarint("jump_height")), 0, self);
    var_2 = var_1["fraction"] < 0.3;
    if(var_2 || isDefined(self.var_4D93) || !scripts\engine\utility::flag("allow_double_jump")) {
      wait(0.25);
      continue;
    }

    self.var_5AD4 = 1;
    var_3 = self getnormalizedmovement();
    var_4 = scripts\engine\utility::spawn_tag_origin();
    var_4.origin = self.origin;
    var_4.angles = self.angles;
    var_5 = getdvarint("g_speed") * 0.6;
    var_6 = self getvelocity();
    var_6 = (var_6[0] * 0.4, var_6[1] * 0.4, clamp(var_6[2], 0, 30));
    thread scripts\sp\utility::func_D2CD(50, 0.1);
    var_7 = 4;
    var_8 = 600;
    var_9 = self getplayerangles() - vectortoangles(var_3);
    var_9 = (min(0, var_9[0]), var_9[1], 0);
    var_0A = anglesToForward(var_9) * var_5 * min(1, length(var_3));
    var_0A = var_0A + var_6;
    var_7 = 0.6;
    var_4 moveslide((0, 0, 30), 30, var_0A * 1.5 + (0, 0, var_8));
    earthquake(0.1, var_7 * 0.5, self.origin, 512);
    self setstance("stand");
    thread scripts\sp\utility::play_sound_on_entity("player_jet");
    self playerlinkto(var_4, "tag_origin", 1);
    earthquake(0.3, 0.75, self.origin, 256);
    self.var_AD32 = var_4;
    wait(var_7);
    if(isDefined(self.var_AD32) && self.var_AD32 == var_4) {
      self setvelocity(var_0A + (0, 0, 50));
      self unlink();
      self.var_AD32 = undefined;
    }

    var_0B = 0.5;
    thread scripts\sp\utility::func_D2CD(100, var_0B);
    thread func_C144();
    self waittill("landed_on_ground");
    self.var_5AD4 = undefined;
    wait(var_0B);
  }
}

func_C144() {
  self notify("notify_on_landing");
  self endon("notify_on_landing");
  for(;;) {
    var_0 = bulletTrace(self.origin + (0, 0, 1), self.origin - (0, 0, getdvarint("jump_height")), 0, self);
    var_1 = var_0["fraction"] < 0.2;
    if(var_1) {
      self notify("landed_on_ground");
    }

    wait(0.2);
  }
}