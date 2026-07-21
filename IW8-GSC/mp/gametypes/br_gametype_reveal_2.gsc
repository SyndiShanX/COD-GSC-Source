/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_reveal_2.gsc
*************************************************/

init() {
  level._id_12CE8 = spawnStruct();
  level._id_12CE8.level_carepackage_drop_defined = getdvarint("_encstr_ABEB237358A5E9B37B805A452CA187ED574A39FA8041DFA3F1E85C77486BB7325350C26388", 128);
  level._id_12CE8._id_13B75 = getdvarint("_encstr_8EE82083DA2348F042873503B6EFA0A9EFA79EEBC2F79D38D1831307DCD40860470F", 35);
  level._id_12CE8._id_13B77 = getdvarint("_encstr_82E820B936C9F598C9F54E95B32BB0C6BE46FAD12D5B9523EB6E958D47A57BDCFA91", 60);
  level._id_12CE8._id_13B79 = getdvarint("_encstr_92E820AB1EBA31FEF3A705232BAAB7707FA2D6C3041DA8A5590F1337DBB28828275A", 15);
  level._id_12CE8._id_13BF9 = getdvarint("_encstr_9B6826EB7FBB8E3E5B481BADB5A28984C7EFAF61F3B9BA790DCA89C8ABE541575DAB065326AD2EC9", 570);
  level._id_12CE8._id_13BFA = getdvarint("_encstr_879533B91BE47D89E4FA4EACEC5685D8AF46F58EB4B5567D9DE4EDD59B91F59BE82CD1597D135666DB9C95BECCDE3936B27DACDC91", 240);
  level._id_12CE8._id_13B6E = getdvarint("_encstr_A1962863BE43779EE501D3BA501396735EBEC7FCC3C8C7E9EB30BAB2E80F4BDBF1087F64E6505B6A9B08", 0);
  level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher = relic_nuketimer_addtotimer();
  level._id_12CE8._id_12345 = 0;
  level._id_12CE8._id_14385 = level._id_12CE8._id_13B77;
  level._id_12CE8._id_145CC = getdvarint("_encstr_925B200328D5F9A36BB06A753C5177FD675A49EAB0652CEFE1985761D83E6BC45B48", 180);
  level._id_12CE8._id_13A17 = undefined;
  level._id_12CE8._id_13A1B = undefined;
  level._id_12CE8._id_13A1A = undefined;
  level._id_12CE8._id_13A19 = undefined;
  level._id_12CE8._id_129C4 = getdvarint("_encstr_A529223B4E3AC1A6104133D2CB6D790A4FCA7E77F0F323C0EFB10BD7F8476D60B6CBE70D", 1);
  level._id_12CE8.playerplunderbank = getdvarint("_encstr_821B2496F60B976952678020DB9DC139214A18944DA3B7F117F7B04867BB5E7D2A8207AF233A", 0);
  level._id_12CE8.playersetattractionbesttime = getdvarfloat("_encstr_99EB2F139F632F6633D091222019E0C821B127A3A76C3F273D87067D2B49025408C1C720B308EB3F913026C0C92BDF9BC5", 0.0);
  level._id_12CE8.nuclear_core_carrier_escaped = getdvarfloat("_encstr_81E12C13A7F0B1E3569E3B92E1AD0776B011878C33B844BFF5B6226A09093F2158F73F1E2F308C43ACAE4B823355", 0.0);
  level._id_12CE8.player_pushing_vehicle_monitor = getdvarint("_encstr_BE4828B96C93FA8993FA9356B35985D8AF19EBCCB12C3BED93EB17D558B9E896E8CBAFC1360B5E569337", 21);
  level._id_12CE8._id_145CE = 0;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_838F0D8DEFA26BC7D83780300FF4D9");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BA32084FFD08358F1C99");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A1B50F226F23E2F0A1FB78932245C75325");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A78F076CA54E1B1B56");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8C100FC793A0BFF07F07F30773956AE520");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A5D50F0ED8C2DC9535E616E051F6F4D312");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B0C0EEC59D0A5D8B1B2353885BBE6B9");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_932316AC447BD37F648F9058EB81710982E39F241A62A9E1");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_BD4C13ABE31D07EE1807A0920148B73B3E38C2732B");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8CDB0F17758F62C1503912545010040A7D", ::onplayerkilled);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8106123B24BF78D3DBDC083511D5719BA1AE6345", ::playerrespawn);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_96F01524FD4B55733DBAD0A152521F686743BD2844D71B", ::_id_12CF4);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_81EC15B516C11A959B1D9527645ACDC28D68D2E48D36B2", ::_id_12CF4);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8F9A199578C7C234D0F8BBBB50A9FBB863049C4D4D1F5A669B38EF", ::_id_12048);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_87C111C827BD838492D2A563D8B9D1C959166D", ::missing_window_blockers);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3", ::_id_12CEE);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_B1130F58C89145BD6813990CA473335A36", ::_id_12CEC);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8E0D1A1FBA72FB316C9F48993B910B0518E693B9554AABDB29976060", ::_id_12862);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_BDE210BD9B1A93C28E955036E84B9DC2A395", ::_id_1200D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_B29F0BB0BA576E58532DEBDF55", ::_id_1200F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88431355E25928370F3B580172EBE0606F5ECBCF9D", "_encstr_85DA0F72482643D63053E4CD57185A6F63", ::_id_1200E);
  level._id_133E0 = 0;
  level.scriptedphysicaldofenabled = 1;
  level.parachuterestoreweaponscb = ::blankfunc;
  level.disableforfeit = 1;
  level.debug_safehouse_gunshop_start = 0;
  level.skipprematchdropspawn = 0;
  level._id_11E96 = 1;
  level._effect["_encstr_A7BA1683D86F743F4EA5F9F3BD50FF3E81B17A7AA8DB2E77"] = loadfx("_encstr_83ED32EBFD13DE41981AC1964B8297F261037B1B5B3B8616783AC99EA329DBBBCF89D75FE7694AF358A6FAA439D8E1923015537B");
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_1206A);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A29E0E760BD6591D9707B2F519DBD991"] = "_encstr_A29E0E760BD6591D9707B2F519DBD991";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A18213BF2B2225F32370DFE1FC394B2E3FB53F833B"] = "_encstr_A18213BF2B2225F32370DFE1FC394B2E3FB53F833B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B0B189D0BB559A3BCE0597DC895E636FA19BDD919BED89C2DE8"] = "_encstr_9B0B189D0BB559A3BCE0597DC895E636FA19BDD919BED89C2DE8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE460E3978C3839DFF18621B80FDD5E7"] = "_encstr_BE460E3978C3839DFF18621B80FDD5E7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99D214C4FF57B015A2E9B8DFC9FBF057D0813845B4DD"] = "_encstr_99D214C4FF57B015A2E9B8DFC9FBF057D0813845B4DD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84BD0D903A463F4B539458C87DBFB1"] = "_encstr_84BD0D903A463F4B539458C87DBFB1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A61D0C5025A0A08621F57BA3769F"] = "_encstr_A61D0C5025A0A08621F57BA3769F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A6981013770FD640BE0F85993BE9409DB75A"] = "_encstr_A6981013770FD640BE0F85993BE9409DB75A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AA30BB3A76120BBF9ABF3F7BF"] = "_encstr_8AA30BB3A76120BBF9ABF3F7BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93DB11163647B43BC28E597DC8CAB9D127EDCB"] = "_encstr_93DB11163647B43BC28E597DC8CAB9D127EDCB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BDEF0D56BEF9826E3180BF4F48A827"] = "_encstr_BDEF0D56BEF9826E3180BF4F48A827";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD1B0FD97F18E41B7743829A0ED82FDC38"] = "_encstr_BD1B0FD97F18E41B7743829A0ED82FDC38";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC6A1048EA3281E1F973122B4D5B1F45584B"] = "_encstr_AC6A1048EA3281E1F973122B4D5B1F45584B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3FD13AC1079608806E9B7E3F66A8D7B3B9BD01343"] = "_encstr_A3FD13AC1079608806E9B7E3F66A8D7B3B9BD01343";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92A9127975A3A3886F614FFAD9503F1DD188EB6D"] = "_encstr_92A9127975A3A3886F614FFAD9503F1DD188EB6D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83E30ED8DE6E95F58EDEEDF536C247CA"] = "_encstr_83E30ED8DE6E95F58EDEEDF536C247CA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D280AB1DECDB2BEEE8685D1"] = "_encstr_8D280AB1DECDB2BEEE8685D1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AAE10AC89D3B60E0A283AB8D"] = "_encstr_AAE10AC89D3B60E0A283AB8D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ADAB0AB90F8270F8CB5A68B0"] = "_encstr_ADAB0AB90F8270F8CB5A68B0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_81AE0B8B44BBF9742920410458"] = "_encstr_81AE0B8B44BBF9742920410458";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA820908D0BB09B1B8B5F1"] = "_encstr_BA820908D0BB09B1B8B5F1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_973E0A7FB3C87F223B40BAA2"] = "_encstr_973E0A7FB3C87F223B40BAA2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92DD0CCA58D9649FFDF8FC113B7B"] = "_encstr_92DD0CCA58D9649FFDF8FC113B7B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88060F5C757A85881227F008FF4DC1F153"] = "_encstr_88060F5C757A85881227F008FF4DC1F153";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2980F6928074EBA3AC6D21A5BDBEF2772"] = "_encstr_A2980F6928074EBA3AC6D21A5BDBEF2772";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96081080B0024C0AEB812B3505A89FA764EC"] = "_encstr_96081080B0024C0AEB812B3505A89FA764EC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6830DCA201F6B6D287FA9B71BA875"] = "_encstr_B6830DCA201F6B6D287FA9B71BA875";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2E30CD94013B8680AF9CB6A7663"] = "_encstr_A2E30CD94013B8680AF9CB6A7663";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93C4122F817BDBAF8B316F0BA0418AF1F7AB3767"] = "_encstr_93C4122F817BDBAF8B316F0BA0418AF1F7AB3767";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87550C33D858CEF64EEB9DBDE656"] = "_encstr_87550C33D858CEF64EEB9DBDE656";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9ADD0E66D82C3BDE39F5462C73EC5639"] = "_encstr_9ADD0E66D82C3BDE39F5462C73EC5639";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_97DD0CC769A303072389A7071858"] = "_encstr_97DD0CC769A303072389A7071858";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6AC0F998DB0EC7B27AFA1A5DCA3DB9CCB"] = "_encstr_B6AC0F998DB0EC7B27AFA1A5DCA3DB9CCB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B840DCC1B58ECF69CD78D2B8527E6"] = "_encstr_9B840DCC1B58ECF69CD78D2B8527E6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91A30E1DBC9678700B493940522F3DA0"] = "_encstr_91A30E1DBC9678700B493940522F3DA0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F7D10C4EDE21DED9A9FA8A81B9F386BAB93"] = "_encstr_8F7D10C4EDE21DED9A9FA8A81B9F386BAB93";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B1F1730C79F4887B8C3E57E01876E3C29F78F430713826DB3"] = "_encstr_9B1F1730C79F4887B8C3E57E01876E3C29F78F430713826DB3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86F217DBE033F519F69D64BEEE2CD2E8AF2CB1E8969D85472B"] = "_encstr_86F217DBE033F519F69D64BEEE2CD2E8AF2CB1E8969D85472B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_972E13B707997D23DEEC91AF5BED93AC7D3AA5AD59"] = "_encstr_972E13B707997D23DEEC91AF5BED93AC7D3AA5AD59";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9B80FB7C1337D46DBECC8FAE80DD237B6"] = "_encstr_A9B80FB7C1337D46DBECC8FAE80DD237B6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91D41080EB9259E3076BE679CAE9CF0B2395"] = "_encstr_91D41080EB9259E3076BE679CAE9CF0B2395";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AF0115289363A681B2A32E80FA5BC3889497E88027C01B"] = "_encstr_AF0115289363A681B2A32E80FA5BC3889497E88027C01B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_930F147597D541DC50700EAF9028966AD1B8EAE1DF39"] = "_encstr_930F147597D541DC50700EAF9028966AD1B8EAE1DF39";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A6C11407E3C6C183873C672922E858C979A046D77953"] = "_encstr_A6C11407E3C6C183873C672922E858C979A046D77953";
  thread toggleusbstickinhand();
}

toggleusbstickinhand() {
  waittillframeend;
  scripts\mp\flags::gameflaginit("_encstr_8E6615FB40BBDA176B1875853FF0ABD74E84BAF5F0719A", 0);
  scripts\mp\flags::gameflaginit("_encstr_916615C8B7678CD73A2DDA5946FADCACD8472DDEE6FA8C", 0);
  scripts\mp\flags::gameflaginit("_encstr_AC661548EAB30DE1C973953ACD9FAF875E8B38B7C0563F", 0);
  scripts\mp\flags::gameflaginit("_encstr_826B106410DE8387E8A47087FBAF4EB9CDBB", 0);
  level._id_12888 = ::emp_drone_proximity_explode;
  level._id_11C76 = ::dyn_door;
  level.modeonspawnplayer = ::onspawnplayer;
  level.disable_back_light = 1;
  level.playerkillstreakgetownerlookatignoreents = 1;
  level thread _id_12D09();
}

blankfunc() {}

relic_nuketimer_addtotimer() {
  if(level.script == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    return (90, 90, 40);
  else
    return getdvarvector("_encstr_A50926B98D27D74C27BE93ACCE592C36FA91FA3259CE2DC659EB370E16BBB97DB1F6D8B0A3D27B9B", (-69, 986, 1770));
}

_id_12D09() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A672C99DB933656BEB29B46EBB9CAC5D559CD8D95EBA3B45B59F537C1B2E63AD7B473BE9B85B6B2F5B91DB03A56");
  level endon("_encstr_957F1E99BDE46CCA7DB2DCC8F5E695E2AB56B9C6CA7D8E4BB595EBB12DD65A8E");
  level thread _id_12866();
  level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");
  wait 2;
  _id_12CFB();
  thread _id_13B74();
  _id_12D0A(level._id_12CE8._id_13B75);
  thread _id_13B76();
  _id_12D0A(level._id_12CE8._id_13B77);
  level waittill("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
  thread _id_13B78(undefined);
  _id_12D0A(level._id_12CE8._id_13B79);
  _id_12CF3(1);
  thread _id_12CF0();
}

_id_12866() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level waittill("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
  wait 45;

  foreach(var_1 in level.players)
  var_1 thread _id_12D0D("_encstr_930F147597D541DC50700EAF9028966AD1B8EAE1DF39");
}

_id_13B74() {
  scripts\mp\flags::gameflagset("_encstr_8E6615FB40BBDA176B1875853FF0ABD74E84BAF5F0719A");
  level thread playerlocationtriggerenter();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_A70D21FFCF5D70929B23F7E81B7B022579FBBFE2A843A2BBD12311CF3D2F7BDC613B96");
  level notify("_encstr_848F220BAB18B6E74196F39A1B2E0B6140139291C7507BEBFD2B4B6140FC776258F3391C");
  _id_1366F();
  level thread _encstr_85BA2C5B708D3CA3D3EE7F2507D0B746CB28B373500B7226C956072797A067CB4B182AA9A8D36B4781B14E5FB689::_id_12D0F(6, 4, 0, 1);
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 4);

  foreach(var_1 in level.players)
  var_1 _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();

  wait(level._id_12CE8._id_13B75 - 8);
  level notify("_encstr_8E7218A0822DBD5017D7382DD423FB0B966A1172F9C2D9699304");
}

_id_13B76() {
  scripts\mp\flags::gameflagset("_encstr_916615C8B7678CD73A2DDA5946FADCACD8472DDEE6FA8C");
  _id_13A1D();
  wait 1;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A18213BF2B2225F32370DFE1FC394B2E3FB53F833B", 0, level.players);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_99D214C4FF57B015A2E9B8DFC9FBF057D0813845B4DD", 0, level.players);
  wait 13;
  level notify("_encstr_957518DA6227BEC0DFDFA79B1CC6C0F5BF9AF64B0927EDC832EC");
  wait 14;
  level notify("_encstr_A9B9183DBDD6899659BEBDABE84CE4B216D6EB66FADC1D16398E");
  wait 14;
  level notify("_encstr_9614181B50094B9CE06FB79501E0629FA748C107BEDEABD63051");
  wait(level._id_12CE8._id_13B77 - 42);
  _id_13670();
  _id_13A1F();
  wait 40;
  level thread _id_11F1B();
}

_id_13B78(var_0) {
  scripts\mp\flags::gameflagset("_encstr_AC661548EAB30DE1C973953ACD9FAF875E8B38B7C0563F");
  var_1 = 0;
  var_2 = 255;
  animscripted_loop_earlyend(var_1, var_2, undefined, 0);

  foreach(var_4 in level.players) {
    if(scripts\mp\utility\player::unset_relic_trex(var_4))
      var_4 scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", var_4);
  }

  foreach(var_4 in level.players)
  var_4.plotarmor = 1;

  if(isDefined(level._id_12CE8._id_13A17)) {
    if(isDefined(level._id_12CE8._id_13A17.owner))
      level._id_12CE8._id_13A17.owner scripts\mp\killstreaks\killstreaks::clearkillstreaks();
    else
      _id_13A18();
  }

  thread _id_11F1A(var_0);
  thread _id_11F13();
  thread _id_11F17(level._id_12CE8._id_13B79);

  if(level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    thread _id_11F12(level._id_12CE8._id_13B79);

  thread _id_11F16(level._id_12CE8._id_13B79 + 5, 6);
  thread _id_11F15(level._id_12CE8._id_13B79 + 5);
  thread _id_13365(level._id_12CE8._id_13B79);
}

playerlocationtriggerenter() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
  level endon("_encstr_8A672C99DB933656BEB29B46EBB9CAC5D559CD8D95EBA3B45B59F537C1B2E63AD7B473BE9B85B6B2F5B91DB03A56");
  wait(level._id_12CE8._id_13BF9);
  level notify("_encstr_957F1E99BDE46CCA7DB2DCC8F5E695E2AB56B9C6CA7D8E4BB595EBB12DD65A8E");
  thread _id_13B78(1);
  _id_12D0A(level._id_12CE8._id_13B79);
  _id_12CF3(1);
  thread _id_12CF0();
}

ai_molotov_used() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
  level endon("_encstr_957F1E99BDE46CCA7DB2DCC8F5E695E2AB56B9C6CA7D8E4BB595EBB12DD65A8E");
  level endon("_encstr_BD211D91EDEC23BEA358D88EA536C2B1BEC8953B4B8D56EB91E4BDC11C5923");
  level endon("_encstr_82D71C32DB67C8D78EB01B472DB1C2637D4656D99636597D3896B1D6D50E");
  wait(level._id_12CE8._id_13BFA);
  level notify("_encstr_8A672C99DB933656BEB29B46EBB9CAC5D559CD8D95EBA3B45B59F537C1B2E63AD7B473BE9B85B6B2F5B91DB03A56");
  thread _id_13B78(1);
  _id_12D0A(level._id_12CE8._id_13B79);
  _id_12CF3(1);
  thread _id_12CF0();
}

_id_13365(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = gettime();
  var_2 = var_0 * 1000 + var_1;
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 9, 2, 3);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 0, 9, var_0);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 1);
  setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", var_2);
  setomnvarforallclients("_encstr_8A49105D4BF51A2D9156BE6BB437D2D60B38", 1);
  wait 3;

  foreach(var_4 in level.players)
  var_4 thread _id_12D0B("_encstr_86F217DBE033F519F69D64BEEE2CD2E8AF2CB1E8969D85472B");
}

spawn_cypher_monitor_model() {
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 0);
}

_id_11F15(var_0) {
  level endon("_encstr_826B106410DE8387E8A47087FBAF4EB9CDBB");

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  var_1 = 3.0;

  for(;;) {
    foreach(var_3 in level.players)
    var_3 playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");

    wait(var_1);
    var_1 = max(0.5, var_1 - 0.5);
  }
}

_id_11F16(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  var_2 = 0.01;
  var_3 = [level.mapcenter];

  if(!getdvarint("_encstr_822424E6867BE71922376888A74693AF422DDCEF4A4147E011A3B118FB74AB0B59525BFFF45A", 0)) {
    var_3[var_3.size] = (-500, 7000, 0);
    var_3[var_3.size] = (-400, -5042, 0);
  }

  while(var_1 > 0) {
    foreach(var_5 in var_3)
    earthquake(var_2, 0.05, var_5, 100000);

    wait 0.05;
    var_2 = var_2 + 0.005;

    if(var_2 >= 0.2)
      var_2 = 0.2;

    var_1 = max(var_1 - 0.05, 0);
  }

  var_1 = 0;
  var_2 = 0.2;

  while(var_1 < 3 && var_2 > 0) {
    foreach(var_5 in var_3)
    earthquake(var_2, 0.05, var_5, 100000);

    wait 0.05;
    var_2 = var_2 - 0.005;

    if(var_2 <= 0)
      var_2 = 0;
  }
}

_id_11F1A(var_0) {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BD1B0FD97F18E41B7743829A0ED82FDC38", 0, level.players);
  wait 3;

  if(istrue(var_0))
    wait 34;
  else {
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_81AE0B8B44BBF9742920410458", 0, level.players);
    wait 5;
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_973E0A7FB3C87F223B40BAA2", 0, level.players);
    wait 29;
  }

  if(isDefined(level._id_12CE8.lb_mg_dmg_factor_tail_stabilizer)) {
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_92A9127975A3A3886F614FFAD9503F1DD188EB6D", 0, level._id_12CE8.lb_mg_dmg_factor_tail_stabilizer);
    var_1 = scripts\engine\utility::array_remove_array(level.players, level._id_12CE8.lb_mg_dmg_factor_tail_stabilizer);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AAE10AC89D3B60E0A283AB8D", 0, var_1);
  } else
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AAE10AC89D3B60E0A283AB8D", 0, level.players);
}

_id_11F1B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
  level endon("_encstr_957F1E99BDE46CCA7DB2DCC8F5E695E2AB56B9C6CA7D8E4BB595EBB12DD65A8E");

  foreach(var_1 in level.players)
  var_1 thread _id_12D0D("_encstr_A6C11407E3C6C183873C672922E858C979A046D77953");

  var_3 = [];

  for(var_4 = 0; var_4 < level._id_12CE8.player_pushing_vehicle_monitor; var_4++) {
    var_5 = level.players[randomint(level.players.size)];
    var_3[var_3.size] = var_5;
  }

  var_3 = scripts\engine\utility::array_remove_duplicates(var_3);
  wait 12;

  foreach(var_7 in var_3) {
    if(!isDefined(var_7) || !isalive(var_7)) {
      continue;
    }
    var_7 thread _id_12F1C(3);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_88060F5C757A85881227F008FF4DC1F153", var_7, 1, 1);
  }

  wait 9;

  foreach(var_7 in var_3) {
    if(!isDefined(var_7) || !isalive(var_7)) {
      continue;
    }
    var_7 thread _id_12F1C(3);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_96081080B0024C0AEB812B3505A89FA764EC", var_7, 1, 1);
  }

  wait 14;

  foreach(var_7 in var_3) {
    if(!isDefined(var_7) || !isalive(var_7)) {
      continue;
    }
    var_7 thread _id_12F1C(3);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B6AC0F998DB0EC7B27AFA1A5DCA3DB9CCB", var_7, 1, 1);
  }

  wait 5;

  foreach(var_7 in var_3) {
    if(!isDefined(var_7) || !isalive(var_7)) {
      continue;
    }
    var_7 thread _id_12D0B("_encstr_AF0115289363A681B2A32E80FA5BC3889497E88027C01B");
  }

  wait 6;

  foreach(var_7 in var_3) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_7 thread _id_12F1C(3);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8F7D10C4EDE21DED9A9FA8A81B9F386BAB93", var_7, 1, 1);
  }
}

_id_11F13(var_0) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  thread midpoint_music();
  thread _id_11F18();
  setmusicstate("_encstr_B150137B37DCE3D2219B569C56C0DD2A3D3FE7DB99");

  foreach(var_2 in level.players)
  var_2 setsoundsubmix("_encstr_9AD91CD6E0EB31E4AF5667AC738EF532B7B30E8CF58DDBBACDA38CEDEE73", 5);
}

midpoint_music() {
  foreach(var_1 in level.players)
  var_1 playlocalsound("_encstr_A92A176ECE47BA6FCB88DA67B06151B1976DB9263E67E2A653");

  wait 3;
  var_3 = scripts\engine\utility::play_loopsound_in_space("_encstr_B42116130876C45245B661257D078AB7D96097EB58AE346B", (383, -2648, 4228));
  wait 12;
  var_3 scripts\engine\utility::stop_loop_sound_on_entity("_encstr_B42116130876C45245B661257D078AB7D96097EB58AE346B");
  waitframe();
  var_3 delete();
}

_id_11F18() {
  wait 10;

  foreach(var_1 in level.players)
  var_1 setsoundsubmix("_encstr_BDF817451FCEAB82A7386B528819314B2084C09220B0BF8C8B", 3);
}

_id_11F17(var_0) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  if(isDefined(level._id_12CE8.lb_mg_dmg_factor_tail_stabilizer)) {
    foreach(var_2 in level.players) {
      foreach(var_4 in level._id_12CE8.lb_mg_dmg_factor_tail_stabilizer)
      var_2 thread scripts\mp\hud_message::showsplash("_encstr_AA101FC01B8F8303A3E7079971BF2F091DA7F8D88751B9E5194B0D9E976285534B", undefined, var_4);
    }
  }

  foreach(var_2 in level.players) {
    if(getdvarint("_encstr_B2502158F7F8784605779A433B0DF4E76F979E6A32EFD8D4404BE2886B085050327B3E", 0) && var_2 updateghostridekills()) {
      continue;
    }
    var_2 thread scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", "_encstr_AC190479FF92", 7.0, 1);
  }

  wait 0.5;
  spawn_cypher_monitor_model();
  wait 13.5;

  foreach(var_2 in level.players)
  var_2 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();

  wait 1;
  var_11 = spawnStruct();
  var_11.origin = getdvarvector("_encstr_A37C200F078649DA20463AC75BA0E1B2C83D37F7C9A53284D04BF74190F0215ABB2D", (421, -1897, 2689));
  var_11.angles = getdvarvector("_encstr_B48E204AF993CFAABE3FB3E785ED4224C16BC9D2F3C0BB831F71171793376A6CC8AB", (8, -134, 0));

  foreach(var_2 in level.players)
  var_2 thread scripts\mp\playerlogic::spawnintermission(var_11, undefined, 0);

  wait 1.5;

  foreach(var_2 in level.players)
  var_2 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();

  wait 2.0;
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 1);
  wait 3;
  setmusicstate("_encstr_B40101");

  foreach(var_2 in level.players) {
    var_2 setsoundsubmix("_encstr_95C51F5E87B9A7F9C158E93268C32E47367FACDC30219BBE9BB863F998336207E9", 5.5);
    var_2 clearsoundsubmix("_encstr_BDF817451FCEAB82A7386B528819314B2084C09220B0BF8C8B", 6.5);
    var_2 clearsoundsubmix("_encstr_9AD91CD6E0EB31E4AF5667AC738EF532B7B30E8CF58DDBBACDA38CEDEE73", 6.5);
  }
}

_id_11F12(var_0) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  var_1 = "_encstr_A99516D562D928B0DBFBB306C3537B392DDD4F43273F9007";

  if(soundexists(var_1)) {
    foreach(var_3 in level.players)
    var_3 playlocalsound(var_1);
  }

  var_5 = [];
  var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-120844, -162669, -1514.17));
  var_5[0].angles = (0, 59.9956, 0);
  var_5[0].state = "_encstr_A5E0161CBFA39FB16B9F9AF93B9D0E059B641D3057BAB7BB";
  var_5[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1376, -8815.3, 152.311));
  var_5[1].angles = (0, 0, 0);
  var_5[1].state = "_encstr_9B501A46FDF0E1AF86296FA153D10F274879F7D42DE03993A541529A";
  var_5[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1376.6, -8840.11, 152.462));
  var_5[2].angles = (0, 0, 0);
  var_5[2].state = "_encstr_9A041730E29837215FFB8608C00F2E37855A01103B76A9F9A3";
  var_5[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3743.56, -7804.97, 148.015));
  var_5[3].angles = (0, 0, 0);
  var_5[3].state = "_encstr_9A041730E29837215FFB8608C00F2E37855A01103B76A9F9A3";
  var_5[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3737.46, -7803.28, 148.023));
  var_5[4].angles = (0, 0, 0);
  var_5[4].state = "_encstr_9B501A46FDF0E1AF86296FA153D10F274879F7D42DE03993A541529A";
  var_5[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (4634.08, -3228.27, 144));
  var_5[5].angles = (0, 0, 0);
  var_5[5].state = "_encstr_9B501A46FDF0E1AF86296FA153D10F274879F7D42DE03993A541529A";
  var_5[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (4614.33, -3222.59, 144));
  var_5[6].angles = (0, 0, 0);
  var_5[6].state = "_encstr_9A041730E29837215FFB8608C00F2E37855A01103B76A9F9A3";
  var_5[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1677.6, 5432.56, 494.917));
  var_5[7].angles = (10.0383, 328.106, 0.236512);
  var_5[7].state = "_encstr_9B501A46FDF0E1AF86296FA153D10F274879F7D42DE03993A541529A";
  var_5[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1641.29, 5458.24, 504.904));
  var_5[8].angles = (0, 0, 0);
  var_5[8].state = "_encstr_9A041730E29837215FFB8608C00F2E37855A01103B76A9F9A3";
  var_5[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4425.86, 1847.89, 702.528));
  var_5[9].angles = (0, 0, 0);
  var_5[9].state = "_encstr_9B501A46FDF0E1AF86296FA153D10F274879F7D42DE03993A541529A";
  var_5[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4450.11, 1832.88, 703.237));
  var_5[10].angles = (0, 0, 0);
  var_5[10].state = "_encstr_9A041730E29837215FFB8608C00F2E37855A01103B76A9F9A3";

  foreach(var_7 in var_5)
  var_7 setModel("_encstr_88250BBBE58D40AE0BF8E07561");

  waitframe();
  var_5[0] setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_BDE417314A4B38B852EB439915EAA177F7C1E8BBB26770A8AA");

  foreach(var_7 in var_5)
  var_7 setscriptablepartstate("_encstr_96190434978B", var_7.state);
}

_id_12CF4() {
  var_0 = getdvarvector("_encstr_8E141949237FCCB06D91315FBB9450061BCA66900BCF7EA0446C3B", level.grouptorewards);
  return var_0;
}

_id_12CF5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players)
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptednode(var_1);
}

_id_12D0A(var_0) {
  level endon("_encstr_8F9715177899713D9348EFC3D9A8FDCA39075DCFD1332B");
  wait(var_0);
}

_id_12CF0() {
  createnavobstaclebyshape();
  level thread scripts\mp\gamelogic::forceend();
  level waittill("_encstr_8F3F0DCF1F807A39380175B16B930B");
  wait 0.6;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_1, 1, 0.3);
  }
}

_id_11A48(var_0) {
  return 0;
}

_id_12D0D(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = "_encstr_8E750850F3A1BD3337D7" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
  var_2 = tolower(var_2);

  if(soundexists(var_2))
    var_3 = lookupsoundlength(var_2, 1) / 1000;
  else
    var_3 = 3;

  var_1 queuedialogforplayer(var_2, var_0, var_3);
}

_id_12D0B(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = "_encstr_AB7508A1C157AA4A61C7" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
  var_2 = tolower(var_2);

  if(soundexists(var_2))
    var_3 = lookupsoundlength(var_2, 1) / 1000;
  else
    var_3 = 3;

  var_1 queuedialogforplayer(var_2, var_0, var_3);
}

_id_12CFB() {
  level.playerkillstreakgetownerlookatignoreents = 0;
  level thread _id_12CF5();

  foreach(var_1 in level.players) {
    if(scripts\mp\utility\player::unset_relic_trex(var_1))
      var_1 scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", var_1);
  }

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A29E0E760BD6591D9707B2F519DBD991", 0, level.players);
  wait 4;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_9B0B189D0BB559A3BCE0597DC895E636FA19BDD919BED89C2DE8", 0, level.players);
  wait 4;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BE460E3978C3839DFF18621B80FDD5E7", 0, level.players);
  wait 9;

  foreach(var_4 in level.players)
  var_4 thread scripts\mp\hud_message::showsplash("_encstr_A6D5241339D7C9ACB3952C637D8CF546ACD9B41BACBE2659D7E84356BE1995DCD139F6CBB2E4");
}

_id_12CEE() {
  var_0 = (0, 0, 0);
  var_1 = 18000;
  var_2 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path(var_0, var_1);
  return var_2;
}

_id_12CEC() {
  thread _id_12CF9();

  foreach(var_1 in level.players)
  var_1 _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
}

_id_12CF9() {
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

_id_1206A(var_0) {
  var_0.locationtriggerupdate = var_0.origin;

  if(isDefined(level._id_12CE8) && isDefined(level._id_12CE8._id_13A17) && isDefined(level._id_12CE8._id_13A17.owner) && var_0 == level._id_12CE8._id_13A17.owner)
    var_0 _id_12CAF(1);
}

carriable_ready() {
  if(!isDefined(self.carryflag)) {
    self attach("_encstr_82DE14039E45A058F75CFDAFD91F804BC0F0F9947638", "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6", 1);
    self.carryflag = "_encstr_BDAF1807E4F683FA8D1DCCFACE2CAD56BE66638576BEEECADC1D";
  }
}

lbravo_hover_attack_think() {
  if(isDefined(self.carryflag)) {
    self detach("_encstr_82DE14039E45A058F75CFDAFD91F804BC0F0F9947638", "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6");
    self.carryflag = undefined;
  }
}

_id_13A1D() {
  var_0 = 1;
  var_1 = 255;
  var_2 = level._id_12CE8._id_14385;
  var_3 = level._id_12CE8._id_14385;
  animscripted_loop_earlyend(var_0, var_1, var_2, 0);
  animscripted_loop_for_time(var_3);
}

_id_13A1F() {
  scripts\cp_mp\killstreaks\airdrop::modifydestructibledamage(level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher);

  foreach(var_1 in level.players)
  var_1 scripts\mp\hud_message::showsplash("_encstr_AD491D2693AF4E5967ACC2367D8CD746CACED28D56BEDBDCFAD939EDAE9B23");

  var_3 = 2;
  var_4 = 255;
  var_5 = level._id_12CE8._id_14385;
  var_6 = level._id_12CE8._id_145CC;
  animscripted_loop_earlyend(var_3, var_4, var_5);
  animscripted_loop_for_time(var_6);
  level thread animatedprop_setup(level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_84BD0D903A463F4B539458C87DBFB1", 0, level.players);
  wait 3;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A61D0C5025A0A08621F57BA3769F", 0, level.players);
}

animscripted_loop_earlyend(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_13A20)) {
    level._id_13A20 = spawnStruct();
    level._id_13A20.level_check_current_drop_amount = 0;
    level._id_13A20.level_carepackage_player_used_logic = 0;
    level._id_13A20.level_carepackage_give_player_killstreak = 255;
    level._id_13A20._id_11B5A = 0;
  }

  if(isDefined(var_3))
    level._id_13A20.level_check_current_drop_amount = var_3;

  if(isDefined(var_0))
    level._id_13A20.level_carepackage_player_used_logic = var_0;

  if(isDefined(var_1))
    level._id_13A20.level_carepackage_give_player_killstreak = var_1;

  if(isDefined(var_2))
    level._id_13A20._id_11B5A = var_2;

  var_4 = (int(level._id_13A20.level_check_current_drop_amount) & 1) << 22;
  var_4 = var_4 + ((int(level._id_13A20.level_carepackage_player_used_logic) & 7) << 19);
  var_4 = var_4 + ((int(level._id_13A20.level_carepackage_give_player_killstreak) & 255) << 11);
  var_4 = var_4 + (int(level._id_13A20._id_11B5A) & 2047);
  setomnvar("_encstr_81771857C86EEAAB2F25803F1B6131A2F1C85FB7E143344281CD", var_4);
}

animscripted_loop_for_time(var_0) {
  var_1 = gettime() + var_0 * 1000;
  setomnvar("_encstr_BE821B5FC066F2B3272DB837031939AAC9D0A7AFD999261ACFBDC4ED7D", int(var_1));
}

animscripted_single_relative(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_1 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_1, "_encstr_AF5A081BBAC993AC73A3", var_0 + (0, 0, 50), "_encstr_8CB827572DF55B0EFA899CD76B0BE06BB237AED7A5C6BDCDFAC8F63BAF0346BEF6C4A9598D472DCE59");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 1);

    foreach(var_3 in level.players)
    objective_addclienttomask(var_1, var_3);

    objective_setplayintro(var_1, 0);
    objective_showtoplayersinmask(var_1);
    level._id_12CE8._id_13A1B = var_1;
    var_5 = animscripted_single_earlyend();

    if(!var_5) {
      thread anin_playvo_func();
      return;
    }
  } else {}
}

animscripted_single_earlyend() {
  if(!isDefined(level._id_12CE8._id_13A17))
    return 0;

  if(!level._id_12CE8._id_13A17 _meth_87B9())
    return 0;

  var_0 = level._id_12CE8._id_13A17 _meth_87B7();

  if(!isDefined(level._id_12CE8._id_13A1C)) {
    level._id_12CE8._id_13A1C = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level._id_12CE8._id_13A17.origin);
    level._id_12CE8._id_13A1C setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  } else
    level._id_12CE8._id_13A1C.origin = level._id_12CE8._id_13A17.origin;

  level._id_12CE8._id_13A1C linkTo(var_0);
  objective_onentity(level._id_12CE8._id_13A1B, level._id_12CE8._id_13A1C);
  return 1;
}

anin_playvo_func() {
  if(!isDefined(level._id_12CE8._id_13A17)) {
    return;
  }
  level._id_12CE8._id_13A17 endon("_encstr_B2A90FEFE3E593278B6721E988DB2EC858");
  var_0 = level._id_12CE8._id_13A17.origin;

  for(;;) {
    waitframe();

    if(!isDefined(level._id_12CE8._id_13A17) || !isDefined(level._id_12CE8._id_13A1B)) {
      break;
    }

    if(distance(level._id_12CE8._id_13A17.origin, var_0) > 0.1) {
      var_0 = level._id_12CE8._id_13A17.origin;
      objective_position(level._id_12CE8._id_13A1B, var_0 + (0, 0, 50));
    }
  }
}

animscripted_single_arrive_at() {
  if(isDefined(level._id_12CE8._id_13A1A)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(level._id_12CE8._id_13A1A);
    level._id_12CE8._id_13A1A = undefined;
  }

  if(isDefined(level._id_12CE8._id_13A19)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(level._id_12CE8._id_13A19);
    level._id_12CE8._id_13A19 = undefined;
  }

  if(isDefined(level._id_12CE8._id_13A1B)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(level._id_12CE8._id_13A1B);
    level._id_12CE8._id_13A1B = undefined;
  }
}

animatedprop_setup(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(level._id_12CE8.level_carepackage_drop_defined <= 0) {
    return;
  }
  for(;;) {
    animatedprop_setanim(var_0);
    wait 2;
  }
}

animatedprop_setanim(var_0) {
  if(level._id_12CE8.level_carepackage_drop_defined <= 0) {
    return;
  }
  var_1 = canceljoins(undefined, undefined, var_0, level._id_12CE8.level_carepackage_drop_defined);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3.type == "_encstr_8D811789E37308C0ABEF4163FB93C8C6EF9AA6B17AC3B3E887" || !_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::update_gamebattles_char_loc(var_3, 0)) {
        continue;
      }
      if(var_3 getscriptableisreserved() && !isDefined(var_3.embassy_main)) {
        continue;
      }
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_3);
    }
  }
}

anim_weapon(var_0) {
  var_1 = spawnStruct();
  var_1.ml_p3_to_safehouse_transition = 0;
  var_2 = undefined;

  if(isDefined(self) && isPlayer(self))
    var_2 = self;

  var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher, (0, 0, 0), var_2, 0, 0, 35);
  var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_8D811789E37308C0ABEF4163FB93C8C6EF9AA6B17AC3B3E887", var_3, 0, 1);

  if(!isDefined(var_4))
    return undefined;

  var_4.keepinmap = 1;
  var_5 = 1;
  var_6 = 255;
  var_7 = level._id_12CE8._id_14385;
  var_8 = level._id_12CE8._id_14385;
  animscripted_loop_earlyend(var_5, var_6, var_7, 0);
  animscripted_loop_for_time(var_8);

  if(istrue(var_0)) {
    var_4.hidden = 1;
    var_4 setscriptablepartstate("_encstr_8D811789E37308C0ABEF4163FB93C8C6EF9AA6B17AC3B3E887", "_encstr_95DF070DD22319CA9B");
  }

  level._id_12CE8._id_13A17 = var_4;
  return var_4;
}

_id_13A1E(var_0) {
  level notify("_encstr_82D71C32DB67C8D78EB01B472DB1C2637D4656D99636597D3896B1D6D50E");
  var_0 carriable_ready();
  level._id_12CE8._id_13A17.owner = var_0;
  level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_0.origin, "_encstr_9695073995D94BD959");
  setmusicstate("_encstr_92F21591BDEC0EC8FA9389B4FA735DB5B2FAA32DD65627");
  animscripted_single_arrive_at();

  if(istrue(level._id_12CE8._id_145CE))
    var_0 thread scriptflags();
  else
    animscripted_loop(var_0);

  var_1 = 3;
  var_2 = var_0 getentitynumber();
  var_3 = getdvarint("_encstr_8B6025CD3639FAC4E4D7C9B267CA8536F546D79156CE5A8DAC7D0DDB1B23EBEED2DCAFD1D2DA56", 180);
  var_4 = level._id_12CE8._id_145CC;
  animscripted_loop_earlyend(var_1, var_2, var_3, 0);
  animscripted_loop_for_time(var_4);
  level._id_12CE8._id_13A17.owner thread aigroundturret_requestmount();
  level._id_12CE8._id_13A17 anim_spawnposition_override(var_0.origin);
  ammobox_tryuseinternal(var_0.origin, var_0, "_encstr_950430EAD2F5DA83EB13397D6BC238DACACDAEFA5A6CF637D723B73BBE0391BEDB98D4B21B47D2B395FA999C5AACCD32D82F", "_encstr_A9C634F371C178377722B31E3A67EFA0E7DE4B2FE9B620704F5AE823217A8679BD2AFDC38BDBE844CFC1A128EA27DBC1548E7F433D47");
  level._id_12CE8._id_12345 = gettime();

  if(level._id_12CE8._id_129C4 > 0) {
    level.activeuavs[var_0.team] = level.activeuavs[var_0.team] + level._id_12CE8._id_129C4;
    scripts\cp_mp\killstreaks\uav::_setteamradarstrength(var_0.team);
  }
}

animscripted_single() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A672C99DB933656BEB29B46EBB9CAC5D559CD8D95EBA3B45B59F537C1B2E63AD7B473BE9B85B6B2F5B91DB03A56");
  level endon("_encstr_957F1E99BDE46CCA7DB2DCC8F5E695E2AB56B9C6CA7D8E4BB595EBB12DD65A8E");

  while(level._id_12CE8._id_145CC > 0) {
    level._id_12CE8._id_145CC = level._id_12CE8._id_145CC - 1;
    wait 1;
  }

  level._id_12CE8._id_145CE = 1;

  if(isDefined(level._id_12CE8._id_13A17) && isDefined(level._id_12CE8._id_13A17.owner))
    level._id_12CE8._id_13A17.owner thread scriptflags();
}

animscripted_loop_relative() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BD211D91EDEC23BEA358D88EA536C2B1BEC8953B4B8D56EB91E4BDC11C5923");

  if(level._id_12CE8._id_145CC > 30) {
    wait(level._id_12CE8._id_145CC - 30);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A6981013770FD640BE0F85993BE9409DB75A", 0, level.players);
  }
}

animscripted_loop_n_times() {
  var_0 = getdvarint("_encstr_8B6025CD3639FAC4E4D7C9B267CA8536F546D79156CE5A8DAC7D0DDB1B23EBEED2DCAFD1D2DA56", 180);
  animscripted_loop_earlyend(undefined, undefined, var_0);
}

animscripted_clear() {
  animscripted_loop_earlyend(0);
}

animscripted_loop(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team == var_0.team) {
      if(var_2 == var_0)
        var_2 scripts\mp\hud_message::showsplash("_encstr_BDB22226E4F5932BD9592C63BE46EB46CA674B8D56BE0ED2D8DA5991F5BA07AFDCB2C666");
      else
        var_2 scripts\mp\hud_message::showsplash("_encstr_A13B22932BA76BC3201F79F12F62300B09F308A65D09A3F18EF7E71DA9039267E3121963");

      continue;
    }

    var_2 scripts\mp\hud_message::showsplash("_encstr_8E8223F5FBC10E10361F61D8895A894DDA437B7F5F29D7487BF4E9D1A1E52868B2BBEB9B87");
  }
}

ammobox_tryuseinternal(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_4, "_encstr_AF5A081BBAC993AC73A3", var_0, var_2);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
    thread apachepilotpool(var_1, var_4, level._id_12CE8.playersetattractionbesttime);
    objective_removeallfrommask(var_4);
    var_5 = scripts\mp\utility\teams::getteamdata(var_1.team, "_encstr_9775086022BE1B413B8B");

    foreach(var_7 in var_5)
    objective_addclienttomask(var_4, var_7);

    objective_showtoplayersinmask(var_4);
    objective_setplayintro(var_4, 0);
    level._id_12CE8._id_13A1A = var_4;
  }

  var_9 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_9 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_9, "_encstr_AF5A081BBAC993AC73A3", var_0, var_3);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_9, 1);
    thread apachepilotpool(var_1, var_9, level._id_12CE8.nuclear_core_carrier_escaped);
    objective_removeallfrommask(var_9);

    foreach(var_7 in level.players) {
      if(var_7.team == var_1.team)
        objective_addclienttomask(var_9, var_7);
    }

    objective_hidefromplayersinmask(var_9);
    objective_setplayintro(var_9, 0);
    level._id_12CE8._id_13A19 = var_9;
    thread anyplayersinlaststandhold(var_1);
  }
}

apachepilotpool(var_0, var_1, var_2) {
  level endon("_encstr_BD211D91EDEC23BEA358D88EA536C2B1BEC8953B4B8D56EB91E4BDC11C5923");

  if(var_2 <= 0.0) {
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 115);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_1, var_0);
  } else {
    for(;;) {
      if(isDefined(var_0)) {
        scripts\mp\objidpoolmanager::update_objective_position(var_1, var_0.origin + (0, 0, 115));

        if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
          wait 0.1;
          continue;
        }

        wait(var_2);
      }
    }
  }
}

anyplayersinlaststandhold(var_0) {
  level endon("_encstr_BD211D91EDEC23BEA358D88EA536C2B1BEC8953B4B8D56EB91E4BDC11C5923");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AFEE11945823223129F0B35AD8737977FB351C");

  for(;;) {
    objective_removeallfrommask(level._id_12CE8._id_13A19);
    var_1 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 1200);

    foreach(var_3 in var_1) {
      if(var_3.team == var_0.team) {
        continue;
      }
      objective_addclienttomask(level._id_12CE8._id_13A19, var_3);
    }

    objective_showtoplayersinmask(level._id_12CE8._id_13A19);
    wait 3;
  }
}

_id_12CAF(var_0) {
  modifydamagetoprop(1, var_0);
}

modifydamagetoprop(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_BD211D91EDEC23BEA358D88EA536C2B1BEC8953B4B8D56EB91E4BDC11C5923");
  var_2 notify("_encstr_933C1F2B60AF7BC731E73C170D99F344D7280193981D794BA8D93D3288E3778C51");
  var_2 endon("_encstr_933C1F2B60AF7BC731E73C170D99F344D7280193981D794BA8D93D3288E3778C51");
  level thread ai_molotov_used();
  var_2 lbravo_hover_attack_think();
  var_3 = animatedprop_startanim();

  foreach(var_5 in level.players)
  var_5 thread scripts\mp\hud_message::showsplash("_encstr_B8051BBE1E970B55FB10C7FBA91B37324BB4C4760D6FA28AE0A0FBC748");

  if(!istrue(var_1))
    wait 0.5;

  _id_13A18();

  if(!istrue(var_0)) {
    var_7 = level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher;
    level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher = var_2.origin + (0, 0, 35);
  } else
    var_7 = undefined;

  anim_weapon();

  if(!isDefined(level._id_12CE8._id_13A17)) {
    if(isDefined(var_7)) {
      level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher = var_7;
      anim_weapon();
    }

    if(!isDefined(level._id_12CE8._id_13A17)) {
      level._id_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher = relic_nuketimer_addtotimer();
      anim_weapon();
    }
  }

  var_8 = 2;
  var_9 = 255;
  var_10 = getdvarint("_encstr_8B6025CD3639FAC4E4D7C9B267CA8536F546D79156CE5A8DAC7D0DDB1B23EBEED2DCAFD1D2DA56", 180);
  var_11 = level._id_12CE8._id_145CC;
  animscripted_loop_earlyend(var_8, var_9, var_10, 1);
  animscripted_loop_for_time(var_11);
  level thread animatedprop_setup(level._id_12CE8._id_13A17.origin);

  if(isDefined(var_2) && isDefined(var_2.team) && level._id_12CE8._id_129C4 > 0) {
    level.activeuavs[var_2.team] = level.activeuavs[var_2.team] - level._id_12CE8._id_129C4;
    scripts\cp_mp\killstreaks\uav::_setteamradarstrength(var_2.team);
  }

  animscripted_single_relative(level._id_12CE8._id_13A17.origin);
}

_id_13A18() {
  animscripted_single_arrive_at();

  if(isDefined(level._id_12CE8._id_13A17)) {
    level._id_12CE8._id_13A17 notify("_encstr_B2A90FEFE3E593278B6721E988DB2EC858");
    level._id_12CE8._id_13A17 anim_scene_stance_override();
    level._id_12CE8._id_13A17 freescriptable();
    level._id_12CE8._id_13A17 = undefined;
  }
}

animatedprop_startanim() {
  var_0 = level._id_12CE8._id_145CC;

  if(isDefined(level._id_12CE8._id_12345))
    var_0 = level._id_12CE8._id_145CC - (gettime() - level._id_12CE8._id_12345) / 1000;

  return var_0;
}

anim_spawnposition_override(var_0) {
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_0, 500.0, 0.0, 0.4, 0, 0);
  level._id_12CE8._id_13A17 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(4, 11, 1, var_1);
  level._id_12CE8._id_13A17 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(1000);
  level thread anim_trafficking_play_scene(var_0);

  foreach(var_3 in level.players) {
    if(var_3.team == level._id_12CE8._id_13A17.owner.team) {
      continue;
    }
    level._id_12CE8._id_13A17 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(var_3);
  }
}

anim_trafficking_play_scene(var_0) {
  level endon("_encstr_BD211D91EDEC23BEA358D88EA536C2B1BEC8953B4B8D56EB91E4BDC11C5923");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
  var_1 = level._id_12CE8._id_13A17.owner;

  for(;;) {
    var_2 = (var_1.origin[0], var_1.origin[1], 1000);
    var_2 = var_2 + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 300);
    level._id_12CE8._id_13A17.mapcircle.origin = var_2;
    level._id_12CE8._id_13A17.guard_spawners = var_2;
    wait 4;
  }
}

anim_scene_stance_override() {
  if(!isDefined(level._id_12CE8._id_13A17.mapcircle)) {
    return;
  }
  level._id_12CE8._id_13A17 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_double_cargo();
}

scriptflags() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = self;
  var_0 scripts\mp\hud_message::showsplash("_encstr_A1A02316B62FB3FD53882F0341838F9A23CC5CCE95876B0559A847C770ED57E283E5E5468B");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8AA30BB3A76120BBF9ABF3F7BF", 0, level.players);
  var_0 thread anim_ref();
  var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar("_encstr_B8BA05F06B9785", 1);
  level waittill("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
  level._id_12CE8.lb_mg_dmg_factor_tail_stabilizer = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A3FD13AC1079608806E9B7E3F66A8D7B3B9BD01343", 0, level._id_12CE8.lb_mg_dmg_factor_tail_stabilizer);
  _id_13A18();
  var_0 scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  lootchopper_getspawnlocations(var_0);
}

anim_ref() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
  level endon("_encstr_BD211D91EDEC23BEA358D88EA536C2B1BEC8953B4B8D56EB91E4BDC11C5923");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_93DB11163647B43BC28E597DC8CAB9D127EDCB", 0, scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B"));
  wait 6;

  foreach(var_0 in scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"))
  var_0 thread _id_12D0B("_encstr_9B1F1730C79F4887B8C3E57E01876E3C29F78F430713826DB3");

  wait 4;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BDEF0D56BEF9826E3180BF4F48A827", 0, scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B"));
  wait 4;

  foreach(var_0 in scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"))
  var_0 thread _id_12D0B("_encstr_972E13B707997D23DEEC91AF5BED93AC7D3AA5AD59");

  wait 5;
  var_5 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_0 in var_5)
  var_0 thread _id_12F1C(3);

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_91A30E1DBC9678700B493940522F3DA0", 0, var_5);
  wait 5;

  foreach(var_0 in scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"))
  var_0 thread _id_12D0B("_encstr_91D41080EB9259E3076BE679CAE9CF0B2395");

  wait 6;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AC6A1048EA3281E1F973122B4D5B1F45584B", 0, scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B"));
  wait 5;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BA820908D0BB09B1B8B5F1", 0, scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B"));
  wait 7;
  var_5 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_0 in var_5)
  var_0 thread _id_12F1C(3);

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_87550C33D858CEF64EEB9DBDE656", 0, var_5);
  wait 4;
  var_5 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_0 in var_5)
  var_0 thread _id_12F1C(3);

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_9B840DCC1B58ECF69CD78D2B8527E6", 0, var_5);
}

_id_12048(var_0) {
  if(var_0.streakname == "_encstr_B8BA05F06B9785") {
    level notify("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
    return 0;
  }

  return undefined;
}

missing_window_blockers(var_0, var_1, var_2, var_3) {
  return _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::haskillstreak("_encstr_B8BA05F06B9785");
}

aigroundturret_requestmount() {
  var_0 = self;
  level endon("_encstr_BD211D91EDEC23BEA358D88EA536C2B1BEC8953B4B8D56EB91E4BDC11C5923");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AFEE11945823223129F0B35AD8737977FB351C");
  level endon("_encstr_957F1E99BDE46CCA7DB2DCC8F5E695E2AB56B9C6CA7D8E4BB595EBB12DD65A8E");
  level endon("_encstr_8A672C99DB933656BEB29B46EBB9CAC5D559CD8D95EBA3B45B59F537C1B2E63AD7B473BE9B85B6B2F5B91DB03A56");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    foreach(var_2 in level.teamdata[var_0.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
      var_2 thread scripts\mp\rank::giverankxp("_encstr_85531EAE02697D39E61F88180F5AB69912AB93A65F013120D433C073C71F2AE9", 100);
      var_2 thread scripts\mp\rank::scoreeventpopup("_encstr_85531EAE02697D39E61F88180F5AB69912AB93A65F013120D433C073C71F2AE9");
    }

    wait 5;
  }
}

updateghostridekills() {
  var_0 = self;
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(var_0.origin, var_0.origin + (0, 0, 10000), undefined, var_2))
    var_1 = 1;

  return var_1;
}

_id_1200D(var_0) {}

_id_1200F(var_0) {
  anim_weapon(1);
  level._id_12CE8._id_13A17 thread _id_13A1E(var_0);
  level thread animscripted_single();
  level._id_12CE8.plundereventtime delete();
}

_id_1200E(var_0) {}

_id_12CF3(var_0) {
  wait 12;
  scripts\mp\flags::gameflagset("_encstr_826B106410DE8387E8A47087FBAF4EB9CDBB");
  wait 8;
}

_id_12F1C(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 playlocalsound("_encstr_A31B17C493D795B3CACDE84CD7DC6C9C2CDA131B2BFACD99C3");
  var_1 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 4);
  var_1 setclientomnvar("_encstr_B40316EAB4AF6E6CC9855BC48DCAC9D7CD474EACDCB33AD0", 5);
  wait(var_0);
  var_1 stoplocalsound("_encstr_A31B17C493D795B3CACDE84CD7DC6C9C2CDA131B2BFACD99C3");
  var_1 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
  var_1 setclientomnvar("_encstr_B40316EAB4AF6E6CC9855BC48DCAC9D7CD474EACDCB33AD0", 0);
}

playerrespawn(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!istrue(level.br_prematchstarted) || istrue(level._id_12CE8.playerplunderbank))
    thread _id_126A4(1);
  else
    thread _id_12539();

  return 1;
}

_id_12539() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(level.gameended)) {
    return;
  }
  if(getdvarint("_encstr_937B16E66C4E7D89D6DED7ABE62BFA37C12CBBB9FA99D287", 1) == 1)
    self endon("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");

  var_0 = 0;
  var_1 = 5;
  var_2 = 2;
  thread _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::patchfix(var_2);
  wait 1;
  var_3 = getdvarint("_encstr_8DD31BB307501143F63EFBB223458715E14D673BB960A32B0853C27A8B", 5);
  scripts\engine\utility::ent_flag_init("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  var_4 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_AA48117347537FEF4F5072DBF877A72789ADE0", var_1);
  self notify("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");
  self._id_1286F = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getspawnpoint(1);
  var_5 = 2500;
  var_6 = scripts\engine\utility::drop_to_ground(self._id_1286F.origin, 1500, -20000);
  var_7 = (0, 0, var_5);
  self._id_1286F.origin = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getoffsetspawnorigin(var_6, var_7);
  var_8 = self._id_1286F;
  scripts\engine\utility::ent_flag_clear("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagwinnerrespawn(1, undefined, var_8, 1, var_8.origin, 1, undefined, undefined, undefined, 1);
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawncover_badnodetest();
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  scripts\mp\damage::resetplayervariables();
}

_id_126A4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_1286F = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getspawnpoint(1);
  var_1 = 1300;
  var_2 = scripts\engine\utility::drop_to_ground(self._id_1286F.origin, 1500, -20000);
  var_3 = (0, 0, var_1);
  self._id_1286F.origin = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getoffsetspawnorigin(var_2, var_3);
  scripts\mp\playerlogic::waitandspawnclient(0);
  self freezecontrols(1);

  if(!istrue(level.skipprematchdropspawn))
    thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::prematchdeployparachute();

  while(!isalive(self))
    waitframe();

  waitframe();

  if(!istrue(game["_encstr_95810CA5B9982DEC9526DEC426F2"])) {
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptednode(self);
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
  }

  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawncover_badnodetest();
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
  self skydive_setdeploymentstatus(1);
  self skydive_setbasejumpingstatus(1);
  var_4 = !self calloutmarkerping_getEnt();
  var_5 = gettime();

  if(var_4) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var_5 + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
  self.waitingtospawn = 0;
  self freezecontrols(0);

  if(var_0)
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);
}

_id_1366F() {
  level.delete_script_object = [];
  level._id_12864 = [];
  level.prematchspawnoriginsforteams = undefined;
  level.delete_script_object = [_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-3589, 672, 2169), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-435, 6921, 1807), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-4721, 4432, 675), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-3928, -9, 820), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-577, -9128, 265), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((3953, -5968, 502), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((3702, -1636, 1214), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-25, -1305, 1970), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-330, 3351, 1900), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((3839, 167, 610), 0, 900)];
  level.prematchspawnorigins = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getprematchlocationspawnorigins();

  for(var_0 = 0; var_0 < level.delete_script_object.size; var_0++)
    level._id_12864[level._id_12864.size] = 0;
}

_id_13670() {
  level.delete_script_object = [];
  level._id_12864 = [];
  level.prematchspawnoriginsforteams = undefined;
  level.delete_script_object = [_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((1302, 1719, 2013), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-229, 785, 2061), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((2137, -2813, 2076), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((833, 4426, 1825), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-1775, -3274, 2337), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((3702, -1636, 1214), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-25, -1305, 1970), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-3260, 309, 2087), 0, 900), _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::createspawnlocation((-1510, -3522, 1888), 0, 900)];
  level.prematchspawnorigins = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getprematchlocationspawnorigins();

  for(var_0 = 0; var_0 < level.delete_script_object.size; var_0++)
    level._id_12864[level._id_12864.size] = 0;
}

_id_12862() {
  return 0;
}

dyn_door(var_0) {
  return 1;
}

onspawnplayer() {
  self notify("_encstr_A1E00B25BA2FD7DBEA6085B830");

  if(isagent(self)) {
    return;
  }
  var_0 = istrue(self.gulag);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer(var_0);
  _encstr_8C492BEBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6ECB488EA33B402AFA808093ADD09D8F63FF::initplayer();
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::teamfriendlyto();
  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  self.healthregendisabled = 0;
  self.br_lastscenecheck = gettime();
  self.needtoplayintro = undefined;
  self.gunnlessweapon = undefined;
  level.superdelay = 0;
  level.superpointsmod = 1;
  self.br_perks = [0, 0, 0, 0, 0];
  self.br_perkpoints = 0;

  if(istrue(level._id_121C8))
    self getclientomnvar();
  else
    self weaponswitchbuttonPressed();

  if(istrue(level._id_121C9))
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();
}

emp_drone_proximity_explode(var_0) {
  var_1 = 0.5;

  if(!isDefined(self._id_1286F) || self calloutmarkerping_getEnt()) {
    self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
    return;
  }

  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::emp_drone_should_take_damage();
  self.thrust_fx_model = undefined;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  self freezecontrols(0);
}

setupmapquadrantcornersandgrid() {}

onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  if(isDefined(var_0) && isDefined(var_0.inflictor) && isDefined(var_0.inflictor.classname) && (var_0.inflictor.classname == "_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B" || var_0.inflictor.classname == "_encstr_85FE0DD5727A27098513298817CA23") && isDefined(level._id_12CE8) && isDefined(level._id_12CE8._id_13A17) && isDefined(level._id_12CE8._id_13A17.owner) && var_0.victim == level._id_12CE8._id_13A17.owner) {
    _id_12CAF();
    return;
  }

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || !isDefined(var_0.victim) || var_0.attacker == var_0.victim) {
    return;
  }
  var_1 = var_0.attacker.team;

  if(!isDefined(level.teamdata[var_1]["_encstr_8E8D0697EB01F243"]))
    level.teamdata[var_1]["_encstr_8E8D0697EB01F243"] = 0;

  level.teamdata[var_1]["_encstr_8E8D0697EB01F243"]++;

  if(isDefined(level._id_12D05)) {
    if(!istrue(level.br_prematchstarted)) {
      return;
    }
    if(level.gameended) {
      return;
    }
    var_2 = var_0.victim;
    var_3 = var_0.attacker;

    if(!isDefined(var_3) || !isPlayer(var_3) || !isDefined(var_2)) {
      return;
    }
    return;
  }
}

lootchopper_getspawnlocations(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.team, "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1) {
    var_4 = var_3 == var_0;
    var_3 dlog_recordplayerevent("_encstr_AC221249DDA7F06082032B35230936807F37D083", ["_encstr_A75C0EAFED57906BBF59A01083D30728", var_4]);
  }
}