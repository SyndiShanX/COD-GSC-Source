/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3543.gsc
*********************************************/

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

func_284E(var_0, var_1) {
  self endon("disconnect");
  scripts\mp\gamescore::trackbuffassist(var_0, self, "power_barrier");
  var_2 = "j_spinelower";
  var_3 = "body";
  if(var_1) {
    self.var_8BF8 = 1;
    self iprintlnbold("BARRIER AND HEADGEAR APPLIED");
    playFXOnTag(level.var_2850["halo"], self, "j_head");
  }

  self.var_8BD3 = 1;
  self iprintlnbold("BARRIER APPLIED");
  scripts\mp\lightarmor::setlightarmorvalue(self, 35);
  playFXOnTag(level.var_2850[var_3], self, var_2);
  thread func_2852(var_0, var_1);
  while(isDefined(self.lightarmorhp)) {
    wait(0.05);
  }

  thread func_2851(var_0, var_1);
}

func_2851(var_0, var_1) {
  stopFXOnTag(level.var_2850["halo"], self, "j_head");
  stopFXOnTag(level.var_2850["body"], self, "j_spinelower");
  if(var_1) {
    self.var_8BF8 = undefined;
  }

  self.var_8BD3 = undefined;
  scripts\mp\gamescore::untrackbuffassist(var_0, self, "power_barrier");
}

func_2852(var_0, var_1) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any("death");
  if(scripts\mp\utility::isreallyalive()) {
    thread func_2851(var_0, var_1);
  }
}

func_284F() {
  var_0 = 0.2;
  var_1 = undefined;
  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 64));
  var_3 = spawn("script_model", var_2.origin);
  var_3 linkto(var_2);
  scripts\engine\utility::waitframe();
  var_4 = func_68D8(var_2);
  playFXOnTag(level.var_2850["shot"], var_2, "tag_origin");
  var_2 moveto(var_4["position"], var_0);
  wait(var_0);
  if(isDefined(var_4["entity"]) && isplayer(var_4["entity"]) && !isDefined(var_4["entity"].var_8BD3) && var_4["entity"].team == self.team) {
    var_5 = self worldpointinreticle_circle(var_4["entity"] gettagorigin("tag_eye"), 65, 25);
    var_4["entity"] thread func_284E(self, var_5);
    playFX(level.var_2850["activate"], var_4["position"] + (0, 0, 20));
    self notify("powers_barrier_used", 1);
  } else {
    self notify("powers_barrier_used", 0);
  }

  var_3 delete();
  var_2 delete();
}

func_68D8(var_0) {
  var_1 = rotatepointaroundvector(anglestoup(self getplayerangles()), anglesToForward(self getplayerangles()), 0);
  var_2 = self.origin + var_1 * 768;
  var_3 = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(self.team));
  var_4 = scripts\engine\utility::array_combine(var_3, func_7E0D());
  var_5 = scripts\engine\utility::array_add(var_4, self);
  var_6 = scripts\common\trace::sphere_trace(self.origin + (0, 0, 64), var_2, 12, var_5);
  if(!isDefined(var_6) || var_6["hittype"] != "hittype_entity") {
    var_6["position"] = var_2;
  }

  return var_6;
}

func_7E0D() {
  var_0 = [];
  foreach(var_2 in level.participants) {
    if(!isplayer(var_2)) {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  return var_0;
}