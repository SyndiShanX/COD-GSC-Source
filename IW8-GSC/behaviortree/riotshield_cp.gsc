/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\riotshield_cp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["soldier_lw_br"])) {
    return;
  }

  aiasm\corner_cover_lean_shoot_lw_mp::asm_register();
  aiasm\gesture_lw_mp::asm_register();
  aiasm\soldier_lw_mp::asm_register();
  behaviortree\soldier_agent_lw::asm_register();
  anim.asmfuncs["soldier_lw_br"] = [];
  anim.asmfuncs["soldier_lw_br"][0] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["soldier_lw_br"][1] = &scripts\asm\soldier\script_funcs::playexposedloop;
  anim.asmfuncs["soldier_lw_br"][2] = &scripts\asm\shared\utility::choosedemeanoranimwithoverride;
  anim.asmfuncs["soldier_lw_br"][3] = &scripts\asm\soldier\script_funcs::soldier_init;
  anim.asmfuncs["soldier_lw_br"][4] = &scripts\asm\soldier\move::playanim_exit;
  anim.asmfuncs["soldier_lw_br"][5] = &scripts\asm\soldier\move::chooseanim_exitsoldier;
  anim.asmfuncs["soldier_lw_br"][6] = &scripts\asm\soldier\arrival::playanim_arrival;
  anim.asmfuncs["soldier_lw_br"][7] = &scripts\asm\soldier\arrival::chooseanim_arrival;
  anim.asmfuncs["soldier_lw_br"][8] = &scripts\asm\soldier\arrival::finisharrival;
  anim.asmfuncs["soldier_lw_br"][9] = &scripts\asm\shared\utility::loopanim;
  anim.asmfuncs["soldier_lw_br"][10] = &scripts\asm\soldier\custom::chooseanim_customidle;
  anim.asmfuncs["soldier_lw_br"][11] = &scripts\asm\shared\utility::animscriptedstartup;
  anim.asmfuncs["soldier_lw_br"][12] = &scripts\asm\shared\utility::animscriptedcleanup;
  anim.asmfuncs["soldier_lw_br"][13] = &scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["soldier_lw_br"][14] = &scripts\asm\shared\utility::animscriptedaction_terminate;
  anim.asmfuncs["soldier_lw_br"][15] = &scripts\asm\soldier\custom::shouldstartcustomidle;
  anim.asmfuncs["soldier_lw_br"][16] = &scripts\asm\soldier\custom::shouldcustomexit;
  anim.asmfuncs["soldier_lw_br"][17] = &autogenfunc_0;
  anim.asmfuncs["soldier_lw_br"][18] = &autogenfunc_1;
  anim.asmfuncs["soldier_lw_br"][19] = &scripts\asm\soldier\melee::playmeleeanim_chargetoready;
  anim.asmfuncs["soldier_lw_br"][20] = &scripts\asm\soldier\melee::playmeleeanim_vsplayer;
  anim.asmfuncs["soldier_lw_br"][21] = &scripts\asm\soldier\melee::playmeleechargeanim;
  anim.asmfuncs["soldier_lw_br"][22] = &scripts\asm\soldier\melee::playmeleeanim_synced;
  anim.asmfuncs["soldier_lw_br"][23] = &scripts\asm\soldier\melee::playmeleeanim_synced_cleanup;
  anim.asmfuncs["soldier_lw_br"][24] = &scripts\asm\soldier\melee::playmeleeanim_synced_victim;
  anim.asmfuncs["soldier_lw_br"][25] = &scripts\asm\soldier\melee::playmeleeanim_synced_survive;
  anim.asmfuncs["soldier_lw_br"][26] = &scripts\asm\soldier\melee::chooseanim_syncmelee;
  anim.asmfuncs["soldier_lw_br"][27] = &scripts\asm\soldier\melee::ischargetoreadycomplete;
  anim.asmfuncs["soldier_lw_br"][28] = &scripts\asm\soldier\melee::melee_shouldabort;
  anim.asmfuncs["soldier_lw_br"][29] = &scripts\asm\soldier\melee::melee_shouldstop;
  anim.asmfuncs["soldier_lw_br"][30] = &scripts\asm\soldier\melee::evaluatesyncedmelee;
  anim.asmfuncs["soldier_lw_br"][31] = &scripts\asm\soldier\death::playdeathanim;
  anim.asmfuncs["soldier_lw_br"][32] = &scripts\mp\trials\mp_oilrig_create_script::ref_1348E;
  anim.asmfuncs["soldier_lw_br"][33] = &scripts\asm\soldier\death::playexplosivedeathanim;
  anim.asmfuncs["soldier_lw_br"][34] = &scripts\asm\soldier\death::chooseexplosivedeathanim;
  anim.asmfuncs["soldier_lw_br"][35] = &scripts\asm\soldier\death::playdeathanim_melee_ragdolldelayed;
  anim.asmfuncs["soldier_lw_br"][36] = &scripts\asm\soldier\death::chooseshockdeathanim;
  anim.asmfuncs["soldier_lw_br"][37] = &scripts\asm\soldier\death::doshieldbashdeath;
  anim.asmfuncs["soldier_lw_br"][38] = &scripts\mp\trials\mp_oilrig_create_script::ref_1348C;
  anim.asmfuncs["soldier_lw_br"][39] = &scripts\asm\soldier\death::playbalconydeathanim;
  anim.asmfuncs["soldier_lw_br"][40] = &scripts\asm\soldier\death::choosebalconydeathanim;
  anim.asmfuncs["soldier_lw_br"][41] = &scripts\asm\soldier\death::shouldplayexplosivedeath;
  anim.asmfuncs["soldier_lw_br"][42] = &scripts\asm\soldier\death::shouldplayshockdeath;
  anim.asmfuncs["soldier_lw_br"][43] = &scripts\asm\soldier\death::shouldplayshieldbashdeath;
  anim.asmfuncs["soldier_lw_br"][44] = &scripts\asm\soldier\death::shouldplaybalconyraildeath;
  anim.asmfuncs["soldier_lw_br"][45] = &scripts\asm\soldier\death::shouldplaybalconydeath;
  anim.asmfuncs["soldier_lw_br"][46] = &scripts\asm\soldier\death::shouldplayplayermeleedeath;
  anim.asmfuncs["soldier_lw_br"][47] = &scripts\asm\soldier\pain::playpainanim;
  anim.asmfuncs["soldier_lw_br"][48] = &scripts\mp\trials\mp_trial_helicopter_port_create_a_script::ref_1348F;
  anim.asmfuncs["soldier_lw_br"][49] = &scripts\asm\soldier\pain::cleanuppainanim;
  anim.asmfuncs["soldier_lw_br"][50] = &scripts\asm\soldier\pain::choosepainanimdeafened;
  anim.asmfuncs["soldier_lw_br"][51] = &scripts\asm\soldier\pain::playpainanim_damageshieldtoground;
  anim.asmfuncs["soldier_lw_br"][52] = &scripts\asm\soldier\pain::chooseanim_damageshieldtoground;
  anim.asmfuncs["soldier_lw_br"][53] = &scripts\asm\soldier\pain::playpainanim_damageshieldtoground_cleanup;
  anim.asmfuncs["soldier_lw_br"][54] = &scripts\asm\soldier\pain::playpainanim_exposedstand;
  anim.asmfuncs["soldier_lw_br"][55] = &scripts\mp\trials\mp_trial_helicopter_port_create_a_script::ref_1348D;
  anim.asmfuncs["soldier_lw_br"][56] = &scripts\asm\soldier\pain::playanim_flashed;
  anim.asmfuncs["soldier_lw_br"][57] = &scripts\asm\soldier\pain::chooseanim_flashed;
  anim.asmfuncs["soldier_lw_br"][58] = &scripts\asm\soldier\pain::cleanupflashanim;
  anim.asmfuncs["soldier_lw_br"][59] = &scripts\asm\soldier\pain::playanim_burning;
  anim.asmfuncs["soldier_lw_br"][60] = &scripts\asm\soldier\pain::chooseanim_burning;
  anim.asmfuncs["soldier_lw_br"][61] = &scripts\asm\soldier\pain::playpainanim_faceplayer;
  anim.asmfuncs["soldier_lw_br"][62] = &scripts\asm\soldier\pain::choosepainanim_faceplayer;
  anim.asmfuncs["soldier_lw_br"][63] = &scripts\asm\shared\utility::isspecialpain;
  anim.asmfuncs["soldier_lw_br"][64] = &scripts\asm\shared\utility::isdeafened;
  anim.asmfuncs["soldier_lw_br"][65] = &scripts\asm\soldier\pain::shoulddamageshielddowntoground;
  anim.asmfuncs["soldier_lw_br"][66] = &scripts\asm\soldier\arrival::transition_arrivalisstopped;
  anim.asmfuncs["soldier_lw_br"][67] = &scripts\asm\shared\utility::transition_isflashed;
  anim.asmfuncs["soldier_lw_br"][68] = &scripts\asm\shared\utility::transition_isburning;
  anim.asmfuncs["soldier_lw_br"][69] = &scripts\asm\soldier\pain::shouldpainfaceplayer;
  anim.asmfuncs["soldier_lw_br"][70] = &scripts\asm\soldier\pain::shouldpainrunfaceplayer;
  anim.asmfuncs["soldier_lw_br"][71] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::ref_13488;
  anim.asmfuncs["soldier_lw_br"][72] = &scripts\asm\soldier\move::terminateexitstartanim;
  anim.asmfuncs["soldier_lw_br"][73] = &scripts\asm\soldier\move::playmoveloop_codeblend;
  anim.asmfuncs["soldier_lw_br"][74] = &scripts\asm\soldier\move::playsharpturnanim;
  anim.asmfuncs["soldier_lw_br"][75] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::ref_13490;
  anim.asmfuncs["soldier_lw_br"][76] = &scripts\asm\soldier\move::sharpturn_terminate;
  anim.asmfuncs["soldier_lw_br"][77] = &scripts\asm\soldier\move::playmovestrafeloop_codeblend;
  anim.asmfuncs["soldier_lw_br"][78] = &scripts\asm\soldier\move::strafeloop_codeblend_cleanup;
  anim.asmfuncs["soldier_lw_br"][79] = &scripts\asm\shared\utility::calcarrivaltype;
  anim.asmfuncs["soldier_lw_br"][80] = &scripts\asm\soldier\move::playreloadwhilemoving;
  anim.asmfuncs["soldier_lw_br"][81] = &scripts\asm\soldier\move::choosereloadwhilemoving;
  anim.asmfuncs["soldier_lw_br"][82] = &scripts\asm\soldier\move::terminatereloadwhilemoving;
  anim.asmfuncs["soldier_lw_br"][83] = &scripts\asm\soldier\move::playanim_strafeaimchange;
  anim.asmfuncs["soldier_lw_br"][84] = &scripts\asm\soldier\move::chooseanim_strafeaimchange;
  anim.asmfuncs["soldier_lw_br"][85] = &scripts\asm\soldier\move::strafeaimchange_cleanup;
  anim.asmfuncs["soldier_lw_br"][86] = &scripts\asm\soldier\move::playanim_strafearrival;
  anim.asmfuncs["soldier_lw_br"][87] = &scripts\asm\soldier\move::chooseanim_strafearrival;
  anim.asmfuncs["soldier_lw_br"][88] = &scripts\asm\soldier\move::playanim_strafereverse;
  anim.asmfuncs["soldier_lw_br"][89] = &scripts\asm\soldier\move::ref_13911;
  anim.asmfuncs["soldier_lw_br"][90] = &scripts\asm\soldier\move::playanim_strafestart;
  anim.asmfuncs["soldier_lw_br"][91] = &scripts\asm\soldier\move::playanim_strafearrive;
  anim.asmfuncs["soldier_lw_br"][92] = &scripts\asm\soldier\move::chooseanim_strafearrive;
  anim.asmfuncs["soldier_lw_br"][93] = &scripts\asm\soldier\move::playanim_strafearrive_cleanup;
  anim.asmfuncs["soldier_lw_br"][94] = &scripts\asm\soldier\arrival::playanim_zeroarrival;
  anim.asmfuncs["soldier_lw_br"][95] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::ref_1348B;
  anim.asmfuncs["soldier_lw_br"][96] = &scripts\asm\soldier\arrival::playanim_zeroarrival_cleanup;
  anim.asmfuncs["soldier_lw_br"][97] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::ref_134B8;
  anim.asmfuncs["soldier_lw_br"][98] = &scripts\asm\soldier\arrival::shouldconsiderarrival;
  anim.asmfuncs["soldier_lw_br"][99] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::ref_134BC;
  anim.asmfuncs["soldier_lw_br"][100] = &scripts\asm\soldier\move::shoulddosharpturn;
  anim.asmfuncs["soldier_lw_br"][101] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::ref_134BD;
  anim.asmfuncs["soldier_lw_br"][102] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::ref_134BB;
  anim.asmfuncs["soldier_lw_br"][103] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::soldier_br_isalert;
  anim.asmfuncs["soldier_lw_br"][104] = &scripts\asm\soldier\arrival::shouldstartarrivalpassthroughswitch;
  anim.asmfuncs["soldier_lw_br"][105] = &scripts\asm\soldier\script_funcs::reload;
  anim.asmfuncs["soldier_lw_br"][106] = &scripts\asm\soldier\script_funcs::reload_cleanup;
  anim.asmfuncs["soldier_lw_br"][107] = &scripts\asm\soldier\script_funcs::playanim_weaponswitch;
  anim.asmfuncs["soldier_lw_br"][108] = &scripts\asm\soldier\script_funcs::terminate_weaponswitch;
  anim.asmfuncs["soldier_lw_br"][109] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::soldier_br_playturnanim;
  anim.asmfuncs["soldier_lw_br"][110] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::soldier_br_chooseturnanim;
  anim.asmfuncs["soldier_lw_br"][111] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::soldier_br_playturnanim_cleanup;
  anim.asmfuncs["soldier_lw_br"][112] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::soldier_br_chooseexposedidle;
  anim.asmfuncs["soldier_lw_br"][113] = &scripts\asm\soldier\script_funcs::terminateidle;
  anim.asmfuncs["soldier_lw_br"][114] = &scripts\asm\soldier\script_funcs::chooseanim_playerpushed;
  anim.asmfuncs["soldier_lw_br"][115] = &scripts\asm\soldier\mp\script_funcs::forwardpushevent;
  anim.asmfuncs["soldier_lw_br"][116] = &scripts\asm\soldier\script_funcs::playexposedidleaimdownloop;
  anim.asmfuncs["soldier_lw_br"][117] = &scripts\asm\shared\utility::chooseanimidle;
  anim.asmfuncs["soldier_lw_br"][118] = &scripts\asm\soldier\script_funcs::terminateexposedidleaimdown;
  anim.asmfuncs["soldier_lw_br"][119] = &scripts\asm\soldier\script_funcs::terminate_casualkiller;
  anim.asmfuncs["soldier_lw_br"][120] = &scripts\asm\soldier\script_funcs::chooseanim_dodge;
  anim.asmfuncs["soldier_lw_br"][121] = &scripts\mp\trials\mp_trl_create_a_script_race_euphrates::ref_134AC;
  anim.asmfuncs["soldier_lw_br"][122] = &scripts\asm\soldier\throwgrenade::chooseanim_throwgrenade;
  anim.asmfuncs["soldier_lw_br"][123] = &scripts\asm\soldier\throwgrenade::playcoveranim_throwgrenade_cleanup;
  anim.asmfuncs["soldier_lw_br"][124] = &scripts\asm\soldier\script_funcs::playturnanim;
  anim.asmfuncs["soldier_lw_br"][125] = &scripts\asm\soldier\script_funcs::choosecrouchturnanim;
  anim.asmfuncs["soldier_lw_br"][126] = &scripts\asm\soldier\script_funcs::playturnanim_cleanup;
  anim.asmfuncs["soldier_lw_br"][127] = &scripts\asm\soldier\script_funcs::playexposedcrouchloop;
  anim.asmfuncs["soldier_lw_br"][128] = &scripts\asm\soldier\script_funcs::terminateexposedcrouch;
  anim.asmfuncs["soldier_lw_br"][129] = &scripts\mp\trials\mp_t_reflex_create_script_quadrace::ref_134A8;
  anim.asmfuncs["soldier_lw_br"][130] = &scripts\asm\soldier\mp\script_funcs::shouldplaypushedanim;
  anim.asmfuncs["soldier_lw_br"][131] = &scripts\asm\soldier\script_funcs::shouldleavecasualkiller;
  anim.asmfuncs["soldier_lw_br"][132] = &scripts\asm\soldier\script_funcs::shouldleavecasualkillerimmediately;
  anim.asmfuncs["soldier_lw_br"][133] = &scripts\asm\soldier\script_funcs::shoulddodge;
  anim.asmfuncs["soldier_lw_br"][134] = &scripts\asm\soldier\throwgrenade::shouldthrowgrenade;
  anim.asmfuncs["soldier_lw_br"][135] = &scripts\asm\soldier\script_funcs::needtoturnformelee;
  anim.asmfuncs["soldier_lw_br"][136] = &scripts\asm\soldier\smartobject::smartobjectcomplete;
  anim.asmfuncs["soldier_lw_br"][137] = &scripts\asm\soldier\smartobject::playsmartobjectpainanim;
  anim.asmfuncs["soldier_lw_br"][138] = &scripts\asm\soldier\smartobject::smartobject_notetrackhandler;
  anim.asmfuncs["soldier_lw_br"][139] = &scripts\asm\soldier\smartobject::choosesmartobjectpainanim;
  anim.asmfuncs["soldier_lw_br"][140] = &scripts\asm\soldier\smartobject::playsmartobjectdeathanim;
  anim.asmfuncs["soldier_lw_br"][141] = &scripts\asm\soldier\smartobject::choosesmartobjectdeathanim;
  anim.asmfuncs["soldier_lw_br"][142] = &scripts\asm\soldier\smartobject::playsmartobjectexit;
  anim.asmfuncs["soldier_lw_br"][143] = &scripts\asm\soldier\smartobject::choosesmartobjectexitanim;
  anim.asmfuncs["soldier_lw_br"][144] = &scripts\asm\soldier\smartobject::playsmartobjectanim;
  anim.asmfuncs["soldier_lw_br"][145] = &scripts\asm\soldier\smartobject::choosesmartobjectanim;
  anim.asmfuncs["soldier_lw_br"][146] = &scripts\asm\soldier\smartobject::playsmartobjectreactanim;
  anim.asmfuncs["soldier_lw_br"][147] = &scripts\asm\soldier\smartobject::choosesmartobjectreactanim;
  anim.asmfuncs["soldier_lw_br"][148] = &scripts\asm\soldier\patrol::patrolreact_terminate;
  anim.asmfuncs["soldier_lw_br"][149] = &scripts\asm\soldier\smartobject::smartobjectinit;
  anim.asmfuncs["soldier_lw_br"][150] = &scripts\asm\soldier\smartobject::playsmartobjectintro;
  anim.asmfuncs["soldier_lw_br"][151] = &scripts\asm\soldier\smartobject::playsmartobjectlogic;
  anim.asmfuncs["soldier_lw_br"][152] = &scripts\asm\soldier\smartobject::smartobjecthasintro;
  anim.asmfuncs["soldier_lw_br"][153] = &scripts\asm\soldier\smartobject::smartobjecthasoutro;
  anim.asmfuncs["soldier_lw_br"][154] = &scripts\asm\soldier\smartobject::smartobjecthaslogic;
  anim.asmfuncs["soldier_lw_br"][155] = &scripts\asm\soldier\smartobject::shouldsmartobjectreact;
  anim.asmfuncs["soldier_lw_br"][156] = &scripts\asm\soldier\smartobject::smartobjecthasexits;
  anim.asmfuncs["soldier_lw_br"][157] = &scripts\asm\soldier\smartobject::shouldplaysmartobjectpain;
  anim.asmfuncs["soldier_lw_br"][158] = &scripts\asm\soldier\smartobject::shouldplaysmartobjectdeath;
  anim.asmfuncs["soldier_lw_br"][159] = &scripts\asm\soldier\smartobject::shouldplaysmartobjectreact;
  anim.asmfuncs["soldier_lw_br"][160] = &abilitykey::ref_11FE3;
  anim.asmfuncs["soldier_lw_br"][161] = &scripts\asm\soldier\cover::coverreload;
  anim.asmfuncs["soldier_lw_br"][162] = &scripts\asm\soldier\cover::terminatecoverreload;
  anim.asmfuncs["soldier_lw_br"][163] = &scripts\asm\soldier\cover::playexposedcoveranim;
  anim.asmfuncs["soldier_lw_br"][164] = &scripts\asm\soldier\cover::clearcoveranim;
  anim.asmfuncs["soldier_lw_br"][165] = &scripts\asm\soldier\cover::playcoveranim;
  anim.asmfuncs["soldier_lw_br"][166] = &scripts\asm\soldier\cover::playcoveranimloop;
  anim.asmfuncs["soldier_lw_br"][167] = &scripts\asm\soldier\throwgrenade::playcoveranim_throwgrenade;
  anim.asmfuncs["soldier_lw_br"][168] = &scripts\asm\soldier\cover::playtransitiontoexposedanim;
  anim.asmfuncs["soldier_lw_br"][169] = &scripts\asm\soldier\cover::choosetransitiontoexposedanim;
  anim.asmfuncs["soldier_lw_br"][170] = &scripts\asm\soldier\script_funcs::terminate_transitiontoexposedanim;
  anim.asmfuncs["soldier_lw_br"][171] = &scripts\asm\soldier\cover::playtransitiontocoverhide;
  anim.asmfuncs["soldier_lw_br"][172] = &scripts\asm\soldier\cover::cleanup_transitiontocoverhide;
  anim.asmfuncs["soldier_lw_br"][173] = &scripts\asm\soldier\cover::chooseanim_tocoverhide;
  anim.asmfuncs["soldier_lw_br"][174] = &scripts\asm\soldier\cover::finishcovermultichangerequest;
  anim.asmfuncs["soldier_lw_br"][175] = &scripts\asm\soldier\throwgrenade::throwgrenade_shouldabort;
  anim.asmfuncs["soldier_lw_br"][176] = &scripts\asm\soldier\cover::iscovermultiswitchrequested;
  anim.asmfuncs["soldier_lw_br"][177] = &scripts\asm\soldier\cover::checkcovermultichangerequest;
  anim.asmfuncs["soldier_lw_br"][178] = &scripts\asm\traverse::playtraverseanim_scaled;
  anim.asmfuncs["soldier_lw_br"][179] = &scripts\asm\soldier\traverse::playtraverseanim_external;
  anim.asmfuncs["soldier_lw_br"][180] = &scripts\asm\soldier\traverse::choosetraverseanim_external;
  anim.asmfuncs["soldier_lw_br"][181] = &scripts\asm\traverse::traverse_cleanup;
  anim.asmfuncs["soldier_lw_br"][182] = &scripts\asm\soldier\traverse::playtraverseanim_ladder;
  anim.asmfuncs["soldier_lw_br"][183] = &scripts\asm\soldier\traverse::terminate_ladder;
  anim.asmfuncs["soldier_lw_br"][184] = &scripts\asm\soldier\traverse::playtraverseanim;
  anim.asmfuncs["soldier_lw_br"][185] = &scripts\mp\trials\mp_trl_boneyard_gw_race::ref_134AE;
  anim.asmfuncs["soldier_lw_br"][186] = &scripts\mp\trials\mp_trl_boneyard_gw_race::ref_134BF;
  anim.asmfuncs["soldier_lw_br"][187] = &scripts\asm\soldier_lw_br\parachutespawn::soldier_br_parachute_transitionstate;
  anim.asmfuncs["soldier_lw_br"][188] = &scripts\asm\soldier_lw_br\parachutespawn::soldier_br_spawnparatrooper;
  anim.asmfuncs["soldier_lw_br"][189] = &scripts\asm\soldier\long_death::choosecrawllongdeathanims;
  anim.asmfuncs["soldier_lw_br"][190] = &scripts\asm\soldier\long_death::choosecoverlongdeathanims;
  anim.asmfuncs["soldier_lw_br"][191] = &scripts\asm\soldier\long_death::chooseexposedlongdeathanims;
  anim.asmfuncs["soldier_lw_br"][192] = &scripts\asm\soldier\long_death::playlongdeathintro;
  anim.asmfuncs["soldier_lw_br"][193] = &scripts\asm\soldier\long_death::chooseanimlongdeath;
  anim.asmfuncs["soldier_lw_br"][194] = &scripts\asm\soldier\long_death::playlongdeathidle;
  anim.asmfuncs["soldier_lw_br"][195] = &scripts\asm\soldier\long_death::longdeathfinal;
  anim.asmfuncs["soldier_lw_br"][196] = &scripts\asm\soldier\long_death::playlongdeathfinaldeath;
  anim.asmfuncs["soldier_lw_br"][197] = &scripts\asm\soldier\long_death::chooselongdeathdeathanim;
  anim.asmfuncs["soldier_lw_br"][198] = &scripts\asm\soldier\long_death::shoulddocoverlongdeath;
  anim.asmfuncs["soldier_lw_br"][199] = &scripts\asm\soldier\long_death::canplaychosenlongdeath;
  anim.asmfuncs["soldier_lw_br"][200] = &scripts\asm\soldier\long_death::shoulddocrawllongdeath;
  anim.asmfuncs["soldier_lw_br"][201] = &scripts\asm\soldier\long_death::shoulddoexposedlongdeath;
  anim.asmfuncs["soldier_lw_br"][202] = &scripts\asm\soldier\long_death::shouldfinishlongdeath;
  anim.asmfuncs["soldier_lw_br"][203] = &scripts\asm\soldier\custom::shouldstopcustomidle;
  anim.asmfuncs["soldier_lw_br"][204] = &scripts\asm\shared\utility::movetypeisnotcasual;
  anim.asmfuncs["soldier_lw_br"][205] = &scripts\asm\soldier\arrival::shouldstartarrivalpassthroughswitchcustom;
  anim.asmfuncs["soldier_lw_br"][206] = &autogenfunc_2;
  anim.asmfuncs["soldier_lw_br"][207] = &scripts\asm\shared\utility::shouldleaveanimscripted;
  anim.asmfuncs["soldier_lw_br"][208] = &scripts\asm\soldier\smartobject::shouldplaysmartobjectanim;
  anim.asmfuncs["soldier_lw_br"][209] = &scripts\asm\soldier\script_funcs::needtoturntofacepath;
  anim.asmfuncs["soldier_lw_br"][210] = &scripts\asm\soldier\smartobject::smartobject_shouldexitintomove;
  anim.asmfuncs["soldier_lw_br"][211] = &scripts\asm\soldier\smartobject::needtoturntosmartobject;
  anim.asmfuncs["soldier_lw_br"][212] = &scripts\asm\shared\utility::scriptedcoverposerequestisdefined;
  anim.asmfuncs["soldier_lw_br"][213] = &scripts\asm\shared\utility::scriptedcoverposerequestis;
  anim.asmfuncs["soldier_lw_br"][214] = &scripts\asm\soldier\pain::shouldpainruntostrafereverse;
  anim.asmfuncs["soldier_lw_br"][215] = &scripts\asm\soldier\script_funcs::currentsnaptonodeis;
  anim.asmfuncs["soldier_lw_br"][216] = &scripts\mp\trials\mp_trl_boneyard_gw_race::ref_134A1;
  anim.asmfuncs["soldier_lw_br"][217] = &scripts\asm\soldier_lw_br\parachutespawn::soldier_br_shouldparachutespawn;
  anim.asmfuncs["soldier_lw_br"][218] = &scripts\asm\soldier\long_death::shoulddoanylongdeath;
  anim.asmfuncs["soldier_lw_br"][219] = &autogenfunc_3;
  anim.asmfuncs["soldier_lw_br"][220] = &autogenfunc_4;
  anim.asmfuncs["soldier_lw_br"][221] = &autogenfunc_5;
}

function autogenfunc_0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isanimScripted() && isDefined(self.asm.customdata.idlestate);
}

function autogenfunc_1(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isanimScripted() && isDefined(self.asm.customdata.exitstate);
}

function autogenfunc_2(var_0, var_1, var_2, var_3) {
  return !isDefined(scripts\asm\asm_bb::bb_getmeleetarget());
}

function autogenfunc_3(var_0) {
  scripts\asm\track::track(var_0);
}

function autogenfunc_4(var_0) {
  scripts\asm\juggernaut\juggernaut::juggernaut(var_0);
}

function autogenfunc_5(var_0) {
  scripts\asm\gesture::gesture(var_0);
}