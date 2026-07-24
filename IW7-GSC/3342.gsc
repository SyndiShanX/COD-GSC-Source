/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3342.gsc
**************************************/

init() {
  level.kinetic_pulse_fx = [];
  level.kinetic_pulse_fx["spark"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_pulse_shock");
  level.kinetic_pulse_fx["blast"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_pulse_blast");
}

_id_E133() {
  self notify("remove_kinetic_pulse");
}

_id_E85E() {
  self endon("death");
  self endon("disconnect");
  self endon("remove_kinetic_pulse");
  playFX(level.kinetic_pulse_fx["blast"], self.origin);
  self playlocalsound("kinetic_pulse");
  self playSound("kinetic_pulse_npc");
  var_0 = undefined;

  if(level.teambased) {
    var_0 = scripts\cp\utility::getteamarray(scripts\cp\utility::getotherteam(self.team));
  } else {
    var_0 = level.characters;
  }

  foreach(var_2 in var_0) {
    if(!isDefined(var_2) || var_2 == self || !scripts\cp\utility::isreallyalive(var_2)) {
      continue;
    }
    if(distance2dsquared(self.origin, var_2.origin) < 100000 && isPlayer(var_2)) {
      var_2 thread _id_A6D4(self);
    }
  }

  self notify("powers_kinetic_pulse_cooldown_start");
}

_id_A6D4(var_0) {
  self endon("disconnect");
  var_1 = level.powers["power_kineticPulse"]._id_5FF3;
  self shellshock("concussion_grenade_mp", 1.0);
  self.stunned = 1;

  if(isDefined(level.scriptablestatefunc)) {
    self thread[[level.scriptablestatefunc]](self);
  }

  scripts\engine\utility::waittill_any_timeout(var_1, "death");
  self.stunned = undefined;
}

_id_A6D5() {
  var_0 = gettime() + level.powers["power_kineticPulse"]._id_5FF3 * 1000;
  scripts\cp\powers\coop_powers::power_modifycooldownrate(0.0);

  while(gettime() < var_0) {
    wait 0.1;
  }

  scripts\cp\powers\coop_powers::_id_D74E();
}