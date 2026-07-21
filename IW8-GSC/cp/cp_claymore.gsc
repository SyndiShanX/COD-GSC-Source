/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_claymore.gsc
***********************************************/

claymore_init() {
  level._effect["_encstr_BE2A113B6179B71597D06AC12BD10ABB10DD85"] = loadfx("_encstr_990234D387585A935BD267AFDF42671227DF9AABADA7A25EC29FC393DF5B25CAA67702C6170810812A7FEF89FF3379805A0F407B7F60");
}

claymore_use(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.exploding = 1;
  var_0._id_121AC = self.name;
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_1 = spawnStruct();
  var_1.throwspeedforward = 100;
  var_1.throwspeedup = -50;
  var_1.castdivisions = 3;
  var_1.castmaxtime = 0.5;
  var_1.castdetail = 1;
  var_1.plantmaxtime = 0.5;
  var_1.plantmaxroll = 15;
  var_1.plantmindistbeloweye = 12;
  var_1.plantmaxdistbelowownerfeet = 20;
  var_1.plantmindisteyetofeet = 45;
  var_1.plantnormalcos = 0.342;
  var_1.plantoffsetz = 3;
  var_2 = scripts\cp\cp_equipment::plant(var_0, var_1);

  if(!istrue(var_2)) {
    var_0.owner notify("_encstr_9A3C117B6B0602C5284EC7CA23C808BAED8D93", var_0.weapon_name);
    self setweaponammoclip(var_0.weapon_obj, self.powers["_encstr_8E910FA7E764B78317A2C973305A28B33B"].charges + 1);
    var_0 delete();
  } else {
    var_3 = var_0 getlinkedparent();

    if(isDefined(var_3))
      var_0 scripts\cp\cp_weapon::explosivehandlemovers(var_3);

    var_0.exploding = 0;
    var_0 thread claymore_plant();
  }
}

claymore_plant() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.owner) && isPlayer(self.owner))
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  var_0 = self.owner;
  thread scripts\cp\cp_equipment::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    var_0 scripts\cp\cp_weapon::onlethalequipmentplanted(self, "_encstr_ACC40CC1F8A321601715CFBFE0EA");
    thread scripts\cp\cp_weapon::monitordisownedequipment(var_0, self);
  } else
    level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(self);

  self missilethermal();
  self missileoutline();

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    self setentityowner(var_0);
    self setotherent(var_0);
  }

  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1);
  thread scripts\cp\cp_weapon::minedamagemonitor();
  thread claymore_explodeonnotify();
  thread claymore_destroyonemp();
  self setscriptablepartstate("_encstr_A24E069389FFAA3C", "_encstr_930B07BB1B6B3854FF", 0);
  var_0 setscriptablepartstate("_encstr_961614EA930567DAD109B9993388629F342E51D2F9DC", "_encstr_A24E069389FFAA3C", 0);
  wait 1;
  self enableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_930B07BB1B6B3854FF", 0);
  thread claymore_watchfortrigger();
}

claymore_watchfortrigger() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  var_0 = physics_createcontents(["_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52"]);

  for(;;) {
    self waittill("_encstr_821A1015B2BAE7C945D3E930CB9D2023929F", var_1);

    foreach(var_3 in var_1) {
      if(!isalive(var_3)) {
        continue;
      }
      if(var_3.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
        if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(var_3, self)) {
          continue;
        }
        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(var_3, self);
        break;
      }

      if(var_3.classname == "_encstr_AA15062C769537A3" || var_3.classname == "_encstr_8BB007E03658CBCAE4") {
        if(!isPlayer(var_3) && !isagent(var_3)) {
          continue;
        }
        var_4 = anglesToForward(self.angles);
        var_5 = anglestoup(self.angles);
        var_6 = self.origin + var_5 * 0;
        var_7 = get_mine_ignore_list();
        var_8 = var_3 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD");
        var_9 = [var_8];
        var_10 = var_6 - var_8;

        if(vectordot(var_10, (0, 0, 1)) >= 0)
          var_9[var_9.size] = var_3 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28");
        else
          var_9[var_9.size] = var_3.origin + (0, 0, 0.125);

        var_11 = 0;

        foreach(var_13 in var_9) {
          var_10 = var_13 - self.origin;
          var_14 = vectordot(var_10, var_4);

          if(var_14 > 192) {
            continue;
          }
          var_15 = vectordot(var_10, var_5);

          if(abs(var_15) > 32) {
            continue;
          }
          var_16 = vectorNormalize(var_10);
          var_17 = vectordot(var_16, var_4);

          if(var_17 < 0.86602) {
            continue;
          }
          var_18 = physics_raycast(var_6, var_13, var_0, var_7, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

          if(isDefined(var_18) && var_18.size > 0) {
            continue;
          }
          var_11 = 1;
          thread claymore_trigger(var_3);
        }

        if(var_11) {
          break;
        }
      }
    }
  }
}

get_mine_ignore_list() {
  var_0 = [self];

  if(isDefined(level.dynamicladders)) {
    foreach(var_2 in level.dynamicladders)
    var_0[var_0.size] = var_2.ents[0];
  }

  var_4 = self getlinkedchildren(1);

  if(!isDefined(var_4))
    var_4 = [];

  var_4[var_4.size] = self getlinkedparent();

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && var_6.classname == "_encstr_8C8D08671D451291C849")
      var_0[var_0.size] = var_6;
  }

  return var_0;
}

claymore_trigger(var_0) {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_930B07BB1B6B3854FF", 0);
  scripts\cp\cp_weapon::explosivetrigger(var_0, 0.3);
  thread claymore_explode(self.owner);
}

claymore_explode(var_0) {
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();

  if(isDefined(self.useobj))
    self.useobj delete();

  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner) && isDefined(var_1.plantedlethalequip))
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var_2 = anglestoup(self.angles);
  var_3 = -1 * anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("_encstr_BE2A113B6179B71597D06AC12BD10ABB10DD85"), self.origin, var_2, var_4);
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", self.origin, "_encstr_ACC40CC1F8A321601715CFBFE0EA", self._id_121AC);
  self detonate();
}

claymore_explodeonnotify() {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.owner))
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_0);
  thread claymore_explode(var_0);
}

claymore_destroy(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  thread claymore_delete(var_0 + 0.2);
  wait(var_0);
  self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
}

claymore_destroyonemp() {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.owner))
    self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_AB770C81EB09798E707B29137D77", var_0);
    var_1 = var_0.attacker;

    if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
      var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
      var_2 = "_encstr_B40101";

      if(istrue(self.hasruggedeqp))
        var_2 = "_encstr_A2FB098A2035874AB0F358";

      thread claymore_destroy();
    }
  }
}

claymore_delete(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  self notify("_encstr_AD75063D571AE108");

  if(isDefined(self.useobj))
    self.useobj delete();

  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner))
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);

  wait(var_0);
  self delete();
}

claymore_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    return var_4;

  if(nullweapon(var_1))
    return var_4;

  if(var_1 != getcompleteweaponname("_encstr_ACC40CC1F8A321601715CFBFE0EA"))
    return var_4;

  if(!isexplosivedamagemod(var_3))
    return var_4;

  var_5 = distance2d(var_2.origin, var_0.origin);
  var_6 = 1 - clamp((var_5 - 75) / 181, 0, 1);
  var_4 = 70 + 70 * var_6;
  return var_4;
}

remotedefusesetup() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = &"_encstr_8D6219C01B0144D708EFF86054EDC709C9734E4D8F119943D344E1";
  var_1 = 0;
  self.useobj = scripts\cp\utility::createhintobject(self.origin + anglestoup(self.angles) * 7, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, var_0, var_1, undefined, "_encstr_BD1805CB69C063", 250, 160, 200, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(var_3 in level.players)
  self.useobj disableplayeruse(var_3);

  thread defusethink();
  thread defuseusemonitoring();

  for(;;) {
    self waittill("_encstr_9A7B088CCA335D37CA91", var_3);

    if(isPlayer(var_3))
      thread claymore_trigger(var_3);
  }
}

defuseusemonitoring() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 0.1;

    foreach(var_1 in level.players)
    self.useobj enableplayeruse(var_1);
  }
}

defusethink() {
  self endon("_encstr_A517132A055FFBA18B687763D8068882E3A674E6F6");
  var_0 = self.useobj;
  var_1 = undefined;

  if(istrue(level.gameended) && !isDefined(var_0)) {
    return;
  }
  while(isDefined(self)) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(self.owner) && var_2 == self.owner) {
      continue;
    }
    var_2.iscapturingcrate = 1;
    var_1 = scripts\cp\utility::createuseent();
    var_1.id = "_encstr_A6530EFD4A6F389E8BD191B96AD74EC0";
    var_3 = var_1 scripts\cp\cp_deployablebox::useholdthink(var_2, getdvarfloat("_encstr_92821BB8758B6F697198CAF39B5B51EF43E5393099B1B3EB5F68224AA8"));

    if(!isDefined(var_2)) {
      return;
    }
    if(!var_3) {
      var_2.iscapturingcrate = 0;
      continue;
    }

    var_2.iscapturingcrate = 0;
    self notify("_encstr_9A7B088CCA335D37CA91", var_2);
  }
}