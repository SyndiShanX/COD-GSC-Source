/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3447.gsc
*********************************************/

func_8995(var_0, var_1) {
  thread scripts\mp\bots\_bots_powers::useprompt(var_0, var_1, 450, ::func_1307D);
  thread scripts\mp\bots\_bots_powers::usequickrope(var_0, var_1, 450, 80, ::func_1307D);
}

func_C166(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon(var_1);
  var_0 waittill("death");
  self notify(var_1);
}

func_10E69() {
  thread func_C166(self.var_5906, "StayInShieldElapsed");
  thread func_B9D2(250, "StayInShieldElapsed");
  var_0 = getclosestpointonnavmesh(self.var_5906.origin, self);
  self.var_5906 = undefined;
  self botsetscriptgoal(var_0, 16, "critical");
  thread cleanupdomeshield();
}

func_B9D2(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon(var_1);
  var_2 = var_0 * var_0;
  for(;;) {
    if(isDefined(self.enemy)) {
      var_3 = distancesquared(self.origin, self.enemy.origin);
      if(var_3 < var_2) {
        self notify(var_1);
        break;
      }
    }

    wait(0.25);
  }
}

func_1307D(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("domeshield_used");
  scripts\mp\bots\_bots_powers::usepowerweapon(var_0, var_1);
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