/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_dmz.gsc
***********************************************/

init() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A78F076CA54E1B1B56");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BDC6085DF29A892901C7");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B49086F374076B48192");

  if(getdvarint("_encstr_937B16E66C4E7D89D6DED7ABE62BFA37C12CBBB9FA99D287", 1) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_838F0D8DEFA26BC7D83780300FF4D9");

  if(getdvarint("_encstr_A9F4146E8D4EEB4C93BEC8B5E9EB8DC2E89535B796E6", 0) != 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BA32084FFD08358F1C99");

  if(getdvarint("_encstr_8DD8129B364E7D895BDBD7AEB959964BBD6EB59B", 1) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_B48D064CB8E8E33A");

  if(getdvarint("_encstr_A2341C573F9318A8AD1D26794589E0C95A4BEBFDFB0A5511FDB248F12E75", 1) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_8CE50ED185C48D59A325B238360B36AC");

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A4319E0710B51CAC6649BE8B2B33B4DD36D17ABDC83956D875BD0", ::playerdropplunderondeath);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8449141CD8B0972B4EA986B7EA63194A956E830BEE9B", ::_id_12691);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::_id_126F1);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8EC10D5F713FFBE6C151ED77E87034", ::_id_1365D);
  level._id_13ABD = getdvarint("_encstr_997B14B936937D19B5D3EB3A56C2ADA0B1BAB9C85939", 0);

  if(level._id_13ABD) {}

  level.disable_super_in_turret._id_11B5D = getdvarint("_encstr_9BCD1F9B364EAF8927BECA3CA39C586CA3AF5BC2C37DAC0F3A39C2C64796B7DCE6", 5);
  level.disable_super_in_turret._id_11F3B = 0;
  level.disable_super_in_turret.player_enemy_cooldown = "_encstr_8D19048EA595";
  level.br_prematchffa = 0;
  setDvar("_encstr_812214C8DF22A68D63E987193DEAFF8C976FF8B06FDC", 1);
  level._id_13BE1 = [];
  level._id_11A32 = [];
  level.onstun = [];
  level.fuckwithgravity = 0;
  level.fuel_stability_event_init = 0;
  level.fuel_stability_event_start = 0;
  var_0 = getdvarint("_encstr_97EB11CDB1E4FA19B63DBEDD4BE6D7B1DBCDA3", 1000);

  if(var_0 > 0) {
    var_0 = var_0 * 10;
    var_0 = var_0 * 100;
    setDvar("_encstr_8B3C125FEF4E8FC583783BF752AB3D92D999A173", var_0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), var_0);
  }

  setDvar("_encstr_9A4E10AB261DF7EA8A01A7AF27B3FA1B1D51", 3);
  setDvar("_encstr_A14816336A93F840D21799E7513F60B5D30108DB831728F8", "_encstr_8DDE08CDF61D434BB9B3");
  setdvarifuninitialized("_encstr_AD59209A0106B7A90B818BA0ABB08F43909D8F1BB18B4F33F00ECCD374E7F3EBF094", 10000);
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 4);
  setomnvar("_encstr_A7990F658429177BBC4FF8417FDCB179D2", 1);
  setomnvar("_encstr_A2E017BB686F48581C5A01DBF76C5DFA1A4F49C9DB201ABD98", 1);
  setdvarifuninitialized("_encstr_A9E21293B8454913DB20EAE1406D1F0E91300BCA", 1);
  level.scriptedphysicaldofenabled = getdvarint("_encstr_957C1D339F73695A50D81FF9A73379A57BD83260B81BCDEC17132A6FDAF9AA", 1);
  level.trackriotshield_tryreset = getdvarint("_encstr_8FB0219BC6E4EBC45BDBBED237B93A58374709D856568C7AABA3A92EABB032AE960EB2", 1);
  level.debug_kill_tromeo = getdvarint("_encstr_A97C28C7320AA90A7A6AA11ED8215150F81791C2EA2590DBDB041A217F436582E56B3354A7ED2898BAF0", 50);
  level._id_13BDF = getdvarint("_encstr_A6A1256B46DACF16BFAFD87B47176737AE71BF3AFB20670A3B689DE960FDBB8B4DB8CF4E4FC5B8", 5);
  level._id_14086 = getdvarint("_encstr_B2D91B7B77AD67B3BBEFDE836702C1E8A06018C8DF05755724990FA73A", 1);
  level._id_11BE6 = getdvarint("_encstr_84711C6E8D9CBEC4ADDBEBD62DB1ACB93AB773CA41862CB9AC7D952528DC", 10);
  level._id_11BE5 = getdvarint("_encstr_81EE1BCD36C9FA895BDB7DD6961BACE68EEDDCCA4134B0CD2BF531A5E6", 30);
  level._id_11BE3 = getdvarint("_encstr_86221DBFAF2DE170A01899F14F3802E619552D254FB8A9D0057FB9FB60581B", 50);
  level._id_11BE4 = getdvarint("_encstr_A39F1DDB6ECA418E12776F03472A459864C5E0915A08783ECACF592B4B8296", 75);
  level.br_checkforlaststandwipe = getdvarint("_encstr_956D21771FB338B8CD384699E4BAF0E61A3BB7DDAF0BFD991BD6CBB00191609013DB69", 750);
  level.spawn_default_player_spawns = getdvarint("_encstr_960422DCD839EB26B6F6EB1A4B8CAC28C6B0D8B2DA95B9D1AA9BD196632856C9D8B2DC47", 10);
  level.spawn_convoy_and_move = getdvarint("_encstr_8FEF237B98AA0FD055F7BF804CA30A68C030B7AD7293B03F6887A323472A389D833250B32B", 0);
  level._id_13366 = getdvarint("_encstr_AC5B214F4746891A1880B1421B30271395FFC7B709E1D2C3D829B206F02345BB76631F", 1);
  level._id_12FB3 = getdvarint("_encstr_8C7C265A366D79F238E0DF6798D1A73229566E572CEF633D67E01F3FE04865FAD1FD6A8F0731AA53", 60);
  level.loadout_updateclassdefault_headlessgetweaponn = getdvarint("_encstr_838E230E6E930FE1C51F61B02FF359AD9A179017472B3F0EB103D0F0A73651EBD2BFF09D5A", 0);
  level._id_11A27 = getdvarint("_encstr_A7441F0E7A233F60F3FD5F2437706897E1CD1613F345787108439ADF23A2B3CE41", 3);
  level._id_11B62 = getdvarint("_encstr_A7441F0E7A233F60F3FD5F2437706897E1CD1613F345787108439ADF23A2B3CE41", 3);
  level._id_11A2A = getdvarint("_encstr_877A1ECB5B0AD156BD1038487572552712692E416F2BF110C730AF57D6322D82", 5000);
  level._id_11A31 = getdvarint("_encstr_82DE21331602D9C5EF989F83D51D282F88ED199C77905F2DD0E07F53608AD6B84D89A0", 1) == 1;
  level._id_11A2B = getdvarint("_encstr_825726CD1BC97D135BBDFA367BED47FA632B0B46B2E47DAD16936DD7DCB49EB27D9197730BB6A5B1", 1);
  level._id_11A2D = getdvarint("_encstr_A31B2AE61B9C7D13DAEDBE1BDBDB8ED78DCA0B192B937D5B0BC9B5EBB4B933B7FA9B47C9B7CD76AFE6B4D395", 2000);
  level._id_11A2E = getdvarint("_encstr_81A42B7BCF98D99BA1F0D1EAD8889B8163BBE1F46B20116F5F4BAAC160501B45413F8C6AE728A7DFFCC1D26BC9", 5000);
  level._id_11A2F = getdvarint("_encstr_870728637E8BC78EE8878129409733872321C05595A277E59B8AC8A761E5899AD18BB52FB8A0D34138E8", 5000);
  level._id_11A30 = getdvarint("_encstr_827C29B96C27BE26DAF67D36DBBD477DC695B023CA9CF5D6B0E4D6AFD29B99DB7DBB95B05BFA9D0B8DEAAC", 1000);
  level.onsquadeliminatedplacement = getdvarint("_encstr_815B245F379B10D0A5153E503D9F58A8D2B7F389C743D8A0D8AAE0ABA77CC9FD8A0F6D117F4A", 0) == 1;
  level._id_11A2C = getdvarint("_encstr_83AD23D6662AD97228C787C5AA20A0D058E7F7A138A3577A6B20FFE12B8052A940F92EF29F", 2);
  level._id_127C0 = getdvarfloat("_encstr_AF5714E7636201C6471A0E7083070BA871FE5B9D1B4B", 0.3);
  level._id_127C2 = getdvarfloat("_encstr_81DF1513A7F0B1E3D9988952232E0776412FBD8B277807", 0.5);
  level._id_127C3 = getdvarfloat("_encstr_8E7114FE9E63FF71558FD148CF63283F19C3FB0B32DA", 0.75);
  level._id_127C1 = getdvarfloat("_encstr_8E5C15B9C64EFA896B7BFADA5D9B5AB1BE66DB5D931DD0", 0.9);
  level._id_14062 = getdvarint("_encstr_AA3317BF4BDA37E088AB17D3731D9D8B2B6F768263702233BD", 1);
  level.checkpoint_objective_id = getdvarint("_encstr_91C21C68C26A4771B772A0A755FBD8E5176BE870FB051FE97F842DAB55C7", 20);
  level._id_13BCD = getdvarint("_encstr_92B61DE68D93BEC8AD4FD78EEDB6CAE64ACADC0E0BEECDBAC2A5478AB46BAC", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("_encstr_82761837E0B35F42D332C18295D73B29BB100F43B868D90A094B", 0);
  level.start_pipe_room = getdvarfloat("_encstr_88CA1C37B193FA235B9EBE9356CD0E58DD73D71C56DCB0B18EE5FAAD0BE1", 15);
  level._id_12CA7 = getdvarint("_encstr_AC901E8F42F251C16B28E762A5F64079AF1E84399B1FC37398E40A3BAA4BCABD", 8000);
  level._id_12CB4 = getdvarint("_encstr_83AB1DD6662AD974289387420AC080CF3B250F8158526D5961F8CF0273E017", 0);
  level._id_121CC = getdvarfloat("_encstr_A6D41D9BB19C7D4C6BBDEB83859C16360DD53A2B88CA071BDBF22256D858E5", 0.5);
  level.current_trigger = getdvarint("_encstr_88F31A378D93BEC8B53D7D26DB73AEDC225958A3D0418D57E646B2C9", 200);
  level.current_volume_allies = getdvarint("_encstr_9B781D325E15019C50D0779B60E8450BC1E53E6BB3396AB518C897D3C9A01C", 250);
  level._id_11B6C = getdvarint("_encstr_97391E6ED893EBC4D6F6D76BB00F288DEAB98C5627229CB71C7ADC11B22C1D0D", 10000);
  level._id_11C40 = getdvarint("_encstr_81761E4F98CBD7AA4B2049FD1B65C1BC73986B9F88A532A289D80DBF7523BB70", 200);
  level._id_122F5 = getdvarint("_encstr_A7391E6ED893AF4C6BBDEB835693C6B2DC3A85D9CA82B1BACD91593922E4DB1C", 50);
  level._id_127BC = getdvarint("_encstr_9359229B1BC9AFC4ADDED73836BAE6C8AC39232C9EDC884EB7C1150D93B216B91A7B6346", 750);
  level._id_11B6B = getdvarint("_encstr_87A8217BCF98D99BA1F0D1FA19030B4DC8ADE4F545915A67D72CFAC083D54B83F0039D", 2000);
  level.oic_loadouts = getdvarfloat("_encstr_998520CDD8277D13ADDB7DCA1E951BAE1D4BF6E6D00BB9436A57B1A3B483635AB227", 1);
  level.checkforcorrectinstance = getdvarint("_encstr_BE731DA211E82732D99D1FDFBB7DCA71B87B5C2F28E1A98B2E692F87F3A643", 0);
  level._id_12966 = getdvarint("_encstr_81B918D2BEF5E17AB05857F790E9231BE1C0DD87135F8BADD878", 5000);
  level._id_12965 = getdvarint("_encstr_ABB91856D70310E9573F57F03FA1E7D00845E308576E9B713E4B", 10000);
  level._id_12962 = getdvarint("_encstr_950F18BF4F5B1F580F97483ACB87F7F423580A21A228480B9488", 2500);
  level._id_12961 = getdvarint("_encstr_8B0F186ED893FA316BF6F52ED5CA6EA350E66E11D237D153C2C3", 7500);
  level._id_12968 = getdvarint("_encstr_A2D219620E2531AA60A8A7274059734BBF966EDB75BB4BE40CF06B", 5000);
  level._id_12967 = getdvarint("_encstr_ABD219B8F6201FB5C81FEF7A836743858F1B290B593307D3890690", 8000);
  level._id_1296A = getdvarint("_encstr_A2D219620E2531AA60A8A7274059734BBF966EDB75BB4BE40CF06B", 5000);
  level._id_12969 = getdvarint("_encstr_ABD219B8F6201FB5C81FEF7A836743858F1B290B593307D3890690", 8000);
  level._id_139EA = getdvarfloat("_encstr_8A90218BAB6B994A6A37682B235FCB80D7C9A0B55F03D10538133206695D35A5FABAE0", 1.5);
  level._id_133EA = getdvarint("_encstr_BA2D1EDC1B9CFA4CB6EDEBB95BB41C5D2B2C0EBDDC229CDE0E9ECD22B2161DD0", 0);
  level._id_133CD = getdvarint("_encstr_8BC02113A7F0B1E3D99889B3E02363FF3023B198232085E36513828B4C88CBAF18D938", 1);
  level.playerismatchedplayerready = getdvarint("_encstr_922A1E3FBB4A29FE7F3256795A6B26A02E02BB8F323F88B033280825C2FF6543", 1);
  level.brjuggsettings = getdvarint("_encstr_AA541FD75E18D98ED75A110B2A016A54DD8B14D5AF0E690A4FE850FDA13AD203D1", 1);
  level._id_13AB9 = getdvarint("_encstr_B64014D6B64BD7290DE7A9D0CF5763EBE15FCBD48C02", 0) == 1;
  level._id_13ABA = getdvarint("_encstr_96DE1E4632B3476AAAE7796022FA0C73577B630AE32E68EB5B0791356FE8B4CB", 0) == 1;
  level._id_13ABC = getdvarint("_encstr_BD101462D128E7921977DF4343BF3B1568F8916B09A0", 0) == 1;
  level._id_13ABB = getdvarint("_encstr_A95A14DCB14EEBC4D67BD7598799D28DF5D14B6BB239", 180);
  level._id_13368 = getdvarint("_encstr_9B95276E6C27FA13B5F6BEC1B1D5738CAC39AC0FA3272CD847EB7B319A966CDBCD7D2DCDEEBDE41B8C", 1) == 1;
  level._id_13363 = getdvarint("_encstr_A7C9261B3E456843A36037F9CBDB12025F606F15634AD45757C391E8E06DBFEED3C2BBA139052127", 0);
  level._id_13B85 = getdvarint("_encstr_A1441F06669B07F9DD17593837E5D1AF334BE80F3D43DD61BD0B8050AB1269EF4B", 0);
  level._id_11DAD = getdvarint("_encstr_9358229B1BC9AFC4ADDED7B6B73B56BE0E36BA37C8CA4EAC3CD19C2C1B3AF5B79BAB9B56", 0) == 1;
  level.overheatlimit = int(getdvarint("_encstr_8DAB1CCAB933980E7F67184221A0434B1AE386E0ADEC105F990B062D99A2", 999) * 100);
  level.overheatreductionamount = getdvarint("_encstr_8A3122FE2B83A6950DAA9940F3636DB92FC410FB854328A774A2E8D84A3D0B937F7A01E5", 1);
  level.choppergunner_handledangerzone = getdvarint("_encstr_B45A2013A7F0B1E3D99889D282AD6BF6A021879821A085A3F513811A68060BAE60D9", 1);
  level._id_127BA = getdvarint("_encstr_8CF21E9B17EA7E555A5DD04F753385C125FBD938E384930B828328DF4D6AC58B", 1);
  level._id_11B3F = getdvarint("_encstr_91D124B346F5F96A18B02F987349BA1CBA33E11DEB7717380B72DEAF34F39B2CAFBF1988BFC1", 120);
  level.spawn_boss_wave_suicidebombers = getdvarint("_encstr_A16D2353AE53678ECB70F1FB90034543698ECDE0BD3BE796D1D98A62F80B715FA0F54375DD", 1);
  level._id_1323E = scripts\engine\utility::ter_op(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE", 0, getdvarint("_encstr_8BB4245047BA2E056A6DAF9F85C355F115AB7880E352213FA319852B5A2BB5187A2F78F02716", 1));
  level._id_12F10 = getdvarint("_encstr_81161F62435ADFFB2580175B82883087E18A5772CB04C229230FA60876BA515312", 0);
  level.locale_defaults = getdvarint("_encstr_A18F1DE63693D798B5ED7D8CB49BB0311BCAEBEE5ACDBE7BE6F5371B7BC9AC", 0);
  level.make_bomb_detonator_interact = getdvarint("_encstr_B1F215D0C73AAE85EAED8095C5C2B710849F708807C5C3", 30);
  level._id_13124 = level.make_bomb_detonator_interact > 0;
  level._id_12191 = getdvarint("_encstr_954A1937B14ED7985BB7D7BDE87D0B37BED62C8ED81AD7E84B6BCA", 1);
  level.chopperexif_fx_init = getdvarint("_encstr_A9FE1807834221E6673A2E11421F3080DE16BFE73CEDD9BD43A2", 0);
  level._id_11ADC = getdvarint("_encstr_B8B81E9BC6E4EB8CDAD3D7B6C2C1A8C876B2510F474E851BA35ADEE689BD8DDC", 0);
  level._id_11C85 = ::_id_126A6;
  level.needs_controller = getdvarint("_encstr_878622C06AC2DF29DF1FD8CDE603346BABF290F9E25DD363C70C5637CE77F81954DA38F0", 1);
  level._id_12192 = getdvarfloat("_encstr_8B011F9BC6ED71EDF84AE118A02B5BF1DBA8A7AD1F2B13A1EF6B8D89ABF0B08F13", 2);
  setomnvar("_encstr_A1C11F9D415761D5E1CAF0607343BBD817CF2E1FB3730E2353E298186B9D731113", level._id_12192);
  level.loadout_updatebrammo = getdvarint("_encstr_AC24217FFB0A69BE3F7296F9FAAFE75825559FCF6EB72171175A6E41B283A8A87DAB63", 0);
  level.lootchopper_modifyweapondamage = getdvarint("_encstr_837B25932770317B59BA09C2E0A0F3F95883390CB3184967FF51E24B8990E7ED6951B993C7984A", 0) == 1;
  level.lootcontentsadjusteconomy_bottomtier = getdvarint("_encstr_97EB11CDB1E4FA19B63DBEDD4BE6D7B1DBCDA3", 1000) * 1000;
  level.lootchopper_isnearbyoccupiedspawns = getdvarint("_encstr_83EE14FFF716D94AB0F64F108B6891D2ED7737177FBD", 300);
  level.lootchopper_oncrateuse = getdvarint("_encstr_8BF718EB49383FE0EA315F20D3FE2067F8D836A8972BB1B394CD", 40);
  level.lootchopper_managespawns = getdvarint("_encstr_976F1D9B6CC9FA31397DAC0F1D4EB0B1D1AFC6BD9B3AF519566C39B2589B56", 20);
  level._id_11C41 = getdvarint("_encstr_AF2A1B7B357F689183A6C17385B8FB4766D103EA8D065312E9E047D8CB", 7);
  level._id_11B6D = getdvarint("_encstr_AA251BE27B5F90AB22AF3064ABF8B5F322DF48B9D973EA9E9BDC923096", 7);
  level.disable_back_light = 1;
  thread _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::init();
  thread toggleusbstickinhand();
  thread teleportplayertoselection();
}

toggleusbstickinhand() {
  waittillframeend;
  level.uavsettings["_encstr_851904B59B34"].timeout = 60;
  scripts\mp\flags::gameflaginit("_encstr_9B4D0D4F2F58F937589BA94940E3AF", 0);
  scripts\mp\flags::gameflaginit("_encstr_B6BB1240173C186F4AF3D79FFF12B561CC6D0879", 0);
  scripts\mp\flags::gameflaginit("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C", 0);
  scripts\mp\flags::gameflaginit("_encstr_811D12412EE567151F4DB94E919A9269AFA20A3F", 0);
  scripts\mp\flags::gameflaginit("_encstr_B6CB14C26CE8B4D9C2472BF5C62CCDA1D72339DE1C37", 0);
  scripts\mp\flags::gameflaginit("_encstr_ACA314B97949B81C7ABB4D7716BB678B8FF1D18228CE", 0);
  level._id_11C76 = ::dyn_door;
  level.elevator_lights_toggle = ::_id_11C50;
  level.ononeleftevent = ::ononeleftevent;
  level.onplayerkilled = ::onplayerkilled;
  level._id_12075 = ::_id_12075;
  level.ontimelimit = ::ontimelimit;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_12601);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  thread _id_1325E();
  thread _encstr_8A362837E0B36903E1B6DD451F6F4A29F848A3671009CB3E25CED93D888733F3A0B02BCB2B035EE25F6E::_id_11A0F();
  thread _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fnoffhandfire();
  level._id_11A29 = [];
  level.onstompeenemyprogressupdate = [];

  for(var_0 = 0; var_0 < level._id_11A27; var_0++) {
    var_1 = 1;
    var_2 = scripts\engine\utility::ter_op(level._id_11A2C > 0 && var_0 == 0, 5, 4);
    var_3 = spawnStruct();
    var_3.modifier = "_encstr_B40101";
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(var_1, var_2);
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(level._id_11A2A);
    level._id_11A29[var_0] = var_3;
    var_3 = spawnStruct();
    var_3.modifier = "_encstr_B40101";
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(var_1, var_2, 2);
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(level._id_11A2A);
    level.onstompeenemyprogressupdate[var_0] = var_3;
  }

  if(!istrue(level._id_14086))
    level thread _id_12397();

  thread _id_14364();
  level thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::teamvehicles();
  cleanupents();

  if(level._id_13ABD) {
    if(getdvarfloat("_encstr_8295247AC930FFDA2165F733A7D8230728917607A168B783876117ABABE8BA7E50792A0B5930", 15.0) > 0.0)
      level thread _id_13FF1();
  }

  if(level._id_13368 && level._id_13363)
    level thread init_relic_team_proximity();

  if(level._id_13B85 > 0) {
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

    if(level._id_11B3F > 0)
      wait(level._id_11B3F);

    level thread _id_1386C();
  }

  if(istrue(level._id_11ADC))
    level thread test_trigger_spawn();

  level._id_140D9 = [];
  level._id_140D9[0] = "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0";
  level._id_140D9[1] = "_encstr_A1580B19DE5B5A9B0BA35AEDCD";
  level._id_140D9[2] = "_encstr_AF460A7B2649F34FE367455D";
  level thread numextractions();

  if(istrue(level.needs_controller))
    level thread test_pipe_fire();

  var_4 = getdvarint("_encstr_9B6E1ADCB127EB26B6F67D1BC49960F43B564E272D325935E09595C8", -1);

  if(var_4 > 0)
    level.br_level.c130_speedoverride = var_4;

  level thread getblockedweaponvariantidsmap();

  if(level.make_bomb_detonator_interact && level._id_12191)
    level thread getburnfxstatepriority();
}

getblockedweaponvariantidsmap() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    return;
  }
  level endon("_encstr_A7EA16E7AD5D990B28138E55E9A044322DC3873B0B71E2D2");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = getdvarint("_encstr_A26D119A30E6465823A63BC34D3B7AC2EA1B0B");
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 5);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime() + int(var_0 * 1000));
  wait(int(max(var_0 - 300, 0)));
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 6);
}

getburnfxstatepriority() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = getdvarint("_encstr_A26D119A30E6465823A63BC34D3B7AC2EA1B0B");
  var_1 = int(max(var_0 - level.make_bomb_detonator_interact, 0));

  if(var_1 <= 0) {
    return;
  }
  wait(var_1);
  level notify("_encstr_A7EA16E7AD5D990B28138E55E9A044322DC3873B0B71E2D2");
  level thread _id_13DC8(undefined, undefined, 1);
}

_id_14363() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.audio_railyard_fires = [];
  level.audio_railyard_fires["_encstr_BEE405E768BB54"] = "_encstr_A2822503507EFABB6308F36C851121924160CB9F90F03982B720FF25652B9B776810FF27504969";
  level.audio_railyard_fires["_encstr_A11F05251783F1"] = "_encstr_92FC251A5837494540BFBBE36B68E943BD576B777F103A384271E5505061EBB70786F13A663550";
  level.audio_railyard_fires["_encstr_B89B05311BD04E"] = "_encstr_B4C4255953AFFE589E9F7D77C00269BEEF5B53614B93A37037870B75F52D909087E20EE98317EF";
  level._id_121D0 = getdvarint("_encstr_A79B2A6606FB67DBB103C8A013DD135B71AD5CE5DAB2EB219C9F70B853EE48955AD9D57BF5DAB7EB5487B830", 45000);
  level._id_121CE = getdvarint("_encstr_A99E336E1B4EAFC1C2E4B0C6345D3A2BF5ED3BB24E862B0B32BEEE58E4DC969BECD73839B25BB0E8B1A1AF1DA5D6CADEAE47BEB6DC", 20000);
  level._id_121CF = getdvarint("_encstr_B63726E61B93D7E0B03916D8D05D8E95BEDECE56E4A12B588CAFBB0B9C374B37CEEB270B19D2AB9B", 2000);
  level._id_121CD = getdvarint("_encstr_8FA726573F931838A15AE1B9C49D504DF9A7C5F383DADD88FC792BF16A7E607012FF710B477213E8", 3000);
  level thread _id_144EB(level._id_121CE);
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level notify("_encstr_848F220BAB18B6E74196F39A1B2E0B6140139291C7507BEBFD2B4B6140FC776258F3391C");
  waitframe();
  level thread _id_144EB(level._id_121D0);
}

_id_14364() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  thread _id_127C6();
}

cleanupents() {
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_920D1AA7081FE397C3407F2F90385F3AD3112D91E1A33BF12841672B", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_B49F18FD153A2D2EB707C88837F6666162FDE571E1F2F116D816", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_99291CC83F37405922F7696D37AA17D09F5630E22963800E1AF7912F6AD7", 1);
}

onplayerdisconnect(var_0) {
  if(isDefined(var_0) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::droponplayerdeath();

    if(isDefined(level.lootchopper_initspawninfo)) {
      if(level.teamdata[var_0.team]["_encstr_9775086022BE1B413B8B"].size == 0)
        level.lootchopper_initspawninfo--;
    } else
      freefallfromplanestatemachine();
  }
}

ononeleftevent(var_0) {}

_id_126F1(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;
  scripts\mp\hud_message::showsplash("_encstr_A10E18B0837149E327D50FFDB37B0E1FA7CA1B50EA17DFF93FDA");

  if(!istrue(level.br_infils_disabled))
    self waittill("_encstr_8F9C0E528823754F286C8799F07117BD");
  else
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  wait 1;
  level thread freefallfromplanestatemachine();

  if(soundexists("_encstr_889D1D23F0EB89392CEBBA5B3AB1F598AD7D47D51DAF2B0BC9B9AFC616371A"))
    level _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_86141119687113E3E88795C9DA1AB69F7E2BE0", self);

  scripts\mp\hud_message::showsplash("_encstr_95A018FB95C01A0908F14B104B106F62A1FD873713F182CFE0D9");

  if(istrue(self.tutorial_usingparachute))
    level _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_872514BBE31FE24FD0FED25A53F88C29F90B37335B46", self, 1, 0, 4.5);

  if(istrue(level.checkforcorrectinstance) && istrue(level.br_prematchstarted))
    checkforlaststandwipe(self);
}

_id_1365D(var_0) {
  return istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
}

relic_oneclip_stock_adjustment_monitor() {}

_id_13C61() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    return;
  }
  for(;;) {
    wait 1;
    var_3 = scripts\mp\gamelogic::gettimeremaining() / 1000;

    if(istrue(level.convoy_handle_stuck_compromise)) {
      break;
    }

    if(var_3 <= 600 && !var_0) {
      var_0 = 1;
      setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 1);

      foreach(var_5 in level.players)
      var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(69, undefined, 10);

      continue;
    }

    if(var_3 <= 300 && !var_1) {
      var_1 = 1;
      setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 2);

      foreach(var_5 in level.players)
      var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(70, undefined, 10);

      continue;
    }

    if(var_3 <= 0 && !var_2) {
      var_2 = 1;

      if(level._id_13ABD) {
        return;
      }
      _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 0);
      level._id_11BD4 = 1;
      var_9 = play_quarry_intro_vo();

      if(isPlayer(var_9)) {
        var_9 _calloutmarkerping_handleluinotify_acknowledged::tryusenuke();
        wait 10;
        var_10 = play_train_speaker_vo_internal();
        level thread scripts\mp\gamelogic::endgame(var_10, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_9BE90A8A70BD8EB7A6FC2956"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B4720B5BE5E260CB0FAA883363"], 0, 1);
      } else {
        var_10 = play_train_speaker_vo_internal();
        level thread scripts\mp\gamelogic::endgame(var_10, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_9BE90A8A70BD8EB7A6FC2956"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B4720B5BE5E260CB0FAA883363"], 0, 1);
      }
    }
  }
}

freefallfromplanestatemachine() {
  level.lootchopper_initspawninfo = 0;

  foreach(var_1 in level.teamdata) {
    if(var_1["_encstr_9775086022BE1B413B8B"].size > 0)
      level.lootchopper_initspawninfo++;
  }
}

play_quarry_intro_vo() {
  var_0 = getarraykeys(level.teamdata);

  foreach(var_2 in var_0) {
    if(level.teamdata[var_2]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size > 0)
      return level.teamdata[var_2]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"][0];
  }

  return undefined;
}

play_train_speaker_vo_internal() {
  var_0 = getarraykeys(level.teamdata);

  foreach(var_2 in var_0) {
    if(level.teamdata[var_2]["_encstr_9775086022BE1B413B8B"].size == 0)
      return var_2;
  }

  return "_encstr_8D19048EA595";
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    return;
  }
  var_10 = getdvarint("_encstr_88F01B378D93BEC4B5B77DD6DB23ACD7B91C1B0BE6A1EB7796E632BDEE", 7500);

  if(isDefined(level._id_136F9) && level._id_136F9 + var_10 > gettime())
    scripts\mp\hud_message::showsplash("_encstr_8E440F89ADBE9DB40E377DD61693DACA23");

  if(isDefined(level._id_136F8) && level._id_136F8 + var_10 > gettime())
    scripts\mp\hud_message::showsplash("_encstr_877E16A6CD615B82FC4B7068BB3F5883FA74B0B6E3FA3D4B");

  if(isDefined(level._id_136F6) && level._id_136F6 + var_10 > gettime())
    scripts\mp\hud_message::showsplash("_encstr_9562189839EB6CC43306164B3932E4F6E0AFD2E6D8DBB55A3776");

  if(isDefined(level._id_136F7) && level._id_136F7 + var_10 > gettime())
    scripts\mp\hud_message::showsplash("_encstr_A2061886CAC7301F1D8BC89812F219A9DB7F9B0833DFD85B05C2");
}

dyn_door(var_0) {
  return 1;
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

  if(istrue(self.hasrespawntoken) && isDefined(level._id_13BCD))
    var_2 = level._id_13BCD;
  else if(level.start_persistent_turbulence > 0.0)
    var_2 = clamp(self.pers["_encstr_8E0607055DBFB3919A"] * level.start_persistent_turbulence, 0.0, level.start_pipe_room);
  else if(isDefined(level.checkpoint_objective_id))
    var_2 = level.checkpoint_objective_id;
  else
    var_2 = getdvarint("_encstr_B1581AAFC76BE0402A89C9626BF28026E3CF2731678330E1471E70FB", 20);

  var_3 = getdvarfloat("_encstr_92A9225776A20F086D77C1FA08D2430953F04EE75377238872837981A8DD78BF28A3725D", 10.0);

  if(var_2 < var_3)
    var_2 = var_3;

  if(level._id_12CB4 != 0)
    var_2 = 0;

  var_4 = getdvarfloat("_encstr_81282083D748495A1DAAE9AB4FEDD7D867CBB4AB1503212B8B456863E04133E90988", 5.0);
  scripts\engine\utility::ent_flag_init("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;

  if(istrue(self._id_13749) || var_0 == 1) {
    var_5 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();
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
      var_5 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();
      var_6 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);
      thread patchfix(0.0, 1);
      wait(var_4);
    } else {
      thread _id_1400C();
      var_10 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_AA48117347537FEF4F5072DBF877A72789ADE0", var_8);

      if(var_10 == "_encstr_AA48117347537FEF4F5072DBF877A72789ADE0") {
        var_5 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();
        var_6 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);
        thread patchfix(0.0, 1);
        wait(var_4);
      }
    }
  }

  self notify("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");
  var_5 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();
  var_6 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);

  if(istrue(self._id_13749)) {
    self._id_13749 = 0;

    if(var_0 > 1 && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
      scripts\mp\hud_message::showsplash("_encstr_82C214118A27EB28133AFFDF417B103D7F83C8DB9223");
  }

  if(validate_demeanor(self.team)) {
    return;
  }
  if(istrue(self.hasrespawntoken)) {
    thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_13DCB(4);
    self._id_13BCC = 1;
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();
  }

  if(validate_demeanor(self.team)) {
    return;
  }
  if(getdvarint("_encstr_A69D166B46DACF52A7B74FD7339D037227F39329CA20A30A", 1) == 0)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

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
  scripts\mp\damage::resetplayervariables();
}

_id_12691(var_0) {
  return 1;
}

_id_1400C() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");

  for(;;) {
    if(scripts\engine\utility::ent_flag("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03")) {
      var_0 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();
      var_1 = gettime();

      if(var_1 - self.trial_other_team >= getdvarfloat("_encstr_8E5722D07AD2EF19EF0FC8D60807634571D2C8B0226ECB719F176BC3FE7B2E29A7DA3090", 2.0) * 1000) {
        var_0 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE(1);
        var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
      }
    } else {
      var_0 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();
      var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
    }

    wait 1.0;
  }
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
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in();

  if(istrue(var_1))
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 6);
  else
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);

  wait 0.25;

  if(getdvarint("_encstr_AC7823E8FF0286ADB285F8F59A6A8F4B688F4098A7A17849DAEAE9F3F2232B30AEDFB028A3", 1) == 1) {
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
    var_3 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();
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

_id_1325E() {
  level.disable_super_in_turret.overheatreductionrate = relic_squadlink_vision_debuff();
  thread _id_11A9E();
}

relic_squadlink_vision_debuff() {
  var_0 = 2500;
  var_1 = level.br_level.br_mapcenter;
  var_2 = (0, randomfloatrange(0, 360), 0);
  var_3 = anglesToForward(var_2);
  var_4 = level.br_level.br_circleradii[0] * 2;
  var_5 = var_1 + var_3 * var_4;
  var_5 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::_id_1342E(var_1, var_5);
  var_6 = getEnt("_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = (var_5[0], var_5[1], var_6.origin[2]);
  var_8 = tracegroundpoint(var_7);
  var_5 = var_8 + (0, 0, var_0);
  return var_5;
}

_id_11A9E() {
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  level.disable_super_in_turret.objectiveiconid = var_0;

  if(var_0 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_0, "_encstr_AF5A081BBAC993AC73A3", level.disable_super_in_turret.overheatreductionrate, "_encstr_87A213BF1BF04ED1C79F6822F083BA1C9ED82F73F0");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0);
  }
}

_id_1325F() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = relic_mythic_should_ai_play_pain();
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquesttableindex("_encstr_B88C0D99330FDDA87B129B973CE9BA");

  foreach(var_3 in level.players) {
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_131AE(var_1);
    var_3 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivesetparameter(var_0);
  }
}

relic_mythic_should_ai_play_pain() {
  var_0 = getdvarint("_encstr_8B9E1277A0F39FE22D608FC0DD15EA6B9BD9D383", 5000);
  var_1 = getdvarint("_encstr_A15A168E5BF3D685DAB9789823F2BBE943FF93878F57D8D5", 2000);
  var_2 = getdvarint("_encstr_8B411B5FEF4E8FC583782D9BE3AB3962C480B033B1C8E3026B7DA05822", 200);

  if(var_1 > 0)
    var_0 = int(max(var_1, var_0 - level.disable_super_in_turret._id_11F3B * var_2));

  return var_0;
}

_id_13354(var_0) {
  var_1 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

  foreach(var_3 in var_1)
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.disable_super_in_turret.objectiveiconid, var_3);
}

spawn_carriables_from_prefabs_min_max(var_0) {
  var_1 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

  foreach(var_3 in var_1)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.disable_super_in_turret.objectiveiconid, var_3);
}

maxvehicledamagedivisor() {
  level.disable_super_in_turret._id_11F3B++;
  level.disable_super_in_turret.spawn_weapon setvalue(level.disable_super_in_turret._id_11F3B);
  level.disable_super_in_turret.spawn_weapon thread spawn_vindia_assault3();
  level.disable_super_in_turret.spawn_vo_playing thread spawn_vindia_assault3();
  var_0 = relic_healthpacks_think();
  level.disable_super_in_turret.spawn_trucks setvalue(var_0 * 100);

  foreach(var_3, var_2 in level.teamdata) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_3)) {
      continue;
    }
    if(isDefined(var_2["_encstr_AB580A05672AE35D5FFF50B8"]) && var_2["_encstr_AB580A05672AE35D5FFF50B8"] > 0)
      _id_14024(var_3);
  }

  var_4 = relic_mythic_should_ai_play_pain();

  foreach(var_6 in level.players) {
    if(!validate_demeanor(var_6.team)) {
      var_6 thread scripts\mp\hud_message::showsplash("_encstr_86511EB27B992FEB80D26B731B036117A8EB88AA96D801BD33D552E091631A9A");
      var_6 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::uiobjectivesetparameter(var_4);
    }
  }
}

_id_131CA(var_0) {
  level.teamdata[var_0]["_encstr_ACC10A017A892AE10F19CF53"] = 1;
}

validate_demeanor(var_0) {
  return istrue(level.teamdata[var_0]["_encstr_ACC10A017A892AE10F19CF53"]);
}

brendgame() {
  wait 1.5;
  handleendgamesplash();
  scripts\mp\gamelogic::endgame_regularmp(level.disable_super_in_turret.player_enemy_cooldown, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B2EB0EA2103F27CB58D9010EE7C3D72F"]);
}

handleendgamesplash() {
  foreach(var_1 in level.players) {
    if(!validate_demeanor(var_1.team))
      var_1 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 2);
  }
}

_id_1327A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 120;
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(!istrue(level.br_infils_disabled))
    level waittill("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B");

  waitframe();
  var_1 = init_relic_trex(&"_encstr_974725356F992279F8C3735FBB89703721F6FB4AE5A1FC61DEF7630BABA6A98F311C23C5BD39A2", undefined, "_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, -170);
  var_1.alpha = 1;
  var_2 = scripts\mp\hud_util::createservertimer("_encstr_8B1608EC43B8D647A113", 1.5);
  var_2 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, -150);
  var_3 = getdvarint("_encstr_82E21B331602D9C693D1EBD3135A805748F0BB917528272DC0A8971FE8", 180);

  if(var_3 > 0) {
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime() + int(var_3 * 1000));
    var_2 settimer(var_3);
    wait(var_3);
  }

  scripts\mp\flags::gameflagset("_encstr_9B4D0D4F2F58F937589BA94940E3AF");
  var_4 = getdvarint("_encstr_8F521E9B36E4BEC427D7ACE1A39C2CD8E8D78E2DB62BEEB0B4E8851B3A4BB359", 180);

  if(var_4 > 0) {
    var_1.label = &"_encstr_92FC258819374D05B1A93CC0BF4C48E89D0129BB1379E91EB0D071C3F97738AFDFA91169FBAC71";
    var_1 thread spawn_vindia_assault3();
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime() + int(var_4 * 1000));
    var_2 settimer(var_4);
    wait(var_4);
  }

  scripts\mp\flags::gameflagset("_encstr_B6BB1240173C186F4AF3D79FFF12B561CC6D0879");
  var_5 = getdvarint("_encstr_8BB51B5047BA2E059B611D9B83B34B11041FF0088745A109A352072E9B", 840);
  var_1.label = &"_encstr_AD871D550740750FD977437DD3386D6799283159211E0D7994DBD97841B515";
  var_1 thread spawn_vindia_assault3();
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime() + int(var_5 * 1000));
  var_2 settimer(var_5);
  var_6 = max(var_5 - var_0, 0);
  wait(var_6);
  var_7 = max(var_5 - var_6, 0);
  var_2.color = (1, 0, 0);
  var_2 thread spawn_vindia_assault3();
  thread heli_assault2_death_watcher(var_7);
  wait(var_7);
  var_2 destroy();
  thread brendgame();
}

heli_assault2_death_watcher(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(var_0 > 0) {
    var_1 = 0;
    var_2 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_0);

    if(var_0 > 60 && var_0 % 10 == 0 || var_0 <= 60 && var_0 > 30 && var_0 % 2 == 0 || var_0 <= 30)
      var_1 = 1;

    if(var_1) {
      foreach(var_4 in level.players)
      var_4 playlocalsound(var_2);
    }

    var_0 = var_0 - 1;
    wait 1;
  }
}

_id_13278() {
  var_0 = 155;
  var_1 = 15;
  var_2 = -3;
  var_3 = 3;

  if(level._id_13ABD) {
    var_4 = safehouse_regroup();
    var_5 = &"_encstr_96801BA44209957DAF9CE060D72901A0AF94086F804FFFBC67679301C5";
    var_6 = var_4;
  } else {
    var_4 = relic_healthpacks_think();
    var_5 = &"_encstr_AB901FE9CF512DA68FB1CDC78D8191BAD140FDB1C3AD577F039407A459B705E10B";
    var_6 = var_4 * 100;
  }

  level.disable_super_in_turret.spawn_tugofwar_tank = init_relic_trex(var_5, undefined, "_encstr_A5AD0568058CE3", "_encstr_A5C407E57585313DB1", var_3, var_0, undefined, undefined, 1);
  level.disable_super_in_turret.spawn_trucks = init_relic_trex(&"_encstr_85D922508F28831A690BEEEF33D1976E7DE6B929358E1381711FCBE47789AC2B117C8070", undefined, "_encstr_A5AD0568058CE3", "_encstr_A5C407E57585313DB1", 65 + var_3, var_0, undefined, undefined, 1);
  level.disable_super_in_turret.spawncrossbowbolt = init_relic_trex(&"_encstr_81FB244DA1F99643A03CF8500591578591F72DDA2709EFD7411611E8EF786BC7216FA45581F1", undefined, "_encstr_8253061E6BDF6331", "_encstr_A5C407E57585313DB1", 5 + var_2, var_0, undefined, undefined, 1);
  var_7 = 0;
  level.disable_super_in_turret.water_immunity_time = init_relic_trex(&"_encstr_9B2F21650FCE2B8AA759E870F16BB766441DF1E42D371742D981F0B8C96D79C3DD7B6C", var_7, "_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, var_0 + var_1, undefined, undefined, 1);

  foreach(var_9 in level.teamnamelist) {
    var_10 = init_relic_trex(&"_encstr_A3F01DCC611F7EC98119D5CF797D09801F796797D8B78D696A24FBA5645779", 0, "_encstr_8253061E6BDF6331", "_encstr_A5C407E57585313DB1", 70 + var_2, var_0, undefined, var_9, 1);
    var_11 = init_relic_trex(&"_encstr_8C2016156FF76802BE115B7779D4CD66078569DAF973305D", undefined, "_encstr_8253061E6BDF6331", "_encstr_A5C407E57585313DB1", -65 + var_2, var_0, undefined, var_9, 1);
    var_11 setvalue(1);
    var_10.placement = var_11;
    _id_131CE(var_9, var_10);
  }

  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(!istrue(level.br_infils_disabled))
    level waittill("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B");

  level.disable_super_in_turret.spawn_tugofwar_tank.alpha = 1;
  level.disable_super_in_turret.spawn_trucks.alpha = 1;
  level.disable_super_in_turret.spawncrossbowbolt.alpha = 1;
  level.disable_super_in_turret.water_immunity_time.alpha = 1;

  foreach(var_9 in level.teamnamelist) {
    var_10 = run_cleanup_funcs_for_unused_objectives(var_9);
    var_10.alpha = 1;
    var_10.placement.alpha = 1;
  }
}

_id_131CE(var_0, var_1) {
  level.teamdata[var_0]["_encstr_B16D0B64D35828B2D5B5F3CFB5"] = var_1;
  var_1.plundercount = 0;
  var_1._id_127B3 = 0;
}

run_cleanup_funcs_for_unused_objectives(var_0) {
  return level.teamdata[var_0]["_encstr_B16D0B64D35828B2D5B5F3CFB5"];
}

init_relic_trex(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_8))
    var_8 = 1.5;

  if(isDefined(var_7))
    var_10 = newteamhudelem(var_7);
  else if(isDefined(var_9))
    var_10 = newclienthudelem(var_9);
  else
    var_10 = newhudelem();

  var_10.elemtype = "_encstr_9779056EEA2583";
  var_10.font = "_encstr_8B1608EC43B8D647A113";
  var_10.fontscale = var_8;
  var_10.basefontscale = var_8;
  var_10.x = 0;
  var_10.y = 0;
  var_10.width = 0;
  var_10.height = int(level.fontheight * var_8);
  var_10.xoffset = 0;
  var_10.yoffset = 0;
  var_10.children = [];
  var_10 scripts\mp\hud_util::setparent(level.uiparent);
  var_10.hidden = 0;
  var_10.alpha = 0;
  var_10 scripts\mp\hud_util::setpoint(var_2, var_3, var_4, var_5);

  if(isDefined(var_0))
    var_10.label = var_0;

  if(isDefined(var_1))
    var_10 setvalue(var_1);

  if(isDefined(var_6))
    var_10.color = var_6;

  return var_10;
}

run_blima_exfil_sequence(var_0) {
  var_1 = 0;

  if(!level._id_12F10) {
    var_1 = var_1 + level.teamdata[var_0]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"];
    var_1 = var_1 + level.teamdata[var_0]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"];
  }

  var_1 = var_1 + level.teamdata[var_0]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"];
  return var_1;
}

rpg_shoot_at_trigs(var_0) {
  return level.teamdata[var_0]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"];
}

registerontimerupdate(var_0) {
  return level.teamdata[var_0]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"];
}

_id_134D8(var_0, var_1) {
  return var_0 > var_1;
}

setobjectivecallbacks(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  _calloutmarkerping_handleluinotify_added::_id_13133(var_0, var_2);
}

setoutputfunc(var_0, var_1) {
  var_2 = int(min(var_1, 131072));
  _calloutmarkerping_handleluinotify_added::_id_13134(var_0, var_2);
}

_id_127C6() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;
  var_1 = [];
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = level.spawn_convoy_and_move != 0;
  level._id_136F9 = undefined;
  level._id_136F8 = undefined;
  level._id_136F6 = undefined;
  level._id_136F7 = undefined;
  var_9 = gettime();
  var_10 = getdvarfloat("_encstr_93FC1B1B30CDF1B3B02A4F78C6D853C36FE89383E865B9D7EB157766D4", 30.0);

  for(;;) {
    waittillframeend;
    var_11 = (gettime() - var_9) / 1000;
    var_12 = level.fuckwithgravity && level.fuel_stability_event_init && level.fuel_stability_event_start;
    var_13 = safehouse_regroup();
    var_0 = var_0 + level.framedurationseconds;

    if(istrue(level._id_14086))
      var_14 = scripts\mp\flags::gameflag("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C");
    else
      var_14 = var_0 > level._id_12FB3;

    var_15 = level._id_13366 && var_14;
    var_16 = scripts\mp\gamescore::run_common_functions_stealth();
    var_17 = level._id_13ABD;
    var_18 = undefined;
    var_19 = undefined;
    var_20 = undefined;
    var_21 = [];
    var_22 = [];
    var_23 = [];
    var_24 = "_encstr_8BBA05185F8B99";
    var_25 = "_encstr_8BBA05185F8B99";
    var_26 = -1;
    var_27 = -1;

    foreach(var_29 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_29)) {
        continue;
      }
      var_30 = run_blima_exfil_sequence(var_29);
      var_31 = registerontimerupdate(var_29);
      var_32 = _id_14025(var_30, var_29, level.disable_super_in_turret.player_enemy_cooldown);
      var_33 = revive_or_disconnect_monitor(var_29);
      var_34 = var_16[var_29];

      if(var_30 > var_26) {
        if(var_26 > var_27) {
          var_27 = var_26;
          var_25 = var_24;
        }

        var_26 = var_30;
        var_24 = var_29;
      } else if(var_24 != "_encstr_8BBA05185F8B99") {
        if(var_30 > var_27) {
          var_27 = var_30;
          var_25 = var_29;
        }
      }

      var_35 = (var_30 - var_31) * 100;
      var_36 = var_30 * 100;
      var_37 = var_36 - var_35;

      if(var_35 < 0)
        var_35 = 0;

      if(var_36 >= var_13 * 0.9)
        var_18 = var_29;
      else if(var_36 >= var_13 * 0.75)
        var_19 = var_29;
      else if(var_36 >= var_13 * 0.5)
        var_20 = var_29;

      if(var_36 >= var_13 * level._id_127C1)
        thread scripts\mp\music_and_dialog::_id_12791();
      else if(var_36 >= var_13 * level._id_127C3)
        thread scripts\mp\music_and_dialog::_id_127A7();
      else if(var_36 >= var_13 * level._id_127C2)
        thread scripts\mp\music_and_dialog::_id_1278B();
      else if(var_36 >= var_13 * level._id_127C0)
        thread scripts\mp\music_and_dialog::_id_127A9();

      var_38 = scripts\mp\utility\teams::getfriendlyplayers(var_29, 0);

      foreach(var_40 in var_38) {
        var_34 = var_16[var_40.team];

        if(!var_6)
          var_34 = 155;

        var_40 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_966115DD134E2B022730DA9210CF7AEB618E554DBD303B", var_34);
        var_40 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B14816D596AF8939EB1CB1B0CBCA9C7D83BD9BB41D2DEDB9", var_34);
        var_40 setobjectivecallbacks("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", int(var_37 * 0.01));
        var_40 setobjectivecallbacks("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", int(var_35 * 0.01));
        var_22[var_40.guid] = var_40.plundercount;
        var_23[var_40.guid] = var_40;
      }

      if(var_15) {
        if(var_34 == 1)
          var_21[var_21.size] = var_29;
        else if(var_34 <= 5) {
          if(var_33 > 5)
            showsplashtoteam(var_29, "_encstr_B16909D5A7E12D6050F18B");
        } else if(var_34 <= 10) {
          if(var_33 > 10)
            showsplashtoteam(var_29, "_encstr_A35D0ACB9B907B57B0C66A12");
        }
      }

      if(var_36 >= var_13) {
        checkforovertime(var_29);

        if(var_17 && level.make_bomb_detonator_interact > 0 && !level.locale_defaults) {
          level thread _id_13DC8(var_29, level.teamdata[var_29]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] * 1000 >= var_13);
          continue;
        }

        if(var_17 && level.make_bomb_detonator_interact > 0 && level.locale_defaults) {
          level.time_before_shoot = var_29;
          continue;
        }

        if(level._id_13AB9 && !istrue(level.exfilactive)) {
          level.exfilactive = 1;
          level thread _id_13839(var_29);
          continue;
        }

        if(!level._id_13AB9 && var_17 && !level.locale_defaults)
          level thread searchradiusidealmin(var_29);
      }
    }

    var_43 = [];
    var_44 = [];

    if(level._id_11A2C == 1)
      var_43 = setteamplacement(game["_encstr_85920F9B354B5AC018902F3FD811A69307"], "_encstr_87070365F7");
    else if(level._id_11A2C == 2) {
      var_43[0] = var_24;
      var_44 = setteamplacement(var_22, "_encstr_9767056D0FBFA8");
    } else
      var_44 = setteamplacement(var_22, "_encstr_9767056D0FBFA8");

    level.disable_super_in_turret.player_enemy_cooldown = var_24;

    if(var_24 == "_encstr_8BBA05185F8B99") {
      var_1 = [];
      waitframe();
      continue;
    }

    if(var_25 != "_encstr_8BBA05185F8B99")
      setoutputfunc("_encstr_917B12ABB4BE3193BE8DC2DC1AF5CDB2D8B773C8", int(var_27));

    setoutputfunc("_encstr_9B6A128B6B69293AEF5657BB8901288DF98A1D6D", int(var_26));

    if(!var_8 && var_26 * 100 >= var_13 * level.spawn_convoy_and_move * 0.01) {
      setomnvar("_encstr_816E211599487D064F3BB248B44F1DC96B697BECB81097BA7E82E809F26C0131EBFC0B", 1);
      var_8 = 1;
    }

    if(!istrue(var_7) && istrue(level._id_14086)) {
      if(!var_2 && var_26 * 100 >= var_13 * level._id_11BE6 * 0.01) {
        var_2 = 1;
        level._id_136F9 = gettime();
        scripts\mp\flags::gameflagset("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C");

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
          _id_13371("_encstr_8E440F89ADBE9DB40E377DD61693DACA23");
      }

      if(!var_3 && (level._id_12F10 || var_26 * 100 >= var_13 * level._id_11BE5 * 0.01)) {
        var_3 = 1;
        level._id_136F8 = gettime();
        scripts\mp\flags::gameflagset("_encstr_811D12412EE567151F4DB94E919A9269AFA20A3F");

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
          _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B1F31060AB3C0B830A2B80958502CD709573", 0, undefined, undefined, undefined, "_encstr_9B0703896B");
      }

      if(!var_4 && var_26 * 100 >= var_13 * level._id_11BE3 * 0.01) {
        var_4 = 1;
        level._id_136F6 = gettime();
        level.br_level.c130_speedoverride = 3044;
        scripts\mp\flags::gameflagset("_encstr_B6CB14C26CE8B4D9C2472BF5C62CCDA1D72339DE1C37");
      }

      if(!var_5 && (istrue(level.convoy_handle_stuck_compromise) || var_26 * 100 >= var_13 * level._id_11BE4 * 0.01)) {
        var_5 = 1;

        if(getdvarint("_encstr_8BBF129653FBDEF165E3B1306AB1B3115BF19C05", 0)) {
          level._id_136F7 = gettime();
          scripts\mp\flags::gameflagset("_encstr_ACA314B97949B81C7ABB4D7716BB678B8FF1D18228CE");

          if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
            _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BE300E20D36DC8E9092EDB50C2D303F3", 0, undefined, undefined, undefined, "_encstr_9B0703896B");
        }
      }

      if(!var_6 && var_26 * 100 >= var_13 * level.spawn_default_player_spawns * 0.01)
        var_6 = 1;

      if(var_2 && var_3 && var_4 && var_5)
        var_7 = 1;
    }

    if(!var_15 || var_26 == 0) {
      waitframe();
      continue;
    }

    if(level._id_11A2C > 0) {
      if(level.lootchopper_modifyweapondamage || istrue(level._id_127D2)) {
        _id_13FF0(var_22, var_44, var_23, var_43);
        level._id_127D2 = 0;
      }
    } else if(level.lootchopper_modifyweapondamage || istrue(level._id_127D2)) {
      _id_13FF0(var_22, var_44, var_23);
      level._id_127D2 = 0;
    }

    foreach(var_29 in var_21) {
      if(!scripts\engine\utility::array_contains(var_1, var_29)) {
        if(istrue(level._id_13BE1[var_29])) {
          if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
            showsplashtoteam(var_29, "_encstr_88D7154CD6AF47DE1CEB3AAC2CB6BE9C95D90BB473B232");

          continue;
        }

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
          showsplashtoteam(var_29, "_encstr_B6830C8AADAF636D387FBCB51B88");

        level._id_13BE1[var_29] = 1;
      }
    }

    if(var_21.size > 0) {
      foreach(var_29 in var_1) {
        if(!scripts\engine\utility::array_contains(var_21, var_29))
          showsplashtoteam(var_29, "_encstr_856711FAB067CB6FC368B4DD1F08E7955FE823");
      }
    }

    var_1 = var_21;
    level._id_13BE0 = var_24;
    level._id_12884 = var_16;

    if(!var_12) {
      if(!level.fuel_stability_event_start && isDefined(var_18)) {
        level.fuel_stability_event_start = 1;

        if(var_11 < var_10)
          level _id_12892("_encstr_8E670B8EBA7153FF0B487D8E3B", var_11);

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            _id_13372(var_18, "_encstr_845914EEDF913CE8EEBBAC51E3B70F1AC3D06D1ADBEF");
            showsplashtoteam(var_18, "_encstr_92A81275718FEB50726B0BB180D5FF5127790B66");
            level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_AC1718DF7BD0E70FFDE1938A0E733AD190EB4223EF502C43263B", var_18, 1, undefined, "_encstr_9B0703896B");

            foreach(var_50 in level.teamnamelist) {
              if(var_50 != var_18)
                level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9AF618F10AAFA5881369E933AFA85A6003E2EBF971E768606D59", var_50, 1, undefined, "_encstr_9B0703896B");
            }
          }
        }
      } else if(!level.fuel_stability_event_init && isDefined(var_19)) {
        level.fuel_stability_event_init = 1;

        if(var_11 < var_10)
          level _id_12892("_encstr_A1F80B6F2D22074BA0E7D1B6BB", var_11);

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            _id_13372(var_19, "_encstr_8EA814FD55E1339BE31393FE4BBF5852938F2961C5D5");
            showsplashtoteam(var_19, "_encstr_931512D942EFBCC01AF391CF1C85A9DCEED9B363");
            level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_8FF018E23BE7A827BDF11345593F3D21D3519ADED98993CBE3A8", var_19, 1, undefined, "_encstr_9B0703896B");

            foreach(var_50 in level.teamnamelist) {
              if(var_50 != var_19)
                level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_91F1186FB7A8972211F8ABB221BF8BC7A32DE2E3C0F1F36FFBC0", var_50, 1, undefined, "_encstr_9B0703896B");
            }
          }
        }
      } else if(!level.fuckwithgravity && isDefined(var_20)) {
        level.fuckwithgravity = 1;

        if(var_11 < var_10)
          level _id_12892("_encstr_A27B0B8BDF89C9B59BC0775350", var_11);

        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
          if(!level.loadout_updateclassdefault_headlessgetweaponn) {
            _id_13372(var_20, "_encstr_8B5514E6B5A711337ADB500143D5A783F21F756B1537");
            showsplashtoteam(var_20, "_encstr_AF0712796D67088B6387B9E7B39AD82AA04903D3");
            level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_976C183B2CB52BB93A858EACD7A618AFC1B2E48DFA33969C378E", var_20, 1, undefined, "_encstr_9B0703896B");

            foreach(var_50 in level.teamnamelist) {
              if(var_50 != var_20)
                level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_A5921882810DFA5FD81163515F15322E6BF96B56AE7D78E3675E", var_50, 1, undefined, "_encstr_9B0703896B");
            }
          }
        }
      }
    }

    waitframe();
  }
}

checkforovertime(var_0) {
  if(!isDefined(level.checkformatchend))
    level.checkformatchend = [];

  if(scripts\engine\utility::array_contains(level.checkformatchend, var_0)) {
    return;
  }
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");
  var_2 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::init_subway_cars();
  var_2._id_1244D = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.plundercount) && var_4.plundercount > 0)
      var_4 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12618(var_4.plundercount, undefined, var_2);
  }

  level.checkformatchend[level.checkformatchend.size] = var_0;
}

_id_12192() {
  level thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_128A6(level._id_12192);
}

_id_12397() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(isDefined(level._id_12FB3))
    wait(level._id_12FB3);

  scripts\mp\flags::gameflagset("_encstr_BA261AC1365836CA5BB29B477DAE838CB08E2B9BD7B06363DBEE598C");
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

_id_13DC6(var_0) {
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  var_1 = getdvarfloat("_encstr_8438130AB9408FEA711FC756C98722D7D840051773", 10);
  var_2 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB";
  level.watchdvars[var_2].value = var_1;
  level.overridewatchdvars[var_2] = var_1;
}

_id_14024(var_0) {
  var_1 = run_cleanup_funcs_for_unused_objectives(var_0);
  var_2 = run_blima_exfil_sequence(var_0);
  var_3 = relic_healthpacks_think();

  if(var_2 >= var_3 && var_1.color != (0, 1, 0)) {
    var_1.color = (0, 1, 0);
    var_4 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

    foreach(var_6 in var_4)
    var_6 playlocalsound("_encstr_97F51BA09361593017A6FD659297D9E955E908104B8597A84BEF74E58A");
  }
}

makepickup(var_0, var_1) {
  var_2 = level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"];

  foreach(var_4 in var_2) {
    if(var_0 > 0) {
      if(isDefined(var_4.spawncorpsehider)) {
        var_5 = gettime() - var_4.spawncorpsehider;

        if(var_5 <= 6000) {
          break;
        }
      }

      var_4.spawncorpsehider = gettime();

      if(isalive(var_4))
        var_4 playlocalsound("_encstr_8722137EDE57EB9C5B88939F80F649739BE003B2CD");

      continue;
    }

    var_4.spawncorpsehider = undefined;
    var_4 stoplocalsound("_encstr_8722137EDE57EB9C5B88939F80F649739BE003B2CD");
  }
}

searchradiusidealmin(var_0) {
  if(istrue(level._id_13DC0)) {
    return;
  }
  if(!istrue(level._id_13DC0))
    level thread _id_12893();

  level._id_13DC0 = 1;
  level thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_9A6B10C7ED2A2710A0CB68F9595316B3974B"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A31511AAF10AE1C301C7CE39A84B318DA8F3A7"], 0, 1);
}

playerdropplunderondeath(var_0, var_1) {
  if(scripts\mp\utility\game::updatehistoryhud(self))
    return 1;

  if(istrue(level.gameended))
    return 1;

  if(istrue(self.unicornpoints)) {
    var_2 = self.plundercount;
    var_3 = self.plundercount;
    var_4 = 0;
  } else {
    if(isDefined(level._id_11C40) && self.plundercount < level._id_11C40) {
      var_4 = 0;
      var_2 = self.plundercount;
      var_3 = self.plundercount;
    } else {
      var_4 = int(self.plundercount * ((100 - level._id_122F5) * 0.01));
      var_2 = self.plundercount - var_4;
      var_3 = var_2;
    }

    if(istrue(level.convoy_handle_stuck_compromise)) {
      if(var_2 <= level.current_volume_allies && (!isDefined(var_1) || var_1 != self))
        var_2 = level.current_volume_allies;
    } else if(var_2 <= level.current_trigger && (!isDefined(var_1) || var_1 != self))
      var_2 = level.current_trigger;

    if(isDefined(level._id_11B6C)) {
      if(var_2 >= level._id_11B6C) {
        var_2 = level._id_11B6C;
        var_3 = var_2;
        var_4 = self.plundercount - level._id_11B6C;
      }
    }
  }

  self.plundercountondeath = var_4;

  if(var_3 > 0)
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1261E(var_3);

  if(var_2 >= level._id_127BC) {
    var_5 = 32;

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6())
      var_5 = 0;

    playFX(scripts\engine\utility::getfx("_encstr_B6930663D72D9813"), self.origin + (0, 0, var_5));
  }

  var_6 = var_2;

  if(istrue(self._id_14436))
    var_6 = int(var_2 * level.oic_loadouts);

  var_7 = var_6;

  if(istrue(level.convoy_handle_stuck_compromise) && (!isDefined(var_1) || self != var_1)) {
    var_7 = int(var_6 * level._id_12192);

    if(isDefined(level._id_11B6B) && var_7 > level._id_11B6B)
      var_7 = level._id_11B6B;
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && istrue(self.get_vehicle_ai_spawner))
    var_7 = int(var_7 + self.get_vehicle_ai_spawner);

  var_8 = dropplunderbyrarity(var_7, var_0);

  foreach(var_10 in var_8)
  var_10._id_11A40 = "_encstr_AA7C07466F9DA30713";

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
    level notify("_encstr_A1B3124D335EAD585A0E9B7792A040CE5C25CDBF", self, var_1, var_8);

  if(isDefined(var_1) && self == var_1 || !level.killcam)
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B6D41683986F56032E87D4C59011071AC7487BBAB8C94F93", var_3);
  else
    self._id_12801 = var_3;

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_id_13C44(self, "_encstr_AA7C07466F9DA30713", var_3 * -1);

  if(isDefined(level._id_11A32) && scripts\engine\utility::array_contains(level._id_11A32, self)) {
    var_5 = 64;

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6())
      var_5 = 0;

    playFX(scripts\engine\utility::getfx("_encstr_B6930663D72D9813"), self.origin + (0, 0, var_5));
  }

  return 1;
}

_id_12075() {
  if(isDefined(self._id_12801)) {
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B6D41683986F56032E87D4C59011071AC7487BBAB8C94F93", int(self._id_12801));
    self._id_12801 = undefined;
  }
}

dropplunderbyrarity(var_0, var_1) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  var_2 = [];
  var_3 = [];
  var_4 = 0;

  for(var_5 = level.br_plunder._id_12954.size - 1; var_5 >= 0; var_5--) {
    var_3[var_5] = int(var_0 / level.br_plunder._id_12954[var_5]);
    var_4 = var_4 + var_3[var_5];

    if(var_0 <= 0) {
      break;
    } else
      var_0 = var_0 - var_3[var_5] * level.br_plunder._id_12954[var_5];
  }

  for(var_6 = level.br_plunder._id_12954.size - 1; var_6 >= 0; var_6--) {
    if(!isDefined(var_3[var_6])) {
      continue;
    }
    for(var_7 = 0; var_7 < var_3[var_6]; var_7++) {
      var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_1, self.origin, self.angles, self);
      var_9 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(level.br_plunder.names[var_6], var_8, level.br_plunder._id_12954[var_6], 1);
      _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_11C91(level.br_plunder.names[var_6], 1);

      if(isDefined(var_9)) {
        var_2[var_2.size] = var_9;

        if(_encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::inplunderlivelobby())
          level.br_plunder_ents[level.br_plunder_ents.size] = var_9;
      }
    }
  }

  level.br_plunder._id_1278F = level.br_plunder._id_1278F + var_4;

  if(isDefined(var_0))
    level.br_plunder._id_127AC = level.br_plunder._id_127AC + var_0;

  level thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplundersounds(self.origin, var_2.size);
  return var_2;
}

relic_healthpacks_think() {
  if(level.lootchopper_oncrateuse > 0)
    var_0 = int(max(level.lootchopper_oncrateuse, level.lootchopper_isnearbyoccupiedspawns - level.disable_super_in_turret._id_11F3B * level.lootchopper_managespawns));

  return level.lootchopper_isnearbyoccupiedspawns;
}

safehouse_regroup() {
  return level.lootcontentsadjusteconomy_bottomtier;
}

_id_126C1(var_0) {
  if(self.plundercount < var_0)
    var_0 = self.plundercount;

  if(!isDefined(self._id_127BB))
    self._id_127BB = 0;

  self._id_127BB = self._id_127BB + var_0;
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(self.plundercount - var_0);
  return var_0;
}

_id_13AA8(var_0) {
  var_1 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

  foreach(var_3 in var_1)
  var_3._id_127BB = 0;
}

_id_13ABF(var_0) {
  var_1 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_127BB)) {
      var_3 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_3._id_127BB);
      var_3._id_127BB = 0;
      var_3 iprintlnbold("_encstr_977E28A20FE8390BC647A57BE6019CB299D59B19AC196101C61ABD0E8356E404371AB71D0219BDDD7371");
    }
  }
}

spawn_vindia_assault3() {
  self endon("_encstr_AD75063D571AE108");

  if(istrue(self._id_1293B)) {
    return;
  }
  var_0 = 0.5;
  var_1 = 4;
  self._id_1293B = 1;
  var_2 = self.fontscale;
  self changefontscaleovertime(var_0);
  self.fontscale = var_1;
  wait(var_0);
  self changefontscaleovertime(var_0);
  self.fontscale = var_2;
  self._id_1293B = undefined;
}

drophelicrate(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1 setModel("_encstr_BEDF1A22D8C15FE308ED6947C77068E3F8B0DA89C12F3F1C58336B4B");
  var_2 = var_0.origin;
  var_3 = (var_2[0], var_2[1], -12000);
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_0, var_4);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"];
  var_7 = var_2[2] - var_6[2];

  if(var_7 > 0) {
    var_8 = sqrt(2 * var_7 / 800);
    var_1 moveTo(var_6, var_8, var_8, 0);
    wait(var_8);
  }

  var_1.origin = var_6;
  playFX(scripts\engine\utility::getfx("_encstr_AA66152FE0E3D49367871116EE23AB9DEE5897F348391C"), var_6);
  var_1 cratedropplunder();
  var_1 delete();
}

cratedropplunder() {
  var_0 = relic_healthpacks_think();
  var_1 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplunderbyrarity(var_0, var_1);
}

frag_crate_spawn(var_0, var_1, var_2) {
  var_3 = var_0 * 0.0000157828;
  var_4 = 0.5 * var_2;
  var_5 = var_1;
  var_6 = -1 * var_3;
  var_7 = (-1 * var_5 + sqrt(var_5 * var_5 - 4 * var_4 * var_6)) / (2 * var_4);
  var_7 = var_7 * 3600;
  var_7 = var_7 + 1.5;
  return var_7;
}

frag_crate_player_at_max_ammo(var_0) {
  var_1 = frag_crate_spawn(30000, 100, 125);
  var_2 = frag_crate_spawn(var_0, 25.0, 31.25);
  var_3 = var_1 + var_2;
  return var_3;
}

sortplayerplunderscores(var_0, var_1) {
  var_2 = gettime() + int(var_1 * 1000);
  var_3 = level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];

  foreach(var_5 in var_3) {
    var_5 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8B061CAEA5EBC493EBC163ABE6462B93AF56E1D1932C8D8E7DCD8E2CD1AC", var_0);
    var_5 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_AB2C1FAB5C571836E1DBF9C38B7AF5C03F37720302D1D8ED1997C5F93723CBF0DD", var_2);
  }
}

smoke_door() {
  if(!isDefined(self.plunder)) {
    return;
  }
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_A52C1853F8633D14C5EE1ED282ABEB67BF28B1768017763DA737", self.team, 1);
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in self.plunder) {
    var_0 = var_0 + var_3.plundercount;

    if(var_3.player.team != self.team)
      var_1 = 1;
  }

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonatefx(self.plunder.size, var_0, "_encstr_9A8F0CB1A5E8471BB2EB894B39C8", var_1, self.endpoint);
  level.br_plunder.oscope_sign_think = level.br_plunder.oscope_sign_think + var_0;
  level.br_plunder.oscope_sign++;
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::num_players_in_safehouse();
}

heliusecleanup() {
  if(isDefined(self.usable)) {
    level.br_depots = scripts\engine\utility::array_remove(level.br_depots, self.usable);
    self.usable = undefined;
  }
}

helicleanupdepotonleaving(var_0) {
  self.usable endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::waittill_either("_encstr_BA2D081B2B58B32D37EC", "_encstr_AD75063D571AE108");
  heliusecleanup();
}

helicreateextractvfx(var_0) {
  self.vfxent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  self.vfxent setModel("_encstr_AAD412E6C69CEBB9B6DBD659D7CE9C9537583256");
  self.vfxent.angles = (0, 90, 90);
  self.vfxent playLoopSound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  self.vfxent setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_AB0703DBB9");
}

helicleanupextract(var_0) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(var_0) && isDefined(self.site))
    self.site setscriptablepartstate(self.site.type, self.site.audio_shf_kill_hangar_lights);
}

snapshot_crate_spawn() {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.vfxent)) {
    return;
  }
  wait 5;
  self.vfxent endon("_encstr_AD75063D571AE108");
  self.vfxent setscriptablepartstate("_encstr_BE7206A2D07B1322", "_encstr_8FA70A7917830EF0B09E4379");
  self.vfxent playSound("_encstr_88741E3B933094C7F831728A58C65BCF300FB4B13390D18B9B2B6BE283171387");
  wait 1;
  self.vfxent stoploopsound();
  wait 4.5;
  self.vfxent delete();
}

spawnheli(var_0, var_1, var_2, var_3) {
  var_4 = vectortoangles(var_2 - var_1);
  var_5 = 99;
  var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_1, var_4, "_encstr_A215169359C387A680CB7370EBD12AF3F5902A2AC33007DA", "_encstr_B2681F23E5D0519E0729F97F8B2D1BC8E008509FEFB8B208F0D4A3F34965024858");

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = var_2 * (1, 1, 0);
  var_6.damagecallback = ::callback_vehicledamage;
  var_6.speed = 50;
  var_6.accel = 99999;
  var_6.health = 1000;
  var_6.maxhealth = var_6.health;
  var_6.team = var_0.team;
  var_6.owner = var_0;
  var_6.defendloc = var_2;
  var_6.lifeid = 0;
  var_6.flaresreservecount = var_5;
  var_6.pathgoal = var_2;
  var_6._id_121FF = var_3;
  var_6.endpoint = var_7;
  var_6.select_mountain_two_spawners = var_4[1];
  var_6.vehiclename = "_encstr_9BEF16359B67FDA671371305E0BDB293E166C898324FA18B";
  var_6 setCanDamage(1);
  var_6 setmaxpitchroll(10, 25);
  var_6 vehicle_setspeed(var_6.speed, var_6.accel);
  var_6 sethoverparams(50, 100, 50);
  var_6 setturningability(0.05);
  var_6 setyawspeed(45, 25, 25, 0.5);
  var_6 setotherent(var_0);
  _id_13693(var_6);
  var_6 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  var_6 thread showquestcircletoplayer();
  var_6 thread handledestroydamage();
  var_6 thread smuggler_post_tele_kill();
  return var_6;
}

_id_13693(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_1 setModel("_encstr_A6A2244C39FA83D8AB738C56E4AF95E1D1E40B6C3A96DB37AF46AC1B2D6759272FBE27DB1C56");
  var_1 linkTo(var_0, "_encstr_849E106850A9BF81C398281878184EBA981B", (11, 20, 42), (0, 180, 0));
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_2 setModel("_encstr_866B2398E4BE071BAEE68C2B4EAFACE1A3C9588DD1B4EDE6BE23AC364B3B59C95ED798C2B3");
  var_2 linkTo(var_1, "_encstr_ADC40D049310B1A3D87B2A7121A033", (0, 0, 0), (0, 0, 0));
  var_0.rope = var_1;
  var_0.crate = var_2;
}

smuggler_post_tele_kill() {
  self endon("_encstr_A9B60A3495C6A5F5D9DEB92B");
  self endon("_encstr_8617083B2B9203E9606B");
  var_0 = self.owner;
  var_1 = self.team;
  self waittill("_encstr_AD75063D571AE108", var_2, var_3, var_4, var_5);
  _id_13ABF(var_1);
  smoke_enemy_think();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread smokesignal(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  snowballfighthint(var_2);
}

smoke_enemy_think() {
  if(isDefined(self.rope))
    self.rope delete();

  if(isDefined(self.crate))
    self.crate delete();
}

snowballfighthint(var_0) {
  var_1 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37") + (0, 0, 40);
  self radiusdamage(var_1, 256, 140, 70, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  playFX(scripts\engine\utility::getfx("_encstr_86A914B1963AA38DB2BE89D2938CAFAC3CC11BED32AC"), var_1, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_1, "_encstr_B1CA1AD495531E3FE4F288904ABA8F539F285FC0FA4B46074AFA9858");
  earthquake(0.4, 800, var_1, 0.7);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_1);
  physicsexplosionsphere(var_1, 500, 200, 1);
  self notify("_encstr_860808CB78E2984063BA");
  wait 0.35;
  level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13AC7("_encstr_B484233B55AFDAC9C8318BD08B502F326BA1F3AFDF3D0188E038C4510310575B50297F7F5D", self.owner, self.owner.team);
  helicleanupextract(1);
  smuggler_killed_early();
}

smuggler_killed_early() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

smokesignal(var_0) {
  self endon("_encstr_860808CB78E2984063BA");
  self notify("_encstr_A3AC0E689D58D2870256B720A28B8AA7");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self settargetyaw(self.angles[1] + var_0 * 2.5);
}

handledestroydamage() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8617083B2B9203E9606B");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if((var_9.basename == "_encstr_A63B18C2B0DA5A9B6E4BC6CAFA0E9CDE35CA36475A8D59FA6BE0" || var_9.basename == "_encstr_A29408E6D5D6CAAF5B1C") && var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" && var_0 >= self.health) {
      callback_vehicledamage(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
      helicleanupextract(1);
    }
  }
}

callback_vehicledamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner))
      var_1 = var_1.owner;
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["_encstr_8AEF05472BC2D6"] == self.team && !level.friendlyfire && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_5, self, var_4, var_2);
  var_1 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");

  if(self.health - var_2 <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

sol_3_4_pool() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_BA2D081B2B58B32D37EC");
  self.leaving = 1;
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  sortplayerplunderscores(3, self.player_weapon_fired_monitor);
  self waittill("_encstr_8B7205D9ED5958");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self._id_121FF, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self waittill("_encstr_8B7205D9ED5958");
  self stoploopsound();
  smoke_door();
  sortplayerplunderscores(0, 0);
  self notify("_encstr_A9B60A3495C6A5F5D9DEB92B");
  smuggler_killed_early();
}

helidescend(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = (var_2, var_3, var_1);
  self setvehgoalpos(var_4, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  self vehicle_setspeed(25.0, 31.25);
  thread snapplayertotoppos();
  thread snappointtooutofboundstriggertrace();
  self waittill("_encstr_8B7205D9ED5958");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

snapplayertotoppos() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8D7D06302FE5E159", var_0);

    if(isDefined(var_0) && var_0 nuke_vault_suicidebomber_internal())
      var_0 dodamage(var_0.health, self.origin, var_0, var_0, "_encstr_8D4E0A501FCB898912CB3FA3");
  }
}

snappointtooutofboundstriggertrace() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 70;
  var_1 = -80;
  var_2 = 150;
  var_3 = 25;
  var_4 = -100;

  for(;;) {
    var_5 = getentarrayinradius("_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56", "_encstr_AC110A7F14873B5B3D073009", self.origin, getdvarfloat("_encstr_88DE0C99B5F3EBF77031AD38034E", 400));

    if(var_5.size <= 1) {
      wait 0.5;
      continue;
    }

    var_6 = scripts\engine\trace::create_vehicle_contents();
    var_7 = anglesToForward(self.angles);
    var_8 = self.origin + var_7 * getdvarfloat("_encstr_8CDC077B631EE3FFA8", var_2) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("_encstr_86DC073AACE647FAD6", var_3) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    var_8 = self.origin + var_7 * getdvarfloat("_encstr_A2DC078ECACD3A7D89", var_4) + (0, 0, getdvarfloat("_encstr_BADC07F043CB4C1733", var_1));
    var_9 = scripts\engine\trace::sphere_trace(var_8, var_8 + (0, 0, 1), var_0, self, var_6);
    var_10 = var_9["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_10) && var_10 nuke_vault_suicidebomber_internal()) {
      var_10 dodamage(var_10.health, self.origin, var_10, var_10, "_encstr_8D4E0A501FCB898912CB3FA3");
      waitframe();
      continue;
    }

    waitframe();
  }
}

tracegroundheight(var_0) {
  var_1 = 125;
  var_2 = tracegroundpoint(var_0, 100, [self]);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

tracegroundpoint(var_0, var_1, var_2) {
  var_3 = -99999;
  var_4 = (var_0[0], var_0[1], var_3);
  var_5 = scripts\engine\trace::create_world_contents();
  var_6 = undefined;

  if(isDefined(var_1))
    var_6 = scripts\engine\trace::sphere_trace(var_0, var_4, var_1, var_2, var_5);
  else
    var_6 = scripts\engine\trace::ray_trace(var_0, var_4, var_2, var_5);

  return var_6["_encstr_BD260953AA97E3F014279D"];
}

heliwatchgameendleave() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread sol_3_4_pool();
}

test_trigger_spawn() {
  var_0 = [];

  if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    var_0[var_0.size] = (-33750, -36000, 155);
    var_0[var_0.size] = (-41550, -7950, 515);
    var_0[var_0.size] = (-37500, 15350, 1130);
    var_0[var_0.size] = (-31950, 52015, 2265);
    var_0[var_0.size] = (-18510, 64815, 1940);
    var_0[var_0.size] = (15565, 60050, 2680);
    var_0[var_0.size] = (44400, 39255, -50);
    var_0[var_0.size] = (59780, 13800, 555);
    var_0[var_0.size] = (61200, -8445, 30);
    var_0[var_0.size] = (59325, -38390, -210);
    var_0[var_0.size] = (8660, -36630, -640);
  } else {
    switch (level.mapname) {
      case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
        var_0[var_0.size] = (1500, 1500, 0);
        var_0[var_0.size] = (2500, 1500, 0);
        var_0[var_0.size] = (3500, 1500, 0);
        var_0[var_0.size] = (4500, 1500, 0);
        break;
      case "_encstr_82610A6B1CAFAD26D78EEAE8":
        break;
    }
  }

  level.outer = var_0;
  level.oscope_ampl_think = [];
  level thread _id_11D07();
}

init_relic_noks(var_0) {}

_id_11D07() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_1 in level.outer) {
    var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(var_2 != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_930B07BB1B6B3854FF", var_1, "_encstr_AD4813961BB7CDD7772CF238BD5A9B47BECCD88576");
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 0);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_2);
    }

    level thread _id_1364F(var_1);
  }

  for(;;) {
    foreach(var_1 in level.outer) {
      var_5 = scripts\mp\utility\player::getplayersinradius(var_1, 300);

      foreach(var_7 in var_5) {
        if(!scripts\engine\utility::array_contains(level.oscope_ampl_think, var_7) && !istrue(var_7.oscope_temp))
          var_7 open_spots_and_spawn_truck(var_1);
      }
    }

    foreach(var_7 in level.oscope_ampl_think) {
      if(distancesquared(var_7.origin, var_7.oscope_temps_think) > 90000) {
        var_7 open_selected_doors();
        continue;
      }

      var_7.outline_ent_index = var_7.outline_ent_index - level.framedurationseconds;

      if(var_7.outline_ent_index <= 0.0)
        var_7 open_sliding_door();
    }

    waitframe();
  }
}

_id_1364F(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1 + (0, 0, 3));
  var_2 setModel("_encstr_AAD412E6C69CEBB9B6DBD659D7CE9C9537583256");
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_9A4813360C3247EAEB70D12B58C765776878BADD95"), var_2, "_encstr_B2BF0708BA770F795B");
  var_2 playLoopSound("_encstr_A12F1108A33F918142D2F590AE7BC5D8574B68");
}

open_spots_and_spawn_truck(var_0) {
  self iprintlnbold("_encstr_92E7126DD8BC587FE20B33374BFEAEB041B2B369");
  level.oscope_ampl_think = scripts\engine\utility::array_add(level.oscope_ampl_think, self);
  self.oscope_temps_think = var_0;
  self.outline_ent_index = 10;
  thread _id_13355();
}

_id_13355() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AF8110B23CD12CC6D1B4B7730DB0DCC62B36");

  while(self.outline_ent_index > 0) {
    self iprintlnbold("_encstr_A7DF0F1F936433EFD363FB0544B0119579" + scripts\engine\math::round_float(self.outline_ent_index, 1));
    waitframe();
  }
}

open_selected_doors() {
  self notify("_encstr_AF8110B23CD12CC6D1B4B7730DB0DCC62B36");
  self iprintlnbold("_encstr_832515D91384A32BD2C363785DBE3789F6075008CF2C11");
  level.oscope_ampl_think = scripts\engine\utility::array_remove(level.oscope_ampl_think, self);
  self.oscope_temps_think = undefined;
  self.outline_ent_index = undefined;
}

open_sliding_door() {
  self iprintlnbold("_encstr_A774157FA8E30262BF45DC55A0E198D768505367A0B909");
  level.oscope_ampl_think = scripts\engine\utility::array_remove(level.oscope_ampl_think, self);
  self.oscope_temp = 1;
  kick(self getentitynumber(), "_encstr_8EF41B15A83127A121278957795B599BD739534125E1E96705F651A52B");
}

checkforlaststandwipe(var_0) {
  if(!isDefined(level.questinfo.teamsonquests) || scripts\engine\utility::array_contains(level.questinfo.teamsonquests, var_0.team)) {
    return;
  }
  var_1 = [];

  foreach(var_3 in level._id_140D9)
  var_1 = scripts\engine\utility::array_combine(var_1, getlootscriptablearrayinradius("_encstr_8C7A081EBE517AFF1B61" + var_3 + "_encstr_8D500871F35FC6F0DF89"));

  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_10, var_8 in var_1) {
    var_9 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_8.origin);

    if(var_9 <= 16777216 && var_9 >= 16384) {
      var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13A38(var_8);
      return;
    }

    if(!isDefined(var_5) || var_9 < var_6) {
      var_5 = var_8;
      var_6 = var_9;
    }
  }

  if(isDefined(var_5))
    var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13A38(var_5);
}

_id_11C50(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(var_4 == "_encstr_8B820C8D96391B1B59FAC1ACB2B6") {
      continue;
    }
    var_1[var_4] = var_3;
  }

  return var_1;
}

setupextractionsites(var_0) {
  var_1 = [];

  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595")
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  var_2 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

  foreach(var_4 in level.players) {
    if(var_1.size > 0 && scripts\engine\utility::array_contains(var_1, var_4)) {
      var_4 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", var_2);
      var_4 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 11);
      continue;
    }

    var_4 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", var_2);
    var_4 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 12);
  }
}

_id_14025(var_0, var_1, var_2) {
  var_3 = scripts\mp\gamescore::_getteamscore(var_1);
  var_4 = var_0 - var_3;

  if(var_4 != 0) {
    var_5 = scripts\engine\utility::ter_op(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid(), 1, undefined);
    level thread scripts\mp\gamescore::giveteamscoreforobjective(var_1, var_4, 0, undefined, var_5, var_2);
  }

  return var_4;
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

    if(var_1 > 0) {
      foreach(var_6 in level._id_11A29)
      var_6.mapcircle setmapcirclestyleindex(2);

      scripts\engine\utility::waittill_notify_or_timeout("_encstr_9A521389A527F73A8BA2DBFB3BBD5AB95A518A0B51", var_1);

      foreach(var_6 in level._id_11A29)
      var_6.mapcircle setmapcirclestyleindex(0);
    }
  }
}

_id_13FCB(var_0, var_1, var_2) {
  var_3 = gettime();
  var_2 = var_2 * 1000;
  var_4 = int(var_3 + var_2);
  var_5 = abs(var_0 - var_1);

  for(;;) {
    var_3 = gettime();
    var_6 = clamp(1.0 - (var_4 - var_3) / var_2, 0.0, 1.0);
    var_7 = scripts\engine\utility::ter_op(var_0 < var_1, var_5 * var_6 + var_0, var_0 - var_5 * var_6);
    setDvar("_encstr_A9E40A47091AF3DD71B1915D", var_7);

    if(var_6 == 1.0) {
      break;
    }

    waitframe();
  }
}

_id_13FF0(var_0, var_1, var_2, var_3) {
  level._id_11A36 = level._id_11A32;
  level._id_11A32 = [];

  if(level._id_11A31) {
    if(istrue(level.convoy_handle_stuck_compromise)) {
      level._id_11A27 = binoculars_checkpendingtimer();

      foreach(var_5 in level._id_11A29)
      var_5.mapcircle hide();
    }
  }

  if(level._id_11A2C == 1) {
    for(var_7 = 0; var_7 < level._id_11A27; var_7++) {
      var_8 = removeplatepouch(var_7, var_0, var_3);

      if(isDefined(var_8)) {
        level._id_11A32[level._id_11A32.size] = var_2[var_8];

        if(istrue(level.onsquadeliminatedplacement)) {
          if(isDefined(var_2[var_8].onstim))
            _id_12C17(var_2[var_8].onstim);
        }
      }
    }
  } else if(level._id_11A2C == 2) {
    var_8 = removeplatepouch(0, var_0, var_3);

    if(isDefined(var_8)) {
      level._id_11A32[0] = var_2[var_8];

      if(istrue(level.onsquadeliminatedplacement)) {
        if(isDefined(var_2[var_8].onstim))
          _id_12C17(var_2[var_8].onstim);
      }
    }

    foreach(var_10 in var_1) {
      var_11 = var_2[var_10];
      var_12 = var_0[var_10];

      if(var_12 == 0) {
        break;
      }

      if(scripts\engine\utility::array_contains(level._id_11A32, var_11)) {
        continue;
      }
      level._id_11A32[level._id_11A32.size] = var_11;

      if(istrue(level.onsquadeliminatedplacement)) {
        if(isDefined(var_11.onstim))
          _id_12C17(var_11.onstim);
      }

      if(level._id_11A32.size == level._id_11A27) {
        break;
      }
    }
  } else {
    foreach(var_11 in var_1) {
      var_12 = var_0[var_11];

      if(var_12 == 0) {
        break;
      }

      level._id_11A32[level._id_11A32.size] = var_2[var_11];

      if(istrue(level.onsquadeliminatedplacement)) {
        if(isDefined(var_2[var_11].onstim))
          _id_12C17(var_2[var_11].onstim);
      }

      if(level._id_11A32.size == level._id_11A27) {
        break;
      }
    }
  }

  foreach(var_11 in level._id_11A36) {
    if(isDefined(var_11) && !scripts\engine\utility::array_contains(level._id_11A32, var_11))
      _id_12C18(var_11);
  }

  for(var_7 = 0; var_7 < level._id_11A27; var_7++) {
    var_18 = level._id_11A29[var_7];

    if(isDefined(level._id_11A32[var_7])) {
      var_18.targetplayer = level._id_11A32[var_7];
      var_18.targetplayer._id_11A26 = var_18;
      var_19 = (var_18.targetplayer.origin[0], var_18.targetplayer.origin[1], level._id_11A2A);

      if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
        var_19 = var_19 + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 1000);

      var_18 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DAE(var_19);

      if(istrue(level._id_11A2B))
        _id_13FEF(var_18);

      var_20 = scripts\engine\utility::array_contains(level._id_11A32, var_18.targetplayer) && !scripts\engine\utility::array_contains(level._id_11A36, var_18.targetplayer);
      var_21 = scripts\mp\utility\teams::getenemyplayers(var_18.targetplayer.team, 0);

      foreach(var_11 in var_21)
      var_18 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(var_11);

      var_24 = scripts\mp\utility\teams::getfriendlyplayers(var_18.targetplayer.team, 0);

      foreach(var_11 in var_24)
      var_18 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(var_11);

      if(var_20)
        battle_tracks_updatebattletracks(var_18);

      continue;
    }

    var_18.targetplayer = undefined;

    foreach(var_11 in level.players)
    var_18 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(var_11);
  }
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
    if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
      var_1 scripts\mp\hud_message::showsplash("_encstr_867C1166B1B80771397007CAE0AAE1FA9B45D1");

    var_1 get_valid_seats();

    if(istrue(level.onsquadeliminatedplacement))
      var_1 thread watchforplayerdeath(var_0);
  }
}

_id_12C18(var_0) {
  if(isDefined(var_0.carriable_set_dropped))
    var_0 get_valid_starting_station_name_on_track();

  if(isDefined(var_0._id_11A26)) {
    foreach(var_2 in level.players)
    var_0._id_11A26 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(var_2);

    var_4 = var_0._id_11A26.guard_spawners;

    if(istrue(level.onsquadeliminatedplacement))
      battle_tracks_trystopdrivertogglethink(var_0, var_4);

    var_0._id_11A26.targetplayer = undefined;
    var_0._id_11A26 = undefined;
  }

  level._id_11A32 = scripts\engine\utility::array_remove(level._id_11A32, var_0);
}

watchforplayerdeath(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  var_1 = self._id_11A26.guard_spawners;
  _id_12C18(self);
  battle_tracks_trystopdrivertogglethink(self, var_1);
}

battle_tracks_trystopdrivertogglethink(var_0, var_1) {
  if(scripts\engine\utility::array_contains(level.onstun, var_0)) {
    return;
  }
  level.onstun = scripts\engine\utility::array_add(level.onstun, var_0);
  var_2 = undefined;

  foreach(var_4 in level.onstompeenemyprogressupdate) {
    if(!isDefined(var_4.targetplayer)) {
      var_2 = var_4;
      break;
    }
  }

  if(!isDefined(var_2)) {
    var_6 = undefined;

    foreach(var_4 in level.onstompeenemyprogressupdate) {
      if(!isDefined(var_6) || var_4.lastusedtime < var_6) {
        var_6 = var_4.lastusedtime;
        var_2 = var_4;
      }
    }

    var_2.targetplayer notify("_encstr_87F30C805BC5C1CEFF40058F3CC7");
  }

  var_2.targetplayer = var_0;
  var_2.lastusedtime = gettime();
  var_0.onstim = var_2;

  if(isDefined(var_1))
    var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DAE(var_1);
  else {
    var_9 = (var_2.targetplayer.origin[0], var_2.targetplayer.origin[1], level._id_11A2A);
    var_9 = var_9 + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 1000);
    var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DAE(var_9);
  }

  if(istrue(level._id_11A2B))
    _id_13FEF(var_2);

  var_10 = scripts\mp\utility\teams::getenemyplayers(var_2.targetplayer.team, 0);

  foreach(var_4 in var_10)
  var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(var_4);

  var_13 = scripts\mp\utility\teams::getfriendlyplayers(var_2.targetplayer.team, 0);

  foreach(var_4 in var_13)
  var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(var_4);

  thread _id_13FD5(var_2);
}

_id_13FD5(var_0) {
  var_0.targetplayer endon("_encstr_87F30C805BC5C1CEFF40058F3CC7");
  wait 5.0;
  _id_12C17(var_0);
}

_id_12C17(var_0) {
  var_1 = var_0.targetplayer;
  level.onstun = scripts\engine\utility::array_remove(level.onstun, var_0.targetplayer);
  var_0.targetplayer.onstim = undefined;
  var_0.targetplayer = undefined;

  foreach(var_3 in level.players)
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(var_3);

  var_1 notify("_encstr_87F30C805BC5C1CEFF40058F3CC7");
}

get_valid_seats() {
  var_0 = "_encstr_B8D22868E7E6655F7AAF63C39FB96086B7AAA10DA1FF81547A9B17EB78767D40AE815979C3B413EF016A";

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6())
    var_0 = "_encstr_B1C31E0B1BC69537B97B9C2FAFECF6D891AF1358E4FA4CC29D7D1CB12CCBB227";

  self attach(var_0, "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6", 1, 1);
  self.carriable_set_dropped = var_0;

  if(self tagexists("_encstr_91480BA9AF130B3B7DB1B2CC47"))
    playFXOnTag(level._effect["_encstr_A28815D9CC87FA9839BE6C58E61A13B2C28CB2934816CE"], self, "_encstr_91480BA9AF130B3B7DB1B2CC47");

  thread get_type_to_drop();
}

get_valid_starting_station_name_on_track() {
  if(isDefined(self) && isDefined(self.carriable_set_dropped)) {
    if(self tagexists("_encstr_91480BA9AF130B3B7DB1B2CC47"))
      killfxontag(level._effect["_encstr_A28815D9CC87FA9839BE6C58E61A13B2C28CB2934816CE"], self, "_encstr_91480BA9AF130B3B7DB1B2CC47");

    self detach(self.carriable_set_dropped, "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6");
    self.carriable_set_dropped = undefined;
  }

  self notify("_encstr_93801872A17B4039CCFBC8E0B229CD39BF7D887D05C3EF77F6C3");
}

get_type_to_drop() {
  self notify("_encstr_ADC61681B683B0C1AA87C1DBD3D115A8298E08FDDFF9088B");
  self endon("_encstr_ADC61681B683B0C1AA87C1DBD3D115A8298E08FDDFF9088B");
  self endon("_encstr_93801872A17B4039CCFBC8E0B229CD39BF7D887D05C3EF77F6C3");
  self waittill("_encstr_AD75063D571AE108");
  get_valid_starting_station_name_on_track();
}

get_unique_id() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_85F91D4F1673ECD1A709A00D624F2B3A8943D381E9E1DB11DCC53748F398EE");
  self endon("_encstr_85F91D4F1673ECD1A709A00D624F2B3A8943D381E9E1DB11DCC53748F398EE");
  self endon("_encstr_AD75063D571AE108");
  get_valid_starting_station_name_on_track();
  self waittill("_encstr_8B18148B28612902BDF0FB374353BAF409495733A87B");

  if(isDefined(self) && isDefined(level._id_11A32) && scripts\engine\utility::array_contains(level._id_11A32, self))
    get_valid_seats();
}

_id_121B6(var_0) {
  var_1 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_1 == "_encstr_B18D0B5281530117EDEAC82033" || var_1 == "_encstr_A1D0081CC297B1EDB08C" || var_1 == "_encstr_9286085A21B8034D3863") {
    return;
  }
  var_2 = 0;
  var_3 = 0;

  if(isDefined(self.plundercount))
    var_3 = var_3 + self.plundercount;

  if(isDefined(self.plunderbanked))
    var_3 = var_3 + self.plunderbanked;

  var_3 = int(var_3 / 10);

  if(var_3 > 4095)
    var_3 = 4095;

  var_2 = var_3;
  var_4 = 0;

  if(isDefined(self._id_11C4F))
    var_4 = var_4 + self._id_11C4F;

  if(var_4 > 15)
    var_4 = 15;

  var_2 = var_2 + (var_4 << 12);
  scripts\mp\utility\stats::setextrascore0(var_2);
}

_id_121B4() {
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self.plundercount))
    var_1 = var_1 + self.plundercount;

  if(isDefined(self.plunderbanked))
    var_1 = var_1 + self.plunderbanked;

  var_1 = int(var_1 / 10);

  if(var_1 > 4095)
    var_1 = 4095;

  var_0 = var_1;
  var_2 = 0;

  if(isDefined(self._id_11C4F))
    var_2 = var_2 + self._id_11C4F;

  if(var_2 > 15)
    var_2 = 15;

  var_0 = var_0 + (var_2 << 12);
  return var_0;
}

_id_12601() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level._id_11A32) && scripts\engine\utility::array_contains(level._id_11A32, self) && !isDefined(self.carriable_set_dropped)) {
    scripts\mp\hud_message::showsplash("_encstr_867C1166B1B80771397007CAE0AAE1FA9B45D1");
    get_valid_seats();
  }
}

_id_13FEF(var_0) {
  if(isDefined(var_0.targetplayer.plundercount))
    var_1 = var_0.targetplayer.plundercount;
  else
    var_1 = 0;

  var_1 = clamp(var_1, level._id_11A30, level._id_11A2E);
  var_2 = level._id_11A2E - level._id_11A30;
  var_3 = (var_1 - level._id_11A30) / var_2;
  var_4 = level._id_11A2F - level._id_11A2D;
  var_5 = level._id_11A2F - var_3 * var_4;
  var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(var_5);
}

binoculars_checkpendingtimer(var_0) {
  var_1 = 0;
  var_0 = scripts\mp\gamescore::run_common_functions_stealth();
  var_2 = safehouse_regroup();

  for(var_3 = 1; var_3 < level._id_11B62 + 1; var_3++) {
    foreach(var_5 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_5)) {
        continue;
      }
      if(var_0[var_5] != var_3) {
        continue;
      }
      var_6 = run_blima_exfil_sequence(var_5) * 100;

      if(var_6 >= var_2 || var_0[var_5] == 1)
        var_1++;
    }
  }

  if(var_1 > level._id_11B62)
    var_1 = level._id_11B62;

  return var_1;
}

longdeathtracker(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 20;
  var_1 = var_1 * 100;
  var_5 = var_0.plundercount * 100;
  var_6 = var_5 + var_1;
  var_7 = var_6;
  var_8 = var_5;
  var_9 = var_8 - var_6;
  var_10 = scripts\engine\utility::sign(var_9);
  var_11 = var_9 / 2.0;
  var_12 = int(var_11 * 2 * level.framedurationseconds);

  if(var_12 == 0) {
    return;
  }
  var_13 = init_relic_trex(&"_encstr_B8622085DF2992E9685383AF2B39C0A7F9E40BDDB5014AF1CD53C7FB01D8980FB96F", var_1, "_encstr_8253061E6BDF6331", "_encstr_A5C407E57585313DB1", var_2 + 46, var_3, undefined, undefined, 1.25, var_0);
  var_13.alpha = 1;
  var_14 = init_relic_trex(&"_encstr_A5A81F78A7AFBB22415386975B89BF46ABFC7111AE7F5B2BE121858A4FA9772375", undefined, "_encstr_8253061E6BDF6331", "_encstr_A5C407E57585313DB1", var_2, var_3 + var_4, undefined, undefined, 1.25, var_0);
  var_14.alpha = 1;
  var_15 = init_relic_trex(&"_encstr_A3F01DCC611F7EC98119D5CF797D09801F796797D8B78D696A24FBA5645779", var_6, "_encstr_A5AD0568058CE3", "_encstr_A5C407E57585313DB1", var_2 + 45, var_3 + var_4, undefined, undefined, 1.25, var_0);
  var_15.alpha = 1;
  wait 1.0;

  while(var_7 != var_8) {
    var_7 = var_7 + var_12;

    if(var_10 > 0 && var_7 > var_8 || var_10 < 0 && var_7 < var_8)
      var_7 = var_8;

    var_15 setvalue(var_7);
    wait(level.framedurationseconds);
  }

  wait 3.0;
  var_13 destroy();
  var_14 destroy();
  var_15 destroy();
}

ai_shooting_timer(var_0, var_1, var_2) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }
  var_3 = [];
  var_4 = [];

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_4 = int(min(var_1, var_0.size));
  }

  if(level._id_1323E) {
    var_5 = 0;

    if(level.binoculars_checkexpirationtimer > 0 && istrue(var_2)) {
      var_6 = 0;

      for(var_7 = 0; var_7 < var_4; var_7++) {
        if(var_6 > level._id_121BB.size - 1)
          var_6 = 0;

        var_8 = level._id_121BB[var_6];

        foreach(var_10 in var_0) {
          if(_id_127DD(var_10.origin, var_8, level._id_127DE)) {
            var_3[var_3.size] = var_10;
            var_0 = scripts\engine\utility::array_remove(var_0, var_10);
            break;
          }
        }

        var_6++;
      }
    } else {
      foreach(var_10 in var_0) {
        var_5 = 0;

        foreach(var_14 in level._id_12950) {
          var_15 = scripts\engine\utility::distance_2d_squared(var_14, var_10.origin);

          if(var_5 == 0 || var_15 < var_5) {
            var_5 = var_15;
            var_10.heliatcapacitycallback = var_14;
          }
        }
      }

      var_6 = 0;

      for(var_7 = 0; var_7 < var_4; var_7++) {
        if(var_6 > level._id_12950.size - 1)
          var_6 = 0;

        var_8 = level._id_12950[var_6];

        foreach(var_10 in var_0) {
          if(isDefined(var_10.heliatcapacitycallback) && var_10.heliatcapacitycallback == var_8) {
            var_3[var_3.size] = var_10;
            var_0 = scripts\engine\utility::array_remove(var_0, var_10);
            break;
          }
        }

        var_6++;
      }
    }
  } else if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_4 = int(min(var_1, var_0.size));

    for(var_7 = 0; var_7 < var_4; var_7++)
      var_3[var_3.size] = var_0[var_7];
  }

  if(istrue(level.spawn_boss_wave_suicidebombers)) {
    foreach(var_21 in var_0) {
      if(!scripts\engine\utility::array_contains(var_3, var_21))
        var_21 setscriptablepartstate(var_21.type, "_encstr_95DF070DD22319CA9B");
    }
  }

  return var_3;
}

_id_127DD(var_0, var_1, var_2) {
  var_3 = var_1[0] - var_2;
  var_4 = var_1[0] + var_2;
  var_5 = var_1[1] - var_2;
  var_6 = var_1[1] + var_2;
  return var_0[0] >= var_3 && var_0[0] <= var_4 && var_0[1] >= var_5 && var_0[1] <= var_6;
}

ai_weapons_free(var_0, var_1) {
  if(var_0.size == 0 || var_1 == 0) {
    return;
  }
  var_2 = undefined;

  if(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!scripts\engine\utility::array_contains(level.br_plunder_sites, var_0[var_3])) {
        var_2 = var_0[var_3];
        break;
      }
    }
  }

  return var_2;
}

play_tape_machine_animations(var_0) {
  var_1 = ai_weapons_free(_encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::register_vfx(), level._id_11B6D);
  var_1.disabled = undefined;
  var_1.snapshot_crate_player_at_max_ammo = undefined;
  var_2 = scripts\engine\utility::ter_op(level._id_13368 && !level._id_13363, var_1.audio_jugg_spawn, var_1.audio_shf_kill_hangar_lights);
  var_1 setscriptablepartstate(var_1.type, var_2);

  if(level._id_13368 && level._id_13363) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_0.locale.objectiveiconid);
    var_0.locale.objectiveiconid = -1;
    var_3 = spawnStruct();
    var_3 init_tape_machine_animations("_encstr_8C0B1A0DAB81254328C1B369081F7B9DF83D855FC338EDF3F059CB72", "_encstr_AF5A081BBAC993AC73A3", var_1.origin + (0, 0, 200));
    var_1.locale = var_3;
  }

  level.br_plunder_sites = scripts\engine\utility::array_remove(level.br_plunder_sites, var_0);
  level.br_plunder_sites = scripts\engine\utility::array_add(level.br_plunder_sites, var_1);
}

_id_1386C() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  waitframe();

  foreach(var_1 in level.br_plunder_sites) {
    var_1.disabled = undefined;
    var_2 = scripts\engine\utility::ter_op(level._id_13368 && !level._id_13363, var_1.audio_jugg_spawn, var_1.audio_shf_kill_hangar_lights);
    var_1 setscriptablepartstate(var_1.type, var_2);
    var_1 thread _id_12E1E();

    if(level._id_13368 && level._id_13363)
      var_1.locale thread _id_13B86();
  }

  level thread _id_12E0E();
}

_id_12E1E() {
  wait(level._id_13B85);
  self.disabled = 1;
  self.snapshot_crate_player_at_max_ammo = 1;
  self setscriptablepartstate(self.type, self.load_relics_from_playlistdvars);
}

_id_12E0E() {
  wait(level._id_13B85 + 1);
  level.br_plunder_sites = ai_shooting_timer(_encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::register_vfx(), level._id_11B6D);

  if(level._id_13368 && level._id_13363)
    level thread init_relic_team_proximity();

  level thread _id_1386C();
}

init_relic_team_proximity() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_1 in level.br_plunder_sites) {
    var_2 = spawnStruct();
    var_2 init_tape_machine_animations("_encstr_8C0B1A0DAB81254328C1B369081F7B9DF83D855FC338EDF3F059CB72", "_encstr_AF5A081BBAC993AC73A3", var_1.origin + (0, 0, 200));
    var_1.locale = var_2;
  }
}

_id_13B86() {
  var_0 = level._id_13B85;
  var_1 = level.framedurationseconds;
  var_2 = var_1 * 1000;
  var_3 = var_0 * 1000;
  var_4 = var_3 - var_2;
  var_5 = gettime() + var_3;

  while(gettime() < var_5) {
    var_6 = var_4 / var_3;
    scripts\mp\objidpoolmanager::objective_show_progress(self.objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objectiveiconid, var_6);
    var_4 = max(var_4 - var_2, 1);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  self.objectiveiconid = -1;
}

init_tape_machine_animations(var_0, var_1, var_2) {
  self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(self.objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(self.objectiveiconid, var_1, (0, 0, 0), var_0);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objectiveiconid, 1);
    objective_showtoplayersinmask(self.objectiveiconid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.objectiveiconid, 1);

    if(isDefined(var_2))
      _id_11DB0(var_2);
  } else {}
}

_id_11DB0(var_0) {
  scripts\mp\objidpoolmanager::update_objective_position(self.objectiveiconid, var_0);
}

_id_1336C(var_0) {
  objective_addclienttomask(self.objectiveiconid, var_0);
}

_id_1336B(var_0) {
  objective_addalltomask(var_0);
}

spawn_downed_friendly(var_0) {
  objective_removeclientfrommask(self.objectiveiconid, var_0);
}

lastdropedtime() {
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
}

_id_13839(var_0) {
  level _id_1314A();
  level thread _id_13353(var_0);

  if(level._id_13ABC)
    level thread _id_13881(var_0);

  if(level._id_13ABA)
    level thread _id_12C13();

  level thread _id_13847();
  level thread _id_11EF5(var_0);
}

_id_1314A() {
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  var_0 = getdvarfloat("_encstr_A95A14DCB14EEBC4D67BD7598799D28DF5D14B6BB239", 180);
  var_1 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB";
  level.watchdvars[var_1].value = var_0;
  level.overridewatchdvars[var_1] = var_0;
}

_id_13353(var_0) {
  foreach(var_2 in level.teamnamelist)
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_847A1AB88B4DF8F97ABAB0A510431DC18303392037E1D3A36323953D", var_2);

  foreach(var_5 in level.players) {
    var_5 thread scripts\mp\hud_message::showsplash("_encstr_A2401AC62EB2A9801DB3A140FF2FDEE39B974BD909BB6B68FEEFF0D0");
    var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(71, undefined, 20);
  }
}

_id_13881(var_0) {
  level.radarmode[var_0] = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
  level.activeuavs[var_0] = 1;
  level.activeadvanceduavs[var_0] = 0;
  scripts\cp_mp\killstreaks\uav::_setteamradarstrength(var_0, 4);
}

_id_12C13() {
  level._id_11A27 = 1;

  if(getdvarint("_encstr_837B25932770317B59BA09C2E0A0F3F95883390CB3184967FF51E24B8990E7ED6951B993C7984A", 0) == 1) {
    if(getdvarfloat("_encstr_8295247AC930FFDA2165F733A7D8230728917607A168B783876117ABABE8BA7E50792A0B5930", 15.0) > 0.0)
      level thread _id_13FF1();
  }
}

_id_13847() {
  foreach(var_1 in level.br_plunder_sites) {
    var_1 setscriptablepartstate(var_1.type, "_encstr_8C8F065F254DC395");
    var_2 = getgroundposition(var_1.origin, 1) + (0, 0, 2);
    var_3 = level.players[0];

    for(var_4 = 0; var_4 < 200; var_4++) {
      var_3 = play_quarry_intro_vo();

      if(isPlayer(var_3)) {
        break;
      }
    }

    var_2 = getgroundposition(var_1.origin, 1) + (0, 0, 2);
    var_5 = var_3 _id_126A8(var_2, var_1);

    if(isDefined(var_5)) {
      var_5.site = var_1;
      var_1.heli = var_5;
      var_5 helicreateextractvfx(var_2);
      var_5 thread outro_main();
    }
  }
}

_id_126A8(var_0, var_1) {
  var_2 = var_0;
  var_3 = var_2 + (0, 0, 2500);
  var_4 = play_skit_and_watch_for_endons(var_3, var_1);
  var_5 = (0, var_4, 0);

  if(getdvarint("_encstr_8DE71F533BD391114877E7786B762FA2EB096CF112FF296368D8854A390912A28F", 1) == 1) {
    var_6 = -100;
    var_7 = 60;
    var_8 = anglesToForward(var_5);
    var_9 = anglestoright(var_5);
    var_2 = var_2 + var_8 * var_6 + var_9 * var_7;
  }

  var_10 = var_3 + -1 * anglesToForward(var_5) * 30000;
  var_11 = var_3 + anglesToForward(var_5) * 30000;
  var_12 = spawnheli(self, var_10, var_3, var_11);
  return var_12;
}

outro_main() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.select_mountain_two_spawners);
  var_0 = _id_13C30(self.pathgoal);
  var_1 = self.pathgoal[2] - var_0;
  self.player_weapon_fired_monitor = frag_crate_player_at_max_ammo(var_1);
  sortplayerplunderscores(1, self.player_weapon_fired_monitor);
  self waittill("_encstr_8B7205D9ED5958");

  foreach(var_3 in level.players)
  var_3 scripts\mp\utility\lower_message::setlowermessageomnvar(72, undefined, 20);

  thread heliwatchgameendleave();
  thread snapshot_crate_spawn();
  helidescend(self.endpoint, var_0);

  foreach(var_6 in level.teamnamelist)
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_83EA1FF3E995CA4C0853C1570A5882F26621C72749307310607BC95EA340D1FBCD", var_6, 1);

  soldier_agent_lwfn0();
  helicleanupextract();

  foreach(var_6 in level.teamnamelist)
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_821C1E17357BF5A945D3E920E38CA323E2DB18168C7291532DFBE1607FB17B53", var_6, 1);

  thread sol_3_4_pool();
}

soldier_agent_lwfn0() {
  self.isdepot = 1;
  self.usable = self.crate;
  var_0 = self.usable;
  var_0 makeusable();
  var_0 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_0 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_0 sethintrequiresholding(1);
  var_0 setuserange(230);
  var_0 setHintString(&"_encstr_AC8E189BE72F6E9919992B39518F10C1BB9C87FF08419FD1697A");
  var_1 = level.br_depots.size;
  level.br_depots[var_1] = var_0;

  foreach(var_3 in level.players) {
    if(!isDefined(var_3))
      continue;
  }

  thread helicleanupdepotonleaving();
  thread snowballfight(var_0);
  sortplayerplunderscores(2, 300);
  wait 300;
  self.isdepot = 0;
  heliusecleanup();
}

snowballfight(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    var_1 scripts\mp\hud_message::showsplash("_encstr_9A9A165F635DD58FB3F577F3500D6A188F38CDE831E3628B");
    var_1 playerhide();
    var_1 vehiclepinonminimap(0);
    var_1 allowmovement(0);
    var_1 allowfire(0);
    var_1 disableoffhandprimaryweapons(0);
    var_1 disableoffhandsecondaryweapons(0);
    var_1 disableweapons(0);
    var_1 disableweaponswitch(0);
    var_1 setcamerathirdperson(1);
    var_1 allowcrouch(0);
    var_1 allowmelee(0);
    var_1 allowjump(0);
    var_1 allowprone(0);
    var_1 scripts\common\utility::allow_killstreaks(0);
    var_1 scripts\common\utility::allow_supers(0);
    var_1._id_12E54 = 1;
    var_0 disableplayeruse(var_1);
  }
}

showquestcircletoplayer() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_8617083B2B9203E9606B");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    self.health = 99999;
  }
}

_id_13C30(var_0) {
  var_1 = 256;
  var_2 = tracegroundpoint(var_0, 100, [self]);
  var_3 = var_2[2];
  var_4 = var_3 + var_1;
  return var_4;
}

play_skit_and_watch_for_endons(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.player_respawn))
    return var_1.player_respawn;

  var_2 = 10;
  var_3 = scripts\engine\trace::create_world_contents();

  for(var_4 = 0; var_4 < 360; var_4 = var_4 + var_2) {
    var_5 = (0, var_4, 0);
    var_6 = var_0 + -1 * anglesToForward(var_5) * 30000;
    var_7 = var_0 + anglesToForward(var_5) * 30000;
    var_8 = scripts\engine\trace::sphere_trace(var_0, var_7, 100, undefined, var_3, 1);

    if(var_8["_encstr_A53009A25003666B9818C6"] == 1) {
      if(isDefined(var_1))
        var_1.player_respawn = var_4;

      return var_4;
    }

    if(var_4 % 3 == 0)
      waitframe();
  }

  var_4 = randomfloat(360);

  if(isDefined(var_1))
    var_1.player_respawn = var_4;

  return var_4;
}

_id_11EF5(var_0) {
  level notify("_encstr_A91D1B1BA522A00BCFFA68110233CC897B3193F35AC198D55FE323393A");
  level endon("_encstr_BA3D177DBD438758BFD012AAA80517BF3B9EF1EFC4C99B67E1");
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 0, 9, level._id_13ABB);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 1);
  var_1 = gettime();
  var_2 = level._id_13ABB * 1000 + var_1;
  setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", level._id_13ABB * 1000 + var_1);

  for(;;) {
    waitframe();

    if(gettime() > var_2) {
      break;
    }
  }

  level thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_9A6B10C7ED2A2710A0CB68F9595316B3974B"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A31511AAF10AE1C301C7CE39A84B318DA8F3A7"], 0, 1);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 0);
}

_id_13DC8(var_0, var_1, var_2) {
  if(istrue(level.convoy_handle_stuck_compromise)) {
    if(istrue(level.chopperexif_fx_init) && istrue(var_1))
      level thread convoy_anim_sequence();

    return;
  }

  level.convoy_handle_stuck_compromise = 1;
  level notify("_encstr_88B018F8678EB113121977882D5A4B58EBEFF8A1DB5109C90A3F");
  thread scripts\mp\music_and_dialog::_id_12792();
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::generic_waittill_button_press();
  level thread _id_12192();
  var_3 = scripts\engine\utility::ter_op(level._id_12192 >= 1, "_encstr_928B1C2557115058956A7328557DD91DCA9F9DB1EF792EB8BBC41EC07B2D", "_encstr_ACD81D26B57DED672B931D96D656F523F65D4C6359EB8DC2B90D7DC1ACC91B");

  if(isDefined(var_0) && (level.locale_defaults || !level.loadout_updatebrammo)) {
    level.time_before_shoot = var_0;
    _id_13372(var_0, "_encstr_A6CC17CA0DB90863A2C00C4833EFC08B8B8F6EAB688B68CF53");
    showsplashtoteam(var_0, "_encstr_934C1531D6BE7BECB2398E5A6B2BF5DCA3164EE8EBD5E6");
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9B04164BF9D1DFAEED29D3B3E37C5801ED0335EB7DE8CF2B", var_0);

    foreach(var_5 in level.teamnamelist) {
      if(var_5 != var_0)
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_88791C89B6BE9D0BB62B6E4716D1CA7D7B67AC933AA56BB2F5CAE695B55E", var_5);
    }
  } else
    level.time_before_shoot = remove_padding_damage();

  if(!isDefined(var_2)) {
    scripts\mp\gamelogic::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    var_7 = scripts\engine\utility::ter_op(level.loadout_updatebrammo || istrue(var_2), 7, 12);
    var_8 = "_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_8E6F0BE85BD29B9154974068CB";
    level.watchdvars[var_8].value = var_7;
    level.overridewatchdvars[var_8] = var_7;

    if(!level.loadout_updatebrammo)
      wait 5;

    _id_13371(var_3);
    wait 5;
    level.ontimelimitgraceperiod = level.make_bomb_detonator_interact;
    level.currenttimelimitdelay = 0.0;
    level.canprocessot = 1;
    level notify("_encstr_9A521389A527F73A8BA2DBFB3BBD5AB95A518A0B51");
  } else {
    level.ontimelimitgraceperiod = level.make_bomb_detonator_interact;
    level.currenttimelimitdelay = 0.0;
    level.canprocessot = 1;
    level notify("_encstr_9A521389A527F73A8BA2DBFB3BBD5AB95A518A0B51");
    level.playerparachutedetachresetomnvars = 1;
    level.playerplaygestureweaponanim = 1;
    _id_13371(var_3);
    wait 5;
  }

  level.playerparachutedetachresetomnvars = undefined;
  scripts\mp\flags::gameflagwait("_encstr_A9071177F53082F3938062C92B75DFFAD04BF4");
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 7);

  if(!isDefined(var_2)) {
    var_9 = gettime() + int(level.make_bomb_detonator_interact * 1000);
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", var_9);
  }

  wait(int(max(level.make_bomb_detonator_interact - 60, 0)));
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 8);
}

remove_padding_damage() {
  var_0 = "_encstr_B40101";

  foreach(var_2 in level.teamnamelist) {
    var_3 = game["_encstr_85920F9B354B5AC018902F3FD811A69307"][var_2];

    if(var_3 == 1) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

ontimelimit() {
  if(level._id_13ABD && level.make_bomb_detonator_interact > 0 && !istrue(level.convoy_handle_stuck_compromise)) {
    if(!isDefined(level.time_before_shoot))
      level.time_before_shoot = remove_padding_damage();

    level thread _id_13DC8(level.time_before_shoot, level.teamdata[level.time_before_shoot]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"] * 1000 >= safehouse_regroup());
    level waittill("_encstr_9A521389A527F73A8BA2DBFB3BBD5AB95A518A0B51");

    while(level.currenttimelimitdelay < level.ontimelimitgraceperiod)
      wait(level.framedurationseconds);
  }

  level thread convoy_anim_sequence();
}

convoy_anim_sequence() {
  if(istrue(level.gameended)) {
    return;
  }
  level thread setup_heli_starts_deep();
  level thread scripts\mp\gamelogic::endgame(level.disable_super_in_turret.player_enemy_cooldown, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_9A6B10C7ED2A2710A0CB68F9595316B3974B"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A31511AAF10AE1C301C7CE39A84B318DA8F3A7"], 0, 1);
}

setup_heli_starts_deep() {
  var_0 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

  foreach(var_2 in level.players)
  var_2 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", var_0);
}

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

numextractions() {
  level waittill("_encstr_82AA118770E83DA1F98B93B7E1883A7F705B3A");
  waitframe();
  var_0 = getdvarfloat("_encstr_9A751DB9D8C9D789B67B7D56F6DABE1AB263197D1B2C6E86BE373658C62C39", 1.0);
  var_1 = getdvarfloat("_encstr_BA741F08B7FE7E28A2F7F11887C2875B991D33519507DEFEAB2901F79876E43F28", 1.0);
  var_2 = getdvarint("_encstr_91212142880AD60D4FD879150A79A120CD630CDB195D81934735467843C99E37F0FF1E", 10000);
  var_3 = getdvarint("_encstr_91021F1BB71B4F92FD2857C54A10C7ADCBC7704F5717187807774360AAD552257F", 7500);
  var_4 = getdvarint("_encstr_9AE11897DED517E85AA02E78E78811BB950BEEDFA71D32F8E323", 5000);

  foreach(var_6 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_6)) {
      continue;
    }
    var_7 = run_blima_exfil_sequence(var_6) * 100;
    var_8 = var_7 >= safehouse_regroup();
    var_9 = game["_encstr_85920F9B354B5AC018902F3FD811A69307"][var_6];
    var_10 = 0;

    if(var_8)
      var_10 = var_3;
    else if(var_9 <= 10)
      var_10 = var_4;

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

      var_13 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 3, var_19);
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

  if(0)
    mp_m_stack_patch();
}

_id_13DB9() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 thread _id_12753(var_2, registerquestcategorytablevalues(var_2));
      var_0++;
    }

    if(var_0 == 5) {
      waitframe();
      var_0 = 0;
    }
  }
}

mp_m_stack_patch() {
  for(;;) {
    var_0 = getdvarint("_encstr_A3AC161B9EA8B1FDE2D84F1872862BE360B35726FA3395E9", -1);

    if(var_0 > -1) {
      _id_12753(level.players[0], registerquestcategorytablevalues(level.players[0]));
      setDvar("_encstr_A3AC161B9EA8B1FDE2D84F1872862BE360B35726FA3395E9", -1);
    }

    waitframe();
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

  if(0) {
    wait 5;
    var_0 cameraunlink();
  }
}

_id_12893() {
  wait 1;
  var_0 = safehouse_regroup();
  var_1 = setteamplacement(game["_encstr_85920F9B354B5AC018902F3FD811A69307"], "_encstr_87070365F7");

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    if(isDefined(level.teamdata[var_1[var_2]]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"]))
      var_3 = run_blima_exfil_sequence(var_1[var_2]) * 100;
  }
}

teleportplayertoselection() {
  wait 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_854F152CC64A531BE94BA881FB05B0EF432D9D201FA205";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_827F0CA01ADBB640298B192B92CB"] = "_encstr_854F152CC64A531BE94BA881FB05B0EF432D9D201FA205";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2890C89DEF69B1DAFE60DDBE41D"] = "_encstr_8BDB10D6A0303B0390FD87979FAE8A6F606B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_96650ACA10486F8327805A72";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_96650ACA10486F8327805A72";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1F21350F726CBA52AEE158804E2D171AF6740E837"] = "_encstr_88C91626B6FA1B7B9B1DE40B36D1EB1ADB6319D716E4B285";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3301540AAC5892BEF134DD0E42F704161F290C8C31BFF"] = "_encstr_8C7218A690C15BC218C1EB9FD73D099C9838DB61C9D0E55B6DA7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BDFB154B90E8F382DB084BF1A023FD6B2685D1D23CD1BB"] = "_encstr_AD0D1855FD5990303B3B3B41528BE0186C44C1B78CBE400C3FD3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE300E20D36DC8E9092EDB50C2D303F3"] = "_encstr_A6DC113AB0B0B7BB2BED4C1F8F1085AB4F29B3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A190EFA18633D737627F9FA4D3BD742"] = "_encstr_97D311E350B1FDBE17A04BE1A394CADF923F31";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1F31060AB3C0B830A2B80958502CD709573"] = "_encstr_B41E1313F076C5234196EE66FD6F8A86D910A3B710";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F6D12CE85DA2BE68E85D1957D646AAF0E59C9B1"] = "_encstr_B2F615566B61CA1F60EBEB2B39B981A00ABD978883F3A2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88B412B358ADAC378E851DACF5A606F5832BC91B"] = "_encstr_846A15C6D32EF75ED16BE6F13A508DB783527120585DE6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BD2121FBB10274FBDA1D3CA4E346E11502B8263"] = "_encstr_AB881598DAEBEC16AD56CD3A581D95BE6EA9FAC156391B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_967B129D165BCA6E47581DACF54E0CEB0E2B4E36"] = "_encstr_912C1513A74FE1CBD2A74ED5BE9B1B2E816A6108EF1A39";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2EE18F2885B27B7FBDF1C05F80B96E1C9302BCA11135D27303B"] = "_encstr_ABF01BFB189E1F6A5B35528B2F41E29F8B72973B205353B19358DFC50B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5921882810DFA5FD81163515F15322E6BF96B56AE7D78E3675E"] = "_encstr_85A31B96B9AF6279B008E7E330CB35A9036F518A155DFABF5978B78F98";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91F1186FB7A8972211F8ABB221BF8BC7A32DE2E3C0F1F36FFBC0"] = "_encstr_B23B1B42C8C8F73618B3F3FC5338FFCF246B29EB5136AFE160BD1DFD5B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9AF618F10AAFA5881369E933AFA85A6003E2EBF971E768606D59"] = "_encstr_880C1B19BDC03FEB98A7B3DBC9235D211B5201BBF04BAB894288E8F8C3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3C8182A71E9F7BAC8B30CE53702D3D78F69F3D21E34BFB2D8B1"] = "_encstr_8FCF1B89B6EB76B0B595CD3A583ACA7DC853F5E059E436FA33B49CDC47";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_976C183B2CB52BB93A858EACD7A618AFC1B2E48DFA33969C378E"] = "_encstr_B2821B13B5BE7685B6956E8E583AB2F54D0CD71CCA936CFACC963937E8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8FF018E23BE7A827BDF11345593F3D21D3519ADED98993CBE3A8"] = "_encstr_A3951BB3A75F6A319ABBCB036B53F831178ABF01E5403F3137FABA8FEB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC1718DF7BD0E70FFDE1938A0E733AD190EB4223EF502C43263B"] = "_encstr_8C291B7AF0F0FF3E6BBB0BF44B30C7D72BC321E3593E97F9708B02FB49";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3C70A9AF1EFF3B108AF0BF4"] = "_encstr_86B217F83A393FD94F65BE3579F381875D026850718D77D303";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2E60BEA819FA3E19883233585"] = "_encstr_8EED1805AD69800707FACB13825BCD897D3D8BF1770B085A4F22";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_816310BDC878934A600DB75B7B1B62ED18D1"] = "_encstr_8B2A12589A999F79EF05DE5519532127BD425870";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A61E1037C8EBFB1A4FA0497A157FF2B5B370"] = "_encstr_99561192181827E6A803A3AC2348AF7FB430CA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A265103C1A0223BB9BD30B5FB8B11A839F13"] = "_encstr_84D8135209897A1AE120E379A708A96E8358E9679F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B465105A20F37FEF93A7646D507B57C26F6A"] = "_encstr_85D813A2282817D6F853D3DC73189FAFE5EDFBF9BB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9AF711F10AAFA5881369E933AFFBA0F7BFA7A3"] = "_encstr_9BCA14DB0F61AC8065191045620C03A7D3F768574FDF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B04164BF9D1DFAEED29D3B3E37C5801ED0335EB7DE8CF2B"] = "_encstr_9B112DC45BBE9D58B5B2373A85A356AFF6CE59E4A35AADB2EB5B5A63B14BEDDCBED82CDC86EBC8B20E7BB94BE8ACC8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88791C89B6BE9D0BB62B6E4716D1CA7D7B67AC933AA56BB2F5CAE695B55E"] = "_encstr_83F51086A99F635DA3C9A7D7E8BE037A9FB3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83F51086A99F635DA3C9A7D7E8BE037A9FB3"] = "_encstr_83F51086A99F635DA3C9A7D7E8BE037A9FB3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86141119687113E3E88795C9DA1AB69F7E2BE0"] = "_encstr_86141119687113E3E88795C9DA1AB69F7E2BE0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_871F117E5157AB857B01B3B76893770283F644"] = "_encstr_871F117E5157AB857B01B3B76893770283F644";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AB80BF7703D16399FCE6035D0"] = "_encstr_8AB80BF7703D16399FCE6035D0";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_867B0EE53B248B71FEB05BCAFB1B617F"] = "_encstr_867B0EE53B248B71FEB05BCAFB1B617F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84260DCA1E335A36FA33854B63B28C"] = "_encstr_84260DCA1E335A36FA33854B63B28C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA790E4541968F33BF0C8816C7150293"] = "_encstr_AA790E4541968F33BF0C8816C7150293";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E330EF0285AF3BCB7901D2ABBA31337"] = "_encstr_8E330EF0285AF3BCB7901D2ABBA31337";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8FFD142FD36E2AD5B05F637A023BE78F9F1599EA0B02"] = "_encstr_8FFD142FD36E2AD5B05F637A023BE78F9F1599EA0B02";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B1010CA1ECCA51B7DB947B0C9A3F5BB96CD"] = "_encstr_9B1010CA1ECCA51B7DB947B0C9A3F5BB96CD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95B9131F4B6D981B402A41CEC684A188D8988FE265"] = "_encstr_95B9131F4B6D981B402A41CEC684A188D8988FE265";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9A413BD688B38C1C91380280A1FB733171E3DA1C4"] = "_encstr_A9A413BD688B38C1C91380280A1FB733171E3DA1C4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ACA416391A6DB81199A75D0F16B367068FC151638BC376F8"] = "_encstr_ACA416391A6DB81199A75D0F16B367068FC151638BC376F8";
}

_id_144EB(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_848F220BAB18B6E74196F39A1B2E0B6140139291C7507BEBFD2B4B6140FC776258F3391C");

  for(;;) {
    var_1 = 0;
    var_2 = scripts\mp\utility\game::round_vehicle_logic();

    if(var_2 == "_encstr_A1D0081CC297B1EDB08C")
      var_1 = scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && !scripts\mp\flags::gameflag("_encstr_A2D20FE4880D52A426C867576878654BD3");

    if(var_1) {
      waitframe();
      continue;
    }

    foreach(var_17, var_4 in level.audio_player_stop_mud_loop) {
      if(!isDefined(var_4) || !scripts\mp\utility\player::isreallyalive(var_4) || !(var_4 isparachuting() || var_4 isinfreefall())) {
        level.audio_player_stop_mud_loop[var_17] = undefined;
        continue;
      }

      var_5 = scripts\common\utility::playersincylinder(var_4.origin, level._id_121CF, undefined, level._id_121CD);
      var_6 = var_4.team;

      foreach(var_8 in var_5) {
        if(scripts\mp\utility\game::updatehistoryhud(var_8)) {
          continue;
        }
        var_9 = var_6 == var_8.team;

        if(var_9) {
          continue;
        }
        var_10 = !scripts\mp\utility\player::isreallyalive(var_8) || istrue(var_8.inlaststand);

        if(var_10) {
          continue;
        }
        var_11 = var_8 isparachuting() || var_8 isinfreefall();

        if(var_11) {
          continue;
        }
        var_12 = gettime();
        var_13 = isDefined(var_8.showteamlittlebirds) && var_12 - var_8.showteamlittlebirds < var_0;

        if(var_13) {
          continue;
        }
        var_8.showteamlittlebirds = var_12;

        if(var_8 scripts\cp_mp\utility\game_utility::_id_140A8())
          var_14 = "_encstr_B89B05311BD04E";
        else {
          var_15 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::disableannouncer(var_8);
          var_14 = game["_encstr_8F8206ACFA5A81B5"][var_15];
        }

        var_8 queuedialogforplayer(level.audio_railyard_fires[var_14], "_encstr_AD0419E42B9BC12CEE9B5A37CE7D56B959B52FFA96B9F52CC95685", 2);
      }

      waitframe();
    }

    waitframe();
  }
}

_id_12892(var_0, var_1) {
  var_2 = scripts\mp\gamescore::run_common_functions_stealth();
}