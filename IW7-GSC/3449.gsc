/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3449.gsc
***************************************/

func_2E53() {
  level.func_2D1C = [];
  level.func_2D1C["power_domeshield"] = ::scripts\mp\bots\bots_power_reaper::func_8995;
  level.func_2D1C["power_overCharge"] = ::func_5234;
  level.func_2D1C["power_adrenaline"] = ::func_5234;
  level.func_2D1C["power_deployableCover"] = ::func_8991;
  level.func_2D1C["power_rewind"] = ::scripts\mp\bots\bots_power_rewind::func_89DC;
  level.func_2D1C["power_adrenaline"] = ::func_5234;
  level.func_2D1C["power_multiVisor"] = ::func_5234;
  level.func_2D1C["power_blinkKnife"] = ::func_897E;
}

func_2D5A() {
  self notify("bot_detect_friendly_domeshields");
  self endon("bot_detect_friendly_domeshields");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_00 = 0;
  self botsetflag("disable_attack", 0);

  for(;;) {
    if(var_00) {
      wait 0.05;
    } else {
      wait 0.5;
    }

    if(var_00) {
      self botsetflag("disable_attack", 0);
      var_00 = 0;
    }

    if(isDefined(self.enemy)) {
      var_01 = self getEye();
      var_02 = self.enemy getEye();
      var_03 = bulletTrace(var_01, var_02, 0, self);
      var_04 = var_3["entity"];

      if(!isDefined(var_04) || !isDefined(var_4.func_2B0E)) {
        continue;
      }
      if(!isDefined(var_4.owner)) {
        continue;
      }
      if(var_4.owner.team == self.team) {
        self botsetflag("disable_attack", 1);
        var_00 = 1;
        continue;
      }
    }
  }
}

bot_think_powers() {
  self notify("bot_think_powers");
  self endon("bot_think_powers");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  thread func_2D5A();

  if(isDefined(self.powers) && self.powers.size > 0) {
    if(isDefined(self.func_AE7B) && isDefined(self.powers[self.func_AE7B])) {
      if(isDefined(level.func_2D1C[self.func_AE7B])) {
        self thread[[level.func_2D1C[self.func_AE7B]]](self.func_AE7B, "primary");
      }
    }

    if(isDefined(self.func_AE7D) && isDefined(self.powers[self.func_AE7D])) {
      if(isDefined(level.func_2D1C[self.func_AE7D])) {
        self thread[[level.func_2D1C[self.func_AE7D]]](self.func_AE7D, "secondary");
      }
    }
  }

  for(;;) {
    self waittill("power_available", var_00, var_01);

    if(isDefined(level.func_2D1C[var_00])) {
      self thread[[level.func_2D1C[var_00]]](var_00, var_01);
    }
  }
}

func_1384F(var_00, var_01) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");

  for(;;) {
    self waittill("power_activated", var_02, var_03);

    if(var_02 == var_00 && var_03 == var_01) {
      break;
    }
  }
}

func_5234(var_00, var_01) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");

  for(;;) {
    while(!isDefined(self.enemy) || !isalive(self.enemy)) {
      wait 0.1;
    }

    if(!self botcanseeentity(self.enemy)) {
      wait 0.1;
      continue;
    }

    var_02 = 0;
    var_03 = 1400;
    var_04 = distance(self.origin, self.enemy.origin);

    if(self _meth_8520()) {
      var_02 = 700;
    }

    if(var_02 != 0) {
      if(var_04 < var_02) {
        wait 0.5;
        continue;
      }
    }

    if(var_04 > var_03) {
      wait 0.5;
      continue;
    }

    break;
  }

  var_05 = var_01 + "_power_ready";
  self botsetflag(var_05, 1);
  func_1384F(var_00, var_01);
  self botsetflag(var_05, 0);
}

func_897E(var_00, var_01) {
  var_02 = self botgetdifficultysetting("throwKnifeChance");
  self botsetdifficultysetting("throwKnifeChance", 0.25);
}

func_8BEE() {
  if(!isalive(self) || !isDefined(self.enemy)) {
    return 0;
  }

  if(self botcanseeentity(self.enemy) && self _meth_8520()) {
    return 1;
  }

  return 0;
}

usepowerweapon(var_00, var_01) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  var_02 = var_01 + "_power_ready";
  self botsetflag(var_02, 1);
  func_1384F(var_00, var_01);
  self botsetflag(var_02, 0);
}

func_9D7E() {
  if(isDefined(self.touchtriggers)) {
    foreach(var_01 in self.touchtriggers) {
      if(!isDefined(var_1.useobj) || !isDefined(var_1.useobj.id)) {
        continue;
      }
      if(var_1.useobj.id == "domFlag") {
        if(scripts\mp\bots\gametype_dom::bot_is_capturing_flag(var_01)) {
          return 1;
        }
      }
    }
  }

  return 0;
}

useprompt(var_00, var_01, var_02, var_03) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("domeshield_used");
  self endon("powers_cleanUp");

  if(!isDefined(var_03)) {
    var_03 = ::usepowerweapon;
  }

  for(;;) {
    wait 0.05;

    while(!func_8BEE() && !func_9D7E()) {
      wait 0.25;
    }

    if(!func_9D7E()) {
      for(var_04 = self getcurrentweaponclipammo(); var_04 > 0; var_04 = self getcurrentweaponclipammo()) {
        wait 0.05;

        if(!func_8BEE()) {
          break;
        }
      }
    }

    if(func_8BEE() || func_9D7E()) {
      if(isDefined(self.enemy)) {
        var_05 = distance(self.origin, self.enemy.origin);

        if(var_05 < var_02) {
          wait 0.25;
          continue;
        }
      }

      self thread[[var_03]](var_00, var_01);
      break;
    }
  }
}

usequickrope(var_00, var_01, var_02, var_03, var_04) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("domeshield_used");
  self endon("powers_cleanUp");

  if(!isDefined(var_04)) {
    var_04 = ::usepowerweapon;
  }

  for(;;) {
    self waittill("damage");

    if(isDefined(self.enemy)) {
      var_05 = distancesquared(self.origin, self.enemy.origin);

      if(var_05 < var_02 * var_02) {
        continue;
      }
    }

    if(self.health < var_03) {
      self thread[[var_04]](var_00, var_01);
      break;
    }
  }
}

func_8991(var_00, var_01) {
  thread useprompt(var_00, var_01, 400, ::usepowerweapon);
  thread usequickrope(var_00, var_01, 450, 80, ::usepowerweapon);
}