/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br.gsc
***********************************************/

main() {
  level._id_14434 = 1;
  level.nobroshot = 1;
  level.clearstockondrop = 1;
  level.loadoutdefaultfiresalediscount = 1;
  level.armoronweaponswitchlongpress = 1;
  level.iscacprimaryweapongroup = 1;
  level.noweaponfalloff = 0;
  level.half_size = 2;
  level.vehicle_occupancy_forceweaponswitchallowed = 1;
  level.client_activate = 0;
  level.debug_safehouse_regroup_start = getdvarint("_encstr_812214C8DF22A68D63E987193DEAFF8C976FF8B06FDC", 0);
  level.debug_show2dvotext = getdvarint("_encstr_8752220F078649DA2046FE8518F0F7B0D09BDB87C32DF09EB8EAFC0D77F02DE8B8355B57", 0);
  level.delay_spawn_room_soldiers = getdvarint("_encstr_855B1BCD8DC9BE4C9C7DD6AC3695CA3396CD5AE61A59C9F56C8DB0AD0E", 0);
  level.delay_spawn_tanks = getdvarint("_encstr_85FF1C5636CB57A992A7B8E073DD016D021DC3DE4C12D5F66C77B0C837F5", 120);
  level.deletehistoryhud = getdvarfloat("_encstr_A59218C3C112591BE8D6137BEFBB4F4B1AFBE8482B7EFFF157C2", 1.0);
  level.deletecrateimmediate = getdvarfloat("_encstr_8C0F1702B14887F2F6770F6A5113ABE4F8F8B18A29384C1ACE", 1.0);
  level.deleteallglass = getdvarint("_encstr_87FC1E38923A17E17BE78675BD672B3B293BB860EAD2AB991FCE187886A330D1", 0);
  level.deleteable = getdvarint("_encstr_85211DF3D8256933FBAFDAC521605B2FD7285A7BB8D3DF671068DFF64B489B", 1);
  level.deletescriptableinstanceaftertime_proc = getdvarint("_encstr_B2901DFBC8D3679A7310AF33E34AC9679FB5E8B7ACC7EBF3BB8B83882811EC", 1);
  level.deletesecretstashhud = getdvarfloat("_encstr_8F241D3806D2470A664E680BE8F3175AD2B5359B4F6368DCE653C6D7E9E192", 1.2);
  level.delay_show_balloon = getdvarint("_encstr_AB2A186BDE7AF13E3367FBE34F3B7E280AB97021C6D439E53A9F", 300);
  level.delay_show_marker_to_tv_station = getdvarint("_encstr_A7F1182F6B5AEF53F25F275F494B037F18592583116709304D67", 300);
  level.delay_spawn_nav_repulsor = getdvarint("_encstr_AB871ADCC64EEB264EF5B5B2D71CC9DED4FAABD1F6399BBDFA46B63B", 300);
  level.delay_show_player_clip = getdvarint("_encstr_A65518E6D84EFAC493EBDA95BE0E397B4DF5ABC24EB6F523ADB3", 300);
  level._encstr_8C791A1EBE37BBFEB81837634971A1532BDD2914A68F0239C0880727 = getdvarint("_encstr_88A51A9A8793F7966B109113510B9A6F289BF418B7B2E9FB76BB9AA8", 0);
  level._encstr_B64B1D426837D0A34F0B3376B007BAF317AB34F29C233FE03F7EAAB9B33519 = getdvarint("_encstr_A18A20E63693D798C9EBCD0EB22B3231DBDE6EE8D70ED21BB65707FA2BB92C313656", 1);
  level.decide_new_code = getdvarint("_encstr_B12A1E208A227F89038F666B9A7F70C3C142A048C27D91A2DFDDF85762AB9999", 0);

  if(level.decide_new_code == 1) {
    level.decoy_clearaithreatbiasgroup = getdvarfloat("_encstr_97552193CF6317C335A04307163FE47FEFDF049315375EE0232B010B4FD5FAA0D519E7", 60.0);
    level.decoy_giveassistpoint = getdvarfloat("_encstr_885521931BDDD1C3146A1B3D88C17027BE7FF3A27DF53B2993AB8974079C60682007C5", 90.0);
    level.decoy_delaystoptrackingassist = getdvarfloat("_encstr_81552192F3359739D52AA8E1F3CF84592B690348C9B5F23185C53B73D9B350DFE32ED3", 120.0);
    level.decoy_aicanseeanyplayer = getdvarfloat("_encstr_914D1ECDB193FA13C97DB1D2271B632BD733C9B02DC6475EF55BEA1B47D2BE89", 1.1);
    level.decoy_canseeplayer = getdvarfloat("_encstr_8E4D1E26C36B4E6D3241A088EB0E3941876E2E9751FBD383514A18A8A3A4A773", 1.2);
    level.decoy_aiseenplayerrecently = getdvarfloat("_encstr_B84D1E676F9E51C2087E56DC3368040AE08DFBA7C3C9ABA139ADCB65EB4B6F27", 1.3);
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(level._encstr_B64B1D426837D0A34F0B3376B007BAF317AB34F29C233FE03F7EAAB9B33519 == 1) {
    _keypadscriptableused_bunkeralt::init();
    _keypadscriptableused::init();
    scripts\mp\utility\sound::besttime("_encstr_8A1712055F8EB303E7485AA298FB7FA3E6469698");
  }

  setdvarifuninitialized("_encstr_8AF41BBB6EEDEE7DB2CEB273477D8CB30B9CFA86DB47AF9C95367B0B32", 0);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::init();

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE"))
    level.brkillchainchance = 1;

  level.defend_spawn_crates = getdvarint("_encstr_8FF613B76033DFA26D208FC717593A973BE8238F50", 1.5);
  var_0[0] = scripts\mp\utility\game::getgametype();

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_pullchute("_encstr_AF271030FA259FABDF34F5681CD7F35BCF93"))
    var_0 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::reinforcement_manager("_encstr_AF271030FA259FABDF34F5681CD7F35BCF93");

  scripts\mp\gameobjects::main(var_0);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 0, 0, 1);
    scripts\mp\utility\game::registerlaststandhealthdvar(100);
    scripts\mp\utility\game::registerlaststandrevivehealthdvar(30);
    scripts\mp\utility\game::registerlaststandtimerdvar(60);
    scripts\mp\utility\game::registerlaststandinvulntimerdvar(0);
    scripts\mp\utility\game::registerlaststandsuicidetimerdvar(10);
    scripts\mp\utility\game::registerlaststandrevivetimerdvar(5);
    scripts\mp\utility\game::registerlaststandweapondvar("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
    scripts\mp\utility\game::registerlaststandrevivedecayscaledvar(0.5);
    scripts\mp\utility\game::registerlaststandweapondelaydvar(1.0);

    if(getdvarint("_encstr_925916E7EF1ED14710B857D173F88B9B7B0737134BC82A3D")) {
      setDvar("_encstr_8C851703DE2317BFA33002B968E576AB98B5B581E0E807C669", 0);
      setDvar("_encstr_8D211623792E6786B09742598940CA43DBF1DA9980884F3A", 2);
      setDvar("_encstr_B1EC179F728A6E90AB29C57B83C659FAB96B105F3239604F9B", 2);
      setDvar("_encstr_8F15177F17BB30B0DA7978915B92D0DE70A7D9EB27A2E56BF9", 0);
    } else if(getdvarint("_encstr_91CC10B346F5F93A78B1150961675ADD7F11")) {
      setDvar("_encstr_856E15E68D93D7E0D80BF25639FADA163CA1AC0B8DD134", 50);
      setDvar("_encstr_8C851703DE2317BFA33002B968E576AB98B5B581E0E807C669", 0);
      setDvar("_encstr_8D211623792E6786B09742598940CA43DBF1DA9980884F3A", 2);
      setDvar("_encstr_B1EC179F728A6E90AB29C57B83C659FAB96B105F3239604F9B", 2);
      setDvar("_encstr_8F15177F17BB30B0DA7978915B92D0DE70A7D9EB27A2E56BF9", 0);
    } else {
      setDvar("_encstr_8C851703DE2317BFA33002B968E576AB98B5B581E0E807C669", 1);
      setDvar("_encstr_8D211623792E6786B09742598940CA43DBF1DA9980884F3A", 0);
      setDvar("_encstr_B1EC179F728A6E90AB29C57B83C659FAB96B105F3239604F9B", 0);
      setDvar("_encstr_8F15177F17BB30B0DA7978915B92D0DE70A7D9EB27A2E56BF9", 0);
    }

    setDvar("_encstr_84611C5B966B5F86FDE93B03F01F7D9B8308C4C53EF3CF8D9D89822AC82D", 5);
    setDvar("_encstr_A1711853AE53678EF5F1123A9037037FE881C4EBBD3BF716EFB8", 1);
    setdvarifuninitialized("_encstr_837525DC1BE4FAE0D8C2F2AC4EFAB29B2C89B195A956D8B7E6C8EAD2DC32A0E64682A5CDA3ED63", 0);
    setdvarifuninitialized("_encstr_8663256E6CC9D7C18D0B2F599CEBB12C6EA34DE82CB919A2CD854C63B29ACA36DB3746AE4BCD19", getdvarint("_encstr_837525DC1BE4FAE0D8C2F2AC4EFAB29B2C89B195A956D8B7E6C8EAD2DC32A0E64682A5CDA3ED63", 0));
    setdvarifuninitialized("_encstr_8F4A214057AA3E310A9E0305325141A1F3A3F9F0C75E9199A286F1958C49A769448F78", 2);
    setdvarifuninitialized("_encstr_82CF2768C26A47F3B369B3A55257B883921BF1D89A05798F4F86B3245D1BC161FE529041721EB10313", 1);
    setdvarifuninitialized("_encstr_917A229BB1E4AF83D885F2599CF5B1B0DC3A9AE8B0CD19D438ACAC231491C8A5E85AB737", 1.0);
    setdvarifuninitialized("_encstr_9AED1C0BBFE8A90BBE66A38B0B1F2BD5F8239465F511ED83EED928F310EF", 0);
    setdvarifuninitialized("_encstr_A99824DE0BA386B5EA8910A0A3826B5B7B8FE5586B87E88714538108FADD2D16D35D6CC3EE2F", 1);
  }

  defineplayerloadout();
  updategametypedvars();
  scripts\cp_mp\parachute::initparachutedvars();
  var_1 = "_encstr_96921EB6C1BC1BB1586EDC1DB098B1CAEB9827BE3839ACDAB08E8D34C5C66E9D";
  level._id_1195F = 10;

  if(getDvar("_encstr_976C1A9B6CC9FA31397D2C8D1D0E39B2B5B0E88D4336F65846EDBA3A") != "_encstr_B40101")
    var_1 = "_encstr_B419046BC179" + getDvar("_encstr_976C1A9B6CC9FA31397D2C8D1D0E39B2B5B0E88D4336F65846EDBA3A") + "_encstr_96A70506895E33";

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_BD4C13ABE31D07EE1807A0920148B73B3E38C2732B"))
    level thread _id_12858();
  else
    _id_12859(var_1);

  if(istrue(level.debug_safehouse_regroup_start)) {
    level._id_11C73 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::droptogroundmultitrace;

    if(!istrue(level.debug_show2dvotext))
      level.delay_put_players_in_black_screen = 0;

    level.scriptedphysicaldofenabled = 1;
  }

  thread waitthensetstatgroupreadonly();
  level.teambased = 0;
  level.overridecrateusetime = 0.5;
  level.onplayerscore = ::onplayerscore;
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.modifyplayerdamage = ::brmodifyplayerdamage;
  level._id_11CA1 = ::elevator_lower;
  level._id_120AB = ::_id_120AB;
  level.onplayerdamaged = ::onplayerdamaged;
  level.onnormaldeath = ::onnormaldeath;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.onplayerkilled = ::onplayerkilled;
  level.onsuicidedeath = ::onsuicidedeath;
  level.iconvisall = ::iconvisall;
  level.objvisall = ::objvisall;
  level.ontimelimit = ::ontimelimit;
  level.onplayerjointeam = ::onplayerjointeam;
  level._id_12888 = ::emp_drone_proximity_explode;
  level.parachutetakeweaponscb = scripts\cp_mp\parachute::takeweaponsdefaultfunc;
  level._id_11C7D = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_11C7D;
  level.allowfauxdeath = 0;
  var_2 = istrue(level.debug_safehouse_regroup_start) && !istrue(level.debug_show2dvotext);

  if(var_2)
    level.parachuterestoreweaponscb = ::_id_1195B;
  else
    level.parachuterestoreweaponscb = ::nakeddrop;

  level.modeshoulddofauxdeathfunc = _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::playershoulddofauxdeath;
  level.modeonlaststandfunc = _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::playersetinlaststand;
  level._id_11C79 = ::_id_12551;
  level.endgame = ::brendgame;
  level.laststandweaponcallback = ::brchooselaststandweapon;
  level._id_11C6F = ::_id_11C6F;
  level.preplayerdamaged = ::emp_drone_pick_up_use_think;
  level._id_11C8B = ::enemy_mines_init;
  level._id_11C8C = ::elevator_init;
  level._id_11C6C = ::disabledvehicles;
  level._id_11C84 = ::spawnclientbr;
  level._id_12099 = ::_id_12099;
  level._id_11FFE = ::_id_11FFE;
  level._id_12082 = ::_id_12082;
  level._id_1205C = ::_id_1205C;
  level._id_1203B = ::_id_1203B;
  level._id_120AF = ::_id_120AF;
  level._id_120B0 = ::_id_120B0;
  level._id_11C7A = ::emp_drone_damage_monitor;
  level._id_11C76 = ::dyn_door;
  level._id_12065 = ::_id_12065;
  level._id_125F1 = ::_id_125F1;
  level.waittillmatch_wait = ::waittillmatch_wait;
  level._id_12AD2 = ::endgame_luidecisionreceived;
  level._id_12AD1 = ::endgame_finitewaves_vo;
  level._id_11C65 = ::elements_hidden;
  level._id_11C7E = ::elevator_doors_open;
  level._id_11C66 = ::_id_11C66;
  level._id_11C6B = ::_id_11C6B;
  level._id_11C82 = ::_id_11C82;
  level._id_11C87 = ::_id_11C87;
  level._id_1331D = ::ending_fade_out;
  level.delay_makeuseable = getdvarint("_encstr_8EE91583DA2348F04287090BB3AB30A51762F98BC2839D", 1);
  level.updategameevents = ::demo_debug_nuke;
  level.getinfectedairdropposition = ::debugprintvipstates;
  level.getinfilplayers = ::debugthink;
  level._id_14254 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::delay_then_run_wave_override;
  level.allowclasschoicefunc = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::deregistergasmaskscriptableatframeend;
  level.tacticaltimemod = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B22A108032FEC12DBF59096D39EFC9EBA5CA", 2.5, 0.5, 5);
  level.battle_tracks_stopbattletrackstoalloccupants = scripts\engine\utility::void;
  level._id_1285F = ::prematchperiod;
  level.debug_unlock_silo = getdvarint("_encstr_97D416A791FAE0AAD2290978B3558EDCBF4F173669D8D8F9", 0);
  level.dontshootwhileparachuting = 1;
  level.disablecopycatloadout = 1;
  level.disableinitplayergameobjects = 1;
  level.watch_for_icbm_spawners = 1;
  level.votes = ::votes;
  level.grenade_effect = scripts\cp_mp\killstreaks\chopper_support::debugtimedelta;
  level.calculateclientmatchdataextrainfopayload = ::calculateclientmatchdataextrainfopayload;
  level._id_11A9D = 1;
  level._id_13C34 = ::_id_13C34;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_ABD51F307E8925998D03277F8D4FA10D8F982D5A032D6F31F9C2580315FDCFE4EB", ::br_armor_plate_used);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8", scripts\mp\menus::_id_13733);

  if(istrue(getdvarint("_encstr_9B84136ED89CBE269CD70E9395D6168E6C1A33330B", 0))) {
    level.br_prematchffa = 1;
    level.allowprematchdamage = 1;
    level.recordfinalkillcam = 0;
    level.ignorescoring = 1;
    level.disableweaponstats = 1;
    level.disablestattracking = 1;
    level.prematchaddkillfunc = ::brprematchaddkill;
    level._id_12001 = ::eliminate_drone_attack_max_cooldown;
    level.getarenapickupattachmentoverrides = 1;
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D31199826EB896", 0);
  }

  level.br_prematchloot = [];
  level.br_prematchlootparts = [];
  setomnvar("_encstr_B17E1560778AD811ABBEEEE197316140CF437930C73491", 1);
  setomnvar("_encstr_88D613AE96AFB6D21B8DB12CADAFC6DBC15E1BB0A3", 0);
  level.bypassclasschoicefunc = ::_id_12341;
  setomnvarforallclients("_encstr_8E8510ABB0472A5FC0DFBFB478E92B754B30", 0);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_A37D125F0309EACC78A3FF49FB20F213D3B5CF8B";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_AF980D1B11DA0C576B5A50400312B8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_AC4509137CC2C9F67E8B0B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A76A0FBD4C9AAFACF047C9588DA35AED73"] = "_encstr_AFB515C551487D2235DBDB6F4F555BA450997E8BA8080E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3710FE04ECADAB03A6C34AF56733A5627"] = "_encstr_B49F197C961A03ABB43F1080DFE8C34BA23E6DF62CD1DB309C4728";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_878B0D2B0D55328178B9D41111C0CC"] = "_encstr_977617D8F2BD23832399C5B54FDB6BFB655AF870FA596B785B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_872514BBE31FE24FD0FED25A53F88C29F90B37335B46"] = "_encstr_B1281E04D90F1127DBDA70F011F7330BA34F939023A7DB4B8741A8C8EA0FFB03";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99CB0DCCB44EB93AEB6C96C9B11B2B"] = "_encstr_8CF717507A35BB1BABE1BD3DC72F805D1E12C809624CCD5383";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_92990BE6B2BBAF6CA527D81B56"] = "_encstr_84CD1531868DC85EAB7711CB7722ABB85B5DF98EEDED20";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A6820FFF97DB9AAD5F1F66D06F42334847"] = "_encstr_BEFC1B07A99DE8066BA22309691F33E8B60C9BFF424728586F0A58F3D2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E180DB67BCD4FDD7FA0228BB841D7"] = "_encstr_AFD41B373795CD6FB31F3B0BA1D018EBC6F8C80F4E90251FC5D308CEC8";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3CC128B305334B193FFCD89DE996AE619E80B5F"] = "_encstr_AAB41CB3165BACB9E8C21DACAFC62CCD1D7D6BC2E6EBCD8E2CDC464BCDCE";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_827F0CA01ADBB640298B192B92CB"] = "_encstr_81EF169D16B52BD15E1C95F526588EE88DACE4DEE5B03695";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1"] = "_encstr_AF2F174F154A699BEB60CD5790BEEF03651D03ABB78353E2CB";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC5715B3286162CB5AC00C12E0433F6CF51BFA2AA0051F"] = "_encstr_B24116ECC2B656CD3A2C8EB2D73757071C8D5EBE329CBD38";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2600AB55AC23379FBCF7BDA"] = "_encstr_95F40F422B15F0525891053D718542FB27";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_86810DC329373F59204BC3DC6F2898"] = "_encstr_AB810ED289113F72107BB4AD6F60BC4B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA7D06CD6F805756"] = "_encstr_B465105A20F37FEF93A7646D507B57C26F6A";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_811A07E32DE7BF9B5A"] = "_encstr_9AF711F10AAFA5881369E933AFFBA0F7BFA7A3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD1A078BDD78F11647"] = "_encstr_A5F711EC0B5B2B6EE82CE8ACEB1DEDC1FA91A9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A21A0747ED0EFAA960"] = "_encstr_93F7113B58B5ACCD8E583AACAFE8DE0EEB9A03";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BEBD0BE3B57089ED893357770F"] = "_encstr_B4CD14CE856BCA8E97E095AFA3DB0EEB6AD7D8BDCD95";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1580CA1F74BE0DA6889E880AAE5"] = "_encstr_928615FAA139078B5041CDEF51B8D2A77FF3F1D2C88EDF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B8C0C2DCD13AF4B3D7F98882785"] = "_encstr_834615AF81B3F9A33AF1F761C3AFAA3F424EA15C2777E5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AFDE0DCC4B732DE6D0D7C60BC663CD"] = "_encstr_BA061D57A1E0ED71CDA5E317816EBA2DB0ABC19FD890B98B932FF7E7911923";
  level notify("_encstr_970E16454B71B5C0F18D704979D1B07B9B4F3BD1BF8B8D70");

  if(_encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_B40B18664DCF4419B7F981D0FDA0F78360238A2038A9FE70A7B9())
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA66104318E9F69788AD4776B79123BC07B8"] = "_encstr_AA6C14D35BB1CE011F2E9CDB30E0C9AF69283A0AD86B";

  level.little_bird_mp_initmines = 1;
  level.little_bird_onenterheavydamagestate = ::disable_all_turrets_permanently;
  level.startingspawns = [];
  level._effect["_encstr_A7B20FD5A3BB90D82594BE333C17083752"] = loadfx("_encstr_A11629ECCC3C5EEB39958BD52BB9A3DCBCAD83BE9D0BD6561C63B0E579673387D7DCB5B5AFDC2D3B372C1B");
  level._effect["_encstr_9BA412D0FB18B6BF8294E8866C5AFD396487D048"] = loadfx("_encstr_862E2CC36C9196372358BF57A0FBD49BE771CA3144CBCA554B38F76FDA73BE73AF9615B42057429FD048DBEF80AB");
  level._effect["_encstr_9A4813360C3247EAEB70D12B58C765776878BADD95"] = loadfx("_encstr_8C0D23431118F74274B9BF3751309BE2F87BADCB89F07F3B4137B77F4BCC822948E6729721");
  level._effect["_encstr_926614331B0B190172FE6656EF7FF96F2189CAF5FC1B"] = loadfx("_encstr_A11C2EEC333C7996DD83EB4C4EF2CE2CB656C1B158F2BCB473334B1B5ED999C3D726E4F5161B626603EBC6C6EDBA8C6E");
  level._effect["_encstr_924818FBA869411BC328E9165C48EB998750D243204F86739829"] = loadfx("_encstr_AF8A32BBEF7802CBF36A2F5D6B5E04C8BD87E37056594AF3BAEB5B7906B3DCC877DE2B6EFCA6D8BBF22747716FAB15A9E135F0A0");
  level.bots_ignore_team_balance = 1;
  level._id_11A5D = getdvarint("_encstr_979718D46B08E7BFF120F2FACA404BDDA8C15F30EF786C1F2ED8", 0);
  setDvar("_encstr_8EB10B48F101F2EBF4BEDDDCD6", getdvarint("_encstr_BEF11B1A183B514228C71844C061278032FD4203FFC778DC052C8AE014", 560));
  setDvar("_encstr_B8610BC5BCB99F08E167979F37", getdvarint("_encstr_AB801B93C99ED7362007ADA921E9BE43C9850AFA11FCF764A073DFB801", 561));
  setDvar("_encstr_B6A30B7A9AC413984596A2D429", getdvarint("_encstr_A6371CE6B1E4D7134EFAD6D2736ADBCC3A9816E6192D9B3B42CAD2768647", 560));
  setDvar("_encstr_91210B8D31359451D7313824D9", getdvarint("_encstr_99851CCDD8277D134ED7B5C21E4D7BCC1D6216E6194B373B4256A53B34A3", 561));
  level.modespecificparachutecompletecb = ::parachutecomplete;
  level._id_12036 = ::_id_12036;

  if(!isDefined(level.skipprematchdropspawn))
    level.skipprematchdropspawn = getdvarint("_encstr_8C071D0BBFE8A90BBE66A32A8897FB5AF83B9174D7602783E87BB9A3916C4B", 0);

  level.br_debugsolotest = getdvarint("_encstr_92FC116B801AEE65D8BF9B420B08E983BD572B", 0);

  if(level.br_debugsolotest)
    level.disableforfeit = 1;

  level.br_infils_disabled = getdvarint("_encstr_9B91166E6C27FA13C9F5D2B999A5636EEB322D6E0B268D59", 0) || _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_9B8F06A38D72C380");
  level.br_circle_disabled = getdvarint("_encstr_8D5E16376C9CAF4C39F5D84B396C8DCAD7914B6E0B26632B", 0);
  level.overheatreductionamount = getdvarint("_encstr_8A3122FE2B83A6950DAA9940F3636DB92FC410FB854328A774A2E8D84A3D0B937F7A01E5", 1);
  level.defensefactormod = getdvarint("_encstr_93BF147B21762FCEC8DF0D1EB1C8150708399212C94B", 4);
  level.roundenddelay = 0.5;
  level.postroundtime = 9;
  level._id_12602 = getdvarint("_encstr_856E15E68D93D7E0D80BF25639FADA163CA1AC0B8DD134");
  level._id_11BF1 = getdvarint("_encstr_AD8A1BBBBAC061D2A6373A70A503428D67A6D1BB9AE9D7D8CF0533D56A", 1);
  level.delete_door_clip = getdvarint("_encstr_859F178EEE138F615A5F9838BB6C59010896838DC65ABB8935", -1);
  level.delete_dropped_weapon = getdvarint("_encstr_93551B9B1BC9AFC44EBE1CB2363656E8A9B03C22C2DA2CECB219586EA3", -1);
  level.deletescavengerhud = getdvarint("_encstr_B4E1156E1BE4FA2639BE9B1B5DB3350B1E88855B859DCA", -1);

  if(!isDefined(level.delay_put_players_in_black_screen))
    disabledfeatures();

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroycrateinbadtrigger();
  _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::brvehiclesinit();
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::main();

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A7B606DA83796F4A"))
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::main();

  _encstr_A1B523C367E34230F8FBA28BA2E8B78FADFD8BD313D2D2A8FA637FD78B0D93E8EF8A771F58::define_as_level_infil_driver();
  _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::init();
  initializetweakableoverrides();
  entcleanup();
  _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_9A0A1ADA4BED9BB6F54B372DA35A581B2DF4598DC2631B982CD8B537();
  level thread bush_zones();
  setdvarifuninitialized("_encstr_84DF147B21762FCEC8DF061FC7C8154315788322AB4B", 1);
  setdvarifuninitialized("_encstr_A32317E64BF201803AAEE9593AC37291576BC163CF67A33D95", 3);
  setdvarifuninitialized("_encstr_8A931B8BAB6B992B9B37FF08E3B7BB68F0CDC8F31BCD93053A6BB28569", 600.0);
  setdvarifuninitialized("_encstr_91DD1D6E8D937D3A586C687BB3ACC9BEA35AB559EDBAD1F4D95693E4B41959", 600.0);
  setdvarifuninitialized("_encstr_A93A214BFF82999A0A0EDF1729EB206B13959BB90B0B7581557F0580632F829D5A7947", 600.0);
  setDvar("_encstr_876917B1BDB61CB09BCD9AD8E4B0DAC48D5993A4C246A5BAB9", 12000);
  _id_12803();
}

_id_12803() {
  _encstr_8FA02FC3E815B42B6B66F7BDFF582FFE43A03BFBD883EA9E41CEBFA9991B07059F235211887DE7EB193581AFA0A8DFCA2F::init();
  thread _encstr_8C4222CDD8C92D071DDC79B683BC7616DA958EBC1CCA9B799839EBE9ED9B5937E2ECDC8D::init();
  thread _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::init();
  thread _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::init();
  thread _encstr_86272063EE5BD1037B9032D850808A4F614F53F7470393A82283E9789593B5978ED7::init();
  scripts\mp\utility\sound::besttime("_encstr_A63B11EEB2C21C7BCDFA47EA934E59E8AFC216");

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_A33A0DC9823F814FC12D95A14D37EB"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A33A0DC9823F814FC12D95A14D37EB");
}

waitthensetstatgroupreadonly() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("_encstr_956807294FC34ED073");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("_encstr_95FF08BB2D73137BDCE6");
  }
}

entcleanup() {
  for(var_0 = 1; var_0 < 10; var_0++)
    _delete_ents("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", "_encstr_B4A608203A19875127D9" + var_0);

  _delete_ents("_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B", "_encstr_8E9F0AB1DBD816632BD7C927");
}

_delete_ents(var_0, var_1) {
  var_2 = getEntArray(var_1, var_0);
  scripts\engine\utility::array_call(var_2, ::delete);
}

totalroundtime(var_0) {
  var_1 = tablelookupgetnumcols("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D") - 1;
  var_2["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", var_0 + 1);
  var_2["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A", var_0 + 1);
  var_2["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353", var_0 + 1);
  var_2["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66", var_0 + 1);
  var_2["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3", var_0 + 1);
  var_2["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB", var_0 + 1);
  var_2["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED", var_0 + 1);
  var_2["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3", var_0 + 1);
  var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B", var_0 + 1);
  var_2["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA", var_0 + 1);
  var_2["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7", var_0 + 1);
  var_2["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC", var_0 + 1);
  var_2["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC", var_0 + 1);
  var_2["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA", var_0 + 1);
  var_2["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560", var_0 + 1);
  var_2["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D", var_0 + 1);
  var_2["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB", var_0 + 1);
  var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B", var_0 + 1);
  var_2["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_2["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_968411DCBAC12B4E7D13E4BE563C8E27851BD1";
  var_2["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_96CB0DB3C7BF3CCF5363C0EA92DCCA", var_0 + 1), tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_88CB0DC6B70B237B5D1DA02B27AD46", var_0 + 1), tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_81CB0D4DB85834BAFDA97BA7CDAA27", var_0 + 1), tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_86EA12137F2FDAF73803D760FBF80151F5DD87DE", var_0 + 1), tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_8BEA12C06AA8690A20E32759212A20912B13FF0A", var_0 + 1), tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_83EA1283EF9F6A47889347108B6891E1652D1766", var_0 + 1)];
  var_2["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";

  if(getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0) || getdvarint("_encstr_A614141F9B6A09DE2311F1588BBF01D087F53FBF1852", 0))
    var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_8E5B11B2E2AE4BC1FA134BDCDB1B5D36C227DC";
  else
    var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = tablelookup("_encstr_A9FB158922CEFFB851E7B8B8976A703B114EFEA07EA36D", 0, "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B", var_0 + 1);

  if(getdvarint("_encstr_867419AB1F48096BDE06E23A8B3D8FBF38AB3C14A9F8CE3B087BAB", 0) == 1) {
    if(getdvarint("_encstr_AD3B1CFBA1F6AF4E485F9A912520D5AF9EBB5273EBC54385C80B8497FB88", 0) == 1)
      var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = risktokencount();
    else
      var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_B8F60CFFCAE9A90877F4F810DF35";
  }

  if(getdvarint("_encstr_9718176636E311B0A807C3A0176F55B90793C7FF2501CFABCB", 0) == 1)
    var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_83EB0FFF5980EA49D9134E150BB891A7CE";

  if(getdvarint("_encstr_A1A51C18B21A37C15BC7AD96D43F4839C7BAC80B4B35A9D8D7E1A518BD33", 0) == 1) {
    var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_88FE0D0157202970845121C58E802F";

    if(getdvarint("_encstr_875620B9C69CEB264EEB918946F5932CDC46BDDAB947C23947B2E4B1B7C219BDAED1", 0) == 1)
      var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = risktokencount();
    else
      var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8749135BCAD73DF7B6EE3C2D0DD9BF04D36822B240";
  }

  if(getdvarint("_encstr_91D21C60A7C259FB1ACFC4759BFBC9312495E769AD7AD385B07B20989014", 0) == 1) {
    var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_8BE20ED75722A6731BF84F3064CA126B";

    if(getdvarint("_encstr_A19520CB06FBCF364D59FB62383FEAEF907D2F5DA6837F7A3990834A089B279FABDD", 0) == 1)
      var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = risk_flagspawncountchange();
    else
      var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_97070E2DBBC1EB6BACD74772DAC21B59";
  }

  if(getdvarint("_encstr_928413BBE1B6EF0E081FC9DC51399567D559F172E9", 0) == 1 && getdvarint("_encstr_823511E61B93FA26E47D3399BE1BDB0B91B246", 0) > 0) {
    if(getdvarint("_encstr_823511E61B93FA26E47D3399BE1BDB0B91B246", 0) == 2)
      var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = riskspawn_initialset();
    else
      var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_87050EAB87BF098061DD677FF417226E";

    if(getdvarint("_encstr_823511E61B93FA26E47D3399BE1BDB0B91B246", 0) == 2)
      var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = risktokencountondeath();
    else
      var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_BAF80FE6A1F537867D364B9B46D285E4C1";

    var_2["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBB0B9D41E718D9E922D8582A";
    var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_BD170C5B689B786221E98009A80C";
  }

  if(getdvarint("_encstr_9B4A1E0F1FA860F6D051254BC1CFAF1FD71980A0B9DCD6C7B95D629B506ACB43", 0) == 1)
    var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_A7ED0AD79F73990E28334B92";

  return var_2;
}

searchcircleorigin(var_0, var_1, var_2) {
  if(!isDefined(level.deletescriptableinstanceaftertime))
    level.deletescriptableinstanceaftertime = totalroundtime(var_0);

  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.deletescriptableinstanceaftertime;
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.prevweaponobj = undefined;
  var_3 = scripts\mp\class::loadout_getclassstruct();
  var_3 = scripts\mp\class::loadout_updateclass(var_3, "_encstr_AAAC09D09972B9C83F2B7F");
  scripts\mp\class::preloadandqueueclassstruct(var_3, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "_encstr_AAAC09D09972B9C83F2B7F", var_1, var_1);

  if(!issubstr(var_3.loadoutprimaryobject.basename, "_encstr_9B7805775B17B3"))
    self givestartammo(var_3.loadoutprimaryobject);

  if(!issubstr(var_3.loadoutprimaryobject.basename, "_encstr_9B7805775B17B3"))
    self givestartammo(var_3.loadoutsecondaryobject);

  scriptednode(self);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();

  if(!istrue(var_2))
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_add_to_chopper_boss_drone_target_array();

  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
  self notify("_encstr_B2110C63C02DC5E92388229F9D75");
}

_id_11E23() {
  if(disable_collect_leads()) {
    var_0 = 0;

    if(istrue(self.shouldhumanspawntags)) {
      return;
    }
    var_1 = isDefined(self.shouldhumanspawntags) && !self.shouldhumanspawntags;

    if(var_1)
      var_0 = 1;

    var_2 = disablealltablets();
    searchcircleorigin(var_2, var_0);

    if(var_1)
      self.shouldhumanspawntags = 1;
  } else if(disable_fulton_group_interactions())
    givematchloadoutfordropbags();
  else if(disable_cinematic_skip()) {
    var_3 = disable_usability_for_duration();
    var_4 = disable_timer();
    givematchloadout(var_3, var_4);
  } else
    scripts\mp\utility\script::laststand_dogtags("_encstr_A54AAA4518E771A52632A0B04EBF55500BF8D140698BC0AB4B6E389083C635E8F3606746CF1BC8C177120AA2C96AFF01FFCAE1BB18E331175E6BE880E603893952747638A09299734512C8F80ADDD1B38B177D210C3A41ABBEFAD09033F21BA91385088F6FABC1CF56D3A1D00B41C3E06B270C01F78FF12F3B9B29B882E0AB7873C29D895F3B794B36F308A80BFDB9F9037DB78EAD8BE969CDAEC2AA76DA63E962C9B49B4DD2E3252397AA92");

  if(isDefined(level.obit_activation) && level.obit_activation._id_129DA == 1)
    disablearmorykiosk();
}

nakeddrop() {
  var_0 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::set_solution();

  if(var_0 && _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_AF751F1831D91BFAEB4823ED4128D8E786C6E427D5051F2FE8FA17F8417872D10E"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AF751F1831D91BFAEB4823ED4128D8E786C6E427D5051F2FE8FA17F8417872D10E");

  if(!var_0 && istrue(level.br_prematchstarted) && !istrue(self.gulag)) {
    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C"))
      _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_992B1791C362CB50F215A1F8C7CC91863A1B71278F5A98E82C");
    else
      _id_11E23();
  }

  thread defend_wave_2();
}

_id_1195B() {
  if(istrue(self.use_armor)) {
    self.use_armor = undefined;
    return;
  }

  var_0 = self.class;

  if(istrue(self.thrownspecialcount)) {
    if(istrue(level.scriptedphysicaldofenabled)) {
      if(isDefined(self.wam_sequence))
        var_0 = self.wam_sequence;
    } else {
      self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.br_respawn_loadout;
      var_0 = "_encstr_AAAC09D09972B9C83F2B7F";
    }
  }

  var_1 = scripts\mp\class::preloadandqueueclass(var_0, 1);
  thread scripts\mp\class::swaploadout();

  if(var_0 != "_encstr_AAAC09D09972B9C83F2B7F")
    scripts\cp_mp\utility\inventory_utility::_takeweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

  self._id_13BCC = 0;

  if(!istrue(self._id_1285B)) {
    if(istrue(level.scriptedphysicaldofenabled))
      disablearmorykiosk();
  }

  self._id_1285B = 1;

  if(!istrue(self.thrownspecialcount)) {
    if(istrue(level.br_prematchstarted)) {
      if(istrue(level.scriptedphysicaldofenabled))
        disablearmorykiosk();

      self.thrownspecialcount = 1;
    }
  }

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_BDAB12B7959A7B29F26BE010A314A08372FDAD3D"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_BDAB12B7959A7B29F26BE010A314A08372FDAD3D");

  thread defend_wave_2();
}

managerespawnfade(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  var_5 = 70;
  var_6 = var_1.origin - var_0.origin;
  var_7 = (var_6[0], var_6[1], 0);
  var_8 = 0;

  if(length2d(var_7) > 0.001) {
    var_9 = vectorNormalize(var_7);
    var_10 = vectortoangles(var_9);
    var_8 = angleclamp180(var_10[1]);
  }

  var_11 = var_0.origin;
  var_12 = (cos(var_8), sin(var_8), 0);
  var_12 = vectorNormalize(var_12);
  var_12 = var_12 * var_5;
  var_13 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12A1C(var_11, var_12[0], var_12[1], var_2, var_3, var_4, var_0);

  if(var_13["_encstr_A53009A25003666B9818C6"] < 1.0) {
    var_14 = var_13["_encstr_BD260953AA97E3F014279D"] + (0, 0, 0.001);
    var_15 = var_11 + (0, 0, 30);
    var_16 = scripts\engine\trace::ray_trace(var_15, var_14, var_0, var_4);

    if(var_16["_encstr_A53009A25003666B9818C6"] >= 1.0) {
      var_1 setOrigin(var_14);
      return;
    } else {}
  }

  var_13 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12A1C(var_11, 0, 0, var_2, var_3, var_4);

  if(var_13["_encstr_A53009A25003666B9818C6"] < 1.0) {
    var_17 = var_13["_encstr_BD260953AA97E3F014279D"] + (0, 0, 0.2);
    var_18 = var_13["_encstr_BD260953AA97E3F014279D"] + (0, 0, 1);
    var_19 = playerphysicstrace(var_17, var_18);

    if(var_19 == var_18) {
      var_1 setOrigin(var_13["_encstr_BD260953AA97E3F014279D"]);
      return;
    }
  }

  var_1 kill(var_0.origin);
}

disablearmorykiosk() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_932316AC447BD37F648F9058EB81710982E39F241A62A9E1")) {
    return;
  }
  if(istrue(level.allowsupers)) {
    var_0 = scripts\mp\supers::getcurrentsuper();

    if(isDefined(var_0)) {
      scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
      return;
    }
  } else
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper(self._id_11954);
}

emp_drone(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0))
    return 0;

  if(istrue(var_0.gulag))
    return 0;

  if(!isDefined(var_0.team))
    return 0;

  if(isDefined(var_1) && var_1.team != var_0.team)
    return 0;

  if(isDefined(var_1) && var_1 == var_0)
    return 0;

  return 1;
}

emp_drone_clean_up(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]) || !isDefined(var_0._id_13AB3)) {
    return;
  }
  var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_0.team, 1);
  var_2 = "_encstr_AB3C19EF6B209D2FB8396942408557D27839A76AFDA825D7DBD1B3" + var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"];
  var_3 = getdvarint("_encstr_8FC626B98DE4F526E4BE86AB8C7B5DE88D9637568CF6C9A2B22CAD5BB03A95CD114BB98E16CDB195", 1024);
  var_4 = squared(var_3);
  var_5 = emp_drone(var_0);

  foreach(var_7 in var_1) {
    var_8 = var_7 getentitynumber();
    var_9 = var_5 && emp_drone(var_7, var_0);

    if(var_9) {
      var_10 = distancesquared(var_0.origin, var_7.origin);

      if(var_10 > var_4)
        var_9 = 0;
    }

    if(!var_9) {
      if(isDefined(var_0._id_13AB3[var_8])) {
        scripts\mp\utility\outline::outlinedisable(var_0._id_13AB3[var_8], var_0);
        var_0._id_13AB3[var_8] = undefined;
      }

      continue;
    }

    if(!isDefined(var_0._id_13AB3[var_8]))
      var_0._id_13AB3[var_8] = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_7, var_2, "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  }
}

emp_drone_clean_up_func(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    level waittill("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
    emp_drone_clean_up(var_0);
  }
}

emissive(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"])) {
    return;
  }
  if(!istrue(level.br_infils_disabled))
    var_0 waittill("_encstr_831910EB8313CF31B9121BFFC3FECDF5800D");

  var_0._id_13AB3 = [];
  var_0 thread emp_drone_clean_up_func(var_0);

  for(;;) {
    emp_drone_clean_up(var_0);
    wait 1;
  }
}

initializetweakableoverrides() {
  if(!isDefined(level.tweakablesinitialized))
    thread scripts\mp\tweakables::init();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_A6931266832B0E2D7201E890C8CDE3A1873D6DDE", getmatchrulesdata("_encstr_86DD07314E8816A316", "_encstr_93D10BDD6A0568BF9BF2537BDB"));
  setdynamicdvar("_encstr_8BC01613A7F0B1E3569E4AA3A1AD37BF2817A8BC2B6047FB", getmatchrulesdata("_encstr_86DD07314E8816A316", "_encstr_A1450F0E22AA5119F463D818C3E1D0BB43"));
  setdynamicdvar("_encstr_B4C611670FA32898E241B06837D1A06ECF2699", getmatchrulesdata("_encstr_86DD07314E8816A316", "_encstr_A16B0AD273CC96D8684C9981"));
  setdynamicdvar("_encstr_85AF0DEA59A06F0A1E9F87C7D14F82", getmatchrulesdata("_encstr_86DD07314E8816A316", "_encstr_9B220634456A5747"));
  setdynamicdvar("_encstr_93351E4B1146FF1E182FFBC94DA8A55FF5C92212F9950F136391F9D81990AFDB", getmatchrulesdata("_encstr_86DD07314E8816A316", "_encstr_B81B17B12D9336B1561185AD58B3B235AEC6D1D2E01BA5CA4E"));
  setdynamicdvar("_encstr_B1F616070FFE31A2285E72BBB193FCEA58AF0FD7F327FA96", getmatchrulesdata("_encstr_86DD07314E8816A316", "_encstr_BE9B0FC7F3321E8859ADD1AF1739E0D89A"));
  setdynamicdvar("_encstr_A736126ED893AF4C937D4E7B5773C836D2B6A51D", 1);
  scripts\mp\utility\game::registerroundlimitdvar("_encstr_B607038AAB", 1);
  setdynamicdvar("_encstr_85D210BB0283A0D865771F51A021CB0F681C", 1);
  scripts\mp\utility\game::registerwinlimitdvar("_encstr_B607038AAB", 1);
  setdynamicdvar("_encstr_A1900FCB06FBCF364D599BB3F05BADFBF1", 0);
  scripts\mp\utility\game::registerlaststandinvulntimerdvar(0);
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.numendgame = scripts\mp\utility\dvars::dvarintvalue("_encstr_AD130B9BEAD62AB932D12CD62B", 4, 0, 20);
  level.brloadouts = scripts\mp\utility\dvars::dvarintvalue("_encstr_93D10BDD6A0568BF9BF2537BDB", 0, 0, 5);
  level.cratedroptimer = scripts\mp\utility\dvars::dvarintvalue("_encstr_A1450F0E22AA5119F463D818C3E1D0BB43", 60, 0, 300);
  level.goalenabletimer = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AFF810A238676B8F902B9294CBA94C979D73", 60, 0, 300);
  level.goalmovetimer = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B2EB0EF2F843654F98540D34E3E0D7AA", 0, 0, 300);
  level.radarendgame = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_A7660DC92C19B04E8AE691D1856B59", 1, 0, 1);
  level.infilcanusec130 = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_A16B0AD273CC96D8684C9981", 1, 0, 1);
  level.usegulag = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_9B220634456A5747", 1, 0, 1);
  level.circledamagemultiplier = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_B81B17B12D9336B1561185AD58B3B235AEC6D1D2E01BA5CA4E", 1, 0.5, 4);
  level.startingweapon = scripts\mp\utility\dvars::dvarintvalue("_encstr_BE9B0FC7F3321E8859ADD1AF1739E0D89A", 0, 0, 8);
  level.timetoadd = 30;
}

_id_12341() {
  var_0 = "_encstr_B40101";

  if(!istrue(level.br_prematchstarted) && istrue(level.br_prematchffa))
    var_0 = _id_1234A();
  else {
    var_1 = level.br_loadouts["_encstr_8B1608EC43B8D647A113"];

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_9556123CF5431D5307B2ABD0FBD50FF17B97BD2D"))
      var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_9556123CF5431D5307B2ABD0FBD50FF17B97BD2D");

    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = var_1;
    var_0 = "_encstr_AAAC09D09972B9C83F2B7F";
  }

  self.pers["_encstr_959506B911C79707"] = var_0;
  return var_0;
}

binoculars_clearpendingtimer() {
  if(self calloutmarkerping_getEnt()) {
    if(self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] == "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9")
      self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBB0B9D41E718D9E922D8582A";
  }
}

_id_14290() {
  wait 5.0;
  iprintln("_encstr_AC712D891AB639182F7417347DEB2DF51C6268D0124D75B91F9C4F2E44EFA84F962AA8FA0F3221EB3FB340282CBF58");
  wait 5.0;
  iprintln("_encstr_AF93149BD032C0565F3A59A3C66B18A24AFCBB8D2CCD");
  wait 5.0;
  iprintln("_encstr_8A1F14B22B272D33B4B10B1DB4F69B026ED1C29CD109");

  for(var_0 = 0; var_0 < level._id_1195F; var_0++) {
    iprintln("_encstr_A7C20A21B8B7F12FA3FBDA42" + var_0);
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level._id_1285D[level._id_12861[var_0]];
    self.class = "_encstr_AAAC09D09972B9C83F2B7F";
    scripts\mp\class::preloadandqueueclass(self.pers["_encstr_959506B911C79707"]);
    scripts\mp\class::swaploadout();
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawncover_badnodetest();
    wait 5.0;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
    wait 4.0;
  }

  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level._id_1285D[level._id_12861[0]];
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  scripts\mp\class::preloadandqueueclass(self.pers["_encstr_959506B911C79707"]);
  scripts\mp\class::swaploadout();
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawncover_badnodetest();
  iprintln("_encstr_ACB71311E130D4FEF8599E136A181E71DCD796754F");
}

_id_1234A() {
  var_0 = "_encstr_B40101";

  if(getdvarint("_encstr_BE2818DB6F38793B8E5693FB797027AFA0AF4C5F8370BDAFB5CB", 1)) {
    if(!isDefined(level._id_12861)) {
      level._id_12861 = [];

      for(var_1 = 0; var_1 < level._id_1195F; var_1++)
        level._id_12861[level._id_12861.size] = var_1;

      if(getDvar("_encstr_8893213736E4FA98C97DC13959AD0BE81B34BE63DEC223ED5DD1FAB73BAC4E9C4BC856") == "_encstr_B40101" && getdvarint("_encstr_B67720EE3B93B6A5FA99C050A3D4558ACFB0F66D9D879BEF24A108F88AAF0F43DB5B", 0) == 0)
        level._id_12861 = scripts\engine\utility::array_randomize(level._id_12861);

      self._id_1285C = level._id_1195F - 2;
    }

    if(!isDefined(self._id_1285C) || self._id_1285C < 0 || self._id_1285C >= level._id_1195F - 1)
      self._id_1285C = 0;
    else
      self._id_1285C++;

    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level._id_1285D[level._id_12861[self._id_1285C]];
    var_0 = "_encstr_AAAC09D09972B9C83F2B7F";
    binoculars_clearpendingtimer();
  } else
    var_0 = "_encstr_8B1608EC43B8D647A113" + (randomint(10) + 1);

  return var_0;
}

_id_12858() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.weaponlootmapdata))
    waitframe();

  level._id_1285D = [];
  var_0 = [];
  var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"] = [];
  var_0["_encstr_8614173948920FEF016B1BFB1FCAB0853F0AFAC94006AB662B"] = [];
  var_1 = "_encstr_967921B507CBC68D16DCDC8E16981BACEB134EF507C995DA168E6C867D981CC5B16ECE";
  var_0 = firstinfectedsplash(var_0);

  for(var_3 = 0; var_3 < var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"].size; var_3++) {
    var_4 = var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"][var_3];
    var_5 = var_0["_encstr_8614173948920FEF016B1BFB1FCAB0853F0AFAC94006AB662B"][var_3];
    level._id_1285D[level._id_1285D.size] = _id_1400B(var_1, var_4, var_5);
  }
}

firstinfectedsplash(var_0) {
  var_1 = 0;
  var_2 = 2;
  var_3 = 2;
  var_4 = 1;
  var_5 = 1;
  var_6 = 2;
  var_7 = 2;

  for(var_8 = [var_2, var_3, var_4, var_5, var_6, var_7]; var_1 < var_8.size; var_1++) {
    var_9 = 0;
    var_10 = 0;
    var_11 = 5;

    while(var_9 < var_8[var_1]) {
      var_12 = search_turret_fire_think(var_1);

      if(!scripts\engine\utility::array_contains(var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"], var_12) || var_10 >= var_11) {
        var_9++;
        var_10 = 0;
        var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"][var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"].size] = var_12;
        continue;
      }

      var_10++;
    }
  }

  var_13 = 0;

  for(var_14 = 0; var_14 < var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"].size; var_14++) {
    if(var_13 < 3) {
      if(randomint(4) == 1)
        var_15 = search_turret_fire_think(6);
      else
        var_15 = search_turret_fire_think(5);

      var_13++;
    } else
      var_15 = search_turret_fire_think(7);

    var_0["_encstr_8614173948920FEF016B1BFB1FCAB0853F0AFAC94006AB662B"][var_0["_encstr_8614173948920FEF016B1BFB1FCAB0853F0AFAC94006AB662B"].size] = var_15;
  }

  var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"] = scripts\engine\utility::array_randomize(var_0["_encstr_AAF115E7D8275092F9F7405FF880E0596E9AA15B5B964B"]);
  var_0["_encstr_8614173948920FEF016B1BFB1FCAB0853F0AFAC94006AB662B"] = scripts\engine\utility::array_randomize(var_0["_encstr_8614173948920FEF016B1BFB1FCAB0853F0AFAC94006AB662B"]);
  return var_0;
}

_id_1285A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.weaponlootmapdata))
    waitframe();

  level._id_1285D = [];
  var_0 = "_encstr_A6B71D073050DB7A037E12CB6F2D3265E608E34760931562719EDA5546F74B";
  var_1 = 0;

  for(var_2 = tablelookupgetnumcols(var_0) - 1; var_1 < var_2; var_1++)
    level._id_1285D[level._id_1285D.size] = _id_1402F(var_0, var_1);
}

search_turret_fire_think(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 0:
      var_1 = 0 + randomint(10);
      break;
    case 1:
      var_1 = 10 + randomint(7);
      break;
    case 2:
      var_1 = 23 + randomint(5);
      break;
    case 3:
      var_1 = 28 + randomint(8);
      break;
    case 4:
      var_1 = 36 + randomint(6);
      break;
    case 5:
      var_1 = randomint(42);
      break;
    case 6:
      var_1 = 42 + randomint(3);
      break;
    case 7:
      var_1 = 17 + randomint(6);
      break;
    default:
      break;
  }

  return var_1;
}

_id_1400B(var_0, var_1, var_2) {
  if(var_1 == var_2) {
    if(var_2 > 0)
      var_2--;
    else
      var_2 = 1;
  }

  var_3 = [];
  var_3["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_3["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_9BB9182BB7D71132DB69D990F7D29E302EAB832FD37FD6EA9302"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_872219FD502BAA9F5B584F9F08F0467283765EBA454392D361703E"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_81221930EF31C19713239E9DFEEACD89992310516BC1F9573ACA26"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_88221919F53AE1C855CB89208F972029C25A0B0E8B12B7302DFB82"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_3["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
  var_3["_encstr_96D10CD10B311B2B0DBDC6BAD6DC"] = var_1;
  var_3["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"] = scripts\mp\class::_id_139E4(var_0, var_1, 0);
  var_3["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = scripts\mp\class::table_getweapon(var_0, var_1, 0);

  for(var_4 = 0; var_4 < scripts\mp\class::getmaxprimaryattachments(); var_4++) {
    var_5 = scripts\mp\class::getattachmentloadoutstring(var_4, "_encstr_BA7F0830B3A7859B60B0");
    var_3[var_5] = scripts\mp\class::table_getweaponattachment(var_0, var_1, 0, var_4);
  }

  var_3["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = scripts\mp\class::table_getweaponcamo(var_0, var_1, 0);
  var_3["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = scripts\mp\class::table_getweaponreticle(var_0, var_1, 0);
  var_3["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = scripts\mp\class::_id_139E6(var_0, var_1, 0, var_3["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]);
  var_3["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"] = scripts\mp\class::_id_139E4(var_0, var_2, 0);
  var_3["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = scripts\mp\class::table_getweapon(var_0, var_2, 0);

  for(var_4 = 0; var_4 < scripts\mp\class::getmaxsecondaryattachments(); var_4++) {
    var_5 = scripts\mp\class::getattachmentloadoutstring(var_4, "_encstr_AC8F0AE74163F85AAA380AD8");
    var_3[var_5] = scripts\mp\class::table_getweaponattachment(var_0, var_2, 0, var_4);
  }

  var_3["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = scripts\mp\class::table_getweaponcamo(var_0, var_2, 0);
  var_3["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = scripts\mp\class::table_getweaponreticle(var_0, var_2, 0);
  var_3["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = scripts\mp\class::_id_139E6(var_0, var_2, 0, var_3["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"]);
  var_3["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = riskspawn_getspawnlocationsbytier("_encstr_B116071BCAD186858D");

  if(scripts\engine\utility::cointoss())
    var_3["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"] = "_encstr_AAEF05B9394BAB";
  else
    var_3["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"] = "_encstr_B6C106DFEFC9611D";

  var_3["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = riskspawn_getspawnlocationsbytier("_encstr_99C209E34FC743616118AB");

  if(var_3["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] != "_encstr_84CB0CB2680B841B3E76A5AF0201" && scripts\engine\utility::cointoss())
    var_3["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"] = "_encstr_AAEF05B9394BAB";
  else
    var_3["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"] = "_encstr_B6C106DFEFC9611D";

  var_3["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [];

  for(var_6 = 0; var_6 < 3; var_6++) {
    var_7 = scripts\mp\class::table_getperk(var_0, var_1, var_6);

    if(var_7 != "_encstr_AC9C0FEA0FF30A29692883BF99A00D4249")
      var_3["_encstr_86CB0DFB97F7022F90BB3A7F53487B"][var_3["_encstr_86CB0DFB97F7022F90BB3A7F53487B"].size] = var_7;
  }

  var_3["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  var_3["_encstr_81E6112CD2D9B12F700387D0E8A7C32341A7DD"] = "_encstr_A63C0B33252188F56B439B89EF";
  return var_3;
}

_id_1402F(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_2["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_96312155DF03770863F979C678AFBE024B219FA36DD21B383270F36308C9BC3D578EFD"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_B6FC168DDB85197B5D471439D2DA2C27F2A9A3A58DB6B227"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_91D217989706EACF1D63D7326AE3D33D398E6368A60A97029F"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_8ED217397721CB9863CBFF8BFB079FB890BE63ACCF971A3522"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_B8D21763FFE7E52FFB99EB46A9B9109AC7EF131BE1FC0F4A5F"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_9BB9182BB7D71132DB69D990F7D29E302EAB832FD37FD6EA9302"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_872219FD502BAA9F5B584F9F08F0467283765EBA454392D361703E"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_81221930EF31C19713239E9DFEEACD89992310516BC1F9573ACA26"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_88221919F53AE1C855CB89208F972029C25A0B0E8B12B7302DFB82"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_2["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_96D10CD10B311B2B0DBDC6BAD6DC"] = var_1;
  var_2["_encstr_B805263D90EB6A5F9B98038318F00953732F87B79E09B39D03B09FEBC8ADD4FB1B460C6DE5A5DBB3"] = scripts\mp\class::_id_139E4(var_0, var_1, 0);
  var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = scripts\mp\class::table_getweapon(var_0, var_1, 0);

  for(var_3 = 0; var_3 < scripts\mp\class::getmaxprimaryattachments(); var_3++) {
    var_4 = scripts\mp\class::getattachmentloadoutstring(var_3, "_encstr_BA7F0830B3A7859B60B0");
    var_2[var_4] = scripts\mp\class::table_getweaponattachment(var_0, var_1, 0, var_3);
  }

  var_2["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = scripts\mp\class::table_getweaponcamo(var_0, var_1, 0);
  var_2["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = scripts\mp\class::table_getweaponreticle(var_0, var_1, 0);
  var_2["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = scripts\mp\class::_id_139E6(var_0, var_1, 0, var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"]);
  var_2["_encstr_99B2286888EADCAFF83B919362D82E502F18AB292D5116D86759C01D572BA8F0931B51BA61DDA87533DF"] = scripts\mp\class::_id_139E4(var_0, var_1, 1);
  var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = scripts\mp\class::table_getweapon(var_0, var_1, 1);

  for(var_3 = 0; var_3 < scripts\mp\class::getmaxsecondaryattachments(); var_3++) {
    var_4 = scripts\mp\class::getattachmentloadoutstring(var_3, "_encstr_AC8F0AE74163F85AAA380AD8");
    var_2[var_4] = scripts\mp\class::table_getweaponattachment(var_0, var_1, 1, var_3);
  }

  var_2["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = scripts\mp\class::table_getweaponcamo(var_0, var_1, 1);
  var_2["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = scripts\mp\class::table_getweaponreticle(var_0, var_1, 1);
  var_2["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = int(tablelookup(var_0, 0, "_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75", var_1 + 1));
  var_2["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = tablelookup(var_0, 0, "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB", var_1 + 1);

  if(scripts\engine\utility::cointoss())
    var_2["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"] = "_encstr_AAEF05B9394BAB";
  else
    var_2["_encstr_B8141D4CD0C932385B1BE7E9D1C8DFF773FB94EB1541184BFFBAB38186438B"] = "_encstr_B6C106DFEFC9611D";

  var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = tablelookup(var_0, 0, "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B", var_1 + 1);

  if(var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] != "_encstr_84CB0CB2680B841B3E76A5AF0201" && scripts\engine\utility::cointoss())
    var_2["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"] = "_encstr_AAEF05B9394BAB";
  else
    var_2["_encstr_8EA71F285227ADE0CBE403710CF268F58F6B2D13DA6FD0706ACD57A70E5F203617"] = "_encstr_B6C106DFEFC9611D";

  var_2["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [];
  var_2["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  var_2["_encstr_81E6112CD2D9B12F700387D0E8A7C32341A7DD"] = "_encstr_A63C0B33252188F56B439B89EF";
  return var_2;
}

riskspawn_getspawnlocationsbytier(var_0) {
  var_1 = [];

  if(var_0 == "_encstr_B116071BCAD186858D")
    var_1 = ["_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95", "_encstr_82A70F2B3B73E33B472371FF21D7809DDF", "_encstr_843D095F2B7D52B041D9A3", "_encstr_8BBB0B9D41E718D9E922D8582A", "_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9", "_encstr_8C450D955CD52D07D7DC2BB6A39587", "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61", "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381", "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC", "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B", "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1"];
  else if(var_0 == "_encstr_99C209E34FC743616118AB")
    var_1 = ["_encstr_820F114AE740032B7F8680CAD930B1D239F212", "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E", "_encstr_8B0E0CAC5CAB4B38FA46566CBDF2", "_encstr_BD170C5B689B786221E98009A80C", "_encstr_B24B12B7A88B412B8F84669AE0974315B0800B3F", "_encstr_A78210CAB8D5A507FAA198F5CD2BCDE6BD93", "_encstr_84CB0CB2680B841B3E76A5AF0201", "_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02"];
  else {}

  var_2 = var_1[randomint(var_1.size)];
  return var_2;
}

_id_12859(var_0) {
  var_1 = tablelookupgetnumcols(var_0) - 1;
  level._id_1285D = [];
  var_2 = 0;

  if(getDvar("_encstr_8893213736E4FA98C97DC13959AD0BE81B34BE63DEC223ED5DD1FAB73BAC4E9C4BC856") != "_encstr_B40101") {
    var_3 = strtok(getDvar("_encstr_8893213736E4FA98C97DC13959AD0BE81B34BE63DEC223ED5DD1FAB73BAC4E9C4BC856"), "_encstr_974C0246");
    var_4 = [];

    for(var_5 = 0; var_5 < var_3.size; var_5++)
      var_4[var_4.size] = int(var_3[var_4.size]);

    for(var_6 = 0; var_6 < var_4.size; var_6++)
      level._id_1285D[level._id_1285D.size] = init_swivelroom_currsolution_marquee(var_4[var_6], var_0);

    level._id_1195F = var_4.size;
    return;
  } else if(getdvarint("_encstr_BE2818DB6F38793B8E5693FB797027AFA0AF4C5F8370BDAFB5CB", 1)) {
    if(getdvarint("_encstr_B67720EE3B93B6A5FA99C050A3D4558ACFB0F66D9D879BEF24A108F88AAF0F43DB5B", 0) == 1 && getdvarint("_encstr_85811CCD1B9CEB26C97D0E39B2B5581DD834D7B1ED16C8DEAB47F59B2BA3", -1) == -1) {
      var_2 = 0;
      level._id_1195F = var_1;
    } else {
      var_2 = int(randomint(var_1 - 1) * 0.1) * 10;

      if(getdvarint("_encstr_85811CCD1B9CEB26C97D0E39B2B5581DD834D7B1ED16C8DEAB47F59B2BA3", -1) != -1)
        var_2 = getdvarint("_encstr_85811CCD1B9CEB26C97D0E39B2B5581DD834D7B1ED16C8DEAB47F59B2BA3", -1);

      var_1 = var_2 + 10;
    }
  }

  for(var_7 = var_2; var_7 < var_1; var_7++)
    level._id_1285D[level._id_1285D.size] = init_swivelroom_currsolution_marquee(var_7, var_0);
}

init_swivelroom_currsolution_marquee(var_0, var_1) {
  var_2["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_2["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = tablelookup(var_1, 0, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", var_0 + 1);
  var_2["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = tablelookup(var_1, 0, "_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A", var_0 + 1);
  var_2["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = tablelookup(var_1, 0, "_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353", var_0 + 1);
  var_2["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = tablelookup(var_1, 0, "_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66", var_0 + 1);
  var_2["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = tablelookup(var_1, 0, "_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3", var_0 + 1);
  var_2["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = tablelookup(var_1, 0, "_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB", var_0 + 1);
  var_2["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = tablelookup(var_1, 0, "_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED", var_0 + 1);
  var_2["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = tablelookup(var_1, 0, "_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3", var_0 + 1);
  var_2["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = tablelookup(var_1, 0, "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B", var_0 + 1);
  var_2["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = tablelookup(var_1, 0, "_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA", var_0 + 1);
  var_2["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = tablelookup(var_1, 0, "_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7", var_0 + 1);
  var_2["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = tablelookup(var_1, 0, "_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC", var_0 + 1);
  var_2["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = tablelookup(var_1, 0, "_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC", var_0 + 1);
  var_2["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = tablelookup(var_1, 0, "_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA", var_0 + 1);
  var_2["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = tablelookup(var_1, 0, "_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560", var_0 + 1);
  var_2["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = tablelookup(var_1, 0, "_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D", var_0 + 1);
  var_2["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = tablelookup(var_1, 0, "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB", var_0 + 1);
  var_2["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = tablelookup(var_1, 0, "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B", var_0 + 1);
  var_2["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_2["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_2["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_968411DCBAC12B4E7D13E4BE563C8E27851BD1";
  var_2["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [tablelookup(var_1, 0, "_encstr_96CB0DB3C7BF3CCF5363C0EA92DCCA", var_0 + 1), tablelookup(var_1, 0, "_encstr_88CB0DC6B70B237B5D1DA02B27AD46", var_0 + 1), tablelookup(var_1, 0, "_encstr_81CB0D4DB85834BAFDA97BA7CDAA27", var_0 + 1), tablelookup(var_1, 0, "_encstr_86EA12137F2FDAF73803D760FBF80151F5DD87DE", var_0 + 1), tablelookup(var_1, 0, "_encstr_8BEA12C06AA8690A20E32759212A20912B13FF0A", var_0 + 1), tablelookup(var_1, 0, "_encstr_83EA1283EF9F6A47889347108B6891E1652D1766", var_0 + 1)];
  var_2["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  var_2["_encstr_96D10CD10B311B2B0DBDC6BAD6DC"] = var_0;
  return var_2;
}

defineplayerloadout() {
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_968411DCBAC12B4E7D13E4BE563C8E27851BD1";
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_AC9C0FEA0FF30A29692883BF99A00D4249"];
  level.br_loadouts["_encstr_8B1608EC43B8D647A113"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  level.br_loadouts["_encstr_9A8507BA4040188D08"] = level.br_loadouts["_encstr_8B1608EC43B8D647A113"];
  level.br_loadouts["_encstr_8E8405EA382B2A"] = level.br_loadouts["_encstr_8B1608EC43B8D647A113"];
  level.br_respawn_loadout = level.br_loadouts["_encstr_8B1608EC43B8D647A113"];
  level.br_respawn_loadout["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_AF7C12B06F10C0C3A06753A9AE506562C9B88320";
}

onprecachegametype() {
  level._effect["_encstr_97A614673387FA3B8537EB39B4B93BBE38C6855E5939"] = loadfx("_encstr_A6602B863D303D5F4402F92213B0BBA2B1BD011647E2335BEB06720A5BE0A3DCD00FBF70F948381F96109B4242");
  level._effect["_encstr_8E7D13CE991EBECEB0CDAFC92D73ECEB8357CC33CB"] = loadfx("_encstr_871C2AB333E1F2B4EEC1EBD8077931E4D7E44B9B76793B99F0D7CEC2E6F5E44BE6ECAF075766995EE2D9CC3C");
  level._effect["_encstr_BE771BE3B1B8275256D7C7E39DF3FA6F70BB5DEA0E48AD5A224B17925B"] = loadfx("_encstr_AA7B39CC7D8896271F58AE16FD3892875AB138AA071360AC8AF8B13ACEF808D9998AAD0F33DE77A3196EAA8B38EA0FA84AAFFC71581181B0438E83");
  level._effect["_encstr_83BE1A3E744A3FA6DDC9BAC228C31D87A065BDB0AF732FAA81B1370F"] = loadfx("_encstr_AB7D385E142A9E44F7D2F92268AF3F5F600DC0CC3F52D60C9D18823A9A2537739E664A4743182BD4B1B9BAA3A041A1973056B0CF470B425B5D98");
  level._effect["_encstr_9BBE1A1EA5A8B9FB4E96126A592B1B61903B8D80BFA87CF7778E7FB7"] = loadfx("_encstr_AA9138CE33F0CB4BEE1CBE899CCB760B5B95E01BC25EF2967366D28D979D333CD72627F5B49BCC5AD8D753AB5B0EBEEED2CD83F58123C5EC663C");
  level._effect["_encstr_83DF13ECCC0F7D762CE6EBD6B0E6B6BE3127AC0B5B"] = loadfx("_encstr_B4BC2CCE99F097A5EEE0AF1339973B0B6B590763C22F7967CCE1EB26C97DD9B0B95B1637B5EB3259DC3AC5673387");
}

onstartgametype() {
  level.blockweapondrops = 1;
  level.customlaststandactionset = "_encstr_92630C50635D8B23832B65D71EEB";
  scripts\mp\playeractions::registeractionset(level.customlaststandactionset, ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_880718D8F70AB9490ECBA9C88B5180E33358585C8FD25170E6BF", "_encstr_85DF1AF633CC0D0B9B197DE695D8F6734685C95EFABBCA0B0EDB9BDC", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_8F0508CE59DCA357392B", "_encstr_964E0BB08D63B7BBF553EA5BC1", "_encstr_92100762872552A643", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05", "_encstr_A6C7065BACB1CA95", "_encstr_88780599B4E495"]);
  level.graceperiod = 3;
  level.ingraceperiod = level.graceperiod;
  level.prematchperiodend = 0;

  if(!level.allowsupers)
    level.setsuperweapondisabled = ::_id_131C8;

  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_8B3F0E27AD52BB87E1731E6F917E1C80");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8B3F0E27AD52BB87E1731E6F917E1C80");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_8DE9146F1A5030357961F45DAF3727203969A6B4F14F");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_95BF13F448528A348A2565A86AF2449AF5844A278A");
  }

  initspawns();

  if(!_id_11A5C())
    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::initcircle();

  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_init();
  _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::init();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::delete_objective_on_death_safe();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initpickupusability();
  _encstr_B2372553095ECF72D09FAFE571E27F3709619B7BF3BDEFFD588527F36BA0C547ADBB6396790E57::init();
  _encstr_8C492BEBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6ECB488EA33B402AFA808093ADD09D8F63FF::init();

  if(!_id_11A5C())
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_quest_util();

  scripts\cp_mp\vehicles\vehicle_compass::calloutmarkerping_init();
  _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::brlootcache_init();
  _encstr_B4592F0E100E4B7AE3FFCE28D07637E34BDF98D048C1736E91C0BED2306F13E1165F43C2FD17A942D3013B53B4963F3AEF::init();
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::init();
  _encstr_ABE327C7AF0393A844EAD8E8527758DFAA1F715B7B9A668A6A82DE217CE1F881824BDFFB9F96242083::init();
  _encstr_81032C6ED8E4B41CA3CDCBAD0E979DB05B561D971C95375E98C9BE2C3647FA6BDEC8B2AF56E68D0B38955C76B9C6::init();
  _encstr_854729D36730FC6B95DB4E12C3407FB690C36C51D96082CEB6D341DA68C5676D28B9F5EF1F300A82ECEB9A::init();
  _encstr_AFAC2972C138C1A3A57F2E3F61E01A0138E92B781B28832EF655E707B175C1758051E749325051F65C2F2F::init();
  _encstr_B1822960778AD811AB3A4861D2367781CD0720B8A33553773262487FADDB3FC827BB201123D08B3D4ACA5E::init();
  _encstr_AC4E30EBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6BFF484BF73B601ABAC01593EAE0298773E76305275E79::init();
  _encstr_B1402B7BCF9854D32D73D6FA3BA8D70E08BBF4E941981A66DE4BE903615D1785D80B8C7D8718231BFD28620B09::init();
  _encstr_96292CAF888B0430F313B7ADBBE6A98203C79BE8A065087EB2CE1F3145C08EA2D74BCD198818A58A035B351780C8::init();
  _encstr_8EC62CCD8D93B4C1D1CDE5D60EF2EC0BDAB2D1E5E0566EBC89937D0BB147AF6BF62356BE133937A1BDE817B3CDC6::init();
  level.br_pickups.crates = [];
  level.br_pickups._encstr_BA7E0F3010CBC39BE0F5F182A36018B7C7 = [];
  level.br_pickups.outercrates = [];
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::initgulag();
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_AF2618A0BAE5ABC8DB12E57401BF504D8DF211B8D1FD3B22B74A", ::_id_1411D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B607038AAB", "_encstr_AB0F11DCBAE02B274D8DB78E6863ACC237AA0E", _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_1398A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B607038AAB", "_encstr_9179131B34C23663CAB9CE59516785365DB0A3DE39", _encstr_ABE327C7AF0393A844EAD8E8527758DFAA1F715B7B9A668A6A82DE217CE1F881824BDFFB9F96242083::getallspawninstances);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_816818A3BA775378C3BD354FB2EE082D8B723B0D92D79F685B80", ::airdrop_registercrateforcleanup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8A6A1E989C62F616C8B75D476839C2D195912DC9CD8E0AB11D5A6716D1B4F637", ::br_ammorestock_playeruse);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_951314597E0CC5D797BE4B1DBB53C215A11645D00B90", ::airdrop_makeweaponfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_8B5212D6C2B656923A56D68C39EDADD0E42C3AB2", ::airdrop_makeitemfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_91651315562FDFA84C43777B8FE8E85986237123A5", ::airdrop_makeitemsfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BA6516FAAE7E0FD465A838531081C6CFD1094F71CDED0FDB", ::airdrop_br_givedropbagloadout);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BA67082278D537E3C827", "_encstr_AF431A59AE6793EBE7E64467A3FD48ADA39B5D59CB56B1261D3312CB", ::br_armor_repair_end);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_88EA08EC2CCDDAB037B5", "_encstr_84160FF275B8CE373C899B60917E7F4E79", _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::disable_near_snake_cam_after_open);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_95C50D4B8218F33AF1288B4298AD25", ::ending_viewing_players_setup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_830A11821090E1A138633BEBD9D06921E8193F", _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1276A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B472054FE12550", "_encstr_850710A7F30D014180090702800881BAE637", _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic);
  _hidesafecircleui::stopusingbomb();
  initloot();
  level thread onprematchstarted();
  thread turnofftimer();
  level thread watchprematchdone();
  level thread _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::brvehiclesonstartgametype();

  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15")
    thread _encstr_BA6F2E3318E5A43B7B56C78DEF285FEE73B0CBEBE8939A8E513EAFBF0F081F73A3B04201407393170BAF9BB5B0919FFE::_id_14363();
  else
    thread _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_14363();

  level thread updateplayerlocationcallouts();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::brdpadcallback);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::setup_teleport_rooms);

  if(getdvarint("_encstr_995213C271884752BBEF8773295518BFC8397DCB0B", 0) == 1)
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_8C100FC793A0BFF07F07F30773956AE520");

  if(disable_fulton_group_interactions()) {
    thread _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::initdropbagsystem();
    thread cleanupdropbagsoncircle();
  }

  level.killstreakbeginusefunc = ::display_hint_single;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_841310FF4D098B1FA62BD8A2107583806833");
}

_id_1411D(var_0, var_1) {
  return 1;
}

has_focus_fire_objective() {
  var_0 = getEntArray("_encstr_8C8D08671D451291C849", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2.weapon_name) && var_2.weapon_name == "_encstr_BA730BF8AFF178988293F158B9")
      thread scripts\mp\equipment\molotov::_id_11CB5(var_2);
  }
}

_id_12076() {
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  if(getdvarint("_encstr_ACF71A97FF53D868F251C1B847EEB8890AEF37319F4818483A752911", 0))
    level.client_activate = 1;

  if(scripts\cp_mp\utility\game_utility::tutorialzoneenter())
    _encstr_92DE20521AF3E850D53340EF70CDFA97582F338909C0BB7059E38F3804B20D2AC8EF::_id_145EE();

  if(!istrue(level._id_133E0)) {
    level thread resetalldoors(2.1);
    level thread scripts\cp\vehicles\little_bird_mg_cp::fulton_destroy(1);
    level thread _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::brvehicleonprematchstarted();
    level thread scripts\mp\equipment\binoculars::teamuseonly();
  }

  level thread _encstr_8C492BEBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6ECB488EA33B402AFA808093ADD09D8F63FF::onprematchdone();

  if(!istrue(level._id_133E0)) {
    has_focus_fire_objective();
    _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::emptyallvehicles();

    if(!istrue(level.br_infils_disabled)) {
      foreach(var_1 in level.players) {
        var_1 _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::setplayerprematchallows();
        var_1 thread _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::resetplayerinventory();

        if(istrue(var_1.hasspawned)) {
          if(istrue(var_1.usingascender))
            var_1 scripts\cp_mp\auto_ascender::canseesafecircleui();

          var_1 thread scripts\mp\weapons::deleteplacedequipment(1);
        }
      }
    }

    foreach(var_1 in level.players) {
      if(isDefined(var_1.burninginfo))
        var_1 scripts\mp\equipment\molotov::molotov_clear_burning();

      var_1 scripts\mp\javelin::vehicle_damage_deregistervisualpercentcallback();
    }

    level notify("_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0");
  }

  level.little_bird_mp_initmines = 0;

  foreach(var_7, var_6 in level.br_prematchloot)
  var_6 setscriptablepartstate(level.br_prematchlootparts[var_7], "_encstr_BE8B08E323FB2BCD6268");

  level.br_prematchloot = undefined;
  level.br_prematchlootparts = undefined;

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection() && disable_flag())
    _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::classselectionbeginnonexclusion();

  var_8 = getdvarint("_encstr_8AF41BBB6EEDEE7DB2CEB273477D8CB30B9CFA86DB47AF9C95367B0B32", 0);

  if(istrue(var_8))
    _id_12BB7();

  if(!istrue(level.br_circle_disabled))
    level thread _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_id_12E09(1);
}

_id_12BB7() {
  if(!istrue(getdvarint("_encstr_85AF0DEA59A06F0A1E9F87C7D14F82", 1))) {
    if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_9B220634456A5747"))
      level _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");

    level.usegulag = 0;
    setomnvar("_encstr_A7990F658429177BBC4FF8417FDCB179D2", 0);
    setomnvar("_encstr_BA091CD3A071EFD349BBEF178763BA37C9490DDD9BA8BECA0877ABE7A19D", 2);
  }

  if(!istrue(level.br_circle_disabled)) {
    level _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::cacheentity();
    level thread _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::allplayers_setphysicaldof();
  }
}

onprematchstarted() {
  level thread _id_12076();
  var_0 = undefined;

  if(!istrue(level.br_infils_disabled) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection()) {
    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3"))
      var_0 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_9B301516FE3D63ED424F23FBBB303F938931ABCE2B26B3");
    else
      var_0 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path();
  }

  if(!istrue(level._id_133E0) && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    foreach(var_2 in level.teamnamelist) {
      setteamradar(var_2, 1);
      setteamradarstrength(var_2, 1);
    }
  }

  if(scripts\mp\utility\game::round_vehicle_logic() != "_encstr_A519044B436F")
    thread scripts\mp\music_and_dialog::stopsuspensemusic();

  level waittill("_encstr_8B7A1187533F0D1369DFC88EF81BD79B148B8D");

  if(_id_11A5C()) {
    _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::initcircle();
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_quest_util();
  }

  if(!istrue(level._id_133E0)) {
    var_4 = getdvarint("_encstr_A14A16336A93F840D217A5FB547E88A0CFB3AB79222FA5C8", 0);

    foreach(var_2 in level.teamnamelist) {
      if(var_4) {
        setteamradar(var_2, 1);
        setteamradarstrength(var_2, var_4);
        continue;
      }

      setteamradar(var_2, 0);
      setteamradarstrength(var_2, 0);
    }
  }

  if(istrue(level.debug_safehouse_regroup_start) && istrue(level.debug_show2dvotext))
    setomnvarforallclients("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);

  var_7 = 0;
  level.debugnextpropindex = 0;
  level.delay_music_reinforcements = 0;

  if(!istrue(level.br_infils_disabled)) {
    if(!istrue(level.infilcanusec130) && !istrue(level.infilcanusemap))
      level.infilcanusec130 = 1;

    if(istrue(level.infilcanusemap)) {
      if(disable_fulton_group_interactions() && !dialog_mount_nag_watcher())
        _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::_id_1284D(1);

      _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::spawnselectioninfil("_encstr_8BB007E03658CBCAE4");
      waitframe();

      foreach(var_9 in level.players) {
        var_9 stopanimscriptsceneevent();
        var_9 notify("_encstr_831910EB8313CF31B9121BFFC3FECDF5800D");

        if(!var_9.brmapselectionafk) {
          var_9 thread _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::_id_13AEC();
          continue;
        }

        var_9 thread sendafksquadmembertogulag();
      }
    }

    setdvarifuninitialized("_encstr_AF201EBB768BBF265D49FB93B02F5AF723EB203480B0B7EF2BA8410AF0A51483", 0);

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_97670EEB0EFB48B1BA22F028DA0D6701"))
      _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_97670EEB0EFB48B1BA22F028DA0D6701");
    else if(istrue(level.infilcanusec130) && !istrue(level.infilcanusemap)) {
      var_11 = undefined;

      if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_99FE10EF999079CA14F3AB53D14F638D48A3"))
        var_11 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_99FE10EF999079CA14F3AB53D14F638D48A3");

      if(!getdvarint("_encstr_AF201EBB768BBF265D49FB93B02F5AF723EB203480B0B7EF2BA8410AF0A51483", 0))
        _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::clear_tier_lights(var_0, "_encstr_8BB007E03658CBCAE4", var_11);
      else {
        _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::clear_tier_lights(var_0, "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

        if(isDefined(level.infilstruct) && isDefined(level.infilstruct.transporttime))
          var_7 = level.infilstruct.transporttime;
      }

      level thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::waittoplayinfildialog();
    }
  } else {
    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_AC2A12B9D6A538A4DC66A5366A95B8BACA9BD8AC"))
      _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AC2A12B9D6A538A4DC66A5366A95B8BACA9BD8AC");

    scripts\mp\flags::gameflagset("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
    waitframe();
    level.allowprematchdamage = 0;
    var_11 = undefined;

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_99FE10EF999079CA14F3AB53D14F638D48A3"))
      var_11 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_99FE10EF999079CA14F3AB53D14F638D48A3");

    if(!isDefined(var_11) || var_11.size > 0)
      _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::_id_1435F(var_11);

    foreach(var_9 in level.players) {
      var_9.plotarmor = undefined;

      if(istrue(level.client_activate)) {
        var_9 skydive_setdeploymentstatus(1);
        var_9 skydive_setbasejumpingstatus(1);
        continue;
      }

      var_9 skydive_setdeploymentstatus(0);
      var_9 skydive_setbasejumpingstatus(0);
    }

    scripts\mp\flags::gameflagset("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B");
  }

  level thread setup_player_killstreak_loadouts();
  level thread setup_weapons_at_pos();

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_838F0D8DEFA26BC7D83780300FF4D9"))
    level thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spectate_init();

  level.br_prematchstarted = 1;
  level notify("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");
}

setup_weapons_at_pos() {
  if(scripts\mp\utility\game::updatex1stashhud()) {
    return;
  }
  scripts\mp\scoreboard::_id_128B0();

  if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0) {
    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch())
      setclientmatchdata("_encstr_B28C0EB49B0AD58936D26C9A2CD1B10D", 1);
    else
      setclientmatchdata("_encstr_B28C0EB49B0AD58936D26C9A2CD1B10D", 0);
  }

  level scripts\engine\utility::waittill_notify_or_timeout("_encstr_B4DE144C93BE1B139960FA1B5933D1FA98DED59B91CD", 120);
  scripts\mp\scoreboard::_id_128B0();
}

setup_player_killstreak_loadouts() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(disable_fulton_group_interactions() && dialog_mount_nag_watcher()) {
    if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker() && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()) {
      var_0 = disable_weapon_swap_until_swap_finished();
      _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::kioskreviveplayer(var_0);

      if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_BA430C806BCF931D8257A1C8AD6B")) {
        for(;;)
          _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::kioskreviveplayer(var_0);
      }
    }
  }

  level.dropbagstruct = undefined;
}

resetalldoors(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_0))
    wait(var_0);

  difficulty_update_time(200);
}

setup_teleport_rooms(var_0, var_1) {
  if(isDefined(var_0) && var_0 == "_encstr_B49E167DD05A212EB37F18A033C72159E23DE3706E63DB71")
    self setclientomnvar("_encstr_A5011EAB96BE13C97D9B2E570B91D79536D26B2DB985A3B232EB58B1E8B49D56", 0);
}

updateplayerlocationcallouts() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.calloutglobals.calloutzones))
    level.calloutglobals.calloutzones = getEntArray("_encstr_B8EE102BE0F1C1E37B182D69FC0F1A9D5828", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!level.calloutglobals.calloutzones.size) {
    return;
  }
  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(!isPlayer(var_2) || !isalive(var_2)) {
        continue;
      }
      if(isDefined(var_2.br_currentcalloutzone) && var_2 istouching(var_2.br_currentcalloutzone)) {
        continue;
      }
      var_3 = 0;

      foreach(var_5 in level.calloutglobals.calloutzones) {
        if(var_2 istouching(var_5)) {
          var_3 = 1;
          var_2.br_currentcalloutzone = var_5;
          var_2 scripts\mp\callouts::setplayercalloutarea(var_5.script_noteworthy);
          var_2 thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A6BA13408DE508B3B7C39F5E201868B813695B9FE3", var_5.script_noteworthy);
          break;
        }
      }

      if(!var_3) {
        var_2.br_currentcalloutzone = undefined;
        var_2 scripts\mp\callouts::setplayercalloutarea("_encstr_8BBA05185F8B99");
      }

      var_0 = (var_0 + 1) % 2;

      if(var_0 == 0)
        waitframe();
    }

    waitframe();
  }
}

getusingproxdoors() {
  return 0;
}

watchprematchdone() {
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  level notify("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623");
  var_0 = scripts\mp\utility\game::getlivingplayers();
  level.totalplayers = var_0.size;
  var_1 = 0;

  foreach(var_3 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_3, "_encstr_8A2A0B936CCCC3078547970A8B") > 0)
      var_1++;
  }

  level._id_1385E = max(1, var_1);
  level._id_12855 = gettime();
  level.recordfinalkillcam = 1;
  level.ignorescoring = 0;
  level.disableweaponstats = 0;
  level.disablestattracking = 0;
  level.prematchaddkillfunc = undefined;
  level.getarenapickupattachmentoverrides = 0;
  difficulty_think();

  foreach(var_6 in level.players)
  var_6 _id_12C6F();

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  vehicle_getarrayinradius();
  setomnvar("_encstr_B17E1560778AD811ABBEEEE197316140CF437930C73491", 0);

  foreach(var_6 in level.players) {
    var_6 setclientdvar("_encstr_8D410B996AD8A5BC640751B95F", 1);

    if(isalive(var_6)) {
      var_6.health = var_6.maxhealth;
      var_6 scripts\cp\vehicles\vehicle_compass_cp::_id_1383B("_encstr_82A71120EA74DD99472EF07507F380971DC280");
    }
  }

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonatedripfx(var_0.size);
  level _id_1319B();
}

turnofftimer() {
  wait 1;
  setomnvar("_encstr_8A601657B4F5ADB03A1B867D1D96D6599CFA4396198C95CD", 1);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_838B0B942AE27B65C76B91F03B", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

tolerance() {
  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()) {
    level.startingspawns = scripts\mp\spawnlogic::getspawnpointarray("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B");

    if(level.startingspawns.size == 0)
      level.startingspawns = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");

    level.prematchspawnorigins = getprematchlocationspawnorigins();
  }
}

debugspawnlocations() {
  for(;;) {
    foreach(var_1 in level.prematchspawnorigins) {
      [var_3, var_4] = getprematchradius(var_1);

      if(var_3 > 0) {}
    }

    waitframe();
  }
}

_id_14070() {
  var_0 = getdvarint("_encstr_BD6714A643EBCEC3F262B9D0BACFB3E0EFDBAF17CF73", 0) != 0;
  return (!istrue(level.br_prematchstarted) || istrue(level.debug_safehouse_gunshop_start)) && !istrue(level.skipprematchdropspawn) && !var_0 && !istrue(level.stop_end_breach_fx);
}

getspawnpoint(var_0) {
  if(isDefined(self._id_1286F)) {
    var_1 = self._id_1286F;
    self._id_1286F = undefined;
    return var_1;
  }

  if(isDefined(self.thrust_fx_model)) {
    var_1 = self.thrust_fx_model;
    return var_1;
  }

  if(!isDefined(level.prematchspawnorigins))
    tolerance();

  if(istrue(var_0) || _id_14070()) {
    var_2 = (0, randomintrange(0, 360), 0);
    var_4 = getprematchspawnorigin();
    [var_6, var_7] = getprematchradius(var_4);
    var_8 = randomfloatrange(var_6, var_7);

    if(getdvarint("_encstr_999A1D42F108C7B2B6374FAB95D54A3D719BBA0B08D8938B137D2FA38B8FE2", 0) == 1) {
      var_10 = vectortoangles(var_4.origin);
      var_2 = (0, var_10[1], 0) * -1;
      var_8 = var_7;
    }

    if(isDefined(var_4.angles))
      var_2 = var_4.angles;

    var_11 = anglesToForward(var_2) * -1;
    var_12 = var_11 * var_8;
    var_13 = var_4.origin + var_12;
    var_13 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::_id_1342E(var_4.origin, var_13, 30);

    if(isDefined(self.setspawnpoint)) {
      var_14 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::getinfilspawnoffset();
      var_13 = self.setspawnpoint.playerspawnpos + (0, 0, var_14);
      var_2 = self.setspawnpoint.playerspawnangles;
      scripts\mp\equipment\tac_insert::_id_13681(0, 1);
    }

    var_1 = spawnStruct();
    var_1.origin = var_13;
    var_1.angles = var_2;
    var_1.index = -1;
    return var_1;
  }

  var_15 = level.startingspawns;
  var_1 = scripts\mp\spawnlogic::getspawnpoint_random(var_15);

  if(!isDefined(var_1)) {
    var_1 = spawnStruct();
    var_1.origin = (0, 0, 0);
    var_1.angles = (0, 0, 0);
    var_1.index = -1;
  }

  return var_1;
}

createspawnlocation(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.minradius = var_1;
  var_3.radius = var_2;
  return var_3;
}

getprematchlocationspawnorigins() {
  var_0 = 0;
  var_1 = scripts\engine\utility::getStructArray("_encstr_A2FE1CCAA340336AD0DB6964DF60F99F703B32530B23172529096F71EDE8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level.delete_script_object)) {
    var_0 = 1;
    var_1 = level.delete_script_object;
  } else if(!var_1.size) {
    var_0 = 1;
    var_1 = getEntArray("_encstr_BE6A0F1C3D989830516526E040F8CB15EF", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  }

  foreach(var_3 in var_1) {
    var_3.groundorigin = var_3.origin;

    if(!isDefined(var_3.radius))
      var_3.radius = 5000;

    if(!isDefined(var_3.minradius))
      var_3.minradius = 500;
  }

  var_5 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8E0D1A1FBA72FB316C9F48993B910B0518E693B9554AABDB29976060");

  if(!isDefined(var_5))
    var_5 = getdvarint("_encstr_8FDB1CC8D023616A532818CE4B9F43A57B7BCD3EDB71871E99A3A8EFBDB8", 5);

  if(var_5 > 0 && var_5 < var_1.size)
    var_1 = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(var_1), 0, var_5);

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3.origin = getoffsetspawnorigin(var_3.origin);
      continue;
    }

    var_7 = getoffsetspawnorigin(var_3.origin)[2];

    if(var_3.origin[2] < var_7)
      var_3.origin = (var_3.origin[0], var_3.origin[1], var_7);
  }

  return var_1;
}

getoffsetspawnorigin(var_0, var_1) {
  var_2 = scripts\engine\trace::create_default_contents(1);
  var_3 = (0, 0, 5000);
  var_4 = var_0 + var_3;
  var_5 = var_0 - var_3;
  var_6 = scripts\engine\trace::ray_trace(var_4, var_5, undefined, var_2);
  var_7 = var_0;

  if(var_6["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
    var_7 = var_6["_encstr_BD260953AA97E3F014279D"];

  if(!isDefined(var_1)) {
    var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::getinfilspawnoffset();
    var_1 = (0, 0, var_8);
  }

  return var_7 + var_1;
}

resetcircuitbreakers(var_0, var_1) {
  var_2 = 5000;
  var_3 = -5000;
  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0, var_2, var_3);

  if(!isDefined(var_1)) {
    var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::getinfilspawnoffset();
    var_1 = (0, 0, var_5);
  }

  return var_4 + var_1;
}

relic_squadlink_toofar_hud_logic() {
  var_0 = int(150 / _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::replace_sat_piece_on_deathordisconnect());
  return var_0;
}

getprematchspawnorigin() {
  var_0 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_A70D21FFCF5D70929B23F7E81B7B022579FBBFE2A843A2BBD12311CF3D2F7BDC613B96");

  if(istrue(var_0) && isDefined(level._id_12864)) {
    var_1 = 0;

    for(var_2 = 0; var_2 < level.prematchspawnorigins.size; var_2++) {
      if(level._id_12864[var_2] < level._id_12864[var_1])
        var_1 = var_2;
    }

    level._id_12864[var_1]++;
    var_3 = level.prematchspawnorigins[var_1];
    return var_3;
  }

  if(!isDefined(level.prematchspawnoriginnextidx)) {
    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_B2722482678563E730023AED218393FB22DBB058EF174FC3104988305F60C023ED5A480121C2"))
      level.prematchspawnoriginnextidx = 0;
    else
      level.prematchspawnoriginnextidx = randomint(level.prematchspawnorigins.size);

    level._id_12865 = [];

    for(var_2 = 0; var_2 < level.prematchspawnorigins.size; var_2++)
      level._id_12865[var_2] = 0;
  }

  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_at_max(self.sessionteam, self.squadindex, "_encstr_A18C14E0272B5B58D16CA16A380BBB37D3E42DCE5ACD");

  if(!isDefined(var_3)) {
    var_3 = level.prematchspawnorigins[level.prematchspawnoriginnextidx];
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_131C3(self.sessionteam, self.squadindex, "_encstr_A18C14E0272B5B58D16CA16A380BBB37D3E42DCE5ACD", var_3);
    level._id_12865[level.prematchspawnoriginnextidx]++;
    var_4 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A3E52148C0D01A378B41D049E09F80B8B0ABD9EF8F785873C8FBE291ED16367B1C57B5");

    if(!isDefined(var_4)) {
      var_5 = relic_squadlink_toofar_hud_logic();
      var_4 = int(var_5 / level.prematchspawnorigins.size);
    }

    if(level._id_12865[level.prematchspawnoriginnextidx] >= var_4)
      level.prematchspawnoriginnextidx = (level.prematchspawnoriginnextidx + 1) % level.prematchspawnorigins.size;
  }

  var_6 = getdvarint("_encstr_8BA71D33AAA3CF3AD009DFBBD7633B9B3DE363237D6391EBCBB8BB1926D386", -1);

  if(var_6 >= 0 && var_6 < level.prematchspawnorigins.size)
    var_3 = level.prematchspawnorigins[var_6];

  return var_3;
}

onplayerconnect(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;
  var_0.needtoplayintro = undefined;
  var_0.br_infil_type = undefined;
  var_0.equipment = [];
  var_0.delay_give_tactical_grenade = 1;
  var_0 thread _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_init();
  var_0 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_initplayer();

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB"))
    var_0 thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB");
  else
    var_0 thread _id_126F1();

  var_0 _id_12C6F();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_BE94109AA047C32EB04BFAD347D0352F765B", var_0);

  if(_encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_B40B18664DCF4419B7F981D0FDA0F78360238A2038A9FE70A7B9())
    var_0 thread _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_86261980ED17DC03FA0B80D952689BC4658B17AB45298F60E2E3E2();

  if(!istrue(level.prematchstarted)) {
    var_0.radarmode = "_encstr_967E0B634D05FF67969942024E";
    level waittill("_encstr_8B7A1187533F0D1369DFC88EF81BD79B148B8D");
    wait 1.4;
  }

  if(!isDefined(var_0.streakdata))
    waittillframeend;

  if(isDefined(var_0)) {
    if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker() && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && !scripts\mp\utility\game::updatex1stashhud()) {
      if(!istrue(level._id_133E0)) {
        var_0 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
        var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::resetplayerinventory();
      }

      var_0 scripts\cp_mp\utility\game_utility::startkeyearning();
    }

    var_0 thread _id_11D22();
    var_1 = getDvar("_encstr_AA78124E7782570B0B810B97D11FC37F5AF02C3A", "_encstr_B40101");

    if(var_1 != "_encstr_B40101")
      var_0.radarmode = var_1;
    else
      var_0.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";

    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::onplayerconnect(var_0);
    threat_sight_monitor(var_0);
    var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_encstr_911512D50E8C16E8958D85B95D6EAC76BA1B1676();
  }
}

_id_126F1() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  wait 1;

  if(!istrue(game["_encstr_B23913A2485CFF7D08BDE2F117E0FD7389619BBA71"])) {
    scripts\mp\hud_message::showsplash("_encstr_A31814C493D7C193CAADC21DD81AEBDDACD81BDB6B2B");

    if(istrue(level.vehicle_collision_getleveldata))
      self setplayermusicstate("_encstr_BEB50E400B37ADFBBAB128B9F72BE14B");
  }

  if(!istrue(level.br_infils_disabled)) {
    self waittill("_encstr_8F7D08C66A0125438523");

    if(isDefined(game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2140B22D9CD77E4F9C1756BE7"]))
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A2140B22D9CD77E4F9C1756BE7", self, 0);

    while(!self isonground())
      waitframe();
  } else
    level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);
  wait 1;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8EA412AB830729900AE9375F1AF448E69BAAE3B1", self, 0);
}

onspawnplayer() {
  self notify("_encstr_A1E00B25BA2FD7DBEA6085B830");
  var_0 = istrue(self.gulag);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer(var_0);
  _encstr_8C492BEBB1E647FA4817D76DE96AC7AF81E913F37B355765D03DAF6ECB488EA33B402AFA808093ADD09D8F63FF::initplayer();

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A7B606DA83796F4A"))
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::teamfriendlyto();

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_838F0D8DEFA26BC7D83780300FF4D9"))
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::initplayer();

  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  self.healthregendisabled = 0;
  self.br_lastscenecheck = gettime();
  self.needtoplayintro = undefined;
  self.gunnlessweapon = undefined;
  self.disable_hotjoining_after_time = undefined;
  self._id_12885 = undefined;

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_AB23109F838B7B7448013FC5BBA84402D013"))
    thread waitloadoutdone();

  level.superdelay = 0;
  level.superpointsmod = 1;
  self.br_perks = [0, 0, 0, 0, 0];
  self.br_perkpoints = 0;

  if(level._id_121C8)
    self getclientomnvar();
  else
    self weaponswitchbuttonPressed();

  if(level._id_121C9)
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(getdvarint("_encstr_B2641EF8FEFB87114BE68C37E3DADBB4F921B0FD7D700821D79290C73F183BB8", 0) > 0)
    level thread emissive(self);

  if(getdvarint("_encstr_91CC10B346F5F93A78B1150961675ADD7F11") == 1)
    self.healthregendisabled = 1;

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319E(0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319C(0);
  _id_1401F(self, self, 0, 1);
  level thread _id_14006();
}

waittill_return(var_0, var_1) {
  if(var_0 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  var_1 endon("_encstr_B81804322D2B");
  self waittill(var_0, var_2, var_3);
  var_1 notify("_encstr_BE3009989F7CABE51AAFDD", var_2, var_3, var_0);
}

waittill_confirm_or_cancel(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "_encstr_AD75063D571AE108") && (!isDefined(var_1) || var_1 != "_encstr_AD75063D571AE108"))
    self endon("_encstr_AD75063D571AE108");

  var_3 = spawnStruct();

  if(isDefined(var_0))
    childthread waittill_return(var_0, var_3);

  if(isDefined(var_1))
    childthread waittill_return(var_1, var_3);

  if(isDefined(var_2))
    childthread waittill_return(var_2, var_3);

  var_3 waittill("_encstr_BE3009989F7CABE51AAFDD", var_4, var_5, var_6);
  var_3 notify("_encstr_B81804322D2B");
  var_7 = spawnStruct();
  var_7.location = var_4;
  var_7.angles = var_5;
  var_7.string = var_6;
  return var_7;
}

_id_13C34(var_0) {
  var_1 = var_0 + (0, 0, 10000);
  var_2 = var_0 - (0, 0, 10000);
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
  var_4 = level.activekillstreaks;
  var_5 = scripts\engine\utility::array_combine(var_3, var_4);
  var_6 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
  return scripts\engine\trace::ray_trace(var_1, var_2, var_5, var_6, 0, 1);
}

giveprematchloadout() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!istrue(level.br_prematchffa)) {
    return;
  }
  if(isDefined(level.calculateclientmatchdataextrainfopayload))
    self[[level.calculateclientmatchdataextrainfopayload]]();
}

calculateclientmatchdataextrainfopayload() {
  var_0 = getdvarint("_encstr_AA721C6EC693FAC493D716631BB7EEBEE0E42BD658E8B1D0AFE0AC93AD37", 0) == 1;

  if(!var_0)
    thread scripts\mp\class::loadout_clearperks();

  waitframe();

  if(!level.allowsupers && !istrue(level.scriptedphysicaldofenabled) || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8F94079C2BB3B2C21B" || getdvarint("_encstr_ABE320C7AF03883842E1F1A8D23B48C07B4353733F8B6EB0574698E0BDDFB88E2233", 1) == 1) {
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12C81();
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper("_encstr_96F610C7E33F527201D9B5BD3029AC9B1841", 0);
  }
}

givematchloadout(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0.5;

  if(!isDefined(var_1))
    var_1 = 20;

  var_2 = self;
  var_3 = var_2 scripts\mp\class::loadout_getorbuildclassstruct(var_2.class);

  if(!isDefined(var_3)) {
    return;
  }
  var_2.prevweaponobj = undefined;
  var_2 scripts\mp\class::loadout_clearperks();
  var_2 scripts\mp\class::loadout_updateplayerperks(var_3);
  scriptednode(var_2);
  var_4 = 0;

  if(isDefined(var_3.loadoutsecondaryobject) && !nullweapon(var_3.loadoutsecondaryobject)) {
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_forcegivecustomweapon(var_2, var_3.loadoutsecondaryobject, var_3.loadoutsecondaryfullname, var_3.loadoutsecondary, var_0, var_1);
    var_4++;
  }

  if(isDefined(var_3.loadoutprimaryobject) && !nullweapon(var_3.loadoutprimaryobject)) {
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_forcegivecustomweapon(var_2, var_3.loadoutprimaryobject, var_3.loadoutprimaryfullname, var_3.loadoutprimary, var_0, var_1);
    var_4++;
  }

  if(var_4 > 1)
    var_2 takeweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

  var_5 = [];

  if(isDefined(var_3.loadoutequipmentprimary))
    var_5[var_5.size] = var_3.loadoutequipmentprimary;

  if(isDefined(var_3.loadoutequipmentsecondary))
    var_5[var_5.size] = var_3.loadoutequipmentsecondary;

  foreach(var_7 in var_5) {
    if(isDefined(level.br_pickups.br_equipnametoscriptable[var_7])) {
      var_8 = level.br_pickups.br_equipnametoscriptable[var_7];
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_2, var_8, 1);
    }
  }
}

givematchloadoutfordropbags() {
  var_0 = self;
  var_0.prevweaponobj = undefined;
  var_0 scripts\mp\class::loadout_clearperks();
  scriptednode(var_0);
}

prematchdeployparachute() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(self.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    waitframe();

  thread scripts\cp_mp\parachute::startfreefall(2, 0, undefined, undefined, 1, 0);
}

getprematchradius(var_0) {
  var_1 = var_0.radius;
  var_2 = var_0.minradius;
  var_3 = getdvarint("_encstr_931021721E5541DAF3390B1BF04891BBCF23F1EA7F9B1BEE7EC0473B09434902B3C542", -1);

  if(var_3 >= 0)
    var_1 = var_3;

  var_3 = getdvarint("_encstr_A5D7216EC6E4BE8927F507E495D6161D1B43D7CDE085EEDCAF6BD2E6F52785C8A5ABDC", -1);

  if(var_3 >= 0)
    var_2 = var_3;

  if(var_2 >= var_1)
    var_1 = var_2 + 1;

  return [var_2, var_1];
}

scriptednode(var_0) {
  if(istrue(level.playerkillstreakgetownerlookatignoreents)) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  var_1 = level.maxteamsize == 1;
  var_2 = istrue(var_0.shouldgetnewspawnpoint);

  if(var_1 && !var_2 && !istrue(level.brking_initpostmain)) {
    return;
  }
  if(!tvstation_fastrope_init(var_0)) {
    return;
  }
  if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743")) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  var_0 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
}

search_update_delay(var_0) {
  if(!tvstation_fastrope_init(var_0)) {
    return;
  }
  if(!var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  var_0 scripts\mp\perks\perks::bears();
}

waitloadoutdone() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker() || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    return;
  }
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()) {
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();
    return;
  }

  if(!istrue(level.br_prematchstarted)) {
    thread giveprematchloadout();
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();

    if(!istrue(self._id_12860)) {
      self._id_12860 = 1;
      scripts\engine\utility::delaythread(1.0, _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward, "_encstr_A3710FE04ECADAB03A6C34AF56733A5627", self);
      var_0 = game["_encstr_813F06832D8A18FE"]["_encstr_976C0F134E7D63B731892FEB5ACD3A39BD"].size - 1;
      var_1 = randomint(var_0);
      self setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_976C0F134E7D63B731892FEB5ACD3A39BD"][var_1]);
    }

    var_2 = getdvarint("_encstr_BD6714A643EBCEC3F262B9D0BACFB3E0EFDBAF17CF73", 0) != 0;

    if(istrue(level.infilcanusemap) && !var_2) {
      level waittill("_encstr_B8BF1A716AA78340F941FDD5791D015967D32EDBF223CD704B29F7CD");
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::resetplayerinventory();
    }

    level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");

    if(level.allowsupers)
      scripts\mp\supers::clearsuper(0);
  }

  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  var_3 = istrue(self.gulag) || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker() || istrue(self._id_12CA8);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::resetplayerinventory(var_3);

  if(!var_3)
    _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize();

  scriptednode(self);

  if(istrue(self.isrespawn)) {
    return;
  }
  if(istrue(self.gulag) || istrue(self._id_12CA8)) {
    return;
  }
  if(!istrue(level.br_infils_disabled) && !istrue(self.watch_for_usb_notetrack_switchoff))
    thread _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::setplayerprematchallows();
}

onplayerscore(var_0, var_1, var_2, var_3) {
  return var_2;
}

brmodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = var_3;

  if(level.tacticalmode)
    var_3 = scripts\mp\damage::gamemodemodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag() && istrue(var_1.gulagarena) && getdvarint("_encstr_920214BFD77BF0581D75599151FD1808F2470B236F52", 1))
    return var_3;

  if(!isDefined(var_10))
    var_10 = var_3;

  if(var_3 > 0) {
    if(istrue(var_1.tracking_max_health))
      var_1 notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

    var_12 = scripts\mp\utility\weapon::getweaponrootname(var_5);
    var_13 = scripts\mp\utility\weapon::getweaponbasenamescript(var_5);
    var_14 = weaponclass(var_5);

    if(var_4 == "_encstr_87A10C9D24E997A01F21838F3D34") {
      if(isDefined(level._id_11C94))
        var_3 = var_1[[level._id_11C94]](var_3);
      else if(var_1 scripts\mp\utility\killstreak::isjuggernaut()) {} else if(getdvarint("_encstr_AF6F1BF6366BCFD650FF8EFA48F989B7A1DDAFAD32415C2DE9C53D5809", 0)) {
        if(var_1 isskydiving())
          var_1 skydive_interrupt();

        var_3 = 0;
      } else if(isDefined(self.br_maxarmorhealth))
        var_3 = self.maxhealth + self.br_maxarmorhealth;
      else
        var_3 = self.maxhealth;
    } else if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && !istrue(var_0.stadium_one_death_func)) {
      if(isDefined(level._id_11C96))
        var_3 = var_1[[level._id_11C96]](var_3);
      else if(var_1 scripts\mp\utility\killstreak::isjuggernaut()) {} else {
        var_15 = self.maxhealth;

        if(isDefined(self.br_maxarmorhealth))
          var_15 = var_15 + self.br_maxarmorhealth;

        var_3 = scripts\mp\utility\script::roundup(var_3 * (var_15 / level._id_12602));
      }
    } else if(var_12 == "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD" && var_4 != "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215") {} else if(var_4 == "_encstr_8DED0A21C79B660BC7588981") {
      var_3 = int(var_10);
      var_3 = _id_11C9C(var_3, var_5);

      if(isDefined(var_0)) {
        if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_840E0D6ECA39EA6BFAD9C2C8D995E8")) {
          var_16 = _findnewlocaleplacement::randomoffsetmortar();
          var_3 = int(var_3 * var_16);
        }
      }
    } else if(scripts\mp\utility\weapon::iskillstreakweapon(var_5)) {
      if(istrue(var_1.inlaststand) && scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_5) == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895") {
        if(isDefined(var_1.disable_hotjoining_after_time)) {
          var_17 = gettime() - var_1.disable_hotjoining_after_time < 5000;

          if(var_17)
            var_3 = 0;
        }
      }
    } else if(var_4 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_4 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_4 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_4 == "_encstr_9B0D099AD3887D91252954") {
      if(getdvarint("_encstr_AF6F1BF6366BCFD650FF8EFA48F989B7A1DDAFAD32415C2DE9C53D5809", 0) && isDefined(var_0)) {
        var_3 = 0;
        var_1 thread debug_showcardlocs(var_0);
      }

      if(var_12 == "_encstr_ACC40CC1F8A321601715CFBFE0EA" || var_12 == "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB")
        var_3 = int(var_3 * 1.5);
    } else if(getdvarint("_encstr_BE8413F37E20A8AEF56E810BC337E1E001403E6F7A", 0) && var_4 != "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3")
      var_3 = difficulty_allowseekafterthreshold(var_9, var_14, var_12, var_8, var_3);
    else if(getdvarint("_encstr_9B8A19AECE33AF417A7FE0906F8DDB778BB32DB7A92A9BE8518728", istrue(level.half_size)) && var_4 != "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3")
      var_3 = died_poorly_funcs(var_9, var_14, var_12, var_8, var_10, var_3, var_5, var_4);

    if(isDefined(var_5)) {
      if(var_5.type == "_encstr_8C8D08671D451291C849") {
        switch (var_5.basename) {
          case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
            var_3 = int(var_3 * getdvarfloat("_encstr_ADBE1E20CB937FE2C2978039E3725BFAC6B42AB1DF296BB5682B0FD978AB81CD", 2));
            break;
          case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
            var_3 = int(var_3 * getdvarfloat("_encstr_8C09220BBFE8A90BBE6652CA2B9B3FDD29279C61E348ED83ED9E5AF330ED5712489B0DFA", 1.667));
            break;
          case "_encstr_92A70ABB8267F5E0D89F6351":
            var_3 = int(var_3 * getdvarfloat("_encstr_AAFB2072C138F782A627231F69437A0CA92B6F7D9B288829715B2B53BB77F271D093", 1.5));
            break;
          case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
            var_3 = int(var_3 * getdvarfloat("_encstr_819D194F2B5B468E0301BFCDA9839878AFF2C7B00D99F3F86F0553", 1.4));
            break;
          case "_encstr_BA730BF8AFF178988293F158B9":
            var_3 = int(var_3 * getdvarfloat("_encstr_91C11A68C26A47B1CB57B9A04C97BB9FD3A96BD04A8363CB6B99B526", 1.45));
            break;
          case "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA":
          case "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170":
          case "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83":
          case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
            if(var_8 == "_encstr_81CC0586952C91" || var_8 == "_encstr_A6CC076A05751852B3")
              var_3 = getdvarint("_encstr_8D4F20B3AF1389801ADFD8351928C9D0F14BACE57233285D50D0EBB3BB28A9E0E71C", 300);
            else
              var_3 = getdvarint("_encstr_8D4F20B3AF1389801ADFD8351928C9D0F14BACE57233285D50D0EBB3BB28A9E0E71C", 200);

            break;
        }
      }
    }

    if(disablebunker11cachelocations(var_1)) {
      if(var_12 != "_encstr_86B108781A36271E4F70") {
        var_3 = 0;

        if(isDefined(var_2))
          var_2 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB", 0, 0, "_encstr_A5AE098ADB583E0AF7A5AB", 0);
      } else
        var_3 = 1;

      if(var_1.health - var_3 <= 0)
        var_3 = 0;
    }

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_A3511399F56AFBE9595B700BE79DA369C29D0714CF")) {
      var_18 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_2, self, var_3, var_5, var_4, var_0, var_6, var_7);
      var_18.shitloc = var_8;
      var_18.idflags = var_9;
      var_3 = thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A3511399F56AFBE9595B700BE79DA369C29D0714CF", var_18);
    }

    if(var_3 == 10000 && level.delay_spawn_room_soldiers == 1)
      var_3 = int(level.delay_spawn_tanks);

    if(level.decide_new_code == 1 && istrue(self.unset_relic_shieldsonly) && (isDefined(var_4) && var_4 != "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3"))
      var_3 = guard_shack_mantle(var_3, var_1);

    if(var_13 == "_encstr_B8F811FFCAE9A908777459915A3940D2813771" || var_13 == "_encstr_85EA0D0B1181251728A113CA4E197B") {
      switch (var_8) {
        case "_encstr_8BBA05185F8B99":
          break;
        case "_encstr_81CC0586952C91":
          var_3 = level.delay_show_balloon;
          break;
        case "_encstr_9ABA05E87F4B70":
          var_3 = level.delay_show_marker_to_tv_station;
          break;
        case "_encstr_952B0C65857BBFB80F9FC0B8A75A":
          var_3 = level.delay_spawn_nav_repulsor;
          break;
        case "_encstr_8D9A10260457F8118F7ED3639F75A0BB9BDB":
          var_3 = level.delay_show_player_clip;
          break;
        case "_encstr_A9C30F63CA998ED716E4D67D5D1C0ECAE4":
          var_3 = level.delay_show_player_clip;
          break;
      }
    }

    if(isDefined(var_0) && isDefined(var_0.objweapon)) {
      if(var_0.objweapon.basename == "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC")
        var_3 = int(var_3 * level.pipe_room_dogtag_revive);
      else if(var_0.objweapon.basename == "_encstr_84A00E50B085578F87182E98ED81081B")
        var_3 = int(var_3 * level.pipe_room_dogtag_revive);
    }
  }

  if(isDefined(var_2) && isPlayer(var_2) && var_2 _meth_87DA(1)) {
    if(var_3 > var_11)
      var_3 = var_11;
  }

  return var_3;
}

_id_11C9C(var_0, var_1) {
  if(isDefined(level.player_equip_regen)) {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

    if(var_2 == "_encstr_A7ED0AD79F73990E28334B92")
      return var_0 * level.player_equip_regen;
  } else
    return var_0;
}

elevator_lower(var_0) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_883F1450CA279389AF06E56B01FFF04387B2D8C8A2BF"))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_883F1450CA279389AF06E56B01FFF04387B2D8C8A2BF", var_0);
  else if(isDefined(level.playerbrsquadleaderscore))
    return [[level.playerbrsquadleaderscore]](var_0);

  return var_0.damage;
}

_id_11C66(var_0) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_A9AE1816D8B1B7BBA9B2635659AC951A96B1C62B4458AD169DCA"))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A9AE1816D8B1B7BBA9B2635659AC951A96B1C62B4458AD169DCA", var_0);

  return 0;
}

_id_120AB(var_0) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_87EE111FD06FCD2A6306A59FED1B329111208B"))
    thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_87EE111FD06FCD2A6306A59FED1B329111208B", var_0);
}

_id_11C6B(var_0) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_9AB41DB476DCBDC9CAB2ACD04BD8C6CA153C83D8B79B4BCECA4416DA58ECAC"))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_9AB41DB476DCBDC9CAB2ACD04BD8C6CA153C83D8B79B4BCECA4416DA58ECAC", var_0);

  return 0;
}

_id_11C82(var_0) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_93311B4B70C8579DA809F9D34129A34FE069B012B897A717F9BFF1C40B"))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_93311B4B70C8579DA809F9D34129A34FE069B012B897A717F9BFF1C40B", var_0);

  return 1;
}

_id_11C67(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_83311156B3EB096899A7C8420E884679625D4D":
      case "_encstr_8664130DAC859DE5EBBBAC581CEDB9EB6C9385E8AC":
      case "_encstr_992A1BB5F7334D18E551C378C0C9D00D39573927CB1B9DD007756870AB":
      case "_encstr_BAF90BD64BF637B67D3293DB07":
      case "_encstr_96D516B648DD1B404537ADC86326F8CFFF133847B347132D":
      case "_encstr_A77318E360E304B2B3D01A552B636ADD2EC8263E82FE44CA8F5D":
      case "_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385":
        return 1;
      default:
        return 0;
    }
  }

  return 0;
}

_id_11C87(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = istrue(var_1.managerespawnfade);

    if(!var_2)
      var_2 = isDefined(var_1.cratetype) && _id_11C67(var_1.cratetype);

    if(var_2) {
      managerespawnfade(var_1, var_0, 75.0, -75.0);
      return 1;
    }
  }

  if(isscriptabledefined()) {
    var_3 = undefined;

    if(isDefined(var_1)) {
      var_3 = getclosestpointonnavmesh(var_1.origin);

      if(isDefined(var_3)) {
        var_4 = var_3 + (0, 0, 5);
        var_5 = playerphysicstrace(var_3, var_4);

        if(var_5 != var_4)
          var_3 = undefined;
      }
    }

    if(!isDefined(var_3)) {
      var_6 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0.origin, 30);
      var_3 = getclosestpointonnavmesh(var_6);
    }

    if(isDefined(var_3) && isDefined(var_1) && istrue(var_1.manageprematchfade)) {
      var_7 = [];

      if(isDefined(var_1.stage1accradius) && isarray(var_1.stage1accradius))
        var_7 = var_1.stage1accradius;

      var_8 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1);
      var_9 = scripts\engine\trace::ray_trace(var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62"), var_3, scripts\engine\utility::array_add(var_7, var_1), var_8);

      if(isDefined(var_9["_encstr_AA1C0886968EA32FE056"]) && var_9["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A" || !canspawn(var_3))
        var_3 = undefined;
    }

    if(isDefined(var_3)) {
      var_0 setOrigin(var_3);
      return 1;
    }
  }

  return 0;
}

debug_showcardlocs(var_0) {
  var_1 = (self.origin[0], self.origin[1], self.origin[2] + 36);

  if(self isonground()) {
    var_2 = (self.origin[0], self.origin[1], self.origin[2] + 20);
    self setOrigin(var_2);
  }

  var_3 = var_1 - var_0.origin;
  var_3 = vectorNormalize(var_3);
  var_4 = getdvarfloat("_encstr_8EA420CB926B30880ACF4B590CB908E0DB6AC653FA7752F8A3C27BA3109140B54393", 1300);
  var_5 = undefined;

  if(var_3[2] > -0.3)
    var_5 = getdvarfloat("_encstr_96A420D389DE977660476164F9E17D8F0DE1A94B903E0FEF68358D7DC9B905DFA0FA", 600);

  var_6 = distance2d(var_0.origin, self.origin) - 20;
  var_7 = clamp(var_6, 0, 80) / 100 * 0.5;
  var_8 = 1;
  var_9 = var_8 - var_7;
  var_3 = var_3 * var_4 * var_9;

  if(isDefined(var_5)) {
    var_10 = var_8 - var_7 * 0.5;
    var_5 = var_5 * var_10;
    var_3 = (var_3[0], var_3[1], max(var_5, var_3[2]));
  }

  self setvelocity(var_3);
}

difficulty_allowseekafterthreshold(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && var_0 &level.idflags_penetration)
    var_5 = 1;
  else
    var_5 = 0;

  if(!var_5) {
    switch (var_1) {
      case "_encstr_8D940738966ED1DB8D":
        if(var_2 == "_encstr_88FE0D0157202970845121C58E802F" || var_2 == "_encstr_8D900DB477077D1C2DD736E0C28385") {
          if(var_3 == "_encstr_81CC0586952C91" || var_3 == "_encstr_A6CC076A05751852B3")
            var_4 = 250;
          else
            var_4 = 150;
        }

        break;
      case "_encstr_850707F7E5833355B8":
        if(var_2 == "_encstr_BE031194230A97F388073F637F2EBBE2088B48")
          var_4 = 250;

        break;
      default:
        break;
    }
  }

  return var_4;
}

tutzonetriggerlogic(var_0) {
  return isDefined(var_0) && var_0 &level.idflags_penetration;
}

usefailvehiclemsg(var_0) {
  return var_0 == "_encstr_82660D691C902EABA8293197FB038E" || var_0 == "_encstr_88F60EF477AA1917C80F0C3A6946EACA" || var_0 == "_encstr_92DF0ED45BDA2E53D81F08FF1B5F9FC2" || var_0 == "_encstr_A1E90DBB8CDA89536851CF8BDD6B66" || var_0 == "_encstr_928210A17CC2BF6265499B129B43DFB323EF";
}

use_respawn_rules(var_0) {
  return var_0 == "_encstr_8BE10EBF5ACEE07BAFE44BB1605A936F" || var_0 == "_encstr_B2050D9B944F0F7A41AB41B8220B1A" || var_0 == "_encstr_99B310905209D5DBA9FAC38B62BB2FE0850A" || var_0 == "_encstr_81A6117B61F155DBB8B032EA3B0BCF1AAA13B6";
}

vehicle_collision_handleevent(var_0, var_1, var_2) {
  return var_0 == "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A" && var_1 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" && var_2 == 1;
}

unset_maze_ai_stealth_settings(var_0) {
  return var_0 == "_encstr_8A5C0FA8E32097400C0797904EA782221F" || var_0 == "_encstr_A6AE10032092892E28FFF91A34B95007CB0A" || var_0 == "_encstr_9B82124BEE07F5E643EBE82799AE633685D547ED" || var_0 == "_encstr_A1E70FBB8CDA89535851E1C3D9EB66A97A" || var_0 == "_encstr_AD4F12B0D388CF5261E150B6B897B9F0A18B1B2F" || var_0 == "_encstr_B68F0EDC43FAE686BE2639BDD6ACBDA9";
}

died_poorly_funcs(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = tutzonetriggerlogic(var_0);

  if(!var_8) {
    switch (var_1) {
      case "_encstr_965306392D3336B2":
        var_9 = var_5 / var_4;

        if(getweaponammopoolname(var_6) == "_encstr_9389125DA80582F427BC28A935D3EB6A31AA1D4D") {
          if(level.deletescavengerhud >= 0) {
            var_9 = var_5 / var_4;
            var_5 = min(var_5, level.deletescavengerhud);
            var_5 = int(var_9 * var_5);
          }

          break;
        }

        if(scripts\cp_mp\utility\weapon_utility::tv_station_boss(var_2))
          var_10 = 1;
        else if(usefailvehiclemsg(var_2)) {
          if(var_3 == "_encstr_81CC0586952C91" || var_3 == "_encstr_A6CC076A05751852B3") {
            var_5 = getdvarint("_encstr_83BC213BF60B3FA6DDC9FAB268AFDA43E3E6A3A519B0F76CAB40722B4037D3CF19C13F", 175);
            break;
          }

          var_10 = 1;
        } else if(var_2 == "_encstr_99550F225BABC7E65077BBB13990FBCE96" || var_2 == "_encstr_8E1C12B974CAB79E2541F33FA85F56573BD72C2D" || var_2 == "_encstr_84FC17199FB2A1B7486ECB07939E2766803F8197D58077F7E3")
          var_10 = level.half_size + 1;
        else
          var_10 = level.half_size;

        var_5 = difficulty_init(var_4, var_6, var_10);
        var_5 = int(var_9 * var_5);
        break;
      case "_encstr_8D940738966ED1DB8D":
      case "_encstr_BE0703A54C":
        if(var_2 == "_encstr_96D20C74F8FBB7C3433793F84727" && var_6 hasattachment("_encstr_81930DF1E6B2C87D8B6F673B4F424D"))
          return var_5 * 0.9;
        else if(var_2 == "_encstr_AB9A12A0049A2EA801CFC4629853282CCBBBEBF0")
          return var_5;
        else if(var_2 == "_encstr_BAB10F67F72A59E09850B24028F0060E50" && var_6 hasattachment("_encstr_8C4F0FB0DA4BDAC4EDAF0E2C38C2661918"))
          return var_5 * 0.9;
        else {
          var_9 = var_5 / var_4;
          var_5 = difficulty_init(var_4, var_6, level.half_size);
          var_5 = int(var_9 * var_5);
        }

        break;
      case "_encstr_850707F7E5833355B8":
        if(level._encstr_8C791A1EBE37BBFEB81837634971A1532BDD2914A68F0239C0880727 == 0) {
          break;
        }

        if(var_3 == "_encstr_81CC0586952C91" || var_3 == "_encstr_A6CC076A05751852B3") {
          if(vehicle_collision_handleevent(var_2, var_7, var_5))
            var_5 = 75;
          else if(usefailvehiclemsg(var_2))
            var_5 = getdvarint("_encstr_83BC213BF60B3FA6DDC9FAB268AFDA43E3E6A3A519B0F76CAB40722B4037D3CF19C13F", 175);
          else if(use_respawn_rules(var_2))
            return var_5;
          else
            var_5 = getdvarint("_encstr_B83B1DCF184B572AF5B8457C1887733E53F8072BB081A4E339480BF975BB0A", 250);
        } else if(vehicle_collision_handleevent(var_2, var_7, var_5))
          return var_5;
        else {
          var_9 = var_5 / var_4;

          if(usefailvehiclemsg(var_2) || var_2 == "_encstr_A52C0E7020307103407898128DC7C6CB")
            var_11 = 1;
          else if(var_2 == "_encstr_BAA51049A41A67CACDF1230A9823050EC3AF")
            var_11 = 3;
          else
            var_11 = level.half_size;

          var_5 = difficulty_init(var_4, var_6, var_11);
          var_5 = int(var_9 * var_5);
        }

        break;
      case "_encstr_BE1904DCDA9D":
        if(var_2 == "_encstr_B69F0D69EFC2D1C7B9FE5BB7418FCB" || var_2 == "_encstr_BD6513D08B1A5868B5B709ABB6DD901E03C20BFB32" && var_7 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")
          return var_5;
        else if(scripts\cp_mp\utility\weapon_utility::tv_station_boss(var_2)) {
          var_12 = 1;

          if(var_2 == "_encstr_AAA50F2F308ACFA34330BBE0862BEBAB6B")
            var_12 = 2;
        } else
          var_12 = 3;

        var_9 = var_5 / var_4;
        var_5 = difficulty_init(var_4, var_6, var_12);
        var_5 = int(var_9 * var_5);

        if(var_6 hasattachment("_encstr_85F90F4F16822EE3FFAB7909E233AB29DD") && var_5 >= 30 && var_5 != 36)
          var_5 = var_5 * 0.92;

        break;
      case "_encstr_A1100738A33A638123":
        if(var_2 == "_encstr_B499142DEE83EBE02DEB8E930E5AB98E7B63B934ED47" && var_6 hasattachment("_encstr_873517CAB06B577E904F8869B7B050EB832B1392F83E3B7560") && var_6 hasattachment("_encstr_A7351AB880415F58B92B8120F37F634E62720B65303D9A780D4CD276"))
          return var_5 * 0.95;

        if(var_2 == "_encstr_B499142DEE83EBE02DEB8E930E5AB98E7B63B934ED47")
          return var_5;

        if(level.delete_door_clip >= 0) {
          if(unset_maze_ai_stealth_settings(var_2) && level.delete_dropped_weapon >= 0)
            var_13 = level.delete_dropped_weapon;
          else
            var_13 = level.delete_door_clip;

          var_9 = var_5 / var_4;
          var_5 = min(var_5, var_13);
          var_5 = int(var_9 * var_5);
        }
      default:
        break;
    }
  }

  return var_5;
}

disablebunker11cachelocations(var_0) {
  return istrue(var_0.gulag) && !istrue(var_0.gulagarena);
}

difficulty_init(var_0, var_1, var_2) {
  var_3 = 0;

  if(var_2 == 4)
    var_3 = var_1 clearvehiclesticker();
  else if(var_2 == 3)
    var_3 = var_1 getweaponclassint();
  else if(var_2 == 2)
    var_3 = var_1 getmid3damage();

  if(var_3 <= 0)
    var_3 = var_1.mindamage;

  if(var_2 == 1 || var_3 <= 0)
    var_3 = var_1.maxdamage;

  if(var_0 < var_3)
    return int(var_3);
  else
    return var_0;
}

onplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(scripts\mp\utility\weapon::iskillstreakweapon(var_6)) {
    if(scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_6) == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" && istrue(level.vehicle_collision_getleveldata))
      return;
  }

  if(isDefined(var_1) && var_1 != var_2 && isPlayer(var_1)) {
    if(var_3 >= var_7)
      var_3 = var_7;

    if(var_3 > 0) {
      var_14 = scripts\mp\utility\weapon::getweaponbasenamescript(var_6);

      if(var_14 == "_encstr_86B108781A36271E4F70" && isalive(var_2))
        var_2 playlocalsound("_encstr_8B8D1C264A6E6F1581906FC1AAAD095F38B9E551C06B83F7FF5B2BC11BA9");

      if((var_14 == "_encstr_BA410C6338E0D79EC39832198839" || var_14 == "_encstr_AB0B08D8BD58B1EBB607") && isalive(var_2))
        _encstr_8A0E28B7504BB4F9B39BBED567EE912625A1FB335B055A179923CEE1F028B188BD684DC6738BA6EC7FF3::airstrike_watchownerdisown(var_14, var_1, var_2);
    }

    var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A7B10CF1BFEA8F782D5FF9717D04", var_1.pers["_encstr_B2BE0788BAF573592F"]);
  } else if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_15 = var_0;

    if(isDefined(var_15.owner) && isPlayer(var_15.owner) && var_15.owner != var_2)
      var_15.owner _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A7B10CF1BFEA8F782D5FF9717D04", var_15.owner.pers["_encstr_B2BE0788BAF573592F"]);
  } else if(isDefined(var_0) && var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::unrescuable_fail()) {
    var_16 = var_0;

    if(isDefined(var_16.owner) && isPlayer(var_16.owner) && var_16.owner != var_2)
      var_16.owner _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A7B10CF1BFEA8F782D5FF9717D04", var_16.owner.pers["_encstr_B2BE0788BAF573592F"]);
  }

  if(isDefined(var_6) && scripts\mp\utility\weapon::iskillstreakweapon(var_6)) {
    var_17 = var_3 >= var_7 && scripts\mp\utility\killstreak::getkillstreaknamefromweapon(var_6) == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895";
    var_18 = istrue(var_2.inlaststand);

    if(var_17 && var_18)
      var_2.disable_hotjoining_after_time = gettime();
  }

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9")) {
    var_19 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_6, var_5, var_0, undefined, var_9);
    thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9", var_19);
  }
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_0.hostdamagepercenthigh = 0;
  var_6 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_6 == "_encstr_BE180419DAE9" || var_6 == "_encstr_8AE1099A0B999F2D28AF15" || var_6 == "_encstr_9B1F05BE4B9B52" || var_6 == "_encstr_B18D0B5281530117EDEAC82033" || var_6 == "_encstr_816E079685517D0975" || var_6 == "_encstr_A1D0081CC297B1EDB08C" || var_6 == "_encstr_BAA110C9BA5BC48D56D74BB9D92CCD4BBDE6" || var_6 == "_encstr_866209ECEDB1197DEE0B4E") {
    return;
  }
  var_7 = scripts\mp\utility\game::getlivingplayers();

  if(isDefined(level.numendgame)) {
    if(var_7.size <= level.numendgame)
      level thread startendgame(1);
  }

  var_8 = level.totalplayers - var_7.size;
  var_9 = 0;

  foreach(var_11 in level.players) {
    if(isDefined(var_11.score) && var_11.score > var_9)
      var_9 = var_11.score;

    if(isDefined(var_11.petwatch) && isalive(var_11)) {
      var_12 = 1 - var_8 / level.totalplayers;
      var_11 scripts\cp_mp\pet_watch::_id_13E23(var_12, 5);
    }
  }

  if(!level.teambased) {
    var_0.score = level.totalplayers - var_7.size;

    foreach(var_11 in var_7)
    var_11.score = var_0.score + 1;
  }
}

getalivecount(var_0) {
  var_1 = 0;

  if(istrue(var_0)) {
    foreach(var_3 in level.teamnamelist)
    var_1 = var_1 + scripts\mp\utility\teams::getteamdata(var_3, "_encstr_8A2A0B936CCCC3078547970A8B");
  } else {
    foreach(var_3 in level.teamnamelist) {
      var_6 = scripts\mp\utility\teams::getteamdata(var_3, "_encstr_8A2A0B936CCCC3078547970A8B");

      if(var_6) {
        var_7 = scripts\mp\utility\teams::getteamdata(var_3, "_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE");

        foreach(var_9 in var_7) {
          if(isDefined(var_9) && !istrue(var_9.gulag))
            var_1 = var_1 + 1;
        }
      }
    }
  }

  return var_1;
}

doplayerkilledsplashes(var_0, var_1) {
  if(istrue(level.usegulag) && var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
    return;
  }
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(var_0.team, var_0.squadindex);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 != var_0)
      var_4 thread scripts\mp\hud_message::showsplash("_encstr_918E11899CBE3AB258B56BC23A2BAF465685C8", undefined, var_0);
  }
}

_id_13387() {
  if(istrue(level.usegulag) && !istrue(level.gulag.shutdown)) {
    var_0 = getalivecount(0);

    if(var_0 <= getdvarint("_encstr_87F11E802A829F69E36F048E17EBF3B3A183F0A8239F3D837F7C9BFE01F3187B", -1))
      _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::shutdowngulag("_encstr_A7E60D8363F85FA2B6F17737DDA0C8", var_0);
  }
}

_id_13388() {
  if(istrue(level.usegulag) && !istrue(level.gulag.shutdown)) {
    var_0 = getdvarint("_encstr_9A651C829E28B7C50531E8EFDFA5C335C12B786955805FB4CCAB8022A1C1", -1);

    if(var_0 < 0) {
      return;
    }
    var_1 = _id_11F43(0);

    if(var_1 <= var_0)
      _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::shutdowngulag("_encstr_82A60B887A76EBDEB72FFD782C", var_1);
  }
}

onplayerdisconnect(var_0) {
  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_838F0D8DEFA26BC7D83780300FF4D9"))
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_11BE2(var_0, undefined, 0);

  if(istrue(level.br_prematchstarted)) {
    thread _id_13387();
    thread _id_13388();
    thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::onplayerdisconnect(var_0);

    if(isDefined(var_0) && istrue(var_0.inlaststand) && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_B18D0B5281530117EDEAC82033" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
      var_0 thread _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::droponplayerdeath();

      if(isDefined(var_0.watch_for_attack))
        var_0.watch_for_attack thread scripts\mp\damage::_id_125E3();
    }
  }

  thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destpoint(var_0, int(scripts\mp\utility\player::isreallyalive(var_0)));

  if(isDefined(var_0)) {
    if(isDefined(var_0.team)) {
      var_1 = scripts\mp\utility\teams::getenemyteams(var_0.team);
      var_2 = [];

      foreach(var_4 in var_1) {
        if(scripts\mp\utility\teams::getteamdata(var_4, "_encstr_8A2A0B936CCCC3078547970A8B"))
          var_2[var_2.size] = var_4;
      }

      var_6 = var_2.size + 1;

      if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
        [var_8, var_9, var_10] = forceunsetdemeanor(var_6);

        if(var_8 > 0) {
          var_0 scriptableusepart(var_8, undefined, "_encstr_8D820B49520F0EC02DDE6367EC");
          var_0.matchbonus = var_9;
          var_0._id_12394 = var_10;
        }

        var_0 _id_1319A(var_6);
        var_0 scripts\cp_mp\utility\game_utility::_id_13168(var_6);
        scripts\mp\gamelogic::ammobox_onplayerholduse(var_0, var_6);
        var_0 _encstr_ABE327C7AF0393A844EAD8E8527758DFAA1F715B7B9A668A6A82DE217CE1F881824BDFFB9F96242083::_id_11E53();
      }

      var_0 thread setup_intel(var_6);
    }

    if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
      var_0 _id_138D6();
      _id_13FCC(var_0);
    }
  }

  level thread _id_14006();
}

_id_13FCC(var_0) {
  scripts\mp\gamelogic::_id_128AF(var_0);
  scripts\mp\scoreboard::_id_128A8(var_0);
  var_1 = getdvarint("_encstr_82B60B391184FF772B3949D2CE", 0);

  if(var_1)
    var_0 setshowinrealism();
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(istrue(level.br_prematchstarted)) {
    if(var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
      self._id_14436 = 1;
    else
      self._id_14436 = 0;

    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::droponplayerdeath(var_1);
    doplayerkilledsplashes(self, var_1);
    _id_13387();
    _id_13388();
    _id_12641(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::resetplayerinventory();
  onplayerscore("_encstr_ABD70578F3D02C", var_1, 0, self);

  if(isDefined(self.watch_for_molotov_ambush_and_spawners)) {
    scripts\mp\utility\outline::outlinedisable(self.watch_for_molotov_ambush_and_spawners, self);
    self.watch_for_molotov_ambush_and_spawners = undefined;
  }

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_8CDB0F17758F62C1503912545010040A7D")) {
    var_10 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_2, var_4, var_3, var_0, undefined, var_5);
    var_10.hitloc = var_6;
    thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8CDB0F17758F62C1503912545010040A7D", var_10);
  }

  searchradiusmax(var_0, var_1, var_4);

  if(!istrue(level.br_prematchstarted)) {
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playerplunderlivelobbydropondeath(var_3);
    return;
  }

  thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::onplayerkilled(var_1, self);
  thread _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::playerdied(var_1, var_4);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319E(0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319C(0);
  _id_1401F(self, self, 0, 1);

  if(istrue(self.inlaststand)) {
    if(isPlayer(var_1))
      var_1 incrementcleanupsstat();
  }

  var_11 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8F351F39D6AB5F8FECFFB840AB1923CBF27CA1B36DF23911CCAF0839EF5C98339A");

  if(!isDefined(var_11))
    var_11 = !istrue(level.usegulag);

  if(var_11)
    _id_11B15(self, "_encstr_8CDB0F17758F62C1503912545010040A7D");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()) {
    if(isbot(self) && isPlayer(var_1) && !istrue(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()))
      var_1 notify("_encstr_A5390DAFD3C93A9DD006BF4579A0B9");
  }

  if(istrue(level.disable_super_in_turret.brmayconsiderplayerdead))
    self._id_1443F = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();

  if(istrue(level.disable_super_in_turret.brlootchoppercratecapturecallback))
    self._id_14438 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_8265155B5AB76EB6D7EDDCA08DC2975939D25A8D63CA91"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8265155B5AB76EB6D7EDDCA08DC2975939D25A8D63CA91", self);

  var_12 = getdvarint("_encstr_8CBE155E3EC35FB3A85770B0C7D86B757963D8EA17DACF", 0) > 0;
  var_13 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag();

  if(var_12 && !var_13) {
    var_14 = getdvarfloat("_encstr_99F1216E6CC9FA26C9EB43D9EC7D477BB52BB9D7B1D016CDD8B2EBB7B9EB8C2BC2E843", 0.5);

    if(randomfloat(1.0) < var_14)
      _encstr_8F9B2D92FEB5C228D3F8D6C7F860F78A7305DB88DF333B0F79D81FE798ADADA3F3276789C879D29A2010CF3A90BB63::_encstr_96D316F2C05717CDC30DADC87D24F8EB830730CD9F431120(self.origin, var_1.angles + (0, 90, 0), self);
  }

  level thread _id_14006();
}

_id_11B15(var_0, var_1) {
  var_0 _id_12640(1, var_1);
  var_0.delay_enter_combat_after_investigating_grenade = 1;
  level notify("_encstr_834E15F643A97834B1675243A7D81DD4674B302AFB48A1");
  var_0 _id_14007();
  var_0 scripts\mp\gamelogic::updateplayerleaderboardstats();
}

_id_13F21(var_0, var_1) {
  var_0 _id_12640(0, var_1);
  var_0.delay_enter_combat_after_investigating_grenade = 0;
  var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  var_0 _id_14007();
}

_id_12641(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(getdvarint("_encstr_BD3619D07AD2EF19933F5F56113B0327FE728860B221CFF0E72665", 1) && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    var_10 = "_encstr_9A120B8AB4D202962D3636D140" + gettime() + "_encstr_BE0703F5EF";
    var_10 = var_10 + (scripts\engine\utility::ter_op(isDefined(var_1) && !isstruct(var_1), var_1 getentitynumber(), "_encstr_9B4C023E") + scripts\engine\utility::ter_op(isDefined(var_0), "_encstr_964C0249" + var_0 getentitynumber(), "_encstr_B40101") + "_encstr_8C07035505");
    var_10 = var_10 + scripts\engine\utility::ter_op(isDefined(self), self getentitynumber(), "_encstr_9B4C023E");
    var_10 = var_10 + scripts\engine\utility::ter_op(isDefined(var_3), "_encstr_BE0703F5EF" + var_3, "_encstr_B40101");
    logstring(var_10);
  }
}

_id_12640(var_0, var_1) {
  if(getdvarint("_encstr_BD3619D07AD2EF19933F5F56113B0327FE728860B221CFF0E72665", 1) && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    var_2 = scripts\engine\utility::ter_op(istrue(var_0), "_encstr_AF690BCA49785A851358721FB2", "_encstr_92D20DCDB5DD92253352513BDA8A47") + gettime() + "_encstr_BE0703F5EF";
    var_2 = var_2 + (scripts\engine\utility::ter_op(isDefined(self), self getentitynumber(), "_encstr_9B4C023E") + "_encstr_BE0703F5EF");
    var_2 = var_2 + scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_AAAC09D09972B9C83F2B7F");
    logstring(var_2);
  }
}

_id_1263F(var_0, var_1, var_2) {
  if(getdvarint("_encstr_BD3619D07AD2EF19933F5F56113B0327FE728860B221CFF0E72665", 1) && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    var_3 = scripts\engine\utility::ter_op(istrue(var_0), "_encstr_82200A7AC2D62080A3C5A786", "_encstr_B49A0D455AD204A4ACADED67AC8E10") + gettime() + "_encstr_BE0703F5EF";
    var_3 = var_3 + (scripts\engine\utility::ter_op(isDefined(self), self getentitynumber(), "_encstr_9B4C023E") + "_encstr_BE0703F5EF" + var_1 + "_encstr_BE0703F5EF");
    var_3 = var_3 + scripts\engine\utility::ter_op(isDefined(var_2), var_2, "_encstr_8BBA05185F8B99");
    logstring(var_3);
  }
}

getglobalbattlepassxpmultiplier(var_0) {
  if(getdvarint("_encstr_BD3619D07AD2EF19933F5F56113B0327FE728860B221CFF0E72665", 1) && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    foreach(var_2 in level.players) {
      if(isalive(var_2) && !istrue(var_2.delay_enter_combat_after_investigating_grenade) && !var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC() && !var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && var_2.team != var_0)
        scripts\mp\utility\script::laststand_dogtags("_encstr_879929D9CB6AC3A8FA86B8F33D9718D7825323DBB7C287E8056F898925BCF23DBADBB5C77BCE545856D081" + var_2 getentitynumber());
    }
  }
}

_id_14007() {
  var_0 = self;
  var_1 = 0;
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_4 in var_2) {
    if(istrue(var_4.delay_enter_combat_after_investigating_grenade))
      var_1 = var_1 | 1 << var_4.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] - 1;
  }

  foreach(var_4 in var_2)
  var_4 setclientomnvar("_encstr_935D11AB5AF5984ED72B362DAD5AB9C2D1B232", var_1);

  if(istrue(level.matchmakingmatch)) {
    var_8 = var_0 getfireteammembers();

    if(isDefined(var_8) && var_8.size > 0) {
      var_9 = 2;

      foreach(var_4 in var_8) {
        if(isDefined(var_4) && !istrue(var_4.delay_enter_combat_after_investigating_grenade)) {
          var_9 = 0;
          break;
        }
      }

      var_0 setclientomnvar("_encstr_A5011EAB96BE13C97D9B2E570B91D79536D26B2DB985A3B232EB58B1E8B49D56", var_9);

      foreach(var_4 in var_8)
      var_4 setclientomnvar("_encstr_A5011EAB96BE13C97D9B2E570B91D79536D26B2DB985A3B232EB58B1E8B49D56", var_9);
    }
  }
}

incrementcleanupsstat() {
  var_0 = self;

  if(!isDefined(var_0.br_cleanups))
    var_0.br_cleanups = 0;

  var_0.br_cleanups++;
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_AD4109B11B2B0BDCAEE037", var_0.br_cleanups);
}

registercrateforcleanup(var_0) {
  level.br_pickups.crates[level.br_pickups.crates.size] = var_0;
}

dropshield(var_0) {}

makeitemsfromcrate(var_0) {
  var_1 = self.data;

  if(var_1.type == "_encstr_8D2509C1CAC9B9DEDC16B1") {
    makepersonalweaponfromcrate(var_0);
    return;
  }

  if(var_1.type == "_encstr_AC20072B9FA9487832") {
    var_2 = randomintrange(2, 4);
    var_3 = 6 - var_2;
  } else {
    var_2 = randomintrange(1, 2);
    var_3 = 6 - var_2;
  }

  var_4 = 0;

  for(var_5 = 0; var_5 < var_2 && var_4 < level.br_pickups.br_dropoffsets.size; var_5++) {
    if(isDefined(makeweaponfromcrate(var_4)))
      var_4++;
  }

  for(var_5 = 0; var_5 < var_3 && var_4 < level.br_pickups.br_dropoffsets.size; var_5++) {
    if(isDefined(makeitemfromcrate(var_4)))
      var_4++;
  }
}

makeweaponfromcrate(var_0) {
  var_1 = scripts\engine\utility::random(level.br_pickups.br_crateguns);
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::relics_monitor_on_player(var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[var_0], 50, -200, (0, 0, 1)) + (0, 0, 24);
  var_4 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::createspawnweaponatpos(var_3, (0, 0, 90), var_2);

  if(isDefined(var_4))
    var_4.isweaponfromcrate = 1;

  return var_4;
}

makeitemfromcrate(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[var_0], 50, -200, (0, 0, 1)) + (0, 0, 12);
  var_2 = scripts\engine\utility::random(level.br_pickups.br_crateitems);
  var_3 = var_2;
  var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_1, (0, 0, 90));
  var_5 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_3, var_4, 1);
  return var_5;
}

_id_11AA0(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[0], 50, -200, (0, 0, 1)) + (0, 0, 12);
  var_2 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_1, (0, 0, 90));
  var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_0, var_2, 1);
  return var_3;
}

makepersonalweaponfromcrate(var_0) {
  var_1 = self.data;
  var_2 = scripts\engine\utility::drop_to_ground(self.origin + (0, 0, 6), 50, -200, (0, 0, 1)) + (0, 0, 24);
  var_3 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::createspawnweaponatposfromname(var_2, var_1.personalweaponfullname);

  if(isDefined(var_3)) {
    var_3.isweaponfromcrate = 1;
    var_0 loadweaponsforplayer([var_1.personalweaponfullname]);
  }

  return var_3;
}

iconvisall(var_0, var_1) {}

objvisall(var_0) {
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
}

initloot() {
  level.br_weaponweights = [];
  level.br_weaponweights["_encstr_8C160DAFE71BF161681EB5BCB0F8FC"] = 20;
  level.br_weaponweights["_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D"] = 40;
  level.br_weaponweights["_encstr_A1E70FBB8CDA89535851E1C3D9EB66A97A"] = 40;
  level.br_weaponweights["_encstr_A5090EB4DD83D78D16BE3B4EED5BACB7"] = 30;
  level.br_weaponweights["_encstr_9AB60FB477707DB1DAFA6DD263DB1364C4"] = 10;
  level.br_weaponweights["_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C"] = 10;
  level.br_weaponweights["_encstr_87610AB4EE83FAD6374B3395"] = 5;
  level.br_weaponweights["_encstr_8BE20ED75722A6731BF84F3064CA126B"] = 50;
  level.br_weaponweights["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 20;
  level.br_weaponweighttotal = 0;

  foreach(var_2, var_1 in level.br_weaponweights)
  level.br_weaponweighttotal = level.br_weaponweighttotal + var_1;

  level.attachmentmap = [];
  level.attachmentmap["_encstr_8C160DAFE71BF161681EB5BCB0F8FC"] = [];
  level.attachmentmap["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = [];
  level.attachmentmap["_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D"] = [];
  level.attachmentmap["_encstr_9AB60FB477707DB1DAFA6DD263DB1364C4"] = [];
  level.attachmentmap["_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C"] = [];
  level.attachmentmap["_encstr_8BE20ED75722A6731BF84F3064CA126B"] = [];
  level.attachmentmap["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = [];
  level.baseraritymap = [];
  level.baseraritymap["_encstr_8C160DAFE71BF161681EB5BCB0F8FC"] = 1;
  level.baseraritymap["_encstr_AF510F2DBB83EBC2E47D0BB696C6B743E6"] = 1;
  level.baseraritymap["_encstr_857F0EA5BB0EEB37B57DAD38B0C1584D"] = 1;
  level.baseraritymap["_encstr_A1E70FBB8CDA89535851E1C3D9EB66A97A"] = 1;
  level.baseraritymap["_encstr_A5090EB4DD83D78D16BE3B4EED5BACB7"] = 1;
  level.baseraritymap["_encstr_9AB60FB477707DB1DAFA6DD263DB1364C4"] = 1;
  level.baseraritymap["_encstr_B4190F4BDDC1BE9BB9D70BB10786584D0C"] = 3;
  level.baseraritymap["_encstr_87610AB4EE83FAD6374B3395"] = 0;
  level.baseraritymap["_encstr_8BE20ED75722A6731BF84F3064CA126B"] = 0;
  level.attachraritymap = [];
  level.attachraritymap["_encstr_BACC05C9770D68"] = 1;
  level.attachraritymap["_encstr_AD3E09B95A632BDC6CCA27"] = 2;
  level.attachraritymap["_encstr_8A07035972"] = 2;
}

weaponlocallowed(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_4 = var_3.origin[2] - 24;
    var_5 = var_3.origin[2] + 90 - 24;

    if(scripts\engine\utility::distance_2d_squared(var_3.origin, var_0.origin) < 147456 && var_0.origin[2] >= var_4 && var_0.origin[2] <= var_5)
      return 0;
  }

  return 1;
}

startendgame(var_0) {
  if(istrue(level.br_debugsolotest)) {
    return;
  }
  scripts\mp\gamelogic::pausetimer();
  level.timepausestart = gettime();
  level.timelimitoverride = 1;
}

debugtestcirclevfx(var_0) {
  if(isDefined(level.circleemitters))
    destroyemitters(level.circleemitters);

  level notify("_encstr_8A9816CEA79D9951131BDF8F3C484FE46A6622E7E912778C");
  waitframe();

  switch (var_0) {
    case 1:
      level thread rundebugvfxcircletest(1000, 0, 15, 2000);
      break;
    case 2:
      level thread rundebugvfxcircletest(2500, 1000, 20, 2000);
      break;
    case 3:
      level thread rundebugvfxcircletest(4500, 2500, 25, 2000);
      break;
    case 4:
      level thread rundebugvfxcircletest(7000, 4500, 40, 2000);
      break;
    case 5:
      level thread rundebugvfxcircletest(10500, 7000, 70, 2000);
      break;
    case 6:
      level thread rundebugvfxcircletest(15000, 10500, 80, 2000);
      break;
    case 7:
      level thread rundebugvfxcircletest(20000, 15000, 80, 2000);
      break;
    case 8:
      level thread rundebugvfxcircletest(50000, 20000, 80, 2000);
      break;
  }
}

groundraycast(var_0) {
  var_1 = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  var_2 = var_0 + (0, 0, 10000);
  var_3 = var_2 + (0, 0, -20000);
  var_4 = physics_raycast(var_2, var_3, var_1, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_4) && var_4.size > 0)
    return var_4[0]["_encstr_BD260953AA97E3F014279D"];

  return (0, 0, 0);
}

debugplayercirclevfx() {
  for(;;) {
    waitframe();

    if(!isDefined(level.circledebugpos) || !isDefined(level.circledebugradius)) {
      continue;
    }
    var_0 = distance2d(self.origin, level.circledebugpos) < level.circledebugradius;

    if(istrue(self.debugcircleincircle)) {
      if(!var_0 && level.debugcircleplayerfx == 0) {
        playFXOnTag(level._effect["_encstr_97A614673387FA3B8537EB39B4B93BBE38C6855E5939"], self, "_encstr_A130084D2FDAD8AA8F62");
        level.debugcircleplayerfx = 1;
        self.debugcircleincircle = 0;
      }

      continue;
    }

    if(var_0 && !self.debugcircleincircle) {
      self.debugcircleincircle = 1;
      stopFXOnTag(level._effect["_encstr_97A614673387FA3B8537EB39B4B93BBE38C6855E5939"], self, "_encstr_A130084D2FDAD8AA8F62");
      level.debugcircleplayerfx = 0;
    }
  }
}

rundebugvfxcircletest(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A9816CEA79D9951131BDF8F3C484FE46A6622E7E912778C");

  if(!istrue(level.debugcircleplayerfx))
    level.players[0] thread debugplayercirclevfx();

  var_4 = 5;
  var_5 = level.players[0] groundraycast(level.players[0].origin);
  level.circleemitters = spawnentsincircle(var_5, var_0, var_3);
  level.circledebugpos = var_5;
  wait 0.1;
  spawnvfxincircle(level.circleemitters);
  var_6 = var_2;

  while(var_2 > 0) {
    var_7 = var_2 / var_6;
    var_8 = var_1 + (var_0 - var_1) * var_7;

    if(var_4 < 0) {
      destroyemitters(level.circleemitters);

      if(var_8 <= 0) {
        return;
      }
      level.circledebugradius = var_8;
      var_4 = 5;
      level.circleemitters = spawnentsincircle(var_5, var_8, var_3);
      wait 0.1;
      spawnvfxincircle(level.circleemitters);
    } else
      updateemitterpositions(var_5, var_8, level.circleemitters);

    var_2 = var_2 - level.framedurationseconds;
    var_4 = var_4 - level.framedurationseconds;
    waitframe();
  }
}

destroyemitters(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1])) {
      stopFXOnTag(level._effect["_encstr_8E7D13CE991EBECEB0CDAFC92D73ECEB8357CC33CB"], var_0[var_1], "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_0[var_1] delete();
    }
  }
}

updateemitterpositions(var_0, var_1, var_2) {
  var_3 = var_2.size;
  var_4 = 6.2831 * var_1;
  var_5 = 360 / var_3;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_5 * var_6;
    var_8 = sin(var_7) * var_1;
    var_9 = cos(var_7) * var_1;
    var_10 = groundraycast(var_0 + (var_9, var_8, 0));
    var_2[var_6].origin = var_10;
    var_2[var_6].angles = (0, var_7 + 180, 0);
  }
}

spawnentsincircle(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 6.2831 * var_1;
  var_5 = var_4 / var_2;

  if(var_5 < 200)
    iprintlnbold("_encstr_AC45078DFAB2FDF138" + int(var_5) + "_encstr_8A5B0AE26775A1780BEFAD90");
  else
    iprintlnbold("_encstr_85BA0B5860B5AFB359ED232D2F" + int(var_5) + "_encstr_A96A1D08B2D62D3AD1AC4E6E0B01D53796CDCE808C6003015AB93747B22C19");

  var_5 = min(var_5, 200);
  var_6 = 360 / var_5;

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_8 = var_6 * var_7;
    var_9 = sin(var_8) * var_1;
    var_10 = cos(var_8) * var_1;
    var_11 = groundraycast(var_0 + (var_10, var_9, 0));
    var_3[var_7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_11);
    var_3[var_7] setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3[var_7].origin = var_11;
    var_3[var_7].angles = (0, var_8 + 180, 0);
  }

  return var_3;
}

spawnvfxincircle(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    playFXOnTag(level._effect["_encstr_8E7D13CE991EBECEB0CDAFC92D73ECEB8357CC33CB"], var_0[var_1], "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

debuggiveperkpoints() {
  var_0 = scripts\mp\utility\game::getlivingplayers();

  foreach(var_2 in var_0)
  var_2.br_perkpoints = var_2.br_perkpoints + 5;
}

ontimelimit() {
  if(isDefined(level.numendgame))
    level thread startendgame(1);

  level.numendgame = undefined;
}

onplayerjointeam(var_0) {
  if(!isDefined(var_0.team))
    scripts\mp\utility\script::laststand_dogtags("_encstr_BD622F101ABBC1F8B08D054DBF9CC8853782283266D69BB007652503D6C7A073CA2B80C15B3FBE12237D3313803C4A8972" + var_0.name);

  if(!scripts\mp\utility\teams::isgameplayteam(var_0.team))
    scripts\mp\utility\script::laststand_dogtags("_encstr_8C2534AA9077D33EA0BB0ACA57D805FB05E90247F197BFF2799B1DED41D88E1725815ABA88BF13ED10B30DE2E54057BFD19156F68047" + var_0.name + "_encstr_974C0246" + var_0.team);

  thread _id_1206E(var_0);
}

_id_1206E(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waittillframeend;

  if(level.teambased) {
    var_1 = [];

    for(var_2 = 1; var_2 < _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::replace_sat_piece_on_deathordisconnect() + 1; var_2++)
      var_1[var_1.size] = var_2;

    var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
    var_4 = 1;

    foreach(var_6 in var_3) {
      if(istrue(var_6.unicornpoints)) {
        continue;
      }
      if(istrue(var_6.tutorial_usingparachute))
        var_4 = 0;

      if(isDefined(var_6.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]))
        var_1 = scripts\engine\utility::array_remove(var_1, var_6.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]);
    }

    if(var_1.size == 0 && !isDefined(var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]))
      scripts\mp\utility\script::laststand_dogtags("_encstr_91E84927ED40C1564E6EDA88E62EBA58C8D4B26B98AC4E947319CAC344AB04C2EC162DC60B898DB20B028EA12D373BDC1085279502314E7BD6AC7390804B40B9C5AE1691375AF42B407A40" + _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::replace_sat_piece_on_deathordisconnect() + "_encstr_ABCA0AC2041D2B16DA409E80" + var_0.team + "_encstr_858310B001DC2E578591293732951E084F10" + var_0.squadindex + "_encstr_A1D10F0B4047952CB6049BB4D3AC109E02" + var_3.size);
    else {
      var_8 = undefined;

      if(isDefined(var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]))
        var_8 = var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"];
      else
        var_8 = var_1[0];

      if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A3380CCF6327ABEBEC818BC88F5B"))
        var_0 _id_1319D(var_4);

      var_0 _id_131A8(var_8);
    }
  }
}

ondeadevent(var_0) {
  if(istrue(level.br_debugsolotest) || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_B18D0B5281530117EDEAC82033" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_816E079685517D0975" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E") {
    return;
  }
  if(isDefined(var_0) && var_0 != "_encstr_AF1904A7F929") {
    thread _id_1209A(var_0);
    var_1 = [];

    foreach(var_3 in scripts\mp\utility\teams::getenemyteams(var_0)) {
      if(scripts\mp\utility\teams::getteamdata(var_3, "_encstr_8A2A0B936CCCC3078547970A8B"))
        var_1[var_1.size] = var_3;
    }

    var_5 = var_1.size + 1;

    foreach(var_7 in scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B")) {
      var_7 scripts\cp_mp\utility\game_utility::_id_13168(var_5);
      var_7 _id_138D6();
    }

    scripts\mp\gamelogic::default_ondeadevent(var_0);
  }
}

_id_11F43(var_0) {
  var_1 = 0;
  var_2 = level.teamnamelist;

  foreach(var_4 in var_2) {
    if(scripts\mp\utility\teams::getteamdata(var_4, "_encstr_8A2A0B936CCCC3078547970A8B")) {
      if(var_0) {
        var_1++;
        continue;
      }

      var_5 = 0;
      var_6 = scripts\mp\utility\teams::getteamdata(var_4, "_encstr_9775086022BE1B413B8B");

      foreach(var_8 in var_6) {
        if(isDefined(var_8) && !var_8 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal()) {
          var_5 = 1;
          break;
        }
      }

      if(var_5)
        var_1++;
    }
  }

  return var_1;
}

_id_1209A(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.teamnamelist) {
    if(var_4 == var_0) {
      continue;
    }
    var_5 = scripts\mp\utility\teams::getteamdata(var_4, "_encstr_8A2A0B936CCCC3078547970A8B");

    if(var_5) {
      var_1[var_1.size] = var_4;
      var_6 = var_5;

      if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_92D41C7DFDCD983B3312B09969D3E7806742C7936CB468758F7A0FC1428F"))
        var_6 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_92D41C7DFDCD983B3312B09969D3E7806742C7936CB468758F7A0FC1428F", var_4);

      var_2 = var_2 + var_5;
    }
  }

  var_8 = var_1.size + 1;
  _id_1209B(var_0, var_8, var_2, 0);
  wait 20;
  thread scripts\mp\gamelogic::setupelevatordoor();
}

_id_1209B(var_0, var_1, var_2, var_3, var_4, var_5) {
  soundsettimescalefactorfromtable(var_0, var_1);
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::dialog_monitor_getoffground(var_0, var_1);
  [var_7, var_8, var_9] = forceunsetdemeanor(var_1);
  var_10 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  foreach(var_12 in var_10) {
    if(isDefined(var_12)) {
      var_12 scriptableusepart(var_7, undefined, "_encstr_A65110DF496B381D3FE230B89ABB474887B4");
      var_12._id_1287A = var_7;
      var_12.matchbonus = var_8;
      var_12._id_12394 = var_9;
    }
  }

  if(!istrue(var_4))
    wait 1.5;

  if(!istrue(level.vehicle_collision_getleveldata)) {
    if(!istrue(var_3) && var_2 < 5)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BEBD0BE3B57089ED893357770F", 0, var_10, 1);
    else if(!istrue(var_3) && var_2 < 10)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B1580CA1F74BE0DA6889E880AAE5", 0, var_10, 1);
    else if(!istrue(var_3) && var_2 < 25)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_9B8C0C2DCD13AF4B3D7F98882785", 0, var_10, 1);

    if(!istrue(var_5))
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A2600AB55AC23379FBCF7BDA", 0, var_10, 1);
  }

  foreach(var_12 in var_10) {
    if(isDefined(var_12)) {
      var_12 thread setup_intel(var_1);
      var_12 _id_1319A(var_1);
      var_12 _id_138D6();
      scripts\mp\gamelogic::ammobox_onplayerholduse(var_12, var_1);
      _id_13FCC(var_12);
    }
  }

  _id_13120(var_0);
}

setup_intel(var_0) {
  var_1 = self;
  var_1 endon("_encstr_B4040CC8B4B96CEDB9B99BCA6CE8");

  if(var_0 < 4)
    var_1 scripts\cp_mp\pet_watch::below_player_eye_allowance();

  var_2 = gettime();
  var_1 setclientomnvar("_encstr_B14816D596AF8939EB1CB1B0CBCA9C7D83BD9BB41D2DEDB9", var_0);

  if(!istrue(var_1.br_spectatorinitialized) && !var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && !var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    var_1 waittill("_encstr_AB6B185EF2998F6B05D7F040935763B3F25CCD538E0263D2EDE3");

  var_1 setclientomnvar("_encstr_A5011EAB96BE13C97D9B2E570B91D79536D26B2DB985A3B232EB58B1E8B49D56", 1);
  var_1 setclientomnvar("_encstr_97B31357D27D9CEDAE73917D2B9B46BEA3B4D1C659", game["_encstr_AAF00AA3C077B857EFB7F045"]["_encstr_AD0C0759F517A03753"]);
  var_1 setclientomnvar("_encstr_8F91145D4BFA39DE5D3732AFACB991EBE459169BBD9B", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B2EB0EA2103F27CB58D9010EE7C3D72F"]);
  var_1 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  var_1 notify("_encstr_9191195A33D053DF804BC7C643D0A52F78493292B8938316C0B3F4");
}

_id_1319A(var_0) {
  var_1 = self;

  if(!isDefined(var_1) || istrue(var_1._id_12396)) {
    return;
  }
  var_1._id_12396 = 1;
  var_1._id_13AB8 = var_0;

  if(var_0 <= 25) {
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_A1AB0EAD3FC881A8AD18838F9C6F13D1", 1);

    if(var_0 <= 10) {
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_82190715F52B81894E", 1);

      if(var_0 <= 5) {
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_ADF208A8B778CDD39BAF", 1);

        if(var_0 == 1)
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_A9F6058464DADF", 1);
      }
    }

    var_1 scripts\mp\gamelogic::updateplayerleaderboardstats();
  }
}

forceunsetdemeanor(var_0) {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return [0, 0, 0];

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_A6A7136CB0631BEA630B8E56842909BDB9EA9B0B28"))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A6A7136CB0631BEA630B8E56842909BDB9EA9B0B28", var_0);

  if(usingtacmap())
    return [0, 0, 0];

  if(isDefined(level._id_133C0) && istrue(level._id_133C0))
    return [0, 0, 0];

  var_1 = getdvarfloat("_encstr_9B321A1E762A1FE6333F8BB010052016F951884319A4AF3397807562", 0.0039);

  if(!isDefined(level._id_13864) || !isDefined(var_0) || !isDefined(level._id_14676) || (level._id_13864 <= 0 || var_0 <= 0 || level._id_14676 <= 0))
    return [0, 0, 0];

  var_2 = gettime() - level._id_13864;
  var_3 = int(var_1 * var_2 + 0.5);
  var_4 = level._id_14676 * (level._id_14678 - var_0 + 1);
  var_5 = var_3 + var_4;
  return [var_5, var_3, var_4];
}

usingtacmap() {
  return getdvarint("_encstr_8E12206B32CB5060AB924113A89739B773CAC333FACBF5A1477B111BB73D29DD9F73", _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99"));
}

usingobject() {
  return getdvarint("_encstr_B1D320B936277DB9AE26A2F2C156D7DECE59E49CB48CAC24B4EC51CA58B6A895B98E", scripts\mp\menus::_id_13733());
}

_id_12C6F() {
  scripts\cp\vehicles\vehicle_compass_cp::_id_12C6E("_encstr_9933089193CA642806B7");
  scripts\cp\vehicles\vehicle_compass_cp::_id_12C6E("_encstr_A9B10D16D8A53B2BEBB473F5D9C2CD");
  scripts\cp\vehicles\vehicle_compass_cp::_id_12C6E("_encstr_82A71120EA74DD99472EF07507F380971DC280");
}

_id_138D6() {
  scripts\cp\vehicles\vehicle_compass_cp::_id_138D5("_encstr_9933089193CA642806B7");
  scripts\cp\vehicles\vehicle_compass_cp::_id_138D5("_encstr_A9B10D16D8A53B2BEBB473F5D9C2CD");
  scripts\cp\vehicles\vehicle_compass_cp::_id_138D5("_encstr_82A71120EA74DD99472EF07507F380971DC280");
}

searchradiusmax(var_0, var_1, var_2) {
  var_3 = self;

  if(isDefined(var_1) && var_1 _calloutmarkerping_handleluinotify_mappingdeletemarker::updateexpiredlootleader()) {
    if(isDefined(var_3.team) && isDefined(var_1.team) && var_3.team != var_1.team) {
      if(isDefined(var_2) && isDefined(var_2.basename) && var_2.basename == "_encstr_84A00E50B085578F87182E98ED81081B") {
        var_4 = var_1.vehicle.owner;

        if(isDefined(var_4) && var_4 != var_1)
          var_4 thread scripts\mp\utility\points::sec_sys_struct_1("_encstr_A11014B083716D23CFCC05FEA24F6B4FA63B80600B53");
      }
    }
  }
}

scriptableusepart(var_0, var_1, var_2) {
  if(!isDefined(self) || isbot(self) || initmaxspeedforpathlengthtable(self)) {
    return;
  }
  if(!game["_encstr_B18F0BDD815F4151AECB982052"]) {
    return;
  }
  if(!(scripts\mp\utility\game::matchmakinggame() || getdvarint("_encstr_AD460A97B91F0DAE3BDBEF88"))) {
    return;
  }
  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_BD3914408A558FBB4F0E55CC19372129B290B8A0B32A") && (usingtacmap() || usingobject())) {
    return;
  }
  if(!getdvarint("_encstr_8AFC1D9BC23B4078BF820B35BCA44996276AD303A9AB0FD956943917C7CF58", 1)) {
    var_3 = scripts\mp\utility\game::round_vehicle_logic();

    if(var_3 == "_encstr_A254085207A6B7334B5A" || var_3 == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8" || var_3 == "_encstr_B4F40EE8C95685E657C92BAF43EA731D" || var_3 == "_encstr_AD300C932B4C969CD1D0AF911346" || var_3 == "_encstr_B4CE14E49513D24E47D07D321319EB4ECA9DCAC9CD95")
      return;
  }

  if(isDefined(self.dialog_wait_ready) && self.dialog_wait_ready == 0) {
    return;
  }
  var_4 = 0;
  var_5 = 0;

  if(!isDefined(var_2))
    var_2 = "_encstr_8C500ABA9B23CACC2D37AC8C";

  switch (var_2) {
    case "_encstr_8D820B49520F0EC02DDE6367EC":
      var_4 = 1;
      var_5 = 1;
      break;
    case "_encstr_A65110DF496B381D3FE230B89ABB474887B4":
      var_4 = 1;
      var_5 = 1;
      break;
    case "_encstr_8B4A08AC3746E8165B56":
    case "_encstr_A6EA07CF498568A5DB":
      var_4 = 1;
      var_5 = 1;
      break;
    case "_encstr_8C500ABA9B23CACC2D37AC8C":
    default:
      var_4 = 0;
      var_5 = 1;
      break;
  }

  if(isDefined(self._id_1287A))
    var_0 = var_0 - self._id_1287A;

  if(var_0 > 0) {
    scripts\mp\rank::giverankxp("_encstr_BA4E0F1EBE37CBF938B0C3EBA150A68307", var_0, var_1, var_4, var_5);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::deregisterscriptableinstance(var_0, var_2);
  }

  self.dialog_wait_ready = 0;
}

_id_1319B() {
  var_0 = 545000;
  var_1 = var_0;
  var_2 = max(1, level.maxteamsize);
  var_3 = 0;

  foreach(var_5 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_5, "_encstr_AB580A05672AE35D5FFF50B8"))
      var_3++;
  }

  var_3 = max(1, var_3);
  var_7 = 200;
  var_8 = 25;
  var_9 = int(var_3 * (var_3 + 1) / 2);
  var_9 = max(var_9, 1);
  var_10 = int(var_1 / (var_9 * var_2) + 0.9);
  var_10 = int(clamp(var_10, var_8, var_7));
  var_11 = getdvarint("_encstr_880E1A3BB35607ED604FB0DDC97F5DADA3C5580719C397E8926950F9", var_10);
  level._id_14676 = var_11;
  level._id_14678 = var_3;
  level._id_13864 = gettime();
}

searchradiusidealmax(var_0) {
  if(!isDefined(level._id_145A5))
    level._id_145A5 = freight_lift_combat();

  var_1 = self.lastnormalweaponobj;
  var_2 = int(var_0 * level._id_145A5);
  scriptableusestate("_encstr_B40101", var_2, var_1, 1, 0);
}

freight_lift_combat() {
  var_0 = getdvarfloat("_encstr_A3831BE66C4EFA989CAFDDAC581C7B9BD71628BED6968DB9CA367BDC32");

  if(var_0 != 0.0)
    return var_0;

  var_1 = 0.0031;
  return var_1;
}

scriptableusestate(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || scripts\mp\utility\weapon::iskillstreakweapon(var_2) || scripts\mp\utility\weapon::isvehicleweapon(var_2)) {
    return;
  }
  if(isDefined(self.owner) && !isbot(self)) {
    self.owner scriptableusestate(var_0, var_1, var_2);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }
  if(!isDefined(var_1) || var_1 <= 0) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!var_3)
    scripts\mp\utility\points::displayscoreeventpoints(var_1, var_0);

  if(!level.playerxpenabled) {
    return;
  }
  thread _id_1435E(var_0, var_1, var_2, var_4);
}

_id_1435E(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_3))
    var_3 = 0;

  if(!var_3) {
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  var_4 = 0;

  if(!isDefined(var_2) || !scripts\mp\weaponrank::weaponshouldgetxp(var_2.basename)) {
    return;
  }
  var_4 = var_1;
  var_4 = var_4 * scripts\mp\weaponrank::getweaponrankxpmultipliertotal();
  var_4 = int(var_4);
  scripts\mp\rank::incrankxp(0, var_2, var_4, "_encstr_A3E30B05B26B9007735A689693");

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(var_2) && (scripts\mp\utility\weapon::iscacprimaryweapon(var_2) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_2))) {
      if(!scripts\mp\utility\weapon::ispickedupweapon(var_2) || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
        scripts\common\utility::_id_13E0A(level._id_11B31, scripts\mp\utility\weapon::getweaponrootname(var_2), "_encstr_AF2F0A13317F6999F380EB53", var_4, -1, var_2);
    }
  }
}

freeze_bomb_vest_timer(var_0) {
  var_1 = 100;
  var_2 = 1;

  if(usingtacmap())
    var_2 = 0.6;
  else
    var_2 = 20;

  var_3 = int(var_1 + var_0 * var_2 * (80 / (40 + var_0)));
  var_4 = 50;
  var_3 = var_3 - var_3 % var_4 + var_4;
  return var_3;
}

resetpostgamestateonjoinedspectators() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = gettime();

  if(!istrue(self.br_spectatorinitialized))
    self waittill("_encstr_AB6B185EF2998F6B05D7F040935763B3F25CCD538E0263D2EDE3");

  var_1 = 3;
  var_2 = (gettime() - var_0) / 1000;

  if(var_2 < var_1)
    wait(var_1 - var_2);

  self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 0);
}

ononeleftevent(var_0) {
  if(istrue(level.br_debugsolotest)) {
    return;
  }
  if(level.teambased) {
    var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);

    if(isDefined(var_1)) {
      if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_B8CD1DF19377E7EE6DBA4BC1E3639999CA497B9A867208FA2021D379A2CA77", var_1))) {
        return;
      }
      var_1 scripts\engine\utility::delaythread(0.5, _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog, "_encstr_A3CC128B305334B193FFCD89DE996AE619E80B5F", 0, [var_1]);
      return;
    }
  } else {
    level.lastplayerwins = scripts\mp\utility\game::getlastlivingplayer();
    level thread scripts\mp\gamelogic::endgame(level.lastplayerwins, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF36133B4BA241B065DAE6B90541588BAADF81B31B"]);
  }
}

onsuicidedeath(var_0) {
  if(!level.teambased) {
    var_1 = scripts\mp\utility\game::getlivingplayers();
    var_0.score = level.totalplayers - var_1.size;

    foreach(var_3 in var_1)
    var_3.score = var_0.score + 1;
  }

  if(!isgamebattlematch() && istrue(var_0.elevator_manager)) {
    if(!isDefined(var_0.hostdamagepercenthigh))
      var_0.hostdamagepercenthigh = 1;
    else
      var_0.hostdamagepercenthigh++;

    if(var_0.hostdamagepercenthigh >= getdvarint("_encstr_AA4921734EB3876E1511524AC81F693F48A0FB1DD6FB9374F52819E310735ECFC19D63", 5))
      level thread scripts\mp\teams::vehomn_controlsarefadedoutorhidden(var_0);
  }
}

_id_11E38() {
  if(isDefined(level.forcedend))
    return _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && level.forcedend;

  return 0;
}

brendgame(var_0, var_1, var_2, var_3) {
  if(level.gameended) {
    return;
  }
  if(isDefined(var_1))
    logstring("_encstr_8C84182BCAC50FB1FB218018319179A25D3EBD86E52D37C54372" + var_1);
  else
    logstring("_encstr_8C85172BCAC50FB1FB218018319179A25D3EBD86E52D37C543");

  if(!istrue(var_3))
    getglobalbattlepassxpmultiplier(var_0);

  level.gameendtime = gettime();
  level.gameended = 1;
  level notify("_encstr_9B1D0BC7932875276230426AA1", var_0);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(var_1 == 25) {
      level.defensefactormod = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C790797213DC9E51B", "_encstr_83B306C13570D0CB")) {
        var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C790797213DC9E51B", "_encstr_83B306C13570D0CB");
        level.defenderflagreset = var_4;
      }
    } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C790797213DC9E51B", "_encstr_B2380A32A855773618B3D6C7"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C790797213DC9E51B", "_encstr_B2380A32A855773618B3D6C7")]]();
  }

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::shutdowngulag("_encstr_A3AF090768A9910F4118EF", 0, 1);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    level.playerzombiethermalupdate = 1;

  if(!isDefined(level.get_rid_of_minigun))
    _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::emptyallvehicles();

  thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8B4A08AC3746E8165B56", var_0);

  if(_id_11E38()) {
    scripts\mp\gamelogic::endgame_regularmp(var_0, var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B2EB0EA2103F27CB58D9010EE7C3D72F"]);
    return;
  }

  setomnvarforallclients("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  var_5 = undefined;

  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595") {
    var_5 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");
    _id_145CB(var_5);
    level scripts\engine\utility::delaythread(1.0, _encstr_ABE327C7AF0393A844EAD8E8527758DFAA1F715B7B9A668A6A82DE217CE1F881824BDFFB9F96242083::_id_11B1D, var_0);

    if(!isDefined(var_2))
      var_2 = 1;

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && scripts\engine\utility::is_equal(var_1, 25))
      var_2 = 0;

    if(isDefined(level._encstr_9AE41B988F4BABFF3B483DB3A6323731A67FF8B807EFA39363B2A3CDBF) && var_2)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_86810DC329373F59204BC3DC6F2898", 0, var_5, undefined, undefined, undefined, level._encstr_9AE41B988F4BABFF3B483DB3A6323731A67FF8B807EFA39363B2A3CDBF);
    else if(var_2)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_86810DC329373F59204BC3DC6F2898", 0, var_5);

    [var_7, var_8, var_9] = forceunsetdemeanor(1);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::dialog_monitor_getoffground(var_0, 1);
    _encstr_A1B523C367E34230F8FBA28BA2E8B78FADFD8BD313D2D2A8FA637FD78B0D93E8EF8A771F58::_id_13FBC(var_5);

    foreach(var_11 in var_5) {
      if(!isDefined(var_11)) {
        continue;
      }
      if(istrue(var_11.inlaststand)) {
        if(var_11 scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9531CB9CA3699D74E2BCE5ACE56FADBDCEBADB41BD87D37AE6C6C599B37", var_11))
          var_11 scripts\mp\laststand::onrevive(1);
      }

      var_11 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::hangar_doors_opening_quadrace();

      if(istrue(var_11.tracking_max_health))
        var_11 notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

      var_11 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
      var_11.spawnprotection = 1;
      var_11 setclientomnvar("_encstr_B14816D596AF8939EB1CB1B0CBCA9C7D83BD9BB41D2DEDB9", 1);
      var_11 scriptableusepart(var_7, undefined, "_encstr_A6EA07CF498568A5DB");
      var_11.matchbonus = var_8;
      var_11._id_12394 = var_9;
      var_11 scripts\cp_mp\pet_watch::below_player_eye_allowance();
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyscorelaunchonly(var_11, "_encstr_AA130B0EC685BC2B93D7BB5A37");
      var_11 _id_1319A(1);
      var_11 scripts\cp_mp\utility\game_utility::_id_13168(1);
      var_11 _id_138D6();
      scripts\mp\gamelogic::ammobox_onplayerholduse(var_11, 0);
      var_11 scripts\mp\gamelogic::updateplayerleaderboardstats();
      _id_13FCC(var_11);

      if(var_11 ispcplayer())
        var_11 setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 23);

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && !isbot(var_11))
        var_11 thread[[level.mover_init]]();
    }

    _id_13120(var_0);
  } else {
    var_13 = [];

    if(isDefined(level._id_12D05)) {
      var_14 = getdvarint("_encstr_96631BDB16EBDF067D69ABD2C8BB3EEBA6075C41BE515F8F1D0861FBE0", 1984);

      foreach(var_16 in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(var_16, "_encstr_AB580A05672AE35D5FFF50B8"))
          var_13[var_13.size] = var_16;
      }

      var_18 = var_13.size;
      [var_7, var_8, var_9] = forceunsetdemeanor(var_18);

      foreach(var_11 in level.players) {
        var_11 scriptableusepart(var_7, undefined, "_encstr_8B4A08AC3746E8165B56");
        var_11._id_1287A = var_7;
        var_11.matchbonus = var_8;
        var_11._id_12394 = var_14;
        var_11 _id_138D6();
      }
    } else if(istrue(level._id_14603)) {
      var_22 = getdvarint("_encstr_8381170AB9408FEAFE7F5B7617A752E960C10517F0884783D7", 5140);

      foreach(var_16 in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(var_16, "_encstr_AB580A05672AE35D5FFF50B8"))
          var_13[var_13.size] = var_16;
      }

      var_18 = var_13.size;
      [var_7, var_8, var_9] = forceunsetdemeanor(var_18);

      foreach(var_11 in level.players) {
        var_11 scriptableusepart(var_7, undefined, "_encstr_8B4A08AC3746E8165B56");
        var_11._id_1287A = var_7;
        var_11.matchbonus = var_8;
        var_11._id_12394 = var_22;
        var_11 _id_138D6();
      }
    } else {
      foreach(var_16 in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(var_16, "_encstr_8A2A0B936CCCC3078547970A8B"))
          var_13[var_13.size] = var_16;
      }

      var_18 = var_13.size;
      [var_7, var_8, var_9] = forceunsetdemeanor(var_18);

      foreach(var_11 in level.players) {
        if(!isDefined(var_11)) {
          continue;
        }
        if(isbot(var_11) || initmaxspeedforpathlengthtable(var_11)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_11)) {
          continue;
        }
        var_11 scriptableusepart(var_7, undefined, "_encstr_8B4A08AC3746E8165B56");
        var_11 _id_138D6();
        var_11.spawnprotection = 1;
        var_11 setclientomnvar("_encstr_B14816D596AF8939EB1CB1B0CBCA9C7D83BD9BB41D2DEDB9", 1);
      }
    }

    foreach(var_16 in var_13)
    _id_13120(var_16);
  }

  var_35 = undefined;

  if(isDefined(var_5))
    var_35 = _encstr_A1B523C367E34230F8FBA28BA2E8B78FADFD8BD313D2D2A8FA637FD78B0D93E8EF8A771F58::get_center_of_array(var_5);

  var_36 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getvalidplayersinarray(level.players, level.questinfo.defaultfilter);
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroy_jammer_relocate(var_36);
  level thread _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroy_lmgs();
  _encstr_A1B523C367E34230F8FBA28BA2E8B78FADFD8BD313D2D2A8FA637FD78B0D93E8EF8A771F58::_id_13E00(var_5, var_35);

  if(isDefined(level.defend_spawn_crates))
    wait(level.defend_spawn_crates);

  if(isDefined(level.defenderflagreset))
    level thread[[level.defenderflagreset]](var_0);
  else {
    level thread handleendgamesplash(var_0);
    level thread setup_player_stealth(var_0);

    if(istrue(level._id_13364))
      level thread setup_player_marks(var_0);

    if(isDefined(level.defensefactormod))
      wait(level.defensefactormod);

    level thread setup_player_stealth(var_0);

    if(istrue(level._id_13364))
      level thread setup_player_marks(var_0);
  }

  if(isDefined(level.delete_players_black_screen))
    level[[level.delete_players_black_screen]](var_0);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(isDefined(level.lootcontentsadjust_accesscardsred)) {
      level thread[[level.lootcontentsadjust_accesscardsred]](var_0, var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B2EB0EA2103F27CB58D9010EE7C3D72F"]);
      return;
    }
  }

  if(isDefined(var_5) && isDefined(var_35))
    _encstr_A1B523C367E34230F8FBA28BA2E8B78FADFD8BD313D2D2A8FA637FD78B0D93E8EF8A771F58::_id_123DE(var_5, var_35);

  scripts\mp\gamelogic::endgame_regularmp(var_0, var_1, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B2EB0EA2103F27CB58D9010EE7C3D72F"]);
}

_id_145CB(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isDefined(var_2) || !isPlayer(var_2)) {
      continue;
    }
    var_2 _encstr_A1B523C367E34230F8FBA28BA2E8B78FADFD8BD313D2D2A8FA637FD78B0D93E8EF8A771F58::namehud();
  }
}

handleendgamesplash(var_0) {
  var_1 = [];

  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595")
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  var_2 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_B18D0B5281530117EDEAC82033" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_816E079685517D0975" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E")
    thread scripts\mp\music_and_dialog::_id_12789(var_1);

  foreach(var_4 in var_1) {
    var_4 setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", var_2);
    var_4 setclientomnvar("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 1);
  }
}

setup_player_stealth(var_0) {
  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595") {
    var_1 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_126CC) && var_3._id_126CC.team == var_0 && var_3.team != var_0 && !isDefined(var_3.shoulddropbrprimary)) {
        var_3 setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", var_1);
        var_3 setclientomnvar("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 1);
        var_3.shoulddropbrprimary = 1;
      }
    }
  }
}

setup_player_marks(var_0) {
  if(isDefined(var_0) && var_0 != "_encstr_8D19048EA595") {
    var_1 = scripts\mp\gamelogic::reinforcement_icon_objective_id();

    foreach(var_3 in level.players) {
      if(var_3.team != var_0 && !isDefined(var_3.shoulddropbrprimary)) {
        var_3 setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", var_1);
        var_3 setclientomnvar("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 1);
        var_3.shoulddropbrprimary = 1;
      }
    }
  }
}

brdpadcallback(var_0, var_1) {
  if(istrue(level.stop_end_breach_fx)) {
    return;
  }
  if(isDefined(var_0)) {
    switch (var_0) {
      case "_encstr_A7BE0FF23073B7D7CBA9F7E428F1CFBB85":
        if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && var_1 == 0) {
          if(isDefined(level.lootchopper_spawn))
            self thread[[level.lootchopper_spawn]](var_0, var_1);

          break;
        }

        thread _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_1298F(var_1);
        break;
      case "_encstr_86480D41F8DEA0D0B7B280EBA9877F":
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::useitemfrominventory(var_1);
        break;
      case "_encstr_ADE90EB9D351398FAB8A766769B2935E":
        _encstr_A34B22F3AA53231093FBDFA370AD60FFF762AB3A036766B22ED237913DA278BE52BAC3E1::buyperkinslot(var_1);
        break;
      case "_encstr_959D0CE391DF2A370871085769F0":
        thread scripts\cp\vehicles\little_bird_mg_cp::fulton_hostage_vo();
        break;
      case "_encstr_AD6412D486A3F1ABD3307F19A39BADC1CFB0DDDB":
        var_2 = var_1;
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_126E1(var_2);
        break;
      case "_encstr_9B830C13E4EB46E47B0EBE2CB18D":
        if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && var_1 == 0) {
          if(isDefined(level.lootchopper_spawn))
            self thread[[level.lootchopper_spawn]](var_0, var_1);

          break;
        }

        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12988(var_1);
        break;
      default:
        break;
    }
  }
}

get_int_or_0(var_0) {
  if(!isDefined(var_0))
    return 0;

  return int(var_0);
}

parachutecomplete() {
  if(disable_fulton_group_interactions() && !dialog_mount_nag_watcher() && !istrue(self.dropbagspawned) && !istrue(level._id_1284C)) {
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath()) {
      thread _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::spawndropbagonlanding();

      foreach(var_1 in level.teamdata[self.team]["_encstr_9775086022BE1B413B8B"])
      var_1.dropbagspawned = 1;
    }
  }

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    thread _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::_id_1334A(5);

  thread scripts\cp_mp\gestures::_id_13E1A();
}

spawnintermission(var_0, var_1) {
  scripts\mp\playerlogic::setspawnvariables();
  self freezecontrols(1);
  scripts\mp\utility\player::updatesessionstate("_encstr_A3BC0D2DB544180EEAE7AFB7FF9258");
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  self spawn(var_0, var_1);
  scripts\mp\utility\player::_id_12898("_encstr_AF1C34E3F9AF8B7D8080DD27D8F0DA777E592F4755D38224106B55ACB358C17A58019692B35FBECB19B547E6AF19313130AB3E0E1907" + var_0);
  scripts\mp\utility\player::setdof_spectator();
}

emp_drone_proximity_explode(var_0) {
  if(!isDefined(self._id_1286F) || self calloutmarkerping_getEnt()) {
    if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
      self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);

    return;
  }

  thread emp_drone_should_take_damage();

  if(!isDefined(self.thrust_fx_model)) {
    var_1 = self._id_1286F.origin;
    var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B8(var_1);
    var_3 = getdvarint("_encstr_A98E20C8132B69065B488CA6C807FF0FC5772273063B6A6F107F0D17D7C8643F02E3", 9000);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_2, var_3, 1);

    if(!istrue(level._id_14623) && !istrue(self._id_14623)) {
      ending_fade_in();
      self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 4);
    }

    wait 0.5;
    spawnintermission(var_2, self._id_1286F.angles);
    scripts\mp\spectating::setdisabled();
  } else
    self.thrust_fx_model = undefined;

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  self freezecontrols(0);
}

emp_drone_should_take_damage() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
  self clearpredictedstreampos();

  if(!istrue(level._id_14623))
    self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);

  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
}

brprematchaddkill() {
  self.kills++;
}

eliminate_drone_attack_max_cooldown(var_0) {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    self.pers["_encstr_B2BE0788BAF573592F"] = self.pers["_encstr_B2BE0788BAF573592F"] + var_0;
}

difficulty_think() {
  foreach(var_1 in level.players) {
    var_1.kills = 0;
    var_1.pers["_encstr_8E8D0697EB01F243"] = 0;
    var_1.score = 0;
    var_1.pers["_encstr_82FB06EB26785BD7"] = 0;
    var_1.egress_landlord_vo = 0;
    var_1.pers["_encstr_A77D0ABAF0559B4B51C6041B"] = 0;
    var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_8AD9126BA5B96ED2B7E6DC68B7ADC1D82B47AC32", 0);
    var_1.pers["_encstr_B2BE0788BAF573592F"] = 0;
    var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A7B10CF1BFEA8F782D5FF9717D04", 0);
  }
}

difficulty_update_time(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, "_encstr_B16705D9AFE22E");
  var_2 = 0;
  var_3 = isDefined(var_0) && isint(var_0);

  foreach(var_5 in var_1) {
    if(!var_5 scriptabledoorisclosed()) {
      var_5 vehicle_getinputvalue();

      if(var_3) {
        var_2++;

        if(var_2 >= var_0) {
          var_2 = 0;
          waitframe();
        }
      }
    }
  }
}

_id_126EB(var_0) {
  var_1 = spawnStruct();
  thread _id_143F1(var_1);
  thread _id_143FC(var_1, var_0);
  var_1 waittill("_encstr_9B620E9F2BA0F3234370C2F91B2697EE");
  return var_1.result;
}

_id_143F1(var_0) {
  var_0 endon("_encstr_9B620E9F2BA0F3234370C2F91B2697EE");
  self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2);
  var_0.result = [var_1, var_2];
  var_0 notify("_encstr_9B620E9F2BA0F3234370C2F91B2697EE");
}

_id_143FC(var_0, var_1) {
  var_0 endon("_encstr_9B620E9F2BA0F3234370C2F91B2697EE");
  wait(var_1);
  var_0 notify("_encstr_9B620E9F2BA0F3234370C2F91B2697EE");
}

playerselectspawnclass() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self endon("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082");

  if(getdvarint("_encstr_AF121CB812BA97E18F4A8EF50FD749B7A9BB088049162378BB530DFF0B2F", 0) == 1 && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9936086E0BB9324CDBC3" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
    var_0 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
    scripts\mp\utility\script::laststand_dogtags("_encstr_B2FA1AD269822B0F8387FDAAB997A3A603E9C778CF12822E8F9B7190" + self.name + "_encstr_862F2E56E5B3910763D0DF3FF8FBFF7A73F08BEE69493F1C4150C33BD8539B32D39692BEBB6F429BB171BF2BA0E12D3E" + var_0);
  }

  self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
  var_1 = "_encstr_A70708DF6DCAB0B8BF17";
  self.pers["_encstr_959506B911C79707"] = var_1;
  self.class = var_1;
  scripts\mp\class::preloadandqueueclass(var_1);
  var_2 = getdvarfloat("_encstr_848614D7DF2EE17498E8E26EC1D8878B0B6B372F6B55", 10.0);
  var_3 = 0.0;
  var_4 = var_2 > 0.0;

  for(;;) {
    var_5 = undefined;
    var_6 = undefined;

    if(var_4) {
      var_7 = _id_126EB(1.0);

      if(!isDefined(var_7)) {
        var_3 = var_3 + 1.0;

        if(var_3 > var_2) {
          self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);
          return 0;
        }

        self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
        continue;
      }

      var_5 = var_7[0];
      var_6 = var_7[1];
    } else
      self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_5, var_6);

    if(var_5 == "_encstr_839D11A7C19B6B7740F04E17E8508411E60B27")
      return 0;
    else if(var_5 != "_encstr_A5EF0DF98DF99B2651677B6157FAED") {
      continue;
    }
    var_8 = 0;

    if(var_6 >= 0) {
      var_9 = scripts\mp\menus::getclasschoice(var_6);
      self.pers["_encstr_959506B911C79707"] = var_9;
      self.class = var_9;
      scripts\mp\class::preloadandqueueclass(var_9);
      var_8 = 1;
    }

    self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);
    return var_8;
  }
}

playerselectspawnsequence() {
  var_0 = self;
  var_0.issquadleader = undefined;
  var_0.br_infilstarted = 0;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::emptyallvehicles();
  var_1 = 1.0;
  var_2 = _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::getspawnselectionlockedtimer();
  var_3 = getdvarint("_encstr_ADB8133F57FB70F09A3958D11B73588873E78BABBB", 25);
  var_4 = var_2 + 0.5 + var_3;
  var_0 thread _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::infilallfadetoblack(var_1, var_4, 1);
  wait(var_1);
  var_0 freezecontrols(1);
  var_0 thread monitorjumpmasterclaim();

  if(disable_flag())
    var_0 playerselectspawnclass();

  var_0 playerselectspawnlocation();
  var_0 setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);
  var_0 freezecontrols(0);
}

playerstartselectspawnclassnonexclusion() {
  var_0 = self;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 freezecontrols(1);

  if(disable_flag())
    var_0 playerselectspawnclass();

  var_0 setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);
  var_0 freezecontrols(0);
}

playerselectspawnlocation() {
  var_0 = self;
  var_0 beginlocationselection(0, 0, 0, 0, 4);

  while(!scripts\mp\flags::gameflag("_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082")) {
    var_1 = waittill_confirm_or_cancel("_encstr_9625158FE84AC7F872D057ACC7D769D30B45D861B16C30", "_encstr_91A21017B155D07573493840921FB5C8AD06");

    if(!isDefined(var_1) || var_1.string == "_encstr_91A21017B155D07573493840921FB5C8AD06") {
      continue;
    }
    waittillframeend;
    _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::handleinfillocationselection(var_1);
    waitframe();
  }

  var_0 endlocationselection();
}

monitorjumpmasterclaim() {
  var_0 = self;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 thread listenforjumpmasterclaimluanotify();
  var_1 = 0;

  while(!scripts\mp\flags::gameflag("_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082")) {
    var_2 = var_0 scripts\engine\utility::waittill_any_ents_return(var_0, "_encstr_88101979A4553DF370E39F5CDD4748ADAB8258EF48FFAB100268A8", var_0, "_encstr_AD31199B8BAE16197DD4BAB583D658B9A3B2E4EBC663165A6B5946", level, "_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082");

    if(var_2 == "_encstr_88101979A4553DF370E39F5CDD4748ADAB8258EF48FFAB100268A8") {
      if(!var_1) {
        var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A97810F553CDD025BAAB13DF566F519130B1", 2);
        var_0.issquadleader = 1;
        var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(48);
        var_3 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

        foreach(var_5 in var_3) {
          if(var_5 != var_0) {
            var_5.issquadleader = 0;
            var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A97810F553CDD025BAAB13DF566F519130B1", 0);
            var_5 notify("_encstr_AD31199B8BAE16197DD4BAB583D658B9A3B2E4EBC663165A6B5946");
            var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(49);
          }
        }
      } else {
        var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A97810F553CDD025BAAB13DF566F519130B1", 1);
        var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(53);
      }

      continue;
    }

    if(var_2 == "_encstr_AD31199B8BAE16197DD4BAB583D658B9A3B2E4EBC663165A6B5946")
      var_1 = 1;
  }
}

listenforjumpmasterclaimluanotify() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_8601164BB0937452D5AE0D4693EB983DF8E04707082BDDEB");
  var_0 endon("_encstr_8601164BB0937452D5AE0D4693EB983DF8E04707082BDDEB");
  level endon("_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082");

  for(;;) {
    var_0 waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1);

    if(var_1 == "_encstr_88101979A4553DF370E39F5CDD4748ADAB8258EF48FFAB100268A8")
      var_0 notify("_encstr_88101979A4553DF370E39F5CDD4748ADAB8258EF48FFAB100268A8");
  }
}

sendafksquadmembertogulag() {
  var_0 = self;
  var_0.br_infilstarted = 1;
  var_0 setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
  var_0 setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
  var_0 playershow(1);
  var_0 kill();
}

defend_wave_2() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setclientomnvar("_encstr_B21F18BA4B7DC439D78C96E6381BC297FA0E954EAD7D967366DE", 1);
  wait 0.1;
  self setclientomnvar("_encstr_B21F18BA4B7DC439D78C96E6381BC297FA0E954EAD7D967366DE", 0);
}

delay_delete_reinforcement_called_icon(var_0, var_1, var_2) {
  var_0.gettingloadout = 1;
  var_3 = undefined;

  if(isDefined(var_0.preloadedclassstruct)) {
    var_3 = var_0.preloadedclassstruct;
    var_0.preloadedclassstruct = undefined;
  } else {
    var_3 = var_0 scripts\mp\class::loadout_getclassstruct();
    var_3 = var_0 scripts\mp\class::loadout_updateclass(var_3, var_0.class);
  }

  var_0.classstruct = var_3;
  var_4 = istrue(var_0.inlaststand);
  var_5 = defaultbreakeraction(var_0, var_1, var_2);
  var_0.prevweaponobj = undefined;
  var_0 scripts\mp\class::loadout_clearperks(1);
  var_0 scripts\mp\class::loadout_updateplayerperks(var_3);
  scriptednode(var_0);

  if(isDefined(var_0.classstruct.loadoutsecondaryobject))
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_forcegivecustomweapon(var_0, var_0.classstruct.loadoutsecondaryobject, var_0.classstruct.loadoutsecondaryfullname, var_0.classstruct.loadoutsecondary);

  if(isDefined(var_0.classstruct.loadoutprimaryobject))
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_forcegivecustomweapon(var_0, var_0.classstruct.loadoutprimaryobject, var_0.classstruct.loadoutprimaryfullname, var_0.classstruct.loadoutprimary);

  var_6 = [];

  if(isDefined(var_0.classstruct.loadoutequipmentprimary))
    var_6[var_6.size] = var_0.classstruct.loadoutequipmentprimary;

  if(isDefined(var_0.classstruct.loadoutequipmentsecondary))
    var_6[var_6.size] = var_0.classstruct.loadoutequipmentsecondary;

  foreach(var_8 in var_6) {
    if(isDefined(level.br_pickups.br_equipnametoscriptable[var_8])) {
      var_9 = level.br_pickups.br_equipnametoscriptable[var_8];
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_0, var_9, 1);

      if(isDefined(var_5.nvgwatcher) && var_5.nvgwatcher.type == var_9)
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::lootused(var_5.nvgwatcher, undefined, "_encstr_BE8B08E323FB2BCD6268", var_0, 1);
      else if(isDefined(var_5.nvidiaansel_allowduringcinematic) && var_5.nvidiaansel_allowduringcinematic.type == var_9)
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::lootused(var_5.nvidiaansel_allowduringcinematic, undefined, "_encstr_BE8B08E323FB2BCD6268", var_0, 1);
    }
  }

  var_0.gettingloadout = 0;
  var_0 notify("_encstr_B2030CA0C91D2F44C0B314F8836B");
  var_0 thread defend_wave_2();

  if(var_4) {
    var_11 = var_0 getcurrentprimaryweapon();

    if(!issameweapon(var_11))
      var_11 = getcompleteweaponname(var_11);

    self.laststandoldweaponobj = var_11;
    var_12 = var_0 brchooselaststandweapon();

    if(!issameweapon(var_12))
      var_12 = getcompleteweaponname(var_12);

    var_0 scripts\mp\laststand::givelaststandweapon(var_12);

    if(!var_0 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
      var_0 scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
  }
}

defaultbreakeraction(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.ml_p3_to_safehouse_transition = 0;
  var_3._id_14598 = [];
  var_3.nvgwatcher = undefined;
  var_3.nvidiaansel_allowduringcinematic = undefined;

  if(istrue(var_2)) {
    var_3.ml_p3_to_safehouse_transition = int(6.5);

    if(getdvarint("_encstr_8FBA193B61366F8E889F4C42E7C0DECF535862D22D0307C3F8D554", 0))
      var_3.ml_p3_to_safehouse_transition = var_3.ml_p3_to_safehouse_transition + 14;
  }

  foreach(var_5 in var_0.equippedweapons) {
    var_6 = scripts\mp\utility\weapon::getweaponrootname(var_5.basename);

    if(issameweapon(var_5) && var_5.inventorytype == "_encstr_BA7F0830B3A7859B60B0") {
      if(var_6 != "_encstr_A7ED0AD79F73990E28334B92" && var_6 != "_encstr_82200E7710825F228B4362D2DBEB8E1A") {
        var_7 = var_0 _encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::operatorsfxalias(var_5);

        if(istrue(var_1) && !var_7) {
          var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_3, var_0.origin, var_0.angles, var_0);
          var_9 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::weaponspawn(var_5, var_0, var_8, 0, 1);

          if(isDefined(var_9)) {
            var_10 = var_0 getweaponammoclip(var_5);
            var_11 = var_0 getweaponammoclip(var_5, "_encstr_A5AD056A019C63");
            var_12 = 0;

            if(var_5.hasalternate) {
              var_13 = var_5 getaltweapon();

              if(!_encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::debug_spawn_crate_on_train(var_5, var_13))
                var_12 = var_0 getweaponammoclip(var_13);
            }

            _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_119F5(var_9, var_10, var_11, var_12);
            var_3._id_14598[var_3._id_14598.size] = var_9;
          }
        }
      }

      var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_5);
    }
  }

  if(isDefined(var_0.equipment["_encstr_BA7F0830B3A7859B60B0"])) {
    if(istrue(var_1)) {
      var_15 = var_0 scripts\mp\equipment::getequipmentslotammo("_encstr_BA7F0830B3A7859B60B0");
      var_16 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, var_0.equipment["_encstr_BA7F0830B3A7859B60B0"]);

      if(isDefined(var_16) && var_15 > 0) {
        var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_3, var_0.origin, var_0.angles, var_0);
        var_9 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_16, var_8, var_15, 1);

        if(isDefined(var_9))
          var_3.nvgwatcher = var_9;
      }
    }

    var_0 scripts\mp\equipment::takeequipment("_encstr_BA7F0830B3A7859B60B0");
  }

  if(isDefined(var_0.equipment["_encstr_AC8F0AE74163F85AAA380AD8"])) {
    if(istrue(var_1)) {
      var_15 = var_0 scripts\mp\equipment::getequipmentslotammo("_encstr_AC8F0AE74163F85AAA380AD8");
      var_16 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, var_0.equipment["_encstr_AC8F0AE74163F85AAA380AD8"]);

      if(isDefined(var_16) && var_15 > 0) {
        var_8 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_3, var_0.origin, var_0.angles, var_0);
        var_9 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_16, var_8, var_15, 1);

        if(isDefined(var_9)) {
          var_3.nvidiaansel_allowduringcinematic = var_9;
          var_9 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::modeloadoutupdateammo(var_0, var_9.type);
        }
      }
    }

    var_0 scripts\mp\equipment::takeequipment("_encstr_AC8F0AE74163F85AAA380AD8");
  }

  var_0 giveweapon(getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"));
  return var_3;
}

deleteobjective() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self freezecontrols(1);
  self setclientomnvar("_encstr_8C0314EA4BBEB7C1CA377D36B7C223DB5D8EBE3185CE", 1);
  var_0 = playerselectspawnclass();
  self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);
  self setclientomnvar("_encstr_8C0314EA4BBEB7C1CA377D36B7C223DB5D8EBE3185CE", 0);
  self freezecontrols(0);
  return var_0;
}

br_givedropbagloadout(var_0) {
  if(istrue(self.tracking_max_health))
    var_0 notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

  var_1 = var_0 deleteobjective();

  if(istrue(var_1))
    scripts\cp_mp\killstreaks\airdrop::dropspecialistbonus(var_0);
  else
    return;

  delay_delete_reinforcement_called_icon(var_0, 1, 1);
  var_2 = scripts\engine\utility::ter_op(isstartstr(var_0.class, "_encstr_BD34078D57B9A37BD6"), 1, 0);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12053(var_2);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    var_3 = self.origin;
    var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
    wait 0.5;
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroy_intro_tank(var_0, var_3, self);
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyscorelaunchonly(var_0, "_encstr_84510D999BA26F4801BF86DBA2EDB0");

    if(isDefined(var_0.primaryweaponobj))
      var_0.primaryweaponobj.customweaponname = createheadicon(var_0.primaryweaponobj);

    if(isDefined(var_0.secondaryweaponobj))
      var_0.secondaryweaponobj.customweaponname = createheadicon(var_0.secondaryweaponobj);
  }
}

eliminate_drone_attack_min_cooldown(var_0) {
  level notify("_encstr_AAA5161B1860E0B25B2C717403190A8789F8B3A3589B3CA9" + self.origin);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroy_bad_traversals(self.team, self.origin);
}

cleanupdropbagsoncircle() {
  if(!getdvarint("_encstr_A7B629FBA1F6AF4E485F8B9C330895CF1FDE0273884FF706B80793A7CF5891FBCBD38B9B16AEE7FA9069BD", 0)) {
    return;
  }
  level waittill("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD");

  while(level.br_pickups.crates.size > 0) {
    var_0 = [];

    foreach(var_2 in level.br_pickups.crates) {
      if(isDefined(var_2) && (!isDefined(var_2.curprogress) || var_2.curprogress == 0)) {
        var_2 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        continue;
      }

      var_0[var_0.size] = var_2;
    }

    level.br_pickups.crates = var_0;
    var_0 = undefined;
    wait 1.0;
  }
}

brchooselaststandweapon() {
  var_0 = self;
  var_1 = var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12570();

  if(!isDefined(var_1))
    var_1 = "_encstr_9A0D0C4B54606F8F63C84B8B53EE";

  return var_1;
}

_id_12551(var_0) {
  _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_A5510A30AA778D28B3C97D51");
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12551(var_0);
}

_id_11C6F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_2, var_4, var_3, var_0, undefined, var_5);
  var_9.hitloc = var_6;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_96A011C6169BE89A8E16CD8CA0C663F6DDB219") && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_96A011C6169BE89A8E16CD8CA0C663F6DDB219", var_9))
    return 0;

  return 1;
}

vandalize_internal(var_0) {
  var_1 = var_0.attacker;

  if(!isDefined(var_1))
    return 0;

  if(istrue(var_0.assistedsuicide))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    return 0;

  return 1;
}

enemy_mines_init(var_0) {
  if(!vandalize_internal(var_0))
    var_0.dokillcam = 0;

  if(!var_0.dokillcam)
    var_0.victim clearpredictedstreampos();

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_838F0D8DEFA26BC7D83780300FF4D9"))
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_11BE2(var_0.victim, var_0.attacker, 1);
}

tvstation_fastrope_init(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0))
    return 0;

  if(istrue(var_0.gulag))
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  return 1;
}

rpg_think(var_0) {
  var_1 = [];
  var_2 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  foreach(var_4 in var_2) {
    if(tvstation_fastrope_init(var_4))
      var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_12046(var_0, var_1) {
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_12570();

  if(tvstation_fastrope_init(var_1) && !isDefined(var_2)) {
    var_3 = rpg_think(var_1.team);

    if(var_3.size < 2 && !istrue(level.watch_for_icbm_spawners)) {
      if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
        var_1 scripts\mp\utility\perk::removeperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
    }

    if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A7B606DA83796F4A"))
      var_1 _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::disable_map_ammo_munitions();
  }
}

emp_drone_pick_up_use_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1) && var_1 != var_2 && var_3 >= var_2.health)
    _id_12046(var_1, var_2);
}

disableallarmorykiosks(var_0) {
  switch (var_0) {
    case "_encstr_8DDE08CDF61D434BB9B3":
      return 0;
    case "_encstr_88A90755CDDE9A2B88":
      return 1;
    case "_encstr_82650C635AB62D47598CC2DAADDE":
      return 2;
    case "_encstr_A11C0DE6A3B0734658278C2CADD6DE":
      return 3;
    case "_encstr_BDC6085DF29A892901C7":
      return 4;
    case "_encstr_AD850C1F4358330956CFABB88BBA":
      return 5;
    case "_encstr_8862174B4BAF5BFFB0874245A85B9B622F60F2D28849D4CFC9":
      return 6;
    case "_encstr_91A50C31B912687073AAFBAD5253":
      return 7;
    case "_encstr_9B94112C8D476B7B9156CEBDB1912BCDECBACD":
      return 8;
    default:
      return 0;
  }
}

disabledfeatures() {
  var_0 = "_encstr_8862174B4BAF5BFFB0874245A85B9B622F60F2D28849D4CFC9";
  var_1 = getDvar("_encstr_A14816336A93F840D21799E7513F60B5D30108DB831728F8", var_0);
  var_2 = disableallarmorykiosks(var_1);
  level.delay_put_players_in_black_screen = var_2;
}

disable_flag() {
  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 1 || level.delay_put_players_in_black_screen == 2 || level.delay_put_players_in_black_screen == 3);
}

disable_fulton_group_interactions() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_8C100FC793A0BFF07F07F30773956AE520"))
    return 0;

  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 4 || level.delay_put_players_in_black_screen == 5 || level.delay_put_players_in_black_screen == 6);
}

dialog_mount_nag_watcher() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_8C100FC793A0BFF07F07F30773956AE520"))
    return 0;

  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 5 || level.delay_put_players_in_black_screen == 6);
}

disable_weapon_swap_until_swap_finished() {
  var_0 = [];

  if(!isDefined(level.br_level)) {
    var_0[var_0.size] = 1;
    return var_0;
  }

  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::reinforcement_manager("_encstr_B8CB0D83F5B80B4A0811E7B768D0A9");

  if(isDefined(var_1)) {
    var_0[var_0.size] = var_1;
    return var_0;
  }

  var_2 = -15;
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::relic_amped_pick_random_valid_player(0);
  var_4 = max(0, var_3 + var_2);
  var_5 = getdvarfloat("_encstr_B2F7151277B34913839FFC4BF8B161BF5FD7E12091C203", var_4);

  if(var_5 < 0)
    var_5 = var_4;

  var_0[var_0.size] = var_5;

  if(getdvarint("_encstr_B84D18676F9E51C2087E971A90F00A4AFC254FB7CD4FCAB4E821", 0) && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_BA430C806BCF931D8257A1C8AD6B")) {
    var_6 = 15;
    var_7 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::run_hud_logic();
    var_8 = max(0, var_7 + var_6);
    var_9 = getdvarfloat("_encstr_B65A169BC639AF314EBE194EDB1C4C0BCEC8EB23561BC2CB", var_8);
    var_0[var_0.size] = var_9;
  }

  return var_0;
}

disable_collect_leads() {
  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 6 || level.delay_put_players_in_black_screen == 7 || level.delay_put_players_in_black_screen == 8);
}

disablealltablets() {
  switch (level.delay_put_players_in_black_screen) {
    case 8:
    case 7:
    case 6:
      return 0;
    default:
  }
}

disable_cinematic_skip() {
  return isDefined(level.delay_put_players_in_black_screen) && (level.delay_put_players_in_black_screen == 1 || level.delay_put_players_in_black_screen == 2 || level.delay_put_players_in_black_screen == 3);
}

disable_usability_for_duration() {
  if(isDefined(level.delay_put_players_in_black_screen)) {
    if(level.delay_put_players_in_black_screen == 2)
      return 0.5;
    else if(level.delay_put_players_in_black_screen == 3)
      return 1.0;
  }

  return 0.0;
}

disable_timer() {
  if(isDefined(level.delay_put_players_in_black_screen)) {
    if(level.delay_put_players_in_black_screen == 2)
      return 20;
  }

  return;
}

_id_125FC() {
  var_0 = spawnStruct();
  var_0._id_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename))
      var_1[var_1.size] = var_4;
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);
    var_0.brtdm_config[var_8] = weaponclipsize(var_7);
    var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7))
      var_0.brtruck_cleanupents[var_8] = self getweaponammoclip(var_7, "_encstr_A5AD056A019C63");

    if(getsubstr(var_8, 0, 4) == "_encstr_9B83050BD88EF5") {
      continue;
    }
    var_0._id_12889[var_0._id_12889.size] = var_7;
  }

  if(self.lastcacweaponobj != getcompleteweaponname("_encstr_8BBA05185F8B99")) {
    foreach(var_4 in var_0._id_12889) {
      if(self.lastcacweaponobj == var_4) {
        var_0.current = self.lastcacweaponobj;
        break;
      }
    }
  }

  var_12 = self getweaponslistoffhands();

  foreach(var_14 in var_12) {
    if(var_14.basename == "_encstr_A51B0B2BD260444AAFCD6F86E2") {
      continue;
    }
    var_15 = self getweaponammoclip(var_14);

    if(var_15 <= 0) {
      continue;
    }
    var_0.offhands[var_0.offhands.size] = var_14;
    var_16 = createheadicon(var_14);
    var_0.brtdm_config[var_16] = var_15;
  }

  foreach(var_20, var_19 in self.equipment)
  var_0.nvidiaansel_overridecollisionradius[var_19] = var_20;

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent)
    var_0.super = self.equipment["_encstr_BEB406F03B72BB3B"];

  self._id_12EB0 = var_0;
}

_id_125FB() {
  self takeallweapons(0, 1);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  self.equipment["_encstr_BA7F0830B3A7859B60B0"] = undefined;
  self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"] = undefined;
  self.equipment["_encstr_91B50734CA58631D1A"] = undefined;
  self.equipment["_encstr_BEB406F03B72BB3B"] = undefined;
  var_0 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");

  if(self._id_12EB0._id_12889.size < 2)
    self giveweapon(var_0);

  var_1 = 0;

  foreach(var_3 in self._id_12EB0._id_12889) {
    var_4 = createheadicon(var_3);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);

    if(!var_1) {
      self assignweaponprimaryslot(var_4);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
      var_1 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var_4);
  }

  foreach(var_7 in self._id_12EB0.offhands) {
    var_8 = scripts\mp\equipment::getequipmentreffromweapon(var_7);

    if(!isDefined(var_8)) {
      continue;
    }
    var_9 = self._id_12EB0.nvidiaansel_overridecollisionradius[var_8];

    if(!isDefined(var_9)) {
      continue;
    }
    scripts\mp\equipment::giveequipment(var_8, var_9);
  }

  foreach(var_4, var_12 in self._id_12EB0.brtruck_ontimelimit) {
    self setweaponammostock(var_4, var_12);
    var_3 = getcompleteweaponname(getweaponbasename(var_4));
    var_13 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_3);

    if(isDefined(var_13)) {
      self.br_ammo[var_13] = var_12;
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_hud_update_ammotype(var_13);
    }
  }

  foreach(var_4, var_12 in self._id_12EB0.brtdm_config)
  self setweaponammoclip(var_4, var_12);

  foreach(var_4, var_12 in self._id_12EB0.brtruck_cleanupents)
  self setweaponammoclip(var_4, var_12, "_encstr_A5AD056A019C63");

  waitframe();
  var_16 = var_0;

  if(isDefined(self._id_12EB0.current))
    var_16 = self._id_12EB0.current;
  else if(isDefined(self._id_12EB0._id_12889[0]))
    var_16 = self._id_12EB0._id_12889[0];

  self switchtoweaponimmediate(var_16);

  if(isDefined(self._id_12EB0.super)) {
    var_17 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self._id_12EB0.super]];
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper(var_17, 0);
  }

  thread scripts\cp_mp\gestures::_id_13E1A();
  self._id_12EB0 = undefined;
}

ending_player_disconnect_thread() {
  foreach(var_1 in level.players) {
    if(isPlayer(var_1) && var_1 scripts\mp\utility\player::isinkillcam()) {
      var_1 notify("_encstr_B6730EE73AE71389B1DA381842565B08");
      var_1.cancelkillcam = 1;
    }
  }
}

disabled_seats_for_vehicle(var_0) {
  var_1 = getdvarint("_encstr_AB851CDCC64EEB264EF5A5379D5DB1DCCA930B8996364BD1CBF53A4BB62B", 30);

  if(var_1 > var_0)
    var_1 = var_0;

  wait(var_0 - var_1);
  level.allowprematchdamage = 0;
  wait(var_1 / 2.0);
  ending_player_disconnect_thread();
  wait(var_1 / 2.0);
}

_id_11B81() {
  var_0 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_B62A09E34FB8BF309F3F63");

  if(isDefined(var_0))
    return var_0;

  return scripts\mp\playerlogic::mayspawn();
}

spawnclientbr(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_13B4F = undefined;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::iswaitingtoentergulag(self)) {
    self notify("_encstr_976B10EF14B3C9B3723350A0794A418167A6");
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::entergulag(self);
    self.waitingtospawn = 0;
  } else if(istrue(self.waitingtospawnamortize) || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::use_csm(self) || istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8EC10D5F713FFBE6C151ED77E87034", self))) {
    self notify("_encstr_976B10EF14B3C9B3723350A0794A418167A6");
    self.waitingtospawn = 0;
  } else if(!_id_11B81()) {
    waitframe();
    self notify("_encstr_976B10EF14B3C9B3723350A0794A418167A6");

    if(istrue(level.stop_visited_once) || istrue(level.snatchspawnalltoc130done) || istrue(level.debugnextpropindex)) {
      if(isDefined(level.brlatespawnplayer))
        self thread[[level.brlatespawnplayer]]();

      return;
    }
  } else {
    if(istrue(var_0))
      level.snatchspawnalltoc130done = 0;

    if(istrue(level.stop_visited_once) || istrue(level.snatchspawnalltoc130done) || istrue(level.debugnextpropindex)) {
      if(isDefined(level.brlatespawnplayer))
        self thread[[level.brlatespawnplayer]]();

      return;
    }

    if(!istrue(level.debug_safehouse_regroup_start)) {
      if(isDefined(level.bypassclasschoicefunc))
        self.class = self[[level.bypassclasschoicefunc]]();
      else
        self.class = _id_12341();
    }

    if(getdvarint("_encstr_B67720EE3B93B6A5FA99C050A3D4558ACFB0F66D9D879BEF24A108F88AAF0F43DB5B", 0) == 1)
      thread _id_14290();

    var_1 = getdvarint("_encstr_854E152646BB27D9E2F7A0E8CF18B6B1636F9E2F5E833D", 1);
    var_2 = var_1 && _id_14070() && !isbot(self);

    if(var_1 > 1)
      var_2 = var_2 && !istrue(self.hasspawned);

    if(var_2)
      self._id_1286F = getspawnpoint(var_2);

    scripts\mp\playerlogic::waitandspawnclient(var_0);
    self freezecontrols(1);

    if(_id_14070())
      thread prematchdeployparachute();

    waitframe();
    self skydive_setdeploymentstatus(0);
    self skydive_setbasejumpingstatus(0);
    var_3 = !self calloutmarkerping_getEnt();
    var_4 = scripts\mp\teams::getcustomization()["_encstr_AD9B0589ED9197"];
    var_5 = gettime();

    if(var_3) {
      while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedcustomizationviewmodels(var_4) && !self hasloadedviewweapons(self.weaponlist)) {
        if(var_5 + 3000 < gettime()) {
          break;
        }

        waitframe();
      }
    }

    self notify("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
    self.waitingtospawn = 0;
    self freezecontrols(0);
  }
}

didgasmaskpipschange(var_0, var_1, var_2) {
  var_3 = 360 / var_0.size;
  var_4 = getdvarint("_encstr_847824A0B74ADEF50BF1238FDD031F25896BC8D0AFF933AF92670EBFEF4A2BCBC7F378B09F9C", 10000);
  var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_6 = 0;

  if(isDefined(var_2))
    var_6 = var_2;
  else
    var_6 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius() - var_4;

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_8 = var_6 * cos(var_3 * var_7);
    var_9 = var_6 * sin(var_3 * var_7);
    var_10 = var_5[0] + var_8;
    var_11 = var_5[1] + var_9;
    var_12 = 0;
    var_13 = (var_10, var_11, var_12);

    if(var_1) {
      foreach(var_15 in var_0)
      var_15.emp_target_list = var_13;

      continue;
    }

    var_0[var_7].emp_target_list = var_13;
  }
}

_id_1254D() {
  if(scripts\cp_mp\execution::hasexecution()) {
    self._id_12EAE = self.executionref;
    scripts\cp_mp\execution::_clearexecution();
    self disableexecutionattack();
  }
}

_id_1254E() {
  if(isDefined(self._id_12EAE)) {
    scripts\cp_mp\execution::_giveexecution(self._id_12EAE);
    self enableexecutionattack();
    self._id_12EAE = undefined;
  }
}

_id_144AE() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_BEB416784BB9975BAFE1B520F43781719FF31968824CE5B3");
  self endon("_encstr_BEB416784BB9975BAFE1B520F43781719FF31968824CE5B3");
  var_0 = self;
  var_1 = var_0.team;
  var_2 = var_0.squadindex;
  var_3 = scripts\mp\utility\game::round_vehicle_logic();

  for(;;) {
    var_4 = "_encstr_B40101";

    if(var_3 == "_encstr_BE180419DAE9" || var_3 == "_encstr_8AE1099A0B999F2D28AF15" || var_3 == "_encstr_9936086E0BB9324CDBC3" || var_3 == "_encstr_9B1F05BE4B9B52" || var_3 == "_encstr_816E079685517D0975" || var_3 == "_encstr_A1D0081CC297B1EDB08C" || var_3 == "_encstr_866209ECEDB1197DEE0B4E")
      var_4 = var_0 scripts\engine\utility::_id_143B4("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_9976159972471B737FD2196F7F10F9F020724249856DA2");
    else
      var_4 = var_0 scripts\engine\utility::_id_143B6("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_9AFB18534AAFA0A05757CD1D9FBD217F73226B3971FFE8E0AD54", "_encstr_9976159972471B737FD2196F7F10F9F020724249856DA2");

    if(var_4 == "_encstr_9976159972471B737FD2196F7F10F9F020724249856DA2") {
      if(!_id_13AAE(var_1)) {
        var_0 playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
        continue;
      }
    }

    if(var_4 != "_encstr_8D820B49520F0EC02DDE6367EC") {
      if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
        continue;
      }
      if(!istrue(var_0.br_infilstarted))
        continue;
    }

    if(var_0 arenastpday(var_1, var_2))
      return;
  }
}

_id_131A8(var_0) {
  var_1 = self;
  var_1.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] = var_0;
  var_2 = var_1.game_extrainfo & 65528;
  var_2 = var_2 | var_0;
  var_1.game_extrainfo = var_2;
}

_id_1319D(var_0) {
  var_1 = self;

  if(var_0 == var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath()) {
    return;
  }
  var_1.tutorial_usingparachute = var_0;

  if(var_0) {
    var_1.game_extrainfo = var_1.game_extrainfo | 64;
    var_1 thread _id_144AE();
  } else
    var_1.game_extrainfo = var_1.game_extrainfo &~64;
}

arenastpday(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_0))
    var_0 = var_2.team;

  if(!isDefined(var_1))
    var_1 = var_2.squadindex;

  if(isDefined(var_2) && !var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath())
    return 0;

  if(isDefined(var_2))
    var_2.should_update_track_timer = 1;

  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_2.squadindex);
  var_4 = 0;
  var_5 = undefined;

  foreach(var_7 in var_3) {
    var_8 = _id_12512(var_7);

    if(var_8 > var_4) {
      var_4 = var_8;
      var_5 = var_7;
    }
  }

  var_10 = 0;

  if(isDefined(var_5)) {
    if(isDefined(var_2))
      var_2 _id_1319D(0);

    var_5 _id_1319D(1);
    var_10 = 1;

    if(!istrue(level.debugnextpropindex))
      level _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_872514BBE31FE24FD0FED25A53F88C29F90B37335B46", var_5, 1, 0);
  }

  _id_1401E(var_0, var_1);
  return var_10;
}

_id_13AAE(var_0, var_1) {
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1);
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(!isDefined(var_5) || var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath()) {
      continue;
    }
    if(!isalive(var_5)) {
      continue;
    }
    if(var_5 ismlgspectator() || var_5 isspectatingplayer()) {
      continue;
    }
    if(var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
      continue;
    }
    if(!istrue(var_5.should_update_track_timer)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}

_id_1401E(var_0, var_1) {
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1);
  var_3 = _id_13AAE(var_0, var_1);

  foreach(var_5 in var_2)
  var_5 setclientomnvar("_encstr_BE091CA34BBF227AE688DFF720B91F8A93D76FDFAE178AB12801D3AFD833", var_3);
}

_id_12512(var_0) {
  if(!isDefined(var_0) || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath() || var_0 ismlgspectator() || var_0 isspectatingplayer() || !isalive(var_0))
    return 0;

  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
    return 1;

  if(istrue(var_0.inlaststand))
    return 2;

  if(istrue(var_0.should_update_track_timer))
    return 3;

  return 4;
}

_id_13AC7(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\utility\teams::getteamdata(var_2, "_encstr_9775086022BE1B413B8B");

  foreach(var_6 in var_4) {
    if(!istrue(var_6.gulag))
      var_6 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
  }
}

_id_131C8(var_0) {
  self.issuperdisabled = var_0;

  if(!var_0)
    new_agent_def_main();
  else {
    var_1 = scripts\mp\supers::getcurrentsuper();

    if(isDefined(var_1)) {
      var_2 = var_1.staticdata.weapon;
      var_3 = self getweaponammoclip(var_2);
      self.loadoutextraperksfromgamemode = var_3;
    }

    self notify("_encstr_AC6714F04BD3A3AA9F69945B4F6BD387404AD08F4333");
    thread scripts\mp\supers::watchsuperdisableplayer();
  }
}

new_agent_def_main() {
  var_0 = "_encstr_8AA60F93A370283EF983D3F9AFA3902028";
  var_1 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_1)) {
    var_2 = var_1.staticdata.weapon;
    var_3 = 0;

    if(isDefined(self.loadoutextraperksfromgamemode)) {
      var_3 = self.loadoutextraperksfromgamemode;
      self.loadoutextraperksfromgamemode = undefined;
    }

    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    self setweaponammoclip(var_2, var_3);
    self assignweaponoffhandspecial(var_2);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
  }

  self notify("_encstr_A62812B9BAE0CA937D8CB46EC231D856AFCA7323");
}

roundnumber() {
  if(!istrue(self.issuperdisabled))
    return 0;

  var_0 = 0;

  if(isDefined(self.loadoutextraperksfromgamemode))
    var_0 = self.loadoutextraperksfromgamemode;

  return var_0;
}

_id_12099(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
    if(!isDefined(var_1) || var_1.size == 0) {
      var_2 = var_0 getcurrentweapon();
      var_3 = var_0 getcurrentweaponclipammo();
      var_4 = weaponclipsize(var_2);

      if(var_3 < var_4) {
        var_0 setweaponammoclip(var_2, var_4);
        var_0 scripts\mp\damagefeedback::hudicontype("_encstr_97DB08C666DF7205C008");
        var_0 playlocalsound("_encstr_AFC214672FA349CB18A3BA45DB28DF52D0A937EFCFA5");
        return 1;
      }
    }
  }

  foreach(var_6 in var_1) {
    var_7 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_6);

    if(var_6.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_6.underbarrel) == "_encstr_BE9708CBAB13138857AD") {
      var_8 = weaponclipsize(var_6);
      var_9 = int(var_8);
      var_0 setweaponammoclip(var_6, var_9);
      var_6._id_12CC1 = 1;
      continue;
    } else if(scripts\mp\utility\weapon::update_health_on_spawn(var_6)) {
      var_0 setweaponammoclip(var_6, var_6.clipsize);
      var_6._id_12CC1 = 1;
      continue;
    } else if(!isDefined(var_7)) {
      continue;
    }
    var_10 = int(level.br_ammo_max[var_7] / level.br_ammo_clipsize[var_7]);
    var_0 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_delete_alerted_icon(var_6, var_10);
    var_6._id_12CC1 = 1;
  }

  if(isDefined(var_0.equipment["_encstr_BA7F0830B3A7859B60B0"]))
    var_0 scripts\mp\equipment::incrementequipmentammo(var_0.equipment["_encstr_BA7F0830B3A7859B60B0"], 2);

  if(isDefined(var_0.equipment["_encstr_AC8F0AE74163F85AAA380AD8"]))
    var_0 scripts\mp\equipment::incrementequipmentammo(var_0.equipment["_encstr_AC8F0AE74163F85AAA380AD8"], 2);

  var_0 scripts\mp\damagefeedback::hudicontype("_encstr_A60E08C1271BEF21A882");
  scripts\mp\equipment\support_box::_id_139AE(var_0);
  thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
  return 1;
}

_id_11FFE(var_0) {
  var_1 = var_0 scripts\mp\equipment::getequipmentmaxammo("_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D");

  if(var_1 <= 0)
    return 0;

  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(var_0, "_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69", 1, var_1, 0);
  var_0 scripts\mp\damagefeedback::hudicontype("_encstr_925809A3CD88325270F892");
  scripts\mp\equipment\support_box::_id_139AE(var_0);
  thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
  return 1;
}

airdrop_registercrateforcleanup(var_0) {
  registercrateforcleanup(var_0);
}

br_ammorestock_playeruse(var_0) {
  dropshield(var_0);
}

airdrop_makeweaponfromcrate() {
  makeweaponfromcrate();
}

airdrop_makeitemfromcrate() {
  makeitemfromcrate();
}

airdrop_makeitemsfromcrate(var_0) {
  makeitemsfromcrate(var_0);
}

airdrop_br_givedropbagloadout(var_0) {
  br_givedropbagloadout(var_0);
}

br_armor_repair_end(var_0) {
  eliminate_drone_attack_min_cooldown(var_0);
}

br_armor_plate_used(var_0) {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A9AA0E883DC1080E933F2903C3CADDF8", var_0);
}

_id_12082(var_0) {
  var_1 = var_0 getcurrentprimaryweapon();
  var_0 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_delete_alerted_icon(var_1);
  var_0 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(level._encstr_99DB1773C7089B9F38F94A03230197D578A30AE943D0E36BDD);
}

_id_1205C(var_0, var_1) {
  var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::setup_train_array(var_1, "_encstr_BA7F0830B3A7859B60B0");
}

_id_1203B(var_0, var_1) {
  switch (var_0) {
    case "_encstr_9A09125ABB07FA6657633AED73D79858ECBE5BC1":
      thread _debug_rooftopobjstart::playerwager(var_1);
      break;
    case "_encstr_8C0D0B025090B6A27D2DBF3355":
      thread _encstr_A31921E61B9CA583E86E5E5B1CCBAC5CAED2835B2B73D1CB9BB1B4CDB39539173B9B36::_encstr_A5900DC320094A0F5073D153EF3D63(var_1);
      break;
    case "_encstr_86B108781A36271E4F70":
      thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::rock_used(var_1);
      break;
    case "_encstr_AB0B08D8BD58B1EBB607":
      var_1 thread _encstr_8A0E28B7504BB4F9B39BBED567EE912625A1FB335B055A179923CEE1F028B188BD684DC6738BA6EC7FF3::airstrike_watchgameend();
      break;
    default:
      break;
  }

  if(var_0 == "_encstr_86B108781A36271E4F70" && istrue(self._id_13B4F)) {
    var_1 delete();
    self._id_13B4F = undefined;
  }
}

_id_120B0(var_0) {
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::takeweaponpickup(var_0);
}

_id_120AF(var_0) {
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
}

_id_12691() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_8449141CD8B0972B4EA986B7EA63194A956E830BEE9B"))
    return _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8449141CD8B0972B4EA986B7EA63194A956E830BEE9B");

  if(!istrue(level.br_prematchstarted))
    return 1;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::iswaitingtoentergulag(self))
    return 1;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::use_csm(self))
    return 1;

  return 0;
}

emp_drone_damage_monitor(var_0, var_1) {
  var_2 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8106123B24BF78D3DBDC083511D5719BA1AE6345", var_0, var_1);

  if(isDefined(var_2))
    return var_2;
  else if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_B18D0B5281530117EDEAC82033" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_816E079685517D0975" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E") {
    if(getdvarint("_encstr_937B16E66C4E7D89D6DED7ABE62BFA37C12CBBB9FA99D287", 1) == 1) {
      if(scripts\mp\utility\game::updatehistoryhud(self))
        return 1;

      if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
        return 0;

      if(istrue(var_0.victim.hasrespawntoken) || istrue(level._id_14062)) {
        if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
          if(isbot(var_0.victim))
            return 1;
        }

        if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15")
          var_0.victim thread _encstr_BA6F2E3318E5A43B7B56C78DEF285FEE73B0CBEBE8939A8E513EAFBF0F081F73A3B04201407393170BAF9BB5B0919FFE::playerrespawn();
        else
          var_0.victim thread _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::playerrespawn();

        var_3 = scripts\mp\utility\teams::getteamdata(var_0.victim.team, "_encstr_AB580A05672AE35D5FFF50B8");

        if(var_3 > 1)
          var_0.victim thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_0, var_1, 1);

        return 1;
      }
    } else {
      if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
        return 0;

      if(istrue(var_0.victim.hasrespawntoken) || istrue(level._id_14062)) {
        if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
          if(isbot(var_0.victim))
            return 1;
        } else if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
          var_0.victim thread scripts\mp\playerlogic::respawn_asspectator(var_0.victim.origin + (0, 0, 60), var_0.victim.angles);

        var_0.victim thread _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::playerrespawn();
        return 1;
      }
    }
  } else if(!_id_12691()) {
    if(!scripts\mp\utility\damage::playershoulddofauxdeath(0))
      var_0.victim thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_0, var_1);

    return 1;
  }

  return 0;
}

dyn_door(var_0) {
  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846", var_0);

  if(isDefined(var_1))
    return var_1;

  return dynamic_door(var_0);
}

dynamic_door(var_0) {
  var_1 = var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::trygulagspawn();

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && !var_1)
    _id_11B15(var_0, "_encstr_86EF132F7FA8ABF1B0211A6AF86019027EB1BF9FC1");

  return !var_1;
}

_id_13F24() {}

_id_11D22() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = gettime();

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
    var_1 = gettime();
    var_2 = var_1 - var_0;
    var_0 = var_1;

    if(_id_13301() && var_2 > 3000)
      thread searchradiusidealmax(var_2);

    var_3 = self.lastnormalweaponobj;

    if(isDefined(var_3)) {
      var_4 = int(var_2 / 1000);
      var_5 = getweaponvariantindex(var_3);
      var_6 = var_3.basename;

      if(getsubstr(var_6, 0, 4) == "_encstr_83C5052DBBC1FA" || getsubstr(var_6, 0, 3) == "_encstr_81190403FB70")
        var_6 = scripts\mp\utility\weapon::getweaponrootname(var_3);

      scripts\common\utility::_id_13E0A(level._id_11B31, var_6, "_encstr_B1680CF9B7C2A5E155FA81B9E93B", var_4, var_5, var_3);
    }
  }
}

_id_13301() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_99F811EE56851C7B9B61E0F49DCA4EA8B4DA2B"))
    return 0;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_99F811EE56851C7B9B61E0F49DCA4EA8B4DA2B"))
    return 1;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker() || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() || scripts\mp\utility\game::updatex1stashhud())
    return 0;

  return 1;
}

weaponshouldgetxp(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  return weaponhasranks(var_1);
}

weaponhasranks(var_0) {
  if(!isDefined(level.weaponranktable.maxweaponranks[var_0]))
    return 0;

  var_1 = level.weaponranktable.maxweaponranks[var_0] > 0;
  return var_1;
}

bush_zones() {
  var_0 = scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_B18D0B5281530117EDEAC82033" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E" || istrue(level.vehicle_collision_getleveldata) || isDefined(level._id_12D05) || isDefined(level._id_12CE8);

  if(var_0) {
    return;
  }
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_97D715AB703EF3ADD2C928B0BDD3459E8E130B36559856")) {
    return;
  }
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8B7A1187533F0D1369DFC88EF81BD79B148B8D");
  var_1 = scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8E8810DBD03DAC3B63D3BFAA7D0B2F3247B8";
  level _id_1269D(50, var_1);
  level _id_1269D(25, var_1);
  level _id_1269D(10, var_1);
  level _id_1269D(5, var_1);
}

_id_1269D(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = reinforcement_type();

  while(var_2.size > var_0) {
    level scripts\engine\utility::waittill_either("_encstr_834E15F643A97834B1675243A7D81DD4674B302AFB48A1", "_encstr_854F1AA7858A6B39E24779E8E7057183A26C10A4D1C231E1D63FA050");
    var_2 = reinforcement_type();

    if(var_2.size <= var_0) {
      var_3 = !istrue(level.usegulag) || istrue(level.gulag.shutdown);

      if(var_1 || var_3)
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B4EF05737FA769" + var_0, 0, undefined, 1);

      break;
    }
  }
}

reinforcement_type() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(istrue(var_2.delay_enter_combat_after_investigating_grenade)) {
      continue;
    }
    if(var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
      continue;
    }
    if(var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
      continue;
    }
    if(level.codcasterenabled) {
      if(var_2 ismlgspectator())
        continue;
    }

    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_12C6A(var_0) {
  if(isDefined(var_0.gulaguses) && var_0.gulaguses > 0) {
    return;
  }
  if(istrue(var_0.play_cinderblock_broken_fx) && !istrue(level._id_133BF)) {
    return;
  }
  var_1 = var_0 scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 0);
  var_0.pers["_encstr_A7350D98707F9B79A37F4B04F34D27"] = var_1;
  var_0.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"] = undefined;
  var_0.pers["_encstr_91FF1555B52BABE824FFC8E8134A01CD421D45D586A027"] = undefined;
  var_0 thread scripts\mp\playerlogic::totaldisttracking(var_0.origin, 1);
}

_id_12036(var_0) {
  _id_12C6A(var_0);

  if(isalive(var_0) && !istrue(var_0.inlaststand))
    var_0.elevator_manager = undefined;

  var_0 scripts\cp_mp\vehicles\vehicle_compass::fulton_initanims();
}

_id_1401F(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"])) {
    if(!isDefined(level.deletescriptableinstance))
      level.deletescriptableinstance = [];

    var_4 = get_int_or_0(level.deletescriptableinstance[var_0.team]);

    if(!isalive(var_0)) {
      var_3 = 1;
      var_2 = 0;
    }

    var_5 = var_0 == var_1;
    var_6 = var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"];
    var_7 = int(ceil(clamp(var_2, 0, 1) * 128));
    var_8 = var_7;

    if(istrue(var_3))
      var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_131A6(0);
    else if(var_5)
      var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_131A6(1);

    var_9 = var_6 * 8;
    var_10 = (var_8 & 255) << var_9;
    var_11 = ~(255 << var_9);
    var_12 = var_4 &var_11;
    var_13 = var_12 + var_10;
    level.deletescriptableinstance[var_0.team] = var_13;
    var_14 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

    if(isDefined(var_14) && var_14.size > 0) {
      foreach(var_16 in var_14)
      var_16 setclientomnvar("_encstr_91921A2B50D00B1A7177E9D56B906903652B6263B988F7536891E5DB", var_13);
    }
  }
}

forest_barrel_damage_watch(var_0) {
  var_1 = [0, 0, 0, 0];

  if(isDefined(var_0) && isDefined(var_0.ejectplayerfromturret)) {
    var_2 = 0;

    foreach(var_7, var_4 in var_0.ejectplayerfromturret) {
      var_5 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::getquesttableindex(var_7);
      var_6 = int(clamp(var_4, 0, 15)) << 4;
      var_1[var_2] = var_6 + var_5;
      var_2++;

      if(var_2 >= 4) {
        break;
      }
    }
  }

  var_8 = [];
  var_8[0] = (var_1[0] << 8) + var_1[1];
  var_8[1] = (var_1[2] << 8) + var_1[3];
  var_8[2] = get_int_or_0(var_0.defaultclassindex);
  var_9 = int(clamp(get_int_or_0(var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]) - 1, 0, 3));
  var_8[3] = var_9 << 14;
  var_8[3] = var_8[3] + get_int_or_0(var_0.pers["_encstr_B2BE0788BAF573592F"]);
  return var_8;
}

_id_12065() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.sessionteam == "_encstr_8BBA05185F8B99" || isDefined(self.thrust_fx_model) || self calloutmarkerping_getEnt())
    return 0;

  if(scripts\mp\menus::shouldmodesetsquads() && !isDefined(self.squadindex))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() && !isbot(self)) {
    self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 1);
    return 0;
  }

  if(!_id_14070())
    return 1;

  var_0 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_97AC148F3596E7DDA6E7381B21A33B2BC2474D5BC883");

  if(!isDefined(var_0))
    var_0 = getspawnpoint();

  self.thrust_fx_model = var_0;
  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_82E2179290C48043DF1D81FB571A085350687EB7B73007AFA3");

  if(isDefined(var_1))
    self.thrust_fx_model.origin = self.thrust_fx_model.origin + (0, 0, var_1);

  if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    setomnvar("_encstr_BA0211D5D2FAD8D5399CCA37A3F539F657E646", 1);

  self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 1);
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B8(var_0.origin);
  spawnintermission(var_2, var_0.angles);
  var_3 = getdvarint("_encstr_BE1A21DCC6C9F51339F5D2374B3AA52C1B7D6EA3E42B16B5AF3A4BB6B2DEAB3AD7D66E", 15000);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_2, var_3, 1, 1);
  return 0;
}

_id_125F1() {
  return self.sessionstate == "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258" && isDefined(self.thrust_fx_model);
}

waittillmatch_wait() {
  var_0 = -1;

  if(isDefined(self.lastdroppableweaponobj))
    var_0 = getaltbunkerindexforname(self.lastdroppableweaponobj);

  self setclientomnvar("_encstr_A5A41C5B23C10E96C6642833A331412E171A41E0552828607F6ADF73F7D8", var_0);
}

endgame_luidecisionreceived(var_0) {
  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A9DC0F9AB5C75A7E1C30A79B90300912A9", var_0);

  if(isDefined(var_1))
    return var_1;
  else
    return var_0;
}

endgame_finitewaves_vo(var_0) {
  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_82A210B87AF7FBF82B2571FF212F63B3DFD2", var_0);

  if(isDefined(var_1))
    return var_1;
  else
    return var_0;
}

elements_hidden(var_0, var_1, var_2) {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_81B90F563DD951779708AF875968260A8F", var_0, var_1);
  var_0 _id_1263F(1, var_1, var_2);
}

elevator_doors_open(var_0, var_1, var_2) {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AC4D1453B030CFC3638C2A6571798A895861B7FB182B", var_0, var_1);
  var_0 _id_1263F(0, var_1, var_2);
}

_id_14006() {
  level notify("_encstr_A56C1BC3EB6A9F905D2AC8610805F8D76203097B4702468065BDB3FF3C");
  level endon("_encstr_A56C1BC3EB6A9F905D2AC8610805F8D76203097B4702468065BDB3FF3C");
  waittillframeend;
  var_0 = level.players.size;
  var_1 = 0;
  var_2 = 0;
  var_3 = [];
  var_4 = [];

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = level.players[var_5];

    if(!istrue(var_6.delay_enter_combat_after_investigating_grenade)) {
      if(istrue(var_6.iszombie) || istrue(var_6.unset_relic_gun_game))
        var_2++;
      else {
        var_1++;
        var_3[var_6.team] = 1;
        var_4[var_6.team] = var_6.team;
      }
    }

    if(!scripts\engine\utility::array_contains_key(var_3, var_6.team)) {
      var_7 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A613112B8BE3D85F5FB050F81A6780A083F549", var_6.team);

      if(isDefined(var_7)) {
        if(!var_7) {
          var_3[var_6.team] = 1;
          var_4[var_6.team] = var_6.team;
        }
      }
    }
  }

  var_9 = (var_2 << 16) + (var_3.size << 8) + var_1;
  setomnvar("_encstr_AB041283746F200EC9F78BB9D7E2C0E0FCCE2BDB", var_9);
}

demo_debug_nuke() {
  var_0 = 0;
  level.teamswithplayers = [];
  var_1 = 0;

  foreach(var_3 in level.teamnamelist) {
    var_4 = scripts\mp\utility\teams::getteamdata(var_3, "_encstr_AB580A05672AE35D5FFF50B8");

    if(var_4) {
      var_0 = var_0 + var_4;
      var_1++;
      level.teamswithplayers[level.teamswithplayers.size] = var_3;

      if(var_1 > 1) {
        break;
      }
    }
  }

  if(scripts\mp\utility\game::matchmakinggame() && !level.ingraceperiod && (!isDefined(level.disableforfeit) || !level.disableforfeit) && !scripts\mp\menus::brking_updateteamscore()) {
    if(level.teambased) {
      if(level.teamswithplayers.size == 1 && game["_encstr_A1AD062E09D98338"] == "_encstr_877508C1D8C22F2DDC3B") {
        thread scripts\mp\gamelogic::onforfeit(level.teamswithplayers[0]);
        return;
      }

      if(level.teamswithplayers.size > 1) {
        level.forfeitinprogress = undefined;
        level notify("_encstr_8EE60EC1CA57DE4009BE0F2DA6EFE0A5");
      }
    } else {
      if(var_0 == 1 && level.maxplayercount > 1) {
        thread scripts\mp\gamelogic::onforfeit();
        return;
      }

      if(var_0 > 1) {
        level.forfeitinprogress = undefined;
        level notify("_encstr_8EE60EC1CA57DE4009BE0F2DA6EFE0A5");
      }
    }
  }

  if(level.teamswithplayers.size == 1 && istrue(level.br_debugsolotest)) {
    return;
  }
  if(!scripts\mp\utility\game::getgametypenumlives() && (!isDefined(level.disablespawning) || !level.disablespawning)) {
    return;
  }
  if(!scripts\mp\utility\game::gamehasstarted()) {
    return;
  }
  if(level.ingraceperiod && !isDefined(level.overrideingraceperiod)) {
    return;
  }
  debugprintvipstates();
  debugthink();

  if(level.teambased) {
    var_6 = [];
    var_7 = 0;
    var_8 = 0;
    var_9 = [];
    var_10 = [];

    foreach(var_12 in level.teamnamelist) {
      var_6[var_12] = 0;

      if(!istrue(level.disablespawning)) {
        foreach(var_14 in scripts\mp\utility\teams::getteamdata(var_12, "_encstr_9775086022BE1B413B8B")) {
          if(!istrue(var_14.hasspawned) || var_14.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_14.team == "_encstr_933E090A10B17DDFB3E522" || var_14.team == "_encstr_BD78059C33C543") {
            continue;
          }
          if(var_14.pers["_encstr_8CAA06DB20A31543"]) {
            var_6[var_12] = var_6[var_12] + var_14.pers["_encstr_8CAA06DB20A31543"];
            var_7 = 1;
          }
        }
      }

      var_16 = scripts\mp\utility\teams::getteamdata(var_12, "_encstr_8A2A0B936CCCC3078547970A8B");

      if(!var_8 && var_16 > 0)
        var_8 = 1;

      var_17 = 1;
      var_18 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A613112B8BE3D85F5FB050F81A6780A083F549", var_12);

      if(isDefined(var_18)) {
        if(!var_18)
          var_17 = 0;
      }

      if(var_17 && scripts\mp\utility\teams::getteamdata(var_12, "_encstr_A1310B432F9BDEFBEF4393B0F1") && var_16 <= 0 && !var_6[var_12] && !scripts\mp\utility\teams::getteamdata(var_12, "_encstr_8B340BAAD957B3BA5DD33DBB1B")) {
        var_9[var_9.size] = var_12;
        continue;
      }

      if(var_16 == 2 && !scripts\mp\utility\teams::getteamdata(var_12, "_encstr_A96C087B2B97994D62DB")) {
        if(scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BD1D06DA5D98651B" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_B18D0B5281530117EDEAC82033" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
          var_19 = scripts\mp\utility\teams::getteamdata(var_12, "_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE");
          var_20 = scripts\engine\utility::random(var_19);
          level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_20, "_encstr_8110100AE8554D5B2028EC19D6EB2753AF48");
        }

        scripts\mp\utility\teams::setteamdata(var_12, "_encstr_A96C087B2B97994D62DB", 1);
        continue;
      }

      if(var_16 == 1) {
        if(gettime() > scripts\mp\utility\teams::getteamdata(var_12, "_encstr_AC610CF033ED0C4B1A6B45D30502") + 5000 && !scripts\mp\utility\teams::getteamdata(var_12, "_encstr_A63208900AB769596374")) {
          var_21 = 0;
          var_19 = scripts\mp\utility\teams::getteamdata(var_12, "_encstr_9775086022BE1B413B8B");

          foreach(var_14 in var_19) {
            if(!isalive(var_14))
              var_21 = var_21 + var_14.pers["_encstr_8CAA06DB20A31543"];
          }

          if(var_21 == 0) {
            scripts\mp\utility\teams::setteamdata(var_12, "_encstr_AC610CF033ED0C4B1A6B45D30502", gettime());
            scripts\mp\utility\teams::setteamdata(var_12, "_encstr_A63208900AB769596374", 1);

            if(var_19.size > 1)
              [[level.ononeleftevent]](var_12);
          }
        }

        continue;
      }

      scripts\mp\utility\teams::setteamdata(var_12, "_encstr_A63208900AB769596374", 0);
    }

    if(!var_8 && !var_7) {
      if(istrue(level.postgameexfil) && level.gameended)
        level notify("_encstr_8BE5181B33B263B8BF3EED38E36160A57A47879BDF2A2088D6D7");

      if(istrue(level.nukeincoming)) {
        return;
      }
      return [[level.ondeadevent]]("_encstr_AF1904A7F929");
    }

    if(istrue(level.postgameexfil) && level.gameended)
      level notify("_encstr_8BE5181B33B263B8BF3EED38E36160A57A47879BDF2A2088D6D7");

    if(!istrue(level.skipondeadevent) && !istrue(level.nukeincoming)) {
      foreach(var_12 in var_9) {
        if(level.multiteambased) {
          scripts\mp\utility\teams::setteamdata(var_12, "_encstr_8B340BAAD957B3BA5DD33DBB1B", 1);
          [[level.ondeadevent]](var_12);
          continue;
        }

        return [[level.ondeadevent]](var_12);
      }
    }
  } else {
    var_6 = 0;

    foreach(var_14 in level.players) {
      if(var_14.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_14.team == "_encstr_933E090A10B17DDFB3E522") {
        continue;
      }
      var_6 = var_6 + var_14.pers["_encstr_8CAA06DB20A31543"];
    }

    var_29 = 0;

    foreach(var_12 in level.teamnamelist)
    var_29 = var_29 + scripts\mp\utility\teams::getteamdata(var_12, "_encstr_8A2A0B936CCCC3078547970A8B");

    if(!var_29 && !var_6) {
      if(istrue(level.nukeincoming)) {
        return;
      }
      return [[level.ondeadevent]]("_encstr_AF1904A7F929");
    }

    var_32 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(var_32.size == 1)
      return [[level.ononeleftevent]]("_encstr_AF1904A7F929");
  }

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_92D815AB409B65A5F965F72933B71EEBC3D11CD3CD7CB6");
}

_id_11A5C() {
  return istrue(level._id_11A5D) && getdvarint("_encstr_ACD3174A1ECE93C5F790FA030133FD6B2004EFD434D1EF8CA7", 1);
}

delay_loading_screen_omnvar(var_0) {
  var_1 = istrue(var_0) && _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::checkgulagusecount();
  return istrue(self.inlaststand) && !istrue(self.shouldgetnewspawnpoint) && !var_1;
}

delay_delete_tv_station_boss_icon() {
  var_0 = [];
  var_1 = [];
  var_2 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);

  if(level.teambased) {
    foreach(var_4 in level.teamnamelist) {
      var_5 = 0;

      foreach(var_7 in level.teamdata[var_4]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
        if(var_7 delay_loading_screen_omnvar(var_2)) {
          continue;
        }
        var_5 = 1;
        break;
      }

      if(var_5) {
        foreach(var_7 in level.teamdata[var_4]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
          if(var_7 delay_loading_screen_omnvar(var_2)) {
            continue;
          }
          var_0[var_0.size] = var_7;
        }

        continue;
      }

      foreach(var_7 in level.teamdata[var_4]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
        if(var_7 delay_loading_screen_omnvar(var_2))
          var_1[var_1.size] = var_7;
      }
    }
  } else {
    foreach(var_7 in level.players) {
      if(var_7 delay_loading_screen_omnvar(var_2)) {
        var_1[var_1.size] = var_7;
        continue;
      }

      if(isalive(var_7))
        var_0[var_0.size] = var_7;
    }
  }

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker()) {
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AFDE0DCC4B732DE6D0D7C60BC663CD", 0, var_0);

    foreach(var_7 in var_0) {
      var_7 setclientomnvar("_encstr_AB1A1B9D3B11763B5851E24AFEACAF6D68EF137059987A1B606B6B1381", 19);
      var_7 playsoundtoplayer("_encstr_AC7016F8CB393DD84369BE3B47F320F31DA1F8F042CE4FB0", var_7);
    }

    foreach(var_7 in var_1)
    var_7 hudoutlineenable("_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246");
  }
}

debugprintvipstates() {
  if(!getdvarint("_encstr_88D6196E3639F5C49CEB362C6E3AE61D859B23334B37B49B86B29C", 0)) {
    return;
  }
  if(istrue(level.watch_for_flash_detonation)) {
    return;
  }
  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_B18D0B5281530117EDEAC82033" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_816E079685517D0975" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E") {
    return;
  }
  var_0 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var_1 = 0;
  var_2 = 0;

  if(level.teambased) {
    foreach(var_4 in level.teamnamelist) {
      var_5 = 0;

      foreach(var_7 in level.teamdata[var_4]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
        if(var_7 delay_loading_screen_omnvar(var_0)) {
          var_2 = 1;
          continue;
        }

        var_5 = 1;
        break;
      }

      if(var_5) {
        var_1++;

        if(var_1 > 1)
          return;
      }
    }
  } else {
    foreach(var_7 in level.players) {
      if(!isalive(var_7)) {
        continue;
      }
      if(var_7 delay_loading_screen_omnvar(var_0)) {
        var_2 = 1;
        continue;
      }

      var_1++;

      if(var_1 > 1)
        return;
    }
  }

  if(var_1 == 0 || !var_2) {
    return;
  }
  level.watch_for_flash_detonation = 1;
  delay_delete_tv_station_boss_icon();
}

debugthink(var_0, var_1) {
  if(!istrue(level.delay_makeuseable))
    return 0;

  if(istrue(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound()))
    return 0;

  if(isDefined(level.start_escape_silo))
    return 0;

  level.start_escape_silo = 1;
  var_2 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_87D21B4BCEE6F6275996ED6B89B4CA6E98C2371D9A1D589B46BA96072B");
  var_3 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_AD511AB0D7DEFF127B21B0EFB8D3B6D9A10A1B572B1B302A49A3F930");
  var_4 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  var_5 = [];
  var_6 = 0;
  var_7 = [];

  foreach(var_9 in level.teamnamelist) {
    var_10 = 1;
    var_5 = [];
    var_11 = 0;
    var_12 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemies_fallback_logic(var_9);

    for(var_13 = 0; var_13 < var_12.size; var_13++) {
      var_14 = var_12[var_13];
      var_15 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(var_9, var_14);

      foreach(var_17 in var_15) {
        var_18 = istrue(var_4) && var_17 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal();

        if(var_18) {
          continue;
        }
        if(var_2 && var_17 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
          continue;
        }
        if(var_3 && var_17 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
          continue;
        }
        if(istrue(var_1) && (isDefined(var_0) && var_0 == var_17)) {
          var_11 = 1;
          continue;
        }

        var_19 = istrue(var_17.inlaststand) || isDefined(var_0) && var_0 == var_17;

        if(var_19 && !istrue(var_17.shouldgetnewspawnpoint) && !var_17 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && !var_17 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
          var_5[var_5.size] = var_17;
          continue;
        }

        var_10 = 0;
        break;
      }
    }

    if(var_10 && (var_5.size > 0 || istrue(var_1) && var_11)) {
      var_21 = [];

      foreach(var_17 in var_5) {
        if(isDefined(self.watch_for_attack) && !scripts\engine\utility::array_contains(var_21, self.watch_for_attack)) {
          self.watch_for_attack._id_145D0 = self.watch_for_player_enter_puddle_trigger;
          var_21[var_21.size] = self.watch_for_attack;
        }

        if(isDefined(var_0) && var_0 == var_17)
          var_6 = 1;

        var_17 notify("_encstr_AA48117347537FEF4F5072DBF877A72789ADE0");
        var_17._id_13749 = 1;
        var_17 scripts\mp\utility\damage::_suicide(0);
      }

      if(istrue(var_1) && isDefined(var_0) && isDefined(var_0.watch_for_attack) && !scripts\engine\utility::array_contains(var_21, var_0.watch_for_attack)) {
        if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_85DB1892EB3E2F57E001C1DB5921DB57E861E84B939FCF8C4065"))
          var_0 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_85DB1892EB3E2F57E001C1DB5921DB57E861E84B939FCF8C4065", var_21);
        else
          var_21[var_21.size] = var_0.watch_for_attack;
      }

      foreach(var_25 in var_21) {
        var_25 thread scripts\mp\events::killeventtextpopup("_encstr_BA2B0B1D2B586BEBBB2D0EB223", 0);
        var_25 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BA2B0B1D2B586BEBBB2D0EB223", var_25._id_145D0);
        var_25._id_145D0 = undefined;
        var_25 thread _id_13AD0(var_0, var_25, self.watch_for_player_enter_puddle_trigger);

        if(!isDefined(var_7[var_25.team])) {
          var_7[var_25.team] = 1;
          var_25 playsoundtoteam("_encstr_B6E114A3992028835FD71F07FBB849C93F5BE431C330", var_25.team);
        }
      }
    }
  }

  level.start_escape_silo = undefined;
  return var_6;
}

_id_13AD0(var_0, var_1, var_2) {
  waitframe();

  if(getdvarint("_encstr_968521DCB1C9FA8CA59BC2C4C6B2EB26C9FAD1B216DAEE961CB232BEB659CD37169D56", 1)) {
    if(isDefined(var_0))
      obituary(var_0, var_1, var_2, "_encstr_BE8B0F2D308830A1F0498D41CB04FF10D0", _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(var_1.team, var_1.squadindex));
  }
}

disable_all_turrets_permanently(var_0) {
  if(disablebunker11cachelocations(var_0))
    return 0;

  if(isagent(var_0))
    return 0;

  return 1;
}

threat_sight_monitor(var_0) {
  if(var_0 scripts\mp\utility\game::rankingenabled() && var_0 hasplayerdata()) {
    var_0 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 0, 0);
    var_0 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 1, 0);
    var_0 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 2, 0);
    var_0 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 3, 0);
    var_0 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 4, 0);
    var_0 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 5, 0);
    var_1 = var_0 getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B");
    var_0 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 6, var_1);
    var_0 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 7, var_1);
  }
}

_id_13120(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  foreach(var_3 in var_1) {
    if(!var_3 scripts\mp\utility\game::rankingenabled() || !var_3 hasplayerdata()) {
      continue;
    }
    var_4 = var_3.pers["_encstr_95EE0966486F7B7989C9B9"];

    if(!isDefined(var_4))
      var_4 = 0;

    var_3 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 0, var_4);
    var_5 = var_3.pers["_encstr_A6120A23912A685B5702D6DF"];

    if(!isDefined(var_5))
      var_5 = 0;

    var_3 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 1, var_5);
    var_6 = var_3.pers["_encstr_A7D40A36EDF6A35ADCD9B028"];

    if(!isDefined(var_6))
      var_6 = 0;

    var_3 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 2, var_6);
    var_7 = 0;

    if(isDefined(var_3.matchbonus))
      var_7 = int(var_3.matchbonus);

    var_3 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 4, var_7);
    var_8 = 0;

    if(isDefined(var_3._id_12394))
      var_8 = int(var_3._id_12394);

    var_3 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 5, var_8);
    var_9 = var_3 getplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 6);
    var_10 = var_9 + var_3.pers["_encstr_AA3B085BC34075B70E12"]["_encstr_B607032B8B"];
    var_3 setplayerdata("_encstr_8C07031599", "_encstr_A93E090B0B93B2C2B15D95", 7, var_10);
  }
}

disabledvehicles(var_0, var_1) {
  if(isDefined(self.vehicle)) {
    var_2 = var_0.streakname;

    if(var_2 == "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4")
      return 0;
  }

  return 1;
}

display_hint_single(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = var_0.owner;

  if(!isDefined(var_1))
    return 0;

  if(!istrue(var_0._id_133CE) && !var_1 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::make_chair_ai_spawner(var_0))
    return 0;

  var_2 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8F9A199578C7C234D0F8BBBB50A9FBB863049C4D4D1F5A669B38EF", var_0);

  if(isDefined(var_2))
    return var_2;

  return scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse(var_0);
}

elevator_init(var_0) {
  return var_0 == 1;
}

votes() {
  var_0 = self.currentprimaryweapon;

  if(isDefined(var_0) && isDefined(var_0.basename) && (var_0.basename == "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B" || var_0.basename == "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817"))
    self setweaponammoclip(var_0, self getcurrentweaponclipammo() + 1);
}

ending_viewing_players_setup(var_0) {
  if(!isDefined(var_0.operatorcustomization) || !isDefined(var_0.operatorcustomization.voice) || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 1;

  return 0;
}

ending_fade_in(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8B9F2B6FF056A33213F78E025E4FBB697958F38F38490879670D523A48FDC1208010D77758A14273ABAD9F392B", var_0);
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_839F2BE7E3801A4748134ED26B0184F266177B674337733F509B82DAED40E79BC8873F9FED6D9BEA38C17F29FA", var_1);
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B1A323AB4BEB36B7B51C58E69BFA3A858DB707DCD65838F5CD2DD359EB7B9DCA9393D21995", var_2);
  } else if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8B9F2B6FF056A33213F78E025E4FBB697958F38F38490879670D523A48FDC1208010D77758A14273ABAD9F392B", level.br_circle.dangercircleent.origin[0]);
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_839F2BE7E3801A4748134ED26B0184F266177B674337733F509B82DAED40E79BC8873F9FED6D9BEA38C17F29FA", level.br_circle.dangercircleent.origin[1]);
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B1A323AB4BEB36B7B51C58E69BFA3A858DB707DCD65838F5CD2DD359EB7B9DCA9393D21995", level.br_circle.dangercircleent.origin[2]);
  } else {
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8B9F2B6FF056A33213F78E025E4FBB697958F38F38490879670D523A48FDC1208010D77758A14273ABAD9F392B", 0);
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_839F2BE7E3801A4748134ED26B0184F266177B674337733F509B82DAED40E79BC8873F9FED6D9BEA38C17F29FA", 0);
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_B1A323AB4BEB36B7B51C58E69BFA3A858DB707DCD65838F5CD2DD359EB7B9DCA9393D21995", 0);
  }
}

prematchperiod() {
  if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"])) {
    level.connectingplayers = getdvarint("_encstr_87B60BC4DC439930C8178D957F");

    if(getdvarint("_encstr_9AFD0F6EC639D7362DEC2BF5D8DE98895E", 0) == 1 && !istrue(level._id_133E0)) {
      game["_encstr_95810CA5B9982DEC9526DEC426F2"] = 0;
      game["_encstr_B23913A2485CFF7D08BDE2F117E0FD7389619BBA71"] = 1;
      level.allowprematchdamage = 1;

      if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE")) {
        setnojipscore(1, 1);
        setnojiptime(1, 1);
        level.nojip = 1;
      }

      level scripts\mp\gamelogic::livelobbymatchstarttimer("_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD", 15);
      level notify("_encstr_8C900F26838A7D1BCF4B1050C709D397C2");
      level.prematchperiod = 0;
    } else if(!istrue(level._id_133E0)) {
      level.allowprematchdamage = 1;
      level scripts\mp\gamelogic::livelobbymatchstarttimer("_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD", 15);
    }

    if(istrue(level._id_133E0)) {
      while(!level.players.size)
        waitframe();
    }

    level notify("_encstr_8B7A1187533F0D1369DFC88EF81BD79B148B8D");
    physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 2);
    level.prematchstarted = 1;
    level.prematchperiodend = 0;
    scripts\mp\gamelogic::matchstarttimerskip();
    physics_raycastents(scripts\mp\gamelogic::gettimeremaining(), 0);
    return 1;
  }

  return 0;
}

risk_flagspawncountchange() {
  if(isDefined(level.defend_main))
    return level.defend_main;

  var_0 = ["_encstr_82B611182358E7F0F73755EBEC37B96975EB68", "_encstr_97070E2DBBC1EB6BACD74772DAC21B59", "_encstr_86950F630B576F60ADBF187A3FD47857BA", "_encstr_88AC1194CB88B92BC9A7CBDE2D419E113D63CD", "_encstr_97070E2DBBC1EB6BACD74772DAC21B59", "_encstr_B1650DA3AFF7D810E55103B206C910", "_encstr_819F167B3FFF46097201356BB6011D701C72B3D8819DA208", "_encstr_9B650D81072A39474516439F7BAF8F", "_encstr_BEB013273882D75A5B3883E89E7B83A450C07FEB30"];
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  level.defend_main = var_2;
  return var_2;
}

risktokencount() {
  if(isDefined(level.delete_undeployed_subway_cars))
    return level.delete_undeployed_subway_cars;

  var_0 = ["_encstr_B8F60CFFCAE9A90877F4F810DF35", "_encstr_AF110D3EBCF7205B412AA808A2250B", "_encstr_84BD0F409F093B49979C454B67A731F5ED"];
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  level.delete_undeployed_subway_cars = var_2;
  return var_2;
}

riskspawn_initialset() {
  if(isDefined(level.demoforcesre))
    return level.demoforcesre;

  var_0 = ["_encstr_B20A0FF36596CFAFCF7843AA3883E5FEC3", "_encstr_9A530EABF3473FBAC1B2D3AF09B12F3F", "_encstr_87050EAB87BF098061DD677FF417226E", "_encstr_ABC010E6437D6BD9D7E8BCB0CDD695591389"];
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  level.demoforcesre = var_2;
  return var_2;
}

risktokencountondeath() {
  if(isDefined(level.demotehvt))
    return level.demotehvt;

  var_0 = ["_encstr_99C40C22E5BF3360E6138FAF68D8", "_encstr_B68F0EDC43FAE686BE2639BDD6ACBDA9", "_encstr_BAF80FE6A1F537867D364B9B46D285E4C1", "_encstr_A7CF0D12D56FE3B036884F5FD02227"];
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  level.demotehvt = var_2;
  return var_2;
}

ending_fade_out() {
  var_0 = getdvarint("_encstr_8ACC12EE8E73EF013A3FA818A748B9CF4ABEFC6A", 0);
  return var_0;
}

guard_shack_mantle(var_0, var_1) {
  if(!isDefined(var_1._id_125E4))
    return var_0;

  var_2 = var_0;
  var_3 = (gettime() - var_1._id_125E4) * 0.001;

  if(var_3 >= level.decoy_clearaithreatbiasgroup && var_3 < level.decoy_giveassistpoint) {
    var_2 = var_2 * level.decoy_aicanseeanyplayer;
    return var_2;
  } else if(var_3 >= level.decoy_giveassistpoint && var_3 < level.decoy_delaystoptrackingassist) {
    var_2 = var_2 * level.decoy_canseeplayer;
    return var_2;
  } else if(var_3 >= level.decoy_delaystoptrackingassist) {
    var_2 = var_2 * level.decoy_aiseenplayerrecently;
    return var_2;
  } else
    return var_2;
}