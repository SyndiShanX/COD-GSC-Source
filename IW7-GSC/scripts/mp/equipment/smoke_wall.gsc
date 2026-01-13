/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\smoke_wall.gsc
***********************************************/

init() {
  level._effect["smokewall"] = loadfx("vfx\iw7\_requests\mp\vfx_smokewall");
  scripts\mp\powerloot::func_DF06("power_smokeWall", ["passive_increased_range", "passive_increased_radius", "passive_increased_duration"]);
}

func_E16E() {
  self notify("remove_smoke_wall");
}

func_1037D(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("remove_smoke_wall");
  var_2 = "power_smokeWall";
  var_3 = self.angles;
  if(isDefined(var_1) && var_1 >= 0.2) {
    var_4 = self.origin;
  } else {
    var_5 = var_1 scripts\engine\utility::waittill_any_return("missile_stuck", "death");
    if(var_5 != "death") {
      var_4 = var_0.origin;
      var_3 = var_0.angles;
      var_6 = anglestoup(var_3) * 64;
      var_4 = var_4 + var_6;
    } else {
      var_7 = scripts\mp\powerloot::func_7FC5("power_smokeWall", 500);
      var_8 = anglesToForward(self.angles) * var_7;
      var_4 = self.origin + var_8;
    }
  }

  thread func_1037C(var_4, self);
  playFX(scripts\engine\utility::getfx("smokewall"), var_4, anglesToForward(var_3), anglestoup(var_3));
  thread scripts\engine\utility::play_sound_in_space("synaptic_smokewall", var_4);
}

func_1037C(var_0, var_1) {
  var_2 = undefined;
  if(level.teambased) {
    var_2 = scripts\mp\utility::getteamarray(scripts\mp\utility::getotherteam(var_1.team));
  } else {
    var_2 = level.characters;
  }

  var_3 = 0;
  foreach(var_5 in var_2) {
    if(!isDefined(var_5) || var_5 == var_1 || !scripts\mp\utility::isreallyalive(var_5)) {
      continue;
    }

    var_6 = var_1 scripts\mp\powerloot::func_7FC4("power_smokeWall", 65536);
    if(distance2dsquared(var_0, var_5.origin) > var_6) {
      continue;
    }

    var_7 = scripts\common\trace::create_contents(0, 1, 1, 0, 0, 0, 0);
    var_8 = physics_raycast(var_0, var_5 getEye(), var_7, undefined, 0, "physicsquery_closest");
    if(isDefined(var_8) && var_8.size > 0) {
      continue;
    }

    var_9 = var_1 scripts\mp\powerloot::func_7FC1("power_smokeWall", 1);
    if(var_5 giveperks(var_0) >= 0.75) {
      var_5 shellshock("flashbang_mp", var_9);
    }

    if(!var_5 scripts\mp\utility::_hasperk("specialty_noplayertarget") && !var_5 scripts\mp\utility::_hasperk("specialty_incog")) {
      var_5 thread func_E48C(var_1);
      var_5 scripts\mp\hud_message::showmiscmessage("spotted");
    }

    var_3++;
  }

  if(var_3 == 0) {
    var_1 iprintlnbold("No Threats Detected");
    return;
  }

  var_1 iprintlnbold(var_3 + " Threats Detected");
}

func_E48C(var_0) {
  self endon("disconnect");
  thread scripts\mp\killstreaks\_emp_common::func_5AA9();
  var_1 = scripts\mp\utility::outlineenableforplayer(self, "orange", var_0, 0, 0, "level_script");
  var_2 = var_0 scripts\mp\powerloot::func_7FC1("power_smokeWall", 1.15);
  scripts\engine\utility::waittill_any_timeout_1(var_2, "death");
  if(isDefined(var_0)) {
    scripts\mp\utility::outlinedisable(var_1, self);
  }
}