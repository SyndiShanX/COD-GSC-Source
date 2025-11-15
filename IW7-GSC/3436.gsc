/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3436.gsc
************************/

func_97D0() {}

applyarchetype() {}

removearchetype() {
  self notify("removeArchetype");
}

func_98AD() {
  level._effect["adrenaline_worldFX"] = loadfx("vfx\iw7\_requests\mp\vfx_adrenaline_world_view");
}

func_261D() {
  self endon("death");
  self endon("disconnect");
  self endon("removeArchetype");
  self setclientomnvar("ui_aura_regen", 0);
  for(;;) {
    self waittill("got_a_kill");
    foreach(var_01 in level.players) {
      if(var_01 != self) {
        if(!level.teambased) {
          continue;
        }

        if(var_01.team != self.team) {
          continue;
        }

        if(distance2dsquared(var_01.origin, self.origin) > 147456) {
          continue;
        }
      }

      var_01 thread func_2617(self);
    }
  }
}

func_2617(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(self != param_00) {
    param_00 thread scripts\mp\utility::giveunifiedpoints("buff_teammate");
  }

  self playlocalsound("mp_overcharge_on");
  self setclientomnvar("ui_aura_regen", 1);
  thread func_261A(2);
  var_01 = gettime();
  thread func_261B(var_01, 0.6);
  wait(0.6);
  var_01 = gettime();
  thread func_261C(var_01, 1.4);
}

func_261B(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("force_regeneration");
  scripts\mp\utility::giveperk("specialty_adrenaline");
  var_02 = anglestoup(self.angles);
  var_03 = anglesToForward(self.angles);
  var_04 = param_00 + param_01 * 1000;
  while(gettime() < var_04) {
    playFX(scripts\engine\utility::getfx("adrenaline_worldFX"), self.origin + (0, 0, 25), var_03, var_02);
    wait(0.1);
  }

  scripts\mp\utility::removeperk("specialty_adrenaline");
}

func_261C(param_00, param_01) {
  self endon("death");
  self endon("damage");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility::giveperk("specialty_adrenaline_lite");
  thread func_2618(param_01);
  thread func_2619(param_01);
  var_02 = anglestoup(self.angles);
  var_03 = anglesToForward(self.angles);
  var_04 = param_00 + param_01 * 1000;
  while(gettime() < var_04) {
    var_05 = playFX(scripts\engine\utility::getfx("adrenaline_worldFX"), self.origin + (0, 0, 25), var_03, var_02);
    var_05 hidefromplayer(self);
    wait(0.1);
  }

  scripts\mp\utility::removeperk("specialty_adrenaline_lite");
}

func_2618(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_01 = scripts\engine\utility::waittill_any_timeout_1(param_00, "damage");
  if(isDefined(var_01) && var_01 == "damage") {
    scripts\mp\utility::removeperk("specialty_adrenaline_lite");
  }
}

func_2619(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("auraRegen_cleanupLuaDamagePublic");
  self endon("auraRegen_cleanupLuaDamagePublic");
  var_01 = scripts\engine\utility::waittill_any_timeout_1(param_00, "damage");
  self setclientomnvar("ui_aura_regen", 0);
  self notify("auraRegen_cleanupLuaDeathPublic");
}

func_261A(param_00) {
  self endon("disconnect");
  self notify("auraRegen_cleanupLuaDeathPublic");
  self endon("auraRegen_cleanupLuaDeathPublic");
  var_01 = scripts\engine\utility::waittill_any_timeout_1(param_00, "death");
  self setclientomnvar("ui_aura_regen", 0);
  self notify("auraRegen_cleanupLuaDamagePublic");
}

func_56E7() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("removeArchetype");
  for(;;) {
    self waittill("melee_fired");
    var_00 = anglesToForward(self getplayerangles());
    playFX(scripts\engine\utility::getfx("disruptor_punch"), self gettagorigin("tag_eye"), var_00);
    self playlocalsound("kinetic_pulse");
    foreach(var_02 in level.players) {
      if(var_02.team != self.team && distance2d(self.origin, var_02.origin) < 512 && istargetingoff(var_02) && scripts\common\trace::ray_trace_passed(self getEye(), var_02 getEye(), undefined, scripts\common\trace::create_contents(0, 1, 1, 1, 0, 1, 0))) {
        if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_02)) {
          var_02 notify("phaseshift_interrupted");
          var_02 scripts\mp\powers::func_C170("powers_phase_shift_update", 0);
        }

        var_03 = anglestoright(self getplayerangles());
        var_04 = rotatepointaroundvector(var_03, var_00, 20);
        var_02 _meth_84DC(var_04, 512);
        var_02 shellshock("concussion_grenade_mp", 2.5, 0, 1);
        var_02 notify("flashbang", var_02.origin, 1, 30, self, 1);
        playFX(scripts\engine\utility::getfx("disruptor_impact"), var_02.origin + (0, 0, 36));
      }
    }
  }
}

istargetingoff(param_00) {
  var_01 = self getplayerangles();
  var_02 = anglesToForward(var_01);
  var_03 = anglestoup(var_01);
  var_04 = anglestoright(var_01);
  var_05 = self getEye() - var_02 * 128;
  if(!scripts\mp\utility::pointvscone(param_00 gettagorigin("tag_eye"), var_05, var_02, var_03, 512, 128, 20)) {
    if(!scripts\mp\utility::pointvscone(param_00 gettagorigin("tag_origin"), var_05, var_02, var_03, 512, 128, 20)) {
      if(!scripts\mp\utility::pointvscone(param_00 gettagorigin("j_mainroot"), var_05, var_02, var_03, 512, 128, 20)) {
        return 0;
      }
    }
  }

  return 1;
}