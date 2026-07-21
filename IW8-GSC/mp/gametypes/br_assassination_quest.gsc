/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_assassination_quest.gsc
***************************************************/

init() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", 1);

  if(!var_0) {
    return;
  }
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B38("_encstr_952212DF03BF599FA212F898DBFC6F70B7B9D1C1");
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B38("_encstr_B11E184EAEFF0A534B608BBFE0603782CFCF9585AF2942855130");
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_8B0517D9CEEF80CF3B2AAD1FB0608AC5C04BA7491F2A63B5AB", 1);

  if(var_0)
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2A("_encstr_8B0517D9CEEF80CF3B2AAD1FB0608AC5C04BA7491F2A63B5AB", "_encstr_BE7925B6634847D225A7DB9FC947DA94F84961FEFB18116BFEE3A387017B42F681D3668670F0CC");

  level.br_leaderbystreak = getdvarint("_encstr_A9C5189BC6C9EB9827BEC6955819ACE4BE89E5FACDD12795B0B5", 0) != 0;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0")._id_1296B = getdvarint("_encstr_84B818E61BE4BE31C9D705A2BEB8AE2BB9D15196DAB2090B6E95", 180);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0")._id_1296C = getdvarint("_encstr_A36A19AB669BAF562D39A8A15143CB1F13553439898113DD2D70F3", 60);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0")._id_12C82 = getdvarint("_encstr_9A191B9B6C39D7C427AF50A8BEC9599B2BE88AB4DAAC4E7A3769A563D8", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestthink("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", ::aq_questthink_circleposition, 5);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestthink("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", ::aq_questthink_objectivevisibility, 0.2);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", ::aq_removequestinstance);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registeronplayerkilled("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", ::aq_playerdied);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2E("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", ::calculateweaponmatchbonus);
  var_1 = level.questinfo.defaultfilter;
  var_1 = scripts\engine\utility::array_add(var_1, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::filtercondition_isdowned);
  var_2 = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD");

  if(var_2 != "_encstr_A254085207A6B7334B5A" && var_2 != "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" && var_2 != "_encstr_816E079685517D0975" && var_2 != "_encstr_AD300C932B4C969CD1D0AF911346" && var_2 != "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95")
    var_1 = scripts\engine\utility::array_add(var_1, ::filtercondition_hasbeentracked);

  if(getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0))
    var_1 = scripts\engine\utility::array_add(var_1, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_landlord_infil_vo);

  if(getdvarint("_encstr_A614141F9B6A09DE2311F1588BBF01D087F53FBF1852", 0))
    var_1 = scripts\engine\utility::array_add(var_1, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_intro_hacking_vo);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerplayerfilter("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", var_1, 0);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B32("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", ::calculatespawndisttodefenderflagstart);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", ::calculatepurchasexp);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").alltrackedplayers = [];
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").inner = [];
  brexfilanimname();
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8EA51308326F26D04DFE37430BB299E7C70A81134B"] = "_encstr_847E2225CB67B3E160E0E717E0DBB35A07D0215EAECFC92348080F1BE8369922F7FD7293";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5A013D6B4CD375ADE73AF589BDCD70DAB7347AC19"] = "_encstr_856B1B0A903F0A7720F09FD51BCB57D45F739142D8D7C9AB5BE8BCD5A5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_82E314D21342B843E79D9FB7D21A717740EE599DF298"] = "_encstr_9A5A23E5708FF8EA624079F17B832FDAB8E55F4F5358AFD2622BDCD9B7C9D3BB0AF11D5E73";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A18B1BDA969BDC5ABDCD7D2CB99BAF345DDC8ECA19EBE6AB3636569B9B"] = "_encstr_9ABD23887C5BB09BC283FF93F76BDE38EF15768162A319C35B9BD19BFB712610BB2EB95B8A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82F1D09E48B5F98DF1359905FFB96A133CD7D853FE1E9C0B5578869C715CB"] = "_encstr_A12425906A22E728B77EB8A941FF539B8D828988A37A07C0379635952427FB43F59AC8F1DA1399";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88A0116BD26ECDB4EDCDAF0BB9CDF5992CA5C6"] = "_encstr_A5CA19F338D8472192E3AE5947F3A6412FB8276FBFBB288996BB89";
}

filtercondition_hasbeentracked(var_0) {
  if(isDefined(var_0.hasbeentracked) && var_0.hasbeentracked)
    return 0;

  return 1;
}

aq_questthink_circleposition() {
  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
    return;
  }
  if(!isDefined(self.targetplayer)) {
    return;
  }
  determinetrackingcircleposition(self.targetplayer);
  lbravo_spawner_jammer3b();
  _id_13FC3(self.targetteam);
}

aq_questthink_objectivevisibility() {
  determineobjectivevisibility();
}

aq_removequestinstance() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").inner = scripts\engine\utility::array_remove(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").inner, var_1);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.hunterteam);
  removeallaqui();
}

takequestitem(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::searchfunc(self.team, "_encstr_8864196AD8F71DE7538E594728FECBA437B883C34949D6F3E8FD4C");
  var_1 = self.team;
  var_2 = determinetargetteam(self);
  var_3 = "_encstr_B40101";

  if(var_0.type == "_encstr_BE7925B6634847D225A7DB9FC947DA94F84961FEFB18116BFEE3A387017B42F681D3668670F0CC")
    var_3 = "_encstr_87D20AFAE4564616D81DAC23";

  var_4 = search(var_1, var_2, var_0.index, self, var_3, var_0);

  if(!isDefined(var_4)) {
    scripts\mp\utility\lower_message::_id_1316E("_encstr_A77C1BAA1837DE4F13C7031BEB98CF23E358F2F1803FD33FEB3C1D14FE", undefined, 5);
    return;
  }

  var_4 search_target_think(self);
}

search_target_think(var_0) {
  var_1 = spawnStruct();
  var_1.excludedplayers = [];
  var_1.excludedplayers[0] = self.targetplayer;

  if(isDefined(var_0))
    var_1.excludedplayers[1] = var_0;

  var_1.stringvar = self.targetplayer.name;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.targetteam, "_encstr_93F029763A3761B78A4AF8F0E2E54B1B07DF88609127A9FF33B1C0D09A3A29362B790EE41D4B56095F3A38", var_1, self._id_13A8C);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self.targetplayer, "_encstr_8D392BBE12794BEBF3FFE8F0C73661A9A2FD20A8AAB31BD3DCEFE0C0CF429B479BE6A6CC077BA7FBBC2F4870FB");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(istrue(level.questinfo._id_132E8)) {
      var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C);

      foreach(var_4 in var_2)
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A5A013D6B4CD375ADE73AF589BDCD70DAB7347AC19", var_4, 1);
    } else
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_A5A013D6B4CD375ADE73AF589BDCD70DAB7347AC19", self.targetteam, 1);
  }

  var_1._id_127D5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardorigin(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.hunterteam));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.hunterteam, "_encstr_AC0E297B0A7F295B0707C0CB38B8315DFC5825B708732FDECC7FA765C2F8EB0940185B2355062903538F30", var_1);

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(istrue(level.questinfo._id_132E8)) {
      var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex);
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8EA51308326F26D04DFE37430BB299E7C70A81134B", 1, var_2, 0);
    } else
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_8EA51308326F26D04DFE37430BB299E7C70A81134B", self.hunterteam, 1);
  }

  if(isDefined(var_0)) {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, "_encstr_ACA42BD95B1FB99E5BEF5B2F13A54385E3FFB0B12BCD771BF32927053743B371790BC6383704674468D873D902", var_1);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(self.hunterteam, var_0, 6, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0"));
  }
}

search(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;

  if(istrue(level.questinfo._id_132E8))
    var_7 = var_3.team + var_3.squadindex;

  var_8 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createquestinstance("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", var_7, var_2, var_5, var_3.squadindex);
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

  var_8 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(4, 3);

  if(isDefined(var_6))
    var_8.targetplayer = var_6;
  else
    var_8 getnewtargetplayer(var_3);

  if(!isDefined(var_8.targetplayer)) {
    generatenumbercode(var_8);
    return undefined;
  }

  if(var_8.modifier != "_encstr_8A430599F76844")
    var_8 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0")._id_1296B, 4);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").alltrackedplayers = scripts\engine\utility::array_combine(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").alltrackedplayers, _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, var_8._id_13A8C));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").inner = scripts\engine\utility::array_combine(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").inner, _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, var_8._id_13A8C));

  if(var_8.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
    if(istrue(level.questinfo._id_132E8))
      level.squaddata[var_0][var_8.squadindex].should_save_debug_info = 0;
    else
      level.teamdata[var_0]["_encstr_BEC80AE0B683C1476AB3C3D9"] = 0;
  }

  var_8 determinetrackingcircleposition(var_8.targetplayer);
  var_8 lbravo_spawner_jammer3b();
  var_8 _id_13FC3(var_8.targetteam);
  var_8 determineobjectivevisibility();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", var_8);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", var_3, var_0);
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
  var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").alltrackedplayers;
  var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, self.squadindex);
  var_6 = scripts\engine\utility::array_combine_unique(var_4, var_5);

  if(istrue(level.questinfo._id_132E8))
    var_6 = scripts\engine\utility::array_combine_unique(var_6, scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B"));

  if(var_3.size == var_6.size && getdvarint("_encstr_86D01E80E9B3B943485BB9F2C3EBB5E72963D26BF55FF3559FC1238780A2E663", 1)) {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").alltrackedplayers = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").inner;
    var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").alltrackedplayers;
    var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1, self.squadindex);
    var_6 = scripts\engine\utility::array_combine_unique(var_4, var_5);

    if(istrue(level.questinfo._id_132E8))
      var_6 = scripts\engine\utility::array_combine_unique(var_6, scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B"));
  }

  var_7 = 0;
  var_8 = level.questinfo.quests["_encstr_92A40EF9E31F7F501AA96573DCC4E8B0"].filters[0];
  var_9 = 5000;
  var_10 = 30000;

  if(playlandingbreath()) {
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

    foreach(var_25, var_19 in var_12) {
      if(!isDefined(var_2)) {
        var_2 = var_25;
        continue;
      }

      if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
        var_20 = _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::rpg_shoot_at_trigs(var_2);
        var_21 = _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::rpg_shoot_at_trigs(var_25);

        if(var_21 > 100000) {
          if(var_21 > var_20) {
            var_2 = var_25;
            continue;
          }
        }
      }

      var_22 = abs(var_17 - var_19);

      if(var_22 < abs(var_17 - var_12[var_2])) {
        var_2 = var_25;
        continue;
      } else if(var_22 > abs(var_17 - var_12[var_2])) {
        continue;
      }
      if(var_19 > var_12[var_2]) {
        var_2 = var_25;
        continue;
      } else if(var_19 < var_12[var_2]) {
        continue;
      }
      var_23 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getteamcenter(var_25, var_8);
      var_24 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getteamcenter(var_2, var_8);

      if(distance2d(var_16, var_23) < distance2d(var_16, var_24)) {
        var_2 = var_25;
        continue;
      }
    }
  }

  return var_2;
}

determinetargetplayer(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getteamcenter(self.hunterteam);

  foreach(var_7 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isplayervalid(var_7, relic_steelballs_dodamage(self.modifier))) {
      continue;
    }
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
      if(scripts\engine\utility::is_equal(var_7.script_noteworthy, "_encstr_950215C2E637C29B6E4B3785A3D2B7DCBE8E2C93D9AC47")) {
        var_4 = var_7;
        break;
      }
    }

    if(!isDefined(var_4))
      var_4 = var_7;

    if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
      var_8 = var_7.plundercount;

      if(isDefined(var_8)) {
        var_9 = distance2dsquared(var_1.origin, var_7.origin);

        if(!isDefined(var_3) || var_9 <= var_3) {
          if(!isDefined(var_2) || var_8 >= var_2) {
            var_2 = var_8;
            var_3 = var_9;
            var_4 = var_7;
          }
        }
      }

      continue;
    }

    if(distance2d(var_5, var_7.origin) < distance2d(var_5, var_4.origin))
      var_4 = var_7;
  }

  var_4.hasbeentracked = 0;
  self.targetplayer = var_4;
  self._id_13A8C = var_4.squadindex;
}

lbravo_spawner_jammer2b(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = level.questinfo.quests["_encstr_92A40EF9E31F7F501AA96573DCC4E8B0"].filters[0];
  var_5 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];
  var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").alltrackedplayers;
  var_7 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rotations(var_1.team, var_4, var_1.squadindex);
  var_8 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::run_trap_room_combat(var_1.team, var_4, var_1.squadindex).size;
  var_9 = 0;
  var_10 = 5000;
  var_11 = 30000;

  if(playlandingbreath()) {
    var_10 = level._id_12962;
    var_11 = level._id_12961;
  }

  while(!isDefined(var_3)) {
    var_9 = var_9 + 5000;
    var_12 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_5, var_6, undefined, var_10 + var_9, var_10);
    var_12 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(var_12, var_4);

    if(!isDefined(var_12) || var_12.size == 0) {
      if(var_9 > var_11) {
        var_12 = scripts\engine\utility::get_array_of_closest(var_1.origin, var_5, var_6, undefined, undefined, undefined);
        var_12 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(var_12, var_4);

        if(!isDefined(var_12) || var_12.size == 0)
          return undefined;
      } else
        continue;
    }

    var_13 = [];

    foreach(var_2 in var_12) {
      if(isDefined(var_13[var_2.squadindex])) {
        continue;
      }
      var_13[var_2.squadindex] = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::run_trap_room_combat(var_2.team, var_4, var_2.squadindex).size;
    }

    foreach(var_21, var_17 in var_13) {
      if(!isDefined(var_3)) {
        var_3 = var_21;
        continue;
      }

      var_18 = abs(var_8 - var_17);

      if(var_18 < abs(var_8 - var_13[var_3])) {
        var_3 = var_21;
        continue;
      } else if(var_18 > abs(var_8 - var_13[var_3])) {
        continue;
      }
      if(var_17 > var_13[var_3]) {
        var_3 = var_21;
        continue;
      } else if(var_17 < var_13[var_3]) {
        continue;
      }
      var_19 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rotations(var_0, var_4, var_21);
      var_20 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rotations(var_0, var_4, var_3);

      if(distance2d(var_7, var_19) < distance2d(var_7, var_20)) {
        var_3 = var_21;
        continue;
      }
    }
  }

  foreach(var_23 in _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::run_trap_room_combat(var_0, var_4, var_3)) {
    if(!isDefined(var_2))
      var_2 = var_23;

    if(distance2d(var_7, var_23.origin) < distance2d(var_7, var_2.origin))
      var_2 = var_23;
  }

  var_2.hasbeentracked = 0;
  self.targetplayer = var_2;
  self._id_13A8C = var_2.squadindex;
}

determinetrackingcircleposition(var_0) {
  var_1 = (var_0.origin[0], var_0.origin[1], relic_amped_test_explode_other_player());

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
    var_1 = var_1 + scripts\engine\math::random_vector_2d() * randomfloatrange(relic_amped_show_timer(), relic_amped_set_head_objective());

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DAE(var_1);
}

lbravo_spawner_jammer3b() {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(level._id_11A2A);
    self._id_13B39 = 2;
  } else {
    if(getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0))
      var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::run_trap_room_combat(self.hunterteam, level.questinfo.defaultfilter);
    else
      var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::run_trap_room_combat(self.hunterteam);

    if(var_0.size == 0) {
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(3500);
      self._id_13B39 = 0;
    } else {
      var_1 = undefined;

      foreach(var_3 in var_0) {
        var_4 = distance2d(var_3.origin, self.targetplayer.origin);

        if(!isDefined(var_1) || var_4 < var_1)
          var_1 = var_4;
      }

      if(var_1 > 5000) {
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(3500);
        self._id_13B39 = 0;
        return;
      }

      if(var_1 > 2500) {
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(2000);
        self._id_13B39 = 1;
        return;
      }

      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(1500);
      self._id_13B39 = 2;
    }
  }
}

determineobjectivevisibility() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    var_2 = var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag();
    var_3 = isDefined(var_1.aq_hudenabled) && var_1.aq_hudenabled;

    if(var_2 && var_3)
      var_1 hideassassinationhud(self);

    if(!var_2 && !var_3)
      var_1 showassassinationhud(self);
  }

  var_5 = self.squadindex;

  if(isDefined(self.targetplayer.squadindex))
    var_5 = self.targetplayer.squadindex;

  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, var_5)) {
    var_2 = var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag();
    var_3 = isDefined(var_1.call_exfil) && var_1.call_exfil;

    if(var_2 && var_3)
      var_1 spawn_cache4_rpgs();

    if(!var_2 && !var_3)
      var_1 _id_13344(self.targetplayer, self._id_13B39);
  }
}

calculatespawndisttodefenderflagstart() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  var_1 setclientomnvar("_encstr_856221C31CF97E7239D3D393B11786509B2B792F62D5468BB6C3279FFD6F83BF40573B", self._id_11C51);

  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0")
    thread carepackage_set_useable();
}

calculatepurchasexp() {
  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
    if(istrue(level.questinfo._id_132E8))
      level.squaddata[self.targetteam][self._id_13A8C].should_save_debug_info = 1;
    else
      scripts\mp\utility\teams::setteamdata(self.targetteam, "_encstr_BEC80AE0B683C1476AB3C3D9", 1);

    brgetloadoutoptionstandardloadoutindex(self.hunterteam);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
  } else {
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.hunterteam, "_encstr_8DD32BA225399E0776F9EBD3C0C0871350F75617B12025079E56826B0BABF30F8941C5BE1938AA97D0283AC3B1");
    var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.targetteam);
    var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardmodifier("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", var_0);
    self._id_12D2D = "_encstr_A299094E408C5D6BBB8142";
    var_2 = spawnStruct();
    var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0");
    var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", self._id_12D2D, self.modifier));
    var_2._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_3, var_0, var_4);
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.targetteam, "_encstr_8F512A1327BEC2E637586ECD4B9B2C1DD2DBCDEB3A4BADB239BE95C3384B9359EB8E2C93EC2BD1DCAFDD5A37", var_2, self._id_13A8C);

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

aq_playerdied(var_0, var_1) {
  if(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
    return;
  }
  thread calculatewinningteam(var_1, var_0);
}

calculateweaponmatchbonus(var_0) {
  thread calculatewinningteam(var_0);
}

calculatewinningteam(var_0, var_1) {
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
      var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0");

      if(isDefined(var_1) && isDefined(var_1.team) && var_1.team == self.hunterteam) {
        var_6 = "_encstr_9A9A265B459196B7327F5BDF141DEAD8B9D8D60931F7E5BB68C8E52029DB0F7D05AA93E7B9872D70";
        self._id_12D2D = "_encstr_B8760F58EBE215018D3321886FAC3863DA";
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lookforvehicles(self.hunterteam, var_1, 8, _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0"));

        foreach(var_8 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex))
        var_8 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_B84E3FBBDA508F1CF1DF744FED382537E688A28318156B9719176A7785202B2B95E2193AC078A30AB0277C43E7B07513A8D863C28B47FB8593776D519730BC9F68", 1);
      } else {
        var_6 = "_encstr_84E92A13DB4F21EF33A64E56BC3A134BD117E871F707F8A1EA4FC55519F35B3307D780F93BA150AB6334B5ED";
        self._id_12D2D = "_encstr_873711F1AB28526AA5F977DB3BD872AB8811B7";
      }

      var_10 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0", self._id_12D2D, self.modifier));
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
    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isteamvalid(self.hunterteam, relic_steelballs_dodamage(self.modifier))) {
      if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") {
        self.result = "_encstr_BD79059C51C351";
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
      } else {
        self._id_12D2D = "_encstr_A299094E408C5D6BBB8142";
        var_18 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C);
        var_19 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::search_speed(self.targetteam, var_0.origin, var_0.angles, self._id_12D30, var_18, self._id_13A8C);
        var_3 = spawnStruct();
        var_3._id_127D5 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_19["_encstr_83A20883C6EA378C2B93"]);
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.targetteam, "_encstr_BE352618C35729E7CBAE565E84320B33D91FE079FF0FE0D9E257CD6D11EB533B3FAFB860A7CFB8AD", var_3, self._id_13A8C);
        self.result = "_encstr_BD79059C51C351";
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
      }
    }
  }
}

getnewtargetplayer(var_0) {
  if(istrue(level.questinfo._id_132E8))
    lbravo_spawner_jammer2b(self.targetteam, var_0);
  else
    determinetargetplayer(self.targetteam, var_0);

  determinetrackingcircleposition(self.targetplayer);
  lbravo_spawner_jammer3b();
  updateassassinationhud();
}

removeallaqui() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex))
  var_1 hideassassinationhud(self);

  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  var_1 spawn_cache4_rpgs();

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();
}

getplayerkills() {
  if(level.br_leaderbystreak)
    return self.killsthislife.size;
  else
    return self.kills;
}

relic_steelballs_dodamage(var_0) {
  switch (var_0) {
    case "_encstr_BAA40B7FAF90ABC1F940D2AAD0":
    case "_encstr_8A430599F76844":
      return level.questinfo.defaultfilter;
    default:
      return 0;
  }
}

showassassinationhud(var_0) {
  self.aq_hudenabled = 1;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0" + var_0.modifier);
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(self);
}

hideassassinationhud(var_0) {
  self.aq_hudenabled = 0;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(self);
}

_id_13FC2(var_0, var_1) {
  if(isDefined(self.call_exfil) && self.call_exfil)
    var_2 = var_0 getentitynumber();
  else
    var_2 = -1;

  var_2 = var_0 getentitynumber();
  var_2 = var_2 + 1;
  var_3 = var_1 << 8 | var_2;
  self setclientomnvar("_encstr_B8ED1B4FD076C283171F6A627737EB813808C3874888072B43AE779FE5", var_3);
}

_id_13FC3(var_0) {
  foreach(var_2 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  var_2 _id_13FC2(self.targetplayer, self._id_13B39);
}

_id_13344(var_0, var_1) {
  self.call_exfil = 1;
  _id_13FC2(var_0, var_1);
}

spawn_cache4_rpgs() {
  self.call_exfil = 0;
  self setclientomnvar("_encstr_B8ED1B4FD076C283171F6A627737EB813808C3874888072B43AE779FE5", 0);
}

updateassassinationhud() {
  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex)) {
    var_1 showassassinationhud(self);
    var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivesetparameter(self.targetplayer getentitynumber());
  }

  foreach(var_1 in _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.targetteam, self._id_13A8C))
  var_1 _id_13344(self.targetplayer, self._id_13B39);
}

carepackage_set_useable() {
  self notify("_encstr_A15F19874BF711A79ADA20502334A748C3C9190D8767BBD544D270");
  self endon("_encstr_A15F19874BF711A79ADA20502334A748C3C9190D8767BBD544D270");
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
    var_6 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.hunterteam, self.squadindex), relic_steelballs_dodamage(self.modifier));

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

brexfilanimname() {
  level thread breventsinit();
}

breventsinit() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = getdvarint("_encstr_92FD1C6B801AEE65D8BFD9720B0E0A63AB735B3F4310593B62A3EED37BE0", 0);

  if(!var_0) {
    return;
  }
  var_1 = getdvarint("_encstr_8A421EF8F69877BAC67FF9F0B58F0F4BA7EF92AF1883F664871C53DFA3AB1DA3", 120);
  loadtables();
  wait(var_1);
  breventflagset(var_0);
}

breventflagset(var_0) {
  var_1 = spawnStruct();
  var_1._id_13AB1 = [];
  var_1.wam_interaction_structs = [];
  var_1._id_12CC9 = int(getdvarfloat("_encstr_8CF31E9B17EA7E55AB51CF4175919B2333B7B888A79E362DE242BDC04BAAFBA9", 10) * 1000);

  if(var_0 == 1)
    var_1.modifier = "_encstr_8A430599F76844";
  else if(var_0 == 2)
    var_1.modifier = "_encstr_BAA40B7FAF90ABC1F940D2AAD0";
  else {}

  if(var_1.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0")
    var_1 brgetloadoutammomax();
  else
    var_1 brgametype();

  var_1 thread brevent4();
  var_1 thread brhandleinvulnerability();
}

breventflagclear() {
  var_0 = (0, 0, 0);
  var_1 = brgetloadoutoptionforname();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = undefined;
    var_6 = scripts\mp\utility\teams::getteamdata(var_4, "_encstr_9775086022BE1B413B8B");

    foreach(var_8 in var_6) {
      if(var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
        continue;
      }
      if(var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath()) {
        var_5 = var_8;
        break;
      }

      if(!isDefined(var_5))
        var_5 = var_8;
    }

    if(!isDefined(var_5)) {
      continue;
    }
    var_10 = spawnStruct();
    var_10.team = var_4;
    var_10.pos = var_5.origin;
    var_0 = var_0 + var_10.pos;
    var_2[var_2.size] = var_10;
  }

  if(var_2.size < 2)
    return var_2;

  var_0 = var_0 / var_2.size;

  foreach(var_10 in var_2) {
    var_13 = var_10.pos - var_0;
    var_10._id_134DA = vectortoangles(var_13)[1];
  }

  var_2 = scripts\mp\utility\script::quicksort(var_2, ::brgetloadoutdropbagsdelayseconds);
  return var_2;
}

brgametype() {
  var_0 = breventflagclear();
  var_1 = getdvarint("_encstr_B8381FCF184B572AF5B8463D198752233360B747D0609FA20D484B32E887EAE219", 150);
  var_2 = var_0.size;

  if(isDefined(var_1))
    var_1 = int(min(var_1, var_2));
  else
    var_1 = var_2;

  var_3 = int(var_2 / var_1);
  var_4 = var_2 % var_1;
  var_5 = [];

  for(var_6 = 0; var_6 < var_3; var_6++)
    var_5[var_6] = var_1;

  for(var_6 = 0; var_6 < var_4; var_6++)
    var_5[var_6 % var_3]++;

  var_7 = 0;

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_1 = var_5[var_6];

    for(var_8 = 0; var_8 < var_1; var_8++) {
      var_9 = var_0[var_7 + var_8].team;
      var_10 = _id_145EB(var_8 - 1, var_1);
      var_11 = _id_145EB(var_8 + 1, var_1);
      var_12 = var_0[var_7 + var_10].team;
      var_13 = var_0[var_7 + var_11].team;
      var_14 = spawnStruct();
      var_14._id_13A75 = var_12;
      var_14._id_13A78 = var_13;
      self._id_13AB1[var_9] = var_14;
    }

    var_7 = var_7 + var_1;
  }
}

brgetloadoutammomax() {
  var_0 = getdvarfloat("_encstr_87861DC06AC2DF29A32FC749E4EFB14F6AD24878629DA780C720C0B5C9775B", 10000);
  var_1 = breventflagclear();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2].team;

    if(isDefined(self._id_13AB1[var_3])) {
      continue;
    }
    for(var_4 = 0; var_4 < var_1.size - 1; var_4++) {
      if(var_4 % 2)
        var_5 = int(-0.5 * var_4 - 0.5);
      else
        var_5 = int(0.5 * var_4 + 1);

      var_6 = _id_145EB(var_2 + var_5, var_1.size);
      var_7 = var_1[var_6].team;

      if(isDefined(self._id_13AB1[var_7])) {
        continue;
      }
      var_8 = var_1[var_6].pos;
      var_9 = var_1[var_2].pos;

      if(distance(var_8, var_9) > var_0) {
        continue;
      }
      var_10 = spawnStruct();
      var_10._id_13A75 = var_7;
      var_10._id_13A78 = var_7;
      self._id_13AB1[var_3] = var_10;
      var_11 = spawnStruct();
      var_11._id_13A75 = var_3;
      var_11._id_13A78 = var_3;
      self._id_13AB1[var_7] = var_11;
      break;
    }
  }
}

brgetloadoutoptionforname() {
  var_0 = gettime();
  var_1 = [];

  foreach(var_5, var_3 in level.teamdata) {
    if(isDefined(self._id_13AB1[var_5])) {
      continue;
    }
    var_4 = self.wam_interaction_structs[var_5];

    if(isDefined(var_4) && var_0 < var_4 + self._id_12CC9) {
      continue;
    }
    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isteamvalid(var_5, relic_steelballs_dodamage(self.modifier))) {
      continue;
    }
    var_1[var_1.size] = var_5;
  }

  return var_1;
}

brgetloadoutammomultiplier(var_0) {
  var_0 waittill("_encstr_A2BD0839CAB6B7CE5919");
  self.wam_interaction_structs[var_0.hunterteam] = gettime();
  self notify("_encstr_BD3107D507320BA356");
}

brhandleinvulnerability() {
  var_0 = getdvarint("_encstr_911421CD6C4EF5C4C97D85B11BEB2C37B95837374BE6F5BAE0192C3AACAF3295C6B0CB", 10);

  for(;;) {
    scripts\engine\utility::waittill_notify_or_timeout("_encstr_BD3107D507320BA356", var_0);

    if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
      brgivestartfieldupgrade();
      continue;
    }

    brgetoperatorteam();
  }
}

brgivestartfieldupgrade() {
  var_0 = [];

  foreach(var_3, var_2 in self._id_13AB1) {
    if(!isDefined(level.questinfo.quests["_encstr_92A40EF9E31F7F501AA96573DCC4E8B0"].instances[var_3]))
      var_0[var_0.size] = var_3;
  }

  foreach(var_3 in var_0)
  self._id_13AB1[var_3] = undefined;

  brgetloadoutammomax();
  brevent4();
}

brgetoperatorteam() {
  var_0 = [];

  foreach(var_3, var_2 in self._id_13AB1) {
    if(!isDefined(level.questinfo.quests["_encstr_92A40EF9E31F7F501AA96573DCC4E8B0"].instances[var_3])) {
      if(var_2._id_13A78 == var_2._id_13A75)
        var_0[var_0.size] = var_3;
    }
  }

  foreach(var_3 in var_0)
  self._id_13AB1[var_3] = undefined;

  var_6 = brgetloadoutoptionforname();
  var_7 = var_6.size;
  var_0 = [];

  foreach(var_3, var_2 in self._id_13AB1) {
    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isteamvalid(var_3, relic_steelballs_dodamage(self.modifier))) {
      if(var_7 > 0) {
        var_7--;
        var_9 = var_6[var_7];
        self._id_13AB1[var_9] = spawnStruct();
        self._id_13AB1[var_9]._id_13A78 = var_2._id_13A78;
        self._id_13AB1[var_9]._id_13A75 = var_2._id_13A75;
        self._id_13AB1[var_2._id_13A75]._id_13A78 = var_9;
        self._id_13AB1[var_2._id_13A78]._id_13A75 = var_9;
      } else {
        self._id_13AB1[var_2._id_13A75]._id_13A78 = var_2._id_13A78;
        self._id_13AB1[var_2._id_13A78]._id_13A75 = var_2._id_13A75;
      }

      var_0[var_0.size] = var_3;
    }
  }

  foreach(var_3 in var_0)
  self._id_13AB1[var_3] = undefined;

  if(var_7 >= 2) {
    for(var_12 = 0; var_12 < var_7; var_12++) {
      var_3 = var_6[var_12];
      var_13 = _id_145EB(var_12 - 1, var_7);
      var_14 = _id_145EB(var_12 + 1, var_7);
      var_15 = var_6[var_13];
      var_16 = var_6[var_14];
      var_17 = spawnStruct();
      var_17._id_13A75 = var_15;
      var_17._id_13A78 = var_16;
      self._id_13AB1[var_3] = var_17;
    }
  }

  if(self._id_13AB1.size < 2) {
    return;
  }
  brevent4();
}

brevent4() {
  foreach(var_6, var_1 in self._id_13AB1) {
    if(isDefined(level.questinfo.quests["_encstr_92A40EF9E31F7F501AA96573DCC4E8B0"].instances[var_6])) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_1._id_13A78;
    var_4 = "_encstr_8C8305779078A7" + var_2 + "_encstr_BA4C02DF" + var_3;
    var_5 = search(var_2, var_3, var_4, undefined, self.modifier);

    if(isDefined(var_5)) {
      var_5 search_target_think();

      if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0")
        var_5 thread brgulagdamagefilter();

      thread brgetloadoutammomultiplier(var_5);
    }
  }
}

brgulagdamagefilter() {
  self endon("_encstr_A2BD0839CAB6B7CE5919");
  var_0 = getdvarfloat("_encstr_A2A9286E3639BE4C9CEB58B163EBB0B93785E69B96DCD7B12D4EC68DCA7D9B1D164EE8F5BAE0C8B08EB2", 5);
  var_1 = getdvarfloat("_encstr_AB2626F3CE3307EE9591729A30F766FF4BA77B8B5318BF764B105A92109F5F5341AFE5707D01DBBF", 0.5);

  for(;;) {
    aq_questthink_circleposition();
    determinetrackingcircleposition(self.targetplayer);
    var_2 = riotshield_common();
    var_3 = var_0 - var_1;
    wait(var_3 * var_2 + var_1);
  }
}

brgetloadoutdropbagsdelayseconds(var_0, var_1) {
  return var_0._id_134DA <= var_1._id_134DA;
}

brgetloadoutoptionstandardloadoutindex(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B"));

  foreach(var_3 in var_1) {
    if(isalive(var_3))
      var_3 kill(var_3.origin, var_3);
  }

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_0, "_encstr_8DD32BA225399E0776F9EBD3C0C0871350F75617B12025079E56826B0BABF30F8941C5BE1938AA97D0283AC3B1");

  if(istrue(level.questinfo._id_132E8)) {
    var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, self.squadindex);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_88A0116BD26ECDB4EDCDAF0BB9CDF5992CA5C6", 1, var_5, 0);
  } else
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_88A0116BD26ECDB4EDCDAF0BB9CDF5992CA5C6", var_0, 1);
}

_id_145EB(var_0, var_1) {
  return (var_0 % var_1 + var_1) % var_1;
}

loadtables() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").lobby_door_enemy_watcher = 1;
}

loadout_updateweapondependentsettings() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").loadoutaddblueprintattachments = 1;
}

getkeypadcodelengthfromomnvar() {
  return isDefined(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").lobby_door_enemy_watcher) && _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").lobby_door_enemy_watcher;
}

getjuggmazespawnpoint() {
  return isDefined(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").loadoutaddblueprintattachments) && _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0").loadoutaddblueprintattachments;
}

riotshield_common() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_92A40EF9E31F7F501AA96573DCC4E8B0")._id_1296B;
  var_1 = (self._id_11C51 - gettime()) / 1000;
  var_2 = clamp(var_1 / var_0, 0.0, 1.0);
  return var_2;
}

relic_amped_test_explode_other_player() {
  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
    var_0 = getdvarfloat("_encstr_A18126AB2FD31F313509CFD2F47E092A13374F975018193B52ABF720320FA24877032BE74B7A98D7", 3000.0);
    var_1 = getdvarfloat("_encstr_8A5124D366B239F6EBAF1B395B014F906B7E5B2B0C06813E3273173197E985201459C3E07075", 200.0);
    var_2 = riotshield_common();
    var_3 = var_0 - var_1;
    return var_3 * var_2 + var_1;
  } else
    return 2000;
}

relic_amped_show_timer() {
  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0")
    return 0;
  else
    return 100;
}

relic_amped_set_head_objective() {
  if(self.modifier == "_encstr_BAA40B7FAF90ABC1F940D2AAD0") {
    var_0 = relic_amped_test_explode_other_player();
    return var_0 * 0.5;
  } else
    return 900;
}

playlandingbreath() {
  var_0 = 0;
  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_88AB1A158BDF6B1548D18F7F35459A290B27CFEAE26BB0DBB00ABD20", "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0");

  if(isDefined(var_1))
    return var_1;

  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var_2) {
    case "_encstr_87A205AF50D049":
    case "_encstr_866209ECEDB1197DEE0B4E":
    case "_encstr_9B1F05BE4B9B52":
    case "_encstr_8AE1099A0B999F2D28AF15":
    case "_encstr_BE180419DAE9":
      var_0 = 1;
      break;
  }

  return var_0;
}