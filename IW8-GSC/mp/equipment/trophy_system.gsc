/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\trophy_system.gsc
***********************************************/

trophy_init() {
  var_0 = spawnStruct();
  var_0.tags = [];
  var_0.tags[0] = "_encstr_8DD10DDD89770635AEDB9020D2C94B";
  var_0.tags[1] = "_encstr_8CD10D8EB0CEAF98584E9C5663FA91";
  var_0.tags[3] = "_encstr_9AD10DB31F7F41DA91500347B80EC3";
  var_0.timeout = getdvarfloat("_encstr_8A931B8BAB6B992B9B37FF08E3B7BB68F0CDC8F31BCD93053A6BB28569", 45.0);
  level.trophy = var_0;
}

trophy_set(var_0, var_1) {
  trophy_clearstored();
  trophy_populatestored();
}

trophy_onsuperset() {}

trophy_unset(var_0, var_1) {
  trophy_clearstored();
}

trophy_used(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\utility\print::printgameaction("_encstr_81A80F7C3EE8C3E40BF2DBE3D03F5D2F21", self);
  var_0 scripts\cp_mp\ent_manager::registerspawn(2, ::sweeptrophy);
  thread scripts\mp\weapons::monitordisownedgrenade(self, var_0);
  var_0 thread trophy_hideandshowaftertime();
  var_0 thread _id_13DDC(self);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  var_0.issuper = isDefined(self.super) && self.super.staticdata.weapon == "_encstr_92EA0A290B32FF88A90170EB";
  var_0.superid = level.superglobals.staticsuperdata["_encstr_9B2F0D5B9D2BB782A7B02BF27821B8"].id;
  var_0.usedcount = 0;
  var_0.laststandweapondelay = self;
  var_2 = scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E");

  if(var_2)
    var_0.hasruggedeqp = 1;

  if(!istrue(var_0.issuper)) {
    var_0.ammo = trophy_removestored();

    if(!isDefined(var_0.ammo))
      var_0.ammo = 3;

    var_0 thread scripts\mp\weapons::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);
  } else
    var_0.ammo = 3;

  scripts\mp\weapons::onequipmentplanted(var_0, "_encstr_AA870D15FAF37393C74318F8BB184A", ::trophy_shutdownanddestroy);
  thread scripts\mp\weapons::monitordisownedequipment(self, var_0);
  var_0 scripts\mp\sentientpoolmanager::registersentient("_encstr_962E10A2166CE896C6C21BF56A1D0B1DB48D", self);
  var_0.explosion = trophy_createexplosion(var_0);
  var_3 = scripts\engine\utility::ter_op(var_2, 200, 100);
  var_4 = "_encstr_A2FB098A2035874AB0F358";
  var_0 thread scripts\mp\damage::monitordamage(var_3, var_4, ::trophy_handlefataldamage, ::trophy_handledamage, 0);
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::trophy_applyempcallback);
  var_0 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
  var_0 thread trophy_deploy();
}

_id_13DDC(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = scripts\engine\utility::_id_143B9(2, "_encstr_9BEC12738743F3E4FC383F10EFB9F28BAF651888");

  if(var_1 == "_encstr_995408F398012F656821") {
    return;
  }
  var_2 = undefined;
  var_3 = tablesort(self.origin, 500, 500);
  var_3[var_3.size] = self;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  var_5 = self.origin;
  var_6 = -2000.0;
  var_7 = self.origin + (0.0, 0.0, var_6);
  var_8 = scripts\engine\trace::ray_trace(var_5, var_7, var_3, var_4);

  if(var_8["_encstr_A53009A25003666B9818C6"] < 1.0) {
    var_2 = var_8["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_2)) {
      if(tugofwar_tank(var_2))
        self.origin = var_0.origin;
    }
  }
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

trophy_deploy() {
  self endon("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8AE20B891099472508F1113039");

  if(level.gametype == "_encstr_B607038AAB")
    self.ignoreme = 1;

  wait 0.1;
  thread _id_13DD5();
  wait 0.2;
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread trophy_watchprotection(45, 105625, ::_id_13DDA, ::trophy_protectionsuccessful);
  thread _id_13DDD();
  thread scripts\mp\equipment_interact::remoteinteractsetup(::trophy_remote_destroy, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

_id_13DD5() {
  self endon("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A55C12F8C2EB2B33974CBD2F4C971AE7534AF8D8");
  wait(trophy_getdeployanimtime());
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C0410C21BE8B4D9CA22953836DECB519B8C");
}

trophy_hideandshowaftertime() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_0 = getdvarfloat("_encstr_81F01EAF6FAAD77B9A1517D0EB37E3F2AF02063888042F11F9609B414B1828C5", 0);
  self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  wait(var_0);
  self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
}

trophy_remote_destroy(var_0) {
  trophy_destroy(1);
}

sweeptrophy() {
  thread trophy_delete(undefined, 0);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C94112F46DB4B5BF59BA8E0A31AB0A310AD15", 0);
}

trophy_destroy(var_0, var_1) {
  thread trophy_delete(var_0, 0.1, var_1);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C94112F46DB4B5BF59BA8E0A31AB0A310AD15", 0);
}

trophy_shutdownanddestroy(var_0, var_1) {
  thread trophy_delete(var_0, 2.6, var_1);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8D31132C1B3AA567CA88B2B93A4E7BE56A1D85278E", 0);
  wait 2.5;

  if(isDefined(self))
    self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C94112F46DB4B5BF59BA8E0A31AB0A310AD15", 0);
}

trophy_delete(var_0, var_1, var_2) {
  self notify("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_88DD0C8047A3D007E37217AE8DDA", "_encstr_BA19049F4B2D");
  self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_9B2F0D5B9D2BB782A7B02BF27821B8", self.usedcount, var_0, var_2);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var_2));
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    scripts\mp\weapons::makeexplosiveunusuabletag();
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.owner)) {
    self.owner notify("_encstr_BDF50E3B33C8439C402FEDD061B8A35F", 0);
    self.owner scripts\mp\weapons::removeequip(self);
  }

  if(isDefined(var_1))
    wait(var_1);

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

trophy_watchprotection(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(level.grenades))
    level.grenades = [];

  if(!isDefined(level.missiles))
    level.missiles = [];

  if(!isDefined(level.mines))
    level.mines = [];

  if(!isDefined(level._id_123A9))
    level._id_123A9 = [];

  var_4 = trophy_castcontents();

  while([[var_2]]()) {
    var_5 = trophy_castorigin(var_0);
    var_6 = [];
    var_6[0] = level.grenades;
    var_6[1] = level.missiles;
    var_6[2] = level.mines;
    var_6[3] = level.projectilekillstreaks;
    var_6[4] = level._id_123A9;
    var_7 = scripts\engine\utility::array_combine_multiple(var_6);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }
      if(istrue(var_9.exploding)) {
        continue;
      }
      if(trophy_checkignorelist(var_9)) {
        continue;
      }
      var_10 = var_9.owner;

      if(!isDefined(var_10) && isDefined(var_9.weapon_name) && weaponclass(var_9.weapon_name) == "_encstr_8C8D08671D451291C849")
        var_10 = getmissileowner(var_9);

      var_11 = 1;

      if(var_11) {
        var_12 = self.owner;

        if(scripts\cp_mp\vehicles\vehicle::isvehicle())
          var_12 = self;

        if(isDefined(var_10) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_12, var_10))) {
          continue;
        }
        if(var_12 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var_12._id_13DF6) && isDefined(var_10.team) && var_12._id_13DF6 == var_10.team)
          continue;
      } else if(var_9 == self) {
        continue;
      }
      if(distancesquared(var_9.origin, self.origin) > trophy_modifiedprotectiondistsqr(var_9, var_1)) {
        continue;
      }
      var_13 = physics_raycast(var_5, var_9.origin, var_4, [self, var_9], 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

      if(isDefined(var_13) && var_13.size > 0) {
        continue;
      }
      self[[var_3]](var_9);
    }

    waitframe();
  }
}

_id_13DDA() {
  return isDefined(self.owner);
}

trophy_protectionsuccessful(var_0) {
  self.owner scripts\mp\killstreaks\killstreaks::givescorefortrophyblocks();
  self.owner thread scripts\mp\gamelogic::threadedsetweaponstatbyname("_encstr_92EA0A290B32FF88A90170EB", 1, "_encstr_88CC0521F3A13B");
  self.owner scripts\mp\utility\stats::incpersstat("_encstr_ACCD11A393F6380D5EA92F37472B6B21D247B9", 1);
  self.owner scripts\mp\supers::hide_plunderboxes("_encstr_9B2F0D5B9D2BB782A7B02BF27821B8");
  self.usedcount++;
  var_1 = var_0.origin;
  _id_119CE(var_0);
  _id_13DD6(var_0);
  var_2 = trophy_getbesttag(var_1);
  var_3 = trophy_getpartbytag(var_2);
  self setscriptablepartstate(var_3, "_encstr_930B07BB1B6B3854FF", 0);
  var_4 = vectortoangles(self gettagorigin(var_2) - var_1);
  var_5 = combineangles(var_4, (-90, 0, 0));
  self.explosion thread trophy_explode(var_1, var_5);
  self.ammo--;

  if(self.ammo <= 0)
    thread trophy_shutdownanddestroy(undefined, 0);
}

_id_13DD6(var_0) {
  var_0 setCanDamage(0);
  var_0.exploding = 1;
  var_0 stopsounds();
  scripts\cp\vehicles\vehicle_compass_cp::ondestroyedbytrophy();
  trophy_notifytrophytargetowner(var_0, "_encstr_92EA0A290B32FF88A90170EB", self.owner);
  _id_13DDB(var_0, var_0.owner, self.owner);

  if(!var_0 scripts\mp\equipment::ondestroyedbytrophy()) {
    if(isDefined(var_0.streakname) && var_0.streakname == "_encstr_B270105ECB28E94BC5CFABAB937D524C5053")
      var_0 notify("_encstr_9B260FF3FBB77BA40877B2B43FF02C973D");
    else
      var_0 delete();
  }
}

_id_13DDB(var_0, var_1, var_2) {
  if(!isDefined(var_0.equipmentref) || var_0.equipmentref != "_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02") {
    return;
  }
  if(!isDefined(var_0.owner) || !isDefined(self.owner)) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(var_1)) {
    return;
  }
  var_3 = var_2;
  var_4 = var_1.origin;
  var_5 = scripts\mp\equipment\snapshot_grenade::_id_13436(var_3, var_4);
  scripts\mp\equipment\snapshot_grenade::_id_13435(var_1, var_2, var_5);
}

_id_13DDD() {
  self endon("_encstr_AD75063D571AE108");
  _id_13DDE();
  thread trophy_shutdownanddestroy(undefined, 0);
}

_id_13DDE() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.trophy.timeout;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

trophy_handledamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_4;
  var_5 = scripts\mp\damage::handlemeleedamage(var_2, var_3, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_2, var_3, var_5);
  scripts\mp\weapons::equipmenthit(self.owner, var_1, var_2, var_3);
  return var_5;
}

trophy_handlefataldamage(var_0) {
  var_1 = var_0.attacker;
  trophy_givepointsfordeath(var_1);
  thread trophy_destroy(var_1, 1);
}

trophy_applyempcallback(var_0) {
  var_0.victim trophy_givepointsfordeath(var_0.attacker);
  var_0.victim thread trophy_shutdownanddestroy(var_0.attacker, 1);
}

trophy_pickup() {
  if(self.owner scripts\mp\equipment::hasequipment("_encstr_AA870D15FAF37393C74318F8BB184A"))
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
  } else {
    self setscriptablepartstate("_encstr_A33B09E3F333B1C7C4812D", "_encstr_810A122A2BEBF8F5391F08B295D373A19F6DE641", 0);
    self.explode1available = 1;
  }
}

trophy_castorigin(var_0) {
  return self.origin + anglestoup(self.angles) * var_0;
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
      case "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7":
      case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
      case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
      case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
      case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
        if(105625 > var_1)
          var_1 = 105625;

        break;
    }
  }

  if(var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unset_bullet_shields() && isDefined(var_0.owner)) {
    if(202500 > var_1)
      var_1 = 202500;
  }

  return var_1;
}

trophy_checkignorelist(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1) && isDefined(var_0.weapon_object))
    var_1 = var_0.weapon_object.basename;

  if(isDefined(var_1)) {
    if(scripts\mp\utility\weapon::iskillstreakweapon(var_1) && var_1 != "_encstr_8DCB0F47F22330CEE7996B13A2E390583A" && var_1 != "_encstr_AC740FAA3BF169D025C6A373200C27E06B")
      return 1;

    if(scripts\mp\utility\weapon::isaxeweapon(var_1))
      return 1;

    switch (var_1) {
      case "_encstr_92EA0A290B32FF88A90170EB":
        if(scripts\mp\weapons::isplantedequipment(var_0))
          return 1;

        break;
      case "_encstr_B80E0DD3FF027E48DD5E7582AF27A8":
      case "_encstr_9A09125ABB07FA6657633AED73D79858ECBE5BC1":
      case "_encstr_86EE1373632E69F1E0E3DFE2FB911473F3F7B78FED":
      case "_encstr_8D3F0E86633BD9B849573060F3575011":
      case "_encstr_91291B6812AE1993A36735B847E3999D161A4081CAC66D294F82A8A948":
      case "_encstr_8FD117D5388D9637AD8985361BAFE8C98536B6D29BCEF56B83":
      case "_encstr_932A12897D8237E1ABEF777D5D38B3BF72E9B068":
      case "_encstr_974A19B28974EB1620913F1B917B9B432DE349FBB158C34FD19B28":
      case "_encstr_8C2E0D5B1078EEF508EBB81DE067A3":
      case "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA":
      case "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170":
      case "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83":
      case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
      case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
      case "_encstr_99D710CDFCDE401566F4DBCA1B9A7D97C8F8":
      case "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0":
      case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
        return 1;
      case "_encstr_A3C80AFA71E9D73FF8CF1AF2":
      case "_encstr_B867153F40FF7F4AAFA11D5763D0D2C25287551B215D4B":
      case "_encstr_86691F58C8EC169B6C568CFA6EBA0EC163E5D791C9B70EF5DA0B4EB52B39D7B51C":
      case "_encstr_81BE0DD71ADF8095A15AF84861C549":
      case "_encstr_835611C8951BF6CDEB37D1851DD27BB9D7B6E0":
      case "_encstr_8C0D0B025090B6A27D2DBF3355":
      case "_encstr_92BC0F408BC20108238458CE67F3F6F32A":
        if(scripts\mp\utility\game::unset_relic_grounded())
          return 1;

        break;
    }
  }

  return 0;
}

trophy_notifytrophytargetowner(var_0, var_1, var_2) {
  if(!isDefined(var_0.owner) || !isPlayer(var_0.owner)) {
    return;
  }
  var_0.owner thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_8C1110C4F078ACF37829635F571BABE4A8D8");

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
      return "_encstr_A19A0772BF43C35FD9" + (var_4 + 1);
  }

  return undefined;
}

trophy_givepointsfordeath(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

#using_animtree("_encstr_A5CF0C3B8E2A106723EFB5A117BB");

trophy_getdeployanimtime() {
  return getanimlength(%_encstr_BAD020F775C1B036B703F0DA192F6B50A3D57B2FE437D8718F8BEE60C203ADC8FD2F);
}

trophy_givedamagefeedback(var_0) {
  var_1 = "_encstr_B40101";

  if(istrue(self.hasruggedeqp))
    var_1 = "_encstr_A2FB098A2035874AB0F358";

  if(isPlayer(var_0))
    var_0 scripts\mp\damagefeedback::updatedamagefeedback(var_1);
}

trophy_addstored(var_0) {
  if(!isDefined(self.trophies))
    self.trophies = [];

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(var_0))
      var_0 = 3;

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
  var_0 = scripts\mp\equipment::getequipmentmaxammo("_encstr_AA870D15FAF37393C74318F8BB184A");

  for(var_1 = 0; var_1 < var_0; var_1++)
    trophy_addstored();
}

trophy_maxstored() {
  return scripts\mp\equipment::getequipmentmaxammo("_encstr_AA870D15FAF37393C74318F8BB184A");
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

_id_119CE(var_0) {
  if(!isDefined(var_0) || !isPlayer(var_0.owner)) {
    return;
  }
  if(!isDefined(self.laststandweapondelay)) {
    return;
  }
  getentitylessscriptablearray("_encstr_97E61D5BA820B72113E4BF75CDBF4B6AC8B0E3B7991BFDAA7775022A3CC382", ["_encstr_B2A811EFE3E99917B3BF806C59F92C681092DA", self.laststandweapondelay, "_encstr_95860E17AA8FA07F5B925658DB1B2518", var_0.owner, "_encstr_97A70FE6B2760BA39546EB3AB0C93BCA3A", var_0.weapon_name]);
}