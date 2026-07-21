/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_quarry2\cp_quarry2_objective_smuggler.gsc
****************************************************************/

main() {
  level.convoy4_objective_func = ::register_convoy4_objectives;
  level.hackingfunc = ::init_hacking_table;
  scripts\cp\cp_hacking::hacking_init();
  scripts\cp\cp_hostage::init_hostages();
  level thread debug_loop_explosion();
  level thread player_equipment_use_stop();
}

init_hacking_table() {
  scripts\cp\cp_hacking::parsehackingtable("_encstr_924523E750D51B2F6F1BABD1D3236329DCD96F4FE1ED58E087024059EA131338377EF7F786");
}

register_convoy4_objectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("_encstr_81D6136CED733BF697D0FADC2BB1AEC9B285932B58", ::obj_maj_secure_init, ::obj_maj_secure_start, ::obj_maj_secure_end, ::debugbeatobjective, ::debug_start_hostages);
  [[var_0]]("_encstr_85CB1536E733434FC8DF598822620B9953954EB84D872B", ::obj_maj_comms_init, ::obj_maj_comms_start, ::obj_maj_comms_end, ::debugbeatobjective, ::debug_start_switches);
  [[var_0]]("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43", ::obj_maj_secure_tower_init, ::obj_maj_secure_tower_start, ::obj_maj_secure_tower_end, ::debugbeatobjective, ::debug_start_terminal);
  [[var_0]]("_encstr_A26B12B8523D4540578C10F4B963694F245AD0B0", ::obj_maj_find_keys_init, ::obj_maj_find_keys_start, ::obj_maj_find_keys_end, ::debugbeatobjective, ::debug_start_keys);
  [[var_0]]("_encstr_81E91323D2D6952F1002EF16C89BF1E95CBAC34310", ::obj_maj_call_train_init, ::obj_maj_call_train_start, ::obj_maj_call_train_end, ::debugbeatobjective, ::debug_start_call);
  [[var_0]]("_encstr_BD09148F27DDF088DF77C6AB0ABFB501B6901307D8C7", ::obj_maj_take_apache_init, ::obj_maj_take_apache_start, undefined, ::debugbeatobjective);
  [[var_0]]("_encstr_AA671327D060C6424BA511136733ABA78B80A79730", ::obj_maj_wait_train_init, ::obj_maj_wait_train_start, undefined, ::debugbeatobjective, ::debug_start_waittrain);
  [[var_0]]("_encstr_B6FD136CDBB99D7B5E43D7B7E0CACDF5E8390BA5B9", ::obj_maj_open_train_init, ::obj_maj_open_train_start, undefined, ::debugbeatobjective);
  [[var_0]]("_encstr_874213AE920318C8F28AF16AF3245278B2A1FF48CE", ::obj_maj_extraction_init, ::obj_maj_extraction_start, undefined, ::debugbeatobjective, ::debug_start_extraction);
  level thread register_spawn_functions();
}

register_interactions() {
  thread smuggler_interactions_threaded();
}

smuggler_interactions_threaded() {
  if(!scripts\engine\utility::flag_exist("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D"))
    scripts\engine\utility::flag_init("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D");

  scripts\engine\utility::flag_wait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D");
  wait 0.25;
  thread _id_131E3();
  thread scripts\cp\cp_destruction::destructible_interactions();
  scripts\cp\cp_interaction::registerinteraction("_encstr_B4281B373845BDC73909038711C74259D7FEB83A9B512703A2570D714B", ::hintcommslaptop, ::activationcommslaptop, ::initcommslaptop, 0, "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  scripts\cp\cp_interaction::registerinteraction("_encstr_B2281B3B873005AFC8E0627B0B385B71F81DA4851508CEFB8BB88A71D1", ::hintcommslaptop, ::activationcommslaptop, ::initcommslaptop, 0, "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  scripts\cp\cp_interaction::registerinteraction("_encstr_A6281BB1B7DADA9B7D8DB00EE8B7E0F5B4DCA32BC916361D96F6CDEB36", ::hintcommslaptop, ::activationcommslaptop, ::initcommslaptop, 0, "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  scripts\cp\cp_interaction::registerinteraction("_encstr_AF9717981A9A272F6F2A13583397DE96F0444C2FB34A89EB23", ::hintcalltraininteract, ::activationcalltraininteract, ::initcalltraininteract, 0, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", 1);
  scripts\cp\coop_personal_ents::registerpentparams("_encstr_AF9717981A9A272F6F2A13583397DE96F0444C2FB34A89EB23", "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_B6C42F9E67EF410D75F12317EA6EDFB83D1516C343555873D0515F43214491A7BFBE6E4D591F81BA257963FF01BF45D939", undefined, "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD", "_encstr_BECC055CF3811A", 270, 65, 140, 65);
  thread spawn_objective_loot();
  waitframe();
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("_encstr_B4281B373845BDC73909038711C74259D7FEB83A9B512703A2570D714B");
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("_encstr_B2281B3B873005AFC8E0627B0B385B71F81DA4851508CEFB8BB88A71D1");
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("_encstr_A6281BB1B7DADA9B7D8DB00EE8B7E0F5B4DCA32BC916361D96F6CDEB36");
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("_encstr_A92F19EF451FBB72AB10C3BF30A05DB199E8B5E2206942BD91909F");
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("_encstr_AF9717981A9A272F6F2A13583397DE96F0444C2FB34A89EB23");
}

_id_131E3() {
  _id_131E6("_encstr_8CA914D778202F4393479A55AE4959DB8BD83367F939");
  _id_131E4();
  _id_131E5();
  _id_131E6("_encstr_AFA91475E1F8F79325795337654D9903C0692B7FFE18");
}

_id_131E6(var_0) {
  if(isDefined(level.hideintelscriptablesfromplayer) && isDefined(scripts\engine\utility::array_find(level.hideintelscriptablesfromplayer, var_0))) {
    return;
  }
  var_1 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 setModel("_encstr_9B8528AD5A1BD247589C2FFAA117F56C4E583A2BFA0698BE0EC9DB0FCBD71B0EEBCD1C0BDD738598632B");

  if(isDefined(var_1.targetname))
    var_2.targetname = var_1.targetname;

  if(!isDefined(level.hideintelscriptablesfromplayer))
    level.hideintelscriptablesfromplayer = [];

  level.hideintelscriptablesfromplayer[level.hideintelscriptablesfromplayer.size] = var_0;
}

_id_131E4() {
  level._id_11F54 = scripts\engine\utility::getStructArray("_encstr_8AE50BBD31D4EB587D76BD85D8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level._id_11F54) {
    var_1._id_127EA = [];

    if(!isDefined(var_1.radius))
      var_1.radius = 500;
  }

  level._id_11F53 = scripts\cp\cp_create_script_utility::_id_13529("_encstr_A30E0CE8D5188110AE5315E3CB98");
}

_id_131E5() {
  level waittill("_encstr_B6BF12235331C06D0AF3D7A1FFB23A61C9AB2E99");
  scripts\cp\cp_create_script_utility::land_usability_disabled("_encstr_A30E0CE8D5188110AE5315E3CB98");
  wait 1;
}

spawn_objective_loot() {
  var_0 = getEntArray("_encstr_92330E8793FD32275899B2F1906867BB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "_encstr_A7B606DA83796F4A") {
      var_2 thread scripts\cp\utility::create_fake_loot(["_encstr_A38916B1626C78B04B6FC3CB93A2054B37FD9EA90AC5C0F6"]);
      continue;
    }

    var_2 thread scripts\cp\utility::create_fake_loot(["_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6"]);
  }
}

_id_1321C() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_A30D0EE0CFB18B108B5519B3E10BE322", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  scripts\cp\cp_spawning_util::balloon_deposit(var_2.origin, var_2.radius);
}

obj_maj_secure_init(var_0) {
  level.global_stealth_broken = 0;
  level thread _id_124D2();
  level thread _id_11F50();
  level thread _id_131F0();
}

obj_maj_secure_start(var_0) {
  level thread smuggler_door_lock();
  level thread _encstr_9ACB388F6126F16B4348E02948B59D5F8703609EBA8FE7F37B9382FAE712A6DF52B921632B62F8E3552782470FB7462C475B801B0E37D2D2BBB7::_id_137F7();
  _id_1321C();
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  scripts\engine\utility::flag_wait("_encstr_841419E17B980A53234E3A5233FE6F095827577EFB4814AF4321E2");
  var_1 = scripts\engine\utility::getStruct("_encstr_A70816DF778DA0B8EF4716D9AA3B67B866D5437BE1F2C8FB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_0.objectiveindex, 0);
  objective_position(var_0.objectiveindex, var_1.origin);
  objective_setlabel(var_0.objectiveindex, &"_encstr_ABE92B211149A91B2B212FD91AF72788E5D3A3CBC4FC95F6DEEE2768D3BDA745A989AD4D95F93527DF2FA22C31");
  level._id_12D89 = scripts\cp\cp_create_script_utility::_id_13529("_encstr_8BBF0F165F8FF987A24370A96ABD9DD143");
  level._id_11F56 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B62810F6989AD716D727DBED33FA3557CECE");
  level.iconovertime = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A23E12C6AD929D8011B2A1C0F72FF997BA534C5C");
  level.icon_trigger_enter = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_952312DE1FCBBBA720C771087AFC511103AB486F");
  level.icon_trigger_exit = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_88AF0C885F92531BF3197405E89B");
  level thread _id_13DBD("_encstr_91AA0D27C38A7DDBE9F71030EF68D3", "_encstr_A9D8185ABDCB2B623AE1EB8F08303CA187572653A80F83AAC038", "_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243", undefined, undefined);
  level thread _id_13DBD("_encstr_92170CA1BBB1F8C31B8FC22A7214", "_encstr_862817236B17CA0BABF128D946EB0946EF4E93ABD021926072", "_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243", undefined, undefined);
  level thread _id_13DBD("_encstr_97871483FB2F9E30C0C75D5BE76CC8F0D7727BC823CF", "_encstr_B8081FD2951898685E39F6D23019C9375F4F9ADD3B629783DA79544820038B6FF7", "_encstr_A6BF124EB9F7E8B3B7A2EF1C81F9E8E9475CFE9E", undefined, undefined);
  level thread setup_enemy_sentries(1);
  level thread _id_12115();
  var_2 = 163840000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2))
    wait 0.1;

  level scripts\engine\utility::delaythread(3, ::nextstar);
  level scripts\engine\utility::delaythread(randomintrange(60, 90), ::nextstar);
  level thread _id_1295D();
  scripts\engine\utility::delaythread(5, ::_id_14408);
  level._id_12959 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8502168BAB0B9CE4CB7DB43747C97B89EB1BD07B1CC1AC93");
  wait 1.5;
  level._id_1295A = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_96DA168BAE2CE4E4CBD7A5371D277B23D7360DDBC183AC39");
  var_2 = 81000000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2))
    wait 0.1;

  level.icontrigger = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8D8012A9327B84C0E8841745F755B0D8A35BA153");
  var_3 = ["_encstr_95112C91798967C87757D13E0BDF47E363A0CD78631011419798036A28CB40ED88690AC5AC0E3BBAD7FAF0971352", "_encstr_9A112C68D3B91798E2EE4B8353EE9F49FF200D40E38349106D64E81E85F36439EB4FD0EBE3C806AA7FC3CFB7A7DB"];
  level thread play_vo_delay(scripts\engine\utility::random(var_3));
  var_2 = 60840000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2))
    wait 0.1;

  level thread scripts\cp\cp_wave_spawning::killstreaks(0.1, "_encstr_A2B3176E6BEA3B9DEB07CCEB2DB91D93F6AF9BDEEBA156B1B4");
  var_2 = 30250000;
  var_4 = 1;

  while(var_4 > 0) {
    wait 0.5;

    if(scripts\cp\utility::any_player_nearby(var_1.origin, var_2))
      var_4 = var_4 - 0.5;
  }

  level notify("_encstr_95980DE61DF6E0D7B6ED278EC2C9CD");
  level play_vo_delay("_encstr_996A252B4001A0D3F89FA9F0278B567B3DE7B6FEA376790B801AC178490B9B50C869BD94CF8EA9");
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_AC7213BBAAFEE9363281AF33200D0BE1D750CF8B9B");
  wait 1;
  var_1 = scripts\engine\utility::getStruct("_encstr_9B9217ED4CA62B1BD196EC957D8D7BCDCEB72F86FA0346D716", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = scripts\engine\utility::getStruct("_encstr_8CDA14277790C3CF501359DCB0C00D6B7593AFA7F94D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = 2600;
  var_7 = var_6 * var_6;

  for(;;) {
    wait 0.5;

    if(scripts\cp\utility::any_player_nearby(var_1.origin, var_7)) {
      break;
    }
  }

  var_8 = ["_encstr_8A802CE048D98FD343AFB8DB4FA7408EE68BD5D733E597BDD8B0BBF720538783CB426F70F786DC78C81B0A50CFB2", "_encstr_8F802CA58B3981A043DEF01FA3FEAF7EF024619253BB37154009F1923FA3EAA37040766373A0E8BD106A8709DAE2", "_encstr_92802CACFB2E4FA25F496AB29B7751F741693C2F959377AF3DE0620B798F12E739C587CBAF598FB5DB90CA61F221"];
  level thread play_vo_delay(scripts\engine\utility::random(var_8));
  var_6 = 1400;
  var_7 = var_6 * var_6;
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_position(var_0.objectiveindex, var_5.origin + (0, 0, 20));
  objective_setlabel(var_0.objectiveindex, &"_encstr_85DB28B08F28CFDB993DF2F1D54115DBFA45C849340457821213D6E64379EB3F947D31C05E7CC78A21E1");
  thread scripts\cp\utility::objective_update("_encstr_8CDA14277790C3CF501359DCB0C00D6B7593AFA7F94D", undefined, undefined, undefined, 1);

  for(;;) {
    wait 0.5;

    if(scripts\cp\utility::any_player_nearby(var_1.origin, var_7)) {
      break;
    }
  }

  scripts\cp\cp_objectives::lua_objective_complete("_encstr_8CDA14277790C3CF501359DCB0C00D6B7593AFA7F94D");
  thread scripts\cp\utility::objective_update("_encstr_BD87168DDBDCCEF6BCA1AF93ACDCE8E4B4B11DA3C9582D73", undefined, undefined, undefined, 1);
}

_id_12115() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_91C20F88F3AF2516D360BBAE7FBBD89FD2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  thread _id_1211B(var_2);
}

_id_1211B(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.radius;
  var_3 = [];
  var_4 = getentitylessscriptablearrayinradius(undefined, undefined, var_1, var_2);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] scriptableisdoor())
      var_3[var_3.size] = var_4[var_5];
  }

  for(var_6 = 0; var_6 < var_3.size; var_6++)
    var_3[var_6] setscriptablepartstate("_encstr_B16705D9AFE22E", "_encstr_A9E508C0A02E73CFA35A", 0);
}

_id_13DBD(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_2))
    level endon(var_2);

  if(isDefined(var_3))
    level endon(var_3);

  if(isDefined(var_4))
    level endon(var_4);

  var_5 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_5.target)) {
    childthread _id_13DBE(var_0, var_5);
    level endon(var_0 + "_encstr_95880867BB8EA07E5F02");
  }

  var_6 = var_5.origin;
  var_7 = var_5.radius;
  var_8 = var_7 * var_7;

  for(;;) {
    wait 0.25;

    if(scripts\cp\utility::any_player_nearby(var_6, var_8)) {
      break;
    }
  }

  level notify(var_0 + "_encstr_937F0968BB0BE13F4D8AC0");

  if(!isDefined(level._id_13DBC))
    level._id_13DBC = [];

  level._id_13DBC[var_0] = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
}

_id_13DBE(var_0, var_1) {
  level endon(var_0 + "_encstr_937F0968BB0BE13F4D8AC0");
  var_2 = var_1.origin;
  var_3 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_3.origin;
  var_5 = var_3.radius;
  var_6 = var_5 * var_5;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_4, var_6)) {
      break;
    }

    wait 0.25;
  }

  level notify(var_0 + "_encstr_95880867BB8EA07E5F02");
}

_id_1295F(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_8B631CC557B093E4F2D7A53747E4BDAF772C9D95F56E1C85EEB9EB1CDB4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1.radius;
  var_3 = var_1.origin;
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_3, var_2, 10000);
  var_4 = 20250000;

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_4))
    wait 0.25;

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_3);
  var_1 = scripts\engine\utility::getStruct("_encstr_91E81DB8AEC2C9272FEB4B9BE62D3259BE77B0B359EB6E070BDDDCFA0EED2D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = var_1.radius;
  var_3 = var_1.origin;
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_3, var_2, 10000);
  var_4 = 6760000;

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_4))
    wait 0.25;

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_3);
}

_id_14408() {
  level.global_stealth_broken = 1;
  level notify("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_2 in var_0)
  var_2 thread scripts\cp\cp_modular_spawning::enter_combat();
}

_id_1295D() {
  level.get_mortar_impact_pos = ::get_mortar_impact_spot;
  level._id_1295D = getEntArray("_encstr_A66F0EDF3B728513212F2038F34409FD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 = scripts\engine\utility::getStruct("_encstr_BA401061B521C39AF301E2EB603D1547D993", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in level._id_1295D) {
    var_2 hidepart("_encstr_8B030FB8D8D3F0CDDBAAAAAF88682AC159", "_encstr_B2DF0F6B969BC6EBEEDA7DDABD393A1693");
    var_2 thread mortar_think(var_0);
  }

  level waittill("_encstr_91310F998D0B3959F51BC2EAB9C643AC19");
  level scripts\engine\utility::delaythread(0.25, scripts\cp\cp_vo::try_to_play_vo_on_team, "_encstr_B1E528193C7DB1076EEBDAC26B16BED8B0631BDBAE8EFAD6ED9C4716277D851D8EB06CDAD29BD9D79118", "_encstr_9A8507BA4040188D08");
  wait 8;
  level waittill("_encstr_91310F998D0B3959F51BC2EAB9C643AC19");
  level scripts\engine\utility::delaythread(0.25, scripts\cp\cp_vo::try_to_play_vo_on_team, "_encstr_A5E52889A3B1F6C8238130493519793E8A1B61170FAB507847A2DB411AFFB0EDB397F787D7720421312A", "_encstr_9A8507BA4040188D08");
}

mortar_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A6BF124EB9F7E8B3B7A2EF1C81F9E8E9475CFE9E");
  level endon("_encstr_95980DE61DF6E0D7B6ED278EC2C9CD");
  self endon("_encstr_AD75063D571AE108");
  var_1 = 4;
  var_2 = 7;
  self.targets = undefined;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, 1000000)) {
      return;
    }
    var_3 = get_players_in_area(var_0.origin, var_0.radius);

    if(var_3.size) {
      self.targets = var_3;
      _encstr_8B1A308750033953B1E6ADB64FDF5AF9AB287E5F601E6CEAEDF543AA3AF712897008BF975078A172B71C4D269E1B1E4F3B98::attract_agent_to_mortar(self, 1, 1000);
      self.targets = undefined;
      wait(randomintrange(var_1, var_2));
      continue;
    }

    wait 1;
  }
}

get_players_in_area(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!var_4 scripts\cp\utility::is_valid_player() || !var_4 isonground()) {
      continue;
    }
    if(scripts\engine\utility::distance_2d_squared(var_4.origin, var_0) < var_1 * var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

get_mortar_impact_spot(var_0) {
  if(!isDefined(var_0.targets))
    return undefined;

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1.origin + (randomintrange(-300, 300), randomintrange(-300, 300), 0);
  var_3 = scripts\engine\trace::ray_trace(var_2 + (0, 0, 500), var_2);
  return var_3["_encstr_BD260953AA97E3F014279D"];
}

nextstar() {
  level._id_1359D = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_833219D976CB2B2B8FA7484847CF606BB3514FFE8122EF53658FD0");
  level._id_1359E = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AB3219693B930708AF11A3DB869F804D2B67C95F373AD810F57989");
  level._id_1359F = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_99321981D37BEFD007B91B73DEE7E81593BF31878F62A0B82D8101");
  wait(randomintrange(4, 8));
  level._id_135A0 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A5321902D025E66358AFDBD027633B2F8DA14B0FD1D5DD3B7068D4");
}

obj_maj_secure_end(var_0) {}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

_id_13779() {
  var_0 = scripts\engine\utility::getStruct("_encstr_B2820D8BD5C227C9BC7D8E4E58B437", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.scr_animtree["_encstr_BDC0122EBA58E427CBF53A4E0B4BCD7D58DC2DAD"] = #animtree;
  level.scr_anim["_encstr_BDC0122EBA58E427CBF53A4E0B4BCD7D58DC2DAD"]["_encstr_8FDE09E270117257C96EB0"] = % _encstr_85EA1A1B9981A20FBEA093DB099DC7DB4023996EAF28AA83EBBB9A62;
  level.scr_animname["_encstr_BDC0122EBA58E427CBF53A4E0B4BCD7D58DC2DAD"]["_encstr_8FDE09E270117257C96EB0"] = "_encstr_85EA1A1B9981A20FBEA093DB099DC7DB4023996EAF28AA83EBBB9A62";
  waitframe();
  level._id_1295E = getEnt("_encstr_B6C50F92F9BB223FD048A30FD8CBF10A75", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_1295E.animname = "_encstr_BDC0122EBA58E427CBF53A4E0B4BCD7D58DC2DAD";
  level._id_1295E useanimtree(level.scr_animtree[level._id_1295E.animname]);
  var_1 = getEnt("_encstr_AC580CC3104324C353C00B0CE343", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getstartorigin(var_0.origin, var_0.angles, level.scr_anim["_encstr_BDC0122EBA58E427CBF53A4E0B4BCD7D58DC2DAD"]["_encstr_8FDE09E270117257C96EB0"]);
  var_3 = getstartangles(var_0.origin, var_0.angles, level.scr_anim["_encstr_BDC0122EBA58E427CBF53A4E0B4BCD7D58DC2DAD"]["_encstr_8FDE09E270117257C96EB0"]);
  level waittill("_encstr_B4F811ABDBA958F5215F3D3B47093D804174F0");
  level._id_1295E dontinterpolate();
  level._id_1295E.origin = var_2;
  level._id_1295E.angles = var_3;
  var_1 dontinterpolate();
  var_1.origin = var_2;
  var_1.angles = var_3;
  var_1 linkTo(level._id_1295E, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, -6, 84), (0, 0, 0));
  level._id_1295E.clipmodel = var_1;
  level._id_1295E setscriptablepartstate("_encstr_B68305BA601B07", "_encstr_B68305BA601B07");
  level._id_1295E thread damage_infront_of_train(level._id_1295E, "_encstr_9273104260DF54B3A950C8C148D3775B6708");
}

obj_maj_comms_init(var_0) {
  level.convoy4_terminal_keys = 0;
  level thread play_hack_alarms();
  level thread play_hacks_interact_vo();
}

obj_maj_comms_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(24);
  scripts\cp\cp_objectives::lua_objective_incomplete("_encstr_BD87168DDBDCCEF6BCA1AF93ACDCE8E4B4B11DA3C9582D73");
  setomnvar("_encstr_A57719730B9F85460DD743916368921F7FB37B6F764273939090E3", 0);
  level thread setup_enemy_sentries(2);
  level obj_comms_start("_encstr_8D491591A5DC1626C62BAFC6DB5BB66EAF8D851C8EB7E0", "_encstr_994C023A", var_0);
  setomnvar("_encstr_A57719730B9F85460DD743916368921F7FB37B6F764273939090E3", 1);
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_92720903B8D392C32A50C9", ["_encstr_A6E3114659E036BD97B026B1CABE6CBD9D59C9", "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895"]);
  level thread setup_enemy_sentries(3);
  wait 1.1;
  level obj_comms_start("_encstr_8D491591A5DC1626C62BAFC6DB5BB66EAF8D851C8EB7E0", "_encstr_8B4C024C", var_0);
  setomnvar("_encstr_A57719730B9F85460DD743916368921F7FB37B6F764273939090E3", 2);
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
  wait 1.1;
  level obj_comms_start("_encstr_8D491591A5DC1626C62BAFC6DB5BB66EAF8D851C8EB7E0", "_encstr_834C02D8", var_0);
  setomnvar("_encstr_A57719730B9F85460DD743916368921F7FB37B6F764273939090E3", 3);
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
  scripts\cp\crate_drops\cp_crate_drops::_id_12C40("_encstr_877209C5EAC24E4EF2FAC8", ["_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895", "_encstr_B8840F126B9D8FF218872D21B7C03CC3CD"]);
  level thread setup_enemy_sentries(4);
  wait 1.1;
}

waittill_all_valid_ai_are_gone(var_0) {
  thread waittill_any_2(var_0);
}

waittill_any_2(var_0) {
  wait 1;
  self notify("_encstr_96BD0D89D20F0BA061D3777BFAD620");

  if(isDefined(self.aitype) && self.aitype == "_encstr_82350FC293FA4356C2D9CB7DD858DC2BC9") {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!var_3 scripts\cp\utility::is_valid_player() || !var_3 isonground()) {
        continue;
      }
      self getenemyinfo(var_3);
      var_1[var_1.size] = var_3;
    }

    if(isDefined(var_1) && var_1.size > 0) {
      var_5 = scripts\engine\utility::getStruct("_encstr_8B92175DB65DDAF31BD07B3F49D1A7320D58A003B051670701", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_1 = sortbydistance(var_1, var_5.origin);

      if(isDefined(var_1[0]))
        scripts\cp\cp_modular_spawning::set_goal_pos(var_1[0].origin);
    }

    thread scripts\cp\cp_modular_spawning::enter_combat();
    wait 0.5;
    scripts\cp\cp_modular_spawning::set_goal_radius(500);
  }
}

obj_maj_comms_end(var_0) {
  scripts\cp\cp_objectives::lua_objective_complete("_encstr_BD87168DDBDCCEF6BCA1AF93ACDCE8E4B4B11DA3C9582D73");
}

obj_maj_secure_tower_init(var_0) {
  level notify("_encstr_950B116EE8DEC1AF0B5D3A7B7DDCADDED656B9");
  level thread spawn_soldiers_attack_tower();
  level notify("_encstr_8DCA125FE2E481C7C37A2BF0A19B0678FF7FC31D");
}

obj_maj_secure_tower_start(var_0) {
  _id_131E6("_encstr_AFA91475E1F8F79325795337654D9903C0692B7FFE18");
  level thread _id_131F1();
  scripts\mp\brclientmatchdata::getprophealth("_encstr_8C2F157778E06CFFEA03391FFD5F033BE5EFEB40A32D43");
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(25);
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(3, "_encstr_AF480B53ABD9CED737C12CBBB9");
  level.obj_reserved_juggs = 1;
  var_1 = scripts\engine\utility::getStruct("_encstr_A39217879B6A4A330BA3CE2117B1A8225658F389F8529131F6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setlocation(var_0.objectiveindex, 0, var_1.origin);
  level thread scripts\cp\cp_objectives::_id_1317E(var_0, var_1.origin);
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "_encstr_A7780FBBE0635F1F964F4337EB989BA2EF");
  level thread _id_12DD5("_encstr_A2DD138ECA8D34BD7D071A5EB9EBC5EA0BE439BC4C");
  var_2 = 220;
  var_3 = var_2 * var_2;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_1.origin, var_3)) {
      break;
    }

    wait 0.25;
  }
}

obj_maj_secure_tower_end(var_0) {}

obj_maj_find_keys_init(var_0) {}

wait_if_fail_calltrain(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_82AE11BF158001576F682AA271A8C38220EB26");
  level thread remind_calltrain(var_0, var_1, var_2, var_3);
  level waittill("_encstr_84C31A5637127E82688B713E7F58D32FF3C3C2C3ED5F57A6C8827010");
  objective_state(var_0, "_encstr_9B46072B7EA254ADAF");
  level.convoy4_failed_calltrain = 1;
  wait 3;
  scripts\cp\cp_objectives::_id_12868("_encstr_81E91323D2D6952F1002EF16C89BF1E95CBAC34310");
  level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}

remind_calltrain(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_82AE11BF158001576F682AA271A8C38220EB26");
  level endon("_encstr_84C31A5637127E82688B713E7F58D32FF3C3C2C3ED5F57A6C8827010");
  level thread remind_calltrain_sethot(var_0);
  wait(var_1 - var_2);
  setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 1);
  wait(var_2 - var_3);
  setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 2);
  wait(var_3);
  level notify("_encstr_84C31A5637127E82688B713E7F58D32FF3C3C2C3ED5F57A6C8827010");
}

remind_calltrain_sethot(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_82AE11BF158001576F682AA271A8C38220EB26");
  level endon("_encstr_84C31A5637127E82688B713E7F58D32FF3C3C2C3ED5F57A6C8827010");
  wait 300;

  for(;;) {
    wait 1;
    objective_sethot(var_0, 1);
    wait 1;
    objective_sethot(var_0, 0);
  }
}

obj_maj_find_keys_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(25);
  level thread scripts\cp\cp_wave_spawning::killstreaks(5, "_encstr_8D180F6EB5D5D9B3AFC166FAE8DBEEB293");
  var_1 = scripts\engine\utility::getStruct("_encstr_A39217879B6A4A330BA3CE2117B1A8225658F389F8529131F6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setlocation(var_0.objectiveindex, 0, var_1.origin);
  objective_icon(var_0.objectiveindex, "_encstr_88EC152D6CBDDCAF77B09738BDB4DCE8BEB1BDD8B5B219");
  objective_setdescription(var_0.objectiveindex, &"_encstr_87052DADC1BF1711E6E20D13AA59F956430825B7B843A569158B2F05D6B581356FB0FCDF807B6901D1A11D0B3BE992");
  level thread delay_objective_update("_encstr_A3CE0FB740F036B2BB558184D5834BD793", 1);
  level thread spawn_soldiers_juggs();
  level thread play_keys_intro_vo();
  level thread start_smoke_in_attic();
  level thread setup_enemy_sentries(5);

  if(!isDefined(level.convoy4_terminal_keys))
    level.convoy4_terminal_keys = 0;

  thread scripts\cp\utility::objective_update("_encstr_81E91323D2D6952F1002EF16C89BF1E95CBAC34310", 360, 180, 60, 0, undefined);
  thread wait_if_fail_calltrain(var_0.objectiveindex, 360, 180, 60);
  wait 1;
  var_2 = 0;

  while(!isDefined(level.convoy4_module_juggs_1) || !isDefined(level.convoy4_module_juggs_1.ai_spawned)) {
    wait 0.05;
    var_2 = var_2 + 0.05;

    if(var_2 > 30) {
      break;
    }
  }

  level thread _id_135CF(level.convoy4_module_juggs_1, "_encstr_A56B10CFF8701B1FEB9536902B0F58966F61", "_encstr_87490E5A10B5FBDF724D0F7825195752", "_encstr_A795178DDE73ECF62F68F553BA3BB3E67D987D98166CB5EA07");
  level thread _id_135CF(level.convoy4_module_juggs_2, "_encstr_866B10D8DEDC67DB2F43EB53AEB3ECCDFAC8", "_encstr_81490EC1870804301B7B499012B0B17E", "_encstr_91EC176C7BE6B37B2FD0EB53EA76B337AF19D7892C1BB5EAC1");
  level thread _id_135CF(level.convoy4_module_juggs_3, "_encstr_8B6B10263DB86310588FB042CB0FAF17B0A3", "_encstr_88490EB1DBDCECBD2FD0D760A1167D66", "_encstr_A57817BFC79A44F8F1837ED0FBD7807E212E4FC5971282E010");

  while(level.convoy4_terminal_keys < 3)
    wait 0.2;

  level notify("_encstr_840A176253FA0798D0B5853FD7B3C349A723A5C1D9871FB3E0");
  wait 1.5;
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
}

_id_135CF(var_0, var_1, var_2, var_3) {
  level endon("_encstr_872C062833FFECA1" + var_2 + "_encstr_BE670688368458A8");
  thread _id_13575(var_0, var_1, var_2, var_3);
  thread _id_13DD0(var_0, var_1, var_2, var_3);

  while(!isDefined(var_0) || var_0.ai_spawned.size == 0)
    wait 0.05;

  _id_13576(var_0, var_1, var_2);
}

_id_13576(var_0, var_1, var_2) {
  if(istrue(var_0.patrolfunc)) {
    return;
  }
  if(isDefined(var_0.ai_spawned) && var_0.ai_spawned.size > 0) {
    var_3 = var_0.ai_spawned[0];
    level thread spawn_key_objective(var_1, var_3, var_2);
    level notify("_encstr_872C062833FFECA1" + var_2 + "_encstr_BE670688368458A8");
  }
}

_id_13575(var_0, var_1, var_2, var_3) {
  level endon("_encstr_872C062833FFECA1" + var_2 + "_encstr_BE670688368458A8");

  for(var_4 = 0; !isDefined(var_0) || var_0.ai_spawned.size == 0 && var_4 < 5; var_4 = var_4 + 0.05)
    wait 0.05;

  if(var_0.ai_spawned.size > 0) {
    return;
  }
  thread scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_1);
  var_0 = scripts\cp\cp_modular_spawning::run_spawn_module(var_3);

  for(var_4 = 0; !isDefined(var_0) || var_0.ai_spawned.size == 0 && var_4 < 120; var_4 = var_4 + 0.5)
    wait 0.5;

  if(var_0.ai_spawned.size == 0) {
    level notify("_encstr_872C062833FFECA1" + var_2 + "_encstr_ABC80AF5CC584BC6E6C23395");
    return;
  }

  _id_13576(var_0, var_1, var_2);
  level notify("_encstr_872C062833FFECA1" + var_2 + "_encstr_BE670688368458A8");
}

_id_13DD0(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_872C062833FFECA1" + var_2 + "_encstr_BE670688368458A8");
  level waittill("_encstr_872C062833FFECA1" + var_2 + "_encstr_ABC80AF5CC584BC6E6C23395");
  wait(randomfloat(10));

  if(!isDefined(var_0) || var_0.ai_spawned.size == 0) {
    level.convoy4_terminal_keys = level.convoy4_terminal_keys + 1;
    var_0.patrolfunc = 1;
    level thread _id_123D7();
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_2);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_1);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_3);
    level notify("_encstr_872C062833FFECA1" + var_2 + "_encstr_BE670688368458A8");
    scripts\cp\utility::objective_update("_encstr_AAA90EF05842DB88136A97CFB3504B8F" + level.convoy4_terminal_keys);
  }
}

obj_maj_find_keys_end(var_0) {
  level notify("_encstr_A79311CDE87BE0F52CE8474BB1FAB9DABDB595");
}

spawn_key_objective(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_objectives::requestworldid(var_0, 15);
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 1);
  objective_setownerteam(var_3, undefined);
  objective_setlabel(var_3, &"_encstr_A11B268682AF8A5550254A2B46F59E4825540D5152AC15A979A17A93AC3D56A1D7B48A95F5629E86");
  var_4 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_4 notsolid();
  var_4 show();
  var_4 linkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 90), (0, 0, 0));
  var_1.jugg_obj_pos = var_4;
  objective_setlocation(var_3, 0, var_4);
  level thread disable_jugg_objective_position_on_death(var_1, var_3, 0, var_2);
  var_1 thread jugg_hold(var_1);
  objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_3);
  objective_icon(var_3, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_3, 0);
  objective_setbackground(var_3, 0);
  objective_showtoplayersinmask(var_3);
  objective_addalltomask(var_3);
  objective_setshowoncompass(var_3, 1);
}

jugg_hold(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0 notify("_encstr_B25A14BBB92BA28C8F06E7BB4011D027DBB3BD185313");
  var_0 notify("_encstr_8BC51B05BDC03FA3C0198A52C1277379B005AC8D1DF1C2E3F571B2CBA8");
  var_0.ignoreall = 1;
  var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
  var_0 thread watch_for_player_damage();
  var_0 jugg_hold_loop();
  var_0.ignoreall = 0;
  scripts\cp\cp_modular_spawning::remove_pacifist_from_guy();
  thread scripts\cp\cp_modular_spawning::enter_combat();
}

watch_for_player_damage() {
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(isPlayer(var_1)) {
      self notify("_encstr_848E0E18B16030E74E96C29A382F37EF");
      return;
    }
  }
}

jugg_hold_loop() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_848E0E18B16030E74E96C29A382F37EF");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0 = getdvarint("_encstr_B64F13CAF91201E015F8A7B9E008729C7712935F03", 1000);
  var_1 = var_0 * var_0;

  for(;;) {
    if(!isDefined(self.maxhealth)) {
      return;
    }
    if(self.health < self.maxhealth - 10) {
      return;
    }
    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      if(distancesquared(level.players[var_2].origin, self.origin) < var_1) {
        return;
      }
      if(scripts\engine\utility::within_fov(self getEye(), self.angles, level.players[var_2].origin, cos(65))) {
        if(distancesquared(level.players[var_2].origin, self.origin) < var_1 && self cansee(level.players[var_2]))
          return;
      }
    }

    wait 0.5;
  }
}

obj_maj_call_train_init(var_0) {
  level.obj_can_call_train = 1;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_B4FE1BD3B1900A48A8C6FD8398F171A3573D035FCD383215902BF99AFB");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_A9FE1B299809C0EF1F39287372D72738DE0A8DAB7AE178BD1FD326D39F");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_ACFE1B3AB8C7AEB303C80F2E79AEFF73E3802363726F643FBAC637662F");
}

obj_maj_call_train_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(16);

  if(isDefined(level.obj_reserved_juggs)) {
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(3, "_encstr_AF480B53ABD9CED737C12CBBB9");
    level.obj_reserved_juggs = undefined;
  }

  level.obj_allow_call_train = 1;
  scripts\cp\cp_interaction::addtointeractionslistbynoteworthy("_encstr_AF9717981A9A272F6F2A13583397DE96F0444C2FB34A89EB23");
  var_1 = scripts\engine\utility::getStruct("_encstr_A39217879B6A4A330BA3CE2117B1A8225658F389F8529131F6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_position(var_0.objectiveindex, var_1.origin);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setlabel(var_0.objectiveindex, &"_encstr_A9E02F90211FCACFBDA6DAD96E865FC6DD1118594155B79F5806DF3674AC4F034FC9A05011EF3B43CD1BD62FECF4BBD511");
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  level waittill("_encstr_82AE11BF158001576F682AA271A8C38220EB26");

  if(istrue(level.convoy4_failed_calltrain))
    wait 99;

  scripts\cp\utility::_id_123FE("_encstr_ABC01ADA57CDFAD81CBEB9B6AECE9D1B5693F53A392C2DDC8DB036C6");
  scripts\cp\cp_objectives::lua_objective_complete("_encstr_81E91323D2D6952F1002EF16C89BF1E95CBAC34310");
  scripts\cp\cp_objectives::reset_objective_timers();
  scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
  level play_vo_delay("_encstr_84B81CC8C3BEC638CDD7B1C2E6B9EB8BBA85C927F2197D5BACE5DCAF2618", undefined, undefined, undefined, 0.4);
}

obj_maj_call_train_end(var_0) {}

obj_maj_take_apache_init(var_0) {}

obj_maj_take_apache_start() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_9B6312872DB83977CFD1328AB9B0FB6E50890504", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  wait 13;
  var_1 = 3000;
  var_2 = var_1 * var_1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_2)) {
      break;
    }

    wait 0.1;
  }

  level notify("_encstr_B2611568FE3B5F932983CF9FCB7ADEB29F29BFFFD948B0");
  var_3 = "_encstr_8B610F8DF637B3DEF20D7DB007C28D3456";
  var_4 = getEnt("_encstr_8B610F8DF637B3DEF20D7DB007C28D3456", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = scripts\cp\cp_objectives::requestworldid(var_3, 15);
  objective_setlocation(var_5, 0, var_0);
  objective_setbackground(var_5, 2);
  objective_setplayintro(var_5, 1);
  objective_setplayoutro(var_5, 1);
  objective_state(var_5, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_5);
  objective_icon(var_5, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_5, 0);
  objective_setlabel(var_5, &"_encstr_ACFC2948F9C72227454E320156AE07BEB53930B1A97DEFE770DE271E1CF467EB770998D861AB12E7D5B335");
  level thread set_apache_desc_delay(1, var_5);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + (0, 0, -200));
  var_6 setModel("_encstr_AB7D1C5E9528C2C9C358CAF1F0237AA7E18BDFD43DF0B25BFF7023098829");
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + (0, 0, -210));
  var_7 setModel("_encstr_8DCA216DE564BAD8C7FAE8B642EF06C97E70D7118DCD72B5E73203BE6AA7BE4819DD71");
  var_4 thread activate_ks_on_use();
  level scripts\engine\utility::_id_143A5("_encstr_AB7E16A328174FF72007B5BB1BF8313745213B0B12E0CFAA", "_encstr_AAE5132062FE5B017BCB10F0B55FAB4FA78B2860FA");
  objective_state(var_5, "_encstr_8267056410C669");
  scripts\cp\cp_objectives::freeworldid(var_3);

  if(isDefined(var_6))
    var_6 scripts\engine\utility::delaycall(4, ::delete);

  if(isDefined(var_7))
    var_7 scripts\engine\utility::delaycall(4, ::delete);
}

set_apache_desc_delay(var_0, var_1) {
  wait(var_0);
  objective_setlabel(var_1, &"_encstr_ACFC2948F9C72227454E320156AE07BEB53930B1A97DEFE770DE271E1CF467EB770998D861AB12E7D5B335");
}

activate_ks_on_use() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B8FD18688F7DC8C77AAFDD48C2120B92D56B69B0A70CC3E7C2D2");
  var_0 = &"_encstr_B84F21C8F750475301B54A794DC9ED4372CD40C1BC8CAF1A9A53436DFF5162970EC4B8";
  self setHintString(var_0);
  self setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("_encstr_BD1805CB69C063");
  self setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  self makeusable();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(scripts\cp\cp_weapon::_id_124AD(var_1)) {
      scripts\cp\cp_weapon::minigamefinishcount(var_1);
      continue;
    }

    level thread activate_apache_on_player(var_1);
    var_1 thread make_traindoors_outlines_disabled_ks(var_1);
    self makeunusable();
    break;
  }

  self delete();
}

make_traindoors_outlines_disabled_ks(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.convoy4_train_doors)) {
    for(var_1 = 0; var_1 < level.convoy4_train_doors.size; var_1++) {
      if(isent(level.convoy4_train_doors[var_1]))
        level.convoy4_train_doors[var_1] hudoutlinedisableforclient(var_0);
    }
  }

  self waittill("_encstr_B45E151389187A1756D9AA720325DF72902BAD8D251047");

  if(!istrue(level.obj_train_stopped)) {
    return;
  }
  if(isDefined(level.convoy4_train_doors)) {
    for(var_1 = 0; var_1 < level.convoy4_train_doors.size; var_1++) {
      if(isent(level.convoy4_train_doors[var_1]))
        level.convoy4_train_doors[var_1] hudoutlineenableforclient(var_0, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246");
    }
  }
}

obj_maj_wait_train_init(var_0) {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "_encstr_ACF415877086359F33F907C313CF897380654C475A1D56");
  level thread _id_131F0();
}

obj_maj_wait_train_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(22);
  level thread scripts\cp\cp_wave_spawning::killstreaks(5, "_encstr_A5830FAAC1930AE76E085EE7A3E3D9520D");
  level thread train_handler();
  level thread spawn_soldiers_rooftops();
  level thread play_cargo_intro();
  level thread setup_enemy_sentries(3);
  var_1 = scripts\engine\utility::getStruct("_encstr_9935129FE7BA641811639E901EFA619D9347033D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setdescription(var_0.objectiveindex, &"_encstr_BE12281A82EBA2AA0A25A456C8BED348492A0D2A252B15D4F2343D7295E956A1D775284A452AA4059239");
  objective_position(var_0.objectiveindex, var_1.origin);
  level thread scripts\cp\cp_objectives::_id_1317E(var_0, var_1.origin);
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_0.objectiveindex, 0);
  level thread obj_maj_take_apache_start();
  level waittill("_encstr_BA1C16936F3D4B306B6F3F5BD2116AD02943DBFF338172C7");
}

obj_maj_open_train_init(var_0) {
  level.trial_target_thread_func = 1;
}

obj_maj_open_train_start(var_0) {
  objective_setdescription(var_0.objectiveindex, &"_encstr_991429C669C9DF15FB062209D35FE83BC0FDB395D4A390AECFBEE4E561EF5022D98549E6C0B8EE9DEFF13A");
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(22);
  var_1 = scripts\cp\cp_breach_c4::setup_c4(scripts\engine\utility::getStruct("_encstr_919B0F019ABEA8E84B22208B493FBD61C2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  var_2 = scripts\cp\cp_breach_c4::setup_c4(scripts\engine\utility::getStruct("_encstr_8E9B0F9C0DE0B44BC510F22BFEAEFAE1D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));
  level thread wait_for_door_breach(var_1);
  level thread wait_for_door_breach(var_2);
  level thread patrol_in_stealth();
  level.convoy4_train_c4s = 0;
  var_3 = scripts\engine\utility::getStructArray("_encstr_B462126BB8EB7C9BF6217F67C51E27C3356882E3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = undefined;
  level.convoy4_train_c4objs = level thread spawn_train_c4_objects();
  var_5 = scripts\engine\utility::getStructArray("_encstr_97941089120610602F7BCB913357AE681D94", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = (0, 0, 175);

  for(var_7 = 0; var_7 < level.convoy4_train_doors.size; var_7++) {
    foreach(var_9 in level.players) {
      if(var_9 scripts\cp_mp\killstreaks\chopper_gunner::isusingchoppergunner()) {
        continue;
      }
      level.convoy4_train_doors[var_7] hudoutlineenableforclient(var_9, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246");
    }

    level.convoy4_train_doors[var_7].obj_index = var_7;
    objective_setlocation(var_0.objectiveindex, var_7, level.convoy4_train_doors[var_7].origin + var_6);
    level thread hacking_magicgrenade_watcher(undefined, level.convoy4_train_doors[var_7].origin, 300);
  }

  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_0.objectiveindex, 1);
  var_11 = undefined;
  level waittill("_encstr_928C0C273211552880ED1089577C", var_11);
  var_12 = scripts\engine\utility::getclosest(var_11, level.convoy4_train_doors, 400);
  playFX(scripts\engine\utility::getfx("_encstr_8A9711CCEB1841735399D188B0722DE7AE6662"), var_12.origin + (0, 0, 52), var_12.angles, anglestoup(var_12.angles));
  level.convoy4_train_doors = scripts\engine\utility::array_remove(level.convoy4_train_doors, var_12);
  var_12 hudoutlinedisable();

  if(isDefined(var_12.open_tut_gate))
    var_12.open_tut_gate delete();

  var_12 delete();
  objective_unsetlocation(var_0.objectiveindex, var_12.obj_index);
  var_4 = level thread spawn_train_stairs(var_11, var_5);
  level thread spawn_c4_interacts_for_train(var_4, var_3);
  level waittill("_encstr_928C0C273211552880ED1089577C", var_11);
  var_12 = scripts\engine\utility::getclosest(var_11, level.convoy4_train_doors, 400);
  playFX(scripts\engine\utility::getfx("_encstr_8A9711CCEB1841735399D188B0722DE7AE6662"), var_12.origin + (0, 0, 52), var_12.angles, anglestoup(var_12.angles));
  objective_setdescription(var_0.objectiveindex, &"_encstr_A35B294FE190296D3967B24853F14FD0C253C7EB3BBCD023222DFD85379991EF20D91B3783C839E4F9B423");
  scripts\cp\utility::objective_update("_encstr_B64412DF60BEA020FB8A58432F6727E051F55893");
  level notify("_encstr_813A0EE05D22BF3D6B8B9BB121F7C038");
  level.obj_take_loot = 1;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_85012123C3FAD8E09B7DB5B0D685FA8BAE0BE4935EC8EB73C2D9EBA3E40B5A73EB4C60");
  level thread play_cargo_c4_nags();
  var_12 hudoutlinedisable();

  if(isDefined(var_12.open_tut_gate))
    var_12.open_tut_gate delete();

  var_12 delete();
  objective_unsetlocation(var_0.objectiveindex, var_12.obj_index);
  var_4 = level thread spawn_train_stairs(var_11, var_5);
  level thread spawn_c4_interacts_for_train(var_4, var_3);

  while(level.convoy4_train_c4s < 4)
    wait 0.1;

  level notify("_encstr_B8120E41516881B9D97E33C1FB40CF73");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_9A701CF4B366079A6781820B63E71297191E6A71EE0E03226BD89A91D251");
  scripts\cp\cp_objectives::screenent_c("_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
}

patrol_in_stealth() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_92F708A803EA9FCF06FD", var_0);
  level thread patrol_think(var_0);
  level waittill("_encstr_92F708A803EA9FCF06FD", var_1);
  level thread patrol_think(var_1);
}

patrol_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = 2500;
  wait 6;
  var_2 = var_0.origin;
  var_3 = 0;
  var_4 = 0;

  while(var_4 < 5) {
    if(distancesquared(var_0.origin, var_2) <= var_1)
      var_3 = var_3 + 1;

    var_4 = var_4 + 1;
    wait 1;
  }

  if(var_3 > 3) {
    if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_5 = scripts\engine\utility::getStructArray("_encstr_BE771422D3700A53D3D7B7E3B77D6B5378FEDAEA0870", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_6 = scripts\engine\utility::getclosest(var_0.origin, var_5);
      var_0 setOrigin(var_6.origin);
    }
  }
}

wait_for_door_breach(var_0) {
  var_0 scripts\engine\utility::ent_flag_wait("_encstr_928C0C273211552880ED1089577C");
  level notify("_encstr_928C0C273211552880ED1089577C", var_0.origin);
}

spawn_train_stairs(var_0, var_1) {
  var_2 = scripts\engine\utility::getclosest(var_0, var_1, 200).script_noteworthy;
  return var_2;
}

spawn_train_c4_objects() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9ACB0BB7412AC7274B29A8C954", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [];
  var_2 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.angles))
      var_4.angles = (0, 0, 0);

    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    var_5 setModel(var_4.script_noteworthy);
    var_5.angles = var_4.angles;
    var_1[var_1.size] = var_5;
    waitframe();
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
    var_6 clonebrushmodeltoscriptmodel(var_2);
    var_6.angles = var_4.angles;
    var_1[var_1.size] = var_6;
    waitframe();
  }

  return var_1;
}

spawn_c4_interacts_for_train(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].script_noteworthy == var_0) {
      var_1[var_2] create_usable_c4_model(var_2);
      wait 0.05;
    }
  }
}

create_usable_c4_model(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_B61D11B71335D7D87BF63AFA07A5365BBAE0BE" + var_0, 15);
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 1);
  objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_1);
  objective_setbackground(var_1, 0);
  objective_setlabel(var_1, &"_encstr_82F021C0FB87591305AA2F59DAB6F5460869341DE93B8847453D1771B85CA1D187176C");
  objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_1, 1);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 4));
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = self.angles;
  var_2._id_12EAD = var_2.angles;

  if(isDefined(self.script_parameters))
    var_2.script_parameters = self.script_parameters;

  waitframe();
  var_3 = &"_encstr_960B23A951E1DFA98D514923858EBF13727D88DDB4D94972E268A099BDAD2E570193674C33";
  objective_position(var_1, var_2.origin + (0, 0, 12));
  var_2 setHintString(var_3);
  var_2 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_2 sethinticon("_encstr_88FF1268537C29B806D035FF8E0BEF7B42E9AB60");
  var_2 sethintdisplayrange(500);
  var_2 sethintdisplayfov(65);
  var_2 setuserange(72);
  var_2 setusefov(65);
  var_2 sethintonobstruction("_encstr_BECC055CF3811A");
  var_2 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_2 sethintrequiresholding(1);
  var_2 makeusable();
  var_2 thread c4_use_think(var_1, var_0);
  return var_2;
}

c4_use_think(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(var_2)) {
      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      var_2 playSound("_encstr_999B12469361FFC2B8434BDFB7C85B3958587B0A");

      if(level.convoy4_train_c4s < 3)
        thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_2, "_encstr_BD1E13BD4CD4F5C82B9D5A6C95F5E695E8E8A5373B");
      else
        thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_2, "_encstr_AD2015ED894DFAC6B7B18DCAB147F536DBB50EC6B2E8CA");

      thread placed_c4_train(var_0, var_1);
      scripts\cp\cp_objectives::freeworldid("_encstr_B61D11B71335D7D87BF63AFA07A5365BBAE0BE" + var_1);
    }
  }
}

placed_c4_train(var_0, var_1) {
  self setModel("_encstr_B1BE11D5BB5A3AFFE092C9231DE1B07D710197");

  if(isDefined(self.script_parameters)) {
    var_2 = self.script_parameters;
    self.angles = (self.angles[0], self.angles[1], int(var_2));
  }

  self.origin = self.origin - (0, 0, 4);
  self setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A24E069389FFAA3C", 0);
  self playLoopSound("_encstr_BAE1116C07D798F6B51337D2D1CAEB31562B38");
  level.convoy4_train_c4s = level.convoy4_train_c4s + 1;
  objective_state(var_0, "_encstr_8267056410C669");
  self makeunusable();
  level waittill("_encstr_8A9B11CFC35E705153DBE789A57C21656D65A2");
  remove_c4_train();
}

remove_c4_train() {
  self stoploopsound("_encstr_BAE1116C07D798F6B51337D2D1CAEB31562B38");
  playFX(level._effect["_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"], self.origin);
  self delete();
}

obj_maj_extraction_init(var_0) {
  level thread spawn_soldiers_ending();
  level thread start_smuggler_heli_flyin();
  level.obj_used_extract_num = 0;
  level.trial_target_thread_func = 1;
}

obj_maj_extraction_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(24);
  var_1 = scripts\engine\utility::getStruct("_encstr_889217F626D42BD8D1A5D9B2D76C7BDCB3B7F2A1BE60A9EB58", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_position(var_0.objectiveindex, var_1.origin);
  level thread scripts\cp\cp_objectives::_id_1317E(var_0, var_1.origin);
  scripts\cp\cp_objectives::_id_11F80(var_0.objectiveindex);
  objective_setownerteam(var_0.objectiveindex, "_encstr_9A8507BA4040188D08");
  objective_sethot(var_0.objectiveindex, 0);
  objective_icon(var_0.objectiveindex, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setdescription(var_0.objectiveindex, &"_encstr_BE632EA7F9405F073169123F3AE9559AC9E53BF5F99BF15BBE98D9CB2FF8C31D71DDD187E6B521F84F8BEBAD19AFEDED");
  objective_setlabel(var_0.objectiveindex, &"_encstr_950F24DF298903E1BF63CE30236F07C235E906A1A001C137059953786D4C197631E839588D42");
  scripts\cp\utility::_id_123FE("_encstr_B1E31C6BAEB9BE3683AFCDDABACEB3C659E4F55BD29B9B4BF6B9F5B23791");
  level thread spawn_map_ac130();
  level thread disable_nearby_vehicles(var_1.origin, 800);
  level thread _id_123E3(var_0.objectiveindex);
  level thread _id_1240E(var_1);
  level wait_for_start_extraction(var_1.origin, var_0.objectiveindex);
  level.obj_allow_fulton = 0;
  level thread kiosksearchradiusidealmin();
}

delayed_disable_respawns(var_0) {
  wait(var_0);
  level.disable_respawns = 1;
}

kiosksearchradiusidealmin() {
  wait 2;

  if(istrue(level.i_see_player_vehicle_watcher)) {
    return;
  }
  level thread play_outro_vo();
  wait 4.5;
  level thread mp_shipment_patch();
  wait 2;
  level thread complete_game_win();
}

smuggler_door_lock() {
  wait 10;
  var_0 = scripts\engine\utility::getStruct("_encstr_A3E6134B3850BA3488819329F29FA0D9384BD8888D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_1 = "_encstr_93E62C734EB35FEA19E0C21AF877660F682EFC0ADD399374C7701992C07F1AA7A69975847F20F7FEFF9AD739C899";
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(1, var_0, 128, var_1, "_encstr_AC110A7F14873B5B3D073009");
}

smuggler_door_unlock() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A3E6134B3850BA3488819329F29FA0D9384BD8888D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_1 = "_encstr_93E62C734EB35FEA19E0C21AF877660F682EFC0ADD399374C7701992C07F1AA7A69975847F20F7FEFF9AD739C899";
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_13BC1(0, var_0, 128, var_1, "_encstr_AC110A7F14873B5B3D073009");
}

start_smuggler_heli_flyin() {
  wait 1;
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  waitframe();
  scripts\engine\utility::flag_init("_encstr_8FE810B3283D1757F053D2F773A81D57E661");
  wait 5;
  level thread spawn_smuggler_javelin();
  level thread smuggler_door_unlock();
  var_0 = scripts\engine\utility::getStruct("_encstr_84E31C7AA0788B8D90093703A32857079119E321E845BB44C9AF14197508", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStruct("_encstr_A28F1E1BDE9BD9BDBCA1AFCDB5EAB3B3C695E4AFA12B8DA5BEC6589BC8A5B93B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.team = "_encstr_8E8405EA382B2A";

  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.classname_mp = "_encstr_AA6F1AFF6F7308C395309EDDD0630AC369B19A8B721F128AAAC95B67";
  var_0.script_modelname = "_encstr_B85414BCDF02F19615D70899DF390B87EA86364F732A";
  var_0.vehicletype = "_encstr_85DC1042C9BE0F13E827C9C67DF0DDAF6EE3";
  wait 15;
  level.smuggler_heli = spawn_objective_heli(var_0);
  level thread spawn_smuggler_heli_pilot();
  level.smuggler_heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_0);
  level.smuggler_heli playLoopSound("_encstr_95A3252F204ECA8B0F0EE05A7A67D2981088DBBFA8A60592472B2D9748C9EA56FBD0EF23989B6C");
  level thread scripts\common\vehicle_paths::gopath(level.smuggler_heli);
  level.smuggler_heli thread spawn_smuggler_and_board_heli();
  scripts\engine\utility::flag_wait("_encstr_8FE810B3283D1757F053D2F773A81D57E661");
  level thread smuggler_heli_objective(level.smuggler_heli);
}

spawn_smuggler_heli_pilot() {
  waitframe();
  level.smuggler_heli.pilot = level.smuggler_heli thread setup_pilot("_encstr_93680B3AB03BAF385A1BBD8E19", (0, 0, -20));
}

spawn_objective_heli(var_0) {
  var_1 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_1.vehicle_skipdeathmodel = 1;
  var_1.death_fx_on_self = 1;
  var_1.vehicle_skipdeathcrash = 0;
  var_1.health = var_1.health + 1500;
  var_1.team = "_encstr_8E8405EA382B2A";
  var_1.affectedbylockon = 1;
  level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(var_1);
  level thread set_smuggler_crash_loc(var_1);
  var_1 thread smuggler_heli_waittill_javelined();
  level thread isplayeronintelchallenge();
  return var_1;
}

isplayeronintelchallenge() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(getdvarint("_encstr_923816D7DF2EE1742049A32F06A0BD0A0B0F132F47DAAA26", 0) == 0)
    wait 1;

  announcement("_encstr_A11A14D87BB15BF69B370EAC6C96C28DB996E9958E40" + level.special_lockon_target_list.size);
  wait 3;
  var_0 = 0;

  foreach(var_2 in level.special_lockon_target_list) {
    var_0++;
    announcement("_encstr_AA4C0223" + var_0 + "_encstr_AB4C0246" + var_2.targetname);
    wait 1;
  }
}

smuggler_heli_waittill_javelined() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isPlayer(var_1) && isDefined(var_9) && getweaponbasename(var_9) == "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920") {
      self dodamage(5000, self.origin, var_1);
      self notify("_encstr_AD75063D571AE108");
    }

    if(isPlayer(var_1))
      var_1 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_A5AE098ADB583E0AF7A5AB", 1, var_0, 0, 0);
  }
}

set_smuggler_crash_loc(var_0) {
  var_0 waittill("_encstr_AD75063D571AE108", var_1);
  var_2 = scripts\engine\utility::getStructArray("_encstr_B8BC1453EAEF8408354DC5A7785F985B9FE28B999333", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0.perferred_crash_location = scripts\engine\utility::getclosest(var_0.origin, var_2);
  var_3 = var_0.perferred_crash_location.origin;
  var_0 thread getcurrentxp();
  var_4 = var_0 scripts\engine\utility::_id_143B9(25, "_encstr_A6031278D920CF1E337059BFB30AE728497B302A");

  foreach(var_6 in level.players) {
    if(isDefined(var_1) && isPlayer(var_1) && var_6 == var_1) {
      thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_6, "_encstr_8CDC13176D9251D3D01B12DF73891B0BFE87A7EFF7");
      continue;
    }

    thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_6, "_encstr_8EE916EDCA43484086AA1F03B46180A9375258A842939D38");
  }

  if(isDefined(var_0) && isent(var_0)) {
    playFX(level._effect["_encstr_B2251330933804F3D083928969B627FBC009B59811"], var_0.origin);
    playsoundatpos(var_0.origin, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
  } else {
    playFX(level._effect["_encstr_B2251330933804F3D083928969B627FBC009B59811"], var_3);
    playsoundatpos(var_3, "_encstr_B4E1196C83BE1327AFE6CB9CDAAF8D43DBE0C159C97DC693B0DCD0");
  }

  if(isDefined(var_0.pilot) && isent(var_0.pilot))
    var_0.pilot delete();

  if(isDefined(level.smuggler_heli.smugglermdl) && isent(level.smuggler_heli.smugglermdl))
    level.smuggler_heli.smugglermdl delete();

  if(isent(var_0))
    var_0 delete();
}

getcurrentxp() {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  self endon("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");

  for(;;) {
    var_0 = self.origin;
    wait 0.5;

    if(self.origin == var_0)
      self notify("_encstr_A6031278D920CF1E337059BFB30AE728497B302A");
  }
}

setup_pilot(var_0, var_1, var_2) {
  var_3 = "_encstr_BDF30A3B51CCFF9AC049F7D4";

  if(isDefined(var_0))
    var_3 = var_0;

  var_4 = (0, 0, 0);

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = (0, 0, 0);

  if(isDefined(var_2))
    var_5 = var_2;

  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin(var_3));
  var_6 setModel("_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4");
  var_6 linkTo(self, var_3, var_4, var_5);
  var_6 scriptmodelplayanim("_encstr_B84A1673790882CCD038D6513378185BFD994FE3C3C91AAC");
  return var_6;
}

spawn_smuggler_and_board_heli() {
  var_0 = smuggler_spawn();
  var_0.script_startingposition = 3;
  var_0.dontkilloff = 1;
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0 scripts\common\utility::demeanor_override("_encstr_92100762872552A643");
  var_0.scripted_mode = 1;
  level thread _id_1342B(var_0);
  level thread smuggler_base_room();
  wait 18;

  if(!isalive(self)) {
    return;
  }
  var_1 = scripts\engine\utility::getStruct("_encstr_925B15C220E5F9E788A57F7731513B3117B0FB5A1857AA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getclosestpointonnavmesh(var_1.origin);
  var_0 setgoalpos(var_2);
  thread scripts\cp\utility::drawsphere(var_2, 25, 9999, (1, 0, 0));
  var_0 thread smuggler_timeout_backup(25);
  var_0 wait_for_soldier_at_heli(var_2);

  if(!isDefined(level.smuggler_heli) || !isent(level.smuggler_heli) || !isalive(var_0)) {
    level waittill("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");

    if(isent(var_0))
      var_0 kill();

    scripts\engine\utility::flag_set("_encstr_8FE810B3283D1757F053D2F773A81D57E661");
    return;
  }

  var_0 notify("_encstr_A6170C3797EB09D55711D0790A67");
  var_0 hide();
  var_0.origin = (34917, 29465, 562);
  var_2 = getclosestpointonnavmesh(var_0.origin);
  var_0 setgoalpos(var_2);
  var_0 thread _id_1342C();
  level.smuggler_heli.smugglermdl = level.smuggler_heli thread setup_pilot("_encstr_AB680B55361AD76B09EB28E886", (0, 0, -20));
  wait 0.5;
  scripts\engine\utility::flag_set("_encstr_8FE810B3283D1757F053D2F773A81D57E661");
}

_id_1342B(var_0) {
  var_0 endon("_encstr_A6170C3797EB09D55711D0790A67");
  var_0 waittill("_encstr_AD75063D571AE108");
  level._id_11F79 = 1;
}

_id_1342C() {
  self endon("_encstr_AD75063D571AE108");
  wait 5;
  self kill();
}

spawn_smuggler_javelin() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_99E6110E48AB5A22AC252E40A2E8CBCAD2EB70", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = "_encstr_AC2A16B4C6BD37AFEE568538EDB9AF36C2D79AAE8D4BCA1D";
  var_2 = scripts\cp_mp\entityheadicons::setheadicon_singleimage;

  foreach(var_4 in var_0) {
    var_5 = scripts\cp\cp_weapon::buildweapon("_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    var_6 = createheadicon(var_5);
    var_7 = spawn("_encstr_B2010820C5337B67C8CF" + var_6, var_4.origin);
    var_7.angles = var_4.angles;
    var_7 itemweaponsetammo(weaponclipsize(var_5), weaponmaxammo(var_5));
    var_7.boxiconid = var_7 thread[[var_2]]("_encstr_9A8507BA4040188D08", var_1, 12, 1, 800, 100, undefined, undefined, 1);
    var_7 thread wait_for_player_pickup();
  }
}

wait_for_player_pickup() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
  setheadiconimage(self.boxiconid);
}

wait_for_soldier_at_heli(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A11910D02B364BF5D9F6EB8E2DD6CAEDBA47");
  var_1 = 1600;

  for(;;) {
    var_2 = distance2dsquared(self.origin, var_0);

    if(var_2 < var_1) {
      break;
    }

    wait 0.1;
  }

  wait 0.5;
}

smuggler_timeout_backup(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A6170C3797EB09D55711D0790A67");
  wait(var_0);
  self notify("_encstr_A11910D02B364BF5D9F6EB8E2DD6CAEDBA47");
}

smuggler_spawn() {
  level.convoy4_module_smugg_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_ACF415877086359F33F907C313CF897380654C475A1D56");
  var_0 = undefined;

  while(!isDefined(level.convoy4_module_smugg_1) || !isDefined(level.convoy4_module_smugg_1.ai_spawned))
    wait 0.05;

  while(level.convoy4_module_smugg_1.ai_spawned.size == 0)
    wait 0.05;

  if(isDefined(level.convoy4_module_smugg_1.ai_spawned) && level.convoy4_module_smugg_1.ai_spawned.size > 0)
    var_0 = level.convoy4_module_smugg_1.ai_spawned[0];

  return var_0;
}

smuggler_heli_objective(var_0) {
  level endon("_encstr_8550172D05DA27FBFD5FB840C30D13EFB2AE12A5DEB33303DD");
  var_1 = "_encstr_BA090E522020EFF249B3BB17B7E38A2C";
  var_2 = scripts\cp\cp_objectives::requestworldid(var_1, 15);
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 1);

  if(isDefined(var_0) && isent(var_0)) {
    var_3 = var_0 scripts\engine\utility::spawn_tag_origin();
    var_3 notsolid();
    var_3 show();
    var_3 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 256), (0, 0, 0));
    var_0.obj_pos = var_3;
    objective_setlocation(var_2, 0, var_0.obj_pos);
  }

  objective_state(var_2, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_2);
  objective_setlabel(var_2, &"_encstr_AC3924D00ABE4555142592568CBE7A90252A1A512559A8A6F2B4259889D7D49AAA8E8E621549");
  objective_icon(var_2, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_sethot(var_2, 1);
  objective_setbackground(var_2, 0);
  objective_addalltomask(var_2);
  objective_showtoplayersinmask(var_2);

  if(istrue(level._id_11F79)) {
    level thread scripts\cp\utility::objective_update("_encstr_97AF1636DEB99DED2FA17DAD4B1BC6BE9BB6D576D98D5627", undefined, undefined, undefined, 1, undefined, 2);
    wait 1;
  } else {
    level thread scripts\cp\utility::objective_update("_encstr_97AF1636DEB99DED2FA17DAD4B1BC6BE9BB6D576D98D5627", undefined, undefined, undefined, 1, undefined, 2);

    if(isDefined(var_0) && isent(var_0)) {
      level thread _id_1241E();
      level thread smuggler_too_far_fail(60, var_1, var_2, var_0);
    }

    if(isDefined(var_0) && isent(var_0))
      var_0 waittill("_encstr_AD75063D571AE108");
    else
      wait 1;
  }

  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_ACF415877086359F33F907C313CF897380654C475A1D56");
  scripts\cp\cp_objectives::lua_objective_complete("_encstr_97AF1636DEB99DED2FA17DAD4B1BC6BE9BB6D576D98D5627");
  objective_state(var_2, "_encstr_8267056410C669");
  scripts\cp\cp_objectives::freeworldid(var_1);
}

smuggler_too_far_fail(var_0, var_1, var_2, var_3) {
  var_3 endon("_encstr_AD75063D571AE108");
  wait(var_0);
  objective_unsetlocation(var_2, 0);
  wait 10;
  level notify("_encstr_8550172D05DA27FBFD5FB840C30D13EFB2AE12A5DEB33303DD");
  objective_state(var_2, "_encstr_9B46072B7EA254ADAF");
  scripts\cp\cp_objectives::fail_objective("_encstr_BA090E522020EFF249B3BB17B7E38A2C");
  scripts\cp\cp_objectives::freeworldid(var_1);
}

smuggler_base_room() {
  var_0 = scripts\engine\utility::getStruct("_encstr_A3E6134B3850BA3488819329F29FA0D9384BD8888D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  var_1 = 2304;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_1)) {
      break;
    }

    wait 3;
  }
}

disable_nearby_vehicles(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = level.vehicle.instances["_encstr_84D70A6B2BEF3C9B30A67164"];

  if(!isDefined(var_3)) {
    return;
  }
  for(;;) {
    var_3 = level.vehicle.instances["_encstr_84D70A6B2BEF3C9B30A67164"];

    foreach(var_5 in var_3) {
      if(distance2dsquared(var_5.origin, var_0) <= var_2)
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_5, 0);
    }

    wait 0.5;
  }
}

game_ended_fadeout() {
  self.endgame_overlay = newclienthudelem(self);
  self.endgame_overlay.x = 0;
  self.endgame_overlay.y = 0;
  self.endgame_overlay setshader("_encstr_83AB065EE1391A7B", 640, 480);
  self.endgame_overlay.alignx = "_encstr_A5AD056A019C63";
  self.endgame_overlay.aligny = "_encstr_AC190479FF92";
  self.endgame_overlay.sort = 1;
  self.endgame_overlay.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.endgame_overlay.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  self.endgame_overlay.alpha = 0;
  self.endgame_overlay.foreground = 1;
  self.endgame_overlay fadeovertime(3);
  self.endgame_overlay.alpha = 1;
}

delay_objective_update(var_0, var_1) {
  wait 0.05;

  if(istrue(var_1))
    level thread scripts\cp\utility::objective_update(var_0);
  else
    level thread scripts\cp\utility::objective_update(var_0, 30, 25, 15);
}

debugbeatobjective(var_0) {
  level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0 + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
}

make_civ_usable(var_0, var_1) {
  scripts\cp\cp_hostage::civ_init(self);
  self.onuse = ::civ_try_go_to_extract;
  self.trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (-1, 0, 35));
  self.trigger linkTo(self, "_encstr_A1190BD4FABB9396DC47EB8DAC");
  self.trigger makeusable();
  self.trigger setuseprioritymax();
  self.trigger setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self.trigger sethintdisplayrange(148);
  self.trigger sethintdisplayfov(90);
  self.trigger setuserange(72);
  self.trigger setusefov(45);
  self.trigger sethintonobstruction("_encstr_BD1805CB69C063");
  self.trigger sethintrequiresholding(1);
  self.trigger setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  scripts\engine\utility::set_movement_speed(170);
  thread scripts\engine\utility::delete_on_death(self.trigger);
  thread scripts\cp\cp_hostage::ai_used_think();
}

civ_try_go_to_extract(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8F4812E067AC5B1B2A1185B779F26903F2F778F0");
  self endon("_encstr_B8690B2BA89F277B84633B5B23");
  self notify("_encstr_B1DA09D3DB3FF1756059F7");
  self notify("_encstr_A2911166BDD8D8B7DD5A73ECF51CB1162F95E4");
  var_2 = self.extractloc;
  var_3 = 350;
  var_4 = 250;
  var_5 = 1000000;
  var_6 = var_3 * var_3;
  var_7 = var_4 * var_4;
  self.combatmode = "_encstr_821109FAE81117DA568730";
  self.trigger makeunusable();
  wait 2;

  for(;;) {
    wait 0.5;
    var_2 = self.extractloc;
    scripts\cp\cp_modular_spawning::set_goal_radius(32);

    if(!scripts\cp\utility::any_player_nearby(self.origin, var_6)) {
      objective_sethot(self.objectiveindex, 1);
      objective_setlabel(self.objectiveindex, &"_encstr_8DFB2B2091AF5A5F2DD6AAA9FE36EF562D81A8C931C5070FC83356A1607CA7A9C1213091C9654943FD8F5AA21B");
      self allowedstances("_encstr_B13D076BED70539F23");
      var_8 = getclosestpointonnavmesh(self.origin);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_8);
      waitframe();
      continue;
    }

    if(are_enemies_nearby(var_7, var_5)) {
      objective_sethot(self.objectiveindex, 1);
      objective_setlabel(self.objectiveindex, &"_encstr_837424D082BE8AAA82A4A42B46FAA79049150D51A46551A9F286898A8229AF84F49A51053AA8");
      self allowedstances("_encstr_B13D076BED70539F23");
      var_8 = getclosestpointonnavmesh(self.origin);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_8);
      waitframe();
      continue;
    }

    if(distancesquared(var_2, self.origin) > 16384) {
      objective_sethot(self.objectiveindex, 0);
      objective_setlabel(self.objectiveindex, &"_encstr_A19427FB9F5EF7FB2B31B9011A3FA56314ED0364BBC7EF328F89504811C7EB07CC4497F8A14D274F5D");
      var_8 = getclosestpointonnavmesh(var_2);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_8);
      waitframe();
    }
  }
}

obj_comms_start(var_0, var_1, var_2) {
  var_3 = var_2.objectiveindex;
  objective_setownerteam(var_2.objectiveindex, undefined);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = 0;

  switch (var_1) {
    case "_encstr_994C023A":
      var_4 = "_encstr_9B9217ED4CA62B1BD196EC957D8D7BCDCEB72F86FA0346D716";
      var_5 = "_encstr_B4281B373845BDC73909038711C74259D7FEB83A9B512703A2570D714B";
      var_6 = &"_encstr_8C37276698B7E77B86F97121D729975D0B759E65292B2D3F65F0A18169F5F3DB07CB1C73AC1734DFCA";
      var_7 = "_encstr_B20219D0C32F0357BBB30983221F9A83411E10D97FA87BFB3EE371";
      var_8 = ::spawn_soldiers_switch_01;
      var_9 = 0;
      var_10 = 1;
      break;
    case "_encstr_8B4C024C":
      var_4 = "_encstr_869217604E721BA1BC670898D7C378551BB5E355E92F7DEE92";
      var_5 = "_encstr_B2281B3B873005AFC8E0627B0B385B71F81DA4851508CEFB8BB88A71D1";
      var_6 = &"_encstr_9A3727A75F7E890B36924123AAAF315B1AE028275424C1271878E07C91BF9897EF57FCD3F52E083E1A";
      var_7 = "_encstr_B20219D0C32F0357BBB30983221F9A83411E10D97FA87BFB3EE371";
      var_8 = ::spawn_soldiers_switch_02;
      var_9 = 150;
      var_10 = 2;
      break;
    case "_encstr_834C02D8":
      var_4 = "_encstr_8B92175DB65DDAF31BD07B3F49D1A7320D58A003B051670701";
      var_5 = "_encstr_A6281BB1B7DADA9B7D8DB00EE8B7E0F5B4DCA32BC916361D96F6CDEB36";
      var_6 = &"_encstr_AF372777B3015F514192473E9277491EE84FEFD1AFF90D59F73EECD4A31FA19D518F4F937370437183";
      var_7 = "_encstr_B20219D0C32F0357BBB30983221F9A83411E10D97FA87BFB3EE371";
      var_8 = ::spawn_soldiers_switch_03;
      var_9 = 100;
      var_10 = 3;
      break;
  }

  level thread stopwaveandstartthisone(var_8);
  level notify("_encstr_AD4F116013D1E2937B3809F3288FBA41A1CBA9" + var_1);
  level thread handle_remind_hack();
  level thread hacking_magicgrenade_watcher(undefined, var_4, var_9);
  level thread quarry_hacking_sfx(var_5, var_1);
  scripts\cp\cp_interaction::addtointeractionslistbynoteworthy(var_5);
  level.convoy4_comms_laptop_int_struct = scripts\cp\utility::getinteractionbynoteworthy(var_5);
  level.convoy4_comms_laptop_int_struct.objectivestruct = var_2;
  level.convoy4_comms_laptop_sn = var_4;

  if(isDefined(level.convoy4_comms_laptop_int_struct))
    level.convoy4_comms_laptop_int_struct.laptopactive = 1;

  var_11 = scripts\engine\utility::getStruct(var_4, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  objective_setplayintro(var_2.objectiveindex, 1);
  objective_setplayoutro(var_2.objectiveindex, 1);
  objective_position(var_2.objectiveindex, var_11.origin);
  level thread scripts\cp\cp_objectives::_id_1317E(var_2, var_11.origin);
  objective_state(var_2.objectiveindex, "_encstr_AF5A081BBAC993AC73A3");
  scripts\cp\cp_objectives::_id_11F80(var_2.objectiveindex);
  objective_icon(var_2.objectiveindex, var_7);
  objective_sethot(var_2.objectiveindex, 0);
  objective_setlabel(var_2.objectiveindex, var_6);

  if(var_1 == "_encstr_8B4C024C") {
    level thread handle_players_near_hack_b(var_11.origin, 650);
    level thread spawn_smoke_when_near_struct("_encstr_97DC1286E8BD030742D2074FE078CBFA69734DFB", 150, undefined, 900);
  }

  if(var_1 == "_encstr_834C02D8") {
    level thread spawn_smoke_when_near_struct("_encstr_8E7D156CDB9BECDEBCD0AFA12C1B6D66FA37ADB75BAC26", undefined, 20);
    level thread spawn_smoke_when_near_struct("_encstr_827D15B1EDE6ECF6F2437D34588DB6CCF5CDB67BD65923", undefined, 20);
    level thread spawn_smoke_when_near_struct("_encstr_927D15D78760333F80C3E92C0138733F5017576F171DAF", undefined, 20);
    level thread spawn_smoke_when_near_struct("_encstr_917D151BB7DC3B7BF2D0BE1A5836AD99D7B96BDEB5AC0D", undefined, 20);
  }

  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  level notify("_encstr_8BEA14216AC848CB71832E492137A88F6871EFC08719");
  scripts\cp\utility::_id_123FE("_encstr_B40101");
  level thread play_hack_vo(var_11);
  playsoundatpos(var_11.origin, "_encstr_91D513E0EB892AF70B1F4B358A87F7332396272BAE");
  level.i_see_player_shield_watcher = 0;
}

activationcommslaptop(var_0, var_1) {
  if(!istrue(level.convoy4_comms_laptop_int_struct.laptopactive)) {
    return;
  }
  thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_1, "_encstr_87500D7F058A49D1C023FF02B990F4");
  var_2 = 1;

  if(getdvarint("_encstr_BED0129AF6ADB921FB50ABA3B83BD7A3411DE7D7", 0) != 0)
    var_2 = 0.03;

  if(!isDefined(level._id_12958))
    level._id_12958 = 1;
  else
    level._id_12958++;

  var_3 = 120;

  switch (level._id_12958) {
    case 1:
      scripts\cp\utility::_id_123FE("_encstr_88611F9AE0AF91CF33984345A5F997E53B7021A2F879D7B78EFE5750B3414361FB");
      var_3 = 220;
      break;
    case 2:
      scripts\cp\utility::_id_123FE("_encstr_BD611F50AB3758E8F2B70703A51F809937B36EB9F2E38DB0C1633731D1C7A0C882");
      var_3 = 120;
      break;
    case 3:
      scripts\cp\utility::_id_123FE("_encstr_87611FB6AE37FAC638FA9BB5D5D99DD859397DCC968DB2CDBE8DDE382D568CEBCC");
      var_3 = 120;
      break;
  }

  var_0.objectivestruct = level.convoy4_comms_laptop_int_struct.objectivestruct;
  var_0.disabled = 1;
  var_0.objectivestruct notify("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243", var_0);
  level notify("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243", var_0);
  level.i_see_player_shield_watcher = 1;
  var_4 = scripts\cp\cp_objective_mechanics::starthackingdefense;
  var_5 = scripts\engine\utility::getStruct(level.convoy4_comms_laptop_sn, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
  [[var_4]](var_0.objectivestruct, var_5, 120 * var_2, "_encstr_8BEA14216AC848CB71832E492137A88F6871EFC08719", var_3);
}

quarry_hacking_sfx(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(var_1 == "_encstr_8B4C024C")
    level thread his_respawn(var_2);

  var_3 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_2.origin);
  wait 0.05;
  var_3 playLoopSound("_encstr_A3E8155BD0014A376940F0A0F780A0FBAEABDEEB0110FB");
  level waittill("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  level thread computer_animation(var_2);
  var_3 stoploopsound("_encstr_A3E8155BD0014A376940F0A0F780A0FBAEABDEEB0110FB");
}

hacking_magicgrenade_watcher(var_0, var_1, var_2) {
  level endon("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  level endon("_encstr_85F7156F53B2EAB7AF6BA888A63909179F41CC2848FBED");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.currentteam = "_encstr_9A8507BA4040188D08";
  }

  var_3 = 300;
  var_4 = var_3 * var_3;
  var_5 = 500 + var_2;
  var_6 = ["_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", "_encstr_8823119675DAFF897F878020BB99612B219D8F"];

  if(!isvector(var_1))
    var_1 = scripts\engine\utility::getStruct(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;

  for(;;) {
    var_7 = scripts\cp\utility::getplayersinteam(var_0.currentteam);
    var_8 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
    var_9 = scripts\engine\utility::getclosest(var_1, var_8, var_5);

    if(isDefined(var_9) && isalive(var_9)) {
      foreach(var_11 in var_7) {
        if(distancesquared(var_11.origin, var_1) <= var_4) {
          var_12 = var_11.origin - var_9.origin;
          var_13 = scripts\engine\utility::random(var_6);
          var_14 = randomfloatrange(1, 3);
          var_15 = var_9 launchgrenade(var_13, var_11.origin, (0, 0, 0), var_14);
          break;
        }
      }
    }

    wait(randomfloat(10) + 5);
  }
}

spawn_smoke_when_near_struct(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_950B116EE8DEC1AF0B5D3A7B7DDCADDED656B9");
  var_4 = scripts\engine\utility::getStruct(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_4)) {
    return;
  }
  if(isDefined(var_3)) {
    var_5 = var_3 * var_3;

    while(!scripts\cp\utility::any_player_nearby(var_4.origin, var_5))
      wait 0.5;
  }

  if(!isDefined(var_1)) {
    if(isDefined(var_4.radius))
      var_1 = int(var_4.radius);
    else
      var_1 = 150;
  }

  var_6 = var_1 * var_1;

  for(;;) {
    if(any_soldiers_nearby(var_4.origin, var_6)) {
      level thread magic_smoke_launch(var_4.origin, (0, 0, 10), 1);

      if(!isDefined(var_2)) {
        return;
      }
      wait(var_2);
    }

    wait 1;
  }
}

any_soldiers_nearby(var_0, var_1) {
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distancesquared(var_2[var_3].origin, var_0) <= var_1)
      return 1;
  }

  return 0;
}

magic_smoke_launch(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait(var_2);
    var_6 = anglesToForward(var_5.angles);
    var_7 = (0, 0, 1);
    var_0 = var_5.origin + (0, 0, 2);
    var_5 delete();
    magicgrenademanual("_encstr_8823119675DAFF897F878020BB99612B219D8F", var_0, (0, 0, 0), 0.3);
    thread scripts\engine\utility::play_sound_in_space("_encstr_AA84191EFD527731C70F18A8C311E993B96713271509019BA11308", var_0);
    wait 7;
  }
}

start_smoke_in_attic() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A79311CDE87BE0F52CE8474BB1FAB9DABDB595");
  var_0 = scripts\engine\utility::getStruct("_encstr_A941140BA3A34BC67DDCB5DBB6B2F51D3996EC3B2BE4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::getStructArray("_encstr_86C40CAF9BD84A86C72B5BB8CF9D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = 72;
  var_3 = var_2 * var_2;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0.origin, var_3)) {
      break;
    }

    wait 0.2;
  }

  foreach(var_5 in var_1)
  level thread magic_smoke_launch(var_5.origin, (0, 0, 10), 1, 3);
}

spawn_extra_collision(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2 dontinterpolate();
  var_2.angles = var_1;
  var_3 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 clonebrushmodeltoscriptmodel(var_3);
  var_2 linkTo(self);
  self.open_tut_gate = var_2;
  return var_2;
}

train_handler() {
  level.train_nav_blocks = level thread spawn_train_nav_blockers_all();
  level.convoy4_train_doors = [];
  var_0 = scripts\engine\utility::getStruct("_encstr_B6521ACA38D3828899E8B2B9FC86A291B3A11F7B03C2196F3BAFC2E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 19;
  var_2 = undefined;

  if(isDefined(var_0.target))
    var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  var_3 = undefined;

  if(isDefined(var_2)) {
    var_4 = vectortoangles(var_2.origin - (var_0.origin + (0, 0, 54)));
    var_3 = (0, var_4[1], 0);
  }

  var_5 = (0, 0, 0);
  var_3 = var_3 + (0, 262, 0);
  level notify("_encstr_BEFF0C2FBC1D40103F93E348EB5F");
  var_6 = 2;
  level thread _id_13779();
  var_7 = spawn_train_car(var_0.origin + (0, 0, 54), var_3, undefined, undefined, undefined, 1);
  var_7.script_noteworthy = "_encstr_A34C02BB";
  level thread move_train_along_struct_path(var_7, var_1, var_5);
  var_7 thread train_sfx_1();
  wait(var_6 + 0.2);
  var_8 = spawn_train_car(var_0.origin + (0, 0, 54), var_3, 1);
  var_8.script_noteworthy = "_encstr_A74C0222";
  level thread move_train_along_struct_path(var_8, var_1, var_5);
  wait(var_6);
  var_9 = spawn_train_car(var_0.origin + (0, 0, 54), var_3);
  var_9.script_noteworthy = "_encstr_A14C023B";
  level thread move_train_along_struct_path(var_9, var_1, var_5);
  level.convoy4_train_follow = var_9;
  wait(var_6);
  var_10 = spawn_train_car(var_0.origin + (0, 0, 54), var_3, 1);
  var_10.script_noteworthy = "_encstr_AC4C024A";
  level thread move_train_along_struct_path(var_10, var_1, var_5);
  var_10 thread train_sfx_2();
  wait(var_6);
  var_11 = [];
  var_11[var_11.size] = var_7;
  var_11[var_11.size] = var_8;
  var_11[var_11.size] = var_9;
  var_11[var_11.size] = var_10;
  level thread _id_13CBB();
  level thread _id_13C9B(var_11);
  level.convoy4_train = var_11;
  level notify("_encstr_954A0E47392C5A9BD7B91C85EEB92B46");
}

_id_13C9B(var_0) {
  wait 37.1;
  level notify("_encstr_B4F811ABDBA958F5215F3D3B47093D804174F0");
  level notify("_encstr_AF73130BB038055AC71FCF665CF0FBD79C02E90958");
  var_1 = 0;

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3.train_parts) {
      if(var_5.type != "_encstr_B26906A4E753E778") {
        var_5 hide();
        var_5 notsolid();
      }
    }

    thread show_headicon_to(var_3);
  }
}

show_headicon_to(var_0) {
  wait 1;

  if(var_0.script_noteworthy == "_encstr_A74C0222") {
    var_1 = level._id_1295E gettagorigin("_encstr_A9BD1232293E97D5E9791377D9309F2F6E803A1B");
    var_2 = level._id_1295E gettagangles("_encstr_A9BD1232293E97D5E9791377D9309F2F6E803A1B");
    var_0.origin = var_1;
    var_0.angles = var_2;
    var_0 linkTo(level._id_1295E, "_encstr_A9BD1232293E97D5E9791377D9309F2F6E803A1B", (0, 0, 56), (0, 0, 0));
  } else if(var_0.script_noteworthy == "_encstr_AC4C024A") {
    var_1 = level._id_1295E gettagorigin("_encstr_95E7126C58E49DF6FA0C46AF47B03BAF4CED32E5");
    var_2 = level._id_1295E gettagangles("_encstr_95E7126C58E49DF6FA0C46AF47B03BAF4CED32E5");
    var_0.origin = var_1;
    var_0.angles = var_2;
    var_0 linkTo(level._id_1295E, "_encstr_95E7126C58E49DF6FA0C46AF47B03BAF4CED32E5", (0, 0, 56), (0, 0, 0));
  }
}

_id_13CBB() {
  wait 73;
  _id_130FB();
}

train_sfx_1() {
  wait 30;
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 linkTo(self);
  wait 0.5;
  var_0 playsoundonmovingent("_encstr_8A4819D883F55CAE8527E4CBAF3AE4164B37AF62EBC29CE4D23BCA");
  wait 20;
  var_0 unlink();
  var_0.origin = level._id_1295E gettagorigin("_encstr_B13D156DD53054ABA5F6273FDE05CF8F99AFF2F96FF85D");
  var_0 linkTo(level._id_1295E, "_encstr_B13D156DD53054ABA5F6273FDE05CF8F99AFF2F96FF85D");
  wait 41;
  var_0 delete();
}

train_sfx_2() {
  wait 30;
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 linkTo(self);
  wait 0.5;
  var_0 playsoundonmovingent("_encstr_977319F8E3310B43778AC6BB4FCB6BF364AAA1FA89D645FB6F9645");
  wait 55;
  var_0 delete();
}

spawn_train_car(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
  var_7 = var_1;
  var_8 = var_7 + (0, 180, 90);
  var_9 = 80;
  var_10 = istrue(var_3);
  var_11 = ::spawn_train_car_part;
  var_12 = [];

  if(!istrue(var_5)) {
    var_12[var_12.size] = [[var_11]]("_encstr_88190426B232", "_encstr_A123202713D2FD80BF4DF1ABB0A7A0360A8FE5F7D77A4669CBA4F983DA49A0F87756", var_0 - (0, 0, var_9), var_7, var_6);
    var_13 = var_12[0].origin + (0, 0, var_9);
    var_12[var_12.size] = [[var_11]]("_encstr_911207DD0DAC56D8CD", "_encstr_96C41FC35033F34F08E8B9A27B56633A5BC09A99408BAA5FE3C385AD99FB075223", var_13 - offset_ang((-184, 0, 48), var_7), var_7, var_6);
    var_12[var_12.size] = [[var_11]]("_encstr_911207DD0DAC56D8CD", "_encstr_96C41FC35033F34F08E8B9A27B56633A5BC09A99408BAA5FE3C385AD99FB075223", var_13 - offset_ang((184, 0, 48), var_7), var_7, var_6);

    if(!istrue(var_2))
      var_12[var_12.size] = [[var_11]]("_encstr_AD9B0589ED9197", "_encstr_AFCA162B23DFD7ED6043FACF71D8B20B70F9A2A24BB8A722", var_13 - offset_ang((0, 0, 40), var_7), var_7, var_6, var_10, var_4);

    if(istrue(var_2)) {
      var_12[var_12.size] = [[var_11]]("_encstr_AD9B0589ED9197", "_encstr_8605122B68D169E2CFBF8AC996F31B2FB899FF43", var_13 - offset_ang((0, 0, 40), var_7), var_7, var_6, var_10, var_4);
      var_12[var_12.size] = [[var_11]]("_encstr_B26906A4E753E778", "_encstr_A939183BBB4628AA2A01C3EFAE3F18C967889C360B1F34C6566B", var_13 + offset_ang((16, -56, -40), var_7), var_7 + (0, 180, 0), var_6);
      var_12[var_12.size] = [[var_11]]("_encstr_B26906A4E753E778", "_encstr_A939183BBB4628AA2A01C3EFAE3F18C967889C360B1F34C6566B", var_13 + offset_ang((-128, -56, -40), var_7), var_7 + (0, 180, 0), var_6);
      var_12[var_12.size] = [[var_11]]("_encstr_B26906A4E753E778", "_encstr_A939183BBB4628AA2A01C3EFAE3F18C967889C360B1F34C6566B", var_13 + offset_ang((128, 56, -40), var_7), var_7, var_6);
      var_12[var_12.size] = [[var_11]]("_encstr_B26906A4E753E778", "_encstr_A939183BBB4628AA2A01C3EFAE3F18C967889C360B1F34C6566B", var_13 + offset_ang((-16, 56, -40), var_7), var_7, var_6);
      level.convoy4_train_doors[level.convoy4_train_doors.size] = var_12[var_12.size - 1];
    }
  } else {
    var_12[var_12.size] = [[var_11]]("_encstr_818806E740658A19", "_encstr_88DA247057A8BA07223595308D6A499E0DE33088BF75493BFB1195AE26F295C66323D8103713", var_0 - (0, 0, var_9), var_7, var_6);
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AB7711E3FD1979CB723FAB904737C3581E7F02"), var_12[var_12.size - 1], "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }

  var_6.train_parts = var_12;
  return var_6;
}

offset_ang(var_0, var_1) {
  var_2 = rotatevector(var_0, var_1);
  return var_2;
}

spawn_train_car_part(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_7.angles = var_3;
  var_7 setModel(var_1);
  var_7 solid();
  var_7 show();
  var_7.type = var_0;
  var_7 linkTo(var_4);

  if(var_0 == "_encstr_B26906A4E753E778") {
    var_8 = var_7.origin;
    var_9 = (-40, 0, 0);
    var_10 = rotatevector(var_9, var_7.angles);
    var_8 = var_8 + var_10;
    var_11 = var_7.angles + (90, 90, 0);
    var_7 thread spawn_extra_collision(var_8, var_11);
  }

  return var_7;
}

spawn_train_nav_blockers_all() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_92BE14C02A450D080FC458C57A9730F5E1623018425C", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = thread spawn_train_nav_blocker(var_3);
    var_1[var_1.size] = var_4;
    waitframe();
  }

  return var_1;
}

spawn_train_nav_blocker(var_0) {
  var_1 = var_0.origin;
  var_1 = var_1 - 24;
  var_2 = createnavobstaclebybounds(var_1, (196, 196, 64), (0, 0, 0));
  return var_2;
}

waitfor_train_explode() {
  wait 3;

  if(!isDefined(level._id_1295E)) {
    return;
  }
  var_0 = level._id_1295E gettagorigin("_encstr_B13D156DD53054ABA5F6273FDE05CF8F99AFF2F96FF85D");
  var_1 = level._id_1295E gettagorigin("_encstr_8B0B146C854ECE7BEBC099FA47163BFAB727A59D4BCD");
  var_2 = level._id_1295E gettagorigin("_encstr_AC451511FD32E9B16A6F8A928784C9173965962B57EAB5");
  var_3 = level._id_1295E gettagorigin("_encstr_A76014D816E4CEF6FA8191F5470BECBEED4EB4CE5ADC");
  level thread explode_results(var_0);
  level thread explode_results(var_1);
  level thread explode_results(var_2);
  level thread explode_results(var_3);
  level notify("_encstr_95B313DB26D4AF3A270B2D37EB56E1C1C67B232B91");
  waitframe();

  if(isDefined(level.convoy4_train_c4objs)) {
    foreach(var_5 in level.convoy4_train_c4objs) {
      if(isent(var_5))
        var_5 delete();
    }
  }

  waitframe();

  if(isDefined(level.train_nav_blocks)) {
    foreach(var_8 in level.train_nav_blocks)
    destroynavobstacle(var_8);
  }
}

explode_results(var_0) {
  wait(randomfloat(0.2));
  playFX(level._effect["_encstr_855B17D999E1BEEE1C7D474EB0A5DCAF560F1CD8DBDCA5F6CD"], var_0 + (0, 0, 12));

  if(soundexists("_encstr_B2111B67281F42630B98439308FD26B25858C78BC893A83851972F91DA"))
    playsoundatpos(var_0, "_encstr_B2111B67281F42630B98439308FD26B25858C78BC893A83851972F91DA");

  var_1 = 4000000;
  var_2 = scripts\cp\utility::give_all_players_nearby(var_0, var_1);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!istrue(var_2[var_3].used_fulton_interact))
        var_2[var_3] dodamage(200, var_0, var_2[var_3], var_2[var_3], "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    }
  }

  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var_0, 0.09, 1.5, 3000);
  wait 0.25;
}

debug_loop_explosion() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;
  var_0 = scripts\engine\utility::getStructArray("_encstr_B4C5175BF3577BB811A54951C4450833C78A33A67ABF26A837", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    if(getDvar("_encstr_843E19070FFE31B11099323AB202D73B56A3F7FBFB230B949841EF", "_encstr_B40101") == "_encstr_B40101") {
      wait 0.5;
      continue;
    }

    setDvar("_encstr_843E19070FFE31B11099323AB202D73B56A3F7FBFB230B949841EF", "_encstr_B40101");

    foreach(var_2 in var_0) {
      var_3 = var_2.origin;
      playFX(level._effect["_encstr_855B17D999E1BEEE1C7D474EB0A5DCAF560F1CD8DBDCA5F6CD"], var_3 + (0, 0, 12));

      if(soundexists("_encstr_B2111B67281F42630B98439308FD26B25858C78BC893A83851972F91DA"))
        playsoundatpos(var_3, "_encstr_B2111B67281F42630B98439308FD26B25858C78BC893A83851972F91DA");

      scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var_3, 0.09, 1.5, 3000);
      wait 0.25;
    }
  }
}

complete_game_win() {
  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0].ability_invulnerable = 1;

  foreach(var_2 in level.players) {
    var_2 scripts\cp_mp\xmike109::scriptable_callback("_encstr_BD50097A1143DAD738900B");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_99580E92FB030F626017BEBD5F802D93");
        continue;
      }

      var_2 thread scripts\cp_mp\xmike109::scriptable_callback("_encstr_8A6112263996ADB93A7BE695D7D6F619D7B32B47");
    }
  }

  scripts\cp\cp_objectives::screenent_c("_encstr_8666105BC2D4F69CEBF64C53ACB18EA5B395");
  level notify("_encstr_810714CA2A9349FB3B566BB29BEF91A79BEAA553E4ED");
  wait 4;
  level thread[[level.endgame]]("_encstr_9A8507BA4040188D08", level.end_game_string_index["_encstr_91190447C232"]);
}

mp_shipment_patch() {
  wait 1.8;
  level thread _id_130A8();
}

move_train_along_struct_path(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BA1C16936F3D4B306B6F3F5BD2116AD02943DBFF338172C7");
  level endon("_encstr_AF73130BB038055AC71FCF665CF0FBD79C02E90958");
  var_1 = var_1 * 17.6;
  var_3 = scripts\engine\utility::getStruct("_encstr_B6521ACA38D3828899E8B2B9FC86A291B3A11F7B03C2196F3BAFC2E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 thread damage_infront_of_train(var_0);

  for(var_4 = 0; isDefined(var_3.target); var_3 = var_5) {
    var_4++;
    var_5 = scripts\engine\utility::getStruct(var_3.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_6 = distance(var_3.origin, var_5.origin);
    var_7 = var_6 / var_1;

    if(var_7 <= 0.1)
      var_7 = 0.15;

    var_8 = 0;

    if(isDefined(var_5.speed) && isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "_encstr_A34C02BB") {
      var_9 = get_train_special_speed(var_5.speed);
      var_7 = var_9.timetomove;

      for(var_4 = 0; var_4 < level.convoy4_train.size; var_4++) {
        if(level.convoy4_train[var_4].script_noteworthy != "_encstr_A34C02BB")
          level.convoy4_train[var_4].speed = var_7;
      }
    }

    if(isDefined(var_0.speed)) {
      if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy != "_encstr_A34C02BB") {
        switch (var_0.script_noteworthy) {
          case "_encstr_A74C0222":
            var_7 = var_0.speed + 0.15;
            break;
          case "_encstr_A14C023B":
            var_7 = var_0.speed - 0.125;
            break;
          case "_encstr_AC4C024A":
            var_7 = var_0.speed - 0.225;
            break;
          case "_encstr_B84C027E":
            var_7 = var_0.speed - 0.325;
            break;
        }
      }
    }

    var_10 = var_7;

    if(var_10 > 2) {
      var_10 = var_7 * 0.25;

      if(var_10 < 0.05)
        var_10 = 0.05;
    }

    var_11 = abs(var_5.origin - var_3.origin[2]);

    if(var_11 > 20) {
      var_10 = var_10 * 0.35;

      if(var_10 < 0.05)
        var_10 = 0.05;
    }

    var_12 = var_5.origin + (0, 0, 54);
    var_13 = vectortoangles(var_5.origin - var_3.origin);
    var_13 = var_13 + var_2;
    var_0 moveTo(var_12, var_7);
    var_0 rotateTo(var_13, var_10);
    wait(var_7);
  }

  _id_130FB();
}

_id_130FB() {
  level.obj_train_stopped = 1;
  level notify("_encstr_BA1C16936F3D4B306B6F3F5BD2116AD02943DBFF338172C7");
}

get_train_special_speed(var_0) {
  var_1 = spawnStruct();
  var_2 = "_encstr_B40101" + var_0;

  switch (var_2) {
    case "_encstr_A34C02BB":
      var_1.timetomove = 0.5;
      var_1.decc = 0.2;
      break;
    case "_encstr_A74C0222":
      var_1.timetomove = 0.55;
      var_1.decc = 0.2;
      break;
    case "_encstr_A14C023B":
      var_1.timetomove = 0.6;
      var_1.decc = 0.2;
      break;
    case "_encstr_AC4C024A":
      var_1.timetomove = 0.65;
      var_1.decc = 0.2;
      break;
    case "_encstr_B84C027E":
      var_1.timetomove = 0.7;
      var_1.decc = 0.2;
      break;
    case "_encstr_8F4C026A":
      var_1.timetomove = 0.75;
      var_1.decc = 0.2;
      break;
    case "_encstr_914C02DC":
      var_1.timetomove = 0.8;
      var_1.decc = 0.2;
      break;
    case "_encstr_864C02F9":
      var_1.timetomove = 0.85;
      var_1.decc = 0.2;
      break;
    case "_encstr_8B4C0227":
      var_1.timetomove = 0.9;
      var_1.decc = 0.2;
      break;
    case "_encstr_AF0703133A":
      var_1.timetomove = 0.95;
      var_1.decc = 0.2;
      break;
  }

  return var_1;
}

damage_infront_of_train(var_0, var_1, var_2) {
  level endon("_encstr_BA1C16936F3D4B306B6F3F5BD2116AD02943DBFF338172C7");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = 170;

  if(isDefined(var_2))
    var_3 = var_2;

  var_4 = var_3 * var_3;
  var_5 = var_0.origin;

  for(;;) {
    var_5 = var_0.origin;

    if(isDefined(var_1))
      var_5 = var_0 gettagorigin(var_1);

    var_6 = [];

    foreach(var_8 in level.players) {
      if(isDefined(var_8.placedsentries)) {
        foreach(var_10 in var_8.placedsentries) {
          foreach(var_12 in var_10)
          var_6[var_6.size] = var_12;
        }
      }
    }

    var_16 = [];
    var_16 = scripts\engine\utility::array_combine(level.players, level.turrets, var_6);

    foreach(var_18 in var_16) {
      if(isPlayer(var_18) && !var_18 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!isalive(var_18)) {
        continue;
      }
      if(distancesquared(var_18.origin, var_5) > var_4) {
        continue;
      }
      if(isDefined(var_18.turrettype)) {
        var_18 notify("_encstr_932D0C087BD23CA6CBBB553A4DE8", 1);
        continue;
      }

      var_18 dodamage(200, var_5);
    }

    wait 0.25;
  }
}

wait_for_start_extraction(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = (0, 0, 90);
  var_3 = var_0 - (0, 0, 64);
  level thread ondefuse(var_3);
  objective_sethot(var_1, 1);
  var_4 = 180;

  if(getdvarint("_encstr_A6D80F2B71265FBF80E94C2F95F004DFC5", 0) > 0)
    var_4 = getdvarint("_encstr_A6D80F2B71265FBF80E94C2F95F004DFC5", 0);

  level thread all_players_fulton();
  level thread wait_for_all_extracts();
  level thread init_bombs();
  var_5 = (-97.881, -441.68, 1024);
  var_6 = var_4 - 32;
  level thread scripts\cp\infilexfil\cp_fulton::fulton_group_exfil_at_pos(var_0 - (0, 0, 64), (0, 237, 0), var_6, var_5);
  level thread wait_extraction_timer(var_4 - 2, var_1);
  level thread scripts\cp\utility::objective_update("_encstr_874213AE920318C8F28AF16AF3245278B2A1FF48CE", var_4, var_4 - 1, var_4 * 0.08333, 1);
  level thread scripts\cp\infilexfil\cp_fulton::_id_123BE(var_4);
  level waittill("_encstr_B8FD18688F7DC8C77AAFDD48C2120B92D56B69B0A70CC3E7C2D2");
  level notify("_encstr_8A9B11CFC35E705153DBE789A57C21656D65A2");
  level.obj_players_fultoning = 1;
  wait 0.5;
}

wait_for_all_extracts() {
  level endon("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2.team == "_encstr_9A8507BA4040188D08")
      var_0++;
  }

  while(level.obj_used_extract_num < var_0)
    wait 0.1;
}

wait_extraction_timer(var_0, var_1) {
  level endon("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");
  level thread player_move(var_0, var_1);

  for(var_2 = 0; var_2 < level.players.size; var_2++)
    level.players[var_2] playLoopSound("_encstr_8E4A0AAECF17E917B322A098");

  wait(var_0);

  for(var_2 = 0; var_2 < level.players.size; var_2++)
    level.players[var_2] stoploopsound("_encstr_8E4A0AAECF17E917B322A098");
}

player_move(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");
  var_2 = var_0 - 15;
  wait(var_2);
  objective_setownerteam(var_1, "_encstr_A7A408B9CA5D1D4E2C63");

  for(;;) {
    objective_sethot(var_1, 1);
    wait 0.65;
    objective_sethot(var_1, 0);
    wait 0.65;
  }
}

ondefuse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");

  for(var_1 = 0; var_1 < 15; var_1++) {
    magicgrenademanual("_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683", getgroundposition(var_0, 16), (0, 0, 0), 0.01);
    wait 10;
  }
}

init_bombs() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::getStruct("_encstr_889217F626D42BD8D1A5D9B2D76C7BDCB3B7F2A1BE60A9EB58", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level waittill("_encstr_9A1C14838DB05ECA27AF5DB9CA91D72BC3E84EB0C68E", var_1);
  var_2 = 900;
  var_3 = createnavbadplacebybounds(var_0.origin, (var_2, var_2, var_2), (0, 0, 0));
  level waittill("_encstr_9A1C14838DB05ECA27AF5DB9CA91D72BC3E84EB0C68E", var_1);
  wait 1;
  destroynavobstacle(var_3);
  var_2 = 3500;
  var_3 = createnavbadplacebybounds(var_0.origin, (var_2, var_2, var_2), (0, 0, 0));
}

all_players_fulton() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_B8F61BDFA7FA2568467399D6DF25385D823B2F6B5383EEE0630B2DA8C5");
  level._id_139B5 = 1;
  wait 0.1;
  level thread waitfor_train_explode();
  level thread scripts\cp\utility::objective_update("_encstr_874213AE920318C8F28AF16AF3245278B2A1FF48CE");
  level notify("_encstr_B8FD18688F7DC8C77AAFDD48C2120B92D56B69B0A70CC3E7C2D2");
}

are_enemies_nearby(var_0, var_1) {
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || var_4 == self) {
      continue;
    }
    var_5 = distance2dsquared(self.origin, var_4.origin);

    if(var_5 > var_1) {
      continue;
    }
    if(var_5 <= var_0)
      return 1;

    var_6 = sighttracepassed(var_4 getEye(), self getEye(), 0, var_4);

    if(var_6)
      return 1;
  }

  return 0;
}

disable_jugg_objective_position_on_death(var_0, var_1, var_2, var_3) {
  var_4 = var_0 thread create_usable_key_model(var_0, var_1, var_2, var_3);
}

create_usable_key_model(var_0, var_1, var_2, var_3) {
  self waittill("_encstr_AD75063D571AE108");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 5));
  var_4 setModel("_encstr_974B19B28974EB1620913F1FAB815E07A920BB4A30D897C150993C");
  var_4.angles = (270, 0, 0);
  waitframe();
  var_5 = &"_encstr_88F7227E3937698F2D159659467F1F19BD3DDF7B1761F8C7CDE8D8EBBC5F3794CF33F081";
  objective_unsetlocation(var_1, var_2);
  objective_setlocation(var_1, var_2, self.origin + (0, 0, 15));
  objective_sethot(var_1, 1);
  var_4 setHintString(var_5);
  var_4 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_4 sethintdisplayrange(500);
  var_4 sethintdisplayfov(65);
  var_4 setuserange(72);
  var_4 setusefov(65);
  var_4 sethintonobstruction("_encstr_BD1805CB69C063");
  var_4 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_4 makeusable();
  var_4 thread key_use_think(var_0, var_1, var_2, var_3);
  return var_4;
}

key_use_think(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(isDefined(var_4)) {
      if(!var_4 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      collect_jugg_key(var_0, var_1, var_2, var_3, var_4);
      scripts\cp\cp_objectives::freeworldidbyobjid(var_1);
      remove_jugg_key();
    }
  }
}

collect_jugg_key(var_0, var_1, var_2, var_3, var_4) {
  level thread play_keys_vo(var_4);
  level.convoy4_terminal_keys = level.convoy4_terminal_keys + 1;
  level notify("_encstr_8CFB0DF02BB5919ECFEFB535F43746" + var_3);
  objective_unsetlocation(var_1, var_2);
  var_4 thread scripts\cp\utility::playerplaypickupanim();
  level thread _id_123D7();
  objective_setdescription(var_1, &"_encstr_BED025966FF759057DC92B0FE296C7B0350D6EDB7B5D504BC859674B394C999F47B26756DE27AF");
  scripts\cp\utility::objective_update("_encstr_AAA90EF05842DB88136A97CFB3504B8F" + level.convoy4_terminal_keys);
}

_id_123D7() {
  var_0 = undefined;

  switch (level.convoy4_terminal_keys) {
    case 1:
      var_0 = &"_encstr_8F02218614D78A55A092949591F5A79025A81A51252B8AA9BC2D2A2B9AFA24AA22F54C";
      scripts\cp\utility::_id_123FE("_encstr_BD8C19856507118BE30937B7A0F947EAF37E81BCC57BFADF6BA863");
      break;
    case 2:
      var_0 = &"_encstr_A302212FEB590719F92A8FE65ABF91D6A007A7996731C5E1BF7415FE3A5761951807FD";
      break;
    case 3:
      var_0 = &"_encstr_930221AF214EF9F9339E2A90D66710B2B421177B71872541D73AE7984EBF986DDD895E";
      scripts\cp\utility::_id_123FE("_encstr_8D1923ADD5CDD7B1387DE66BEAD9EC362B4EAFA39593B5A5CD16B1D7B0C68E2DCE58D12B46");
      break;
  }

  if(isDefined(var_0)) {
    foreach(var_2 in level.players)
    var_2 thread scripts\cp\cp_hud_message::tutorialprint(var_0, 4);
  }
}

remove_jugg_key() {
  if(isDefined(self.jugg_obj_pos)) {
    if(isent(self.jugg_obj_pos))
      self.jugg_obj_pos delete();

    self.jugg_obj_pos = undefined;
  }

  playFX(level._effect["_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"], self.origin);
  self delete();
}

spawn_map_ac130() {
  var_0 = level.players[0];
  level.convoy4_ac130 = var_0 scripts\cp\inventory\cp_ac130::spawn_ambient_ac130(var_0);
}

activate_apache_on_player(var_0) {
  var_1 = scripts\engine\utility::getStruct("_encstr_ACA50F7859757E976BEF4B1915C7490BD5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level notify("_encstr_AB7E16A328174FF72007B5BB1BF8313745213B0B12E0CFAA");
  var_0 thread scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
}

register_spawn_functions() {
  if(scripts\engine\utility::flag_exist("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B"))
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\engine\utility::flag_exist("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD"))
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");

  if(scripts\engine\utility::flag_exist("_encstr_A65211EB562BA098E71253B95ABB589043B525"))
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");

  if(!scripts\engine\utility::flag_exist("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D"))
    scripts\engine\utility::flag_init("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D");

  scripts\engine\utility::flag_wait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D");
  wait 0.5;
  scripts\cp\coop_stealth::coop_stealth_init();
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_833219D976CB2B2B8FA7484847CF606BB3514FFE8122EF53658FD0", 0, 1, 1, 0.1, 0, "_encstr_833219D976CB2B2B8FA7484847CF606BB3514FFE8122EF53658FD0", scripts\cp\cp_modular_spawning::_id_13BAC, undefined, undefined);
  [[var_0]]("_encstr_AB3219693B930708AF11A3DB869F804D2B67C95F373AD810F57989", 0, 1, 1, 0.1, 0, "_encstr_AB3219693B930708AF11A3DB869F804D2B67C95F373AD810F57989", scripts\cp\cp_modular_spawning::_id_13BAC, undefined, undefined);
  [[var_0]]("_encstr_99321981D37BEFD007B91B73DEE7E81593BF31878F62A0B82D8101", 0, 1, 1, 0.1, 0, "_encstr_99321981D37BEFD007B91B73DEE7E81593BF31878F62A0B82D8101", scripts\cp\cp_modular_spawning::_id_13BAC, undefined, undefined);
  [[var_0]]("_encstr_A5321902D025E66358AFDBD027633B2F8DA14B0FD1D5DD3B7068D4", 0, 1, 1, 0.1, 0, "_encstr_A5321902D025E66358AFDBD027633B2F8DA14B0FD1D5DD3B7068D4", scripts\cp\cp_modular_spawning::_id_13BAC, undefined, undefined);
  [[var_0]]("_encstr_8502168BAB0B9CE4CB7DB43747C97B89EB1BD07B1CC1AC93", 5, 5, 5, 0.1, 0, "_encstr_8502168BAB0B9CE4CB7DB43747C97B89EB1BD07B1CC1AC93", undefined, undefined, undefined);
  [[var_0]]("_encstr_96DA168BAE2CE4E4CBD7A5371D277B23D7360DDBC183AC39", 4, 4, 4, 0.1, 0, "_encstr_96DA168BAE2CE4E4CBD7A5371D277B23D7360DDBC183AC39", undefined, undefined, undefined);
  [[var_0]]("_encstr_B62810F6989AD716D727DBED33FA3557CECE", 1, 1, 1, 0.1, 0, "_encstr_B62810F6989AD716D727DBED33FA3557CECE", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B62810F6989AD716D727DBED33FA3557CECE", ::_id_12926);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_B62810F6989AD716D727DBED33FA3557CECE", undefined, 20000, 30000);
  [[var_0]]("_encstr_A23E12C6AD929D8011B2A1C0F72FF997BA534C5C", 1, 1, 1, 0.1, 0, "_encstr_A23E12C6AD929D8011B2A1C0F72FF997BA534C5C", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A23E12C6AD929D8011B2A1C0F72FF997BA534C5C", ::_id_13890);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A23E12C6AD929D8011B2A1C0F72FF997BA534C5C", undefined, 20000, 30000);
  [[var_0]]("_encstr_8D8012A9327B84C0E8841745F755B0D8A35BA153", 4, 6, 10, 0.1, 0, "_encstr_8D8012A9327B84C0E8841745F755B0D8A35BA153", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8D8012A9327B84C0E8841745F755B0D8A35BA153", ::_id_12D87);
  [[var_0]]("_encstr_8E310EC090DA7CBF9152AF3F6AB3D79B", 7, 11, 40, 0.1, 0, "_encstr_8E310EC090DA7CBF9152AF3F6AB3D79B", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_B2310E932F806B474383F9173B164F72", 7, 9, 40, 0.1, 0, "_encstr_B2310E932F806B474383F9173B164F72", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_AF310ED31860737D533A618F0ABFB9A6", 7, 9, 40, 0.1, 0, "_encstr_AF310ED31860737D533A618F0ABFB9A6", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_8E310EC090DA7CBF9152AF3F6AB3D79B", ::setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B2310E932F806B474383F9173B164F72", ::setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AF310ED31860737D533A618F0ABFB9A6", ::setup_manual_goalpos);
  [[var_0]]("_encstr_92170CA1BBB1F8C31B8FC22A7214", 12, 12, 12, 0.25, 0, "_encstr_92170CA1BBB1F8C31B8FC22A7214", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_92170CA1BBB1F8C31B8FC22A7214", ::ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_92170CA1BBB1F8C31B8FC22A7214", undefined, 20000, 30000);
  [[var_0]]("_encstr_91AA0D27C38A7DDBE9F71030EF68D3", 10, 10, 10, 0.25, 0, "_encstr_91AA0D27C38A7DDBE9F71030EF68D3", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_91AA0D27C38A7DDBE9F71030EF68D3", ::ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_91AA0D27C38A7DDBE9F71030EF68D3", undefined, 20000, 30000);
  [[var_0]]("_encstr_97871483FB2F9E30C0C75D5BE76CC8F0D7727BC823CF", 12, 12, 12, 0.1, 0, "_encstr_97871483FB2F9E30C0C75D5BE76CC8F0D7727BC823CF", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_97871483FB2F9E30C0C75D5BE76CC8F0D7727BC823CF", ::_id_12956);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_97871483FB2F9E30C0C75D5BE76CC8F0D7727BC823CF", undefined, 20000, 30000);
  [[var_0]]("_encstr_952312DE1FCBBBA720C771087AFC511103AB486F", 7, 7, 7, 0.1, 0, "_encstr_952312DE1FCBBBA720C771087AFC511103AB486F", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_952312DE1FCBBBA720C771087AFC511103AB486F", ::ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_952312DE1FCBBBA720C771087AFC511103AB486F", ::ks_pointkingsgetnobonus);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_952312DE1FCBBBA720C771087AFC511103AB486F", undefined, 20000, 30000);
  [[var_0]]("_encstr_88AF0C885F92531BF3197405E89B", 4, 4, 4, 0.1, 0, "_encstr_88AF0C885F92531BF3197405E89B", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_88AF0C885F92531BF3197405E89B", ::_id_1295B);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_88AF0C885F92531BF3197405E89B", undefined, 20000, 30000);
  [[var_0]]("_encstr_AB78125B1F09FF85D330F9828017FB5F210DEFC1", 1, 1, 1, 0.1, 0, "_encstr_AB78125B1F09FF85D330F9828017FB5F210DEFC1", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB78125B1F09FF85D330F9828017FB5F210DEFC1", ::make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB78125B1F09FF85D330F9828017FB5F210DEFC1", scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_AB78125B1F09FF85D330F9828017FB5F210DEFC1", ::setup_hostage_fulton_anims);
  [[var_0]]("_encstr_997812B9070BDD9B9523EB34F6E68EC29DB27DC4", 1, 1, 1, 0.1, 0, "_encstr_997812B9070BDD9B9523EB34F6E68EC29DB27DC4", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_997812B9070BDD9B9523EB34F6E68EC29DB27DC4", ::make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_997812B9070BDD9B9523EB34F6E68EC29DB27DC4", scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_997812B9070BDD9B9523EB34F6E68EC29DB27DC4", ::setup_hostage_fulton_anims);
  [[var_0]]("_encstr_9B781232D7338396512077B3604B442A87E5B1AE", 1, 1, 1, 0.1, 0, "_encstr_9B781232D7338396512077B3604B442A87E5B1AE", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9B781232D7338396512077B3604B442A87E5B1AE", ::make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9B781232D7338396512077B3604B442A87E5B1AE", scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_9B781232D7338396512077B3604B442A87E5B1AE", ::setup_hostage_fulton_anims);
  [[var_0]]("_encstr_A9D013B9072CDDDCCA19AF43F6E68E163BCAB9EB2C", 5, 5, 5, 0.1, 0, "_encstr_A9D013B9072CDDDCCA19AF43F6E68E163BCAB9EB2C", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A9D013B9072CDDDCCA19AF43F6E68E163BCAB9EB2C", scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A9D013B9072CDDDCCA19AF43F6E68E163BCAB9EB2C", scripts\cp\cp_hostage::setup_hostage_anims);
  [[var_0]]("_encstr_A2D013B938B0DD9B5946F51A7B371D5876B2E6FA98", 5, 5, 5, 0.1, 0, "_encstr_A2D013B938B0DD9B5946F51A7B371D5876B2E6FA98", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A2D013B938B0DD9B5946F51A7B371D5876B2E6FA98", scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A2D013B938B0DD9B5946F51A7B371D5876B2E6FA98", scripts\cp\cp_hostage::setup_hostage_anims);
  [[var_0]]("_encstr_B1D013CD1CB0BBB99546FA86DE378E0BB3596EBE1B", 5, 5, 5, 0.1, 0, "_encstr_B1D013CD1CB0BBB99546FA86DE378E0BB3596EBE1B", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B1D013CD1CB0BBB99546FA86DE378E0BB3596EBE1B", scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B1D013CD1CB0BBB99546FA86DE378E0BB3596EBE1B", scripts\cp\cp_hostage::setup_hostage_anims);
  [[var_0]]("_encstr_ACC512C198BD2E203B9941020BAE960EC198B56F", 8, 8, 10, 2, 0, "_encstr_B6140EEE85BAB5B8299AB9BAFA49F673", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_ACC512C198BD2E203B9941020BAE960EC198B56F", ::_id_11F52);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_ACC512C198BD2E203B9941020BAE960EC198B56F", ::ks_pointsperkingslain);
  [[var_0]]("_encstr_B6140EEE85BAB5B8299AB9BAFA49F673", 6, 12, 200, 2, 0, "_encstr_B6140EEE85BAB5B8299AB9BAFA49F673", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_B6140EEE85BAB5B8299AB9BAFA49F673", ::_id_11F52);
  [[var_0]]("_encstr_B84312FE95AAA5A839EAC9AAEA7AE66301FAEE75", 4, 6, 12, 2.25, 0, "_encstr_A2140EC218C02325C8614F284538E186", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_BD561272389DA3871A3577100E417F7A5758EBEA", 4, 8, 10, 1, 0, "_encstr_B1140ED8DEB967BD2F43FA0C1913FA8C", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_A2140EC218C02325C8614F284538E186", 4, [scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "_encstr_A7B20BF7F3CA85C01753F9337B", 28, 20], 150, [scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "_encstr_A2140EC218C02325C8614F284538E186", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_B1140ED8DEB967BD2F43FA0C1913FA8C", 4, [scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "_encstr_A7B20BF7F3CA85C01753F9337B", 28, 8], 250, [scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "_encstr_B1140ED8DEB967BD2F43FA0C1913FA8C", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_81DA128DED3767BD9743BE06646CFA62F50EE4AC", 2, 12, 36, 0.1, 0, "_encstr_95140E5EFD4DD637E7EBF7CACAC78982", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_95140E5EFD4DD637E7EBF7CACAC78982", 2, 28, 250, 0.1, 0, "_encstr_95140E5EFD4DD637E7EBF7CACAC78982", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_85D013B740F036B2BB5581527EB789EA78C83B5740", 1, 2, 25, 0.1, 0, "_encstr_85D013B740F036B2BB5581527EB789EA78C83B5740", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_842A18F2D0F06380936CF1AFFAB047E20A3B2B2AB397C125D128", 1, 3, 25, 5, 0, "_encstr_842A18F2D0F06380936CF1AFFAB047E20A3B2B2AB397C125D128", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_991F0EC6DBB99DDB5ED0EBC06685AF62", 1, 24, 250, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_991F0EC6DBB99DDB5ED0EBC06685AF62", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_84F41051A0BA54DA32E2B0A7AB63BEE37E0F", 5, 5, 5, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_AB1F0ECF9F085B57F8ABF112730B5FD7", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_991F0EC6DBB99DDB5ED0EBC06685AF62", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_84F41051A0BA54DA32E2B0A7AB63BEE37E0F", undefined, 20000, 30000);
  [[var_0]]("_encstr_87490E5A10B5FBDF724D0F7825195752", 0, 7, 50, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_87490E5A10B5FBDF724D0F7825195752", ::watchforjuggstop, undefined, undefined);
  [[var_0]]("_encstr_81490EC1870804301B7B499012B0B17E", 0, 7, 50, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_81490EC1870804301B7B499012B0B17E", ::watchforjuggstop, undefined, undefined);
  [[var_0]]("_encstr_88490EB1DBDCECBD2FD0D760A1167D66", 0, 7, 50, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_88490EB1DBDCECBD2FD0D760A1167D66", ::watchforjuggstop, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_87490E5A10B5FBDF724D0F7825195752", ::setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_81490EC1870804301B7B499012B0B17E", ::setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_88490EB1DBDCECBD2FD0D760A1167D66", ::setup_manual_goalpos);
  [[var_0]]("_encstr_A56B10CFF8701B1FEB9536902B0F58966F61", 1, 1, 1, 0.05, 0, "_encstr_A56B10CFF8701B1FEB9536902B0F58966F61", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_866B10D8DEDC67DB2F43EB53AEB3ECCDFAC8", 1, 1, 1, 0.05, 0, "_encstr_866B10D8DEDC67DB2F43EB53AEB3ECCDFAC8", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_8B6B10263DB86310588FB042CB0FAF17B0A3", 1, 1, 1, 0.05, 0, "_encstr_8B6B10263DB86310588FB042CB0FAF17B0A3", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A56B10CFF8701B1FEB9536902B0F58966F61", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_866B10D8DEDC67DB2F43EB53AEB3ECCDFAC8", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_8B6B10263DB86310588FB042CB0FAF17B0A3", undefined, 20000, 30000);
  [[var_0]]("_encstr_A795178DDE73ECF62F68F553BA3BB3E67D987D98166CB5EA07", 1, 1, 1, 0.05, 0, "_encstr_A795178DDE73ECF62F68F553BA3BB3E67D987D98166CB5EA07", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_91EC176C7BE6B37B2FD0EB53EA76B337AF19D7892C1BB5EAC1", 1, 1, 1, 0.05, 0, "_encstr_91EC176C7BE6B37B2FD0EB53EA76B337AF19D7892C1BB5EAC1", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_A57817BFC79A44F8F1837ED0FBD7807E212E4FC5971282E010", 1, 1, 1, 0.05, 0, "_encstr_A57817BFC79A44F8F1837ED0FBD7807E212E4FC5971282E010", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A795178DDE73ECF62F68F553BA3BB3E67D987D98166CB5EA07", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_91EC176C7BE6B37B2FD0EB53EA76B337AF19D7892C1BB5EAC1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_A57817BFC79A44F8F1837ED0FBD7807E212E4FC5971282E010", undefined, 20000, 30000);
  [[var_0]]("_encstr_999110BED5EAE5E8792A09785FB7012741EA", 8, [scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "_encstr_82800DE12BB7BD80299D2D21894DF0", 24, 8], 250, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_999110BED5EAE5E8792A09785FB7012741EA", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_A19110DBB7786B755B0269B3F05FEFA7B656", 14, [scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "_encstr_82800DE12BB7BD80299D2D21894DF0", 24, 16], 250, [scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "_encstr_A19110DBB7786B755B0269B3F05FEFA7B656", ::watchforstopwaves, undefined, undefined);
  [[var_0]]("_encstr_91F3116BB0C8DB250B5219B2A8199C034130A1", 19, 19, 250, 0.5, 0, "_encstr_91F3116BB0C8DB250B5219B2A8199C034130A1", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_999110BED5EAE5E8792A09785FB7012741EA", undefined, 20000, 30000);
  [[var_0]]("_encstr_AC28174DED4FA8BB1F42509E5BA3E7F0A555C5AF65F0E87303", 2, 2, 2, 0.1, 0, "_encstr_AC28174DED4FA8BB1F42509E5BA3E7F0A555C5AF65F0E87303", scripts\cp\cp_modular_spawning::disable_kill_off, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_AC28174DED4FA8BB1F42509E5BA3E7F0A555C5AF65F0E87303", undefined, 20000, 30000);
  [[var_0]]("_encstr_ACF415877086359F33F907C313CF897380654C475A1D56", 1, 1, 1, 0.05, 0, "_encstr_ACF415877086359F33F907C313CF897380654C475A1D56", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_ACF415877086359F33F907C313CF897380654C475A1D56", undefined, 20000, 30000);
  [[var_0]]("_encstr_A2DD138ECA8D34BD7D071A5EB9EBC5EA0BE439BC4C", 3, 6, 6, 0.1, 0, "_encstr_A2DD138ECA8D34BD7D071A5EB9EBC5EA0BE439BC4C", undefined, undefined, undefined);
  [[var_0]]("_encstr_95DD138B5F6B48B8E1DBF1DBFFC9FFF801F233A212", 3, 6, 6, 0.1, 0, "_encstr_95DD138B5F6B48B8E1DBF1DBFFC9FFF801F233A212", undefined, undefined, undefined);
  [[var_0]]("_encstr_B4DD1313BDD79277F6A08BD7A0AE210BAB4E1AC83E", 3, 6, 6, 0.1, 0, "_encstr_B4DD1313BDD79277F6A08BD7A0AE210BAB4E1AC83E", undefined, undefined, undefined);
  [[var_0]]("_encstr_9ADD1347CA6C34DEAF07862F9BEB17BAB0934E5E43", 3, 6, 6, 0.1, 0, "_encstr_9ADD1347CA6C34DEAF07862F9BEB17BAB0934E5E43", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", ::_id_11E4F);
  [[var_0]]("_encstr_86E4112FD86BCD8B0F04E3987667A295B1A087", 1, 1, 50, 0.1, 0, "_encstr_86E4112FD86BCD8B0F04E3987667A295B1A087", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("_encstr_86E4112FD86BCD8B0F04E3987667A295B1A087", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_86E4112FD86BCD8B0F04E3987667A295B1A087", ::spawn_in_cover);
}

_id_11E4F(var_0) {
  if(isDefined(self.unittype) && self.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B") {
    self.never_kill_off = 1;
    self.dont_kill_off = 1;
  }
}

_id_1295B(var_0) {
  _id_1295C(var_0);
}

_id_1295C(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\common\utility::demeanor_override("_encstr_92100762872552A643");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    self.goalheight = 512;
    var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = getgroundposition(var_1.origin, 16) + (0, 0, 8);
    self.script_origin_other = var_2;
    scripts\cp\cp_modular_spawning::set_goal_pos(var_2);

    if(isDefined(var_1.radius))
      scripts\cp\cp_modular_spawning::set_goal_radius(var_1.radius);

    thread blueprintextract_beforepickupspawned("_encstr_95980DE61DF6E0D7B6ED278EC2C9CD");
    level waittill("_encstr_95980DE61DF6E0D7B6ED278EC2C9CD");
    self.dont_kill_off = 0;
    self.never_kill_off = 0;
    self.script_origin_other = undefined;
    scripts\cp\cp_modular_spawning::set_goal_radius(1000);
  }
}

_id_12956(var_0) {
  thread ks_pointsperkingslain(var_0);
  thread blueprintextract_beforepickupspawned("_encstr_8CB41517AE169C4ECB7D9C5A3B43E8FAB9382CDDB9CA91", "_encstr_8CB41517AE169C4ECB7D9C5A3B43E8FAB9382CDDB9CA91", "_encstr_A6BF124EB9F7E8B3B7A2EF1C81F9E8E9475CFE9E");
  thread _id_12957();
}

_id_12957() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  scripts\common\utility::demeanor_override("_encstr_931904C66102");

  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp\utility::is_valid_player() || !var_1 isonground()) {
      continue;
    }
    self getenemyinfo(var_1);
  }

  for(var_3 = randomintrange(15, 20); var_3 > 0; var_3 = var_3 - 1) {
    if(scripts\cp\utility::any_player_nearby(self.origin, 640000)) {
      break;
    }

    wait 1;
  }

  scripts\common\utility::demeanor_override("_encstr_AA7C07466F9DA30713");
}

ks_pointkingsgetnobonus(var_0) {
  thread blueprintextract_beforepickupspawned("_encstr_A3D3148BEA0B399C2F7D1BB299D1FAB90E0BBBCD59C8", "_encstr_8CB41517AE169C4ECB7D9C5A3B43E8FAB9382CDDB9CA91");
}

ks_pointsperkingslain(var_0) {
  setup_manual_goalpos(var_0);
  thread blueprintextract_beforepickupspawned("_encstr_A6BF124EB9F7E8B3B7A2EF1C81F9E8E9475CFE9E");
}

blueprintextract_beforepickupspawned(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = 20;

  if(!isDefined(var_1))
    var_1 = "_encstr_ABA008615A631510C7EA";

  if(!isDefined(var_2))
    var_2 = "_encstr_ABA008615A631510C7EA";

  level scripts\engine\utility::_id_143A6(var_0, var_1, var_2);

  while(scripts\cp\cp_modular_spawning::has_seen_any_player_recently()) {
    var_3 = var_3 - 0.25;
    wait 0.25;

    if(scripts\cp\utility::any_player_nearby(self.origin, 360000)) {
      return;
    }
    if(var_3 <= 0)
      return;
  }

  scripts\cp\cp_modular_spawning::script_kill_ai();
}

watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopwaves(var_0);
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

stopwaveandstartthisone(var_0) {
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  wait 0.5;
  [[var_0]]();
}

watchforjuggstop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforjuggstop(var_0);
}

_id_11F52(var_0) {
  if(!isDefined(level._id_11F54)) {
    return;
  }
  var_1 = "_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27";
  thread bomb_label(level._id_11F54, var_1);
  thread _id_11F55(var_1);
}

bomb_label(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_1))
    level endon(var_1);

  var_2 = printdata(var_0);
  thread bomb_plant_allowed(var_2);

  for(;;) {
    scripts\common\utility::demeanor_override("_encstr_92100762872552A643");
    var_3 = getclosestpointonnavmesh(var_2.origin);
    var_4 = var_2.radius;
    self.script_origin_other = var_3;
    scripts\cp\cp_modular_spawning::set_goal_pos(var_3);
    scripts\cp\cp_modular_spawning::set_goal_radius(var_4);
    wait 2;
  }
}

bomb_on_vehicle_clean_up_monior(var_0) {
  var_0 notify("_encstr_821E1B57E01F6762B7C1F1C2C19BCB0A23D26BF1B3B08D518B427E9301");
  var_0 endon("_encstr_821E1B57E01F6762B7C1F1C2C19BCB0A23D26BF1B3B08D518B427E9301");

  for(;;) {
    var_1 = var_0.origin;
    var_2 = var_0.radius;
    level thread scripts\engine\utility::draw_circle(var_1, var_2, (1, 1, 0), 0.5, 0, 20);

    if(isDefined(var_0._id_127EA) && var_0._id_127EA.size) {
      foreach(var_6, var_4 in var_0._id_127EA) {
        if(isDefined(var_4) && isai(var_4) && isalive(var_4)) {
          var_5 = var_4 getentitynumber();

          if(!isDefined(var_5))
            var_5 = "_encstr_AA15062C769537A3";
        }
      }
    }

    wait 1;
  }
}

bomb_plant_allowed(var_0) {
  handlemeleekillsteelballs(var_0);
  var_0._id_127EA[var_0._id_127EA.size] = self;
  self waittill("_encstr_AD75063D571AE108");
  handlemeleekillsteelballs(var_0);
}

printdata(var_0) {
  var_1 = var_0[0];
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(isDefined(var_4.script_count_max) && int(var_4.script_count_max) <= var_4._id_127EA.size) {
      if(var_1 == var_4 && var_3 < var_0.size - 1)
        var_1 = var_0[var_3 + 1];

      continue;
    } else
      var_2[var_2.size] = var_4;

    if(var_1._id_127EA.size > var_4._id_127EA.size)
      var_1 = var_4;
  }

  return var_1;
}

_id_11F55(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill(var_0);
  wait 1;
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_pos(scripts\engine\utility::random(level.players).origin);
  scripts\cp\cp_modular_spawning::set_goal_radius(500);
}

handlemeleekillsteelballs(var_0) {
  var_1 = [];

  foreach(var_3 in var_0._id_127EA) {
    if(isDefined(var_3) && isalive(var_3))
      var_1[var_1.size] = var_3;
  }

  var_0._id_127EA = var_1;
}

_id_12926(var_0) {
  thread _id_12927(var_0);
}

isplayerinsiderectangularzonebasedonent() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;)
    wait 0.1;
}

_id_12927(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  scripts\cp\cp_modular_spawning::set_goal_pos(self.script_origin_other);
  scripts\cp\cp_modular_spawning::set_goal_radius(32);
  _id_143CF(1);
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);
  var_1 = scripts\cp\utility::get_closest_living_player(16000000);

  if(isDefined(var_1))
    self setgoalpos(var_1.origin);
}

_id_143CF(var_0) {
  for(;;) {
    level waittill("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243", var_1);

    if(isDefined(var_1) && isDefined(level._id_12958) && level._id_12958 == var_0) {
      break;
    }

    wait 0.05;
  }
}

_id_12D87(var_0) {
  thread _id_12D88(var_0);
}

_id_12D88(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.5;
  thread scripts\common\utility::demeanor_override("_encstr_92100762872552A643");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_1)) {
      self.script_origin_other = var_1.origin;
      scripts\cp\cp_modular_spawning::set_goal_radius(64);
    }
  } else {
    self.script_origin_other = self.origin;
    scripts\cp\cp_modular_spawning::set_goal_radius(128);
  }

  level waittill("_encstr_A6BF124EB9F7E8B3B7A2EF1C81F9E8E9475CFE9E");
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);
  var_2 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_2))
    self setgoalpos(var_2.origin);
}

_id_13890(var_0) {
  thread _id_13891(var_0);
  thread _id_14409();
}

_id_14409() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  level waittill("_encstr_B6BF12235331C06D0AF3D7A1FFB23A61C9AB2E99");
  self._id_14409 = 1;
}

_id_13891(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  scripts\cp\cp_modular_spawning::set_goal_radius(52);

  while(!istrue(self._id_14409)) {
    wait 1;
    var_1 = 650;
    var_2 = 64;
    var_3 = scripts\cp\utility::get_closest_living_player(var_1 * var_1);

    if(isDefined(var_3) && abs(self.origin[2] - var_3.origin[2]) < var_2) {
      break;
    }

    if(isDefined(self.maxhealth) && self.health < self.maxhealth / 2) {
      break;
    }
  }

  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);

  for(;;) {
    var_4 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(var_4))
      self setgoalpos(var_4.origin);

    wait 10;
  }
}

_watchforjuggstop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_91271B68B32D1916DF6935A6488FF88F99FAC040FA496B284B8531AD4B");
  var_1 = var_0.group_name;
  level waittill("_encstr_8CFB0DF02BB5919ECFEFB535F43746" + var_1);
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

spawn_soldiers_switch_01() {
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "_encstr_8E370FF77D5330B47FFB9306625F7E98FA");
  level.convoy4_module_02a_pre = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_ACC512C198BD2E203B9941020BAE960EC198B56F");
  level waittill("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  scripts\cp\cp_spawning_util::_id_13BBD(0);
  wait 0.5;
  level.convoy4_module_02a = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B6140EEE85BAB5B8299AB9BAFA49F673");
}

spawn_soldiers_switch_02() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level.convoy4_module_02b_pre = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B84312FE95AAA5A839EAC9AAEA7AE66301FAEE75");
  level.convoy4_module_02b2_pre = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BD561272389DA3871A3577100E417F7A5758EBEA");
  level waittill("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  level thread scripts\cp\cp_wave_spawning::killstreaks(0.1, "_encstr_8E370FF77D5330B47FFB9306625F7E98FA");
  wait 1;
  level.convoy4_module_02b = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A2140EC218C02325C8614F284538E186");
  level.convoy4_module_02b2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_B1140ED8DEB967BD2F43FA0C1913FA8C");
}

spawn_soldiers_switch_03() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  level.convoy4_module_02c_pre = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_81DA128DED3767BD9743BE06646CFA62F50EE4AC");
  level waittill("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  wait 0.5;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("_encstr_81DA128DED3767BD9743BE06646CFA62F50EE4AC");
  level thread scripts\cp\cp_wave_spawning::killstreaks(0.5, "_encstr_A9041687D733D4502F6A1B6E94F9B81A8FB71D374F2AADA0");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", ::waittill_all_valid_ai_are_gone);
}

spawn_soldiers_attack_tower() {
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  wait 0.5;
  level.convoy4_module_03a = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_991F0EC6DBB99DDB5ED0EBC06685AF62");
  level.convoy4_module_03b = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_84F41051A0BA54DA32E2B0A7AB63BEE37E0F");
}

spawn_soldiers_juggs() {
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  wait 0.5;
  level.convoy4_module_juggs_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A56B10CFF8701B1FEB9536902B0F58966F61");
  level.convoy4_module_juggs_2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_866B10D8DEDC67DB2F43EB53AEB3ECCDFAC8");
  level.convoy4_module_juggs_3 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_8B6B10263DB86310588FB042CB0FAF17B0A3");
  wait 3;
  level.convoy4_module_04a_1 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_87490E5A10B5FBDF724D0F7825195752");
  level.convoy4_module_04a_2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_81490EC1870804301B7B499012B0B17E");
  level.convoy4_module_04a_3 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_88490EB1DBDCECBD2FD0D760A1167D66");
}

spawn_soldiers_rooftops() {
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  wait 1;
  level.convoy4_module_roofs = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_999110BED5EAE5E8792A09785FB7012741EA");
  level.convoy4_module_roofs2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_A19110DBB7786B755B0269B3F05FEFA7B656");
}

spawn_soldiers_ending() {
  level notify("_encstr_AF791AD05D4CC0B3A14E17CFA67B6693C7D88B260BDA02AF08B373DF");
  wait 1;
  level.convoy4_module_roofs2 = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_91F3116BB0C8DB250B5219B2A8199C034130A1");
}

setup_manual_goalpos(var_0, var_1) {
  self notify("_encstr_96BD0D89D20F0BA061D3777BFAD620");
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);

  switch (var_0.group_name) {
    case "_encstr_91AA0D27C38A7DDBE9F71030EF68D3":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      break;
    case "_encstr_AF310ED31860737D533A618F0ABFB9A6":
    case "_encstr_B2310E932F806B474383F9173B164F72":
    case "_encstr_8E310EC090DA7CBF9152AF3F6AB3D79B":
      scripts\cp\cp_modular_spawning::set_goal_radius(1000);
      self.goalheight = 1024;
      break;
    case "_encstr_88490EB1DBDCECBD2FD0D760A1167D66":
    case "_encstr_81490EC1870804301B7B499012B0B17E":
    case "_encstr_87490E5A10B5FBDF724D0F7825195752":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 128;
      break;
    case "_encstr_952312DE1FCBBBA720C771087AFC511103AB486F":
      scripts\cp\cp_modular_spawning::set_goal_radius(384);
      self.goalheight = 128;
      self.sightmaxdistance = 2200;
      thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
      break;
    case "_encstr_A23E12C6AD929D8011B2A1C0F72FF997BA534C5C":
      scripts\cp\cp_modular_spawning::set_goal_radius(64);
      self.goalheight = 128;
      break;
  }
}

initcommslaptop(var_0) {}

hintcommslaptop(var_0, var_1) {
  if(istrue(level.convoy4_comms_laptop_int_struct.laptopactive))
    return &"_encstr_820213DF77C9FF73A440BEDD34EB9D2737A1EF9BE7";
  else
    return "_encstr_B40101";
}

hintcalltraininteract(var_0, var_1) {
  if(!istrue(level.obj_allow_call_train))
    return "_encstr_B40101";

  var_2 = &"_encstr_B6C42F9E67EF410D75F12317EA6EDFB83D1516C343555873D0515F43214491A7BFBE6E4D591F81BA257963FF01BF45D939";

  switch (level.obj_call_train_count) {
    case 0:
      var_2 = &"_encstr_B6C42F9E67EF410D75F12317EA6EDFB83D1516C343555873D0515F43214491A7BFBE6E4D591F81BA257963FF01BF45D939";
      break;
    case 1:
      var_2 = &"_encstr_A6C42F2B637F4247DB2ED6A8977011E26AAD8FFB019FD85FA8873736D917DB3F391E1F45AD707BD91587A39FC371DF2962";
      break;
    case 2:
      var_2 = &"_encstr_B2C42FC9938FE763D02A9E032A690FCD327F41E91F7EBDA71E0618801B80EBBB7F0FE9A193DFD79D14BCE0302379AB1EFA";
      break;
    case 8:
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      var_2 = &"_encstr_84C42F4608015921A9121923D63E5F5B3425E0B9A3569F2AFA7021415C576951EFDF767BC9A903B70973E009555AA5576A";
      break;
  }

  return var_2;
}

initcalltraininteract(var_0) {
  level.obj_call_train_count = 0;

  foreach(var_2 in var_0) {
    var_2.p_ent_skip_fov = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var_2);
  }
}

activationcalltraininteract(var_0, var_1) {
  if(!istrue(level.obj_allow_call_train)) {
    return;
  }
  level.obj_call_train_count++;
  scripts\cp\utility::playsoundatpos_safe(var_0.origin, "_encstr_A32A178FE150EB8DF8A37A803E68B2A21345F7F7AB61826F9A" + level.obj_call_train_count);
  var_2 = hintcalltraininteract(var_0, var_1);
  scripts\cp\coop_personal_ents::update_pent_hintstring(var_0, var_2);
  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();

  if(level.obj_call_train_count >= 3) {
    var_0.disabled = 1;
    level.obj_allow_call_train = 0;
    level.tracking_hints_calltrain = undefined;
    scripts\cp\coop_personal_ents::delayed_remove_peent_interaction(var_0);
    level.obj_called_train = 1;
    level thread scripts\cp\cp_vo::remove_from_nag_vo("_encstr_82BA2569F8B7F0D7C387D7CBA70A88B83516132320A259029A071FAF97626570F12D7979C109DA");
    level notify("_encstr_82AE11BF158001576F682AA271A8C38220EB26");
  }
}

_id_124D2() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  level endon("_encstr_8C54160E8D58CB95C9FA479C5AEC762BE45991BEF6C4A5E8");
  var_0 = scripts\engine\utility::getStruct("_encstr_8C0C0C8273D0AAF373777F33639D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 10000;

  for(;;) {
    var_2 = scripts\cp\utility::give_all_players_nearby(var_0.origin, var_1);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_2[var_3] getclantag() == "_encstr_9A6005079CB073")
        var_2[var_3] thread _id_1436B(var_0.origin, var_1);
    }

    wait 5;
  }
}

_id_1436B(var_0, var_1) {
  level endon("_encstr_8C54160E8D58CB95C9FA479C5AEC762BE45991BEF6C4A5E8");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(istrue(self._id_13C51)) {
    return;
  }
  self._id_13C51 = 1;
  var_2 = 0;

  for(;;) {
    if(distance2dsquared(self.origin, var_0) > var_1) {
      self._id_13C51 = undefined;
      return;
    }

    if(var_2 > 60) {
      level thread _id_11F51();
      return;
    }

    wait 1;
    var_2 = var_2 + 1;
  }
}

_id_11F51() {
  level notify("_encstr_8C54160E8D58CB95C9FA479C5AEC762BE45991BEF6C4A5E8");
  var_0 = getEnt("_encstr_9AB30B70AA6F436F8D2AC0C032", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 makeusable();
  var_0 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0 sethintdisplayrange(265);
  var_0 sethintdisplayfov(80);
  var_0 setuserange(95);
  var_0 setusefov(35);
  var_0 sethintonobstruction("_encstr_BD1805CB69C063");
  var_0 setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isDefined(var_1)) {
      if(!var_1 scripts\cp\utility::is_valid_player()) {
        continue;
      }
      var_1 playlocalsound("_encstr_A2240F47D3B0F682BD43FFBBA3D6EA25C0");
      level thread _id_11F4F(var_0);
      var_0 makeunusable();
    }
  }
}

_id_11F4F(var_0) {
  var_1 = ::_id_135A7;
  var_2 = [];
  var_2 = [[[var_1]]((7488, -11168, 224), (0, 267.5, 0)), [[var_1]]((7488, -11120, 224), (0, 267.5, 0)), [[var_1]]((7504, -11120, 224), (0, 267.5, 0)), [[var_1]]((7472, -11120, 224), (0, 267.5, 0)), [[var_1]]((7536, -11120, 224), (0, 267.5, 0)), [[var_1]]((7552, -11120, 224), (0, 267.5, 0)), [[var_1]]((7568, -11120, 224), (0, 267.5, 0)), [[var_1]]((7568, -11144, 224), (0, 267.5, 0)), [[var_1]]((7536, -11144, 224), (0, 267.5, 0)), [[var_1]]((7536, -11168, 224), (0, 267.5, 0)), [[var_1]]((7552, -11168, 224), (0, 267.5, 0)), [[var_1]]((7568, -11168, 224), (0, 267.5, 0)), [[var_1]]((7608, -11120, 224), (0, 267.5, 0)), [[var_1]]((7608, -11144, 224), (0, 267.5, 0)), [[var_1]]((7608, -11168, 224), (0, 267.5, 0)), [[var_1]]((7624, -11136, 224), (0, 267.5, 0)), [[var_1]]((7640, -11144, 224), (0, 267.5, 0)), [[var_1]]((7656, -11136, 224), (0, 267.5, 0)), [[var_1]]((7672, -11120, 224), (0, 267.5, 0)), [[var_1]]((7672, -11144, 224), (0, 267.5, 0)), [[var_1]]((7672, -11168, 224), (0, 267.5, 0)), [[var_1]]((7448, -11208, 224), (0, 267.5, 0)), [[var_1]]((7464, -11200, 224), (0, 357.5, 0)), [[var_1]]((7520, -11232, 224), (0, 267.5, 0)), [[var_1]]((7448, -11232, 224), (0, 267.5, 0)), [[var_1]]((7448, -11256, 224), (0, 267.5, 0)), [[var_1]]((7464, -11264, 224), (0, 357.5, 0)), [[var_1]]((7528, -11256, 224), (0, 327.5, 0)), [[var_1]]((7464, -11232, 224), (0, 357.5, 0)), [[var_1]]((7524, -11208, 224), (0, 252.5, 0)), [[var_1]]((7552, -11252, 224), (0, 222.5, 0)), [[var_1]]((7560, -11232, 224), (0, 177.5, 0)), [[var_1]]((7540, -11196, 224), (0, 182.5, 0)), [[var_1]]((7600, -11248, 224), (0, 267.5, 0)), [[var_1]]((7608, -11224, 224), (0, 267.5, 0)), [[var_1]]((7616, -11200, 224), (0, 267.5, 0)), [[var_1]]((7632, -11224, 224), (0, 267.5, 0)), [[var_1]]((7640, -11248, 224), (0, 267.5, 0)), [[var_1]]((7616, -11232, 224), (0, 357.5, 0)), [[var_1]]((7672, -11248, 224), (0, 267.5, 0)), [[var_1]]((7672, -11224, 224), (0, 267.5, 0)), [[var_1]]((7680, -11208, 224), (0, 282.5, 0)), [[var_1]]((7688, -11232, 224), (0, 282.5, 0)), [[var_1]]((7696, -11248, 224), (0, 282.5, 0)), [[var_1]]((7712, -11248, 224), (0, 267.5, 0)), [[var_1]]((7712, -11224, 224), (0, 267.5, 0)), [[var_1]]((7712, -11200, 224), (0, 267.5, 0)), [[var_1]]((7352, -11304, 224), (0, 267.5, 0)), [[var_1]]((7352, -11328, 224), (0, 267.5, 0)), [[var_1]]((7352, -11352, 224), (0, 267.5, 0)), [[var_1]]((7352, -11376, 224), (0, 267.5, 0)), [[var_1]]((7392, -11320, 224), (0, 267.5, 0)), [[var_1]]((7424, -11320, 224), (0, 267.5, 0)), [[var_1]]((7408, -11312, 224), (0, 192.5, 0)), [[var_1]]((7408, -11344, 224), (0, 327.5, 0)), [[var_1]]((7424, -11344, 224), (0, 267.5, 0)), [[var_1]]((7424, -11368, 224), (0, 267.5, 0)), [[var_1]]((7456, -11320, 224), (0, 267.5, 0)), [[var_1]]((7456, -11344, 224), (0, 267.5, 0)), [[var_1]]((7472, -11352, 224), (0, 297.5, 0)), [[var_1]]((7488, -11368, 224), (0, 267.5, 0)), [[var_1]]((7472, -11384, 224), (0, 177.5, 0)), [[var_1]]((7472, -11312, 224), (0, 267.5, 0)), [[var_1]]((7488, -11312, 224), (0, 267.5, 0)), [[var_1]]((7528, -11304, 224), (0, 177.5, 0)), [[var_1]]((7536, -11312, 224), (0, 282.5, 0)), [[var_1]]((7544, -11336, 224), (0, 267.5, 0)), [[var_1]]((7528, -11344, 224), (0, 177.5, 0)), [[var_1]]((7544, -11360, 224), (0, 267.5, 0)), [[var_1]]((7528, -11376, 224), (0, 357.5, 0)), [[var_1]]((7584, -11352, 224), (0, 177.5, 0)), [[var_1]]((7608, -11352, 224), (0, 177.5, 0)), [[var_1]]((7632, -11304, 224), (0, 267.5, 0)), [[var_1]]((7664, -11304, 224), (0, 267.5, 0)), [[var_1]]((7680, -11328, 224), (0, 267.5, 0)), [[var_1]]((7656, -11344, 224), (0, 222.5, 0)), [[var_1]]((7632, -11368, 224), (0, 267.5, 0)), [[var_1]]((7656, -11376, 224), (0, 177.5, 0)), [[var_1]]((7680, -11376, 224), (0, 177.5, 0)), [[var_1]]((7720, -11320, 224), (0, 267.5, 0)), [[var_1]]((7736, -11304, 224), (0, 267.5, 0)), [[var_1]]((7760, -11320, 224), (0, 267.5, 0)), [[var_1]]((7760, -11344, 224), (0, 267.5, 0)), [[var_1]]((7720, -11344, 224), (0, 267.5, 0)), [[var_1]]((7728, -11368, 224), (0, 267.5, 0)), [[var_1]]((7752, -11368, 224), (0, 267.5, 0)), [[var_1]]((7792, -11304, 224), (0, 267.5, 0)), [[var_1]]((7792, -11328, 224), (0, 267.5, 0)), [[var_1]]((7792, -11352, 224), (0, 267.5, 0)), [[var_1]]((7792, -11376, 224), (0, 267.5, 0)), [[var_1]]((7864, -11304, 224), (0, 267.5, 0)), [[var_1]]((7856, -11328, 224), (0, 267.5, 0)), [[var_1]]((7848, -11352, 224), (0, 267.5, 0)), [[var_1]]((7840, -11376, 224), (0, 267.5, 0)), [[var_1]]((7848, -11296, 224), (0, 177.5, 0)), [[var_1]]((7832, -11296, 224), (0, 177.5, 0))];
  level.breakerstate = [];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    level.breakerstate[level.breakerstate.size] = var_2[var_3] thread _id_135A6(var_0.origin);
    wait 0.25;
  }

  wait 30;

  for(var_3 = 0; var_3 < level.breakerstate.size; var_3++) {
    level.breakerstate[var_3] delete();
    wait 0.25;
  }
}

_id_135A7(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

_id_135A6(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + self.origin + (-7500, 11182, 512));
  var_1 setModel("_encstr_87BB18F45F48515B3D19DA33468657964857C839A738A2EFDCB0");

  if(isDefined(self.angles))
    var_1.angles = self.angles;

  return var_1;
}

_id_11F50() {
  var_0 = scripts\engine\utility::getStruct("_encstr_8C0C0C8273D0AAF373777F33639D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = vehicle_getarray();
  var_2 = 2250000;

  foreach(var_4 in var_1) {
    if(distance2dsquared(var_4.origin, var_0.origin) < var_2) {
      if(isDefined(var_4.spawndata) && var_4.birthtime < gettime() - 20000)
        scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var_4);
    }

    wait 0.1;
  }
}

_id_131F0() {
  scripts\cp\utility::skydivestreamhintdvars("_encstr_B49507136BBF0EA070");
}

_id_131F1() {
  scripts\cp\utility::skydivestreamhintdvars("_encstr_845A0C037351A00EAB3F819BCF63");
}

setup_enemy_sentries(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 1:
      var_1 = "_encstr_BDFC1186222AD7F855E3D990C769B31573015F";
      break;
    case 2:
      var_1 = "_encstr_BEFC112FB89E78882F93468BCB17BEE8303F35";
      break;
    case 3:
      var_1 = "_encstr_92FC116B1809EB7D60921EA36FC93B43A10F5F";
      break;
    case 4:
      var_1 = "_encstr_88FC111B5979AB80873857D185A15B5B132EC2";
      break;
    case 5:
      var_1 = "_encstr_81FC113F1BCA64908D721ED35B71881EA33F3B";
      break;
  }

  if(isDefined(var_1)) {
    level.initlocationcircle = var_1;
    level.initlethalmaxoffsetmap = var_1;
  }
}

_id_130A8() {
  foreach(var_1 in level.players)
  var_1 thread scripts\mp\vehicles\vehicle_damage_mp::_id_1340D(2, 1, 1);

  wait 2;

  foreach(var_1 in level.players) {
    var_4 = scripts\engine\utility::getStruct("_encstr_BA540EB1855BAC932CD795E646B4DCEC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = var_4.origin;
    var_6 = scripts\engine\utility::getStruct(var_4.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5);
    var_7 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_7.angles = var_4.angles;
    var_7 moveTo(var_6.origin, 20, 1, 1);
    var_1 playerhide();
    var_1 allowfire(0);
    var_1 disableoffhandweapons();
    var_1 disableusability();
    var_1 allowmovement(0);
    var_1 setclientomnvar("_encstr_AA5B0CE53B662BDC495081EAC891", 1);
    var_1 spawn_endgame_camera(var_7);
    var_1 lerpfovscalefactor(0, 0);
  }
}

spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", "_encstr_82070322E1");
}

setup_hostage_fulton_anims(var_0, var_1) {
  thread thread_hostage_fulton_anims();
}

thread_hostage_fulton_anims() {
  level scripts\cp\cp_hostage::anim_init_hostage();
  level waittill("_encstr_8F4812E067AC5B1B2A1185B779F26903F2F778F0");
  thread scripts\cp\cp_hostage::anim_fulton_hostage_player_scene(self);
}

play_vo_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4))
    wait(var_4);

  if(isDefined(var_0))
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08", var_3, var_5, var_6);

  if(isDefined(var_1))
    wait(var_1);

  if(isDefined(var_2))
    level thread scripts\cp\utility::cp_add_dialogue_line(var_2);
}

vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 / 1000;
  return var_1;
}

play_intro_vo() {
  level endon("_encstr_AB79125B1DC8E3C9FF381A23E021BC632110C6CF");
  wait 5;
  scripts\mp\vehicles\vehicle_damage_mp::_id_12409("_encstr_AFAD05B58130DB");
  level play_vo_delay("_encstr_91BD2532F0D78D3837D73685DCE6BEE2AEB04EC95E91BEB696E69B2DB773BE5AB9479C7BEB9881");
  wait 1.5;
  level play_vo_delay("_encstr_AF9D1D1BFB1F37D307F9F243089091AB459F9252D842AFF3C69C4AB7F1BE2F");
  wait 0.75;
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
}

play_hacks_interact_vo() {
  level waittill("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  wait 2;
  level thread play_vo_delay("_encstr_A1321F45A359C6FBA7C18790D02F318325A76BCBE80DC974D13FA823732A4821EB", undefined, undefined);
  level waittill("_encstr_ACD714581109C747FD88F9E2D0337AA7C00FD3CB2031");
  level thread play_vo_delay("_encstr_8227256D40A99F5B23372030FF5BF6F353AEDEEE98971FE317D368788F728B778B55D87CF91F89", undefined, undefined);
}

handle_players_near_hack_b(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = var_1 * var_1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_2)) {
      break;
    }

    wait 0.15;
  }

  level notify("_encstr_ACD714581109C747FD88F9E2D0337AA7C00FD3CB2031");
}

handle_remind_hack() {
  level notify("_encstr_820E1B2AE8983DDA59D359CC3B48F1A239F232B7700FE14BD810224F1B");
  level endon("_encstr_820E1B2AE8983DDA59D359CC3B48F1A239F232B7700FE14BD810224F1B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  level waittill("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  var_0 = 0.25;
  var_1 = 0.1;

  for(;;) {
    if(!istrue(level.i_see_player_shield_watcher)) {
      return;
    }
    var_2 = 0;

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(istrue(level.players[var_3].inhackring))
        var_2++;
    }

    if(var_2 <= 1)
      var_1 = var_1 + var_0;

    if(var_1 > 15) {
      level thread play_nag_hack_vo();
      var_1 = 0.1;
    }

    wait(var_0);
  }
}

play_nag_hack_vo() {
  var_0 = ["_encstr_97FD28C83CEB36E06EEBB50BAD16AF5CAE859C395EC8EBDCB076AF9B3AB097D7F673D71A5836ADF54C06", "_encstr_B2FD28DC494166037E2662CA485F875AB8E34232A3F2A1332F5939D373A7D7991055F7A02B10F42F6E9B"];
  level thread play_vo_delay(scripts\engine\utility::random(var_0));
}

play_hack_vo(var_0) {
  if(!isDefined(level.convoy4_vo_hacks))
    level.convoy4_vo_hacks = 0;

  if(level.convoy4_vo_hacks == 0) {
    level play_vo_delay("_encstr_A9E225E2601F465BFB20E3E1C1411F0AA3300B3BC09D316F7015CF10EF2987D939A8C372893322", undefined, undefined);
    level thread _id_123F0();
  } else if(level.convoy4_vo_hacks == 1) {
    level play_vo_delay("_encstr_A6662648EBB9B77BB7DF323FF527465B9BC27060939A97B38F07D0A3D14788E7C97A20C07A698303", undefined, undefined);
    level thread _id_123F1();
  } else if(level.convoy4_vo_hacks == 2) {
    level.convoy4_vo_hacks = undefined;
    var_1 = var_0 scripts\cp\utility::get_closest_living_player();
    scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_1, "_encstr_8CDC13176D9251D3D01B12DF73891B0BFE87A7EFF7");
    level play_vo_delay("_encstr_B8C82783E1A03A7898162CB648D08FD30D6B53438B7EA12660D8A6FD26F0F94AEAFFB3BF0F886949D2");
  }

  if(isDefined(level.convoy4_vo_hacks))
    level.convoy4_vo_hacks = level.convoy4_vo_hacks + 1;
}

_id_123F0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  wait 20;
  level thread play_vo_delay("_encstr_B1F02268AB1729A10BE19A974502B730917F29F80FFF03A7919387A31A1A0378EC07CABA");
}

_id_123F1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243");
  wait 20;
  level thread play_vo_delay("_encstr_A3F022E9E31FEED88A0F9F835576D9208F8A06313AC79DE8A91F93CB50DDA0F863615353");
}

play_keys_intro_vo() {
  level play_vo_delay("_encstr_BE7C273722D14B23A6A7A38FE74E199178E92A3ABA122F6AF0EDCBCB37F983C718B0E6C451F8E78777");
  wait 0.75;
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
}

play_keys_vo(var_0) {
  if(!isDefined(level.convoy4_vo_keys))
    level.convoy4_vo_keys = 0;

  if(level.convoy4_vo_keys == 0) {
    thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_0, "_encstr_8F87127B98D4AFB1ED8D8D596C47D799A5E46EA3");
    level thread play_vo_delay("_encstr_978225320FBEB183E6F5AD0BD60BD7B8D5859C9C2F8CFAA3EEDB7D6D2B97E6EBC659331DF54CC0", undefined, undefined, undefined, 0.15);
  } else if(level.convoy4_vo_keys == 1) {
    thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_0, "_encstr_B44814379D0889EFD0E0B22AE9B5E7FEC01FA4883B90");
    level thread play_vo_delay("_encstr_865624F5D83107B3CBCFF0A82FF16E9B3B067606703FB7188E5F49C01711A6E9426FED18DA77", undefined, undefined, undefined, 0.15);
  } else if(level.convoy4_vo_keys == 2) {
    thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_0, "_encstr_AD2015ED894DFAC6B7B18DCAB147F536DBB50EC6B2E8CA");
    level.convoy4_vo_keys = undefined;
    level thread play_final_key_vo();
  }

  if(isDefined(level.convoy4_vo_keys))
    level.convoy4_vo_keys = level.convoy4_vo_keys + 1;
}

play_final_key_vo() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_82AE11BF158001576F682AA271A8C38220EB26");
  level play_vo_delay("_encstr_82BA2569F8B7F0D7C387D7CBA70A88B83516132320A259029A071FAF97626570F12D7979C109DA");
  wait 0.75;
  scripts\mp\vehicles\vehicle_damage_mp::_id_12408(undefined, "_encstr_A26D149E50E863B177E153DB52238AA12A052A7940EB");
  level thread play_vo_delay("_encstr_82BA2569F8B7F0D7C387D7CBA70A88B83516132320A259029A071FAF97626570F12D7979C109DA", undefined, undefined, 1, undefined, 35);
}

play_cargo_intro() {
  level thread play_cargo_train_stopped();
  level waittill("_encstr_B2611568FE3B5F932983CF9FCB7ADEB29F29BFFFD948B0");
  level thread play_vo_delay("_encstr_8E281D191EBE1BE0B9F5B60BB585AF5C5D2CC9E4CB91D7E839C2B49BFA2681", undefined, undefined);
}

play_cargo_train_stopped() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_BA1C16936F3D4B306B6F3F5BD2116AD02943DBFF338172C7");
  level thread play_vo_delay("_encstr_A7F31D737077971BB25F235E4247A661E0A822AD52D509B052615410216210", undefined, undefined);
}

play_cargo_c4_nags() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B8120E41516881B9D97E33C1FB40CF73");

  for(;;) {
    level thread play_vo_delay("_encstr_85012123C3FAD8E09B7DB5B0D685FA8BAE0BE4935EC8EB73C2D9EBA3E40B5A73EB4C60");
    wait(randomfloatrange(20, 30));
  }
}

_id_1241E() {
  level thread play_vo_delay("_encstr_8FEE276C4087FF404B976F894DB7A9BB403032BAB07A413F4007871253BA1A80CF43D88FC94F8F834A");
}

_id_123E3(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.obj_got_extract = 1;
  wait 0.5;
  level thread play_vo_delay("_encstr_9ABC22A9387730170347998B9F6BC8F8F5D6D3E3E0E219458BF3DD93E7C32BC0B6213333", undefined, undefined);
  wait 90;
  level thread play_vo_delay("_encstr_8EAA2DF140E12817E7D190393BCF586083B12555D902815FE32A0AA1D3A78C089D1C97F5577AE8A9EF4243A929769F", undefined, undefined);
  wait 75;
  level thread play_vo_delay("_encstr_81BC225510170191AA89E080A342179B17B1E6D679DACEF35023E8989ADB3310A3674E6F", undefined, undefined);
  wait 18;
  var_1 = 0;
  var_2 = level.players.size;

  foreach(var_4 in level.players) {
    if(!istrue(var_4.used_fulton_interact)) {
      var_1++;
      level thread scripts\cp\cp_vo::try_to_play_vo_for_one_player("_encstr_8ABC229A0ADF474F58C1D8A1DB7B11879DAFBD223A32E862402372821BE39B5F80BFCF9A", var_4, 0);
    }
  }

  if(var_2 == var_1) {
    level notify("_encstr_88761A2B9738D3EFEBDB913A7A4543CEB859A9BF3D099F9F9BC80A32");
    objective_state(var_0, "_encstr_9B46072B7EA254ADAF");
    level.i_see_player_vehicle_watcher = 1;
    wait 3;
    scripts\cp\cp_objectives::_id_12868("_encstr_874213AE920318C8F28AF16AF3245278B2A1FF48CE");
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
  }
}

_id_1240E(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A9B11CFC35E705153DBE789A57C21656D65A2");
  var_1 = 14400;

  for(;;) {
    var_2 = var_0 scripts\cp\utility::get_closest_living_player(var_1);

    if(isDefined(var_2)) {
      break;
    }

    wait 1;
  }

  level notify("_encstr_AAE5132062FE5B017BCB10F0B55FAB4FA78B2860FA");
  level thread scripts\mp\vehicles\vehicle_damage_mp::_id_12408(var_2, "_encstr_AD830CF6264D7D437B8D465ADCB3");
  level thread _id_12DFA();
  level thread _id_12DE8();
}

_id_12DE8() {
  level.vehicle_occupancy_getteamfriendlyto = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_AC28174DED4FA8BB1F42509E5BA3E7F0A555C5AF65F0E87303");
  level thread _id_138BD(60, "_encstr_AC28174DED4FA8BB1F42509E5BA3E7F0A555C5AF65F0E87303");
}

_id_12DFA() {
  level thread _id_12DD5("_encstr_95DD138B5F6B48B8E1DBF1DBFFC9FFF801F233A212");
  wait(randomfloatrange(10, 15));
  level thread _id_12DD5("_encstr_B4DD1313BDD79277F6A08BD7A0AE210BAB4E1AC83E");
  wait(randomfloatrange(10, 15));
  level thread _id_12DD5("_encstr_9ADD1347CA6C34DEAF07862F9BEB17BAB0934E5E43");
}

_id_138BD(var_0, var_1) {
  wait(var_0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_1);
}

_id_12DD5(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);

  if(isDefined(var_1.module_vehicles[0]) && isent(var_1.module_vehicles[0])) {
    var_2 = var_1.module_vehicles[0];
    var_2 thread _id_14350();
  }
}

_id_14350() {
  self endon("_encstr_AD75063D571AE108");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

play_outro_vo() {
  wait 1.8;
  level play_vo_delay("_encstr_9BE8221A98E78E9323E82B5999096752EBF8C3F308D5491F7A653A51A673471D75712F4F", undefined, undefined);
  wait 0.25;
  level play_vo_delay("_encstr_885F27C83CAFD8E0E6D736C2E6CDBE8B5D2C9C4E5E19F5AD2DE6DCB4B7CDBE6EAE1BC6CA6EDC7D1306", undefined, undefined);
}

play_hack_alarms() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_87A91B7BE10B92C3B810321A588BF38F99B7EFFD7B28116B5F0B5BC243", var_0);
  var_1 = scripts\engine\utility::getStruct("_encstr_92C511DB4CA9F5581BC24EADFA6E8EE4AB1BD1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level thread play_alarm_pos(var_1.origin);
}

play_alarm_pos(var_0) {
  if(isDefined(level.obj_alarm)) {
    level notify("_encstr_8DCA125FE2E481C7C37A2BF0A19B0678FF7FC31D");
    level.obj_alarm stoploopsound();
    level.obj_alarm delete();
    waitframe();
  }

  level.obj_alarm = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  level.obj_alarm show();
  wait 1;
  level.obj_alarm playLoopSound("_encstr_822617EE42A9BBFB3183D0F04F4990D323AD48E31DF31F8B49");
  level waittill("_encstr_8DCA125FE2E481C7C37A2BF0A19B0678FF7FC31D");
  level.obj_alarm stoploopsound();
  waitframe();
  var_1 = lookupsoundlength("_encstr_ABB3178D07FAE257B09393BCAF85638593D6D7F699CCFAC098");
  var_1 = var_1 / 1000;

  for(var_2 = 0; var_2 < 6; var_2++) {
    level.obj_alarm playSound("_encstr_ABB3178D07FAE257B09393BCAF85638593D6D7F699CCFAC098");
    wait(var_1);
  }

  level.obj_alarm delete();
}

his_respawn(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getscriptablearrayinradius("_encstr_ACD1106B7B46B28DD7342C36B61B9385E856", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_0.origin, 1000);

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1.size == 0) {
    return;
  }
  var_2 = var_1[0];
  var_2 setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_BA19049F4B2D");
}

computer_animation(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getscriptablearrayinradius("_encstr_ACD1106B7B46B28DD7342C36B61B9385E856", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_0.origin, 1000);

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1.size == 0) {
    return;
  }
  var_2 = var_1[0];
  var_2 setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_AB0703DBB9");
  level waittill("_encstr_A929111F2B9BAF68CF09D0E7DE0F1750687E27");
  var_2 setscriptablepartstate("_encstr_ABA2055B164BDC", "_encstr_BA19049F4B2D");
}

debug_start_hostages(var_0) {
  thread teleportstructs_threadedwait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D", "_encstr_A6E01836DBDC3BBD971AF591CAC4AE9DD7DCD18527E8D7D8BD8D");
}

debug_start_switches(var_0) {
  wait 0.5;
  thread teleportstructs_threadedwait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D", "_encstr_AFD619333096DE1F63B5970902D8F8BFD89B40734E18B82CD7D6EA");
}

debug_start_terminal(var_0) {
  thread teleportstructs_threadedwait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D", "_encstr_8DD619A31FB05B77735329A241C6D7D7E1CF4C29BDC8A92310D1E7");
}

debug_start_keys(var_0) {
  wait 0.5;
  thread teleportstructs_threadedwait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D", "_encstr_A2D61966081DA3A7E272A773C0B9757AA79E2B1E6E8189FC48A002");
}

debug_start_call(var_0) {
  wait 0.5;
  thread teleportstructs_threadedwait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D", "_encstr_A2D61966081DA3A7E272A773C0B9757AA79E2B1E6E8189FC48A002");
}

debug_start_waittrain(var_0) {
  thread teleportstructs_threadedwait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D", "_encstr_B1D619B1F6E6D9B72F43FAC895265DCEEBDCE858398EEBC6B76CD4");
}

debug_start_extraction(var_0) {
  thread teleportstructs_threadedwait("_encstr_A69F2B7BCFF7E1D38FDB4E4F328001B5A0D3974BFFD1667BFFA93BC9C6FEB9EBC820A37F7F4518B7F0D34BD86D", "_encstr_B1D619B1F6E6D9B72F43FAC895265DCEEBDCE858398EEBC6B76CD4");
}

teleportstructs_threadedwait(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", var_1, 1);
}

player_equipment_use_stop() {
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  waitframe();
  var_0 = (29097, 33602, 496);
  var_1 = getnodesinradius(var_0, 30, 0, 128);

  foreach(var_3 in var_1)
  var_3 disconnectnode();
}

israndomnoattachmentloadouts() {
  while(getdvarint("_encstr_A6CE17DB03F28943A2C80C102BEBD78DDA066E7B763A98CF6D", 0) == 0)
    wait 1;

  wait 1;
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  waitframe();
  var_0 = (29097, 33602, 496);
  var_1 = 2250000;

  while(!scripts\cp\utility::any_player_nearby(var_0, var_1))
    wait 0.1;

  announcement("_encstr_924619875046A0209248A9B1A377CFC19EDC2F47FE2FF05F277322");
  level.incomingcallback = scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_86E4112FD86BCD8B0F04E3987667A295B1A087");
}

spawn_in_cover(var_0) {
  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "_encstr_922406B1A6FD5E05")) {
      if(issubstr(var_1.type, "_encstr_A5AD0568019C63"))
        var_2 = var_2 + (0, 90, 0);
      else if(issubstr(var_1.type, "_encstr_8253061E2B5FE330") || issubstr(var_1.type, "_encstr_87AB0D4BD7B857DB077503DA9B8EEB") || issubstr(var_1.type, "_encstr_8BF608EDC8D8CFD8F9A8") || issubstr(var_1.type, "_encstr_AFFF0C6E8FE899DDE6174B068510"))
        var_2 = var_2 - (0, 90, 0);
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
    self.script_origin_other = var_3;
    scripts\cp\cp_modular_spawning::set_goal_pos(self.script_origin_other);
    scripts\cp\cp_modular_spawning::set_goal_radius(32);
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
  } else {}
}