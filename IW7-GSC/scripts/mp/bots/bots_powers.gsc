/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_powers.gsc
*********************************************/

func_2E53() {
  level.var_2D1C = [];
  level.var_2D1C["power_domeshield"] = ::scripts\mp\bots\bots_power_reaper::func_8995;
  level.var_2D1C["power_overCharge"] = ::func_5234;
  level.var_2D1C["power_adrenaline"] = ::func_5234;
  level.var_2D1C["power_deployableCover"] = ::func_8991;
  level.var_2D1C["power_rewind"] = ::scripts\mp\bots\bots_power_rewind::func_89DC;
  level.var_2D1C["power_adrenaline"] = ::func_5234;
  level.var_2D1C["power_multiVisor"] = ::func_5234;
  level.var_2D1C["power_blinkKnife"] = ::func_897E;
}

func_2D5A() {
  self notify("bot_detect_friendly_domeshields");
  self endon("bot_detect_friendly_domeshields");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 = 0;
  self botsetflag("disable_attack", 0);
  for(;;) {
    if(var_0) {
      wait(0.05);
    } else {
      wait(0.5);
    }

    if(var_0) {
      self botsetflag("disable_attack", 0);
      var_0 = 0;
    }

    if(isDefined(self.enemy)) {
      var_1 = self getEye();
      var_2 = self.enemy getEye();
      var_3 = bulletTrace(var_1, var_2, 0, self);
      var_4 = var_3["entity"];
      if(!isDefined(var_4) || !isDefined(var_4.var_2B0E)) {
        continue;
      }

      if(!isDefined(var_4.owner)) {
        continue;
      }

      if(var_4.owner.team == self.team) {
        self botsetflag("disable_attack", 1);
        var_0 = 1;
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
    if(isDefined(self.var_AE7B) && isDefined(self.powers[self.var_AE7B])) {
      if(isDefined(level.var_2D1C[self.var_AE7B])) {
        self thread[[level.var_2D1C[self.var_AE7B]]](self.var_AE7B, "primary");
      }
    }

    if(isDefined(self.var_AE7D) && isDefined(self.powers[self.var_AE7D])) {
      if(isDefined(level.var_2D1C[self.var_AE7D])) {
        self thread[[level.var_2D1C[self.var_AE7D]]](self.var_AE7D, "secondary");
      }
    }
  }

  for(;;) {
    self waittill("power_available", var_0, var_1);
    if(isDefined(level.var_2D1C[var_0])) {
      self thread[[level.var_2D1C[var_0]]](var_0, var_1);
    }
  }
}

func_1384F(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  for(;;) {
    self waittill("power_activated", var_2, var_3);
    if(var_2 == var_0 && var_3 == var_1) {
      break;
    }
  }
}

func_5234(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  for(;;) {
    while(!isDefined(self.enemy) || !isalive(self.enemy)) {
      wait(0.1);
    }

    if(!self botcanseeentity(self.enemy)) {
      wait(0.1);
      continue;
    }

    var_2 = 0;
    var_3 = 1400;
    var_4 = distance(self.origin, self.enemy.origin);
    if(self func_8520()) {
      var_2 = 700;
    }

    if(var_2 != 0) {
      if(var_4 < var_2) {
        wait(0.5);
        continue;
      }
    }

    if(var_4 > var_3) {
      wait(0.5);
      continue;
    }

    break;
  }

  var_5 = var_1 + "_power_ready";
  self botsetflag(var_5, 1);
  func_1384F(var_0, var_1);
  self botsetflag(var_5, 0);
}

func_897E(var_0, var_1) {
  var_2 = self botgetdifficultysetting("throwKnifeChance");
  self getpassivestruct("throwKnifeChance", 0.25);
}

func_8BEE() {
  if(!isalive(self) || !isDefined(self.enemy)) {
    return 0;
  }

  if(self botcanseeentity(self.enemy) && self func_8520()) {
    return 1;
  }

  return 0;
}

usepowerweapon(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  var_2 = var_1 + "_power_ready";
  self botsetflag(var_2, 1);
  func_1384F(var_0, var_1);
  self botsetflag(var_2, 0);
}

func_9D7E() {
  if(isDefined(self.touchtriggers)) {
    foreach(var_1 in self.touchtriggers) {
      if(!isDefined(var_1.useobj) || !isDefined(var_1.useobj.id)) {
        continue;
      }

      if(var_1.useobj.id == "domFlag") {
        if(scripts\mp\bots\gametype_dom::bot_is_capturing_flag(var_1)) {
          return 1;
        }
      }
    }
  }

  return 0;
}

useprompt(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("domeshield_used");
  self endon("powers_cleanUp");
  if(!isDefined(var_3)) {
    var_3 = ::usepowerweapon;
  }

  for(;;) {
    wait(0.05);
    while(!func_8BEE() && !func_9D7E()) {
      wait(0.25);
    }

    if(!func_9D7E()) {
      for(var_4 = self getcurrentweaponclipammo(); var_4 > 0; var_4 = self getcurrentweaponclipammo()) {
        wait(0.05);
        if(!func_8BEE()) {
          break;
        }
      }
    }

    if(func_8BEE() || func_9D7E()) {
      if(isDefined(self.enemy)) {
        var_5 = distance(self.origin, self.enemy.origin);
        if(var_5 < var_2) {
          wait(0.25);
          continue;
        }
      }

      self thread[[var_3]](var_0, var_1);
      break;
    }
  }
}

usequickrope(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("domeshield_used");
  self endon("powers_cleanUp");
  if(!isDefined(var_4)) {
    var_4 = ::usepowerweapon;
  }

  for(;;) {
    self waittill("damage");
    if(isDefined(self.enemy)) {
      var_5 = distancesquared(self.origin, self.enemy.origin);
      if(var_5 < var_2 * var_2) {
        continue;
      }
    }

    if(self.health < var_3) {
      self thread[[var_4]](var_0, var_1);
      break;
    }
  }
}

func_8991(var_0, var_1) {
  thread useprompt(var_0, var_1, 400, ::usepowerweapon);
  thread usequickrope(var_0, var_1, 450, 80, ::usepowerweapon);
}