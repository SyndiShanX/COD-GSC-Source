/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_fastheal.gsc
*****************************************/

watchfasthealusage() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  if(!isDefined(level.fasthealsettings)) {
    fasthealinit();
  }

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "fast_heal_mp") {
      if(!isalive(self)) {
        var_0 delete();
        return;
      }

      thread tryusefastheal();
    }
  }
}

fasthealinit() {
  self.fasthealsettings = spawnStruct();
}

tryusefastheal() {
  if(!isDefined(self.fasthealsettings)) {
    fasthealinit();
  }

  resetfastheal();
  thread startfastheal();
  thread monitorplayerdeath();
  return 1;
}

startfastheal() {
  self endon("ClearFastHeal");
  self endon("death");
  self playlocalsound("earn_superbonus");
  self.isfastheal = 1;
  self._id_50A0 = 1;
  self._id_98E1 = 1.5;
  self._id_98E2 = 13.33;
  self notify("damage");
  wait 10;
  self._id_98E1 = undefined;
  self._id_98E2 = undefined;
  self.isfastheal = 0;

  if(isDefined(self.fasthealsettings.overlay)) {
    self.fasthealsettings.overlay destroy();
  }

  self notify("EndFastHeal");
}

resetfastheal() {
  if(isDefined(self.isfastheal) && self.isfastheal == 1) {
    if(isDefined(self.fasthealsettings.overlay)) {
      self.fasthealsettings.overlay destroy();
    }

    self._id_98E1 = undefined;
    self._id_98E2 = undefined;
    self notify("ClearFastHeal");
  }
}

monitorplayerdeath() {
  self endon("EndFastHeal");
  self waittill("death");
  self._id_98E1 = undefined;
  self._id_98E2 = undefined;
  self.isfastheal = 0;

  if(isDefined(self.fasthealsettings.overlay)) {
    self.fasthealsettings.overlay destroy();
  }
}

printhealthtoscreen() {
  self endon("EndFastHeal");
  self endon("death");

  for(;;) {
    _iprintlnbold(self.health);
    wait 1;
  }
}