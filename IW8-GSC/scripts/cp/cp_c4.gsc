/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_c4.gsc
***********************************************/

function c4_used(var0) {
  self endon("disconnect");
  var0 endon("death");
  thread c4_deleteonownerdisconnect(var0);
  var0.throwtime = gettime();
  var0.deletefunc = &c4_delete;
  c4_addtoarray(var0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  thread c4_explodeonnotify();
  var0 waittill("missile_stuck");
  scripts\cp\cp_weapon::onlethalequipmentplanted(var0, "power_c4");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var0);
  var0 thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);
  var0 setscriptablepartstate("effects", "plant", 0);
  var0.headiconid = var0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
}

function c4_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  wait 0.1;
  thread c4_explode(self.owner);
}

function c4_explode(var0) {
  thread c4_delete(5);
  level notify("grenade_exploded_during_stealth", self, "c4_mp_p", var0.name);
  self setentityowner(var0);
  self setscriptablepartstate("effects", "explode", 0);
}

function c4_destroy(var0) {
  thread c4_delete(2);
  self setscriptablepartstate("effects", "destroy", 0);
}

function c4_delete(var0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  var1 = self.owner;

  if(isDefined(self.owner)) {
    var1.plantedlethalequip = scripts\engine\utility::array_remove(var1.plantedlethalequip, self);
    var1 notify("c4_update", 0);
  }

  if(isDefined(var0)) {
    wait var0;
  }

  self delete();
}

function c4_explodeonnotify() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var0 = self.owner;
  self waittill("detonateExplosive", var1);

  if(isDefined(var1)) {
    thread c4_explode(var1);
    return;
  }

  thread c4_explode(var0);
}

function c4_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", var0, var1);

  if(isDefined(self.owner) && var0 != self.owner) {
    var0 notify("destroyed_equipment");
  }

  thread c4_destroy();
}

function c4_candetonate(var0) {
  return (gettime() - self.throwtime) / 1000 > 0.3 && !isDefined(self.detonationtime);
}

function c4_watchfordetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");
  var0 = getcompleteweaponname("c4_mp_p");

  for(;;) {
    self waittillmatch("detonate", var0);
    thread c4_detonateall();
  }
}

function c4_watchforaltdetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");
  var0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var0 = 0;

      while(self useButtonPressed()) {
        var0 += 0.05;
        wait 0.05;
      }

      if(var0 >= 0.5) {
        continue;
      }

      var0 = 0;

      while(!self useButtonPressed() && var0 < 0.5) {
        var0 += 0.05;
        wait 0.05;
      }

      if(var0 >= 0.5) {
        continue;
      }

      thread c4_detonateall();
    }

    wait 0.05;
  }
}

function c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var1 in self.c4s) {
      if(c4_candetonate(var1)) {
        thread c4_detonate();
      }
    }

    return;
  }
}

function c4_addtoarray(var0) {
  var1 = self.owner;

  if(!isDefined(self.c4s)) {
    self.c4s = [];
  }

  self.c4s[var0 getentitynumber()] = var0;
  thread c4_removefromarrayondeath(var0);
}

function c4_removefromarray(var0) {
  if(!isDefined(self.c4s)) {
    return;
  }

  self.c4s[var0] = undefined;
}

function c4_removefromarrayondeath(var0) {
  self endon("disconnect");
  var1 = var0 getentitynumber();
  var0 waittill("death");
  c4_removefromarray(var1);
}

function c4_deleteonownerdisconnect(var0) {
  self endon("death");
  self endon("missile_stuck");
  var0 waittill("disconnect");
  self delete();
}