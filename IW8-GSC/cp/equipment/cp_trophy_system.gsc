/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\equipment\cp_trophy_system.gsc
***********************************************/

trophy_init() {
  var_0 = spawnStruct();
  var_0.tags = [];
  var_0.tags[0] = "_encstr_B235159A4F706A47CAA93A533011A7E9CA3B371A4B9BF7";
  var_0.tags[1] = "_encstr_8DD81553F50EC9BD9A59D88EB41BCAFAC046AF132CB9B2";
  var_0.tags[2] = "_encstr_93EF150351A3C2426D0D1ED36339BAA7038A5FBB483B0D";
  var_0.tags[3] = "_encstr_A24E15FBEF776B271091EE33087875F1EF81A7437B1EC2";
  level.trophy = var_0;
}

trophy_used(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  var_0.usedcount = 0;
  var_2 = scripts\cp\utility::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E");

  if(var_2)
    var_0.hasruggedeqp = 1;

  var_0.ammo = trophy_removestored();

  if(!isDefined(var_0.ammo))
    var_0.ammo = 2;

  scripts\cp\cp_weapon::ontacticalequipmentplanted(var_0, "_encstr_AA870D15FAF37393C74318F8BB184A");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0.explosion = trophy_createexplosion(var_0);
  var_3 = scripts\engine\utility::ter_op(var_2, 200, 100);
  var_4 = scripts\engine\utility::ter_op(var_2, "_encstr_A2FB098A2035874AB0F358", "_encstr_B40101");
  var_0 thread scripts\cp\cp_weapon::monitordamage(var_3, var_4, ::trophy_handlefataldamage, ::trophy_handledamage, 0);
  var_0 thread trophy_destroyonemp();
  var_0 thread trophy_destroyongameend();
  var_0 thread trophy_watchprotection();
  var_0 missilethermal();
  var_0 missileoutline();
  var_0 thread trophy_deploysequence();
}

trophy_destroy(var_0) {
  var_0 = istrue(var_0);
  var_1 = 0.1;

  if(var_0)
    var_1 = var_1 + 0.5;

  thread trophy_delete(var_1);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8D31132C1B3AA567CA88B2B93A4E7BE56A1D85278E", 0);

  if(var_0)
    wait 0.5;

  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C94112F46DB4B5BF59BA8E0A31AB0A310AD15", 0);
}

trophy_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  }

  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner) && !istrue(self.issuper)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8"))
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8")]]("_encstr_9B2F0D5B9D2BB782A7B02BF27821B8", self.usedcount);

    var_1.plantedtacticalequip = scripts\engine\utility::array_remove(var_1.plantedtacticalequip, self);
    var_1 notify("_encstr_BDF50E3B33C8439C402FEDD061B8A35F", 0);
  } else if(isDefined(self.owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8"))
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8")]]("_encstr_9B2F0D5B9D2BB782A7B02BF27821B8", self.usedcount);

    var_1.activesupertrophies = scripts\engine\utility::array_remove(var_1.activesupertrophies, self);
    var_1 notify("_encstr_BDF50E3B33C8439C402FEDD061B8A35F", 0);
  }

  wait(var_0);
  self delete();
}

trophy_deploysequence() {
  self endon("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A55C12F8C2EB2B33974CBD2F4C971AE7534AF8D8");
  wait 1.25;
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C0410C21BE8B4D9CA22953836DECB519B8C");
}

trophy_watchprotection() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(level.grenades))
    level.grenades = [];

  if(!isDefined(level.missiles))
    level.missiles = [];

  if(!isDefined(level.mines))
    level.mines = [];

  if(!isDefined(level._id_11D34))
    level._id_11D34 = [];

  var_0 = trophy_castcontents();

  for(;;) {
    var_1 = trophy_castorigin();
    var_2 = [];
    var_2[0] = level.grenades;
    var_2[1] = level.missiles;
    var_2[2] = level.mines;
    var_2[3] = level._id_11D34;
    var_3 = scripts\engine\utility::array_combine_multiple(var_2);

    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(istrue(var_5.exploding)) {
        continue;
      }
      if(trophy_checkignorelist(var_5)) {
        continue;
      }
      var_6 = var_5.owner;

      if(!isDefined(var_6) && isDefined(var_5.weapon_name) && weaponclass(var_5.weapon_name) == "_encstr_8C8D08671D451291C849")
        var_6 = getmissileowner(var_5);

      if(isDefined(var_6) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_6))) {
        continue;
      }
      if(distancesquared(var_5.origin, self.origin) > trophy_modifiedprotectiondistsqr(var_5, 65536)) {
        continue;
      }
      var_7 = physics_raycast(var_1, var_5.origin, var_0, [self, var_5], 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

      if(isDefined(var_7) && var_7.size > 0) {
        continue;
      }
      trophy_protectionsuccessful(var_5);
    }

    waitframe();
  }
}

trophy_protectionsuccessful(var_0) {
  var_0 setCanDamage(0);
  var_0.exploding = 1;
  var_0 stopsounds();
  trophy_startcooldownlist(var_0);
  trophy_notifytrophytargetowner(var_0, "_encstr_92EA0A290B32FF88A90170EB", self.owner);
  var_1 = var_0.origin;
  var_2 = var_0.angles;

  if(scripts\cp\cp_weapon::isplantedequipment(var_0))
    var_0 scripts\cp\cp_weapon::deleteexplosive();
  else
    var_0 delete();

  var_3 = trophy_getbesttag(var_1);
  var_4 = trophy_getpartbytag(var_3);
  self setscriptablepartstate(var_4, "_encstr_930B07BB1B6B3854FF", 0);
  self.explosion thread trophy_explode(var_1, var_2);
  self.usedcount++;
  self.ammo--;

  if(self.ammo <= 0)
    thread trophy_destroy(1);
}

trophy_handledamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_4;
  return var_5;
}

trophy_handlefataldamage(var_0) {
  var_1 = var_0.attacker;
  trophy_givepointsfordeath(var_1);
  thread trophy_destroy();
}

trophy_destroyonemp() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AB770C81EB09798E707B29137D77", var_0);
  var_1 = var_0.attacker;
  trophy_givepointsfordeath(var_1);
  trophy_givedamagefeedback(var_1);
  thread trophy_destroy(1);
}

trophy_destroyongameend() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1", "_encstr_935E0F139CF6D76E1A7B3AEB6E1D85E4D1");
  thread trophy_destroy();
}

trophy_pickup() {
  if(self.owner scripts\cp\cp_equipment::hasequipment("_encstr_AA870D15FAF37393C74318F8BB184A"))
    self.owner trophy_addstored(self.ammo);
}

trophy_createexplosion(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.killcament = var_0;
  var_1.owner = var_0.owner;
  var_1.team = var_0.team;
  var_1.equipmentref = var_0.equipmentref;
  var_1.weapon_name = var_0.weapon_name;
  var_1 setotherent(var_1.owner);
  var_1 setentityowner(var_1.owner);
  var_1 setModel("_encstr_B4B2194727DE0EA1F2BEE65E6EE856ADF56BC1BE2B0FC1C6BDC856");
  var_1.explode1available = 1;
  var_1.explode2available = 1;
  var_1 thread trophy_cleanuponparentdeath(var_0, 0.1);
  return var_1;
}

trophy_explode(var_0, var_1) {
  self dontinterpolate();
  self.origin = var_0;
  self.angles = var_1;

  if(self.explode1available) {
    self setscriptablepartstate("_encstr_A73B09AC1E8336ED239526", "_encstr_810A122A2BEBF8F5391F08B295D373A19F6DE641", 0);
    self.explode1available = 0;
  } else if(self.explode2available) {
    self setscriptablepartstate("_encstr_A33B09E3F333B1C7C4812D", "_encstr_810A122A2BEBF8F5391F08B295D373A19F6DE641", 0);
    self.explode1available = 0;
  }
}

trophy_castorigin() {
  return self.origin + anglestoup(self.angles) * 45;
}

trophy_castcontents() {
  return physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
}

trophy_modifiedprotectiondistsqr(var_0, var_1) {
  if(isDefined(var_0.weapon_name) && isDefined(var_0.owner)) {
    switch (var_0.weapon_name) {
      case "_encstr_935E169BDD961D6C1AFA318D2C1995BE8D34B46319D76BE0":
      case "_encstr_AFBB119A85B1DA0BD87DC6169B9BEDDCD7DAC1":
      case "_encstr_BE541946E4DEB9B2F5A1A5CEACAF0727BDD4CA8D3AD236B2F5DAC1":
        if(147456 > var_1)
          var_1 = 147456;

        break;
      case "_encstr_BD48113A4334CFEE2807A4B13F78B477A8B823":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
      case "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7":
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
      case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
        if(65536 > var_1)
          var_1 = 65536;

        break;
    }
  }

  return var_1;
}

trophy_checkignorelist(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1) && isDefined(var_0.weapon_object))
    var_1 = var_0.weapon_object.basename;

  if(isDefined(var_1)) {
    if(scripts\cp\utility::iskillstreakweapon(var_1))
      return 1;

    switch (var_1) {
      case "_encstr_92EA0A290B32FF88A90170EB":
        if(scripts\cp\cp_weapon::isplantedequipment(var_0))
          return 1;

        break;
      case "_encstr_91291B6812AE1993A36735B847E3999D161A4081CAC66D294F82A8A948":
      case "_encstr_8FD117D5388D9637AD8985361BAFE8C98536B6D29BCEF56B83":
      case "_encstr_99D710CDFCDE401566F4DBCA1B9A7D97C8F8":
      case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
      case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
      case "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0":
      case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
        return 1;
    }
  }

  return 0;
}

trophy_startcooldownlist(var_0) {
  if(getdvarint("_encstr_A36F0FE60DDEEEA0396C34B247CB385637", 0) > 0)
    return;
}

trophy_notifytrophytargetowner(var_0, var_1, var_2) {
  if(!isDefined(var_0.owner) || !isPlayer(var_0.owner)) {
    return;
  }
  var_0.owner thread scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8C1110C4F078ACF37829635F571BABE4A8D8");

  if(isDefined(var_0.weapon_name)) {
    switch (var_0.weapon_name) {
      case "_encstr_935E169BDD961D6C1AFA318D2C1995BE8D34B46319D76BE0":
      case "_encstr_AFBB119A85B1DA0BD87DC6169B9BEDDCD7DAC1":
      case "_encstr_BE541946E4DEB9B2F5A1A5CEACAF0727BDD4CA8D3AD236B2F5DAC1":
        var_0.owner notify("_encstr_8EF61412F9EE8BC2189B151C3F98C8DF95F33ADBE043", var_2, var_1, var_0.weapon_name, var_0.origin, var_0.angles);
        break;
    }
  }
}

trophy_getbesttag(var_0) {
  var_1 = level.trophy.tags;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_10, var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = self gettagangles(var_5);
    var_8 = anglesToForward(var_7);
    var_9 = vectordot(vectorNormalize(var_0 - var_6), var_8);

    if(var_10 == 0 || var_9 > var_2) {
      var_2 = var_9;
      var_3 = var_5;
    }
  }

  return var_3;
}

trophy_getpartbytag(var_0) {
  var_1 = level.trophy.tags;

  foreach(var_4, var_3 in var_1) {
    if(var_3 == var_0)
      return "_encstr_AF08083BAA57988D729B" + (var_4 + 1);
  }

  return undefined;
}

trophy_givepointsfordeath(var_0) {}

trophy_givedamagefeedback(var_0) {
  var_1 = "_encstr_B40101";

  if(istrue(self.hasruggedeqp))
    var_1 = "_encstr_A2FB098A2035874AB0F358";

  if(isPlayer(var_0))
    var_0 scripts\cp\cp_damagefeedback::updatedamagefeedback(var_1);
}

trophy_addstored(var_0) {
  if(!isDefined(self.trophies))
    self.trophies = [];

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(var_0))
      var_0 = 2;

    self.trophies[self.trophies.size] = var_0;
  }
}

trophy_removestored() {
  if(isDefined(self.trophies) && self.trophies.size > 0) {
    var_0 = self.trophies[self.trophies.size - 1];
    self.trophies[self.trophies.size - 1] = undefined;
    return var_0;
  }

  return undefined;
}

trophy_clearstored() {
  self.trophies = undefined;
}

trophy_populatestored() {
  var_0 = 4;

  for(var_1 = 0; var_1 < var_0; var_1++)
    trophy_addstored();
}

trophy_maxstored() {
  return 4;
}

trophy_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    return [var_3, var_4];

  if(var_3 == 0)
    return [var_3, var_4];

  var_5 = undefined;

  if(level.hardcoremode) {
    switch (var_2) {
      case "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3":
      case "_encstr_8C26185BD0EF873FF8CF0CF25710844F18AB43D37BB5AFF928B9":
      case "_encstr_92EA0A290B32FF88A90170EB":
        var_5 = 20;
        break;
    }
  }

  var_6 = var_4;

  if(isDefined(var_5))
    var_6 = var_5 - var_3;

  var_6 = min(var_6, var_4);
  return [var_3, var_4];
}

trophy_cleanuponparentdeath(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");
  wait(var_1);
  self delete();
}