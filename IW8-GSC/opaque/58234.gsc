/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58234.gsc
***********************************************/

bot_gulag_think() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068", 1);
  var_0.destroycallback = ::bot_get_stored_custom_classes;
  var_0._id_13E92 = "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC";
  level.pindia_headlights = getdvarint("_encstr_8DBE18E66C27BECC46FAB9A35827D1AF969BD7E83459F52CB49C", 0);
  level.picking_up_minigun = getdvarfloat("_encstr_91392388662377DE4279A7BB6537C99DC75362C872EFE0296B7BB013FE59C59343B3570B88", 0.1);
  level.picked_up_weapon = getdvarint("_encstr_A1721423792E67872397555683584DF7C0137A7A8186", 1);
  level.pilot_model = getdvarint("_encstr_865118A33FF017E5C8718B12FA0B08FFF02E105A887012BC725D", 35);
  level.pilot_setups = getdvarint("_encstr_8FED187B98AA0FF05C970F878DB77B597020F6A6397BB0051047", 15000);
  level.ph_checkforovertime = getdvarint("_encstr_A2BD1FB9C639AFCC19D7588C3296D12DB79B2C36F56C7B733A9CC2D236D79DCCC3", 1);
  level.pickuptrigger = getdvarint("_encstr_8F89209BD8E4AF338CEBEE5ACD76D7D8BDDC8E93855A1B6EEBADA5E6F56E38B2B246", 65);
  level.pickup_truck_initomnvars = getdvarint("_encstr_9A5B2162318D991AD2C99871784373B9BEE73DC573C89915C3EFD9D375C9D3B16A311C", 100);
  level.pickupchecks = getdvarint("_encstr_99022073C652D9146A4FF5838713F070171D1BEBEEA1B856F1AFE3951F4BAF98B5F7", 90);
  level.pilot_anim_loop = getdvarint("_encstr_A6461CE6C69CEBCC237DB7BDC4FAF69DB22793A5912BD76E59C6DBE68CCD", 40);
  level.phfrozen = getdvarint("_encstr_A69F206B46DACF179B6FC6174B1940B223F093299A2B27AAA3295EE82D745B3A2990", 0);
  level.pickprematchrandomloadout = getdvarint("_encstr_B1E712DCB1C9AF668CEB1AD22356BE1CB463DB1D", 0);
  level.pickedupcoreminigun = getdvarint("_encstr_88A1239BC64E7D338CEBB30BB97D4658AD857695D738630BE59539E6F5165A4E836358E656", 3);
  level.pick_up_data = getdvarfloat("_encstr_88D925584FB25675F27995288B796DD904E75070FB61EE3FFB1D15A0679195C04F63D8D81717E1", 0.15);
  level.pick_from_preset_solutions = getdvarfloat("_encstr_9BCE299B364EAF9946BEC8B7A3D79DAC63B7D8D2A3E5EBEC39B7EADC46F536D2E8E8632BF54685D6857659", 0.85);
  level._encstr_8AD61B27A7363CE8F880EBC8394BB0694A5AE41AE5D1BD75C1918EDFA0 = getdvarint("_encstr_8CC21F9BB19CBE998CFA5AD99BDBC956262CB99196B9EC74592C4E220BADB0B3AC", 0);
  level._encstr_8FE21B92D04F727F6965BBB5F1910BBF4BF80A1A708BAAB3214181AF1D = getdvarint("_encstr_87D11FCD8DE4FA668CEB9CB223EA36CA26B0E6232DDC9DE8CA16C9220BDA0BB395", 1);
  level._encstr_8FCE209932EB46B7D1D99536DBB1D2D1E57627DE5DDC46630B37195AE6ECCEB2C293 = getdvarfloat("_encstr_8DF1282037CA5E7DEA71AD20937195C10CEF5878F3691627F3651DB86FA99909667B80D81737A9EBEA4A", 0.25);
  level._encstr_B4F82109DF97A07B3217012367BA34184333D0035E16F8AEEA7F311D9FE28840118B9A = getdvarfloat("_encstr_9AB629B936E47D99C8FAADD273D737E095B223BE330B1B8EDE27F5CCDB4EEBC8BDD1F5B3B263B7C6B48EE5", 0.2);
  level.pit_locations = getdvarint("_encstr_8CED253FBB4A29FC5B3173196A1F26C06309DF9F32F5B03063294880D3AB6968F16C2B13C95F48", 2);
  level.phase_three_combat = getdvarint("_encstr_96701377A0F39FA201608E83DD2F097C39B0AFD7F0", 1);
  level.phase_zero_combat = getdvarfloat("_encstr_AC0628573F931888A411E17BC38709C51AD3E7F39BA9DDF0F93648712167607DE2FF63092FF190381CC8", 0);
  level.phclass = getdvarfloat("_encstr_85C5203B629BE0785F1FFBDB5CC5E93D7FCB3161FBD7AEA8F72A8BCF7821780B17D2", 0.1);
  level.phase_two_combat = getdvarfloat("_encstr_8BF119436895B9F3E9F039257DD04F3BDB988ABA7877EE1B614105", 2.25);
  level.phaseindex = getdvarfloat("_encstr_ADA7199BC639FA6646EBC2BA1DB7D7D158C9CECAD1BE27C29B7695", 12000);
  level.pingedenemies = getdvarfloat("_encstr_86BB159BAA021F693BEF8509AFAF7037EFF1A0B8C1DF91", 5);
  level.ping_response_time = getdvarfloat("_encstr_ABBB15B98D27EB6619F58C5B3BF56BB723F5CECDF589A3", 3.75);
  level.pistolslide = getdvarfloat("_encstr_865B1B3B10EDD19B715894856C3E7F657959F3B3898D179B08BE94857E", 5);
  level.pindia_vehicle_registration = getdvarfloat("_encstr_A5BB15120E23DF0F52F7CC581F0F490D218F4B108117F1", 10);
  level.pipe_room_dogtag_revive = getdvarfloat("_encstr_A38619932672F9344A6FD1FBB7C189303CB1BBEB41F8D87F736FF5", 0.475);
  level.phone_group_spawned = getdvarfloat("_encstr_A7011F03FE7D57B342A9BAA8B0777A1D510421ABFA443F8510BC5FCA45A9336C3F", 0.5);
  level.phonehint = getdvarfloat("_encstr_A971209B2E8A01CC4277D9C3BFD981E83C43407395C998FE2933EDFFFB0259E8CD5A", 1.5);
  level.phone_group_spawned_timeout = getdvarfloat("_encstr_96C123C3E81539736970BCBD745607FB4128EA6B389B6FEBE6C181A69DB8C387FF1852F250", 0.0);
  level.phone = getdvarfloat("_encstr_88C82137B193FA3319D7C86B767DAD5D1BA35A1CC6D2B2C9EB91932DB395931BCA37DC", 10.0);
  level.phoneisringing = getdvarfloat("_encstr_9B5E2216768B1769C4E7B0E01F27E1A3821E8495C1032353AB136120CB2299FF7A0589AD", 40.0);
  level.phoneplayring = getdvarfloat("_encstr_AF4B219B1B9CBE99467D8C6B9DAF190BB5C276ACD793BD1B8DD73A864EACDC0D7BC691", 45.0);
  level.phoneisnotringing = getdvarfloat("_encstr_AD8E1FBBBAC061D6AD37AA50B73FC781632FC8E799E9F1D506834FDCFAA6D53FD0", 2.0);
  level.phonemorsesinglescriptableused = getdvarfloat("_encstr_BE3B1E6E1B27AF338CD732D63BF58C2CDA0BEC95AF9CDB8DC6F5CC856CA3DBE4", 2.0);
  level.phonesfx = getdvarfloat("_encstr_97D225A791FAE0AE57294970AF194F9E8D071F370F5BD77B30591789B2174C9320D87BB38BAF0A", 20.0);
  level.phcountdowntimer = getdvarfloat("_encstr_88641A7B50AD91DBB1985445ACFE83A315902182C84F1507EBFB5545", 4);
  level.pickclassbr = getdvarint("_encstr_B4E919331262F7CF391E1BA806D8A1B71117D9ABB0CB9B2920553B", 0);
  level.pickedpball = getdvarint("_encstr_B8541F3E5EA33FB11C0F58189333E987CA4735CCB48A1139FF2B3860E377802F92", 1);
  level.pickup_truck_initdamage = getdvarint("_encstr_A61F1C4F98CBD7EA5938C6FC967FE3B1114887BF10221F42B1494D737529", 30);
  level.ph_setfinalkillcamwinner = getdvarfloat("_encstr_86291863EE5BE75B7AF140585209DB4FE40B99DBCD2F90617342", 0);
  level.ph_endgame = getdvarfloat("_encstr_993415BFD77BF0500CB959501AF30817D2136F091703A5", 1.0);
  level.phase_five_combat = getdvarint("_encstr_88FA29725F831943890F0F5A6643EB0BE51BE7F2A748ABA3DB3AD06F91AB47A3A30A92B457D6010BF83BD2", 4);
  level.ph_loadouts = getdvarint("_encstr_8C3029B96CE4D79946AF85B4E46C3958333ABE332C6E1DD7B1BDE6A3E42C2DD8E6D7B52D73EB85CD76B195", 55);
  level.phase_four_combat = getdvarint("_encstr_8DA822CAB933980C5B5707823518434B4AE38638B8E59129F70904AFBDD17978C26F2C87", 1);
  level.pickup_timeout = getdvarint("_encstr_978E291B30CDF1BB91B87161C69923861D604162E85DB7CF0B806E65D3E03F8DB3A16A9B78016D5F40F04E", 0);
  level.pickrandomspawn = getdvarint("_encstr_8ED826878295B7BD5931F1F01BDA169BE0CBEF605778E7F5C549BA85E1FA31477DC1931C7B430726", 1);
  level.pistolweapon = getdvarint("_encstr_B2E820B0A75ACEED5AC135BD62D323538F7F08D007F2868B73F9A74B7ACB69B916CF", 0);
  level.pilot_linkto_origin_offset = getdvarint("_encstr_AD4E2260D6C2CF1779E168FFE893BB082101CA3F4307D03AC9A7F3B877D90B295B1FFF2B", 1);
  level._encstr_82771863D8166412D3BFCF4715FB1A27FB10FF173088D59A3B4E = getdvarint("_encstr_BD301FCD3639FA3346BE91C2B516B359F58C5926DED5CDC6B2F51D4BDA56BEB6DC", 500);
  level._encstr_834E1EF422A96C39BD077232D1D89E5507C8916AFB208D81D7D488BDC9B95651 = getdvarfloat("_encstr_BDBB253736C9F5CC467D8C58AD2CB32BFA8C9589DBABDC1BCAEB3A0D27ACDC86DBD819BE071B3A", 0.3);
  level.pickup_sound_playerwm_handler = getdvarfloat("_encstr_B8812240AE03493EDD2177852F8B2D33A287718A6C11C50C189D533848ED050F927F585B", 4.5);
  level.pickup_sound_playervm_handler = getdvarfloat("_encstr_860B21E7636201C46319C870D31F8928FFC741A30F81E01BD35283D84A13B5911559D9", 0.9);
  level.pickup_sound_hvt_handler = getdvarfloat("_encstr_860B21E7636201C46319C870D31F8928FFC741A30F81E01BD35283D84A13B591555FFF", 0.3);
  level.pickrandomvehiclespawn = getdvarfloat("_encstr_AAC31E36685BC143ECEE5BCDFBFBB4E24DFFF70A12A1A77FB82508BA09E3A023", 0.05);
  level.pickup_saw_and_start_mission = getdvarfloat("_encstr_83BF223BF60B3FA7F1C9BAF298FB1D374170B4AD1C76132EA7E8C23BF93394237E41374F", 0.2);
  level.pickup_gasmask = getdvarfloat("_encstr_8DBD23E66C27BECC46FAB46B1C57B1B956D719DAB3D7662CB11DDB9CEBAD2DC8AF0D96D986", 0.75);
  bot_is_capturing_hq_zone();
  bot_hq_start();
  bot_is_capturing_zone();
  bot_has_streak_in_crate();
  bot_has_player_enemy();
  bot_hp_allow_predictive_capping();
  bot_gun_pick_personality_from_weapon();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BDC80A5437EAD749519A6068", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_88C5055208731B")]]();

  bot_is_in_gas();
  bot_hq_think();
}

bot_hq_think() {
  thread _id_1327D();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BDC80A5437EAD749519A6068", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_BAF609D2739647C4853A2B")]]();
}

bot_is_capturing_hq_zone() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068", 1);
  var_0.enterstartcallback = ::bot_get_low_on_all_ammo;
  var_0.enterendcallback = ::bot_get_human_picked_class;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::bot_get_num_teammates_capturing_zone;
  var_0.reentercallback = ::bot_parachute_into_map;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 0;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 255;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 150;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 150;
  var_0.exitextents["_encstr_AC190479FF92"] = 10;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 50;
  var_0.allowairexit = 1;
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-150, 150, -45);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-150, -150, -45);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-255, 0, -45);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (30, 0, -45);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_AB0A0B99C9DBB98EAFC69533E8";
  var_0.exitoffsets[var_1] = (90, 35, 45);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-90, 35, 45);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_A266062032BD7723", "_encstr_8D48079DD59BE65627"];
  var_3 = "_encstr_A266062032BD7723";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_BDC80A5437EAD749519A6068", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B69B0589C236B6"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D8();
  var_4._id_13E8A = getcompleteweaponname("_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC");
  var_4._id_13E92 = "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC";
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4._id_12023 = "_encstr_A930138F411DE927482F9958FB8D52C7D8D0A078CB";
  var_3 = "_encstr_8D48079DD59BE65627";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_BDC80A5437EAD749519A6068", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B69B0589C236B6"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_4._id_145E0 = getdvarint("_encstr_A5B31E8A39C00F2A75FFFBB7CFA64266C041421953D0EA425DE797EBAFCE8AA6", 0);
  var_4._id_1409C = getdvarint("_encstr_A301204F278BAF80DC69CBE10A93C0C07287C58F9763D581E4FE513EB66618090AB7", 1);
}

bot_hq_start() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_BDC80A5437EAD749519A6068", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_A266062032BD7723", "_encstr_8D48079DD59BE65627"]);
}

bot_is_capturing_zone() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_BDC80A5437EAD749519A6068", 1);
  var_0.id = 19;
  var_0.seatids["_encstr_A266062032BD7723"] = 0;
  var_0.seatids["_encstr_8D48079DD59BE65627"] = 1;
  var_0._id_12DA2[0] = 0;
  var_0._id_12DA2[1] = 1;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC"] = 0;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC"] = 1;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC"] = 0;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC"] = 1;
}

bot_has_streak_in_crate() {
  level.br_pe_chopper_crates = getdvarfloat("_encstr_B1E0179B6C39BE6623AFA1CAB0D83A86D7DE6759E4934B2356", 1500);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_BDC80A5437EAD749519A6068", level.br_pe_chopper_crates, undefined, undefined, undefined, level.phcountdowntimer);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068");
  var_0.class = "_encstr_B846067B175AA56A";
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_BDC80A5437EAD749519A6068", "_encstr_8FA906CC80677438");
  var_1._id_12024 = ::bot_loadout_choose_from_custom_default_class;
  var_1._id_1202D = ::bot_modify_behavior_from_loadout;
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_BDC80A5437EAD749519A6068", "_encstr_AB5E07609A5B7368E5");
  var_1._id_12024 = ::bot_loadout_team;
  var_1._id_1202D = ::bot_modify_behavior_from_tweakables;
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_BDC80A5437EAD749519A6068", "_encstr_B846067B175AA56A");
  var_1._id_12024 = ::bot_loadout;
  var_1._id_1202D = ::bot_match_rules_invalidate_loadout;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_BDC80A5437EAD749519A6068");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_BDC80A5437EAD749519A6068", 10);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14175("_encstr_BDC80A5437EAD749519A6068", ::bot_nags);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_BDC80A5437EAD749519A6068", ::bot_get_active_tactical_goals_of_type);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC", 5);
}

bot_has_player_enemy() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_BDC80A5437EAD749519A6068", 1);
  var_0.challengeevaluator = 2;
  var_0.keycardlocs_chosen = 0.75;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 5;
  var_0.isallowedweapon = 20;
  var_0.isakimbo = 40;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

bot_hp_allow_predictive_capping() {
  level._effect["_encstr_A7501181F4C2A88EAA5B216F4F63D798670F89"] = loadfx("_encstr_8CCB36BE24194E0454E847A2ABF7981B33BF80A3A6B3A2686FFBB94B3F1B338E7912AE63E65BF187EB23F8B2F51E3908F70F6AFF1D7B32F9");
  level._effect["_encstr_AA5615F3DC183886E7CAA3F1BA0B9BD98FA91D40BF1268"] = loadfx("_encstr_8E313D68D8BBD0B99F32AF1ABA2F0F1F016925CC782C8F6AAA1BAFD0674ADAFE1005D1EB2DE9E28377A3316301EB833309C52B882729BEAD9BA8A3C67696E9");
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");

bot_gun_pick_personality_from_weapon() {
  level.scr_anim["_encstr_A64D09017442280E2ADBA1"]["_encstr_A517086A8F6B5A9F6B48"] = % _encstr_BE0C24DFAB1B902838999BF17C2F583752636103AFE3CE70506FC0E827EA4976EBAFF5F7BF8B;
  level.scr_anim["_encstr_A64D09017442280E2ADBA1"]["_encstr_B8120A535FC8923E79782FC5"] = % _encstr_BE0B2622CDE5F16503E9C3B768DE245A815F6CDE38499BBFEBD0A39B681327A3517B75D91D8F03F6;
}

bot_give_weapon() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068");
  var_1 = var_0._id_13E92;
  return var_1;
}

bot_gametype_set_role(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_821619CEAC0DAFCD1AD7ADB4B1F5582D9CFA9185D8E034B0F5EE9E";
  var_0.targetname = "_encstr_BDC80A5437EAD749519A6068";

  if(!isDefined(var_0.vehicletype))
    var_0.vehicletype = "_encstr_85100F7376B718BBA15A43D8058F09CC4A";

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  var_3 = bot_give_weapon();
  var_4 = bot_get_teammates_capturing_zone();
  var_5 = bot_gametype_zones_precached(var_2, var_3, "_encstr_8849273B59D0BECD867D5BD263F585D2C9AF4616D8C143C2F5BBE9D7D1EAC9932BA37D581D1DB0C634", var_4.tag, var_4.tagoffset);
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_5, getcompleteweaponname(var_3));
  var_2._id_13E92 = var_3;

  if(level.pistolweapon)
    var_5 setentityowner(var_2);

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_BDC80A5437EAD749519A6068", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC");
  var_2.shouldmodeplayfinalmoments = 0;
  var_2._id_120B4 = level.pilot_anim_loop;
  var_2._id_13E83 = "_encstr_A14F0AE336178944BA076F41";
  var_2 thread botisonplayerteam();
  var_2 thread botloadoutfavoritecamosecondary();
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BDC80A5437EAD749519A6068", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_8AEA073693CA16D12B")]](var_2);

  if(getdvarfloat("_encstr_92061F63BE43779EE50192AA193FD2475B90C8FAC0EBC7E6C1580A026963CDEF13", 0) > 0)
    var_2._id_13A32 = gettime() + getdvarfloat("_encstr_92061F63BE43779EE50192AA193FD2475B90C8FAC0EBC7E6C1580A026963CDEF13", 0) * 1000;

  var_2 thread helis_assault3_hangar_check_size();
  var_2 thread br_tacmap_icon();

  if(level.pickedpball)
    var_2 unmarkkeyframedmover(1);

  return var_2;
}

helis_assault3_hangar_check_size() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 vehphys_enablecollisioncallback(1);

  if(getdvarint("_encstr_A65615E6D84EFAC493EBCC91BE2D37B32DE61BD24C3656", 0)) {
    return;
  }
  wait 5;
  var_1 = [];
  var_2 = [];

  for(;;) {
    var_0 waittill("_encstr_93510A16C71B20636A2AB8B8", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isDefined(var_10) && isDefined(var_10.helperdronetype) && var_10.helperdronetype == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC") {
      continue;
    }
    if(istrue(level.phfrozen) && !istrue(var_0.shouldmodeplayfinalmoments)) {
      continue;
    }
    var_12 = 0;

    if(istrue(level.pickrandomspawn))
      var_12 = isDefined(var_10) && var_10 == var_0;

    if(isDefined(var_10.model) && !var_12) {
      if(var_10 _calloutmarkerping_handleluinotify_mappingdeletemarker::unset_bullet_shields()) {
        var_10 _calloutmarkerping_handleluinotify_mappingdeletemarker::createteamdefenderflagbase();

        if(isDefined(var_0))
          var_0 bot_should_cap_next_zone(9000, var_10, var_7);

        continue;
      }

      if(istrue(var_0.shouldmodeplayfinalmoments) && (var_10 unreachable_function() || var_10 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr())) {
        if(isDefined(var_10.owner) && isDefined(var_0.owner) && var_10.owner.team != var_0.owner.team) {
          var_13 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

          foreach(var_15 in var_13)
          var_15 dodamage(20, var_0.origin, var_10.owner, var_15, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC");

          var_17 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_10);

          foreach(var_15 in var_17)
          var_15 dodamage(20, var_0.origin, var_0.owner, var_15, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC");
        }

        var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);
        var_0 dodamage(9000, var_7, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
        var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
        var_10 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);
        var_10 dodamage(9000, var_7, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
        var_10 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
        continue;
      }
    }

    var_20 = 1.0;
    var_21 = 0;
    var_22 = 0;

    switch (var_11) {
      case 0:
        var_20 = level.phone_group_spawned;
        break;
      case 1:
        var_20 = level.phonehint;
        var_21 = 1;
        break;
      case 2:
        var_22 = 1;
        break;
      default:
        break;
    }

    if(var_21)
      var_23 = var_20;
    else
      var_23 = var_9 * var_20;

    if(istrue(level.phase_four_combat)) {
      var_24 = length(var_0 vehicle_getvelocity() - var_0.br_toggle_armor_allows);
      var_23 = var_23 * (var_24 / 17.6);
    }

    if(abs(angleclamp180(var_0.angles[0]) > level.phoneisringing))
      var_23 = var_23 * level.phoneisnotringing;

    if(abs(var_0.angles[2]) > level.phoneplayring)
      var_23 = var_23 * level.phonemorsesinglescriptableused;

    if(var_0.angles[2] > 90 || var_0.angles[2] < -90)
      var_23 = var_23 * level.phonesfx;

    var_25 = 0;

    if(var_23 > level.pickup_sound_playerwm_handler)
      var_25 = var_0.maxhealth;
    else if(var_23 > level.pickup_sound_playervm_handler) {
      var_26 = level.pickup_sound_playerwm_handler - level.pickup_sound_playervm_handler;
      var_27 = (var_23 - level.pickup_sound_playervm_handler) / var_26;
      var_28 = var_0.maxhealth * level.pickup_saw_and_start_mission;
      var_29 = var_0.maxhealth * level.pickup_gasmask;
      var_25 = scripts\engine\math::lerp(var_28, var_29, var_27);
    } else if(var_23 > level.pickup_sound_hvt_handler)
      var_25 = var_0.maxhealth * level.pickrandomvehiclespawn;

    var_30 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_0);

    if(!isDefined(var_30))
      var_25 = var_25 * level.phone;

    var_31 = -1;

    if(var_11 != 1) {
      var_31 = abs(vectordot(var_8, vectorNormalize(var_0.br_toggle_armor_allows)));
      var_32 = 1;

      if(var_22 && var_9 < level._encstr_B4F82109DF97A07B3217012367BA34184333D0035E16F8AEEA7F311D9FE28840118B9A)
        var_32 = 0;

      if(var_32) {
        if(var_31 > level.pick_from_preset_solutions)
          var_25 = var_25 + (var_0.maxhealth * 0.25 + randomintrange(50, 100));
        else if(var_31 > level.pick_up_data)
          var_25 = var_25 * level.pit_locations;
      }
    } else
      var_25 = var_25 + 550;

    if(isDefined(var_1[var_11]) && var_1[var_11] > gettime()) {
      if(var_25 < var_2[var_11])
        continue;
    }

    if(var_22 && var_25 > 0) {
      if(level._encstr_8AD61B27A7363CE8F880EBC8394BB0694A5AE41AE5D1BD75C1918EDFA0) {
        continue;
      }
      if(level._encstr_8FE21B92D04F727F6965BBB5F1910BBF4BF80A1A708BAAB3214181AF1D && var_31 <= level._encstr_8FCE209932EB46B7D1D99536DBB1D2D1E57627DE5DDC46630B37195AE6ECCEB2C293)
        continue;
    }

    if(var_25 > 0) {
      var_0 bot_should_cap_next_zone(var_25, var_10, var_7);
      var_1[var_11] = gettime() + level._encstr_82771863D8166412D3BFCF4715FB1A27FB10FF173088D59A3B4E;
      var_2[var_11] = min(var_25 * level._encstr_834E1EF422A96C39BD077232D1D89E5507C8916AFB208D81D7D488BDC9B95651, var_0.maxhealth);
    }
  }
}

br_tacmap_icon() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.br_toggle_armor_allows = 0;

  for(;;) {
    waittillframeend;
    var_0.br_toggle_armor_allows = var_0 vehicle_getvelocity();
    waitframe();
  }
}

bot_should_cap_next_zone(var_0, var_1, var_2) {
  var_3 = self;

  if(var_0 > 650)
    var_3 br_pickupdenyweaponpickupap("_encstr_B6F41B9BDEE3870F10E09BCAC8C1A66A832778C7891240510AFF590151", "_encstr_87C416E457B513D82BD79923BEB1BDB11BF58C0BDA58ECCA");

  var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);

  if(var_3.health - var_0 <= 0) {
    if(!istrue(var_3.should_play_player_infil) && (var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0" || var_1 == var_3))
      br_mapboundsfull();
    else {
      var_3 dodamage(var_0, var_2, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
      var_3 radiusdamage(var_3.origin, 250, 200, 80, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC");
      var_3.brlootchoppercrateactivatecallback = 1;
      var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
      return;
    }
  }

  var_3 dodamage(var_0, var_2, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
  var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
}

br_mapboundsfull() {
  var_0 = self;
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  foreach(var_3 in var_1) {
    var_3.donotmodifydamage = 1;
    var_3 dodamage(99, var_0.origin, var_3, var_3, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9", "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC");
    var_3.donotmodifydamage = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);

  foreach(var_6 in var_1)
  var_6.plotarmor = 1;

  var_0 radiusdamage(var_0.origin, 250, 200, 80, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC");
  var_0.brlootchoppercrateactivatecallback = 1;

  foreach(var_6 in var_1)
  var_6.plotarmor = 0;
}

bot_get_teammates_capturing_zone() {
  var_0 = spawnStruct();

  if(getdvarint("_encstr_92D01CD1380888ABB735D1C770838B2A5DD93EE3D6F117A74EEF4A0FEBB7", 0) == 1) {
    var_0.tag = "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118";
    var_0.tagoffset = (58.87, 0, 60.052);
  } else {
    var_0.tag = "_encstr_99FE0B2B19086F6B9DC5D387E1";
    var_0.tagoffset = (0, 0, 0);
  }

  return var_0;
}

bot_gametype_zones_precached(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin(var_3), var_1, 0);
  var_5 unmarkkeyframedmover(1);
  var_5 linkTo(var_0, var_3, var_4, (-1, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("_encstr_BA7D0EF916AAA3692C479020EB7FA1E9");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  var_5.maxhealth = 999999;
  var_5.health = var_5.maxhealth;
  return var_5;
}

bot_get_stored_custom_classes(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  if(isDefined(self.owner))
    self.owner.br_pe_chopper_damage_time = var_0.meansofdeath;

  self notify("_encstr_8B1A098BD8E134029B657C");

  if(istrue(level.pickup_timeout))
    wait 0.2;

  if(!isDefined(self)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  self setscriptablepartstate("_encstr_840703F23B", "_encstr_A29B05E9400E5D");
  self setscriptablepartstate("_encstr_AB700F3F0938439D5922C08309B04E104D", "_encstr_A29B05E9400E5D");
  self setscriptablepartstate("_encstr_82990E9BDE28FB5EE80F95F893E3A8D8", "_encstr_A29B05E9400E5D");
  self setscriptablepartstate("_encstr_BEA50D188B572DF572C9AEB9DD4A3B", "_encstr_A29B05E9400E5D", 0);

  if(isDefined(self.isballisticspecial)) {
    foreach(var_3 in self.isballisticspecial)
    self setscriptablepartstate(var_3, "_encstr_BA19049F4B2D");
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread bot_get_angles_to_goal();
  var_5 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(!istrue(self.brlootchoppercrateactivatecallback))
    self radiusdamage(self.origin, 250, 200, 80, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC");

  var_6 = scripts\engine\utility::ter_op(self.shouldmodeplayfinalmoments, "_encstr_A7501181F4C2A88EAA5B216F4F63D798670F89", "_encstr_AA5615F3DC183886E7CAA3F1BA0B9BD98FA91D40BF1268");
  playFX(scripts\engine\utility::getfx(var_6), var_5, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(var_5, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
  earthquake(0.4, 800, var_5, 0.7);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_5);
  physicsexplosionsphere(var_5, 500, 200, 1);
}

botloadoutfavoritecamosecondary() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  wait 2;
  var_1 = 1;
  var_2 = [var_0];

  for(;;) {
    var_3 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_4 = var_0.origin + anglestoup(var_0.angles) * -600;
    var_5 = scripts\engine\trace::ray_trace(var_0.origin, var_4, var_2, var_3, 0);

    if(isDefined(var_5)) {
      if(var_1 && var_5["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        var_0 setscriptablepartstate("_encstr_A1A80DA123D68258283949F70D4F53", "_encstr_BEE608BF50D84BAA9DF4", 0);
        var_1 = 0;
      } else if(!var_1 && var_5["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        var_0 setscriptablepartstate("_encstr_A1A80DA123D68258283949F70D4F53", "_encstr_93CF08C7684F60BBB372", 0);
        var_1 = 1;
      }
    }

    wait 0.3;
  }
}

botisonplayerteam() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.br_alt_mode_inflation = 0;
  var_0.should_play_player_infil = 0;
  var_1 = [var_0];

  for(;;) {
    if(!_encstr_8BE608031FD3E1D08EBF(var_0)) {
      _encstr_81F90F6EDFA05ECB3939FA72810E8B95C8(var_0);
      return;
    }

    var_2 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_0.origin - (0, 0, 150), var_1, var_2, 0);

    if(isDefined(var_3)) {
      if(var_3["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        var_0.shouldmodeplayfinalmoments = 1;
        var_0.should_play_player_infil = 1;
        var_0 setscriptablepartstate("_encstr_BDDC07EBCCB5CA4BED", "_encstr_AD4513AE081843B6CBEDC71BFB1566FBC099C9974D");
      } else if(istrue(var_0.shouldmodeplayfinalmoments)) {
        var_0 br_pickupdenyweaponpickupap("_encstr_99EC14139F635BE5B0C6A922603B51E081D741B76565", "_encstr_A21B0F27AEAD1363CABE6632FA8DC2CDC8");
        var_0.shouldmodeplayfinalmoments = 0;
        var_0 setscriptablepartstate("_encstr_BDDC07EBCCB5CA4BED", "_encstr_962F0CB3560DD236D8CAD7576E59");
      }

      if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_8EFB1313B8EDD74428B5173A43A8836B1B51BA8AA3")]]())
        var_0 dodamage(10000, var_0.origin, undefined, undefined);
    }

    var_4 = var_0 register_sequence_4_objectives();

    if(var_0.br_alt_mode_inflation != var_4 && isDefined(var_0.owner)) {
      var_0.br_alt_mode_inflation = var_4;
      var_0.owner bots_with_player_enemy(1);
    }

    wait 0.2;
  }
}

bot_get_angles_to_goal() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BDC80A5437EAD749519A6068", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

bot_nags(var_0) {
  if(isDefined(var_0.damage) && var_0.damage > 0)
    self notify("_encstr_B2310D943398AE674DEE4B0270958B", var_0);

  return 1;
}

bot_get_active_tactical_goals_of_type(var_0) {
  thread bot_get_stored_custom_classes(var_0);
  return 1;
}

bot_on_player_death() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8A49121C93F61CACB1C6CA93AFB9E09673AFBAE0");
  var_0 notify("_encstr_9706140E397B0E2B8D1B56E4BEE6835ADCD719DBBBB9");

  if(istrue(var_0._id_128E9)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_8F9D0AF3602FF27F68E9BDA2", "_encstr_A517086A8F6B5A9F6B48", 0);
  var_0._id_128E9 = 1;
  wait(getanimlength(level.scr_anim["_encstr_A64D09017442280E2ADBA1"]["_encstr_A517086A8F6B5A9F6B48"]));

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_8F9D0AF3602FF27F68E9BDA2", "_encstr_A7C5056BD931D1", 0);
}

bot_next_difficulty_type_index() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_9706140E397B0E2B8D1B56E4BEE6835ADCD719DBBBB9");
  var_0 notify("_encstr_8A49121C93F61CACB1C6CA93AFB9E09673AFBAE0");

  if(!isDefined(var_0._id_128E9)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_8F9D0AF3602FF27F68E9BDA2", "_encstr_B8120A535FC8923E79782FC5", 0);
  var_0._id_128E9 = undefined;
  wait(getanimlength(level.scr_anim["_encstr_A64D09017442280E2ADBA1"]["_encstr_B8120A535FC8923E79782FC5"]));

  if(!isDefined(var_0)) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_8F9D0AF3602FF27F68E9BDA2", "_encstr_8F120D4B0B5A2D59C6755ED3DAB9A8", 0);
}

bot_get_distance_to_goal(var_0) {
  var_1 = self;

  if(!isDefined(var_1.isballisticspecial))
    var_1.isballisticspecial = [];

  if(!scripts\engine\utility::array_contains(var_1.isballisticspecial, "_encstr_878611380AC7898EB71940CCD703B173EEB2F8") && randomfloat(1.0) < 0.4)
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "_encstr_878611380AC7898EB71940CCD703B173EEB2F8";

  if(!scripts\engine\utility::array_contains(var_1.isballisticspecial, "_encstr_932E122B7B6238C379BF633D4FB1F3AF6D0AE07D") && randomfloat(1.0) < 0.4)
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "_encstr_932E122B7B6238C379BF633D4FB1F3AF6D0AE07D";

  if(var_0 && !scripts\engine\utility::array_contains(var_1.isballisticspecial, "_encstr_81BF0C5D09CFE0CF6F6AE880E2C7") && randomfloat(1.0) < 0.5)
    var_1.isballisticspecial[var_1.isballisticspecial.size] = "_encstr_81BF0C5D09CFE0CF6F6AE880E2C7";
}

bot_nag(var_0) {
  var_1 = self;

  foreach(var_3 in var_1.isballisticspecial)
  var_1 setscriptablepartstate(var_3, var_0, 0);
}

bot_loadout_choose_from_custom_default_class(var_0, var_1) {
  var_2 = self;
  var_2 bot_get_distance_to_goal(0);
  var_2 bot_nag("_encstr_8FA906CC80677438");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_14165(var_0, var_1);
}

bot_modify_behavior_from_loadout(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_1416A(var_0, var_1);
}

bot_loadout_team(var_0, var_1) {
  var_2 = self;
  var_2 bot_get_distance_to_goal(1);
  var_2 bot_nag("_encstr_AB5E07609A5B7368E5");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_14167(var_0, var_1);
}

bot_modify_behavior_from_tweakables(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_1416B(var_0, var_1);
}

bot_loadout(var_0, var_1) {
  var_2 = self;
  var_2 bot_get_distance_to_goal(1);
  var_2 bot_nag("_encstr_B846067B175AA56A");
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_14163(var_0, var_1);
}

bot_match_rules_invalidate_loadout(var_0, var_1) {
  var_2 = self;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_14169(var_0, var_1);
}

_id_1327D() {
  level.bot_set_zone_nodes = spawnStruct();
  level.bot_set_zone_nodes.powers = [];
  bhadriotshield(level.bot_set_zone_nodes, "_encstr_8C350C382DD8DB1D76BAB937CA4E", "_encstr_A9E60828803C73F11780", ::botstopmovingonlaststand);
}

_id_14231(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommand(var_6, var_4);
  }
}

_id_14230(var_0) {
  if(!isDefined(self) || isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommandremove(var_6, var_4);
  }
}

bhadriotshield(var_0, var_1, var_2, var_3) {
  if(isstring(var_2))
    var_2 = [var_2];

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
}

botstopmovingonlaststand(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.vehicle)) {
    return;
  }
  var_2.vehicle.turret.turreton = 1;
  var_2.vehicle.turret setmode("_encstr_849007B268BD03DFD8");
  var_2 thread bottompercentagetoadjusteconomy();
}

bottompercentagetoadjusteconomy() {
  var_0 = self;
  var_0 notify("_encstr_927B149B8B61A224E9EBA2AA81805C5ACE2F376B071D");
  var_0 endon("_encstr_927B149B8B61A224E9EBA2AA81805C5ACE2F376B071D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");
  var_0.vehicle endon("_encstr_AD75063D571AE108");
  var_1 = var_0.vehicle.turret;

  if(isDefined(var_1))
    var_1.owner = var_0;

  var_2 = 6;

  for(;;) {
    var_1 shootturret(var_0.vehicle._id_13E83, var_2, 1);

    if(istrue(var_0.vehicle.binoculars_onstateenterfunc))
      var_0.binoculars_onstateexitfunc[1] = var_0.binoculars_onstateexitfunc[1] + 1;
    else
      var_0.binoculars_onstateexitfunc[0] = var_0.binoculars_onstateexitfunc[0] + 1;

    if(var_0.vehicle._id_13E83 == "_encstr_A14F0AE336178944BA076F41")
      var_0.vehicle._id_13E83 = "_encstr_A2E40C6B019C4FAF58833B38E7F2";
    else
      var_0.vehicle._id_13E83 = "_encstr_A14F0AE336178944BA076F41";

    var_0.vehicle br_pickupdenyweaponpickupap("_encstr_9A2E15D3F805874F1876A0A10201DF0F41815BDA30E73B", "_encstr_AB131039AED698B1B2BECC327D3734B7B78E");
    var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 1, 12, 11, 0);
    wait(level.picking_up_minigun);

    if(!var_0 attackButtonPressed()) {
      var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 0, 12, 1, 0);
      return;
    }
  }
}

_id_12636(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");

  for(;;) {
    var_2 waittill(var_1);
    waittillframeend;
    var_2 thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

_id_12635(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");

  if(isbot(var_1)) {
    return;
  }
  foreach(var_4, var_3 in var_0.powers)
  var_1 thread _id_12636(var_0, var_4);
}

bot_get_low_on_all_ammo(var_0, var_1, var_2, var_3, var_4) {
  if(!_encstr_8BE608031FD3E1D08EBF(var_0))
    _encstr_81F90F6EDFA05ECB3939FA72810E8B95C8(var_0);

  if(isDefined(level.pindia_headlights) && level.pindia_headlights > 0)
    var_0.origin = var_0.origin + (0, 0, level.pindia_headlights);

  var_0 thread bot_gametype_get_num_players_on_team();
  var_0 thread bot_on_player_death();

  if(var_1 == "_encstr_A266062032BD7723") {
    if(istrue(level.phase_three_combat)) {
      var_3 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 2047, 0, 11, 1);
      var_3 thread checkpoint_release_spawnpoint();
      var_3 thread binoculars_istargetinrange();
    }

    if(istrue(level.picked_up_weapon)) {
      var_3 init_player_health();
      var_3 thread _id_1315F();
    }

    var_3 thread _id_14231(level.bot_set_zone_nodes);
    var_3 thread _id_12635(level.bot_set_zone_nodes);

    if(!istrue(level.phonesringing_singlemorse) && istrue(level.pickclassbr))
      var_3 thread br_allowloadout();

    var_3 thread br_alt_mode_impulse_player();
    var_3 thread bot_pick_new_zone();
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
}

br_alt_mode_impulse_player() {
  var_0 = self;
  var_0 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    return;
  }
  var_1 = var_0.vehicle;
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.nuke_killplayerwithattacker = 0;

  while(isDefined(var_0) && isDefined(var_0.vehicle)) {
    if(istrue(var_1.shouldmodeplayfinalmoments) && !istrue(var_1.nuke_killplayerwithattacker)) {
      var_2 = var_0 usinggamepad() && var_0 fragButtonPressed();
      var_3 = !var_0 usinggamepad() && var_0 _meth_87D4();

      if(var_2 || var_3)
        var_1 thread bot_get_flag_carrier();
    }

    wait 0.2;
  }
}

bot_pick_new_zone() {
  var_0 = self;
  var_0 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    return;
  }
  var_1 = var_0.vehicle;
  var_1 endon("_encstr_AD75063D571AE108");

  if(istrue(var_1.shouldmodeplayfinalmoments)) {
    return;
  }
  for(;;) {
    while(var_1 vehicle_getspeed() < 60)
      wait 0.2;

    var_1 br_pickupdenyweaponpickupap("_encstr_83EA16FFF7167A4D50730C5668D0AF82E5773F275F35B20C", "_encstr_8FF411B313E7901935CF5B44595A162E82701D");

    while(var_1 vehicle_getspeed() > 60)
      wait 1.5;

    if(!_encstr_8BE608031FD3E1D08EBF(var_1)) {
      _encstr_81F90F6EDFA05ECB3939FA72810E8B95C8(var_1);
      return;
    }
  }
}

bot_get_flag_carrier() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_97D8110768AFF206C1E9CF3FD039F42A6BF00C");
  var_0 endon("_encstr_97D8110768AFF206C1E9CF3FD039F42A6BF00C");
  var_0.nuke_killplayerwithattacker = 1;
  var_0 br_pickupdenyweaponpickupap("_encstr_AB3F18F34710DF1FB8FB1AB2C005BF57F8579961FD38A2D7D2D1", "_encstr_A3F8139D2D2592305901846ACF4F8AD326DA700F55");
  var_0 setscriptablepartstate("_encstr_BEA50D188B572DF572C9AEB9DD4A3B", "_encstr_BEA50D188B572DF572C9AEB9DD4A3B", 1);

  if(soundexists("_encstr_BE0110124B31AE82107B17631FA6ABE128C9"))
    var_0 playsoundtoplayer("_encstr_BE0110124B31AE82107B17631FA6ABE128C9", var_0.owner);

  var_1 = 1;

  for(var_2 = 1; isDefined(var_0) && isDefined(var_0.owner) && (var_1 || var_2); var_2 = !var_0.owner usinggamepad() && var_0.owner _meth_87D4()) {
    wait 0.4;
    var_1 = var_0.owner usinggamepad() && var_0.owner fragButtonPressed();
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_0.nuke_killplayerwithattacker = 0;
  var_0 setscriptablepartstate("_encstr_BEA50D188B572DF572C9AEB9DD4A3B", "_encstr_A29B05E9400E5D", 0);
}

bot_gametype_get_num_players_on_team() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BE92180BC15BD7AE184BD7F347D0B37377F822C3EE25BFA6F8A7");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0._id_145C9 = 0;
  var_0.helicrash = 0;
  var_0.spawn_fake_letter = 0;

  for(;;) {
    if(istrue(var_0._id_145C9)) {
      if(var_0 vehicle_getspeed() < level.pickuptrigger) {
        var_0._id_145C9 = 0;
        var_0 setscriptablepartstate("_encstr_840703F23B", "_encstr_A29B05E9400E5D", 0);
      }
    } else if(var_0 vehicle_getspeed() > level.pickuptrigger) {
      var_0._id_145C9 = 1;
      var_0 setscriptablepartstate("_encstr_840703F23B", "_encstr_8B6007D127B04BD8E6", 0);
    }

    if(istrue(level.ph_checkforovertime)) {
      if(istrue(var_0.helicrash)) {
        if(var_0 vehicle_getspeed() < level.pickup_truck_initomnvars) {
          var_0.helicrash = 0;
          var_0 setscriptablepartstate("_encstr_AB700F3F0938439D5922C08309B04E104D", "_encstr_A29B05E9400E5D", 0);
        }
      } else if(var_0 vehicle_getspeed() > level.pickup_truck_initomnvars) {
        var_0.helicrash = 1;
        var_0 setscriptablepartstate("_encstr_AB700F3F0938439D5922C08309B04E104D", "_encstr_AB700F3F0938439D5922C08309B04E104D", 0);
      }

      if(istrue(var_0.spawn_fake_letter)) {
        if(var_0 vehicle_getspeed() < level.pickupchecks || abs(var_0.angles[2]) < level.ph_loadouts) {
          var_0.spawn_fake_letter = 0;
          var_0._id_138A5 = undefined;
          var_0 setscriptablepartstate("_encstr_82990E9BDE28FB5EE80F95F893E3A8D8", "_encstr_A29B05E9400E5D", 0);
        }
      } else if(var_0 vehicle_getspeed() > level.pickupchecks && abs(var_0.angles[2]) > level.ph_loadouts) {
        var_0.spawn_fake_letter = 1;
        var_0._id_138A5 = gettime();
        var_0 setscriptablepartstate("_encstr_82990E9BDE28FB5EE80F95F893E3A8D8", "_encstr_82990E9BDE28FB5EE80F95F893E3A8D8", 0);
      }
    }

    if(istrue(var_0.spawn_fake_letter)) {
      if(isDefined(var_0._id_138A5) && gettime() - var_0._id_138A5 > 500) {
        var_0 setscriptablepartstate("_encstr_A1E60C8D8D70604C3051C1D7CA28", "_encstr_91510FB3059FF655AD3FAAEB99732D8B15", 0);
        var_0._id_1443E = 1;
      }
    } else if(istrue(var_0._id_1443E)) {
      var_0 setscriptablepartstate("_encstr_A1E60C8D8D70604C3051C1D7CA28", "_encstr_A7A408B9CA5D1D4E2C63", 0);
      var_0._id_1443E = undefined;
    }

    wait 0.3;
  }
}

register_sequence_4_objectives() {
  var_0 = self;
  var_1 = 0;

  if(var_0.shouldmodeplayfinalmoments)
    var_1 = 2;
  else if(var_0 vehicle_getspeed() > 5)
    var_1 = 1;
  else
    var_1 = 0;

  return var_1;
}

bot_get_human_picked_class(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    thread bot_get_landing_spot(var_0, var_1, var_2, var_3, var_4);
  else if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "_encstr_A266062032BD7723") {
      var_3 checkpoint_player_spawns_func();
      bot_pick_new_loadout_next_spawn(var_3);
    }
  }
}

bot_get_landing_spot(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3.should_hide_buried_mother_corpse))
    var_3.should_hide_buried_mother_corpse = 1;
  else
    var_3.should_hide_buried_mother_corpse = var_3.should_hide_buried_mother_corpse + 1;

  var_3 bot_pickup_origin(var_0, var_1, var_2, var_4);

  if(isDefined(var_3.carriable_set_dropped)) {
    if(isDefined(level.bot_shotguns))
      var_3 thread[[level.bot_shotguns]]();
  }

  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627") {
    var_5 = "_encstr_85100F7376B718BBA15A43D8058F09CC4A";
    var_6 = 3;
  }

  if(var_1 == "_encstr_A266062032BD7723") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_0.owner = var_3;
    var_3 controlslinkTo(var_0);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_0._id_13E92);
    var_7.owner = var_3;
    var_3.vehicle.turret = var_7;
    bot_gametype_get_allied_defenders_for_team(var_3);
    var_3 bots_with_player_enemy(1);
    var_3.binoculars_onstateexitfunc = [0, 0];
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);

  if(getdvarint("_encstr_9A7621B9D8C9D795370B89C656BEC21CAFB35ACD4BEDCD37CA47F5DB67AC3927B48C95", 1)) {
    if(isDefined(level._encstr_B2011828C9171F67C897152022632A439313B07A51E047EDB5D7))
      var_3 visionsetnakedforplayer(level._encstr_B2011828C9171F67C897152022632A439313B07A51E047EDB5D7, 0);
    else
      var_3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_93FA106B1C7DEEE9EB5AB98DB0DCC8EB2C38");
  }

  wait 1;

  if(istrue(level.pickprematchrandomloadout) && isDefined(var_3) && var_1 == "_encstr_A266062032BD7723")
    var_3 playerhide();
}

bot_get_num_teammates_capturing_zone(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && var_1 == "_encstr_A266062032BD7723") {
    var_3 thread _id_14230(level.bot_set_zone_nodes);
    var_3 bot_snipers();
    var_3 notify("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");
    var_0 thread bot_next_difficulty_type_index();
    var_3 notify("_encstr_B47F1C86F048BBF37F05139B7B17DAD99898FDC7A8A0435AD52B7B2771CD");
    var_3 bots_with_player_enemy(0);
  }

  if(istrue(var_4.success)) {
    var_3 notify("_encstr_8D2316421AA3CB4450E76F4B8B404B1FDF50ABAAE30F4BFB");
    bot_get_player_enemy(var_0, var_1, var_2, var_3, var_4);
  }
}

bot_get_player_enemy(var_0, var_1, var_2, var_3, var_4) {
  var_3 bot_protect_hq_zone(var_0, var_1, var_2, var_4);

  if(var_1 == "_encstr_A266062032BD7723") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  var_5 = !isDefined(var_2);

  if(var_1 == "_encstr_A266062032BD7723" || var_5 && var_3 hasweapon(var_0._id_13E92)) {
    var_6 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_0._id_13E92);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_6);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);
    }

    var_6.owner = undefined;
    var_6 setotherent(undefined);

    if(!level.pistolweapon)
      var_6 setentityowner(undefined);

    bot_pick_new_loadout_next_spawn(var_3);
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 controlsunlink();

    if(istrue(var_4.playerdeath))
      var_3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_7) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840")]](var_3);
      else
        var_3 suicide();
    }
  }

  if(isDefined(level._id_142D1))
    var_3 visionsetnakedforplayer(level._id_142D1, 0);
  else
    var_3 scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_B40101", 0.0);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

bot_gametype_get_allied_defenders_for_team(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = 1;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068");

  if(istrue(var_1._id_133D3)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_9ABD17493B45108C63839D839B88D3E8F3D410012AB5C04D8B", 0.4, 0, ::bot_go_to_destination);
}

bot_pick_new_loadout_next_spawn(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = undefined;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068");

  if(istrue(var_1._id_133D3)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_9ABD17493B45108C63839D839B88D3E8F3D410012AB5C04D8B", 0);
}

bot_go_to_destination(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" && var_4 != "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    return 1;

  if(!isDefined(var_5))
    return 1;

  switch (var_5.basename) {
    case "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC":
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      return 0;
    default:
      return 1;
  }
}

bot_parachute_into_map(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4);
  thread bot_pick_dd_zone_with_fewer_defenders(var_0, var_1, var_2, var_3, var_4);
}

bot_pick_dd_zone_with_fewer_defenders(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "_encstr_A266062032BD7723") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
  }
}

_id_13DDA() {
  return 1;
}

trophy_protectionsuccessful(var_0) {
  self._id_13DDF--;
  var_1 = var_0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_993F1C6B20D95C8F7045AF9CE6380BA44381C2B3D08595DFAFBF8A877523", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_993F1C6B20D95C8F7045AF9CE6380BA44381C2B3D08595DFAFBF8A877523", "_encstr_88C5055208731B")]](var_0);

  var_2 = trophy_getbesttag(var_1);
  self setscriptablepartstate("_encstr_9B1910D4B568FFFBA316426AA357E262FCE0", var_2);
  var_3 = vectortoangles(self gettagorigin(var_2) - var_1);
  var_4 = combineangles(var_3, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8A716E847BC384A61F8BFECEBC898A3A04F78F0B1D27D71", "_encstr_88C5055208731B"))
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8A716E847BC384A61F8BFECEBC898A3A04F78F0B1D27D71", "_encstr_88C5055208731B")]](var_1, var_4);

  if(self._id_13DDF == 0) {
    self notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_ABF40FA3E09808FA7328154D306B62AD20");
    self waittill("_encstr_8891134727DE831AE57D85B65BEDFAE42B33D263D8");
  } else
    self notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_8EAF11EB3877BA03B238F1E5C9981703B76872");
}

trophy_getbesttag(var_0) {
  var_1 = ["_encstr_A1060DCBA13CEF8B087FD8D84B3982", "_encstr_93060D9119AF8955A3925358DB3F2E", "_encstr_A3060DDB4758481BB8AA276361998E", "_encstr_83060D83B1A0C7D3B65743DB83C81F"];
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_8, var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = distancesquared(var_6, var_0);

    if(var_8 == 0 || var_7 < var_2) {
      var_2 = var_7;
      var_3 = var_5;
    }
  }

  return var_3;
}

bot_is_in_gas() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_BDC80A5437EAD749519A6068", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::bot_get_tdef_flag;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

bot_get_tdef_flag() {
  if(isDefined(level._id_1217D) && level._id_1217D.size != 0)
    var_0 = level._id_1217D;
  else
    var_0 = scripts\engine\utility::getStructArray("_encstr_BDC80A5437EAD749519A6068", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

bots_with_player_enemy(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || !isDefined(var_1.vehicle) || isbot(var_1)) {
    return;
  }
  var_2 = var_1.vehicle;

  if(!isDefined(var_2.br_alt_mode_inflation)) {
    return;
  }
  var_3 = bots_seek_player(var_0, var_2.br_alt_mode_inflation);
  var_1 setclientomnvar("_encstr_AD7E0F5796EB8993FACC46D7E63AC2D1B2", var_3);
}

bots_seek_player(var_0, var_1) {
  var_2 = 1;
  var_3 = 3;
  var_4 = int(var_0) &var_2;
  var_4 = var_4 + ((int(var_1) &var_3) << 1);
  return var_4;
}

br_allowloadout() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");
  var_1 = -40;
  var_2 = -135;
  var_3 = 40;
  var_4 = -135;
  var_0.botloadoutfavoritecamoprimary = var_0 _id_12530(var_3, var_4, "_encstr_A5AD056A019C63", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_A146078E65FB5158DD", &"_encstr_A98D1F3920F9E908EF43BBB9B918E4A0ADF32954CD31983721A7869DA311440BF1");

  while(!isDefined(var_0.vehicle))
    wait 0.5;

  var_0 thread br_ammo_update_ammotype_weapons();
}

bot_snipers() {
  var_0 = self;

  if(isDefined(var_0.botloadoutfavoritecamoprimary))
    var_0.botloadoutfavoritecamoprimary destroy();

  var_0.botloadoutfavoritecamoprimary = undefined;
}

br_ammo_update_ammotype_weapons() {
  var_0 = self;

  if(!isDefined(var_0)) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");

  for(;;) {
    if(!isDefined(var_0.vehicle)) {
      return;
    }
    var_1 = 0;

    foreach(var_3 in level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"]) {
      if(istrue(var_3.shouldmodeplayfinalmoments))
        var_1++;
    }

    if(isDefined(level.vehicle.instances["_encstr_83F40783ADF1D14AA3"])) {
      foreach(var_6 in level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]) {
        if(istrue(var_6.shouldmodeplayfinalmoments))
          var_1++;
      }
    }

    var_0.botloadoutfavoritecamoprimary setvalue(var_1);
    wait 3;
  }
}

_id_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = init_player_plane_exit_anims("_encstr_8B1608EC43B8D647A113", 1.0);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 1;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6))
    var_8.label = var_6;

  if(isDefined(var_7))
    var_8 setvalue(var_7);

  return var_8;
}

init_player_plane_exit_anims(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "_encstr_9779056EEA2583";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.hidden = 0;
  return var_2;
}

init_player_health() {
  self.br_pelletmaxdamage = spawnStruct();
  self.br_pelletmaxdamage._id_13A72 = [];
}

_id_1315F() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_B47F1C86F048BBF37F05139B7B17DAD99898FDC7A8A0435AD52B7B2771CD");
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

  wait 2;

  while(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(var_0)) {
    var_2 = [];
    [var_4, var_5] = rooftop_active(level.pilot_setups, level.pilot_model);

    foreach(var_7 in level.players) {
      if(var_7.team == var_0.team) {
        continue;
      }
      if(isDefined(level.br_pickupdenyalreadyhaveplatepouch)) {
        if(var_7[[level.br_pickupdenyalreadyhaveplatepouch]]())
          continue;
      }

      if(isDefined(level.br_movingcirclemovedistmin)) {
        if(var_7[[level.br_movingcirclemovedistmin]]("_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2") || var_7[[level.br_movingcirclemovedistmin]]("_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F"))
          continue;
      }

      if(isDefined(var_7.vehicle) && isDefined(var_7.vehicle.targetname) && (var_7.vehicle.targetname == "_encstr_83F40783ADF1D14AA3" || var_7.vehicle.targetname == "_encstr_BDC80A5437EAD749519A6068")) {
        if(var_7.vehicle _id_1331B(var_7))
          var_2 = scripts\engine\utility::array_add(var_2, var_7);

        continue;
      }

      if(isDefined(var_7.currentweapon) && isDefined(var_7.currentweapon.basename) && (var_7.currentweapon.basename == "_encstr_97781E650A25C38AAC57A0C87B5BB7F5DF8A108FA21EBB8BF030E72F98F028EA" || var_7.currentweapon.basename == "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83" || var_7.currentweapon.basename == "_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A")) {
        var_2 = scripts\engine\utility::array_add(var_2, var_7);
        continue;
      }

      var_8 = _id_13D9C(var_7.origin, var_0.vehicle.origin, var_4, var_5);

      if(istrue(var_8)) {
        var_2 = scripts\engine\utility::array_add(var_2, var_7);
        continue;
      }
    }

    if(isDefined(level.decoygrenades)) {
      foreach(var_11 in level.decoygrenades) {
        if(!isDefined(var_11)) {
          continue;
        }
        if(isDefined(var_11.team) && var_11.team == var_0.team) {
          continue;
        }
        var_8 = _id_13D9C(var_11.origin, var_0.vehicle.origin, var_4, var_5);

        if(istrue(var_8)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_11);
          continue;
        }
      }
    }

    if(isDefined(level.dummy_hint)) {
      foreach(var_14 in level.dummy_hint) {
        if(!isDefined(var_14)) {
          continue;
        }
        var_8 = _id_13D9C(var_14.origin, var_0.vehicle.origin, var_4, var_5);

        if(istrue(var_8)) {
          var_2 = scripts\engine\utility::array_add(var_2, var_14);
          continue;
        }
      }
    }

    if(var_2.size > 0) {
      var_16 = level.teamdata[var_0.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];

      if(istrue(var_1))
        var_16 = level.squaddata[var_0.team][var_0.squadindex].players;

      foreach(var_18 in var_16) {
        if(!isalive(var_18)) {
          continue;
        }
        if(isDefined(level.br_pickupdenyalreadyhaveplatepouch)) {
          if(var_18[[level.br_pickupdenyalreadyhaveplatepouch]]())
            continue;
        }

        var_19 = distance(var_0.vehicle.origin, var_18.origin);

        if(var_19 < 10000) {
          foreach(var_21 in var_2)
          var_18 thread br_plunder_site_use_states(var_21, var_0);
        }
      }

      if(soundexists("_encstr_B2DD107B2AF783ABDFD759865DA15FE8B070"))
        var_0 playsoundtoplayer("_encstr_B2DD107B2AF783ABDFD759865DA15FE8B070", var_0);
    }

    wait 3.25;
  }
}

rooftop_active(var_0, var_1) {
  var_2 = self;
  var_2 notify("_encstr_A2EF1D8827C4464F520527B6514AAFA83D37A0309F661E0D9A2AA533B602DF");
  var_2 endon("_encstr_A2EF1D8827C4464F520527B6514AAFA83D37A0309F661E0D9A2AA533B602DF");
  var_3 = var_2.vehicle.origin;
  var_4 = anglesToForward(var_2.vehicle.angles);
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = vectorcross(var_4, (0, 0, 1));
  var_6 = var_4 * var_0 * cos(var_1);
  var_7 = var_0 * sin(var_1);
  var_8 = [];
  var_9 = (0, 0, 0);
  var_10 = undefined;
  var_11 = undefined;

  for(var_12 = 0; var_12 < 2; var_12++) {
    var_13 = var_12 / 2 * 360;
    var_14 = var_3 + var_6 + var_7 * (var_5 * cos(var_13));
    var_9 = var_14;

    if(isDefined(var_11)) {
      var_10 = var_14;
      continue;
    }

    var_11 = var_14;
  }

  return [var_10, var_11];
}

_id_13D9C(var_0, var_1, var_2, var_3) {
  var_4 = updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3);

  if(var_4)
    return 1;
  else
    return 0;
}

updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3) {
  if(!use_nvg_think(var_0, var_1, var_2))
    return 0;

  if(!use_nvg_think(var_0, var_2, var_3))
    return 0;

  if(!use_nvg_think(var_0, var_3, var_1))
    return 0;

  return 1;
}

use_nvg_think(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]) < 0;
}

_id_1331B(var_0) {
  var_1 = self;
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(var_1);

  if(isDefined(var_2)) {
    if(var_2 == var_0)
      return 1;
  } else {
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1);

    foreach(var_5 in var_3) {
      if(var_5 == var_0)
        return 1;
      else
        break;
    }
  }

  return 0;
}

br_plunder_site_use_states(var_0, var_1) {
  var_2 = self;
  var_3 = undefined;

  if(isDefined(var_0.type) && var_0.type == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D") {
    var_4 = "_encstr_8E461FA1AEC8D7B46CF6B9F57693DBEA7319BE5B2C27B595C8BEB726A6F51BB2EC";
    var_3 = var_0.origin;
  } else if(var_0 updatedroprelicsfunc() || var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::updateexpiredlootleader())
    var_4 = "_encstr_8A38145B50715F92CFB88DC997E31B17F868BB2FB829";
  else
    var_4 = "_encstr_8E1F17A1AE8CF596D8BD37D73B9CF65DB98CAFB6C293B59546";

  var_5 = 8;
  var_6 = 1;
  var_7 = 500;
  var_8 = 31500;
  var_9 = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_2, var_4, var_5, var_6, var_8, var_7, undefined, 1, 1, var_3);
  var_2 br_prematchspawnlocations(var_0);
  var_2 scriptedspawnpointarray(var_0, var_1);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_9);
}

scriptedspawnpointarray(var_0, var_1) {
  var_2 = self;

  if(!isDefined(level.br_movingcirclegulagcloseoffset)) {
    return;
  }
  if(!isDefined(var_2) || !isDefined(var_0) || !isDefined(var_1) || !isDefined(var_0.lastkilledby) || !isDefined(var_0.lastkilledby.team)) {
    return;
  }
  if(!isent(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(var_0.health != 0) {
    return;
  }
  if(var_2 != var_1) {
    return;
  }
  if(var_2 == var_1 && var_0.lastkilledby.team == var_1.team && var_0.lastkilledby != var_1)
    var_1 thread[[level.br_movingcirclegulagcloseoffset]]("_encstr_B2A512E24696E36FCF6B727B08F766FF4BA37B8C");
}

br_prematchspawnlocations(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_B47F1C86F048BBF37F05139B7B17DAD99898FDC7A8A0435AD52B7B2771CD");
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", 3.0);
}

updatedroprelicsfunc() {
  var_0 = self;

  if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle.targetname) && var_0.vehicle.targetname == "_encstr_BDC80A5437EAD749519A6068")
    return 1;

  return 0;
}

unreachable_function() {
  var_0 = self;

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var_0.targetname) && var_0.targetname == "_encstr_BDC80A5437EAD749519A6068")
    return 1;

  return 0;
}

unrescuable_fail() {
  var_0 = self;

  if(isDefined(var_0.classname) && var_0.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E" && isDefined(var_0.model) && var_0.model == "_encstr_8849273B59D0BECD867D5BD263F585D2C9AF4616D8C143C2F5BBE9D7D1EAC9932BA37D581D1DB0C634")
    return 1;

  return 0;
}

checkpoint_release_spawnpoint() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A9601CCA3C4B47B4B9B3F538A5367BD1AF6EB2C2A3EBC2D24E6CE40B33E8");
  wait 2;

  if(!isDefined(var_0.vehicle)) {
    var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 2047, 0, 11, 1);
    return;
  }

  var_0.br_standard_loadout = spawnStruct();
  var_1 = var_0.vehicle.turret;

  while(isDefined(var_0.vehicle)) {
    var_0.br_standard_loadout.checkpoint_set = [];

    if(istrue(level.phase_zero_combat)) {
      if(!istrue(var_0.vehicle.binoculars_onstateenterfunc)) {
        var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 2047, 0, 11, 0);
        wait(level.phclass);
        continue;
      }
    }

    if(istrue(level.phase_three_combat) && isDefined(var_0.vehicle.turret)) {
      var_2 = var_0.vehicle.turret _meth_87CF("_encstr_A14F0AE336178944BA076F41");

      if(checkpoint_trigger(var_2))
        var_0.br_standard_loadout.checkpoint_set[0] = var_2;
    }

    var_0 checkpoint_register();
    wait(level.phclass);

    if(isDefined(var_0.br_standard_loadout) && (isDefined(var_0.br_standard_loadout.target) && !isalive(var_0.br_standard_loadout.target))) {
      var_0.br_standard_loadout.target = undefined;
      var_0 checkpoint_register();
      var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 2047, 0, 11, 1);
    }
  }
}

checkpoint_trigger(var_0) {
  var_1 = self;
  var_2 = isDefined(var_0);

  if(var_2) {
    var_3 = isDefined(var_0.owner);
    var_4 = var_3 && isDefined(var_0.owner.team) && var_0.owner.team != "_encstr_A7A408B9CA5D1D4E2C63";
    var_5 = var_3 && isDefined(var_0.owner.vehicle) && var_0.owner.vehicle == var_0;
    var_6 = var_5 && var_4 && var_0.owner.team != var_1.team;
    var_7 = isDefined(var_0.team) && var_0.team != "_encstr_A7A408B9CA5D1D4E2C63";
    var_8 = undefined;
    var_9 = isPlayer(var_0) && var_0 isskydiving() && istrue(level.pilot_linkto_origin_offset);
    var_10 = isPlayer(var_0) && istrue(var_0._id_125CD);
    var_11 = isDefined(var_0.agent_type) && (var_0.agent_type == "_encstr_B6B00E2383C3A0EEAF7A69704267AB98" || var_0.agent_type == "_encstr_86EA0F2767A56AEA69611A27D9180242FB");

    if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(var_6)
        return 1;
    } else if(var_7 && !var_11) {
      var_8 = var_0.team != var_1.team;

      if(var_8 && !var_9 && !var_10)
        return 1;
    }
  }

  return 0;
}

checkpoints_init(var_0) {
  return (var_0 gettagorigin("_encstr_A14F0AE336178944BA076F41") + var_0 gettagorigin("_encstr_A2E40C6B019C4FAF58833B38E7F2")) / 2;
}

checkpoints_count(var_0) {
  return var_0 gettagangles("_encstr_A14F0AE336178944BA076F41");
}

_id_127DF(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]);
}

checkpoint_player_spawns_func() {
  var_0 = self;
  var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 2047, 0, 11, 1);
  var_0.br_standard_loadout = undefined;
}

checkpoint_register() {
  var_0 = self;
  var_1 = var_0.br_standard_loadout.checkpoint_set;

  if(!isDefined(var_1) || var_1.size <= 0) {
    var_0.br_standard_loadout.target = undefined;
    var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 2047, 0, 11, 1);
  } else {
    var_2 = checkpoints_init(var_0.vehicle.turret);
    var_3 = anglesToForward(var_0.vehicle.angles);
    var_4 = var_3 * level.phaseindex * cos(level.phase_two_combat);
    var_5 = var_2 + var_4;
    var_6 = undefined;
    var_7 = undefined;

    foreach(var_9 in var_1) {
      var_10 = _id_127DF(var_9.origin, var_2, var_5);

      if(!isDefined(var_7) || var_10 < var_7) {
        var_7 = var_10;
        var_6 = var_9;
      }
    }

    if(isDefined(var_0.br_standard_loadout.target) && var_6 == var_0.br_standard_loadout.target) {
      var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", var_6 getentitynumber(), 0, 11, 0);
      return;
    }

    var_0.br_standard_loadout.target = var_6;
    var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", var_6 getentitynumber(), 0, 11, 1);

    if(soundexists("_encstr_96EB149BA17D9932D78E1627CE59A3BEC6DB6CB5B219"))
      var_0 playsoundtoplayer("_encstr_96EB149BA17D9932D78E1627CE59A3BEC6DB6CB5B219", var_0);

    if(isDefined(var_6.vehicle)) {
      var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 1, 11, 1, 0);
      return;
    }

    var_0 _id_13FBF("_encstr_84310D05A9BF09011993D0709AAFE9", 0, 11, 1, 0);
  }
}

_id_13FBF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;

  if(!isDefined(var_1)) {
    return;
  }
  var_6 = int(pow(2, var_3)) - 1;
  var_7 = (var_1 &var_6) << var_2;
  var_8 = ~(var_6 << var_2);
  var_9 = self calloutmarkerping_entityzoffset(var_0);

  if(istrue(var_4)) {
    self setclientomnvar(var_0, var_7);
    return;
  } else if(!isDefined(var_9))
    var_9 = var_8;

  var_10 = var_9 &var_8;

  if(!isDefined(var_7)) {
    return;
  }
  var_11 = var_10 + var_7;

  if(var_11 != var_9)
    self setclientomnvar(var_0, var_11);
}

binoculars_istargetinrange() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isbot(var_0)) {
    return;
  }
  while(!isDefined(var_0.vehicle))
    waitframe();

  if(!isDefined(var_0.vehicle)) {
    return;
  }
  var_0.vehicle endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D2316421AA3CB4450E76F4B8B404B1FDF50ABAAE30F4BFB");
  var_0.vehicle.binoculars_onstateenterfunc = 0;
  var_1 = 0;

  while(isDefined(var_0.vehicle)) {
    while(var_1 == var_0 adsButtonPressed())
      waitframe();

    var_1 = var_0 adsButtonPressed();

    if(var_1) {
      var_0.vehicle.binoculars_onstateenterfunc = 1;
      var_0 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 1);
      continue;
    }

    var_0.vehicle.binoculars_onstateenterfunc = 0;
    var_0 setclientomnvar("_encstr_BA1E177B08D9418A2EF1BB87255D11B9E8D379C6E1D801338D", 0);
  }
}

loadout_finalizeweapons(var_0) {
  if(!isDefined(self.loadout_fixcopiedclassstruct)) {
    self.loadout_fixcopiedclassstruct = 1;
    self _meth_87D0(0);
    _id_13FEC(var_0, 1);
  } else {
    var_1 = _id_13FEC(var_0, 1);

    if(var_1)
      self.loadout_fixcopiedclassstruct++;
  }
}

move_structs(var_0) {
  if(isDefined(self.loadout_fixcopiedclassstruct)) {
    var_1 = _id_13FEC(var_0, 0);

    if(var_1)
      self.loadout_fixcopiedclassstruct--;

    if(!self.loadout_fixcopiedclassstruct) {
      self _meth_87D0(1);
      self.loadout_fixcopiedclassstruct = undefined;
    }
  }
}

_id_13FEC(var_0, var_1) {
  if(!isDefined(self.loadout_getglobalclassstruct))
    self.loadout_getglobalclassstruct = [0, 0, 0, 0, 0];

  var_2 = undefined;

  switch (var_0) {
    case "_encstr_9A50080BA7292FFA0DA2":
      var_2 = 0;
      break;
    case "_encstr_9B220634456A5747":
      var_2 = 1;
      break;
    case "_encstr_A5510A30AA778D28B3C97D51":
      var_2 = 2;
      break;
    case "_encstr_B15208273F5BA2896879":
      var_2 = 3;
      break;
    case "_encstr_87680AB085AF1DBA93C92B1D":
      var_2 = 4;
      break;
  }

  if(!isDefined(var_2))
    return 0;

  if(var_1) {
    if(istrue(self.loadout_getglobalclassstruct[var_2]))
      return 0;
    else {
      self.loadout_getglobalclassstruct[var_2] = 1;
      return 1;
    }
  } else if(istrue(self.loadout_getglobalclassstruct[var_2])) {
    self.loadout_getglobalclassstruct[var_2] = 0;
    return 1;
  } else
    return 0;
}

br_pickupdenyweaponpickupap(var_0, var_1) {
  var_2 = self;

  if(!_encstr_8BE608031FD3E1D08EBF(var_2)) {
    _encstr_81F90F6EDFA05ECB3939FA72810E8B95C8(var_2);
    return;
  }

  var_2 setscriptablepartstate("_encstr_A29A0CCB508E5D1A3D43829ADACA", var_0, 0);
  var_2 setscriptablepartstate("_encstr_816E079685517D0975", var_1, 0);
}

_encstr_8BE608031FD3E1D08EBF(var_0) {
  return var_0 unreachable_function() && var_0.model == "_encstr_821619CEAC0DAFCD1AD7ADB4B1F5582D9CFA9185D8E034B0F5EE9E" && var_0.vehiclename == "_encstr_BDC80A5437EAD749519A6068";
}

_encstr_81F90F6EDFA05ECB3939FA72810E8B95C8(var_0, var_1) {
  var_2 = "_encstr_BEFB270D372213B0DCEFB9E812F89058BB8ADB69FB8AEF73ED10B103BF68508692E70D7367A207D240" + var_1.vehiclename + "_encstr_BDDD0B1E9EB34A6BEDD0B8DF7E" + var_1.model;
  var_3 = var_2 == undefined;
}

bot_pickup_origin(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isDefined(var_4)) {
    return;
  }
  var_4.br_pickupdenyalreadyhavequest = gettime();
  var_4 bot_set_difficultysetting(var_0, var_1);
  var_5 = [];
  var_6 = var_0 respawntags();
  var_5[var_5.size] = "_encstr_88820B076385B959FA47970759";
  var_5[var_5.size] = var_6;
  var_7 = var_4 retreat_vehicle_collision_clear(var_2);
  var_5[var_5.size] = "_encstr_993112B9EB4AE3481AB9FB529AF5611552131B05";
  var_5[var_5.size] = var_7;

  if(var_7 == "_encstr_A2940E56B9E8CA39D79D2B0D96D8B156") {
    var_8 = var_4 restartcircleelimination();
    var_5[var_5.size] = "_encstr_B4A218682AFB855E17951C01269D90BAB0C2413163F161D42B2B";
    var_5[var_5.size] = var_8;
    var_9 = var_4 register_trap_room_objectives();
    var_5[var_5.size] = "_encstr_BA98162BFB4030F0F9A8C8BF9770A9A1C232BF91134B0DC5";
    var_5[var_5.size] = var_9;
    var_10 = var_4 register_valid_gametypes_for_create_script();
    var_5[var_5.size] = "_encstr_8F7315C5F3300742FBAD838BF3104A63F9D87D01E9F8D2";
    var_5[var_5.size] = var_10;
    var_11 = var_4 restock_dialoguesectionalogic();
    var_5[var_5.size] = "_encstr_BD8B12C2E923738DA3095FBB88BB54D9D1FB4A3F";
    var_5[var_5.size] = var_11;
  } else {
    var_5[var_5.size] = "_encstr_B4A218682AFB855E17951C01269D90BAB0C2413163F161D42B2B";
    var_5[var_5.size] = "_encstr_B40101";
    var_5[var_5.size] = "_encstr_BA98162BFB4030F0F9A8C8BF9770A9A1C232BF91134B0DC5";
    var_5[var_5.size] = "_encstr_B40101";
    var_5[var_5.size] = "_encstr_8F7315C5F3300742FBAD838BF3104A63F9D87D01E9F8D2";
    var_5[var_5.size] = 0;
    var_5[var_5.size] = "_encstr_BD8B12C2E923738DA3095FBB88BB54D9D1FB4A3F";
    var_5[var_5.size] = "_encstr_B40101";
  }

  var_4 dlog_recordplayerevent("_encstr_967E1E814D05DF671D7B52F24DB9A8C877709D6FB36CB99113A3A7E8D885B73D", var_5);
}

bot_protect_hq_zone(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = [];
  var_6 = var_0 respawntags();
  var_5[var_5.size] = "_encstr_88820B076385B959FA47970759";
  var_5[var_5.size] = var_6;
  var_7 = var_4 retreatanddie(var_2);
  var_5[var_5.size] = "_encstr_BD3511C1C6B0CB2B27BED1F2C156AF59872D1D";
  var_5[var_5.size] = var_7;

  if(var_7 == "_encstr_95740D391337B5711BE5A9A30B4578") {
    var_8 = var_4 restartwrapper(var_3);
    var_5[var_5.size] = "_encstr_8F0113CA1E5AA3F53B2B1A961BC6B2D7B12CABCD95";
    var_5[var_5.size] = var_8;
    var_9 = var_4 respawntimedisable();
    var_5[var_5.size] = "_encstr_BEC716C1B48270C1EABBC3AFDBE29FF0178AC91B5AF1D088";
    var_5[var_5.size] = var_9;

    if(var_8 == "_encstr_AD75063D571AE108") {
      var_10 = var_0 register_techo_seat_data();
      var_5[var_5.size] = "_encstr_81321B568B939831A8CD88AF52A9256ABA912B4B5FB3D0175FA383E3E2";
      var_5[var_5.size] = var_10;
      var_11 = var_4 register_subway_track();
      var_5[var_5.size] = "_encstr_997D15B09693C11B8573ACAF36C2AEE695AF91CA583A1A";
      var_5[var_5.size] = var_11;
      var_12 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0).size + 1;
      var_5[var_5.size] = "_encstr_B88317A82B7F49395BF31384A7E86FF102FF910BE7F2C80B10";
      var_5[var_5.size] = var_12;
      var_13 = var_4 register_trap_room_objectives();
      var_5[var_5.size] = "_encstr_AAF21BEFF06B4855D175A8D840A2604CF818A01BEFD52A6758C3C4C20D";
      var_5[var_5.size] = var_13;
    } else {
      var_5[var_5.size] = "_encstr_81321B568B939831A8CD88AF52A9256ABA912B4B5FB3D0175FA383E3E2";
      var_5[var_5.size] = "_encstr_B40101";
      var_5[var_5.size] = "_encstr_997D15B09693C11B8573ACAF36C2AEE695AF91CA583A1A";
      var_5[var_5.size] = "_encstr_B40101";
      var_5[var_5.size] = "_encstr_B88317A82B7F49395BF31384A7E86FF102FF910BE7F2C80B10";
      var_5[var_5.size] = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0).size + 1;
      var_5[var_5.size] = "_encstr_AAF21BEFF06B4855D175A8D840A2604CF818A01BEFD52A6758C3C4C20D";
      var_5[var_5.size] = "_encstr_B40101";
    }
  } else {
    var_5[var_5.size] = "_encstr_8F0113CA1E5AA3F53B2B1A961BC6B2D7B12CABCD95";
    var_5[var_5.size] = "_encstr_B40101";
    var_5[var_5.size] = "_encstr_BEC716C1B48270C1EABBC3AFDBE29FF0178AC91B5AF1D088";
    var_5[var_5.size] = 0;
    var_5[var_5.size] = "_encstr_81321B568B939831A8CD88AF52A9256ABA912B4B5FB3D0175FA383E3E2";
    var_5[var_5.size] = "_encstr_B40101";
    var_5[var_5.size] = "_encstr_997D15B09693C11B8573ACAF36C2AEE695AF91CA583A1A";
    var_5[var_5.size] = "_encstr_B40101";
    var_5[var_5.size] = "_encstr_B88317A82B7F49395BF31384A7E86FF102FF910BE7F2C80B10";
    var_5[var_5.size] = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0).size + 1;
    var_5[var_5.size] = "_encstr_AAF21BEFF06B4855D175A8D840A2604CF818A01BEFD52A6758C3C4C20D";
    var_5[var_5.size] = "_encstr_B40101";
  }

  var_4 dlog_recordplayerevent("_encstr_8E051DB9E9B5B10F45C6F8258387CB9009D0E18FC1A9FFEB452A0F9DB06CFB", var_5);

  if(isDefined(var_4.br_pe_chopper_damage_time))
    var_4.br_pe_chopper_damage_time = undefined;

  if(isDefined(var_4.br_onvehicledeath))
    var_4.br_onvehicledeath = undefined;

  var_4 bot_set_difficultysetting(var_0, var_1);

  if(isDefined(var_4.binoculars_onstateexitfunc) && var_0 unreachable_function()) {
    if(isDefined(var_4.binoculars_onstateexitfunc[0]) && isDefined(var_4.binoculars_onstateexitfunc[1]) && var_4.binoculars_onstateexitfunc[1] > 0)
      var_4 dlog_recordplayerevent("_encstr_A998255504D781CF2F1BA8F8D349493847BE6D4064978BE553A250089B112371D767EDCEF92771", ["_encstr_96670CF1C79319D6BB4321CBDB23", var_4.binoculars_onstateexitfunc[0], "_encstr_87EA1427082BC7595907221F7D3111925368ABBF9823", var_4.binoculars_onstateexitfunc[1]]);

    var_4.binoculars_onstateexitfunc = undefined;
    return;
  }
}

restartcircleelimination() {
  var_0 = self;

  if(!isDefined(var_0.should_hide_buried_mother_corpse))
    return "_encstr_B40101";

  if(var_0.should_hide_buried_mother_corpse < 0)
    return "_encstr_AA4914664BB337EB4F48720AF877E70B2B25FA1150B9";
  else if(var_0.should_hide_buried_mother_corpse == 0)
    return "_encstr_BE5A15EE3519F7C25BD383DB7D186042C5D76088A0B012";
  else
    return "_encstr_A2FB162BA1A0878DB8EB5A59E5789997D7D8D26128035387";
}

respawntags() {
  var_0 = self;

  if(var_0 unreachable_function())
    return 1;
  else if(var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr())
    return 2;
  else if(var_0 _calloutmarkerping_onpingchallenge::unset_force_aitype_riotshield())
    return 3;
  else
    return 0;
}

retreat_vehicle_collision_clear(var_0) {
  var_1 = self;

  if(isDefined(var_0))
    return "_encstr_BA850E3EBDC7E56F9BF32EE18B4A2E34";
  else
    return "_encstr_A2940E56B9E8CA39D79D2B0D96D8B156";
}

register_trap_room_objectives() {
  var_0 = self;

  if(!isDefined(var_0.calloutarea))
    return "_encstr_B40101";

  return var_0.calloutarea;
}

register_valid_gametypes_for_create_script() {
  var_0 = self;
  var_1 = 0;

  if(!isDefined(level.vehicle) || !isDefined(level.vehicle.instances))
    return var_1;

  if(isDefined(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"])) {
    foreach(var_3 in level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"]) {
      if(istrue(var_3.shouldmodeplayfinalmoments))
        var_1++;
    }
  }

  if(isDefined(level.vehicle.instances["_encstr_83F40783ADF1D14AA3"])) {
    foreach(var_6 in level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]) {
      if(istrue(var_6.shouldmodeplayfinalmoments))
        var_1++;
    }
  }

  return var_1;
}

restock_dialoguesectionalogic() {
  var_0 = self;

  if(var_0 usinggamepad())
    return "_encstr_BE5B0B663F55B3039DC162C345";
  else
    return "_encstr_B81904B54C6B";
}

retreatanddie(var_0) {
  var_1 = self;

  if(isDefined(var_0))
    return "_encstr_BA850E3EBDC7E56F9BF32EE18B4A2E34";
  else
    return "_encstr_95740D391337B5711BE5A9A30B4578";
}

restartwrapper(var_0) {
  var_1 = self;

  if(!isDefined(var_0.onprematchfadedone2))
    return "_encstr_B40101";

  return tolower(var_0.onprematchfadedone2);
}

respawntimedisable() {
  var_0 = self;

  if(!isDefined(var_0.br_pickupdenyalreadyhavequest))
    return 0;

  var_1 = int((gettime() - var_0.br_pickupdenyalreadyhavequest) / 1000);
  return var_1;
}

register_techo_seat_data() {
  var_0 = self;
  var_1 = 0;
  var_2 = 0;

  if(isDefined(var_0.waitthensetgendersoundcontext)) {
    for(var_3 = 1; var_3 < var_0.waitthensetgendersoundcontext.size; var_3 = var_3 + 2) {
      if(var_1 < var_0.waitthensetgendersoundcontext[var_3]) {
        var_1 = var_0.waitthensetgendersoundcontext[var_3];
        var_2 = var_3;
      }
    }

    var_4 = var_0.waitthensetgendersoundcontext[var_2 - 1];
    return var_4;
  }

  return "_encstr_B40101";
}

register_subway_track() {
  var_0 = self;

  if(isDefined(var_0.br_pe_chopper_damage_time))
    return var_0.br_pe_chopper_damage_time;

  return "_encstr_B40101";
}

bot_set_difficultysetting(var_0, var_1) {
  var_2 = self;
  var_3 = -1;

  if(!isDefined(level._id_13B94))
    level._id_13B94 = ["_encstr_96550DC4EDB6982BE4AFC12D1BED1D", 0, "_encstr_92B70EC4BD6BC4CA4EEBD9AECDE6CA27", 0, "_encstr_8386101FB7E3EA649830EFE7C9332192BF55", 0, "_encstr_9B4B14531790F87320DFA267589BBF33D73BF8089B1A", 0];

  switch (var_1) {
    case "_encstr_A266062032BD7723":
      if(var_0 unreachable_function())
        var_3 = 5;
      else
        var_3 = 1;

      break;
    case "_encstr_8D48079DD59BE65627":
      var_3 = 7;
      break;
    case "_encstr_B15A0AD36BA8BBD79C58EBE3":
    case "_encstr_A7BF0B839873B3D72BABEAF535":
    case "_encstr_876809B995B01DAFA3DD7B":
      var_3 = 3;
      break;
    default:
      break;
  }

  if(var_3 < 0 || !isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_2._id_13B95))
    var_2._id_13B95 = gettime();
  else {
    var_2._id_13B95 = int((gettime() - var_2._id_13B95) / 1000);
    level._id_13B94[var_3] = level._id_13B94[var_3] + var_2._id_13B95;
    var_2._id_13B95 = undefined;
    getentitylessscriptablearray("_encstr_AFA0251BF12F3F212B6BF55D2B615A0851A35719B02F67EF501A1B77E2AB98AB858B892F458EA3", level._id_13B94);
  }
}