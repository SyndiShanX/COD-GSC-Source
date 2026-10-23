/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_healthoverlay.gsc
********************************************************/

init() {
  level.healthoverlaycutoff = 0.55;
  var_0 = 4;
  var_0 = _id_0511::gettweakablevalue("player", "healthregentime");
  level.playerhealth_regularregendelay = var_0 * 1000;
  level.playerhealth_grenadierregendelay = int(max(var_0 - 1, 0) * 1000);
  level._id_73FB = 1.5;
  level._id_4C1E = level.playerhealth_regularregendelay <= 0;
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    thread playerhealthregen();
    thread playerdeathmixmonitor();
    self.breathmute_submix_active = 0;
  }
}

playerhealthregen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("goliath_equipped");
  level endon("game_ended");

  if(self.health <= 0) {
    return;
  }
  if(common_scripts\utility::_id_562E(self._id_4C1E)) {
    return;
  }
  var_0 = 0;
  thread playerpainbreathingsound();

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(self.health <= 0) {
      return;
    }
    var_0 = gettime();
    var_6 = self.health / self.maxhealth;

    if(var_6 <= level.healthoverlaycutoff) {
      self.atbrinkofdeath = 1;
    }

    if(_func_367()) {
      if(isDefined(self._id_5692) && self._id_5692 == 1) {
        thread _id_1BC0(var_0, var_1, var_5);
        return;
      }
    }

    thread _id_4C20();
    thread _id_1BC0(var_0, var_1, var_5);
  }
}

_id_1BC0(var_0, var_1, var_2) {
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
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(var_2) && var_2 != "MOD_FALLING" || isDefined(var_1) && var_1 > 1) {
    playdamagesound(var_0);
  }

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  var_3 = maps\mp\_utility::_hasperk("specialty_fasterhealthregen");
  var_4 = level.playerhealth_regularregendelay;

  if(var_3) {
    var_4 = level.playerhealth_grenadierregendelay;
  }

  if(isDefined(self._id_98E1)) {
    var_4 = self._id_98E1 * 1000;
  }

  self.breathingstoptime = var_0 + 0.6 * var_4;

  if(var_3) {
    wait(var_4 / 1000);
  } else {
    wait(1.4 * (var_4 / 1000));
  }

  if(!level.gameended && isDefined(self.atbrinkofdeath) && self.atbrinkofdeath == 1) {
    self clientclearsoundsubmix("mute_breath");
    self.breathmute_submix_active = 0;
    self.atbrinkofdeath = 0;
  }
}

playdamagesound(var_0) {
  if(isDefined(level.customplaydamagesound)) {
    self thread[[level.customplaydamagesound]](var_0);
    return;
  }

  if(isDefined(self.damage_sound_time) && self.damage_sound_time + 3000 > var_0) {
    return;
  }
  self.damage_sound_time = var_0;
  var_1 = _randomintrange(1, 8);
  self clientaddsoundsubmix("mute_breath");
  self.breathmute_submix_active = 1;

  if(self.team == "axis") {
    if(self hasfemalecustomizationmodel()) {
      self playSound("generic_pain_enemy_fm_" + var_1, "pain_sound_done");
    } else {
      self playSound("generic_pain_enemy_" + var_1, "pain_sound_done");
    }
  } else if(self hasfemalecustomizationmodel())
    self playSound("generic_pain_friendly_fm_" + var_1, "pain_sound_done");
  else {
    self playSound("generic_pain_friendly_" + var_1, "pain_sound_done");
  }

  self waittill("pain_sound_done");

  if(!common_scripts\utility::_id_562E(self.atbrinkofdeath)) {
    self clientclearsoundsubmix("mute_breath");
    self.breathmute_submix_active = 0;
  }
}

_id_4C20() {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("goliath_equipped");
  level endon("game_ended");

  if(level._id_4C1E) {
    return;
  }
  if(maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight") && (!isDefined(self._id_50A0) || !self._id_50A0)) {
    return;
  }
  var_0 = isDefined(self.atbrinkofdeath) && self.atbrinkofdeath;
  var_1 = maps\mp\_utility::_hasperk("specialty_fasterhealthregen");
  var_2 = level.playerhealth_regularregendelay;

  if(var_1) {
    var_2 = level.playerhealth_grenadierregendelay;
  }

  if(isDefined(self._id_98E1)) {
    var_2 = self._id_98E1 * 1000;
  }

  if(!isDefined(self._id_50A0) || !self._id_50A0) {
    if(maps\mp\_utility::_id_585F()) {
      common_scripts\utility::waittill_notify_or_timeout("immediateHealthRegen", var_2 / 1000);
    } else {
      wait(var_2 / 1000);
    }
  } else
    self._id_50A0 = 0;

  if(var_1) {
    if(self.health < self.maxhealth) {}

    self.health = self.maxhealth;
  } else {
    var_3 = _float(self.health);

    for(;;) {
      waitframe();
      var_4 = level._id_73FB;

      if(isDefined(self._id_98E2)) {
        var_4 = self._id_98E2;
      }

      var_5 = self.maxhealth;

      if(self.health < var_5) {
        var_3 = var_3 + var_4;
        self.health = int(var_3);

        if(self.health > var_5) {
          self.health = var_5;
        }

        continue;
      }

      break;
    }
  }

  maps\mp\gametypes\_damage::resetattackerlist();

  if(var_0) {
    self notify("recovery_battlecry");
    maps\mp\gametypes\_missions::healthregeneratedbrinkofdeath();
  } else
    maps\mp\gametypes\_missions::_id_4C1F();
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

  if(getdvarint("4017", 0)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  wait 3;

  for(;;) {
    wait 0.2;

    if(self.health <= 0) {
      return;
    }
    if(self.health >= self.maxhealth * level.healthoverlaycutoff) {
      continue;
    }
    if(level._id_4C1E && (!isDefined(self.breathingstoptime) || gettime() > self.breathingstoptime)) {
      continue;
    }
    if(maps\mp\_utility::isusingremote() || maps\mp\_utility::isinremotetransition()) {
      continue;
    }
    if(self._id_165B) {
      continue;
    }
    if(!common_scripts\utility::_id_562E(self.breathmute_submix_active)) {
      self clientaddsoundsubmix("mute_breath");
      self.breathmute_submix_active = 1;
    }

    if(self hasfemalecustomizationmodel()) {
      self playlocalsound("deaths_door_mp_female");
    } else {
      self playlocalsound("deaths_door_mp_male");
    }

    wait 1.284;
    wait(0.1 + _randomfloat(0.8));
  }
}

playerdeathmixmonitor() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self waittill("death");

  if(common_scripts\utility::_id_562E(self.breathmute_submix_active)) {
    self clientclearsoundsubmix("mute_breath");
    self.breathmute_submix_active = 0;
  }
}

_id_7467() {
  self notify("sprint_breathing");
  self endon("sprint_breathing");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  if(getdvarint("4017", 0)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  for(;;) {
    self waittill("sprint_jog_begin");
    self playlocalsound("sprint_jog_male");
  }
}