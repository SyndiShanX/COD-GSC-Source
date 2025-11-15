/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_vo.gsc
*********************************************/

play_zombie_vo(param_00, param_01, param_02) {
  param_00 endon("death");
  if(!isDefined(param_00)) {
    return;
  }

  if(func_10397()) {
    if(scripts\engine\utility::istrue(param_02) || !scripts\engine\utility::istrue(param_00.playing_stumble)) {
      param_00 func_CE9D(param_00.voprefix, param_01);
    }
  }
}

func_BEEB() {
  for(;;) {
    level.var_C1D9 = 0;
    wait(0.25);
  }
}

func_10397() {
  if(!isDefined(level.var_C1D9)) {
    level thread func_BEEB();
  }

  if(level.var_C1D9 > 4) {
    return 0;
  }

  level.var_C1D9++;
  return 1;
}

zombie_behind_vo() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  if(!isDefined(level.var_1469)) {
    level.var_1469 = 0;
  }

  var_00 = -25536;
  var_01 = 90000;
  var_02 = 160000;
  var_03 = 225625;
  for(;;) {
    scripts\engine\utility::waitframe();
    var_04 = gettime();
    if(var_04 > level.var_1469 + 1000) {
      level.var_1469 = var_04;
    }

    var_05 = level.spawned_enemies;
    var_06 = 0;
    var_07 = 1;
    if(isDefined(var_05)) {
      foreach(var_09 in var_05) {
        if(!isDefined(var_09) || !isDefined(var_09.agent_type) || !isDefined(var_09.isnodeoccupied) || var_09.isnodeoccupied != self) {
          continue;
        }

        if(!func_FF72(var_09)) {
          continue;
        }

        var_0A = 200;
        if(isDefined(var_09.asm.cur_move_mode)) {
          var_0B = var_09.asm.cur_move_mode;
        } else {
          var_0B = var_09.synctransients;
        }

        var_0C = "walk_front_grunt";
        var_0D = "walk_behind_grunt";
        switch (var_0B) {
          case "slow_walk":
            var_0A = var_00;
            break;

          case "walk":
            var_0A = var_01;
            break;

          case "run":
            var_0A = var_02;
            var_0C = "run_front_grunt";
            var_0D = "run_behind_grunt";
            break;

          case "sprint":
            var_0A = var_03;
            var_0C = "sprint_front_grunt";
            var_0D = "sprint_behind_grunt";
            break;
        }

        var_06 = play_vo_on_dist(var_09, var_0A, var_0C, var_0D);
      }
    }

    if(var_06) {
      wait(var_07);
    }
  }
}

play_vo_on_dist(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  if(!isDefined(param_00.next_vo_time)) {
    param_00.next_vo_time = 0;
  }

  if(distancesquared(param_00.origin, self.origin) < param_01) {
    var_05 = 0;
    if(func_9D21(param_00)) {
      var_05 = 1;
      var_06 = param_03;
      var_04 = 2;
      param_00.next_vo_time = gettime() + 1000;
    } else {
      var_06 = param_03;
      var_04 = 1;
      param_00.next_vo_time = gettime() + 6000;
    }

    if(var_05 || gettime() > param_00.next_vo_time) {
      play_zombie_vo(param_00, var_06, var_05);
    }
  }

  return var_04;
}

func_FF72(param_00) {
  switch (param_00.agent_type) {
    case "karatemaster":
    case "zombie_sasquatch":
    case "slasher":
    case "zombie_grey":
    case "zombie_brute":
    case "ratking":
    case "skater":
    case "crab_brute":
    case "crab_mini":
      return 0;

    default:
      return 1;
  }
}

func_9D21(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01)) {
    return func_9B76(self, param_00.origin, param_01);
  }

  return func_9B76(self, param_00.origin);
}

func_9B76(param_00, param_01, param_02) {
  var_03 = param_00 func_7D85(param_01);
  var_04 = param_00.origin[2] - param_01[2];
  if(scripts\engine\utility::istrue(param_02)) {
    if(var_03 < -95 || var_03 > 95) {
      return 1;
    }
  } else if((var_03 < -95 || var_03 > 95) && abs(var_04) < 50) {
    return 1;
  }

  return 0;
}

func_7D85(param_00) {
  var_01 = param_00;
  var_02 = self.angles[1] - func_7D84(var_01);
  var_02 = angleclamp180(var_02);
  return var_02;
}

func_7D84(param_00) {
  var_01 = vectortoangles(param_00 - self.origin);
  return var_01[1];
}

func_CE9D(param_00, param_01) {
  if(isDefined(param_00)) {
    param_01 = param_00 + param_01;
  }

  if(soundexists(param_01)) {
    self.playing_stumble = 1;
    var_02 = lookupsoundlength(param_01);
    self playsoundonmovingent(param_01);
    wait(var_02 / 1000);
    self.playing_stumble = 0;
  }
}

play_zombie_death_vo(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("stop_audio_monitors");
  if(isDefined(param_01)) {
    var_03 = param_01;
  } else {
    var_03 = 5;
  }

  self waittill("death");
  if(!scripts\engine\utility::istrue(param_02)) {
    if(randomint(100) > var_03) {
      return;
    }
  }

  var_04 = "death";
  if(isDefined(self)) {
    if(func_10397()) {
      var_04 = param_00 + var_04;
      if(soundexists(var_04)) {
        self playSound(var_04);
        return;
      }
    }
  }
}

func_13F10() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_audio_monitors");
  thread play_zombie_death_vo(self.voprefix);
  self.playing_stumble = 0;
  var_00 = self.voprefix == level.var_13F24;
  var_01 = "walk_front_grunt";
  for(;;) {
    var_02 = scripts\engine\utility::waittill_any_timeout_1(6, "attack_hit", "attack_miss");
    var_03 = undefined;
    if(!isDefined(self.isnodeoccupied)) {
      var_04 = level.players[0];
    } else {
      var_04 = self.isnodeoccupied;
    }

    if(isDefined(self.asm.cur_move_mode)) {
      var_05 = self.asm.cur_move_mode;
    } else {
      var_05 = self.synctransients;
    }

    var_06 = "walk_talk";
    var_01 = "walk_front_grunt";
    switch (var_05) {
      case "run":
        var_06 = "run_talk";
        var_01 = "run_front_grunt";
        break;

      case "sprint":
        var_06 = "run_talk";
        var_01 = "sprint_front_grunt";
        break;
    }

    var_07 = 1;
    if(isDefined(self.is_cop)) {
      var_07 = 10;
    }

    if(randomint(100) < var_07) {
      var_03 = var_06;
    } else {
      switch (var_02) {
        case "attack_hit":
          if(var_04 func_9D21(self)) {
            var_03 = "behind_attack";
          } else if(isDefined(self.is_cop)) {
            var_03 = "front_attack";
          } else {
            var_03 = "male_front_attack";
          }
          break;

        case "attack_miss":
          if(var_04 func_9D21(self)) {
            var_03 = "behind_attack";
          } else if(isDefined(self.is_cop)) {
            var_03 = "front_attack";
          } else {
            var_03 = "male_front_attack";
          }
          break;

        case "timeout":
          if(randomint(100) < 25) {
            level thread play_zombie_vo(self, var_01, 0);
          }
          break;
      }
    }

    if(isDefined(var_03)) {
      level thread play_zombie_vo(self, var_03, 1);
    }
  }
}