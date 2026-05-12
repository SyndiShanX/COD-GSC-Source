/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_flamethrower.gsc
*************************************************/

func_00D5() {
  level.var_5A61["flamethrower"] = ::func_9E2D;
  level.var_5A7D["flamethrower_mp"] = "flamethrower";
  level.var_5A7D["flamethrower_german_mp"] = "flamethrower";
  level.var_5A7D["flamethrower_grenadier_mp"] = "flamethrower";
  level.var_5A7D["flamethrower_german_grenadier_mp"] = "flamethrower";
}

func_9E2D(param_00) {
  var_01 = func_9E2E();
  return var_01;
}

func_9E2E() {
  if(maps\mp\_utility::func_57A0(self)) {
    thread func_9569();
    maps\mp\_matchdata::func_5E9A("flamethrower", self.var_0116);
    return 1;
  }

  return 0;
}

func_9569() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.var_267E)) {
    return;
  }

  var_00 = self.var_267E[3];
  var_01 = self.var_01A7;
  if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(level.var_79C1)) {
    var_01 = maps\mp\_utility::func_45DE(var_01);
  }

  if(!maps\mp\_riotshield::func_4B8C()) {
    if(var_01 == "allies") {
      self.var_267E[3] = 478;
    } else {
      self.var_267E[3] = 479;
    }

    if(!function_01EF(self)) {
      self setcostumemodels(self.var_267E, self.var_01A7, 1);
    }

    self waittill("weapon_change", var_02);
    self.var_267E[3] = var_00;
    if(!function_01EF(self)) {
      self setcostumemodels(self.var_267E, self.var_01A7, 1);
    }
  }
}