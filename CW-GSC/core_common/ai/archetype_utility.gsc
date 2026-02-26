/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_utility.gsc
************************************************/

#using scripts\core_common\ai\archetype_aivsaimelee;
#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_human_cover;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_notetracks;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace aiutility;

function private autoexec __init__system__() {
  system::register(#"archetype_utility", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  registerbehaviorscriptfunctions();
}

function private registerbehaviorscriptfunctions() {
  assert(iscodefunctionptr(&btapi_forceragdoll));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_forceragdoll", &btapi_forceragdoll);
  assert(iscodefunctionptr(&btapi_hasammo));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasammo", &btapi_hasammo);
  assert(iscodefunctionptr(&btapi_haslowammo));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_haslowammo", &btapi_haslowammo);
  assert(isscriptfunctionptr(&function_2de6da8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6a474bfdd215a3f4", &function_2de6da8);
  assert(isscriptfunctionptr(&function_a9bc841));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_185ec143f3641fa6", &function_a9bc841);
  assert(iscodefunctionptr(&btapi_hasenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasenemy", &btapi_hasenemy);
  assert(isscriptfunctionptr(&function_e0454a8b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_10923e11cc70c83f", &function_e0454a8b);
  assert(isscriptfunctionptr(&issafefromgrenades));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"issafefromgrenades", &issafefromgrenades);
  assert(isscriptfunctionptr(&function_f557fb8b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1226ab372ff4dc13", &function_f557fb8b);
  assert(isscriptfunctionptr(&function_865ea8e6));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2ff118c59ed4bd9e", &function_865ea8e6);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78488585a31af367", &function_8f12f910);
  assert(isscriptfunctionptr(&recentlysawenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"recentlysawenemy", &recentlysawenemy);
  assert(isscriptfunctionptr(&shouldbeaggressive));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldbeaggressive", &shouldbeaggressive);
  assert(isscriptfunctionptr(&shouldonlyfireaccurately));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldonlyfireaccurately", &shouldonlyfireaccurately);
  assert(isscriptfunctionptr(&canblindfire));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"canblindfire", &canblindfire);
  assert(isscriptfunctionptr(&shouldreacttonewenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreacttonewenemy", &shouldreacttonewenemy);
  assert(isscriptfunctionptr(&shouldreacttonewenemy));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldreacttonewenemy", &shouldreacttonewenemy);
  assert(isscriptfunctionptr(&hasweaponmalfunctioned));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hasweaponmalfunctioned", &hasweaponmalfunctioned);
  assert(isscriptfunctionptr(&shouldstopmoving));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstopmoving", &shouldstopmoving);
  assert(isscriptfunctionptr(&shouldstopmoving));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstopmoving", &shouldstopmoving);
  assert(isscriptfunctionptr(&function_abb9c007));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_750c8220e46d9ba", &function_abb9c007);
  assert(isscriptfunctionptr(&function_abb9c007));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_750c8220e46d9ba", &function_abb9c007);
  assert(isscriptfunctionptr(&choosebestcovernodeasap));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"choosebestcovernodeasap", &choosebestcovernodeasap);
  assert(isscriptfunctionptr(&function_c1ac838a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_12126a94eb75c541", &function_c1ac838a);
  assert(isscriptfunctionptr(&choosebettercoverservicecodeversion));
  behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterCoverService", &choosebettercoverservicecodeversion, 1);
  assert(isscriptfunctionptr(&sensenearbyplayers));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"sensenearbyplayers", &sensenearbyplayers);
  assert(isscriptfunctionptr(&function_4755155f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_28725784491067a5", &function_4755155f);
  assert(iscodefunctionptr(&btapi_refillammo));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_refillammoifneededservice", &btapi_refillammo);
  assert(isscriptfunctionptr(&function_43a090a8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2b72d392931b3fe0", &function_43a090a8);
  assert(isscriptfunctionptr(&reloadterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"reloadterminate", &reloadterminate);
  assert(isscriptfunctionptr(&function_a7abd081));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_338bde0d7a1d8ab4", &function_a7abd081);
  assert(isscriptfunctionptr(&trystoppingservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"trystoppingservice", &trystoppingservice);
  assert(isscriptfunctionptr(&isfrustrated));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isfrustrated", &isfrustrated);
  assert(isscriptfunctionptr(&function_22766ccd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a7ca1fd075b9349", &function_22766ccd);
  assert(isscriptfunctionptr(&function_d116f6b4));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_40e03ac97f371cb1", &function_d116f6b4);
  assert(iscodefunctionptr(&btapi_updatefrustrationlevel));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_updatefrustrationlevel", &btapi_updatefrustrationlevel);
  assert(isscriptfunctionptr(&islastknownenemypositionapproachable));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"islastknownenemypositionapproachable", &islastknownenemypositionapproachable);
  assert(isscriptfunctionptr(&tryadvancingonlastknownpositionbehavior));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryadvancingonlastknownpositionbehavior", &tryadvancingonlastknownpositionbehavior);
  assert(isscriptfunctionptr(&function_15b9bbef));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6eddb51350d11f58", &function_15b9bbef);
  assert(isscriptfunctionptr(&trygoingtoclosestnodetoenemybehavior));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"trygoingtoclosestnodetoenemybehavior", &trygoingtoclosestnodetoenemybehavior);
  assert(isscriptfunctionptr(&tryrunningdirectlytoenemybehavior));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryrunningdirectlytoenemybehavior", &tryrunningdirectlytoenemybehavior);
  assert(isscriptfunctionptr(&flagenemyunattackableservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"flagenemyunattackableservice", &flagenemyunattackableservice);
  assert(isscriptfunctionptr(&keepclaimnode));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimnode", &keepclaimnode);
  assert(isscriptfunctionptr(&keepclaimnode));
  behaviorstatemachine::registerbsmscriptapiinternal(#"keepclaimnode", &keepclaimnode);
  assert(isscriptfunctionptr(&releaseclaimnode));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"releaseclaimnode", &releaseclaimnode);
  assert(isscriptfunctionptr(&releaseclaimnode));
  behaviorstatemachine::registerbsmscriptapiinternal(#"releaseclaimnode", &releaseclaimnode);
  assert(isscriptfunctionptr(&function_8b760d36));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_674fb2fe0b622d15", &function_8b760d36);
  assert(isscriptfunctionptr(&scriptstartragdoll));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"startragdoll", &scriptstartragdoll);
  assert(isscriptfunctionptr(&notstandingcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"notstandingcondition", &notstandingcondition);
  assert(isscriptfunctionptr(&notcrouchingcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"notcrouchingcondition", &notcrouchingcondition);
  assert(isscriptfunctionptr(&function_736c20e1));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34d02056cda999ed", &function_736c20e1);
  assert(isscriptfunctionptr(&function_4aff5b9d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_67f7516b1162e7ee", &function_4aff5b9d);
  assert(isscriptfunctionptr(&function_4fefd9b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5eb98eaec46c01af", &function_4fefd9b);
  assert(isscriptfunctionptr(&function_31cbd57e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_587aa92de0ae4cdd", &function_31cbd57e);
  assert(isscriptfunctionptr(&function_4aff5b9d));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_67f7516b1162e7ee", &function_4aff5b9d);
  assert(isscriptfunctionptr(&meleeacquiremutex));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleeacquiremutex", &meleeacquiremutex);
  assert(isscriptfunctionptr(&meleereleasemutex));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleereleasemutex", &meleereleasemutex);
  assert(isscriptfunctionptr(&prepareforexposedmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareforexposedmelee", &prepareforexposedmelee);
  assert(isscriptfunctionptr(&cleanupmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupmelee", &cleanupmelee);
  assert(iscodefunctionptr(&btapi_shouldnormalmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
  assert(iscodefunctionptr(&btapi_shouldnormalmelee));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
  assert(iscodefunctionptr(&btapi_shouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldmelee", &btapi_shouldmelee);
  assert(iscodefunctionptr(&btapi_shouldmelee));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldmelee", &btapi_shouldmelee);
  assert(isscriptfunctionptr(&isbalconydeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isbalconydeath", &isbalconydeath);
  assert(isscriptfunctionptr(&function_c104a10e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_73d21e0db2035bfa", &function_c104a10e);
  assert(isscriptfunctionptr(&balconydeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"balconydeath", &balconydeath);
  assert(isscriptfunctionptr(&usecurrentposition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"usecurrentposition", &usecurrentposition);
  assert(isscriptfunctionptr(&isunarmed));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isunarmed", &isunarmed);
  assert(isscriptfunctionptr(&function_459c5ea7));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_712bff7525e4a6b8", &function_459c5ea7);
  assert(isscriptfunctionptr(&function_b375c36c));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3da552249ce651af", &function_b375c36c);
  assert(isscriptfunctionptr(&function_39c7ce7f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_a8b8446f4206a0a", &function_39c7ce7f);
  assert(iscodefunctionptr(&btapi_shouldchargemelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
  assert(iscodefunctionptr(&btapi_shouldchargemelee));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
  assert(isscriptfunctionptr(&cleanupchargemelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemelee", &cleanupchargemelee);
  assert(isscriptfunctionptr(&cleanupchargemeleeattack));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemeleeattack", &cleanupchargemeleeattack);
  assert(isscriptfunctionptr(&setupchargemeleeattack));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupchargemeleeattack", &setupchargemeleeattack);
  assert(isscriptfunctionptr(&function_de7e2d3f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_209f67e4390a01e4", &function_de7e2d3f);
  assert(isscriptfunctionptr(&function_9414b79f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6cd29429666ea22d", &function_9414b79f);
  assert(isscriptfunctionptr(&function_bcbf3f38));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6ae246561f9295e4", &function_bcbf3f38);
  assert(isscriptfunctionptr(&shouldchoosespecialpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpain", &shouldchoosespecialpain);
  assert(isscriptfunctionptr(&function_3769693b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_382af3d128c68e13", &function_3769693b);
  assert(isscriptfunctionptr(&function_9b0e7a22));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50fc16dcf1175197", &function_9b0e7a22);
  assert(isscriptfunctionptr(&shouldchoosespecialpronepain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronepain", &shouldchoosespecialpronepain);
  assert(isscriptfunctionptr(&function_89cb7bfd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78675d76c0c51e10", &function_89cb7bfd);
  assert(isscriptfunctionptr(&shouldchoosespecialdeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialdeath", &shouldchoosespecialdeath);
  assert(isscriptfunctionptr(&shouldchoosespecialpronedeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronedeath", &shouldchoosespecialpronedeath);
  assert(isscriptfunctionptr(&setupexplosionanimscale));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupexplosionanimscale", &setupexplosionanimscale);
  function_7a62f47d();
  assert(iscodefunctionptr(&btapi_isinphalanx));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isinphalanx", &btapi_isinphalanx);
  assert(isscriptfunctionptr(&isinphalanx));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanx", &isinphalanx);
  assert(isscriptfunctionptr(&isinphalanxstance));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanxstance", &isinphalanxstance);
  assert(isscriptfunctionptr(&togglephalanxstance));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"togglephalanxstance", &togglephalanxstance);
  assert(isscriptfunctionptr(&isatattackobject));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatattackobject", &isatattackobject);
  assert(isscriptfunctionptr(&shouldattackobject));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldattackobject", &shouldattackobject);
  assert(isscriptfunctionptr(&generictryreacquireservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"generictryreacquireservice", &generictryreacquireservice);
  behaviortreenetworkutility::registerbehaviortreeaction(#"defaultaction", undefined, undefined, undefined);
  assert(isscriptfunctionptr(&function_331e64bd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e656fe04d8ca3d7", &function_331e64bd);
  archetype_aivsaimelee::registeraivsaimeleebehaviorfunctions();
}

function function_7a62f47d() {
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealth", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactcondition", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldstealth", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealthresume", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactstart", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactterminate", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthidleterminate", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6015c026b1fa3b68", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6903274957b06c58", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"ifinstealth", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_30483c99fb320ecb", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5d5935e442748f9e", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2b4b5597da9bc2f8", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_8374ad58022a136", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_652e009b8323c31b", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealth_enemy_updateeveryframe", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65e89f484bba20bb", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_14f8e3d6eda75d6a", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_458e9a34b803db29", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ed5e6ee9b115c2a", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77e5c00cfcf7002e", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5d73de1aab3eb35d", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_ae56f63cd9fbe86", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealth_shouldinvestigate", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6431cd50d65a767c", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31b933dc0e7c5c84", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e0ad4032a3da41f", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1c37119295b3cc48", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6a892d952d9c58b7", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_247b034a88a7e3b", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_540afeb2906c14c7", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_44e72b8fcdaf3ff8", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealth_shouldhunt", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1432a729e25120ac", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4691e67cad7d9b37", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6c20630dac281d70", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7c50b51a79eba680", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a2cb215f0adfdab", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a287df3d9435b4c", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4429fadb560937b5", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4d4262f789528f48", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6623ac05b3e89d2", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_c3501ebe051547e", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_633bd00a4c6c070d", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_38670b1f6bfc60d6", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_219ee8817462ba75", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_56707481883cec89", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72041acc7d1e9e99", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a1c1fb228689f9c", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_fef2a96c4de38c7", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3cb50e01a7d9b2e0", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7faa7f08cbd182e0", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2792d75a8b597397", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealth_neutral_updateeveryframe", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_15db81c49c83357e", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"ifshoulddosmartobject", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"dosmartobject", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"dosmartobject_init", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_792be4bd91e1c9e2", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4ab3a0d2b8ce1d48", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3fb32d4ff7ddb9f7", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2fa97de855da1e4f", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ccd1fa8f8bd85fc", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7f29302adf2f1e45", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_52aa02ad4a142cb3", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_982f6b18e2cdc06", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_23286b53d24487b4", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_22ca87c523f21d6d", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d1883695574917c", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1cad32c846c91188", &function_8f12f910);
  assert(isscriptfunctionptr(&function_865ea8e6));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_37829e514d614663", &function_865ea8e6);
  assert(isscriptfunctionptr(&function_865ea8e6));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_66bfafd78f8a2da4", &function_865ea8e6);
  assert(isscriptfunctionptr(&function_865ea8e6));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_28aa53308dae6714", &function_865ea8e6);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_77e5c00cfcf7002e", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5d73de1aab3eb35d", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_ae56f63cd9fbe86", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_76d6aa4d32b2559c", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1082b3ce4938748d", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldstealth", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6015c026b1fa3b68", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6903274957b06c58", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"stealthreactcondition", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_34ba896ad71ef639", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_247b034a88a7e3b", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_540afeb2906c14c7", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_44e72b8fcdaf3ff8", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2fa97de855da1e4f", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7cd1f4f1d328c8c", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_344cc9226dda1596", &function_8f12f910);
  assert(isscriptfunctionptr(&function_8f12f910));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1082b3ce4938748d", &function_8f12f910);
  assert(isscriptfunctionptr(&function_865ea8e6));
  behaviorstatemachine::registerbsmscriptapiinternal(#"alwaystrue", &function_865ea8e6);
}

function function_8f12f910(entity) {
  return false;
}

function function_865ea8e6(entity) {
  return true;
}

function private function_ba333ba3() {
  if(is_true(self.var_a8f2b553)) {
    return "SLOPE";
  }

  return "STAIRS";
}

function private bb_getstairsnumskipsteps() {
  assert(isDefined(self._stairsstartnode) && isDefined(self._stairsendnode));
  numtotalsteps = self getblackboardattribute("_staircase_num_total_steps");
  stepssofar = self getblackboardattribute("_staircase_num_steps");
  direction = self getblackboardattribute("_staircase_direction");
  numoutsteps = 2;
  totalstepswithoutout = numtotalsteps - numoutsteps;
  assert(stepssofar < totalstepswithoutout);
  remainingsteps = totalstepswithoutout - stepssofar;

  if(remainingsteps >= 8) {
    return "staircase_skip_8";
  } else if(remainingsteps >= 6) {
    return "staircase_skip_6";
  }

  assert(remainingsteps >= 3);
  return "staircase_skip_3";
}

function function_459c5ea7(entity) {
  return function_27675652(entity) === "_vault_over_drop" || function_b375c36c(entity) || function_39c7ce7f(entity);
}

function function_b375c36c(entity) {
  return function_27675652(entity) === "_vault_jump_up_drop";
}

function function_39c7ce7f(entity) {
  return function_27675652(entity) === "_vault_jump_down_drop";
}

function function_27675652(entity) {
  assert(isDefined(entity.var_854857c6));
  traversaltype = entity getblackboardattribute("_parametric_traversal_type");

  if(!isDefined(traversaltype) || traversaltype != "mantle_traversal") {
    return undefined;
  }

  if(!isDefined(entity.var_854857c6)) {
    return undefined;
  }

  if(!isDefined(entity.ai.var_e233df10)) {
    entity.ai.var_e233df10 = [];
    bundle = getscriptbundle(entity.var_854857c6);
    entity.ai.var_e233df10[#"min"] = bundle.var_f850cb73;
    entity.ai.var_e233df10[#"max"] = bundle.var_f724517b;
  }

  if(!isDefined(entity.ai.var_e233df10[#"min"])) {
    entity.ai.var_e233df10[#"min"] = 0.8;
  }

  if(!isDefined(entity.ai.var_e233df10[#"max"])) {
    entity.ai.var_e233df10[#"max"] = 1.2;
  }

  startnode = entity.traversestartnode;
  endnode = entity.traverseendnode;
  mantlenode = entity.traversemantlenode;

  if(!isDefined(mantlenode)) {
    return undefined;
  }

  startheight = mantlenode.origin[2] - startnode.origin[2];
  var_b6b9b5f0 = mantlenode.origin[2] - endnode.origin[2];

  if(startheight == 0 || var_b6b9b5f0 == 0) {
    assertmsg("<dev string:x38>" + mantlenode.origin[0] + "<dev string:x62>" + mantlenode.origin[1] + "<dev string:x62>" + mantlenode.origin[2] + "<dev string:x68>");
  }

  ratio = abs(var_b6b9b5f0 / startheight);

  if(ratio < entity.ai.var_e233df10[#"min"]) {
    return "_vault_jump_up_drop";
  }

  if(ratio > entity.ai.var_e233df10[#"max"]) {
    return "_vault_jump_down_drop";
  }

  return "_vault_over_drop";
}

function private function_36e869c5() {
  entity = self;
  startnode = entity.traversestartnode;
  mantlenode = entity.traversemantlenode;

  if(!isDefined(mantlenode)) {
    return undefined;
  }

  startheight = abs(mantlenode.origin[2] - startnode.origin[2]);
  return startheight;
}

function private function_975e9355() {
  entity = self;
  endnode = entity.traverseendnode;
  mantlenode = entity.traversemantlenode;

  if(!isDefined(mantlenode)) {
    return undefined;
  }

  var_b6b9b5f0 = abs(mantlenode.origin[2] - endnode.origin[2]);
  return var_b6b9b5f0;
}

function private bb_gettraversalheight() {
  entity = self;
  startposition = entity.traversalstartpos;
  endposition = entity.traversalendpos;

  if(isDefined(entity.traveseheightoverride)) {
    record3dtext("<dev string:x6e>" + entity.traveseheightoverride, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x83>");

    return entity.traveseheightoverride;
  }

  if(isDefined(entity.traversemantlenode) || entity function_dd4f686e()) {
    pivotorigin = archetype_mocomps_utility::calculatepivotoriginfromedge(entity, entity.traversemantlenode, entity.origin);
    traversalheight = pivotorigin[2] - (is_true(entity.var_fad2bca9) && isDefined(entity.traversalstartpos) ? entity.traversalstartpos[2] : entity.origin[2]);

    record3dtext("<dev string:x6e>" + traversalheight, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x83>");

    if(traversalheight < 24) {
      println("<dev string:x8d>" + entity.traversalstartpos + "<dev string:xae>" + traversalheight + "<dev string:xcd>");
    }

    return traversalheight;
  } else if(isDefined(startposition) && isDefined(endposition)) {
    traversalheight = endposition[2] - startposition[2];

    if(bb_getparametrictraversaltype() == "jump_across_traversal" && function_dabc588b(entity.aitype)) {
      traversalheight = abs(traversalheight);
    }

    record3dtext("<dev string:x6e>" + traversalheight, self.origin + (0, 0, 32), (1, 0, 0), "<dev string:x83>");

    return traversalheight;
  }

  return 0;
}

function private bb_gettraversalwidth() {
  entity = self;
  startposition = entity.traversalstartpos;
  endposition = entity.traversalendpos;

  if(isDefined(entity.travesewidthoverride)) {
    record3dtext("<dev string:xed>" + entity.travesewidthoverride, self.origin + (0, 0, 48), (1, 0, 0), "<dev string:x83>");

    return entity.travesewidthoverride;
  }

  if(isDefined(startposition) && isDefined(endposition)) {
    var_d4b651b8 = distance2d(startposition, endposition);

    record3dtext("<dev string:xed>" + var_d4b651b8, self.origin + (0, 0, 48), (1, 0, 0), "<dev string:x83>");

    return var_d4b651b8;
  }

  return 0;
}

function bb_getparametrictraversaltype() {
  entity = self;

  if(entity function_3c566724()) {
    if(entity function_dd4f686e()) {
      return "mantle_traversal";
    }

    startposition = entity.traversalstartpos;
    endposition = entity.traversalendpos;

    if(isDefined(startposition) && isDefined(endposition)) {
      traversaldistance = distance2d(startposition, endposition);
      isendpointaboveorsamelevel = startposition[2] <= endposition[2];

      if(traversaldistance >= 108 && abs(endposition[2] - startposition[2]) <= 100) {
        return "jump_across_traversal";
      }

      if(abs(endposition[2] - startposition[2]) <= 24) {
        var_a4122588 = isendpointaboveorsamelevel ? "<dev string:x101>" : "<dev string:x10d>";
        height = endposition[2] - startposition[2];
        println("<dev string:x11b>" + var_a4122588 + "<dev string:x128>" + height + "<dev string:x14a>" + startposition + "<dev string:x158>" + endposition + "<dev string:x163>");
      }

      if(isendpointaboveorsamelevel) {
        return "jump_up_traversal";
      }

      return "jump_down_traversal";
    }

    return "unknown_traversal";
  }

  entity = self;
  startposition = entity.traversalstartpos;
  endposition = entity.traversalendpos;

  if(!isDefined(entity.traversestartnode) || entity.traversestartnode.type != "Volume" || !isDefined(entity.traverseendnode) || entity.traverseendnode.type != "Volume") {
    return "unknown_traversal";
  }

  if(isDefined(entity.traversestartnode) && isDefined(entity.traversemantlenode)) {
    return "mantle_traversal";
  }

  if(isDefined(startposition) && isDefined(endposition)) {
    traversaldistance = distance2d(startposition, endposition);
    isendpointaboveorsamelevel = startposition[2] <= endposition[2];

    if(traversaldistance >= 108 && abs(endposition[2] - startposition[2]) <= 100) {
      return "jump_across_traversal";
    }

    if(isendpointaboveorsamelevel) {
      if(is_true(entity.traverseendnode.hanging_traversal) && is_true(entity.var_1731eda3)) {
        return "jump_up_hanging_traversal";
      } else {
        return "jump_up_traversal";
      }
    }

    return "jump_down_traversal";
  }

  return "unknown_traversal";
}

function bb_getawareness() {
  return self.awarenesslevelcurrent;
}

function bb_getawarenessprevious() {
  return self.awarenesslevelprevious;
}

function function_cc26899f() {
  if(isDefined(self.zombie_move_speed)) {
    if(self.zombie_move_speed == "walk") {
      return "locomotion_speed_walk";
    } else if(self.zombie_move_speed == "run") {
      return "locomotion_speed_run";
    } else if(self.zombie_move_speed == "sprint") {
      return "locomotion_speed_sprint";
    } else if(self.zombie_move_speed == "super_sprint") {
      return "locomotion_speed_super_sprint";
    } else if(self.zombie_move_speed == "super_super_sprint") {
      return "locomotion_speed_super_super_sprint";
    }
  }

  return "locomotion_speed_walk";
}

function private bb_getgibbedlimbs() {
  entity = self;
  rightarmgibbed = gibserverutils::isgibbed(entity, 16);
  leftarmgibbed = gibserverutils::isgibbed(entity, 32);

  if(rightarmgibbed && leftarmgibbed) {
    return "both_arms";
  } else if(rightarmgibbed) {
    return "right_arm";
  } else if(leftarmgibbed) {
    return "left_arm";
  }

  return "none";
}

function bb_getyawtocovernode() {
  if(!isDefined(self.node) || self.node.spawnflags & 128) {
    return 0;
  }

  disttonodesqr = distance2dsquared(self getnodeoffsetposition(self.node), self.origin);

  if(is_true(self.keepclaimednode)) {
    if(disttonodesqr > sqr(64)) {
      return 0;
    }
  } else if(disttonodesqr > sqr(24)) {
    return 0;
  }

  angletonode = ceil(angleclamp180(self.angles[1] - self getnodeoffsetangles(self.node)[1]));
  return angletonode;
}

function bb_gethigheststance() {
  if(self isatcovernodestrict() && self shouldusecovernode()) {
    higheststance = self gethighestnodestance(self.node);
    return higheststance;
  }

  return self getblackboardattribute("_stance");
}

function bb_getlocomotionfaceenemyquadrantprevious() {
  if(isDefined(self.prevrelativedir)) {
    direction = self.prevrelativedir;

    switch (direction) {
      case 0:
        return "locomotion_face_enemy_none";
      case 1:
        return "locomotion_face_enemy_front";
      case 2:
        return "locomotion_face_enemy_right";
      case 3:
        return "locomotion_face_enemy_left";
      case 4:
        return "locomotion_face_enemy_back";
    }
  }

  return "locomotion_face_enemy_none";
}

function bb_getcurrentcovernodetype() {
  return getcovertype(self.node);
}

function bb_getcoverconcealed() {
  if(iscoverconcealed(self.node)) {
    return "concealed";
  }

  return "unconcealed";
}

function bb_getcurrentlocationcovernodetype() {
  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < sqr(24)) {
    return bb_getcurrentcovernodetype();
  }

  return bb_getpreviouscovernodetype();
}

function function_8493bd6a() {
  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < sqr(24)) {
    return self gethighestnodestance(self.node);
  }

  return self gethighestnodestance(self.prevnode);
}

function function_7f1ff852() {
  var_c6e68bb4 = self.prevnode;

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < sqr(24)) {
    var_c6e68bb4 = self.node;
  }

  if(isDefined(var_c6e68bb4)) {
    if(isinarray(getvalidcoverpeekouts(var_c6e68bb4), "over")) {
      return "YES";
    }
  }

  return "NO";
}

function bb_getshouldturn() {
  if(isDefined(self.should_turn) && self.should_turn) {
    return "should_turn";
  }

  return "should_not_turn";
}

function bb_getarmsposition() {
  if(isDefined(self.zombie_arms_position)) {
    if(self.zombie_arms_position == "up") {
      return "arms_up";
    }

    return "arms_down";
  }

  return "arms_up";
}

function bb_gethaslegsstatus() {
  if(self.missinglegs) {
    return "has_legs_no";
  }

  return "has_legs_yes";
}

function function_f61d3341() {
  if(gibserverutils::isgibbed(self, 256)) {
    return "has_left_leg_no";
  }

  return "has_left_leg_yes";
}

function function_9b395e55() {
  if(gibserverutils::isgibbed(self, 128)) {
    return "has_right_leg_no";
  }

  return "has_right_leg_yes";
}

function function_99e55609() {
  if(gibserverutils::isgibbed(self, 32)) {
    return "has_left_arm_no";
  }

  return "has_left_arm_yes";
}

function function_aa8f1e69() {
  if(gibserverutils::isgibbed(self, 16)) {
    return "has_right_arm_no";
  }

  return "has_right_arm_yes";
}

function function_5b03a448() {
  if(isDefined(self.e_grapplee)) {
    return "has_grapplee_yes";
  }

  return "has_grapplee_no";
}

function actorgetpredictedyawtoenemy(entity, lookaheadtime) {
  if(isDefined(entity.predictedyawtoenemy) && isDefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
    return entity.predictedyawtoenemy;
  }

  selfpredictedpos = entity.origin;
  moveangle = entity.angles[1] + entity getmotionangle();
  selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * lookaheadtime;
  aimpos = entity function_c709ce88();
  yaw = vectortoangles(aimpos - selfpredictedpos)[1] - entity.angles[1];
  yaw = absangleclamp360(yaw);
  entity.predictedyawtoenemy = yaw;
  entity.predictedyawtoenemytime = gettime();
  return yaw;
}

function function_e28a3ee5() {
  if(isDefined(self.var_920617c1)) {
    return self.var_920617c1;
  }

  return "stealth_investigate_height_default";
}

function bb_actorispatroling() {
  entity = self;

  if(entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
    return "patrol_enabled";
  }

  return "patrol_disabled";
}

function bb_actorhasenemy() {
  entity = self;

  if(isDefined(entity.enemy)) {
    return "has_enemy";
  }

  return "no_enemy";
}

function function_b3f35a07() {
  c_door = self.ai.doortoopen;

  if(!isDefined(c_door)) {
    return "door_will_open_no";
  }

  if(is_true(self.ai.door_opened)) {
    return "door_will_open_yes";
  }

  return "door_will_open_no";
}

function function_7970d18b() {
  if(is_true(self.ai.var_10150769)) {
    return "door_overlay_disabled";
  }

  return "door_overlay_enabled";
}

function function_19574f85() {
  c_door = self.ai.doortoopen;

  if(!isDefined(c_door)) {
    return 999999;
  }

  var_203b2da1 = c_door.var_85f2454d.doorbottomcenter;

  if(!isDefined(var_203b2da1)) {
    var_203b2da1 = c_door.origin;
  }

  var_f56439f = c_door.var_85f2454d.var_c4269c41;

  if(!isDefined(var_f56439f)) {
    var_f56439f = anglestoright(c_door.angles);
  }

  var_a003c4d6 = math::vec_to_angles(var_f56439f);
  var_93b76ac5 = var_203b2da1 - self.origin;
  var_3ea61d84 = math::vec_to_angles(var_93b76ac5);
  angle_diff = var_a003c4d6 - var_3ea61d84;
  angle_diff = angleclamp180(angle_diff);
  var_deeb5ea3 = undefined;

  if(angle_diff < 0) {
    var_deeb5ea3 = angle_diff + 90;
  } else {
    var_deeb5ea3 = angle_diff - 90;
  }

  return var_deeb5ea3;
}

function bb_actorgetenemyyaw() {
  enemy = self.enemy;

  if(!isDefined(enemy)) {
    return 0;
  }

  toenemyyaw = actorgetpredictedyawtoenemy(self, 0.2);
  return toenemyyaw;
}

function function_dc8e1a0a() {
  enemy = isDefined(self.var_2df45b5d) ? self.var_2df45b5d : self.enemy;

  if(!isDefined(enemy)) {
    return 0;
  }

  node = undefined;

  if(isDefined(self.node) && self nearnode(self.node)) {
    node = self.node;
  } else {
    node = self.prevnode;
  }

  if(!isDefined(node)) {
    return 0;
  }

  toenemyyaw = vectortoangles(enemy.origin - node.origin)[1] - node.angles[1];
  toenemyyaw = absangleclamp360(toenemyyaw);

  record3dtext("<dev string:x173>" + toenemyyaw, self.origin, (1, 0, 0), "<dev string:x181>", self);

  return toenemyyaw;
}

function bb_actorgetperfectenemyyaw() {
  enemy = isDefined(self.var_2df45b5d) ? self.var_2df45b5d : self.enemy;

  if(!isDefined(enemy)) {
    return 0;
  }

  toenemyyaw = vectortoangles(enemy.origin - self.origin)[1] - self.angles[1];
  toenemyyaw = absangleclamp360(toenemyyaw);

  record3dtext("<dev string:x173>" + toenemyyaw, self.origin, (1, 0, 0), "<dev string:x181>", self);

  return toenemyyaw;
}

function function_caea19a8() {
  result = self.angles[1];

  if(isDefined(self.stealth.patrol_react_pos) && isDefined(self.stealth) && isDefined(self.stealth.patrol_react_time) && gettime() - self.stealth.patrol_react_time < 2000) {
    deltaorigin = self.stealth.patrol_react_pos - self.origin;
    result = vectortoangles(deltaorigin)[1];
  }

  return result;
}

function bb_actorgetreactyaw() {
  return absangleclamp360(self.angles[1] - self getblackboardattribute("_react_yaw_world"));
}

function function_bee4de6() {
  result = self.angles[1];

  if(isDefined(self.var_5aaa7f76)) {
    deltaorigin = self.var_5aaa7f76 - self.origin;

    recordstar(self.var_5aaa7f76, (1, 0, 1), "<dev string:x83>", self);
    recordline(self.origin, self.var_5aaa7f76, (1, 0, 1), "<dev string:x83>", self);

    result = vectortoangles(deltaorigin)[1];
  }

  return result;
}

function function_6568cc68() {
  angle = absangleclamp360(self.angles[1] - self getblackboardattribute("_zombie_react_yaw_world"));

  record3dtext("<dev string:x18f>" + angle, self.origin, (1, 0, 1), "<dev string:x83>", self);

  return angle;
}

function function_abb9c007(entity) {
  if(isDefined(self.stealth)) {
    if(is_true(self.stealth.var_7f670ead)) {
      return 0;
    }

    return is_true(self.stealth.var_527ef51c);
  }

  return self haspath();
}

function getangleusingdirection(direction) {
  directionyaw = vectortoangles(direction)[1];
  yawdiff = directionyaw - self.angles[1];
  yawdiff *= 0.00277778;
  flooredyawdiff = floor(yawdiff + 0.5);
  turnangle = (yawdiff - flooredyawdiff) * 360;
  return absangleclamp360(turnangle);
}

function wasatcovernode() {
  if(isDefined(self.prevnode)) {
    if(self.prevnode.type == # "cover left" || self.prevnode.type == # "cover right" || self.prevnode.type == # "cover pillar" || self.prevnode.type == # "cover stand" || self.prevnode.type == # "conceal stand" || self.prevnode.type == # "cover crouch" || self.prevnode.type == # "cover crouch window" || self.prevnode.type == # "conceal crouch") {
      return true;
    }
  }

  return false;
}

function bb_getlocomotionexityaw(blackboard, yaw) {
  if(self haspath()) {
    predictedlookaheadinfo = self predictexit();
    status = predictedlookaheadinfo[#"path_prediction_status"];

    if(!isDefined(self.pathgoalpos)) {
      return -1;
    }

    if(status == 3) {
      start = self.origin;
      end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
      angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
      exityaw = absangleclamp360(angletoexit - self.prevnode.angles[1]);

      record3dtext("<dev string:x1a1>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x181>", undefined, 0.4);

      return exityaw;
    } else if(status == 4) {
      start = self.origin;
      end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
      angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
      exityaw = absangleclamp360(angletoexit - self.angles[1]);

      record3dtext("<dev string:x1a1>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x181>", undefined, 0.4);

      return exityaw;
    } else if(status == 0) {
      if(wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
        end = self.pathgoalpos;
        angletodestination = vectortoangles(end - self.origin)[1];
        exityaw = absangleclamp360(angletodestination - self.prevnode.angles[1]);

        record3dtext("<dev string:x1a1>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x181>", undefined, 0.4);

        return exityaw;
      }

      start = predictedlookaheadinfo[#"path_prediction_start_point"];
      end = start + predictedlookaheadinfo[#"path_prediction_travel_vector"];
      exityaw = getangleusingdirection(predictedlookaheadinfo[#"path_prediction_travel_vector"]);

      record3dtext("<dev string:x1a1>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x181>", undefined, 0.4);

      return exityaw;
    } else if(status == 2) {
      if(wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
        end = self.pathgoalpos;
        angletodestination = vectortoangles(end - self.origin)[1];
        exityaw = absangleclamp360(angletodestination - self.prevnode.angles[1]);

        record3dtext("<dev string:x1a1>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x181>", undefined, 0.4);

        return exityaw;
      }

      exityaw = getangleusingdirection(vectornormalize(self.pathgoalpos - self.origin));

      record3dtext("<dev string:x1a1>" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "<dev string:x181>", undefined, 0.4);

      return exityaw;
    }
  }

  return -1;
}

function bb_getlocomotionfaceenemyquadrant() {
  walkstring = getdvarstring(#"tacticalwalkdirection");

  switch (walkstring) {
    case # "right":
      return "<dev string:x1af>";
    case # "left":
      return "<dev string:x1ce>";
    case # "back":
      return "<dev string:x1ec>";
  }

  if(isDefined(self.relativedir)) {
    direction = self.relativedir;

    switch (direction) {
      case 0:
        return "locomotion_face_enemy_front";
      case 1:
        return "locomotion_face_enemy_front";
      case 2:
        return "locomotion_face_enemy_right";
      case 3:
        return "locomotion_face_enemy_left";
      case 4:
        return "locomotion_face_enemy_back";
    }
  }

  return "locomotion_face_enemy_front";
}

function bb_getlocomotionpaintype() {
  if(self haspath()) {
    predictedlookaheadinfo = self predictpath();
    status = predictedlookaheadinfo[#"path_prediction_status"];
    startpos = self.origin;
    furthestpointtowardsgoalclear = 1;

    if(status == 2) {
      furthestpointalongtowardsgoal = startpos + vectorscale(self.lookaheaddir, 300);
      furthestpointtowardsgoalclear = self findpath(startpos, furthestpointalongtowardsgoal, 0, 0) && self maymovetopoint(furthestpointalongtowardsgoal);
    }

    if(furthestpointtowardsgoalclear) {
      forwarddir = anglesToForward(self.angles);
      possiblepaintypes = [];
      endpos = startpos + vectorscale(forwarddir, 300);

      if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
        possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_long";
      }

      endpos = startpos + vectorscale(forwarddir, 200);

      if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
        possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_med";
      }

      endpos = startpos + vectorscale(forwarddir, 150);

      if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
        possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_short";
      }

      if(possiblepaintypes.size) {
        return array::random(possiblepaintypes);
      }
    }
  }

  return "locomotion_inplace_pain";
}

function bb_getlookaheadangle() {
  return absangleclamp360(vectortoangles(self.lookaheaddir)[1] - self.angles[1]);
}

function bb_getpreviouscovernodetype() {
  return getcovertype(self.prevnode);
}

function bb_actorgettrackingturnyaw() {
  var_71a0045b = undefined;

  if(isDefined(self.enemy)) {
    if(self cansee(self.enemy)) {
      var_71a0045b = self.enemy.origin;
    } else if(issentient(self.enemy)) {
      if(self.highlyawareradius && distance2dsquared(self.enemy.origin, self.origin) < sqr(self.highlyawareradius)) {
        var_71a0045b = self.enemy.origin;
      } else {
        var_71a0045b = self function_c709ce88();
      }
    }
  } else if(isDefined(self.ai.var_3af1add3)) {
    var_71a0045b = [[self.ai.var_3af1add3]](self);
  } else if(isDefined(self.likelyenemyposition)) {
    if(self canshoot(self.likelyenemyposition)) {
      if(!isDefined(self.var_2747663c)) {
        self.var_2747663c = 0;
        self.var_dec89a60 = 0;
      }

      if(gettime() - self.var_2747663c > 500) {
        self.var_dec89a60 = sighttracepassed(self.origin + (0, 0, 64), self.likelyenemyposition, 0, self);
        self.var_2747663c = gettime();
      }

      if(self.var_dec89a60) {
        var_71a0045b = self.likelyenemyposition;
      }
    }
  }

  if(isDefined(var_71a0045b)) {
    turnyaw = absangleclamp360(self.angles[1] - vectortoangles(var_71a0045b - self.origin)[1]);
    return turnyaw;
  }

  return 0;
}

function function_db9d3d() {
  var_f2db693 = self gettagangles("j_head");

  if(!isDefined(var_f2db693)) {
    return 0;
  }

  var_f2db693 = var_f2db693[1];
  var_b00fa06a = self.angles[1];
  var_18f32ba4 = angleclamp180(var_f2db693 - var_b00fa06a);
  return var_18f32ba4;
}

function bb_getweaponclass() {
  weaponclass = isDefined(self.weaponclass) ? self.weaponclass : "rifle";

  switch (weaponclass) {
    case # "rifle":
      return "rifle";
    case # "rifle":
      return "rifle";
    case # "mg":
      return "mg";
    case # "smg":
      return "smg";
    case # "spread":
      return "spread";
    case # "pistol":
      return "pistol";
    case # "grenade":
      return "grenade";
    case # "rocketlauncher":
      return "rocketlauncher";
    default:
      return "rifle";
  }
}

function function_6f949118() {
  angles = self gettagangles("tag_origin");
  return angleclamp180(angles[0]);
}

function function_38855dc8() {
  if(!isDefined(self.favoriteenemy)) {
    return 0;
  }

  velocity = self.favoriteenemy getvelocity();
  return length(velocity);
}

function function_ebaa4b7c() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  return self.enemy.origin[2] - self.origin[2];
}

function function_6ecd367e() {
  if(!isDefined(self.traversestartnode) || !isDefined(self.traversestartnode.type)) {
    return "NONE";
  }

  return self.traversestartnode.type;
}

function function_b51ae338() {
  if(!isDefined(self.lastfootsteptime)) {
    self.lastfootsteptime = -1;
    self.var_82a8657 = "";
  }

  currenttime = gettime();

  if(currenttime != self.lastfootsteptime) {
    self.lastfootsteptime = currenttime;
    var_ddf4687a = self function_502c064();
    self.var_82a8657 = isDefined(var_ddf4687a.name) ? var_ddf4687a.name : "";
    self.var_5476bfce = isDefined(var_ddf4687a.percentage) ? var_ddf4687a.percentage : 0;
  }

  return self.var_82a8657;
}

function function_4dbfd949() {
  if(!isDefined(self.lastfootsteptime)) {
    self.lastfootsteptime = -1;
    self.var_5476bfce = 0;
  }

  currenttime = gettime();

  if(currenttime != self.lastfootsteptime) {
    self.lastfootsteptime = currenttime;
    var_ddf4687a = self function_502c064();
    self.var_82a8657 = isDefined(var_ddf4687a.name) ? var_ddf4687a.name : "";
    self.var_5476bfce = isDefined(var_ddf4687a.percentage) ? var_ddf4687a.percentage : 0;
  }

  return self.var_5476bfce;
}

function function_463cbab0() {
  if(isDefined(self.ai.exitstance)) {
    return self.ai.exitstance;
  }

  return isDefined(self getblackboardattribute("_stance")) ? self getblackboardattribute("_stance") : "stand";
}

function notstandingcondition(entity) {
  if(entity getblackboardattribute("_stance") != "stand") {
    return true;
  }

  return false;
}

function notcrouchingcondition(entity) {
  if(entity getblackboardattribute("_stance") != "crouch") {
    return true;
  }

  return false;
}

function function_736c20e1(entity) {
  if(entity getblackboardattribute("_stance") != "prone") {
    return true;
  }

  return false;
}

function function_4aff5b9d(entity) {
  var_899a4d57 = 0;

  if(notstandingcondition(entity)) {
    if(isDefined(entity.prevnode) && (!iscovernode(entity.prevnode) || !entity function_4c2fffe6(entity.prevnode))) {
      var_899a4d57 = 1;
    }
  }

  return var_899a4d57;
}

function function_4fefd9b(entity) {
  var_a65f9f38 = 0;

  if(gettime() > (isDefined(entity.var_20b5b6da) ? entity.var_20b5b6da : 0)) {
    if(isDefined(entity.prevnode) && iscovernode(entity.prevnode) && entity function_4c2fffe6(entity.prevnode) && entity nearnode(entity.prevnode)) {
      exityaw = bb_getlocomotionexityaw();

      if(exityaw > 120 && exityaw < 240) {
        tacpoint = function_5e657d(entity.prevnode);

        if(isDefined(tacpoint) && isDefined(entity.enemy) && function_96c81b85(tacpoint, entity.enemy.origin + (0, 0, 60))) {
          var_a65f9f38 = 1;
        }
      }
    }
  }

  return var_a65f9f38;
}

function function_31cbd57e(entity) {
  entity.var_20b5b6da = gettime() + 3000;
  function_2da76de(entity);
}

function scriptstartragdoll(entity) {
  entity startragdoll();

  record3dtext("<dev string:x20a>", entity.origin + (0, 0, 4), (1, 0, 0), "<dev string:x220>", undefined, 0.4);
}

function private prepareforexposedmelee(entity) {
  keepclaimnode(entity);
  meleeacquiremutex(entity);
  currentstance = entity getblackboardattribute("_stance");

  if(isDefined(entity.enemy) && entity.enemy.scriptvehicletype === "firefly") {
    entity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
    entity.var_9af77489 = 1;
  }

  if(currentstance == "crouch") {
    entity setblackboardattribute("_desired_stance", "stand");
  }
}

function isfrustrated(entity) {
  return isDefined(entity.ai.frustrationlevel) && entity.ai.frustrationlevel > 0;
}

function function_22766ccd(entity) {
  if(isDefined(entity.ai.frustrationlevel) && entity.ai.frustrationlevel >= 2) {
    if(entity isatcovernode()) {
      var_7153a971 = gettime() - entity.var_79f94433;

      if(var_7153a971 >= 3000) {
        return true;
      }
    }
  }

  return false;
}

function flagenemyunattackableservice(entity) {
  entity flagenemyunattackable();
}

function islastknownenemypositionapproachable(entity) {
  if(isDefined(entity.enemy)) {
    lastknownpositionofenemy = entity lastknownpos(entity.enemy);

    if(entity isingoal(lastknownpositionofenemy) && entity findpath(entity.origin, lastknownpositionofenemy, 1, 0)) {
      return true;
    }
  }

  return false;
}

function function_d116f6b4(entity) {
  return is_true(entity.fixednode);
}

function tryadvancingonlastknownpositionbehavior(entity) {
  if(isDefined(entity.enemy)) {
    if(is_true(entity.aggressivemode)) {
      lastknownpositionofenemy = entity lastknownpos(entity.enemy);

      if(entity isingoal(lastknownpositionofenemy) && entity findpath(entity.origin, lastknownpositionofenemy, 1, 0)) {
        entity function_a57c34b7(lastknownpositionofenemy, lastknownpositionofenemy);
        setnextfindbestcovertime(entity);
        return true;
      }
    }
  }

  return false;
}

function function_15b9bbef(entity) {
  if(function_d116f6b4(entity) || entity.goalforced) {
    return false;
  }

  if(shouldonlyfireaccurately(entity)) {
    return false;
  }

  if(!isDefined(entity.var_df6c21d4)) {
    return true;
  }

  if(gettime() > entity.var_df6c21d4) {
    return true;
  }

  return false;
}

function trygoingtoclosestnodetoenemybehavior(entity) {
  var_be8baf32 = randomintrange(30000, 60000);

  if(entity.aggressivemode) {
    var_be8baf32 /= 2;
  }

  entity.var_df6c21d4 = gettime() + var_be8baf32;

  if(isDefined(entity.weapon) && isDefined(entity.weapon.weapclass) && entity.weapon.weapclass == "spread") {
    if(!is_true(entity.var_64a1455c) && isDefined(entity.team) && entity.team !== # "allies") {
      var_75f2bdf3 = tryrunningdirectlytoenemybehavior(entity);

      if(var_75f2bdf3) {
        return true;
      }
    }
  }

  if(isDefined(entity.enemy)) {
    lastknownpositionofenemy = entity lastknownpos(entity.enemy);
    closestrandomnode = undefined;
    nodes = entity findbestcovernodes();

    if(nodes.size > 0) {
      var_e416dc99 = [];

      foreach(node in nodes) {
        if(node.spawnflags & 128) {
          var_e416dc99[var_e416dc99.size] = node;
          continue;
        }

        var_c86d779 = anglesToForward(node.angles);
        dirtoenemy = vectornormalize((lastknownpositionofenemy - node.origin) * (1, 1, 0));
        dot = vectordot(var_c86d779, dirtoenemy);

        if(dot > 0.5) {
          var_e416dc99[var_e416dc99.size] = node;
        }
      }

      if(var_e416dc99.size > 0) {
        nodes = var_e416dc99;
      }

      var_abe95912 = min(nodes.size, 15);
      bestnodes = array::slice(nodes, 0, var_abe95912 - 1);
      var_1a11849e = arraysortclosest(bestnodes, lastknownpositionofenemy, 1);
      closestrandomnode = var_1a11849e[0];
    }

    if(isDefined(closestrandomnode) && entity isingoal(closestrandomnode.origin)) {
      releaseclaimnode(entity);
      usecovernodewrapper(entity, closestrandomnode);
      return true;
    }
  }

  return false;
}

function tryrunningdirectlytoenemybehavior(entity) {
  if(isDefined(entity.enemy) && is_true(entity.aggressivemode)) {
    origin = entity.enemy.origin;
    var_4bb69ed1 = 0;

    if(entity isingoal(origin)) {
      var_4bb69ed1 = 1;
    } else {
      goalinfo = self function_4794d6a3();

      if(isDefined(goalinfo.goalvolume)) {
        var_28fe9101 = goalinfo.goalvolume.maxs - goalinfo.goalvolume.mins;
        var_2e7904ce = (var_28fe9101[0] + var_28fe9101[1]) / 2;
        var_9fd6b922 = var_2e7904ce * 0.5;
        var_7ccdb9a2 = function_1ec73db4(origin, goalinfo.goalvolume);

        if(var_7ccdb9a2 < var_9fd6b922) {
          var_4bb69ed1 = 1;
        }
      } else {
        var_d1530255 = goalinfo.goalradius * 0.5;
        var_30a12270 = distance(origin, goalinfo.goalpos) - goalinfo.goalradius;

        if(var_30a12270 < var_d1530255) {
          var_4bb69ed1 = 1;
        }
      }
    }

    if(var_4bb69ed1 && entity findpath(entity.origin, origin, 1, 0)) {
      function_106ea3ab(entity, origin);
      thread function_97d5dde9(entity, entity.enemy);
      return true;
    }
  }

  return false;
}

function private function_106ea3ab(entity, origin) {
  entity function_a57c34b7(origin, undefined, "run_to_enemy");
  releaseclaimnode(entity);
  setnextfindbestcovertime(entity);

  if(entity.nextfindbestcovertime - gettime() < 20000) {
    entity.nextfindbestcovertime = gettime() + 20000;
  }
}

function private function_97d5dde9(entity, currentenemy) {
  entity endon(#"death", #"entitydeleted");
  self notify("676a46e517cf5043");
  self endon("676a46e517cf5043");

  while(true) {
    if(!isDefined(entity.enemy)) {
      entity function_d4c687c9();
      return;
    }

    if(entity.enemy != currentenemy) {
      function_106ea3ab(entity, entity.enemy.origin);
      currentenemy = entity.enemy;
    }

    if(gettime() > entity.nextfindbestcovertime) {
      entity function_d4c687c9();
      return;
    }

    if(entity cansee(entity.enemy)) {
      function_106ea3ab(entity, entity.enemy.origin);
    }

    wait 1;
  }
}

function shouldreacttonewenemy(entity) {
  return false;
}

function hasweaponmalfunctioned(entity) {
  return is_true(entity.malfunctionreaction);
}

function function_2de6da8(entity) {
  if(entity ai::get_behavior_attribute("disablereload")) {
    return true;
  }

  if(btapi_hasammo(entity) || function_5ac894ba(entity)) {
    return true;
  }

  return false;
}

function function_a9bc841(entity) {
  if(entity ai::get_behavior_attribute("disablereload")) {
    return false;
  }

  if(btapi_haslowammo(entity) && !function_5ac894ba(entity)) {
    return true;
  }

  return false;
}

function function_e0454a8b(entity) {
  if(btapi_hasenemy(entity)) {
    return true;
  }

  if(isDefined(entity.var_38754eac)) {
    return true;
  }

  return false;
}

function issafefromgrenades(entity) {
  return entity issafefromgrenade();
}

function function_f557fb8b(entity, optionalorigin) {
  if(isDefined(optionalorigin)) {
    if(!entity function_e8448790(optionalorigin)) {
      return false;
    }

    if(entity function_3f7004eb(optionalorigin)) {
      return false;
    }
  } else {
    if(!issafefromgrenades(entity)) {
      return false;
    }

    if(!entity function_b6149e2e()) {
      return false;
    }
  }

  return true;
}

function recentlysawenemy(entity) {
  if(isDefined(entity.enemy) && entity seerecently(entity.enemy, 6)) {
    return true;
  }

  return false;
}

function shouldonlyfireaccurately(entity) {
  if(is_true(entity.accuratefire)) {
    return true;
  }

  return false;
}

function canblindfire(entity) {
  if(is_true(entity.var_57314c74)) {
    return true;
  }

  return false;
}

function shouldbeaggressive(entity) {
  if(is_true(entity.aggressivemode)) {
    return true;
  }

  return false;
}

function usecovernodewrapper(entity, node) {
  samenode = entity.node === node;
  entity usecovernode(node);

  if(!samenode) {
    entity setblackboardattribute("_cover_mode", "cover_mode_none");
    entity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
  }

  if(samenode) {
    setnextfindbestcovertime(entity);
  } else {
    entity.var_11b1735a = 1;
  }

  entity.ai.var_47823ae7 = gettime() + 1000;
}

function function_3823e69e(entity) {
  var_f4406fbd = 0;

  if(is_true(entity.var_11b1735a)) {
    var_f4406fbd = 1;

    if(isDefined(entity.node)) {
      offsetorigin = entity getnodeoffsetposition(entity.node);

      if(!entity isposatgoal(offsetorigin)) {
        var_f4406fbd = 0;
      }
    }
  }

  if(var_f4406fbd) {
    setnextfindbestcovertime(entity);
    entity.var_79f94433 = gettime();
    entity.var_11b1735a = undefined;
  }
}

function setnextfindbestcovertime(entity) {
  entity.nextfindbestcovertime = entity getnextfindbestcovertime();
}

function choosebestcovernodeasap(entity) {
  node = getbestcovernodeifavailable(entity);

  if(isDefined(node)) {
    releaseclaimnode(entity);
    usecovernodewrapper(entity, node);
  }
}

function function_c1ac838a(entity) {
  var_eddf1d34 = function_f557fb8b(entity);

  if(!var_eddf1d34) {
    node = getbestcovernodeifavailable(entity);

    if(isDefined(node)) {
      if(isDefined(entity.node) && !var_eddf1d34 && !function_f557fb8b(entity, node.origin)) {
        node = undefined;
      }
    }

    if(isDefined(node)) {
      releaseclaimnode(entity);
      usecovernodewrapper(entity, node);
    }
  }
}

function function_589c524f(entity) {
  var_edbb5c0d = 0;

  if(isDefined(entity.ai.var_bb3caa0f)) {
    goalinfo = self function_4794d6a3();

    if(isDefined(goalinfo.overridegoalpos)) {
      if(goalinfo.var_93096ed5 === "exposed_reacquire") {
        var_edbb5c0d = 1;
      }
    }
  }

  if(var_edbb5c0d) {
    if(!goalinfo.var_9e404264) {
      return 1;
    }

    curtime = gettime();
    var_20d51dfe = gettime() - entity.ai.var_bb3caa0f;
    var_5b03a551 = var_20d51dfe >= 5000;

    if(!var_5b03a551) {
      return 2;
    }

    var_bb5564f2 = var_20d51dfe > 30000;

    if(!var_bb5564f2) {
      return 3;
    } else {
      return 4;
    }
  }

  return 0;
}

function choosebettercoverservicecodeversion(entity) {
  if(!isalive(entity)) {
    return false;
  }

  if(isDefined(entity.stealth) && entity ai::get_behavior_attribute("stealth")) {
    return false;
  }

  if(is_true(entity.fixednode)) {
    var_d4302a98 = 0;

    if(isDefined(entity getgoalvolume())) {
      if(!isDefined(entity.node) || !entity isapproachinggoal()) {
        var_d4302a98 = 1;
      }
    }

    if(!var_d4302a98) {
      return false;
    }
  }

  if(is_true(entity.avoid_cover)) {
    return false;
  }

  var_eddf1d34 = function_f557fb8b(entity);

  if(var_eddf1d34) {
    if(entity isatcovernode() && issuppressedatcovercondition(entity)) {
      return false;
    }

    if(function_22766ccd(entity) && function_15b9bbef(entity)) {
      return false;
    }
  }

  var_d78ca29a = function_589c524f(entity);

  if(var_d78ca29a == 1 || var_d78ca29a == 2) {
    return false;
  }

  if(is_true(entity.keepclaimednode)) {
    return false;
  }

  var_eef1785f = !is_true(entity.var_11b1735a);
  newnode = entity choosebettercovernode(1, !var_eef1785f);

  if(isDefined(newnode)) {
    if(isDefined(entity.node) && !var_eddf1d34 && !function_f557fb8b(entity)) {
      newnode = undefined;
    }
  }

  if(isDefined(newnode)) {
    usecovernodewrapper(entity, newnode);
    return true;
  }

  var_c8d2b0aa = is_true(entity.var_11b1735a);

  if(gettime() > entity.nextfindbestcovertime && !var_c8d2b0aa) {
    setnextfindbestcovertime(entity);
  }

  return false;
}

function private sensenearbyplayers(entity) {
  if(isDefined(entity.stealth) && entity ai::get_behavior_attribute("stealth")) {
    return 0;
  }

  var_821a7a87 = getplayers();

  if(entity.team === # "allies") {
    allai = getaiarray();

    foreach(ai in allai) {
      if(ai.team === # "axis") {
        array::add(var_821a7a87, ai);
      }
    }
  }

  foreach(target in var_821a7a87) {
    distancesq = distancesquared(target.origin, entity.origin);

    if(isDefined(entity.ai.var_5a4e769f)) {
      var_89f8daa2 = entity.ai.var_5a4e769f;
      var_f7df3136 = sqr(var_89f8daa2);
    } else {
      var_89f8daa2 = 360;
      var_f7df3136 = sqr(360);
    }

    if(distancesq <= var_f7df3136) {
      distancetotarget = sqrt(distancesq);
      randchance = 1 - distancetotarget / var_89f8daa2;
      var_56e2d5dc = randomfloat(1);

      if(var_56e2d5dc < randchance) {
        entity getperfectinfo(target);
      }
    }
  }
}

function private function_4755155f(entity) {
  btapi_trackcoverparamsservice(entity);
}

function function_43a090a8(entity) {
  entity.ai.reloading = 1;
}

function reloadterminate(entity) {
  btapi_refillammo(entity);
  entity.ai.reloading = 0;

  if(isDefined(entity.var_bd5efde2)) {
    animationstatenetwork::function_9d41000(entity);
  }

  if(isDefined(entity.var_af41987d) && entity haspart(entity.var_af41987d)) {
    entity showpart(entity.var_af41987d);
  }

  if(isDefined(entity.var_91d2328b) && entity haspart(entity.var_91d2328b)) {
    entity showpart(entity.var_91d2328b);
  }
}

function private function_a7abd081(entity) {}

function getbestcovernodeifavailable(entity) {
  node = entity findbestcovernode();

  if(!isDefined(node)) {
    return undefined;
  }

  if(entity nearclaimnode()) {
    currentnode = self.node;
  }

  if(isDefined(currentnode) && node == currentnode) {
    return undefined;
  }

  if(isDefined(entity.covernode) && node == entity.covernode) {
    return undefined;
  }

  return node;
}

function getsecondbestcovernodeifavailable(entity) {
  nodes = entity findbestcovernodes();

  if(nodes.size > 1) {
    node = nodes[1];
  }

  if(!isDefined(node)) {
    return undefined;
  }

  if(entity nearclaimnode()) {
    currentnode = self.node;
  }

  if(isDefined(currentnode) && node == currentnode) {
    return undefined;
  }

  if(isDefined(entity.covernode) && node == entity.covernode) {
    return undefined;
  }

  return node;
}

function getcovertype(node) {
  if(isDefined(node)) {
    if(node.type == # "cover pillar") {
      return "cover_pillar";
    } else if(node.type == # "cover left") {
      return "cover_left";
    } else if(node.type == # "cover right") {
      return "cover_right";
    } else if(node.type == # "cover stand" || node.type == # "conceal stand") {
      return "cover_stand";
    } else if(node.type == # "cover crouch" || node.type == # "cover crouch window" || node.type == # "conceal crouch") {
      return "cover_crouch";
    } else if(node.type == # "exposed" || node.type == # "guard") {
      return "cover_exposed";
    } else if(node.type == # "turret") {
      return "cover_turret";
    }
  }

  return "cover_none";
}

function iscoverconcealed(node) {
  if(isDefined(node)) {
    return (node.type == # "conceal crouch" || node.type == # "conceal stand");
  }

  return false;
}

function canseeenemywrapper() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(!isDefined(self.node)) {
    return self cansee(self.enemy);
  }

  node = self.node;
  enemyeye = self.enemy getEye();
  yawtoenemy = angleclamp180(node.angles[1] - vectortoangles(enemyeye - node.origin)[1]);

  if(node.type == # "cover left" || node.type == # "cover right") {
    if(yawtoenemy > 60 || yawtoenemy < -60) {
      return 0;
    }

    if(self function_c97b59f8("stand", node)) {
      if(node.type == # "cover left" && yawtoenemy > 10) {
        return 0;
      }

      if(node.type == # "cover right" && yawtoenemy < -10) {
        return 0;
      }
    }
  }

  nodeoffset = (0, 0, 0);

  if(node.type == # "cover pillar") {
    assert(!(isDefined(node.spawnflags) && (node.spawnflags & 2048) == 2048) || !(isDefined(node.spawnflags) && (node.spawnflags & 1024) == 1024));
    canseefromleft = 1;
    canseefromright = 1;
    nodeoffset = (-32, 3.7, 60);
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    canseefromleft = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
    nodeoffset = (32, 3.7, 60);
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    canseefromright = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
    return (canseefromright || canseefromleft);
  }

  if(node.type == # "cover left") {
    nodeoffset = (-36, 7, 63);
  } else if(node.type == # "cover right") {
    nodeoffset = (36, 7, 63);
  } else if(node.type == # "cover stand" || node.type == # "conceal stand") {
    nodeoffset = (-3.7, -22, 63);
  } else if(node.type == # "cover crouch" || node.type == # "cover crouch window" || node.type == # "conceal crouch") {
    nodeoffset = (3.5, -12.5, 45);
  }

  lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);

  if(sighttracepassed(lookfrompoint, enemyeye, 0, undefined)) {
    return 1;
  }

  return 0;
}

function calculatenodeoffsetposition(node, nodeoffset) {
  right = anglestoright(node.angles);
  forward = anglesToForward(node.angles);
  return node.origin + vectorscale(right, nodeoffset[0]) + vectorscale(forward, nodeoffset[1]) + (0, 0, nodeoffset[2]);
}

function gethighestnodestance(node) {
  assert(isDefined(node));
  assert(isDefined(self));

  if(self function_c97b59f8("stand", node)) {
    return "stand";
  }

  if(self function_c97b59f8("crouch", node)) {
    return "crouch";
  }

  if(self function_c97b59f8("prone", node)) {
    return "prone";
  }

  var_f078bbdd = [];

  if(doesnodeallowstance(node, "<dev string:x22d>")) {
    var_f078bbdd[var_f078bbdd.size] = "<dev string:x22d>";
  }

  if(doesnodeallowstance(node, "<dev string:x236>")) {
    var_f078bbdd[var_f078bbdd.size] = "<dev string:x236>";
  }

  if(doesnodeallowstance(node, "<dev string:x240>")) {
    var_f078bbdd[var_f078bbdd.size] = "<dev string:x240>";
  }

  var_58cb7691 = [];

  if(self function_f0e4aede("<dev string:x22d>", node)) {
    var_58cb7691[var_58cb7691.size] = "<dev string:x22d>";
  }

  if(self function_f0e4aede("<dev string:x236>", node)) {
    var_58cb7691[var_58cb7691.size] = "<dev string:x236>";
  }

  if(self function_f0e4aede("<dev string:x240>", node)) {
    var_58cb7691[var_58cb7691.size] = "<dev string:x240>";
  }

  msg1 = "<dev string:x249>" + self.aitype + "<dev string:x254>" + node.type + "<dev string:x26c>" + node.origin + "<dev string:x279>";
  msg2 = "<dev string:x295>";

  if(var_f078bbdd.size == 0) {
    msg2 += "<dev string:x2b1>";
  } else {
    foreach(stance in var_f078bbdd) {
      msg2 += "<dev string:x2bc>" + stance + "<dev string:x2c2>";
    }
  }

  msg2 += "<dev string:x2c7>";
  msg3 = "<dev string:x2cd>";

  if(var_58cb7691.size == 0) {
    msg3 += "<dev string:x2b1>";
  } else {
    foreach(stance in var_58cb7691) {
      msg3 += "<dev string:x2bc>" + stance + "<dev string:x2c2>";
    }
  }

  msg3 += "<dev string:x2c7>";
  errormsg("<dev string:x2ea>" + msg1 + "<dev string:x2ea>" + msg2 + "<dev string:x2ea>" + msg3);

  if(node.type == # "cover crouch" || node.type == # "cover crouch window" || node.type == # "conceal crouch") {
    return "crouch";
  }

  return "stand";
}

function function_c97b59f8(stance, node) {
  assert(isDefined(stance));
  assert(isDefined(node) && ispathnode(node));
  assert(isDefined(self) && isactor(self));

  if(ispathnode(node) && isactor(self) && isDefined(stance)) {
    return (doesnodeallowstance(node, stance) && self function_f0e4aede(stance, node));
  }

  return false;
}

function trystoppingservice(entity) {
  if(entity shouldholdgroundagainstenemy()) {
    entity clearpath();
    keepclaimnode(entity);
    return true;
  }

  releaseclaimnode(entity);
  return false;
}

function shouldstopmoving(entity) {
  if(entity shouldholdgroundagainstenemy()) {
    return true;
  }

  return false;
}

function setcurrentweapon(weapon) {
  self.weapon = weapon;
  self.weaponclass = weapon.weapclass;

  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), "<dev string:x2ef>" + weapon.name + "<dev string:x2fa>");
  }

  self.weaponmodel = weapon.worldmodel;
}

function setprimaryweapon(weapon) {
  self.primaryweapon = weapon;
  self.primaryweaponclass = weapon.weapclass;

  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), "<dev string:x2ef>" + weapon.name + "<dev string:x2fa>");
  }
}

function setsecondaryweapon(weapon) {
  self.secondaryweapon = weapon;
  self.secondaryweaponclass = weapon.weapclass;

  if(weapon != level.weaponnone) {
    assert(isDefined(weapon.worldmodel), "<dev string:x2ef>" + weapon.name + "<dev string:x2fa>");
  }
}

function keepclaimnode(entity) {
  entity.keepclaimednode = 1;
  return true;
}

function releaseclaimnode(entity) {
  entity.keepclaimednode = 0;
  return true;
}

function function_8b760d36(entity) {
  if(entity isingoal(entity.origin)) {
    return true;
  }

  return false;
}

function getaimyawtoenemyfromnode(entity, node, enemy) {
  return angleclamp180(vectortoangles(node lastknownpos(node.enemy) - enemy.origin)[1] - enemy.angles[1]);
}

function getaimpitchtoenemyfromnode(entity, node, enemy) {
  return angleclamp180(vectortoangles(node lastknownpos(node.enemy) - enemy.origin)[0] - enemy.angles[0]);
}

function choosefrontcoverdirection(entity) {
  coverdirection = entity getblackboardattribute("_cover_direction");
  entity setblackboardattribute("_previous_cover_direction", coverdirection);
  entity setblackboardattribute("_cover_direction", "cover_front_direction");
}

function locomotionshouldpatrol(entity) {
  if(entity haspath() && entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
    return true;
  }

  return false;
}

function private _dropriotshield(riotshieldinfo) {
  entity = self;
  entity shared::throwweapon(riotshieldinfo.weapon, riotshieldinfo.tag, 1, 0);

  if(isDefined(entity)) {
    entity detach(riotshieldinfo.model, riotshieldinfo.tag);
  }
}

function attachriotshield(entity, riotshieldweapon, riotshieldmodel, riotshieldtag) {
  riotshield = spawnStruct();
  riotshield.weapon = riotshieldweapon;
  riotshield.tag = riotshieldtag;
  riotshield.model = riotshieldmodel;
  entity attach(riotshieldmodel, riotshield.tag);
  entity.riotshield = riotshield;
}

function dropriotshield(entity) {
  if(isDefined(entity.riotshield)) {
    riotshieldinfo = entity.riotshield;
    entity.riotshield = undefined;
    entity thread _dropriotshield(riotshieldinfo);
  }
}

function meleeacquiremutex(entity) {
  if(isDefined(entity) && isDefined(entity.enemy)) {
    entity.meleeenemy = entity.enemy;

    if(isPlayer(entity.meleeenemy)) {
      if(!isDefined(entity.meleeenemy.meleeattackers)) {
        entity.meleeenemy.meleeattackers = 0;
      }

      entity.meleeenemy.meleeattackers++;
    }
  }
}

function meleereleasemutex(entity) {
  if(isDefined(entity.meleeenemy)) {
    if(isPlayer(entity.meleeenemy)) {
      if(isDefined(entity.meleeenemy.meleeattackers)) {
        entity.meleeenemy.meleeattackers -= 1;

        if(entity.meleeenemy.meleeattackers <= 0) {
          entity.meleeenemy.meleeattackers = undefined;
        }
      }
    }
  }

  entity.meleeenemy = undefined;
}

function shouldmutexmelee(entity) {
  return function_3d91d94b(entity);
}

function shouldnormalmelee(entity) {
  return hascloseenemytomelee(entity);
}

function shouldmelee(entity) {
  return btapi_shouldmelee(entity);
}

function hascloseenemytomelee(entity) {
  return btapi_shouldnormalmelee(entity);
}

function shouldchargemelee(entity) {
  return btapi_shouldchargemelee(entity);
}

function private setupchargemeleeattack(entity) {
  if(isDefined(entity.enemy) && entity.enemy.scriptvehicletype === "firefly") {
    entity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
    entity.var_9af77489 = 1;
  }

  meleeacquiremutex(entity);
  keepclaimnode(entity);

  record3dtext("<dev string:x31d>" + distance(self.origin, self.enemy.origin), self.origin + (0, 0, 64), (1, 0, 0), "<dev string:x33c>");
}

function private cleanupmelee(entity) {
  meleereleasemutex(entity);
  releaseclaimnode(entity);

  if(is_true(entity.var_9af77489)) {
    entity setblackboardattribute("_melee_enemy_type", undefined);
    entity.var_9af77489 = undefined;
  }

  if(isDefined(entity.ai.var_aba9dcfd) && isDefined(entity.ai.var_38ee3a42)) {
    entity pathmode("move delayed", 1, randomfloatrange(entity.ai.var_aba9dcfd, entity.ai.var_38ee3a42));
  }
}

function private cleanupchargemelee(entity) {
  entity.ai.nextchargemeleetime = gettime() + 2000;

  if(is_true(entity.var_9af77489)) {
    entity setblackboardattribute("_melee_enemy_type", undefined);
    entity.var_9af77489 = undefined;
  }

  meleereleasemutex(entity);
  releaseclaimnode(entity);
  entity pathmode("move delayed", 1, randomfloatrange(0.75, 1.5));
}

function cleanupchargemeleeattack(entity) {
  meleereleasemutex(entity);
  releaseclaimnode(entity);

  if(is_true(entity.var_9af77489)) {
    entity setblackboardattribute("_melee_enemy_type", undefined);
    entity.var_9af77489 = undefined;
  }

  if(isDefined(entity.ai.var_aba9dcfd) && isDefined(entity.ai.var_38ee3a42)) {
    entity pathmode("move delayed", 1, randomfloatrange(entity.ai.var_aba9dcfd, entity.ai.var_38ee3a42));
    return;
  }

  entity pathmode("move delayed", 1, randomfloatrange(0.5, 1));
}

function private shouldchoosespecialpronepain(entity) {
  stance = entity getblackboardattribute("_stance");
  return stance == "prone_back" || stance == "prone_front";
}

function private function_9b0e7a22(entity) {
  return entity.var_40543c03 === "concussion";
}

function private function_3769693b(entity) {
  return entity.var_40543c03 === "fire";
}

function private shouldchoosespecialpain(entity) {
  return false;
}

function private function_89cb7bfd(entity) {
  return entity.var_ab2486b4;
}

function private shouldchoosespecialdeath(entity) {
  if(isDefined(entity.damageweapon)) {
    return entity.damageweapon.specialpain;
  }

  return 0;
}

function private shouldchoosespecialpronedeath(entity) {
  stance = entity getblackboardattribute("_stance");
  return stance == "prone_back" || stance == "prone_front";
}

function private setupexplosionanimscale(entity, asmstatename) {
  self.animtranslationscale = 2;
  self asmsetanimationrate(0.7);
  return 4;
}

function isbalconydeath(entity) {
  if(is_true(entity.var_2f38dcc9) || is_true(entity.var_f13e4919)) {
    self.b_balcony_death = 1;
    return true;
  }

  if(!isDefined(entity.node)) {
    return false;
  }

  if(!(entity.node.spawnflags & 1024 || entity.node.spawnflags & 2048)) {
    return false;
  }

  if(isDefined(entity.node.script_balconydeathchance) && randomint(100) > int(100 * entity.node.script_balconydeathchance)) {
    return false;
  }

  distsq = distancesquared(entity.origin, entity.node.origin);

  if(distsq > sqr(64)) {
    return false;
  }

  anglediff = math::angle_dif(int(entity.node.angles[1]), int(entity.angles[1]));

  if(abs(anglediff) > 15) {
    return false;
  }

  self.b_balcony_death = 1;
  return true;
}

function function_c104a10e(entity) {
  if(is_true(entity.var_20ed6efb)) {
    return true;
  }

  if(!isDefined(entity.node)) {
    return false;
  }

  if(!is_true(entity.node.var_f0a93b8d)) {
    return false;
  }

  if(isDefined(entity.node.var_b8179184) && randomint(100) > int(100 * entity.node.var_b8179184)) {
    return false;
  }

  distsq = distancesquared(entity.origin, entity.node.origin);

  if(distsq > sqr(64)) {
    return false;
  }

  anglediff = math::angle_dif(int(entity.node.angles[1]), int(entity.angles[1]));

  if(abs(anglediff) > 15) {
    return false;
  }

  return true;
}

function balconydeath(entity) {
  entity.clamptonavmesh = 0;

  if(is_true(entity.var_2f38dcc9) || entity.node.spawnflags & 1024) {
    entity setblackboardattribute("_special_death", "balcony");
    return;
  }

  if(is_true(entity.var_f13e4919) || entity.node.spawnflags & 2048) {
    entity setblackboardattribute("_special_death", "balcony_norail");
  }
}

function usecurrentposition(entity) {
  entity function_a57c34b7(entity.origin);
}

function isunarmed(entity) {
  if(entity.weapon == level.weaponnone) {
    return true;
  }

  return false;
}

function function_7bbe1407(ai) {
  ai endon(#"death");
  sniper_glint = # "lensflares/fx9_lf_sniper_glint";
  var_910f361 = ai.weapon;
  fx_tags = ["tag_sights", "tag_scope_rear_lid_animate", "tag_scope", "tag_barrel", "tag_flash", "tag_eye"];

  while(true) {
    ai waittill(#"about_to_fire");

    if(ai.weapon != var_910f361) {
      continue;
    }

    for(i = 0; i < fx_tags.size; i++) {
      tag = fx_tags[i];
      has_tag = isDefined(ai gettagorigin(tag));

      if(has_tag) {
        playFXOnTag(sniper_glint, ai, tag);
        break;
      }
    }
  }
}

function function_efed8903(ai) {
  ai endon(#"death");

  while(true) {
    ai waittill(#"stopped_firing");
  }
}

function private isinphalanx(entity) {
  return entity ai::get_behavior_attribute("phalanx");
}

function private isinphalanxstance(entity) {
  phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
  currentstance = entity getblackboardattribute("_stance");

  switch (phalanxstance) {
    case # "stand":
      return (currentstance == "stand");
    case # "crouch":
      return (currentstance == "crouch");
  }

  return true;
}

function private togglephalanxstance(entity) {
  phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");

  switch (phalanxstance) {
    case # "stand":
      entity setblackboardattribute("_desired_stance", "stand");
      break;
    case # "crouch":
      entity setblackboardattribute("_desired_stance", "crouch");
      break;
  }
}

function isatattackobject(entity) {
  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(isDefined(entity.attackable) && is_true(entity.attackable.is_active)) {
    if(!isDefined(entity.attackable_slot)) {
      return false;
    }

    if(entity isatgoal()) {
      entity.is_at_attackable = 1;
      return true;
    }
  }

  return false;
}

function shouldattackobject(entity) {
  if(isDefined(entity.enemy_override)) {
    return false;
  }

  if(isDefined(entity.attackable) && is_true(entity.attackable.is_active)) {
    if(is_true(entity.is_at_attackable)) {
      return true;
    }
  }

  return false;
}

function meleeattributescallback(entity, attribute, oldvalue, value) {
  switch (oldvalue) {
    case # "can_melee":
      if(value) {
        attribute.canmelee = 1;
      } else {
        attribute.canmelee = 0;
      }

      break;
    case # "can_be_meleed":
      if(value) {
        attribute.canbemeleed = 1;
      } else {
        attribute.canbemeleed = 0;
      }

      break;
  }
}

function arrivalattributescallback(entity, attribute, oldvalue, value) {
  switch (oldvalue) {
    case # "disablearrivals":
      if(value) {
        attribute.ai.disablearrivals = 1;
      } else {
        attribute.ai.disablearrivals = 0;
      }

      break;
  }
}

function function_eef4346c(entity, attribute, oldvalue, value) {
  switch (oldvalue) {
    case # "disablepeek":
      if(value) {
        attribute.ai.disablepeek = 1;
      } else {
        attribute.ai.disablepeek = 0;
      }

      break;
  }
}

function function_1cd75f29(entity, attribute, oldvalue, value) {
  switch (oldvalue) {
    case # "disablelean":
      if(value) {
        attribute.ai.disablelean = 1;
      } else {
        attribute.ai.disablelean = 0;
      }

      break;
  }
}

function function_a626b1a9(entity, attribute, oldvalue, value) {
  switch (oldvalue) {
    case # "disablereload":
      if(value) {
        attribute.ai.disablereload = 1;
      } else {
        attribute.ai.disablereload = 0;
      }

      break;
  }
}

function phalanxattributecallback(entity, attribute, oldvalue, value) {
  if(value) {
    oldvalue.ai.phalanx = 1;
    return;
  }

  oldvalue.ai.phalanx = 0;
}

function private generictryreacquireservice(entity) {
  if(!isDefined(entity.reacquire_state)) {
    entity.reacquire_state = 0;
  }

  if(!isDefined(entity.enemy)) {
    entity.reacquire_state = 0;
    return false;
  }

  if(entity haspath()) {
    entity.reacquire_state = 0;
    return false;
  }

  if(is_true(entity.fixednode)) {
    entity.reacquire_state = 0;
    return false;
  }

  if(entity seerecently(entity.enemy, 4)) {
    entity.reacquire_state = 0;
    return false;
  }

  dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
  forward = anglesToForward(entity.angles);

  if(vectordot(dirtoenemy, forward) < 0.5) {
    entity.reacquire_state = 0;
    return false;
  }

  switch (entity.reacquire_state) {
    case 0:
    case 1:
    case 2:
      step_size = 32 + entity.reacquire_state * 32;
      reacquirepos = entity reacquirestep(step_size);
      break;
    case 4:
      if(!entity cansee(entity.enemy) || !entity canshootenemy()) {
        entity flagenemyunattackable();
      }

      break;
    default:
      if(entity.reacquire_state > 15) {
        entity.reacquire_state = 0;
        return false;
      }

      break;
  }

  if(isvec(reacquirepos)) {
    entity function_a57c34b7(reacquirepos);
    return true;
  }

  entity.reacquire_state++;
  return false;
}

function private function_bcbf3f38(entity) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  animation = self asmgetcurrentdeltaanimation();
  currenttime = self getanimtime(animation);
  notes = getnotetracktimes(animation, "melee_fire");

  if(!isDefined(notes)) {
    if(!isalive(self.enemy)) {
      return true;
    }

    return false;
  }

  meleetime = notes[0];

  if(meleetime > currenttime && meleetime - currenttime < 0.05) {
    weapon = self.weapon;

    if(isDefined(self.meleeweapon) && self.meleeweapon != getweapon(#"none")) {
      weapon = self.meleeweapon;
    }

    if(!isDefined(weapon)) {
      return false;
    }

    distancetotarget = distance(self.origin, self.enemy.origin);

    record3dtext("<dev string:x346>" + distancetotarget, self.origin + (0, 0, 64), (1, 0, 0), "<dev string:x33c>");

    if(distancetotarget <= weapon.aimeleerange) {
      return false;
    }

    settingsbundle = self ai::function_9139c839();

    if(!(isDefined(settingsbundle) && isDefined(settingsbundle.var_158394c8))) {
      return false;
    }

    if(distancetotarget > weapon.aimeleerange + settingsbundle.var_158394c8) {
      return true;
    }

    toenemy = vectornormalize(self.enemy.origin - self.origin);
    dot = vectordot(toenemy, self getweaponforwarddir());
    dot = math::clamp(dot, -1, 1);

    if(dot < 0 || acos(dot) > 80) {
      return true;
    }
  }

  return false;
}

function private function_de7e2d3f(entity) {
  entity setblackboardattribute("_charge_melee_anim", math::cointoss());
  entity setupchargemeleeattack(entity);
  return true;
}

function private function_9414b79f(entity) {
  entity cleanupchargemelee(entity);
  return true;
}

function private function_331e64bd(entity) {
  function_644b35fa(entity);
}

function function_493e5914(smeansofdeath) {
  var_62ea2e0c = ["MOD_PISTOL_BULLET", "MOD_RIFLE_BULLET", "MOD_GRENADE", "MOD_PROJECTILE", "MOD_MELEE", "MOD_MELEE_WEAPON_BUTT", "MOD_MELEE_ASSASSINATE", "MOD_HEAD_SHOT", "MOD_IMPACT"];

  if(isinarray(var_62ea2e0c, smeansofdeath)) {
    return true;
  }

  return false;
}

function function_254912d7(weapon_name, smeansofdeath) {
  if(!isDefined(level.var_feba6a94)) {
    level.var_feba6a94 = [];
  } else if(!isarray(level.var_feba6a94)) {
    level.var_feba6a94 = array(level.var_feba6a94);
  }

  level.var_feba6a94[weapon_name] = smeansofdeath;
}

function function_e2278a4b(weapon, smeansofdeath) {
  if(sessionmodeiszombiesgame() && killstreaks::is_killstreak_weapon(weapon)) {
    return 0;
  }

  if(isDefined(smeansofdeath) && level.var_feba6a94[weapon.name] === smeansofdeath) {
    return 1;
  }

  return function_69c2d36f(weapon, smeansofdeath);
}

function private function_69c2d36f(weapon, smeansofdeath) {
  if(sessionmodeiszombiesgame() && killstreaks::is_killstreak_weapon(weapon)) {
    return false;
  }

  if(isDefined(weapon) && weapon.var_349c3324 <= 1) {
    return false;
  }

  var_4e9743c0 = ["MOD_GRENADE", "MOD_PROJECTILE_SPLASH", "MOD_MELEE", "MOD_MELEE_WEAPON_BUTT", "MOD_MELEE_ASSASSINATE"];

  if(isinarray(var_4e9743c0, smeansofdeath)) {
    return false;
  }

  return true;
}

function function_cb552839(entity) {
  tag_loc = entity.origin;

  if(isDefined(entity.var_28621cf4)) {
    tag_loc = entity gettagorigin(entity.var_28621cf4);
  }

  offset = (0, 0, 60);

  if(isDefined(entity.var_e5365d8a)) {
    offset = entity.var_e5365d8a;
  }

  return tag_loc + offset;
}