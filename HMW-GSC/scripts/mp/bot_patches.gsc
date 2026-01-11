main() {
  // register custom streaks for bots
  replacefunc(maps\mp\bots\_bots_ks::bot_killstreak_setup, ::bot_killstreak_setup_stub);

  // use killstreaks persistent variable instead of hardPointItem
  replacefunc(maps\mp\bots\_bots_ks::bot_think_killstreak, ::bot_think_killstreak_stub);
  replacefunc(maps\mp\bots\_bots_util::bot_in_combat, ::bot_in_combat_stub);
}

bot_in_combat_stub(var_0) {
  if(!isDefined(self.last_enemy_sight_time)) {
    return 0;
  }

  if(self.last_enemy_sight_time == 0) {
    return 0;
  }

  var_1 = gettime() - self.last_enemy_sight_time;
  var_2 = level.bot_out_of_combat_time;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  return var_1 < var_2;
}

bot_killstreak_setup_stub() {
  if(!isDefined(level.killstreak_botfunc)) {
    bot_register_killstreak_func("radar_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, maps\mp\bots\_bots_ks::bot_can_use_uav);
    bot_register_killstreak_func("airstrike_mp", ::bot_killstreak_choose_loc_enemies, maps\mp\bots\_bots_ks::bot_can_use_airstrike);
    bot_register_killstreak_func("helicopter_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, maps\mp\bots\_bots_ks::bot_can_use_helicopter);

    // h2m changes
    bot_register_killstreak_func("counter_radar_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, ::bot_killstreak_do_use);
    bot_register_killstreak_func("sentry_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, ::bot_killstreak_do_use);
    bot_register_killstreak_func("harrier_airstrike_mp", ::bot_killstreak_choose_loc_enemies, maps\mp\bots\_bots_ks::bot_can_use_airstrike);
    bot_register_killstreak_func("stealth_airstrike_mp", ::bot_killstreak_choose_loc_enemies, maps\mp\bots\_bots_ks::bot_can_use_airstrike);
    bot_register_killstreak_func("chopper_gunner_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, maps\mp\bots\_bots_ks::bot_can_use_helicopter);
    bot_register_killstreak_func("ac130_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, ::bot_can_use_ac130);
    bot_register_killstreak_func("nuke_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, ::bot_killstreak_do_use);
    bot_register_killstreak_func("emp_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, ::bot_killstreak_do_use);
    bot_register_killstreak_func("dogs_mp", maps\mp\bots\_bots_ks::bot_killstreak_simple_use, ::bot_killstreak_do_use);
  }
}

bot_register_killstreak_func(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.killstreak_botfunc)) {
    level.killstreak_botfunc = [];
  }

  level.killstreak_botfunc[var_0] = var_1;

  if(!isDefined(level.killstreak_botcanuse)) {
    level.killstreak_botcanuse = [];
  }

  level.killstreak_botcanuse[var_0] = var_2;

  if(!isDefined(level.killstreak_botparm)) {
    level.killstreak_botparm = [];
  }

  // add isdefined check here
  if(isDefined(var_3)) {
    level.killstreak_botparm[var_0] = var_3;
  }

  if(!isDefined(level.bot_supported_killstreaks)) {
    level.bot_supported_killstreaks = [];
  }

  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var_0;
}

bot_think_killstreak_stub() {
  self notify("bot_think_killstreak");
  self endon("bot_think_killstreak");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.killstreak_botfunc)) {
    wait 0.05;
  }

  for(;;) {
    wait(randomfloatrange(2.0, 4.0));

    if(maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
      var_0 = self.pers["killstreaks"];

      // TODO: is this bandaid fix okay? this is technically CptPrice changes here that im patching
      if(isDefined(var_0) && var_0.size > 1) {
        var_0 = var_0[0].streakName;

        if(isDefined(self.bot_killstreak_wait) && isDefined(self.bot_killstreak_wait[var_0]) && gettime() < self.bot_killstreak_wait[var_0]) {
          continue;
        }

        var_1 = level.killstreak_botcanuse[var_0];

        if(isDefined(var_1) && !self[[var_1]](var_0)) {
          continue;
        }

        var_2 = level.killstreak_botfunc[var_0];

        if(isDefined(var_2)) {
          var_3 = self[[var_2]](var_0, var_1);

          if(!isDefined(var_3) || var_3 == 0) {
            if(!isDefined(self.bot_killstreak_wait)) {
              self.bot_killstreak_wait = [];
            }

            self.bot_killstreak_wait[var_0] = gettime() + 5000;
          }
        } else {
        }
      }
    }
  }
}

bot_killstreak_choose_loc_enemies(var_0, var_1) {
  wait(randomintrange(3, 5));

  if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }

  if(isDefined(var_1) && !self[[var_1]](var_0)) {
    return 0;
  }

  self botsetflag("disable_movement", 1);
  maps\mp\bots\_bots_ks::bot_switch_to_killstreak_weapon(var_0);
  wait 2.0;

  if(!isDefined(self.selectinglocation)) {
    self botsetflag("disable_movement", 0);
    return;
  }

  targets = [];
  foreach(player in level.players) {
    if(self != player || (level.teambased && self.team != player.team)) {
      targets[targets.size] = player;
    }
  }

  random_target = targets[randomint(targets.size)];
  if(!isDefined(random_target)) {
    random_target = self;
  }

  heightEnt = getent("airstrikeheight", "targetname");
  if(isDefined(heightEnt) || isDefined(level.airstrikeHeightScale)) {
    height = maps\mp\h2_killstreaks\_airdrop::getFlyHeightOffset(random_target.origin);
  }
  else {
    height = level.heli_leave_nodes[randomInt(level.heli_leave_nodes.size)].origin[2];
  }

  location = (random_target.origin[0], random_target.origin[1], height);

  self notify("confirm_location", location, randomInt(360));
  self waittill("stop_location_selection");
  wait 1.0;
  self botsetflag("disable_movement", 0);
}

// custom streaks
bot_can_use_ac130(var_0) {
  return (isDefined(level.ac130inuse) && !level.ac130inuse);
}

bot_killstreak_do_use(var_0) {
  return 1;
}

// bot ks funcs
h2_set_bot_ks() {
  switch (randomInt(4)) {
    case 0:
      self.customKillstreaks[0] = "radar_mp";
      self.customKillstreaks[1] = "airstrike_mp";
      self.customKillstreaks[2] = "helicopter_mp";
      break;

    case 1:
      self.customKillstreaks[0] = "counter_radar_mp";
      self.customKillstreaks[1] = "sentry_mp";
      self.customKillstreaks[2] = "harrier_airstrike_mp";
      break;

    case 2:
      self.customKillstreaks[0] = "radar_mp";
      self.customKillstreaks[1] = "stealth_airstrike_mp";
      self.customKillstreaks[2] = "chopper_gunner_mp";
      break;

    case 3:
      self.customKillstreaks[0] = "counter_radar_mp";
      self.customKillstreaks[1] = "ac130_mp";
      self.customKillstreaks[2] = "emp_mp";
      break;

    default:
      break;
  }
}

bot_remote_use(vehicle) {
  level endon("game_ended");
  self endon("disconnect");

  self notify("bot_remote_use");
  self endon("bot_remote_use");

  self BotSetFlag("disable_rotation", true);
  lastAimAt = undefined;
  times = 0;

  wait 3;

  while(self maps\mp\_utility::isUsingRemote()) {
    wait 0.05;

    self.aimAt = undefined;
    eyePos = vehicle.origin;

    if(isDefined(lastAimAt)) {
      bodyAngles = VectorToAngles(lastAimAt - eyePos);
      self _setPlayerAngles(bodyAngles);
      self BotPressButton("attack");

      self.aimAt = lastAimAt;
      times++;

      if(times == 3) {
        times = 0;
        lastAimAt = undefined;
        wait 0.05;
      }

      wait 0.05;
      continue;
    }

    foreach(player in level.players) {
      if(player == self) {
        continue;
      }

      if(!maps\mp\_utility::isReallyAlive(player)) {
        continue;
      }

      if(level.teamBased && self.pers["team"] == player.pers["team"]) {
        continue;
      }

      if(!bulletTracePassed(eyePos, player getTagOrigin("tag_eye"), false, self)) {
        continue;
      }

      if(isDefined(self.aimAt)) {
        if(closer(eyePos, player getTagOrigin("j_mainroot"), self.aimAt getTagOrigin("j_mainroot"))) {
          self.aimAt = player;
        }
      } else {
        self.aimAt = player;
      }
    }

    if(isDefined(self.aimAt)) {
      spine = self.aimAt getTagOrigin("j_spineupper");
      angles = VectorToAngles((spine) - (eyePos));

      self _setPlayerAngles(angles);
      self BotPressButton("attack");

      if(!isDefined(self.aimAt) || !maps\mp\_utility::isReallyAlive(self.aimAt)) {
        lastAimAt = spine;
      }
    }
  }

  self BotSetFlag("disable_rotation", false);
}

_setPlayerAngles(Angle) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  Steps = 4;
  Delay = 0.05;
  originalAngle = Angle;

  PStepAngle = 180 / Steps;
  NStepAngle = PStepAngle - (PStepAngle * 2); //Try tweaking the 180 into 360
  myAngle = self getPlayerAngles();
  myAngle = NormalizeAngles(myAngle);
  Angle = NormalizeAngles(Angle);

  X = (Angle[0] - myAngle[0]) / Steps;
  if((myAngle[0] + (X * Steps)) > 360 || X > 36 || X < -36) {
    X = (myAngle[0] - ((myAngle[0] + (X * Steps)) - 360)) / Steps;
    X = X - (X * 2);
  }

  Y = (Angle[1] - myAngle[1]) / Steps;
  if((myAngle[1] + (Y * Steps)) > 360 || Y > 36 || Y < -36) {
    Y = (myAngle[1] - ((myAngle[1] + (Y * Steps)) - 360)) / Steps;
    Y = Y - (Y * 2);
  }

  if((X < PStepAngle && X > NStepAngle) && (Y < PStepAngle && Y > NStepAngle)) {
    for(i = 1; i < Steps; i++) {
      newAngle = (myAngle[0] + X, myAngle[1] + Y, 0);
      self setPlayerAngles(newAngle);
      myAngle = self getPlayerAngles();
      wait Delay;
    }

    self setPlayerAngles(originalAngle);
    return 1;
  }

  wait Delay;
  self setPlayerAngles(originalAngle);
  return 0;
}

NormalizeAngles(Angle) {
  X = Angle[0];
  Y = Angle[1];
  Z = Angle[2];
  if(X < 0) X = Angle[0] + 360;
  if(Y < 0) Y = Angle[1] + 360;
  if(Z < 0) Z = Angle[2] + 360;
  if(X > 360) {
    X = Angle[0] - 360;
  }
  if(Y > 360) {
    Y = Angle[1] - 360;
  }
  if(Z > 360) {
    Z = Angle[2] - 360;
  }

  return (X, Y, Z);
}