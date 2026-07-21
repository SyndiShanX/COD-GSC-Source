/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58268.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_B8BA05F06B9785", _calloutmarkerping_handleluinotify_acknowledged::tryusenukefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637", _calloutmarkerping_handleluinotify_acknowledged::tryusenukefromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_BAEB28C3973773DB5C7A80106374E7882F17DFCBE493581507B0A0B02A4BA360139F533D400B417B6A8A", ::_id_11EEA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_B2DB28CA47AFCB8FB3FF7B8669C2D0D039F08820C48B79D025BC3722FB8C5B64AB80C19405A53DB0CD10", ::_id_11EEB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_A7D50D32ACC60B5E8A9BC8A358B659", ::nuke_delayendgame);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_969018B09191A29558AD945837DA61A0A95DC6E8B4388DD2B24E", ::_id_11EDD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_889F081BC2CDADB48D8D", ::nuke_cankill);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_88AF0BB8478C507912967B0D2A", ::_id_11EEC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_AC9517EFE275C887082F7FA7B2E4886CD331031B9F0F42374B", ::_id_11EED);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_BA031591CA9B1DC9B75E82B1A3963B56F426A62BD81DE6", ::nuke_destroyactiveobjects);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_877512A5E6A08D2CF22BC952B929583296DB37CA", ::nuke_isplayerinradzone);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8BA05F06B9785", "_encstr_97040DC7E1B00354B8593EFD30C8A3", ::_id_11EF7);
}

_id_11EEA(var_0) {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

_id_11EEB() {
  return scripts\mp\hostmigration::waittillhostmigrationdone();
}

nuke_delayendgame(var_0, var_1) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(istrue(level._id_11BD4))
    level thread scripts\mp\gamelogic::endgame(var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_9BE90A8A70BD8EB7A6FC2956"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B4720B5BE5E260CB0FAA883363"], 1, 1);
  else
    level thread scripts\mp\gamelogic::endgame(var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_BD13094D481CF9A9AFE881"], undefined, 1);
}

_id_11EDD(var_0, var_1, var_2) {
  scripts\mp\rank::addteamrankxpmultiplier(var_0, var_1, var_2);
}

nuke_cankill(var_0, var_1) {
  if(istrue(level.blocknukekills))
    return 0;

  if(!isDefined(level.nukeinfo))
    return 0;

  if(istrue(var_1))
    return 1;

  if(level.teambased) {
    if(isDefined(level.nukeinfo.team) && var_0.team == level.nukeinfo.team)
      return 0;
  } else {
    var_2 = isDefined(level.nukeinfo.player) && var_0 == level.nukeinfo.player;
    var_3 = isDefined(level.nukeinfo.player) && isDefined(var_0.owner) && var_0.owner == level.nukeinfo.player;

    if(var_2 || var_3)
      return 0;
  }

  return 1;
}

nuke_destroyactiveobjects(var_0) {
  var_1 = "_encstr_A29408E6D5D6CAAF5B1C";
  var_2 = level.activekillstreaks;
  var_3 = [[level.getactiveequipmentarray]]();
  var_4 = undefined;

  if(isDefined(var_2) && isDefined(var_3))
    var_4 = scripts\engine\utility::array_combine_unique(var_2, var_3);
  else if(isDefined(var_2))
    var_4 = var_2;
  else if(isDefined(var_3))
    var_4 = var_3;

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9F8150DE578FB9851B708B9AF43D029220AFD8EFF8257"))
          var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9F8150DE578FB9851B708B9AF43D029220AFD8EFF8257")]](10000, level.nukeinfo.player, level.nukeinfo.player, var_0, var_6.origin, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_1);
      }
    }
  }
}

nuke_isplayerinradzone(var_0, var_1, var_2) {
  var_3 = distance2dsquared(var_1, var_0.origin);
  return var_3 < var_2;
}

_id_11EEC(var_0) {
  if(isPlayer(var_0)) {
    var_1 = getcompleteweaponname("_encstr_A29408E6D5D6CAAF5B1C");
    scripts\mp\damage::addattacker(var_0, level.nukeinfo.player, undefined, var_1, 0, undefined, undefined, undefined, undefined, undefined);
    var_2 = vectorNormalize(var_0.origin + (0, 0, 1000) - level.nuke_inflictor.origin);
    var_0 thread scripts\mp\damage::finishplayerdamagewrapper(level.nuke_inflictor, level.nukeinfo.player, 999999, 0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_1, var_0.origin, var_2, "_encstr_8BBA05185F8B99", 0, 0, undefined, undefined);
  }
}

_id_11EED(var_0) {
  var_1 = level.nukeinfo.player;

  if(level.teambased && var_0.team == var_1.team)
    var_1 = var_0;

  var_2 = getcompleteweaponname("_encstr_A29408E6D5D6CAAF5B1C");
  var_0 dodamage(999999, level.nuke_inflictor.origin, var_1, level.nuke_inflictor, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_2, "_encstr_8BBA05185F8B99");
}

_id_11EF7(var_0) {
  var_1 = "_encstr_AF1805EFE726E9" + var_0 + "_encstr_8E6F0BE85BD29B9154974068CB";
  level.watchdvars[var_1].value = 0;
  level.overridewatchdvars[var_1] = 0;
  level.extratime = 0;
  return var_1;
}