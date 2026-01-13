/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  var_0 = [];
  var_1 = 0.05;
  var_2 = 120;
  var_3 = 200;
  var_4 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
  var_5 = self gettagorigin("j_spineupper");
  for(var_6 = 0; var_6 < 5; var_6++) {
    var_7 = undefined;
    if(level.teambased && !level.friendlyfire) {
      var_7 = scripts\mp\utility::clearscrambler(var_5, var_3, scripts\mp\utility::getotherteam(self.team), undefined);
    } else {
      var_7 = scripts\mp\utility::clearscrambler(var_5, var_3, undefined, self);
    }

    foreach(var_9 in var_7) {
      var_0A = var_9 getentitynumber();
      if(isDefined(var_0[var_0A])) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_9)) {
        continue;
      }

      if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_9)) {
        continue;
      }

      var_0B = var_5;
      var_0C = var_9.origin;
      var_0D = physics_raycast(var_0B, var_0C, var_4, undefined, 0, "physicsquery_closest", 1);
      if(isDefined(var_0D) && var_0D.size > 0) {
        var_0C = var_9 getEye();
        var_0D = physics_raycast(var_0B, var_0C, var_4, undefined, 0, "physicsquery_closest", 1);
        if(isDefined(var_0D) && var_0D.size > 0) {
          continue;
        }
      }

      var_0[var_0A] = var_9;
      kineticpulse_playereffects(var_9, var_5);
    }

    var_7 = scripts\mp\weapons::getempdamageents(var_5, var_3, 0);
    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_0A = var_9 getentitynumber();
      if(isDefined(var_0[var_0A])) {
        continue;
      }

      if(!scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_9)) {
        continue;
      }

      var_10 = var_9;
      if(isDefined(var_9.triggerportableradarping)) {
        var_10 = var_9.triggerportableradarping;
      }

      if(!scripts\mp\weapons::friendlyfirecheck(self, var_10) && var_10 != self) {
        continue;
      }

      var_0[var_0A] = var_9;
      kineticpulse_nonplayereffects(var_9, var_5);
    }

    var_3 = var_3 + var_2;
    wait(var_1);
  }
}

kineticpulse_playereffects(var_0, var_1) {
  thread kineticpulse_playerconcuss(var_0);
  thread kineticpulse_playeremp(var_0);
  var_0 dodamage(1, var_1, self, self, "MOD_EXPLOSIVE", "kineticpulse_mp");
}

kineticpulse_playerconcuss(var_0) {
  scripts\mp\gamescore::func_11ACE(self, var_0, "kineticpulse_concuss_mp");
  var_1 = scripts\mp\perks\_perkfunctions::applystunresistence(self, var_0, 5);
  var_0 shellshock("concussion_grenade_mp", var_1);
  var_0 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(var_1, "death", "disconnect");
  if(isDefined(var_0) && scripts\mp\utility::isreallyalive(var_0)) {
    if(isDefined(self)) {
      scripts\mp\gamescore::untrackdebuffassist(self, var_0, "kineticpulse_concuss_mp");
    }
  }
}

kineticpulse_playeremp(var_0) {
  if(!scripts\mp\killstreaks\_emp_common::func_FFC5()) {
    scripts\mp\damagefeedback::updatedamagefeedback("hiticonempimmune", undefined, undefined, undefined, 1);
    return;
  }

  scripts\mp\gamescore::func_11ACE(self, var_0, "kineticpulse_emp_mp");
  var_0 scripts\mp\killstreaks\_emp_common::func_20C3();
  var_0 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(5, "death", "disconnect");
  if(isDefined(var_0) && scripts\mp\utility::isreallyalive(var_0)) {
    if(isDefined(self)) {
      scripts\mp\gamescore::untrackdebuffassist(self, var_0, "kineticpulse_emp_mp");
    }

    var_0 scripts\mp\killstreaks\_emp_common::func_E0F3();
  }
}

kineticpulse_nonplayereffects(var_0, var_1) {
  var_0 notify("emp_damage", self, 5, var_1, "kineticpulse_emp_mp", "MOD_EXPLOSIVE");
}

isplayertaggedbykineticpulse(var_0) {
  var_1 = scripts\mp\gamescore::getdebuffattackersbyweapon(var_0, "kineticpulse_concuss_mp");
  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_1, self)) {
    return 1;
  }

  var_1 = scripts\mp\gamescore::getdebuffattackersbyweapon(var_0, "kineticpulse_emp_mp");
  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_1, self)) {
    return 1;
  }

  return 0;
}