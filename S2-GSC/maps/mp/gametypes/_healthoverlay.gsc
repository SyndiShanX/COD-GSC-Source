/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_healthoverlay.gsc
************************************************/

func_00D5() {
  level.var_4C1D = 0.55;
  var_00 = 4;
  var_00 = maps\mp\gametypes\_tweakables::func_46F7("player", "healthregentime");
  level.var_73FA = var_00 * 1000;
  level.playerhealth_grenadierregendelay = int(max(var_00 - 1, 0) * 1000);
  level.var_73FB = 1.5;
  level.var_4C1E = level.var_73FA <= 0;
  level thread func_6B6C();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B82();
  }
}

func_6B82() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    thread func_73FC();
    thread playerdeathmixmonitor();
    self.breathmute_submix_active = 0;
  }
}

func_73FC() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("goliath_equipped");
  level endon("game_ended");
  if(self.var_00BC <= 0) {
    return;
  }

  if(common_scripts\utility::func_562E(self.var_4C1E)) {
    return;
  }

  var_00 = 0;
  thread func_7434();
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05);
    if(self.var_00BC <= 0) {
      return;
    }

    var_00 = gettime();
    var_06 = self.var_00BC / self.var_00FB;
    if(var_06 <= level.var_4C1D) {
      self.var_10F4 = 1;
    }

    if(function_0367()) {
      if(isDefined(self.var_5692) && self.var_5692 == 1) {
        thread func_1BC0(var_00, var_01, var_05);
        return;
      }
    }

    thread func_4C20();
    thread func_1BC0(var_00, var_01, var_05);
  }
}

func_1BC0(param_00, param_01, param_02) {
  self notify("breathingManager");
  self endon("breathingManager");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  if(maps\mp\_utility::func_581D() || maps\mp\_utility::func_572D()) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if((isDefined(param_02) && param_02 != "MOD_FALLING") || isDefined(param_01) && param_01 > 1) {
    func_720E(param_00);
  }

  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  var_03 = maps\mp\_utility::func_0649("specialty_fasterhealthregen");
  var_04 = level.var_73FA;
  if(var_03) {
    var_04 = level.playerhealth_grenadierregendelay;
  }

  if(isDefined(self.var_98E1)) {
    var_04 = self.var_98E1 * 1000;
  }

  self.var_1BC1 = param_00 + 0.6 * var_04;
  if(var_03) {
    wait(var_04 / 1000);
  } else {
    wait(1.4 * var_04 / 1000);
  }

  if(!level.var_3F9D && isDefined(self.var_10F4) && self.var_10F4 == 1) {
    self method_8627("mute_breath");
    self.breathmute_submix_active = 0;
    self.var_10F4 = 0;
  }
}

func_720E(param_00) {
  if(isDefined(level.var_297F)) {
    self thread[[level.var_297F]](param_00);
    return;
  }

  if(isDefined(self.var_29AB) && self.var_29AB + 3000 > param_00) {
    return;
  }

  self.var_29AB = param_00;
  var_01 = randomintrange(1, 8);
  self method_8626("mute_breath");
  self.breathmute_submix_active = 1;
  if(self.var_01A7 == "axis") {
    if(self method_843D()) {
      self method_8617("generic_pain_enemy_fm_" + var_01, "pain_sound_done");
    } else {
      self method_8617("generic_pain_enemy_" + var_01, "pain_sound_done");
    }
  } else if(self method_843D()) {
    self method_8617("generic_pain_friendly_fm_" + var_01, "pain_sound_done");
  } else {
    self method_8617("generic_pain_friendly_" + var_01, "pain_sound_done");
  }

  self waittill("pain_sound_done");
  if(!common_scripts\utility::func_562E(self.var_10F4)) {
    self method_8627("mute_breath");
    self.breathmute_submix_active = 0;
  }
}

func_4C20() {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("goliath_equipped");
  level endon("game_ended");
  if(level.var_4C1E) {
    return;
  }

  if(maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight") && !isDefined(self.var_50A0) || !self.var_50A0) {
    return;
  }

  var_00 = isDefined(self.var_10F4) && self.var_10F4;
  var_01 = maps\mp\_utility::func_0649("specialty_fasterhealthregen");
  var_02 = level.var_73FA;
  if(var_01) {
    var_02 = level.playerhealth_grenadierregendelay;
  }

  if(isDefined(self.var_98E1)) {
    var_02 = self.var_98E1 * 1000;
  }

  if(!isDefined(self.var_50A0) || !self.var_50A0) {
    if(maps\mp\_utility::func_585F()) {
      common_scripts\utility::func_A74B("immediateHealthRegen", var_02 / 1000);
    } else {
      wait(var_02 / 1000);
    }
  } else {
    self.var_50A0 = 0;
  }

  if(var_01) {
    if(self.var_00BC < self.var_00FB) {}

    self.var_00BC = self.var_00FB;
  } else {
    var_03 = float(self.var_00BC);
    for(;;) {
      wait 0.05;
      var_04 = level.var_73FB;
      if(isDefined(self.var_98E2)) {
        var_04 = self.var_98E2;
      }

      var_05 = self.var_00FB;
      if(self.var_00BC < var_05) {
        var_03 = var_03 + var_04;
        self.var_00BC = int(var_03);
        if(self.var_00BC > var_05) {
          self.var_00BC = var_05;
        }

        continue;
      }

      break;
    }
  }

  maps\mp\gametypes\_damage::func_7D51();
  if(var_00) {
    self notify("recovery_battlecry");
    maps\mp\gametypes\_missions::healthregeneratedbrinkofdeath();
    return;
  }

  maps\mp\gametypes\_missions::func_4C1F();
}

func_A651() {
  self notify("waiting_to_stop_remote");
  self endon("waiting_to_stop_remote");
  self endon("death");
  level endon("game_ended");
  self waittill("stopped_using_remote");
  maps\mp\_utility::func_7E50(0);
}

func_7434() {
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

  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  wait(3);
  for(;;) {
    wait(0.2);
    if(self.var_00BC <= 0) {
      return;
    }

    if(self.var_00BC >= self.var_00FB * level.var_4C1D) {
      continue;
    }

    if(level.var_4C1E && !isDefined(self.var_1BC1) || gettime() > self.var_1BC1) {
      continue;
    }

    if(maps\mp\_utility::func_581D() || maps\mp\_utility::func_572D()) {
      continue;
    }

    if(self.var_165B) {
      continue;
    }

    if(!common_scripts\utility::func_562E(self.breathmute_submix_active)) {
      self method_8626("mute_breath");
      self.breathmute_submix_active = 1;
    }

    if(self method_843D()) {
      self method_8615("deaths_door_mp_female");
    } else {
      self method_8615("deaths_door_mp_male");
    }

    wait(1.284);
    wait(0.1 + randomfloat(0.8));
  }
}

playerdeathmixmonitor() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self waittill("death");
  if(common_scripts\utility::func_562E(self.breathmute_submix_active)) {
    self method_8627("mute_breath");
    self.breathmute_submix_active = 0;
  }
}

func_7467() {
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

  if(isDefined(level.var_585D) && level.var_585D) {
    return;
  }

  for(;;) {
    self waittill("sprint_jog_begin");
    self method_8615("sprint_jog_male");
  }
}