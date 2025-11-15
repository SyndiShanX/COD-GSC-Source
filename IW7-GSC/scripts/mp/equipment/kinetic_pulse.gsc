/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\kinetic_pulse.gsc
**************************************************/

kineticpulse_use() {
  self setscriptablepartstate("kineticPulse", "activeWarmUp");
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(0.5, "death", "disconnect");
  if(!isDefined(self)) {
    return;
  }

  if(!scripts\mp\utility::isreallyalive(self)) {
    self setscriptablepartstate("kineticPulse", "neutral");
    return;
  }

  self iprintlnbold("Kinetic Pulse Activated");
  self setclientomnvar("ui_hud_shake", 1);
  self setscriptablepartstate("kineticPulse", "activeFire");
  var_00 = [];
  var_01 = 0.05;
  var_02 = 120;
  var_03 = 200;
  var_04 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
  var_05 = self gettagorigin("j_spineupper");
  for(var_06 = 0; var_06 < 5; var_06++) {
    var_07 = undefined;
    if(level.teambased && !level.friendlyfire) {
      var_07 = scripts\mp\utility::clearscrambler(var_05, var_03, scripts\mp\utility::getotherteam(self.team), undefined);
    } else {
      var_07 = scripts\mp\utility::clearscrambler(var_05, var_03, undefined, self);
    }

    foreach(var_09 in var_07) {
      var_0A = var_09 getentitynumber();
      if(isDefined(var_00[var_0A])) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_09)) {
        continue;
      }

      if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_09)) {
        continue;
      }

      var_0B = var_05;
      var_0C = var_09.origin;
      var_0D = physics_raycast(var_0B, var_0C, var_04, undefined, 0, "physicsquery_closest", 1);
      if(isDefined(var_0D) && var_0D.size > 0) {
        var_0C = var_09 getEye();
        var_0D = physics_raycast(var_0B, var_0C, var_04, undefined, 0, "physicsquery_closest", 1);
        if(isDefined(var_0D) && var_0D.size > 0) {
          continue;
        }
      }

      var_00[var_0A] = var_09;
      kineticpulse_playereffects(var_09, var_05);
    }

    var_07 = scripts\mp\weapons::getempdamageents(var_05, var_03, 0);
    foreach(var_09 in var_07) {
      if(!isDefined(var_09)) {
        continue;
      }

      var_0A = var_09 getentitynumber();
      if(isDefined(var_00[var_0A])) {
        continue;
      }

      if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_09)) {
        continue;
      }

      var_10 = var_09;
      if(isDefined(var_09.triggerportableradarping)) {
        var_10 = var_09.triggerportableradarping;
      }

      if(!scripts\mp\weapons::friendlyfirecheck(self, var_10) && var_10 != self) {
        continue;
      }

      var_00[var_0A] = var_09;
      kineticpulse_nonplayereffects(var_09, var_05);
    }

    var_03 = var_03 + var_02;
    wait(var_01);
  }
}

kineticpulse_playereffects(param_00, param_01) {
  thread kineticpulse_playerconcuss(param_00);
  thread kineticpulse_playeremp(param_00);
  param_00 dodamage(1, param_01, self, self, "MOD_EXPLOSIVE", "kineticpulse_mp");
}

kineticpulse_playerconcuss(param_00) {
  scripts\mp\gamescore::func_11ACE(self, param_00, "kineticpulse_concuss_mp");
  var_01 = scripts\mp\perks\_perkfunctions::applystunresistence(self, param_00, 5);
  param_00 shellshock("concussion_grenade_mp", var_01);
  param_00 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(var_01, "death", "disconnect");
  if(isDefined(param_00) && scripts\mp\utility::isreallyalive(param_00)) {
    if(isDefined(self)) {
      scripts\mp\gamescore::untrackdebuffassist(self, param_00, "kineticpulse_concuss_mp");
    }
  }
}

kineticpulse_playeremp(param_00) {
  if(!scripts\mp\killstreaks\_emp_common::func_FFC5()) {
    scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
    return;
  }

  scripts\mp\gamescore::func_11ACE(self, param_00, "kineticpulse_emp_mp");
  param_00 scripts\mp\killstreaks\_emp_common::func_20C3();
  param_00 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(5, "death", "disconnect");
  if(isDefined(param_00) && scripts\mp\utility::isreallyalive(param_00)) {
    if(isDefined(self)) {
      scripts\mp\gamescore::untrackdebuffassist(self, param_00, "kineticpulse_emp_mp");
    }

    param_00 scripts\mp\killstreaks\_emp_common::func_E0F3();
  }
}

kineticpulse_nonplayereffects(param_00, param_01) {
  param_00 notify("emp_damage", self, 5, param_01, "kineticpulse_emp_mp", "MOD_EXPLOSIVE");
}

isplayertaggedbykineticpulse(param_00) {
  var_01 = scripts\mp\gamescore::getdebuffattackersbyweapon(param_00, "kineticpulse_concuss_mp");
  if(isDefined(var_01) && scripts\engine\utility::array_contains(var_01, self)) {
    return 1;
  }

  var_01 = scripts\mp\gamescore::getdebuffattackersbyweapon(param_00, "kineticpulse_emp_mp");
  if(isDefined(var_01) && scripts\engine\utility::array_contains(var_01, self)) {
    return 1;
  }

  return 0;
}