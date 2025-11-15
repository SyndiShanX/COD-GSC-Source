/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3543.gsc
************************/

init() {
  level.var_2850 = [];
  level.var_2850["wave"] = loadfx("vfx\iw7\_requests\mp\trail_kinetic_wave");
  level.var_2850["wedge"] = loadfx("vfx\iw7\_requests\mp\vfx_kinetic_wave_wedge");
  level.var_2850["halo"] = loadfx("vfx\iw7\_requests\mp\vfx_light_barrier_halo");
  level.var_2850["body"] = loadfx("vfx\iw7\_requests\mp\vfx_light_barrier_body");
  level.var_2850["start"] = loadfx("vfx\iw7\_requests\mp\vfx_barrier_start");
  level.var_2850["shot"] = loadfx("vfx\iw7\_requests\mp\vfx_barrier_trail");
  level.var_2850["activate"] = loadfx("vfx\iw7\_requests\mp\vfx_barrier_activate");
}

func_E0D3() {
  self notify("remove_barrier");
}

func_E83A() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_barrier");
  self playlocalsound("kinetic_pulse");
  self playSound("kinetic_pulse_npc");
  thread func_284F();
}

func_284E(param_00, param_01) {
  self endon("disconnect");
  scripts\mp\gamescore::trackbuffassist(param_00, self, "power_barrier");
  var_02 = "j_spinelower";
  var_03 = "body";
  if(param_01) {
    self.var_8BF8 = 1;
    self iprintlnbold("BARRIER AND HEADGEAR APPLIED");
    playFXOnTag(level.var_2850["halo"], self, "j_head");
  }

  self.var_8BD3 = 1;
  self iprintlnbold("BARRIER APPLIED");
  scripts\mp\lightarmor::setlightarmorvalue(self, 35);
  playFXOnTag(level.var_2850[var_03], self, var_02);
  thread func_2852(param_00, param_01);
  while(isDefined(self.lightarmorhp)) {
    wait(0.05);
  }

  thread func_2851(param_00, param_01);
}

func_2851(param_00, param_01) {
  stopFXOnTag(level.var_2850["halo"], self, "j_head");
  stopFXOnTag(level.var_2850["body"], self, "j_spinelower");
  if(param_01) {
    self.var_8BF8 = undefined;
  }

  self.var_8BD3 = undefined;
  scripts\mp\gamescore::untrackbuffassist(param_00, self, "power_barrier");
}

func_2852(param_00, param_01) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("death");
  if(scripts\mp\utility::isreallyalive()) {
    thread func_2851(param_00, param_01);
  }
}

func_284F() {
  var_00 = 0.2;
  var_01 = undefined;
  var_02 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 64));
  var_03 = spawn("script_model", var_02.origin);
  var_03 linkto(var_02);
  scripts\engine\utility::waitframe();
  var_04 = func_68D8(var_02);
  playFXOnTag(level.var_2850["shot"], var_02, "tag_origin");
  var_02 moveto(var_04["position"], var_00);
  wait(var_00);
  if(isDefined(var_04["entity"]) && isplayer(var_04["entity"]) && !isDefined(var_04["entity"].var_8BD3) && var_04["entity"].team == self.team) {
    var_05 = self worldpointinreticle_circle(var_04["entity"] gettagorigin("tag_eye"), 65, 25);
    var_04["entity"] thread func_284E(self, var_05);
    playFX(level.var_2850["activate"], var_04["position"] + (0, 0, 20));
    self notify("powers_barrier_used", 1);
  } else {
    self notify("powers_barrier_used", 0);
  }

  var_03 delete();
  var_02 delete();
}

func_68D8(param_00) {
  var_01 = rotatepointaroundvector(anglestoup(self getplayerangles()), anglesToForward(self getplayerangles()), 0);
  var_02 = self.origin + var_01 * 768;
  var_03 = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(self.team));
  var_04 = scripts\engine\utility::array_combine(var_03, func_7E0D());
  var_05 = scripts\engine\utility::array_add(var_04, self);
  var_06 = scripts\common\trace::sphere_trace(self.origin + (0, 0, 64), var_02, 12, var_05);
  if(!isDefined(var_06) || var_06["hittype"] != "hittype_entity") {
    var_06["position"] = var_02;
  }

  return var_06;
}

func_7E0D() {
  var_00 = [];
  foreach(var_02 in level.participants) {
    if(!isplayer(var_02)) {
      var_00 = scripts\engine\utility::array_add(var_00, var_02);
    }
  }

  return var_00;
}