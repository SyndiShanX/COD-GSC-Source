/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3573.gsc
*********************************************/

init() {
  scripts\mp\powerloot::func_DF06("power_opticWave", ["passive_increased_duration", "passive_increased_range", "passive_increased_speed"]);
}

func_E145() {
  self notify("remove_optic_wave");
}

func_C6AF() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_optic_wave");
  var_0 = scripts\mp\powerloot::func_7FC6("power_opticWave", 0.8);
  self.powers["power_opticWave"].var_19 = 1;
  self playanimscriptevent("power_active", "opticwave");
  self playlocalsound("ghost_optic_wave");
  thread func_C6AE(var_0);
  func_C6AD(var_0);
  self.powers["power_opticWave"].var_19 = 0;
  scripts\engine\utility::waitframe();
}

func_C6AD(var_0) {
  self endon("death");
  level endon("game_ended");
  if(level.teambased) {
    level.activeuavs[self.team]++;
  } else {
    level.activeuavs[self.guid]++;
  }

  var_1 = 0;
  var_2 = scripts\mp\powerloot::func_7FC5("power_opticWave", 1750);
  foreach(var_4 in level.participants) {
    if(!scripts\mp\utility::isreallyalive(var_4)) {
      continue;
    }

    if(!scripts\mp\utility::isenemy(var_4)) {
      continue;
    }

    if(var_4 scripts\mp\utility::_hasperk("specialty_noplayertarget") || var_4 scripts\mp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }

    var_5 = var_4.origin - self.origin;
    if(1 && vectordot(anglesToForward(self.angles), var_5) < 0) {
      continue;
    }

    var_6 = var_2 * var_2;
    if(length2dsquared(var_5) > var_6) {
      continue;
    }

    if(!self worldpointinreticle_circle(var_4 getEye(), 65, 75)) {
      if(!self worldpointinreticle_circle(var_4.origin, 65, 75)) {
        if(!self worldpointinreticle_circle(var_4 gettagorigin("j_mainroot"), 65, 75)) {
          continue;
        }
      }
    }

    thread func_C7A7(var_4, distance2d(self.origin, var_4.origin) / var_2, var_0);
    var_1 = 1;
  }
}

func_C7A7(var_0, var_1, var_2) {
  wait(var_2 * var_1);
  var_3 = scripts\mp\utility::outlineenableforplayer(var_0, "orange", self, 0, 1, "level_script");
  if(!isai(var_0)) {
    var_0 scripts\mp\utility::_hudoutlineviewmodelenable(5);
  }

  var_4 = scripts\mp\powerloot::func_7FC1("power_opticWave", 1.35);
  func_13AA0(var_3, var_0, var_4);
}

func_13AA0(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death(var_2, "leave");
  if(isDefined(var_1)) {
    scripts\mp\utility::outlinedisable(var_0, var_1);
    if(!isai(var_1)) {
      var_1 scripts\mp\utility::_hudoutlineviewmodeldisable();
    }
  }
}

func_C6AE(var_0) {
  self visionsetnakedforplayer("opticwave_mp", 0);
  var_1 = spawn("script_model", self gettagorigin("tag_eye"));
  var_1 setModel("prop_mp_optic_wave_scr");
  var_1.angles = self getplayerangles();
  var_1 setotherent(self);
  var_1 setscriptablepartstate("effects", "active", 0);
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 1750;
  var_1 moveto(var_2, var_0);
  wait(var_0);
  self visionsetnakedforplayer("", 0.5);
  var_1 delete();
}