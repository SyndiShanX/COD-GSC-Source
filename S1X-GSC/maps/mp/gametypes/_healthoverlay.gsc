/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_healthoverlay.gsc
***************************************************/

#include maps\mp\_utility;

init() {
  level.healthOverlayCutoff = 0.55;

  regenTime = 5;
  regenTime = maps\mp\gametypes\_tweakables::getTweakableValue("player", "healthregentime");

  level.playerHealth_RegularRegenDelay = regenTime * 1000;

  level.healthRegenDisabled = (level.playerHealth_RegularRegenDelay <= 0);

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread onPlayerSpawned();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self thread playerHealthRegen();

    self VisionSetThermalForPlayer(game["thermal_vision"]);
  }
}

playerHealthRegen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("goliath_equipped");
  self endon("faux_spawn");
  level endon("game_ended");

  if(self.health <= 0) {
    assert(!isalive(self));
    return;
  }

  veryHurt = false;
  hurtTime = 0;

  thread playerPainBreathingSound();

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, damage_type);

    if(self.health <= 0) {
      return;
    }

    hurtTime = getTime();
    healthRatio = self.health / self.maxHealth;

    if(!isDefined(self.healthRegenLevel)) {
      self.regenSpeed = 1;
    } else if(self.healthRegenLevel == .33) {
      self.regenSpeed = .75;
    } else if(self.healthRegenLevel == .66) {
      self.regenSpeed = .50;
    } else if(self.healthRegenLevel == .99) {
      self.regenSpeed = .30;
    } else {
      self.regenSpeed = 1;
    }

    if(healthRatio <= level.healthOverlayCutoff) {
      self.atBrinkOfDeath = true;
    }

    self thread healthRegeneration(hurtTime, healthRatio);
    self thread breathingManager(hurtTime, healthRatio, damage, damage_type);
  }

}

breathingManager(hurtTime, healthRatio, damage, damage_type) {
  self notify("breathingManager");
  self endon("breathingManager");

  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  if(self isUsingRemote() || self isInRemoteTransition()) {
    return;
  }

  if(!IsPlayer(self)) {
    return;
  }

  if((isDefined(damage_type) && damage_type != "MOD_FALLING") || (isDefined(damage) && damage > 1)) {
    playDamageSound(hurtTime);
  }

  self.breathingStopTime = hurtTime + (3000 * self.regenSpeed);

  wait(7 * self.regenSpeed);

  if(!level.gameEnded && isDefined(self.atBrinkOfDeath) && self.atBrinkOfDeath == true) {
    if(!self maps\mp\killstreaks\_juggernaut::get_is_in_mech()) {
      if(self HasFemaleCustomizationModel()) {
        self playLocalSound("deaths_door_exit_female");
      } else {
        self playLocalSound("deaths_door_exit");
      }
    }
    self.atBrinkOfDeath = false;
  }
}

playDamageSound(hurtTime) {
  if(isDefined(level.customPlayDamageSound)) {
    self thread[[level.customPlayDamageSound]](hurtTime);
    return;
  }

  if(isDefined(self.damage_sound_time) && self.damage_sound_time + 5000 > hurtTime) {
    return;
  }

  self.damage_sound_time = hurtTime;
  rand = RandomIntRange(1, 8);

  if(!self maps\mp\killstreaks\_juggernaut::get_is_in_mech()) {
    if(self.team == "axis") {
      if(self HasFemaleCustomizationModel()) {
        self playSound("generic_pain_enemy_fm_" + rand);
      } else {
        self playSound("generic_pain_enemy_" + rand);
      }
    } else {
      if(self HasFemaleCustomizationModel()) {
        self playSound("generic_pain_friendly_fm_" + rand);
      } else {
        self playSound("generic_pain_friendly_" + rand);
      }
    }
  }
}

healthRegeneration(hurtTime, healthRatio) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");

  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("goliath_equipped");
  level endon("game_ended");

  if(level.healthRegenDisabled) {
    return;
  }

  if(!isDefined(self.ignoreRegenDelay)) {
    self.ignoreRegenDelay = false;
  }

  if(self.ignoreRegenDelay == false) {
    wait((level.playerHealth_RegularRegenDelay / 1000) * self.regenSpeed);
  } else {
    self.ignoreRegenDelay = false;
  }

  if(healthRatio < .55) {
    wasVeryHurt = true;
  } else {
    wasVeryHurt = false;
  }

  for(;;) {
    if(self.regenSpeed == .75) {
      wait(.2);
      if(self.health < self.maxHealth) {
        self.health += 5;
      } else {
        break;
      }
    } else if(self.regenSpeed == .50) {
      wait(0.05);
      if(self.health < self.maxHealth) {
        self.health += 2;
      } else {
        break;
      }
    } else if(self.regenSpeed == .30) {
      wait(0.15);
      if(self.health < self.maxHealth) {
        self.health += 40;
      } else {
        break;
      }
    } else if(!isDefined(self.regenSpeed) || self.regenSpeed == 1) {
      wait(0.05);

      if(self.health < self.maxHealth) {
        self.health += 1;
        healthRatio = self.health / self.maxHealth;
      } else {
        break;
      }
    }

    if(self.health > self.maxHealth) {
      self.health = self.maxHealth;
    }
  }

  self maps\mp\gametypes\_damage::resetAttackerList();

  if(wasVeryHurt) {
    self maps\mp\gametypes\_missions::healthRegenerated();
  }
}

wait_for_not_using_remote() {
  self notify("waiting_to_stop_remote");
  self endon("waiting_to_stop_remote");

  self endon("death");
  level endon("game_ended");

  self waittill("stopped_using_remote");

  self revertVisionSetForPlayer(0);
}

playerPainBreathingSound() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(GetDvarInt("virtuallobbyactive", 0)) {
    return;
  }

  if(!IsPlayer(self)) {
    return;
  }

  wait(3);

  for(;;) {
    wait(0.2);

    if(self.health <= 0) {
      return;
    }

    if(self.health >= self.maxhealth * 0.55) {
      continue;
    }

    if(level.healthRegenDisabled && gettime() > self.breathingStopTime) {
      continue;
    }

    if(self isUsingRemote() || self isInRemoteTransition()) {
      continue;
    }

    if(!self maps\mp\killstreaks\_juggernaut::get_is_in_mech()) {
      if(self HasFemaleCustomizationModel()) {
        self playLocalSound("deaths_door_mp_female");
      } else {
        self playLocalSound("deaths_door_mp_male");
      }
    }

    wait(1.284);
    wait(0.1 + randomfloat(0.8));
  }
}