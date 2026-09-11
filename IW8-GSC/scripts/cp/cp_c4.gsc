/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_c4.gsc
***********************************************/

function c4_used(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  thread c4_deleteonownerdisconnect(var_0);
  var_0.throwtime = gettime();
  var_0.deletefunc = &c4_delete;
  c4_addtoarray(var_0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  thread c4_explodeonnotify();
  var_0 waittill("missile_stuck");
  scripts\cp\cp_weapon::onlethalequipmentplanted(var_0, "power_c4");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0 thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);
  var_0 setscriptablepartstate("effects", "plant", 0);
  var_0.headiconid = var_0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
}

function c4_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  wait 0.1;
  thread c4_explode(self.owner);
}

function c4_explode(var_0) {
  thread c4_delete(5);
  level notify("grenade_exploded_during_stealth", self, "c4_mp_p", var_0.name);
  self setentityowner(var_0);
  self setscriptablepartstate("effects", "explode", 0);
}

function c4_destroy(var_0) {
  thread c4_delete(2);
  self setscriptablepartstate("effects", "destroy", 0);
}

function c4_delete(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);
    var_1 notify("c4_update", 0);
  }

  if(isDefined(var_0)) {
    wait var_0;
  }

  self delete();
}

function c4_explodeonnotify() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);

  if(isDefined(var_1)) {
    thread c4_explode(var_1);
    return;
  }

  thread c4_explode(var_0);
}

function c4_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", var_0, var_1);

  if(isDefined(self.owner) && var_0 != self.owner) {
    var_0 notify("destroyed_equipment");
  }

  thread c4_destroy();
}

function c4_candetonate(var_0) {
  return (gettime() - self.throwtime) / 1000 > 0.3 && !isDefined(self.detonationtime);
}

function c4_watchfordetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");
  var_0 = getcompleteweaponname("c4_mp_p");

  for(;;) {
    self waittillmatch("detonate", var_0);
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
  var_0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var_0 = 0;

      while(self useButtonPressed()) {
        var_0 += 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.5) {
        continue;
      }

      var_0 = 0;

      while(!self useButtonPressed() && var_0 < 0.5) {
        var_0 += 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.5) {
        continue;
      }

      thread c4_detonateall();
    }

    wait 0.05;
  }
}

function c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var_1 in self.c4s) {
      if(c4_candetonate(var_1)) {
        thread c4_detonate();
      }
    }

    return;
  }
}

function c4_addtoarray(var_0) {
  var_1 = self.owner;

  if(!isDefined(self.c4s)) {
    self.c4s = [];
  }

  self.c4s[var_0 getentitynumber()] = var_0;
  thread c4_removefromarrayondeath(var_0);
}

function c4_removefromarray(var_0) {
  if(!isDefined(self.c4s)) {
    return;
  }

  self.c4s[var_0] = undefined;
}

function c4_removefromarrayondeath(var_0) {
  self endon("disconnect");
  var_1 = var_0 getentitynumber();
  var_0 waittill("death");
  c4_removefromarray(var_1);
}

function c4_deleteonownerdisconnect(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_0 waittill("disconnect");
  self delete();
}