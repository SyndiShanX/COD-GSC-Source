/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_rat_race.gsc
*************************************************/

activate_laser_trap_parent() {}

init() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319") {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_97CE0D72D84DC423792EE1F2C6E0F7");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_84EC163339208BC548FB4A5DC74BCAEF59D1B8CA6085477A");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC");
    level.decoyassists = ::groundz;
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_96F01524FD4B55733DBAD0A152521F686743BD2844D71B", ::relic_steelballs_health_boost);
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_81EC15B516C11A959B1D9527645ACDC28D68D2E48D36B2", ::relic_steelballs_health_boost);
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97D311FBD1FDFCADD2C9E888A7D50FD3890F07", ::dangercircletick);
  } else
    level.deletequestobjicon = 1;

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BDC6085DF29A892901C7");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B49086F374076B48192");
  level._encstr_99081DB05B2BA0FF0FE5B19241D8F6260310D2EDC0F828B2C5483AA2095F3C = getdvarint("_encstr_81C8258A39C00F6BF7A947FBEBAE4257B841C5945680E0C3569BCFFBC3403A9F88483EDEA82884", 1);

  if(!level._encstr_99081DB05B2BA0FF0FE5B19241D8F6260310D2EDC0F828B2C5483AA2095F3C)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F");

  if(getdvarint("_encstr_937B16E66C4E7D89D6DED7ABE62BFA37C12CBBB9FA99D287", 1) == 0)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_838F0D8DEFA26BC7D83780300FF4D9");

  if(getdvarint("_encstr_8A8519DF5BAAC91EE3D153394B7FCEE006B57F69C1935052EFAAE8", 1) != 0)
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
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97670EEB0EFB48B1BA22F028DA0D6701", ::manage_fakebody_hides);
  level._id_13ABD = getdvarint("_encstr_997B14B936937D19B5D3EB3A56C2ADA0B1BAB9C85939", 0);
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
  var_0 = getdvarint("_encstr_97EB11CDB1E4FA19B63DBEDD4BE6D7B1DBCDA3", 3000);

  if(var_0 > 0) {
    var_0 = var_0 * 10;
    var_0 = var_0 * 100;
    setDvar("_encstr_8B3C125FEF4E8FC583783BF752AB3D92D999A173", var_0);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), var_0);
  }

  setDvar("_encstr_9A4E10AB261DF7EA8A01A7AF27B3FA1B1D51", 3);
  setDvar("_encstr_A14816336A93F840D21799E7513F60B5D30108DB831728F8", "_encstr_8DDE08CDF61D434BB9B3");
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 4);
  setomnvar("_encstr_A7990F658429177BBC4FF8417FDCB179D2", 1);
  setomnvar("_encstr_A2E017BB686F48581C5A01DBF76C5DFA1A4F49C9DB201ABD98", 1);
  setdvarifuninitialized("_encstr_A9E21293B8454913DB20EAE1406D1F0E91300BCA", 1);
  level.scriptedphysicaldofenabled = getdvarint("_encstr_957C1D339F73695A50D81FF9A73379A57BD83260B81BCDEC17132A6FDAF9AA", 1);
  level.trackriotshield_tryreset = getdvarint("_encstr_8FB0219BC6E4EBC45BDBBED237B93A58374709D856568C7AABA3A92EABB032AE960EB2", 1);
  level.debug_kill_tromeo = getdvarint("_encstr_A97C28C7320AA90A7A6AA11ED8215150F81791C2EA2590DBDB041A217F436582E56B3354A7ED2898BAF0", 50);
  level._id_13BDF = getdvarint("_encstr_A6A1256B46DACF16BFAFD87B47176737AE71BF3AFB20670A3B689DE960FDBB8B4DB8CF4E4FC5B8", 5);
  level._id_14086 = getdvarint("_encstr_B2D91B7B77AD67B3BBEFDE836702C1E8A06018C8DF05755724990FA73A", 1);
  level._id_11BE6 = getdvarint("_encstr_9792218703C2A16ED70BAE7322A7ADE95D913113BBABD8B8EF6140192B974879FCC097", 0);
  level._id_11BE5 = getdvarint("_encstr_81EE1BCD36C9FA895BDB7DD6961BACE68EEDDCCA4134B0CD2BF531A5E6", 30);
  level._id_11BE3 = getdvarint("_encstr_86221DBFAF2DE170A01899F14F3802E619552D254FB8A9D0057FB9FB60581B", 50);
  level._id_11BE4 = getdvarint("_encstr_A39F1DDB6ECA418E12776F03472A459864C5E0915A08783ECACF592B4B8296", 75);
  level.br_checkforlaststandwipe = getdvarint("_encstr_9B8F26AECE33AF4369D301606F837977AAF4A6BDE29AB9AE529F98C0AFDBB167E29197B13D937DF3", 2500);
  level.br_circle_init_func = getdvarint("_encstr_8C3A2B7EAB0326358E9B1978E226C3FEA759067D12CF8B27F5D218093A7EA75007E8036693CF33DF5E5A788863", 25);
  level.spawn_default_player_spawns = getdvarint("_encstr_960422DCD839EB26B6F6EB1A4B8CAC28C6B0D8B2DA95B9D1AA9BD196632856C9D8B2DC47", 10);
  level.spawn_convoy_and_move = getdvarint("_encstr_8FEF237B98AA0FD055F7BF804CA30A68C030B7AD7293B03F6887A323472A389D833250B32B", 0);
  level._id_13366 = getdvarint("_encstr_AC5B214F4746891A1880B1421B30271395FFC7B709E1D2C3D829B206F02345BB76631F", 1);
  level._id_12FB3 = getdvarint("_encstr_8C7C265A366D79F238E0DF6798D1A73229566E572CEF633D67E01F3FE04865FAD1FD6A8F0731AA53", 60);
  level.loadout_updateclassdefault_headlessgetweaponn = getdvarint("_encstr_838E230E6E930FE1C51F61B02FF359AD9A179017472B3F0EB103D0F0A73651EBD2BFF09D5A", 0);
  level._encstr_86A91ED156B06BADB0E895D87BED3A8DB28519AC39ADC227ADB2CD2C4CB15932 = getdvarint("_encstr_933B2FDC6C93FA93C23AF53916D859EB8ECA0BB6B62CA356F5B1DBEDA37DC65916192BC9EBDAC24EAD7D2B9B2C89C6CA91", 1);
  level._encstr_924F1CE856165BAD85D1ACC6F6F6A3B1CAB0C856C95B0B27D6B1B7D5738E = getdvarint("_encstr_87C52DE636C9FAE40B1D7D93C2B1957D1D562C6BDA588ECABE63BDDB1DBEB1ACC246AC4EFADA0B4ED67DB17BEA9B3A", 3);
  level._id_11A27 = getdvarint("_encstr_8E8F24F7FF0EC14220ABC98A21189D19E90F7F631FB92A097091BAD958D0B21228AFF7FFD5DD", 6);
  level._id_11B62 = getdvarint("_encstr_8E8F24F7FF0EC14220ABC98A21189D19E90F7F631FB92A097091BAD958D0B21228AFF7FFD5DD", 6);
  level._id_11A2A = getdvarint("_encstr_877A1ECB5B0AD156BD1038487572552712692E416F2BF110C730AF57D6322D82", 750);
  level._id_11A31 = getdvarint("_encstr_82DE21331602D9C5EF989F83D51D282F88ED199C77905F2DD0E07F53608AD6B84D89A0", 0) == 1;
  level._id_11A37 = getdvarfloat("_encstr_B22F29B812BA9763B74C907E31D7C9CF657AE00849D52BD99B450EE01D43117BCBA2E978B26B53F33B6919", 5.0);
  level._id_11A38 = getdvarfloat("_encstr_B6412FD6B64BD72B018BA9D8C75B819FD2DD40DD01027BB1ECE7C8B9FF60791BFBC7D0EBA55B339BC60F63C19B84904DD2", 2.0);
  level._id_11A3B = getdvarint("_encstr_8AAE20A00AA2FF0BCF24F86609FFD1374E3220D812BF4703F754F6D5DF573B13724B", 800);
  level._id_11A3A = getdvarint("_encstr_ABFA1E6E8D93AFE40B477DC90BC656BEC6A54ED8C659D738EA63E6ACFA95738C", 200);
  level._id_11A2B = getdvarint("_encstr_825726CD1BC97D135BBDFA367BED47FA632B0B46B2E47DAD16936DD7DCB49EB27D9197730BB6A5B1", 1);
  level._id_11A2D = getdvarint("_encstr_A31B2AE61B9C7D13DAEDBE1BDBDB8ED78DCA0B192B937D5B0BC9B5EBB4B933B7FA9B47C9B7CD76AFE6B4D395", 250);
  level._id_11A2E = getdvarint("_encstr_81A42B7BCF98D99BA1F0D1EAD8889B8163BBE1F46B20116F5F4BAAC160501B45413F8C6AE728A7DFFCC1D26BC9", 5000);
  level._id_11A2F = getdvarint("_encstr_870728637E8BC78EE8878129409733872321C05595A277E59B8AC8A761E5899AD18BB52FB8A0D34138E8", 750);
  level._id_11A30 = getdvarint("_encstr_827C29B96C27BE26DAF67D36DBBD477DC695B023CA9CF5D6B0E4D6AFD29B99DB7DBB95B05BFA9D0B8DEAAC", 2500);
  level._id_11A35 = getdvarint("_encstr_8D2D397378B628A369037FEB633715DFFAC8D7344861EBBFC0AFD278CFD64A77B0DBB9F0D177DD4F9B737E5B59FB2B15CEA80A66AF6905582DB406", 100);
  level._id_11A34 = getdvarint("_encstr_842D39F3D610460E9F2CF18EA9B0AF313A3F1F3B61A4C521D44988CE7133521281761620591FB07E6CF0D863D2EA0FAAF89FA17D661F8B1FE7B950", 250);
  level.onsquadeliminatedplacement = getdvarint("_encstr_815B245F379B10D0A5153E503D9F58A8D2B7F389C743D8A0D8AAE0ABA77CC9FD8A0F6D117F4A", 0) == 1;
  level._id_11A2C = getdvarint("_encstr_83AD23D6662AD97228C787C5AA20A0D058E7F7A138A3577A6B20FFE12B8052A940F92EF29F", 0);
  level._id_127C0 = getdvarfloat("_encstr_AF5714E7636201C6471A0E7083070BA871FE5B9D1B4B", 0.3);
  level._id_127C2 = getdvarfloat("_encstr_81DF1513A7F0B1E3D9988952232E0776412FBD8B277807", 0.5);
  level._id_127C3 = getdvarfloat("_encstr_8E7114FE9E63FF71558FD148CF63283F19C3FB0B32DA", 0.75);
  level._id_127C1 = getdvarfloat("_encstr_8E5C15B9C64EFA896B7BFADA5D9B5AB1BE66DB5D931DD0", 0.9);
  level._id_14062 = getdvarint("_encstr_AA3317BF4BDA37E088AB17D3731D9D8B2B6F768263702233BD", 1);
  level.checkpoint_objective_id = getdvarint("_encstr_91C21C68C26A4771B772A0A755FBD8E5176BE870FB051FE97F842DAB55C7", 20);
  level._id_13BCD = getdvarint("_encstr_92B61DE68D93BEC8AD4FD78EEDB6CAE64ACADC0E0BEECDBAC2A5478AB46BAC", level.checkpoint_objective_id);
  level.start_persistent_turbulence = getdvarint("_encstr_82761837E0B35F42D332C18295D73B29BB100F43B868D90A094B", 0);
  level.start_pipe_room = getdvarfloat("_encstr_88CA1C37B193FA235B9EBE9356CD0E58DD73D71C56DCB0B18EE5FAAD0BE1", 15);
  level._id_12CA7 = getdvarint("_encstr_AC901E8F42F251C16B28E762A5F64079AF1E84399B1FC37398E40A3BAA4BCABD", 5000);
  level._id_12CB4 = getdvarint("_encstr_83AB1DD6662AD974289387420AC080CF3B250F8158526D5961F8CF0273E017", 0);
  level._id_121CC = getdvarfloat("_encstr_A6D41D9BB19C7D4C6BBDEB83859C16360DD53A2B88CA071BDBF22256D858E5", 0.5);
  level.current_trigger = getdvarint("_encstr_88F31A378D93BEC8B53D7D26DB73AEDC225958A3D0418D57E646B2C9", 0);
  level.current_volume_allies = getdvarint("_encstr_9B781D325E15019C50D0779B60E8450BC1E53E6BB3396AB518C897D3C9A01C", 0);
  level._id_11B6C = getdvarint("_encstr_97391E6ED893EBC4D6F6D76BB00F288DEAB98C5627229CB71C7ADC11B22C1D0D", 20000);
  level._id_11C40 = getdvarint("_encstr_81761E4F98CBD7AA4B2049FD1B65C1BC73986B9F88A532A289D80DBF7523BB70", 0);
  level._id_122F5 = getdvarint("_encstr_A7391E6ED893AF4C6BBDEB835693C6B2DC3A85D9CA82B1BACD91593922E4DB1C", 80);
  level._id_127BC = getdvarint("_encstr_9359229B1BC9AFC4ADDED73836BAE6C8AC39232C9EDC884EB7C1150D93B216B91A7B6346", 750);
  level._id_11B6B = getdvarint("_encstr_87A8217BCF98D99BA1F0D1FA19030B4DC8ADE4F545915A67D72CFAC083D54B83F0039D", 20000);
  level.oic_loadouts = getdvarfloat("_encstr_998520CDD8277D13ADDB7DCA1E951BAE1D4BF6E6D00BB9436A57B1A3B483635AB227", 1);
  level.checkforcorrectinstance = getdvarint("_encstr_A78F226E8D4EFA9C161DEB278536567D2C5DD1DB82DC372D3BE6192D4E6E478A57CAE63A", 0);
  level._id_12966 = getdvarint("_encstr_A67F1DDFBFDB592A4FB3781361462BC11F4B305BE0E1D86038C9731DE8B928", 5000);
  level._id_12965 = getdvarint("_encstr_8D7F1DABF20B1028EEC41745F956A8D8AF0BE1536B0BB098CFA15771CD3E88", 10000);
  level._id_12962 = getdvarint("_encstr_864F1DA33FF017CDE0C30EC30A0FB0FFE0AB308B1D71C3B6F05B53485424AA", 2500);
  level._id_12961 = getdvarint("_encstr_8F4F1D9B36E4BEE4161DEBC90BD8ACD7E25DAC6E3A0A6EB922D2CDA3A60BC3", 30000);
  level._id_12968 = getdvarint("_encstr_82101E2BEE786F0B41C359CA595831E12143129B90C7E1414C05A25B6B75F0E8", 5000);
  level._id_12967 = getdvarint("_encstr_91101ED753B2D11EA75BFE4312775D198ABD734FEC5268EF9370306BABE70758", 10000);
  level._id_1296A = getdvarint("_encstr_82101E2BEE786F0B41C359CA595831E12143129B90C7E1414C05A25B6B75F0E8", 5000);
  level._id_12969 = getdvarint("_encstr_91101ED753B2D11EA75BFE4312775D198ABD734FEC5268EF9370306BABE70758", 30000);
  level._id_139EA = getdvarfloat("_encstr_A13826D73A13B9ED985BBEFE11362DE78BFF89AED551B2FA4DEBA3060AA3951BE7828D934F025BC0", 1.5);
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
  level._encstr_A28B1623D2DC8589362B38B1D5DC32B22789C237AD4BCD9D = getdvarint("_encstr_996F2F4B0A7A8768A39839CD783181796B60D76095DF33AB7BAB36E9C2B9EFB7AB041851D76BCA533859BD6D51C8E3B921", 1);
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
  level.lootcontentsadjusteconomy_bottomtier = getdvarint("_encstr_97EB11CDB1E4FA19B63DBEDD4BE6D7B1DBCDA3", 3000) * 1000;
  level.lootchopper_isnearbyoccupiedspawns = getdvarint("_encstr_83EE14FFF716D94AB0F64F108B6891D2ED7737177FBD", 300);
  level.lootchopper_oncrateuse = getdvarint("_encstr_8BF718EB49383FE0EA315F20D3FE2067F8D836A8972BB1B394CD", 40);
  level.lootchopper_managespawns = getdvarint("_encstr_976F1D9B6CC9FA31397DAC0F1D4EB0B1D1AFC6BD9B3AF519566C39B2589B56", 20);
  level._id_11C41 = getdvarint("_encstr_AF2A1B7B357F689183A6C17385B8FB4766D103EA8D065312E9E047D8CB", 7);
  level._id_11B6D = getdvarint("_encstr_AA251BE27B5F90AB22AF3064ABF8B5F322DF48B9D973EA9E9BDC923096", 7);
  level.disable_back_light = 1;
  level._id_12A12 = spawnStruct();
  level._id_12A12._id_1404C = getdvarint("_encstr_82FB32EB26DBEF124B20895360A70F379396454F4F600B9F55E8922B18D5477F4877D8D751A8AFA631F87A82C1FDBE73A0EF5E74", 0) != 0;
  level.play_nag_players_hvt_callouts = ::play_nag_intro_vo;
  _id_13208();
  _id_13209();
  level._id_12A12.maphints = getdvarint("_encstr_AD501B60D6C2CF1273B8099B288FBD41838FA9394703B94B2A25CBB04F", 750);
  level._id_12A12._id_122A1 = getdvarint("_encstr_B2A521F3CE3307EAB3C8917B588F674F2BA5579C5078BF765B832B03A8EBD13BE019F5", 90);
  level._id_12A12.manualturret_watchturretusetimeout = getdvarfloat("_encstr_8C831E3FE8BBA7DBC33DD98AAFEF621F437017EBF030EFF331585D021E932BED", 2.0);
  level._id_12A12._id_1229C = getdvarint("_encstr_AF06275BEE4AC106529BEFBDE75AC579E0C746D19693B0A85AFB9781B76195B09C5EA8AEBEE7ABF8B3", 10);
  level._id_12A12._id_12296 = getdvarint("_encstr_BD502C7A164D59C29918BF03D8B18D01E1BDC9F68FB7E2270130071370EE46AABDCE8B616C3B7B258E900F0F70A3", 5);
  level.spawn_set_jugg_value = spawnStruct();
  level.spawn_set_jugg_value.chosen = undefined;
  level.spawn_set_jugg_value.choppersupport_watchtargetrange = undefined;
  level._id_12A12._id_13A9B = [];
  level._id_12A12._id_12482 = [];
  thread toggleusbstickinhand();
  thread teleportplayertoselection();
  thread subscribedlocale();
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
  scripts\mp\flags::gameflaginit("_encstr_A2D20FE4880D52A426C867576878654BD3", 0);

  if(getDvar("_encstr_9570084B1793A090CDFF") != "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319") {
    level._id_12A12._id_12E2C = put_objective_on_guy("_encstr_8B1608EC43B8D647A113");
    tank_x1_capacity();
  }

  subwave_progression();
  thread _encstr_A2A71CE336FFD3DF7AAAD808C2D77D4E13A5F96BAFBFDBE3A27320A0CA6A();
  thread _encstr_ADA01EA053816B5FDBCD75F0A7E24D76F65710C0EF2EC6C763B7EE86FCCABB3B();
  level._id_11C76 = ::dyn_door;
  level.elevator_lights_toggle = ::_id_11C50;
  level.ononeleftevent = ::ononeleftevent;
  level.onplayerkilled = ::onplayerkilled;
  level._id_12075 = ::_id_12075;
  level._id_13B7E = ::_id_13B66;
  level.ontimelimit = ::ontimelimit;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_12601);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  thread _id_1325E();
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

  level._encstr_990A1880536E58F90B6DB1107730B3E51211622FDAB84003CBC6 = [];

  foreach(var_5 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_5)) {
      continue;
    }
    level._encstr_990A1880536E58F90B6DB1107730B3E51211622FDAB84003CBC6[var_5] = [];

    for(var_0 = 0; var_0 < level._encstr_924F1CE856165BAD85D1ACC6F6F6A3B1CAB0C856C95B0B27D6B1B7D5738E; var_0++) {
      var_3 = spawnStruct();
      var_3.modifier = "_encstr_B40101";
      var_3 init_tape_machine_animations("_encstr_91A3353BB919A0FFBF9AFB46721FB7E82F06B3F751FE68C8979311895AC7E798475F391FCF63A10187FA49315337A8E05CFDAFD1614B88", "_encstr_A2BE0AB4DC3BB46E5A981BAC");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_3.objectiveiconid);
      scripts\mp\objidpoolmanager::update_objective_setzoffset(var_3.objectiveiconid, 75);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_3.objectiveiconid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_3.objectiveiconid, 0);
      objective_setshowdistance(var_3.objectiveiconid, 0);
      level._encstr_990A1880536E58F90B6DB1107730B3E51211622FDAB84003CBC6[var_5][var_0] = var_3;
    }
  }

  if(!istrue(level._id_14086))
    level thread _id_12397();

  thread _id_14364();
  level thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::teamvehicles();
  cleanupents();

  if(level._id_13ABD) {
    if(level._id_11A37 > 0.0)
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

  var_7 = getdvarint("_encstr_9B6E1ADCB127EB26B6F67D1BC49960F43B564E272D325935E09595C8", -1);

  if(var_7 > 0)
    level.br_level.c130_speedoverride = var_7;

  if(level.make_bomb_detonator_interact && level._id_12191)
    level thread getburnfxstatepriority();

  level thread syringe_out();
}

syringe_out() {
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  level thread _id_13EEE();
  level thread _id_13FA8();
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
      _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::freefallfromplanestatemachine();
  }
}

ononeleftevent(var_0) {}

_id_126F1(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_97FC14C8B7EB77CA8D6CB76BACF5B91C8D85DC3459CD");
  wait 2;
  level thread _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::freefallfromplanestatemachine();
  scripts\mp\hud_message::showsplash("_encstr_971B1DEEBE3192A850EFA310317348B563B1BFC5E60FCD79D781C890681518");

  if(istrue(level.checkforcorrectinstance) && istrue(level.br_prematchstarted))
    _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::checkforlaststandwipe(self);

  while(!self isonground())
    waitframe();

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);
}

_id_1365D(var_0) {
  if(istrue(level.dmztut_endgametransition) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE") {
    var_1 = var_0 rear_door_collision();
    var_2 = spawnStruct();
    var_0._id_1286F = var_1;
    var_0._id_1286F.index = -1;
    var_0 thread _id_126A4(var_2);
    return 1;
  }

  return 0;
}

_id_126A4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = level.teamdata[self.team]["_encstr_A78C0CCD950FA39456DC0E16DDE6"];
  var_2 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");

  if(var_2 > 1 && !istrue(level.gameended))
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_0, undefined, 1);

  if(istrue(level.gameended))
    level waittill("_encstr_ABA008615A631510C7EA");

  self.waitingtospawn = 1;
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::emp_drone_proximity_explode(0);
  self.waitingtospawn = 0;
  thread scripts\mp\playerlogic::spawnplayer(undefined, 0);

  if(!istrue(level.skipprematchdropspawn))
    thread _id_1253A();

  while(!isalive(self))
    waitframe();

  self notify("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
  self.waitingtospawn = 0;
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);
  scripts\mp\damage::resetplayervariables();
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in();
  thread _id_13EE7();
  thread init_infil();
}

_id_1253A() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(self.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    waitframe();

  thread scripts\cp_mp\parachute::startfreefall(0, 1, undefined, undefined, 1, 0);
  self skydive_deployparachute();
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

  _id_122A7(var_1, self);
}

activate_trap_from_interaction() {}

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
  var_5 = spawnStruct();

  if(getdvarint("_encstr_9B6B21EB7FBB8E3E5B481BA9B101EB89FB9AAF6DF5B6EBF6277AAE1008DF4A92DBC9C7", 1) == 1)
    var_5 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125BE();
  else
    var_5 = rear_door_collision();

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
  thread _id_13EE7();
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

activate_javelin_ammo_refill() {}

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

activate_stealth_settings() {}

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

replace_access_card_on_deathordisconnect() {
  var_0 = level.br_plunder._id_12954[level.br_plunder._id_12954.size - 1] * 100;
  var_1 = int(ceil(level.lootcontentsadjusteconomy_bottomtier / var_0));
  var_2 = getdvarint("_encstr_8CF33F9B17EA7E759A9BD04E365293A62DB7E0E9C39C7315F2C7BEC08A0AC528981BA098DB2DCEC9FB6DB7DEE9020156FFDB18F903C9C0F3F115ACEDBACB63F95D", 50);

  if(var_1 > var_2)
    var_1 = var_2;

  return var_1;
}

run_common_functions_solider_stealth(var_0) {
  return level.teamdata[var_0]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"];
}

run_died_poorly_funcs(var_0) {
  if(isDefined(level._id_12A12._id_13A9B))
    return level._id_12A12._id_13A9B[var_0];

  return undefined;
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
      var_31 = scripts\engine\utility::ter_op(level._encstr_A28B1623D2DC8589362B38B1D5DC32B22789C237AD4BCD9D, run_common_functions_solider_stealth(var_29), var_30);
      var_32 = registerontimerupdate(var_29);
      var_33 = _id_14025(var_31, var_29, level.disable_super_in_turret.player_enemy_cooldown);
      var_34 = revive_or_disconnect_monitor(var_29);
      var_35 = var_16[var_29];

      if(var_31 > var_26) {
        if(var_26 > var_27) {
          var_27 = var_26;
          var_25 = var_24;
        }

        var_26 = var_31;
        var_24 = var_29;
      } else if(var_24 != "_encstr_8BBA05185F8B99") {
        if(var_31 > var_27) {
          var_27 = var_31;
          var_25 = var_29;
        }
      }

      var_36 = (var_30 - var_32) * 100;
      var_37 = var_30 * 100;
      var_38 = var_37 - var_36;

      if(var_38 > 0) {}

      if(var_36 < 0)
        var_36 = 0;

      var_39 = var_31 * 100;

      if(var_39 >= var_13 * 0.9)
        var_18 = var_29;
      else if(var_39 >= var_13 * 0.75)
        var_19 = var_29;
      else if(var_39 >= var_13 * 0.5)
        var_20 = var_29;

      if(var_39 >= var_13 * level._id_127C1)
        thread scripts\mp\music_and_dialog::_id_12791();
      else if(var_39 >= var_13 * level._id_127C3)
        thread scripts\mp\music_and_dialog::_id_127A7();
      else if(var_39 >= var_13 * level._id_127C2)
        thread scripts\mp\music_and_dialog::_id_1278B();
      else if(var_39 >= var_13 * level._id_127C0)
        thread scripts\mp\music_and_dialog::_id_127A9();

      var_40 = scripts\mp\utility\teams::getfriendlyplayers(var_29, 0);

      foreach(var_42 in var_40) {
        var_35 = var_16[var_42.team];

        if(!var_6)
          var_35 = 155;

        var_42 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_966115DD134E2B022730DA9210CF7AEB618E554DBD303B", var_35);
        var_42 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B14816D596AF8939EB1CB1B0CBCA9C7D83BD9BB41D2DEDB9", var_35);
        var_42 setobjectivecallbacks("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", int(var_38 * 0.01));
        var_42 setobjectivecallbacks("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", int(var_36 * 0.01));
        var_22[var_42.guid] = var_42.plundercount;
        var_23[var_42.guid] = var_42;
      }

      if(var_15) {
        if(var_35 == 1)
          var_21[var_21.size] = var_29;
        else if(var_35 <= 5) {
          if(var_34 > 5)
            showsplashtoteam(var_29, "_encstr_B16909D5A7E12D6050F18B");
        } else if(var_35 <= 10) {
          if(var_34 > 10)
            showsplashtoteam(var_29, "_encstr_A35D0ACB9B907B57B0C66A12");
        }
      }

      if(var_39 >= var_13) {
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

    var_45 = [];
    var_46 = [];

    if(level._id_11A2C == 1)
      var_45 = setteamplacement(game["_encstr_85920F9B354B5AC018902F3FD811A69307"], "_encstr_87070365F7");
    else if(level._id_11A2C == 2) {
      var_45[0] = var_24;
      var_46 = setteamplacement(var_22, "_encstr_9767056D0FBFA8");
    } else
      var_46 = setteamplacement(var_22, "_encstr_9767056D0FBFA8");

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

      var_4 = 1;
      var_5 = 1;

      if(!var_6 && var_26 * 100 >= var_13 * level.spawn_default_player_spawns * 0.01)
        var_6 = 1;

      if(var_2 && var_3 && var_4 && var_5)
        var_7 = 1;
    }

    if(!var_15) {
      waitframe();
      continue;
    }

    if(level._id_11A2C > 0) {
      if(level.lootchopper_modifyweapondamage || istrue(level._id_127D2)) {
        _id_13FF0(var_22, var_46, var_23, var_45);
        level._id_127D2 = 0;
      }
    } else if(level.lootchopper_modifyweapondamage || istrue(level._id_127D2)) {
      _id_13FF0(var_22, var_46, var_23);
      level._id_127D2 = 0;
    }

    if(var_46.size != var_22.size)
      var_46 = setteamplacement(var_22, "_encstr_9767056D0FBFA8");

    _encstr_99BE1E23DFD4871BBF53395333EF9B01AB83202FA3023852F9306AC0AAA88792(var_22, var_46, var_23);

    if(var_26 == 0) {
      waitframe();
      continue;
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

            foreach(var_52 in level.teamnamelist) {
              if(var_52 != var_18)
                level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_9AF618F10AAFA5881369E933AFA85A6003E2EBF971E768606D59", var_52, 1, undefined, "_encstr_9B0703896B");
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

            foreach(var_52 in level.teamnamelist) {
              if(var_52 != var_19)
                level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_91F1186FB7A8972211F8ABB221BF8BC7A32DE2E3C0F1F36FFBC0", var_52, 1, undefined, "_encstr_9B0703896B");
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

            foreach(var_52 in level.teamnamelist) {
              if(var_52 != var_20)
                level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_A5921882810DFA5FD81163515F15322E6BF96B56AE7D78E3675E", var_52, 1, undefined, "_encstr_9B0703896B");
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

  if(var_2 >= level._id_127BC)
    playFX(scripts\engine\utility::getfx("_encstr_B6930663D72D9813"), self.origin + (0, 0, 32));

  var_5 = var_2;

  if(istrue(self._id_14436))
    var_5 = int(var_2 * level.oic_loadouts);

  var_6 = var_5;

  if(istrue(level.convoy_handle_stuck_compromise) && (!isDefined(var_1) || self != var_1)) {
    var_6 = int(var_5 * level._id_12192);

    if(isDefined(level._id_11B6B) && var_6 > level._id_11B6B)
      var_6 = level._id_11B6B;
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && istrue(self.get_vehicle_ai_spawner))
    var_6 = int(var_6 + self.get_vehicle_ai_spawner);

  if(var_6 > 0) {
    var_7 = replace_access_card_on_deathordisconnect();
    var_8 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplunderbyrarity(var_6, var_0, var_7);

    foreach(var_10 in var_8)
    var_10._id_11A40 = "_encstr_AA7C07466F9DA30713";

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
      level notify("_encstr_A1B3124D335EAD585A0E9B7792A040CE5C25CDBF", self, var_1, var_8);
  }

  if(isDefined(var_1) && self == var_1 || !level.killcam)
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B6D41683986F56032E87D4C59011071AC7487BBAB8C94F93", var_3);
  else
    self._id_12801 = var_3;

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::_id_13C44(self, "_encstr_AA7C07466F9DA30713", var_3 * -1);

  if(isDefined(level._id_11A32) && scripts\engine\utility::array_contains(level._id_11A32, self))
    playFX(scripts\engine\utility::getfx("_encstr_B6930663D72D9813"), self.origin + (0, 0, 64));

  return 1;
}

_id_12075() {
  if(isDefined(self._id_12801)) {
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B6D41683986F56032E87D4C59011071AC7487BBAB8C94F93", int(self._id_12801));
    self._id_12801 = undefined;
  }
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
  var_2 = replace_access_card_on_deathordisconnect();
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplunderbyrarity(var_0, var_1, var_2);
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

activate_gasmask() {}

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
  var_0 = level._id_11A37;
  var_1 = level._id_11A38;
  var_2 = level._id_11A3B;
  var_3 = level._id_11A39;
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

activate_pressure_sensor() {}

_id_13FF0(var_0, var_1, var_2, var_3) {
  level._id_11A36 = level._id_11A32;
  level._id_11A32 = [];
  level._id_11A33 = [];

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
    var_14 = getdvarint("_encstr_A930300E4B1AEE7DF06BF780F9E152C7C4E0C0F56730A1BE2AFBAB0FB51EF3428653C875F5228A63C0CBF4509D47C95F905F", 2000);

    foreach(var_11 in var_1) {
      var_12 = var_0[var_11];
      var_16 = var_2[var_11];

      if(var_12 < var_14) {
        break;
      }

      if(1) {
        var_17 = int(floor(level._id_11A27 / 2));
        var_18 = var_16.team;

        if(!isDefined(level._id_11A33[var_18]))
          level._id_11A33[var_18] = [];

        if(level._id_11A33[var_18].size == var_17) {
          continue;
        }
        level._id_11A33[var_18][level._id_11A33[var_18].size] = var_16;
      }

      level._id_11A32[level._id_11A32.size] = var_16;

      if(istrue(level.onsquadeliminatedplacement)) {
        if(isDefined(var_16.onstim))
          _id_12C17(var_16.onstim);
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
    var_22 = level._id_11A29[var_7];

    if(isDefined(level._id_11A32[var_7])) {
      var_22.targetplayer = level._id_11A32[var_7];
      var_22.targetplayer._id_11A26 = var_22;
      var_23 = (var_22.targetplayer.origin[0], var_22.targetplayer.origin[1], level._id_11A2A);

      if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
        var_23 = var_23 + scripts\engine\math::random_vector_2d() * randomfloatrange(level._id_11A35, level._id_11A34);

      var_22 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_11DAE(var_23);

      if(istrue(level._id_11A2B))
        _id_13FEF(var_22);

      var_24 = scripts\engine\utility::array_contains(level._id_11A32, var_22.targetplayer) && !scripts\engine\utility::array_contains(level._id_11A36, var_22.targetplayer);
      var_25 = scripts\mp\utility\teams::getenemyplayers(var_22.targetplayer.team, 0);

      foreach(var_11 in var_25)
      var_22 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(var_11);

      var_28 = scripts\mp\utility\teams::getfriendlyplayers(var_22.targetplayer.team, 0);

      foreach(var_11 in var_28)
      var_22 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(var_11);

      if(var_24)
        battle_tracks_updatebattletracks(var_22);

      continue;
    }

    var_22.targetplayer = undefined;

    foreach(var_11 in level.players)
    var_22 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_dogtags(var_11);
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
    var_9 = var_9 + scripts\engine\math::random_vector_2d() * randomfloatrange(level._id_11A35, level._id_11A34);
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

_encstr_99BE1E23DFD4871BBF53395333EF9B01AB83202FA3023852F9306AC0AAA88792(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2) || !level._encstr_86A91ED156B06BADB0E895D87BED3A8DB28519AC39ADC227ADB2CD2C4CB15932) {
    return;
  }
  var_3 = [];
  var_4 = getdvarint("_encstr_A1F233DC1BC9F5C9168ED739B08D2BF53A5658D6DA58D195BE63F6B7E8D7B1562C32CA93D76BC293ADD7D65A377D073657E646ACE4", 2000);

  foreach(var_6 in var_1) {
    var_7 = var_2[var_6];
    var_8 = var_0[var_6];

    if(var_8 < var_4) {
      break;
    }

    if(!isDefined(var_7) || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatelootleadersonfixedinterval(var_7)) {
      continue;
    }
    if(!isDefined(var_3[var_7.team]))
      var_3[var_7.team] = [];

    if(var_3[var_7.team].size >= level._encstr_924F1CE856165BAD85D1ACC6F6F6A3B1CAB0C856C95B0B27D6B1B7D5738E) {
      continue;
    }
    var_3[var_7.team][var_3[var_7.team].size] = var_7;
  }

  foreach(var_11 in level.teamnamelist) {
    if(!isDefined(level._encstr_990A1880536E58F90B6DB1107730B3E51211622FDAB84003CBC6[var_11])) {
      continue;
    }
    var_12 = var_3[var_11];
    var_13 = [];
    var_14 = gettime();

    for(var_15 = 0; var_15 < level._encstr_990A1880536E58F90B6DB1107730B3E51211622FDAB84003CBC6[var_11].size; var_15++) {
      var_16 = level._encstr_990A1880536E58F90B6DB1107730B3E51211622FDAB84003CBC6[var_11][var_15];

      if(isDefined(var_16.nextupdatetime) && var_16.nextupdatetime >= var_14) {
        continue;
      }
      if(isDefined(var_16.player)) {
        var_17 = 1;

        if(isDefined(var_12) && scripts\engine\utility::array_contains(var_12, var_16.player)) {
          if(isDefined(var_16.player._encstr_A70F1CFBDBB9F055D923F1E99DBA1321D0B7FF62302782B6522D1E83FF18) && var_16.player._encstr_A70F1CFBDBB9F055D923F1E99DBA1321D0B7FF62302782B6522D1E83FF18 == var_15)
            var_17 = 0;
          else {}
        }

        if(var_17) {
          var_16.player._encstr_A70F1CFBDBB9F055D923F1E99DBA1321D0B7FF62302782B6522D1E83FF18 = undefined;
          var_16.player = undefined;
        }
      }

      if(!isDefined(var_16.player)) {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_16.objectiveiconid);
        var_13[var_13.size] = var_15;
      }
    }

    if(!isDefined(var_12)) {
      continue;
    }
    var_18 = 1000;

    foreach(var_7 in var_12) {
      if(!isDefined(var_7)) {
        continue;
      }
      if(isDefined(var_7._encstr_A70F1CFBDBB9F055D923F1E99DBA1321D0B7FF62302782B6522D1E83FF18)) {
        continue;
      }
      if(var_13.size > 0) {
        var_20 = var_13[0];
        var_16 = level._encstr_990A1880536E58F90B6DB1107730B3E51211622FDAB84003CBC6[var_11][var_20];
        scripts\mp\objidpoolmanager::update_objective_onentity(var_16.objectiveiconid, var_7);
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_16.objectiveiconid, var_11);
        var_16.nextupdatetime = var_14 + var_18;
        var_7._encstr_A70F1CFBDBB9F055D923F1E99DBA1321D0B7FF62302782B6522D1E83FF18 = var_20;
        var_16.player = var_7;
        var_13 = scripts\engine\utility::array_remove(var_13, var_20);
        continue;
      }

      break;
    }
  }
}

get_valid_seats() {
  self attach("_encstr_B8D22868E7E6655F7AAF63C39FB96086B7AAA10DA1FF81547A9B17EB78767D40AE815979C3B413EF016A", "_encstr_869011ED8EA26FA3BC7FBB983BFFD94B4AB4C6", 1, 1);
  self.carriable_set_dropped = "_encstr_B8D22868E7E6655F7AAF63C39FB96086B7AAA10DA1FF81547A9B17EB78767D40AE815979C3B413EF016A";

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

  if(isDefined(level._id_11A32) && scripts\engine\utility::array_contains(level._id_11A32, self)) {
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

activate_station() {}

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

activate_scout_drone() {}

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

achievement_id() {}

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
    if(level._id_11A37 > 0.0)
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

activate_gas_trap_cloud_parent() {}

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

    _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_13371(var_3);
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
    _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_13371(var_3);
    wait 5;
  }

  level.playerparachutedetachresetomnvars = undefined;
  scripts\mp\flags::gameflagwait("_encstr_A9071177F53082F3938062C92B75DFFAD04BF4");
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 7);
  var_9 = gettime() + int(level.make_bomb_detonator_interact * 1000);
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", var_9);
  wait(int(max(level.make_bomb_detonator_interact - getdvarint("_encstr_9B8B1CAECE33AF4369D301606F8379774AB3303DE52A8B885767B8E077CC"), 60)));
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

activate_gas_trap_cloud() {}

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
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A1991D74B8A0771ADFB012AB191552671990FCE4CB8EDF66C9B0ABC3E00FDA"] = "_encstr_A1991D74B8A0771ADFB012AB191552671990FCE4CB8EDF66C9B0ABC3E00FDA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F991D57F88BA128B028D3A38149E20A6380DFCD5B473A413BE8B7B3B846FA"] = "_encstr_8F991D57F88BA128B028D3A38149E20A6380DFCD5B473A413BE8B7B3B846FA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_834B1F19EDDAFAE07B5A37A3D7CCE49659B9231BBCAF362C1C8EBAC956FAB01B8D"] = "_encstr_834B1F19EDDAFAE07B5A37A3D7CCE49659B9231BBCAF362C1C8EBAC956FAB01B8D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4441F41E50F9731CD1145B3EFBA60388D2F8017F2E3E55D05BA07EB9C6DA8B80D"] = "_encstr_96A91846B7B6FAC1B796B9A37DAC37CA6B97EB8DB0C1E8D54E56";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A6B31A85E0C789AF1093F64B0793600573D8F9B3D9E013D57BF5EF2F"] = "_encstr_A6B31A85E0C789AF1093F64B0793600573D8F9B3D9E013D57BF5EF2F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8AB31A18CA65FF4BF739606537E7B043CD3349D8C2FA11A3EB5DE07E"] = "_encstr_8AB31A18CA65FF4BF739606537E7B043CD3349D8C2FA11A3EB5DE07E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_838C1C856D620FA3C707E830F7E5B8A38A10909E460B114BA22F5980C334"] = "_encstr_838C1C856D620FA3C707E830F7E5B8A38A10909E460B114BA22F5980C334";
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

play_nag_intro_vo(var_0) {
  var_1 = getdvarint("_encstr_8F9131DC1B93AFE4583AAF392C8D95EBE61AF6ABB119FA665AD8A3564EEBB356344BD88D2BBE6E1CC277CDFACD3A4E5DC63ADC", 0) != 0;

  if(var_1 == 0)
    return var_0;

  var_2 = "_encstr_A6B217B718E7C538388BFD0B079F188E495DF68F9BE056D4BA";
  var_3 = level.br_vehtargetnametoref[var_2];

  if(var_0.size > 0) {
    var_4 = _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::vars_update(var_0[0], var_2, var_3);

    if(var_4)
      return var_0;
  }

  return [];
}

baitedbydecoy(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;

  if(isDefined(var_1))
    var_2.angles = var_1;
  else
    var_2.angles = (0, 0, 0);

  var_2.targetname = "_encstr_A6B217B718E7C538388BFD0B079F188E495DF68F9BE056D4BA";

  if(!isDefined(level._id_1218B))
    level._id_1218B = [];

  level._id_1218B[level._id_1218B.size] = var_2;
  return var_2;
}

_id_13208() {
  if(level.mapname != "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319") {
    return;
  }
  if(level._id_12A12._id_1404C) {
    baitedbydecoy((21829, -56164, 242), (0, 352.5, 0));
    baitedbydecoy((23273.7, -52382.6, 366), (0, 120, 0));
    baitedbydecoy((29059.9, -47273.2, 524.897), (0, 182.5, 0));
    baitedbydecoy((26132.2, -43407.8, 690), (0, 212.5, 0));
    baitedbydecoy((27337.9, -40774.9, 653.864), (0, 35, 0));
    baitedbydecoy((18872.8, -49149.1, 642.25), (0, 212.5, 0));
    baitedbydecoy((26485, -49953.8, 535.335), (0, 125, 0));
    baitedbydecoy((14641.5, -50754.1, 443), (0, 205, 0));
    baitedbydecoy((18177.9, -52511.3, 296.52), (0, 5, 0));
    baitedbydecoy((31340.1, -51236.2, 485.647), (0, 212.5, 0));
    baitedbydecoy((26923.4, -53985.7, 341.472), (0, 215, 0));
    baitedbydecoy((15814.4, -33847.7, 4961.59), (0, 2.5, 0));
    baitedbydecoy((13140.3, -33986.8, 5062), (0, 12.5, 0));
    baitedbydecoy((20237.7, -46707.8, 749.25), (0, 120, 0));
    baitedbydecoy((18673.2, -46929.3, 750.987), (0, 212.5, 0));
    baitedbydecoy((28218.5, -56839.5, 323), (0, 170, 0));
    baitedbydecoy((29638.9, -56025.7, 308.468), (0, 262.5, 0));
    baitedbydecoy((8788.77, -54637.7, 561), (0, 307.5, 0));
    baitedbydecoy((10261.7, -54162.6, 561.477), (0, 302.5, 0));
    baitedbydecoy((10794.8, -53842.6, 563.362), (0, 265, 0));
    baitedbydecoy((10175.3, -54896.7, 561.123), (0, 70, 0));
    baitedbydecoy((9113.54, -55194.9, 562.331), (0, 30, 0));
    baitedbydecoy((11842.2, -53605.4, 556.825), (0, 57.5, 0));
    baitedbydecoy((29493.2, -37091.4, 733.981), (0, 167.5, 0));
    baitedbydecoy((28995.2, -37095.5, 731.408), (0, 257.5, 0));
    baitedbydecoy((29229.3, -37784.2, 723.448), (0, 225, 0));
    baitedbydecoy((28802.7, -37644.4, 727.448), (0, 352.5, 0));
    baitedbydecoy((29023.5, -38650.6, 676.476), (0, 22.5, 0));
    baitedbydecoy((29001.4, -39083.9, 681.896), (0, 167.5, 0));
  } else {
    baitedbydecoy((-28582, -19482, 889));
    baitedbydecoy((-22569, -20732, 888));
    baitedbydecoy((-20408, -23435, 888));
    baitedbydecoy((-28679, -22099, 884));
    baitedbydecoy((-27214, -25240, 888));
    baitedbydecoy((-24989, -22957, 888));
    baitedbydecoy((-26014, 21203, 2232));
    baitedbydecoy((-20201, 25508, 2664));
    baitedbydecoy((-22648, 24464, 2560));
    baitedbydecoy((-17014, 24577, 3003));
    baitedbydecoy((-21303, 18168, 3500));
    baitedbydecoy((-21657, 22420, 2972));
    baitedbydecoy((-43032, -2120, 412));
    baitedbydecoy((-41880, -6515, 431));
    baitedbydecoy((-26135, 3610, 3525));
    baitedbydecoy((-30175, 7359, 3250));
    baitedbydecoy((-9877, 6187, 952));
    baitedbydecoy((-13139, 5492, 797));
    baitedbydecoy((-17087.2, -10702, 888), (0, 310, 0));
    baitedbydecoy((-2039.2, -18554, 2105.75), (0, 100, 0));
    baitedbydecoy((-2238.8, -29194.7, 2545.96), (0, 129, 0));
    baitedbydecoy((-20306.8, -30970.7, 858.08), (0, 134, 0));
    baitedbydecoy((-26450.8, -4834.7, 1707.32), (0, 194, 0));
    baitedbydecoy((-4102.8, -2402.7, 1810.69), (0, 265, 0));
    baitedbydecoy((-47416, -11744, 218.24), (0, 0, 0));
    baitedbydecoy((-34408, -13224, 158), (0, 240, 0));
    baitedbydecoy((-48480, -17928, 150), (0, 360, 0));
    baitedbydecoy((-42152, -24152, 190.792), (0, 105, 0));
    baitedbydecoy((-34520, -27640, 275.981), (0, 135, 0));
    baitedbydecoy((-38032, -4328, 1219.71), (0, 255, 0));
    baitedbydecoy((-2072, 10824, 3806.23), (0, 90, 0));
    baitedbydecoy((-12560, 12648, 2910.61), (0, 15, 0));
    baitedbydecoy((-2304, 20544, 2335.33), (0, 165, 0));
    baitedbydecoy((-13688, 26992, 3002.13), (0, 300, 0));
    baitedbydecoy((-28672, 12536, 2053), (0, 75, 0));
    baitedbydecoy((-26904, 28496, 2054), (0, 315, 0));
    baitedbydecoy((-2560, 29808, 1057.95), (0, 195, 0));
    baitedbydecoy((-48256, 8688, 151.32), (0, 345, 0));
    baitedbydecoy((-36184, 15440, 1184), (0, 300, 0));
    baitedbydecoy((-44896, 19200, 1563.34), (0, 285, 0));
    baitedbydecoy((-37352, 27304, 1878.76), (0, 30, 0));
    baitedbydecoy((-46088, 568, 578.53), (0, 75, 0));
    baitedbydecoy((-37400, 20480, 2695.61), (0, 360, 0));
  }
}

_id_13209() {
  level._id_12178 = [];
  level._id_12178[level._id_12178.size] = [(18405.7, -42293, 828), (0, 32.4992, 0)];
  level._id_12178[level._id_12178.size] = [(27560.9, -42692.7, 671.782), (0, 32.5, 0)];
  level._id_12178[level._id_12178.size] = [(30719.7, -55871.3, 317.407), (0, 352.5, 0)];
  level._id_12178[level._id_12178.size] = [(14293.1, -50606.7, 447.147), (0, 9.99992, 0)];
  level._id_12178[level._id_12178.size] = [(24952.3, -51440.4, 395.131), (0, 302.499, 0)];
}

activate_precision_use_lua() {}

put_objective_on_guy(var_0) {
  var_1 = spawnStruct();
  var_1._id_13904 = var_0;
  var_2 = 0;
  var_3 = 60;
  var_4 = 3000;
  var_5 = 0;
  var_6 = 10;
  var_7 = 0.75;
  var_8 = 0.9;
  var_9 = 300;
  var_10 = 3000;
  var_11 = 0;
  var_12 = 10;
  var_13 = 0.75;
  var_14 = 0.9;

  if(level.mapname == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319") {
    if(level._id_12A12._id_1404C) {
      var_1.ground_detection_think = (23079, -53205, 3525);
      var_1.circle_radius = 32000;
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (10162, -54045, 561);
      level.spawn_set_jugg_value.chosen = (28689, -37165, 760);
      var_3 = 170;
      var_4 = 3000;
      var_5 = 0;
      var_6 = 7;
      var_7 = 0.5;
      var_8 = 0.65;
      var_9 = 55;
      var_10 = 3000;
      var_11 = 0;
      var_12 = 7;
      var_13 = 0.55;
      var_14 = 0.7;
      var_1 _id_12AF0(0, (28868, -55849, 309));
      var_1 _id_12AF0(0, (18402, -45320, 888));
      var_1 _id_12AF0(0, (13942, -34146, 5040));
      var_1 _id_12AEF((8186, -45544, 2411));
      var_1 _id_12AEF((40081, -46767, 315));
      var_1 _id_12AEF((21653, -50408, 440));
      var_1 _id_12AEF((35786.4, -39525.1, 530.743));
      var_1 _id_12AEF((4680, -35440, 4438));
      var_1 _id_12AEF((15320, -41043, 2441));
      var_1 _id_12AEF((31359, -47372, 528));
      var_1 _id_12AEF((17844, -27418, 5516));
      var_1 _id_12AEF((21777, -57498, 378));
      var_1 _id_12AEF((31763, -56480, 326));
    } else {
      var_1.ground_detection_think = (-23030, 659, 0);
      var_1.circle_radius = 32000;
      level.spawn_set_jugg_value.choppersupport_watchtargetrange = (-22010, 24680, 3022);
      level.spawn_set_jugg_value.chosen = (-24170, -23620, 3022);
      var_1 _id_12AF0(0, (-42744, -7333, 473));
      var_1 _id_12AF0(0, (-27836, 4897, 3279));
      var_1 _id_12AF0(0, (-9169, 6657, 965));
      var_1 _id_12AF0(1, (-8516, 16084, 2060));
    }

    if(getdvarint("_encstr_B1422F208A227F8B4FA478E6897F51B78FD2A05802B19F8327CFF84861A3D98937BB51C0CAD5DDF907C6775E6CE780451A", 0)) {
      var_1._id_134FF = his_removequestinstance(level.spawn_set_jugg_value.choppersupport_watchtargetrange, var_1.ground_detection_think);
      var_1._id_13500 = his_removequestinstance(level.spawn_set_jugg_value.chosen, var_1.ground_detection_think);
    }

    if(level._encstr_99081DB05B2BA0FF0FE5B19241D8F6260310D2EDC0F828B2C5483AA2095F3C) {
      level.spawn_set_jugg_value._encstr_BECB14E3F58580C5AACBB7C18FE29BB8294F8E7B5DEB = (26975.3, -52773.1, 383.928);
      level.spawn_set_jugg_value._encstr_93CB1403A06BA68A1BEE09FC5D219260310847CF2881 = (357.394, 34.9914, -1.08173);
    }
  } else {
    level.spawn_set_jugg_value.choppersupport_watchtargetrange = (8244, -2576, 3022);
    level.spawn_set_jugg_value.chosen = (-4791, -1707, 3022);

    if(level._encstr_99081DB05B2BA0FF0FE5B19241D8F6260310D2EDC0F828B2C5483AA2095F3C) {
      level.spawn_set_jugg_value._encstr_BECB14E3F58580C5AACBB7C18FE29BB8294F8E7B5DEB = (1726.5, -3760, 3022);
      level.spawn_set_jugg_value._encstr_93CB1403A06BA68A1BEE09FC5D219260310847CF2881 = (0, 0, 0);
    }
  }

  var_1._id_1354F = getdvarint("_encstr_ACF01EA7769A6782B279070397D758B170E74F437A275C90976739B9A881D731", var_2);
  var_1._id_134FF = getdvarint("_encstr_ABC220E636C9FA9C58E8AF392CC695D7378316BB37EB2CDC9D36B2F50B1BD85AB2CD", var_3);
  var_1._id_13564 = getdvarint("_encstr_8BAD21731E7AB163D2AB907A11B75F097B43460438DF118AA94F381949272851D07253", var_4);
  var_1._encstr_B84C17674917D3CE61B9155FF058378AFB9D4FA7C9C97ABD58 = getdvarint("_encstr_953F24DC6CC9FA27C2A3D72758C6B2BEE683B0DD37EB16B9B38DB2BED6A5B9FA0BD88D2DAC37", var_5);
  var_1._encstr_96AE177BC742E30D394925270BC0A96BAF90392914522C8D23 = getdvarint("_encstr_A19424CB06FBCF326BA369B380472F173377214728E67F7D1FD8F279189B205F29D1A4C1350B", var_6);
  var_1._encstr_BE7E164708A1E77227ADFC728D7F1AB1280987A340182D6B = getdvarfloat("_encstr_88AA2312CE1AB91549F167F321431F7F2B73CFAB32B784CBB85B8FD0A8C546C81C39227FC8", var_7);
  var_1._encstr_A99A16DE18EF83ADA13AC810D3497399238F6FD96CB789DF = getdvarfloat("_encstr_967923CD369CBE4E161DD74E16D859EB6E832C77E67D91D2378EEBD6851ED72C368D2D56CD", var_8);
  var_1._id_13500 = getdvarint("_encstr_B11E1ECAA6FDE95209884FF348213D919747D643987FC2861170BF3F507AF99B", var_9);
  var_1._id_13565 = getdvarint("_encstr_A1AF1F47361A383B9A6B772B92184DCE4B214E3C8E01DABD2C5F5993A979C81BD7", var_10);
  var_1._encstr_AFC7155B63DFAFED8143E6F74188790F731811E20AA3E7 = getdvarint("_encstr_A2B9226E6C937D9C16A37D93B0C62BAFCD1C0BEE37F5C29B3B1B59FAB54B9BFA2C3CD2DC", var_11);
  var_1._encstr_8897156E07B0DD73EB16733BC62BBED6B087AF0B3CD29B = getdvarint("_encstr_B1E3229B6C39BE270B3A7DE4B0C6B2F5DCE016DDDCFA0B7376B156AFB6853CEB850F5A6E", var_12);
  var_1._encstr_997B14B9070BDD9B7D232DB947BEADD2B9AF85F05AB9 = getdvarfloat("_encstr_B6FE216ED8C9D7935847D739C2C6ACF5E6380BDDB9F53296CDE8AFB64BB97D2CC3966E", var_13);
  var_1._encstr_8D5A14370E58BBCDAF465A9B3AEBADC21E7D0B0F4B37 = getdvarfloat("_encstr_9674214F98CBD7AB53AD493A1F7F928FB3687FD768C624C28F4541F5771109793A18BF", var_14);

  if(!isDefined(var_1.circle_radius) || !isDefined(var_1.ground_detection_think))
    var_1 power_wave_mode_reset_playerdata(level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);

  if(!isDefined(var_1.arena_bot_seek_dropped_weapon))
    var_1 poweron_warnings(level._id_12A12._id_1229C, level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);

  if(!isDefined(var_1.manualturret_toggleallowuseactions)) {
    var_15 = scripts\engine\trace::create_default_contents(1);
    var_16 = scripts\engine\utility::drop_to_ground(var_1.ground_detection_think, 10000, -20000, undefined, var_15);
    var_1 _id_12AF0(0, var_16);
  }

  return var_1;
}

his_removequestinstance(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = (var_0[0], var_0[1], 0);
    var_3 = (var_1[0], var_1[1], 0);

    if(distancesquared(var_2, var_3) > squared(0.1)) {
      var_4 = var_2 - var_3;
      var_4 = vectorNormalize(var_4);
      return vectortoyaw(var_4);
    }
  }

  return 0;
}

power_wave_mode_reset_playerdata(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = (var_1[0], var_1[1], 0);
    var_3 = (var_0[0], var_0[1], 0);

    if(distancesquared(var_2, var_3) > squared(0.1)) {
      var_4 = var_3 - var_2;
      var_5 = length(var_4);
      var_4 = vectorNormalize(var_4);
      self.circle_radius = int(var_5 * 0.5);
      self.ground_detection_think = var_2 + var_4 * self.circle_radius;
      self._id_134FF = vectortoyaw(-1 * var_4);
      self._id_13500 = vectortoyaw(var_4);
    }
  }
}

poweron_warnings(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = (0, 0, 0);
  var_5 = (1, 0, 0);
  var_6 = 3000;
  var_7 = (0, 1, 0);
  var_8 = 1000;

  if(isDefined(self.ground_detection_think))
    var_4 = self.ground_detection_think;

  if(isDefined(self.circle_radius)) {
    var_6 = self.circle_radius;
    var_8 = int(min(var_8, self.circle_radius));
  }

  if(isDefined(var_2) && isDefined(var_1)) {
    var_9 = (var_2[0], var_2[1], 0);
    var_10 = (var_1[0], var_1[1], 0);

    if(distancesquared(var_9, var_10) > squared(0.1)) {
      var_7 = vectorNormalize(var_10 - var_9);
      var_5 = vectorcross(var_7, (0, 0, 1));
    }
  }

  var_11 = scripts\engine\trace::create_default_contents(1);

  for(var_12 = 0; var_12 < var_0; var_12++) {
    var_13 = randomint(var_6) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
    var_14 = randomint(var_8) * scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
    var_15 = var_4 + var_13 * var_5 + var_14 * var_7;
    var_15 = scripts\engine\utility::drop_to_ground(var_15, 10000, -20000, undefined, var_11);
    var_3[var_3.size] = var_15;
  }

  self.arena_bot_seek_dropped_weapon = var_3;
}

activate_subway_track_trigger_hurt() {}

_id_13B66() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);
  scripts\mp\flags::gameflagwait("_encstr_A2D20FE4880D52A426C867576878654BD3");

  while(game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit()) {
      var_4 = scripts\mp\gamelogic::gettimeremaining() / 1000;
      var_5 = int(var_4 + 0.5);
      var_6 = 0;

      if(var_3 == 2 && var_5 % 2 == 1)
        var_6 = 1;

      var_7 = getdvarint("_encstr_AA1A2837364EFA4EC247F59C581BCAFA0EB2D7C87BD6BECC3685ECBE9B47584E3AD7A35AD6CABEDC566C", 840) + 20;
      var_8 = getdvarint("_encstr_8BD82A9221D817638FD14FE3E3A65A5F7049011E9938F88955B587E3EF40E3CC903343E993B0B5E2208FD797", 1020) + 20;
      var_9 = getdvarint("_encstr_964B2CF7716EFE05516B81226301854FCBE5A766E72F90B8B99E486FA3DE6A8B36E3E9FF6B5B253F4F538DCBB725", 660) + 20;

      if(!var_0 && (var_6 == 1 && var_5 == var_7 + 1 || var_6 == 0 && var_5 == var_7)) {
        if(getdvarint("_encstr_8BC32113A7F0B1A3DFFB89A3A12637793803878C2760C9AB7171027909885F6E70FB34", 1))
          level thread _id_122C0(0);

        var_0 = 1;
      } else if(!var_1 && (var_6 == 1 && var_5 == var_8 + 1 || var_6 == 0 && var_5 == var_8)) {
        if(getdvarint("_encstr_BEE022C399CE876208E14F6AE3306F3F77F1994AA1261311F81567508778F50F9648B242", 1))
          level thread _id_1229B();

        var_1 = 1;
      } else if(!var_2 && (var_6 == 1 && var_5 == var_9 + 1 || var_6 == 0 && var_5 == var_9)) {
        if(getdvarint("_encstr_BEE022C399CE876208E14F6AE3306F3F77F1994AA1261311F81567508778F50F9648B242", 1))
          level thread _id_1229A();

        var_2 = 1;
      }

      if(var_4 - floor(var_4) >= 0.05) {
        wait(var_4 - floor(var_4));
        continue;
      }
    }

    wait 1.0;
  }
}

activate_target() {}

_id_12AF0(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = level._id_12A12.maphints;

  if(!isDefined(self.manualturret_toggleallowuseactions))
    self.manualturret_toggleallowuseactions = [];

  if(!isDefined(self.manualturret_toggleallowuseactions[var_0]))
    self.manualturret_toggleallowuseactions[var_0] = [];

  var_4 = spawnStruct();
  var_4._id_135CE = var_0;
  var_4.location = getgroundposition(var_1, 5);
  var_4.get_current_building_obj_struct = var_2;
  var_4.mid_bosses = var_3;
  self.manualturret_toggleallowuseactions[var_0] = scripts\engine\utility::array_add(self.manualturret_toggleallowuseactions[var_0], var_4);
}

_id_122C0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level._id_12A12._id_12E2C.manualturret_toggleallowuseactions) || var_0 >= level._id_12A12._id_12E2C.manualturret_toggleallowuseactions.size) {
    return;
  }
  var_1 = level._id_12A12._id_12E2C.manualturret_toggleallowuseactions[var_0];
  level._id_12A12._id_12E2C._id_122B5 = var_0;

  if(!isDefined(var_1) || var_1.size <= 0) {
    return;
  }
  _id_122BF();
  level.objectivescaler = 1;

  if(getdvarint("_encstr_8ED12363506D78B35989671EDE3FC90F0F30BF181FD71695A843F044385FB896C1EB9595EE", 0) == 0) {
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BA911319F6DAFA0EB72D9B47AF4B37B1DE6BA573CE", 0);
    _id_12424("_encstr_926220506391ADE3E73A69D52FBB292F875AD031BAF5C3F9E71FE358EB1F100B6D62");
    wait 20;
  }

  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_ACC612C8F6ADFA07B7A59B47D76EE80B39472BC8", 0);
  _id_12424("_encstr_918D1E899CBE39BA5B8963CAAF83B2F546BDDAEB33B10BCEDCF5DEB9B1D2B959");
  wait 3.0;
  level thread _id_122BE();
}

_id_122BF() {
  var_0 = level._id_12A12._id_12E2C._id_122B5;
  var_1 = level._id_12A12._id_12E2C.manualturret_toggleallowuseactions[var_0];

  foreach(var_4, var_3 in var_1)
  var_3 thread _id_122B7();
}

_id_122BE() {
  var_0 = ["_encstr_B20703DFCF", "_encstr_B40703E96D", "_encstr_B6070359BA", "_encstr_A2070318DC", "_encstr_950703EBCA"];

  if(!isDefined(level._id_12A12.are_all_players_in_region)) {
    level._id_12A12.are_all_players_in_region = [];
    level._id_12A12.are_all_players_in_region["_encstr_9A8507BA4040188D08"] = 0;
    level._id_12A12.are_all_players_in_region["_encstr_8E8405EA382B2A"] = 0;
  }

  if(!isDefined(level._id_12A12.spawnsecretstashlootcache))
    level._id_12A12.spawnsecretstashlootcache = 0;

  var_1 = level._id_12A12._id_12E2C._id_122B5;
  var_2 = level._id_12A12._id_12E2C.manualturret_toggleallowuseactions[var_1];

  foreach(var_8, var_4 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_4.get_current_building_obj_struct), var_4.get_current_building_obj_struct, level._id_12A12.maphints);
    var_6 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4.location, 0, int(var_5), int(level.defend_wave_3));
    var_6.script_label = var_0[level._id_12A12.spawnsecretstashlootcache];
    var_6.iconname = var_0[level._id_12A12.spawnsecretstashlootcache];
    level._id_12A12.spawnsecretstashlootcache++;
    var_2[var_8].trigger = var_6;
    var_7 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_2[var_8].trigger, "_encstr_A7A408B9CA5D1D4E2C63");
    var_7.onuse = ::_id_122B2;
    var_7.onbeginuse = ::_id_122A8;
    var_7.onuseupdate = ::_id_122B3;
    var_7.onenduse = ::_id_122AA;
    var_7.oncontested = ::_id_122A9;
    var_7.onuncontested = ::_id_122AF;
    var_7.onunoccupied = ::_id_122B0;
    var_7.onpinnedstate = ::_id_122AD;
    var_7.onunpinnedstate = ::_id_122B1;
    var_7._id_138B2 = ::_id_122AE;
    var_7.stompprogressreward = ::_id_122B8;
    var_7.id = "_encstr_87D9083A6F628DDB5F1F";
    var_7.pinobj = 1;
    var_7.lockupdatingicons = 1;
    var_7.trigger = var_6;
    var_7.get_current_bush_zone = 0;
    var_7.get_current_building_obj_struct = var_5;
    var_7.pos = var_4.location;
    var_7.vfxent = var_4.vfxent;
    var_7 scripts\mp\gameobjects::setcapturebehavior("_encstr_92FC0B5BB01A6B73D09459526B");
    var_7 scripts\mp\gameobjects::setusetime(level._id_12A12._id_122A1);
    playencryptedcinematicforall(var_7.objidnum, 1);
    var_7._id_11AD0 = [];
    var_7._id_11AD0["_encstr_AD830516C68DE5"] = spawnStruct();
    var_7._id_11AD0["_encstr_88BF06FD784A6393"] = spawnStruct();
    var_7._id_11AD0["_encstr_A7A408B9CA5D1D4E2C63"] = spawnStruct();
    var_7.waittill_pickup_or_timeout = "_encstr_8C500ABA9B23CACC2D37AC8C";
    var_7._id_11AD0["_encstr_A7A408B9CA5D1D4E2C63"] _id_122A4(9, var_7.curorigin, var_5);
    var_7._id_11AD0["_encstr_AD830516C68DE5"] _id_122A4(8, var_7.curorigin, var_5);
    var_7._id_11AD0["_encstr_88BF06FD784A6393"] _id_122A4(0, var_7.curorigin, var_5);
    var_7 _id_122BB("_encstr_A7A408B9CA5D1D4E2C63");
    var_7 thread _id_122B9();
    var_7 thread _id_122BA();
    var_2[var_8].manned_turret_operator_validation_func = var_7;
    wait 0.5;
  }
}

_id_122AB(var_0) {
  self._id_1265B = scripts\engine\utility::array_add(self._id_1265B, var_0);
  var_0.truck_03_node = 1;
}

_id_122AC(var_0) {
  self._id_1265B = scripts\engine\utility::array_remove(self._id_1265B, var_0);
  var_0.truck_03_node = 0;
}

_id_122B9() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self._id_1265B = [];

  while(!self.get_current_bush_zone) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if((isPlayer(var_0) || isbot(var_0)) && !scripts\engine\utility::array_contains(self._id_1265B, var_0))
      _id_122AB(var_0);

    waitframe();
  }
}

_id_122BA() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!self.get_current_bush_zone) {
    foreach(var_1 in self._id_1265B) {
      if(!var_1 istouching(self.trigger) || !isalive(var_1))
        _id_122AC(var_1);
    }

    wait 0.1;
  }

  foreach(var_1 in self._id_1265B)
  _id_122AC(var_1);
}

_id_122A7(var_0, var_1) {
  if(istrue(var_1.truck_03_node)) {
    var_0 thread scripts\mp\rank::giverankxp("_encstr_97021BC3E3B1226CD01EF73D7029AE7A1F6FEF17ADED9A41D960ACC548", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_97021BC3E3B1226CD01EF73D7029AE7A1F6FEF17ADED9A41D960ACC548");
  }

  if(istrue(var_0.truck_03_node)) {
    var_0 thread scripts\mp\rank::giverankxp("_encstr_96131C9B13094BDDE06FBC8F330967BBA7C9C102F954EF158007BB81D978", 20, var_0.weapon, 0, 1);
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_96131C9B13094BDDE06FBC8F330967BBA7C9C102F954EF158007BB81D978");
  }
}

_id_122A4(var_0, var_1, var_2) {
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(var_0, 0, 0, var_1);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(int(var_2));
}

_id_122BB(var_0) {
  if(var_0 != self.waittill_pickup_or_timeout) {
    self.waittill_pickup_or_timeout = var_0;

    foreach(var_2 in self._id_11AD0)
    var_2 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::spawn_double_cargo();

    var_4 = self.waittill_pickup_or_timeout != "_encstr_8E8405EA382B2A" && self.waittill_pickup_or_timeout != "_encstr_9A8507BA4040188D08";
    var_5 = undefined;

    foreach(var_7 in level.players) {
      var_8 = var_7.team == self.waittill_pickup_or_timeout;

      if(var_4)
        var_5 = self._id_11AD0["_encstr_A7A408B9CA5D1D4E2C63"];
      else
        var_5 = scripts\engine\utility::ter_op(var_8, self._id_11AD0["_encstr_AD830516C68DE5"], self._id_11AD0["_encstr_88BF06FD784A6393"]);

      if(isDefined(var_5))
        var_5 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1336A(var_7);
    }

    if(isDefined(var_5))
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, var_0);
  }
}

_id_122A5() {
  foreach(var_1 in self._id_11AD0)
  var_1 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();
}

_id_122B2(var_0) {
  var_1 = var_0.team;
  self.get_current_station_signage_structs = var_1;
  self.capturetime = gettime();
  self.get_current_bush_zone = 1;

  if(self.touchlist[var_1].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  self notify("_encstr_AC1B1071F559A8303789B9E072C7E068AD4C");
  thread _id_122A2(var_1);
}

_id_122A8(var_0) {
  self.userate = 1.0;

  if(!isDefined(self._id_11F63) || !self._id_11F63) {
    self._id_11F63 = 1;
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(self.curorigin, "_encstr_8218041DF5FA");
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1)
    var_3 notify("_encstr_91D9276C8563B1B75D8EAD0B936D95E4835AB9D9EBBB8527E9F673CAA55A1B36A2AE56E6D1A436DBCD");
  }
}

_id_122B3(var_0, var_1, var_2, var_3) {
  self.userate = 1.0;

  if(var_1 < 1.0 && !level.gameended && !istrue(self.get_current_bush_zone))
    _id_12427(var_1, var_0);

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;

  _id_122BB(var_0);
}

_id_122AA(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

_id_122A9() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8D861089DB8FC7E017163810235367EB7553");
  var_0 = scripts\mp\gameobjects::getownerteam();
}

_id_122AF(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = undefined;
  var_3 = _id_122A6();

  if(var_3 <= 1) {
    foreach(var_5 in level.teamnamelist) {
      var_6 = self.teamprogress[var_5];

      if(var_6 > 0) {
        var_2 = var_5;
        break;
      }
    }

    if(isDefined(var_2))
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_2);
    else if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_1);
    else if(var_0 != "_encstr_8BBA05185F8B99")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);

    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

    if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63")
      self.didstatusnotify = 0;
  }
}

_id_122B0() {
  var_0 = scripts\mp\gameobjects::getownerteam();

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63")
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1");
  else
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

  self.didstatusnotify = 0;
}

_id_122AD(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");
}

_id_122B1(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");
}

_id_122AE(var_0) {
  self.userate = level._id_12A12.manualturret_watchturretusetimeout;
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = self.teamprogress[var_4];

    if(var_5 > 0)
      var_2 = var_5 / self.usetime;
  }
}

_id_122B8(var_0) {
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8E84100AE82D2133A3508787FD6923F77DB0");
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");

  if(isDefined(self.lastprogressteam))
    self.lastprogressteam = undefined;
}

_id_12427(var_0, var_1) {
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

_id_122A2(var_0) {
  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595") {
    level._id_12A12.are_all_players_in_region[var_0] = level._id_12A12.are_all_players_in_region[var_0] + 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(var_0, 15, 0);

    foreach(var_2 in level.players) {
      if(isDefined(var_2) && isDefined(var_2.team) && var_2.team == var_0) {
        var_2 thread _id_122B4(1, var_0);
        var_2 thread scripts\mp\hud_message::showsplash("_encstr_869120E64A2135E1BCBF28B827C57E698A346875E91ADB0B840F508003277199E258");
        continue;
      }

      if(isDefined(var_2) && isDefined(var_2.team) && var_2.team != var_0) {
        var_2 thread _id_122B4(0, var_0);
        var_2 thread scripts\mp\hud_message::showsplash("_encstr_8B5C21989CAF932CE8FAE485D8CAEB0EBDD2373AD78DB0073AAB272B8CEB95CD59ADE5");
      }
    }

    var_4 = undefined;

    foreach(var_6 in self.touchlist[var_0]) {
      var_2 = var_6.player;
      var_2 thread scripts\mp\rank::giverankxp("_encstr_82B018A23BB84E6B6D0EAA0250A88B0520F7173BABF893778E61", 250, var_2 getcurrentprimaryweapon());
      var_2 thread scripts\mp\rank::scoreeventpopup("_encstr_82B018A23BB84E6B6D0EAA0250A88B0520F7173BABF893778E61");

      if(!isDefined(var_4))
        var_4 = var_2;
    }

    if(isDefined(var_4)) {
      var_8 = getdvarint("_encstr_99A627CDB1E4AFE4161DAF4EB01B957D38957DC8BD6BFAC11BEAB9C82B9CF5DE9B7DC60BE01D573995", 10000);
      var_9 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::init_subway_cars();
      var_9._id_1244D = 0;
      var_4 thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(var_8, var_9);
      var_4 thread _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1261C(var_8, run_died_poorly_funcs(var_0), var_9);
    }

    thread _id_122B6(self.pos);
    thread _id_122A3(self);
  }
}

_id_122B4(var_0, var_1) {
  var_2 = level._id_12A12.are_all_players_in_region[var_1];

  switch (var_2) {
    case 1:
      if(var_0)
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A1991D74B8A0771ADFB012AB191552671990FCE4CB8EDF66C9B0ABC3E00FDA", self);
      else
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A6B31A85E0C789AF1093F64B0793600573D8F9B3D9E013D57BF5EF2F", self);

      break;
    case 2:
      if(var_0)
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8F991D57F88BA128B028D3A38149E20A6380DFCD5B473A413BE8B7B3B846FA", self);
      else
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8AB31A18CA65FF4BF739606537E7B043CD3349D8C2FA11A3EB5DE07E", self);

      break;
    case 3:
      if(var_0)
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_834B1F19EDDAFAE07B5A37A3D7CCE49659B9231BBCAF362C1C8EBAC956FAB01B8D", self);
      else
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_838C1C856D620FA3C707E830F7E5B8A38A10909E460B114BA22F5980C334", self);

      break;
  }
}

_id_122A3(var_0) {
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"), var_0.vfxent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0.vfxent delete();
  var_0 _id_122A5();
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::removeobjective(var_0);
}

_id_122B7() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.location - (0, 0, 3));
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.vfxent = var_0;
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

_id_122B6(var_0) {}

_id_122A6() {
  var_0 = 0;

  foreach(var_3, var_2 in self.numtouching) {
    if(var_2 > 0 && (!isstring(var_3) || var_3 != "_encstr_8BBA05185F8B99"))
      var_0++;
  }

  return var_0;
}

_id_12424(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = undefined;

    if(isalive(var_3)) {
      if(isDefined(var_1)) {
        var_4 = spawnStruct();
        var_4.intvar = var_1;
      }

      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_3, var_0, var_4);
    }
  }
}

_id_12981(var_0) {
  self notify("_encstr_999A1C873190FC61366933FF9753A921E8997B4FEE50925A046F1FBB930D");
  self endon("_encstr_999A1C873190FC61366933FF9753A921E8997B4FEE50925A046F1FBB930D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.isflagcarrymode))
    self.isflagcarrymode = [];

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var_0);

  while(self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var_2 in self.isflagcarrymode)
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self, var_2._id_136F3, var_2);

      self.isflagcarrymode = [];
      break;
    }

    wait 1.0;
  }
}

_encstr_BE0E1CDFFB2A843017D61BB67A1CD0B0D237557F43724E8845AD23C9E2EB() {
  var_0 = getdvarint("_encstr_8F0421E6D89CFA27B0A3D7270B36B2D7314E7BAD9537BEB0D1B5FA2D73A3B2E43B161B", 10);
  var_1 = getdvarint("_encstr_84E0277B21762FCA50893702BB98D7E796FB326249C0774690933F114D30DB67C8716AA9F02B77BCA8", 6);

  if(level.mapname == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319") {
    _encstr_AD0B2E6BB0BB30F83BF322D0A87E7CC9C8DD048B13671AC02E7B1603D0DDF082C562A921A78B0B7B88304F1540945EA7::_encstr_8A4911194B371CACB937CA93AFB1E4560B3AB2(scripts\common\utility::groundpos((28868, -55849, 311)), (0, 180, 0), var_0, var_1);
    _encstr_AD0B2E6BB0BB30F83BF322D0A87E7CC9C8DD048B13671AC02E7B1603D0DDF082C562A921A78B0B7B88304F1540945EA7::_encstr_8A4911194B371CACB937CA93AFB1E4560B3AB2(scripts\common\utility::groundpos((18402, -45320, 890)), (0, 0, 0), var_0, var_1);
    _encstr_AD0B2E6BB0BB30F83BF322D0A87E7CC9C8DD048B13671AC02E7B1603D0DDF082C562A921A78B0B7B88304F1540945EA7::_encstr_8A4911194B371CACB937CA93AFB1E4560B3AB2(scripts\common\utility::groundpos((13942, -34146, 5043)), (0, 0, 0), var_0, var_1);
  } else {
    var_2 = scripts\engine\trace::create_default_contents(1);
    var_3 = scripts\engine\utility::drop_to_ground(level._id_12A12._id_12E2C.ground_detection_think, 10000, -20000, undefined, var_2);
    _encstr_AD0B2E6BB0BB30F83BF322D0A87E7CC9C8DD048B13671AC02E7B1603D0DDF082C562A921A78B0B7B88304F1540945EA7::_encstr_8A4911194B371CACB937CA93AFB1E4560B3AB2(var_3, (0, 45, 0), var_0, var_1);
    var_4 = var_3 + (-95, -130, 0);
    _encstr_AD0B2E6BB0BB30F83BF322D0A87E7CC9C8DD048B13671AC02E7B1603D0DDF082C562A921A78B0B7B88304F1540945EA7::_encstr_8A4911194B371CACB937CA93AFB1E4560B3AB2(var_4, (0, 60, 0), var_0, var_1 + 3);
  }
}

_id_13514() {
  var_0 = "_encstr_9A8507BA4040188D08";
  var_1 = level.spawn_set_jugg_value.choppersupport_watchtargetrange;
  level._id_12A12._id_13A9B[var_0] = _encstr_8B6D2AA046225F99543B5ADAC9BFCF1BA83BFB2BC9993BD7E918E18B18CBAF63530E2DEF45DF6859EE522AB2::_id_140F5(scripts\common\utility::groundpos(var_1), (0, 0, 0), var_0);
  var_0 = "_encstr_8E8405EA382B2A";
  var_1 = level.spawn_set_jugg_value.chosen;
  level._id_12A12._id_13A9B[var_0] = _encstr_8B6D2AA046225F99543B5ADAC9BFCF1BA83BFB2BC9993BD7E918E18B18CBAF63530E2DEF45DF6859EE522AB2::_id_140F5(scripts\common\utility::groundpos(var_1), (0, 0, 0), var_0);
}

subwave_progression() {
  _setdomflagiconinfo("_encstr_86151DBBE91303D74B431DF79EEA53B17B3BEDDE02856BA22711BF7D922F26", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  _setdomflagiconinfo("_encstr_A5151D6B074BBBAFE8B803A7F8C18843FB2677A5FD8B33FAB1D0B76B68FE52", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  _setdomflagiconinfo("_encstr_8D151DBBAAE021286FBEED708B77F3E14B031830023B91C327D460D6726759", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
  _setdomflagiconinfo("_encstr_AB151DBB2C971CBDB4DCE8AF8D16383ABA4E569BCABAA39CB0B1F54CC9FA23", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
  _setdomflagiconinfo("_encstr_99151DDC0BAB4F2FAB18AB39F9A777E333669588512F833E8129E6EE40AF5F", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
  _setdomflagiconinfo("_encstr_A239164CAE6311ED815B782947A1BB41CB12CDC0C66B8709", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  _setdomflagiconinfo("_encstr_B63916EE0BCB1CDEB43747D7C6580ED1EAE4ACF5C4C9FA98", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  _setdomflagiconinfo("_encstr_B43916BBC2BC0EDBA5B9A3EBD8C2C11D5D9356FA3193F51B", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
  _setdomflagiconinfo("_encstr_B239161349DBABB538A5F4D75790BA6305838A19B1365F2F", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
  _setdomflagiconinfo("_encstr_A63916EEB0F21C7B2D7347BE1B2C1CE8BAE456F5984ED72B", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
  _setdomflagiconinfo("_encstr_97DF15EE0B5EE07B5ACDE8F5C856999537917D134EEB85", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  _setdomflagiconinfo("_encstr_88DF159FB7B2FB37A83EA5894745CD5BF03CDE1A4EAF8D", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  _setdomflagiconinfo("_encstr_81DF1517A3A87AD7DBB83B7101253BF7C801878A1DF1C6", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
  _setdomflagiconinfo("_encstr_8ADF159F0B83231768B504B939C751F2D071D70EBBD180", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
  _setdomflagiconinfo("_encstr_84DF153B61F3938D10BD1C2FB1A8170F903931F2AB589F", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
  _setdomflagiconinfo("_encstr_ADF018B08F710BDF6A6DD548C7820511DE33D8F0EF3F01DDD156", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 0);
  _setdomflagiconinfo("_encstr_85F01824C60B7978F9332081E30D919BA22F9320DF012583E72B", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 0);
  _setdomflagiconinfo("_encstr_8AF018BB2C2FE0BDB4CD3AFA4695CC2B73194BE6D9F5319C7DB1", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 0);
  _setdomflagiconinfo("_encstr_84F018D3D0CB57DA30302510416B99B2700BDA3EFF99D653975B", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 0);
  _setdomflagiconinfo("_encstr_B2F0186BDEF108380223491723EAF4F88EF7D0C0C76F506E9917", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 0);
  _setdomflagiconinfo("_encstr_87D8180B61234BD75B5D54373A9218D937BB98E7ECB79B683E38", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  _setdomflagiconinfo("_encstr_81D818DD2CBC07BD96E6E8EBC6ED73E8566EE8ACC8BE98C9F54C", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  _setdomflagiconinfo("_encstr_88D8187847B9B36722359D304E7A5DFB0D97E810BB474915291E", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
  _setdomflagiconinfo("_encstr_92D818DB30DA679FCB607D7F3F17DDD9C3601DD34F573EC3C8E9", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
  _setdomflagiconinfo("_encstr_BED818FB97DB2B5F1848933748B006334B3683F78D6FC28AE608", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
  _setdomflagiconinfo("_encstr_AFCC15BBC2E5E0F6A5CD1D7D3AC2B64B379DF5264EEB85", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  _setdomflagiconinfo("_encstr_A9CC15BB162FC1DED29B3AFA47C26D9673CEAF4C4EFA26", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  _setdomflagiconinfo("_encstr_8CCC15EEB0F238DB5ACD1DF5A30B5BD29BD97D98C9F56C", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
  _setdomflagiconinfo("_encstr_B1CC15DD58BC83BDA5E6A3F5E8166D4B37D9EBC4937D23", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
  _setdomflagiconinfo("_encstr_BACC15F7794890B8AFE2731EAB67628025D71F55F2B970", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
  _setdomflagiconinfo("_encstr_96F0152CF97F937FFC4A104102153FC84B67A02E423F79", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_95F514A22F95A85940918328F0C452FCA95B4D4979B1", 1);
  _setdomflagiconinfo("_encstr_88F0157785CBE0DEA537D1F51B7B6E5A37D9D713E47D4C", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_BAF514A56CDB9BD7BBC22F07F62DCD8EEB46B7B6EB98", 1);
  _setdomflagiconinfo("_encstr_81F015BF6B68F8175C5515E7C157D334AED20668503F37", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_B1F5144BC72788FF4B6E931FC582D573AF73A8A8CFC3", 1);
  _setdomflagiconinfo("_encstr_AAF015B7B0474895D97520D808402351605951595B199A", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_8CF514D017F7582FFBDEC34FB5F285C31FA358787F94", 1);
  _setdomflagiconinfo("_encstr_97F01508A2E8595067A6F5788C579BD3956AD1286B89BB", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_A9F5142D8DEDCDEBBBC2F2C1BD2DCDE8BE91B7B6F556", 1);
  level._effect["_encstr_AA501593CAB89746E80FC7EB9787C27BC83987D02F08A6"] = loadfx("_encstr_8C4525D999E1E596DD0EFAB183BC0727DEC1E53B99F0FA9B5BB5EBCD2DD99B16C6EBD9C995959B");
  _encstr_BD8926CDD8E42D073A9B976B0ECBCEC2B6B21DCBC1596E79C427EB197BB5AF2EAB95B947B83B37B1::_id_13239();
}

_setdomflagiconinfo(var_0, var_1, var_2, var_3, var_4) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 0;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = var_3;
  level.waypointpulses[var_0] = var_4;
}

activate_switch_cooldown() {}

_id_12AEF(var_0) {
  if(!isDefined(self.arena_bot_seek_dropped_weapon))
    self.arena_bot_seek_dropped_weapon = [];

  self.arena_bot_seek_dropped_weapon[self.arena_bot_seek_dropped_weapon.size] = var_0;
}

_id_1229B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  _id_12297();
  level thread _id_12299(level._id_12A12._id_12296);

  if(getdvarint("_encstr_8ED12363506D78B35989671EDE3FC90F0F30BF181FD71695A843F044385FB896C1EB9595EE", 0) == 0) {
    _id_12424("_encstr_A76D26139CF5B3B0B656A3E507567DC916D17D27C236CAD7C2A5273227DE0EEB2D73B17BB5A59BB3");
    wait 20;
  }

  _id_12424("_encstr_91B72E31E4D73B585B2B47E538ACEB272CE8D7932C8D597D98DEB95D37D79DBD8DC8AFC627B03A959BD7ED738DB4B995");
  wait 3.0;
  var_0 = level._id_12A12._id_12296;
  _id_122EE(var_0);
}

_id_12297() {
  level._id_12A12._id_12E2A = spawnStruct();
  level._id_12A12._id_12E2A.aq_playerdisconnect = [];
  level._id_12A12._id_12E2A.are_all_alive_players_touching_plane = [];
  level._id_12A12._id_12E2C.arena_bot_seek_dropped_weapon = scripts\engine\utility::array_randomize(level._id_12A12._id_12E2C.arena_bot_seek_dropped_weapon);
  var_0 = scripts\cp_mp\killstreaks\airdrop::getleveldata("_encstr_A77318E360E304B2B3D01A552B636ADD2EC8263E82FE44CA8F5D");
  var_0.capturecallback = ::_id_12295;
  var_0.timeout = undefined;
}

_id_12299(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    if(!isDefined(level._id_12A12._id_12E2C.arena_bot_seek_dropped_weapon[var_2 + var_1])) {
      return;
    }
    level thread _id_12298(var_2 + var_1);
    wait 2.0;
  }
}

_id_12298(var_0) {
  var_1 = level._id_12A12._id_12E2C.arena_bot_seek_dropped_weapon[var_0];
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_1, "_encstr_8218041DF5FA");
}

_id_1229A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level._id_12A12._id_12296;
  var_1 = level._id_12A12._id_1229C - var_0;
  level thread _id_12299(var_1, var_0);
  wait 20;
  _id_12424("_encstr_91B72E31E4D73B585B2B47E538ACEB272CE8D7932C8D597D98DEB95D37D79DBD8DC8AFC627B03A959BD7ED738DB4B995");
  wait 3.0;
  _id_122EE(var_1, var_0);
}

_id_122EE(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1))
    var_1 = 0;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = level._id_12A12._id_12E2C.arena_bot_seek_dropped_weapon[var_2 + var_1];
    var_4 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_3 + (0, 0, 2000), var_3, (0, randomint(360), 0), "_encstr_A77318E360E304B2B3D01A552B636ADD2EC8263E82FE44CA8F5D");
    level._id_12A12._id_12E2A.aq_playerdisconnect[level._id_12A12._id_12E2A.aq_playerdisconnect.size] = var_4;
    scripts\engine\utility::array_remove(level._id_12A12._id_12E2C.arena_bot_seek_dropped_weapon, var_2);
    wait 2.5;
  }
}

_id_12295(var_0) {
  thread scripts\cp_mp\killstreaks\airdrop::dialog_wait_think_civ(var_0);
  level._id_12A12._id_12E2A.aq_playerdisconnect = scripts\engine\utility::array_remove(level._id_12A12._id_12E2A.aq_playerdisconnect, self);
  showsplashtoteam(var_0.team, "_encstr_974E344C39D73BB0DA95D12F07B27DC916E8D73916C6957D26EDB9D56EAF76B7B146EBC69C0BA359D71BB01CA3579C5632AF58C6632F");
}

activate_laser_shut_down_interaction() {}

_id_13EEE() {
  var_0 = "_encstr_9A19040BCDBC";
  var_1 = level._id_12A12._id_12E2C.ground_detection_think + vectorNormalize(level._id_12A12._id_12E2C._id_136A8["_encstr_8E8405EA382B2A"]) * level._id_12A12._id_12E2C.circle_radius * level._id_12A12._id_12E2C._id_13631["_encstr_8E8405EA382B2A"];
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_8AF71A4B63BFC8B7D302D0A0DA6C9DC32768CF28FE63901B7DBA70E0");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "_encstr_930B07BB1B6B3854FF");
  var_2.lockupdatingicons = 1;
  var_2.team = "_encstr_8E8405EA382B2A";
  level.spawn_set_jugg_value.choosecrouchorstandtac = var_2;
  level.spawn_set_jugg_value.choosecrouchorstandtac thread _id_13EF2();
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_AAD017D28DDE73D7BB582F1CEDA573A3EB86177D95B92B6BBC");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "_encstr_930B07BB1B6B3854FF");
  var_2.lockupdatingicons = 1;
  var_2.team = "_encstr_8E8405EA382B2A";
  level.spawn_set_jugg_value.choosebestpropforkillcam = var_2;
  level.spawn_set_jugg_value.choosebestpropforkillcam thread _id_13EF2();
  var_1 = level._id_12A12._id_12E2C.ground_detection_think + vectorNormalize(level._id_12A12._id_12E2C._id_136A8["_encstr_9A8507BA4040188D08"]) * level._id_12A12._id_12E2C.circle_radius * level._id_12A12._id_12E2C._id_13631["_encstr_9A8507BA4040188D08"];
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_8AF71A4B63BFC8B7D302D0A0DA6C9DC32768CF28FE63901B7DBA70E0");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "_encstr_930B07BB1B6B3854FF");
  var_2.lockupdatingicons = 1;
  var_2.team = "_encstr_9A8507BA4040188D08";
  level.spawn_set_jugg_value.brjugg_cleanupents = var_2;
  level.spawn_set_jugg_value.brjugg_cleanupents thread _id_13EF2();
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_AAD017D28DDE73D7BB582F1CEDA573A3EB86177D95B92B6BBC");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "_encstr_930B07BB1B6B3854FF");
  var_2.lockupdatingicons = 1;
  var_2.team = "_encstr_9A8507BA4040188D08";
  level.spawn_set_jugg_value.briskillstreakallowed = var_2;
  level.spawn_set_jugg_value.briskillstreakallowed thread _id_13EF2();
}

_id_13EF2() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::ter_op(self.team == "_encstr_8E8405EA382B2A", level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);

  if(!isDefined(var_0)) {
    return;
  }
  self.origin = var_0;
  scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, var_0);
}

_id_13EE7() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isai(self)) {
    return;
  }
  if(self.team == "_encstr_9A8507BA4040188D08") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.brjugg_cleanupents.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosebestpropforkillcam.objidnum, self);
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.briskillstreakallowed.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosecrouchorstandtac.objidnum, self);
  }
}

activate_all_targets() {}

relic_steelballs_health_boost() {
  return level._id_12A12._id_12E2C.ground_detection_think;
}

dangercircletick(var_0, var_1) {}

groundz() {
  level.br_level._id_13884 = 1;
  level._id_12A12._id_12E2C = put_objective_on_guy("_encstr_8B1608EC43B8D647A113");
  level.grouptorewards = level._id_12A12._id_12E2C;
  level.br_level.default_class_chosen = [level.grouptorewards];
  var_0 = getdvarint("_encstr_A26D119A30E6465823A63BC34D3B7AC2EA1B0B");
  level.br_level.br_circledelaytimes = [var_0 * 2];
  level.br_level.br_circleclosetimes = [var_0 * 2];
  level.br_level.br_circleradii = [level._id_12A12._id_12E2C.circle_radius, level._id_12A12._id_12E2C.circle_radius];
  level.br_level.br_circleminimapradii = [int(level._id_12A12._id_12E2C.circle_radius / 2)];
  level.br_level.default_player_connect_black_screen = [0];
  level.br_level.default_suicidebomber_combat = [0];
  tank_x1_capacity();

  if(!isDefined(level.br_circle))
    level.br_circle = spawnStruct();

  level.br_circle.circleindex = 0;
  level.br_circle.starttime = gettime();
  level.br_circle.dangercircleent = spawnStruct();
  level.br_circle.dangercircleent.origin = [level._id_12A12._id_12E2C.ground_detection_think[0], level._id_12A12._id_12E2C.ground_detection_think[1], level._id_12A12._id_12E2C.circle_radius];
  level.br_circle.safecircleent = spawnStruct();
  level.br_circle.safecircleent.origin = [level._id_12A12._id_12E2C.ground_detection_think[0], level._id_12A12._id_12E2C.ground_detection_think[1], level._id_12A12._id_12E2C.circle_radius];
  setomnvar("_encstr_A5E615ABE7B176D80F0D70A8341588B769637B017FBB46", level.br_level.br_circleminimapradii[0]);
  var_1 = level.br_level.br_circleradii.size;

  if(isDefined(var_1) && var_1 > 0)
    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::teleport_entities_inside_subway_car(var_1);
}

activatemeleeblood() {}

tank_x1_capacity() {
  level._id_12A12._id_12E2C._id_1365E["_encstr_9A8507BA4040188D08"] = level._id_12A12._id_12E2C._id_13564;
  level._id_12A12._id_12E2C._id_1365E["_encstr_8E8405EA382B2A"] = level._id_12A12._id_12E2C._id_13565;
  level._id_12A12._id_12E2C._id_136A8["_encstr_9A8507BA4040188D08"] = anglesToForward((0, level._id_12A12._id_12E2C._id_134FF, 0));
  level._id_12A12._id_12E2C._id_136A8["_encstr_8E8405EA382B2A"] = anglesToForward((0, level._id_12A12._id_12E2C._id_13500, 0));
  level._id_12A12._id_12E2C._id_13608["_encstr_9A8507BA4040188D08"] = level._id_12A12._id_12E2C._encstr_B84C17674917D3CE61B9155FF058378AFB9D4FA7C9C97ABD58;
  level._id_12A12._id_12E2C._id_13608["_encstr_8E8405EA382B2A"] = level._id_12A12._id_12E2C._encstr_AFC7155B63DFAFED8143E6F74188790F731811E20AA3E7;
  level._id_12A12._id_12E2C._id_13607["_encstr_9A8507BA4040188D08"] = level._id_12A12._id_12E2C._encstr_96AE177BC742E30D394925270BC0A96BAF90392914522C8D23;
  level._id_12A12._id_12E2C._id_13607["_encstr_8E8405EA382B2A"] = level._id_12A12._id_12E2C._encstr_8897156E07B0DD73EB16733BC62BBED6B087AF0B3CD29B;
  level._id_12A12._id_12E2C._id_13631["_encstr_9A8507BA4040188D08"] = level._id_12A12._id_12E2C._encstr_BE7E164708A1E77227ADFC728D7F1AB1280987A340182D6B;
  level._id_12A12._id_12E2C._id_13631["_encstr_8E8405EA382B2A"] = level._id_12A12._id_12E2C._encstr_997B14B9070BDD9B7D232DB947BEADD2B9AF85F05AB9;
  level._id_12A12._id_12E2C._id_13630["_encstr_9A8507BA4040188D08"] = level._id_12A12._id_12E2C._encstr_A99A16DE18EF83ADA13AC810D3497399238F6FD96CB789DF;
  level._id_12A12._id_12E2C._id_13630["_encstr_8E8405EA382B2A"] = level._id_12A12._id_12E2C._encstr_8D5A14370E58BBCDAF465A9B3AEBADC21E7D0B0F4B37;
  level._id_12A12._id_12E2C.spawnorigin["_encstr_9A8507BA4040188D08"] = level._id_12A12._id_12E2C.ground_detection_think + level._id_12A12._id_12E2C._id_136A8["_encstr_9A8507BA4040188D08"] * level._id_12A12._id_12E2C.circle_radius * level._id_12A12._id_12E2C._id_13631["_encstr_9A8507BA4040188D08"];
  level._id_12A12._id_12E2C.spawnorigin["_encstr_8E8405EA382B2A"] = level._id_12A12._id_12E2C.ground_detection_think + level._id_12A12._id_12E2C._id_136A8["_encstr_8E8405EA382B2A"] * level._id_12A12._id_12E2C.circle_radius * level._id_12A12._id_12E2C._id_13631["_encstr_8E8405EA382B2A"];
  level._id_12A12._id_12E2C.passes_final_capsule_check = level._id_12A12._id_12E2C._id_1354F;
  level thread _id_1283F();
}

_id_1283F() {
  level._id_12AB4 = [];
  level._id_12AB4["_encstr_9A8507BA4040188D08"] = [];
  level._id_12AB4["_encstr_8E8405EA382B2A"] = [];
  var_0 = getdvarint("_encstr_AA4D10734EB3876E1511A38AD8136217EA25", 50);
  var_1 = getdvarint("_encstr_A1A31F18B21A37C317EC309ED137696F02EBF0B0FAF9A91BEFE325AFAB5F53C52B", 5);

  while(!isDefined(level.teamnamelist))
    waitframe();

  var_2 = 0;
  var_3 = scripts\mp\teams::_id_132E6();

  foreach(var_5 in level.teamnamelist) {
    if(var_3 && var_5 == "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8") {
      continue;
    }
    for(var_6 = 0; var_6 < var_0; var_6++) {
      var_7 = spawnStruct();
      var_8 = vectortoangles(level._id_12A12._id_12E2C._id_136A8[var_5]);
      var_9 = randomfloatrange(level._id_12A12._id_12E2C._id_13608[var_5], level._id_12A12._id_12E2C._id_13607[var_5]);
      var_10 = anglesToForward((0, var_8[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_9, var_9 * -1), 0));
      var_11 = randomfloatrange(level._id_12A12._id_12E2C._id_13631[var_5], level._id_12A12._id_12E2C._id_13630[var_5]);
      var_12 = level._id_12A12._id_12E2C.ground_detection_think + var_10 * level._id_12A12._id_12E2C.circle_radius * var_11;

      if(istrue(level._id_12A12._id_12E2C.passes_final_capsule_check)) {
        var_13 = level._id_12A12._id_12E2C.spawnorigin[scripts\mp\utility\game::getotherteam(var_5)[0]] - var_12;
        var_8 = vectortoangles(var_13);
      } else
        var_8 = vectortoangles(var_10 * -1);

      var_14 = scripts\engine\trace::create_default_contents(1);
      var_15 = 0;
      var_16 = 0;
      var_17 = 10;
      var_18 = [];

      for(var_19 = 0; var_19 < var_1; var_19++) {
        var_20 = scripts\engine\trace::ray_trace(var_12 + (0, 0, 10000), var_12 - (0, 0, 20000) + anglesToForward(var_8) * var_19 * 2000, undefined, var_14)["_encstr_BD260953AA97E3F014279D"];
        var_18[var_18.size] = var_20;

        if(var_20[2] > var_15) {
          var_15 = var_20[2];
          var_16 = var_19;
        }

        var_2++;

        if(var_2 == 5) {
          waitframe();
          var_2 = 0;
        }
      }

      var_12 = (var_12[0], var_12[1], var_15 + level._id_12A12._id_12E2C._id_1365E[var_5]);
      var_7.origin = var_12;
      var_7._id_13C33 = var_18;
      var_7.spawn_exfil_heli = var_16;
      var_7.angles = var_8;
      var_7.time = gettime();
      var_7.team = var_5;
      var_7.index = -1;
      level._id_12AB4[var_5][level._id_12AB4[var_5].size] = var_7;
    }
  }
}

rear_door_collision() {
  if(!isDefined(self._id_12AB3)) {
    self._id_12AB3 = spawnStruct();
    return ppkteamnoflag();
  }

  if(self._id_12AB3.team != self.team || self._id_12AB3.lifeid != self.lifeid)
    return ppkteamnoflag();

  return self._id_12AB3;
}

ppkteamnoflag() {
  var_0 = randomint(level._id_12AB4[self.team].size);
  var_1 = level._id_12AB4[self.team][var_0];
  self._id_12AB3.origin = var_1.origin;
  self._id_12AB3.angles = var_1.angles;
  self._id_12AB3.time = gettime();
  self._id_12AB3.team = self.team;
  self._id_12AB3.index = -1;
  self._id_12AB3.lifeid = self.lifeid;
  return self._id_12AB3;
}

activate_laser_trap() {}

manage_fakebody_hides() {
  scripts\mp\deathicons::_id_12BFD();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!isDefined(var_1)) {
      continue;
    }
    if(!isalive(var_1))
      var_1 scripts\mp\playerlogic::spawnplayer(0);

    if(istrue(var_1.delay_enter_combat_after_investigating_grenade))
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(var_1);

    var_1 setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
    var_1 setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
    var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
    var_2 = var_1 rear_door_collision();
    var_3 = var_1 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_2);
  }

  level.dmztut_endgametransition = 1;
  wait 2.0;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 thread _id_12496();
  }

  level thread _id_138CC();
  scripts\mp\flags::gameflagset("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  scripts\mp\flags::gameflagset("_encstr_A2D20FE4880D52A426C867576878654BD3");
  waitframe();

  if(isDefined(level.br_pickups))
    _encstr_BE0E1CDFFB2A843017D61BB67A1CD0B0D237557F43724E8845AD23C9E2EB();
  else {}

  _id_13514();
  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 4);
}

_id_138CC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 10;
  level thread scripts\mp\music_and_dialog::stopsuspensemusic();
}

_id_12496() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264C();
  self._id_133E7 = 1;
  self._id_12CA8 = 1;
  self.plotarmor = 1;

  if(!isalive(self))
    scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  waitframe();
  thread patch_far_wait();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  self.plotarmor = undefined;
  self._id_12CA8 = undefined;
  self.elevator_manager = 1;
  self freezecontrols(1);
  self playerhide();
  thread _id_12495();
}

patch_far_wait() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
}

_id_12495() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\cp_mp\execution::_clearexecution();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();
  var_0 = rear_door_collision();
  var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagwinnerrespawn(1, undefined, var_0, 1, var_1, 1, undefined, undefined, undefined, 1);

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  scripts\mp\damage::resetplayervariables();
  waittillframeend;
  self clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3", 1);
  self._id_133E7 = 0;
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in();
  thread _id_13EE7();
  thread init_infil();
  self notify("_encstr_97FC14C8B7EB77CA8D6CB76BACF5B91C8D85DC3459CD");
}

_encstr_82A91C89B6A10732F5919387ED884A68A0BBBE0E4BF8CF6AD8B9F7AFCB4E() {}

_encstr_ADA01EA053816B5FDBCD75F0A7E24D76F65710C0EF2EC6C763B7EE86FCCABB3B() {
  var_0 = "_encstr_961F1027C76B12F866F85BDF981BAC8B07D0";
  var_1 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C(var_0);

  if(level._encstr_A28B1623D2DC8589362B38B1D5DC32B22789C237AD4BCD9D)
    var_1._id_14068 = ::_encstr_81EF3BC1C6D57391599C7D27561CEDE62D8EDEE4E5383685CB56C907D85DB932954ECACE2BE647D8C28D1B980B36B5F59D0BD5D8473A9C1637DC995939;
}

_encstr_8C81288F091EA77ACB3154CEA8C9732503A1CBEFE8B0C0D211405F1E0DB57AEB2B885FBBD9C807FA6366() {}

_encstr_A2A71CE336FFD3DF7AAAD808C2D77D4E13A5F96BAFBFDBE3A27320A0CA6A() {
  if(level._encstr_99081DB05B2BA0FF0FE5B19241D8F6260310D2EDC0F828B2C5483AA2095F3C) {
    var_0[0] = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_8A5110B3A5B5B0F59A1B492B5B62C70B7C6A");
    var_0[1] = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_A65110D9546B401DBF0314B9CAA7CFE0C7E2");
    var_0[2] = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_B4AB16DF8A20F26AC6994BF781FB4359081715A320F8AD93");
    var_0[3] = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C("_encstr_B4F91169D8BC587FE20B7123436A3F1844BE77");

    foreach(var_2 in var_0) {
      if(level._encstr_A28B1623D2DC8589362B38B1D5DC32B22789C237AD4BCD9D) {
        var_2._id_14077 = 2;
        var_2._id_14068 = ::_encstr_81EF3BC1C6D57391599C7D27561CEDE62D8EDEE4E5383685CB56C907D85DB932954ECACE2BE647D8C28D1B980B36B5F59D0BD5D8473A9C1637DC995939;
      }

      var_2._id_13ACC = 1;
    }

    var_4 = easepower("_encstr_A1EB22D00BAC5067F3799FA9CB6A49D91A2760F8FB6A29379B9C18A0A9539BA3758F523A", scripts\common\utility::groundpos(level.spawn_set_jugg_value._encstr_BECB14E3F58580C5AACBB7C18FE29BB8294F8E7B5DEB), level.spawn_set_jugg_value._encstr_93CB1403A06BA68A1BEE09FC5D219260310847CF2881);
    var_4.audio_shf_kill_hangar_lights = "_encstr_930B07BB1B6B3854FF";
    var_4.audio_jugg_spawn = "_encstr_B43F0E4671B87173BD8FD73315553AA4";
    var_4.load_relics_from_playlistdvars = "_encstr_BE8B08E323FB2BCD6268";
    var_4.little_bird_onexitheavydamagestate = "_encstr_BE8B08E323FB2BCD6268";
    var_5[0] = var_4;
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1314B(var_5);
  }
}

_encstr_92FA24F92F4951F58BDD23C26EE81BA045F00210F2DFD3A386859998531FC557D9A1DFDFB419() {}

_encstr_81EF3BC1C6D57391599C7D27561CEDE62D8EDEE4E5383685CB56C907D85DB932954ECACE2BE647D8C28D1B980B36B5F59D0BD5D8473A9C1637DC995939(var_0, var_1, var_2) {
  var_2 = _encstr_A9FB298C677B87195D978868C357912F020A7385FFB353A03F3F30183B81A97BCB30E09893BA2D69E9EB50(var_0, var_2);
  var_3 = run_died_poorly_funcs(var_1.team);
  var_4 = _encstr_8E0C1C947F639F1374C778206F8289079B259530178A8DBE309B183077BA(var_3.plunder, var_1);
  _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1279F(var_3, var_1, var_2);
  var_5 = _encstr_8E0C1C947F639F1374C778206F8289079B259530178A8DBE309B183077BA(var_3.plunder, var_1);
  var_6 = var_5 - var_4;
  _encstr_92811CA9F549BFE663C8FB42382F9BC786673C3518919F6A5FC093BB889B(var_0, var_1, var_6);
}

_encstr_AB64269CD90B3907E422E8F85B312F317768118731CF233FCC4A39583253F5C9F7F2300F92CB09BB(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_4, var_3 in var_0) {
      if(isDefined(var_3.player) && var_3.player == var_1)
        return var_4;
    }
  }

  return undefined;
}

_encstr_8E0C1C947F639F1374C778206F8289079B259530178A8DBE309B183077BA(var_0, var_1) {
  if(isDefined(var_0)) {
    foreach(var_4, var_3 in var_0) {
      if(isDefined(var_3.player) && var_3.player == var_1)
        return var_3.plundercount;
    }
  }

  return 0;
}

_encstr_A9FB298C677B87195D978868C357912F020A7385FFB353A03F3F30183B81A97BCB30E09893BA2D69E9EB50(var_0, var_1) {
  var_2 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1278C(var_0._id_127C8);

  if(isDefined(var_2.get_closest_enemy_near_turret) && var_2.get_closest_enemy_near_turret > 0) {
    var_3 = 0;

    if(isDefined(var_0.plunder)) {
      foreach(var_5 in var_0.plunder)
      var_3 = var_3 + var_5.plundercount;
    }

    var_7 = var_2.get_closest_enemy_near_turret - var_3;

    if(var_1 >= var_7) {
      var_1 = var_7;
      _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12799(var_0);
    }
  }

  return var_1;
}

_encstr_92811CA9F549BFE663C8FB42382F9BC786673C3518919F6A5FC093BB889B(var_0, var_1, var_2) {
  if(!isDefined(var_0.plunder))
    var_0.plunder = [];

  var_3 = _encstr_AB64269CD90B3907E422E8F85B312F317768118731CF233FCC4A39583253F5C9F7F2300F92CB09BB(var_0.plunder, var_1);

  if(isDefined(var_3))
    var_0.plunder[var_3].plundercount = var_0.plunder[var_3].plundercount + var_2;
  else {
    var_4 = spawnStruct();
    var_4.player = var_1;
    var_4.team = var_1.team;
    var_4.plundercount = var_2;
    var_0.plunder[var_0.plunder.size] = var_4;
  }
}

activate_emp_drone_func() {}

subscribedlocale() {
  thread issidehouseobjective();
  thread _encstr_91C73A19AC31AE3BEBEE583AB10D7D99EDC97D9C2C8EBEE416D8CAEB07392D9B47FAB5581DC60DF5D23733EDF58EDBF5B1BDCD9BEDB1CAD7239D8527();
}

issidehouseobjective() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = "_encstr_979440871286A1669BB9A911E2BF25D81A9D573DA9AB59B6FF52E1DE2BC3577035CF9D9B5854F0F1378999C023A71D300F5A0B17F63FC9446FD350C8BB63D84065A5";
  var_1 = "_encstr_B40101";
  setDvar(var_0, var_1);

  for(;;) {
    if(getDvar(var_0, var_1) != var_1) {
      foreach(var_3 in level.players) {
        if(!scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_playercanusevehicles(var_3)) {
          continue;
        }
        var_4 = var_3.origin + (300, 300, 100);
        var_5 = var_3.angles * (0, 1, 0);
        var_6 = spawnStruct();
        var_6.origin = var_4;
        var_6.angles = var_5;
        var_6.owner = var_3;
        var_6.spawntype = "_encstr_A390072B07566805D8";
        var_6.immediate = 1;
        var_7 = _calloutmarkerping_predicted_isanypingactive::_id_120C1(var_6);
      }

      setDvar(var_0, var_1);
    }

    wait 1;
  }
}

_encstr_91C73A19AC31AE3BEBEE583AB10D7D99EDC97D9C2C8EBEE416D8CAEB07392D9B47FAB5581DC60DF5D23733EDF58EDBF5B1BDCD9BEDB1CAD7239D8527() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = "_encstr_82A735B00BF68F79F31FF4FF35F7E38B9AC25920D2CB57B3974B8DF87043881DC30970301BA6712E4F7E04E8D76330B7EE92E058023D93";
  var_1 = "_encstr_B40101";
  setDvar(var_0, var_1);

  for(;;) {
    if(getDvar(var_0, var_1) != var_1) {
      _encstr_8AA425B3A674F93E1A9FD39FEB138B382CB1D8A98BCBF8607243DDF73F1BC069D3152063F53C58();
      setDvar(var_0, var_1);
    }

    wait 1;
  }
}

init_infil() {
  if(!isDefined(self) || isai(self)) {
    return;
  }
  var_0 = spawnStruct();
  var_0.player = self;
  var_1 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.2);
  var_1 scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", 0, 80);
  var_1.color = (1, 1, 1);
  var_1.alpha = 0;
  var_1.hidewheninmenu = 1;
  var_1.label = &"_encstr_927B3453FDF87111E9AEAA6645093709D95BDBC34B8669CB793754F91C51A4318D036F7F972F1083C1DD5BF195D9FBF8E089D79309FD";
  var_0._id_121D8 = var_1;
  var_2 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.2);
  var_2 scripts\mp\hud_util::setparent(var_1);
  var_2 scripts\mp\hud_util::setpoint("_encstr_865709ED15C16594FF9309", "_encstr_AC190439DF9A", -50, 0);
  var_2.color = (0, 0, 1);
  var_2.alpha = 0;
  var_2.hidewheninmenu = 1;
  var_0.playersetattractionextradata = var_2;
  var_2 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.2);
  var_2 scripts\mp\hud_util::setparent(var_1);
  var_2 scripts\mp\hud_util::setpoint("_encstr_AF9F08DB601069806D49", "_encstr_AC190439DF9A", 50, 0);
  var_2.color = (1, 0, 0);
  var_2.alpha = 0;
  var_2.hidewheninmenu = 1;
  var_0.nuke_abortkillcamonspawn = var_2;
  level._id_12A12._id_12482[level._id_12A12._id_12482.size] = var_0;
}

_id_13FA8() {
  while(!level.gameended) {
    if(isDefined(level._id_12A12._id_12482)) {
      var_0 = getdvarint("_encstr_A3E7234B486839BE29A33640F19E109EAF88D5A8CF58BBB1FCFBE6E3EF0837131E63B10F95", 1);
      var_1 = [];

      for(var_2 = 0; var_2 < level._id_12A12._id_12482.size; var_2++) {
        var_3 = level._id_12A12._id_12482[var_2];
        var_4 = var_3.player;

        if(!isDefined(var_4)) {
          var_1[var_1.size] = var_3;
          continue;
        }

        if(isDefined(var_3._id_121D8))
          var_3._id_121D8.alpha = scripts\engine\utility::ter_op(var_0, 1, 0);

        if(isDefined(var_3.playersetattractionextradata)) {
          var_3.playersetattractionextradata _id_13FA9(rpg_shoot_at_trigs(var_4.team) * 100);
          var_3.playersetattractionextradata.alpha = scripts\engine\utility::ter_op(var_0, 1, 0);
        }

        if(isDefined(var_3.nuke_abortkillcamonspawn)) {
          var_5 = scripts\mp\utility\teams::getenemyteams(var_4.team);

          for(var_6 = 0; var_6 < var_5.size; var_6++) {
            if(!level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_5[var_6])) {
              var_3.nuke_abortkillcamonspawn _id_13FA9(rpg_shoot_at_trigs(var_5[var_6]) * 100);
              var_3.nuke_abortkillcamonspawn.alpha = scripts\engine\utility::ter_op(var_0, 1, 0);
              break;
            }
          }
        }
      }

      for(var_2 = 0; var_2 < var_1.size; var_2++) {
        if(isDefined(var_1[var_2]))
          var_1[var_2] handledropbags();
      }

      level._id_12A12._id_12482 = scripts\engine\utility::array_remove_array(level._id_12A12._id_12482, var_1);
    }

    waitframe();
  }

  if(isDefined(level._id_12A12._id_12482)) {
    for(var_2 = 0; var_2 < level._id_12A12._id_12482.size; var_2++) {
      if(isDefined(level._id_12A12._id_12482[var_2]))
        level._id_12A12._id_12482[var_2] handledropbags();
    }

    level._id_12A12._id_12482 = undefined;
  }
}

_id_13FA9(var_0) {
  var_1 = 1000000;
  var_2 = 1000;

  if(var_0 >= var_1) {
    var_3 = var_0 / var_1;
    self.label = &"_encstr_9B8D293682E1B5255C7F69F9E7A5306978FBB8AD2F49E72D71574111F3ED153FF0D588A1B4C43954170B91";
    self setvalue(var_3);
  } else if(var_0 >= var_2) {
    var_3 = var_0 / var_2;
    self.label = &"_encstr_BE5A2AF602193A3053A7818B270958A1EC5FE8C9C111B11D4709BCD683770599C73328FD016F9BBAADB5332E";
    self setvalue(var_3);
  } else {
    self.label = &"_encstr_A3F01DCC611F7EC98119D5CF797D09801F796797D8B78D696A24FBA5645779";
    self setvalue(var_0);
  }
}

handledropbags() {
  if(isDefined(self._id_121D8))
    self._id_121D8 scripts\mp\hud_util::destroyelem();

  if(isDefined(self.playersetattractionextradata))
    self.playersetattractionextradata scripts\mp\hud_util::destroyelem();

  if(isDefined(self.nuke_abortkillcamonspawn))
    self.nuke_abortkillcamonspawn scripts\mp\hud_util::destroyelem();
}

_encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314(var_0, var_1) {
  var_2 = "_encstr_B40101" + var_0 + "_encstr_AC0703C532";

  if(isDefined(var_1))
    var_2 = var_2 + var_1;
  else
    var_2 = var_2 + "_encstr_8C500ABA9B23CACC2D37AC8C";

  return var_2;
}

_encstr_955E1D42990D47E74893350787C82E533D76EAEA81656FD180D93A09A5A872() {
  var_0 = spawnStruct();
  var_0._encstr_8E370ECB79D210BED3EA7B41227F7660 = _encstr_9718146C358311C870B7D221375157B96BE7D9F36221();
  var_0._encstr_A7010E04FD5B9FE7434ABBE8E8AF9B1C = _encstr_B419143B95A3BEA395586B7D3747581D59D78D2DB9D1();
  var_0._encstr_863810A9FB5AF3782A82EB416BE5E8239363 = _encstr_81F216FF632BD76B1D9693DDFD37D373A1E34181A00977A3();
  var_0._encstr_97321B308DC56ECCD52BE30F03207B43B1089260676DC7A0C5409893B3 = _encstr_841622F75B30415BA90B4AF211FEAF42C019676BFB9895ABCB6693FBF9D59FF120B3F3D4();
  return var_0;
}

_encstr_BA302147EB80F1EB199BDA02E16E1F37C843F6DC07688033B5F6227B8EC64B2A982D77(var_0) {
  switch (var_0) {
    case 1:
      return "_encstr_A31C07A04AD02DAAA0";
    case 2:
      return "_encstr_8EA808B17D2249860F61";
    case 3:
      return "_encstr_9A9B05DB23D51C";
    case 4:
      return "_encstr_82AD054DB4C11D";
    case 5:
      return "_encstr_A5860D8058B62731C16FA177960BB1";
    case 6:
      return "_encstr_8C910DB94DA9137ED49F01013F21D7";
    case 7:
      return "_encstr_8F8C11E9158B681AE1894FEFB98133CC5488A8";
    case 8:
      return "_encstr_B1AD06FFC9DD903B";
    case 0:
      return "_encstr_8BBA05087F0B9D";
  }

  return "_encstr_BDEE0A5B38C7F277F350AA92" + var_0 + "_encstr_824C0266";
}

_encstr_9718146C358311C870B7D221375157B96BE7D9F36221() {
  var_0 = [];
  var_0[var_0.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_84EF055138A18F", gettime());
  var_0[var_0.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_8856063588FB5D97", gettime() / level.frameduration);

  if(isDefined(level.disable_super_in_turret))
    var_0[var_0.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_ACAF1BD3FF53F718E062236F579D2F1868B061F553418BDBC4FDA1B6CB", level.disable_super_in_turret.player_enemy_cooldown);

  var_0[var_0.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_A73C19235BB4DAE4F250ED34EB1031829CFBA3B32BD0A29480B925", level.time_before_shoot);
  var_1 = [];
  var_1["_encstr_B40101"] = [];
  var_1["_encstr_B40101"][0] = var_0;
  return var_1;
}

_encstr_B419143B95A3BEA395586B7D3747581D59D78D2DB9D1() {
  var_0 = [];

  if(!isDefined(level.teamnamelist))
    return var_0;

  foreach(var_2 in level.teamnamelist) {
    var_3 = [];
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_8AEF05452BC2D6", var_2);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_B2FE13B1F939A5477661028A28D57A0E1261106011", game["_encstr_85920F9B354B5AC018902F3FD811A69307"][var_2]);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_ACA11374279F0A2F0B60D2DA62695886D18FA6B6DF", game["_encstr_96040B1D59B0AD35B1F64E599B"][var_2]);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_A19613191F03BB5BDDD8A2CB411396773F10ECE941", level.teamdata[var_2]["_encstr_813D11B9340B207DDF63B7993A973D70E39139"]);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_9A3E139EF98F72C5D829C70AA4F03C3A678F8F97C9", level.teamdata[var_2]["_encstr_99F2110E8DD57346954E4AB98895077BB94BD1"]);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_BECE130457A98A259878F7A36151E6226B9DB6C6CF", level.teamdata[var_2]["_encstr_B4C60E6133D3B0A8F50AD58935D3E8FD"]);
    var_4 = run_died_poorly_funcs(var_2);

    if(!isDefined(var_4))
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_AF3513B9BF672FFB7938968E823966E25157180807", "_encstr_8C500ABA9B23CACC2D37AC8C");
    else
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_AF3513B9BF672FFB7938968E823966E25157180807", var_4._id_127BD);

    var_5 = scripts\mp\utility\teams::getfriendlyplayers(var_2);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_ADFF0A642023D18E50BD2A37", var_5.size);

    foreach(var_7 in var_5)
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_B23408F9E3F2657F49A9", var_7.name);

    if(!isDefined(var_0[var_2]))
      var_0[var_2] = [];

    var_0[var_2][var_0[var_2].size] = var_3;
  }

  return var_0;
}

_encstr_81F216FF632BD76B1D9693DDFD37D373A1E34181A00977A3() {
  var_0 = [];

  if(!isDefined(level.players))
    return var_0;

  foreach(var_2 in level.players) {
    var_3 = [];
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_8BB007A03658CBCAE4", var_2.name);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_A23010A3328306C0B29FC9D1D6C8F2EF0E9A", var_2.score);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_B445109B366BE3134D58D93911EE4712C04A", var_2.team);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_9151100450A3FE99ABC7FBDB992F37FB1540", var_2.br_cash_count);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_86B910E4CEB8A875324B2B0D7BEA30484537", var_2.plunderbanked);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_A7711048080736BA37462BC936F6D5B94780", var_2.plundercount);
    var_4 = [];

    if(isDefined(var_2._id_127B9)) {
      foreach(var_6 in getarraykeys(var_2._id_127B9)) {
        if(!isDefined(var_4[var_6]))
          var_4[var_6] = spawnStruct();

        var_4[var_6]._id_127B9 = var_2._id_127B9[var_6];
      }
    }

    if(isDefined(var_2._id_127B8)) {
      foreach(var_6 in getarraykeys(var_2._id_127B8)) {
        if(!isDefined(var_4[var_6]))
          var_4[var_6] = spawnStruct();

        var_4[var_6]._id_127B8 = var_2._id_127B8[var_6];
      }
    }

    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_966910FCD690805D0A6333E51F73AD584C9A", var_4.size);

    foreach(var_6 in getarraykeys(var_4)) {
      var_11 = var_4[var_6];

      if(!isDefined(var_11._id_127B9))
        var_11._id_127B9 = "_encstr_8C500ABA9B23CACC2D37AC8C";

      if(!isDefined(var_11._id_127B8))
        var_11._id_127B8 = "_encstr_8C500ABA9B23CACC2D37AC8C";

      var_12 = "_encstr_B44C020E" + var_11._id_127B9 + "_encstr_B117040B4051" + var_11._id_127B8 + "_encstr_BE0703F5EF" + _encstr_BA302147EB80F1EB199BDA02E16E1F37C843F6DC07688033B5F6227B8EC64B2A982D77(var_6);
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_8318042B1E0A", var_12);
    }

    var_3[var_3.size] = "_encstr_B40101";

    if(!isDefined(var_0[var_2.team]))
      var_0[var_2.team] = [];

    var_0[var_2.team][var_0[var_2.team].size] = var_3;
  }

  return var_0;
}

_encstr_841622F75B30415BA90B4AF211FEAF42C019676BFB9895ABCB6693FBF9D59FF120B3F3D4() {
  var_0 = [];

  if(!isDefined(level._id_127C7))
    return var_0;

  foreach(var_2 in level._id_127C7.instances) {
    var_3 = [];
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_B1FB0B8303FF32B3F03B753AB2", var_2._id_127C8);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_B445109B366BE3134D58D93911EE4712C04A", var_2.team);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_AB1310840494118010404010800210101004", var_2._id_127BD);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_9A7E10DCD1703075E6919BB814D0C5772BD6", var_2._id_127D0);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_97C71094BEC8D805225B1B3D37DB47107C47", var_2._id_127D3);
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_92AF0FF4876BC5094B153B1F486F6862C1", var_2._id_126BE.size);

    foreach(var_5 in var_2._id_126BE)
    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_A3FD0AD13C51A7B0C1E90593", var_5.name);

    var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_85290A8408C11BBACD8C2B4E", var_2.plunder.size);

    foreach(var_8 in var_2.plunder) {
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_A3FD0AD13C51A7B0C1E90593", var_8.player.name);
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_8F73111C7C13785379A3FBABFB1E2A7FA838FB", var_8.plundercount);
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_99ED11B436D4D16DD1CFA3363AB1AAD20929D9", var_8.team);
    }

    if(!isDefined(var_2._id_127B1))
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_95161A6B2ECACC5FBBFF1F5A8FF703552DDF7F60AA38190E30C215BE", 0);
    else {
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_95161A6B2ECACC5FBBFF1F5A8FF703552DDF7F60AA38190E30C215BE", var_2._id_127B1.size);

      foreach(var_5 in var_2._id_127B1)
      var_3[var_3.size] = _encstr_912321063811B00187907A022A7F6BC8DB7927DA1D18818367315D78F70B1B43109314("_encstr_A3FD0AD13C51A7B0C1E90593", var_5.name);
    }

    var_3[var_3.size] = "_encstr_B40101";

    if(isDefined(var_2.team))
      var_12 = var_2.team;
    else
      var_12 = "_encstr_8C500ABA9B23CACC2D37AC8C";

    if(!isDefined(var_0[var_12]))
      var_0[var_12] = [];

    var_0[var_12][var_0[var_12].size] = var_3;
  }

  return var_0;
}

_encstr_9A79210EE44B9B47BE9D0B5B2BBEB93A0B8E59AF1BD2CD47BE47DBF58DDBDCCDDB3659(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_4 = 0;

    foreach(var_6 in var_3) {
      foreach(var_8 in var_6) {}
    }
  }
}

_encstr_8AA425B3A674F93E1A9FD39FEB138B382CB1D8A98BCBF8607243DDF73F1BC069D3152063F53C58() {
  var_0 = _encstr_955E1D42990D47E74893350787C82E533D76EAEA81656FD180D93A09A5A872();
  _encstr_9A79210EE44B9B47BE9D0B5B2BBEB93A0B8E59AF1BD2CD47BE47DBF58DDBDCCDDB3659(var_0._encstr_8E370ECB79D210BED3EA7B41227F7660, "_encstr_B6A2056AD237D8");
  _encstr_9A79210EE44B9B47BE9D0B5B2BBEB93A0B8E59AF1BD2CD47BE47DBF58DDBDCCDDB3659(var_0._encstr_A7010E04FD5B9FE7434ABBE8E8AF9B1C, "_encstr_8AEF05452BC2D6");
  _encstr_9A79210EE44B9B47BE9D0B5B2BBEB93A0B8E59AF1BD2CD47BE47DBF58DDBDCCDDB3659(var_0._encstr_863810A9FB5AF3782A82EB416BE5E8239363, "_encstr_8BB007A03658CBCAE4");
  _encstr_9A79210EE44B9B47BE9D0B5B2BBEB93A0B8E59AF1BD2CD47BE47DBF58DDBDCCDDB3659(var_0._encstr_97321B308DC56ECCD52BE30F03207B43B1089260676DC7A0C5409893B3, "_encstr_83A20882C6EA378C2B93");
}