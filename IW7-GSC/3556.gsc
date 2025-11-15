/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3556.gsc
************************/

init() {
  level._effect["slam_sml"] = loadfx("vfx\old\_requests\archetypes\vfx_heavy_slam_s");
  level._effect["slam_lrg"] = loadfx("vfx\old\_requests\archetypes\vfx_heavy_slam_l");
  level._effect["dash_dust"] = loadfx("vfx\core\screen\vfx_scrnfx_tocam_slidedust_m");
  level._effect["dash_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_dash_trail");
}

setusepriority() {}

func_E0E9() {
  self notify("removeDash");
}

func_4D90() {
  if(isbot(self)) {
    return;
  }

  self endon("removeDash");
  self endon("death");
  self endon("disconnect");
  self.powers["power_dash"].var_19 = 1;
  var_00 = func_4D88(self);
  var_01 = func_4D8C(self, var_00);
  self.powers["power_dash"].var_19 = 0;
  return var_01;
}

func_4D91(param_00) {
  return param_00 isonground() == 0 && param_00 getstance() != "prone";
}

func_4D88(param_00) {
  var_01 = param_00 getnormalizedmovement();
  var_02 = anglestoright(param_00.angles);
  var_03 = anglesToForward(param_00.angles);
  var_04 = var_03 * var_01[0] + var_02 * var_01[1];
  var_05 = param_00.origin + var_04 * 175;
  return param_00 aiphysicstrace(param_00.origin + (0, 0, 20), var_05, 16, 80, 0, 0);
}

func_4D8C(param_00, param_01) {
  var_02 = lengthsquared(param_00.origin - param_01);
  if(var_02 < 576) {
    return 0;
  }

  var_03 = param_00 scripts\engine\utility::spawn_tag_origin();
  thread func_4D89(param_00, var_03);
  func_4D8D(param_00, param_01, var_03);
  param_00 notify("dash_finished");
  return 1;
}

func_4D8D(param_00, param_01, param_02) {
  var_03 = param_00.origin - param_01;
  var_04 = lengthsquared(var_03);
  var_05 = self getentityvelocity();
  var_06 = 0;
  if(var_04 >= 28224) {
    var_06 = 1;
  }

  if(param_00 isonground()) {
    param_00 setstance("crouch");
  }

  param_00 playerlinkto(param_02, "tag_origin");
  func_4D8F("dash_dust");
  self playlocalsound("synaptic_dash");
  self playSound("synaptic_dash_npc");
  param_02 moveto(param_01, 0.35, 0.01, 0);
  wait(0.35);
  if(0) {
    param_00 func_4D87();
  }

  wait(0.1);
  param_00 setvelocity(var_05 * 1.2);
  param_00 unlink();
  param_00 setstance("stand");
}

func_4D8E() {
  self endon("disconnect");
  playFXOnTag(scripts\engine\utility::getfx("dash_trail"), self, "TAG_EYE");
  wait(0.35);
  stopFXOnTag(scripts\engine\utility::getfx("dash_trail"), self, "TAG_EYE");
}

func_4D87() {
  var_00 = [];
  foreach(var_02 in level.characters) {
    if(!isDefined(var_02) || !isalive(var_02) || !scripts\mp\utility::isenemy(var_02)) {
      continue;
    }

    if(distancesquared(var_02.origin, self.origin) < 254016) {
      var_00[var_00.size] = var_02;
    }
  }

  if(isDefined(var_00[0])) {
    var_00 = sortbydistance(var_00, self.origin);
    var_04 = var_00[0];
    var_05 = self gettagorigin("TAG_EYE");
    var_06 = var_04.origin;
    var_07 = vectortoangles(var_04.origin - self.origin);
    self setplayerangles(var_07);
  }
}

func_4D89(param_00, param_01) {
  param_00 scripts\engine\utility::waittill_any_3("death", "disconnect", "dash_finished");
  scripts\engine\utility::waitframe();
  if(isDefined(param_01)) {
    param_01 delete();
  }
}

func_4D92(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("death");
  wait(param_01);
  return 1;
}

func_4D8F(param_00) {
  thread func_4D8E();
  var_01 = (235.004, 521.706, 1.95469);
  var_02 = (270, 0, 0);
  var_03 = anglestoup(var_02);
  var_04 = anglesToForward(var_02);
  var_05 = spawnfxforclient(level._effect[param_00], var_01, self, var_04, var_03);
  triggerfx(var_05);
  wait(0.05);
  var_05 delete();
}