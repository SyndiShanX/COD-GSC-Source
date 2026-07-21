/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_heavy_weapon_drop.gsc
*************************************************/

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
  var_0.destroyoncapture = 1;
  level.delaystreamtomovingplane = getdvarint("_encstr_966E2477A0F39FE22D60CA87481FAA691B588B3F482B19CB6B18933A4DB3F22423809B779083", 0) == 1;
  level.shrink_poi_into_the_bank = spawnStruct();
  level.shrink_poi_into_the_bank.besttimestate = 1;
  level.shrink_poi_into_the_bank._id_13EFF = [["_encstr_8EED1705B2A5C0B76359C8B0523BC6D0FA3D8BEF774EA85F03", 0], ["_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253", 100], ["_encstr_BAFB18C493C6F6F6D1AF9B1C56C6A58563A5B98ED7C4F673D537", 0], ["_encstr_857F1D89931BEDF6D17DEEB2B0C1DB9BD736587D4D57D8D22B47F5632B3B59", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"]];
  level.shrink_poi_into_the_bank.chopper_gunner = [["_encstr_9B4C214B5B5878B5E051A34B479B872E8F2980C9B9C8CB035ADDD29BE0DA41C26068DD", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"], ["_encstr_83A3211327D8B7EDA3FABB5985E0B773BE632CF547C9339CAC59CCA593CABE39584E59", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"], ["_encstr_A1582098E41BDBDBA3FADDAC2C83DE9BFA3786FAD816BEB6B6D2B1B798AFB21CD26C", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"]];
  level.shrink_poi_into_the_bank.waypoint_icon = [["_encstr_AFA92636E3C8C752A5273F2F59415B14C0E96EFCFE80828A76635727B778C179B093628333105342", 0], ["_encstr_B87115F542355090F3E9B923535FD7190FA95F73F95A28", 100], ["_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3", 8], ["_encstr_B4772045F2657BC0A399087092FB8690BA7DCB2FB70EA01557C3C11B0BF33EA014D5", 0]];
  level.shrink_poi_into_the_bank.waypoints = [["_encstr_852E23EA528367BA24E1CC971E130F96D19EE2A86B6FBFAB98EA2FB020936298CFB37DCF97", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_BA99272D76B02F90EC215857A7F897B2F1F311AF427D01C73530D68DCF2A02D572E7B2D0EFB18398E2", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_8B82238927367BDB1DFADDACB007ED9B7DDCA1D72C39F50DE52C736DB295680DFA63B29DCA", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"], ["_encstr_B16422B5BBB2C07BF4516339C6D8C88839178147C7CA80D839758B90EEE25AA8E2D7AF4B", "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9"], ["_encstr_AB4422D102CCD810EBCF570B4FD36898A7DA93CEEA25A15CA3276B035FAF8CC93C376101", "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9"], ["_encstr_ACB8225203C055F710DE1B02EAFB1FB8E7A7CC6866529FD8CBAA081AC7ECD68805C18027", "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9"]];
  level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911 = [["_encstr_AF491213931BDEDB477DED339934587391BE3686", 2], ["_encstr_B4C917454B4230F0E441706937D0C8F89A9723D7ABDA05281E", 2], ["_encstr_A7F5186B7A448F67735F2F9F072B617E6859A399D1552A585465", 2], ["_encstr_81D6144C4E63B7F6477D7B9933342CB9327D339358D9", 2]];
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

shut_down_station() {
  var_0 = [];
  var_1 = randomint(100);

  if(istrue(level.delaystreamtomovingplane)) {
    if(var_1 < 5) {
      var_2 = randomint(level.shrink_poi_into_the_bank._id_13EFF.size);
      var_0[0] = level.shrink_poi_into_the_bank._id_13EFF[var_2];
    } else {
      var_2 = randomint(level.shrink_poi_into_the_bank.waypoint_icon.size);
      var_0[0] = level.shrink_poi_into_the_bank.waypoint_icon[var_2];
    }

    var_2 = randomint(level.shrink_poi_into_the_bank.waypoints.size);
    var_0[1] = level.shrink_poi_into_the_bank.waypoints[var_2];
    var_2 = randomint(level.shrink_poi_into_the_bank.chopper_gunner.size);
    var_0[2] = level.shrink_poi_into_the_bank.chopper_gunner[var_2];
    var_2 = randomint(level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911.size);
    var_0[3] = level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911[var_2];

    if(istrue(level.shrink_poi_into_the_bank.besttimestate))
      var_0[4] = ["_encstr_BED616F65A021F50CCCFF0E82BFCEB914B07FF8AF94BCB3B", 0];
  } else {
    if(var_1 < 5)
      var_0[0] = ["_encstr_95EF1DE6EB6B4FB889C7F73BB7D31FA0FF28707F70744215536D17CD60C7F8", "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"];
    else if(var_1 < 10)
      var_0[0] = ["_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656", "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"];
    else {
      var_2 = randomint(level.shrink_poi_into_the_bank.waypoint_icon.size);
      var_0[0] = level.shrink_poi_into_the_bank.waypoint_icon[var_2];
    }

    var_2 = randomint(level.shrink_poi_into_the_bank.chopper_gunner.size);
    var_0[1] = level.shrink_poi_into_the_bank.chopper_gunner[var_2];
    var_2 = randomint(level.shrink_poi_into_the_bank.waypoints.size);
    var_0[2] = level.shrink_poi_into_the_bank.waypoints[var_2];
    var_2 = randomint(level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911.size);
    var_0[3] = level.shrink_poi_into_the_bank.weapon_xp_iw8_pi_mike1911[var_2];

    if(istrue(level.shrink_poi_into_the_bank.besttimestate))
      var_0[4] = ["_encstr_BED616F65A021F50CCCFF0E82BFCEB914B07FF8AF94BCB3B", 0];
  }

  var_3 = 0;
  var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();

  foreach(var_6 in var_0) {
    var_7 = var_6[0];

    if(_encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::get_bonus_targets(var_7)) {
      var_8 = level.br_pickups.delay_hide_player_clip[var_7];

      if(!var_3 && isDefined(var_8) && var_8 == 4) {
        var_9 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_7, var_4, self.origin, self.angles, 0, 1);
        var_3 = 1;
      } else
        var_9 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_7, var_4, self.origin, self.angles, 0, 0);

      if(isstring(var_6[1])) {
        var_10 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_6[1], var_4, self.origin, self.angles, 0, 0);
        var_10.count = level.br_pickups.maxcounts[var_6[1]];
      } else
        var_9.count = var_6[1];
    }
  }

  if(isDefined(level.shrink_poi_into_the_bank.beardone))
    [[level.shrink_poi_into_the_bank.beardone]](var_4, self.origin, self.angles);

  if(istrue(self._id_135B6)) {
    var_12 = spawnStruct();
    var_12.origin = self.origin;
    var_12.angles = (0, 90, 0);
    var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41("_encstr_91BA1631E41BBDB747D7B9BD58BEE0DEEEAF8CBDD9A3C2B3", var_4, var_12.origin, var_12.angles, 0, 1);
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