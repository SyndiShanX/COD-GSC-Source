/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_medical_crate_drop.gsc
**************************************************/

init() {
  level._encstr_84870FAFD32582730B88292EA3E8AC9A06 = [];
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_B2AD0EADE3C1932783ABA66E30DB3448");
  var_0.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_0.dummymodel = "_encstr_81B323C844B374732990702F3877A803E969376B16206B7FB92740C92E87674A9098870BD9";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 1.5;
  var_0.otherusetime = 1.5;
  var_0.activatecallback = ::_encstr_93711FC4C9B65632D236588D6C9C85E8B20B361D2DD985A3CAD816C6632685B15B;
  var_0.capturecallback = ::_encstr_B1981EC01BBD6101526607997EBB530B1DE750C8EB5D5BCBDA8E899116629F50;
  var_0.destroyoncapture = 1;
  level._encstr_B2AD0EADE3C1932783ABA66E30DB3448 = spawnStruct();
  level._encstr_B2AD0EADE3C1932783ABA66E30DB3448._encstr_B89B0D392BEC2DECCAD7B4A3566B6E = [["_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1", 1], ["_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1", 1], ["_encstr_A378104B25894AD7104638C5D971F333D383", 4]];
  level._encstr_B2AD0EADE3C1932783ABA66E30DB3448._encstr_96A91347B0B1A3A5B116B1FA952EBAD283D6ACB93A = [["_encstr_BA4719B06BCC7047D359B3CD2EAA895817BF08889F96C9092A3D3D", 2]];
  level._encstr_B2AD0EADE3C1932783ABA66E30DB3448._encstr_8DC70D61E5E220CE0F6B8870B29B86 = [["_encstr_B6921C7DCAADC8187B519339AB2FD8E885399DD97F5250535F0A4E41E2BB", 1], ["_encstr_B6921C7DCAADC8187B519339AB2FD8E885399DD97F5250535F0A4E41E2BB", 1], ["_encstr_96D01F899336DB7BD17D07B227D6D783F6A5E6D1D7367B1B32FA98B17B7BC8AC32", 1], ["_encstr_96D01F899336DB7BD17D07B227D6D783F6A5E6D1D7367B1B32FA98B17B7BC8AC32", 1]];
}

_encstr_93711FC4C9B65632D236588D6C9C85E8B20B361D2DD985A3CAD816C6632685B15B(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }

  level._encstr_84870FAFD32582730B88292EA3E8AC9A06[level._encstr_84870FAFD32582730B88292EA3E8AC9A06.size] = self;
}

_encstr_B1981EC01BBD6101526607997EBB530B1DE750C8EB5D5BCBDA8E899116629F50(var_0) {
  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  level._encstr_84870FAFD32582730B88292EA3E8AC9A06 = scripts\engine\utility::array_remove(level._encstr_84870FAFD32582730B88292EA3E8AC9A06, self);
  _encstr_A232206B27F203A0A1DD26B94289504DF9ABF7E79BA95DC8EBB38BF06E6588F3923B();
}

_encstr_A232206B27F203A0A1DD26B94289504DF9ABF7E79BA95DC8EBB38BF06E6588F3923B() {
  var_0 = [];

  foreach(var_2 in level._encstr_B2AD0EADE3C1932783ABA66E30DB3448._encstr_B89B0D392BEC2DECCAD7B4A3566B6E)
  var_0[var_0.size] = var_2;

  foreach(var_2 in level._encstr_B2AD0EADE3C1932783ABA66E30DB3448._encstr_96A91347B0B1A3A5B116B1FA952EBAD283D6ACB93A)
  var_0[var_0.size] = var_2;

  foreach(var_2 in level._encstr_B2AD0EADE3C1932783ABA66E30DB3448._encstr_8DC70D61E5E220CE0F6B8870B29B86)
  var_0[var_0.size] = var_2;

  var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

  foreach(var_2 in var_0) {
    var_10 = var_2[0];

    if(var_10 == "_encstr_A378104B25894AD7104638C5D971F333D383") {
      _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_encstr_8A90118BB809D88A7A37708B432FDB6890CF98(self.origin, self.angles, self, 4);
      continue;
    }

    if(_encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::get_bonus_targets(var_10)) {
      var_11 = level.br_pickups.delay_hide_player_clip[var_10];

      if(isDefined(var_11) && var_11 == 4) {
        var_12 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_10, var_8, self.origin, self.angles, 0, 1);
        var_13 = 1;
      } else
        var_12 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_10, var_8, self.origin, self.angles, 0, 0);

      var_12.count = var_2[1];
    }
  }
}

_encstr_A51616ED05712AA3E9A8AF5770C18C52AFAE3567FFBD23F8() {
  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.origin);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  level._encstr_84870FAFD32582730B88292EA3E8AC9A06 = scripts\engine\utility::array_remove(level._encstr_84870FAFD32582730B88292EA3E8AC9A06, self);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

_encstr_85A81360514BCF522ACB4F4BF287E5E3723BAFCBB7() {
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_B2AD0EADE3C1932783ABA66E30DB3448");
  return var_0.ownerusetime;
}