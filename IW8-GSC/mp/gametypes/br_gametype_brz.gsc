/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_brz.gsc
***********************************************/

init() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_87D21B4BCEE6F6275996ED6B89B4CA6E98C2371D9A1D589B46BA96072B");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8449141CD8B0972B4EA986B7EA63194A956E830BEE9B", ::_id_12691);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_ADBB1538C49859E5C29B60B8A33047CAA3AF31F1D38BE8", ::_id_1269C);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_99BF1329D1D1E75FE321F84309778B37879F3D33B2", ::_id_1269B);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::onplayerkilled);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A7BD11D3F8513A3FCBA7F9E7B077C33EAB601B", ::_id_142CC);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8F351F39D6AB5F8FECFFB840AB1923CBF27CA1B36DF23911CCAF0839EF5C98339A", ::_id_11B16);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_81B90F563DD951779708AF875968260A8F", ::addtoteamlives);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AC4D1453B030CFC3638C2A6571798A895861B7FB182B", ::removefromteamlives);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A9AE1816D8B1B7BBA9B2635659AC951A96B1C62B4458AD169DCA", ::brking_cleanupents);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C", ::_id_12604);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_92D41C7DFDCD983B3312B09969D3E7806742C7936CB468758F7A0FC1428F", ::_id_12BBA);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A549125D02CF7BE7E581E8980BFF55355FB9DDC3", ::droponplayerdeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_93311B4B70C8579DA809F9D34129A34FE069B012B897A717F9BFF1C40B", ::_id_13308);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97D311FBD1FDFCADD2C9E888A7D50FD3890F07", ::dangercircletick);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_ABF20BE7B0B911BA27BDD60AA5", ::onnewequipmentpickup);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AD491376AB362CD9752DDC37959C9456E60EC2DDE6", ::gulagwinnerrespawn);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846", ::_id_11B80);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8EC10D5F713FFBE6C151ED77E87034", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_1365D);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A3511399F56AFBE9595B700BE79DA369C29D0714CF", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::modifyplayerdamage);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_883F1450CA279389AF06E56B01FFF04387B2D8C8A2BF", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_11CA1);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9AB41DB476DCBDC9CAB2ACD04BD8C6CA153C83D8B79B4BCECA4416DA58ECAC", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::standard_health);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A9DC0F9AB5C75A7E1C30A79B90300912A9", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_1264B);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_82A210B87AF7FBF82B2571FF212F63B3DFD2", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_1264A);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_96A011C6169BE89A8E16CD8CA0C663F6DDB219", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::watch_flight_collision);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AB6E121F8B384F1A31424C9F0D0802380EE3B392", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::wait_for_chopper_boss_finish_turning);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::onplayerdamaged);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8B4A08AC3746E8165B56", _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::spawnangle);
  level.disable_super_in_turret._id_146C6 = 0;
  level.disable_super_in_turret._id_11B76 = getdvarint("_encstr_A2BD1AB9C639AF4C9CD79E0F38F5B52C3C152CB337CA4B9BB498D8CA", 0);
  level.disable_super_in_turret._id_11B74 = getdvarfloat("_encstr_A65F154B609DA1FB23C81A2077AE8F76D18112B2A83B62", 0);
  level.disable_super_in_turret._id_11B75 = level.disable_super_in_turret._id_11B74 * level.disable_super_in_turret._id_11B74;
  level.disable_super_in_turret._id_13A25 = getdvarint("_encstr_A38A16A321187F225B66C3D87927FBA575585AB742A4F3B0", 1);
  level.disable_super_in_turret.spawndomplates = getdvarint("_encstr_A607185B01560FEEE83FF2E87959B46F71F902010BA0F767C08F", 0);
  level.disable_super_in_turret._id_146B2 = getdvarint("_encstr_92F01CCD8DE4EB8993FAE93C83FA9EB7B6134BACF54627ED077D472CB39B", 0);
  level.disable_super_in_turret._id_11B5B = getdvarint("_encstr_AB2414F3CE3307EE9591C3DBD0F765B72AB87C9954BB", 0);
  level.disable_super_in_turret.spawndomplateflagtestmap = getdvarint("_encstr_8F16217F17BB30B0DA79FAB2DA8F985D2287CD9F83B2E748EFCB232E429D8815BAA343", 0);
  level.disable_super_in_turret._id_12CB0 = [];
  level.disable_super_in_turret._id_12CB1 = [];
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9541189EAD89FA47CA0B5BD658E8B2BEC40BB1ADAF0D57B5B0CD"] = "_encstr_81341B9088F88AB38881A39592282B8A3B9DE17D61AFE06731A789F252";
  level.br_infils_disabled = 0;
  thread toggleusbstickinhand();
}

toggleusbstickinhand() {
  waittillframeend;
  thread _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_1472D();
  thread _id_11CFB();
}

_id_11CFB() {
  for(;;) {
    foreach(var_1 in level.teamnamelist) {
      var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemies_fallback_logic(var_1);

      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        var_4 = var_2[var_3];
        var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationids(var_1, var_4);

        if(var_5 > 0) {
          var_6 = use_emp_drone(var_1, var_4);

          if(!var_6) {
            votesys_init(var_1, var_4);
            scripts\mp\utility\script::laststand_dogtags("_encstr_8BB12FDAB79B4BE8DEC9058DD869BDD613962B45AC58DA91D287AEC102690199B7AEB9C8404BE63B8536B42308A356B0D6");
          }
        }
      }
    }

    wait 1;
  }
}

_id_126F1() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;

  if(!istrue(game["_encstr_B23913A2485CFF7D08BDE2F117E0FD7389619BBA71"]))
    scripts\mp\hud_message::showsplash("_encstr_AA3321FB5A9147C8885A41D0131D5E6AAA70F0D362D8E2523B063879C03DE146108741");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("_encstr_8F7D08C66A0125438523");

    while(!self isonground())
      waitframe();
  } else
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);

  if(isalive(self) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    thread _id_125DB();

  wait 1;
  scripts\mp\hud_message::showsplash("_encstr_9AEB181A9D81A7073121D30BAB1DC7581001AF77DB40EEF7E9D9");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1", self, 0);
}

_id_13148() {
  var_0 = -15;
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::relic_amped_pick_random_valid_player(1);
  var_2 = max(0, var_1 + var_0);
  var_3 = getdvarfloat("_encstr_B2F7151277B34913839FFC4BF8B161BF5FD7E12091C203", var_2);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B10("_encstr_B8CB0D83F5B80B4A0811E7B768D0A9", var_3);
}

_id_14691(var_0) {
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_97090C4FB613EB7B0E59E6D2DCCE", 0, var_0);
  wait 1;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_85A0160A6D128F2D46BB507077745B012A520B1F85791943", 0, var_0);
}

_id_12051() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self;
  wait 3;

  while(!var_0 isonground())
    wait 2;

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_AAA016125DBBDEEBA5224B30A97B9BF337EA1307A4A7EB65", var_0);
}

_id_11B16() {
  return _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_11B16();
}

_id_12691(var_0) {
  if(!istrue(level.br_prematchstarted))
    return 1;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::iswaitingtoentergulag(self))
    return 1;

  return _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
}

_id_11B80(var_0, var_1) {
  var_2 = 0;
  var_3 = use_emp_drone(var_0.team, var_0.squadindex, var_0);

  if(!istrue(self.gulag) && _encstr_8C4222CDD8C92D071DDC79B683BC7616DA958EBC1CCA9B799839EBE9ED9B5937E2ECDC8D::updatelocationbesttimehud("_encstr_8DB007073616ECAE95", var_0)) {
    if(var_3)
      var_2 = var_0 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_126D2(var_1);
  } else if(!var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    var_2 = var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::trygulagspawn();

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && !var_2) {
    if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
      thread _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12538();

    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11B15(var_0);

    if(!var_3)
      votesys_init(var_0.team, var_0.squadindex, var_0);
  }

  return !var_2;
}

use_emp_drone(var_0, var_1, var_2) {
  var_3 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1);

  foreach(var_6 in var_4) {
    if(isDefined(var_2) && var_6 == var_2) {
      continue;
    }
    if(istrue(var_3) && var_6 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
      return 1;

    var_7 = var_6 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() || var_6 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125E9();

    if(!var_7 && isalive(var_6) && !istrue(var_6.inlaststand))
      return 1;

    if(istrue(var_6.inlaststand) && (istrue(var_6.shouldgetnewspawnpoint) || var_6 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12517()))
      return 1;
  }

  return 0;
}

votesys_init(var_0, var_1, var_2) {
  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_2) && var_2 == var_5) {
      continue;
    }
    if(isalive(var_5)) {
      var_5 suicide();
      continue;
    }

    if(var_5 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125E9()) {
      var_5 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12681(0, 0);
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11B15(var_5);
      var_5 scripts\mp\playerlogic::removefromalivecount();
      continue;
    }
  }
}

_id_1269C(var_0) {
  return _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
}

_id_1269B(var_0) {
  return _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
}

_id_13308(var_0) {
  var_1 = isPlayer(var_0.attacker) && var_0.attacker _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
  var_2 = isPlayer(var_0.victim) && var_0.victim _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();

  if(var_1 && !var_2 && var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981")
    return 0;

  return 1;
}

brking_cleanupents(var_0) {
  var_1 = isPlayer(var_0.attacker) && var_0.attacker _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
  return var_1;
}

_id_12728() {
  playFX(scripts\engine\utility::getfx("_encstr_85810DE97B5B4C96957D8E39B0B9DC"), self.origin);
  self notify("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
  _id_1272E(0);
  var_0 = gettime() + 3000;

  while(self isgestureplaying() && var_0 > gettime()) {
    self stopgestureviewmodel();
    waitframe();
  }

  while(var_0 > gettime() && (self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8C140CAFEF2FC261305972B65549")]]()))
    waitframe();

  self enableoffhandweapons();
  self giveandfireoffhand("_encstr_ABA20CDC474BDABE3D6BC4F5D61C");
  wait 2;
}

_id_1272E(var_0) {
  self allowfire(var_0);
  self allowmovement(var_0);
  self allowmelee(var_0);

  if(var_0) {
    self playershow();
    self enableoffhandweapons();
  } else {
    self playerhide();
    self disableoffhandweapons();
  }
}

_id_126FA(var_0) {
  if(!istrue(var_0) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    return;
  }
  _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12681(0);
  _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12727(0);

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_B82907C2887BC62B39");
  else
    self _meth_87AA("_encstr_B40101");

  if(isDefined(self.operatorcustomization.clothtype) && self.operatorcustomization.clothtype != "_encstr_B40101")
    self setclothtype(self.operatorcustomization.clothtype);
  else
    self setclothtype("_encstr_BEE00A93594E2BE548C7786C");

  self._id_12CA8 = 1;
  var_1 = self.origin;
  var_2 = self.origin;
  var_3 = self getplayerangles();
  var_4 = 0;

  if(level.disable_super_in_turret.spawndragonsbreathstruct)
    [var_2, var_3, var_1] = _id_125DD();
  else {
    [var_2, var_3, var_4] = _id_125DE();
    var_1 = var_2;
  }

  self.plotarmor = 1;
  self setscriptablepartstate("_encstr_BACB074025B01AAA28", "_encstr_BA19049F4B2D");
  self setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_B4250C393D87BECBF505130E27C3");
  self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
  _id_12728();

  if(!var_4) {
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
    wait 1;
  } else
    waitframe();

  scripts\mp\class::loadout_emptycacheofloadout("_encstr_AAAC09D09972B9C83F2B7F");
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.br_respawn_loadout;
  self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.forcespawnangles = var_3;
  self.forcespawnorigin = var_1;
  scripts\mp\utility\player::_setsuit("_encstr_917A134BBB70AF23CA99C25D1B47CDBA5A3AFADA38");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self skydive_deployparachute();
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
  _id_1272E(1);
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");

  if(level.disable_super_in_turret._id_1470D)
    thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();

  if(level.disable_super_in_turret._id_1470C) {
    _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125DA();

    if(!level.disable_super_in_turret._id_1470D)
      self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63");

    self visionsetnakedforplayer("_encstr_B40101", 0);
  }

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    self.plotarmor = undefined;
    _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_126BD(var_2, var_3, var_1);
  } else {
    if(!var_4) {
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
      playFX(scripts\engine\utility::getfx("_encstr_85810DE97B5B4C96957D8E39B0B9DC"), self.origin);
    }

    if(!var_4)
      _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();

    thread _id_1252C();
  }

  if(istrue(level.disable_super_in_turret.spawndomplateflagtestmap) && _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125FA())
    _id_125FB();
  else {
    var_7 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::disablealltablets();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::searchcircleorigin(var_7, 0);
  }

  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
  _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_1262B(0);
  scripts\mp\hud_message::showsplash("_encstr_827C1D314EF5CE16DA56D1BC1C95F5E987C1AF1BD058E676B2BED0BADA589B");
  self.plotarmor = undefined;
  thread _id_125D9();
  self._id_12CA8 = undefined;

  foreach(var_9 in level.teamdata[self.team]["_encstr_9775086022BE1B413B8B"]) {
    if(self != var_9)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_9541189EAD89FA47CA0B5BD658E8B2BEC40BB1ADAF0D57B5B0CD", var_9);
  }
}

_id_125DD() {
  var_0 = getdvarint("_encstr_B8A01DDC369CD79893EB9EC338FACDC12CEE9BA1CA5AEC861DED33336E5647", 3000);
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::relic_nuketimer_gettimeformission() / 1000;
  var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE(0, var_1, var_0);
  var_3 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_2);
  return [var_2.origin, var_2.angles, var_3];
}

_id_125DE() {
  [var_1, var_2, var_3] = _id_125D8();

  if(!var_3)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_1);

  return [var_1, var_2, var_3];
}

_id_125D8() {
  var_0 = 500;
  var_1 = 10000;
  var_2 = 5;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return [self.origin, self getplayerangles(), 1];

  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_5 = distance2dsquared(self.origin, var_4);

  if(var_5 <= var_3 * var_3)
    return [self.origin, self getplayerangles(), 1];

  var_6 = undefined;
  var_7 = undefined;
  var_8 = (self.origin[0], self.origin[1], 0);
  var_9 = vectorNormalize(var_8 - var_4);

  for(var_10 = 1; var_10 <= var_2; var_10++) {
    var_11 = var_3 - var_0 * var_10;

    if(var_11 < 0) {
      break;
    }

    [var_6, var_7] = remove_marker_when_player_disconnects(var_4, var_9, var_11);

    if(isDefined(var_6)) {
      break;
    }
  }

  if(!isDefined(var_6)) {
    var_6 = var_4;
    var_7 = self getplayerangles();
  }

  var_13 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_6, var_1);
  return [var_13, var_7, 0];
}

remove_marker_when_player_disconnects(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * var_2;
  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::relic_nuketimer_gettimeformission() / 1000;

  if(_encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::set_relic_rocket_kill_ammo(var_3, var_4)) {
    var_5 = vectortoangles(var_1 * -1);
    return [var_3, var_5];
  } else
    return [undefined, undefined];
}

_id_125D9() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_84290BF4DBB698B42BAFCD2BA3");

  while(!self isonground())
    waitframe();

  thread _id_125DB();
}

_id_125FB() {
  self takeallweapons(0, 1);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  self.equipment["_encstr_BA7F0830B3A7859B60B0"] = undefined;
  self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"] = undefined;
  self.equipment["_encstr_91B50734CA58631D1A"] = undefined;
  self.equipment["_encstr_BEB406F03B72BB3B"] = undefined;
  var_0 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

  if(self._id_1472F._id_12889.size < 2)
    self giveweapon(var_0);

  var_1 = 0;

  foreach(var_3 in self._id_1472F._id_12889) {
    var_4 = createheadicon(var_3);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);

    if(!var_1) {
      self assignweaponprimaryslot(var_4);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
      var_1 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var_4);
  }

  foreach(var_7 in self._id_1472F.offhands) {
    var_8 = scripts\mp\equipment::getequipmentreffromweapon(var_7);

    if(!isDefined(var_8)) {
      continue;
    }
    var_9 = self._id_1472F.nvidiaansel_overridecollisionradius[var_8];

    if(!isDefined(var_9)) {
      continue;
    }
    scripts\mp\equipment::giveequipment(var_8, var_9);
  }

  foreach(var_4, var_12 in self._id_1472F.brtruck_ontimelimit) {
    self setweaponammostock(var_4, var_12);
    var_3 = getcompleteweaponname(getweaponbasename(var_4));
    var_13 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_3);

    if(isDefined(var_13)) {
      self.br_ammo[var_13] = var_12;
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_hud_update_ammotype(var_13);
    }
  }

  foreach(var_4, var_12 in self._id_1472F.brtdm_config)
  self setweaponammoclip(var_4, var_12);

  foreach(var_4, var_12 in self._id_1472F.brtruck_cleanupents)
  self setweaponammoclip(var_4, var_12, "_encstr_A5AD056A019C63");

  waitframe();
  var_16 = var_0;

  if(isDefined(self._id_1472F.current) && self._id_1472F.current != getcompleteweaponname("_encstr_8BBA05185F8B99"))
    var_16 = self._id_1472F.current;

  self switchtoweaponimmediate(var_16);

  if(isDefined(self._id_1472F.super)) {
    var_17 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self._id_1472F.super]];
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper(var_17, 0);
  }

  thread scripts\cp_mp\gestures::_id_13E1A();
  self._id_1472F = undefined;
}

addtoteamlives(var_0, var_1) {
  var_0 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::addtoteamlives(var_0, var_1);
}

removefromteamlives(var_0, var_1) {
  var_0 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::removefromteamlives(var_0, var_1);
}

_id_1472E(var_0) {
  if(level.disable_super_in_turret.spawndomplateflagtestmap && !var_0 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125FA())
    var_0 _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125FC();
}

gulagwinnerrespawn(var_0) {
  if(level.disable_super_in_turret.spawndomplateflagtestmap && _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125FA())
    _id_125FB();
}

_id_12702() {
  self.itemsdropped = 0;
  var_0 = level.disable_super_in_turret._id_146C6 % 10;
  level.disable_super_in_turret._id_146C6++;
  var_1 = verifybunkercode("_encstr_82470DF0B83BAAB09D966F23813C01", var_0);

  if(isDefined(var_1))
    var_2 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_1, 0);
}

_id_12604() {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    return;
  else
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11E23();
}

droponplayerdeath(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() || istrue(self.isjuggernaut))
    return 1;

  if(level.disable_super_in_turret.spawndomplateflagtestmap)
    _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125FC();

  return 0;
}

onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  var_1 = var_0.victim;
  var_2 = var_0.attacker;

  if(!isDefined(var_2) || !isPlayer(var_2) || !isDefined(var_1)) {
    return;
  }
  var_3 = var_0.hitloc;

  if(isDefined(var_3) && var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && (var_3 == "_encstr_81CC0586952C91" || var_3 == "_encstr_A6CC076A05751852B3")) {
    var_4 = 0;
    var_2 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_BA1A129877094830430AE74AC815EA8048581D93", var_4, 1);
  }

  var_1 setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
}

_id_13325(var_0) {
  if(isDefined(var_0) && var_0 == self)
    return 0;

  if(level.teambased && isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team)
    return 0;

  if(isDefined(var_0) && !isDefined(var_0.team) && (var_0.classname == "_encstr_85FE0DD5727A27098513298817CA23" || var_0.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0"))
    return 0;

  if(isagent(self) || isagent(var_0))
    return 0;

  return 1;
}

_id_13326(var_0) {
  if(!_id_13325(var_0))
    return 0;

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    return 0;

  return 1;
}

_id_13302(var_0) {
  if(!_id_13325(var_0))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    return 0;

  return 1;
}

resetdangercircleorigin() {
  var_0 = undefined;

  foreach(var_2 in level.disable_super_in_turret._id_12CB0) {
    if(!isDefined(var_0) || var_2.lastusedtime < var_0.lastusedtime)
      var_0 = var_2;
  }

  return var_0;
}

spawndogtags() {
  var_0 = 16;
  var_1 = undefined;
  var_2 = 0;
  var_3 = undefined;

  if(level.disable_super_in_turret._id_12CB1.size > 0) {
    var_4 = level.disable_super_in_turret._id_12CB1.size - 1;
    var_1 = level.disable_super_in_turret._id_12CB1[var_4];
    level.disable_super_in_turret._id_12CB1[var_4] = undefined;
    loadoutprimaryaddblueprintattachments(var_1);
    var_2 = 1;
    var_3 = var_1.trigger;
    var_5 = var_1.visuals;
  } else if(level.disable_super_in_turret._id_12CB0.size >= level.disable_super_in_turret._id_11B5B) {
    var_1 = resetdangercircleorigin();
    loadoutprimaryaddblueprintattachments(var_1);
    var_2 = 1;
    var_3 = var_1.trigger;
    var_5 = var_1.visuals;
  } else {
    var_6 = "_encstr_AF991C1915C91725664AF1500921FB91015B54F7F567EAE313F15CE2A063";
    var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_5[0].angles = (45, 0, 0);
    var_5[0] setModel(var_6);
    var_5[0] hudoutlineenable("_encstr_8D6B15DEAEE8D84BCD957D8CB2C1D143BE07AE4E38C6CA");
    var_5[0] setasgametypeobjective();
    var_5[0].usetype = 1;
    var_5[0].vampirepoints = 1;
    var_3 = var_5[0];

    if(level.disable_super_in_turret._id_13A25) {
      var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", (0, 0, 0), 0, 32, 32);
      var_3.vampirepoints = 1;
      var_5[0].vampirepoints = undefined;
    }
  }

  var_7 = "_encstr_9A19040BCDBC";
  var_8 = 0;
  var_1 = scripts\mp\gameobjects::createuseobject(var_7, var_3, var_5, (0, 0, var_0), undefined, var_2);
  var_1._id_133E5 = 1;
  var_1.onuse = ::onuse;
  var_1 scripts\mp\gameobjects::setusetime(var_8);
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::timeoutonabandonedcallback();
  var_1.inuse = 1;
  var_1.lastusedtime = gettime();
  var_9 = "_encstr_B40101" + var_1 getentitynumber();
  level.disable_super_in_turret._id_12CB0[var_9] = var_1;
  return var_1;
}

_id_13238(var_0, var_1) {
  var_2 = 36;
  var_3 = (0, 0, 36);
  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_1, 30);
  var_5 = var_4 + (0, 0, var_2);
  var_0.curorigin = var_5;

  if(level.disable_super_in_turret._id_13A25)
    var_0.trigger.origin = var_5;

  var_0.visuals[0].origin = var_5;
  var_0 scripts\mp\gameobjects::initializetagpathvariables();
  var_0.interactteam = "_encstr_9A19040BCDBC";
  var_0.visuals[0] _id_1337A();
  var_0.ownerteam = "_encstr_A7A408B9CA5D1D4E2C63";
  var_0.trigger triggerenable();

  if(isDefined(var_0.objidnum)) {
    if(var_0.objidnum != -1) {
      var_6 = var_0.objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_6, "_encstr_930B07BB1B6B3854FF");
      scripts\mp\objidpoolmanager::update_objective_position(var_6, var_4 + var_3);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_6, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_0.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_0.objidnum, 0);
      var_0 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_8D701AD8D9A3D7CD4C1A2C4F6BC02F0B49DF82890FABA35586805851", "_encstr_8ECD1123407BEFC751BD31889F2789592B50D7");
      var_0 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
      objective_icon(var_0.objidnum, "_encstr_8FD7152CF02AB611202FDE406061206863C32064F55F4D");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.objidnum);
    }
  }

  playsoundatpos(var_5, "_encstr_A28719B5E0F55B5A36D86CDBDC995A39DAEB3A0BEC37BE91C9DB0E");
  var_0.visuals[0] scriptmodelplayanim("_encstr_845B0F80326F10804A938B9F27535730E6");
}

_id_13662(var_0, var_1) {
  var_2 = spawndogtags();
  _id_13238(var_2, var_0.origin);

  if(istrue(var_0.isjuggernaut)) {
    var_3 = 2;
    var_4 = getdvarint("_encstr_8C18172FF8ABB7CA1558601837A7C245906993D7F8C4D5C207", var_3);
    var_5 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

    for(var_6 = 1; var_6 < var_4; var_6++) {
      var_7 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_5, var_0.origin, var_0.angles, var_0, undefined, undefined, 0);

      if(!isDefined(var_7) || var_7.origin == (0, 0, 0))
        var_7.origin = var_0.origin;

      var_2 = spawndogtags();
      _id_13238(var_2, var_7.origin);
    }
  }
}

_id_1332E(var_0) {
  if(!_id_13325(var_0))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && self._id_11F39 > 0)
    return 1;

  return 0;
}

_id_136BA(var_0, var_1) {
  var_2 = spawndogtags();
  _id_13238(var_2, var_0.origin);

  if(self._id_11F39 > 1) {
    var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

    for(var_4 = 1; var_4 < self._id_11F39; var_4++) {
      var_5 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_3, var_0.origin, var_0.angles, var_0, undefined, undefined, 0);

      if(!isDefined(var_5) || var_5.origin == (0, 0, 0))
        var_5.origin = var_0.origin;

      var_2 = spawndogtags();
      _id_13238(var_2, var_5.origin);
    }
  }
}

loadoutprimaryaddblueprintattachments(var_0) {
  var_0.visuals[0] dontinterpolate();
  var_0.visuals[0] hide();
  var_0.trigger triggerdisable();
  var_0.trigger notify("_encstr_8BE208E31FA8E1631D65");
  var_0 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  var_0.inuse = 0;
  var_0.visuals[0].origin = (0, 0, 0);
  var_0.trigger.origin = (0, 0, 0);
  headlessinfilplayers(var_0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.objidnum);
}

removetags(var_0) {
  loadoutprimaryaddblueprintattachments(var_0);
  var_1 = "_encstr_B40101" + var_0 getentitynumber();
  level.disable_super_in_turret._id_12CB0[var_1] = undefined;
  level.disable_super_in_turret._id_12CB1[level.disable_super_in_turret._id_12CB1.size] = var_0;
  playFX(level._effect["_encstr_ABCF0CDC475AD6F50EB41BD6BAC1"], var_0.curorigin);
  playsoundatpos(var_0.curorigin, "_encstr_91DA104FE1837D3A58EC6EFA832D8DD6AB1C");
}

headlessinfilplayers(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
      continue;
    }
    var_3 = var_2 getnodeoffset_code(7);

    if(var_3 != -1 && var_3 == var_0.objidnum)
      var_2 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
  }
}

_id_126E6(var_0) {
  foreach(var_2 in level.disable_super_in_turret._id_12CB0) {
    if(isDefined(var_2.visuals[0]))
      var_2.visuals[0] _id_12CB2(self);
  }
}

_id_12CB2(var_0) {
  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    self showtoplayer(var_0);

    if(!level.disable_super_in_turret._id_13A25)
      self enableplayeruse(var_0);
  } else {
    self hidefromplayer(var_0);

    if(!level.disable_super_in_turret._id_13A25)
      self disableplayeruse(var_0);
  }
}

_id_1337A() {
  self hide();

  if(!level.disable_super_in_turret._id_13A25) {
    self makeusable();
    self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
    self setHintString(&"_encstr_AAA40EBF0966CA113908B2FC16579988");
    self setuseprioritymax();
  }

  foreach(var_1 in level.players)
  _id_12CB2(var_1);
}

onuse(var_0) {
  _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::onuse(var_0);
}

_id_12730() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  var_0 = 0.5;

  for(;;) {
    var_1 = self getnodeoffset_code(7);
    var_2 = sortbydistance(level.disable_super_in_turret._id_12CB0, self.origin);
    var_3 = 0;

    foreach(var_5 in var_2) {
      var_6 = undefined;

      if(var_3 < level.disable_super_in_turret._id_11B76 && level.disable_super_in_turret._id_11B75 > 0)
        var_6 = distance2dsquared(self.origin, var_5.origin);

      if(var_3 < level.disable_super_in_turret._id_11B76 && (level.disable_super_in_turret._id_11B75 == 0 || var_6 < level.disable_super_in_turret._id_11B75)) {
        var_3++;
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_5.objidnum, self);
        continue;
      }

      var_3 = level.disable_super_in_turret._id_11B76;
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_5.objidnum, self);

      if(var_1 != -1 && var_1 == var_5.objidnum)
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }

    wait(var_0);
  }
}

_id_125CE() {
  foreach(var_1 in level.disable_super_in_turret._id_12CB0)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.objidnum, self);
}

gulagisspawnpositionwithindangercircle(var_0) {
  if(istrue(level.disable_super_in_turret._id_146E7)) {
    if(getdvarint("_encstr_874A205B708DB1EB13F82A3007DEE347F780E293A07F761F48C02B289D83630D57E8", 0) == 0) {
      return;
    }
    var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::remove_engineer_class();

    if(var_0 >= var_1)
      level.disable_super_in_turret._id_146E7 = 0;
  }
}

_id_13284() {
  if(istrue(level.br_circle_disabled)) {
    return;
  }
  if(getdvarint("_encstr_874A205B708DB1EB13F82A3007DEE347F780E293A07F761F48C02B289D83630D57E8", 0) == 0) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  var_0 = "_encstr_B8B209842D94DB0579ECFC";
  var_1 = 0.8;
  var_2 = -100;
  var_3 = -290;
  var_4 = 90;
  var_5 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::run_hud_logic();
  var_6 = init_relic_trex(var_0, var_1);
  var_6 scripts\mp\hud_util::setpoint("_encstr_8253061E6BDF6331", "_encstr_A5C407E57585313DB1", var_3, var_2);
  var_6.label = &"_encstr_A3051733EB598271E8758F6502B0E15CE06FA3A973A0CC51D4";
  var_7 = scripts\mp\hud_util::createservertimer(var_0, var_1);
  var_7 scripts\mp\hud_util::setpoint("_encstr_A5AD0568058CE3", "_encstr_A5C407E57585313DB1", var_3, var_2);
  var_7 settenthstimer(var_5);
  var_8 = getdvarint("_encstr_8C4923EBB1E69F7E784F9C69EF9005AF8BAE2233F8370779D8019F7BEBC10DE736C3DA9AA1", var_4);
  var_9 = var_5 - var_8;

  if(var_9 > 0) {
    wait(var_9);
    var_7.color = (1, 0, 0);
    var_7 thread _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::spawn_vindia_assault3();
    wait(var_8);
  } else
    wait(var_5);

  wait 2;
  var_7 destroy();
  var_6 destroy();
}

_id_142CC(var_0, var_1) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::wait_for_chopper_boss_finish_turning(var_0);
  else
    _encstr_92CD26C37908D8EB3D1F670F50C8DA3955FB5BD792B14F9E42836953ACF2D18F7312F230F087FB66::_id_142C6(self, var_0, var_1);
}

init_relic_trex(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_3 = newteamhudelem(var_2);
  else
    var_3 = newhudelem();

  var_3.elemtype = "_encstr_9779056EEA2583";
  var_3.font = var_0;
  var_3.fontscale = var_1;
  var_3.basefontscale = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_1);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 scripts\mp\hud_util::setparent(level.uiparent);
  var_3.hidden = 0;
  var_3.alpha = 1;
  return var_3;
}

gulagisfaded() {
  level.br_level.br_circledelaytimes[1] = level.br_level.br_circledelaytimes[0];
  level.br_level.br_circledelaytimes[0] = 1;
  level.br_level.br_circleclosetimes[0] = 1;
  level.br_level.default_player_connect_black_screen[0] = 1;
}

init_relic_aggressive_melee() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path(var_0, var_1);
  return var_2;
}

being_hacked() {
  thread vehomn_getleveldata();
}

vehomn_getleveldata() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = distance(self._id_12205.startpt, self._id_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed() - 5;
  wait(var_1);

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "_encstr_969105B1C4CC81" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
      var_3 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
    }
  }
}

_id_12BBA(var_0) {
  return _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_12BBA(var_0);
}

onnewequipmentpickup(var_0) {
  foreach(var_2 in level.players) {
    var_2 hudoutlinedisable();

    if(var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
      var_2 setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_B4250C393D87BECBF505130E27C3");
      var_2 unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);

      if(level.disable_super_in_turret._id_1470C) {
        if(!level.disable_super_in_turret._id_1470D)
          var_2 setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63");

        var_2 visionsetnakedforplayer("_encstr_B40101", 0);
      }

      if(!isDefined(scripts\engine\utility::array_find(var_0, var_2))) {
        var_2 playerhide();
        var_2 setscriptablepartstate("_encstr_BACB074025B01AAA28", "_encstr_BA19049F4B2D");
      }
    }
  }
}

_id_13252() {
  if(!istrue(level.disable_super_in_turret.spawndomplates)) {
    return;
  }
  level.disable_super_in_turret.human = spawnStruct();
  level.disable_super_in_turret.human.powers = [];
  _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::battlepassxpmultipliers(level.disable_super_in_turret.human, "_encstr_8C0E05C27340B0", ["_encstr_A6E308B2DCE8B0B936B2", "_encstr_ACF70A27C7824C50E45D6358"], ::_id_125D5, 1, undefined, ::_id_125D6, undefined, &"_encstr_B8460CE95AB9FD4E1086B1816F50", undefined, 60);
}

_id_125DB() {
  if(!istrue(level.disable_super_in_turret.spawndomplates)) {
    return;
  }
  thread _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_126B4(level.disable_super_in_turret.human);
}

_id_125D5(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_84290BF4DBB698B42BAFCD2BA3");
  var_2 = 750;

  if(istrue(self.hoopty_truck_initomnvars)) {
    var_3 = getdvarint("_encstr_A5B71EFBDEDD08C533474013BFC78BA08BB24F39BF5FC16A45F961912BB1B03A", var_2);
    var_4 = gettime() - self.hoopty_truck_initomnvars;

    if(var_4 <= var_3) {
      _id_1252C();
      thread _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_1262C(var_0, var_1);
      self.hoopty_truck_initomnvars = undefined;
      return;
    }
  }

  self.hoopty_truck_initomnvars = gettime();
}

_id_1252C() {
  if(!getdvarint("_encstr_B29C1F336A93F840D217B5C940F158B5B7E2283EF3732F30ED3F8FEF7626487E67", 0)) {
    return;
  }
  var_0 = 650;
  var_1 = getdvarint("_encstr_AABA17C862CAE711AB37524BF0F79B4B723A3148FAE7C38BF7", var_0);
  var_2 = incrementpersistentstat(level.players, self.origin, var_1);

  foreach(var_4 in var_2) {
    if(var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && var_4.team != self.team && isalive(var_4))
      _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::_id_125D7(var_4, var_1);
  }

  var_6 = anglesToForward(self.angles);
  playFX(level.disable_super_in_turret.start_coop_defuse_infiltrate, self.origin, var_6);
  playsoundatpos(self.origin, "_encstr_ACB215AFFF55B3E84BB1C150DF9CAD986F9FA3737743FA");
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", self.origin);
  earthquake(0.5, 1.5, self.origin, var_1);
}

_id_125D6(var_0, var_1) {
  self.hoopty_truck_initomnvars = undefined;
}

_id_11BA8(var_0) {
  var_1 = var_0.meansofdeath;
  var_2 = var_0.victim;
  var_3 = var_0.hitloc;

  if(isPlayer(var_2) && var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && (var_3 == "_encstr_81CC0586952C91" || var_3 == "_encstr_A6CC076A05751852B3"))
    var_1 = "_encstr_A13D156A9E88AF21540A227D4D21D345F5D27AD412298A";

  return var_1;
}

dangercircletick(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.disable_super_in_turret._id_12CB0) {
    if(isDefined(var_4.visuals) && distance2dsquared(var_4.origin, var_0) > var_2)
      thread removetags(var_4);
  }
}