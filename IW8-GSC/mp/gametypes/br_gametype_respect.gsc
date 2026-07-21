/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_respect.gsc
************************************************/

init() {
  level._id_12CB9 = spawnStruct();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_95F80E992D399B1D345A93B18DB295F6");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_932316AC447BD37F648F9058EB81710982E39F241A62A9E1");
  level.decoyassists = ::groundz;
  level thread _id_12800();
}

_id_12800() {
  waittillframeend;
  var_0 = getdvarint("_encstr_956120DCB14EEBC9568C568336B7F245DEB5CAE6D7D8BD9B3B569C4750D6DEAB73D1", 40);
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  scriptableinit();
  _encstr_83D01CD9963B951636B107B1582FAC39B92756C82B0ED8DE5E3ADE5B59E6();
  var_1 = getdvarint("_encstr_835E23FB8E1B89AD9213825F529538BB41C80AA1B86F60EE68BE8D07DABBA118721584E395", 810);
  wait(var_1);

  foreach(var_3 in level.players) {
    if(istrue(level.br_pickups._id_12CB5) && var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken() && var_0 > 0) {
      var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();
      var_3 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_0);
      var_3 scripts\mp\utility\lower_message::_id_1316E("_encstr_8161177EAB19928AE51B0B73671351FBF0B0F30703A041E2C8", undefined, 5);
    }
  }
}

groundz() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_97CE0D72D84DC423792EE1F2C6E0F7");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC");
  var_0 = getdvarint("_encstr_A54F1ED38A731820F7DB4153F39B81DEC77329B872D650F0CDAF4F5B2C042895", 780);
  var_1 = getdvarint("_encstr_B66E1E6EC64EBEC9AC6EC1B28D477D6CB49CB11B59237D368D7B37ACA24B5B56", 120);
  var_2 = getdvarint("_encstr_887920CDB1E47D93B29B0E5636D1BE8D4B276C63B2C4FAB1C6DE37954958C8B4D5DC", 3000);

  switch (getdvarint("_encstr_A2E6191B41164FAA10A738359FC0B9F733DB9272697827E238E324", 0)) {
    case 0:
      level._id_12CB9.groundentity = [30, 30];
      level._id_12CB9.ground_spawners = [var_0, var_1];
      level.br_level.default_player_connect_black_screen = [0, 0];
      level.br_level.default_suicidebomber_combat = [0, 0];
      level.br_level.br_circleradii = [75000, var_2, 0];
      level.br_level.br_circleminimapradii = [9000, 5500];
      break;
    case 1:
      level._id_12CB9.groundentity = [60];
      level._id_12CB9.ground_spawners = [var_0];
      level.br_level.default_player_connect_black_screen = [0];
      level.br_level.default_suicidebomber_combat = [0];
      level.br_level.br_circleradii = [75000, 0];
      level.br_level.br_circleminimapradii = [6000];
      break;
  }

  level.br_level.br_circledelaytimes = level._id_12CB9.groundentity;
  level.br_level.br_circleclosetimes = level._id_12CB9.ground_spawners;
}

_id_12CBA(var_0) {
  if(getdvarint("_encstr_BD3E1F6EC639D7C9CA6E0E95B1A3AFADD2B11BAF36BD76968DBE2BE616136395C8", 0) == 0) {
    return;
  }
  if(!isDefined(var_0) || !isPlayer(var_0) || istrue(var_0.inlaststand) || !var_0 scripts\cp_mp\utility\player_utility::_isalive() || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal() || istrue(var_0.isjuggernaut)) {
    return;
  }
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(scripts\mp\utility\weapon::ismeleeonly(var_3) || scripts\mp\utility\weapon::issuperweapon(var_3) || scripts\mp\utility\weapon::iskillstreakweapon(var_3) || scripts\mp\utility\weapon::isgamemodeweapon(var_3)) {
      continue;
    }
    var_4 = scripts\mp\utility\weapon::getweapongroup(var_3);
    var_5 = 3;
    var_6 = scripts\mp\weapons::getammooverride(var_3) * var_5;

    if(var_3.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_3.underbarrel) == "_encstr_BE9708CBAB13138857AD") {
      var_7 = var_0 getweaponammoclip(var_3);
      var_8 = int(var_7 + var_6);
      var_0 setweaponammoclip(var_3, var_8);
      continue;
    }

    var_9 = var_0 getweaponammostock(var_3);
    var_8 = int(var_9 + var_6);
    var_0 setweaponammostock(var_3, var_8);
  }

  var_11 = var_0 scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");

  if(isDefined(var_11))
    var_0 scripts\mp\equipment::incrementequipmentammo(var_11);

  var_12 = var_0 scripts\mp\equipment::getcurrentequipment("_encstr_AC8F0AE74163F85AAA380AD8");

  if(isDefined(var_12))
    var_0 scripts\mp\equipment::incrementequipmentammo(var_12);

  var_0.health = var_0.maxhealth;
  var_0 playsoundtoplayer("_encstr_A3C80F4AF0E9DFB1709519F44369C36705", var_0);
}

scriptableinit() {
  foreach(var_1 in level.players)
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_1, "_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28", 1, undefined, 0);
}

_encstr_83D01CD9963B951636B107B1582FAC39B92756C82B0ED8DE5E3ADE5B59E6() {
  foreach(var_1 in level.players)
  var_1 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
}