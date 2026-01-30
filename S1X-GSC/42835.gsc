/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42835.gsc
**************************************/

stock_think() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self.has_stock = 0;

  for(;;) {
    if(!self.has_stock) {
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