/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\soldier_cp_mp.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["soldier_cp"])) {
    return;
  }
  anim.asmfuncs["soldier_cp"] = [];
  anim.asmfuncs["soldier_cp"][0] = scripts\asm\shared\utility::choosedemeanoranimwithoverride;
  anim.asmfuncs["soldier_cp"][1] = scripts\asm\soldier\script_funcs::soldier_init;
  anim.asmfuncs["soldier_cp"][2] = scripts\asm\soldier\grenade_response::playgrenadereturnthrowanim;
  anim.asmfuncs["soldier_cp"][3] = scripts\asm\soldier\grenade_response::choosegrenadereturnthrowanim;
  anim.asmfuncs["soldier_cp"][4] = scripts\asm\soldier\grenade_response::terminategrenadereturnthrowanim;
  anim.asmfuncs["soldier_cp"][5] = scripts\asm\soldier\grenade_response::playgrenadeavoidanim;
  anim.asmfuncs["soldier_cp"][6] = scripts\asm\soldier\grenade_response::grenadeavoid_terminate;
  anim.asmfuncs["soldier_cp"][7] = scripts\asm\soldier\grenade_response::shouldgrenadedive;
  anim.asmfuncs["soldier_cp"][8] = scripts\asm\shared\utility::loopanim;
  anim.asmfuncs["soldier_cp"][9] = scripts\asm\soldier\custom::chooseanim_customidle;
  anim.asmfuncs["soldier_cp"][10] = scripts\asm\shared\utility::animscriptedstartup;
  anim.asmfuncs["soldier_cp"][11] = scripts\asm\shared\utility::animscriptedcleanup;
  anim.asmfuncs["soldier_cp"][12] = scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["soldier_cp"][13] = scripts\asm\shared\utility::animscriptedaction_terminate;
  anim.asmfuncs["soldier_cp"][14] = scripts\asm\soldier\custom::shouldstartcustomidle;
  anim.asmfuncs["soldier_cp"][15] = scripts\asm\soldier\custom::shouldcustomexit;
  anim.asmfuncs["soldier_cp"][16] = scripts\asm\shared\utility::playmoveloopcasual;
  anim.asmfuncs["soldier_cp"][17] = scripts\asm\shared\utility::playmoveloopcasualcleanup;
  anim.asmfuncs["soldier_cp"][18] = scripts\asm\soldier\move::movewalkandtalk;
  anim.asmfuncs["soldier_cp"][19] = scripts\asm\soldier\move::choosewalkandtalkanims;
  anim.asmfuncs["soldier_cp"][20] = scripts\asm\soldier\move::chooseanim_stairs;
  anim.asmfuncs["soldier_cp"][21] = scripts\asm\soldier\move::chooseanim_stairs_rise_run;
  anim.asmfuncs["soldier_cp"][22] = ::autogenfunc_0;
  anim.asmfuncs["soldier_cp"][23] = ::autogenfunc_1;
  anim.asmfuncs["soldier_cp"][24] = scripts\asm\soldier\cover::terminatecoverreload;
  anim.asmfuncs["soldier_cp"][25] = scripts\asm\soldier\throwgrenade::playcoveranim_throwgrenade;
  anim.asmfuncs["soldier_cp"][26] = scripts\asm\soldier\throwgrenade::playcoveranim_throwgrenade_cleanup;
  anim.asmfuncs["soldier_cp"][27] = scripts\asm\soldier\cover::playcoveranim_droprpg;
  anim.asmfuncs["soldier_cp"][28] = scripts\asm\soldier\script_funcs::playanim_weaponswitch;
  anim.asmfuncs["soldier_cp"][29] = scripts\asm\soldier\script_funcs::terminate_weaponswitch;
  anim.asmfuncs["soldier_cp"][30] = scripts\asm\soldier\cover::finishcovermultichangerequest;
  anim.asmfuncs["soldier_cp"][31] = scripts\asm\soldier\cover::checkcovermultichangerequest;
  anim.asmfuncs["soldier_cp"][32] = scripts\asm\soldier\melee::playmeleeanim_chargetoready;
  anim.asmfuncs["soldier_cp"][33] = scripts\asm\soldier\melee::playmeleeanim_vsplayer;
  anim.asmfuncs["soldier_cp"][34] = scripts\asm\soldier\melee::playmeleechargeanim;
  anim.asmfuncs["soldier_cp"][35] = scripts\asm\soldier\melee::playmeleeanim_synced;
  anim.asmfuncs["soldier_cp"][36] = scripts\asm\soldier\melee::playmeleeanim_synced_cleanup;
  anim.asmfuncs["soldier_cp"][37] = scripts\asm\soldier\melee::playmeleeanim_synced_victim;
  anim.asmfuncs["soldier_cp"][38] = scripts\asm\soldier\melee::playmeleeanim_synced_survive;
  anim.asmfuncs["soldier_cp"][39] = scripts\asm\soldier\melee::chooseanim_syncmelee;
  anim.asmfuncs["soldier_cp"][40] = scripts\asm\soldier\melee::ischargetoreadycomplete;
  anim.asmfuncs["soldier_cp"][41] = scripts\asm\soldier\melee::melee_shouldabort;
  anim.asmfuncs["soldier_cp"][42] = scripts\asm\soldier\melee::melee_shouldstop;
  anim.asmfuncs["soldier_cp"][43] = scripts\asm\soldier\melee::evaluatesyncedmelee;
  anim.asmfuncs["soldier_cp"][44] = scripts\asm\soldier\death::playdeathanim;
  anim.asmfuncs["soldier_cp"][45] = scripts\asm\soldier\death::choosecrouchingdeathanim;
  anim.asmfuncs["soldier_cp"][46] = scripts\asm\soldier\death::choosemovingdeathanim;
  anim.asmfuncs["soldier_cp"][47] = scripts\asm\soldier\death::choosecoverdeathanim;
  anim.asmfuncs["soldier_cp"][48] = scripts\asm\soldier\death::playexplosivedeathanim;
  anim.asmfuncs["soldier_cp"][49] = scripts\asm\soldier\death::chooseexplosivedeathanim;
  anim.asmfuncs["soldier_cp"][50] = scripts\asm\soldier\death::playdeathanim_melee_ragdolldelayed;
  anim.asmfuncs["soldier_cp"][51] = scripts\asm\soldier\death::chooseshockdeathanim;
  anim.asmfuncs["soldier_cp"][52] = scripts\asm\soldier\death::doshieldbashdeath;
  anim.asmfuncs["soldier_cp"][53] = scripts\asm\soldier\death::choosedirectionaldeathanim;
  anim.asmfuncs["soldier_cp"][54] = scripts\asm\soldier\death::choosedirectionalcrouchdeathanim;
  anim.asmfuncs["soldier_cp"][55] = scripts\asm\soldier\death::choosedirectionallargepaindeathanim;
  anim.asmfuncs["soldier_cp"][56] = scripts\asm\soldier\death::playbalconydeathanim;
  anim.asmfuncs["soldier_cp"][57] = scripts\asm\soldier\death::choosebalconydeathanim;
  anim.asmfuncs["soldier_cp"][58] = scripts\asm\soldier\ground_turret::playdeathanim_groundturret;
  anim.asmfuncs["soldier_cp"][59] = scripts\asm\soldier\death::shouldplayexplosivedeath;
  anim.asmfuncs["soldier_cp"][60] = scripts\asm\soldier\death::shouldplayshockdeath;
  anim.asmfuncs["soldier_cp"][61] = scripts\asm\soldier\death::shouldplayshieldbashdeath;
  anim.asmfuncs["soldier_cp"][62] = scripts\asm\soldier\death::shouldplaybalconyraildeath;
  anim.asmfuncs["soldier_cp"][63] = scripts\asm\soldier\death::shouldplaybalconydeath;
  anim.asmfuncs["soldier_cp"][64] = scripts\asm\soldier\death::shouldplayplayermeleedeath;
  anim.asmfuncs["soldier_cp"][65] = scripts\asm\soldier\pain::playpainanim;
  anim.asmfuncs["soldier_cp"][66] = scripts\asm\soldier\pain::cleanuppainanim;
  anim.asmfuncs["soldier_cp"][67] = scripts\asm\soldier\pain::playcoverpainanim;
  anim.asmfuncs["soldier_cp"][68] = scripts\asm\soldier\pain::choosepainanim_covercorner;
  anim.asmfuncs["soldier_cp"][69] = scripts\asm\soldier\pain::playpainanimlmg;
  anim.asmfuncs["soldier_cp"][70] = scripts\asm\soldier\pain::playpainanim_exposedstand;
  anim.asmfuncs["soldier_cp"][71] = scripts\asm\soldier\pain::playpainanim_exposedcrouch;
  anim.asmfuncs["soldier_cp"][72] = scripts\asm\soldier\pain::playpainanim_exposedcrouchtransition;
  anim.asmfuncs["soldier_cp"][73] = scripts\asm\soldier\pain::choosedirectionalpainanim_transition;
  anim.asmfuncs["soldier_cp"][74] = scripts\asm\soldier\pain::clearpainturnrate;
  anim.asmfuncs["soldier_cp"][75] = scripts\asm\soldier\pain::playanim_flashed;
  anim.asmfuncs["soldier_cp"][76] = scripts\asm\soldier\pain::cleanupflashanim;
  anim.asmfuncs["soldier_cp"][77] = scripts\asm\soldier\pain::playanim_burning;
  anim.asmfuncs["soldier_cp"][78] = scripts\asm\soldier\pain::playpainanim_faceplayer;
  anim.asmfuncs["soldier_cp"][79] = scripts\asm\shared\utility::transition_isflashed;
  anim.asmfuncs["soldier_cp"][80] = scripts\asm\shared\utility::transition_isburning;
  anim.asmfuncs["soldier_cp"][81] = scripts\asm\soldier\patrol_idle::patrol_idle_init;
  anim.asmfuncs["soldier_cp"][82] = scripts\asm\soldier\patrol_idle::patrol_smoking_cleanup;
  anim.asmfuncs["soldier_cp"][83] = scripts\asm\soldier\patrol_idle::patrol_playidleintro;
  anim.asmfuncs["soldier_cp"][84] = scripts\asm\soldier\patrol_idle::patrol_notehandler_smoking;
  anim.asmfuncs["soldier_cp"][85] = scripts\asm\soldier\patrol_idle::patrol_playidleloop;
  anim.asmfuncs["soldier_cp"][86] = scripts\asm\soldier\patrol_idle::patrol_playidlereact;
  anim.asmfuncs["soldier_cp"][87] = scripts\asm\soldier\patrol_idle::patrol_chooseidlereact;
  anim.asmfuncs["soldier_cp"][88] = scripts\asm\soldier\patrol_idle::patrol_playidleend;
  anim.asmfuncs["soldier_cp"][89] = scripts\asm\soldier\patrol_idle::patrol_playdeathanim_sitting;
  anim.asmfuncs["soldier_cp"][90] = scripts\asm\soldier\patrol_idle::patrol_idle_cleanup;
  anim.asmfuncs["soldier_cp"][91] = scripts\asm\soldier\patrol_idle::patrol_notehandler_cellphone;
  anim.asmfuncs["soldier_cp"][92] = scripts\asm\soldier\patrol_idle::patrol_prop_cleanup;
  anim.asmfuncs["soldier_cp"][93] = scripts\asm\soldier\patrol_idle::patrol_notehandler_drinking;
  anim.asmfuncs["soldier_cp"][94] = scripts\asm\soldier\patrol_idle::patrol_playidlesittingreact;
  anim.asmfuncs["soldier_cp"][95] = scripts\asm\soldier\patrol_idle::patrol_playidlesittingloop_sleeping;
  anim.asmfuncs["soldier_cp"][96] = scripts\asm\soldier\patrol_idle::patrol_playidlesittingloop_sleeping_cleanup;
  anim.asmfuncs["soldier_cp"][97] = scripts\asm\soldier\patrol_idle::patrol_playidlesittingloop_cellphone;
  anim.asmfuncs["soldier_cp"][98] = scripts\asm\soldier\patrol_idle::patrol_playidlesittingloop_prop_cleanup;
  anim.asmfuncs["soldier_cp"][99] = scripts\asm\soldier\patrol_idle::patrol_playidlesittingloop_laptop;
  anim.asmfuncs["soldier_cp"][100] = scripts\asm\soldier\patrol_idle::patrol_playidlesittingloop_cleanup;
  anim.asmfuncs["soldier_cp"][101] = scripts\asm\soldier\patrol_idle::patrol_playidlesittingloop_pistolclean;
  anim.asmfuncs["soldier_cp"][102] = scripts\asm\soldier\patrol_idle::patrol_chooseanim_custom;
  anim.asmfuncs["soldier_cp"][103] = scripts\asm\soldier\patrol::patrol_playanim_idlecurious;
  anim.asmfuncs["soldier_cp"][104] = scripts\asm\soldier\patrol::flashlightnotehandler;
  anim.asmfuncs["soldier_cp"][105] = scripts\asm\shared\utility::playanimwithdooropen;
  anim.asmfuncs["soldier_cp"][106] = scripts\asm\soldier\patrol_idle::patrol_idle_custom_init;
  anim.asmfuncs["soldier_cp"][107] = scripts\asm\soldier\patrol_idle::patrol_idle_custom_cleanup;
  anim.asmfuncs["soldier_cp"][108] = scripts\asm\soldier\patrol_idle::patrol_playidleintro_custom;
  anim.asmfuncs["soldier_cp"][109] = scripts\asm\soldier\patrol_idle::patrol_playidle_custom_terminate;
  anim.asmfuncs["soldier_cp"][110] = scripts\asm\soldier\patrol_idle::patrol_playidleloop_custom;
  anim.asmfuncs["soldier_cp"][111] = scripts\asm\soldier\patrol_idle::patrol_playidlereact_custom;
  anim.asmfuncs["soldier_cp"][112] = scripts\asm\soldier\patrol_idle::patrol_playidleend_custom;
  anim.asmfuncs["soldier_cp"][113] = scripts\asm\soldier\patrol::chooseanim_patrolreactlookaround;
  anim.asmfuncs["soldier_cp"][114] = scripts\asm\soldier\patrol::patrol_magicflashlightdetach;
  anim.asmfuncs["soldier_cp"][115] = scripts\asm\soldier\patrol::patrol_magicflashlighton;
  anim.asmfuncs["soldier_cp"][116] = scripts\asm\soldier\patrol_idle::patrol_idle_istype;
  anim.asmfuncs["soldier_cp"][117] = scripts\asm\soldier\patrol_idle::patrol_hascustomanim;
  anim.asmfuncs["soldier_cp"][118] = scripts\asm\soldier\patrol_idle::patrol_iscustomanimdefaultvalue;
  anim.asmfuncs["soldier_cp"][119] = ::autogenfunc_2;
  anim.asmfuncs["soldier_cp"][120] = ::autogenfunc_3;
  anim.asmfuncs["soldier_cp"][121] = scripts\asm\soldier\long_death::playstumblingpaintransition;
  anim.asmfuncs["soldier_cp"][122] = scripts\asm\soldier\long_death::playstumblingwander;
  anim.asmfuncs["soldier_cp"][123] = scripts\asm\soldier\long_death::playcrawlingpaintransition;
  anim.asmfuncs["soldier_cp"][124] = scripts\asm\soldier\long_death::playdyingcrawl;
  anim.asmfuncs["soldier_cp"][125] = scripts\asm\soldier\long_death::playcrawlflipover;
  anim.asmfuncs["soldier_cp"][126] = scripts\asm\soldier\long_death::playdyingcrawlback;
  anim.asmfuncs["soldier_cp"][127] = scripts\asm\soldier\long_death::playdyingbackidle;
  anim.asmfuncs["soldier_cp"][128] = scripts\asm\soldier\long_death::choosedyingbackidle;
  anim.asmfuncs["soldier_cp"][129] = scripts\asm\soldier\long_death::playdyingbackshoot;
  anim.asmfuncs["soldier_cp"][130] = scripts\asm\soldier\long_death::playlongdeathintro;
  anim.asmfuncs["soldier_cp"][131] = scripts\asm\soldier\long_death::playlongdeathmercy;
  anim.asmfuncs["soldier_cp"][132] = scripts\asm\soldier\long_death::playlongdeathidle;
  anim.asmfuncs["soldier_cp"][133] = scripts\asm\soldier\long_death::playlongdeathgrenadepull;
  anim.asmfuncs["soldier_cp"][134] = scripts\asm\soldier\long_death::longdeathgrenadepullnotetrackhandler;
  anim.asmfuncs["soldier_cp"][135] = scripts\asm\soldier\long_death::playlongdeathgrenade;
  anim.asmfuncs["soldier_cp"][136] = scripts\asm\soldier\long_death::playlongdeathfinaldeath;
  anim.asmfuncs["soldier_cp"][137] = scripts\asm\soldier\long_death::playshootinglongdeathidle;
  anim.asmfuncs["soldier_cp"][138] = scripts\asm\soldier\long_death::hasbeenhitwithemp;
  anim.asmfuncs["soldier_cp"][139] = scripts\asm\soldier\long_death::shoulddodyingcrawl;
  anim.asmfuncs["soldier_cp"][140] = scripts\asm\traverse::playtraverseanim_scaled;
  anim.asmfuncs["soldier_cp"][141] = scripts\asm\soldier\traverse::playtraverseanim_deprecated;
  anim.asmfuncs["soldier_cp"][142] = scripts\asm\soldier\traverse::playtraverseanim_external;
  anim.asmfuncs["soldier_cp"][143] = scripts\asm\soldier\traverse::choosetraverseanim_external;
  anim.asmfuncs["soldier_cp"][144] = scripts\asm\traverse::traverse_cleanup;
  anim.asmfuncs["soldier_cp"][145] = scripts\asm\soldier\traverse::playtraverseanim_ladder;
  anim.asmfuncs["soldier_cp"][146] = scripts\asm\soldier\traverse::terminate_ladder;
  anim.asmfuncs["soldier_cp"][147] = scripts\asm\soldier\traverse::playtraverseanim;
  anim.asmfuncs["soldier_cp"][148] = scripts\asm\traverse::calctraversetype;
  anim.asmfuncs["soldier_cp"][149] = scripts\asm\traverse::playtraversearrivalanim;
  anim.asmfuncs["soldier_cp"][150] = scripts\asm\traverse::traversechooseanim;
  anim.asmfuncs["soldier_cp"][151] = scripts\asm\shared\utility::playanimandusegoalweight;
  anim.asmfuncs["soldier_cp"][152] = scripts\asm\soldier\cover::playshuffleloop;
  anim.asmfuncs["soldier_cp"][153] = scripts\asm\soldier\cover::playshuffleanim_arrival;
  anim.asmfuncs["soldier_cp"][154] = scripts\asm\soldier\cover::playshuffleanim_terminate;
  anim.asmfuncs["soldier_cp"][155] = scripts\asm\soldier\cover::abortshufflecleanup;
  anim.asmfuncs["soldier_cp"][156] = scripts\asm\soldier\cover::shouldbeginshuffleexit;
  anim.asmfuncs["soldier_cp"][157] = scripts\asm\soldier\cover::shouldplayshuffleenter;
  anim.asmfuncs["soldier_cp"][158] = scripts\asm\shared\utility::isarrivaltype;
  anim.asmfuncs["soldier_cp"][159] = scripts\asm\soldier\lmg::playanim_deploylmg;
  anim.asmfuncs["soldier_cp"][160] = scripts\asm\soldier\lmg::chooseanim_deploylmg;
  anim.asmfuncs["soldier_cp"][161] = scripts\asm\soldier\lmg::terminate_deploylmg;
  anim.asmfuncs["soldier_cp"][162] = scripts\asm\soldier\lmg::playcovercrouchlmg;
  anim.asmfuncs["soldier_cp"][163] = scripts\asm\soldier\lmg::coverlmgterminate;
  anim.asmfuncs["soldier_cp"][164] = scripts\asm\soldier\lmg::playanim_dismountlmg;
  anim.asmfuncs["soldier_cp"][165] = scripts\asm\soldier\lmg::playanim_droplmg;
  anim.asmfuncs["soldier_cp"][166] = scripts\asm\soldier\lmg::coverturretterminate;
  anim.asmfuncs["soldier_cp"][167] = scripts\asm\soldier\lmg::playanim_deployturret;
  anim.asmfuncs["soldier_cp"][168] = scripts\asm\soldier\lmg::playanim_dismountturret;
  anim.asmfuncs["soldier_cp"][169] = scripts\asm\soldier\lmg::noanim_deployturret;
  anim.asmfuncs["soldier_cp"][170] = scripts\asm\soldier\lmg::shoulddismountlmg;
  anim.asmfuncs["soldier_cp"][171] = scripts\asm\soldier\lmg::lowestcoverstanddeployposeis;
  anim.asmfuncs["soldier_cp"][172] = scripts\asm\soldier\lmg::desiredturretposeis;
  anim.asmfuncs["soldier_cp"][173] = scripts\asm\soldier\move::playreloadwhilemoving;
  anim.asmfuncs["soldier_cp"][174] = scripts\asm\soldier\move::choosereloadwhilemoving;
  anim.asmfuncs["soldier_cp"][175] = scripts\asm\soldier\move::terminatereloadwhilemoving;
  anim.asmfuncs["soldier_cp"][176] = scripts\asm\soldier\move::playanim_strafeaimchange;
  anim.asmfuncs["soldier_cp"][177] = scripts\asm\soldier\move::chooseanim_strafeaimchange;
  anim.asmfuncs["soldier_cp"][178] = scripts\asm\soldier\move::strafeaimchange_cleanup;
  anim.asmfuncs["soldier_cp"][179] = scripts\asm\soldier\move::playanim_strafereverse;
  anim.asmfuncs["soldier_cp"][180] = scripts\asm\soldier\move::strafereverse_cleanup;
  anim.asmfuncs["soldier_cp"][181] = scripts\asm\soldier\move::chooseanim_strafearrive;
  anim.asmfuncs["soldier_cp"][182] = scripts\asm\soldier\move::stumblechooseanim;
  anim.asmfuncs["soldier_cp"][183] = scripts\asm\soldier\move::shouldstrafeaimchange;
  anim.asmfuncs["soldier_cp"][184] = scripts\asm\soldier\move::shouldrestartaimchange;
  anim.asmfuncs["soldier_cp"][185] = scripts\asm\soldier\script_funcs::reload_cleanup;
  anim.asmfuncs["soldier_cp"][186] = scripts\asm\soldier\script_funcs::terminateexposedprone;
  anim.asmfuncs["soldier_cp"][187] = scripts\asm\soldier\script_funcs::choosecrouchturnanim;
  anim.asmfuncs["soldier_cp"][188] = scripts\asm\soldier\throwgrenade::playanim_throwgrenade;
  anim.asmfuncs["soldier_cp"][189] = scripts\asm\soldier\throwgrenade::playanim_throwgrenade_cleanup;
  anim.asmfuncs["soldier_cp"][190] = scripts\asm\soldier\script_funcs::chooseanim_playerpushed;
  anim.asmfuncs["soldier_cp"][191] = scripts\asm\soldier\mp\script_funcs::forwardpushevent;
  anim.asmfuncs["soldier_cp"][192] = scripts\asm\shared\utility::chooseanimidle;
  anim.asmfuncs["soldier_cp"][193] = scripts\asm\soldier\script_funcs::terminateexposedidleaimdown;
  anim.asmfuncs["soldier_cp"][194] = scripts\asm\soldier\script_funcs::terminateexposedcrouchaimdown;
  anim.asmfuncs["soldier_cp"][195] = scripts\asm\soldier\script_funcs::playanim_newenemyreaction;
  anim.asmfuncs["soldier_cp"][196] = scripts\asm\soldier\script_funcs::terminate_casualkiller;
  anim.asmfuncs["soldier_cp"][197] = scripts\asm\soldier\smartobject::smartobjectcomplete;
  anim.asmfuncs["soldier_cp"][198] = scripts\asm\soldier\smartobject::playsmartobjectpainanim;
  anim.asmfuncs["soldier_cp"][199] = scripts\asm\soldier\smartobject::smartobject_notetrackhandler;
  anim.asmfuncs["soldier_cp"][200] = scripts\asm\soldier\smartobject::choosesmartobjectpainanim;
  anim.asmfuncs["soldier_cp"][201] = scripts\asm\soldier\smartobject::playsmartobjectdeathanim;
  anim.asmfuncs["soldier_cp"][202] = scripts\asm\soldier\smartobject::choosesmartobjectdeathanim;
  anim.asmfuncs["soldier_cp"][203] = scripts\asm\soldier\smartobject::playsmartobjectexit;
  anim.asmfuncs["soldier_cp"][204] = scripts\asm\soldier\smartobject::choosesmartobjectexitanim;
  anim.asmfuncs["soldier_cp"][205] = scripts\asm\soldier\smartobject::playsmartobjectanim;
  anim.asmfuncs["soldier_cp"][206] = scripts\asm\soldier\smartobject::choosesmartobjectanim;
  anim.asmfuncs["soldier_cp"][207] = scripts\asm\soldier\smartobject::playsmartobjectreactanim;
  anim.asmfuncs["soldier_cp"][208] = scripts\asm\soldier\smartobject::choosesmartobjectreactanim;
  anim.asmfuncs["soldier_cp"][209] = scripts\asm\soldier\smartobject::smartobjectinit;
  anim.asmfuncs["soldier_cp"][210] = scripts\asm\soldier\smartobject::playsmartobjectintro;
  anim.asmfuncs["soldier_cp"][211] = scripts\asm\soldier\smartobject::playsmartobjectlogic;
  anim.asmfuncs["soldier_cp"][212] = scripts\asm\soldier\smartobject::smartobjecthasintro;
  anim.asmfuncs["soldier_cp"][213] = scripts\asm\soldier\smartobject::smartobjecthasoutro;
  anim.asmfuncs["soldier_cp"][214] = scripts\asm\soldier\smartobject::smartobjecthaslogic;
  anim.asmfuncs["soldier_cp"][215] = scripts\asm\soldier\smartobject::shouldsmartobjectreact;
  anim.asmfuncs["soldier_cp"][216] = scripts\asm\soldier\smartobject::smartobjecthasexits;
  anim.asmfuncs["soldier_cp"][217] = scripts\asm\soldier\smartobject::shouldplaysmartobjectpain;
  anim.asmfuncs["soldier_cp"][218] = scripts\asm\soldier\smartobject::shouldplaysmartobjectdeath;
  anim.asmfuncs["soldier_cp"][219] = scripts\asm\soldier\smartobject::shouldplaysmartobjectreact;
  anim.asmfuncs["soldier_cp"][220] = scripts\asm\soldier\vehicle::playanim_entervehicle;
  anim.asmfuncs["soldier_cp"][221] = scripts\asm\soldier\vehicle::chooseanim_vehicle;
  anim.asmfuncs["soldier_cp"][222] = scripts\asm\soldier\vehicle::entervehicle_terminate;
  anim.asmfuncs["soldier_cp"][223] = scripts\asm\soldier\vehicle::playanim_exitvehicle;
  anim.asmfuncs["soldier_cp"][224] = scripts\asm\soldier\vehicle::exitvehicle_terminate;
  anim.asmfuncs["soldier_cp"][225] = scripts\asm\soldier\vehicle::playanim_vehicledeath;
  anim.asmfuncs["soldier_cp"][226] = scripts\asm\soldier\vehicle::clearvehiclearchetype;
  anim.asmfuncs["soldier_cp"][227] = scripts\asm\soldier\vehicle::playanim_vehicleidle;
  anim.asmfuncs["soldier_cp"][228] = scripts\asm\soldier\vehicle::playanim_vehicle;
  anim.asmfuncs["soldier_cp"][229] = scripts\asm\soldier\vehicle::playanim_vehicleturret;
  anim.asmfuncs["soldier_cp"][230] = scripts\asm\soldier\vehicle::chooseanim_vehicleturret;
  anim.asmfuncs["soldier_cp"][231] = scripts\asm\soldier\vehicle::playanim_vehicleturret_terminate;
  anim.asmfuncs["soldier_cp"][232] = scripts\asm\soldier\vehicle::chooseanim_vehicleturretdeath;
  anim.asmfuncs["soldier_cp"][233] = scripts\asm\soldier\vehicle::_id_C9C1B653ECDCAFFD;
  anim.asmfuncs["soldier_cp"][234] = scripts\asm\soldier\vehicle::_id_EA6FCDDDE1C07C00;
  anim.asmfuncs["soldier_cp"][235] = scripts\asm\soldier\vehicle::_id_03A547F046D6592A;
  anim.asmfuncs["soldier_cp"][236] = scripts\asm\soldier\vehicle::playanim_vehiclereload;
  anim.asmfuncs["soldier_cp"][237] = scripts\asm\soldier\vehicle::vehiclereload_terminate;
  anim.asmfuncs["soldier_cp"][238] = scripts\asm\soldier\vehicle::_id_D4533DCC81147462;
  anim.asmfuncs["soldier_cp"][239] = scripts\asm\soldier\vehicle::_id_863EAACFE47CEDEE;
  anim.asmfuncs["soldier_cp"][240] = scripts\asm\soldier\vehicle::vehicleshouldstophide;
  anim.asmfuncs["soldier_cp"][241] = scripts\asm\soldier\vehicle::vehiclehasalias;
  anim.asmfuncs["soldier_cp"][242] = scripts\asm\soldier\vehicle::vehicleshouldrunexit;
  anim.asmfuncs["soldier_cp"][243] = scripts\asm\soldier\vehicle::_id_9E3CA0A0ABCF9CF0;
  anim.asmfuncs["soldier_cp"][244] = scripts\asm\soldier\vehicle::_id_B4B7FF53BE58DE23;
  anim.asmfuncs["soldier_cp"][245] = scripts\asm\soldier\vehicle::_id_99CABDA949B9375A;
  anim.asmfuncs["soldier_cp"][246] = scripts\asm\soldier\cp::transition_parachutestate;
  anim.asmfuncs["soldier_cp"][247] = scripts\asm\soldier\mp\melee::on_execution_begin;
  anim.asmfuncs["soldier_cp"][248] = scripts\asm\soldier\ground_turret::playanim_mountturret;
  anim.asmfuncs["soldier_cp"][249] = scripts\asm\soldier\ground_turret::playanim_aioperateturret;
  anim.asmfuncs["soldier_cp"][250] = scripts\asm\soldier\ground_turret::playanim_aidismountturret;
  anim.asmfuncs["soldier_cp"][251] = scripts\asm\soldier\ground_turret::playanim_aibegindismountturret;
  anim.asmfuncs["soldier_cp"][252] = scripts\asm\soldier\ground_turret::aigroundturret_shouldcompletedismount;
  anim.asmfuncs["soldier_cp"][253] = ::autogenfunc_4;
  anim.asmfuncs["soldier_cp"][254] = scripts\asm\soldier\custom::shouldstopcustomidle;
  anim.asmfuncs["soldier_cp"][255] = scripts\asm\soldier\lmg::turretrequested;
  anim.asmfuncs["soldier_cp"][256] = ::autogenfunc_5;
  anim.asmfuncs["soldier_cp"][257] = scripts\asm\shared\utility::shouldleaveanimscripted;
  anim.asmfuncs["soldier_cp"][258] = scripts\asm\soldier\pain::transition_flashfinished;
  anim.asmfuncs["soldier_cp"][259] = scripts\asm\soldier\smartobject::smartobject_shouldexitintomove;
  anim.asmfuncs["soldier_cp"][260] = scripts\asm\soldier\smartobject::needtoturntosmartobject;
  anim.asmfuncs["soldier_cp"][261] = scripts\asm\soldier\vehicle::vehiclegetoutcodemove;
  anim.asmfuncs["soldier_cp"][262] = ::autogenfunc_6;
  anim.asmfuncs["soldier_cp"][263] = ::autogenfunc_7;
  anim.asmfuncs["soldier_cp"][264] = ::autogenfunc_8;
}

autogenfunc_0(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\soldier\move::shouldwalkandtalk();
}

autogenfunc_1(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !scripts\asm\soldier\move::shouldwalkandtalk();
}

autogenfunc_2(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self codemoverequested() && isDefined(self.grenade);
}

autogenfunc_3(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self aigetdesiredspeed() < 60;
}

autogenfunc_4(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_iswhizbyrequested();
}

autogenfunc_5(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !isDefined(scripts\asm\asm_bb::bb_getmeleetarget());
}

autogenfunc_6(asmname) {
  scripts\asm\track::track(asmname);
}

autogenfunc_7(asmname) {
  scripts\asm\juggernaut\juggernaut::juggernaut(asmname);
}

autogenfunc_8(asmname) {
  scripts\asm\gesture::gesture(asmname);
}