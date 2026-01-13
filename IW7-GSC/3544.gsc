/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3544.gsc
*********************************************/

init() {
  level._effect["battery_pulse"] = loadfx("vfx\iw7\_requests\mp\vfx_battery_pulse");
  level._effect["battery_target"] = loadfx("vfx\iw7\_requests\mp\vfx_battery_pulse_target");
  level._effect["battery_screen"] = loadfx("vfx\iw7\_requests\mp\vfx_battery_pulse_screen");
  level._effect["battery_cooldown"] = loadfx("vfx\iw7\_requests\mp\vfx_battery_pulse_cooldown");
}

func_E83B(var_0) {
  if(!isagent(self)) {
    scripts\mp\powers::power_modifycooldownrate(2);
    thread func_139AC(var_0);
    thread func_139AB(4, "stop_battery_linger");
    thread func_CEE7("battery_cooldown", 0.1, 4, 1, "stop_battery_linger");
    if(isDefined(self) && isDefined(var_0)) {
      scripts\mp\gamescore::trackbuffassist(var_0, self, "power_battery");
    }
  }
}

func_139AB(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_1(var_0, "death");
  if(!isDefined(var_2)) {
    self notify(var_1);
    return;
  }

  self notify(var_1, var_2);
}

func_139AC(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("stop_battery_linger");
  scripts\mp\powers::func_D74E();
  self.var_28C7 = undefined;
  if(isDefined(self) && isDefined(var_0)) {
    scripts\mp\gamescore::untrackbuffassist(self, var_0, "power_battery");
  }
}

func_CEE7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("disconnect");
  self endon(var_4);
  level endon("game_ended");
  if(!isDefined(var_3) || !var_3) {
    var_7 = self.origin;
    if(isDefined(var_5)) {
      var_7 = self gettagorigin(var_5);
    }

    var_8 = spawn("script_model", var_7);
    var_8 setModel("tag_origin");
    var_8 linkto(self, "tag_origin", (0, 0, 0), (90, 0, 0));
    var_8 thread scripts\mp\utility::delayentdelete(var_2);
    for(;;) {
      playfxontagforclients(scripts\engine\utility::getfx(var_0), var_8, "tag_origin", var_6);
      wait(var_1);
    }

    return;
  }

  for(;;) {
    var_9 = spawnfxforclient(scripts\engine\utility::getfx(var_0), self gettagorigin("tag_eye"), self);
    triggerfx(var_9);
    var_9 thread scripts\mp\utility::delayentdelete(var_1);
    wait(var_1);
  }
}