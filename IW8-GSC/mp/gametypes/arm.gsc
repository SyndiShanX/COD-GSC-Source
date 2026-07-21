/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\arm.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0[0] = scripts\mp\utility\game::getgametype();
  var_0[1] = "_encstr_A11904E823B6";
  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 2400);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  setDvar("_encstr_8C811F3FE8BBA78AC3B157C1A6C922378040EFCFA0D3D13115D6DD850D89FAE609", 0);
  setDvar("_encstr_B879157F1AB2C8CA4AA967EFFE6D3A07F3533C3AC16947", 1);
  setDvar("_encstr_8A6F1BB9C627BEC9EACD632B0B9BD7DA2C0FBEA3563643B92D36B08DE6", 30);
  setDvar("_encstr_87EF136FB8EBF7BA6981651B6035B298D010ABBFA0", 1);
  setDvar("_encstr_A1380B2B3997F897F9537F623B", 0);
  setomnvar("_encstr_85511125C469453BFDF7A07BC737918952EF9E", 5);
  updategametypedvars();
  level.scoreperplayer = undefined;
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.onrespawndelay = ::getrespawndelay;
  level.onnormaldeath = ::onnormaldeath;
  level._id_12065 = ::_id_12065;
  level._id_125F1 = ::_id_125F1;
  level.onobjectivecomplete = _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::onflagcapture;
  level.updatefobspawnselection = ::updatefobspawnselection;
  level.lastcaptime = gettime();
  level.alliescapturing = [];
  level.axiscapturing = [];
  level.lastcaptureteam = undefined;
  level.previousclosespawnent = undefined;
  level.promode = 1;
  level._id_12C49 = 1;
  level.requiredplayercount["_encstr_9A8507BA4040188D08"] = 24;
  level.requiredplayercount["_encstr_8E8405EA382B2A"] = 24;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_BDBC137616B556E897C1ACD7EC4EB7AB738CDD859C";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_96050CDCD839EB46B4560D58938C"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_B21804C8D0D7" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_95B909F7CB45A81F58EF63"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] + "_encstr_824305B93705A7";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A9341086475D6B710127AD68ED4042EFC908";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A9341086475D6B710127AD68ED4042EFC908";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32"] = "_encstr_83CF0EDB26357D46B2CD47C9DB2FAC32";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_96150D4AF18ABF1EC031AC950DD8E7"] = "_encstr_96150D4AF18ABF1EC031AC950DD8E7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7270B37CAC6BA4E96CD76BE2C"] = "_encstr_A7270B37CAC6BA4E96CD76BE2C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB270BF3CD11AFEAA31812A940"] = "_encstr_AB270BF3CD11AFEAA31812A940";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99270B0B3F0BC056E2C34F371F"] = "_encstr_99270B0B3F0BC056E2C34F371F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91270B68A22E13B3A766BCB844"] = "_encstr_91270B68A22E13B3A766BCB844";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8F270B380596131AEB68C8A788"] = "_encstr_8F270B380596131AEB68C8A788";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7010A03FD5FFFE3521A09C8"] = "_encstr_A7010A03FD5FFFE3521A09C8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B010A0FFD30CD6AE50956EB"] = "_encstr_9B010A0FFD30CD6AE50956EB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99010A734743881E7AA38787"] = "_encstr_99010A734743881E7AA38787";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B010A9BC5CF20CDF9FAE19D"] = "_encstr_8B010A9BC5CF20CDF9FAE19D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83010ACD591B5DC959C87D56"] = "_encstr_83010ACD591B5DC959C87D56";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BDC098D7BCD96DC76FA2C"] = "_encstr_9BDC098D7BCD96DC76FA2C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83DC0901B70A98F85731F1"] = "_encstr_83DC0901B70A98F85731F1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BDC0955A0D021A28C87BF"] = "_encstr_8BDC0955A0D021A28C87BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93DC09C6F637B437CEEB19"] = "_encstr_93DC09C6F637B437CEEB19";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A1DC0929273333A5D46689"] = "_encstr_A1DC0929273333A5D46689";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD68071BF6B9A3BE0B"] = "_encstr_AD68071BF6B9A3BE0B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_976807690FAFEBD7F6"] = "_encstr_976807690FAFEBD7F6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA68071BD0C3C4417F"] = "_encstr_AA68071BD0C3C4417F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A66807089AB2999EEB"] = "_encstr_A66807089AB2999EEB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B26807A5E0B3C99E27"] = "_encstr_B26807A5E0B3C99E27";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_87DE09C6F6CDD1D7C21B8D"] = "_encstr_8CC614AFA733EA82D5BE6CA57961A80533B86897A391";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9ACF0B721D77E3CA11394F63B8"] = "_encstr_ADEB153721758558B118E452917348D0D33C50409BBE91";
  level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"] = loadfx("_encstr_A11629ECCC3C5EEB39958BD52BB9A3DCBCAD83BE9D0BD6561C63B0E579673387D7DCB5B5AFDC2D3B372C1B");
  level._effect["_encstr_9BA412D0FB18B6BF8294E8866C5AFD396487D048"] = loadfx("_encstr_862E2CC36C9196372358BF57A0FBD49BE771CA3144CBCA554B38F76FDA73BE73AF9615B42057429FD048DBEF80AB");
  level._effect["_encstr_A14018B3CCF0AFCDE60B3A8DA17D5836139981F51B8DDEBA23DC"] = loadfx("_encstr_BE60307395D360F780CF51EFAA6A5FB9F0E11568D457A27E9B2B593F281A55B602C7F01757AA77F7BFD9373D7AB640FC9DE8");
  level._effect["_encstr_AC091A5D2B3318A8B211E018478190503AABF7D3DBA9D698EA754850"] = loadfx("_encstr_A18D38EC66C3CB5ADD077D4C3979B3B05BCA0ED8582F5E4BE666966379D9CC3CAF2693BE5A9B662DC6AFC6637B5D8CD7378DC9DED8B15CB3990F");
  level._effect["_encstr_BE771BE3B1B8275256D7C7E39DF3FA6F70BB5DEA0E48AD5A224B17925B"] = loadfx("_encstr_AA7B39CC7D8896271F58AE16FD3892875AB138AA071360AC8AF8B13ACEF808D9998AAD0F33DE77A3196EAA8B38EA0FA84AAFFC71581181B0438E83");
  level._effect["_encstr_83BE1A3E744A3FA6DDC9BAC228C31D87A065BDB0AF732FAA81B1370F"] = loadfx("_encstr_AB7D385E142A9E44F7D2F92268AF3F5F600DC0CC3F52D60C9D18823A9A2537739E664A4743182BD4B1B9BAA3A041A1973056B0CF470B425B5D98");
  level._effect["_encstr_9BBE1A1EA5A8B9FB4E96126A592B1B61903B8D80BFA87CF7778E7FB7"] = loadfx("_encstr_AA9138CE33F0CB4BEE1CBE899CCB760B5B95E01BC25EF2967366D28D979D333CD72627F5B49BCC5AD8D753AB5B0EBEEED2CD83F58123C5EC663C");
  level._effect["_encstr_8C66180BA22310A82AEF7B7DFED4E0D8D78A8010D9ABB3C8C4BC"] = loadfx("_encstr_9B5E3694372BF788D77A69984B5781A3821F0F114E93AFF0A62BD0E0D626F9E90946863024BAF5389CB7D810EB41160932AF732D6DD34D42");
  level._effect["_encstr_A78918D999E1F52627FA4B37332D1BEB3707DE3ABE364BCE1A1D"] = loadfx("_encstr_AB8136C3699B16F408C99FAA35A23F7749A11BEA11F3DE2CF86DD1BCB7B087DBF839B341F8C083646337C3A8DF8881331B318A7BA8A44B18");
  level.nukeselectactive = getdvarint("_encstr_837419DC1BE4FAC2E4DABECDAE5BB2D4ACB1958D3A14D83A96ECAC", 0);
  level.killstoearnnukeselect = getdvarint("_encstr_ADB51E3F57FB70E89AB51E905C7C789E71FFDBA3BB62B0ABAB8F87A9055D4855", 7);
  level.useobjectives = getdvarint("_encstr_8C3B167EAB0326134A0A1940C3A797598B558E7509AB297F", 1);
  level.userallypointvehicles = getdvarint("_encstr_8D841B4B568A1F883A113EF072411B4A407FB1B8E36772F370BEF82B3E", 1);
  level.hideenemyhq = getdvarint("_encstr_84D2141B30CDF1A753A14F604B797F8F0DE86233D123", 0);
  level.hideenemyfobs = getdvarint("_encstr_952716628733898163E2312B5BEF9FDF5D555BFBE5C72EA3", 0);
  level.disablelittlebirdrally = getdvarint("_encstr_B8711FD753B2D197EBCAFE8192375FF0CDAD217BEC9B10ED43A25389C95781F820", 1);
  level.completelyremovelittlebird = getdvarint("_encstr_B8FC2390877AEEC3DBAD405605022930D573B8E09732E1E3D29345F99CEB79F83D3350684B", 0);
  level.move_spawnpoints_to_valid_positions = getdvarint("_encstr_A53A1BCFC7C609996040318718C0A27215012FAB81611272504BF78555", 0);
  level.usec130spawn = getdvarint("_encstr_8B4E1637C627F5C239D6F5EAB9AC684C6606A93885DD9BDC", 0);
  level.usec130spawnfirstonly = getdvarint("_encstr_97031BC7CF3EF1616858393EFB4AF88997634F3BFDEB6B4B80E46DC5EA", 0);
  level.c130movementmethod = getdvarint("_encstr_ACC413C3198507E12D2B414F6B3A7B7F4FB881EDAD", 0);
  level.c130flightdist = getdvarfloat("_encstr_965E17E63639FAC29C5BAFB1C4CC0319364BD9A1E8225ADCA3", 4000);
  level.c130distapart = getdvarfloat("_encstr_B4F416E68D277DC227B5FAB189668111D29B47280E0BE48E", 5000);
  level.c130alignedtolocale = getdvarfloat("_encstr_B1F31CD0C73AAE831B6D8096522769D59C47E8B027C407A7A09586AF1DBA", 1);
  level.dropbrloot = getdvarint("_encstr_B28913ABDFC219DBD35DF02995DF9163A119EA2043", 0);
  level.spawnselectionshowenemy = getdvarint("_encstr_87E61C37C6937DDC38C2EEDCA6561B2B8DE84BBDDC4D34DBEE8AB9566BBC", 0);
  level.spawnselectionshowfriendly = getdvarint("_encstr_84841FD7DF2EE1638829236D87C8B49A0E59072F5DC6DA2788D59AB479C8C442DB", 0);
  level.usesquadleader = getdvarint("_encstr_A37617373693FA164EB6BEABDC569AC5EA2C919856B091CA4E", 1);
  level.spawnsquadleaderonly = getdvarint("_encstr_81D91DCD6C39F58527D6BE6EE02CBBDC352EEA2CC898598546ACE47AB9D897", 0);
  level.usestaticspawnselectioncamera = getdvarint("_encstr_B6541AF8EF12B69B7315E8862B3AC9386BB768D017D6CD53AA3F7687", 0);
  level.useunifiedspawnselectioncameraheight = getdvarint("_encstr_872821E7EF1ED14188B8D9DAF3F89F3A6E03073775CF393608E14CA76989D502C489EB", 1);
  level.forcetopickafob = getdvarint("_encstr_8B8516AB1815CFD24A602E28D855FEC5167987A7EA27B0C7", 0);
  level.maxhqtanks = getdvarint("_encstr_8AFB134663CBEECB92C2E1483A28D1670B094032EB", 2);
  level._id_13A58 = getdvarint("_encstr_B227182B9FC889E75EC0813BA9B837329827A0811F70038F89F9", 120);
  level.c4_obj_and_progress_clear = getdvarint("_encstr_BAF917E61B27F516C9B6FA5807C649959BC1B0EE9BA8966B95", 120);
  level.longdialoguecooldown = getdvarint("_encstr_84851DD7DF2EE17198A829EDED90BF880B73132F4FD50A0B48F01DF738BBCE", 1);
  level._id_11BD2 = getdvarint("_encstr_833E181AFEC391E7C0026729E7BB7AB3BD8EF72A80DF55956F8F", 1);
  level._id_11BD3 = getdvarint("_encstr_8C861803DE23173E8530A19A68DDF6C7BD309C81E029E3C45358", 30);
  level._id_11F41 = getdvarint("_encstr_88EE1C6E6CC9BEB027B6F537D5B69CDEDC49851B36BC9556434B6C36B2DC", 25);
  level.loadout_updateclassdefault_weapons = getdvarint("_encstr_A7491C63D780C19F2688D97210FED7C608B3D8FD4D20155B4780C06B38DD", 0);
  level._id_12305 = getdvarint("_encstr_ACBB1DF3CE33076ABBF853AA208B250B8BA26DBB50BB137D75A84B7370E95F", 30);
  level._id_13377 = getdvarint("_encstr_95CD166E36C9D72C9CD6AF3734DBBBA2AC2CADA22C73DACD", 1);
  level._id_13375 = getdvarint("_encstr_B6941C5FDB2A491F637276FB0A3FCCC907319BA9491358D1479888C33297", 1);
  level._id_1369C = getdvarint("_encstr_9A6A1E02E32B2798634AF0D7FB1F13227F67B43903CBDB209B9E0B291C5315B7", 120);
  level._id_11AC5 = getdvarint("_encstr_A2EB23283FC2466B83C53839DE9A9B49344F1878CF7B7B795AABA5B13770EB5364D3B8B84F", 1);
  level.matchdata_logvictimkillevent = getdvarint("_encstr_ACC016C3198507E12D2B4153A06DF3870A10BFADBA45E58B", 0);
  level.matchdata_logscoreevent = getdvarint("_encstr_A1B21C47361A3859AB48777372705C4F4803CBB0A3F07BBCAD936DB36A38", 0);
  level._id_1408C = getdvarint("_encstr_AD0516E61B937D2C4E5BD7BAE69505A59B9D6ACB37D156AD", 1);

  if(istrue(level._id_13377)) {
    level._id_13C4A = [];
    level._id_13C4A["_encstr_8E8405EA382B2A"] = [];
    level._id_13C4A["_encstr_9A8507BA4040188D08"] = [];
  }

  if(istrue(level._id_13375)) {
    level._id_13C49 = [];
    level._id_13C49["_encstr_8E8405EA382B2A"] = [];
    level._id_13C49["_encstr_9A8507BA4040188D08"] = [];
    level._id_13C49["_encstr_A7770ABF18E31F23BF4BDF97"] = [];
  }

  if(level.useobjectives || level.userallypointvehicles || level.usesquadspawnselection) {
    setDvar("_encstr_8BF21B436895B9F749E93D0FFD53A7FAF90B8B0A4003AD37E14D092718", 1);
    setDvar("_encstr_A7A71CCDC69CD7EC2C6BCAFA194B6E2C13B1B2E68385DDB9C60BB5B2E416", 0);
    setDvar("_encstr_AF771A1BB6BB57DAA78A27705B08D9FF8646E90DDD821FCF9BE60BF8", 1);
  } else {
    setDvar("_encstr_8BF21B436895B9F749E93D0FFD53A7FAF90B8B0A4003AD37E14D092718", 0);
    setDvar("_encstr_A7A71CCDC69CD7EC2C6BCAFA194B6E2C13B1B2E68385DDB9C60BB5B2E416", 1);
    setDvar("_encstr_AF771A1BB6BB57DAA78A27705B08D9FF8646E90DDD821FCF9BE60BF8", 1);
  }

  if(level.dropbrloot)
    level.blockweapondrops = 1;

  if(level.c130movementmethod == 1) {
    level.c130pathkilltracker = [];
    level.c130pathkilltracker["_encstr_8E8405EA382B2A"] = 0;
    level.c130pathkilltracker["_encstr_9A8507BA4040188D08"] = 0;
  }

  level.modecontrolledvehiclespawningonly = 1;
  level.disableteamstartspawns = 1;
  level._id_1368D = ::_id_1368D;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_B49115530AF3982033459FED7F9DD0C947B2693B3227CD", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_86550DFA1D220B34D12B80A33FFD29"));
  setdynamicdvar("_encstr_B29C18336A93F8405325FFCD5FBD30AE87F36B7BE327B5C02D05", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_B4CE10F4BD73CA6816E0D1BA93598A2DDA59"));
  setdynamicdvar("_encstr_ACAC1CCF7758EF62FB3329F5B566152B5A755B237A45C0B7F6DD4D20EA43", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_934B143DF6DC2B82B13A2D9D0BA396DB7344ACD82CE5"));
  setdynamicdvar("_encstr_B1901CDC8DC9F598D1B5BE9C58E691BD5B26F68D58D1A5B7E63DE419CAC9", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_AB9F14E3BA1395D8C5D44F4FE16B20E8EBB07BA942CB"));
  setdynamicdvar("_encstr_8FC918B98DE4F526E8DAF50B8C235AE82D67B235C6F6C94B37EC", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_829C10A99FECC0B502436B0F3F4AFE988E37"));
  setdynamicdvar("_encstr_842812E6D839D731A3B67D830BBA6ECA2A96ADCA", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_83FE0A484FBDAB0BF9EC1915"));
  setdynamicdvar("_encstr_86C314A65EE829066BCA3FD9D31917D13F50F6B1D762", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_A9210CA017EC518B7175D7E30F6B"));
  setdynamicdvar("_encstr_95F213032FD22116589D902D10C730D9EA1F8D4DBB", getmatchrulesdata("_encstr_8F0B09903AD3015D5F9457", "_encstr_832F0B5BCFA2A1623A2B6903B6"));
  setdynamicdvar("_encstr_BE16139B1B4EBE31A3D6BEDCC1C2DDCD8C2BB1B0E5", getmatchrulesdata("_encstr_AB85091DC8ACCC442C4785", "_encstr_8CA10BD013238F78BFFAB053C3"));
  scripts\mp\utility\game::registerhalftimedvar("_encstr_B81904B04E6B", 0);
}

onstartgametype() {
  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");
  level.objectives = [];
  level.uncapturableobjectives = [];
  initspawns();
  seticonnames();
  level.usedomflag = 0;
  level.killstreakqueue = [];
  level.teamkillstreakqueue = [];
  level.teamkillstreakqueue["_encstr_9A8507BA4040188D08"] = [];
  level.teamkillstreakqueue["_encstr_8E8405EA382B2A"] = [];
  level.killstreaklist = [];
  level.killstreaklist[4] = ["_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"];
  level.killstreaklist[3] = ["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B", "_encstr_8CC008133958C81BACCB"];
  level.killstreaklist[2] = ["_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_B1B30B51D176511E377A1BC313", "_encstr_86FD08B775CD07DC1338"];
  level.teamkillstreakqueue["_encstr_9A8507BA4040188D08"] = ["_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", "_encstr_B270105ECB28E94BC5CFABAB937D524C5053"];
  level.teamkillstreakqueue["_encstr_8E8405EA382B2A"] = ["_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", "_encstr_B270105ECB28E94BC5CFABAB937D524C5053"];
  level thread setupwaypointicons();
  debug_setupmatchdata();
  _id_1324D();
  calculatehqmidpoint();

  if(istrue(level.useobjectives))
    setupobjectives();

  level thread runobjectives();

  if(level.usec130spawn)
    level thread managec130spawns();

  if(istrue(level.userallypointvehicles)) {
    scripts\mp\rally_point::init();
    level thread init_rallyvehicles();
  }

  thread init_groundwarvehicles();
  level thread updatedomscores();
  scripts\mp\utility\dialog::initstatusdialog();

  if(istrue(level._id_11BD2))
    level thread _id_11EEE();

  monitordriverexitbutton();

  if(istrue(level._id_1408C))
    scripts\cp_mp\vehicles\vehicle_compass::calloutmarkerping_init();

  scripts\cp_mp\parachute::initparachutedvars();
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.pausescoring = scripts\mp\utility\dvars::dvarintvalue("_encstr_83FE0A484FBDAB0BF9EC1915", 1, 0, 1);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("_encstr_A9210CA017EC518B7175D7E30F6B", 1, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8CA10BD013238F78BFFAB053C3", 5, 0, 30);
  level.usehqrules = 1;
  level.flagcapturetime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AFBB1099B1B0D91AC2C1E8579C598AD25BCA", 30, 0, 30);
  level.flagsrequiredtoscore = scripts\mp\utility\dvars::dvarintvalue("_encstr_8BB015CC36583BE6A495C5AED2C99546A2F69A36ED9CCA", 1, 1, 3);
  level.pointsperflag = scripts\mp\utility\dvars::dvarintvalue("_encstr_BA150E0BDD617835235BEBCD2BFAF768", 1, 1, 300);
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("_encstr_82730D3B68514312E927CD4410D90B", 0, 0, 1);
  level.capturedecay = scripts\mp\utility\dvars::dvarintvalue("_encstr_87940DB10BE0D1D5E42B88ACC616E5", 1, 0, 1);
  level.capturetype = scripts\mp\utility\dvars::dvarintvalue("_encstr_A5B60CF9DFD99DEB337D3193BF2F", 1, 0, 3);
  level.numflagsscoreonkill = scripts\mp\utility\dvars::dvarintvalue("_encstr_813614C07352A6316B87B7D13FF728B02C383CEAE578", 0, 0, 3);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86FA0ABD89A6D41B85630BC9", 4, 1, 10);

  if(getdvarint("_encstr_B63914C26363DBEEAF3A5658DAD70EC9DEF06C86C2D1", 0) == 1) {
    setDvar("_encstr_B8F20B31E043F917232347D1D2", 1);
    var_0 = 1000;
    var_1 = getdvarint("_encstr_958219C1C9DE0FC6A1B0E8BE27C291D2AB377DDEEC954E93A591AC", 0);

    if(var_1 != 0)
      var_0 = var_1;

    setDvar("_encstr_AB150B27C9D4134DA69CA8A745", var_0);
  }
}

seticonnames() {
  level.iconcapture = "_encstr_859A1183D94B3B2548D56447E7202A93F5133A";
  level.iconneutral = "_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1";
  level.icondefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
  level.iconcontested = "_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509";
  level.icondefending = "_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30";
  level.icontaking = "_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012";
  level.iconlosing = "_encstr_8202100F51F881C7C0F2255890A5865376FF";
}

monitordriverexitbutton() {
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_BE6A0F1C3D989830516526E040F8CB15EF", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_A7511A63F7D8F8067A57773D672255906DC14B181D2808CBF20F0B11", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_BEB406F03B72BB3B", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_B4840D0763993ADCA8D3C816A9E015", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_B8EE102BE0F1C1E37B182D69FC0F1A9D5828", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_B66314EBA72963897D1FCFA3AD6AE9A3A857A22F77F8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_BA650FEBA3B9035567795AB210A78CDF73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_920D1AA7081FE397C3407F2F90385F3AD3112D91E1A33BF12841672B", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_95F719D9AC34C1D7D65A63AF2CB49CF52C8D3416396396594C990C", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_B49F18FD153A2D2EB707C88837F6666162FDE571E1F2F116D816", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_99291CC83F37405922F7696D37AA17D09F5630E22963800E1AF7912F6AD7", 1);
  scripts\cp_mp\utility\game_utility::_id_12C0F("_encstr_8FA906CC80677438");
  scripts\cp_mp\utility\game_utility::_id_12C0F("_encstr_A38E124303C0477207C357B07F1D8725F85596B3");

  if(isDefined(level.localeid) && level.localeid == "_encstr_8A34097127C761890FA9D2")
    scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_8D34098D7BB185C6CAEB1C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  var_0 = [];
  var_0[0] = (-22592, 27367, 1000);
  var_0[1] = (-22592, 27303, -448);
  var_0[2] = (7837, -9674, 1154);
  var_0[3] = (7637, -9674, 1154);
  var_0[4] = (7901, -9674, -270);
  var_0[5] = (7701, -9674, -270);
  var_0[6] = (10366, -11606, 66);
  var_0[7] = (10366, -11813, 66);
  var_0[6] = (10366, -11670, -270);
  var_0[7] = (10366, -11877, -270);
  var_0[8] = (7498, -11716, 66);
  var_0[9] = (7498, -11652, -270);
  var_0[10] = (-1200, -18954, -242);
  var_0[11] = (-1215, -19016, 774);
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.model) && var_3.model == "_encstr_A2B40B8E2C3B7DDB274B9D4B37") {
      var_4 = 0;

      foreach(var_6 in var_0) {
        if(var_4) {
          break;
        }

        if(distancesquared(var_3.origin, var_6) < 144)
          var_4 = 1;
      }

      if(var_4)
        var_3 delete();
    }
  }
}

_id_12C14() {
  wait 5;
  var_0 = [];
  var_0[0] = "_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83";
  var_0[1] = "_encstr_A6FB14E3E927D37F593ED08858714532B59898479FF3";
  var_0[2] = "_encstr_815E0C7F0B2A8702B0C0DA9BABC6";
  var_0[3] = "_encstr_99BE0E29D1D1E75FE3979AE119923385";
  var_0[4] = "_encstr_BAFB0FD80B464656C9A62B1D16D8C8D8A1";
  var_0[5] = "_encstr_BD8E0EC56F29A28DA34947BF2833190F";
  var_0[6] = "_encstr_A7FB0F63B0C891AC4EA95947581BC49319";
  var_0[7] = "_encstr_911A095DA283A56B9B2211";
  var_0[8] = "_encstr_AA9508ADB7EA9BA3C61A";
  var_0[9] = "_encstr_BE9508BA80D5CB6BE2E5";
  var_0[10] = "_encstr_841A09ADB7BA9BA3199AD8";
  var_0[11] = "_encstr_928E0E3967A2D5C0822310E8172A9235";
  var_0[12] = "_encstr_830B1105709BF1E2BB614AAE1D5B7F65F23A28";
  var_0[13] = "_encstr_825E11D8E2DFBB301C749B95D0C05ADE5A2B9A";
  var_0[14] = "_encstr_8E130FA8F2D7C858269F0D3DBD524AAE4A";
  var_0[15] = "_encstr_8DAF0AD6B0E68E8D9546A61B";
  var_0[16] = "_encstr_83AF0AC0361ED0412A46EDE1";
  var_0[17] = "_encstr_919109AA5148539DA0FDAC";
  var_0[18] = "_encstr_9B9109AD2CE6A363953364";
  var_0[19] = "_encstr_8B3414DBFB57F41B465C39B353B4E813E97023B39242";
  var_0[20] = "_encstr_BDBA1437478596E43719AE1B8DC8364B3B0DD1C48CC1";

  foreach(var_2 in var_0)
  scripts\cp_mp\utility\game_utility::_id_12C10(var_2, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

debug_setupmatchdata() {
  level.axishqname = "_encstr_B16B0EDFCFE1246042F1013A643B11F7";
  level.allieshqname = "_encstr_B4B9103B4BE98DA8C30FE76904D7D16F84B1";
  level.startingfobnames_allies = [];
  level.startingfobnames_axis = [];
  level.startingfobnames_neutral = ["_encstr_84790A3BE767F9EF0AF1078F", "_encstr_8A790ADC87B90C78B8366A32", "_encstr_85790AFFD88E0E9AB5D8724A", "_encstr_95790A27CFC727EA2891A293", "_encstr_B4790A3F7337CA8F9687DA83"];
  level.defaultaxisspawn = "_encstr_B16B0EDFCFE1246042F1013A643B10E7";
  level.defaultaxisspawncamera = "_encstr_B16B0EDFCFE1246042F1013A643B10E7";
  level.defaultalliesspawn = "_encstr_B4B9103B4BE98DA8C30FE76904D7D16F8CB3";
  level.defaultalliesspawncamera = "_encstr_B4B9103B4BE98DA8C30FE76904D7D16F8CB3";
}

setupwaypointicons() {
  while(!isDefined(game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"]))
    waitframe();

  foreach(var_2, var_1 in game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].tabledatabyref) {
    level.waypointcolors[var_2 + "_encstr_B6DC0AD75AE636BDAD5AE63B"] = "_encstr_A7A408B9CA5D1D4E2C63";
    level.waypointbgtype[var_2 + "_encstr_B6DC0AD75AE636BDAD5AE63B"] = 1;
    level.waypointstring[var_2 + "_encstr_B6DC0AD75AE636BDAD5AE63B"] = "_encstr_B40101";
    level.waypointshader[var_2 + "_encstr_B6DC0AD75AE636BDAD5AE63B"] = var_1["_encstr_BE6C080DBA2392367BE6"];
    level.waypointpulses[var_2 + "_encstr_B6DC0AD75AE636BDAD5AE63B"] = 0;
    level.waypointcolors[var_2] = "_encstr_A7A408B9CA5D1D4E2C63";
    level.waypointbgtype[var_2] = 1;
    level.waypointstring[var_2] = "_encstr_966420E58F4E870D179958D081EFF56B66A87F622A16E7866109C15949F7FE17FF7E";
    level.waypointshader[var_2] = var_1["_encstr_BE6C080DBA2392367BE6"];
  }
}

_id_1324D() {
  level.gw_objstruct = spawnStruct();
  level.gw_objstruct.axishqloc = spawnStruct();
  level.gw_objstruct.axishqloc.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(level.axishqname);

  if(!isDefined(level.gw_objstruct.axishqloc)) {}

  level.gw_objstruct.allieshqloc = spawnStruct();
  level.gw_objstruct.allieshqloc.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(level.allieshqname);

  if(!isDefined(level.gw_objstruct.allieshqloc))
    return;
}

setupobjectives() {
  level.gw_objstruct.startingfobs_allies = [];
  level.gw_objstruct.startingfobs_axis = [];
  level.gw_objstruct.startingfobs_neutral = [];
  var_0 = ["_encstr_B20703DFCF", "_encstr_B40703E96D", "_encstr_B6070359BA", "_encstr_A2070318DC", "_encstr_950703EBCA"];
  var_1 = 0;

  foreach(var_3 in level.startingfobnames_allies) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var_3);
    var_4.trigger.objkey = var_0[var_1];
    var_1++;
    level.gw_objstruct.startingfobs_allies[level.gw_objstruct.startingfobs_allies.size] = var_4;
  }

  foreach(var_3 in level.startingfobnames_axis) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var_3);
    var_4.trigger.objkey = var_0[var_1];
    var_1++;
    level.gw_objstruct.startingfobs_axis[level.gw_objstruct.startingfobs_axis.size] = var_4;
  }

  foreach(var_3 in level.startingfobnames_neutral) {
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.trigger = scripts\cp_mp\utility\game_utility::getlocaleent(var_3);
    var_4.trigger.objkey = var_0[var_1];
    var_1++;
    level.gw_objstruct.startingfobs_neutral[level.gw_objstruct.startingfobs_neutral.size] = var_4;
  }
}

updatedomscores() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = undefined;
  var_1 = undefined;
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level thread scripts\mp\spawnselection::_id_13FD9();

  while(!level.gameended) {
    wait 10;
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_2 = getowneddomflags();

    if(!isDefined(level.scoretick))
      level.scoretick = [];

    foreach(var_4 in level.teamnamelist)
    level.scoretick[var_4] = 0;

    if(var_2.size) {
      for(var_6 = 1; var_6 < var_2.size; var_6++) {
        var_7 = var_2[var_6];
        var_8 = gettime() - var_7.capturetime;

        for(var_9 = var_6 - 1; var_9 >= 0 && var_8 > gettime() - var_2[var_9].capturetime; var_9--)
          var_2[var_9 + 1] = var_2[var_9];

        var_2[var_9 + 1] = var_7;
      }

      foreach(var_7 in var_2) {
        var_11 = var_7 scripts\mp\gameobjects::getownerteam();
        var_0 = getteamscore(var_11);
        var_12 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getteamflagcount(var_11);

        if(var_12 >= level.flagsrequiredtoscore)
          level.scoretick[var_11] = level.scoretick[var_11] + level.pointsperflag;
      }
    }

    updatescores();
  }
}

getowneddomflags() {
  var_0 = [];

  foreach(var_2 in level.objectives) {
    if(var_2 scripts\mp\gameobjects::getownerteam() != "_encstr_A7A408B9CA5D1D4E2C63" && isDefined(var_2.capturetime))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

updatescores() {
  var_0 = [];

  foreach(var_2 in level.teamnamelist) {
    var_3 = game["_encstr_96040B1D59B0AD35B1F64E599B"][var_2] + level.scoretick[var_2];

    if(var_3 >= level.roundscorelimit)
      var_0[var_0.size] = var_2;
  }

  if(var_0.size == 1)
    level.scoretick[var_0[0]] = level.roundscorelimit - game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0[0]];

  var_5 = scripts\mp\gamescore::freight_lift_door_switch();

  foreach(var_2 in level.teamnamelist) {
    if(level.scoretick[var_2] > 0)
      scripts\mp\gamescore::giveteamscoreforobjective(var_2, level.scoretick[var_2], 1, undefined, 1);
  }

  var_8 = scripts\mp\gamescore::freight_lift_door_switch();

  if(var_5 != var_8)
    scripts\mp\gamescore::_id_12762(var_8, 1, var_5);
}

runobjectives(var_0) {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];
  level.allfobs = [];

  if(istrue(level.useobjectives)) {
    foreach(var_2 in level.gw_objstruct.startingfobs_axis) {
      var_3 = runobjflag(var_2.trigger, "_encstr_8E8405EA382B2A");
      level.allfobs[level.allfobs.size] = var_2;
      level.axisspawnareas[level.axisspawnareas.size] = var_2.name;

      if(isDefined(level.spawnselectionlocations[var_2.name]["_encstr_8E8405EA382B2A"].anchorentity))
        level.spawnselectionlocations[var_2.name]["_encstr_8E8405EA382B2A"].anchorentity.origin = var_2.trigger.origin + (0, 0, 100);
    }

    foreach(var_2 in level.gw_objstruct.startingfobs_allies) {
      var_3 = runobjflag(var_2.trigger, "_encstr_9A8507BA4040188D08");
      level.allfobs[level.allfobs.size] = var_2;
      level.alliesspawnareas[level.alliesspawnareas.size] = var_2.name;

      if(isDefined(level.spawnselectionlocations[var_2.name]["_encstr_9A8507BA4040188D08"].anchorentity))
        level.spawnselectionlocations[var_2.name]["_encstr_9A8507BA4040188D08"].anchorentity.origin = var_2.trigger.origin + (0, 0, 100);
    }

    foreach(var_2 in level.gw_objstruct.startingfobs_neutral) {
      var_3 = runobjflag(var_2.trigger, "_encstr_A7A408B9CA5D1D4E2C63");
      level.allfobs[level.allfobs.size] = var_2;
    }

    foreach(var_2 in level.allfobs) {
      var_2.trigger.gameobject.oncontested = ::objective_oncontested;
      var_2.trigger.gameobject.onuncontested = ::objective_onuncontested;
      var_2.trigger.gameobject.onuse = ::objective_onuse;
      var_2.trigger.gameobject.onbeginuse = ::objective_onusebegin;
      var_2.trigger.gameobject.onenduse = ::objective_onuseend;
      var_2.trigger.gameobject.onpinnedstate = ::objective_onpinnedstate;
      var_2.trigger.gameobject.onunpinnedstate = ::objective_onunpinnedstate;

      if(istrue(level.playinggulagbink))
        var_2._id_136CD = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::_id_136CE;

      level.objectives[var_2.trigger.gameobject.objectivekey] = var_2.trigger.gameobject;
      level.spawnselectionlocations[var_2.name]["_encstr_9A8507BA4040188D08"].objectivekey = var_2.trigger.gameobject.objectivekey;
      level.spawnselectionlocations[var_2.name]["_encstr_8E8405EA382B2A"].objectivekey = var_2.trigger.gameobject.objectivekey;
    }
  }

  if(level.usesquadspawnselection) {
    scripts\mp\spawnselection::setspawnlocations(level.axisspawnareas, "_encstr_8E8405EA382B2A");
    scripts\mp\spawnselection::setspawnlocations(level.alliesspawnareas, "_encstr_9A8507BA4040188D08");
    sethqmarkerobjective();

    while(!isDefined(level.spawnselectionlocations))
      waitframe();

    waitframe();

    if(isDefined(level.spawnselectionlocations[level.axishqname]["_encstr_8E8405EA382B2A"].anchorentity))
      level.spawnselectionlocations[level.axishqname]["_encstr_8E8405EA382B2A"].anchorentity.origin = level.gw_objstruct.axishqloc.trigger.origin;

    if(isDefined(level.spawnselectionlocations[level.allieshqname]["_encstr_9A8507BA4040188D08"].anchorentity))
      level.spawnselectionlocations[level.allieshqname]["_encstr_9A8507BA4040188D08"].anchorentity.origin = level.gw_objstruct.allieshqloc.trigger.origin;
  }

  level thread objective_manageobjectivesintrovisibility();
  hackfixcameras();
  level thread brking_getspawnpoint();
}

brking_getspawnpoint() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_1 in level.allfobs)
  var_1.trigger.gameobject scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
}

objective_manageobjectivesintrovisibility() {
  wait 1;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.marker.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.axishqloc.nuclear_core_on_chopper.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(level.gw_objstruct.allieshqloc.nuclear_core_on_chopper.objidnum);

  foreach(var_1 in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_1.trigger.gameobject.objidnum);

  if(isDefined(level.rallypointvehicles)) {
    foreach(var_4 in level.rallypointvehicles)
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_4.marker.objidnum);
  }

  while(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    waitframe();

  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.axishqloc.marker.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(level.gw_objstruct.allieshqloc.marker.objidnum, "_encstr_9A8507BA4040188D08");

  foreach(var_1 in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1.trigger.gameobject.objidnum);

  if(isDefined(level.rallypointvehicles)) {
    foreach(var_4 in level.rallypointvehicles) {
      if(isDefined(var_4))
        scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_4.marker.objidnum, var_4.team);
    }
  }
}

hackfixcameras() {
  if(istrue(level.usestaticspawnselectioncamera)) {
    return;
  }
  while(!isDefined(level.spawncameras["_encstr_B4B9103B4BE98DA8C30FE76904D7D16F84B1"]))
    waitframe();

  var_0 = "_encstr_9A8507BA4040188D08";
  var_1 = level.spawnselectionteamforward[var_0];
  var_2 = ["_encstr_B4B9103B4BE98DA8C30FE76904D7D16F84B1", "_encstr_84790A3BE767F9EF0AF1078F", "_encstr_8A790ADC87B90C78B8366A32", "_encstr_85790AFFD88E0E9AB5D8724A", "_encstr_95790A27CFC727EA2891A293", "_encstr_B4790A3F7337CA8F9687DA83"];

  foreach(var_4 in var_2) {
    var_5 = level.spawnselectionlocations[var_4][var_0].anchorentity.origin;
    var_6 = var_5 + var_1 * -8500 + (0, 0, 7000);
    var_7 = vectorNormalize(var_5 - var_6);
    var_8 = scripts\mp\utility\script::vectortoanglessafe(var_7, (0, 0, 1));

    if(istrue(level.useunifiedspawnselectioncameraheight)) {
      var_9 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
      var_6 = (var_6[0], var_6[1], var_9);
    }

    var_6 = var_6 + calculatecameraoffset(var_0, var_5);
    level.spawncameras[var_4][var_0].origin = var_6;
    level.spawncameras[var_4][var_0].angles = var_8;
  }

  while(!isDefined(level.spawncameras["_encstr_B16B0EDFCFE1246042F1013A643B11F7"]))
    waitframe();

  var_0 = "_encstr_8E8405EA382B2A";
  var_1 = level.spawnselectionteamforward[var_0];
  var_2 = ["_encstr_B16B0EDFCFE1246042F1013A643B11F7", "_encstr_84790A3BE767F9EF0AF1078F", "_encstr_8A790ADC87B90C78B8366A32", "_encstr_85790AFFD88E0E9AB5D8724A", "_encstr_95790A27CFC727EA2891A293", "_encstr_B4790A3F7337CA8F9687DA83"];

  foreach(var_4 in var_2) {
    var_5 = level.spawnselectionlocations[var_4][var_0].anchorentity.origin;
    var_6 = var_5 + var_1 * -8500 + (0, 0, 7000);
    var_7 = vectorNormalize(var_5 - var_6);
    var_8 = scripts\mp\utility\script::vectortoanglessafe(var_7, (0, 0, 1));

    if(istrue(level.useunifiedspawnselectioncameraheight)) {
      var_9 = scripts\mp\spawnselection::getunifedspawnselectioncameraheight();
      var_6 = (var_6[0], var_6[1], var_9);
    }

    var_6 = var_6 + calculatecameraoffset(var_0, var_5);
    level.spawncameras[var_4][var_0].origin = var_6;
    level.spawncameras[var_4][var_0].angles = var_8;
  }
}

updatefobspawnselection() {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];

  foreach(var_1 in level.allfobs) {
    var_2 = var_1.trigger.gameobject;

    if(var_2.ownerteam == "_encstr_8E8405EA382B2A") {
      level.axisspawnareas[level.axisspawnareas.size] = var_1.name;

      if(isDefined(level.spawnselectionlocations[var_1.name]["_encstr_8E8405EA382B2A"].anchorentity))
        level.spawnselectionlocations[var_1.name]["_encstr_8E8405EA382B2A"].anchorentity.origin = var_1.trigger.origin + (0, 0, 100);

      continue;
    }

    if(var_2.ownerteam == "_encstr_9A8507BA4040188D08") {
      level.alliesspawnareas[level.alliesspawnareas.size] = var_1.name;

      if(isDefined(level.spawnselectionlocations[var_1.name]["_encstr_9A8507BA4040188D08"].anchorentity))
        level.spawnselectionlocations[var_1.name]["_encstr_9A8507BA4040188D08"].anchorentity.origin = var_1.trigger.origin + (0, 0, 100);
    }
  }

  scripts\mp\spawnselection::setspawnlocations(level.axisspawnareas, "_encstr_8E8405EA382B2A");
  scripts\mp\spawnselection::setspawnlocations(level.alliesspawnareas, "_encstr_9A8507BA4040188D08");
}

sethqmarkerobjective() {
  var_0 = "_encstr_9A19040BCDBC";
  var_1 = level.gw_objstruct.axishqloc.trigger.origin;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_8AF71A4B63BFC8B7D302D0A0DA6C9DC32768CF28FE63901B7DBA70E0");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  var_2.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.marker = var_2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var_2;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_AAD017D28DDE73D7BB582F1CEDA573A3EB86177D95B92B6BBC");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 7);
  var_2.lockupdatingicons = 1;
  level.gw_objstruct.axishqloc.nuclear_core_on_chopper = var_2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var_2;
  var_1 = level.gw_objstruct.allieshqloc.trigger.origin;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_8AF71A4B63BFC8B7D302D0A0DA6C9DC32768CF28FE63901B7DBA70E0");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  var_2.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.marker = var_2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var_2;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 0), undefined, var_0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "_encstr_9A8507BA4040188D08");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "_encstr_8E8405EA382B2A");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_AAD017D28DDE73D7BB582F1CEDA573A3EB86177D95B92B6BBC");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 7);
  var_2.lockupdatingicons = 1;
  level.gw_objstruct.allieshqloc.nuclear_core_on_chopper = var_2;
  level.uncapturableobjectives[level.uncapturableobjectives.size] = var_2;
  level.spawnselectionteamforward = [];
  level.spawnselectionteamforward["_encstr_9A8507BA4040188D08"] = vectorNormalize(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
  level.spawnselectionteamforward["_encstr_8E8405EA382B2A"] = vectorNormalize(level.gw_objstruct.allieshqloc.trigger.origin - level.gw_objstruct.axishqloc.trigger.origin);
}

spawnselection_showenemyhq() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(self.team == "_encstr_9A8507BA4040188D08") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.marker.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.nuclear_core_on_chopper.objidnum, self);
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.allieshqloc.nuclear_core_on_chopper.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.gw_objstruct.axishqloc.marker.objidnum, self);
  }

  while(self.inspawnselection)
    waitframe();

  if(self.team == "_encstr_8E8405EA382B2A")
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.allieshqloc.nuclear_core_on_chopper.objidnum, self);
  else
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.gw_objstruct.axishqloc.nuclear_core_on_chopper.objidnum, self);
}

objective_oncontested() {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_oncontested();

  if(!istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 1;
  }
}

objective_onuncontested(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuncontested(var_0);

  if(istrue(self.updatedoncontestedspawnselection)) {
    updatefobspawnselection();
    self.updatedoncontestedspawnselection = 0;
  }
}

objective_onusebegin(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onusebegin(var_0);
  updatefobspawnselection();
}

objective_onuseend(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
  updatefobspawnselection();
}

objective_onuse(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse(var_0);
  updatefobspawnselection();
}

objective_onuseupdate(var_0, var_1, var_2, var_3) {}

objective_onpinnedstate(var_0) {
  updatefobspawnselection();
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onunpinnedstate(var_0);
}

objective_onunpinnedstate(var_0) {
  updatefobspawnselection();
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onunpinnedstate(var_0);
}

dommainloop() {}

runobjflag(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  var_0.script_label = var_0.objkey;
  var_2 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_0, undefined, undefined, undefined, 0);
  var_2.origin = var_0.origin;
  var_2 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  var_2.didstatusnotify = 0;
  var_2 scripts\mp\gameobjects::setownerteam(var_1);
  var_3 = "_encstr_9A19040BCDBC";

  if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63") {
    if(level.hideenemyfobs)
      var_3 = "_encstr_ACFC091AE8AB2FCBE15119";

    var_2.capturetime = gettime();
  }

  var_2 scripts\mp\gameobjects::setvisibleteam(var_3);
  return var_2;
}

dropcrate(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var_2, var_0, var_1.origin, (0, randomint(360), 0), undefined);
  return var_3;
}

docratedropsmoke(var_0, var_1, var_2) {
  var_3 = var_1.origin + (0, 0, 2000);
  var_4 = scripts\common\utility::groundpos(var_3, (0, 0, 1));
  var_1.vfxent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_1.vfxent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.vfxent.angles = (0, 0, 0);
  var_1.vfxent playLoopSound("_encstr_85CC1BF750D02B12F7FE0EC2D5916AEBF8A82F57298B95FAF785997D47");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_9BA412D0FB18B6BF8294E8866C5AFD396487D048"), var_1.vfxent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(isDefined(var_0))
    var_0 scripts\engine\utility::_id_143B9(var_2, "_encstr_AA590EF71A80800D1FEAC370EB0FCADD");
  else
    wait(var_2);

  stopFXOnTag(scripts\engine\utility::getfx("_encstr_9BA412D0FB18B6BF8294E8866C5AFD396487D048"), var_1.vfxent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1.vfxent delete();
}

addkillstreakstoqueue(var_0) {
  level.killstreaklist[var_0] = scripts\engine\utility::array_randomize(level.killstreaklist[var_0]);

  foreach(var_2 in level.killstreaklist[var_0])
  level.killstreakqueue[level.killstreakqueue.size] = var_2;
}

dropdefconkillstreaks(var_0) {
  level.activezone.airdroplocations[var_0] = scripts\engine\utility::array_randomize(level.activezone.airdroplocations[var_0]);

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = level.activezone.airdroplocations[var_0][var_1];

    if(isDefined(var_2)) {
      var_2.isinside = 0;
      level thread runkillstreakreward(var_2.origin, var_0);
      wait(randomfloatrange(1.5, 2.5));
    }
  }
}

registervaliddroplocations() {
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.validdroplocationstruct = spawnStruct();
  level.validdroplocationstruct.clusters = scripts\engine\utility::getStructArray("_encstr_8DE1128C27DB831285B33463AED1CA4E9CDE9195", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_0 = scripts\engine\utility::getStructArray("_encstr_933F102AF8B77A6B71E41C278E19FB44CF70", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_2 in var_0) {
    var_2.inuse = 0;

    foreach(var_4 in level.validdroplocationstruct.clusters) {
      if(var_2.target == var_4.targetname) {
        if(!isDefined(var_4.droplocations))
          var_4.droplocations = [];

        var_4.droplocations[var_4.droplocations.size] = var_2;
        continue;
      }
    }
  }

  level.nextkillstreakgoal = 100;

  if(0)
    thread debug_testcratedroplocationpicker();
}

debug_testcratedroplocationpicker() {
  for(;;) {
    choosecratelocation();
    wait 1;
  }
}

checkkillstreakcratedrop(var_0) {
  if(game["_encstr_96040B1D59B0AD35B1F64E599B"][var_0] >= level.nextkillstreakgoal) {
    level.nextkillstreakgoal = level.nextkillstreakgoal + 100;
    dropkillstreakcrates(2);
  }
}

dropkillstreakcrates(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_3)) {
      var_1 = var_3;
      break;
    }
  }

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = choosecratelocation();
    thread runkillstreakreward(var_6, var_1, getkillstreak(1));
    wait 5;
  }
}

choosecratelocation() {
  var_0 = randomfloatrange(0, 1.0);
  var_1 = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, var_0);
  var_2 = vectorlerp(level.c130pathstruct_b.endpt, level.c130pathstruct_b.startpt, var_0);
  var_3 = vectorlerp(var_1, var_2, 0.5);
  var_4 = scripts\engine\trace::ray_trace(var_3, var_3 - (0, 0, 100000));
  var_3 = var_4["_encstr_BD260953AA97E3F014279D"];
  var_5 = findclosestdroplocation(var_3);

  if(0) {
    debugsphereonlocation(var_1, (0, 0, 1), 100);
    debugsphereonlocation(var_2, (0, 0, 1), 100);
    debugsphereonlocation(var_3, (1, 0, 0), 100);
    debugsphereonlocation(var_5.origin, (0, 1, 0), 100);
    thread scripts\mp\utility\debug::drawline(var_3, var_5.origin, 3, (0, 1, 0));
  }

  return var_5;
}

findclosestdroplocation(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_2 = var_1 scripts\engine\utility::array_sort_with_func(level.validdroplocationstruct.clusters, ::sortlocationsbydistance);

  foreach(var_4 in var_2) {
    var_5 = scripts\engine\utility::array_randomize(var_4.droplocations);

    if(0)
      return var_5[0];
    else {
      foreach(var_7 in var_5) {
        if(!var_7.inuse) {
          var_7.inuse = 1;
          return var_7;
        }
      }
    }
  }

  return undefined;
}

choosenukecratelocation() {
  var_0 = randomfloatrange(level.mapsafecorners[1][0], level.mapsafecorners[0][0]);
  var_1 = randomfloatrange(level.mapsafecorners[1][1], level.mapsafecorners[0][1]);
  var_2 = (var_0, var_1, 100000);
  var_3 = scripts\engine\trace::ray_trace(var_2, var_2 - (0, 0, 100000));
  var_2 = var_3["_encstr_BD260953AA97E3F014279D"];
  var_4 = findclosestdroplocation(var_2);

  if(0) {
    debugsphereonlocation(var_2, (1, 0, 0), 100);
    debugsphereonlocation(var_4.origin, (0, 1, 0), 100);
    thread scripts\mp\utility\debug::drawline(var_2, var_4.origin, 3, (0, 1, 0));
  }

  return var_4;
}

runkillstreakreward(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = undefined;
  var_4 = scripts\mp\gameobjects::createobjidobject(var_0.origin, "_encstr_A7A408B9CA5D1D4E2C63", (0, 0, 72), undefined, "_encstr_9A19040BCDBC");
  var_4.origin = var_0.origin;
  var_4.angles = var_0.angles;
  thread docratedropsmoke(undefined, var_0, 16);
  var_4.iconname = "_encstr_B6DC0AD75AE636BDAD5AE63B";
  var_4.lockupdatingicons = 0;
  var_4 scripts\mp\gameobjects::setobjectivestatusicons(var_2);
  var_4.lockupdatingicons = 1;
  wait 4;
  var_3 = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(var_1.team, var_2, var_0.origin, (0, randomint(360), 0), undefined);
  var_3.skipminimapicon = 1;
  var_3.nevertimeout = 0;
  var_3.waitforobjectiveactivate = 1;
  var_3.killminimapicon = 0;
  var_3.disallowheadiconid = 1;
  var_3.isarmcrate = 1;
  var_3 waittill("_encstr_AA590EF71A80800D1FEAC370EB0FCADD");
  var_4.useobj = var_3;
  var_4.origin = var_3.origin;
  var_5 = 0;
  var_6 = 0.1;
  wait 1;
  var_3 notify("_encstr_8FCA13B789D45636E8D2672BEB0BD8E82D67B047CA");
  scripts\mp\objidpoolmanager::update_objective_onentity(var_4.objidnum, var_3);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_4.objidnum, 72);
  var_4.iconname = "_encstr_B40101";
  var_4.lockupdatingicons = 0;
  var_4 scripts\mp\gameobjects::setobjectivestatusicons(var_2);
  var_4.lockupdatingicons = 1;
  objective_setlabel(var_4.objidnum, "_encstr_B40101");
  var_3 waittill("_encstr_AD75063D571AE108");
  var_4 scripts\mp\gameobjects::setvisibleteam("_encstr_8BBA05185F8B99");
  var_4 scripts\mp\gameobjects::releaseid();
  var_4.visibleteam = "_encstr_8BBA05185F8B99";
}

getkillstreak(var_0) {
  if(!isDefined(level.killstreaktierlist))
    processkillstreaksintotiers();

  level.killstreaktierlist[var_0] = scripts\engine\utility::array_randomize(level.killstreaktierlist[var_0]);
  return level.killstreaktierlist[var_0][0];
}

processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["_encstr_B270105ECB28E94BC5CFABAB937D524C5053", "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", "_encstr_851904B59B34"];
  level.killstreaktierlist[2] = ["_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B", "_encstr_8CC008133958C81BACCB"];
  level.killstreaktierlist[1] = ["_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_851904B59B34", "_encstr_B1B30B51D176511E377A1BC313", "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2"];
  level.killstreaktierlist[0] = ["_encstr_851904B59B34"];
}

br_getrewardicon(var_0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var_0]["_encstr_BE6C080DBA2392367BE6"];
}

_id_11EEE() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(istrue(level.useobjectives))
    level thread _id_11EEF();
}

_id_11EEF() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A91D1B1BA522A00BCFFA68110233CC897B3193F35AC198D55FE323393A");

  for(;;) {
    if(freeze_bomb_case_timer("_encstr_8E8405EA382B2A") == level.objectives.size)
      level thread _id_11EF6("_encstr_8E8405EA382B2A");
    else if(freeze_bomb_case_timer("_encstr_9A8507BA4040188D08") == level.objectives.size)
      level thread _id_11EF6("_encstr_9A8507BA4040188D08");

    waitframe();
  }
}

_id_11EF6(var_0) {
  level notify("_encstr_A91D1B1BA522A00BCFFA68110233CC897B3193F35AC198D55FE323393A");
  level endon("_encstr_BA3D177DBD438758BFD012AAA80517BF3B9EF1EFC4C99B67E1");
  setomnvar("_encstr_B6C31613FBEF422AF099FBCF10A8FE8A41035D0FCD331A4D", scripts\engine\utility::ter_op(var_0 == "_encstr_8E8405EA382B2A", 1, 2));
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 9, 2, 1);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 0, 9, level._id_11BD3);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 1);
  var_1 = 0;
  var_2 = gettime();
  var_3 = level._id_11BD3 * 1000 + var_2;
  setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", level._id_11BD3 * 1000 + var_2);

  while(freeze_bomb_case_timer(var_0) == level.objectives.size) {
    waitframe();

    if(gettime() > var_3) {
      _id_11EF9(var_0);
      level notify("_encstr_BA3D177DBD438758BFD012AAA80517BF3B9EF1EFC4C99B67E1");
    }
  }

  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 0);
  level thread _id_11EEF();
}

_id_11EF9(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level._id_11BD4 = 1;
  level.blocknukekills = 1;

  foreach(var_2 in level.objectives)
  var_2 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");

  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 0);

  foreach(var_5 in level.players) {
    if(isDefined(var_5) && !isbot(var_5) && istrue(var_5.inspawnselection)) {
      if(isDefined(var_5._id_12135)) {
        var_5 clearsoundsubmix("_encstr_AF5F144BBBE0FAAD83FA37E02CBB37AF3658AD959C85");
        var_5._id_12135 stoploopsound(var_5._id_12136);
        var_5._id_12135 delete();
        var_5._id_12135 = undefined;
        var_5._id_12136 = undefined;
      }
    }
  }

  if(isDefined(level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"][0])) {
    var_7 = level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"][0];
    var_7 _calloutmarkerping_handleluinotify_acknowledged::tryusenuke();
  } else
    level thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_9BE90A8A70BD8EB7A6FC2956"], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B4720B5BE5E260CB0FAA883363"], 0, 1);
}

nukeselectgimmewatcher(var_0) {
  if(!istrue(var_0.hasnukeselectks)) {
    var_1 = var_0.killcountthislife % level.killstoearnnukeselect;

    if(var_1 >= 0 && var_0.killcountthislife >= level.killstoearnnukeselect) {
      var_0.hasnukeselectks = 1;
      var_0 thread scripts\mp\killstreaks\killstreaks::givekillstreak("_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637", 0, 0, var_0);
      var_0 scripts\mp\hud_message::showkillstreaksplash("_encstr_9A13159BD5B656BE6EB2362BC63AD7637BB116475AF637", undefined, 1);
    }
  }
}

initspawns(var_0) {
  level.gamemodestartspawnpointnames = [];

  if(istrue(var_0)) {
    var_1 = "_encstr_B49D1979D239072B9F7730A07FF66643B27DE3F5EAD1F773891B18";
    var_2 = "_encstr_BA33174DC1D9FFF7805B3B52A3601F36B85BEBF75F68863B3D";
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A");

    if(var_3.size > 0)
      var_1 = "_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A";

    var_4 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9");

    if(var_4.size > 0)
      var_2 = "_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9";
  } else {
    var_1 = "_encstr_B49D1979D239072B9F7730A07FF66643B27DE3F5EAD1F773891B18";
    var_2 = "_encstr_BA33174DC1D9FFF7805B3B52A3601F36B85BEBF75F68863B3D";
  }

  level.gamemodestartspawnpointnames["_encstr_9A8507BA4040188D08"] = var_1;
  level.gamemodestartspawnpointnames["_encstr_8E8405EA382B2A"] = var_2;
  level.gamemodespawnpointnames = [];
  level.gamemodespawnpointnames["_encstr_9A8507BA4040188D08"] = "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
  level.gamemodespawnpointnames["_encstr_8E8405EA382B2A"] = "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);

  if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_93FB0A6B1C7D2CB92D5EB00D")
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_97B00F74E4BD5DCD8CBA85C9A215C49E9A", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  else if(scripts\cp_mp\utility\game_utility::islargemap())
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_81CC0A74C9EDD5B98CEA859C", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  else
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");

  scripts\mp\spawnlogic::addstartspawnpoints(var_1);
  scripts\mp\spawnlogic::addstartspawnpoints(var_2);
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], var_1);
  scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], var_2);
  var_5 = scripts\mp\spawnlogic::getspawnpointarray(var_1);
  var_6 = scripts\mp\spawnlogic::getspawnpointarray(var_2);
  scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_5);
  scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_6);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
  var_7 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
  var_8 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
  scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_7);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_8);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.spawnpoints = var_7;
}

calculatespawndisttozones(var_0) {
  var_0.scriptdata.distsqtokothzones = [];

  foreach(var_2 in level.objectives) {
    var_3 = getpathdist(var_0.origin, var_2.origin, 5000);

    if(var_3 < 0)
      var_3 = scripts\engine\utility::distance_2d_squared(var_0.origin, var_2.origin);
    else
      var_3 = var_3 * var_3;

    var_0.scriptdata.distsqtokothzones[var_2 getentitynumber()] = var_3;

    if(var_3 > var_2.furthestspawndistsq)
      var_2.furthestspawndistsq = var_3;
  }
}

getspawnpoint() {
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_AD0C095DF195E8B6074A18");
  }

  if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
    var_2 = self getspectatingplayer();

    if(isDefined(var_2) && isDefined(self.squadindex) && self.team == var_2.team && self.squadindex == var_2.squadindex)
      var_1 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_2);
  }

  return var_1;
}

onspawnplayer() {
  self.forcespawnnearteammates = undefined;
  thread updatematchstatushintonspawn();
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.nukeprogress))
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 28);
  else
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 27);
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\mp\menus::updatesquadomnvars(self.team, self.squadindex);
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(level.nukeselectactive && isPlayer(var_1) && var_3 != "_encstr_AB590C99ED78875F650F3951034D") {
    if(!isDefined(var_1.killcountthislife))
      var_1.killcountthislife = 0;

    if(!istrue(var_1.hasnukeselectks))
      var_1.killcountthislife++;

    nukeselectgimmewatcher(var_1);
  }

  if(!isDefined(level.c130pathkilltracker) || level.c130movementmethod != 1) {
    return;
  }
  level.c130pathkilltracker[self.team] = level.c130pathkilltracker[self.team] + 1;
}

managedroppedents(var_0) {
  if(!isDefined(level.br_droppedloot))
    level.br_droppedloot = [];

  if(level.br_droppedloot.size > 64) {
    for(var_1 = 0; var_1 < 16; var_1++) {
      if(isDefined(level.br_droppedloot[var_1])) {
        level.br_droppedloot[var_1] delete();
        level.br_droppedloot[var_1] = undefined;
      }
    }

    var_2 = [];

    for(var_1 = 16; var_1 < level.br_droppedloot.size; var_1++)
      var_2[var_1 - 16] = level.br_droppedloot[var_1];

    level.br_droppedloot = var_2;
  }

  foreach(var_4 in var_0)
  level.br_droppedloot[level.br_droppedloot.size] = var_4;

  if(!isDefined(level.br_pickups.droppeditems))
    level.br_pickups.droppeditems = [];

  if(level.br_pickups.droppeditems.size > 64) {
    for(var_1 = 0; var_1 < 16; var_1++) {
      if(isDefined(level.br_pickups.droppeditems[var_1])) {
        level.br_pickups.droppeditems[var_1] delete();
        level.br_pickups.droppeditems[var_1] = undefined;
      }
    }

    var_2 = [];

    for(var_1 = 16; var_1 < level.br_pickups.droppeditems.size; var_1++)
      var_2[var_1 - 16] = level.br_pickups.droppeditems[var_1];

    level.br_pickups.droppeditems = var_2;
  }
}

onplayerconnect(var_0) {
  if(isDefined(level.rallypointvehicles))
    thread scripts\mp\rally_point::rallypoint_showtoplayer(var_0);

  if(istrue(level._id_1408C))
    var_0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();

  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
}

onplayerdisconnect(var_0) {
  thread scripts\mp\spawnselection::_id_12ACB(var_0.team, var_0.squadindex);
}

updategamemodespawncamera() {
  var_0 = "_encstr_BD3209B116372B8123BED0";

  if(isDefined(level.activezone))
    var_0 = level.activezone.zonetrigger.script_label;

  scripts\mp\spawncamera::setgamemodecamera("_encstr_9A8507BA4040188D08", level.spawncameras[var_0]["_encstr_9A8507BA4040188D08"]);
  scripts\mp\spawncamera::setgamemodecamera("_encstr_8E8405EA382B2A", level.spawncameras[var_0]["_encstr_8E8405EA382B2A"]);
}

debugdrawtocameras() {
  for(;;) {
    wait 0.25;

    if(!isDefined(level.players[0])) {
      continue;
    }
    foreach(var_5, var_1 in level.spawncameras) {
      foreach(var_4, var_3 in var_1) {
        thread scripts\mp\utility\debug::drawangles(var_3.origin, var_3.angles, 0.25, 50);
        thread scripts\mp\utility\debug::drawsphere(var_3.origin, 50.0, 0.25, scripts\engine\utility::ter_op(var_4 == "_encstr_9A8507BA4040188D08", (0, 0, 1), (1, 0, 0)));
      }
    }
  }
}

onplayerspawned(var_0) {
  for(;;)
    var_0 waittill("_encstr_BA350853C128FB939DB9");
}

getownerteamplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

getrespawndelay() {
  self.spawncameraskipthermal = 0;
  return undefined;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

_encstr_BA220EFA2B2857FAAEF19F8F115FA3BD(var_0, var_1) {
  self setspectatedefaults(var_0, var_1);
  self spawn(var_0, var_1);
  scripts\mp\utility\player::_id_12898("_encstr_85B3286E7B580A8F9EC19FCFD556F38DC043E6B331CA5166DF7BA6076FF5E880196F16F3CCEAE18E67D1" + var_0);
}

_id_12065() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.sessionteam == "_encstr_8BBA05185F8B99" || self calloutmarkerping_getEnt())
    return 1;

  if(isDefined(self.thrust_fx_model))
    return 0;

  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.gamemodestartspawnpointnames[self.sessionteam]);
  var_1 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_0);
  self.thrust_fx_model = var_1;
  _encstr_BA220EFA2B2857FAAEF19F8F115FA3BD(var_1.origin, var_1.angles);
  return 0;
}

_id_125F1() {
  return self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" && isDefined(self.thrust_fx_model);
}

initspecatatorcameras() {
  level.spectatorcameras = [];
  level.currentspectatorcamref = "_encstr_9B8E06A6CD13AF4B";
  var_0 = scripts\engine\utility::getStructArray("_encstr_A7B213D1BF0A90383892BEF03E708136621B7D134F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = var_2.script_noteworthy;
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_6 in var_4) {
      switch (var_6.script_label) {
        case "_encstr_A11E11297F3177A8BC8C718B399B08B94AE3FB":
          setteammapposition(var_3, "_encstr_9A8507BA4040188D08", var_6);
          break;
        case "_encstr_8C500F3ADBFAC2F02DB9EB6CB0DACA39B0":
          setteammapposition(var_3, "_encstr_8E8405EA382B2A", var_6);
          break;
      }
    }
  }
}

setteammapposition(var_0, var_1, var_2) {
  if(!isDefined(level.spectatorcameras[var_0]))
    level.spectatorcameras[var_0] = [];

  level.spectatorcameras[var_0][var_1] = var_2;
}

applythermal() {
  self visionsetthermalforplayer("_encstr_B60A15ABAB38AB4AE13741AE77D9F75F8D4AC4EE815F1A");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

startspectatorview() {
  if(scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  waitframe();
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  var_0 = 0;
  var_1 = undefined;
  var_2 = (0, 0, 0);
  var_3 = 1000;
  var_4 = self.origin + (0, 0, var_3);
  var_5 = self.angles;
  self.deathspectatepos = var_4;
  self.deathspectateangles = var_5;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self getvieworigin());
  var_6 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6.angles = var_5;
  self.spectatorcament = var_6;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_6, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  thread dohalfwayflash();
  var_6 movecameratomappos(self, var_4, var_5);
}

dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }
  removethermal();
  thread runslamzoomonspawn();
}

movecameratomappos(var_0, var_1, var_2) {
  var_0 endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_3 = 1.0;
  var_4 = 1.0;
  self moveTo(var_1, 2.0, 1.0, 1.0);
  var_0 playlocalsound("_encstr_8867179032B9E625040796C93205D5E02FFAA21721E86F3D6B");
  var_0 setclienttriggeraudiozonepartialwithfade("_encstr_AC230AABDAA970F821572333", 0.5, "_encstr_AB1904853B28");
  self rotateTo(var_2, 2.0, 1.0, 1.0);
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 = var_5 * (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0.spectatorcament)) {
    self moveTo(var_1 + var_5, 15.0, 1.0, 1.0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_5, 1000);
  }
}

runslamzoomonspawn() {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self cameralinkTo(self.spectatorcament, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.2);
  self.spectatorcament moveTo(var_0, 0.5);
  self playlocalsound("_encstr_A39D1618AAE7A00982B7171B57BACE084F80C0D0153F38B0");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(var_1, 0.5, 0.5);
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }
  self visionsetnakedforplayer("_encstr_B40101", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");
  self cameraunlink();
  self.spectatorcament delete();
}

playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

arm_playstatusdialog(var_0, var_1) {
  var_2 = "_encstr_A3820DC80FEB6B1C58AF5D6E1D1BFA" + var_0;
  var_2 = tolower(var_2);
  var_3 = undefined;

  if(var_1 == "_encstr_8A0F0A95308BF4B191BA9A52") {
    var_4 = scripts\mp\utility\teams::getteamdata("_encstr_8E8405EA382B2A", "_encstr_9775086022BE1B413B8B");
    var_5 = scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B");
    var_3 = scripts\engine\utility::array_combine(var_4, var_5);
  } else if(var_1 == "_encstr_8E8405EA382B2A" || var_1 == "_encstr_9A8507BA4040188D08")
    var_3 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  foreach(var_7 in var_3) {
    if(!isbot(var_7))
      var_7 arm_leaderdialogonplayer_internal(var_2, var_0);
  }
}

arm_playstatusdialogonplayer(var_0) {
  var_1 = "_encstr_8C13179BF9A8D270F01EB33A53B097AA987D2F57ADEE1A4AD9" + var_0;
  var_1 = tolower(var_1);
  arm_leaderdialogonplayer_internal(var_1, var_0);
}

arm_leaderdialogonplayer_internal(var_0, var_1) {
  if(isDefined(self.playerlastdialogstatus)) {
    var_2 = 5000;

    if(gettime() < self.playerlastdialogstatus["_encstr_84EF055338A18F"] + var_2 && self.playerlastdialogstatus["_encstr_B2DA070A5F8BAB87AF"] == var_1) {
      return;
    }
    self.playerlastdialogstatus["_encstr_84EF055338A18F"] = gettime();
    self.playerlastdialogstatus["_encstr_B2DA070A5F8BAB87AF"] = var_1;
  }

  if(soundexists(var_0))
    self queuedialogforplayer(var_0, var_1, 2);
}

managec130spawns() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 6000;
  var_1 = 12000;
  var_2 = 20000;
  var_3 = 1;
  var_4 = (0, 0, 6000);
  level.timebetweenc130passes = 0;
  level.flighttime = 20;
  level.spawnc130 = [];

  foreach(var_6 in level.teamnamelist)
  level.spawnc130[var_6] = undefined;

  c130_pickrandomflightpath();
  level.spawnc130["_encstr_8E8405EA382B2A"] = createc130("_encstr_8E8405EA382B2A", level.c130pathstruct_a.startpt + var_4);
  level.spawnc130["_encstr_9A8507BA4040188D08"] = createc130("_encstr_9A8507BA4040188D08", level.c130pathstruct_b.startpt + var_4);

  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  for(;;) {
    if(!isDefined(level.timeuntilnextc130))
      level.timeuntilnextc130 = [];

    if(!isDefined(level.timeuntilnextc130["_encstr_8E8405EA382B2A"]))
      level.timeuntilnextc130["_encstr_8E8405EA382B2A"] = 0;

    if(!isDefined(level.timeuntilnextc130["_encstr_9A8507BA4040188D08"]))
      level.timeuntilnextc130["_encstr_9A8507BA4040188D08"] = 0;

    var_8 = gettime() + (level.flighttime + level.timebetweenc130passes) * 1000;
    level.timeuntilnextc130["_encstr_8E8405EA382B2A"] = var_8;
    level.timeuntilnextc130["_encstr_9A8507BA4040188D08"] = var_8;

    if(0) {
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1000, (1, 0, 0));
      thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1000, (0, 0, 1));
    }

    if(var_3) {
      level.spawnc130["_encstr_8E8405EA382B2A"] thread handlec130motion(level.c130pathstruct_a.startpt + var_4, level.c130pathstruct_a.endpt + var_4, level.flighttime, "_encstr_8E8405EA382B2A");
      level.spawnc130["_encstr_9A8507BA4040188D08"] thread handlec130motion(level.c130pathstruct_b.startpt + var_4, level.c130pathstruct_b.endpt + var_4, level.flighttime, "_encstr_9A8507BA4040188D08");
    } else {
      level.spawnc130["_encstr_8E8405EA382B2A"] thread handlec130motion(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, level.flighttime, "_encstr_8E8405EA382B2A");
      level.spawnc130["_encstr_9A8507BA4040188D08"] thread handlec130motion(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, level.flighttime, "_encstr_9A8507BA4040188D08");
    }

    level.c130firstpassstarted = 1;
    level scripts\engine\utility::waittill_all_in_array(["_encstr_8BF51840FA1762176BEF2C38E8518F7DF968AAABF077EE43A0CE", "_encstr_97B61AAF2AC398595107A3DC601F129DF3688FFB10A601B2512BEF12"]);
    c130_fightpathmove();
    var_9 = level.c130pathstruct_a.startpt;
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.endpt;
    level.c130pathstruct_a.endpt = var_9;
    var_9 = level.c130pathstruct_b.startpt;
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.endpt;
    level.c130pathstruct_b.endpt = var_9;
    var_3 = 0;

    if(istrue(level.usec130spawnfirstonly)) {
      level.usec130spawn = 0;
      break;
    }
  }

  scripts\mp\spawnselection::removedynamicspawnarea("_encstr_8E8405EA382B2A", "_encstr_82140D8C2FCDB0B5B4D8EBB1C4330C");
  scripts\mp\spawnselection::removedynamicspawnarea("_encstr_9A8507BA4040188D08", "_encstr_82140D8C2FCDB0B5B4D8EBB1C4330C");
  scripts\mp\spawnselection::removespawnlocation("_encstr_82140D8C2FCDB0B5B4D8EBB1C4330C", "_encstr_8E8405EA382B2A");
  scripts\mp\spawnselection::removespawnlocation("_encstr_82140D8C2FCDB0B5B4D8EBB1C4330C", "_encstr_9A8507BA4040188D08");
  level.spawnc130["_encstr_8E8405EA382B2A"] delete();
  level.spawnc130["_encstr_9A8507BA4040188D08"] delete();
}

createc130(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_2 setModel("_encstr_95F719D9AC34C1D7D65A63AF2CB49CF52C8D3416396396594C990C");
  var_2 setCanDamage(0);
  var_2.maxhealth = 100000;
  var_2.health = var_2.maxhealth;
  var_2.playeroffsets = [(32, 30, 0), (-32, 30, 0), (0, 30, 0), (16, 30, 0), (-16, 30, 0)];
  var_2.currentplayeroffset = 0;
  var_2.respawnqueue = [];
  var_2.players = [];
  var_2.team = var_0;
  var_2 playLoopSound("_encstr_9AD91096EE07AFD6B9F5166C896603AF3683");
  var_2 thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::gunship_spawnvfx();
  return var_2;
}

handlec130motion(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = distance(var_1, var_0);
  var_6 = var_0 + var_4 * var_5 * 0.425;
  var_7 = var_0 + var_4 * var_5 * 0.55;
  var_8 = var_2 * 0.3;
  var_9 = var_2 * 0.6;
  var_10 = var_2 * 0.1;
  self.canjoin = 1;
  self.canparachute = 0;
  var_11 = vectorNormalize(var_1 - var_0);
  self.angles = vectortoangles(var_11);
  self.origin = var_0;
  gatherc130playerstospawn();
  self moveTo(var_1, var_8 + var_9 + var_10, var_8 * 0.25);
  wait(var_8);
  self.canparachute = 1;

  foreach(var_13 in self.players)
  var_13 notify("_encstr_87870D404AC5C149A311C64BFD4331");

  wait(var_9);
  self.canjoin = 0;
  self.canparachute = 0;

  foreach(var_13 in self.players)
  var_13 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");

  wait(var_10);
  level notify("_encstr_BE9714A7E6173FD1406EB348993B18D97B3B53412F39" + var_3);
}

gatherc130playerstospawn() {
  self.players = scripts\engine\utility::array_combine(self.players, self.respawnqueue);
  self.respawnqueue = [];
  var_0 = 1400;
  var_1 = (30, 0, 0);
  var_2 = anglesToForward(var_1) * var_0 * -1;
  var_3 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37") + var_2;
  var_4 = self.angles;

  foreach(var_6 in self.players) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_6.forcespawncameraorg = var_3;
    var_6.forcespawncameraang = var_4;
    var_6 notify("_encstr_B2210BB189CC60AF9CAC16C8BC");
  }
}

removefromspawnselectionaftertime(var_0) {
  wait(var_0);
  removefromspawnselection();
}

removefromspawnselection() {
  scripts\mp\spawnselection::removedynamicspawnarea(self.team, "_encstr_82140D8C2FCDB0B5B4D8EBB1C4330C");
  scripts\mp\spawnselection::removespawnlocation("_encstr_82140D8C2FCDB0B5B4D8EBB1C4330C", self.team);
}

spawnplayertoc130() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(level.spawnc130[self.team])) {
    return;
  }
  self waittill("_encstr_883D12A03B66AF883733E7E90DBB5137CCE2D0E8");
  var_0 = level.spawnc130[self.team];
  var_0.respawnqueue[var_0.respawnqueue.size] = self;

  if(istrue(var_0.canjoin))
    var_0 gatherc130playerstospawn();

  if(istrue(self.inspawncamera))
    self waittill("_encstr_A2FB163B03BFCF8DE1E7495DF3D01627D698529328051B87");
  else
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  scripts\common\utility::allow_killstreaks(0);
  self disableusability();
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self setCanDamage(0);
  thread jumplistener(var_0, 0);
  self.br_infil_type = "_encstr_969105B1C4CC81";

  if(!isbot(self))
    thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::orbitcam(var_0);
}

jumplistener(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A2B30F4DABDA83312D371DACCD959C4192");
  self endon("_encstr_A2B30F4DABDA83312D371DACCD959C4192");

  if(isDefined(self.parachute))
    self.parachute delete();

  scripts\mp\utility\game::_id_131A3(self, 1);
  thread listenjump(var_0, var_1);
  thread listenkick(var_0, var_1);
}

listenkick(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8F7D08C66A0125438523");
  self notify("_encstr_97550D62E7673C61B5F1421F9A48C3");
  self endon("_encstr_97550D62E7673C61B5F1421F9A48C3");
  self waittill("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
  self cameradefault();
  self unlink();
  wait 0.1;

  if(self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    return;
  }
  var_2 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::calctrailpoint();
  thread parachute(var_0, var_1);
  self notify("_encstr_8F7D08C66A0125438523");
  self notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
}

listenjump(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8F7D08C66A0125438523");
  self notify("_encstr_BE3D0DE959F288959BB8BBA0035A7B");
  self endon("_encstr_BE3D0DE959F288959BB8BBA0035A7B");
  self notifyonplayercommand("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82", "_encstr_B44609DFE707CF394E1651");

  for(;;) {
    var_2 = scripts\engine\utility::waittill_either("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82", "_encstr_87870D404AC5C149A311C64BFD4331");

    if(isDefined(var_2) && var_2 == "_encstr_87870D404AC5C149A311C64BFD4331")
      self iprintlnbold("_encstr_925A1931A0FBF2E7213A6D7D3FF9233D9949AA8B904F6CB7C38501");
    else if(!istrue(var_0.canparachute))
      self iprintlnbold("_encstr_A15B101057EB399FDB1AC05A2374B38197EF");
    else
      break;

    if(self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D")
      return;
  }

  self cameradefault();
  self unlink();
  wait 0.1;
  thread parachute(var_0, var_1);
  self notify("_encstr_8F7D08C66A0125438523");
  self notify("_encstr_BA690F0390EF325749AF754FBEF0773C13");
}

parachute(var_0, var_1) {
  self endon("_encstr_A2B30F4DABDA83312D371DACCD959C4192");
  self notify("_encstr_A9200C8307F251BFF2335DED5CDE");
  self endon("_encstr_A9200C8307F251BFF2335DED5CDE");

  if(self.team == "_encstr_8E8405EA382B2A")
    var_2 = level.c130pathstruct_b.midpt;
  else
    var_2 = level.c130pathstruct_a.midpt;

  var_3 = vectorNormalize(var_2 - var_0.origin);
  var_0.players = scripts\engine\utility::array_remove(var_0.players, self);

  if(isDefined(var_0.playeroffsets) && isDefined(var_0.currentplayeroffset)) {
    var_4 = var_0.playeroffsets[var_0.currentplayeroffset];
    self setOrigin(var_0.origin + var_4, 1, 1);
    var_0.currentplayeroffset++;

    if(var_0.currentplayeroffset == var_0.playeroffsets.size)
      var_0.currentplayeroffset = 0;
  } else {
    var_5 = anglesToForward(var_0.angles) * var_0.br_vieworigin;
    self setOrigin(var_0.origin + var_5, 1, 1);
  }

  waitframe();
  self playershow();
  self.plotarmor = 0;
  scripts\mp\utility\game::_id_131A3(self, 0);
  self setplayerangles(vectortoangles(var_3));
  thread scripts\cp_mp\parachute::startfreefall(5.0, 0);
}

debug_randomflightpathstest() {
  wait 10;

  for(;;) {
    c130_pickrandomflightpath();
    level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt - (0, 0, 10000);
    level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt - (0, 0, 10000);
    level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt - (0, 0, 10000);
    level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt - (0, 0, 10000);
    thread scripts\mp\utility\debug::drawline(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1, (1, 0, 1));
    thread scripts\mp\utility\debug::drawline(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1, (1, 0, 1));
    wait 1;
  }
}

c130_pickrandomflightpath() {
  if(istrue(level.c130alignedtolocale) && istrue(level.useobjectives)) {
    var_0 = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
    var_1 = vectortoangles(level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin);
    var_2 = var_1[1];

    if(0)
      debugsphereonlocation(var_0, (0, 1, 0), 100000);
  } else {
    var_0 = (level.mapsafecorners[0] + level.mapsafecorners[1]) * 0.5;
    var_2 = randomfloatrange(0, 359);
  }

  var_3 = makec130pathparamsstruct(var_0, var_2 - 90);
  level.c130pathstruct_a = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::makepathstruct(var_3);
  var_3.randomangle = var_3.randomangle + 180;
  level.c130pathstruct_b = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::makepathstruct(var_3);
  var_4 = 0.2;
  var_5 = 0;
  var_6 = 0;

  if(istrue(level.c130spacing_usebigmapsettings)) {
    var_4 = 0.1;
    var_5 = randomfloatrange(-5000.0, 5000);
    var_6 = randomfloatrange(-5000.0, 5000);
  }

  var_7 = anglestoright(level.c130pathstruct_a.angle);
  level.c130pathstruct_a.startpt = var_7 * level.c130distapart + level.c130pathstruct_a.startpt;
  level.c130pathstruct_a.endpt = var_7 * level.c130distapart + level.c130pathstruct_a.endpt;
  var_7 = anglestoright(level.c130pathstruct_b.angle);
  level.c130pathstruct_b.startpt = var_7 * level.c130distapart + level.c130pathstruct_b.startpt;
  level.c130pathstruct_b.endpt = var_7 * level.c130distapart + level.c130pathstruct_b.endpt;
  var_8 = (var_5, var_6, 0);
  level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + var_8;
  level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + var_8;
  level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
  level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + var_8;
  level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + var_8;
  level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
  level.battlecenter = vectorlerp(level.c130pathstruct_a.midpt, level.c130pathstruct_b.midpt, 0.5);
  level.c130minpathmovementinterval = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_b.endpt, var_4);
  level.c130minpathmovementinterval = level.c130minpathmovementinterval - level.c130pathstruct_a.startpt;
  level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * level.c130distapart / 10;
  level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);
}

makec130pathparamsstruct(var_0, var_1) {
  var_2 = 6.28318;
  var_3 = var_1;
  var_4 = 180;
  var_5 = level.c130flightdist;
  var_6 = spawnStruct();
  var_6.r = var_5;
  var_6.randomangle = var_3;
  var_6.endangleoffset = var_4;
  var_6.centerpt = var_0;
  return var_6;
}

c130_fightpathmove() {
  if(0)
    level.c130movementmethod = 2;

  if(level.c130movementmethod == 0)
    return;
  else if(level.c130movementmethod == 1) {
    if(0) {
      level.c130pathkilltracker["_encstr_8E8405EA382B2A"] = 1;
      level.c130pathkilltracker["_encstr_9A8507BA4040188D08"] = 0;
    }

    if(level.c130pathkilltracker["_encstr_8E8405EA382B2A"] > level.c130pathkilltracker["_encstr_9A8507BA4040188D08"]) {
      if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
        level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + level.c130minpathmovementinterval;
        level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + level.c130minpathmovementinterval;
        level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + level.c130minpathmovementinterval;
        level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + level.c130minpathmovementinterval;
      }
    } else if(arenextpathsinsafebounds(level.c130minpathmovementinterval * -1.0)) {
      level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt - level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt - level.c130minpathmovementinterval;
      level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt - level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt - level.c130minpathmovementinterval;
    }

    level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
    level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);
    level.c130pathkilltracker["_encstr_8E8405EA382B2A"] = 0;
    level.c130pathkilltracker["_encstr_9A8507BA4040188D08"] = 0;
  } else if(level.c130movementmethod == 2) {
    var_0 = (0, 0, 0);
    var_1 = (0, 0, 0);
    var_2 = 0;
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(isalive(var_5)) {
        if(var_5.team == "_encstr_8E8405EA382B2A") {
          var_0 = var_0 + var_5.origin;
          var_2++;
          continue;
        }

        if(var_5.team == "_encstr_9A8507BA4040188D08") {
          var_1 = var_1 + var_5.origin;
          var_3++;
        }
      }
    }

    if(var_2 == 0 || var_3 == 0) {
      return;
    }
    var_7 = var_0 / var_2;
    var_8 = var_1 / var_3;
    var_9 = vectorlerp(var_7, var_8, 0.5);
    level.c130minpathmovementinterval = vectorlerp(level.battlecenter, var_9, 0.5);
    level.c130minpathmovementinterval = level.c130minpathmovementinterval - level.battlecenter;
    var_10 = distance2d(level.battlecenter, var_9);
    level.c130minpathmovementinterval = vectorNormalize(level.c130minpathmovementinterval) * var_10 / 4;
    level.c130minpathmovementinterval = (level.c130minpathmovementinterval[0], level.c130minpathmovementinterval[1], 0);

    if(arenextpathsinsafebounds(level.c130minpathmovementinterval)) {
      level.c130pathstruct_a.startpt = level.c130pathstruct_a.startpt + level.c130minpathmovementinterval;
      level.c130pathstruct_a.endpt = level.c130pathstruct_a.endpt + level.c130minpathmovementinterval;
      level.c130pathstruct_a.midpt = vectorlerp(level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5);
      level.c130pathstruct_b.startpt = level.c130pathstruct_b.startpt + level.c130minpathmovementinterval;
      level.c130pathstruct_b.endpt = level.c130pathstruct_b.endpt + level.c130minpathmovementinterval;
      level.c130pathstruct_b.midpt = vectorlerp(level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5);

      if(0) {
        debugsphereonlocation(level.battlecenter, (1, 0, 0), 700);
        debugsphereonlocation(var_9, (0, 1, 0), 700);
      }

      level.battlecenter = level.battlecenter + level.c130minpathmovementinterval;
    }
  }
}

arenextpathsinsafebounds(var_0) {
  return ispointinsafebounds(level.c130pathstruct_a.startpt + var_0) && ispointinsafebounds(level.c130pathstruct_a.endpt + var_0) && ispointinsafebounds(level.c130pathstruct_b.startpt + var_0) && ispointinsafebounds(level.c130pathstruct_b.endpt + var_0);
}

ispointinsafebounds(var_0) {
  return var_0[0] < level.mapsafecorners[0][0] && var_0[0] > level.mapsafecorners[1][0] && var_0[1] < level.mapsafecorners[0][1] && var_0[1] > level.mapsafecorners[1][1];
}

registervehicletype(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.spawncallback = var_2;
  var_3.vehiclespawns = [[var_1]]();

  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  level.vehicleinfo[var_0] = var_3;
}

init_groundwarvehicles() {
  level.ignorevehicletypeinstancelimit = 1;
  registervehicletype("_encstr_84D70A6B2BEF3C9B30A67164", scripts\cp_mp\vehicles\technical::technical_getspawnstructscallback, ::vehiclespawn_truck);
  registervehicletype("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", scripts\cp_mp\vehicles\little_bird::little_bird_getspawnstructscallback, ::vehiclespawn_littlebird);
  registervehicletype("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", _calloutmarkerping_poolidisdanger::x1stash_detectplayers, ::_id_14266);
  registervehicletype("_encstr_8FE608B268BFF756987D", scripts\cp_mp\vehicles\cop_car::cop_car_getspawnstructscallback, ::vehiclespawn_copcar);
  registervehicletype("_encstr_8C190467402B", scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, ::vehiclespawn_atv);
  registervehicletype("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", scripts\cp_mp\vehicles\cargo_truck::cargo_truck_getspawnstructscallback, ::vehiclespawn_cargotruck);
  registervehicletype("_encstr_91CD07D045CF0B0BB8", scripts\cp_mp\vehicles\hoopty::hoopty_getspawnstructscallback, ::vehiclespawn_hoopty);
  registervehicletype("_encstr_8BAA0D68183D43A35319057A93B767", scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_getspawnstructscallback, ::vehiclespawn_hooptytruck);
  registervehicletype("_encstr_85DE05A6B2AC0E", scripts\cp_mp\vehicles\jeep::jeep_getspawnstructscallback, ::vehiclespawn_jeep);
  registervehicletype("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", scripts\cp_mp\vehicles\large_transport::large_transport_getspawnstructscallback, ::vehiclespawn_largetransport);
  registervehicletype("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", scripts\cp_mp\vehicles\med_transport::med_transport_getspawnstructscallback, ::vehiclespawn_medtransport);
  registervehicletype("_encstr_8FD60D6AA0EAB34083F7C423A0213B", scripts\cp_mp\vehicles\pickup_truck::pickup_truck_getspawnstructscallback, ::vehiclespawn_pickuptruck);
  registervehicletype("_encstr_9A120A1D8536F5E4ED3BB293", scripts\cp_mp\vehicles\tac_rover::tac_rover_getspawnstructscallback, ::vehiclespawn_tacrover);
  registervehicletype("_encstr_911904464232", scripts\cp_mp\vehicles\van::van_getspawnstructscallback, ::vehiclespawn_van);
  registervehicletype("_encstr_AF390B295782C3585F1B21D8C4", scripts\cp_mp\vehicles\light_tank::light_tank_getspawnstructscallback, ::vehiclespawn_tank);
  level.vehiclespawnlocs = [];
  level.tankspawnlocs_axis = [];
  level.tankspawnlocs_allies = [];

  foreach(var_1 in level.vehicleinfo) {
    if(var_1.refname == "_encstr_AF390B295782C3585F1B21D8C4" && level.mapname == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB" && level.localeid == "_encstr_8A34097127C761890FA9D2") {
      var_2 = [];
      var_3 = [];
      var_2[0] = (17465, -21971, -150);
      var_3[0] = (10, 90, 0);
      var_2[1] = (16460, -22045, -150);
      var_3[1] = (358, 26, 0);
      var_4 = 0;
      var_5 = [];
      var_6 = [];
      var_5[0] = (19430, -2396, -380);
      var_6[0] = (7, 315, 0);
      var_5[1] = (21100, -2356, -380);
      var_6[1] = (7, 219, 0);
      var_7 = 0;

      foreach(var_9 in var_1.vehiclespawns) {
        if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "_encstr_8A34097127C761890FA9D2") {
          if(isDefined(var_9.script_team) && var_9.script_team == "_encstr_8E8405EA382B2A") {
            var_9.origin = var_2[var_4];
            var_9.angles = var_3[var_4];
            var_4++;
            continue;
          }

          if(isDefined(var_9.script_team) && var_9.script_team == "_encstr_9A8507BA4040188D08") {
            var_9.origin = var_5[var_7];
            var_9.angles = var_6[var_7];
            var_7++;
          }
        }
      }
    }

    if(var_1.refname == "_encstr_8C190467402B") {
      if(level.mapname == "_encstr_93D20D28714743B99070632BAF3944" && level.localeid == "_encstr_AF3409DC18C12FBD6B6107") {
        var_11 = [];
        var_12 = [];
        var_11[0] = (46022, 1039, 56);
        var_12[0] = (7, 289, 0);
        var_11[1] = (47881, -1404, 115);
        var_12[1] = (8, 294, 0);
        var_11[2] = (47970, -22545, -320);
        var_12[2] = (9, 105, 0);

        for(var_13 = 0; var_13 < var_11.size; var_13++) {
          var_14 = spawnStruct();
          var_14.origin = var_11[var_13];
          var_14.angles = var_12[var_13];
          var_14.script_noteworthy = "_encstr_AF3409DC18C12FBD6B6107";
          var_14.targetname = "_encstr_BE7E0A0F2843CFA3792F7B35";
          var_14.vehicletype = "_encstr_9A981257491E559F356058E910276A60A359D570";
          var_1.vehiclespawns[var_1.vehiclespawns.size] = var_14;
        }

        foreach(var_9 in var_1.vehiclespawns) {
          if(distancesquared(var_9.origin, (53109, -8400, -710)) < 16384) {
            var_9.origin = (46868, -457, 18);
            var_9.angles = (11, 252, 0);
            continue;
          }

          if(distancesquared(var_9.origin, (48215, -1671, 56)) < 16384) {
            var_9.origin = (47906, -676, 55);
            var_9.angles = (11, 309, 0);
          }
        }
      } else if(level.mapname == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB" && level.localeid == "_encstr_8A34097127C761890FA9D2") {
        var_11 = [];
        var_12 = [];
        var_11[0] = (17806, -20823, -110);
        var_12[0] = (11, 358, 0);
        var_11[1] = (16109, -24057, -144);
        var_12[1] = (1, 90, 0);
        var_11[2] = (18227, -704, -448);
        var_12[2] = (7, 266, 0);
        var_11[3] = (19180, 332, -447);
        var_12[3] = (6, 298, 0);

        for(var_13 = 0; var_13 < var_11.size; var_13++) {
          var_14 = spawnStruct();
          var_14.origin = var_11[var_13];
          var_14.angles = var_12[var_13];
          var_14.script_noteworthy = "_encstr_8A34097127C761890FA9D2";
          var_14.targetname = "_encstr_BE7E0A0F2843CFA3792F7B35";
          var_14.vehicletype = "_encstr_9A981257491E559F356058E910276A60A359D570";
          var_1.vehiclespawns[var_1.vehiclespawns.size] = var_14;
        }

        foreach(var_9 in var_1.vehiclespawns) {
          if(distancesquared(var_9.origin, (18368, -21157, -107)) < 16384) {
            var_9.origin = (16572, -19828, 86);
            var_9.angles = (2, 55, 0);
            continue;
          }

          if(distancesquared(var_9.origin, (19526, -15475, -97)) < 16384) {
            var_9.origin = (19177, -15490, -116);
            var_9.angles = (2, 64, 0);
          }
        }
      }
    }

    if(var_1.refname == "_encstr_9A120A1D8536F5E4ED3BB293") {
      if(level.mapname == "_encstr_93D20D28714743B99070632BAF3944" && level.localeid == "_encstr_AF3409DC18C12FBD6B6107") {
        var_11 = [];
        var_12 = [];
        var_11[0] = (48384, -1703, 70);
        var_12[0] = (7, 260, 0);
        var_11[1] = (50216, -22058, -336);
        var_12[1] = (5, 84, 0);

        for(var_13 = 0; var_13 < var_11.size; var_13++) {
          var_14 = spawnStruct();
          var_14.origin = var_11[var_13];
          var_14.angles = var_12[var_13];
          var_14.script_noteworthy = "_encstr_AF3409DC18C12FBD6B6107";
          var_14.targetname = "_encstr_9B910F8E2C36937BD956E47DCDC10BEECD";
          var_14.vehicletype = "_encstr_B849127B4D1072C5E07E929C52E8016AF6FF87E3";
          var_1.vehiclespawns[var_1.vehiclespawns.size] = var_14;
        }
      } else if(level.mapname == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB" && level.localeid == "_encstr_8A34097127C761890FA9D2") {
        var_11 = [];
        var_12 = [];
        var_11[0] = (21969, -11928, -156);
        var_12[0] = (7, 269, 0);
        var_11[1] = (16413, -22817, -144);
        var_12[1] = (7, 85, 0);

        for(var_13 = 0; var_13 < var_11.size; var_13++) {
          var_14 = spawnStruct();
          var_14.origin = var_11[var_13];
          var_14.angles = var_12[var_13];
          var_14.script_noteworthy = "_encstr_8A34097127C761890FA9D2";
          var_14.targetname = "_encstr_9B910F8E2C36937BD956E47DCDC10BEECD";
          var_14.vehicletype = "_encstr_B849127B4D1072C5E07E929C52E8016AF6FF87E3";
          var_1.vehiclespawns[var_1.vehiclespawns.size] = var_14;
        }
      }
    }

    if(var_1.refname == "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6" && level.mapname == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB" && level.localeid == "_encstr_8A34097127C761890FA9D2") {
      foreach(var_9 in var_1.vehiclespawns) {
        if(distancesquared(var_9.origin, (20559, -24015, -105)) < 16384) {
          var_9.origin = (18119, -21282, -118);
          var_9.angles = (6, 55, 0);
        }
      }
    }

    foreach(var_9 in var_1.vehiclespawns) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == level.localeid) {
        if(var_1.refname == "_encstr_AF390B295782C3585F1B21D8C4") {
          if(isDefined(var_9.script_team) && var_9.script_team == "_encstr_8E8405EA382B2A") {
            var_22 = level.tankspawnlocs_axis.size;
            level.tankspawnlocs_axis[var_22] = var_9;
            level.tankspawnlocs_axis[var_22].refname = var_1.refname;
          } else if(isDefined(var_9.script_team) && var_9.script_team == "_encstr_9A8507BA4040188D08") {
            var_22 = level.tankspawnlocs_allies.size;
            level.tankspawnlocs_allies[var_22] = var_9;
            level.tankspawnlocs_allies[var_22].refname = var_1.refname;
          }

          continue;
        }

        if(istrue(level.matchdata_logvictimkillevent) && var_1.refname == "_encstr_85DE05A6B2AC0E" || istrue(level.matchdata_logscoreevent) && var_1.refname == "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6")
          continue;
        else {
          var_22 = level.vehiclespawnlocs.size;
          level.vehiclespawnlocs[var_22] = var_9;
          level.vehiclespawnlocs[var_22].refname = var_1.refname;
        }
      }
    }
  }

  if(0) {
    foreach(var_26 in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(var_26.origin, var_26.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var_28 = level._id_11F41;

  if(!isDefined(level._id_11F41))
    var_28 = 25;

  if(0) {
    for(var_13 = 0; var_13 < var_28; var_13++) {
      var_26 = level.vehiclespawnlocs[var_13];
      thread scripts\mp\utility\debug::drawline(var_26.origin + (0, 0, 1500), var_26.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var_13 = 0; var_13 < var_28; var_13++) {
    var_26 = level.vehiclespawnlocs[var_13];

    if(isDefined(var_26)) {
      var_1 = level.vehicleinfo[var_26.refname];
      [[var_1.spawncallback]](var_26);
    }
  }

  scripts\mp\flags::gameflagwait("_encstr_8C7513227310552215EF8367D7B0AB9E40591D6B68");
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;
  thread vehiclespawn_hqtanks(level.tankspawnlocs_axis);
  thread vehiclespawn_hqtanks(level.tankspawnlocs_allies);
}

vehiclespawn_hqtanks(var_0) {
  foreach(var_2 in var_0) {
    var_3 = level.vehicleinfo[var_2.refname];
    [[var_3.spawncallback]](var_2);
    wait(randomfloatrange(2.0, 3.0));
  }
}

vehiclespawn_truck(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_84D70A6B2BEF3C9B30A67164", var_2, var_1);
}

vehiclespawn_littlebird(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", var_2, var_1);
}

_id_14266(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_2, var_1);
}

vehiclespawn_copcar(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8FE608B268BFF756987D", var_2, var_1);
}

vehiclespawn_atv(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8C190467402B", var_2, var_1);
}

vehiclespawn_cargotruck(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", var_2, var_1);
}

vehiclespawn_hoopty(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_91CD07D045CF0B0BB8", var_2, var_1);
}

vehiclespawn_hooptytruck(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8BAA0D68183D43A35319057A93B767", var_2, var_1);
}

vehiclespawn_jeep(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_85DE05A6B2AC0E", var_2, var_1);
}

vehiclespawn_largetransport(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", var_2, var_1);
}

vehiclespawn_medtransport(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_2, var_1);
}

vehiclespawn_pickuptruck(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8FD60D6AA0EAB34083F7C423A0213B", var_2, var_1);
}

vehiclespawn_tacrover(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A120A1D8536F5E4ED3BB293", var_2, var_1);
}

vehiclespawn_van(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_911904464232", var_2, var_1);
}

vehiclespawn_tank(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  var_2.spawnmethod = "_encstr_8A9A1B47D79A98B327BBE769254F29652A63A3D730A2C78D5DFFBFEC55";

  if(isDefined(var_0.script_team) && var_0.script_team == "_encstr_8E8405EA382B2A") {
    if(level.numhqtanks_axis >= level.maxhqtanks) {
      return;
    }
    var_2.usealtmodel = 1;
    var_2.team = "_encstr_8E8405EA382B2A";
    level.numhqtanks_axis++;
  } else {
    if(level.numhqtanks_allies >= level.maxhqtanks) {
      return;
    }
    var_2.team = "_encstr_9A8507BA4040188D08";
    level.numhqtanks_allies++;
  }

  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_AF390B295782C3585F1B21D8C4", var_2, var_1);

  if(istrue(level._id_13377))
    _id_1413B(var_3, var_3.team);

  return var_3;
}

_id_1413B(var_0, var_1) {
  wait 1;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_0.origin, var_1, (0, 0, 0), undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, var_1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2.objidnum);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_AB7C254196C89BC9C358EA929033FAA78186D1C4B9D18F81A7A8028B90777207F8E55B6C43380B");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2.objidnum, var_0);
  var_2.lockupdatingicons = 1;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && isDefined(var_4.team) && var_4.team == var_1 && istrue(var_4.inspawnselection))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2.objidnum, var_4);
  }

  var_0._id_1369D = var_2;
  thread _id_14228(var_0);
  level._id_13C4A[var_1][level._id_13C4A[var_1].size] = var_0;
}

_id_14228(var_0) {
  var_1 = var_0._id_1369D.objidnum;
  var_2 = var_0.team;
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
  level._id_13C4A[var_2] = scripts\engine\utility::array_remove(level._id_13C4A[var_2], var_0);
}

_id_1420E() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_1 in level._id_13C4A[self.team])
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_1._id_1369D.objidnum, self);

  while(self.inspawnselection)
    waitframe();

  foreach(var_1 in level._id_13C4A["_encstr_8E8405EA382B2A"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1._id_1369D.objidnum, self);

  foreach(var_1 in level._id_13C4A["_encstr_9A8507BA4040188D08"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1._id_1369D.objidnum, self);
}

vehiclespawn_getspawndata(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.showheadicon = 1;
  return var_1;
}

droptank_playincomingdialog(var_0) {
  var_1 = var_0.team;
  var_2 = "_encstr_8CC008133958C81BACCB";

  if(level.teambased) {
    if(isDefined(level.killstreakactivatedtime[var_2])) {
      if(isDefined(level.killstreakactivatedtime[var_2][var_1])) {
        if(gettime() < level.killstreakactivatedtime[var_2][var_1])
          return;
      }
    }

    level.killstreakactivatedtime[var_2][var_1] = gettime() + scripts\mp\utility\dialog::getkillstreakdialogcooldown() * 1000;
  }

  scripts\mp\utility\dialog::leaderdialog(var_1 + "_encstr_8EBC0BF5994E9695E62336BCD7" + var_2 + "_encstr_86FF098F7BCD431D2BC8F2", var_1, "_encstr_AFC610DA4059C3AAD865EDF14F59F3777559");
}

_id_1413A(var_0, var_1) {
  wait 1;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_0.origin, var_1, (0, 0, 0), undefined, 0, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, var_1);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2.objidnum);
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "_encstr_AFA01F2F762F2D213B9A705308905A6E5CBF13D3701F5BDFC6DFE9F243FF0D8883");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2.objidnum, var_0);
  var_2.lockupdatingicons = 1;

  foreach(var_4 in level.players) {
    if(isDefined(var_4) && istrue(var_4.inspawnselection))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2.objidnum, var_4);
  }

  var_0._id_1369D = var_2;
  thread _id_14227(var_0);
  level._id_13C49["_encstr_A7770ABF18E31F23BF4BDF97"][level._id_13C49["_encstr_A7770ABF18E31F23BF4BDF97"].size] = var_0;
}

_id_14227(var_0) {
  var_1 = var_0._id_1369D.objidnum;
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1);
  var_2 = var_0.watch_for_player_entered_trap_room;

  if(!isDefined(var_0.watch_for_player_entered_trap_room))
    var_2 = "_encstr_A7770ABF18E31F23BF4BDF97";

  level._id_13C49[var_2] = scripts\engine\utility::array_remove(level._id_13C49[var_2], var_0);
}

_id_1420F() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_1 in level._id_13C49[self.team])
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_1._id_1369D.objidnum, self);

  foreach(var_1 in level._id_13C49["_encstr_A7770ABF18E31F23BF4BDF97"])
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_1._id_1369D.objidnum, self);

  while(self.inspawnselection)
    waitframe();

  foreach(var_1 in level._id_13C49["_encstr_8E8405EA382B2A"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1._id_1369D.objidnum, self);

  foreach(var_1 in level._id_13C49["_encstr_9A8507BA4040188D08"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1._id_1369D.objidnum, self);

  foreach(var_1 in level._id_13C49["_encstr_A7770ABF18E31F23BF4BDF97"])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1._id_1369D.objidnum, self);
}

_id_141FF(var_0) {
  if(isDefined(self.watch_for_player_entered_trap_room))
    level._id_13C49[self.watch_for_player_entered_trap_room] = scripts\engine\utility::array_remove(level._id_13C49[self.watch_for_player_entered_trap_room], self);
  else
    level._id_13C49["_encstr_A7770ABF18E31F23BF4BDF97"] = scripts\engine\utility::array_remove(level._id_13C49["_encstr_A7770ABF18E31F23BF4BDF97"], self);

  self.watch_for_player_entered_trap_room = var_0;
  level._id_13C49[var_0][level._id_13C49[var_0].size] = self;
  scripts\mp\objidpoolmanager::update_objective_icon(self._id_1369D.objidnum, "_encstr_A99D282D1BED377DDAD237D2B65838FAC62D3A3A8D56134B39C8BEDCE0C2779BEBDCB236B2D83AD2B7B9");

  foreach(var_2 in level.players) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self._id_1369D.objidnum, var_2);

    if(isDefined(var_2) && isDefined(var_2.team) && var_2.team == var_0 && istrue(var_2.inspawnselection)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self._id_1369D.objidnum, var_2);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self._id_1369D.objidnum, var_2);
  }
}

init_rallyvehicles() {
  while(!isDefined(level.spawnselectionlocations))
    waitframe();

  waitframe();
  level.rallypointvehicles = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_AFF2147B0EDAA5E93938B8632B55494628D5100390E9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy != level.localeid) {
      continue;
    }
    var_3 = scripts\engine\utility::ter_op(var_2.script_team == "_encstr_8E8405EA382B2A", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
    var_4 = getrallyvehiclespawndata(var_2, var_3);
    var_5 = spawnStruct();
    var_6 = scripts\mp\vehicles\technical_mp::technical_mp_spawncallback(var_4, var_5);

    if(isDefined(var_6)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = var_6;
      continue;
    }
  }

  var_0 = scripts\engine\utility::getStructArray("_encstr_A2A9154E1636D82F14ED5AB9A389B43A47B1CA1296E419", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!istrue(level.disablelittlebirdrally)) {
    foreach(var_2 in var_0) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy != level.localeid) {
        continue;
      }
      var_3 = scripts\engine\utility::ter_op(var_2.script_team == "_encstr_8E8405EA382B2A", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
      var_4 = getrallyvehiclespawndata(var_2, var_3);
      var_5 = spawnStruct();

      if(level.move_spawnpoints_to_valid_positions)
        var_6 = _x1opsnpcwaittilluse::xyvelscale_low(var_4, var_5);
      else
        var_6 = scripts\mp\vehicles\little_bird_mp::little_bird_mp_spawncallback(var_4, var_5);

      if(isDefined(var_6)) {
        level.rallypointvehicles[level.rallypointvehicles.size] = var_6;
        continue;
      }
    }
  } else if(!istrue(level.completelyremovelittlebird)) {
    if(level.localeid == "_encstr_8A34097127C761890FA9D2" && level.mapname == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB" && istrue(level._id_11AC5)) {
      var_10 = [];
      var_10[0] = (23718, -4470, -350);
      var_10[1] = (25046, -17463, -50);
      var_10[2] = (19627, -17495, 50);
      var_10[3] = (23478, -7635, -250);
      var_11 = [];
      var_11[0] = (6, 316, 0);
      var_11[1] = (8, 225, 0);
      var_11[2] = (10, 47, 0);
      var_11[3] = (11, 176, 0);

      foreach(var_13, var_2 in var_0) {
        var_2.origin = var_10[var_13];
        var_2.angles = var_11[var_13];
      }
    }

    foreach(var_2 in var_0) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy != level.localeid) {
        continue;
      }
      if(!isDefined(var_2.angles))
        var_2.angles = (0, randomfloat(360), 0);

      var_4 = vehiclespawn_getspawndata(var_2);

      if(level.move_spawnpoints_to_valid_positions)
        var_6 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_4, undefined);
      else
        var_6 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", var_4, undefined);

      level thread _id_1413A(var_6, "_encstr_A7A408B9CA5D1D4E2C63");
    }
  }

  var_0 = scripts\engine\utility::getStructArray("_encstr_BA5B0E27C263D8E5287BA5731DA041D0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy != level.localeid) {
      continue;
    }
    var_3 = scripts\engine\utility::ter_op(var_2.script_team == "_encstr_8E8405EA382B2A", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
    var_4 = getrallyvehiclespawndata(var_2, var_3);

    if(var_3 == "_encstr_9A8507BA4040188D08")
      var_4.usealtmodel = 1;

    var_5 = spawnStruct();
    var_6 = scripts\mp\vehicles\apc_rus_mp::apc_rus_mp_spawncallback(var_4, var_5);

    if(isDefined(var_6)) {
      level.rallypointvehicles[level.rallypointvehicles.size] = var_6;
      continue;
    }
  }

  foreach(var_19 in level.teamnamelist) {
    while(!isDefined(level.availablespawnlocations[var_19][0]))
      waitframe();
  }

  var_21 = 0;
  var_22 = 0;
  var_23 = 0;
  var_24 = 0;
  var_25 = 0;
  var_26 = 0;
  var_27 = "_encstr_92741662A8AF939F084B9B9C5536039F7FE87A1A60AB4D3F";
  var_28 = "_encstr_8EA0179DDDD7672B435A1B8D59BEC6B4E8E8C6AC98A59391FA";
  var_29 = "_encstr_927B10C7B7F833350868E62D81D9790B4E4F";

  foreach(var_6 in level.rallypointvehicles) {
    var_4 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(var_6);

    if(!isDefined(var_4.rallypointhealth))
      var_4.rallypointhealth = var_6.health;
    else
      var_6.health = var_4.rallypointhealth;

    var_13 = 0;
    var_31 = undefined;

    if(var_6.team == "_encstr_8E8405EA382B2A") {
      if(var_6.vehiclename == "_encstr_84D70A6B2BEF3C9B30A67164") {
        var_21++;

        if(var_21 <= 8)
          var_4.ref = var_27 + var_21;
        else {}
      } else if(var_6.vehiclename == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8" || var_6.vehiclename == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F") {
        var_22++;

        if(var_22 <= 2)
          var_4.ref = var_28 + var_22;
        else {}
      } else if(var_6.vehiclename == "_encstr_86510C82737817CD40B38B720A15") {
        var_23++;

        if(var_23 <= 2)
          var_4.ref = var_29 + var_23;
        else {}
      }
    } else if(var_6.vehiclename == "_encstr_84D70A6B2BEF3C9B30A67164") {
      var_24++;

      if(var_24 <= 8)
        var_4.ref = var_27 + var_24;
      else {}
    } else if(var_6.vehiclename == "_encstr_9A8F0CB1A5E8471BB2EB894B39C8" || var_6.vehiclename == "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F") {
      var_25++;

      if(var_25 <= 2)
        var_4.ref = var_28 + var_25;
      else {}
    } else if(var_6.vehiclename == "_encstr_86510C82737817CD40B38B720A15") {
      var_26++;

      if(var_26 <= 2)
        var_4.ref = var_29 + var_26;
      else {}
    }

    if(istrue(level.userallypointvehicles) && level.userallypointvehicles != 2)
      watchvehicleforrallypointactivation(var_6);
  }
}

watchvehicleforrallypointactivation(var_0) {
  scripts\mp\rally_point::rallypointvehicle_activate(var_0);
}

getrallyvehiclespawndata(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_2.cannotbesuspended = 1;
  var_2.team = var_1;
  return var_2;
}

arm_initoutofbounds() {
  level.outofboundstriggers = [];
  var_0 = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == level.localeid && scripts\mp\utility\game_utility_mp::_id_11C8A(var_2)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = var_2;
      continue;
    }

    var_2 delete();
  }
}

debugprint(var_0) {
  if(0)
    return;
}

isobjectivecontested(var_0) {
  if(var_0.ownerteam == "_encstr_8E8405EA382B2A")
    return var_0.numtouching["_encstr_9A8507BA4040188D08"] > 0;
  else if(var_0.ownerteam == "_encstr_9A8507BA4040188D08")
    return var_0.numtouching["_encstr_8E8405EA382B2A"] > 0;
}

freeze_bomb_case_timer(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0)
      var_1++;
  }

  return var_1;
}

createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;

  if(isDefined(var_11))
    var_12 = var_11;
  else
    var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);

  var_12 makeusable();

  if(isDefined(var_11) && isDefined(var_0))
    var_12 sethinttag(var_0);

  if(isDefined(var_1))
    var_12 setCursorHint(var_1);
  else
    var_12 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");

  if(isDefined(var_2))
    var_12 sethinticon(var_2);

  if(isDefined(var_3))
    var_12 setHintString(var_3);

  if(isDefined(var_4))
    var_12 setusepriority(var_4);
  else
    var_12 setusepriority(0);

  if(isDefined(var_5))
    var_12 setuseholdduration(var_5);
  else
    var_12 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");

  if(isDefined(var_6))
    var_12 sethintonobstruction(var_6);
  else
    var_12 sethintonobstruction("_encstr_BECC055CF3811A");

  if(isDefined(var_7))
    var_12 sethintdisplayrange(var_7);
  else
    var_12 sethintdisplayrange(200);

  if(isDefined(var_8))
    var_12 sethintdisplayfov(var_8);
  else
    var_12 sethintdisplayfov(160);

  if(isDefined(var_9))
    var_12 setuserange(var_9);
  else
    var_12 setuserange(50);

  if(isDefined(var_10))
    var_12 setusefov(var_10);
  else
    var_12 setusefov(120);

  if(!isDefined(var_11))
    return var_12;
}

calculatefrontline() {
  if(level.mapname == "_encstr_B4E60CF02329C9CA181E392D8268") {
    level.c130frontlinepos = (0, 375, 0);
    level.c130frontlinevec = (0, 1, 0);
    level.axisfrontlinevec = (-1, 0, 0);
    level.alliesfrontlinevec = (1, 0, 0);
  } else {
    level.c130frontlinepos = (5100, -1615, 0);
    level.c130frontlinevec = (1, 0, 0);
    level.axisfrontlinevec = (0, -1, 0);
    level.alliesfrontlinevec = (0, 1, 0);
  }
}

getexfilstructs() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A765175896E4C8277B8362F6360B8ED2EDCDAFC21BD85A566E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStructArray("_encstr_96741507C8CBECAB4FAF8D7D1E7B83B93098878FD82D33", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  var_3 = scripts\engine\utility::getclosest(level.lane_1_obj_struct.currentobjective.gameobject.origin, var_2);
  var_4 = scripts\engine\utility::getclosest(level.lane_2_obj_struct.currentobjective.gameobject.origin, var_2);
  var_5 = scripts\engine\utility::getclosest(level.lane_3_obj_struct.currentobjective.gameobject.origin, var_2);
  level.armexfilcount = 3;
  return [var_3, var_4, var_5];
}

onexfilfinish(var_0) {}

onexfilkilled(var_0) {
  level.armexfilcount--;

  if(level.armexfilcount == 0)
    thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"]);
}

sortlocationsbydistance(var_0, var_1) {
  return distancesquared(var_0.origin, self.origin) < distancesquared(var_1.origin, self.origin);
}

calculatedroplocationnearlocation(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1.0, 1.0);

  if(var_7 > 0) {
    var_4 = randomfloatrange(var_3[0] + var_1 * var_7, var_3[0] + var_2 * var_7);

    if(var_4 >= level.br_level.br_corners[0][0])
      var_4 = level.br_level.br_corners[0][0] - 250;
  } else {
    var_4 = randomfloatrange(var_3[0] + var_2 * var_7, var_3[0] + var_1 * var_7);

    if(var_4 <= level.br_level.br_corners[1][0])
      var_4 = level.br_level.br_corners[1][0] + 250;
  }

  var_6 = randomint(2);
  var_7 = scripts\engine\utility::ter_op(var_6, -1.0, 1.0);

  if(var_7 > 0) {
    var_5 = randomfloatrange(var_3[1] + var_1 * var_7, var_3[1] + var_2 * var_7);

    if(var_5 >= level.br_level.br_corners[0][1])
      var_5 = level.br_level.br_corners[0][1] - 250;
  } else {
    var_5 = randomfloatrange(var_3[1] + var_2 * var_7, var_3[1] + var_1 * var_7);

    if(var_5 >= level.br_level.br_corners[1][1])
      var_5 = level.br_level.br_corners[1][1] + 250;
  }

  var_8 = spawnStruct();
  var_8.origin = (var_4, var_5, var_3[2]);
  return var_8;
}

debugsphereonlocation(var_0, var_1, var_2) {}

getmissedinfilcamerapositions(var_0) {
  var_1 = spawnStruct();
  var_1.startorigin = undefined;
  var_1.endpos = undefined;

  if(level.mapname == "_encstr_93A80FB50EBE8DF6C6B036ACFA47ACB98E") {
    switch (level.localeid) {
      case "_encstr_8D34098D7BB185C6CAEB1C":
      case "_encstr_8A34097127C761890FA9D2":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (2094, -1804, 2763);
          var_1.startangles = (54, 40, 0);
          var_1.endorigin = (2094, -1804, 2763);
          var_1.endangles = (54, 40, 0);
        } else {
          var_1.startorigin = (2315, 1956, 2763);
          var_1.startangles = (54, 296, 0);
          var_1.endorigin = (2094, -1804, 2763);
          var_1.endangles = (54, 40, 0);
        }

        break;
      default:
        var_1.startorigin = (0, 0, 0);
        var_1.startangles = (0, 0, 0);
        var_1.endorigin = (0, 0, 0);
        var_1.endangles = (0, 0, 0);
        break;
    }
  } else {
    switch (level.localeid) {
      case "_encstr_A63409881A3633786F5F9E":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (38864, -14018, -396);
          var_1.startangles = (3, 250, 0);
          var_1.endorigin = (38473, -14077, 401);
          var_1.endangles = (15, 252, 0);
        } else {
          var_1.startorigin = (30526, -38262, -483);
          var_1.startangles = (0, 72, 0);
          var_1.endorigin = (30024, -38403, 560);
          var_1.endangles = (19, 67, 0);
        }

        break;
      case "_encstr_8A34097127C761890FA9D2":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (16977, -23256, 169);
          var_1.startangles = (9, 69, 0);
          var_1.endorigin = (16899, -23467, 683);
          var_1.endangles = (15, 68, 0);
        } else {
          var_1.startorigin = (18607, 1423, -355);
          var_1.startangles = (8, 289, 0);
          var_1.endorigin = (18100, 1083, 503);
          var_1.endangles = (22, 302, 0);
        }

        break;
      case "_encstr_8D34098D7BB185C6CAEB1C":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (18672, -26836, -129);
          var_1.startangles = (359, 76, 0);
          var_1.endorigin = (18518, -26909, 314);
          var_1.endangles = (14, 69, 0);
        } else {
          var_1.startorigin = (18607, 1423, -355);
          var_1.startangles = (8, 289, 0);
          var_1.endorigin = (18100, 1083, 503);
          var_1.endangles = (22, 302, 0);
        }

        break;
      case "_encstr_919F0AB1ED6C85B1CA7D136C":
      case "_encstr_84340989AF4FE911972172":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (24893, 28349, 1408);
          var_1.startangles = (15, 54, 0);
          var_1.endorigin = (25613, 29274, 1255);
          var_1.endangles = (19, 53, 0);
        } else {
          var_1.startorigin = (39490, 48919, 2302);
          var_1.startangles = (17, 235, 0);
          var_1.endorigin = (39254, 48584, 1542);
          var_1.endangles = (18, 245, 0);
        }

        break;
      case "_encstr_AF3409DC18C12FBD6B6107":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (48331, -24822, 514);
          var_1.startangles = (12, 77, 0);
          var_1.endorigin = (48424, -24421, -240);
          var_1.endangles = (2, 77, 0);
        } else {
          var_1.startorigin = (46188, 2520, 49);
          var_1.startangles = (7, 295, 0);
          var_1.endorigin = (46571, 2664, 526);
          var_1.endangles = (16, 276, 0);
        }

        break;
      case "_encstr_B89F0A1BF6D8581B2BEB4C81":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (-11083, 22197, 381);
          var_1.startangles = (10, 181, 0);
          var_1.endorigin = (-12112, 23761, 381);
          var_1.endangles = (11, 201, 0);
        } else {
          var_1.startorigin = (-31134, 11924, -116);
          var_1.startangles = (0, 36, 0);
          var_1.endorigin = (-31134, 11924, 434);
          var_1.endangles = (11, 36, 0);
        }

        break;
      case "_encstr_AC9F0A2D80FF2A2CE9B19686":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (9215, 984, 325);
          var_1.startangles = (357, 186, 0);
          var_1.endorigin = (9107, 628, 1144);
          var_1.endangles = (19, 182, 0);
        } else {
          var_1.startorigin = (-5351, 641, 408);
          var_1.startangles = (2, 352, 0);
          var_1.endorigin = (-5282, 996, 1103);
          var_1.endangles = (11, 347, 0);
        }

        break;
      case "_encstr_889F0A63DE6C8536ACEB98C1":
        if(var_0 == "_encstr_8E8405EA382B2A") {
          var_1.startorigin = (-22847, -28632, 34);
          var_1.startangles = (12, 42, 0);
          var_1.endorigin = (-22694, -28429, 356);
          var_1.endangles = (12, 40, 0);
        } else {
          var_1.startorigin = (-8084, -20649, 72);
          var_1.startangles = (10, 185, 0);
          var_1.endorigin = (-9092, -20635, 224);
          var_1.endangles = (12, 184, 0);
        }

        break;
      default:
        var_1.startorigin = (0, 0, 0);
        var_1.startangles = (0, 0, 0);
        var_1.endorigin = (0, 0, 0);
        var_1.endangles = (0, 0, 0);
        break;
    }
  }

  return var_1;
}

calculatehqmidpoint() {
  level.hqmidpoint = (level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin) * 0.5;
  level.hqvecttomid_allies = level.gw_objstruct.axishqloc.trigger.origin - level.hqmidpoint;
  level.hqvecttomid_axis = level.gw_objstruct.allieshqloc.trigger.origin - level.hqmidpoint;
  level.hqdisttomid = length(level.hqvecttomid_axis);
}

calculatecameraoffset(var_0, var_1) {
  switch (level.mapname) {
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
      var_2 = 0.25;
      var_3 = 0.35;
      break;
    case "_encstr_BA3F0A7D37E6935EE590C3CF":
      var_2 = 0.25;
      var_3 = 0.8;
      break;
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      var_2 = 0.5;
      var_3 = 0.3;
      break;
    default:
      var_2 = 0.0;
      var_3 = 0.0;
      break;
  }

  var_4 = distance(var_1, level.hqmidpoint);

  if(var_4 < 2048)
    return (0, 0, 0);

  if(var_0 == "_encstr_8E8405EA382B2A") {
    var_5 = distance(level.gw_objstruct.axishqloc.trigger.origin, var_1);
    var_6 = level.hqvecttomid_axis;
  } else {
    var_5 = distance(level.gw_objstruct.allieshqloc.trigger.origin, var_1);
    var_6 = level.hqvecttomid_allies;
  }

  if(var_5 < 2048)
    return var_6 * var_2;

  if(var_5 > level.hqdisttomid) {
    if(var_0 == "_encstr_8E8405EA382B2A")
      var_5 = distance(level.gw_objstruct.allieshqloc.trigger.origin, var_1);
    else
      var_5 = distance(level.gw_objstruct.axishqloc.trigger.origin, var_1);

    var_7 = 100 - var_5 * 100 / level.hqdisttomid;
    var_8 = var_6 * var_3 * -1.0 * (var_7 / 100);
    return var_8;
  } else {
    var_7 = 100 - var_5 * 100 / level.hqdisttomid;
    var_8 = var_6 * var_2 * (var_7 / 100);
    return var_8;
  }
}

_id_1368D() {
  if(isDefined(self.selectedspawnarea) && issubstr(self.selectedspawnarea, "_encstr_8E07031369"))
    return 1;

  return 0;
}