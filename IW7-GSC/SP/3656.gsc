/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3656.gsc
************************/

func_5AD1(param_00) {
  scripts\engine\utility::flag_init("allow_double_jump");
  scripts\engine\utility::flag_set("allow_double_jump");
  notifyoncommand("jump", "+gostand");
  notifyoncommand("jump", "+moveup");
  if(!isDefined(param_00)) {
    param_00 = 60;
  }

  setsaveddvar("jump_height", param_00);
  self.var_AD32 = undefined;
  self.var_5AD4 = undefined;
  for(;;) {
    self waittill("jump");
    var_01 = scripts\common\trace::ray_trace(self.origin + (0, 0, 1), self.origin - (0, 0, getdvarint("jump_height")), self, scripts\common\trace::create_default_contents(0));
    var_01 = bulletTrace(self.origin + (0, 0, 1), self.origin - (0, 0, getdvarint("jump_height")), 0, self);
    var_02 = var_01["fraction"] < 0.3;
    if(var_02 || isDefined(self.var_4D93) || !scripts\engine\utility::flag("allow_double_jump")) {
      wait(0.25);
      continue;
    }

    self.var_5AD4 = 1;
    var_03 = self getnormalizedmovement();
    var_04 = scripts\engine\utility::spawn_tag_origin();
    var_04.origin = self.origin;
    var_04.angles = self.angles;
    var_05 = getdvarint("g_speed") * 0.6;
    var_06 = self getvelocity();
    var_06 = (var_06[0] * 0.4, var_06[1] * 0.4, clamp(var_06[2], 0, 30));
    thread scripts\sp\utility::func_D2CD(50, 0.1);
    var_07 = 4;
    var_08 = 600;
    var_09 = self getplayerangles() - vectortoangles(var_03);
    var_09 = (min(0, var_09[0]), var_09[1], 0);
    var_0A = anglesToForward(var_09) * var_05 * min(1, length(var_03));
    var_0A = var_0A + var_06;
    var_07 = 0.6;
    var_04 moveslide((0, 0, 30), 30, var_0A * 1.5 + (0, 0, var_08));
    earthquake(0.1, var_07 * 0.5, self.origin, 512);
    self setstance("stand");
    thread scripts\sp\utility::play_sound_on_entity("player_jet");
    self playerlinkto(var_04, "tag_origin", 1);
    earthquake(0.3, 0.75, self.origin, 256);
    self.var_AD32 = var_04;
    wait(var_07);
    if(isDefined(self.var_AD32) && self.var_AD32 == var_04) {
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
    var_00 = bulletTrace(self.origin + (0, 0, 1), self.origin - (0, 0, getdvarint("jump_height")), 0, self);
    var_01 = var_00["fraction"] < 0.2;
    if(var_01) {
      self notify("landed_on_ground");
    }

    wait(0.2);
  }
}