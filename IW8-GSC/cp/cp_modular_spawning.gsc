/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_modular_spawning.gsc
***********************************************/

init_modular_spawning() {
  init_modular_spawning_flags();
  init_spawn_vars_and_pointers();
  setup_aitypes_array();
  level thread init_enemy_type_tracking();
  level thread init_trigger_spawn_groups();
  level thread scripts\cp\cp_escalation::main();

  if(isDefined(level.ambientgroupinit))
    level thread[[level.ambientgroupinit]]();

  modular_spawning_debug_init();
  scripts\cp\cp_wave_spawning::init_wave_spawning();

  if(getdvarint("_encstr_8AAD1D371B27EBB4DCD28EBE1BBD9D95E4D7B9F6322BFAE60E2CEE37B29C37", 1))
    level thread init_spawnpoints_from_cover_nodes();
}

init_modular_spawning_flags() {
  scripts\engine\utility::flag_init("_encstr_96A617E3C95D27B70917617EDBE13AFB88A17B3A1336076DB8");
  scripts\engine\utility::flag_init("_encstr_B6691C8E4EA5B3EC5627FAD6BDC8AB6356DCBE96E6D28E96B0D84B4F59C8");
  scripts\engine\utility::flag_init("_encstr_A17F10AB09E237B01B603723FB786BAC0E34");
  scripts\engine\utility::flag_init("_encstr_93A4192A1998437A88E3ABCFCB43C3B7A0CD697293800F82FBE5BF");
  scripts\engine\utility::flag_init("_encstr_8E8F19ABEB8E22524889C98BA14091DAE91BBF7F413F0B0618F0FF");
  scripts\engine\utility::flag_init("_encstr_93FE1D6A60CF7EAB90A54F694BBB97431B802292F04BB9974B9F6F6E53CD2F");
  scripts\engine\utility::flag_init("_encstr_BA352044F3B87EA31999C93203E0B7F55837EECD69800643B5F6034B49C423ECA03F");
  scripts\engine\utility::flag_init("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");
  scripts\engine\utility::flag_init("_encstr_BE070EA54FD75257215867A710D932BA");
}

init_spawn_vars_and_pointers() {
  level.ignoredbycheck = ::isentignoredbyme;
  level.spawn_queue = 0;
  level.active_spawn_modules = [];
  level.module_group_id = 0;
  level.spawnloopupdatefunc = ::update_spawn_data_on_death;
  level.enemy_monitor_func = ::enemy_monitor;
  level._id_11CA7 = [];
  level.nearbyposarray = [];
  level.ambientgroups = [];
  level.current_uid = 0;
  level.dynamic_spawn_locations = [];
  level.static_spawn_locations = [];
  level.current_num_spawned_enemies = 0;
  level.current_num_spawned_soldiers = 0;
  level.current_num_spawned_juggernauts = 0;
  level.current_num_spawned_zombies = 0;
  level.total_spawned_enemies = 0;
  level.reserved_spawn_slots = [];
  level.soft_reserved_spawn_slots = 0;
  level.delayed_spawn_slots = 0;
  level.desired_enemy_deaths_this_wave = 0;
  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.lastsoldierspawned = undefined;
  level.spawned_enemies = [];
  level.spawned_allies = [];
  level.spawned_ai = [];
  level.max_enemy_count = 20;
  level.spawned_soldiers = [];
  level.spawned_juggernauts = [];
  level.health_scale = [];
  level.respawn_enemy_list = [];
  level.parentspawnstruct = [];
  level.active_spawn_module_structs = [];
  level.next_heli_spawn = 0;
  level.spawner_script_funcs = [];
  level.requested_spawns_count = 0;
  level.requested_spawns_groups = [];
  level.all_air_vehicle_spawn_points = [];
  level.valid_air_vehicle_spawn_points = [];
  level.ground_vehicle_spawn_points = [];
  level.landing_pos_array = [];
  level.all_spawned_vehicles = [];
  level.cluster_spawners = [];
  level.grouped_modules = [];
  level.requested_spawners = [];
  level.wave_spawner_overrides = [];
  level.spawn_scoring_pois = [];
  level.aitype_override = [];
  level.aitype_override_weights = [];
  level.aitype_override_cumulative_weight = 0;
  level.can_kill_off_list = [];
  level.cover_node_spawners_override = [];
  level.cover_node_spawners_override_id = 0;
  level.spawn_module_structs_memory = [];
  level.hideallunselectedextractpads = [];
  level.show_active_modules = 0;
  level.stack_patch_waittill_leaf = [];
  level._id_13648 = [];
  level._id_133BD = 0;
  level.wasexecuted = [];
  scripts\cp\cp_skits::setup_spawn_skits();
  scripts\cp\cp_vehicles::vehicle_ai_spawn_funcs();
  level init_passive_wave_struct();
}

setup_aitypes_array() {
  level.aitypes = [];
  level.random_aitype_list = ["_encstr_AD07034A38", "_encstr_BE1904DCDA9D", "_encstr_A65B084B38A76BEFC350"];
  scripts\cp\cp_spawning_util::init_airlock("_encstr_834B1B586CE87BE4FAD8B7739DACE4475991FA9DB234966C1BACAF8596");
  var_0 = ["_encstr_A3DA28463CEBC6E037BE6D2CD6C2FA1BB0B1637BEAA3F55893B67B272B23F5E683C277E6B4B976D71381", "_encstr_B1DA289BF9A83270601E34BE70D8978A1F79233F9B65B959B0A02D426988CF436FFBC7430B80E22FDA23"];
  var_1 = ["_encstr_99402E4AC8B7DEC393589B8969F9B76673C05272D88999AB6BB89685682333EA87804ADB215F8AF7A31069B61C6E9E22", "_encstr_AF402E2520C728279B175818BB57EF9B41822380D858E81A3360080F89C84B7AA783C9B521D3EB11C7CEF475C1591528"];
  var_2 = ["_encstr_A3682CBCEB3E5FD22F390AA2C063410751590C3F85A3675F2DF0123B699F02970935B7BB9FA9BFA5CB80BA51F231", "_encstr_8A682C191EFA3607E6AFDA16ADB0BE8D851B8DBDD58EFAB29B59D6977DB917BA5832FAE68385BB379637D9AF1903", "_encstr_88682CD830B9E638130792C932018FF053EC92172D7D5F2D037B0AB9B08F69733E48AFFB5BD2830D44CB62A00B79", "_encstr_8A802CE048D98FD343AFB8DB4FA7408EE68BD5D733E597BDD8B0BBF720538783CB426F70F786DC78C81B0A50CFB2", "_encstr_8F802CA58B3981A043DEF01FA3FEAF7EF024619253BB37154009F1923FA3EAA37040766373A0E8BD106A8709DAE2", "_encstr_92802CACFB2E4FA25F496AB29B7751F741693C2F959377AF3DE0620B798F12E739C587CBAF598FB5DB90CA61F221"];
  var_3 = ["_encstr_A91D2B09B869A08F7F59C8B1420FD0683E3491E75D0BF9DA0FB241395BDBF78013AF3751F1B33893BBAA5EAB67", "_encstr_871D2B23C37D36386EFA6D58D60BAFC658D863DB57A3AF9AEAD9CECAE4E6C2AB47EBB9071677B95AE69DEB190C", "_encstr_83BD2B2C7BAECF22DFC9EA3280F7D177C1E9BCAF1513F7EC8B70424A903596671BD82B48A71B6BF45558C9076A", "_encstr_83BD2B2C7BAECF22DFC9EA3280F7D177C1E9BCAF1513F7EC8B70424A903596671BD82B48A71B6BF45558C9076A"];
  var_4 = ["_encstr_B6DD27191EF536C16ED7B60B5BC27D1B2CC6D8BDAE8EAFE6CD5A1CCA27AFDC0E58DDB9D2CDCED7260C", "_encstr_ABDD277A3290CF5AD0EF3301B378A907272872327BDD87D250EB200D65616A135FE3CADAA03CCF5A7A", "_encstr_A5DD27461ED7361C9BAFAD0BB558EB6CB06336BDEA477D37DC4B0E2B39BEE61C2C77E64BCDD9EB6606", "_encstr_BD7227AC393116136E3622FA9B4677CE28E92C3F8BD0515798E8DBA243888F427077D6B12520E9A69F", "_encstr_977227C063312FE33FA7C9B763D7CEF7668A38102B931FDB7389CFBD5A3F3399CEC3A0B8F2EFE73B62", "_encstr_A672276D181F0989B2811888BB4A1FC13FA4E1508DDBF6D7DDCAF0A083693FFB974778DBFE2F3E9F12"];
  var_5 = ["_encstr_B1222F0F2BA72A504BD19FBF28610752B34995451529219B5358A7E778D9CF8A17519E7F7ED7BBC0F9409BEF737197E741", "_encstr_A6222F13406EEB8B773844FE197B31B3F1884BB7B0A31F6383CB4EF4F52B097AD838FB07203E8B1B83DC15ECE8C7C1528B", "_encstr_84742FC887F5C6E0B9D736859BDC7DB12C36C6DBABA3BECD572D1BB48CACFA26DBAD315927AFDC1CC2EEDC96E6B3AF130C", "_encstr_A50F2271E05F18363A6FDBC3EEC1066039BEFBA84DC641FB1237F9FBF30AD880C5528383", "_encstr_A67A225A12B0AFBE308F59312DA9C2FFC7E9D33258F0A7F478FF4421B950413B75A33B6B", "_encstr_A5D122D94807406E5217B39B4E79AE88D16643F0356EE913CA9F81532BE260F87DBA2BEB", "_encstr_991E22C81E7DD898D87D2CC5687D39CA85C61D5AB7B97D43F69B47D2D859D7895D276E47", "_encstr_A2742F233CD76CC16ED7C6B0DCB9D71BC21BB17B5D47AFB957A5D896C8B2BE267BD6269539EBDCC158BB73B4B9ECBE9106"];
  register_aitype_setup("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A1C91E665198571380E39B8FCBBB0993603E5AEBCB69EA3BE48FBFDB256F93DC", undefined, ::set_juggernaut_flags, undefined, var_3);
  register_aitype_setup("_encstr_995808C258811FE66019", "_encstr_AC3625586CE8BD27F55673595BF2FAD838FA93D5CD7D8CCA3756C9E8EB589CBEB3DED84B85D1A1", undefined, ::select_patrol_nine_spawners, undefined, var_2);
  register_aitype_setup("_encstr_872A0E8992D3EB504B38F7915D7690AB", "_encstr_AC3625586CE8BD27F55673595BF2FAD838FA93D5CD7D8CCA3756C9E8EB589CBEB3DED84B85D1A1", undefined, ::select_patrol_nine_spawners, undefined, var_0);
  register_aitype_setup("_encstr_816D0C1C9FD16B8F642B11D0A047", "_encstr_86272621EE43D70BC92038D94D4A094EEFC1D2C7C67784E133F2A2F888D3099798DFA7594410447B", undefined, undefined, undefined, var_2);
  register_aitype_setup("_encstr_BE1904DCDA9D", "_encstr_86CC1E10E9ABBA652999B67722CBD79F28E9929A775F31559FC13BACE603E901", undefined, ::circleorigin, undefined, undefined);
  register_aitype_setup("_encstr_B8820A402D5749305DC20B91", "_encstr_AFDB1E161B477B9CBE95E6956B2FAF1BC1EB93579BF519AC6ECA393AAF6E6BD9", undefined, ::calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("_encstr_AD07034A38", "_encstr_82581D851BD1BD93D79573B26B2FF51B83FA0BC6B8BE91AC372B4E1DD7B09C", undefined, ::circleorigin, undefined, var_2);
  register_aitype_setup("_encstr_823A0903B269F80537CB8A", "_encstr_B2582058D81DDB4E7DB2CDB25B5EF5360EF59C5DE6D7C8ACCD95C91D7D8593EB2CB5", undefined, ::calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("_encstr_82350FC293FA4356C2D9CB7DD858DC2BC9", "_encstr_841526F157304D5330094AE2107BAF0668477A6DCFC157F7CE2183FB3E5FC3F148B7DFCC03785FE3", undefined, ::calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("_encstr_A65B084B38A76BEFC350", "_encstr_A278229E76213AA23EF05B7F98D25722C1806655E7CFC2FDC3E81323F14B28AA9124EB4D", undefined, ::circleorigin, undefined, undefined);
  register_aitype_setup("_encstr_84980E96FB45432F2D8D01C0E57AE08F", "_encstr_B801227E96C1DA42DE10FBDF38723742612002F3066FA29D6308F38391EBC84A31444BAD", undefined, ::calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("_encstr_8EF60E63FBE3D70440A312175B98CF6B", "_encstr_8CAD21EF70E31F53C7CD1DD7215359DBCB29674388FE4C6AB7D5E28BAF0D126D511093", ::suicide_bomber_combat_func, ::cp_suicidebomber_init, undefined, var_5);
  register_aitype_setup("_encstr_B1E1149BAEB4C69623B289DEB6C4B227D7D05658ECCB", "_encstr_8CAD21EF70E31F53C7CD1DD7215359DBCB29674388FE4C6AB7D5E28BAF0D126D511093", ::suicide_bomber_combat_func, ::cp_suicidebomber_init, undefined, var_5);
  register_aitype_setup("_encstr_A11904E483B3", "_encstr_88CC1E33F6A127C3F7ED20D505CB490991AF4FBDA33FB1C78B33C53B89DD57D0", undefined, undefined, undefined, undefined);
  register_aitype_setup("_encstr_8B100A4E1C3BFA342B16672F", "_encstr_88CC1E33F6A127C3F7ED20D505CB490991AF4FBDA33FB1C78B33C53B89DD57D0", undefined, undefined, undefined, undefined);
  register_aitype_setup("_encstr_A5450BC280BF4B604068C33187", "_encstr_959B1EC2D847DE9CAFACE6ACDAE57DC6387D39BA6EF53996BD3ADC864B561B32", undefined, undefined, undefined, var_0);
  register_aitype_setup("_encstr_9685119CB4BDA36EA14BCAD846AF0D5685B3E5", "_encstr_959B1EC2D847DE9CAFACE6ACDAE57DC6387D39BA6EF53996BD3ADC864B561B32", undefined, undefined, undefined, var_0);
  register_aitype_setup("_encstr_850707F7E5833355B8", "_encstr_9B702158B147ED27AF56B92BB5BCBE3638F52CC62EAF1956E695C9E8D7CDE696C1AC93", undefined, undefined, undefined, var_4);
  register_aitype_setup("_encstr_9BB50D5780F739921A3F6A90FF4389", "_encstr_9B702158B147ED27AF56B92BB5BCBE3638F52CC62EAF1956E695C9E8D7CDE696C1AC93", undefined, undefined, undefined, var_0);
  register_aitype_setup("_encstr_9A190463ADB3", "_encstr_81CB1E0E39F03F6BE88B83A7F3A3E16B780686D59351FCD2D6938BFBAFC10AA7", undefined, undefined, undefined, undefined);
  register_aitype_setup("_encstr_975F0A8AFB473F790F1F0BF0", "_encstr_8ADB1E0B8D3AEDE4AF569BACB62F7DC683F54EBAE6AF2395CD59E4E87DD8B5CE", undefined, ::calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("_encstr_82F80BEB201803D4431089B2D0", "_encstr_AC5114CAB1E55F7A113B9665D3D8C99B8CAE72721B35", undefined, ::circleorigin, undefined, var_2);
  register_aitype_setup("_encstr_8F270B1005542B0B6909095FE8", "_encstr_834B1B586CE87BE4FAD8B7739DACE4475991FA9DB234966C1BACAF8596", undefined, ::circleorigin, undefined, undefined);
  register_aitype_setup("_encstr_B1190448CD80", "_encstr_87142137EB5B607541CAD08062E077B923AF4F39514FC993B2D2081039BEE5F69B2E4D", undefined, undefined, undefined, undefined);
  register_aitype_setup("_encstr_B8B4080BD8D82FEBC293", "_encstr_8BFE1672095DD7F289BBECE463617E731063EB3A91A0A7AA", undefined, ::circleorigin, undefined, undefined);
  register_aitype_setup("_encstr_A7F20F7F6744835F7383EF9E453F0175D8", "_encstr_BAFA20C21B47F6277DB27359D6F27D8D837DB08D5CBE462BCD5693D1F51BE47BEE8C", ::test_combat_func, undefined, undefined, var_0);
  register_aitype_setup("_encstr_83B406EB700BCB1F", "_encstr_923B2B9FDF2DE262F1A965AF402887FA870F6B4767C01A2DA8B19AF33EB0D271D4979BAF2BFD22DFC09B54FBD3", undefined, undefined, undefined, undefined);
  register_aitype_setup("_encstr_B4CB11453F52B638F54A134EB4D758F5CA7733", "_encstr_AAA11F9F53E3D8DDE9522830CBB1B773F7FA1001AA0341E70BD9432043936B2977", undefined, ::circleorigin, undefined, undefined);
  register_aitype_setup("_encstr_A66906287A77A33B", "_encstr_B1A31F0B1B8EF6397D581BD8CBFAB1C17D34569CF6D73416912D93D7AE9398C273", undefined, ::circleorigin, undefined, undefined);
  register_aitype_setup("_encstr_8AD70AE42511BD4079879B40", "_encstr_9B702158B147ED27AF56B92BB5BCBE3638F52CC62EAF1956E695C9E8D7CDE696C1AC93", undefined, ::setup_informant, undefined, undefined);
  register_aitype_setup("_encstr_A54D0BDF020F99BBA25280082A", "_encstr_AB661FDDF53AB34A3FD7D0B18B4D439F525F4E554A830FB1FA0F6048E77DD93F0A", undefined, ::calloutmarkerpingvohandlerpool, undefined, var_2);
  register_aitype_setup("_encstr_91FC0C59351AD789019738408F53", "_encstr_8CB220ED0EF7C89BB942F879ABCB47462BAD6E558ADBF6E91D2A89B0B26203D9DF5B", undefined, ::calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("_encstr_B4BC0C4E1CCEAF9DC2CDB60BB9B5", "_encstr_924020BB1E376BDB1F6A5BA663EF96D90F6D1F23AADB49A64B02B6A93ADF41D062CB", undefined, undefined, undefined, undefined);
  register_aitype_setup("_encstr_AAC910DC86B7E876AB9BD73B58CDD6C2DCB5", "_encstr_A3C32456CD95D6977D6C38D7E45DDCEB8CB26E5993477D371AF6E83BAE37EBECC2B9B685B9B5", undefined, ::calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("_encstr_8F710CE6B5CEFACE2CCDB585CDD6", "_encstr_BE3920AC7356B6CBEBD838F593576EEBC82B6E95391DD76ED676EB9D2C9B5BC2DCD6", undefined, ::calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("_encstr_88630F7B389B5AD773985749A6B88F2227", "_encstr_9103237A836A2B89714878FF9B1377A14FC7783B5D6391F80543537DBAD9C22F7FA526C3F3", undefined, undefined, undefined, var_4);
}

cp_suicidebomber_init() {
  self.bombercanexplodebehindtarget = 1;
  self.bomberusegrenade = 0;
  self.combatmode = "_encstr_821109FAE81117DA568730";
  self.suicidebomberchants = 0;
  thread killcam_timescalefactor();
}

killcam_timescalefactor() {
  self endon("_encstr_AD75063D571AE108");
  waitframe();

  if(istrue(level.creategulagloadoutarry))
    self enabletraversals(1, "_encstr_958C08CDDBD8325A959C");
  else
    self enabletraversals(0, "_encstr_958C08CDDBD8325A959C");
}

mousetrapsfound() {
  level.creategulagloadoutarry = 1;
}

set_juggernaut_flags() {
  self.disablegrenaderesponse = 1;
  self.meleechargedistvsplayer = getdvarint("_encstr_8C0421E61BE4AFA9EAB39DAFB6CA63595968D0B0C9CEB2444BB91D956E821B585E2B39", self.meleechargedistvsplayer);
  self.meleechargedist = getdvarint("_encstr_88E11997B6D3472348372C890545D95B911B38194E1C83D3E0FB5C", self.meleechargedist);
  self.meleestopattackdistsq = squared(getdvarint("_encstr_A3591FBE6BC3E6C54B6A18D1E26791F9F7234538D0B74B31B6324011DABA69F77F", sqrt(self.meleestopattackdistsq)));
  self.meleedamageoverride = getdvarint("_encstr_BD731DBB0F58197B6D319219584DBB4F08B9213DA348DFA79469FBD32015D7", self.meleedamageoverride);
  self.attackeraccuracy = getdvarint("_encstr_84831AA2CE6571E223A807DFA03BB4DA1F52AF9AA7EF0A252B701F4F", self.attackeraccuracy);
  self.juggernautwalkdist = getdvarint("_encstr_A5281C3B4E3AC1A4284F6271CC65B9BAA7DA583670D35FD0AD10BBDB9B43", self.juggernautwalkdist);
  self.minpaindamage = getdvarint("_encstr_8B4517FBA1F6AF4C702F8FAF2348955B9718A21049C10F4798", self.minpaindamage);
  self.maxhealth = getdvarint("_encstr_A21013F7FF0EC15A80C9C7C1A008806A6D13736371", self.maxhealth);
  self.health = self.maxhealth;
  self.immune_to_melee_damage = 1;
  self.recent_player_attackers = [];
  self allowedstances("_encstr_A5AD069B231F0BAF");
  self setscriptablepartstate("_encstr_A1DF0C39FD1FDB67CBA0B3E030D3", "_encstr_813F06832D8A18FE", 1);
  self sethitlocdamagetable("_encstr_956E134B5361A1E0C3BC803B69ACB86CAB7FCDC1BF");

  if(getdvarint("_encstr_A9C816FF7B8AE93ADF72111EAA476EC026DC6B2FF0361070", 1))
    scripts\engine\utility::disable_pain();

  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0] setplayermusicstate("_encstr_9B03144F77D1D2ABE76911ABFD69D8B3E17F3E2B7E28");

  thread pain_threshold_watcher();
  thread jugg_music();
}

jugg_music() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0 linkTo(self);
  wait 0.1;
  var_0 setModel("_encstr_AB4A161B1859DFEA25F0968BE557C3634350EBEB40111CD2");
  scripts\engine\utility::_id_143A6("_encstr_88B00FB037873113F3557705AB596B58EC", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_AD75063D571AE108");
  var_0 delete();
}

pain_threshold_watcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = get_jugg_minpaindamage();
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2);
    var_3 = level.players.size;

    if(isDefined(var_2) && var_2 scripts\cp\utility::is_valid_player() && var_3 > 0) {
      self.recent_player_attackers[var_2.name] = 1;
      thread remove_player_from_attacker_list(var_2);
      var_4 = getdvarint("_encstr_BE38186E1B27AF53AED9B3F50B468CEBE0632CE5B29CD7ADF646", 75);
      var_5 = self.recent_player_attackers.size;
      var_6 = int(max(1, var_0 * (var_3 / var_5) - (var_5 - 1) * var_4));
      self.minpaindamage = var_6;
    }
  }
}

remove_player_from_attacker_list(var_0) {
  var_0 notify("_encstr_857621F6971A170BA5C730C827E1216581FF6EF06DD1D3739C57A0F81F02BEE18A22E5");
  var_0 endon("_encstr_857621F6971A170BA5C730C827E1216581FF6EF06DD1D3739C57A0F81F02BEE18A22E5");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self.recent_player_attackers[var_0.name] = 1;
  wait(getdvarfloat("_encstr_8614153BA9A3BFDDE06794F75AEA7085F16BE1DE12880B", 0.5));
  self.recent_player_attackers[var_0.name] = undefined;

  if(self.recent_player_attackers.size < 1)
    self.minpaindamage = get_jugg_minpaindamage();
}

get_jugg_minpaindamage() {
  return getdvarint("_encstr_8B4517FBA1F6AF4C702F8FAF2348955B9718A21049C10F4798", 200);
}

unset_ai_events() {
  set_dont_enter_combat_flag();
}

test_combat_func() {
  var_0 = 1;
}

register_aitype_setup(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.agent_type = var_1;
  var_6.combat_func = var_2;
  var_6.spawn_func = var_3;
  var_6.info_func = var_4;
  var_6._id_135F3 = var_5;
  level.wasexecuted[var_0] = -99999;
  level.aitypes[var_0] = var_6;
}

get_aitype_settings() {
  var_0 = undefined;

  if(isDefined(var_0))
    self.post_spawn_ai_funcs[self.post_spawn_ai_funcs.size] = var_0;
}

get_aitypes_from_spawner() {
  var_0 = [];

  if(!isDefined(self.script_noteworthy))
    return level.random_aitype_list;
  else {
    var_1 = strtok(self.script_noteworthy, "_encstr_974C0246");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(isDefined(level.aitypes[var_3]))
        var_0[var_0.size] = var_3;
    }

    if(var_0.size > 0)
      return var_0;
    else
      return level.random_aitype_list;
  }
}

init_enemy_type_tracking() {
  level.spawned_enemy_types["_encstr_958C08CDDBD8325A959C"] = 0;
  level.spawned_enemy_types["_encstr_842408C29CB6DB392B32"] = 0;
  level.spawned_enemy_types["_encstr_8C710F56607DE7252963A0BB2BC85F5AB8"] = 0;
  level.spawned_enemy_types["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"] = 0;
  level.allowed_enemy_types["_encstr_958C08CDDBD8325A959C"] = 99;
  level.allowed_enemy_types["_encstr_842408C29CB6DB392B32"] = 20;
  level.allowed_enemy_types["_encstr_8C710F56607DE7252963A0BB2BC85F5AB8"] = 5;
  level.allowed_enemy_types["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"] = 1;
  level.heavy_chance = 0;
  level.elite_chance = 0;

  if(isDefined(level.enemy_info_table)) {
    init_floor_enemy_info_table();
    update_floor_enemy_info(0);
  }
}

init_floor_enemy_info_table(var_0) {
  if(!isDefined(var_0))
    var_0 = "_encstr_84C51A5628066B73599D80BE6079DBC7D0A221F9F362D5A7F272C080";

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = spawnStruct();
    var_3.index = int(var_2);
    var_3.floor_num = int(tablelookup(var_0, 0, var_2, 1));
    var_3.group_name = tablelookup(var_0, 0, var_2, 2);
    var_3.max_in_group = int(tablelookup(var_0, 0, var_2, 3));
    var_3.min_heavy = int(tablelookup(var_0, 0, var_2, 4));
    var_3.max_heavy = int(tablelookup(var_0, 0, var_2, 5));
    var_3.heavy_chance = int(tablelookup(var_0, 0, var_2, 6));
    var_3.allowed_light = tablelookup(var_0, 0, var_2, 7);
    var_3.allowed_heavy = tablelookup(var_0, 0, var_2, 8);
    var_3.min_elite = int(tablelookup(var_0, 0, var_2, 9));
    var_3.max_elite = int(tablelookup(var_0, 0, var_2, 10));
    var_3.elite_chance = int(tablelookup(var_0, 0, var_2, 11));
    var_3.allowed_elite = tablelookup(var_0, 0, var_2, 12);
    var_4 = strtok(var_3.allowed_light, "_encstr_964C0249");
    var_3.allowed_light = var_4;
    var_4 = strtok(var_3.allowed_heavy, "_encstr_964C0249");
    var_3.allowed_heavy = var_4;
    var_4 = strtok(var_3.allowed_elite, "_encstr_964C0249");
    var_3.allowed_elite = var_4;
    level.enemyinfotabledata[var_3.floor_num][var_3.group_name] = var_3;
    var_1++;
  }
}

update_floor_enemy_info(var_0) {
  level.spawned_enemy_types["_encstr_958C08CDDBD8325A959C"] = 0;
  level.spawned_enemy_types["_encstr_842408C29CB6DB392B32"] = 0;
  level.spawned_enemy_types["_encstr_8C710F56607DE7252963A0BB2BC85F5AB8"] = 0;
  level.spawned_enemy_types["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"] = 0;
  level.allowed_enemy_types["_encstr_958C08CDDBD8325A959C"] = 0;
  level.allowed_enemy_types["_encstr_842408C29CB6DB392B32"] = 0;
  level.allowed_enemy_types["_encstr_8C710F56607DE7252963A0BB2BC85F5AB8"] = 0;
  level.allowed_enemy_types["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"] = 0;
  var_1 = "_encstr_BA7708A895703BB8818A";
  var_2 = level.enemyinfotabledata[var_0][var_1].allowed_light;
  var_3 = 99;

  foreach(var_5 in var_2)
  level.allowed_enemy_types[var_5] = var_3;

  level.heavy_chance = level.enemyinfotabledata[var_0][var_1].heavy_chance;

  if(level.heavy_chance > 0) {
    var_2 = level.enemyinfotabledata[var_0][var_1].allowed_heavy;
    var_3 = level.enemyinfotabledata[var_0][var_1].max_heavy;

    foreach(var_5 in var_2)
    level.allowed_enemy_types[var_5] = var_3;
  }

  level.elite_chance = level.enemyinfotabledata[var_0][var_1].elite_chance;

  if(level.elite_chance > 0) {
    var_2 = level.enemyinfotabledata[var_0][var_1].allowed_elite;
    var_3 = level.enemyinfotabledata[var_0][var_1].max_elite;

    foreach(var_5 in var_2)
    level.allowed_enemy_types[var_5] = var_3;
  }
}

init_trigger_spawn_groups() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  register_trigger_func("_encstr_9AE11195D5ED17608BA72B20878890FB137BBF", ::trigger_run_spawn_module, ::register_triggered_module);
  register_trigger_func("_encstr_88F01927D573BEE6C1B0DDE6D76BED19BA1B59FAD8BDED0796E6B3", ::trigger_run_module_once, ::register_triggered_looping_module);
  register_trigger_func("_encstr_88761A3AA338999F6F71138A9EC9378F0869A58F33809FBF18681B22", ::trigger_run_module_once, ::register_triggered_infinite_module);
  register_trigger_func("_encstr_91231E023816D62F3BA8FB1E0979AD48FB691DC00C1C0DB25F035CA93BCADD4B", ::trigger_run_module_once, ::register_triggered_timeout_module);
  register_trigger_func("_encstr_A6271639BADCBE9BC12CBBCDBEB6DE46BAD82BFAB196371D", ::trigger_choose_func_from_list, ::register_triggered_timeout_module);
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  var_0 = getEntArray("_encstr_99CA0EDAB78CBA36ACEB57C13258A395", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target) && isDefined(var_2.script_function)) {
      [[run_triggered_module_registration(var_2.script_function)]](var_2);
      var_2 thread run_script_func_when_triggered(var_2);
    }
  }

  scripts\engine\utility::flag_set("_encstr_B6691C8E4EA5B3EC5627FAD6BDC8AB6356DCBE96E6D28E96B0D84B4F59C8");
}

run_triggered_module_registration(var_0) {
  if(isDefined(level.trigger_spawn_module_func[var_0]))
    return level.trigger_spawn_module_func[var_0];
  else
    return::register_triggered_module;
}

register_triggered_timeout_module(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.script_count), int(var_0.script_count), undefined);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_0.script_count_min), int(var_0.script_count_min), 0);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_0.script_count_max), int(var_0.script_count_max), var_1.size);
  registerambientgroup(var_0.target, var_3, var_4, var_2, [::wait_time_from_active_count, 0.25, 5, 0.8], undefined, var_0.target, undefined, var_0.target, 30);
  set_spawn_scoring_params_for_group(var_0.target, undefined, undefined, var_0.script_maxdist, undefined);
}

watch_for_players(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    return;
  }
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.group))
    self.group endon("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

  var_1 = define_var_if_undefined(var_1, 562500);
  var_2 = define_var_if_undefined(var_2, 45);
  var_4 = define_var_if_undefined(var_4, 2.5);
  var_5 = 0;

  for(;;) {
    self waittill("_encstr_A9980CD206D783ADA12A30A07283", var_6);

    if(isDefined(var_6) && isPlayer(var_6)) {
      if(var_6 scripts\cp\utility::is_valid_player() && !istrue(var_6.ignoreme)) {
        if(scripts\engine\trace::can_see_origin(var_6 getEye(), 0)) {
          wait(var_4);
          var_7 = distancesquared(self.origin, var_6.origin);

          if(isDefined(var_3)) {
            if(var_7 <= var_3) {
              self.group scripts\engine\utility::ent_flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
              level notify("_encstr_B1F613170377C3AFC8DB797E90B8EBCADDA92FE7ED");
            } else if(var_7 <= var_1) {
              if(!var_5) {
                var_5 = 1;
                set_demeanor_from_unittype("_encstr_85BB067A08A3FAB3");
              }
            }
          } else if(var_7 <= var_1) {
            self.group scripts\engine\utility::ent_flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
            level notify("_encstr_B1F613170377C3AFC8DB797E90B8EBCADDA92FE7ED");
          }
        }
      }
    }
  }
}

set_script_count_on_spawns(var_0, var_1, var_2, var_3) {
  var_4 = getarraykeys(level.active_spawn_module_structs);

  for(var_5 = 0; var_5 < level.active_spawn_module_structs.size; var_5++) {
    var_6 = level.active_spawn_module_structs[var_4[var_5]];

    if(isarray(var_6)) {
      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];

        if(var_8.group_name != var_0) {
          var_9 = process_module_var(var_8, var_8.spawn_points);

          for(var_10 = 0; var_10 < var_9.size; var_10++) {
            var_8.spawn_points[var_10].script_count = 1;
            var_8.spawn_points[var_10].script_timeout = undefined;
          }
        }
      }

      continue;
    }

    if(var_6.group_name != var_0) {
      for(var_10 = 0; var_10 < var_6.spawn_points.size; var_10++) {
        var_6.spawn_points[var_10].script_count = 1;
        var_6.spawn_points[var_10].script_timeout = undefined;
      }
    }
  }
}

wait_random_time(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && isDefined(var_2))
    wait(randomfloatrange(var_1, var_2));
  else if(isDefined(var_2))
    wait(var_2);
  else if(isDefined(var_1))
    wait(var_1);
  else
    wait 0.25;
}

wait_time_from_active_count(var_0, var_1, var_2, var_3) {
  var_4 = var_0.activecount;
  var_5 = process_module_var(var_0, var_0.max_size);

  if(var_4 / var_5 >= var_3)
    return var_2;
  else
    return var_1;
}

register_triggered_infinite_module(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  registerambientgroup(var_0.target, 0, var_1.size, undefined, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  set_spawn_scoring_params_for_group(var_0.target, undefined, undefined, var_0.script_maxdist, undefined);
}

register_triggered_looping_module(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  registerambientgroup(var_0.target, 0, var_1.size, var_1.size, 0.25, ::wait_for_all_group_dead, var_0.target, undefined, var_0.target, undefined);
  set_spawn_scoring_params_for_group(var_0.target, undefined, undefined, var_0.script_maxdist, undefined);
}

register_triggered_module(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  registerambientgroup(var_0.target, 0, var_1.size, var_1.size, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  set_spawn_scoring_params_for_group(var_0.target, undefined, undefined, var_0.script_maxdist, undefined);
}

register_triggered_module_maze_jugg(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  registerambientgroup(var_0.target, 0, var_1.size, var_1.size, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  register_module_ai_spawn_func(var_0.target, scripts\cp\cp_spawning_util::disable_juggernaut_move_behavior);
  register_module_ai_spawn_func(var_0.target, scripts\cp\cp_spawning_util::disable_cover_node_behavior);
  register_module_ai_spawn_func(var_0.target, ::watch_for_players);
  register_module_weapons_free_func(var_0.target, scripts\cp\cp_spawning_util::enable_juggernaut_move_behavior);
}

register_trigger_func(var_0, var_1, var_2) {
  if(!isDefined(level.trigger_spawn_func))
    level.trigger_spawn_func = [];

  if(!isDefined(level.trigger_spawn_module_func))
    level.trigger_spawn_module_func = [];

  level.trigger_spawn_func[var_0] = var_1;
  level.trigger_spawn_module_func[var_0] = var_2;
}

run_script_func_when_triggered(var_0) {
  var_0 notify("_encstr_A5AA1F8B0398CF6AA025A1A03119772F3079D14348E5D3A9304DA9BF3F20BAD76D");
  var_0 endon("_encstr_A5AA1F8B0398CF6AA025A1A03119772F3079D14348E5D3A9304DA9BF3F20BAD76D");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 scripts\engine\utility::thread_on_notify("_encstr_A103102396DC164C36CAAF3A4EB49DB35993", scripts\engine\utility::trigger_off);

  if(!isDefined(level.trigger_spawn_func)) {
    var_0 notify("_encstr_A103102396DC164C36CAAF3A4EB49DB35993");
    return;
  }

  if(!isDefined(level.trigger_spawn_func[var_0.script_function])) {
    var_0 notify("_encstr_A103102396DC164C36CAAF3A4EB49DB35993");
    return;
  }

  var_1 = level.trigger_spawn_func[var_0.script_function];

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isPlayer(var_2))
      [[var_1]](var_0, var_2);
  }
}

isentignoredbyme(var_0, var_1) {
  if(!isagent(var_0))
    return 0;

  if(istrue(var_1.ignoreme))
    return 1;

  var_2 = var_0 getthreatbiasgroup();
  var_3 = var_1 getthreatbiasgroup();

  if(isDefined(level.ignoremegroups) && isDefined(level.ignoremegroups[var_3])) {
    if(scripts\engine\utility::array_contains(level.ignoremegroups[var_3], var_2))
      return 1;
    else
      return 0;
  } else
    return 0;
}

debug_kill_soldier(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 scripts\engine\utility::enable_pain();
  var_0 animmode("_encstr_820E07FAE8780B3A4C");
  var_0 set_goal_radius(32);
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 notify("_encstr_BA22087EA808525BA5D9");
  var_0 notify("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_0.nocorpse = undefined;
  var_0.scripted_mode = 0;
  var_0.entered_combat = 1;

  if(isDefined(var_0.spawnpoint.target)) {
    var_1 = scripts\engine\utility::getStruct(var_0.spawnpoint.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_0 set_goal_pos(var_1.origin);
  }

  var_0 scripts\engine\utility::_id_143A5("_encstr_A3130D9AF069D2310E87C1D9C03A82", "_encstr_8B7205D9ED5958");
  wait 2;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "_encstr_AB590C99ED78875F650F3951034D");
}

spawn_soldier_scripted(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    var_4 = var_1;
  else
    var_4 = choose_spawnpoint(var_0);

  var_0.respawning = undefined;

  if(!isDefined(var_4)) {
    var_0 change_module_status(undefined, "_encstr_A21F0BE86F39C908B7EFB8EB6B");
    return 0;
  }

  if(istrue(var_0._id_133BE))
    return 1;

  return spawn_soldier_scripted_internal(var_0, var_4, 0, undefined, var_2, var_3);
}

_id_13BAC(var_0, var_1) {
  var_1 = define_var_if_undefined(var_1, 1);
  var_0._id_133BE = var_1;
}

spawn_soldier_scripted_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_3 = undefined;

  if(isDefined(var_1.pos_override_struct)) {
    var_7 = var_1.pos_override_struct.origin;
    var_8 = var_1.pos_override_struct.angles;
  } else if(isDefined(var_1.vehicle_position)) {
    var_7 = var_1.origin;
    var_8 = var_1.angles;
  }

  if(isDefined(var_1.specs)) {
    if(!isarray(var_1.specs))
      var_1.specs = [var_1.specs];

    var_3 = scripts\engine\utility::random(var_1.specs);
    var_6 = var_3;
  }

  var_9 = var_1 spawn_ai(var_7, var_8, var_3, var_0);

  if(isDefined(var_9)) {
    if(isDefined(var_0.cargo_truck_mg_init)) {
      if(isDefined(level.players[var_0.cargo_truck_mg_init])) {
        level.players[var_0.cargo_truck_mg_init].cargo_truck_mg_gunnerdamagemodignorefunc++;
        var_9.cargo_truck_mg_initdamage = level.players[var_0.cargo_truck_mg_init];
      }
    }

    var_0 change_module_status(undefined, "_encstr_97EE0C19B7EA731910A0CE957347");
    var_1 notify("_encstr_91940E4B73CF5F1D7177EDC36F986207", var_1);
    level notify("_encstr_A3DD1637382CEEDC56C8EBEC27DEAB83AFCD7B63C84B569C", var_9);
    level notify("_encstr_924F14C296F5DC0E85DDCDF537571B8DCAB9E666D51B", var_9, var_1, var_1.origin, var_0);
    return run_ai_post_spawn_init(var_0, var_9, var_1, var_4, var_6, var_2, var_5);
  } else {
    var_0 change_module_status(undefined, "_encstr_950D0EC5577E2DD82FBFF736898783F4");
    var_1 notify("_encstr_8BFA0DEB2BA09F80C7F84F31527508", var_1);
    var_1.aitype = undefined;

    if(istrue(var_5))
      return undefined;
    else
      return 0;
  }
}

run_ai_post_spawn_init(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 set_default_values(undefined, var_2, var_3, var_0);
  var_1 node_fields_pre_goal(var_2);

  if(isDefined(var_0) && var_0 scripts\cp\cp_spawning_util::module_disables_spawners_until_owner_death())
    var_1 thread scripts\cp\cp_spawning_util::disable_spawner_until_owner_death(var_2);

  copy_to_soldier_from_spawn_point(var_2, var_1);
  var_1 _id_12DDC(undefined, var_2, var_3, var_0);
  var_2 set_default_spawner_values();
  var_1 scripts\cp\cp_squadmanager::addtosquad();
  var_2 run_spawner_post_spawn_actions(var_0);
  var_1 run_ai_post_spawn_actions();
  var_1 run_aitype_spawn_func();

  if(isDefined(var_2.specs) && isDefined(var_4)) {
    if(scripts\engine\utility::array_contains(var_2.specs, var_4)) {
      var_2.specs = scripts\engine\utility::array_remove(var_2.specs, var_4);

      if(var_2.specs.size < 1)
        var_2.specs = undefined;
    }
  }

  var_7 = undefined;

  if(isDefined(var_2.script_animation_type)) {
    if(!isDefined(var_0) || !var_0 scripts\engine\utility::ent_flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0")) {
      var_8 = strtok(var_2.script_animation_type, "_encstr_964C0249");
      var_7 = scripts\engine\utility::random(var_8);
    }
  }

  if(isDefined(var_2.script_function)) {
    if(isDefined(level.spawner_script_funcs[var_2.script_function]) && isDefined(var_2.ai_infil_type))
      var_1[[level.spawner_script_funcs[var_2.script_function].script_function]](var_0, var_2, var_2.ai_infil_type);
  } else if(isDefined(var_7) && isDefined(level.spawn_skits[var_7])) {
    var_1 thread enter_combat_after_stealth();
    var_1 thread[[level.spawn_skits[var_7].skit_func]]();
  } else if(var_1 is_door_spawn()) {
    if(istrue(var_5))
      var_1 thread agent_use_door_spawner(var_2.doors[0], var_1, var_2.doors, var_2.doors[0].origin, var_2.doors[0].angles, ::debug_kill_soldier, var_2);
    else
      var_1 thread agent_use_door_spawner(var_2.doors[0], var_1, var_2.doors, var_2.doors[0].origin, var_2.doors[0].angles, undefined, var_2);
  } else {
    scripts\engine\utility::delaythread(5, ::unset_used_recently, var_2);

    if(var_1 is_patroller() || var_1 is_pacifist()) {
      if(!isDefined(var_0) || !var_0 scripts\engine\utility::ent_flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0")) {
        if(!isDefined(var_2.script_demeanor)) {
          if(is_specified_unittype("_encstr_83E8094727E333E8F9CE50"))
            var_1 set_demeanor_from_unittype("_encstr_84A70683D6FED826");
          else if(is_specified_unittype("_encstr_8BFC0BC2CBD4F737E0A5E1FD79")) {
            if(var_1.spawnpoint _id_13655(512))
              var_1 scripts\cp\cp_spawning_util::disable_juggernaut_move_behavior(var_0);
          } else if(nullweapon(var_1.primaryweapon))
            var_1 set_demeanor_from_unittype("_encstr_96080730D8534E0A28");
          else
            var_1 set_demeanor_from_unittype("_encstr_96080730D8534E0A28");
        }

        var_1 thread start_patrol();
      } else
        var_1 thread enter_combat();
    } else if(isDefined(var_2.target))
      var_1 thread enter_combat_after_go_to_node();
    else
      var_1 thread enter_combat();
  }

  var_2.aitype = undefined;

  if(istrue(var_6))
    return var_1;
  else
    return 1;
}

run_aitype_spawn_func() {
  if(isDefined(self.aitype) && isDefined(level.aitypes[self.aitype]) && isDefined(level.aitypes[self.aitype].spawn_func))
    self thread[[level.aitypes[self.aitype].spawn_func]]();

  if(_id_132C7())
    thread loschecktime(self.aitype);
}

_id_132C7() {
  var_0 = istrue(self.pacifist) || istrue(self.ignoreme) || istrue(self.ignoreall) || isDefined(level.global_stealth_broken) && !istrue(level.global_stealth_broken) || istrue(level.announcer_vo_playing) || istrue(level._id_135F4) || istrue(level.validatealivecount) || istrue(level._id_139B5);
  return !var_0;
}

loschecktime(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(level.wasexecuted[var_0] + 60000 > gettime()) {
    return;
  }
  if(isDefined(level.aitypes[var_0]) && isDefined(level.aitypes[var_0]._id_135F3)) {
    var_1 = level.aitypes[var_0]._id_135F3;
    level._id_135F4 = 1;

    if(isarray(var_1)) {
      var_2 = scripts\engine\utility::random(var_1);
      level scripts\cp\cp_vo::try_to_play_vo_on_team(var_2, "_encstr_9A8507BA4040188D08");
    } else
      level scripts\cp\cp_vo::try_to_play_vo_on_team(var_1, "_encstr_9A8507BA4040188D08");

    level.wasexecuted[var_0] = gettime();
    level._id_135F4 = 0;
  }
}

set_demeanor_from_unittype(var_0) {
  var_0 = _id_140C4(var_0);

  if(is_specified_unittype("_encstr_83E8094727E333E8F9CE50"))
    scripts\asm\asm_bb::bb_setcivilianstate(var_0);
  else if(!is_specified_unittype("_encstr_8BFC0BC2CBD4F737E0A5E1FD79"))
    scripts\common\utility::demeanor_override(var_0);
}

_id_140C4(var_0) {
  switch (var_0) {
    case "_encstr_8AEE0B360BE6578563AFCEBACD":
    case "_encstr_914B078DB09BAB0BB1":
      return "_encstr_96080730D8534E0A28";
    default:
      return var_0;
  }
}

give_soldier_armor() {
  if(!issubstr(self.agent_type, "_encstr_A73D07EF53B65AE710") && !is_juggernaut_aitype()) {}

  self.wearing_armor = 1;
}

_id_12BF1() {
  self.wearing_armor = undefined;
}

give_soldier_helmet() {
  if(!issubstr(self.agent_type, "_encstr_82FC08E118A5AB4508C1") && !is_juggernaut_aitype()) {}

  self.wearing_helmet = 1;
}

set_character_models(var_0, var_1, var_2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  if(isDefined(var_0))
    self setModel(var_0);

  if(isDefined(var_1)) {
    self attach(var_1, "_encstr_B40101", 1);
    self.headmodel = var_1;
  }
}

watch_for_bad_path() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0;
  var_1 = 0;
  wait 5;

  for(;;) {
    self waittill("_encstr_86E5092BA829F7AB738DA4", var_2);

    if(getdvarint("_encstr_AA8B1D8EEE138FA141EF1013BB651E2DCAD71097C6CBA98E338B080B4BADB3", 0)) {
      break;
    }

    if(!has_never_kill_off_flag()) {
      var_3 = gettime();

      if(var_3 - var_1 > 5000) {
        var_0 = 0;
        var_1 = var_3;
      } else {
        var_0++;
        var_1 = var_3;

        if(var_0 >= 10) {
          if(passed_kill_off_time_checks(gettime()))
            teleport_to_nearby_spawner("_encstr_B69E0942C3200E4BBF9B9A", var_2);
        }

        wait 0.5;
      }
    }
  }
}

watch_for_ai_events() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self notify("_encstr_B25A14BBB92BA28C8F06E7BB4011D027DBB3BD185313");
  self endon("_encstr_B25A14BBB92BA28C8F06E7BB4011D027DBB3BD185313");

  for(;;) {
    self waittill("_encstr_B4580A0740984DFBF2C57BEB", var_0);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1];

      if(has_func_for_aievent(var_2.type))
        run_aievent_func(var_2.type, var_0);

      switch (var_2.type) {
        case "_encstr_8A21128393F64D2BB13A4B1BB2F55AD60E85C61D":
        case "_encstr_928E112F37025EA89FEB168B577948992A9B93":
        case "_encstr_AA300EBF415D43B0F85A6159731058AB":
        case "_encstr_92FD082A30066B713094":
        case "_encstr_A5490D5E05C3F8B363F3C8D83B3E43":
        case "_encstr_860808CB78E2984063BA":
          var_3 = 1;

          if(scripts\cp\coop_stealth::_id_132D7())
            var_3 = !isDefined(self.stealth);

          if(var_3)
            thread enter_combat();

          break;
        default:
          break;
      }
    }
  }
}

register_aievent_func_for_group(var_0, var_1, var_2) {
  if(isDefined(level.ambientgroups[var_0]) && isarray(level.ambientgroups[var_0])) {
    for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
      if(!isDefined(level.ambientgroups[var_0][var_3].aievent_funcs))
        level.ambientgroups[var_0][var_3].aievent_funcs = [];

      level.ambientgroups[var_0][var_3].aievent_funcs[var_1] = var_2;
    }
  } else {
    if(!isDefined(level.ambientgroups[var_0].aievent_funcs))
      level.ambientgroups[var_0].aievent_funcs = [];

    level.ambientgroups[var_0].aievent_funcs[var_1] = var_2;
  }
}

has_func_for_aievent(var_0) {
  if(isDefined(self.group.aievent_funcs) && isDefined(self.group.aievent_funcs[var_0]) && isbuiltinfunction(self.group.aievent_funcs[var_0]))
    return 1;
  else
    return 0;
}

run_aievent_func(var_0, var_1) {
  self thread[[self.group.aievent_funcs[var_0]]](var_0, var_1);
}

get_nervous(var_0, var_1) {
  if(!isDefined(self.nervousness))
    self.nervousness = 0;

  thread increment_and_decay_nervousness();
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    switch (var_4.type) {
      case "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C":
        if(self.nervousness >= randomintrange(15, 45)) {
          self.nervousness = undefined;
          thread enter_combat();
          return;
        }

        var_2 = ["_encstr_8C632695DE57C939AC10322758DD5AB93B01588EE8CAE6E8D2F673041DF601F2DEABE4CDAC36CCB8"];
        break;
      case "_encstr_875A127BB2F7D340FA3F9B993BE99013D35AD163":
        var_2 = ["_encstr_877A2289590C3053EE13A32B32D27F01226B7EC3ED4878D8C2A3A3AF55A631529FAA174A", "_encstr_866A0694EAC8568B", "_encstr_8C632695DE57C939AC10322758DD5AB93B01588EE8CAE6E8D2F673041DF601F2DEABE4CDAC36CCB8", "_encstr_92C60B0D2C366B80327BDDCD90"];

        if(self.nervousness >= randomintrange(5, 15)) {
          self.nervousness = undefined;
          thread enter_combat();
          return;
        }

        break;
    }

    if(isDefined(var_2) && isDefined(var_4.entity) && isPlayer(var_4.entity)) {
      var_4.entity thread apply_and_remove_attention_flag();
      var_4.entity give_message_to_player(scripts\engine\utility::random(var_2));
    }
  }
}

give_message_to_player(var_0) {
  if(!isDefined(self.next_hint_time) || gettime() > self.next_hint_time) {
    self.next_hint_time = gettime() + randomintrange(3, 5) * 1000;
    self iprintlnbold(var_0);
  }
}

apply_and_remove_attention_flag() {
  self notify("_encstr_BE6A2097B78038E03761CD70C108EB156DBDBDDE695BEB93CDACF41DF32E9199A047");
  self endon("_encstr_BE6A2097B78038E03761CD70C108EB156DBDBDDE695BEB93CDACF41DF32E9199A047");
  self.has_drawn_attention_recently = 1;
  wait 5;
  self.has_drawn_attention_recently = undefined;
}

increment_and_decay_nervousness() {
  self notify("_encstr_B1742067B0A9BA9A0B6545FB403BE274F608AFC75042DF7263864B35BDC7DA3D1B08");
  self endon("_encstr_B1742067B0A9BA9A0B6545FB403BE274F608AFC75042DF7263864B35BDC7DA3D1B08");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self.nervousness++;
  wait 5;
  self.nervousness--;
}

attempt_to_give_info(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(var_3.type) && var_3.type == "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C")
      var_4 = ["_encstr_8C632695DE57C939AC10322758DD5AB93B01588EE8CAE6E8D2F673041DF601F2DEABE4CDAC36CCB8"];
    else
      var_4 = ["_encstr_BD6415F4AA664EF2338D233DB95D80BF2796285953FF28", "_encstr_B68B20125601D016E60237BD026EB12B56B3B2B9807BDC01A1D2CD04E686A54ED1B8", "_encstr_838A1293EFC657A9C61F38923BE918A35E138638", "_encstr_AD981421AC9C3701BB95589C2DDC3B0413F6DB3ADC5C", "_encstr_A7022E38FDD7E7AA324ADB50C09F9B484B50245A7B16BDADAF3D4F4B49A72B6D130D204F86A090A76B49D0082A14E2DD", "_encstr_A7FA1442B240B52C2F0458471D588DB610377BDE9B17", "_encstr_AF451E9FA34DE34FDAE5414BF6F62A09A3CA5FE8DF55B90F1D0D468BF132BB82", "_encstr_AF451E9FA34DE34FDAE5414BF6F62A09A3CA5FE8DF55B90F1D0D468BF132BB82", "_encstr_AF451E9FA34DE34FDAE5414BF6F62A09A3CA5FE8DF55B90F1D0D468BF132BB82"];

    if(isDefined(var_3.entity) && isPlayer(var_3.entity))
      var_3.entity give_message_to_player(scripts\engine\utility::random(var_4));
  }
}

copy_to_soldier_from_spawn_point(var_0, var_1) {
  var_1.spawnpoint = var_0;

  if(!istrue(var_0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint()))
    var_1.target = var_0.target;

  var_1.script_squadname = var_0.script_squadname;
  var_1.script_stealthgroup = var_0.script_stealthgroup;
  var_1.script_demeanor_post = var_0.script_demeanor_post;
  var_1.script_goalheight = var_0.script_goalheight;
  var_1.script_radius = var_0.script_radius;
  var_1.dontkilloff = var_0.dontkilloff;
  var_1.script_patroller = var_0.script_patroller;
  var_1.equip_helmet = var_0.equip_helmet;
  var_1.is_on_platform = var_0.is_on_platform;
  var_1.door_spawner = var_0.door_spawner;
  var_1.dont_enter_combat = var_0.dont_enter_combat;
  var_1.script_origin_other = var_0.script_origin_other;
  var_1.aitype = var_0.aitype;

  if(isDefined(var_0.script_enemyselector))
    var_1.script_enemyselector = var_0.script_enemyselector;

  if(isDefined(var_0.script_goalvolume))
    var_1.script_goalvolume = getEnt(var_0.script_goalvolume, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

unset_used_recently(var_0) {
  if(isDefined(var_0))
    var_0.used_recently = undefined;
}

choose_spawnpoint(var_0, var_1, var_2) {
  if(isDefined(var_0.vehicle))
    return var_0.vehicle.spawn_point find_spawn_loc_from_vehicle_spawner(var_0);

  if(istrue(var_1))
    var_0.respawning = 1;

  var_3 = var_0 process_module_var(var_0, var_0.spawn_points);
  var_4 = var_0 scripts\cp\cp_spawner_scoring::score_ai_spawns(var_3, var_1, undefined, var_2);
  var_0._id_127ED = undefined;
  var_0 scripts\cp\cp_spawner_scoring::_id_12891(var_4);

  if(!isDefined(var_4))
    return undefined;

  if(istrue(var_4 scripts\cp\cp_vehicles::is_vehicle_spawnpoint()))
    return var_4 find_spawn_loc_from_vehicle_spawner(var_0);
  else if(isDefined(var_4.script_reuse_max)) {
    var_4.script_reuse_max = int(var_4.script_reuse_max);

    if(!isDefined(var_4.count))
      var_4.count = 1;
    else {
      var_4.count = int(var_4.count);
      var_4.count++;
    }

    if(var_4.count >= var_4.script_reuse_max) {
      var_4.used_recently = 1;
      var_4 thread reset_spawn_vars(var_4);
    }
  } else
    var_4.used_recently = 1;

  return var_4;
}

find_spawn_loc_from_vehicle_spawner(var_0) {
  if(!isDefined(self.vehicle)) {
    if(!spawn_vehicle_at_vehicle_spawner(var_0))
      return undefined;
  }

  if(isDefined(self.vehicle) && self.vehicle scripts\common\vehicle_aianim::vehicle_hasavailablespots()) {
    level notify("_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501", var_0, self.vehicle);
    var_0 notify("_encstr_9B7610EBFB1BBA4B40B1C1D20BF087026501", var_0, self.vehicle);

    if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup))
      return get_near_vehicle_spawner();
    else {
      self.pos_override_struct = self.vehicle;
      return self;
    }
  } else
    return undefined;
}

get_near_vehicle_spawner() {
  var_0 = scripts\engine\utility::getStructArray(self.veh_spawn_point.script_vehiclegroup, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] == self.veh_spawn_point) {
      continue;
    }
    if(!istrue(var_0[var_1].disabled)) {
      self.pos_override_struct = var_0[var_1];
      var_0[var_1].disabled = 1;
      return self;
    }
  }

  return undefined;
}

spawn_vehicle_at_vehicle_spawner(var_0) {
  if(!isDefined(self.script_function))
    return 0;

  if(has_vehicle_type_exceeded_module_cap(var_0, self.script_function))
    return 0;

  if([[level.ai_spawn_vehicle_func[self.script_function].vehicle_spawn_func]](var_0, self, self.script_function)) {
    if(isDefined(var_0.vehicle)) {
      var_0.vehicle _id_14206(var_0.vehicle);
      var_0.vehicle thread _id_14187(var_0.vehicle);
    }

    return 1;
  } else
    return 0;
}

_id_14206(var_0) {
  level._id_11CA7[var_0 getentitynumber()] = var_0;
}

_id_14187(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0 getentitynumber();
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0.vehiclename))
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(var_0);

  level._id_11CA7[var_1] = undefined;
}

set_last_spawn_time() {}

get_last_spawn_time() {}

disable_spawn_point(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 > 0) {
    var_0 little_bird_mg_givetakegunnerturrettimeout();

    if(isDefined(var_2))
      var_2.longer_spawn_delay = 1;

    wait(var_1);

    if(isDefined(var_2))
      var_2.longer_spawn_delay = 0;

    var_0 mounted();
  } else
    var_0 little_bird_mg_givetakegunnerturrettimeout();
}

spawn_is_vehicle_spawn(var_0) {
  if(!isnode(var_0) && isDefined(var_0.spawnflags)) {
    var_1 = int(var_0.spawnflags);
    var_2 = 16;
    var_3 = 8;
    var_4 = 512;

    if(var_1 &var_2) {
      var_0 define_spawner("_encstr_847610EC5686D2C63659AFCD8358DD37AC39");
      var_0 remove_from_spawner_flags(8);
      var_0 add_to_spawner_flags(16);

      if(!isDefined(var_0.script_function))
        var_0.script_function = "_encstr_A3351CC84AC5A988DF2FC446E747506161A3F8A062DEC1813F2B5737D703";
    }

    if(var_1 &var_3) {
      var_0 define_spawner("_encstr_847610EC5686D2C63659AFCD8358DD37AC39");
      var_0 add_to_spawner_flags(8);
      var_0 remove_from_spawner_flags(16);
      var_0.script_goalyaw = 1;

      if(!isDefined(var_0.script_function))
        var_0.script_function = "_encstr_83C5194E0B7323EDADFAB0D227EBB395D02DD836B2EBCDC1C2DD73";

      level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = var_0;
      level.all_air_vehicle_spawn_points[level.all_air_vehicle_spawn_points.size] = var_0;

      if(!(var_1 & 32))
        var_0.heli_path_func = scripts\cp\cp_vehicles::create_heli_path;
    }

    if((var_0 spawner_flags_check(16) || var_0 spawner_flags_check(8)) && var_1 &var_4) {
      var_0.veh_model_spawner = 1;
      var_0.dontgetonpath = 1;
    }

    if(var_1 &var_3 || var_1 &var_2) {
      return 1;
      return;
    }

    return undefined;
    return;
  } else
    return undefined;
}

barkov_execution_path(var_0) {
  if(isDefined(self.spawnflags)) {
    if(!_id_13655(var_0))
      self.spawnflags = self.spawnflags + var_0;
  } else
    self.spawnflags = var_0;
}

_id_12BD2(var_0) {
  if(isDefined(self.spawnflags) && self.spawnflags &var_0)
    self.spawnflags = self.spawnflags - var_0;
}

define_spawner(var_0) {
  switch (var_0) {
    case "_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E":
      define_as_cluster_spawner();
      break;
    case "_encstr_847610EC5686D2C63659AFCD8358DD37AC39":
      define_as_vehicle_spawner();
      break;
  }
}

_id_13655(var_0) {
  return isDefined(self.spawnflags) && self.spawnflags &var_0;
}

spawner_flags_check(var_0) {
  return isDefined(self.spawner_flags) && self.spawner_flags &var_0;
}

add_to_spawner_flags(var_0) {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(var_0))
      self.spawner_flags = self.spawner_flags + var_0;
  } else
    self.spawner_flags = var_0;
}

remove_from_spawner_flags(var_0) {
  if(isDefined(self.spawner_flags) && self.spawner_flags &var_0)
    self.spawner_flags = self.spawner_flags - var_0;
}

_id_12BC9() {
  if(isDefined(self.spawnpoint) && isstruct(self.spawnpoint)) {
    if(isDefined(self.spawnpoint.spawnflags) && self.spawnpoint.spawnflags & 1024)
      self.spawnpoint.spawnflags = self.spawnpoint.spawnflags - 1024;
  }
}

define_as_cluster_spawner() {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(4))
      self.spawner_flags = self.spawner_flags + 4;
  } else
    self.spawner_flags = 4;
}

define_as_vehicle_spawner() {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(2))
      self.spawner_flags = self.spawner_flags + 2;
  } else
    self.spawner_flags = 2;
}

reset_spawn_vars(var_0) {}

returnzeroifundefined(var_0) {
  if(isDefined(var_0))
    return var_0;
  else
    return 0;
}

returnblankfuncifundefined(var_0) {
  if(isDefined(var_0))
    return var_0;
  else
    return::blankmodulefunc;
}

blankmodulefunc(var_0, var_1, var_2, var_3, var_4, var_5) {}

registerambientgroup(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_11 = strtok(var_0, "_encstr_874C029E");

  if(var_11.size > 1)
    var_10.group_name = var_11[1];
  else
    var_10.group_name = var_0;

  var_10.min_size = returnzeroifundefined(var_1);
  var_10.max_size = returnzeroifundefined(var_2);
  var_10.time_between_spawns = returnzeroifundefined(var_4);
  var_10.post_module_delay = returnzeroifundefined(var_5);
  var_10.activecount = 0;
  var_10.spawn_count = 0;
  var_10.ai_spawned = [];
  var_10.module_vehicles = [];
  var_10._id_11CB0 = 0;
  var_10._id_13BE5 = 0;
  var_10.cqb_module = 0;
  var_10.debug_struct = var_10 create_module_debug_struct();

  if(isDefined(var_6)) {
    if(isbuiltinfunction(var_6))
      var_10.spawn_points = var_6;
    else if(isarray(var_6)) {
      foreach(var_13 in var_6)
      var_10.spawn_points = scripts\engine\utility::array_combine(var_10.spawn_points, scripts\engine\utility::getStructArray(var_13, "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

      for(var_15 = 0; var_15 < var_10.spawn_points.size; var_15++) {
        var_16 = var_10.spawn_points[var_15];
        var_16 thread spawner_init();
      }

      var_10.spawn_points = [::return_spawners_by_targetname, var_6];
    } else {
      var_10.spawn_points = scripts\engine\utility::getStructArray(var_6, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      foreach(var_16 in var_10.spawn_points)
      var_16 thread spawner_init();
    }
  }

  var_10.totalspawns = returnzeroifundefined(var_3);
  var_10.start_func = returnblankfuncifundefined(var_7);
  var_10.nextgroup = var_8;
  var_10.timeout_action = var_9;
  var_10.currentmodulekills = 0;
  var_10.currentmoduledeaths = 0;
  var_10.set_chosen_spawner_from_uid = ["_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", "_encstr_BA730BF8AFF178988293F158B9", "_encstr_92A70ABB8267F5E0D89F6351", "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", "_encstr_8823119675DAFF897F878020BB99612B219D8F", "_encstr_B8D30758E3EE7827BA"];
  var_10.serverroomrewardroll = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];

  if(isDefined(level.ambientgroups[var_10.group_name])) {
    if(isarray(level.ambientgroups[var_10.group_name])) {
      var_19 = [];

      foreach(var_21 in level.ambientgroups[var_10.group_name])
      var_19 = scripts\engine\utility::array_add(var_19, var_21);

      var_19 = scripts\engine\utility::array_add(var_19, var_10);
      level.ambientgroups[var_10.group_name] = var_19;
    } else {
      var_23 = level.ambientgroups[var_10.group_name];
      level.ambientgroups[var_10.group_name] = [var_10, var_23];
    }

    var_10.moduleid = level.module_group_id;
    level.module_group_id++;
  } else {
    var_10.moduleid = level.module_group_id;
    level.module_group_id++;
    level.ambientgroups[var_10.group_name] = var_10;
  }

  var_24 = "_encstr_841804471897" + var_0 + "_encstr_8D4C02E8" + level.ambientgroups.size;
  var_25 = "_encstr_AD103D59F513B03D278919C022DA5E59220891C39ABBE8A2629698617873079105A44B59053681CF57DB4870D297C22A8E77695FBCCEF0157A1060D94B5315" + var_24 + "_encstr_A7D2301104229B59E808E6B19CAF199513EAD9BE9B0E2CEE73D2B9EC106E070BDDE6D75B7B8CAEC6957D6C432CE6B3950813" + var_10.group_name + "_encstr_8A17044A7724";
  scripts\cp\utility::addentrytodevgui(var_25);
  var_25 = "_encstr_92FE3C1AB01EE94B4BBF99622BE13E6588F1286755C8DAB21786C07761FF7E931F8CA0EAED97C15727AF4DE3A071C5B219AD0E6A34AF487093B739DB1DB8" + var_24 + "_encstr_92072F321F49C75FE9FAC3DA7067D757F91DFFD7CE6BD7E3F5581A92CA578BC753904D6FED132B2FEF3082CAC04707B2C1" + var_10.group_name + "_encstr_8A17044A7724";
  scripts\cp\utility::addentrytodevgui(var_25);
}

return_spawners_by_targetname(var_0, var_1) {
  if(!isarray(var_1))
    var_1 = [var_1];
  else {
    var_2 = [];

    for(var_3 = 0; var_3 < var_1.size; var_3++)
      var_2[var_2.size] = var_1[var_3];

    var_1 = var_2;
  }

  var_4 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_4 = scripts\engine\utility::array_combine(var_4, scripts\engine\utility::getStructArray(var_1[var_3], "_encstr_B2CE0BA1D0FB19FDC54613D9BF"));

  return var_4;
}

delay_start_specified_module() {
  if(getDvar("_encstr_B2501458F7F878853F4C9B2B3B41F35B2E8F862CD0D7", "_encstr_B40101") != "_encstr_B40101") {
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
    scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
    wait 2;
    var_0 = run_spawn_module(getDvar("_encstr_B2501458F7F878853F4C9B2B3B41F35B2E8F862CD0D7", "_encstr_B40101"));
  }
}

delay_start_cover_node_spawning() {
  if(getdvarint("_encstr_921F18B98D9C7DD8DECE56C9AF73ED2356FA6E1C85DD73A5373B", 0)) {
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
    scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
    wait 2;
    var_0 = run_spawn_module("_encstr_819214D165B6E8FE396B07297F01468879FBF868CD0F");
    run_func_on_group_by_groupname("_encstr_819214D165B6E8FE396B07297F01468879FBF868CD0F", [::override_spawn_scoring_for_module_struct, undefined, undefined, 10000, undefined]);
    run_func_on_group_by_groupname("_encstr_819214D165B6E8FE396B07297F01468879FBF868CD0F", [::toggle_always_attempt_killoff, 1]);
  }
}

delay_start_wave_spawning() {
  if(getdvarint("_encstr_828D129B2E8A014412D3DBA7EF2B87F83E04A091", 0)) {
    scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
    scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
    scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
    scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
    wait 2;
    var_0 = run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  }
}

init_spawnpoints_from_cover_nodes() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_wait("_encstr_A65211EB562BA098E71253B95ABB589043B525");
  scripts\engine\utility::flag_wait("_encstr_A2D20FE4880D52A426C867576878654BD3");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\cp\coop_stealth::coop_stealth_init();
  registerambientgroup("_encstr_A9EF0C953059113ADFF3F98FC9D9", 0, ::get_max_agent_count, undefined, 0.05, undefined, undefined, undefined, undefined, undefined);
  registerambientgroup("_encstr_859E1A0FAA628FC349FB30E9C770D9073A94881C49CA97A80FEB9878", 0, 24, undefined, 0.1, undefined, "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined);
  set_spawn_scoring_params_for_group("_encstr_859E1A0FAA628FC349FB30E9C770D9073A94881C49CA97A80FEB9878", 1250, 2000, 5000, 1);
  register_module_ai_spawn_func("_encstr_859E1A0FAA628FC349FB30E9C770D9073A94881C49CA97A80FEB9878", ::set_pre_wave_spawning_spawn_funcs);
  register_module_weapons_free_func("_encstr_859E1A0FAA628FC349FB30E9C770D9073A94881C49CA97A80FEB9878", ::pre_wave_weapons_free);
  registerambientgroup("_encstr_B602128722EA075BD17388615FF8519F820C7084", 0, 24, undefined, 0.1, ::unset_pre_wave_spawning, ::return_cover_spawners, ::init_pre_wave_spawning, "_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  set_spawn_scoring_params_for_group("_encstr_B602128722EA075BD17388615FF8519F820C7084", 750, 2000, 5000, 1);
  register_module_ai_spawn_func("_encstr_B602128722EA075BD17388615FF8519F820C7084", ::set_pre_wave_spawning_spawn_funcs);
  registerambientgroup("_encstr_819214D165B6E8FE396B07297F01468879FBF868CD0F", [::get_ambient_min_count, 0], [::get_ambient_max_count, 24], undefined, ::module_wave_spawn, undefined, ::return_cover_spawners, ::wait_for_spawners_created);
  register_module_as_passive("_encstr_819214D165B6E8FE396B07297F01468879FBF868CD0F");
  set_spawn_scoring_params_for_group("_encstr_819214D165B6E8FE396B07297F01468879FBF868CD0F", 750, 2000, 5000, 1);
  level thread delay_start_cover_node_spawning();
  level thread delay_start_wave_spawning();
  var_0 = scripts\engine\utility::getStructArray("_encstr_8D4513EF80E3E78B1F0DB809E1EFEF31135262FBF6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = get_all_nodes();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2].script_index = undefined;
    var_3 = isDefined(var_1[var_2].spawnflags) && var_1[var_2].spawnflags & 16384;
    var_4 = var_1[var_2].type == "_encstr_8BDD061F03D82763";

    if(var_4 || var_3)
      var_1[var_2] disconnectnode();
  }

  if(var_0.size < 1) {
    var_5 = 0;
    var_6 = [];
    var_7 = 0;

    for(;;) {
      var_5++;
      var_8 = var_1[0];
      var_9 = [];
      var_6[var_6.size] = var_8;

      if(var_1.size > 1) {
        for(var_10 = 0; var_10 < var_1.size; var_10++) {
          var_11 = var_1[var_10];
          var_11.script_index = undefined;

          if(var_8 == var_11) {
            continue;
          }
          if(isDefined(var_11.classname) && var_11.classname == "_encstr_81D70DCDED23B2F556E183DB9BB28C") {
            continue;
          }
          var_9[var_9.size] = var_11;
        }

        var_1 = var_9;
        var_6 = var_9;
        break;
      } else
        break;
    }

    var_1 = undefined;
    var_0 = split_array_into_quadrants(var_6);
    var_6 = undefined;
  }

  for(var_10 = 0; var_10 < var_0.size; var_10++) {
    var_0[var_10] define_spawner("_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E");
    var_0[var_10] thread spawner_init();
    var_0[var_10] init_cluster_parent();
    var_0[var_10].child_spawners = undefined;
  }

  level.cover_node_spawners = var_0;
  scripts\engine\utility::flag_set("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");
}

get_all_nodes() {
  return getallnodes();
}

attempt_throttle(var_0) {
  var_0++;

  if(var_0 % 2000 == 0)
    waitframe();

  return var_0;
}

return_cover_spawners(var_0) {
  if(istrue(var_0.use_only_veh_spawners))
    return [];

  if(isDefined(var_0.cover_node_spawners_override) && var_0.cover_node_spawners_override.size > 0) {
    var_1 = [];
    var_2 = getarraykeys(var_0.cover_node_spawners_override);

    for(var_3 = 0; var_3 < var_0.cover_node_spawners_override.size; var_3++)
      var_1 = scripts\engine\utility::array_combine(var_1, var_0.cover_node_spawners_override[var_2[var_3]]);

    if(var_1.size > 0)
      return var_1;
  } else if(isDefined(var_0.wave_spawner_overrides) && var_0.wave_spawner_overrides.size > 0) {
    var_1 = [];

    for(var_3 = 0; var_3 < var_0.wave_spawner_overrides.size; var_3++) {
      var_4 = scripts\engine\utility::getStructArray(var_0.wave_spawner_overrides[var_3], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_1 = scripts\engine\utility::array_combine(var_1, var_4);
    }

    if(var_1.size > 0)
      return var_1;
  } else if(isDefined(var_0.requested_spawners) && var_0.requested_spawners.size > 0) {
    var_1 = [];

    for(var_3 = 0; var_3 < var_0.requested_spawners.size; var_3++) {
      var_4 = scripts\engine\utility::getStructArray(var_0.requested_spawners[var_3], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_1 = scripts\engine\utility::array_combine(var_1, var_4);
    }

    if(var_1.size > 0) {
      if(isDefined(level.cover_node_spawners))
        return scripts\engine\utility::array_combine(level.cover_node_spawners, var_1);
      else
        return var_1;
    } else if(isDefined(level.cover_node_spawners))
      return level.cover_node_spawners;
    else
      return [];
  }

  if(isDefined(level.cover_node_spawners))
    return level.cover_node_spawners;
  else
    return [];
}

use_cover_node_spawners_around_pos(var_0) {
  scripts\engine\utility::flag_wait("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");

  if(isDefined(self.cover_node_spawners)) {
    var_1 = scripts\engine\utility::get_array_of_closest(var_0, self.cover_node_spawners, undefined, 5, undefined, undefined);
    self.cover_node_spawners_override[self.cover_node_spawners_override_id] = var_1;
    var_2 = self.cover_node_spawners_override_id;
    self.cover_node_spawners_override_id++;
    return var_2;
  } else
    return undefined;
}

remove_cover_node_spawners_around_pos_with_id(var_0) {
  if(isDefined(self.cover_node_spawners_override[var_0]))
    self.cover_node_spawners_override[var_0] = undefined;
}

init_wave_settings(var_0) {
  var_0.wave_reference = 1;
}

init_pre_wave_spawning(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");
  add_global_spawn_function("_encstr_8E8405EA382B2A", ::stay_passive_if_not_weapons_free);
  add_global_spawn_function("_encstr_8E8405EA382B2A", ::set_aggro_flag_on_enter_combat);
  add_global_spawn_function("_encstr_8E8405EA382B2A", ::watch_for_players, undefined, 1000000, 45);
}

unset_pre_wave_spawning(var_0) {
  remove_global_spawn_function("_encstr_8E8405EA382B2A", ::stay_passive_if_not_weapons_free);
  remove_global_spawn_function("_encstr_8E8405EA382B2A", ::set_aggro_flag_on_enter_combat);
  remove_global_spawn_function("_encstr_8E8405EA382B2A", ::watch_for_players);
}

setup_wave_vars(var_0) {
  var_0.spawn_aitype_counts = [];
}

wait_for_spawners_created(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_956B1B374F9345685FDA0339C34618067B27BBA52FDB1BC8B4B44AB12F");
}

split_array_into_quadrants(var_0) {
  if(isDefined(var_0) && var_0.size < 1)
    return [];

  var_1 = scripts\cp\utility::get_center_point_of_array(var_0);
  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = (0, 0, 0);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];

  for(var_13 = 0; var_13 < var_0.size; var_13++) {
    var_14 = var_0[var_13];
    var_15 = var_2 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(var_14.origin);
    var_16 = var_2 scripts\cp\cp_spawning_util::increase_wave_ai_spawned_counter(var_14.origin);

    if(var_15 && var_16) {
      var_3[var_3.size] = var_14;
      continue;
    }

    if(!var_15 && !var_16) {
      var_6[var_6.size] = var_14;
      continue;
    }

    if(!var_15 && var_16) {
      var_5[var_5.size] = var_14;
      continue;
    }

    if(var_15 && !var_16)
      var_4[var_4.size] = var_14;
  }

  if(isDefined(var_3)) {
    if(var_3.size > 64) {
      var_9 = split_array_into_quadrants(var_3);

      for(var_13 = 0; var_13 < var_9.size; var_13++) {
        var_17 = var_9[var_13];

        if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
          var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
          var_17.angles = (0, 0, 0);
          var_7[var_7.size] = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17.child_spawners = var_3;

      if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
        var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
        var_17.angles = (0, 0, 0);
        var_7[var_7.size] = var_17;
      }
    }
  }

  if(isDefined(var_4)) {
    if(var_4.size > 64) {
      var_10 = split_array_into_quadrants(var_4);

      for(var_13 = 0; var_13 < var_10.size; var_13++) {
        var_17 = var_10[var_13];

        if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
          var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
          var_17.angles = (0, 0, 0);
          var_7[var_7.size] = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17.child_spawners = var_4;

      if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
        var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
        var_17.angles = (0, 0, 0);
        var_7[var_7.size] = var_17;
      }
    }
  }

  if(isDefined(var_5)) {
    if(var_5.size > 64) {
      var_11 = split_array_into_quadrants(var_5);

      for(var_13 = 0; var_13 < var_11.size; var_13++) {
        var_17 = var_11[var_13];

        if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
          var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
          var_17.angles = (0, 0, 0);
          var_7[var_7.size] = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17.child_spawners = var_5;

      if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
        var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
        var_17.angles = (0, 0, 0);
        var_7[var_7.size] = var_17;
      }
    }
  }

  if(isDefined(var_6)) {
    if(var_6.size > 64) {
      var_12 = split_array_into_quadrants(var_6);

      for(var_13 = 0; var_13 < var_12.size; var_13++) {
        var_17 = var_12[var_13];

        if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
          var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
          var_17.angles = (0, 0, 0);
          var_7[var_7.size] = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17.child_spawners = var_6;

      if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
        var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
        var_17.angles = (0, 0, 0);
        var_7[var_7.size] = var_17;
      }
    }
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  return var_7;
}

assign_spawnpoints_to_parent_structs(var_0) {
  var_1 = scripts\cp\utility::get_center_point_of_array(var_0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {}
}

register_module_as_passive(var_0) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_1 = 0; var_1 < level.ambientgroups[var_0].size; var_1++)
        level.ambientgroups[var_0][var_1].is_passive = 1;
    } else
      level.ambientgroups[var_0].is_passive = 1;
  }
}

register_module_ai_spawn_func(var_0, var_1) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
        if(!isDefined(level.ambientgroups[var_0][var_2].ai_spawn_func))
          level.ambientgroups[var_0][var_2].ai_spawn_func = [];

        level.ambientgroups[var_0][var_2].ai_spawn_func[level.ambientgroups[var_0][var_2].ai_spawn_func.size] = var_1;
      }
    } else {
      if(!isDefined(level.ambientgroups[var_0].ai_spawn_func))
        level.ambientgroups[var_0].ai_spawn_func = [];

      level.ambientgroups[var_0].ai_spawn_func[level.ambientgroups[var_0].ai_spawn_func.size] = var_1;
    }
  }
}

awardbunker11blueprint(var_0, var_1) {
  if(isDefined(level.active_spawn_module_structs[var_0])) {
    if(isarray(level.active_spawn_module_structs[var_0])) {
      for(var_2 = 0; var_2 < level.active_spawn_module_structs[var_0].size; var_2++) {
        if(!isDefined(level.active_spawn_module_structs[var_0][var_2].ai_spawn_func))
          level.active_spawn_module_structs[var_0][var_2].ai_spawn_func = [];

        level.active_spawn_module_structs[var_0][var_2].ai_spawn_func[level.active_spawn_module_structs[var_0][var_2].ai_spawn_func.size] = var_1;
      }
    } else {
      if(!isDefined(level.active_spawn_module_structs[var_0].ai_spawn_func))
        level.active_spawn_module_structs[var_0].ai_spawn_func = [];

      level.active_spawn_module_structs[var_0].ai_spawn_func[level.active_spawn_module_structs[var_0].ai_spawn_func.size] = var_1;
    }
  }
}

apply_func_to_all_in_group(var_0, var_1) {
  if(isDefined(level.active_spawn_module_structs[var_0])) {
    var_2 = level.active_spawn_module_structs[var_0];

    if(isarray(var_2)) {
      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        var_4 = var_2[var_3];

        for(var_5 = 0; var_5 < var_4.ai_spawned.size; var_5++)
          var_4.ai_spawned[var_5] thread[[var_1]]();
      }
    }
  }
}

register_module_weapons_free_func(var_0, var_1) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
        if(!isDefined(level.ambientgroups[var_0][var_2].fn_weapons_free))
          level.ambientgroups[var_0][var_2].fn_weapons_free = [];

        level.ambientgroups[var_0][var_2].fn_weapons_free[level.ambientgroups[var_0][var_2].fn_weapons_free.size] = var_1;
      }
    } else {
      if(!isDefined(level.ambientgroups[var_0].fn_weapons_free))
        level.ambientgroups[var_0].fn_weapons_free = [];

      level.ambientgroups[var_0].fn_weapons_free[level.ambientgroups[var_0].fn_weapons_free.size] = var_1;
    }
  }
}

register_module_ai_death_func(var_0, var_1) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
        if(!isDefined(level.ambientgroups[var_0][var_2].ai_death_func))
          level.ambientgroups[var_0][var_2].ai_death_func = [];

        level.ambientgroups[var_0][var_2].ai_death_func[level.ambientgroups[var_0][var_2].ai_death_func.size] = var_1;
      }
    } else {
      if(!isDefined(level.ambientgroups[var_0].ai_death_func))
        level.ambientgroups[var_0].ai_death_func = [];

      level.ambientgroups[var_0].ai_death_func[level.ambientgroups[var_0].ai_death_func.size] = var_1;
    }
  }
}

register_module_run_func_after_notify(var_0, var_1, var_2) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
        if(!isDefined(level.ambientgroups[var_0][var_3].funcs_after_notifies))
          level.ambientgroups[var_0][var_3].funcs_after_notifies = [];

        level.ambientgroups[var_0][var_3].funcs_after_notifies[var_1] = var_2;
      }
    } else {
      if(!isDefined(level.ambientgroups[var_0].funcs_after_notifies))
        level.ambientgroups[var_0].funcs_after_notifies = [];

      level.ambientgroups[var_0].funcs_after_notifies[var_1] = var_2;
    }
  }
}

module_run_func_after_notify() {
  if(isDefined(self.funcs_after_notifies)) {
    self endon("_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591");
    var_0 = getarraykeys(self.funcs_after_notifies);

    for(;;) {
      var_1 = level scripts\engine\utility::waittill_any_in_array_return(var_0);
      self thread[[self.funcs_after_notifies[var_1]]]();
    }
  }
}

set_kill_off_vars(var_0, var_1, var_2) {
  var_0.kill_off_time_override = var_1;
  var_0.last_seen_time_override = var_2;
}

toggle_always_attempt_killoff(var_0, var_1) {}

module_always_attempt_killoff(var_0) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_1 = 0; var_1 < level.ambientgroups[var_0].size; var_1++)
        level.ambientgroups[var_0][var_1].always_attempt_killoff = 1;
    } else
      level.ambientgroups[var_0].always_attempt_killoff = 1;
  }
}

force_module_cqb_scoring(var_0) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_1 = 0; var_1 < level.ambientgroups[var_0].size; var_1++)
        level.ambientgroups[var_0][var_1].cqb_module = 1;
    } else
      level.ambientgroups[var_0].cqb_module = 1;
  }
}

override_spawn_scoring_for_module_struct(var_0, var_1, var_2, var_3, var_4) {
  var_0 create_spawn_scoring_struct(var_1, var_2, var_3, var_4);
}

_id_130E7(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = level.gametype;
    var_6 = strtok(var_4, "_encstr_974C0246");

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(var_6[var_7] == var_5) {
        break;
      }
    }

    return;
  }

  level.spawn_scoring_overrides = create_spawn_scoring_struct(var_0, var_1, var_2, var_3);
}

set_spawn_scoring_params_for_group(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    var_6 = level.gametype;
    var_7 = strtok(var_5, "_encstr_974C0246");

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_7[var_8] == var_6) {
        break;
      }
    }

    return;
  }

  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_8 = 0; var_8 < level.ambientgroups[var_0].size; var_8++)
        level.ambientgroups[var_0][var_8].spawn_scoring_overrides = create_spawn_scoring_struct(var_1, var_2, var_3, var_4);
    } else
      level.ambientgroups[var_0].spawn_scoring_overrides = create_spawn_scoring_struct(var_1, var_2, var_3, var_4);
  }
}

create_spawn_scoring_struct(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_0))
    var_4.close_dist = int(var_0);
  else
    var_4.close_dist = 1024;

  var_4.close_dist_sq = var_4.close_dist * var_4.close_dist;

  if(isDefined(var_1))
    var_4.far_dist = int(var_1);
  else
    var_4.far_dist = 2048;

  var_4.far_dist_sq = var_4.far_dist * var_4.far_dist;

  if(isDefined(var_2)) {
    var_4._id_13BDB = int(var_2);
    var_4.too_far_dist_sq = var_4._id_13BDB * var_4._id_13BDB;
  } else {
    var_4._id_13BDB = 4096;
    var_4.too_far_dist_sq = 16777216;
  }

  if(isDefined(var_3))
    var_4.far_score = int(var_3);
  else
    var_4.far_score = 20;

  return var_4;
}

get_spawned_ai_from_group_struct(var_0) {
  var_1 = [];

  if(isstruct(self)) {
    if(isarray(self)) {
      for(var_2 = 0; var_2 < self.size; var_2++)
        var_1 = scripts\engine\utility::array_combine(var_1, self[var_2].ai_spawned);
    } else
      var_1 = self.ai_spawned;
  } else if(isDefined(level.active_spawn_module_structs[var_0])) {
    var_3 = level.active_spawn_module_structs[var_0];

    if(isarray(var_3)) {
      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = var_3[var_4];
        var_1 = scripts\engine\utility::array_combine(var_1, var_5.ai_spawned);
      }
    } else
      var_1 = scripts\engine\utility::array_combine(var_1, var_3.ai_spawned);
  }

  return var_1;
}

make_ai_usable(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1))
    self.onuse = var_1;
  else
    self.onuse = ::follow_triggering_player;

  self.trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 30));
  self.trigger linkTo(self);
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

  if(isDefined(var_2))
    self.trigger setHintString(var_2);

  if(isDefined(var_4))
    set_goal_radius(var_4);

  if(isDefined(var_5))
    self.goalheight = var_5;

  thread scripts\engine\utility::delete_on_death(self.trigger);
  thread ai_used_think(var_3);
}

ai_used_think(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8FAE0723DEEECDCA19");
  self endon("_encstr_8A12060D5BA9C745");
  self.trigger endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(isDefined(self.onuse))
      self thread[[self.onuse]](var_1, var_0);
  }
}

follow_triggering_player(var_0, var_1) {
  self notify("_encstr_811919A12DE9732747D89BEBD0FA977396F2881727CB197FF3CBEB");
  self endon("_encstr_811919A12DE9732747D89BEBD0FA977396F2881727CB197FF3CBEB");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");

  if(isDefined(var_1))
    create_head_icon_for_ai(var_1);

  for(;;) {
    set_goal_ent(var_0);
    wait 1;
    var_0 = scripts\cp\utility::get_closest_living_player();
  }
}

create_head_icon_for_ai(var_0) {
  self.headicon = deleteheadicon(self);
  setheadiconfriendlyimage(self.headicon, var_0);
  setheadicondrawthroughgeo(self.headicon, 1);
  setheadiconsnaptoedges(self.headicon, 29000);
  setheadiconmaxdistance(self.headicon, 10);
  addclienttoheadiconmask(self.headicon, 10);
  thread remove_headicon_on_death();
}

remove_headicon_on_death() {
  if(!isDefined(self.headicon)) {
    return;
  }
  var_0 = self.headicon;
  var_1 = scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_B8D910023F20F5D3AB27F802D659C8813540");
  setheadiconimage(var_0);
}

disable_kill_off(var_0, var_1, var_2, var_3) {
  var_0.disable_kill_off = 1;
}

quarry_hacks_count(var_0) {
  if(isDefined(level.ambientgroups) && isDefined(level.ambientgroups[var_0]))
    return level.ambientgroups[var_0];
  else
    return undefined;
}

isambientspawningpaused(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(scripts\engine\utility::ent_flag_exist("_encstr_998C0C70E2AB1F517F6F36A055EB") && scripts\engine\utility::ent_flag("_encstr_998C0C70E2AB1F517F6F36A055EB")) {
    scripts\engine\utility::ent_flag_waitopen("_encstr_998C0C70E2AB1F517F6F36A055EB");
    return 1;
  }

  if(istrue(level.spawnpoint_debug))
    level waittill("_encstr_82F415A203F1B95F23668B6EC8B07C50EBB97285B0B7AA");

  if(istrue(level.ambient_spawning_paused)) {
    wait 0.25;
    return 1;
  }

  return 0;
}

allowed_to_spawn_agent(var_0, var_1, var_2, var_3) {
  var_4 = get_total_reserved_slot_count();
  var_5 = get_max_agent_count();
  var_6 = var_5 - var_4;
  var_7 = level.spawned_ai.size - level.delayed_spawn_slots;
  var_8 = var_6 - var_7;

  if(isDefined(var_0)) {
    var_9 = var_0 get_comp_count();

    if(!isDefined(var_9))
      return 0;

    var_10 = var_9 - var_0 get_activecount_from_group(1);
    var_11 = get_reserved_slot_count_by_string_id(var_3);
    var_6 = var_5 - var_4 + var_11;

    if(!istrue(var_0.kill_off_enemies)) {
      if(var_10 > 0 && var_8 > 0) {
        return 1;
        return;
      }

      return 0;
      return;
      return;
    }

    if(var_10 > 0 && var_8 > 0) {
      return 1;
      return;
    }

    if(!istrue(var_0.min_spawn_requested)) {
      var_0.min_spawn_requested = 1;
      var_0 increase_reserved_spawn_slots(1, var_0.moduleid, var_0);
    }

    var_12 = 0;

    if(!istrue(var_0.disable_kill_off)) {
      var_13 = int(abs(var_8));
      var_12 = kill_off_enemies(var_0, int(clamp(var_13, 1, var_6)), istrue(var_0.kill_off_enemies) || istrue(var_1));
    }

    if(var_12 > 0)
      wait 0.1;

    var_14 = level.spawned_ai.size - level.delayed_spawn_slots;
    var_15 = var_6 - var_14;
    return var_15;
    return;
    return;
  } else if(var_8 < 1) {
    var_13 = int(abs(var_8));
    var_12 = kill_off_enemies(undefined, int(clamp(var_13, 1, var_6)), istrue(var_1));

    if(var_12 > 0)
      wait 0.1;

    var_14 = level.spawned_ai.size - level.delayed_spawn_slots;
    var_15 = var_6 - var_14;
    return var_15;
  } else
    return var_8;
}

get_max_agent_count(var_0) {
  var_1 = getdvarint("_encstr_8E401637C69CFA19B2CCC2BAD8D1EBB516E1853B59E68EDC", 32);
  var_2 = 32;
  var_3 = getdvarint("_encstr_A99317F77392F1B1877BD901B263F55861C775430AFA180DBF", var_1);

  if(var_2 > var_1)
    return int(var_2);

  return int(clamp(var_3, var_2, var_1));
}

is_agent_in_group(var_0, var_1) {
  if(!isDefined(var_1.enemy_group))
    return 0;

  if(var_0 == var_1.enemy_group)
    return 1;

  return 0;
}

propent(var_0, var_1) {
  var_2 = var_0 project();
  var_3 = var_1 project();
  return var_2 > var_3;
}

_id_134D3() {
  if(isDefined(self.group)) {
    if(self.group.group_name != "_encstr_A1340ECC2FCBC509A733AF20B02B7DE2")
      return 1;
    else
      return 0;
  } else
    return 0;
}

project() {
  var_0 = 1073741824;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    var_4 = distancesquared(self.origin, var_3.origin);

    if(var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_0;
}

vehicle_preventplayercollisiondamagefortimeafterexit() {
  self endon("_encstr_AD75063D571AE108");
  self._id_133B6 = 1;
  self.playeriszombie = 1;
  self._id_12FC1 = 1;

  for(;;) {
    var_0 = passive_kill_off_ai(1);

    if(isDefined(var_0) && !var_0) {
      self._id_133B6 = undefined;
      self.playeriszombie = undefined;
      break;
    }

    wait 0.25;
  }
}

kill_off_enemies(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = gettime();

  if(isDefined(var_0))
    level.compare_group_name = var_0.group_name;

  if(istrue(var_2) && var_1 > var_4) {
    var_6 = getaiarray("_encstr_8E8405EA382B2A");
    var_7 = scripts\engine\utility::array_sort_with_func(var_6, ::propent);
    var_7 = scripts\cp\utility::array_sort_by_handler(var_7, ::_id_134D3);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_7[var_8] passive_kill_off_ai(1)) {
        var_4++;

        if(var_1 <= var_4)
          return var_4;
      }
    }

    var_7 = scripts\engine\utility::array_removedead(var_7);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      var_9 = var_7[var_8];

      if(var_9 has_never_kill_off_flag()) {
        continue;
      }
      if(istrue(scripts\engine\utility::script_func("_encstr_AB2F13295C5740B6E197E3CDFBABF32007B9704383", var_9))) {
        continue;
      }
      if(!isDefined(var_9) || !isalive(var_9) || var_9.health <= 0) {
        continue;
      }
      if(isDefined(var_9.team) && var_9.team == "_encstr_9A8507BA4040188D08") {
        continue;
      }
      if(isDefined(var_0) && scripts\engine\utility::is_equal(var_9.enemy_group, var_0.group_name)) {
        var_9 thread teleport_to_nearby_spawner("_encstr_A54610CFB0A28ED020419F3B857BDA89AE5E");
        continue;
      }

      var_9 script_kill_ai();
      var_4++;

      if(var_1 <= var_4)
        return var_4;
    }
  }

  return var_4;
}

passed_kill_off_time_checks(var_0) {
  if(isDefined(self.killofftime) && var_0 <= self.killofftime)
    return 0;
  else
    return 1;
}

get_see_recently_time_overrides() {
  if(isDefined(self._id_12FC1))
    return self._id_12FC1;
  else if(isDefined(self.group)) {
    if(isDefined(self.group.last_seen_time_override))
      return self.group.last_seen_time_override;
    else if(istrue(self.group.cqb_module))
      return 2;
    else
      return 6;
  } else
    return 6;
}

can_be_script_killed(var_0, var_1) {
  if(istrue(self.marked_for_death))
    return 0;

  if(has_dont_kill_off_flag())
    return 0;

  if(istrue(self.playing_skit))
    return 0;

  if(is_riding_vehicle())
    return 0;

  if(isDefined(self.killofftime) && gettime() <= self.killofftime)
    return 0;

  if(is_specified_unittype("_encstr_8BFC0BC2CBD4F737E0A5E1FD79"))
    return 0;

  if(isDefined(self.group)) {
    if(self.group get_activecount_from_group() <= process_module_var(self.group, self.group.min_size)) {
      if(!isDefined(var_0) || var_0 != self.group)
        return 0;
    }
  }

  if(var_1 && isDefined(self.enemy_group) && isDefined(var_0)) {
    if(self.enemy_group != var_0.group_name)
      return 0;
  }

  if(isDefined(self.enemy) && self canshootenemy())
    return 0;
}

dont_kill_flag() {
  return istrue(self.dontkilloff);
}

is_always_on_group() {
  if(isDefined(self.enemy_group)) {
    if(istrue(self.group.is_passive))
      return 1;
    else if(self.enemy_group == "_encstr_AAE20A695D3F40F36327BFB5")
      return 1;
    else
      return 0;
  } else
    return 0;
}

can_be_seen() {
  return istrue(self.bcansee);
}

is_bad_path() {
  return istrue(self.badpath);
}

is_same_group() {
  if(!isDefined(level.compare_group_name))
    return 1;
  else
    return isDefined(self.enemy_group) && self.enemy_group == level.compare_group_name;
}

kill_off_sort() {
  var_0 = 0;

  if(!is_riding_vehicle())
    var_0 = var_0 + 15;

  if(is_same_group())
    var_0 = var_0 + 15;

  if(!is_bad_path())
    var_0 = var_0 + 10;

  if(!is_always_on_group())
    var_0 = var_0 + 25;

  return var_0;
}

get_killoff_time() {
  if(isDefined(self.killofftime))
    return self.killofftime;
  else
    return 0;
}

watch_for_all_groups_dead(var_0, var_1) {
  level endon("_encstr_A123070F0B327D488F" + var_1 + "_encstr_A3A807379D4802F372");
  var_2 = 0;
  var_3 = [];

  foreach(var_5 in var_0) {
    thread notify_when_group_ends(var_5, var_1, var_2);
    var_3[var_3.size] = var_1 + var_2 + "_encstr_93D80BF536F6B638D8AC1D95C8";
    var_2++;
  }

  level scripts\engine\utility::waittill_all_in_array(var_3);
  level notify("_encstr_8E430EB5EDC85D36ACF59D27F6AB1C40" + var_1 + "_encstr_ACF90B31FF82C1F8ECDF033987");
}

notify_when_group_ends(var_0, var_1, var_2) {
  level endon("_encstr_A123070F0B327D488F" + var_1 + "_encstr_A3A807379D4802F372");
  var_0 waittill("_encstr_AA5E19F7B6605F9A3FE0737AD88514FBD9887B6741EB63E741B83A");
  level notify(var_1 + var_2 + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

run_spawn_module(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_97AF17C6CAD9598DEB939585235EF5CC7B397D37D84E9607E8");

  if(getdvarint("_encstr_ADC91583368209473ADFCBE3D7D19848170EE89BDEE130", 0)) {
    if(var_0 != "_encstr_AAE20A695D3F40F36327BFB5" && var_0 != "_encstr_B19C0F53C2F0080ACE95B91D80A256CD3A")
      return;
  }

  if(getdvarint("_encstr_96FB1AC7CF3EF16F8878B031D3D8BB8B1B4D07FF97675A4F50206D07", 0)) {
    if(isDefined(level.ambientgroups[var_0]) && !istrue(level.ambientgroups[var_0].is_passive))
      return;
  }

  level notify("_encstr_B2671C25E5339F1B7321CFBBF7806F55E32031518398F81D58CBB3DF4978" + var_0);
  level.active_spawn_modules[level.active_spawn_modules.size] = var_0;

  if(!isDefined(level.active_spawn_module_structs[var_0]))
    level.active_spawn_module_structs[var_0] = [];

  if(!isDefined(level.spawn_module_structs_memory[var_0]))
    level.spawn_module_structs_memory[var_0] = [];

  var_5 = create_module_struct(var_0);

  if(isDefined(var_5)) {
    if(isarray(var_5)) {
      var_5 thread watch_for_all_groups_dead(var_5, var_0);

      foreach(var_2 in var_5)
      level thread add_and_watch_group(var_2, var_0);

      foreach(var_2 in var_5)
      level thread _id_12DDA(var_2, 1);
    } else {
      level thread add_and_watch_group(var_5, var_0);
      level thread _id_12DDA(var_5, 0);
    }

    return var_5;
  }
}

add_and_watch_group(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.active_spawn_module_structs[var_1][level.active_spawn_module_structs[var_1].size] = var_0;
  level.spawn_module_structs_memory[var_1][level.spawn_module_structs_memory[var_1].size] = var_0;
  var_0 waittill("_encstr_AD75063D571AE108");

  if(var_0 get_activecount_from_group(1) < 1) {
    scripts\cp\cp_spawning_util::_id_12BD3(var_0);

    if(isDefined(level.spawn_module_structs_memory[var_0.group_name]) && scripts\engine\utility::array_contains(level.spawn_module_structs_memory[var_0.group_name], var_0)) {
      level.spawn_module_structs_memory[var_0.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[var_0.group_name], var_0);

      if(isDefined(level.spawn_module_structs_memory[var_0.group_name]) && level.spawn_module_structs_memory[var_0.group_name].size < 1)
        level.spawn_module_structs_memory[var_0.group_name] = undefined;
    }
  }

  if(scripts\engine\utility::array_contains(level.active_spawn_module_structs[var_1], var_0)) {
    level.active_spawn_module_structs[var_1] = scripts\engine\utility::array_remove(level.active_spawn_module_structs[var_1], var_0);

    if(isDefined(level.active_spawn_module_structs[var_1]) && level.active_spawn_module_structs[var_1].size < 1)
      level.active_spawn_module_structs[var_1] = undefined;
  }
}

create_module_struct(var_0) {
  var_1 = quarry_hacks_count(var_0);

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      var_2 = [];

      foreach(var_4 in var_1) {
        var_5 = copy_from_level_struct(var_4);
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
      }

      return var_2;
    } else {
      var_5 = copy_from_level_struct(var_1);
      return var_5;
    }
  }
}

copy_from_level_struct(var_0) {
  var_1 = spawnStruct();
  var_1.group_name = var_0.group_name;
  var_1.min_size = var_0.min_size;
  var_1.max_size = var_0.max_size;
  var_1.time_between_spawns = var_0.time_between_spawns;
  var_1.post_module_delay = var_0.post_module_delay;
  var_1.activecount = var_0.activecount;
  var_1.spawn_count = var_0.spawn_count;
  var_1.ai_spawned = var_0.ai_spawned;
  var_1.spawn_points = var_0.spawn_points;
  var_1.totalspawns = var_0.totalspawns;
  var_1.start_func = var_0.start_func;
  var_1.nextgroup = var_0.nextgroup;
  var_1.timeout_action = var_0.timeout_action;
  var_1.currentmodulekills = var_0.currentmodulekills;
  var_1.currentmoduledeaths = var_0.currentmoduledeaths;
  var_1.moduleid = var_0.moduleid;
  var_1.ai_spawn_func = var_0.ai_spawn_func;
  var_1.ai_death_func = var_0.ai_death_func;
  var_1.fn_weapons_free = var_0.fn_weapons_free;
  var_1.cqb_module = var_0.cqb_module;
  var_1.always_attempt_killoff = var_0.always_attempt_killoff;
  var_1.status = var_0.status;
  var_1.spawn_scoring_overrides = var_0.spawn_scoring_overrides;
  var_1.aievent_funcs = var_0.aievent_funcs;
  var_1.is_passive = var_0.is_passive;
  var_1.module_vehicles = var_0.module_vehicles;
  var_1._id_11CB0 = var_0._id_11CB0;
  var_1.disable_spawners_until_owner_death = var_0.disable_spawners_until_owner_death;
  var_1.combined_counters = var_0.combined_counters;
  var_1._id_141B3 = var_0._id_141B3;
  var_1.debug_data = var_0.debug_data;
  var_1._id_13BE5 = var_0._id_13BE5;
  var_1.set_chosen_spawner_from_uid = var_0.set_chosen_spawner_from_uid;
  var_1.serverroomrewardroll = var_0.serverroomrewardroll;
  var_1.lightsfloor02 = var_0.lightsfloor02;
  var_1.level_module_struct = var_0;
  level.requested_spawns_groups[var_1.moduleid] = 0;
  var_1 scripts\engine\utility::ent_flag_init("_encstr_998C0C70E2AB1F517F6F36A055EB");
  var_1 scripts\engine\utility::ent_flag_init("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  return var_1;
}

add_to_module_vehicles_list(var_0, var_1) {
  if(isDefined(var_1)) {
    if(!isDefined(var_0.vehicle_caps_counter))
      var_0.vehicle_caps_counter = [];

    if(!isDefined(var_0.vehicle_caps_counter[var_1]))
      var_0.vehicle_caps_counter[var_1] = 1;
    else
      var_0.vehicle_caps_counter[var_1]++;
  }

  var_0._id_11CB0++;
  var_0.module_vehicles[var_0.module_vehicles.size] = self;
  thread scripts\engine\utility::thread_on_notify_no_endon_death("_encstr_AD75063D571AE108", ::remove_from_module_vehicles_list, var_0, var_1);
}

has_vehicle_type_exceeded_module_cap(var_0, var_1) {
  if(!isDefined(var_0.vehicle_caps))
    return 0;

  if(isDefined(var_0.vehicle_caps[var_1])) {
    if(!isDefined(var_0.vehicle_caps_counter))
      return 0;

    if(!isDefined(var_0.vehicle_caps_counter[var_1]))
      return 0;

    if(triggerenterfunc(var_0.vehicle_caps_counter[var_1], var_0.vehicle_caps[var_1]))
      return 1;
  }

  return 0;
}

remove_from_module_vehicles_list(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_0.vehicle_caps_counter)) {
      if(isDefined(var_0.vehicle_caps_counter[var_1])) {
        var_0.vehicle_caps_counter[var_1]--;

        if(var_0.vehicle_caps_counter[var_1] < 0)
          var_0.vehicle_caps_counter[var_1] = 0;
      }
    }
  }

  if(scripts\engine\utility::array_contains(var_0.module_vehicles, self))
    var_0.module_vehicles = scripts\engine\utility::array_remove(var_0.module_vehicles, self);

  var_0 notify("_encstr_AF591BED65E4B04643BA0E93827F08B3FFFC37B51A8D28808723ED7BBB");
}

timeout_group_after_duration() {
  self endon("_encstr_AD75063D571AE108");
  level notify("_encstr_B2811EA3A5DA56BDBAD1EBEC9CB7BA07D758991DCA93EB23EA27B047D2ED73F5" + self.moduleid);
  level endon("_encstr_B2811EA3A5DA56BDBAD1EBEC9CB7BA07D758991DCA93EB23EA27B047D2ED73F5" + self.moduleid);
  level endon("_encstr_A123070F0B327D488F" + self.group_name + "_encstr_A3A807379D4802F372");
  var_0 = process_module_var(self, self.timeout_action);

  if(isDefined(var_0) && isnumber(var_0))
    wait(var_0);

  level notify("_encstr_95A5156F2089DF4A2BB7A79BF913A19950208B1790C33F" + self.moduleid);
}

_id_12DDA(var_0, var_1) {
  level notify("_encstr_8D41180663DA875945E3B030AB7C1617E38E7C8071E265802D83" + var_0.moduleid);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread watch_for_module_endons();
  var_0 thread _id_12DF3();
  var_0 thread module_run_func_after_notify();

  if(isDefined(var_0.timeout_action))
    var_0 thread timeout_group_after_duration();

  var_0 change_module_status(undefined, "_encstr_820A0BC15DB4B5595CABDDDF27");
  var_0 scripts\cp\cp_spawning_util::run_module_init_funcs_on_module_struct();

  if(isDefined(var_0.start_func)) {
    var_0 change_module_status(undefined, "_encstr_93DE0BEA0583633C49618FDB70");
    process_module_var(var_0, var_0.start_func);
  }

  var_0 thread run_weapons_free_funcs();

  if(getDvar("_encstr_91620F0BD64B51EA574117644781EB568D", "_encstr_B40101") != "_encstr_B40101" && getDvar("_encstr_91620F0BD64B51EA574117644781EB568D", "_encstr_B40101") == var_0.group_name)
    level thread _id_12E20(var_0, var_1);
  else
    level thread runspawnmodule(var_0, var_1);

  var_0 waittill("_encstr_AD75063D571AE108");
}

run_weapons_free_funcs() {
  if(isDefined(self.fn_weapons_free)) {
    scripts\engine\utility::ent_flag_wait("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

    for(var_0 = 0; var_0 < self.fn_weapons_free.size; var_0++)
      thread process_module_var(self, self.fn_weapons_free[var_0]);
  }
}

_id_12DDD() {
  if(isDefined(self.group.lightsfloor02)) {
    for(var_0 = 0; var_0 < self.group.lightsfloor02.size; var_0++)
      thread process_module_var(self.group, self.group.lightsfloor02[var_0]);
  }
}

_id_12DF3() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = level scripts\engine\utility::_id_143AD("_encstr_97010EC7E9B7736E015835FF73B0AD49" + self.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8", "_encstr_95A5156F2089DF4A2BB7A79BF913A19950208B1790C33F" + self.moduleid);

  if(isDefined(self.post_module_delay)) {
    var_1 = process_module_var(self, self.post_module_delay);

    if(isDefined(var_1) && isnumberandgreaterthanzero(var_1))
      level scripts\engine\utility::_id_143B9(var_1, "_encstr_91D21588BF8359C7072345B5AA87F513319D272B2DEAD7");

    level notify("_encstr_A123070F0B327D488F" + self.group_name + "_encstr_A91B167FB065208DCF7A4811C33BCD89BE3793D9444FA05D");
  }

  if(isDefined(self.nextgroup)) {
    var_2 = process_module_var(self, self.nextgroup);

    if(isDefined(var_2) && isstring(var_2))
      level thread run_spawn_module(var_2, undefined, self);
  }

  self notify("_encstr_AD75063D571AE108");
}

remove_pacifist_from_enemies() {
  for(var_0 = 0; var_0 < level.spawned_enemies.size; var_0++) {
    level.spawned_enemies[var_0].pacifist = 0;
    level.spawned_enemies[var_0].script_pacifist = undefined;
    level.spawned_enemies[var_0] thread enter_combat_after_stealth();
  }
}

remove_pacifist_from_guy() {
  self.pacifist = 0;
  self.script_pacifist = undefined;
}

demeanor_override_all_enemies(var_0) {
  for(var_1 = 0; var_1 < level.spawned_enemies.size; var_1++)
    level.spawned_enemies[var_1] set_demeanor_from_unittype(var_0);
}

set_dont_enter_combat_flag(var_0) {
  self.dont_enter_combat = 1;
}

clear_dont_enter_combat_flag() {
  self.dont_enter_combat = undefined;
}

watch_for_module_endons() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_0 = ["_encstr_8D41180663DA875945E3B030AB7C1617E38E7C8071E265802D83" + self.moduleid, "_encstr_AB731281ED21790A703FA4904735B8541D7BE210" + self.moduleid, "_encstr_AB731281ED21790A703FA4904735B8541D7BE210" + self.group_name];
  level scripts\engine\utility::waittill_any_in_array_return(var_0);
  self notify("_encstr_AD75063D571AE108");
}

isnumberandgreaterthanzero(var_0) {
  if(isDefined(var_0) && isnumber(var_0) && var_0 > 0)
    return 1;
  else
    return 0;
}

runspawnmodule(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_81A5107AE378DAD3A7F3C2F8D80D9F4D48CF" + var_0.moduleid);
  level endon("_encstr_81A5107AE378DAD3A7F3C2F8D80D9F4D48CF" + var_0.moduleid);
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread resetgroupvariables();
  waittillframeend;

  for(;;) {
    if(var_0 isambientspawningpaused()) {
      var_0 change_module_status(undefined, "_encstr_84AC0E2F609155E2E33F2266FDB70A0C");
      continue;
    }

    var_2 = process_module_var(var_0, var_0.totalspawns);
    var_0.debug_data.totalspawns = var_2;

    if(var_2 > 0 && var_0 get_activecount_from_group(1) + var_0.currentmodulekills >= var_2) {
      level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
      return;
    }

    var_2 = process_module_var(var_0, var_0.totalspawns);
    var_0.debug_data.totalspawns = var_2;
    var_3 = var_0 get_comp_count();
    var_4 = var_0 get_comp_count(0);
    var_5 = allowed_to_spawn_agent(var_0);

    if(var_5) {
      if(isDefined(var_3) && isDefined(var_4) && var_0 get_activecount_from_group(1) < var_3 && var_0 get_activecount_from_group() < var_4)
        var_0 spawn_soldier_scripted(var_0);

      var_6 = process_module_var(var_0, var_0.time_between_spawns);

      if(isnumberandgreaterthanzero(var_6))
        wait(var_6);
      else
        waitframe();

      continue;
    }

    wait 0.1;
  }
}

_id_12E20(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_81A5107AE378DAD3A7F3C2F8D80D9F4D48CF" + var_0.moduleid);
  level endon("_encstr_81A5107AE378DAD3A7F3C2F8D80D9F4D48CF" + var_0.moduleid);
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 thread resetgroupvariables();

  for(;;) {
    if(var_0 isambientspawningpaused()) {
      var_0 change_module_status(undefined, "_encstr_84AC0E2F609155E2E33F2266FDB70A0C");
      continue;
    }

    var_2 = process_module_var(var_0, var_0.totalspawns);
    var_0.debug_data.totalspawns = var_2;

    if(var_2 > 0 && var_0 get_activecount_from_group(1) + var_0.currentmodulekills >= var_2) {
      level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
      return;
    }

    var_2 = process_module_var(var_0, var_0.totalspawns);
    var_0.debug_data.totalspawns = var_2;
    var_3 = var_0 get_comp_count();
    var_4 = var_0 get_comp_count(0);
    var_5 = allowed_to_spawn_agent(var_0);

    if(var_5) {
      if(isDefined(var_3) && isDefined(var_4) && var_0 get_activecount_from_group(1) < var_3 && var_0 get_activecount_from_group() < var_4)
        var_0 spawn_soldier_scripted(var_0);

      var_6 = process_module_var(var_0, var_0.time_between_spawns);

      if(isnumberandgreaterthanzero(var_6))
        wait(var_6);

      continue;
    }

    wait 0.1;
  }
}

get_comp_count(var_0) {
  var_1 = process_module_var(self, self.min_size);
  self.debug_data.min_size = var_1;
  self.kill_off_enemies = undefined;
  var_0 = define_var_if_undefined(var_0, 1);

  if(isDefined(var_1) && get_activecount_from_group(var_0) < var_1) {
    self.kill_off_enemies = 1;
    level.requested_spawns_groups[self.moduleid] = var_1;
    return var_1;
  }

  var_2 = process_module_var(self, self.max_size);
  self.debug_data.max_size = var_2;

  if(isDefined(var_2) && get_activecount_from_group(var_0) < var_2) {
    level.requested_spawns_groups[self.moduleid] = var_2;
    return var_2;
  }

  return undefined;
}

send_aievent_to_others_in_group(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = self;

  if(isDefined(var_1)) {
    if(isarray(self.group)) {
      var_6 = [];

      for(var_7 = 0; var_7 < self.group.size; var_7++)
        var_6 = scripts\engine\utility::array_add(var_6, self.group[var_7].ai_spawned);

      var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_6, undefined, undefined, var_1, 0);
    } else
      var_8 = scripts\engine\utility::get_array_of_closest(self.origin, self.group.ai_spawned, undefined, undefined, var_1, 0);
  } else if(isarray(self.group)) {
    var_6 = [];

    for(var_7 = 0; var_7 < self.group.size; var_7++)
      var_6 = scripts\engine\utility::array_add(var_6, self.group[var_7].ai_spawned);

    var_8 = var_6;
  } else
    var_8 = self.group.ai_spawned;

  for(var_7 = 0; var_7 < var_8.size; var_7++) {
    if(var_8[var_7] == self) {
      if(istrue(var_4)) {
        var_8[var_7] aieventlistenerevent(var_0, var_5, self.origin);
        continue;
      } else
        continue;
    }

    if(istrue(var_2) && !scripts\engine\utility::within_fov(self.origin, self.angles, var_8[var_7].origin, cos(65))) {
      continue;
    }
    if(istrue(var_3) && !self aiphysicstracepassed(self.origin, var_8[var_7].origin, 15, 60)) {
      continue;
    }
    var_8[var_7] aieventlistenerevent(var_0, var_5, self.origin);
  }
}

notify_others_in_group(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4))
    var_5 = getaiarray("_encstr_8E8405EA382B2A");
  else
    var_5 = self.group.ai_spawned;

  if(isDefined(var_1))
    var_5 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, undefined, var_1, 0);

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(var_5[var_6] == self) {
      continue;
    }
    if(istrue(var_2) && !scripts\engine\utility::within_fov(var_5[var_6].origin, var_5[var_6].angles, self.origin, cos(65))) {
      continue;
    }
    if(istrue(var_3) && !var_5[var_6] cansee(self)) {
      continue;
    }
    var_5[var_6] notify(var_0);
  }
}

get_requested_spawn_count(var_0) {
  var_1 = 0;

  foreach(var_4, var_3 in level.requested_spawns_groups) {
    if(isDefined(var_0) && var_0 == var_4) {
      continue;
    }
    var_1 = var_1 + var_3;
  }

  return var_1;
}

run_func_on_group_by_groupname(var_0, var_1) {
  foreach(var_3 in level.active_spawn_module_structs) {
    if(isarray(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5.group_name == var_0)
          var_5 process_module_var(var_5, var_1);
      }

      continue;
    }

    if(var_3.group_name == var_0)
      var_3 process_module_var(var_3, var_1);
  }
}

pause_all_other_groups(var_0) {
  foreach(var_2 in level.active_spawn_module_structs) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4.group_name != var_0) {
          if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
            announcement(var_4.group_name + "_encstr_8E6E0A57D157E1114DFF2B23");

          var_4 scripts\engine\utility::ent_flag_set("_encstr_998C0C70E2AB1F517F6F36A055EB");
        }
      }

      continue;
    }

    if(var_2.group_name != var_0) {
      if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
        announcement(var_2.group_name + "_encstr_8E6E0A57D157E1114DFF2B23");

      var_2 scripts\engine\utility::ent_flag_set("_encstr_998C0C70E2AB1F517F6F36A055EB");
    }
  }
}

unpause_all_other_groups(var_0) {
  foreach(var_2 in level.active_spawn_module_structs) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4.group_name != var_0) {
          if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
            announcement(var_4.group_name + "_encstr_9A6C0CB0A0EBDF1D6170235B4891");

          var_4 scripts\engine\utility::ent_flag_clear("_encstr_998C0C70E2AB1F517F6F36A055EB");
        }
      }

      continue;
    }

    if(var_2.group_name != var_0) {
      if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
        announcement(var_2.group_name + "_encstr_9A6C0CB0A0EBDF1D6170235B4891");

      var_2 scripts\engine\utility::ent_flag_clear("_encstr_998C0C70E2AB1F517F6F36A055EB");
    }
  }
}

pause_group_by_id(var_0, var_1) {
  foreach(var_3 in level.active_spawn_module_structs) {
    if(isarray(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5.group_name == var_0 && var_5.moduleid == var_1) {
          if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
            announcement(var_5.group_name + "_encstr_8E6E0A57D157E1114DFF2B23");

          var_5 scripts\engine\utility::ent_flag_set("_encstr_998C0C70E2AB1F517F6F36A055EB");
        }
      }

      continue;
    }

    if(var_3.group_name == var_0 && var_3.moduleid == var_1) {
      if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
        announcement(var_3.group_name + "_encstr_8E6E0A57D157E1114DFF2B23");

      var_3 scripts\engine\utility::ent_flag_set("_encstr_998C0C70E2AB1F517F6F36A055EB");
    }
  }
}

unpause_group_by_id(var_0, var_1) {
  foreach(var_3 in level.active_spawn_module_structs) {
    if(isarray(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5.group_name == var_0 && var_5.moduleid == var_1) {
          if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
            announcement(var_5.group_name + "_encstr_9A6C0CB0A0EBDF1D6170235B4891");

          var_5 scripts\engine\utility::ent_flag_clear("_encstr_998C0C70E2AB1F517F6F36A055EB");
        }
      }

      continue;
    }

    if(var_3.group_name == var_0 && var_3.moduleid == var_1) {
      if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
        announcement(var_3.group_name + "_encstr_9A6C0CB0A0EBDF1D6170235B4891");

      var_3 scripts\engine\utility::ent_flag_clear("_encstr_998C0C70E2AB1F517F6F36A055EB");
    }
  }
}

set_weapons_free_for_all_groups() {
  foreach(var_1 in level.spawn_module_structs_memory) {
    if(isarray(var_1)) {
      foreach(var_3 in var_1)
      var_3 scripts\engine\utility::ent_flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

      continue;
    }

    var_1 scripts\engine\utility::ent_flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  }
}

pause_group_by_group_name(var_0) {
  foreach(var_2 in level.active_spawn_module_structs) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4.group_name == var_0) {
          if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
            announcement(var_4.group_name + "_encstr_8E6E0A57D157E1114DFF2B23");

          var_4 scripts\cp\cp_spawning_util::_id_12DEE();
          var_4 scripts\engine\utility::ent_flag_set("_encstr_998C0C70E2AB1F517F6F36A055EB");
        }
      }

      continue;
    }

    if(var_2.group_name == var_0) {
      if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
        announcement(var_2.group_name + "_encstr_8E6E0A57D157E1114DFF2B23");

      var_2 scripts\cp\cp_spawning_util::_id_12DEE();
      var_2 scripts\engine\utility::ent_flag_set("_encstr_998C0C70E2AB1F517F6F36A055EB");
    }
  }
}

unpause_group_by_group_name(var_0) {
  foreach(var_2 in level.active_spawn_module_structs) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4.group_name == var_0) {
          if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
            announcement(var_2.group_name + "_encstr_9A6C0CB0A0EBDF1D6170235B4891");

          var_4 scripts\cp\cp_spawning_util::_id_12DEF();
          var_4 scripts\engine\utility::ent_flag_clear("_encstr_998C0C70E2AB1F517F6F36A055EB");
        }
      }

      continue;
    }

    if(var_2.group_name == var_0) {
      if(getdvarint("_encstr_83ED17FFF716D95B60F0CBD9A88094B3E103C76B5B3D4305D0", 0))
        announcement(var_2.group_name + "_encstr_9A6C0CB0A0EBDF1D6170235B4891");

      var_2 scripts\cp\cp_spawning_util::_id_12DEF();
      var_2 scripts\engine\utility::ent_flag_clear("_encstr_998C0C70E2AB1F517F6F36A055EB");
    }
  }
}

stop_all_groups() {
  var_0 = getarraykeys(level.active_spawn_module_structs);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    stop_module_by_groupname(var_0[var_1]);
}

stop_module_by_id(var_0) {
  level notify("_encstr_AB731281ED21790A703FA4904735B8541D7BE210" + var_0);
}

stop_module_by_groupname(var_0, var_1) {
  if(isDefined(level.active_spawn_module_structs[var_0])) {
    var_2 = level.active_spawn_module_structs[var_0];

    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(istrue(var_1)) {
          level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_4.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
          continue;
        }

        var_4 notify("_encstr_AD75063D571AE108");
      }
    } else if(istrue(var_1))
      level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_2.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
    else
      var_2 notify("_encstr_AD75063D571AE108");
  }
}

initialize_as_veh_spawner() {
  define_spawner("_encstr_847610EC5686D2C63659AFCD8358DD37AC39");
  remove_from_spawner_flags(8);
  add_to_spawner_flags(16);
  self.script_function = "_encstr_96EC0BA32B8D1AB7D70E8697E6";
  self.veh_model_spawner = 1;
  scripts\cp\utility::addtostructarray("_encstr_B2CE0BA1D0FB19FDC54613D9BF", "_encstr_9388109D4EBDABE6327DCEACA1D7AC0FA5A3", self);
  scripts\cp\utility::addtostructarray("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", "_encstr_970D094917423528F5CD31", self);
}

process_module_var(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_91D51748AFC259B3097B4FF509DDD31F25886368A1EA15C33D");

  if(!isDefined(var_1))
    return "_encstr_83B306C13570D0CB";

  var_4 = var_1;

  if(isstring(var_1))
    return var_1;
  else if(isnumberandgreaterthanzero(var_1))
    return var_1;
  else if(isarray(var_1)) {
    if(isarray(var_1[0])) {
      for(var_5 = 0; var_5 < var_1.size; var_5++)
        var_4 = process_module_var(var_0, var_1[var_5], var_2);
    } else if(isbuiltinfunction(var_1[0])) {
      var_6 = var_1[0];
      var_7 = [];
      var_8 = process_module_params(var_0, var_1);
      var_4 = var_0 run_modular_spawning_func(var_6, var_8, var_3);
    } else
      var_4 = var_1;
  } else if(isbuiltinfunction(var_1)) {
    if(istrue(var_2))
      return var_1;
    else
      var_4 = [[var_1]](var_0);
  }

  return var_4;
}

process_module_params(var_0, var_1) {
  var_2 = [];

  if(var_1.size < 2)
    return var_2;
  else {
    var_3 = spawnStruct();
    var_3.var_params = [];
    var_4 = min(var_1.size, 9);

    for(var_5 = 1; var_5 < var_4; var_5++) {
      var_6 = var_1[var_5];
      var_3 thread send_notify_after_frame_end("_encstr_91D51748AFC259B3097B4FF509DDD31F25886368A1EA15C33D");
      var_3.var_params[var_5 - 1] = var_3 process_module_var(var_0, var_6, 1);
    }
  }

  return var_3;
}

send_notify_after_frame_end(var_0) {
  self endon("_encstr_AD75063D571AE108");
  waittillframeend;
  self notify(var_0);
}

run_modular_spawning_func(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_3 = var_2;
  else
    var_3 = self;

  if(!isDefined(var_1.var_params))
    return var_3[[var_0]](self);
  else if(var_1.var_params.size == 1)
    return var_3[[var_0]](self, return_undefined_param_if_empty(var_1.var_params[0]));
  else if(var_1.var_params.size == 2)
    return var_3[[var_0]](self, return_undefined_param_if_empty(var_1.var_params[0]), return_undefined_param_if_empty(var_1.var_params[1]));
  else if(var_1.var_params.size == 3)
    return var_3[[var_0]](self, return_undefined_param_if_empty(var_1.var_params[0]), return_undefined_param_if_empty(var_1.var_params[1]), return_undefined_param_if_empty(var_1.var_params[2]));
  else if(var_1.var_params.size == 4)
    return var_3[[var_0]](self, return_undefined_param_if_empty(var_1.var_params[0]), return_undefined_param_if_empty(var_1.var_params[1]), return_undefined_param_if_empty(var_1.var_params[2]), return_undefined_param_if_empty(var_1.var_params[3]));
  else if(var_1.var_params.size == 5)
    return var_3[[var_0]](self, return_undefined_param_if_empty(var_1.var_params[0]), return_undefined_param_if_empty(var_1.var_params[1]), return_undefined_param_if_empty(var_1.var_params[2]), return_undefined_param_if_empty(var_1.var_params[3]), return_undefined_param_if_empty(var_1.var_params[4]));
  else if(var_1.var_params.size == 6)
    return var_3[[var_0]](self, return_undefined_param_if_empty(var_1.var_params[0]), return_undefined_param_if_empty(var_1.var_params[1]), return_undefined_param_if_empty(var_1.var_params[2]), return_undefined_param_if_empty(var_1.var_params[3]), return_undefined_param_if_empty(var_1.var_params[4]), return_undefined_param_if_empty(var_1.var_params[5]));
  else if(var_1.var_params.size == 7)
    return var_3[[var_0]](self, return_undefined_param_if_empty(var_1.var_params[0]), return_undefined_param_if_empty(var_1.var_params[1]), return_undefined_param_if_empty(var_1.var_params[2]), return_undefined_param_if_empty(var_1.var_params[3]), return_undefined_param_if_empty(var_1.var_params[4]), return_undefined_param_if_empty(var_1.var_params[5]), return_undefined_param_if_empty(var_1.var_params[6]));
  else if(var_1.var_params.size == 8)
    return var_3[[var_0]](self, return_undefined_param_if_empty(var_1.var_params[0]), return_undefined_param_if_empty(var_1.var_params[1]), return_undefined_param_if_empty(var_1.var_params[2]), return_undefined_param_if_empty(var_1.var_params[3]), return_undefined_param_if_empty(var_1.var_params[4]), return_undefined_param_if_empty(var_1.var_params[5]), return_undefined_param_if_empty(var_1.var_params[6]), return_undefined_param_if_empty(var_1.var_params[7]));
  else
    return undefined;
}

return_undefined_param_if_empty(var_0) {
  if(isDefined(var_0)) {
    if(isstring(var_0) && var_0 == "_encstr_83B306C13570D0CB")
      return undefined;
    else
      return var_0;
  } else
    return undefined;
}

resetgroupvariables() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  self.currentmodulekills = 0;
  level.requested_spawns_groups[self.moduleid] = undefined;
}

spawn_ai(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    var_3 change_module_status(undefined, "_encstr_8277117F587365D2E9351EC21FF34B26BE68D7");

  var_4 = self.origin;
  var_5 = self.angles;

  if(isDefined(var_0))
    var_4 = var_0;

  if(isDefined(var_1))
    var_5 = (0, var_1[1], 0);

  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_3) && isDefined(var_3.spawn_aitype_counts) && var_3.spawn_aitype_counts.size > 0 && !isDefined(self.vehicle)) {
    var_6 = var_3 choose_and_decrement_from_aitype_list();
    var_7 = level.aitypes[var_6].agent_type;
  } else if(isDefined(var_3) && isDefined(var_3.aitype_override) && var_3.aitype_override.size && !isDefined(self.vehicle)) {
    var_8 = weighted_array_randomize(var_3.aitype_override, var_3.aitype_override_weights);
    var_7 = level.aitypes[var_8].agent_type;
    var_6 = var_8;
  } else if(isDefined(level.aitype_override) && level.aitype_override.size && !isDefined(self.vehicle)) {
    var_8 = weighted_array_randomize(level.aitype_override, level.aitype_override_weights);
    var_7 = level.aitypes[var_8].agent_type;
    var_6 = var_8;
  } else if(isDefined(var_2)) {
    var_7 = level.aitypes[var_2].agent_type;
    var_6 = var_2;
  } else {
    var_9 = get_aitypes_from_spawner();
    var_8 = scripts\engine\utility::random(var_9);
    var_7 = level.aitypes[var_8].agent_type;
    var_6 = var_8;
  }

  if(isDefined(level.playerisprop)) {
    var_8 = scripts\engine\utility::random(level.playerisprop);

    if(isDefined(level.aitypes[var_8]) && isDefined(level.aitypes[var_8].agent_type)) {
      var_7 = level.aitypes[var_8].agent_type;
      var_6 = var_8;
    }
  }

  var_10 = undefined;

  if(istrue(level.playerismatchpending) || is_armored()) {
    if(isDefined(level.aitypes[var_6 + "_encstr_938A0711C8E8A1DB0B"]) && isDefined(level.aitypes[var_6 + "_encstr_938A0711C8E8A1DB0B"].agent_type)) {
      var_7 = level.aitypes[var_6 + "_encstr_938A0711C8E8A1DB0B"].agent_type;
      var_6 = var_6 + "_encstr_938A0711C8E8A1DB0B";
      var_10 = 1;
    }
  }

  if(!isDefined(var_7)) {
    var_8 = scripts\engine\utility::random(level.random_aitype_list);
    var_7 = level.aitypes[var_8].agent_type;
    var_6 = var_8;
  }

  var_11 = var_7;

  if(isDefined(var_3))
    var_3 change_module_status(undefined, "_encstr_8DDC111A86EDCD950858D9AC371DBEA3E50EB2");

  if(isDefined(var_3))
    var_3 change_module_status(undefined, "_encstr_99590F2078A7F7A2C827BEF84340AFD7BD");

  enter_spawn_queue();
  self.aitype = var_6;
  self.agent_type = var_7;

  if(isDefined(var_3) && istrue(var_3.min_spawn_requested)) {
    var_12 = undefined;
    var_3 change_module_status(undefined, "_encstr_91F81123BDC91BB2029AC10BEE730826F6ED38");

    for(;;) {
      var_12 = scripts\mp\mp_agent::spawnnewagentaitype(var_11, var_4, var_5);

      if(isDefined(var_12)) {
        break;
      }

      waitframe();
    }

    var_3.min_spawn_requested = undefined;

    if(get_reserved_slot_count_by_string_id(var_3.moduleid) > 0)
      decrease_reserved_spawn_slots(1, var_3.moduleid);
  } else {
    if(isDefined(var_3))
      var_3 change_module_status(undefined, "_encstr_B1E10E9A0EB0EEE601A0D1E8B2DA3847");

    var_12 = scripts\mp\mp_agent::spawnnewagentaitype(var_11, var_4, var_5);
  }

  if(isDefined(var_12) && istrue(var_10))
    var_12.equip_armor = 1;

  return var_12;
}

triggerenterfunc(var_0, var_1) {
  return var_0 >= var_1;
}

choose_and_decrement_from_aitype_list() {
  var_0 = getarraykeys(self.spawn_aitype_counts);

  foreach(var_2 in var_0) {
    if(isDefined(self.spawn_aitype_counts[var_2]) && isint(self.spawn_aitype_counts[var_2]) && triggerenterfunc(self.spawn_aitype_counts[var_2], 1)) {
      for(var_3 = 0; var_3 < level.spawn_module_structs_memory[self.group_name].size; var_3++) {
        var_4 = level.spawn_module_structs_memory[self.group_name][var_3];

        if(isDefined(var_4.spawn_aitype_counts[var_2])) {
          var_4.spawn_aitype_counts[var_2]--;

          if(var_4.spawn_aitype_counts[var_2] <= 0)
            var_4.spawn_aitype_counts[var_2] = undefined;
        }
      }

      var_5 = level.aitypes[var_2].agent_type;
      var_6 = var_2;
      return var_6;
    }
  }

  return undefined;
}

weighted_array_randomize(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_2 = var_2 + var_1[var_3];

  var_4 = randomfloat(var_2);
  var_5 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_5 = var_5 + var_1[var_3];

    if(var_5 >= var_4)
      return var_0[var_3];
  }
}

enter_spawn_queue() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.spawn_queue++;

  if(level.spawn_queue > 1)
    wait(level.spawn_queue * 0.05);

  level.spawn_queue--;
}

start_patrol() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_81130D62549E85A31778EFBB9388C0");
  self endon("_encstr_81130D62549E85A31778EFBB9388C0");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread enter_combat_after_stealth();

  if(isDefined(self.script_linkto))
    thread go_to_node(get_next_node_array());
  else if(isDefined(self.spawnpoint.target) || isDefined(self.spawnpoint.script_linkto) && !is_door_spawn())
    thread go_to_node(self.spawnpoint get_next_node_array());
  else if(should_roam())
    thread patrol_using_cover_nodes();
}

patrol_using_cover_nodes() {
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.dot_override))
    self.dot_override = 0;

  if(self.goalradius < 256)
    var_0 = 1024;
  else
    var_0 = self.goalradius;

  set_goal_radius(64);
  var_1 = 64;
  var_2 = 256;
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(self.script_goalheight))
    var_2 = int(self.script_goalheight);

  for(;;) {
    if(isDefined(self.script_origin_other))
      var_5 = self.script_origin_other;
    else
      var_5 = self.origin;

    if(istrue(self.find_new_patrol)) {
      wait 0.25;
      continue;
    }

    var_6 = -1;
    var_4 = undefined;
    var_7 = undefined;
    var_8 = getnodesinradiussorted(var_5, var_0, var_1, var_2, "_encstr_AF1904A7F929");
    var_9 = [];

    if(isDefined(var_8) && var_8.size > 0) {
      for(var_10 = 0; var_10 < var_8.size; var_10++) {
        if(isDefined(var_3) && var_8[var_10] == var_3) {
          continue;
        }
        if(isDefined(showcinematicletterboxing(var_8[var_10]))) {
          continue;
        }
        if(isDefined(self.dot_override))
          var_11 = self.angles + (0, self.dot_override, 0);
        else
          var_11 = self.angles;

        var_12 = scripts\engine\math::get_dot(self.origin, var_11, var_8[var_10].origin);

        if(var_12 < 0.3) {
          if(var_12 > var_6) {
            var_4 = var_8[var_10];
            var_6 = var_12;
          }

          continue;
        }

        var_9[var_9.size] = var_8[var_10];
      }
    }

    if(var_9.size > 0)
      var_7 = get_least_used_from_array(var_9);

    var_13 = gettime();

    if(isDefined(var_7)) {
      self.dot_override = undefined;
      var_3 = var_7;
      go_to_node(var_7);
      var_14 = gettime();

      if(var_14 <= var_13)
        waitframe();

      continue;
    }

    if(isDefined(var_4)) {
      self.dot_override = undefined;
      var_3 = var_4;
      go_to_node(var_4);
      var_14 = gettime();

      if(var_14 <= var_13)
        waitframe();

      continue;
    }

    wait 1;
  }
}

enter_combat_after_stealth(var_0) {
  if(scripts\cp\coop_stealth::_id_132D7()) {
    return;
  }
  self notify("_encstr_8BC51B05BDC03FA3C0198A52C1277379B005AC8D1DF1C2E3F571B2CBA8");
  self endon("_encstr_8BC51B05BDC03FA3C0198A52C1277379B005AC8D1DF1C2E3F571B2CBA8");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_92600D68A25B83032F3BE8D112FF0B");
  var_1 = [];
  var_2 = [];
  var_3 = undefined;

  if(isDefined(self.team)) {
    if(isDefined(self.group) && self.group scripts\engine\utility::ent_flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0") && !self.group scripts\engine\utility::ent_flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0")) {
      if(self.team == "_encstr_9A8507BA4040188D08") {
        var_2 = [self, level];
        scripts\engine\utility::waittill_any_ents_array(var_2, "_encstr_B2BE0788BAF573592F", "_encstr_99A30FCD3ACAB0D8471AAF6CB76B89853A", "_encstr_B60B0D9BCB68EE7AB8B31F2D23C3AB", "_encstr_B4910DD36ABF0F48B55B9FD5625FD0", "_encstr_A5490D5E05C3F8B363F3C8D83B3E43");
      } else if(istrue(self.aggressive))
        return;
      else if(is_pacifist()) {
        var_2 = [self, self.group, level];
        scripts\engine\utility::waittill_any_ents_array(var_2, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0", "_encstr_BD3F0A6EC2BBD791CA2C8EA1");
      } else {
        var_2 = [self, self.group, level];
        var_3 = scripts\engine\utility::waittill_any_ents_return(level, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0", self.group, "_encstr_B4910DD36ABF0F48B55B9FD5625FD0", self, "_encstr_BD3F0A6EC2BBD791CA2C8EA1", self, "_encstr_A9980CD206D783ADA12A30A07283");
      }
    }
  }

  if(isDefined(level.enter_combat_flag) && !scripts\engine\utility::flag(level.enter_combat_flag))
    scripts\engine\utility::flag_set(level.enter_combat_flag);

  thread enter_combat();
}

set_default_spawner_values() {
  self.lastspawntime = gettime();
}

set_default_values(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  if(!is_specified_unittype("_encstr_83E8094727E333E8F9CE50") && (is_pacifist() || is_patroller()))
    thread watch_for_ai_events();

  if(isDefined(var_0) && isDefined(var_0.groupname))
    self.groupname = var_0.groupname;

  set_kill_off_time();

  if(isDefined(self.script_radius))
    set_goal_radius(self.script_radius);
  else
    set_goal_radius(2048);

  if(isDefined(self.script_goalheight))
    self.goalheight = self.script_goalheight;
  else
    self.goalheight = 256;

  self.og_goalradius = self.goalradius;
  self.spawnpoint = var_1;
  self.qsetgoalpos = 1;
  self.spawn_parameter_array = var_2;

  if(istrue(self.equip_helmet) || is_juggernaut_aitype())
    give_soldier_helmet();

  if(is_armored() || is_juggernaut_aitype())
    give_soldier_armor();

  stoppingpower_getweaponhcrdata();
}

_id_12DDC(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  thread watch_for_bad_path();

  if(isDefined(var_3))
    join_module_group(var_3, self);

  if(isDefined(level.global_ai_func_array) && level.global_ai_func_array.size > 0) {
    if(isDefined(self.team) && self.team == "_encstr_8E8405EA382B2A") {
      var_4 = self.team;

      for(var_5 = 0; var_5 < level.global_ai_func_array[var_4].size; var_5++) {
        var_6 = level.global_ai_func_array[var_4][var_5];

        if(isDefined(var_6["_encstr_87D70783C22716D60D"])) {
          self thread[[var_6["_encstr_B2BB0998FB35773B1FAFF0"]]](var_6["_encstr_81D7070E2C93B0D613"], var_6["_encstr_ADD707F0EB707381A5"], var_6["_encstr_97D707ABD1FAFFA582"], var_6["_encstr_87D70783C22716D60D"]);
          continue;
        }

        if(isDefined(var_6["_encstr_97D707ABD1FAFFA582"])) {
          self thread[[var_6["_encstr_B2BB0998FB35773B1FAFF0"]]](var_6["_encstr_81D7070E2C93B0D613"], var_6["_encstr_ADD707F0EB707381A5"], var_6["_encstr_97D707ABD1FAFFA582"]);
          continue;
        }

        if(isDefined(var_6["_encstr_ADD707F0EB707381A5"])) {
          self thread[[var_6["_encstr_B2BB0998FB35773B1FAFF0"]]](var_6["_encstr_81D7070E2C93B0D613"], var_6["_encstr_ADD707F0EB707381A5"]);
          continue;
        }

        if(isDefined(var_6["_encstr_81D7070E2C93B0D613"])) {
          self thread[[var_6["_encstr_B2BB0998FB35773B1FAFF0"]]](var_6["_encstr_81D7070E2C93B0D613"]);
          continue;
        }

        self thread[[var_6["_encstr_B2BB0998FB35773B1FAFF0"]]]();
      }
    }
  }

  if(!is_specified_unittype("_encstr_83E8094727E333E8F9CE50") && (is_pacifist() || is_patroller()))
    thread watch_for_ai_events();

  if(isDefined(level.enemy_monitor_func))
    self thread[[level.enemy_monitor_func]](self.unittype);
}

stoppingpower_getweaponhcrdata() {
  self.dropweapon = 0;

  if(!isDefined(self.sidearm))
    self.sidearm = isundefinedweapon();

  scripts\common\utility::initweapon(self.primaryweapon);
  scripts\common\utility::initweapon(self.sidearm);

  if(!is_specified_unittype("_encstr_83E8094727E333E8F9CE50")) {
    _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.primaryweapon, "_encstr_BA7F0830B3A7859B60B0");
    _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::placeweaponon(self.sidearm, "_encstr_AF53086E4B46ACC2E4B5");
    scripts\cp\utility::set_battlechatter(1);
  }
}

set_kill_off_time(var_0) {
  if(isDefined(var_0))
    var_1 = var_0 * 1000;
  else if(isDefined(self.group) && isDefined(self.group.kill_off_time_override))
    var_1 = self.group.kill_off_time_override * 1000;
  else if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.script_timer))
    var_1 = self.spawnpoint.script_timer * 1000;
  else if(isDefined(self.group) && istrue(self.group.cqb_module))
    var_1 = 2500000;
  else
    var_1 = 20000;

  var_2 = gettime() + var_1;

  if(!isDefined(self.killofftime) || var_2 > self.killofftime)
    self.killofftime = var_2;

  if(istrue(self.entered_combat)) {
    var_3 = var_1 / 1000;
    thread add_to_kill_off_list(var_3);
  } else
    remove_from_kill_off_list();
}

add_to_kill_off_list(var_0) {
  self notify("_encstr_927B15DF9165A12430AEE46CA04047FACC3D9F631316DB");
  self endon("_encstr_927B15DF9165A12430AEE46CA04047FACC3D9F631316DB");
  self endon("_encstr_AD75063D571AE108");
  remove_from_kill_off_list();
  wait(var_0);

  if(isDefined(self.entity_number))
    level.can_kill_off_list[self.entity_number] = self;
  else
    level.can_kill_off_list[self getentitynumber()] = self;

  if(level.can_kill_off_list.size == 1)
    level thread passive_kill_off_loop();
}

passive_kill_off_loop() {
  level notify("_encstr_8310136EE87B83AFDA96C6C6BEB799CCF536BDEDE0");
  level endon("_encstr_8310136EE87B83AFDA96C6C6BEB799CCF536BDEDE0");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = level.frameduration / 1000;

  for(;;) {
    var_1 = 1;
    var_2 = getarraykeys(level.can_kill_off_list);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(!isDefined(level.can_kill_off_list[var_2[var_3]])) {
        continue;
      }
      var_4 = level.can_kill_off_list[var_2[var_3]] thread passive_kill_off_ai();

      if(!isDefined(var_4) || var_4) {
        if(var_1 > var_0)
          var_1 = var_1 - var_0;

        waitframe();
      }
    }

    wait(var_1);
  }
}

passive_kill_off_ai(var_0) {
  if(!isalive(self))
    return 0;

  if(self.health < 1)
    return 0;

  if(has_dont_kill_off_flag())
    return 0;

  if(istrue(scripts\engine\utility::script_func("_encstr_AB2F13295C5740B6E197E3CDFBABF32007B9704383", self)))
    return 0;

  if(istrue(self.attempting_teleport))
    return 0;

  if(istrue(self.playing_skit))
    return 0;

  if(is_specified_unittype("_encstr_8BFC0BC2CBD4F737E0A5E1FD79"))
    return 0;

  if(istrue(self.tripledefenderkill)) {
    set_kill_off_time(20);
    return 0;
  }

  if(!istrue(self.playeriszombie)) {
    if(is_riding_vehicle())
      return 0;

    if(isDefined(self.enemy) && self canshootenemy())
      return 0;
  }

  var_1 = get_see_recently_time_overrides();

  if(isDefined(self.group) && istrue(self.group.cqb_module))
    var_2 = 2250000;
  else
    var_2 = 25000000;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(distancesquared(var_4.origin, self.origin) < var_2)
      return 0;

    if(self seerecently(var_4, var_1))
      return 0;
  }

  if(!vo_nag_hangar()) {
    if(!istrue(var_0))
      return 1;
  }

  teleport_to_nearby_spawner("_encstr_BD8111CF9EBB507BB34FA17F573A317A6FB7F1", undefined, 0);
  return 1;
}

vo_nag_hangar() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(self hastacvis(var_1, 0, 64, 1))
      return 0;

    if(var_1 hastacvis(self, 0, 64, 1))
      return 0;
  }

  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1);
  var_3 = self getapproxeyepos();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_4 = level.players[var_0];

    if(scripts\engine\trace::ray_trace_passed(var_4 getEye(), var_3, [var_4, self], var_2))
      return 0;
  }

  return 1;
}

is_riding_vehicle() {
  return isDefined(self.ridingvehicle);
}

is_specified_unittype(var_0) {
  return isDefined(self.unittype) && self.unittype == var_0;
}

is_juggernaut_aitype() {
  return isDefined(self.unittype) && self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
}

set_default_rpg_values() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.5;
  set_goal_radius(150);
  self.og_goalradius = self.goalradius;
  self.rocketammo = 100;
}

suicide_bomber_combat_func(var_0) {
  thread _id_13791();

  if(isDefined(level.suicide_bomber_combat_func))
    self thread[[level.suicide_bomber_combat_func]]();
  else
    thread juggernaut_state();
}

_id_13791() {
  self endon("_encstr_AD75063D571AE108");
  self.suicidebomberchants = 0;
  wait 3;
  var_0 = self.origin;

  while(distance(var_0, self.origin) < 750) {
    self.suicidebomberchants = 0;
    wait 0.5;
  }

  self.suicidebomberchants = 1;
  thread scripts\aitypes\suicidebomber\combat::dochants();
}

juggernaut_state() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    prepickupweapon();

    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on))
        self.bombertarget = self.enemy.vehicle_riding_on;
      else
        self.bombertarget = undefined;
    }

    wait 1;
  }
}

setup_informant() {
  self.ignoreall = 1;
  self.goalradius = 4;
  self.goalheight = 32;
  self.combatmode = "_encstr_821109FAE81117DA568730";
  self allowedstances("_encstr_A5AD069B231F0BAF");
}

set_default_sniper_values() {
  self endon("_encstr_AD75063D571AE108");
  self.no_fallback = 1;
  wait 0.5;
  set_goal_radius(250);
  self.og_goalradius = self.goalradius;
}

assign_soldier_spec(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level.soldier_agent_specialize_func)) {
    if(isDefined(level.soldier_agent_specialize_func[var_0])) {
      var_1[[level.soldier_agent_specialize_func[var_0]]]();

      if(isDefined(var_1.spec))
        level.spawned_enemy_types[var_1.spec]++;
    }
  }
}

attempt_to_join_squad() {
  if(isDefined(self.script_goalvolume)) {
    return;
  }
  if(is_no_squad()) {
    return;
  }
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::islongrangeai()) {
    return;
  }
  if(isDefined(self.unittype) && self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    return;
  }
  level.squad_max_size = getdvarint("_encstr_BE180EDCC6C9F59BB857C232FAB6850F", 4);
  level.squad_leader_group_size = getdvarint("_encstr_A1D715E6C64EBE6EB8BA2C467DC6592C462B27AF5B2CC3", 2);
  scripts\cp\cp_squadmanager::addtosquad();
}

run_spawner_post_spawn_actions(var_0) {
  if(isDefined(var_0) && isDefined(self.post_spawn_spawner_funcs)) {
    foreach(var_2 in self.post_spawn_spawner_funcs)
    self[[var_2]](var_0);
  }
}

run_ai_post_spawn_actions() {
  if(isDefined(self.spawnpoint.post_spawn_ai_funcs)) {
    foreach(var_1 in self.spawnpoint.post_spawn_ai_funcs)
    self[[var_1]]();
  }
}

join_module_group(var_0, var_1) {
  var_1.enemy_group = var_0.group_name;
  var_1.moduleid = var_0.moduleid;
  var_1.group = var_0;
  var_1.group.activecount++;
  var_1.group.spawn_count++;
  var_0.ai_spawned[var_0.ai_spawned.size] = var_1;
  var_0 thread scripts\cp\utility::add_to_notify_queue("_encstr_A3DD1637382CEEDC56C8EBEC27DEAB83AFCD7B63C84B569C", var_1);

  if(isDefined(var_0.threatbiasoverride))
    var_1.threatbiasoverride = var_0.threatbiasoverride;

  if(isDefined(var_0.ai_spawn_func)) {
    for(var_2 = 0; var_2 < var_0.ai_spawn_func.size; var_2++)
      var_1 thread process_module_var(var_0, var_0.ai_spawn_func[var_2], undefined, var_1);
  }
}

last_spawn_time() {
  if(isDefined(self.lastspawntime))
    return self.lastspawntime;
  else
    return gettime();
}

set_spawner_init_flag() {
  add_to_spawner_flags(1);
}

is_spawner_initialized() {
  return isDefined(self.spawner_flags) && self.spawner_flags & 1;
}

spawner_init() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_97AF17C6CAD9598DEB939585235EF5CC7B397D37D84E9607E8");
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  if(is_spawner_initialized()) {
    return;
  }
  set_spawner_init_flag();
  remove_default_kvps();
  _id_130E8();

  if(!trying_to_spawn_boss()) {
    remove_from_spawner_flags(4);
    remove_from_spawner_flags(2);
  } else {
    spawn_is_vehicle_spawn(self);
    self.lastspawntime = 0;

    if(isstruct(self) && isDefined(self.spawnflags))
      self.spawnflags = int(self.spawnflags);

    if(isDefined(self.script_parent)) {
      var_0 = scripts\engine\utility::getStructArray(self.script_parent, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

      if(var_0.size > 0) {
        self.child_spawners = [];
        self.child_spawners = var_0;
        init_cluster_parent();
        scripts\engine\utility::array_thread(var_0, ::spawner_init);
        return;
      }

      return;
    }

    var_1 = 2;
    var_2 = 64;
    var_3 = 128;
    var_4 = 256;

    if(!isnode(self) && isDefined(self.spawnflags)) {
      if(!isint(self.spawnflags))
        self.spawnflags = int(self.spawnflags);

      if(self.spawnflags &var_1)
        self.equip_armor = 1;

      if(self.spawnflags &var_2) {
        add_to_spawner_flags(512);
        self.is_on_platform = 1;
      }

      if(!istrue(scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
        var_5 = 8;

        if(self.spawnflags &var_5)
          self.dont_enter_combat = 1;
      }
    }

    if(isDefined(self.script_count) || isDefined(self.script_timeout)) {
      self.post_spawn_spawner_funcs = [];
      self.post_spawn_spawner_funcs[self.post_spawn_spawner_funcs.size] = ::spawner_disable_after_count;
    }

    get_aitype_settings();
  }
}

trying_to_spawn_boss() {
  var_0 = "_encstr_B60703498F";
  var_1 = "_encstr_B40703A9CB";
  var_2 = "_encstr_B20703DE66";
  var_3 = "_encstr_A60703890B";
  var_4 = "_encstr_8A07037EF7";
  var_5 = "_encstr_840703710E";
  var_6 = "_encstr_AD0703B91A";
  var_7 = "_encstr_8507034357";
  var_8 = "_encstr_AA0703CB1C";
  var_9 = "_encstr_970703CB9C";
  var_10 = var_1 + "_encstr_8FF013A15957395D25C2426438790766105517882E";

  if(isDefined(self.targetname))
    var_11 = var_0 + "_encstr_88450F79F112B035539A59C032DAD1423C" + self.targetname + "_encstr_824C0266";
  else
    var_11 = "_encstr_B40101";

  var_12 = scripts\engine\utility::ter_op(isstruct(self), var_0 + "_encstr_8C420AA0DCD14E57D81D4910" + var_11 + var_3 + "_encstr_BD3508CD07B0BB7356E4", var_0 + "_encstr_845F0728B55F1085AE" + var_11 + var_3 + "_encstr_B18109FA3788D91F0ABFE6");

  if(isDefined(self.script_difficulty) && level.gameskill <= 1 && scripts\engine\utility::is_equal(self.script_difficulty, "_encstr_83CC051A163991")) {
    little_bird_mg_givetakegunnerturrettimeout();
    return 0;
  }

  var_13 = scripts\cp\cp_vehicles::is_vehicle_spawnpoint();

  if(!spawner_flags_check(4)) {
    if(isDefined(self.origin)) {
      var_14 = getgroundposition(self.origin, 1, 100, 16);

      if(var_13) {
        if(!isDefined(self._id_133BB) && !ispointonnavmesh(var_14)) {
          little_bird_mg_givetakegunnerturrettimeout();
          return 0;
        } else
          return 1;
      } else
        var_14 = self.origin;

      var_15 = getclosestpointonnavmesh(var_14);

      if(distance2dsquared(var_15, self.origin) <= 4096) {
        if(isstruct(self)) {
          var_15 = scripts\engine\utility::drop_to_ground(var_15, 32, -1000);
          self.origin = var_15;
        }
      } else {
        little_bird_mg_givetakegunnerturrettimeout();
        return 0;
      }
    } else {
      little_bird_mg_givetakegunnerturrettimeout();
      return 0;
    }
  }

  return 1;
}

little_bird_mg_givetakegunnerturrettimeout() {
  add_to_spawner_flags(1024);
}

mounted() {
  remove_from_spawner_flags(1024);
}

_id_130E8() {
  if(isDefined(self.spawnflags) && !isnode(self)) {
    var_0 = int(self.spawnflags);
    var_1 = 16;
    var_2 = 8;

    if(var_0 &var_1)
      define_spawner("_encstr_847610EC5686D2C63659AFCD8358DD37AC39");

    if(var_0 &var_2)
      define_spawner("_encstr_847610EC5686D2C63659AFCD8358DD37AC39");
  }

  if(isDefined(self.script_parent)) {
    var_3 = scripts\engine\utility::getStructArray(self.script_parent, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_3.size > 0)
      define_spawner("_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E");
  }
}

remove_default_kvps() {
  if(scripts\engine\utility::is_equal(self.target, "_encstr_8B1608EC43B8D647A113"))
    self.target = undefined;

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "_encstr_8B1608EC43B8D647A113"))
    self.script_noteworthy = undefined;

  if(scripts\engine\utility::is_equal(self.script_forcespawn, 0))
    self.script_forcespawn = undefined;

  if(scripts\engine\utility::is_equal(self.script_team, "_encstr_8E8405EA382B2A"))
    self.script_team = undefined;

  if(scripts\engine\utility::is_equal(self.script_radius, 0))
    self.script_radius = undefined;

  if(scripts\engine\utility::is_equal(self.script_goalheight, 0))
    self.script_goalheight = undefined;

  if(scripts\engine\utility::is_equal(self.script_origin_other, (0, 0, 0)))
    self.script_origin_other = undefined;

  if(scripts\engine\utility::is_equal(self.script_count, 0))
    self.script_count = undefined;

  if(scripts\engine\utility::is_equal(self.script_timeout, 0))
    self.script_timeout = undefined;

  if(scripts\engine\utility::is_equal(self.script_dot, 0))
    self.script_dot = undefined;

  if(scripts\engine\utility::is_equal(self.script_dist_only, 0))
    self.script_dist_only = undefined;

  if(scripts\engine\utility::is_equal(self.script_demeanor, "_encstr_8B1608EC43B8D647A113"))
    self.script_demeanor = undefined;

  if(scripts\engine\utility::is_equal(self.script_speed, 0))
    self.script_speed = undefined;

  if(scripts\engine\utility::is_equal(self.script_linkto, "_encstr_8B1608EC43B8D647A113"))
    self.script_linkto = undefined;

  if(scripts\engine\utility::is_equal(self.script_linkname, "_encstr_8B1608EC43B8D647A113"))
    self.script_linkname = undefined;

  if(isDefined(self.script_unload)) {
    if(isstring(self.script_unload) && scripts\engine\utility::is_equal(self.script_unload, "_encstr_B10703DD0F"))
      self.script_unload = undefined;
    else if(isint(self.script_unload) && scripts\engine\utility::is_equal(self.script_unload, -1))
      self.script_unload = undefined;
  }
}

is_door_spawn() {
  var_0 = 32;

  if(isDefined(self.spawnpoint)) {
    if(istrue(self.spawnpoint.door_spawner))
      return 1;
    else if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      if(self.spawnpoint.spawnflags &var_0 && !(self.spawnpoint.spawnflags & 8)) {
        if(isDefined(self.spawnpoint.script_linkto)) {
          var_1 = getEntArray(self.spawnpoint.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

          if(!isDefined(var_1) || var_1.size < 1)
            var_1 = scripts\engine\utility::getStructArray(self.spawnpoint.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

          if(isDefined(var_1) && var_1.size > 0) {
            for(var_2 = 0; var_2 < var_1.size; var_2++) {
              var_3 = var_1[var_2];

              if(isDefined(var_3.targetname) && var_3.targetname == "_encstr_836A0F9FC84F778F097C221725A877A337") {
                if(!isDefined(self.spawnpoint.doors))
                  self.spawnpoint.doors = [var_3];
                else
                  self.spawnpoint.doors[self.spawnpoint.doors.size] = var_3;

                continue;
              }

              if(isDefined(var_1[0].script_noteworthy) && var_1[0].script_noteworthy == "_encstr_BDCD12B9C1C2EECDD7467BB79CFAB94B73B3B195") {
                if(!isDefined(self.spawnpoint.doors)) {
                  self.spawnpoint.doors = [var_3];
                  continue;
                }

                self.spawnpoint.doors[self.spawnpoint.doors.size] = var_3;
              }
            }

            if(isDefined(self.spawnpoint.doors) && self.spawnpoint.doors > 0) {
              self.spawnpoint.door_spawner = 1;
              return 1;
              return;
            }

            return 0;
            return;
            return;
          }

          return 0;
          return;
        } else
          return 0;
      } else
        return 0;
    } else if(isDefined(self.spawnpoint.script_linkto)) {
      var_1 = getEntArray(self.spawnpoint.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

      if(!isDefined(var_1) || var_1.size < 1)
        var_1 = scripts\engine\utility::getStructArray(self.spawnpoint.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");

      if(isDefined(var_1) && var_1.size > 0) {
        for(var_2 = 0; var_2 < var_1.size; var_2++) {
          var_3 = var_1[var_2];

          if(isDefined(var_3.targetname) && var_3.targetname == "_encstr_836A0F9FC84F778F097C221725A877A337") {
            if(!isDefined(self.spawnpoint.doors))
              self.spawnpoint.doors = [var_3];
            else
              self.spawnpoint.doors[self.spawnpoint.doors.size] = var_3;

            continue;
          }

          if(isDefined(var_1[0].script_noteworthy) && var_1[0].script_noteworthy == "_encstr_BDCD12B9C1C2EECDD7467BB79CFAB94B73B3B195") {
            if(!isDefined(self.spawnpoint.doors)) {
              self.spawnpoint.doors = [var_3];
              continue;
            }

            self.spawnpoint.doors[self.spawnpoint.doors.size] = var_3;
          }
        }

        if(isDefined(self.spawnpoint.doors) && self.spawnpoint.doors.size > 0) {
          self.spawnpoint.door_spawner = 1;
          return 1;
          return;
        }

        return 0;
        return;
        return;
      }

      return 0;
      return;
    } else
      return 0;
  } else
    return 0;
}

is_no_squad() {
  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 1;
    else
      return 0;
  } else
    return istrue(self.nosquad);
}

is_armored() {
  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 2;
    else if(istrue(self.wearing_armor))
      return 1;
    else if(istrue(self.equip_armor))
      return 1;
    else
      return 0;
  } else
    return istrue(self.equip_armor);
}

is_patroller() {
  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 128;
    else
      return 0;
  } else
    return istrue(self.script_patroller);
}

is_pacifist() {
  if(istrue(self.pacifist_override))
    return 1;
  else if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 256;
    else
      return 0;
  } else
    return istrue(self.script_pacifist);
}

remove_pacifist_spawn_flag() {
  if(isDefined(self.spawnflags)) {
    if(!isnode(self.spawnpoint) && self.spawnflags & 256)
      self.spawnflags = self.spawnflags - 256;
  }
}

update_script_demeanor_for_all_spawners_in_group(var_0) {
  var_1 = process_module_var(self, self.spawn_points);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isstruct(var_1[var_2]))
      var_1[var_2].script_demeanor = var_0;
  }
}

has_dont_kill_off_flag() {
  if(isDefined(self.birthtime) && self.birthtime >= gettime())
    return 1;

  if(has_never_kill_off_flag())
    return 1;

  if(istrue(self._id_133B6))
    return 0;
  else if(istrue(self.dontkilloff))
    return 1;
  else if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 1024;
    else
      return 0;
  } else
    return 0;
}

has_never_kill_off_flag() {
  if(isDefined(self.birthtime) && self.birthtime >= gettime())
    return 1;

  if(istrue(self.never_kill_off))
    return 1;
  else if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 2048;
    else
      return 0;
  } else
    return 0;
}

should_roam() {
  if(isDefined(self.spawnpoint) && !istrue(spawn_is_vehicle_spawn(self.spawnpoint))) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      if(self.spawnpoint.spawnflags & 512)
        return 0;
      else
        return 1;
    } else
      return 1;
  } else
    return 1;
}

parent_spawner_disable_after_count(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  self notify("_encstr_9A6923C2E12B53E0A369E6D1D9473092FB8FBCB8139ACD40B71997403C55D25FB85DF3F053");
  self endon("_encstr_9A6923C2E12B53E0A369E6D1D9473092FB8FBCB8139ACD40B71997403C55D25FB85DF3F053");
  var_1 endon("_encstr_8BFA0DEB2BA09F80C7F84F31527508");
  var_1 waittill("_encstr_91940E4B73CF5F1D7177EDC36F986207");

  if(isDefined(self.script_count)) {
    self.script_count--;

    if(self.script_count < 1)
      thread disable_spawn_point(self, self.script_timeout, var_0);
  } else if(isDefined(self.script_timeout)) {
    if(!isDefined(self.lastspawntime))
      self.lastspawntime = 0;

    self.lastspawntime = gettime() + self.script_timeout * 1000 + 10000;
  }
}

spawner_disable_after_count(var_0) {
  if(isDefined(self.script_count)) {
    self.script_count--;

    if(self.script_count < 1)
      thread disable_spawn_point(self, self.script_timeout, var_0);
  } else if(isDefined(self.script_timeout)) {
    if(!isDefined(self.lastspawntime))
      spawner_init();

    self.lastspawntime = gettime() + self.script_timeout * 1000 + 10000;
  }
}

init_cluster_parent() {
  define_spawner("_encstr_A95010B1D8BADC1DAC93EBDC0E16BB9BCA4E");
}

watch_for_nearby_disable() {
  for(;;) {
    level waittill("_encstr_961C213D543BCB496C6F099877B9830523712EBF2E138D915ADF01D077C27E91CA65AD", var_0);

    if(distance2dsquared(self.origin, var_0) <= 65536)
      set_default_spawner_values();
  }
}

init_score_data(var_0) {}

get_ideal_dist(var_0) {
  if(!isDefined(var_0.script_noteworthy))
    return 1250;

  if(istrue(var_0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint()))
    return 5000;

  switch (var_0.script_noteworthy) {
    case "_encstr_850707F7E5833355B8":
      return 2500;
    case "_encstr_AD07034A38":
      return 1250;
    case "_encstr_BE1904DCDA9D":
      return 1250;
    case "_encstr_A65B084B38A76BEFC350":
      return 1250;
    case "_encstr_A11904E483B3":
      return 1250;
    case "_encstr_958C08CDDBD8325A959C":
      return 1250;
    case "_encstr_BE7A10F2C0484CB2ADFD6F8FE5411A92F849":
      return 1250;
    case "_encstr_BEC81783359CD043AACBB7D3D3F298A82D4F8E78DFF4C00D93":
      return 1250;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      return 1250;
    case "_encstr_AF6F0FF6308AB914E8A5011BE0B50DB780":
    default:
      return 1250;
  }
}

enemy_monitor(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  update_spawn_data_on_spawn(var_0, var_1);

  if(getdvarint("_encstr_86F516DCC627F519D6D9BECACDACDAD2B26EAFEE161D9527", 0) != 0)
    thread kill_agent_when_in_water();
}

kill_agent_when_in_water() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 10), self.origin + (0, 0, -10), 0, self);
    self.hit_water = var_0["_encstr_8BCA0C2BFD504F333E6D7513637B"] == "_encstr_A28E0F9BEA9C99D1BC83B27DDDC23AB227";

    if(istrue(self.hit_water)) {
      if(istrue(level.bshockactive)) {
        if(isDefined(level.soldiershockfunc))
          self[[level.soldiershockfunc]](2);
      }
    }

    wait 1;
  }
}

update_spawn_data_on_spawn(var_0, var_1) {
  var_2 = 1;

  if(isDefined(self.team)) {
    if(self.team == "_encstr_8E8405EA382B2A") {
      level.spawned_enemies[level.spawned_enemies.size] = self;
      level.current_num_spawned_enemies = level.current_num_spawned_enemies + var_2;
    } else if(self.team == "_encstr_9A8507BA4040188D08")
      level.spawned_allies[level.spawned_allies.size] = self;
  }

  level.spawned_ai[level.spawned_ai.size] = self;

  if(isDefined(var_0)) {
    if(var_0 == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
      level.spawned_juggernauts[level.spawned_juggernauts.size] = self;
      level.current_num_spawned_juggernauts = level.current_num_spawned_juggernauts + var_2;
    }

    if(var_0 == "_encstr_A7E80E1818902B623DBA872BD4C1184C" || var_0 == "_encstr_958C08CDDBD8325A959C") {
      level.spawned_soldiers[level.spawned_soldiers.size] = self;
      level.current_num_spawned_soldiers = level.current_num_spawned_soldiers + var_2;
    }
  }
}

_update_spawn_data_on_death(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_B4841B67519DBADC88764A92A9C01E91658BEBAFA7B012BFE819C69B60");
  self waittill("_encstr_AD75063D571AE108");
  thread update_spawn_data_on_death(var_0, var_1);
}

remove_from_kill_off_list() {
  if(isDefined(level.can_kill_off_list)) {
    if(isDefined(self.entity_number) && isDefined(level.can_kill_off_list[self.entity_number]))
      level.can_kill_off_list[self.entity_number] = undefined;
    else if(isDefined(level.can_kill_off_list[self getentitynumber()]))
      level.can_kill_off_list[self getentitynumber()] = undefined;

    if(level.can_kill_off_list.size < 1)
      level notify("_encstr_8310136EE87B83AFDA96C6C6BEB799CCF536BDEDE0");
  }
}

update_spawn_data_on_death(var_0, var_1) {
  self notify("_encstr_B4841B67519DBADC88764A92A9C01E91658BEBAFA7B012BFE819C69B60");
  self endon("_encstr_B4841B67519DBADC88764A92A9C01E91658BEBAFA7B012BFE819C69B60");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread remove_from_kill_off_list();

  if(!isDefined(self.group))
    level notify("_encstr_9B9E11234787E2E2F02B627EE1483EDA08FBB3");

  var_2 = 1;

  if(isDefined(self.cargo_truck_mg_initdamage)) {
    if(isDefined(self.cargo_truck_mg_initdamage.cargo_truck_mg_gunnerdamagemodignorefunc)) {
      self.cargo_truck_mg_initdamage.cargo_truck_mg_gunnerdamagemodignorefunc--;

      if(self.cargo_truck_mg_initdamage.cargo_truck_mg_gunnerdamagemodignorefunc < 1)
        self.cargo_truck_mg_initdamage.cargo_truck_mg_gunnerdamagemodignorefunc = 0;
    }
  }

  if(isDefined(self.team)) {
    if(self.team == "_encstr_8E8405EA382B2A") {
      if(scripts\engine\utility::array_contains(level.spawned_enemies, self)) {
        level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, self);
        level.current_num_spawned_enemies = level.current_num_spawned_enemies - var_2;
      }
    } else if(self.team == "_encstr_9A8507BA4040188D08") {
      if(scripts\engine\utility::array_contains(level.spawned_allies, self))
        level.spawned_allies = scripts\engine\utility::array_remove(level.spawned_allies, self);
    }
  }

  remove_from_enemy_list();

  if(isDefined(self.ridingvehicle))
    self.ridingvehicle thread scripts\cp\utility::add_to_notify_queue("_encstr_8FC80F3885E63756DCCE5693EB235ACA8C");

  if(scripts\engine\utility::array_contains(level.spawned_ai, self))
    level.spawned_ai = scripts\engine\utility::array_remove(level.spawned_ai, self);

  if(isDefined(self.group)) {
    var_3 = is_my_group_an_active_module();

    if(self.group get_activecount_from_group() - var_2 >= 1)
      self.group.activecount = int(clamp(self.group.activecount - var_2, 0, self.group.activecount - var_2));
    else
      self.group.activecount = 0;

    self.group.ai_spawned = scripts\engine\utility::array_remove(self.group.ai_spawned, self);

    if(var_3) {
      if(!istrue(self.died_poorly))
        self.group.currentmodulekills = self.group.currentmodulekills + var_2;
    } else
      self.group.currentmodulekills = self.group.currentmodulekills + var_2;

    var_4 = process_module_var(self.group, self.group.totalspawns);

    if(isDefined(var_4) && var_4 > 0) {
      if(var_3 && self.group.currentmodulekills >= var_4) {
        self.group notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + self.group.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
        self.group notify("_encstr_AA5E19F7B6605F9A3FE0737AD88514FBD9887B6741EB63E741B83A");
        self.group notify("_encstr_B2F615527B828A3B61E9C72BF8B90139BFFBC90BA732A3");
        level notify("_encstr_AA5E19F7B6605F9A3FE0737AD88514FBD9887B6741EB63E741B83A");

        if(self.group get_activecount_from_group(1) < 1) {
          scripts\cp\cp_spawning_util::_id_12BD3(self.group);
          self.group notify("_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591");

          if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
            level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

            if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1)
              level.spawn_module_structs_memory[self.group.group_name] = undefined;
          }
        }
      } else if(!var_3 && self.group get_activecount_from_group(1) < 1) {
        scripts\cp\cp_spawning_util::_id_12BD3(self.group);
        self.group notify("_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591");

        if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
          level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

          if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1)
            level.spawn_module_structs_memory[self.group.group_name] = undefined;
        }
      } else if(var_3 && self.group get_activecount_from_group(1) < 1)
        self.group notify("_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF");
    } else if(!var_3 && self.group get_activecount_from_group(1) < 1) {
      scripts\cp\cp_spawning_util::_id_12BD3(self.group);
      self.group notify("_encstr_8D1B162CB1B1D7B339BDEA83BEDC0EB0BBCDB9FA912B8591");

      if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
        level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

        if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1)
          level.spawn_module_structs_memory[self.group.group_name] = undefined;
      }
    } else if(var_3 && self.group get_activecount_from_group(1) < 1)
      self.group notify("_encstr_8FB91D11DEE3CFFBABA1428A2087F7EBF8BD88B76ECB374355E8A9022BD3EF");

    if(!istrue(self.died_poorly))
      thread run_group_death_funcs();
    else
      thread _id_12DDD();

    if(scripts\cp\cp_spawning_util::group_has_combined_counters(self.group.group_name)) {
      var_5 = self.group scripts\cp\cp_spawning_util::propwatchdeath();

      if(isDefined(var_5)) {
        var_6 = level.hideallunselectedextractpads[var_5];

        if(isDefined(var_6) && var_6.size > 0) {
          for(var_7 = 0; var_7 < var_6.size; var_7++)
            level thread send_notify_to_groups_from_groupname(var_6[var_7].group_name, "_encstr_8D1114AAB66D3016451F1210E3DB37EFE0B7733FF0E7", var_6[var_7] get_activecount_from_group());
        } else
          level thread send_notify_to_groups_from_groupname(self.group.group_name, "_encstr_8D1114AAB66D3016451F1210E3DB37EFE0B7733FF0E7", self.group get_activecount_from_group());
      } else
        level thread send_notify_to_groups_from_groupname(self.group.group_name, "_encstr_8D1114AAB66D3016451F1210E3DB37EFE0B7733FF0E7", self.group get_activecount_from_group());
    } else
      level thread send_notify_to_groups_from_groupname(self.group.group_name, "_encstr_8D1114AAB66D3016451F1210E3DB37EFE0B7733FF0E7", self.group get_activecount_from_group());
  }

  if(isDefined(self.unittype)) {
    if(isDefined(self.unittype) && self.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
      level.spawned_juggernauts = scripts\engine\utility::array_remove(level.spawned_juggernauts, self);
      level.current_num_spawned_juggernauts = level.current_num_spawned_juggernauts - var_2;
    }

    if(self.unittype == "_encstr_958C08CDDBD8325A959C") {
      level.spawned_soldiers = scripts\engine\utility::array_remove(level.spawned_soldiers, self);
      level.current_num_spawned_soldiers = level.current_num_spawned_soldiers - var_2;
    }
  }
}

toggle_force_stop_wave_from_groupname(var_0, var_1, var_2) {
  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_3 = 0; var_3 < level.spawn_module_structs_memory[var_0].size; var_3++) {
      level.spawn_module_structs_memory[var_0][var_3].stop_wave_spawning = var_1;

      if(!istrue(var_1))
        level.spawn_module_structs_memory[var_0][var_3] notify("_encstr_8A2A0BBF610B8F89833BC79BE3");

      if(isDefined(var_2))
        level.spawn_module_structs_memory[var_0][var_3] change_module_status(undefined, var_2);
    }
  }
}

get_spawn_count_from_groupname(var_0) {
  var_1 = 0;

  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_2 = 0; var_2 < level.spawn_module_structs_memory[var_0].size; var_2++) {
      if(isDefined(level.spawn_module_structs_memory[var_0][var_2].spawn_count))
        var_1 = var_1 + level.spawn_module_structs_memory[var_0][var_2].spawn_count;
    }
  }

  return var_1;
}

barkov_crawl_scene_nostab(var_0) {
  var_0.spawn_count++;
}

_id_1393E(var_0) {
  var_0.spawn_count--;
}

reset_spawn_count_from_groupname(var_0) {
  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_1 = 0; var_1 < level.spawn_module_structs_memory[var_0].size; var_1++) {
      if(isDefined(level.spawn_module_structs_memory[var_0][var_1].spawn_count))
        level.spawn_module_structs_memory[var_0][var_1].spawn_count = 0;
    }
  }
}

send_notify_to_groups_from_groupname(var_0, var_1, var_2, var_3) {
  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_4 = 0; var_4 < level.spawn_module_structs_memory[var_0].size; var_4++) {
      var_5 = level.spawn_module_structs_memory[var_0][var_4];
      var_5 thread scripts\cp\utility::add_to_notify_queue(var_1, var_2);
    }
  }
}

get_activecount_from_group(var_0) {
  if(istrue(self._id_133BE))
    return self._id_11CB0;
  else {
    var_1 = 0;

    if(!istrue(var_0) && isDefined(self.hide_rocket_fuel_readings_to_player)) {
      var_2 = level.hideallunselectedextractpads[self.hide_rocket_fuel_readings_to_player];

      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        var_4 = var_2[var_3];

        if(isDefined(var_4.activecount))
          var_1 = var_1 + var_4.activecount;
      }
    } else if(isDefined(self.activecount))
      var_1 = self.activecount;

    return var_1;
  }
}

set_wave_settings_for_all_with_groupname(var_0, var_1, var_2, var_3) {
  if(isDefined(level.active_spawn_module_structs[var_0])) {
    for(var_4 = 0; var_4 < level.active_spawn_module_structs[var_0].size; var_4++) {
      var_5 = level.active_spawn_module_structs[var_0][var_4];
      var_5.wave_reference = var_1;
      var_5.last_wave_ref = var_2;
      var_5.last_wave_num = var_3;
    }
  }
}

toggle_teleport_enemy_info_loop(var_0) {
  self.should_teleport_to_nearby_target = 1;
}

stay_passive_if_not_weapons_free() {
  if(!scripts\engine\utility::flag("_encstr_BE070EA54FD75257215867A710D932BA")) {
    self.pacifist_override = 1;
    set_demeanor_from_unittype("_encstr_96080730D8534E0A28");
    enter_combat_after_stealth();
    watch_for_ai_events();
  }
}

set_aggro_flag_on_enter_combat() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_86A91FCD563AFA2CB3CEC9DEFACC362CB37DDBCDAFACDC479539EB6CEDB598B03A");
  self endon("_encstr_86A91FCD563AFA2CB3CEC9DEFACC362CB37DDBCDAFACDC479539EB6CEDB598B03A");
  self waittill("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self.group notify("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + self.group.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
  scripts\engine\utility::flag_set("_encstr_BE070EA54FD75257215867A710D932BA");
}

pre_wave_weapons_free(var_0) {
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

set_pre_wave_spawning_spawn_funcs(var_0) {
  if(getdvarint("_encstr_9103201BB71B4F803A7857D7AA732FA10B9FC84F5937C8F00749EF76BC92E32E63BB", 1)) {
    var_1 = scripts\engine\utility::getStructArray("_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_2 = scripts\engine\utility::getclosest(self.origin, var_1);

    if(isDefined(var_2) && isDefined(var_2.script_linkname))
      self.script_linkto = var_2.script_linkname;
  } else
    thread set_script_origin_other_to_center_of_players();

  var_3 = self;
  var_3.sightmaxdistance = 2200;
  var_3.pacifist_override = 1;
  var_3 thread scripts\cp\coop_stealth::run_common_functions(var_3, 1, 1, 60, 250000);
}

set_script_origin_other_to_center_of_players() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(istrue(self.entered_combat)) {
      break;
    }

    self.script_origin_other = scripts\cp\utility::get_center_point_of_array(level.players);
    wait 2;
  }
}

toggle_kamikaze_for_group(var_0, var_1) {
  var_0.kamikaze = var_1;
}

numfound() {
  if(!isDefined(self.group)) {
    var_0 = ["_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", "_encstr_BA730BF8AFF178988293F158B9", "_encstr_92A70ABB8267F5E0D89F6351", "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", "_encstr_8823119675DAFF897F878020BB99612B219D8F", "_encstr_B8D30758E3EE7827BA"];
    var_1 = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];
  } else {
    var_0 = self.group.set_chosen_spawner_from_uid;
    var_1 = self.group.serverroomrewardroll;
  }

  var_2 = scripts\engine\utility::array_sum(var_1);
  var_3 = randomfloatrange(0.0, var_2);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_4 = var_4 + var_1[var_5];

    if(var_4 >= var_3) {
      self.grenadeweapon = getcompleteweaponname(var_0[var_5]);
      self.grenadeammo = 2;
      return;
    }
  }
}

propwaitminigamehudinit(var_0) {
  if(isDefined(var_0) && isDefined(var_0.set_chosen_spawner_from_uid))
    return;
}

select_patrol_nine_spawners(var_0) {
  _id_12BF1();
  thread circleorigin(var_0);
}

calloutmarkerpingvohandlerpool(var_0) {
  give_soldier_armor();
  thread circleorigin(var_0);
}

circleorigin(var_0) {
  if(isDefined(self.script_origin_other)) {
    return;
  }
  if(istrue(self._id_133B2)) {
    return;
  }
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }
  self notify("_encstr_96BD0D89D20F0BA061D3777BFAD620");
  self endon("_encstr_96BD0D89D20F0BA061D3777BFAD620");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(!istrue(self.entered_combat))
    self waittill("_encstr_92600D68A25B83032F3BE8D112FF0B");

  if(isDefined(self.a) && !is_specified_unittype("_encstr_8BFC0BC2CBD4F737E0A5E1FD79") && !istrue(self.clearsoundsubmixmpbrinfilanim))
    self.a.disablelongdeath = 0;
  else
    self.a.disablelongdeath = 1;

  numfound();

  if(!scripts\cp\utility::turn_off_sniper_laser())
    self.maxfaceenemydist = 1200;

  set_goal_radius(2048);
  var_1 = randomintrange(10, 20);
  wait(var_1);

  while(istrue(self.playing_skit))
    wait 1;

  set_goal_radius(1536);
  var_1 = randomintrange(10, 20);
  wait(var_1);

  while(istrue(self.playing_skit))
    wait 1;

  if(!scripts\cp\utility::turn_off_sniper_laser())
    self.aggressivemode = 1;

  self.ignoresuppression = 1;
  set_goal_radius(1024);
  var_1 = randomintrange(10, 20);
  wait(var_1);

  while(istrue(self.playing_skit))
    wait 1;

  set_goal_radius(512);
}

wave_go_kamikaze(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0)) {
    var_0 notify("_encstr_971711EEB0B3597DD9EDD7B685B62DAD2CF4AC");
    var_0 endon("_encstr_971711EEB0B3597DD9EDD7B685B62DAD2CF4AC");
    var_0 endon("_encstr_AD75063D571AE108");

    if(isDefined(var_0.timeout_after_min_count) && var_0.timeout_after_min_count > 0) {
      scripts\cp\cp_wave_spawning::_id_13F81(0, var_0);
      var_0 thread timeout_wave(var_0.timeout_after_min_count);
    }
  }

  wait 1.5;
  level notify("_encstr_A69A0C9B62ABDD913F0E918326E7");
}

_id_1451F(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
  level notify("_encstr_9926128B3E1E40C012FF53515F8A94989F971061");
  level endon("_encstr_9926128B3E1E40C012FF53515F8A94989F971061");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }
  var_1 = 0;
  var_2 = 45;
  var_3 = int(var_2 / 2);

  for(;;) {
    var_4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

    if(var_4.size == 0)
      var_1++;

    if(var_1 >= var_2) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_wave_spawning::_id_13F81(0, var_0);
  var_0 thread timeout_wave(var_0.timeout_after_min_count);
}

timeout_wave(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
  level endon("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
  self endon("_encstr_AD75063D571AE108");
  setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 0);

  if(getdvarint("_encstr_A18B12E63693D7DD85CE95EB3A4BB6B2D7E6ACE8", -1) != -1)
    var_0 = getdvarint("_encstr_A18B12E63693D7DD85CE95EB3A4BB6B2D7E6ACE8", -1);

  if(isDefined(level._id_14529) && level._id_14529 > 10)
    var_0 = level._id_14529;

  notify_all_groups_in_module(self.group_name, "_encstr_AC99123C6BF8183640FFA04151945B1D4130BB53");
  toggle_force_stop_wave_from_groupname(self.group_name, 1, "_encstr_ADCF0B1F60D07BD1F99228B747");
  toggle_force_stop_wave_from_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", 1, "_encstr_ADCF0B1F60D07BD1F99228B747");
  wave_cooldown_time(var_0);
  scripts\cp\cp_wave_spawning::_id_13F81(0, self);

  if(!istrue(self.disable_wave_hud)) {
    wait 0.1;

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      level.players[var_1] thread scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
      level.players[var_1] thread scripts\cp\cp_hud_message::showsplash("_encstr_AD380EFAC3600F8E682BB7952520578B", level.logfriendlyfire, undefined);

      if(level.logfriendlyfire >= 20)
        level.players[var_1] thread playerhudupdatenumconsumed();
    }
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    thread _id_14521();

    if(var_0 > 10.1) {
      wait(var_0 - 10);

      for(var_1 = 0; var_1 < 10; var_1++) {
        setomnvar("_encstr_959613C61CF5C6DBBACD478CDEDDB9BEB1BD36B74E", 2);
        wait 1;
      }
    } else
      wait(var_0);
  } else
    wait(var_0);

  setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", 0);
  scripts\cp\cp_wave_spawning::increase_wave_num();
  run_func_on_group_by_groupname(self.group_name, [::toggle_kamikaze_for_group, undefined]);
  toggle_force_stop_wave_from_groupname(self.group_name, undefined, "_encstr_B44C123693E089BFD7A32289EBB51F3A1013BE87");
  toggle_force_stop_wave_from_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", undefined, "_encstr_B44C123693E089BFD7A32289EBB51F3A1013BE87");
}

_id_14521() {
  wait 2.5;
  level notify("_encstr_8F6D16E8A5DA2BDEAED17DDD85ECCAAF6CDBB538C6591DAC");
}

playerhudupdatenumconsumed() {
  self notify("_encstr_ACD31B4E906BAF47A7289A63D04F3B5F030DEFC338D0AB4D8B88820A90");
  self endon("_encstr_ACD31B4E906BAF47A7289A63D04F3B5F030DEFC338D0AB4D8B88820A90");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    scripts\mp\ammorestock::_id_12062();
    wait 5;
  }
}

notify_all_groups_in_module(var_0, var_1) {
  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_2 = 0; var_2 < level.spawn_module_structs_memory[var_0].size; var_2++)
      level.spawn_module_structs_memory[var_0][var_2] notify(var_1);
  }
}

group_wait_for_activecount_notify(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AC99123C6BF8183640FFA04151945B1D4130BB53");

  for(;;) {
    self waittill("_encstr_8D1114AAB66D3016451F1210E3DB37EFE0B7733FF0E7", var_1);

    if(getdvarfloat("_encstr_998A1B68C26A4713877EBDB8548B7B8B92DA1018CA4959E86F95B0A54C", 0) != 0)
      childthread start_threshold_timeout(getdvarfloat("_encstr_998A1B68C26A4713877EBDB8548B7B8B92DA1018CA4959E86F95B0A54C"));

    if(var_1 <= var_0) {
      self notify("_encstr_8E5118B3859173AB0F0822BBB86F64CFE865174C93B897353360");
      break;
    }
  }
}

start_threshold_timeout(var_0) {
  self notify("_encstr_8E5118B3859173AB0F0822BBB86F64CFE865174C93B897353360");
  self endon("_encstr_8E5118B3859173AB0F0822BBB86F64CFE865174C93B897353360");
  wait(var_0);
  self notify("_encstr_AC99123C6BF8183640FFA04151945B1D4130BB53");
}

run_group_death_funcs() {
  if(isDefined(self.group) && isDefined(self.group.ai_death_func)) {
    for(var_0 = 0; var_0 < self.group.ai_death_func.size; var_0++)
      self thread[[self.group.ai_death_func[var_0]]]();
  }
}

is_my_group_an_active_module() {
  var_0 = getarraykeys(level.active_spawn_module_structs);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = level.active_spawn_module_structs[var_0[var_1]];

    if(isarray(var_2)) {
      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        if(var_2[var_3] == self.group)
          return 1;
      }

      continue;
    }

    if(var_2 == self.group)
      return 1;
  }

  return 0;
}

get_total_reserved_slot_count() {
  var_0 = 0;

  foreach(var_2 in level.reserved_spawn_slots)
  var_0 = var_0 + var_2;

  return var_0;
}

get_reserved_slot_count_by_string_id(var_0) {
  if(isDefined(var_0) && isDefined(level.reserved_spawn_slots[var_0]))
    return level.reserved_spawn_slots[var_0];
  else
    return 0;
}

increase_reserved_spawn_slots(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(!isDefined(level.reserved_spawn_slots[var_1]))
      level.reserved_spawn_slots[var_1] = 0;
  } else
    var_1 = "_encstr_8B1608EC43B8D647A113";

  level.reserved_spawn_slots[var_1] = level.reserved_spawn_slots[var_1] + var_0;
  allowed_to_spawn_agent(var_2, 1, level.reserved_spawn_slots[var_1], var_1);
}

decrease_reserved_spawn_slots(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(level.reserved_spawn_slots[var_1])) {
      var_2 = level.reserved_spawn_slots[var_1];
      level.reserved_spawn_slots[var_1] = int(clamp(var_2 - var_0, 0, var_2 - var_0));

      if(level.reserved_spawn_slots[var_1] < 1) {
        level.reserved_spawn_slots[var_1] = undefined;
        return;
      }
    } else {}
  } else {
    var_1 = "_encstr_8B1608EC43B8D647A113";

    if(isDefined(level.reserved_spawn_slots[var_1])) {
      var_2 = level.reserved_spawn_slots[var_1];
      level.reserved_spawn_slots[var_1] = int(clamp(var_2 - var_0, 0, var_2 - var_0));

      if(level.reserved_spawn_slots[var_1] < 1) {
        level.reserved_spawn_slots[var_1] = undefined;
        return;
      }
    } else {}
  }
}

increase_delayed_spawn_slots(var_0) {
  level.delayed_spawn_slots = level.delayed_spawn_slots + var_0;
}

decrease_delayed_spawn_slots(var_0) {
  level.delayed_spawn_slots = level.delayed_spawn_slots - var_0;
}

fake_flashlight(var_0) {
  self notify("_encstr_975E102AE35F05170399E9A0C920D1BFF838");
  self endon("_encstr_975E102AE35F05170399E9A0C920D1BFF838");
  self endon("_encstr_AD75063D571AE108");

  if(getdvarint("_encstr_978219322DE6B013D8567D2BE62B5BBC7D991B586E1A634BCE1AD1", 0) != 0) {
    return;
  }
  wait 0.25;
  var_1 = "_encstr_A3840F30E263F934CA97FFF19BA28C082C";

  if(isDefined(var_0))
    var_1 = var_0;

  if(!isDefined(level._effect[var_1])) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "_encstr_A14F0AE336178944BA076F41";
  var_2[var_2.size] = "_encstr_84DC0A330F0AF9CAE3308079";
  var_2[var_2.size] = "_encstr_AC510D9BF16C9F3AA0299D6ECF3882";

  foreach(var_4 in var_2) {
    if(isDefined(self gettagorigin(var_4, 1))) {
      playFXOnTag(level._effect[var_1], self, var_4);
      scripts\engine\utility::_id_143A8("_encstr_BA22087EA808525BA5D9", "_encstr_84C80FD3603FC30B79FD97B0818147CF6D", "_encstr_92600D68A25B83032F3BE8D112FF0B", "_encstr_82B21DB109F84A0BF849FAD3B1BB07852BE3213D8F7117730583A0AA989FAF", "_encstr_938C091AC8B8AFFB036D37");
      stopFXOnTag(level._effect[var_1], self, var_4);
      break;
    }
  }
}

enter_combat(var_0) {
  if(istrue(self.aggressive) || istrue(self.dont_enter_combat)) {
    return;
  }
  self notify("_encstr_BA22087EA808525BA5D9");
  self notify("_encstr_92600D68A25B83032F3BE8D112FF0B");
  self notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  set_kill_off_time();
  set_demeanor_from_unittype("_encstr_AA7C07466F9DA30713");

  if(getdvarint("_encstr_A10715BBE1B6EFCED01FC7C551A09463551E4242698DD7", 0))
    scripts\cp\cp_outline::enable_outline_for_players(self, level.players, "_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40", "_encstr_9ACC05B41B7F32");

  self.pacifist_override = undefined;
  self.scripted_mode = 0;
  self.entered_combat = 1;
  self.script_pacifist = undefined;
  self.pacifist = 0;
  self.currentnode = undefined;

  if(!is_specified_unittype("_encstr_8BFC0BC2CBD4F737E0A5E1FD79")) {
    var_1 = randomintrange(180, 220);
    scripts\engine\utility::set_movement_speed(var_1);
  }

  if(!is_specified_unittype("_encstr_8EF60E63FBE3D70440A312175B98CF6B") && !is_specified_unittype("_encstr_83E8094727E333E8F9CE50"))
    thread get_enemy_info_loop();

  run_combat_func();
}

run_combat_func(var_0, var_1) {
  if(isDefined(self.combat_func_override))
    var_2 = self.combat_func_override;
  else
    var_2 = self.aitype;

  if(isDefined(var_2)) {
    if(isDefined(level.aitypes[var_2]) && isDefined(level.aitypes[var_2].combat_func)) {
      if(isDefined(var_0) && isDefined(var_1))
        self thread[[level.aitypes[var_2].combat_func]](var_0, var_1);
      else if(isDefined(var_0))
        self thread[[level.aitypes[var_2].combat_func]](var_0);
      else
        self thread[[level.aitypes[var_2].combat_func]]();
    }
  }
}

get_enemy_info_loop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8BCB143FF560013B7D6DF9139163F8B527B9F44F95DB");
  self endon("_encstr_8BCB143FF560013B7D6DF9139163F8B527B9F44F95DB");
  self endon("_encstr_AD75063D571AE108");

  if(istrue(self.attempting_teleport)) {
    self.ignoreall = 0;
    self.is_on_platform = undefined;
    self.attempting_teleport = undefined;
    self show();
    set_kill_off_time(20.0);
  }

  if(!isDefined(var_0))
    var_0 = 2;

  var_1 = 0;
  var_2 = 1;
  var_3 = projectilewaittilstucktimeout();
  var_4 = ::prepickupweapon;
  var_5 = ::progression_main;

  for(;;) {
    if(_id_132DB()) {
      var_1 = 0;
      self.target_enemy = undefined;
    } else {
      var_7 = var_3;

      if(var_2)
        var_7 = undefined;

      var_6 = self[[var_4]](var_7);
      var_8 = self[[var_5]](var_7, var_6);

      if(isDefined(var_8)) {
        var_2 = 0;

        if(isDefined(self.script_origin_other))
          var_9 = self.script_origin_other;
        else
          var_9 = var_8.origin;

        if(scripts\cp\utility::turn_off_sniper_laser())
          set_goal_pos_check_for_offset(var_8.origin);
        else if(!has_dont_kill_off_flag() && z_is_excessive(var_9)) {
          if(passed_kill_off_time_checks(gettime()))
            teleport_to_nearby_spawner("_encstr_B1761493B828E8A813EED677D627D2309720F3D770E3", var_9);
        } else {
          set_kill_off_time(var_0);
          set_demeanor_from_unittype("_encstr_AA7C07466F9DA30713");

          if(isDefined(self.goal_pos_override) && !isDefined(self.last_set_goalent)) {
            self.goal_pos_override = undefined;
            set_goal_radius(self.last_goalradius);
          }

          update_target_player(var_8);

          if(isDefined(self.group))
            self.group scripts\engine\utility::ent_flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

          if(isDefined(self.script_goalvolume))
            self setgoalvolumeauto(self.script_goalvolume);
          else {
            self cleargoalvolume();

            if(!istrue(self.combat_func_active)) {
              if(!istrue(self.is_on_platform) && isDefined(self.engagemaxdist)) {
                var_10 = 6;

                if(self seerecently(var_8, var_10)) {
                  var_11 = distancesquared(var_9, self.origin);
                  var_12 = var_11 <= self.engagemaxdist * self.engagemaxdist;

                  if(istrue(var_1) && var_12 || isDefined(var_8.vehicle_riding_on)) {
                    var_1 = 0;
                    set_goal_pos_check_for_offset(self.origin);
                  } else if(!istrue(var_1) && !var_12) {
                    var_1 = 1;
                    set_goal_pos_check_for_offset(var_8.origin);
                  }
                } else {
                  var_1 = 1;
                  set_goal_pos_check_for_offset(var_8.origin);
                }
              } else {
                self.goal_pos_override = undefined;
                set_goal_pos_check_for_offset(self.origin);
              }
            }
          }
        }
      } else if(!istrue(self.combat_func_active)) {
        var_1 = 0;
        self.target_enemy = undefined;
        self.goal_pos_override = undefined;

        if(isDefined(self.script_origin_other))
          set_goal_pos_check_for_offset(self.script_origin_other);
        else if(istrue(self.is_on_platform))
          set_goal_pos_check_for_offset(self.origin);
        else if(isDefined(self.script_goalvolume))
          self setgoalvolumeauto(self.script_goalvolume);
        else if(!has_dont_kill_off_flag()) {
          if(passed_kill_off_time_checks(gettime()))
            teleport_to_nearby_spawner("_encstr_8A5A1091E5389CD08AE783A89E34C5ABDAC0", self.origin);
          else {
            set_goal_pos_check_for_offset(self.origin);
            set_demeanor_from_unittype("_encstr_931904C66102");
          }
        } else {
          set_goal_pos_check_for_offset(self.origin);
          set_demeanor_from_unittype("_encstr_931904C66102");
        }
      }
    }

    wait(var_0);
  }
}

projectilewaittilstucktimeout() {
  if(isDefined(self.group)) {
    if(isDefined(self.group.spawn_scoring_overrides))
      var_0 = self.group.spawn_scoring_overrides._id_13BDB;
    else if(istrue(self.group.cqb_module))
      var_0 = 2333;
    else
      var_0 = 4096;
  } else if(istrue(level.spawn_scoring_overrides))
    var_0 = level.spawn_scoring_overrides._id_13BDB;
  else
    var_0 = 4096;

  var_0 = int(min(var_0, 2500));
  return var_0;
}

_id_132DB() {
  if(istrue(self.ignoreall) || istrue(self.scripted_mode))
    return 1;
  else
    return 0;
}

prepdoorsforunload() {
  for(var_0 = 0; var_0 < level.players.size; var_0++)
    self getenemyinfo(level.players[var_0]);
}

prepickupweapon(var_0) {
  self notify("_encstr_9AD51FFF251BEFD651E0897308A308DF73967F75C8416F980FD0620A288785970B");
  self endon("_encstr_9AD51FFF251BEFD651E0897308A308DF73967F75C8416F980FD0620A288785970B");
  var_1 = [];

  if(!scripts\engine\utility::is_equal(self.demeanoroverride, "_encstr_AA7C07466F9DA30713")) {
    self endon("_encstr_AD75063D571AE108");
    wait 5;
  }

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(quickdropremoveammofrominventory(level.players[var_2]))
      var_1[var_1.size] = level.players[var_2];
  }

  return var_1;
}

quickdropremoveammofrominventory(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var_0.warp_player_debug = gettime();
    self getenemyinfo(var_0);
    return 1;
  }

  var_1 = 5;
  var_2 = 5;

  if(self seerecently(var_0, var_1)) {
    var_0.warp_player_debug = gettime();
    self getenemyinfo(var_0);
    return 1;
  } else if(isDefined(var_0.warp_player_debug) && gettime() < var_0.warp_player_debug + var_2 * 1000) {
    self getenemyinfo(var_0);
    return 1;
  } else if(isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, var_0.origin) < 262144 && self pathdisttogoal() < 2048)
    return 1;

  return 0;
}

z_is_excessive(var_0) {
  var_1 = self.origin;
  var_2 = 256;

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper())
    var_2 = 512;

  var_3 = undefined;

  if(isDefined(var_0))
    var_3 = var_0[2];

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(!isDefined(var_0))
      var_3 = level.players[var_4].origin[2];

    if(int(abs(var_1[2] - var_3)) >= var_2 && !spawnsighttrace(undefined, level.players[var_4].origin, var_1))
      return 1;
  }

  return 0;
}

set_goal_pos_to_center_of_nearby_ai() {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.goal_pos_override))
    set_goal_radius(1024);

  var_0 = level.spawned_enemies;
  var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, 10);
  var_2 = scripts\cp\utility::get_center_point_of_array(var_1);

  if(!isDefined(self.goal_pos_override) || distance2dsquared(self.goal_pos_override, var_2) >= 262144) {
    self.goal_pos_override = var_2;
    set_goal_pos(self.goal_pos_override);
  }

  wait 5;
}

has_seen_any_player_recently_watcher() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 10;
  var_1 = gettime() / level.frameduration % var_0;
  var_2 = self getentitynumber() % var_0;

  if(var_1 != var_2)
    wait((var_2 + var_0 - var_1) % var_0 * level.frameduration / 1000);

  while(has_seen_any_player_recently())
    wait 0.5;
}

has_seen_any_player_recently() {
  var_0 = 3;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(self seerecently(level.players[var_1], var_0))
      return 1;
  }

  if(!vo_nag_hangar())
    return 1;

  return 0;
}

teleport_to_nearby_spawner(var_0, var_1, var_2) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }
  if(istrue(self.marked_for_death) || istrue(self.attempting_teleport)) {
    return;
  }
  if(has_never_kill_off_flag()) {
    if(isDefined(var_0)) {
      if(getdvarint("_encstr_A105199B369CF56E34DEBBAF8EB2B1B21C7B4E3AFA39ACB0CDF6CD", 0)) {
        var_3 = 1;

        if(isDefined(var_1)) {
          if(var_3)
            announcement("_encstr_BD5410C631D7ED9E1D9C4D4E2D0987EB9DDA" + self.origin + "_encstr_BEF31ECE08FB9B45D099D047815273A1326D5307B38B529905AEEA0813E96A81" + var_0);
        } else if(var_3)
          announcement("_encstr_BD5410C631D7ED9E1D9C4D4E2D0987EB9DDA" + self.origin + "_encstr_BEF31ECE08FB9B45D099D047815273A1326D5307B38B529905AEEA0813E96A81" + var_0);
      }
    }
  } else if(istrue(self.playeriszombie) || !isDefined(self.group))
    script_kill_ai();
  else {
    self endon("_encstr_AD75063D571AE108");
    self notify("_encstr_B4041BE8B236AC0EBDC91DBE8EDE7D9B95164E4CF2AFB9E00BDDE69527");
    self endon("_encstr_B4041BE8B236AC0EBDC91DBE8EDE7D9B95164E4CF2AFB9E00BDDE69527");

    if(getdvarint("_encstr_A105199B369CF56E34DEBBAF8EB2B1B21C7B4E3AFA39ACB0CDF6CD", 0))
      self hudoutlineenable("_encstr_9BB71A270D8301521D4B19A0BBD184386DF713A8B30BD96D9306FB5F");

    if(getdvarint("_encstr_8619139B8D397D31D8DE6CD6AFE82BB12B07B793E8", 0)) {
      self notify("_encstr_8BCB143FF560013B7D6DF9139163F8B527B9F44F95DB");
      self.ignoreall = 1;
      self.ignoreme = 1;
      self.marked_for_death = 1;
      set_goal_pos(self.origin);
      self waittill("_encstr_ABA008615A631510C7EA");
    }

    if(!isDefined(var_2))
      var_2 = 1;

    if(var_2)
      has_seen_any_player_recently_watcher();

    if(istrue(self.playing_skit))
      script_kill_ai(1);
    else {
      if(is_riding_vehicle()) {
        script_kill_ai();
        return;
        return;
      }

      var_4 = choose_spawnpoint(self.group, 1, self);

      if(isDefined(var_4)) {
        if(isDefined(var_0)) {
          if(getdvarint("_encstr_A105199B369CF56E34DEBBAF8EB2B1B21C7B4E3AFA39ACB0CDF6CD", 0)) {
            var_3 = 1;

            if(isDefined(var_1)) {
              if(var_3)
                announcement("_encstr_87BF0BC14FA81D5B9FB9DB07A9" + self.origin + "_encstr_8CC216013A59D8590E7B9C1D59198026B26C85D537954702" + var_0);
            } else if(var_3)
              announcement("_encstr_87BF0BC14FA81D5B9FB9DB07A9" + self.origin + "_encstr_8CC216013A59D8590E7B9C1D59198026B26C85D537954702" + var_0);
          }
        }

        var_4 notify("_encstr_91940E4B73CF5F1D7177EDC36F986207", var_4);
        self endon("_encstr_AD75063D571AE108");
        self.combat_func_active = undefined;
        self.attempting_teleport = 1;
        self.ignoreall = 1;
        set_kill_off_time(20.0);
        self hide();
        var_4 set_default_spawner_values();
        wait 0.1;
        self dontinterpolate();
        var_5 = (0, 0, 0);

        if(isDefined(var_4.angles))
          var_5 = var_4.angles;

        self forceteleport(var_4.origin, var_5, 10000, 1);
        self.goal_pos_override = undefined;
        set_goal_pos(self.origin);
        wait 0.1;
        self.ignoreall = 0;
        self.is_on_platform = undefined;
        self.attempting_teleport = undefined;
        self show();
        set_kill_off_time(20.0);
        var_6 = get_closest_available_player();
        update_target_player(var_6);
        return;
      }

      if(isDefined(var_0)) {
        if(var_0 == "_encstr_B69E0942C3200E4BBF9B9A") {
          return;
        }
        if(var_0 == "_encstr_B1761493B828E8A813EED677D627D2309720F3D770E3") {
          if(isDefined(var_1)) {} else {}

          set_goal_pos_to_center_of_nearby_ai();
          return;
        }

        script_kill_ai();
        return;
        return;
        return;
      }

      script_kill_ai();
    }
  }
}

script_kill_ai(var_0) {
  remove_from_kill_off_list();

  if(self.birthtime >= gettime())
    waitframe();

  self.marked_for_death = 1;

  if(!istrue(var_0))
    self.nocorpse = 1;

  self.died_poorly = 1;
  self.died_poorly_health = self.health;
  self kill();
}

is_in_combat_volume() {
  return 0;
}

remove_from_enemy_list(var_0) {
  if(!isDefined(var_0) && isDefined(self.target_enemy))
    var_0 = self.target_enemy;

  if(isDefined(var_0)) {
    if(scripts\engine\utility::array_contains(var_0.enemy_list, self))
      var_0.enemy_list = scripts\engine\utility::array_remove(var_0.enemy_list, self);
  }
}

get_closest_available_player(var_0) {
  var_1 = undefined;

  if(isDefined(var_0))
    var_2 = scripts\common\utility::playersnear(self.origin, var_0);
  else
    var_2 = scripts\cp\utility::get_array_of_valid_players();

  var_2 = sortbydistance(var_2, self.origin);
  var_3 = var_0;

  if(var_2.size > 0) {
    var_1 = var_2[0];

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(istrue(var_5.ignoreme)) {
        continue;
      }
      if(!var_5 scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(isDefined(self.enemy) && var_5 == self.enemy)
        return var_5;

      if(scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(var_5.origin)) {
        var_1 = var_5;
        break;
      }
    }
  }

  if(isDefined(var_1))
    return var_1;
  else
    return undefined;
}

progression_main(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && !scripts\cp\utility::turn_off_sniper_laser())
    var_3 = playersnearcustom(self.origin, var_0, var_1);
  else
    var_3 = scripts\cp\utility::get_array_of_valid_players();

  var_3 = sortbydistance(var_3, self.origin);
  var_4 = var_0;

  if(var_3.size > 0) {
    var_2 = var_3[0];

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_5];

      if(istrue(var_6.ignoreme)) {
        continue;
      }
      if(!var_6 scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(isDefined(self.enemy) && var_6 == self.enemy)
        return var_6;

      if(var_6 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(self.origin)) {
        var_2 = var_6;
        break;
      }
    }
  }

  if(isDefined(var_2))
    return var_2;
  else
    return undefined;
}

playersnearcustom(var_0, var_1, var_2) {
  var_3 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"]);
  var_4 = (var_1, var_1, var_1);
  var_5 = var_0 - var_4;
  var_6 = var_0 + var_4;
  var_7 = [];
  var_8 = physics_aabbbroadphasequery(var_5, var_6, var_3, []);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    if(isPlayer(var_8[var_9])) {
      if(scripts\engine\utility::array_contains(var_2, var_8[var_9]))
        var_7 = scripts\engine\utility::array_add(var_7, var_8[var_9]);
    }
  }

  return var_7;
}

set_default_ar_values() {
  self.maxfaceenemydist = 768;
  scripts\engine\utility::set_movement_speed(75);
  self setengagementmindist(128, 64);
  self setengagementmaxdist(512, 640);
}

shotgunner_info_loop(var_0) {
  if(!isDefined(var_0))
    var_0 = get_closest_available_player();

  if(!isDefined(var_0)) {
    set_demeanor_from_unittype("_encstr_92100762872552A643");
    set_goal_radius(2000);
    return;
  } else {
    update_target_player(var_0);
    set_goal_ent(var_0);
    self setgoalentity(var_0, 250);
    set_goal_radius(512);
    set_demeanor_from_unittype("_encstr_AA7C07466F9DA30713");
  }
}

shotgunner_combat(var_0) {
  if(!isDefined(var_0))
    var_0 = get_closest_available_player();

  if(!isDefined(var_0)) {
    set_demeanor_from_unittype("_encstr_92100762872552A643");
    set_goal_radius(2000);
  } else {
    self.combat_func_active = 1;
    set_goal_ent(var_0);
    set_goal_radius(256);
    set_demeanor_from_unittype("_encstr_AA7C07466F9DA30713");
  }
}

update_target_player(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(var_0.enemy_list))
      var_0.enemy_list = [];

    if(!isDefined(self.target_enemy) || self.target_enemy != var_0) {
      self notify("_encstr_88560F9158FB9D9F1D3A572C101370373D");
      remove_from_enemy_list(var_0);
    }

    run_combat_func(var_0);
  }

  self.target_enemy = var_0;
}

shotgunner_spawn() {}

sniper_combat() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self.script_goalvolume))
    self setgoalvolumeauto(self.script_goalvolume);

  self.defaultcoverselector = "_encstr_AB9710F008A369AA37E3DE682873EB1FCFB1";
  set_demeanor_from_unittype("_encstr_965108334E0B373A961B");
  self setengagementmindist(1024.0, 0.0);
  self setengagementmaxdist(2048.0, 4096.0);
  self waittill("_encstr_88BF06FD784A6393");
  self enableavoidance(1, 1);
  self setavoidanceradius(64);
  self setavoidancereciprocity(1);
}

play_rappel_intro_anim(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.ignoreall = 1;
  var_0 scripts\asm\shared\mp\utility::burnfxstates("_encstr_A1691CE6234EF5C6ED5BAF4B373A56C9F5E42C0E0EB21BAFDDA573C8B7EE", var_1.origin, var_1.angles);
  var_0.ignoreall = 0;
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();

  if(isDefined(var_2))
    var_0 thread[[var_2]](var_0);
}

trigger_choose_func_from_list(var_0, var_1) {}

trigger_run_module_once(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = run_spawn_module(var_0.target);
  var_0 notify("_encstr_A103102396DC164C36CAAF3A4EB49DB35993");
}

trigger_run_spawn_module(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = run_spawn_module(var_0.target);

  if(isDefined(var_2))
    wait_for_all_group_dead(var_2);
}

set_dontkilloff_flag() {
  self.dontkilloff = 1;
}

wait_for_all_multi_group_dead(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    level scripts\engine\utility::_id_143B9(var_1, "_encstr_8E430EB5EDC85D36ACF59D27F6AB1C40" + var_0.group_name + "_encstr_ACF90B31FF82C1F8ECDF033987");
  else
    level waittill("_encstr_8E430EB5EDC85D36ACF59D27F6AB1C40" + var_0.group_name + "_encstr_ACF90B31FF82C1F8ECDF033987");
}

wait_for_all_group_dead(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    var_0 scripts\engine\utility::_id_143B9(var_1, "_encstr_AA5E19F7B6605F9A3FE0737AD88514FBD9887B6741EB63E741B83A");
  else
    var_0 waittill("_encstr_AA5E19F7B6605F9A3FE0737AD88514FBD9887B6741EB63E741B83A");
}

wait_at_spawn_counts(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_0.spawn_count % var_1 == 0)
    return var_2;
  else
    return var_3;
}

return_random_number(var_0, var_1, var_2) {
  var_1 = define_var_if_undefined(var_1, 3);
  var_2 = define_var_if_undefined(var_2, 5);
  return randomintrange(var_1, var_2);
}

waittill_spawn_notify_after_count(var_0, var_1) {
  if(var_0.spawn_count == 0)
    level waittill(var_1);
  else if(var_0.max_size % var_0.spawn_count == 0)
    level waittill(var_1);
  else
    return 0.1;
}

_id_145D3(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(!isarray(var_1))
    var_1 = [var_1];

  if(!isarray(var_2))
    var_2 = [var_2];

  if(var_1.size != var_2.size) {
    return;
  }
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = "_encstr_81EE0FDD96D143A59BD789F6579B8CE6EB" + var_5;
    var_4[var_5] = var_6;
    watch_for_players_beyond_point(var_0, var_1[var_5], var_2[var_5], undefined, var_6, 1);
  }

  var_0 scripts\engine\utility::waittill_all_in_array(var_4);
  var_0 notify("_encstr_A9011B87B3925F91072EF3E994F1D01C4943131B47EA2DC938855840BB");

  if(isDefined(var_3))
    var_0 thread[[var_3]]();
}

watch_for_players_beyond_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread watch_for_players_beyond_point_internal(var_0, var_1, var_2, var_3, var_4, var_5);
}

mp_hideout_patch() {
  stop_module_by_groupname(self.group_name, 1);
}

watch_for_players_beyond_point_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A9011B87B3925F91072EF3E994F1D01C4943131B47EA2DC938855840BB");
  var_6 = spawnStruct();
  var_6.origin = var_1;
  var_6.angles = var_2;

  for(;;) {
    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      if(var_6 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(level.players[var_7].origin)) {
        if(isDefined(var_4))
          var_0 notify(var_4);

        if(isDefined(var_3))
          var_0 thread[[var_3]]();

        if(!istrue(var_5))
          return;
      }
    }

    wait 0.5;
  }
}

_id_14340(var_0) {
  var_0 scripts\engine\utility::ent_flag_wait("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
}

set_heavy_hitter(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 2048;

  var_2 = var_0 get_spawned_ai_from_group_struct();

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_2[var_3] set_goal_radius(var_1);
}

set_initial_goalheight(var_0, var_1) {
  thread _id_13F33(var_1);
}

_id_13F33(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  level waittill(var_0);
  self.ignoreall = 0;
}

set_initial_goalRadius(var_0, var_1) {
  var_2 = var_0 get_spawned_ai_from_group_struct();

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_2[var_3] scripts\cp\cp_spawning_util::enable_juggernaut_move_behavior();
}

_id_1309B(var_0) {
  level notify("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");

  if(scripts\engine\utility::flag_exist("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
    scripts\engine\utility::flag_set("_encstr_B4910DD36ABF0F48B55B9FD5625FD0");
}

group_fallback_to_pos(var_0, var_1) {
  var_2 = var_0 get_spawned_ai_from_group_struct();
  var_0 set_script_origin_other_for_group(var_1);
}

fallback_to_pos_if_weapons_free(var_0, var_1) {
  if(var_0 scripts\engine\utility::ent_flag("_encstr_B4910DD36ABF0F48B55B9FD5625FD0"))
    set_script_origin_other_on_ai(var_1);
}

stop_and_start_group(var_0, var_1, var_2) {
  run_spawn_module(var_2);
  stop_module_by_groupname(var_1);
}

module_wave_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = define_var_if_undefined(var_1, get_passive_wave_spawn_time());
  var_2 = define_var_if_undefined(var_2, get_passive_spawn_window_time());
  var_3 = define_var_if_undefined(var_3, 0.1);
  var_7 = define_var_if_undefined(var_6, var_0 get_activecount_from_group());
  var_4 = get_passive_wave_low_threshold(var_0, var_4);
  var_5 = get_passive_wave_high_threshold(var_0, var_5);

  if(istrue(var_0.spawn_window_open)) {
    if(!istrue(var_0.disable_wave_hud))
      setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", 0);

    return var_3;
  } else {
    var_8 = gettime();

    if(isDefined(var_4) && isDefined(var_5)) {
      if(isDefined(var_6)) {
        if(var_0.spawn_count > 0 && var_0.spawn_count % var_5 == 0) {
          var_0 change_module_status(undefined, "_encstr_82791036ED77BE47D02795B91ABDC691A380" + var_4);
          var_0 group_wait_for_activecount_notify(var_4);
          var_0 change_module_status(undefined, "_encstr_ADCF0B1F60D07BD1F99228B747");
          var_0 wave_cooldown_time(var_1);
          wait(var_1);

          if(!istrue(var_0.disable_wave_hud))
            setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", 0);

          var_0 scripts\cp\cp_wave_spawning::increase_wave_num();
          var_0 change_module_status(undefined, "_encstr_8F5A1D6301C74F2A534D99D71705332D08763B8FB7CF93C8BE9F67C07F2063");
        } else {
          var_0 change_module_status(undefined, "_encstr_91921B4B73CF5F1DC04DFFFF41C8696B630972F19B13F317F8A9FFC409");
          return var_3;
        }
      } else if(var_7 >= var_5) {
        var_0 change_module_status(undefined, "_encstr_82791036ED77BE47D02795B91ABDC691A380" + var_4);
        var_0 group_wait_for_activecount_notify(var_4);
        var_0 change_module_status(undefined, "_encstr_ADCF0B1F60D07BD1F99228B747");
        var_0 wave_cooldown_time(var_1);
        wait(var_1);

        if(!istrue(var_0.disable_wave_hud))
          setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", 0);

        var_0 scripts\cp\cp_wave_spawning::increase_wave_num();
        var_0 change_module_status(undefined, "_encstr_8F5A1D6301C74F2A534D99D71705332D08763B8FB7CF93C8BE9F67C07F2063");
      } else {
        var_0 change_module_status(undefined, "_encstr_91921B4B73CF5F1DC04DFFFF41C8696B630972F19B13F317F8A9FFC409");
        return var_3;
      }
    } else if(!isDefined(var_0.last_wave_time)) {
      var_0 change_module_status(undefined, "_encstr_924D13FAD07D4A43663EF019D4A82793934062E2B8");
      var_0.spawn_window_open = 1;
      var_0 scripts\engine\utility::delaythread(var_2, ::disable_spawn_window);
      var_0 scripts\engine\utility::delaythread(var_2, ::wave_cooldown_time, var_1);
      return var_3;
    } else {
      var_9 = var_0.last_wave_time + var_1 * 1000 - var_8;

      if(var_9 < 0) {
        var_0 change_module_status(undefined, "_encstr_A623121B2808E47977AFC67B9807B3B910C847D7");
        var_0.spawn_window_open = 1;
        var_0 scripts\engine\utility::delaythread(var_2, ::disable_spawn_window);
        var_0 scripts\engine\utility::delaythread(var_2, ::wave_cooldown_time, var_1);
        return var_3;
      } else {
        var_0 change_module_status(undefined, "_encstr_ADCF0B1F60D07BD1F99228B747");
        return var_1;
      }
    }
  }
}

wave_cooldown_time(var_0) {
  if(!istrue(level.wave_cooldown_active)) {
    level thread monitor_wave_cooldown(var_0);
    level thread _id_1451B(var_0);

    if(!istrue(self.disable_wave_hud)) {
      var_1 = gettime() + var_0 * 1000;
      setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", int(var_1));
    }
  }
}

monitor_wave_cooldown(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.wave_cooldown_active = 1;
  wait(var_0);
  level.wave_cooldown_active = undefined;
}

_id_1451B(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B4700EC309BCBBCF1F5BD1DB031A5869");
  level endon("_encstr_B1BD11D2F3CABB076CC280022FEAD0DD3DE116");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }
  if(isDefined(level._id_14531) && level._id_14531 <= level.logfriendlyfire) {
    return;
  }
  var_1 = var_0;

  while(var_1 > 0) {
    var_1--;
    var_2 = scripts\cp\utility::relic_bang_and_boom_dropfunc(var_1);

    foreach(var_4 in level.players)
    var_4 playlocalsound(var_2);

    if(var_1 == 30 || var_1 == 10) {
      var_6 = scripts\cp\utility::respawn_flare_wavesv_used_playereffects(var_1);

      if(isDefined(var_6))
        level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_6, "_encstr_9A8507BA4040188D08");
    }

    wait 1;
  }
}

override_spawner_aitypes(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(isDefined(var_1))
    var_4[var_4.size] = var_1;

  if(isDefined(var_2))
    var_4[var_4.size] = var_2;

  if(isDefined(var_3))
    var_4[var_4.size] = var_3;

  for(var_5 = 0; var_5 < var_0.spawn_points.size; var_5++) {
    var_6 = var_0.spawn_points[var_5];
    var_6.script_noteworthy = var_4;
  }
}

set_count_based_on_grouped_modules(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.grouped_modules[var_1]))
    level.grouped_modules[var_1] = [];

  if(!scripts\engine\utility::array_contains(level.grouped_modules[var_1], var_0))
    level.grouped_modules[var_1][level.grouped_modules[var_1].size] = var_0;

  var_4 = var_0.activecount;
  var_5 = get_active_from_grouped_modules(level.grouped_modules[var_1]);

  if(var_5 < var_2)
    return var_3;
  else
    return 0;
}

shipfx(var_0) {
  var_1 = rear_spotlight_speed(var_0);

  if(!isDefined(var_1))
    return 0;

  var_2 = rear_spotlight_speed(var_0);

  if(!isDefined(var_2))
    return 0;

  return var_1 < var_2;
}

rear_spotlight_speed(var_0) {
  if(isDefined(var_0._id_13959))
    return var_0._id_13959;
  else
    return undefined;
}

recharge_equipment_update_slot(var_0) {
  if(isDefined(var_0._id_13BE9))
    return var_0._id_13BE9;
  else
    return undefined;
}

_id_130F7(var_0, var_1) {
  var_0._id_13BE9 = var_1;
}

get_active_from_grouped_modules(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1 = var_1 + var_0[var_2].activecount;

  return var_1;
}

define_var_if_undefined(var_0, var_1) {
  if(!isDefined(var_0)) {
    if(isbuiltinfunction(var_1))
      return [[var_1]]();
    else
      return var_1;
  } else
    return var_0;
}

disable_spawn_window(var_0) {
  self.spawn_window_open = undefined;
  self.last_wave_time = gettime();
}

wave_reinforce(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_0 get_activecount_from_group() <= var_0.min_size) {
    if(var_1 > 0.05)
      return randomfloatrange(0.05, var_1);
    else
      return 0.05;
  }

  if(var_0.activecount >= var_0.max_size) {
    while(var_0 get_activecount_from_group() > var_0.min_size)
      wait 0.25;

    return var_2;
  }

  if(isDefined(var_1))
    return var_1;
  else if(isDefined(var_2))
    return var_2;
  else
    return 0.05;
}

set_wave_show_hud(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_0.disable_wave_hud = !var_1;
}

go_to_node(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isarray(var_0) && var_0.size < 1) {
    var_0 = self.spawnpoint get_next_node_array();

    if(var_0.size == 0) {
      self notify("_encstr_8DFD1123C0C1937233CDD112A7C9AA67E920F3");

      if(isDefined(var_1))
        [[var_1]]();

      return;
    }
  } else if(!isarray(var_0))
    var_0 = [var_0];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isvector(var_0[var_3])) {
      var_4 = spawnStruct();
      var_4.origin = var_0[var_3];
      var_4.angles = (0, 0, 0);
      var_0[var_3] = var_4;
    }
  }

  go_to_node_internal(var_0, var_1, var_2);
}

get_next_node_array() {
  var_0 = get_linkto_goals();

  if(var_0.size < 1) {
    if(isDefined(self.target))
      var_0 = get_target_goals(self.target);
  }

  return var_0;
}

get_target_goals(var_0) {
  var_1 = getnodearray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2)
  var_1[var_1.size] = var_4;

  var_2 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_4 = var_2[var_6];

    if(!is_target_goal_valid(var_4)) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

get_linkto_goals() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_linked_ents();
    var_2 = scripts\engine\utility::get_linked_structs();
    var_3 = scripts\engine\utility::get_linked_nodes();
    var_0 = scripts\engine\utility::array_combine(var_1, var_2, var_3);
  }

  return var_0;
}

go_to_node_internal(var_0, var_1, var_2) {
  self notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  self endon("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isarray(var_0))
    var_0 = [var_0];

  thread go_to_node_end();
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = var_0[0];

  for(;;) {
    if(!var_3) {
      var_0 = get_least_used_from_array(var_0);
      var_5 = get_path_array(var_0, var_6);

      if(var_5.size > 1)
        var_3 = 1;
    }

    self.currentnode = var_0;

    if(var_3) {
      var_0 = var_5[var_5.size - 1];
      go_through_patharray(var_5, var_1, var_2);
      var_5 = undefined;
      var_3 = 0;
    } else {
      node_fields_pre_goal(var_0);
      go_to_node_set_goal(var_0);
      self waittill("_encstr_8B7205D9ED5958");
    }

    var_0 notify("_encstr_8F5C086405E70FBA4B4A", self);
    node_fields_after_goal(var_0, var_1);
    _id_11E9E(var_0);
    var_0 scripts\engine\utility::script_delay();

    if(isDefined(var_0.script_flag_wait))
      scripts\engine\utility::flag_wait(var_0.script_flag_wait);

    if(isDefined(var_0.script_ent_flag_wait))
      scripts\engine\utility::ent_flag_wait(var_0.script_ent_flag_wait);

    var_0 scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(var_0, var_2);

    if(!isDefined(var_0.target) && !isDefined(var_0.script_linkto)) {
      break;
    }

    var_7 = var_0 get_next_node_array();

    if(!var_7.size) {
      break;
    }

    var_0 = var_7;
  }

  self notify("_encstr_8DFD1123C0C1937233CDD112A7C9AA67E920F3");

  if(isDefined(self.script_forcegoal)) {
    return;
  }
  var_8 = self getgoalvolume();

  if(isDefined(var_8))
    self setgoalvolumeauto(var_8, var_8 get_cover_volume_forward());
}

get_least_used_from_array(var_0) {
  if(var_0.size == 1)
    return var_0[0];

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(!isDefined(var_1.used_time))
    var_1.used_time = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.used_time))
      var_3.used_time = 0;

    if(var_3.used_time < var_1.used_time)
      var_1 = var_3;
  }

  var_1.used_time = gettime();
  return var_1;
}

get_path_array(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(;;) {
    var_2[var_2.size] = var_0;
    var_3++;

    if(var_3 == 16) {
      break;
    }

    if(go_to_node_should_stop(var_0)) {
      break;
    }

    if(!isDefined(var_0.target) && !isDefined(var_0.script_linkto)) {
      break;
    }

    var_4 = var_0 get_next_node_array();

    if(!var_4.size) {
      break;
    }

    var_0 = get_least_used_from_array(var_4);

    if(var_0 == var_1) {
      break;
    }
  }

  return var_2;
}

go_through_patharray(var_0, var_1, var_2) {
  self setgoalpath(var_0);

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_3;
    var_5 = var_0[var_3];
    self.currentnode = var_5;
    node_fields_pre_goal(var_5);
    var_6 = waittill_subgoal();

    if(var_4 == var_0.size - 1) {
      self waittill("_encstr_8B7205D9ED5958");
      break;
    }

    var_5 notify("_encstr_8F5C086405E70FBA4B4A", self);
    node_fields_after_goal(var_5, var_1);
    _id_11E9E(var_5);
    node_fields_after_goal_and_wait(var_5, var_2);
  }
}

node_fields_pre_goal(var_0) {
  if(isDefined(var_0.radius))
    set_goal_radius(var_0.radius);

  if(isDefined(var_0.script_radius)) {
    self.script_radius = var_0.script_radius;
    set_goal_radius(var_0.script_radius);
  }

  if(isDefined(var_0.height))
    self.goalheight = var_0.height;

  if(isDefined(var_0.script_demeanor))
    set_demeanor_from_unittype(var_0.script_demeanor);

  if(istrue(var_0.script_pacifist) || isDefined(var_0.spawnflags) && var_0.spawnflags & 256)
    self.pacifist = 1;

  if(isDefined(var_0.script_ignoreall))
    self.ignoreall = var_0.script_ignoreall;

  if(isDefined(var_0.script_ignoreme))
    self.ignoreme = var_0.script_ignoreme;

  if(isDefined(var_0.script_flag))
    scripts\engine\utility::flag_init(var_0.script_flag);

  if(isDefined(var_0.script_speed))
    scripts\engine\utility::set_movement_speed(var_0.script_speed);
}

node_fields_after_goal(var_0, var_1) {
  if(isDefined(var_1))
    [[var_1]](var_0);

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(var_0.script_flag_clear))
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);
}

_id_11E9E(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  if(!istrue(level.global_stealth_broken) && !istrue(self.entered_combat) && isDefined(var_0.script_animation_type)) {
    var_1 = undefined;
    var_2 = strtok(var_0.script_animation_type, "_encstr_964C0249");
    var_1 = scripts\engine\utility::random(var_2);

    if(isDefined(var_1)) {
      if(!istrue(var_0.script_looping))
        self._id_133A4 = 1;
      else
        self._id_133A4 = undefined;

      self.playing_skit = 1;
      _id_1241B(var_0, var_1);
      self.playing_skit = undefined;

      while(istrue(self.playing_skit))
        wait 0.05;
    }
  }
}

_id_1241B(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  if(istrue(self._id_133A4))
    self endon("_encstr_831708605035B3A01801" + var_1 + "_encstr_A3850616E56F783F");

  set_goal_pos(var_0.origin);
  self thread[[level.spawn_skits[var_1].skit_func]]();

  while(istrue(self.playing_skit))
    wait 0.05;
}

node_fields_after_goal_and_wait(var_0, var_1) {
  if(isDefined(var_0.script_soundalias)) {
    if(soundexists(var_0.script_soundalias))
      self playSound(var_0.script_soundalias);
  }

  if(isDefined(var_0.script_forcegoal))
    set_goal_radius(var_0.script_forcegoal);

  if(isDefined(self.post_wait_func))
    [[self.post_wait_func]]();

  if(isDefined(var_0.script_delay_post))
    wait(var_0.script_delay_post);

  while(isDefined(var_0.script_requires_player)) {
    var_0.script_requires_player = 0;

    if(go_to_node_wait_for_player(var_0, ::get_next_node_array)) {
      var_0.script_requires_player = 1;
      var_0 notify("_encstr_965717E66C395A83E8AFC9AC5CAE5A4EAC9BBE38D82C97959C");
      break;
    }

    wait 0.25;
  }

  if(isDefined(var_0.script_demeanor_post))
    set_demeanor_from_unittype(var_0.script_demeanor_post);

  if(isDefined(var_1))
    [[var_1]](var_0);

  if(isDefined(var_0.script_death) && var_0.script_death)
    script_kill_ai();

  if(isDefined(var_0.script_delete) && var_0.script_delete)
    self delete();
}

go_to_node_wait_for_player(var_0, var_1) {
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(distancesquared(var_3.origin, var_0.origin) < distancesquared(self.origin, var_0.origin))
      return 1;

    if(!isDefined(var_0.script_dist_only)) {
      var_4 = anglesToForward(self.angles);

      if(isDefined(var_0.target)) {
        var_5 = var_0[[var_1]](var_0.target);

        if(var_5.size == 1)
          var_4 = vectorNormalize(var_5[0].origin - var_0.origin);
        else if(isDefined(var_0.angles))
          var_4 = anglesToForward(var_0.angles);
      } else if(isDefined(var_0.angles))
        var_4 = anglesToForward(var_0.angles);

      var_6 = [];
      var_6[var_6.size] = vectorNormalize(var_3.origin - self.origin);

      foreach(var_8 in var_6) {
        if(vectordot(var_4, var_8) > 0)
          return 1;
      }
    }

    var_10 = 300;

    if(var_0.script_requires_player > var_10)
      var_10 = var_0.script_requires_player;

    if(distancesquared(var_3.origin, self.origin) < squared(var_10))
      return 1;

    return 0;
  }
}

waittill_subgoal() {
  self endon("_encstr_8B7205D9ED5958");
  self waittill("_encstr_ADE70897C7523FBFBA1A", var_0);
  return var_0;
}

go_to_node_should_stop(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_0.target))
    return 1;

  if(isDefined(var_0.script_delay))
    return 1;

  if(isDefined(var_0.script_delay_min))
    return 1;

  if(isDefined(var_0.script_delay_max))
    return 1;

  if(isDefined(var_0.script_wait))
    return 1;

  if(isDefined(var_0.script_wait_add))
    return 1;

  if(isDefined(var_0.script_wait_min))
    return 1;

  if(isDefined(var_0.script_wait_max))
    return 1;

  if(isDefined(var_0.script_flag_wait))
    return 1;

  if(isDefined(var_0.script_ent_flag_wait))
    return 1;

  if(isDefined(var_0.script_delay_post))
    return 1;

  if(isDefined(var_0.script_requires_player))
    return 1;

  if(isDefined(var_0.script_idle))
    return 1;

  if(isDefined(var_0.script_stopnode))
    return 1;

  return 0;
}

get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw))
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  else
    return undefined;
}

go_to_node_set_goal(var_0) {
  if(isnode(var_0))
    go_to_node_set_goal_node(var_0);
  else if(isstruct(var_0))
    go_to_node_set_goal_pos(var_0);
  else if(isent(var_0))
    go_to_node_set_goal_ent(var_0);

  if(isstruct(var_0) || isnode(var_0))
    var_0.patrol_stop = go_to_node_should_stop(var_0);
}

go_to_node_set_goal_ent(var_0) {
  if(var_0.code_classname == "_encstr_AC790C38CB1680D7038561F51D6A") {
    self setgoalvolumeauto(var_0, var_0 get_cover_volume_forward());
    self notify("_encstr_8D7214B7EFB943C8A1B03501B07195B76F5909F8D91C");
    return;
  }

  go_to_node_set_goal_pos(var_0);
}

go_to_node_set_goal_pos(var_0) {
  set_goal_ent(var_0);
  self notify("_encstr_8D7214B7EFB943C8A1B03501B07195B76F5909F8D91C");
}

enter_combat_after_go_to_node() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  go_to_node(self.spawnpoint get_next_node_array());
  thread enter_combat();
}

set_goal_ent(var_0) {
  set_goal_pos(var_0.origin);
  self.last_set_goalent = var_0;

  if(isstruct(var_0) && !isDefined(var_0.type))
    var_0.type = "_encstr_91D8076ED193D5B11D";
}

set_goal_pos(var_0) {
  if(istrue(self.fixednode)) {
    return;
  }
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var_0;
  self.last_set_goalent = undefined;
  self setgoalpos(getclosestpointonnavmesh(var_0));
  self notify("_encstr_861D0D7395BB7DB3DEC28DBE38DE9B");
}

go_to_node_set_goal_node(var_0) {
  set_goal_node(var_0);
  self notify("_encstr_8D7214B7EFB943C8A1B03501B07195B76F5909F8D91C");
}

set_goal_node(var_0) {
  self.last_set_goalnode = var_0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var_0);
}

go_to_node_end() {
  self notify("_encstr_97040F97D7A8436F013835FF7129AD5A9D");
  self endon("_encstr_97040F97D7A8436F013835FF7129AD5A9D");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.using_goto_node = 1;
  var_0 = scripts\engine\utility::_id_143AD("_encstr_8DFD1123C0C1937233CDD112A7C9AA67E920F3", "_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

is_target_goal_valid(var_0) {
  if(isspawner(var_0))
    return 0;

  switch (var_0.code_classname) {
    case "_encstr_B1F70D1B2D73B2A790FB797D5088ED":
    case "_encstr_A70911F16A4C28BC9F231658BB53ED80A2DC6B":
    case "_encstr_956B0F193B6244C0659AE65B464C78857B":
    case "_encstr_97710C6B2DCD1BAF3AD54E4E598E":
      return 0;
  }

  return 1;
}

set_goal_radius(var_0) {
  if(!isDefined(var_0))
    var_0 = 2048;

  self.last_goalradius = self.goalradius;
  self.goalradius = int(var_0);
}

return_to_last_goalRadius() {
  if(isDefined(self.last_goalradius))
    set_goal_radius(self.last_goalradius);
}

set_goal_pos_check_for_offset(var_0) {
  if(isDefined(self.script_origin_other))
    var_0 = self.script_origin_other;

  set_goal_pos(var_0);
}

set_script_origin_other_for_group(var_0) {
  if(isarray(self)) {
    var_1 = [];

    for(var_2 = 0; var_2 < self.size; var_2++)
      var_1 = scripts\engine\utility::array_add(var_1, self[var_2].ai_spawned);

    var_3 = var_1;
  } else
    var_3 = self.ai_spawned;

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    var_3[var_2] set_kill_off_time();
    var_3[var_2] set_script_origin_other_on_ai(var_0);
  }
}

_id_11CAE(var_0) {
  self._id_133B2 = 1;
}

_id_11CAC(var_0, var_1) {
  set_goal_radius(var_1);
}

_id_11CAB(var_0, var_1) {
  self.goalheight = var_1;
}

_id_11CB2(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait(var_1);
  scripts\engine\utility::flag_waitopen(var_1);
}

_id_12CE2(var_0) {
  return var_0.group_name;
}

_id_11CB1(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait(var_1);
}

_id_11CAD(var_0, var_1) {
  self.script_origin_other = var_1;
}

set_script_origin_other_on_ai(var_0) {
  self.script_origin_other = var_0;
}

clear_script_origin_other_on_ai(var_0) {
  self.script_origin_other = undefined;
}

modular_spawning_debug_init() {
  delay_start_specified_module();
  setDvar("_encstr_97D91582EE85911B6008A7FF8079C54A51680AFB47E12B", 0);
  setdvarifuninitialized("_encstr_81671983DA234878C4B73F77B3AAA0242B711B6B02CF80509D9607", 0);
  setdvarifuninitialized("_encstr_8F21132BCBDD11E8C73B4B7B8FB33358CCA8D36017", 0);
  setdvarifuninitialized("_encstr_AA8B1D8EEE138FA141EF1013BB651E2DCAD71097C6CBA98E338B080B4BADB3", 0);
  setdvarifuninitialized("_encstr_A10715BBE1B6EFCED01FC7C551A09463551E4242698DD7", 0);
  setdvarifuninitialized("_encstr_86B618AB1EBA317652670F575F6A31707FF5F18189032027EB0F", 0);
  setdvarifuninitialized("_encstr_ADC91583368209473ADFCBE3D7D19848170EE89BDEE130", 0);
  setdvarifuninitialized("_encstr_92E01B521AF32E50D629688B2FDA8B971B03778257C8A15E39E2BCA806", 0);
  setdvarifuninitialized("_encstr_83C8191B42BBC0E8FA0985B917277897ABFA11438AB707C0D41987", 0);
  setdvarifuninitialized("_encstr_B2501458F7F878853F4C9B2B3B41F35B2E8F862CD0D7", "_encstr_B40101");
  setdvarifuninitialized("_encstr_921F18B98D9C7DD8DECE56C9AF73ED2356FA6E1C85DD73A5373B", 0);
  setdvarifuninitialized("_encstr_8AAD1D371B27EBB4DCD28EBE1BBD9D95E4D7B9F6322BFAE60E2CEE37B29C37", 1);
  setdvarifuninitialized("_encstr_828D129B2E8A014412D3DBA7EF2B87F83E04A091", 0);
  setdvarifuninitialized("_encstr_96FB1AC7CF3EF16F8878B031D3D8BB8B1B4D07FF97675A4F50206D07", 0);
  setdvarifuninitialized("_encstr_A105199B369CF56E34DEBBAF8EB2B1B21C7B4E3AFA39ACB0CDF6CD", 0);
  setdvarifuninitialized("_encstr_8619139B8D397D31D8DE6CD6AFE82BB12B07B793E8", 0);
  setdvarifuninitialized("_encstr_842A19F3D610468E1B37FB18BB28BFB31A5F6F2A52ADC634D90868", 0);
  setdvarifuninitialized("_encstr_83121863403607ACB94B59B9A9D33F98B9FB82537957A86073CB", -1);
  setdvarifuninitialized("_encstr_A6F017237A83E8F8664EFB974CCDB05023629B69830338187F", -1);
  setdvarifuninitialized("_encstr_8AC5174BFE5AD19422E38BF7DFAAD010E455736069A4A8415A", -1);
  setdvarifuninitialized("_encstr_9A6013829E28B7EF23A3F097EDABA0B920EDF8664C", -1);
  setdvarifuninitialized("_encstr_97571393CF631723761882EF99016B60AFBF05100C", -1);
  setdvarifuninitialized("_encstr_886A0D60F6F2F83F01A395F70215EB", "_encstr_B40101");
  setdvarifuninitialized("_encstr_9BB41457069B67B3DE6DBA41CF3288E9AAA302AB7217", 0);
  setdvarifuninitialized("_encstr_998A1B68C26A4713877EBDB8548B7B8B92DA1018CA4959E86F95B0A54C", 0);
  setdvarifuninitialized("_encstr_9103201BB71B4F803A7857D7AA732FA10B9FC84F5937C8F00749EF76BC92E32E63BB", 1);
  var_0 = "_encstr_92C37119ACD9765D5ABE6CAD230444868201112B265DECD14601E508682808A9DBC8EA1BB280A6070B773796733B04CB014D1ADEBB08287695B947026A8E2C3AB91D6208790111B4CD58311B591DC0881044D1F676B3C6568310B93627EB6E0DBD77F50BEC56373AD79B3A588E370218441028";
  scripts\cp\utility::addentrytodevgui(var_0);

  for(var_1 = 4; var_1 < 4 + get_max_agent_count(); var_1++) {
    var_0 = "_encstr_A6C74519ACD9CED5B47D8DB6234044A1410288954CAE76D19101E580864108D4DE1957B12B014D0716BBE6B4DCD902E502A6D0B7EE0814EC2B7347023547583AE61D6201E50256" + var_1 + "_encstr_8D4C02E8" + var_1 + "_encstr_ADE72135921219BFDAAA797B9BF09F8615A15B9BBA60698AF76510DB172F1BD7257249" + var_1 + "_encstr_8A17044A7724";
    scripts\cp\utility::addentrytodevgui(var_0);
  }

  var_0 = "_encstr_819D62612D1B4105B201BE413D27BE49872603F80685824A02A7F827B1A0A68587E28759A97A80DDC37234438F1987A89BB2A6679C22D050390B76C166B327C0CFA3BD521AD3AB9DBF232A615835EEFBEC08E922FF0BA5EFE221D090BB3AC772BA7EF28C";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_B49A738CCA67ECEA2DEB6CD68C081168820122B24C57B3E823407940688280A9DE32BA1BB2029A1C2CBB9B4BE6CE04F21014275AE68E089AC158EEDCAC4E0888D2DC0B13D856DCE8194408118EDEB39D1B2BE00437B1E4F50E4ED23747FADC0E1677DCCAC9D723D2DC853136563710810898220250";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_8A6B6C1959B37657D2AFD8D68C10440D4108889589AE3B1D8C08F2020D2802A6DB32ABD82B80A93816BB9BB4377680CB10A634B7EE04D0365985DCD507044DE82C47CD748C110488D1B776CE6359380437D827FA9B86DBEEFAB6A5B1637DBDCC33D76EE80B3A37081801C4114041";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_ABFA638C95B3B3EA4BF58DB523402286A0808859265DD91D64015E041A4101A9B723ABB12B1035C158EEE6A5E69D04970841C25DCD5910A6C116BBB996B99D1DC0440111D1BD3BD936950E01B96C39F5E085AB9BCAD79B0EB0BBDC4BE69D020C024C2208A0";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_A7906891CAB3CE572DBE366B320111864110115926AEB374234079401A28049AF6C8D5D8AC10A68385DD73D273D940F28082932DE68E804DC1AC360192CDCCF61108113AEDCE9D632B38089BD84E7D9B34DEEED737382C77DCFA6EC1CA1BAF5A3766DE04604013444041";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_84756CC85667CEEAB4D7B1B5230888A10A10445913ABCEE823047910680A01D4DB8CBA1B5610D41CC2EEDC96E6B310F208A8BDB3D9D8564005D613D22B9BE804D41C16EE732D9B3B1110441DDBECD9C6B20740DC8D27D785637785F2CDAFF673EB0BD8DDB02FDC04814098110182";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_9BFA76322B9DD9D596FA8DB68C02110D0A02449526ABCED19140CB0234280135ED8CAEC6CA0235382CDD73A5733B025E40885A6E0B9863AC8089161983C23A1A806C63CAB0B9D5C14766224088D17BECCED8B28304376CC9BE91D2370B311BB2BE13B032F50E584734EBD88D950BCDABC101C040C4228082";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_A39370AB87766A25DACFDB2061D9C2F07022892B66783767226EED2926228171DFD185DD39A29177A698A833BDE79AD7825988871B21BB4973DA7B67F29316D960B927AFE27E52326A203631405ADF69AB6861434F6B208784603F172927BDD9F028DB4B01EEA59F0880A0B6DF9A6A32DE95";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_B8306340FDE3FAB72BA9EB4A9C41861E59D0D78765D32F4DB666E6A1186A2AF18091DF88479901504F38A5689B37B9D88981F00D82DBEF1B9F06F743871CD36F931F4E3EEEFC0714A8E16B72294AC3C0F6047B7B87C7387B6FD385C3A27CCED14EABD21ABA";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_B20773E4CDB3E72BA391528A7009B63F2F074C9DD67B5F20FD829E5621810EDF209DE51CFD2947FA032092DA5037C61E71E376818D816BC521984B4601379E17136FD70EAD9357DE51DAC3CAC8674587CB675BBBBEDE4715EB407902A06D7F038638DF345D66E7DAA340727A50BFE642113F1AE852";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_95386FC11884370B285FAF98F709829DB7613F95916B62BDE3095FB95987661FB0590D518BC189C159EB4EF0D078964052139B9DD0430F6B853372ED0FE0A1A6D2C1C983E011A8F881AE1A9D87AF8872A8288280978AB138E018EACB887BC82A08AF622BD613F50BB297B961C15A12204A";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_873D73B915F350DDC7A939E002BA3E3902287123BA9B88824276B8411853E7B165C46BB9251661EF37FBA810F277AFEA6E77D501D17EE9B64FA66719CB0F33F857F037B17113F8F3BBCA3129C64BF8386F04D32958FAC8465722B0A85B0F2FB0827373AD85A9808FD79B483052D7CFF20EA96DF942";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_85F9674117232FE397CE9809E7B1E10BB820FC1809DBC73A82679E812F31C717F072DB4D87325F7049D0BAC7C5B82A05E9632011E78BC3812AC84FB153A51A8B0F4A9166E1EA7BE81F2FB8B0A8869EAFE2490104CE7DFB2365DF8B88D1E79DE1FF59EF12626ECA268C";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_8F676E91ACECB3D55AAFD8D62308111A0580222B98AE9DD14602BC01A1051053DB19BA8D95049A830BDDE62DE6B3107940A1B19585E6AE0E105956865AC63659E6E81A110888DC95A3806E6C93EBC8B2C457B3AFE6E0B077B996E63B086CD82BC2735707FACE2B34A58D8DB2B91180A0";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_8C6A6C49921B0C10ECEF6F7BFC8692D62B5EC5910ACFB42252E8EFD9C3724A89AFB27B38C2F2E6A85E97654306E712703AB9D3C0FB4A376335D84F6D3F4B58268A67A1A146EF6D385E630F6567F78866DFCA8673CBFF9CA024461F3953DB1037CF427818C14F5670FB303F35281C";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_85216682E82D676F98AFCBCDA5890AA6C95A086A38F3DF1A9BD79FB8DE6FCA7DCFD08372B8319AEB2964D6F950D1922DF930DABBF113C45BC0CD93E0F8F80BC4BD18C6A672C90507B939ADF027C10781E7F8FB0AA0ABBD6FF39EB817A84BCF957F52F796BA956622";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_A52462D94D3ECF63C84122524FCF11F8734E1D37C8C33F0A3A4A1649814ACF99B0E9ED390FBA0E1B43CF1BD07A6018C7095B2AEB2ECA84B8B7E5E15FEECC5277E12E7D7D2F02A720D28B10C1B897CC3B8F1A185C5E272B102074DA754A02CA99C2568294";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_B187480BB053C7F37BAF6EE5F591FEABFF0203B720EB3FCFE58765CE76114251C0C82B2AB2E954629DC57F46E7650B1749E8B3A7E091ACAAF5DD4701B6A1D2A17098DB3A7A39B1E6494A";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_9ACC4CB71D5DC2CD90394767F8E1D2C8A907376F76B31ABAD3AA7E5A69834D52B94584B648411020413032621ABB0FFA77D14F5A67618A72EB40CF2780F1F912F97B59163B93D3F81B626E7A3AC4";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_A93F4A232BB33BEAA5D78D5B461022D02802882B13EA3B74C8807940A93A952C363A0D02E50199B7EC448044A37BCEB3D8B2070832CA98ABECEB9BD15985B13A1AFA66BDD904600862110128";
  scripts\cp\utility::addentrytodevgui(var_0);
  level.spawnpoint_debug = 0;
  var_0 = "_encstr_8D9F779159679DD5D2AF36DA9104110D824022ACC4EACE1D8C085E02868210537B32BA365601350E5877B996373B80CB086AE058EE731CBDD29BD10188954CEAEC0879022AB7ECD9C62B746811401137591D806E3627EB462B89AB76D7E63858EEE6D2CDD980B9C185EEE638B796DC8EFA235913BA76880850";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_ADCC720C40D07F80E331C9873322163EA981D91F88F82440FA71AE1A53412AB1D00BCB0420303F6B468BD3BFA39F3FF02673A820E0520FC71940706207646EF35976F7C1057F0BBA80C8AE88EE03A247E7E9C0A3A63B76DEC14758025B211E07072F28166BF79B9FB9F318B790304AB7A63E475C";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_8105888C59ECB35D4B7DD8AD8C1088A11402115698D576748C805E04A105016ADEC8BA3656404D83B0DDDC9637CE10790835C1C2EE9B1C7BA59BE88022CA89D5EC08F2801419460805C9DE1E2F101463C25E593904141D8013DBC6470D881011B9564704373627D719564CAB76BEDC8316BB9B4BE676101C39DEF0BCEB588C91EB0ED80BF2599C110114";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_851789D215330F5B1C3EFFA7F76981EE67F1883D7657B2B2E2B12E6817F931FBE001550A61F8E70AB7B348AF7AD8E6FABFC73753936872AA593A685F17DB2B702FC2DD5A2117E4D55319EA87A4B14F97AD184BF0AEE9FC9FA1A762FBE03CE67EC63392633E3FB2C0CF93F0C093DC169E9BA94FF090481249F3E33850EBB1558D28EF4DA761CA79329A27D2";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_BAE592650F339FE3213F2058BB20518FF9E6FD7D26FB57C242DA3A2A1FA8D95B529FDD717F0647B3F9AF386843B7A1274ECAD70F53BAC918A933F01AF3CD21DB82BEE027E7E2A9819C375A895FEC992FDB17CDBF4A2B676A693AE16837215145E7EB96374E53CB13181F7090E754699DBBA7A02632AAA718095348FA437A60E103C1A5A58D4279A1D7CF5090FF83DB037A260F8A";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_8EA77E29F27B2C30CCCF4F5B1C6672F60B3EA5B12A2F54023288CF3923522AA94F921B1822D28688BEB745A326C7F2501A5930E0AB2AD75813B14DA3102238CF9FE2C12CB29305186F83ED213A12A80D6AAB21B359CBB5A0036F0FBF70FEF0D837D239712313F85051417FB981E33808F7CB71039A772158B74D1983A3DEDA5A";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "_encstr_AB9A74C80DA329AD01CFD3E888F9E103A911EDA0F3BD87A00270725679079828903A83D589C1892A2F7B1A10F050589A203D8A2D683D94EF037197582FF1EB6BD289BF39831F932F92F506DB0671061A7233FA83CFA558BAED23DD47A10F21FEDB1B79ED870F57105890C8F6AB988DC09A9F48CEF1AC";
  scripts\cp\utility::addentrytodevgui(var_0);
  registerambientgroup("_encstr_96541788A821553A7418BCA9580F0828EC2BDC3A408A56CD1D", 0, ::get_max_agent_count, undefined, 0.1, undefined, ::get_all_cluster_spawners, undefined, undefined, undefined);
  registerambientgroup("_encstr_810C24D8B11DC38FCA9FAF2EDD68FF96991813E6B13BC46FD9A9ED2FFE33A7DB3531E9DAF0A1", 0, 24, undefined, 0.1, undefined, ::redshirt_drop_off_behavior, undefined, undefined, undefined);
}

redshirt_drop_off_behavior(var_0) {
  if(getDvar("_encstr_8CBC135E3EC35F13BD7331587BD14B457963DDE653", "_encstr_B40101") != "_encstr_B40101") {
    var_1 = scripts\engine\utility::getStructArray(getDvar("_encstr_8CBC135E3EC35F13BD7331587BD14B457963DDE653", "_encstr_B40101"), "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_1.size > 0) {
      return var_1;
      return;
    }

    return [];
    return;
  } else
    return [];
}

get_all_cluster_spawners(var_0) {
  if(isDefined(level.cluster_spawners) && level.cluster_spawners.size > 0)
    return level.cluster_spawners;
  else
    return undefined;
}

print_active_modules_to_screen() {
  level notify("_encstr_9AB31FFFBA6FCD3901CAF8486263C3FE975F0DF50CE7EB27B33221683ABA8BF1C3");
  level endon("_encstr_9AB31FFFBA6FCD3901CAF8486263C3FE975F0DF50CE7EB27B33221683ABA8BF1C3");
  level.show_active_modules = !level.show_active_modules;

  if(!level.show_active_modules) {
    if(isDefined(level.menu_background))
      level.menu_background destroy();

    return;
  }

  create_background();

  for(;;) {
    var_0 = 150;
    var_1 = "_encstr_87E44C024001800810404040400208018040018040801008044080020110010802080201408002010480088002020204024040040402040810011008010140080280100880080801044080800404";
    var_2 = "_encstr_B2D3249B75EEB33CD8BB04A013D8052AA74AD630D93B9A26A0D115E949F80A031FA7BA2BA199";
    var_3 = "_encstr_93A01E9FE0747BFB5BF8FB22A1D3B3A7630C89FF322987F540F3DF6B7BBB4A16" + level.spawned_ai.size + "_encstr_874C029E" + get_max_agent_count();
    var_3 = var_3 + getsubstr(var_1, 0, var_1.size - (var_3.size + var_2.size)) + var_2;
    var_0 = var_0 + 15;
    var_4 = "_encstr_8B2708D9D6C0E2F7EE72";
    var_5 = getsubstr(var_1, 0, var_1.size - var_4.size * 5 - 4);

    if(isDefined(level.spawn_module_structs_memory) && level.spawn_module_structs_memory.size > 0) {
      var_6 = getarraykeys(level.spawn_module_structs_memory);

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];
        var_9 = level.spawn_module_structs_memory[var_8];

        for(var_10 = 0; var_10 < var_9.size; var_10++) {
          var_11 = var_9[var_10];

          if(var_8 == "_encstr_A1340ECC2FCBC509A733AF20B02B7DE2") {
            var_12 = var_11 get_current_wave_ref();
            var_8 = "_encstr_B61407E4063B931270" + var_12;
          }

          var_13 = var_11 get_module_debug_data();

          if(isDefined(level.active_spawn_module_structs) && var_11 is_group_active())
            var_14 = (1, 1, 1);
          else
            var_14 = (1, 1, 0);

          var_15 = add_space_to_string("_encstr_8B30052B714720" + var_11 get_activecount_from_group(1), var_4);
          var_16 = add_space_to_string("_encstr_AB3005493262AA" + var_13.min_size, var_4);
          var_17 = add_space_to_string("_encstr_AB3005493260AA" + var_13.max_size, var_4);
          var_18 = add_space_to_string("_encstr_AA3005830853FD" + var_13.totalspawns, var_4);
          var_19 = add_space_to_string("_encstr_A730057042213A" + var_11.currentmodulekills, var_4);
          var_3 = add_space_to_string(var_13.status + "_encstr_854C021F" + var_8, var_5) + "_encstr_B44C0203" + var_10 + "_encstr_AF07039E3E" + var_15 + var_16 + var_17 + var_19 + var_18;
          var_0 = var_0 + 15;
        }
      }
    }

    waitframe();
  }
}

create_background() {
  level.menu_background = create_hudelem();
  level.menu_background setshader("_encstr_83AB065EE1391A7B", 350, 110);
  level.menu_background.color = (0.2, 0.2, 0.2);
  level.menu_background.alpha = 0.1;
  level.menu_background.sort = -20;
}

create_hudelem(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_5))
    var_5 = 20;

  var_6 = newhudelem();
  var_6.location = 0;
  var_6.alignx = "_encstr_A5AD056A019C63";
  var_6.aligny = "_encstr_8F8D07BB035BDAD5CD";
  var_6.vertalign = "_encstr_AC190479FF92";
  var_6.horzalign = "_encstr_A5AD056A019C63";
  var_6.foreground = 1;
  var_6.fontscale = 1;
  var_6.sort = define_var_if_undefined(var_5, 1);
  var_6.alpha = define_var_if_undefined(var_4, 0.1);
  var_6.x = define_var_if_undefined(var_1, 0);
  var_6.y = define_var_if_undefined(var_2, 85);
  var_6.og_scale = 1;
  var_6.archived = 0;

  if(isDefined(var_0)) {
    var_6.text = var_0;

    if(isnumber(var_0))
      var_6 setvalue(var_0);
    else
      var_6 clearalltextafterhudelem();
  }

  return var_6;
}

add_space_to_string(var_0, var_1) {
  if(var_0.size > var_1.size)
    return getsubstr(var_0, 0, var_1.size);
  else {
    var_2 = getsubstr(var_1, 0, var_1.size - var_0.size);

    if(isDefined(var_2) && var_2.size > 0)
      return var_0 + var_2;
    else
      return var_0;
  }
}

is_group_active() {
  if(isDefined(level.active_spawn_module_structs) && level.active_spawn_module_structs.size > 0) {
    var_0 = getarraykeys(level.active_spawn_module_structs);

    for(var_1 = 0; var_1 < level.active_spawn_module_structs.size; var_1++) {
      var_2 = var_0[var_1];

      if(scripts\engine\utility::array_contains(level.active_spawn_module_structs[var_2], self))
        return 1;
    }

    return 0;
  } else
    return 0;
}

create_module_debug_struct() {
  var_0 = spawnStruct();
  var_0.status = "_encstr_92B408E4D573DCD2CDEC";
  var_0.min_size = 0;
  var_0.max_size = 0;
  var_0.totalspawns = 0;
  self.debug_data = var_0;
}

change_module_status(var_0, var_1) {}

get_module_debug_data() {
  return self.debug_data;
}

agent_use_door_spawner(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("_encstr_BE2810CC77D032CF8611522A39703F2A28D9");
  var_1 notify("_encstr_BE2810CC77D032CF8611522A39703F2A28D9");
  var_1 endon("_encstr_BE2810CC77D032CF8611522A39703F2A28D9");

  foreach(var_8 in var_2) {
    if(!var_8 scripts\engine\utility::ent_flag_exist("_encstr_92E713689EB03176D35F0F353F093E3841F630E147"))
      var_8 scripts\engine\utility::ent_flag_init("_encstr_92E713689EB03176D35F0F353F093E3841F630E147");

    if(!var_8 scripts\engine\utility::ent_flag_exist("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281"))
      var_8 scripts\engine\utility::ent_flag_init("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281");
  }

  var_1 asmsetstate(var_1.asmname, "_encstr_84610D49100897C2DF809A03583BFF");
  var_1 scripts\asm\asm_bb::bb_setanimScripted();
  var_1.ignoreall = 1;
  var_1.scripted_mode = 1;
  var_10 = undefined;
  var_11 = 2;
  var_12 = undefined;
  var_1 thread decrement_door_count_on_death(var_0, var_1, var_6, var_2);

  if(isDefined(level.spawn_ldoor_anims)) {
    if(var_0.spawners_using == 1) {
      foreach(var_8 in var_2)
      set_door_state(var_8, "_encstr_AA4D0D6FC75143211748F2FB7003A7", var_6);

      var_1 thread soldier_wait_for_door_open_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
    } else
      var_1 thread soldier_wait_for_door_open_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  } else {
    foreach(var_8 in var_2)
    set_door_state(var_8, "_encstr_AA4D0D6FC75143211748F2FB7003A7", var_6);

    var_1 thread soldier_wait_for_door_open_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
  }
}

decrement_door_count_on_death(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0.spawners_using))
    var_0.spawners_using = 0;

  var_0.spawners_using++;

  if(isDefined(var_2) && isDefined(var_2.script_reuse_max))
    var_4 = var_2.script_reuse_max;
  else
    var_4 = 3;

  if(var_0.spawners_using >= var_4) {
    foreach(var_6 in var_3)
    var_6 thread scripts\engine\utility::ent_flag_set_delayed("_encstr_92E713689EB03176D35F0F353F093E3841F630E147", 0.25);
  }

  var_1 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D561A0A7D20139103186C03E18FC72A339DE71807DB3B3809B1173F");
  decrement_spawners_using_count(var_0, var_3);
}

decrement_spawners_using_count(var_0, var_1) {
  var_2 = var_0.spawners_using;

  if(var_2 <= 0)
    var_2 = 0;
  else
    var_2--;

  var_0.spawners_using = var_2;

  if(var_0.spawners_using <= 0) {
    foreach(var_4 in var_1)
    set_door_state(var_4, "_encstr_B1520D7B3750C3BFC058151A90C0CF");
  }
}

soldier_wait_for_door_open_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_1 notify("_encstr_832F249BBF32C06CF75BF027BFB005CF97DACE61D9471863D9282B35E0C8D275C3F3F02D3E27");
  var_1 endon("_encstr_832F249BBF32C06CF75BF027BFB005CF97DACE61D9471863D9282B35E0C8D275C3F3F02D3E27");
  var_1 endon("_encstr_AD75063D571AE108");
  var_8 = undefined;
  var_9 = undefined;
  var_10 = 7;
  var_1.invulnerable = 1;
  var_1.animname = "_encstr_A56016C2A5FADCE01677E6F591DE7B4E7D6E7B638CA52BE4";
  var_11 = 0;
  var_12 = undefined;
  var_1 scripts\engine\utility::disable_pain();

  if(isDefined(var_0.anim_node))
    var_13 = var_0.anim_node;
  else
    var_13 = var_0;

  if(istrue(var_7) || !isDefined(var_0.last_ai_spawn_anim)) {
    if(getDvar("_encstr_957C17339F73695A409DABFE87B2F8ED81A813308003DBE517", "_encstr_B40101") != "_encstr_B40101") {
      var_14 = getDvar("_encstr_957C17339F73695A409DABFE87B2F8ED81A813308003DBE517", "_encstr_B40101");
      var_1.ai_door_anim = var_14;
    } else {
      var_14 = scripts\cp\cp_ai_spawn_anim_skits::get_spawn_anim(var_0, var_6, var_1);
      var_1.ai_door_anim = var_14;
    }

    var_0 thread ai_spawn_door_interal(var_0, var_1, var_12, var_2, var_3, var_4, var_6);
  } else {
    if(var_0 scripts\engine\utility::ent_flag("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281"))
      var_0 scripts\engine\utility::ent_flag_waitopen("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281");

    var_14 = get_follow_anim_from_breach_anim(var_0.last_ai_spawn_anim);
    var_1.ai_door_anim = var_14;
  }

  if(var_0 scripts\engine\utility::ent_flag("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281"))
    var_0 scripts\engine\utility::ent_flag_waitopen("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281");

  if(var_0 scripts\engine\utility::ent_flag("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281"))
    var_0 scripts\engine\utility::ent_flag_waitopen("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281");

  if(var_1.agent_type != "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    var_1.ai_door_anim = var_14;
    var_0.last_ai_spawn_anim = var_14;
  }

  var_0 scripts\engine\utility::ent_flag_wait("_encstr_92E713689EB03176D35F0F353F093E3841F630E147");

  if(var_1.agent_type != "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    var_8 = var_1 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_1.ai_door_anim);
    var_9 = var_1 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_8);
    var_15 = var_13.origin;
    var_16 = var_13.angles;

    if(scripts\cp\cp_ai_spawn_anim_skits::is_double_door(var_6))
      var_15 = scripts\cp\cp_ai_spawn_anim_skits::get_double_door_mid_point(var_6);

    var_3 = getstartorigin(var_15, var_16, var_9);
    var_4 = getstartangles(var_15, var_16, var_9);
    var_1 dontinterpolate();
    var_1 forceteleport(var_3, var_4);
  }

  foreach(var_18 in var_2)
  set_door_state(var_18, "_encstr_93CF08C7684F60BBB372", var_6);

  var_0 scripts\engine\utility::ent_flag_wait("_encstr_A9880DE0321D2D266FA86DD09943E9");
  var_1.invulnerable = undefined;

  if(var_1.agent_type != "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
    var_1 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_8);
    var_1 animmode("_encstr_B69807B9DE36C69683");
    var_10 = getanimlength(var_9);
    run_door_spawn_end_funcs(var_1, var_0, var_5, var_10, var_2, var_13);
  } else {
    if(isDefined(var_1.enemy))
      var_1 set_goal_pos(var_1.enemy.origin);
    else {
      var_20 = scripts\cp\utility::get_array_of_valid_players(1, var_1.origin)[0];

      if(isDefined(var_20))
        var_1 set_goal_pos(var_20.origin);
    }

    run_door_spawn_end_funcs(var_1, var_0, var_5, var_10, var_2);
  }
}

play_intro_animation(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0.last_ai_spawn_anim = var_2;
  var_4 = var_1 scripts\asm\asm::asm_lookupanimfromalias("_encstr_84610D49100897C2DF809A03583BFF", var_2);
  var_5 = var_1 scripts\asm\asm::asm_getxanim("_encstr_84610D49100897C2DF809A03583BFF", var_4);
  var_6 = var_0.origin;
  var_7 = var_0.angles;
  var_8 = getstartorigin(var_6, var_7, var_5);
  var_9 = getstartangles(var_6, var_7, var_5);
  var_1 dontinterpolate();
  var_1 forceteleport(var_8, var_9);
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_10 setModel("_encstr_A5341932F00DA43F789DF7D721661FEAA3285A7A2BA7DA473072D5");
  wait 0.2;
  var_1 aisetanim("_encstr_84610D49100897C2DF809A03583BFF", var_4);
  var_1 animmode("_encstr_B69807B9DE36C69683");
  var_11 = getanimlength(var_5);
  var_12 = get_door_anim_from_ai_anim(var_2);

  if(isDefined(var_0.linkedpents)) {
    foreach(var_14 in var_0.linkedpents) {
      var_14.animname = "_encstr_84480E58D2AF37832CBBE6AFC87BDB4E";
      var_14 useanimtree(level.scr_animtree[var_14.animname]);
      var_0 thread scripts\common\anim::anim_single_solo(var_14, var_12);
    }
  } else if(isDefined(var_0.targetmodels)) {
    foreach(var_14 in var_0.targetmodels) {
      var_14.animname = "_encstr_84480E58D2AF37832CBBE6AFC87BDB4E";
      var_14 useanimtree(level.scr_animtree[var_14.animname]);
      var_0 thread scripts\common\anim::anim_single_solo(var_14, var_12);
    }
  } else if(isent(var_0)) {
    var_0.animname = "_encstr_84480E58D2AF37832CBBE6AFC87BDB4E";
    var_0 useanimtree(level.scr_animtree[var_0.animname]);
    var_0 thread scripts\common\anim::anim_single_solo(var_0, var_12);
  }

  wait(var_11);
  var_10 delete();
  wait 1;

  foreach(var_19 in var_3)
  var_19 scripts\engine\utility::ent_flag_clear("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281");
}

ai_spawn_door_interal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("_encstr_A31C16C24BD7CD83C2EEDCD719DBED9CEBD2731D2B93851B");
  var_0 endon("_encstr_A31C16C24BD7CD83C2EEDCD719DBED9CEBD2731D2B93851B");
  var_2 = "_encstr_A3B50F0330A0BC21FD177F730F120AF3D8";
  var_7 = get_door_anim_from_ai_anim(var_1.ai_door_anim);

  if(isDefined(level.scr_anim["_encstr_84480E58D2AF37832CBBE6AFC87BDB4E"][var_7])) {
    var_8 = getanimlength(level.scr_anim["_encstr_84480E58D2AF37832CBBE6AFC87BDB4E"][var_7]);
    var_9 = 0.5;
  } else {
    var_8 = 5;
    var_9 = 0.5;
  }

  var_0 thread run_open_door_anim(var_0, var_2, var_7, var_8, var_9, var_6, var_3);

  if(var_0 scripts\engine\utility::ent_flag("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281"))
    var_0 scripts\engine\utility::ent_flag_waitopen("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281");

  var_0 scripts\engine\utility::ent_flag_wait_or_timeout("_encstr_92E713689EB03176D35F0F353F093E3841F630E147", 3);

  foreach(var_11 in var_3)
  var_11 scripts\engine\utility::ent_flag_set("_encstr_92E713689EB03176D35F0F353F093E3841F630E147");

  var_0 scripts\engine\utility::ent_flag_wait("_encstr_A9880DE0321D2D266FA86DD09943E9");
  wait 0.75;

  if(isDefined(var_2) && soundexists(var_2))
    scripts\cp\utility::playsoundinspace(var_2, var_4);
}

run_door_spawn_end_funcs(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_3)) {
    var_0 thread scripts\cp\utility::notify_delay("_encstr_8D561A0A7D20139103186C03E18FC72A339DE71807DB3B3809B1173F", var_3);
    var_6 = max(0.05, var_3 - 0.25);
    wait(var_6);
  }

  var_0.ignoreall = 0;

  if(isDefined(var_2))
    [[var_2]](var_0);
  else {
    if(var_0.agent_type != "_encstr_8BFC0BC2CBD4F737E0A5E1FD79") {
      var_0 set_goal_radius(2000);
      var_0 scripts\engine\utility::enable_pain();
      var_0 animmode("_encstr_820E07FAE8780B3A4C");
    } else
      var_0 set_goal_radius(128);

    var_0 scripts\asm\shared\mp\utility::bunkercounteruav();

    if(isDefined(var_0.spawnpoint.target))
      var_0 thread start_patrol();
    else
      var_0 thread enter_combat();
  }
}

run_open_door_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("_encstr_820E133BE5986FDA5087D0E7F93870330F02A28158");
  var_0 endon("_encstr_820E133BE5986FDA5087D0E7F93870330F02A28158");
  var_0 scripts\engine\utility::ent_flag_wait("_encstr_A9880DE0321D2D266FA86DD09943E9");

  if(isDefined(var_0.anim_node))
    var_7 = var_0.anim_node;
  else
    var_7 = var_0;

  if(isDefined(var_0.linkedpents)) {
    foreach(var_9 in var_0.linkedpents) {
      var_9.animname = "_encstr_84480E58D2AF37832CBBE6AFC87BDB4E";
      var_9 useanimtree(level.scr_animtree[var_9.animname]);
      var_7 thread scripts\common\anim::anim_single_solo(var_9, var_2);
      var_9 notify("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");
    }
  } else if(isDefined(var_0.targetmodels)) {
    foreach(var_9 in var_0.targetmodels) {
      var_9.animname = "_encstr_84480E58D2AF37832CBBE6AFC87BDB4E";
      var_9 useanimtree(level.scr_animtree[var_9.animname]);
      var_7 thread scripts\common\anim::anim_single_solo(var_9, var_2);
      var_9 notify("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");
    }
  } else if(isent(var_0)) {
    var_0.animname = "_encstr_84480E58D2AF37832CBBE6AFC87BDB4E";
    var_0 useanimtree(level.scr_animtree[self.animname]);
    var_7 thread scripts\common\anim::anim_single_solo(var_0, var_2);
    var_0 notify("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");
  }

  wait_for_door_anim_end(var_0, var_3, var_4, var_5, var_6, var_2);
}

wait_for_door_anim_end(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_A7011707FF4BFB5762AADB39A8B75A1A3711263AEAC93FBD8D");
  var_0 endon("_encstr_A7011707FF4BFB5762AADB39A8B75A1A3711263AEAC93FBD8D");

  foreach(var_7 in var_4)
  set_door_state(var_7, "_encstr_8A4A07DB83569BAC91", var_3);

  wait(max(0, var_1 + 1.25));

  foreach(var_7 in var_4)
  set_door_state(var_7, "_encstr_A350079E35DACF8944", var_3);
}

subway_black_screen() {
  if(!scripts\engine\utility::ent_flag_exist("_encstr_83E20CC8DEEDC9F56CD8ED37B2C8"))
    scripts\engine\utility::ent_flag_init("_encstr_83E20CC8DEEDC9F56CD8ED37B2C8");

  if(!scripts\engine\utility::ent_flag_exist("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45"))
    scripts\engine\utility::ent_flag_init("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");

  if(!scripts\engine\utility::ent_flag_exist("_encstr_A9880DE0321D2D266FA86DD09943E9"))
    scripts\engine\utility::ent_flag_init("_encstr_A9880DE0321D2D266FA86DD09943E9");

  if(!scripts\engine\utility::ent_flag_exist("_encstr_B1520D7B3750C3BFC058151A90C0CF"))
    scripts\engine\utility::ent_flag_init("_encstr_B1520D7B3750C3BFC058151A90C0CF");

  if(!scripts\engine\utility::ent_flag_exist("_encstr_87761291DEDE4EEBDE83959B7DB91DB09C1DB2C8"))
    scripts\engine\utility::ent_flag_init("_encstr_87761291DEDE4EEBDE83959B7DB91DB09C1DB2C8");
}

set_door_state(var_0, var_1, var_2) {
  var_0 subway_black_screen();
  var_0.current_state = var_1;
  var_0 scripts\engine\utility::ent_flag_clear("_encstr_B2CA11F3D31C9ED059A75EF9630FDEA7F03281");

  switch (var_1) {
    case "_encstr_93CF08C7684F60BBB372":
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_83E20CC8DEEDC9F56CD8ED37B2C8");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");
      var_0 scripts\engine\utility::ent_flag_set("_encstr_A9880DE0321D2D266FA86DD09943E9");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_B1520D7B3750C3BFC058151A90C0CF");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_87761291DEDE4EEBDE83959B7DB91DB09C1DB2C8");
      break;
    case "_encstr_B1520D7B3750C3BFC058151A90C0CF":
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_83E20CC8DEEDC9F56CD8ED37B2C8");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_A9880DE0321D2D266FA86DD09943E9");
      var_0 scripts\engine\utility::ent_flag_set("_encstr_B1520D7B3750C3BFC058151A90C0CF");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_87761291DEDE4EEBDE83959B7DB91DB09C1DB2C8");
      break;
    case "_encstr_8A4A07DB83569BAC91":
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_83E20CC8DEEDC9F56CD8ED37B2C8");
      var_0 scripts\engine\utility::ent_flag_set("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_A9880DE0321D2D266FA86DD09943E9");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_B1520D7B3750C3BFC058151A90C0CF");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_87761291DEDE4EEBDE83959B7DB91DB09C1DB2C8");
      break;
    case "_encstr_A350079E35DACF8944":
      var_0 scripts\engine\utility::ent_flag_set("_encstr_83E20CC8DEEDC9F56CD8ED37B2C8");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_A9880DE0321D2D266FA86DD09943E9");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_B1520D7B3750C3BFC058151A90C0CF");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_87761291DEDE4EEBDE83959B7DB91DB09C1DB2C8");
      var_0.last_ai_spawn_anim = undefined;
      var_0.spawners_using = 0;
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_92E713689EB03176D35F0F353F093E3841F630E147");

      if(isDefined(var_2)) {
        var_2 mounted();
        var_2.door = undefined;
        var_2.used_recently = undefined;
        var_2.count = 0;
      }

      break;
    case "_encstr_AA4D0D6FC75143211748F2FB7003A7":
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_83E20CC8DEEDC9F56CD8ED37B2C8");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_9BE10CFD47E2B3B72FA1AFF8FD45");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_A9880DE0321D2D266FA86DD09943E9");
      var_0 scripts\engine\utility::ent_flag_clear("_encstr_B1520D7B3750C3BFC058151A90C0CF");
      var_0 scripts\engine\utility::ent_flag_set("_encstr_87761291DEDE4EEBDE83959B7DB91DB09C1DB2C8");
      break;
  }
}

get_follow_anim_from_breach_anim(var_0) {
  switch (var_0) {
    case "_encstr_AA9F269654FBDEFFE592B118BA7BBB33F7F495B7A71306D74C1A18A12290178B376EB08F3F072821":
    case "_encstr_962E229B464EBE36DEDAD796CD1D2B9CAFB191F6DEC9BEAD4B36B57DB2F07D935737AF85":
      return "_encstr_872E220B22ABF0408D3DF7935633082E773A61303A7308C8240B8787451811F667729E19";
    case "_encstr_872E220B22ABF0408D3DF7935633082E773A61303A7308C8240B8787451811F667729E19":
      return "_encstr_BD2E22FAA9B07F2AA0CB77A725D5B2AA3130B74560E837E28BEFBF872BFB59E2D898E1CE";
    case "_encstr_BD2E22FAA9B07F2AA0CB77A725D5B2AA3130B74560E837E28BEFBF872BFB59E2D898E1CE":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "_encstr_8F27223885D2470BE808097FD0C163ABD1813418C04DB9D32043C22F6DC2D9E86B5841D7":
      return "_encstr_A1272260BA62BF69B77DB8AB46E391AD81A250F8623A07A0479BBA8825BB9E57F2EA1118";
    case "_encstr_A1272260BA62BF69B77DB8AB46E391AD81A250F8623A07A0479BBA8825BB9E57F2EA1118":
      return "_encstr_932722DF5CAAC99E97F2F638EAD3457809BC096FCF1281D2F70A48E6A23B10B8DA0AF7EF";
    case "_encstr_932722DF5CAAC99E97F2F638EAD3457809BC096FCF1281D2F70A48E6A23B10B8DA0AF7EF":
      return scripts\engine\utility::random(level.spawn_dbldoor_anims);
    case "_encstr_A7B824FB41F6AF0EA03BB79925A057D388B96292E9C03702491F899BC7D11F83D0D3EB3A16AF":
      return "_encstr_A3B82402514887E27813BF1F6D9DCAE279F9FE4DC9484F2B58376F3F4FD03230D143B3554698";
    case "_encstr_A3B82402514887E27813BF1F6D9DCAE279F9FE4DC9484F2B58376F3F4FD03230D143B3554698":
      return "_encstr_93B82457239318A0AF9D26F8459CD8C6F98BEDE1DBAAD810C774E8B12C4F2B7B914B4B1D9F32";
    case "_encstr_93B82457239318A0AF9D26F8459CD8C6F98BEDE1DBAAD810C774E8B12C4F2B7B914B4B1D9F32":
      return scripts\engine\utility::random(level.spawn_dbldoor_anims);
    case "_encstr_856C24E69193D7C6DE6BBE9637A3CA27AF914C638CBDB74EFA6DD26CADFAAC1EFA6C1798AF85":
      return "_encstr_8A6C24B9C827BE8DDEADFA4B731D59E4EB8CC46346F67BC9EBB6B46CD6BE56F0AF1BB826BE13";
    case "_encstr_8A6C24B9C827BE8DDEADFA4B731D59E4EB8CC46346F67BC9EBB6B46CD6BE56F0AF1BB826BE13":
      return "_encstr_846C246E919CBEC6ED5BEB96CDD1AC39AF3213D891F6ED39EBAD5A8DB5D7CA3CBED82E4CF536";
    case "_encstr_846C246E919CBEC6ED5BEB96CDD1AC39AF3213D891F6ED39EBAD5A8DB5D7CA3CBED82E4CF536":
      return scripts\engine\utility::random(level.spawn_dbldoor_anims);
    case "_encstr_8164273A6970BFEA600BB7676595F2EA71F07785A0A877634F3163C777335A3BC9B9E801FB381EB997":
      return "_encstr_AA64276E46C9FA1BBD5BBEA59B1DCA93FA8D23B77BE47DBBB01BD8D76DD2C6B5AFACC3FA39BAE6F598";
    case "_encstr_AA64276E46C9FA1BBD5BBEA59B1DCA93FA8D23B77BE47DBBB01BD8D76DD2C6B5AFACC3FA39BAE6F598":
      return "_encstr_9764270BB1E8A90F3020610A68952F5A2939946FCFB0E197EFF84A51D0637FD4D18310D74D60756F86";
    case "_encstr_9764270BB1E8A90F3020610A68952F5A2939946FCFB0E197EFF84A51D0637FD4D18310D74D60756F86":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "_encstr_8203271FF1A0DFF7EDC2B043D0638D6547E97BB7AF7B078F0F7160A9C3F8FB3A61C5ABCF13EA0286D1":
      return "_encstr_960327DC1939EB36B7D6EB5A738EAC39F53619B7DEC97DDD2C1BB1F55BB436ADD7B2F0F5C65C31AF26";
    case "_encstr_960327DC1939EB36B7D6EB5A738EAC39F53619B7DEC97DDD2C1BB1F55BB436ADD7B2F0F5C65C31AF26":
      return "_encstr_870327AB820B10A06DDD1773F693A84E179AC1D0DAD3A84886A46927EB3C509A6FA2DA5EA2B77ED1DE";
    case "_encstr_870327AB820B10A06DDD1773F693A84E179AC1D0DAD3A84886A46927EB3C509A6FA2DA5EA2B77ED1DE":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "_encstr_817A276370B599C7A88967591093879A47789A3AC04D415F41612C77BAD857641FA8E3B1B0EB45C7B9":
      return "_encstr_877A27CB5C0AD1D63D50386035C3DD0A218B6F20ED2BF1C0C7C0B357DA321F62471A6BC1533F70A9AD";
    case "_encstr_877A27CB5C0AD1D63D50386035C3DD0A218B6F20ED2BF1C0C7C0B357DA321F62471A6BC1533F70A9AD":
      return "_encstr_967A27CD469CBE6CF65BD72DE61D594EEB938CF6F6C97DEE168D8DF5AD5AD86DAFAC0FF5C95D737D1B";
    case "_encstr_967A27CD469CBE6CF65BD72DE61D594EEB938CF6F6C97DEE168D8DF5AD5AD86DAFAC0FF5C95D737D1B":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "_encstr_868027B309BEF756E843FFC16D189F1B70A3BAFAF0163F8B6059F4EF1FA826B798F9F361D96F73C948":
      return "_encstr_A58027AA459D89E368E0EF3FD023DDE36FE6F725B8C5C13F71103BDFE0F893BA97F57851162BCA4F79";
    case "_encstr_A58027AA459D89E368E0EF3FD023DDE36FE6F725B8C5C13F71103BDFE0F893BA97F57851162BCA4F79":
      return "_encstr_8D8027AB820B10A06DDD1773F693A84E177BC1D0DAD3A84886A46927EB3C509A6FA2DA5EA2B77ED1DE";
    case "_encstr_8D8027AB820B10A06DDD1773F693A84E177BC1D0DAD3A84886A46927EB3C509A6FA2DA5EA2B77ED1DE":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "_encstr_92EC262753E368D0BF8D36C8758C2836E99BF197E74BD028C9A558061B4120F822730F1737329850":
      return "_encstr_BEEC26EB5108492F10AD412A08F54F7A09D9744FEFD081B7CF186A3153479FF96099D7CB2BF8D9BB";
    case "_encstr_BEEC26EB5108492F10AD412A08F54F7A09D9744FEFD081B7CF186A3153479FF96099D7CB2BF8D9BB":
      return "_encstr_8EEC2627A42241060F7A4EB0725BCDE0B13481E7478AF9545F02207E3BE7F6D157886F77E1F6B196";
    case "_encstr_8EEC2627A42241060F7A4EB0725BCDE0B13481E7478AF9545F02207E3BE7F6D157886F77E1F6B196":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "_encstr_871E213AD50D199318907FAF60934D13FF7947B5C87551CCE1F88787E8AE036B5D188E":
      return "_encstr_921E21B9919C7DD8DEADF5A537A3AC93F5638CDBBD9CFAD1B01BBE2BC3FAD81798FA89";
    case "_encstr_921E21B9919C7DD8DEADF5A537A3AC93F5638CDBBD9CFAD1B01BBE2BC3FAD81798FA89":
      return "_encstr_821E211F88AB5FA28F41F112C6EB8F0A4FDC2FC7B058EF089F22E097E289168B326FAF";
    case "_encstr_821E211F88AB5FA28F41F112C6EB8F0A4FDC2FC7B058EF089F22E097E289168B326FAF":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "_encstr_B81026A3EB137E48DD454F996B43BDDB1786A57F6F8A092C2788644753B150D009F0CFAE63D60999":
      return "_encstr_921026628D2531AB20B8A747987B652BA71E2F9DE08D89E789D86397A0315BA1BBB3791657D5C13A";
    case "_encstr_921026628D2531AB20B8A747987B652BA71E2F9DE08D89E789D86397A0315BA1BBB3791657D5C13A":
      return "_encstr_BE1026DFAB1B90582715BE70FD0450BE616B791F6FC358B0412DC08E63F9A860BAEB978FAFAAAFC8";
    case "_encstr_BE1026DFAB1B90582715BE70FD0450BE616B791F6FC358B0412DC08E63F9A860BAEB978FAFAAAFC8":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "_encstr_A35926BE6CC3E6D7CDCAD960D223831B1F1C4D38CF7B2EABE2F198988A7D3F315B87432554CF9663":
      return "_encstr_AC5926B3A065A9F798D9370960C3D7AA97784A0A903D11569B28702D09A877B72149023230FBD963";
    case "_encstr_AC5926B3A065A9F798D9370960C3D7AA97784A0A903D11569B28702D09A877B72149023230FBD963":
      return "_encstr_9159266EC893BE1B7BB6FA96B9A3CA39AF63237BB793AF9C81AF1CBA3636F5AC1ED7D2231BB2EB8D";
    case "_encstr_9159266EC893BE1B7BB6FA96B9A3CA39AF63237BB793AF9C81AF1CBA3636F5AC1ED7D2231BB2EB8D":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "_encstr_B4DA26D23DF5E17BF048579748CB357BD74E9F4D105D39D9F3F1E3EF30E0D7F23170A40709AB71C9":
      return "_encstr_B6DA26DC1927F58DED5BF54B9BE89593EB27C8BDED4EAF7206D71CEAC636D7AC1ED7A5C88DCAD74C";
    case "_encstr_B6DA26DC1927F58DED5BF54B9BE89593EB27C8BDED4EAF7206D71CEAC636D7AC1ED7A5C88DCAD74C":
      return "_encstr_A6DA262B91265FFE50EB672995F007A3D8CBD25258FEA7A082A7403DB9184127F3069A6AC0DDEF6E";
    case "_encstr_A6DA262B91265FFE50EB672995F007A3D8CBD25258FEA7A082A7403DB9184127F3069A6AC0DDEF6E":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "_encstr_9165210B174B510A5753BF6185D8EDD68123D14FAFB3890B88F781EF8037DE97124F49":
      return "_encstr_AC6521101BFA6E478A2DC0D3C51383736FEB30784F922651B256D8ED58D9D7DBBAC788";
    case "_encstr_AC6521101BFA6E478A2DC0D3C51383736FEB30784F922651B256D8ED58D9D7DBBAC788":
      return "_encstr_B865210A59408FFA701BC71775A5C2FA81234795D0B847435F1FBF3F61D86A3130EE3E";
    case "_encstr_B865210A59408FFA701BC71775A5C2FA81234795D0B847435F1FBF3F61D86A3130EE3E":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "_encstr_A6C22B1BB3CBC19F87B150A452E540D2E0391317271B79CF8F3B71278B59C02BA08D0DCA696DCBB17377239FCE":
      return "_encstr_8AC22B4B3F5AD19EC28FFF9BEB1BD5E0DF95114065A2194C1A93E1EFA7022810B4EFB97B811D5810C3DFEDE70B";
    case "_encstr_8AC22B4B3F5AD19EC28FFF9BEB1BD5E0DF95114065A2194C1A93E1EFA7022810B4EFB97B811D5810C3DFEDE70B":
      return "_encstr_84C22B5E3CD35742D8DD713BF85BF79B968D92CFEF721923888238C9CE195FD389437F834027B316906DF0094E";
    case "_encstr_84C22B5E3CD35742D8DD713BF85BF79B968D92CFEF721923888238C9CE195FD389437F834027B316906DF0094E":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "_encstr_87B22628F22A07D17FA560638E3B59E5D9DA0840BAC2CFEB3BDF7DE99C8763F73F035950B39D9761":
      return "_encstr_81B2260B07CBF9B6276841195023102DB7C8396F95881F270908550825F31BE998BA7798558B71AE";
    case "_encstr_81B2260B07CBF9B6276841195023102DB7C8396F95881F270908550825F31BE998BA7798558B71AE":
      return "_encstr_88B226787392361F2295680B2DEB6BDBD7CB4820F74ACEF77A3D758187D28DA655F3094067FE868F";
    case "_encstr_88B226787392361F2295680B2DEB6BDBD7CB4820F74ACEF77A3D758187D28DA655F3094067FE868F":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "_encstr_92302B87817EB1234098F97CD0B06DDB4005437F6FA6790F68C02DC96BA8BFE3A1B1CFF3A74553EF18CBA5C1C1":
      return "_encstr_82302BE62393FA36DEB5FAA5DC1D59937D3946EDDEC9FADD85C6D87DB90DB7ABD819564E7DAC1EBE27AEDCEB98";
    case "_encstr_82302BE62393FA36DEB5FAA5DC1D59937D3946EDDEC9FADD85C6D87DB90DB7ABD819564E7DAC1EBE27AEDCEB98":
      return "_encstr_BD302BCD4639FA1BF6DA7DD2B947B29CF54E19F6DEC9EBEEB0C61BFAE686DEBA1B1959C9D7B2E1D74EAB37AF6C";
    case "_encstr_BD302BCD4639FA1BF6DA7DD2B947B29CF54E19F6DEC9EBEEB0C61BFAE686DEBA1B1959C9D7B2E1D74EAB37AF6C":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "_encstr_82261CE6477BE7393FFFB9708B5CB1F5F1EDD5601D931F4114E7D0706761":
      return "_encstr_998D2268B26A4791BF65A0A34EFB99A5999A487B7A020F096B91BE2B67CF23433DD2C028";
    case "_encstr_998D2268B26A4791BF65A0A34EFB99A5999A487B7A020F096B91BE2B67CF23433DD2C028":
      return "_encstr_82261CE6477BE7393FFFB9708B5CB1F5F1EDD5601D931F4114E7D0706761";
    case "_encstr_83A81CD6E52AD97338CF8784BAF828463EA5E3B768A3579B73C8FF428741":
      return "_encstr_99AD22D3ADD3E74E4FE071EA7381079BAE014C77B0BB9F1263D83A22A18FBA9F207FD4F5";
    case "_encstr_99AD22D3ADD3E74E4FE071EA7381079BAE014C77B0BB9F1263D83A22A18FBA9F207FD4F5":
      return "_encstr_83A81CD6E52AD97338CF8784BAF828463EA5E3B768A3579B73C8FF428741";
    case "_encstr_AB141CB98C27D78DB7DABEB4B947B239AF4E46DBDE39FA993685370D7D0B":
      return "_encstr_8C5122B91993BEC6EDB6EB2D37E8CA39AF9C23DBDB93FA991BC2B9D07DCE4ECA372C9195";
    case "_encstr_8C5122B91993BEC6EDB6EB2D37E8CA39AF9C23DBDB93FA991BC2B9D07DCE4ECA372C9195":
      return "_encstr_AB141CB98C27D78DB7DABEB4B947B239AF4E46DBDE39FA993685370D7D0B";
    case "_encstr_846E1C6E919CBEC6ED5BEB96CDD1AC39AF3923DEBD27EBB9ADBDDA95AF58":
      return "_encstr_976922E604AB8EAFB5A281C86A8B6BE3C7BAE55097C3F6D71DAA28A051673D59AB517DDD";
    case "_encstr_976922E604AB8EAFB5A281C86A8B6BE3C7BAE55097C3F6D71DAA28A051673D59AB517DDD":
      return "_encstr_846E1C6E919CBEC6ED5BEB96CDD1AC39AF3923DEBD27EBB9ADBDDA95AF58";
  }
}

get_door_anim_from_ai_anim(var_0) {
  if(!isDefined(var_0))
    return "_encstr_A6602A833960217748A8F982D01DA7A2B1BD0C175708791F6760C2E958FBE75C590B985FC5E8FDF79D380A03";

  switch (var_0) {
    case "_encstr_A35926BE6CC3E6D7CDCAD960D223831B1F1C4D38CF7B2EABE2F198988A7D3F315B87432554CF9663":
      return "_encstr_87F929DCC839EBC67BB5FAB473D12B27F5C646DEB739AFC9C07DE0BA1B1BBE2BC3F5A591C659AF91DBF693";
    case "_encstr_B4DA26D23DF5E17BF048579748CB357BD74E9F4D105D39D9F3F1E3EF30E0D7F23170A40709AB71C9":
      return "_encstr_85A429D23DF5E17BF048579748CB357BD74E9F4D105D39D9F3F1E3EF30E0D7F23170A40709AB71CC2088D3";
    case "_encstr_AA9F269654FBDEFFE592B118BA7BBB33F7F495B7A71306D74C1A18A12290178B376EB08F3F072821":
    case "_encstr_962E229B464EBE36DEDAD796CD1D2B9CAFB191F6DEC9BEAD4B36B57DB2F07D935737AF85":
      return "_encstr_A5C325E3E58A81F96223593B580BF145177999CD701AE19C220EB8976F5221CAD533F941270762";
    case "_encstr_8F27223885D2470BE808097FD0C163ABD1813418C04DB9D32043C22F6DC2D9E86B5841D7":
      return "_encstr_BDAA253697AB37E9EFCF8920DB2CE1A5C13D25B02DC36FD0C11F2099DF48FE3FCB26304D85CAFD";
    case "_encstr_A7B824FB41F6AF0EA03BB79925A057D388B96292E9C03702491F899BC7D11F83D0D3EB3A16AF":
      return "_encstr_9A4528B862BA97418F5590F33E8BC995A9CA88C8FA153FBB774B83FE03FF314901D3B840A16F47502B7A";
    case "_encstr_856C24E69193D7C6DE6BBE9637A3CA27AF914C638CBDB74EFA6DD26CADFAAC1EFA6C1798AF85":
      return "_encstr_83AD28D6E52AD97338CF8784BAF828463EA7FBB13072678B17E8FB225786176019392A022FB20742A3D0";
    case "_encstr_8164273A6970BFEA600BB7676595F2EA71F07785A0A877634F3163C777335A3BC9B9E801FB381EB997":
      return "_encstr_B88B2A1B32BBC070BD0DE7832623181E67CA71ED2A031818D614B9F75B4CE06ABFF28A8E63F7C821AFFFB7A5";
    case "_encstr_8203271FF1A0DFF7EDC2B043D0638D6547E97BB7AF7B078F0F7160A9C3F8FB3A61C5ABCF13EA0286D1":
      return "_encstr_864E2AA323F017EF90520E72FA21B04B91ED384A90E801B4A2D94C1190247A6A7F4B90CE8BC212E810D728C6";
    case "_encstr_817A276370B599C7A88967591093879A47789A3AC04D415F41612C77BAD857641FA8E3B1B0EB45C7B9":
      return "_encstr_A6602A833960217748A8F982D01DA7A2B1BD0C175708791F6760C2E958FBE75C590B985FC5E8FDF79D380A03";
    case "_encstr_868027B309BEF756E843FFC16D189F1B70A3BAFAF0163F8B6059F4EF1FA826B798F9F361D96F73C948":
      return "_encstr_BE812A47A8C3CFA2472971F480299AAA0E6093AF587B172BB3B185617A3B324BD6709BE7A0F362D181D84D22";
    case "_encstr_92EC262753E368D0BF8D36C8758C2836E99BF197E74BD028C9A558061B4120F822730F1737329850":
      return "_encstr_A101299B469CF56CB7DAAFB4CD3A9539D7638CB77B39EBBB85C68DF51D2CB1EB591EFA36E2C47D32F6BD4E";
    case "_encstr_871E213AD50D199318907FAF60934D13FF7947B5C87551CCE1F88787E8AE036B5D188E":
      return "_encstr_8B8D2462CFCB570387F06170B66BC96D3881E790704551DCDF47D9C5D8FF394AD1EF8C289870";
    case "_encstr_B81026A3EB137E48DD454F996B43BDDB1786A57F6F8A092C2788644753B150D009F0CFAE63D60999":
      return "_encstr_86032937D8B35F32D7B9C14410D96A3ABEF0E33FE8EBE7BB23C115F1059B42CF01089787A0012FD267689A";
    case "_encstr_9165210B174B510A5753BF6185D8EDD68123D14FAFB3890B88F781EF8037DE97124F49":
      return "_encstr_A16724E6234EF5C6ED5BAF4B373A56C9F5E48CEDED39D73A858DFACA3CEBC6E2897D8CDBDE4E";
    case "_encstr_A6C22B1BB3CBC19F87B150A452E540D2E0391317271B79CF8F3B71278B59C02BA08D0DCA696DCBB17377239FCE":
      return "_encstr_86AC2ECD4639FA6CB7DA7DD2738EB24EAFB119EDB74EBE7785368DEB6EA1DBBA36232B4EFAAC1EBE39BA73FAC8EDDEE4";
    case "_encstr_87B22628F22A07D17FA560638E3B59E5D9DA0840BAC2CFEB3BDF7DE99C8763F73F035950B39D9761":
      return "_encstr_956029DC324EEB8DF6ADF54B373ACA27BE36C8F6DB9C7DDC34F65DC61956E4FA2BE1BEE4AB9B7DC8DBDB4E";
    case "_encstr_92302B87817EB1234098F97CD0B06DDB4005437F6FA6790F68C02DC96BA8BFE3A1B1CFF3A74553EF18CBA5C1C1":
      return "_encstr_BDD82EEB8F8D4977E7D8C79AEDE3536BF0BA40A79083E7DBA9E5BB577B78FF3BB85175FB47B9C9E73B4DCD16D03FD772";
    case "_encstr_82261CE6477BE7393FFFB9708B5CB1F5F1EDD5601D931F4114E7D0706761":
      return "_encstr_AA041F404BAA3E173A9D100335E353C3DFC34028FF42F6C532867E9B413ABFA85A";
    case "_encstr_998D2268B26A4791BF65A0A34EFB99A5999A487B7A020F096B91BE2B67CF23433DD2C028":
      return "_encstr_AA041F404BAA3E173A9D100335E353C3DFC34028FF42F6C532867E9B413ABFA85A";
    case "_encstr_83A81CD6E52AD97338CF8784BAF828463EA5E3B768A3579B73C8FF428741":
      return "_encstr_B29C1F331A93F8489525FFEB5E3B30367F326938327B30102D0F9FFB47E7987063";
    case "_encstr_99AD22D3ADD3E74E4FE071EA7381079BAE014C77B0BB9F1263D83A22A18FBA9F207FD4F5":
      return "_encstr_B29C1F331A93F8489525FFEB5E3B30367F326938327B30102D0F9FFB47E7987063";
    case "_encstr_AB141CB98C27D78DB7DABEB4B947B239AF4E46DBDE39FA993685370D7D0B":
      return "_encstr_B4D51FB9464EAFB1DEADFA4B73D1ACC9FAE4C87BDB4EEB9936856ED0D7C8BDF693";
    case "_encstr_8C5122B91993BEC6EDB6EB2D37E8CA39AF9C23DBDB93FA991BC2B9D07DCE4ECA372C9195":
      return "_encstr_AB141CB98C27D78DB7DABEB4B947B239AF4E46DBDE39FA993685370D7D0B";
    case "_encstr_846E1C6E919CBEC6ED5BEB96CDD1AC39AF3923DEBD27EBB9ADBDDA95AF58":
      return "_encstr_88A61F9A9B93F7D6BA09B6137D298ADB49EBB70735B2E9977997FAB850374FB77A";
    case "_encstr_976922E604AB8EAFB5A281C86A8B6BE3C7BAE55097C3F6D71DAA28A051673D59AB517DDD":
      return "_encstr_846E1C6E919CBEC6ED5BEB96CDD1AC39AF3923DEBD27EBB9ADBDDA95AF58";
  }

  return var_0;
}

_open_door(var_0, var_1) {
  var_0.angles = var_0.vopenedangles;

  if(isDefined(var_0.linkedpents)) {
    set_door_state(var_0, "_encstr_93CF08C7684F60BBB372");

    foreach(var_3 in var_0.linkedpents) {
      if(isDefined(var_3.collision)) {
        var_3.collision connectpaths();

        if(istrue(var_1))
          var_3.collision delete();
      }

      var_3 rotateTo(var_0.angles, 0.75);
    }

    wait 0.75;
  }

  set_door_state(var_0, "_encstr_8A4A07DB83569BAC91");
  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

add_global_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.global_ai_func_array))
    level.global_ai_func_array = [];

  if(!isDefined(level.global_ai_func_array[var_0]))
    level.global_ai_func_array[var_0] = [];

  var_6 = [];
  var_6["_encstr_B2BB0998FB35773B1FAFF0"] = var_1;
  var_6["_encstr_81D7070E2C93B0D613"] = var_2;
  var_6["_encstr_ADD707F0EB707381A5"] = var_3;
  var_6["_encstr_97D707ABD1FAFFA582"] = var_4;
  var_6["_encstr_87D70783C22716D60D"] = var_5;
  level.global_ai_func_array[var_0][level.global_ai_func_array[var_0].size] = var_6;
}

remove_global_spawn_function(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.global_ai_func_array[var_0].size; var_3++) {
    if(level.global_ai_func_array[var_0][var_3]["_encstr_B2BB0998FB35773B1FAFF0"] != var_1)
      var_2[var_2.size] = level.global_ai_func_array[var_0][var_3];
  }

  level.global_ai_func_array[var_0] = var_2;
}

exists_global_spawn_function(var_0, var_1) {
  if(!isDefined(level.global_ai_func_array))
    return 0;

  for(var_2 = 0; var_2 < level.global_ai_func_array[var_0].size; var_2++) {
    if(level.global_ai_func_array[var_0][var_2]["_encstr_B2BB0998FB35773B1FAFF0"] == var_1)
      return 1;
  }

  return 0;
}

init_passive_wave_struct() {
  var_0 = spawnStruct();
  var_0.high_threshold = undefined;
  var_0.low_threshold = undefined;
  var_0.spawn_window_time = 5;
  var_0.wave_spawn_time = 15;
  var_0.min_count = 0;
  var_0.max_count = 48;
  var_0.wave_time_between_spawns = 1;
  var_0.disable_wave_hud = 0;
  self.passive_wave_settings = var_0;
}

override_passive_wave_spawning_spawners(var_0) {
  if(!scripts\engine\utility::array_contains(self.wave_spawner_overrides, var_0))
    self.wave_spawner_overrides[self.wave_spawner_overrides.size] = var_0;
}

remove_passive_wave_spawning_spawner_override(var_0) {
  if(scripts\engine\utility::array_contains(self.wave_spawner_overrides, var_0))
    self.wave_spawner_overrides = scripts\engine\utility::array_remove(self.wave_spawner_overrides, var_0);
}

add_spawners_to_passive_wave_spawning(var_0) {
  if(!scripts\engine\utility::array_contains(self.requested_spawners, var_0)) {
    var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_1.size > 0) {
      self.requested_spawners[self.requested_spawners.size] = var_0;
      scripts\engine\utility::array_thread(var_1, ::spawner_init);
    }
  }
}

remove_spawners_from_passive_wave_spawning(var_0) {
  if(scripts\engine\utility::array_contains(self.requested_spawners, var_0))
    self.requested_spawners = scripts\engine\utility::array_remove(self.requested_spawners, var_0);
}

battle_stations(var_0) {
  if(!scripts\engine\utility::array_contains(self._id_12C43, var_0)) {
    var_1 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(var_1.size > 0) {
      self._id_12C43[self._id_12C43.size] = var_0;
      scripts\engine\utility::array_thread(var_1, ::spawner_init);
    }
  }
}

_id_12BFB(var_0) {
  if(scripts\engine\utility::array_contains(self._id_12C43, var_0))
    self._id_12C43 = scripts\engine\utility::array_remove(self._id_12C43, var_0);
}

set_passive_wave_high_threshold(var_0) {
  if(isDefined(self.passive_wave_settings))
    self.passive_wave_settings.high_threshold = var_0;
}

add_spawn_scoring_poi(var_0, var_1, var_2) {
  var_1 = define_var_if_undefined(var_1, 1024);
  var_2 = define_var_if_undefined(var_2, 2048);
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = (0, 0, 0);
  var_3.radius = var_1;
  var_3.activation_radius_sq = var_2 * var_2;
  self.spawn_scoring_pois[self.spawn_scoring_pois.size] = var_3;
}

remove_spawn_scoring_poi(var_0) {
  var_1 = self.spawn_scoring_pois;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].origin == var_0)
      self.spawn_scoring_pois = scripts\engine\utility::array_remove(var_1, var_1[var_2]);
  }
}

init_airlock_buttons(var_0, var_1) {
  if(!isDefined(self.aitype_override)) {
    self.aitype_override = [];
    self.aitype_override_weights = [];
    self.aitype_override_cumulative_weight = 0;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    self.aitype_override[self.aitype_override.size] = var_0[var_2];
    var_3 = define_var_if_undefined(var_1[var_2], 10);
    self.aitype_override_weights[self.aitype_override_weights.size] = var_3;
    self.aitype_override_cumulative_weight = self.aitype_override_cumulative_weight + var_3;
  }
}

remove_aitype_spawner_override(var_0) {
  if(isDefined(self.aitype_override)) {
    var_1 = self.aitype_override;
    var_2 = self.aitype_override_weights;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3] == var_0) {
        self.aitype_override = scripts\engine\utility::array_remove(var_1, var_1[var_3]);
        self.aitype_override_weights = scripts\engine\utility::array_remove_index(var_2, var_3);
        self.aitype_override_cumulative_weight = self.aitype_override_cumulative_weight - var_2[var_3];
      }
    }
  }
}

get_passive_wave_high_threshold(var_0, var_1) {
  if(getdvarint("_encstr_83121863403607ACB94B59B9A9D33F98B9FB82537957A86073CB", -1) != -1)
    return getdvarint("_encstr_83121863403607ACB94B59B9A9D33F98B9FB82537957A86073CB");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.high_threshold))
    return self.passive_wave_settings.high_threshold;
  else {
    if(isDefined(var_1))
      return process_module_var(var_0, var_1);

    return undefined;
  }
}

set_passive_wave_low_threshold(var_0) {
  if(isDefined(self.passive_wave_settings))
    self.passive_wave_settings.low_threshold = var_0;
}

get_passive_wave_low_threshold(var_0, var_1) {
  if(getdvarint("_encstr_A6F017237A83E8F8664EFB974CCDB05023629B69830338187F", -1) != -1)
    return getdvarint("_encstr_A6F017237A83E8F8664EFB974CCDB05023629B69830338187F");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.low_threshold))
    return self.passive_wave_settings.low_threshold;
  else {
    if(isDefined(var_1))
      return process_module_var(var_0, var_1);

    return undefined;
  }
}

set_passive_spawn_window_time(var_0) {
  if(isDefined(self.passive_wave_settings))
    self.passive_wave_settings.spawn_window_time = var_0;
}

get_passive_spawn_window_time(var_0) {
  if(getdvarint("_encstr_861E16BFAF2DE1F803D91B7097E0C26839551F1FCB982860", 0) != 0)
    return getdvarint("_encstr_861E16BFAF2DE1F803D91B7097E0C26839551F1FCB982860");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.spawn_window_time))
    return self.passive_wave_settings.spawn_window_time;
  else
    return 5;
}

set_passive_wave_spawn_time(var_0) {
  if(isDefined(self.passive_wave_settings))
    self.passive_wave_settings.wave_spawn_time = var_0;
}

get_passive_wave_spawn_time(var_0) {
  if(getdvarint("_encstr_8AC5174BFE5AD19422E38BF7DFAAD010E455736069A4A8415A", -1) != -1)
    return getdvarint("_encstr_8AC5174BFE5AD19422E38BF7DFAAD010E455736069A4A8415A");

  if(isDefined(self.timeout_after_min_count))
    return self.timeout_after_min_count;

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.wave_spawn_time))
    return self.passive_wave_settings.wave_spawn_time;
  else
    return 15;
}

set_ambient_min_count(var_0) {
  if(isDefined(self.passive_wave_settings))
    self.passive_wave_settings.min_count = var_0;
}

get_ambient_min_count(var_0, var_1) {
  if(getdvarint("_encstr_9A6013829E28B7EF23A3F097EDABA0B920EDF8664C", -1) != -1)
    return getdvarint("_encstr_9A6013829E28B7EF23A3F097EDABA0B920EDF8664C");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.min_count))
    return self.passive_wave_settings.min_count;
  else
    return var_1;
}

set_ambient_max_count(var_0) {
  if(isDefined(self.passive_wave_settings))
    self.passive_wave_settings.max_count = var_0;
}

get_ambient_max_count(var_0, var_1) {
  if(getdvarint("_encstr_97571393CF631723761882EF99016B60AFBF05100C", -1) != -1)
    return getdvarint("_encstr_97571393CF631723761882EF99016B60AFBF05100C");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.max_count))
    return self.passive_wave_settings.max_count;
  else
    return var_1;
}

get_spawn_time_from_wave(var_0, var_1) {
  if(isDefined(self.wave_time_between_spawns))
    return self.wave_time_between_spawns;
  else
    return var_1;
}

regenhealthaddfunc(var_0, var_1) {
  if(isDefined(var_0.min_count))
    return int(var_0.min_count);
  else
    return var_1;
}

get_wave_high_threshold(var_0) {
  if(isDefined(var_0.high_threshold))
    return int(var_0.high_threshold);
  else
    return int(var_0.spawn_wave_total);
}

get_current_wave_ref() {
  if(isDefined(level.first_wave_override)) {
    var_0 = level.first_wave_override;
    level.first_wave_override = undefined;
    return var_0;
  } else if(isDefined(self.wave_reference_override)) {
    var_0 = self.wave_reference_override;
    self.wave_reference_override = undefined;
    return var_0;
  } else if(isDefined(self.wave_reference))
    return self.wave_reference;
  else
    return undefined;
}

set_wave_ref_override(var_0) {
  if(trophy_protection_success("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2")) {
    run_func_on_group_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [::battle_tracks_clearbattletracks, var_0]);
    var_1 = get_module_structs_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");

    if(isDefined(var_1) && var_1.size > 0)
      var_1[0] thread scripts\cp\cp_wave_spawning::start_wave();
  } else {
    level.first_wave_override = var_0;
    var_1 = run_spawn_module("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2");
  }

  return var_1;
}

battle_tracks_clearbattletracks(var_0, var_1) {
  level notify("_encstr_A6370DE8B4DA597BAEA3F5EE0BCE59");
  var_0 notify("_encstr_8A2A0BBF610B8F89833BC79BE3");
  var_0 notify("_encstr_971711EEB0B3597DD9EDD7B685B62DAD2CF4AC");
  toggle_force_stop_wave_from_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", undefined, "_encstr_B44C123693E089BFD7A32289EBB51F3A1013BE87");
  toggle_force_stop_wave_from_groupname("_encstr_BA7A12F4162B83AE30BFA020F36AE0DFF3BFEE7E", undefined, "_encstr_B44C123693E089BFD7A32289EBB51F3A1013BE87");
  run_func_on_group_by_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", [::toggle_kamikaze_for_group, undefined]);
  set_wave_settings_for_all_with_groupname("_encstr_A1340ECC2FCBC509A733AF20B02B7DE2", var_1, var_0.wave_reference, var_0.last_wave_num);
  var_0.next_wave = var_1;
  var_0.wave_reference_override = var_1;
}

trophy_protection_success(var_0) {
  return isDefined(level.active_spawn_module_structs[var_0]);
}

clear_wave_ref_override() {
  self.wave_reference_override = undefined;
}

get_wave_max_spawns() {
  if(getdvarint("_encstr_9BB41457069B67B3DE6DBA41CF3288E9AAA302AB7217", 0) != 0)
    return getdvarint("_encstr_9BB41457069B67B3DE6DBA41CF3288E9AAA302AB7217");

  if(isDefined(self.wave_max_spawns))
    return self.wave_max_spawns;
  else
    return undefined;
}

get_module_structs_by_groupname(var_0, var_1) {
  var_2 = [];

  if(!isarray(var_0))
    var_0 = [var_0];

  if(istrue(var_1)) {
    var_3 = getarraykeys(level.spawn_module_structs_memory);
    var_4 = level.spawn_module_structs_memory;
  } else {
    var_3 = getarraykeys(level.active_spawn_module_structs);
    var_4 = level.active_spawn_module_structs;
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_3[var_5]];

    if(isarray(var_6)) {
      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];

        for(var_9 = 0; var_9 < var_0.size; var_9++) {
          if(var_8.group_name == var_0[var_9])
            var_2[var_2.size] = var_8;
        }
      }

      continue;
    }

    for(var_9 = 0; var_9 < var_0.size; var_9++) {
      if(var_6.group_name == var_0[var_9])
        var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

remove_all_aitype_overrides() {
  remove_aitype_spawner_override("_encstr_8219049E744B");
  remove_aitype_spawner_override("_encstr_83B406EB700BCB1F");
  remove_aitype_spawner_override("_encstr_995808C258811FE66019");
  remove_aitype_spawner_override("_encstr_A7F20F7F6744835F7383EF9E453F0175D8");
  remove_aitype_spawner_override("_encstr_816D0C1C9FD16B8F642B11D0A047");
  remove_aitype_spawner_override("_encstr_BE1904DCDA9D");
  remove_aitype_spawner_override("_encstr_B1190448CD80");
  remove_aitype_spawner_override("_encstr_AD07034A38");
  remove_aitype_spawner_override("_encstr_A65B084B38A76BEFC350");
  remove_aitype_spawner_override("_encstr_8BFC0BC2CBD4F737E0A5E1FD79");
  remove_aitype_spawner_override("_encstr_8EF60E63FBE3D70440A312175B98CF6B");
  remove_aitype_spawner_override("_encstr_A11904E483B3");
  remove_aitype_spawner_override("_encstr_9A190463ADB3");
  remove_aitype_spawner_override("_encstr_850707F7E5833355B8");
  remove_aitype_spawner_override("_encstr_8EF60E63FBE3D70440A312175B98CF6B");
  remove_aitype_spawner_override("_encstr_8AD70AE42511BD4079879B40");
}

show_all_player_wave_started_splash() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_85F12426846A777EF13BE081B30471A312AA88AC5E932B26CB7380E08B25A9B7DBD2993FB2CA");

  if(turn_off_steam() || scripts\cp\utility::turn_off_sniper_laser()) {
    level notify("_encstr_B4700EC309BCBBCF1F5BD1DB031A5869");

    if(!isDefined(level.logfriendlyfire))
      level.logfriendlyfire = 1;
    else
      level.logfriendlyfire = level.logfriendlyfire + 1;

    setomnvar("_encstr_B48A0F4E9B69E79ABC4B07CB83E9722DA8", level.logfriendlyfire);
    wait 0.1;

    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      level.players[var_0] thread scripts\cp\cp_hud_message::showsplash("_encstr_AA8B10862AC1DF015EB7E188DB61BB018AD7", level.logfriendlyfire, undefined);
      level.players[var_0] setplayerdata("_encstr_850703B7D9", "_encstr_8D720DB1E3340748613532E3D0F095", "_encstr_838808DBB7E55A5EBB70", level.logfriendlyfire);
      scripts\cp\cp_persistence::update_player_career_highest_wave(level.players[var_0], level.logfriendlyfire, level.players.size);
    }
  }

  wait 2;
}

turn_off_steam() {
  return !istrue(self.disable_wave_hud);
}

set_wave_settings() {
  if(isDefined(level.wave_table))
    var_0 = level.wave_table;
  else if(getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") == "_encstr_B6570B78A33FB39B3317E886AB")
    var_0 = "_encstr_911904535326" + getDvar("_encstr_9A050BF1B1D21107C3D5B601E0") + "_encstr_A6C11037FF878B87E73D4F66726D1AC3F634";
  else
    var_0 = "_encstr_A74B1D73F16ACEDBB0A9DAD2917D9F849197E9EE6341D367C68072DE39D653";

  if(getdvarint("_encstr_B4161308A20A27336FCDAF0CA113795FF3EA18787A", 1) && tableexists(var_0)) {
    var_1 = var_0;
    var_2 = "_encstr_A1340ECC2FCBC509A733AF20B02B7DE2";

    if(isDefined(level.spawn_module_structs_memory[var_2])) {
      for(var_3 = 0; var_3 < level.spawn_module_structs_memory[var_2].size; var_3++) {
        var_4 = level.spawn_module_structs_memory[var_2][var_3];
        var_5 = var_4 get_current_wave_ref();
        var_4.valid_vehicles = [];
        var_4.valid_vehicles["_encstr_93230F29863BDBDB7F7718F03B9AF01BE3"] = int(tablelookup(var_1, 0, var_5, 15));
        var_4.valid_vehicles["_encstr_88520840BAB5F918BF78"] = int(tablelookup(var_1, 0, var_5, 16));
        var_4.valid_vehicles["_encstr_A9100DDA2D37325A161C7D53D59DCE"] = int(tablelookup(var_1, 0, var_5, 17));
        var_4.valid_vehicles["_encstr_A6F90CB2FC09825758B150955870"] = int(tablelookup(var_1, 0, var_5, 19));

        if(scripts\engine\utility::array_sum(var_4.valid_vehicles) > 0)
          var_4.wave_use_vehicles = 1;

        var_4.spawn_aitype_counts = [];
        var_4.spawn_aitype_counts["_encstr_AD07034A38"] = int(tablelookup(var_1, 0, var_5, 1));
        var_4.spawn_aitype_counts["_encstr_823A0903B269F80537CB8A"] = int(tablelookup(var_1, 0, var_5, 2));
        var_4.spawn_aitype_counts["_encstr_82350FC293FA4356C2D9CB7DD858DC2BC9"] = int(tablelookup(var_1, 0, var_5, 3));
        var_4.spawn_aitype_counts["_encstr_BE1904DCDA9D"] = int(tablelookup(var_1, 0, var_5, 4));
        var_4.spawn_aitype_counts["_encstr_B8820A402D5749305DC20B91"] = int(tablelookup(var_1, 0, var_5, 5));
        var_4.spawn_aitype_counts["_encstr_A65B084B38A76BEFC350"] = int(tablelookup(var_1, 0, var_5, 6));
        var_4.spawn_aitype_counts["_encstr_84980E96FB45432F2D8D01C0E57AE08F"] = int(tablelookup(var_1, 0, var_5, 7));
        var_4.spawn_aitype_counts["_encstr_A11904E483B3"] = int(tablelookup(var_1, 0, var_5, 8));
        var_4.spawn_aitype_counts["_encstr_9A190463ADB3"] = int(tablelookup(var_1, 0, var_5, 9));
        var_4.spawn_aitype_counts["_encstr_975F0A8AFB473F790F1F0BF0"] = int(tablelookup(var_1, 0, var_5, 10));
        var_4.spawn_aitype_counts["_encstr_850707F7E5833355B8"] = int(tablelookup(var_1, 0, var_5, 11));
        var_4.spawn_aitype_counts["_encstr_995808C258811FE66019"] = int(tablelookup(var_1, 0, var_5, 12));
        var_4.spawn_aitype_counts["_encstr_8EF60E63FBE3D70440A312175B98CF6B"] = int(tablelookup(var_1, 0, var_5, 13));
        var_4.spawn_aitype_counts["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"] = int(tablelookup(var_1, 0, var_5, 14));
        var_4.spawn_aitype_counts = var_4 remove_invalid_aitypes();
        var_4.wave_difficulty = int(tablelookup(var_1, 0, var_5, 22));
        var_4.high_threshold = int(tablelookup(var_1, 0, var_5, 23));
        var_4.min_count = int(tablelookup(var_1, 0, var_5, 24));
        var_4._id_11E6B = int(tablelookup(var_1, 0, var_5, 25));
        var_4.timeout_after_min_count = int(tablelookup(var_1, 0, var_5, 26));
        var_4.next_wave = tablelookup(var_1, 0, var_5, 29);
        var_4.use_only_veh_spawners = int(tablelookup(var_1, 0, var_5, 32));
        var_4.paratroopers_allowed = int(tablelookup(var_1, 0, var_5, 20));
        var_4._id_1451A = int(tablelookup(var_1, 0, var_5, 21));
        var_6 = float(tablelookup(var_1, 0, var_5, 30));
        var_4.wave_time_between_spawns = scripts\engine\utility::ter_op(var_6 > 0, var_6, 1);

        if(scripts\cp\utility::turn_off_sniper_laser())
          var_4.disable_wave_hud = int(tablelookup(var_1, 0, var_5, 31));
        else
          var_4.disable_wave_hud = 1;

        var_4.spawn_wave_total = scripts\engine\utility::array_sum(var_4.spawn_aitype_counts) + var_4.paratroopers_allowed * 8;
        var_4._id_13BE5 = 0;
        var_4.requested_spawners = [];
        var_7 = strtok(tablelookup(var_1, 0, var_5, 27), "_encstr_964C0249");

        if(isDefined(var_7) && var_7.size > 0) {
          for(var_8 = 0; var_8 < var_7.size; var_8++)
            var_4 add_spawners_to_passive_wave_spawning(var_7[var_8]);
        }

        var_4._id_12C43 = [];
        var_7 = strtok(tablelookup(var_1, 0, var_5, 28), "_encstr_964C0249");

        if(isDefined(var_7) && var_7.size > 0) {
          for(var_8 = 0; var_8 < var_7.size; var_8++)
            var_4 battle_stations(var_7[var_8]);
        }
      }
    }
  }
}

ignoredeathsdoor(var_0, var_1) {
  if(isDefined(level.spawn_module_structs_memory[var_1])) {
    var_2 = level.spawn_module_structs_memory[var_1][0];
    var_0.high_threshold = var_2.high_threshold;
    var_0._id_11E6B = var_2._id_11E6B;
    var_0.min_count = var_2.min_count;
    var_0.disable_wave_hud = var_2.disable_wave_hud;
  } else
    var_0.spawn_wave_total = var_0.totalspawns;
}

pressure_stability_event_init(var_0) {
  var_1 = [];

  if(isDefined(self.script_type) && isDefined(var_0) && isarray(var_0) && var_0.size > 0) {
    if(!isarray(self.script_type)) {
      var_2 = strtok(self.script_type, "_encstr_964C0249");
      self.script_type = [];

      for(var_3 = 0; var_3 < var_2.size; var_3++)
        self.script_type[self.script_type.size] = var_2[var_3];
    }

    for(var_3 = 0; var_3 < self.script_type.size; var_3++) {
      if(scripts\engine\utility::array_contains(var_0, self.script_type[var_3]))
        var_1[var_1.size] = self.script_type[var_3];
    }

    return var_1;
  } else
    return var_0;
}

pressure_stability_event_start() {
  var_0 = [];
  var_1 = getarraykeys(self.valid_vehicles);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self.valid_vehicles[var_1[var_2]] > 0)
      var_0[var_0.size] = var_1[var_2];
  }

  if(var_0.size > 0)
    return var_0;
  else
    return undefined;
}

remove_invalid_aitypes() {
  var_0 = getarraykeys(self.spawn_aitype_counts);

  for(var_1 = 0; var_1 < level.spawn_module_structs_memory[self.group_name].size; var_1++) {
    var_2 = level.spawn_module_structs_memory[self.group_name][var_1];

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(isDefined(var_2.spawn_aitype_counts[var_4]) && var_2.spawn_aitype_counts[var_4] < 1)
        var_2.spawn_aitype_counts[var_4] = undefined;
    }
  }

  return self.spawn_aitype_counts;
}