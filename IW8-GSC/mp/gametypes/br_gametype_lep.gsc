/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_lep.gsc
***********************************************/

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

doteamextractedupdate() {
  level.scr_animtree["_encstr_87440B6AA23FD88937DF636A43"] = #animtree;
  level.scr_anim["_encstr_87440B6AA23FD88937DF636A43"]["_encstr_B4B70E28CA6585E9830F6F6909CBD16F"] = % _encstr_856921BBF009010F8268B5CB1F4E13555B603273B9F5C5C7996FBA810C96EF5DF7A0AA;
  level.scr_animname["_encstr_87440B6AA23FD88937DF636A43"]["_encstr_B4B70E28CA6585E9830F6F6909CBD16F"] = "_encstr_856921BBF009010F8268B5CB1F4E13555B603273B9F5C5C7996FBA810C96EF5DF7A0AA";
  level.scr_animtree["_encstr_97C50E30FD5BC34F070A3030F36A035B"] = #animtree;
  level.scr_anim["_encstr_97C50E30FD5BC34F070A3030F36A035B"]["_encstr_B40A0CA663DFCD0CDFAF9B53FFA4"] = % _encstr_A9301F8C4D9CEE7728C7A388F96622F7C58881F667402B2B99FB6A79B4DDA7F74B;
  level.scr_animname["_encstr_97C50E30FD5BC34F070A3030F36A035B"]["_encstr_B40A0CA663DFCD0CDFAF9B53FFA4"] = "_encstr_A9301F8C4D9CEE7728C7A388F96622F7C58881F667402B2B99FB6A79B4DDA7F74B";
  level.scr_animtree["_encstr_A9190F1FB5A328B7FFFAC970721BD6587B"] = #animtree;
  level.scr_anim["_encstr_A9190F1FB5A328B7FFFAC970721BD6587B"]["_encstr_B40A0CA663DFCD0CDFAF9B53FFA4"] = % _encstr_A2301F5D273218BBBA1163BB86B7E048DA93E3DD377AF73AC7F70851AC7E105F47;
  level.scr_animname["_encstr_A9190F1FB5A328B7FFFAC970721BD6587B"]["_encstr_B40A0CA663DFCD0CDFAF9B53FFA4"] = "_encstr_A2301F5D273218BBBA1163BB86B7E048DA93E3DD377AF73AC7F70851AC7E105F47";
}

drone_death_cleanup() {
  level._effect["_encstr_8E3916FD7610F136CB097841E3A77C506DDD4541273F9007"] = loadfx("_encstr_BDE334D999C379D2EEE0D726E479D9C26B950E3685F2E5CAEC2B37A3BCB333C3EB3139BE365938EB3BE4BDD57346FA56870E5C3B99C3");
}

init() {
  level thread downedwithbombweapon();
  level thread dragonsbreathdamage();
  level thread dovoforleaderinterrogated();
  level thread downed_reviver_watch_for_return_to_usability();
  level thread _encstr_95992DE6D827D21C3A6EF2ADE0BC9DC2B6953ABC0E56B9F28939D7760BD6593AE583CABE4E59C4D2C9D143719DE6C6::enabledskiplaststand();
  level thread doteamextractedupdate();
  level._id_13BD1 = ::helidrivabledeathall;
}

downedwithbombweapon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarint("_encstr_B13711BFD77BF0701AB9F8D19ACFB81592171F", 0) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");
}

dragonsbreathdamage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  drone_death_cleanup();
  level thread scripts\mp\utility\sound::besttime("_encstr_8C40111023D1C3C3877625885CAF4BEF820AB8");
  double_agent();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8C100FC793A0BFF07F07F30773956AE520");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BA430C806BCF931D8257A1C8AD6B");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BE94109AA047C32EB04BFAD347D0352F765B", ::drop_new_carepackage);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8F3D13CD2304CAAA680143B51793A9A5EFED1F937D", ::dorpgambushvo);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_81EC15B516C11A959B1D9527645ACDC28D68D2E48D36B2", ::drop_platform);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_96F01524FD4B55733DBAD0A152521F686743BD2844D71B", ::drop_platform);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_AD5B19389C2BD0C28D1B6A58CC59D05A93D81BACD0599B1D2BC9DC", ::dropaccesscard);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::drop_support_crate_intro);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9A8B0EBDB986F69B3A4E851B3A8A3719", ::drop_max);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8106123B24BF78D3DBDC083511D5719BA1AE6345", ::drop_support_crates);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_959211381051B3070B4EBC2E96C9A3937312EA", ::drop_minigun);
  waittillframeend;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7", ::doarmsracelocationnags);
  doapcdamagevo();
  level.delete_players_black_screen = ::drop_weapon_scripted;
  level.disable_back_light = 1;
  downangles();
  level._id_140D9 = [];
  level._id_123AB = spawnStruct();
  level._id_123AB.player_fov_default_1 = [];
  level._id_123AB.audio_player_spawn_mud_loop = [];
  level._id_123AB.audio_player_start_mud_loop = [];
  level._id_123AB._id_11B1B = [];

  switch (level.mapname) {
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      download_progress();
      level thread dropped_weapon();
      break;
    case "_encstr_8CD508CA98A70FAFC01D":
      level._id_123AB._id_12F8B = [];
      level._id_123AB._id_13B2E = [];
      level thread dropped_weapon_cleanup();
      break;
  }

  level thread dragonsbreathhitloccollection();
  downed_player();
  downtown_helicopter_start();
  dotmtylgroup();

  if(!isDefined(level.ctgs_comparestats))
    level.ctgs_comparestats = spawnStruct();

  level thread dropcircle();
  level thread drop_in_progress();
  level thread drones_spawning();
  level thread doteamcirclebattlechatter();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::drop_locations);
}

dragonsbreathhitloccollection() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  dropbrkillstreak("_encstr_91A112B50EEB91BDDCD0F5D89507D76E8E8527D1", undefined, 1);
}

double_agent() {
  level.weapon_should_not_get_ammo = [(-20473, -5682, -738), (134, 18667, -792), (35557, 24084, -198)];
  level.weapon_pick_up_monitor = [[(-22749, -7178, -678), (-18213, -4752, -678)], [(-1047, 21103, -733), (1082, 16414, -733)], [(37656, 24942, -140), (33145, 22862, -140)]];
  level.weapon_buy_point_watch_death = [];

  foreach(var_7, var_1 in level.weapon_should_not_get_ammo) {
    var_2 = 1;
    var_3 = var_1;

    foreach(var_5 in level.weapon_pick_up_monitor[var_7]) {
      var_2++;
      var_3 = var_3 + var_5;
    }

    var_3 = var_3 / var_2;
    level.weapon_class[var_7] = var_3;
  }

  var_8 = scripts\engine\utility::array_randomize([0, 1, 2]);
  level.weapon_xp_iw8_ar_kilo433 = var_8[0];
  level.weapon_xp_iw8_ar_golf36 = level.weapon_should_not_get_ammo[level.weapon_xp_iw8_ar_kilo433];

  if(var_8[0] != 1 && var_8[1] != 1) {
    var_8[2] = var_8[1];
    var_8[1] = 1;
  }

  level.weapon_box_cache_use = var_8;
}

doapcdamagevo() {
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

dovoforleaderinterrogated() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_970E16454B71B5C0F18D704979D1B07B9B4F3BD1BF8B8D70");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA290F923A2D10B1C695C06DA81A2853B2"] = "_encstr_B89313C1EDDDCA9C76E41631F556DC56DA2FBE4D81";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB8D12124A74EF55A9930E0DABB0515FA5819B8B"] = "_encstr_B4421869E567E335CF0A5B71EFBA60388D2F8017F2E3E55D05BA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9ABE1089384E6019C1AF9D83E7CBC8C8E915"] = "_encstr_85DD1883683C1F12A87DC1CA0F905D4769C2093BB39ECF0FF067";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD300C9587334B63F5E495C29197"] = "_encstr_95F90C950F334B1BF5DCA3B04E3A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A523129732A172B131614DF4578A95A543272B63"] = "_encstr_ACDD1607BDDDAC273B935826F566274B569B8C635EEBD460";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D0115591E994BB1D733C95ACAE623D85EF5CD470BE4A3"] = "_encstr_919A1B09873BC8E647F3E189492B9ED0D7EEB9B929E930A7C3AB7BF3F2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A73213B8806577588F73CA39EB4E235520114BEB38"] = "_encstr_9B3E1BC1BDDDB293EC932C267DCC9CB42BE6238DCBFADC57C68D5637DC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D861089DB8FC7E017163810235367EB7553"] = "_encstr_B65E1783DEBBB239ECE4584CD79EED73CA7D6C7BE61DCA9B1D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_827F0CA01ADBB640298B192B92CB"] = "_encstr_96100DA43008803117708F97F24717";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE0D0BE3877A8DB92C173B312A"] = "_encstr_A9431247A3304D23902005611109465636502773";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD0D0BE55098DD419D636F17F5"] = "_encstr_A1850B3A1A28E82AEF12E3B7DE";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8ED01292606978F750A30111511FCB772F40D79B"] = "_encstr_88D7126C86B0C6D859CDB3ACEBB9EAD88D599BB9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D961129070B413DBF7DD107C768087AB93932"] = "_encstr_A5970D71E52D50E87BF393B9BB2246";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2D4129AF1671FFE10AB1ADF5BE0461701E83292"] = "_encstr_B21C0EC4DE5B4CAF5AE636DB6B5AE69D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84E3118AE1772F0E10853714B3B0D7231619F3"] = "_encstr_97700D0B2DC9FA32B299ACCDD8ACB9";
}

downed_reviver_watch_for_return_to_usability() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
}

download_progress() {
  var_0 = "_encstr_874F1C7721289ACA4920FF827EA8E943C881F7B7EB2D929FA8AB254E13D0";

  for(var_1 = int(tablelookuprownum(var_0, 0, "_encstr_A34C02BB")); tablelookupbyrow(var_0, var_1, 0) == "_encstr_A34C02BB"; var_1--) {
    var_2 = [];
    var_2[0] = (int(tablelookupbyrow(var_0, var_1, 1)), int(tablelookupbyrow(var_0, var_1, 2)), int(tablelookupbyrow(var_0, var_1, 3)));
    var_2[1] = (int(tablelookupbyrow(var_0, var_1, 4)), int(tablelookupbyrow(var_0, var_1, 5)), int(tablelookupbyrow(var_0, var_1, 6)));
    level._id_123AB.player_fov_default_1 = do_ascender_entrance(level._id_123AB.player_fov_default_1, var_2[0], var_2[1]);
  }

  level.weapon_xp_iw8_ar_golf36 = (-265, -4121, 58);
}

downtown_gw_ambient_sound_load() {
  var_0 = "_encstr_874F1C7721289ACA4920FF827EA8E943C881F7B7EB2D929FA8AB254E13D0";
  var_1 = level.br_level.default_class_chosen[3];
  var_2 = level.br_level.br_circleradii[3];

  for(var_3 = 0; tablelookupbyrow(var_0, var_3, 0) == "_encstr_934C0218"; var_3++) {
    var_4 = [];
    var_4[0] = (int(tablelookupbyrow(var_0, var_3, 1)), int(tablelookupbyrow(var_0, var_3, 2)), int(tablelookupbyrow(var_0, var_3, 3)));
    var_4[1] = (int(tablelookupbyrow(var_0, var_3, 4)), int(tablelookupbyrow(var_0, var_3, 5)), int(tablelookupbyrow(var_0, var_3, 6)));

    if(distance2d(var_1, var_4[0]) > var_2) {
      level._id_123AB.player_fov_default_1 = do_ascender_entrance(level._id_123AB.player_fov_default_1, var_4[0], var_4[1], 1);
      continue;
    }

    level._id_123AB._id_13B2E = do_ascender_entrance(level._id_123AB._id_13B2E, var_4[0], var_4[1], 1);
  }

  for(var_3 = int(tablelookuprownum(var_0, 0, "_encstr_A74C0222")); tablelookupbyrow(var_0, var_3, 0) == "_encstr_A74C0222"; var_3--) {
    var_4 = [];
    var_4[0] = (int(tablelookupbyrow(var_0, var_3, 1)), int(tablelookupbyrow(var_0, var_3, 2)), int(tablelookupbyrow(var_0, var_3, 3)));
    var_4[1] = (int(tablelookupbyrow(var_0, var_3, 4)), int(tablelookupbyrow(var_0, var_3, 5)), int(tablelookupbyrow(var_0, var_3, 6)));
    level._id_123AB._id_12F8B = do_ascender_entrance(level._id_123AB._id_12F8B, var_4[0], var_4[1], 1);
  }

  for(var_3 = 0; tablelookupbyrow(var_0, var_3, 7) != "_encstr_B40101"; var_3++)
    do_cache_2_prep(int(tablelookupbyrow(var_0, var_3, 7)), int(tablelookupbyrow(var_0, var_3, 8)));
}

downed_player() {
  dropbrlootchoppercrate("_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  dropbrlootchoppercrate("_encstr_859A1183D94B3B2548D56447E7202A93F5133A", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  dropbrlootchoppercrate("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", 0);
  dropbrlootchoppercrate("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", 0);
  dropbrlootchoppercrate("_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", 1);
  dropbrlootchoppercrate("_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", 1);
  dropbrlootchoppercrate("_encstr_8202100F51F881C7C0F2255890A5865376FF", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", 1);
  _encstr_BD8926CDD8E42D073A9B976B0ECBCEC2B6B21DCBC1596E79C427EB197BB5AF2EAB95B947B83B37B1::_id_13239();
}

dropbrlootchoppercrate(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "_encstr_A22F2FEA4BEBD683EB1393EB6BB038ADCA73EAAF96D8DEB9EBCEAEC658ECBEDBEC9527E8A56B2BAFDE31A9956C3A4BCECA";
  level.waypointpulses[var_0] = var_3;
}

downtown_helicopter_start() {
  var_0 = [["_encstr_92D11FD25BF8E8083D47EF1FB0A09B2C4AFBF99F59314FEF419F5A5BEF72503771", 1], ["_encstr_9A5215896221373A0B01AFB325B81AAA9F07DAE97FD76B", 1], ["_encstr_81D6144C4E63B7F6477D7B9933342CB9327D339358D9", 1], ["_encstr_96B6164C938DDEDEA3D7B73399D00BDC46D7E6B2B5A3B20F", 1], ["_encstr_8C3B18F6BA7B200FCB2998D892E4CBD8B36F867801B3EB497583", 1], ["_encstr_B6CD1D26398DF67BD1BEDAD2361BCD47392B856DAF932BD8EDE623E4BDB9CA", 1], ["_encstr_B48D190EDBF0FF7ABD3FB7A789ED73171881461793A0B492985F17", 1]];
  var_1 = 0;
  level.weapon_xp_iw8_ar_sierra552 = spawnStruct();
  level.weapon_xp_iw8_ar_sierra552.itemlist = [];

  foreach(var_3 in var_0) {
    var_4 = var_3[1];
    var_1 = var_1 + var_4;
    var_5 = spawnStruct();
    var_5.name = var_3[0];
    var_5._id_12D81 = var_1;
    level.weapon_xp_iw8_ar_sierra552.itemlist[level.weapon_xp_iw8_ar_sierra552.itemlist.size] = var_5;
  }

  level.weapon_xp_iw8_ar_sierra552._id_13BF6 = var_1;
}

drop_support_crate_intro() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;

  if(!istrue(game["_encstr_B23913A2485CFF7D08BDE2F117E0FD7389619BBA71"]))
    scripts\mp\hud_message::showsplash("_encstr_A31814C493D7C193CAADC21DD81AEBDDACD81BDB6B2B");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("_encstr_8F7D08C66A0125438523");
    thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_BE0D0BE3877A8DB92C173B312A", self);

    while(!self isonground())
      waitframe();

    thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_BD0D0BE55098DD419D636F17F5", self);
  } else
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);
}

dotmtylgroup() {
  level._id_13B41 = "_encstr_8286169D333CD7269CAFD82B38FAC4B7D6C45927FA958738";
  level._id_13B46 = getdvarfloat("_encstr_B1062C4A267D69D4A838273F6026B5F2015092461D93031B96087B0B9098751BF7D71A7D7D354A6F5B18272FD853", 500);
  level._id_13B47 = getdvarfloat("_encstr_AD482C371B39EB1D864ECAB0D1D75B96DCEBE48546D25DE6FADC3A4E2DDA2BCDF5854EEDAE7391F5C11B2CE52B93", 10);
  level._id_13B45 = getdvarint("_encstr_850C21573F931818A85A61F9C3B7D8C30BABF7DFEFAA5879E8F78B362A64B8F3D21747", 1);
  level._id_13B48 = getdvarfloat("_encstr_825932CD1BC97DA31AC92BB0A3EB47434B1B5BE6B2E6CDEB270B8C5A5DB9D7B9D1C9965B2BB97DB04EDED5738CEBE0D80B97AC39", 10);
  level._id_13B43 = getdvarfloat("_encstr_8C3B217EAB032639CCFBC8E0B329C1B9935183E002E70B77F792A8093B3BA570D7FD0E", 0.3);
  level._id_13B49 = getdvarfloat("_encstr_B21428B9C627AFD10DE4ACB0E8FAB3B039B4AC19AF2395B158F2BE26591DBBB295E6BEDC1D2796B65637", 0.5);
  level._id_13B44 = getdvarint("_encstr_83111C6EC693FA3A1A275616E8AF59F00736BD6ED2F6B97D46B05B0B9D2B", 0);
}

downangles() {
  level.multieventdebug = spawnStruct();
  level.multieventdebug._id_142AF = "_encstr_BE4C0BB60EFA639583FA2BE623";
  level.multieventdebug._id_142AE = 76;
  level.multieventdebug.unmarkplayeraseliminated = 1;
}

drop_new_carepackage(var_0) {
  level thread dropbrlootchoppercrateforpublicevent(var_0);
}

dropbrlootchoppercrateforpublicevent(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(isDefined(level._id_142D1))
    var_0 visionsetnakedforplayer(level._id_142D1, 0);
}

doteamcirclebattlechatter() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 1.5;
  dropbrkillstreak("_encstr_8B3612DD8B79E48A401917C7857CD254D19057E2", 0.5);
  level waittill("_encstr_ACCC194B7366B48DD73A4E16E69B4BD1D2F637D7B134ED1C38B2C9");
  dropbrkillstreak("_encstr_8CD508CA98A70FAFC01D");
  waitframe();
  dropbrkillstreak("_encstr_91A112B50EEB91BDDCD0F5D89507D76E8E8527D1");
}

dorpgambushvo() {
  level thread doteleporttosafehouse();
  level thread draw_cross_forever();
  level thread doorstate();
}

draw_cross_forever() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_ACD1141393F536AC1CAF2DE647937B91EA363A5AB737");
}

drop_platform() {
  return level.weapon_xp_iw8_ar_golf36;
}

dropaccesscard() {
  for(var_0 = 6; var_0 > 3; var_0--)
    do_exfil_vo(1, var_0);

  for(var_0 = 3; var_0 > 1; var_0--)
    do_exfil_vo(2, var_0);

  for(var_0 = 1; var_0 >= 0; var_0--)
    do_exfil_vo(3, var_0);
}

doorisclosed(var_0) {
  var_1 = [];

  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595")
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  return var_1;
}

drop_weapon_scripted(var_0) {
  thread dopunishhelivocalls(doorisclosed(var_0));
  thread dom();
  var_1 = dontspawnjeep();

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      var_3 scripts\mp\utility\player::_freezecontrols(1);
      var_3 calloutmarkerping_getinventoryslot(0.0);
      var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_1.origin);
    }
  }

  wait 8;

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      if(scripts\mp\utility\player::unset_relic_trex(var_3))
        var_3 scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", var_3);

      var_3 setclientomnvar("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 0);
      var_3 setclientomnvar("_encstr_A5011EAB96BE13C97D9B2E570B91D79536D26B2DB985A3B232EB58B1E8B49D56", 0);
      var_3.plotarmor = 1;
      var_3 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack(1);
    }
  }

  wait 1;
  dorestartvo();
  level thread dropbrhealthpack();
  level thread doleaderinterrogationnag();

  foreach(var_3 in level.players) {
    if(isDefined(var_3))
      var_3 thread scripts\mp\playerlogic::spawnintermission(var_1, undefined, 0);
  }

  wait 1.5;
  dropbrkillstreak("_encstr_BA0D100523483337B5F249249D5067687065", 0);

  foreach(var_3 in level.players) {
    if(isDefined(var_3))
      var_3 thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
  }

  wait 2;
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 15);
  wait 8;
}

drop_max(var_0) {
  if(getdvarint("_encstr_AF5A279BB1C9FA8D2B83F5E60DB7BBAF071B2CB9597D2D6CDB9BFA1699475639AF6CED733A4E166C47", 0) > 0) {
    foreach(var_2 in level._id_123AB.audio_player_spawn_mud_loop)
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2, self);

    level._id_123AB._id_11B1B = scripts\engine\utility::array_remove(level._id_123AB._id_11B1B, self);
  } else if(!istrue(self.highlighttoteam)) {
    foreach(var_2 in level._id_123AB.audio_player_spawn_mud_loop)
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2, self);

    foreach(var_2 in level._id_123AB.audio_player_start_mud_loop)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_2, self);

    level._id_123AB._id_11B1B = scripts\engine\utility::array_remove(level._id_123AB._id_11B1B, self);
  }
}

drop_support_crates(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread drop_type();
  return undefined;
}

drop_type() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AC211A091DBAD07DD16B231B67DBAE9045F6B361431521278B5F1319");

  if(isDefined(level._id_142D1))
    self visionsetnakedforplayer(level._id_142D1, 0);

  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(isDefined(level._id_142D1))
    self visionsetnakedforplayer(level._id_142D1, 0);
}

dontspawnjeep() {
  var_0 = spawnStruct();
  var_0.origin = (-13871, -22965, 1193);
  var_0.angles = (358, 59, 0);
  return var_0;
}

dorestartvo() {
  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE") {
    return;
  }
  var_0 = level.br_circle.circleindex;
  _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::spawn_carriable_at_struct();

  if(level.br_level.default_suicidebomber_combat[var_0] > 0)
    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::spawn_dummy_crate();

  _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::all_players_are_in_trap_room_entrance();
  setomnvar("_encstr_9B391B25C4695DDBCF07C8E8FF04F131B1EA1DA79AB35F61D673C0D0BF", undefined);
}

dropbrhealthpack() {
  dropoff();
  level endon("_encstr_861F0CBF8117989903787A707FC0");
  thread extractlocale_createquestlocale((7747, 12827, 0));
  wait 13.5;
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));

  for(;;) {
    level thread dropbrweapon(var_0);
    wait 13.5;
  }
}

#using_animtree("_encstr_B40101");

extractlocale_createquestlocale(var_0) {
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_1.origin = var_0;
  var_2 = getanimlength(%_encstr_A9301F8C4D9CEE7728C7A388F96622F7C58881F667402B2B99FB6A79B4DDA7F74B);

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = 13.5 * var_3 / var_2;
    thread dropbrweapon(var_1, var_4);
  }

  scripts\engine\utility::_id_143BF(var_2, "_encstr_861F0CBF8117989903787A707FC0");
  var_1 delete();
}

#using_animtree("_encstr_B40101");

dropbrweapon(var_0, var_1) {
  var_2 = dropbrsuperfulton("_encstr_97C50E30FD5BC34F070A3030F36A035B");
  var_3 = dropbrsuperfulton("_encstr_A9190F1FB5A328B7FFFAC970721BD6587B");
  var_4 = [var_2, var_3];
  var_5 = getanimlength(%_encstr_A9301F8C4D9CEE7728C7A388F96622F7C58881F667402B2B99FB6A79B4DDA7F74B);
  var_0 thread scripts\common\anim::anim_single(var_4, "_encstr_B40A0CA663DFCD0CDFAF9B53FFA4");

  if(isDefined(var_1)) {
    var_0 scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time, var_4, "_encstr_B40A0CA663DFCD0CDFAF9B53FFA4", var_1);
    var_5 = var_5 - var_1 * var_5;
  }

  scripts\engine\utility::_id_143BF(var_5, "_encstr_861F0CBF8117989903787A707FC0");
  var_2 delete();
  var_3 delete();
}

dropbrsuperfulton(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_1 setModel("_encstr_88091AD4F099830B01274030F75A81C5E19E6F7C01C361B1FBE7DAEA");
  var_1.animname = var_0;
  var_1 useanimtree(level.scr_animtree[var_0]);
  return var_1;
}

doleaderinterrogationnag() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_13B41 = "_encstr_9B9C1A4355AB61F2186E652F63993ABA89F5B7DBBF5D5BB849311D77";
  level._id_13B46 = 12000;
  level._id_13B47 = 4000;
  level._id_13B45 = 10;
  level._id_13B48 = 4000;
  level._id_13B43 = 0.1;
  var_0 = 11.5;

  for(;;) {
    level thread _hidesafecircleui::chase(var_0, (-6937, -15094, 2876), 1);
    wait(var_0);
  }
}

drop_minigun() {
  if(isDefined(level.weapon_xp_iw8_ar_falima) && isDefined(level.weapon_xp_iw8_ar_falima.oil_puddles))
    thread drop_intel_on_death_regardless();
}

drop_intel_on_death_regardless() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 1;

  while(var_0) {
    var_1 = scripts\engine\utility::_id_143B0("_encstr_A344148634FF4BA91712A1F83A6D4D6653CD8C73AE7F", "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69", "_encstr_869814AB9BD8AF6A50394BAF218B22C6C066E7367028", "_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    thread dropbrgasmask(self);

    if(isDefined(self.laststandreviveent))
      thread dropbrgasmask(self.laststandreviveent.reviver);

    switch (var_1) {
      case "_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A":
      case "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69":
      case "_encstr_AD75063D571AE108":
        var_0 = 0;
        break;
      case "_encstr_869814AB9BD8AF6A50394BAF218B22C6C066E7367028":
      case "_encstr_A344148634FF4BA91712A1F83A6D4D6653CD8C73AE7F":
      default:
        break;
    }
  }
}

dropbrgasmask(var_0) {
  if(isDefined(var_0)) {
    waitframe();
    var_1 = level.weapon_xp_iw8_ar_falima.oil_puddles;

    if(var_1.claimteam == "_encstr_8BBA05185F8B99" && !isDefined(var_1.lastprogressteam))
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 17);
    else if(istrue(var_1.stalemate))
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 20);
    else if(var_0.team == var_1.lastprogressteam)
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 18);
    else
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 19);

    var_2 = 0;

    if(isDefined(var_1.lastprogressteam))
      var_2 = var_1.teamprogress[var_1.lastprogressteam] / var_1.usetime;

    var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_2);
  }
}

do_exfil_vo(var_0, var_1) {
  if(var_0 > 0) {
    var_2 = level.weapon_class[level.weapon_box_cache_use[0]];

    for(var_3 = 1; var_3 < var_0; var_3++)
      var_2 = var_2 + level.weapon_class[level.weapon_box_cache_use[var_3]];

    var_2 = var_2 / var_0;
    var_4 = 0;

    for(var_3 = 0; var_3 < var_0; var_3++) {
      var_5 = [level.weapon_should_not_get_ammo[level.weapon_box_cache_use[var_3]]];

      foreach(var_7 in level.weapon_pick_up_monitor[level.weapon_box_cache_use[var_3]])
      var_5 = scripts\engine\utility::array_add(var_5, var_7);

      foreach(var_10 in var_5) {
        var_11 = distance2d(var_2, var_10);

        if(var_11 > var_4)
          var_4 = var_11;
      }
    }

    var_13 = var_1 + 1;
    var_14 = var_2 - level.br_level.default_class_chosen[var_13];
    var_15 = length2d(var_14);
    var_16 = var_15 + level.br_level.br_circleradii[var_13];
    var_17 = max(var_4, var_16);
    var_18 = level.br_level.br_circleradii[var_1];

    if(var_18 < var_17) {
      var_19 = 1.0 - var_18 / var_16;
      var_20 = var_14 * (var_16 / var_15);
      level.br_level.default_class_chosen[var_1] = var_2 - var_20 * var_19;
      return;
    }

    var_21 = var_18 - var_17;
    var_22 = var_21 / var_18;
    level.br_level.default_class_chosen[var_1] = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_2, var_18, var_22, var_22);
    return;
  } else
    var_2 = level.weapon_xp_iw8_ar_golf36;
}

door_is_frozen(var_0) {
  var_1 = 0;

  foreach(var_3 in level.weapon_should_not_get_ammo) {
    var_4 = level.br_level.default_class_chosen[var_0];
    var_5 = level.br_level.br_circleradii[var_0];

    if(scripts\engine\utility::updatescrapassistdata(var_3, var_4, var_5))
      var_1++;
  }

  return var_1;
}

double_wood_stack() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_88E91C83F2AB86A36BB0A5A8B359A25B938820E5C08807761F9A8E1BE04D", 0);

  if(!var_0) {
    return;
  }
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6060E6ADAC0612AB8357B2143C3E7EB"] = "_encstr_9B5A0A1BB3FA734ECE0F9818";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D7B12F007E0665BC327C1C03CBAB9E94AAF1BA8"] = "_encstr_A50C0ED0E36568A89AABF1EBE3228EE8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2A114D00A9BF848542999E16FFE60B9C332495B9223"] = "_encstr_8172130FC0A9E44A5BA047FFAF7F32BDD3886FDB30";
  level.weapon_xp_iw8_lm_mgolf34 = [];
  level waittill("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623");
  var_1 = "_encstr_83FB1CD60E79984E7DC6B283EB3686C2EB1BDB360BD1B47BDC9BB8B1B9B3";
  var_2 = 0;
  var_3 = [];
  var_3[0] = ["_encstr_91742264A04ED0B091F532E7E9B9A890571FC27015E8BFB12B23033975F7F92B61CE8277", 1];
  var_3[1] = ["_encstr_82E61432568DF69C7DD62D8D937B3886DECD2B7D064C", 3];
  var_3[2] = ["_encstr_851020792782B7289F5BE018C389C84DF997EBDFEBA956A8FFF4AB53AF62D1F6E24E", 3];
  var_3[3] = ["_encstr_8A2A268B658FBF86C14B3FDBCFC16FEE15A538C8C8D12F4A3CCB5703423F99490F2B4F59608B90BF", 4];
  var_3[4] = ["_encstr_B23329932F802A2BC6AB3A5330908BE9208B061D37B8F07B6740925B99E0E71AA829855FEDE87D3BAFD3EF", 2];
  var_3[5] = ["_encstr_8AED0D267BC2477D9BB2E8AF8D5983", 2];

  for(;;) {
    var_4 = tablelookupbyrow(var_1, var_2, 0);

    if(var_4 == "_encstr_B40101") {
      break;
    }

    var_5 = int(tablelookupbyrow(var_1, var_2, 10));
    var_6 = var_5 - 1;

    if(var_6 > var_3.size) {
      continue;
    }
    var_7 = [];
    var_8 = [];

    for(var_9 = []; int(tablelookupbyrow(var_1, var_2, 10)) == var_5; var_2++) {
      var_7[var_7.size] = (float(tablelookupbyrow(var_1, var_2, 1)), float(tablelookupbyrow(var_1, var_2, 2)), float(tablelookupbyrow(var_1, var_2, 3)));
      var_8[var_8.size] = (float(tablelookupbyrow(var_1, var_2, 4)), float(tablelookupbyrow(var_1, var_2, 5)), float(tablelookupbyrow(var_1, var_2, 6)));
      var_9[var_9.size] = (float(tablelookupbyrow(var_1, var_2, 7)), float(tablelookupbyrow(var_1, var_2, 8)), float(tablelookupbyrow(var_1, var_2, 9)));
    }

    level.weapon_xp_iw8_lm_mgolf34[var_2] = droppoint(var_3[var_6][0], var_7, var_8, var_9, var_5, var_3[var_6][1]);
  }

  foreach(var_11 in level.players)
  var_11 thread drop_jugg_crate();
}

droppoint(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = randomintrange(0, var_1.size);
  var_7 = var_1[var_6];
  var_8 = var_3[var_6];
  var_9 = var_2[var_6];
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_10.angles = var_8;
  var_10 setModel(var_0);
  var_10.weapon_xp_iw8_lm_lima86 = var_4;
  var_10.useprompt = scripts\mp\gameobjects::createhintobject(var_10.origin + var_9, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_82D91BD9F8712E466FB385C71F4F951A0E3719938161E161ACD8254DB0", undefined, undefined, undefined, 480, 90, 72, 90);
  var_10.useprompt dohudplunderpulse(var_4);
  thread do_hack_sequence(var_10.useprompt, var_4, var_5);
  return var_10;
}

dohudplunderpulse(var_0) {
  var_1 = "_encstr_8C732F64D3FA67033597AFBBAFB60A9D88385D61CBB8E15BE09D57CA9370B3D271C1D377C04897924B9B83BB2B80FA05C9" + var_0;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && var_3 draw_debug_sphere(var_1)) {
      self disableplayeruse(var_3);
      self hidefromplayer(var_3);
    }
  }
}

do_hack_sequence(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);
    var_3 thread do_heli_takeoff_vo(var_1, var_2);
  }
}

do_heli_takeoff_vo(var_0, var_1) {
  var_2 = self;
  var_2 playsoundtoplayer("_encstr_A20D12EFEB98A25E888905C120708CBAE6134F63", var_2);
  var_2 thread do_ghost_skit();
  var_2 thread dobreakeractivation();
  var_2 thread do_laser_panel_anim_sequence(var_0, var_1);

  foreach(var_4 in level.weapon_xp_iw8_lm_mgolf34) {
    var_4.useprompt disableplayeruse(var_2);
    var_4.useprompt hidefromplayer(var_2);
  }

  wait 0.25;
  var_2 scripts\mp\hud_message::showsplash("_encstr_AF7F1931397D8DCAC1AFB1438536D8CA73B359EB371DC293479591", var_1);
  thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8D7B12F007E0665BC327C1C03CBAB9E94AAF1BA8", var_2, 1, 0, 3);
}

dropbrcustompickupitem() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  dropbrmissiontablet(0);
  self waittill("_encstr_BA350853C128FB939DB9");

  foreach(var_1 in level.weapon_xp_iw8_lm_mgolf34) {
    var_1.useprompt enableplayeruse(self);
    var_1.useprompt showtoplayer(self);
  }

  thread drop_jugg_crate();
}

do_ghost_skit() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8ADB1B13C9AF8DCA38F5D80DB08DB1CA7376ACAFC6B76BC1B159E8CA91");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  thread dropbrcustompickupitem();
}

dobreakeractivation() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8ADB1B13C9AF8DCA38F5D80DB08DB1CA7376ACAFC6B76BC1B159E8CA91");
  level waittill("_encstr_9B1D0BC7932875276230426AA1", var_0);

  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595") {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

    foreach(var_3 in var_1) {
      if(var_3 == self)
        var_3 thread do_kidnapping_anims(0);
    }
  }
}

do_laser_panel_anim_sequence(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_AF7F1931397D8DCAC1AFB1438536D8CA73B359EB371DC293479591");
  dropbrmissiontablet(var_0);
  _calloutmarkerping_handleluinotify_added::_id_1313E("_encstr_A3C6160B70F0EBFA91A91DF037B0C67B072EE222D8B5A333", 3, 3, var_1);
  var_2 = level.br_circle.circleindex;

  while(level.br_circle.circleindex < var_2 + var_1) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_3);
    var_4 = var_2 + var_1 - var_3 + 1;

    if(var_4 > 0)
      _calloutmarkerping_handleluinotify_added::_id_1313E("_encstr_A3C6160B70F0EBFA91A91DF037B0C67B072EE222D8B5A333", 3, 3, var_4);
  }

  thread do_kidnapping_anims(5);
}

do_kidnapping_anims(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8ADB1B13C9AF8DCA38F5D80DB08DB1CA7376ACAFC6B76BC1B159E8CA91");
  doors_opened_music("_encstr_AA860B91FFA31FB0F643A0E007" + self.weapon_xp_iw8_lm_lima86);

  if(var_0 && var_0 > 0)
    wait(var_0);

  _calloutmarkerping_handleluinotify_added::_id_1313E("_encstr_A3C6160B70F0EBFA91A91DF037B0C67B072EE222D8B5A333", 3, 3, 0);
  scripts\mp\hud_message::showsplash("_encstr_8ADB1B13C9AF8DCA38F5D80DB08DB1CA7376ACAFC6B76BC1B159E8CA91", self.weapon_xp_iw8_lm_lima86);
  thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B2A114D00A9BF848542999E16FFE60B9C332495B9223", self, 1, 0, 3);
}

dropbrmissiontablet(var_0) {
  self.weapon_xp_iw8_lm_lima86 = var_0;
  _calloutmarkerping_handleluinotify_added::_id_1313E("_encstr_A3C6160B70F0EBFA91A91DF037B0C67B072EE222D8B5A333", 0, 3, var_0);
}

drop_jugg_crate() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AF7F1931397D8DCAC1AFB1438536D8CA73B359EB371DC293479591");

  for(;;) {
    var_0 = incrementpersistentstat(level.weapon_xp_iw8_lm_mgolf34, self.origin, 400);

    if(var_0.size > 0) {
      var_1 = scripts\engine\utility::array_get_first_item(var_0);

      if(isDefined(var_1) && draw_debug_sphere("_encstr_8C732F64D3FA67033597AFBBAFB60A9D88385D61CBB8E15BE09D57CA9370B3D271C1D377C04897924B9B83BB2B80FA05C9" + var_1.weapon_xp_iw8_lm_lima86))
        wait 5;
      else {
        wait 1;

        if(!isDefined(self.weapon_xp_iw8_lm_lima86) || self.weapon_xp_iw8_lm_lima86 == 0) {
          thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B6060E6ADAC0612AB8357B2143C3E7EB", self);
          wait 35;
        }
      }
    }

    wait 1;
  }
}

doextractionevent() {
  dogtag_collected_lap(1);
  thread dogtag_collected();
}

dogtag_collected_lap(var_0) {
  dogtag_visibility_watcher((-37834.2, 28261, 851.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-38449.2, 27099, 1024.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-38449.2, 25818, 1024.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-37815.2, 26098, 532.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-37607.2, 25237, 696.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-37356.2, 26299, 476.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-37618.2, 27497, 707.73), undefined, undefined, var_0);
  dogtag_visibility_watcher((-38418.2, 26177, 1024.73), undefined, undefined, var_0);
}

dogtag_collected() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  dogtag_collected_lap();
}

dogtag_visibility_watcher(var_0, var_1, var_2, var_3) {
  var_4 = 600;
  var_5 = 350;

  if(!isDefined(var_1))
    var_1 = var_4;

  if(!isDefined(var_2))
    var_2 = var_5;

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::little_bird_mg_playercontrolmg(var_0, var_1, var_2, var_3);
}

door2(var_0, var_1) {
  if(var_0.size > 0) {
    if(istrue(var_1)) {
      var_2 = randomint(var_0.size);
      return var_0[var_2];
    } else {
      var_3 = [];

      foreach(var_5 in var_0) {
        var_6 = scripts\common\utility::playersinsphere(var_5.crashorigin, 3000);
        var_5.numplayers = var_6.size;
      }

      var_3 = scripts\engine\utility::array_sort_with_func(var_0, ::doarmsraceopencachenags);

      if(var_3[0].numplayers == 0) {
        var_8 = door2(var_0, 1);
        level._id_12882 = var_8.crashorigin;
        return var_8;
      }

      var_8 = door_anim(var_3);
      level._id_12882 = var_8.crashorigin;
      return var_8;
    }
  }

  return undefined;
}

doarmsraceopencachenags(var_0, var_1) {
  return var_0.numplayers > var_1.numplayers;
}

door_anim(var_0) {
  if(isDefined(level._id_12882)) {
    foreach(var_2 in var_0) {
      if(distance2dsquared(var_2.crashorigin, level._id_12882) > 100000000)
        return var_2;
    }

    return var_0[0];
  } else
    return var_0[0];
}

dropangles(var_0) {
  var_1 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
  var_2 = level.br_level.br_circleradii[level.br_circle.circleindex + 1];

  foreach(var_4 in level._id_123AB.player_fov_default_1) {
    if(distance2d(var_4.crashorigin, var_1) > var_2) {
      var_4.forced_bleedout = 1;
      level._id_123AB.player_fov_default_1 = scripts\engine\utility::array_remove(level._id_123AB.player_fov_default_1, var_4);
    }
  }
}

dropped_weapon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!getdvarint("_encstr_8DEC1E3EEB4366550A69C080B3690FF96F984DA044FBA8B9B9D2E8B8EAFDCB91", 1)) {
    return;
  }
  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);
    var_1 = door2(level._id_123AB.player_fov_default_1);

    if(isDefined(var_1) && level doingcheck(var_1))
      level._id_123AB.player_fov_default_1 = scripts\engine\utility::array_remove(level._id_123AB.player_fov_default_1, var_1);

    level waittill("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD", var_0);
    dropangles(var_0);
  }
}

dropped_weapon_cleanup() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!getdvarint("_encstr_8DEC1E3EEB4366550A69C080B3690FF96F984DA044FBA8B9B9D2E8B8EAFDCB91", 1)) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  while(!isDefined(level.infilstruct)) {
    return;
  }
  downtown_gw_ambient_sound_load();
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);

  if(getdvarint("_encstr_A29F25371B27D71B5607AF675ADCA57BB9AF9B59A3FAAC87E8593723B223D78C2D6E2C4C8D5946", 0) == 0)
    dropbrkillstreak("_encstr_8348155B0EBE23DE730DAF63590EBE365AC91B1BB2AF13", 10);

  level thread dohudplunderroll();
  wait 15;
  level thread dokidnapsequence(var_0);
  level thread dropbrselfrevivetoken(5, 2363, 40, 60, 40);
  level waittill("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD", var_0);
  dropangles(var_0);
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);

  if(getdvarint("_encstr_A29F25371B27D71B5607AF675ADCA57BB9AF9B59A3FAAC87E8593723B223D78C2D6E2C4C8D5946", 0) == 0)
    dropbrkillstreak("_encstr_AB481507305EDC4A1DDD19CD6D0901632088A78B60B642", 10);

  level thread dokidnapsequence(var_0);
  level thread dropbrselfrevivetoken(5, 2363, 40, 60);
  level waittill("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD", var_0);
  dropangles(var_0);
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);

  if(getdvarint("_encstr_A29F25371B27D71B5607AF675ADCA57BB9AF9B59A3FAAC87E8593723B223D78C2D6E2C4C8D5946", 0) == 0)
    dropbrkillstreak("_encstr_994815FAA8973F9FD00D4F644DFB970603508262B83FA2", 10);

  level thread dointrovo(var_0);
  thread do_manual_splash_damage_when_frag_explodes();
  level thread dropbrselfrevivetoken(5, 1181, 35, 50);
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");

  if(getdvarint("_encstr_A29F25371B27D71B5607AF675ADCA57BB9AF9B59A3FAAC87E8593723B223D78C2D6E2C4C8D5946", 0) == 0)
    dropbrkillstreak("_encstr_A54815D9700FF9A7E5C771F0CABA0FD16FAA56C16D67AB", 10);

  thread do_not_unload();
  level thread dropbrselfrevivetoken(5, 1181, 35, 50);
  level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
  level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::generate_solution();
  level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::little_bird_mg_mp_enterendinternal();
  level thread dontshowscoreevent();
}

dontspawncargotruck(var_0) {}

doingcheck(var_0, var_1) {
  var_0.infil_chopper_path_flags_manager = 1;
  level thread dointerrogationvo(var_0);
  return 1;
}

dointerrogationvo(var_0) {
  var_1 = var_0.crashorigin;
  var_2 = vectortoangles(var_0.crashorigin - var_0.spawnorigin);
  var_3 = var_0.infectsetradaronnumsurvivors;

  if(!isDefined(var_0.infectsetradaronnumsurvivors))
    var_3 = var_2;

  var_4 = var_0.spawnorigin;

  if(getdvarint("_encstr_BAA42153AE53670DDB88F1CA602B02732E8FC4F9B0D91F13DF08F9D3D033BB4341FE55", 0) > 0) {
    var_5 = (0, 0, 500);
    var_6 = dropallunusableitems(var_1 + var_5, var_1 - var_5);
    var_7 = var_6["_encstr_BD260953AA97E3F014279D"];
  } else
    var_7 = var_1;

  var_8 = anglesToForward((0, var_2[1], 0)) * -250;
  var_9 = var_7 + var_8;
  dohudplunderrollsound(var_0, var_4, var_9);
  var_0.infil_chopper_path_flags_manager = 0;
  var_0.forced_bleedout = 1;
  var_10 = dropjuggbox(var_7, var_3);
  var_10 radiusdamage(var_7, 500, 1000, 50);
  var_10 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_B6A908D84EB0E6435632");
  playFX(level._effect["_encstr_8E3916FD7610F136CB097841E3A77C506DDD4541273F9007"], var_7, anglesToForward((0, var_2[1], 0)), (0, 0, 1));
  drone_turret_canseetarget(var_10, var_0.objid, var_0._id_11F93);
  var_10 thread dropped_weapon_cleanup_internal();
}

dohudplunderrollsound(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = vectortoangles(var_3);
  var_4 = (var_4[2], var_4[1] + 90, var_4[0]);
  var_5 = dropcpcratefromscriptedheli(var_1, var_4);
  var_5 endon("_encstr_AD75063D571AE108");
  waitframe();
  var_5 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_811C08A1AEE9732B23C4");
  var_0.objid = drone_turrets(var_5, 2000, 1, 1, 0, 0);
  var_0._id_11F93 = drone_turrets(var_5, 2000, 1, 0, 0, 1);
  var_6 = getdvarint("_encstr_8C0117E61BE4AF89E4AFB1B238BE1B58D80DCAAFCDE0B25623", 3000);
  var_7 = getdvarfloat("_encstr_B27E179B8DE4F589397D8DAC1CAFB116D81A59D7C21B6C2BD8", 0.75);
  var_8 = distance(var_1, var_2);
  var_9 = var_8 / var_6;
  var_10 = var_9 * var_7;
  var_5 moveTo(var_2, var_9, var_10, 0.05);
  level thread drop_priorities(var_5);
  wait(var_9);
  var_5 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_878807108A42A309BB");
  drop_saw_think(var_2);
  var_5 notify("_encstr_AB8519DCE8ED0EF50EC6853759D7D9CAD04B1BB156AF1BC9AB3734");
  var_5 notify("_encstr_ACA50E9B9863589599E75A0B1EA94B8D");
  var_5 delete();
}

dropcpcratefromscriptedheli(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2.angles = var_1;
  var_2 setModel("_encstr_8FF120E30D2F282737CF4B4F7A6A156A21B14ACBD9C995CF0398EA980F105F4D64E0");
  var_2 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_8E440A950FE01BB76E96BDE6");
  return var_2;
}

dropjuggbox(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2.angles = var_1;
  var_2 setModel("_encstr_AFCC25BAE685BE26BDAD989539BE26899B7D86564EED7DEE2DCD76EBD8DEB526D29B5991EBC0C8");
  var_2.enemy_is_visible = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3 = getEnt("_encstr_9A0D18585835158DA2EE77A511EEA8CEFFD8CA45F39F491B6864", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_3)) {
    var_2.enemy_is_visible clonebrushmodeltoscriptmodel(var_3);
    var_2.enemy_is_visible linkTo(var_2, "_encstr_B40101", (-86, -28, 40), (0, 0, 0));
  } else {}

  var_2.id = "_encstr_BAE50DE60E739BA638C72068AF47B9";
  var_2.updatecirclepulse = 1;
  var_2.angles = (0, var_1[1], 0);
  return var_2;
}

drop_saw_think(var_0) {
  var_1 = scripts\engine\trace::sphere_trace_get_all_results(var_0, var_0, 60);

  foreach(var_3 in var_1) {
    var_4 = var_3["_encstr_850E077B0BF30318B9"];
    dropoff_sound_playervm_handler(var_4, var_0);
  }
}

drop_priorities(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AB8519DCE8ED0EF50EC6853759D7D9CAD04B1BB156AF1BC9AB3734");

  for(;;) {
    var_0 waittill("_encstr_8D7D06302FE5E159", var_1);
    dropoff_sound_playervm_handler(var_1, var_0.origin);
  }
}

dropoff_sound_playervm_handler(var_0, var_1) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  if(!var_0 scripts\common\vehicle::isvehicle() && !isDefined(var_0.classname)) {
    return;
  }
  if(var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
    var_0 dodamage(10 * var_0.health, var_1);
}

dropallunusableitems(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1);

  for(var_3 = []; isDefined(var_2["_encstr_850E077B0BF30318B9"]) && var_3.size < 25; var_2 = scripts\engine\trace::ray_trace(var_0, var_1, var_3))
    var_3[var_3.size] = var_2["_encstr_850E077B0BF30318B9"];

  return var_2;
}

drone_turret_canseetarget(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0.angles) * 50;
  var_4 = var_0.origin + var_3;
  var_5 = (0, 0, 500);
  var_6 = dropallunusableitems(var_4 + var_5, var_4 - var_5);
  var_7 = (0, var_0.angles[1] - 90, 0);
  var_7 = generateaxisanglesfromupvector(var_6["_encstr_820E07FAE8780B3A4C"], var_7);
  var_0.chest = easepower("_encstr_A65F125AE8C76DCF805D3F3BFF299B779F7052F3", var_6["_encstr_BD260953AA97E3F014279D"] + (0, 0, 0.5), var_7);
  var_0.chest.get_circle_back_nodes_on_same_side = ::draw_line_orgtoent;
  var_0.chest._id_123A1 = var_0;
  var_0.chest.objid = var_1;
  var_0.chest._id_11F93 = var_2;
  drone_turrets(var_0.chest, 30, 1, 0, 1, 0);
  drone_turrets(var_0.chest, 30, 1, 0, 0, 1);
}

draw_line_orgtoent(var_0, var_1, var_2, var_3, var_4) {
  if((var_2 == "_encstr_A350079E35DACF8944" || var_2 == "_encstr_ACAE0DEFDB15AF50C5B1A047569F6D") && !isDefined(var_0.entity)) {
    if(var_2 == "_encstr_A350079E35DACF8944")
      var_0 setscriptablepartstate(var_1, "_encstr_93CF08C7684F60BBB372");
    else if(var_2 == "_encstr_ACAE0DEFDB15AF50C5B1A047569F6D")
      var_0 setscriptablepartstate(var_1, "_encstr_AA100EA813B5CD1B226718987DAA4F08");

    var_3 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_93D50D50754757B91858A1848079C8");
    var_3 scripts\cp\vehicles\vehicle_compass_cp::_id_12002();

    if(!isDefined(var_3._id_11A01))
      var_3._id_11A01 = 1;
    else
      var_3._id_11A01++;

    var_3 scripts\mp\utility\stats::setextrascore1(var_3._id_11A01);
    dropjuggernautcrate(var_0);
    level notify("_encstr_82941EBD48D8D4AA27572B17C7D8633D389137C960B08412106F17CBB9F07B64" + var_0.origin);
    var_0 thread dropbrattackerperkammo(var_0.objid);
    var_0 thread dropbrattackerperkammo(var_0._id_11F93, 1);
    var_0.objid = undefined;
    var_0._id_11F93 = undefined;
    var_0 thread drawprematchareas(var_1);
  }

  return 0;
}

drawprematchareas(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self._id_123A1 endon("_encstr_9AA11558686EE593F0368A43DB7AE91328433BFFFB5BFF");
  var_1 = getdvarint("_encstr_96DB219B6C4EBEE42B5DCDB098C62BF5D8166C1A95FA4EB21B1AB09C9D95EBD14B5B59", 120);
  wait(var_1);
  self setscriptablepartstate(var_0, "_encstr_BEE608BF50D84BAA9DF4");
  drone_turrets(self, 30, 1, 0, 1, 0);
  drone_turrets(self, 30, 1, 0, 0, 1);
}

dropped_weapon_cleanup_internal() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9AA11558686EE593F0368A43DB7AE91328433BFFFB5BFF");

  for(;;) {
    level waittill("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD");
    var_0 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
    var_1 = level.br_level.br_circleradii[level.br_circle.circleindex + 1];

    if(distance2d(self.origin, var_0) > var_1) {
      for(;;) {
        var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
        var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius() + 1500;

        if(distance2d(self.origin, var_0) > var_1) {
          thread drone_out_of_bound_monitor();
          return;
        }

        wait 1;
      }
    }
  }
}

dropjuggernautcrate(var_0) {
  var_1 = door_is_open_at_least(var_0);

  if(!isDefined(var_1) || var_1.size <= 0)
    return [];

  var_2 = spawnStruct();
  var_3 = anglesToForward((0, var_0.angles[1] - -90, 0));
  var_2.origin = var_0.origin + var_3 * 25 - (0, 0, 0.5);
  var_2.angles = (0, var_0.angles[1], 0);
  var_2.itemsdropped = 0;
  var_4 = var_2 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_1, 1, undefined);
  return var_4;
}

door_is_open_at_least(var_0) {
  var_1 = randomint(24);
  var_2 = verifybunkercode("_encstr_B87D0A417AB0C8EA9A2E60FD", var_1);

  if(!isDefined(var_2))
    var_2 = [];

  var_3 = door_parts();

  if(isDefined(var_3))
    var_2[var_2.size] = var_3;

  var_2[var_2.size] = "_encstr_951B1278EA63183F2B87B8436BC9BB43663049F0";
  return var_2;
}

door_parts() {
  if(!isDefined(level.weapon_xp_iw8_ar_sierra552))
    downtown_helicopter_start();

  var_0 = randomint(level.weapon_xp_iw8_ar_sierra552._id_13BF6);

  foreach(var_2 in level.weapon_xp_iw8_ar_sierra552.itemlist) {
    if(var_0 <= var_2._id_12D81)
      return var_2.name;
  }

  return undefined;
}

drone_out_of_bound_monitor(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    var_0 = 0;

  while(!var_0) {
    var_1 = scripts\common\utility::playersinsphere(self.origin, 3000);

    if(var_1.size == 0) {
      break;
    }

    wait 1;
  }

  self.chest setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_95DF070DD22319CA9B");
  dropbrattackerperkammo(self.chest.objid);
  dropbrattackerperkammo(self.chest._id_11F93, 1);
  self notify("_encstr_9AA11558686EE593F0368A43DB7AE91328433BFFFB5BFF");
  self.enemy_is_visible delete();
  self delete();
}

drone_turrets(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("_encstr_AF5A279BB1C9FA8D2B83F5E60DB7BBAF071B2CB9597D2D6CDB9BFA1699475639AF6CED733A4E166C47", 0) > 0 && istrue(var_5))
    return undefined;

  var_6 = scripts\engine\utility::ter_op(istrue(var_5), var_0._id_11F93, var_0.objid);

  if(!isDefined(var_6)) {
    var_6 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(istrue(var_5)) {
      var_0._id_11F93 = var_6;
      scripts\mp\objidpoolmanager::objective_add_objective(var_6, "_encstr_930B07BB1B6B3854FF");
      level._id_123AB.audio_player_start_mud_loop[level._id_123AB.audio_player_start_mud_loop.size] = var_6;
    } else {
      var_0.objid = var_6;
      scripts\mp\objidpoolmanager::objective_add_objective(var_6, "_encstr_AF5A081BBAC993AC73A3");
      level._id_123AB.audio_player_spawn_mud_loop[level._id_123AB.audio_player_spawn_mud_loop.size] = var_6;
    }

    objective_setbackground(var_6, 1);
    objective_icon(var_6, "_encstr_B2FA1A9363616A5B26E5EA99B883E0BB77E9C9F19BE262A03FBD31C3");
    _func_421(var_6, 1);
    objective_setplayintro(var_6, 0);
    objective_setlabel(var_6, "_encstr_93AC19094ABE8954A0AFA2CA2AE48A970A8905392AFAD04A283521");
    _func_043D(var_6, 1);
    objective_removeallfrommask(var_6);

    foreach(var_8 in level.players) {
      if(isDefined(var_8)) {
        if(scripts\engine\utility::array_contains(level._id_123AB._id_11B1B, var_8)) {
          if(istrue(var_5))
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_6, var_8);
          else
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_6, var_8);

          continue;
        }

        if(!istrue(var_5)) {
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_6, var_8);
          continue;
        }

        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_6, var_8);
      }
    }
  } else
    objective_setzoffset(var_6, 0);

  if(!isDefined(var_1))
    var_1 = 0;

  if(istrue(var_3))
    objective_setshowoncompass(var_6, var_3);

  if(istrue(var_2) && !istrue(var_5))
    getbnetigrbattlepassxpmultiplier(var_6, 39370, 47244);

  if(istrue(var_4))
    objective_setshowdistance(var_6, var_4);

  if(isent(var_0)) {
    if(getdvarint("_encstr_8E8826CBE01D217BA3488CBDF72E37F667D0D281F89B25B3FE4598B4071317B19B30FA0A31495DAF", 0) > 0)
      var_0 thread dropoff_sound_playerwm_handler(var_6, var_1);
    else {
      objective_onentity(var_6, var_0);
      objective_setzoffset(var_6, var_1);
    }
  } else
    objective_setlocation(var_6, 0, var_0.origin + (0, 0, var_1));

  return var_6;
}

dropoff_sound_playerwm_handler(var_0, var_1) {
  self endon("_encstr_ACA50E9B9863589599E75A0B1EA94B8D");
  self endon("_encstr_AD75063D571AE108");
  var_2 = (0, 0, var_1);

  for(;;) {
    objective_position(var_0, self.origin + var_2);
    waitframe();
    waitframe();
  }
}

dropbrattackerperkammo(var_0, var_1) {
  if(getdvarint("_encstr_AF5A279BB1C9FA8D2B83F5E60DB7BBAF071B2CB9597D2D6CDB9BFA1699475639AF6CED733A4E166C47", 0) > 0 && istrue(var_1)) {
    return;
  }
  if(isDefined(var_0)) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3)) {
        var_4 = var_3 getnodeoffset_code(7);

        if(isDefined(var_4) && var_4 == var_0)
          var_3 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
      }
    }

    waittillframeend;
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0);

    if(istrue(var_1))
      level._id_123AB.audio_player_start_mud_loop = scripts\engine\utility::array_remove(level._id_123AB.audio_player_start_mud_loop, var_0);
    else
      level._id_123AB.audio_player_spawn_mud_loop = scripts\engine\utility::array_remove(level._id_123AB.audio_player_spawn_mud_loop, var_0);
  }
}

drop_in_progress() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_A3100E18FB608AB8AE43D392E5A86782", var_0, var_1);
    waitframe();
    var_2 = scripts\engine\utility::array_removeundefined(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1));

    foreach(var_4 in var_2) {
      if(!scripts\engine\utility::array_contains(level._id_123AB._id_11B1B, var_4)) {
        level._id_123AB._id_11B1B = scripts\engine\utility::array_add(level._id_123AB._id_11B1B, var_4);

        foreach(var_6 in level._id_123AB.audio_player_spawn_mud_loop)
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_6, var_4);

        foreach(var_6 in level._id_123AB.audio_player_start_mud_loop)
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_6, var_4);
      }
    }
  }
}

do_ascender_entrance(var_0, var_1, var_2, var_3) {
  if(istrue(var_3)) {
    var_4 = combineangles((0, 180, 0), (0, level.infilstruct.c130pathstruct.angle[1], 0));
    var_5 = var_1 + anglesToForward(var_4) * -24000;
    var_5 = (var_5[0], var_5[1], 23000);
  } else {
    var_5 = var_1 + anglesToForward(var_2) * -24000;
    var_5 = (var_5[0], var_5[1], 23000);
  }

  var_6 = spawnStruct();
  var_6.crashorigin = var_1;
  var_6.spawnorigin = var_5;
  var_6.infectsetradaronnumsurvivors = var_2;
  var_6.infil_chopper_path_flags_manager = 0;
  var_6.forced_bleedout = 0;
  var_0 = scripts\engine\utility::array_add(var_0, var_6);
  return var_0;
}

do_cache_2_prep(var_0, var_1) {
  var_2 = var_0 - 1;

  if(!isDefined(level.player_fulton_evac_rumble))
    level.player_fulton_evac_rumble = [];

  if(!isDefined(level.player_fulton_evac_rumble[var_2]))
    level.player_fulton_evac_rumble[var_2] = [];

  level.player_fulton_evac_rumble[var_2] = scripts\engine\utility::array_add(level.player_fulton_evac_rumble[var_2], var_1);
}

dokidnapsequence(var_0) {
  var_1 = level.player_fulton_evac_rumble[var_0 - 1];

  foreach(var_3 in var_1) {
    wait(var_3);
    var_4 = door2(level._id_123AB.player_fov_default_1);

    if(!isDefined(var_4)) {
      return;
    }
    if(level doingcheck(var_4))
      level._id_123AB.player_fov_default_1 = scripts\engine\utility::array_remove(level._id_123AB.player_fov_default_1, var_4);
  }
}

dointrovo(var_0) {
  var_1 = level.player_fulton_evac_rumble[var_0 - 1];

  foreach(var_3 in var_1) {
    wait(var_3);
    var_4 = door2(level._id_123AB._id_13B2E, 1);

    if(!isDefined(var_4)) {
      return;
    }
    if(level doingcheck(var_4))
      level._id_123AB._id_13B2E = scripts\engine\utility::array_remove(level._id_123AB._id_13B2E, var_4);
  }
}

dohudplunderroll() {
  var_0 = scripts\engine\utility::array_randomize(level._id_123AB._id_12F8B);
  wait 5;

  foreach(var_2 in var_0) {
    level thread doingcheck(var_2);
    wait 3;
  }
}

drones_spawning() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  var_0 = 0;

  while(var_0 <= 5) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0);

    if(var_0 == 1)
      wait 20;

    var_1 = level.br_level.br_mapcenter;

    if(var_0 > 1 && var_0 < level.br_level.default_class_chosen.size)
      var_1 = level.br_level.default_class_chosen[var_0];

    var_1 = (var_1[0], var_1[1], 30000);
    extraction_balloon_num_completed(var_1, var_0);
  }
}

extraction_balloon_num_completed(var_0, var_1) {
  if(!isDefined(level.player_infil_played_or_skipped)) {
    level.player_infil_played_or_skipped = spawnStruct();
    level.player_infil_played_or_skipped.ent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    level.player_infil_played_or_skipped.ent setModel("_encstr_A73D0B4B5DB379EA10966D376B");
    thread doesstreakinfomatchequippedstreak(level.player_infil_played_or_skipped.ent);
  }

  level.player_infil_played_or_skipped.amount = clamp(var_1, 1, 5);
  level.player_infil_played_or_skipped.ent.origin = var_0;
  level.player_infil_played_or_skipped.ent setscriptablepartstate("_encstr_96190434978B", "_encstr_AAA906D838B2788E" + level.player_infil_played_or_skipped.amount);
}

dropcircle() {
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  if(!isDefined(level.infilstruct)) {
    return;
  }
  dropoff();
  thread dropminigunondeath(2048, ["_encstr_87440B6AA23FD88937DF636A43", "_encstr_87440B6AA23FD88937DF636A43", "_encstr_87440B6AA23FD88937DF636A43"], level.infilstruct.c130pathstruct.angle[1]);
}

dropminigunondeath(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_861F0CBF8117989903787A707FC0");

  if(!getdvarint("_encstr_B2FC1FCB7F28694BFE26128AEB403B1D18FD551FBF68EB1F265E9A02D126831748", 1)) {
    return;
  }
  if(!isDefined(level.ctgs_comparestats))
    level.ctgs_comparestats = spawnStruct();

  var_3 = gettime() + var_0 * 1000;
  var_4 = [(45000, -15000, 0), (45000, -20000, 0), (45000, -17500, 0), (45000, -18000, 0), (45000, -20000, 0)];
  var_5 = -1000;
  var_2 = var_2;
  var_6 = var_1;
  var_7 = 20;
  var_8 = getdvarint("_encstr_BEF614472F8308B8DFEDF169528FE8D4AA1BD3F1BFDB", 20);
  level._id_11B54 = getdvarint("_encstr_BD50227A164D59D2FB41774F10958722C5BD82FB8FBD320B66880303A08B590887CD0DAB", 16);

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && level.br_circle.circleindex < 1) {
    var_9 = getdvarvector("_encstr_ADDB0E9D370D40FD83B1D0F94AEFA5A8", var_4[0]);
    var_10 = level.br_level.br_mapcenter + rotatevector(var_9, (0, var_2, 0));
    dropdeliveryatpos(var_10, var_2, var_6, var_7, var_8);
  }

  while(gettime() < var_3) {
    if(level.ctgs_comparestats._id_123AC < level._id_11B54)
      dropcondensedplunder(var_4, var_5, var_2, var_6, var_7);

    wait(var_8);
  }
}

dropoff() {
  level notify("_encstr_861F0CBF8117989903787A707FC0");

  if(!isDefined(level.ctgs_comparestats) || !isDefined(level.ctgs_comparestats._id_1452C)) {
    return;
  }
  foreach(var_1 in level.ctgs_comparestats._id_1452C)
  doendofmatchotsequence(var_1, 0);

  level.ctgs_comparestats._id_1452C = [];
}

dropdeliveryatpos(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.ctgs_comparestats._id_123AC))
    level.ctgs_comparestats._id_123AC = 0;

  for(var_5 = 3; var_5 > 0; var_5--) {
    if(level.ctgs_comparestats._id_123AC < level._id_11B54) {
      var_6 = dotooclosetominenags(var_0, var_1, var_2, var_3);
      var_7 = var_6.models[0] scripts\engine\utility::getanim("_encstr_B4B70E28CA6585E9830F6F6909CBD16F");
      var_8 = getanimlength(var_7);
      var_9 = var_4 * var_5 / var_8;
      thread drop_scavenger_bag(var_6);
      var_6.bunkeralt_playerinteractwithkeypadloop scripts\engine\utility::delaythread(0.05, scripts\common\anim::anim_set_time, var_6.models, "_encstr_B4B70E28CA6585E9830F6F6909CBD16F", var_9);
    }
  }
}

dropcondensedplunder(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(min(level.br_circle.circleindex, level.br_level.br_circleradii.size - 1));
  var_6 = level.br_level.br_mapcenter;
  var_7 = getdvarvector("_encstr_ADDB0E9D370D40FD83B1D0F94AEFA5A8", var_0[int(clamp(var_5, 0, var_0.size - 1))]);

  if(var_5 > 0) {
    var_6 = level.br_level.default_class_chosen[var_5];
    var_4 = var_4 + level.br_level.br_mapsize[0] / level.br_level.br_circleradii[var_5];
  }

  if(isDefined(level.br_circle.starttime)) {
    var_8 = level.br_circle.starttime / 1000 + level.br_level.br_circledelaytimes[var_5];
    var_9 = gettime() / 1000 + 17;
    var_10 = var_9 >= var_8;

    if(var_10 && var_5 + 1 < level.br_level.default_class_chosen.size) {
      var_11 = clamp((var_9 - var_8) / level.br_level.br_circleclosetimes[var_5], 0, 1);
      var_12 = level.br_level.default_class_chosen[var_5 + 1];
      var_13 = getdvarvector("_encstr_9342132250D79A9F48019D7F30839F2D53D80B4D93", var_0[int(clamp(var_5 + 1, 0, var_0.size - 1))]);
      var_6 = vectorlerp(var_6, var_12, var_11);
      var_7 = vectorlerp(var_7, var_13, var_11);
    }
  }

  var_6 = (var_6[0], var_6[1], var_1) + rotatevector(var_7, (0, var_2, 0));
  var_14 = dotooclosetominenags(var_6, var_2, var_3, var_4);
  thread drop_scavenger_bag(var_14);
}

dotooclosetominenags(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.ctgs_comparestats))
    level.ctgs_comparestats.ctgs_comparestats = spawnStruct();

  if(!isDefined(level.ctgs_comparestats._id_123AC))
    level.ctgs_comparestats._id_123AC = 0;

  if(!isDefined(level.ctgs_comparestats._id_1452C))
    level.ctgs_comparestats._id_1452C = [];

  var_4 = spawnStruct();
  var_4.spawnpos = var_0;
  var_4.building_magic_grenade_watch = (0, var_1, 0);
  var_4.bunkeralt_playerinteractwithkeypadloop = scripts\engine\utility::spawn_tag_origin(var_4.spawnpos, var_4.building_magic_grenade_watch);
  var_4.molotov_delete_pool_by_id = var_3;
  var_4.models = [];
  var_5 = (0, 0, 0);

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && isDefined(level.br_level.br_circleradii) && var_2.size > 1) {
    var_6 = int(clamp(level.br_circle.circleindex, 0, level.br_level.br_circleradii.size));
    var_5 = (0, randomfloat(level.br_level.br_circleradii[var_6]), 0);
    var_5 = rotatevector(var_5, (0, var_1, 0));
    var_0 = var_0 - (var_2.size / 2, var_2.size / 2, 0) * var_5;
  }

  foreach(var_10, var_8 in var_2) {
    var_9 = dropcashdeny(var_0);
    var_9.animname = var_8;
    var_9 useanimtree(level.scr_animtree[var_8]);
    var_9 unmarkkeyframedmover(1);
    var_4.models[var_10] = var_9;
    var_5 = var_5 * rotatevector((-1, 1, -1), (0, var_1, 0));
    var_0 = var_0 + var_5;
  }

  var_4.num_nodes_search_player = var_4.models.size + 1;
  level.ctgs_comparestats._id_123AC = level.ctgs_comparestats._id_123AC + var_4.num_nodes_search_player;
  level.ctgs_comparestats._id_1452C[level.ctgs_comparestats._id_1452C.size] = var_4;
  return var_4;
}

doendofmatchotsequence(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  foreach(var_3 in var_0.models)
  var_3 delete();

  var_0.bunkeralt_playerinteractwithkeypadloop delete();
  level.ctgs_comparestats._id_123AC = level.ctgs_comparestats._id_123AC - var_0.num_nodes_search_player;

  if(istrue(var_1))
    level.ctgs_comparestats._id_1452C = scripts\engine\utility::array_remove(level.ctgs_comparestats._id_1452C, var_0);
}

drop_scavenger_bag(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_861F0CBF8117989903787A707FC0");
  var_0.bunkeralt_playerinteractwithkeypadloop scripts\common\anim::anim_single(var_0.models, "_encstr_B4B70E28CA6585E9830F6F6909CBD16F", undefined, var_0.molotov_delete_pool_by_id);
  doendofmatchotsequence(var_0);
}

dropcashdeny(var_0) {
  var_1 = clamp(level.br_circle.circleindex + 1, 1, 5);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_3 = "_encstr_A714288F80BE2D6BA3C8F6ADC94DC2D246A87717F0D1623757E07A6427579AD9EE188BDF28AB97DAC1AE";
  var_2 setModel(var_3);
  var_2.angles = (0, 0, 0);
  return var_2;
}

dontshowscoreevent() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_934E061EC163016D");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      var_1 setsoundsubmix("_encstr_A5650DC4C9FA1BCA07F516D689BE91");
      var_1 clearsoundsubmix("_encstr_A5650DC4C9FA1BCA07F516D689BE91", 5);
    }
  }

  wait 3;
  level thread dropcratefrommanualheli_cp();
  wait 8;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_84E3118AE1772F0E10853714B3B0D7231619F3", undefined, undefined, 1);
  wait 8;
  level thread do_custom_evade_start();
  wait 20.0;
  level thread dont_shoot_parachutes();
}

do_custom_evade_start() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8D961129070B413DBF7DD107C768087AB93932", undefined, undefined, 1);
  var_0 = level.weapon_xp_iw8_ar_golf36;
  var_1 = 10288;
  level thread dropkit_marker_hints(var_0, var_1);
}

doarmsracelocationnags(var_0, var_1, var_2, var_3) {
  if(var_2 == "_encstr_A2E60C6BC099B7E1A0A93A398F48" && !isPlayer(self)) {
    var_4 = scripts\common\utility::playersincylinder(var_0, var_1);
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B2D4129AF1671FFE10AB1ADF5BE0461701E83292", undefined, var_4);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_6) || var_6.team == self.team) {
        continue;
      }
      _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader(var_6, "_encstr_B69D106CCB80D1DBB8B80AD1430D8B145BA3", 0);
    }
  } else
    _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbulletpenetration(var_0, var_1, var_2, var_3);
}

do_spawn_vo_callout(var_0, var_1) {
  if(!isDefined(level.create_digit_models))
    level.create_digit_models = [];

  var_2 = 1000;

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_4 = randomfloatrange(0, 360);
    var_5 = randomfloatrange(0, var_1);
    var_6 = (cos(var_4) * var_5, sin(var_4) * var_5, 0) + var_0;

    for(var_7 = 0; var_7 < level.create_digit_models.size; var_7++) {
      var_8 = level.create_digit_models[var_7];
      var_2 = distance2d(var_6, var_8);

      if(var_2 < 1000) {
        break;
      }
    }

    if(var_2 < 1000) {
      continue;
    }
    level.create_digit_models[level.create_digit_models.size] = var_6;
    return var_6;
  }

  return undefined;
}

dropkit_marker_hints(var_0, var_1) {
  self notify("_encstr_91C01090A2EA47B1BF653EA752BB988BD51B");
  self notify("_encstr_9A3A0EE5C5790AC5B1DA23B6F11A609F");
  self endon("_encstr_91C01090A2EA47B1BF653EA752BB988BD51B");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = 2 * level.framedurationseconds;
  var_3 = 5;

  for(;;) {
    level.create_digit_models = [];

    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = do_spawn_vo_callout(var_0, var_1);

      if(!isDefined(var_5)) {
        break;
      }

      if(getdvarint("_encstr_8F59208F6913C97C71E34905A025738B5231E3AA465BE1BF37C9638910C7C0AAB111", 0))
        level thread dropbrprimaryweapons(var_5, 30, 30);

      if(getdvarint("_encstr_A55A1768C26A47709778A0264F9F7983D21A6B506A830F093B", 0))
        level thread _hidesafecircleui::chase(10, var_5);

      wait(var_2);
    }

    wait 20;
  }
}

dropbrprimaryweapons(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.streakname = "_encstr_A2E60C6BC099B7E1A0A93A398F48";
  var_3.score = 0;
  var_3.shots_fired = 0;
  var_3.hits = 0;
  var_3.damage = 0;
  var_3.kills = 0;
  var_3._id_11EAE = 0;
  var_3._id_11F47 = 1;
  var_3.vehicle_process_node_when_at_goal = 1;
  var_3._id_121A9 = "_encstr_97901DB71389F8E0E75AAE5373E3AB485FA7330BBB6AE8B9EF91E03BE9E3FE";
  var_3._id_121A8 = "_encstr_AF521D6D9BF58EDEDA85FA374727B4B6AC7D1B1B5D9B47ACC97DB683FA1E23";
  var_3._id_133DC = 1;
  var_3._id_13A81 = var_0;

  if(isDefined(var_1))
    var_3._id_129E3 = var_1;

  if(isDefined(var_2))
    var_3._id_11ECE = var_2;

  var_4 = randomfloatrange(0, 360);
  var_5 = vectortoangles((cos(var_4), sin(var_4), 0));
  scripts\cp_mp\killstreaks\toma_strike::_id_13BDA(var_0, var_5, var_3);
}

helidrivabledeathall() {
  if(!isDefined(self)) {
    return;
  }
  radiusdamage(self.origin, 256, 15, 15, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_95E70D8EDBDA85F5839CED35F5B683");
}

dropbrselfrevivetoken(var_0, var_1, var_2, var_3, var_4) {
  level notify("_encstr_9A3A0EE5C5790AC5B1DA23B6F11A609F");
  level endon("_encstr_9A3A0EE5C5790AC5B1DA23B6F11A609F");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 = getdvarfloat("_encstr_B60E183B8E2AA1EEA2BF979117ABB6D8DD2645737261B093CAEB", 0.5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7", ::doarmsracelocationnags);

  while(level._id_123A7) {
    var_6 = scripts\engine\utility::array_randomize(level.players);
    var_7 = [];
    var_8 = [];
    level.create_digit_models = [];

    for(var_9 = 0; var_9 < var_0; var_9++) {
      var_10 = undefined;

      foreach(var_12 in var_6) {
        var_8[var_8.size] = var_12;

        if(!isDefined(var_12) || !scripts\mp\utility\player::isreallyalive(var_12)) {
          continue;
        }
        if(do_func(var_12, var_7, var_1 * 3)) {
          var_10 = do_spawn_vo_callout(var_12.origin, var_1);
          var_7[var_7.size] = var_12;
          break;
        }
      }

      foreach(var_15 in var_8)
      var_6 = scripts\engine\utility::array_remove(var_6, var_15);

      var_8 = [];

      if(isDefined(var_10)) {
        if(getdvarint("_encstr_ADCE241B70F00FB8F322298F17ABC2B5CDA9B55FF078A0D39719A3B063092B2E574B0A015075", 0))
          level thread dropbrprimaryweapons(var_10, undefined, 900);

        if(getdvarint("_encstr_AF0D233EEB436675CE7A80D0622E17786B91C63D4DA788B1B9B2F818FBFBCB533337C1A6CB", 0))
          level thread do_convoy_moving_vo(var_5, var_10, 6);
      }

      if(var_6.size < 1) {
        break;
      }
    }

    var_17 = randomintrange(var_2, var_3);
    wait(var_17);
  }
}

do_func(var_0, var_1, var_2) {
  var_3 = var_2 * var_2;

  foreach(var_5 in var_1) {
    if(var_0 == var_5)
      return 0;

    if(distance2dsquared(var_0.origin, var_5.origin) < var_3)
      return 0;
  }

  return 1;
}

do_convoy_moving_vo(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_2);
  level thread _hidesafecircleui::chase(var_0, var_1);
}

dropbrkillstreak(var_0, var_1, var_2) {
  level._id_142D1 = var_0;

  if(istrue(var_2)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_4 in level.players)
  var_4 visionsetnakedforplayer(var_0, var_1);
}

dropcratefrommanualheli_cp() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  dropbrkillstreak("_encstr_963919B1BB187FA0C8E3C75AC57373B849923380793D30EF39EA82", 10);
}

drop_locations(var_0, var_1) {
  if(var_0 == "_encstr_84300E8EA97BA8771622B0602AAFE9A1")
    self notify("_encstr_84300E8EA97BA8771622B0602AAFE9A1");
}

dont_shoot_parachutes() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.weapon_xp_iw8_ar_falima = spawnStruct();
  var_0 = 225;
  var_1 = getgroundposition(level.weapon_xp_iw8_ar_golf36, 1);
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_ABF116FBE09E142A6128D788AC7B729FE0A8674760305E32");
  wait 20.0;
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_AC0814757B418190B01161DA47819050FAA3F1EBF30A");

  foreach(var_3 in level.players)
  var_3 scripts\mp\utility\lower_message::setlowermessageomnvar(83, undefined, 10);

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BD300C9587334B63F5E495C29197", undefined, undefined, 1);
  wait 3.0;
  level.weapon_xp_iw8_ar_falima.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1, 0, int(var_0), int(level.defend_wave_3));
  var_5 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(level.weapon_xp_iw8_ar_falima.trigger, "_encstr_A7A408B9CA5D1D4E2C63");
  var_5.flagmodel setModel("_encstr_AD751E3382F9D3286C5F50E02BA1261F72BF38BE2F528FF077DF58E81BD978A5");
  var_5.onuse = ::domtablet_init;
  var_5.onbeginuse = ::domflag_showicontoplayer;
  var_5.onuseupdate = ::donetsksubmap;
  var_5.onenduse = ::domflagupdateiconsframeend;
  var_5.oncontested = ::domflag_usecondition;
  var_5.onuncontested = ::domlocale_onrespawn;
  var_5.onunoccupied = ::domoralesnags;
  var_5.onpinnedstate = ::domgulagsounds;
  var_5.onunpinnedstate = ::domplatecapturetime;
  var_5._id_138B2 = ::domlocale_onentergulag;
  var_5.stompprogressreward = ::dont_update_volume;
  var_5.gate_swings_open = 1;
  var_5.id = "_encstr_87D9083A6F628DDB5F1F";
  var_5.pinobj = 0;
  var_5.lockupdatingicons = 1;
  var_5 scripts\mp\gameobjects::setcapturebehavior("_encstr_92FC0B5BB01A6B73D09459526B");
  var_5 scripts\mp\gameobjects::setusetime(60);
  var_5 dontclose();
  playencryptedcinematicforall(var_5.objidnum, 1);
  level.weapon_xp_iw8_ar_falima.oil_puddles = var_5;
  level.objectivescaler = 1;

  foreach(var_3 in level.players) {
    var_3 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 17);
    var_3 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  }
}

dont_disable(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_2.team)) {
      if(var_2.team == var_0) {
        var_2 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 18);
        continue;
      }

      var_2 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 19);
    }
  }
}

dont_kill_off_old(var_0) {
  if(var_0 == "_encstr_B85C0AD87B9B8E95CD8E2B46")
    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 20);
  else if(var_0 == "_encstr_ACFC091AE8AB2FCBE15119")
    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 18);
  else
    self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 19);
}

dontcallpostplunder(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2) && !istrue(var_2.usedprops) && !istrue(var_2.beingrevived))
      var_2 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_0);
  }
}

domflag_onbeginuse(var_0) {
  self notify("_encstr_B1EC17B3C38FA8E01F3AD357108BB83FCD35185F3F32E74798");
  self endon("_encstr_B1EC17B3C38FA8E01F3AD357108BB83FCD35185F3F32E74798");

  if(isPlayer(var_0))
    var_1 = var_0.team;
  else
    var_1 = var_0;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_1)) {
      if(var_3.team == var_1) {
        var_3 thread dont_kill_off_old("_encstr_ACFC091AE8AB2FCBE15119");
        var_3 thread scripts\mp\hud_message::showsplash("_encstr_AF641B422BC8DB37F0C7E6FA43B03D2389E229AB51BF97E160911EF971");
        continue;
      }

      var_3 thread dont_kill_off_old("_encstr_88BF06FD784A6393");
      var_3 thread scripts\mp\hud_message::showsplash("_encstr_A5DC18269CD7C65983AF9573955B2FEB3A2BB0B5BE56E166D263");
    }
  }
}

domtablet_init(var_0) {
  var_1 = var_0.team;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  drop_usb_stick(var_1, "_encstr_8ED01292606978F750A30111511FCB772F40D79B", "_encstr_9ABE1089384E6019C1AF9D83E7CBC8C8E915");
  dontcallpostplunder(1);
  thread domflag_hideiconfromplayer(var_1);
}

domflag_showicontoplayer(var_0) {
  if(!isDefined(self._id_11F63) || !self._id_11F63) {
    self._id_11F63 = 1;
    thread domflag_onbeginuse(var_0);
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1)
    var_3 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }
}

donetsksubmap(var_0, var_1, var_2, var_3) {
  if(var_1 < 1.0 && !level.gameended && !istrue(self.get_current_bush_zone)) {
    dontcallpostplunder(var_1);
    donotwatchabandoned(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;

  if(self.gate_swings_open && var_1 > 0.5) {
    self.gate_swings_open = 0;
    drop_usb_stick(var_0, "_encstr_A523129732A172B131614DF4578A95A543272B63", "_encstr_AA290F923A2D10B1C695C06DA81A2853B2");
  }
}

domflagupdateiconsframeend(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

domflag_usecondition() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8D861089DB8FC7E017163810235367EB7553", undefined, undefined, 1);
  var_0 = scripts\mp\gameobjects::getownerteam();

  foreach(var_2 in level.players) {
    if(isDefined(var_2) && isDefined(var_0))
      var_2 thread dont_kill_off_old("_encstr_B85C0AD87B9B8E95CD8E2B46");
  }
}

domlocale_onrespawn(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = undefined;
  var_3 = domassairetreat();

  if(var_3 <= 1) {
    foreach(var_5 in level.teamnamelist) {
      var_6 = self.teamprogress[var_5];

      if(var_6 > 0) {
        var_2 = var_5;
        break;
      }
    }

    if(isDefined(var_2)) {
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_2);
      dont_disable(var_2);
    } else if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_1);
    else if(var_0 != "_encstr_8BBA05185F8B99")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);

    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

    if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
      self.didstatusnotify = 0;
  }
}

domoralesnags() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1");
  else
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

  self.didstatusnotify = 0;
}

domgulagsounds(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");
}

domplatecapturetime(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");
}

domlocale_onentergulag(var_0) {
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0)
      var_2 = var_5 / self.usetime;
  }

  if(isDefined(var_2)) {
    dontcallpostplunder(var_2);
    var_7 = level.frameduration * self.userate / self.usetime;

    if(var_2 <= var_7)
      thread domflag_onbeginuse(self.claimteam);

    if(!self.gate_swings_open && var_2 < 0.4)
      self.gate_swings_open = 1;
  }
}

dont_update_volume(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8E84100AE82D2133A3508787FD6923F77DB0");
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

  if(isDefined(self.lastprogressteam)) {
    thread domflag_onbeginuse(var_0);
    self.lastprogressteam = undefined;
  }
}

donotwatchabandoned(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "_encstr_B40101";
    var_0 = int(floor(var_0 * 10));
    var_2 = "_encstr_856B180A5867CF6F6068A3D9972B4F12537312A1E0E3C6A71EC7" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
  }
}

domflag_hideiconfromplayer(var_0) {
  var_1 = getarraykeys(level.teamdata);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(var_4 == var_0) {
      continue;
    }
    if(level.teamdata[var_4]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
      var_2[var_2.size] = var_4;
  }

  var_6 = scripts\mp\utility\script::quicksort(var_2, ::dropbrsuper);

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    var_4 = var_6[var_7];
    var_8 = var_7 + 2;
    thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1209B(var_4, var_8, 0, 1);
  }

  waitframe();

  if(istrue(level._id_13DC0)) {
    return;
  }
  level._id_13DC0 = 1;
  level._id_145C1 = 1;
  level thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"], undefined, undefined, undefined, 1);
}

dropbrsuper(var_0, var_1) {
  var_2 = getteamscore(var_0);
  var_3 = getteamscore(var_1);
  return var_2 >= var_3;
}

domassairetreat() {
  var_0 = 0;

  foreach(var_3, var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "_encstr_8BBA05185F8B99"))
      var_0++;
  }

  return var_0;
}

dontclose() {
  scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "_encstr_887D1A0929BE312A28FAA8655439A8BC1255C95AA249FAA2858C9431");
}

doorstate() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = scripts\engine\utility::array_removeundefined(level.players);

  foreach(var_2 in var_0)
  var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_95F20AF223522197B0839069");
}

dopunishhelivocalls(var_0) {
  foreach(var_2 in var_0)
  var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_120A4("_encstr_B1F20A28DF38AE89AAEA80BE");
}

doors_opened_music(var_0) {
  scripts\cp\vehicles\vehicle_compass_cp::_id_120A4(var_0);
}

draw_debug_sphere(var_0) {
  return self getplayerdata("_encstr_8C07031599", "_encstr_A2B510AD2D9BCD5AF6730D7BB6E063B2D159", var_0);
}

door_set_frozen() {
  var_0 = scripts\engine\utility::array_removeundefined(level.players);
  return _encstr_A1B523C367E34230F8FBA28BA2E8B78FADFD8BD313D2D2A8FA637FD78B0D93E8EF8A771F58::get_center_of_array(var_0);
}

drop_usb_stick(var_0, var_1, var_2) {
  foreach(var_4 in level.teamnamelist) {
    if(var_4 == var_0) {
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback(var_1, var_4, undefined, undefined, undefined, 1);
      continue;
    }

    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback(var_2, var_4, undefined, undefined, undefined, 1);
  }
}

doesstreakinfomatchequippedstreak(var_0) {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    var_0 delete();
}

doteleporttosafehouse() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players)
  var_1 setsoundsubmix("_encstr_83650D959BA1617010B141D8E6D71A");

  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 500));
  var_3 setModel("_encstr_A123081957C36850B6C8");
  waitframe();
  var_3 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_AFF710C25BED5F06B857838CC3A84F5F371B");
  level.weapon_xp_iw8_la_rpapa7 = var_3;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 500));
  var_3 setModel("_encstr_A123081957C36850B6C8");
  waitframe();
  var_3 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A29B05E9400E5D");
  level.weapon_xp_iw8_lm_kilo121 = var_3;

  foreach(var_1 in level.players)
  var_1 clearsoundsubmix("_encstr_83650D959BA1617010B141D8E6D71A", 5);
}

do_manual_splash_damage_when_frag_explodes() {
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_9AF710315BCBA708D457E71191FBF0600297");

  foreach(var_1 in level.players) {
    var_1 setsoundsubmix("_encstr_A5650DC4C9FA1BCA07F516D689BE91");
    var_1 setsoundsubmix("_encstr_83650D959BA1617010B141D8E6D71A", 5);
    var_1 clearsoundsubmix("_encstr_A5650DC4C9FA1BCA07F516D689BE91", 5);
  }

  wait 5;
  level.weapon_xp_iw8_la_rpapa7 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A29B05E9400E5D");
}

do_not_unload() {
  level.weapon_xp_iw8_la_rpapa7 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_8CF710602B73B319D7DF3EB5F9730107CAE7");

  foreach(var_1 in level.players) {
    var_1 setsoundsubmix("_encstr_A5650DC4C9FA1BCA07F516D689BE91", 5);
    var_1 clearsoundsubmix("_encstr_83650D959BA1617010B141D8E6D71A", 5);
  }

  wait 5;
  level.weapon_xp_iw8_lm_kilo121 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_A29B05E9400E5D");
}

dom() {
  if(isDefined(level.endmusicplayed)) {
    return;
  }
  var_0 = scripts\mp\gamescore::run_common_functions_stealth();
  level.endmusicplayed = 1;

  foreach(var_2 in level.players) {
    var_3 = var_0[var_2.team];

    if(var_3 <= 10)
      var_2 setplayermusicstate("_encstr_88DD0FD00B9F3073B3799C2B4ECB5F3B11");
    else
      var_2 setplayermusicstate("_encstr_9BC712DB736127E86378A8CD5327014F91DFE001");

    var_2 setsoundsubmix("_encstr_B2281235B9A105E75D01F22A48BDE7FD1827B983", 2);
    var_2 enableplayerbreathsystem(0);
  }
}