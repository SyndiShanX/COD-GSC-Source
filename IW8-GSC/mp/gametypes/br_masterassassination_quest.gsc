/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_masterassassination_quest.gsc
*********************************************************/

init() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", 1);

  if(!var_0) {
    return;
  }
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B38("_encstr_933E18BA608F7BF713E7233B8F5BE744CD08B372A81D791F0859");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B38("_encstr_82F11E223FDF0B7363660B734033FAD34A487383D8DB292395356FC07A780281");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716")._id_1296B = getdvarint("_encstr_9716196EB193D7899CEB531445AF2ED5ACE68E155ADA2B090B6EAC", 180);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716")._id_1296C = getdvarint("_encstr_96041ADCD839EB2639F5A9508AEB2EBA56B91D2AD2B59509ED9BD537", 60);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716")._id_12C82 = getdvarint("_encstr_A6271CB9B1E4BE13C9EBA628A2AFE456B9CAA3A2A5D6569CF4E6692DC6B1", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestthink("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", ::_id_11AF5, 10);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestthink("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", ::_id_11AF6, 0.2);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", ::_id_11AF7);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registeronplayerkilled("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", ::_id_11AF2);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2E("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", ::_id_11AF3);
  var_1 = level.questinfo.defaultfilter;
  var_1 = scripts\engine\utility::array_add(var_1, _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::filtercondition_hasbeentracked);
  var_1 = scripts\engine\utility::array_add(var_1, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::filtercondition_isdowned);

  if(getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0))
    var_1 = scripts\engine\utility::array_add(var_1, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_landlord_infil_vo);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerplayerfilter("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", var_1, 0);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B32("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", ::_id_11AF1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", ::_id_11AF0);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").alltrackedplayers = [];
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").inner = [];
  _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::brexfilanimname();
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8EA51308326F26D04DFE37430BB299E7C70A81134B"] = "_encstr_847E2225CB67B3E160E0E717E0DBB35A07D0215EAECFC92348080F1BE8369922F7FD7293";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5A013D6B4CD375ADE73AF589BDCD70DAB7347AC19"] = "_encstr_856B1B0A903F0A7720F09FD51BCB57D45F739142D8D7C9AB5BE8BCD5A5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82E314D21342B843E79D9FB7D21A717740EE599DF298"] = "_encstr_9A5A23E5708FF8EA624079F17B832FDAB8E55F4F5358AFD2622BDCD9B7C9D3BB0AF11D5E73";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A18B1BDA969BDC5ABDCD7D2CB99BAF345DDC8ECA19EBE6AB3636569B9B"] = "_encstr_9ABD23887C5BB09BC283FF93F76BDE38EF15768162A319C35B9BD19BFB712610BB2EB95B8A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82F1D09E48B5F98DF1359905FFB96A133CD7D853FE1E9C0B5578869C715CB"] = "_encstr_A12425906A22E728B77EB8A941FF539B8D828988A37A07C0379635952427FB43F59AC8F1DA1399";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88A0116BD26ECDB4EDCDAF0BB9CDF5992CA5C6"] = "_encstr_A5CA19F338D8472192E3AE5947F3A6412FB8276FBFBB288996BB89";
}

_id_11AF5() {
  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
    return;
  }
  if(!isDefined(self.targetplayer)) {
    return;
  }
  _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::determinetrackingcircleposition(self.targetplayer);
  _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::lbravo_spawner_jammer3b();
  _id_13FF8(self.targetteam);
}

_id_11AF6() {
  _id_11AED();
}

_id_11AF7() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").inner = scripts\engine\utility::array_remove(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").inner, var_1);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.hunterteam);
  _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::removeallaqui();
}

takequestitem(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::searchfunc(self.team, "_encstr_8864196AD8F71DE7538E594728FECBA437B883C34949D6F3E8FD4C");
  var_1 = self.team;
  var_2 = determinetargetteam(self);
  var_3 = search(var_1, var_2, var_0.index, self, "_encstr_B40101", var_0);

  if(!isDefined(var_3)) {
    scripts\mp\utility\lower_message::_id_1316E("_encstr_A77C1BAA1837DE4F13C7031BEB98CF23E358F2F1803FD33FEB3C1D14FE", undefined, 5);
    return;
  }

  var_3 search_target_think(self);
}

search_target_think(var_0) {
  var_1 = spawnStruct();
  var_1.excludedplayers = [];
  var_1.excludedplayers[0] = self.targetplayer;

  if(isDefined(var_0))
    var_1.excludedplayers[1] = var_0;

  var_1.stringvar = self.targetplayer.name;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.targetteam, "_encstr_B6C82FC44EBEB685E6472B27C26ECD85DC9BB4DC58472DB7E6FA17BA569B47FAE61D859CD17D3AB0E43BAC8EF547CAB0B6", var_1, self._id_13A8C);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self.targetplayer, "_encstr_AFC8314A23C0C72EE069EDE25B38723F7EBB7212292D8FE520D7F1ED7B50FB7FA6B34A5B1310335EB89F1DD4777005CFCB09F3");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(istrue(level.questinfo._id_132E8)) {
      var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C);

      foreach(var_4 in var_2)
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A5A013D6B4CD375ADE73AF589BDCD70DAB7347AC19", var_4, 1);
    } else
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_A5A013D6B4CD375ADE73AF589BDCD70DAB7347AC19", self.targetteam, 1);
  }

  var_1._id_127D5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardorigin(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.hunterteam));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.hunterteam, "_encstr_AD072F7A386910E927137033B9BB76C938D6193757239CC82DDED35398DEFD31D36426E3D349085B88084F15F81D55AFCF", var_1);

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(istrue(level.questinfo._id_132E8)) {
      var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8EA51308326F26D04DFE37430BB299E7C70A81134B", 1, var_2, 0);
    } else
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_8EA51308326F26D04DFE37430BB299E7C70A81134B", self.hunterteam, 1);
  }

  if(isDefined(var_0)) {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, "_encstr_A6963139530FD960BA1493B529E2A897D73BD020CA1B03D8152783A355CA58700FE3A92B035FC5D02EFCA3A9477788A0FB6A43", var_1);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(self.hunterteam, var_0, 6, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716"));
  }
}

search(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;

  if(istrue(level.questinfo._id_132E8))
    var_7 = var_3.team + var_3.squadindex;

  var_8 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createquestinstance("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", var_7, var_2, var_5, var_3.squadindex);
  var_8.modifier = var_4;

  if(!isDefined(var_8.modifier))
    var_8.modifier = "_encstr_B40101";

  var_8 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerteamonquest(var_0, var_3);
  var_8.team = var_0;
  var_8.hunterteam = var_0;
  var_8.targetteam = var_1;
  var_8._id_13A87 = 0;
  var_8.spawned_warp_traversethink = 0;
  var_8._id_13A8E = 0;

  if(isDefined(var_1))
    var_8._id_13A8E = var_8 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinteam(var_1).size;

  if(!isDefined(var_8.targetteam)) {
    generatenumbercode(var_8);
    return undefined;
  }

  var_8 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(4, 16);

  if(isDefined(var_6))
    var_8.targetplayer = var_6;
  else
    var_8 getnewtargetplayer(var_3);

  if(!isDefined(var_8.targetplayer)) {
    generatenumbercode(var_8);
    return undefined;
  }

  if(var_8.modifier != "_encstr_8A430599F76844")
    var_8 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716")._id_1296B, 4);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").alltrackedplayers = scripts\engine\utility::array_combine(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").alltrackedplayers, _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, var_8._id_13A8C));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").inner = scripts\engine\utility::array_combine(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").inner, _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, var_8._id_13A8C));

  if(var_8.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
    if(istrue(level.questinfo._id_132E8))
      level.squaddata[var_0][var_8.squadindex].should_save_debug_info = 0;
    else
      level.teamdata[var_0]["_encstr_BEC80AE0B683C1476AB3C3D9"] = 0;
  }

  var_8 _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::determinetrackingcircleposition(var_8.targetplayer);
  var_8 _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::lbravo_spawner_jammer3b();
  var_8 _id_13FF8(var_8.targetteam);
  var_8 _id_11AED();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", var_8);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", var_3, var_0);
  return var_8;
}

generatenumbercode(var_0) {
  if(isDefined(var_0.mapcircle))
    var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();

  var_0.result = "_encstr_A6270A37B7BED87B8D2C36AC";
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(var_0.hunterteam);
}

determinetargetteam(var_0) {
  var_1 = var_0.team;
  var_2 = undefined;
  var_3 = level.players;
  var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").alltrackedplayers;
  var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, self.squadindex);
  var_6 = scripts\engine\utility::array_combine_unique(var_4, var_5);

  if(istrue(level.questinfo._id_132E8))
    var_6 = scripts\engine\utility::array_combine_unique(var_6, scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B"));

  if(var_3.size == var_6.size && getdvarint("_encstr_86D01E80E9B3B943485BB9F2C3EBB5E72963D26BF55FF3559FC1238780A2E663", 1)) {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").alltrackedplayers = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").inner;
    var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716").alltrackedplayers;
    var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, self.squadindex);
    var_6 = scripts\engine\utility::array_combine_unique(var_4, var_5);

    if(istrue(level.questinfo._id_132E8))
      var_6 = scripts\engine\utility::array_combine_unique(var_6, scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B"));
  }

  var_7 = 0;
  var_8 = level.questinfo.quests["_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716"].filters[0];
  var_9 = 5000;
  var_10 = 30000;

  if(_encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::playlandingbreath()) {
    var_9 = level._id_12962;
    var_10 = level._id_12961;
  }

  while(!isDefined(var_2)) {
    var_7 = var_7 + 5000;
    var_11 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, var_6, undefined, var_9 + var_7, var_9);
    var_11 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(var_11, var_8);

    if(!isDefined(var_11) || var_11.size == 0) {
      if(var_7 > var_10) {
        var_11 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, var_6, undefined, undefined, undefined);
        var_11 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(var_11, var_8);

        if(!isDefined(var_11) || var_11.size == 0)
          return undefined;
      } else
        continue;
    }

    var_12 = [];

    foreach(var_14 in var_11)
    var_12[var_14.team] = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinteam(var_14.team, var_8).size;

    var_16 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getteamcenter(var_1, var_8);
    var_17 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinteam(var_1, var_8).size;
    var_2 = undefined;
    var_18 = -1;
    var_19 = -1;
    var_20 = -1;
    var_21 = -1;
    var_22 = -1;
    var_23 = undefined;

    foreach(var_30, var_25 in var_12) {
      if(!isDefined(var_2)) {
        var_2 = var_30;
        var_18 = rpg_guys_construction_spawners(var_30);
        var_19 = rpg_guys(var_30);
        var_20 = rpg_shoot_at_trig_watch(var_30);
        var_21 = rpg_max_range(var_30);
      }

      var_26 = rpg_guys_construction_spawners(var_30);
      var_27 = rpg_guys(var_30);
      var_28 = rpg_shoot_at_trig_watch(var_30);
      var_29 = rpg_max_range(var_30);

      if(var_26 < var_18)
        continue;
      else if(var_26 > var_18) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        continue;
      }

      if(var_27 < var_19)
        continue;
      else if(var_27 > var_19) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        continue;
      }

      if(var_28 < var_20)
        continue;
      else if(var_28 > var_20) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        continue;
      }

      if(var_29 > var_21)
        continue;
      else if(var_29 > var_21) {
        var_2 = var_30;
        var_18 = var_26;
        var_19 = var_27;
        var_20 = var_28;
        var_21 = var_29;
        continue;
      } else {
        if(!isDefined(var_23))
          var_23 = randomintrange(1, 2);

        if(var_23 == 1) {
          var_2 = var_30;
          var_18 = var_26;
          var_19 = var_27;
          var_20 = var_28;
          var_21 = var_29;
          var_23 = undefined;
          continue;
        }

        var_23 = undefined;
        continue;
      }
    }

    return var_2;
  }
}

getnewtargetplayer(var_0) {
  determinetargetplayer(self.targetteam, var_0);
  _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::determinetrackingcircleposition(self.targetplayer);
  _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::lbravo_spawner_jammer3b();
  _id_13FF7();
}

determinetargetplayer(var_0, var_1) {
  var_2 = -1;
  var_3 = -1;
  var_4 = -1;
  var_5 = -1;
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    var_10 = var_9;

    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isplayervalid(var_10, _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::relic_steelballs_dodamage(self.modifier))) {
      continue;
    }
    if(!isDefined(var_6)) {
      var_6 = var_10;
      var_2 = var_10.plundercount;
      var_3 = var_10.score;
      var_4 = var_10.extrascore3;
      var_5 = var_10.kills;
    }

    if(var_10.kills > var_5) {
      var_6 = var_10;
      continue;
    }

    if(var_10.extrascore3 > var_4) {
      var_6 = var_10;
      continue;
    }

    if(var_10.score > var_3) {
      var_6 = var_10;
      continue;
    }

    if(var_10.plundercount > var_2) {
      var_6 = var_10;
      continue;
    }

    if(!isDefined(var_7))
      var_7 = randomintrange(1, 2);

    if(var_7 == 1) {
      var_6 = var_10;
      var_7 = undefined;
      continue;
    }

    var_7 = undefined;
    continue;
  }

  var_6.hasbeentracked = 0;
  self.targetplayer = var_6;
  self._id_13A8C = var_6.squadindex;
}

_id_11AED() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    var_2 = var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag();
    var_3 = isDefined(var_1._id_11AEF) && var_1._id_11AEF;

    if(var_2 && var_3)
      var_1 spawn_custom_type(self);

    if(!var_2 && !var_3)
      var_1 _id_13360(self);
  }

  var_5 = self.squadindex;

  if(isDefined(self.targetplayer.squadindex))
    var_5 = self.targetplayer.squadindex;

  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, var_5)) {
    var_2 = var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag();
    var_3 = isDefined(var_1._id_11AF8) && var_1._id_11AF8;

    if(var_2 && var_3)
      var_1 spawn_custom_type_array();

    if(!var_2 && !var_3)
      var_1 _id_13361(self.targetplayer, self._id_13B39);
  }
}

_id_11AF1() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  var_1 setclientomnvar("_encstr_856221C31CF97E7239D3D393B11786509B2B792F62D5468BB6C3279FFD6F83BF40573B", self._id_11C51);

  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0")
    thread _id_11B1C();
}

_id_11AF0() {
  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
    if(istrue(level.questinfo._id_132E8))
      level.squaddata[self.targetteam][self._id_13A8C].should_save_debug_info = 1;
    else
      scripts\mp\utility\teams::setteamdata(self.targetteam, "_encstr_BEC80AE0B683C1476AB3C3D9", 1);

    _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::brgetloadoutoptionstandardloadoutindex(self.hunterteam);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
  } else {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.hunterteam, "_encstr_BDBA3126277DD6C237D1AC9C2C6EB90B9B6EA5B958A3D27BDCEB3A2DD6AC9CF559F01CD2272BAF865DDCA32BC9E6BED8DB6ECA");
    var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.targetteam);
    var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardmodifier("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", var_0);
    self._id_12D2D = "_encstr_A299094E408C5D6BBB8142";
    var_2 = spawnStruct();
    var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716");
    var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", self._id_12D2D, self.modifier));
    var_2._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_3, var_0, var_4);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.targetteam, "_encstr_9AC5301327BEB50BE64795932C379B16CD9B969B168E96F637BED1A5B65639EB563CE04B4ECAEBE885C9D9B247E6FADD2D9B", var_2, self._id_13A8C);

    if(istrue(level.questinfo._id_132E8)) {
      var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_88A0116BD26ECDB4EDCDAF0BB9CDF5992CA5C6", 1, var_5, 0);
      var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C);
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B82F1D09E48B5F98DF1359905FFB96A133CD7D853FE1E9C0B5578869C715CB", 1, var_5, 0);
    } else {
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_88A0116BD26ECDB4EDCDAF0BB9CDF5992CA5C6", self.hunterteam, 1);
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_B82F1D09E48B5F98DF1359905FFB96A133CD7D853FE1E9C0B5578869C715CB", self.targetteam, 1);
    }

    if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_BE180419DAE9" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_9B1F05BE4B9B52" && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_866209ECEDB1197DEE0B4E") {
      var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C);
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::search_speed(self.targetteam, self.targetplayer.origin, self.targetplayer.angles, self._id_12D30, var_6, self._id_13A8C);
    }
  }
}

_id_11AF2(var_0, var_1) {
  if(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
    return;
  }
  thread _id_11AF4(var_1, var_0);
}

_id_11AF3(var_0) {
  thread _id_11AF4(var_0);
}

_id_11AF4(var_0, var_1) {
  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0" && (istrue(level.questinfo._id_132E8) && istrue(level.squaddata[self.hunterteam][self.squadindex].should_save_debug_info) || scripts\mp\utility\teams::getteamdata(self.hunterteam, "_encstr_BEC80AE0B683C1476AB3C3D9"))) {
    return;
  }
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(!isbot(var_0))
      return;
  }

  if(var_0.team == self.targetteam) {
    if(var_0 == self.targetplayer) {
      var_2 = var_0.attackers;
      wait 0.75;
      var_3 = spawnStruct();
      var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.hunterteam);
      var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716");

      if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == self.hunterteam) {
        var_6 = "_encstr_8DD52CA225399D4F765B8AC3C14ECF5680CF51269BC8242F9056E21AA8278B0FD05BEFB81B602BCF46CB39833070";
        self._id_12D2D = "_encstr_B8760F58EBE215018D3321886FAC3863DA";
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(self.hunterteam, var_1, 8, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716"));

        foreach(var_8 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex))
        var_8 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_B84E3FBBDA508F1CF1DF744FED382537E688A28318156B9719176A7785202B2B95E2193AC078A30AB0277C43E7B07513A8D863C28B47FB8593776D519730BC9F68", 1);
      } else {
        var_6 = "_encstr_92B1302EAE9985094E04671DE86FB89243E8FC7E412C3A7F2569F7C04D539887103398F377EDB7BF9BA05B92EAA00BC4A3E5";
        self._id_12D2D = "_encstr_873711F1AB28526AA5F977DB3BD872AB8811B7";
      }

      var_10 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716", self._id_12D2D, self.modifier));
      var_11 = _encstr_96292CAF888B0430F313B7ADBBE6A98203C79BE8A065087EB2CE1F3145C08EA2D74BCD198818A58A035B351780C8::clear_all_remaining(var_1);
      var_3._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_5, var_4, var_10, undefined, var_11);
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.hunterteam, var_6, var_3);
      level notify("_encstr_965B1EC237B90BE6DC5A37B0D1A5F6B9AF8B5D95E6A3D7D87BB6C11BCA1D2B23", self.hunterteam, self.squadindex);

      if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
        if(istrue(level.questinfo._id_132E8)) {
          var_12 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
          level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_82E314D21342B843E79D9FB7D21A717740EE599DF298", 1, var_12, 0);
        } else
          level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_82E314D21342B843E79D9FB7D21A717740EE599DF298", self.hunterteam, 1);
      }

      self._id_12D2E = var_0.origin;
      self._id_12D2B = var_0.angles;

      if(isDefined(var_2)) {
        foreach(var_14 in var_2) {
          if(isDefined(var_14.team) && var_14.team == self.hunterteam)
            _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B15(var_14);
        }
      }

      self.result = "_encstr_88E30897BDF1B71F7823";
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
    }

    if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
      if(!isDefined(level.gulag) || isDefined(level.gulag) && !istrue(level.gulag.shutdown)) {
        foreach(var_8 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
          if(istrue(var_8.inlaststand))
            var_8 scripts\mp\laststand::playanim_aibegindismountturret("_encstr_883618B33B68CEF047138817CD6A1B84A012F78FBBEA3BFFBB9F", var_8);

          if(!isalive(var_8)) {
            var_8 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
            var_8 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergulagautowin("_encstr_BE8413E17A28B726F7A8603FC301E0E86BC0793F4B");
          }
        }
      }
    }
  } else if(var_0.team == self.hunterteam) {
    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isteamvalid(self.hunterteam, _encstr_AFDA30371B274B1CE8CDF2B583E5B30BB5ACA3978356DCE54CE4AFB0B96E0BDC6EB4B92CD1A5DBCD7D5CAECADC8E5C9D376C::relic_steelballs_dodamage(self.modifier))) {
      if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
        self.result = "_encstr_BD79059C51C351";
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
      } else {
        self._id_12D2D = "_encstr_A299094E408C5D6BBB8142";
        var_18 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C);
        var_19 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::search_speed(self.targetteam, var_0.origin, var_0.angles, self._id_12D30, var_18, self._id_13A8C);
        var_3 = spawnStruct();
        var_3._id_127D5 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_19["_encstr_83A20883C6EA378C2B93"]);
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.targetteam, "_encstr_85D82CA2CB283FD60871C5DA73201A5766836AEA3115E78D183FFBDF1360E58F0DF981D399EE6747E08FCFCF3378", var_3, self._id_13A8C);
        self.result = "_encstr_BD79059C51C351";
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
      }
    }
  }
}

rpg_guys_construction_spawners(var_0) {
  var_1 = 0;

  foreach(var_3 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
  var_1 = var_1 + var_3.kills;

  return var_1;
}

rpg_shoot_at_trig_watch(var_0) {
  var_1 = 0;

  foreach(var_3 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
  var_1 = var_1 + var_3.score;

  return var_1;
}

rpg_guys(var_0) {
  var_1 = 0;

  foreach(var_3 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
  var_1 = var_1 + var_3.extrascore3;

  return var_1;
}

rpg_max_range(var_0) {
  var_1 = 0;

  foreach(var_3 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
  var_1 = var_1 + var_3.plundercount;

  return var_1;
}

_id_11AEE(var_0) {
  switch (var_0) {
    case "_encstr_BAA40B7FAF90ABC1F940D2AAD0":
    case "_encstr_8A430599F76844":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

_id_13360(var_0) {
  self._id_11AEF = 1;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_868B1448A75393D33356BE46AEDB07F8A63F08D03716" + var_0.modifier);
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(self);
}

spawn_custom_type(var_0) {
  self._id_11AEF = 0;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(self);
}

_id_13FF6(var_0, var_1) {
  if(isDefined(self._id_11AF8) && self._id_11AF8)
    var_2 = var_0 getentitynumber();
  else
    var_2 = -1;

  var_2 = var_0 getentitynumber();
  var_2 = var_2 + 1;
  var_3 = var_1 << 8 | var_2;
  self setclientomnvar("_encstr_B8ED1B4FD076C283171F6A627737EB813808C3874888072B43AE779FE5", var_3);
}

_id_13FF8(var_0) {
  foreach(var_2 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  var_2 _id_13FF6(self.targetplayer, self._id_13B39);
}

_id_13361(var_0, var_1) {
  self._id_11AF8 = 1;
  _id_13FF6(var_0, var_1);
}

spawn_custom_type_array() {
  self._id_11AF8 = 0;
  self setclientomnvar("_encstr_B8ED1B4FD076C283171F6A627737EB813808C3874888072B43AE779FE5", 0);
}

_id_13FF7() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    var_1 _id_13360(self);
    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  var_1 _id_13361(self.targetplayer, self._id_13B39);
}

_id_11B1C() {
  self notify("_encstr_8F631FD0AA62296903916E66893F93DB8D329008A2FDD1A017DD645772A3188DB7");
  self endon("_encstr_8F631FD0AA62296903916E66893F93DB8D329008A2FDD1A017DD645772A3188DB7");
  self endon("_encstr_A2BD0839CAB6B7CE5919");
  var_0 = [300, 240, 180, 120, 90, 60, 30, 10];

  foreach(var_2 in var_0) {
    var_3 = (self._id_11C51 - gettime()) / 1000;
    var_4 = var_3 - var_2;

    if(var_4 < 0) {
      continue;
    }
    wait(var_4);
    var_5 = int(var_2 / 60);
    var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex), _id_11AEE(self.modifier));

    foreach(var_8 in var_6) {
      var_9 = gettime() + var_2 * 1000;
      var_10 = 5;

      if(var_2 <= 20)
        var_10 = var_2;

      var_8 scripts\mp\utility\lower_message::_id_1316E("_encstr_97CF2182301FC657FB3FFBF3C3A01F0D9BA01B8A702531039011F527E469E39523A0C2", var_9, var_10);

      if(var_5 >= 2) {
        var_8 iprintlnbold(&"_encstr_AFB331D482EB48A4BE9272A30A35155EA6946AD4A4D3277D824D35A06A9AA439F58CF545925354FAAB0A299394273AEBA6529C", var_5);
        continue;
      }

      var_8 iprintlnbold(&"_encstr_A9B331D4A07D2192EBA47274509A15CBD4A4359A94D3C9F505A6358235A6A427D719AF1525532A7D5D5029279472D1F53551A1", var_2);
    }
  }
}