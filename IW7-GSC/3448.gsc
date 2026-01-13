/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3448.gsc
************************/

_meth_80F1() {
  foreach(var_1 in self.rewindorigins) {
    return var_1;
  }

  return undefined;
}

func_E4D6() {
  if(!isDefined(self.rewindorigins) || self.rewindorigins.size < 0) {
    return 0;
  }

  var_0 = _meth_80F1();
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = distancesquared(self.origin, var_0);
  if(var_1 < -25536) {
    return 0;
  }

  return 1;
}

func_89DC(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("powers_cleanUp");
  for(;;) {
    self waittill("damage");
    if(isDefined(self.isnodeoccupied)) {
      if(!self getteamsize() && self.isnodeoccupied.health < self.health) {
        continue;
      }
    }

    if(!func_E4D6()) {
      continue;
    }

    if(scripts\mp\bots\_bots_powers::func_8BEE()) {
      if(self.health < 90) {
        scripts\mp\bots\_bots_powers::usepowerweapon(var_0, var_1);
        break;
      }
    }
  }
}