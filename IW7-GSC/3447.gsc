/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3447.gsc
************************/

func_8995(param_00, param_01) {
  thread scripts\mp\bots\_bots_powers::useprompt(param_00, param_01, 450, ::func_1307D);
  thread scripts\mp\bots\_bots_powers::usequickrope(param_00, param_01, 450, 80, ::func_1307D);
}

func_C166(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon(param_01);
  param_00 waittill("death");
  self notify(param_01);
}

func_10E69() {
  thread func_C166(self.var_5906, "StayInShieldElapsed");
  thread func_B9D2(250, "StayInShieldElapsed");
  var_00 = getclosestpointonnavmesh(self.var_5906.origin, self);
  self.var_5906 = undefined;
  self botsetscriptgoal(var_00, 16, "critical");
  thread cleanupdomeshield();
}

func_B9D2(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon(param_01);
  var_02 = param_00 * param_00;
  for(;;) {
    if(isDefined(self.isnodeoccupied)) {
      var_03 = distancesquared(self.origin, self.isnodeoccupied.origin);
      if(var_03 < var_02) {
        self notify(param_01);
        break;
      }
    }

    wait(0.25);
  }
}

func_1307D(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("domeshield_used");
  scripts\mp\bots\_bots_powers::usepowerweapon(param_00, param_01);
  while(!isDefined(self.var_5906)) {
    wait(0.05);
  }

  func_10E69();
}

cleanupdomeshield() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self waittill("StayInShieldElapsed");
  self botclearscriptgoal();
}