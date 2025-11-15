/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3544.gsc
************************/

init() {
  level._effect["battery_pulse"] = loadfx("vfx\iw7\_requests\mp\vfx_battery_pulse");
  level._effect["battery_target"] = loadfx("vfx\iw7\_requests\mp\vfx_battery_pulse_target");
  level._effect["battery_screen"] = loadfx("vfx\iw7\_requests\mp\vfx_battery_pulse_screen");
  level._effect["battery_cooldown"] = loadfx("vfx\iw7\_requests\mp\vfx_battery_pulse_cooldown");
}

func_E83B(param_00) {
  if(!isagent(self)) {
    scripts\mp\powers::power_modifycooldownrate(2);
    thread func_139AC(param_00);
    thread func_139AB(4, "stop_battery_linger");
    thread func_CEE7("battery_cooldown", 0.1, 4, 1, "stop_battery_linger");
    if(isDefined(self) && isDefined(param_00)) {
      scripts\mp\gamescore::trackbuffassist(param_00, self, "power_battery");
    }
  }
}

func_139AB(param_00, param_01, param_02) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_1(param_00, "death");
  if(!isDefined(param_02)) {
    self notify(param_01);
    return;
  }

  self notify(param_01, param_02);
}

func_139AC(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("stop_battery_linger");
  scripts\mp\powers::func_D74E();
  self.var_28C7 = undefined;
  if(isDefined(self) && isDefined(param_00)) {
    scripts\mp\gamescore::untrackbuffassist(self, param_00, "power_battery");
  }
}

func_CEE7(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("death");
  self endon("disconnect");
  self endon(param_04);
  level endon("game_ended");
  if(!isDefined(param_03) || !param_03) {
    var_07 = self.origin;
    if(isDefined(param_05)) {
      var_07 = self gettagorigin(param_05);
    }

    var_08 = spawn("script_model", var_07);
    var_08 setModel("tag_origin");
    var_08 linkto(self, "tag_origin", (0, 0, 0), (90, 0, 0));
    var_08 thread scripts\mp\utility::delayentdelete(param_02);
    for(;;) {
      playfxontagforclients(scripts\engine\utility::getfx(param_00), var_08, "tag_origin", param_06);
      wait(param_01);
    }

    return;
  }

  for(;;) {
    var_09 = spawnfxforclient(scripts\engine\utility::getfx(param_00), self gettagorigin("tag_eye"), self);
    triggerfx(var_09);
    var_09 thread scripts\mp\utility::delayentdelete(param_01);
    wait(param_01);
  }
}