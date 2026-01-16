/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_healthoverlay.gsc
************************************************/

init() {
  level.mw1_health_regen = 1;
  level.healthoverlaycutoff = 0.55;
  var_0 = 5;
  var_0 = maps\mp\gametypes\_tweakables::gettweakablevalue("player", "healthregentime");
  level.playerhealth_regularregendelay = var_0 * 1000;
  level.healthregendisabled = level.playerhealth_regularregendelay <= 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for (;;) {
    self waittill("spawned_player");
    thread playerhealthregen();
  }
}

playerhealthregen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("goliath_equipped");
  self endon("faux_spawn");
  level endon("game_ended");

  if(self.health <= 0) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  thread playerpainbreathingsound();

  for (;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(self.health <= 0) {
      return;
    }
    var_1 = gettime();
    var_7 = self.health / self.maxhealth;

    if(!isdefined(self.healthregenlevel))
      self.regenspeed = 1;
    else if(self.healthregenlevel == 0.33)
      self.regenspeed = 0.75;
    else if(self.healthregenlevel == 0.66)
      self.regenspeed = 0.5;
    else if(self.healthregenlevel == 0.99)
      self.regenspeed = 0.3;
    else
      self.regenspeed = 1;

    if(var_7 <= level.healthoverlaycutoff)
      self.atbrinkofdeath = 1;

    thread healthregeneration(var_1, var_7);
    thread breathingmanager(var_1, var_7, var_2, var_6);
  }
}

breathingmanager(var_0, var_1, var_2, var_3) {
  self notify("breathingManager");
  self endon("breathingManager");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  if(maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition()) {
    return;
  }
  if(!isplayer(self)) {
    return;
  }
  if(isdefined(var_3) && var_3 != "MOD_FALLING" || isdefined(var_2) && var_2 > 1)
    playdamagesound(var_0);

  if(isdefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  if(isdefined(level.playerdobreathing) && !self[[level.playerdobreathing]]()) {
    return;
  }
  if(level.mw1_health_regen) {
    self.breathingstoptime = var_0 + 6000 * self.regenspeed;
    return;
  }

  self.breathingstoptime = var_0 + 3000 * self.regenspeed;
  wait(7 * self.regenspeed);

  if(!level.gameended && isdefined(self.atbrinkofdeath) && self.atbrinkofdeath == 1) {
    if(self hasfemalecustomizationmodel())
      self playlocalsound("deaths_door_exit_female");
    else
      self playlocalsound("deaths_door_exit");

    self.atbrinkofdeath = 0;
  }
}

playdamagesound(var_0) {
  if(isdefined(level.customplaydamagesound))
    self thread[[level.customplaydamagesound]](var_0);
  else {
    if(isdefined(self.damage_sound_time) && self.damage_sound_time + 5000 > var_0) {
      return;
    }
    self.damage_sound_time = var_0;
    var_1 = randomintrange(1, 8);

    if(self.team == "axis") {
      if(self hasfemalecustomizationmodel())
        self playsound("generic_pain_enemy_fm_" + var_1);
      else
        self playsound("generic_pain_enemy_" + var_1);
    } else {
      if(self hasfemalecustomizationmodel()) {
        self playsound("generic_pain_friendly_fm_" + var_1);
        return;
      }

      self playsound("generic_pain_friendly_" + var_1);
    }
  }
}

healthregeneration(var_0, var_1) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("goliath_equipped");
  level endon("game_ended");

  if(level.healthregendisabled) {
    return;
  }
  if(!isdefined(self.ignoreregendelay))
    self.ignoreregendelay = 0;

  if(self.ignoreregendelay == 0)
    wait(level.playerhealth_regularregendelay / 1000 * self.regenspeed);
  else
    self.ignoreregendelay = 0;

  if(var_1 < 0.55)
    var_2 = 1;
  else
    var_2 = 0;

  for (;;) {
    if(level.mw1_health_regen && !var_2) {
      if(level.mw1_health_regen)
        wait 0.05;

      self.health = self.maxhealth;
      break;
    } else if(self.regenspeed == 0.75) {
      wait 0.2;

      if(self.health < self.maxhealth)
        self.health = self.health + 5;
      else
        break;
    } else if(self.regenspeed == 0.5) {
      wait 0.05;

      if(self.health < self.maxhealth)
        self.health = self.health + 2;
      else
        break;
    } else if(self.regenspeed == 0.3) {
      wait 0.15;

      if(self.health < self.maxhealth)
        self.health = self.health + 40;
      else
        break;
    } else if(!isdefined(self.regenspeed) || self.regenspeed == 1) {
      if(!level.mw1_health_regen)
        wait 0.05;

      if(self.health < self.maxhealth) {
        if(level.mw1_health_regen) {
          self.health = self.health + 10;

          if(self.health > self.maxhealth)
            self.health = self.maxhealth;

          wait 0.05;
        } else
          self.health = self.health + 1;
      } else
        break;
    }

    if(self.health > self.maxhealth)
      self.health = self.maxhealth;
  }

  maps\mp\gametypes\_damage::resetattackerlist();
  maps\mp\gametypes\_missions::healthregenerated();
}

wait_for_not_using_remote() {
  self notify("waiting_to_stop_remote");
  self endon("waiting_to_stop_remote");
  self endon("death");
  level endon("game_ended");
  self waittill("stopped_using_remote");
  maps\mp\_utility::revertvisionsetforplayer(0);
}

playerpainbreathingsound() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(getdvarint("virtuallobbyactive", 0)) {
    return;
  }
  if(!isplayer(self)) {
    return;
  }
  if(isdefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  wait 3;

  for (;;) {
    wait 0.2;

    if(self.health <= 0) {
      return;
    }
    if(self.health >= self.maxhealth * 0.55) {
      continue;
    }
    if(level.healthregendisabled && gettime() > self.breathingstoptime) {
      continue;
    }
    if(maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(self hasfemalecustomizationmodel())
      self playlocalsound("deaths_door_mp_female");
    else
      self playlocalsound("deaths_door_mp_male");

    wait 1.284;
    wait(0.1 + randomfloat(0.8));
  }
}