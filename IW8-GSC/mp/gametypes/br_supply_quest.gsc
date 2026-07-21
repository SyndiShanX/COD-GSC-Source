/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_supply_quest.gsc
***********************************************/

init() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcategory("_encstr_B8F407C8034AB9D087", 1);

  if(!var_0) {
    return;
  }
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerremovequestinstance("_encstr_B8F407C8034AB9D087", ::_id_139A2);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registeronplayerkilled("_encstr_B8F407C8034AB9D087", ::_id_1399F);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2E("_encstr_B8F407C8034AB9D087", ::_id_139A0);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B2D("_encstr_B8F407C8034AB9D087", ::_id_1399C);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B30("_encstr_B8F407C8034AB9D087", ::_id_1399D);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerquestcircletick("_encstr_B8F407C8034AB9D087", ::_id_1398F);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A6D13B6D237E6A5DECDFA9BAB1CD7C26C6CCA8347"] = "_encstr_ADDD1B83318AC8FBF7A2D698BAEFAE40259E5F1FA5356137FF6AE92353";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_818317EA70DFEA97C0107F6BB50B87F705A8C352D87924F37A"] = "_encstr_95AB1C5B5ACDE62D7BE6BEB52D9B6EB47B737DB9D81667FA858D8D2B38A3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ABD71448F32833A3881DEFFA8333C606C31B2B3A3707"] = "_encstr_B29F1631AAE36DC0162BA9875D7C80BE7FC34BB9F2272610";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD0E11E59020CB221875DF577BBF891668785D"] = "_encstr_81921910E4B358733A6B673B4FC3464077BDDEA90F0681BCB21F09";
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297C("_encstr_B8F407C8034AB9D087", 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12B31("_encstr_B8F407C8034AB9D087", ::_id_1399E);
  totaltrainlootcrates();
}

takequestitem(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::createquestinstance("_encstr_B8F407C8034AB9D087", self.team, var_0.index, var_0);
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::registerteamonquest(self.team, self);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::searchfunc(self.team, "_encstr_8864196AD8F71DE7538E594728FECBA437B883C34949D6F3E8FD4C");
  var_1.semtex_stuckplayer = self;
  var_1.team = self.team;
  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
  var_1 _id_13999();
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1297D(getdvarint("_encstr_8F571C8F6913C972935F8B2B43384BBB191BD3AA5B5B23FC33C94506A8D7", 180), 4);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::addquestinstance("_encstr_B8F407C8034AB9D087", var_1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13879("_encstr_B8F407C8034AB9D087", self, self.team);
  var_2 = spawnStruct();
  var_2.excludedplayers = [];
  var_2.excludedplayers[0] = var_1.semtex_stuckplayer;
  var_2.ogangles = [];
  var_2.ogangles[0] = var_1.team;
  var_2._id_127D5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardmodifier("_encstr_B8F407C8034AB9D087", _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team));
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(var_1.team, "_encstr_B6531B8EDB59C3189740AC30D707E39DC713885F0352CB735EFBD5F143", var_2);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_1.semtex_stuckplayer, "_encstr_951F245E020F1B936283E85869FA5B1107AC484E7C9F63A9812B8888729701EEBB29684DC50B", var_2);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztutdropcash("_encstr_8A6D13B6D237E6A5DECDFA9BAB1CD7C26C6CCA8347", var_1.team, var_1.semtex_stuckplayer, 1, 0.5);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8A6D13B6D237E6A5DECDFA9BAB1CD7C26C6CCA8347", var_1.semtex_stuckplayer, 1, 0.5);
  var_3 = _id_13995(var_1.semtex_stuckplayer);
  var_1 thread _id_13993(var_3);
}

_id_13999() {
  var_0 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::sortvalidplayersinarray(scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B"));

  foreach(var_2 in var_0["_encstr_9B9406CE2CC64B23"])
  var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_B8F407C8034AB9D087");

  foreach(var_2 in var_0["_encstr_975C08DAFD6501713F9D"])
  var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
}

_id_1399F(var_0, var_1) {
  _id_139A1(var_1, var_0);
}

_id_139A0(var_0) {
  if(var_0.team == self.team) {
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestinstancedata("_encstr_B8F407C8034AB9D087", self.team).playerlist = var_1;

    if(isDefined(self.crate) && var_1.size)
      self.crate setotherent(var_1[0]);

    if(!_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::isteamvalid(var_0.team)) {
      self.result = "_encstr_BD79059C51C351";
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
    }
  }

  _id_139A1(var_0);
}

_id_1399C(var_0) {
  _id_13998(var_0);
}

_id_1399D(var_0) {
  if(var_0.team == self.team)
    _id_1399A(var_0);
}

_id_139A1(var_0, var_1) {}

_id_1399E() {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_BD0E11E59020CB221875DF577BBF891668785D", self.team, 1, 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_9B641E8A0D113227CFF3C29BFEA7FF6FD8B93F0453F8FF7360497B132D7EF767");
  self.result = "_encstr_BD79059C51C351";
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

_id_139A2() {
  _id_13997();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::releaseteamonquest(self.team);
}

_id_1399A(var_0) {
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectiveshow("_encstr_B8F407C8034AB9D087");
}

_id_13998(var_0) {
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivehide();
}

_id_13997() {
  foreach(var_1 in scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B"))
  _id_13998(var_1);
}

_id_13990() {
  var_0 = spawnStruct();
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::ringing(self.team);
  var_2 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquestindex("_encstr_B8F407C8034AB9D087");
  var_3 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtovalue(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::rewardtotype("_encstr_B8F407C8034AB9D087"));
  var_4 = _encstr_96292CAF888B0430F313B7ADBBE6A98203C79BE8A065087EB2CE1F3145C08EA2D74BCD198818A58A035B351780C8::clear_all_remaining(self.semtex_stuckplayer);
  var_0._id_121B5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_121B9(var_2, var_1, var_3, undefined, var_4);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_AAB8193127D76EBAE0E01B2FAF17AE95DCD1FAC6F6ADC18DACE856", var_0);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztutdropcash("_encstr_ABD71448F32833A3881DEFFA8333C606C31B2B3A3707", self.team, self.semtex_stuckplayer, 1, 0, 0.5);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_ABD71448F32833A3881DEFFA8333C606C31B2B3A3707", self.semtex_stuckplayer, 1, 0, 0.5);
  self._id_12D2D = undefined;
  self._id_12D2E = self.semtex_stuckplayer.origin;
  self._id_12D2B = self.semtex_stuckplayer.angles;
  self.result = "_encstr_88E30897BDF1B71F7823";
  thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

_id_1398E() {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_BD0E11E59020CB221875DF577BBF891668785D", self.team, 1, 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_970A1F4C39FA6EAB0E1CC6F2BEE2AB59E61DD7D8B4C9B1C695EB330BD236EAC92B");
  self.result = "_encstr_BD79059C51C351";
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

_id_13994() {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_BD0E11E59020CB221875DF577BBF891668785D", self.team, 1, 1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayteamsplash(self.team, "_encstr_846E184CC9D7E6EA0E1C8D97EBC5AEB2B93AFACC85968DBA4E95");
  self.result = "_encstr_BD79059C51C351";
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::removequestinstance();
}

_id_1398F(var_0, var_1) {
  if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius() > 0) {
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

    if(!isDefined(self.lastcircletick))
      self.lastcircletick = -1;

    var_3 = gettime();

    if(self.lastcircletick == var_3) {
      return;
    }
    self.lastcircletick = var_3;

    if(isDefined(self.crate)) {
      var_4 = distance2d(self.crate.origin, var_0);

      if(var_4 > var_2) {
        _id_1398E();
        self.crate setscriptablepartstate("_encstr_862B0E856EB5320BE338A3177138C1AB", "_encstr_8882099673858D1D4B6756", 0);
      }
    }
  }
}

_id_13993(var_0) {
  wait(getdvarint("_encstr_8D6C1DF8DB26408E8A092BE73B4F033F77C903584AB33D598588194DF073B3", 3.0));
  var_1 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_0 + (0, 0, 5000), var_0, (0, 0, 0), "_encstr_83311156B3EB096899A7C8420E884679625D4D", "_encstr_9BD5110B93F862333B01B36AABAF671D403994", 0);
  var_1 setotherent(self.semtex_stuckplayer);
  self.crate = var_1;
  self.crate.trackriotshield_monitorshieldattach = self.id;
  self.crate.cratetype = "_encstr_83311156B3EB096899A7C8420E884679625D4D";
  var_2 = spawnStruct();
  var_2.excludedplayers = [];
  var_2.excludedplayers[0] = self.semtex_stuckplayer;
  var_2.ogangles = [];
  var_2.ogangles[0] = self.team;
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::look_at_heli("_encstr_ADC91BA172AF684DFBC3D1E3673395103B4B8E191AF9080D217BE5C7F3", var_0, getdvarint("_encstr_9A96201F67DA199572605BD352213AB08FB8CAF8D3E3695A70406B38A0404B7386BB", 10000), level.questinfo.defaultfilter, var_2);
  var_3 = scripts\mp\utility\player::getplayersinradius(var_0, getdvarint("_encstr_9A96201F67DA199572605BD352213AB08FB8CAF8D3E3695A70406B38A0404B7386BB", 10000));

  foreach(var_5 in var_3) {
    if(var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
      continue;
    }
    if(var_5.team == self.team) {
      continue;
    }
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_818317EA70DFEA97C0107F6BB50B87F705A8C352D87924F37A", var_5, 1, 0, 0.5);
  }

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_818317EA70DFEA97C0107F6BB50B87F705A8C352D87924F37A", self.team, 1, 1);
}

totaltrainlootcrates() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_83311156B3EB096899A7C8420E884679625D4D");
  var_0.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_0.dummymodel = "_encstr_AAD31BDAD21B2D3AB09CF2D7D8C29C953858B1B6859D95BE0C8CEB26C9";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = getdvarint("_encstr_8F571C8F6913C972935F8B2B43384BBB191BD3AA5B5B23FC33C94506A8D7", 180) + 5 - getdvarint("_encstr_8D6C1DF8DB26408E8A092BE73B4F033F77C903584AB33D598588194DF073B3", 3.0);
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 2.0;
  var_0.otherusetime = 2.0;
  var_0.activatecallback = scripts\cp_mp\killstreaks\airdrop::dialog_wait_think;
  var_0.capturecallback = ::_id_13992;
  var_0.destroycallback = scripts\cp_mp\killstreaks\airdrop::dialogqueue;
  var_0.ingame = scripts\cp_mp\killstreaks\airdrop::dialogueindex;
  var_0.destroyoncapture = 1;
}

_id_13992(var_0) {
  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  _id_1399B(var_0);

  if(isDefined(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::reviveteam("_encstr_B8F407C8034AB9D087", self.trackriotshield_monitorshieldattach))) {
    var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::reviveteam("_encstr_B8F407C8034AB9D087", self.trackriotshield_monitorshieldattach);

    if(var_0.team == var_1.semtex_stuckplayer.team)
      var_1 _id_13990();
    else
      var_1 _id_13994();
  }
}

_id_1399B(var_0) {
  self.itemsdropped = 0;

  if(!isDefined(level.deletesmokinggunhud))
    level.deletesmokinggunhud = 0;
  else
    level.deletesmokinggunhud = (level.deletesmokinggunhud + 1) % 10;

  var_1 = verifybunkercode("_encstr_92C9168DED37A3C9B01BD1EBB9EA0738C6BCAFD8930BE859", level.deletesmokinggunhud);

  if(isDefined(var_1))
    var_1 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A1A(var_1, var_0);

  if(isDefined(var_1) && var_0 scripts\mp\utility\perk::_hasperk("_encstr_A525253BC72DCE64888D531381EE1B39A7581BF2D0612790AD2867E108076FA8B6096323CDA015"))
    var_1 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A1D(var_1, var_0);

  if(isDefined(var_1))
    var_2 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_1, 0);

  if(!isDefined(var_0._id_11A01))
    var_0._id_11A01 = 1;
  else
    var_0._id_11A01++;

  var_0 scripts\mp\utility\stats::setextrascore1(var_0._id_11A01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_92611950639191A0EF2CF0D618C78B71C78B41D82AF0BFF8EB2560");
}

_id_13996(var_0) {
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_1, var_2, 0.2, 0.8, 1, 1);
  var_4 = scripts\mp\utility\teams::getenemyplayers(var_0.team, 1);
  var_5 = sortbydistance(var_4, var_0.origin);

  if(var_5.size > 0 && _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius() > 0) {
    foreach(var_7 in var_5) {
      var_8 = var_7 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag();
      var_9 = distance2d(var_0.origin, var_7.origin);

      if(isDefined(var_7) && !var_8 && var_9 < getdvarint("_encstr_873026EBB1E69F7E784F8B75E99005CF98297372FB35E772E81B826BF1C14FD7362339DA809FE76A", 23650)) {
        if(distance2d(var_7.origin, var_1) < var_2 && _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius() > 0) {
          var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_7.origin, clamp(var_2 - distance2d(var_7.origin, var_1), 100, getdvarint("_encstr_88711FE66CC9AF3193AF9B5DC1388DE5AF8D9C58A3597DB11B16D6C1F58C96CDE8", 12000)), 0.1, 0.9, 1, 1);
          return var_3;
        } else {
          if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius() > 0) {
            continue;
          }
          var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_7.origin, 4000, 0.1, 0.9, 1, 1);
          return var_3;
        }
      }
    }

    if(getdvarint("_encstr_873026EBB1E69F7E784F8B75E99005CF98297372FB35E772E81B826BF1C14FD7362339DA809FE76A", 23650) < var_2 && distance2d(var_0.origin, var_1) > var_2) {
      var_11 = vectortoangles((var_0.origin[0], var_0.origin[1], 0) - (var_1[0], var_1[1], 0));
      var_12 = var_2 - getdvarint("_encstr_88711FE66CC9AF3193AF9B5DC1388DE5AF8D9C58A3597DB11B16D6C1F58C96CDE8", 12000);
      var_13 = scripts\engine\math::vector_project_endpoint(var_1, var_11, var_12);
      var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_13, getdvarint("_encstr_88711FE66CC9AF3193AF9B5DC1388DE5AF8D9C58A3597DB11B16D6C1F58C96CDE8", 12000), 0.1, 0.7, 1, 1);
    } else {
      var_11 = vectortoangles((var_0.origin[0], var_0.origin[1], 0) - (var_1[0], var_1[1], 0));
      var_12 = distance2d(var_1, var_0.origin);
      var_13 = scripts\engine\math::vector_project_endpoint(var_1, var_11, var_12 / 2);
      var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_13, clamp(var_12 / 2, 100, getdvarint("_encstr_88711FE66CC9AF3193AF9B5DC1388DE5AF8D9C58A3597DB11B16D6C1F58C96CDE8", 12000)), 0.1, 0.8, 1, 1);
    }
  } else if(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius() > 0)
    var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_1, clamp(var_2, 100, getdvarint("_encstr_88711FE66CC9AF3193AF9B5DC1388DE5AF8D9C58A3597DB11B16D6C1F58C96CDE8", 12000)), 0.1, 0.9, 1, 1);
  else
    var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_0.origin, getdvarint("_encstr_88711FE66CC9AF3193AF9B5DC1388DE5AF8D9C58A3597DB11B16D6C1F58C96CDE8", 12000), 0.1, 0.9, 1, 1);

  return var_3;
}

_id_13995(var_0) {
  var_1 = _id_13996(var_0);

  if(isDefined(var_1) && istrue(level._id_14089) && isscriptabledefined())
    var_1 = getclosestpointonnavmesh(var_1);

  return var_1;
}