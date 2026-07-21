/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\at_mine.gsc
***********************************************/

at_mine_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95", 1);
  var_0.radius = 100;
  var_0.triggercallback = ::at_mine_vehicle_trigger;
}

at_mine_use(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");

  if(scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E"))
    var_0.hasruggedeqp = 1;

  var_0 scripts\cp_mp\ent_manager::registerspawn(2, ::deletemine);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 thread at_mine_watch_game_end();
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
  var_0 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
  var_2 = spawnStruct();
  var_2.endonstring = "_encstr_887B0FB5B4DC95FA322B6E4727BDF29523";
  var_2._id_133CA = 1;
  var_0 thread scripts\mp\movers::handle_moving_platform_touch(var_2);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_3);

  if(isDefined(var_3)) {
    if(isent(var_3) && tugofwar_tank(var_3)) {
      var_0.origin = var_0.origin + (0, 0, 1.6);
      var_2._id_123B4 = 1;
      var_0 _meth_87BB(1);
    }

    var_0 linkTo(var_3);
  }

  thread at_mine_plant(var_0);
}

tugofwar_tank(var_0) {
  if(isDefined(level._id_145F1)) {
    foreach(var_2 in level._id_145F1._id_13C8D) {
      if(var_2 == var_0)
        return 1;
      else if(isDefined(var_2.wz_tease) && var_2.wz_tease == var_0)
        return 1;
    }
  }

  return 0;
}

at_mine_update_danger_zone() {
  if(istrue(level.iscacprimaryweapongroup)) {
    return;
  }
  if(isDefined(self.dangerzone))
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

at_mine_plant(var_0) {
  var_0 endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0 missilethermal();
  var_0 missileoutline();
  var_0 setnodeploy(1);
  var_0 setscriptablepartstate("_encstr_A24E069389FFAA3C", "_encstr_930B07BB1B6B3854FF", 0);
  self setscriptablepartstate("_encstr_8B6E12104F255F996149499AF5F58D69CF23D9CB", "_encstr_A24E069389FFAA3C", 0);
  scripts\mp\weapons::onequipmentplanted(var_0, "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95", ::at_mine_delete);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 scripts\mp\sentientpoolmanager::registersentient("_encstr_849C0E9130898B0EE380AF2867D8882A", var_0.owner, 1);
  var_0 thread scripts\mp\weapons::minedamagemonitor();
  var_0 thread at_mine_watch_detonate();
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::at_mine_empapplied);
  var_0 at_mine_update_danger_zone();
  wait 0.75;

  if(istrue(var_0._id_13BFF))
    var_0 thread carriable_detonate_propane();

  wait 0.75;
  var_0 thread scripts\mp\equipment_interact::remoteinteractsetup(::at_mine_explode_from_player_trigger, 1, 1);
  var_0 setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_930B07BB1B6B3854FF", 0);
  var_0 thread at_mine_watch_trigger();
  var_0 thread scripts\mp\weapons::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);
  thread scripts\mp\weapons::outlineequipmentforowner(var_0);
  var_0.headiconid = var_0 scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
}

at_mine_explode_from_player_trigger(var_0) {
  thread at_mine_delete(5);

  if(!isDefined(var_0))
    var_0 = self.owner;

  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_86170B998B7277A9287F9BCDDA", 0);
  self setscriptablepartstate("_encstr_BE64070B9B5E42C718", "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

at_mine_explode_from_vehicle_trigger(var_0) {
  var_0 dodamage(200, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_81430B218B3F7018458997D78A"));
  var_1 = var_0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("_encstr_81430B218B3F7018458997D78A"), self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  thread at_mine_explode_from_vehicle_trigger_internal();
  waitframe();

  if(isDefined(var_0))
    var_0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var_1);
}

at_mine_explode_from_vehicle_trigger_internal() {
  thread at_mine_delete(5);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_91090C3D823580CC775AF8A1022F", 0);
}

at_mine_explode_from_notify(var_0) {
  thread at_mine_delete(5);
  self setentityowner(var_0);
  self clearscriptabledamageowner();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_B1670BDDDBE2A139417D01D967", 0);
}

at_mine_destroy(var_0) {
  thread at_mine_delete(5);
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
}

at_mine_delete(var_0) {
  self notify("_encstr_AD75063D571AE108");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("_encstr_88DD0C8047A3D007E37217AE8DDA", "_encstr_BA19049F4B2D");
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  if(isDefined(self.owner))
    self.owner scripts\mp\weapons::removeequip(self);

  if(isDefined(self.dangericonent))
    self.dangericonent delete();

  var_1 = self getlinkedchildren();

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3) && isDefined(var_3.equipmentref) && var_3.equipmentref == "_encstr_82A70F2B3B73E33B472371FF21D7809DDF" && !istrue(var_3.exploding))
        var_3 thread scripts\mp\equipment\claymore::claymore_destroy();
    }
  }

  if(isDefined(var_0))
    wait(var_0);

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

carriable_detonate_propane() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.carriable_watch_for_physics_collison = (0, 0, 0);
  var_0 = 0.2;

  for(;;) {
    var_1 = self.origin;
    wait(var_0);
    self.carriable_watch_for_physics_collison = 1 / var_0 * (self.origin - var_1);
  }
}

trial_ui_set_combo_bar_combo(var_0) {
  return isDefined(var_0) && isDefined(var_0.carriable_watch_for_physics_collison) && length2dsquared(var_0.carriable_watch_for_physics_collison) > 0.01;
}

at_mine_watch_trigger() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_821A1015B2BAE7C945D3E930CB9D2023929F", var_0);

    foreach(var_2 in var_0) {
      if(var_2.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
        if(var_2 scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
          continue;
        }
        if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(var_2, self)) {
          continue;
        }
        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(var_2, self);
        break;
      }

      if(var_2.classname == "_encstr_AA15062C769537A3" || var_2.classname == "_encstr_8BB007E03658CBCAE4") {
        if(!isPlayer(var_2) && !isagent(var_2)) {
          continue;
        }
        if(isDefined(var_2.vehicle)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_2)) {
          continue;
        }
        if(var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
          continue;
        }
        thread at_mine_player_trigger(var_2);
        break;
      }
    }
  }
}

at_mine_player_trigger(var_0) {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self.triggeredbyplayer = 1;
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_930B07BB1B6B3854FF", 0);
  var_1 = scripts\mp\utility\weapon::_launchgrenade("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860", self.origin, (0, 0, 0), 100, 1);
  var_1 linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(var_1);
  var_1.weapon_object = getcompleteweaponname("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860");
  self.dangericonent = var_1;
  scripts\mp\weapons::explosivetrigger(var_0, 0.1);
  thread at_mine_watch_flight();
}

at_mine_vehicle_trigger(var_0, var_1) {
  var_1 endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  var_1 scripts\mp\weapons::makeexplosiveunusuabletag();
  var_1 setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  var_1 setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_930B07BB1B6B3854FF", 0);
  wait 0.2;
  var_1 thread at_mine_explode_from_vehicle_trigger(var_0);
}

at_mine_watch_flight_mover(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.grenade scripts\engine\utility::_id_143BA(var_0, "_encstr_AD75063D571AE108", "_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");

  if(isDefined(self.grenade))
    self moveTo(self.origin, 0.05, 0, 0);

  while(isDefined(self.grenade))
    waitframe();

  self delete();
}

deletemine() {
  at_mine_delete(0);
}

at_mine_watch_flight() {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0.8;

  if(var_0 > 0) {
    var_1 = (0, 0, 1);
    var_2 = self.origin + var_1 * 64;
    var_3 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80"]);
    var_4 = scripts\mp\utility\equipment::get_mine_ignore_list();
    var_5 = self.origin;
    var_6 = var_2;
    var_7 = physics_raycast(var_5, var_6, var_3, var_4, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_8 = vectordot(var_7[0]["_encstr_BD260953AA97E3F014279D"] - var_5, var_1);
      var_8 = max(0, var_8 - 1);
      var_0 = 0;
      var_2 = self.origin;

      if(var_8 > 0) {
        var_0 = var_8 / 64 * 0.8;
        var_2 = self.origin + var_1 * var_8;
      }
    }

    if(trial_ui_set_combo_bar_combo(self))
      var_2 = var_2 + self.carriable_watch_for_physics_collison * var_0;

    if(var_0 > 0) {
      var_9 = var_0;
      var_10 = var_9 * 0.81;

      if(trial_ui_set_combo_bar_combo(self))
        var_10 = var_10 * 0.25;

      var_9 = var_9 - var_10;
      var_11 = 0;

      if(var_9 > 0)
        var_11 = var_9 * 0;

      var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
      var_12.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      var_12 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      self.mover = var_12;
      var_12.grenade = self;
      self linkTo(var_12, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
      var_12 moveTo(var_2, var_0, var_11, var_10);
      var_12 thread at_mine_watch_flight_mover(var_0);
      thread at_mine_watch_flight_effects(var_0);
      childthread scripts\mp\utility\equipment::_id_14444();
      scripts\engine\utility::_id_143B9(var_0, "_encstr_8C4918EA30E953BC7023976EB7A844FB03AE53A259BD03755003");
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

at_mine_empapplied(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(var_1))
    var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");

  thread at_mine_destroy();
}

at_mine_watch_detonate() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_0);

  if(isDefined(var_0))
    thread at_mine_explode_from_notify(var_0);
  else if(isDefined(self.owner))
    thread at_mine_explode_from_notify(self.owner);
  else
    thread at_mine_destroy();
}

at_mine_watch_game_end() {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  level scripts\engine\utility::_id_143A5("_encstr_9B1D0BC7932875276230426AA1", "_encstr_935E0F139CF6D76E1A7B3AEB6E1D85E4D1");
  thread at_mine_destroy();
}

at_mine_damage_vehicle_manually(var_0) {
  var_0 dodamage(200, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_81430B218B3F7018458997D78A"));
  var_1 = var_0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("_encstr_81430B218B3F7018458997D78A"), self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  waitframe();

  if(isDefined(var_0))
    var_0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var_1);
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
      else if(var_9 == "_encstr_B13D076BED70539F23" || self issprintsliding())
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

at_mine_onownerchanged(var_0) {
  self setscriptablepartstate("_encstr_BE64070B9B5E42C718", "_encstr_930B07BB1B6B3854FF", 0);
  at_mine_update_danger_zone();
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}