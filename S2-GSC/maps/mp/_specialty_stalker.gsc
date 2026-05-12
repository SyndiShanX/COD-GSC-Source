/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_specialty_stalker.gsc
*********************************************/

func_93B0() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.var_4B45 = 0;
  for(;;) {
    if(!self.var_4B45) {
      if(self hasperk("specialty_stalker", 1)) {
        self unsetperk("specialty_stalker", 1);
      }

      wait 0.05;
      continue;
    }

    if(!self hasperk("specialty_stalker", 1)) {
      self setperk("specialty_stalker", 1, 0);
    }

    wait 0.05;
  }
}