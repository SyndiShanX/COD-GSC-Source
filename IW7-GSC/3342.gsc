/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3342.gsc
************************/

init() {
  level.kinetic_pulse_fx = [];
  level.kinetic_pulse_fx["spark"] = loadfx("vfx\iw7\_requests\mp\vfx_kinetic_pulse_shock");
  level.kinetic_pulse_fx["blast"] = loadfx("vfx\iw7\_requests\mp\vfx_kinetic_pulse_blast");
}

func_E133() {
  self notify("remove_kinetic_pulse");
}

func_E85E() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_kinetic_pulse");
  playFX(level.kinetic_pulse_fx["blast"], self.origin);
  self playlocalsound("kinetic_pulse");
  self playSound("kinetic_pulse_npc");
  var_00 = undefined;
  if(level.teambased) {
    var_00 = scripts\cp\utility::getteamarray(scripts\cp\utility::getotherteam(self.team));
  } else {
    var_00 = level.characters;
  }

  foreach(var_02 in var_00) {
    if(!isDefined(var_02) || var_02 == self || !scripts\cp\utility::isreallyalive(var_02)) {
      continue;
    }

    if(distance2dsquared(self.origin, var_02.origin) < 100000 && isplayer(var_02)) {
      var_02 thread func_A6D4(self);
    }
  }

  self notify("powers_kinetic_pulse_cooldown_start");
}

func_A6D4(param_00) {
  self endon("disconnect");
  var_01 = level.powers["power_kineticPulse"].var_5FF3;
  self shellshock("concussion_grenade_mp", 1);
  self.stunned = 1;
  if(isDefined(level.scriptablestatefunc)) {
    self thread[[level.scriptablestatefunc]](self);
  }

  scripts\engine\utility::waittill_any_timeout_1(var_01, "death");
  self.stunned = undefined;
}

func_A6D5() {
  var_00 = gettime() + level.powers["power_kineticPulse"].var_5FF3 * 1000;
  scripts\cp\powers\coop_powers::power_modifycooldownrate(0);
  while(gettime() < var_00) {
    wait(0.1);
  }

  scripts\cp\powers\coop_powers::func_D74E();
}