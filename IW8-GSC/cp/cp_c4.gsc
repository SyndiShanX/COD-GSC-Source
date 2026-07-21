/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_c4.gsc
***********************************************/

c4_used(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread c4_deleteonownerdisconnect(self);
  var_0.throwtime = gettime();
  var_0.deletefunc = ::c4_delete;
  c4_addtoarray(var_0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  var_0 thread c4_explodeonnotify();
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  scripts\cp\cp_weapon::onlethalequipmentplanted(var_0, "_encstr_8D7C09102FE7216D71A66D");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0 thread scripts\cp\cp_equipment::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A24E069389FFAA3C", 0);
  var_0.headiconid = var_0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
}

c4_detonate() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.1;
  thread c4_explode(self.owner);
}

c4_explode(var_0) {
  thread c4_delete(5);
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", self, "_encstr_9AAE0876FCB7603101DB", var_0.name);
  self setentityowner(var_0);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_860808CB78E2984063BA", 0);
}

c4_destroy(var_0) {
  thread c4_delete(2);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_AFCB082AC1D6A3EA7B73", 0);
}

c4_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  level.mines[self getentitynumber()] = undefined;
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);
    var_1 notify("_encstr_B6E80AE6BBC14D331DEBF38F", 0);
  }

  if(isDefined(var_0))
    wait(var_0);

  self delete();
}

c4_explodeonnotify() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.owner;
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_1);

  if(isDefined(var_1))
    thread c4_explode(var_1);
  else
    thread c4_explode(var_0);
}

c4_destroyonemp() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_93F60B2B5BC1EB912C5BB0ECB2", var_0, var_1);

  if(isDefined(self.owner) && var_0 != self.owner)
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");

  thread c4_destroy();
}

c4_candetonate(var_0) {
  return (gettime() - self.throwtime) / 1000 > 0.3 && !isDefined(self.detonationtime);
}

c4_watchfordetonation() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF630952E3C8BFF5E8B3F4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_AA2813B3190951B9E59F204CA9BB30E5E6732897ED");
  self endon("_encstr_AA2813B3190951B9E59F204CA9BB30E5E6732897ED");
  var_0 = getcompleteweaponname("_encstr_9AAE0876FCB7603101DB");

  for(;;) {
    self waittillmatch("_encstr_BDE80911CA4B20E0D6FC4B", var_0);
    thread c4_detonateall();
  }
}

c4_watchforaltdetonation() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF630952E3C8BFF5E8B3F4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_821616EE2C8EB1A123DB4EA0B14711AC1D7BB985E8D2B737");
  self endon("_encstr_821616EE2C8EB1A123DB4EA0B14711AC1D7BB985E8D2B737");
  var_0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var_0 = 0;

      while(self useButtonPressed()) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.5) {
        continue;
      }
      var_0 = 0;

      while(!self useButtonPressed() && var_0 < 0.5) {
        var_0 = var_0 + 0.05;
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

c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var_1 in self.c4s) {
      if(var_1 c4_candetonate())
        var_1 thread c4_detonate();
    }
  }
}

c4_addtoarray(var_0) {
  var_1 = self.owner;

  if(!isDefined(self.c4s))
    self.c4s = [];

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
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = var_0 getentitynumber();
  var_0 waittill("_encstr_AD75063D571AE108");
  c4_removefromarray(var_1);
}

c4_deleteonownerdisconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  self delete();
}