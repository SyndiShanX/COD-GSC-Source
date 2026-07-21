/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_relics.gsc
***********************************************/

register_relics() {
  level.updateonkillrelicsfunc = ::updateonkillrelics;
  level.updatepersistentrelicsfunc = ::updatepersistentrelics;
  level.updateondamagerelicsfunc = ::updateondamagerelics;
  level._id_14000 = ::_id_13FFF;
  level.cp_relics = [];
  level.updaterecentkillsrelics_func = ::updaterecentkills;
  level._id_13FD4 = ::_id_13FD3;
  level.relic_combos = load_relic_combos_from_table();
  level.modifyplayerdamage_relics = [];

  if(!isDefined(level.perks))
    level.perks = ["_encstr_AB671357374BBF8E0DDF4808E756819F53DD4D54CC", "_encstr_817A145378B59437E88F5B5893D087D11DC0BB5A0863", "_encstr_81991360BD43A7D1DBF0C26AA80597BF7991F9FB43", "_encstr_B6921259DD2AE8AF1FB2F1981A3BC591053FA5FB", "_encstr_B6E3170395B6D0F759E7237BFBA649C93D4AFC0F818925B1C5", "_encstr_848D1118A3F8B40FC151B20AB8A83F61503B8E", "_encstr_AD721437572BDFEE6D7FE8A847B6617FD27B2030AAE2", "_encstr_841E1338B24EDABEB516D8862D9B59FA37D6168DB6", "_encstr_878D112B23DE52BFB0F916DC90C0CD69B243B3", "_encstr_A33812C9223BBF07CD018FA88C2BC9F7F098158F"];

  register_relic("_encstr_81191963AE660F2B43C5FEEBD11A55771582AE077569164BF8C3B3", ::init_passive_railgun_overload, ::set_passive_railgun_overload, ::unset_passive_railgun_overload);
  register_relic("_encstr_818B1838856ECD96CE59F563B037E8EBE634ED1D9B7D0BDAB6F6", ::init_passive_last_shots_ammo, ::set_passive_last_shots_ammo, ::unset_passive_last_shots_ammo);
  register_relic("_encstr_8FB50D70DF03A73C8D70A1AAE8EF77", ::init_passive_nuke, ::set_passive_nuke, ::unset_passive_nuke);
  register_relic("_encstr_B1B416EF8EE337E0BE5741F03FC1196FFAB565E066FAC3E8", ::init_headshot_ammo, ::set_headshot_ammo, ::unset_headshot_ammo);
  register_relic("_encstr_A1B417F36FC3E3F8E8392181E7CFB1C7ECF88BC01FD3128DFB", ::init_headshot_super, ::set_headshot_super, ::unset_headshot_super);
  register_relic("_encstr_882510FBE1AF90230359E05D5B6BA39AF8D3", ::init_passive_refresh, ::set_passive_refresh, ::unset_passive_refresh);
  register_relic("_encstr_82211B13A0AF7302EB45F1C2C7FB4E143BEFECCB31A8EF388FD2F89661", ::init_passive_double_kill_reload, ::set_passive_double_kill_reload, ::unset_passive_double_kill_reload);
  register_relic("_encstr_82680D7017DBABB168A7569FF71B8F", ::init_passive_gore, ::set_passive_gore, ::unset_passive_gore);
  register_relic("_encstr_8BB412484FBBAB13DBEFAF11C75243D11BC73020", ::init_passive_melee_kill, ::set_passive_melee_kill, ::unset_passive_melee_kill);
  register_relic("_encstr_AC3217188A42478873D5188BAD575001ECF16850C19C8BE033", ::init_passive_health_on_kill, ::set_passive_health_on_kill, ::unset_passive_health_on_kill);
  register_relic("_encstr_9AD01DB21F5783D173E8B773F0C99CBBD9B8BA6FF4938ADF78D8BF77B88044", ::init_passive_health_regen_on_kill, ::set_passive_health_regen_on_kill, ::unset_passive_health_regen_on_kill);
  register_relic("_encstr_8C331B382CE6DC5A67B27DB6DECEB2D7B938CA2B8CEBDB9BAFAD9663D8", ::init_passive_move_speed_on_kill, ::set_passive_move_speed_on_kill, ::unset_passive_move_speed_on_kill);
  register_relic("_encstr_ABDF0FC1A7139E60466FD648142C08DF9A", ::init_passive_hitman, ::set_passive_hitman, ::unset_passive_hitman);
  register_relic("_encstr_A9AE1A07C2CDB94BCEB2FA37D8DEC959F531F67357DCEBB6A5D8C6E6", ::init_passive_score_bonus_kills, ::set_passive_score_bonus_kills, ::unset_passive_score_bonus_kills);
  register_relic("_encstr_8FCB193885E63796ECCAF59B6C7B9CCA6E473956C2B67D83B06C6D", ::init_passive_score_bonus_kills, ::set_passive_score_bonus_kills, ::unset_passive_score_bonus_kills);
  register_relic("_encstr_B2E31583169BE62DCECA7DE4853732F66BF5C1954EADDC", ::init_passive_random_perks, ::set_passive_random_perks, ::unset_passive_random_perks);
  register_relic("_encstr_A97D19C1124AC801CBCAA11BDB2F67F3699191C42AA0E8DBCBB7AA", ::init_passive_visor_detonation, ::set_passive_visor_detonation, ::unset_passive_visor_detonation);
  register_relic("_encstr_8E341458E00BFEB99ED8AFEA7FA93F33987B13D85D2E", ::init_passive_melee_super, ::set_passive_melee_super, ::unset_passive_melee_super);
  register_relic("_encstr_A56B1383FFFEBB196C3D36902B8DE080372512F7BB", ::init_passive_jump_super, ::set_passive_jump_super, ::unset_passive_jump_super);
  register_relic("_encstr_91B81A38C2DC9B5A9D2BF591B7AE4CC6ACBEDA4B8DB1D7CD5DE0959C", ::init_passive_double_kill_super, ::set_passive_double_kill_super, ::unset_passive_double_kill_super);
  register_relic("_encstr_8E4E1AB00FD377EC5D80514AE841270F0BEC214C96187F321FB88BC2", ::init_passive_mode_switch_score, ::set_passive_mode_switch_score, ::unset_passive_mode_switch_score);
  register_relic("_encstr_BD3818C85A92B7788305C8D91D3321537182B8A0B221C312F324", ::init_passive_melee_cone_expl, ::set_passive_melee_cone_expl, ::unset_passive_melee_cone_expl);
  register_relic("_encstr_AC38101C2CE6CD966756FA9859E49B59395B", ::init_passive_berserk, ::set_passive_berserk, ::unset_passive_berserk);
  register_relic("_encstr_9970162B2A3AABB08D1039FB73912DF071D8DD0991ED0328", ::init_passive_infinite_ammo, ::set_passive_infinite_ammo, ::unset_passive_infinite_ammo);
  register_relic("_encstr_B8541ABFDEB367500EE79178933FEBFFAAC9B948738A77DBD01F5878", ::init_passive_crouch_move_speed, ::set_passive_crouch_move_speed, ::unset_passive_crouch_move_speed);
  register_relic("_encstr_9A6B1AC2E10B7FD8E3CAF0D7783F71924F7BB4B913CBEFC08797A350", ::init_passive_fortified, ::set_passive_fortified, ::unset_passive_fortified);
  register_relic("_encstr_BA7D1477167BAF6836AFC9309F7481BFB2BE61776FF2", ::init_passive_cold_damage, ::set_passive_cold_damage, ::unset_passive_cold_damage);
  register_relic("_encstr_9AA60E0785DC6E96CE95FACDEDE6D2D8", ::init_passive_sonic, ::set_passive_sonic, ::unset_passive_sonic);
  register_relic("_encstr_860717E1612260432BBA0E91827B080871EC59B337CE6819CB", ::init_passive_below_the_belt, ::set_passive_below_the_belt, ::unset_passive_below_the_belt);
  register_relic("_encstr_92D51779F94A083B53D296D8FADBE32066409FD961B5D07427", ::init_passive_minimap_damage, ::set_passive_minimap_damage, ::unset_passive_minimap_damage);
  register_relic("_encstr_870E11C116DCB9B43B56F5590F8E4E85BEF083", ::init_extra_xp, ::set_extra_xp, ::unset_extra_xp);
  register_relic("_encstr_A2251382B19BEB02B443FFE3B3DE1B0F28993D4FA9", ::init_passive_fast_melee, ::set_passive_fast_melee, ::unset_passive_fast_melee);
  register_relic("_encstr_ABBA1AB1BDF60EF51C166EDC4B672BAF9BE62CC1F5D17B7D0D2B2C32", ::init_snap_to_head, ::set_snap_to_head, ::unset_snap_to_head);
  register_relic("_encstr_85371B096FDB56B88EA7EEA14D50888BB19BABA93F829541A3FA51B937", ::init_passive_empty_reload_speed, ::set_passive_empty_reload_speed, ::unset_passive_empty_reload_speed);
  register_relic("_encstr_8C971F070BB9375AB356D7D2DC6C9C59C29B2BC8BEE61BF6E0CAEB989CAC164786", ::init_passive_increased_scope_breath, ::set_passive_increased_scope_breath, ::unset_passive_increased_scope_breath);
  register_relic("_encstr_B678161C2C37CD969DB2D743AB37E8CA4EEBD62D36635927", ::init_passive_hunter_killer, ::set_passive_hunter_killer, ::unset_passive_hunter_killer);
  register_relic("_encstr_A21A13072C6E9B4BECCAF5B67BCECAEBE60EACAC19", ::init_passive_move_speed, ::set_passive_move_speed, ::unset_passive_move_speed);
  register_relic("_encstr_83AA1457672B1B79F0EF8785CAC098D09BE7EB8360C2", ::init_passive_miss_refund, ::set_passive_miss_refund, ::unset_passive_miss_refund);
  register_relic("_encstr_8DE5125039C35370684D709BA9776BB3CBB8EDB1", ::init_passive_scoutping, ::set_passive_scoutping, ::unset_passive_scoutping);
  register_relic("_encstr_BAA61250AF73D74CFD20F1CBE80D86678981CDEA", ::init_passive_scrambler, ::set_passive_scrambler, ::unset_passive_scrambler);
  register_relic("_encstr_84D21A2B20CFFA87D3A54F7A4F387B050B39A2E33043B6FBE89D7674", ::init_passive_random_attachment, ::set_passive_random_attachment, ::unset_passive_random_attachment);
  register_relic("_encstr_8CDF143201B05BB224D36FC7C740EB85298BEEBFB910", ::init_passive_scope_radar, ::set_passive_scope_radar, ::unset_passive_scope_radar);
  register_relic("_encstr_A66C1B5F3E5387702EC7B1D8B75F6BD33BE3D66D960A1719E1DF583BB7", ::init_passive_scorestreak_damage, ::set_passive_scorestreak_damage, ::unset_passive_scorestreak_damage);
  register_relic("_encstr_BEB81DE87AB29758A3E52836FB1FE3731A9370D812CC97B1D705CF24D5B749", ::init_passive_scorestreak_damage, ::set_passive_scorestreak_damage, ::unset_passive_scorestreak_damage);
  register_relic("_encstr_8A4411F0F56841AA504338F0B5775B67FBE997", ::init_relic_collat_dmg, ::set_relic_collat_dmg, ::unset_relic_collat_dmg);
  register_relic("_encstr_85320CC0C73C608FB1E68715FE9A", ::init_relic_catch, ::set_relic_catch, ::unset_relic_catch);
  register_relic("_encstr_B4110B428A310A1E697A1A5855", ::init_relic_boom, ::set_relic_boom, ::unset_relic_boom);
  register_relic("_encstr_978E0B0B2BF17CAFF6AE6769C5", ::init_relic_swat, ::set_relic_swat, ::unset_relic_swat);
  register_relic("_encstr_86F812C995C65A1B7D3B6385B9DCC60BE6E67BDC", ::init_relic_glasscannon, ::set_relic_glasscannon, ::unset_relic_glasscannon);
  register_relic("_encstr_B85617BEDF42531127F7505893352BDFBA83BD50B58A1119C5", ::tac_rover_horn, ::_id_130AE, ::_id_13F36);
  register_relic("_encstr_91851193AC36B4B1BE99DEB1D56EBE99B4C9B2", ::tacinsert_destroyuselistener, ::_id_130BC, ::_id_13F42);
  register_relic("_encstr_87FF1830F2BD7BC1CFDC0F71B147494F672B6040C916A59853C5", ::tac_rover_trail, ::_id_130B3, ::_id_13F3B);
  register_relic("_encstr_AB57110667FAEB596F9B286883641037528FF5", ::tacinsert_updatedestroyusability, ::_id_130C3, ::_id_13F49);
  register_relic("_encstr_ACCF10932BC6B46CD7B62C2747CB9391DED6", ::tacmapvo, ::_id_130C7, ::_id_13F4D);
  register_relic("_encstr_A65811E4598D4BC6FAECC2CDBEADB0938E9793", ::tacinsert_gamemode_callback, ::_id_130BD, ::_id_13F43);
  register_relic("_encstr_AB310F55277203A09F1F6318098FF8495A", ::tacinsert_monitorupdatespawnposition, ::_id_130BF, ::_id_13F45);
  register_relic("_encstr_953B150318893927EE09B7F8B5E610BB506A749DF07B83", ::take_intro_items, ::_id_130D6, ::_id_13F5B);
  register_relic("_encstr_BD2C10BA8940492AB8F7CFD73BDD22B1B8D0", ::take, ::_id_130D3, ::_id_13F59);
  register_relic("_encstr_A94A0A272B1BB48DFA32CC16", ::taccover_timeout, ::_id_130B4, ::_id_13F3C);
  register_relic("_encstr_A33312C80A45B309170343CBED23114F6D22B028", ::taillightright, ::_id_130D2, ::_id_13F58);
  register_relic("_encstr_88690D687775E32B3FCF9BDC6209F7", ::tactical_boxes, ::_id_130C8, ::_id_13F4E);
  register_relic("_encstr_A7AA0CE456D85A36D72CB6C1AC32", ::tac_rover_initdamage, ::_id_130B1, ::_id_13F39);
  register_relic("_encstr_8B3E125DE341E3C751ED20DF83CA2802C296A7D2", ::take_time_away_from_bomb_vest_timer, ::_id_130D7, ::_id_13F5C);
  register_relic("_encstr_8DB60EF379E17F0619219F9FE90BCFEF", ::taccovertriggerblockers, ::_id_130B5, ::_id_13F3D);
  register_relic("_encstr_B4A10EF6970A1BA99F0B28C037F4214B", ::tacinserts, ::_id_130C5, ::_id_13F4B);
  register_relic("_encstr_AB6A0E5637AABB093FFB1868D75761F5", ::tacinsert_tacinsertdestroyedfeedback, ::_id_130C2, ::_id_13F48);
  register_relic("_encstr_974A0E63E971EF96A9931818A958DD0F", ::tacinsert_deleteontoofar, ::_id_130BA, ::_id_13F40);
  register_relic("_encstr_B2E010935663D26CEBCC85E6D13136562B46", ::tacinsert_destroyongameended, ::_id_130BB, ::_id_13F41);
  register_relic("_encstr_99DB1072CB605C87A0D84B92810DE715708D", ::tagautopickup, ::_id_130CE, ::_id_13F54);
  register_relic("_encstr_A59F1027B2B196D8BE23B75D131B598E0B83", ::tacinsert_cachespawnposition, ::_id_130B7, ::_id_13F3F);
  register_relic("_encstr_9ACF0E321D6922DB56704F6758C882AA", ::takelaststandtransitionweapon, ::_id_130D9, ::_id_13F5E);
  register_relic("_encstr_B194129C95B196D87DA1CA581B47A1C158B1B6CD", ::tacinsert_pickuplistener, ::_id_130C1, ::_id_13F47);
  register_relic("_encstr_93630E3BBB99924BD8ED9092AD50DDCA", ::tag_usb_with_head_icon, ::_id_130CD, ::_id_13F53);
  register_relic("_encstr_84F20B73F09ADB1AF630A80AA3", ::tag_convoy_with_objectives, ::_id_130CB, ::_id_13F51);
  register_relic("_encstr_9305126B8828C19A0F8065117F03329F1660CF93", ::tactical_crate_spawn, ::_id_130C9, ::_id_13F4F);
  register_relic("_encstr_B64A0A43D0044B92A7193BF0", ::tacmapexplanation, ::_id_130C6, ::_id_13F4C);
  register_relic("_encstr_BACF15FD7D0D58BE7712D07B7B23653162D87F79E73328", undefined, ::_id_1308D, ::_id_13F2C);
  register_relic("_encstr_8DC71465E56530C60F7A48D3C38B8DC9FA76DB198D4A", undefined, ::_id_1308E, ::_id_13F2D);
  register_relic("_encstr_AA0E184047BCE00F31E60395F89B5B6E0ACF20E8F74038CB2ACF", undefined, ::_id_1308B, ::_id_13F2A);
  register_relic("_encstr_B6301B9635BBDBF788EF8F6863EA750F08631996D068C8D2227296FD2B", undefined, ::_id_1308F, ::_id_13F2E);
  register_relic("_encstr_B462110B2BF17CAFF6A7797C43FB7F093540C2", undefined, ::_id_1308C, ::_id_13F2B);
  register_relic("_encstr_841615E25BF0CC1730893AF392FF4709E01D6577CD1057", undefined, ::_id_1308A, ::_id_13F30);
  register_relic("_encstr_9180142E7DAB30E7F10A384832999BA8E3DFBE28DF77", ::tac_rover_initomnvars, ::_id_130B2, ::_id_13F3A);
  register_relic("_encstr_93050D6B8828C19A0F8065DD751F52", ::tag_to_shoot_from, ::_id_130CC, ::_id_13F52);
  register_relic("_encstr_858811B3AA4B43E8398C3F07BD1AD81F47C2CB", ::tacinsert_brrespawnsplash, ::_id_130B6, ::_id_13F3E);
  register_relic("_encstr_A99212F5751540B67F7A59C1A25375A0ADCD716F", ::tacinsert_onjoinedteam, ::_id_130C0, ::_id_13F46);
  register_relic("_encstr_87FC1730F2BD7BC1CFCA0876BB4F6B4F249A7848C916BBD837", ::taillightleft, ::_id_130D1, ::_id_13F57);
  register_relic("_encstr_B2C5134047BCE00F31A20D987E1A552B14DB70E8F7", ::tagtaken, ::_id_130D0, ::_id_13F56);
  register_relic("_encstr_A76A0FC9AC1BB46CBE76C9DBD57319AC23", ::tacinsert_getspawnposition, ::_id_130BE, ::_id_13F44);
  register_relic("_encstr_B6950E5DDDADF81ED7525039BA33C3E8", ::tags_used, ::_id_130CF, ::_id_13F55);
  register_relic("_encstr_85E810233ADBD378893493AF34EA88AFAB42", ::tacinsert_updatepickupusability, ::_id_130C4, ::_id_13F4A);
  register_relic("_encstr_966E11739030A9F27776CB875529DA699840FF", ::take_ai_weapon, ::_id_130D4, ::_id_13F5A);
  register_relic("_encstr_A96B159CB2C62DB17DCDED4C5D63B156478CC2B558CE56", ::tactical_goal_in_action_thread, ::_id_130CA, ::_id_13F50);
  register_relic("_encstr_AB4E114E59635A1BBEC2D6D6DB7D19E42CD2B9", ::tac_rover_initcollision, ::_id_130B0, ::_id_13F38);
  register_relic("_encstr_92AB0B5575BCD71B5F6C8A3FE0", ::takeaccesscardpickup, ::_id_130D8, ::_id_13F5D);
  level.select_bridge_three_spawners = [];
  level.select_bridge_three_spawners["_encstr_84F20B73F09ADB1AF630A80AA3"] = ::setupcirclepeek;
  level.select_bridge_three_spawners["_encstr_9305126B8828C19A0F8065117F03329F1660CF93"] = ::setup_comms_obj_b_goals_and_cover;
  level.select_bridge_three_spawners["_encstr_B64A0A43D0044B92A7193BF0"] = ::setup_wave_spawn_zone_disable;
  level.select_bridge_three_spawners["_encstr_91851193AC36B4B1BE99DEB1D56EBE99B4C9B2"] = ::setup_train_entarray;
  level.select_bridge_three_spawners["_encstr_88690D687775E32B3FCF9BDC6209F7"] = ::setupbrsquadleader;
  level.select_bridge_three_spawners["_encstr_A94A0A272B1BB48DFA32CC16"] = ::setup_next_advance;
  level.select_bridge_three_spawners["_encstr_978E0B0B2BF17CAFF6AE6769C5"] = ::getgamewinnerfunc;
  level.select_bridge_three_spawners["_encstr_BACF15FD7D0D58BE7712D07B7B23653162D87F79E73328"] = ::complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["_encstr_8DC71465E56530C60F7A48D3C38B8DC9FA76DB198D4A"] = ::complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["_encstr_AA0E184047BCE00F31E60395F89B5B6E0ACF20E8F74038CB2ACF"] = ::complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["_encstr_B6301B9635BBDBF788EF8F6863EA750F08631996D068C8D2227296FD2B"] = ::complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["_encstr_B462110B2BF17CAFF6A7797C43FB7F093540C2"] = ::complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["_encstr_841615E25BF0CC1730893AF392FF4709E01D6577CD1057"] = ::complete_vault_assault_retrieve_saw;
  level.select_bridge_three_spawners["_encstr_953B150318893927EE09B7F8B5E610BB506A749DF07B83"] = ::select_boss_one_spawners;
  level.select_bridge_three_spawners["_encstr_AB57110667FAEB596F9B286883641037528FF5"] = ::select_back_one_spawners;
  level.select_bridge_three_spawners["_encstr_B194129C95B196D87DA1CA581B47A1C158B1B6CD"] = ::_id_12B79;
  level.select_bridge_three_spawners["_encstr_9ACF0E321D6922DB56704F6758C882AA"] = ::_id_12BAE;
  level.select_bridge_three_spawners["_encstr_BD2C10BA8940492AB8F7CFD73BDD22B1B8D0"] = ::select_back_two_spawners;
  level.select_bridge_three_spawners["_encstr_A7AA0CE456D85A36D72CB6C1AC32"] = ::select_back_door_spawners;
  level.onkillrelics = [];
  level.onkillrelics["_encstr_8FB50D70DF03A73C8D70A1AAE8EF77"] = ::trackkillsforpassivenuke;
  level.onkillrelics["_encstr_B2E31583169BE62DCECA7DE4853732F66BF5C1954EADDC"] = ::trackkillsforrandomperks;
  level.onkillrelics["_encstr_81191963AE660F2B43C5FEEBD11A55771582AE077569164BF8C3B3"] = ::dolocalrailgundamage;
  level.onkillrelics["_encstr_B1B416EF8EE337E0BE5741F03FC1196FFAB565E066FAC3E8"] = ::handleheadshotammopassive;
  level.onkillrelics["_encstr_A1B417F36FC3E3F8E8392181E7CFB1C7ECF88BC01FD3128DFB"] = ::addvaluetocardmeter;
  level.onkillrelics["_encstr_882510FBE1AF90230359E05D5B6BA39AF8D3"] = ::handlepassiverefresh;
  level.onkillrelics["_encstr_82211B13A0AF7302EB45F1C2C7FB4E143BEFECCB31A8EF388FD2F89661"] = ::doublekillreloadwatcher;
  level.onkillrelics["_encstr_82680D7017DBABB168A7569FF71B8F"] = ::handlegorepassive;
  level.onkillrelics["_encstr_9AD01DB21F5783D173E8B773F0C99CBBD9B8BA6FF4938ADF78D8BF77B88044"] = ::handlehealthregenonkillpassive;
  level.onkillrelics["_encstr_8C331B382CE6DC5A67B27DB6DECEB2D7B938CA2B8CEBDB9BAFAD9663D8"] = ::handlemovespeedonkillpassive;
  level.onkillrelics["_encstr_ABDF0FC1A7139E60466FD648142C08DF9A"] = ::handlehitmanpassive;
  level.onkillrelics["_encstr_8BB412484FBBAB13DBEFAF11C75243D11BC73020"] = ::handlemeleekillpassive;
  level.onkillrelics["_encstr_AC3217188A42478873D5188BAD575001ECF16850C19C8BE033"] = ::handlehealthonkillpassive;
  level.onkillrelics["_encstr_818B1838856ECD96CE59F563B037E8EBE634ED1D9B7D0BDAB6F6"] = ::handleammoonlastshotskill;
  level.onkillrelics["_encstr_A97D19C1124AC801CBCAA11BDB2F67F3699191C42AA0E8DBCBB7AA"] = ::handlevisordetonation;
  level.onkillrelics["_encstr_8E341458E00BFEB99ED8AFEA7FA93F33987B13D85D2E"] = ::handlemeleesuper;
  level.onkillrelics["_encstr_A56B1383FFFEBB196C3D36902B8DE080372512F7BB"] = ::handleairbornesuper;
  level.onkillrelics["_encstr_91B81A38C2DC9B5A9D2BF591B7AE4CC6ACBEDA4B8DB1D7CD5DE0959C"] = ::handledoublekillssuper;
  level.onkillrelics["_encstr_BD3818C85A92B7788305C8D91D3321537182B8A0B221C312F324"] = ::handlemeleeconeexplode;
  level.onkillrelics["_encstr_AC38101C2CE6CD966756FA9859E49B59395B"] = ::handleberserk;
  level.onkillrelics["_encstr_A5630EE0859BDCD26756F5E6A5DC532C"] = ::handleammoonlastshotskill;
  level.onkillrelics["_encstr_B2C5134047BCE00F31A20D987E1A552B14DB70E8F7"] = ::setupblueprintpickupweapons;
  level.onkillrelics["_encstr_A99212F5751540B67F7A59C1A25375A0ADCD716F"] = ::setup_trap_consoles;
  level.onkillrelics["_encstr_87FC1730F2BD7BC1CFCA0876BB4F6B4F249A7848C916BBD837"] = ::setuphumanpowers;
  level.onkillrelics["_encstr_966E11739030A9F27776CB875529DA699840FF"] = ::setupboardroomcode;
  level.onkillrelics["_encstr_8A4411F0F56841AA504338F0B5775B67FBE997"] = ::handlereliccollatdamage;
  level.onkillrelics["_encstr_85320CC0C73C608FB1E68715FE9A"] = ::handlereliccatch;
  level.onkillrelics["_encstr_B4110B428A310A1E697A1A5855"] = ::handlerelicboom;
  level.onkillrelics["_encstr_ACCF10932BC6B46CD7B62C2747CB9391DED6"] = ::setuphelitimer;
  level.onkillrelics["_encstr_A65811E4598D4BC6FAECC2CDBEADB0938E9793"] = ::setuphqs;
  level.onkillrelics["_encstr_A33312C80A45B309170343CBED23114F6D22B028"] = ::setuphudelemninfilblack;
  level.onkillrelics["_encstr_B194129C95B196D87DA1CA581B47A1C158B1B6CD"] = ::_id_12B7A;
  level.onkillrelics["_encstr_A7AA0CE456D85A36D72CB6C1AC32"] = ::setupglobalkillcount;
  level.persistentrelics = [];
  level.persistentrelics["_encstr_9970162B2A3AABB08D1039FB73912DF071D8DD0991ED0328"] = ::handleinfiniteammopassive;
  level.persistentrelics["_encstr_8896120E16B9DC4BCE56FA33F693E8963396B223"] = ::handlefortified;
  level.persistentrelics["_encstr_AB57110667FAEB596F9B286883641037528FF5"] = ::setupdom;
  level.persistentrelics["_encstr_953B150318893927EE09B7F8B5E610BB506A749DF07B83"] = ::setupdomplates;
  level.persistentrelics["_encstr_AB310F55277203A09F1F6318098FF8495A"] = ::setupdogtags;
  register_relic("_encstr_8A7D1756A3208B185190403773E15A87B793E9E08733F9C8EF", undefined, ::_id_13099, ::_id_13F34);
  level.persistentrelics["_encstr_8A7D1756A3208B185190403773E15A87B793E9E08733F9C8EF"] = ::setup_bot_flag;
  level.ondamagerelics = [];
  level.ondamagerelics["_encstr_9AA60E0785DC6E96CE95FACDEDE6D2D8"] = ::handlepassivesonic;
  level.ondamagerelics["_encstr_92D51779F94A083B53D296D8FADBE32066409FD961B5D07427"] = ::updatepassiveminimapdamage;
  level.ondamagerelics["_encstr_BA7D1477167BAF6836AFC9309F7481BFB2BE61776FF2"] = ::updatepassivecolddamage;
  level.ondamagerelics["_encstr_978E0B0B2BF17CAFF6AE6769C5"] = ::handlerelicswat;
  level.ondamagerelics["_encstr_8A4411F0F56841AA504338F0B5775B67FBE997"] = ::_id_12016;
  level.ondamagerelics["_encstr_9ACF0E321D6922DB56704F6758C882AA"] = ::_id_1201D;
  level.ondamagerelics["_encstr_B64A0A43D0044B92A7193BF0"] = ::_id_1201A;
  level.ondamagerelics["_encstr_91851193AC36B4B1BE99DEB1D56EBE99B4C9B2"] = ::_id_12018;
  level.ondamagerelics["_encstr_87FF1830F2BD7BC1CFDC0F71B147494F672B6040C916A59853C5"] = ::_id_12019;
  level.ondamagerelics["_encstr_966E11739030A9F27776CB875529DA699840FF"] = ::_id_1201C;
  level.ondamagerelics["_encstr_858811B3AA4B43E8398C3F07BD1AD81F47C2CB"] = ::_id_12017;
  level.ondamagerelics["_encstr_BD2C10BA8940492AB8F7CFD73BDD22B1B8D0"] = ::_id_1201B;
  level.ondamagerelics["_encstr_A96B159CB2C62DB17DCDED4C5D63B156478CC2B558CE56"] = ::_id_12B87;
  level._id_12015 = [];
  level._id_12015["_encstr_91851193AC36B4B1BE99DEB1D56EBE99B4C9B2"] = ::_id_12014;
  level._id_12020 = [];
  level._id_12020["_encstr_9180142E7DAB30E7F10A384832999BA8E3DFBE28DF77"] = ::_id_12B6D;
}

load_relic_combos_from_table() {
  var_0 = "_encstr_83681797EB3F578FCEFE92DBA3AE17B247F815055BDED10E3B";
  var_1 = [];

  for(var_2 = 1; var_2 <= 10; var_2++) {
    var_3 = table_look_up(var_0, var_2, 1);

    if(var_3 == "_encstr_B40101") {
      continue;
    }
    var_1[var_2 - 1] = spawnStruct();
    var_1[var_2 - 1].scomboname = table_look_up(var_0, var_2, 1);
    var_1[var_2 - 1].srelicref1 = table_look_up(var_0, var_2, 2);
    var_1[var_2 - 1].srelicref2 = table_look_up(var_0, var_2, 3);
    var_1[var_2 - 1].srelicref3 = table_look_up(var_0, var_2, 4);
    var_1[var_2 - 1].srelicref4 = table_look_up(var_0, var_2, 5);
    var_1[var_2 - 1].srelicref5 = table_look_up(var_0, var_2, 6);
    var_1[var_2 - 1].srelicref6 = table_look_up(var_0, var_2, 7);
  }

  return var_1;
}

table_look_up(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, var_1, var_2);
}

init_passive_random_attachment(var_0) {
  var_1 = getweaponswithpassive(var_0, "_encstr_84D21A2B20CFFA87D3A54F7A4F387B050B39A2E33043B6FBE89D7674");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = scripts\cp\utility::getrawbaseweaponname(var_4);
    var_6 = scripts\cp\utility::getweaponrootname(var_4);
    var_7 = scripts\cp\utility::getweaponcamo(var_6);
    var_8 = scripts\cp\utility::getweaponcosmeticattachment(var_6);
    var_9 = scripts\cp\utility::getweaponreticle(var_6);
    var_10 = scripts\cp\utility::getweaponpaintjobid(var_6);
    var_0.weapon_build_models[var_5] = scripts\cp\utility::mpbuildweaponname(var_6, var_2, var_7, var_9, scripts\cp\utility::get_weapon_variant_id(var_0, var_4), self getentitynumber(), self.clientid, var_10, var_8);
  }
}

set_passive_random_attachment(var_0) {}

unset_passive_random_attachment(var_0) {}

getweaponswithpassive(var_0, var_1) {
  var_2 = [];
  var_3 = getarraykeys(var_0.weapon_passives);

  foreach(var_5 in var_3) {
    for(var_6 = 0; var_6 < var_0.weapon_passives[var_5].size; var_6++) {
      if(var_0.weapon_passives[var_5][var_6].name == var_1)
        var_2[var_2.size] = var_5;
    }
  }

  var_2 = scripts\engine\utility::array_remove_duplicates(var_2);
  return var_2;
}

init_passive_fast_melee(var_0) {}

set_passive_fast_melee(var_0) {
  var_0.increased_melee_damage = 150;
}

unset_passive_fast_melee(var_0) {
  var_0.increased_melee_damage = undefined;
}

init_extra_xp(var_0) {
  var_0.weapon_passive_xp_multiplier = 1;
  var_0.kill_with_extra_xp_passive = 0;
}

set_extra_xp(var_0) {
  var_0.weapon_passive_xp_multiplier = 1.25;
}

unset_extra_xp(var_0) {
  var_0.weapon_passive_xp_multiplier = 1;
  var_0.kill_with_extra_xp_passive = 0;
}

init_passive_below_the_belt(var_0) {
  var_0.crotch_damage_multiplier = undefined;
}

set_passive_below_the_belt(var_0) {
  var_0.crotch_damage_multiplier = 3.75;
}

unset_passive_below_the_belt(var_0) {
  var_0.crotch_damage_multiplier = undefined;
}

init_passive_move_speed(var_0) {
  var_0.weapon_passive_xp_multiplier = 1;
}

set_passive_move_speed(var_0) {
  var_0.weaponpassivespeedmod = 0.05;
  var_0[[level.move_speed_scale]]();
}

unset_passive_move_speed(var_0) {
  var_0.weaponpassivespeedmod = undefined;
  var_0[[level.move_speed_scale]]();
}

init_passive_empty_reload_speed(var_0) {}

set_passive_empty_reload_speed(var_0) {
  var_0 scripts\cp\utility::_setperk("_encstr_A1C71BE233105BA29FF1F3FFAF34EA83409B9FAD4898E499E59BEBC30B");
}

unset_passive_empty_reload_speed(var_0) {
  var_0 scripts\cp\utility::_unsetperk("_encstr_A1C71BE233105BA29FF1F3FFAF34EA83409B9FAD4898E499E59BEBC30B");
}

init_passive_increased_scope_breath(var_0) {}

set_passive_increased_scope_breath(var_0) {
  var_0 scripts\cp\utility::_setperk("_encstr_9B6915EB59CA09FC17D103B1E7724884FCEA9643F7356A");
}

unset_passive_increased_scope_breath(var_0) {
  var_0 scripts\cp\utility::_unsetperk("_encstr_9B6915EB59CA09FC17D103B1E7724884FCEA9643F7356A");
}

init_snap_to_head(var_0) {}

set_snap_to_head(var_0) {
  var_0 scripts\cp\utility::_setperk("_encstr_B6CC163738AC364B85D81DF2AF58D547B70BA5AD342B0B19");
}

unset_snap_to_head(var_0) {
  var_0 scripts\cp\utility::_unsetperk("_encstr_B6CC163738AC364B85D81DF2AF58D547B70BA5AD342B0B19");
}

init_passive_hunter_killer(var_0) {
  self.hunterkilleroutlines = 0;
}

set_passive_hunter_killer(var_0) {
  self endon("_encstr_A16C1D50AF73D74CFD20F17A5835C3478B18C3F1B1F8F7D287381A12C00BBD");
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  thread updatehunterkillerplayers(var_1);
  thread hunterkillerlistenforconnect();

  foreach(var_0 in var_1) {
    thread hunterkillerlistenfordisconnect(var_0);
    thread hunterkillerlistenfordamage(var_0);
  }
}

unset_passive_hunter_killer(var_0) {
  self notify("_encstr_A16C1D50AF73D74CFD20F17A5835C3478B18C3F1B1F8F7D287381A12C00BBD");

  foreach(var_2 in self.hunterkillerids) {
    var_0 = self.hunterkillerents[var_2];
    scripts\cp\cp_outline::disable_outline_for_players(var_0, level.players);
  }

  self.hunterkillerids = undefined;
  self.hunterkillerents = undefined;
}

updatehunterkillerplayers(var_0) {
  if(!isDefined(self.hunterkillerids))
    self.hunterkillerids = [];

  if(!isDefined(self.hunterkillerents))
    self.hunterkillerents = [];

  foreach(var_2 in var_0) {
    if(var_2 == self || !isDefined(self) || !isDefined(self.team) || !isDefined(var_2) || !isDefined(var_2.team)) {
      continue;
    }
    var_3 = gethunterkillerid(var_2);

    if(level.teambased && self.team != var_2.team && var_2.health / var_2.maxhealth <= 0.5 && var_2.health > 0) {
      if(var_3 < 0) {
        self.hunterkilleroutlines++;
        scripts\cp\cp_outline::enable_outline_for_player(var_2, self, 1, 0, 1, "_encstr_9ACC05B41B7F32");
        var_4 = self.hunterkilleroutlines;
        self.hunterkillerids[self.hunterkillerids.size] = var_4;
        self.hunterkillerents[var_4] = var_2;
        thread hunterkillerlistenforhealth(var_2);
      }

      continue;
    }

    if(var_3 >= 0) {
      var_5 = [];
      var_6 = [];
      scripts\cp\cp_outline::disable_outline_for_player(var_2, self);

      foreach(var_4 in self.hunterkillerids) {
        var_8 = self.hunterkillerents[var_4];

        if(var_8 == var_2) {
          continue;
        }
        var_5[var_5.size] = var_4;
        var_6[var_4] = var_8;
      }

      self.hunterkillerids = var_5;
      self.hunterkillerents = var_6;
      var_2 notify("_encstr_B662249BBB2B470B6EF7D0CBA59A5B81A88F62333508DF40599D506B3B27C3E87109CD68758D");
    }
  }
}

hunterkillerlistenforhealth(var_0) {
  self endon("_encstr_A16C1D50AF73D74CFD20F17A5835C3478B18C3F1B1F8F7D287381A12C00BBD");
  var_0 endon("_encstr_B662249BBB2B470B6EF7D0CBA59A5B81A88F62333508DF40599D506B3B27C3E87109CD68758D");

  for(;;) {
    wait 1.0;
    thread updatehunterkillerplayer(var_0);
  }
}

gethunterkillerid(var_0) {
  if(!isDefined(self.hunterkillerids) || !isDefined(self.hunterkillerents))
    return -1;

  foreach(var_2 in self.hunterkillerids) {
    var_3 = self.hunterkillerents[var_2];

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 == var_0)
      return var_2;
  }

  return -1;
}

hunterkillerlistenforconnect() {
  self endon("_encstr_A16C1D50AF73D74CFD20F17A5835C3478B18C3F1B1F8F7D287381A12C00BBD");

  for(;;) {
    level waittill("_encstr_A62B0E0EE493BA148EF0B3FF3840FDE2", var_0);
    thread updatehunterkillerplayer(var_0);
    thread hunterkillerlistenfordamage(var_0);
  }
}

hunterkillerlistenfordisconnect(var_0) {
  self endon("_encstr_A16C1D50AF73D74CFD20F17A5835C3478B18C3F1B1F8F7D287381A12C00BBD");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  thread updatehunterkillerplayer(var_0);
}

hunterkillerlistenfordamage(var_0) {
  self endon("_encstr_A16C1D50AF73D74CFD20F17A5835C3478B18C3F1B1F8F7D287381A12C00BBD");

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    thread updatehunterkillerplayer(var_0);
  }
}

updatehunterkillerplayer(var_0) {
  var_1 = [];
  var_1[var_1.size] = var_0;
  thread updatehunterkillerplayers(var_1);
}

init_passive_refresh(var_0) {
  var_0.nextpassiverefreshkills = 0;
}

set_passive_refresh(var_0) {
  var_0.onkillrelics["_encstr_882510FBE1AF90230359E05D5B6BA39AF8D3"] = 1;
}

unset_passive_refresh(var_0) {
  var_0.onkillrelics["_encstr_882510FBE1AF90230359E05D5B6BA39AF8D3"] = 0;
}

handlepassiverefresh(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1.nextpassiverefreshkills++;

  if(var_1.nextpassiverefreshkills >= 50) {
    if(isDefined(level.power_adjustcharges))
      var_1[[level.power_adjustcharges]](undefined, "_encstr_BA7F0830B3A7859B60B0", 1);

    var_1.nextpassiverefreshkills = 0;
  }
}

init_passive_double_kill_reload(var_0) {}

set_passive_double_kill_reload(var_0) {
  var_0.onkillrelics["_encstr_82211B13A0AF7302EB45F1C2C7FB4E143BEFECCB31A8EF388FD2F89661"] = 1;
}

unset_passive_double_kill_reload(var_0) {
  var_0.onkillrelics["_encstr_82211B13A0AF7302EB45F1C2C7FB4E143BEFECCB31A8EF388FD2F89661"] = 0;
}

doublekillreloadwatcher(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_1.recentkillcount >= 4) {
    var_0 = var_1 getcurrentweapon();
    var_6 = weaponclipsize(var_0);
    var_7 = var_1 getweaponammostock(var_0);
    var_8 = var_1 getweaponammoclip(var_0);
    var_9 = min(var_6 - var_8, var_7);
    var_10 = min(var_8 + var_9, var_6);
    var_1 setweaponammoclip(var_0, int(var_10));
    var_1 setweaponammostock(var_0, int(var_7 - var_9));

    if(var_1 isdualwielding()) {
      var_7 = var_1 getweaponammostock(var_0);
      var_8 = var_1 getweaponammoclip(var_0, "_encstr_A5AD056A019C63");
      var_9 = min(var_6 - var_8, var_7);
      var_10 = min(var_8 + var_9, var_6);
      var_1 setweaponammoclip(var_0, int(var_10), "_encstr_A5AD056A019C63");
      var_1 setweaponammostock(var_0, int(var_7 - var_9));
    }
  }
}

init_passive_melee_kill(var_0) {
  var_0.passive_melee_kill_damage = 0;
}

set_passive_melee_kill(var_0) {
  var_0.skip_weapon_check = 1;
  var_0.passive_melee_kill_damage = 1000;
  var_0.onkillrelics["_encstr_8BB412484FBBAB13DBEFAF11C75243D11BC73020"] = 1;
}

unset_passive_melee_kill(var_0) {
  var_0.skip_weapon_check = undefined;
  var_0.passive_melee_kill_damage = 0;
  var_0.onkillrelics["_encstr_8BB412484FBBAB13DBEFAF11C75243D11BC73020"] = 0;
}

handlemeleekillpassive(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(var_3 != "_encstr_8DED0A21C79B660BC7588981") {
    return;
  }
  level thread handlegoreeffect(var_2);
  wait 0.05;
  var_6 = var_2 getcorpseentity();

  if(isDefined(var_6)) {
    var_6 hide();
    var_6.permhidden = 1;
  }
}

handlegoreeffect(var_0) {
  var_1 = var_0 gettagorigin("_encstr_8EEC09159F6238030BFA23");
  playFX(level._effect["_encstr_AF72050FB0BB23"], var_1, (1, 0, 0));
  playsoundatpos(var_1, "_encstr_92B30D6F234A09E94D1C433D9841E8");

  foreach(var_3 in level.players)
  var_3 earthquakeforplayer(0.5, 1.5, var_1, 120);
}

init_passive_gore(var_0) {}

set_passive_gore(var_0) {
  var_0.onkillrelics["_encstr_82680D7017DBABB168A7569FF71B8F"] = 1;
}

unset_passive_gore(var_0) {
  var_0.onkillrelics["_encstr_82680D7017DBABB168A7569FF71B8F"] = 0;
}

handlegorepassive(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 endon("_encstr_84160AF443884D23A8099AF3");
  wait 0.05;
  var_6 = var_2 getcorpseentity();

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = var_6.origin;
  earthquake(0.5, 1.5, var_7, 120);
  playFX(level._effect["_encstr_AFD50B33308AD86FA2AF2B1F53"], var_7 + (0, 0, 12));

  if(isDefined(var_6)) {
    var_6 hide();
    var_6.permhidden = 1;
  }
}

init_passive_health_on_kill(var_0) {
  var_0.passive_regen_on_kill_count = 0;
}

set_passive_health_on_kill(var_0) {
  var_0.onkillrelics["_encstr_AC3217188A42478873D5188BAD575001ECF16850C19C8BE033"] = 1;
}

unset_passive_health_on_kill(var_0) {
  var_0.onkillrelics["_encstr_AC3217188A42478873D5188BAD575001ECF16850C19C8BE033"] = 0;
}

handlehealthonkillpassive(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1.passive_regen_on_kill_count++;

  if(var_1.passive_regen_on_kill_count >= 2) {
    var_1 notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
    var_1.passive_regen_on_kill_count = 0;
  }
}

init_passive_health_regen_on_kill(var_0) {
  var_0.passive_regen_on_kill_count = 0;
}

set_passive_health_regen_on_kill(var_0) {
  var_0.onkillrelics["_encstr_9AD01DB21F5783D173E8B773F0C99CBBD9B8BA6FF4938ADF78D8BF77B88044"] = 1;
}

unset_passive_health_regen_on_kill(var_0) {
  var_0.onkillrelics["_encstr_9AD01DB21F5783D173E8B773F0C99CBBD9B8BA6FF4938ADF78D8BF77B88044"] = 0;
}

handlehealthregenonkillpassive(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_1.passive_regen_on_kill_count >= 2) {
    var_1 notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
    var_1.passive_regen_on_kill_count = 0;
  } else
    var_1.passive_regen_on_kill_count++;
}

init_passive_move_speed_on_kill(var_0) {
  var_0.weaponpassivespeedonkillmod = 0;
}

set_passive_move_speed_on_kill(var_0) {
  var_0.onkillrelics["_encstr_8C331B382CE6DC5A67B27DB6DECEB2D7B938CA2B8CEBDB9BAFAD9663D8"] = 1;
}

unset_passive_move_speed_on_kill(var_0) {
  var_0.onkillrelics["_encstr_8C331B382CE6DC5A67B27DB6DECEB2D7B938CA2B8CEBDB9BAFAD9663D8"] = 0;
}

handlemovespeedonkillpassive(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "_encstr_8C331B382CE6DC5A67B27DB6DECEB2D7B938CA2B8CEBDB9BAFAD9663D8";
  var_1 notify(var_6);
  var_1 endon(var_6);

  if(var_1.weaponpassivespeedonkillmod != 0.075) {
    var_1.weaponpassivespeedonkillmod = 0.075;
    var_1[[level.move_speed_scale]]();
  }

  var_1 scripts\engine\utility::_id_143BA(5, "_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_1)) {
    return;
  }
  var_1.weaponpassivespeedonkillmod = 0;
  var_1[[level.move_speed_scale]]();
}

init_passive_score_bonus_kills(var_0) {}

set_passive_score_bonus_kills(var_0) {
  var_0.cash_scalar = var_0.cash_scalar + 0.1;
  var_0.cash_scalar_weapon = scripts\cp\utility::getrawbaseweaponname(var_0 getcurrentweapon());
}

unset_passive_score_bonus_kills(var_0) {
  var_0.cash_scalar = var_0.cash_scalar - 0.1;
  var_0.cash_scalar_weapon = undefined;
}

init_passive_hitman(var_0) {}

set_passive_hitman(var_0) {
  var_0.onkillrelics["_encstr_ABDF0FC1A7139E60466FD648142C08DF9A"] = 1;
}

unset_passive_hitman(var_0) {
  var_0.onkillrelics["_encstr_ABDF0FC1A7139E60466FD648142C08DF9A"] = 0;
}

handlehitmanpassive(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !var_1 scripts\cp_mp\utility\player_utility::_isalive() || !isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1.hitmankills))
    var_1.hitmankills = [];
  else if(hitmankeyexists(var_1, var_2.birthtime)) {
    return;
  }
  var_1 thread resethitmanaftertimeout();
  var_1.hitmankills[var_1.hitmankills.size] = var_2.birthtime;

  if(var_1.hitmankills.size >= 10) {
    var_1 notify("_encstr_9612128A50880F9BA013BA8C230926ABA76B4212", 200);
    var_1.hitmankills = [];
  }
}

resethitmanaftertimeout() {
  self notify("_encstr_A3B50FC4F078B5C2F877131F6B156AE520");
  self endon("_encstr_A3B50FC4F078B5C2F877131F6B156AE520");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 10;
  self.hitmankills = [];
}

hitmankeyexists(var_0, var_1) {
  if(!isDefined(var_0.hitmankills))
    return 0;

  foreach(var_3 in var_0.hitmankills) {
    if(var_3 == var_1)
      return 1;
  }

  return 0;
}

hitmanpassivedeathwatcher() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  self.hitmankills = undefined;
}

init_passive_nuke(var_0) {
  var_0.passivenukekillcount = 0;
  var_0.lastpassivenukeactivation = 0;
  var_0 thread tracklaststandforpassivenuke(var_0);
}

set_passive_nuke(var_0) {
  var_0.onkillrelics["_encstr_8FB50D70DF03A73C8D70A1AAE8EF77"] = 1;
}

unset_passive_nuke(var_0) {
  var_0.onkillrelics["_encstr_8FB50D70DF03A73C8D70A1AAE8EF77"] = 0;
}

trackkillsforpassivenuke(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1.passivenukekillcount++;

  if(var_1.passivenukekillcount >= 3) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
    var_6 thread scripts\cp\utility::delayentdelete(10);
    var_7 = scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08");
    var_8 = 0;

    foreach(var_10 in var_7)
    var_10 kill();

    var_1.passivenukekillcount = 0;
  }
}

tracklaststandforpassivenuke(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
    var_0.passivenukekillcount = 0;
  }
}

init_headshot_ammo(var_0) {}

set_headshot_ammo(var_0) {
  var_0.onkillrelics["_encstr_B1B416EF8EE337E0BE5741F03FC1196FFAB565E066FAC3E8"] = 1;
}

unset_headshot_ammo(var_0) {
  var_0.onkillrelics["_encstr_B1B416EF8EE337E0BE5741F03FC1196FFAB565E066FAC3E8"] = 0;
}

handleheadshotammopassive(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !isDefined(var_0)) {
    return;
  }
  if(!scripts\cp\utility::isheadshot(var_0, var_4, var_3, var_1)) {
    return;
  }
  var_6 = weaponclipsize(var_0);
  adjust_clip_ammo_from_stock(var_1, var_0, "_encstr_8253060E2B5FE330", var_6);

  if(var_1 isdualwielding())
    adjust_clip_ammo_from_stock(var_1, var_0, "_encstr_A5AD056A019C63", var_6);
}

adjust_clip_ammo_from_stock(var_0, var_1, var_2, var_3) {
  var_4 = var_0 getweaponammostock(var_1);

  if(var_4 < 1) {
    return;
  }
  var_5 = var_0 getweaponammoclip(var_1, var_2);
  var_6 = var_3 - var_5;

  if(var_4 >= var_6)
    var_0 setweaponammostock(var_1, var_4 - var_6);
  else {
    var_6 = var_4;
    var_0 setweaponammostock(var_1, 0);
  }

  var_7 = min(var_5 + var_6, var_3);
  var_0 setweaponammoclip(var_1, int(var_7), var_2);
}

init_passive_fortified(var_0) {
  var_0.has_fortified_passive = 0;
}

set_passive_fortified(var_0) {
  var_0.persistentrelics["_encstr_8896120E16B9DC4BCE56FA33F693E8963396B223"] = 1;
  var_0.has_fortified_passive = 1;
}

unset_passive_fortified(var_0) {
  var_0.persistentrelics["_encstr_8896120E16B9DC4BCE56FA33F693E8963396B223"] = 0;
  var_0.has_fortified_passive = 0;
}

handlefortified(var_0, var_1, var_2) {}

init_passive_ninja(var_0) {}

set_passive_ninja(var_0) {
  var_0.persistentrelics["_encstr_A5630EE0859BDCD26756F5E6A5DC532C"] = 1;
}

unset_passive_ninja(var_0) {
  var_0.persistentrelics["_encstr_A5630EE0859BDCD26756F5E6A5DC532C"] = 0;
}

handleninjaonlastshot(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_3 = weaponclipsize(var_1);
  var_4 = var_0 getweaponammoclip(var_1, "_encstr_8253060E2B5FE330");

  if(var_4 == 0)
    var_0 thread set_player_stealthed();

  if(var_4 == 0 && !scripts\engine\utility::array_contains(var_0.stealth_used, "_encstr_8253060E2B5FE330"))
    var_0 thread set_player_stealthed();
  else if(var_4 > 0)
    var_0.stealth_used = scripts\engine\utility::array_remove(var_0.stealth_used, "_encstr_8253060E2B5FE330");

  if(var_0 isdualwielding()) {
    var_5 = var_0 getweaponammoclip(var_1, "_encstr_A5AD056A019C63");

    if(var_5 == 0 && !scripts\engine\utility::array_contains(var_0.stealth_used, "_encstr_A5AD056A019C63"))
      var_0 thread set_player_stealthed();
    else if(var_5 > 0)
      var_0.stealth_used = scripts\engine\utility::array_remove(var_0.stealth_used, "_encstr_A5AD056A019C63");
  }
}

set_player_stealthed() {
  self notify("_encstr_AD990EC9ACCD56A3FACD1D592CD8A30D");
  self endon("_encstr_AD990EC9ACCD56A3FACD1D592CD8A30D");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!scripts\cp\utility::isignoremeenabled())
    scripts\cp\utility::allow_player_ignore_me(1);

  playFX(level._effect["_encstr_A140149BE8D2B6D5C6ABB97D9DB1DB77F513AB279B8E"], scripts\engine\utility::drop_to_ground(self.origin) - (0, 0, 30));
  scripts\engine\utility::play_sound_in_space("_encstr_AC9411ABA2F6514118ACE722B4FBA86DC305E3", scripts\engine\utility::drop_to_ground(self.origin));

  if(self isdualwielding())
    wait 3.0;
  else
    wait 4.0;

  if(scripts\cp\utility::isignoremeenabled())
    scripts\cp\utility::allow_player_ignore_me(0);
}

init_passive_last_shots_ammo(var_0) {}

set_passive_last_shots_ammo(var_0) {
  var_0.onkillrelics["_encstr_818B1838856ECD96CE59F563B037E8EBE634ED1D9B7D0BDAB6F6"] = 1;
}

unset_passive_last_shots_ammo(var_0) {
  var_0.onkillrelics["_encstr_818B1838856ECD96CE59F563B037E8EBE634ED1D9B7D0BDAB6F6"] = 0;
}

handleammoonlastshotskill(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !isDefined(var_0)) {
    return;
  }
  var_6 = weaponclipsize(var_0);
  var_7 = var_1 getweaponammoclip(var_0, "_encstr_8253060E2B5FE330");

  if(var_7 <= int(var_6 * 0.2))
    adjust_clip_ammo_from_stock(var_1, var_0, "_encstr_8253060E2B5FE330", var_6);

  if(var_1 isdualwielding()) {
    var_7 = var_1 getweaponammoclip(var_0, "_encstr_A5AD056A019C63");

    if(var_7 <= int(var_6 * 0.2))
      adjust_clip_ammo_from_stock(var_1, var_0, "_encstr_A5AD056A019C63", var_6);
  }
}

init_passive_railgun_overload(var_0) {}

set_passive_railgun_overload(var_0) {
  var_0.onkillrelics["_encstr_81191963AE660F2B43C5FEEBD11A55771582AE077569164BF8C3B3"] = 1;
}

unset_passive_railgun_overload(var_0) {
  var_0.onkillrelics["_encstr_81191963AE660F2B43C5FEEBD11A55771582AE077569164BF8C3B3"] = 0;
}

dolocalrailgundamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2.hitbychargedshot))
    return 0;

  if(!scripts\engine\utility::isbulletdamage(var_3))
    return 0;

  if(isDefined(var_2.agent_type) && (var_2.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_2.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_2.agent_type == "_encstr_9BE008764102938025A5" || var_2.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73" || var_2.agent_type == "_encstr_8D7811402FFDC15BD2A9CEDFBA4BBB694CA758" || var_2.agent_type == "_encstr_8A900B94BD88703A9B327769C2")) {
    return;
  }
  var_6 = istrue(var_2.is_suicide_bomber);
  var_2.head_is_exploding = 1;
  var_7 = var_2 gettagorigin("_encstr_8EEC09159F6238030BFA23");
  playsoundatpos(var_2.origin, "_encstr_9949198B40EDF1BBD0244F604DD97BC20F40B3F2933F37BB4B1977");
  playFX(level._effect["_encstr_86240D412D2FD753ABF168D941EB7A"], var_7);

  if(isDefined(var_2.headmodel))
    var_2 detach(var_2.headmodel);

  if(!var_6)
    var_2 setscriptablepartstate("_encstr_81CC0586952C91", "_encstr_BECC055CF3811A");

  var_2.hitbychargedshot radiusdamage(var_2.origin, 64, var_2.maxhealth, var_2.maxhealth, var_2.hitbychargedshot, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_ACC213809B0F0782172B0E67E1E790778A80EFA829");
  var_2.hitbychargedshot = undefined;
}

init_headshot_super(var_0) {
  var_0.delayedsuperbonus = 0;
}

set_headshot_super(var_0) {
  var_0.onkillrelics["_encstr_A1B417F36FC3E3F8E8392181E7CFB1C7ECF88BC01FD3128DFB"] = 1;
}

unset_headshot_super(var_0) {
  var_0.onkillrelics["_encstr_A1B417F36FC3E3F8E8392181E7CFB1C7ECF88BC01FD3128DFB"] = 0;
}

addvaluetocardmeter(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1.delayedsuperbonus++;
  wait(0.05 * var_1.delayedsuperbonus);
  var_1.delayedsuperbonus--;

  if(var_1.delayedsuperbonus < 0)
    var_1.delayedsuperbonus = 0;

  var_1 notify("_encstr_9612128A50880F9BA013BA8C230926ABA76B4212", 10);
}

init_passive_sonic(var_0) {
  var_0.sonictimer = 0;
}

set_passive_sonic(var_0) {
  var_0.ondamagerelics["_encstr_9AA60E0785DC6E96CE95FACDEDE6D2D8"] = 1;
}

unset_passive_sonic(var_0) {
  var_0.ondamagerelics["_encstr_9AA60E0785DC6E96CE95FACDEDE6D2D8"] = 0;
}

handlepassivesonic(var_0, var_1, var_2) {
  var_3 = gettime();

  if(var_2 scripts\cp\utility::agentisfnfimmune()) {
    return;
  }
  if(var_3 <= var_0.sonictimer) {
    return;
  }
  if(distance2dsquared(var_0.origin, var_2.origin) <= 62500)
    thread scripts\cp\cp_weapon::fx_stun_damage(var_2, var_0);

  var_0.sonictimer = var_3 + 1000;
}

init_passive_crouch_move_speed(var_0) {}

set_passive_crouch_move_speed(var_0) {
  var_0 thread adjust_move_speed_while_crouched(var_0);
  var_0 thread adjust_move_speed_while_sliding(var_0);
}

unset_passive_crouch_move_speed(var_0) {
  var_0 notify("_encstr_819A1862BDA0B79BCB01C2CB983316635E1EE8EDC5E92F65F730");
  var_0.weaponpassivespeedmod = undefined;
}

adjust_move_speed_while_sliding(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_819A1862BDA0B79BCB01C2CB983316635E1EE8EDC5E92F65F730");

  for(;;) {
    self waittill("_encstr_A67411E610AB48B57381E0E01A8F6B462FA6E5");

    if(var_0 getstance() == "_encstr_B13D076BED70539F23") {
      if(isDefined(level.move_speed_scale)) {
        var_0.weaponpassivespeedmod = 0.5;
        var_0[[level.move_speed_scale]]();
      }
    }

    while(var_0 getstance() == "_encstr_B13D076BED70539F23")
      wait 0.1;

    var_0.weaponpassivespeedmod = undefined;
    var_0[[level.move_speed_scale]]();
  }
}

adjust_move_speed_while_crouched(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_819A1862BDA0B79BCB01C2CB983316635E1EE8EDC5E92F65F730");

  for(;;) {
    if(var_0 getstance() == "_encstr_B13D076BED70539F23") {
      if(isDefined(level.move_speed_scale)) {
        var_0.weaponpassivespeedmod = 0.5;
        var_0[[level.move_speed_scale]]();
      }
    }

    while(var_0 getstance() == "_encstr_B13D076BED70539F23")
      wait 0.1;

    var_0.weaponpassivespeedmod = undefined;
    var_0[[level.move_speed_scale]]();
    var_0 waittill("_encstr_82EE0F816D2233A3C06BCD7214775D361D");
  }
}

init_passive_infinite_ammo(var_0) {}

set_passive_infinite_ammo(var_0) {
  var_0 scripts\cp\utility::enable_infinite_ammo(1);
  var_0.persistentrelics["_encstr_9970162B2A3AABB08D1039FB73912DF071D8DD0991ED0328"] = 1;
}

unset_passive_infinite_ammo(var_0) {
  var_0 scripts\cp\utility::enable_infinite_ammo(0);
  var_0.persistentrelics["_encstr_9970162B2A3AABB08D1039FB73912DF071D8DD0991ED0328"] = 0;
  var_0 notify("_encstr_AA4F2EC26A50A9C82863C7ABB7A11269807289E01BB0AD7761E761D90707B7E8FB88110405FFAB18839B383E717DE918");
}

handleinfiniteammopassive(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AA4F2EC26A50A9C82863C7ABB7A11269807289E01BB0AD7761E761D90707B7E8FB88110405FFAB18839B383E717DE918");

  for(;;) {
    var_0 waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_2);
    var_0 thread listenforfirecomplete();
    var_3 = 4;
    var_4 = self.health;

    if(var_4 - var_3 < 1)
      var_3 = 0;

    if(var_3 > 0)
      var_0 dodamage(var_3, var_0 gettagorigin("_encstr_83190BED4757A3B3B20C5E83E0"), var_0, undefined, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9");

    var_0 updateinfiniteammopassive(var_2);
  }
}

listenforfirecomplete() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self notify("_encstr_AF3413D998610F3D7338C27988A335DFBE74515AA5");
  self endon("_encstr_AF3413D998610F3D7338C27988A335DFBE74515AA5");
  self.selfdamaging = 1;
  wait 0.2;
  self.selfdamaging = 0;
}

updateinfiniteammopassive(var_0) {
  var_1 = self.health;
  var_2 = weaponclipsize(var_0);
  self setweaponammoclip(var_0, var_2);

  if(self isdualwielding())
    self setweaponammoclip(var_0, var_2, "_encstr_A5AD056A019C63");
}

init_passive_miss_refund(var_0) {}

set_passive_miss_refund(var_0) {
  var_1 = var_0 getcurrentweapon();
  var_0 thread missrefundwatcher(var_1);
}

unset_passive_miss_refund(var_0) {
  var_0 notify("_encstr_834518EA85B3B8ABB98BF49B0292EFDB782378602977EE03F37F");
}

missrefundwatcher(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_834518EA85B3B8ABB98BF49B0292EFDB782378602977EE03F37F");

  for(;;) {
    self waittill("_encstr_AF8F0C1B6C17D8D0522F777F37EA", var_1);

    if(var_1 == var_0) {
      if(randomfloat(1.0) > 0.75) {
        var_2 = self getweaponammostock(var_0);
        self setweaponammostock(var_0, var_2 + 1);
      }
    }
  }
}

init_passive_scrambler(var_0) {}

set_passive_scrambler(var_0) {
  var_0 thread handlepassivescrambler(var_0);
}

unset_passive_scrambler(var_0) {
  var_0 notify("_encstr_BEF61771274295C8D5A291AB12B1505DC987FDEB8F6A6958FA");
}

scrambler_executevisuals(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_A130084D2FDAD8AA8F62"));
  var_1 setModel("_encstr_A943171B8570C7E930201862932B4B56368837B38ACFBF36B0");
  var_1.angles = self getplayerangles();
  var_1 setotherent(self);
  var_1 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_930B07BB1B6B3854FF", 0);
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 256;
  var_1 moveTo(var_2, var_0);
  scripts\engine\utility::_id_143BA(var_0, "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_AD75063D571AE108");

  if(isDefined(var_1))
    var_1 delete();
}

handlepassivescrambler(var_0) {
  var_0 notify("_encstr_BEF61771274295C8D5A291AB12B1505DC987FDEB8F6A6958FA");
  var_0 endon("_encstr_BEF61771274295C8D5A291AB12B1505DC987FDEB8F6A6958FA");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(randomint(100) > 85) {
      var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
      var_2 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_1, undefined, 24, 256);
      var_3 = 0;

      foreach(var_5 in var_2) {
        if(scripts\engine\utility::within_fov(var_0 getEye(), var_0.angles, var_5.origin, cos(65))) {
          if(!var_3)
            var_0 thread scrambler_executevisuals(0.8);

          thread scrambler_stun_damage(var_5, var_0);
          var_3++;
        }

        if(var_3 >= 5) {
          break;
        }
      }
    }

    wait(randomfloatrange(5.0, 10.0));
  }
}

scrambler_stun_damage(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.stun_hit_time)) {
    if(gettime() > var_0.stun_hit_time) {
      var_0.allowpain = 1;
      var_0.stun_hit_time = gettime() + 1000;
      var_0.stunned = 1;
    } else
      return;
  } else {
    var_0.allowpain = 1;
    var_0.stun_hit_time = gettime() + 1000;
    var_0.stunned = 1;
  }

  var_0 dodamage(1, var_0.origin, var_1, var_1, "_encstr_BDB50C41D83F8F9F030B60E80F5B", "_encstr_99E911030B3BD963A332A759AA80FABBE1CD10");
  var_0 thread addhealthback(var_0);
  wait 1;
  var_0.allowpain = 0;
  var_0.stunned = undefined;
}

addhealthback(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  waittillframeend;

  if(var_0.health < var_0.maxhealth)
    var_0.health = var_0.health + 1;
}

init_passive_random_perks(var_0) {
  var_0.passiverandomperkskillcount = 0;
  var_0 thread tracklaststandforpassiverandomperks(var_0);
}

tracklaststandforpassiverandomperks(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
    var_0.passiverandomperkskillcount = 0;
  }
}

set_passive_random_perks(var_0) {
  var_0.onkillrelics["_encstr_B2E31583169BE62DCECA7DE4853732F66BF5C1954EADDC"] = 1;
}

trackkillsforrandomperks(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1.passiverandomperkskillcount++;

  if(var_1.passiverandomperkskillcount >= 75) {
    var_6 = level.perks;
    var_1.passiverandomperkskillcount = 0;

    if(!isDefined(var_1.zombies_perks) || var_1.zombies_perks.size < 5) {
      for(;;) {
        var_7 = scripts\engine\utility::random(var_6);

        if(!var_1 scripts\cp\utility::has_zombie_perk(var_7)) {
          var_1 iprintln("_encstr_8456567E8392B9B063ADAB51F30522882EC9E7AAC1FFE3F96BB6334A39715416AF3B98CF15E835DAC8AA30FA783EC261E87170A041A05643FD1DD5076DA80A7136AA78B6F2EFF167B5928E57F3EDFFA3F7C9732B5BFFA03E");
          break;
        } else
          var_6 = scripts\engine\utility::array_remove(var_6, var_7);

        waitframe();
      }
    }
  }
}

unset_passive_random_perks(var_0) {
  var_0.onkillrelics["_encstr_B2E31583169BE62DCECA7DE4853732F66BF5C1954EADDC"] = 0;
}

init_passive_melee_super(var_0) {}

set_passive_melee_super(var_0) {
  var_0.skip_weapon_check = 1;
  var_0.onkillrelics["_encstr_8E341458E00BFEB99ED8AFEA7FA93F33987B13D85D2E"] = 1;
}

unset_passive_melee_super(var_0) {
  var_0.skip_weapon_check = undefined;
  var_0.onkillrelics["_encstr_8E341458E00BFEB99ED8AFEA7FA93F33987B13D85D2E"] = 0;
}

handlemeleesuper(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_3) && var_3 == "_encstr_8DED0A21C79B660BC7588981")
    var_1 notify("_encstr_9612128A50880F9BA013BA8C230926ABA76B4212", 125);
}

init_passive_jump_super(var_0) {}

set_passive_jump_super(var_0) {
  var_0.onkillrelics["_encstr_A56B1383FFFEBB196C3D36902B8DE080372512F7BB"] = 1;
  var_0.current_weapon_jump_super = scripts\cp\utility::getrawbaseweaponname(var_0 getcurrentweapon());
}

unset_passive_jump_super(var_0) {
  var_0.onkillrelics["_encstr_A56B1383FFFEBB196C3D36902B8DE080372512F7BB"] = 0;
  var_0.current_weapon_jump_super = undefined;
}

handleairbornesuper(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!var_1 isonground() && (isDefined(var_1.current_weapon_jump_super) && scripts\cp\utility::getrawbaseweaponname(var_0) == var_1.current_weapon_jump_super))
    var_1 notify("_encstr_9612128A50880F9BA013BA8C230926ABA76B4212", 75);
}

init_passive_double_kill_super(var_0) {}

set_passive_double_kill_super(var_0) {
  var_0.onkillrelics["_encstr_91B81A38C2DC9B5A9D2BF591B7AE4CC6ACBEDA4B8DB1D7CD5DE0959C"] = 1;
  var_0.current_weapon_double_super = scripts\cp\utility::getrawbaseweaponname(var_0 getcurrentweapon());
}

unset_passive_double_kill_super(var_0) {
  var_0.onkillrelics["_encstr_91B81A38C2DC9B5A9D2BF591B7AE4CC6ACBEDA4B8DB1D7CD5DE0959C"] = 0;
  var_0.current_weapon_double_super = undefined;
}

handledoublekillssuper(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_1.recentkillcount) && (isDefined(var_1.current_weapon_double_super) && scripts\cp\utility::getrawbaseweaponname(var_0) == var_1.current_weapon_double_super)) {
    if(var_1.recentkillcount == 2)
      var_1 notify("_encstr_9612128A50880F9BA013BA8C230926ABA76B4212", 125);
  }
}

init_passive_mode_switch_score(var_0) {}

set_passive_mode_switch_score(var_0) {
  var_0.alt_mode_passive = 1;
  var_0.cash_scalar_alt_weapon = scripts\cp\utility::getrawbaseweaponname(var_0 getcurrentweapon());
  var_0.cash_scalar = var_0.cash_scalar + 0.1;
}

unset_passive_mode_switch_score(var_0) {
  var_0.cash_scalar = var_0.cash_scalar - 0.1;
  var_0.cash_scalar_alt_weapon = undefined;
  var_0.alt_mode_passive = 0;
}

init_passive_visor_detonation(var_0) {}

set_passive_visor_detonation(var_0) {
  var_0.onkillrelics["_encstr_A97D19C1124AC801CBCAA11BDB2F67F3699191C42AA0E8DBCBB7AA"] = 1;
}

unset_passive_visor_detonation(var_0) {
  var_0.onkillrelics["_encstr_A97D19C1124AC801CBCAA11BDB2F67F3699191C42AA0E8DBCBB7AA"] = 0;
}

handlevisordetonation(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!scripts\engine\utility::isbulletdamage(var_3))
    return 0;

  if(!scripts\cp\utility::isheadshot(var_0, var_4, var_3, var_1))
    return 0;

  if(isDefined(var_2.agent_type) && (var_2.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_2.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_2.agent_type == "_encstr_9BE008764102938025A5" || var_2.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73" || var_2.agent_type == "_encstr_8D7811402FFDC15BD2A9CEDFBA4BBB694CA758" || var_2.agent_type == "_encstr_8A900B94BD88703A9B327769C2")) {
    return;
  }
  var_6 = istrue(var_2.is_suicide_bomber);
  var_2.head_is_exploding = 1;
  var_7 = var_2 gettagorigin("_encstr_8EEC09159F6238030BFA23");
  playsoundatpos(var_2.origin, "_encstr_9949198B40EDF1BBD0244F604DD97BC20F40B3F2933F37BB4B1977");
  playFX(level._effect["_encstr_86240D412D2FD753ABF168D941EB7A"], var_7);

  if(isDefined(var_2.headmodel))
    var_2 detach(var_2.headmodel);

  if(!var_6)
    var_2 setscriptablepartstate("_encstr_81CC0586952C91", "_encstr_BECC055CF3811A");
}

passive_visor_detonation_activate() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_82931DFF6880FF9B2777472795DD912E4B53F582E6D88D93087517ABB3F0CA");

  for(;;) {
    self waittill("_encstr_8C3C1F40525EC163B37725885487889B891B30281A7929D84F73B8942DE773472D", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    waitframe();
  }
}

init_passive_berserk(var_0) {}

set_passive_berserk(var_0) {
  var_0.onkillrelics["_encstr_AC38101C2CE6CD966756FA9859E49B59395B"] = 1;
}

unset_passive_berserk(var_0) {
  var_0.onkillrelics["_encstr_AC38101C2CE6CD966756FA9859E49B59395B"] = 0;
}

handleberserk(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!istrue(var_1.berserk)) {
    var_1.berserk = 1;
    var_1 setfiretimescaleon(65);
    var_6 = var_1 player_getrecoilscale();

    if(var_6 < 0)
      var_6 = 100;

    var_6 = max(var_6 - 20, 0);
    var_1 player_recoilscaleon(int(var_6));
  }

  var_1 notify("_encstr_B4A613D88B980FC83B5796C3351688D9089240E073");
  var_1 thread remove_berserk_after_timeout(2);
}

remove_berserk_after_timeout(var_0) {
  self endon("_encstr_AACF0CCAB9C8FA982B9C6E594EAD");
  self endon("_encstr_B4A613D88B980FC83B5796C3351688D9089240E073");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread listencancelberserk();
  wait(var_0);
  unset_berserk();
}

listencancelberserk() {
  self endon("_encstr_AACF0CCAB9C8FA982B9C6E594EAD");
  self endon("_encstr_B4A613D88B980FC83B5796C3351688D9089240E073");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  unset_berserk();
}

unset_berserk() {
  if(istrue(self.berserk)) {
    self.berserk = 0;
    self setfiretimescaleoff();
    var_0 = self player_getrecoilscale();
    var_0 = min(var_0 + 20, 100);
    self player_recoilscaleon(int(var_0));
    self notify("_encstr_AACF0CCAB9C8FA982B9C6E594EAD");
  }
}

unsetquadfeederpassive() {
  self notify("_encstr_95F21562355721D250910D1EA0C7F2EDE2DF0FCCDAF1DB");
  self notify("_encstr_B631161D3E9BB7D39DEFBBF95BAFF5359329119E9B4B50A2");
  unset_berserk();
}

init_passive_melee_cone_expl(var_0) {}

set_passive_melee_cone_expl(var_0) {
  var_0.onkillrelics["_encstr_BD3818C85A92B7788305C8D91D3321537182B8A0B221C312F324"] = 1;
  var_0.skip_weapon_check = 1;
}

unset_passive_melee_cone_expl(var_0) {
  var_0.onkillrelics["_encstr_BD3818C85A92B7788305C8D91D3321537182B8A0B221C312F324"] = 0;
  var_0.skip_weapon_check = undefined;
}

handlemeleeconeexplode(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_3 != "_encstr_8DED0A21C79B660BC7588981") {
    return;
  }
  if(!issubstr(var_0, "_encstr_825609B52BB1952B9CD973") && !var_1 isalternatemode(var_0)) {
    return;
  }
  var_6 = var_2 gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28");
  var_7 = var_1 getplayerangles();
  var_8 = anglesToForward(var_7);
  var_9 = anglestoup(var_7);
  var_10 = var_6 - var_8 * 128;
  var_11 = 384;
  playFX(level._effect["_encstr_A68D0DC6DB37ACBEACF00E1BFA990F"], var_6 + (0, 2, 0), var_8, var_9);
  var_12 = scripts\cp\cp_agent_utils::get_alive_enemies();

  foreach(var_14 in var_12) {
    if(isDefined(var_14.flung) || isDefined(var_14.agent_type) && (var_14.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB" || var_14.agent_type == "_encstr_A60E0DA22F1BF540F8660F84DAD6A1" || var_14.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B" || var_14.agent_type == "_encstr_9BE008764102938025A5" || var_14.agent_type == "_encstr_97630D0B93F8274B3E8D82ABA81D73")) {
      continue;
    }
    if(!scripts\engine\math::pointvscone(var_14 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"), var_10, var_8, var_9, var_11, 128, 12)) {
      continue;
    }
    if(var_14 damageconetrace(var_6, var_1) <= 0) {
      continue;
    }
    var_15 = int(1500 * var_1 scripts\cp\cp_weapon::get_weapon_level(var_0));
    wait 0.05;
    var_14 dodamage(var_15, var_6, var_1, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_0);
  }
}

init_passive_minimap_damage(var_0) {}

set_passive_minimap_damage(var_0) {
  var_0.ondamagerelics["_encstr_92D51779F94A083B53D296D8FADBE32066409FD961B5D07427"] = 1;
}

unset_passive_minimap_damage(var_0) {
  var_0.ondamagerelics["_encstr_92D51779F94A083B53D296D8FADBE32066409FD961B5D07427"] = 0;
}

updatepassiveminimapdamage(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return;
  }
  var_3 = "_encstr_865D19FAA0E11DA730459681E958B7A77B20D30289BFD2BFE8BC9D";

  if(isDefined(var_2.damaged_by_players))
    var_3 = "_encstr_820619F06BF3B970488BCDCB194387B545F8BCF25071988C2CA0F7";

  if(isDefined(var_2.marked_for_challenge))
    var_3 = "_encstr_AFF818227BED6B8490239691D968C1B39D330BDA86C433FC181B";
  else
    var_3 = "_encstr_865D19FAA0E11DA730459681E958B7A77B20D30289BFD2BFE8BC9D";

  level thread set_outline_passive_minimap_damage(var_0, var_2, var_3);
}

enable_outline_for_players(var_0, var_1, var_2, var_3) {
  var_0 hudoutlineenableforclients(var_1, var_2);
}

set_outline_passive_minimap_damage(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BD4611B7578EB12DDC56BE23A5DC8531C65932");

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = "_encstr_865D19FAA0E11DA730459681E958B7A77B20D30289BFD2BFE8BC9D";

  enable_outline_for_players(var_1, level.players, var_2, "_encstr_9ACC05B41B7F32");
  wait 10;
  unset_outline_passive_minimap_damage(var_1);
}

disable_outline_for_players(var_0, var_1) {
  var_0 hudoutlinedisableforclients(var_1);
}

unset_outline_passive_minimap_damage(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  scripts\cp\cp_outline::disable_outline_for_players(var_0, level.players);
}

activate_adrenaline_boost(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 scripts\cp\utility::adddamagemodifier("_encstr_8FF90DDB5051ECC359200E451057FB", 0.2, 0);
  var_0 notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  var_0 playlocalsound("_encstr_AB62189EC2279951A452B8E829FC3BD1C36C1685298B86438DEB");
  wait 5;
  var_0 scripts\cp\utility::removedamagemodifier("_encstr_8FF90DDB5051ECC359200E451057FB", 0);
  var_0 playlocalsound("_encstr_85750FFE529A0B4BA81FC090DFF4A05B73");
}

adr_boost(var_0) {
  var_0 notify("_encstr_83C71BDB73E3DFC83F109BB73B648095AF9A30C00A4F8F80D615A38755");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(randomint(100) > 30) {
      thread run_adrenaline_visuals(var_0, 5);
      thread activate_adrenaline_boost(var_0);
    }

    wait(randomfloatrange(5.0, 15.0));
  }
}

remove_adrenaline_visuals(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 visionsetnakedforplayer("_encstr_B40101", 0.5);
}

run_adrenaline_visuals(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BE671A1E3D9D5898435FE170A8B0FD16AD83B69957DBACBFFBB9B51A");
  var_0 visionsetnakedforplayer("_encstr_A3DD0BD6B46EE6D2C6CA6C2CD6", scripts\engine\utility::ter_op(1, 0.1, 0.0));
  var_0 scripts\engine\utility::_id_143B9(var_1, "_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 thread remove_adrenaline_visuals(var_0);
}

init_passive_cold_damage(var_0) {}

set_passive_cold_damage(var_0) {
  var_0.ondamagerelics["_encstr_BA7D1477167BAF6836AFC9309F7481BFB2BE61776FF2"] = 1;
  var_0.cold_weapon = var_0 getcurrentweapon();
}

unset_passive_cold_damage(var_0) {
  var_0.ondamagerelics["_encstr_BA7D1477167BAF6836AFC9309F7481BFB2BE61776FF2"] = 0;
  var_0.cold_weapon = undefined;
}

updatepassivecolddamage(var_0, var_1, var_2) {
  var_3 = isDefined(var_2.agent_type) && var_2.agent_type == "_encstr_8B6C0DE8403D73AB45F9302BC3E4CB";
  var_4 = isDefined(var_2.agent_type) && var_2.agent_type == "_encstr_82A90CC0B0303AC2FDF7DFF3FB9B";
  var_5 = istrue(var_2.is_suicide_bomber);

  if(var_3 || var_4 || var_5) {
    return;
  }
  if(isDefined(var_0.cold_weapon)) {
    if(scripts\cp\utility::getrawbaseweaponname(var_0.cold_weapon) == scripts\cp\utility::getrawbaseweaponname(var_1)) {
      var_2 thread unsetslowmovementaftertime(var_2, var_2.movemode);
      var_2.movemode = "_encstr_97BC0AB9C67BDD7DDD851B6D";
      var_2 scripts\asm\asm_bb::bb_requestmovetype("_encstr_97BC0AB9C67BDD7DDD851B6D");
    }
  }
}

unsetslowmovementaftertime(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  wait 10;

  if(isDefined(var_1)) {
    var_0.movemode = var_1;
    var_0 scripts\asm\asm_bb::bb_requestmovetype(var_1);
  }
}

init_passive_scorestreak_damage(var_0) {}

set_passive_scorestreak_damage(var_0) {
  var_0.special_zombie_damage = 1.1;
}

unset_passive_scorestreak_damage(var_0) {
  var_0.special_zombie_damage = undefined;
}

init_passive_scope_radar(var_0) {
  var_0.activate_radar = 0;
  var_0 notifyonplayercommand("_encstr_A75A132EFB27936B718BB898D25267C96373A0AB5E", "_encstr_97120D65B983599519EB1D86C9B7EE");
  var_0 notifyonplayercommand("_encstr_993314BFD7AA674837F259F1DEE26117F20F6F3F2743", "_encstr_A52F0DF89B22FF1545787B02C3C7FF");
}

set_passive_scope_radar(var_0) {
  var_0 thread updatescoperadar(var_0);
}

unset_passive_scope_radar(var_0) {
  var_0 notify("_encstr_827C10BACD37CA47A636BD385949169116C9");
  var_0 thread cleanup_outlines(var_0);
}

updatescoperadar(var_0) {
  var_0 notify("_encstr_9AF511AB3819B0D12B9AD8F638CA94B0230BE4");
  var_0 endon("_encstr_9AF511AB3819B0D12B9AD8F638CA94B0230BE4");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_827C10BACD37CA47A636BD385949169116C9");
  var_1 = 2.4;
  var_2 = 1750;

  for(;;) {
    if(!var_0 adsButtonPressed())
      var_3 = var_0 scripts\engine\utility::_id_143B7("_encstr_A75A132EFB27936B718BB898D25267C96373A0AB5E", "_encstr_993314BFD7AA674837F259F1DEE26117F20F6F3F2743", "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_AD75063D571AE108", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
    else
      var_3 = "_encstr_A75A132EFB27936B718BB898D25267C96373A0AB5E";

    if(var_3 == "_encstr_A75A132EFB27936B718BB898D25267C96373A0AB5E")
      runscoperadarinloop(var_0, var_1, var_2);

    var_0 thread remove_visuals(var_0);
  }
}

runscoperadarinloop(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 notify("_encstr_AFF5147B0BFA6AF3CADBD893894DC9CE0CD5B40FE0D1");
  var_0 endon("_encstr_AFF5147B0BFA6AF3CADBD893894DC9CE0CD5B40FE0D1");
  var_0 endon("_encstr_993314BFD7AA674837F259F1DEE26117F20F6F3F2743");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = 0.75;

  while(var_0 adsButtonPressed()) {
    if(var_0 playerads() >= var_3) {
      var_0 playlocalsound("_encstr_A21609A3D9CC87E248D577");
      var_0 thread scoperadar_executeping(var_0, var_1, var_2);
      var_0 scoperadar_executevisuals(var_0, var_1);
    }

    waitframe();
  }
}

scoperadar_executeping(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_993314BFD7AA674837F259F1DEE26117F20F6F3F2743");
  var_3 = 0;
  var_4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_5 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_4, undefined, 24, var_2);
  var_0.closestenemies = var_5;
  var_6 = 0;

  foreach(var_8 in var_0.closestenemies) {
    var_8.is_outlined_from_scoperadar = 0;

    if(scripts\engine\utility::within_fov(var_0 getEye(), var_0.angles, var_8.origin, cos(65))) {
      var_6++;
      var_9 = var_8.origin - var_0.origin;

      if(1 && vectordot(anglesToForward(var_0.angles), var_9) < 0) {
        continue;
      }
      var_10 = var_2 * var_2;

      if(length2dsquared(var_9) > var_10) {
        continue;
      }
      var_0 thread outlineplayerbydistance(var_8, var_0, distance2d(var_0.origin, var_8.origin) / var_2, var_1);
      var_3 = 1;
    }
  }
}

enable_outline_for_player(var_0, var_1, var_2, var_3) {
  var_0 hudoutlineenableforclient(var_1, var_2);
}

outlineplayerbydistance(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_993314BFD7AA674837F259F1DEE26117F20F6F3F2743");
  var_1 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  wait(var_3 * var_2);
  var_4 = 1;
  var_0.is_outlined_from_scoperadar = 1;
  enable_outline_for_player(var_0, var_1, var_4, 1, 1, "_encstr_9ACC05B41B7F32");
}

watchhighlightfadetime(var_0, var_1, var_2) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 scripts\engine\utility::_id_143BF(var_2);

  if(isDefined(var_1))
    disable_outline_for_player(var_1, var_0);
}

disable_outline_for_player(var_0, var_1) {
  var_0 hudoutlinedisableforclient(var_1);
}

scoperadar_executevisuals(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 visionsetnakedforplayer("_encstr_8C980DF6833A96D8BB169DCABEAD1C", 0.2);
  var_0.fxent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62"));
  var_0.fxent setModel("_encstr_A943171B8570C7E930201862932B4B56368837B38ACFBF36B0");
  var_0.fxent.angles = var_0 getplayerangles();
  var_0.fxent setotherent(var_0);
  var_0.fxent setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_930B07BB1B6B3854FF", 0);
  var_2 = var_0.fxent.origin + anglesToForward(var_0.fxent.angles) * 1750;
  var_0.fxent moveTo(var_2, var_1);
  var_0 scripts\engine\utility::_id_143C3(var_1, "_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_AD75063D571AE108", "_encstr_993314BFD7AA674837F259F1DEE26117F20F6F3F2743", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_827C10BACD37CA47A636BD385949169116C9");

  if(isDefined(var_0.closestenemies)) {
    foreach(var_4 in var_0.closestenemies) {
      if(isDefined(var_4)) {
        if(istrue(var_4.is_outlined_from_scoperadar)) {
          disable_outline_for_player(var_4, var_0);
          var_4.is_outlined_from_scoperadar = 0;
        }
      }
    }
  }

  var_0 visionsetnakedforplayer("_encstr_B40101", 0.1);

  if(isDefined(var_0.fxent))
    var_0.fxent delete();
}

remove_visuals(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      if(istrue(var_3.is_outlined_from_scoperadar)) {
        disable_outline_for_player(var_3, var_0);
        var_3.is_outlined_from_scoperadar = 0;
      }
    }
  }

  if(isDefined(var_0.fxent))
    var_0.fxent delete();
}

cleanup_outlines(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      if(istrue(var_3.is_outlined_from_scoperadar)) {
        disable_outline_for_player(var_3, var_0);
        var_3.is_outlined_from_scoperadar = 0;
      }
    }
  }
}

init_passive_scoutping(var_0) {}

set_passive_scoutping(var_0) {
  var_0 thread updatescoutping(var_0);
}

unset_passive_scoutping(var_0) {
  var_0 notify("_encstr_AF190FF7FDA64A6C8961DDA37B69893274");
}

updatescoutping(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AF190FF7FDA64A6C8961DDA37B69893274");
  var_1 = 1000;
  var_2 = 0.1;

  for(;;) {
    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
    var_4 = var_1;
    var_5 = var_2;
    var_4 = int(var_4);
    var_5 = float(var_5);

    if(isDefined(var_3))
      var_6 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_3, undefined, 24, var_4);
    else {
      waitframe();
      continue;
    }

    if(var_6.size >= 1) {
      foreach(var_8 in var_6) {
        scripts\cp\cp_outline::enable_outline_for_players(var_8, level.players, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246", "_encstr_BE19041BDEDD");
        wait(var_5);
      }

      continue;
    }

    waitframe();
  }
}

updateonkillrelics(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1.onkillrelics)) {
    return;
  }
  var_5 = gettime();
  var_6 = getarraykeys(var_1.onkillrelics);

  if(!isDefined(var_6)) {
    return;
  }
  foreach(var_8 in var_6) {
    if(istrue(var_1.onkillrelics[var_8]))
      thread[[level.onkillrelics[var_8]]](var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

updatepersistentrelics(var_0) {
  if(!isDefined(var_0.persistentrelics)) {
    return;
  }
  var_1 = gettime();
  var_2 = getarraykeys(var_0.persistentrelics);

  if(!isDefined(var_2)) {
    return;
  }
  foreach(var_4 in var_2) {
    if(istrue(var_0.persistentrelics[var_4]))
      var_0 thread[[level.persistentrelics[var_4]]](var_0);
  }
}

updateondamagerelics(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isPlayer(var_2))
    var_6 = var_2;
  else if(isPlayer(var_0))
    var_6 = var_0;

  if(!isDefined(var_6)) {
    return;
  }
  if(!isDefined(var_6.ondamagerelics)) {
    return;
  }
  var_5 = gettime();
  var_7 = getarraykeys(var_6.ondamagerelics);

  if(!isDefined(var_7)) {
    return;
  }
  foreach(var_9 in var_7) {
    if(istrue(var_6.ondamagerelics[var_9]))
      thread[[level.ondamagerelics[var_9]]](var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_13FFF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isPlayer(var_2))
    var_6 = var_2;
  else if(isPlayer(var_0))
    var_6 = var_0;
  else if(isDefined(var_0.owner) && isPlayer(var_0.owner))
    var_6 = var_0.owner;

  if(!isDefined(var_6)) {
    return;
  }
  if(!isDefined(var_6.ondamagerelics)) {
    return;
  }
  var_5 = gettime();
  var_7 = getarraykeys(var_6.ondamagerelics);

  if(!isDefined(var_7)) {
    return;
  }
  foreach(var_9 in var_7) {
    if(isDefined(var_6._id_12015)) {
      if(istrue(var_6._id_12015[var_9])) {
        if(isDefined(level._id_12015[var_9]))
          thread[[level._id_12015[var_9]]](var_0, var_1, var_2, var_3, var_4, var_5);
      }
    }
  }
}

_id_13FD3(var_0, var_1) {
  var_2 = undefined;

  if(!isPlayer(var_1.eattacker)) {
    if(!isDefined(var_1.eattacker.owner))
      return;
    else
      var_2 = var_1.eattacker.owner;
  } else
    var_2 = var_1.eattacker;

  if(!isDefined(var_2) || !isDefined(var_2._id_12020)) {
    return;
  }
  var_3 = gettime();
  var_4 = getarraykeys(var_2._id_12020);

  if(!isDefined(var_4)) {
    return;
  }
  foreach(var_6 in var_4) {
    if(istrue(var_2._id_12020[var_6]))
      thread[[level._id_12020[var_6]]](var_0, var_1);
  }
}

init() {
  if(scripts\cp\utility::turn_off_sniper_laser() || scripts\cp\utility::tryingtoleave()) {
    return;
  }
  zombiepingrate();
  register_relics();
  relics_monitor();
  level thread player_connect_monitor();
}

zombiepingrate() {
  level._effect["_encstr_AB2711E8CD51EBAAA11023A978B92283C8256D"] = loadfx("_encstr_8C0328EC33F097A5EE1C7DB1385E6B5ADC6C5E3B99F0AF3683AF1A592C23D7591E83367B23CAE2ECCC1E");
  level._effect["_encstr_A90C16D0ACB032DC86B7D1FA95E1E0C6BD8C2BBE4DBAB3D9"] = loadfx("_encstr_B8632C4B1910FF5A7CB1C73F490842E1E00195D3F1E84732D767633F5345A925E00BFD1D29A83F9AAD3F727BB573");
  level._effect["_encstr_8C3F1240525ED183B368AF965B474B8386DAD008"] = loadfx("_encstr_AB0F259D33F07996DD07AF6C0E79CECC3CFA0D95C236E8D0C12C6C6DD7EC0BB94B6EA18B67991E");
  level._effect["_encstr_BAD211D08A5FE170D4B8037FDB719BB70703A8"] = loadfx("_encstr_93C11E2B84494EA92B0AAF5760088E62E1B03467FFB933E093B8474F8ADB56CB");
  level._effect["_encstr_AB020E433345580FC9F38B8DCBF25840"] = loadfx("_encstr_A58B337BB2F1AFF7101B1F07A36FB7C338C1FF4B4268DE83C893DD8BD998EFE33DC02077D1A3072EF40868AF277F3B6B1B0214A48B");
}

player_connect_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    taken_damage_for_molotov_achievement(var_0);
    var_0 thread _id_12BAF();
  }
}

taken_damage_for_molotov_achievement(var_0) {
  var_0.onkillrelics = [];
  var_0.persistentrelics = [];
  var_0.ondamagerelics = [];
  var_0.relics = [];
}

relics_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  zombienumtoconsume();
}

_id_12BAF() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_8C390FFEAD7BE0170A29889012A4E1F8EB");
  var_0 endon("_encstr_8C390FFEAD7BE0170A29889012A4E1F8EB");
  var_0.activated_relics = [];
  scripts\engine\utility::flag_wait("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");
  var_0 init_and_set_relics(var_0);

  for(;;) {
    var_0 waittill("_encstr_955A0D1399019FE6B9A3203CA3C82F", var_1, var_2);

    if(isDefined(var_2)) {
      if(!istrue(var_2)) {
        unset_relics(var_0, var_1);
        continue;
      }

      set_relics(var_0, var_1);
    }
  }
}

zombienumtoconsume() {
  level.set_relics = [];
  var_0 = getDvar("_encstr_AD260F8BDAF657224BC3D16335E39BA2E3", "_encstr_B40101");
  var_1 = strtok(var_0, "_encstr_964C0249");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && var_3 != "_encstr_B40101") {
      level.set_relics[var_3] = 1;
      level thread _id_12DE4(var_3);
    }
  }
}

_id_12DE4(var_0) {
  if(isDefined(level.select_bridge_three_spawners[var_0]) && isbuiltinfunction(level.select_bridge_three_spawners[var_0]))
    level thread[[level.select_bridge_three_spawners[var_0]]]();
}

load_relics_via_dvar() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.set_relics = [];

  for(;;) {
    var_0 = getDvar("_encstr_AD260F8BDAF657224BC3D16335E39BA2E3", "_encstr_B40101");
    var_1 = strtok(var_0, "_encstr_964C0249");

    foreach(var_3 in var_1) {
      if(istrue(level.set_relics[var_3])) {
        waitframe();
        continue;
      }

      if(isDefined(var_3) && var_3 != "_encstr_B40101") {
        level.set_relics[var_3] = 1;

        foreach(var_5 in level.players)
        var_5 notify("_encstr_955A0D1399019FE6B9A3203CA3C82F", var_3, 1);
      }
    }

    waitframe();
  }
}

_id_130FD(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_12B71))
    var_1._id_12B71 = 1;
  else
    var_1._id_12B71 = var_1._id_12B71 + 1;

  var_2 = tablelookup("_encstr_8A3016F638F621B1817B4808E2A6371B27D2897DCE7F6BF5", 1, var_0, 0);
  var_3 = int(var_2);
  var_4 = "_encstr_A92F0B2ECF47DB6588409F67AA";

  switch (var_1._id_12B71) {
    case 1:
      var_4 = "_encstr_A92F0B2ECF47DB6588409F67AA";
      break;
    case 2:
      var_4 = "_encstr_8C2F0B7780786EF548A8D84756";
      break;
    case 3:
      var_4 = "_encstr_9A2F0BD2605F424F587BAB9F2E";
      break;
    case 4:
      var_4 = "_encstr_B42F0B47E2C1AEBBEC3B40DEF7";
      break;
  }

  var_1 setclientomnvar(var_4, var_3);
}

unload_relics_via_dvar() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = getDvar("_encstr_96E9119EFE039FB376DF20A0878249015A6616", "_encstr_B40101");
    var_1 = strtok(var_0, "_encstr_964C0249");

    foreach(var_3 in var_1) {
      if(istrue(level.set_relics[var_3])) {
        if(isDefined(var_3) && var_3 != "_encstr_B40101") {
          foreach(var_5 in level.players)
          var_5 notify("_encstr_955A0D1399019FE6B9A3203CA3C82F", var_3, 0);

          level.set_relics[var_3] = undefined;
        }
      }
    }

    waitframe();
  }
}

debug_set_relic(var_0, var_1) {
  if(isDefined(var_1) && isDefined(level.cp_relics[var_1])) {
    var_0.relics[var_1] = level.cp_relics[var_1];
    set_relics(var_0, var_1);
  }
}

debug_unset_relic(var_0, var_1) {
  if(isDefined(var_1) && isDefined(level.cp_relics[var_1])) {
    var_0.relics[var_1] = level.cp_relics[var_1];
    unset_relics(var_0, var_1);
  }
}

init_and_set_relics(var_0) {
  foreach(var_4, var_2 in level.set_relics) {
    var_3 = level.cp_relics[var_4];
    var_4 = var_3.name;
    set_relics(var_0, var_4);
  }
}

unset_relics(var_0, var_1) {
  var_2 = level.cp_relics[var_1];

  if(!isDefined(var_2)) {
    return;
  }
  if(isDefined(var_2)) {
    if(isDefined(var_2) && isDefined(var_2.unset_func))
      [[var_2.unset_func]](var_0);

    var_0.activated_relics = scripts\engine\utility::array_remove(var_0.activated_relics, var_2.name);
  }
}

set_relics(var_0, var_1) {
  var_2 = level.cp_relics[var_1];

  if(!isDefined(var_2)) {
    return;
  }
  if(isDefined(var_2)) {
    if(isDefined(var_2) && isDefined(var_2.init_func))
      [[var_2.init_func]](var_0);
  }

  if(isDefined(var_2) && isDefined(var_2.set_func))
    [[var_2.set_func]](var_0);

  if(isDefined(level.updatepersistentrelicsfunc))
    level thread[[level.updatepersistentrelicsfunc]](var_0);

  var_0.activated_relics = scripts\engine\utility::array_add(var_0.activated_relics, var_2.name);
  var_0 _id_130FD(var_2.name);
}

register_relic(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.init_func = var_1;
  var_4.set_func = var_2;
  var_4.unset_func = var_3;
  var_4.name = var_0;
  level.cp_relics[var_0] = var_4;
}

parserelicstable() {
  if(!isDefined(level.lootpassivesstructs))
    level.lootpassivesstructs = [];

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 0);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 1);
    var_3 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 2);
    var_4 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 12);
    var_5 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 13);
    var_6 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 15);
    var_7 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 23);
    var_8 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 24);
    var_9 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 25);
    var_10 = spawnStruct();
    var_10.name = var_2;
    var_10.passivestringref = var_3;
    var_10.passiveindex = int(var_1);
    var_10.weapontype = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 8) == "_encstr_B40101", 0, 1);
    var_10.killstreaktype = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 9) == "_encstr_B40101", 0, 1);
    var_10.lethaltype = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 10) == "_encstr_B40101", 0, 1);
    var_10.tacticaltype = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 11) == "_encstr_B40101", 0, 1);

    if(var_4 != "_encstr_B40101")
      var_10.attachmentref = var_4;

    if(getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") == "_encstr_BACB074025B01AAA28" || getDvar("_encstr_ADE50BEB2F7C519F9918E82B68") == "_encstr_B2660A666F36C7FB7B29F797") {
      var_11 = tablelookupbyrow("_encstr_B172294F4020B23A0BE684BF56A7C27FF08847177041F062750601FAB7C70B31BBB86357E0985DBE471E53", var_0, 22);

      if(var_11 != "_encstr_B40101")
        var_10.attachmentref = var_11;
    }

    if(var_5 != "_encstr_B40101")
      var_10.perkref = var_5;

    if(var_6 != "_encstr_B40101")
      var_10.messageref = var_6;

    if(isDefined(var_7))
      var_10.prdprobability = int(var_7);

    if(isDefined(var_8))
      var_10.prdconstant = float(var_8);

    if(isDefined(var_9))
      var_10.maxrolls = int(var_9);

    if(!isDefined(level.lootpassivesstructs[var_2]))
      level.lootpassivesstructs[var_2] = var_10;

    var_0++;
  }
}

updaterecentkills(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  self endon("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  self.recentkillcount++;
  var_2 = getweaponbasename(var_1);

  if(!isDefined(self.killsperweaponlog[var_2]))
    self.killsperweaponlog[var_2] = 1;
  else
    self.killsperweaponlog[var_2]++;

  if(!isDefined(self.recentkillsperweapon))
    self.recentkillsperweapon = [];

  if(!isDefined(self.recentkillsperweapon[var_2]))
    self.recentkillsperweapon[var_2] = 1;
  else
    self.recentkillsperweapon[var_2]++;

  wait 3.5;
  self.recentkillcount = 0;
  self.recentkillsperweapon = undefined;
}

init_relic_collat_dmg(var_0) {}

set_relic_collat_dmg(var_0) {
  var_0.ondamagerelics["_encstr_8A4411F0F56841AA504338F0B5775B67FBE997"] = 1;
  level.explosivedamagemod = 0.4;
  var_0.onkillrelics["_encstr_8A4411F0F56841AA504338F0B5775B67FBE997"] = 1;
}

unset_relic_collat_dmg(var_0) {
  level.explosivedamagemod = undefined;
  var_0.ondamagerelics["_encstr_8A4411F0F56841AA504338F0B5775B67FBE997"] = 0;
  var_0.onkillrelics["_encstr_8A4411F0F56841AA504338F0B5775B67FBE997"] = 0;
}

_id_12016(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isagent(var_2)) {
    return;
  }
  if(!scripts\cp\utility::isheadshot(var_1, var_4, var_3, var_0) && (var_3 != "_encstr_8DED0A21C79B660BC7588981" && var_3 != "_encstr_A1ED0BA9FF84562B60BA073E83")) {
    return;
  }
  var_2.nocorpse = 1;
}

handlereliccollatdamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!scripts\cp\utility::isheadshot(var_0, var_4, var_3, var_1) && (var_3 != "_encstr_8DED0A21C79B660BC7588981" && var_3 != "_encstr_A1ED0BA9FF84562B60BA073E83")) {
    return;
  }
  var_6 = isDefined(var_2.unittype) && var_2.unittype == "_encstr_8BFC0BC2CBD4F737E0A5E1FD79";
  var_7 = var_2.origin;

  if(var_2 tagexists("_encstr_AADA07DBF19A4A81D7"))
    var_7 = var_2 gettagorigin("_encstr_AADA07DBF19A4A81D7");
  else if(var_2 tagexists("_encstr_A130084D2FDAD8AA8F62"))
    var_7 = var_2 gettagorigin("_encstr_A130084D2FDAD8AA8F62");

  var_2.clear_keypad_currentdisplay_models = 1;

  if(var_6) {
    radiusdamage(var_2.origin + (0, 0, 60), 512, 666, 69, undefined, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9");
    scripts\mp\vehicles\vehicle_compass_mp::_id_12E0B("_encstr_97F90B15B04EA343E2ABC25B95", 1.0, 0.6, var_2.origin, 84);
    playFX(level._effect["_encstr_A90C16D0ACB032DC86B7D1FA95E1E0C6BD8C2BBE4DBAB3D9"], var_7);
    var_2 playSound("_encstr_92B30D6F234A09E94D1C433D9841E8");
  } else {
    radiusdamage(var_2.origin + (0, 0, 60), 333, 333, 33, undefined, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9");
    scripts\mp\vehicles\vehicle_compass_mp::_id_12E0B("_encstr_97F90B15B04EA343E2ABC25B95", 1.0, 0.6, var_2.origin, 84);
    playFX(level._effect["_encstr_AB2711E8CD51EBAAA11023A978B92283C8256D"], var_7);
    var_2 playSound("_encstr_92B30D6F234A09E94D1C433D9841E8");
  }

  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2.origin);
}

init_relic_catch(var_0) {
  level.grenade_drop_cooldown = [];
}

set_relic_catch(var_0) {
  var_0.onkillrelics["_encstr_85320CC0C73C608FB1E68715FE9A"] = 1;
  scripts\cp\cp_agent_damage::register_drop_func("_encstr_8C8D08671D451291C849", ::drop_grenade, ::should_drop_grenade, 0);
}

unset_relic_catch(var_0) {
  var_0.onkillrelics["_encstr_85320CC0C73C608FB1E68715FE9A"] = 0;
}

handlereliccatch(var_0, var_1, var_2, var_3, var_4, var_5) {}

drop_grenade(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::drop_to_ground(self.origin + (0, 0, 32), 90) + (0, 0, 2);

  if(isDefined(var_1))
    var_3 = var_1;

  var_4 = "_encstr_923A1AA7D52492717889292B4019BFEB0D6D27034BC08A2168B18B23";

  if(isDefined(level.blueprintextract_shouldgivereward))
    var_4 = level.blueprintextract_shouldgivereward;

  var_5 = 1;

  if(isDefined(level.blueprintextract_trygetreward))
    var_5 = level.blueprintextract_trygetreward;

  var_6 = 200;

  if(isDefined(level.blueprintextractchance))
    var_6 = level.blueprintextractchance;

  var_7 = &"_encstr_95811C0D3D9E0ABE1DA09A8AF5A03182CAF24192862DEB3A4915C9058854";

  if(isDefined(level.blueprintextractspawns))
    var_7 = level.blueprintextractspawns;

  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_8 setModel(var_4);
  var_8.headicon = var_8 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, "_encstr_AB5A1BA1CBB77650E6CC7B17C94EF0480FA2F9CBB2A73968BFB66B79E4", 7, 0, 128, 128, undefined, 0, 0, undefined, undefined);
  var_8.trigger = spawn("_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", var_3, 0, 32, 32);
  var_8 thread scripts\cp\utility::delayentdelete(30);
  var_8.trigger thread scripts\cp\utility::delayentdelete(30);
  var_8 thread activate_grenade_object();
}

activate_grenade_object() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      continue;
    }
    if(scripts\cp\cp_powers::_id_1281C(var_0)) {
      var_0 thread scripts\cp\utility::hint_prompt("_encstr_95640D5BB00FEB9D27ACE60B32B2E6", 1, 1);
      continue;
    }

    if(!nullweapon(var_0 getcurrentweapon()))
      var_0 forceplaygestureviewmodel("_encstr_837B0B872B78312B5B994A5303");

    var_0 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");

    foreach(var_2 in var_0.powers) {
      if(isDefined(level.bmoendgameot)) {
        var_3 = 0;

        if(isDefined(var_0.powers[level.bmoendgameot]))
          var_3 = var_0.powers[level.bmoendgameot].charges;

        var_4 = var_0 scripts\cp\cp_loadout::get_num_of_charges_for_power(var_0, "_encstr_BA7F0830B3A7859B60B0");

        if(var_3 >= var_4)
          var_3 = var_4 - 1;

        var_0 scripts\cp\cp_powers::givepower(level.bmoendgameot, "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, 0, 0, var_3 + 1);
      } else
        var_0 notify("_encstr_9A3C117B6B0602C5284EC7CA23C808BAED8D93", var_2.weaponuse);

      waitframe();
    }

    if(isDefined(self.trigger))
      self.trigger delete();

    self delete();
  }
}

should_drop_grenade(var_0) {
  var_1 = getdvarint("_encstr_AB21178F8706C95E4863FE47FE3072A2D01B5B2F17A5A31FD8");

  if(var_1)
    return 1;

  if(!isDefined(level.grenade_drop_cooldown))
    return 0;

  if(isDefined(self.unittype) && self.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B")
    return 0;

  if(!isDefined(var_0.eattacker))
    return 0;

  var_2 = 10;
  var_3 = gettime();
  var_4 = var_0.eattacker getentitynumber();

  if(!isDefined(level.grenade_drop_cooldown[var_4])) {
    level.grenade_drop_cooldown[var_4] = var_3 + var_2 * 1000;
    return 1;
  }

  if(var_3 > level.grenade_drop_cooldown[var_4]) {
    level.grenade_drop_cooldown[var_4] = var_3 + var_2 * 1000;
    return 1;
  }

  return 0;
}

load_relic_catch_params() {
  self.script_forcegrenade = 1;
  self.grenadeammo = 255;
  self.fngrenadecooldownelapsedoverride = ::start_coop_bomb_case_defusal;
  self.grenadesafedist = 64;
}

start_coop_bomb_case_defusal(var_0) {
  return scripts\engine\utility::cointoss();
}

init_relic_boom(var_0) {}

set_relic_boom(var_0) {
  var_0.onkillrelics["_encstr_B4110B428A310A1E697A1A5855"] = 1;
}

unset_relic_boom(var_0) {
  var_0.onkillrelics["_encstr_B4110B428A310A1E697A1A5855"] = 0;
}

handlerelicboom(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = magicgrenademanual("_encstr_99410C4B48C39AB7D0CD95B769DB", var_2.origin, (0, 0, 0));
  var_6.owner = var_2;
  var_2 thread scripts\cp\equipment\cp_thermite::thermite_used(var_6);
}

init_relic_swat(var_0) {
  scripts\mp\vehicles\vehicle_compass_mp::_id_12B16("_encstr_97F90B15B04EA343E2ABC25B95", ::earthquake, 5, ::brjugg_initpostmain, 0, 0, 0, 1, 1);
}

brjugg_initpostmain(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return 1;
}

set_relic_swat(var_0) {
  var_0.ondamagerelics["_encstr_978E0B0B2BF17CAFF6AE6769C5"] = 1;

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::relic_swat_modifyplayerdamage))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::relic_swat_modifyplayerdamage);
}

try_to_do_first_passby_room_logic() {
  return istrue(level.set_relics["_encstr_978E0B0B2BF17CAFF6AE6769C5"]);
}

try_to_do_first_entry_room_logic() {
  return istrue(level.set_relics["_encstr_8A4411F0F56841AA504338F0B5775B67FBE997"]);
}

try_start_fake_infil_chopper(var_0) {
  if(isDefined(level.set_relics) && isDefined(level.set_relics[var_0]))
    return istrue(level.set_relics[var_0]);
  else
    return 0;
}

getgamewinnerfunc() {
  if(!isDefined(level._id_132C6))
    level._id_132C6 = [];

  level._id_132C6 = scripts\engine\utility::array_add(level._id_132C6, ::_id_140CB);
}

_id_140CB(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0))
    return 1;

  if(isDefined(var_0.owner)) {
    if(!isPlayer(var_0.owner))
      return 1;
  }

  if(!isPlayer(var_0))
    return 1;

  var_6 = var_2 == "_encstr_A1ED0BA9FF84562B60BA073E83";
  var_7 = var_2 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && (isDefined(var_4) && var_4 == "_encstr_8BBA05185F8B99") || var_2 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_2 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_2 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_2 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B";
  var_8 = var_2 == "_encstr_9B0D099AD3887D91252954";
  var_9 = isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && isDefined(var_0.owner) && isPlayer(var_0.owner);
  var_10 = var_9 && var_2 == "_encstr_8D4E0A501FCB898912CB3FA3";
  var_11 = isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" && !isDefined(var_0.owner);
  var_12 = var_11 && var_2 == "_encstr_8D4E0A501FCB898912CB3FA3";
  var_13 = var_2 == "_encstr_8D4E0A501FCB898912CB3FA3";
  var_14 = var_2 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001";
  var_15 = var_2 == "_encstr_8DED0A21C79B660BC7588981";
  var_16 = var_6 || var_7 || var_14 || var_15 || var_13 || var_9 || var_10 || var_11 || var_12 || tripwire_trackachievementboom(var_3) || scripts\cp\utility::isheadshot(var_3, var_4, var_2, var_0);

  if(var_16)
    return 1;

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    if(isPlayer(var_0) && isai(var_5)) {
      if(var_16)
        return 1;
      else
        return 0;
    } else
      return 1;
  } else if(var_16)
    return 1;
  else
    return 0;

  return 0;
}

unset_relic_swat(var_0) {
  var_0.ondamagerelics["_encstr_978E0B0B2BF17CAFF6AE6769C5"] = 0;
  level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::relic_swat_modifyplayerdamage);
}

relic_swat_modifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(_id_140CB(var_1, var_2, var_3, var_4, var_7, var_0))
    return var_2;
  else
    return 0;
}

tripwire_trackachievementboom(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0.basename) {
    case "_encstr_A29408E6D5D6CAAF5B1C":
    case "_encstr_8DCB0F47F22330CEE7996B13A2E390583A":
      return 1;
    case "_encstr_B20A13E6C5D1CBAA99F8F2EA78F722FBC8225795DF":
    case "_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E":
    case "_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07":
    case "_encstr_AC740FAA3BF169D025C6A373200C27E06B":
    case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
    case "_encstr_AAC517BEE0390F6BED2A408B187B8722C6CF7429D2C0E94F20":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
    case "_encstr_81430B218B3F7018458997D78A":
    case "_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB":
      return 1;
    case "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9":
    case "_encstr_95E70D8EDBDA85F5839CED35F5B683":
    case "_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1":
    case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_BE2610C077D0B2630B5683EB7B6E472168F1":
    case "_encstr_99E107C0F71E86B363":
    case "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213":
    case "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0":
    case "_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148":
    case "_encstr_8CBA0AD33D120153A1AFA040":
    case "_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E":
    case "_encstr_A2CF0C31B4B37D985A2746D76B07":
    case "_encstr_B2F60B166F934917E1C5C7BA1B":
    case "_encstr_92B90BC2C11BBEE4AE6ED7AD0E":
    case "_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9":
    case "_encstr_A7A70785E89DD7AD0E":
    case "_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C":
    case "_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43":
    case "_encstr_88E90F60526BE39B37B026C8BBEA614FB1":
    case "_encstr_8D7B0D3007F3805512A6C759B18AB1":
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      return 1;
    case "_encstr_A2950D16C9E8D2361B59932FF55BC1":
    case "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579":
    case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
    case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
    case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
    case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
    case "_encstr_9AAE0876FCB7603101DB":
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
    case "_encstr_92A70ABB8267F5E0D89F6351":
      return 1;
    default:
      return 0;
  }
}

handlerelicswat(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isPlayer(var_0))
    var_2 notify("_encstr_8E5B0734D28EFA854B", var_0);
}

tac_rover_trail(var_0) {}

_id_130B3(var_0) {
  var_0.ondamagerelics["_encstr_87FF1830F2BD7BC1CFDC0F71B147494F672B6040C916A59853C5"] = 1;
  var_0.is_available_for_hack = 1;
}

_id_13F3B(var_0) {
  var_0.ondamagerelics["_encstr_87FF1830F2BD7BC1CFDC0F71B147494F672B6040C916A59853C5"] = undefined;
  var_0.is_available_for_hack = undefined;
}

init_relic_glasscannon(var_0) {}

set_relic_glasscannon(var_0) {
  while(!isDefined(var_0.gs))
    waitframe();

  var_0.og_health_value = var_0.maxhealth;
  var_0.og_health_regen_delay = var_0.gs.healthregendelay;
  var_0.og_health_regen_rate = var_0.gs.healthregenrate;
  var_0.maxhealth = 100;
  var_0.gs.healthregendelay = 1.5;
  var_0.gs.healthregenrate = 50;
}

unset_relic_glasscannon(var_0) {
  var_0.maxhealth = var_0.og_health_value;
  var_0.gs.healthregendelay = var_0.og_health_regen_delay;
  var_0.gs.healthregenrate = var_0.og_health_regen_rate;
}

setupdomplates(var_0, var_1, var_2) {}

take_intro_items(var_0) {}

_id_130D6(var_0) {
  var_0.persistentrelics["_encstr_953B150318893927EE09B7F8B5E610BB506A749DF07B83"] = 1;
}

_id_13F5B(var_0) {
  var_0.persistentrelics["_encstr_953B150318893927EE09B7F8B5E610BB506A749DF07B83"] = 0;
}

select_boss_one_spawners() {
  level thread _id_12BAA(500);
}

_id_12BAA(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

  for(;;) {
    var_1 = level.players;

    if(var_1.size <= 1) {
      wait 3;
      continue;
    }

    foreach(var_3 in var_1) {
      if(!truckdoorrightcol(var_3)) {
        if(isDefined(var_3.triggered_module_spawn_cancel)) {
          if(isDefined(level._id_120A1)) {
            foreach(var_5 in level._id_120A1)
            var_3 thread[[var_5]](var_3);
          }
        }

        var_3.triggered_module_spawn_cancel = undefined;
        continue;
      }

      if(proper_damage(var_3) > var_0) {
        if(!istrue(var_3.triggered_module_spawn_cancel)) {
          if(isDefined(level._id_120A3)) {
            foreach(var_5 in level._id_120A3)
            var_3 thread[[var_5]](var_3);
          }
        }

        var_3.triggered_module_spawn_cancel = 1;
        continue;
      }

      if(istrue(var_3.triggered_module_spawn_cancel)) {
        if(isDefined(level._id_120A2)) {
          foreach(var_5 in level._id_120A2)
          var_3 thread[[var_5]](var_3);
        }
      }

      var_3.triggered_module_spawn_cancel = 0;
    }

    waitframe();
  }
}

truckdoorrightcol(var_0) {
  var_1 = !isalive(var_0) || istrue(var_0.inlaststand) || istrue(var_0.bspawningviaac130) || istrue(var_0.unset_relic_oneclip);
  return !var_1;
}

proper_damage(var_0) {
  var_1 = scripts\cp\utility::getplayersinteam(var_0.team);

  if(var_1.size <= 1)
    return 0;

  var_2 = -1;

  foreach(var_4 in var_1) {
    if(var_4 == var_0) {
      continue;
    }
    var_5 = distance2d(var_0.origin, var_4.origin);

    if(var_5 < var_2 || var_2 < 0)
      var_2 = var_5;
  }

  return var_2;
}

select_back_door_spawners() {
  scripts\mp\vehicles\vehicle_compass_mp::_id_12B16("_encstr_97F90B15B04EA343E2ABC25B95", ::earthquake, 5, ::brjugg_initpostmain, 0, 0, 0, 1, 1);
  level thread _id_12B5C("_encstr_9A8507BA4040188D08");
}

tac_rover_initdamage(var_0) {}

_id_12B5C(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_BA741A93BBF1B82081CF60B09352871F981D3F7015071BBC8B33E2AB");
  level endon("_encstr_BA741A93BBF1B82081CF60B09352871F981D3F7015071BBC8B33E2AB");

  if(!isDefined(var_0))
    var_0 = "_encstr_9A8507BA4040188D08";

  for(;;) {
    if(!isDefined(level._id_12B57)) {
      wait 0.2;
      continue;
    }

    if(!isDefined(level._id_12B68) || !_id_12B59(level._id_12B68) || shocklevel()) {
      if(istrue(shocklevel()) && !istrue(_id_12B5A())) {
        _id_12B53();
        _id_12B5F(1);
        wait 3.0;
        _id_12B5F(0);
        continue;
      } else {
        level._id_12B68 = _id_12B61(var_0, 1);

        if(!isDefined(level._id_12B68))
          level waittill("_encstr_A5390DAFD3C93A9DD006BF4579A0B9");
        else
          waitframe();

        continue;
      }
    }

    if(isDefined(level.bufferedammoboxdata) && level.bufferedammoboxdata <= 0) {
      var_1 = level._id_12B68;

      if(isDefined(var_1)) {
        level _id_12B56(var_1);
        _id_12B5F(1);
        wait 3.0;
        _id_12B5F(0);
      } else
        level waittill("_encstr_A5390DAFD3C93A9DD006BF4579A0B9");

      continue;
    }

    waitframe();
  }
}

_id_12B5D(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8CF517080FF4B85779DEC94F3722E723348FA0E9D399700393");
  level endon("_encstr_84DC16530DBA9A3AF80B2071B788EE2902A0D1079B67420B");
  level notify("_encstr_BAE7206E0F92832117C750B0BF44FECDAAB7E776699B4B4817EB68D1C390930BB29F");
  level endon("_encstr_BAE7206E0F92832117C750B0BF44FECDAAB7E776699B4B4817EB68D1C390930BB29F");

  if(!isDefined(var_0))
    var_0 = "_encstr_9A8507BA4040188D08";

  for(;;) {
    if(!isDefined(level._id_12B57) || !isDefined(level.bufferedammoboxdata)) {
      waitframe();
      continue;
    }

    var_1 = 0.5;

    if(level.bufferedammoboxdata > 7500.0)
      var_1 = 0.5;
    else if(level.bufferedammoboxdata > 5000.0) {
      _id_12B63("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF", var_0);
      var_1 = 1;
    } else {
      _id_12B63("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C", var_0);
      var_1 = 0.2;
    }

    if(isDefined(level._id_12B68) && level.bufferedammoboxdata <= -1500) {
      return;
    }
    wait(var_1);
  }
}

shocklevel() {
  if(!isDefined(level._id_12B68))
    return 1;

  return istrue(level._id_12B68.sfx_revive_lp);
}

shoot_at_apc() {
  if(!isDefined(level._id_12B68))
    return 1;

  if(!isDefined(level._id_12B68.bshouldreturnvalue)) {
    level._id_12B68.bshouldreturnvalue = gettime();
    return 0;
  }

  return gettime() - level._id_12B68.bshouldreturnvalue >= 15000;
}

_id_12B55(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_A7341F93687177B98F6F0D20EB442317E6B34AF0D07CDD3BCD5D096360F390F7A8");
  level endon("_encstr_A7341F93687177B98F6F0D20EB442317E6B34AF0D07CDD3BCD5D096360F390F7A8");
  level waittill("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  wait 3;

  for(;;) {
    wait(var_0);
    _id_12B5E();
  }
}

_id_12B5E() {
  level notify("_encstr_A5390DAFD3C93A9DD006BF4579A0B9");

  if(!istrue(level._id_12B60) && !istrue(level._id_12B58)) {
    if(!isDefined(level._id_12B57)) {
      level._id_12B57 = gettime() + 10000;
      var_0 = level._id_12B57;
    } else
      var_0 = level._id_12B57 + 6000;

    var_1 = gettime() + 20000;
    level._id_12B5B = gettime();
    level._id_12B57 = min(var_0, var_1);

    if(isDefined(level._id_12B68) && var_0 > var_1)
      level._id_12B68.sfx_revive_lp = 1;
  }
}

_id_12B66(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8CF517080FF4B85779DEC94F3722E723348FA0E9D399700393");
  level endon("_encstr_84DC16530DBA9A3AF80B2071B788EE2902A0D1079B67420B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  level notify("_encstr_93241FDD5D2D789E5732B01B5A93CDA085B5250FD3D408D4E36ACE8372130DA89F");
  level endon("_encstr_93241FDD5D2D789E5732B01B5A93CDA085B5250FD3D408D4E36ACE8372130DA89F");
  var_2 = gettime();
  var_3 = var_2 + 2000;
  var_4 = 0;
  level._id_12B58 = 1;

  if(isDefined(level.buddyspawnplayer))
    objective_setprogress(level.buddyspawnplayer, 0);

  while(var_3 > gettime()) {
    var_5 = max(gettime() - var_2, 0.1);
    var_4 = var_5 / 2000 / 2;

    if(isDefined(var_0))
      var_0 setclientomnvar("_encstr_A99718DD011723BB6DEA987142C741190B8FE7D66F8F6BF39253", var_4);

    waitframe();
  }

  level._id_12B58 = 0;

  if(istrue(var_1))
    level._id_12B57 = gettime() + 10000;

  level thread _id_12B5D("_encstr_9A8507BA4040188D08");

  for(;;) {
    if(!isDefined(level._id_12B57)) {
      waitframe();
      continue;
    }

    level.bufferedammoboxdata = level._id_12B57 - gettime();

    if(level.bufferedammoboxdata > 0) {
      var_0 setclientomnvar("_encstr_A99718DD011723BB6DEA987142C741190B8FE7D66F8F6BF39253", level.bufferedammoboxdata / 20000);

      if(isDefined(level.buddyspawnplayer))
        objective_setprogress(level.buddyspawnplayer, level.bufferedammoboxdata / 20000);
    } else {
      var_0 setclientomnvar("_encstr_A99718DD011723BB6DEA987142C741190B8FE7D66F8F6BF39253", 0);
      objective_setprogress(level.buddyspawnplayer, 0);
    }

    if(isDefined(level._id_12B68) && level.bufferedammoboxdata <= -1500) {
      if(_id_12B59(level._id_12B68))
        level _id_12B56(level._id_12B68);

      _id_12B5F(1);
      wait 3.0;
      _id_12B5F(0);
      level notify("_encstr_8CF517080FF4B85779DEC94F3722E723348FA0E9D399700393");
    }

    waitframe();
  }
}

_id_12B63(var_0, var_1) {
  if(!soundexists(var_0)) {
    return;
  }
  if(isDefined(level._id_12B68))
    level._id_12B68 playSound(var_0);
}

_id_12B5A() {
  var_0 = level._id_12B68;

  if(!isDefined(var_0))
    return 1;

  var_1 = scripts\engine\utility::array_remove(scripts\cp\utility::getplayersinteam(var_0.team), var_0);

  if(var_1.size <= 0)
    return 0;

  foreach(var_3 in var_1) {
    if(_id_12B59(var_3))
      return 1;
  }

  return 0;
}

_id_12B53() {
  if(isDefined(level._id_12B68)) {
    level._id_12B68.sfx_revive_lp = 0;
    level._id_12B68.bshouldreturnvalue = undefined;
    level._id_12B68 setclientomnvar("_encstr_A99718DD011723BB6DEA987142C741190B8FE7D66F8F6BF39253", 0);
  }

  level._id_12B57 = undefined;
  level._id_12B5B = undefined;
  level._id_12B68 = undefined;

  if(isDefined(level.buddyspawnplayer)) {
    objective_addalltomask(level.buddyspawnplayer);
    objective_hidefromplayersinmask(level.buddyspawnplayer);
  }
}

_id_12B67(var_0) {
  for(;;) {
    var_1 = undefined;

    if(level.players.size > 1) {
      var_1 = level.players[1];
      var_1 scripts\engine\utility::ent_flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
    }

    if(isDefined(var_1)) {
      var_1._id_12A7E = 1;
      var_1.shouldskipdeathsshield = 1;
      var_1 dodamage(var_1.maxhealth + 100000, var_1.origin, var_1, undefined, "_encstr_AB590C99ED78875F650F3951034D");
      var_1 waittill("_encstr_8E4208C9ACEC5A3BAC46");
      wait(var_0);
      continue;
    }

    wait 1;
  }
}

_id_12B61(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(level._id_12B68)) {
    var_2 = level._id_12B68;
    _id_12B53();
  }

  var_3 = _id_12B62(var_0, var_2);

  if(getdvarint("_encstr_BE010F12A15897830D5F63D763218BE550", 0) > 0 && level.players.size > 1 && _id_12B59(level.players[0]))
    var_3 = level.players[0];

  if(!isDefined(var_3)) {
    return;
  }
  level._id_12B68 = var_3;
  level._id_12B68.bshouldreturnvalue = gettime();
  level._id_12B68.sfx_revive_lp = 0;
  _id_12B65(var_3);

  if(!isDefined(var_1))
    var_1 = 0;

  level.bufferedammoboxdata = undefined;
  level thread _id_12B66(var_3, var_1);
  return var_3;
}

_id_12B62(var_0, var_1) {
  var_2 = scripts\cp\utility::getplayersinteam(var_0);

  foreach(var_4 in var_2) {
    if(!_id_12B59(var_4))
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
  }

  if(var_2.size <= 0)
    return undefined;

  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_2, var_1) && var_2.size > 1)
    var_2 = scripts\engine\utility::array_remove(var_2, var_1);

  return scripts\engine\utility::random(var_2);
}

_id_12B65(var_0) {
  if(!isDefined(level.buddyspawnplayer)) {
    var_1 = scripts\cp\cp_objectives::requestworldid("_encstr_B2390972C85FFF77C9EBC4");
    level.buddyspawnplayer = var_1;
    objective_setplayintro(var_1, 0);
    objective_setplayoutro(var_1, 0);
    objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
    objective_icon(var_1, "_encstr_A3F2144852DF68A18B31BBA15774502D77BBC0709A2B");
    objective_setbackground(var_1, 0);
    objective_setshowoncompass(var_1, 1);
    objective_setshowprogress(var_1, 1);
    objective_setprogress(var_1, 0);
  }

  objective_onentity(level.buddyspawnplayer, var_0);
  objective_setzoffset(level.buddyspawnplayer, 90);
  objective_addalltomask(level.buddyspawnplayer);
  objective_showtoplayersinmask(level.buddyspawnplayer);
}

_id_12B59(var_0) {
  var_1 = var_0 scripts\engine\utility::ent_flag("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  var_2 = !isalive(var_0) || istrue(var_0.inlaststand) || istrue(var_0.respawn_in_progress) || istrue(var_0.bspawningviaac130) || isDefined(var_0.super_invulnerable) || !istrue(var_1);
  return !var_2;
}

_id_12B54() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  var_0 = level.players[0];
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_913D0F237561835B8B18C10B08F554DB59");
  wait 4;
  var_0._id_12A7E = 1;
  var_0.shouldskipdeathsshield = 1;
  var_0 dodamage(var_0.maxhealth + 100000, var_0.origin, var_0, undefined, "_encstr_AB590C99ED78875F650F3951034D");
}

_id_12B56(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0.origin;

  if(var_0 tagexists("_encstr_AADA07DBF19A4A81D7"))
    var_1 = var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7");
  else if(var_0 tagexists("_encstr_A130084D2FDAD8AA8F62"))
    var_1 = var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62");

  var_2 = 3000;
  var_3 = gettime();

  while(istrue(var_0.invulnerable) && gettime() - var_3 <= var_2)
    waitframe();

  var_4 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();
  var_0._id_12A7E = 1;
  var_0.shouldskipdeathsshield = 1;
  var_0 dodamage(var_0.maxhealth + 100000, var_0.origin, var_0, undefined, "_encstr_AB590C99ED78875F650F3951034D");
  radiusdamage(var_0.origin + (0, 0, 60), 600, var_0.maxhealth, var_0.maxhealth, undefined, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9");
  scripts\mp\vehicles\vehicle_compass_mp::_id_12E0B("_encstr_97F90B15B04EA343E2ABC25B95", 1.0, 0.6, var_0.origin, 84);
  earthquake(1.0, 0.6, var_0.origin, 333);
  playFX(level._effect["_encstr_AB2711E8CD51EBAAA11023A978B92283C8256D"], var_1);
  var_0 playSound("_encstr_92B30D6F234A09E94D1C433D9841E8");

  if(isDefined(var_4))
    var_4 dodamage(var_4.maxhealth, (0, 0, 0), undefined, undefined);

  var_0._id_12A7E = 0;
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0.origin);
  var_0 setclientomnvar("_encstr_A99718DD011723BB6DEA987142C741190B8FE7D66F8F6BF39253", 0);
  var_0.bshouldreturnvalue = undefined;
  level notify("_encstr_84DC16530DBA9A3AF80B2071B788EE2902A0D1079B67420B");
  var_0 thread _id_12B64(var_0);
}

_id_12B64(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isalive(var_0) || istrue(var_0.inlaststand) || istrue(var_0.respawn_in_progress))
    wait 1;

  var_0 scripts\engine\utility::_id_143A5("_encstr_9695073995D94BD959", "_encstr_AD75063D571AE108");
  var_0.shouldskipdeathsshield = 0;
  var_0.shouldskiplaststand = 0;
}

_id_130B1(var_0) {
  var_0.onkillrelics["_encstr_A7AA0CE456D85A36D72CB6C1AC32"] = 1;
}

_id_13F39(var_0) {
  var_0.onkillrelics["_encstr_A7AA0CE456D85A36D72CB6C1AC32"] = 0;
}

_id_12B5F(var_0) {
  level._id_12B60 = var_0;

  if(istrue(var_0)) {
    level notify("_encstr_8CF517080FF4B85779DEC94F3722E723348FA0E9D399700393");

    if(isDefined(level.buddyspawnplayer)) {
      objective_addalltomask(level.buddyspawnplayer);
      objective_hidefromplayersinmask(level.buddyspawnplayer);
    }

    if(isDefined(level._id_12B68))
      level._id_12B68 = undefined;

    level._id_12B57 = undefined;
    level._id_12B5B = undefined;
    level.bufferedammoboxdata = undefined;
  } else {}
}

setupglobalkillcount(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !isai(var_2)) {
    return;
  }
  if(!isDefined(level._id_12B68)) {
    _id_12B61(var_1.team, 1);
    _id_12B5E();
  } else if(level._id_12B68 == var_1)
    _id_12B5E();
}

taillightright(var_0) {
  var_0 thread _id_12B96(var_0);
}

_id_12B96(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0.maxhealth = 1;
  scripts\cp\cp_armor::givearmor(var_0, 100, 1);
}

_id_130D2(var_0) {
  var_0.onkillrelics["_encstr_A33312C80A45B309170343CBED23114F6D22B028"] = 1;
}

_id_13F58(var_0) {
  var_0.onkillrelics["_encstr_A33312C80A45B309170343CBED23114F6D22B028"] = 0;
}

setuphudelemninfilblack(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    return;
  }
  if(scripts\cp\cp_armor::player_have_full_armor(var_1)) {
    return;
  }
  var_6 = scripts\cp\cp_armor::get_player_armor_amount(var_1);
  var_7 = int(clamp(var_6 + 50, 50, 100));
  scripts\cp\cp_armor::givearmor(var_1, var_7, 1);
}

_id_12B99() {
  level._effect["_encstr_B1321BE3F42B9FCB9748E92370297D73A129804095C229FC54C71F5805"] = loadfx("_encstr_AD9B29D9CCE1F24BBBE0D7D80E5E6B2D9B36CB3B99F0BEC60EAF3ABA37E69536D7CEA5E696DBB9C5B3331E");
}

select_back_two_spawners() {
  level thread _id_12BAA(200);

  if(!isDefined(level._id_120A3))
    level._id_120A3 = [];

  if(!isDefined(level._id_120A2))
    level._id_120A2 = [];

  if(!isDefined(level._id_120A1))
    level._id_120A1 = [];

  level._id_120A2 = scripts\engine\utility::array_add(level._id_120A2, ::_id_12B9C);
  level._id_120A3 = scripts\engine\utility::array_add(level._id_120A3, ::_id_12B9D);
  level._id_120A1 = scripts\engine\utility::array_add(level._id_120A1, ::_id_12B9B);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::_id_12B9A))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::_id_12B9A);
}

setupdomendflag(var_0, var_1, var_2) {}

_id_12B9C(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0._id_12BB0 = 1;
  var_0 notify("_encstr_8BD61C2BBBF006F3514092CA6E364BFF3021B5844FA0CD979039AA72F305");
  var_0 thread scripts\cp\cp_hud_message::tutorialprint("_encstr_B40101", 0.2);
  var_0 thread _id_12B98(var_0, 2, "_encstr_84111A6EE2BAC223635ADCD6D7CDE8CA38E05991FA3ADEB7D7CC2C27", 2);
  var_0 _id_12BA1(var_0, 0);
  var_0 thread _id_12B9F(var_0);
}

_id_12B9D(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0._id_12BB0 = 0;
  var_0 notify("_encstr_84111A6EE2BAC223635ADCD6D7CDE8CA38E05991FA3ADEB7D7CC2C27");
  var_0 _id_12BA1(var_0, 1);
  var_0 thread _id_12BA0(var_0);
  var_0 thread _id_12BA2(var_0);
}

_id_12B9B(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 setclientomnvar("_encstr_A11E172B673176488F4A7168B49BF9B60BFFFB8127AACBE0C3", 0);
}

_id_12B98(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon(var_2);
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 setclientomnvar("_encstr_A11E172B673176488F4A7168B49BF9B60BFFFB8127AACBE0C3", var_3);
  wait(var_1);
  var_0 setclientomnvar("_encstr_A11E172B673176488F4A7168B49BF9B60BFFFB8127AACBE0C3", 0);
}

_id_12BA2(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8BD61C2BBBF006F3514092CA6E364BFF3021B5844FA0CD979039AA72F305");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 thread _id_12BA3(var_0);
  var_0 thread _id_12B97(var_0);
}

_id_12BA3(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8BD61C2BBBF006F3514092CA6E364BFF3021B5844FA0CD979039AA72F305");
  var_0 scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 _id_12B9F(var_0);
}

_id_12B97(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8BD61C2BBBF006F3514092CA6E364BFF3021B5844FA0CD979039AA72F305");
  var_0 visionsetnakedforplayer("_encstr_8E230FB9AE6D56F51995B01D4398C65DC9", 0);
  var_0 allowsupersprint(0);
  wait 5;
  playfxontagforclients(level._effect["_encstr_B1321BE3F42B9FCB9748E92370297D73A129804095C229FC54C71F5805"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
}

_id_12B9F(var_0) {
  var_0 visionsetnakedforplayer("_encstr_B40101", 0);
  var_0 allowsupersprint(1);
  stopFXOnTag(level._effect["_encstr_B1321BE3F42B9FCB9748E92370297D73A129804095C229FC54C71F5805"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

_id_12BA0(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8BD61C2BBBF006F3514092CA6E364BFF3021B5844FA0CD979039AA72F305");

  for(;;) {
    var_1 = 3;
    var_0 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_84EB2A201FB8138AD98F696AD7B1856B4AD5B8D98494C73282B56D0CCB6959E76F4F1060CCC3B37C2975611A", var_1 - 1);
    var_0 thread _id_12B98(var_0, var_1 - 1, "_encstr_8BD61C2BBBF006F3514092CA6E364BFF3021B5844FA0CD979039AA72F305", 1);
    var_0 playlocalsound("_encstr_840E116CE0AFC67B6B1CEAE859C9BECCB0D21B");
    wait(var_1);
  }
}

take(var_0) {}

_id_130D3(var_0) {
  var_0.ondamagerelics["_encstr_BD2C10BA8940492AB8F7CFD73BDD22B1B8D0"] = 1;
  var_0._id_12015["_encstr_BD2C10BA8940492AB8F7CFD73BDD22B1B8D0"] = 1;
  var_0 setclientomnvar("_encstr_A11E172B673176488F4A7168B49BF9B60BFFFB8127AACBE0C3", 0);

  if(!isDefined(var_0._id_13741)) {
    var_1 = scripts\cp\cp_objectives::requestworldid(var_0.name + "_encstr_AD430E87B83B7BB7EBE4ABAA7A0CA46D");
    var_0._id_13741 = var_1;
    objective_setplayintro(var_1, 0);
    objective_setplayoutro(var_1, 0);
    objective_state(var_1, "_encstr_AF5A081BBAC993AC73A3");
    objective_icon(var_1, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
    objective_setbackground(var_1, 1);
    objective_setshowoncompass(var_1, 1);
    objective_onentity(var_1, var_0);
    objective_setzoffset(var_1, 70);
    objective_setshowdistance(var_1, 1);
    objective_addalltomask(var_1);
    objective_hidefromplayersinmask(var_1);
  }
}

_id_13F59(var_0) {
  var_0.ondamagerelics["_encstr_BD2C10BA8940492AB8F7CFD73BDD22B1B8D0"] = 0;
  var_0._id_12015["_encstr_BD2C10BA8940492AB8F7CFD73BDD22B1B8D0"] = 0;
  var_0 setclientomnvar("_encstr_A11E172B673176488F4A7168B49BF9B60BFFFB8127AACBE0C3", 0);

  if(isDefined(var_0._id_13741)) {
    objective_delete(var_0._id_13741);
    var_0._id_13741 = scripts\cp\cp_objectives::freeworldid(var_0.name + "_encstr_AD430E87B83B7BB7EBE4ABAA7A0CA46D");
    var_0._id_13741 = undefined;
  }
}

_id_1201B(var_0, var_1, var_2, var_3, var_4, var_5) {
  return;
}

_id_12B9A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1;

  if(isDefined(var_1) && isPlayer(var_1)) {
    if(!istrue(var_1.triggered_module_spawn_cancel))
      var_8 = 2;
  } else if(isDefined(var_0) && isPlayer(var_0)) {
    if(!istrue(var_0.triggered_module_spawn_cancel))
      var_8 = 0.5;
  }

  return int(var_2 * var_8);
}

_id_12B9E(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0._id_13740)) {
    return;
  }
  var_0._id_13740 = scripts\cp\cp_outline_utility::outlineenableforall(var_0, "_encstr_883219360842533B880A95526367658B68A1E989E040AFA0F721A7", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
  wait 2;
  scripts\cp\cp_outline_utility::outlinedisable(var_0._id_13740, var_0);
  var_0._id_13740 = undefined;
}

_id_12BA1(var_0, var_1) {
  var_2 = scripts\cp\utility::getplayersinteam(var_0.team);
  var_2 = scripts\engine\utility::array_remove(var_2, var_0);

  if(var_2.size <= 0) {
    return;
  }
  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_13741)) {
      if(istrue(var_1)) {
        objective_removeclientfrommask(var_4._id_13741, var_0);
        objective_hidefromplayersinmask(var_4._id_13741);
        continue;
      }

      objective_addclienttomask(var_4._id_13741, var_0);
      objective_hidefromplayersinmask(var_4._id_13741);
    }
  }
}

select_back_one_spawners() {
  scripts\mp\vehicles\vehicle_compass_mp::_id_12B16("_encstr_97F90B15B04EA343E2ABC25B95", ::earthquake, 5, ::brjugg_initpostmain, 0, 0, 0, 1, 1);
}

tacinsert_updatedestroyusability(var_0) {}

_id_130C3(var_0) {
  var_0.persistentrelics["_encstr_AB57110667FAEB596F9B286883641037528FF5"] = 1;
}

_id_13F49(var_0) {
  var_0.persistentrelics["_encstr_AB57110667FAEB596F9B286883641037528FF5"] = 0;
}

setupdom(var_0, var_1, var_2) {}

_id_12B7E(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_93831FFEAD7BE017011AE898B2E5D7798F550DE012E70B733222F0D0F9FA8391EF");
  var_0 notify("_encstr_A5D01E1B0F3410EE91DBB3A5134A20B8DBE74136F76FE995BB93B15F57227898");
  var_0 endon("_encstr_A5D01E1B0F3410EE91DBB3A5134A20B8DBE74136F76FE995BB93B15F57227898");
  var_0 thread _id_12B7D(var_0);
  var_0 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_82F22BC0FB87681DC6EA4E5211B6F5460869341DE93B884745BA070178BDA1D189157CB97446C8159D6FA12717", 2);
  wait 2;
  var_1 = var_0.origin;

  if(var_0 tagexists("_encstr_AADA07DBF19A4A81D7"))
    var_1 = var_0 gettagorigin("_encstr_AADA07DBF19A4A81D7");
  else if(var_0 tagexists("_encstr_A130084D2FDAD8AA8F62"))
    var_1 = var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62");

  var_0 notify("_encstr_8E461AC9ACD85AB1EBC685E64663DBC65B59C8D7AC8738B1DEC8B246");
  radiusdamage(var_0.origin + (0, 0, 60), 333, 333, 33, undefined, "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9");
  scripts\mp\vehicles\vehicle_compass_mp::_id_12E0B("_encstr_97F90B15B04EA343E2ABC25B95", 1.0, 0.6, var_0.origin, 84);
  playFX(level._effect["_encstr_AB2711E8CD51EBAAA11023A978B92283C8256D"], var_1);
  var_0 playSound("_encstr_92B30D6F234A09E94D1C433D9841E8");
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0.origin);
}

_id_12B7D(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8E461AC9ACD85AB1EBC685E64663DBC65B59C8D7AC8738B1DEC8B246");
  var_0 endon("_encstr_A5D01E1B0F3410EE91DBB3A5134A20B8DBE74136F76FE995BB93B15F57227898");

  while(!isDefined(var_0.inhackring))
    waitframe();

  var_0 notify("_encstr_93831FFEAD7BE017011AE898B2E5D7798F550DE012E70B733222F0D0F9FA8391EF");
}

tacmapexplanation(var_0) {}

_id_130C6(var_0) {
  var_0.ondamagerelics["_encstr_B64A0A43D0044B92A7193BF0"] = 1;
  var_0._id_12E85 = [];
  var_0 thread _id_11AA6();
}

_id_13F4C(var_0) {
  var_0.ondamagerelics["_encstr_B64A0A43D0044B92A7193BF0"] = 0;
}

setup_wave_spawn_zone_disable() {
  scripts\mp\playeractions::registeractionset("_encstr_9A0406E1E05537AB", ["_encstr_BD6B06A64C87A9E3", "_encstr_92100762872552A643", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05", "_encstr_919007AA5148539DA0"]);
  scripts\mp\playeractions::registeractionset("_encstr_BA0406318C7AD7C8", ["_encstr_BD6B06A64C87A9E3", "_encstr_92100762872552A643"]);
  scripts\mp\playeractions::registeractionset("_encstr_A90406F97B90C8F2", ["_encstr_BD6B06A64C87A9E3", "_encstr_92100762872552A643"]);
  scripts\mp\playeractions::registeractionset("_encstr_A5040662649EFAD0", ["_encstr_BD6B06A64C87A9E3", "_encstr_92100762872552A643"]);
}

complete_vault_assault_retrieve_saw(var_0) {}

_id_1308D(var_0) {
  if(!isDefined(level.playerisprop))
    level.playerisprop = [];

  level.playerisprop[level.playerisprop.size] = "_encstr_A65B084B38A76BEFC350";
}

_id_1308E(var_0) {
  if(!isDefined(level.playerisprop))
    level.playerisprop = [];

  level.playerisprop[level.playerisprop.size] = "_encstr_850707F7E5833355B8";
}

_id_1308B(var_0) {
  if(!isDefined(level.playerisprop))
    level.playerisprop = [];

  level.playerisprop[level.playerisprop.size] = "_encstr_A5450BC280BF4B604068C33187";
}

_id_1308F(var_0) {
  if(!isDefined(level.playerisprop))
    level.playerisprop = [];

  level.playerisprop[level.playerisprop.size] = "_encstr_8EF60E63FBE3D70440A312175B98CF6B";
}

_id_1308C(var_0) {
  if(!isDefined(level.playerisprop))
    level.playerisprop = [];

  level.playerisprop[level.playerisprop.size] = "_encstr_A11904E483B3";
}

_id_13F2B(var_0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "_encstr_A11904E483B3")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "_encstr_A11904E483B3");

    if(level.playerisprop.size < 1)
      _id_13F2F();
  }
}

_id_13F2C(var_0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "_encstr_A65B084B38A76BEFC350")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "_encstr_A65B084B38A76BEFC350");

    if(level.playerisprop.size < 1)
      _id_13F2F();
  }
}

_id_13F2D(var_0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "_encstr_850707F7E5833355B8")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "_encstr_850707F7E5833355B8");

    if(level.playerisprop.size < 1)
      _id_13F2F();
  }
}

_id_13F2A(var_0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "_encstr_A5450BC280BF4B604068C33187")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "_encstr_A5450BC280BF4B604068C33187");

    if(level.playerisprop.size < 1)
      _id_13F2F();
  }
}

_id_13F2E(var_0) {
  if(isDefined(level.playerisprop) && scripts\engine\utility::array_contains(level.playerisprop, "_encstr_8EF60E63FBE3D70440A312175B98CF6B")) {
    level.playerisprop = scripts\engine\utility::array_remove(level.playerisprop, "_encstr_8EF60E63FBE3D70440A312175B98CF6B");

    if(level.playerisprop.size < 1)
      _id_13F2F();
  }
}

_id_13F2F(var_0) {
  level.playerisprop = undefined;
}

_id_1308A(var_0) {
  level.playerismatchpending = 1;
}

_id_13F30(var_0) {
  level.playerismatchpending = undefined;
}

_id_13099(var_0) {
  var_0.persistentrelics["_encstr_8A7D1756A3208B185190403773E15A87B793E9E08733F9C8EF"] = 1;
  var_0._id_12B72 = 0;
}

_id_13F34(var_0) {
  var_0.persistentrelics["_encstr_8A7D1756A3208B185190403773E15A87B793E9E08733F9C8EF"] = 0;
  var_0._id_12B72 = undefined;
}

setup_bot_flag(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(!isDefined(var_0.velo_forward)) {
      wait 0.1;
      continue;
    }

    var_3 = var_0.velo_forward - var_0.origin;
    var_3 = (var_3[0], var_3[1], 0);
    var_4 = length(var_3);

    if(var_4 > 0)
      var_0._id_12B72 = 0;
    else if(isDefined(self._id_14288) && self._id_14288.size < 3)
      var_0._id_12B72 = 1;

    wait 0.25;
  }
}

_id_11AA6() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    waitframe();

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }
    var_0 = propwhistle(self);

    foreach(var_2 in self._id_12E85) {
      if(var_2 == var_0)
        continue;
    }

    switch (var_0) {
      case 2:
      case 1:
        if(scripts\engine\utility::array_contains(self._id_12E85, var_0)) {
          break;
        }

        self._id_12E85 = scripts\engine\utility::array_add(self._id_12E85, var_0);
        scripts\mp\playeractions::allowactionset("_encstr_86AD053164A7FA" + var_0, 0);
        break;
      case 4:
      case 3:
        foreach(var_2 in self._id_12E85) {
          scripts\mp\playeractions::allowactionset("_encstr_86AD053164A7FA" + var_2, 1);
          self._id_12E85 = scripts\engine\utility::array_remove(self._id_12E85, var_2);
        }

        break;
      default:
        break;
    }
  }
}

_id_1201A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(var_2)) {
    return;
  }
  var_6 = var_2;

  if(scripts\cp\cp_laststand::player_in_laststand(var_6)) {
    return;
  }
  switch (propwhistle(var_6)) {
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    default:
      break;
  }
}

_id_12019(var_0, var_1, var_2, var_3, var_4, var_5) {}

propwhistle(var_0) {
  var_1 = var_0.health / var_0.maxhealth;

  if(var_1 <= 0.33)
    return 1;
  else if(var_1 <= 0.66)
    return 2;
  else if(var_1 <= 1.0)
    return 3;
  else
    return 4;
}

tag_convoy_with_objectives(var_0) {}

_id_130CB(var_0) {}

_id_13F51(var_0) {}

setupcirclepeek() {
  level.little_bird_mg_cp_spawncallback = 1;
  level.disable_loot_drop = 1;
  wait 10;
  scripts\cp\cp_munitions::_id_12BE0();
}

tactical_crate_spawn(var_0) {}

_id_130C9(var_0) {
  var_0._id_11E8E = 1;
}

_id_13F4F(var_0) {
  var_0._id_11E8E = undefined;
}

setup_comms_obj_b_goals_and_cover() {
  level.little_bird_mg_cp_onexitvehicle = 1;
  wait 10;
  scripts\cp\cp_munitions::_id_12BE0(["_encstr_99F3154C4EB17BF6D1EB6BD5DCA5474BB7737D58B6DAF6"]);
}

setupbrsquadleader() {
  scripts\cp\cp_modular_spawning::add_global_spawn_function("_encstr_8E8405EA382B2A", ::start_hack);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::_id_12B82))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::_id_12B82);
}

_id_12B82(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_128A2(var_0, var_1, var_4, var_7, var_3);

  if(isDefined(var_3) && var_3 == "_encstr_8DED0A21C79B660BC7588981")
    return int(var_2 * propwatchprematchsettings());
  else
    return int(var_2);
}

_id_128A2(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    return;
  }
  if(_id_12B85(var_2)) {
    var_0._id_12B81 = 1;
    return;
  }

  var_5 = scripts\engine\utility::isbulletdamage(var_4) || var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && var_3 != "_encstr_8BBA05185F8B99";
  var_6 = var_5 && scripts\cp\utility::isheadshot(var_2, var_3, var_4, var_1);

  if(_id_12B86(var_6, var_4)) {
    if(_id_12B80(var_0)) {
      var_0._id_12B81 = 1;
      return;
    }
  }
}

_id_12B80(var_0) {
  var_1 = gettime();
  return var_1 >= var_0._id_12B83;
}

_id_12B86(var_0, var_1) {
  if(istrue(var_0))
    return 1;

  if(isDefined(var_1) && var_1 == "_encstr_8DED0A21C79B660BC7588981")
    return 1;

  return 0;
}

_id_12B85(var_0) {
  if(scripts\cp\cp_agent_damage::is_flashbang(var_0.basename, var_0, undefined))
    return 1;

  return 0;
}

start_hack() {
  var_0 = self.maxhealth;
  var_1 = propwatchprematchsettings();
  var_2 = var_0 * var_1;
  scripts\mp\mp_agent::set_agent_health(var_2);
  self._id_12B83 = gettime();
  self.fnshouldplaypainanim = ::_id_12B84;
}

_id_12B84() {
  if(istrue(self._id_12B81)) {
    self._id_12B83 = gettime() + 2000;
    self._id_12B81 = 0;
    return 1;
  } else
    return 0;
}

propwatchprematchsettings() {
  if(getdvarint("_encstr_B60E181B0F3410EE91DF8391231A2659DDE34053B47070936A9B", 0) != 0)
    return int(getdvarint("_encstr_B60E181B0F3410EE91DF8391231A2659DDE34053B47070936A9B", 0));
  else
    return 10;
}

tactical_boxes(var_0) {}

_id_130C8(var_0) {}

_id_13F4E(var_0) {
  if(scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::_id_12B82))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::_id_12B82);
}

setup_train_entarray() {
  scripts\cp\cp_modular_spawning::add_global_spawn_function("_encstr_8E8405EA382B2A", ::_id_13085);

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::_id_12B76))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::_id_12B76);
}

_id_13085() {
  self.playerforcespawn = [];
}

truckcollision(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1.playerforcespawn, var_0);
}

backtruck(var_0, var_1) {
  var_1.playerforcespawn = scripts\engine\utility::array_add(var_1.playerforcespawn, var_0);
  _id_13F82(var_1);

  if(playergetbestrespawnteammate()) {
    if(var_1.playerforcespawn.size == 1)
      var_1.playergetlaststandpistol = scripts\cp\cp_outline_utility::outlineenableforall(var_1, "_encstr_883219360842533B880A95526367658B68A1E989E040AFA0F721A7", "_encstr_AD4214B3689849BEABFAB35A7A0883FD43F8C78B6BDB");
  }
}

_id_12BE9(var_0, var_1) {
  var_1.playerforcespawn = scripts\engine\utility::array_remove(var_1.playerforcespawn, var_0);
  _id_13F82(var_1);

  if(playergetbestrespawnteammate()) {
    if(shipment_spawnpatchtriggers(var_1)) {
      if(isDefined(var_1.playergetlaststandpistol))
        scripts\cp\cp_outline_utility::outlinedisable(var_1.playergetlaststandpistol, var_1);
    }
  }
}

playergetbestrespawnteammate() {
  if(getdvarint("_encstr_916718E634F6DDD733EDC65D37FA992D9C56EBDE57A31BA5B995", 0) != 0)
    return 1;

  return 0;
}

propsetclonesleft(var_0) {
  if(!playergetbestrespawnmissionorigin(var_0))
    return 1;
  else {
    var_1 = primesneeded(var_0);
    var_2 = propnumflashes(var_0);
    var_3 = var_1 + var_2;
    return var_3;
  }
}

propnumflashes(var_0) {
  var_1 = 0;
  return var_1 * var_0.playerforcespawn.size;
}

primesneeded(var_0) {
  switch (var_0.playerforcespawn.size) {
    case 1:
      return 1;
    case 2:
      return 8;
    case 3:
      return 27;
    case 4:
      return 64;
    default:
      return 64;
  }
}

playerfakesplash(var_0, var_1, var_2) {
  var_2 endon("_encstr_AD75063D571AE108");
  var_2 notify("_encstr_9A4115236706E3C35169C40A2179192B6593CF9FEB3609" + var_1);
  var_2 endon("_encstr_9A4115236706E3C35169C40A2179192B6593CF9FEB3609" + var_1);
  scripts\engine\utility::waittill_any_ents_or_timeout_return(4.5, var_0, "_encstr_8D820B49520F0EC02DDE6367EC");
  _id_12BE9(var_1, var_2);
}

playergetbestrespawnmissionorigin(var_0) {
  return isDefined(var_0.playerforcespawn);
}

_id_13F83(var_0) {
  if(!_id_132D9()) {
    return;
  }
  if(shipment_spawnpatchtriggers(var_0))
    var_0 notify("_encstr_A5D3178CCAD8CAD156F566DE8D5737D7334B9C95BEA5C6DE37");
  else if(!sg_removequestinstance(var_0))
    _id_11A84(var_0);
  else
    objective_icon(var_0.playergetbestdropbagorigin, propsetflashesleft(var_0));
}

_id_11A84(var_0) {
  var_1 = _id_11A83(var_0);
  var_2 = var_0 getentitynumber();
  var_3 = scripts\cp\cp_objectives::requestworldid("_encstr_A9BE1852C8B5BF50E99B6977FD409E87E6861A1AD31DBF84C9BF" + var_2, 22);
  objective_state(var_3, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_3, propsetflashesleft(var_0));
  objective_setbackground(var_3, 1);
  objective_addalltomask(var_3);
  objective_showtoplayersinmask(var_3);
  objective_setplayintro(var_3, 0);
  objective_setplayoutro(var_3, 0);
  objective_setshowdistance(var_3, 0);
  objective_setshowprogress(var_3, 0);
  objective_setfadedisabled(var_3, 1);
  objective_sethot(var_3, 1);
  objective_setpulsate(var_3, 0);
  objective_setshowoncompass(var_3, 0);
  objective_onentity(var_3, var_1);
  var_0.playergetbestdropbagorigin = var_3;
  var_1 thread playerfriendlyto(var_1, var_0, var_2, var_3);
}

playerfriendlyto(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 scripts\engine\utility::_id_143A5("_encstr_A5D3178CCAD8CAD156F566DE8D5737D7334B9C95BEA5C6DE37", "_encstr_AD75063D571AE108");
  scripts\cp\cp_objectives::freeworldid("_encstr_A9BE1852C8B5BF50E99B6977FD409E87E6861A1AD31DBF84C9BF" + var_2);
  objective_delete(var_3);
  var_1.playergetbestdropbagorigin = undefined;
  var_0 delete();
}

_id_11A83(var_0) {
  var_1 = (0, 0, 15);
  var_2 = (23, 8, 0);
  var_3 = "_encstr_BDAB07BA596A43E9EB";
  var_4 = var_0 gettagorigin(var_3);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4 + var_1);
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_5 linkTo(var_0, var_3, var_2, (0, 0, 0));
  return var_5;
}

sg_removequestinstance(var_0) {
  return isDefined(var_0.playergetbestdropbagorigin);
}

_id_13F82(var_0) {
  if(!_id_132D9()) {
    return;
  }
  if(shipment_spawnpatchtriggers(var_0)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0.playerforcespectatorclientwait);
    var_0.playerforcespectatorclientwait = undefined;
  } else if(!sg_playerdisconnect(var_0))
    _id_11A82(var_0);
  else
    setheadiconfriendlyimage(var_0.playerforcespectatorclientwait, propsetflashesleft(var_0));
}

_id_132D9() {
  if(getdvarint("_encstr_9BDC150D4B9156BE667B6C57E67D33B427ACBEA5C6EDCD", 0) != 0)
    return 0;

  return 1;
}

shipment_spawnpatchtriggers(var_0) {
  return var_0.playerforcespawn.size == 0;
}

sg_playerdisconnect(var_0) {
  return isDefined(var_0.playerforcespectatorclientwait);
}

_id_11A82(var_0) {
  var_1 = propsetflashesleft(var_0);
  var_0.playerforcespectatorclientwait = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage("_encstr_9A8507BA4040188D08", var_1, 10, 1, undefined, undefined, undefined, 0, 1);
}

propsetflashesleft(var_0) {
  switch (var_0.playerforcespawn.size) {
    case 1:
      return "_encstr_87DB24FA75F2AECF5E1D4E376A929EDB6F7908E4FAC36FE838405D3348CA853B538A615A18A9";
    case 2:
      return "_encstr_AFDB2486AB46FA5AC6BDE67D33EDB1ABCDEB33969356D74CEDDCBAB9AF8D2B9DAC367D8EDDBD";
    case 3:
      return "_encstr_8F6D26D0D5C8FAD26CBDB97D99DEC6BA6ED799B42759D74CBDB9EA9BEB1B5967CA1BAF8E1AC92B2B";
    case 4:
      return "_encstr_971B25EB3D8211E820C702211D6756BB47E7CDF32203D0AAE7E0AB10E914189B47DA311B783B0B";
  }
}

_id_12018(var_0, var_1, var_2, var_3, var_4, var_5) {
  return;
}

_id_12014(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_2) && isPlayer(var_2)) {
    return;
  }
  if(isDefined(var_0.owner) && isPlayer(var_0.owner))
    var_0 = var_0.owner;

  if(!(isDefined(var_0) && isPlayer(var_0))) {
    return;
  }
  var_6 = var_0 getentitynumber();

  if(!truckcollision(var_6, var_2))
    backtruck(var_6, var_2);

  var_2 thread playerfakesplash(var_0, var_6, var_2);
}

_id_12B76(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = propsetclonesleft(var_0);
  return int(var_2 * var_8);
}

tacinsert_destroyuselistener(var_0) {}

_id_130BC(var_0) {
  var_0.ondamagerelics["_encstr_91851193AC36B4B1BE99DEB1D56EBE99B4C9B2"] = 1;
  var_0._id_12015["_encstr_91851193AC36B4B1BE99DEB1D56EBE99B4C9B2"] = 1;
}

_id_13F42(var_0) {
  var_0.ondamagerelics["_encstr_91851193AC36B4B1BE99DEB1D56EBE99B4C9B2"] = 0;
  var_0._id_12015["_encstr_91851193AC36B4B1BE99DEB1D56EBE99B4C9B2"] = 0;

  if(scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::_id_12B76))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::_id_12B76);
}

tacinsert_gamemode_callback(var_0) {}

_id_130BD(var_0) {
  var_0.onkillrelics["_encstr_A65811E4598D4BC6FAECC2CDBEADB0938E9793"] = 1;
}

_id_13F43(var_0) {
  var_0.onkillrelics["_encstr_A65811E4598D4BC6FAECC2CDBEADB0938E9793"] = 0;
}

setuphqs(var_0, var_1, var_2, var_3, var_4, var_5) {
  setuphelilandingposition(var_0, var_1, var_2, var_3, var_4, var_5, ::propwaitminigamebuttonwatch);
}

propwaitminigamebuttonwatch() {
  return ["_encstr_B8D30758E3EE7827BA"];
}

tacmapvo(var_0) {}

_id_130C7(var_0) {
  var_0.onkillrelics["_encstr_ACCF10932BC6B46CD7B62C2747CB9391DED6"] = 1;
}

_id_13F4D(var_0) {
  var_0.onkillrelics["_encstr_ACCF10932BC6B46CD7B62C2747CB9391DED6"] = 0;
}

setuphelitimer(var_0, var_1, var_2, var_3, var_4, var_5) {
  setuphelilandingposition(var_0, var_1, var_2, var_3, var_4, var_5, ::putinlaststand);
}

setuphelilandingposition(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 147456;
  var_8 = "_encstr_8EEC09159F6238030BFA23";

  if(isDefined(var_2.unittype) && var_2.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B") {
    return;
  }
  var_9 = 15;
  var_10 = anglesToForward(var_2.angles);
  var_11 = var_2 gettagorigin(var_8) + var_10 * var_9;
  var_12 = [[var_6]]();
  var_13 = var_2;
  var_14 = scripts\engine\utility::random(var_12);
  var_15 = var_13 launchgrenade(var_14, var_11, var_10 * propwaitminigamecleanuponplayernotify(var_14), propwaitminigamefalltimer(var_14));

  if(var_14 == "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B")
    var_15.owner = var_2;
  else {
    var_15.owner = spawnStruct();
    var_15.owner.team = "_encstr_8E8405EA382B2A";
  }

  var_15.team = "_encstr_8E8405EA382B2A";

  switch (var_14) {
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
      level thread lootsource(var_15);
      break;
    case "_encstr_BA730BF8AFF178988293F158B9":
      level thread scripts\cp\powers\coop_molotov::bomber_shouldusetraversals(var_13, var_15);
      break;
    case "_encstr_B8D30758E3EE7827BA":
      var_13 thread scripts\cp\equipment\cp_gas_grenade::gas_used(var_15);
      break;
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
      var_15 thread scripts\cp\cp_weapon::watchconcussiongrenadeexplode();
      break;
  }
}

lootsource(var_0) {
  var_0 endon("_encstr_8F5C086405E70FBA4B4A");
  var_0 waittill("_encstr_860808CB78E2984063BA", var_1);
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");

  if(var_2.size > 0) {
    var_3 = scripts\engine\utility::getclosest(var_1, var_2);
    var_3 radiusdamage(var_1, 256, 140, 70, var_3, "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421", getcompleteweaponname("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B"));
  } else
    radiusdamage(var_1, 256, 140, 70, undefined, "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421", getcompleteweaponname("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B"));
}

putinlaststand() {
  var_0 = ["_encstr_8C4A10BA936F7F31D0159D6ECB304757814B"];
  var_1 = getDvar("_encstr_8B4A18ADB0278E979C46BDB5F53B2756B9163295EBD1F2C15637", "_encstr_B40101");

  if(var_1 != "_encstr_B40101")
    return powered_on_model(var_1);
  else
    return var_0;
}

powered_on_model(var_0) {
  var_1 = strtok(var_0, "_encstr_964C0249");
  var_2 = [];

  foreach(var_4 in var_1)
  var_2 = scripts\engine\utility::array_add(var_2, prematchinfinitammo(var_4));

  return var_2;
}

prematchinfinitammo(var_0) {
  switch (var_0) {
    case "_encstr_8A78055C8D488C":
      return "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B";
    case "_encstr_9B1804C793EB":
      return "_encstr_B8D30758E3EE7827BA";
    case "_encstr_8DCB085BEF657B4DCF0B":
      return "_encstr_BA730BF8AFF178988293F158B9";
    case "_encstr_86BA0B806A05670B67C30308A6":
      return "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B";
    default:
  }
}

propwaitminigamecleanuponplayernotify(var_0) {
  switch (var_0) {
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
      return 40;
    case "_encstr_B8D30758E3EE7827BA":
      return 400;
    case "_encstr_BA730BF8AFF178988293F158B9":
      return 400;
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
      return 120;
    default:
      return 100;
  }
}

propwaitminigamefalltimer(var_0) {
  switch (var_0) {
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
      return 1.5;
    case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
      return 1.0;
    default:
      return 1.5;
  }
}

tacinsert_monitorupdatespawnposition(var_0) {}

_id_130BF(var_0) {
  var_0.persistentrelics["_encstr_AB310F55277203A09F1F6318098FF8495A"] = 1;
  var_0 thread _id_124A9(var_0);
  var_0 thread _id_124A8(var_0);
}

_id_124A8(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_B2C3225063B1E203E36904153D695FA915FFA138AF509BBF9B8F0F9F5592E7B348A79098");
  var_0 endon("_encstr_B2C3225063B1E203E36904153D695FA915FFA138AF509BBF9B8F0F9F5592E7B348A79098");
  var_0 endon("_encstr_8BFB0F2BE830D750C7F01F366174207B70");
  var_0 waittill("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  var_0.set_stealth_enabled = var_0.primaryweaponobj;

  for(;;) {
    var_0 waittill("_encstr_B10A154F2D4569C789C027C7B061A0A34F445746179FB2");
    var_1 = race_ui_show_record(var_0);
    var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1, undefined, undefined, 1);
    var_0 givemaxammo(var_1);
    var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 0);
    var_0 scripts\engine\utility::_id_143B9(1, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
    var_0 takeweapon(var_0.set_stealth_enabled);
    var_0.set_stealth_enabled = var_1;
  }
}

setupdogtags(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_8B2A18085AD599D8CF30D5560B27E371FF5260E9B36D8731872D");
  var_0 endon("_encstr_8B2A18085AD599D8CF30D5560B27E371FF5260E9B36D8731872D");
  var_0 endon("_encstr_8BFB0F2BE830D750C7F01F366174207B70");

  for(;;) {
    var_0 waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_2);

    if(isDefined(var_0.set_stealth_enabled) && !scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      var_3 = var_0 getweaponammoclip(var_0.set_stealth_enabled) + var_0 getweaponammostock(var_0.set_stealth_enabled);

      if(var_3 == 0)
        var_0 notify("_encstr_B10A154F2D4569C789C027C7B061A0A34F445746179FB2");

      if(!var_0 hasweapon(var_0.set_stealth_enabled))
        var_0 notify("_encstr_B10A154F2D4569C789C027C7B061A0A34F445746179FB2");
    }
  }
}

_id_124A9(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_BDA32C297BDA73F8AA0909436D5F30A7F2A7FFB5E792B5E0DD9C9259D95F68EF7B2765674B8A86C0D7B3D8D0BD3B");
  var_0 endon("_encstr_BDA32C297BDA73F8AA0909436D5F30A7F2A7FFB5E792B5E0DD9C9259D95F68EF7B2765674B8A86C0D7B3D8D0BD3B");
  var_0 endon("_encstr_8BFB0F2BE830D750C7F01F366174207B70");

  for(;;) {
    var_0 waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2);

    if(var_1 == "_encstr_A5EF0DF98DF99B2651677B6157FAED" || var_1 == "_encstr_88D00B37718B3BE3F7ED25D31C" || var_1 == "_encstr_81EC128DC6859BCDD75B95E657D76CD8ED6ECAC8") {
      break;
    }
  }

  for(;;) {
    var_0 waittill("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

    if(isDefined(var_0.secondaryweaponobj))
      var_0 takeweapon(var_0.secondaryweaponobj);

    powerscooldown(var_0);
  }
}

race_ui_show_record(var_0) {
  var_1 = var_0._id_12A04[var_0._id_12A03];
  var_0._id_12A03++;

  if(var_0._id_12A03 == var_0._id_12A04.size)
    var_0._id_12A03 = 0;

  return var_1;
}

powerscooldown(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 10; var_2++) {
    if(isDefined(var_0.intro_drive_along_path) && var_2 == var_0.intro_drive_along_path) {
      continue;
    }
    var_3 = init_intro_anims(var_0, var_2);
    var_1[var_1.size] = var_3;
  }

  for(var_4 = 0; var_4 < 10; var_4++)
    var_1 = scripts\engine\utility::array_randomize(var_1);

  if(isDefined(var_0.intro_drive_along_path)) {
    var_3 = init_intro_anims(var_0, var_0.intro_drive_along_path);
    var_1[var_1.size] = var_3;
  }

  var_0._id_12A03 = 0;
  var_0._id_12A04 = var_1;
}

init_intro_anims(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = var_0 scripts\cp\cp_loadout::loadout_updateclasscustom(var_2, var_1);
  var_4 = scripts\cp\cp_weapon::buildweapon(var_3.loadoutprimary, var_3.loadoutprimaryattachments, var_3.loadoutprimarycamo, var_3.loadoutprimaryreticle, var_3.loadoutprimaryvariantid, var_3.loadoutprimaryattachmentids, var_3.loadoutprimarycosmeticattachment, var_3.loadoutprimarystickers, istrue(var_3.loadouthasnvg));
  var_4 = scripts\cp\cp_loadout::scriptable_door_get_in_radius(var_0, var_4);
  return var_4;
}

_id_13F45(var_0) {
  var_0.persistentrelics["_encstr_AB310F55277203A09F1F6318098FF8495A"] = 0;
  var_0 notify("_encstr_8BFB0F2BE830D750C7F01F366174207B70");
}

taccover_timeout(var_0) {}

_id_130B4(var_0) {
  var_0._id_1389A = 0.0;
}

_id_13F3C(var_0) {
  var_0._id_1389A = undefined;
}

setup_next_advance() {
  level thread _id_137A2();
}

_id_137A2(var_0) {
  wait 45;
  level.little_bird_mg_mp_init = undefined;

  switch (level.script) {
    case "_encstr_86A90F8D07AF0B4EB6E67DC82B2C36AC39":
      level thread scripts\cp\killstreaks\gunship_cp::notcanon(75, undefined, (-18750.2, 9332.44, 0), 40000, 15000, var_0);
      break;
    case "_encstr_93580C1B837DB9DAAECED936B239":
      level thread scripts\cp\killstreaks\gunship_cp::notcanon(45, undefined, undefined, 40000, 15000, var_0);
      break;
    case "_encstr_96250E8F105945B875F131AFB3CBAEB7":
      level thread scripts\cp\killstreaks\gunship_cp::notcanon(45, undefined, (3289.02, 45965.8, 0), 40000, 15000, var_0);
      break;
    default:
      level thread scripts\cp\killstreaks\gunship_cp::notcanon(45, undefined, undefined, undefined, undefined, var_0);
      break;
  }
}

tac_rover_horn(var_0) {}

_id_130AE(var_0) {
  scripts\cp\cp_modular_spawning::add_global_spawn_function("_encstr_8E8405EA382B2A", ::_id_130AF);

  foreach(var_2 in level.spawned_enemies)
  var_2 _id_130AF();
}

_id_13F36(var_0) {
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("_encstr_8E8405EA382B2A", ::_id_130AF);

  foreach(var_2 in level.spawned_enemies)
  var_2 _id_13F37();
}

_id_130AF() {
  thread bistrexactive(self);
  self.fnmeleecharge_init = ::bisthread;

  if(self.meleechargedistvsplayer < 3000) {
    self.bisoverwatch = 1;
    self._id_12146 = self.meleechargedistvsplayer;
    self.meleechargedistvsplayer = 3000;
  }
}

_id_13F37() {
  self.fnmeleecharge_init = undefined;
  self notify("_encstr_A6492443335FB0982ADF87B5CF53D630FECF289A11BBA84F23BFFF91CFFB903994A653D107F4");

  if(istrue(self.bisoverwatch)) {
    self.meleechargedistvsplayer = self._id_12146;
    self._id_12146 = undefined;
    self.bisoverwatch = undefined;
  }
}

bisthread(var_0) {
  self.melee.bignoretimeout = 1;
  self.melee.bignoretargetflee = 1;
}

bistrexactive(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A6492443335FB0982ADF87B5CF53D630FECF289A11BBA84F23BFFF91CFFB903994A653D107F4");

  for(;;) {
    if(isDefined(var_0.enemy) && isPlayer(var_0.enemy)) {
      var_1 = getclosestpointonnavmesh(var_0.enemy.origin);
      var_0 setgoalpos(var_1);
    }

    wait 1;
  }
}

take_time_away_from_bomb_vest_timer(var_0) {
  var_0._id_12BAB = 1;
  var_0 setcamerathirdperson(1);
}

_id_130D7(var_0) {
  var_0._id_12BAB = 1;
  var_0 thread _id_130F4();
}

_id_130F4() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;
  self setcamerathirdperson(1);
}

_id_13F5C(var_0) {
  var_0._id_12BAB = undefined;
  var_0 setcamerathirdperson(0);
}

tag_usb_with_head_icon(var_0) {
  var_0.little_bird = 1;
}

_id_130CD(var_0) {
  var_0.little_bird = 1;
}

_id_13F53(var_0) {
  var_0.little_bird = undefined;
}

takelaststandtransitionweapon(var_0) {
  var_0 thread _id_13F8F();
}

_id_12BAE() {
  level._id_12BAC = 1;
  setomnvar("_encstr_93F811AB5A7D6EA1EDDD34ACB0D8E80D4CB027", 1);
}

_id_130D9(var_0) {
  var_0.ondamagerelics["_encstr_9ACF0E321D6922DB56704F6758C882AA"] = 1;
}

_id_13F5E(var_0) {
  level._id_12BAC = 0;
}

_id_1201D(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isagent(var_2)) {
    return;
  }
  var_6 = undefined;

  if(!isPlayer(var_0)) {
    if(!isDefined(var_0.owner))
      return;
    else
      var_6 = var_0.owner;
  } else
    var_6 = var_0;

  if(isDefined(var_6) && !istrue(var_6.inlaststand)) {
    if(var_6.health + 5 > var_6.maxhealth)
      var_6 scripts\cp\cp_damage::set_normalhealth(var_6.maxhealth / var_6.maxhealth);
    else
      var_6 scripts\cp\cp_damage::set_normalhealth((var_6.health + 5) / var_6.maxhealth);

    if(!isDefined(var_6.waittill_player_completes_assassination_contract))
      var_6.waittill_player_completes_assassination_contract = 0;

    if(gettime() < var_6.waittill_player_completes_assassination_contract) {
      return;
    }
    var_6.waittill_player_completes_assassination_contract = gettime() + 300;
    var_6 thread _id_12BAD();
  }
}

_id_12BAD() {
  self endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 0.25;
  self setclientomnvar("_encstr_923E15B9113560D4F7A999E112AB1E28CE63473BBB1DC0", "_encstr_A6EC0EF149031025DB5AC8D1324FE8F8");
  self setclientomnvar("_encstr_84E21C0A61F9D78F70DF0E15B3A0161F16D831428940B3C9409714115D60", gettime());

  if(!isDefined(self.waittill_player_completes_scavenger_contract))
    self.waittill_player_completes_scavenger_contract = 0;

  if(gettime() < self.waittill_player_completes_scavenger_contract) {
    return;
  }
  self playlocalsound("_encstr_91D513E0EB892AF70B1F4B358A87F7332396272BAE");
  self.waittill_player_completes_scavenger_contract = gettime() + 500;
}

tacinsert_pickuplistener(var_0) {
  var_0 thread _id_13F8F();
}

_id_12B79() {
  level._id_12B78 = 1;
  setomnvar("_encstr_93F811AB5A7D6EA1EDDD34ACB0D8E80D4CB027", 1);
  level.showsplashtoallexceptteam = getdvarint("_encstr_85A61892BDC9827BF660BFB758CB385BABC65C419373DA8C7B48", 25);
}

_id_130C1(var_0) {
  var_0.onkillrelics["_encstr_B194129C95B196D87DA1CA581B47A1C158B1B6CD"] = 1;
}

_id_13F47(var_0) {
  var_0.onkillrelics["_encstr_B194129C95B196D87DA1CA581B47A1C158B1B6CD"] = 0;
}

_id_12B7A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.audio_fade_in_ext_walla))
    level.audio_fade_in_ext_walla = [];

  if(level.audio_fade_in_ext_walla.size >= 20) {
    level.audio_fade_in_ext_walla[0].trigger.fx delete();
    level.audio_fade_in_ext_walla[0].trigger delete();
    level.audio_fade_in_ext_walla[0] delete();
    waitframe();
  }

  while(isDefined(var_2) && isDefined(var_2.a) && istrue(var_2 scripts\engine\utility::doinglongdeath()))
    wait 0.1;

  var_6 = getgroundposition(var_2.origin, 4, 10);
  var_7 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_6, 0, 72, 72);
  var_7.fx = spawnfx(level._effect["_encstr_BAD211D08A5FE170D4B8037FDB719BB70703A8"], var_6 + (0, 0, 25));
  triggerfx(var_7.fx);
  var_7 thread _id_12B7B();
}

_id_12B7B() {
  self endon("_encstr_B89709384BC66DCAC85D38");
  self endon("_encstr_AD75063D571AE108");
  thread _id_12B7C();
  var_0 = gettime() + 20000;

  while(gettime() < var_0)
    wait 0.05;

  playsoundatpos(self.origin, "_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");
  playFX(level._effect["_encstr_8C3F1240525ED183B368AF965B474B8386DAD008"], self.origin + (0, 0, 25));
  self.fx delete();
  self delete();
}

_id_12B7C() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0) || !var_0 scripts\cp\utility::is_valid_player() || var_0.health == var_0.maxhealth)
      continue;
    else {
      self notify("_encstr_B89709384BC66DCAC85D38");
      var_0 playlocalsound("_encstr_B6521B4D9B5942F899A0A3B5E68C228ABFA11D7BC773196398A7DBE579");
      playFX(level._effect["_encstr_8C3F1240525ED183B368AF965B474B8386DAD008"], self.origin);
      var_1 = var_0 getnormalhealth();

      if(var_1 + int(level.showsplashtoallexceptteam / 100))
        var_0 scripts\cp\cp_damage::set_normalhealth(1);
      else
        var_0 scripts\cp\cp_damage::set_normalhealth(var_1 + int(level.showsplashtoallexceptteam / 100));

      self.fx delete();
      self delete();
      return;
    }
  }
}

tac_rover_initomnvars(var_0) {}

_id_130B2(var_0) {
  level._id_12B6C = 1;
  var_0._id_12020["_encstr_9180142E7DAB30E7F10A384832999BA8E3DFBE28DF77"] = 1;
  var_0._id_11E8E = 1;
}

_id_13F3A(var_0) {
  level._id_12B6C = 0;
  var_0._id_12020["_encstr_9180142E7DAB30E7F10A384832999BA8E3DFBE28DF77"] = 0;
  var_0._id_11E8E = undefined;
}

_id_12B6D(var_0, var_1) {
  if(!isDefined(level.audio_gauntlet_leave_sfx_transition))
    level.audio_gauntlet_leave_sfx_transition = [];

  if(level.audio_gauntlet_leave_sfx_transition.size >= 20) {
    level.audio_gauntlet_leave_sfx_transition[0].trigger delete();
    level.audio_gauntlet_leave_sfx_transition[0] delete();
    waitframe();
  }

  var_2 = redbuttonused(var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, 72, 72);

  if(var_2 == "_encstr_B483058670B0B7")
    var_3.minigun_sweep_to_loc_safe = "_encstr_B483058670B0B7";
  else
    var_3.minigun_sweep_to_loc_safe = "_encstr_8C8D08671D451291C849";

  playsoundatpos(var_0, "_encstr_A28719B5E0F55B5A36D86CDBDC995A39DAEB3A0BEC37BE91C9DB0E");
  var_3 thread _id_12B6E();
}

redbuttonused(var_0) {
  var_1 = undefined;

  switch (var_0.smeansofdeath) {
    case "_encstr_84670F0D974DCF124E3F7A931851A1FB9F":
    case "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215":
    case "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9":
      var_1 = "_encstr_8C8D08671D451291C849";
      break;
    case "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5":
    case "_encstr_9B0D099AD3887D91252954":
    case "_encstr_B45C0E2DFF41B17F437FB870E733FBFF":
    case "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421":
    case "_encstr_911B0C7DA090E9A7F799FD50DD48":
    case "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B":
    case "_encstr_A1ED0BA9FF84562B60BA073E83":
      var_1 = "_encstr_B483058670B0B7";
      break;
  }

  return var_1;
}

_id_12B6E() {
  self endon("_encstr_B89709384BC66DCAC85D38");
  self endon("_encstr_AD75063D571AE108");
  thread _id_12B6F();
  var_0 = gettime() + 20000;

  while(gettime() < var_0)
    wait 0.05;

  setheadiconimage(self.headicon);
  self delete();
}

_id_12B6F() {
  self endon("_encstr_AD75063D571AE108");
  self.headicon = setheadicondrawinmap(self.origin + (0, 0, 14));

  if(self.minigun_sweep_to_loc_safe == "_encstr_B483058670B0B7")
    setheadiconfriendlyimage(self.headicon, "_encstr_A7810ED0BA917D961BBD9BF5856BADDE");
  else
    setheadiconfriendlyimage(self.headicon, "_encstr_8384181CBDC1F97979609B5718133DC281D92715A50FA2AAC138");

  setheadiconsnaptoedges(self.headicon, 29000);
  setheadiconmaxdistance(self.headicon, 10);
  addclienttoheadiconmask(self.headicon, 10);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0) || !var_0 scripts\cp\utility::is_valid_player())
      continue;
    else {
      var_1 = 0;

      if(self.minigun_sweep_to_loc_safe == "_encstr_B483058670B0B7") {
        var_0 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
        var_1 = var_0 scripts\cp\cp_agent_damage::score_spawner_relative_to_objective();
      } else {
        var_0 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");

        if(var_0 _id_132D2()) {
          var_1 = 1;
          var_0 thread scripts\cp\cp_grenade_crate::healthbox_onusedeployable();
        }
      }

      if(var_1) {
        self notify("_encstr_B89709384BC66DCAC85D38");
        playFX(level._effect["_encstr_8F3D0E0F27C16BDA189860B95F14AB99"], self.origin);
        setheadiconimage(self.headicon);
        self delete();
        return;
      }
    }
  }
}

_id_132D2() {
  var_0 = 1;
  var_1 = 1;
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(weapontype(var_4) == "_encstr_96390B3F9BB7FCA569EBAB6AD5") {
      if(var_4.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0") {
        if(self.gl_proj_override == "_encstr_8D7609A4F337C2C9C2BDB7")
          continue;
      }

      if(!scripts\cp\cp_grenade_crate::_id_11B4A(var_4))
        var_1 = 0;
    }

    if(var_4.inventorytype == "_encstr_B4DC085639F9C2779108" && isDefined(var_4.underbarrel) && var_4.underbarrel == "_encstr_BE9708CBAB13138857AD") {
      if(!scripts\cp\cp_grenade_crate::_id_11B4A(var_4))
        var_1 = 0;
    }
  }

  foreach(var_7 in self.powers) {
    if(var_7.charges < var_7.maxcharges)
      var_0 = 0;
  }

  if(!var_0 || !var_1)
    return 1;

  return 0;
}

tag_to_shoot_from(var_0) {}

_id_130CC(var_0) {
  var_0._id_11E8E = 1;
}

_id_13F52(var_0) {
  var_0._id_11E8E = undefined;
}

tacinsert_updatepickupusability(var_0) {}

_id_130C4(var_0) {
  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::_id_12B7F))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::_id_12B7F);
}

_id_13F4A(var_0) {
  level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::_id_12B7F);
}

_id_12B7F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1;

  if(isDefined(var_1) && isPlayer(var_1)) {
    foreach(var_10 in level.players) {
      if(isDefined(var_10) && scripts\cp\cp_laststand::player_in_laststand(var_10))
        var_8++;
    }
  }

  var_12 = int(var_2 * var_8);
  return var_12;
}

tacinsert_brrespawnsplash(var_0) {}

_id_130B6(var_0) {
  var_0.ondamagerelics["_encstr_858811B3AA4B43E8398C3F07BD1AD81F47C2CB"] = 1;
  var_0._id_11E8E = 1;
}

_id_13F3E(var_0) {
  var_0.ondamagerelics["_encstr_858811B3AA4B43E8398C3F07BD1AD81F47C2CB"] = 0;
  var_0._id_11E8E = 0;
}

_id_12017(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  if(isDefined(var_3) && (var_3 == "_encstr_8DED0A21C79B660BC7588981" || var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001"))
    var_0._id_11E8E = 0;
  else
    var_0._id_11E8E = 1;
}

taillightleft(var_0) {}

_id_130D1(var_0) {
  var_0.onkillrelics["_encstr_87FC1730F2BD7BC1CFCA0876BB4F6B4F249A7848C916BBD837"] = 1;
}

_id_13F57(var_0) {
  var_0.onkillrelics["_encstr_87FC1730F2BD7BC1CFCA0876BB4F6B4F249A7848C916BBD837"] = 0;
  var_0 setclientomnvar("_encstr_B11C1855F3D9FEEB807B6A8260E61F361053F7F75DE003773E91", 0);
}

setuphumanpowers(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  if(!isDefined(var_0) || weapontype(var_0) != "_encstr_96390B3F9BB7FCA569EBAB6AD5" || !var_1 hasweapon(var_0)) {
    return;
  }
  var_6 = var_1 getammocount(var_0);
  var_7 = weaponclipsize(var_0);
  var_1 setweaponammoclip(var_0, var_7);
  var_1 setweaponammostock(var_0, var_6 - var_7 + 1);
}

tacinsert_onjoinedteam(var_0) {}

_id_130C0(var_0) {
  var_0.onkillrelics["_encstr_A99212F5751540B67F7A59C1A25375A0ADCD716F"] = 1;
}

_id_13F46(var_0) {
  var_0.onkillrelics["_encstr_A99212F5751540B67F7A59C1A25375A0ADCD716F"] = 0;
  var_0 setclientomnvar("_encstr_B11C1855F3D9FEEB807B6A8260E61F361053F7F75DE003773E91", 0);
}

setup_trap_consoles(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  if(!scripts\cp\utility::isheadshot(var_0, var_4, var_3, var_1)) {
    return;
  }
  if(!isDefined(var_0) || weapontype(var_0) != "_encstr_A6260731BAD8D82BD1" || !var_1 hasweapon(var_0)) {
    return;
  }
  while(var_1 isreloading())
    wait 0.05;

  var_6 = weaponclipsize(var_0);
  var_7 = int(var_6 * 0.25);
  var_7 = int(clamp(var_7, 1, 10));
  var_1 thread _id_12B6A(var_0, var_7);
}

tagtaken(var_0) {}

_id_130D0(var_0) {
  var_0.onkillrelics["_encstr_B2C5134047BCE00F31A20D987E1A552B14DB70E8F7"] = 1;
  var_0 thread _id_12B95();
}

_id_13F56(var_0) {
  var_0.onkillrelics["_encstr_B2C5134047BCE00F31A20D987E1A552B14DB70E8F7"] = 0;
  var_0 setclientomnvar("_encstr_B11C1855F3D9FEEB807B6A8260E61F361053F7F75DE003773E91", 0);
  var_0 notify("_encstr_8252190E3373E788908B4DC580587DDB79E01F0B17C8EDC3A4473D");
  var_0._id_1287F = undefined;
}

_id_12B94() {
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  wait 1;
  self takeallweapons();
  self giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  self switchtoweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  self disableweaponpickup();
  wait 1;
  self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_915110C201FF735285933AA351C30E3A0358", "_encstr_930B07BB1B6B3854FF", 0);
  self setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_930B07BB1B6B3854FF");
  wait 0.5;
  self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_930B07BB1B6B3854FF", 0);
}

_id_12B95() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8252190E3373E788908B4DC580587DDB79E01F0B17C8EDC3A4473D");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0) && weapontype(var_0) == "_encstr_A6260731BAD8D82BD1")
      self._id_1287F = var_0;
    else if(isDefined(self._id_1287F) && !self hasweapon(self._id_1287F))
      self._id_1287F = undefined;

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }
}

setupblueprintpickupweapons(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  if(!isDefined(var_3) || var_3 != "_encstr_8DED0A21C79B660BC7588981" && var_3 != "_encstr_AA230E8CF56CD18DB12FC7E303C8C001") {
    return;
  }
  if(var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001" && isDefined(var_1._id_1287F))
    var_0 = var_1._id_1287F;

  if(!isDefined(var_0) || weapontype(var_0) != "_encstr_A6260731BAD8D82BD1" || !var_1 hasweapon(var_0)) {
    return;
  }
  while(var_1 isreloading())
    wait 0.05;

  var_6 = weaponclipsize(var_0);
  var_7 = int(var_6 * 0.25);
  var_7 = int(clamp(var_7, 1, 10));
  var_1 thread _id_12B6A(var_0, var_7);
}

_id_12B6A(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = self;
  wait 0.75;

  if(!isDefined(var_0) || weapontype(var_0) != "_encstr_A6260731BAD8D82BD1" || !var_3 hasweapon(var_0)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 1;

  var_4 = try_start_fake_infil_chopper("_encstr_B6950E5DDDADF81ED7525039BA33C3E8");
  var_5 = weaponclipsize(var_0);
  var_6 = var_3 getweaponammoclip(var_0);

  if(!istrue(var_4)) {
    var_5 = var_5 + weaponmaxammo(var_0);
    var_6 = var_6 + var_3 getweaponammostock(var_0);
  }

  var_1 = int(min(var_5 - var_6, var_1));

  if(var_1 == 0) {
    return;
  }
  var_7 = var_3 getcurrentweapon() == var_0 || var_3 isinexecutionattack();

  if(var_7)
    var_3 thread _id_12B70(var_1);

  if(var_7 && var_2) {
    while(var_1 > 0) {
      var_8 = var_3 thread _id_12B6B(var_0, var_4);

      if(istrue(var_8))
        var_3 notify("_encstr_8FBF0D1AA0B9AFC110CF4942F16857");
      else
        break;

      wait 0.2;
      var_1--;
    }
  } else {
    var_9 = weaponclipsize(var_0);
    var_10 = var_3 getweaponammoclip(var_0);
    var_11 = var_9 - var_10;

    if(var_11 >= var_1)
      var_3 setweaponammoclip(var_0, var_10 + var_1);
    else {
      var_3 setweaponammoclip(var_0, var_9);

      if(!istrue(var_4)) {
        var_12 = weaponmaxammo(var_0);
        var_13 = var_3 getweaponammostock(var_0);
        var_1 = var_1 - var_11;
        var_14 = int(min(var_12, var_13 + var_1));
        var_3 setweaponammostock(var_0, var_14);
      }
    }

    var_3 notify("_encstr_8FBF0D1AA0B9AFC110CF4942F16857");
  }
}

_id_12B6B(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_0) || weapontype(var_0) != "_encstr_A6260731BAD8D82BD1" || !var_2 hasweapon(var_0)) {
    return;
  }
  var_3 = var_2 getweaponammoclip(var_0);

  if(istrue(var_1) || var_3 < weaponclipsize(var_0)) {
    var_2 setweaponammoclip(var_0, var_3 + 1);
    var_2 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
    return 1;
  } else {
    var_4 = var_2 getweaponammostock(var_0);

    if(var_4 < weaponmaxammo(var_0)) {
      var_2 setweaponammostock(var_0, var_4 + 1);
      var_2 playlocalsound("_encstr_B4DD11D3BDD3134731489F8FC14B396ABFCD9A");
      return 1;
    }
  }

  return 0;
}

_id_12B70(var_0) {
  self notify("_encstr_81D6264EAC63B436F5C1AB9B1B344CD536B12BA3DCD793B277584E46D7A1AE8CEB23D29BE08D0BF2");
  self endon("_encstr_81D6264EAC63B436F5C1AB9B1B344CD536B12BA3DCD793B277584E46D7A1AE8CEB23D29BE08D0BF2");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setclientomnvar("_encstr_B11C1855F3D9FEEB807B6A8260E61F361053F7F75DE003773E91", 0);
  wait 0.25;
  self setclientomnvar("_encstr_B11C1855F3D9FEEB807B6A8260E61F361053F7F75DE003773E91", var_0);
  wait 1.75;
  self setclientomnvar("_encstr_B11C1855F3D9FEEB807B6A8260E61F361053F7F75DE003773E91", 0);
}

take_ai_weapon(var_0) {}

_id_130D4(var_0) {
  var_0.onkillrelics["_encstr_966E11739030A9F27776CB875529DA699840FF"] = 1;
  var_0.ondamagerelics["_encstr_966E11739030A9F27776CB875529DA699840FF"] = 1;
  var_0 thread _id_12BA4();
  var_0 thread _id_12BA7();
  var_0 thread _id_12BA8();
  var_0 thread _id_130D5(var_0);
}

_id_130D5(var_0) {
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  var_1 = var_0.origin;

  while(var_0.origin == var_1)
    wait 0.25;

  var_0 scripts\cp\utility::giveperk("_encstr_BAC518BAA24009C4126563BBD907C003100E0DC7E7248184C5A9");
  var_0 scripts\cp\utility::giveperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3");
  wait 0.05;
  var_0.perk_data["_encstr_86FA0DB595C6592B7D9B1B853658E4"] = 3;
}

_id_13F5A(var_0) {
  var_0 scripts\cp\perks\cp_perks::removeperk("_encstr_BAC518BAA24009C4126563BBD907C003100E0DC7E7248184C5A9");
  var_0 scripts\cp\perks\cp_perks::removeperk("_encstr_A3B1148267AB52014110AB677198C18B71718FFD45C3");
  var_0.onkillrelics["_encstr_966E11739030A9F27776CB875529DA699840FF"] = 0;
  var_0.ondamagerelics["_encstr_966E11739030A9F27776CB875529DA699840FF"] = 0;

  if(isDefined(var_0._id_13413))
    var_0._id_13413 delete();

  var_0 notify("_encstr_83A017FBFB19BA4BD9730B57A99892F2E11177D753B03205D8");
}

setupboardroomcode(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  if(!isDefined(var_3) || var_3 != "_encstr_8DED0A21C79B660BC7588981") {
    return;
  }
  var_1 thread _id_12BA6();
  var_1 playSound("_encstr_92B30D6F234A09E94D1C433D9841E8");
}

_id_1201C(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    return;
  }
  var_2.playerlootleadervalidity = undefined;
  var_2.shouldhelmetpop = undefined;

  if(isDefined(var_2._id_12144) && isDefined(var_2.a))
    var_2.a.disablelongdeath = var_2._id_12144;

  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  if(!isDefined(var_3) || var_3 != "_encstr_8DED0A21C79B660BC7588981") {
    return;
  }
  var_2.playerlootleadervalidity = 1;
  var_2.shouldhelmetpop = 1;

  if(isDefined(var_2.a)) {
    if(isDefined(var_2.a.disablelongdeath))
      var_2._id_12144 = var_2.a.disablelongdeath;

    var_2.a.disablelongdeath = 1;
  }
}

_id_12BA6() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = self;
  var_1 = clamp(self.health + 90, 0, self.maxhealth);
  scripts\cp\cp_damage::set_normalhealth(var_1 / self.maxhealth);
}

_id_12BA7() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_83A017FBFB19BA4BD9730B57A99892F2E11177D753B03205D8");

  while(!isDefined(self.model) || self.model == "_encstr_B40101")
    wait 0.05;

  wait 1;
  var_0 = self gettagorigin("_encstr_ABE50A686906AA5571F1E8E5");
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, 32, 48);
  var_1 enablelinkTo();
  var_1 linkTo(self, "_encstr_ABE50A686906AA5571F1E8E5", (0, 0, 0), (0, 0, 0));
  self._id_13413 = var_1;
  var_1 endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_850E1357739303C8B411A358848CD8502A8FE7EBF3");
    wait 0.3;

    while(self issprintsliding()) {
      self._id_13413 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
      earthquake(0.2, 0.25, self.origin, 100);
      self playRumbleOnEntity("_encstr_B6F00B9B1D8F830F9918182AAB");

      if(isDefined(var_2) && !isPlayer(var_2) && (isai(var_2) || isagent(var_2)) && self issprintsliding()) {
        _id_12BA5(var_2, self, 32, 285);
        physicsexplosionsphere(self.origin, 68, 48, 2.5);
        self playRumbleOnEntity("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2");
        playrumbleonposition("_encstr_877F102E8D025921D70F7B10DB093B9BCAB5", self.origin);
        earthquake(0.5, 0.5, self.origin, 100);

        while(self issprintsliding()) {
          earthquake(0.2, 0.25, self.origin, 100);
          self playRumbleOnEntity("_encstr_B6F00B9B1D8F830F9918182AAB");
          wait 0.05;
        }
      }
    }
  }
}

_id_12BA5(var_0, var_1, var_2, var_3) {
  var_0.open_close_loop = 1;
  var_0.shouldhelmetpop = 1;
  var_4 = var_0.health;
  radiusdamage(var_0.origin + (0, 0, 8), var_2, var_3, var_3 - 1, var_1, "_encstr_8DED0A21C79B660BC7588981");
  var_1.lasthitmarkertime = undefined;
  var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8");
}

_id_12BA4() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_83A017FBFB19BA4BD9730B57A99892F2E11177D753B03205D8");

  for(;;) {
    self waittill("_encstr_8272124FD0706552B7B6CB441FFBC93BDB68BB53");
    var_0 = 250;
    var_1 = anglesToForward(self getplayerangles(1));
    var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
    var_3 = scripts\engine\utility::get_array_of_closest(self.origin, var_2, undefined, undefined, 128);

    if(isDefined(var_3) && var_3.size > 0) {
      var_4 = var_3[0];
      var_5 = var_4 getEye() - (0, 0, 12);
      var_6 = self worldpointinreticle_circle(var_5, 70, 300);
      var_7 = sighttracepassed(var_4 getEye(), self getEye(), 0, var_4);

      if(var_6 && var_7) {
        var_1 = scripts\engine\utility::flatten_vector(var_4.origin - self.origin);
        var_0 = 350;
      } else {}
    }

    self knockback(var_1, var_0);
    wait 0.5;
  }
}

_id_12BA8() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_83A017FBFB19BA4BD9730B57A99892F2E11177D753B03205D8");
  childthread _id_12BA9();

  for(;;) {
    self waittill("_encstr_9AF00D9B3A5DB6C1FA2358D6B0CE59", var_0, var_1, var_2);
    radiusdamage(self.origin, 64, 150, 149, self, "_encstr_8DED0A21C79B660BC7588981");
    playFX(level._effect["_encstr_AB020E433345580FC9F38B8DCBF25840"], self.origin);
    self playRumbleOnEntity("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2");
    playrumbleonposition("_encstr_877F102E8D025921D70F7B10DB093B9BCAB5", self.origin);
    earthquake(0.5, 1.5, self.origin, 100);
  }
}

_id_12BA9() {
  for(;;) {
    while(self isonground())
      wait 0.05;

    var_0 = gettime();
    var_1 = self.origin[2];

    while(!self isonground()) {
      if(self.origin[2] > var_1)
        var_1 = self.origin[2];

      wait 0.05;
    }

    var_2 = max(0, var_1 - self.origin[2]);

    if(var_2 < 128) {
      continue;
    }
    var_3 = (gettime() - var_0) / 1000;
    self notify("_encstr_9AF00D9B3A5DB6C1FA2358D6B0CE59", var_3, var_1, var_2);
  }
}

tags_used(var_0) {}

_id_130CF(var_0) {
  var_0 thread _id_12B92();
}

_id_13F55(var_0) {
  var_0 notify("_encstr_8E8618CBD011213B41D189BB602803F767F01273999BA5BBB9C6");
  var_0 setclientomnvar("_encstr_B11C1855F3D9FEEB807B6A8260E61F361053F7F75DE003773E91", 0);
}

_id_12B92() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8E8618CBD011213B41D189BB602803F767F01273999BA5BBB9C6");
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  wait 0.5;
  thread _id_12B93();

  for(;;) {
    var_0 = self getweaponslistprimaries();

    foreach(var_2 in var_0) {
      if(!isDefined(var_2) || weapontype(var_2) != "_encstr_A6260731BAD8D82BD1") {
        continue;
      }
      var_3 = self getweaponammostock(var_2);

      if(var_3 > 0) {
        var_4 = weaponclipsize(var_2);
        var_5 = self getweaponammoclip(var_2);

        if(var_5 < var_4) {
          var_6 = int(min(var_4, var_5 + var_3));
          thread _id_12B6A(var_2, var_6 - var_5);
        }

        self setweaponammostock(var_2, 0);
      }
    }

    scripts\engine\utility::_id_143A8("_encstr_B2230CB06BB5DEAF1C2D36D6BA1C", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_82720C27D0D170F2D5A0CAC397D1", "_encstr_8FBF0D1AA0B9AFC110CF4942F16857", "_encstr_87741585DADAEDEBE6A3BDD8ADAF9BB71DD7B2DA833A2F");
  }
}

_id_12B93() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8E8618CBD011213B41D189BB602803F767F01273999BA5BBB9C6");

  for(;;) {
    wait 0.05;
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || weapontype(var_0) != "_encstr_A6260731BAD8D82BD1") {
      continue;
    }
    if(self getweaponammostock(var_0) > 0)
      self notify("_encstr_87741585DADAEDEBE6A3BDD8ADAF9BB71DD7B2DA833A2F");
  }
}

tacinsert_getspawnposition(var_0) {}

_id_130BE(var_0) {
  var_0 thread _id_12B77();
}

_id_12B77() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8E401937CA1DFA9CB2D8D2B1BE9D4EBD57B9912B19F5AC9B19B239");

  for(;;) {
    self waittill("_encstr_8A730DD6B72A37C984A7486847CA23");
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || weapontype(var_0) != "_encstr_A6260731BAD8D82BD1") {
      continue;
    }
    var_1 = self getweaponammoclip(var_0);
    self setweaponammoclip(var_0, 0);
    var_2 = self getweaponammostock(var_0);

    while(var_2 == self getweaponammostock(var_0)) {
      if(!self hasweapon(var_0)) {
        break;
      }

      if(!self isreloading() || self getcurrentweapon() != var_0) {
        self setweaponammoclip(var_0, var_1);
        break;
      }

      wait 0.05;
    }
  }
}

_id_13F44(var_0) {
  var_0 notify("_encstr_8E401937CA1DFA9CB2D8D2B1BE9D4EBD57B9912B19F5AC9B19B239");
}

tactical_goal_in_action_thread(var_0) {}

_id_130CA(var_0) {
  var_0.ondamagerelics["_encstr_A96B159CB2C62DB17DCDED4C5D63B156478CC2B558CE56"] = 1;

  if(!scripts\engine\utility::array_contains(level.modifyplayerdamage_relics, ::_id_12B87))
    level.modifyplayerdamage_relics = scripts\engine\utility::array_add(level.modifyplayerdamage_relics, ::_id_12B87);
}

_id_13F50(var_0) {
  var_0.ondamagerelics["_encstr_A96B159CB2C62DB17DCDED4C5D63B156478CC2B558CE56"] = 0;
  level.modifyplayerdamage_relics = scripts\engine\utility::array_remove(level.modifyplayerdamage_relics, ::_id_12B87);
}

_id_12B87(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1))
    return var_2;

  if(!isent(var_1))
    return var_2;

  if(isDefined(var_1.owner)) {
    if(!isPlayer(var_1.owner))
      return var_2;
  }

  if(!isPlayer(var_1))
    return var_2;

  var_8 = scripts\engine\utility::isbulletdamage(var_3) || var_3 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" && var_7 != "_encstr_8BBA05185F8B99";

  if(var_8) {
    if(istrue(var_4.unlockableindex))
      var_8 = 0;
  }

  if(!scripts\cp\pvpe\pvpe::pvpe_enabled()) {
    if(isPlayer(var_1) && isai(var_0)) {
      if(!var_8)
        return var_2;
      else
        return 0;
    } else
      return var_2;
  } else if(!var_8)
    return var_2;
  else
    return 0;
}

takeaccesscardpickup(var_0) {
  level.persistentrelics["_encstr_92AB0B5575BCD71B5F6C8A3FE0"] = ::setupoptimalreadinghint;
}

_id_130D8(var_0) {
  var_0.persistentrelics["_encstr_92AB0B5575BCD71B5F6C8A3FE0"] = 1;
}

_id_13F5D(var_0) {
  var_0.persistentrelics["_encstr_92AB0B5575BCD71B5F6C8A3FE0"] = 0;
}

setupoptimalreadinghint(var_0) {
  self notify("_encstr_86910BE38E321940AD9329984B");
  self endon("_encstr_86910BE38E321940AD9329984B");
  self endon("_encstr_A6F30A230BF77FB9234AFBD9");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 0.05;

    if(!generate_cypher(var_0)) {
      continue;
    }
    var_1 = var_0 getvelocity();
    var_2 = length(var_1);

    if(var_2 < 5) {
      var_0 scripts\cp\utility::allow_player_ignore_me(1);
      var_0.comparescriptindexobscuredspawns = 1;
      var_0 thread getcpscriptedhelidropheight(var_0);
    }
  }
}

getcpscriptedhelidropheight(var_0) {
  self notify("_encstr_B4CE16C6A12BC66DF5CCBD39FA154EACF094CAB5BDD916B1");
  self endon("_encstr_B4CE16C6A12BC66DF5CCBD39FA154EACF094CAB5BDD916B1");

  for(;;) {
    waitframe();
    var_1 = var_0 getvelocity();
    var_2 = length(var_1);

    if(var_2 >= 5) {
      var_0 scripts\cp\utility::allow_player_ignore_me(0);
      var_0.comparescriptindexobscuredspawns = undefined;
      break;
    }
  }
}

generate_cypher(var_0) {
  if(istrue(var_0.inlaststand))
    return 0;

  if(istrue(var_0.comparescriptindexobscuredspawns))
    return 0;

  return 1;
}

tac_rover_initcollision(var_0) {
  var_0.setvalidreviveposition = 0;
}

_id_130B0(var_0) {
  var_0.setvalidreviveposition = 1;
  var_0 thread _id_12B52();
}

_id_13F38(var_0) {
  var_0.setvalidreviveposition = 0;
  var_0 notify("_encstr_ABB910568B77874E673B9F7B9781E378DA05");
}

_id_12B52() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_ABB910568B77874E673B9F7B9781E378DA05");

  for(;;) {
    if(!scripts\cp\utility::is_valid_player()) {
      wait 1;
      continue;
    }

    var_0 = self getcurrentprimaryweapon();

    if(!isDefined(var_0)) {
      wait 1;
      continue;
    }

    var_1 = 0;
    var_2 = weaponclipsize(var_0);

    if(!isDefined(var_2))
      var_2 = 22.5;

    if(var_2 < 1)
      var_2 = 22.5;

    if(weapontype(var_0) == "_encstr_A5450BC280BF4B604068C33187")
      var_1 = 1;

    if(istrue(var_0.ismelee))
      var_1 = 1;

    if(isDefined(var_0.classname)) {
      if(var_0.classname == "_encstr_8BBA05185F8B99")
        var_1 = 1;

      if(var_0.classname == "_encstr_8C8D08671D451291C849")
        var_1 = 1;

      if(var_0.classname == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        var_1 = 1;
    }

    if(self isreloading())
      var_1 = 1;

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_0))
      var_1 = 1;

    if(!var_1) {
      if(isDefined(self.last_weapon) && self.last_weapon == var_0) {
        if(var_0.inventorytype == "_encstr_B4DC085639F9C2779108") {
          if(isDefined(var_0.underbarrel) && var_0.underbarrel == "_encstr_BE9708CBAB13138857AD") {
            var_3 = self getweaponammoclip(var_0);
            var_4 = int(max(0, var_3 - 1));
            self setweaponammoclip(var_0, var_4);
            self setweaponammostock(var_0, 0);
            self notify("_encstr_93BF0D5AE0F9EF8178850919A5A897");
            thread _id_12B70(-1);
            break;
          }
        } else {
          if(var_0 hasattachment("_encstr_AD9C07E0478148252A", 1)) {
            var_5 = self getweaponammoclip(var_0, "_encstr_A5AD056A019C63");
            var_6 = self getweaponammoclip(var_0, "_encstr_8253060E2B5FE330");

            if(!isDefined(self.waittill_any_return_no_endon_death_3))
              self.waittill_any_return_no_endon_death_3 = "_encstr_A5AD056A019C63";

            if(self.waittill_any_return_no_endon_death_3 == "_encstr_A5AD056A019C63") {
              var_4 = int(max(0, var_5 - 1));
              self setweaponammoclip(var_0, var_4, "_encstr_A5AD056A019C63");
              self.waittill_any_return_no_endon_death_3 = "_encstr_8253060E2B5FE330";
            } else {
              var_4 = int(max(0, var_6 - 1));
              self setweaponammoclip(var_0, var_4, "_encstr_8253060E2B5FE330");
              self.waittill_any_return_no_endon_death_3 = "_encstr_A5AD056A019C63";
            }
          } else {
            var_3 = self getweaponammoclip(var_0);
            var_4 = int(max(0, var_3 - 1));
            self setweaponammoclip(var_0, var_4);
          }

          self notify("_encstr_93BF0D5AE0F9EF8178850919A5A897");
          thread _id_12B70(-1);
        }
      }

      var_7 = max(45 / var_2, 0.4);
      self.last_weapon = var_0;
      scripts\engine\utility::_id_143B9(var_7, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
      continue;
    }

    wait 1;
  }
}

taccovertriggerblockers(var_0) {}

_id_130B5(var_0) {
  level._id_12B73 = 1;
  level.disable_hotjoin_via_ac130 = 1;
  level.dogtag_revive = 1;
}

_id_13F3D(var_0) {
  level._id_12B73 = 0;
  level.disable_hotjoin_via_ac130 = 0;
  level.dogtag_revive = 0;
}

tacinserts(var_0) {}

_id_130C5(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_0.playerjailtimeout = var_1;
}

_id_13F4B(var_0) {
  var_0.playerjailtimeout = undefined;
}

tacinsert_destroyongameended(var_0) {}

_id_130BB(var_0) {
  level.get_bleed_out_time = ::_id_12B75;
}

_id_12B75() {
  return 7;
}

_id_13F41(var_0) {
  level.get_bleed_out_time = undefined;
}

tagautopickup(var_0) {}

_id_130CE(var_0) {
  level thread _id_12B8B();
}

_id_13F54(var_0) {
  level notify("_encstr_B85A149C2B1B2D8D7DCDABB6B2E85AB695E4AFAC9B8C");
}

_id_12B8B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B85A149C2B1B2D8D7DCDABB6B2E85AB695E4AFAC9B8C");

  if(isDefined(level._id_12B88)) {
    return;
  }
  level._id_12B88 = spawnStruct();
  level._id_12B88.point_of_no_return = 16;
  level._id_12B88.nuke_clockobject = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 100));
  level._id_12B88.nuke_clockobject dontinterpolate();
  level._id_12B88.nuke_clockobject hide();
  level._id_12B88._id_11EE9 = spawnStruct();
  level._id_12B88._id_11EE9.targetname = "_encstr_A7220E9613A0A77FB50213DACE17879A";
  level._id_12B88._id_11EE9.origin = level._id_12B88.nuke_clockobject.origin;
  level.nuke_expl_struct = level._id_12B88._id_11EE9;
  scripts\engine\utility::flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  wait 0.5;
  var_0 = "_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7";
  var_1 = "_encstr_AD771EB896AAB7A9782B60E06FAC2613523F20BE2D728DB377DF58E803C439B1";
  var_2 = "_encstr_8FEB1878E0B997E84ACFBF8FCD4F1B5A11A0F6AEB713C033B047";
  var_3 = 60;
  var_4 = "_encstr_82A21DA8EA76C399F31FF5782CF723B39F6138B8A28F3910C75B8DF8063728";
  var_5 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));

  switch (var_5) {
    case "_encstr_AC7F0DE0FB29E7698F7CA5254DFFB3":
      var_0 = "_encstr_B23E156EC6B0C6953AAC6E3AD766962759EB59C2391BE5";
      level thread scripts\cp\utility::notify_delay(var_0, 10);
      break;
    case "_encstr_93580C1B837DB9DAAECED936B239":
      level._id_12B88.patrolzone = 1;
      var_0 = "_encstr_AA43162B312CB73C50DB4B25F77085D74E6E62A319F04FF7";
      var_1 = "_encstr_AD771EB896AAB7A9782B60E06FAC2613523F20BE2D728DB377DF58E803C439B1";
      var_2 = "_encstr_8FEB1878E0B997E84ACFBF8FCD4F1B5A11A0F6AEB713C033B047";
      var_3 = 60;
      var_4 = "_encstr_82A21DA8EA76C399F31FF5782CF723B39F6138B8A28F3910C75B8DF8063728";
      var_6 = getDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");

      if(isDefined(var_6) && var_6 == "_encstr_8A12071CD08B1F423B") {
        var_0 = "_encstr_AAC5143618BBCF47E4A9D64139FCAA6750C5B6FBA290";
        level thread scripts\cp\utility::notify_delay(var_0, 5);
      }

      break;
  }

  level waittill(var_0);
  level thread _id_12B8E();
  level thread _id_12B91();
  level thread _id_12B90(var_1, var_2, var_4, var_3);
  waitframe();
  level waittill("_encstr_AF2613A86A259329373EEDEA0D0FD1798A62C8E082");
  var_7 = level._id_12B88.nuke_clockobject.origin;
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_8 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_8.team = "_encstr_8E8405EA382B2A";
  var_8.pers = [];
  var_8.pers["_encstr_8AEF05472BC2D6"] = "_encstr_8E8405EA382B2A";
  var_8.owner = var_8;
  var_9 = var_8 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B8BA05F06B9785", var_8);
  var_8 thread _calloutmarkerping_handleluinotify_acknowledged::nuke_start(var_9);
  level waittill("_encstr_BE250FC643F0F7CF8511833A186F3BAF20");
  wait 5;

  if(istrue(level._id_12B88.patrolzone))
    scripts\cp\cp_objectives::_id_12868("_encstr_A196107F3E40779DEBA0A219C805D7677814");

  var_10 = scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08");

  foreach(var_12 in var_10)
  var_12 suicide();

  foreach(var_15 in level.players)
  var_15 dodamage(var_15.health + 1000, var_15.origin, var_15);

  wait 4;
  var_17 = 0;

  foreach(var_15 in level.players) {
    if(var_15 scripts\cp_mp\utility\player_utility::_isalive())
      var_17 = 1;
  }

  if(var_17)
    level thread[[level.endgame]]("_encstr_8E8405EA382B2A", level.end_game_string_index["_encstr_BA19049B7723"]);
}

_id_12B8E() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B85A149C2B1B2D8D7DCDABB6B2E85AB695E4AFAC9B8C");
  level._id_12B88._id_13B8A = 0;
  level._id_12B88._id_13B8A = _id_12B8A();
  var_0 = getDvar("_encstr_ACFA1697FF53D8E8E59DA0F905DDE80D8B7F3333C32B9DE0", 0);

  if(int(var_0) > 5)
    level._id_12B88._id_13B8A = int(var_0);

  if(soundexists("_encstr_A9790FF37398A906FB2A0251DF117BF3F8"))
    level._id_12B88.nuke_clockobject playSound("_encstr_A9790FF37398A906FB2A0251DF117BF3F8");

  level thread _id_12B8F();
}

_id_12B8F() {
  level endon("_encstr_B85A149C2B1B2D8D7DCDABB6B2E85AB695E4AFAC9B8C");
  setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", gettime() + level._id_12B88._id_13B8A * 1000);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 1);
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 9, 2, 1);

  while(level._id_12B88._id_13B8A > level._id_12B88.point_of_no_return) {
    if(level._id_12B88._id_13B8A % 2 == 0 && soundexists("_encstr_BE75132493BA2792D5BFF72797F06B5E8099DD2B28"))
      level._id_12B88.nuke_clockobject playSound("_encstr_BE75132493BA2792D5BFF72797F06B5E8099DD2B28");

    var_0 = scripts\cp\utility::respawn_flare_wavesv_used_playereffects(level._id_12B88._id_13B8A - 1, 1);

    if(isDefined(var_0))
      level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "_encstr_9A8507BA4040188D08");

    level._id_12B88._id_13B8A = level._id_12B88._id_13B8A - 1;
    wait 1;
  }

  level._id_12B88.play_onboard_plane_vo = 1;
  level notify("_encstr_AF2613A86A259329373EEDEA0D0FD1798A62C8E082");
}

_id_12B90(var_0, var_1, var_2, var_3) {
  level endon("_encstr_BE250FC643F0F7CF8511833A186F3BAF20");
  level waittill(var_0);
  level notify("_encstr_B85A149C2B1B2D8D7DCDABB6B2E85AB695E4AFAC9B8C");
  _calloutmarkerping_handleluinotify_acknowledged::_id_11EDE();
  _calloutmarkerping_handleluinotify_added::_id_13191("_encstr_810B0D6B2147C0F3F857CE3797C4D1", 11, 1, 0);

  if(isDefined(var_1) && isDefined(var_2)) {
    if(!isDefined(var_3))
      var_3 = 60;

    level waittill(var_1);

    if(level._id_12B88._id_13B8A > var_3) {
      level thread _id_12B8F();
      level thread _id_12B90(var_2);
    }
  }
}

_id_12B91() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B85A149C2B1B2D8D7DCDABB6B2E85AB695E4AFAC9B8C");

  for(;;) {
    level waittill("_encstr_960821889873C5094852CA3D27EBF3C3E5703BCF76FB1871909A3110B288A6F2A26B97", var_0);

    if(level._id_12B88._id_13B8A > level._id_12B88.point_of_no_return + 1) {
      if(var_0 == "_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12")
        _id_12B89(15);
      else
        _id_12B89(30);

      if(istrue(level._id_12B88.play_onboard_plane_vo)) {
        _calloutmarkerping_handleluinotify_acknowledged::_id_11EDE();
        level._id_12B88.play_onboard_plane_vo = 0;
        waitframe();
        level thread _id_12B8F();
      }
    }
  }
}

_id_12B89(var_0) {
  if(level.gameskill < 3)
    var_0 = var_0 * 2;

  level._id_12B88._id_13B8A = level._id_12B88._id_13B8A + var_0;
  setomnvar("_encstr_9BA519C8C73F90B3E217E88DAD6A9FB8614B889007DDC94F9A7FF6", gettime() + level._id_12B88._id_13B8A * 1000);
}

_id_12B8A() {
  var_0 = 900;
  var_1 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));

  switch (var_1) {
    case "_encstr_AC7F0DE0FB29E7698F7CA5254DFFB3":
      var_0 = 80;
      level scripts\engine\utility::delaythread(61, scripts\cp\cp_objectives::screenent_c, "_encstr_84BA10B04A453FAB979FC6CA6D9F93FBAB12");
      break;
    case "_encstr_93580C1B837DB9DAAECED936B239":
      var_2 = getDvar("_encstr_84221339B26E1DC2C947D7360D59D85B07F696B947", "_encstr_B40101");

      if(isDefined(var_2) && var_2 == "_encstr_8A12071CD08B1F423B") {
        if(level.gameskill < 3)
          var_0 = 300;
        else
          var_0 = 240;
      } else if(level.gameskill < 3)
        var_0 = 960;
      else
        var_0 = 720;

      break;
  }

  return var_0;
}

tacinsert_tacinsertdestroyedfeedback(var_0) {}

_id_130C2(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_B2B0198E91D0C4FBE854833CEF0706B08887874D8750D508090742");

  for(;;) {
    level scripts\engine\utility::_id_143A5("_encstr_B6041904659B6139FF23F0D183D890AFA2817E857A43CB83AC5788", "_encstr_A56518DE895359C6479667567DDA4BCDA5AD0B83AAC123C2E8CA");

    foreach(var_2 in level.worldobjidpool.active)
    objective_state(var_2.objid, "_encstr_930B07BB1B6B3854FF");
  }
}

_id_13F48(var_0) {
  level notify("_encstr_B2B0198E91D0C4FBE854833CEF0706B08887874D8750D508090742");
}

tacinsert_deleteontoofar(var_0) {}

_id_130BA(var_0) {
  level.explosivedamagemod = 7;
}

_id_13F40(var_0) {
  level.explosivedamagemod = undefined;
}

calldropbag() {
  if(scripts\cp\utility::turn_off_sniper_laser() || scripts\cp\utility::tryingtoleave())
    return 0;

  if(getDvar("_encstr_AD260F8BDAF657224BC3D16335E39BA2E3", "_encstr_B40101") != "_encstr_B40101")
    return 1;

  return 0;
}

tacinsert_cachespawnposition(var_0) {}

_id_130B7(var_0) {
  scripts\cp\cp_modular_spawning::add_global_spawn_function("_encstr_8E8405EA382B2A", ::_id_130B8);

  foreach(var_2 in level.spawned_enemies)
  var_2 _id_130B8();
}

_id_13F3F(var_0) {
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("_encstr_8E8405EA382B2A", ::_id_130B8);

  foreach(var_2 in level.spawned_enemies) {
    if(isDefined(var_2)) {
      var_2 notify("_encstr_A6A7164EB2634BC6FA23ED57C43695D185E0FAAC37465939");
      var_2 notify("_encstr_BD351DC956364B1BF5C8BDEA89C6B21D160ED786CAB10ECA39F59C2BE656E8");

      if(istrue(var_2.a.doinglongdeath)) {
        var_2 scripts\asm\soldier\long_death::longdeathkillme();
        continue;
      }

      var_2.forcelongdeath = undefined;
      var_2.longdeathnoncombat = undefined;
      var_2.invulnerable = 0;
      var_2.health = var_2.maxhealth;
      var_2.skipdyingbackcrawl = undefined;

      if(isDefined(var_2.a))
        var_2.a.force_num_crawls = undefined;
    }
  }
}

_id_130B8() {
  thread _id_130B9();
}

_id_130B9() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A6A7164EB2634BC6FA23ED57C43695D185E0FAAC37465939");

  if(scripts\cp\utility::isjuggernaut()) {
    return;
  }
  if(isDefined(self.unittype) && self.unittype == "_encstr_8EF60E63FBE3D70440A312175B98CF6B") {
    return;
  }
  var_0 = self.health;
  wait 0.05;
  var_1 = self.weapon;

  if(!isDefined(self.weapon) || !issameweapon(self.weapon)) {
    var_2 = self getweaponslistprimaries();

    if(isDefined(var_2) && var_2.size > 0)
      var_1 = var_2[0];
  }

  for(var_3 = 3; var_3 > 0; var_3--) {
    var_4 = var_0;
    self.health = var_0 + var_4;
    var_5 = undefined;

    while(var_4 > 0) {
      self waittill("_encstr_B2BE0788BAF573592F", var_6, var_7, var_8, var_9, var_5);

      if(isDefined(var_7) && isPlayer(var_7))
        var_4 = var_4 - var_6;
    }

    if(scripts\cp\cp_modular_spawning::is_riding_vehicle() || istrue(self.playing_skit) || istrue(self.a.disablelongdeath) || istrue(self.attempting_teleport) || istrue(self.clearsoundsubmixmpbrinfilanim) || isDefined(var_5) && var_5 == "_encstr_9B0D099AD3887D91252954" || isDefined(self.script) && (self.script == "_encstr_84DB09430E5B9A0B6D2001" || self.script == "_encstr_83F30911AECB135CC058C2") || istrue(self._blackboard.animscriptedactive)) {
      self.health = 1;
      return;
    }

    self.invulnerable = 1;
    self.health = 1000;

    if(!isDefined(self.asm.longdeathanims))
      self.asm.longdeathanims = spawnStruct();

    childthread _id_12B74();
    wait 0.05;
    self asmsetstate(self.asmname, "_encstr_87D2121BD0F6F63759D78D7BB9B3BE8CCAC2471A");
    wait 0.8;
    self.invulnerable = 0;
    self.health = var_0;
    wait 3;
    self notify("_encstr_A7C81018BC79F1B7A16055B9589BD7020380");
    self notify("_encstr_8B5815E5A17F102F31DA60F07315A7E9972EFBE6181719");
    self notify("_encstr_BD351DC956364B1BF5C8BDEA89C6B21D160ED786CAB10ECA39F59C2BE656E8");
    self.a.doinglongdeath = undefined;
    scripts\asm\asm::asm_setstate("_encstr_A51317EF8B594AB369E8AF1B70ED9652AF25F5E9F68962E611");

    if(!isDefined(var_1)) {
      var_2 = self getweaponslistprimaries();

      if(isDefined(var_2) && var_2.size > 0)
        var_1 = var_2[0];
    }

    if(isDefined(var_1)) {
      self takeweapon(var_1);
      self giveweapon(var_1);
      _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::forceuseweapon(var_1, "_encstr_BA7F0830B3A7859B60B0");
    }
  }
}

_id_12B74() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A6A7164EB2634BC6FA23ED57C43695D185E0FAAC37465939");
  self endon("_encstr_BD351DC956364B1BF5C8BDEA89C6B21D160ED786CAB10ECA39F59C2BE656E8");
  self.a.force_num_crawls = 3;
  self.skipdyingbackcrawl = 1;
  self.forcelongdeath = 3;
  self.longdeathnoncombat = 1;

  for(;;) {
    self.asm.longdeathanims.earlyfinishtime = undefined;
    self.desiredtimeofdeath = gettime() + 1000;
    self.bulletsinclip = 0;
    wait 0.05;
  }
}

_id_13F8F() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    wait 1;
    thread _id_13F90();
  }
}

_id_13F90() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  elevator_silo_lights(self);

  for(;;) {
    self._id_11FC1 = self.health;
    self._id_11FC4 = self.maxhealth;
    wait 0.1;

    if(self.health != self._id_11FC1 || self.maxhealth != self._id_11FC4)
      elevator_silo_lights(self);
  }
}

elevator_silo_lights(var_0) {
  var_1 = var_0 getentitynumber();
  var_2 = int(var_0.health);
  var_3 = var_0.maxhealth;

  if(istrue(var_0.inlaststand))
    var_4 = 0;

  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_1, "_encstr_B25D0C18B85A22CFD914E7DB5F1C", var_3);
  scripts\cp\cp_persistence::setcoopplayerdata_for_everyone("_encstr_A74B0A55CF2902ABAF0A7A13", var_1, "_encstr_A7120D933079210A8543372E496112", var_2);
}