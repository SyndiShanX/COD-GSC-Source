/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_skydive_protection.gsc
**************************************************/

init() {
  var_0 = isDefined(level.modifyplayerdamage) && level.modifyplayerdamage == _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::brmodifyplayerdamage;

  if(var_0) {
    level.modifyplayerdamage = ::endmatchcamerastriggered;
    level._id_133EF = getdvarint("_encstr_81861BF74B22B9DBC7F3D1A32BA8E713E15F3568A867232F6F2548B5F0", 1) == 1;
    level._id_133F1 = getdvarfloat("_encstr_9A9F235B89AA87BFEA3BDA49A37A29B3AF63983BBB57BB0FBE4BB85745B5D0B97B967478FE", 0.1);
    level._id_133EE = getdvarfloat("_encstr_A5921FC3C112595F201262D0FB3DBFCB7ABBE8C1697578EF73071E8B20A3A27059", 0.1);
    level._id_133F5 = getdvarint("_encstr_914529DFDFBB6F737A92EAB3750F1FF96374F6A13888398382F59188E8374717247AE1ADF358B0E591A0D3", 2500);
    level._id_133F4 = getdvarint("_encstr_ACB62C43213059EBE81ADFC29B59237BD9B796EFE672B4F8E91B88BAC38BFE9705C1F92769E73B29728023958848", 750);
    level._id_133F3 = getdvarfloat("_encstr_A2C026620E2531BBA0184B475859530BDB9CAD526EB73BF5C918775770B45712A3BCF497D6B9C228", 0.25);
    level._id_133F2 = getdvarfloat("_encstr_81992963BE4377DAD730B27A50131A03991CF6D84E888367EFB06A12B82B4DEB700C4965E6F5276BB950D2", 0.25);
    level._encstr_9B7026DCB5978C963B567D9BC1B0EEE63827ED47ACB11D96DEB9CDC299954797912D9B1DB0B9B156 = getdvarfloat("_encstr_96BA29ABF20B10206CC96173EED7194FEF2B80370BA73DD806BC6347EEB2401C87B3FA3D02BF75209D8373", 750);
  }
}

toma_strike_munitionused(var_0) {
  if(!istrue(level._id_133EF)) {
    return;
  }
  thread endingpropspecate();
  thread ending_zplanes();
  thread ending_winning_players_setup();

  if(var_0)
    thread endingph();
  else
    self._id_133F1 = level._id_133F1;
}

ending_zplanes() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8D55207B7C2B72F23D79F03565EBC0AB3511578009EFF85EABBD3F3B32679019AF3D");
  self._id_133EF = 1;

  for(var_0 = _encstr_AA252DE27B07509BA199B36DEED935D1A707F8A1F3B2CA9D9B5D527098F3EF88DB9C05F0B552D5303A035D71F8A8B3(); !self isonground() && _encstr_B29F1F117B97E2985721ADF36FFF303593628B5BD20B2EA0AD0685FF6A2548F03B() >= level._id_133F4 && (!isDefined(var_0) || var_0 >= level._encstr_9B7026DCB5978C963B567D9BC1B0EEE63827ED47ACB11D96DEB9CDC299954797912D9B1DB0B9B156); var_0 = _encstr_AA252DE27B07509BA199B36DEED935D1A707F8A1F3B2CA9D9B5D527098F3EF88DB9C05F0B552D5303A035D71F8A8B3())
    waitframe();

  self._id_133EF = undefined;
  self notify("_encstr_8D55207B7C2B72F23D79F03565EBC0AB3511578009EFF85EABBD3F3B32679019AF3D");
}

_encstr_AA252DE27B07509BA199B36DEED935D1A707F8A1F3B2CA9D9B5D527098F3EF88DB9C05F0B552D5303A035D71F8A8B3() {
  var_0 = getdvarint("_encstr_B4F631AB1EBA3176623F293B2BAAAE9041F3F047C21F20259A130B2FB3118F681D8B9A5DAC6B98EF62271B6BBFAAC030B5AE2D", 0);
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !isalive(var_3)) {
      continue;
    }
    if(!isDefined(var_3.team) || var_3.team == self.team) {
      continue;
    }
    if(var_0 && isai(var_3)) {
      continue;
    }
    if(var_3 isonground()) {
      var_4 = abs(distance(self.origin, var_3.origin));

      if(isDefined(var_1))
        var_1 = min(var_4, var_1);
      else
        var_1 = var_4;
    }
  }

  return var_1;
}

ending_winning_players_setup() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9AD523EB22BA03D465A8895340BB8D9391804C71452057DC7B08716BC0E7039789FDC1E750");
  self._id_133ED = 1;

  while(!self isonground())
    waitframe();

  self._id_133ED = undefined;
  self notify("_encstr_9AD523EB22BA03D465A8895340BB8D9391804C71452057DC7B08716BC0E7039789FDC1E750");
}

endingpropspecate() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8D55207B7C2B72F23D79F03565EBC0AB3511578009EFF85EABBD3F3B32679019AF3D");
  self._id_133EF = 1;
  self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
  self._id_133EF = undefined;
  self notify("_encstr_8D55207B7C2B72F23D79F03565EBC0AB3511578009EFF85EABBD3F3B32679019AF3D");
}

endingph() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8D55207B7C2B72F23D79F03565EBC0AB3511578009EFF85EABBD3F3B32679019AF3D");
  self._id_133F0 = 1;
  self._id_133F1 = 1;

  while(istrue(self._id_133EF)) {
    var_0 = _encstr_B29F1F117B97E2985721ADF36FFF303593628B5BD20B2EA0AD0685FF6A2548F03B();
    var_1 = level._id_133F5 - level._id_133F4;
    self._id_133F0 = clamp(var_0 / var_1, 0, 1);
    var_2 = level._id_133F3 - level._id_133F2;
    self._id_133F1 = self._id_133F0 * var_2 + level._id_133F2;
    waitframe();
  }

  self._id_133F1 = undefined;
}

_encstr_8864186AD8AF9CA7B183464DB038C76615D8C2F39063D5FF89FD(var_0) {
  return isDefined(var_0) && scripts\mp\damage::trial_vehicle_outline_id(var_0.basename);
}

endmatchcamerastriggered(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(istrue(level._id_133EF)) {
    if(istrue(var_1._id_133EF) && isDefined(self._id_133F1) && !_encstr_8864186AD8AF9CA7B183464DB038C76615D8C2F39063D5FF89FD(var_5))
      var_3 = var_3 * self._id_133F1;

    if(isDefined(var_2) && istrue(var_2._id_133ED)) {
      switch (var_4) {
        case "_encstr_B45C0E2DFF41B17F437FB870E733FBFF":
        case "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421":
        case "_encstr_911B0C7DA090E9A7F799FD50DD48":
        case "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B":
          var_3 = var_3 * level._id_133EE;
          break;
      }
    }
  }

  var_3 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::brmodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  return var_3;
}

_encstr_B29F1F117B97E2985721ADF36FFF303593628B5BD20B2EA0AD0685FF6A2548F03B() {
  var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(self.origin, 0, -100000);
  var_1 = self.origin[2] - var_0[2];
  return var_1;
}