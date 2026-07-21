/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_rebirth_reverse.gsc
********************************************************/

init() {
  level thread enabledfeatures();
  level thread enabledskipdeathshield();
  level thread enable_traversals_for_bombers();
  level thread enabledbasejumping();
  setdvarifuninitialized("_encstr_814C1EC39F0690B6AB1620C5A0F0635D49912362BB5BAC7D4966ED9381E00D17", 0);
  setDvar("_encstr_8C4614CDD8C9EB269CD783397BA95636E87D6DB4D8D6", 1500);
  var_0 = getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD");

  if(scripts\cp_mp\utility\game_utility::tutorialzoneenter()) {
    timeoutonabandoneddelay("_encstr_8F94215B8379B1D858B9B93A2C89B1ACBE9827FAC95913969CE843F5EEEE91E2B19B9D");
    timeoutonabandoneddelay("_encstr_977A29651B75465AA1E798C01959937DDFCAE0773359A51A66B3E317C028C0BAF18F438E97AF4F887AAF94");
    timeoutonabandoneddelay("_encstr_99A229B5385EB1D816DCB98EB013B195AF89C9BEC92B13A59CE8A1BE1B5A27C61B9566FAEEDD23178D9B67");
  } else if(var_0 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95") {
    timeoutonabandoneddelay("_encstr_827F21A00BB6B660A68B1701814EA80DCF82DB6E53F77E70BA64295FAC36B060D70BD3");
    timeoutonabandoneddelay("_encstr_8A66295B1C7936C6C2B9DC472C31D8957D984E7DC9AC13B49C1D86F58DB427B11BB291BE2389321736B99D");
    timeoutonabandoneddelay("_encstr_A6DF29D61C5EB1B116B937D1C2C48D95D798C97D27CA98D2C9D1A1FAB12D9C8D1BB2CCFA32C4C8C56C6E3B");
  } else {
    timeoutonabandoneddelay("_encstr_B87E1DB06A7646345FE31F9CA7692D5201FDB3A9E6B2CE4C188CE2F04E2A0C");
    timeoutonabandoneddelay("_encstr_964F25B60E79B136169BE61D8598C62BBE989CF5272B985A4E8E1AFA8D969CD8B1AC2371D86E3B");
    timeoutonabandoneddelay("_encstr_B64125D9729EAFE80197C8E8C75AA0EBE19ECE484A9275B0FAA318B9A779BB1F7AC7E648E62B15");
  }

  level.disable_super_in_turret._id_140A3 = getdvarint("_encstr_B80E19A3F7137E409A77658347EFACDBEF0E227543A7BB2527807B", 1);
  level.disable_super_in_turret._id_140A5 = getdvarint("_encstr_86AB15CD3639FA4C39BED5E62BEB3BAC379D592C376CCA", 1);
  level.disable_super_in_turret._id_1428B = getdvarint("_encstr_81BA1EDE0BA386B5EA8930A0724763997BB36D4075DF89871682B0691A9C3970", 0);
  level.disable_super_in_turret._id_140A6 = getdvarint("_encstr_A7252C37C6E4AF4C27EB57E6AC7D9D56CD76AC1637D859AFC8951B9C590BE6B2F527B237E02C77B9D73A5AD62BE4", 1);
  level.disable_super_in_turret._id_14094 = getdvarint("_encstr_BE031912A15897E2860767676B38ABE5E86B0E9BF8D967EADC1B77", 0);
  level.disable_super_in_turret._id_1408D = getdvarint("_encstr_B22D29B812BA9761FB6785FE35276BAF246A383049D33F1EC34505F50B17765D8FC3903823ED273347659D", 1);
  level._id_12CA7 = getdvarint("_encstr_AC901E8F42F251C16B28E762A5F64079AF1E84399B1FC37398E40A3BAA4BCABD", 7500);
  level.disable_super_in_turret._id_12C92 = getdvarint("_encstr_8C0D3402B14887F2F6770B2F7513BBE4C09EFA0F2BB0417BC05F071347C5A22CD1E3B69423711863AD1F03634BE7FA69A049A11FD8C0", 0);
  level.disable_super_in_turret._id_12C91 = getdvarint("_encstr_966733B3069219D6CB8F1DCB8382268850911BC9AAF8901422A717D99F6B6150CF352063545698D8AB132BF5EB32BD419B0A699B3D", 1);
}

enabledfeatures() {
  if(getdvarint("_encstr_BA6C153318E52973BB409A85E6E00BAB7961CA2A78B39F", 0) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");

  if(getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) != 0) {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A5D50F0ED8C2DC9535E616E051F6F4D312");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_A92C15EAC13B1A65AF90871768635B829B7636673B4B83");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC");
  }
}

enabledskipdeathshield() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_85DC0CB2A8BE0795B831C9C57B28", ::circletimer);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846", ::empty_function);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8106123B24BF78D3DBDC083511D5719BA1AE6345", ::_encstr_87C61C432DFE92A2F0FBB3BC7610E46AD3AB9BEFE329CA9DC0A3AAC66B18);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8F351F39D6AB5F8FECFFB840AB1923CBF27CA1B36DF23911CCAF0839EF5C98339A", ::end_escape_silo);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2", ::end_silo_thrust);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C", ::end_intro_obj);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9556123CF5431D5307B2ABD0FBD50FF17B97BD2D", ::enable_spawner);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AB6E121F8B384F1A31424C9F0D0802380EE3B392", ::enablejuggernautcrateobjective);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_85DB1892EB3E2F57E001C1DB5921DB57E861E84B939FCF8C4065", ::empdrone_killstreaktargetthink);

  if(!istrue(level.tryupdategenericprogress))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::end_game_tutorial_func);

  if(getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) != 0) {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3", ::enable_leaderboard);
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_B1130F58C89145BD6813990CA473335A36", ::emp_target_monitor);
    thread end_nuke_vault();
  }

  waittillframeend;

  if(level.disable_super_in_turret._id_1408D)
    level._id_12073 = ::end_game_win;

  level.ontimelimit = ::end_gates;
  enable_keypad_interaction();
  level._id_140D9 = [];
  level._id_140D9[0] = "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0";
  level._id_140D9[1] = "_encstr_A1580B19DE5B5A9B0BA35AEDCD";
  level._id_140D9[2] = "_encstr_AF460A7B2649F34FE367455D";
  _encstr_85592F474FBE12F0D81BA53D532A2F2A99EBC3E7116DFB97B0C3A18228E07462EC73E7BBBD805395D02B248DE072BF9BCE::init();
  tomastrike_findoptimallaunchpos();
  thread end_paratroopers_group();
  thread end_reach_exhaust_waste();
  thread end_reach_icbm_launch();
  thread end_origin_final();
  thread end_pipe_room();
  thread enabledminimapdisable();
  scripts\mp\rank::_id_12189("_encstr_ABD70578F3D02C", 100);
  scripts\mp\rank::_id_12189("_encstr_93D50D50754757B91858A1848079C8", 200);
}

enable_traversals_for_bombers() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_970E16454B71B5C0F18D704979D1B07B9B4F3BD1BF8B8D70");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_827F0CA01ADBB640298B192B92CB"] = "_encstr_8D7E1429D2770D18E8C0631FEAD718CDA32AE1F01A8F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2140B22D9CD77E4F9C1756BE7"] = "_encstr_B1CF1E9D58B62BD1E5072BF5C8566E1BAF9CACE6ABC93B59371BACBEE6DEC6BD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84A0116030A58FCA831B2E186558091BD878D0"] = "_encstr_84A0116030A58FCA831B2E186558091BD878D0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9571117507B22308D4BC4639E4BBD8EE2A6FC1"] = "_encstr_82C61F5B5BBE1AFA2070A1F2C9103E2280CD979F235532B4511924BA612074AAED";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC030F2243FA28039C50BE0573D1B0BD47"] = "_encstr_8A4A1D9C2B265A4ED186BE93B2B4DC667B39B1CAADCA9BE8BEB2DC912DCDEC";
}

enabledminimapdisable() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      var_1._id_12CA1 = 0;
  }
}

enable_keypad_interaction() {
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_920D1AA7081FE397C3407F2F90385F3AD3112D91E1A33BF12841672B", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_B49F18FD153A2D2EB707C88837F6666162FDE571E1F2F116D816", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_99291CC83F37405922F7696D37AA17D09F5630E22963800E1AF7912F6AD7", 1);
}

enabledbasejumping() {}

end_paratroopers_group() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.disable_super_in_turret._id_12CA4 = 1;
}

end_reach_exhaust_waste() {
  waittillframeend;
  var_0 = level.allteamnamelist;

  foreach(var_3, var_2 in var_0)
  level.teamdata[var_2]["_encstr_B48F06CC58B0F50B"] = var_3;

  var_4 = getdvarint("_encstr_9792258703C2A1669BB9CB7322A7AA381FA70113A9ED3820E39203DE4ABBDD8032F5CFB9555680", 0);

  if(istrue(var_4)) {
    foreach(var_6, var_2 in level.teamdata)
    level.teamdata[var_6]["_encstr_BA590D3AC9586C5BAC19515616B6E6"] = [];
  } else {
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

    foreach(var_8 in level.players)
    var_8._id_13C4B = [];
  }
}

end_reach_icbm_launch() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1._id_1443B = [];
  }
}

end_gates() {
  if(isDefined(level.numendgame))
    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::startendgame(1);

  level.numendgame = undefined;
}

empty_function(var_0) {
  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    if(istrue(level.disable_super_in_turret._id_12CA4)) {
      if(!isDefined(var_0._id_12CA1))
        var_0._id_12CA1 = 0;

      if(var_0._id_12CA1 <= 0) {
        var_0._encstr_AFD20F22358BD8278398772542B8F0B745 = 1;
        return 0;
      }
    }

    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11B15(var_0);
    var_0 _encstr_99FC22AE7BA0550A93C5CBB3B7CB628CF083E736B0180CE276F3EFCB336C5AD4C8C81FBA();
    var_0 notify("_encstr_B4BE0C6E5CEAB091BEDDB483B232");
  }

  return 1;
}

end_escape_silo() {
  var_0 = int(min(level.br_circle.circleindex, level.disable_super_in_turret._id_12CA1.size - 1));
  var_1 = isDefined(self._id_12CA1) && self._id_12CA1 > 0 && self._id_12CA1 < level.disable_super_in_turret._id_12CA1[var_0];
  return scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && (var_1 || !istrue(level.disable_super_in_turret._id_12CA4));
}

end_freight_lift(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B")) {
    if(!istrue(var_2.shouldgamelobbyremainintact) && isalive(var_2) && var_0 != var_2) {
      var_2.shouldgamelobbyremainintact = 1;
      var_2 thread scripts\mp\hud_message::showsplash("_encstr_87DA165A72410BFFDE9C52618A911CE36BBB9869ECC397D8");
    }
  }
}

end_health() {
  if(!isDefined(self.endgame_finitewaves_music))
    self.endgame_finitewaves_music = 0;

  var_0 = self.endgame_finitewaves_music;

  if(var_0 > 255)
    var_0 = 255;

  self.extrascore0 = var_0;
  self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"] = var_0;
  return var_0;
}

end_trans_1_obj(var_0, var_1) {
  var_2 = !istrue(level.teamdata[self.team]["_encstr_ADC01314AB683D4BDFF91812C32E733A9025B19E33"]);

  if(var_2)
    level.teamdata[self.team]["_encstr_ADC01314AB683D4BDFF91812C32E733A9025B19E33"] = 1;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.endgame_finitewaves_music))
      var_4.endgame_finitewaves_music = 0;

    var_4.endgame_finitewaves_music++;
    var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_8AC70C0AB3C8245B35E562CB6895", var_4.endgame_finitewaves_music);
    var_4 end_health();
    var_5 = !isDefined(var_1) || var_4 != var_1;
    var_6 = var_2 && var_5;

    if(var_6)
      var_4 thread scripts\mp\hud_message::showsplash("_encstr_8C3018314EBE9C5926B4C93AD0EB335A39B9E8FA4EAC9D5A3B95");
  }
}

enablejuggernautcrateobjective(var_0, var_1) {
  var_2 = self;
  var_2 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergulagautowin(var_0, var_1);
  var_2 end_trans_1_obj(level.teamdata[var_2.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"], var_0);
  return;
}

end_game_tutorial_func(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  _id_121E7(var_0);

  if(level.gameended) {
    return;
  }
  if(!isDefined(var_0.victim)) {
    return;
  }
  thread end_freight_lift(var_0.victim);

  if(!isDefined(var_0.victim._id_1443B))
    var_0.victim._id_1443B = [];

  if(!scripts\engine\utility::array_contains(var_0.victim._id_1443B, var_0.attacker))
    scripts\engine\utility::array_add(var_0.victim._id_1443B, var_0.attacker);

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || var_0.attacker == var_0.victim) {
    return;
  }
  var_0.attacker thread endcameradebug_think(var_0.victim);
  var_0.attacker thread endcameraorigins(var_0.victim);
  var_0.attacker thread endcameraangles(var_0.victim);
}

endcameraangles(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!level.disable_super_in_turret._id_140A5) {
    return;
  }
  if(!istrue(level.disable_super_in_turret._id_12CA4)) {
    return;
  }
  empendearly(var_0);
}

empendearly(var_0) {
  if(self._id_12CA1 <= 0) {
    return;
  }
  if(!isDefined(self._id_1443B))
    self._id_1443B = [];

  if(isDefined(self._id_1443B) && scripts\engine\utility::array_contains(self._id_1443B, var_0)) {
    if(istrue(level.disable_super_in_turret._id_140A6)) {
      self._id_12CA1 = self._id_12CA1 - getdvarint("_encstr_A52A283380A271124E783BD240E7B767A5906060080F76B68B7FFB9AE0BB1B96D201E4F33F9CAFB39B5F", 5);
      _encstr_8FAC2EC25872378811BB8B13F7B6CD656AA158EBE86061AA41B38FB957A5D9A4BFEB08F3E7B0B74F369BB7D7E6F97A0F();
      wait 1;
      _encstr_BD3A30586BD29B19FF125D5B274B217FFFF350F8C2ACED93933AEDCEE02F2B3DE38A50705B030B289755E748CB4731F10EF2();
    }

    scripts\engine\utility::array_remove(self._id_1443B, var_0);
    thread scripts\mp\events::killeventtextpopup("_encstr_BD8215895A97587DF27F050153093C384EF79161C513A8", 0, 0);
  }
}

endcameraorigins(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B4BE0C6E5CEAB091BEDDB483B232");

  if(!level.disable_super_in_turret._id_140A3) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_0 waittill("_encstr_8F1D0DDA15CB63C677E079C27BAD3F");
  end_silo_jump(self.team, var_0.team);
}

endcameradebug_think(var_0) {
  var_1 = self;

  if(istrue(var_0.delay_enter_combat_after_investigating_grenade)) {
    var_1 thread scripts\mp\events::killeventtextpopup("_encstr_BEE80CA7409955ABFFFC144AEDA1", 0);
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BEE80CA7409955ABFFFC144AEDA1", var_1._id_145D0);
    var_1 thread endac130infilanimsinternal(var_0);
  }
}

endac130infilanimsinternal(var_0) {
  var_1 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::brchooselaststandweapon();
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AD0(var_0, self, var_1);
  var_2 = [];

  if(!isDefined(var_2[self.team])) {
    var_2[self.team] = 1;
    self playsoundtoteam("_encstr_B6E114A3992028835FD71F07FBB849C93F5BE431C330", self.team);
  }
}

play_track_damage_screen_vfx(var_0) {
  var_1 = -1;
  var_2 = 2147483647;

  foreach(var_5, var_4 in var_0) {
    if(var_4["_encstr_A1110A38E3FE4D23E3D10975"] < var_2) {
      var_1 = var_5;
      var_2 = var_4["_encstr_A1110A38E3FE4D23E3D10975"];
    }
  }

  return var_1;
}

getteamindex(var_0) {
  return level.teamdata[var_0]["_encstr_B48F06CC58B0F50B"];
}

start_reach_pipe_room(var_0, var_1) {
  var_2 = -1;

  foreach(var_5, var_4 in var_0) {
    if(var_4["_encstr_84BA05A8CA852B"] == var_1) {
      var_2 = var_5;
      break;
    }
  }

  return var_2;
}

_id_14023(var_0, var_1, var_2) {
  var_3 = int(pow(2, 8));
  var_4 = 8 * var_2;
  var_5 = var_3 - 1;
  var_5 = var_5 << var_4;
  var_6 = ~var_5;
  var_0 = var_0 &var_6;
  var_7 = var_1 << var_4;
  var_0 = var_0 | var_7;
  return var_0;
}

_id_14029(var_0, var_1, var_2) {
  var_3 = -1;

  foreach(var_5 in var_0) {
    if(isDefined(var_5)) {
      if(var_3 < 0) {
        var_3 = var_5 calloutmarkerping_entityzoffset("_encstr_BD6A162645AB08CD33B2C1E06B0EA76DEFEC389DDD4F7017");
        var_3 = _id_14023(var_3, var_1, var_2);
      }

      var_5 setclientomnvar("_encstr_BD6A162645AB08CD33B2C1E06B0EA76DEFEC389DDD4F7017", var_3);
    }
  }
}

run_lbravo_spawner() {
  var_0 = getdvarint("_encstr_9792258703C2A1669BB9CB7322A7AA381FA70113A9ED3820E39203DE4ABBDD8032F5CFB9555680", 0);
  var_1 = [];

  if(istrue(var_0))
    var_1 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_BA590D3AC9586C5BAC19515616B6E6");
  else {
    if(!isDefined(self._id_13C4B))
      self._id_13C4B = [];

    var_1 = self._id_13C4B;
  }

  return var_1;
}

end_silo_jump(var_0, var_1) {
  var_2 = -1;
  var_3 = run_lbravo_spawner();
  var_2 = start_reach_pipe_room(var_3, var_1);

  if(var_2 < 0) {
    if(var_3.size == 4)
      var_2 = play_track_damage_screen_vfx(var_3);
    else
      var_2 = var_3.size;
  }

  if(var_2 < 0 || var_2 >= 4) {
    return;
  }
  thread end_silo_elevator(var_0, var_1, var_2);
}

end_silo_elevator(var_0, var_1, var_2) {
  if(var_2 < 0 || var_2 >= 4) {
    return;
  }
  var_3 = "_encstr_93BA0A0B03FFDF8CF9AB091D" + var_0 + var_2;
  var_4 = [];
  var_5 = [];
  var_5["_encstr_84BA05A8CA852B"] = var_1;
  var_5["_encstr_A1110A38E3FE4D23E3D10975"] = gettime();
  var_6 = getdvarint("_encstr_9792258703C2A1669BB9CB7322A7AA381FA70113A9ED3820E39203DE4ABBDD8032F5CFB9555680", 0);

  if(istrue(var_6)) {
    level notify(var_3);
    level endon(var_3);
    level.teamdata[var_0]["_encstr_BA590D3AC9586C5BAC19515616B6E6"][var_2] = var_5;
    var_4 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");
  } else {
    self notify(var_3);
    self endon(var_3);
    self._id_13C4B[var_2] = var_5;
    var_4 = [self];
  }

  var_7 = getteamindex(var_1);
  _id_14029(var_4, var_7, var_2);
  var_8 = getdvarfloat("_encstr_AF9721961B1B272D723953B003E25895D87754C7F655CB871768550203A9CD876B302B", 2.5);
  wait(var_8);
  var_4 = scripts\engine\utility::array_removeundefined(var_4);
  _id_14029(var_4, 0, var_2);
}

end_origin_final() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) == 0)
    level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");

  var_0 = rocket_attack_min_cooldown();
  var_1 = 0;

  if(getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0))
    var_1 = 1;

  for(var_2 = 0; var_2 < var_0; var_2++)
    var_1 = var_1 + (level.br_level.br_circleclosetimes[var_2] + level.br_level.br_circledelaytimes[var_2]);

  var_3 = int(var_1 * 1000);
  var_4 = gettime();
  var_5 = var_4 + var_3;
  setomnvarforallclients("_encstr_AB2C1FAB5C571836E1DBF9C38B7AF5C03F37720302D1D8ED1997C5F93723CBF0DD", var_5);
  level.ally_movement_defend_0 = var_1;
  var_6 = var_3;
  var_7 = getdvarint("_encstr_B446326FE67397158A277D91957A6EB088B7960112FF705A2BDB28F91B6D69C00412AB98200124C818E37DC7A21F503F3B8FC331", 90000);
  thread end_mine_caves(var_6 / 1000);

  while(var_6 > var_7) {
    wait((var_6 - var_7) / 1000);
    var_8 = gettime() - var_4;
    var_6 = var_3 - var_8;
  }

  setomnvarforallclients("_encstr_AB2C1FAB5C571836E1DBF9C38B7AF5C03F37720302D1D8ED1997C5F93723CBF0DD", int(gettime() + var_6));

  foreach(var_10 in level.players) {
    if(!isDefined(var_10)) {
      continue;
    }
    var_10 thread scripts\mp\hud_message::showsplash("_encstr_A1EA21D00B9FF37392F49EA58C7965D901E37840E37BA92B8A5D9538A6A29743794BE8");
  }
}

end_mine_caves(var_0) {
  wait(var_0 - 90);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AC030F2243FA28039C50BE0573D1B0BD47");
}

end_pipe_room() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.disable_super_in_turret._id_12CA1 = [];
  level.disable_super_in_turret._id_14093 = getdvarint("_encstr_A6F124237A83E850A267DBCF45C1984D3FE3F92B52DFBD507D31CB9F78B7401817EA1351DA6F", 1);

  if(level.disable_super_in_turret._id_14093) {
    var_0 = rocket_attack_min_cooldown();

    for(var_1 = 0; var_1 < var_0; var_1++)
      level.disable_super_in_turret._id_12CA1[var_1] = getdvarint("_encstr_B25D2420F94B610ED53F93CADE19088BC149AA79B32321839AC7D4CD29E7AF5F37F0061E5A9F" + (var_1 + 1), 30);
  } else
    level.disable_super_in_turret._id_12CA1[0] = getdvarint("_encstr_A61B1D88266379210DCF6BA536AFEB3B017102D5D25B490FF8F68DBDB581FA", 30);
}

_encstr_99FC22AE7BA0550A93C5CBB3B7CB628CF083E736B0180CE276F3EFCB336C5AD4C8C81FBA() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6");
  var_1 = var_0 &~16384;
  self setclientomnvar("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6", var_1);
}

_encstr_81B4229636F5427A30B0FB93C12B38AA874EDF0E135D8B88BB20EFFB5883E6E31369A782() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6");
  var_1 = var_0 | 16384;
  self setclientomnvar("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6", var_1);
}

_encstr_8FAC2EC25872378811BB8B13F7B6CD656AA158EBE86061AA41B38FB957A5D9A4BFEB08F3E7B0B74F369BB7D7E6F97A0F() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6");
  var_1 = var_0 | 32768;
  self setclientomnvar("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6", var_1);
}

_encstr_BD3A30586BD29B19FF125D5B274B217FFFF350F8C2ACED93933AEDCEE02F2B3DE38A50705B030B289755E748CB4731F10EF2() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6");
  var_1 = var_0 &~32768;
  self setclientomnvar("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6", var_1);
}

_encstr_978026314EE4B213D227D143F59B593AC995985A4E1D4393CADCC12CBBE6E82DD659399D161BD559(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6");
  var_2 = var_1 &~16383;
  var_3 = var_2 | var_0;
  self setclientomnvar("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6", var_3);
}

_encstr_8C0A2B1A9DE8270B33C3D31A4E162FDB402B9269F5802C83ED1B8BB253E0235440831AEC63A8F3970C7142FB79(var_0) {
  var_1 = self calloutmarkerping_entityzoffset("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6");
  var_2 = var_1 &~2147418112;
  var_3 = var_1 & 1073741824;

  if(var_3 != 0)
    var_3 = 0;
  else
    var_3 = 1073741824;

  var_4 = var_2 | var_0 << 16 | var_3;
  self setclientomnvar("_encstr_8CE81CD5A5BE4E591396393A3492566E1C85EE73A25AD6959CFACDBD36F6", var_4);
}

carriable_init(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1) {
    var_4 = var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal();
    var_5 = isalive(var_3) && !istrue(var_3.inlaststand);

    if(var_3 != var_0 && var_5 && !var_4)
      return 1;
  }

  return 0;
}

end_ml_p3_exfil() {
  var_0 = self;

  if(!isDefined(var_0.gulaguses) || var_0.gulaguses == 0) {
    var_0 end_trans_1_obj(level.teamdata[var_0.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]);
    var_0 scripts\mp\playerlogic::addtoalivecount();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(var_0);
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::dynamic_door(var_0);
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::entergulag(var_0);
    self.waitingtospawn = 0;
  }
}

_id_121E7(var_0) {
  if(!isDefined(var_0.victim) || !isDefined(var_0.attacker)) {
    return;
  }
  if(var_0.victim == var_0.attacker || !isPlayer(var_0.attacker)) {
    return;
  }
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.victim.team, "_encstr_8A2A0B936CCCC3078547970A8B");

  if(var_1 == 0)
    var_0.attacker scripts\cp\vehicles\vehicle_compass_cp::_id_12004("_encstr_AAFC07F3495FF46B09");
}

end_game_win(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  if(isDefined(var_2) && isDefined(var_3) && var_2 == "_encstr_88860C1327D7D62DEDCD6D2457CB" && var_3 == "_encstr_8C910FAE02697139F13F79E8E71E70BD12") {
    var_4 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_8A2A0B936CCCC3078547970A8B");
    var_5 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_AB580A05672AE35D5FFF50B8");
    var_6 = var_5 - var_4;

    if(var_6 == 1)
      return;
  }

  var_7 = getdvarfloat("_encstr_AB1B269B2F78397BCE16235A59ABE32B43EF101F53E0BB77606B0AE143F5EFA5E871878ADB98043F", 0.02);
  var_8 = getdvarint("_encstr_B4D52DB9364EAF31E4EB932B13A54ED143BEE07B5ACD8ECDAFD1EDBE99D2C937A3F5DC5936DEE646D7F63399DCACE8", 50);
  var_9 = int(floor((var_1 + var_8) * var_7));

  if(isDefined(var_2)) {
    if(var_2 == "_encstr_88860C1327D7D62DEDCD6D2457CB") {
      var_10 = getdvarfloat("_encstr_A34830F3AA53388012D765B3123CC875E3C12BF8924BE55061D457CF2B6738B0538A46E0FAF79E5809DA7B9B1F8AE0853792", 0.3);
      var_9 = int(ceil(var_9 * var_10));
    } else if(var_2 == "_encstr_ABD70578F3D02C")
      var_9 = int(floor((250 + var_8) * var_7));
    else if(var_2 == "_encstr_93D50D50754757B91858A1848079C8")
      var_9 = int(floor((100 + var_8) * var_7));
  }

  if(var_9 <= 0) {
    return;
  }
  if(isDefined(var_0._id_12CA1) && var_0._id_12CA1 > 0) {
    var_0._id_12CA1 = int(max(0, var_0._id_12CA1 - var_9));

    if(!isDefined(var_0._id_12CA3))
      var_0._id_12CA3 = 0;

    var_0._id_12CA3 = var_0._id_12CA3 + var_9;
  }
}

endgame_camera() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B4BE0C6E5CEAB091BEDDB483B232");
  var_0 endon("_encstr_A7A811E456E61C16DDCDAF912DB958C4C62B19");

  while(var_0._id_12CA1 > 0) {
    if(var_0._id_12CA1 <= 5)
      var_0 playsoundtoplayer("_encstr_8A8D238BC791D1E82FEAD1EBD3EA981D5A4713572B9AA9183A895B23FEB27845334FB7BB1F", var_0);
    else if(var_0._id_12CA1 <= 10)
      var_0 playsoundtoplayer("_encstr_92D72073F141F8B7F7A3D11B3BABE460A553EBAF74B4B0757B69884192A3B098BFAB", var_0);
    else if(var_0._id_12CA1 % 4 == 2)
      var_0 playsoundtoplayer("_encstr_A18617FB6AE168EBEF73E3B7D578588070B74D1773C0F85F03", var_0);
    else
      var_0 playsoundtoplayer("_encstr_A1371CCF9AA79AE969DAF97E05722C0F68A789B8D5B872FDCA9FA39B6AC0", var_0);

    var_0 _encstr_978026314EE4B213D227D143F59B593AC995985A4E1D4393CADCC12CBBE6E82DD659399D161BD559(var_0._id_12CA1);
    var_0 _encstr_8C0A2B1A9DE8270B33C3D31A4E162FDB402B9269F5802C83ED1B8BB253E0235440831AEC63A8F3970C7142FB79(var_0._id_12CA3);
    var_0._id_12CA3 = 0;
    wait 1;
    var_0._id_12CA1--;
  }

  var_0 _encstr_99FC22AE7BA0550A93C5CBB3B7CB628CF083E736B0180CE276F3EFCB336C5AD4C8C81FBA();
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_880E1A19A2C02AE3E097B2DBC08F4AAF8F42F0A7A8FFA968536870F9");
}

end_wave_spawn_ahead_of_completion() {
  if(!istrue(level.disable_super_in_turret._id_12CA4)) {
    return;
  }
  var_0 = self;
  var_0 endon("_encstr_B4BE0C6E5CEAB091BEDDB483B232");
  var_0 endon("_encstr_A7A811E456E61C16DDCDAF912DB958C4C62B19");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(getdvarint("_encstr_9AD41CEB26DBEF166D795B2278B3CA9B300D457C4FC2E75B7B08A3FA70F3", 0) != 0)
    var_0._id_12CA1 = getdvarint("_encstr_9AD41CEB26DBEF166D795B2278B3CA9B300D457C4FC2E75B7B08A3FA70F3", 0);
  else {
    var_1 = int(min(level.br_circle.circleindex, level.disable_super_in_turret._id_12CA1.size - 1));
    var_0._id_12CA1 = level.disable_super_in_turret._id_12CA1[var_1];
  }

  self waittill("_encstr_8F1D0DDA15CB63C677E079C27BAD3F");
  var_0 _encstr_978026314EE4B213D227D143F59B593AC995985A4E1D4393CADCC12CBBE6E82DD659399D161BD559(var_0._id_12CA1);
  var_0 _encstr_81B4229636F5427A30B0FB93C12B38AA874EDF0E135D8B88BB20EFFB5883E6E31369A782();
  var_0._id_12CA3 = 0;

  while(!self isonground())
    waitframe();

  var_0 thread endgame_camera();
}

_encstr_87C61C432DFE92A2F0FBB3BC7610E46AD3AB9BEFE329CA9DC0A3AAC66B18(var_0, var_1) {
  if(!istrue(level.br_prematchstarted))
    return undefined;

  var_2 = self;

  if(istrue(var_2._encstr_AFD20F22358BD8278398772542B8F0B745)) {
    var_2.alreadyaddedtoalivecount = 1;
    var_2 thread enable_oob_immunity_on_riders();
    var_2 thread end_wave_spawn_ahead_of_completion();
  } else
    var_0.victim thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_0, var_1);

  var_2._encstr_AFD20F22358BD8278398772542B8F0B745 = undefined;
  return 1;
}

enable_oob_immunity_on_riders() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_AA180D46F62D73ECA456371C58BBDC");

  if(istrue(level.disable_super_in_turret._id_12C91))
    var_0 notify("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");

  var_1 = 0;

  if(istrue(level.disable_super_in_turret._id_12C92))
    var_1 = var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126E8();

  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::relic_nuketimer_gettimeformission() / 1000;
  var_3 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE(0, var_2);

  if(level.br_circle.circleindex < 2) {
    var_4 = getclosestpointonnavmesh(var_3.origin);
    var_5 = getdvarint("_encstr_92AE206A264B0969CE2F3B33F05BB0C320893A750328BA4F2569EB2D53D3F0ABA833", 2500);

    if(distance2d(var_4, var_3.origin) > var_5) {
      var_6 = getrandomnavpoint(var_4, randomfloat(var_5));
      var_3.origin = (var_6[0], var_6[1], var_3.origin[2]);
    }
  }

  if(isDefined(self.lastdeathpos)) {
    var_5 = getdvarint("_encstr_92AE206A264B0969CE2F3B33F05BB0C320893A750328BA4F2569EB2D53D3F0ABA833", 2500);
    var_7 = var_5 * var_5;

    if(distance2dsquared(self.lastdeathpos, var_3.origin) > var_7) {
      var_8 = var_3.origin - self.lastdeathpos;
      var_8 = vectorNormalize(var_8);
      var_8 = (var_8[0] * var_5, var_8[1] * var_5, var_8[2]);
      var_6 = (self.lastdeathpos[0] + var_8[0], self.lastdeathpos[1] + var_8[1], var_8[2]);
      var_6 = getclosestpointonnavmesh(var_6);
      var_3.origin = (var_6[0], var_6[1], var_3.origin[2]);
    }
  }

  if(!_encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::set_relic_rocket_kill_ammo(var_3.origin, var_2)) {
    var_9 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
    var_10 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
    var_8 = var_3.origin - var_9;
    var_8 = vectorNormalize(var_8);
    var_8 = (var_8[0] * var_10, var_8[1] * var_10, var_8[2]);
    var_6 = var_9 + var_8;
    var_3.origin = (var_6[0], var_6[1], var_3.origin[2]);
  }

  var_11 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_3);
  self.forcespawnorigin = var_11;

  if(var_1)
    var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  var_12 = 1.0;
  var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  wait(var_12);
  var_0 _encstr_81B4229636F5427A30B0FB93C12B38AA874EDF0E135D8B88BB20EFFB5883E6E31369A782();
  var_0 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
  var_0 scripts\mp\playerlogic::spawnplayer(undefined, 0);
  var_0 scripts\cp_mp\execution::_clearexecution();
  var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();
  var_0 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
  var_0.respawningfromtoken = undefined;
  var_0 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_13DCB(20);
  var_0 end_loop_emp_spark_vfx(var_3, var_11);
}

end_silo_thrust() {
  wait 0.5;
  return 1;
}

end_loop_emp_spark_vfx(var_0, var_1) {
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");

  if(isDefined(self.oobimmunity))
    scripts\mp\outofbounds::disableoobimmunity(self);

  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptednode(self);
  _id_12A7D();

  if(!isDefined(var_0))
    var_0 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();

  var_2 = var_0.origin;
  var_3 = var_0.angles;
  var_4 = var_2;

  if(isDefined(var_1))
    var_4 = var_1;

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::set_scriptable_states();
  self setOrigin(var_4, 1);
  self setplayerangles(var_3);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5.angles = var_3;
  var_5 hide();
  var_5 showtoplayer(self);
  self playerlinktoabsolute(var_5, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playerhide();
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12524(var_5);
  waitframe();
  _id_1264E();

  if(getdvarint("_encstr_A69D166B46DACF52A7B74FD7339D037227F39329CA20A30A", 1) == 0)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();

  if(isDefined(var_1))
    var_5.origin = var_2;

  var_5 playsoundtoplayer("_encstr_85E90F214B17D778126B31F7262DE02EF7", self);
  wait 1.5;
  self unlink();
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    self clearsoundsubmix("_encstr_AC6F16A09BE04FB9335FB4B574A7C1875B03C008A3CC6B30", 2);
  else
    self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);

  self clearclienttriggeraudiozone(1);
  self playershow();
  _id_12677(1);
  var_6 = 0;

  if(isDefined(level._id_121CC))
    var_6 = level._id_121CC;

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
    thread scripts\cp_mp\parachute::startfreefall(var_6, 0, undefined, undefined, 1);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12C7A();
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12072();
  _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::_id_12072();
  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12523();

  waitframe();
  var_5 delete();

  if(istrue(level._id_133EF))
    _encstr_85592F474FBE12F0D81BA53D532A2F2A99EBC3E7116DFB97B0C3A18228E07462EC73E7BBBD805395D02B248DE072BF9BCE::toma_strike_munitionused(1);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    self notify("_encstr_B18313686F8BFB339B7D70E452326346C747E078FF");

  self notify("_encstr_978F121A20F5F1EF10A0675746FB5B863780E293");

  if(istrue(level.disable_super_in_turret._id_12CA4)) {
    if(!istrue(level.stage))
      thread scripts\mp\hud_message::showsplash("_encstr_A12F1470AB3F139372147E052CD9C5B96C6F68B877C1", 20);

    if(!istrue(self.player_deposited_heli)) {
      thread scripts\mp\hud_message::showsplash("_encstr_A9EF1D96BE59B32DD2F4FDD9C0EF90A54303396BE37F97973B60434A48B0BA");
      self.player_deposited_heli = 1;
    }
  } else
    _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader(self, "_encstr_A7A811E456E61C16DDCDAF912DB958C4C62B19", undefined, 2);

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_84A0116030A58FCA831B2E186558091BD878D0", self);
  self notify("_encstr_8F1D0DDA15CB63C677E079C27BAD3F");
}

_id_1264E() {
  self notify("_encstr_82D10F60A26E2BB3D36026A553EB19AFD5");
  self.health = self.maxhealth;
  scripts\mp\healthoverlay::onexitdeathsdoor(1);
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A1500D40B22258CE7B07674D3F421C", 0);
}

_id_12A7D() {
  if(isDefined(level.deletescriptableinstanceaftertime) || getdvarint("_encstr_9347133356AB495E48019FFE1702FFAE5B906BC552", 1) != 0)
    self.set_shouldrespawn = 1;
}

_id_12677(var_0) {
  if(var_0) {
    self enableoffhandweapons();
    self enableusability();
  } else {
    self disableoffhandweapons();
    self disableusability();
  }
}

enable_spawner() {
  var_0 = level.deletescriptableinstanceaftertime;

  if(isDefined(level._id_12A7D)) {
    var_1 = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      var_1 = min(level.br_circle.circleindex, level._id_12A7D.size);
      var_1 = int(var_1);
    }

    if(isDefined(level._encstr_B1AC137B404E12C3BB404B779039E89B43232A6E30[var_1]))
      var_0 = level._id_12A7D[var_1][level._encstr_B1AC137B404E12C3BB404B779039E89B43232A6E30[var_1]];
  }

  return var_0;
}

enable_spawner_after_vehicle_death() {
  var_0 = 0;

  if(isDefined(level._id_12A7D)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      if(level.br_circle.circleindex == level._id_12A7D.size - 1)
        var_0 = 1;
    }
  }

  return var_0;
}

end_intro_obj() {
  level.deletescriptableinstanceaftertime = enable_spawner();
  var_0 = enable_spawner_after_vehicle_death();
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::searchcircleorigin(0, 1, var_0);

  if(isDefined(level.obit_activation) && level.obit_activation._id_129DA == 1)
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::disablearmorykiosk();

  if(!isDefined(self.player_enable_invulnerability)) {
    self.player_enable_invulnerability = 1;
    var_1 = getdvarint("_encstr_84C921D3F80509539B60AFA98C01DF4A43180AA9D8F3BBB733558FD7A86EA752F3A812", 1);

    if(var_1)
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::bdroppingshield(1);
  } else {
    var_1 = getdvarint("_encstr_BA3F2363BE43779EE501827A5013190F1991FED74EC98B64C5380912B80F0AEF33074177E8", 0);

    if(var_1)
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::bdroppingshield(1);
  }

  return 0;
}

empdrone_killstreaktargetthink(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_12CA1))
    var_1._id_12CA1 = 0;

  if(var_1._id_12CA1 > 0 || !istrue(level.disable_super_in_turret._id_12CA4))
    var_0[var_0.size] = var_1.watch_for_attack;
}

rocket_attack_min_cooldown() {
  return getdvarint("_encstr_965229B96C93AF3127FAE459895A27A3D0D7DC47F683D79CAC6E1C0BDDE6D7D8A54E366359EBB49B3295F0", 3);
}

circletimer(var_0) {
  if(istrue(level.disable_super_in_turret._id_12CA4)) {
    var_1 = rocket_attack_min_cooldown();

    if(var_0 >= var_1)
      loadoutcustomperkdiscount();
  }
}

loadoutcustomperkdiscount() {
  level.disable_super_in_turret._id_12CA4 = 0;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader(var_1, "_encstr_A7A811E456E61C16DDCDAF912DB958C4C62B19", undefined, 2);
    var_1 setclientomnvar("_encstr_AB2C1FAB5C571836E1DBF9C38B7AF5C03F37720302D1D8ED1997C5F93723CBF0DD", 0);
    var_1 notify("_encstr_A7A811E456E61C16DDCDAF912DB958C4C62B19");
  }

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_9571117507B22308D4BC4639E4BBD8EE2A6FC1");
}

timeoutonabandoneddelay(var_0) {
  if(!isDefined(level._id_12A7D))
    level._id_12A7D = [];

  var_1 = level._id_12A7D.size;
  var_2 = tablelookupgetnumcols(var_0) - 1;
  level._id_12A7D[var_1] = [];

  for(var_3 = 0; var_3 < var_2; var_3++)
    level._id_12A7D[var_1][level._id_12A7D[var_1].size] = init_structs_mp_don3(var_3, var_0);

  level._encstr_B1AC137B404E12C3BB404B779039E89B43232A6E30 = [];

  foreach(var_6, var_5 in level._id_12A7D) {
    if(isDefined(level._id_12A7D[var_6]) && level._id_12A7D[var_6].size > 0)
      level._encstr_B1AC137B404E12C3BB404B779039E89B43232A6E30[var_6] = randomintrange(0, level._id_12A7D[var_6].size);
  }
}

init_structs_mp_don3(var_0, var_1) {
  var_2["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = tablelookup(var_1, 0, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", var_0 + 1);
  var_2["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = tablelookup(var_1, 0, "_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A", var_0 + 1);
  var_2["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = tablelookup(var_1, 0, "_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353", var_0 + 1);
  var_2["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = tablelookup(var_1, 0, "_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66", var_0 + 1);
  var_2["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = tablelookup(var_1, 0, "_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3", var_0 + 1);
  var_2["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = tablelookup(var_1, 0, "_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB", var_0 + 1);
  var_2["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = tablelookup(var_1, 0, "_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED", var_0 + 1);
  var_2["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = tablelookup(var_1, 0, "_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3", var_0 + 1);
  var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = tablelookup(var_1, 0, "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B", var_0 + 1);
  var_2["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = tablelookup(var_1, 0, "_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA", var_0 + 1);
  var_2["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = tablelookup(var_1, 0, "_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7", var_0 + 1);
  var_2["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = tablelookup(var_1, 0, "_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC", var_0 + 1);
  var_2["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = tablelookup(var_1, 0, "_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC", var_0 + 1);
  var_2["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = tablelookup(var_1, 0, "_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA", var_0 + 1);
  var_2["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = tablelookup(var_1, 0, "_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560", var_0 + 1);
  var_2["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = tablelookup(var_1, 0, "_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D", var_0 + 1);
  var_2["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = tablelookup(var_1, 0, "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB", var_0 + 1);
  var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = tablelookup(var_1, 0, "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B", var_0 + 1);
  var_2["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_2["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_968411DCBAC12B4E7D13E4BE563C8E27851BD1";
  var_2["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [tablelookup(var_1, 0, "_encstr_96CB0DB3C7BF3CCF5363C0EA92DCCA", var_0 + 1), tablelookup(var_1, 0, "_encstr_88CB0DC6B70B237B5D1DA02B27AD46", var_0 + 1), tablelookup(var_1, 0, "_encstr_81CB0D4DB85834BAFDA97BA7CDAA27", var_0 + 1), tablelookup(var_1, 0, "_encstr_86EA12137F2FDAF73803D760FBF80151F5DD87DE", var_0 + 1), tablelookup(var_1, 0, "_encstr_8BEA12C06AA8690A20E32759212A20912B13FF0A", var_0 + 1), tablelookup(var_1, 0, "_encstr_83EA1283EF9F6A47889347108B6891E1652D1766", var_0 + 1)];
  var_2["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  var_2["_encstr_96D10CD10B311B2B0DBDC6BAD6DC"] = var_0;
  return var_2;
}

tomastrike_findoptimallaunchpos() {
  if(!istrue(level.disable_super_in_turret._id_14094)) {
    return;
  }
  if(!isDefined(level.disable_super_in_turret._id_1452E))
    level.disable_super_in_turret._id_1452E = [60, 30];

  thread _id_14013();
}

_id_14013() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;
  level.disable_super_in_turret._id_1452F = level.disable_super_in_turret._id_1452E[var_0];
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");

  while(level.disable_super_in_turret._id_12CA4) {
    while(level.disable_super_in_turret._id_1452F > 0) {
      wait 1;
      level.disable_super_in_turret._id_1452F--;
    }

    wait 1;
    var_0 = int(min(var_0 + 1, level.disable_super_in_turret._id_1452E.size - 1));
    level.disable_super_in_turret._id_1452F = level.disable_super_in_turret._id_1452E[var_0];
  }
}

enable_leaderboard() {
  var_0 = (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], 0);
  var_1 = level.br_level.br_circleradii[1];
  var_2 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path(var_0, var_1);
  return var_2;
}

emp_target_monitor() {
  thread enablefeature();
}

enablefeature() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = distance(self._id_12205.startpt, self._id_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed() - 5;
  wait(var_1);

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "_encstr_969105B1C4CC81" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "_encstr_8A720C58B3AB7729A26778B853CB";
      var_3 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
    }
  }
}

end_nuke_vault() {
  var_0 = -15;
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::relic_amped_pick_random_valid_player(1);
  var_2 = max(0, var_1 + var_0);
  var_3 = getdvarfloat("_encstr_B2F7151277B34913839FFC4BF8B161BF5FD7E12091C203", var_2);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B10("_encstr_B8CB0D83F5B80B4A0811E7B768D0A9", var_3);
}