/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\healthoverlay.gsc
****************************************/

init() {
  level.healthoverlaycutoff = 0.55;
  var_00 = scripts\mp\tweakables::gettweakablevalue("player", "healthregentime");
  level.healthregendisabled = var_00 <= 0;
  level.playerhealth_regularregendelay = var_00;
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    thread playerhealthregen();
    self visionsetthermalforplayer(game["thermal_vision"]);
  }
}

playerhealthregen() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");
  if(self.health <= 0) {
    return;
  }

  var_00 = 0;
  var_01 = 0;
  thread func_D368(self.maxhealth * 0.55);
  for(;;) {
    scripts\engine\utility::waittill_any_3("damage", "force_regen", "force_regeneration");
    if(self.health <= 0) {
      return;
    }

    if(scripts\mp\utility::isjuggernaut()) {
      continue;
    }

    var_01 = gettime();
    var_02 = self.health / self.maxhealth;
    self.regenspeed = level.playerhealth_regularregendelay;
    if(scripts\mp\utility::_hasperk("specialty_regenfaster")) {
      self.regenspeed = self.regenspeed * level.var_DE8A;
    }

    if(var_02 <= level.healthoverlaycutoff) {
      self.var_2410 = 1;
    }

    thread healthregeneration(var_01, var_02);
  }
}

func_D367() {
  self notify("playerBreathingBetterSound");
  self endon("playerBreathingBetterSound");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  if(level.gameended) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  if(scripts\mp\utility::isusingremote()) {
    return;
  }

  if(scripts\mp\utility::func_9D48("archetype_scout")) {
    self playlocalsound("breathing_better_c6");
    return;
  }

  if(scripts\mp\utility::isfemale()) {
    self playlocalsound("Fem_breathing_better");
    return;
  }

  self playlocalsound("breathing_better");
}

healthregeneration(param_00, param_01) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  if(!scripts\mp\utility::_hasperk("specialty_adrenaline")) {
    if(level.healthregendisabled) {
      return;
    }

    while(scripts\mp\utility::istrue(self.healthregendisabled)) {
      wait(0.5);
    }
  }

  if(!scripts\mp\utility::_hasperk("specialty_adrenaline")) {
    scripts\mp\utility::wait_endon(self.regenspeed, "force_regeneration");
  }

  if(param_01 < 0.55) {
    var_02 = 1;
  } else {
    var_02 = 0;
  }

  if(scripts\mp\utility::_hasperk("specialty_adrenaline") || scripts\mp\utility::_hasperk("specialty_regenfaster")) {
    self setclientomnvar("ui_health_regen_hud", 1);
  }

  var_03 = self.maxhealth / 50;
  var_04 = 0;
  var_05 = gettime();
  for(;;) {
    if(scripts\mp\utility::istrue(self.healthregendisabled) && !scripts\mp\utility::_hasperk("specialty_adrenaline")) {
      return;
    }

    wait(0.05);
    var_06 = 0;
    if(scripts\mp\utility::_hasperk("specialty_adrenaline") || scripts\mp\utility::_hasperk("specialty_adrenaline_lite")) {
      var_06 = scripts\mp\equipment\adrenaline::func_7EF5();
    } else if(scripts\mp\utility::_hasperk("specialty_regenfaster")) {
      var_06 = var_03 * level.var_DE89;
    } else {
      var_06 = var_03;
    }

    var_07 = 0;
    if(self.health < self.maxhealth) {
      var_07 = 1;
      var_08 = self.health + var_06 + var_04;
      var_09 = int(min(self.maxhealth, var_08));
      self.health = var_09;
      var_04 = var_08 - var_09;
    }

    if(self.health >= self.maxhealth) {
      self.health = self.maxhealth;
      if(var_07 && scripts\mp\utility::_hasperk("specialty_regenfaster")) {
        scripts\mp\missions::func_D991("ch_trait_icu");
      }

      break;
    }
  }

  self notify("healed");
  thread scripts\mp\damage::removeoldattackersovertime();
  func_D367();
  self setclientomnvar("ui_health_regen_hud", 0);
}

func_135F0() {
  self notify("waiting_to_stop_remote");
  self endon("waiting_to_stop_remote");
  self endon("death");
  level endon("game_ended");
  self waittill("stopped_using_remote");
  scripts\mp\utility::restorebasevisionset(0);
}

func_D368(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  if(!isplayer(self)) {
    return;
  }

  self.hardcoreinjuredlooopsplayed = 0;
  wait(2);
  for(;;) {
    wait(0.2);
    if(self.health <= 0) {
      return;
    }

    if(self.health >= param_00) {
      continue;
    }

    var_01 = level.healthregendisabled || isDefined(self.healthregendisabled) && self.healthregendisabled;
    if(scripts\mp\utility::isusingremote()) {
      continue;
    }

    if(scripts\mp\utility::func_9D48("archetype_scout")) {
      self playlocalsound("breathing_hurt_c6");
    } else if(scripts\mp\utility::isfemale()) {
      self playlocalsound("Fem_breathing_hurt");
    } else {
      self playlocalsound("breathing_hurt");
    }

    wait(1.5);
    if(level.hardcoremode) {
      self.hardcoreinjuredlooopsplayed++;
      if(self.hardcoreinjuredlooopsplayed > 3) {
        return;
      }
    }
  }
}