/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_geigerstash_quest.gsc
*************************************************/

init() {
  scripts\engine\scriptable::_id_12F5B("_encstr_AD9B0589ED9197", ::postspawn_rpg);
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_95B60C179A73E83FD62A41CE4698", 1);

  if(!var_0) {
    return;
  }
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_95B60C179A73E83FD62A41CE4698")._id_12FA0 = getdvarint("_encstr_96C324C3E8153963AB70BFB57351273A7F286A5B18F7EAB721CE83A00EB8B38699083172106B", 7000);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_95B60C179A73E83FD62A41CE4698")._id_11C4C = getdvarint("_encstr_B48F234AF993CFAABE3FE7E7BBEC023AA0A346D2F011B552167F27D78D1D8A6DC88DFE5AC9", 180);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B3D("_encstr_95B60C179A73E83FD62A41CE4698", ::postspawn_sniper);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_95B60C179A73E83FD62A41CE4698", ::postspawn_assault3_bombers);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2E("_encstr_95B60C179A73E83FD62A41CE4698", ::postplunder);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcircletick("_encstr_95B60C179A73E83FD62A41CE4698", ::postgamestate);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2D("_encstr_95B60C179A73E83FD62A41CE4698", ::postkillcamplunderlost);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B30("_encstr_95B60C179A73E83FD62A41CE4698", ::postspawn_initial_allies);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C("_encstr_95B60C179A73E83FD62A41CE4698", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31("_encstr_95B60C179A73E83FD62A41CE4698", ::postlaunchscenenodecorrection);
}

postspawn_sniper() {
  var_0 = self.origin;
  var_1 = _id_11A00(var_0);
  var_2 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::play_train_speaker_vo("_encstr_95B60C179A73E83FD62A41CE4698", var_1);

  if(!isDefined(var_2))
    return 0;

  getlootspawnpointcount(var_2.index);
  var_0 = var_2.origin;
  self._id_12C4A = var_2;
  return 1;
}

postgamestate(var_0, var_1) {
  if(!isDefined(self.lastcircletick))
    self.lastcircletick = -1;

  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }
  self.lastcircletick = var_2;
  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1)
    pathstruct();
}

postkillcamplunderlost(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
}

postspawn_initial_allies(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_95B60C179A73E83FD62A41CE4698");
}

postlaunchscenenodecorrection() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_851023757B410490A91F619B029CF8468A67CBD3DF6B5579ECF468716A4F2B7B6327450B73");
  var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](self.team, 0);
  postshipmodifychevrons(var_0);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9B9511AD2D379B4BBDE6BE9D95B9FACC2CB48D", self.team, 1);
}

postshipmodifychevrons(var_0) {
  var_1 = "_encstr_AC8F0AE74163F85AAA380AD8";
  var_2 = "_encstr_91BE15B2E25DA538F5D9B2A5D9CAE4BE6CB7AEB91D2BE4";
  var_0[0] scripts\mp\equipment::_id_13A30(var_0, var_1, var_2, 0);

  foreach(var_4 in var_0) {
    if(isDefined(var_4.modespawnclient))
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_4.modespawnclient);
  }
}

postspawn_assault3_bombers() {
  lastboredscore();

  foreach(var_1 in self.playerlist)
  var_1 setclientomnvar("_encstr_9563145DB4EB4CC9F5EC564BB3B2E4F5E8B0E476591D", -1);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
}

postplunder(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestinstancedata("_encstr_95B60C179A73E83FD62A41CE4698", self.team).playerlist = var_1;

    if(isDefined(self) && isDefined(self.force_spawn_all_dead_players) && var_1.size)
      self.force_spawn_all_dead_players setotherent(var_1[0]);

    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isteamvalid(var_0.team)) {
      self.result = "_encstr_BD79059C51C351";
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
    }
  }
}

gethillspawnshutofforigin(var_0) {
  if(var_0.team == self.team)
    return 1;
  else
    return 0;
}

takequestitem(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createquestinstance("_encstr_95B60C179A73E83FD62A41CE4698", self.team, var_0.index, var_0);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerteamonquest(self.team, self);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B15(self);
  var_1.team = self.team;
  var_1.startlocation = self.origin;
  var_1.intelprogress = self.origin;
  var_1._id_12C4A = var_0._id_12C4A;
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
  var_2 = _id_11A00(var_1.startlocation, var_1._id_12C4A);
  var_1 _id_13659(var_1._id_12C4A.origin, var_1._id_12C4A.angles);
  var_1 _id_13FDC();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshowtoteam("_encstr_95B60C179A73E83FD62A41CE4698", self.team);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestdata("_encstr_95B60C179A73E83FD62A41CE4698")._id_11C4C, 4);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_95B60C179A73E83FD62A41CE4698", var_1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879("_encstr_95B60C179A73E83FD62A41CE4698", self, self.team);
  var_3 = spawnStruct();
  var_3.excludedplayers = [];
  var_3.excludedplayers[0] = self;
  var_3._id_127D5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardmodifier("_encstr_95B60C179A73E83FD62A41CE4698", _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_B27A27829BE16F454322AD66A84383BB5021D84DAF170B5EC7F3317EB3319B689720901D68884BB363", var_3);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self, "_encstr_BE7D29B663D14F72ABD787C3E7CDFA93902EEAFB391804A9FED99FCB0160F3F968D0670316E8D1725D83EB", var_3);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::searchfunc(self.team, "_encstr_8864196AD8F71DE7538E594728FECBA437B883C34949D6F3E8FD4C");
}

_id_11A00(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_12FA3 = "_encstr_B16718DF8753BD6855FA81B92D27286558FF4F493FA8F6709950";
  var_2._id_12F9F = var_0;
  var_2._id_12FA6 = 10000;
  var_2._id_12FA7 = 0;
  var_2._id_12FA4 = 4000;
  var_2._id_12FA5 = 2000;
  var_2._id_12FA1 = 1;
  var_2._id_12C4A = var_1;
  var_2.mintime = 60;

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15") {
    if(var_2._id_12FA6 < level._id_12969)
      var_2._id_12FA6 = level._id_12969;

    var_2._id_12FA4 = level._id_12969;
    var_2._id_12FA5 = level._id_1296A;
  }

  return var_2;
}

_id_13659(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3 = self.playerlist[0];
  var_2.angles = var_1;
  var_2 setotherent(var_3);
  var_2 setModel("_encstr_99EA29F2B782436D51468BC1582FD070E6AF7DB7E3E5E76A1787027D3009B25969DDEAF0A40F9F51CFFA79");
  var_2 setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_828D1319AF91C04D23C7F9DBEFAA98583C8503D197");
  var_2._id_12970 = self;
  self.force_spawn_all_dead_players = var_2;
  var_2._id_12970.curorigin = var_2.origin;

  foreach(var_5 in level.players) {
    if(var_5 != var_3 && (var_3.team == "_encstr_8BBA05185F8B99" || var_5.team != var_3.team))
      var_2 disablescriptableplayeruse(var_5);
  }

  var_7 = "_encstr_AC8F0AE74163F85AAA380AD8";
  var_8 = "_encstr_91BE15B2E25DA538F5D9B2A5D9CAE4BE6CB7AEB91D2BE4";
  self.playerlist[0] scripts\mp\equipment::scriptablescleanupbatchsize(self.playerlist, var_7, var_8);
  var_9 = self.force_spawn_all_dead_players getentitynumber();

  foreach(var_5 in self.playerlist)
  var_5 setclientomnvar("_encstr_9563145DB4EB4CC9F5EC564BB3B2E4F5E8B0E476591D", var_9);
}

_id_13FDC() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::sortvalidplayersinarray(self.playerlist);

  foreach(var_2 in var_0["_encstr_9B9406CE2CC64B23"])
  var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_95B60C179A73E83FD62A41CE4698");

  foreach(var_2 in var_0["_encstr_975C08DAFD6501713F9D"])
  var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
}

spawn_carriables_from_scriptables_individual_percentage(var_0) {
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
}

lastboredscore() {
  foreach(var_1 in self.playerlist)
  spawn_carriables_from_scriptables_individual_percentage(var_1);
}

postspawn_rpg(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_ADBB1538C49859E5C29B60B8A33047CAA3AF31F1D38BE8", var_0))) {
    return;
  }
  if(var_2 == "_encstr_828D1319AF91C04D23C7F9DBEFAA98583C8503D197" && isDefined(var_0.entity)) {
    var_5 = var_0.entity._id_12970;

    if(istrue(var_5.removed)) {
      var_3 scripts\mp\utility\lower_message::_id_1316E("_encstr_8EF011069F687C83B736A4D1C06860B13338D3", undefined, 5);
      return;
    }

    var_0 setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_A696149922D7DC40FA13B1933B24C990DB5A30C03A57");
    var_6 = getdvarint("_encstr_8617243BA9A3BFCDD88794CD1C8AF1BDFA5BE9C3D29089662619CB3185E3276575C1E1ED29B3", 30);
    var_0.entity scripts\engine\utility::delaycallwatchself(var_6, ::delete);
    var_5._id_12D2E = var_0.origin;
    var_5._id_12D2B = var_0.angles;
    var_5 hint_escape_maze(var_0.entity);
    level notify("_encstr_82941EBD48D8D4AA27572B17C7D8633D389137C960B08412106F17CBB9F07B64" + var_0.origin);
    var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_3.team, 0);

    foreach(var_9 in var_7)
    var_9 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");

    postshipmodifychevrons(var_7);
  }
}

hint_escape_maze(var_0) {
  var_1 = spawnStruct();
  var_2 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team);
  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_95B60C179A73E83FD62A41CE4698");
  var_4 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_95B60C179A73E83FD62A41CE4698"));
  var_1._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_3, var_2, var_4);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_93FB1E139C7DEC952DD9B24EB9E8C26E0DAF17AEB26E477D36F6B638D8591D95", var_1);
  self._id_12D2E = var_0.origin;
  self._id_12D2B = var_0.angles;
  self.result = "_encstr_88E30897BDF1B71F7823";

  foreach(var_6 in self.playerlist)
  var_6 setclientomnvar("_encstr_9563145DB4EB4CC9F5EC564BB3B2E4F5E8B0E476591D", -1);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();

  foreach(var_6 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B"))
  var_6 scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_ABE613289349CA177B72C9F2418F074A99BD810663");
}

pathstruct() {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_844F24959BA1E47009BFC13BA2FC98262AC72B337FCB35D95B142B118DD531D41287998B4BF2");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_875718B6D2DC6E96EDCD7DBD26A6FA6CD2278DD8B2F5CCB09636", self.team, 1);
  self.result = "_encstr_BD79059C51C351";

  foreach(var_1 in self.playerlist)
  var_1 setclientomnvar("_encstr_9563145DB4EB4CC9F5EC564BB3B2E4F5E8B0E476591D", -1);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}