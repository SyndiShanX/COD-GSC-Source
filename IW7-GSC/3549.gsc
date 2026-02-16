/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3549.gsc
*********************************************/

c4_set(var_0) {
  thread c4_watchforaltdetonation();
}

c4_used(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  scripts\mp\utility::printgameaction("c4 spawn", var_0.owner);
  var_0.throwtime = gettime();
  c4_addtoarray(var_0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  if(scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_0.hasruggedeqp = 1;
  }

  var_0 thread scripts\mp\weapons::minedamagemonitor();
  var_0 thread c4_explodeonnotify();
  var_0 thread c4_destroyongameend();
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 waittill("missile_stuck");
  var_0 setotherent(self);
  var_0 give_player_tickets(1);
  scripts\mp\weapons::onlethalequipmentplanted(var_0, "power_c4");
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  var_0 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", var_0.owner, 1);
  var_0 thread c4_destroyonemp();
  var_0 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  var_0 setscriptablepartstate("plant", "active", 0);
  thread scripts\mp\weapons::outlineequipmentforowner(var_0, self);
  var_0 missilethermal();
  var_0 missileoutline();
  var_0 thread scripts\mp\entityheadicons::setheadicon_factionimage(self, (0, 0, 20), 0.1);
}

c4_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  wait(0.1);
  thread c4_explode(self.owner);
}

c4_explode(var_0) {
  scripts\mp\utility::printgameaction("c4 triggered", self.owner);
  thread c4_delete(0.1);
  self setentityowner(var_0);
  self func_8593();
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
}

c4_destroy(var_0) {
  thread c4_delete(0.1);
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

c4_delete(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self.exploding = 1;
  var_1 = self.owner;
  if(isDefined(self.owner)) {
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);
    var_1 notify("c4_update", 0);
  }

  wait(var_0);
  self delete();
}

c4_explodeonnotify() {
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

c4_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", var_0, var_1, var_2, var_3, var_4);
  if(isDefined(var_3) && var_3 == "emp_grenade_mp") {
    if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.owner, var_0))) {
      var_0 scripts\mp\missions::func_D991("ch_tactical_emp_eqp");
    }
  }

  if(scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 scripts\mp\killstreaks\killstreaks::func_83A0();
  }

  var_5 = "";
  if(scripts\mp\utility::istrue(self.hasruggedeqp)) {
    var_5 = "hitequip";
  }

  if(isPlayer(var_0)) {
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_5);
  }

  thread c4_destroy();
}

c4_destroyongameend() {
  self endon("death");
  level scripts\engine\utility::waittill_any("game_ended", "bro_shot_start");
  thread c4_destroy();
}

c4_validdetonationstate() {
  if(!scripts\mp\utility::isreallyalive(self)) {
    return 0;
  }

  if(scripts\mp\utility::isusingremote()) {
    return 0;
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(self)) {
    return 0;
  }

  if(scripts\mp\supers\super_reaper::isusingreaper()) {
    return 0;
  }

  if(self func_84CA()) {
    return 0;
  }

  if(self func_8568()) {
    return 0;
  }

  return 1;
}

c4_candetonate() {
  return gettime() - self.throwtime / 1000 > 0.3;
}

c4_watchfordetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");
  for(;;) {
    self waittill("detonate");
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
  while(self useButtonPressed()) {
    scripts\engine\utility::waitframe();
  }

  var_0 = 0;
  for(;;) {
    if(self useButtonPressed()) {
      var_0 = 0;
      while(self useButtonPressed()) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= 0.5) {
        continue;
      }

      var_0 = 0;
      while(!self useButtonPressed() && var_0 < 0.25) {
        var_0 = var_0 + 0.05;
        wait(0.05);
      }

      if(var_0 >= 0.25) {
        continue;
      }

      if(c4_validdetonationstate()) {
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

c4_resetaltdetonpickup() {
  if(scripts\mp\powers::hasequipment("power_c4")) {
    thread c4_watchforaltdetonation();
  }
}

c4_addtoarray(var_0) {
  var_1 = self.owner;
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