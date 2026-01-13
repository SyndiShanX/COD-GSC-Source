/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3335.gsc
************************/

c4_used(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 thread c4_deleteonownerdisconnect(self);
  var_0.throwtime = gettime();
  c4_addtoarray(var_0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  var_0 thread c4_explodeonnotify();
  var_0 waittill("missile_stuck");
  scripts\cp\cp_weapon::onlethalequipmentplanted(var_0, "power_c4");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0 setscriptablepartstate("plant", "active", 0);
}

c4_detonate() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  wait(0.1);
  thread c4_explode(self.triggerportableradarping);
}

c4_explode(var_0) {
  thread c4_delete(5);
  self setentityowner(var_0);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
}

c4_destroy(var_0) {
  thread c4_delete(2);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

c4_delete(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self.exploding = 1;
  var_1 = self.triggerportableradarping;
  if(isDefined(self.triggerportableradarping)) {
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);
    var_1 notify("c4_update", 0);
  }

  wait(var_0);
  self delete();
}

c4_explodeonnotify() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  var_0 = self.triggerportableradarping;
  self waittill("detonateExplosive", var_1);
  if(isDefined(var_1)) {
    thread c4_explode(var_1);
    return;
  }

  thread c4_explode(var_0);
}

c4_destroyonemp() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self waittill("emp_damage", var_0, var_1);
  if(isDefined(self.triggerportableradarping) && var_0 != self.triggerportableradarping) {
    var_0 notify("destroyed_equipment");
  }

  thread c4_destroy();
}

c4_candetonate(var_0) {
  return gettime() - self.throwtime / 1000 > 0.3 && !isDefined(self.var_53D7);
}

c4_watchfordetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");
  for(;;) {
    self waittillmatch("c4_zm", "detonate");
    thread c4_detonateall();
  }
}

c4_watchforaltdetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");
  var_0 = 0;
  for(;;) {
    if(self usebuttonpressed()) {
      var_0 = 0;
      while(self usebuttonpressed()) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= 0.5) {
        continue;
      }

      var_0 = 0;
      while(!self usebuttonpressed() && var_0 < 0.5) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= 0.5) {
        continue;
      }

      if(!scripts\cp\powers\coop_phaseshift::isentityphaseshifted(self) && !scripts\cp\utility::isusingremote() && scripts\cp\utility::isreallyalive(self)) {
        thread c4_detonateall();
      }
    }

    wait(0.05);
  }
}

c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var_1 in self.c4s) {
      if(var_1 c4_candetonate()) {
        var_1 thread c4_detonate();
      }
    }
  }
}

c4_addtoarray(var_0) {
  var_1 = self.triggerportableradarping;
  if(!isDefined(self.c4s)) {
    self.c4s = [];
  }

  self.c4s[var_0 getentitynumber()] = var_0;
  thread c4_removefromarrayondeath(var_0);
}

c4_removefromarray(var_0) {
  if(!isDefined(self.c4s)) {
    return;
  }

  self.c4s[var_0] = undefined;
}

c4_removefromarrayondeath(var_0) {
  self endon("disconnect");
  var_1 = var_0 getentitynumber();
  var_0 waittill("death");
  c4_removefromarray(var_1);
}

c4_deleteonownerdisconnect(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_0 waittill("disconnect");
  self delete();
}