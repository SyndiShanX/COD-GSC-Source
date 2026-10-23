/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_specialty_stalker.gsc
**************************************************/

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

      waitframe();
      continue;
    }

    if(!self hasperk("specialty_stalker", 1)) {
      self setperk("specialty_stalker", 1, 0);
    }

    waitframe();
  }
}