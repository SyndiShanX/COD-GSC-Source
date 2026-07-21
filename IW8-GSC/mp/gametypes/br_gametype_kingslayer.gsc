/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_kingslayer.gsc
***************************************************/

init() {
  level thread displaydelayedmissioncompletesplash();
  level thread displaycodes();
  level thread displayplunderloss();
  level thread display_who_broke_stealth_message();
  level thread displaycodeindex();
}

displaycodes() {
  if(getdvarint("_encstr_AF42117B265A57539364496527683A83A59F5F", 0) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");

  setDvar("_encstr_84A31DE356E269A6BBDF736F6352F8E0B72E285BFE5460F02233637D63BA35", 1);
  setDvar("_encstr_812214C8DF22A68D63E987193DEAFF8C976FF8B06FDC", 1);
  setomnvar("_encstr_A7990F658429177BBC4FF8417FDCB179D2", 1);
  setomnvar("_encstr_A2E017BB686F48581C5A01DBF76C5DFA1A4F49C9DB201ABD98", 1);
  level.playerkillstreakgetownerlookatignoreents = getdvarint("_encstr_BDE11ECDD893FAD62DB9D937D80B5ECA937DCCB7C9C6AC88D29BB013B12B269A", 0) == 1;
  level.scriptedphysicaldofenabled = getdvarint("_encstr_957C1D339F73695A50D81FF9A73379A57BD83260B81BCDEC17132A6FDAF9AA", 1);
  level.trackriotshield_tryreset = getdvarint("_encstr_8FB0219BC6E4EBC45BDBBED237B93A58374709D856568C7AABA3A92EABB032AE960EB2", 1);
  level.wait_until_emp_drone_done = getdvarint("_encstr_8BCB242BF6500127BCE8FC07A27340B353B9F34355588B9B95D2A8DAD5879D81B352D8630558", 1);
  level.wait_until_impact = getdvarint("_encstr_BA762E08B7FE7E60E2F330A88102A147FB5133D090E7DA73281DB39BA930FC73B0C617E40FCD9141C027302318454DE1", 0);
  level.waitandapplybrweaponxp = getdvarint("_encstr_B81D1BB96C93F5AD969B9D6E1BB0BC954EF5C1DED29BD1E68ADBEA96E6", 50);
  level.wait_until_trap_room_clear = getdvarint("_encstr_B6C32192FEB5A1337010F7BF18A9E9CA4D18DA0D53254B62D838B7B7A140BAA1CBAF65", 1) == 1;
  level.wait_until_truck_arrives_at_station = getdvarint("_encstr_BDF5244B1146FF5CC04DFFD371B8E05FEE0EF3F23810EB9C28A5F7DB4FF0EB2B98059A6A0376", 1) == 1;
  level.wait_use_respawn = getdvarint("_encstr_88C41DF3A9FEB7149805879B29F0588726C63BBA7058534A290BAABBDB50E7", 5);
  setDvar("_encstr_915A1288228AA753875B9A9837EF98DFB68A1038", level.waitandapplybrweaponxp);
  level.spawn_convoy_and_move = getdvarint("_encstr_8FEF237B98AA0FD055F7BF804CA30A68C030B7AD7293B03F6887A323472A389D833250B32B", 0);
  level.lootchopper_modifyweapondamage = getdvarint("_encstr_837B25932770317B59BA09C2E0A0F3F95883390CB3184967FF51E24B8990E7ED6951B993C7984A", 0) == 1;
  level._id_13366 = getdvarint("_encstr_AC5B214F4746891A1880B1421B30271395FFC7B709E1D2C3D829B206F02345BB76631F", 1);
  level._id_12FB3 = getdvarint("_encstr_8C7C265A366D79F238E0DF6798D1A73229566E572CEF633D67E01F3FE04865FAD1FD6A8F0731AA53", 60);
  level.loadout_updateclassdefault_headlessgetweaponn = getdvarint("_encstr_838E230E6E930FE1C51F61B02FF359AD9A179017472B3F0EB103D0F0A73651EBD2BFF09D5A", 0);
  level._id_11A27 = getdvarint("_encstr_A7441F0E7A233F60F3FD5F2437706897E1CD1613F345787108439ADF23A2B3CE41", 3);
  level._id_11B62 = getdvarint("_encstr_A7441F0E7A233F60F3FD5F2437706897E1CD1613F345787108439ADF23A2B3CE41", 3);
  level._id_11A2A = getdvarint("_encstr_877A1ECB5B0AD156BD1038487572552712692E416F2BF110C730AF57D6322D82", 1000);
  level._id_11A31 = getdvarint("_encstr_82DE21331602D9C5EF989F83D51D282F88ED199C77905F2DD0E07F53608AD6B84D89A0", 1) == 1;
  level._id_11A2B = getdvarint("_encstr_825726CD1BC97D135BBDFA367BED47FA632B0B46B2E47DAD16936DD7DCB49EB27D9197730BB6A5B1", 0);
  level._id_11A2D = getdvarint("_encstr_A31B2AE61B9C7D13DAEDBE1BDBDB8ED78DCA0B192B937D5B0BC9B5EBB4B933B7FA9B47C9B7CD76AFE6B4D395", 2000);
  level._id_11A2E = getdvarint("_encstr_81A42B7BCF98D99BA1F0D1EAD8889B8163BBE1F46B20116F5F4BAAC160501B45413F8C6AE728A7DFFCC1D26BC9", 5000);
  level._id_11A2F = getdvarint("_encstr_870728637E8BC78EE8878129409733872321C05595A277E59B8AC8A761E5899AD18BB52FB8A0D34138E8", 5000);
  level._id_11A30 = getdvarint("_encstr_827C29B96C27BE26DAF67D36DBBD477DC695B023CA9CF5D6B0E4D6AFD29B99DB7DBB95B05BFA9D0B8DEAAC", 1000);
  level._id_11A2C = getdvarint("_encstr_83AD23D6662AD97228C787C5AA20A0D058E7F7A138A3577A6B20FFE12B8052A940F92EF29F", 3);
  level._id_11A28 = getdvarint("_encstr_8A822A58900BF7BF5998E0FF7183530F2247D5D792E5B1BD5FB8ABDB2533D3ABE1524BE0F604D5FB2107AA4D", 0);
  level._id_127C0 = getdvarfloat("_encstr_AF5714E7636201C6471A0E7083070BA871FE5B9D1B4B", 0.3);
  level._id_127C2 = getdvarfloat("_encstr_81DF1513A7F0B1E3D9988952232E0776412FBD8B277807", 0.5);
  level._id_127C3 = getdvarfloat("_encstr_8E7114FE9E63FF71558FD148CF63283F19C3FB0B32DA", 0.75);
  level._id_127C1 = getdvarfloat("_encstr_8E5C15B9C64EFA896B7BFADA5D9B5AB1BE66DB5D931DD0", 0.9);
  level.isbotpracticematch = getdvarfloat("_encstr_BA0D241B6FDEDF33BB20883B94D8FF6890F8970E554FBF9E05BD843CA4608ED7A2A0E7D0BF78", 20);
  level.isbrgametypefuncdefined = [];
  level._id_14062 = getdvarint("_encstr_AA3317BF4BDA37E088AB17D3731D9D8B2B6F768263702233BD", 1);
  level.checkpoint_objective_id = getdvarint("_encstr_91C21C68C26A4771B772A0A755FBD8E5176BE870FB051FE97F842DAB55C7", 1);
  level._id_13BCD = getdvarint("_encstr_92B61DE68D93BEC8AD4FD78EEDB6CAE64ACADC0E0BEECDBAC2A5478AB46BAC", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("_encstr_82761837E0B35F42D332C18295D73B29BB100F43B868D90A094B", 0);
  level.start_pipe_room = getdvarfloat("_encstr_88CA1C37B193FA235B9EBE9356CD0E58DD73D71C56DCB0B18EE5FAAD0BE1", 15);
  level._id_12CA7 = getdvarint("_encstr_AC901E8F42F251C16B28E762A5F64079AF1E84399B1FC37398E40A3BAA4BCABD", 5000);
  level._id_12CB4 = getdvarint("_encstr_83AB1DD6662AD974289387420AC080CF3B250F8158526D5961F8CF0273E017", 0);
  level._id_121CC = getdvarfloat("_encstr_A6D41D9BB19C7D4C6BBDEB83859C16360DD53A2B88CA071BDBF22256D858E5", 0.5);
  level.wait_unload_jeep = getdvarint("_encstr_930C20721E5541D390B0571FB8C989AAEDB83C6C7593D8E958900FE7806758528F48", 1) == 1;
  level.waitandpause = getdvarint("_encstr_A3771F373693FAB62D37CE9B1B16CB95E4EBCDE016BBB9A04EF647566C8E96EDDC", 1) == 1;
  level.waitandspawnprops = getdvarfloat("_encstr_93AC27CD6CE4EBB6D237B36E63162FB24EEBCDC10BBB9B0A4EF6D1CA6C8EA57BDC53B7915A99B4CA9C", 0.5);
  level.waitandgetnewspawnpoint = getdvarfloat("_encstr_93D523D857F3A7F84868E1039CF9432F38F75FD80F3F0B79987BDD9A792D2AD5D9C99F823A", 0.5);
  level._id_133EA = getdvarint("_encstr_BA2D1EDC1B9CFA4CB6EDEBB95BB41C5D2B2C0EBDDC229CDE0E9ECD22B2161DD0", 1);
  level._id_133CD = getdvarint("_encstr_8BC02113A7F0B1E3D99889B3E02363FF3023B198232085E36513828B4C88CBAF18D938", 1);
  level.playerismatchedplayerready = getdvarint("_encstr_922A1E3FBB4A29FE7F3256795A6B26A02E02BB8F323F88B033280825C2FF6543", 2);
  level.wait_to_spawn_r0 = getdvarint("_encstr_991122B936C9F5ADB4B93BCDB12C2F959C7D1BA5E46CD82B35ED9DAC225ADCA31637B195", 18000);
  level.wait_till_time = getdvarint("_encstr_A32320E64BF201C82188C767EA61B3FB6DE181E3AD4BAD7D975BA3CB33B04ECB657F", 1);
  level.wait_spawn_trucks_smokescreen = getdvarint("_encstr_92A323BBE21B60909CAE7757C4C65835B39971601BBB2E78F29B256BE42FF186B741C868F2", 3);
  level.wait_spawn_sidehouse_trucks = getdvarint("_encstr_A95721DC1BC9EBDA4BE69D37B1C25E2B93AF58969C23E4ED380D9316A3950AC9D6F69C", 3);
  level.wait_to_close_in = getdvarint("_encstr_B8041BFA96CDD95B1848DF8730711122652046F48617229D6558EFEBC8", 20);
  level.wait_unload_chopper = getdvarfloat("_encstr_B2521C58F7F878043346BA5729CEF90FEAA78B2C30D3A097F949659365E0", 10100);
  level.wait_to_advance = getdvarfloat("_encstr_AF6A1F936E93A70C03B8B28BD06BC007CBD80B317E5993577F803A83B0293CFF81", 50);
  level.wait_to_reset_wave_loadout = getdvarfloat("_encstr_92C61FCD6C39FAADB4739D6E36C297B227AFB15A931BD85922ACD8C22F1596D6CA", 50);
  level.wait_to_spawn_ambush_vehicle = getdvarint("_encstr_86262363EE5BE76FAA78701B4C496B4DEEC196B7460F8CE1D032A51081E2094387D9A16BC2", 4750);
  level.wait_to_stop_path_vehicle = getdvarint("_encstr_A7A11C1BBF92263A982542E38DBBE063D021025FBE7470B757143B5EF495", 1) == 1;
  level.wait_to_start_exfil_obj = getdvarint("_encstr_AC93298F42F251E020A80722ACFF087DBB2FE1B8160FC137B8683B4AAB41FBBFC94FA3E2B8349D9F7931D2", 1);
  level.wait_to_stop_pre_tmtyl_spawners = getdvarint("_encstr_A7AD28E636E4D7B65ACDB3CD8DB05ECA27FAD8B4E4D8B1AC9ED51DD3CC84DB5DCD32DCA0B046C8B4DCD9", 1);
  level.wait_to_play_intro_vo = getdvarint("_encstr_99EA1B139F632FE25048B703583360F843D75F9762E62B3FADF302732C", 0);
  level._id_11C85 = ::_id_126A6;
  level.needs_controller = getdvarint("_encstr_878622C06AC2DF29DF1FD8CDE603346BABF290F9E25DD363C70C5637CE77F81954DA38F0", 1);
  level._id_13BE1 = [];
  level._id_11A32 = [];
  level.fuckwithgravity = 0;
  level.fuel_stability_event_init = 0;
  level.fuel_stability_event_start = 0;

  if(getdvarint("_encstr_847E1DA2CE6571E3A0E0076FC899B99A3D48EF5CAEEB1A3CC921371758B08B", 0) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_B48D064CB8E8E33A");

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BDC6085DF29A892901C7");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BA32084FFD08358F1C99");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_AF190997F3A62B7168C0DA");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A5D50F0ED8C2DC9535E616E051F6F4D312");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_8CE50ED185C48D59A325B238360B36AC");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_A92C15EAC13B1A65AF90871768635B829B7636673B4B83");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC");

  if(getdvarint("_encstr_AC4F1BEBB1E69F3CA02D9F73D11840BF0EAE12F21B3713B5E8419F67C9", 0) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8EAD05E157ED90");

  if(getdvarint("_encstr_91781C9BB1E4AF5BD2B9CEDC1B16E5B29CAF23D2B92C981BB2284E6BF6C9", 0) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A7B606DA83796F4A");

  level.onstartgametype = ::onstartgametype;
  level._id_11C84 = ::_id_11C83;
  level.ononeleftevent = ::ononeleftevent;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8449141CD8B0972B4EA986B7EA63194A956E830BEE9B", ::_id_12691);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8EC10D5F713FFBE6C151ED77E87034", ::_id_1365D);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BE94109AA047C32EB04BFAD347D0352F765B", ::dlog_analytics_init);
  scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 9);
  scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
  scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
  scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
  scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
  scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  level.decoyassists = ::brmini_initdialog;
  level.wait_until_done = [];
  level._id_13364 = 1;
}

_id_1365D(var_0) {
  return istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
}

_id_12691(var_0) {
  return 1;
}

displaydelayedmissioncompletesplash() {
  var_0 = spawnStruct();
  var_0.weights = [];
  level.votesys_update_time = var_0;
  display_message_to_guilty_player("_encstr_A2E60C6BC099B7E1A0A93A398F48", getdvarint("_encstr_95AB1DDCD8C9BE6D4BE6CECD8D0B2FB293FAADB49B76B64BB1B17DA3B76B85", 50));
  display_message_to_guilty_player("_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", getdvarint("_encstr_B13D227BCF98D9BFA3D0521BB88FAF0FF0CFEBF97D881C7FD988E93303D50FC4200B9776", 10));
  display_message_to_guilty_player("_encstr_8FFA10EB3033E5B2613B4D05176949BDF950", getdvarint("_encstr_844C1DDCC639F55B2D3776B9D80B5EACC9EB5B4BDCD9B64B1BD8FA0BEAC23B", 40));
}

displayplunderloss() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3", ::display_ping_hint_with_radial_check);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_B1130F58C89145BD6813990CA473335A36", ::display_message_to_teammates);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::dmz_numteamswithplayers);
  waittillframeend;
  scripts\mp\flags::gameflaginit("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C", 0);
  level.ontimelimit = ::dmz_bot_callback_func;
  level.onplayerkilled = ::dmg_trig;
  level._id_11C7A = ::_id_125F7;
  level.modifyplayerdamage = ::distort_fx;
  level.assists_disabled = undefined;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A7AA0FC427BED813CC06A0A54E329CDE07", "_encstr_BA2017FE03BA1008A3F59BCB27D711B7B8D532C603503D638D", ::divide_living_ai);
  display_mission_failed_text();
  touchdown_origin();
  level._id_11A29 = [];
  level._id_140D9 = [];
  level._id_140D9[0] = "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0";
  level._id_140D9[1] = "_encstr_A1580B19DE5B5A9B0BA35AEDCD";
  level._id_140D9[2] = "_encstr_AF460A7B2649F34FE367455D";
  level thread numextractions();
  level thread dmzextractcostdecrease();
  level thread dist_sq_to_ref();
  level thread dist_miles();
  thread _id_14365();
  level thread _id_12397();

  if(getdvarfloat("_encstr_8295247AC930FFDA2165F733A7D8230728917607A168B783876117ABABE8BA7E50792A0B5930", 15.0) > 0.0)
    level thread _id_13FF1();

  if(istrue(level.needs_controller))
    level thread test_pipe_fire();

  scripts\mp\rank::_id_12189("_encstr_ABD70578F3D02C", 100);
  scripts\mp\rank::_id_12189("_encstr_93D50D50754757B91858A1848079C8", 200);
}

display_who_broke_stealth_message() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_970E16454B71B5C0F18D704979D1B07B9B4F3BD1BF8B8D70");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_827F0CA01ADBB640298B192B92CB"] = "_encstr_8D110DCAB7E1501459D3B2418BD9FF";
}

display_mission_failed_text() {
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_920D1AA7081FE397C3407F2F90385F3AD3112D91E1A33BF12841672B", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_B49F18FD153A2D2EB707C88837F6666162FDE571E1F2F116D816", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_99291CC83F37405922F7696D37AA17D09F5630E22963800E1AF7912F6AD7", 1);
}

displaycodeindex() {}

touchdown_origin() {
  foreach(var_1 in level.teamnamelist) {
    level.teamdata[var_1]["_encstr_BD550F036883656BD815494CBE61BF6A23"] = 0;
    level.teamdata[var_1]["_encstr_9B8B102DCDA2DBC07B53D0F85FB43821AAB5"] = 0;
  }
}

display_message_to_guilty_player(var_0, var_1) {
  level.votesys_update_time.weights[var_0] = var_1;
}

display_relics_splash(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_5, var_4 in level.votesys_update_time.weights) {
    var_2 = var_2 + var_4;
    var_1[var_5] = var_2;
  }

  var_6 = randomint(var_2);
  var_7 = undefined;

  foreach(var_5, var_2 in var_1) {
    if(var_6 < var_2) {
      var_7 = var_5;
      break;
    }
  }

  return var_7;
}

dmz_numteamswithplayers(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;
  scripts\mp\hud_message::showsplash("_encstr_95B52803EB1FE82F59AF41C8C795A168D898FF13491FAA4008B771DA702D83A36730C1C7438D29D75005");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("_encstr_8F7D08C66A0125438523");

    while(!self isonground())
      waitframe();
  } else
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);
  wait 1;
  scripts\mp\hud_message::showsplash("_encstr_83E91F454B713480FDCF138AB2DD397A4A5337EFAB3A83781AA97B01DD8380A162");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1", self, 0);
}

dmz_bot_callback_func() {
  if(isDefined(level.numendgame))
    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::startendgame(1);

  level.numendgame = undefined;
}

onstartgametype() {
  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_A5660F7F6E627D337D2B17E9A21DD98F75");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8E0115EFFEFCF57FDDF961736767B9353A5927B7BFB66F");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_9A1A147A4825518645A495A2A6BCD50A92BE09A49C8A");
  }
}

_id_11C83(var_0) {
  thread playerrespawn();
  return 1;
}

_id_125F7(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 0;

  var_0.victim thread playerrespawn();
  return 1;
}

dist_to_line_seg() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91971B3F9B31706D6F220369497F9F9053EECF8122E588A58FABF85042");
  self.waitandpause = 1;

  while(!self isonground())
    waitframe();

  if(level.wait_unload_jeep)
    self.wait_unload_chopper_flood_players = 0;

  self.waitandpause = 0;
  self notify("_encstr_91971B3F9B31706D6F220369497F9F9053EECF8122E588A58FABF85042");
}

distance_weight() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91971B3F9B31706D6F220369497F9F9053EECF8122E588A58FABF85042");
  self.waitandpause = 1;
  self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");

  if(level.wait_unload_jeep)
    self.wait_unload_chopper_flood_players = 0;

  self.waitandpause = 0;
  self notify("_encstr_91971B3F9B31706D6F220369497F9F9053EECF8122E588A58FABF85042");
}

dist_to_line() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.wait_until_player_is_near = 1;

  while(!self isonground())
    waitframe();

  self.wait_until_player_is_near = 0;
}

distort_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(level.waitandpause) {
    if(isDefined(var_1.waitandpause) && var_1.waitandpause == 1)
      var_3 = var_3 * level.waitandspawnprops;

    if(isDefined(var_2) && isDefined(var_2.wait_until_player_is_near) && var_2.wait_until_player_is_near == 1) {
      switch (var_4) {
        case "_encstr_B45C0E2DFF41B17F437FB870E733FBFF":
        case "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421":
        case "_encstr_911B0C7DA090E9A7F799FD50DD48":
        case "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B":
          var_3 = var_3 * level.waitandgetnewspawnpoint;
          break;
      }
    }
  }

  var_3 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::brmodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  return var_3;
}

playerrespawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(level.gameended)) {
    return;
  }
  if(getdvarint("_encstr_937B16E66C4E7D89D6DED7ABE62BFA37C12CBBB9FA99D287", 1) == 1)
    self endon("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");

  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");

  if(!istrue(self._id_13749) || var_0 == 1) {
    var_1 = 1.0;
    wait(var_1);
  }

  var_2 = level.checkpoint_objective_id;
  var_3 = getdvarfloat("_encstr_92A9225776A20F086D77C1FA08D2430953F04EE75377238872837981A8DD78BF28A3725D", 5.0);

  if(var_2 < var_3)
    var_2 = var_3;

  if(level._id_12CB4 != 0)
    var_2 = 0;

  var_4 = getdvarfloat("_encstr_81282083D748495A1DAAE9AB4FEDD7D867CBB4AB1503212B8B456863E04133E90988", 3.0);
  scripts\engine\utility::ent_flag_init("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;

  if(istrue(self._id_13749) || var_0 == 1) {
    var_5 = display_wave_num();
    var_6 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);
    thread patchfix(0.0, var_0 > 1);
    wait(var_4);
  } else if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_2 * 1000));
    var_7 = var_2 - var_3;
    var_8 = var_2 - var_7;
    var_9 = var_2 - getdvarfloat("_encstr_836B22D789622F86887031A3A5A6499227E06F844684118E579B535BE1FFF0D1F94A07ED", 6.0);
    thread patchfix(var_9);
    var_10 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_AA48117347537FEF4F5072DBF877A72789ADE0", var_7);

    if(var_10 == "_encstr_AA48117347537FEF4F5072DBF877A72789ADE0") {
      var_5 = display_wave_num();
      var_6 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);
      thread patchfix(0.0, 1);
      wait(var_4);
    } else {
      thread _id_1400C();
      var_10 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_AA48117347537FEF4F5072DBF877A72789ADE0", var_8);

      if(var_10 == "_encstr_AA48117347537FEF4F5072DBF877A72789ADE0") {
        var_5 = display_wave_num();
        var_6 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);
        thread patchfix(0.0, 1);
        wait(var_4);
      }
    }
  }

  self notify("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");
  var_5 = display_wave_num();
  var_6 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);

  if(istrue(self._id_13749)) {
    self._id_13749 = 0;

    if(var_0 > 1 && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
      scripts\mp\hud_message::showsplash("_encstr_82C214118A27EB28133AFFDF417B103D7F83C8DB9223");
  }

  if(!displaysplashtoplayersinradius(var_5.origin)) {
    var_11 = display_timer(0, 0.7);
    var_5.origin = (var_11[0], var_11[1], var_5.origin[2]);
  }

  scripts\engine\utility::ent_flag_clear("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && isDefined(level._id_124E7))
    var_5 = scripts\engine\utility::getStruct(level._id_124E7, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagwinnerrespawn(1, undefined, var_5, 1, var_6, 1);
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_B8350FE0F4011BF7A6A9FACA8B4BB204A8");
  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);

  if(level.waitandpause) {
    thread distance_weight();
    thread dist_to_line_seg();
    thread dist_to_line();
  }

  self setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);

  foreach(var_13 in level._id_11A32) {
    if(var_13 == self) {
      carriabletype();
      break;
    }
  }
}

display_wave_num() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 1;

  if(isDefined(self.setspawnpoint)) {
    var_0 = self.setspawnpoint.playerspawnpos;
    var_1 = self.setspawnpoint.playerspawnangles;
  }

  var_4 = getdvarfloat("_encstr_9538272328860F37283DBF68F5215859F38EB295B33B022768D3D325D11F228FF37728D5A54738FDFB", 0.8);
  var_5 = getdvarfloat("_encstr_9A8A27CD8DE4F5DAB4CD9D9B36C2BC5993BE27CA6E0758EE9BD42CF04A58235A5D370AAC9C3659373A", 0.9);
  var_6 = getdvarfloat("_encstr_8654217E1EE37FD0D10B90382BF1AAB34B89768DF21BCB1B8E83B8E81307E0B333AF67", 100);

  if(!isDefined(var_0) && var_6 >= 0) {
    var_7 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12568();

    if(isDefined(var_7)) {
      var_8 = display_ready_for_sequence();
      var_9 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
      var_10 = vectorNormalize(var_7.origin - var_8) * (var_9 * var_4) + var_8;
      var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_10, var_6, var_4, var_5);

      if(isDefined(var_0)) {
        var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0);
        var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::registercarryobjectpickupcheck(var_0, var_7.origin);
      }
    }
  }

  if(!isDefined(var_0)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      var_11 = display_ready_for_sequence();
      var_12 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
      var_13 = getdvarint("_encstr_99CD1EDB18F8EF2EF38EED20B2BB5D524F8F6388F8BB57E341EA657BAA0D628F", 1);
      var_14 = getdvarint("_encstr_A16E1F53AE53678EF5F1D2EA304D871FCB07DFF62EB8E7529158E8E2685BFF4760", 1);
      var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_11, var_12, var_4, var_5);
      var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::registercarryobjectpickupcheck(var_0, var_11);
    } else if(isDefined(level.prematchspawnorigins)) {
      if(isDefined(level.teamdata[self.team]["_encstr_922D161FB00D487D73F1B399DB1B3CC06215FFB529F75030"]) && isDefined(level.teamdata[self.team]["_encstr_9A191C9B0EB0DDDC75B41CB29EC95A3B4BDCAAB9CA6A8E0B398E514BDA2B"]) && isDefined(level.checkpoint_objective_id) && level.teamdata[self.team]["_encstr_9A191C9B0EB0DDDC75B41CB29EC95A3B4BDCAAB9CA6A8E0B398E514BDA2B"] + level.checkpoint_objective_id * 1000 > gettime())
        var_0 = level.teamdata[self.team]["_encstr_922D161FB00D487D73F1B399DB1B3CC06215FFB529F75030"];
      else {
        var_15 = [];

        foreach(var_17 in level.prematchspawnorigins) {
          if(distance2dsquared(var_17.origin, self.origin) > var_6)
            var_15[var_15.size] = var_17;
        }

        if(var_15.size == 0)
          var_15 = level.prematchspawnorigins;

        var_15 = scripts\engine\utility::array_randomize(var_15);
        var_0 = var_15[0].origin;
        var_0 = var_0 + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 500);
        level.teamdata[self.team]["_encstr_922D161FB00D487D73F1B399DB1B3CC06215FFB529F75030"] = var_0;
        level.teamdata[self.team]["_encstr_9A191C9B0EB0DDDC75B41CB29EC95A3B4BDCAAB9CA6A8E0B398E514BDA2B"] = gettime();
      }

      var_1 = (0, 0, 0);

      if(var_0[2] > 10000) {
        var_3 = 0;
        var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::getinfilspawnoffset();
      }
    } else {
      var_0 = (0, 0, 0);
      var_1 = (0, 0, 0);
    }
  }

  if(!isDefined(var_1)) {
    var_19 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
    var_20 = vectortoyaw(var_19 - var_0);
    var_1 = (0, var_20, 0);
  }

  if(var_3) {
    if(!isDefined(var_2))
      var_2 = scripts\cp_mp\parachute::getc130height();

    if(isDefined(level.br_circle)) {
      var_21 = level.br_circle.circleindex;
      var_22 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::remove_engineer_class();
      var_23 = isDefined(var_21) && var_21 >= var_22;

      if(var_23)
        var_2 = var_2 * getdvarfloat("_encstr_975C247BE76D3F6D53AF2990C148DF9BD8E07BD52FEFBBC0E3234CDAE1F805A8C120D25AA080", 0.55);
    }

    if(isDefined(level._id_12CA7))
      var_2 = level._id_12CA7;

    var_24 = (0, 0, var_2);
    var_0 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getoffsetspawnorigin(var_0, var_24);
  }

  var_25 = spawnStruct();
  var_25.origin = var_0;
  var_25.angles = var_1;
  var_25.height = var_2;
  return var_25;
}

patchfix(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self notify("_encstr_8A4D10990B46598ABD74CA0B39B4DC76AA38");
  self endon("_encstr_8A4D10990B46598ABD74CA0B39B4DC76AA38");

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  var_2 = 1.0;
  thread fadeoutin();
  wait(var_2 - 0.25);

  if(getdvarint("_encstr_8383230AB9408F7A731D277F712F03EDE8864316514179034E137B7B5B4E482E234E3D1D08", 1) == 1)
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in();

  if(istrue(var_1))
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 6);
  else
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);

  wait 0.25;

  if(getdvarint("_encstr_AC7823E8FF0286ADB285F8F59A6A8F4B688F4098A7A17849DAEAE9F3F2232B30AEDFB028A3", 1) == 1) {
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
    var_3 = display_wave_num();
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_3.origin, var_3.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var_3.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  }
}

fadeoutin() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
}

_id_1400C() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");

  for(;;) {
    if(scripts\engine\utility::ent_flag("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03")) {
      var_0 = display_wave_num();
      var_1 = gettime();

      if(var_1 - self.trial_other_team >= getdvarfloat("_encstr_8E5722D07AD2EF19EF0FC8D60807634571D2C8B0226ECB719F176BC3FE7B2E29A7DA3090", 2.0) * 1000) {
        var_0 = display_wave_num();
        var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
      }
    } else {
      var_0 = display_wave_num();
      var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
    }

    wait 1.0;
  }
}

display_ping_hint_with_radial_check() {
  var_0 = getdvarint("_encstr_8D1B246E8DC9D7B5B4B9CE9BD8582FB293EB334BC99BD17D0EF6A59B3ABE8C2D6E1D857336B2", 30000);
  level.br_level.default_class_chosen[0] = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(level.br_level.default_class_chosen[0], var_0);

  if(istrue(level.wait_to_stop_path_vehicle))
    distsqtodefenderflagstart(0);
  else
    level.br_level.default_class_chosen[1] = level.br_level.default_class_chosen[0];

  var_1 = (level.br_level.default_class_chosen[0][0], level.br_level.default_class_chosen[0][1], 0);
  var_2 = level.br_level.br_circleradii[0];
  var_3 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path(var_1, var_2);
  return var_3;
}

display_message_to_teammates() {
  thread displaysquadmessagetoplayer();
}

displaysquadmessagetoplayer() {
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

dist_sq_to_ref() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    return;
  }
  level waittill("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623");
  wait 20;
  level thread _id_1383F();
}

_id_1383F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    for(var_0 = 0; var_0 < level.wait_till_time; var_0++) {
      var_1 = display_timer(0, 0.6);
      var_2 = spawnStruct();
      var_2.origin = var_1;
      var_2.clear_legacy_pickup_munitions = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
      var_2.clear_legacy_pickup_munitions setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
      level thread mlgiconfullflag(var_2, "_encstr_87DB140A6162E9BB53DA4537BAF218FF6F4A30E0EDED");
    }

    wait(level.wait_to_advance + level.wait_to_reset_wave_loadout);
  }
}

mlgiconfullflag(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.modify_blast_shield_damage))
    var_0.modify_blast_shield_damage = level.wait_unload_chopper;

  if(scripts\cp_mp\utility\game_utility::turretdisabled())
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_0.origin, var_0.modify_blast_shield_damage);
  else
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_0.origin, var_0.modify_blast_shield_damage);

  if(istrue(level._id_1406F))
    var_2 = _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::return_enemy_type_mask(var_2);

  var_3 = _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fn_spec_op_post_customization(undefined, var_2, 1);
  var_4 = distance(var_3.startpt, var_3.endpt);
  var_5 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed();
  var_6 = var_4 / var_5;
  var_7 = _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fntrapdeactivation(var_3, var_4, var_5, var_6);
  var_7.mode_can_play_ending = ::mode_can_play_ending;
  var_7._id_134E2 = var_1;
  var_7 _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fob(1, "_encstr_A77318E360E304B2B3D01A552B636ADD2EC8263E82FE44CA8F5D", "_encstr_81ED11AD96B93BCD1B58E55627D7EEDE4E8DC8", var_0);
}

mode_can_play_ending(var_0, var_1, var_2, var_3) {
  var_4 = self.startpt;
  var_5 = self.centerpt;
  var_6 = self.speed;
  var_7 = distance2d(var_4, var_5) / var_6;
  var_8 = 0;
  var_9 = 0;

  for(level._id_11F2C = level._id_11F2C + var_0; var_8 < var_0; var_12._id_140A0 = relic_laststand_modifyplayerdamage()) {
    wait(var_7);
    var_10 = _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fnchildscorefunc(self.origin, 1);
    var_11 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_10 + (0, 0, level.fnhidefoundintel - 100), var_10, self.angles, var_1, var_2, var_3._id_11EAB);
    var_8++;
    var_11.ml_p2_func = var_3;
    var_11._id_134E2 = self._id_134E2;
    level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var_11;
    var_12 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_11);
  }
}

divide_living_ai(var_0) {
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_BED616F65A021F50CCCFF0E82BFCEB914B07FF8AF94BCB3B", var_2);
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_B4772045F2657BC0A399087092FB8690BA7DCB2FB70EA01557C3C11B0BF33EA014D5", var_2);
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_AFA92636E3C8C752A5273F2F59415B14C0E96EFCFE80828A76635727B778C179B093628333105342", var_2);

  if(!isDefined(var_0._id_11A01))
    var_0._id_11A01 = 1;
  else
    var_0._id_11A01++;

  var_0 scripts\mp\utility\stats::setextrascore1(var_0._id_11A01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_AFA51129F3EFD14A0A6239BBDDF03738838BBB");
}

relic_laststand_modifyplayerdamage() {
  return level.wait_spawn_trucks_smokescreen;
}

brmini_initdialog() {
  level.br_level.br_circleclosetimes = [level.wait_to_advance, level.wait_to_advance];
  level.br_level.br_circledelaytimes = [level.wait_to_reset_wave_loadout + 40, level.wait_to_reset_wave_loadout];
  level.br_level.default_player_connect_black_screen = [1, 0];
  level.br_level.default_suicidebomber_combat = [0, 0];
  level.br_level.br_circleminimapradii = [level.wait_to_spawn_ambush_vehicle, level.wait_to_spawn_ambush_vehicle];
  level.br_level.br_circleradii = [level.wait_unload_chopper, level.wait_unload_chopper, level.wait_unload_chopper];

  if(istrue(level.wait_to_stop_path_vehicle)) {
    var_0 = [];
    var_1 = [];
    var_2 = [];
    var_3 = [];

    for(var_4 = 0; var_4 < level.wait_to_close_in; var_4++) {
      var_0[var_0.size] = level.wait_unload_chopper;
      var_1[var_1.size] = level.wait_to_advance;
      var_2[var_2.size] = level.wait_to_reset_wave_loadout;
      var_3[var_3.size] = level.wait_to_spawn_ambush_vehicle;
    }

    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::open_teleport_room_door(var_0, var_1, var_2, var_3);
  } else
    level.br_level._id_13884 = 1;
}

_id_14365() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  thread dmzextractcost();
}

dlog_analytics_init(var_0) {
  var_0._id_12306 = 0;
  var_0.wagingplayer = 0;
  var_0.vstartposition = 0;
}

dmg_trig(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(level.wait_unload_jeep)
    self.wait_unload_chopper_flood_players = 1;

  lbravo_hover_rider_death_monitor();

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    return;
  }
  if(isDefined(var_1) && isPlayer(self))
    display_welcome(var_1, self);
}

display_welcome(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  if(var_0 != var_1 && isDefined(var_0.team)) {
    var_2 = var_0.team;
    var_3 = 1;
    var_4 = 1;

    if(level.wait_until_truck_arrives_at_station) {
      foreach(var_6 in level._id_11A32) {
        if(!isDefined(var_6)) {
          continue;
        }
        if(var_6.team == var_2) {
          var_4 = 0;
          break;
        }
      }
    }

    if(level.wait_until_impact == 0 && !scripts\mp\flags::gameflag("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C"))
      var_4 = 0;

    if(var_4 == 1) {
      foreach(var_6 in level._id_11A32) {
        if(!isDefined(var_6)) {
          continue;
        }
        var_9 = scripts\engine\utility::ter_op(level.wait_until_trap_room_clear, var_6.team == var_1.team, var_6 == var_1);

        if(var_9) {
          var_3 = level.wait_use_respawn;
          var_0.wagingplayer++;
          var_0 _id_121B6();
          var_1.vstartposition++;
          var_1 _id_121B6();
          var_10 = isDefined(var_0.streakdata.streaks[1]);
          var_11 = display_relics_splash(var_0);
          var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar(var_11, var_10, 1);
          var_0 thread scripts\mp\hud_message::showsplash("_encstr_92A80C6773BEEF806C79483FB0D9" + var_11);
          var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_ABD209607C101FA7481923");
          var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_85B0122B99385D1B96FFD387B7C8029C9001E079" + var_3);
          break;
        }
      }
    }

    if(isDefined(level.teamdata[var_2])) {
      level.teamdata[var_2]["_encstr_BD550F036883656BD815494CBE61BF6A23"] = level.teamdata[var_2]["_encstr_BD550F036883656BD815494CBE61BF6A23"] + var_3;
      var_0._id_12306 = var_0._id_12306 + var_3;

      if(level.wait_until_emp_drone_done > 0) {
        if(level.teamdata[var_2]["_encstr_BD550F036883656BD815494CBE61BF6A23"] >= level.wait_until_emp_drone_done)
          level notify("_encstr_A75017E132FBF880CABF2F395FC3D579644E49991D3D1845A3");
      }
    } else
      scripts\mp\utility\script::laststand_dogtags("_encstr_B448062C935005E2" + var_2 + "_encstr_AF351A901BC32A3D7F38961AF03975F79BF554062DA9778541B8DB92");
  }
}

_id_121B6(var_0) {
  var_1 = self.wagingplayer;

  if(var_1 > 255)
    var_1 = 255;

  var_2 = self.vstartposition;

  if(var_2 > 255)
    var_2 = 255;

  var_1 = var_1 + (var_2 << 8);
  scripts\mp\utility\stats::setextrascore0(var_1);
}

_id_121B4() {
  var_0 = self.wagingplayer;

  if(var_0 > 255)
    var_0 = 255;

  var_1 = self.vstartposition;

  if(var_1 > 255)
    var_1 = 255;

  var_0 = var_0 + (var_1 << 8);
  return var_0;
}

numextractions() {
  level waittill("_encstr_82AA118770E83DA1F98B93B7E1883A7F705B3A");
  waitframe();
  var_0 = getdvarfloat("_encstr_9A751DB9D8C9D789B67B7D56F6DABE1AB263197D1B2C6E86BE373658C62C39", 1.0);
  var_1 = getdvarfloat("_encstr_BA741F08B7FE7E28A2F7F11887C2875B991D33519507DEFEAB2901F79876E43F28", 1.0);
  var_2 = getdvarint("_encstr_91212142880AD60D4FD879150A79A120CD630CDB195D81934735467843C99E37F0FF1E", 3000);
  var_3 = getdvarint("_encstr_91021F1BB71B4F92FD2857C54A10C7ADCBC7704F5717187807774360AAD552257F", 2250);
  var_4 = getdvarint("_encstr_9AE11897DED517E85AA02E78E78811BB950BEEDFA71D32F8E323", 1500);

  foreach(var_6 in level.teamnamelist) {
    var_7 = 0;
    var_8 = 0;
    var_9 = game["_encstr_85920F9B354B5AC018902F3FD811A69307"][var_6];
    var_10 = 0;

    if(var_8)
      var_10 = var_3;
    else if(var_9 <= 10)
      var_10 = var_4;
    else
      var_10 = 750;

    var_11 = scripts\mp\utility\teams::getteamdata(var_6, "_encstr_9775086022BE1B413B8B");

    foreach(var_13 in var_11) {
      var_13 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_138D6();
      var_13 scripts\cp_mp\utility\game_utility::_id_13168(var_9);

      if(!var_13 scripts\mp\utility\game::rankingenabled() || !var_13 hasplayerdata()) {
        continue;
      }
      var_13 scripts\mp\utility\stats::incpersstat("_encstr_B49005512AF703", int(var_7 / 10000));
      var_14 = var_13.pers["_encstr_95EE0966486F7B7989C9B9"];

      if(!isDefined(var_14))
        var_14 = 0;

      var_13 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 0, var_14);
      var_15 = var_13.pers["_encstr_A6120A23912A685B5702D6DF"];

      if(!isDefined(var_15))
        var_15 = 0;

      var_13 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 1, var_15);
      var_16 = var_13.pers["_encstr_A7D40A36EDF6A35ADCD9B028"];

      if(!isDefined(var_16))
        var_16 = 0;

      var_13 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 2, var_16);
      var_17 = 0;

      if(isDefined(var_13.plundercount))
        var_17 = int(var_13.plundercount * var_0);

      var_18 = 0;

      if(isDefined(var_13.plunderbanked))
        var_18 = int(var_13.plunderbanked * var_1);

      var_19 = var_17 + var_18;

      if(var_19 > 0)
        var_13 scripts\mp\rank::giverankxp("_encstr_BD6F167A61F6F38140BF0606B310523F107831F208C0DFC2", var_19, undefined, 1, 1);

      var_13 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 3, 0);
      var_20 = 0;

      if(isDefined(var_13.matchbonus))
        var_20 = int(var_13.matchbonus);

      var_13 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 4, var_20);

      if(var_10 > 0)
        var_13 scripts\mp\rank::giverankxp("_encstr_BE5B10EF3C9676721DD342E11F307842D5C7", var_10, undefined, 1, 1);

      var_13 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 5, var_10);
      var_21 = var_13 getplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 6);
      var_22 = var_21 + var_13.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"];
      var_13 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 7, var_22);
    }
  }
}

dmzlootleaderupdateonpickup(var_0, var_1, var_2) {
  var_3 = int(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_1]);
  var_4 = var_0 - var_3;

  if(var_4 != 0) {
    var_5 = scripts\engine\utility::ter_op(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid(), 1, undefined);
    level thread scripts\mp\gamescore::giveteamscoreforobjective(var_1, var_4, 0, undefined, var_5, var_2);
  }

  return var_4;
}

distsqtodefenderfalgstart(var_0) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, var_0);
}

dmzextractcost() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;
  var_1 = [];
  var_2 = level.spawn_convoy_and_move != 0;
  var_3 = 0;

  for(;;) {
    waittillframeend;
    var_4 = level.fuckwithgravity && level.fuel_stability_event_init && level.fuel_stability_event_start;
    var_5 = level.waitandapplybrweaponxp;
    var_0 = var_0 + level.framedurationseconds;

    if(istrue(level._id_14086))
      var_6 = scripts\mp\flags::gameflag("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C");
    else
      var_6 = var_0 > level._id_12FB3;

    var_7 = level._id_13366 && var_6;
    var_8 = scripts\mp\gamescore::run_common_functions_stealth();
    var_9 = level._id_13ABD;
    var_10 = undefined;
    var_11 = undefined;
    var_12 = undefined;
    var_13 = [];
    var_14 = [];
    var_15 = [];
    var_16 = "_encstr_8BBA05185F8B99";
    var_17 = "_encstr_8BBA05185F8B99";
    var_18 = -1;
    var_19 = 0;

    foreach(var_21 in level.teamnamelist) {
      var_22 = level.teamdata[var_21]["_encstr_BD550F036883656BD815494CBE61BF6A23"];
      var_23 = dmzlootleaderupdateonpickup(var_22, var_21, level.disable_super_in_turret.player_enemy_cooldown);
      var_24 = revive_or_disconnect_monitor(var_21);
      var_25 = var_8[var_21];

      if(var_22 > var_18) {
        if(var_18 > var_19) {
          var_19 = var_18;
          var_17 = var_16;
        }

        var_18 = var_22;
        var_16 = var_21;
      } else if(var_16 != "_encstr_8BBA05185F8B99") {
        if(var_22 > var_19) {
          var_19 = var_22;
          var_17 = var_21;
        }
      }

      var_26 = var_22;
      var_27 = var_22;
      var_28 = 0;

      if(var_27 >= var_5 * 0.9)
        var_10 = var_21;
      else if(var_27 >= var_5 * 0.75)
        var_11 = var_21;
      else if(var_27 >= var_5 * 0.5)
        var_12 = var_21;

      if(var_27 >= var_5 * level._id_127C1)
        thread scripts\mp\music_and_dialog::_id_12791();
      else if(var_27 >= var_5 * level._id_127C3)
        thread scripts\mp\music_and_dialog::_id_127A7();
      else if(var_27 >= var_5 * level._id_127C2)
        thread scripts\mp\music_and_dialog::_id_1278B();
      else if(var_27 >= var_5 * level._id_127C0)
        thread scripts\mp\music_and_dialog::_id_127A9();

      var_29 = scripts\mp\utility\teams::getfriendlyplayers(var_21, 0);
      _id_14004(var_8, var_29);

      foreach(var_31 in var_29) {
        var_14[var_31.guid] = var_31._id_12306;
        var_15[var_31.guid] = var_31;
      }

      if(var_7) {
        if(var_25 == 1)
          var_13[var_13.size] = var_21;
        else if(var_25 <= 5) {
          if(var_24 > 5)
            showsplashtoteam(var_21, "_encstr_B16909D5A7E12D6050F18B");
        } else if(var_25 <= 10) {
          if(var_24 > 10)
            showsplashtoteam(var_21, "_encstr_A35D0ACB9B907B57B0C66A12");
        }
      }

      if(var_27 >= var_5)
        level thread searchradiusidealmin(var_21);
    }

    foreach(var_31 in level.players) {
      var_35 = level.teamdata[var_31.team]["_encstr_BD550F036883656BD815494CBE61BF6A23"];
      var_31 setclientomnvar("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", int(var_35));
      var_31 setclientomnvar("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", int(scripts\engine\utility::ter_op(var_35 >= var_18, var_19, var_18)));
    }

    var_37 = [];
    var_38 = [];

    if(level._id_11A2C == 1)
      var_37 = setteamplacement(game["_encstr_85920F9B354B5AC018902F3FD811A69307"], "_encstr_87070365F7");
    else if(level._id_11A2C == 2) {
      var_37[0] = var_16;
      var_38 = setteamplacement(var_14, "_encstr_9767056D0FBFA8");
    } else
      var_38 = setteamplacement(var_14, "_encstr_9767056D0FBFA8");

    level.disable_super_in_turret.player_enemy_cooldown = var_16;

    if(var_16 == "_encstr_8BBA05185F8B99") {
      var_1 = [];
      waitframe();
      continue;
    }

    if(!var_2 && var_18 >= var_5 * level.spawn_convoy_and_move * 0.1) {
      setomnvar("_encstr_816E211599487D064F3BB248B44F1DC96B697BECB81097BA7E82E809F26C0131EBFC0B", 1);
      var_2 = 1;
    }

    if(!var_7 || var_18 == 0) {
      waitframe();
      continue;
    }

    if(level._id_11A2C > 0) {
      if(level.lootchopper_modifyweapondamage || istrue(level._id_127D2)) {
        _id_13FF0(var_14, var_38, var_15, var_37);
        level._id_127D2 = 0;
      }
    } else if(level.lootchopper_modifyweapondamage || istrue(level._id_127D2)) {
      _id_13FF0(var_14, var_38, var_15);
      level._id_127D2 = 0;
    }

    foreach(var_21 in var_13) {
      if(!scripts\engine\utility::array_contains(var_1, var_21)) {
        if(istrue(level._id_13BE1[var_21])) {
          if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
            showsplashtoteam(var_21, "_encstr_88D7154CD6AF47DE1CEB3AAC2CB6BE9C95D90BB473B232");

          continue;
        }

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
          showsplashtoteam(var_21, "_encstr_B6830C8AADAF636D387FBCB51B88");

        level._id_13BE1[var_21] = 1;
      }
    }

    if(var_13.size > 0) {
      foreach(var_21 in var_1) {
        if(!scripts\engine\utility::array_contains(var_13, var_21))
          showsplashtoteam(var_21, "_encstr_856711FAB067CB6FC368B4DD1F08E7955FE823");
      }
    }

    var_1 = var_13;
    level._id_13BE0 = var_16;
    level._id_12884 = var_8;

    if(!var_4) {
      if(!level.fuel_stability_event_start && isDefined(var_10)) {
        level.fuel_stability_event_start = 1;

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            _id_13372(var_10, "_encstr_845914EEDF913CE8EEBBAC51E3B70F1AC3D06D1ADBEF");
            showsplashtoteam(var_10, "_encstr_92A81275718FEB50726B0BB180D5FF5127790B66");
            level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8E180DB67BCD4FDD7FA0228BB841D7", 0, undefined, undefined, 2);
          }
        }
      } else if(!level.fuel_stability_event_init && isDefined(var_11)) {
        level.fuel_stability_event_init = 1;

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            _id_13372(var_11, "_encstr_8EA814FD55E1339BE31393FE4BBF5852938F2961C5D5");
            showsplashtoteam(var_11, "_encstr_931512D942EFBCC01AF391CF1C85A9DCEED9B363");
          }
        }
      } else if(!level.fuckwithgravity && isDefined(var_12)) {
        level.fuckwithgravity = 1;

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            _id_13372(var_12, "_encstr_8B5514E6B5A711337ADB500143D5A783F21F756B1537");
            showsplashtoteam(var_12, "_encstr_AF0712796D67088B6387B9E7B39AD82AA04903D3");
          }
        }
      }
    }

    waitframe();
  }
}

_id_14004(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_0[var_3.team];
    var_3 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_966115DD134E2B022730DA9210CF7AEB618E554DBD303B", var_4);
    var_3 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B14816D596AF8939EB1CB1B0CBCA9C7D83BD9BB41D2DEDB9", var_4);
  }
}

revive_or_disconnect_monitor(var_0) {
  if(isDefined(level._id_12884))
    return level._id_12884[var_0];

  return -1;
}

_id_13371(var_0) {
  foreach(var_2 in level.players)
  var_2 scripts\mp\hud_message::showsplash(var_0);
}

showsplashtoteam(var_0, var_1) {
  foreach(var_3 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
  var_3 scripts\mp\hud_message::showsplash(var_1);
}

_id_13372(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3) && var_3.team != var_0)
      var_3 scripts\mp\hud_message::showsplash(var_1);
  }
}

setobjectivecallbacks(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  self setclientomnvar(var_0, var_2);
}

setoutputfunc(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  setomnvar(var_0, var_2);
}

_id_13FF0(var_0, var_1, var_2, var_3) {
  level._id_11A36 = level._id_11A32;
  level._id_11A32 = [];

  if(level._id_11A2C == 1) {
    for(var_4 = 0; var_4 < level._id_11A27; var_4++) {
      var_5 = removeplatepouch(var_4, var_0, var_3);

      if(isDefined(var_5))
        level._id_11A32[level._id_11A32.size] = var_2[var_5];
    }
  } else if(level._id_11A2C == 2) {
    var_5 = removeplatepouch(0, var_0, var_3);

    if(isDefined(var_5))
      level._id_11A32[0] = var_2[var_5];

    foreach(var_7 in var_1) {
      var_8 = var_2[var_7];
      var_9 = var_0[var_7];

      if(var_9 == 0) {
        break;
      }

      if(var_9 == level._id_12D6F) {
        continue;
      }
      if(scripts\engine\utility::array_contains(level._id_11A32, var_8)) {
        continue;
      }
      level._id_11A32[level._id_11A32.size] = var_8;

      if(level._id_11A32.size == level._id_11A27) {
        break;
      }
    }
  } else {
    foreach(var_8 in var_1) {
      var_9 = var_0[var_8];

      if(var_9 == 0) {
        break;
      }

      level._id_11A32[level._id_11A32.size] = var_2[var_8];

      if(level._id_11A32.size == level._id_11A27) {
        break;
      }
    }
  }

  foreach(var_8 in level._id_11A36) {
    if(isDefined(var_8) && !scripts\engine\utility::array_contains(level._id_11A32, var_8))
      _id_12C18(var_8);
  }

  level notify("_encstr_B63F14D5722AABEB05273030FF4CC6F9425EC5554AF3");

  if(level._id_11A29.size < level._id_11A27) {
    for(var_4 = 0; var_4 < level._id_11A27; var_4++) {
      var_15 = spawnStruct();
      var_15.hidden = 0;
      var_15 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tape_machine_animations("_encstr_85B42F15A929AD7FE6D143AF11616AA8B050E7AEA3DF405D1FDEEBBB76FACBBB2DD622D6D5489FC9900BBBCFA5831BE208", "_encstr_930B07BB1B6B3854FF");
      level._id_11A29[var_4] = var_15;
    }
  }

  for(var_4 = 0; var_4 < level._id_11A27; var_4++) {
    var_15 = level._id_11A29[var_4];

    if(isDefined(level._id_11A32[var_4])) {
      var_15.targetplayer = level._id_11A32[var_4];
      var_15.targetplayer._id_11A26 = var_15;
      var_16 = var_15.targetplayer.origin;
      var_17 = scripts\engine\utility::array_contains(level._id_11A32, var_15.targetplayer) && !scripts\engine\utility::array_contains(level._id_11A36, var_15.targetplayer);

      if(var_15.hidden == 0) {
        var_18 = scripts\mp\utility\teams::getenemyplayers(var_15.targetplayer.team, 0);

        foreach(var_8 in var_18)
        var_15 displaywelcome(var_8);

        var_21 = scripts\mp\utility\teams::getfriendlyplayers(var_15.targetplayer.team, 0);

        foreach(var_8 in var_21)
        var_15 displaysquadmessagetoteam(var_8);
      }

      if(var_17)
        battle_tracks_updatebattletracks(var_15);

      continue;
    }

    var_15.targetplayer = undefined;
    objective_removeallfrommask(var_15.objectiveiconid);
  }
}

dmzextractcostdecrease() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_B63F14D5722AABEB05273030FF4CC6F9425EC5554AF3");

  for(;;) {
    for(var_0 = 0; var_0 < level._id_11A27; var_0++) {
      var_1 = level._id_11A29[var_0];

      if(isDefined(var_1.targetplayer)) {
        if(!scripts\mp\utility\player::isreallyalive(var_1.targetplayer) && var_1.hidden == 0) {
          var_1.hidden = 1;
          objective_removeallfrommask(var_1.objectiveiconid);
          level notify("_encstr_84A7116416FAB826DB07457BC7807DB88DEBA9", var_1.objectiveiconid);
        } else if(scripts\mp\utility\player::isreallyalive(var_1.targetplayer) && var_1.hidden == 1) {
          if(!level.wait_unload_jeep || isDefined(var_1.targetplayer.wait_unload_chopper_flood_players) && var_1.targetplayer.wait_unload_chopper_flood_players == 0) {
            var_1.hidden = 0;
            var_2 = scripts\mp\utility\teams::getenemyplayers(var_1.targetplayer.team, 0);

            foreach(var_4 in var_2)
            var_1 displaywelcome(var_4);
          }
        }

        var_1 distsqtodefenderfalgstart(var_1.targetplayer.origin);
        continue;
      }

      if(var_1.hidden == 0) {
        var_1.hidden = 1;
        objective_removeallfrommask(var_1.objectiveiconid);
      }
    }

    if(level._id_11A28 > 0) {
      wait(level._id_11A28);
      continue;
    }

    waitframe();
  }
}

displaywelcome(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336C(var_0);
}

displaysquadmessagetoteam(var_0) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_downed_friendly(var_0);
}

removeplatepouch(var_0, var_1, var_2) {
  var_3 = var_2[var_0];
  var_4 = 0;
  var_5 = 0;

  if(level.teamdata[var_3]["_encstr_9775086022BE1B413B8B"].size == 0)
    return undefined;

  var_6 = level.teamdata[var_3]["_encstr_9775086022BE1B413B8B"][0].guid;

  foreach(var_8 in level.teamdata[var_3]["_encstr_9775086022BE1B413B8B"]) {
    var_4 = var_1[var_8.guid];

    if(var_4 > var_5) {
      var_5 = var_4;
      var_6 = var_8.guid;
    }
  }

  return var_6;
}

battle_tracks_updatebattletracks(var_0) {
  var_1 = var_0.targetplayer;

  if(scripts\mp\utility\player::isreallyalive(var_1)) {
    var_1 carriabletype();

    if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
      var_1 scripts\mp\hud_message::showsplash("_encstr_867C1166B1B80771397007CAE0AAE1FA9B45D1");
  }
}

_id_13FF1() {
  level notify("_encstr_A3A4139CACCDA3B093D189BDDBA3C456C21995396E");
  level endon("_encstr_A3A4139CACCDA3B093D189BDDBA3C456C21995396E");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarfloat("_encstr_8295247AC930FFDA2165F733A7D8230728917607A168B783876117ABABE8BA7E50792A0B5930", 15.0);
  var_1 = getdvarfloat("_encstr_9A6B2A02E32B27B0803BF0E9182773318367B91905ABB763E3D797D02D48149BA3DF32300758076AAA17F873", 5.0);
  var_2 = getdvarint("_encstr_8D851B4B568A1F9025103E78F27D27E875BFA8DB83C3722FA07B9005BD", 800);
  var_3 = getdvarint("_encstr_BD2819336A93F8401527FFFF59BA1B399701EB7B027F2D712F0E81", 200);
  var_4 = var_0 - var_1;
  scripts\mp\flags::gameflagwait("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C");

  for(;;) {
    level._id_127D2 = 1;
    scripts\engine\utility::waittill_notify_or_timeout("_encstr_9A521389A527F73A8BA2DBFB3BBD5AB95A518A0B51", var_4);
  }
}

_id_12397() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(isDefined(level._id_12FB3))
    wait(level._id_12FB3);

  if(level.wait_until_emp_drone_done > 0)
    level waittill("_encstr_A75017E132FBF880CABF2F395FC3D579644E49991D3D1845A3");

  scripts\mp\flags::gameflagset("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C");
}

_id_12C18(var_0) {
  var_0 lbravo_hover_rider_death_monitor();

  if(isDefined(var_0._id_11A26)) {
    foreach(var_2 in level.players)
    var_0._id_11A26 displaysquadmessagetoteam(var_2);

    var_4 = var_0._id_11A26.guard_spawners;
    var_0._id_11A26.targetplayer = undefined;
    var_0._id_11A26 = undefined;
  }

  level._id_11A32 = scripts\engine\utility::array_remove(level._id_11A32, var_0);
}

searchradiusidealmin(var_0) {
  waitframe();
  _id_14004(scripts\mp\gamescore::run_common_functions_stealth(), level.players);

  if(istrue(level._id_13DC0)) {
    return;
  }
  level._id_13DC0 = 1;
  level thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
  var_1 = [];

  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595")
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  thread scripts\mp\music_and_dialog::_id_12789(var_1);
}

ononeleftevent(var_0) {}

_id_126A6() {
  if(!istrue(self.controlsfrozen))
    scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_8AA00F577927E3FEA14867A5A159399A8D");

  var_0 = spawnStruct();
  var_1 = self getspectatingplayer();

  if(!isDefined(var_1))
    var_1 = self;

  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;

  if(!var_1 isonground()) {
    var_2 = scripts\engine\trace::create_default_contents(1);
    var_0.origin = scripts\engine\utility::drop_to_ground(var_0.origin, 0, -20000, undefined, var_2);
  }

  var_0.origin = var_0.origin + (0, 0, 100);

  if(!isDefined(level.needs_antenna)) {
    level.needs_antenna = 1;
    level thread _id_13DB9();
  }

  return 1;
}

test_pipe_fire() {
  var_0 = [];
  level.mp_m_trench_patch = [];
  level.mp_m_speedball_patch = [];

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE") {
    level.mp_m_trench_patch[0] = (8682, -1036, 427);
    level.mp_m_speedball_patch[0] = (14, 163, 0);
    level.mp_m_trench_patch[1] = (-1139, -3425, 1116);
    level.mp_m_speedball_patch[1] = (33, 75, 0);
    level.mp_m_trench_patch[2] = (-5567, -4786, 1116);
    level.mp_m_speedball_patch[2] = (37, 192, 0);
  } else {
    level.mp_m_trench_patch[0] = (-36548, -31983, 2400);
    level.mp_m_speedball_patch[0] = (12, 72, 0);
    level.mp_m_trench_patch[1] = (-17592, -36440, 1379);
    level.mp_m_speedball_patch[1] = (17, 90, 0);
    level.mp_m_trench_patch[2] = (-3520, -34298, 1217);
    level.mp_m_speedball_patch[2] = (11, 110, 0);
    level.mp_m_trench_patch[3] = (-9577, -25957, 360);
    level.mp_m_speedball_patch[3] = (357, 82, 0);
    level.mp_m_trench_patch[4] = (23022, -26926, 1359);
    level.mp_m_speedball_patch[4] = (16, 101, 0);
    level.mp_m_trench_patch[5] = (31261, -29753, 1359);
    level.mp_m_speedball_patch[5] = (27, 52, 0);
    level.mp_m_trench_patch[6] = (44843, -41261, 3220);
    level.mp_m_speedball_patch[6] = (16, 52, 0);
    level.mp_m_trench_patch[7] = (44229, -15403, 1331);
    level.mp_m_speedball_patch[7] = (13, 72, 0);
    level.mp_m_trench_patch[8] = (44491, 3484, 1638);
    level.mp_m_speedball_patch[8] = (23, 11, 0);
    level.mp_m_trench_patch[9] = (16047, -3206, 2613);
    level.mp_m_speedball_patch[9] = (27, 309, 0);
    level.mp_m_trench_patch[10] = (5668, -5905, 1614);
    level.mp_m_speedball_patch[10] = (23, 304, 0);
    level.mp_m_trench_patch[11] = (-13412, -20443, 1033);
    level.mp_m_speedball_patch[11] = (11, 109, 0);
    level.mp_m_trench_patch[12] = (-30369, -7811, 1680);
    level.mp_m_speedball_patch[12] = (31, 339, 0);
    level.mp_m_trench_patch[13] = (-26278, 4081, 142);
    level.mp_m_speedball_patch[13] = (6, 110, 0);
    level.mp_m_trench_patch[14] = (-16429, 6021, 847);
    level.mp_m_speedball_patch[14] = (21, 57, 0);
    level.mp_m_trench_patch[15] = (-7525, 11672, 1082);
    level.mp_m_speedball_patch[15] = (14, 46, 0);
    level.mp_m_trench_patch[16] = (8356, 15296, 2021);
    level.mp_m_speedball_patch[16] = (12, 38, 0);
    level.mp_m_trench_patch[17] = (26010, 29975, 2716);
    level.mp_m_speedball_patch[17] = (13, 68, 0);
    level.mp_m_trench_patch[18] = (12043, 30910, 3081);
    level.mp_m_speedball_patch[18] = (21, 88, 0);
    level.mp_m_trench_patch[19] = (7127, 52592, 2100);
    level.mp_m_speedball_patch[19] = (28, 241, 0);
    level.mp_m_trench_patch[20] = (-6693, 56481, 4026);
    level.mp_m_speedball_patch[20] = (16, 246, 0);
    level.mp_m_trench_patch[21] = (-21394, 37175, 757);
    level.mp_m_speedball_patch[21] = (2, 124, 0);
    level.mp_m_trench_patch[22] = (-26151, 25577, 271);
    level.mp_m_speedball_patch[22] = (357, 10, 0);
  }
}

_id_13DB9() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    var_2 thread _id_12753(var_2, registerquestcategorytablevalues(var_2));
    var_0++;

    if(var_0 == 5) {
      waitframe();
      var_0 = 0;
    }
  }
}

registerquestcategorytablevalues(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_6, var_4 in level.mp_m_trench_patch) {
    var_5 = distance2dsquared(var_0.origin, var_4);

    if(var_5 <= 9000000)
      return var_6;

    if(!isDefined(var_2) || var_2 > var_5) {
      var_2 = var_5;
      var_1 = var_6;
    }
  }

  return var_1;
}

_id_12753(var_0, var_1) {
  var_2 = level.mp_m_trench_patch[var_1];
  var_3 = level.mp_m_speedball_patch[var_1];
  var_4 = var_2 + anglestoright(var_3) * 1000;
  var_5 = var_3;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_6 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6.angles = var_3;
  var_0 cameralinkTo(var_6, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 moveTo(var_4, 60);
  var_6 rotateTo(var_5, 60);
}

dist_miles() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread dmzminextractcost();

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
    distsqtodefenderflagstart();
  }
}

distsqtodefenderflagstart(var_0) {
  if(!isDefined(var_0))
    var_0 = level.br_circle.circleindex + 1;

  if(level.br_level.default_class_chosen.size <= var_0 || !istrue(level.wait_to_stop_path_vehicle)) {
    return;
  }
  var_1 = level.br_level.default_class_chosen[var_0];
  var_2 = level.wait_to_spawn_r0;
  var_3 = level._id_11A32.size > 0;

  if(var_3) {
    var_4 = level._id_11A32[0].origin;
    var_5 = scripts\engine\utility::ter_op(level.wait_to_start_exfil_obj, var_1 - var_4, var_4 - var_1);
  } else {
    var_6 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_1, var_2, 0.8, 1.0, 1, 0, 1);
    var_5 = var_6 - var_1;
  }

  var_5 = vectorNormalize(var_5) * var_2;
  var_7 = var_1 + var_5;
  var_8 = !_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_7, 1);

  if(var_8) {
    var_5 = vectorNormalize(level.br_level.br_mapcenter - var_1) * var_2;
    var_7 = var_1 + var_5;
    var_8 = !_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_7, 1);

    if(var_8)
      var_7 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_1, var_2, 0.8, 1.0, 1, 0, 1);
  }

  level.br_level.default_class_chosen[var_0 + 1] = var_7;
}

displaysplashtoplayers(var_0) {
  var_1 = level.br_level.br_mapbounds;
  var_2 = level.wait_to_stop_pre_tmtyl_spawners;
  var_3 = var_0[0] < var_1[0][0] * var_2 && var_0[0] > var_1[1][0] * var_2 && var_0[1] < var_1[0][1] * var_2 && var_0[1] > var_1[1][1] * var_2;
  return var_3;
}

dmzminextractcost() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.group_unset_jugg_ignoreall_after_notify = gettime();

  for(;;) {
    level waittill("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD");
    level.group_unset_jugg_ignoreall_after_notify = gettime();
  }
}

display_reinforcement_called_icon() {
  return (gettime() - level.group_unset_jugg_ignoreall_after_notify) / 1000 / level.wait_to_advance;
}

display_ready_for_sequence() {
  var_0 = display_reinforcement_called_icon();

  if(level.br_circle.circleindex < 0)
    return level.br_level.default_class_chosen[0];

  if(var_0 > 1)
    return level.br_level.default_class_chosen[level.br_circle.circleindex];

  var_1 = level.br_level.default_class_chosen[level.br_circle.circleindex + 1];
  var_2 = level.br_level.default_class_chosen[level.br_circle.circleindex];
  return vectorlerp(var_2, var_1, display_reinforcement_called_icon());
}

displaysplashtoplayersinradius(var_0) {
  var_1 = display_ready_for_sequence();
  var_2 = distance2d(var_0, var_1);
  return var_2 < level.wait_unload_chopper;
}

display_timer(var_0, var_1) {
  var_2 = display_ready_for_sequence();
  return _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_2, level.wait_unload_chopper, var_0, var_1);
}

carriabletype() {
  if(!isDefined(self.carryflag)) {
    self attach("_encstr_82DE14039E45A058F75CFDAFD91F804BC0F0F9947638", "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6", 1);
    self.carryflag = "_encstr_BDAF1807E4F683FA8D1DCCFACE2CAD56BE66638576BEEECADC1D";
    self setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 1);
  }
}

lbravo_hover_rider_death_monitor() {
  if(isDefined(self.carryflag)) {
    self detach("_encstr_82DE14039E45A058F75CFDAFD91F804BC0F0F9947638", "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6");
    self.carryflag = undefined;
    self setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);
  }
}