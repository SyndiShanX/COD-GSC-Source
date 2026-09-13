/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br.gsc
***********************************************/

main() {
  level.nobroshot = 1;
  level.clearstockondrop = 1;
  level.disablespawncamera = 1;
  level.armoronweaponswitchlongpress = 1;
  level.dangerzoneskipequipment = 1;
  level.noweaponfalloff = 0;
  level.clampstepbulletdamage = 2;
  level.br_allowloadout = getdvarint("dvar_C0DBA6A7250AAD33", 0);
  level._id_66113AA6FC12BE57 = getdvarint("dvar_746BEF1D96C7472D", 0);
  level._id_C62D39D6E6AFB119 = getdvarint("dvar_539EF73C48382C6B", 0);
  level._id_06D1D9E1B59C6F37 = getdvarint("dvar_1A1007F742526DFD", 0);
  level._id_F561FC43A226DAE4 = getdvarint("dvar_74C08DC52C036AFA", 0);
  level._id_7D17E26667BE2792 = getdvarint("dvar_55D9444D8A3CE31A", 1);
  level._id_472D7A6D15E57940 = getdvarint("dvar_586D32848F833922", 1);
  level._id_1D814F83596D0A02 = getdvarint("dvar_07A1DA73FA673ED8", 1);
  level._id_47207B7B330CF8E0 = getdvarint("scr_disableprematchsuper", 0);
  level._id_0F478C1F94CAA7E9 = getdvarint("scr_use_playerdata_weapon_slot", 1);
  level._id_87A4731D4DCE4C3F = _id_2D9D24F7C63AC143::_id_8237B4EEAB275F08;
  level._id_58ADCE74179AB9EF = scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm";
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  _id_9BBACB179DEA3237[0] = scripts\mp\utility\game::getgametype();
  _id_9BBACB179DEA3237[_id_9BBACB179DEA3237.size] = scripts\mp\utility\game::getsubgametype();
  scripts\mp\gameobjects::main(_id_9BBACB179DEA3237);

  if(getdvarint("scr_br_voice_proxy_enabled", 0) == 1) {
    setDvar("voice_proximity_team", 0);
    setDvar("voice_proximity_radius", 2200);

    if(getdvarint("dvar_23235702FBEA7B42", 0) == 1) {
      setDvar("voice_proximity_enemy", 1);
      setDvar("dvar_58A078A367C02AB3", 1);
    } else
      setDvar("voice_proximity_enemy", 0);
  } else {
    setDvar("voice_proximity_team", 0);
    setDvar("voice_proximity_enemy", 0);
  }

  _id_362C58E8BB39BCDA::init();

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
    scripts\mp\utility\game::registerlaststandhealthdvar(100);
    scripts\mp\utility\game::registerlaststandrevivehealthdvar(30);
    scripts\mp\utility\game::registerlaststandtimerdvar(60);
    scripts\mp\utility\game::registerlaststandinvulntimerdvar(0);
    scripts\mp\utility\game::registerlaststandsuicidetimerdvar(10);
    scripts\mp\utility\game::registerlaststandrevivetimerdvar(5);
    scripts\mp\utility\game::registerlaststandweapondvar("iw8_gunless");
    scripts\mp\utility\game::registerlaststandrevivedecayscaledvar(0.5);
    scripts\mp\utility\game::registerlaststandweapondelaydvar(1.0);
    setDvar("scr_br_spawnprotectiontimer", 5);
    setDvar("scr_br_allowkillstreaks", 1);
    setdvarifuninitialized("dvar_DDD02929770FCC8C", 0);
    setdvarifuninitialized("dvar_7A493092F8A1C04C", getdvarint("dvar_DDD02929770FCC8C", 0));
    setdvarifuninitialized("dvar_A3A7191F4314591F", 2);
    setdvarifuninitialized("scr_player_laststandreviveretainhealth", 1);
    setdvarifuninitialized("dvar_1A0DE898609317B4", 1.0);
    setdvarifuninitialized("dvar_5C93DCD7535822E6", 0);
    setdvarifuninitialized("scr_br_respawn_token_is_self_revive", 1);
    setdvarifuninitialized("dvar_296DEC2CBCFB6606", 0);
    setdvarifuninitialized("dvar_1F9797AA5675C82A", 1);
    setdvarifuninitialized("dvar_1D3C72CAB41E5D7C", 1);
  }

  defineplayerloadout();
  updategametypedvars();
  scripts\cp_mp\parachute::initparachutedvars();
  table = "classtable:classtable_br_prematch";
  level._id_003DC5C06B446489 = 10;

  if(getdvarint("mgl", 0))
    table = "classtable:classtable_br_default_mgl";

  if(_id_362C58E8BB39BCDA::isfeatureenabled("prematchBlueprints"))
    level thread prematchinitblueprintloadouts();
  else
    prematchinitloadouts(table);

  if(istrue(level.br_allowloadout)) {
    level.modeloadoutupdateammo = _id_724736FCF0FB6604::brloadoutupdateammo;

    if(!istrue(level._id_66113AA6FC12BE57))
      level.br_loadout_option = 0;

    level.giveloadouteverytime = 1;
  }

  thread _id_B01C9196B051F596();
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
  level.modifyvehicledamage = ::brmodifyvehicledamage;
  level.onplayerdamaged = ::onplayerdamaged;
  level.onnormaldeath = ::onnormaldeath;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.onplayerkilled = ::onplayerkilled;
  level.onsuicidedeath = ::onsuicidedeath;
  level.objvisall = 1;
  level.ontimelimit = ::ontimelimit;
  level.prewaitandspawnclient = ::brprewaitandspawnclient;
  level.modeplayerskipdialog = _id_2CEDCC356F1B9FC8::modeplayerskipdialog;
  level.allowfauxdeath = 0;
  level._id_B9C50A4FD9223CC7 = ::brendgame;
  level._id_62A7B43F2B60646D = ::_id_6760D3783DFAC7DD;
  level._id_4038D35F2CB73FD7 = _id_362C58E8BB39BCDA::isfeaturedisabled;
  level.migratespectators = _id_6489FCDFE6FA2E36::migratespectators;
  _id_2342B8AAD723994E::registeronplayerjoinsquadcallback(::onplayerjoinsquad);

  if(!istrue(level.br_allowloadout) && !istrue(level._id_E4A482EDC1542597)) {
    level.parachutetakeweaponscb = scripts\cp_mp\parachute::takeweaponsdefaultfunc;
    level.parachuterestoreweaponscb = ::nakeddrop;
  } else {
    level.parachutetakeweaponscb = scripts\cp_mp\parachute::takeweaponsdefaultfunc;
    level.parachuterestoreweaponscb = ::loadoutdrop;
  }

  level.modeshoulddofauxdeathfunc = _id_123A6F38785CDF2D::playershoulddofauxdeath;
  level.modeonlaststandfunc = _id_123A6F38785CDF2D::playersetinlaststand;
  level.modeonexitlaststandfunc = ::playerexitlaststand;
  level.endgame = ::brendgame;
  level.laststandweaponcallback = ::brchooselaststandweapon;
  level.modelaststandallowed = ::modelaststandallowed;
  level.preplayerdamaged = ::brpreplayerdamaged;
  level.modevalidatekillcam = ::brvalidatekillcam;
  level.modespawnclient = ::spawnclientbr;
  level.onsupportboxusedbyplayer = ::onsupportboxusedbyplayer;
  level.onarmorboxusedbyplayer = ::onarmorboxusedbyplayer;
  level._id_130BC3F5F33BB97D = ::_id_130BC3F5F33BB97D;
  level._id_F24AE0993EFCA48F = ::_id_F24AE0993EFCA48F;
  level.onscavengerbagpickup = ::onscavengerbagpickup;
  level.onnewequipmentpickup = ::onnewequipmentpickup;
  level.ongrenadeused = ::ongrenadeused;
  level.onweapontaken = ::onweapontaken;
  level.modeplayerkilledspawn = ::brplayerkilledspawn;
  level.modemayconsiderplayerdead = ::brmayconsiderplayerdead;
  level.onplayerconnectstream = ::onplayerconnectstream;
  level.playerisstreaming = ::playerisstreaming;
  level.lastdroppableweaponchanged = ::lastdroppableweaponchanged;
  level.regenhealthaddfunc = ::brregenhealthadd;
  level.regendelayspeedfunc = ::brregendelayspeed;
  level.modeaddtoteamlives = ::brmodeaddtoteamlives;
  level.moderemovefromteamlives = ::brmoderemovefromteamlives;
  level.modeallowmeleevehicledamage = ::modeallowmeleevehicledamage;
  level.modeignorevehicleexplosivedamage = ::modeignorevehicleexplosivedamage;
  level.modevalidatekillstreakslot = ::brmodevalidatekillstreakslot;
  level._id_9E34D99A98D2FF67 = ::_id_9E34D99A98D2FF67;
  level._id_29F84151A47F0A35 = ::_id_342438311E316357;

  if(!isDefined(level.modeiskillstreakallowed))
    level.modeiskillstreakallowed = ::briskillstreakallowed;

  level.updategameevents = ::br_updategameevents;
  level.checkforlaststandfinish = ::br_checkforlaststandfinish;
  level.checkforlaststandwipe = ::br_checkforlaststandwipe;
  level.vehicleoccupantdeathcustomcallback = _id_2CEDCC356F1B9FC8::br_onvehicledeath;
  level.allowclasschoicefunc = _id_724736FCF0FB6604::brallowclasschoicefunc;
  level.tacticaltimemod = scripts\mp\utility\dvars::dvarfloatvalue("tacticalTimeMod", 2.5, 0.5, 5);
  level.addlaststandoverheadiconcallback = scripts\engine\utility::void;
  level.dontshootwhileparachuting = 1;
  level.disablecopycatloadout = 1;
  level.disableinitplayergameobjects = 1;
  level.laststandkillteamifdowndisable = 1;
  level.killstreakweaponfiredcontinue = ::killstreakweaponfiredcontinue;
  level.makedroneguardscrambler = 1;
  level.traceselectedmaplocation = ::traceselectedmaplocation;
  level._id_947925F5FC6939A3 = ::_id_227CA42A35B0398B;

  if(getdvarint("scr_br_prematchffa", 0)) {
    level.br_prematchffa = 1;

    if(scripts\mp\utility\game::getsubgametype() != "dmz")
      level.allowprematchdamage = 1;

    level.recordfinalkillcam = 0;
    level.ignorescoring = 1;
    level.disableweaponstats = 1;
    level.disablestattracking = 1;
    level.prematchaddkillfunc = ::brprematchaddkill;
    level.onattackerdamagenottracked = ::bronattackerdamagenottracked;

    if(scripts\mp\utility\game::getsubgametype() != "dmz")
      level.challengesdisabled = 1;

    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_numLives"), 0);
  }

  level._id_B89A535236A6F3D8 = ::_id_B89A535236A6F3D8;
  level.br_prematchloot = [];
  level.br_prematchlootparts = [];
  setomnvar("scriptable_loot_hide", 1);
  setomnvar("ui_killcam_copycat", 0);
  level.bypassclasschoicefunc = ::pickclassbr;
  setomnvarforallclients("ui_skip_loadout", 0);
  level.assists_disabled = undefined;
  game["dialog"]["gametype"] = "wrzn_wzan_gmty";
  game["dialog"]["offense_obj"] = "klla_wzan_hint";
  game["dialog"]["defense_obj"] = "hint_ffa";
  game["dialog"]["obj_extraction"] = "objective_extraction";
  game["dialog"]["prematch_enter"] = "pmnt_wzan_gams";
  game["dialog"]["prematch_end"] = "pmnd_wzan_gams";
  game["dialog"]["deploy_squad_leader"] = "dpsl_wzan_gams";
  game["dialog"]["first_circle"] = "crcf_wzan_gams";
  game["dialog"]["new_circle"] = "crcn_wzan_gams";
  game["dialog"]["circle_closing"] = "crrc_wzan_gams";
  game["dialog"]["final_circle"] = "crrf_wzan_gams";
  game["dialog"]["last_man_standing"] = "lsms_wzan_gams";
  game["dialog"]["match_start"] = "btry_wzan_gmty";
  game["dialog"]["primary_objective"] = "btry_wzan_objt";
  game["dialog"]["supply_drop_incoming"] = "spdr_wzan_gams";
  game["dialog"]["team_loss"] = "lose_wzan_gams";
  game["dialog"]["team_victory"] = "win0_wzan_gams";
  game["dialog"]["top_2"] = "tp02_wzan_gams";
  game["dialog"]["top_3"] = "tp03_wzan_gams";
  game["dialog"]["top_5"] = "tp05_wzan_gams";
  game["dialog"]["top_10"] = "tp10_wzan_gams";
  game["dialog"]["top_25"] = "tp25_wzan_gams";
  game["dialog"]["top_50"] = "tp50_wzan_gams";
  game["dialog"]["top_5_lose"] = "t05l_wzan_gmty";
  game["dialog"]["top_10_lose"] = "t10l_wzan_gmty";
  game["dialog"]["top_25_lose"] = "t25l_wzan_gmty";
  game["dialog"]["finish_calls"] = "game_end_prompt_finish_calls";
  game["dialog"]["respawning_enemy_in_area"] = "enia_wzan_rspw";
  game["dialog"]["br_sitrep_circle_in"] = "radn_wzan_bsci";
  game["dialog"]["br_sitrep_circle_mixed"] = "radn_wzan_bscm";
  game["dialog"]["br_sitrep_circle_out"] = "radn_wzan_bsct";
  game["dialog"]["br_sitrep_circle_outfar"] = "radn_wzan_bsco";
  level notify("br_dialog_initialized");
  level.disabledamagestattracking = 1;
  level.disabledamagestattrackingfunc = ::brdisabledamagestattracking;
  level.startingspawns = [];
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_smk_signal_red"] = loadfx("vfx/iw8_cp/prop/vfx_smk_signal_red");
  level.bots_ignore_team_balance = 1;

  if(!isDefined(level.teammaxfill))
    level.teammaxfill = getdvarint("dvar_87507E11EADD4DB4", 1) > 0;

  level.lowpopcheck = getdvarint("dvar_BE00F4EEBC5A0ACA", 0);
  level.modespecificparachutecompletecb = ::parachutecomplete;
  level.onfirstlandcallback = ::onfirstlandcallback;
  level._id_387CD21817428092 = getdvarint("dvar_8AD87BD26869EC0D", 0);

  if(!isDefined(level.skipprematchdropspawn))
    level.skipprematchdropspawn = getdvarint("dvar_D182F4551B978E2B", 0);

  level.br_debugsolotest = getdvarint("scr_br_solo_test", 0);
  level._id_D804888D9484FF69 = getdvarint("dvar_732CD1E227920A87", 0);

  if(_id_A587B0B0998C6D13())
    level.disableforfeit = 1;

  level.br_infils_disabled = getdvarint("dvar_98F4CDF3FA51A9D0", 0) || _id_362C58E8BB39BCDA::isfeaturedisabled("infil");
  level.br_circle_disabled = getdvarint("dvar_0D65846276AEAE13", 0);
  level.extractplunderheliinvulnerable = getdvarint("dvar_9126054077CBEFAC", 1);
  level.br_ending_delay = getdvarint("dvar_01122632B784E1B7", 4);
  level.roundenddelay = 0.5;
  level.postroundtime = 9;

  if(scripts\mp\utility\game::getsubgametype() != "dmz")
    level._id_ED844DB90CB6D370 = 0;

  level.br_pelletmaxdamage = getdvarint("scr_br_pelletmaxdamage", -1);
  level._id_2CACA637693D024D = getdvarint("dvar_0FC3E181B5B3E5B7", -1);
  level._id_22DB86FD48FEE384 = getdvarint("scr_br_slugmaxdamage", -1);
  level._id_E247454AC2869696 = getdvarint("dvar_005FCBCE13EF8D5F", 9);
  level._id_A7F81DFDC88E53E6 = getdvarint("unified_backpack_size", 0);
  level._id_4941FC1EE570D4CB = ::_id_C8915AC8C8987452;
  level._id_4C124F424CDFA325 = getdvarint("dvar_170C10715AF6A431", -1);
  level._id_6BED852A909E4F70 = getdvarint("dvar_ECA4CF1DB65156C9", 0);
  level._id_68C03DCCCE80D6F8 = getdvarint("dvar_0CCD72BAA1F9838C", 1);
  level._id_E97D3DE5B99775A6 = getdvarint("dvar_BB9CA2724C97686B", 1);
  level._id_7F3AAFCF56C9CE14 = getdvarint("dvar_A5369146AF094F2C", 1);
  level._id_F2C468B1D700A1BD = getdvarint("dvar_3BBAB476317628C6", 1) == 1;
  level._id_455A4E4B5E61F55F = getdvarint("dvar_4DD57309D51B9D0A", 1) == 1;
  level._id_8A854EC031BB41F1 = getdvarint("dvar_AEB97A5FADA9C62F", 1) == 1;
  level._id_318DE67B5265B4C6 = getdvarint("dvar_6132D06D6475B2E0", 1) == 1;
  level._id_2F60D02380CD603D = ::_id_AD8C1E6228A10058;
  level._id_B13E35608B336D65 = _id_2D9D24F7C63AC143::_id_B13E35608B336D65;
  level._id_6196D9EA9A30E609 = _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609;
  level._id_AFA6AFA7165491D8 = _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7;
  level._id_DC52A11D1EE2690E = getdvarint("scr_br_default_spawn_height", 17000);
  level._id_5B5A1FCD1024EDA5 = getdvarint("scr_br_dynamic_spawn_height_enable", 0);
  level._id_B257658F289A3108 = getdvarfloat("scr_br_dynamic_spawn_height_reduction_percent", 0.09);
  level._id_27506E83D743E391 = getdvarint("scr_br_dynamic_spawn_height_circle_index_limit", -1);
  level._id_5321A1377F9CC5AA = getdvarint("scr_br_dynamic_spawn_height_minimum", 6500);
  _id_0CDA409F3A76DAC5();

  if(!isDefined(level.br_loadout_option))
    brinitloadoutoption();

  _id_715028F54BAD19A1::branalytics_init();
  _id_46AF76764B1FC7F0::brvehiclesinit();
  _id_75377E59F5BECAC8::main();
  _id_7933519955F32C4E::main();
  _id_5C6B989A6F25F7FA::br_ending_init();
  _id_1671F48D05259D22::init();
  _id_002E0206D4774172::init();
  level thread _id_669760F0500E4358::init(scripts\mp\utility\game::getsubgametype() != "dmz");

  if(istrue(level._id_C62D39D6E6AFB119))
    thread _id_744CAD313ED0A87E::init();
  else
    thread _id_9C8DFD3B19180B63();

  level thread _id_21C19CFC7139D773::init();
  level thread _id_15038E9B270F1B31::init();
  level thread _id_5BC60484D17FA95C::_id_DBDCA8CA57E8D71D();
  level thread _id_3583FF375AB3A91E::_id_61B256ED26C0A7F7();
  level thread _id_7EAFD8F2B77A1870::_id_05675A69BBCEA259();
  thread _id_4708E0CB7EEA8875();
  thread _id_D1618645A2C0E3E6();
  initializetweakableoverrides();
  entcleanup();
  level thread announceplayercountlandmarks();
  level._id_C59C301EAABC2E32 = getdvarint("dvar_19FAE1AAD58E8C50", 0);
  setdvarifuninitialized("dvar_A5AB8ED6CC1B486A", 3);
  setdvarifuninitialized("dvar_D9B119233DF13AC1", 600.0);
  setdvarifuninitialized("dvar_FDEB104EC6908DF8", 600.0);
  setdvarifuninitialized("dvar_9775C39C335AAB23", 600.0);
  setDvar("dvar_7B5549FCFA5138BC", 30);
  _id_70F8C085C6BDE77E::_id_C238E4C6605E99F8();
  _id_5E9EE20A8C623C8F::init();
  thread _id_2E385BC294259245::init();
  thread _id_29C32B7117E01180::init();
  thread _id_2902155747C5C4FE::init();
  thread _id_48814951E916AF89::init();
  thread _id_2391409EF7B431E1::_id_D22B3026C3183EAD();
  thread _id_828026E0C887CD11();
  thread _id_57D3850A12CF1D8F::_id_A894D6041798CC06();
  _id_48814951E916AF89::_id_93ADD0B65DB9F722(::_id_56869E118720CA3B, level);
  level._id_9A849908E60B857C = getdvarint("br_perk_package_enabled", 0);

  if(!scripts\engine\utility::flag_exist("stealth_enabled")) {
    scripts\engine\utility::flag_init("stealth_enabled");
    scripts\engine\utility::flag_init("level_stealth_initialized");
    scripts\engine\utility::flag_init("stealth_spotted");
  }

  if(getdvarint("scr_dmz_nukemapdataafterprematch", 1) == 1)
    level thread _id_EA010C4D09365B32();

  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showBrDMZSplash", _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4);
  _id_47DEB71F27D46832::init();

  if(_id_3FF084F114B7F6C9::_id_6934349B7823D888())
    _id_3FF084F114B7F6C9::init();

  if(!_id_362C58E8BB39BCDA::isbrgametypefuncdefined("lootAllowedInBackpack"))
    _id_362C58E8BB39BCDA::registerbrgametypefunc("lootAllowedInBackpack", ::_id_E83AB39A1E762EAD);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_72AF5A878A9D3397::initialize();

  scripts\engine\utility::flag_set("br_init", 1);
}

_id_B01C9196B051F596() {
  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();
  level.nosuspensemusic = 1;
  waittillframeend;
  thread scripts\mp\music_and_dialog::stopsuspensemusic();

  if(_id_FAF0D2FAC3F47583 != "dmz")
    _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("mp_gamemode_br");
}

_id_D1618645A2C0E3E6() {
  level waittill("infils_ready");
}

_id_4708E0CB7EEA8875() {
  if(!istrue(getdvarint("dvar_072AE262A8559256", 0))) {
    return;
  }
  level waittill("infils_ready");
  _func_71A28A935629A941("br_saba_aieventlist");
  array["spotted"]["ally_damaged"] = 512;
  array["hidden"]["ally_damaged"] = 512;
  array["spotted"]["ally_hurt_peripheral"] = 512;
  array["hidden"]["ally_hurt_peripheral"] = 512;
  array["spotted"]["ally_killed"] = 256;
  array["hidden"]["ally_killed"] = 256;
  array["spotted"]["attack"] = 512;
  array["hidden"]["attack"] = 512;
  array["spotted"]["object_impact"] = 128;
  array["hidden"]["object_impact"] = 128;
  array["spotted"]["death"] = 256;
  array["hidden"]["death"] = 128;
  array["spotted"]["decoy_grenade"] = 256;
  array["hidden"]["decoy_grenade"] = 128;
  array["spotted"]["defaultevent"] = 256;
  array["hidden"]["defaultevent"] = 128;
  array["spotted"]["door_bash"] = 512;
  array["hidden"]["door_bash"] = 256;
  array["spotted"]["explosion"] = 256;
  array["hidden"]["explosion"] = 128;
  array["spotted"]["footstep"] = 180;
  array["hidden"]["footstep"] = 180;
  array["spotted"]["footstep_walk"] = 180;
  array["hidden"]["footstep_walk"] = 180;
  array["spotted"]["footstep_sprint"] = 360;
  array["hidden"]["footstep_sprint"] = 240;
  array["spotted"]["glass_destroyed"] = 384;
  array["hidden"]["glass_destroyed"] = 256;
  array["spotted"]["grenade danger"] = 256;
  array["hidden"]["grenade danger"] = 128;
  array["spotted"]["grenade_ping"] = 256;
  array["hidden"]["grenade_ping"] = 128;
  array["spotted"]["gunshot"] = 960;
  array["hidden"]["gunshot"] = 480;
  array["spotted"]["gunshot_impact"] = 240;
  array["hidden"]["gunshot_impact"] = 180;
  array["spotted"]["gunshot_teammate"] = 256;
  array["hidden"]["gunshot_teammate"] = 256;
  array["spotted"]["pain"] = 256;
  array["hidden"]["pain"] = 128;
  array["spotted"]["projectile_impact"] = 256;
  array["hidden"]["projectile_impact"] = 256;
  array["spotted"]["silenced_shot_impact"] = 64;
  array["hidden"]["silenced_shot_impact"] = 64;
  array["spotted"]["throwingknife_impact"] = 96;
  array["hidden"]["throwingknife_impact"] = 96;
  array["spotted"]["window_open"] = 128;
  array["hidden"]["window_open"] = 0;
  scripts\stealth\manager::set_event_distances(array);
}

waitthensetstatgroupreadonly() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("losses");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("winLoss");
  }
}

entcleanup() {
  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    _delete_ents("script_noteworthy", "locale_" + _id_AC0E594AC96AA3A8);

  _delete_ents("script_noteworthy", "locale_99");
}

_delete_ents(key, value) {
  ents = getEntArray(value, key);
  scripts\engine\utility::array_call(ents, ::delete);
}

initstandardloadout(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  _id_A300FA75277719EE = scripts\mp\class::_id_DF2933F96D726D71(_id_00CEBA6EC7E8CA50);
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon._id_59F68715C04CE28F;
  loadout["loadoutPrimaryAttachment2"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutPrimaryAttachment3"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutPrimaryAttachment4"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon._id_59F68215C04CD790;
  loadout["loadoutPrimaryAttachment5"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutPrimaryCamo"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.reticle;
  loadout["loadoutSecondary"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon._id_59F68715C04CE28F;
  loadout["loadoutSecondaryAttachment2"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutSecondaryAttachment3"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutSecondaryAttachment4"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon._id_59F68215C04CD790;
  loadout["loadoutSecondaryAttachment5"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutSecondaryCamo"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).equipment.primary;
  loadout["loadoutEquipmentSecondary"] = scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).equipment._id_D7B9856A19F9B6B5;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).perks._id_16680ABD1742C050, scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).perks._id_16680DBD1742C6E9, scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).perks._id_16680CBD1742C4B6, scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680ABD1742C050, scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680DBD1742C6E9, scripts\mp\class::_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680CBD1742C4B6];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutFieldUpgrade1"] = "none";
  loadout["loadoutFieldUpgrade2"] = "none";
  return loadout;
}

givestandardtableloadout(_id_089688461C79EF11, _id_2FEFED9BB7EA82D8, _id_C179E44BD14D2D12, _id_5D3709F813102611) {
  if(!isDefined(level.br_standard_loadout))
    level.br_standard_loadout = initstandardloadout("classtable:classtable_br", _id_089688461C79EF11);

  self.pers["gamemodeLoadout"] = level.br_standard_loadout;
  self.class = "gamemode";
  self.prevweaponobj = undefined;
  struct = scripts\mp\class::loadout_getclassstruct();
  struct = scripts\mp\class::loadout_updateclass(struct, "gamemode");
  scripts\mp\class::preloadandqueueclassstruct(struct, 1, 1);
  self takeallweapons();
  scripts\mp\class::giveloadout(self.team, "gamemode", _id_2FEFED9BB7EA82D8, _id_2FEFED9BB7EA82D8);
  self givestartammo(struct.loadoutprimaryobject);

  if(isDefined(struct.loadoutsecondaryobject))
    self givestartammo(struct.loadoutsecondaryobject);

  givelaststandifneeded(self);
  _id_724736FCF0FB6604::br_ammo_player_clear();

  if(istrue(_id_5D3709F813102611)) {
    _id_DBFA241366DD1CDB = _id_724736FCF0FB6604::_id_A2FA56C4E1C77BA9(scripts\mp\utility\weapon::getweapongroup(struct.loadoutprimaryobject));
    _id_724736FCF0FB6604::br_ammo_give_type(self, _id_DBFA241366DD1CDB, weaponclipsize(struct.loadoutprimaryobject));

    if(isDefined(struct.loadoutsecondaryobject)) {
      _id_9551516C6BB95A1B = _id_724736FCF0FB6604::_id_A2FA56C4E1C77BA9(scripts\mp\utility\weapon::getweapongroup(struct.loadoutsecondaryobject));
      _id_724736FCF0FB6604::br_ammo_give_type(self, _id_9551516C6BB95A1B, weaponclipsize(struct.loadoutsecondaryobject));
    }
  }

  if(!istrue(_id_C179E44BD14D2D12) && !istrue(_id_5D3709F813102611))
    _id_724736FCF0FB6604::br_give_starting_ammo();

  _id_724736FCF0FB6604::br_ammo_update_weapons(self);
  self notify("ammo_update");
}

nakeddrophandleloadout() {
  if(istrue(level._id_52BA18A9DC3B6BFD)) {
    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("giveFavoriteLoadout"))
      _id_362C58E8BB39BCDA::runbrgametypefunc("giveFavoriteLoadout");
  } else if(brdoesloadoutoptiongivestandardloadoutimmediately()) {
    _id_2FEFED9BB7EA82D8 = 0;

    if(istrue(self.hasspawnweapons)) {
      return;
    }
    _id_CF45F8EF8ED86B4C = isDefined(self.hasspawnweapons) && !self.hasspawnweapons;

    if(_id_CF45F8EF8ED86B4C)
      _id_2FEFED9BB7EA82D8 = 1;

    loadoutindex = brgetloadoutoptionstandardloadoutindex();
    givestandardtableloadout(loadoutindex, _id_2FEFED9BB7EA82D8);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && getdvarint("dvar_1CA10CA828658CF7", 1) == 1) {
      _id_DC6BF94DBAAA7056 = getdvarint("dvar_34CF7BA2E01ABB6E", 100);
      _id_6DEA1694F5261B36 = getdvarint("dvar_19F5EC6621CA72B3", 0);
      _id_07C40FA80892A721::givestartingarmor(_id_DC6BF94DBAAA7056, undefined, _id_6DEA1694F5261B36);
    }

    if(_id_CF45F8EF8ED86B4C) {
      self.hasspawnweapons = 1;
      return;
    }
  } else if(brdoesloadoutoptionusedropbags())
    givematchloadoutfordropbags();
  else if(brdoesloadoutoptiongivecustomweaponsimmediately()) {
    _id_94C2510160259CC5 = brgetloadoutammomultiplier();
    ammomax = brgetloadoutammomax();
    givematchloadout(_id_94C2510160259CC5, ammomax);
  }
}

_id_3DD2CD5885F42B78() {
  if(!isDefined(level._id_5954867AD88105FA))
    level._id_5954867AD88105FA = getdvarint("dvar_741256D4A75B3E28", 0);

  return level._id_5954867AD88105FA;
}

nakeddrop() {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerDropBonuses"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("playerDropBonuses");

  _id_E97C69489CC1637A = _id_67708F418B1FAC79::gulagwinnerrestoreloadout();

  if(!_id_E97C69489CC1637A && istrue(level.br_prematchstarted) && !istrue(self.gulag)) {
    if(getdvarint("dvar_004799897B190D65", 1)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("backpack", "isBackpackInventoryEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("backpack", "isBackpackInventoryEnabled")]]()) {
        for(_id_A6F8D8115E0F1E79 = 0; _id_A6F8D8115E0F1E79 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(self); _id_A6F8D8115E0F1E79++)
          _id_2D9D24F7C63AC143::_id_DB1DD76061352E5B(_id_A6F8D8115E0F1E79);
      }
    }

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerNakedDropLoadout"))
      _id_362C58E8BB39BCDA::runbrgametypefunc("playerNakedDropLoadout");
    else
      nakeddrophandleloadout();
  }

  if(_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2() && getdvarint("dvar_68A323D5BD07266C", 0) == 1 && !_id_2CEDCC356F1B9FC8::playeriszombie())
    _id_2D9D24F7C63AC143::_id_C2F16E2BBB4E38C0("brloot_nvg");

  thread br_displayperkinfo();
}

loadoutdrop() {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerDropBonuses"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("playerDropBonuses");

  if(istrue(self.isredeploykeepweapons)) {
    self.isredeploykeepweapons = undefined;
    return;
  }

  class = self.class;

  if(istrue(self.initiallandingcomplete) && !istrue(level.giveloadouteverytime)) {
    self.pers["gamemodeLoadout"] = level.br_respawn_loadout;
    class = "gamemode";
  }

  struct = scripts\mp\class::preloadandqueueclass(class, 1);
  thread scripts\mp\class::swaploadout();

  if(class != "gamemode")
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw9_me_fists_mp");

  self.tokenrespawned = 0;

  if(!istrue(self.prematchintiallandingcomplete)) {
    if(istrue(level.giveloadouteverytime))
      brgivestartfieldupgrade();
  }

  self.prematchintiallandingcomplete = 1;

  if(!istrue(self.initiallandingcomplete)) {
    if(istrue(level.br_prematchstarted)) {
      if(istrue(level.giveloadouteverytime))
        brgivestartfieldupgrade();

      self.initiallandingcomplete = 1;
    }
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && getdvarint("dvar_1CA10CA828658CF7", 1) == 1) {
    _id_968BD61837A9C038 = getdvarint("dvar_3C87CCC2C15B53A4", 100);
    _id_381776CAE951DA48 = getdvarint("dvar_8B8E8245086EFDD1", 0);
    _id_07C40FA80892A721::givestartingarmor(_id_968BD61837A9C038, undefined, _id_381776CAE951DA48);
  }

  thread br_displayperkinfo();
}

_id_5357C1261661E9E4(_id_12BFF32D91032009, player, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975) {
  _id_1F0F661B1F135896 = -2400;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  _id_0741196A281686EE = scripts\engine\trace::_id_B88B8BD51EA7FE24();
  contents = contents &~_id_0741196A281686EE;
  _id_8D213E19BB3A154A = 70;
  _id_7AB60AA67D45982F = player.origin - _id_12BFF32D91032009.origin;
  _id_4D339274DA6847D6 = (_id_7AB60AA67D45982F[0], _id_7AB60AA67D45982F[1], 0);
  _id_80385098E14F48C8 = 0;

  if(length2d(_id_4D339274DA6847D6) > 0.001) {
    _id_EC0A3044D861D58E = vectorNormalize(_id_4D339274DA6847D6);
    _id_CD09032C027520D1 = vectortoangles(_id_EC0A3044D861D58E);
    _id_80385098E14F48C8 = angleclamp180(_id_CD09032C027520D1[1]);
  }

  _id_8C4038F0270DE13E = _id_12BFF32D91032009.origin;
  _id_5985D426AA39D205 = (cos(_id_80385098E14F48C8), sin(_id_80385098E14F48C8), 0);
  _id_5985D426AA39D205 = vectorNormalize(_id_5985D426AA39D205);
  _id_5985D426AA39D205 = _id_5985D426AA39D205 * _id_8D213E19BB3A154A;
  result = _id_2CEDCC356F1B9FC8::raytraceoffset(_id_8C4038F0270DE13E, _id_5985D426AA39D205[0], _id_5985D426AA39D205[1], _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, contents, _id_12BFF32D91032009);

  if(result["fraction"] < 1.0) {
    _id_9077C073DEF296AA = result["position"] + (0, 0, 0.001);
    _id_D228F1F35B586E32 = _id_8C4038F0270DE13E + (0, 0, 30);
    _id_C4AFEC3695912ED3 = scripts\engine\trace::ray_trace(_id_D228F1F35B586E32, _id_9077C073DEF296AA, _id_12BFF32D91032009, contents);

    if(_id_C4AFEC3695912ED3["fraction"] >= 1.0) {
      player setOrigin(_id_9077C073DEF296AA);
      return;
    } else {}
  }

  result = _id_2CEDCC356F1B9FC8::raytraceoffset(_id_8C4038F0270DE13E, 0, 0, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, contents);

  if(result["fraction"] < 1.0) {
    _id_74BB7B7C25A2F978 = result["position"] + (0, 0, 0.2);
    _id_CF47C99B295D9D6B = result["position"] + (0, 0, 1);
    _id_1B37FC247C529EE3 = playerphysicstrace(_id_74BB7B7C25A2F978, _id_CF47C99B295D9D6B);

    if(_id_1B37FC247C529EE3 == _id_CF47C99B295D9D6B) {
      player setOrigin(result["position"]);
      return;
    }
  }

  player kill(_id_12BFF32D91032009.origin);
}

_id_ECC9EA2F03ECDD72(player) {
  if(getdvarint("dvar_46568393C6B31535", 1)) {
    if(istrue(player._id_A68533829C9BF898)) {
      player setOrigin(player._id_A68533829C9BF898);
      player._id_A68533829C9BF898 = undefined;
      return 1;
    }
  }

  return 0;
}

brgivestartfieldupgrade() {
  if(level._id_47207B7B330CF8E0) {
    return;
  }
  if(istrue(level.allowsupers)) {
    super = scripts\mp\supers::getcurrentsuper();

    if(isDefined(super)) {
      scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
      return;
    }
  } else
    _id_7E52B56769FA7774::forcegivesuper(self.loadoutbrfieldupgrade);
}

brplayerhudoutlineforteammatessafe(player, _id_6EE5484560EC747C) {
  if(!isDefined(player))
    return 0;

  if(!isalive(player))
    return 0;

  if(istrue(player.gulag))
    return 0;

  if(!isDefined(player.team))
    return 0;

  if(isDefined(_id_6EE5484560EC747C) && _id_6EE5484560EC747C.team != player.team)
    return 0;

  if(isDefined(_id_6EE5484560EC747C) && _id_6EE5484560EC747C == player)
    return 0;

  return 1;
}

brplayerhudoutlineforteammatesupdate(player) {
  if(!isDefined(player) || !isDefined(player._id_3F78C6A0862F9E25) || !isDefined(player.teammateoutlineids)) {
    return;
  }
  _id_96674628376EABA6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](player.team, 1);
  assetname = "outline_nodepth_brplayer" + (player._id_3F78C6A0862F9E25 + 1);
  distmax = getdvarint("dvar_4530F1E48DA9E83A", 1024);
  _id_671BCAFFB2F4070A = squared(distmax);
  _id_CB981010DB503FE6 = brplayerhudoutlineforteammatessafe(player);

  foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6) {
    entnum = _id_F0EA4030349A33D5 getentitynumber();
    _id_29F49A35ACC51689 = _id_CB981010DB503FE6 && brplayerhudoutlineforteammatessafe(_id_F0EA4030349A33D5, player);

    if(_id_29F49A35ACC51689) {
      dist = distancesquared(player.origin, _id_F0EA4030349A33D5.origin);

      if(dist > _id_671BCAFFB2F4070A)
        _id_29F49A35ACC51689 = 0;
    }

    if(!_id_29F49A35ACC51689) {
      if(isDefined(player.teammateoutlineids[entnum])) {
        scripts\mp\utility\outline::outlinedisable(player.teammateoutlineids[entnum], player);
        player.teammateoutlineids[entnum] = undefined;
      }

      continue;
    }

    if(!isDefined(player.teammateoutlineids[entnum]))
      player.teammateoutlineids[entnum] = scripts\mp\utility\outline::outlineenableforplayer(player, _id_F0EA4030349A33D5, assetname, "level_script");
  }
}

brplayerhudoutlineupdatefromnotify(player) {
  player endon("disconnect");

  for(;;) {
    level waittill("update_circle_hide");
    brplayerhudoutlineforteammatesupdate(player);
  }
}

brplayerhudoutlineforteammates(player) {
  player endon("disconnect");

  if(!isDefined(player._id_3F78C6A0862F9E25)) {
    return;
  }
  if(!istrue(level.br_infils_disabled))
    player waittill("infil_jump_done");

  player.teammateoutlineids = [];
  player thread brplayerhudoutlineupdatefromnotify(player);

  for(;;) {
    brplayerhudoutlineforteammatesupdate(player);
    wait 1;
  }
}

initializetweakableoverrides() {
  if(!isDefined(level.tweakablesinitialized))
    thread scripts\mp\tweakables::init();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_br_brloadouts", getmatchrulesdata("brData", "brLoadouts"));
  setdynamicdvar("scr_br_crateDropTimer", getmatchrulesdata("brData", "crateDropTimer"));
  setdynamicdvar("scr_br_infilC130", getmatchrulesdata("brData", "infilC130"));
  setdynamicdvar("scr_br_gulag", getmatchrulesdata("brData", "gulag"));
  setdynamicdvar("scr_br_circleDamageMultiplier", getmatchrulesdata("brData", "circleDamageMultiplier"));
  setdynamicdvar("scr_br_startingWeapon", getmatchrulesdata("brData", "startingWeapon"));
  setdynamicdvar("scr_br_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("br", 1);
  setdynamicdvar("scr_br_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("br", 1);
  setdynamicdvar("scr_br_promode", 0);
  scripts\mp\utility\game::registerlaststandinvulntimerdvar(0);
}

updategametypedvars() {
  _id_0FD32F08E72B657F::updatecommongametypedvars();
  level.numendgame = scripts\mp\utility\dvars::dvarintvalue("numEndGame", 4, 0, 20);
  level.brloadouts = scripts\mp\utility\dvars::dvarintvalue("brLoadouts", 0, 0, 5);
  level.cratedroptimer = scripts\mp\utility\dvars::dvarintvalue("crateDropTimer", 60, 0, 300);
  level.goalenabletimer = scripts\mp\utility\dvars::dvarfloatvalue("goalEnableTimer", 60, 0, 300);
  level.goalmovetimer = scripts\mp\utility\dvars::dvarfloatvalue("goalMoveTimer", 0, 0, 300);
  level.radarendgame = scripts\mp\utility\dvars::dvarfloatvalue("radarEndGame", 1, 0, 1);
  level.usegulag = scripts\mp\utility\dvars::dvarintvalue("gulag", 1, 0, 1);
  level.circledamagemultiplier = scripts\mp\utility\dvars::dvarfloatvalue("circleDamageMultiplier", 1, 0.5, 4);
  level.startingweapon = scripts\mp\utility\dvars::dvarintvalue("startingWeapon", 0, 0, 8);
  level.timetoadd = 30;
}

pickclassbr() {
  class = "";

  if(!istrue(level.br_prematchstarted) && istrue(level.br_prematchffa) && getdvarint("dvar_25AD2925D6075C8F", 0) == 0)
    class = pickprematchrandomloadout();
  else {
    _id_2B838D5CA576AE83 = level.br_loadouts["default"];

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("getDefaultLoadout"))
      _id_2B838D5CA576AE83 = _id_362C58E8BB39BCDA::runbrgametypefunc("getDefaultLoadout");

    self.pers["gamemodeLoadout"] = _id_2B838D5CA576AE83;
    class = "gamemode";
  }

  self.pers["class"] = class;
  return class;
}

_id_20F91635CFFFBDCF() {
  wait 5.0;
  iprintln("Loadout verification starting in 10 seconds.");
  wait 5.0;
  iprintln("5 seconds to start.");
  wait 5.0;
  iprintln("Verification start!");

  for(_id_465DF4A45CDB81BF = 0; _id_465DF4A45CDB81BF < level._id_003DC5C06B446489; _id_465DF4A45CDB81BF++) {
    iprintln("Loadout: " + _id_465DF4A45CDB81BF);
    self.pers["gamemodeLoadout"] = level.prematchloadouts[level.prematchrandomloadout[_id_465DF4A45CDB81BF]];
    self.class = "gamemode";
    scripts\mp\class::preloadandqueueclass(self.pers["class"]);
    scripts\mp\class::swaploadout();
    _id_724736FCF0FB6604::br_ammo_player_max_out();
    wait 5.0;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
    wait 4.0;
  }

  self.pers["gamemodeLoadout"] = level.prematchloadouts[level.prematchrandomloadout[0]];
  self.class = "gamemode";
  scripts\mp\class::preloadandqueueclass(self.pers["class"]);
  scripts\mp\class::swaploadout();
  _id_724736FCF0FB6604::br_ammo_player_max_out();
  iprintln("Verification done!");
}

_id_0788F7C22FA09824() {
  if(self isplayerheadless()) {
    if(self.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"] == "equip_molotov")
      self.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"] = "equip_frag";
  }
}

pickprematchrandomloadout() {
  class = "";

  if(getdvarint("dvar_C7EECED4234B1158", 1)) {
    if(!isDefined(level.prematchrandomloadout)) {
      level.prematchrandomloadout = [];

      for(index = 0; index < level._id_003DC5C06B446489; index++)
        level.prematchrandomloadout[level.prematchrandomloadout.size] = index;

      if(getDvar("dvar_FC5F34B202C7515E") == "" && getdvarint("dvar_8FD5E2FBD99396A4", 0) == 0)
        level.prematchrandomloadout = scripts\engine\utility::array_randomize(level.prematchrandomloadout);

      self.prematchloadoutindex = level._id_003DC5C06B446489 - 2;
    }

    if(!isDefined(self.prematchloadoutindex) || self.prematchloadoutindex < 0 || self.prematchloadoutindex >= level._id_003DC5C06B446489 - 1)
      self.prematchloadoutindex = 0;
    else
      self.prematchloadoutindex++;

    self.pers["gamemodeLoadout"] = level.prematchloadouts[level.prematchrandomloadout[self.prematchloadoutindex]];
    class = "gamemode";
    _id_0788F7C22FA09824();
  } else
    class = "default" + (randomint(10) + 1);

  return class;
}

prematchinitblueprintloadouts() {
  level endon("game_ended");

  while(!isDefined(level.weaponlootmapdata))
    waitframe();

  level.prematchloadouts = [];
  _id_3DC1E231AD1D8FD2 = [];
  _id_3DC1E231AD1D8FD2["classIdxPrimaryArray"] = [];
  _id_3DC1E231AD1D8FD2["classIdxSecondaryArray"] = [];
  table = "classtable:classtable_br_prematch_bp";
  _id_3DC1E231AD1D8FD2 = buildloadoutindices(_id_3DC1E231AD1D8FD2);

  for(_id_FA1AE55F729DDC96 = 0; _id_FA1AE55F729DDC96 < _id_3DC1E231AD1D8FD2["classIdxPrimaryArray"].size; _id_FA1AE55F729DDC96++) {
    _id_F0EC1D955C38855B = _id_3DC1E231AD1D8FD2["classIdxPrimaryArray"][_id_FA1AE55F729DDC96];
    _id_6FBC31E9F6CBE69B = _id_3DC1E231AD1D8FD2["classIdxSecondaryArray"][_id_FA1AE55F729DDC96];
    level.prematchloadouts[level.prematchloadouts.size] = updateprematchloadoutarray(table, _id_F0EC1D955C38855B, _id_6FBC31E9F6CBE69B);
  }
}

buildloadoutindices(_id_3DC1E231AD1D8FD2) {
  _id_7C8FEB9DA40F13A2 = 0;
  _id_7A97CE49E361E991 = 2;
  _id_399CEA81AD587E4D = 2;
  _id_154C735B7D5AC474 = 1;
  _id_A4F11B0B6ADFFAFF = 1;
  _id_6A1D197E7F97F97C = 2;
  _id_0B93DB625CD6F699 = 2;

  for(_id_B125376FE94819E1 = [_id_7A97CE49E361E991, _id_399CEA81AD587E4D, _id_154C735B7D5AC474, _id_A4F11B0B6ADFFAFF, _id_6A1D197E7F97F97C, _id_0B93DB625CD6F699]; _id_7C8FEB9DA40F13A2 < _id_B125376FE94819E1.size; _id_7C8FEB9DA40F13A2++) {
    _id_F8134FCD629EB9DD = 0;
    _id_9B84A81421AAA7DD = 0;
    _id_9EA228BEE6FC0EDE = 5;

    while(_id_F8134FCD629EB9DD < _id_B125376FE94819E1[_id_7C8FEB9DA40F13A2]) {
      _id_8B0CADB1C3ACC65C = giverandomloadoutindex(_id_7C8FEB9DA40F13A2);

      if(!scripts\engine\utility::array_contains(_id_3DC1E231AD1D8FD2["classIdxPrimaryArray"], _id_8B0CADB1C3ACC65C) || _id_9B84A81421AAA7DD >= _id_9EA228BEE6FC0EDE) {
        _id_F8134FCD629EB9DD++;
        _id_9B84A81421AAA7DD = 0;
        _id_3DC1E231AD1D8FD2["classIdxPrimaryArray"][_id_3DC1E231AD1D8FD2["classIdxPrimaryArray"].size] = _id_8B0CADB1C3ACC65C;
        continue;
      }

      _id_9B84A81421AAA7DD++;
    }
  }

  _id_6AE6A640C4C9252B = 0;

  for(_id_8F3618CF7570D373 = 0; _id_8F3618CF7570D373 < _id_3DC1E231AD1D8FD2["classIdxPrimaryArray"].size; _id_8F3618CF7570D373++) {
    if(_id_6AE6A640C4C9252B < 3) {
      if(randomint(4) == 1)
        _id_FC4AAE5CBA71022C = giverandomloadoutindex(6);
      else
        _id_FC4AAE5CBA71022C = giverandomloadoutindex(5);

      _id_6AE6A640C4C9252B++;
    } else
      _id_FC4AAE5CBA71022C = giverandomloadoutindex(7);

    _id_3DC1E231AD1D8FD2["classIdxSecondaryArray"][_id_3DC1E231AD1D8FD2["classIdxSecondaryArray"].size] = _id_FC4AAE5CBA71022C;
  }

  _id_3DC1E231AD1D8FD2["classIdxPrimaryArray"] = scripts\engine\utility::array_randomize(_id_3DC1E231AD1D8FD2["classIdxPrimaryArray"]);
  _id_3DC1E231AD1D8FD2["classIdxSecondaryArray"] = scripts\engine\utility::array_randomize(_id_3DC1E231AD1D8FD2["classIdxSecondaryArray"]);
  return _id_3DC1E231AD1D8FD2;
}

giverandomloadoutindex(index) {
  _id_E98ACF9FA9D0767D = 0;

  switch (index) {
    case 0:
      _id_E98ACF9FA9D0767D = 0 + randomint(10);
      break;
    case 1:
      _id_E98ACF9FA9D0767D = 10 + randomint(7);
      break;
    case 2:
      _id_E98ACF9FA9D0767D = 23 + randomint(5);
      break;
    case 3:
      _id_E98ACF9FA9D0767D = 28 + randomint(8);
      break;
    case 4:
      _id_E98ACF9FA9D0767D = 36 + randomint(6);
      break;
    case 5:
      _id_E98ACF9FA9D0767D = randomint(42);
      break;
    case 6:
      _id_E98ACF9FA9D0767D = 42 + randomint(3);
      break;
    case 7:
      _id_E98ACF9FA9D0767D = 17 + randomint(6);
      break;
    default:
      break;
  }

  return _id_E98ACF9FA9D0767D;
}

updateprematchloadoutarray(table, _id_F0EC1D955C38855B, _id_6FBC31E9F6CBE69B) {
  if(_id_F0EC1D955C38855B == _id_6FBC31E9F6CBE69B) {
    if(_id_6FBC31E9F6CBE69B > 0)
      _id_6FBC31E9F6CBE69B--;
    else
      _id_6FBC31E9F6CBE69B = 1;
  }

  _id_E698DF1EC0933CE4 = [];
  _id_E698DF1EC0933CE4["loadoutArchetype"] = "archetype_assault";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment2"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment3"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment4"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment5"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryCosmeticAttachment"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimarySticker"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimarySticker1"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimarySticker2"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimarySticker3"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondary"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment2"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment3"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment4"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment5"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker1"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker2"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker3"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker4"] = "none";
  _id_E698DF1EC0933CE4["loadoutMeleeSlot"] = "none";
  _id_E698DF1EC0933CE4["loadoutStreakType"] = "assault";
  _id_E698DF1EC0933CE4["loadoutKillstreak1"] = "none";
  _id_E698DF1EC0933CE4["loadoutKillstreak2"] = "none";
  _id_E698DF1EC0933CE4["loadoutKillstreak3"] = "none";
  _id_E698DF1EC0933CE4["loadoutSuper"] = "none";
  _id_E698DF1EC0933CE4["loadoutFieldUpgrade1"] = "none";
  _id_E698DF1EC0933CE4["loadoutFieldUpgrade2"] = "none";
  _id_E698DF1EC0933CE4["tableColumn"] = _id_F0EC1D955C38855B;
  _id_E698DF1EC0933CE4["loadoutPrimaryAddBlueprintAttachments"] = scripts\mp\class::table_getaddblueprintattachments(table, _id_F0EC1D955C38855B, 0);
  _id_E698DF1EC0933CE4["loadoutPrimary"] = scripts\mp\class::table_getweapon(table, _id_F0EC1D955C38855B, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxprimaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "primary");
    _id_E698DF1EC0933CE4[_id_EFBDCD88107AF5F9] = scripts\mp\class::table_getweaponattachment(table, _id_F0EC1D955C38855B, 0, _id_DF6D8E005B4B8020);
  }

  _id_E698DF1EC0933CE4["loadoutPrimaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_F0EC1D955C38855B, 0);
  _id_E698DF1EC0933CE4["loadoutPrimaryReticle"] = scripts\mp\class::table_getweaponreticle(table, _id_F0EC1D955C38855B, 0);
  _id_E698DF1EC0933CE4["loadoutPrimaryVariantID"] = scripts\mp\class::table_getweaponvariantid(table, _id_F0EC1D955C38855B, 0, _id_E698DF1EC0933CE4["loadoutPrimary"]);
  _id_E698DF1EC0933CE4["loadoutSecondaryAddBlueprintAttachments"] = scripts\mp\class::table_getaddblueprintattachments(table, _id_6FBC31E9F6CBE69B, 0);
  _id_E698DF1EC0933CE4["loadoutSecondary"] = scripts\mp\class::table_getweapon(table, _id_6FBC31E9F6CBE69B, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxsecondaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "secondary");
    _id_E698DF1EC0933CE4[_id_EFBDCD88107AF5F9] = scripts\mp\class::table_getweaponattachment(table, _id_6FBC31E9F6CBE69B, 0, _id_DF6D8E005B4B8020);
  }

  _id_E698DF1EC0933CE4["loadoutSecondaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_6FBC31E9F6CBE69B, 0);
  _id_E698DF1EC0933CE4["loadoutSecondaryReticle"] = scripts\mp\class::table_getweaponreticle(table, _id_6FBC31E9F6CBE69B, 0);
  _id_E698DF1EC0933CE4["loadoutSecondaryVariantID"] = scripts\mp\class::table_getweaponvariantid(table, _id_6FBC31E9F6CBE69B, 0, _id_E698DF1EC0933CE4["loadoutSecondary"]);
  _id_E698DF1EC0933CE4["loadoutEquipmentPrimary"] = getrandomprematchequipment("lethal");

  if(scripts\engine\utility::cointoss())
    _id_E698DF1EC0933CE4["loadoutExtraEquipmentPrimary"] = "TRUE";
  else
    _id_E698DF1EC0933CE4["loadoutExtraEquipmentPrimary"] = "FALSE";

  _id_E698DF1EC0933CE4["loadoutEquipmentSecondary"] = getrandomprematchequipment("tactical");

  if(_id_E698DF1EC0933CE4["loadoutEquipmentSecondary"] != "equip_smoke" && scripts\engine\utility::cointoss())
    _id_E698DF1EC0933CE4["loadoutExtraEquipmentSecondary"] = "TRUE";
  else
    _id_E698DF1EC0933CE4["loadoutExtraEquipmentSecondary"] = "FALSE";

  _id_E698DF1EC0933CE4["loadoutPerks"] = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    perk = scripts\mp\class::table_getperk(table, _id_F0EC1D955C38855B, _id_AC0E594AC96AA3A8);

    if(perk != "specialty_null")
      _id_E698DF1EC0933CE4["loadoutPerks"][_id_E698DF1EC0933CE4["loadoutPerks"].size] = perk;
  }

  _id_E698DF1EC0933CE4["loadoutGesture"] = "playerData";
  _id_E698DF1EC0933CE4["loadoutExecution"] = "playerData";
  return _id_E698DF1EC0933CE4;
}

updatex1prematchloadoutarray(table, _id_901E4A7F9EB06EB6) {
  _id_E698DF1EC0933CE4 = [];
  _id_E698DF1EC0933CE4["loadoutArchetype"] = "archetype_assault";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment2"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment3"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment4"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryAttachment5"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimaryCosmeticAttachment"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimarySticker"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimarySticker1"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimarySticker2"] = "none";
  _id_E698DF1EC0933CE4["loadoutPrimarySticker3"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondary"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment2"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment3"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment4"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondaryAttachment5"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker1"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker2"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker3"] = "none";
  _id_E698DF1EC0933CE4["loadoutSecondarySticker4"] = "none";
  _id_E698DF1EC0933CE4["loadoutMeleeSlot"] = "none";
  _id_E698DF1EC0933CE4["loadoutStreakType"] = "assault";
  _id_E698DF1EC0933CE4["loadoutKillstreak1"] = "none";
  _id_E698DF1EC0933CE4["loadoutKillstreak2"] = "none";
  _id_E698DF1EC0933CE4["loadoutKillstreak3"] = "none";
  _id_E698DF1EC0933CE4["loadoutSuper"] = "none";
  _id_E698DF1EC0933CE4["loadoutFieldUpgrade1"] = "none";
  _id_E698DF1EC0933CE4["loadoutFieldUpgrade2"] = "none";
  _id_E698DF1EC0933CE4["tableColumn"] = _id_901E4A7F9EB06EB6;
  _id_E698DF1EC0933CE4["loadoutPrimaryAddBlueprintAttachments"] = scripts\mp\class::table_getaddblueprintattachments(table, _id_901E4A7F9EB06EB6, 0);
  _id_E698DF1EC0933CE4["loadoutPrimary"] = scripts\mp\class::table_getweapon(table, _id_901E4A7F9EB06EB6, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxprimaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "primary");
    _id_E698DF1EC0933CE4[_id_EFBDCD88107AF5F9] = scripts\mp\class::table_getweaponattachment(table, _id_901E4A7F9EB06EB6, 0, _id_DF6D8E005B4B8020);
  }

  _id_E698DF1EC0933CE4["loadoutPrimaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_901E4A7F9EB06EB6, 0);
  _id_E698DF1EC0933CE4["loadoutPrimaryReticle"] = scripts\mp\class::table_getweaponreticle(table, _id_901E4A7F9EB06EB6, 0);
  _id_E698DF1EC0933CE4["loadoutPrimaryVariantID"] = scripts\mp\class::table_getweaponvariantid(table, _id_901E4A7F9EB06EB6, 0, _id_E698DF1EC0933CE4["loadoutPrimary"]);
  _id_E698DF1EC0933CE4["loadoutSecondaryAddBlueprintAttachments"] = scripts\mp\class::table_getaddblueprintattachments(table, _id_901E4A7F9EB06EB6, 1);
  _id_E698DF1EC0933CE4["loadoutSecondary"] = scripts\mp\class::table_getweapon(table, _id_901E4A7F9EB06EB6, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < scripts\mp\class::getmaxsecondaryattachments(); _id_DF6D8E005B4B8020++) {
    _id_EFBDCD88107AF5F9 = scripts\mp\class::getattachmentloadoutstring(_id_DF6D8E005B4B8020, "secondary");
    _id_E698DF1EC0933CE4[_id_EFBDCD88107AF5F9] = scripts\mp\class::table_getweaponattachment(table, _id_901E4A7F9EB06EB6, 1, _id_DF6D8E005B4B8020);
  }

  _id_E698DF1EC0933CE4["loadoutSecondaryCamo"] = scripts\mp\class::table_getweaponcamo(table, _id_901E4A7F9EB06EB6, 1);
  _id_E698DF1EC0933CE4["loadoutSecondaryReticle"] = scripts\mp\class::table_getweaponreticle(table, _id_901E4A7F9EB06EB6, 1);
  _id_E698DF1EC0933CE4["loadoutSecondaryVariantID"] = int(tablelookup(table, 0, "loadoutSecondaryVariantID", _id_901E4A7F9EB06EB6 + 1));
  _id_E698DF1EC0933CE4["loadoutEquipmentPrimary"] = tablelookup(table, 0, "loadoutEquipmentPrimary", _id_901E4A7F9EB06EB6 + 1);

  if(scripts\engine\utility::cointoss())
    _id_E698DF1EC0933CE4["loadoutExtraEquipmentPrimary"] = "TRUE";
  else
    _id_E698DF1EC0933CE4["loadoutExtraEquipmentPrimary"] = "FALSE";

  _id_E698DF1EC0933CE4["loadoutEquipmentSecondary"] = tablelookup(table, 0, "loadoutEquipmentSecondary", _id_901E4A7F9EB06EB6 + 1);

  if(_id_E698DF1EC0933CE4["loadoutEquipmentSecondary"] != "equip_smoke" && scripts\engine\utility::cointoss())
    _id_E698DF1EC0933CE4["loadoutExtraEquipmentSecondary"] = "TRUE";
  else
    _id_E698DF1EC0933CE4["loadoutExtraEquipmentSecondary"] = "FALSE";

  _id_E698DF1EC0933CE4["loadoutPerks"] = [];
  _id_E698DF1EC0933CE4["loadoutGesture"] = "playerData";
  _id_E698DF1EC0933CE4["loadoutExecution"] = "playerData";
  return _id_E698DF1EC0933CE4;
}

getrandomprematchequipment(slot) {
  _id_98FA4B76D957B210 = [];

  if(slot == "lethal")
    _id_98FA4B76D957B210 = ["equip_at_mine", "equip_claymore", "equip_c4", "equip_frag", "equip_molotov", "equip_semtex", "equip_thermite", "equip_throwing_knife", "equip_throwing_knife_fire", "equip_throwing_knife_electric"];
  else if(slot == "tactical")
    _id_98FA4B76D957B210 = ["equip_adrenaline", "equip_concussion", "equip_decoy", "equip_flash", "equip_gas_grenade", "equip_hb_sensor", "equip_smoke", "equip_snapshot_grenade"];
  else {}

  equipment = _id_98FA4B76D957B210[randomint(_id_98FA4B76D957B210.size)];
  return equipment;
}

prematchinitloadouts(table) {
  _id_07D958726E11B327 = scripts\mp\class::_id_DF2933F96D726D71(table);
  level.prematchloadouts = [];
  _id_E5F44E7FDD29ACDD = 0;

  if(getDvar("dvar_FC5F34B202C7515E") != "") {
    _id_D61EA355B2C5B7D5 = strtok(getDvar("dvar_FC5F34B202C7515E"), " ");
    _id_4D4AA257C98F2157 = [];

    for(_id_2613246720524878 = 0; _id_2613246720524878 < _id_D61EA355B2C5B7D5.size; _id_2613246720524878++)
      _id_4D4AA257C98F2157[_id_4D4AA257C98F2157.size] = int(_id_D61EA355B2C5B7D5[_id_4D4AA257C98F2157.size]);

    for(_id_1BA75F00ACFEC3A6 = 0; _id_1BA75F00ACFEC3A6 < _id_4D4AA257C98F2157.size; _id_1BA75F00ACFEC3A6++)
      level.prematchloadouts[level.prematchloadouts.size] = createprematchloadout(_id_4D4AA257C98F2157[_id_1BA75F00ACFEC3A6], table);

    level._id_003DC5C06B446489 = _id_4D4AA257C98F2157.size;
    return;
  } else if(getdvarint("dvar_C7EECED4234B1158", 1)) {
    if(getdvarint("dvar_8FD5E2FBD99396A4", 0) == 1 && getdvarint("dvar_0B1D09189D817146", -1) == -1) {
      _id_E5F44E7FDD29ACDD = 0;
      level._id_003DC5C06B446489 = _id_07D958726E11B327;
    } else {
      _id_E5F44E7FDD29ACDD = int(randomint(_id_07D958726E11B327 - 1) * 0.1) * 10;

      if(getdvarint("dvar_0B1D09189D817146", -1) != -1)
        _id_E5F44E7FDD29ACDD = getdvarint("dvar_0B1D09189D817146", -1);

      _id_07D958726E11B327 = _id_E5F44E7FDD29ACDD + 10;
    }
  }

  for(_id_089688461C79EF11 = _id_E5F44E7FDD29ACDD; _id_089688461C79EF11 < _id_07D958726E11B327; _id_089688461C79EF11++)
    level.prematchloadouts[level.prematchloadouts.size] = createprematchloadout(_id_089688461C79EF11, table);
}

createprematchloadout(_id_089688461C79EF11, table) {
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon._id_59F68715C04CE28F;
  loadout["loadoutPrimaryAttachment2"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutPrimaryAttachment3"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutPrimaryAttachment4"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon._id_59F68215C04CD790;
  loadout["loadoutPrimaryAttachment5"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutPrimaryCamo"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).primaryweapon.reticle;
  loadout["loadoutSecondary"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon._id_59F68715C04CE28F;
  loadout["loadoutSecondaryAttachment2"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutSecondaryAttachment3"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutSecondaryAttachment4"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon._id_59F68215C04CD790;
  loadout["loadoutSecondaryAttachment5"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutSecondaryCamo"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).equipment.primary;
  loadout["loadoutEquipmentSecondary"] = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).equipment._id_D7B9856A19F9B6B5;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).perks._id_16680ABD1742C050, scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).perks._id_16680DBD1742C6E9, scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11).perks._id_16680CBD1742C4B6, scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680ABD1742C050, scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680DBD1742C6E9, scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11)._id_50D0559DCBA571E2._id_16680CBD1742C4B6];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutFieldUpgrade1"] = "none";
  loadout["loadoutFieldUpgrade2"] = "none";
  loadout["tableColumn"] = _id_089688461C79EF11;
  return loadout;
}

defineplayerloadout() {
  level.br_loadouts["default"]["loadoutArchetype"] = "archetype_assault";
  level.br_loadouts["default"]["loadoutPrimary"] = "none";
  level.br_loadouts["default"]["loadoutPrimaryAttachment"] = "none";
  level.br_loadouts["default"]["loadoutPrimaryAttachment2"] = "none";
  level.br_loadouts["default"]["loadoutPrimaryCamo"] = "none";
  level.br_loadouts["default"]["loadoutPrimaryReticle"] = "none";
  level.br_loadouts["default"]["loadoutSecondary"] = "none";
  level.br_loadouts["default"]["loadoutSecondaryAttachment"] = "none";
  level.br_loadouts["default"]["loadoutSecondaryAttachment2"] = "none";
  level.br_loadouts["default"]["loadoutSecondaryCamo"] = "none";
  level.br_loadouts["default"]["loadoutSecondaryReticle"] = "none";
  level.br_loadouts["default"]["loadoutMeleeSlot"] = "iw9_me_fists_mp";
  level.br_loadouts["default"]["loadoutEquipmentPrimary"] = "none";
  level.br_loadouts["default"]["loadoutEquipmentSecondary"] = "none";
  level.br_loadouts["default"]["loadoutStreakType"] = "assault";
  level.br_loadouts["default"]["loadoutKillstreak1"] = "none";
  level.br_loadouts["default"]["loadoutKillstreak2"] = "none";
  level.br_loadouts["default"]["loadoutKillstreak3"] = "none";
  level.br_loadouts["default"]["loadoutSuper"] = "super_br_extract";
  level.br_loadouts["default"]["loadoutPerks"] = ["specialty_null"];
  level.br_loadouts["default"]["loadoutGesture"] = "playerData";
  level.br_loadouts["default"]["loadoutFieldUpgrade1"] = "none";
  level.br_loadouts["default"]["loadoutFieldUpgrade2"] = "none";
  level.br_loadouts["allies"] = level.br_loadouts["default"];
  level.br_loadouts["axis"] = level.br_loadouts["default"];
  level.br_respawn_loadout = level.br_loadouts["default"];
  level.br_respawn_loadout["loadoutSecondary"] = "iw8_pi_golf21";
}

onprecachegametype() {
  level._effect["vfx_gas_ring_player"] = loadfx("vfx/iw8_cp/br_ring/vfx_gas_ring_player.vfx");
  level._effect["vfx_gas_ring_puffy"] = loadfx("vfx/iw8_cp/br_ring/vfx_gas_ring_puffy.vfx");
  level._effect["vfx_br_infil_cloud_scroll"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx");
  level._effect["vfx_br_infil_jump_smoke_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_01"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx");
  level._effect["vfx_br_infil_jump_wisp_02"] = loadfx("vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx");
  level._effect["vfx_gas_mask_break"] = loadfx("vfx/iw8_br/gameplay/vfx_br_gasmask_dest.vfx");
  level._effect["vfx_gameplay_tier2_helmet_pop"] = loadfx("vfx/iw9/gameplay/mp/vfx_gameplay_tier2_helmet_pop.vfx");
  level._effect["vfx_gameplay_tier3_helmet_pop"] = loadfx("vfx/iw9/gameplay/mp/vfx_gameplay_tier3_helmet_pop.vfx");
}

onstartgametype() {
  _id_362C58E8BB39BCDA::runbrgametypefunc("onStartGameTypePre");
  level.blockweapondrops = 1;
  level.customlaststandactionset = "brlaststand";
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910(level.customlaststandactionset, ["usability", "vehicle_use", "crate_use", "ascender_use", "weapon_switch", "weapon_switch_clip", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee", "fire", "show_operator_pet"]);
  level.graceperiod = 3;
  level.ingraceperiod = level.graceperiod;
  level.prematchperiodend = 0;

  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm")
    level.prematchperiodend = getdvarint("dvar_942E15DCD26FB29E", 20);

  _id_2D9D24F7C63AC143::_id_E0948A1E98E82AE1();
  setclientnamemode("auto_change");

  foreach(_id_F90358454413407F in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(_id_F90358454413407F, &"OBJECTIVES/DM");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DM");
    else
      scripts\mp\utility\game::setobjectivescoretext(_id_F90358454413407F, &"OBJECTIVES/DM_SCORE");

    scripts\mp\utility\game::setobjectivehinttext(_id_F90358454413407F, &"OBJECTIVES/DM_HINT");
  }

  initspawns();

  if(!lowpopallowtweaks())
    _id_2695A20D4011076D::initcircle();

  _id_724736FCF0FB6604::br_ammo_init();
  _id_45B2B4A889E633FA::init();
  _id_7E52B56769FA7774::br_pickups_init();
  _id_7E52B56769FA7774::initpickupusability();
  _id_1F6BC044DD1738AB::init();

  if(getdvarint("dvar_E4187D1543C7477E", 0) != 1)
    _id_7502DF3A967E1664::init();

  if(!lowpopallowtweaks()) {
    if(getdvarint("dvar_82BDE055B11E6698", 0))
      _id_3ACF1C0EBAF602F2::init_quest_util();
    else
      thread _id_64ACB6CE534155B7::_id_BF4FD0B5A7C2F528();
  }

  scripts\mp\calloutmarkerping_mp::calloutmarkerping_init();
  _id_552B8E4EA5FF7DF1::brlootcache_init();
  _id_72EB7558D3496DE0::breventsinit();
  _id_337BD370F7C5E6F9::init();
  _id_6731BE38C3B94FF7::init();
  _id_43828ADD0312B6BF::init();
  _id_261E315C49E5E4EF::init();
  _id_600B944A95C3A7BF::init();
  level thread _id_342E51952B63E594::init();
  level.br_pickups.crates = [];
  level.br_pickups.outercrates = [];
  _id_67708F418B1FAC79::initgulag();
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", ::vehicle_compass_br_shouldbevisibletoplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br", "superSlotCleanUp", _id_7E52B56769FA7774::superslotcleanup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br", "challengeEvaluator", _id_43828ADD0312B6BF::challengeevaluator);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "registerCrateForCleanup", ::airdrop_registercrateforcleanup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "brLoadoutCrateFirstActivation", ::airdop_brloadoutcratefirstactivation);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeWeaponFromCrate", ::airdrop_makeweaponfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeItemFromCrate", ::airdrop_makeitemfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "makeItemsFromCrate", ::airdrop_makeitemsfromcrate);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "br_giveDropBagLoadout", ::airdrop_br_givedropbagloadout);
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "brOnLoadoutCrateDestroyed", ::airdrop_bronloadoutcratedestroyed);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gasmask", "breakGasMaskBR", _id_7E52B56769FA7774::breakgasmaskbr);
  scripts\cp_mp\utility\script_utility::registersharedfunc("backpack", "isBackpackInventoryEnabled", _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("backpack", "removeSmallestItemStackBackpack", _id_2D9D24F7C63AC143::_id_51F5AAFA38A37F0F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("backpack", "addItemToBackpackByRef", _id_2D9D24F7C63AC143::_id_9D094FAC5AE6454E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("backpack", "getTotalItemCountInBag", _id_2D9D24F7C63AC143::_id_B4BD198A25085E3E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "calloutMarkerPing_markerAdded", ::_id_1B1C1195E27710B9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br", "isInstancedSpace", ::_id_3DD2CD5885F42B78);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br", "packClientMatchData", ::_id_3AC2A599D142369D);
  scripts\mp\carriable::initcarriables();

  if(_id_3FF084F114B7F6C9::_id_6934349B7823D888()) {
    if(_id_14D3930854CB398C::_id_4DB915A9CE0E903A())
      _id_14D3930854CB398C::init();
  }

  initloot();
  level thread onprematchstarted();
  thread turnofftimer();
  level thread watchprematchdone();
  level thread _id_46AF76764B1FC7F0::brvehiclesonstartgametype();
  _id_439D01E25D19543B::init();
  level._id_E4669B797013D077 = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F("veh9_mil_lnd_mrap");

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    level thread _id_439D01E25D19543B::_id_E456F5964BA54D64();
    _id_4480C6CE37B2BDF3::_id_B52F35A3FF450ECD();
  }

  thread waitandstartparachuteoverheadmonitoring();
  level thread updateplayerlocationcallouts();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_DB908ECACCBE933C);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  scripts\mp\utility\disconnect_event_aggregator::_id_5B91DF923C38392B(::_id_0C11D61293D7E8BA);
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::handleexitsquadeliminatedstate);

  if(scripts\mp\loot::_id_310AB06891CB4517())
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(scripts\mp\loot::_id_E146F016A8A7244F);

  if(_id_6A8EC730B2BFA844::_id_CFF2F4F168B29B81())
    _id_6A8EC730B2BFA844::_id_5A9C4BF10785CE1E();
  else
    _id_6A8EC730B2BFA844::cleanup();

  if(brdoesloadoutoptionusedropbags()) {
    thread _id_4D5A55FCA0ED1835::initdropbagsystem();
    thread cleanupdropbagsoncircle();
  }

  level.killstreakbeginusefunc = ::brkillstreakbeginusefunc;
  _id_72AF5A878A9D3397::start();
  _id_362C58E8BB39BCDA::runbrgametypefunc("onStartGameType");
}

vehicle_compass_br_shouldbevisibletoplayer(vehicle, player) {
  return 1;
}

cleanupmolotovs() {
  grenades = getEntArray("grenade", "classname");

  foreach(grenade in grenades) {
    if(isDefined(grenade) && isDefined(grenade.weapon_name) && grenade.weapon_name == "molotov_mp")
      thread scripts\mp\equipment\molotov::molotov_cleanup_pool(grenade);
  }
}

onprematchfadedone() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  if(!istrue(level.skipprematch)) {
    level thread resetalldoors(2.1);
    level thread scripts\cp_mp\calloutmarkerping::calloutmarkerping_removeallcalloutsforallplayers(1);

    if(scripts\mp\utility\game::getsubgametype() != "dmz")
      level thread _id_46AF76764B1FC7F0::brvehicleonprematchstarted();

    level thread scripts\mp\carriable::clean_and_spawn_carriables();
    _func_ 3E0 EE94A187AE10();
  }

  level thread _id_1F6BC044DD1738AB::onprematchdone();

  if(!istrue(level.skipprematch)) {
    cleanupmolotovs();
    _id_46AF76764B1FC7F0::emptyallvehicles();

    if(!istrue(level.br_infils_disabled)) {
      foreach(player in level.players) {
        if(!istrue(level._id_E4A482EDC1542597)) {
          player setplayerprematchallows();
          player thread _id_7E52B56769FA7774::resetplayerinventory(undefined, 1);
        }

        if(istrue(player.hasspawned)) {
          if(istrue(player.usingascender))
            player scripts\cp_mp\auto_ascender::ascenderinstantstop();

          player thread scripts\mp\weapons::deleteplacedequipment(1);
        }

        if(istrue(level._id_387CD21817428092))
          player setclientomnvar("ui_squad_leader_pack_dropped", 0);
      }
    }

    foreach(player in level.players) {
      if(isDefined(player.burninginfo))
        player scripts\mp\equipment\molotov::molotov_clear_burning();

      player scripts\mp\javelin::javelin_forceclear();
    }

    level notify("prematch_cleanup");
  }

  level.disabledamagestattracking = 0;

  foreach(_id_AC0E594AC96AA3A8, _id_65D040B6FA76F410 in level.br_prematchloot)
  _id_65D040B6FA76F410 setscriptablepartstate(level.br_prematchlootparts[_id_AC0E594AC96AA3A8], "visible");

  level.br_prematchloot = undefined;
  level.br_prematchlootparts = undefined;

  if(!istrue(level.br_circle_disabled))
    level thread _id_2695A20D4011076D::runcircles(1);
}

onprematchstarted() {
  level thread onprematchfadedone();
  _id_7933519955F32C4E::_id_5DF8C6ABD0B861CD();

  if(!istrue(level.skipprematch) && !scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924() && !getdvarint("dvar_1BF2AFD8A32B6892", 0)) {
    foreach(team in level.teamnamelist) {
      setteamradar(team, 1);
      setteamradarstrength(team, 1);
    }
  }

  level waittill("prematch_started");

  if(lowpopallowtweaks()) {
    _id_2695A20D4011076D::initcircle();

    if(getdvarint("dvar_82BDE055B11E6698", 0))
      _id_3ACF1C0EBAF602F2::init_quest_util();
    else
      thread _id_64ACB6CE534155B7::_id_BF4FD0B5A7C2F528();
  }

  if(!istrue(level.skipprematch)) {
    foreach(team in level.teamnamelist) {
      setteamradar(team, 0);
      setteamradarstrength(team, 0);
    }
  }

  if(istrue(level.br_allowloadout) && istrue(level._id_66113AA6FC12BE57))
    setomnvarforallclients("ui_options_menu", 0);

  if(_id_7933519955F32C4E::_id_B4E9D46918F067BB())
    _id_7933519955F32C4E::_id_F5C1889669D23A75();
  else
    scripts\mp\flags::gameflagwait("br_ready_to_jump");

  if(istrue(level._id_BF269015710DE2DD))
    level thread _id_21C19CFC7139D773::_id_DA05E0125FA8BBF4();

  level thread _id_67179FFA48ECB2C9();

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && _id_4F0E283905A1B329::_id_B243F0FD0562BBFB())
    level thread _id_4F0E283905A1B329::_id_05B61A0C37FC3665();

  level thread handlematchscoreboardinfo();

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate"))
    level thread _id_6489FCDFE6FA2E36::spectate_init();

  level.br_prematchstarted = 1;
  level notify("infils_ready");
}

handlematchscoreboardinfo() {
  if(scripts\mp\utility\game::isprophuntgametype()) {
    return;
  }
  scripts\mp\scoreboard::processmatchscoreboardinfo();

  if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::privatematch())
      setclientmatchdata("isPublicMatch", 1);
    else
      setclientmatchdata("isPublicMatch", 0);
  }

  level scripts\engine\utility::waittill_notify_or_timeout("br_c130_left_bounds", 120);
  scripts\mp\scoreboard::processmatchscoreboardinfo();
}

_id_67179FFA48ECB2C9() {
  if(getdvarint("dvar_4C8E33496C92CD2E", 0)) {
    return;
  }
  level endon("game_ended");

  if(!_id_2CEDCC356F1B9FC8::istutorial() && !_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
    if(brdoesloadoutoptionusedropbags() && brareloadoutdropbagsdelayed()) {
      _id_70BCBF0AD5028219 = brgetloadoutdropbagsdelayseconds();
      _id_4D5A55FCA0ED1835::delaydropbags(_id_70BCBF0AD5028219);

      if(_id_362C58E8BB39BCDA::isfeatureenabled("dropBagLoop")) {
        for(;;)
          _id_4D5A55FCA0ED1835::delaydropbags(_id_70BCBF0AD5028219);
      }
    } else if(_id_D27F645C3282A371()) {
      _id_70BCBF0AD5028219 = _id_8209CC6A885E9A2E();
      level thread _id_261E315C49E5E4EF::_id_607167C18661377B(_id_70BCBF0AD5028219);
    }
  }

  level.dropbagstruct = undefined;
}

resetalldoors(_id_74B5B12BB6514385) {
  level endon("game_ended");

  if(isDefined(_id_74B5B12BB6514385))
    wait(_id_74B5B12BB6514385);

  brclosealldoors(50);
}

handleexitsquadeliminatedstate(_id_EA3E3B2121E6713A, _id_E1D097C517C3AF5B) {
  if(isDefined(_id_EA3E3B2121E6713A) && _id_EA3E3B2121E6713A == "exit_squad_eliminated")
    self setclientomnvar("ui_br_squad_eliminated_active", 0);
}

waitandstartparachuteoverheadmonitoring() {
  level endon("game_ended");
  level.activeparachutersfactionvo = [];
  level.activeparachutersfactionvo["uktl"] = "dx_bra_uktl_respawning_enemy_in_area";
  level.activeparachutersfactionvo["rutl"] = "dx_bra_rutl_respawning_enemy_in_area";
  level.parachuteoverheadwarningtimeoutms = getdvarint("dvar_BA0B665C109648FD", 45000);
  level.parachuteoverheadwarningprematchtimeoutms = getdvarint("dvar_BFBF97A63D9482CC", 20000);
  level.parachuteoverheadwarningradius = getdvarint("dvar_898325E4EE88D57F", 2000);
  level.parachuteoverheadwarningheight = getdvarint("dvar_019F16B7BFEA9D46", 3000);
  level thread watchparachutersoverhead(level.parachuteoverheadwarningprematchtimeoutms);
  scripts\mp\flags::gameflagwait("prematch_done");
  level notify("cancel_watch_parachuters_overhead");
  waitframe();
  level thread watchparachutersoverhead(level.parachuteoverheadwarningtimeoutms);
}

watchparachutersoverhead(_id_2B029FE0E94CB290) {
  level endon("game_ended");
  level endon("cancel_watch_parachuters_overhead");

  for(;;) {
    foreach(xuid, player in level.activeparachuters) {
      if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player) || !(player isparachuting() || player isinfreefall())) {
        level.activeparachuters[xuid] = undefined;
        continue;
      }

      _id_78122E18403A8DC4 = scripts\common\utility::playersincylinder(player.origin, level.parachuteoverheadwarningradius, undefined, level.parachuteoverheadwarningheight);
      _id_55B4FA124C5108FF = player.team;

      foreach(targetplayer in _id_78122E18403A8DC4) {
        if(isDefined(targetplayer.c130)) {
          continue;
        }
        _id_8B1B7044E27E6A56 = _id_55B4FA124C5108FF == targetplayer.team;

        if(_id_8B1B7044E27E6A56) {
          continue;
        }
        _id_CDA71AEC07AAB082 = !scripts\mp\utility\player::isreallyalive(targetplayer) || istrue(targetplayer.inlaststand);

        if(_id_CDA71AEC07AAB082) {
          continue;
        }
        _id_744496CCCBBFCB78 = targetplayer isparachuting() || targetplayer isinfreefall();

        if(_id_744496CCCBBFCB78) {
          continue;
        }
        time = gettime();
        _id_008EDFF54C680323 = isDefined(targetplayer.heardparachuteoverheadtime) && time - targetplayer.heardparachuteoverheadtime < _id_2B029FE0E94CB290;

        if(_id_008EDFF54C680323) {
          continue;
        }
        targetplayer.heardparachuteoverheadtime = time;

        if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
          _id_95CE4F91D0F58568 = _id_2CEDCC356F1B9FC8::brgetoperatorteam(targetplayer);

          if(!isDefined(_id_95CE4F91D0F58568))
            _id_95CE4F91D0F58568 = "allies";

          _id_7570AFA45D86040F = game["voice"][_id_95CE4F91D0F58568];
          targetplayer queuedialogforplayer(level.activeparachutersfactionvo[_id_7570AFA45D86040F], "respawning_enemy_in_area", 2);
          continue;
        }

        _id_2CEDCC356F1B9FC8::brleaderdialog("respawning_enemy_in_area", 1, [targetplayer]);
      }

      waitframe();
    }

    waitframe();
  }
}

updateplayerlocationcallouts() {
  level endon("game_ended");
  level.calloutglobals.calloutzones = getEntArray("location_volume", "targetname");

  if(!level.calloutglobals.calloutzones.size) {
    return;
  }
  for(;;) {
    _id_2F04EB838CE020DC = 0;

    foreach(player in level.players) {
      if(!isPlayer(player) || !isalive(player)) {
        continue;
      }
      if(isDefined(player.br_currentcalloutzone) && player istouching(player.br_currentcalloutzone)) {
        continue;
      }
      isinzone = 0;

      foreach(_id_7FCBFFDAC2386D7D in level.calloutglobals.calloutzones) {
        if(player istouching(_id_7FCBFFDAC2386D7D)) {
          isinzone = 1;
          player.br_currentcalloutzone = _id_7FCBFFDAC2386D7D;
          player scripts\mp\callouts::setplayercalloutarea(_id_7FCBFFDAC2386D7D.script_noteworthy);
          player thread _id_362C58E8BB39BCDA::runbrgametypefunc("onEnterCalloutArea", _id_7FCBFFDAC2386D7D.script_noteworthy);
          break;
        }
      }

      if(!isinzone) {
        player.br_currentcalloutzone = undefined;
        player scripts\mp\callouts::setplayercalloutarea("none");
      }

      _id_2F04EB838CE020DC = (_id_2F04EB838CE020DC + 1) % 2;

      if(_id_2F04EB838CE020DC == 0)
        waitframe();
    }

    waitframe();
  }
}

_id_0CDA409F3A76DAC5() {
  _id_B68065A3DB843DD9 = getdvarint("scr_drop_on_death_version", 4);
  level._id_A2ED7C61B6DA2D72 = getdvarint("dvar_EECDEA7818A7FE27", 1) == 1;

  switch (_id_B68065A3DB843DD9) {
    case 0:
      level._id_51225D738094457D = 0;
      level._id_AA5679EBF3504E13 = 1;
      level._id_A3499C286AC570E4 = 1;
      level._id_04BC57EBFFEE174B = 0;
      break;
    case 1:
      level._id_51225D738094457D = 1;
      level._id_AA5679EBF3504E13 = 1;
      level._id_A3499C286AC570E4 = 1;
      level._id_04BC57EBFFEE174B = 0;
      level._id_A1AAB37EC3423E39 = getdvarint("dvar_03F8E6E632099C5F", 1);
      break;
    case 2:
      level._id_51225D738094457D = 0;
      level._id_AA5679EBF3504E13 = 1;
      level._id_A3499C286AC570E4 = 1;
      level._id_04BC57EBFFEE174B = 1;
      break;
    case 3:
      level._id_51225D738094457D = 0;
      level._id_AA5679EBF3504E13 = 0;
      level._id_A3499C286AC570E4 = 0;
      level._id_04BC57EBFFEE174B = 0;
      break;
    case 4:
      level._id_51225D738094457D = 1;
      level._id_AA5679EBF3504E13 = 0;
      level._id_A3499C286AC570E4 = 0;
      level._id_04BC57EBFFEE174B = 0;
      level._id_813B4B2211FBAF1D = 1;
      break;
    case 5:
      level._id_51225D738094457D = 0;
      level._id_AA5679EBF3504E13 = 1;
      level._id_A3499C286AC570E4 = 1;
      level._id_04BC57EBFFEE174B = 0;
      level._id_73DC8CB1481E4A36 = 1;
      level._id_4CA052423B9BB316 = 1;
      break;
    default:
      level._id_51225D738094457D = 0;
      level._id_AA5679EBF3504E13 = 1;
      level._id_A3499C286AC570E4 = 1;
      level._id_04BC57EBFFEE174B = 0;
      break;
  }
}

getusingproxdoors() {
  return 0;
}

watchprematchdone() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level notify("br_prematchEnded");
  totalplayers = scripts\mp\utility\game::getlivingplayers();
  level.totalplayers = totalplayers.size;
  startingteamcount = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount") > 0)
      startingteamcount++;
  }

  level.startingteamcount = max(1, startingteamcount);
  level.prematchendtime = gettime();
  level.recordfinalkillcam = 1;
  level.ignorescoring = 0;
  level.disableweaponstats = 0;
  level.disablestattracking = 0;
  level.prematchaddkillfunc = undefined;
  level.challengesdisabled = 0;
  brclearscoreboardstats();

  if(getdvarint("scr_br_voice_proxy_enabled", 0) == 1) {
    setDvar("voice_proximity_enemy", 1);
    setDvar("dvar_58A078A367C02AB3", 1);
  } else
    setDvar("voice_proximity_enemy", 0);

  foreach(player in level.players)
  player resetchallengetimers();

  if(!_id_362C58E8BB39BCDA::isfeatureenabled("allowLateJoiners")) {
    level.allowlatecomers = 0;
    setnojiptime(1, 1);
    setnojipscore(1, 1);
  }

  brmatchstarted();
  setomnvar("scriptable_loot_hide", 0);
  level notify("scriptable_loot_hide_off");

  foreach(player in level.players) {
    player setclientdvar("ui_opensummary", 1);

    if(isalive(player)) {
      player.health = player.maxhealth;
      player scripts\cp_mp\challenges::startchallengetimer("alive_not_downed");
    }
  }

  _id_715028F54BAD19A1::branalytics_playercount(totalplayers.size);
  level setplacementxpshare();

  if(getdvarint("dvar_1295AA08E53FC39D", 0) == 0)
    removeallcorpses();

  if(getdvarint("dvar_3D82B17BAC600216", 1) == 1)
    _func_ CEA1D94B4418BCC();
}

turnofftimer() {
  wait 1;
  setomnvar("ui_match_timer_hidden", 1);
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

initprematchspawnlocations() {
  if(!_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
    level.startingspawns = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");

    if(level.startingspawns.size == 0)
      level.startingspawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");

    level.prematchspawnorigins = getprematchlocationspawnorigins();

    if(level._id_6BED852A909E4F70 == 1) {
      arenas = scripts\engine\utility::getStructArray("gulag_dom", "targetname");

      if(isDefined(arenas) && arenas.size > 0) {
        foreach(arena in arenas) {
          _id_BB81957D1AE1CF3A = scripts\engine\utility::getStructArray(arena.target, "targetname");

          foreach(_id_BDF25D8A73FF7DAD in _id_BB81957D1AE1CF3A) {
            if(_id_BDF25D8A73FF7DAD.script_noteworthy == "gulag_dom_prematch_spawn")
              level.prematchspawnorigins[0].origin = _id_BDF25D8A73FF7DAD.origin;
          }
        }

        return;
      }
    } else if(level._id_6BED852A909E4F70 == 2) {
      if(_id_0B0385BB45379222::_id_9005AF34E01BF8FE())
        level.prematchspawnorigins[0].origin = (-1880, -640, 430);
    }
  }
}

_id_6E4F8E741562E931() {
  for(;;) {
    if(isDefined(level.prematchspawnorigins)) {
      foreach(location in level.prematchspawnorigins) {
        [minradius, radius] = getprematchradius(location);

        if(minradius > 0) {}
      }
    }

    waitframe();
  }
}

usedropspawn() {
  _id_18B417329DC24BF0 = getdvarint("dvar_03F36284B49B3D7A", 0) != 0;
  return (!istrue(level.br_prematchstarted) || istrue(level.br_allowdropspawnafterprematch)) && !istrue(level.skipprematchdropspawn) && !_id_18B417329DC24BF0 && !istrue(level.infilcinematicactive);
}

getspawnpoint(_id_6039638FD494A229) {
  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm")
    return _id_4480C6CE37B2BDF3::getspawnpoint();

  if(scripts\mp\utility\game::getsubgametype() == "rumble_mgl")
    return _id_070B5255E06B3968::_id_D873616665B0F13E();

  if(isDefined(self.prespawnspawn)) {
    spawnpoint = self.prespawnspawn;
    self.prespawnspawn = undefined;
    return spawnpoint;
  }

  if(isDefined(self.initialprespawn)) {
    spawnpoint = self.initialprespawn;
    return spawnpoint;
  }

  _id_F423081B135E1C9F = scripts\mp\flags::gameflagexists("prematch_done") && scripts\mp\flags::gameflag("prematch_done");

  if(!isDefined(level.prematchspawnorigins) && !_id_F423081B135E1C9F)
    initprematchspawnlocations();

  if(istrue(_id_6039638FD494A229) || usedropspawn()) {
    _id_C40592D1D3225AC7 = (0, randomintrange(0, 360), 0);
    dropstruct = getprematchspawnorigin();
    [minradius, radius] = getprematchradius(dropstruct);
    _id_553AA30EFC389CB5 = randomfloatrange(minradius, radius);

    if(isDefined(level._id_4C124F424CDFA325) && level._id_4C124F424CDFA325 > -1)
      _id_553AA30EFC389CB5 = level._id_4C124F424CDFA325;

    if(getdvarint("dvar_8B70BEE2041ED89D", 0) == 1) {
      _id_352CCE1AFCDAA37D = vectortoangles(dropstruct.origin);
      _id_C40592D1D3225AC7 = (0, _id_352CCE1AFCDAA37D[1], 0) * -1;
      _id_553AA30EFC389CB5 = radius;
    }

    _id_6C3DA2DAFC41D197 = anglesToForward(_id_C40592D1D3225AC7) * -1;
    _id_CB86F09E852A6445 = _id_6C3DA2DAFC41D197 * _id_553AA30EFC389CB5;
    _id_51C508B23EF96D39 = dropstruct.origin + _id_CB86F09E852A6445;

    if(isDefined(self.setspawnpoint)) {
      _id_AD3758FD3576AE97 = _id_0930A1E7BD882C1D::getinfilspawnoffset();
      _id_51C508B23EF96D39 = self.setspawnpoint.playerspawnpos + (0, 0, _id_AD3758FD3576AE97);
      _id_C40592D1D3225AC7 = self.setspawnpoint.playerspawnangles;
      scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(0, 1);
    }

    spawnpoint = spawnStruct();
    spawnpoint.origin = _id_51C508B23EF96D39;
    spawnpoint.angles = _id_C40592D1D3225AC7;
    spawnpoint.index = -1;
    return spawnpoint;
  }

  spawnpoints = level.startingspawns;
  spawnpoint = scripts\mp\spawnlogic::getspawnpoint_random(spawnpoints);

  if(!isDefined(spawnpoint)) {
    spawnpoint = spawnStruct();
    spawnpoint.origin = (0, 0, 0);
    spawnpoint.angles = (0, 0, 0);
    spawnpoint.index = -1;
  }

  return spawnpoint;
}

createspawnlocation(origin, minradius, _id_5991EF3EA72A6543) {
  loc = spawnStruct();
  loc.origin = origin;
  loc.minradius = minradius;
  loc.radius = _id_5991EF3EA72A6543;
  return loc;
}

getprematchlocationspawnorigins() {
  _id_115964AEA2202001 = 0;
  _id_95BEA949F8FC8A68 = scripts\engine\utility::getStructArray("br_prematch_insertion_point", "targetname");
  _id_402E8B8D0E252DB6 = getdvarint("dvar_500929CF224E1D03", 0);

  if(_id_402E8B8D0E252DB6) {
    _id_A055CD5EA13FAA2C = getdvarvector("dvar_15FAB3C9C51CA75E", (0, 0, 0));
    _id_13AF2A3F5D343CE4 = getdvarint("dvar_D7079D5A45600C6A", 0);
    _id_95BEA949F8FC8A68 = [createspawnlocation(_id_A055CD5EA13FAA2C, 0, _id_13AF2A3F5D343CE4)];
  } else if(isDefined(level.br_prematchspawnlocations)) {
    _id_115964AEA2202001 = 1;
    _id_95BEA949F8FC8A68 = level.br_prematchspawnlocations;
  } else if(!_id_95BEA949F8FC8A68.size) {
    _id_115964AEA2202001 = 1;
    _id_95BEA949F8FC8A68 = getEntArray("vehicle_volume", "script_noteworthy");
  }

  foreach(location in _id_95BEA949F8FC8A68) {
    location.groundorigin = location.origin;

    if(!isDefined(location.radius))
      location.radius = 5000;

    if(!isDefined(location.minradius))
      location.minradius = 500;
  }

  _id_504A04C57A458DD1 = getdvarint("scr_br_maxprematchlocations", 5);

  if(isDefined(level._id_2F78F22EDF92FAA9) && level._id_2F78F22EDF92FAA9 < _id_504A04C57A458DD1)
    _id_504A04C57A458DD1 = level._id_2F78F22EDF92FAA9;

  if(_id_504A04C57A458DD1 > 0 && _id_504A04C57A458DD1 < _id_95BEA949F8FC8A68.size)
    _id_95BEA949F8FC8A68 = scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(_id_95BEA949F8FC8A68), 0, _id_504A04C57A458DD1);

  foreach(location in _id_95BEA949F8FC8A68) {
    if(_id_115964AEA2202001) {
      location.origin = getoffsetspawnorigin(location.origin);
      continue;
    }

    _id_3C590B0EE220AFA3 = getoffsetspawnorigin(location.origin)[2];

    if(location.origin[2] < _id_3C590B0EE220AFA3)
      location.origin = (location.origin[0], location.origin[1], _id_3C590B0EE220AFA3);
  }

  return _id_95BEA949F8FC8A68;
}

_id_CB40F77C51717EA1() {
  return 5;
}

getoffsetspawnorigin(origin, _id_A6427A6A24F058DC) {
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  _id_5985D426AA39D205 = (0, 0, 5000);
  tracestart = origin + _id_5985D426AA39D205;
  _id_8B39E5984DA1FFAF = origin - _id_5985D426AA39D205;
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, _id_FBCABD62B8F66EB8);
  _id_8721071772476C47 = origin;

  if(trace["hittype"] != "hittype_none")
    _id_8721071772476C47 = trace["position"];

  if(!isDefined(_id_A6427A6A24F058DC)) {
    zoffset = _id_0930A1E7BD882C1D::getinfilspawnoffset();
    _id_A6427A6A24F058DC = (0, 0, zoffset);
  }

  return _id_8721071772476C47 + _id_A6427A6A24F058DC;
}

getoffsetspawnoriginmultitrace(origin, _id_A6427A6A24F058DC) {
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  _id_084D0C3E36ADDFA4 = 5000;
  _id_191EBD2DD0D5F975 = 5000;
  groundorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(origin, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, _id_FBCABD62B8F66EB8);

  if(!isDefined(_id_A6427A6A24F058DC)) {
    zoffset = _id_0930A1E7BD882C1D::getinfilspawnoffset();
    _id_A6427A6A24F058DC = (0, 0, zoffset);
  }

  return groundorigin + _id_A6427A6A24F058DC;
}

getexpectednumberofteams() {
  _id_7F494A77CF41CCB7 = int(150 / level.maxteamsize);
  return _id_7F494A77CF41CCB7;
}

getprematchspawnorigin() {
  if(!isDefined(level.prematchspawnoriginsforteams)) {
    level.prematchspawnoriginsforteams = [];
    level.prematchspawnoriginnextidx = randomint(level.prematchspawnorigins.size);
    level.prematchspawnoriginteamcount = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.prematchspawnorigins.size; _id_AC0E594AC96AA3A8++)
      level.prematchspawnoriginteamcount[_id_AC0E594AC96AA3A8] = 0;
  }

  if(!isDefined(level.prematchspawnoriginsforteams[self.sessionteam])) {
    level.prematchspawnoriginsforteams[self.sessionteam] = level.prematchspawnorigins[level.prematchspawnoriginnextidx];
    level.prematchspawnoriginteamcount[level.prematchspawnoriginnextidx]++;
    _id_8158644CA35340A1 = scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73();

    if(_id_8158644CA35340A1)
      level.prematchspawnoriginnextidx = (level.prematchspawnoriginnextidx + 1) % level.prematchspawnorigins.size;
    else {
      _id_51FEBE69A426F521 = getexpectednumberofteams();
      _id_EC868D5A67804395 = int(_id_51FEBE69A426F521 / level.prematchspawnorigins.size);

      if(level.prematchspawnoriginteamcount[level.prematchspawnoriginnextidx] >= _id_EC868D5A67804395)
        level.prematchspawnoriginnextidx = (level.prematchspawnoriginnextidx + 1) % level.prematchspawnorigins.size;
    }
  }

  spawnorigin = level.prematchspawnoriginsforteams[self.sessionteam];
  _id_DE8CE87F4113A890 = getdvarint("dvar_DA9368D09CDD8075", -1);

  if(_id_DE8CE87F4113A890 >= 0 && _id_DE8CE87F4113A890 < level.prematchspawnorigins.size)
    spawnorigin = level.prematchspawnorigins[_id_DE8CE87F4113A890];

  return spawnorigin;
}

onplayerconnect(player) {
  level endon("game_ended");
  player endon("disconnect");

  if(scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm" && !level._id_EC2FB549B15AD827)
    player scripts\mp\validation::_id_F6D25A34B1D286B1();

  if(level._id_58ADCE74179AB9EF)
    player scripts\mp\utility\stats::initpersstat("objectivesCompleted");

  player.needtoplayintro = undefined;
  player.br_infil_type = undefined;
  player.equipment = [];
  player._id_D2DBB2FA012E6D9C = [];
  player.br_isplayerbeforeinitialinfildeploy = 1;

  if(istrue(level._id_9A849908E60B857C)) {
    player.pers["perkPackageTier3State"] = 2;
    player.pers["perkPackageTier2Earned"] = 1;
  }

  _id_2D9D24F7C63AC143::_id_B4F4561FDB86FA25(player);
  player thread _id_2D9D24F7C63AC143::_id_631FD0855C653A68(player, 1);
  player thread _id_724736FCF0FB6604::br_ammo_player_init();
  player thread _id_70F8C085C6BDE77E::_id_210B4D286FEAE145();

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerWelcomeSplashes"))
    player thread _id_362C58E8BB39BCDA::runbrgametypefunc("playerWelcomeSplashes");
  else
    player thread playerwelcomesplashes();

  player resetchallengetimers();

  if(_id_2D9D24F7C63AC143::_id_720D227D0E55A960())
    _id_2391409EF7B431E1::_id_941FE2B16D6FFF9D(player);

  _id_362C58E8BB39BCDA::runbrgametypefunc("onPlayerConnect", player);

  if(isDefined(player) && player _meth_8420670EAFC8D391()) {
    if(!isDefined(level._id_C5877DBE60FDDBF6))
      level._id_C5877DBE60FDDBF6 = [];

    level._id_C5877DBE60FDDBF6[level._id_C5877DBE60FDDBF6.size] = player;
    player._id_58C7D0139E08B036 = player getentitynumber();
    player thread _id_67708F418B1FAC79::_id_7959E2DF2CC7C5B4();
    player thread _id_548072087C9FD504::_id_D2F9149ADFA20419();
  }

  if(isDefined(player) && _id_3FF084F114B7F6C9::_id_6934349B7823D888() && scripts\mp\utility\game::getsubgametype() != "dmz" && getdvarint("dvar_E57FC6A3EC1C560B", 1))
    player thread _id_A0394891C6CB41A5();

  if(isDefined(player) && scripts\common\utility::_id_A10967D736DC56E5()) {
    if(!isDefined(level.difficultytype))
      level _id_48814951E916AF89::_id_C8393014DD7F8AB6();

    player.gameskill = _id_53DA3333B83B3527::get_gameskill();
    player _id_53DA3333B83B3527::set_difficulty_from_locked_settings();
    player.owner = undefined;
    scripts\engine\utility::flag_wait("level_stealth_initialized");

    while(!isDefined(player.team))
      waitframe();

    player scripts\stealth\player::main();
  }

  if(isDefined(level._id_E3AC672A3513883F))
    player[[level._id_E3AC672A3513883F]]();

  if(!istrue(level.prematchstarted)) {
    player.radarmode = "slow_radar";
    level waittill("prematch_started");
    wait 1.4;
  }

  if(!isDefined(player.streakdata))
    waittillframeend;

  if(isDefined(player)) {
    if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() && !_id_2CEDCC356F1B9FC8::istutorial() && !_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && !scripts\mp\utility\game::isprophuntgametype()) {
      if(!istrue(level.skipprematch)) {
        if(scripts\mp\utility\game::getsubgametype() != "dmz")
          player _id_724736FCF0FB6604::br_ammo_player_clear();

        if(scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm")
          player _id_7E52B56769FA7774::resetplayerinventory(0, 1);
      }

      player scripts\cp_mp\utility\game_utility::startkeyearning();
    }

    if(_id_E88EA7C360EA7FDF() && !_id_2CEDCC356F1B9FC8::istutorial() && !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() && !scripts\mp\utility\game::isprophuntgametype())
      player thread monitorweaponswitchbr();

    player.radarmode = "normal_radar";

    if(getdvarint("dvar_82BDE055B11E6698", 0))
      _id_3ACF1C0EBAF602F2::onplayerconnect(player);
    else
      _id_64ACB6CE534155B7::onplayerconnect(player);

    if(scripts\mp\utility\game::getsubgametype() != "dmz")
      initializeaardata(player);

    player _id_67708F418B1FAC79::_id_DD93503CF95B6277();
  }
}

_id_E88EA7C360EA7FDF() {
  switch (scripts\mp\utility\game::getsubgametype()) {
    case "kingslayer":
    case "plunder":
    case "dmz":
      return 0;
  }

  return 1;
}

playerwelcomesplashes() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;

  if(!istrue(game["liveLobbyCompleted"])) {}

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");
    _id_31C5DAC60B438208 = self isonground() || self _meth_E40102956C887F7C() || self _meth_415FE9EECA7B2E2B();
    _id_A2B5F51A86D266AD = self isonladder();
    binvehicle = self _meth_793F941D7DFF15ED();

    while(!_id_31C5DAC60B438208 && !_id_A2B5F51A86D266AD && !binvehicle)
      waitframe();
  } else
    level waittill("prematch_done");

  _id_715028F54BAD19A1::branalytics_landing(self);
  wait 1;
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective", self, 0);
  _id_AD8C1E6228A10058();
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self notify("br_spawned");
  _id_9E83064E74FA428C = istrue(self.gulag) || scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm";
  _id_7E52B56769FA7774::initplayer(_id_9E83064E74FA428C);
  _id_1F6BC044DD1738AB::initplayer(_id_9156B53BCF7CE573);

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate"))
    _id_6489FCDFE6FA2E36::initplayer();

  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  self.healthregendisabled = 0;
  self.needtoplayintro = undefined;
  self.gunnlessweapon = undefined;
  self.brdownedbyairstriketime = undefined;

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("waitLoadoutDone"))
    thread waitloadoutdone(_id_9156B53BCF7CE573);

  level.superdelay = 0;
  level.superpointsmod = 1;

  if(level.parachutecancutautodeploy)
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(level.parachutecancutparachute)
    self skydive_cutparachuteon();
  else
    self skydive_cutparachuteoff();

  if(getdvarint("dvar_621CA7153D2B5C1D", 0) > 0)
    level thread brplayerhudoutlineforteammates(self);

  _id_2CEDCC356F1B9FC8::setplayerdownedextrainfo(0);
  _id_2CEDCC356F1B9FC8::setplayerbeingrevivedextrainfo(0);
  updatesquadmemberlaststandreviveprogress(self, self, 0, 1);

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("onSpawnPlayer"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("onSpawnPlayer");

  thread _id_467380E90C7DB5A7();

  if(getdvarint("bg_bristotallynormal", 0) && getdvarint("dvar_DC29833577096D47", 0))
    thread _id_7AEC3C7A702AEC62();

  level thread updateplayerandteamcountui();
}

waittill_return(_id_12E3586B64301806, ent) {
  if(_id_12E3586B64301806 != "death")
    self endon("death");

  ent endon("die");
  self waittill(_id_12E3586B64301806, location, angle);
  ent notify("returned", location, angle, _id_12E3586B64301806);
}

waittill_confirm_or_cancel(_id_12E3586B64301806, _id_9BA4FCFEB48763BA, _id_0CD73FF319D57C07) {
  if((!isDefined(_id_12E3586B64301806) || _id_12E3586B64301806 != "death") && (!isDefined(_id_9BA4FCFEB48763BA) || _id_9BA4FCFEB48763BA != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_12E3586B64301806))
    childthread waittill_return(_id_12E3586B64301806, ent);

  if(isDefined(_id_9BA4FCFEB48763BA))
    childthread waittill_return(_id_9BA4FCFEB48763BA, ent);

  if(isDefined(_id_0CD73FF319D57C07))
    childthread waittill_return(_id_0CD73FF319D57C07, ent);

  ent waittill("returned", location, angle, string);
  ent notify("die");
  _id_6E586A99FA56A20F = spawnStruct();
  _id_6E586A99FA56A20F.location = location;
  _id_6E586A99FA56A20F.angles = angle;
  _id_6E586A99FA56A20F.string = string;
  return _id_6E586A99FA56A20F;
}

traceselectedmaplocation(location) {
  _id_5883D53023334465 = location + (0, 0, 10000);
  _id_3CB14AEA5687B8F6 = location - (0, 0, 10000);
  _id_F590BCBAFFB210C5 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
  _id_D4C559B594AD3DF9 = level.activekillstreaks;
  _id_B9D5783A4F34EFBC = scripts\engine\utility::array_combine(_id_F590BCBAFFB210C5, _id_D4C559B594AD3DF9);
  contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
  return scripts\engine\trace::ray_trace(_id_5883D53023334465, _id_3CB14AEA5687B8F6, _id_B9D5783A4F34EFBC, contentoverride, 0, 1);
}

giveprematchloadout() {
  self endon("death_or_disconnect");

  if(!istrue(level.br_prematchffa)) {
    return;
  }
  if(isDefined(level._id_B89A535236A6F3D8) && !istrue(level._id_8281A47E2CECB257))
    self[[level._id_B89A535236A6F3D8]]();
}

_id_B89A535236A6F3D8() {
  _id_7CDE6FD13210763D = getdvarint("dvar_9A965C244B485A82", 0) == 1;

  if(!_id_7CDE6FD13210763D)
    thread scripts\mp\class::loadout_clearperks(undefined, 1);

  waitframe();

  if(!level.allowsupers && !istrue(level.giveloadouteverytime) && !level._id_47207B7B330CF8E0) {
    _id_7E52B56769FA7774::resetsuper();
    _id_7E52B56769FA7774::forcegivesuper("super_ammo_drop", 0);
  }
}

givematchloadout(_id_94C2510160259CC5, ammomax) {
  if(!isDefined(_id_94C2510160259CC5))
    _id_94C2510160259CC5 = 0.5;

  if(!isDefined(ammomax))
    ammomax = 20;

  player = self;
  _id_DDFACDF2215C052E = player scripts\mp\class::loadout_getorbuildclassstruct(player.class);

  if(!isDefined(_id_DDFACDF2215C052E)) {
    return;
  }
  player.prevweaponobj = undefined;
  player scripts\mp\class::loadout_clearperks();
  player scripts\mp\class::loadout_updateplayerperks(_id_DDFACDF2215C052E);
  givelaststandifneeded(player);
  _id_9B82C9CD52FE9E6B = 0;

  if(isDefined(_id_DDFACDF2215C052E.loadoutsecondaryobject) && !isnullweapon(_id_DDFACDF2215C052E.loadoutsecondaryobject)) {
    _id_724736FCF0FB6604::br_forcegivecustomweapon(player, _id_DDFACDF2215C052E.loadoutsecondaryobject, _id_DDFACDF2215C052E.loadoutsecondaryfullname, _id_DDFACDF2215C052E.loadoutsecondary, _id_94C2510160259CC5, ammomax);
    _id_9B82C9CD52FE9E6B++;
  }

  if(isDefined(_id_DDFACDF2215C052E.loadoutprimaryobject) && !isnullweapon(_id_DDFACDF2215C052E.loadoutprimaryobject)) {
    _id_724736FCF0FB6604::br_forcegivecustomweapon(player, _id_DDFACDF2215C052E.loadoutprimaryobject, _id_DDFACDF2215C052E.loadoutprimaryfullname, _id_DDFACDF2215C052E.loadoutprimary, _id_94C2510160259CC5, ammomax);
    _id_9B82C9CD52FE9E6B++;
  }

  if(_id_9B82C9CD52FE9E6B > 1)
    player takeweapon("iw9_me_fists_mp");

  equipment = [];

  if(isDefined(_id_DDFACDF2215C052E.loadoutequipmentprimary))
    equipment[equipment.size] = _id_DDFACDF2215C052E.loadoutequipmentprimary;

  if(isDefined(_id_DDFACDF2215C052E.loadoutequipmentsecondary))
    equipment[equipment.size] = _id_DDFACDF2215C052E.loadoutequipmentsecondary;

  foreach(_id_1189BD7FBE2861F8 in equipment) {
    if(isDefined(level.br_pickups.br_equipnametoscriptable[_id_1189BD7FBE2861F8])) {
      scriptablename = level.br_pickups.br_equipnametoscriptable[_id_1189BD7FBE2861F8];
      _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, scriptablename, 1);
    }
  }
}

givematchloadoutfordropbags() {
  player = self;
  player.prevweaponobj = undefined;
  player scripts\mp\class::loadout_clearperks();
  givelaststandifneeded(player);
}

prematchdeployparachute() {
  self endon("disconnect");

  while(self.sessionstate != "playing")
    waitframe();

  thread scripts\cp_mp\parachute::startfreefall(2, 0, undefined, undefined, 1, 0);
}

getprematchradius(dropstruct) {
  radius = dropstruct.radius;
  minradius = dropstruct.minradius;
  _id_E5BD279D3767139F = getdvarint("dvar_3E97A62800FF7A1A", -1);

  if(_id_E5BD279D3767139F >= 0)
    radius = _id_E5BD279D3767139F;

  _id_E5BD279D3767139F = getdvarint("dvar_CAD542096552C754", -1);

  if(_id_E5BD279D3767139F >= 0)
    minradius = _id_E5BD279D3767139F;

  if(minradius >= radius)
    radius = minradius + 1;

  return [minradius, radius];
}

givelaststandifneeded(player) {
  if(istrue(level.forcedisablelaststand)) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  _id_04AD7C03EC4FA687 = level.maxteamsize == 1;
  hasselfrevivetoken = player _id_2CEDCC356F1B9FC8::hasselfrevivetoken();

  if(_id_04AD7C03EC4FA687 && !hasselfrevivetoken && !istrue(level._id_F4E4FAE260BDDFF3)) {
    return;
  }
  if(!iscontender(player)) {
    return;
  }
  if(player scripts\mp\utility\perk::_hasperk("specialty_pistoldeath")) {
    return;
  }
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  player scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
}

givespecialistbonusifneeded(player) {
  if(!iscontender(player)) {
    return;
  }
  if(!player _id_2CEDCC356F1B9FC8::hasspecialistbonus()) {
    return;
  }
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  player scripts\mp\perks\perks::addspecialistbonus();
}

waitloadoutdone(_id_9156B53BCF7CE573) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self notify("waitLoadoutDone");
  self endon("waitLoadoutDone");
  self waittill("giveLoadout");

  if(!isagent(self))
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("spawnVehicleDelay");

  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    self.attached_bag = undefined;
    _id_342175A1B9F9067E = self getplayerdata(level._id_5D69837CF4DB0407, level._id_342175A1B9F9067E);
    _id_8F24A28261FB9DA3 = _id_2D9D24F7C63AC143::_id_565CBEA3437267D9(self);
    _id_4480C6CE37B2BDF3::_id_0C3F3FCEEDDDA6F6(_id_8F24A28261FB9DA3);
  }

  if(_id_2CEDCC356F1B9FC8::istutorial() || _id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() || istrue(_id_9156B53BCF7CE573)) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
    if(!_id_362C58E8BB39BCDA::isfeaturedisabled("armor"))
      thread _id_50434E55C7907057();

    return;
  }

  _id_F4FB517B368C5E9B = 0;

  if(!istrue(level.br_prematchstarted)) {
    _id_F4FB517B368C5E9B = 1;
    thread giveprematchloadout();

    if(!_id_362C58E8BB39BCDA::isfeaturedisabled("armor"))
      thread _id_50434E55C7907057();

    scripts\mp\utility\perk::giveperk("specialty_pistoldraw");

    if(!istrue(self.prematchplayedwelcomevo)) {
      self.prematchplayedwelcomevo = 1;

      if(scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm") {
        scripts\engine\utility::delaythread(1.0, _id_2CEDCC356F1B9FC8::brleaderdialogplayer, "prematch_enter", self);

        if(!scripts\mp\flags::gameflag("prematch_done")) {
          _id_A0BD6B17E1037F3B = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_lobby_intro");
          self setplayermusicstate(_id_A0BD6B17E1037F3B);
        }
      }
    }

    level waittill("infils_ready");

    if(level.allowsupers)
      scripts\mp\supers::clearsuper(0);
  }

  if(istrue(level._id_376762409014CC8E))
    _id_724736FCF0FB6604::br_ammo_player_clear();

  _id_9E83064E74FA428C = istrue(self.gulag) || _id_2CEDCC356F1B9FC8::istutorial() || istrue(self.respawningbr) || (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") || scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73();
  _id_F7E8A863407717B3 = istrue(_id_F4FB517B368C5E9B);
  _id_7E52B56769FA7774::resetplayerinventory(_id_9E83064E74FA428C, _id_F7E8A863407717B3);

  if(!istrue(_id_F4FB517B368C5E9B) && !istrue(self.gulag) && !_id_362C58E8BB39BCDA::isfeaturedisabled("armor"))
    thread _id_50434E55C7907057();

  if(isDefined(level._id_F38E7B13448998B4))
    self thread[[level._id_F38E7B13448998B4]]();

  givelaststandifneeded(self);

  if(istrue(self.isrespawn)) {
    return;
  }
  if(istrue(self.gulag) || istrue(self.respawningbr)) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") {
    return;
  }
  if(!istrue(level.br_infils_disabled) && !istrue(self.latetoinfil))
    thread setplayerprematchallows();
}

onplayerscore(event, player, points, victim, _id_7EC7671A1E0C788F) {
  return points;
}

brmodifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1) {
  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    idamage = scripts\mp\damage::gamemodemodifyplayerdamage(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, _id_BE4285B26ED99AB1);

  if(isDefined(eattacker) && istrue(eattacker._id_6C66AFBC7F2CE4B0)) {
    _id_38D7AD5B3EFCE8C9 = getdvarfloat("dvar_FDF0EC912BF92434", 49.0);
    idamage = min(_id_38D7AD5B3EFCE8C9, idamage);
  }

  if(isDefined(eattacker) && isagent(eattacker) && isDefined(eattacker.agent_type) && issubstr(eattacker.agent_type, "rusher") && smeansofdeath == "MOD_MELEE") {
    idamage = min(idamage, getdvarint("dvar_22B45420BF5F62C5", 30));
    _id_BE4285B26ED99AB1 = idamage;
  }

  if(victim _id_2CEDCC356F1B9FC8::isplayeringulag() && isDefined(eattacker) && isagent(eattacker) && isDefined(eattacker.agent_type) && issubstr(eattacker.agent_type, "baton")) {
    switch (smeansofdeath) {
      case "MOD_EXECUTION":
        return idamage;
      case "MOD_DOWN":
        return idamage;
    }
  }

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && isbot(eattacker) && eattacker _id_2CEDCC356F1B9FC8::isplayeringulag() && istrue(eattacker.gulagarena) && _id_362C58E8BB39BCDA::isbrgametypefuncdefined("modifyPlayerDamage")) {
    _id_642470E1ABC1BBF9 = scripts\cp_mp\utility\damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir);
    _id_642470E1ABC1BBF9.shitloc = shitloc;
    idamage = thread _id_362C58E8BB39BCDA::runbrgametypefunc("modifyPlayerDamage", _id_642470E1ABC1BBF9);
    return idamage;
  }

  if(victim _id_2CEDCC356F1B9FC8::isplayeringulag() && istrue(victim.gulagarena) && getdvarint("scr_gulag_mp_damage", 1))
    return idamage;

  if(!isDefined(_id_BE4285B26ED99AB1))
    _id_BE4285B26ED99AB1 = idamage;

  if(idamage > 0) {
    if(istrue(victim.insertingarmorplate) && (!scripts\cp_mp\utility\damage_utility::_id_0CB9BA92488B23C5(objweapon) || getdvarint("scr_radiation_cancelsarmor", 1) == 1))
      victim notify("try_armor_cancel", "damage_received");

    if(scripts\mp\loot::_id_6F45E7311F77EAC4(victim) && !scripts\cp_mp\utility\damage_utility::_id_0CB9BA92488B23C5(objweapon) && !scripts\mp\loot::_id_73D8C72E055E8640(victim))
      victim notify("close_container");

    _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
    _id_5C3F9357F11D2223 = scripts\mp\utility\weapon::getweaponbasenamescript(objweapon);
    weapontype = weaponclass(objweapon);

    if(smeansofdeath == "MOD_FALLING") {
      if(isDefined(level.modifybrfalldamage))
        idamage = victim[[level.modifybrfalldamage]](idamage);
      else if(victim scripts\mp\utility\killstreak::isjuggernaut()) {} else if(getdvarint("scr_br_alt_mode_rocketjump", 0)) {
        if(victim isskydiving())
          victim skydive_interrupt();

        idamage = 0;
      }
    } else if(isDefined(einflictor) && einflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(isDefined(level.modifybrvehicledamage))
        idamage = victim[[level.modifybrvehicledamage]](idamage);
    } else if(_id_49E6EF3EDADD524E == "iw9_dm_crossbow" && smeansofdeath != "MOD_PISTOL_BULLET") {} else if(smeansofdeath == "MOD_MELEE")
      idamage = int(_id_BE4285B26ED99AB1);
    else if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon)) {
      if(istrue(victim.inlaststand) && scripts\mp\utility\killstreak::getkillstreaknamefromweapon(objweapon) == "precision_airstrike") {
        if(isDefined(victim.brdownedbyairstriketime)) {
          _id_30F68AF7E399B74D = gettime() - victim.brdownedbyairstriketime < 5000;

          if(_id_30F68AF7E399B74D)
            idamage = 0;
        }
      }
    } else if(getdvarint("scr_br_alt_mode_gg", 0) && smeansofdeath != "MOD_TRIGGER_HURT")
      idamage = brclampdamagealtmodegg(idflags, weapontype, _id_49E6EF3EDADD524E, shitloc, idamage);
    else if(istrue(level._id_F561FC43A226DAE4) && !victim _id_07C40FA80892A721::hasarmor() && getdvarint("dvar_6B68C911DBD04FD2", istrue(level.clampstepbulletdamage)) && smeansofdeath != "MOD_TRIGGER_HURT")
      idamage = brclampdamage(idflags, weapontype, _id_49E6EF3EDADD524E, shitloc, _id_BE4285B26ED99AB1, idamage, objweapon, smeansofdeath);

    if(brgulagdamagefilter(victim)) {
      if(_id_49E6EF3EDADD524E != "rock_mp") {
        idamage = 0;

        if(isDefined(eattacker))
          eattacker _id_5762AC2F22202BA2::updatedamagefeedback("standard", 0, 0, "standard", 0);
      } else
        idamage = 1;

      if(victim.health - idamage <= 0)
        idamage = 0;
    }

    if(isDefined(einflictor) && getdvarint("scr_br_alt_mode_rocketjump", 0)) {
      if(_id_F7F3032369F275C6(smeansofdeath)) {
        _id_5528888BDD4C85D6 = getdvarfloat("dvar_D4F0BBE5DF7312CC", 0.1);

        if(isDefined(eattacker) && eattacker == victim)
          _id_5528888BDD4C85D6 = 0;

        idamage = int(idamage * _id_5528888BDD4C85D6);
        victim thread br_alt_mode_impulse_player(einflictor);
      }
    }

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("modifyPlayerDamage")) {
      _id_642470E1ABC1BBF9 = scripts\cp_mp\utility\damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir);
      _id_642470E1ABC1BBF9.shitloc = shitloc;
      idamage = thread _id_362C58E8BB39BCDA::runbrgametypefunc("modifyPlayerDamage", _id_642470E1ABC1BBF9);
    }
  }

  return idamage;
}

brmodifyvehicledamage(data) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("modifyVehicleDamage"))
    return _id_362C58E8BB39BCDA::runbrgametypefunc("modifyVehicleDamage", data);

  return data.damage;
}

modeallowmeleevehicledamage(data) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("allowMeleeVehicleDamage"))
    return _id_362C58E8BB39BCDA::runbrgametypefunc("allowMeleeVehicleDamage", data);

  return 0;
}

_id_1FA2A6B50267656A(data) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("allowImpactVehicleDamage"))
    return _id_362C58E8BB39BCDA::runbrgametypefunc("allowImpactVehicleDamage", data);

  return 0;
}

modeignorevehicleexplosivedamage(data) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("ignoreVehicleExplosiveDamage"))
    return _id_362C58E8BB39BCDA::runbrgametypefunc("ignoreVehicleExplosiveDamage", data);

  return 0;
}

_id_9E34D99A98D2FF67(player, mover) {
  if(isDefined(mover)) {
    if(istrue(mover._id_C23CA3472233553D)) {
      _id_5357C1261661E9E4(mover, player, 75.0, -75.0);
      return 1;
    }

    if(istrue(mover._id_CA3708C44459C6EA)) {
      if(_id_ECC9EA2F03ECDD72(player))
        return 1;
    }
  }

  if(isnavmeshloaded()) {
    _id_9077C073DEF296AA = undefined;

    if(isDefined(mover)) {
      _id_9077C073DEF296AA = getclosestpointonnavmesh(mover.origin);

      if(isDefined(_id_9077C073DEF296AA)) {
        _id_BF5B3F9EA7746AC0 = _id_9077C073DEF296AA + (0, 0, 5);
        endpos = playerphysicstrace(_id_9077C073DEF296AA, _id_BF5B3F9EA7746AC0);

        if(endpos != _id_BF5B3F9EA7746AC0)
          _id_9077C073DEF296AA = undefined;
      }
    }

    if(!isDefined(_id_9077C073DEF296AA)) {
      groundorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(player.origin, 30);
      _id_9077C073DEF296AA = getclosestpointonnavmesh(groundorigin);
    }

    if(isDefined(_id_9077C073DEF296AA) && isDefined(mover) && istrue(mover._id_5395A5CCA02EAE60)) {
      _id_705A4BB89F63D4C4 = [];

      if(isDefined(mover._id_705A4BB89F63D4C4) && isarray(mover._id_705A4BB89F63D4C4))
        _id_705A4BB89F63D4C4 = mover._id_705A4BB89F63D4C4;

      contents = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1);
      trace = scripts\engine\trace::ray_trace(player gettagorigin("tag_eye"), _id_9077C073DEF296AA, scripts\engine\utility::array_add(_id_705A4BB89F63D4C4, mover), contents);

      if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none" || !canspawn(_id_9077C073DEF296AA))
        _id_9077C073DEF296AA = undefined;
    }

    if(isDefined(_id_9077C073DEF296AA)) {
      player setOrigin(_id_9077C073DEF296AA);
      return 1;
    }
  }

  return 0;
}

br_alt_mode_impulse_player(einflictor) {
  _id_AA2FC3CC3A2BCF35 = (self.origin[0], self.origin[1], self.origin[2] + 36);

  if(self isonground()) {
    tracestart = self.origin + (0, 0, 18);
    _id_8B39E5984DA1FFAF = self.origin + (0, 0, 90);
    contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 1);
    _id_868513209FA17242 = scripts\engine\trace::capsule_trace_passed(tracestart, _id_8B39E5984DA1FFAF, 12, 72, undefined, einflictor, contents);

    if(_id_868513209FA17242) {
      _id_A9706ADAF7C52E27 = (self.origin[0], self.origin[1], self.origin[2] + 18);
      self setOrigin(_id_A9706ADAF7C52E27);
    }
  }

  vdir = _id_AA2FC3CC3A2BCF35 - einflictor.origin;
  vdir = vectorNormalize(vdir);
  _id_22E9F9CF6E83C4D7 = getdvarfloat("dvar_F904C89EC86AED27", 1300);
  _id_3C590B0EE220AFA3 = undefined;

  if(vdir[2] > -0.3)
    _id_3C590B0EE220AFA3 = getdvarfloat("dvar_1B50FA9F9D44136F", 600);

  _id_80E7D3DF9ACD45BC = distance2d(einflictor.origin, self.origin) - 20;
  _id_808B4CAFF75E3E3D = clamp(_id_80E7D3DF9ACD45BC, 0, 80) / 100 * 0.5;
  _id_1B5B75666FA5B0F0 = 1;
  _id_B79930868F410231 = _id_1B5B75666FA5B0F0 - _id_808B4CAFF75E3E3D;
  vdir = vdir * _id_22E9F9CF6E83C4D7 * _id_B79930868F410231;

  if(isDefined(_id_3C590B0EE220AFA3)) {
    _id_2A3D8284E254788F = _id_1B5B75666FA5B0F0 - _id_808B4CAFF75E3E3D * 0.5;
    _id_3C590B0EE220AFA3 = _id_3C590B0EE220AFA3 * _id_2A3D8284E254788F;
    vdir = (vdir[0], vdir[1], max(_id_3C590B0EE220AFA3, vdir[2]));
  }

  self setvelocity(vdir);
}

_id_F7F3032369F275C6(smeansofdeath) {
  _id_08B3A4B8AAFA9740 = !isDefined(level._id_06BFB61F13A7D6A4);

  if(_id_08B3A4B8AAFA9740) {
    if(getdvarint("dvar_33AC50155C7EF8F8", 0)) {
      _id_D6CF0029DB971FE9 = ["MOD_EXPLOSIVE_BULLET", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_IMPACT", "MOD_FIRE", "MOD_FIRE_BULLET"];
      level._id_06BFB61F13A7D6A4 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D6CF0029DB971FE9.size; _id_AC0E594AC96AA3A8++) {
        _id_1E11F8621108597D = _func_2EF675C13CA1C4AF("dvar_69CFAEF4362B6A26", tolower(_id_D6CF0029DB971FE9[_id_AC0E594AC96AA3A8]));

        if(getdvarint(_id_1E11F8621108597D))
          level._id_06BFB61F13A7D6A4[level._id_06BFB61F13A7D6A4.size] = _id_D6CF0029DB971FE9[_id_AC0E594AC96AA3A8];
      }
    } else
      level._id_06BFB61F13A7D6A4 = ["MOD_EXPLOSIVE", "MOD_EXPLOSIVE_BULLET", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_FIRE"];
  }

  return scripts\engine\utility::array_contains(level._id_06BFB61F13A7D6A4, smeansofdeath);
}

brclampdamagealtmodegg(idflags, weapontype, _id_49E6EF3EDADD524E, shitloc, idamage) {
  if(isDefined(idflags) && idflags &level.idflags_penetration)
    _id_1646FE11681A5388 = 1;
  else
    _id_1646FE11681A5388 = 0;

  if(!_id_1646FE11681A5388) {
    switch (weapontype) {
      case "pistol":
        if(_id_49E6EF3EDADD524E == "iw8_pi_decho" || _id_49E6EF3EDADD524E == "iw8_pi_cpapa") {
          if(shitloc == "head" || shitloc == "helmet")
            idamage = 250;
          else
            idamage = 150;
        }

        break;
      case "sniper":
        if(_id_49E6EF3EDADD524E == "iw9_dm_crossbow")
          idamage = 250;

        break;
      default:
        break;
    }
  }

  return idamage;
}

isbulletpenetration(idflags) {
  return isDefined(idflags) && idflags &level.idflags_penetration;
}

issnipersemi(_id_49E6EF3EDADD524E) {
  return _id_49E6EF3EDADD524E == "iw8_sn_delta" || _id_49E6EF3EDADD524E == "iw8_sn_golf28" || _id_49E6EF3EDADD524E == "iw8_sn_mike14" || _id_49E6EF3EDADD524E == "iw8_sn_sbeta" || _id_49E6EF3EDADD524E == "iw8_sn_sksierra";
}

isxmike109explosivedamage(_id_49E6EF3EDADD524E, smeansofdeath, idamage) {
  return _id_49E6EF3EDADD524E == "iw8_sn_xmike109" && smeansofdeath == "MOD_PISTOL_BULLET" && idamage == 1;
}

brclampdamage(idflags, weapontype, _id_49E6EF3EDADD524E, shitloc, _id_BE4285B26ED99AB1, idamage, objweapon, smeansofdeath) {
  _id_1646FE11681A5388 = isbulletpenetration(idflags);

  if(!_id_1646FE11681A5388) {
    switch (weapontype) {
      case "rifle":
        _id_B7AB28868F552DF5 = idamage / _id_BE4285B26ED99AB1;

        if(getweaponammopoolname(objweapon) == "enum_6AA606A18241AD16") {
          if(level._id_22DB86FD48FEE384 >= 0) {
            _id_B7AB28868F552DF5 = idamage / _id_BE4285B26ED99AB1;
            idamage = min(idamage, level._id_22DB86FD48FEE384);
            idamage = int(_id_B7AB28868F552DF5 * idamage);
          }

          break;
        }

        if(_id_49E6EF3EDADD524E == "iw8_ar_falpha")
          _id_6E367C2AB8A94B0D = 1;
        else
          _id_6E367C2AB8A94B0D = level.clampstepbulletdamage;

        idamage = brclampstepdamage(_id_BE4285B26ED99AB1, objweapon, _id_6E367C2AB8A94B0D);
        idamage = int(_id_B7AB28868F552DF5 * idamage);
        break;
      case "mg":
      case "pistol":
        _id_B7AB28868F552DF5 = idamage / _id_BE4285B26ED99AB1;
        idamage = brclampstepdamage(_id_BE4285B26ED99AB1, objweapon, level.clampstepbulletdamage);
        idamage = int(_id_B7AB28868F552DF5 * idamage);
        break;
      case "sniper":
        if(shitloc == "head" || shitloc == "helmet") {
          if(isxmike109explosivedamage(_id_49E6EF3EDADD524E, smeansofdeath, idamage))
            idamage = 75;
          else if(issnipersemi(_id_49E6EF3EDADD524E))
            idamage = 175;
          else
            idamage = 250;
        } else if(isxmike109explosivedamage(_id_49E6EF3EDADD524E, smeansofdeath, idamage))
          return idamage;
        else if(_id_49E6EF3EDADD524E == "iw9_dm_crossbow")
          idamage = 200;
        else {
          _id_B7AB28868F552DF5 = idamage / _id_BE4285B26ED99AB1;

          if(issnipersemi(_id_49E6EF3EDADD524E))
            _id_5439FCC28091B721 = 1;
          else
            _id_5439FCC28091B721 = level.clampstepbulletdamage;

          idamage = brclampstepdamage(_id_BE4285B26ED99AB1, objweapon, _id_5439FCC28091B721);
          idamage = int(_id_B7AB28868F552DF5 * idamage);
        }

        break;
      case "smg":
        _id_B7AB28868F552DF5 = idamage / _id_BE4285B26ED99AB1;
        idamage = brclampstepdamage(_id_BE4285B26ED99AB1, objweapon, 3);
        idamage = int(_id_B7AB28868F552DF5 * idamage);
        break;
      case "spread":
        if(level.br_pelletmaxdamage >= 0) {
          if((_id_49E6EF3EDADD524E == "iw8_sh_oscar12" || _id_49E6EF3EDADD524E == "iw8_sh_aalpha12") && level._id_2CACA637693D024D >= 0)
            _id_65A460BBD41D8D09 = level._id_2CACA637693D024D;
          else
            _id_65A460BBD41D8D09 = level.br_pelletmaxdamage;

          _id_B7AB28868F552DF5 = idamage / _id_BE4285B26ED99AB1;
          idamage = min(idamage, _id_65A460BBD41D8D09);
          idamage = int(_id_B7AB28868F552DF5 * idamage);
        }
      default:
        break;
    }
  }

  return idamage;
}

brgulagdamagefilter(player) {
  return istrue(player.gulag) && !istrue(player.gulagarena);
}

brclampstepdamage(_id_BE4285B26ED99AB1, weapon, _id_4EFCC1874038117A) {
  _id_E7EC701163E1B30C = 0;

  if(_id_4EFCC1874038117A == 4)
    _id_E7EC701163E1B30C = weapon getmid3damage();
  else if(_id_4EFCC1874038117A == 3)
    _id_E7EC701163E1B30C = weapon getmid2damage();
  else if(_id_4EFCC1874038117A == 2)
    _id_E7EC701163E1B30C = weapon getmid1damage();

  if(_id_E7EC701163E1B30C <= 0)
    _id_E7EC701163E1B30C = weapon.mindamage;

  if(_id_4EFCC1874038117A == 1 || _id_E7EC701163E1B30C <= 0)
    _id_E7EC701163E1B30C = weapon.maxdamage;

  if(_id_BE4285B26ED99AB1 < _id_E7EC701163E1B30C)
    return int(_id_E7EC701163E1B30C);
  else
    return _id_BE4285B26ED99AB1;
}

onplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("onPlayerDamaged")) {
    _id_642470E1ABC1BBF9 = scripts\cp_mp\utility\damage_utility::packdamagedata(eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir);
    _id_642470E1ABC1BBF9.shitloc = shitloc;
    _id_362C58E8BB39BCDA::runbrgametypefunc("onPlayerDamaged", _id_642470E1ABC1BBF9);
  }

  if(istrue(victim.gulag)) {
    arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(victim);

    if(isDefined(arena)) {
      if(!isDefined(victim._id_3A7C9A3E9AA20358))
        victim._id_3A7C9A3E9AA20358 = 0;

      victim._id_3A7C9A3E9AA20358 = victim._id_3A7C9A3E9AA20358 + idamage;
    }
  }

  if(isDefined(eattacker) && eattacker != victim && isPlayer(eattacker)) {
    if(idamage >= _id_FCDF19E3CDD29669)
      idamage = _id_FCDF19E3CDD29669;

    if(idamage > 0) {
      victim _id_21C19CFC7139D773::_id_D0CCB374806FE494();
      _id_5C3F9357F11D2223 = scripts\mp\utility\weapon::getweaponbasenamescript(objweapon);

      if(_id_5C3F9357F11D2223 == "rock_mp" && isalive(victim))
        victim playlocalsound("br_gulag_rock_player_impact");
    }

    eattacker _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("damageDealt", eattacker.pers["damage"]);
  } else if(isDefined(einflictor) && einflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    vehicle = einflictor;

    if(isDefined(vehicle.owner) && isPlayer(vehicle.owner) && vehicle.owner != victim) {
      victim _id_21C19CFC7139D773::_id_D0CCB374806FE494();
      vehicle.owner _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("damageDealt", vehicle.owner.pers["damage"]);
    }
  } else if(isDefined(eattacker) && eattacker != victim && isagent(eattacker))
    victim _id_21C19CFC7139D773::_id_D0CCB374806FE494();

  if(isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon)) {
    _id_8FCD15F752798A79 = idamage >= _id_FCDF19E3CDD29669 && scripts\mp\utility\killstreak::getkillstreaknamefromweapon(objweapon) == "precision_airstrike";
    _id_D3837504F686B986 = istrue(victim.inlaststand);

    if(_id_8FCD15F752798A79 && _id_D3837504F686B986)
      victim.brdownedbyairstriketime = gettime();
  }
}

onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("OnNormalDeath"))
    _id_362C58E8BB39BCDA::runbrgametypefunc6("OnNormalDeath", victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  _id_0FD32F08E72B657F::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);

  if(victim _meth_E40102956C887F7C())
    _id_3EB5723089C90994(victim);
  else
    victim._id_60D0A5246848AE8C = 0;

  if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm" || scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "kingslayer" || scripts\mp\utility\game::getsubgametype() == "rumble_mgl" || scripts\mp\utility\game::getsubgametype() == "champion") {
    return;
  }
  _id_677AE66DF2125F53 = scripts\mp\utility\game::getlivingplayers();

  if(isDefined(level.numendgame)) {
    if(_id_677AE66DF2125F53.size <= level.numendgame)
      level thread startendgame(1);
  }

  _id_BEDB769CC0E5E018 = level.totalplayers - _id_677AE66DF2125F53.size;
  _id_C7761B0132ABCFA7 = 0;

  foreach(player in level.players) {
    if(isDefined(player.score) && player.score > _id_C7761B0132ABCFA7)
      _id_C7761B0132ABCFA7 = player.score;

    if(isDefined(player.petwatch) && isalive(player)) {
      _id_B85F94BB6CBB1D8C = 1 - _id_BEDB769CC0E5E018 / level.totalplayers;
      player scripts\cp_mp\pet_watch::tryupdategenericprogress(_id_B85F94BB6CBB1D8C, 5);
    }
  }

  if(!level.teambased) {
    victim.score = level.totalplayers - _id_677AE66DF2125F53.size;

    foreach(player in _id_677AE66DF2125F53)
    player.score = victim.score + 1;
  }
}

getalivecount(_id_D50AE4DC9841FD21) {
  _id_1F7BCAA53CA6D399 = 0;

  if(istrue(_id_D50AE4DC9841FD21)) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    _id_1F7BCAA53CA6D399 = _id_1F7BCAA53CA6D399 + scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");
  } else {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");

      if(_id_BCE4EFC75EB01319) {
        aliveplayers = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "alivePlayers");

        foreach(player in aliveplayers) {
          if(isDefined(player) && !istrue(player.gulag) && !player _id_7DBB8165D792B06C())
            _id_1F7BCAA53CA6D399 = _id_1F7BCAA53CA6D399 + 1;
        }
      }
    }
  }

  _id_1F7BCAA53CA6D399 = _id_1F7BCAA53CA6D399 + _id_1BBD21D289BA8A92();
  return _id_1F7BCAA53CA6D399;
}

doplayerkilledsplashes(victim, attacker) {
  if(istrue(level.usegulag) && victim _id_2CEDCC356F1B9FC8::isplayeringulag()) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "rumble_mgl")
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::_id_3D0F2343793D709B(victim.team, victim._id_0FF97225579DE16A, 1);
  else
    _id_6D5ED003AF1F9612 = level.teamdata[victim.team]["alivePlayers"];

  foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
    if(!isDefined(_id_F0EA4030349A33D5)) {
      continue;
    }
    if(_id_F0EA4030349A33D5 != victim)
      _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_teammate_dead", undefined, victim);
  }
}

shutdowngulagforalivecount() {
  if(istrue(level.usegulag) && !istrue(level.gulag.shutdown)) {
    count = getalivecount(0);

    if(count <= getdvarint("dvar_2665FC757A822EB2", -1))
      _id_67708F418B1FAC79::shutdowngulag("player_count", count);
  }
}

onplayerdisconnect(player) {
  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate")) {
    if(!istrue(player._id_632BAD3EDB4E449E))
      _id_6489FCDFE6FA2E36::migratespectators(player, undefined, 0);
  }

  if(istrue(level.br_prematchstarted)) {
    shutdowngulagforalivecount();
    _id_67708F418B1FAC79::onplayerdisconnect(player);
    _id_C2416B3BCAF44892 = isDefined(player) && istrue(player.inlaststand) && !player _id_7DBB8165D792B06C() && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "kingslayer" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl" && !istrue(player._id_DED04CDD264A7E00);

    if(_id_C2416B3BCAF44892) {
      if(_id_2D9D24F7C63AC143::_id_720D227D0E55A960())
        _id_2391409EF7B431E1::_id_F6D685CABFAD2CE9(player, player.laststandattacker);

      if(isDefined(player.laststandattacker))
        player.laststandattacker scripts\mp\damage::playerincrementscoreboardkills();
    }
  }

  _id_715028F54BAD19A1::branalytics_disconnect(player, int(scripts\mp\utility\player::isreallyalive(player)));

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("onPlayerDisconnect"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("onPlayerDisconnect", player);

  level thread updateplayerandteamcountui();
  _id_6731BE38C3B94FF7::onplayerdisconnect(player);

  if(istrue(level._id_8A854EC031BB41F1) && scripts\mp\utility\game::getsubgametype() != "dmz" && !scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    player _id_7E52B56769FA7774::droponplayerdeath();

  _id_728FFCEE8CBF30EE::_id_601137842B64C899(player);
}

_id_0C11D61293D7E8BA(player) {
  if(isDefined(player) && player.team != "codcaster") {
    _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(player.team);
    _id_A9CEB9B39C78FB07 = [];

    foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
      _id_E1E65E11F75F9CBB = _id_D0F9FBF3F0F8C739(_id_F90358454413407F);

      if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount") || _id_E1E65E11F75F9CBB > 0)
        _id_A9CEB9B39C78FB07[_id_A9CEB9B39C78FB07.size] = _id_F90358454413407F;
    }

    teamplacement = _id_A9CEB9B39C78FB07.size + 1;

    if(scripts\mp\flags::gameflag("prematch_done")) {
      [_id_B5D67493FB854F58, _id_1B70C48B930405F0, _id_D6A23FDABD1D282C] = player calculatebrbonusxp(teamplacement, player.team);

      if(_id_B5D67493FB854F58 > 0) {
        player givebrbonusxp(_id_B5D67493FB854F58, undefined, "disconnect");
        player.matchbonus = _id_1B70C48B930405F0;
        player.placementbonus = _id_D6A23FDABD1D282C;
      }

      player setplacementstats(teamplacement);
      player stopchallengetimers();
      scripts\mp\gamelogic::_setplayerteamrank(player, teamplacement);
      updateclientmatchdata(player);

      if(isDefined(level._id_0C3EDD7B8C279A3E))
        player thread[[level._id_0C3EDD7B8C279A3E]]();
    }

    player thread handlebrdefeatedpostgamestate(teamplacement);
  }
}

_id_AD8C1E6228A10058() {
  player = self;

  if(!level._id_318DE67B5265B4C6) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2D9D24F7C63AC143::_id_B13E35608B336D65(player); _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = player _id_2D9D24F7C63AC143::_id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);
    _id_FF239359935AA777 = player _id_2D9D24F7C63AC143::_id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
    player setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, _id_AC0E594AC96AA3A8, "lootID", 1);
    player setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, _id_AC0E594AC96AA3A8, "quantity", 1);
    player setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, _id_AC0E594AC96AA3A8, "lootID", _id_EEEAE9DEFA0C1E95);
    player setplayerdata(level._id_5D69837CF4DB0407, level._id_201C841C4668A94F, _id_AC0E594AC96AA3A8, "quantity", _id_FF239359935AA777);
  }
}

updateclientmatchdata(player) {
  scripts\mp\gamelogic::processlobbydataforclient(player);
  scripts\mp\scoreboard::processcommonplayerdataforplayer(player);
  _id_877E2FC32734DD14 = getdvarint("online_mp_clientmatchdata_enabled", 0);

  if(_id_877E2FC32734DD14)
    player sendclientmatchdataforclient();
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  if(istrue(level.br_prematchstarted)) {
    if(_id_2D9D24F7C63AC143::_id_720D227D0E55A960())
      _id_2391409EF7B431E1::_id_F6D685CABFAD2CE9(self, attacker, objweapon);

    if(smeansofdeath == "MOD_EXECUTION")
      self.wasexecuted = 1;
    else
      self.wasexecuted = 0;

    _id_7E52B56769FA7774::droponplayerdeath(attacker, smeansofdeath, objweapon);
    doplayerkilledsplashes(self, attacker);
    shutdowngulagforalivecount();
    _id_0A34750D17473C49::_id_8311407EA8B66F9A(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);
  }

  _id_29C32B7117E01180::onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);

  if(istrue(attacker.gulag)) {
    if(_id_5BC60484D17FA95C::_id_CFE304859F30E747("gulagOnPlayerKilled"))
      _id_5BC60484D17FA95C::_id_3CCEB052D780FEF1("gulagOnPlayerKilled", attacker);
  }

  _id_724736FCF0FB6604::br_ammo_player_clear();
  _id_D4B54DC4008C298C = self.lastdroppableweaponobj;
  _id_D4B54DC4008C298C = scripts\mp\utility\weapon::mapweapon(_id_D4B54DC4008C298C, einflictor);
  _id_B2B6CAFCDB2218D2 = getcompleteweaponname(_id_D4B54DC4008C298C);

  if(isDefined(_id_B2B6CAFCDB2218D2)) {
    thread scripts\mp\gamelogic::trackleaderboarddeathstats(attacker, self, _id_B2B6CAFCDB2218D2, smeansofdeath);
    self._id_F08DA114FFD85042 = self.lifeid;
  }

  _id_7E52B56769FA7774::resetplayerinventory(undefined, undefined, 1);
  onplayerscore("kill", attacker, 0, self);

  if(isDefined(self.laststandoutlineid)) {
    scripts\mp\utility\outline::outlinedisable(self.laststandoutlineid, self);
    self.laststandoutlineid = undefined;
  }

  _id_72AF5A878A9D3397::_id_2EA4C1DB39176769(attacker, self, smeansofdeath, idamage);

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("onPlayerKilled")) {
    _id_642470E1ABC1BBF9 = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, idamage, objweapon, smeansofdeath, einflictor, undefined, vdir);
    thread _id_362C58E8BB39BCDA::runbrgametypefunc("onPlayerKilled", _id_642470E1ABC1BBF9);
  }

  if(!istrue(level.br_prematchstarted)) {
    _id_6AFF3948CF4CCA03::playerplunderlivelobbydropondeath(smeansofdeath);
    return;
  }

  if(_id_55E418C5CC946593::_id_C0D385A09D173A36())
    thread _id_55E418C5CC946593::onplayerkilled(attacker, self);

  if(getdvarint("dvar_82BDE055B11E6698", 0))
    thread _id_3ACF1C0EBAF602F2::onplayerkilled(attacker, self);
  else
    thread _id_64ACB6CE534155B7::onplayerkilled(attacker, self);

  thread _id_123A6F38785CDF2D::playerdied(attacker, objweapon);
  _id_2CEDCC356F1B9FC8::setplayerdownedextrainfo(0);
  _id_2CEDCC356F1B9FC8::setplayerbeingrevivedextrainfo(0);
  updatesquadmemberlaststandreviveprogress(self, self, 0, 1);

  if(istrue(self.inlaststand)) {
    if(isPlayer(attacker))
      attacker incrementcleanupsstat();
  }

  eliminated = _id_362C58E8BB39BCDA::runbrgametypefunc("markPlayerAsEliminatedOnKilled");

  if(!isDefined(eliminated))
    eliminated = !istrue(level.usegulag);

  if(eliminated)
    _id_0A34750D17473C49::markplayeraseliminated(self, "onPlayerKilled");

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()) {
    if(isbot(self) && isPlayer(attacker) && !istrue(attacker _id_2CEDCC356F1B9FC8::isplayeringulag()))
      attacker notify("killed_enemy");
  }

  level thread updateplayerandteamcountui();
  level notify("player_killed");
}

incrementcleanupsstat() {
  player = self;

  if(!isDefined(player.br_cleanups))
    player.br_cleanups = 0;

  player.br_cleanups++;
  player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("cleanups", player.br_cleanups);
}

registercrateforcleanup(crate) {
  level.br_pickups.crates[level.br_pickups.crates.size] = crate;
}

brloadoutcratefirstactivation(crate) {}

makeitemsfromcrate(player) {
  cratedata = self.data;

  if(cratedata.type == "personal") {
    makepersonalweaponfromcrate(player);
    return;
  }

  if(cratedata.type == "weapon") {
    _id_FAC9C78FD161DD04 = randomintrange(2, 4);
    _id_05A13070AF1D88B0 = 6 - _id_FAC9C78FD161DD04;
  } else {
    _id_FAC9C78FD161DD04 = randomintrange(1, 2);
    _id_05A13070AF1D88B0 = 6 - _id_FAC9C78FD161DD04;
  }

  _id_2891322C71EF74A8 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FAC9C78FD161DD04 && _id_2891322C71EF74A8 < level.br_pickups.br_dropoffsets.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(makeweaponfromcrate(_id_2891322C71EF74A8)))
      _id_2891322C71EF74A8++;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_05A13070AF1D88B0 && _id_2891322C71EF74A8 < level.br_pickups.br_dropoffsets.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(makeitemfromcrate(_id_2891322C71EF74A8)))
      _id_2891322C71EF74A8++;
  }
}

makeweaponfromcrate(_id_2891322C71EF74A8) {
  _id_5FBA91F7C0FC9C89 = scripts\engine\utility::random(level.br_pickups.br_crateguns);
  fullweaponobj = _id_7E52B56769FA7774::getfullweaponobjforscriptablepartname(_id_5FBA91F7C0FC9C89);

  if(!isDefined(fullweaponobj)) {
    return;
  }
  groundpos = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[_id_2891322C71EF74A8], 50, -200, (0, 0, 1)) + (0, 0, 24);
  weapon = _id_724736FCF0FB6604::createspawnweaponatpos(groundpos, (0, 0, 90), fullweaponobj);

  if(isDefined(weapon))
    weapon.isweaponfromcrate = 1;

  return weapon;
}

makeitemfromcrate(_id_2891322C71EF74A8) {
  groundpos = scripts\engine\utility::drop_to_ground(self.origin + level.br_pickups.br_dropoffsets[_id_2891322C71EF74A8], 50, -200, (0, 0, 1)) + (0, 0, 12);
  scriptablename = scripts\engine\utility::random(level.br_pickups.br_crateitems);
  itemname = scriptablename;
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(groundpos, (0, 0, 90));
  pickupent = _id_7E52B56769FA7774::spawnpickup(itemname, _id_CB4FAD49263E20C4, 1);
  return pickupent;
}

makepersonalweaponfromcrate(player) {
  cratedata = self.data;
  groundpos = scripts\engine\utility::drop_to_ground(self.origin + (0, 0, 6), 50, -200, (0, 0, 1)) + (0, 0, 24);
  weapon = _id_724736FCF0FB6604::createspawnweaponatposfromname(groundpos, cratedata.personalweaponfullname);

  if(isDefined(weapon)) {
    weapon.isweaponfromcrate = 1;
    player loadweaponsforplayer([cratedata.personalweaponfullname]);
  }

  return weapon;
}

initloot() {
  level.br_weaponweights = [];
  level.br_weaponweights["iw8_ar_mike4"] = 20;
  level.br_weaponweights["iw8_sm_mpapa5"] = 40;
  level.br_weaponweights["iw8_sh_dpapa12"] = 40;
  level.br_weaponweights["iw8_la_gromeo"] = 30;
  level.br_weaponweights["iw8_lm_kilo121"] = 10;
  level.br_weaponweights["iw8_sn_alpha50"] = 10;
  level.br_weaponweights["iw8_knife"] = 5;
  level.br_weaponweights["iw8_pi_golf21"] = 50;
  level.br_weaponweights["iw8_ar_akilo47"] = 20;
  level.br_weaponweighttotal = 0;

  foreach(_id_DE88CD14114C1E24, weight in level.br_weaponweights)
  level.br_weaponweighttotal = level.br_weaponweighttotal + weight;

  level.baseraritymap = [];
  level.baseraritymap["iw8_ar_mike4"] = 1;
  level.baseraritymap["iw8_ar_akilo47"] = 1;
  level.baseraritymap["iw8_sm_mpapa5"] = 1;
  level.baseraritymap["iw8_sh_dpapa12"] = 1;
  level.baseraritymap["iw8_la_gromeo"] = 1;
  level.baseraritymap["iw8_lm_kilo121"] = 1;
  level.baseraritymap["iw8_sn_alpha50"] = 3;
  level.baseraritymap["iw8_knife"] = 0;
  level.baseraritymap["iw8_pi_golf21"] = 0;
  level.attachraritymap = [];
  level.attachraritymap["holo"] = 1;
  level.attachraritymap["silencer"] = 2;
  level.attachraritymap["gl"] = 2;
}

weaponlocallowed(loc, _id_62FC582F58179B24) {
  foreach(_id_AC0E5E4AC96AAEA7 in _id_62FC582F58179B24) {
    _id_470E4B042B50D3DD = _id_AC0E5E4AC96AAEA7.origin[2] - 24;
    _id_32C058CA9CBFCD31 = _id_AC0E5E4AC96AAEA7.origin[2] + 90 - 24;

    if(scripts\engine\utility::distance_2d_squared(_id_AC0E5E4AC96AAEA7.origin, loc.origin) < 147456 && loc.origin[2] >= _id_470E4B042B50D3DD && loc.origin[2] <= _id_32C058CA9CBFCD31)
      return 0;
  }

  return 1;
}

startendgame(firsttime) {
  if(_id_A587B0B0998C6D13()) {
    return;
  }
  scripts\mp\gamelogic::pausetimer();
  level.timepausestart = gettime();
  level.timelimitoverride = 1;
}

debugtestcirclevfx(number) {
  if(isDefined(level.circleemitters))
    destroyemitters(level.circleemitters);

  level notify("runDebugVFXCircleTest");
  waitframe();

  switch (number) {
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

groundraycast(pos) {
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  caststart = pos + (0, 0, 10000);
  castend = caststart + (0, 0, -20000);
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0)
    return _id_E021C2744CC7ED68[0]["position"];

  return (0, 0, 0);
}

debugplayercirclevfx() {
  for(;;) {
    waitframe();

    if(!isDefined(level.circledebugpos) || !isDefined(level.circledebugradius)) {
      continue;
    }
    _id_B1E1B0A993DBD52A = distance2d(self.origin, level.circledebugpos) < level.circledebugradius;

    if(istrue(self.debugcircleincircle)) {
      if(!_id_B1E1B0A993DBD52A && level.debugcircleplayerfx == 0) {
        playFXOnTag(level._effect["vfx_gas_ring_player"], self, "tag_eye");
        level.debugcircleplayerfx = 1;
        self.debugcircleincircle = 0;
      }

      continue;
    }

    if(_id_B1E1B0A993DBD52A && !self.debugcircleincircle) {
      self.debugcircleincircle = 1;
      stopFXOnTag(level._effect["vfx_gas_ring_player"], self, "tag_eye");
      level.debugcircleplayerfx = 0;
    }
  }
}

rundebugvfxcircletest(_id_ACC4F45C61ED5FF1, _id_15B8FF04C24C09F4, time, _id_713A986EA7B77210) {
  level endon("game_ended");
  level endon("runDebugVFXCircleTest");

  if(!istrue(level.debugcircleplayerfx))
    level.players[0] thread debugplayercirclevfx();

  _id_2A54ADD44D7DDF42 = 5;
  groundpos = level.players[0] groundraycast(level.players[0].origin);
  level.circleemitters = spawnentsincircle(groundpos, _id_ACC4F45C61ED5FF1, _id_713A986EA7B77210);
  level.circledebugpos = groundpos;
  wait 0.1;
  spawnvfxincircle(level.circleemitters);
  starttime = time;

  while(time > 0) {
    _id_B1D0BC03029F6A2C = time / starttime;
    _id_A66785EDEC9E567B = _id_15B8FF04C24C09F4 + (_id_ACC4F45C61ED5FF1 - _id_15B8FF04C24C09F4) * _id_B1D0BC03029F6A2C;

    if(_id_2A54ADD44D7DDF42 < 0) {
      destroyemitters(level.circleemitters);

      if(_id_A66785EDEC9E567B <= 0) {
        return;
      }
      level.circledebugradius = _id_A66785EDEC9E567B;
      _id_2A54ADD44D7DDF42 = 5;
      level.circleemitters = spawnentsincircle(groundpos, _id_A66785EDEC9E567B, _id_713A986EA7B77210);
      wait 0.1;
      spawnvfxincircle(level.circleemitters);
    } else
      updateemitterpositions(groundpos, _id_A66785EDEC9E567B, level.circleemitters);

    time = time - level.framedurationseconds;
    _id_2A54ADD44D7DDF42 = _id_2A54ADD44D7DDF42 - level.framedurationseconds;
    waitframe();
  }
}

destroyemitters(_id_CEE4E2853864526E) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CEE4E2853864526E.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_CEE4E2853864526E[_id_AC0E594AC96AA3A8])) {
      stopFXOnTag(level._effect["vfx_gas_ring_puffy"], _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8], "tag_origin");
      _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8] delete();
    }
  }
}

updateemitterpositions(center, _id_A66785EDEC9E567B, _id_CEE4E2853864526E) {
  count = _id_CEE4E2853864526E.size;
  _id_EB2EEB8B58BFD8A0 = 6.2831 * _id_A66785EDEC9E567B;
  _id_44706ED8E238A53C = 360 / count;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    angle = _id_44706ED8E238A53C * _id_AC0E594AC96AA3A8;
    y = sin(angle) * _id_A66785EDEC9E567B;
    x = cos(angle) * _id_A66785EDEC9E567B;
    groundpos = groundraycast(center + (x, y, 0));
    _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8].origin = groundpos;
    _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8].angles = (0, angle + 180, 0);
  }
}

spawnentsincircle(center, radius, _id_713A986EA7B77210) {
  _id_CEE4E2853864526E = [];
  _id_EB2EEB8B58BFD8A0 = 6.2831 * radius;
  _id_63F445469B886BF8 = _id_EB2EEB8B58BFD8A0 / _id_713A986EA7B77210;

  if(_id_63F445469B886BF8 < 200)
    iprintlnbold("Using " + int(_id_63F445469B886BF8) + " emitters");
  else
    iprintlnbold("Can't use " + int(_id_63F445469B886BF8) + " emitters, using 200 instead");

  _id_63F445469B886BF8 = min(_id_63F445469B886BF8, 200);
  _id_44706ED8E238A53C = 360 / _id_63F445469B886BF8;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_63F445469B886BF8; _id_AC0E594AC96AA3A8++) {
    angle = _id_44706ED8E238A53C * _id_AC0E594AC96AA3A8;
    y = sin(angle) * radius;
    x = cos(angle) * radius;
    groundpos = groundraycast(center + (x, y, 0));
    _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8] = spawn("script_model", groundpos);
    _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8] setModel("tag_origin");
    _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8].origin = groundpos;
    _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8].angles = (0, angle + 180, 0);
  }

  return _id_CEE4E2853864526E;
}

spawnvfxincircle(_id_CEE4E2853864526E) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_CEE4E2853864526E.size; _id_AC0E594AC96AA3A8++)
    playFXOnTag(level._effect["vfx_gas_ring_puffy"], _id_CEE4E2853864526E[_id_AC0E594AC96AA3A8], "tag_origin");
}

ontimelimit() {
  if(isDefined(level.numendgame))
    level thread startendgame(1);

  level.numendgame = undefined;
}

onplayerjoinsquad(player) {
  if(!isDefined(player.team))
    scripts\mp\utility\script::demoforcesre("onPlayerJoinTeam: !isDefined( player.team ) - " + player.name);

  if(!scripts\mp\utility\teams::isgameplayteam(player.team))
    scripts\mp\utility\script::demoforcesre("onPlayerJoinTeam: !isGameplayTeam( player.team ) - " + player.name + " " + player.team);

  if(level.teambased) {
    _id_D6EE3E704C6731D4 = _id_58BE75C518BF0D40::getsquadleader(player.team, player._id_0FF97225579DE16A);

    if(!_id_362C58E8BB39BCDA::isfeaturedisabled("squadLeader")) {
      if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
        _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(player.team, "players");

        foreach(player in _id_A6AB8D0FDA441DC2)
        player setplayerbrsquadleader(_id_D6EE3E704C6731D4 == player);
      } else
        player setplayerbrsquadleader(_id_D6EE3E704C6731D4 == player);
    }
  }
}

ondeadevent(team) {
  if(istrue(level.br_debugsolotest) || scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "kingslayer" || scripts\mp\utility\game::getsubgametype() == "rumble_mgl" || !_id_227CA42A35B0398B(team)) {
    return;
  }
  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B() && istrue(self.gulagarena)) {
    return;
  }
  if(istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("onDeadEvent", team))) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    _id_32699BFF444B041B = _id_4480C6CE37B2BDF3::_id_1714FFEA633DCFED(team);

    if(_id_32699BFF444B041B)
      return;
  }

  if(isDefined(team)) {
    if(team != "all") {
      _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

      foreach(player in _id_A6AB8D0FDA441DC2) {
        if(isDefined(player))
          player thread _id_0A34750D17473C49::_id_1B5DA10393C9C50E(1);
      }

      _id_0A34750D17473C49::_id_DEF20F6AA082FCF5(team);
      thread onsquadeliminated(team);
      scripts\mp\gamelogic::default_ondeadevent(team);
    } else {
      level notify("all_players_dead");

      foreach(player in level.players) {
        if(player getclientomnvar("ui_league_play_br_leave_penalty_timer") > _id_0A34750D17473C49::_id_B5B049C4B47CF929())
          player thread _id_0A34750D17473C49::_id_1B5DA10393C9C50E(1);
      }
    }
  }

  if((scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") && isDefined(team))
    thread _id_4480C6CE37B2BDF3::_id_ADC51ADE78872D95(team);
}

_id_99E3948BFD8A99B8(team) {
  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    players = scripts\mp\utility\teams::getteamdata(team, "players");
    _id_BCE4EFC75EB01319 = 0;

    foreach(player in players) {
      if(!istrue(player.br_iseliminated) && !player _id_7DBB8165D792B06C())
        _id_BCE4EFC75EB01319++;
    }

    _id_E1E65E11F75F9CBB = _id_D0F9FBF3F0F8C739(team);
    _id_BCE4EFC75EB01319 = _id_BCE4EFC75EB01319 + _id_E1E65E11F75F9CBB;
    return _id_BCE4EFC75EB01319;
  } else if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B() && level._id_68C03DCCCE80D6F8) {
    _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(team, "aliveCount");
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players) {
      if(!isalive(player) && istrue(player.gulagarena))
        _id_BCE4EFC75EB01319++;
    }

    return _id_BCE4EFC75EB01319;
  } else
    return scripts\mp\utility\teams::getteamdata(team, "aliveCount");
}

onsquadeliminated(team) {
  _id_A9CEB9B39C78FB07 = [];
  _id_5AAB9D85460F9E87 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(_id_F90358454413407F == team) {
      continue;
    }
    _id_849D01AFB2FC0F0A = _id_99E3948BFD8A99B8(_id_F90358454413407F);

    if(_id_849D01AFB2FC0F0A > 0) {
      _id_A9CEB9B39C78FB07[_id_A9CEB9B39C78FB07.size] = _id_F90358454413407F;
      _id_5AAB9D85460F9E87 = _id_5AAB9D85460F9E87 + _id_849D01AFB2FC0F0A;
    }
  }

  level._id_67B3435949F31707 = _id_A9CEB9B39C78FB07.size;

  if(isDefined(level._id_ED844DB90CB6D370)) {
    _id_E0466189B4CA60A3 = getdvarint("dvar_B732D750AE36E4E0", 3);

    if(_id_E0466189B4CA60A3 != -1 && _id_A9CEB9B39C78FB07.size <= _id_E0466189B4CA60A3 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "permanentlyDisableAssim"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "permanentlyDisableAssim")]]();
  }

  if(_id_362C58E8BB39BCDA::isfeatureenabled("pleaForHelp"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("pleaForHelp", "deletePleasFromTeam")]](team);

  teamplacement = _id_A9CEB9B39C78FB07.size + 1;
  onsquadeliminatedplacement(team, teamplacement, _id_5AAB9D85460F9E87, 0);

  if(isDefined(level._id_561ADDF876799987))
    [[level._id_561ADDF876799987]]("placement", team);

  if(istrue(level._id_77907D733ABE8B63)) {
    if(getdvarint("dvar_EC4C94A9646F819F", 1) == 1) {
      if(!_id_04CDABCD91A92977::_id_C9B26CFB4D93AE50())
        _id_697B7AE06BA9B28C::_id_9A30317C91CFAF5E();
      else if(istrue(level._id_E20AF527A1D336F6))
        _id_697B7AE06BA9B28C::_id_E197F06B7037E7A1(team);
    }
  }
}

_id_79A4861772547BC2(team, _id_5AAB9D85460F9E87, _id_6FDDAB94C52A873C) {
  wait 1.5;
  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

  if(_id_FAF0D2FAC3F47583 != "dmz" && _id_FAF0D2FAC3F47583 != "exgm") {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

    if(!istrue(_id_6FDDAB94C52A873C) && _id_5AAB9D85460F9E87 < 5)
      _id_2CEDCC356F1B9FC8::brleaderdialog("top_5_lose", 0, _id_A6AB8D0FDA441DC2, 1);
    else if(!istrue(_id_6FDDAB94C52A873C) && _id_5AAB9D85460F9E87 < 10)
      _id_2CEDCC356F1B9FC8::brleaderdialog("top_10_lose", 0, _id_A6AB8D0FDA441DC2, 1);
    else if(!istrue(_id_6FDDAB94C52A873C) && _id_5AAB9D85460F9E87 < 25)
      _id_2CEDCC356F1B9FC8::brleaderdialog("top_25_lose", 0, _id_A6AB8D0FDA441DC2, 1);

    _id_2CEDCC356F1B9FC8::brleaderdialog("team_loss", 0, _id_A6AB8D0FDA441DC2, 1);
  }
}

onsquadeliminatedplacement(team, teamplacement, _id_5AAB9D85460F9E87, _id_6FDDAB94C52A873C, skipsplash) {
  setteamplacement(team, teamplacement);
  _id_715028F54BAD19A1::branalytics_teameliminated(team, teamplacement);
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player)) {
      [_id_B5D67493FB854F58, _id_1B70C48B930405F0, _id_D6A23FDABD1D282C] = player calculatebrbonusxp(teamplacement, team);
      _id_B01ACA3236595958 = _id_09E8CCAD6488211B::_id_8B22E17D9E3AAEA3(player);
      player givebrbonusxp(_id_B5D67493FB854F58, undefined, "squadEliminated", _id_B01ACA3236595958);
      player.matchbonus = scripts\mp\rank::_id_C18C8BB0776284C6(_id_1B70C48B930405F0, _id_B01ACA3236595958);
      player.placementbonus = scripts\mp\rank::_id_9E1336D25EB66326(_id_D6A23FDABD1D282C, _id_B01ACA3236595958);
    }
  }

  level thread _id_79A4861772547BC2(team, _id_5AAB9D85460F9E87, _id_6FDDAB94C52A873C);

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(isDefined(player)) {
      player thread handlebrdefeatedpostgamestate(teamplacement, skipsplash);
      player setplacementstats(teamplacement);
      player stopchallengetimers();
      scripts\mp\gamelogic::_setplayerteamrank(player, teamplacement);
      updateclientmatchdata(player);

      if(istrue(level._id_77907D733ABE8B63))
        player _id_697B7AE06BA9B28C::_id_D1092FECB16D3B3C(teamplacement, 1, 0);
    }
  }

  setaardata(team);
}

handlebrdefeatedpostgamestate(teamplacement, skipsplash) {
  player = self;
  player endon("disconnnect");

  if(isDefined(teamplacement)) {
    if(teamplacement < 4)
      player scripts\cp_mp\pet_watch::addtop3brcharge();

    if(getdvarint("dvar_A6B52F16F3853A9A", 0) == 1)
      player _id_15038E9B270F1B31::_id_397F011C8120EA71();
    else
      player setclientomnvar("ui_br_player_position", teamplacement);
  }

  player _id_21C19CFC7139D773::_id_5B732DD6AB2EE2D6();
  starttime = gettime();

  if(!istrue(skipsplash) && !istrue(player.br_spectatorinitialized)) {
    player waittill("br_spectatorInitialized");

    if(!isDefined(player))
      return;
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz" && !istrue(player.extracted)) {
    player setclientomnvar("ui_dmz_extract_successful", 0);
    _id_5CC93630CC034274 = player getplayerdata(level._id_5D69837CF4DB0407, "currentStreakCount");

    if(isDefined(_id_5CC93630CC034274) && _id_5CC93630CC034274 > 0) {
      if(_id_5CC93630CC034274 == 1)
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("streak_fail_single", [player], undefined, 1);
      else
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("streak_fail_multiple", [player], undefined, 1);
    }
  }

  if(!istrue(skipsplash)) {
    player setclientomnvar("ui_br_squad_eliminated_active", 1);
    player setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
    player setclientomnvar("ui_round_end_reason", game["end_reason"]["br_eliminated"]);
    player setclientdvar("ui_opensummary", 1);
  }

  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    player _id_4480C6CE37B2BDF3::_id_1A425272955D5F75();
    player _id_4480C6CE37B2BDF3::_id_0865B1A5A62C49D7();
  }

  player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  player notify("br_team_fully_eliminated");
}

setplacementstats(teamplacement) {
  player = self;

  if(!isDefined(player) || istrue(player.placementstatsset)) {
    return;
  }
  player.placementstatsset = 1;
  player.teamplacement = teamplacement;
  player.pers["telemetry"].teamplacement = teamplacement;

  if(istrue(player.br_iseliminated))
    _id_4A6760982B403BAD::_id_766155419D15C501(player);

  if(teamplacement <= 25) {
    player scripts\mp\utility\stats::incpersstat("topTwentyFive", 1);

    if(teamplacement <= 10) {
      player scripts\mp\utility\stats::incpersstat("topTen", 1);

      if(teamplacement <= 5) {
        player scripts\mp\utility\stats::incpersstat("topFive", 1);

        if(teamplacement == 1)
          player scripts\mp\utility\stats::incpersstat("wins", 1);
      }
    }

    player scripts\mp\gamelogic::updateplayerleaderboardstats();
  }
}

calculatebrbonusxp(teamplacement, _id_DD267BFAB9A8D3C3) {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    return [0, 0, 0];

  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

  if(_id_FAF0D2FAC3F47583 == "dmz" || _id_FAF0D2FAC3F47583 == "exgm" || _id_FAF0D2FAC3F47583 == "plunder" || _id_FAF0D2FAC3F47583 == "risk" || _id_FAF0D2FAC3F47583 == "kingslayer")
    return [0, 0, 0];

  _id_045CC69876EE2423 = getdvarfloat("dvar_45EA3E49A354B856", 0.002);

  if(!isDefined(level.startofxptime) || !isDefined(teamplacement) || !isDefined(level.xpperplayerpershare) || (level.startofxptime <= 0 || teamplacement <= 0 || level.xpperplayerpershare <= 0))
    return [0, 0, 0];

  _id_5458808B1A085C02 = gettime() - level.startofxptime;
  _id_05DB83A557FCD180 = int(_id_045CC69876EE2423 * _id_5458808B1A085C02 + 0.5);
  _id_E2DDE397B32F23BC = int(level.xpperplayerpershare * (level.xpteamsatmatchstart - teamplacement + 1));

  if(isDefined(self)) {
    if(isDefined(self._id_9AFA50B51D5682F6)) {
      _id_05DB83A557FCD180 = _id_05DB83A557FCD180 - self._id_9AFA50B51D5682F6;
      self._id_9AFA50B51D5682F6 = self._id_9AFA50B51D5682F6 + _id_05DB83A557FCD180;
    } else
      self._id_9AFA50B51D5682F6 = _id_05DB83A557FCD180;

    if(isDefined(self._id_899C8788F1299A96)) {
      _id_B8FA7FDAAB174658 = int(max(self._id_899C8788F1299A96, _id_E2DDE397B32F23BC));
      _id_E2DDE397B32F23BC = int(max(0, _id_B8FA7FDAAB174658 - self._id_899C8788F1299A96));
      self._id_899C8788F1299A96 = self._id_899C8788F1299A96 + _id_E2DDE397B32F23BC;
    } else
      self._id_899C8788F1299A96 = _id_E2DDE397B32F23BC;
  }

  logstring("PLACEMENT PART LOGa: time=" + _id_5458808B1A085C02 + "; timeXP=" + _id_05DB83A557FCD180 + "; teamPlacement=" + teamplacement + "; placementXp=" + _id_E2DDE397B32F23BC);
  logstring("PLACEMENT PART LOGb: XP_PER_MILISECOND =" + _id_045CC69876EE2423 + "; xpPerPlayerPerShare=" + level.xpperplayerpershare);

  if(isDefined(_id_DD267BFAB9A8D3C3)) {
    players = scripts\mp\utility\teams::getteamdata(_id_DD267BFAB9A8D3C3, "players");
    validplayer = 0;

    foreach(player in players) {
      if(!player _id_7DBB8165D792B06C())
        validplayer++;
    }

    if(validplayer > 0)
      _id_E2DDE397B32F23BC = int(_id_E2DDE397B32F23BC * level.maxteamsize / validplayer);
  }

  _id_4A1681FE94A57886 = _id_05DB83A557FCD180 + _id_E2DDE397B32F23BC;
  return [_id_4A1681FE94A57886, _id_05DB83A557FCD180, _id_E2DDE397B32F23BC];
}

resetchallengetimers() {
  scripts\cp_mp\challenges::resetchallengetimer("driving");
  scripts\cp_mp\challenges::resetchallengetimer("alive_in_gas");
  scripts\cp_mp\challenges::resetchallengetimer("alive_not_downed");
}

stopchallengetimers() {
  scripts\cp_mp\challenges::stopchallengetimer("driving");
  scripts\cp_mp\challenges::stopchallengetimer("alive_in_gas");
  scripts\cp_mp\challenges::stopchallengetimer("alive_not_downed");
}

givebrbonusxp(_id_B5D67493FB854F58, objweapon, _id_401C3A2E68AAB0FD, _id_B01ACA3236595958) {
  if(!isDefined(self) || isbot(self) || istestclient(self)) {
    return;
  }
  if(!game["timePassed"]) {
    return;
  }
  if(!(scripts\mp\utility\game::matchmakinggame() || getdvarint("force_challenges"))) {
    return;
  }
  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

  if(_id_FAF0D2FAC3F47583 == "dmz" || _id_FAF0D2FAC3F47583 == "exgm" || _id_FAF0D2FAC3F47583 == "plunder" || _id_FAF0D2FAC3F47583 == "risk" || _id_FAF0D2FAC3F47583 == "kingslayer") {
    return;
  }
  if((_id_FAF0D2FAC3F47583 == "resurgence" || _id_FAF0D2FAC3F47583 == "resurgence_mgl" || _id_FAF0D2FAC3F47583 == "champion") && !getdvarint("dvar_479587858546FA68", 0)) {
    return;
  }
  if(isDefined(self.brbonusxpallowed) && self.brbonusxpallowed == 0) {
    return;
  }
  _id_719B93858D7B1C94 = 0;
  _id_8197B2CE199B9025 = 0;

  if(!isDefined(_id_401C3A2E68AAB0FD))
    _id_401C3A2E68AAB0FD = "undefined";

  switch (_id_401C3A2E68AAB0FD) {
    case "disconnect":
      _id_719B93858D7B1C94 = 1;
      _id_8197B2CE199B9025 = 1;
      break;
    case "squadEliminated":
      _id_719B93858D7B1C94 = 1;
      _id_8197B2CE199B9025 = 1;
      break;
    case "endGame":
    case "winner":
      _id_719B93858D7B1C94 = 1;
      _id_8197B2CE199B9025 = 1;
      break;
    case "undefined":
    default:
      _id_719B93858D7B1C94 = 0;
      _id_8197B2CE199B9025 = 1;
      break;
  }

  if(_id_B5D67493FB854F58 > 0) {
    scripts\mp\rank::giverankxp("stat_9BE8184EB12293BA", _id_B5D67493FB854F58, undefined, _id_719B93858D7B1C94, _id_8197B2CE199B9025, 1, _id_B01ACA3236595958);
    _id_715028F54BAD19A1::branalytics_bonusxp_debugdata(scripts\mp\rank::_id_FE885EED6609E08A(_id_B5D67493FB854F58, _id_B01ACA3236595958), _id_401C3A2E68AAB0FD);
  }

  self.brbonusxpallowed = 0;
}

setplacementxpshare() {
  _id_E0F4D3685FF5C5BC = 178107;
  _id_D176C6FA97AE9438 = _id_E0F4D3685FF5C5BC;
  _id_0774C9CA5D1D6221 = max(1, level.maxteamsize);
  _id_E34E0F7B6E831845 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "teamCount"))
      _id_E34E0F7B6E831845++;
  }

  _id_E34E0F7B6E831845 = max(1, _id_E34E0F7B6E831845);
  _id_2121AA51C2C8132E = 225;
  _id_409D356961C27474 = 5;
  _id_2CE07AC87B732035 = int(_id_E34E0F7B6E831845 * (_id_E34E0F7B6E831845 + 1) / 2);
  _id_2CE07AC87B732035 = max(_id_2CE07AC87B732035, 1);
  xpperplayerpershare = int(_id_D176C6FA97AE9438 / (_id_2CE07AC87B732035 * _id_0774C9CA5D1D6221) + 0.9);
  xpperplayerpershare = int(clamp(xpperplayerpershare, _id_409D356961C27474, _id_2121AA51C2C8132E));
  _id_FFFC590CE12509E3 = getdvarint("scr_br_placement_xp_share", xpperplayerpershare);
  logstring("PLACEMENT CALCULATION LOGa: placementPool=" + _id_E0F4D3685FF5C5BC + "; numberOfTeams=" + _id_E34E0F7B6E831845 + "; totalShares=" + _id_2CE07AC87B732035 + "; xpPerPlayerPerShare=" + xpperplayerpershare + "; xpToUse=" + _id_FFFC590CE12509E3);
  level.xpperplayerpershare = _id_FFFC590CE12509E3;
  level.xpteamsatmatchstart = _id_E34E0F7B6E831845;
  level.startofxptime = gettime();
}

giveweaponxpfromtimebr(_id_68944C6870DA247B) {
  _id_3D5DAFC30CE4635E = getdvarfloat("dvar_64AB4E1C10D28AB0", 0.0017);
  lastweaponobj = self.lastnormalweaponobj;
  value = int(_id_68944C6870DA247B * _id_3D5DAFC30CE4635E);
  givebrweaponxp("stat_0000000000000000", value, lastweaponobj, 1, 0);
}

givebrweaponxp(type, value, objweapon, _id_719B93858D7B1C94, _id_8197B2CE199B9025) {
  if(!isDefined(objweapon) || _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon) || scripts\mp\utility\weapon::isvehicleweapon(objweapon)) {
    return;
  }
  if(isDefined(self.owner) && !isbot(self)) {
    self.owner givebrweaponxp(type, value, objweapon);
    return;
  }

  if(isai(self) || !isPlayer(self)) {
    return;
  }
  if(!isDefined(value) || value <= 0) {
    return;
  }
  if(!isDefined(_id_719B93858D7B1C94))
    _id_719B93858D7B1C94 = 0;

  if(!isDefined(_id_8197B2CE199B9025))
    _id_8197B2CE199B9025 = 0;

  if(!_id_719B93858D7B1C94)
    scripts\mp\utility\points::displayscoreeventpoints(value, type);

  if(!level.playerxpenabled) {
    return;
  }
  thread waitandapplybrweaponxp(type, value, objweapon, _id_8197B2CE199B9025);
}

waitandapplybrweaponxp(type, value, objweapon, _id_8197B2CE199B9025) {
  self endon("disconnect");

  if(!isDefined(_id_8197B2CE199B9025))
    _id_8197B2CE199B9025 = 0;

  if(!_id_8197B2CE199B9025) {
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  _id_DE29895DCA8987CE = 0;

  if(!isDefined(objweapon) || !scripts\mp\weaponrank::weaponshouldgetxp(objweapon)) {
    return;
  }
  _id_DE29895DCA8987CE = value;
  _id_DE29895DCA8987CE = _id_DE29895DCA8987CE * scripts\mp\weaponrank::getweaponrankxpmultipliertotal();
  _id_DE29895DCA8987CE = int(_id_DE29895DCA8987CE);
  scripts\mp\rank::incrankxp(0, objweapon, _id_DE29895DCA8987CE, "stat_9B80F8E3667071C1");

  if(level.playerxpenabled && !isai(self)) {
    if(isDefined(objweapon) && (scripts\mp\utility\weapon::iscacprimaryweapon(objweapon) || scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon))) {
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9.weaponname = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
      _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(objweapon);
      _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "xp_earned";
      _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = _id_DE29895DCA8987CE;
      _id_7E2C53B0BCF117D9.variantid = -1;
      _id_7E2C53B0BCF117D9.weaponobj = objweapon;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
    }
  }
}

calculatepurchasexp(_id_465AB95DD1230BD3, itemtype) {
  _id_23C60C77CB5DC35B = getdvarint("dvar_B6BD80BA75FA61AF", 0);
  _id_B50692D04E77586B = getdvarfloat("dvar_0E8D8C6B25C9B387", 80);
  _id_465AB95DD1230BD3 = _id_465AB95DD1230BD3 / 100;
  _id_EAC5AC0A940E674E = _id_23C60C77CB5DC35B + int(_id_465AB95DD1230BD3 * _id_B50692D04E77586B);
  _id_700C8B9FFF678A6F = getdvarint("dvar_E3CA7808574D931B", 1000);

  if(_id_EAC5AC0A940E674E > _id_700C8B9FFF678A6F)
    _id_EAC5AC0A940E674E = _id_700C8B9FFF678A6F;

  return _id_EAC5AC0A940E674E;
}

resetpostgamestateonjoinedspectators() {
  self endon("disconnect");
  starttime = gettime();

  if(!istrue(self.br_spectatorinitialized))
    self waittill("br_spectatorInitialized");

  _id_BAD00F4B9D75DFBD = 3;
  _id_63AAD0D428C51772 = (gettime() - starttime) / 1000;

  if(_id_63AAD0D428C51772 < _id_BAD00F4B9D75DFBD)
    wait(_id_BAD00F4B9D75DFBD - _id_63AAD0D428C51772);

  self setclientomnvar("post_game_state", 0);
}

_id_A587B0B0998C6D13() {
  return istrue(level.br_debugsolotest) || (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm" || scripts\mp\utility\game::getsubgametype() == "zxp");
}

ononeleftevent(team) {
  if(_id_A587B0B0998C6D13() || !_id_227CA42A35B0398B(team)) {
    return;
  }
  if(level.teambased) {
    _id_8A4678AC12287D01 = scripts\mp\utility\game::getlastlivingplayer(team);

    if(isDefined(_id_8A4678AC12287D01)) {
      _id_8A4678AC12287D01 scripts\engine\utility::delaythread(0.5, _id_2CEDCC356F1B9FC8::brleaderdialog, "last_man_standing", 0, [_id_8A4678AC12287D01]);
      return;
    }
  } else {
    level.lastplayerwins = scripts\mp\utility\game::getlastlivingplayer();
    level thread scripts\mp\gamelogic::endgame(level.lastplayerwins, game["end_reason"]["enemies_eliminated"]);
  }
}

_id_3EB5723089C90994(victim) {
  if(istrue(victim.brneverlanded) || istrue(victim._id_91A2B1303B861667)) {
    if(!isDefined(victim._id_60D0A5246848AE8C))
      victim._id_60D0A5246848AE8C = 1;
    else
      victim._id_60D0A5246848AE8C++;

    if(victim._id_60D0A5246848AE8C >= getdvarint("dvar_F43737C13C504E05", 5))
      level thread scripts\mp\teams::kickafkplayer(victim);
  }
}

onsuicidedeath(victim) {
  if(!level.teambased) {
    _id_677AE66DF2125F53 = scripts\mp\utility\game::getlivingplayers();
    victim.score = level.totalplayers - _id_677AE66DF2125F53.size;

    foreach(player in _id_677AE66DF2125F53)
    player.score = victim.score + 1;
  }

  _id_3EB5723089C90994(victim);
}

needdefaultendgameflowonly() {
  if(isDefined(level.forcedend))
    return _id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && level.forcedend;

  return 0;
}

brendgame(winner, _id_F0500919D8C387B9, nukedetonated) {
  if(level.gameended) {
    return;
  }
  level.gameended = 1;
  waittillframeend;

  foreach(player in level.players)
  _id_4A6760982B403BAD::_id_766155419D15C501(player);

  level.gameendtime = gettime();
  level notify("game_ended");

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    level._id_C2111AF4E4ECE485 = 1;

  logstring("[KEY_MOMENT] gameEnded winner = " + scripts\engine\utility::_id_53C4C53197386572(winner, "undefined"));

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    if(_id_F0500919D8C387B9 == 25) {
      level.br_ending_delay = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("DMZTut", "empty")) {
        func = scripts\cp_mp\utility\script_utility::getsharedfunc("DMZTut", "empty");
        level.br_endgamesplashcallback = func;
      }
    } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("DMZTut", "endGameVO"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("DMZTut", "endGameVO")]]();
  }

  _id_67708F418B1FAC79::shutdowngulag("end_game", 0, 1);

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    level.gameisending = 1;

  _id_46AF76764B1FC7F0::emptyallvehicles();
  thread _id_362C58E8BB39BCDA::runbrgametypefunc("endGame", winner, _id_F0500919D8C387B9);

  if(needdefaultendgameflowonly())
    scripts\mp\gamelogic::endgame_regularmp(winner, _id_F0500919D8C387B9, game["end_reason"]["br_eliminated"], nukedetonated);
  else {
    setomnvarforallclients("ui_br_transition_type", 0);
    _id_03784E17637539B8 = undefined;
    _id_B01ACA3236595958 = undefined;

    if(isDefined(winner) && winner != "tie") {
      winnerviewsetup();
      _id_03784E17637539B8 = scripts\mp\utility\teams::getteamdata(winner, "players");

      foreach(_id_6DD753ADD7D1C236 in _id_03784E17637539B8)
      _id_6DD753ADD7D1C236 scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("event", "player_win");

      _id_3AACF02225CA0DA5::_id_025A4B6A2083E2AB(_id_03784E17637539B8);
      _id_04C15A6F75CC4A6D = 1;

      if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() && scripts\engine\utility::is_equal(_id_F0500919D8C387B9, 25))
        _id_04C15A6F75CC4A6D = 0;

      if(istrue(nukedetonated))
        _id_04C15A6F75CC4A6D = 0;

      if(_id_04C15A6F75CC4A6D)
        _id_2CEDCC356F1B9FC8::brleaderdialog("team_victory", 0, _id_03784E17637539B8);

      _id_5C6B989A6F25F7FA::_id_E50B941AFD09E62E(_id_03784E17637539B8);
      _id_03784E17637539B8 = scripts\engine\utility::array_combine(_id_03784E17637539B8, level._id_C5877DBE60FDDBF6);

      foreach(player in _id_03784E17637539B8) {
        if(!isDefined(player)) {
          continue;
        }
        [_id_B5D67493FB854F58, _id_1B70C48B930405F0, _id_D6A23FDABD1D282C] = player calculatebrbonusxp(1, winner);

        if(_id_F0500919D8C387B9 == game["end_reason"]["nuke_end"])
          _id_B5D67493FB854F58 = _id_B5D67493FB854F58 * scripts\engine\utility::ter_op(isDefined(level._id_C83AA9DBC3654AFA), level._id_C83AA9DBC3654AFA._id_09A8C945FE45C8E5._id_ECD0F4EB1E770D6C, 1);

        _id_B01ACA3236595958 = _id_09E8CCAD6488211B::_id_8B22E17D9E3AAEA3(player);

        if(istrue(player.inlaststand)) {
          if(player scripts\mp\laststand::finishreviveplayer("self_revive_on_kill_success", player))
            player scripts\mp\laststand::onrevive(1);
        }

        if(istrue(player.gasmaskequipped))
          player thread _id_7E52B56769FA7774::removegasmaskbr();

        if(istrue(player.insertingarmorplate))
          player notify("try_armor_cancel", "game_end");

        player _id_6A5D3BF7A5B7064A::onexitdeathsdoor(0);
        player _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
        player.spawnprotection = 1;

        if(!player _meth_8420670EAFC8D391())
          player setclientomnvar("ui_br_player_position", 1);
        else {
          _id_3EDA0EF65C9478AC = scripts\engine\utility::array_find(level.allteamnamelist, winner);
          player setclientomnvar("ui_br_player_position", _id_3EDA0EF65C9478AC);
        }

        player givebrbonusxp(_id_B5D67493FB854F58, undefined, "winner", _id_B01ACA3236595958);
        player.matchbonus = scripts\mp\rank::_id_C18C8BB0776284C6(_id_1B70C48B930405F0, _id_B01ACA3236595958);
        player.placementbonus = scripts\mp\rank::_id_9E1336D25EB66326(_id_D6A23FDABD1D282C, _id_B01ACA3236595958);
        player scripts\cp_mp\pet_watch::addtop3brcharge();
        _id_715028F54BAD19A1::branalytics_inventory_snapshot(player, "player_win");
        player setplacementstats(1);
        player stopchallengetimers();
        scripts\mp\gamelogic::_setplayerteamrank(player, 0);
        player scripts\mp\gamelogic::updateplayerleaderboardstats();
        updateclientmatchdata(player);
        player _id_21C19CFC7139D773::_id_5B732DD6AB2EE2D6();

        if(player ispcplayer())
          player setclientomnvar("nVidiaHighlights_events", 23);

        if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && !isbot(player))
          player thread[[level.end_game_tutorial_func]]();

        if(istrue(level._id_77907D733ABE8B63)) {
          player _id_697B7AE06BA9B28C::_id_D1092FECB16D3B3C(1, 1, 0);
          player setclientomnvar("ui_league_play_br_can_leave_with_party", 1);
        }
      }

      _id_C77C36C19FC6C0C2 = [];

      foreach(_id_1C1DEE64DF9A9C2E in level.teamnamelist) {
        if(_id_1C1DEE64DF9A9C2E == winner) {
          continue;
        }
        _id_BCE4EFC75EB01319 = _id_99E3948BFD8A99B8(_id_1C1DEE64DF9A9C2E);

        if(_id_BCE4EFC75EB01319 > 0)
          _id_C77C36C19FC6C0C2 = scripts\engine\utility::array_add(_id_C77C36C19FC6C0C2, _id_1C1DEE64DF9A9C2E);
      }

      if(_id_C77C36C19FC6C0C2.size > 0) {
        _id_C77C36C19FC6C0C2 = scripts\engine\utility::array_sort_with_func(_id_C77C36C19FC6C0C2, _id_5C6B989A6F25F7FA::_id_4B3D6AD67EBA0F73);

        for(_id_1E40D5D61118A436 = 0; _id_1E40D5D61118A436 < _id_C77C36C19FC6C0C2.size; _id_1E40D5D61118A436++) {
          _id_1C1DEE64DF9A9C2E = _id_C77C36C19FC6C0C2[_id_1E40D5D61118A436];

          if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("getGametypeTeamPlacement"))
            teamplacement = _id_362C58E8BB39BCDA::runbrgametypefunc("getGametypeTeamPlacement", _id_1C1DEE64DF9A9C2E);
          else
            teamplacement = _id_1E40D5D61118A436 + 2;

          onsquadeliminatedplacement(_id_1C1DEE64DF9A9C2E, teamplacement, undefined, 1, 1);
        }
      }

      setaardata(winner);
      level notify("team_won", winner);
    } else {
      _id_A9CEB9B39C78FB07 = [];

      foreach(_id_F90358454413407F in level.teamnamelist) {
        if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount"))
          _id_A9CEB9B39C78FB07[_id_A9CEB9B39C78FB07.size] = _id_F90358454413407F;
      }

      teamplacement = _id_A9CEB9B39C78FB07.size;

      foreach(player in level.players) {
        if(!isDefined(player)) {
          continue;
        }
        if(isbot(player) || istestclient(player)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(player)) {
          continue;
        }
        [_id_B5D67493FB854F58, _id_1B70C48B930405F0, _id_D6A23FDABD1D282C] = player calculatebrbonusxp(teamplacement);
        _id_B01ACA3236595958 = _id_09E8CCAD6488211B::_id_8B22E17D9E3AAEA3(player);
        player givebrbonusxp(_id_B5D67493FB854F58, undefined, "endGame", _id_B01ACA3236595958);
        player stopchallengetimers();
        _id_4A6760982B403BAD::_id_766155419D15C501(player);
        player.spawnprotection = 1;
        player setclientomnvar("ui_br_player_position", 1);
        player _id_21C19CFC7139D773::_id_5B732DD6AB2EE2D6();
      }

      foreach(_id_F90358454413407F in _id_A9CEB9B39C78FB07)
      setaardata(_id_F90358454413407F);
    }

    _id_F7B694A4EDF7DC9A = undefined;

    if(isDefined(_id_03784E17637539B8))
      _id_F7B694A4EDF7DC9A = _id_40F4C8F2B94C5CD9::get_center_of_array(_id_03784E17637539B8);

    activeplayers = [];

    if(getdvarint("dvar_82BDE055B11E6698", 0))
      activeplayers = _id_3ACF1C0EBAF602F2::getvalidplayersinarray(level.players, level.questinfo.defaultfilter);
    else {
      foreach(_id_8ED1AE79096AA264 in level.players) {
        if(!_id_8ED1AE79096AA264 _id_2CEDCC356F1B9FC8::isplayeringulag() && scripts\mp\utility\player::isreallyalive(_id_8ED1AE79096AA264))
          activeplayers[activeplayers.size] = _id_8ED1AE79096AA264;
      }
    }

    _id_715028F54BAD19A1::branalytics_economy_snapshot(activeplayers);
    _id_89E9BD04F1EA27F3();
    wait 1.5;
    _id_D1190CA89743235E = getdvarint("dvar_DD208E4B059EAE0F") != 1;

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && isDefined(_id_03784E17637539B8) && _id_D1190CA89743235E) {
      foreach(player in level.players)
      level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 2);

      wait 2;

      foreach(player in level.players)
      level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0.1);
    }

    if(isDefined(level.br_endgamesplashcallback))
      level thread[[level.br_endgamesplashcallback]](winner);
    else {
      if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
        foreach(player in level.players)
        player thread _id_4E187BEA631FB06A(_id_F0500919D8C387B9);
      }

      level thread handleendgamesplash(winner, nukedetonated);
      level thread handleendgamespectatingsplash(winner, nukedetonated);

      if(istrue(level.shownonspectatingwinnersplash))
        level thread handleendgamenonwinnersplash(winner, nukedetonated);

      if(isDefined(level._id_79C116F876DC27EB))
        level thread[[level._id_79C116F876DC27EB]](_id_03784E17637539B8, _id_F7B694A4EDF7DC9A);

      if(isDefined(level.br_ending_delay))
        wait(level.br_ending_delay);

      if(istrue(level.shownonspectatingwinnersplash))
        level thread handleendgamenonwinnersplash(winner, nukedetonated);
    }

    _id_362C58E8BB39BCDA::runbrgametypefunc("postEndGameSplash", winner);

    if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
      if(isDefined(level.dmztutendgame)) {
        level thread[[level.dmztutendgame]](winner, _id_F0500919D8C387B9, game["end_reason"]["br_eliminated"]);
        return;
      }
    }

    _id_0A976FF9EFE768B4(_id_03784E17637539B8, _id_F7B694A4EDF7DC9A, nukedetonated);

    if(istrue(level._id_A5C9FCD81C474AB0)) {
      level notify("spawning_intermission");
      _id_D8CB902EBFC7B2A2 = scripts\mp\gamelogic::getintermissionspawnpointoverride();

      foreach(player in level.players) {
        player thread scripts\mp\utility\game::setuipostgamefade(0);

        if(!isDefined(level.modespawnendofgame) || !player[[level.modespawnendofgame]]())
          player thread scripts\mp\playerlogic::spawnintermission(_id_D8CB902EBFC7B2A2);

        if(!istrue(player._id_A5C9FCD81C474AB0))
          player thread scripts\mp\gamelogic::_id_34AF0DDF175D84E3(nukedetonated, 1);
      }

      return;
    }

    scripts\mp\gamelogic::endgame_regularmp(winner, _id_F0500919D8C387B9, game["end_reason"]["br_eliminated"]);
  }
}

_id_4E187BEA631FB06A(_id_F0500919D8C387B9) {
  level endon("exitLevel_called");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, val);

    if(_id_7148C1A6F25491F8 == "skip_end_scene") {
      level.skipfinalkillcam = 1;
      self setclientomnvar("ui_world_fade", 1);
      self._id_A5C9FCD81C474AB0 = 1;
      _id_0F4678C9C2A5B24E::_id_150E98CD3E09D279();

      if(istrue(level._id_A5C9FCD81C474AB0))
        thread scripts\mp\gamelogic::_id_34AF0DDF175D84E3();
      else {
        level._id_A5C9FCD81C474AB0 = 1;
        level thread scripts\mp\gamelogic::endgame_regularmp(level._id_3940D363B8FB58C3, _id_F0500919D8C387B9, game["end_reason"]["br_eliminated"], undefined, undefined, undefined, self);
      }

      return;
    }
  }
}

_id_89E9BD04F1EA27F3() {
  level thread _id_715028F54BAD19A1::branalytics_endgame();
}

winnerviewsetup(winners) {}

handleendgamesplash(winner, nukedetonated) {
  _id_03784E17637539B8 = [];

  if(isDefined(winner) && winner != "tie") {
    _id_03784E17637539B8 = scripts\mp\utility\teams::getteamdata(winner, "players");
    _id_03784E17637539B8 = scripts\engine\utility::array_combine(_id_03784E17637539B8, level._id_C5877DBE60FDDBF6);
  }

  _id_464DD76C6ECB56FA = scripts\mp\gamelogic::getbrendsplashpostgamestate();
  _id_FAF0D2FAC3F47583 = scripts\mp\utility\game::getsubgametype();

  if(_id_FAF0D2FAC3F47583 == "dmz" || _id_FAF0D2FAC3F47583 == "exgm" || _id_FAF0D2FAC3F47583 == "plunder" || _id_FAF0D2FAC3F47583 == "risk" || _id_FAF0D2FAC3F47583 == "kingslayer" || _id_FAF0D2FAC3F47583 == "rumble_mgl")
    thread scripts\mp\music_and_dialog::plunder_endgame_music();

  foreach(player in _id_03784E17637539B8) {
    player setclientomnvar("post_game_state", _id_464DD76C6ECB56FA);
    player setclientomnvar("ui_br_end_game_splash_type", 1);

    if(istrue(nukedetonated)) {
      player setclientomnvar("ui_br_elite_ending", 1);

      if(!player _meth_8420670EAFC8D391())
        player setclientomnvar("ui_br_player_position", 1);
      else {
        _id_3EDA0EF65C9478AC = scripts\engine\utility::array_find(level.allteamnamelist, winner);
        player setclientomnvar("ui_br_player_position", _id_3EDA0EF65C9478AC);
      }

      continue;
    }

    if(isDefined(level._id_C83AA9DBC3654AFA) && isDefined(level._id_C83AA9DBC3654AFA.defused)) {
      if(level._id_C83AA9DBC3654AFA.defused == 1)
        level thread _id_2CF9E62C94779216();
    }
  }
}

_id_2CF9E62C94779216() {
  wait 10.0;
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 1);
  wait 5.0;
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 2);
}

handleendgamespectatingsplash(winner, nukedetonated) {
  if(isDefined(winner) && winner != "tie") {
    _id_464DD76C6ECB56FA = scripts\mp\gamelogic::getbrendsplashpostgamestate();

    foreach(player in level.players) {
      if(isDefined(player.playertospectate) && player.team != winner && !isDefined(player.hasseenendgamesplash)) {
        player setclientomnvar("post_game_state", _id_464DD76C6ECB56FA);
        player setclientomnvar("ui_br_end_game_splash_type", 1);
        player.hasseenendgamesplash = 1;

        if(istrue(nukedetonated)) {
          player setclientomnvar("ui_br_elite_ending", 1);
          player setclientomnvar("ui_br_player_position", 2);
          continue;
        }

        if(isDefined(level._id_C83AA9DBC3654AFA) && isDefined(level._id_C83AA9DBC3654AFA.defused)) {
          if(level._id_C83AA9DBC3654AFA.defused == 1)
            level thread _id_2CF9E62C94779216();
        }
      }
    }
  }
}

handleendgamenonwinnersplash(winner, nukedetonated) {
  if(isDefined(winner) && winner != "tie") {
    _id_464DD76C6ECB56FA = scripts\mp\gamelogic::getbrendsplashpostgamestate();

    foreach(player in level.players) {
      if(player.team != winner && !isDefined(player.hasseenendgamesplash)) {
        player setclientomnvar("post_game_state", _id_464DD76C6ECB56FA);
        player setclientomnvar("ui_br_end_game_splash_type", 1);
        player.hasseenendgamesplash = 1;

        if(istrue(nukedetonated)) {
          player setclientomnvar("ui_br_elite_ending", 1);
          player setclientomnvar("ui_br_player_position", 2);
          continue;
        }

        if(isDefined(level._id_C83AA9DBC3654AFA) && isDefined(level._id_C83AA9DBC3654AFA.defused)) {
          if(level._id_C83AA9DBC3654AFA.defused == 1)
            level thread _id_2CF9E62C94779216();
        }
      }
    }
  }
}

_id_0A976FF9EFE768B4(_id_03784E17637539B8, _id_F7B694A4EDF7DC9A, nukedetonated) {
  if(isDefined(_id_03784E17637539B8) && isDefined(_id_F7B694A4EDF7DC9A)) {
    if(istrue(nukedetonated))
      _id_728FFCEE8CBF30EE::_id_F6E0BDD81A472B97(_id_03784E17637539B8);
    else
      _id_5C6B989A6F25F7FA::play_ending(_id_03784E17637539B8, _id_F7B694A4EDF7DC9A);
  }
}

_id_AB41ACC7AC2F6642(_id_421750C958BD3064) {
  return _id_421750C958BD3064 & 255;
}

_id_86081F65C04E8EBE(_id_421750C958BD3064) {
  return (_id_421750C958BD3064 & 65280) >> 8;
}

_id_7C646C29EA7FCB5A(itemtype, _id_3793828403C6873E) {
  if(itemtype == 10) {
    [lootid, quantity] = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(_id_3793828403C6873E);

    if(_id_7E52B56769FA7774::_id_F96674BA1A1EC2B3(lootid))
      return 1;
  }

  return 0;
}

_id_DB908ECACCBE933C(_id_EA3E3B2121E6713A, _id_421750C958BD3064) {
  if(istrue(level.infilcinematicactive) || istrue(self.jailed)) {
    return;
  }
  if(istrue(self.isjuggernaut) && (_id_421750C958BD3064 == 256 || _id_421750C958BD3064 == 257)) {
    return;
  }
  if(isDefined(_id_EA3E3B2121E6713A)) {
    switch (_id_EA3E3B2121E6713A) {
      case "drop_item":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(!_id_420EC7054801A5BD(itemtype, _id_3793828403C6873E)) {
          break;
        }

        if(istrue(self._id_859654E0445A36D9) && itemtype == 1) {
          if(isDefined(level.br_pickups._id_355CDDB773CB000D))
            scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);

          break;
        }

        if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
          if(isDefined(level.br_pickups._id_7C27D71DBF683991))
            scripts\mp\hud_message::showerrormessage(level.br_pickups._id_7C27D71DBF683991);

          break;
        }

        if(_id_048614492EF09B23::_id_5711A00587F71794(self) && (_id_048614492EF09B23::_id_1225F23A18664F4C(self) || itemtype != 1))
          _id_048614492EF09B23::_id_80BADA2833945A7A(itemtype, _id_3793828403C6873E);
        else
          thread _id_7E52B56769FA7774::quickdropitem(itemtype, _id_3793828403C6873E);

        if(isDefined(self._id_02FA5B49969DEF47) && isDefined(self._id_02FA5B49969DEF47._id_46A3A8565AC0C17C) && self._id_02FA5B49969DEF47._id_46A3A8565AC0C17C == 14)
          thread _id_7E52B56769FA7774::_id_F7E756154EC35632(itemtype, _id_3793828403C6873E);

        break;
      case "drop_all_items":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(istrue(self.insertingarmorplate) && itemtype == 2 && "health" == scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E)) {
          break;
        }

        if(!_id_420EC7054801A5BD(itemtype, _id_3793828403C6873E)) {
          break;
        }

        if(istrue(self._id_859654E0445A36D9) && itemtype == 1) {
          if(isDefined(level.br_pickups._id_355CDDB773CB000D))
            scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);

          break;
        }

        if(scripts\cp_mp\utility\player_utility::isinvehicle() && !_id_7C646C29EA7FCB5A(itemtype, _id_3793828403C6873E)) {
          if(isDefined(level.br_pickups._id_7C27D71DBF683991))
            scripts\mp\hud_message::showerrormessage(level.br_pickups._id_7C27D71DBF683991);

          break;
        }

        if(_id_048614492EF09B23::_id_5711A00587F71794(self) && (_id_048614492EF09B23::_id_1225F23A18664F4C(self) || itemtype != 1))
          _id_048614492EF09B23::_id_80BADA2833945A7A(itemtype, _id_3793828403C6873E, undefined, 1);
        else
          _id_7E52B56769FA7774::quickdropall(itemtype, _id_3793828403C6873E);

        if(isDefined(self._id_02FA5B49969DEF47) && isDefined(self._id_02FA5B49969DEF47._id_46A3A8565AC0C17C) && self._id_02FA5B49969DEF47._id_46A3A8565AC0C17C == 14)
          thread _id_7E52B56769FA7774::_id_F7E756154EC35632(itemtype, _id_3793828403C6873E);

        break;
      case "backpack_equip":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(!_id_420EC7054801A5BD(itemtype, _id_3793828403C6873E, 1)) {
          break;
        }

        if(itemtype == 1 && _id_3793828403C6873E == 2) {
          _id_B9976CC76957A593 = _id_724736FCF0FB6604::_id_27EF2C36EB95D796();

          if(_id_F32857A938336F2B(self, _id_B9976CC76957A593)) {
            break;
          }

          _id_2D9D24F7C63AC143::_id_F5A1A13F0181BB66(self, undefined, 1);
        } else
          thread _id_7E52B56769FA7774::_id_CAB3366841D709AA(_id_3793828403C6873E);

        break;
      case "sell_item":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(itemtype == 10)
          _id_7E52B56769FA7774::_id_F1A38D2BA0BBCB08(self, _id_3793828403C6873E);

        break;
      case "sell_all_item":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(itemtype == 10)
          _id_7E52B56769FA7774::_id_F1A38D2BA0BBCB08(self, _id_3793828403C6873E, 1);

        break;
      case "sell_all_valuables":
        _id_7E52B56769FA7774::_id_64F0398B29CF7C3E(self);
        break;
      case "weapon_to_backpack":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(itemtype != 1) {
          break;
        }

        if(istrue(self._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
          scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
          break;
        }

        _id_17D89F18C1D0EB4F = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(self, _id_3793828403C6873E);
        _id_D5ADAFA612D0BA43 = scripts\engine\utility::ter_op(_id_3793828403C6873E == 1, 0, 1);
        _id_929E81472980EC28 = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(self, _id_D5ADAFA612D0BA43);

        if(!isDefined(_id_17D89F18C1D0EB4F)) {
          break;
        }

        if(_id_17D89F18C1D0EB4F.basename == "iw9_me_fists_mp" || scripts\mp\utility\weapon::_id_1E9278BA699927F7(_id_17D89F18C1D0EB4F) || _id_17D89F18C1D0EB4F.basename == "iw9_nukecore_artifact_mp") {
          break;
        }

        if(_id_F32857A938336F2B(self, _id_17D89F18C1D0EB4F)) {
          break;
        }

        if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self)) {
          _id_2D9D24F7C63AC143::_id_F5A1A13F0181BB66(self, _id_17D89F18C1D0EB4F, 1);
          break;
        }

        _id_E1147886CCF51970 = _id_724736FCF0FB6604::_id_86A5C7670325346B(self, _id_3793828403C6873E);
        _id_2D9D24F7C63AC143::_id_705889B7586CF34E(self, _id_17D89F18C1D0EB4F, _id_3793828403C6873E);
        _id_724736FCF0FB6604::_id_AE30366A2D519A57(self, _id_3793828403C6873E, undefined);
        _id_724736FCF0FB6604::_id_AE30366A2D519A57(self, 2, _id_E1147886CCF51970);
        self takeweapon(_id_17D89F18C1D0EB4F);
        _id_3184653FDF31DB44 = undefined;

        if(!self hasweapon("iw9_me_fists_mp")) {
          _id_3184653FDF31DB44 = makeweapon("iw9_me_fists_mp");
          self giveweapon(_id_3184653FDF31DB44);
        }

        if(isDefined(_id_929E81472980EC28))
          self switchtoweapon(_id_929E81472980EC28);
        else if(isDefined(_id_3184653FDF31DB44))
          self switchtoweapon(_id_3184653FDF31DB44);

        break;
      case "stow_ground_loot":
        if(istrue(self.gulagarena) && !level._id_43307855F189EB31._id_EF02A6EC3343C9BD) {
          scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/CANNOT_STOW_IN_GULAG");
          break;
        }

        _id_27F4861ED723E273 = _id_421750C958BD3064;
        _id_A23A9D12025E9230 = getentitylessscriptablearray(undefined, undefined, self.origin, 110);
        _id_F043DFD27DC3C769 = [];

        foreach(scriptable in _id_A23A9D12025E9230) {
          if(!scriptable getscriptableisloot() && (!isDefined(scriptable.type) || isDefined(scriptable.type) && scriptable.type != "brloot_weapon_pi_decho_golden")) {
            continue;
          }
          lootid = undefined;
          iscustomweapon = 0;
          scriptablename = _id_7E52B56769FA7774::_id_155B1A2C8879BDA5(scriptable);

          if(isDefined(scriptable.type) && scriptable getscriptablehaspart(scriptable.type) && scriptable getscriptablepartstate(scriptable.type) == "hidden") {
            continue;
          }
          if(_id_7E52B56769FA7774::isweaponpickup(scriptablename)) {
            if(!scripts\mp\loot::isweaponitem(_id_27F4861ED723E273)) {
              continue;
            }
            if(isDefined(scriptable.customweaponname)) {
              lootid = _id_2669878CF5A1B6BC::_id_B0D37B9BE0027733(scriptable.customweaponname);
              iscustomweapon = 1;
            } else {
              weaponobj = _id_7E52B56769FA7774::getfullweaponobjforpickup(scriptable);
              lootid = _id_2669878CF5A1B6BC::_id_9C331F88BE5A1478(weaponobj);
            }
          } else
            lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);

          if(isDefined(lootid) && (_id_27F4861ED723E273 == lootid || iscustomweapon))
            _id_F043DFD27DC3C769[_id_F043DFD27DC3C769.size] = scriptable;
        }

        _id_5D9D8662FC4251B8 = undefined;

        if(_id_F043DFD27DC3C769.size == 1)
          _id_5D9D8662FC4251B8 = _id_F043DFD27DC3C769[0];
        else if(_id_F043DFD27DC3C769.size > 1) {
          _id_2B5718884854AA2B = 0;
          _id_20AF753DED3657E1 = anglesToForward(self getplayerangles());

          foreach(scriptable in _id_F043DFD27DC3C769) {
            _id_CAC6B8B7EFDDB0E4 = scriptable.origin - self.origin;
            _id_E6D3398E6E00BB9E = vectorNormalize(_id_CAC6B8B7EFDDB0E4);
            angle = vectordot(_id_20AF753DED3657E1, _id_E6D3398E6E00BB9E);

            if(angle > 0 && angle > _id_2B5718884854AA2B) {
              _id_2B5718884854AA2B = angle;
              _id_5D9D8662FC4251B8 = scriptable;
            }
          }
        }

        _id_2D9D24F7C63AC143::_id_A763F6F503206771(self, _id_5D9D8662FC4251B8, _id_27F4861ED723E273);
        break;
      case "item_to_backpack":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(!_id_420EC7054801A5BD(itemtype, _id_3793828403C6873E)) {
          break;
        }

        _id_13ECA9A3244E502F = _id_2D9D24F7C63AC143::_id_CF1BEF64E94F2D1A(itemtype, _id_3793828403C6873E);

        if(!isDefined(_id_13ECA9A3244E502F)) {
          break;
        }

        lootid = _id_13ECA9A3244E502F[0];
        quantity = _id_13ECA9A3244E502F[1];

        if(!isDefined(lootid) || !isDefined(quantity) || lootid == 0 || quantity == 0) {
          break;
        }

        _id_7E52B56769FA7774::_id_D8CD9C1941A88194(lootid, quantity, undefined, 1, 1, 1);
        thread _id_7E52B56769FA7774::quickdropall(itemtype, _id_3793828403C6873E, 1);

        if(isDefined(self._id_02FA5B49969DEF47) && isDefined(self._id_02FA5B49969DEF47._id_46A3A8565AC0C17C) && self._id_02FA5B49969DEF47._id_46A3A8565AC0C17C == 14)
          thread _id_7E52B56769FA7774::_id_F7E756154EC35632(itemtype, _id_3793828403C6873E);

        break;
      case "drop_stock_ammo":
        _id_3793828403C6873E = _id_421750C958BD3064;
        _id_DE88CD14114C1E24 = _id_7E52B56769FA7774::_id_13ECF3644442A3E7(self, _id_3793828403C6873E);

        if(!isDefined(_id_DE88CD14114C1E24)) {
          break;
        }

        if(_id_F32857A938336F2B(self, _id_DE88CD14114C1E24) || self isreloading()) {
          break;
        }

        ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

        if(isDefined(ammotype) && isDefined(self.br_ammo[ammotype]) && self.br_ammo[ammotype] > 0) {
          _id_CD87B28B548D9F4A = level.br_pickups.counts[ammotype];

          if(!isDefined(_id_CD87B28B548D9F4A)) {
            break;
          }

          _id_1F11155517C54C34 = int(min(self.br_ammo[ammotype], _id_CD87B28B548D9F4A));
          _id_74806F0C4CAA7E55 = _id_1F11155517C54C34;
          _id_975C95468376CEE8 = scripts\engine\utility::ter_op(_id_3793828403C6873E == 2, self.br_ammo[ammotype], self getweaponammostock(_id_DE88CD14114C1E24));

          if(self.br_ammo[ammotype] > _id_975C95468376CEE8) {
            _id_74806F0C4CAA7E55 = _id_1F11155517C54C34 + self.br_ammo[ammotype] - _id_975C95468376CEE8;

            if(_id_74806F0C4CAA7E55 > self.br_ammo[ammotype]) {
              _id_1F11155517C54C34 = _id_975C95468376CEE8;
              _id_74806F0C4CAA7E55 = self.br_ammo[ammotype];
            }
          }

          if(_id_1F11155517C54C34 > 0)
            _id_7E52B56769FA7774::quickdropnewitem(10, ammotype, _id_1F11155517C54C34);

          _id_724736FCF0FB6604::br_ammo_take_type(self, ammotype, _id_74806F0C4CAA7E55);
        }

        break;
      case "loadout_enter_decision_layer":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(!_id_420EC7054801A5BD(itemtype, _id_3793828403C6873E)) {
          break;
        }

        if(scripts\mp\loot::_id_6F45E7311F77EAC4(self)) {
          break;
        }

        _id_13ECA9A3244E502F = _id_2D9D24F7C63AC143::_id_CF1BEF64E94F2D1A(itemtype, _id_3793828403C6873E);

        if(!isDefined(_id_13ECA9A3244E502F)) {
          break;
        }

        lootid = _id_13ECA9A3244E502F[0];
        quantity = _id_13ECA9A3244E502F[1];
        thread _id_7E52B56769FA7774::quickdropall(itemtype, _id_3793828403C6873E, 1);
        scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(self.origin, self.angles);
        pickup = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, quantity, 0);

        if(pickup getscriptableparthasstate(scriptablename, "hidden"))
          pickup setscriptablepartstate(scriptablename, "hidden");

        _id_491C9B4E02748831 = pickup;
        _id_491C9B4E02748831.contents = [];
        _id_491C9B4E02748831._id_46A3A8565AC0C17C = 14;
        _id_491C9B4E02748831.contents[0] = [];
        _id_491C9B4E02748831.contents[0]["quantity"] = pickup.count;
        _id_491C9B4E02748831.contents[0]["lootID"] = lootid;
        _id_491C9B4E02748831._id_0343C584E7E00192 = 1;
        _id_491C9B4E02748831.itemtype = itemtype;
        _id_491C9B4E02748831._id_3793828403C6873E = _id_3793828403C6873E;
        scripts\mp\loot::_id_68CA06034B8AACCD(self, _id_491C9B4E02748831);
        break;
      case "barter_item":
        if(!istrue(level._id_C153EAC6E7C0E1A2)) {
          break;
        }

        _id_A073D6E49197691F = _id_421750C958BD3064;

        if(!isDefined(_id_A073D6E49197691F)) {
          break;
        }

        result = _id_342E51952B63E594::_id_B03A252F9AB9BCFD(self, _id_A073D6E49197691F);

        if(result) {
          self setclientomnvar("ui_barter_success", 1);
          level thread _id_342E51952B63E594::_id_2B4F0BEA679346EF(self);
        }

        break;
      case "drag_and_drop_bp_in_swapping":
        _id_47868F432C8FCB6B = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_5E7CE68553217EAF = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(istrue(self._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
          scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
          break;
        }

        if(_id_55E418C5CC946593::_id_C0D385A09D173A36()) {
          _id_24B33F095A509811 = _id_55E418C5CC946593::_id_3634D41E203BC04E(_id_47868F432C8FCB6B);
          _id_24B33C095A509178 = _id_55E418C5CC946593::_id_3634D41E203BC04E(_id_5E7CE68553217EAF);

          if(isDefined(_id_24B33F095A509811) && isDefined(_id_24B33F095A509811.perks)) {
            _id_55E418C5CC946593::_id_222999AAD19F5B52(_id_5E7CE68553217EAF, _id_24B33F095A509811.perks);
            _id_55E418C5CC946593::_id_E8FD3389A3F6433A(_id_47868F432C8FCB6B);
          }

          if(isDefined(_id_24B33C095A509178) && isDefined(_id_24B33C095A509178.perks)) {
            _id_55E418C5CC946593::_id_222999AAD19F5B52(_id_47868F432C8FCB6B, _id_24B33C095A509178.perks);

            if(!isDefined(_id_24B33F095A509811))
              _id_55E418C5CC946593::_id_E8FD3389A3F6433A(_id_5E7CE68553217EAF);
          }
        }

        _id_2D9D24F7C63AC143::_id_68BCA2C2E9F0A1D3(_id_47868F432C8FCB6B, _id_5E7CE68553217EAF);
        break;
      case "drag_and_drop_weapon_in_swapping":
        _id_B9976CC76957A593 = self getcurrentweapon();

        if(scripts\mp\utility\weapon::_id_1E9278BA699927F7(_id_B9976CC76957A593)) {
          break;
        }

        if(_id_F32857A938336F2B(self, _id_B9976CC76957A593)) {
          break;
        }

        if(istrue(self._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
          scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
          break;
        }

        _id_2D9D24F7C63AC143::_id_1D982E57487B7EFE();
        break;
      case "backpack_weapon_to_loadout_drag_and_drop":
        _id_B9976CC76957A593 = self getcurrentweapon();

        if(_id_F32857A938336F2B(self, _id_B9976CC76957A593)) {
          break;
        }

        if(istrue(self._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
          scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
          break;
        }

        _id_6B280ABE56564AC7 = self.primaryweapons[_id_421750C958BD3064];

        if(!scripts\mp\utility\weapon::_id_1E9278BA699927F7(_id_6B280ABE56564AC7))
          _id_2D9D24F7C63AC143::_id_F5A1A13F0181BB66(self, _id_6B280ABE56564AC7, 1);

        break;
      case "container_weapon_to_loadout_drag_and_drop":
        _id_03DE70F4007CA2C9 = _id_421750C958BD3064 & 255;
        _id_D54A79024C228770 = _id_421750C958BD3064 >> 8;
        _id_B9976CC76957A593 = self getcurrentweapon();

        if(_id_F32857A938336F2B(self, _id_B9976CC76957A593)) {
          break;
        }

        if(istrue(self._id_859654E0445A36D9) && isDefined(level.br_pickups._id_355CDDB773CB000D)) {
          scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
          break;
        }

        _id_2D9D24F7C63AC143::_id_51301C83420D42B4(_id_03DE70F4007CA2C9, _id_D54A79024C228770);
        break;
      case "loot_container_to_specific_backpack_slot":
        _id_D54A79024C228770 = _id_421750C958BD3064 >> 8;
        _id_65B695F0C0D909ED = _id_421750C958BD3064 & 255;
        _id_2D9D24F7C63AC143::_id_CE92A41B8F3B666F(_id_65B695F0C0D909ED, _id_D54A79024C228770);
        break;
      case "loadout_to_specific_backpack_slot":
        _id_65B695F0C0D909ED = _id_421750C958BD3064 & 1023;
        _id_421750C958BD3064 = _id_421750C958BD3064 >> 10;
        _id_3793828403C6873E = _id_421750C958BD3064 & 1023;
        _id_421750C958BD3064 = _id_421750C958BD3064 >> 10;
        itemtype = _id_421750C958BD3064 & 1023;
        _id_2D9D24F7C63AC143::_id_9F1F9042105E4240(itemtype, _id_3793828403C6873E, _id_65B695F0C0D909ED);
        break;
      default:
        break;
    }
  }
}

_id_420EC7054801A5BD(itemtype, _id_3793828403C6873E, _id_2EB789D043254817) {
  if(!scripts\mp\utility\player::_id_AD443BBCDCF37B85(self))
    return 0;

  if(istrue(self.insertingarmorplate) && itemtype == 2 && "health" == scripts\mp\equipment::_id_4967838290CB31B9(_id_3793828403C6873E))
    return 0;

  issuper = 0;
  _id_161692D8FA9CEBEC = 0;

  if(itemtype == 10 && istrue(_id_2EB789D043254817)) {
    [lootid, quantity] = _id_2D9D24F7C63AC143::_id_6738846DA50730F1(_id_3793828403C6873E);
    lootid = scripts\engine\utility::_id_53C4C53197386572(lootid, 0);
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

    if(isDefined(scriptablename)) {
      issuper = _id_7E52B56769FA7774::issuperpickup(scriptablename);
      _id_161692D8FA9CEBEC = _id_2CEDCC356F1B9FC8::isequipment(scriptablename);
    }
  }

  if((self isthrowinggrenade() || self isgestureplaying("ges_vm_offhand_1h_stim_inject")) && (itemtype == 2 || itemtype == 4 || issuper || _id_161692D8FA9CEBEC))
    return 0;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(self getcurrentweapon()))
    return 0;

  if(itemtype == 10 && isDefined(self._id_0E0C39101BFC15D2) && istrue(self._id_0E0C39101BFC15D2[_id_3793828403C6873E]))
    return 0;

  if(itemtype == 4) {
    _id_13ECA9A3244E502F = _id_2D9D24F7C63AC143::_id_CF1BEF64E94F2D1A(itemtype, _id_3793828403C6873E);

    if(!isDefined(_id_13ECA9A3244E502F) || _id_13ECA9A3244E502F.size <= 1)
      return 0;

    lootid = _id_13ECA9A3244E502F[0];
    quantity = _id_13ECA9A3244E502F[1];

    if(!isDefined(lootid) || !isDefined(quantity) || lootid == 0 || quantity == 0)
      return 0;

    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

    if(!isDefined(scriptablename))
      return 0;

    if((scripts\mp\supers::issuperinuse() || scripts\mp\supers::_id_565913010C84FFCA()) && !_id_7E52B56769FA7774::_id_1BE34022A4ACCE73(scriptablename))
      return 0;

    if(_id_7E52B56769FA7774::_id_907944A173ED27E1(scriptablename))
      return 0;
  }

  if(itemtype == 1) {
    _id_13ECA9A3244E502F = _id_2D9D24F7C63AC143::_id_CF1BEF64E94F2D1A(itemtype, _id_3793828403C6873E);

    if(!isDefined(_id_13ECA9A3244E502F) || _id_13ECA9A3244E502F.size <= 1 || !isDefined(_id_13ECA9A3244E502F[2]))
      return 0;

    weaponobj = _id_13ECA9A3244E502F[2];
    basename = getweaponbasename(weaponobj);

    if(basename == "iw9_nukecore_artifact_mp")
      return 0;
  }

  return 1;
}

_id_1C7F3F4E23F94F86(scriptablename) {
  if(!scripts\mp\utility\player::_id_AD443BBCDCF37B85(self))
    return 0;

  if(!isDefined(scriptablename))
    return 1;

  if(istrue(self.insertingarmorplate) && _id_2CEDCC356F1B9FC8::isarmorplate(scriptablename))
    return 0;

  issuper = _id_7E52B56769FA7774::issuperpickup(scriptablename);
  _id_161692D8FA9CEBEC = _id_2CEDCC356F1B9FC8::isequipment(scriptablename);
  _id_36DE08EA672B354C = _id_7E52B56769FA7774::_id_36DE08EA672B354C(scriptablename);

  if((self isthrowinggrenade() || self isgestureplaying("ges_vm_offhand_1h_stim_inject")) && (issuper || _id_161692D8FA9CEBEC))
    return 0;

  if(istrue(scripts\mp\supers::issuperdisabled()) && issuper)
    return 0;

  if(_id_36DE08EA672B354C)
    return _id_55E418C5CC946593::_id_BDD930EEE0042052();

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(self getcurrentweapon()))
    return 0;

  return 1;
}

_id_F32857A938336F2B(player, _id_A1C804FFA2416774) {
  return isDefined(player) && isDefined(player._id_55562BD5EB6065E5) && isDefined(_id_A1C804FFA2416774) && player._id_55562BD5EB6065E5 != player getweaponammoclip(_id_A1C804FFA2416774);
}

get_int_or_0(value) {
  if(!isDefined(value))
    return 0;

  return int(value);
}

parachutecomplete() {
  if(brdoesloadoutoptionusedropbags() && !brareloadoutdropbagsdelayed() && !istrue(self.dropbagspawned) && !istrue(level.precomputeddropbags)) {
    if(_id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
      thread _id_4D5A55FCA0ED1835::spawndropbagonlanding();

      foreach(player in level.teamdata[self.team]["players"])
      player.dropbagspawned = 1;
    }
  }

  if(scripts\mp\flags::gameflag("prematch_done"))
    thread _id_4384ABBF498DF6A7::showdiscountsplash(5);
}

spawnintermission(spawnorigin, spawnangles) {
  scripts\mp\playerlogic::setspawnvariables();
  self freezecontrols(1);
  scripts\mp\utility\player::updatesessionstate("intermission");
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  self spawn(spawnorigin, spawnangles);
  scripts\mp\utility\player::printspawnmessage("playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + spawnorigin);
  scripts\mp\utility\player::setdof_spectator();
}

brprewaitandspawnclient(_id_9156B53BCF7CE573) {
  if(!isDefined(self.prespawnspawn) || self isplayerheadless()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  thread brprewaitandspawnclientcleanup();

  if(!isDefined(self.initialprespawn) && !istrue(_id_9156B53BCF7CE573)) {
    _id_11F3B4465C8B637B = self.prespawnspawn.origin;
    droporigin = _id_2CEDCC356F1B9FC8::playerstreamhintdroptoground(_id_11F3B4465C8B637B);
    timeout = getdvarint("dvar_6CE81E74109AF8D3", 9000);
    _id_2CEDCC356F1B9FC8::playerstreamhintlocation(droporigin, timeout, 1);

    if(!istrue(level.x1playertransition) && !istrue(self.x1playertransition)) {
      _id_258C4F40DEE8189A();
      self setclientomnvar("ui_br_transition_type", 4);
    }

    wait 0.5;
    spawnintermission(droporigin, self.prespawnspawn.angles);
    scripts\mp\spectating::setdisabled();
  } else
    self.initialprespawn = undefined;

  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  self freezecontrols(0);
}

_id_6760D3783DFAC7DD(_id_9156B53BCF7CE573) {
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  self setclientomnvar("ui_br_extended_load_screen", 0);
  self freezecontrols(0);
}

brprewaitandspawnclientcleanup() {
  self endon("disconnect");
  self waittill("brWaitAndSpawnClientComplete");
  self clearpredictedstreampos();

  if(!istrue(level.x1playertransition))
    self setclientomnvar("ui_br_transition_type", 0);

  self setclientomnvar("ui_br_extended_load_screen", 0);
}

brprematchaddkill() {
  self.kills++;
}

bronattackerdamagenottracked(damage) {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    self.pers["damage"] = self.pers["damage"] + damage;
}

brclearscoreboardstats() {
  foreach(player in level.players) {
    player.kills = 0;
    player.pers["kills"] = 0;
    player.deaths = 0;
    player.pers["deaths"] = 0;
    player.score = 0;
    player.pers["score"] = 0;
    player.brmissionscompleted = 0;
    player.pers["contracts"] = 0;
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("missionsCompleted", 0);
    player.pers["damage"] = 0;
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("damageDealt", 0);
  }
}

brclosealldoors(_id_41252DD8A866AD6A) {
  level endon("game_ended");
  doors = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "door");
  _id_3C98CA3B59C3EFEF = 0;
  _id_884A98392CE1109B = isDefined(_id_41252DD8A866AD6A) && isint(_id_41252DD8A866AD6A);

  foreach(door in doors) {
    if(!door scriptabledoorisclosed() && door getscriptablepartstate("door") != "invisible") {
      door scriptabledoorclose();

      if(_id_884A98392CE1109B) {
        _id_3C98CA3B59C3EFEF++;

        if(_id_3C98CA3B59C3EFEF >= _id_41252DD8A866AD6A) {
          _id_3C98CA3B59C3EFEF = 0;
          waitframe();
        }
      }
    }
  }
}

_id_4F4B9A3C68AF0F7B(_id_3A7FA5A908D33403) {
  _id_624F473FE3EE62F1 = spawnStruct();
  thread _id_D031B5B9BF72725B(_id_624F473FE3EE62F1);
  thread _id_FDC0CF0E13EF442B(_id_624F473FE3EE62F1, _id_3A7FA5A908D33403);
  _id_624F473FE3EE62F1 waittill("waittill_proc");
  return _id_624F473FE3EE62F1.result;
}

_id_D031B5B9BF72725B(_id_624F473FE3EE62F1) {
  _id_624F473FE3EE62F1 endon("waittill_proc");
  self waittill("luinotifyserver", _id_7148C1A6F25491F8, _id_0AC2E2DC79F3D177);
  _id_624F473FE3EE62F1.result = [_id_7148C1A6F25491F8, _id_0AC2E2DC79F3D177];
  _id_624F473FE3EE62F1 notify("waittill_proc");
}

_id_FDC0CF0E13EF442B(_id_624F473FE3EE62F1, _id_3A7FA5A908D33403) {
  _id_624F473FE3EE62F1 endon("waittill_proc");
  wait(_id_3A7FA5A908D33403);
  _id_624F473FE3EE62F1 notify("waittill_proc");
}

playerselectspawnclass() {
  self endon("death_or_disconnect");
  self endon("last_stand_start");
  self endon("halo_kick_c130");
  level endon("game_ended");
  level endon("end_spawn_selection");

  if(getdvarint("dvar_206A763969420CE0", 0) == 1 && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm" && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "sandbox" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
    _id_891D91911E4C1ADE = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
    scripts\mp\utility\script::demoforcesre("playerSelectSpawnClass() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + _id_891D91911E4C1ADE);
  }

  self setclientomnvar("ui_options_menu", 2);
  _id_D2505540B9FF998C = "custom1";
  self.pers["class"] = _id_D2505540B9FF998C;
  self.class = _id_D2505540B9FF998C;
  scripts\mp\class::preloadandqueueclass(_id_D2505540B9FF998C);
  _id_646A3262E2AA2948 = getdvarfloat("dvar_006F432A1782BEB1", 10.0);
  _id_5493CF7A76FF4176 = 0.0;
  _id_009C35BA153F8C42 = _id_646A3262E2AA2948 > 0.0;

  for(;;) {
    _id_7148C1A6F25491F8 = undefined;
    _id_0AC2E2DC79F3D177 = undefined;

    if(_id_009C35BA153F8C42) {
      result = _id_4F4B9A3C68AF0F7B(1.0);

      if(!isDefined(result)) {
        _id_5493CF7A76FF4176 = _id_5493CF7A76FF4176 + 1.0;

        if(_id_5493CF7A76FF4176 > _id_646A3262E2AA2948) {
          self setclientomnvar("ui_options_menu", 0);
          return 0;
        }

        self setclientomnvar("ui_options_menu", 2);
        continue;
      }

      _id_7148C1A6F25491F8 = result[0];
      _id_0AC2E2DC79F3D177 = result[1];
    } else
      self waittill("luinotifyserver", _id_7148C1A6F25491F8, _id_0AC2E2DC79F3D177);

    if(_id_7148C1A6F25491F8 == "exit_loadout_bag")
      return 0;
    else if(_id_7148C1A6F25491F8 != "class_select") {
      continue;
    }
    _id_EAABF9463637080F = 0;

    if(_id_0AC2E2DC79F3D177 >= 0) {
      _id_2D36749FDFFC49B4 = scripts\mp\menus::getclasschoice(_id_0AC2E2DC79F3D177);
      self.pers["class"] = _id_2D36749FDFFC49B4;
      self.class = _id_2D36749FDFFC49B4;
      scripts\mp\class::preloadandqueueclass(_id_2D36749FDFFC49B4);
      _id_EAABF9463637080F = 1;
    }

    return _id_EAABF9463637080F;
  }
}

playerstartselectspawnclassnonexclusion() {
  player = self;
  player endon("disconnect");
  player freezecontrols(1);

  if(brdoesloadoutoptionrequireclassselection())
    player playerselectspawnclass();

  player setclientomnvar("ui_options_menu", 0);
  player freezecontrols(0);
}

monitorjumpmasterclaim() {
  player = self;
  player endon("disconnect");
  player thread listenforjumpmasterclaimluanotify();
  _id_9770425DA56E6488 = 0;

  while(!scripts\mp\flags::gameflag("end_spawn_selection")) {
    msg = player scripts\engine\utility::waittill_any_ents_return(player, "attempt_jumpmaster_claim", player, "squad_jumpmaster_claimed", level, "end_spawn_selection");

    if(msg == "attempt_jumpmaster_claim") {
      if(!_id_9770425DA56E6488) {
        player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("jumpMasterState", 2);
        player.issquadleader = 1;
        player scripts\mp\utility\lower_message::setlowermessageomnvar("br_player_is_jumpmaster");
        members = scripts\mp\utility\teams::getfriendlyplayers(player.team, 0);

        foreach(_id_80EF668C09FFB70F in members) {
          if(_id_80EF668C09FFB70F != player) {
            _id_80EF668C09FFB70F.issquadleader = 0;
            _id_80EF668C09FFB70F _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("jumpMasterState", 0);
            _id_80EF668C09FFB70F notify("squad_jumpmaster_claimed");
            _id_80EF668C09FFB70F scripts\mp\utility\lower_message::setlowermessageomnvar("br_teammate_is_jumpmaster");
          }
        }
      } else {
        player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("jumpMasterState", 1);
        player scripts\mp\utility\lower_message::setlowermessageomnvar("br_player_deploy_solo");
      }

      continue;
    }

    if(msg == "squad_jumpmaster_claimed")
      _id_9770425DA56E6488 = 1;
  }
}

listenforjumpmasterclaimluanotify() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("listenClaimJumpMaster");
  player endon("listenClaimJumpMaster");
  level endon("end_spawn_selection");

  for(;;) {
    player waittill("luinotifyserver", _id_EA3E3B2121E6713A);

    if(_id_EA3E3B2121E6713A == "attempt_jumpmaster_claim")
      player notify("attempt_jumpmaster_claim");
  }
}

sendafksquadmembertogulag() {
  player = self;
  player.br_infilstarted = 1;
  player setclientomnvar("ui_br_infil_started", 1);
  player setclientomnvar("ui_br_infiled", 1);
  player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);
  player kill();
}

br_displayperkinfo() {
  self endon("disconnect");

  if(isDefined(level.isstandardsandbox) && !level.isstandardsandbox) {
    return;
  }
  if(_id_2CEDCC356F1B9FC8::_id_F5446040A93792C3()) {
    return;
  }
  self setclientomnvar("ui_br_display_perk_info", 1);
  wait 0.1;
  self setclientomnvar("ui_br_display_perk_info", 0);
}

br_giveselectedclass(player, _id_A5AB866673E5E99D, _id_4047CB430F29ADA4) {
  player.gettingloadout = 1;
  struct = undefined;

  if(isDefined(player.preloadedclassstruct)) {
    struct = player.preloadedclassstruct;
    player.preloadedclassstruct = undefined;
  } else {
    struct = player scripts\mp\class::loadout_getclassstruct();
    struct = player scripts\mp\class::loadout_updateclass(struct, player.class);
  }

  player.classstruct = struct;
  inlaststand = istrue(player.inlaststand);
  dropstruct = br_clearinventory(player, _id_A5AB866673E5E99D, _id_4047CB430F29ADA4);
  player.prevweaponobj = undefined;
  player scripts\mp\class::loadout_clearperks();
  player scripts\mp\class::loadout_updateplayerperks(struct);
  givelaststandifneeded(player);
  givespecialistbonusifneeded(player);
  player scripts\mp\class::_id_9743C56A4D2DC135(struct);
  player scripts\mp\class::_id_A80B77A2ABAA376E(struct);

  if(isDefined(player.classstruct.loadoutsecondaryobject))
    _id_724736FCF0FB6604::br_forcegivecustomweapon(player, player.classstruct.loadoutsecondaryobject, player.classstruct.loadoutsecondaryfullname, player.classstruct.loadoutsecondary);

  if(isDefined(player.classstruct.loadoutprimaryobject))
    _id_724736FCF0FB6604::br_forcegivecustomweapon(player, player.classstruct.loadoutprimaryobject, player.classstruct.loadoutprimaryfullname, player.classstruct.loadoutprimary);

  _id_E7D8E765AC9243A6 = "none";
  _id_604669419E2560E6 = "none";
  _id_6DC747A4410E0395 = 0;
  _id_6E8F0546B97C1DD5 = 0;

  if(isDefined(player.classstruct.loadoutequipmentprimary)) {
    _id_E7D8E765AC9243A6 = player.classstruct.loadoutequipmentprimary;

    if(isDefined(player.classstruct._id_B68E3A0A9C628D23) && player.classstruct._id_B68E3A0A9C628D23 > 0)
      _id_6DC747A4410E0395 = player.classstruct._id_B68E3A0A9C628D23;
  }

  if(isDefined(player.classstruct.loadoutequipmentsecondary)) {
    _id_604669419E2560E6 = player.classstruct.loadoutequipmentsecondary;

    if(isDefined(player.classstruct._id_0A1DFC5CE15795A3) && player.classstruct._id_0A1DFC5CE15795A3 > 0)
      _id_6E8F0546B97C1DD5 = player.classstruct._id_0A1DFC5CE15795A3;
  }

  player._id_A6DD5C7E74106CE3[_id_E7D8E765AC9243A6] = _id_6DC747A4410E0395;
  player._id_A6DD5C7E74106CE3[_id_604669419E2560E6] = _id_6E8F0546B97C1DD5;
  player scripts\mp\equipment::giveequipment(_id_E7D8E765AC9243A6, "primary", _id_6DC747A4410E0395);
  player scripts\mp\equipment::giveequipment(_id_604669419E2560E6, "secondary", _id_6E8F0546B97C1DD5);
  player.gettingloadout = 0;
  player notify("giveLoadout");
  player thread br_displayperkinfo();

  if(inlaststand) {
    laststandoldweaponobj = player getcurrentprimaryweapon();

    if(!isweapon(laststandoldweaponobj))
      laststandoldweaponobj = makeweapon(laststandoldweaponobj);

    self.laststandoldweaponobj = laststandoldweaponobj;
    laststandweapon = player brchooselaststandweapon();

    if(!isweapon(laststandweapon))
      laststandweapon = makeweapon(laststandweapon);

    player scripts\mp\laststand::givelaststandweapon(laststandweapon);

    if(!player scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
      player scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
  }
}

br_clearinventory(player, _id_A5AB866673E5E99D, _id_4047CB430F29ADA4) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  dropstruct.weaponpickups = [];
  dropstruct.equipprimarypickup = undefined;
  dropstruct.equipsecondarypickup = undefined;

  if(istrue(_id_4047CB430F29ADA4)) {
    dropstruct._id_DFBA5A2C3C6F0A07 = int(5.0);

    if(getdvarint("dvar_AC8187887A7808AA", 0))
      dropstruct._id_DFBA5A2C3C6F0A07 = dropstruct._id_DFBA5A2C3C6F0A07 + 11;
  }

  foreach(weapon in player.equippedweapons) {
    basename = _id_2669878CF5A1B6BC::getweaponrootname(weapon.basename);

    if(isweapon(weapon) && weapon.inventorytype == "primary") {
      if(_id_7E52B56769FA7774::shoulddropbrprimary(weapon, player)) {
        _id_EC7DED352736C3B1 = player _id_4ACBD920A4F5A24D::extract_ismissionweapon(weapon);

        if(istrue(_id_A5AB866673E5E99D) && !_id_EC7DED352736C3B1) {
          _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
          pickupent = _id_724736FCF0FB6604::weaponspawn(weapon, player, _id_CB4FAD49263E20C4, 0, 1);

          if(isDefined(pickupent)) {
            _id_5413C446D646561A = player getweaponammoclip(weapon);
            _id_5F1E64F3E8613C52 = player getweaponammoclip(weapon, "left");
            _id_DAA197E6C4B920EE = 0;

            if(weapon.hasalternate) {
              _id_B6FF735C3690CC44 = weapon getaltweapon();

              if(_id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_B6FF735C3690CC44) != _id_724736FCF0FB6604::br_ammo_type_for_weapon(weapon))
                _id_DAA197E6C4B920EE = player getweaponammoclip(_id_B6FF735C3690CC44);
            }

            _id_7E52B56769FA7774::loot_setitemcount(pickupent, _id_5413C446D646561A, _id_5F1E64F3E8613C52, _id_DAA197E6C4B920EE);
            dropstruct.weaponpickups[dropstruct.weaponpickups.size] = pickupent;
          }
        }
      }

      player scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
    }
  }

  if(isDefined(player.equipment["primary"])) {
    if(istrue(_id_A5AB866673E5E99D)) {
      ammocount = player scripts\mp\equipment::getequipmentslotammo("primary");
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, player.equipment["primary"]);

      if(isDefined(_id_FEB782334DD23A66) && ammocount > 0) {
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
        pickupent = _id_7E52B56769FA7774::spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, ammocount, 1);

        if(isDefined(pickupent))
          dropstruct.equipprimarypickup = pickupent;
      }
    }

    player scripts\mp\equipment::takeequipment("primary");
  }

  if(isDefined(player.equipment["secondary"])) {
    if(istrue(_id_A5AB866673E5E99D)) {
      ammocount = player scripts\mp\equipment::getequipmentslotammo("secondary");
      _id_FEB782334DD23A66 = scripts\engine\utility::array_find(level.br_pickups.br_equipname, player.equipment["secondary"]);

      if(isDefined(_id_FEB782334DD23A66) && ammocount > 0) {
        _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);

        if(_id_2CEDCC356F1B9FC8::_id_12D9A293931F0455(_id_FEB782334DD23A66))
          ammocount = player _id_0EC0F9AD939B29E0::_id_DB61876ACA4E4CD3();

        pickupent = _id_7E52B56769FA7774::spawnpickup(_id_FEB782334DD23A66, _id_CB4FAD49263E20C4, ammocount, 1);

        if(isDefined(pickupent))
          dropstruct.equipsecondarypickup = pickupent;
      }
    }

    player scripts\mp\equipment::takeequipment("secondary");
  }

  if(_id_55E418C5CC946593::_id_C0D385A09D173A36() && isDefined(player._id_028C944F222F4814._id_183EC729C8876D57)) {
    if(istrue(_id_A5AB866673E5E99D))
      player _id_55E418C5CC946593::_id_3AF23B0BFAF91DBD(dropstruct);
  }

  player giveweapon(makeweapon("iw9_me_fists_mp"));
  return dropstruct;
}

br_selectdropbagclass() {
  self endon("disconnect");
  self freezecontrols(1);
  self setclientomnvar("ui_open_loadout_bag", 1);
  _id_EAABF9463637080F = playerselectspawnclass();
  self setclientomnvar("ui_options_menu", 0);
  self setclientomnvar("ui_open_loadout_bag", 0);
  self freezecontrols(0);
  return _id_EAABF9463637080F;
}

br_givedropbagloadout(player) {
  if(istrue(self.insertingarmorplate))
    player notify("try_armor_cancel", "loadout_open");

  if(isbot(player, 1) && isDefined(level.bot_funcs["select_class_from_airdrop"]))
    _id_EAABF9463637080F = player[[level.bot_funcs["select_class_from_airdrop"]]]();
  else if(getdvarint("dvar_F195E306FFA755D0", 0) == 1)
    _id_EAABF9463637080F = player _id_362C58E8BB39BCDA::runbrgametypefunc("GetRandomLoadout");
  else
    _id_EAABF9463637080F = player br_selectdropbagclass();

  if(istrue(_id_EAABF9463637080F))
    scripts\cp_mp\killstreaks\airdrop::brloadoutcratepostcapture(player);
  else
    return;

  br_giveselectedclass(player, 1, 1);
  _id_8691AF1F100B771F = scripts\engine\utility::ter_op(isstartstr(player.class, "custom"), 1, 0);
  player scripts\cp_mp\challenges::onloadout(_id_8691AF1F100B771F);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    wait 0.5;
    _id_715028F54BAD19A1::branalytics_dropbagused(player, self.origin, self);
    _id_715028F54BAD19A1::branalytics_inventory_snapshot(player, "dropbag_used");
  }
}

bronloadoutcratedestroyed(immediate) {
  level notify("dropbag_kill_callout_" + self.origin);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_715028F54BAD19A1::branalytics_dropbagdestroyed(self.team, self.origin);
}

cleanupdropbagsoncircle() {
  if(!getdvarint("dvar_E91068B532510E98", 0)) {
    return;
  }
  level waittill("br_circle_started");

  while(level.br_pickups.crates.size > 0) {
    _id_78CBE5DB7F9353DF = [];

    foreach(crate in level.br_pickups.crates) {
      if(isDefined(crate) && (!isDefined(crate.curprogress) || crate.curprogress == 0)) {
        crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        continue;
      }

      _id_78CBE5DB7F9353DF[_id_78CBE5DB7F9353DF.size] = crate;
    }

    level.br_pickups.crates = _id_78CBE5DB7F9353DF;
    _id_78CBE5DB7F9353DF = undefined;
    wait 1.0;
  }
}

brchooselaststandweapon() {
  _id_1730C8D8475566CD = self;
  laststandweapon = _id_1730C8D8475566CD _id_2CEDCC356F1B9FC8::playergetlaststandpistol();

  if(!isDefined(laststandweapon))
    laststandweapon = "iw8_gunless";

  return laststandweapon;
}

playerexitlaststand(_id_22F7E2F7E3607528) {
  _id_67708F418B1FAC79::playerexitlaststand(_id_22F7E2F7E3607528);
}

modelaststandallowed(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, idamage, objweapon, smeansofdeath, einflictor, undefined, vdir);
  damagedata.hitloc = shitloc;

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("lastStandAllowed") && !_id_362C58E8BB39BCDA::runbrgametypefunc("lastStandAllowed", damagedata))
    return 0;

  return 1;
}

isvalidkillcam(_id_642470E1ABC1BBF9) {
  attacker = _id_642470E1ABC1BBF9.attacker;

  if(!isDefined(attacker))
    return 0;

  if(istrue(_id_642470E1ABC1BBF9.assistedsuicide))
    return 0;

  _id_BC18E17A39C9670B = _id_362C58E8BB39BCDA::isfeaturedisabled("gulag");
  _id_447AAAD9ABFBB2BD = isDefined(level._id_43307855F189EB31) && istrue(level._id_43307855F189EB31._id_CADC8D24186A8A91);
  _id_182F678BA0AFDACF = istrue(attacker.gulag);

  if(!_id_BC18E17A39C9670B && !_id_447AAAD9ABFBB2BD && _id_182F678BA0AFDACF)
    return 0;

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF())
    return 0;

  return 1;
}

brvalidatekillcam(_id_642470E1ABC1BBF9) {
  if(isDefined(_id_642470E1ABC1BBF9)) {
    if(!isvalidkillcam(_id_642470E1ABC1BBF9))
      _id_642470E1ABC1BBF9.dokillcam = 0;

    if(!_id_642470E1ABC1BBF9.dokillcam)
      _id_642470E1ABC1BBF9.victim clearpredictedstreampos();

    if(!_id_362C58E8BB39BCDA::isfeaturedisabled("teamSpectate"))
      _id_6489FCDFE6FA2E36::migratespectators(_id_642470E1ABC1BBF9.victim, _id_642470E1ABC1BBF9.attacker, 1);
  }
}

iscontender(player) {
  if(!isDefined(player))
    return 0;

  if(!isalive(player))
    return 0;

  if(istrue(player.gulag))
    return 0;

  if(istrue(player.inlaststand))
    return 0;

  return 1;
}

getteamcontenders(team) {
  _id_946A4601500E7C66 = [];
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(iscontender(player))
      _id_946A4601500E7C66[_id_946A4601500E7C66.size] = player;
  }

  return _id_946A4601500E7C66;
}

onkillingblow(eattacker, victim) {
  _id_8BBD9824A695ABDC = _id_2CEDCC356F1B9FC8::playergetlaststandpistol();
  eattacker thread _id_21C19CFC7139D773::_id_5A4B82CE1C8D94D6(victim);

  if(iscontender(victim) && !isDefined(_id_8BBD9824A695ABDC)) {
    _id_282D9AC5FA39BF7F = getteamcontenders(victim.team);

    if(_id_282D9AC5FA39BF7F.size < 2 && !istrue(level.laststandkillteamifdowndisable)) {
      if(victim scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
        victim scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
    }

    if(!_id_362C58E8BB39BCDA::isfeaturedisabled("armor"))
      victim _id_07C40FA80892A721::breakarmor();
  }
}

brpreplayerdamaged(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(isDefined(eattacker) && eattacker != victim && idamage >= victim.health)
    onkillingblow(eattacker, victim);
}

brgetloadoutoptionforname(_id_194D8BC9C448E603) {
  switch (_id_194D8BC9C448E603) {
    case "nothing":
      return 0;
    case "noammo":
      return 1;
    case "limitedammo":
      return 2;
    case "standardammo":
      return 3;
    case "dropbag":
      return 4;
    case "dropbagtime":
      return 5;
    case "pistolarmordropbagtime":
      return 6;
    case "pistolarmor":
      return 7;
    case "altmodegoldengun":
      return 8;
    case "dropplane":
      return 9;
    default:
      return 0;
  }
}

brinitloadoutoption() {
  _id_A14D77328BA7E8F1 = "pistolarmordropbagtime";
  _id_194D8BC9C448E603 = getDvar("scr_br_loadout_option", _id_A14D77328BA7E8F1);
  _id_E4AAE95542F412AF = brgetloadoutoptionforname(_id_194D8BC9C448E603);
  level.br_loadout_option = _id_E4AAE95542F412AF;
  level._id_58C406E460511EA8 = getdvarint("dvar_D70B4DE72AD5AD0B", 0);
}

brdoesloadoutoptionrequireclassselection() {
  return isDefined(level.br_loadout_option) && (level.br_loadout_option == 1 || level.br_loadout_option == 2 || level.br_loadout_option == 3);
}

brdoesloadoutoptionusedropbags() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("drogBagLoadout"))
    return 0;

  return isDefined(level.br_loadout_option) && (level.br_loadout_option == 4 || level.br_loadout_option == 5 || level.br_loadout_option == 6);
}

brareloadoutdropbagsdelayed() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("drogBagLoadout"))
    return 0;

  return isDefined(level.br_loadout_option) && (level.br_loadout_option == 5 || level.br_loadout_option == 6);
}

_id_374B5EC4199E8B21() {
  return isDefined(level.br_loadout_option) && istrue(level._id_58C406E460511EA8) && level.br_loadout_option == 6;
}

_id_D27F645C3282A371() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("drogBagLoadout"))
    return 0;

  return isDefined(level.br_loadout_option) && level.br_loadout_option == 9;
}

brgetloadoutdropbagsdelayseconds() {
  _id_70BCBF0AD5028219 = [];

  if(!isDefined(level.br_level)) {
    _id_70BCBF0AD5028219[_id_70BCBF0AD5028219.size] = 1;
    return _id_70BCBF0AD5028219;
  }

  _id_7E2390B12CB7FC63 = _id_362C58E8BB39BCDA::getbrgametypedata("dropBagDelay");

  if(isDefined(_id_7E2390B12CB7FC63)) {
    if(isarray(_id_7E2390B12CB7FC63))
      _id_70BCBF0AD5028219 = _id_7E2390B12CB7FC63;
    else
      _id_70BCBF0AD5028219[_id_70BCBF0AD5028219.size] = _id_7E2390B12CB7FC63;

    return _id_70BCBF0AD5028219;
  }

  _id_21BE5F4D451EFD18 = -15;
  firsttime = _id_2695A20D4011076D::getcircleclosetime(0);
  _id_5FD1D7EEEBE96215 = max(0, firsttime + _id_21BE5F4D451EFD18);
  _id_23F3A96159A40D18 = getdvarfloat("scr_br_dropbag_delay", _id_5FD1D7EEEBE96215);
  _id_70BCBF0AD5028219[_id_70BCBF0AD5028219.size] = _id_23F3A96159A40D18;

  if(getdvarint("scr_br_dropbag2_enabled", 0) && !_id_362C58E8BB39BCDA::isfeatureenabled("dropBagLoop")) {
    _id_9C06DBDBE08EB98C = 15;
    _id_04CD425AAB99F4F0 = _id_67708F418B1FAC79::gettimetogulagclosed();
    _id_05582E42C9CCDD59 = max(0, _id_04CD425AAB99F4F0 + _id_9C06DBDBE08EB98C);
    _id_F2E56FB5A709FF9C = getdvarfloat("dvar_3771B5264B3F0789", _id_05582E42C9CCDD59);
    _id_70BCBF0AD5028219[_id_70BCBF0AD5028219.size] = _id_F2E56FB5A709FF9C;
  }

  return _id_70BCBF0AD5028219;
}

_id_8209CC6A885E9A2E() {
  _id_70BCBF0AD5028219 = [];
  _id_7E2390B12CB7FC63 = _id_362C58E8BB39BCDA::getbrgametypedata("dropPlaneDelay");

  if(isDefined(_id_7E2390B12CB7FC63)) {
    _id_70BCBF0AD5028219[_id_70BCBF0AD5028219.size] = _id_7E2390B12CB7FC63;
    return _id_70BCBF0AD5028219;
  }

  circleindex = getdvarint("dvar_7073E48B9FD3D775", 1) - 1;
  _id_2568210352BE1ECF = getdvarint("dvar_431D9D141B0FF196", 1);

  if(circleindex >= 0) {
    waittime = _id_335119D3D9EFED24(circleindex, _id_2568210352BE1ECF);
    _id_2C83FAE7F97DCE2A = getdvarint("dvar_EDB26FB318F05407", 40);
    waittime = max(5, waittime - _id_2C83FAE7F97DCE2A);
    _id_70BCBF0AD5028219[_id_70BCBF0AD5028219.size] = waittime;
  }

  circleindex = getdvarint("dvar_C65A2CA664793F10", 4) - 1;
  _id_2568210352BE1ECF = getdvarint("dvar_A1FA1D5514626ABD", 1);

  if(circleindex >= 0) {
    waittime = _id_335119D3D9EFED24(circleindex, _id_2568210352BE1ECF);
    _id_2C83FAE7F97DCE2A = getdvarint("dvar_3D529093F4EC34E2", 15);
    waittime = max(5, waittime - _id_2C83FAE7F97DCE2A);
    _id_70BCBF0AD5028219[_id_70BCBF0AD5028219.size] = waittime;
  }

  return _id_70BCBF0AD5028219;
}

_id_335119D3D9EFED24(circleindex, _id_2568210352BE1ECF) {
  waittime = _id_2695A20D4011076D::getcircleclosetime(circleindex);

  if(!_id_2568210352BE1ECF)
    waittime = waittime - level.br_level.br_circleclosetimes[circleindex];

  return waittime;
}

brdoesloadoutoptiongivestandardloadoutimmediately() {
  return isDefined(level.br_loadout_option) && (level.br_loadout_option == 6 || level.br_loadout_option == 7 || level.br_loadout_option == 8 || level.br_loadout_option == 9);
}

brgetloadoutoptionstandardloadoutindex() {
  switch (level.br_loadout_option) {
    case 9:
    case 8:
    case 7:
    case 6:
      return 0;
    default:
  }
}

brdoesloadoutoptiongivecustomweaponsimmediately() {
  return isDefined(level.br_loadout_option) && (level.br_loadout_option == 1 || level.br_loadout_option == 2 || level.br_loadout_option == 3);
}

brgetloadoutammomultiplier() {
  if(isDefined(level.br_loadout_option)) {
    if(level.br_loadout_option == 2)
      return 0.5;
    else if(level.br_loadout_option == 3)
      return 1.0;
  }

  return 0.0;
}

brgetloadoutammomax() {
  if(isDefined(level.br_loadout_option)) {
    if(level.br_loadout_option == 2)
      return 20;
  }

  return;
}

_id_4043E420432F59F0(_id_67765E10502FCD44) {
  _id_990BF19E67EC2D89 = undefined;
  _id_990BF19E67EC2D89 = scripts\mp\class::preloadandqueueclass(_id_67765E10502FCD44);
  return _id_990BF19E67EC2D89;
}

_id_10FFA1071B1C2681() {
  _id_5FB036C33CDDD360 = spawnStruct();
  _id_5FB036C33CDDD360._id_BC002676438672C9 = [];
  _id_5FB036C33CDDD360._id_AC9CAEBED426E625 = [];
  _id_5FB036C33CDDD360._id_734357A0B88E3A30 = [];
  _id_5FB036C33CDDD360._id_D1AD88BF84DAA67F = [];
  _id_5FB036C33CDDD360.offhands = [];
  _id_5FB036C33CDDD360._id_00ACA871F9745FC8 = [];
  _id_D39A4E49BE46E576 = [];
  _id_34CA738E6F3870DE = self getweaponslistprimaries();

  foreach(primary in _id_34CA738E6F3870DE) {
    if(!scripts\mp\utility\weapon::ismeleeoverrideweapon(primary) && !issubstr(primary.basename, "iw9_me_fists_mp") && !scripts\mp\utility\weapon::isgunlessweapon(primary.basename) && !scripts\mp\utility\weapon::_id_0D3C77884D93D850(primary.basename) && !scripts\mp\utility\weapon::_id_3F15E5E526FF94CE(primary.basename))
      _id_D39A4E49BE46E576[_id_D39A4E49BE46E576.size] = primary;
  }

  foreach(weaponobj in _id_D39A4E49BE46E576) {
    weaponname = getcompleteweaponname(weaponobj);
    _id_5FB036C33CDDD360._id_AC9CAEBED426E625[weaponname] = weaponclipsize(weaponobj);
    _id_5FB036C33CDDD360._id_D1AD88BF84DAA67F[weaponname] = self getweaponammostock(weaponobj);

    if(scripts\mp\utility\weapon::isakimbo(weaponobj))
      _id_5FB036C33CDDD360._id_734357A0B88E3A30[weaponname] = self getweaponammoclip(weaponobj, "left");

    if(getsubstr(weaponname, 0, 4) == "alt_") {
      continue;
    }
    _id_5FB036C33CDDD360._id_BC002676438672C9[_id_5FB036C33CDDD360._id_BC002676438672C9.size] = weaponobj;
  }

  if(self.lastcacweaponobj != makeweapon("none")) {
    foreach(primary in _id_5FB036C33CDDD360._id_BC002676438672C9) {
      if(self.lastcacweaponobj == primary) {
        _id_5FB036C33CDDD360.current = self.lastcacweaponobj;
        break;
      }
    }
  }

  _id_A8B87696AB744141 = self getweaponslistoffhands();

  foreach(_id_32D16745C91DBE50 in _id_A8B87696AB744141) {
    if(_id_32D16745C91DBE50.basename == "bandage_br") {
      continue;
    }
    _id_26D3CCFFC7BEBEC9 = self getweaponammoclip(_id_32D16745C91DBE50);

    if(_id_26D3CCFFC7BEBEC9 <= 0) {
      continue;
    }
    _id_5FB036C33CDDD360.offhands[_id_5FB036C33CDDD360.offhands.size] = _id_32D16745C91DBE50;
    _id_FE758E8B3E5F9EC0 = getcompleteweaponname(_id_32D16745C91DBE50);
    _id_5FB036C33CDDD360._id_AC9CAEBED426E625[_id_FE758E8B3E5F9EC0] = _id_26D3CCFFC7BEBEC9;
  }

  foreach(slot, _id_1189BD7FBE2861F8 in self.equipment)
  _id_5FB036C33CDDD360._id_00ACA871F9745FC8[_id_1189BD7FBE2861F8] = slot;

  _id_5FB036C33CDDD360.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent)
    _id_5FB036C33CDDD360.super = self.equipment["super"];

  self._id_5FB036C33CDDD360 = _id_5FB036C33CDDD360;
}

_id_7FBB2E52F100474E() {
  self endon("disconnect");
  self takeallweapons(0, 1);
  _id_724736FCF0FB6604::br_ammo_player_clear();
  self.equipment["primary"] = undefined;
  self.equipment["secondary"] = undefined;
  self.equipment["health"] = undefined;
  self.equipment["super"] = undefined;
  _id_2B1D0E57C66A43D0 = makeweapon("iw9_me_fists_mp");

  if(self._id_5FB036C33CDDD360._id_BC002676438672C9.size < 2)
    self giveweapon(_id_2B1D0E57C66A43D0);

  _id_CF6837E74D470965 = 0;

  foreach(weaponobj in self._id_5FB036C33CDDD360._id_BC002676438672C9) {
    weaponname = getcompleteweaponname(weaponobj);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(weaponobj);

    if(!_id_CF6837E74D470965) {
      self assignweaponprimaryslot(weaponname);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(weaponobj);
      _id_CF6837E74D470965 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, weaponname);
  }

  foreach(_id_32D16745C91DBE50 in self._id_5FB036C33CDDD360.offhands) {
    _id_1189BD7FBE2861F8 = scripts\mp\equipment::getequipmentreffromweapon(_id_32D16745C91DBE50);

    if(!isDefined(_id_1189BD7FBE2861F8)) {
      continue;
    }
    slot = self._id_5FB036C33CDDD360._id_00ACA871F9745FC8[_id_1189BD7FBE2861F8];

    if(!isDefined(slot)) {
      continue;
    }
    scripts\mp\equipment::giveequipment(_id_1189BD7FBE2861F8, slot);
  }

  foreach(weaponname, ammo in self._id_5FB036C33CDDD360._id_D1AD88BF84DAA67F) {
    self setweaponammostock(weaponname, ammo);
    weaponobj = makeweapon(getweaponbasename(weaponname));
    _id_811ABFDB6C33F17F = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weaponobj);

    if(isDefined(_id_811ABFDB6C33F17F)) {
      self.br_ammo[_id_811ABFDB6C33F17F] = ammo;
      _id_724736FCF0FB6604::br_ammo_player_hud_update_ammotype(_id_811ABFDB6C33F17F);
    }
  }

  foreach(weaponname, ammo in self._id_5FB036C33CDDD360._id_AC9CAEBED426E625)
  self setweaponammoclip(weaponname, ammo);

  foreach(weaponname, ammo in self._id_5FB036C33CDDD360._id_734357A0B88E3A30)
  self setweaponammoclip(weaponname, ammo, "left");

  waitframe();
  _id_B8F86333B805D701 = _id_2B1D0E57C66A43D0;

  if(isDefined(self._id_5FB036C33CDDD360.current))
    _id_B8F86333B805D701 = self._id_5FB036C33CDDD360.current;
  else if(isDefined(self._id_5FB036C33CDDD360._id_BC002676438672C9[0]))
    _id_B8F86333B805D701 = self._id_5FB036C33CDDD360._id_BC002676438672C9[0];

  self switchtoweaponimmediate(_id_B8F86333B805D701);

  if(isDefined(self._id_5FB036C33CDDD360.super)) {
    _id_EBEC497FF8B18A45 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self._id_5FB036C33CDDD360.super]];
    _id_7E52B56769FA7774::forcegivesuper(_id_EBEC497FF8B18A45, 0);
  }

  thread scripts\cp_mp\gestures::tryreenablescriptablevfx();
  self._id_5FB036C33CDDD360 = undefined;
}

brskipplayerkillcams() {
  foreach(player in level.players) {
    if(isPlayer(player) && player scripts\mp\utility\player::isinkillcam()) {
      player notify("abort_killcam");
      player.cancelkillcam = 1;
    }
  }
}

brhandleinvulnerability(time) {
  _id_180FB0A14520C9A9 = getdvarint("dvar_EDDAEBB33871CF7D", 30);

  if(_id_180FB0A14520C9A9 > time)
    _id_180FB0A14520C9A9 = time;

  wait(time - _id_180FB0A14520C9A9);
  level.allowprematchdamage = 0;
  wait(_id_180FB0A14520C9A9 / 2.0);
  brskipplayerkillcams();
  wait(_id_180FB0A14520C9A9 / 2.0);
}

spawnclientbr(_id_9156B53BCF7CE573) {
  self endon("disconnect");
  self._id_47F9A068DF7C5418 = undefined;

  if(_id_2CEDCC356F1B9FC8::iswaitingtoentergulag(self)) {
    self notify("attempted_spawn");
    _id_67708F418B1FAC79::entergulag(self);
    self.waitingtospawn = 0;
  } else if(istrue(self.waitingtospawnamortize) || _id_2CEDCC356F1B9FC8::isrespawningfromtoken(self) || istrue(_id_362C58E8BB39BCDA::runbrgametypefunc("spawnHandled", self))) {
    self notify("attempted_spawn");
    self.waitingtospawn = 0;
  } else if(!scripts\mp\playerlogic::mayspawn()) {
    waitframe();
    self notify("attempted_spawn");

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("handleBRLateSpawnPlayer"))
      _id_362C58E8BB39BCDA::runbrgametypefunc("handleBRLateSpawnPlayer");
    else if(istrue(level.infiltransistioning) || istrue(level.snatchspawnalltoc130done) || istrue(level.br_c130spawndone)) {
      if(isDefined(level.brlatespawnplayer))
        self thread[[level.brlatespawnplayer]]();

      return;
    }
  } else {
    if(istrue(_id_9156B53BCF7CE573))
      level.snatchspawnalltoc130done = 0;

    if(istrue(level._id_466A09C79541FC26) && !istrue(_id_9156B53BCF7CE573)) {
      if(isDefined(level._id_924A9707BDCBFC46))
        self thread[[level._id_924A9707BDCBFC46]]();

      return;
    }

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("handleBRLateSpawnPlayer"))
      _id_362C58E8BB39BCDA::runbrgametypefunc("handleBRLateSpawnPlayer");
    else if(istrue(level.infiltransistioning) || istrue(level.snatchspawnalltoc130done) || istrue(level.br_c130spawndone)) {
      if(isDefined(level.brlatespawnplayer))
        self thread[[level.brlatespawnplayer]]();

      return;
    }

    if(!istrue(level.br_allowloadout)) {
      if(isDefined(level.bypassclasschoicefunc))
        self.class = self[[level.bypassclasschoicefunc]]();
      else
        self.class = pickclassbr();
    }

    if(getdvarint("dvar_8FD5E2FBD99396A4", 0) == 1)
      thread _id_20F91635CFFFBDCF();

    _id_4E7E70A167DFAD45 = getdvarint("dvar_C04BDBE0595BF776", 1);
    _id_6039638FD494A229 = _id_4E7E70A167DFAD45 && usedropspawn() && !isbot(self);

    if(_id_4E7E70A167DFAD45 > 1)
      _id_6039638FD494A229 = _id_6039638FD494A229 && !istrue(self.hasspawned);

    if(_id_6039638FD494A229)
      self.prespawnspawn = getspawnpoint(_id_6039638FD494A229);

    scripts\mp\playerlogic::waitandspawnclient(_id_9156B53BCF7CE573);
    self freezecontrols(1);

    if(usedropspawn())
      thread prematchdeployparachute();

    waitframe();

    if(scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm") {
      self skydive_setdeploymentstatus(0);
      self skydive_setbasejumpingstatus(0);
    }

    _id_4DE859B9228E5CFD = !self isplayerheadless();
    body = scripts\mp\teams::getcustomization()["body"];
    _id_C30AC8F00CB1CC8A = gettime();

    if(_id_4DE859B9228E5CFD) {
      while(isalive(self) && isDefined(body) && isDefined(self.weaponlist) && !self hasloadedcustomizationviewmodels(body) && !self hasloadedviewweapons(self.weaponlist)) {
        if(_id_C30AC8F00CB1CC8A + 3000 < gettime()) {
          break;
        }

        waitframe();
      }

      _id_DE6EF125511E1141 = getdvarfloat("dvar_3E0E124917F2104B", 1.0);

      if(_id_DE6EF125511E1141 > 0)
        wait(_id_DE6EF125511E1141);
    }

    self notify("brWaitAndSpawnClientComplete");
    self.waitingtospawn = 0;
    self freezecontrols(0);
  }
}

playerexecutionsdisable() {
  if(scripts\cp_mp\execution::hasexecution()) {
    self.savedexecutionref = self.executionref;
    scripts\cp_mp\execution::_clearexecution();
    self disableexecutionattack();
  }
}

playerexecutionsenable() {
  if(isDefined(self.savedexecutionref)) {
    scripts\cp_mp\execution::_giveexecution(self.savedexecutionref);
    self enableexecutionattack();
    self.savedexecutionref = undefined;
  }
}

watchforbrsquadleadershift() {
  level endon("game_ended");
  self notify("br_squad_leader_shift");
  self endon("br_squad_leader_shift");
  player = self;
  _id_FABF84450735DD93 = player.team;

  for(;;) {
    msg = "";

    if(scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm" || scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "sandbox" || scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "rumble_mgl")
      msg = player scripts\engine\utility::waittill_any_return_no_endon_death_2("disconnect", "br_pass_squad_leader");
    else
      msg = player scripts\engine\utility::waittill_any_return_no_endon_death_4("death", "disconnect", "remove_from_alive_count", "br_pass_squad_leader");

    if(msg == "br_pass_squad_leader") {
      if(!teamhasfreshsquadleadercandidate(_id_FABF84450735DD93)) {
        player playlocalsound("br_pickup_deny");
        continue;
      }
    }

    if(msg != "disconnect") {
      if(!scripts\mp\flags::gameflag("prematch_done")) {
        continue;
      }
      if(!istrue(player.br_infilstarted))
        continue;
    }

    if(player abandonbrsquadleader(_id_FABF84450735DD93))
      return;
  }
}

setplayersquadindex(squadindex) {
  player = self;
  _id_573AA6BE0B25ACD9 = player.game_extrainfo & 65528;
  _id_573AA6BE0B25ACD9 = _id_573AA6BE0B25ACD9 | squadindex;
  player.game_extrainfo = _id_573AA6BE0B25ACD9;
}

setplayerbrsquadleader(_id_F9D07E5FA610B560) {
  player = self;

  if(_id_F9D07E5FA610B560 == player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
    return;
  }
  player.isbrsquadleader = _id_F9D07E5FA610B560;

  if(_id_F9D07E5FA610B560) {
    player.game_extrainfo = player.game_extrainfo | 256;
    player thread watchforbrsquadleadershift();
  } else
    player.game_extrainfo = player.game_extrainfo &~256;
}

abandonbrsquadleader(_id_FABF84450735DD93) {
  player = self;

  if(!isDefined(_id_FABF84450735DD93))
    _id_FABF84450735DD93 = player.team;

  if(isDefined(player) && !player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
    return 0;

  if(isDefined(player))
    player.haspassedsquadleader = 1;

  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_BC415F6B9EDCB228 = 0;
  _id_980DDA0CD0E207D2 = undefined;

  foreach(_id_89C718895A5117B3 in _id_A6AB8D0FDA441DC2) {
    _id_382B22D1FDDEA86F = playerbrsquadleaderscore(_id_89C718895A5117B3);

    if(_id_382B22D1FDDEA86F > _id_BC415F6B9EDCB228) {
      _id_BC415F6B9EDCB228 = _id_382B22D1FDDEA86F;
      _id_980DDA0CD0E207D2 = _id_89C718895A5117B3;
    }
  }

  success = 0;

  if(isDefined(_id_980DDA0CD0E207D2)) {
    if(isDefined(player))
      player setplayerbrsquadleader(0);

    _id_980DDA0CD0E207D2 setplayerbrsquadleader(1);
    success = 1;

    if(!istrue(level.br_c130spawndone) && scripts\mp\utility\game::getsubgametype() == "br")
      level _id_2CEDCC356F1B9FC8::brleaderdialogplayer("deploy_squad_leader", _id_980DDA0CD0E207D2, 1, 0);
  }

  updatesquadleaderpassstateforteam(_id_FABF84450735DD93);
  return success;
}

teamhasfreshsquadleadercandidate(_id_FABF84450735DD93) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_A782B5B8FCCC6409 = 0;

  foreach(_id_89C718895A5117B3 in _id_A6AB8D0FDA441DC2) {
    if(!isDefined(_id_89C718895A5117B3) || _id_89C718895A5117B3 _id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
      continue;
    }
    if(!isalive(_id_89C718895A5117B3)) {
      continue;
    }
    if(_id_89C718895A5117B3 _meth_8420670EAFC8D391() || _id_89C718895A5117B3 isspectatingplayer()) {
      continue;
    }
    if(_id_89C718895A5117B3 _id_2CEDCC356F1B9FC8::isplayeringulag()) {
      continue;
    }
    if(!istrue(_id_89C718895A5117B3.haspassedsquadleader)) {
      _id_A782B5B8FCCC6409 = 1;
      break;
    }
  }

  return _id_A782B5B8FCCC6409;
}

updatesquadleaderpassstateforteam(_id_FABF84450735DD93) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_FABF84450735DD93, "players");
  _id_A782B5B8FCCC6409 = teamhasfreshsquadleadercandidate(_id_FABF84450735DD93);

  foreach(_id_89C718895A5117B3 in _id_A6AB8D0FDA441DC2)
  _id_89C718895A5117B3 setclientomnvar("ui_br_squad_leader_can_pass", _id_A782B5B8FCCC6409);
}

playerbrsquadleaderscore(player) {
  if(!isDefined(player) || player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader() || player _meth_8420670EAFC8D391() || player isspectatingplayer() || !isalive(player))
    return 0;

  if(player _id_2CEDCC356F1B9FC8::isplayeringulag())
    return 1;

  if(istrue(player.inlaststand))
    return 2;

  if(istrue(player.haspassedsquadleader))
    return 3;

  return 4;
}

teamsplashbr(_id_1B4ADA49A21B51CA, owner, team, optionalnumber, _id_042B1E877AB187C6) {
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in _id_A6AB8D0FDA441DC2) {
    if(!istrue(player.gulag))
      player thread scripts\mp\hud_message::showsplash(_id_1B4ADA49A21B51CA, optionalnumber, owner, undefined, undefined, _id_042B1E877AB187C6);
  }
}

endsuperdisableweaponbr() {
  _id_027CEBAE05627958 = "super_delay_mp";
  _id_D3C112E63BF53EE5 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(_id_D3C112E63BF53EE5)) {
    _id_641083E829D5514C = _id_D3C112E63BF53EE5.staticdata.weapon;
    ammo = 0;

    if(scripts\mp\perks\perkfunctions::_id_66F0CBD5FF8458FE())
      ammo = scripts\engine\utility::ter_op(scripts\mp\supers::issuperready(), 1, 0);
    else
      ammo = scripts\engine\utility::ter_op(istrue(self._id_1066FBD86C88A6DF), 1, 0);

    scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_641083E829D5514C);
    self setweaponammoclip(_id_641083E829D5514C, ammo);
    self assignweaponoffhandspecial(_id_641083E829D5514C);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_027CEBAE05627958);
  }

  self notify("super_disable_end");
  self._id_B310FFBB7DF412DD = 1;
}

getsuperweapondisabledammobr() {
  ammo = scripts\mp\equipment::getequipmentslotammo("super");

  if(!istrue(scripts\mp\supers::issuperdisabled()))
    return ammo;

  if(istrue(self._id_1066FBD86C88A6DF))
    ammo = 1;

  return ammo;
}

onsupportboxusedbyplayer(player, dropstruct) {
  _id_509D86412C9D7426 = player getweaponslistprimaries();

  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    if(!isDefined(_id_509D86412C9D7426) || _id_509D86412C9D7426.size == 0) {
      minigun = player getcurrentweapon();
      _id_D0BAE9FA43B9E424 = player getcurrentweaponclipammo();
      _id_E21A1FE75EA20307 = weaponclipsize(minigun);

      if(_id_D0BAE9FA43B9E424 < _id_E21A1FE75EA20307) {
        player setweaponammoclip(minigun, _id_E21A1FE75EA20307);
        player _id_5762AC2F22202BA2::hudicontype("br_ammo");
        player playlocalsound("iw9_support_box_use");
        return 1;
      }
    }
  }

  if(!isDefined(dropstruct))
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(_id_DE88CD14114C1E24.isalternate && _id_2669878CF5A1B6BC::_id_DE04E13AB01E1A10(_id_DE88CD14114C1E24.underbarrel)) {
      clipammo = weaponclipsize(_id_DE88CD14114C1E24);
      _id_2AA9CAEF99C9AF77 = int(clipammo);
      player setweaponammoclip(_id_DE88CD14114C1E24, _id_2AA9CAEF99C9AF77);
      continue;
    } else if(_id_2669878CF5A1B6BC::isminigunweapon(_id_DE88CD14114C1E24)) {
      player setweaponammoclip(_id_DE88CD14114C1E24, _id_DE88CD14114C1E24.clipsize);
      continue;
    } else if(!isDefined(ammotype)) {
      continue;
    }
    _id_724736FCF0FB6604::_id_C668C8660AB99773(_id_DE88CD14114C1E24, player, dropstruct);
  }

  if(_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(player)) {
    _id_9AC5E72784815708 = _id_2D9D24F7C63AC143::_id_2985254128B1C262(player);
    _id_724736FCF0FB6604::_id_C668C8660AB99773(_id_9AC5E72784815708, player, dropstruct);
  }

  if(isDefined(player.equipment["primary"])) {
    _id_117E7DC4F772CE21 = 2;
    _id_FB4E05597755DD4C(player, _id_117E7DC4F772CE21, player.equipment["primary"], dropstruct);
  }

  if(isDefined(player.equipment["secondary"])) {
    _id_117E7DC4F772CE21 = 2;
    _id_FB4E05597755DD4C(player, _id_117E7DC4F772CE21, player.equipment["secondary"], dropstruct);
  }

  player _id_5762AC2F22202BA2::hudicontype("ammobox");
  scripts\mp\equipment\support_box::supportbox_playusesound(player);
  thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
  return 1;
}

_id_FB4E05597755DD4C(player, _id_75E244E5F45C894D, equipmentref, dropstruct) {
  _id_0035A4276EF6519A = player _id_7EF95BBA57DC4B82::getequipmentammo(equipmentref);
  _id_5ECD4EF83F881C83 = player _id_7EF95BBA57DC4B82::getequipmentmaxammo(equipmentref);
  _id_BAB9E4F8BA9F23D0 = _id_5ECD4EF83F881C83 - _id_0035A4276EF6519A;
  player scripts\mp\equipment::incrementequipmentammo(equipmentref, _id_0035A4276EF6519A + _id_BAB9E4F8BA9F23D0);
  _id_416102A18FC1FD69 = _id_75E244E5F45C894D - _id_BAB9E4F8BA9F23D0;

  if(_id_416102A18FC1FD69 > 0) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(equipmentref);
    scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

    if(istrue(level._id_01AA4FF5576B74B2) && isDefined(dropstruct))
      scripts\mp\equipment\support_box::_id_225B99924F316BC1(dropstruct, player, scriptablename, _id_416102A18FC1FD69);
    else {
      _id_4A9B06AED9F99334 = spawnStruct();
      _id_4A9B06AED9F99334.scriptablename = scriptablename;
      _id_4A9B06AED9F99334.count = _id_416102A18FC1FD69;
      player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_4A9B06AED9F99334);
    }
  }
}

onarmorboxusedbyplayer(player, dropstruct) {
  armoramount = getdvarint("dvar_0796878180A8E250", 6);
  _id_3E26AF1F7D06878B = "brloot_armor_plate";
  _id_09FFB530E039A041 = player scripts\mp\equipment::getequipmentslotammo("health");
  _id_09FFB530E039A041 = scripts\engine\utility::_id_53C4C53197386572(_id_09FFB530E039A041, 0);
  _id_989DBBD449C282CA = player scripts\mp\equipment::getequipmentmaxammo("equip_armorplate");
  _id_E5DD98C912B3B189 = _id_989DBBD449C282CA - _id_09FFB530E039A041;
  result = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_3E26AF1F7D06878B, 1, _id_E5DD98C912B3B189, 0);

  if(result) {
    player _id_5762AC2F22202BA2::hudicontype("br_armor");
    _id_42AC611ED3E82A3C = armoramount - _id_E5DD98C912B3B189;

    if(_id_42AC611ED3E82A3C > 0) {
      if(istrue(level._id_F2C468B1D700A1BD)) {
        if(!isDefined(dropstruct))
          dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

        scripts\mp\equipment\support_box::_id_225B99924F316BC1(dropstruct, player, _id_3E26AF1F7D06878B, _id_42AC611ED3E82A3C);
      } else {
        _id_4A9B06AED9F99334 = spawnStruct();
        _id_4A9B06AED9F99334.scriptablename = _id_3E26AF1F7D06878B;
        _id_4A9B06AED9F99334.count = _id_42AC611ED3E82A3C;
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_3E26AF1F7D06878B);
        player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_4A9B06AED9F99334);
      }
    }
  } else {
    _id_4A9B06AED9F99334 = spawnStruct();
    _id_4A9B06AED9F99334.scriptablename = _id_3E26AF1F7D06878B;
    _id_4A9B06AED9F99334.count = armoramount;
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_3E26AF1F7D06878B);
    player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_4A9B06AED9F99334);
  }

  scripts\mp\equipment\support_box::supportbox_playusesound(player);
  thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
  return 1;
}

_id_130BC3F5F33BB97D(player) {
  _id_456C4271ED8779B9 = "brloot_self_revive";
  result = _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, _id_456C4271ED8779B9, 1, 1, 0);

  if(result) {
    player _id_5762AC2F22202BA2::hudicontype("br_armor");
    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(0, 0);
    _id_3EAA9F644DBE7834 = scripts\cp_mp\challenges::_id_6D40F12A09494350(_id_3EAA9F644DBE7834, 2);
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_456C4271ED8779B9);
    scripts\cp_mp\challenges::_id_D24138B32084FC3E(player, lootid, undefined, _id_3EAA9F644DBE7834, 1);
  } else {
    _id_4A9B06AED9F99334 = spawnStruct();
    _id_4A9B06AED9F99334.scriptablename = _id_456C4271ED8779B9;
    _id_4A9B06AED9F99334.count = 1;
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_456C4271ED8779B9);
    player _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_4A9B06AED9F99334);
  }

  return 1;
}

_id_F24AE0993EFCA48F(player) {
  _id_D72DFD0DF23D5877 = tolower(getDvar(_func_2EF675C13CA1C4AF("dvar_AF9284300060DCB3", "")));

  if(!isDefined(_id_D72DFD0DF23D5877) || _id_D72DFD0DF23D5877 == "")
    _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, "brloot_plate_carrier_2", 1, 1, 0);
  else {
    itemlist = strtok(_id_D72DFD0DF23D5877, " ");

    foreach(item in itemlist) {
      if(!isDefined(_id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(item))) {
        continue;
      }
      switch (item) {
        case "brloot_ammo_rocket":
          _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, item, 1, getdvarint("dvar_E2706D365AD75B50", 3), 0);
          break;
        case "brloot_ammo_50cal":
        case "brloot_ammo_12g":
        case "brloot_ammo_762":
        case "brloot_ammo_919":
          _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, item, 1, getdvarint("dvar_5970233D0AC3EB9E", 30), 0);
          break;
        default:
          _id_7E52B56769FA7774::br_forcegivecustompickupitem(player, item, 1, 1, 0);
      }
    }
  }

  player _id_5762AC2F22202BA2::hudicontype("br_ammo");
  scripts\mp\equipment\support_box::supportbox_playusesound(player);
  thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
  return 1;
}

airdrop_registercrateforcleanup(crate) {
  registercrateforcleanup(crate);
}

airdop_brloadoutcratefirstactivation(crate) {
  brloadoutcratefirstactivation(crate);
}

airdrop_makeweaponfromcrate() {
  makeweaponfromcrate();
}

airdrop_makeitemfromcrate() {
  makeitemfromcrate();
}

airdrop_makeitemsfromcrate(player) {
  makeitemsfromcrate(player);
}

airdrop_br_givedropbagloadout(player) {
  br_givedropbagloadout(player);
}

airdrop_bronloadoutcratedestroyed(immediate) {
  bronloadoutcratedestroyed(immediate);
}

onscavengerbagpickup(player) {
  primary = player getcurrentprimaryweapon();
  player _id_724736FCF0FB6604::br_give_weapon_clip(primary);
}

onnewequipmentpickup(player, equipmentref) {
  player _id_7E52B56769FA7774::handleexplosivepickup(equipmentref, "primary");
}

ongrenadeused(weaponname, grenade) {
  switch (weaponname) {
    case "iw8_fulton_bag_mp":
      thread scripts\mp\equipment\fulton::fulton_used(grenade);
      break;
    case "rock_mp":
      thread _id_67708F418B1FAC79::rock_used(grenade);
      break;
    case "balloon_extract_mp":
      thread _id_1D393929CF0BD6A2::_id_231A038D18C51203(grenade);
      break;
    default:
      _id_362C58E8BB39BCDA::runbrgametypefunc("onGrenadeUsed", weaponname, grenade);
      break;
  }

  if(weaponname == "rock_mp" && istrue(self._id_47F9A068DF7C5418)) {
    grenade delete();
    self._id_47F9A068DF7C5418 = undefined;
  }
}

onweapontaken(_id_F42F309550E65575) {
  _id_724736FCF0FB6604::takeweaponpickup(_id_F42F309550E65575);
}

playershouldrespawn() {
  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerShouldRespawn"))
    return _id_362C58E8BB39BCDA::runbrgametypefunc("playerShouldRespawn");

  if(!istrue(level.br_prematchstarted))
    return 1;

  if(_id_2CEDCC356F1B9FC8::iswaitingtoentergulag(self))
    return 1;

  if(_id_2CEDCC356F1B9FC8::isrespawningfromtoken(self))
    return 1;

  return 0;
}

brplayerkilledspawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  result = _id_362C58E8BB39BCDA::runbrgametypefunc("playerKilledSpawn", _id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);

  if(isDefined(result))
    return result;
  else if(scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "kingslayer" || scripts\mp\utility\game::getsubgametype() == "rumble_mgl") {
    if(getdvarint("dvar_FE3AFD6EAD4AA523", 1) == 1) {
      if(istrue(isDefined(self.c130)))
        return 1;

      if(!scripts\mp\flags::gameflag("prematch_done"))
        return 0;

      if(istrue(_id_642470E1ABC1BBF9.victim.hasrespawntoken) || istrue(level.useautorespawn)) {
        if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
          if(isbot(_id_642470E1ABC1BBF9.victim))
            return 1;
        }

        _id_642470E1ABC1BBF9.victim thread _id_5BAB271917698DC4::_id_844BDF70E8A61534();
        _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(_id_642470E1ABC1BBF9.victim.team, "teamCount");

        if(_id_652F47620AC4713F > 1 && !_id_362C58E8BB39BCDA::isfeaturedisabled("spectateOnDeath"))
          _id_642470E1ABC1BBF9.victim thread _id_6489FCDFE6FA2E36::spawnspectator(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7, 1);

        return 1;
      }
    } else {
      if(!scripts\mp\flags::gameflag("prematch_done"))
        return 0;

      if(istrue(_id_642470E1ABC1BBF9.victim.hasrespawntoken) || istrue(level.useautorespawn)) {
        if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
          if(isbot(_id_642470E1ABC1BBF9.victim))
            return 1;
        } else if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
          _id_642470E1ABC1BBF9.victim thread scripts\mp\playerlogic::respawn_asspectator(_id_642470E1ABC1BBF9.victim.origin + (0, 0, 60), _id_642470E1ABC1BBF9.victim.angles);

        _id_642470E1ABC1BBF9.victim thread _id_5BAB271917698DC4::_id_844BDF70E8A61534();
        return 1;
      }
    }
  } else if(!playershouldrespawn()) {
    if(!scripts\mp\utility\damage::playershoulddofauxdeath(0) && !_id_362C58E8BB39BCDA::isfeaturedisabled("spectateOnDeath"))
      _id_642470E1ABC1BBF9.victim thread _id_6489FCDFE6FA2E36::spawnspectator(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);
    else if(scripts\mp\utility\game::getsubgametype() == "dmz") {
      self.br_spectatorinitialized = 1;
      self notify("br_spectatorInitialized");
    }

    return 1;
  }

  return 0;
}

brmayconsiderplayerdead(player) {
  result = _id_362C58E8BB39BCDA::runbrgametypefunc("mayConsiderPlayerDead", player);

  if(isDefined(result))
    return result;

  if(scripts\mp\flags::gameflag("prematch_done") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "isEnabled") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "isEnabled")]]() && scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "disablePlayer"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "disablePlayer")]](player, "player_dead");

  _id_E111BC24345972FF = player _id_67708F418B1FAC79::trygulagspawn();

  if(scripts\mp\flags::gameflag("prematch_done") && !_id_E111BC24345972FF)
    _id_0A34750D17473C49::markplayeraseliminated(player, "brMayConsiderPlayerDead");

  return !_id_E111BC24345972FF;
}

unreachable_function() {}

monitorweaponswitchbr() {
  level endon("game_ended");
  self endon("disconnect");
  lastweaponchangetime = gettime();

  for(;;) {
    self waittill("weapon_change");
    _id_4046BF37E49E7A5C = gettime();

    if(_id_4046BF37E49E7A5C - lastweaponchangetime >= 3000) {
      _id_68944C6870DA247B = _id_4046BF37E49E7A5C - lastweaponchangetime;
      thread giveweaponxpfromtimebr(_id_68944C6870DA247B);
    }

    lastweaponchangetime = _id_4046BF37E49E7A5C;
  }
}

weaponshouldgetxp(weapon) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  return weaponhasranks(_id_AB501F397D3CD312);
}

weaponhasranks(_id_AB501F397D3CD312) {
  if(!isDefined(level.weaponranktable.maxweaponranks[_id_AB501F397D3CD312]))
    return 0;

  _id_77492B2ECBE850E2 = level.weaponranktable.maxweaponranks[_id_AB501F397D3CD312] > 0;
  return _id_77492B2ECBE850E2;
}

announceplayercountlandmarks() {
  _id_2FE5E740A0022889 = getdvarfloat("dvar_7383409DF4EA8BD2", 0.6);

  if(!_id_2FE5E740A0022889) {
    return;
  }
  level endon("game_ended");
  level waittill("prematch_started");

  if(getdvarint("dvar_D9F5B4D05943B70C", 0) == 1) {
    level _id_773C7F13E1254D74(50, _id_2FE5E740A0022889);
    level _id_773C7F13E1254D74(25, _id_2FE5E740A0022889);
    level _id_773C7F13E1254D74(10, _id_2FE5E740A0022889);
    level _id_773C7F13E1254D74(5, _id_2FE5E740A0022889);
  } else {
    level playersleftloop(50, _id_2FE5E740A0022889);
    level playersleftloop(25, _id_2FE5E740A0022889);
    level playersleftloop(10, _id_2FE5E740A0022889);
    level playersleftloop(5, _id_2FE5E740A0022889);
  }
}

playersleftloop(numplayers, _id_2FE5E740A0022889) {
  if(istrue(level.brgametype._id_C435BC516C8091CA)) {
    return;
  }
  if(getdvarint("party_maxplayers", 20) * _id_2FE5E740A0022889 < numplayers) {
    return;
  }
  level endon("game_ended");
  _id_BEDB769CC0E5E018 = getbrplayersnoteliminated();
  _id_ADA79DBC285A1B55 = scripts\mp\utility\game::getsubgametype() == "resurgence" && level.brgametype._id_04AD7C03EC4FA687;

  while(_id_BEDB769CC0E5E018.size > numplayers) {
    level scripts\engine\utility::waittill_either("br_player_eliminated", "players_remaining_changed");
    _id_BEDB769CC0E5E018 = getbrplayersnoteliminated();

    if(_id_BEDB769CC0E5E018.size <= numplayers) {
      _id_0457D1BA9EA64FD1 = !istrue(level.usegulag) || istrue(level.gulag.shutdown);

      if(_id_ADA79DBC285A1B55 || _id_0457D1BA9EA64FD1)
        _id_2CEDCC356F1B9FC8::brleaderdialog("top_" + numplayers, 0, undefined, 1);

      break;
    }
  }
}

_id_773C7F13E1254D74(numplayers, _id_2FE5E740A0022889) {
  if(getdvarint("party_maxplayers", 20) * _id_2FE5E740A0022889 < numplayers) {
    return;
  }
  level endon("game_ended");
  _id_BEDB769CC0E5E018 = getbrplayersnoteliminated();
  _id_ADA79DBC285A1B55 = scripts\mp\utility\game::getsubgametype() == "resurgence" && level.brgametype._id_04AD7C03EC4FA687;
  _id_9EA582CFEF3850C6 = [];
  _id_A4C3A5AFE5B8DA9B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BEDB769CC0E5E018.size; _id_AC0E594AC96AA3A8++) {
    player = _id_BEDB769CC0E5E018[_id_AC0E594AC96AA3A8];

    if(player _id_7DBB8165D792B06C()) {
      continue;
    }
    if(!isDefined(_id_A4C3A5AFE5B8DA9B[player.team])) {
      _id_A4C3A5AFE5B8DA9B[player.team] = 1;
      _id_9EA582CFEF3850C6[_id_9EA582CFEF3850C6.size] = player.team;
    }
  }

  while(_id_BEDB769CC0E5E018.size > numplayers && _id_9EA582CFEF3850C6.size > 0) {
    level scripts\engine\utility::waittill_either("br_player_eliminated", "players_remaining_changed");
    _id_BEDB769CC0E5E018 = getbrplayersnoteliminated();
    _id_8986CC772C6DE270 = [];

    foreach(team in _id_9EA582CFEF3850C6) {
      _id_DADCB19D1B7DB056 = scripts\mp\utility\teams::getteamdata(team, "alivePlayers");

      if(!isDefined(_id_DADCB19D1B7DB056))
        _id_DADCB19D1B7DB056 = [];

      if(_id_BEDB769CC0E5E018.size - _id_DADCB19D1B7DB056.size <= numplayers) {
        _id_0457D1BA9EA64FD1 = !istrue(level.usegulag) || istrue(level.gulag.shutdown);

        if(_id_ADA79DBC285A1B55 || _id_0457D1BA9EA64FD1)
          _id_2CEDCC356F1B9FC8::brleaderdialogteam("top_" + numplayers, team, 0, undefined, 1);

        _id_8986CC772C6DE270[_id_8986CC772C6DE270.size] = team;
      }
    }

    foreach(team in _id_8986CC772C6DE270)
    _id_9EA582CFEF3850C6 = scripts\engine\utility::array_remove(_id_9EA582CFEF3850C6, team);
  }
}

getbrplayersnoteliminated() {
  _id_F7BC4EF9C5601076 = [];

  foreach(player in level.players) {
    if(istrue(player.br_iseliminated)) {
      continue;
    }
    if(player _id_2CEDCC356F1B9FC8::playeriszombie()) {
      continue;
    }
    if(level.codcasterenabled) {
      if(player _meth_8420670EAFC8D391())
        continue;
    }

    _id_F7BC4EF9C5601076[_id_F7BC4EF9C5601076.size] = player;
  }

  return _id_F7BC4EF9C5601076;
}

_id_F297F4741391514D() {
  _id_C0BDDB9FBE492AF7 = [];

  foreach(team in level.teamnamelist) {
    if(_id_F8167AAB51948BF0(team)) {
      continue;
    }
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      if(player _id_2CEDCC356F1B9FC8::playeriszombie()) {
        continue;
      }
      if(level.codcasterenabled) {
        if(player _meth_8420670EAFC8D391())
          continue;
      }

      _id_C0BDDB9FBE492AF7[_id_C0BDDB9FBE492AF7.size] = player;
    }
  }

  return _id_C0BDDB9FBE492AF7;
}

_id_F8167AAB51948BF0(team) {
  _id_7B7B91FCE61D92F0 = scripts\mp\utility\teams::getteamdata(team, "aliveCount") == 0;
  teamcanrespawn = isDefined(level.teamcanrespawn) && istrue(level.teamcanrespawn[team]);
  return _id_7B7B91FCE61D92F0 && !teamcanrespawn;
}

resetafkchecks(player) {
  if(isDefined(player.gulaguses) && player.gulaguses > 0 || istrue(player.ffsm_isgulagrespawn)) {
    player.ignoreafkcheck = 0;

    if(!istrue(player.pers["distTrackingPassed"])) {
      player.pers["distTrackingPassedOrResetTime"] = player scripts\mp\teams::_id_19300ABFBB10928B();
      player thread scripts\mp\playerlogic::totaldisttracking(player.origin);
    } else
      player notify("afk_tracking_resume");

    return;
  }

  player.pers["distTrackingPassed"] = 0;
  player.pers["totalDistTraveledAFK"] = 0;
  player._id_CB9581FC7FF5F394 = undefined;
  player thread scripts\mp\playerlogic::totaldisttracking(player.origin);
}

_id_49738978A130D729(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player waittill("laststand_revived");
  _id_F7FC6D074E78A084(player);
}

onfirstlandcallback(player) {
  if(!scripts\mp\utility\player::isreallyalive(player)) {
    return;
  }
  if(scripts\mp\utility\player::isinlaststand(player)) {
    level thread _id_49738978A130D729(player);
    return;
  }

  _id_F7FC6D074E78A084(player);
}

_id_B6C2BD8342C0670E(player) {
  level endon("game_ended");
  player endon("death_or_disconnect");

  for(;;) {
    if(!player _meth_E40102956C887F7C()) {
      player._id_91A2B1303B861667 = undefined;
      break;
    }

    wait 0.5;
  }
}

_id_F7FC6D074E78A084(player) {
  resetafkchecks(player);
  player.brneverlanded = undefined;
  player scripts\mp\calloutmarkerping_mp::calloutmarkerping_squadleaderbeaconplayerfirstlanded();
  level thread _id_B6C2BD8342C0670E(player);

  if(getdvarint("dvar_9F0AEA8FBA119184", 1) == 1)
    player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);

  if(istrue(level._id_387CD21817428092)) {
    if(level._id_387CD21817428092 != 0) {
      if(!istrue(level.teamdata[player.team]["squadBoonDropped"])) {
        if(scripts\mp\flags::gameflag("prematch_done") && scripts\mp\flags::gameflag("br_ready_to_jump")) {
          if(player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
            player _id_90011DB2FCA825A8();
            level.teamdata[player.team]["squadBoonDropped"] = 1;
          }
        }
      }
    }
  }

  _id_362C58E8BB39BCDA::runbrgametypefunc("onPlayerFirstLand", player);
}

updatesquadmemberlaststandreviveprogress(_id_22F7E3F7E360775B, reviver, progress, _id_979D1594B4F7F7BE) {
  if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
    if(!isDefined(level.br_squadrevivestatus))
      level.br_squadrevivestatus = [];

    _id_70401238ACB839BC = get_int_or_0(level.br_squadrevivestatus[_id_22F7E3F7E360775B.team]);

    if(!isalive(_id_22F7E3F7E360775B)) {
      _id_979D1594B4F7F7BE = 1;
      progress = 0;
    }

    _id_053B0B2667F5CEB2 = _id_22F7E3F7E360775B == reviver;
    squadindex = _id_22F7E3F7E360775B._id_3F78C6A0862F9E25;
    _id_98C2F6161F41A683 = int(ceil(clamp(progress, 0, 1) * 15));
    _id_B792D342072A35C0 = _id_98C2F6161F41A683;

    if(istrue(_id_979D1594B4F7F7BE))
      _id_22F7E3F7E360775B _id_2CEDCC356F1B9FC8::setplayerselfrevivingextrainfo(0);
    else if(_id_053B0B2667F5CEB2)
      _id_22F7E3F7E360775B _id_2CEDCC356F1B9FC8::setplayerselfrevivingextrainfo(1);

    if(squadindex == -1) {
      return;
    }
    _id_64571E3AECCD1A07 = squadindex * 5;
    _id_B27D0EFF739466E0 = (_id_B792D342072A35C0 & 31) << _id_64571E3AECCD1A07;
    _id_F8F977081D3DA8B4 = ~(31 << _id_64571E3AECCD1A07);
    _id_ED711AEAF5E8CB76 = _id_70401238ACB839BC &_id_F8F977081D3DA8B4;
    _id_454D6756FB16FF83 = _id_ED711AEAF5E8CB76 + _id_B27D0EFF739466E0;
    level.br_squadrevivestatus[_id_22F7E3F7E360775B.team] = _id_454D6756FB16FF83;
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(_id_22F7E3F7E360775B.team, "players");

    if(isDefined(_id_6D5ED003AF1F9612) && _id_6D5ED003AF1F9612.size > 0) {
      foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612)
      _id_F0EA4030349A33D5 setclientomnvar("ui_br_squad_revive_status", _id_454D6756FB16FF83);
    }
  }
}

calculateclientmatchdataextrainfopayload(player) {
  _id_53CF4AFA40BCDDC4 = [0, 0, 0, 0];

  if(isDefined(player) && isDefined(player.brmissiontypescompleted)) {
    _id_B6A02FDCEF39DD11 = 0;

    foreach(_id_5744FAFD565864D7, _id_CFBAA84BF8594E2A in player.brmissiontypescompleted) {
      _id_591000CB6EF11522 = undefined;

      if(getdvarint("dvar_82BDE055B11E6698", 0))
        _id_591000CB6EF11522 = _id_3ACF1C0EBAF602F2::getquesttableindex(_id_5744FAFD565864D7);
      else
        _id_591000CB6EF11522 = _id_64ACB6CE534155B7::getquesttableindex(_id_5744FAFD565864D7);

      _id_7417822DB1EBF4B1 = int(clamp(_id_CFBAA84BF8594E2A, 0, 15)) << 4;
      _id_53CF4AFA40BCDDC4[_id_B6A02FDCEF39DD11] = _id_7417822DB1EBF4B1 + _id_591000CB6EF11522;
      _id_B6A02FDCEF39DD11++;

      if(_id_B6A02FDCEF39DD11 >= 4) {
        break;
      }
    }
  }

  _id_6207408622BD0E3E = [];
  _id_6207408622BD0E3E[0] = (_id_53CF4AFA40BCDDC4[0] << 8) + _id_53CF4AFA40BCDDC4[1];
  _id_6207408622BD0E3E[1] = (_id_53CF4AFA40BCDDC4[2] << 8) + _id_53CF4AFA40BCDDC4[3];
  _id_6207408622BD0E3E[2] = get_int_or_0(player.br_contractxpearned);
  _id_1B83ACB5F45683AC = int(clamp(get_int_or_0(player._id_3F78C6A0862F9E25) - 1, 0, 3));
  _id_6207408622BD0E3E[3] = _id_1B83ACB5F45683AC << 14;
  _id_6207408622BD0E3E[3] = _id_6207408622BD0E3E[3] + get_int_or_0(player.pers["damage"]);
  return _id_6207408622BD0E3E;
}

onplayerconnectstream() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "spectator" || self.sessionteam == "none" || isDefined(self.initialprespawn) || self isplayerheadless())
    return 0;

  if(istrue(level.codcasterenabled) && self _meth_8420670EAFC8D391())
    return 1;

  if(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF() && !isbot(self)) {
    self setclientomnvar("ui_br_extended_load_screen", 1);
    return 0;
  }

  if(!usedropspawn())
    return 1;

  spawnpoint = getspawnpoint();
  self.initialprespawn = spawnpoint;
  self setclientomnvar("ui_br_extended_load_screen", 1);
  droporigin = _id_2CEDCC356F1B9FC8::playerstreamhintdroptoground(spawnpoint.origin);
  spawnintermission(droporigin, spawnpoint.angles);
  timeout = getdvarint("dvar_3F23E1C2BBC2681A", 15000);
  _id_2CEDCC356F1B9FC8::playerstreamhintlocation(droporigin, timeout, 1, 1);
  return 0;
}

_id_67A646DC2B984DAC() {
  if(!isDefined(self.sessionteam) || self.sessionteam == "spectator" || self.sessionteam == "none" || self isplayerheadless())
    return 0;

  spawnpoint = self getorigin();
  self setclientomnvar("ui_br_extended_load_screen", 1);
  timeout = getdvarint("dvar_3F23E1C2BBC2681A", 15000);
  _id_2CEDCC356F1B9FC8::playerstreamhintlocation(spawnpoint, timeout, 1, 1);
  return 0;
}

playerisstreaming() {
  return self.sessionstate == "intermission" && isDefined(self.initialprespawn);
}

lastdroppableweaponchanged() {
  _id_EE490A6916FE49B7 = -1;

  if(isDefined(self.lastdroppableweaponobj))
    _id_EE490A6916FE49B7 = getweaponindex(self.lastdroppableweaponobj);

  self setclientomnvar("ui_br_last_droppable_weapon", _id_EE490A6916FE49B7);
}

brregenhealthadd(_id_7C90DD5575D81006) {
  _id_15123138426896F0 = _id_362C58E8BB39BCDA::runbrgametypefunc("regenHealthAdd", _id_7C90DD5575D81006);

  if(isDefined(_id_15123138426896F0))
    return _id_15123138426896F0;
  else
    return _id_7C90DD5575D81006;
}

brregendelayspeed(_id_01F1BD121B3EAA21) {
  _id_15123138426896F0 = _id_362C58E8BB39BCDA::runbrgametypefunc("regenDelaySpeed", _id_01F1BD121B3EAA21);

  if(isDefined(_id_15123138426896F0))
    return _id_15123138426896F0;
  else
    return _id_01F1BD121B3EAA21;
}

brmodeaddtoteamlives(player, team, context) {
  _id_362C58E8BB39BCDA::runbrgametypefunc("addToTeamLives", player, team);
  player _id_0A34750D17473C49::_id_B5483AF58EE9F2C3(1, team, context);
}

brmoderemovefromteamlives(player, team, context) {
  _id_362C58E8BB39BCDA::runbrgametypefunc("removeFromTeamLives", player, team);
  player _id_0A34750D17473C49::_id_B5483AF58EE9F2C3(0, team, context);
}

updateplayerandteamcountui() {
  level notify("updatePlayerAndTeamCountUI");
  level endon("updatePlayerAndTeamCountUI");
  waittillframeend;

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("updatePlayerAndTeamCountUI")) {
    _id_362C58E8BB39BCDA::runbrgametypefunc("updatePlayerAndTeamCountUI");
    return;
  }

  totalplayers = level.players.size;
  _id_6B2375BEF731CC3A = 0;
  _id_35068B9B9DC4C73F = 0;
  _id_A4C3A5AFE5B8DA9B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < totalplayers; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(player _id_7DBB8165D792B06C() || player.team == "spectator" || player.team == "codcaster") {
      continue;
    }
    if(!istrue(player.br_iseliminated)) {
      if(istrue(player.iszombie) || istrue(player._id_7F788F4B6412959C))
        _id_35068B9B9DC4C73F++;
      else {
        _id_6B2375BEF731CC3A++;
        _id_A4C3A5AFE5B8DA9B[player.team] = 1;
      }
    }

    if(!isDefined(_id_A4C3A5AFE5B8DA9B[player.team])) {
      result = _id_362C58E8BB39BCDA::runbrgametypefunc("isTeamEliminated", player.team);

      if(isDefined(result)) {
        if(!result)
          _id_A4C3A5AFE5B8DA9B[player.team] = 1;
      }
    }
  }

  foreach(_id_B4ADDE4C68BB0F24 in _id_749723C2A45A0233()) {
    _id_6B2375BEF731CC3A++;
    _id_A4C3A5AFE5B8DA9B[_id_B4ADDE4C68BB0F24.team] = 1;
  }

  _id_047BF15E70EE220A = (_id_35068B9B9DC4C73F << 16) + (_id_A4C3A5AFE5B8DA9B.size << 8) + _id_6B2375BEF731CC3A;
  setomnvar("ui_br_match_stats", _id_047BF15E70EE220A);
}

br_updategameevents() {
  totalplayers = 0;
  level.teamswithplayers = [];
  _id_09AA4910DF893FAB = 0;

  foreach(team in level.teamnamelist) {
    _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(team, "teamCount");

    if(isDefined(level._id_7B37B2193F163B9B))
      _id_652F47620AC4713F = _id_652F47620AC4713F + scripts\mp\utility\teams::getteamdata(team, "UIBotCount");

    if(_id_652F47620AC4713F) {
      totalplayers = totalplayers + _id_652F47620AC4713F;
      _id_09AA4910DF893FAB++;
      level.teamswithplayers[level.teamswithplayers.size] = team;

      if(_id_09AA4910DF893FAB > 1) {
        break;
      }
    }
  }

  if(scripts\mp\utility\game::matchmakinggame() && !level.ingraceperiod && (!isDefined(level.disableforfeit) || !level.disableforfeit) && !scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    if(level.teambased) {
      if(level.teamswithplayers.size == 1 && game["state"] == "playing") {
        thread scripts\mp\gamelogic::onforfeit(level.teamswithplayers[0]);
        return;
      }

      if(level.teamswithplayers.size > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
      }
    } else {
      if(totalplayers == 1 && level.maxplayercount > 1) {
        thread scripts\mp\gamelogic::onforfeit();
        return;
      }

      if(totalplayers > 1) {
        level.forfeitinprogress = undefined;
        level notify("abort_forfeit");
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
  br_checkforlaststandfinish();

  if(isDefined(level.checkforlaststandwipe))
    [[level.checkforlaststandwipe]]();

  if(level.teambased) {
    livescount = [];
    _id_3ED276C562480671 = 0;
    _id_4351D3695CBE4FD7 = 0;
    _id_3C4188E57EE38E07 = [];
    _id_388B9E43B508CD03 = [];

    foreach(_id_F90358454413407F in level.teamnamelist) {
      livescount[_id_F90358454413407F] = 0;

      if(!istrue(level.disablespawning)) {
        foreach(player in scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players")) {
          if(!istrue(player.hasspawned) || player.team == "spectator" || player.team == "codcaster" || player.team == "free") {
            continue;
          }
          if(player.pers["lives"]) {
            livescount[_id_F90358454413407F] = livescount[_id_F90358454413407F] + player.pers["lives"];
            _id_3ED276C562480671 = 1;
          }
        }
      }

      _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");
      _id_E1E65E11F75F9CBB = _id_D0F9FBF3F0F8C739(_id_F90358454413407F);
      _id_F5ED82F1F755BB2D = _id_BCE4EFC75EB01319 > 0 || _id_E1E65E11F75F9CBB > 0;

      if(!_id_4351D3695CBE4FD7 && _id_F5ED82F1F755BB2D)
        _id_4351D3695CBE4FD7 = 1;

      _id_BCE4EFC75EB01319 = _id_BCE4EFC75EB01319 + _id_E1E65E11F75F9CBB;
      _id_4F212C7C91F56842 = 1;
      result = _id_362C58E8BB39BCDA::runbrgametypefunc("isTeamEliminated", _id_F90358454413407F);

      if(isDefined(result)) {
        if(!result)
          _id_4F212C7C91F56842 = 0;
      }

      if(_id_4F212C7C91F56842 && scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "hasSpawned") && !_id_F5ED82F1F755BB2D && !livescount[_id_F90358454413407F] && !scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "deathEvent")) {
        _id_3C4188E57EE38E07[_id_3C4188E57EE38E07.size] = _id_F90358454413407F;
        continue;
      }

      if(_id_BCE4EFC75EB01319 == 1) {
        if(gettime() > scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "oneLeftTime") + 5000 && !scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "oneLeft")) {
          _id_91595DB4CCF80384 = 0;
          players = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players");

          foreach(player in players) {
            if(!isalive(player))
              _id_91595DB4CCF80384 = _id_91595DB4CCF80384 + player.pers["lives"];
          }

          if(_id_91595DB4CCF80384 == 0) {
            scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeftTime", gettime());
            scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeft", 1);

            if(players.size + _id_E1E65E11F75F9CBB > 1)
              [[level.ononeleftevent]](_id_F90358454413407F);
          }
        }

        continue;
      }

      scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "oneLeft", 0);
    }

    if(!_id_4351D3695CBE4FD7 && !_id_3ED276C562480671) {
      if(istrue(level.postgameexfil) && level.gameended)
        level notify("exfil_continue_game_end");

      if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
        return;
      }
      return [[level.ondeadevent]]("all");
    }

    if(istrue(level.postgameexfil) && level.gameended)
      level notify("exfil_continue_game_end");

    if(!istrue(level.skipondeadevent) && !istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
      foreach(_id_F90358454413407F in _id_3C4188E57EE38E07) {
        if(level.multiteambased) {
          scripts\mp\utility\teams::setteamdata(_id_F90358454413407F, "deathEvent", 1);
          [[level.ondeadevent]](_id_F90358454413407F);
          continue;
        }

        return [[level.ondeadevent]](_id_F90358454413407F);
      }
    }
  } else {
    livescount = 0;

    foreach(player in level.players) {
      if(player.team == "spectator" || player.team == "codcaster") {
        continue;
      }
      livescount = livescount + player.pers["lives"];
    }

    _id_1F7BCAA53CA6D399 = 0;

    foreach(_id_F90358454413407F in level.teamnamelist)
    _id_1F7BCAA53CA6D399 = _id_1F7BCAA53CA6D399 + scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");

    if(!_id_1F7BCAA53CA6D399 && !livescount) {
      if(istrue(level.nukeinfo._id_9DCCABA98B643CAD)) {
        return;
      }
      return [[level.ondeadevent]]("all");
    }

    _id_677AE66DF2125F53 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(_id_677AE66DF2125F53.size == 1)
      return [[level.ononeleftevent]]("all");
  }

  _id_362C58E8BB39BCDA::runbrgametypefunc("postUpdateGameEvents");
}

lowpopallowtweaks() {
  return istrue(level.lowpopcheck) && getdvarint("dvar_07C1F8A5958FE9D4", 1);
}

br_laststandfinishplayerisincapacitated(_id_A11643FDEEDEE81B) {
  _id_F750EAC01A3C640A = istrue(_id_A11643FDEEDEE81B) && _id_67708F418B1FAC79::checkgulagusecount();
  return istrue(self.inlaststand) && !_id_2CEDCC356F1B9FC8::hasselfrevivetoken() && !_id_F750EAC01A3C640A;
}

br_highlightlaststandfinishplayers() {
  attackers = [];
  victims = [];
  _id_A11643FDEEDEE81B = isDefined(level.gulag) && !istrue(level.gulag.shutdown);

  if(level.teambased) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      _id_17077B9DAE232349 = 0;

      foreach(player in level.teamdata[_id_F90358454413407F]["alivePlayers"]) {
        if(player br_laststandfinishplayerisincapacitated(_id_A11643FDEEDEE81B)) {
          continue;
        }
        _id_17077B9DAE232349 = 1;
        break;
      }

      if(_id_17077B9DAE232349) {
        foreach(player in level.teamdata[_id_F90358454413407F]["alivePlayers"]) {
          if(player br_laststandfinishplayerisincapacitated(_id_A11643FDEEDEE81B)) {
            continue;
          }
          attackers[attackers.size] = player;
        }

        continue;
      }

      foreach(player in level.teamdata[_id_F90358454413407F]["alivePlayers"]) {
        if(player br_laststandfinishplayerisincapacitated(_id_A11643FDEEDEE81B))
          victims[victims.size] = player;
      }
    }
  } else {
    foreach(player in level.players) {
      if(player br_laststandfinishplayerisincapacitated(_id_A11643FDEEDEE81B)) {
        victims[victims.size] = player;
        continue;
      }

      if(isalive(player))
        attackers[attackers.size] = player;
    }
  }

  if(!_id_2CEDCC356F1B9FC8::istutorial()) {
    _id_2CEDCC356F1B9FC8::brleaderdialog("finish_calls", 0, attackers);

    foreach(player in attackers) {
      player setclientomnvar("ui_br_end_game_splash_type", 19);
      player playlocalsound("br_finish_them_splash");
    }

    foreach(player in victims)
    player hudoutlineenable("outline_nodepth_red");
  }
}

br_checkforlaststandfinish() {
  if(!getdvarint("dvar_9513D33B9343F1A0", 0)) {
    return;
  }
  if(istrue(level.laststandfinisherdone)) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "plunder" || scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "kingslayer" || scripts\mp\utility\game::getsubgametype() == "rumble_mgl") {
    return;
  }
  _id_A11643FDEEDEE81B = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  _id_90B405FE6856A3A4 = 0;
  _id_1D0BD18DD6759D61 = 0;

  if(level.teambased) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      _id_17077B9DAE232349 = 0;

      foreach(player in level.teamdata[_id_F90358454413407F]["alivePlayers"]) {
        if(player br_laststandfinishplayerisincapacitated(_id_A11643FDEEDEE81B)) {
          _id_1D0BD18DD6759D61 = 1;
          continue;
        }

        _id_17077B9DAE232349 = 1;
        break;
      }

      if(_id_17077B9DAE232349) {
        _id_90B405FE6856A3A4++;

        if(_id_90B405FE6856A3A4 > 1)
          return;
      }
    }
  } else {
    foreach(player in level.players) {
      if(!isalive(player)) {
        continue;
      }
      if(player br_laststandfinishplayerisincapacitated(_id_A11643FDEEDEE81B)) {
        _id_1D0BD18DD6759D61 = 1;
        continue;
      }

      _id_90B405FE6856A3A4++;

      if(_id_90B405FE6856A3A4 > 1)
        return;
    }
  }

  if(_id_90B405FE6856A3A4 == 0 || !_id_1D0BD18DD6759D61) {
    return;
  }
  level.laststandfinisherdone = 1;
  br_highlightlaststandfinishplayers();
}

br_checkforlaststandwipe(victim, _id_9C14AE6E04BBD667) {
  if(!getdvarint("dvar_B11F030E3DC6E3FF", 1))
    return 0;

  if(istrue(_id_2CEDCC356F1B9FC8::_id_CC053AECC2C53ECF()))
    return 0;

  if(isDefined(level._id_F44D8C2D0A8691A8))
    return 0;

  level._id_F44D8C2D0A8691A8 = 1;
  _id_A11643FDEEDEE81B = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  _id_F22FB09A173DCC1C = [];
  _id_C9FA03A7D2163C24 = 0;
  _id_6A9853A7EF309B8F = [];
  _id_FA2DFB970D051F16 = [];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_B1FD2C57A16C6E04 = 1;
    _id_F22FB09A173DCC1C = [];
    _id_7B618684ADBE33F6 = 0;

    foreach(player in level.teamdata[_id_F90358454413407F]["alivePlayers"]) {
      _id_1B7F5108008D55B6 = istrue(_id_A11643FDEEDEE81B) && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag();

      if(_id_1B7F5108008D55B6) {
        continue;
      }
      if(istrue(_id_9C14AE6E04BBD667) && (isDefined(victim) && victim == player)) {
        _id_7B618684ADBE33F6 = 1;
        continue;
      }

      isinlaststand = istrue(player.inlaststand) || isDefined(victim) && victim == player;

      if(isinlaststand && !player _id_2CEDCC356F1B9FC8::hasselfrevivetoken() && !istrue(player _id_556B8AEAA691317F::_id_A35FFF2FF233592A()) && !player _id_2CEDCC356F1B9FC8::playeriszombie()) {
        _id_F22FB09A173DCC1C[_id_F22FB09A173DCC1C.size] = player;
        continue;
      }

      _id_B1FD2C57A16C6E04 = 0;
      break;
    }

    _id_DB5C349FB62D9AC6 = !istrue(level.brgametype._id_B43745B85F249E68) && _id_B1FD2C57A16C6E04 && (_id_F22FB09A173DCC1C.size > 0 || istrue(_id_9C14AE6E04BBD667) && _id_7B618684ADBE33F6);

    if(istrue(_id_DB5C349FB62D9AC6)) {
      _id_39341F43DD2CC6F0 = istrue(level.brgametype._id_C42E40EC22A1F0D4) && isDefined(victim) && istrue(victim._id_1E309FA83F9FBE2E) && (!isDefined(victim.respawndelay) || victim.respawndelay <= 0);
      _id_DB5C349FB62D9AC6 = !istrue(_id_39341F43DD2CC6F0);
    }

    if(istrue(_id_DB5C349FB62D9AC6)) {
      attackers = [];

      foreach(_id_E3D55ABD84AD4CA9 in _id_F22FB09A173DCC1C) {
        if(isDefined(_id_E3D55ABD84AD4CA9.laststandattacker) && !scripts\engine\utility::array_contains(attackers, _id_E3D55ABD84AD4CA9.laststandattacker)) {
          _id_E3D55ABD84AD4CA9.laststandattacker.wipeweapon = _id_E3D55ABD84AD4CA9.laststandweaponobj;
          attackers[attackers.size] = _id_E3D55ABD84AD4CA9.laststandattacker;
        }

        if(isDefined(victim) && victim == _id_E3D55ABD84AD4CA9)
          _id_C9FA03A7D2163C24 = 1;

        _id_E3D55ABD84AD4CA9 notify("squad_wipe_death");
        _id_E3D55ABD84AD4CA9.squadwiped = 1;
        _id_E3D55ABD84AD4CA9._id_4CE88B2DFE0BFA52 = 1;
        _id_E3D55ABD84AD4CA9 scripts\mp\utility\damage::_suicide(0);
        _id_E3D55ABD84AD4CA9._id_4CE88B2DFE0BFA52 = undefined;
      }

      if(istrue(_id_9C14AE6E04BBD667) && isDefined(victim) && isDefined(victim.laststandattacker) && !scripts\engine\utility::array_contains(attackers, victim.laststandattacker))
        attackers[attackers.size] = victim.laststandattacker;

      foreach(attacker in attackers) {
        if(isDefined(attacker.team) && !isDefined(_id_FA2DFB970D051F16[attacker.team])) {
          _id_FA2DFB970D051F16[attacker.team] = 1;
          _id_FFCDDBAB91473037 = level.teamdata[attacker.team]["alivePlayers"];

          foreach(_id_78D4262A23453D9E in _id_FFCDDBAB91473037) {
            _id_78D4262A23453D9E thread scripts\mp\events::killeventtextpopup("stat_5766542B6AD9975A", 0);
            _id_78D4262A23453D9E thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5766542B6AD9975A", _id_78D4262A23453D9E.wipeweapon);
          }

          wipeweapon = self.laststandweaponobj;

          if(!isDefined(wipeweapon)) {
            if(isDefined(victim) && isDefined(victim.laststandattacker))
              wipeweapon = victim.laststandattacker.currentweapon;
            else
              wipeweapon = attacker.currentweapon;
          }

          attacker thread teamwipedobituary(victim, attacker, wipeweapon);
        }

        attacker.wipeweapon = undefined;

        if(!isDefined(_id_6A9853A7EF309B8F[attacker.team]) && !scripts\mp\damage::_id_80ADE967129C9845()) {
          _id_6A9853A7EF309B8F[attacker.team] = 1;
          attacker playsoundtoteam("ui_team_wipe_splash", attacker.team);
        }
      }

      _id_6A8EC730B2BFA844::_id_63FEDB7F004DA23B(attackers);
    }
  }

  level._id_F44D8C2D0A8691A8 = undefined;
  return _id_C9FA03A7D2163C24;
}

teamwipedobituary(victim, attacker, laststandweapon) {
  attackerteam = attacker.team;
  waitframe();

  if(getdvarint("dvar_6084A01ACCF3B2EB", 1)) {
    if(isDefined(victim) && isDefined(attackerteam)) {
      _id_F86DA5D91524E369 = [];

      if(isDefined(level._id_C5877DBE60FDDBF6))
        _id_F86DA5D91524E369 = level._id_C5877DBE60FDDBF6;

      _id_F86DA5D91524E369 = scripts\engine\utility::array_combine(_id_F86DA5D91524E369, level.teamdata[attackerteam]["alivePlayers"]);
      obituary(victim, attacker, laststandweapon, "MOD_TEAM_WIPED", _id_F86DA5D91524E369);
    }
  }
}

brdisabledamagestattracking(player) {
  if(brgulagdamagefilter(player))
    return 0;

  if(isagent(player))
    return 0;

  return 1;
}

initializeaardata(player) {
  if(player scripts\mp\utility\game::rankingenabled() && player hasplayerdata()) {
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 0, 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 1, 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 2, 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 3, 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 4, 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 5, 0);
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 6, 0);
    _id_BF587C66B60EF10F = player getplayerdata("common", "mpProgression", "playerLevel", "xp");
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 7, _id_BF587C66B60EF10F);
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 8, _id_BF587C66B60EF10F);
  }
}

setaardata(team) {
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(!player scripts\mp\utility\game::rankingenabled() || !player hasplayerdata()) {
      continue;
    }
    _id_6DAE31F85F556E55 = player.pers["combatXP"];

    if(!isDefined(_id_6DAE31F85F556E55))
      _id_6DAE31F85F556E55 = 0;

    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 0, _id_6DAE31F85F556E55);
    _id_54658E63E8FB96B5 = player.pers["missionXP"];

    if(!isDefined(_id_54658E63E8FB96B5))
      _id_54658E63E8FB96B5 = 0;

    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 1, _id_54658E63E8FB96B5);
    _id_737B512E4921C915 = player.pers["lootingXP"];

    if(!isDefined(_id_737B512E4921C915))
      _id_737B512E4921C915 = 0;

    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 2, _id_737B512E4921C915);
    _id_A778B138DD227A8C = player.pers["supportXP"];

    if(!isDefined(_id_A778B138DD227A8C))
      _id_A778B138DD227A8C = 0;

    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 3, _id_A778B138DD227A8C);
    _id_7DE8BC11139992C8 = player.pers["reconXP"];

    if(!isDefined(_id_7DE8BC11139992C8))
      _id_7DE8BC11139992C8 = 0;

    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 4, _id_7DE8BC11139992C8);
    matchbonus = 0;

    if(isDefined(player.matchbonus))
      matchbonus = int(player.matchbonus);

    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 5, matchbonus);
    placementbonus = 0;

    if(isDefined(player.placementbonus))
      placementbonus = int(player.placementbonus);

    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 6, placementbonus);
    _id_BF587C66B60EF10F = player getplayerdata(level._id_5D69837CF4DB0407, "aarValue", 7);
    _id_EFE4124EAA21EA43 = _id_BF587C66B60EF10F + player.pers["summary"]["xp"];
    player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 8, _id_EFE4124EAA21EA43);
    player setplayerdata("common", "brSubGameType", getDvar("dvar_7611A2790A0BF7FE"));
    player notify("br_player_aar_data_set");
  }
}

briskillstreakallowed(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470) {
  if(isDefined(self.vehicle)) {
    streakname = _id_16EFCF27E6EFCBE8.streakname;

    if(streakname == "manual_turret")
      return 0;
  }

  return 1;
}

brkillstreakbeginusefunc(streakinfo) {
  if(!isDefined(streakinfo))
    return 0;

  player = streakinfo.owner;

  if(!isDefined(player))
    return 0;

  if(!istrue(streakinfo.skipequippedstreakcheck) && !player _id_7E52B56769FA7774::doesstreakinfomatchequippedstreak(streakinfo))
    return 0;

  return scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse(streakinfo);
}

brmodevalidatekillstreakslot(_id_015314DA30B44470) {
  return _id_015314DA30B44470 == 1;
}

killstreakweaponfiredcontinue() {
  _id_2869A3A20D48E6AD = self.currentprimaryweapon;

  if(isDefined(_id_2869A3A20D48E6AD) && isDefined(_id_2869A3A20D48E6AD.basename) && _id_2869A3A20D48E6AD.basename == "iw9_spotter_scope_mp")
    self setweaponammoclip(_id_2869A3A20D48E6AD, self getcurrentweaponclipammo() + 1);
}

_id_258C4F40DEE8189A(_id_BDE7478B4A6080AD, _id_BDE7468B4A607E7A, radius) {
  if(isDefined(_id_BDE7478B4A6080AD) && isDefined(_id_BDE7468B4A607E7A) && isDefined(radius)) {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_x", _id_BDE7478B4A6080AD);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_y", _id_BDE7468B4A607E7A);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_size_override", radius);
  } else if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_x", level.br_circle.dangercircleent.origin[0]);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_y", level.br_circle.dangercircleent.origin[1]);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_size_override", level.br_circle.dangercircleent.origin[2]);
  } else {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_x", 0);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_y", 0);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_size_override", 0);
  }
}

_id_7DBB8165D792B06C() {
  return _id_26CCBFE3954CACF4::_id_3AE9C05025CBAC2D();
}

_id_749723C2A45A0233() {
  return _id_26CCBFE3954CACF4::_id_749723C2A45A0233();
}

_id_1BBD21D289BA8A92() {
  return _id_26CCBFE3954CACF4::_id_1BBD21D289BA8A92();
}

_id_227CA42A35B0398B(team) {
  _id_156F390A5362BC55 = _id_749723C2A45A0233();

  if(!level.teambased || !isDefined(team) || team == "all")
    return _id_156F390A5362BC55.size == 0;

  foreach(_id_B4ADDE4C68BB0F24 in _id_156F390A5362BC55) {
    if(_id_B4ADDE4C68BB0F24.team == team)
      return 0;
  }

  return 1;
}

_id_72CE5F47DA0F5661() {
  return istrue(level.usegulag) && istrue(level.gulag.shutdown);
}

_id_50434E55C7907057() {
  self endon("disconnect");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && getDvar("dvar_7611A2790A0BF7FE", "") != "dmz") {
    if(!istrue(level.br_prematchstarted)) {
      return;
    }
    _id_968BD61837A9C038 = getdvarint("dvar_3C87CCC2C15B53A4", 150);
    _id_381776CAE951DA48 = getdvarint("dvar_8B8E8245086EFDD1", 0);
    _id_07C40FA80892A721::givestartingarmor(_id_968BD61837A9C038, undefined, _id_381776CAE951DA48);
    return;
  }

  if(!istrue(level.br_prematchstarted))
    level waittill("infils_ready");

  _id_07C40FA80892A721::givestartingarmor();
}

_id_C8915AC8C8987452() {
  _id_A81ADEB0E1F89320 = level.br_pickups.maxcounts["brloot_armor_plate"];

  if(istrue(level._id_06D1D9E1B59C6F37))
    _id_A81ADEB0E1F89320 = level._id_06D1D9E1B59C6F37;

  if(istrue(self.hasplatepouch))
    _id_A81ADEB0E1F89320 = _id_A81ADEB0E1F89320 + level._id_6835A3D279520DC9;

  return _id_A81ADEB0E1F89320;
}

setplayerprematchallows() {
  _id_3B64EB40368C1450::set("prematch", "player_for_spawn_logic", 0);
  self allowmelee(0);
  self disableoffhandweapons();
  level.freefallstartcb = ::freefallstartfunc;
}

freefallstartfunc() {
  self allowmelee(1);
  self enableoffhandweapons();
}

_id_15FA5F9B3A2B7A52() {
  if(!isDefined(level._id_15FA5F9B3A2B7A52))
    level._id_15FA5F9B3A2B7A52 = 0;

  level._id_15FA5F9B3A2B7A52++;
}

_id_84E10866B5154784() {
  if(!isDefined(level._id_15FA5F9B3A2B7A52)) {
    return;
  }
  level._id_15FA5F9B3A2B7A52--;

  if(!level._id_15FA5F9B3A2B7A52)
    level._id_15FA5F9B3A2B7A52 = undefined;
}

_id_EA010C4D09365B32() {
  waittillframeend;

  while(!scripts\mp\flags::gameflagexists("prematch_done"))
    waitframe();

  scripts\mp\flags::gameflagwait("prematch_done");
  waittillframeend;

  while(istrue(level._id_15FA5F9B3A2B7A52))
    waitframe();

  level.struct_class_names = undefined;
}

_id_90011DB2FCA825A8() {
  player = self;
  _id_0774C9CA5D1D6221 = level.teamdata[player.team]["players"].size;
  _id_2D9D24F7C63AC143::_id_1DB038329EB56917(player, 8554, 1, _id_0774C9CA5D1D6221);
}

_id_56869E118720CA3B(agent, _id_6181DE250AFA5BB6) {
  if(isDefined(_id_6181DE250AFA5BB6) && _id_6181DE250AFA5BB6 scripts\cp_mp\vehicles\vehicle::isvehicle())
    _id_6181DE250AFA5BB6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(_id_6181DE250AFA5BB6);

  if(isDefined(_id_6181DE250AFA5BB6) && isPlayer(_id_6181DE250AFA5BB6)) {
    if(!isDefined(_id_6181DE250AFA5BB6._id_2B00EAA34070C8F7))
      _id_6181DE250AFA5BB6._id_2B00EAA34070C8F7 = 1;
    else
      _id_6181DE250AFA5BB6._id_2B00EAA34070C8F7 = _id_6181DE250AFA5BB6._id_2B00EAA34070C8F7 + 1;

    if(scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk")
      _id_6181DE250AFA5BB6 _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("agentKills", _id_6181DE250AFA5BB6._id_2B00EAA34070C8F7);

    _id_832C0F7147235E86 = _id_6181DE250AFA5BB6 getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "modeStats", "br_dmz", "agentKills");
    _id_832C0F7147235E86 = _id_832C0F7147235E86 + 1;
    _id_6181DE250AFA5BB6 setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "modeStats", "br_dmz", "agentKills", _id_832C0F7147235E86);
    _id_6181DE250AFA5BB6 _id_AFFE08E0629D5B85(agent);
  }
}

_id_AFFE08E0629D5B85(agent) {
  if(isagent(agent)) {
    category = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "category");
    tier = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "tier");
    _id_6AA1251FAD0A78E8 = _id_371B4C2AB5861E62::_id_E2292DCF63ECCF7A(agent, "elite");

    if(category == "elites")
      scripts\mp\utility\stats::incpersstat("bossAgentKills", 1);
    else if(isDefined(tier)) {
      if(isDefined(_id_6AA1251FAD0A78E8) && _id_6AA1251FAD0A78E8 == 1)
        scripts\mp\utility\stats::incpersstat("tier" + tier + "EliteAgentKills", 1);
      else
        scripts\mp\utility\stats::incpersstat("tier" + tier + "NormalAgentKills", 1);
    }
  }
}

_id_7AEC3C7A702AEC62() {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("tnbrMonitorLauncherAmmoRestock");
  self endon("tnbrMonitorLauncherAmmoRestock");

  while(!scripts\mp\flags::gameflagexists("prematch_done"))
    waitframe();

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    _id_1F2C0996928E3110 = getdvarfloat("dvar_2C016FD52C45F297", 5.0);
    wait(_id_1F2C0996928E3110);

    if(!scripts\mp\utility\player::_id_AD443BBCDCF37B85(self)) {
      continue;
    }
    if(_id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
      continue;
    }
    _id_DA2C96C009B81A2F = 0;
    _id_D6E9347C3618A5BB = self getweaponslistprimaries();

    foreach(weapon in _id_D6E9347C3618A5BB) {
      ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weapon);

      if(isDefined(ammotype) && ammotype == "brloot_ammo_rocket") {
        _id_DA2C96C009B81A2F = 1;
        break;
      }
    }

    if(!_id_DA2C96C009B81A2F) {
      continue;
    }
    _id_438E5FAD74EE0D44 = get_int_or_0(self.br_ammo["brloot_ammo_rocket"]);
    _id_79F8CD87B2A5EC53 = level._id_E6EA72FC5E3FCD00["brloot_ammo_rocket"];

    if(_id_438E5FAD74EE0D44 < _id_79F8CD87B2A5EC53)
      _id_724736FCF0FB6604::br_ammo_give_type(self, "brloot_ammo_rocket", 1, 0);
  }
}

_id_342438311E316357() {
  _id_6F2AB6D7F309B05D = getdvarint("dvar_4BDED611DECF41C5", 0);
  return _id_6F2AB6D7F309B05D;
}

_id_8D739EC62C568C41(_id_3474B4E818850C46) {
  if(!isDefined(self.carryflag)) {
    self.carryflag = scripts\engine\utility::ter_op(isDefined(_id_3474B4E818850C46), _id_3474B4E818850C46, "prop_king_game_flag");
    self attach(self.carryflag, "tag_stowed_back3", 1);
    self setclientomnvar("ui_flag_player_hud_icon", 1);
  }
}

_id_96D6B5E51DD4A63B() {
  if(isDefined(self.carryflag)) {
    self detach(self.carryflag, "tag_stowed_back3");
    self.carryflag = undefined;
    self setclientomnvar("ui_flag_player_hud_icon", 0);
  }
}

_id_A0394891C6CB41A5() {
  self endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "disablePlayer"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "disablePlayer")]](self, "untilMatchStart");

  scripts\mp\flags::gameflagwait("br_ready_to_jump");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("teamAssim", "enablePlayer"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("teamAssim", "enablePlayer")]](self, "untilMatchStart");
}

_id_1B1C1195E27710B9(_id_93A0836A10E99C34, _id_394466C2DDB208CB) {
  if(isDefined(_id_93A0836A10E99C34) && isDefined(_id_394466C2DDB208CB)) {
    _id_A1823E6B1CB4B46D = _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB);

    if(isDefined(_id_A1823E6B1CB4B46D) && _id_A1823E6B1CB4B46D == 9) {
      if(!isDefined(_id_93A0836A10E99C34._id_CB9581FC7FF5F394))
        _id_93A0836A10E99C34._id_CB9581FC7FF5F394 = 0;

      _id_93A0836A10E99C34._id_CB9581FC7FF5F394++;
    }

    _id_A1823E6B1CB4B46D = _id_93A0836A10E99C34 calloutmarkerping_gettype(_id_394466C2DDB208CB);

    if(_id_A1823E6B1CB4B46D == 4) {
      _id_6D7CFF43E352D995 = _id_93A0836A10E99C34 calloutmarkerping_getgscobjectiveindex(_id_394466C2DDB208CB);

      if(isDefined(level._id_DBBD13CC9AD757C1) && isDefined(level._id_DBBD13CC9AD757C1._id_807FFB67240349F5)) {
        foreach(_id_3170CA906B2241A6 in level._id_DBBD13CC9AD757C1._id_807FFB67240349F5) {
          if(!isDefined(_id_3170CA906B2241A6.objid) || _id_3170CA906B2241A6.objid != _id_6D7CFF43E352D995) {
            continue;
          }
          _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("assim_plea_successful", [_id_3170CA906B2241A6._id_15AB90A8DE6865AA]);
          _id_3170CA906B2241A6._id_15AB90A8DE6865AA scripts\mp\utility\lower_message::setlowermessageomnvar("plea_found");
        }
      }
    }
  }
}

_id_9C8DFD3B19180B63() {
  if(getdvarint("dvar_738B7382A23AC132", 0)) {
    return;
  }
  while(!scripts\mp\flags::gameflagexists("prematch_done"))
    waitframe();

  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\cp_mp\utility\script_utility::registersharedfunc("ai", "dropLootOnAgentDeath", _id_48814951E916AF89::_id_82ED67AE79913551);
  _id_48814951E916AF89::_id_5AEE5D819F7DFD1C();
}

_id_828026E0C887CD11() {
  level._id_29592A532AAEC801 = getdvarint("dvar_F1A9C0B8C6ED7AA0", 0) != 0;
  level._id_B33F1F9E5160D095 = getdvarint("dvar_840ECB3ADEBE57F7", 1) != 0;
  level._id_4FB44898C7E0006A = getdvarint("dvar_545B8C1ED10FBED0", 1) != 0;
  level._id_E442BA065DD78F24 = getdvarint("dvar_823C8CE2368209B2", 0) != 0;

  if(!level._id_29592A532AAEC801) {
    return;
  }
  while(!isDefined(level.struct_class_names))
    waitframe();

  if(level.mapname == "mp_br_mechanics") {
    _id_F13412448E4CD8A6 = spawnStruct();
    _id_F13412448E4CD8A6.origin = (3956.32, -1963.43, 0);
    _id_F13412448E4CD8A6.angles = (0, -84.4941, 0);
    _id_F13412448E4CD8A6.script_noteworthy = "april_rainbow_1";
    scripts\engine\utility::_id_1F6C1A9B7564DC61(_id_F13412448E4CD8A6);
    _id_0F3F3C199AB11B6E = spawnStruct();
    _id_0F3F3C199AB11B6E.origin = (3906.32, -1963.43, 0);
    _id_0F3F3C199AB11B6E.angles = (0, 0, 0);
    _id_0F3F3C199AB11B6E.script_noteworthy = "april_cache_1_1";
    scripts\engine\utility::_id_1F6C1A9B7564DC61(_id_0F3F3C199AB11B6E);
    _id_0F3F3C199AB11B6E = spawnStruct();
    _id_0F3F3C199AB11B6E.origin = (4006.32, -1963.43, 0);
    _id_0F3F3C199AB11B6E.angles = (0, 0, 0);
    _id_0F3F3C199AB11B6E.script_noteworthy = "april_cache_1_2";
    scripts\engine\utility::_id_1F6C1A9B7564DC61(_id_0F3F3C199AB11B6E);
    _id_0F3F3C199AB11B6E = spawnStruct();
    _id_0F3F3C199AB11B6E.origin = (3956.32, -1963.43, 0);
    _id_0F3F3C199AB11B6E.angles = (0, 0, 0);
    _id_0F3F3C199AB11B6E.script_noteworthy = "april_cache_1_3";
    scripts\engine\utility::_id_1F6C1A9B7564DC61(_id_0F3F3C199AB11B6E);
  }

  _id_1A9CEBEE5B016E80 = 0;
  _id_AC0E594AC96AA3A8 = 1;

  for(;;) {
    if(!isDefined(scripts\engine\utility::getStruct("april_rainbow_" + _id_AC0E594AC96AA3A8, "script_noteworthy"))) {
      break;
    }

    _id_1A9CEBEE5B016E80 = _id_1A9CEBEE5B016E80 + 1;
    _id_AC0E594AC96AA3A8++;
  }

  if(_id_1A9CEBEE5B016E80 == 0) {
    return;
  }
  _id_A620CB0E6444887F = randomint(_id_1A9CEBEE5B016E80) + 1;
  _id_2FFF16A950675118 = scripts\engine\utility::getStruct("april_rainbow_" + _id_A620CB0E6444887F, "script_noteworthy");
  _id_BB0CDC1D09140A25 = spawn("script_model", _id_2FFF16A950675118.origin);
  _id_BB0CDC1D09140A25.angles = _id_2FFF16A950675118.angles;
  _id_BB0CDC1D09140A25 setModel("br_april_rainbow");
  _id_BB0CDC1D09140A25 setscriptablepartstate("rainbow", "on");

  if(getdvarint("dvar_4292BF6AB9D3B43C", 1) == 1) {
    return;
  }
  _id_4EAD6B4FF3816236 = [];
  _id_AC0E5C4AC96AAA41 = 1;

  for(;;) {
    _id_3531236D1A437A5C = scripts\engine\utility::getStruct("april_cache_" + _id_A620CB0E6444887F + "_" + _id_AC0E5C4AC96AAA41, "script_noteworthy");

    if(!isDefined(_id_3531236D1A437A5C)) {
      break;
    }

    _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache_april", _id_3531236D1A437A5C.origin, _id_3531236D1A437A5C.angles);
    _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
    _id_4EAD6B4FF3816236[_id_4EAD6B4FF3816236.size] = _id_B038ED928EC17A81;
    _id_AC0E5C4AC96AAA41++;
  }

  if(_id_4EAD6B4FF3816236.size > 0) {
    foreach(_id_B038ED928EC17A81 in _id_4EAD6B4FF3816236) {
      _id_B038ED928EC17A81.contents = getscriptablelootcachecontents(_id_B038ED928EC17A81);
      _id_B038ED928EC17A81.contents[_id_B038ED928EC17A81.contents.size] = "brloot_plunder_cash_legendary_1";
    }

    _id_D84CBC950E239E80 = scripts\engine\utility::random(_id_4EAD6B4FF3816236);
    _id_D84CBC950E239E80.contents[_id_D84CBC950E239E80.contents.size] = "brloot_weapon_sn_alpha50_april";
  }

  _id_AC0E5C4AC96AAA41 = 1;

  for(;;) {
    _id_3531236D1A437A5C = scripts\engine\utility::getStruct("april_fake_cache_" + _id_A620CB0E6444887F + "_" + _id_AC0E5C4AC96AAA41, "script_noteworthy");

    if(!isDefined(_id_3531236D1A437A5C)) {
      break;
    }

    _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache_april", _id_3531236D1A437A5C.origin, _id_3531236D1A437A5C.angles);
    _id_AC0E5C4AC96AAA41++;
  }
}

_id_E83AB39A1E762EAD(itemname) {
  if(isDefined(itemname) && _id_7E52B56769FA7774::_id_36DE08EA672B354C(itemname))
    return _id_55E418C5CC946593::_id_BDD930EEE0042052();

  if(isDefined(itemname) && _id_7E52B56769FA7774::isquesttablet(itemname))
    return 0;

  return 1;
}

_id_D0F9FBF3F0F8C739(team) {
  _id_E1E65E11F75F9CBB = 0;

  if(isDefined(level._id_7B37B2193F163B9B)) {
    _id_E1E65E11F75F9CBB = scripts\mp\utility\teams::getteamdata(team, "UIBotCount");

    if(_id_E1E65E11F75F9CBB < 0)
      _id_E1E65E11F75F9CBB = 0;
  }

  return _id_E1E65E11F75F9CBB;
}

_id_467380E90C7DB5A7() {
  self endon("death_or_disconnect");

  if(isDefined(self._id_31D13939F28644D4)) {
    return;
  }
  self._id_31D13939F28644D4 = 1;

  while(!self isonground())
    waitframe();

  self._id_31D13939F28644D4 = undefined;
}

_id_3AC2A599D142369D() {
  _id_081DAB8953B9DF82 = 0;
  _id_C5C0C138D608BE6A = 0;

  if(isDefined(self.brmissionscompleted))
    _id_C5C0C138D608BE6A = _id_C5C0C138D608BE6A + self.brmissionscompleted;

  if(_id_C5C0C138D608BE6A > 15)
    _id_C5C0C138D608BE6A = 15;

  _id_081DAB8953B9DF82 = _id_C5C0C138D608BE6A;
  return _id_081DAB8953B9DF82;
}