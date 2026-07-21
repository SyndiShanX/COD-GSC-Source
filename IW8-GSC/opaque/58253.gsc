/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58253.gsc
***********************************************/

subscribetoquestlocale() {
  init_vfx();
  init_dvars();
}

init_vfx() {
  level._effect["_encstr_84382B4B19108FEAFE7F2B276F2872FC70C004D5118871F2D8670F7B534DCA2F50EE3E9CEB980C6AB8357B77B3"] = loadfx("_encstr_B4B1446766F0E5A5EE705E1C4EDE07E5371BC9D2838E8526B1CA375E9DCCC3BEC44EAF46956CBDDCD1165B4B9B2C1D967BDCD76E3A2C1DB4B7B9BE8D2D398D6356EB26D85D95");
  level._effect["_encstr_92BE2C68BAC05FA923AFC54D6BAFD0C16E921810629B4B407B87563D41EB78AF1559D0A02BF689D9E7B3DDBD59D7"] = loadfx("_encstr_B10C3267990F5E4BBB1CFA4CC979A5CD1BB0B99179AC5CBAD2077919ACD8DE37CB67660FF526E4CCF52356B1DE37D7CDA3CAC2D6");
  level._effect["_encstr_AA202BEBBF50D11E13478983DFAA50D0E1D5B060E6A4A840EA5FDFB9EFC32BC0B6217918CA1BF80D118FDBBD07"] = loadfx("_encstr_8FD731EBD85BF7A0636AEF2198A8397E7C42C027A55B59A8BBCADECCFA28F8D8AE1B103B4EDAABCA3FC325062A62E178AB6809");
  level._effect["_encstr_9ADF1C9D5CC117D8DAA62820877848EF536F973AA73FF2F6E735CD0F38B3"] = loadfx("_encstr_936433BBBDB1F641CC418882BA12D11B68C8FE317AC54915B38767AFB5FEE7F8B03BCF7811AAEB2F304B51E2FF055193D70BF0AEE2");
}

init_dvars() {
  if(!isDefined(level.iswztrain)) {
    level.iswztrain = spawnStruct();
    level.iswztrain.instances = [];
  }

  level.iswztrain.lifetime = getdvarfloat("_encstr_865C1B3B10EDD19351469F8670BB1BE659E8626289B914A38935918D75", 20.0);
  level.iswztrain.weaponswitchhintlogic = getdvarfloat("_encstr_B8D727F8E76E7803FFB717489FB6B889F3A8A215663D0C5E3A5B94FB65797D81AEA32F98A7AA17BB01", -1);
  level.iswztrain._id_142CD = getdvarfloat("_encstr_8C9D23D05F05A728F79AA84D8F430C337BC808737103BBAF22161264389DBA96D46F84C9D9", 0.1);
  level.iswztrain.infinite_ammo = getdvarint("_encstr_9BC8209F3708B0A867D9F048810B215FD3EF9035A94AF65CB7E819C3E85F18EBE130", 0);
}

jugg_protect_jammer() {
  self.jugg_pursue_target = undefined;
  var_0 = scripts\mp\equipment::getequipmentmaxammo("_encstr_881C1456B8BAB438FA46958DB7CDD7E6E80B47A5DB37");

  for(var_1 = 0; var_1 < var_0; var_1++)
    javelin_interact_monitor();
}

javelin_interact_monitor(var_0) {
  if(!isDefined(self.jugg_pursue_target))
    self.jugg_pursue_target = [];

  if(self.jugg_pursue_target.size < jug_trig_spawn()) {
    if(!isDefined(var_0))
      var_0 = 3;

    self.jugg_pursue_target[self.jugg_pursue_target.size] = var_0;
  }
}

jugg_modifyherodroptoplayerdamage() {
  if(isDefined(self.jugg_pursue_target) && self.jugg_pursue_target.size > 0) {
    var_0 = self.jugg_pursue_target[self.jugg_pursue_target.size - 1];
    self.jugg_pursue_target[self.jugg_pursue_target.size - 1] = undefined;
    return var_0;
  }

  return undefined;
}

jugg_modifyfalldamage() {
  self.jugg_pursue_target = undefined;
}

jugg_go_to_node_callback(var_0, var_1) {
  jugg_modifyfalldamage();
}

jugg_getminigunweapon(var_0, var_1) {
  jugg_protect_jammer();
}

jug_trig_spawn() {
  return scripts\mp\equipment::getequipmentmaxammo("_encstr_881C1456B8BAB438FA46958DB7CDD7E6E80B47A5DB37");
}

jug_reinforce() {
  jug_encounter_test(undefined, 0, 0.15);
}

jugg_dmg_debug() {
  jug_encounter_test(undefined, 0, 0.15);
}

jeep_initomnvars(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.owner = self;
  var_0 setotherent(var_0.owner);
  var_0 setnodeploy(1);
  var_0.issuper = isDefined(var_0.owner.super) && var_0.owner.super.staticdata.weapon == "_encstr_835611C8951BF6CDEB37D1851DD27BB9D7B6E0";
  var_0.superid = level.superglobals.staticsuperdata["_encstr_8E2314CDAE0E5627D791B2D87B9BF5DCD12C3AB4DE73"].id;
  var_0.usedcount = 0;
  var_0 scripts\cp_mp\ent_manager::registerspawn(2, ::jug_reinforce);
  var_0 thread jeep_initcollision();
  var_0 thread jeep(var_0.owner);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);
  var_0.owner thread scripts\mp\weapons::monitordisownedgrenade(var_0.owner, var_0);
  scripts\mp\utility\print::printgameaction("_encstr_81A80F7C3EE8C3E40BF2DBE3D03F5D2F21", self);

  if(!istrue(var_0.issuper)) {
    var_0.ammo = jugg_modifyherodroptoplayerdamage();

    if(!isDefined(var_0.ammo))
      var_0.ammo = 3;

    var_0 thread scripts\mp\weapons::makeexplosiveusabletag("_encstr_BA300854E318F1FF9699", 1);
  } else
    var_0.ammo = 3;

  var_0.owner scripts\mp\weapons::onequipmentplanted(var_0, "_encstr_881C1456B8BAB438FA46958DB7CDD7E6E80B47A5DB37", ::jugg_dmg_debug);
  var_0 thread scripts\mp\weapons::monitordisownedequipment(var_0.owner, var_0);
  var_0 scripts\mp\sentientpoolmanager::registersentient("_encstr_962E10A2166CE896C6C21BF56A1D0B1DB48D", var_0.owner);
  var_0.explosion = jeep_horn();
  var_2 = var_0.owner scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E");

  if(var_2)
    var_0.hasruggedeqp = 1;

  var_3 = scripts\engine\utility::ter_op(var_2, 200, 100);
  var_4 = "_encstr_A2FB098A2035874AB0F358";
  var_0 thread scripts\mp\damage::monitordamage(var_3, var_4, ::jugg_canreload, ::jugg_canparachute, 0);
  var_0 scripts\cp_mp\emp_debuff::set_apply_emp_callback(::jugg_assault3_check_size);
  var_0 setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
  var_0 thread javelin_forceclear();
}

javelin_forceclear() {
  self endon("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8AE20B891099472508F1113039");

  if(level.gametype == "_encstr_B607038AAB")
    self.ignoreme = 1;

  wait 0.1;
  thread joininprogresstimeout();
  thread jugg_pursue_players(1);
  wait 0.4;
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  self._id_13B97 = gettime();
  self._id_13B96 = gettime() + level.iswztrain.lifetime * 1000;
  level.iswztrain.instances = scripts\engine\utility::array_add(level.iswztrain.instances, self);
  var_0 = self.origin - (0, 0, 125);
  var_1 = 20;
  var_2 = var_0 + (0, 0, var_1);
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 250, 250);
  scripts\mp\utility\trigger::makeenterexittrigger(var_3, ::jugg_combo, ::jugg_enter_combat_callback, undefined, undefined, ::jugg_get_priority_player);
  var_3.tracknonoobplayerlocation = self;
  var_3 enablelinkTo();
  var_3 linkTo(self);
  self.trigger = var_3;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(3, 0, 1, self.origin);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13369();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(250);
  var_4 = level.iswztrain.lifetime;

  if(isDefined(level.br_circle) && _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::islastcircle() && level.iswztrain.weaponswitchhintlogic > 0)
    var_4 = level.iswztrain.weaponswitchhintlogic;

  wait(var_4);
  jug_encounter_test(undefined, 0, 0.15);
  jugg_canuseweaponpickups();
  thread scripts\mp\equipment_interact::remoteinteractsetup(::jug_encounter_test, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

jugg_idle_until_shot_or_near(var_0) {
  self.start_death_from_above_sequence = 1;
  thread jugg_modifyvehicletoplayerdamage();
  var_1 = int((var_0._id_13B96 - gettime()) / 1000);
}

jugg_managestockammo() {
  self.start_death_from_above_sequence = 0;
  jugg_objective_struct();
}

jugg_disableoverlayonentergulag() {
  if(!isDefined(self.gastriggerstouching))
    self.gastriggerstouching = [];

  if(self.gastriggerstouching.size > 0) {
    foreach(var_1 in self.gastriggerstouching) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(scripts\engine\utility::array_contains(var_1.playersintrigger, self)) {
        scripts\mp\equipment\gas_grenade::gas_onexittrigger(var_1 getentitynumber());
        return 1;
      }
    }
  }

  return 0;
}

jugg_get_closest_attackable_player() {
  if(!isDefined(self.gastriggerstouching))
    self.gastriggerstouching = [];

  if(self.gastriggerstouching.size > 0) {
    foreach(var_1 in self.gastriggerstouching) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(scripts\engine\utility::array_contains(var_1.playersintrigger, self)) {
        scripts\mp\equipment\gas_grenade::gas_onentertrigger(var_1);
        return 1;
      }
    }
  }

  return 0;
}

jugg_combo(var_0, var_1) {
  var_2 = gettime() + 500 >= var_1.tracknonoobplayerlocation._id_13B96;

  if(!var_2 && jugg_addtoactivejugglist(var_0) && !istrue(var_1.tracknonoobplayerlocation._id_122F2)) {
    var_3 = var_0;
    var_3.start_death_from_above_sequence = 1;
    var_3 jugg_idle_until_shot_or_near(var_1.tracknonoobplayerlocation);
    var_3 jugg_disableoverlayonentergulag();
    var_1.tracknonoobplayerlocation jugg_maze_killtrigger(var_3);

    if(scripts\cp_mp\gasmask::hasgasmask(var_3)) {
      var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8AF50A134EEBC6A5396C362B");
      var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8F220C3BC1D17391C2B85469FBB2");
      var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_960411D81AB2ADF533166C1D7B4E2FAF76B0DC");
    }

    if(isPlayer(var_3))
      var_3 scripts\mp\equipment\gas_grenade::gas_clear(0);
  }
}

jugg_enter_combat_callback(var_0, var_1) {
  if(jugg_addtoactivejugglist(var_0)) {
    var_2 = var_0;
    var_2 jugg_managestockammo();
    var_2 jugg_get_closest_attackable_player();
  }
}

jugg_get_priority_player(var_0, var_1) {
  if(jugg_addtoactivejugglist(var_0) || isDefined(var_0.vehicletype))
    return 0;

  return 1;
}

jugg_maze_killtrigger(var_0) {
  if(!isDefined(self.trigger.participants))
    self.trigger.participants = [];

  if(scripts\engine\utility::array_contains(self.trigger.participants, var_0)) {
    return;
  }
  self.trigger.participants = scripts\engine\utility::array_add(self.trigger.participants, var_0);
}

jugg_addtoactivejugglist(var_0) {
  return isPlayer(var_0) || isagent(var_0) || isbot(var_0);
}

jugg_pursue_players(var_0) {
  var_1 = "_encstr_8B86073AF9350F8288";

  if(var_0)
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AA202BEBBF50D11E13478983DFAA50D0E1D5B060E6A4A840EA5FDFB9EFC32BC0B6217918CA1BF80D118FDBBD07"), self, var_1);
  else
    killfxontag(scripts\engine\utility::getfx("_encstr_AA202BEBBF50D11E13478983DFAA50D0E1D5B060E6A4A840EA5FDFB9EFC32BC0B6217918CA1BF80D118FDBBD07"), self, var_1);

  for(var_2 = 1; var_2 <= 3; var_2++) {
    var_3 = "_encstr_B2BF0708BA770F795B";

    if(var_2 > 1)
      var_3 = var_3 + scripts\engine\utility::string(var_2);

    playFXOnTag(scripts\engine\utility::getfx("_encstr_92BE2C68BAC05FA923AFC54D6BAFD0C16E921810629B4B407B87563D41EB78AF1559D0A02BF689D9E7B3DDBD59D7"), self, var_3);
  }
}

jugg_protect_jammer_internal() {
  killfxontag(scripts\engine\utility::getfx("_encstr_AA202BEBBF50D11E13478983DFAA50D0E1D5B060E6A4A840EA5FDFB9EFC32BC0B6217918CA1BF80D118FDBBD07"), self, "_encstr_8B86073AF9350F8288");

  for(var_0 = 1; var_0 <= 3; var_0++) {
    var_1 = "_encstr_B2BF0708BA770F795B";

    if(var_0 > 1)
      var_1 = var_1 + scripts\engine\utility::string(var_0);

    stopFXOnTag(scripts\engine\utility::getfx("_encstr_92BE2C68BAC05FA923AFC54D6BAFD0C16E921810629B4B407B87563D41EB78AF1559D0A02BF689D9E7B3DDBD59D7"), self, var_1);
  }
}

joininprogresstimeout() {
  self endon("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A55C12F8C2EB2B33974CBD2F4C971AE7534AF8D8");
  wait(jug_spawn_func());
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C0410C21BE8B4D9CA22953836DECB519B8C");
}

#using_animtree("_encstr_A5CF0C3B8E2A106723EFB5A117BB");

jug_spawn_func() {
  return getanimlength(%_encstr_BAD020F775C1B036B703F0DA192F6B50A3D57B2FE437D8718F8BEE60C203ADC8FD2F);
}

jugg_assault3_check_size(var_0) {
  var_1 = var_0.victim;
  var_1 jug_trigger_spawn(var_0.attacker);
  var_1 jugg_canuseweaponpickups();
  var_1 thread jug_encounter_test(var_0.attacker, 1);
}

jugg_modifyvehicletoplayerdamage() {
  if(isagent(self)) {
    return;
  }
  if(istrue(self.isx1ops)) {
    return;
  }
  self.isx1ops = 1;
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_9ADF1C9D5CC117D8DAA62820877848EF536F973AA73FF2F6E735CD0F38B3"), self, "_encstr_AADA07DBF19A4A81D7");
  waitframe();
  var_0 = playfxontagforclients(scripts\engine\utility::getfx("_encstr_9ADF1C9D5CC117D8DAA62820877848EF536F973AA73FF2F6E735CD0F38B3"), self, "_encstr_AADA07DBF19A4A81D7", self);
}

jugg_objective_struct(var_0) {
  if(isagent(self)) {
    return;
  }
  if(istrue(var_0))
    killfxontag(scripts\engine\utility::getfx("_encstr_9ADF1C9D5CC117D8DAA62820877848EF536F973AA73FF2F6E735CD0F38B3"), self, "_encstr_AADA07DBF19A4A81D7");

  stopFXOnTag(scripts\engine\utility::getfx("_encstr_9ADF1C9D5CC117D8DAA62820877848EF536F973AA73FF2F6E735CD0F38B3"), self, "_encstr_AADA07DBF19A4A81D7");
  self.isx1ops = 0;
}

jugg_canparachute(var_0) {
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

jugg_canuseweaponpickups() {
  if(isDefined(self.trigger)) {
    if(!isDefined(self.trigger.participants))
      self.trigger.participants = [];

    var_0 = scripts\engine\utility::array_combine_unique(self.trigger.triggerenterents, self.trigger.participants);

    foreach(var_2 in var_0)
    var_2 jugg_enter_combat_callback(var_2, self.trigger);
  }

  jugg_protect_jammer_internal();
  level.iswztrain.instances = scripts\engine\utility::array_remove(level.iswztrain.instances, self);

  if(isDefined(self.mapcircle))
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();

  waitframe();

  if(isDefined(self.trigger))
    self.trigger delete();

  self notify("_encstr_BEE809A3785B486AA5FE17");
}

jugg_canreload(var_0) {
  var_1 = var_0.attacker;
  jug_trigger_spawn(var_1);
  thread jug_encounter_test(var_1, 1);
}

jug_encounter_test(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread jeep_initdamage(var_0, var_1);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8D31132C1B3AA567CA88B2B93A4E7BE56A1D85278E", 0);
  self._id_122F2 = 1;

  if(!isDefined(var_2))
    var_2 = 0.15;

  wait(var_2);

  if(isDefined(self.explosion))
    self.explosion delete();

  if(isDefined(self))
    self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C94112F46DB4B5BF59BA8E0A31AB0A310AD15", 0);
}

jeep_initdamage(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_BEE809A3785B486AA5FE17");
  self notify("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_88DD0C8047A3D007E37217AE8DDA", "_encstr_BA19049F4B2D");
  self.owner scripts\cp\vehicles\vehicle_compass_cp::_id_12032("_encstr_9B2F0D5B9D2BB782A7B02BF27821B8", self.usedcount, var_0, var_1);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(var_1));
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

  jugg_canuseweaponpickups();
  self setscriptablepartstate("_encstr_A3CD06BF48102D73", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8C94112F46DB4B5BF59BA8E0A31AB0A310AD15", 0);
  wait 2.0;
  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self))
    self delete();
}

jug_trigger_spawn(var_0) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_0))) {
    var_0 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    var_0 thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

jeep_horn() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0.killcament = self;
  var_0.owner = self.owner;
  var_0.team = self.team;
  var_0.equipmentref = self.equipmentref;
  var_0.weapon_name = self.weapon_name;
  var_0 setotherent(var_0.owner);
  var_0 setentityowner(var_0.owner);
  var_0 setModel("_encstr_B4B2194727DE0EA1F2BEE65E6EE856ADF56BC1BE2B0FC1C6BDC856");
  var_0.explode1available = 1;
  return var_0;
}

jeep_initcollision() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_0 = getdvarfloat("_encstr_81F01EAF6FAAD77B9A1517D0EB37E3F2AF02063888042F11F9609B414B1828C5", 0);
  self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BECC055CF3811A", 0);
  wait(var_0);
  self setscriptablepartstate("_encstr_A1430B84E48B6BF9D91BE83877", "_encstr_BD1805CB69C063", 0);
}

jeep(var_0) {
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

jugg_health_debug() {
  if(self.owner scripts\mp\equipment::hasequipment("_encstr_881C1456B8BAB438FA46958DB7CDD7E6E80B47A5DB37"))
    self.owner javelin_interact_monitor(self.ammo);
}