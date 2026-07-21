/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_inflation.gsc
**************************************************/

init() {
  if(!getdvarint("_encstr_92341A878F7EB122A8DE763D93E9650ADD2BAF676DAC4A19C060ED85", 0) || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_85EE090C9DD0A62F3CA1B3") {
    return;
  }
  level.debug_silo_jump = spawnStruct();
  level.debug_silo_jump.disabled = 0;
  level.debug_silo_jump.cost = getdvarint("_encstr_B48D1F4AF993CFAABE3FFFC381F082271881C95430D8B4D2954B3FD3EF86EA7340", 45);
  level.debug_silo_jump.minigamewinnersettings = getdvarfloat("_encstr_939627C23F6B9F2D3B06C879F0EFC1DA7B7ACF5BE26760273B7FE7DD1F132282F7297047A3A25B1D43", 1.0);
  level.debug_silo_jump.minigameapplyplayernamesettings = getdvarint("_encstr_A281235F88DBC7BA4508F6AD8577028F61D077BF58F13C72913B7D2578392B474B993727C3", -1);
  level.debug_silo_jump._id_12C89 = getdvarfloat("_encstr_978B281B30CDF1AB53B87164C51E5F0519E84132E04D75DFCB9B776E4883274A99504BFA0111EF2341FB", 10.0);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A4319E0710B51CAC6649BE8B2B33B4DD36D17ABDC83956D875BD0", ::playerdropplunderondeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_85DC0CB2A8BE0795B831C9C57B28", ::circletimer);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_96F00CAFF7571301BDFBC0989252", ::_id_12804);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8F351F39D6AB5F8FECFFB840AB1923CBF27CA1B36DF23911CCAF0839EF5C98339A", ::_id_11B16);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_938917C18D85CB56391DAE8D85D928AED17B5DA5735D16D28E", ::_id_125BD);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2", ::_id_13DCB);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_86342022A8D774B7E8B66875B67377FB0758F95A01692FEFC387546DC7583FC04BF0", ::assignspectatortospectateplayer);

  if(!getdvarint("_encstr_AF5B209BB1C9FA4C93FA16D88EAFB6B74659EBA59B998D2C1D5A7BE6D7765736B0EC", 0))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A9C319ABE6958ADBB6CAE651DB94ACECD2D995A29585D6B5B03AAC");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_97C92259EBD4B00CB16F0D0577CBDE286303C073172C0837DA0F2309AF239D711D9D8929");
  thread teamswithcirclepeek();
}

teamswithcirclepeek() {
  while(!isDefined(level.onplayerspawncallbacks))
    waitframe();

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

onplayerspawned() {
  _id_14012();
}

_id_12516() {
  return istrue(level.br_prematchstarted) && !istrue(self.delay_enter_combat_after_investigating_grenade) && !level.debug_silo_jump.disabled && self.plundercount >= level.debug_silo_jump.cost;
}

playerdropplunderondeath(var_0, var_1) {
  var_2 = self.plundercount;

  if(istrue(self.respawningfromtoken)) {
    var_2 = var_2 - level.debug_silo_jump.cost;

    if(var_2 < 0)
      var_2 = 0;
  }

  var_3 = int(var_2 * level.debug_silo_jump.minigamewinnersettings);
  var_2 = var_2 - var_3;
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_2, roof_combat_spawn_func());

  if(level.debug_silo_jump.minigameapplyplayernamesettings >= 0)
    var_3 = int(min(level.debug_silo_jump.minigameapplyplayernamesettings, var_3));

  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::ml_p3_func(var_3, var_0);
  return 1;
}

circletimer(var_0) {
  if(!var_0)
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_13249();

  var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::remove_engineer_class();

  if(!level.debug_silo_jump.disabled && var_0 >= var_1) {
    level.debug_silo_jump.disabled = 1;

    foreach(var_3 in level.players) {
      if(!isDefined(var_3) || !isalive(var_3)) {
        continue;
      }
      var_3 _id_14012();
      _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader(var_3, "_encstr_B8BB13512AF703C9374DC1C17F58015E5322AB19E2", undefined, 2);
    }
  }

  return 0;
}

_id_12804(var_0) {
  var_1 = 0;

  if(isDefined(var_0))
    var_1 = var_0._id_133E4;

  _id_14012(var_1);
}

_id_14012(var_0) {
  if(_id_12516()) {
    if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken()) {
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);

      if(!istrue(var_0))
        thread scripts\mp\hud_message::showsplash("_encstr_BD1D22DA5D41E47BF440C29BC85843D180EB433093D8EDF7A5587AB230B8F314705FDDB8");
    }
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken()) {
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();

    if(!istrue(var_0))
      thread scripts\mp\hud_message::showsplash("_encstr_86AD208927AF4BCD33D885E84BED37EB3995DC0EB0EEDCF5D1B76DACCD7D1BB7B9A3");
  }
}

_id_1336E(var_0) {
  waittillframeend;
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_131A2(1);
  thread spawn_drones(var_0);
}

spawn_drones(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    wait(var_0);

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_131A2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

roof_combat_spawn_func() {
  var_0 = spawnStruct();
  var_0._id_133E4 = 1;
  return var_0;
}

_id_11B16() {
  return 0;
}

_id_125BD(var_0, var_1) {
  if(!isDefined(var_0)) {
    if(level.debug_silo_jump._id_12C89) {
      var_2 = level.debug_silo_jump._id_12C89;
      thread _id_1336E(var_2);
      wait(var_2);
      return 1;
    }
  }

  return 0;
}

_id_13DCB(var_0) {
  return 1;
}

assignspectatortospectateplayer(var_0, var_1) {
  var_0 notify("_encstr_B43F2B467380716238AFC36F37DDCAA4B8FBB34DEFF0057A0DE3DB677989B2F14003FB56C068EE726691876F1B");

  if(istrue(level.endmatchcameratransitions))
    return 0;

  if(!isDefined(var_1) || !isPlayer(var_1) || !isalive(var_1) && !isDefined(var_1._id_1391A))
    return 0;

  if(var_0.team == var_1.team)
    return 0;

  if(!scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_8A2A0B936CCCC3078547970A8B"))
    return 0;

  thread cargo_truck_mg_mp_init(var_0);
  return 1;
}

cargo_truck_mg_mp_init(var_0) {
  level endon("_encstr_918D15899CA638B0DDB982D8B0CBB2273715DC8C4BB93B");
  var_0 endon("_encstr_B43F2B467380716238AFC36F37DDCAA4B8FBB34DEFF0057A0DE3DB677989B2F14003FB56C068EE726691876F1B");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_126AB();
  var_0 setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", var_0 getentitynumber());
  wait 1.0;
  var_1 = _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::regive_killstreak_after_use(var_0);
  thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::assignspectatortospectateplayer(var_0, var_1);
}