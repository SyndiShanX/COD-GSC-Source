/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\equipment\cp_at_mine.gsc
***********************************************/

at_mine_use(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.set_car_collision = self.name;
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0 thread at_mine_watch_game_end();
  var_0 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);

  if(isDefined(var_1))
    var_0 linkTo(var_1);

  thread at_mine_plant(var_0);
}

at_mine_plant(var_0) {
  var_0 endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  var_0 endon("_encstr_AD75063D571AE108");

  if(isPlayer(self))
    self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isPlayer(self)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_AFA60BCBD30756C8DB355A8B5F");
    var_0 setotherent(self);
    var_0 setentityowner(self);
  }

  var_0 missilethermal();
  var_0 missileoutline();
  var_0 setnodeploy(1);
  var_0 setscriptablepartstate("_encstr_A24E069389FFAA3C", "_encstr_930B07BB1B6B3854FF", 0);
  var_0 enableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");

  if(isPlayer(self)) {
    self setscriptablepartstate("_encstr_8B6E12104F255F996149499AF5F58D69CF23D9CB", "_encstr_A24E069389FFAA3C", 0);
    scripts\cp\cp_weapon::onlethalequipmentplanted(var_0, "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95", 1);
    thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  } else
    level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(var_0);

  var_0 thread scripts\cp\cp_equipment::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);
  var_0 thread scripts\cp\cp_weapon::minedamagemonitor();
  var_0 thread at_mine_watch_detonate();
  var_0 thread at_mine_watch_emp();
  var_0 thread remotedefusesetup();
  var_0 thread remotedetonatethink();
  wait 1;
  var_1 = var_0 at_mine_create_player_trigger();
  var_0.playertrigger = var_1;
  var_0 thread scripts\cp\cp_weapon::minedeletetrigger(var_1);
  var_0 thread at_mine_watch_player_trigger(var_1);
  var_0 thread at_mine_watch_vehicle_trigger();
}

at_mine_explode_from_player_trigger(var_0) {
  thread at_mine_delete(1);

  if(isDefined(var_0)) {
    self setentityowner(var_0);
    self clearscriptabledamageowner();
  }

  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_86170B998B7277A9287F9BCDDA", 0);
}

at_mine_explode_from_vehicle_trigger(var_0) {
  if(isDefined(var_0))
    thread at_mine_damage_manually(self.owner, var_0);

  thread at_mine_delete(1);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_91090C3D823580CC775AF8A1022F", 0);
}

at_mine_explode_from_notify(var_0) {
  thread at_mine_delete(1);
  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_B1670BDDDBE2A139417D01D967", 0);
}

at_mine_destroy(var_0) {
  thread at_mine_delete(1);
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
}

at_mine_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner) && isDefined(var_1.plantedlethalequip))
    var_1.plantedlethalequip = scripts\engine\utility::array_remove(var_1.plantedlethalequip, self);

  if(isDefined(self.dangericonent))
    self.dangericonent delete();

  if(isDefined(self.useobj))
    self.useobj delete();

  if(isDefined(var_0))
    wait(var_0);

  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", self.origin, "_encstr_81430B218B3F7018458997D78A", self.set_car_collision);
  self delete();
}

at_mine_create_player_trigger() {
  var_0 = spawn("_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", self.origin, 0, 100, 50);
  var_0.angles = self.angles;
  var_0 enablelinkTo();
  var_0 linkTo(self);
  var_0 hide();
  var_0.mine = self;
  return var_0;
}

at_mine_watch_player_trigger(var_0) {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80"]);

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!isDefined(var_2)) {
      continue;
    }
    if(!isPlayer(var_2) && !isagent(var_2)) {
      continue;
    }
    if(isDefined(var_2.vehicle)) {
      continue;
    }
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_2))) {
      continue;
    }
    thread at_mine_player_trigger(var_2);
  }
}

at_mine_player_trigger(var_0) {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self.triggeredbyplayer = 1;
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_930B07BB1B6B3854FF", 0);
  var_1 = scripts\cp\utility::_launchgrenade("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860", self.origin, (0, 0, 0), 100, 1);
  var_1 linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(var_1);
  var_1.weapon_object = getcompleteweaponname("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860");
  self.dangericonent = var_1;
  scripts\cp\cp_weapon::explosivetrigger(var_0, 0.1);
  thread at_mine_watch_flight();
}

at_mine_watch_vehicle_trigger() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = [(0, 0, 0), (60, 0, 0), (-60, 0, 0)];
  var_1 = 75;
  var_2 = var_1 * var_1;
  var_3 = 30;
  var_4 = [(0, 0, 0), (22, 0, 0), (-22, 0, 0)];
  var_5 = 96;
  var_6 = var_5 * var_5;
  var_7 = 15;

  for(;;) {
    var_8 = getactivebradleys();

    if(isDefined(var_8)) {
      foreach(var_10 in var_8) {
        if(!isDefined(var_10)) {
          continue;
        }
        if(level.teambased) {
          if(var_10.team == self.owner.team)
            continue;
        } else if(isDefined(var_10.owner) && var_10.owner == self.owner) {
          continue;
        }
        var_11 = anglestoaxis(var_10.angles);

        foreach(var_13 in var_0) {
          var_14 = var_10.origin;
          var_14 = var_14 + var_11["_encstr_8253060E2B5FE330"] * var_13[0];
          var_14 = var_14 + var_11["_encstr_B42E085325A82CB3F221"] * var_13[1];
          var_14 = var_14 + var_11["_encstr_87070365F7"] * var_13[2];
          var_15 = self.origin - var_14;
          var_16 = vectordot(var_15, var_11["_encstr_87070365F7"]);

          if(abs(var_16) > var_3) {
            continue;
          }
          var_17 = var_15 - var_11["_encstr_87070365F7"] * var_16;

          if(lengthsquared(var_17) > var_2) {
            continue;
          }
          thread at_mine_vehicle_trigger(var_10);
          return;
        }
      }
    }

    var_20 = level.assaultdrones;

    if(isDefined(var_20)) {
      foreach(var_22 in var_20) {
        if(!isDefined(var_22)) {
          continue;
        }
        if(!isDefined(var_22.streakname) || var_22.streakname != "_encstr_B1B30B51D176511E377A1BC313") {
          continue;
        }
        if(isDefined(var_22.owner) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_22.owner, self.owner))) {
          continue;
        }
        var_11 = anglestoaxis(var_22.angles);

        foreach(var_13 in var_4) {
          var_24 = var_22.origin;
          var_24 = var_24 + var_11["_encstr_8253060E2B5FE330"] * var_13[0];
          var_24 = var_24 + var_11["_encstr_B42E085325A82CB3F221"] * var_13[1];
          var_24 = var_24 + var_11["_encstr_87070365F7"] * var_13[2];
          var_15 = self.origin - var_24;
          var_16 = vectordot(var_15, var_11["_encstr_87070365F7"]);

          if(abs(var_16) > var_7) {
            continue;
          }
          var_17 = var_15 - var_11["_encstr_87070365F7"] * var_16;

          if(lengthsquared(var_17) > var_6) {
            continue;
          }
          thread at_mine_vehicle_trigger(var_22);
          return;
        }
      }
    }

    waitframe();
  }
}

getactivebradleys() {
  var_0 = [];

  foreach(var_2 in level.vehicle.instances) {
    foreach(var_4 in var_2)
    var_0[var_0.size] = var_4;
  }

  if(isDefined(level.bradley))
    var_0 = scripts\engine\utility::array_combine(var_0, level.bradley.activevehicles["_encstr_BE7D0633C08849E2"]);

  if(var_0.size == 0)
    return undefined;

  return var_0;
}

at_mine_vehicle_trigger(var_0) {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_930B07BB1B6B3854FF", 0);
  wait 0.2;
  thread at_mine_explode_from_vehicle_trigger(var_0);
}

at_mine_watch_flight_mover(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.grenade scripts\engine\utility::_id_143BA(var_0, "_encstr_AD75063D571AE108", "_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");

  if(isDefined(self.grenade))
    self moveTo(self.origin, 0.05, 0, 0);

  wait 2;
  self delete();
}

at_mine_watch_flight() {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0.7;

  if(var_0 > 0) {
    var_1 = (0, 0, 1);
    var_2 = self.origin + var_1 * 64;
    var_3 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80"]);
    var_4 = self.origin;
    var_5 = var_2;
    var_6 = physics_raycast(var_4, var_5, var_3, self, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_6) && var_6.size > 0) {
      var_7 = vectordot(var_6[0]["_encstr_BD260953AA97E3F014279D"] - var_4, var_1);
      var_7 = max(0, var_7 - 1);
      var_0 = 0;
      var_2 = self.origin;

      if(var_7 > 0) {
        var_0 = var_7 / 64 * 0.7;
        var_2 = self.origin + var_1 * var_7;
      }
    }

    if(var_0 > 0) {
      var_8 = var_0;
      var_9 = var_8 * 0.93;
      var_8 = var_8 - var_9;
      var_10 = 0;

      if(var_8 > 0)
        var_10 = var_8 * 0;

      var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
      var_11.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      var_11 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      self.mover = var_11;
      var_11.grenade = self;
      self linkTo(var_11, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
      var_11 moveTo(var_2, var_0, var_10, var_9);
      var_11 thread at_mine_watch_flight_mover(var_0);
      thread at_mine_watch_flight_effects(var_0);
      wait(var_0);
      thread at_mine_explode_from_player_trigger();
      return;
    }
  }
}

at_mine_watch_flight_effects(var_0) {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_930B07BB1B6B3854FF", 0);
}

at_mine_watch_emp() {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_AB770C81EB09798E707B29137D77", var_0);
    var_1 = var_0.attacker;

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
      var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");

      if(isPlayer(var_1))
        var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB");

      thread at_mine_destroy();
    }
  }
}

at_mine_watch_detonate() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self.owner;
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_1);

  if(isDefined(var_1))
    thread at_mine_explode_from_notify(var_1);
  else
    thread at_mine_explode_from_notify(var_0);
}

at_mine_watch_game_end() {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1", "_encstr_935E0F139CF6D76E1A7B3AEB6E1D85E4D1");
  thread at_mine_destroy();
}

at_mine_damage_manually(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_2 = getcompleteweaponname("_encstr_81430B218B3F7018458997D78A");
  waitframe();
  var_3 = 200;

  if(isDefined(var_1.mine_damage_override))
    var_3 = var_1.mine_damage_override;

  if(isDefined(var_0) && isDefined(self)) {
    var_1 dodamage(var_3, self.origin, var_0, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_2);
    var_1 notify("_encstr_B2BE0788BAF573592F", var_3, self.origin, var_0, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_2);
  }
}

at_mine_modified_damage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    return var_4;

  if(var_3 != "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")
    return var_4;

  if(!isDefined(var_2))
    return var_4;

  if(nullweapon(var_2))
    return var_4;

  if(var_2.basename != "_encstr_81430B218B3F7018458997D78A" && var_2.basename != "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860")
    return var_4;

  var_5 = anglestoup(var_1.angles);
  var_6 = var_1.origin - self getEye();
  var_7 = vectordot(var_6, var_5);

  if(var_7 > 46)
    return 0;

  var_6 = self.origin - var_1.origin;
  var_8 = vectordot(var_6, var_5);

  if(var_8 > 46)
    return 0;

  if(var_2.basename == "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860" || istrue(var_1.triggeredbyplayer)) {
    if(var_7 >= 0) {
      var_9 = var_0 getstance();

      if(var_9 == "_encstr_922406F1A6FD5E05")
        var_4 = int(min(var_4, 35));
      else if(var_9 == "_encstr_B13D076BED70539F23")
        var_4 = int(min(var_4, 55));
    }
  }

  return var_4;
}

at_mine_cleanup_danger_icon_ent(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

remotedetonatethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_A2BF1039CAB6B78E59D719AC3AF6B92C3A59", var_0);
    thread at_mine_explode_from_player_trigger(var_0);
  }
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
      thread at_mine_explode_from_player_trigger(var_3);
  }
}

defuseusemonitoring() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 0.1;

    foreach(var_1 in level.players) {
      if(var_1.team == self.team || !var_1 scripts\cp\utility::_hasperk("_encstr_AD781843325528832AF3A1A32743DD10E78B095EDFBDD84523BF")) {
        self.useobj disableplayeruse(var_1);
        continue;
      }

      self.useobj enableplayeruse(var_1);
    }
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