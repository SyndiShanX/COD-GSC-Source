/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\claymore.gsc
***********************************************/

claymore_init() {
  level._effect["_encstr_BE2A113B6179B71597D06AC12BD10ABB10DD85"] = loadfx("_encstr_990234D387585A935BD267AFDF42671227DF9AABADA7A25EC29FC393DF5B25CAA67702C6170810812A7FEF89FF3379805A0F407B7F60");

  if(istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    return;
  }
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("_encstr_82A70F2B3B73E33B472371FF21D7809DDF", 1);
  var_0.triggercallback = ::claymore_triggerfromvehicle;
}

claymore_use(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_AD75063D571AE108");

  if(scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E"))
    var_0.hasruggedeqp = 1;

  var_0.exploding = 1;
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);

  if(isDefined(scripts\cp_mp\utility\player_utility::getvehicle())) {
    scripts\mp\hud_message::showerrormessage("_encstr_8F0717E1D99B43DFEFA5C0C5D743849BB571B96170241135A3");
    thread scripts\mp\equipment::incrementequipmentammo("_encstr_82A70F2B3B73E33B472371FF21D7809DDF", 1);
    waitframe();
    var_0 delete();
  }

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

  if(_calloutmarkerping_handleluinotify_enemyrepinged::_id_124F5()) {
    var_1.plantoffsetz = var_1.plantoffsetz + 2;
    var_1.contents = init_mine_caves();
  }

  var_2 = scripts\mp\utility\equipment::plant(var_0, var_1);

  if(!istrue(var_2)) {
    scripts\mp\hud_message::showerrormessage("_encstr_8F0717E1D99B43DFEFA5C0C5D743849BB571B96170241135A3");
    thread scripts\mp\equipment::incrementequipmentammo("_encstr_82A70F2B3B73E33B472371FF21D7809DDF", 1);
    var_0 delete();
  } else {
    var_3 = var_0 getlinkedparent();

    if(isDefined(var_3))
      var_0 scripts\mp\weapons::explosivehandlemovers(var_3);

    var_0.exploding = 0;
    var_0 thread claymore_plant();
  }
}

claymore_plant() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  var_0 = self.owner;
  var_1 = self.owner.team;
  scripts\cp_mp\ent_manager::registerspawn(1, ::sweepclaymore);
  scripts\mp\sentientpoolmanager::registersentient("_encstr_849C0E9130898B0EE380AF2867D8882A", var_0, 1);
  thread scripts\mp\weapons::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);
  var_0 scripts\mp\weapons::onequipmentplanted(self, "_encstr_82A70F2B3B73E33B472371FF21D7809DDF", ::claymore_delete);
  thread scripts\mp\weapons::monitordisownedequipment(var_0, self);
  self missilethermal();
  self missileoutline();
  self setentityowner(var_0);
  self setotherent(var_0);
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread scripts\mp\weapons::minedamagemonitor();
  thread claymore_explodeonnotify();
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(::claymore_empapplied);
  claymore_updatedangerzone();
  self setscriptablepartstate("_encstr_A24E069389FFAA3C", "_encstr_930B07BB1B6B3854FF", 0);
  var_0 setscriptablepartstate("_encstr_961614EA930567DAD109B9993388629F342E51D2F9DC", "_encstr_A24E069389FFAA3C", 0);
  thread handle_respawn_via_c130();
  wait 1;
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_930B07BB1B6B3854FF", 0);
  thread claymore_watchfortrigger();
  thread scripts\mp\equipment_interact::remoteinteractsetup(::claymore_trigger, 1, 1);
}

claymore_updatedangerzone() {
  if(istrue(level.iscacprimaryweapongroup)) {
    return;
  }
  if(isDefined(self.dangerzone))
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

handle_respawn_via_c130() {
  self endon("_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A");
  self endon("_encstr_AD75063D571AE108");
  var_0 = gettime() + 2000;

  while(var_0 > gettime()) {
    var_1 = (0, self.angles[1], 0);
    var_2 = 15;
    self.angles = anglelerpquat(var_1, self.angles, var_2);
    waitframe();
  }
}

claymore_watchfortrigger() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  var_0 = physics_createcontents(["_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52"]);

  for(;;) {
    self waittill("_encstr_821A1015B2BAE7C945D3E930CB9D2023929F", var_1);

    if(istrue(self.stunned)) {
      continue;
    }
    foreach(var_3 in var_1) {
      if(isDefined(var_3.classname)) {
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
          if(var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
            continue;
          }
          var_4 = anglesToForward(self.angles);
          var_5 = anglestoup(self.angles);
          var_6 = self.origin + var_5 * 0;
          var_7 = scripts\mp\utility\equipment::get_mine_ignore_list();
          var_8 = var_3 gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD");
          var_9 = [var_8];
          var_10 = var_6 - var_8;

          if(vectordot(var_10, (0, 0, 1)) >= 0)
            var_9[var_9.size] = var_3 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28");
          else
            var_9[var_9.size] = var_3.origin;

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
}

claymore_trigger(var_0, var_1) {
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_1))
    var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  else
    var_1 = self.owner;

  self notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  scripts\mp\utility\print::printgameaction("_encstr_923113C791F7D32D407B772E9380618A5C2B1B5779", self.owner);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_930B07BB1B6B3854FF", 0);
  scripts\mp\weapons::explosivetrigger(var_0, 0.3);
  thread claymore_explode(var_1);
}

claymore_triggerfromvehicle(var_0, var_1) {
  var_1 endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 notify("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  var_1 scripts\mp\weapons::makeexplosiveunusuabletag();
  var_1 setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  var_1 setscriptablepartstate("_encstr_8F5C086405E70FBA4B4A", "_encstr_930B07BB1B6B3854FF", 0);
  wait 0.1;
  var_1 thread claymore_explodefromvehicletrigger(var_0);
}

claymore_explodefromvehicletrigger(var_0) {
  var_0 dodamage(160, self.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_ACC40CC1F8A321601715CFBFE0EA"));
  var_1 = var_0 scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, getcompleteweaponname("_encstr_ACC40CC1F8A321601715CFBFE0EA"), self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  thread claymore_explode();
  waitframe();

  if(isDefined(var_0))
    var_0 scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(var_1);
}

claymore_explode(var_0) {
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\mp\weapons::makeexplosiveunusuabletag();

  if(isDefined(self.useobj))
    self.useobj delete();

  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner))
    var_1 scripts\mp\weapons::removeequip(self);

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var_2 = anglestoup(self.angles);
  var_3 = -1 * anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("_encstr_BE2A113B6179B71597D06AC12BD10ABB10DD85"), self.origin, var_2, var_4);
  self radiusdamage(self.origin, 75, 100, 100, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB");
  self detonate(var_0);
}

claymore_explodeonnotify() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.owner;
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_1);
  self.leadmarkers = var_1;
  thread claymore_explode(var_1);
}

sweepclaymore() {
  claymore_destroy();
}

claymore_destroy(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  thread claymore_delete(var_0 + 0.2);
  wait(var_0);
  self setscriptablepartstate("_encstr_AFCB082AC1D6A3EA7B73", "_encstr_930B07BB1B6B3854FF", 0);
}

claymore_empapplied(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1))) {
    var_1 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_1 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  var_2 = "_encstr_B40101";

  if(istrue(self.hasruggedeqp))
    var_2 = "_encstr_A2FB098A2035874AB0F358";

  if(isPlayer(var_1))
    var_1 scripts\mp\damagefeedback::updatedamagefeedback(var_2);

  thread claymore_destroy();
}

claymore_delete(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  self setscriptablepartstate("_encstr_88DD0C8047A3D007E37217AE8DDA", "_encstr_BA19049F4B2D");
  self notify("_encstr_AD75063D571AE108");
  scripts\cp_mp\ent_manager::deregisterspawn();
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  var_1 = self.owner;

  if(isDefined(self.owner))
    var_1 scripts\mp\weapons::removeequip(self);

  if(isDefined(var_0))
    wait(var_0);

  self delete();
}

claymore_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    return var_4;

  if(nullweapon(var_1))
    return var_4;

  if(var_1 == getcompleteweaponname("_encstr_ACC40CC1F8A321601715CFBFE0EA")) {
    if(isDefined(self.handle_settings_for_techo_group)) {
      foreach(var_6 in self.handle_settings_for_techo_group) {
        if(isDefined(var_6) && var_6 == var_2)
          return 0;
      }
    }
  } else if(var_1 == getcompleteweaponname("_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB")) {
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_2.owner)))
      return 0;

    thread handle_ground_spawning(var_2);
  } else
    return var_4;

  if(!isexplosivedamagemod(var_3))
    return var_4;

  var_8 = var_0.origin - var_2.origin;
  var_9 = vectordot(var_8, anglestoup(var_2.angles));

  if(var_9 > 65)
    return 0;

  var_8 = var_2.origin - var_0 getEye();
  var_9 = vectordot(var_8, anglestoup(var_2.angles));

  if(var_9 > 65)
    return 0;

  var_10 = anglesToForward(var_2.angles);
  var_10 = (var_10[0], var_10[1], 0);
  var_11 = var_0.origin - var_2.origin;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectordot(var_10, var_11);

  if(var_12 < 0)
    return 0;

  var_9 = distance2d(var_2.origin, var_0.origin);
  var_13 = 1 - clamp((var_9 - 75) / 130, 0, 1);
  var_4 = 70 + 90 * var_13;

  if(isDefined(var_2.leadmarkers)) {
    var_14 = isDefined(var_2.owner) && var_2.leadmarkers == var_2.owner;
    var_15 = var_2.leadmarkers == var_0;

    if(!var_14 && var_15)
      var_4 = min(var_4, 80);
  }

  return var_4;
}

handle_ground_spawning(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_96C222C29033B05F08E6BD8FF6300F7E4FA96ABA50876F77C0CD89A48CDBFF058B09E2A2");
  self endon("_encstr_96C222C29033B05F08E6BD8FF6300F7E4FA96ABA50876F77C0CD89A48CDBFF058B09E2A2");

  if(!isDefined(self.handle_settings_for_techo_group))
    self.handle_settings_for_techo_group = [];

  self.handle_settings_for_techo_group[self.handle_settings_for_techo_group.size] = var_0;
  waittillframeend;
  self.handle_settings_for_techo_group = undefined;
}

claymore_onownerchanged(var_0) {
  self setscriptablepartstate("_encstr_BE64070B9B5E42C718", "_encstr_930B07BB1B6B3854FF", 0);
  claymore_updatedangerzone();
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}

handle_set_respawn_overrides(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isPlayer(var_0))
    var_0 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A2FB098A2035874AB0F358");

  self notify("_encstr_AC5211EA506F07BD90159D5FEFB0439337E912");
  self endon("_encstr_AC5211EA506F07BD90159D5FEFB0439337E912");
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self.stunned = 1;
  wait 3.0;
  self.stunned = 0;
  self setscriptablepartstate("_encstr_B81904B04E6B", "_encstr_930B07BB1B6B3854FF", 0);
}

init_mine_caves() {
  var_0 = ["_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C"];
  return physics_createcontents(var_0);
}