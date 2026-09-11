/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\incendiarylauncher.gsc
*******************************************************/

function init() {
  thread firemanager();
}

function firemanager() {
  self.offhands = spawnStruct();
  self.offhands.lastusedoffhandweapon = undefined;
  self.offhands.lastusedoffhandtime = 0;

  for(;;) {
    self waittill("missile_fire", var0, var1);

    if(var1.basename == "iw8_la_mike32_incendiary") {
      thread watchforimpact();
    }
  }
}

function watchforimpact() {
  self endon("entitydeleted");
  var0 = getmissileowner(self);
  self waittill("explode", var1, var2, var3, var4);
  scripts\sp\equipment\molotov::molotovexplode(var1, var2, var3, var4, var0);
}