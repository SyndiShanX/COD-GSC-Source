/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_heavy_weapon_drop_x2.gsc
****************************************************/

init() {
  level.shutdownattractionicontrigger = [];
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_8664130DAC859DE5EBBBAC581CEDB9EB6C9385E8AC");
  var_0.capturestring = &"_encstr_AF491E6A82CB8E51E4154A4A0DAF137A3DA8F568940A5151EBD0A0058AAA94A8";
  var_0.dummymodel = "_encstr_BD94250DB3633CBBDF3BEB71E1276BF7380BBB833B30474F5F7B81AAEB106BAF28FB3E14532088";
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
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = ::signal_nag;
  var_0.capturecallback = ::signal_strength;
  var_0.destroycallback = ::signal_yaw;
  var_0.ingame = ::signalomnvar;
  var_0.destroyoncapture = 1;
  level.shrink_poi_into_the_bank = spawnStruct();
  var_1 = getdvarint("_encstr_8E5716886F9981F9DF16DBC01C4B60797172B8D8A22DE393", 0);
  level.shrink_poi_into_the_bank.equipment = remove_from_bomb_detonator_waiting_for_pick_up_array(var_1);
}

remove_from_bomb_detonator_waiting_for_pick_up_array(var_0) {
  switch (var_0) {
    case 1:
      return [["_encstr_91591A4CE463DE7BA3AF9B57C12BE4AFB6AB734B3A4BB7379B31DB3C", 8]];
    default:
      return [["_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656", 1], ["_encstr_8AC22069BA4450987347AF83D75BD073DFD6D346A3E9F0CE9AF3EBB7CB71A990BFAF", 1], ["_encstr_9A3C21335D8142DF084E43CFA183178AF0938B4FC993EA8BC8133AD6FB701FE2B5275F", 1], ["_encstr_95EF1DE6EB6B4FB889C7F73BB7D31FA0FF28707F70744215536D17CD60C7F8", 1]];
  }
}

signal_nag(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80")]](self);
  }

  level.shutdownattractionicontrigger[level.shutdownattractionicontrigger.size] = self;
}

signal_strength(var_0) {
  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  level.shutdownattractionicontrigger = scripts\engine\utility::array_remove(level.shutdownattractionicontrigger, self);
  shut_down_station();
}

signal_yaw(var_0) {
  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  level.shutdownattractionicontrigger = scripts\engine\utility::array_remove(level.shutdownattractionicontrigger, self);
}

signalomnvar(var_0, var_1) {
  self setscriptablepartstate("_encstr_9BF30C3F2099CCEA7F7793CF6B37", "_encstr_A1A107973D7982FB90", 0);
}

shut_down_station() {
  var_0 = [];
  var_1 = 0;
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

  foreach(var_4 in level.shrink_poi_into_the_bank.equipment) {
    var_5 = var_4[0];
    var_6 = var_4[1];

    if(_encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::get_bonus_targets(var_5)) {
      for(var_7 = 0; var_7 < var_6; var_7++)
        var_8 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_5, var_2, self.origin, self.angles, 0, 1);
    }
  }
}

shut_down_laser_trap() {
  playFX(level.conf_fx["_encstr_8BE007AB0FE8607F9B"], self.origin);

  if(isDefined(self._id_13428)) {
    self._id_13428 setscriptablepartstate("_encstr_A9A80DCBFDC7F01D417713076BCAD1", "_encstr_BA19049F4B2D", 0);
    self._id_13428 delete();
  }

  level.shutdownattractionicontrigger = scripts\engine\utility::array_remove(level.shutdownattractionicontrigger, self);
  scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}