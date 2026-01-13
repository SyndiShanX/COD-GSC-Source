/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3556.gsc
*********************************************/

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
  var_0 = func_4D88(self);
  var_1 = func_4D8C(self, var_0);
  self.powers["power_dash"].var_19 = 0;
  return var_1;
}

func_4D91(var_0) {
  return var_0 isonground() == 0 && var_0 getstance() != "prone";
}

func_4D88(var_0) {
  var_1 = var_0 getnormalizedmovement();
  var_2 = anglestoright(var_0.angles);
  var_3 = anglesToForward(var_0.angles);
  var_4 = var_3 * var_1[0] + var_2 * var_1[1];
  var_5 = var_0.origin + var_4 * 175;
  return var_0 aiphysicstrace(var_0.origin + (0, 0, 20), var_5, 16, 80, 0, 0);
}

func_4D8C(var_0, var_1) {
  var_2 = lengthsquared(var_0.origin - var_1);
  if(var_2 < 576) {
    return 0;
  }

  var_3 = var_0 scripts\engine\utility::spawn_tag_origin();
  thread func_4D89(var_0, var_3);
  func_4D8D(var_0, var_1, var_3);
  var_0 notify("dash_finished");
  return 1;
}

func_4D8D(var_0, var_1, var_2) {
  var_3 = var_0.origin - var_1;
  var_4 = lengthsquared(var_3);
  var_5 = self getentityvelocity();
  var_6 = 0;
  if(var_4 >= 28224) {
    var_6 = 1;
  }

  if(var_0 isonground()) {
    var_0 setstance("crouch");
  }

  var_0 playerlinkto(var_2, "tag_origin");
  func_4D8F("dash_dust");
  self playlocalsound("synaptic_dash");
  self playSound("synaptic_dash_npc");
  var_2 moveto(var_1, 0.35, 0.01, 0);
  wait(0.35);
  if(0) {
    var_0 func_4D87();
  }

  wait(0.1);
  var_0 setvelocity(var_5 * 1.2);
  var_0 unlink();
  var_0 setstance("stand");
}

func_4D8E() {
  self endon("disconnect");
  playFXOnTag(scripts\engine\utility::getfx("dash_trail"), self, "TAG_EYE");
  wait(0.35);
  stopFXOnTag(scripts\engine\utility::getfx("dash_trail"), self, "TAG_EYE");
}

func_4D87() {
  var_0 = [];
  foreach(var_2 in level.characters) {
    if(!isDefined(var_2) || !isalive(var_2) || !scripts\mp\utility::isenemy(var_2)) {
      continue;
    }

    if(distancesquared(var_2.origin, self.origin) < 254016) {
      var_0[var_0.size] = var_2;
    }
  }

  if(isDefined(var_0[0])) {
    var_0 = sortbydistance(var_0, self.origin);
    var_4 = var_0[0];
    var_5 = self gettagorigin("TAG_EYE");
    var_6 = var_4.origin;
    var_7 = vectortoangles(var_4.origin - self.origin);
    self setplayerangles(var_7);
  }
}

func_4D89(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any_3("death", "disconnect", "dash_finished");
  scripts\engine\utility::waitframe();
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_4D92(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("death");
  wait(var_1);
  return 1;
}

func_4D8F(var_0) {
  thread func_4D8E();
  var_1 = (235.004, 521.706, 1.95469);
  var_2 = (270, 0, 0);
  var_3 = anglestoup(var_2);
  var_4 = anglesToForward(var_2);
  var_5 = spawnfxforclient(level._effect[var_0], var_1, self, var_4, var_3);
  triggerfx(var_5);
  wait(0.05);
  var_5 delete();
}