/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\c4.gsc
***********************************************/

c4_set(var_0, var_1) {
  level.brmini_cleanupents = getdvarfloat("_encstr_825D207B22DBA0205A752B11B70672683F6A13663AFF6D38B579E9238FAFB049E7D3", 0.75);
  thread c4_watchforaltdetonation();
}

c4_used(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  scripts\mp\utility\print::printgameaction("_encstr_85850991BF7A4E70B69F3D", var_0.owner);
  var_0.throwtime = gettime();
  var_0 scripts\cp_mp\ent_manager::registerspawn(1, ::sweepc4);
  c4_addtoarray(var_0.owner, var_0);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();

  if(scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E"))
    var_0.hasruggedeqp = 1;

  var_0 thread scripts\mp\weapons::minedamagemonitor();
  var_0 thread c4_explodeonnotify();
  var_0 thread c4_destroyongameend();
  var_0 thread scripts\mp\equipment_interact::remoteinteractsetup(::c4_detonate, 1, 0);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  scripts\mp\weapons::onequipmentplanted(var_0, "_encstr_843D095F2B7D52B041D9A3", ::c4_delete);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 thread scripts\mp\weapons::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);
  var_0 scripts\mp\sentientpoolmanager::registersentient("_encstr_849C0E9130898B0EE380AF2867D8882A", var_0.owner, 1);
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::c4_empapplied);
  var_0 thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  var_0 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A24E069389FFAA3C", 0);
  thread scripts\mp\weapons::outlineequipmentforowner(var_0);
  var_0 missilethermal();
  var_0 missileoutline();
  var_0.headiconid = var_0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
  var_0 c4_updatedangerzone();
}

c4_updatedangerzone() {
  if(istrue(level.iscacprimaryweapongroup)) {
    return;
  }
  if(isDefined(self.dangerzone))
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);

  var_0 = (self.origin[0], self.origin[1], self.origin[2] - 50.0);
  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(var_0, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 100, self.owner.team, undefined, self.owner, 0, self, 1);
}

c4_detonate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  else
    var_0 = self.owner;

  wait 0.1;
  thread c4_explode(var_0);
}

c4_explode(var_0) {
  scripts\mp\utility\print::printgameaction("_encstr_8D9D0D8D0D02D1C9D2B376CAC9AC23", self.owner);
  level notify("_encstr_87051569430389C06AD9777DC7D7404DCFBAA193BAD733", self.origin, 256, self.owner, self);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.origin;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 1, 0, 0, 0);
  var_5 = vectordot((0, 0, 1), anglestoup(self.angles));

  if(abs(var_5) <= 0.81915) {
    var_6 = var_3 - anglestoup(self.angles) * 5;
    var_7 = physics_raycast(var_3, var_6, var_4, self, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_1 = 5;
      var_2 = "_encstr_AF560CCB78E2984063BA0FF1127B";
    }
  } else if(var_5 <= -0.96592) {
    var_6 = var_3 - anglestoup(self.angles) * 5;
    var_7 = physics_raycast(var_3, var_6, var_4, self, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_1 = 5;
      var_2 = "_encstr_AF560CCB78E2984063BA0FF1127B";
    }
  }

  if(!isDefined(var_1)) {
    var_6 = var_3 - (0, 0, 20);
    var_7 = physics_raycast(var_3, var_6, var_4, self, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(!isDefined(var_7) || var_7.size <= 0) {
      var_1 = 5;
      var_2 = "_encstr_860F0B326A5FDBB550B3C1E175";
    }
  }

  if(!isDefined(var_1)) {
    var_1 = 5;
    var_2 = "_encstr_860808CB78E2984063BA";
  }

  thread c4_delete(var_1);
  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", var_2, 0);
}

sweepc4() {
  thread c4_delete();
}

c4_destroy(var_0) {
  thread c4_delete(5);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_AFCB082AC1D6A3EA7B73", 0);
  self setscriptablepartstate("_encstr_BE64070B9B5E42C718", "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

c4_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("_encstr_88DD0C8047A3D007E37217AE8DDA", "_encstr_BA19049F4B2D");
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  var_1 = self.owner;

  if(isDefined(var_1)) {
    c4_removefromarray(var_1, self, self getentitynumber());
    var_1 scripts\mp\weapons::removeequip(self);
    var_1 notify("_encstr_B6E80AE6BBC14D331DEBF38F", 0);
  }

  thread c4_resetscriptableonunlink();

  if(isDefined(var_0))
    wait(var_0);

  self delete();
}

c4_resetscriptableonunlink() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.5;
  var_0 = self getlinkedparent();

  if(isDefined(var_0)) {
    var_0 waittill("_encstr_AD75063D571AE108");
    self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  }
}

c4_explodeonnotify() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.owner;
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_1);

  if(isDefined(var_1))
    thread c4_explode(var_1);
  else
    thread c4_explode(var_0);
}

c4_empapplied(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  var_3 = "_encstr_B40101";

  if(istrue(self.hasruggedeqp))
    var_3 = "_encstr_A2FB098A2035874AB0F358";

  if(isPlayer(var_1))
    var_1 scripts\mp\damagefeedback::updatedamagefeedback(var_3);

  thread c4_destroy();
}

c4_destroyongameend() {
  self endon("_encstr_AD75063D571AE108");
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1", "_encstr_935E0F139CF6D76E1A7B3AEB6E1D85E4D1");
  thread c4_destroy();
}

c4_validdetonationstate() {
  if(!scripts\mp\utility\player::isreallyalive(self))
    return 0;

  if(scripts\mp\utility\player::isusingremote())
    return 0;

  if(!isDefined(self.c4s) || self.c4s.size <= 0)
    return 0;

  return 1;
}

c4_candetonate() {
  return (gettime() - self.throwtime) / 1000 > 0.3;
}

c4_watchfordetonation() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AF630952E3C8BFF5E8B3F4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_AA2813B3190951B9E59F204CA9BB30E5E6732897ED");
  self endon("_encstr_AA2813B3190951B9E59F204CA9BB30E5E6732897ED");

  for(;;) {
    self waittill("_encstr_BDE80911CA4B20E0D6FC4B");

    if(self getheldoffhand().basename == "_encstr_9AAE0876FCB7603101DB" || self getheldoffhand().basename == "_encstr_B14F0C678148B28D585B90111030")
      thread c4_detonateall();
  }
}

c4_watchforaltdetonation() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AF630952E3C8BFF5E8B3F4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_821616EE2C8EB1A123DB4EA0B14711AC1D7BB985E8D2B737");
  self endon("_encstr_821616EE2C8EB1A123DB4EA0B14711AC1D7BB985E8D2B737");

  while(self useButtonPressed())
    waitframe();

  var_0 = gettime();
  var_1 = 0;
  var_2 = level.framedurationseconds;

  for(;;) {
    if(self useButtonPressed()) {
      var_1 = 0;

      while(self useButtonPressed()) {
        var_1 = var_1 + var_2;
        wait(var_2);
      }

      if(var_1 >= 0.5) {
        continue;
      }
      var_1 = 0;

      while(!self useButtonPressed() && var_1 < 0.25) {
        var_1 = var_1 + var_2;
        wait(var_2);
      }

      if(var_1 >= 0.25) {
        continue;
      }
      if(c4_validdetonationstate()) {
        self playsoundtoplayer("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF", self);

        while(gettime() - var_0 <= level.brmini_cleanupents * 1000) {
          waitframe();
          continue;
        }

        thread c4_detonateall();
      }
    }

    waitframe();
  }
}

c4_animdetonate() {
  var_0 = getcompleteweaponname("_encstr_B14F0C678148B28D585B90111030");
  self giveandfireoffhand(var_0);
  thread c4_animdetonatecleanup();
}

c4_animdetonatecleanup() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_BA9519D843BE0BCDB4AD11563A7B37B0E82B0D63CA2CDCAB388249");
  self endon("_encstr_BA9519D843BE0BCDB4AD11563A7B37B0E82B0D63CA2CDCAB388249");
  var_0 = getcompleteweaponname("_encstr_B14F0C678148B28D585B90111030");
  wait 1;

  if(self hasweapon(var_0))
    self takeweapon(var_0);
}

c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(var_1 in self.c4s) {
      if(var_1 c4_candetonate())
        var_1 thread c4_detonate();
    }
  }
}

c4_onownerchanged(var_0) {
  if(istrue(self.exploding)) {
    return;
  }
  c4_removefromarray(var_0, self, self getentitynumber());
  thread c4_destroy();
}

c4_resetaltdetonpickup() {
  if(scripts\mp\equipment::hasequipment("_encstr_843D095F2B7D52B041D9A3"))
    thread c4_watchforaltdetonation();
}

c4_addtoarray(var_0, var_1) {
  if(!isDefined(var_0.c4s))
    var_0.c4s = [];

  var_2 = var_1 getentitynumber();
  var_0.c4s[var_2] = var_1;
  thread c4_removefromarrayondeath(var_0, var_1, var_2);
}

c4_removefromarray(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_1 notify("_encstr_AB4113E3E9791A1F3978FBF2658E7F95D10D8A69EB");

  if(isDefined(var_0) && isDefined(var_0.c4s))
    var_0.c4s[var_2] = undefined;
}

c4_removefromarrayondeath(var_0, var_1, var_2) {
  var_1 endon("_encstr_AB4113E3E9791A1F3978FBF2658E7F95D10D8A69EB");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 waittill("_encstr_AD75063D571AE108");
  thread c4_removefromarray(var_0, var_1, var_2);
}