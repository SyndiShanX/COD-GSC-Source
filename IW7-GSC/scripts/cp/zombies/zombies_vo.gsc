/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_vo.gsc
*********************************************/

play_zombie_vo(var_0, var_1, var_2) {
  var_0 endon("death");
  if(!isDefined(var_0)) {
    return;
  }

  if(func_10397()) {
    if(scripts\engine\utility::istrue(var_2) || !scripts\engine\utility::istrue(var_0.playing_stumble)) {
      var_0 func_CE9D(var_0.voprefix, var_1);
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

  var_0 = -25536;
  var_1 = 90000;
  var_2 = 160000;
  var_3 = 225625;
  for(;;) {
    scripts\engine\utility::waitframe();
    var_4 = gettime();
    if(var_4 > level.var_1469 + 1000) {
      level.var_1469 = var_4;
    }

    var_5 = level.spawned_enemies;
    var_6 = 0;
    var_7 = 1;
    if(isDefined(var_5)) {
      foreach(var_9 in var_5) {
        if(!isDefined(var_9) || !isDefined(var_9.agent_type) || !isDefined(var_9.isnodeoccupied) || var_9.isnodeoccupied != self) {
          continue;
        }

        if(!func_FF72(var_9)) {
          continue;
        }

        var_0A = 200;
        if(isDefined(var_9.asm.cur_move_mode)) {
          var_0B = var_9.asm.cur_move_mode;
        } else {
          var_0B = var_9.synctransients;
        }

        var_0C = "walk_front_grunt";
        var_0D = "walk_behind_grunt";
        switch (var_0B) {
          case "slow_walk":
            var_0A = var_0;
            break;

          case "walk":
            var_0A = var_1;
            break;

          case "run":
            var_0A = var_2;
            var_0C = "run_front_grunt";
            var_0D = "run_behind_grunt";
            break;

          case "sprint":
            var_0A = var_3;
            var_0C = "sprint_front_grunt";
            var_0D = "sprint_behind_grunt";
            break;
        }

        var_6 = play_vo_on_dist(var_9, var_0A, var_0C, var_0D);
      }
    }

    if(var_6) {
      wait(var_7);
    }
  }
}

play_vo_on_dist(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  if(!isDefined(var_0.next_vo_time)) {
    var_0.next_vo_time = 0;
  }

  if(distancesquared(var_0.origin, self.origin) < var_1) {
    var_5 = 0;
    if(func_9D21(var_0)) {
      var_5 = 1;
      var_6 = var_3;
      var_4 = 2;
      var_0.next_vo_time = gettime() + 1000;
    } else {
      var_6 = var_3;
      var_4 = 1;
      var_0.next_vo_time = gettime() + 6000;
    }

    if(var_5 || gettime() > var_0.next_vo_time) {
      play_zombie_vo(var_0, var_6, var_5);
    }
  }

  return var_4;
}

func_FF72(var_0) {
  switch (var_0.agent_type) {
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

func_9D21(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1)) {
    return func_9B76(self, var_0.origin, var_1);
  }

  return func_9B76(self, var_0.origin);
}

func_9B76(var_0, var_1, var_2) {
  var_3 = var_0 func_7D85(var_1);
  var_4 = var_0.origin[2] - var_1[2];
  if(scripts\engine\utility::istrue(var_2)) {
    if(var_3 < -95 || var_3 > 95) {
      return 1;
    }
  } else if((var_3 < -95 || var_3 > 95) && abs(var_4) < 50) {
    return 1;
  }

  return 0;
}

func_7D85(var_0) {
  var_1 = var_0;
  var_2 = self.angles[1] - func_7D84(var_1);
  var_2 = angleclamp180(var_2);
  return var_2;
}

func_7D84(var_0) {
  var_1 = vectortoangles(var_0 - self.origin);
  return var_1[1];
}

func_CE9D(var_0, var_1) {
  if(isDefined(var_0)) {
    var_1 = var_0 + var_1;
  }

  if(soundexists(var_1)) {
    self.playing_stumble = 1;
    var_2 = lookupsoundlength(var_1);
    self playsoundonmovingent(var_1);
    wait(var_2 / 1000);
    self.playing_stumble = 0;
  }
}

play_zombie_death_vo(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("stop_audio_monitors");
  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = 5;
  }

  self waittill("death");
  if(!scripts\engine\utility::istrue(var_2)) {
    if(randomint(100) > var_3) {
      return;
    }
  }

  var_4 = "death";
  if(isDefined(self)) {
    if(func_10397()) {
      var_4 = var_0 + var_4;
      if(soundexists(var_4)) {
        self playSound(var_4);
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
  var_0 = self.voprefix == level.var_13F24;
  var_1 = "walk_front_grunt";
  for(;;) {
    var_2 = scripts\engine\utility::waittill_any_timeout_1(6, "attack_hit", "attack_miss");
    var_3 = undefined;
    if(!isDefined(self.isnodeoccupied)) {
      var_4 = level.players[0];
    } else {
      var_4 = self.isnodeoccupied;
    }

    if(isDefined(self.asm.cur_move_mode)) {
      var_5 = self.asm.cur_move_mode;
    } else {
      var_5 = self.synctransients;
    }

    var_6 = "walk_talk";
    var_1 = "walk_front_grunt";
    switch (var_5) {
      case "run":
        var_6 = "run_talk";
        var_1 = "run_front_grunt";
        break;

      case "sprint":
        var_6 = "run_talk";
        var_1 = "sprint_front_grunt";
        break;
    }

    var_7 = 1;
    if(isDefined(self.is_cop)) {
      var_7 = 10;
    }

    if(randomint(100) < var_7) {
      var_3 = var_6;
    } else {
      switch (var_2) {
        case "attack_hit":
          if(var_4 func_9D21(self)) {
            var_3 = "behind_attack";
          } else if(isDefined(self.is_cop)) {
            var_3 = "front_attack";
          } else {
            var_3 = "male_front_attack";
          }
          break;

        case "attack_miss":
          if(var_4 func_9D21(self)) {
            var_3 = "behind_attack";
          } else if(isDefined(self.is_cop)) {
            var_3 = "front_attack";
          } else {
            var_3 = "male_front_attack";
          }
          break;

        case "timeout":
          if(randomint(100) < 25) {
            level thread play_zombie_vo(self, var_1, 0);
          }
          break;
      }
    }

    if(isDefined(var_3)) {
      level thread play_zombie_vo(self, var_3, 1);
    }
  }
}